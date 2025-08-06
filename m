Return-Path: <linux-wireless+bounces-26165-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3483FB1C0C6
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Aug 2025 09:00:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FDF0182DDC
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Aug 2025 07:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FA231C860E;
	Wed,  6 Aug 2025 07:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gr3JR0G+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0739C8821
	for <linux-wireless@vger.kernel.org>; Wed,  6 Aug 2025 07:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754463623; cv=none; b=QZJ+hkwQciZ+Lm45SRZQbGK8/95BoKy4VpSvfaHY67+QvmFMMjw7/gFjw7QuapprbFmbngWJJnvTK0VRrdm8uNFVt2Dp4DCwbE2I7/RQQf9F0HBpx+JUAZzDopzkD+mX43IXJuGFkzPrghIOhWbU0ME6F9h5zosgJVQobmHE6h0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754463623; c=relaxed/simple;
	bh=j41/opJZG3HayqZRzU3osXSvk+kZibu3wwTCaaAME7k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e/I8qibS0n8fwV52GudKSaJW76hCksaz51DksyTMLXtIstxT2KOUBjZ6L28j6Ui659h/tdxgLTbFkmWSiKuRMF6C6i8aTT4mpKaXpluIANc/2RlXlhfxTxrm4Lqg1zxqufPDyZ326+0lapoFjfVM5DtXJmumS4mYv7UR9MhseXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gr3JR0G+; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2429d9d3755so7089285ad.3
        for <linux-wireless@vger.kernel.org>; Wed, 06 Aug 2025 00:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754463615; x=1755068415; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+PJ2Y4D5wbasdWs8LHDv5pP2x0H5risjGvi7zm5xR5M=;
        b=gr3JR0G+ytokO/8c94lNywK0f6q7gjzn2800bEKbWGuocAM1FWB8Hkp6QwQFV+RZ/x
         VDG51dH50pjwL1znsWaYZO5jcUc9at/DwEJtg7vw1hi7UMA1/RkooSY7F53js86vhNeo
         H+KChwMTQ06AISsNza/Q88MKGKo1DvYda+Z8oroBdEdas1ev3nxD4JH2wwWG48K7SZy2
         TxMtekk3xhh+hyoAw4UTqw7z4MmzblpbMZcDLVMdURMxJdeJOWtYqFb5LvS6nOqZnLNS
         QICB9yFbHKpKeEWlIxAPagZtKZT4SEpBDzpOGdWKXxPgdVblFB7aknVayCccncn64xIc
         5ltw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754463615; x=1755068415;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+PJ2Y4D5wbasdWs8LHDv5pP2x0H5risjGvi7zm5xR5M=;
        b=edx/LhuGieLAlXIn+ulh7yqHY62RsR1ulovsA7jME06Nkuxpwhb3fprDTjRcMzNQsb
         t+JvH5RmfNeIe4SEldaRuhzmnRTpXWRPhpFdN0JCjfAUtneVnjLTa04+A038e2sFrRUl
         /iuI++UfAs/RbLU1oGKE2lCid2PikOpbi6ZGqY5HD5uGN6qptj5F6HfRzIfb0D9c7Fjn
         EEmMQ82V0MLGtvtVm50ZnR+LYs9FLoOGIKGdtCgK9ytkwHzUByJ0Ke4rOcAK2fmwiwip
         gHpEQnXX1jY37309qhaM4ze6LciVv10C2K8Xw5o6P5/72EJnXCsJutkpO3FKJClP6vUg
         IVzg==
X-Gm-Message-State: AOJu0YyPAGeDaJMbIqOjWX+44E0YNRc+p16goy8JhP6tz3XQRxggUpj+
	hwMXZ/Lr0tzL6cjJa6zqSvFflGP4+q3DPBGJN8qw4thD7U1sA96l6KUl
X-Gm-Gg: ASbGncueGd1fIT9VvGtD+ODmJzg+FEgLr3IPjsU4zA0FcljEn8mhe8RHMeghsW3HymA
	2Z2tdfz00APGmnJi93xtfUrODNS5LjEIoQl+3prhT0SgICXNFTiYQb7tAlzniwfvkl6ojnFrmoI
	e2dcKYEPwQ1YkYkH5xG4MzE89GP8yDC/hA8ctSD/9P82m/tsm7Xhi5TmyNeD1TKxRQTaoAZNIXe
	dDq7/UKDJXNSJIpJBGb35zcn4kBjNvHNN4LFdOibU6YsZUmlQdNapXkrnAxSEsWNZUUEpGcHPLN
	47ksg9BuTQe3JmjQUClyrvbna5HQdMweUdhTx1A9+EPSViCyfVuDp6V1PfYSgRwbbTj9mT0SdoR
	tpnOPNFLeIWce8eCJxfMG2KldDyIKzBKZPivrnCZmibS4BP9e/9X9ejD142CBA+kohWm+ThE=
