Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F16844635E
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Nov 2021 13:29:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232304AbhKEMcC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 5 Nov 2021 08:32:02 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:62153 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232105AbhKEMcA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 5 Nov 2021 08:32:00 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1636115361; h=Content-Transfer-Encoding: Content-Type:
 MIME-Version: Message-ID: In-Reply-To: Date: References: Subject: Cc:
 To: From: Sender; bh=5gyxY92i0U1AzI5x0lNZ8Y1r1eJlkSEZSR605FD4njQ=; b=HfA/Jm/vf5pozFUv0voKQxo7Df6b96Q3SRUbsKEXsNlMTXgkITQq8oL6l3C5jPiILL6+U5mx
 nDCAZWVRJnAps07I17bUzNPGLKl11wH3mc2yYv4KQDSPghdMBQwzepJUI84IEgGZ9u48Z2ZW
 scqwQ6ygLKNajjpG0xP0fcpcCdw=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-west-2.postgun.com with SMTP id
 6185239dc797bc30ce9e46f1 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 05 Nov 2021 12:29:17
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id EC2ACC43460; Fri,  5 Nov 2021 12:29:16 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from tynnyri.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 9C6E3C4338F;
        Fri,  5 Nov 2021 12:29:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 9C6E3C4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     =?utf-8?B?5bCk5pmT5p2w?= <yxj790222@163.com>
Cc:     linux-wireless@vger.kernel.org, ath10k@lists.infradead.org
Subject: Re: qca9984 fails to work
References: <7fc1368d.53c6.17cda9721bb.Coremail.yxj790222@163.com>
Date:   Fri, 05 Nov 2021 14:29:13 +0200
In-Reply-To: <7fc1368d.53c6.17cda9721bb.Coremail.yxj790222@163.com>
 (=?utf-8?B?IuWwpOaZk+adsA==?=
        "'s message of "Mon, 1 Nov 2021 16:21:50 +0800 (CST)")
Message-ID: <87mtmiyeee.fsf@tynnyri.adurom.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

=E5=B0=A4=E6=99=93=E6=9D=B0 <yxj790222@163.com> writes:

> before update, everthing is ok, after update kernel, qca9984 fails to wor=
k.
> dmesg|grep ath10k:
>
> [ =C2=A0=C2=A0=C2=A04.764210] ath10k_pci 0000:07:00.0: enabling device (0=
000 -> 0002)
>
> [ =C2=A0=C2=A0=C2=A04.765527] ath10k_pci 0000:07:00.0: pci irq msi oper_i=
rq_mode 2 irq_mode 0 reset_mode 0
>
> [ =C2=A0=C2=A0=C2=A04.886828] ath10k_pci 0000:07:00.0: firmware: direct-l=
oading
> firmware ath10k/pre-cal-pci-0000:07:00.0.bin
>
> [ =C2=A0=C2=A0=C2=A04.886844] ath10k_pci 0000:07:00.0: firmware: failed t=
o load ath10k/QCA9984/hw1.0/firmware-6.bin (-2)
>
> [ =C2=A0=C2=A0=C2=A04.888769] ath10k_pci 0000:07:00.0: firmware: direct-l=
oading
> firmware ath10k/QCA9984/hw1.0/firmware-5.bin
>
> [ =C2=A0=C2=A0=C2=A04.888774] ath10k_pci 0000:07:00.0: qca9984/qca9994 hw=
1.0 target
> 0x01000000 chip_id 0x00000000 sub 168c:cafe
>
> [ =C2=A0=C2=A0=C2=A04.888777] ath10k_pci 0000:07:00.0: kconfig debug 0 de=
bugfs 0 tracing 0 dfs 0 testmode 0
>
> [ =C2=A0=C2=A0=C2=A04.889124] ath10k_pci 0000:07:00.0: firmware ver
> 10.4-3.9.0.2-00131 api 5 features
> no-p2p,mfp,peer-flow-ctrl,btcoex-param,allows-mesh-bcast,no-ps,peer-fixed=
-rate,
> iram-recovery crc32 23bd9e43
>
> [ =C2=A0=C2=A0=C2=A07.170482] ath10k_pci 0000:07:00.0: firmware: direct-l=
oading firmware ath10k/QCA9984/hw1.0/board-2.bin
>
> [ =C2=A0=C2=A0=C2=A07.170600] ath10k_pci 0000:07:00.0: board_file api 2 b=
mi_id 0:1 crc32 85498734
>
> [ =C2=A0=C2=A010.810016] ath10k_pci 0000:07:00.0: failed to copy target i=
ram contents: -12
>
> [ =C2=A0=C2=A010.865295] ath10k_pci 0000:07:00.0: could not init core (-1=
2)
>
> [ =C2=A0=C2=A010.865332] ath10k_pci 0000:07:00.0: could not probe fw (-12)
>
> kernel:
> [ 0.000000] Linux version 5.14.0-3-amd64
> (debian-kernel@lists.debian.org) (gcc-10 (Debian 10.3.0-11) 10.3.0,
> GNU ld (GNU Binutils for Debian) 2.37) #1 SMP Debian 5.14.12-1
> (2021-10-14)
> [ 0.000000] Command line: BOOT_IMAGE=3D/boot/vmlinuz-5.14.0-3-amd64
> root=3DUUID=3D6ad1bda4-9feb-4849-b1d9-4311c76e3522 ro quiet
> [    0.000000] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating poi=
nt registers'
> [    0.000000] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
> [    0.000000] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
> [    0.000000] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256

This commit should fix it:

https://git.kernel.org/linus/6f8c8bf4c7c9

--=20
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes
