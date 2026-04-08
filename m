Return-Path: <linux-wireless+bounces-34511-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cI+AEUfu1Wkv/gcAu9opvQ
	(envelope-from <linux-wireless+bounces-34511-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 08 Apr 2026 07:57:27 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DEB923B762F
	for <lists+linux-wireless@lfdr.de>; Wed, 08 Apr 2026 07:57:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B5C77301911A
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Apr 2026 05:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DA5A35F5F7;
	Wed,  8 Apr 2026 05:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q5dEqX/b"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8541A27702D;
	Wed,  8 Apr 2026 05:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775627838; cv=none; b=k23AWJSYG+xp8KNR0WV/CkGWQ13fe3MvBpmkSoYiodsNs8wTevjkz6CW9a6tp3zFFniQNaU7Mdi/xK1RDCX7rj91X2yfOR54Qp7kD1fvS6TlY3frs0SHyD2fq0CZkHuvcxS4YziJmkeo3E0pUIlSy1FferxTMsG7nCTqgKQFXDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775627838; c=relaxed/simple;
	bh=CFgNAs10xWp7nlnTz3fpwGVgGiRBe0UcCI+L2v4Vlkw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QZ4A97IYvuZgsTSszv1GuDkqPRkT6xaGLgc7OTprjc8yi8oW/Ot3ZFBqcDIjJEq89SoTMbutRbCycDWplZAG+j/rBfuw4bvxKnk4A95QJyZaP6ThpW+LX3BiCrEGCbldA63NNykjtOyGxaSrazVQ9TQ5z+Cc6s4RSSiQKbrj7S8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q5dEqX/b; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775627836; x=1807163836;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=CFgNAs10xWp7nlnTz3fpwGVgGiRBe0UcCI+L2v4Vlkw=;
  b=Q5dEqX/bDmtek/oDxBaXaGkv1rtvhhDbR5v/NUy4LiAbl7KK/Vpkcuj4
   wrGoCTbCxBEvp3J6dyX5ElDOy4nzEzfAvx8VksdTK+nH6InjkCW6CRzcJ
   fqHENLEvmz+8JycRyGPe/gDrapLRA1T0IyBkswua16KpWNmsru1auAhQr
   kcrBUZj1l9ciNmjHqnqfgvt+fCzu9JJqEY8iQbz3ujjqLSA5Y0wUedTKq
   DVwOurVzLNjuTtEL78v+TQ59npnkZZ7PNHVOUovkhIMziQ+0dHgmNM0pJ
   ZGbxjyf0cl2l84zXV3HZ0gwjMxEXr1g8CjQi3xhGX6NihL1RCGA9A8yYf
   Q==;
X-CSE-ConnectionGUID: at4YNI4ERNS38M7NRsi/PA==
X-CSE-MsgGUID: U7/a1lnfR8ahj54UlnCj1A==
X-IronPort-AV: E=McAfee;i="6800,10657,11752"; a="93991185"
X-IronPort-AV: E=Sophos;i="6.23,167,1770624000"; 
   d="scan'208";a="93991185"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2026 22:57:16 -0700
X-CSE-ConnectionGUID: KmvXhqiyS/a4L5PoiJndHQ==
X-CSE-MsgGUID: UL5b/zjFTgezy1Wq3Fbn8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,167,1770624000"; 
   d="scan'208";a="233256075"
Received: from iapp347.iil.intel.com (HELO localhost) ([10.167.28.6])
  by fmviesa005.fm.intel.com with ESMTP; 07 Apr 2026 22:57:13 -0700
From: Avinash Bhatt <avinash.bhatt@intel.com>
To: devicetree@vger.kernel.org
Cc: linux-wireless@vger.kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	johannes@sipsolutions.net,
	johannes.berg@intel.com,
	miriam.rachel.korenblit@intel.com,
	kobi.guetta@intel.com,
	emmanuel.grumbach@intel.com,
	Avinash Bhatt <avinash.bhatt@intel.com>
Subject: [RFC PATCH 0/1] dt-bindings: net: wireless: intel,iwlwifi: add binding
Date: Wed,  8 Apr 2026 08:57:08 +0300
Message-Id: <20260408055709.11579-1-avinash.bhatt@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34511-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:dkim,intel.com:mid]
X-Rspamd-Queue-Id: DEB923B762F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi DT maintainers and community,

We are the Intel wireless LAN driver team (iwlwifi). This is our first
attempt at a Device Tree binding and we are posting this RFC well ahead
of any formal submission to get early guidance and feedback.

Background:

Intel discrete Wi-Fi adapters are traditionally configured by platform
firmware via ACPI DSM methods. As ARM64 and other non-x86 platforms
gain adoption, we want to support platforms that use Device Tree instead
of ACPI for providing this OEM configuration data (SAR power limits,
regulatory overrides, 6 GHz country enablement, etc.).

Scope of this RFC:

This binding currently covers only the Wi-Fi 7 BE200 adapter (PCI ID
8086:272b). Support for other Intel discrete Wi-Fi devices may be added
in future revisions as we validate the binding on additional platforms.
Similarly, the set of properties documented here reflects what we have
implemented today -- some properties may be revised, renamed, or
extended based on feedback before the final submission.

What we are looking for:

 - Feedback on the overall approach and whether the property
   naming/structure follows DT conventions
 - Any concerns about the layout of multi-cell properties (revision +
   bitmap pattern used throughout)
 - Guidance on anything that would prevent this from being accepted
   upstream

The patch passes `make dt_binding_check` cleanly.

As this is our first DT binding submission, any feedback on conventions
or best practices we may have missed is very welcome.

Thanks in advance for your time,
Avinash Bhatt
Intel Wireless LAN Team

Avinash Bhatt (1):
  dt-bindings: net: wireless: intel,iwlwifi: add binding

 .../bindings/net/wireless/intel,iwlwifi.yaml  | 413 ++++++++++++++++++
 1 file changed, 413 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/wireless/intel,iwlwifi.yaml

--
2.34.1


