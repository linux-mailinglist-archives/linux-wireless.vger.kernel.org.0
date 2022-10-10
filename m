Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E1995F9EC0
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Oct 2022 14:34:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231513AbiJJMeD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 10 Oct 2022 08:34:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230463AbiJJMeC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 10 Oct 2022 08:34:02 -0400
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D12F6161
        for <linux-wireless@vger.kernel.org>; Mon, 10 Oct 2022 05:34:01 -0700 (PDT)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-1321a1e94b3so12321739fac.1
        for <linux-wireless@vger.kernel.org>; Mon, 10 Oct 2022 05:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BCoJGdgEXWgTh9X1IKXUrdb6MFIEOWpxwvdtUJ9BG50=;
        b=RofXUp24YEN2O3TfPg/vQMAAniNPzPzW2MTeYXYN1qWZjhW7Se0WFkwsE670dsBa7I
         A+YaDooLlIa5/qcNg1vdczciV2eA0C1M/L61hA/voNFH8pvmqMCUybK24giO7YnE8uCO
         05I9siy9oODx7c2zmnR+piawl8usQF7RLfwBIDXgR2U/nNdIwvsrf0lgFgEA9tt+Y9No
         BuRDQW2YqADZEac/i7WgV5jGcepGU+2LvwPCSc6PFk03bbACviJkfQU2oKzw9RiotOcF
         A1VCQemgZpAujt5r+I93u1PFx1ig2yaqBZuFFj5CHsfF4umf5PY2tC5oQQsQYi1BT2kU
         FS8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BCoJGdgEXWgTh9X1IKXUrdb6MFIEOWpxwvdtUJ9BG50=;
        b=k0wTCeAhRrh6OA7ZCiCRGi+9eKeHKN0akaGrq+cG0j+mFRW1kCh2lzjn6ymoVPeITG
         PQKa5xUDG2PTaSzTe061MJ7jFQoGP5dOUzjDUUxabOrkoJHRJg7zkCd+C6wHSqIzvfNP
         eFg1IwVd2iAOMimlwD09WpnG4C6PaBfDockioYhSBBbniBIyT3hbxzKTEJaNdNGSN9zv
         4M7mGcoB9JZdEQFCNY/gjEgXpd6rifdTdyIHT6yrVTQnNhq9twDqXuvJvySrPOQCIXk/
         wX82a7vCqwlw+u6HGKMAr/mKqxMwqpfzCzJ6mbjiULL4/Otcj1+T6AePkKTsOVit3t8P
         HTNA==
X-Gm-Message-State: ACrzQf2x2TZ0erImUcqLpxOpEeGTiRwv1WFO5iMpi+mmDSo3jXesAxJ0
        G3VYhVipB8eXeO3o+/iZEYear7zF6a9W4ZaKfx8AY0pA5jg=
X-Google-Smtp-Source: AMsMyM5cf6kPzr7jE5GAUyCfXnqbN5K9xtd8rGsz/qxfIlb5FN7dL+P1uofm4NP2vWG4X1rYw+TGRERCHxDYMMzWFWE=
X-Received: by 2002:a05:6871:207:b0:132:7706:e74f with SMTP id
 t7-20020a056871020700b001327706e74fmr15450140oad.8.1665405240348; Mon, 10 Oct
 2022 05:34:00 -0700 (PDT)
MIME-Version: 1.0
From:   Sipos Csaba <dchardware@gmail.com>
Date:   Mon, 10 Oct 2022 14:33:22 +0200
Message-ID: <CALQr=E--ECWhEGFU1pQ2f093eNgChdJ=gMZDu5ZhZeTRSGj0Sw@mail.gmail.com>
Subject: ath11k: firmware crash above version 2.5.0.1 _01208 (IPQ8074)
To:     kvalo@kernel.org, linux-wireless@vger.kernel.org,
        robimarko@gmail.com
Content-Type: text/plain; charset="UTF-8"
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

I tried the latest firmware available on your github account for
IPQ8074 on my Xiaomi AX6 router, and it produces a firmware crash
right after the Q6 processor tries to boot:

[    7.503844] ath11k c000000.wifi: ipq8074 hw2.0
[    7.504147] remoteproc remoteproc0: powering up cd00000.q6v5_wcss
[    7.511424] remoteproc remoteproc0: Booting fw image
IPQ8074/q6_fw.mdt, size 668
[    8.511575] remoteproc remoteproc0: remote processor
cd00000.q6v5_wcss is now up
[    8.517199] kmodloader: done loading kernel modules from /etc/modules.d/*
[    8.555705] ath11k c000000.wifi: qmi ignore invalid mem req type 3
[    8.563181] ath11k c000000.wifi: chip_id 0x0 chip_family 0x0
board_id 0xff soc_id 0xffffffff
[    8.563231] ath11k c000000.wifi: fw_version 0x270204a5
fw_build_timestamp 2022-08-04 13:05 fw_build_id
WLAN.HK.2.7.0.1-01744-QCAHKSWPL_SILICONZ-1
...................................
[   13.813010] qcom-q6v5-wcss-pil cd00000.q6v5_wcss: fatal error received:
[   13.813010] QC Image Version:
QC_IMAGE_VERSION_STRING=WLAN.HK.2.7.0.1-01744-QCAHKSWPL_SILICONZ-1
[   13.813010] Image Variant : IMAGE_VARIANT_STRING=8074.wlanfw.eval_v2Q
[   13.813010]
[   13.813010]     :Excep  :0 Exception detectedparam0 :zero, param1
:zero, param2 :zero.
[   13.813010] Thread ID      : 0x00000069  Thread name    : WLAN RT0
Process ID     : 0
[   13.813010] Register:
[   13.813010] SP : 0x4bfacdc0
[   13.813010] FP : 0x4bfacdd8
[   13.813010] PC : 0x4b18d338
[   13.813010] SSR : 0x00000001
[   13.813010] BADVA : 0x009c9d7e
[   13.813010] LR : 0x4b18d2b8
[   13.813010]
[   13.813010] Stack Dump
[   13.813010] from : 0x4bfacdc0
[   13.813010] to   : 0x4bfad400
[   13.813010]
[   13.860940] remoteproc remoteproc0: crash detected in
cd00000.q6v5_wcss: type fatal error
[   13.881901] remoteproc remoteproc0: handling crash #1 in cd00000.q6v5_wcss
[   13.889965] remoteproc remoteproc0: recovering cd00000.q6v5_wcss
[   13.922662] remoteproc remoteproc0: stopped remote processor
cd00000.q6v5_wcss

Kernel is 5.15.71
ath11k is almost up to date (I believe only the last 2 or 3 commits
are missing compared to 'ath-next')

I also tried with firmware 2.6.0.1-00861, it yields the same firmware crash.

Firmware 2.5.0.1-01208 is the last one that works properly.

There are others who also experience the same firmware crash with the
same device.

Can you please help us with this?

Regards,
Csaba
