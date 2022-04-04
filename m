Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC6D34F179D
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Apr 2022 16:50:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349816AbiDDOvq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 4 Apr 2022 10:51:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354558AbiDDOvZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 4 Apr 2022 10:51:25 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02C4723BCD
        for <linux-wireless@vger.kernel.org>; Mon,  4 Apr 2022 07:49:15 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id z9-20020a05683020c900b005b22bf41872so7346424otq.13
        for <linux-wireless@vger.kernel.org>; Mon, 04 Apr 2022 07:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:from:subject:to:cc
         :references:content-language:in-reply-to:content-transfer-encoding;
        bh=QF1AbWF1FsN1/Qzjq17M6/poRQaG0jjTSkcR71d4GTo=;
        b=oFbyOurzFVNKn/F2TWyGlmuePshZgofOYfnxl8sofCiEWAYXTZNRh3SKHbVyZ3xAyy
         dCuPOuZGZSIY5pa9fNihKQ7dsCBGu1oGcF8fyYYUZxDiXfJzhkozwPBd19sZ6c31dAw+
         d0zsaKYnIb6EW9BnzLgjv1U96mRB/3DZuty7EjcxrN1AP4W+JgbXsdVk8+7LhmRoSY6t
         RC6URUDiof8FaJtmNegNpYPlO8KgvO7sUXVOSUsyWiuufnZTgR3w1LgB3KSE1Da5lBSO
         odU855Z1G0J4Ga6HrLF9eBCNwVw24pNeGea5GOJCfjlu3FrkYGx4m3xSmW6rAhsyPbA1
         47bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :from:subject:to:cc:references:content-language:in-reply-to
         :content-transfer-encoding;
        bh=QF1AbWF1FsN1/Qzjq17M6/poRQaG0jjTSkcR71d4GTo=;
        b=lKeYzBFvRdWOG5joLxMQPMoAAtQRvYv6mqLZF7rPHl5i4hTPn470Q57hy4Kx28StjI
         OSZPhGnX50fqtGL0uRHzsUDKoUcA1ICqKc1ubDm4ZaK9Sa4TTSZI3PXCVliznPWVIYrA
         l7aVyv3qn4KdRNs8ZyuZTNnhz/hxS6bC2vyT0+48nmWPdQhGC4q0T6RxlW91QRjaZvZC
         D5IS/cJMx5RC8TbSNQj/WiisoD8Rf1FzpF1v+LNYwuu/fftfqvdrv4b7V5lCTdIfIvgi
         YdQ9tFn11quQZrxlaZUiAVSTiM/QygWIwOtGDyO8wFlUTIdgHFQa2dmQh2EFoHIXfyN5
         tfCQ==
X-Gm-Message-State: AOAM531E9cWcGeRFQ8iJyl+k3A3CbRSIBmxMdOOD81F9h/QUYz30y5kT
        uxCzYijjM88YVOX86p7Qv0S2UsKf6YU=
X-Google-Smtp-Source: ABdhPJwVDx5BSavFHVb5Q3RoVY9fhaTLP7/5g7MBO11XfrbxLTd2bT0xIzrwAW+EaVQdovPB1kMvJg==
X-Received: by 2002:a05:6830:104c:b0:5c9:5d9f:e924 with SMTP id b12-20020a056830104c00b005c95d9fe924mr156701otp.369.1649083754165;
        Mon, 04 Apr 2022 07:49:14 -0700 (PDT)
Received: from ?IPV6:2603:8090:2005:39b3::1004? (2603-8090-2005-39b3-0000-0000-0000-1004.res6.spectrum.com. [2603:8090:2005:39b3::1004])
        by smtp.gmail.com with ESMTPSA id f8-20020a4ace88000000b00321598cd45dsm3973190oos.33.2022.04.04.07.49.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Apr 2022 07:49:13 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <ba45934b-69ab-edfa-1679-2e8e00fac126@lwfinger.net>
Date:   Mon, 4 Apr 2022 09:49:11 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
From:   Larry Finger <Larry.Finger@lwfinger.net>
Subject: Re: rtw_8822ce wifi regression after kernel update from 5.15 to 5.16
To:     "G. P. B." <george.banyard@gmail.com>, snecknico@gmail.com
Cc:     kvalo@kernel.org, linux-wireless@vger.kernel.org,
        regressions@leemhuis.info, regressions@lists.linux.dev,
        tony0620emma@gmail.com
