Return-Path: <linux-wireless+bounces-9534-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3105916E71
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Jun 2024 18:51:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF58F2811F6
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Jun 2024 16:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D138175573;
	Tue, 25 Jun 2024 16:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KNrfUNW/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 889F9175558
	for <linux-wireless@vger.kernel.org>; Tue, 25 Jun 2024 16:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719334295; cv=none; b=CzGKXNFDLLqk7YN5etsC6bsiWtsvDFVPpoCtPtb9ATUiW/8lwGRWYwZ1+SGeDxrkGgqnclBPQmlDyjFx/vSfdniMogNpxGDEtDMcQeJR83IZ30q2I7hoMoYevrMmHVbobjSQVYDRHrq6riVsFYKQa470HMG5TnSBUoqJ3CSDUfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719334295; c=relaxed/simple;
	bh=xAPWMalNau4f160ej93mfoX8AZq9ZvX5f/dQxfk/7bU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=r0s6PMAWWFMoqpqtzJnStQjVAVIQyYaEPnvlJTK1Y0YnAGJ9gQuDry8UARPIaM/mdamVn/ACxWBPxwPM7Vhk2ed68pV1sWS56Pq1KMvG0pPYfmfFR4nN8nvOXwRU3fTnXyLEwv3PBd/wno/hXJ/xX3tTqVz0tG17abgr23BQCYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KNrfUNW/; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719334294; x=1750870294;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=xAPWMalNau4f160ej93mfoX8AZq9ZvX5f/dQxfk/7bU=;
  b=KNrfUNW/wL0MxC3L9Htar7AzVpLbjXGNNxtMG8v4VMIgCzXdFJL/fS6v
   XF6amsrEQaP+4DdHrF++Z7gt3pG1wiZ+dDo55a7j3z8BM006LoXjNjzcD
   KaLaSQXSJZOT6O2sbDZ6lBqS9+GLIM8SzeTDgJ6RJVcyYHzsWnq5WV88r
   xRDTMnXyNGgoHpZvEtFhHJR9Jlju6DOp+oHcnRsnFVvc9lg+0Z1TcCHbq
   2l31P8XBeVD5TZB7bUMVGdZhWSvrKuBEQEdPJnbVlrREoGcjLeEu0cn4q
   JRve/gLIf0qxmioBVToo/JrNrcO4ACN6qDUcc2mls8b1iKfiO7yAZot95
   g==;
X-CSE-ConnectionGUID: XaJ0/HkPRS+Ncv+2P0mq1g==
X-CSE-MsgGUID: Q2tJ07CfTRuB3uutXAXfXg==
X-IronPort-AV: E=McAfee;i="6700,10204,11114"; a="16594675"
X-IronPort-AV: E=Sophos;i="6.08,264,1712646000"; 
   d="scan'208";a="16594675"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2024 09:51:33 -0700
X-CSE-ConnectionGUID: otp7N4csSlqHbwlIRQ6Vmg==
X-CSE-MsgGUID: 9H8YShF6StqxnWDj2ADoKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,264,1712646000"; 
   d="scan'208";a="48632414"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2024 09:51:30 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH 00/17] wifi: iwlwifi: updates - 25-06-24
Date: Tue, 25 Jun 2024 19:51:06 +0300
Message-Id: <20240625165123.1624974-1-miriam.rachel.korenblit@intel.com>
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

This patch set contains a few features, bugfixes and cleanups.

Benjamin Berg (1):
  wifi: iwlwifi: mvm: don't log error for failed UATS table read

Daniel Gabay (1):
  wifi: iwlwifi: remove MVM prefix from scan API

Emmanuel Grumbach (1):
  wifi: iwlwifi: update the BA notification API

