Return-Path: <linux-wireless+bounces-33543-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GKTABS6jvGkI1wIAu9opvQ
	(envelope-from <linux-wireless+bounces-33543-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Mar 2026 02:30:22 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CE3C2D4C66
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Mar 2026 02:30:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F18D63221778
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Mar 2026 01:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACDAE2E093A;
	Fri, 20 Mar 2026 01:25:16 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C27A32E7BD6
	for <linux-wireless@vger.kernel.org>; Fri, 20 Mar 2026 01:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773969916; cv=none; b=F8XvIVaoOj1p9yEQ4G2nGTmBj1B5u3UC2wCF6gLeUC14O2hpRUlJH36ydprF0UDlImunplPCsIVFYdLuzpQovzlO+z0p1GmAirmrXY2tOh8uGuNUCfgyyfm4rOHYCVivI8PLRekoxOvCMoZrPRvM8woQiEGfATCN4p8YX89Hqlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773969916; c=relaxed/simple;
	bh=YM3u0it3wWyko/sNve4E8SApgNH7HFUTOMIScZJQq9U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qKZu9fZ9my+esnQZnSOfS40z27+NIgEbzd3blB1AQ+1u2RRcujV+To8mXp4YeguSWxJ3ONUiqRXfJf5GrGZashHy6F3Udpigvp8m1mC9PYF67tXFoKcn496cEUexa3ujVwlGurPhG29ecACZDTdalIm58NjngmtM8UrcxbmXr9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-2c0c955a481so802023eec.1
        for <linux-wireless@vger.kernel.org>; Thu, 19 Mar 2026 18:25:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773969912; x=1774574712;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pcE3963mtoxNpsjtfnMGkLcMdWR/4YpWXWFsCalwpQc=;
        b=mjpdQBpUXtW5rFtchrZ0rXGeLtXKFkzFRKbryE7wASlSXG+jK1oYn7oe3tkhy6Ixmc
         IwCvezBdWkUXZ7rXmi8eSqFiYk5UzIRtTcjEhyL0+ut8my/1nADBuI5j80vVAUWXGMzO
         /fGGJDvuJS2cDXTZAInIpdPJo7HXLhXQTOQPxdP7ISRPSWy6WNSVutvwLW7uo5uCBuPM
         FNEB3AtsqiRo4aiSLdsYG8DWFP7VBBC+Mk/l1g1BWRyXBoRhweByZ6MFdSqT/Tr+tGb6
         1MTD9NbQZwZBscEQ85iYjSifUip0iPVkvrQxR8P9Q+C2eSH4J0Vuz1FKqGq1EyBuOMmm
         BG1g==
X-Forwarded-Encrypted: i=1; AJvYcCVqfns8x5mYLqWoVtRcNnQipIOuP2jjdWQBX42cTL5Bs4DuOl9vtnvbJSRU49Zlf1W02gHLOQUzrY0G42Kx+g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yynoj+lrmZ69xWzs4FuAOBsdFESF2HawUBN9IHC5tttLNhWIPwm
	DU2PtCv6hUulg8AsqVWxTTp0wLlANCzEFz7QTpwcZ3ndXvzKIPHQEMk=
X-Gm-Gg: ATEYQzw4hglDuopynECjoIvvcxkiBUKf1bzv7OWg9jzu6fniYLGnixjK55Wu6yWzhsa
	LMXNmiqEGr3BBuTQnTT/f01CjZlExtzsG25xCJ2FABfbl+GsmTXlXgr6IEhoNuw9e9BKWoWCu+Z
	ua1XIkYsKX7Q9QL+4qsACQmIfT9NNUkDsrhdurCdkwRAJ3p+O2qC87XXMx2ia77rWG2BbGvyw9Q
	vNfKSEbs7QWZd7GgGbOad7g5aFCLRkIdmccLGjTScde2LJEcbOFLUvLwiGfu8ii1rK5JYVQEm0a
	MpRhPLQ6B3DQysJQsIOdYc9Q76122bKJHbfx5sGG1YPBNyZkz7vNNbcNnrUTlXKVwJN/BGstt2y
	ku9COjI0wyd8kVySaswJMMm+k4Durw7WltLCCb+asUuQrpn8xit+0GDMwIKP1RInruhCf8JKc0s
	c9ONszrUZoGU8s/ELbayTt2P6IBse0IW0aw6ieY8P/3cDB3ZOC2SdTj7ExLJvOLpFK5HdCTkH4p
	/wIUkgxLp6nm5H8Bw==
X-Received: by 2002:a05:7300:5b95:b0:2be:b00c:d083 with SMTP id 5a478bee46e88-2c1097ecb5bmr849410eec.35.1773969911672;
        Thu, 19 Mar 2026 18:25:11 -0700 (PDT)
Received: from localhost (c-76-102-12-149.hsd1.ca.comcast.net. [76.102.12.149])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c10b14c985sm1150838eec.2.2026.03.19.18.25.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 18:25:11 -0700 (PDT)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	andrew+netdev@lunn.ch,
	michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	saeedm@nvidia.com,
	tariqt@nvidia.com,
	mbloch@nvidia.com,
	alexanderduyck@fb.com,
	kernel-team@meta.com,
	johannes@sipsolutions.net,
	sd@queasysnail.net,
	jianbol@nvidia.com,
	dtatulea@nvidia.com,
	sdf@fomichev.me,
	mohsin.bashr@gmail.com,
	jacob.e.keller@intel.com,
	willemb@google.com,
	skhawaja@google.com,
	bestswngs@gmail.com,
	aleksandr.loktionov@intel.com,
	kees@kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	linux-rdma@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	leon@kernel.org
Subject: [PATCH net-next v3 07/13] bnxt: convert to ndo_set_rx_mode_async
Date: Thu, 19 Mar 2026 18:24:55 -0700
Message-ID: <20260320012501.2033548-8-sdf@fomichev.me>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260320012501.2033548-1-sdf@fomichev.me>
References: <20260320012501.2033548-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-33543-lists,linux-wireless=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DMARC_NA(0.00)[fomichev.me];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,lwn.net,linuxfoundation.org,lunn.ch,broadcom.com,intel.com,nvidia.com,fb.com,meta.com,sipsolutions.net,queasysnail.net,fomichev.me,gmail.com,vger.kernel.org,lists.osuosl.org];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[sdf@fomichev.me,linux-wireless@vger.kernel.org];
	NEURAL_SPAM(0.00)[0.147];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,netdev];
	RCPT_COUNT_TWELVE(0.00)[37];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,fomichev.me:email,fomichev.me:mid,intel.com:email]
