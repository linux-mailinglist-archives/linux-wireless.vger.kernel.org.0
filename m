Return-Path: <linux-wireless+bounces-25052-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F099AFDF00
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Jul 2025 07:03:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 473531C26937
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Jul 2025 05:03:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDE0A26B74A;
	Wed,  9 Jul 2025 05:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Rkof+FRU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 740F926A1AF
	for <linux-wireless@vger.kernel.org>; Wed,  9 Jul 2025 05:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752037362; cv=none; b=pk97IobHfxd16gqYkJEv+aKh7840tyyYzPFWGRgTrvKYgCDjOxYIZCRWPL/4+nwExl/f0aPpkxr1/AlzmiDT1MsbpkMgB4qnR9GAYKmV13+dMsWxG3HGqE21HSj6xDTlTYNo8vDPAELWCiEXNyy+MvH1nxId2edYQ1bGDAmFayE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752037362; c=relaxed/simple;
	bh=CZkdLZeRMp3xYK78tLAdoJnCzpxejN7SNqFlczVuso0=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dnKpTtlpjA1slvBDqWwrKvyRbsIjFyFlvulz7VSp9WrufQJy3u3WbfyF+o8z98B3Jxk6Lt4yD6LSaNhWqxagqb6s/ViapJbbLYb+N0KCOCPPZdtaaPU++CnQRm3nXI8m0aqnn2WiBaHE6LhtsSGn7+9KoqAVGtMf14l0MOWwyEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Rkof+FRU; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752037361; x=1783573361;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=CZkdLZeRMp3xYK78tLAdoJnCzpxejN7SNqFlczVuso0=;
  b=Rkof+FRU1tYKoGNIfcwv8XFHgPfgxZvrd2vZlEXl98GdYim8CLflmriI
   aE92dn5+9LtPOrLjUlgbxWdxQRnrmbJjODnJXDS0kJxKws2MXYiMI2G7C
   2RmxEVAZAEjCNiuEmdiIo6sXjm4zEIo+/7SLVBT0y+USsuk28RmF4r1mA
   TL6rCK+BSDN+XAbwASR1DhXc4Ir+N6RtzNJ8xGgNwTzpXWqhXr6jffQbc
   Kee1b7qwQZcuWy9BhBjJoiM8QD9mxH14UFOr44fWnWzLxhQ5C4uEEycAB
   9Icuw/AWoGEDslvNkDb12tm1+6NP9hQzUI38fA/cCybg8mbLTc6Ty4E2D
   Q==;
X-CSE-ConnectionGUID: 1YSO/epnTnGY/jtl7xNXvw==
X-CSE-MsgGUID: 95YoHhUVQGy+y8MfCgWAIw==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="53501522"
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="53501522"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 22:02:41 -0700
X-CSE-ConnectionGUID: DXEzLnkmSBCW1SV4iu3RJg==
X-CSE-MsgGUID: xG+b4epkTfqpMXtztggDeQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="192859277"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 22:02:40 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Subject: [PATCH iwlwifi-next 14/15] wifi: iwlwifi: pcie: add a missing include
Date: Wed,  9 Jul 2025 08:01:58 +0300
Message-Id: <20250709075928.69259a34e4af.If75c28a85b5ba4c2661bdf4ce20b97dbe7d2abb2@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250709050159.854432-1-miriam.rachel.korenblit@intel.com>
References: <20250709050159.854432-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

pcie/utils.h needs to include iwl-io.h for the iwl_read/iwl_write calls.
Add it.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/pcie/utils.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/utils.h b/drivers/net/wireless/intel/iwlwifi/pcie/utils.h
index 031dfdf4bba4..27437d5e099b 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/utils.h
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/utils.h
@@ -6,6 +6,8 @@
 #ifndef __iwl_pcie_utils_h__
 #define __iwl_pcie_utils_h__
 
+#include "iwl-io.h"
+
 void iwl_trans_pcie_dump_regs(struct iwl_trans *trans, struct pci_dev *pdev);
 
 static inline void _iwl_trans_set_bits_mask(struct iwl_trans *trans,
-- 
2.34.1


