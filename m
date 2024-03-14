Return-Path: <linux-wireless+bounces-4740-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F5D187BAFF
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Mar 2024 11:10:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF51F2815C5
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Mar 2024 10:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B29F66DCE3;
	Thu, 14 Mar 2024 10:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="VoCCJJpR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E996D1C8;
	Thu, 14 Mar 2024 10:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710411008; cv=none; b=d1I03EufI5FaHyqcEiRAcVrFRT45EFbIPP4TLtNp7DMByAMdkR+5LPvprPpjq/t26uI7KOAb+O6NWs3BbLamQMoupUvQws4P3x89cXXE/+ZHOZy+A6uOlcyuIfx/0aTmaDQ/GiYdszyr7OEGS7l12pxWlQhwbTKTJwuAGMHSu+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710411008; c=relaxed/simple;
	bh=ySDz11gRP28auks7fj5AC4J0V+PhZ+YcgZc3uVR/92U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sZQypKCw//myJ+RD6qm1L87xFFOzwtFdxlSEYPcrj74UEcYN39xizdFYPlxa53oTgbO27FHS6La69jCucQHCajPRHC+ErPS7W/aXP1b4WD7IpErTxR9/zQ9+Wqf97A7o6GrLGfJggG3y1SSc2PKHfTaIJmCIwB6ANO3DbM11jlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=VoCCJJpR; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=R+dG/F9SAS74F0UmnSYaQKCAoX4nYEm4hmGAbe+Pwg0=;
	t=1710411006; x=1711620606; b=VoCCJJpRmuJA1fRgHS+9tf1x7iZmJSO3jLux2mosn73AxRm
	ZZYSqbz1YjyOL93esFJYM5J81CltpaG6uHJcKe/ghoGsWJsgBOePADl5xBp/IJOy8nq+pSNXxng6y
	K/AJrcAQGmwKikGaSppXYIXp22kWRaV8O+aoj2N3Kfhtw7C4upoJrsz7dk8T0gO9EQWgjqctvqenp
	jE7QZXXfLuTe8w2x7jJQ4vaof7L5I9Yzfsk4jtzfhuMTOd9OJ1bf9g7O81iTJH4xU2auYKAezAXFj
	oLQW6vj4x82/mVRgsMkmMDDiBAOxQg6ZqdfS61/AX5RuGOMHeUM/FjAFHHB2i4bA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rki2A-0000000GUPO-1oHk;
	Thu, 14 Mar 2024 11:09:58 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	stable@vger.kernel.org,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>
Subject: [PATCH 2/2] wifi: iwlwifi: mvm: disable MLO for the time being
Date: Thu, 14 Mar 2024 11:09:52 +0100
Message-ID: <20240314110951.d6ad146df98d.I47127e4fdbdef89e4ccf7483641570ee7871d4e6@changeid>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240314110951.b50f1dc4ec21.I656ddd8178eedb49dc5c6c0e70f8ce5807afb54f@changeid>
References: <20240314110951.b50f1dc4ec21.I656ddd8178eedb49dc5c6c0e70f8ce5807afb54f@changeid>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

MLO ended up not really fully stable yet, we want to make
sure it works well with the ecosystem before enabling it.
Thus, remove the flag, but set WIPHY_FLAG_DISABLE_WEXT so
we don't get wireless extensions back until we enable MLO
for this hardware.

Cc: stable@vger.kernel.org
Reviewed-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 1935630d3def..69227954e281 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -360,7 +360,7 @@ int iwl_mvm_mac_setup_register(struct iwl_mvm *mvm)
 	if (mvm->mld_api_is_used && mvm->nvm_data->sku_cap_11be_enable &&
 	    !iwlwifi_mod_params.disable_11ax &&
 	    !iwlwifi_mod_params.disable_11be)
-		hw->wiphy->flags |= WIPHY_FLAG_SUPPORTS_MLO;
+		hw->wiphy->flags |= WIPHY_FLAG_DISABLE_WEXT;
 
 	/* With MLD FW API, it tracks timing by itself,
 	 * no need for any timing from the host
-- 
2.44.0


