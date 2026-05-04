Return-Path: <linux-wireless+bounces-35883-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qBeVBYAM+Wks4wIAu9opvQ
	(envelope-from <linux-wireless+bounces-35883-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 04 May 2026 23:15:44 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CDF74C3EE8
	for <lists+linux-wireless@lfdr.de>; Mon, 04 May 2026 23:15:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C05A73005D03
	for <lists+linux-wireless@lfdr.de>; Mon,  4 May 2026 21:15:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0527F237180;
	Mon,  4 May 2026 21:15:40 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from gollum.nazgul.ch (gollum.nazgul.ch [82.197.176.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B668A1E9906
	for <linux-wireless@vger.kernel.org>; Mon,  4 May 2026 21:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.197.176.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777929339; cv=none; b=mrwJcRqMkJPpi0n9Xv7kuG4BnrWmWL1DAHsEz1RKNTkMm+t8wAhQylq17MHpp+80o0XBj6NOSj4UQ5pzGZciOF4VGdOzjv5hyOwVpPUV16XuF2Ppf1TjdKOSJ/cyZy4rLnymc+EBERBD6qWTqxLmIdxNxr3JOYJbrj7zZLx1GtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777929339; c=relaxed/simple;
	bh=mnBoYg2T9yuqNTevdKXRAVf9GnSkHkQoawstT2Nj8o0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=HLmtbUufqHJjT2qih6dh1sIJOtw0/Mv3oHLHXuDYQxfDlc9zgTpIPAOT04Gj9ZdncvyaxHE5Vnk+S5Z6TKTMEbOq5ZzccU+JcL3+AI9mnVz8qJNJyeegoDaUiOy0RoD+HOyLVcp5OMYdkXcQJw5S740NZEjICmi5M0QntCN4mW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nazgul.ch; spf=pass smtp.mailfrom=nazgul.ch; arc=none smtp.client-ip=82.197.176.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nazgul.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nazgul.ch
Received: from localhost (gollum.nazgul.ch [local])
	by gollum.nazgul.ch (OpenSMTPD) with ESMTPA id 024d991b;
	Mon, 4 May 2026 23:08:54 +0200 (CEST)
Date: Mon, 4 May 2026 23:08:54 +0200
From: Marcus Glocker <marcus@nazgul.ch>
To: ath12k@lists.infradead.org, linux-wireless@vger.kernel.org
Cc: jjohnson@kernel.org, kvalo@kernel.org, 
	manivannan.sadhasivam@linaro.org, Mark Kettenis <mark.kettenis@xs4all.nl>
Subject: ath12k WCN7850: Q6 Hexagon fault at WLAON region 0x1792000 ~2s
 post-AUTHORIZE on X1E80100
Message-ID: <g7dkeq3uwg7eby57zcuu5eysf4tqomh5civlvkpnlziipn6xis@45eevyzgfmaq>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Rspamd-Queue-Id: 2CDF74C3EE8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[nazgul.ch];
	TAGGED_FROM(0.00)[bounces-35883-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,linaro.org,xs4all.nl];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-0.969];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[marcus@nazgul.ch,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nazgul.ch:url,nazgul.ch:email]

Hi,

We're porting ath12k to OpenBSD as the qwz(4) driver, targeting Samsung
Galaxy Book4 Edge (X1E80100 SoC, WCN7850 hw2.0).  Scan, auth, 4-way
handshake all complete; ~2 seconds after WPA2 AUTHORIZE the WCN7850
firmware crashes deterministically with:

	dlpager_main.c:147 Non Page Fault Exception cause code 0x 23
	at Address: 0x 1792000

Cause code 0x23 isn't a valid arm64 exception -- the fault is on the
WCN7850's on-die Hexagon Q6 DSP, with QURT's generic exception handler
(which happens to live in dlpager_main.c) printing it.  So this is not
a host CPU fault.

Per the RDDM segment table (at the start of the dump), VA 0x01792000
is the start of the chip's WLAON_DUMP region (size 0x820).  The Q6 is
trying to read its own always-on hardware state region and the chip
refuses the access.

(Samsung, Asus, Honor) with multiple FW builds.  Currently testing
with WLAN.HMT.1.1.c5-00302-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.115823.3
(fw 0x110cffff, 2025-06-25) -- the exact blob a Linux ath12k user
runs successfully on the identical Samsung hardware.  Same board-2.bin,
same compiled DTB (upstream hamoa.dtsi based).

We've field-compared qwz against ath12k and ruled out (byte-level or
wire-level):

  * QMI host_cap, m3_info, wlan_cfg, wlan_ini, bdf_download (all
    fields including ce_config, svc_to_ce_map, shadow_reg_v3,
    feature_list, m3 paddr/size, nm_modem)
  * MHI bringup ordering (BHI -> wait SBL EE -> wait M0 -> BHIE)
  * BHI/BHIE DMA coherency
  * ASPM disable before MHI start
  * WLAON_WARM_SW_ENTRY zeroing + QFPROM_PWR_CTRL VDD4BLOW clear
  * static_window_map=false + window-bank register init
  * Per-chunk vs monolithic respond_mem allocation
  * WMI_PEER_MIMO_PS_STATE = WMI_PEER_SMPS_PS_NONE (added matching
    ath12k_setup_peer_smps; doesn't help)
  * FW image variation (c5 and c7 both fail identically)

Specifically NOT involved (we have evidence either way):

  * Gunyah -- X1E80100 is reportedly run in EL2 without Gunyah by
    users where ath12k works; so Gunyah isn't programming WLAON
    access for the Q6.
  * SMMU / pcie_smmu -- pcie_smmu is status="reserved" upstream,
    pcie4 has no iommus property; PCIe DMA bypasses SMMU.
  * SCM/PAS -- ath12k's PCIe path makes no qcom_scm_* calls.

Question: what subsystem inside the WCN7850 firmware touches the
WLAON region at 0x01792000 around 2 seconds after the host sends
WMI_PEER_AUTHORIZE?  And what host-side configuration (WMI command,
HTT message, MHI state, etc.) primes that path so the access
succeeds on Linux?

Even a pointer at the right Linux code path or the right FW-side
component would unblock us.  We have full RDDM dumps and dmesg
captures available; happy to share off-list or as attachments.

Thanks,
Marcus

-- 

[ -- Marcus Glocker, marcus@nazgul.ch, https://nazgul.ch ------------- ]

