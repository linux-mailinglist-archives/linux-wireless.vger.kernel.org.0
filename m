Return-Path: <linux-wireless+bounces-13111-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07E2598420D
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Sep 2024 11:26:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9A11285C67
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Sep 2024 09:26:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 701DC17ADFA;
	Tue, 24 Sep 2024 09:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kTwTT9F3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BA1417ADF1
	for <linux-wireless@vger.kernel.org>; Tue, 24 Sep 2024 09:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727169923; cv=none; b=iuO/jqm3Hkgf831sOpLPO6DGVQBBMFdEwv0h5SXwz74tJ/eYZ0W+B8Yp4Z1Bk87/1Cohws1mSaFI4ac2ZYwhRzp1Xh0LTojeCSk+8CYU4JeKZYqt4Y85KFvqDDJtSCgehoE96xGs8AinVrbst9BGfay5HOj9A2OdHHCWpy2eUW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727169923; c=relaxed/simple;
	bh=VKUzvTr7g8w0XMTjwnJJJg8ssO4tx+8HtBNMDAyLejQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CKdK4K87QKFYf0LZJ58yNqML9f5KkQCaUTSNwz9x9Alfr0Q7eCf7gfkRm3J+jUpDsOdzJWtfPfiHoOJLGNFtBXNYOEHGNsG0lSrhkOlvmLvEdhRGKl4dOsqx9v2hPuM7Uh3hDB7tgt2SYmL8QgG0jIn3So5olzdM2qIEJeZzjeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kTwTT9F3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9512DC4CEC7;
	Tue, 24 Sep 2024 09:25:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727169923;
	bh=VKUzvTr7g8w0XMTjwnJJJg8ssO4tx+8HtBNMDAyLejQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kTwTT9F3YJkDsyzOZh+s7iHj4xzlWTg32jSNXSIRcgud+9dt4fVqQwfTHQP+xeaRX
	 DZA+CVkrN8KFzV6rBlIWPcxMlfTe+koXTTmBIMh+klfkrcC7NDsSNRGgKUx1+98r4t
	 xLE2zRz2RNgwIyVJWtsNpPy79OVy+3SQKBlOAQ2EcqKPT3UrqcxdUGgpGO8DXLpe2o
	 wQMkqfp0R+yDXqPr29hw+TUNrBy6yhIl+AY9AzdRhzheoyoYWvw58ik3iaFi8mlLqx
	 51VEsrVMC8WPm4WHhSyQC03+vVSrfPRIzt4DqhanFn28aXPDsDOV2upghXqsshUmly
	 cn0abwsVDHWdg==
From: Kalle Valo <kvalo@kernel.org>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH RFC v3 5/6] wifi: ath12k: ath12k_mac_op_set_key(): remove exit label
Date: Tue, 24 Sep 2024 12:25:14 +0300
Message-Id: <20240924092515.1049885-6-kvalo@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20240924092515.1049885-1-kvalo@kernel.org>
References: <20240924092515.1049885-1-kvalo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kalle Valo <quic_kvalo@quicinc.com>

In ath12k_mac_op_set_key() removing the exit label was a bit more complex so do
it in a separate patch. Remove the else branch and remove now the uncessary ret
initialisation.

No functional changes.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 47e8354bb436..c41740734fc8 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -3942,7 +3942,7 @@ static int ath12k_mac_set_key(struct ath12k *ar, enum set_key_cmd cmd,
 	struct ath12k_peer *peer;
 	struct ath12k_sta *arsta;
 	const u8 *peer_addr;
-	int ret = 0;
+	int ret;
 	u32 flags = 0;
 
 	lockdep_assert_wiphy(ath12k_ar_to_hw(ar)->wiphy);
@@ -3970,14 +3970,13 @@ static int ath12k_mac_set_key(struct ath12k *ar, enum set_key_cmd cmd,
 		if (cmd == SET_KEY) {
 			ath12k_warn(ab, "cannot install key for non-existent peer %pM\n",
 				    peer_addr);
-			ret = -EOPNOTSUPP;
-			goto exit;
-		} else {
-			/* if the peer doesn't exist there is no key to disable
-			 * anymore
-			 */
-			goto exit;
+			return -EOPNOTSUPP;
 		}
+
+		/* if the peer doesn't exist there is no key to disable
+		 * anymore
+		 */
+		return 0;
 	}
 
 	if (key->flags & IEEE80211_KEY_FLAG_PAIRWISE)
@@ -3988,13 +3987,13 @@ static int ath12k_mac_set_key(struct ath12k *ar, enum set_key_cmd cmd,
 	ret = ath12k_install_key(arvif, key, cmd, peer_addr, flags);
 	if (ret) {
 		ath12k_warn(ab, "ath12k_install_key failed (%d)\n", ret);
-		goto exit;
+		return ret;
 	}
 
 	ret = ath12k_dp_rx_peer_pn_replay_config(arvif, peer_addr, cmd, key);
 	if (ret) {
 		ath12k_warn(ab, "failed to offload PN replay detection %d\n", ret);
-		goto exit;
+		return ret;
 	}
 
 	spin_lock_bh(&ab->base_lock);
@@ -4040,8 +4039,7 @@ static int ath12k_mac_set_key(struct ath12k *ar, enum set_key_cmd cmd,
 
 	spin_unlock_bh(&ab->base_lock);
 
-exit:
-	return ret;
+	return 0;
 }
 
 static int ath12k_mac_op_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
-- 
2.39.5


