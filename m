Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74C2B53CD73
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Jun 2022 18:46:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344074AbiFCQqZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 3 Jun 2022 12:46:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244871AbiFCQqY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 3 Jun 2022 12:46:24 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B551517F7
        for <linux-wireless@vger.kernel.org>; Fri,  3 Jun 2022 09:46:22 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id w27so10885628edl.7
        for <linux-wireless@vger.kernel.org>; Fri, 03 Jun 2022 09:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Woceb0Rke0kHZAKQOxFNrONpwZyqKA30q2Uef9j1sWg=;
        b=O+nr7Y4GlgXVxyiPhIS/JwPUvloVGcydyPndUaBGvyEf2pxef/YWw5Qqe6eac/4XzD
         voUH4cvEFs8nGlotS6fFiDzMX+owWrmB6mgMEf8rr/JF6tEI3ZSO2Uuj5U8456CcjlQf
         TYB0HwcKWQtGKWIa9ZOj28tDeWjuKEyFgs1jcaiIM9ZGaXLsQ/uXiVEq/0xl725fnCFj
         XRb7p/OD3ZgjurbGyrbq7DvqmJWo08nfqupNBp8WGebWXEi8sg9fvBsDLxVpOOu2M4cS
         QuFbo6lm+xP35t2tq4H6MEQUqLwYIn3x1YRRyw90Is6nTn4Z/Xx6O7bwNEtDnhqMl2Vs
         lQDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Woceb0Rke0kHZAKQOxFNrONpwZyqKA30q2Uef9j1sWg=;
        b=NBKf3VB8uRQIiI/T/4Hk3VX7EtagxBI2SspjCiQ802whCCiWd0bSKC8jdb8dYw/Wkj
         kATAOOM5eGfgNDAdOAyqVifJYCUiNIOQQZ2vOxELDijlIgcFUOuqNovxHO6Sr7lMk45I
         Dgaf0Pil1rz+zjWSQ1u86rvCcqSnbaIM9jGntbtrPdgl20j8uvuviFiz8LtUlPkZ9NbF
         f0G1B7tDNpam620FCWyzUN3Bn4LjN1ljTXXltwL3Y0MC70pAmdDKE0ePca9p3IynDajp
         m6VxmzpRiAgpxYxuwLuy6l/YrwoU5Lx4lo3J2sXwgB3EX2zsidTFWHZ0QmhUBzlUAGOr
         Vxjw==
X-Gm-Message-State: AOAM531rVg/yOuT7Qeebj85paatNB4Ra/sFrhcEOXnkPg7W1gcoB077r
        JU5kxggE7Nam1E7i1ca7bDI=
X-Google-Smtp-Source: ABdhPJwox2o3lpWBvFvHM5Z3hm3Ssg58lh8U+R8DMB58iiRmtt5SYLeE+KthNUIacPOMey6H2eiBrA==
X-Received: by 2002:a05:6402:20c:b0:42b:d302:a80f with SMTP id t12-20020a056402020c00b0042bd302a80fmr11687092edv.330.1654274780902;
        Fri, 03 Jun 2022 09:46:20 -0700 (PDT)
Received: from localhost.localdomain (93-42-70-190.ip85.fastwebnet.it. [93.42.70.190])
        by smtp.googlemail.com with ESMTPSA id f22-20020a1709067f9600b006f3ef214db6sm3010819ejr.28.2022.06.03.09.46.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jun 2022 09:46:20 -0700 (PDT)
From:   Christian 'Ansuel' Marangi <ansuelsmth@gmail.com>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org,
        Christian 'Ansuel' Marangi <ansuelsmth@gmail.com>
Subject: [RFC PATCH] ath11k: fix peer addition/deletion error on sta band migration
Date:   Fri,  3 Jun 2022 18:45:59 +0200
Message-Id: <20220603164559.27769-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This patch try to fix the following error.

Wed Jun  1 22:19:30 2022 kern.warn kernel: [  119.561227] ath11k c000000.wifi: peer already added vdev id 0 req, vdev id 1 present
Wed Jun  1 22:19:30 2022 kern.warn kernel: [  119.561282] ath11k c000000.wifi: Failed to add peer: 28:c2:1f:xx:xx:xx for VDEV: 0
Wed Jun  1 22:19:30 2022 kern.warn kernel: [  119.568053] ath11k c000000.wifi: Failed to add station: 28:c2:1f:xx:xx:xx for VDEV: 0
Wed Jun  1 22:19:31 2022 daemon.notice hostapd: wlan2: STA 28:c2:1f:xx:xx:xx IEEE 802.11: Could not add STA to kernel driver
Wed Jun  1 22:19:31 2022 daemon.notice hostapd: wlan2: STA 28:c2:1f:xx:xx:xx IEEE 802.11: did not acknowledge authentication response
Wed Jun  1 22:19:31 2022 daemon.notice hostapd: wlan1: AP-STA-DISCONNECTED 28:c2:1f:xx:xx:xx
Wed Jun  1 22:19:31 2022 daemon.info hostapd: wlan1: STA 28:c2:1f:xx:xx:xx IEEE 802.11: disassociated due to inactivity
Wed Jun  1 22:19:32 2022 daemon.info hostapd: wlan1: STA 28:c2:1f:xx:xx:xx IEEE 802.11: deauthenticated due to inactivity (timer DEAUTH/REMOVE)

