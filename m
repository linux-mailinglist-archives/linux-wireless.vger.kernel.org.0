Return-Path: <linux-wireless+bounces-4540-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 32291877AEF
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Mar 2024 07:29:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C68141F2150F
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Mar 2024 06:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2574612E49;
	Mon, 11 Mar 2024 06:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QU5uMoJm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93BDB12E48
	for <linux-wireless@vger.kernel.org>; Mon, 11 Mar 2024 06:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710138525; cv=none; b=SQKqJIir3ESy5QMmyqLWt1wrB/9A4AVkXLOgAnT3ZgTPo6QI3i5t+mVBaeMZYRz6IXw+BoO36EMm0lbAac6xugLddZzlYvyyYs1tE3qsi54hM/ISUOvLg2vKIpALwDOUFD6ywemEuJ5WCg4WuCJQ3GL8ekXjyrCG5FyHco/yvZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710138525; c=relaxed/simple;
	bh=L5l83wYKvSAVVgU1aT5L5DhD8vP3TeictaLJN4VarOM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Z3udV/uGgt/fmJQ9EzLDBZHWg9jADvj/D5qszkmyh7wXkZS/IGp9DDs5FCef6CFPl1EYZszRrdY8fewGRud6DtwaHe4EJNXDinFTlf/75gnqR+zA32TQ+I+nykZxF7AQyXbM4ux00hgvYnI325Vp7kjeKpDgscV15L7q1Zbb+AY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QU5uMoJm; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710138524; x=1741674524;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=L5l83wYKvSAVVgU1aT5L5DhD8vP3TeictaLJN4VarOM=;
  b=QU5uMoJmhUnaoIuV72dJ1/A9D2jS4DX2UKIMPHkJis0sY+0cxt49/kbX
   0984EhF+2kqa7tRzODI0FZgeWDwznuoLwVghLfWkYg4VgzeMwvJgHZZwD
   0CTKcU4ua0Fwdez9TO4b02dT3dZPjjgtVjPR6uQO6RbGHRt/kfq7+7J/8
   T8IAZz2N8tERArgB9DkBWTSVC6c/ajpenoJpKf04KjIhqXtT5qt13pliA
   A/jRx7d9nCml3jOGoHMnt5emReHQ0EsfXv7szc6McJHOOc0VCDw6AOGrn
   NCx+s2rpwwF6fDBkEix77Gqn5+Uf4OE8G8I8yScpPBWb1vjkFSKGwdm+3
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11009"; a="30226776"
X-IronPort-AV: E=Sophos;i="6.07,115,1708416000"; 
   d="scan'208";a="30226776"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2024 23:28:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,115,1708416000"; 
   d="scan'208";a="15657693"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2024 23:28:42 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Shaul Triebitz <shaul.triebitz@intel.com>
Subject: [PATCH 08/15] wifi: iwlwifi: mvm: skip keys of other links
Date: Mon, 11 Mar 2024 08:28:08 +0200
Message-Id: <20240311081938.fdf527b50d61.I605a971d2d68107769dd363b896b471998259e64@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240311062815.4099838-1-miriam.rachel.korenblit@intel.com>
References: <20240311062815.4099838-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Shaul Triebitz <shaul.triebitz@intel.com>

When waking up from wowlan, we iterate over the current
keys and remove those that were rekeyed.
With MLO, there might be keys of other links which should
not be removed.
Skip MLO keys on other links (other than the wowlan
active link).

Signed-off-by: Shaul Triebitz <shaul.triebitz@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
index 5ee27e268295..7ee3d6fa4526 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
@@ -1824,6 +1824,10 @@ static void iwl_mvm_d3_find_last_keys(struct ieee80211_hw *hw,
 				      void *_data)
 {
 	struct iwl_mvm_d3_gtk_iter_data *data = _data;
+	int link_id = vif->active_links ? __ffs(vif->active_links) : -1;
+
+	if (link_id >= 0 && key->link_id >= 0 && link_id != key->link_id)
+		return;
 
 	if (data->unhandled_cipher)
 		return;
@@ -1912,6 +1916,10 @@ static void iwl_mvm_d3_update_keys(struct ieee80211_hw *hw,
 	struct iwl_mvm_d3_gtk_iter_data *data = _data;
 	struct iwl_wowlan_status_data *status = data->status;
 	s8 keyidx;
+	int link_id = vif->active_links ? __ffs(vif->active_links) : -1;
+
+	if (link_id >= 0 && key->link_id >= 0 && link_id != key->link_id)
+		return;
 
 	if (data->unhandled_cipher)
 		return;
-- 
2.34.1


