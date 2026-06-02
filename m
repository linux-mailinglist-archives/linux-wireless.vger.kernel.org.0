Return-Path: <linux-wireless+bounces-37306-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id THpcALwAH2oRcwAAu9opvQ
	(envelope-from <linux-wireless+bounces-37306-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 02 Jun 2026 18:11:40 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 55784630172
	for <lists+linux-wireless@lfdr.de>; Tue, 02 Jun 2026 18:11:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=FIMmeIaz;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37306-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37306-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CDC90300D46A
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Jun 2026 16:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 438FC3F23B5;
	Tue,  2 Jun 2026 16:00:43 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D788C3F23CC
	for <linux-wireless@vger.kernel.org>; Tue,  2 Jun 2026 16:00:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780416043; cv=none; b=MGCYds+yovJEnTR0B7sCBLAwYA7vrDErJTRP090E0WaPycaFJ51Wb0SfPPVJ7FEsRlAjY+vzC5qtIdY/PS0u6AL2kjFbsIM569QxHz151eVUTwugVwjy3EZujuxmwuZIGUlsG1mQXcHgyGnMExA6sI8HfXpDI62+l0HTBEdLWpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780416043; c=relaxed/simple;
	bh=uZdF596PNZnuGbALi2cUiTrmcQOsXIobn1K8xAwNAh4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cLLSyWlWFKvKls5ZF/hvzyAP0CHH4zv2eOMe+Bxkmo0aF1jSbC7lu3kf52c5o9gyw8eJ7Yc6UKnZ9Y79fAwfOXiEr0elTyLGBhEv0jrEnCj0v/yqukVJ1A0pkmvKH7CJMv8S62pWpYu2eVkzASaAx8TJ0dR1xgyZbEiO78RfWuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FIMmeIaz; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780416041;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ScNxumSQCLZY0CA50/rf+ukYfKVFTKvR4NqwPnDooNA=;
	b=FIMmeIaz1XioY/qa5i+y6sY9wteHOXBq9qmtxAFnd5r4CH4LVoqHI3GSL0zQBdyUmUZF7d
	hB8ZEE3/Rh6yZQsrBvSlXmlu3AaJsgBd45mAG5skXtD1+KVzwWI567JwwY5/dg+7dkiOSE
	YNte45w2Rtk8806KgeNQsNNUkbShF+M=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-371-jBXE21GHNhyXaxH5QHis2w-1; Tue,
 02 Jun 2026 12:00:37 -0400
X-MC-Unique: jBXE21GHNhyXaxH5QHis2w-1
X-Mimecast-MFC-AGG-ID: jBXE21GHNhyXaxH5QHis2w_1780416034
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1698C18005B6;
	Tue,  2 Jun 2026 16:00:34 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.48.109])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A22961956095;
	Tue,  2 Jun 2026 16:00:29 +0000 (UTC)
From: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
To: bhelgaas@google.com,
	alex@shazbot.org
Cc: jjohnson@kernel.org,
	mani@kernel.org,
	linux-pci@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	ath11k@lists.infradead.org,
	ath12k@lists.infradead.org,
	mhi@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
Subject: [PATCH v6 0/3] PCI: Add d3cold and device-specific reset for Qualcomm devices
Date: Tue,  2 Jun 2026 18:00:21 +0200
Message-ID: <20260602160024.1171949-1-jtornosm@redhat.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[jtornosm@redhat.com,linux-wireless@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-37306-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:bhelgaas@google.com,m:alex@shazbot.org,m:jjohnson@kernel.org,m:mani@kernel.org,m:linux-pci@vger.kernel.org,m:linux-wireless@vger.kernel.org,m:ath11k@lists.infradead.org,m:ath12k@lists.infradead.org,m:mhi@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:jtornosm@redhat.com,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jtornosm@redhat.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[11];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 55784630172

Some PCIe devices lack working reset methods for VFIO passthrough scenarios.
These devices typically have no FLR, advertise NoSoftRst+ (blocking PM reset),
and have broken or unavailable bus reset. When a VM crashes, VFIO cannot reset
the device for reuse without a working reset method.

This series addresses the problem by adding general d3cold infrastructure and
device-specific reset for Qualcomm devices:

**Patch 1/3: d3cold reset method**
Adds D3cold as a general reset method with strict _PR3 requirement. Only
attempts true power cycling via platform control (ACPI _PR3), never falls
back to D3hot. This provides genuine power-off reset on platforms that
support it.

**Patch 2/3: device-specific reset for Qualcomm devices**
Adds device-specific reset entries for Qualcomm ath11k/ath12k WiFi and
SDX62/SDX65 modems using D3cold power cycling with automatic D3hot fallback.
Uses pci_set_power_state(D3cold) which automatically falls back to D3hot on
platforms without _PR3. Extracts shared pci_dev_d3cold_d0_cycle() helper to
avoid code duplication with general d3cold method. Device-specific reset is
position #1 in reset hierarchy, providing immediate working reset for these
Qualcomm devices.

**Patch 3/3: Qualcomm quirk_no_bus_reset**
Disables broken bus reset for Qualcomm devices. Testing proves this is
device-specific: MediaTek MT7925e works correctly with bus reset using the
same passive M.2-to-PCIe adapters where Qualcomm devices fail, confirming
PERST# is properly wired and the issue is not deployment-specific. Acts as
safety net to prevent broken SBR if users override via sysfs.

v6: - Patch 1/3 and 3/3 unchanged from v5
    - For patch 2/3, fix double IOMMU handling for device-specific reset:
      remove pci_dev_reset_iommu_prepare/done from pci_dev_d3cold_d0_cycle()
      helper, keep in pci_d3cold_reset() caller
    - Qualcomm maintainers CC'd
v5: https://lore.kernel.org/all/20260521130512.515125-1-jtornosm@redhat.com/

Jose Ignacio Tornos Martinez (3):
  PCI: Add d3cold as general reset method
  PCI: Add device-specific reset for Qualcomm devices
  PCI: Disable broken bus reset on Qualcomm devices

--
2.53.0


