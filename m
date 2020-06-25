Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3974209CFE
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Jun 2020 12:42:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404042AbgFYKmT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 25 Jun 2020 06:42:19 -0400
Received: from smail.rz.tu-ilmenau.de ([141.24.186.67]:50843 "EHLO
        smail.rz.tu-ilmenau.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404000AbgFYKmT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 25 Jun 2020 06:42:19 -0400
Received: from legolas.prakinf.tu-ilmenau.de (unknown [141.24.207.116])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smail.rz.tu-ilmenau.de (Postfix) with ESMTPSA id 157AE58005E;
        Thu, 25 Jun 2020 12:42:18 +0200 (CEST)
From:   Markus Theil <markus.theil@tu-ilmenau.de>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Markus Theil <markus.theil@tu-ilmenau.de>
Subject: [PATCH v4] mac80211: allow rx of mesh eapol frames with default rx key
Date:   Thu, 25 Jun 2020 12:42:14 +0200
Message-Id: <20200625104214.50319-1-markus.theil@tu-ilmenau.de>
X-Mailer: git-send-email 2.27.0
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
eapol frames only if they are for our vif address.

With this patch in-place, ieee80211_rx_h_mesh_fwding continues
after the ieee80211_drop_unencrypted check and notices, that
these eapol frames have to be delivered locally, as they should.

Signed-off-by: Markus Theil <markus.theil@tu-ilmenau.de>
---
v4: reorganize checks for better performance (suggestions from Johannes Berg)
v3: continue with previous drop check, if eapol check fails
v2: fixes for rx path with packet sockets
 net/mac80211/rx.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index a88ab6fb16f2..1f7177de8ca8 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -2396,6 +2396,7 @@ static int ieee80211_802_1x_port_control(struct ieee80211_rx_data *rx)

 static int ieee80211_drop_unencrypted(struct ieee80211_rx_data *rx, __le16 fc)
 {
+	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)rx->skb->data;
 	struct sk_buff *skb = rx->skb;
 	struct ieee80211_rx_status *status = IEEE80211_SKB_RXCB(skb);

@@ -2406,6 +2407,32 @@ static int ieee80211_drop_unencrypted(struct ieee80211_rx_data *rx, __le16 fc)
 	if (status->flag & RX_FLAG_DECRYPTED)
 		return 0;

+	/* check mesh EAPOL frames first */
+	if (unlikely(rx->sta && ieee80211_vif_is_mesh(&rx->sdata->vif) && ieee80211_is_data(fc))) {
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
+		ethertype_offset = hdr_len + ieee80211_get_mesh_hdrlen(mesh_hdr)
+				 + sizeof(rfc1042_header);
+
+		if (skb_copy_bits(rx->skb, ethertype_offset, &ethertype, 2) == 0 &&
+		    ethertype == rx->sdata->control_port_protocol)
+			return 0;
+		else
+			goto drop_check;
+	}
+
+drop_check:
 	/* Drop unencrypted frames if key is set. */
 	if (unlikely(!ieee80211_has_protected(fc) &&
 		     !ieee80211_is_any_nullfunc(fc) &&
--
2.27.0