Johannes Berg (13):
  wifi: iwlwifi: mvm: don't flush BSSes on restart with MLD API
  wifi: iwlwifi: mvm: use IWL_FW_CHECK for link ID check
  wifi: iwlwifi: mvm: always unblock EMLSR on ROC end
  wifi: iwlwifi: fw: api: fix some kernel-doc
  wifi: iwlwifi: trans: make bad state warnings
  wifi: iwlwifi: dvm: fix kernel-doc warnings
  wifi: iwlwifi: pcie: fix kernel-doc
  wifi: iwlwifi: fix kernel-doc in iwl-trans.h
  wifi: iwlwifi: fix kernel-doc in iwl-fh.h
  wifi: iwlwifi: fix prototype mismatch kernel-doc warnings
  wifi: iwlwifi: fix remaining mistagged kernel-doc comments
  wifi: iwlwifi: fw: api: datapath: fix kernel-doc
  wifi: iwlwifi: mvm: fix rs.h kernel-doc

Miri Korenblit (1):
  wifi: iwlwifi: mvm: remove init_dbg module parameter

 .../net/wireless/intel/iwlwifi/dvm/commands.h |  8 ++--
 drivers/net/wireless/intel/iwlwifi/dvm/tt.h   |  4 +-
 .../net/wireless/intel/iwlwifi/fw/api/alive.h |  6 +--
 .../wireless/intel/iwlwifi/fw/api/binding.h   |  4 +-
 .../wireless/intel/iwlwifi/fw/api/config.h    |  4 +-
 .../net/wireless/intel/iwlwifi/fw/api/d3.h    |  4 +-
 .../wireless/intel/iwlwifi/fw/api/datapath.h  | 27 +++++++----
 .../wireless/intel/iwlwifi/fw/api/dbg-tlv.h   |  2 +-
 .../wireless/intel/iwlwifi/fw/api/location.h  |  2 +-
 .../wireless/intel/iwlwifi/fw/api/mac-cfg.h   |  2 +-
 .../wireless/intel/iwlwifi/fw/api/nvm-reg.h   |  4 +-
 .../wireless/intel/iwlwifi/fw/api/offload.h   |  2 +-
 .../wireless/intel/iwlwifi/fw/api/phy-ctxt.h  |  4 +-
 .../net/wireless/intel/iwlwifi/fw/api/phy.h   |  2 +-
 .../net/wireless/intel/iwlwifi/fw/api/power.h | 10 ++--
 .../net/wireless/intel/iwlwifi/fw/api/rs.h    |  4 +-
 .../net/wireless/intel/iwlwifi/fw/api/rx.h    |  4 +-
 .../net/wireless/intel/iwlwifi/fw/api/scan.h  | 16 +++----
 .../net/wireless/intel/iwlwifi/fw/api/tx.h    |  6 ++-
 .../wireless/intel/iwlwifi/fw/error-dump.h    |  4 +-
 .../net/wireless/intel/iwlwifi/iwl-config.h   |  3 +-
 drivers/net/wireless/intel/iwlwifi/iwl-csr.h  |  6 +--
 drivers/net/wireless/intel/iwlwifi/iwl-fh.h   | 34 +++++++-------
 .../wireless/intel/iwlwifi/iwl-nvm-parse.h    |  2 +-
 drivers/net/wireless/intel/iwlwifi/iwl-prph.h |  4 +-
 .../net/wireless/intel/iwlwifi/iwl-trans.c    | 46 ++++++++-----------
 .../net/wireless/intel/iwlwifi/iwl-trans.h    |  7 ++-
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c   | 14 +++---
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c |  8 ++--
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  | 12 ++---
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c  |  9 +---
 drivers/net/wireless/intel/iwlwifi/mvm/rs.h   | 19 ++++----
 drivers/net/wireless/intel/iwlwifi/mvm/sta.h  |  2 +-
 .../wireless/intel/iwlwifi/mvm/time-event.c   |  2 +-
 .../wireless/intel/iwlwifi/pcie/internal.h    |  6 ++-
 35 files changed, 146 insertions(+), 147 deletions(-)

-- 
2.34.1