To repro this:
- Have 2 Wifi with the same bssid and pass on different band (2.4 and
5GHz)
- Enable 802.11r Fast Transaction with same mobility domain
- FT Protocol: FT over the Air
From a openwrt system issue the command (with the correct mac)
ubus call hostapd.wlan1 wnm_disassoc_imminent '{"addr":"28:C2:1F:xx:xx:xx"}'
Notice the log printing the errors.

The cause of this error has been investigated and we found that this is
related to the WiFi Fast Transaction feature. We observed that this is
triggered when the router tells the device to change band. In this case
the device first auth to the other band and then the disconnect path
from the prev band is triggered.
This is problematic with the current rhash implementation since the
addrs is used as key and the logic of "adding first, delete later"
conflicts with the rhash logic.
In fact peer addition will fail since the peer is already added and with
that fixed a peer deletion will cause unitended effect by removing the
peer just added.

Current solution to this is to add additional logic to the peer delete,
make sure we are deleting the correct peer taken from the rhash
table (and fallback to the peer list) and for the peer add logic delete
the peer entry for the rhash list before adding the new one (counting as
an error only when a peer with the same vlan_id is asked to be added).

With this change, a sta can correctly transition from 2.4GHz and 5GHZ
with no drop and no error are printed.

Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.5.0.1-01208-QCAHKSWPL_SILICONZ-1

Fixes: 7b0c70d92a43 ("ath11k: Add peer rhash table support")
Signed-off-by: Christian 'Ansuel' Marangi <ansuelsmth@gmail.com>
---

Some additional comments external to this patch.
I tried to find different way to fix this...
One of them would be mod the logic of the rhash and using as a key both
the vlan_id and the addr but this is problematic for the function
where ath11k_peer_find_by_addr is used as vlan_id is not always available.

I honestly think a correct solution would be have a rhash list per vdev_id
or per mac_id but again this is problematic for some function that just handles
data and have only the addr as a way to identify the peer.

So unless some change are done to the firmware to provide the vlan_id in the
msdu data this to me seems to be the only solution to correctly handle this case.

Another solution I tried was to add to the peer some additional info and put
the rhash addition in the peer delete logic by passing the "to-be-added peer" to
the peer to delete but I notice that it's unreliable since it can happent that
the new peer hasn't been mapped at the time the peer delete is called.

So this is really how to handle the rhash table in this corner case.
Considering how peer are handled in theory it should never happen to have
dangling peer that are not deleted.

Hoping this is not too much of an hack and we find a good solution for this
problem.

 drivers/net/wireless/ath/ath11k/peer.c | 30 ++++++++++++++++++++++----
 1 file changed, 26 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/peer.c b/drivers/net/wireless/ath/ath11k/peer.c
index 9e22aaf34b88..1ae7af02c364 100644
--- a/drivers/net/wireless/ath/ath11k/peer.c
+++ b/drivers/net/wireless/ath/ath11k/peer.c
@@ -302,6 +302,21 @@ static int __ath11k_peer_delete(struct ath11k *ar, u32 vdev_id, const u8 *addr)
 	spin_lock_bh(&ab->base_lock);
 
 	peer = ath11k_peer_find_by_addr(ab, addr);
+	/* Check if the found peer is what we want to remove.
+	 * While the sta is transitioning to another band we may
+	 * have 2 peer with the same addr assigned to different
+	 * vdev_id. Make sure we are deleting the correct peer.
+	 */
+	if (peer && peer->vdev_id == vdev_id)
+		ath11k_peer_rhash_delete(ab, peer);
+
+	/* Fallback to peer list search if the correct peer can't be found.
+	 * Skip the deletion of the peer from the rhash since it has already
+	 * been deleted in peer add.
+	 */
+	if (!peer)
+		peer = ath11k_peer_find(ab, vdev_id, addr);
+
 	if (!peer) {
 		spin_unlock_bh(&ab->base_lock);
 		mutex_unlock(&ab->tbl_mtx_lock);
@@ -312,8 +327,6 @@ static int __ath11k_peer_delete(struct ath11k *ar, u32 vdev_id, const u8 *addr)
 		return -EINVAL;
 	}
 
-	ath11k_peer_rhash_delete(ab, peer);
-
 	spin_unlock_bh(&ab->base_lock);
 	mutex_unlock(&ab->tbl_mtx_lock);
 
@@ -372,8 +385,17 @@ int ath11k_peer_create(struct ath11k *ar, struct ath11k_vif *arvif,
 	spin_lock_bh(&ar->ab->base_lock);
 	peer = ath11k_peer_find_by_addr(ar->ab, param->peer_addr);
 	if (peer) {
-		spin_unlock_bh(&ar->ab->base_lock);
-		return -EINVAL;
+		if (peer->vdev_id == param->vdev_id) {
+			spin_unlock_bh(&ar->ab->base_lock);
+			return -EINVAL;
+		}
+
+		/* Assume sta is transitioning to another band.
+		 * Remove here the peer from rhash.
+		 */
+		mutex_lock(&ar->ab->tbl_mtx_lock);
+		ath11k_peer_rhash_delete(ar->ab, peer);
+		mutex_unlock(&ar->ab->tbl_mtx_lock);
 	}
 	spin_unlock_bh(&ar->ab->base_lock);
 
-- 
2.36.1

