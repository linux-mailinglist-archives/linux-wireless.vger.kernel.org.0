Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 584C950C954
	for <lists+linux-wireless@lfdr.de>; Sat, 23 Apr 2022 12:40:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235051AbiDWKgF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 23 Apr 2022 06:36:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235064AbiDWKgD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 23 Apr 2022 06:36:03 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 585FD75618
        for <linux-wireless@vger.kernel.org>; Sat, 23 Apr 2022 03:33:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 12032B80A73
        for <linux-wireless@vger.kernel.org>; Sat, 23 Apr 2022 10:33:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF25FC385A0;
        Sat, 23 Apr 2022 10:33:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650709983;
        bh=3+MiHjepdSBOzsa4FqtEGwxjolutuhcJAjmMBdk4C60=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=ia73tQAm5SbhDJEex+r0sohnFIboOyLGfQIfPeI4e24FmFZaaBpBzug+dKzT2BFjP
         q/fWhjqE/bvcPQS0eh1IVVc5SW1oi62veKK/NhkATb0p5FHq795f962eBZgbpM6GMc
         s4/xwyIo8/H4bfDZ56Kw1NhcDWFxfQZwCg8Z+ZnuhAGiZiHsCC2nifHoVA/9RL1/kL
         TozhP49EwEtLJvO+BGNhJEoz5nbwHS4eiSzl9BA3WD5ZNswmqu5bZxaQuZmNb7QRsC
         7uwZ7kIq38e+SlR14HZgjP0ZjVBzAVuXZMwqcephe+zhXTNcH/VTgPlfZx7VKX0I6l
         o09VPBsbScfQw==
From:   Kalle Valo <kvalo@kernel.org>
To:     Cheng Wang <quic_chengwan@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH] ath11k: add register read debugfs interface for WCN6855
References: <20220125063731.3049556-1-quic_chengwan@quicinc.com>
        <878rv0ezy5.fsf@kernel.org>
Date:   Sat, 23 Apr 2022 13:32:57 +0300
In-Reply-To: <878rv0ezy5.fsf@kernel.org> (Kalle Valo's message of "Fri, 28 Jan
        2022 15:45:38 +0200")
Message-ID: <87tuakjdie.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Kalle Valo <kvalo@kernel.org> writes:

> Cheng Wang <quic_chengwan@quicinc.com> writes:
>
>> Add debugfs interface reg_addr/reg_value and use these two interfaces
>> to read register value.
>> For example, execute the following commands to read WCN6855 HW register =
of
>> =E2=80=9Cmemtype=3D0xa offset=3D0x3a00d0=E2=80=9D:
>>
>> $ echo 0xa 0x3a00d0>reg_addr
>> $ cat reg_value
>> 0x10200000
>>
>> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-01720.1-QCAHSPSWPL_V1_V2_SILIC=
ONZ_LITE-1
>>
>> Signed-off-by: Cheng Wang <quic_chengwan@quicinc.com>
>
> This had new warnings, fixed in the pending branch:
>
> drivers/net/wireless/ath/ath11k/debugfs.c:1207: line length of 96 exceeds=
 90 columns
> drivers/net/wireless/ath/ath11k/debugfs.c:1253: line length of 94 exceeds=
 90 columns
> drivers/net/wireless/ath/ath11k/debugfs.c:1318: line length of 91 exceeds=
 90 columns
> drivers/net/wireless/ath/ath11k/qmi.c:1673: line length of 94 exceeds 90 =
columns

I tried to test this[1] and I couldn't get it to work:

# echo 0xa 0x3a00d0>reg_addr
# cat reg_value=20
failed to read reg, err=3D-22

The error message from ath11k is:

[  923.629220] ath11k_pci 0000:06:00.0: ath11k_qmi_wlanfw_athdiag_read_send=
 start, mem_type 10 offset 0x300000
[  923.647156] ath11k_pci 0000:06:00.0: QMI request failed result=3D0, erro=
r=3D0, valid=3D1, len=3D0

While reviewing the patch I found other issues:

o do not use ath11k_info()

o debug messages don't follow ath11k style

o warning messages don't follow ath11k style

o convert ab->hw_reg to struct ath11k_hw_params flag

o don't print a warning if register read feature is not supported

My setup on my NUC is:

[  679.283156] ath11k_pci 0000:06:00.0: MSI vectors: 32
[  679.283230] ath11k_pci 0000:06:00.0: wcn6855 hw2.0
[  679.486183] mhi mhi0: Requested to power ON
[  679.488864] mhi mhi0: Power on setup success
[  679.890486] mhi mhi0: Wait for device to enter SBL or Mission mode
[  680.537360] ath11k_pci 0000:06:00.0: chip_id 0x2 chip_family 0xb board_i=
d 0x106 soc_id 0x400c0200
[  680.537669] ath11k_pci 0000:06:00.0: fw_version 0x110f0c35 fw_build_time=
stamp 2022-03-30 09:05 fw_build_id WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILI=
CONZ_LITE-3.6510.7

[1] https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=
=3Dpending&id=3D26c7a6e468f27c1155fd7e7cc8653eabe44b9640

--=20
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes
