Return-Path: <linux-wireless+bounces-9697-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E211E91BFB6
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Jun 2024 15:39:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E80211C21D31
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Jun 2024 13:39:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B5C91BE874;
	Fri, 28 Jun 2024 13:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dm5tt.de header.i=@dm5tt.de header.b="M89tBEc7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [188.68.63.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89BEA1DA23
	for <linux-wireless@vger.kernel.org>; Fri, 28 Jun 2024 13:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.68.63.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719581818; cv=none; b=Dmtmmn9lFf0EG0necCwK+PYkovN84yqrUpAZ53R+qrPhqe9wdQbUUFMi1qVO7sDttG9X86lEnJDbfJRVHPecfUlLRrChF4qcJ3C7FlZLvfMPlKePKzT+6wb9wDZ/afh66WNhTxvrO5r1aPFL/gsK+wPEMpwqiAgw4/LXsT6S9zI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719581818; c=relaxed/simple;
	bh=XRSDHaJ2E27jcKVuIZwvbeBq1F24pc3mlmsw+BKsjMc=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=VKmf4peObYXJYC17HONTRw4rnR+IAVM4RoryafZXC3e/cpHlkL2cpux5NHB5CqtBhLYXdcK5VTo8jZ1tvVCZ+glx2x+SsqVxbewUX0ll+bVUkssOhSWICF90Y8pb3wyc2/kXSDhAdIUIaspxh3OJT4pYbElBYOPVlBVmpRx5RHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dm5tt.de; spf=pass smtp.mailfrom=dm5tt.de; dkim=pass (2048-bit key) header.d=dm5tt.de header.i=@dm5tt.de header.b=M89tBEc7; arc=none smtp.client-ip=188.68.63.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dm5tt.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dm5tt.de
Received: from mors-relay-2501.netcup.net (localhost [127.0.0.1])
	by mors-relay-2501.netcup.net (Postfix) with ESMTPS id 4W9br35J4dz63RS
	for <linux-wireless@vger.kernel.org>; Fri, 28 Jun 2024 15:29:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dm5tt.de; s=key2;
	t=1719581347; bh=XRSDHaJ2E27jcKVuIZwvbeBq1F24pc3mlmsw+BKsjMc=;
	h=Date:To:From:Subject:From;
	b=M89tBEc70I5xgNIysHMfRTAFHiGLryfUn0Jz/MCqqujgkiME5mX3dEx/oaymQgPr/
	 qwMcTbrrrGitm3eFlLRseY3ZKY7Ca6SYfL6o1fTUNSGldxedmd2PZqHi0TJPOe7Yur
	 PZg8ACG1X6CibBtghyH+FTU6uRieYp8FP9UCjlswctgGJwBUGzNcbruvotdGnPKBJW
	 3ozHbMP7kvRiz1SjnYcJ4f1PYI1i1WbeEyf9BalWkZRNeCrnUHowU723/5MeA2rQ2k
	 7fRfkfJxyf1eoZ2/vCJsSPzxl0DPVL0THODAShzpq/rFxuhitB+9sx9T8jyDk2S5wi
	 pxU/3gtj28SZA==
Received: from policy01-mors.netcup.net (unknown [46.38.225.35])
	by mors-relay-2501.netcup.net (Postfix) with ESMTPS id 4W9br34Sl0z4xhg
	for <linux-wireless@vger.kernel.org>; Fri, 28 Jun 2024 15:29:07 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at policy01-mors.netcup.net
X-Spam-Flag: NO
X-Spam-Score: -2.898
X-Spam-Level: 
Received: from mxe8c3.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy01-mors.netcup.net (Postfix) with ESMTPS id 4W9br24Rrjz8tXN
	for <linux-wireless@vger.kernel.org>; Fri, 28 Jun 2024 15:29:06 +0200 (CEST)
Received: from [IPV6:2a02:3100:5d17:cc01:aba0:5683:fb05:8c66] (dynamic-2a02-3100-5d17-cc01-aba0-5683-fb05-8c66.310.pool.telefonica.de [IPv6:2a02:3100:5d17:cc01:aba0:5683:fb05:8c66])
	by mxe8c3.netcup.net (Postfix) with ESMTPSA id 160191C00B3
	for <linux-wireless@vger.kernel.org>; Fri, 28 Jun 2024 15:29:02 +0200 (CEST)
Authentication-Results: mxe8c3;
        spf=pass (sender IP is 2a02:3100:5d17:cc01:aba0:5683:fb05:8c66) smtp.mailfrom=mail@dm5tt.de smtp.helo=[IPV6:2a02:3100:5d17:cc01:aba0:5683:fb05:8c66]
Received-SPF: pass (mxe8c3: connection is authenticated)
Message-ID: <71cfa27d-96de-49b0-89dd-661b6df37b64@dm5tt.de>
Date: Fri, 28 Jun 2024 15:29:01 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: linux-wireless@vger.kernel.org
From: "Holger Adams, DM5TT" <mail@dm5tt.de>
Subject: Kernel 6.9.6, iwlwifi with an Intel AX210 sporadically fails after
 resuming from Suspend to RAM
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-PPP-Message-ID: <171958134233.987287.8507679072547944636@mxe8c3.netcup.net>
X-NC-CID: mD7c4ooh+xlb1Y8BxhLw9vJjq+llkEGOwMnVnbA=
X-Rspamd-Queue-Id: 160191C00B3
X-Rspamd-Server: rspamd-worker-8404

