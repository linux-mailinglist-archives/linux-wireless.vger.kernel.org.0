Return-Path: <linux-wireless+bounces-8796-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F2707903DCE
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Jun 2024 15:43:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F38528741A
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Jun 2024 13:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F09DD17D342;
	Tue, 11 Jun 2024 13:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CRqkZOfb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1413F172BBF;
	Tue, 11 Jun 2024 13:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718113417; cv=none; b=jKktqvxOUj3Iijw8UWM+GgnowdsJJVqc1E2MjAhS1Y4LDSs3qFW4CmppaGqKI+Wg9MfLd3nln45JQybN7yquHzO+R1RqgpIcG1KHiZbs/94YX+8sivBUnjV69OulXPLCW8oXKOOMrmy67VApcBAe3NtZQEi7J0kXv6nxtppjdxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718113417; c=relaxed/simple;
	bh=OG5+gG2tsRz977EkQFXTMDM4t4UQ16IcKWt2wq5O56I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q7lZjidMGW1IXXRsHZA1qVDjxf2fER2JPOjQmMfoBnrq+3fajrb4b6Iq5Pes2TI7vw0jeZlnUzApSvYhKpGzZkOGjI7iezr7g2UT3K5pPlUMMxvVgXG52kyd7FjZdO0yA7NHOuFj7q79SsY7OLVKaObepU9p0O0Q8GWjRK0YA6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CRqkZOfb; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1f4c043d2f6so5167565ad.2;
        Tue, 11 Jun 2024 06:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718113415; x=1718718215; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7tui/Ff4CbXJq4hvZzqsXw+YxZz4lComudgf1zpRG34=;
        b=CRqkZOfbtNekJXmtZRoSQnLQ+KDUfu+SUH+n0UH0RI8b4+iM8aKOxdSlRWAitdMYKe
         L3tKR5QHQFne/u7NR4oBwkU86JSU1C64XDYZx/j0QkUbyiYLEVBFHfZvP2SGuPOk/8TU
         H952+zl5C/0dlytZSruS4VEogJUMSCE8V5oJWmonSD7+975agox/Ro+wKL3mfYxxMKqU
         CJTkbCP6kbtYsScpFo6x7EXQDYutAMrqo3O6YBhKkJy4dpV3ZQ6UBQb3bhdDiCUUgIKr
         +lKC/1KOYbJV11dHW5ybpgXcV16ciavRFxywFiotL5AgR8x9Fih4WkEaXzFaR6cl/huC
         K0Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718113415; x=1718718215;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7tui/Ff4CbXJq4hvZzqsXw+YxZz4lComudgf1zpRG34=;
        b=PAAE0WFXVWuNd6nT5/yqyegv1SNQ6eHLLT+CUmCG5XCEnsyGzEQjq3GrAjFEJIXMJp
         hif1Qsrh6iQIxckZKaoOER/7LVhiayDkSMdEimV62BNfvI76VB/FWZl+/DdX/WFI7r3A
         aV5QOIA2biZ92XmbVoicc0jycytKCh4WPDdu1zZDI1VxRFXDXrQtq3Dad9fYLSi2MofS
         MhAL0i4DUAUF0tJHAIVXxvn7b5sFeb9htqa+zCfXsmF/C2lnMk7LnsBEETEBAHm6PS9J
         Dm0Jv4J86AET6mJCMtatPYCcpNaDVITsC5FRL3Cdx0cG2OWGmAhU9k3XVLyB3Yduy953
         aFww==
X-Forwarded-Encrypted: i=1; AJvYcCWuNUyMADuy4vnxzGbvT2C+Z7JRLAFbYvNr8hVslAdO/R+YsoeOow7shGXK9ojH6UlHIpR+Nv6XA9wZR/02SXv2vxphOhoviHQimCzZGi+aIa5rP5skxqSd2sWVrDP0E4E1/SY0I2/TnfUSWGQ=
X-Gm-Message-State: AOJu0YwvzOCTmtXtB2ippfeLzNc5bSuWh4VIDF+jx9SascMAKexDMAGN
	gjx7eQjfK4hEYwzQy8oeU5+9nuojq/XhOj6HJsSzpiz3BAoCZpIm2SjmtdxIY4UklZUH0anvgTM
	uuGBR0983xTOH0p5Xq39yJDPnKh5FqNg5oq4=
X-Google-Smtp-Source: AGHT+IFeHMTksJjSAYIv+QgqlOQDKbQRPoMeYUvWa4NzWcasuoS5fIyej3M3168XoVlT5V0Ht8ycPFnh3rMj13HRhW0=
X-Received: by 2002:a17:903:189:b0:1f7:178e:6091 with SMTP id
 d9443c01a7336-1f7178e6195mr56766315ad.0.1718113414925; Tue, 11 Jun 2024
 06:43:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOMZO5A7+nxACoBPY0k8cOpVQByZtEV_N1489MK5wETHF_RXWA@mail.gmail.com>
 <3fbb5317d9ff33ef1b60ca8297537335ce86a79d.camel@sipsolutions.net>
In-Reply-To: <3fbb5317d9ff33ef1b60ca8297537335ce86a79d.camel@sipsolutions.net>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 11 Jun 2024 10:43:23 -0300
Message-ID: <CAOMZO5Aufe7zAE7TFVprvRreamYd9=RHjybjaEz2O9WaPksV=Q@mail.gmail.com>
Subject: Re: iwlwifi: Regression after migrating to 6.6.32
To: Johannes Berg <johannes@sipsolutions.net>
Cc: miriam.rachel.korenblit@intel.com, kvalo@kernel.org, 
	Jakub Kicinski <kuba@kernel.org>, linux-wireless <linux-wireless@vger.kernel.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Johannes,

On Tue, Jun 11, 2024 at 9:52=E2=80=AFAM Johannes Berg <johannes@sipsolution=
s.net> wrote:

> This warning happens if DMA mapping/allocation returns a page that's not
> page-aligned??
>
>                 rxb->page_dma =3D
>                         dma_map_page(trans->dev, page, rxb->offset,
>                                      trans_pcie->rx_buf_bytes,
>                                      DMA_FROM_DEVICE);
>
> (or similar places), where rxb->offset will always be 0 unless
> rx_buf_bytes is set to 2048, but that can only happen if the amsdu_size
> module parameter is set to 4 (=3D2k) but that's not even supported any
> more?
>
> Maybe make this WARN_ONCE(...) with a string that has more info on the
> addresses.

I did as suggested:

