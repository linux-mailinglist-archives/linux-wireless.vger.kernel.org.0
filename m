Return-Path: <linux-wireless+bounces-5224-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B08788AC6E
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Mar 2024 18:52:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BCB41C3EC2A
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Mar 2024 17:52:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41BCA1327F6;
	Mon, 25 Mar 2024 17:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="j4ASV0hS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A56B438DFB
	for <linux-wireless@vger.kernel.org>; Mon, 25 Mar 2024 17:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711386537; cv=none; b=eaGMs6lbpJIpZE5QhXnIOxqU4WZ/MzFX5RlfwavYvu1c06/R2RCz4QswHtBuHh+JK5g4rnqUefi4GxK6vVly7eZTXhkBCvz5BkP7lEE26gr/JFnb5lpYp1DuUFVPlfbuBhMYbAjPEnSw+uW1AKlOqqoJbbwH/6o4bQKBYROWvek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711386537; c=relaxed/simple;
	bh=+Eca2tEmbDkrVwprTC111l2qZDY5XxMd4AZWUK9a3DU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YCJ5Gm2XBB2GYmwETDpZD8OXbmL5aM5Sj7D9+jfbJdzEpsMKtv7GCVF4mqk507qEDDdgRI8ljaONO2Devcrin8MrLLnDx4yT/ZO1o8+lJWJsQbB9dBpI9Sh9qr5VuVKZjeaGSabkiB5IYUnpeNwMntOC3eRbW06t8mkLpZdevi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=j4ASV0hS; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=Nkc4z6RGvb2lUDk7LGBhj10I/D6w0DvGqK3io/S7EsQ=; t=1711386535; x=1712596135; 
	b=j4ASV0hSEtNgy42pAQIBMeaQRKso+AuKslptcip82UwuvQ8+fHTjdWRg289wWXuK67bHnaOf+5w
	vltwzt+KYvby/E9QQlWo2XlDluDMWNT2DLjetFjvh1eQazeKmOwY1vjfwUAKXdr4j9sWbFO0U1Xh1
	3D2ZtJ7PQI/I5ejq5Lsli6cBBDpc5kXr3NHLxnJsnlvLuKIP3XdmjWT76nOiySTR6CVjJym8Ssrpl
	51IJZSnOKQ2Ro5G+7La8JZcIdhaqEnWFk3Xxjp9Cs3NjKDf2M+g7knrcMZWZqbLJ87iBpyzBuo9CD
	1zGG2HjsxVZV596Z4GJDTx3a2Pe2vUB2Us7A==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1ronoa-0000000DyFB-4ACf;
	Mon, 25 Mar 2024 18:08:53 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Daniel Gabay <daniel.gabay@intel.com>,
	Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Subject: [PATCH] wifi: iwlwifi: mvm: fix check in iwl_mvm_sta_fw_id_mask
Date: Mon, 25 Mar 2024 18:08:51 +0100
Message-ID: <20240325180850.e95b442bafe9.I8c0119fce7b00cb4f65782930d2c167ed5dd0a6e@changeid>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

In the previous commit, I renamed the variable to differentiate
mac80211/mvm link STA, but forgot to adjust the check. The one
from mac80211 is already non-NULL anyway, but the mvm one can
be NULL when the mac80211 isn't during link switch conditions.
Fix the check.

Fixes: 2783ab506eaa ("wifi: iwlwifi: mvm: select STA mask only for active links")
Reviewed-by: Daniel Gabay <daniel.gabay@intel.com>
Reviewed-by: Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c
index d9738fe6f967..bd1d6ad44648 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c
@@ -36,7 +36,7 @@ u32 iwl_mvm_sta_fw_id_mask(struct iwl_mvm *mvm, struct ieee80211_sta *sta,
 		mvm_link_sta =
 			rcu_dereference_check(mvmsta->link[link_id],
 					      lockdep_is_held(&mvm->mutex));
-		if (!link_sta)
+		if (!mvm_link_sta)
 			continue;
 
 		result |= BIT(mvm_link_sta->sta_id);
-- 
2.44.0


