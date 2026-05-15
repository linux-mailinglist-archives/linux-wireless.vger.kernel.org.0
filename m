Return-Path: <linux-wireless+bounces-36486-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SH0fOWYWB2rgrQIAu9opvQ
	(envelope-from <linux-wireless+bounces-36486-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 15 May 2026 14:49:42 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 808FF54FE8D
	for <lists+linux-wireless@lfdr.de>; Fri, 15 May 2026 14:49:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 21E0F3253722
	for <lists+linux-wireless@lfdr.de>; Fri, 15 May 2026 12:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 679AA47ECFF;
	Fri, 15 May 2026 12:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HylRw1NU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C7E947DFB2
	for <linux-wireless@vger.kernel.org>; Fri, 15 May 2026 12:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778847317; cv=none; b=C1GczQeX/+jrKlOc0HVsgy+Ygy2OX4I7BV4encGiak155RlhlKdPDc7kD7vL/O/dlPTr1EAIjvDjgvu4+LKLblu/4MX8eVt9fCGYmXvMuq7b/USGv2sF8YgmxwrowxIlwpijC8brD+cNbTIM3kHEl4s+U/2CyMMJL4bM0lRNAtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778847317; c=relaxed/simple;
	bh=aoaEmZRtuPsvFuMG6FcscPMvVO7RokPayu0oe1OyzkA=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=vCB35yk4ZufzeDIbKPw/Urxl696snxRs7+56YfeVb/5Vc4RQphdQ5zVErVfSTbWcxlh4yFXw3AiMaA4IYoVcfejd3jd44r4IFOvXUcu9nmAyjf+5V4zsIiWUyh8pLjPixiqz+pVMiQtVzNbpa7wmzm4sOingJHVu4dK7mCiJZrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HylRw1NU; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778847315; x=1810383315;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=aoaEmZRtuPsvFuMG6FcscPMvVO7RokPayu0oe1OyzkA=;
  b=HylRw1NUxIqjN6HOQJV8yoEhdzSdsiJzDjPIqviOHaCPNiM7Qf2Lhr9h
   yM1mPMC2aLgEHUKPOhyFDKTKyWavl4jks7A3vyoNZz3BZL2FVmMRdUX9L
   zxvBKXMFNnmeUhP1qWvfnJQkvZ8xSrkvxoO2f5XzWwF+vy9iXmCDA/cEI
   XZ0Y1z+2UHHia5/n9c038Rp070l5CQzctTs+AU3a/A8alphMPUsT+nL8S
   denvWFU4avM2ugfAb3lKnqGOwkTXBm3NGiRiRQUhJxih2bXM87KIFT9fe
   Sx++GykkrdEYhSZGGbf86HM3xeg9zqFLLzhjUhnXlkkmsrGD0RLg4edeF
   g==;
X-CSE-ConnectionGUID: x6GhbqzyQBWhglo1eaOX8w==
X-CSE-MsgGUID: NDSTly16Q5Oblkmh6pf+2g==
X-IronPort-AV: E=McAfee;i="6800,10657,11786"; a="79657840"
X-IronPort-AV: E=Sophos;i="6.23,236,1770624000"; 
   d="scan'208";a="79657840"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2026 05:15:15 -0700
X-CSE-ConnectionGUID: 2kVGZwDvS6CwOBj+p9GWJg==
X-CSE-MsgGUID: rv4QRek4QJihIqPCjAG4ew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,236,1770624000"; 
   d="scan'208";a="262201032"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2026 05:15:13 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Subject: [PATCH iwlwifi-fixes 0/5] wifi: iwlwifi: fixes - 2026-05-15
Date: Fri, 15 May 2026 15:14:55 +0300
Message-Id: <20260515121500.1170852-1-miriam.rachel.korenblit@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 808FF54FE8D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-36486-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	HAS_ORG_HEADER(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_ONE(0.00)[1];
	FORGED_SENDER_MAILLIST(0.00)[]
X-Rspamd-Action: no action

Hi,
A couple of fixes from our internal tree.

Miri
---

Emmanuel Grumbach (1):
  wifi: iwlwifi: mld: disconnect only after 6 beacons without Rx

Johannes Berg (2):
  wifi: iwlwifi: mvm: fix driver-set TX rates on old devices
  wifi: iwlwifi: mld: don't WARN on WoWLAN suspend w/o BSS vif

Miri Korenblit (1):
  wifi: iwlwifi: mld: don't dereference a pointer before NULL checking
    it

Moriya Itzchaki (1):
  wifi: iwlwifi: use correct function to read STEP_URM register

 .../wireless/intel/iwlwifi/mld/constants.h    |  4 +--
 drivers/net/wireless/intel/iwlwifi/mld/d3.c   |  6 ++---
 drivers/net/wireless/intel/iwlwifi/mld/link.c | 13 +++++----
 .../net/wireless/intel/iwlwifi/mvm/mac-ctxt.c | 27 ++++++++++++-------
 .../net/wireless/intel/iwlwifi/mvm/utils.c    | 14 +++-------
 .../intel/iwlwifi/pcie/gen1_2/trans-gen2.c    |  6 ++---
 6 files changed, 36 insertions(+), 34 deletions(-)

-- 
2.34.1


