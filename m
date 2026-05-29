Return-Path: <linux-wireless+bounces-37090-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wMp4JH4pGWp/rQgAu9opvQ
	(envelope-from <linux-wireless+bounces-37090-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2026 07:51:58 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EEE605FDA25
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2026 07:51:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C5544303259D
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2026 05:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B41D38F226;
	Fri, 29 May 2026 05:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Nn0is+c3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB2C348C62
	for <linux-wireless@vger.kernel.org>; Fri, 29 May 2026 05:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780033610; cv=none; b=KkyuhpQEAzzI7Bzb4AgbP7/fdW25ov03mUtZ2AOYplB6FzXM4W/+9oLGAv2JSTp5tVbyNBrDaK476Ef1iFs3asHXib9jihYADzqY31i2q290iMJTrPJC8YqUktZIVTP+vRu22VYE3AyHpXYmxDqQWrmOO0hJxv+7+CpmqQZs1Dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780033610; c=relaxed/simple;
	bh=ne7tjOPkmxtkPBCTQSUghHF/nAQaGM9lLemPcfvhbqc=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=HX8RfcZ/HjW9SiJPHWicsVdY5RhHmOj7cw6yyBTXgRDGhKES4FaVHMsJfwXzh8UJFEREycA0t+UcToxVfwDrleW0pN+lF6LriRNZTPP04ESU8ij6kiQkWxzkWTQFdcNvzr/mYHhJk3RvtBmP8DSHQiRGD1x3y93EzjH6QdrS63s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Nn0is+c3; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780033608; x=1811569608;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ne7tjOPkmxtkPBCTQSUghHF/nAQaGM9lLemPcfvhbqc=;
  b=Nn0is+c3DRGbVeFvVYTf3EKw1QjPwmzLt+e10yd52hxfq5AAbbyQ9jKc
   CML+hmBvwa44mqoLKneIs0+0HjPhdaT9DVs0F+Wn3r0cwc+/kzZV2mjbK
   /kWtEcx3HGld4US5nanu/i9+GDZ2hQlNU3bxwYtcaMN9WpjWWThlI+Lqy
   Djh5BQ846Zn9W+ROr8+z0DMZYY+5FsQirst3zV7WDs3L8WrjhmfT5O8Qd
   eYNTxWEAn4DKDQ4kzpooS3eFj/RdUvpV03k9ipwdyIAhDIuwpeYedZkn4
   AEMjqnh/5GD+LjlZxXwVc6yqVGATqmnbPoJTVQiexrW+V1dgyEagiMab4
   A==;
X-CSE-ConnectionGUID: Od/el2TVS42vFPCIFy9lEg==
X-CSE-MsgGUID: 2Ho8AHJTRpKxqJM0uWniHQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11800"; a="91453707"
X-IronPort-AV: E=Sophos;i="6.24,174,1774335600"; 
   d="scan'208";a="91453707"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2026 22:46:47 -0700
X-CSE-ConnectionGUID: f2J4zDOMTMWELxqZQfs9yg==
X-CSE-MsgGUID: BCHRgMPBTeWGCoHJCEstDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,174,1774335600"; 
   d="scan'208";a="247043574"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2026 22:46:47 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Subject: [PATCH wireless-fixes 0/3] wifi: iwlwifi: fixes - 2026-05-29
Date: Fri, 29 May 2026 08:46:28 +0300
Message-Id: <20260529054631.4039300-1-miriam.rachel.korenblit@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-37090-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_ONE(0.00)[1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:mid,intel.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: EEE605FDA25
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

A few fixed from our internal tree.

Thanks,
Miri
---

Emmanuel Grumbach (2):
  wifi: iwlwifi: mvm: don't support the reset handshake for old
    firmwares
  wifi: iwlwifi: mvm: avoid oversized UATS command copy

Pagadala Yesu Anjaneyulu (1):
  wifi: iwlwifi: mld: send tx power constraints before link activation

 drivers/net/wireless/intel/iwlwifi/mld/ap.c   |   4 -
 .../net/wireless/intel/iwlwifi/mld/mac80211.c |   7 +
 .../net/wireless/intel/iwlwifi/mld/power.c    |   2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c   |  26 +-
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c  |   6 +
 res                                           | 250 ++++++++++++++++++
 6 files changed, 285 insertions(+), 10 deletions(-)
 create mode 100644 res

-- 
2.34.1