References: <CAFPFaMLHXhHMhuAuvXWHb3c-tX_9qRxsquEUHXY0fMxh_VsKtw@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAFPFaMLHXhHMhuAuvXWHb3c-tX_9qRxsquEUHXY0fMxh_VsKtw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 4/3/22 13:11, G. P. B. wrote:
> Dear all,
> 
> Hopefully this email gets added to the thread correctly as I came here from 
> https://lore.kernel.org/linux-wireless/CAO_iuKG0gE=5fEKMF2A+iWUhsxtnPOQtTQTkBRo2vH5CmKu7iA@mail.gmail.com/ 
> <https://lore.kernel.org/linux-wireless/CAO_iuKG0gE=5fEKMF2A+iWUhsxtnPOQtTQTkBRo2vH5CmKu7iA@mail.gmail.com/>
> and using the mailto link with Gmail.
> 
> I'm also hitting this issue but I'm not sure if this is a regression in 5.16. 
> I've been struggling with weird random disconnects for a while but I blamed it 
> on the known bad router that I usually connect to at my university (at least 
> October 2021 when I got this laptop brand new).
> 
> The laptop is a HP Pavilion Laptop 15-eh0014na running Fedora 34:
> Linux fedora 5.16.18-100.fc34.x86_64 #1 SMP PREEMPT Mon Mar 28 14:46:06 UTC 2022 
> x86_64 x86_64 x86_64 GNU/Linux
> 
> Network driver:
> 02:00.0 Network controller: Realtek Semiconductor Co., Ltd. RTL8822CE 802.11ac 
> PCIe Wireless Network Adapter DeviceName: Realtek Wireless LAN + BT Subsystem: 
> Hewlett-Packard Company Device 85f7 Kernel driver in use: rtw_8822ce Kernel 
> modules: rtw88_8822ce
> 
> A sample, similar to the ones of Nico, of the output of dmesg -w:
> [ 915.489081] rtw_8822ce 0000:02:00.0: timed out to flush queue 1 [ 915.599086] 
> rtw_8822ce 0000:02:00.0: timed out to flush queue 2 [ 915.711096] rtw_8822ce 
> 0000:02:00.0: timed out to flush queue 1 [ 915.822106] rtw_8822ce 0000:02:00.0: 
> timed out to flush queue 2 [ 916.265097] rtw_8822ce 0000:02:00.0: timed out to 
> flush queue 0 [ 916.376085] rtw_8822ce 0000:02:00.0: timed out to flush queue 1 
> [ 916.449083] rtw_8822ce 0000:02:00.0: failed to get tx report from firmware
> 
> I'm not very proficient at debugging Linux so not sure how much more I can help 
> to narrow down the issue.
> But maybe a description of my experience might help, the WiFi icon still 
> considers at all time to be connected to the router and have a perfect signal.
> Sometimes enabling and immediately disabling Airplane mode fixes the issue 
> (probably due to a restart of the module?), and the issue is more likely to come 
> up after waking up from sleep.
> 
> I will try to see if I can rollback the kernel to 5.15 and see if that fixes the 
> issue and report back.
> 
> If I can be of any other assistance please let me know.

George,

I do not know of any regression in 5.16 with regard to the driver for RTL8822CE. 
Certainly, I saw no regressions in my testing of that driver from before it was 
in the kernel up to the present. That said, I can only comment on the user-space 
part of openSUSE Tumbleweed, which is probably not your distro of choice.

Are you using the drivers at https://GitHub.com/lwfinger/rtw88.git rather than 
the ones in the kernel? Your posted errors that refer to rtw_8822ce indicate 
that to be true. If the drivers came from the kernel, the reference would be to 
rtw88_8822ce! If so, do a 'git pull' to get the drivers updated to match the 
code in kernel 5.18. A lot of things have been fixed.

In your system, please do a 'lsmod | grep rtw'. If any items refer to rtw88_*, 
you have mixed drivers loaded. In that case, you should blacklist the rtw88_* 
driver.

Larry
