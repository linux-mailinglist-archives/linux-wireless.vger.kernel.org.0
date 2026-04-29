Return-Path: <linux-wireless+bounces-35577-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iKcVKd298WkbkQEAu9opvQ
	(envelope-from <linux-wireless+bounces-35577-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Apr 2026 10:14:21 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D801491105
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Apr 2026 10:14:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 10B39301220A
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Apr 2026 08:14:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBF713AA1A8;
	Wed, 29 Apr 2026 08:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Pt1/pJeV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91E743A874D;
	Wed, 29 Apr 2026 08:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777450453; cv=none; b=J6/7L/IrToNCn39lpIE0wvDP7ICNOuzVtKr+1uh453QfmBXP6fa5fjiXN39YUNAsK7oLs6GNp4mE9yRY82hXxspIYv4NJKr0UBKA3Qdzb8WuFrFfln2aXAxxSagl9gA74Bp6XXHBZ44pNvTvSs47JvZESubYP4Wm/mEJQR49nbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777450453; c=relaxed/simple;
	bh=lLxq1FdncFUtMzgjAwl9KxfT7PHQjfbOieKFploQRao=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Xwr7DiCR39u0NDQzV+ic2ITUjpLMY3W3xDDyAmFT5T8S+FIFCnVKi7mu0CVU0l8znzeXF5DatijjniL6nbCgV5CqmNH4i8wMdDDiU4YOfoAk/NQzHM2eCB4Y7d1MpGyN5Cse6IgtINYPpzJtAeUQPRyUiGCeeubvdPUon9fppXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Pt1/pJeV; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777450451; x=1808986451;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=lLxq1FdncFUtMzgjAwl9KxfT7PHQjfbOieKFploQRao=;
  b=Pt1/pJeVJwvi9Q92I6wWc5WRL/FMb2khNMYGfzNWke3e3t3KwrC4qBmR
   giNElXADlyg4kyWMhoz93UDlDPhTcuYVHAaZJJDoIiCJvb85pv97wHm2F
   MmILy6FdQCT1gLinnS/xcAaYgf4SMsSV/XrEvbvtkA5sOzjgEGsaZlxxT
   5RJzjmpSgI6puoC9rmzH25+QBLMXRHV6eASCdndc6XtMEXj86EqaKbHfI
   DULGkvx/3ajVvmNcD1fOKuQgtlQ884898WxETQhFe+Yje163AKQe9AEUq
   NzWup0IPSow3s/yGGrjjMqslohANMD7SLtlU7xBPPhN7X5ZArFBLDUoli
   A==;
X-CSE-ConnectionGUID: G9wGKezCTMeW5NxGYqJOEQ==
X-CSE-MsgGUID: Vdry7iaMTvaQcPMHe8VtPA==
X-IronPort-AV: E=McAfee;i="6800,10657,11770"; a="89751703"
X-IronPort-AV: E=Sophos;i="6.23,205,1770624000"; 
   d="scan'208";a="89751703"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 01:14:11 -0700
X-CSE-ConnectionGUID: 20U1xCG7QIKYPixnncUCdA==
X-CSE-MsgGUID: mUiWHRwjRDGMFIYNV0FdMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,205,1770624000"; 
   d="scan'208";a="235977950"
Received: from iapp347.iil.intel.com (HELO localhost) ([10.167.28.6])
  by fmviesa004.fm.intel.com with ESMTP; 29 Apr 2026 01:14:08 -0700
From: Avinash Bhatt <avinash.bhatt@intel.com>
To: devicetree@vger.kernel.org
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	johannes@sipsolutions.net,
	miriam.rachel.korenblit@intel.com,
	kobi.guetta@intel.com,
	emmanuel.grumbach@intel.com,
	Avinash Bhatt <avinash.bhatt@intel.com>
Subject: [PATCH 0/1] dt-bindings: net: wireless: intel,iwlwifi: add binding
Date: Wed, 29 Apr 2026 11:14:02 +0300
Message-Id: <20260429081403.46087-1-avinash.bhatt@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 2D801491105
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35577-lists,linux-wireless=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[avinash.bhatt@intel.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[intel.com:+];
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:dkim,intel.com:mid]

Add Device Tree binding schema for Intel discrete Wi-Fi 7 BE200 PCIe
adapters. The binding documents optional OEM platform configuration
properties for platforms using Device Tree instead of ACPI/UEFI firmware
methods.

Link to RFC: https://patchwork.kernel.org/project/devicetree/patch/20260408055709.11579-2-avinash.bhatt@intel.com/

Avinash Bhatt (1):
  dt-bindings: net: wireless: intel,iwlwifi: add binding

 .../bindings/net/wireless/intel,iwlwifi.yaml  | 445 ++++++++++++++++++
 1 file changed, 445 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/wireless/intel,iwlwifi.yaml

-- 
2.34.1


