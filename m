Return-Path: <linux-wireless+bounces-7187-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 327578BBF75
	for <lists+linux-wireless@lfdr.de>; Sun,  5 May 2024 08:20:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 558B01C20AE1
	for <lists+linux-wireless@lfdr.de>; Sun,  5 May 2024 06:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91135AD32;
	Sun,  5 May 2024 06:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h1AaobuQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B8706FB9
	for <linux-wireless@vger.kernel.org>; Sun,  5 May 2024 06:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714890030; cv=none; b=W9iGu/XiTp9TO5wGzl9vnykB7mPj5V9ck2bx3fsaIiy8xabEkYp9k8l5W9urqMSq1JqAaf5C1mCwgLAcuuXnxS0AnwyD+/OR62nSSOf3sp3V/OKEO0+j8ciiZlfKJG0bKwjDq0gnKZCdbjH+bqnMpjjpFnROF/ngo4Z1qHI1ZR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714890030; c=relaxed/simple;
	bh=XShRLm5EvFM3vQ4Kpn4WVXyIfB16VncYCzrERvcQbVk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TpLPcqf1RsbyNhxA+v4Dnv8CuhMvHo5EHH4mmnkBDwsgTkWcd9OOLDO6/KZKEIlBjff9WvNnsDpYNlVBMRAEpH6j9m6md+9vuVRwCkJ1G81ChSGOcBYw+T5qJCfTk/HCS37NlR80Q5TqzUZvLGKIi9VV1/z7BsQcDU//vWOir/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h1AaobuQ; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714890029; x=1746426029;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XShRLm5EvFM3vQ4Kpn4WVXyIfB16VncYCzrERvcQbVk=;
  b=h1AaobuQvWhuRgiigpoaxPQSi6bniwLoDoeYRqHJ3dKIHmLleli+ni9b
   qhhtzM9d+qqCnRsWIOYKe1AdGBRt+54j4YKy/Se2qwZuJg60ofm65jwl8
   /I/AQ6JAxwTZbLcXo7r+xI2M6hvGA4n91uLRJjYejTX1prVJciF7fvEBz
   gRbuZauq1pJN3LbQH+QQxvzoRIK13XbuvJCz65yqTkbGXXOx95QlwXrXz
   Bj9q58dIk5BW+tdkH0FY2oOjMWK5PiwwzZp55cHl4uRI8kiH2VndGmD6E
   SGpfKge1MY7/2T35jfq0IwIjn505qhzPAqj7PbJ5DhnCOqE9NuMzw7ae6
   g==;
X-CSE-ConnectionGUID: /EuMkwnBS6GciuMoJIRiAg==
X-CSE-MsgGUID: NVkiKukQSmOmy8DGQ7BIKg==
X-IronPort-AV: E=McAfee;i="6600,9927,11063"; a="14461823"
X-IronPort-AV: E=Sophos;i="6.07,255,1708416000"; 
   d="scan'208";a="14461823"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2024 23:20:29 -0700
X-CSE-ConnectionGUID: LsBlShIiSAquzgDaTF/6Lw==
X-CSE-MsgGUID: 8OxpTaV0TOucDv+TEhPdvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,255,1708416000"; 
   d="scan'208";a="27903615"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2024 23:20:28 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH 09/15] wifi: iwlwifi: mvm: avoid always prefering single-link
Date: Sun,  5 May 2024 09:19:53 +0300
Message-Id: <20240505091420.4614e6891dbd.Ie40eae0dd99d82ba60dea5b6dbcd42dcdf16b90d@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240505061959.825245-1-miriam.rachel.korenblit@intel.com>
References: <20240505061959.825245-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

The new link selection algorithm uses defaults values for BSS load if
the BSS Load element was not published by the AP.
For 6 GHz, that value is 0. So if the best link is 6 GHz, the EMLSR
grade to always be equal to the grade of the best link,
and then the best link grade is getting a bonus of 10 percent, meaning
that we will never activate EMLSR.
Change the logic to not give a bonus for the best link.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/link.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/link.c b/drivers/net/wireless/intel/iwlwifi/mvm/link.c
index 79f048f54a21..9d7f9e5be253 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/link.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/link.c
@@ -727,8 +727,8 @@ void iwl_mvm_select_links(struct iwl_mvm *mvm, struct ieee80211_vif *vif)
 	if (hweight16(new_active_links) <= 1)
 		goto set_active;
 
-	/* prefer single link over marginal eSR improvement */
-	if (best_link->grade * 110 / 100 >= max_esr_grade) {
+	/* For equal grade - prefer EMLSR */
+	if (best_link->grade > max_esr_grade) {
 		primary_link = best_link->link_id;
 		new_active_links = BIT(best_link->link_id);
 	}
-- 
2.34.1


