Return-Path: <linux-wireless+bounces-21761-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF538A9474B
	for <lists+linux-wireless@lfdr.de>; Sun, 20 Apr 2025 11:02:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA8863B4BC0
	for <lists+linux-wireless@lfdr.de>; Sun, 20 Apr 2025 09:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E42418DB0A;
	Sun, 20 Apr 2025 09:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="deXvi3cc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 475562AD14
	for <linux-wireless@vger.kernel.org>; Sun, 20 Apr 2025 09:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745139726; cv=none; b=RRvoJqm1J4fpA25uql0qxsGFq8G8F/t9izWcimKRELLmTfQyQuXrljT2g0d0Lj9It4JThzi3QdidH0szVlX5Dvep7DLfRajHwQ0B24lxifk5ell0HTeu113DZbxKkLVHJQjY/nwQYWeAzwa1EGyPmuPFemX+3jpcn09nuA07pNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745139726; c=relaxed/simple;
	bh=rP9batdfcHKHJ1vg/DFVmnBRQIlfUNhSpuUxiQlqo7c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HTY9MZBlBe7WKEyrXKnAQiyRqqUXQ8NLMP8AilHAJuGE4LxxXAWKVvRDMVDPAuoSqDiNvpGx9ROR4B6XIdmgX8PBt+3/eM+0y1u/gZno95B+0cMKBkIvBcboHsvzKsN7ZrCGyGtOVGkJOUi3gRUcqFfZ8VpGTz3EQ7zEv+AKQ5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=deXvi3cc; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745139724; x=1776675724;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=rP9batdfcHKHJ1vg/DFVmnBRQIlfUNhSpuUxiQlqo7c=;
  b=deXvi3cc9dshDmRWWujH7oGSI3y5asybC5JNTxCXzcAgxf8SJQl7uLln
   FeLz+3/uoyE0rOosFPZIgqD9xMW+weHNadDfZXXDP7TqJX/gvLpT6tCi4
   9rRzly9qajwbC6+ckxfHikJIejkocTJuIrSk9fOQ6J9UMN0akgPurfeio
   0PPTJ1d4v9Z9UVG2sS593QXx/aBx/6T5lkiFXxo7LbHtnt096BUm37vDE
   Q6E7NcndpJhgiOV7PJ8lv5GmkZMSEwLhA4PaqvitSCCtbzgwDpod8s0jp
   ofcA2DhVK5W8+zpIXuQVq70nxnbIUrJh3j9wxw/6akmMDOk+KlZ2I5ALK
   w==;
X-CSE-ConnectionGUID: Z5+VHQtkR++Ij7IKl7KmNw==
X-CSE-MsgGUID: 7Q1dhwtrRhSd2ojtMVmk3Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11408"; a="56880470"
X-IronPort-AV: E=Sophos;i="6.15,225,1739865600"; 
   d="scan'208";a="56880470"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2025 02:02:04 -0700
X-CSE-ConnectionGUID: tthD1TETRGy5ouhivZMIlQ==
X-CSE-MsgGUID: VGOZaF2URH+UoD7ZmRpeQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,225,1739865600"; 
   d="scan'208";a="136632845"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2025 02:02:02 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH wireless 0/2] wifi: iwlwifi: fix probe failure
Date: Sun, 20 Apr 2025 12:01:48 +0300
Message-Id: <20250420090150.3508273-1-miriam.rachel.korenblit@intel.com>
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

This series reverts the patches that caused a probe failure,
until it will properly be fixed.

Miri Korenblit (2):
  Revert "wifi: iwlwifi: add support for BE213"
  Revert "wifi: iwlwifi: make no_160 more generic"

 drivers/net/wireless/intel/iwlwifi/cfg/sc.c   |   2 -
 .../net/wireless/intel/iwlwifi/iwl-config.h   |  16 +-
 .../wireless/intel/iwlwifi/iwl-nvm-parse.c    |  16 +-
 .../net/wireless/intel/iwlwifi/iwl-trans.h    |   7 +-
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c | 221 ++++++++----------
 .../wireless/intel/iwlwifi/tests/devinfo.c    |  15 +-
 6 files changed, 122 insertions(+), 155 deletions(-)

-- 
2.34.1