Hello!

After resuming from Suspend to RAM my Intel AX210 seems to fail 
sporadically. During that behavior it's spitting out error related 
messages into the kernel log.

I can't exactly remember when this bug was introduced - but pretty sure 
it was between 6.8.x -> 6.9.x.

Because of its sporadic behavior I wasn't able to bisect it.

Bug Ticket OpenSUSE: https://bugzilla.suse.com/show_bug.cgi?id=1226309

Please CC me if there are further questions as I'm not subscribed.

Best Regards,
Holger


Non-wrapped log: 
https://nc.holad.de/s/Hp3Zm6MEXsWcLyc/download/had_ax210_6.9.6_kernel_bug.txt

[ 8247.686118] [  T57781] ACPI: PM: Restoring platform NVS memory
[ 8247.686356] [  T57781] LVT offset 0 assigned for vector 0x400
[ 8247.687000] [  T57781] Enabling non-boot CPUs ...
[ 8247.687028] [  T57781] smpboot: Booting Node 0 Processor 1 APIC 0x2
[ 8247.692394] [  T57781] CPU1 is up
[ 8247.692404] [  T57781] smpboot: Booting Node 0 Processor 2 APIC 0x4
[ 8247.695709] [  T57781] CPU2 is up
[ 8247.695719] [  T57781] smpboot: Booting Node 0 Processor 3 APIC 0x6
(...)
[ 8247.768260] [  T57781] ACPI: PM: Waking up from system sleep state S3
[ 8247.768926] [  T57781] ACPI: EC: interrupt unblocked
[ 8247.771702] [  T57781] ACPI: EC: event unblocked
[ 8247.771759] [  T57562] xhci_hcd 0000:02:00.0: xHC error in resume, 
USBSTS 0x401, Reinit
[ 8247.771762] [  T57562] usb usb1: root hub lost power or was reset
[ 8247.771763] [  T57562] usb usb2: root hub lost power or was reset
[ 8247.772392] [  T57781] serial 00:04: activated