--- a/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
@@ -266,7 +266,8 @@ static void iwl_pcie_rxmq_restock(struct iwl_trans *tra=
ns,
                list_del(&rxb->list);
                rxb->invalid =3D false;
                /* some low bits are expected to be unset (depending on hw)=
 */
-               WARN_ON(rxb->page_dma & trans_pcie->supported_dma_mask);
+               WARN_ONCE(rxb->page_dma & trans_pcie->supported_dma_mask,
+                         "rxb->offset is %d trans_pcie->rx_buf_bytes
is %d\n", rxb->offset, trans_pcie->rx_buf_bytes);
                /* Point to Rx buffer via next RBD in circular buffer */
                iwl_pcie_restock_bd(trans, rxq, rxb);
                rxq->write =3D (rxq->write + 1) & (rxq->queue_size - 1);
--=20

and this is the result:

[    5.033520] ------------[ cut here ]------------
[    5.033723] iwlwifi 0000:01:00.0: Detected RF HR B3, rfid=3D0x10a100
[    5.038174] rxb->offset is 0 trans_pcie->rx_buf_bytes is 4096
[    5.038279] WARNING: CPU: 1 PID: 135 at
/drivers/net/wireless/intel/iwlwifi/pcie/rx.c:269
iwl_pcie_rxmq_restock.part.0+0x160/0x16c [iwlwifi]
[    5.062764] Modules linked in: iwlmvm(+) mac80211 libarc4
openvswitch nsh nf_conncount nf_nat iwlwifi edt_ft5x06 cfg80211 rfkill
fuse nfnetlink ipv6
[    5.076130] CPU: 1 PID: 135 Comm: irq/203-iwlwifi Not tainted
6.6.32-stable-standard-00002-ga107bd5acba0 #1
[    5.085889] Hardware name: CompuLab i.MX8MM IoT Gateway (DT)
[    5.091562] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=
=3D--)
[    5.098537] pc : iwl_pcie_rxmq_restock.part.0+0x160/0x16c [iwlwifi]
[    5.104900] lr : iwl_pcie_rxmq_restock.part.0+0x160/0x16c [iwlwifi]
[    5.111254] sp : ffff80008000bd20
[    5.114575] x29: ffff80008000bd20 x28: ffff0000c1ab0080 x27: ffff0000c1a=
b8000
[    5.121729] x26: dead000000000122 x25: dead000000000100 x24: ffff0000c1a=
b1e70
[    5.128884] x23: ffff0000c1ab0080 x22: ffff0000c4e34460 x21: ffff0000c1a=
b8078
[    5.136041] x20: ffff0000c4e34470 x19: ffff0000c1ab8000 x18: fffffffffff=
fffff
[    5.143194] x17: 0000000000000001 x16: 0000000000000000 x15: ffff8000800=
0b8e0
[    5.150350] x14: 0000000000000000 x13: ffff80008185a15d x12: 625f6675625=
f7872
[    5.157506] x11: fffffffffffe0000 x10: 000000000000000a x9 : 00000000000=
01000
[    5.164659] x8 : 000000000000000a x7 : 0000000000000004 x6 : 00000000000=
00000
[    5.171812] x5 : ffff0000ff76dd48 x4 : 0000000000000000 x3 : 00000000000=
00027
[    5.178968] x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff0000c18=
98000
[    5.186121] Call trace:
[    5.188573]  iwl_pcie_rxmq_restock.part.0+0x160/0x16c [iwlwifi]
[    5.194607]  iwl_pcie_rxq_restock+0x40/0x4c [iwlwifi]
[    5.199744]  iwl_pcie_rx_handle+0x414/0x884 [iwlwifi]
[    5.204877]  iwl_pcie_napi_poll_msix+0x38/0xb0 [iwlwifi]
[    5.210280]  __napi_poll+0x38/0x178
[    5.213790]  net_rx_action+0x128/0x270
[    5.217554]  __do_softirq+0x100/0x26c
[    5.221227]  ____do_softirq+0x10/0x1c
[    5.224900]  call_on_irq_stack+0x24/0x4c
[    5.228834]  do_softirq_own_stack+0x1c/0x2c
[    5.233027]  do_softirq+0x54/0x6c
[    5.236357]  __local_bh_enable_ip+0x8c/0x98
[    5.240554]  iwl_pcie_irq_rx_msix_handler+0x90/0xe8 [iwlwifi]
[    5.246403]  irq_thread_fn+0x2c/0xa8
[    5.249991]  irq_thread+0x160/0x248
[    5.253490]  kthread+0x110/0x114
[    5.256728]  ret_from_fork+0x10/0x20
[    5.260317] ---[ end trace 0000000000000000 ]--

Many other warnings follow:

[   10.724476] ------------[ cut here ]------------
[   10.724481] Invalid rxb from HW 4085
[   10.724531] iwlwifi 0000:01:00.0: Microcode SW error detected.
Restarting 0x0.
[   10.724601] WARNING: CPU: 1 PID: 135 at
/drivers/net/wireless/intel/iwlwifi/pcie/rx.c:1490
iwl_pcie_rx_handle+0x694/0x884 [iwlwifi]
[   10.724681] Modules linked in: caam_jr caamhash_desc caamalg_desc
authenc libdes btusb option btrtl usb_wwan btintel usbserial smsc
btmtk btbcm bluetooth ecdh_generic ecc smsc95xx usbnet hantro_vpu
v4l2_vp9 v4l2_h264 videobuf2_dma_contig videobuf2_memops v4l2_mem2mem
videobuf2_v4l2 videobuf2_common imx8m_ddrc videodev etnaviv
crct10dif_ce gpu_sched mc at24 fsl_imx8_ddr_perf clk_bd718x7
snvs_pwrkey rtc_snvs caam error pwm_imx27 spi_imx imx_sdma
imx8mm_thermal snd_soc_fsl_sai snd_soc_fsl_utils imx_pcm_dma pwm_bl
backlight imx_cpufreq_dt iwlmvm mac80211 libarc4 openvswitch nsh
nf_conncount nf_nat iwlwifi edt_ft5x06 cfg80211 rfkill fuse nfnetlink
ipv6
[   10.724837] CPU: 1 PID: 135 Comm: irq/203-iwlwifi Tainted: G
W          6.6.32-stable-standard-00002-ga107bd5acba0 #1
[   10.724845] Hardware name: CompuLab i.MX8MM IoT Gateway (DT)
[   10.724849] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=
=3D--)
[   10.724857] pc : iwl_pcie_rx_handle+0x694/0x884 [iwlwifi]
[   10.724923] lr : iwl_pcie_rx_handle+0x694/0x884 [iwlwifi]
[   10.724991] sp : ffff80008000bd80
[   10.724994] x29: ffff80008000bdf0 x28: ffff0000c1ab0080 x27: ffff0000c1a=
b8000
[   10.725004] x26: 000000000000000c x25: ffff0000c1ab1c80 x24: 00000000fff=
ee582
[   10.725014] x23: 0000000000000001 x22: 0000000000000001 x21: 00000000000=
00040
[   10.725024] x20: ffff0000c1ab0080 x19: ffff0000c1ab8078 x18: fffffffffff=
fffff
[   10.725035] x17: ffff80007e2ab000 x16: ffff800080008000 x15: ffff8000800=
0b940
[   10.725045] x14: 0000000000000000 x13: ffff80008185f804 x12: 20627872206=
4696c
[   10.725055] x11: fffffffffffe0000 x10: 000000000000000a x9 : 00000000000=
00ff5
[   10.725064] x8 : 000000000000000a x7 : 0000000000000004 x6 : 00000000000=
00000
[   10.725073] x5 : ffff0000ff76dd48 x4 : 0000000000000000 x3 : 00000000000=
00027
[   10.725083] x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff0000c18=
98000
[   10.725093] Call trace:
[   10.725096]  iwl_pcie_rx_handle+0x694/0x884 [iwlwifi]
[   10.725164]  iwl_pcie_napi_poll_msix+0x38/0xb0 [iwlwifi]
[   10.725232]  __napi_poll+0x38/0x178
[   10.725245]  net_rx_action+0x128/0x270
[   10.725254]  __do_softirq+0x100/0x26c
[   10.725260]  ____do_softirq+0x10/0x1c
[   10.725269]  call_on_irq_stack+0x24/0x4c
[   10.725276]  do_softirq_own_stack+0x1c/0x2c
[   10.725282]  do_softirq+0x54/0x6c
[   10.725293]  __local_bh_enable_ip+0x8c/0x98
[   10.725303]  iwl_pcie_irq_rx_msix_handler+0x90/0xe8 [iwlwifi]
[   10.725370]  irq_thread_fn+0x2c/0xa8
[   10.725377]  irq_thread+0x160/0x248
[   10.725384]  kthread+0x110/0x114
[   10.725391]  ret_from_fork+0x10/0x20
[   10.725399] ---[ end trace 0000000000000000 ]---
[   11.040466] iwlwifi 0000:01:00.0: Start IWL Error Log Dump:
[   11.046122] iwlwifi 0000:01:00.0: Transport status: 0x0000004B, valid: 6
[   11.046133] iwlwifi 0000:01:00.0: Loaded firmware version:
77.ad46c98b.0 cc-a0-77.ucode
[   11.046140] iwlwifi 0000:01:00.0: 0x00000084 | NMI_INTERRUPT_UNKNOWN
[   11.046146] iwlwifi 0000:01:00.0: 0x00A0A2B0 | trm_hw_status0
[   11.046152] iwlwifi 0000:01:00.0: 0x00000001 | trm_hw_status1
[   11.046157] iwlwifi 0000:01:00.0: 0x004F8B7A | branchlink2
[   11.046162] iwlwifi 0000:01:00.0: 0x004EEC2A | interruptlink1
[   11.046167] iwlwifi 0000:01:00.0: 0x004EEC2A | interruptlink2
[   11.046173] iwlwifi 0000:01:00.0: 0x000152DA | data1
[   11.046178] iwlwifi 0000:01:00.0: 0x01000000 | data2
[   11.046183] iwlwifi 0000:01:00.0: 0x00000000 | data3
[   11.046188] iwlwifi 0000:01:00.0: 0x00000000 | beacon time
[   11.046193] iwlwifi 0000:01:00.0: 0x00155CAF | tsf low
[   11.046199] iwlwifi 0000:01:00.0: 0x00000000 | tsf hi
[   11.046204] iwlwifi 0000:01:00.0: 0x00000000 | time gp1
[   11.046209] iwlwifi 0000:01:00.0: 0x0015B919 | time gp2
[   11.046214] iwlwifi 0000:01:00.0: 0x00000001 | uCode revision type
[   11.046219] iwlwifi 0000:01:00.0: 0x0000004D | uCode version major
[   11.046224] iwlwifi 0000:01:00.0: 0xAD46C98B | uCode version minor
[   11.046230] iwlwifi 0000:01:00.0: 0x00000340 | hw version
[   11.046235] iwlwifi 0000:01:00.0: 0x00C89000 | board version
[   11.046240] iwlwifi 0000:01:00.0: 0x8035F500 | hcmd
[   11.046246] iwlwifi 0000:01:00.0: 0x20020000 | isr0
[   11.046251] iwlwifi 0000:01:00.0: 0x00000000 | isr1
[   11.046256] iwlwifi 0000:01:00.0: 0x08F00002 | isr2
[   11.046261] iwlwifi 0000:01:00.0: 0x00C0001C | isr3
[   11.046266] iwlwifi 0000:01:00.0: 0x00000000 | isr4
[   11.046271] iwlwifi 0000:01:00.0: 0x00000000 | last cmd Id
[   11.046276] iwlwifi 0000:01:00.0: 0x000152DA | wait_event
[   11.046282] iwlwifi 0000:01:00.0: 0x00000000 | l2p_control
[   11.046287] iwlwifi 0000:01:00.0: 0x00010000 | l2p_duration
[   11.046292] iwlwifi 0000:01:00.0: 0x00000000 | l2p_mhvalid
[   11.046297] iwlwifi 0000:01:00.0: 0x00000000 | l2p_addr_match
[   11.046302] iwlwifi 0000:01:00.0: 0x00000009 | lmpm_pmg_sel
[   11.046308] iwlwifi 0000:01:00.0: 0x00000000 | timestamp
[   11.046313] iwlwifi 0000:01:00.0: 0x00000848 | flow_handler
[   11.046367] iwlwifi 0000:01:00.0: Start IWL Error Log Dump:
[   11.046372] iwlwifi 0000:01:00.0: Transport status: 0x0000004B, valid: 7
[   11.046378] iwlwifi 0000:01:00.0: 0x20000066 | NMI_INTERRUPT_HOST
[   11.046384] iwlwifi 0000:01:00.0: 0x00000000 | umac branchlink1
[   11.046390] iwlwifi 0000:01:00.0: 0x80455D2E | umac branchlink2
[   11.276561] iwlwifi 0000:01:00.0: 0x80472CBA | umac interruptlink1
[   11.276572] iwlwifi 0000:01:00.0: 0x80472CBA | umac interruptlink2
[   11.276577] iwlwifi 0000:01:00.0: 0x01000000 | umac data1
[   11.276583] iwlwifi 0000:01:00.0: 0x80472CBA | umac data2
[   11.276588] iwlwifi 0000:01:00.0: 0x00000000 | umac data3
[   11.276593] iwlwifi 0000:01:00.0: 0x0000004D | umac major
[   11.276599] iwlwifi 0000:01:00.0: 0xAD46C98B | umac minor
[   11.276604] iwlwifi 0000:01:00.0: 0x0015B916 | frame pointer
[   11.276609] iwlwifi 0000:01:00.0: 0xC0886260 | stack pointer
[   11.276614] iwlwifi 0000:01:00.0: 0x000801B3 | last host cmd
[   11.276619] iwlwifi 0000:01:00.0: 0x00000000 | isr status reg
[   11.276644] iwlwifi 0000:01:00.0: IML/ROM dump:
[   11.276650] iwlwifi 0000:01:00.0: 0x00000003 | IML/ROM error/state
[   11.276668] iwlwifi 0000:01:00.0: 0x00005B4F | IML/ROM data1
[   11.276686] iwlwifi 0000:01:00.0: 0x00000080 | IML/ROM WFPM_AUTH_KEY_0
[   11.276698] iwlwifi 0000:01:00.0: Fseq Registers:
[   11.276706] iwlwifi 0000:01:00.0: 0x60000041 | FSEQ_ERROR_CODE
[   11.276715] iwlwifi 0000:01:00.0: 0x00290021 | FSEQ_TOP_INIT_VERSION
[   11.276724] iwlwifi 0000:01:00.0: 0x00050008 | FSEQ_CNVIO_INIT_VERSION
[   11.276733] iwlwifi 0000:01:00.0: 0x0000A503 | FSEQ_OTP_VERSION
[   11.276742] iwlwifi 0000:01:00.0: 0x80000003 | FSEQ_TOP_CONTENT_VERSION
[   11.276751] iwlwifi 0000:01:00.0: 0x4552414E | FSEQ_ALIVE_TOKEN
[   11.276760] iwlwifi 0000:01:00.0: 0x00100530 | FSEQ_CNVI_ID
[   11.276771] iwlwifi 0000:01:00.0: 0x00000532 | FSEQ_CNVR_ID
[   11.276782] iwlwifi 0000:01:00.0: 0x00100530 | CNVI_AUX_MISC_CHIP
[   11.276793] iwlwifi 0000:01:00.0: 0x00000532 | CNVR_AUX_MISC_CHIP
[   11.276804] iwlwifi 0000:01:00.0: 0x05B0905B |
CNVR_SCU_SD_REGS_SD_REG_DIG_DCDC_VTRIM
[   11.276815] iwlwifi 0000:01:00.0: 0x0000025B |
CNVR_SCU_SD_REGS_SD_REG_ACTIVE_VDIG_MIRROR
[   11.276824] iwlwifi 0000:01:00.0: 0x00050008 | FSEQ_PREV_CNVIO_INIT_VERS=
ION
[   11.276833] iwlwifi 0000:01:00.0: 0x00290021 | FSEQ_WIFI_FSEQ_VERSION
[   11.276842] iwlwifi 0000:01:00.0: 0x00290021 | FSEQ_BT_FSEQ_VERSION
[   11.276851] iwlwifi 0000:01:00.0: 0x00000000 | FSEQ_CLASS_TP_VERSION
[   11.276870] iwlwifi 0000:01:00.0: UMAC CURRENT PC: 0x804727d0
[   11.475114] iwlwifi 0000:01:00.0: LMAC1 CURRENT PC: 0xd0
[   11.475165] iwlwifi 0000:01:00.0: Starting mac, retry will be
triggered anyway
[   11.475202] iwlwifi 0000:01:00.0: FW error in SYNC CMD RSS_CONFIG_CMD
[   11.475213] CPU: 3 PID: 369 Comm: systemd-network Tainted: G
W          6.6.32-stable-standard-00002-ga107bd5acba0 #1
[   11.475223] Hardware name: CompuLab i.MX8MM IoT Gateway (DT)
[  OK  ] Reached targe[   11.475227] Call trace:
[   11.475230]  dump_backtrace+0x90/0xe8
t Login Prompts.
[   11.475247]  show_stack+0x18/0x24
[   11.475257]  dump_stack_lvl+0x48/0x60
[   11.475267]  dump_stack+0x18/0x24
[   11.475276]  iwl_trans_txq_send_hcmd+0x374/0x434 [iwlwifi]
[   11.475371]  iwl_trans_send_cmd+0xa4/0x118 [iwlwifi]
[   11.543800]  iwl_mvm_send_cmd_pdu+0x48/0x94 [iwlmvm]
[   11.548854]  iwl_send_rss_cfg_cmd+0xac/0xdc [iwlmvm]
[   11.553886]  iwl_mvm_up+0x664/0x8a0 [iwlmvm]
[   11.558222]  __iwl_mvm_mac_start+0x128/0x204 [iwlmvm]
[   11.563340]  iwl_mvm_mac_start+0x80/0x194 [iwlmvm]
[   11.568196]  drv_start+0x34/0x58 [mac80211]
[   11.572516]  ieee80211_do_open+0x2a8/0x6b0 [mac80211]
[   11.577688]  ieee80211_open+0x80/0xa8 [mac80211]
[   11.577821]  __dev_open+0x100/0x1d8
[   11.577834]  __dev_change_flags+0x194/0x20c
[   11.577844]  dev_change_flags+0x24/0x6c
[  OK  ] Reached targe[   11.577854]  do_setlink+0x27c/0xeb0
t Multi-User System.[   11.577863]  rtnl_setlink+0x120/0x1d8

[   11.577872]  rtnetlink_rcv_msg+0x128/0x378
[   11.577880]  netlink_rcv_skb+0x60/0x130
[   11.577891]  rtnetlink_rcv+0x18/0x24
[   11.577900]  netlink_unicast+0x300/0x36c
[   11.577907]  netlink_sendmsg+0x1a8/0x420
[   11.577914]  __sys_sendto+0x118/0x180
[   11.577922]  __arm64_sys_sendto+0x28/0x38
[   11.577929]  invoke_syscall+0x48/0x114
[   11.577939]  el0_svc_common.constprop.0+0xc0/0xe0
[   11.577948]  do_el0_svc+0x1c/0x28
[   11.577957]  el0_svc+0x40/0xe4
[   11.577966]  el0t_64_sync_handler+0x120/0x12c
[   11.577975]  el0t_64_sync+0x190/0x194
[   11.578728] iwlwifi 0000:01:00.0: Failed to configure RSS queues: -5
[   11.676672] iwlwifi 0000:01:00.0: mac start retry 0

