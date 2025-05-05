Return-Path: <linux-wireless+bounces-22518-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB25AAAA67B
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 02:13:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C88E1167040
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 00:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA3E03280AB;
	Mon,  5 May 2025 22:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fknkrSOe"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EEE93280A2;
	Mon,  5 May 2025 22:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484487; cv=none; b=qCeVU7yF57BohQfBkFcdxEZLFLmxbXZehDxC/6LA/6A7uFqojN4RMYwMmyIaES1QyiO6pPpggsZjBpWPFwSGz42Fu8LuXcS53GzTYiiDeyZKmS9gA0TOetXDYN/JVX9/xO7C2icmDy8MA5iElTKriLIx/a3joE+QYOWXJmJU7+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484487; c=relaxed/simple;
	bh=HHPlxbkjj8uKoAUKROxb6hyWNeK7YJF8UJPFP1hVd98=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UhraimxO7jbyGTicBFsLoqVz864lCzoAeCqUZEE0HYHc4nY799YuDYBkmWxrU0e88u51EtIffl0zNN0ziPENCvD0BKdV+kjj02RxP7rEDniD2brhM00lYEydTlgNdVr3HyDrVA/rzganLE3F3cv+6EhULUAVCvMPFqh2px6HrPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fknkrSOe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC3BFC4CEED;
	Mon,  5 May 2025 22:34:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484487;
	bh=HHPlxbkjj8uKoAUKROxb6hyWNeK7YJF8UJPFP1hVd98=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fknkrSOeisnTxuJQsVVmml84GP4EyxhgRbwc/pNXM9dGIe3sQc90PSEN7ftmTaAE6
	 b52gRXeltP/8KQhcrHdlBCO92TwwdTsDFwbNAuFPIyqFo585l77e18/DKBvvXJSmQz
	 gxL6ARpbHbChasRXWzRDMLaFmTFkfQ//ATZNRCf8l1LU3yuqBTLrUvm5sHv0YWO5g/
	 pmh4A0NGqug20SQwofrYmg5p0rH8T9MNb6Y6AihBh3Wmjp0aU+52Ind6QlAEHRhx+n
	 7KXBIi/IKaYbQ1ZlsihxIF8+aKuephrcdBVLE/ma/IFBPdCVJWJN8ECUnBpGQ4VoWD
	 ccuOmv86KprtA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>,
	Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>,
	Nicolas Escande <nico.escande@gmail.com>,
	Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>,
	jjohnson@kernel.org,
	linux-wireless@vger.kernel.org,
	ath12k@lists.infradead.org
Subject: [PATCH AUTOSEL 6.14 495/642] wifi: ath12k: use arvif instead of link_conf in ath12k_mac_set_key()
Date: Mon,  5 May 2025 18:11:51 -0400
Message-Id: <20250505221419.2672473-495-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
Content-Transfer-Encoding: 8bit

From: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>

[ Upstream commit 00e4dc11695d48322780812b503314682659e98b ]

Currently, in ath12k_mac_set_key(), if sta is not present, the address is
retrieved from link_conf's bssid or addr member, depending on the interface
type.

When operating as an ML station and during shutdown, link_conf will not be
available. This can result in the following error:

ath12k_pci 0004:01:00.0: unable to access bss link conf in set key for vif AA:BB:CC:DD:EE:FF link 1

The primary purpose of accessing link_conf is to obtain the address for
finding the peer. However, since arvif is always valid in this call, it can
be used instead.

Add change to use arvif instead of link_conf.

A subsequent change will expose this issue but since tear down will give
error, this is included first.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00130-QCAHKSWPL_SILICONZ-1.97421.5 # Nicolas Escande

Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
Signed-off-by: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
Tested-by: Nicolas Escande <nico.escande@gmail.com>
Link: https://patch.msgid.link/20250204-unlink_link_arvif_from_chanctx-v2-5-764fb5973c1a@oss.qualcomm.com
Signed-off-by: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/ath/ath12k/mac.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 9123ffab55b52..95ad9fefbdfcd 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -4534,9 +4534,6 @@ static int ath12k_mac_set_key(struct ath12k *ar, enum set_key_cmd cmd,
 			      struct ath12k_link_sta *arsta,
 			      struct ieee80211_key_conf *key)
 {
-	struct ath12k_vif *ahvif = arvif->ahvif;
-	struct ieee80211_vif *vif = ath12k_ahvif_to_vif(ahvif);
-	struct ieee80211_bss_conf *link_conf;
 	struct ieee80211_sta *sta = NULL;
 	struct ath12k_base *ab = ar->ab;
 	struct ath12k_peer *peer;
@@ -4553,19 +4550,10 @@ static int ath12k_mac_set_key(struct ath12k *ar, enum set_key_cmd cmd,
 	if (test_bit(ATH12K_FLAG_HW_CRYPTO_DISABLED, &ab->dev_flags))
 		return 1;
 
-	link_conf = ath12k_mac_get_link_bss_conf(arvif);
-	if (!link_conf) {
-		ath12k_warn(ab, "unable to access bss link conf in set key for vif %pM link %u\n",
-			    vif->addr, arvif->link_id);
-		return -ENOLINK;
-	}
-
 	if (sta)
 		peer_addr = arsta->addr;
-	else if (ahvif->vdev_type == WMI_VDEV_TYPE_STA)
-		peer_addr = link_conf->bssid;
 	else
-		peer_addr = link_conf->addr;
+		peer_addr = arvif->bssid;
 
 	key->hw_key_idx = key->keyidx;
 
-- 
2.39.5


