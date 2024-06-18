Return-Path: <linux-wireless+bounces-9215-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A73F290DA2E
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Jun 2024 19:03:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C7E3284A18
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Jun 2024 17:03:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3170545BF0;
	Tue, 18 Jun 2024 17:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q4BqAlog"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DBA5446DE
	for <linux-wireless@vger.kernel.org>; Tue, 18 Jun 2024 17:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718730193; cv=none; b=IfZSGIHKvhFxTEIBmZR5OW3fWXv8bcLNBblkiSh07VoYQTCPSnJiKTxERM3iWIu3gUg/P04wDupIHJ7s30sFVfSNNxboE7C0lF3z0howqHFi/zRu/LYFu+FtLh65MAldC6gSTLwEk3Y4dWEvoEm7G/ULAeUrVqfIyL8XcmKECgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718730193; c=relaxed/simple;
	bh=BDRHj37q6mcCXE7un2oXIkPsTZZcmatPyTnKLfnypr0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=U8pK3sNYyP1wc5zr3dbKo5rH9eFt+MFoa5U/aIBXc5XO5Ear3BXqsOpiczHkYSyYg6pRTao31IHh1rtbCg8qIDd7fdXNKMe8ZIKv3cl5c2FuoVXUCaFhk+ob7dMnb0ghG1CQ6hR5kulmRVjh4YY3si+de64+oGjiSTTjr2FGsgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q4BqAlog; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718730191; x=1750266191;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=BDRHj37q6mcCXE7un2oXIkPsTZZcmatPyTnKLfnypr0=;
  b=Q4BqAlogF3Fe9U8yYDOUNKrG+m0WAfwBTUtyD5U5K+X/0WV+Ep9BY/wC
   fmv4+a339YzzfoN+Bd4YkxAxtUHDE2JvqXl2QeQtrMC6R9fWTnLHL1b4+
   nY/6EyywSQRzhbkqTuEOOVWjo/383fuf3lSlNG/Cq6YQzHs6YMA7Qk2PF
   vIy/61MeSxuGCJm4/S2oxb3AtpRSsAWhixdXkK4RyT6CmwoNSzYD7gGkE
   dIr5+e70YQvsxNibqmf2WxMaE4YmuTEWeRihWUN7uIiX9sSLjfp6m6ayn
   uT/xrw8AADf99I7Bs2B6PWad0NKdOnF7OYdWOSEq5nHMJr19fgJCqyd+4
   g==;
X-CSE-ConnectionGUID: 71RRxOlyTPeCFZzZjvxLNw==
X-CSE-MsgGUID: FDBgfUXBQFKV2Rz09Zh7EQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11107"; a="33093988"
X-IronPort-AV: E=Sophos;i="6.08,247,1712646000"; 
   d="scan'208";a="33093988"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2024 10:03:11 -0700
X-CSE-ConnectionGUID: AOo10jrwR82QGmeBzF/lMA==
X-CSE-MsgGUID: EdoufoUIQHqXUpC3YnvVvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,247,1712646000"; 
   d="scan'208";a="46541777"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2024 10:03:10 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
Subject: [wireless PATCH 0/3] wifi: iwlwifi: bugfixes - 18-06-24
Date: Tue, 18 Jun 2024 20:03:00 +0300
Message-Id: <20240618170303.2438911-1-miriam.rachel.korenblit@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

Hi,

This patch set contains a few bugfixes.

Thanks,
Miri


Daniel Gabay (1):
  wifi: iwlwifi: fix iwl_mvm_get_valid_rx_ant()

Emmanuel Grumbach (1):
  wifi: iwlwifi: pcie: fix a few legacy register accesses for new devices

Johannes Berg (1):
  wifi: iwlwifi: mvm: unify and fix interface combinations

 drivers/net/wireless/intel/iwlwifi/iwl-io.c   |  4 +-
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c | 43 ++++++++++++-------
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  4 +-
 .../net/wireless/intel/iwlwifi/pcie/trans.c   | 22 +++++++---
 4 files changed, 49 insertions(+), 24 deletions(-)

-- 
2.34.1


