Return-Path: <linux-wireless+bounces-9091-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 353A090AFE2
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Jun 2024 15:47:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C75A62811D7
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Jun 2024 13:47:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 162141C2334;
	Mon, 17 Jun 2024 13:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uucoUY0g"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E17BE19B3F9;
	Mon, 17 Jun 2024 13:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718630629; cv=none; b=O/AG4jQo30nLllx3yZdJydMsvBx9hhAnE+s3uefl9YEHB60lbzplHdJrX27CR6lcz7MeyR2oQHGe4cMEzaE5QTDVvOhS/4Z+MWya1q/Q/z8fPVHeJ951v1fq2RYT98/gpm8AHHIoEqydMHGTur0xDLLrBFVjVGIA1+yMBKMhrk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718630629; c=relaxed/simple;
	bh=3VfQZ5Q3HQut4Y6z9uJyn7926e1/dXsvwADT5sBEWpw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QUBW9M1+/atez/pf9wSyfW6W1LDpho8jfF4a5NGIT2i3rn7LEWuS6yvYaKbecYu/P+f1z87a+9r9/RhOLSsZuBD+1F2T0e30JlhZlsRyYUbFbdFzmRHemJ683Erp7WS0pE4TTiTXDiyXd6nDq/+9Muwg9e81iCjC8zidPgGyatA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uucoUY0g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B11EC2BD10;
	Mon, 17 Jun 2024 13:23:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718630628;
	bh=3VfQZ5Q3HQut4Y6z9uJyn7926e1/dXsvwADT5sBEWpw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uucoUY0g2yocN9vIlXCw6qjz32btBHb6b9fFDAKpp4FMei3rc5WctRPQqs0vhO/4s
	 xXDx/1p4UPUs3AVaIe7iO0K89vlowcK3BeOIq2IctTlUEq6JV0qsJAe516e0oJEK8g
	 18aTfWRRUZywXdCkb7FKddHp3wcBhzkl+WYGwudC4WURjz+JWA+uWvRpof0wwfV3Sd
	 uHXjai2W1IEungWnoyo+X1ijKEAT7/trOVCevbR6vRq8kokdcbkKUndGEaid9C/gS+
	 nXJE5CUBO5Ocflc8cFM5ZKE+2NR8FELO5yLD6//FlTe2hGbXzJhRac6zFkutrc9Aum
	 MAuQHaUuXqc5A==
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
Subject: [PATCH AUTOSEL 6.6 17/35] wifi: iwlwifi: mvm: Handle BIGTK cipher in kek_kck cmd
Date: Mon, 17 Jun 2024 09:22:15 -0400
Message-ID: <20240617132309.2588101-17-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240617132309.2588101-1-sashal@kernel.org>
References: <20240617132309.2588101-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.34
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
index 66aed6635d92c..9c89f0dd69c86 100644
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


