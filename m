Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3501F542505
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Jun 2022 08:54:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229669AbiFHEqr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 8 Jun 2022 00:46:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbiFHEp4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 8 Jun 2022 00:45:56 -0400
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com [IPv6:2001:4860:4864:20::33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C06623C65A
        for <linux-wireless@vger.kernel.org>; Tue,  7 Jun 2022 18:03:48 -0700 (PDT)
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-f2a4c51c45so25376404fac.9
        for <linux-wireless@vger.kernel.org>; Tue, 07 Jun 2022 18:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=7xE5uLkT//96EF3wJ5+yMU2MvyoX0Nb5hjXmGn0XY6U=;
        b=MdR2LSaGaZAXlxOy0gAfkyDFeIDWxNQJRT44FnG8fiCycUwE1BnC3ElPMoM8HcDnmU
         yMNI7o6eb4WhDzGBLYiuNFVIKkQBMMxansx8QFCAUBJzJKEXS9Y4YIaF1Im7b9FpFQHa
         qHWi5ATQ4gTxW/j+QXYLF8JI5EBPVbDHRK3Uj4/Flm7DfdXVg26REJcR9s5x64k9XcHl
         +ozCTuuQpaucjB0lMd8qgRtYr4Qf0I2NWy+HoLRBiI/gXe1BK0x8cFQD1SfYuwQKEngG
         vHd1YzWMbrU++SxTblAmfx9CuUyGjaiNnzKMbhWihaHn1uNxtLYEUxRZkMAOeCQJe3+8
         GgSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=7xE5uLkT//96EF3wJ5+yMU2MvyoX0Nb5hjXmGn0XY6U=;
        b=YRhkj5OJoagcjTTWLWhQn3/5y+6G8R4dvoUZHof3burWSX05XwcwYXfrAfKdj65+GD
         sSFSFYJMLQsAYSsAJ4YoVMzMr+/kbF8MEi1SYRB4WV1RL+AfUS1IKPm1d8k8/y3WqC/A
         RBbYz3MnWh1jnBxcIwxrfwU/lpf1uq49IIIZ0t2FVINvvTs65JZxjpXnPUH/FGjOlFv4
         4MvisOBGSftDhtvfnThUvU/yt4XOwGQ8jmUnf1fHUbw/1QtpaBx1Ahhp4sGPCW/gk69P
         h0h1dnZDiU/I/FjtSjXxvv68z4dIpUDtk3hJ/2S4jMLS/BJEIE5doiyL1mzk4o1iCWjs
         DJSA==
X-Gm-Message-State: AOAM5332mCeEU0KgUXED+bzkwjqCS1kbMmEntFBarD0Xd+R0m7OyI78l
        DwJ+MiTlc+7DGeDCrapIpYk=
X-Google-Smtp-Source: ABdhPJww0/Yw3AFtekNHZlWOkwohG+jKr/aFTdLsTNCG6XPxnqOzmxcXtMBJ17OGL3l0EceMKYy+zg==
X-Received: by 2002:a05:6870:f698:b0:f2:cbde:a121 with SMTP id el24-20020a056870f69800b000f2cbdea121mr1003984oab.149.1654650206496;
        Tue, 07 Jun 2022 18:03:26 -0700 (PDT)
Received: from ?IPV6:2603:8090:2005:39b3::100e? (2603-8090-2005-39b3-0000-0000-0000-100e.res6.spectrum.com. [2603:8090:2005:39b3::100e])
        by smtp.gmail.com with ESMTPSA id l14-20020a0568302b0e00b0060b66e2eaaesm10119282otv.38.2022.06.07.18.03.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jun 2022 18:03:25 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <aad47f4f-a5bc-e8e2-15d3-2baf2512b661@lwfinger.net>
Date:   Tue, 7 Jun 2022 20:03:24 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v3 4/4] rtw88: Fix Sparse warning for rtw8821c_hw_spec
Content-Language: en-US
To:     Ping-Ke Shih <pkshih@realtek.com>,
        Nathan Chancellor <nathan@kernel.org>
Cc:     Kalle Valo <kvalo@kernel.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
References: <20220524153716.20450-1-Larry.Finger@lwfinger.net>
 <Yp+hfo5Uual8ZUkR@dev-arch.thelio-3990X>
 <e28ce50b-c1e6-74ae-6f57-5f864ba0c93a@lwfinger.net>
 <45a6b6ea84c74ffeafff1b68c2e1c5e3@realtek.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
In-Reply-To: <45a6b6ea84c74ffeafff1b68c2e1c5e3@realtek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 6/7/22 19:25, Ping-Ke Shih wrote:
> 
>> -----Original Message-----
>> From: Larry Finger <larry.finger@gmail.com> On Behalf Of Larry Finger
>> Sent: Wednesday, June 8, 2022 5:26 AM
>> To: Nathan Chancellor <nathan@kernel.org>
>> Cc: Kalle Valo <kvalo@kernel.org>; Johannes Berg <johannes@sipsolutions.net>;
>> linux-wireless@vger.kernel.org; Ping-Ke Shih <pkshih@realtek.com>
>> Subject: Re: [PATCH v3 4/4] rtw88: Fix Sparse warning for rtw8821c_hw_spec
>>
>> On 6/7/22 14:05, Nathan Chancellor wrote:
>>> Hi Larry,
>>>
>>> On Tue, May 24, 2022 at 10:37:16AM -0500, Larry Finger wrote:
>>>> Sparse lists the following:
>>>>
>>>>     CHECK   drivers/net/wireless/realtek/rtw88/rtw8821c.c
>>>> drivers/net/wireless/realtek/rtw88/rtw8821c.c:1880:22: warning: symbol 'rtw8821c_hw_spec' was not
>> declared. Should it be static?
>>>>
>>>> The warning arises because the external declaration for rtw8821c_hw_spec
>>>> occurs in rtw8821ce.h, which is not included in rtw8821c.h. That line is
>>>> moved, and the now empty file rtw8821ce.h is deleted.
>>>>
>>>> Symbol 'rtw8821c_hw_spec' can be made constant.
>>>>
>>>> Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
>>>
>>> I bisected this change as commit 89d8f53ff6e7 ("wifi: rtw88: Fix Sparse
>>> warning for rtw8821c_hw_spec") in linux-next as the cause of one of my
>>> test machines failing to boot with the following stacktrace:
>>>
>>> BUG: unable to handle page fault for address: ffffffffc09f52f4
>>> #PF: supervisor write access in kernel mode
>>
>> Nathan,
>>
>> Thanks for your excellent report. Does the attached patch fix your issue?
>>
> 
> Hi Larry,
> 
> How about keeping rtw8821c_hw_spec const, but move ch_param[3] from
> 'struct rtw_chip_info' to 'struct rtw_hal'?
> 
> If you agree this, I can prepare a patch.
> 

If that fixes the crashes, that is fine with me. The other 3 devices will need 
the same fix.

Larry