[ 8247.779971] [  T57845] iwlwifi 0000:07:00.0: WRT: Invalid buffer 
destination
[ 8247.833734] [  T57825] nvme nvme0: 8/0/0 default/read/poll queues
[ 8247.852637] [  T51159] nvme nvme1: 8/0/0 default/read/poll queues
[ 8247.890444] [  T57539] [drm] PCIE GART of 256M enabled (table at 
0x000000F400300000).
[ 8247.941139] [  T57845] iwlwifi 0000:07:00.0: 
WFPM_UMAC_PD_NOTIFICATION: 0x20
[ 8247.941153] [  T57845] iwlwifi 0000:07:00.0: 
WFPM_LMAC2_PD_NOTIFICATION: 0x1f
[ 8247.941166] [  T57845] iwlwifi 0000:07:00.0: WFPM_AUTH_KEY_0: 0x90
[ 8247.941179] [  T57845] iwlwifi 0000:07:00.0: CNVI_SCU_SEQ_DATA_DW9: 0x0
[ 8248.085135] [    T798] ata2: SATA link down (SStatus 0 SControl 330)
[ 8248.085160] [    T796] ata1: SATA link down (SStatus 0 SControl 330)
[ 8248.085182] [    T806] ata6: SATA link down (SStatus 0 SControl 330)
[ 8248.205677] [  T57845] iwlwifi 0000:07:00.0: Timeout waiting for PNVM 
load!
[ 8248.205679] [  T57845] iwlwifi 0000:07:00.0: Failed to start RT 
ucode: -110
[ 8248.205680] [  T57845] iwlwifi 0000:07:00.0: Failed to start RT 
ucode: -110
[ 8248.205681] [  T57845] iwlwifi 0000:07:00.0: WRT: Collecting data: 
ini trigger 13 fired (delay=0ms).
[ 8248.206805] [  T57845] iwlwifi 0000:07:00.0: Start IWL Error Log Dump:
[ 8248.206805] [  T57845] iwlwifi 0000:07:00.0: Transport status: 
0x00000042, valid: 6
[ 8248.206806] [  T57845] iwlwifi 0000:07:00.0: Loaded firmware version: 
89.202a2f7b.0 ty-a0-gf-a0-89.ucode
[ 8248.206807] [  T57845] iwlwifi 0000:07:00.0: 0x00000084 | 
NMI_INTERRUPT_UNKNOWN
[ 8248.206808] [  T57845] iwlwifi 0000:07:00.0: 0x002002F0 | trm_hw_status0
[ 8248.206809] [  T57845] iwlwifi 0000:07:00.0: 0x00000000 | trm_hw_status1
[ 8248.206810] [  T57845] iwlwifi 0000:07:00.0: 0x004DAD6C | branchlink2
[ 8248.206810] [  T57845] iwlwifi 0000:07:00.0: 0x004D09AE | interruptlink1
[ 8248.206811] [  T57845] iwlwifi 0000:07:00.0: 0x004D09AE | interruptlink2
[ 8248.206811] [  T57845] iwlwifi 0000:07:00.0: 0x0001668E | data1
[ 8248.206812] [  T57845] iwlwifi 0000:07:00.0: 0x01000000 | data2
[ 8248.206812] [  T57845] iwlwifi 0000:07:00.0: 0x00000000 | data3
[ 8248.206813] [  T57845] iwlwifi 0000:07:00.0: 0x00000000 | beacon time
[ 8248.206813] [  T57845] iwlwifi 0000:07:00.0: 0x00053DC4 | tsf low
[ 8248.206814] [  T57845] iwlwifi 0000:07:00.0: 0x00000000 | tsf hi
[ 8248.206814] [  T57845] iwlwifi 0000:07:00.0: 0x00000000 | time gp1
[ 8248.206814] [  T57845] iwlwifi 0000:07:00.0: 0x00067E45 | time gp2
[ 8248.206815] [  T57845] iwlwifi 0000:07:00.0: 0x00000001 | uCode 
revision type
[ 8248.206815] [  T57845] iwlwifi 0000:07:00.0: 0x00000059 | uCode 
version major
[ 8248.206816] [  T57845] iwlwifi 0000:07:00.0: 0x202A2F7B | uCode 
version minor
[ 8248.206816] [  T57845] iwlwifi 0000:07:00.0: 0x00000420 | hw version
[ 8248.206817] [  T57845] iwlwifi 0000:07:00.0: 0x00C80002 | board version
[ 8248.206817] [  T57845] iwlwifi 0000:07:00.0: 0x8005FC12 | hcmd
[ 8248.206818] [  T57845] iwlwifi 0000:07:00.0: 0x00020000 | isr0
[ 8248.206818] [  T57845] iwlwifi 0000:07:00.0: 0x00000000 | isr1
[ 8248.206819] [  T57845] iwlwifi 0000:07:00.0: 0x48F00002 | isr2
[ 8248.206819] [  T57845] iwlwifi 0000:07:00.0: 0x00C0001C | isr3
[ 8248.206820] [  T57845] iwlwifi 0000:07:00.0: 0x00000000 | isr4
[ 8248.206820] [  T57845] iwlwifi 0000:07:00.0: 0x00000000 | last cmd Id
[ 8248.206821] [  T57845] iwlwifi 0000:07:00.0: 0x0001668E | wait_event
[ 8248.206821] [  T57845] iwlwifi 0000:07:00.0: 0x00000000 | l2p_control
[ 8248.206822] [  T57845] iwlwifi 0000:07:00.0: 0x00000000 | l2p_duration
[ 8248.206822] [  T57845] iwlwifi 0000:07:00.0: 0x00000000 | l2p_mhvalid
[ 8248.206822] [  T57845] iwlwifi 0000:07:00.0: 0x00000000 | l2p_addr_match
[ 8248.206823] [  T57845] iwlwifi 0000:07:00.0: 0x00000009 | lmpm_pmg_sel
[ 8248.206823] [  T57845] iwlwifi 0000:07:00.0: 0x00000000 | timestamp
[ 8248.206824] [  T57845] iwlwifi 0000:07:00.0: 0x00000020 | flow_handler
[ 8248.206867] [  T57845] iwlwifi 0000:07:00.0: Start IWL Error Log Dump:
[ 8248.206868] [  T57845] iwlwifi 0000:07:00.0: Transport status: 
0x00000042, valid: 7
[ 8248.206869] [  T57845] iwlwifi 0000:07:00.0: 0x20000066 | 
NMI_INTERRUPT_HOST
[ 8248.206869] [  T57845] iwlwifi 0000:07:00.0: 0x00000000 | umac 
branchlink1
[ 8248.206870] [  T57845] iwlwifi 0000:07:00.0: 0x804838B2 | umac 
branchlink2
[ 8248.206870] [  T57845] iwlwifi 0000:07:00.0: 0x804A5AB2 | umac 
interruptlink1
[ 8248.206871] [  T57845] iwlwifi 0000:07:00.0: 0x804A5AB2 | umac 
interruptlink2
[ 8248.206871] [  T57845] iwlwifi 0000:07:00.0: 0x01000000 | umac data1
[ 8248.206872] [  T57845] iwlwifi 0000:07:00.0: 0x804A5AB2 | umac data2
[ 8248.206872] [  T57845] iwlwifi 0000:07:00.0: 0x00000000 | umac data3
[ 8248.206873] [  T57845] iwlwifi 0000:07:00.0: 0x00000059 | umac major
[ 8248.206873] [  T57845] iwlwifi 0000:07:00.0: 0x202A2F7B | umac minor
[ 8248.206874] [  T57845] iwlwifi 0000:07:00.0: 0x00067E43 | frame pointer
[ 8248.206874] [  T57845] iwlwifi 0000:07:00.0: 0xC0886258 | stack pointer
[ 8248.206875] [  T57845] iwlwifi 0000:07:00.0: 0x00000000 | last host cmd
[ 8248.206875] [  T57845] iwlwifi 0000:07:00.0: 0x00000400 | isr status reg
[ 8248.206888] [  T57845] iwlwifi 0000:07:00.0: IML/ROM dump:
[ 8248.206888] [  T57845] iwlwifi 0000:07:00.0: 0x00000B03 | IML/ROM 
error/state
[ 8248.206901] [  T57845] iwlwifi 0000:07:00.0: 0x0000807B | IML/ROM data1
[ 8248.206914] [  T57845] iwlwifi 0000:07:00.0: 0x00000090 | IML/ROM 
WFPM_AUTH_KEY_0
[ 8248.206922] [  T57845] iwlwifi 0000:07:00.0: Fseq Registers:
[ 8248.206925] [  T57845] iwlwifi 0000:07:00.0: 0x20000000 | FSEQ_ERROR_CODE
[ 8248.206928] [  T57845] iwlwifi 0000:07:00.0: 0x80440007 | 
FSEQ_TOP_INIT_VERSION
[ 8248.206932] [  T57845] iwlwifi 0000:07:00.0: 0x00080009 | 
FSEQ_CNVIO_INIT_VERSION
[ 8248.206935] [  T57845] iwlwifi 0000:07:00.0: 0x0000A652 | 
FSEQ_OTP_VERSION
[ 8248.206939] [  T57845] iwlwifi 0000:07:00.0: 0x00000002 | 
FSEQ_TOP_CONTENT_VERSION
[ 8248.206942] [  T57845] iwlwifi 0000:07:00.0: 0x4552414E | 
FSEQ_ALIVE_TOKEN
[ 8248.206945] [  T57845] iwlwifi 0000:07:00.0: 0x00400410 | FSEQ_CNVI_ID
[ 8248.206949] [  T57845] iwlwifi 0000:07:00.0: 0x00400410 | FSEQ_CNVR_ID
[ 8248.206952] [  T57845] iwlwifi 0000:07:00.0: 0x00400410 | 
CNVI_AUX_MISC_CHIP
[ 8248.206957] [  T57845] iwlwifi 0000:07:00.0: 0x00400410 | 
CNVR_AUX_MISC_CHIP
[ 8248.206963] [  T57845] iwlwifi 0000:07:00.0: 0x00009061 | 
CNVR_SCU_SD_REGS_SD_REG_DIG_DCDC_VTRIM
[ 8248.206969] [  T57845] iwlwifi 0000:07:00.0: 0x00000061 | 
CNVR_SCU_SD_REGS_SD_REG_ACTIVE_VDIG_MIRROR
[ 8248.206972] [  T57845] iwlwifi 0000:07:00.0: 0x00000000 | 
FSEQ_PREV_CNVIO_INIT_VERSION
[ 8248.206975] [  T57845] iwlwifi 0000:07:00.0: 0x00440007 | 
FSEQ_WIFI_FSEQ_VERSION
[ 8248.206979] [  T57845] iwlwifi 0000:07:00.0: 0x5F5C074A | 
FSEQ_BT_FSEQ_VERSION
[ 8248.206982] [  T57845] iwlwifi 0000:07:00.0: 0x000000E6 | 
FSEQ_CLASS_TP_VERSION
[ 8248.206995] [  T57845] iwlwifi 0000:07:00.0: UMAC CURRENT PC: 0x804a5578
[ 8248.206998] [  T57845] iwlwifi 0000:07:00.0: LMAC1 CURRENT PC: 0xd0
[ 8248.209907] [  T57539] amdgpu 0000:09:00.0: 
[drm:amdgpu_ring_test_helper [amdgpu]] *ERROR* ring comp_1.1.0 test 
failed (-110)
[ 8248.477017] [  T57539] amdgpu 0000:09:00.0: 
[drm:amdgpu_ring_test_helper [amdgpu]] *ERROR* ring comp_1.2.0 test 
failed (-110)
[ 8248.744066] [  T57539] amdgpu 0000:09:00.0: 
[drm:amdgpu_ring_test_helper [amdgpu]] *ERROR* ring comp_1.2.1 test 
failed (-110)


