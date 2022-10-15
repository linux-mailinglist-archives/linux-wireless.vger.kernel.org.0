Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F02075FFBF3
	for <lists+linux-wireless@lfdr.de>; Sat, 15 Oct 2022 22:59:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbiJOU5n (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 15 Oct 2022 16:57:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbiJOU5m (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 15 Oct 2022 16:57:42 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CAF83FA32
        for <linux-wireless@vger.kernel.org>; Sat, 15 Oct 2022 13:57:41 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id x188so8497807oig.5
        for <linux-wireless@vger.kernel.org>; Sat, 15 Oct 2022 13:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O6uj+NoxRspWG9+6PPaoadKMdN0ZV9naBb7s6mOkhOs=;
        b=l+ggp+haVgxontb3BjUnMuBO4gEQd35Kk+cu4TzoXFv1nsACN1gyOox/LVYhFKlD+1
         uH6NokRco9GyEhUu7QTbPuEmyrcCCALsWPhhStq4ZPivxiBX22xm1+MgDoZFIJtTQfsJ
         yq2EwIPDDBDF8Br0qtGmMgRmBiGeN/cuNDMXWAdrBhmjOHQxQPVZOacAEmf8xtZU1OXW
         J+Z2wwS3Qrp+nbFU7ejk4KR7Mlggc3w8QhBtlVsoM9KQkSMH4vcN4LWwGtpHTuK6O/aI
         C2LzlU1uVAImJoBKxjfukrXyFenJdthEm2ltlCrmU6XDvkruG7UVI3VUMiUS8OUTYf/t
         bGEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O6uj+NoxRspWG9+6PPaoadKMdN0ZV9naBb7s6mOkhOs=;
        b=E+kG3/RWJ3LomGnBgMU9qTn3EBaOpU4iJEPTvn2apbaJ2EJfpf5z5dnk4mUT9ZE4VC
         APwHKo0KQ+RUr5AHVYqsv0y1aqWmz42Wu6/A3RYJxbcHimGiw4GIuNl2z9ln+EJSU1ik
         Unm7V56nSqncWiflJsAQtXOnqfwiDOweL/qS3dOTcfVjgZ6LV/mcQrBWFAqSCiGJhWLo
         JD3vBSToj+oL2VDN+Gi13Yi7dOjz+WFQfQ43Xv4qxvwJ97juhMdDf4JHvRuFODNiSjEw
         kqh82hSjB/bTpRvITA2T2/EI0fd8oBtyBcSpQV40xsie7ktiiC0iYzEvcMCYEYLxtUc6
         Eurw==
X-Gm-Message-State: ACrzQf0qrU6KbezQoQVAbFSjerN66Olzekv4avoKyHwe1FcH2M7P0vSi
        akOqt6TAKdEMWjzm99UB+/+r54Zr5fzs6dY8TYXTHlDS
X-Google-Smtp-Source: AMsMyM5AJ38yPbNXHs59f4PzSVjtBQQfgX/2qO5v0zlJKQh/Ua8CuJS8uw0V5OpYa0ovfJtTRuJ78U5B9YHjKXmjc0Q=
X-Received: by 2002:a05:6808:1188:b0:34b:90d1:766 with SMTP id
 j8-20020a056808118800b0034b90d10766mr1843256oil.167.1665867460901; Sat, 15
 Oct 2022 13:57:40 -0700 (PDT)
MIME-Version: 1.0
References: <CALQr=E--ECWhEGFU1pQ2f093eNgChdJ=gMZDu5ZhZeTRSGj0Sw@mail.gmail.com>
In-Reply-To: <CALQr=E--ECWhEGFU1pQ2f093eNgChdJ=gMZDu5ZhZeTRSGj0Sw@mail.gmail.com>
From:   Sipos Csaba <dchardware@gmail.com>
Date:   Sat, 15 Oct 2022 22:57:04 +0200
Message-ID: <CALQr=E8rKYk=F-p9Ow3FDAn52Q4-Dt4Gv=TKXYUxcpgMczhCRg@mail.gmail.com>
Subject: Re: ath11k: firmware crash above version 2.5.0.1 _01208 (IPQ8074)
To:     kvalo@kernel.org, linux-wireless@vger.kernel.org,
        robimarko@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Dear Kalle,

To add to this issue:

The suspicion is that either the BDF or the CAL syntax might have
changed as the firmware crashes really early (5 seconds after load),
so I tried the BDF released on codelinaro for FW 2.7, and that yields
the same crash. Note that if I use the same 2.7 BDF with FW 2.5, there
is no crash.

As FW 2.5 runs perfectly fine on the same HW, kernel and ath11k
revision where FW 2.6 and 2.7 crashes, everything points towards a FW
/ BDF / CAL interoperability or some sort of syntax related issue.

If someone from QCA can take a look at the BDF and CAL of the device,
that would be a big step forward. Maybe a flag or two needs to be
changed. Note that the device's current BDF and CAL was generated with
template 5.0.5, so fairly old. Please let me know and I can attach
both files.

If any more information is needed, I am happy to help.

Regards,
Csaba

Sipos Csaba <dchardware@gmail.com> ezt =C3=ADrta (id=C5=91pont: 2022. okt. =
10., H, 14:33):
>
> Dear Kalle,
>
> I tried the latest firmware available on your github account for
> IPQ8074 on my Xiaomi AX6 router, and it produces a firmware crash
> right after the Q6 processor tries to boot:
>
> [    7.503844] ath11k c000000.wifi: ipq8074 hw2.0
> [    7.504147] remoteproc remoteproc0: powering up cd00000.q6v5_wcss
> [    7.511424] remoteproc remoteproc0: Booting fw image
> IPQ8074/q6_fw.mdt, size 668
> [    8.511575] remoteproc remoteproc0: remote processor
> cd00000.q6v5_wcss is now up
> [    8.517199] kmodloader: done loading kernel modules from /etc/modules.=
d/*
> [    8.555705] ath11k c000000.wifi: qmi ignore invalid mem req type 3
> [    8.563181] ath11k c000000.wifi: chip_id 0x0 chip_family 0x0
> board_id 0xff soc_id 0xffffffff
> [    8.563231] ath11k c000000.wifi: fw_version 0x270204a5
> fw_build_timestamp 2022-08-04 13:05 fw_build_id
> WLAN.HK.2.7.0.1-01744-QCAHKSWPL_SILICONZ-1
> ...................................
> [   13.813010] qcom-q6v5-wcss-pil cd00000.q6v5_wcss: fatal error received=
:
> [   13.813010] QC Image Version:
> QC_IMAGE_VERSION_STRING=3DWLAN.HK.2.7.0.1-01744-QCAHKSWPL_SILICONZ-1
> [   13.813010] Image Variant : IMAGE_VARIANT_STRING=3D8074.wlanfw.eval_v2=
Q
> [   13.813010]
> [   13.813010]     :Excep  :0 Exception detectedparam0 :zero, param1
> :zero, param2 :zero.
> [   13.813010] Thread ID      : 0x00000069  Thread name    : WLAN RT0
> Process ID     : 0
> [   13.813010] Register:
> [   13.813010] SP : 0x4bfacdc0
> [   13.813010] FP : 0x4bfacdd8
> [   13.813010] PC : 0x4b18d338
> [   13.813010] SSR : 0x00000001
> [   13.813010] BADVA : 0x009c9d7e
> [   13.813010] LR : 0x4b18d2b8
> [   13.813010]
> [   13.813010] Stack Dump
> [   13.813010] from : 0x4bfacdc0
> [   13.813010] to   : 0x4bfad400
> [   13.813010]
> [   13.860940] remoteproc remoteproc0: crash detected in
> cd00000.q6v5_wcss: type fatal error
> [   13.881901] remoteproc remoteproc0: handling crash #1 in cd00000.q6v5_=
wcss
> [   13.889965] remoteproc remoteproc0: recovering cd00000.q6v5_wcss
> [   13.922662] remoteproc remoteproc0: stopped remote processor
> cd00000.q6v5_wcss
>
> Kernel is 5.15.71
> ath11k is almost up to date (I believe only the last 2 or 3 commits
> are missing compared to 'ath-next')
>
> I also tried with firmware 2.6.0.1-00861, it yields the same firmware cra=
sh.
>
> Firmware 2.5.0.1-01208 is the last one that works properly.
>
> There are others who also experience the same firmware crash with the
> same device.
>
> Can you please help us with this?
>
> Regards,
> Csaba
