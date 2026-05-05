Return-Path: <linux-wireless+bounces-35947-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MKDeANcn+mmHKQMAu9opvQ
	(envelope-from <linux-wireless+bounces-35947-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 05 May 2026 19:24:39 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 665CC4D1FDA
	for <lists+linux-wireless@lfdr.de>; Tue, 05 May 2026 19:24:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DC8FD301D94A
	for <lists+linux-wireless@lfdr.de>; Tue,  5 May 2026 17:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 383283E929C;
	Tue,  5 May 2026 17:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mokrynskyi.com header.i=@mokrynskyi.com header.b="eQ8bo+lJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.mokrynskyi.com (mail.mokrynskyi.com [65.109.39.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77700492190
	for <linux-wireless@vger.kernel.org>; Tue,  5 May 2026 17:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.39.229
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778001876; cv=none; b=L79JX3TEsb+3eK/6oKqgnNOdVp2NtbCGrZ8ZHGEoym4EI0YNDZ3KiWyD0oJc4Y34UslPxFMkGksMyZCnzP4socV6CYckOpd1gxJUANhPBnKdk3BAjxMa9QDidArYYEePnwfRRlYlkRr4ZFR9gGAhOvzc0Fv/lD2t1tOhPUuKWfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778001876; c=relaxed/simple;
	bh=xzR9f0MzvqfJq9Wbs3rb3KO1S/d6GE/NMIyJCJA7Cks=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jLn1kEC3O1zDy7SxYv2vNz+fCplrY72zH6pwlWkTkVu1iTga11XRRNg6iG+ROioMhGVAvOBAx8YwXyH8hmx+PRTnN6HIZxwpCN0spA+TVXcE7AxhWXV7FcRYin68RNwFSECjp5OdcDv0Vk1WO76GLQnitIwvDCyqaBPr3WFUXBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mokrynskyi.com; spf=pass smtp.mailfrom=mokrynskyi.com; dkim=pass (2048-bit key) header.d=mokrynskyi.com header.i=@mokrynskyi.com header.b=eQ8bo+lJ; arc=none smtp.client-ip=65.109.39.229
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mokrynskyi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mokrynskyi.com
From: Nazar Mokrynskyi <nazar@mokrynskyi.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mokrynskyi.com;
	s=dkim; t=1778001862;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=4YomgKhaVyFY7egyHjSVSlDXhkJ5thpj1igc2YBNc6w=;
	b=eQ8bo+lJemXAGD9gUufuBfvi4m/O4rNBAfuffbmcWQVWuqDpcBl6NIN+wfToDjEBDI1xA9
	M6GmtRyWr+Gi7AgRK7ACoYGEqMg9YhqfvZFD7NZSJPYw83ZN8X5ExOeD1DZM2Dc62K2N5b
	y7bqbZ4NL91hAXSOnxi5b3vnx29wdMg0eU8BWl72ZE6xOWtU3lSlmpeaIpfD6b4qhQlYwE
	r8iwYWvzKMA4bOYNp+sRdgObheblEghv5TT6rhNntBQVE+6UbGYqbFi7XGPn23Js7vDvWk
	Ug8yU8NGtId/QfQjhuYDCWW+gAbAsIb4HyrCFBMROuS3G6URBPJRrjiYAEVHBw==
Authentication-Results: mail.mokrynskyi.com;
	auth=pass smtp.mailfrom=nazar@mokrynskyi.com
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
	jeff.johnson@oss.qualcomm.com,
	Nazar Mokrynskyi <nazar@mokrynskyi.com>
Subject: [PATCH 0/2] wifi: ath12k: Fix operation under virtio
Date: Tue,  5 May 2026 20:24:13 +0300
Message-ID: <20260505172415.566328-1-nazar@mokrynskyi.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: -
X-Rspamd-Queue-Id: 665CC4D1FDA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[mokrynskyi.com,reject];
	R_DKIM_ALLOW(-0.20)[mokrynskyi.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35947-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nazar@mokrynskyi.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[mokrynskyi.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mokrynskyi.com:dkim,mokrynskyi.com:mid,openwrt.org:url]

I've been struggling with ath12k and even ath11k for years:
https://forum.openwrt.org/t/qcn9274-crashes-the-system-during-driver-load/239491?u=nazar-pc
https://forum.openwrt.org/t/qcn9074-doesnt-initialize-on-x86-64/163288?u=nazar-pc

With these patches it is finally possible to use QCN9274 under KVM with virtio.

First patch avoids global reset, allowing module to power on properly. Similar
patch should probably be added for ath11k too. Without this patch I was getting
the following:
```
[    6.856855] ath12k_pci 0000:01:00.0: BAR 0 [mem 0xfc600000-0xfc7fffff 64bit]: assigned
[    6.879292] ath12k_pci 0000:01:00.0: MSI vectors: 16
[    6.883931] ath12k_pci 0000:01:00.0: Hardware name: qcn9274 hw2.0
[    6.990901] ath12k_pci 0000:01:00.0: link down error during global reset
[    7.998602] ath12k_pci 0000:01:00.0: link failed to recover after global reset
[    8.011545] mhi mhi0: BHI offset: 0xffffffff is out of range: 0x200000
[    8.013095] ath12k_pci 0000:01:00.0: failed to set mhi state: INIT(0)
[    8.014588] ath12k_pci 0000:01:00.0: failed to start mhi: -34
[    8.016025] ath12k_pci 0000:01:00.0: failed to power up :-34
[    8.050113] ath12k_pci 0000:01:00.0: failed to create soc 0 core: -34
[    8.053079] ath12k_pci 0000:01:00.0: unable to create hw group
[    8.090241] ath12k_pci 0000:01:00.0: failed to init core: -34
[    8.554526] ath12k_pci 0000:01:00.0: probe with driver ath12k_pci failed with error -34
```

With the patch the process goes further:
```
[    6.897009] ath12k_pci 0000:01:00.0: BAR 0 [mem 0xfc600000-0xfc7fffff 64bit]: assigned
[    6.906501] ath12k_pci 0000:01:00.0: MSI vectors: 16
[    6.909033] ath12k_pci 0000:01:00.0: Hardware name: qcn9274 hw2.0
[    6.959630] mhi mhi0: Requested to power ON
[    6.960899] mhi mhi0: Power on setup success
[    7.128588] mhi mhi0: Wait for device to enter SBL or Mission mode
[    7.659325] ath12k_pci 0000:01:00.0: qmi dma allocation failed (20971520 B type 1), will try later with small size
[    7.670187] ath12k_pci 0000:01:00.0: memory type 10 not supported
[    7.674957] kmodloader: done loading kernel modules from /etc/modules.d/*
[    7.683773] ath12k_pci 0000:01:00.0: chip_id 0x0 chip_family 0xb board_id 0x1019 soc_id 0x401a2200
[    7.688137] ath12k_pci 0000:01:00.0: fw_version 0x160484db fw_build_timestamp 2025-12-09 20:09 fw_build_id QC_IMAGE_VERSION_STRING=WLAN.WBE.1.6-01243-QCAHKSWPL_SILICONZ-1
[   10.611560] ath12k_pci 0000:01:00.0: Invalid module id 2
[   10.616467] ath12k_pci 0000:01:00.0: failed to parse tlv -22
[   10.747508] debugfs: File 'simulate_fw_crash' in directory 'pci-0000:01:00.0' already present!
[   10.752188] debugfs: File 'device_dp_stats' in directory 'pci-0000:01:00.0' already present!
[   10.770705] ieee80211 phy0: copying sband (band 1) due to VHT EXT NSS BW flag
[   10.774844] debugfs: File 'ath12k' in directory 'phy0' already present!
[   13.968334] ath12k_pci 0000:01:00.0: failed to send WMI_PDEV_SET_PARAM cmd
[   13.971771] ath12k_pci 0000:01:00.0: failed to set ac override for ARP: -108
[   13.975315] ath12k_pci 0000:01:00.0: fail to start mac operations in pdev idx 0 ret -108
[   14.123699] ath12k_pci 0000:01:00.0: link down error during global reset
[   14.167537] mhi mhi0: BHI offset: 0xffffffff is out of range: 0x200000
[   14.169031] ath12k_pci 0000:01:00.0: failed to set mhi state: INIT(0)
[   14.170504] ath12k_pci 0000:01:00.0: failed to start mhi: -34
```

Second patch fixes an issue I had in OpenWRT, which may have been caused by
firmware upgrade:
```
[   10.611560] ath12k_pci 0000:01:00.0: Invalid module id 2
[   10.616467] ath12k_pci 0000:01:00.0: failed to parse tlv -22
```

My understanding is that it is fine to ignore unknown capability of the
firmware, it should not be required if driver doesn't know about it anyway.

I noticed a very similar code in ath11k, but wasn't sure if the change is needed
there too, so skipped it. Though I have a strong suspicion the same firmware
mismatch might happen there too.

With both of those I can finally use QCN9274 under KVM virtual machine with
virtio, at least with `pci=noaer` on the host. Without `pci=noaer` the module
still boots and works properly, but any attempt to shut down or reboot
inevitably crashes the host, which I reported to vfio maintainers, but I'd
appreciate cooperation from ath12k maintainers too:
https://lore.kernel.org/kvm/70de9b8f-b7c7-481b-8cb1-931e3b82eb0e@mokrynskyi.com/

Nazar Mokrynskyi (2):
  wifi: ath12k: skip PCIe global reset on initial power-up
  wifi: ath12k: skip unknown direct buffer ring module IDs

 drivers/net/wireless/ath/ath12k/pci.c |  3 ++-
 drivers/net/wireless/ath/ath12k/wmi.c | 12 ++++--------
 2 files changed, 6 insertions(+), 9 deletions(-)

--
2.43.0


