Return-Path: <linux-wireless+bounces-14381-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BACB09ACB3F
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Oct 2024 15:31:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CD562837A4
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Oct 2024 13:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6077C1AAE02;
	Wed, 23 Oct 2024 13:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T8hbYr0m"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C70F1BDA8F
	for <linux-wireless@vger.kernel.org>; Wed, 23 Oct 2024 13:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729690208; cv=none; b=cA7Ca0Kqlee46b9Bx3g/kcR1oGSyaCkMS+PWSFSui/51cNDDNUwPxfI8ooUpPozQC6+F+24g0iuyym6bihJPyNHq37QGYIO76DxRVvTMdyfODWPPxkn1Hfv22ri9FLxnl4+cTtB1fFv9bhzM9e7dr7udMLwxAzl8jL6M2mXpfk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729690208; c=relaxed/simple;
	bh=V1wdaqhPHxLWgr646r9fLNDlKSG64mnsfzDYxdjDIoE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lbbxVKlZnocyoIBBPPpUlb8JG9FrSmy39GyT0alvqme/Xe0EYb2EAoWdUkRizCUWdbVAQVK1DmQT+23j0U+ZzWTWKmsZXmHqwS82Lm/UmvqrVH7EnpplKKAMgeAEDetrvMcSapHCIprG21fJHJMvtyzPVrXWhkLK0lWNxtv/H5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T8hbYr0m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E7EFC4CEE7;
	Wed, 23 Oct 2024 13:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729690207;
	bh=V1wdaqhPHxLWgr646r9fLNDlKSG64mnsfzDYxdjDIoE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=T8hbYr0mRApoaczw2ICmxzG5f2AxjkeRHTXXvKpobEOtMvtzyYC/oe87VA2veW7o4
	 nAcPUSdGia9HTKx/tWVWW6XGLkgUaCdSWkv2KytEE0TAONAdo9N9P71J7z/qJNnGVs
	 YWR/WBuUbdGN9+UOrzzAPwv7aAdP9tWRGJDbOqlFl3j9uqTCUYdsUMo7rXv7xwjCi/
	 kDLTNyG2tNhwMyGdXZ5+7wU9nzwFagA0k7tChGqAS+6JPpgVtE1/qMIohpYMr2d6UQ
	 afCngvzQJYwefLS1Y1CxrAcK/rxdbBI+lRmO9isxhNULxVgNuN9zm0ANgf25xvDXcq
	 9SZLHNS6pTprA==
From: Kalle Valo <kvalo@kernel.org>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH 1/8] wifi: ath12k: ath12k_mac_vdev_create(): use goto for error handling
Date: Wed, 23 Oct 2024 16:29:57 +0300
Message-Id: <20241023133004.2253830-2-kvalo@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241023133004.2253830-1-kvalo@kernel.org>
References: <20241023133004.2253830-1-kvalo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kalle Valo <quic_kvalo@quicinc.com>

In commit 477cabfdb776 ("wifi: ath12k: modify link arvif creation and removal
for MLO") I had accidentally left one personal TODO comment about using goto
instead of ret. Switch to use goto to be consistent with the error handling in
the function.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index f5f96a8b1d61..f45f32f3b5f6 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -7047,8 +7047,7 @@ int ath12k_mac_vdev_create(struct ath12k *ar, struct ath12k_link_vif *arvif)
 		ret = ath12k_wait_for_peer_delete_done(ar, arvif->vdev_id,
 						       arvif->bssid);
 		if (ret)
-			/* KVALO: why not goto err? */
-			return ret;
+			goto err;
 
 		ar->num_peers--;
 	}
-- 
2.39.5


