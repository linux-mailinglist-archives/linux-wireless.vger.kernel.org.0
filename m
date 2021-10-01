Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95FD941E7A4
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Oct 2021 08:38:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231137AbhJAGkA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 1 Oct 2021 02:40:00 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:60617 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230397AbhJAGkA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 1 Oct 2021 02:40:00 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1633070296; h=Content-Transfer-Encoding: Content-Type:
 MIME-Version: Message-ID: In-Reply-To: Date: References: Subject: Cc:
 To: From: Sender; bh=zwE1UcSRKjH4fdXGIfTb0HNedDc6r4BlZz/g6kDw5TA=; b=FIyqaDgF4YZI6vzBSSkVoCQUkydtMrBsJn1464utgEfJrmms3mzVtirPATR3zGyfZvhZHXLC
 c16ax3rfcTQPAvQB7rI8mvV4v0Gg6ksB07PIO8wd3O5tE17+aUCmgwrqcLX/QUlicH8jhRQl
 /FiisvtUeLLeHuPzldxuRFwB/+g=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-east-1.postgun.com with SMTP id
 6156acd8713d5d6f960824da (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 01 Oct 2021 06:38:16
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 63AD9C43460; Fri,  1 Oct 2021 06:38:15 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from tynnyri.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id DBEA4C4338F;
        Fri,  1 Oct 2021 06:38:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org DBEA4C4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Maurice Smulders <Maurice.Smulders@windtalker.com>
Cc:     "linux-wireless\@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        ath10k@lists.infradead.org, ath11k@lists.infradead.org
Subject: Re: Qualcomm Atheros Ath10k and Ath11k CE Buffer DMA alignment issues on Raspberry PI CM4 - Aarch64 architecture
References: <35F57D80-C7F7-47B2-BEC8-533006C72E2A@windtalker.com>
Date:   Fri, 01 Oct 2021 09:38:11 +0300
In-Reply-To: <35F57D80-C7F7-47B2-BEC8-533006C72E2A@windtalker.com> (Maurice
        Smulders's message of "Thu, 16 Sep 2021 14:38:14 +0000")
Message-ID: <87lf3d5jxo.fsf@tynnyri.adurom.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Maurice Smulders <Maurice.Smulders@windtalker.com> writes:

> I am trying to use the QCA6174A and the QCA6390 on a custom board using a=
 PCIe switch - but that doesn't matter - It still fails w/o the switch:
>
> lspci
> 00:00.0 PCI bridge: Broadcom Inc. and subsidiaries BCM2711 PCIe Bridge (r=
ev 20)
> 01:00.0 PCI bridge: Pericom Semiconductor PI7C9X2G608GP PCIe2 6-Port/8-La=
ne Packet Switch
> 02:01.0 PCI bridge: Pericom Semiconductor PI7C9X2G608GP PCIe2 6-Port/8-La=
ne Packet Switch
> 02:02.0 PCI bridge: Pericom Semiconductor PI7C9X2G608GP PCIe2 6-Port/8-La=
ne Packet Switch
> 02:03.0 PCI bridge: Pericom Semiconductor PI7C9X2G608GP PCIe2 6-Port/8-La=
ne Packet Switch
> 02:04.0 PCI bridge: Pericom Semiconductor PI7C9X2G608GP PCIe2 6-Port/8-La=
ne Packet Switch
> 02:05.0 PCI bridge: Pericom Semiconductor PI7C9X2G608GP PCIe2 6-Port/8-La=
ne Packet Switch
> 05:00.0 Unassigned class [ff00]: Qualcomm QCA6390 Wireless Network Adapte=
r [AX500-DBS (2x2)]
> 06:00.0 Network controller: Qualcomm Atheros QCA6174 802.11ac Wireless Ne=
twork Adapter (rev 32)
>
> Both device drivers do not work. I changed the CE code to use the GFP_DMA=
32 flag as an attempt to allocate the memory correctly, but DMESG shows
>
> [pi@node6745 ~]$ dmesg | grep ath
> [=C2=A0=C2=A0=C2=A0=C2=A05.801896] ath10k_pci 0000:06:00.0: ath10k_ce_all=
oc_src_ring: Not unaligned <--- User message exit from this function
> [=C2=A0=C2=A0=C2=A0=C2=A05.804284] ath10k_pci 0000:06:00.0: failed to all=
oc CE src ring 0: -12
> [=C2=A0=C2=A0=C2=A0=C2=A05.813138] ath10k_pci 0000:06:00.0: failed to all=
ocate copy engine pipe 0: -12
> [=C2=A0=C2=A0=C2=A0=C2=A05.815414] ath10k_pci 0000:06:00.0: failed to all=
ocate copy engine pipes: -12
> [=C2=A0=C2=A0=C2=A0=C2=A05.818002] ath10k_pci 0000:06:00.0: failed to set=
up resource: -12
> [=C2=A0=C2=A0=C2=A0=C2=A05.826953] ath10k_pci: probe of 0000:06:00.0 fail=
ed with error -12
> [=C2=A0=C2=A0=C2=A0=C2=A05.855993] ath11k_pci 0000:05:00.0: WARNING: ath1=
1k PCI support is experimental!
> [=C2=A0=C2=A0=C2=A0=C2=A05.896148] ath11k_pci 0000:05:00.0: BAR 0: assign=
ed [mem 0x600000000-0x600ffffff 64bit]
> [=C2=A0=C2=A0=C2=A0=C2=A05.900236] ath11k_pci 0000:05:00.0: enabling devi=
ce (0000 -> 0002)
> [=C2=A0=C2=A0=C2=A0=C2=A05.914050] ath11k_pci: probe of 0000:05:00.0 fail=
ed with error -12
>
> Error -12 (ENOMEM) gets returned and the driver doesn't work...
>
> 05:00.0 Unassigned class [ff00]: Qualcomm QCA6390 Wireless Network Adapte=
r [AX500-DBS (2x2)]
> Subsystem: Qualcomm Device 0108
> Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepp=
ing- SERR- FastB2B- DisINTx-
> Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort-=
 <MAbort- >SERR- <PERR- INTx-
> Region 0: Memory at 600000000 (64-bit, non-prefetchable) [size=3D16M]
> Capabilities: <access denied>
> Kernel modules: ath11k_pci
>
> 06:00.0 Network controller: Qualcomm Atheros QCA6174 802.11ac Wireless Ne=
twork Adapter (rev 32)
> Subsystem: ASUSTeK Computer Inc. Device 86e0
> Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepp=
ing- SERR- FastB2B- DisINTx-
> Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort-=
 <MAbort- >SERR- <PERR- INTx-
> Interrupt: pin A routed to IRQ 48
> Region 0: Memory at 601000000 (64-bit, non-prefetchable) [disabled] [size=
=3D2M]
> Capabilities: <access denied>
> Kernel modules: ath10k_pci
>
> I am at a loss what to do here. The ath11k driver has the SINGLE MSI fix =
built in.=C2=A0
>
> Any ideas' what I can try to fix this problem on the raspberry Pi CM4?

Sorry, no ideas. But adding ath10k and ath11k lists, maybe people there
can propose something.

--=20
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes
