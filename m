Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C8644117AB
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Sep 2021 16:55:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240960AbhITO47 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 20 Sep 2021 10:56:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58698 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232984AbhITO46 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 20 Sep 2021 10:56:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632149731;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zrePRa7PpPNmLbUM0XUJPSYupcExt61dOeDPClw6IJ8=;
        b=O+qPzIOqnfq383zlOlOQW3sVIx7dyhD3uZKDYJdFVmlslSbtwRcnZxWh6RDktUDFh+y/lv
        +6nOqJkjHU/afPXTXEvn1zqfPYs89mrbeLtkUOLZe60bP6NFbulUdZpyYLtfJrYoKYyTMl
        d/uXHKN4Mw8blgBT5HZuB8MBqIp8AE8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-375-dYK3Y6xHNw-5N3F25gw98g-1; Mon, 20 Sep 2021 10:55:30 -0400
X-MC-Unique: dYK3Y6xHNw-5N3F25gw98g-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 24292101F000;
        Mon, 20 Sep 2021 14:55:29 +0000 (UTC)
Received: from x1.localdomain.com (unknown [10.39.194.118])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 58A451F451;
        Mon, 20 Sep 2021 14:55:27 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Fabio Aiuto <fabioaiuto83@gmail.com>,
        linux-wireless@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [PATCH 2/3] staging: rtl8723bs: remove a second possible deadlock
Date:   Mon, 20 Sep 2021 16:55:01 +0200
Message-Id: <20210920145502.155454-2-hdegoede@redhat.com>
In-Reply-To: <20210920145502.155454-1-hdegoede@redhat.com>
References: <20210920145502.155454-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Lockdep complains about rtw_free_assoc_resources() taking the sta_hash_lock
followed by it calling rtw_free_stainfo() which takes xmitpriv->lock.
While the rtl8723bs_xmit_thread takes the sta_hash_lock while already
holding the xmitpriv->lock:

[  103.849756] ======================================================
[  103.849761] WARNING: possible circular locking dependency detected
[  103.849767] 5.15.0-rc1+ #470 Tainted: G         C  E
[  103.849773] ------------------------------------------------------
[  103.849776] wpa_supplicant/695 is trying to acquire lock:
[  103.849781] ffffa5d0c0562b00 (&pxmitpriv->lock){+.-.}-{2:2}, at: rtw_free_stainfo+0x8a/0x510 [r8723bs]
[  103.849840]
               but task is already holding lock:
[  103.849843] ffffa5d0c05636a8 (&pstapriv->sta_hash_lock){+.-.}-{2:2}, at: rtw_free_assoc_resources+0x48/0x110 [r8723bs]
[  103.849881]
               which lock already depends on the new lock.

[  103.849884]
               the existing dependency chain (in reverse order) is:
[  103.849887]
               -> #1 (&pstapriv->sta_hash_lock){+.-.}-{2:2}:
[  103.849898]        _raw_spin_lock_bh+0x34/0x40
[  103.849913]        rtw_get_stainfo+0x93/0x110 [r8723bs]
[  103.849948]        rtw_make_wlanhdr+0x14a/0x270 [r8723bs]
[  103.849983]        rtw_xmitframe_coalesce+0x5c/0x6c0 [r8723bs]
[  103.850019]        rtl8723bs_xmit_thread+0x4ac/0x620 [r8723bs]
[  103.850050]        kthread+0x143/0x160
[  103.850058]        ret_from_fork+0x22/0x30
[  103.850067]
               -> #0 (&pxmitpriv->lock){+.-.}-{2:2}:
[  103.850077]        __lock_acquire+0x1158/0x1de0
[  103.850084]        lock_acquire+0xb5/0x2b0
[  103.850090]        _raw_spin_lock_bh+0x34/0x40
[  103.850095]        rtw_free_stainfo+0x8a/0x510 [r8723bs]
[  103.850130]        rtw_free_assoc_resources+0x53/0x110 [r8723bs]
[  103.850159]        PHY_IQCalibrate_8723B+0x122b/0x36a0 [r8723bs]
[  103.850189]        cfg80211_disconnect+0x173/0x320 [cfg80211]
[  103.850331]        nl80211_disconnect+0x6e/0xb0 [cfg80211]
[  103.850422]        genl_family_rcv_msg_doit+0xcd/0x110
[  103.850430]        genl_rcv_msg+0xce/0x1c0
[  103.850435]        netlink_rcv_skb+0x50/0xf0
[  103.850441]        genl_rcv+0x24/0x40
[  103.850446]        netlink_unicast+0x16d/0x230
[  103.850452]        netlink_sendmsg+0x22b/0x450
[  103.850457]        sock_sendmsg+0x5e/0x60
[  103.850465]        ____sys_sendmsg+0x22f/0x270
[  103.850472]        ___sys_sendmsg+0x81/0xc0
[  103.850479]        __sys_sendmsg+0x49/0x80
[  103.850485]        do_syscall_64+0x3b/0x90
[  103.850493]        entry_SYSCALL_64_after_hwframe+0x44/0xae
[  103.850500]
               other info that might help us debug this:

[  103.850504]  Possible unsafe locking scenario:

[  103.850507]        CPU0                    CPU1
[  103.850510]        ----                    ----
[  103.850512]   lock(&pstapriv->sta_hash_lock);
[  103.850518]                                lock(&pxmitpriv->lock);
[  103.850524]                                lock(&pstapriv->sta_hash_lock);
[  103.850530]   lock(&pxmitpriv->lock);
[  103.850535]
                *** DEADLOCK ***

Push the taking of sta_hash_lock down into rtw_free_stainfo(),
where the critical section is, this allows taking the lock after
rtw_free_stainfo() has released pxmitpriv->lock.

This requires changing rtw_free_all_stainfo() so that it does its freeing
in 2 steps, first moving all stainfo-s to free to a local list while
holding the sta_hash_lock and then walking that list to call
rtw_free_stainfo() on them without holding the sta_hash_lock.

Pushing the taking of sta_hash_lock down into rtw_free_stainfo(),
also fixes a whole bunch of callers of rtw_free_stainfo() which
were not holding that lock even though they should.

Note that this also fixes the deadlock from the "remove possible
deadlock when disconnect" patch in a different way. But the
changes from that patch offer a nice locking cleanup regardless.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/staging/rtl8723bs/core/rtw_mlme.c      |  5 -----
 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c  |  4 ----
 drivers/staging/rtl8723bs/core/rtw_sta_mgt.c   | 11 +++++++++--
 drivers/staging/rtl8723bs/os_dep/ioctl_linux.c |  2 --
 4 files changed, 9 insertions(+), 13 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme.c b/drivers/staging/rtl8723bs/core/rtw_mlme.c
