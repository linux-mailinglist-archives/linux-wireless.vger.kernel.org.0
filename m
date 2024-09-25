Return-Path: <linux-wireless+bounces-13152-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DEDC985837
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Sep 2024 13:39:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BE94280DFD
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Sep 2024 11:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 184B8186614;
	Wed, 25 Sep 2024 11:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RGgfwOAW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E185218660A;
	Wed, 25 Sep 2024 11:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727264231; cv=none; b=joRzjLnzHt8QwF6F3QBizFLliHM+v3wDvULx3KajS3/v6KrQu0m2/rQrFRMepcPGODmxoq/ukt8+yq6YQk3UBSvl0e7l2NUKOyHbVHjSkxsH7jKXc1OCHYSTJ24Aj/EZd5Zl7kzLcEX2L4aLJ7Hp1RnPOFpT0DXX93qX1mpU9ZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727264231; c=relaxed/simple;
	bh=QDlngv21ViIIXjXW17K5p3hPzXrWomA1FOXV7dp3iJc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pOFkzJsxM0xJT4OcJjqAgs2Mp6x8a1tfU1C+zB3mb36bSsZIOGhp99gNqCw+xFeapT5PlP1SSmePWC6uMF68Q0W4sX7gybVvDzp0SL3raFpz2QAsrElZTWjn9agYzMtmj495BSwGiZ+TrsM9OU+1n+ewWjWXqplnk0jgPZy6/Yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RGgfwOAW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15C24C4CEC7;
	Wed, 25 Sep 2024 11:37:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727264230;
	bh=QDlngv21ViIIXjXW17K5p3hPzXrWomA1FOXV7dp3iJc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RGgfwOAWaOQEbZr3h5rpuB5Sb5IDwAmMbFewM7g7trFTBAF1FXfpHFM4GLBBqghRq
	 qUAEcm0N99mXzadlHt2Cr4V66aRpO04u7jTYxnx3PjJKq0Sq/NJfdH4NAHWTgNp4d4
	 gW2ACMCf5RfdfO2ldScApLDdPWK8+g5A3dffHjlBJV5tqHxlMaVHzphQL9Oq5lXMHb
	 cWwg9wrHNgoxxlBMnX1bN6jkrC4DqA+T1zYb/GCHO3cty7MFm5NeJE8y/Vqa113erT
	 TH5MOBFrv9SCass/K6WfLcrCRIYL2v6jCA8/qFF/odLnNL7cnWJt/H3+bC5moEc65w
	 QkrARFdwLgg5Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	kvalo@kernel.org,
	gregory.greenman@intel.com,
	emmanuel.grumbach@intel.com,
	ilan.peer@intel.com,
	shaul.triebitz@intel.com,
	benjamin.berg@intel.com,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.11 011/244] wifi: iwlwifi: mvm: drop wrong STA selection in TX
Date: Wed, 25 Sep 2024 07:23:52 -0400
Message-ID: <20240925113641.1297102-11-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925113641.1297102-1-sashal@kernel.org>
References: <20240925113641.1297102-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

[ Upstream commit 1c7e1068a7c9c39ed27636db93e71911e0045419 ]

This shouldn't happen at all, since in station mode all MMPDUs
go through the TXQ for the STA, and not this function. There
may or may not be a race in mac80211 through which this might
happen for some frames while a station is being added, but in
that case we can also just drop the frame and pretend the STA
didn't exist yet.

Also, the code is simply wrong since it uses deflink, and it's
not easy to fix it since the mvmvif->ap_sta pointer cannot be
used without the mutex, and perhaps the right link might not
even be known.

Just drop the frame at that point instead of trying to fix it
up.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Link: https://patch.msgid.link/20240808232017.45ad105dc7fe.I6d45c82e5758395d9afb8854057ded03c7dc81d7@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c    | 16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 625ccf566e1c2..1ebcc6417ecef 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -838,20 +838,10 @@ void iwl_mvm_mac_tx(struct ieee80211_hw *hw,
 	if (ieee80211_is_mgmt(hdr->frame_control))
 		sta = NULL;
 
-	/* If there is no sta, and it's not offchannel - send through AP */
+	/* this shouldn't even happen: just drop */
 	if (!sta && info->control.vif->type == NL80211_IFTYPE_STATION &&
-	    !offchannel) {
-		struct iwl_mvm_vif *mvmvif =
-			iwl_mvm_vif_from_mac80211(info->control.vif);
-		u8 ap_sta_id = READ_ONCE(mvmvif->deflink.ap_sta_id);
-
-		if (ap_sta_id < mvm->fw->ucode_capa.num_stations) {
-			/* mac80211 holds rcu read lock */
-			sta = rcu_dereference(mvm->fw_id_to_mac_id[ap_sta_id]);
-			if (IS_ERR_OR_NULL(sta))
-				goto drop;
-		}
-	}
+	    !offchannel)
+		goto drop;
 
 	if (tmp_sta && !sta && link_id != IEEE80211_LINK_UNSPECIFIED &&
 	    !ieee80211_is_probe_resp(hdr->frame_control)) {
-- 
2.43.0


