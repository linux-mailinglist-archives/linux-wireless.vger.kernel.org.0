Return-Path: <linux-wireless+bounces-39060-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id L6ubKblCVmqM2QAAu9opvQ
	(envelope-from <linux-wireless+bounces-39060-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 16:07:53 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E6F3755856
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 16:07:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=fftncCX3;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-39060-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-39060-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3392331ADC0A
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 14:02:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 768BD24113D;
	Tue, 14 Jul 2026 14:02:43 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E37124418CC
	for <linux-wireless@vger.kernel.org>; Tue, 14 Jul 2026 14:02:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784037763; cv=none; b=etbKYMr9Wy/k0U0otPt9iDrVCq5F/dQpCIhpqsL7p7JIT3WVvbFP402zFIl3wTZ+mbePvsZhpzL/9i9EhcE7yZRw74ruup21KZ7hacEUjTzy+kEMKuCFzDuzxOvCalraaRAF4xBcvFbpKkH5m8NfKfGly81pCsnUyQD1Re/LSnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784037763; c=relaxed/simple;
	bh=i48GcHcDiTgcMvQlQELODyV6Mu+tiEkWEznE4lvVqhM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MwMsS16Bars9zBVwEoZ892EImbO8e3RlvkPnAVO/bEWsS6swITnAmXt7Wv12f8qk13nh4tm/3JzAIm2r4QatnygMbe0hr9aaYeEb8hweKqib8nWzOyMa/fw4bbfaf+Ktr7LV2skGCrKEGWv2BxaGk++ks4Lg4b/wiqKklktx3aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fftncCX3; arc=none smtp.client-ip=198.175.65.16
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784037761; x=1815573761;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=i48GcHcDiTgcMvQlQELODyV6Mu+tiEkWEznE4lvVqhM=;
  b=fftncCX3W1CxTffXL0N7BXzTeBYJFOJQv/5oafbFZPYz2JvgK1ZBW7Za
   44HpYgtldmc9hJ91En+7841G4sJXnBdkVsh89gLo9OP8fhSOamy0giPwB
   xtNndjqfAGVQQdP5uFXOZe2svMenkKyzH25ZLp3WLbAMHeIXpv1S8UrN7
   cDUMWids4Hof1t5ldU8TIxBeDFzbEfYEsDDU6/TD//MRsQ/UyzOE4ILSi
   tRCCQnkB2AJp11Uj4P+jeBGJjw/WZ9M/bLTaSQjoiEi5ksgX0pEEiOfth
   aht4GfCqrAfqlZ59nSrmYsmKRLnijjJa9RqUHoqbJE7Zt0/ipHM+rtEw3
   g==;
X-CSE-ConnectionGUID: v7hT8NnxQrCrgi+LLX4e1g==
X-CSE-MsgGUID: P+xEVFM/SzWZwDGsXV6Upg==
X-IronPort-AV: E=McAfee;i="6800,10657,11846"; a="84855052"
X-IronPort-AV: E=Sophos;i="6.25,163,1779174000"; 
   d="scan'208";a="84855052"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 07:02:40 -0700
X-CSE-ConnectionGUID: mI5oM2/LRKqM2QvOY4AuKQ==
X-CSE-MsgGUID: 2szRkvOBRruyKa7m/2gneA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,163,1779174000"; 
   d="scan'208";a="254737834"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 07:02:39 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH v2 iwlwifi-next 00/15] wifi: iwlwifi: updates - 07-14-2026
Date: Tue, 14 Jul 2026 17:02:03 +0300
Message-Id: <20260714140218.2887000-1-miriam.rachel.korenblit@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:johannes@sipsolutions.net,m:linux-wireless@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-39060-lists,linux-wireless=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:from_mime,intel.com:dkim,intel.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1E6F3755856

Hi,

Usual fixed, cleanups and features from our internal tree.

Emmanuel Grumbach (8):
  wifi: iwlwifi: mvm: fix the FCS truncation logic in d3
  wifi: iwlwifi: mld: treat valid BAID without STA as a FW error
  wifi: iwlwifi: mvm: validate monitor notif link_id
  wifi: iwlwifi: mld: validate D3_END notif size
  wifi: iwlwifi: pcie: validate txq_id in txq_enable
  wifi: iwlwifi: mvm: reset the smart fifo state upon FW stop
  wifi: iwlwifi: mvm: cleanup the driver state after device_powered_off
  wifi: iwlwifi: mld: reset the driver state upon firmware recovery

Johannes Berg (2):
  wifi: iwlwifi: mvm: remove iwl_mvm_recalc_tcm()
  wifi: iwlwifi: claim UHR DBE capability for UHR devices

Miri Korenblit (3):
  wifi: iwlwifi: add a compile time check for too long hcmds
  wifi: iwlwifi: support TTL platform device ID
  wifi: iwlwifi: mld: cancel wiphy work before freeing wiphy

Pagadala Yesu Anjaneyulu (2):
  wifi: iwlwifi: ignore raw-DSM TLV for LARI cmd version 13 and above
  wifi: iwlwifi: regulatory: add LARI_CONFIG_CHANGE command v14 support

 drivers/net/wireless/intel/iwlwifi/fw/acpi.c  |  4 +-
 .../wireless/intel/iwlwifi/fw/api/nvm-reg.h   | 15 +++-
 drivers/net/wireless/intel/iwlwifi/fw/file.h  |  5 +-
 .../net/wireless/intel/iwlwifi/fw/runtime.h   | 13 +++-
 drivers/net/wireless/intel/iwlwifi/fw/uefi.c  | 20 ++---
 drivers/net/wireless/intel/iwlwifi/fw/uefi.h  |  4 +-
 .../wireless/intel/iwlwifi/iwl-nvm-parse.c    |  3 +-
 drivers/net/wireless/intel/iwlwifi/mld/agg.c  |  9 ++-
 drivers/net/wireless/intel/iwlwifi/mld/d3.c   | 10 ++-
 drivers/net/wireless/intel/iwlwifi/mld/hcmd.h |  9 ++-
 .../net/wireless/intel/iwlwifi/mld/mac80211.c |  3 +-
 .../net/wireless/intel/iwlwifi/mld/mac80211.h |  2 +
 drivers/net/wireless/intel/iwlwifi/mld/mcc.c  |  2 +-
 drivers/net/wireless/intel/iwlwifi/mld/mld.c  |  6 +-
 drivers/net/wireless/intel/iwlwifi/mld/mld.h  |  2 -
 .../wireless/intel/iwlwifi/mld/regulatory.c   | 74 ++++++++++++++-----
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c   |  2 +-
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c |  2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  | 23 ++++--
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c  |  7 +-
 .../net/wireless/intel/iwlwifi/mvm/utils.c    | 54 +++-----------
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c |  1 +
 .../wireless/intel/iwlwifi/pcie/gen1_2/tx.c   | 11 ++-
 23 files changed, 173 insertions(+), 108 deletions(-)
---
v2: send again after next branch to contain the fix:
wifi: iwlwifi: mvm: avoid oversized UATS command copy
without it we will get the compilation error added in:
wifi: iwlwifi: add a compile time check for too long hcmds
-- 
2.34.1