index d4650ef3dbe8..59e0b5345078 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme.c
@@ -899,7 +899,6 @@ void rtw_free_assoc_resources(struct adapter *adapter, int lock_scanned_queue)
 {
 	struct	mlme_priv *pmlmepriv = &adapter->mlmepriv;
 	struct wlan_network *tgt_network = &pmlmepriv->cur_network;
-	struct	sta_priv *pstapriv = &adapter->stapriv;
 	struct dvobj_priv *psdpriv = adapter->dvobj;
 	struct debug_priv *pdbgpriv = &psdpriv->drv_dbg;
 
@@ -907,11 +906,7 @@ void rtw_free_assoc_resources(struct adapter *adapter, int lock_scanned_queue)
 		struct sta_info *psta;
 
 		psta = rtw_get_stainfo(&adapter->stapriv, tgt_network->network.mac_address);
-		spin_lock_bh(&(pstapriv->sta_hash_lock));
 		rtw_free_stainfo(adapter,  psta);
-
-		spin_unlock_bh(&(pstapriv->sta_hash_lock));
-
 	}
 
 	if (check_fwstate(pmlmepriv, WIFI_ADHOC_STATE|WIFI_ADHOC_MASTER_STATE|WIFI_AP_STATE)) {
diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
index a1ae16ec69eb..ad9c237054c4 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
@@ -1489,9 +1489,7 @@ unsigned int OnDeAuth(struct adapter *padapter, union recv_frame *precv_frame)
 		struct sta_info *psta;
 		struct sta_priv *pstapriv = &padapter->stapriv;
 
-		/* spin_lock_bh(&(pstapriv->sta_hash_lock)); */
 		/* rtw_free_stainfo(padapter, psta); */
-		/* spin_unlock_bh(&(pstapriv->sta_hash_lock)); */
 
 		netdev_dbg(padapter->pnetdev,
 			   "ap recv deauth reason code(%d) sta:%pM\n", reason,
@@ -1565,9 +1563,7 @@ unsigned int OnDisassoc(struct adapter *padapter, union recv_frame *precv_frame)
 		struct sta_info *psta;
 		struct sta_priv *pstapriv = &padapter->stapriv;
 
-		/* spin_lock_bh(&(pstapriv->sta_hash_lock)); */
 		/* rtw_free_stainfo(padapter, psta); */
-		/* spin_unlock_bh(&(pstapriv->sta_hash_lock)); */
 
 		netdev_dbg(padapter->pnetdev,
 			   "ap recv disassoc reason code(%d) sta:%pM\n",
diff --git a/drivers/staging/rtl8723bs/core/rtw_sta_mgt.c b/drivers/staging/rtl8723bs/core/rtw_sta_mgt.c
index b965f3353b04..0c9ea1520fd0 100644
--- a/drivers/staging/rtl8723bs/core/rtw_sta_mgt.c
+++ b/drivers/staging/rtl8723bs/core/rtw_sta_mgt.c
@@ -268,7 +268,6 @@ struct	sta_info *rtw_alloc_stainfo(struct	sta_priv *pstapriv, u8 *hwaddr)
 	return psta;
 }
 
-/*  using pstapriv->sta_hash_lock to protect */
 u32 rtw_free_stainfo(struct adapter *padapter, struct sta_info *psta)
 {
 	int i;
@@ -339,8 +338,10 @@ u32 rtw_free_stainfo(struct adapter *padapter, struct sta_info *psta)
 
 	spin_unlock_bh(&pxmitpriv->lock);
 
+	spin_lock_bh(&pstapriv->sta_hash_lock);
 	list_del_init(&psta->hash_list);
 	pstapriv->asoc_sta_count--;
+	spin_unlock_bh(&pstapriv->sta_hash_lock);
 
 	/*  re-init sta_info; 20061114 will be init in alloc_stainfo */
 	/* _rtw_init_sta_xmit_priv(&psta->sta_xmitpriv); */
@@ -435,6 +436,7 @@ void rtw_free_all_stainfo(struct adapter *padapter)
 	struct sta_info *psta = NULL;
 	struct	sta_priv *pstapriv = &padapter->stapriv;
 	struct sta_info *pbcmc_stainfo = rtw_get_bcmc_stainfo(padapter);
+	LIST_HEAD(stainfo_free_list);
 
 	if (pstapriv->asoc_sta_count == 1)
 		return;
@@ -447,11 +449,16 @@ void rtw_free_all_stainfo(struct adapter *padapter)
 			psta = list_entry(plist, struct sta_info, hash_list);
 
 			if (pbcmc_stainfo != psta)
-				rtw_free_stainfo(padapter, psta);
+				list_move(&psta->hash_list, &stainfo_free_list);
 		}
 	}
 
 	spin_unlock_bh(&pstapriv->sta_hash_lock);
+
+	list_for_each_safe(plist, tmp, &stainfo_free_list) {
+		psta = list_entry(plist, struct sta_info, hash_list);
+		rtw_free_stainfo(padapter, psta);
+	}
 }
 
 /* any station allocated can be searched by hash list */
diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
index 9d4a233a861e..295121c268bd 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
@@ -835,9 +835,7 @@ static int rtw_add_sta(struct net_device *dev, struct ieee_param *param)
 	psta = rtw_get_stainfo(pstapriv, param->sta_addr);
 	if (psta)
 	{
-		spin_lock_bh(&(pstapriv->sta_hash_lock));
 		rtw_free_stainfo(padapter,  psta);
-		spin_unlock_bh(&(pstapriv->sta_hash_lock));
 
 		psta = NULL;
 	}
-- 
2.31.1

