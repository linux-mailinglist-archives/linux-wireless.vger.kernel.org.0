Return-Path: <linux-wireless+bounces-38790-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id TZjJKGtfTmrmLQIAu9opvQ
	(envelope-from <linux-wireless+bounces-38790-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 08 Jul 2026 16:32:11 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 06DBE72761D
	for <lists+linux-wireless@lfdr.de>; Wed, 08 Jul 2026 16:32:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20201202 header.b=JX03yOPT;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38790-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38790-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2FC9F30277EE
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Jul 2026 14:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E99E8416CF9;
	Wed,  8 Jul 2026 14:30:22 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AA2E3B7747;
	Wed,  8 Jul 2026 14:30:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783521021; cv=none; b=EnHhGAAUZI13Gftqet99mEOaIQ4CCZtASq2R/Lsmdm4yYrQd+4PeFDh+sZkaG7mM8o2rLzyMneMogosfqawc9dYhacKlaMVz/SLjVGlzyneJZPX/5PFZZqkLoaz4uATrXkF5zpONZRVwPxYUJk1G/6JNB0itCMP44mudqqN/7d0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783521021; c=relaxed/simple;
	bh=gQhapFU2gHvnflkP8Shzdby92+Ir7fqJ5ZXyGhEN0WI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=lQMMosQxd8omDB9w8JmHBr5MaEBP2RGUu9OKPF1g5RvQp7r41Cpvlt0FkR0W7zCzr/7hOPDcorlirYXBjkp1U6C7x7J1KH7Oxwx2urqj6AqNk9xZzfF3ywEitIQI05rPFkfo+9bgEzCmaWgK11haIzCwx2Pux9wUSG6X3K5UEo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JX03yOPT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E49EDC2BCB7;
	Wed,  8 Jul 2026 14:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1783521021;
	bh=gQhapFU2gHvnflkP8Shzdby92+Ir7fqJ5ZXyGhEN0WI=;
	h=From:Subject:Date:To:Cc:From;
	b=JX03yOPTVQvNuAbErhlJVQe8E1RpFeIRKMPxI1o6sw3aMGBdhfCWlHYLcsfOopDsI
	 Y0FiLiHDrQsM+J0LxFK1AmUu50TSBvJ8Wjl2MDhRpyDJ+AmS6aAKg+IPRg/xpV6tbB
	 HUwIPV+aKJ5mbyOrXmEZWMP9hdI2IpfLNTfkGOvkhppM8sQ3L50AtUQWxH0aDPDlKX
	 SNvH7NJ9JDxX0FCHR73mS9QvkNJXjf7ayPM42v2ibqLIUAIG5WjVTTUG4gdfcLzUgN
	 uKsQkN1Kb7H2s463uOIKGg9QqGM+znkBQIKgViI4URX0j5X4PwIqvQT7pnSXBciO8j
	 0kkxNiLRayMWQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEB04C43458;
	Wed,  8 Jul 2026 14:30:20 +0000 (UTC)
From: Manivannan Sadhasivam <mani@kernel.org>
Subject: [PATCH v3 0/8] PCI/ASPM: Add pci_force_enable_link_state() API and
 convert Atheros drivers
Date: Wed, 08 Jul 2026 16:30:14 +0200
Message-Id: <20260708-pci-aspm-fix-v3-0-6bd72451746e@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAPZeTmoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyjHUUlJIzE
 vPSU3UzU4B8JSMDIzMDcwML3YLkTN3E4oJc3bTMCl1jY0MLI7NEo+Qk0xQloJaColSgMNi46Fg
 Iv7g0KSs1uQRkhlJtLQCyes/GcAAAAA==
X-Change-ID: 20260708-pci-aspm-fix-331826a2cb5d
To: Bjorn Helgaas <bhelgaas@google.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Rob Herring <robh@kernel.org>, Nirmal Patel <nirmal.patel@linux.intel.com>, 
 Jonathan Derrick <jonathan.derrick@linux.dev>, 
 Jeff Johnson <jjohnson@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-wireless@vger.kernel.org, 
 ath12k@lists.infradead.org, ath11k@lists.infradead.org, 
 ath10k@lists.infradead.org, 
 Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, 
 Qiang Yu <qiang.yu@oss.qualcomm.com>, mani@kernel.org, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5491; i=mani@kernel.org;
 h=from:subject:message-id;
 bh=gQhapFU2gHvnflkP8Shzdby92+Ir7fqJ5ZXyGhEN0WI=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBqTl73YP36FvIsLRoHSB3uLXBEmb1VLP8fzrjGo
 vopGvPHqqGJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCak5e9wAKCRBVnxHm/pHO
 9VItB/9+NlfefDWPw3NDZQfzENbdPK5CjbHbDyMYfvDUBd+0D+ymYnONXpd9fnx6TyydIiRfiCe
 ZSlkrclpD5J7Y7QCkDo0hAc1ErkkCRx8ujsWjFonBGX2vTBr5edjBf6TcWOVe68wbfqvWk5eO5n
 Z/dqImoNjC7RXgnTtaXHLHjfyXXD42JgXDQZHxoXXRDlR7WrZRQ3cVRwUyO1MN0KfmCGfTR9Koi
 dKoAfVHGpw0hQCCVM386cmF2NHMWzkDg8KIQvYHnCU15sE11lxO1mbZXxtKNd+qhJKMCJydHCAU
 z1wbhqEUFE4eQzcBw80/kj4qbP3OZnyOtVEwPfjjwGBDlvpi
X-Developer-Key: i=mani@kernel.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Endpoint-Received: by B4 Relay for mani@kernel.org/default with
 auth_id=787
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-38790-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:bhelgaas@google.com,m:lpieralisi@kernel.org,m:kwilczynski@kernel.org,m:robh@kernel.org,m:nirmal.patel@linux.intel.com,m:jonathan.derrick@linux.dev,m:jjohnson@kernel.org,m:linux-pci@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-arm-msm@vger.kernel.org,m:linux-wireless@vger.kernel.org,m:ath12k@lists.infradead.org,m:ath11k@lists.infradead.org,m:ath10k@lists.infradead.org,m:krishna.chundru@oss.qualcomm.com,m:qiang.yu@oss.qualcomm.com,m:mani@kernel.org,m:ilpo.jarvinen@linux.intel.com,m:manivannan.sadhasivam@oss.qualcomm.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[mani@kernel.org,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mani@kernel.org,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 06DBE72761D

Hi,

This series converts the atheros WLAN drivers (ath10k/ath11k/ath12k) to
use the PCI core ASPM APIs for enabling/disabling ASPM instead of writing
to the LNKCTL register directly. Touching LNKCTL behind the PCI core's
back leaves the ASPM service driver's view of the link state out of sync
with the hardware, which is not nice.

The catch is that these drivers save the currently enabled ASPM states,
disable ASPM before firmware download, and restore the saved states
afterwards. pci_enable_link_state() cannot restore states that were
disabled via pci_disable_link_state() or blacklisted during init (like
the pre-1.1 device blacklist, which is only meant to be overridden with
pcie_aspm=force), and that is intentional. So the save/restore sequence
cannot be expressed with the existing APIs.

In v2 I tried to fix this by making pci_enable_link_state*() symmetric
with the disable APIs, but as pointed out during review, that also ends
up overriding the init-time blacklist for every caller (including VMD),
which is not something we want. So instead, this version adds a separate
pci_force_enable_link_state() API (patch 2) that re-enables the requested
states unconditionally. The caller is responsible for only asking for
states the device actually supports, and the ath drivers do this by
restoring exactly what pcie_aspm_enabled() reported earlier.

The first five patches touch the PCI core: patch 1 (from Ilpo) makes
pci_disable_link_state() disable ASPM unconditionally, patch 2 adds the
new API, patch 3 moves the D0 transition needed before enabling PCI-PM
L1 PM Substates (PCIe r6.0, sec 5.5.4) into the shared helper and drops
it from the vmd and pcie-qcom callers, patch 4 cleans up the kernel-doc,
and patch 5 makes pcie_aspm_enabled() return the enabled state mask so it
can be used for save/restore. The last three patches convert the ath
drivers.

Testing
=======

I've tested this series on a Lenovo Thinkpad T14s with WCN7850 (so that's
just the ath12k driver). Rest of the drivers are compile tested only.

Merging Strategy
================

Even though there is no build dependency between the PCI core and atheros
patches, there is a functional dependency. So I'd recommend creating an
immutable branch with the PCI patches and merging that branch into both
the PCI and linux-wireless trees, and finally merging the atheros patches
into the linux-wireless tree.

If the immutable branch seems like a hassle, then the PCI core patches
could get merged first and the atheros patches can wait for the next
cycle.

- Mani

Changes in v3:
* Dropped the change that made pci_enable_link_state*() symmetric with the
  disable APIs. Instead added a new pci_force_enable_link_state() API used
  only by the ath drivers, so the init-time blacklist stays overridable
  only via pcie_aspm=force and existing callers like VMD are left
  untouched.
* Fixed the locked path to use pci_set_power_state_locked() for the D0
  transition. The previous version called the non-locked variant, which
  re-acquires pci_bus_sem.
* ath drivers now disable PCIE_LINK_STATE_ASPM_ALL instead of
  PCIE_LINK_STATE_ALL so that CLKPM is preserved and can be restored
  (pcie_aspm_enabled() doesn't report CLKPM).
* Reworked the kernel-doc patch to cover both the enable and disable APIs
  and reference the new API.
* Rebased on top of v7.2-rc1.

Changes in v2:
* Reworked the pcie_aspm_enabled() API to return the enabled states
  instead of bool and used it to save/restore the ASPM states in ath
  drivers.
* Added a patch from Ilpo to disable ASPM even if BIOS didn't grant
  permission.
* Added the CONFIG_PCIEASPM dependency to ath{10/11/12}k drivers.
* Rebased on top of v6.17-rc1.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
Ilpo Järvinen (1):
      PCI/ASPM: Always disable ASPM when driver requests it

Manivannan Sadhasivam (7):
      PCI/ASPM: Add pci_force_enable_link_state() API
      PCI/ASPM: Transition the device to D0 (if required) when enabling ASPM link states
      PCI/ASPM: Improve the kernel-doc for pci_{enable,disable}_link_state*() APIs
      PCI/ASPM: Return enabled ASPM states from pcie_aspm_enabled() API
      wifi: ath12k: Use pci_{enable/disable}_link_state() APIs to enable/disable ASPM states
      wifi: ath11k: Use pci_{enable/disable}_link_state() APIs to enable/disable ASPM states
      wifi: ath10k: Use pci_{enable/disable}_link_state() APIs to enable/disable ASPM states

 drivers/net/wireless/ath/ath10k/Kconfig |   2 +-
 drivers/net/wireless/ath/ath10k/pci.c   |  11 +--
 drivers/net/wireless/ath/ath10k/pci.h   |   5 +-
 drivers/net/wireless/ath/ath11k/Kconfig |   2 +-
 drivers/net/wireless/ath/ath11k/pci.c   |  19 +----
 drivers/net/wireless/ath/ath11k/pci.h   |   3 +-
 drivers/net/wireless/ath/ath12k/Kconfig |   2 +-
 drivers/net/wireless/ath/ath12k/pci.c   |  19 +----
 drivers/net/wireless/ath/ath12k/pci.h   |   4 +-
 drivers/pci/controller/dwc/pcie-qcom.c  |   5 --
 drivers/pci/controller/vmd.c            |   5 --
 drivers/pci/pcie/aspm.c                 | 140 ++++++++++++++++++++++++--------
 include/linux/pci.h                     |   7 +-
 13 files changed, 129 insertions(+), 95 deletions(-)
---
base-commit: dc59e4fea9d83f03bad6bddf3fa2e52491777482
change-id: 20260708-pci-aspm-fix-331826a2cb5d

Best regards,
--  
மணிவண்ணன் சதாசிவம்



