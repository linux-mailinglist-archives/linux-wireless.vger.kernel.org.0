Return-Path: <linux-wireless+bounces-9158-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BE1C090CC0A
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Jun 2024 14:42:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BEA01F22214
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Jun 2024 12:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8A89158DB7;
	Tue, 18 Jun 2024 12:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="omLAcdsh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E471158DB2;
	Tue, 18 Jun 2024 12:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718714216; cv=none; b=UBo1BosChwqDlCUg8TP6YFw5UsoWmUYg7sYAP+XYhvCdGW5LbD4fxgNwJbzYeaQ5Z+10IgAtL9mw7uxYl9yoap7SCz1xD2cspex7O2tFFA9s5C4QPywepmfIbf9C+KFfEtksksUcSQpHe3yKOKF+SeFtXCheimC1zzFqUoRHyIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718714216; c=relaxed/simple;
	bh=JLOJ558q63l03Y1Ze34RgJjlYOi5QqzBLt+5yBQZ0cU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h1a6YYLc8ZFWrf1FN2OQAHUsQ8qHWGGTMvOF4cgOs0nes+DQXzis698kxPkI07dFAG9qTVkglvPT8aZ3KkXftCct+cQTC4UrsVPUYxhJ659w7n7R2XK5BRZg3OIL3hQr7NC3YNNlSvWtYfwCHldRl1m6YDZxKUlwwpKxuZENtYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=omLAcdsh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1BEDC3277B;
	Tue, 18 Jun 2024 12:36:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718714216;
	bh=JLOJ558q63l03Y1Ze34RgJjlYOi5QqzBLt+5yBQZ0cU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=omLAcdshYiNYAg/OXayMLI0azdCcjYI+gKf5V4pcHMwDMf+t8R0XIyImP1O159Nql
	 8ZizLSYxY8xFGKlNKLuQ7VtNzMfaCd1ihPBI9Mkkz/x32bVYm8Dq3BCIAD+8Cte0qP
	 3yglC3fBtbXhxrZmqweME0r0xOmYYzFPtoxr+io2fxhektttJk5v+EVcUxPIZ7f6Yk
	 2CZT54fqTsZgK3h45DheTQnlJ336cWPefSsrU9TNUnWzCyUPhaYsHUWNYvc7YADhv8
	 dBn7C2KWQn7lbW1z9LAL58VENlE5wqjDrPzQZ1TLxKxLGp+BWHXj2GQ53VGp/Z6bx6
	 FxAwzJ0nGRlhQ==
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
Subject: [PATCH AUTOSEL 6.9 20/44] wifi: iwlwifi: mvm: Handle BIGTK cipher in kek_kck cmd
Date: Tue, 18 Jun 2024 08:35:01 -0400
Message-ID: <20240618123611.3301370-20-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240618123611.3301370-1-sashal@kernel.org>
References: <20240618123611.3301370-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.9.5
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
index 74743c3ceeefb..6f16b5b33f0c0 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
@@ -595,6 +595,12 @@ static void iwl_mvm_wowlan_gtk_type_iter(struct ieee80211_hw *hw,
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
@@ -606,10 +612,13 @@ static void iwl_mvm_wowlan_gtk_type_iter(struct ieee80211_hw *hw,
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


