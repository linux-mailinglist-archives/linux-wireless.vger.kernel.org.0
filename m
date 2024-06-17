Return-Path: <linux-wireless+bounces-9101-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82D6690B09B
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Jun 2024 15:59:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6ADE1C23A19
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Jun 2024 13:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C05916DC0C;
	Mon, 17 Jun 2024 13:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="btywrhE3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1423817737E;
	Mon, 17 Jun 2024 13:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718630729; cv=none; b=GZzcTVhcMfGMFOYSb9FYKukKl5g50ifRhzrKd53HtKxh1a6CT7XMNUjvFTRhSi7Ud7/XFwTUZX6V2ggU458KPLwJnLnUu60Ivg5HbGEGhu7Uy9DYSIOlBbsZSPhcSL8fT+kGMzjrzfXPAYNsGxEOxudh+BJ4d4N6JGnGONgEgO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718630729; c=relaxed/simple;
	bh=hq8Wn4mgFcQ5ZsgQz/dTNMmh6yB2UphrglQ7l2h1J0s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DLVBn+5GzVqBj54/MH2l54l3VtjKZWkbbNdHfcelZsIp6zisVGGwIVSEtlNORPd2BehSejaw+uceNXY/F97rS6VuyUBoVH7KzBg4F8ATja+bHQK7P5UHkNctCUY7aO/gI3FQiujq22iDh/BvwMaYkPLSR8igoDgRxUru2aJPJy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=btywrhE3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCFC1C4AF4D;
	Mon, 17 Jun 2024 13:25:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718630728;
	bh=hq8Wn4mgFcQ5ZsgQz/dTNMmh6yB2UphrglQ7l2h1J0s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=btywrhE3j05qxQGaIlGG9fMr0V2RIN9Vclggsd9FdGhIJyDXQQU5tI69IxGWHVzeJ
	 x+7e54yhqBlg0FFerCF8rS/AYJFs+371CaD4CEINsHb4lnlyP5E/6GWhzcYNDCHt30
	 J9UOCg5TdQJ3sBONnqfDziQx1EVCMBPmGI0wXZTE51RemxQUFH7xzi5Db4zD8hb1q/
	 3n42aaIoU2QDipoxM8ICOPU/tH8wdabC9KEdBOuvv7QRHVHJmzxljiO187H+VQP+8R
	 qnd+pKrVRH7R/LbFBe3MH9FYz7nG5ElZKsVXwIxcx5XdomTZHmjJDQAvCSKB2h9eqk
	 5Ys0BiGLezpOQ==
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
Date: Mon, 17 Jun 2024 09:24:20 -0400
Message-ID: <20240617132456.2588952-16-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240617132456.2588952-1-sashal@kernel.org>
References: <20240617132456.2588952-1-sashal@kernel.org>
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


