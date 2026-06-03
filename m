Return-Path: <linux-wireless+bounces-37338-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id M3evMrwLIGrYuwAAu9opvQ
	(envelope-from <linux-wireless+bounces-37338-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 03 Jun 2026 13:10:52 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 529DC636DC3
	for <lists+linux-wireless@lfdr.de>; Wed, 03 Jun 2026 13:10:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=DizyQp2P;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37338-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37338-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0002431CF2F4
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jun 2026 11:03:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02AA1466B47;
	Wed,  3 Jun 2026 10:59:11 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B62814611C2
	for <linux-wireless@vger.kernel.org>; Wed,  3 Jun 2026 10:59:09 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780484350; cv=none; b=WXfynU4BZ8pYb+lLUB/gz29EPs71vWhtD7J4yYJpFgojLlY7fZzQOPft+uS4J66hSFb3bZLstbRYY6IidC2hh5HJdkm4uHSPEzWgYzUi314Eg2STDt48zlJLdErySdJP7dFQ6uClHg9IJFjKbdf00bQMk5LwD26C8dHH+XQWPEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780484350; c=relaxed/simple;
	bh=ZubWPNKb76BgJrfDBjrP2CunDrq90eRpkW8OkfVt0Wk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YyQr0s9O/k7hNrGINPF2ZHV0FCL4gcuPrcR+hzLTuT7y2W2ruWQYw6mzZ/ZKe35bNnJdEAdSfdjCfR3kWiokzAVOn3uDUraWRCB3eyHEYjqdduNcoJmkdMHHiQrzppzqmEP2tBncj4C6QXLPRxfA+IHIWgRv+GHB+l27aZrTtXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DizyQp2P; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780484349;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=gUOUj2uQfA2vt7AFIl1y5TD83w2VwUTO4xUveVofnp8=;
	b=DizyQp2PkutsUVgKxgffvE3N4ciZrC7/C7fmXBPtjl5YE2cM1sRw4OjCa0/c1GlQfTetu4
	Q9sC0A0x0m16t93eWepp1zIAU889K8o5gzudxAudPuIgzSce6tWiE7uTf3J6OYKpisKmx7
	aCnmTG7hFIe4TEaDy2E0b/MnyMc/ORk=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-277-U-giJPGxMgSEXrRIli0tUQ-1; Wed,
 03 Jun 2026 06:59:05 -0400
X-MC-Unique: U-giJPGxMgSEXrRIli0tUQ-1
X-Mimecast-MFC-AGG-ID: U-giJPGxMgSEXrRIli0tUQ_1780484343
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B8AE71956060;
	Wed,  3 Jun 2026 10:59:02 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.48.81])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 26C721956095;
	Wed,  3 Jun 2026 10:58:57 +0000 (UTC)
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
Subject: [PATCH v7 0/3] PCI: Add d3cold and device-specific reset for Qualcomm devices
Date: Wed,  3 Jun 2026 12:58:50 +0200
Message-ID: <20260603105853.326290-1-jtornosm@redhat.com>
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
	TAGGED_FROM(0.00)[bounces-37338-lists,linux-wireless=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 529DC636DC3

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
Adds device-specific reset entries for Qualcomm WCN6855/WCN7850 WiFi cards and
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

v7: Address the comments from Jeff Johnson: the problem was detected for
    the specific devices WCN6855 and WCN7850, use the name of the devices
    instead of the related drivers ath11k and ath12k, which support a large
    number of devices (patches 2/3 and 3/3).
v6: https://lore.kernel.org/all/20260602160024.1171949-1-jtornosm@redhat.com/

Jose Ignacio Tornos Martinez (3):
  PCI: Add d3cold as general reset method
  PCI: Add device-specific reset for Qualcomm devices
  PCI: Disable broken bus reset on Qualcomm devices

--
2.53.0