X-Rspamd-Queue-Id: 8CE3C2D4C66
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Convert bnxt from ndo_set_rx_mode to ndo_set_rx_mode_async.
bnxt_set_rx_mode, bnxt_mc_list_updated and bnxt_uc_list_updated
now take explicit uc/mc list parameters and iterate with
netdev_hw_addr_list_for_each instead of netdev_for_each_{uc,mc}_addr.

The bnxt_cfg_rx_mode internal caller passes the real lists under
netif_addr_lock_bh.

BNXT_RX_MASK_SP_EVENT is still used here, next patch converts to
the direct call.

Cc: Michael Chan <michael.chan@broadcom.com>
Cc: Pavan Chebbi <pavan.chebbi@broadcom.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 31 +++++++++++++----------
 1 file changed, 17 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index c982aac714d1..225217b32e4b 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -11040,7 +11040,8 @@ static int bnxt_setup_nitroa0_vnic(struct bnxt *bp)
 }
 
 static int bnxt_cfg_rx_mode(struct bnxt *);
-static bool bnxt_mc_list_updated(struct bnxt *, u32 *);
+static bool bnxt_mc_list_updated(struct bnxt *, u32 *,
+				 const struct netdev_hw_addr_list *);
 
 static int bnxt_init_chip(struct bnxt *bp, bool irq_re_init)
 {
@@ -11130,7 +11131,7 @@ static int bnxt_init_chip(struct bnxt *bp, bool irq_re_init)
 	} else if (bp->dev->flags & IFF_MULTICAST) {
 		u32 mask = 0;
 
-		bnxt_mc_list_updated(bp, &mask);
+		bnxt_mc_list_updated(bp, &mask, &bp->dev->mc);
 		vnic->rx_mask |= mask;
 	}
 
@@ -13519,17 +13520,17 @@ void bnxt_get_ring_drv_stats(struct bnxt *bp,
 		bnxt_get_one_ring_drv_stats(bp, stats, &bp->bnapi[i]->cp_ring);
 }
 
