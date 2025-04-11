Return-Path: <linux-wireless+bounces-21441-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DFB9FA85A09
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Apr 2025 12:29:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07CCD8C27DD
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Apr 2025 10:29:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACF6A278E77;
	Fri, 11 Apr 2025 10:29:52 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailout3.hostsharing.net (mailout3.hostsharing.net [176.9.242.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F502278E4C
	for <linux-wireless@vger.kernel.org>; Fri, 11 Apr 2025 10:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.242.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744367392; cv=none; b=fASrClvZnaFzZ/PsZVbrnjDv0AlKXFj0dY6C5t2s4Egc15zQ1P7kXsF8z8PHcx6ypswLTbOzDs9Io8FXQJsWEHY+WUPpzPclh/0W+0Mwcq8jZBYJLuTJQlPr30kVSNoMAkLUkljB1JGYwi7ISufxhHwzNhkt3hUBZf80m7TtNlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744367392; c=relaxed/simple;
	bh=H14QcamuIK2+7caX1w/sNT4RUjaqzC9ImLX+b6wyggk=;
	h=Message-ID:From:Date:Subject:To:Cc; b=a3/0WisQf+LS1eweGjhsTVzSe6pC7U2ofTa/LX/cfVsIfBjYFC6nX83Mey+QullfdVS0uqquut6UFnv6eqxVhG5Foje157BH0/BzSyVjXc4dJufg5knHdmYbPDhiCk1XfM2ILvKBuG/l7qVZYdSYCal7lchURAzmh4HQ8K2l8Jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=176.9.242.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by mailout3.hostsharing.net (Postfix) with ESMTPS id 8E57F3005E16;
	Fri, 11 Apr 2025 12:21:08 +0200 (CEST)
Received: from localhost (unknown [89.246.108.87])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by h08.hostsharing.net (Postfix) with ESMTPSA id 59B9B6010C9C;
	Fri, 11 Apr 2025 12:21:16 +0200 (CEST)
X-Mailbox-Line: From d3ba1006a1b72ceb58c593fa62b9bd7c73e2e4ed Mon Sep 17 00:00:00 2001
Message-ID: <d3ba1006a1b72ceb58c593fa62b9bd7c73e2e4ed.1744366815.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Fri, 11 Apr 2025 12:21:05 +0200
Subject: [PATCH] wifi: iwlwifi: mld: Restart firmware on
 iwl_mld_no_wowlan_resume() error
To: Miri Korenblit <miriam.rachel.korenblit@intel.com>, Johannes Berg <johannes.berg@intel.com>, Emmanuel Grumbach <emmanuel.grumbach@intel.com>, Benjamin Berg <benjamin.berg@intel.com>, Yedidya Benshimol <yedidya.ben.shimol@intel.com>, Arnd Bergmann <arnd@arndb.de>, Avraham Stern <avraham.stern@intel.com>, Daniel Gabay <daniel.gabay@intel.com>, Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>, Shaul Triebitz <shaul.triebitz@intel.com>
Cc: linux-wireless@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>

Commit 44605365f935 ("iwlwifi: mld: fix building with CONFIG_PM_SLEEP
disabled") sought to fix build breakage, but inadvertently introduced
a new issue:

iwl_mld_mac80211_start() no longer calls iwl_mld_start_fw() after having
called iwl_mld_stop_fw() in the error path of iwl_mld_no_wowlan_resume().

Fix it.

Fixes: 44605365f935 ("iwlwifi: mld: fix building with CONFIG_PM_SLEEP disabled")
Reported-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Closes: https://lore.kernel.org/r/MW5PR11MB58106D6BC6403845C330C7AAA3A22@MW5PR11MB5810.namprd11.prod.outlook.com/
Signed-off-by: Lukas Wunner <lukas@wunner.de>
Acked-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/mac80211.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
index 0b5bc5abb82d..99e13cfd1e5f 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
@@ -475,8 +475,8 @@ static
 int iwl_mld_mac80211_start(struct ieee80211_hw *hw)
 {
 	struct iwl_mld *mld = IWL_MAC80211_GET_MLD(hw);
-	int ret;
 	bool in_d3 = false;
+	int ret = 0;
 
 	lockdep_assert_wiphy(mld->wiphy);
 
@@ -501,7 +501,7 @@ int iwl_mld_mac80211_start(struct ieee80211_hw *hw)
 		iwl_mld_restart_cleanup(mld);
 	}
 
-	if (!in_d3) {
+	if (!in_d3 || ret) {
 		ret = iwl_mld_start_fw(mld);
 		if (ret)
 			goto error;
-- 
2.43.0