X-Google-Smtp-Source: AGHT+IGSiEGveSXvbNV7nv1GqbabWBisxgG67FjmM9mmfQlGUUDu3fktEJqByYD62CtQBDJOH43LEg==
X-Received: by 2002:a17:902:c94b:b0:240:22af:91c7 with SMTP id d9443c01a7336-2429ee84360mr21550685ad.14.1754463614823;
        Wed, 06 Aug 2025 00:00:14 -0700 (PDT)
Received: from NT123328-PC02.ZyXEL.com (114-33-191-187.hinet-ip.hinet.net. [114.33.191.187])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31f63f36311sm18692998a91.34.2025.08.06.00.00.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 00:00:14 -0700 (PDT)
From: Zhi-Jun You <hujy652@gmail.com>
To: jjohnson@kernel.org
Cc: linux-wireless@vger.kernel.org,
	ath10k@lists.infradead.org,
	Zhi-Jun You <hujy652@gmail.com>
Subject: [RFC PATCH] wifi: ath10k: support flush_sta method
Date: Wed,  6 Aug 2025 15:00:05 +0800
Message-ID: <20250806070005.1429-1-hujy652@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a STA is marked as no longer authorized, if the driver doesn't
implement flush_sta(), mac80211 calls ieee80211_flush_queues() to
flush hardware queues to avoid sending unencrypted frames.

This has became a problem for ath10k because ieee80211_flush_queues()
will stop all traffic and call ath10k_flush, which waits until the
whole HW queue is empty. In a busy environment this will trigger a
timeout warning and stalls other STAs.

Fix this by implementing flush_sta method using WMI command to flush
frames of a specific STA.
Flushed frames will be marked as discard in tx complete indication.

ops->flush_sta will be set to NULL if htt.disable_tx_comp is set to
true.

Tested-on: QCA9984 hw1.0 PCI 10.4-3.9.0.2-00157

Signed-off-by: Zhi-Jun You <hujy652@gmail.com>
---
 drivers/net/wireless/ath/ath10k/mac.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/net/wireless/ath/ath10k/mac.c b/drivers/net/wireless/ath/ath10k/mac.c
index 24dd794e31ea..6959f20334a7 100644
--- a/drivers/net/wireless/ath/ath10k/mac.c
+++ b/drivers/net/wireless/ath/ath10k/mac.c
@@ -8135,6 +8135,20 @@ static void ath10k_flush(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	mutex_unlock(&ar->conf_mutex);
 }
 
+static void ath10k_mac_op_flush_sta(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
+			     struct ieee80211_sta *sta)
+{
+	struct ath10k_vif *arvif = (void *)vif->drv_priv;
+	struct ath10k *ar = hw->priv;
+	u32 bitmap = 0xFFFFFFFF;
+	int ret = 0;
+
+	ret = ath10k_wmi_peer_flush(ar, arvif->vdev_id, sta->addr, bitmap);
+	if (ret)
+		ath10k_warn(ar, "failed to flush sta (sta %pM)\n",
+			    sta->addr);
+}
+
 /* TODO: Implement this function properly
  * For now it is needed to reply to Probe Requests in IBSS mode.
  * Probably we need this information from FW.
@@ -9487,6 +9501,7 @@ static const struct ieee80211_ops ath10k_ops = {
 	.set_rts_threshold		= ath10k_set_rts_threshold,
 	.set_frag_threshold		= ath10k_mac_op_set_frag_threshold,
 	.flush				= ath10k_flush,
+	.flush_sta			= ath10k_mac_op_flush_sta,
 	.tx_last_beacon			= ath10k_tx_last_beacon,
 	.set_antenna			= ath10k_set_antenna,
 	.get_antenna			= ath10k_get_antenna,
@@ -10294,6 +10309,9 @@ int ath10k_mac_register(struct ath10k *ar)
 	if (!ar->hw_params.hw_ops->set_coverage_class)
 		ar->ops->set_coverage_class = NULL;
 
+	if (ar->htt.disable_tx_comp)
+		ar->ops->flush_sta = NULL;
+
 	ret = ath_regd_init(&ar->ath_common.regulatory, ar->hw->wiphy,
 			    ath10k_reg_notifier);
 	if (ret) {
-- 
2.50.1