-static bool bnxt_mc_list_updated(struct bnxt *bp, u32 *rx_mask)
+static bool bnxt_mc_list_updated(struct bnxt *bp, u32 *rx_mask,
+				 const struct netdev_hw_addr_list *mc)
 {
 	struct bnxt_vnic_info *vnic = &bp->vnic_info[BNXT_VNIC_DEFAULT];
-	struct net_device *dev = bp->dev;
 	struct netdev_hw_addr *ha;
 	u8 *haddr;
 	int mc_count = 0;
 	bool update = false;
 	int off = 0;
 
-	netdev_for_each_mc_addr(ha, dev) {
+	netdev_hw_addr_list_for_each(ha, mc) {
 		if (mc_count >= BNXT_MAX_MC_ADDRS) {
 			*rx_mask |= CFA_L2_SET_RX_MASK_REQ_MASK_ALL_MCAST;
 			vnic->mc_list_count = 0;
@@ -13553,17 +13554,17 @@ static bool bnxt_mc_list_updated(struct bnxt *bp, u32 *rx_mask)
 	return update;
 }
 
-static bool bnxt_uc_list_updated(struct bnxt *bp)
+static bool bnxt_uc_list_updated(struct bnxt *bp,
+				 const struct netdev_hw_addr_list *uc)
 {
-	struct net_device *dev = bp->dev;
 	struct bnxt_vnic_info *vnic = &bp->vnic_info[BNXT_VNIC_DEFAULT];
 	struct netdev_hw_addr *ha;
 	int off = 0;
 
-	if (netdev_uc_count(dev) != (vnic->uc_filter_count - 1))
+	if (netdev_hw_addr_list_count(uc) != (vnic->uc_filter_count - 1))
 		return true;
 
-	netdev_for_each_uc_addr(ha, dev) {
+	netdev_hw_addr_list_for_each(ha, uc) {
 		if (!ether_addr_equal(ha->addr, vnic->uc_list + off))
 			return true;
 
@@ -13572,7 +13573,9 @@ static bool bnxt_uc_list_updated(struct bnxt *bp)
 	return false;
 }
 
-static void bnxt_set_rx_mode(struct net_device *dev)
+static void bnxt_set_rx_mode(struct net_device *dev,
+			     struct netdev_hw_addr_list *uc,
+			     struct netdev_hw_addr_list *mc)
 {
 	struct bnxt *bp = netdev_priv(dev);
 	struct bnxt_vnic_info *vnic;
@@ -13593,7 +13596,7 @@ static void bnxt_set_rx_mode(struct net_device *dev)
 	if (dev->flags & IFF_PROMISC)
 		mask |= CFA_L2_SET_RX_MASK_REQ_MASK_PROMISCUOUS;
 
-	uc_update = bnxt_uc_list_updated(bp);
+	uc_update = bnxt_uc_list_updated(bp, uc);
 
 	if (dev->flags & IFF_BROADCAST)
 		mask |= CFA_L2_SET_RX_MASK_REQ_MASK_BCAST;
@@ -13601,7 +13604,7 @@ static void bnxt_set_rx_mode(struct net_device *dev)
 		mask |= CFA_L2_SET_RX_MASK_REQ_MASK_ALL_MCAST;
 		vnic->mc_list_count = 0;
 	} else if (dev->flags & IFF_MULTICAST) {
-		mc_update = bnxt_mc_list_updated(bp, &mask);
+		mc_update = bnxt_mc_list_updated(bp, &mask, mc);
 	}
 
 	if (mask != vnic->rx_mask || uc_update || mc_update) {
@@ -13620,7 +13623,7 @@ static int bnxt_cfg_rx_mode(struct bnxt *bp)
 	bool uc_update;
 
 	netif_addr_lock_bh(dev);
-	uc_update = bnxt_uc_list_updated(bp);
+	uc_update = bnxt_uc_list_updated(bp, &dev->uc);
 	netif_addr_unlock_bh(dev);
 
 	if (!uc_update)
@@ -15871,7 +15874,7 @@ static const struct net_device_ops bnxt_netdev_ops = {
 	.ndo_start_xmit		= bnxt_start_xmit,
 	.ndo_stop		= bnxt_close,
 	.ndo_get_stats64	= bnxt_get_stats64,
-	.ndo_set_rx_mode	= bnxt_set_rx_mode,
+	.ndo_set_rx_mode_async	= bnxt_set_rx_mode,
 	.ndo_eth_ioctl		= bnxt_ioctl,
 	.ndo_validate_addr	= eth_validate_addr,
 	.ndo_set_mac_address	= bnxt_change_mac_addr,
-- 
2.53.0


