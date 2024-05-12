Return-Path: <linux-wireless+bounces-7511-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BB2618C3502
	for <lists+linux-wireless@lfdr.de>; Sun, 12 May 2024 06:31:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F0BDB2117F
	for <lists+linux-wireless@lfdr.de>; Sun, 12 May 2024 04:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACA26D51E;
	Sun, 12 May 2024 04:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cBfHGBuW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3438BC14F
	for <linux-wireless@vger.kernel.org>; Sun, 12 May 2024 04:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715488288; cv=none; b=i6rnMRC4nA9C7DCNXk+phWrx4V2j8d+tUXeXFhieAaKpCJAkjRp9kOti3AwullwjMsKNnBDcm9Auvj7eT6Z4NghON8n1gaIuEVoTtNmvoAiyH4nHxlBAWMHNvn330xHTMFbd6iz9dpYM8yd39imrK5uUqSg3b5tGMVtAMgzqrz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715488288; c=relaxed/simple;
	bh=kHGC2FdNe6QuUU6MWeBKs+jtl72d1udgQBlnHpLO800=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MDapgekkhBEudkhYGM4FLETUEsJGnjb1R+2Y1rQzAOT0Jvvqc7oDh6m7oU6XdadOOnDeJhqibG4w/dM5A0T4Uf6zn+XwborXfblAT97xdxHm1Msxtv2Be6UuqXwH/XN9QLOvcDF7LTFmPa6m7Wkg87Sz6onv2zBnFkMAVPKOdgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cBfHGBuW; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715488286; x=1747024286;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=kHGC2FdNe6QuUU6MWeBKs+jtl72d1udgQBlnHpLO800=;
  b=cBfHGBuWnzFNtuz7/XjqopQxd4xZPPwV1D7wcfquqJvXSTpWRKnS7VVt
   EZ+eBxIHLIu6Sud8jSZwYMkqSKirfi0kGn1e///UVDu8mbBagBiPZ/XjK
   6pQjkV67KuyyjDtUbeuZi7piq6pY6SXmcbUfwlm+8HOZIs83nT1YOrPQE
   WvNb+tVsaYzQ2FpALmlMSJ3l4y5Ru9rG8+YOgSIZ0CeW0HEV2u99BDQ2C
   6GsvDaCM37nz/1D4DGdW4Xi44I7JOBol3fyW6AG68c9vIadNDhjKj+qYJ
   vSRY341GKmWprf/bgwukV5vmXO6ZcHg3jfn9TiCvjlcy18yaTUZuF97y5
   g==;
X-CSE-ConnectionGUID: U20MJQhdT3uYXLk4/JfJEw==
X-CSE-MsgGUID: wCBYo7+eRECeqa+r8ZBAzg==
X-IronPort-AV: E=McAfee;i="6600,9927,11070"; a="11323831"
X-IronPort-AV: E=Sophos;i="6.08,155,1712646000"; 
   d="scan'208";a="11323831"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2024 21:31:26 -0700
X-CSE-ConnectionGUID: 6Is5YCEJQWCpvX8uWhycew==
X-CSE-MsgGUID: acuAxoUvTYS8HrAC4l2AHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,155,1712646000"; 
   d="scan'208";a="34532142"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2024 21:31:24 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH 00/16] wifi: iwlwifi: updates - 2024-05-12
Date: Sun, 12 May 2024 07:30:54 +0300
Message-Id: <20240512043110.3413383-1-miriam.rachel.korenblit@intel.com>
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

This patch set includes iwlwifi patches. It contains a few features,
bugfixes and cleanups.

Thanks,
Miri

Benjamin Berg (2):
  wifi: iwlwifi: mvm: remove stale STA link data during restart
  wifi: iwlwifi: mvm: use vif P2P type helper

Emmanuel Grumbach (3):
  wifi: iwlwifi: mvm: leave a print in the logs when we call fw_nmi()
  wifi: iwlwifi: always print the firmware version in hex
  wifi: iwlwifi: mvm: fix a crash on 7265

Johannes Berg (4):
  wifi: iwlwifi: mvm: mark bad no-data RX as having bad PLCP
  wifi: iwlwifi: mei: unify iwl_mei_set_power_limit() prototype
  wifi: iwlwifi: fw: avoid bad FW config on RXQ DMA failure
  wifi: iwlwifi: mvm: don't track used links separately

Miri Korenblit (5):
  wifi: iwlwifi: mvm: don't always set anttena in beacon template cmd
  wifi: iwlwifi: mvm: Use the SMPS cfg of the correct link
  wifi: iwlwifi: mvm: add a of print of a few commands
  wifi: iwlwifi: bump FW API to 91 for BZ/SC devices
  wifi: iwlwifi: mvm: disable dynamic EMLSR when AUTO_EML is false

Mukesh Sisodiya (1):
  wifi: iwlwifi: fw: api: Add new timepoint for scan failure

Yedidya Benshimol (1):
  wifi: iwlwifi: mvm: Handle BIGTK cipher in kek_kck cmd

 drivers/net/wireless/intel/iwlwifi/cfg/bz.c   |  2 +-
 drivers/net/wireless/intel/iwlwifi/cfg/sc.c   |  2 +-
 .../wireless/intel/iwlwifi/fw/api/dbg-tlv.h   |  7 ++++
 drivers/net/wireless/intel/iwlwifi/fw/init.c  |  7 +++-
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c  | 14 ++-----
 .../net/wireless/intel/iwlwifi/mei/iwl-mei.h  |  4 +-
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c   | 13 ++++++-
 .../net/wireless/intel/iwlwifi/mvm/debugfs.c  |  2 +
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c   |  6 +--
 drivers/net/wireless/intel/iwlwifi/mvm/link.c | 31 +++++++---------
 .../net/wireless/intel/iwlwifi/mvm/mac-ctxt.c |  9 +++--
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c | 37 +++++++++++++++++++
 .../net/wireless/intel/iwlwifi/mvm/mld-sta.c  | 12 +++---
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  1 -
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c  | 25 +++++++++++++
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c |  9 +++--
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c |  4 +-
 drivers/net/wireless/intel/iwlwifi/mvm/sta.h  |  5 +++
 18 files changed, 135 insertions(+), 55 deletions(-)

-- 
2.34.1


