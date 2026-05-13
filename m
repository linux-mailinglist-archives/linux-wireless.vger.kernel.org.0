Return-Path: <linux-wireless+bounces-36383-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id COcNElBhBGq6HgIAu9opvQ
	(envelope-from <linux-wireless+bounces-36383-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 13 May 2026 13:32:32 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BA63D532557
	for <lists+linux-wireless@lfdr.de>; Wed, 13 May 2026 13:32:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5560F302F59B
	for <lists+linux-wireless@lfdr.de>; Wed, 13 May 2026 11:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2AD23A6B8B;
	Wed, 13 May 2026 11:26:54 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from gollum.nazgul.ch (gollum.nazgul.ch [82.197.176.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 710FD2C027A
	for <linux-wireless@vger.kernel.org>; Wed, 13 May 2026 11:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.197.176.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778671614; cv=none; b=WN7+FfeMH009sDOQmtQEhNdRwsi33HyyRZ2j5EzpmTWH+wz0y1UPdO3OygZAzDpFNWYd5g27Ch+C62v1HXC8NfGO+UnqTCEr7ybEB0iyQNrUKgZvyWUOq+5DA8J84r9j+XSFFgQNQXBHrdiHWmzY0ZylmqclaCnnfr5fJlsAodU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778671614; c=relaxed/simple;
	bh=2UYCJxfioedOZZv6jpLq87SCJoZwFtNqbyqa/Ui/H1g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ErF25K8MVDbufD5drkDiIaeRaMsYXCT4Q8OWrIlvoyA5VnNEpVOkchwFOhk7c+I3Z4+EM4Z6E9anCEwOraJJkLcyiaTKQqNqBAskLO6vk3gdZ6jOCYcb6KC0mL4fv7o+ya2roAxMtMe46jJwsL68OQWjQ5zCr8OV9oHJT0qooW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nazgul.ch; spf=pass smtp.mailfrom=nazgul.ch; arc=none smtp.client-ip=82.197.176.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nazgul.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nazgul.ch
Received: from localhost (gollum.nazgul.ch [local])
	by gollum.nazgul.ch (OpenSMTPD) with ESMTPA id c8f6739e;
	Wed, 13 May 2026 13:26:49 +0200 (CEST)
Date: Wed, 13 May 2026 13:26:49 +0200
From: Marcus Glocker <marcus@nazgul.ch>
To: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Cc: Maxim Storetvedt <m.tvedt@tutanota.com>, ath12k@lists.infradead.org, 
	linux-wireless@vger.kernel.org, jjohnson@kernel.org, kvalo@kernel.org, 
	Mark Kettenis <mark.kettenis@xs4all.nl>
Subject: Re: ath12k WCN7850: Q6 Hexagon fault at WLAON region 0x1792000 ~2s
 post-AUTHORIZE on X1E80100
Message-ID: <cz6dbqafvulifyrefsxzwrlq5z5uojylphqkq5oydbn2bvcns5@bhj3hr2rvxhq>
References: <g7dkeq3uwg7eby57zcuu5eysf4tqomh5civlvkpnlziipn6xis@45eevyzgfmaq>
 <0b450204-9afc-4ba1-b9c5-1876b5a7078a@oss.qualcomm.com>
 <tzkh5t3bmiqff67g72rihapizz2u2dlj4xfrr324d6yg4rtltt@3qrsymzw7c2c>
 <92ace4b9-143e-4962-90fa-215a22e24796@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <92ace4b9-143e-4962-90fa-215a22e24796@oss.qualcomm.com>
X-Rspamd-Queue-Id: BA63D532557
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-36383-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[nazgul.ch];
	FREEMAIL_CC(0.00)[tutanota.com,lists.infradead.org,vger.kernel.org,kernel.org,xs4all.nl];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[marcus@nazgul.ch,linux-wireless@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nazgul.ch:url]
X-Rspamd-Action: no action

On Wed, May 13, 2026 at 11:05:05AM +0800, Baochen Qiang wrote:

> 
> 
> On 5/13/2026 3:59 AM, Marcus Glocker wrote:
> > On Tue, May 12, 2026 at 11:38:06AM +0800, Baochen Qiang wrote:
> > 
> >>
> >>
> >> On 5/5/2026 5:08 AM, Marcus Glocker wrote:
> >>> Hi,
> >>>
> >>> We're porting ath12k to OpenBSD as the qwz(4) driver, targeting Samsung
> >>> Galaxy Book4 Edge (X1E80100 SoC, WCN7850 hw2.0).  Scan, auth, 4-way
> >>> handshake all complete; ~2 seconds after WPA2 AUTHORIZE the WCN7850
> >>> firmware crashes deterministically with:
> >>>
> >>> 	dlpager_main.c:147 Non Page Fault Exception cause code 0x 23
> >>> 	at Address: 0x 1792000
> >>>
> >>> Cause code 0x23 isn't a valid arm64 exception -- the fault is on the
> >>> WCN7850's on-die Hexagon Q6 DSP, with QURT's generic exception handler
> >>> (which happens to live in dlpager_main.c) printing it.  So this is not
> >>> a host CPU fault.
> >>>
> >>> Per the RDDM segment table (at the start of the dump), VA 0x01792000
> >>> is the start of the chip's WLAON_DUMP region (size 0x820).  The Q6 is
> >>> trying to read its own always-on hardware state region and the chip
> >>> refuses the access.
> >>>
> >>> (Samsung, Asus, Honor) with multiple FW builds.  Currently testing
> >>> with WLAN.HMT.1.1.c5-00302-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.115823.3
> >>> (fw 0x110cffff, 2025-06-25) -- the exact blob a Linux ath12k user
> >>> runs successfully on the identical Samsung hardware.  Same board-2.bin,
> >>> same compiled DTB (upstream hamoa.dtsi based).
> >>>
> >>> We've field-compared qwz against ath12k and ruled out (byte-level or
> >>> wire-level):
> >>>
> >>>   * QMI host_cap, m3_info, wlan_cfg, wlan_ini, bdf_download (all
> >>>     fields including ce_config, svc_to_ce_map, shadow_reg_v3,
> >>>     feature_list, m3 paddr/size, nm_modem)
> >>>   * MHI bringup ordering (BHI -> wait SBL EE -> wait M0 -> BHIE)
> >>>   * BHI/BHIE DMA coherency
> >>>   * ASPM disable before MHI start
> >>>   * WLAON_WARM_SW_ENTRY zeroing + QFPROM_PWR_CTRL VDD4BLOW clear
> >>>   * static_window_map=false + window-bank register init
> >>>   * Per-chunk vs monolithic respond_mem allocation
> >>>   * WMI_PEER_MIMO_PS_STATE = WMI_PEER_SMPS_PS_NONE (added matching
> >>>     ath12k_setup_peer_smps; doesn't help)
> >>>   * FW image variation (c5 and c7 both fail identically)
> >>>
> >>> Specifically NOT involved (we have evidence either way):
> >>>
> >>>   * Gunyah -- X1E80100 is reportedly run in EL2 without Gunyah by
> >>>     users where ath12k works; so Gunyah isn't programming WLAON
> >>>     access for the Q6.
> >>>   * SMMU / pcie_smmu -- pcie_smmu is status="reserved" upstream,
> >>>     pcie4 has no iommus property; PCIe DMA bypasses SMMU.
> >>>   * SCM/PAS -- ath12k's PCIe path makes no qcom_scm_* calls.
> >>>
> >>> Question: what subsystem inside the WCN7850 firmware touches the
> >>> WLAON region at 0x01792000 around 2 seconds after the host sends
> >>> WMI_PEER_AUTHORIZE?  And what host-side configuration (WMI command,
> >>> HTT message, MHI state, etc.) primes that path so the access
> >>> succeeds on Linux?
> >>>
> >>> Even a pointer at the right Linux code path or the right FW-side
> >>> component would unblock us.  We have full RDDM dumps and dmesg
> >>> captures available; happy to share off-list or as attachments.
> >>
> >> please help collect ath12k successful dmesg log and qwz failed dmesg log for compare.
> >>
> >> Please enable verbose ath12k log when loading ath12k driver:
> >>
> >> If you are using the latest upstream ath12k:
> >>
> >> 	sudo modprobe ath12k debug_mask=0xffffffff
> >> 	sudo modprobe ath12k_wifi7
> >>
> >> If you are using an old ath12k:
> >>
> >> 	sudo modprobe ath12k debug_mask=0xffffffff
> >>
> >>>
> >>> Thanks,
> >>> Marcus
> >>>
> >>
> > 
> > Hi Baochen,
> >                                         
> > Thanks for coming back on this topic.
> >                                         
> > Attached the OpenBSD dmesg, with full ath12k driver debug logging
> 
> the dmesg shows several WMI_INIT cmd instances which is not expected, because in normal
> operation this command should be sent only once.
> 
> cat dmesg |grep -w 'sending WMI command 0x1'
> May 12 19:35:46 x1e /bsd: qwz_wmi_cmd_send_nowait: sending WMI command 0x1
> May 12 19:37:20 x1e /bsd: qwz_wmi_cmd_send_nowait: sending WMI command 0x1
> May 12 19:37:41 x1e /bsd: qwz_wmi_cmd_send_nowait: sending WMI command 0x1
> May 12 19:37:46 x1e /bsd: qwz_wmi_cmd_send_nowait: sending WMI command 0x1
> May 12 19:37:50 x1e /bsd: qwz_wmi_cmd_send_nowait: sending WMI command 0x1
> 
> other than that I don't find any other clues.

Yes, that is specific to the OpenBSD NIC framework.  I've just tested
a quick hack with which the WMI_INIT cmd only gets issued once, but it
makes no difference to the firmware crash.
 
> > enabled, plus the resulting RDDM binary after the firmware crash:
> 
> how did you collect the RDDM binary, seems not in the right format, my tool can not parse
> it correctly. Looking into the binary, at least the magic 'ATH12K-FW-DUMP' is not present
> at the very beginning.

It looks like ath12k wraps the raw RDDM dump in some ath12k firmware
dump structure, which we don't do with our driver.  I did write a small
conversion program, trying to generate the dump which you expect.  You
can find the converted dump file here:

https://nazgul.ch/pub/qwz0-rddm.bin.out.gz

I hope you can load that in to your tool.

> And from which Linux version you take the ath12k codebase?

Well, that is a good question.  qwz (the ath12k OpenBSD driver), is
an initial clone of the qwx (the ath11k OpenBSD driver), which is
functional.  On top of that we did changes, of which the recent ones
did sync missing functionality from the Linux ath12k driver.  We did
already do a lot of comparison between qwz and the ath12k driver, but
we can't spot an obvious difference which could explain the firmware
crash.  Obviously doesn't mean that there isn't a gap between qwz and
ath12k related to this issue which we don't see.

> > 
> > https://nazgul.ch/pub/qwz0-rddm.bin.gz
> >                                         
> > The command sequence on OpenBSD to re-produce that was:
> >                                         
> > ifconfig qwz0 up                        # Bring the ath12k device up
> > ifconfig qwz0 scan                      # Scan for networks
> > ifconfig qwz0 nwid nazgul wpakey xxx    # Start association
> >                                         
> > Hi Max,
> >                                         
> > Since you have Linux running on exactly the same Samsung Galaxy Book4
> > Edge 14" laptop, where ath12k works, would you be so kind and also
> > provide the dmesg output showing an successful association with the
> > ath12k driver debug logging enabled?  See above how to enable that.
> > That would be very helpful!
> >                                         
> > Thanks and Regards,
> > Marcus
> 

