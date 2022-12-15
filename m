Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC9DD64E30F
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Dec 2022 22:28:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229927AbiLOV2F (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 15 Dec 2022 16:28:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbiLOV2E (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 15 Dec 2022 16:28:04 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BC0D2EB
        for <linux-wireless@vger.kernel.org>; Thu, 15 Dec 2022 13:28:01 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id m19so1033864edj.8
        for <linux-wireless@vger.kernel.org>; Thu, 15 Dec 2022 13:28:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/jPYg8cTwiO3WJtKs0bWAN0DFbB7s5PL49/jXiK0t3w=;
        b=B6VfxC/SzDmgGOipBvTq0Lj7hTjzxmqA3LhvFsAbpWzL/YWnc4mBlPPa98MCGt+Bg7
         Z/+d21XPt6phNaJVClbZLnKvGr4n9v0s7/IASUKbXKG/mIgDqoVy7GSmxcQnXR6sQUYd
         RjsEA85i8StEiqKvWFZGIxd0+c44MhlzoksfhlYrSHdOiZk3DCdOER0uXIoJSM+feUtG
         8FMNqi38J+f/CZzQ57QY+T1mQd11Ff9b96djycRDspRzRtJwn3l3HaYax8FzP6ePOfZW
         RWhdJ0okwdlXOcMto8QF/u2DJEfHfhYPGNuNh/sVo/NIbqCD7TVFE8AmOTT7WyTpgDNa
         3QJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/jPYg8cTwiO3WJtKs0bWAN0DFbB7s5PL49/jXiK0t3w=;
        b=18yTOHrLerfACVzQ4JgYdiBlvw4KxdiMxrZW4Ii7Slju8TMvpIMpf8lTRZsAAIjJBZ
         SBicuG4Gxh/Bf6I+qvN30cRiV/3MyBzvoJgyqGIRU+nlxqtpw4TGXZ4Tep8MdA/9bpCA
         /x/4QEDs6rsgERgXg7Gp9jNy9mJlnoIri6RByRXcxA6HKAettmcg4+iqI2Bg8J0r+UGw
         lRW8eVAuHgxH/CL6gJI82icuWhnDfI1iUkTSmIZsRcnXC+OYhzcNRO15U/IPWXxexWEW
         nmoDLpxpEusBPC9T8zitkYURdQ4GzcovjRkGHC5MupORpdBMlBTGyzVmAkTm1GNRsX+v
         nLhA==
X-Gm-Message-State: ANoB5pkxAqWDStTtFhLc3IMdCdbD7OQImTpwACqIu5vLdMyr5EdPI8sj
        lV3t6VR9i+6gBOm6h2csR86/q/Pye0KlMmC4aJTVxt8318s=
X-Google-Smtp-Source: AA0mqf55CT1D1WFGDrr2l8Ssv/hQ+Ib8FbgvnP5Om1SJPQzD390ohYVAQsDx/AYWTeE6PhCVIeP8putBYqfZKObuJMg=
X-Received: by 2002:aa7:cf82:0:b0:46b:34b:5804 with SMTP id
 z2-20020aa7cf82000000b0046b034b5804mr46330215edx.240.1671139679828; Thu, 15
 Dec 2022 13:27:59 -0800 (PST)
MIME-Version: 1.0
References: <CAJZ9B5tdZxqBG8pZhEKdzfaNqrR=8jGdNuMXJ7cYCitL7eatKw@mail.gmail.com>
 <27bdcf85-ed2f-40f6-a285-76879a8fbc6a@lockie.ca> <2a1b8b59-845e-d3b2-6195-2c74ce818341@lwfinger.net>
In-Reply-To: <2a1b8b59-845e-d3b2-6195-2c74ce818341@lwfinger.net>
From:   Joshua Richenhagen <richenhagen@gmail.com>
Date:   Thu, 15 Dec 2022 22:27:48 +0100
Message-ID: <CAJZ9B5v_D9rmc2dYNOB3FekAjKYw8Yukyuhp5qAqrM0Uf14K0w@mail.gmail.com>
Subject: Re: Realtek 1d3e:c826 not working
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     James <bjlockie@lockie.ca>, linux-wireless@vger.kernel.org
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

Thank you very much for the help Ping-Ke and Larry.

For anyone suffering from the same problem and using Ubuntu. I've
build a Kernel from wireless-next.git (6.1.0-rc8) and one from
linux-next.git (6.1.0-next-20221215) which both brings bluetooth and
wifi to work with this chip.

https://drive.google.com/drive/folders/134-ohL57i8n7aW48gZ-ielh1-Vpczm0h?usp=sharing

Am Mi., 14. Dez. 2022 um 18:02 Uhr schrieb Larry Finger
<Larry.Finger@lwfinger.net>:
>
> On 12/12/22 13:19, James wrote:
> > https://askubuntu.com/questions/1412450/network-driver-for-realtek-10ecb852
> >
> > Dec. 12, 2022 11:43:59 Joshua Richenhagen <richenhagen@gmail.com>:
> >
> >> Hello,
> >>
> >> on my new Xiaomi Book Pro 14 Ryzen with Realtek b852 using newest
> >> kernel Linux 6.1 Wifi is not recognized at all. Is the PCIe device ID
> >> missing in the rtw89 driver?
> >>
> >> 01:00.0 Network controller: Realtek Semiconductor Co., Ltd. Device b852
> >>          Subsystem: Device 1d3e:c826
> >>          Flags: fast devsel, IRQ 255, IOMMU group 11
> >>          I/O ports at 2000 [disabled] [size=256]
> >>          Memory at c0900000 (64-bit, non-prefetchable) [disabled] [size=1M]
> >>          Capabilities: [40] Power Management version 3
> >>          Capabilities: [50] MSI: Enable- Count=1/1 Maskable- 64bit+
> >>          Capabilities: [70] Express Endpoint, MSI 00
> >>          Capabilities: [100] Advanced Error Reporting
> >>          Capabilities: [148] Device Serial Number 00-e0-4c-ff-fe-88-52-01
> >>          Capabilities: [158] Latency Tolerance Reporting
> >>          Capabilities: [160] L1 PM Substates
> >>
> >> Kinds regards
> >> Joshua Richenhagen
>
> That driver will not be in the kernel until kernel 6.2, which is predicted to be
> released on Feb. 19, 2023.
>
> In the meantime, clone the rtw89 repository at
> https://github.com/lwfinger/rtw89.git, and follow the instructions in README.md
> in the cloned repo. Pat particular attention to the last paragraph if you are
> running Ubuntu. For some reason, they have not included the firmware for this
> device even though it has been in the official linux-firmware repo since October.
>
> Larry
>
