Return-Path: <linux-wireless+bounces-9179-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E20390CD03
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Jun 2024 15:03:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB3A61F218A2
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Jun 2024 13:03:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25C2E1A2FDA;
	Tue, 18 Jun 2024 12:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="agU7AQtn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F01A31A38F1;
	Tue, 18 Jun 2024 12:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718714451; cv=none; b=Wrxa7xYMLndhhczsw5h6dqPt8rWMrzWB3w/rPd+UoovW1ITmOoyAeDsNsrdR3o4gzQNSLRarDZdxMJv+b4D5uGz2iC/une6dFkN9f9g3unGqf3PkRsomqUwzMfgVGPsIU/Tua+7/bKcqkBsMsXInX2B4S5FzJ+ZxeRMdqrfaB4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718714451; c=relaxed/simple;
	bh=hq8Wn4mgFcQ5ZsgQz/dTNMmh6yB2UphrglQ7l2h1J0s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s51WLp6V5uLBJDPi/rGpLHrSYiRIyfYEKTQLhA9A30rI4xmJ1DB6dMQt2PwZk/C8wLjHrM7S3yt0KyFfABFrXsjUjuqbw7adbkfZh4btV5PdxnMj5/1wry74mYRK//HrAmTzScCG6C6AF0qbdGBc04bUNoczpYIoCqIDDHU2bsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=agU7AQtn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2530C4AF1D;
	Tue, 18 Jun 2024 12:40:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718714450;
	bh=hq8Wn4mgFcQ5ZsgQz/dTNMmh6yB2UphrglQ7l2h1J0s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=agU7AQtnvsZdYfTBPeHwGViKCbPg6kNKd+W5BoDddS1D58/xNiS7Wq01nz/3MUtFP
	 D1z+pQJctmpWc7M8SUjOK5W0k/mXZC95AnhIsFBGHkBhieJzwuSIqbffm1xM1Qnb8W
	 alie7ZfJ2d0uJsUk76hsfT516xitLBp4mN35kVVg3uq9q08WNnhFGT1dJc9VWE2DFE
	 HNeJhyQimgK+UiL+HBxj3PpNnoz1iDR6YfvLM2ItYQYb/064eN3BWMCJZtsWTfCpzh
	 ON1QIKB8jBixtBQ5Cxm+fYHfpB3dYbkJe0TZ1Axyhr8ok/okgM08OjejYChVzdifmI
	 OEVF3N1cflV1Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Yedidya Benshimol <yedidya.ben.shimol@intel.com>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	kvalo@kernel.org,
	gregory.greenman@intel.com,
	shaul.triebitz@intel.com,
	benjamin.berg@intel.com,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 16/29] wifi: iwlwifi: mvm: Handle BIGTK cipher in kek_kck cmd
Date: Tue, 18 Jun 2024 08:39:42 -0400
Message-ID: <20240618124018.3303162-16-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240618124018.3303162-1-sashal@kernel.org>
References: <20240618124018.3303162-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.94
Content-Transfer-Encoding: 8bit

From: Yedidya Benshimol <yedidya.ben.shimol@intel.com>

[ Upstream commit 08b16d1b5997dc378533318e2a9cd73c7a898284 ]

The BIGTK cipher field was added to the kek_kck_material_cmd
but wasn't assigned. Fix that by differentiating between the
IGTK/BIGTK keys and assign the ciphers fields accordingly.

Signed-off-by: Yedidya Benshimol <yedidya.ben.shimol@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Link: https://msgid.link/20240513132416.7fd0b22b7267.Ie9b581652b74bd7806980364d59e1b2e78e682c0@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
index 9a36ce98b5bfc..425588605a262 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
@@ -594,16 +594,25 @@ static void iwl_mvm_wowlan_gtk_type_iter(struct ieee80211_hw *hw,
 					 void *_data)
 {
 	struct wowlan_key_gtk_type_iter *data = _data;
+	__le32 *cipher = NULL;
+
+	if (key->keyidx == 4 || key->keyidx == 5)
+		cipher = &data->kek_kck_cmd->igtk_cipher;
+	if (key->keyidx == 6 || key->keyidx == 7)
+		cipher = &data->kek_kck_cmd->bigtk_cipher;
 
 	switch (key->cipher) {
 	default:
 		return;
 	case WLAN_CIPHER_SUITE_BIP_GMAC_256:
 	case WLAN_CIPHER_SUITE_BIP_GMAC_128:
-		data->kek_kck_cmd->igtk_cipher = cpu_to_le32(STA_KEY_FLG_GCMP);
+		if (cipher)
+			*cipher = cpu_to_le32(STA_KEY_FLG_GCMP);
 		return;
 	case WLAN_CIPHER_SUITE_AES_CMAC:
-		data->kek_kck_cmd->igtk_cipher = cpu_to_le32(STA_KEY_FLG_CCM);
+	case WLAN_CIPHER_SUITE_BIP_CMAC_256:
+		if (cipher)
+			*cipher = cpu_to_le32(STA_KEY_FLG_CCM);
 		return;
 	case WLAN_CIPHER_SUITE_CCMP:
 		if (!sta)
-- 
2.43.0


