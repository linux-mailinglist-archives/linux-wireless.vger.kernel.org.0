Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A55921F4AB
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2020 16:41:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729495AbgGNOlL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 14 Jul 2020 10:41:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:56316 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729369AbgGNOk1 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 14 Jul 2020 10:40:27 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3314222205;
        Tue, 14 Jul 2020 14:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594737627;
        bh=307H0mAGqFThKH7YKYzyGbkMGO1zCL4yynGdqbyR1Cc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ybJtPEkU1hIJztk/3fPQHNY+4Jkiqf75qrL4Vn+wfqVa4seUMQlpDc9TkudmyoSuJ
         XSS0cf5oqr2in9/cvkHvXf+fD6XGESt1WBjqLFXgmBDM+zCAjMDuNAnJZ+18Ad7gpa
         zgaWaze+OsQYQ5ieNGK3CE7CB29uwgwkGs3T+QA8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Markus Theil <markus.theil@tu-ilmenau.de>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <sashal@kernel.org>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.4 2/9] mac80211: allow rx of mesh eapol frames with default rx key
Date:   Tue, 14 Jul 2020 10:40:16 -0400
Message-Id: <20200714144024.4036118-2-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200714144024.4036118-1-sashal@kernel.org>
References: <20200714144024.4036118-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Markus Theil <markus.theil@tu-ilmenau.de>

[ Upstream commit 0b467b63870d9c05c81456aa9bfee894ab2db3b6 ]

Without this patch, eapol frames cannot be received in mesh
mode, when 802.1X should be used. Initially only a MGTK is
defined, which is found and set as rx->key, when there are
no other keys set. ieee80211_drop_unencrypted would then
drop these eapol frames, as they are data frames without
encryption and there exists some rx->key.

Fix this by differentiating between mesh eapol frames and
other data frames with existing rx->key. Allow mesh mesh
eapol frames only if they are for our vif address.

With this patch in-place, ieee80211_rx_h_mesh_fwding continues
after the ieee80211_drop_unencrypted check and notices, that
these eapol frames have to be delivered locally, as they should.

Signed-off-by: Markus Theil <markus.theil@tu-ilmenau.de>
Link: https://lore.kernel.org/r/20200625104214.50319-1-markus.theil@tu-ilmenau.de
[small code cleanups]
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mac80211/rx.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index a74a6ff18f919..886dce84e70c0 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -1963,6 +1963,7 @@ static int ieee80211_802_1x_port_control(struct ieee80211_rx_data *rx)
 
 static int ieee80211_drop_unencrypted(struct ieee80211_rx_data *rx, __le16 fc)
 {
+	struct ieee80211_hdr *hdr = (void *)rx->skb->data;
 	struct sk_buff *skb = rx->skb;
 	struct ieee80211_rx_status *status = IEEE80211_SKB_RXCB(skb);
 
@@ -1973,6 +1974,31 @@ static int ieee80211_drop_unencrypted(struct ieee80211_rx_data *rx, __le16 fc)
 	if (status->flag & RX_FLAG_DECRYPTED)
 		return 0;
 
+	/* check mesh EAPOL frames first */
+	if (unlikely(rx->sta && ieee80211_vif_is_mesh(&rx->sdata->vif) &&
+		     ieee80211_is_data(fc))) {
+		struct ieee80211s_hdr *mesh_hdr;
+		u16 hdr_len = ieee80211_hdrlen(fc);
+		u16 ethertype_offset;
+		__be16 ethertype;
+
+		if (!ether_addr_equal(hdr->addr1, rx->sdata->vif.addr))
+			goto drop_check;
+
+		/* make sure fixed part of mesh header is there, also checks skb len */
+		if (!pskb_may_pull(rx->skb, hdr_len + 6))
+			goto drop_check;
+
+		mesh_hdr = (struct ieee80211s_hdr *)(skb->data + hdr_len);
+		ethertype_offset = hdr_len + ieee80211_get_mesh_hdrlen(mesh_hdr) +
+				   sizeof(rfc1042_header);
+
+		if (skb_copy_bits(rx->skb, ethertype_offset, &ethertype, 2) == 0 &&
+		    ethertype == rx->sdata->control_port_protocol)
+			return 0;
+	}
+
+drop_check:
 	/* Drop unencrypted frames if key is set. */
 	if (unlikely(!ieee80211_has_protected(fc) &&
 		     !ieee80211_is_any_nullfunc(fc) &&
-- 
2.25.1