[ 8248.958225] [  T57845] ------------[ cut here ]------------
[ 8248.958225] [  T57845] Hardware became unavailable upon resume. This 
could be a software issue prior to suspend or a hardware issue.
[ 8248.958241] [  T57845] WARNING: CPU: 4 PID: 57845 at 
net/mac80211/util.c:1822 ieee80211_reconfig+0x9c/0x14b0 [mac80211]
[ 8248.958282] [  T57845] Modules linked in: rfcomm snd_seq_dummy 
snd_hrtimer snd_seq ccm af_packet nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 
nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct 
nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 
nf_tables vboxnetadp(O) vboxnetflt(O) qrtr vboxdrv(O) cmac algif_hash 
algif_skcipher af_alg bnep nls_iso8859_1 nls_cp437 vfat fat btusb iwlmvm 
uvcvideo btrtl snd_hda_codec_realtek btintel videobuf2_vmalloc btbcm uvc 
snd_hda_codec_generic btmtk snd_hda_scodec_component snd_hda_codec_hdmi 
mac80211 snd_usb_audio videobuf2_memops intel_rapl_msr bluetooth 
videobuf2_v4l2 snd_usbmidi_lib amd_atl libarc4 intel_rapl_common 
videodev joydev snd_ump snd_hda_intel edac_mce_amd snd_intel_dspcfg 
videobuf2_common snd_rawmidi snd_intel_sdw_acpi snd_seq_device 
ecdh_generic eeepc_wmi mc snd_hda_codec iwlwifi asus_wmi snd_hda_core 
kvm_amd snd_hwdep asus_wmi_sensors battery snd_pcm platform_profile 
cfg80211 igb kvm sparse_keymap dca snd_timer rfkill snd mxm_wmi wmi_bmof 
soundcore
[ 8248.958310] [  T57845]  k10temp pcspkr i2c_piix4 acpi_cpufreq 
gpio_amdpt gpio_generic tiny_power_button button tcp_bbr sch_fq fuse 
efi_pstore nvme_fabrics loop configfs nfnetlink dmi_sysfs ip_tables 
x_tables hid_logitech_hidpp dm_crypt essiv authenc trusted asn1_encoder 
tee hid_logitech_dj hid_plantronics hid_generic usbhid amdgpu ahci 
crct10dif_pclmul crc32_pclmul libahci polyval_clmulni polyval_generic 
gf128mul libata video amdxcp i2c_algo_bit ghash_clmulni_intel 
drm_ttm_helper sd_mod ttm sha512_ssse3 drm_exec scsi_dh_emc sha256_ssse3 
gpu_sched scsi_dh_rdac xhci_pci scsi_dh_alua sha1_ssse3 xhci_pci_renesas 
drm_suballoc_helper xhci_hcd drm_buddy sg nvme aesni_intel 
drm_display_helper crypto_simd usbcore scsi_mod nvme_core ccp cryptd cec 
sp5100_tco rc_core nvme_auth scsi_common t10_pi wmi btrfs 
blake2b_generic libcrc32c crc32c_intel xor raid6_pq dm_mod msr i2c_dev 
efivarfs
[ 8248.958338] [  T57845] CPU: 4 PID: 57845 Comm: kworker/u97:42 
Tainted: G           O       6.9.6-1-default #1 openSUSE Tumbleweed 
2755c1c7dacbae24c77209a2b76f605a35b283af
[ 8248.958341] [  T57845] Hardware name: System manufacturer System 
Product Name/ROG STRIX B450-F GAMING, BIOS 5201 08/10/2023
[ 8248.958342] [  T57845] Workqueue: async async_run_entry_fn
[ 8248.958345] [  T57845] RIP: 0010:ieee80211_reconfig+0x9c/0x14b0 
[mac80211]
[ 8248.958376] [  T57845] Code: 02 00 00 41 c6 87 ad 05 00 00 00 4c 89 
ff e8 ab a6 fb ff 41 89 c5 85 c0 0f 84 ff 02 00 00 48 c7 c7 a8 c8 4a c2 
e8 84 7a 8e da <0f> 0b eb 2d 84 c0 0f 85 95 01 00 00 c6 87 ad 05 00 00 
00 e8 7c a6
[ 8248.958377] [  T57845] RSP: 0018:ffffbc7dc65afca0 EFLAGS: 00010282
[ 8248.958378] [  T57845] RAX: 0000000000000000 RBX: ffff977a75ec8538 
RCX: 0000000000000027
[ 8248.958379] [  T57845] RDX: ffff97893e827808 RSI: 0000000000000001 
RDI: ffff97893e827800
[ 8248.958379] [  T57845] RBP: 0000000000000000 R08: 0000000000000000 
R09: ffffbc7dc65afa90
[ 8248.958380] [  T57845] R10: ffffbc7dc65afa88 R11: 0000000000000003 
R12: ffffffff9e20a3af
[ 8248.958380] [  T57845] R13: 00000000ffffff92 R14: 0000000000000000 
R15: ffff977a75ec8900
[ 8248.958381] [  T57845] FS:  0000000000000000(0000) 
GS:ffff97893e800000(0000) knlGS:0000000000000000
[ 8248.958382] [  T57845] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 8248.958382] [  T57845] CR2: 0000000000000000 CR3: 0000000857c36000 
CR4: 0000000000750ef0
[ 8248.958383] [  T57845] PKRU: 55555554
[ 8248.958383] [  T57845] Call Trace:
[ 8248.958386] [  T57845]  <TASK>
[ 8248.958386] [  T57845]  ? ieee80211_reconfig+0x9c/0x14b0 [mac80211 
9833361847ca07e05d5bab2c6c245a827f032875]
[ 8248.958415] [  T57845]  ? __warn.cold+0xa8/0x102
[ 8248.958417] [  T57845]  ? ieee80211_reconfig+0x9c/0x14b0 [mac80211 
9833361847ca07e05d5bab2c6c245a827f032875]
[ 8248.958447] [  T57845]  ? report_bug+0xd8/0x150
[ 8248.958449] [  T57845]  ? handle_bug+0x3c/0x80
[ 8248.958452] [  T57845]  ? exc_invalid_op+0x17/0x70
[ 8248.958453] [  T57845]  ? asm_exc_invalid_op+0x1a/0x20
[ 8248.958456] [  T57845]  ? ieee80211_reconfig+0x9c/0x14b0 [mac80211 
9833361847ca07e05d5bab2c6c245a827f032875]
[ 8248.958484] [  T57845]  ? schedule+0x27/0xf0
[ 8248.958486] [  T57845]  ? wq_worker_running+0xe/0x60
[ 8248.958488] [  T57845]  ? schedule_timeout+0x125/0x150
[ 8248.958489] [  T57845]  ? ttwu_queue_wakelist+0xd0/0xf0
[ 8248.958491] [  T57845]  ? select_task_rq_fair+0x1aa/0x1800
[ 8248.958493] [  T57845]  ? lock_timer_base+0x76/0xa0
[ 8248.958496] [  T57845]  wiphy_resume+0x82/0x1b0 [cfg80211 
be56504aecfc35eddbb73a252a4e4535a8bfd13d]
[ 8248.958529] [  T57845]  ? __pfx_wiphy_resume+0x10/0x10 [cfg80211 
be56504aecfc35eddbb73a252a4e4535a8bfd13d]
[ 8248.958556] [  T57845]  dpm_run_callback+0x47/0x150
[ 8248.958559] [  T57845]  device_resume+0x103/0x300
[ 8248.958561] [  T57845]  ? __pfx_dpm_watchdog_handler+0x10/0x10
[ 8248.958563] [  T57845]  async_resume+0x1d/0x30
[ 8248.958564] [  T57845]  async_run_entry_fn+0x2f/0x110
[ 8248.958566] [  T57845]  process_one_work+0x17d/0x340
[ 8248.958568] [  T57845]  worker_thread+0x2f1/0x400
[ 8248.958570] [  T57845]  ? __pfx_worker_thread+0x10/0x10
[ 8248.958571] [  T57845]  kthread+0xcf/0x100
[ 8248.958573] [  T57845]  ? __pfx_kthread+0x10/0x10
[ 8248.958574] [  T57845]  ret_from_fork+0x31/0x50
[ 8248.958577] [  T57845]  ? __pfx_kthread+0x10/0x10
[ 8248.958578] [  T57845]  ret_from_fork_asm+0x1a/0x30
[ 8248.958581] [  T57845]  </TASK>
[ 8248.958581] [  T57845] ---[ end trace 0000000000000000 ]---
[ 8248.958639] [  T57845] ------------[ cut here ]------------

