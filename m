Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73B1970F389
	for <lists+linux-wireless@lfdr.de>; Wed, 24 May 2023 11:54:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231167AbjEXJyP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 24 May 2023 05:54:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232020AbjEXJyA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 24 May 2023 05:54:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AAB1184
        for <linux-wireless@vger.kernel.org>; Wed, 24 May 2023 02:53:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B4264629A0
        for <linux-wireless@vger.kernel.org>; Wed, 24 May 2023 09:53:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E39E9C433D2;
        Wed, 24 May 2023 09:53:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684922033;
        bh=LBztt9LoyPY/XquFLTs0T7VWX7VrvUKUT1G85x0Yxho=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=jVfzSewanpXoRGhiq9k+55gNai0/HE8I8JKpTTHUFf6oqhGw+mN6hCZgs5j9C07lt
         su4s1f3TFuVSFDJ1j1epEY5KSgpUZPJrZ6trCwlGXqWS1+w54VjkfASxiAjtC9jIyR
         waWWEwpzU3JPbhx/ljF4V8+SSui6xO59Gd1TLrMlCl60QClEO2SO8+lv1VrXXPAHn+
         8TswkQRP2frD1T1hfb2yaAxhznxvaBWTM2c0+e84UHNemA2ouQToBzgZXg96zsCs9N
         Wxh25NJXrwR31MSlIgn9hx1eBYZ3cfKCEML+a9x2jeEc14v4XuVFZqqNNIR3q4ipX4
         gGnt1OJpPDC3g==
From:   Kalle Valo <kvalo@kernel.org>
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     Jernej =?utf-8?Q?=C5=A0krabec?= <jernej.skrabec@gmail.com>,
        Ping-Ke Shih <pkshih@realtek.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        "linux-wireless\@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "tony0620emma\@gmail.com" <tony0620emma@gmail.com>
Subject: Re: wifi: rtw88: questions about adding support for RTL8723DS/RTL8723BS
References: <CAFBinCD=HVyedXpqRfAC=m3A=wstDbtQfLDZqjHufSawdLKwiw@mail.gmail.com>
        <5a47af41569c4f0b91d6d2bc054586d0@realtek.com>
        <CAFBinCD3nPPHUmtoqRch87SOXpLcfrzOT7SDdsJdGe-KGOK9Mg@mail.gmail.com>
        <5673351.DvuYhMxLoT@jernej-laptop>
        <e2dc78fd-014a-14d1-9b4e-9ad251e1d9e1@lwfinger.net>
Date:   Wed, 24 May 2023 12:53:49 +0300
In-Reply-To: <e2dc78fd-014a-14d1-9b4e-9ad251e1d9e1@lwfinger.net> (Larry
        Finger's message of "Thu, 18 May 2023 13:48:28 -0500")
Message-ID: <87lehekqc2.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Larry Finger <Larry.Finger@lwfinger.net> writes:

>>>> To make rtlwifi support SDIO is another way. It seems like add a HCI is
>>>> easier than an new chip, and we can have a simple support list of rtlwifi
>>>> and rtw88 eventually, like
>>>>
>>>>          rtlwifi       rtw88
>>>> 8723BE    o
>>>> 8723BS    o?
>>>> 8723DE                  o
>>>> 8723DS                  o
>>> Per chip support matrix is:
>>> 8723BE: rtlwifi
>>> 8723BU: rtl8xxxu
>>> 8723BS: staging driver which I'd like to replace
>>> 8723DE/U/S: rtw88
>>>
>>> HCI support matrix:
>>> rtlwifi: PCIe, USB
>>> rtl8xxxu: USB
>>> rtw88: PCIe, USB and SDIO
>>>
>>> So it seems you are right: I should consider whether adding RTL8723BS
>>> support to rtw88 is the right choice.
>>
>> While rtw88 might not be best choice by above matrix, it seems to be most
>> featureful, stable and at least from what I saw, easiest to add new variants.
>>
>> I'll do a bit of experiment with rtw88 to see how hard it would be...
>>
>> Best regards,
>> Jernej
>
> Now that RTL8192CU is being handled, the USB part of rtlwifi is being
> considered for deletion. If you decide in terms of adding RTL8723BS to
> rtlwifi, please let me know.

From higher level point of view I would prefer rtlwifi going away in the
long run and the development focus be on rtl8xxxu, rtw88 and rtw89. So
if at all possible, please avoid adding new hardware support to rtlwifi.

But of course I'm not familiar with Realtek designs so please do correct
if I'm missing something :)

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
