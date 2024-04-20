Return-Path: <linux-wireless+bounces-6601-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D98E8ABBD4
	for <lists+linux-wireless@lfdr.de>; Sat, 20 Apr 2024 15:44:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE549281768
	for <lists+linux-wireless@lfdr.de>; Sat, 20 Apr 2024 13:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 698281805E;
	Sat, 20 Apr 2024 13:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="ev3Qdbc/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3CB217C72
	for <linux-wireless@vger.kernel.org>; Sat, 20 Apr 2024 13:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713620690; cv=none; b=U2nwJckCOxo6He6940P+5jBswzm4BngSZSl6HeGeAyZacaRv6bTqpfi1yGHB0DP4+H4GxfBT0zLti+iK4PnDQh1CR9WCsKEAKJj1fCeK4of63iISN/PZbLNHctDQCJywimStY4iNaCbN6RyNj60M96s6UMOmZxvYbAohfaWHkKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713620690; c=relaxed/simple;
	bh=RhbpoDQu7dGjKu0YbieETI7Y60muw1VC+nLLDElU58E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=H6GLwAgyeF3K5RcbUNkuGKX/PIDiXRFdre+2K5XZ2+zI2nVl2fD+LqJA+PuDrQi8mWqPmDMT2l/GQBwIh0efZbr52JsNawTgEBVCILSDCTFA0OTDCJajP49Io/TZqJIF6U/MF1fJIXKwWCvyH7cVOFaHW+iMxTLYiv6N/I+UD9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=ev3Qdbc/; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=Ie079eXeRS6hxQiA+t2imb7PP/7IY1YSsUgdtPBvm0U=; t=1713620687; x=1714830287; 
	b=ev3Qdbc/kyzdrBXVVaXltZ0jMZzoqa8o0Gzfn6RBXDrKxaVVO34HAHod+7L5ynufl9IxEXJ150e
	hTd8xS5kOxz3E40aVw0tV3FBN1/jpOrLJDxt1nRRiRSlKyp5NLDAGB3sMRkRFjd1hK//p8Nh7xIi0
	fIYTTihP2pN5nPcKG8/3Aaef8V+T/yIrYBMSrDYUrkWbFOR4NqezMyMUBapM4p4vPSEI7jqzw1r9u
	VebY/1x/pR3zXIJKyNbVMJTl3cxst03l2UTpXYP3q6Cbja+RUIt0bjIGGnKxIGRrYmATlK19dMro0
	6SFRWoK3vONpnQ6N468XQS7SNsTMXwk5BXAQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1ryB1C-0000000FlMr-0pNB;
	Sat, 20 Apr 2024 15:44:38 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] wifi: iwlwifi: mvm: fix link ID management
Date: Sat, 20 Apr 2024 15:44:36 +0200
Message-ID: <20240420154435.dce72db5d5e3.Ic40b454b24f1c7b380a1eedf67455d9cf2f58541@changeid>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

On older (pre-MLD API) devices, we started also calling
iwl_mvm_set_link_mapping()/iwl_mvm_unset_link_mapping(),
but of course not also iwl_mvm_remove_link(). Since the
link ID was only released in iwl_mvm_remove_link() this
causes us to run out of FW link IDs very quickly. Fix
it by releasing the link ID correctly.

Fixes: a8b5d4809b50 ("wifi: iwlwifi: mvm: Configure the link mapping for non-MLD FW")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/link.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/link.c b/drivers/net/wireless/intel/iwlwifi/mvm/link.c
index 9f69e04594e4..fe5bba8561d0 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/link.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/link.c
@@ -279,6 +279,7 @@ int iwl_mvm_unset_link_mapping(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 
 	RCU_INIT_POINTER(mvm->link_id_to_link_conf[link_info->fw_link_id],
 			 NULL);
+	iwl_mvm_release_fw_link_id(mvm, link_info->fw_link_id);
 	return 0;
 }
 
@@ -296,7 +297,6 @@ int iwl_mvm_remove_link(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 		return 0;
 
 	cmd.link_id = cpu_to_le32(link_info->fw_link_id);
-	iwl_mvm_release_fw_link_id(mvm, link_info->fw_link_id);
 	link_info->fw_link_id = IWL_MVM_FW_LINK_ID_INVALID;
 	cmd.spec_link_id = link_conf->link_id;
 	cmd.phy_id = cpu_to_le32(FW_CTXT_INVALID);
-- 
2.44.0