[ 8248.958639] [  T57845] WARNING: CPU: 4 PID: 57845 at 
net/mac80211/driver-ops.c:41 drv_stop+0xf1/0x100 [mac80211]
[ 8248.958668] [  T57845] Modules linked in: rfcomm snd_seq_dummy 
snd_hrtimer snd_seq ccm af_packet nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 
nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct 
nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 
nf_tables vboxnetadp(O) vboxnetflt(O) qrtr vboxdrv(O) cmac algif_hash 
algif_skcipher af_alg bnep nls_iso8859_1 nls_cp437 vfat fat btusb iwlmvm 
uvcvideo btrtl snd_hda_codec_realtek btintel videobuf2_vmalloc btbcm uvc 
snd_hda_codec_generic btmtk snd_hda_scodec_component snd_hda_codec_hdmi 
mac80211 snd_usb_audio videobuf2_memops intel_rapl_msr bluetooth 
videobuf2_v4l2 snd_usbmidi_lib amd_atl libarc4 intel_rapl_common 
videodev joydev snd_ump snd_hda_intel edac_mce_amd snd_intel_dspcfg 
videobuf2_common snd_rawmidi snd_intel_sdw_acpi snd_seq_device 
ecdh_generic eeepc_wmi mc snd_hda_codec iwlwifi asus_wmi snd_hda_core 
kvm_amd snd_hwdep asus_wmi_sensors battery snd_pcm platform_profile 
cfg80211 igb kvm sparse_keymap dca snd_timer rfkill snd mxm_wmi wmi_bmof 
soundcore
[ 8248.958685] [  T57845]  k10temp pcspkr i2c_piix4 acpi_cpufreq 
gpio_amdpt gpio_generic tiny_power_button button tcp_bbr sch_fq fuse 
efi_pstore nvme_fabrics loop configfs nfnetlink dmi_sysfs ip_tables 
x_tables hid_logitech_hidpp dm_crypt essiv authenc trusted asn1_encoder 
tee hid_logitech_dj hid_plantronics hid_generic usbhid amdgpu ahci 
crct10dif_pclmul crc32_pclmul libahci polyval_clmulni polyval_generic 
gf128mul libata video amdxcp i2c_algo_bit ghash_clmulni_intel 
drm_ttm_helper sd_mod ttm sha512_ssse3 drm_exec scsi_dh_emc sha256_ssse3 
gpu_sched scsi_dh_rdac xhci_pci scsi_dh_alua sha1_ssse3 xhci_pci_renesas 
drm_suballoc_helper xhci_hcd drm_buddy sg nvme aesni_intel 
drm_display_helper crypto_simd usbcore scsi_mod nvme_core ccp cryptd cec 
sp5100_tco rc_core nvme_auth scsi_common t10_pi wmi btrfs 
blake2b_generic libcrc32c crc32c_intel xor raid6_pq dm_mod msr i2c_dev 
efivarfs
[ 8248.958701] [  T57845] CPU: 4 PID: 57845 Comm: kworker/u97:42 
Tainted: G        W  O       6.9.6-1-default #1 openSUSE Tumbleweed 
2755c1c7dacbae24c77209a2b76f605a35b283af
[ 8248.958703] [  T57845] Hardware name: System manufacturer System 
Product Name/ROG STRIX B450-F GAMING, BIOS 5201 08/10/2023
[ 8248.958703] [  T57845] Workqueue: async async_run_entry_fn
[ 8248.958705] [  T57845] RIP: 0010:drv_stop+0xf1/0x100 [mac80211]
[ 8248.958732] [  T57845] Code: 0b 00 48 85 c0 74 0c 48 8b 78 08 48 89 
de e8 b6 02 05 00 65 ff 0d f7 6c ca 3d 0f 85 3d ff ff ff 0f 1f 44 00 00 
e9 33 ff ff ff <0f> 0b 5b c3 cc cc cc cc 0f 1f 80 00 00 00 00 90 90 90 
90 90 90 90
[ 8248.958733] [  T57845] RSP: 0018:ffffbc7dc65afc00 EFLAGS: 00010246
[ 8248.958734] [  T57845] RAX: 0000000000000000 RBX: ffff977a75ec8900 
RCX: 0000000000000000
[ 8248.958734] [  T57845] RDX: 0000000000000001 RSI: 0000000000000286 
RDI: ffff977a75ec8900
[ 8248.958735] [  T57845] RBP: ffff977a75ec8900 R08: ffffffff9eb558b0 
R09: ffffffff9eb558b0
[ 8248.958735] [  T57845] R10: ffffffff9eb558b0 R11: ffff97893e83a9e4 
R12: ffff977a75ec91f8
[ 8248.958736] [  T57845] R13: ffff977a75ec8e10 R14: 0000000000000000 
R15: ffff977a52159c70
[ 8248.958736] [  T57845] FS:  0000000000000000(0000) 
GS:ffff97893e800000(0000) knlGS:0000000000000000
[ 8248.958737] [  T57845] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 8248.958737] [  T57845] CR2: 0000000000000000 CR3: 0000000857c36000 
CR4: 0000000000750ef0
[ 8248.958738] [  T57845] PKRU: 55555554
[ 8248.958738] [  T57845] Call Trace:
[ 8248.958739] [  T57845]  <TASK>
[ 8248.958740] [  T57845]  ? drv_stop+0xf1/0x100 [mac80211 
9833361847ca07e05d5bab2c6c245a827f032875]
[ 8248.958767] [  T57845]  ? __warn.cold+0xa8/0x102
[ 8248.958768] [  T57845]  ? drv_stop+0xf1/0x100 [mac80211 
9833361847ca07e05d5bab2c6c245a827f032875]
[ 8248.958795] [  T57845]  ? report_bug+0xd8/0x150
[ 8248.958796] [  T57845]  ? handle_bug+0x3c/0x80
[ 8248.958798] [  T57845]  ? exc_invalid_op+0x17/0x70
[ 8248.958799] [  T57845]  ? asm_exc_invalid_op+0x1a/0x20
[ 8248.958801] [  T57845]  ? drv_stop+0xf1/0x100 [mac80211 
9833361847ca07e05d5bab2c6c245a827f032875]
[ 8248.958828] [  T57845]  ieee80211_do_stop+0x533/0x7c0 [mac80211 
9833361847ca07e05d5bab2c6c245a827f032875]
[ 8248.958859] [  T57845]  ieee80211_stop+0x58/0x190 [mac80211 
9833361847ca07e05d5bab2c6c245a827f032875]
[ 8248.958888] [  T57845]  __dev_close_many+0xa7/0x120
[ 8248.958892] [  T57845]  dev_close_many+0x99/0x160
[ 8248.958893] [  T57845]  dev_close+0x6a/0x90
[ 8248.958894] [  T57845]  cfg80211_shutdown_all_interfaces+0x4d/0xf0 
[cfg80211 be56504aecfc35eddbb73a252a4e4535a8bfd13d]
[ 8248.958922] [  T57845]  wiphy_resume+0xc1/0x1b0 [cfg80211 
be56504aecfc35eddbb73a252a4e4535a8bfd13d]
[ 8248.958949] [  T57845]  ? __pfx_wiphy_resume+0x10/0x10 [cfg80211 
be56504aecfc35eddbb73a252a4e4535a8bfd13d]
[ 8248.958976] [  T57845]  dpm_run_callback+0x47/0x150
[ 8248.958977] [  T57845]  device_resume+0x103/0x300
[ 8248.958979] [  T57845]  ? __pfx_dpm_watchdog_handler+0x10/0x10
[ 8248.958980] [  T57845]  async_resume+0x1d/0x30
[ 8248.958981] [  T57845]  async_run_entry_fn+0x2f/0x110
[ 8248.958983] [  T57845]  process_one_work+0x17d/0x340
[ 8248.958984] [  T57845]  worker_thread+0x2f1/0x400
[ 8248.958986] [  T57845]  ? __pfx_worker_thread+0x10/0x10
[ 8248.958987] [  T57845]  kthread+0xcf/0x100
[ 8248.958988] [  T57845]  ? __pfx_kthread+0x10/0x10
[ 8248.958989] [  T57845]  ret_from_fork+0x31/0x50
[ 8248.958991] [  T57845]  ? __pfx_kthread+0x10/0x10
[ 8248.958992] [  T57845]  ret_from_fork_asm+0x1a/0x30
[ 8248.958994] [  T57845]  </TASK>
[ 8248.958994] [  T57845] ---[ end trace 0000000000000000 ]---
[ 8248.959027] [  T57845] ieee80211 phy0: PM: dpm_run_callback(): 
wiphy_resume+0x0/0x1b0 [cfg80211] returns -110
[ 8248.959056] [  T57845] ieee80211 phy0: PM: failed to resume async: 
error -110
[ 8249.136199] [  T57539] [drm] UVD and UVD ENC initialized successfully.
[ 8249.237197] [  T57539] [drm] VCE initialized successfully.
[ 8249.245061] [  T57781] OOM killer enabled.
[ 8249.245061] [  T57781] Restarting tasks ... done.
[ 8249.246904] [  T57781] random: crng reseeded on system resumption
[ 8249.250282] [  T57781] PM: suspend exit
[ 8249.250695] [  T47580] thermal thermal_zone0: failed to read out 
thermal zone (-61)
[ 8249.349418] [   T2199] iwlwifi 0000:07:00.0: WRT: Invalid buffer 
destination
[ 8249.503330] [   T2199] iwlwifi 0000:07:00.0: 
WFPM_UMAC_PD_NOTIFICATION: 0x20
[ 8249.503350] [   T2199] iwlwifi 0000:07:00.0: 
WFPM_LMAC2_PD_NOTIFICATION: 0x1f
[ 8249.503364] [   T2199] iwlwifi 0000:07:00.0: WFPM_AUTH_KEY_0: 0x90
[ 8249.503380] [   T2199] iwlwifi 0000:07:00.0: CNVI_SCU_SEQ_DATA_DW9: 0x0
[ 8249.671076] [  T57450] [drm] scheduler comp_1.1.0 is not ready, skipping
[ 8249.671079] [  T57450] [drm] scheduler comp_1.2.0 is not ready, skipping
[ 8249.671080] [  T57450] [drm] scheduler comp_1.2.1 is not ready, skipping
[ 8249.684720] [   T2199] iwlwifi 0000:07:00.0: WRT: Invalid buffer 
destination
[ 8249.702878] [  T57450] [drm] scheduler comp_1.1.0 is not ready, skipping
[ 8249.702881] [  T57450] [drm] scheduler comp_1.2.0 is not ready, skipping
[ 8249.702881] [  T57450] [drm] scheduler comp_1.2.1 is not ready, skipping
[ 8249.702976] [  T57450] [drm] scheduler comp_1.1.0 is not ready, skipping
[ 8249.702976] [  T57450] [drm] scheduler comp_1.2.0 is not ready, skipping
[ 8249.702977] [  T57450] [drm] scheduler comp_1.2.1 is not ready, skipping
[ 8249.838627] [   T2199] iwlwifi 0000:07:00.0: 
WFPM_UMAC_PD_NOTIFICATION: 0x20
[ 8249.838643] [   T2199] iwlwifi 0000:07:00.0: 
WFPM_LMAC2_PD_NOTIFICATION: 0x1f
[ 8249.838662] [   T2199] iwlwifi 0000:07:00.0: WFPM_AUTH_KEY_0: 0x90
[ 8249.838675] [   T2199] iwlwifi 0000:07:00.0: CNVI_SCU_SEQ_DATA_DW9: 0x0
[ 8253.129061] [    T804] ata5: link is slow to respond, please be 
patient (ready=0)
[ 8253.470270] [   T2303] wlp7s0: authenticate with send auth to 
f2:a5:40:xx:xx:xx (local address=c8:15:4e:6a:b7:60)
[ 8253.471083] [   T2303] wlp7s0: send auth to f2:a5:40:xx:xx:xx (try 1/3)
[ 8254.370053] [      C0] iwlwifi 0000:07:00.0: Not associated and the 
session protection is over already...

(...) endless connection loop. All connection attempts will fail.

