Return-Path: <linux-wireless+bounces-19864-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61858A547B8
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Mar 2025 11:26:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC5987A2CCF
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Mar 2025 10:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBCF9200100;
	Thu,  6 Mar 2025 10:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RwVmGhqp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75FE01FFC70
	for <linux-wireless@vger.kernel.org>; Thu,  6 Mar 2025 10:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741256761; cv=none; b=EsLn9Qt8tLbkJ61VVekjjoNXAAY2TIpDonLWKs8bbJW43Tal1E69QVZ8tTi3z1zEXvAorctBct1UpwZk8t9njv7fF/mbKw1jmiiZgSpQ3GDegGTl7JwbPInSnN6OM6MYcmfYN5fBNO7oKYNZIEVbEbEM+OjLa4a4ro2abjJsr3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741256761; c=relaxed/simple;
	bh=2Kp4bI0zODG2pvo3yh1hvhbGXMp5d1wndSDl2EqK9G0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kZBXEN21bpeBVEIsiqBK4xAEZCAjPyXozlpSaGkF3BDOwEkxgiPpFsxdC5sNUwmGOgIJKUr2GhWgbHNuy3CpM3RbVdovjU5tCpkS3c3FB/EqUfYlr0A4SaQPR2FQsLoHGzPFD4VYPU7ejJi5CILCjNekpIJfiqEAqvCuxXGXxF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RwVmGhqp; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741256760; x=1772792760;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=2Kp4bI0zODG2pvo3yh1hvhbGXMp5d1wndSDl2EqK9G0=;
  b=RwVmGhqpsFdUmrZXRibJTj0wftcZCsMNTEvVoA7IIVT9TAFFoq1DM6+/
   UscFInrAlj+npSRh8zTvCvmX+mGW/AD+51v5+W1uhcQ3+9kHQBcxiMDjN
   aIj3lEBG844C3tvNDBfOJhwUzPSROf4HN71vmhx8JpZNWETPT/qFFGRDI
   Ex5RKSmDkIJbMBJZm+oINmsSbztnFiHvCOf/6y6P86thNa4qc4DBIui69
   G2N+uN88ddHlN18/Yw1NmdZU0rgb0WNFfA9rKEb6CeIkLJPoxxeGitAIH
   qAw+oz7OCn9D1Z/ZZTeFw5aVv0Ezhw1c7zTfyEsHvx+kENfD0hYX1GoBX
   A==;
X-CSE-ConnectionGUID: eW0+Zjn1RHGyjNlhCMD5YA==
X-CSE-MsgGUID: RGITh5kbRVK0EvRPwV/96Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="41433433"
X-IronPort-AV: E=Sophos;i="6.14,225,1736841600"; 
   d="scan'208";a="41433433"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 02:26:00 -0800
X-CSE-ConnectionGUID: G21bH83eQbGxCZCuuuVf1w==
X-CSE-MsgGUID: knuWQIZ2SiSappy83+wTOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,225,1736841600"; 
   d="scan'208";a="142209548"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 02:25:58 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH wireless 0/3] wifi: iwlwifi: fixes - 2025-03-06
Date: Thu,  6 Mar 2025 12:25:45 +0200
Message-Id: <20250306102548.4056118-1-miriam.rachel.korenblit@intel.com>
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
A few bugfixes from our internal tree.

Thanks,
Miri
---

Emmanuel Grumbach (1):
  wifi: iwlwifi: mvm: fix PNVM timeout for non-MSI-X platforms

Ilan Peer (1):
  wifi: iwlwifi: pcie: Fix TSO preparation

Miri Korenblit (1):
  wifi: iwlwifi: trans: cancel restart work on op mode leave

 drivers/net/wireless/intel/iwlwifi/iwl-trans.c |  2 ++
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c    |  6 +++---
 drivers/net/wireless/intel/iwlwifi/pcie/tx.c   | 11 ++++++-----
 3 files changed, 11 insertions(+), 8 deletions(-)

-- 
2.34.1


