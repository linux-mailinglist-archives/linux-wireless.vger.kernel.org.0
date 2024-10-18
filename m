Return-Path: <linux-wireless+bounces-14213-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19C799A421E
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Oct 2024 17:18:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C43DE1F244B3
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Oct 2024 15:18:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12D4B1F429A;
	Fri, 18 Oct 2024 15:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QnYy+T5k"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D809823D2;
	Fri, 18 Oct 2024 15:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729264727; cv=none; b=rQjXyqTsA/1YK1IFJ2F4LOTiPGmjX5BU4WR0SEGaQs5Re00nsHGM6hy66Xhwnli+jo4mOni9Syp2VwaLChH/G+vYNtDWov8neYnxTslpXJXCiERO40uHVO5Z3W/opRYIoBF8vie7LrJEtdqXBYCOISGnEU878kYlcBJpHm9X6ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729264727; c=relaxed/simple;
	bh=Dl9FBwnKZ8zZNjnDzm0pCGqQQga7fV358IucvehV1Ko=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fheHUP91s0PkPKn/JhPDoLjeLsu0liZdl39YWHWd9g2z350w6ggHz58HNLTrqi2AbEY74PImVuuFfZLLwS/iLT3vNIeBdPa1Fw6teHhDE497GsD5kmToWUgRk7Lo/R5Px/eDLBX9Ius9BrVKRXsGIEaMsRMbGl8dtwnEZdzpXVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QnYy+T5k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 261E4C4CEC3;
	Fri, 18 Oct 2024 15:18:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729264726;
	bh=Dl9FBwnKZ8zZNjnDzm0pCGqQQga7fV358IucvehV1Ko=;
	h=From:To:Cc:Subject:Date:From;
	b=QnYy+T5kav249Tu3+CTKHsU6puEDJ5Elc2VjWoxr+t5K3Mx9zFSy5PiX5k4VBCyMb
	 ac6U+uI9SUFph/uZxpyTTO4Jb7BudqvCeK6MwjV0ehr4txAeb716oFONwoskmxcshf
	 cVuPLRcl8pRbCVmwM9+tGmo0MWr3rM6YhZifrpf7h8VyfcL0nBsWeAhPG9mkYXi6mH
	 JQcpbafdGHkwMreUGr2z8wyxYDg//DlNBx/NRtWE8+ewpHoXnTmlZq07E7lyWomkrj
	 9s/Rlk7IVfCXDDRVGHhHPwt/XSRvocR8lOtWIaoWmwmbNAmRFFZ4d2JfrMM3D3W1lL
	 uf0Wn7skkLliQ==
From: Arnd Bergmann <arnd@kernel.org>
To: Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Kalle Valo <kvalo@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Johannes Berg <johannes.berg@intel.com>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	Gregory Greenman <gregory.greenman@intel.com>,
	Daniel Gabay <daniel.gabay@intel.com>,
	Benjamin Berg <benjamin.berg@intel.com>,
	Ilan Peer <ilan.peer@intel.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] iwlwifi: work around -Wenum-compare-conditional warning
Date: Fri, 18 Oct 2024 15:18:34 +0000
Message-Id: <20241018151841.3821671-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

This is one of only three -Wenum-compare-conditional warnings we get
in randconfig builds:

drivers/net/wireless/intel/iwlwifi/mvm/sta.c:4331:17: error: conditional expression between different enumeration types ('enum iwl_fw_sta_type' and 'enum iwl_sta_type') [-Werror,-Wenum-compare-conditional]
 4331 |         u32 type = mld ? STATION_TYPE_PEER : IWL_STA_LINK;
      |                        ^ ~~~~~~~~~~~~~~~~~   ~~~~~~~~~~~~

This is a false positive since the code works as intended, but the
warning is otherwise sensible, so slightly rewrite it in order to
not trigger the warning.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
I also tried a more complex approach of splitting the function into
two separate ones, since the 'mld' behavior is already quite different
from the other path. The version I post here ended up looking simpler
to me, but I can also send the other one if the maintainers prefer.
---
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
index b6c99cd6d9e5..9d05c344d967 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
@@ -4328,7 +4328,10 @@ int iwl_mvm_add_pasn_sta(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 	unsigned int wdg_timeout =
 		iwl_mvm_get_wd_timeout(mvm, vif);
 	bool mld = iwl_mvm_has_mld_api(mvm->fw);
-	u32 type = mld ? STATION_TYPE_PEER : IWL_STA_LINK;
+	u32 type = IWL_STA_LINK;
+
+	if (mld)
+		type = STATION_TYPE_PEER;
 
 	ret = iwl_mvm_allocate_int_sta(mvm, sta, 0,
 				       NL80211_IFTYPE_UNSPECIFIED, type);
-- 
2.39.5


