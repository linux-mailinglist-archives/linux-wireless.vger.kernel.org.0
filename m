Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 688AA1FC88E
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Jun 2020 10:27:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726625AbgFQI1G (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 17 Jun 2020 04:27:06 -0400
Received: from smail.rz.tu-ilmenau.de ([141.24.186.67]:49908 "EHLO
        smail.rz.tu-ilmenau.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725967AbgFQI1F (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 17 Jun 2020 04:27:05 -0400
Received: from legolas.fritz.box (unknown [87.147.49.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smail.rz.tu-ilmenau.de (Postfix) with ESMTPSA id 449E5580075;
        Wed, 17 Jun 2020 10:27:03 +0200 (CEST)
From:   Markus Theil <markus.theil@tu-ilmenau.de>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Markus Theil <markus.theil@tu-ilmenau.de>,
        kernel test robot <rong.a.chen@intel.com>
Subject: [PATCH v3 2/2] mac80211: allow rx of mesh eapol frames with default rx key
Date:   Wed, 17 Jun 2020 10:26:37 +0200
Message-Id: <20200617082637.22670-3-markus.theil@tu-ilmenau.de>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200617082637.22670-1-markus.theil@tu-ilmenau.de>
References: <20200617082637.22670-1-markus.theil@tu-ilmenau.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Without this patch, eapol frames cannot be received in mesh
mode, when 802.1X should be used. Initially only a MGTK is
defined, which is found and set as rx->key, when there are
no other keys set. ieee80211_drop_unencrypted would then
drop these eapol frames, as they are data frames without
encryption and there exists some rx->key.

Fix this by differentiating between mesh eapol frames and
other data frames with existing rx->key. Allow mesh mesh
eapol frames only if they are for our vif address. If a
check for eapol frames fails, the previous drop check is
executed (thanks to a kernel test bot, which found an issue
in a previous patch version here).

With this patch in-place, ieee80211_rx_h_mesh_fwding continues
after the ieee80211_drop_unencrypted check and notices, that
these eapol frames have to be delivered locally, as they should.

Reported-by: kernel test robot <rong.a.chen@intel.com>
Signed-off-by: Markus Theil <markus.theil@tu-ilmenau.de>
---
 net/mac80211/rx.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index 21854a61a2b7..60293a9fa3dc 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -2396,6 +2396,7 @@ static int ieee80211_802_1x_port_control(struct ieee80211_rx_data *rx)
 
 static int ieee80211_drop_unencrypted(struct ieee80211_rx_data *rx, __le16 fc)
 {
+	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)rx->skb->data;
 	struct sk_buff *skb = rx->skb;
 	struct ieee80211_rx_status *status = IEEE80211_SKB_RXCB(skb);
 
@@ -2406,12 +2407,37 @@ static int ieee80211_drop_unencrypted(struct ieee80211_rx_data *rx, __le16 fc)
 	if (status->flag & RX_FLAG_DECRYPTED)
 		return 0;
 
+	/* check mesh EAPOL frames first */
+	if (unlikely(rx->sta && ieee80211_vif_is_mesh(&rx->sdata->vif) && ieee80211_is_data(fc))) {
+		struct ieee80211s_hdr *mesh_hdr;
+		u16 hdr_len = ieee80211_hdrlen(fc);
+		u16 ethertype_offset;
+		__be16 ethertype;
+
+		/* make sure fixed part of mesh header is there, also checks skb len */
+		if (!pskb_may_pull(rx->skb, hdr_len + 6))
+			goto drop_check;
+
+		mesh_hdr = (struct ieee80211s_hdr *)(skb->data + hdr_len);
+		ethertype_offset = hdr_len + ieee80211_get_mesh_hdrlen(mesh_hdr)
+				 + sizeof(rfc1042_header);
+		if (!pskb_may_pull(rx->skb, ethertype_offset + sizeof(ethertype)) ||
+		    !ether_addr_equal(hdr->addr1, rx->sdata->vif.addr))
+			goto drop_check;
+
+		skb_copy_bits(rx->skb, ethertype_offset, &ethertype, 2);
+		if (ethertype == rx->sdata->control_port_protocol)
+			goto pass_frame;
+	}
+
+drop_check:
 	/* Drop unencrypted frames if key is set. */
 	if (unlikely(!ieee80211_has_protected(fc) &&
 		     !ieee80211_is_any_nullfunc(fc) &&
 		     ieee80211_is_data(fc) && rx->key))
 		return -EACCES;
 
+pass_frame:
 	return 0;
 }
 
-- 
2.27.0

