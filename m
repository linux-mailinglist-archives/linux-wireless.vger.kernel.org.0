Return-Path: <linux-wireless+bounces-13193-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 795A8985E70
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Sep 2024 15:35:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 899A71C253FF
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Sep 2024 13:35:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E35C61D0419;
	Wed, 25 Sep 2024 12:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UwwDH1LV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B83641D0414;
	Wed, 25 Sep 2024 12:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727266321; cv=none; b=d+w+XIIe6HBDeyx4MChWRoub2fVLjqFnr6CjwdvK3LMbCCwpc1XXkVhKB8OTNAVsRoD/igdvJQKCDJ0FTo3FLYEfj6Dzhlt6IJtctYwcZZObiEyAGyy/xsteca0wZLork5uPncBKQRH9Abg2aq/8/ZAVRWlWNV+jyl5s148GKHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727266321; c=relaxed/simple;
	bh=TYxnkDvOyad4YxDihbQO+h0oUGrPysRaxOV8/rS5H3I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uD5pOh5SlCw1IDptSzQ5cu8e/BBX2H7xATc09bM8hrgWONdm60o0zPE8DR1UXE+8vuNsNOb86JbZ9wyzemvuMq739KDLPhjADaDqDCaplf5SlksMl4VGkImQF103ejhhs4wPqkiDX+YpL6HNb5Cm5+9IJFBaRBR0xg5h/IX74UI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UwwDH1LV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A688C4CEC3;
	Wed, 25 Sep 2024 12:12:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727266321;
	bh=TYxnkDvOyad4YxDihbQO+h0oUGrPysRaxOV8/rS5H3I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UwwDH1LVnIb85CT4tRnZiNNrXD3NbHG2kqooKkFUFoL3bcMzL+4Dmm0YwnFzzB1JY
	 4P2NpHgZ/rfUzX6d2o3tcG2O3HIGSJ7o78+viu1AKWQ+jDdWBp25vBOxNTdIHvVTvI
	 SIfa5falRNT7os+Tneorh1RKeUBOqpd2S/nCRcPyRpkypH/owJo/HHJwgT8fE0QeQW
	 +V2BoEltcoLNFSAI9p3VgpLEKixGAIm0Cr5y/QO97edXF+ZNZjAFtBn+vSUL/OAGkA
	 cCU3Wx4yinpZKfNwfW1MCMkVeLjLa8KoZ+2/2iqB/rUjeTUxSmUn/AGe5jektMkW9o
	 EBqMZn45VwM+A==
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
Subject: [PATCH AUTOSEL 6.6 009/139] wifi: iwlwifi: mvm: drop wrong STA selection in TX
Date: Wed, 25 Sep 2024 08:07:09 -0400
Message-ID: <20240925121137.1307574-9-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925121137.1307574-1-sashal@kernel.org>
References: <20240925121137.1307574-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.52
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
index f973efbbc3795..c6264ff10d883 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -766,20 +766,10 @@ void iwl_mvm_mac_tx(struct ieee80211_hw *hw,
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


