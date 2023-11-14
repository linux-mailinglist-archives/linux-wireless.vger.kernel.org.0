Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D4DE7EAFD9
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Nov 2023 13:30:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232919AbjKNMaQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 14 Nov 2023 07:30:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbjKNMaP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 14 Nov 2023 07:30:15 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9167C13A
        for <linux-wireless@vger.kernel.org>; Tue, 14 Nov 2023 04:30:12 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-6bd73395bceso4331689b3a.0
        for <linux-wireless@vger.kernel.org>; Tue, 14 Nov 2023 04:30:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699965012; x=1700569812; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tQTfT0zTJuBtXZlDzif1ZDcc9hhUB4tbfGAcFSTfp4A=;
        b=BfTe5cpcDG4iv1AuQNdSg6Y9mLygk9T6ZqR0sc0+bcN4nXeFDcs/7rFVy08L7YJkfX
         Lr7gWRybpWLF9oMAxR3S8p7oKdW3NgrnrZQ1+d5DxGLe2vHp1/Haifx2Le+wP7jThI+c
         RJI/89PL3PYLnu9KqYpPGKeLYYXinNDkQgIGO/kbbXzwFd+hSqAFjXaf0UBCzkNrIG7C
         HOPfl5AYON9CUbJ6SBcScDgwcKq2XCrBPnGaUpGL8KYp3FelViBxGrK/qVn7Yz7TaEa/
         rtk+h7IK41pvb5/SZ404Zf6V8rVqIl0J2hTDSPQjko+7OoUHQU7bSrR/FQgXI60Ub7/q
         gzlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699965012; x=1700569812;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tQTfT0zTJuBtXZlDzif1ZDcc9hhUB4tbfGAcFSTfp4A=;
        b=TLScqw4NKC+9zQiVAVUYW/a/X/xKeskGF0CIdS+MqdT3Qz6aJJbU6p43Zn7XQwJjWW
         fNPL2eSO2XSwpAVTNihr+AuP7voD5uqAMDlW2JKN7oD7PO95T7zWF8bgj9o+WotyEusS
         GjNmbf5HpGHDd+FEoaY9ZbPx9eDMNvcd/E7JjdmrVP0FInHJQMrGOy8epoba7ecf+brU
         xvhyF1R8ijLuQjnJWrCp1EYorsU9/Ag7rjijXdPszKH8LUtsg9VCseO/MRWPLmJ1MXNS
         434zdqN5ys4Ain1miVzduZM2XFu786+JqwgoFOoil42/o7RFVfKpLiIy4acCODMIORHi
         wxow==
X-Gm-Message-State: AOJu0YycFl2kCtf+HV+JTgQfsX5hk7oNLerXTLhMN8rNIIlwaih47L7a
        3ETUbdYCSeW5Sws+C4hUkVQ=
X-Google-Smtp-Source: AGHT+IHdYTorzfhXpsHtmI5qrCwfNwvSuQ0qqSZFH+2P0Kw23tu5RTgepsehkE7dMCwXWUaLGschdQ==
X-Received: by 2002:a05:6a00:783:b0:68b:a137:373d with SMTP id g3-20020a056a00078300b0068ba137373dmr2848049pfu.17.1699965011931;
        Tue, 14 Nov 2023 04:30:11 -0800 (PST)
Received: from [192.168.254.82] ([50.39.172.77])
        by smtp.gmail.com with ESMTPSA id fi42-20020a056a0039aa00b006bb5ff51177sm1066326pfb.194.2023.11.14.04.30.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Nov 2023 04:30:11 -0800 (PST)
Message-ID: <c8e75ea8-39b9-4f70-a3e9-3c9c4372cf20@gmail.com>
Date:   Tue, 14 Nov 2023 04:30:08 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath10k: add support to allow broadcast action from
 RX
Content-Language: en-US
To:     Kalle Valo <kvalo@kernel.org>
Cc:     linux-wireless@vger.kernel.org, ath10k@lists.infradead.org
References: <20231017165306.118779-1-prestwoj@gmail.com>
 <169989062657.3473659.188127753057713210.kvalo@kernel.org>
 <2033c16c-4d9a-4592-bb81-7a9ad7821576@gmail.com> <87wmuk926d.fsf@kernel.org>
From:   James Prestwood <prestwoj@gmail.com>
In-Reply-To: <87wmuk926d.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 11/14/23 12:20 AM, Kalle Valo wrote:
> James Prestwood <prestwoj@gmail.com> writes:
> 
>> On 11/13/23 7:50 AM, Kalle Valo wrote:
>>> James Prestwood <prestwoj@gmail.com> wrote:
>>>
>>>> Advertise support for multicast frame registration and update the RX
>>>> filter with FIF_MCAST_ACTION to allow broadcast action frames to be
>>>> received. Broadcast action frames are needed for the Device
>>>> Provisioning Protocol (DPP) for Presence and PKEX Exchange requests.
>>>>
>>>> Signed-off-by: James Prestwood <prestwoj@gmail.com>
>>>> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
>>> On what hardware and firmware did you test with this? As there's so
>>> many
>>> different combinations in ath10k we use Tested-on tag to document that.
>>> https://wireless.wiki.kernel.org/en/users/drivers/ath10k/submittingpatches#tested-on_tag
>>> As ath10k hardware and firmware can work very differently from each
>>> other I'm
>>> suspicious if this feature really work in all of them.
>>
>> I only tested on a QCA6174 (and I'll add Tested-on for that). This
>> makes sense and maybe enabling unconditionally for all ath10k hardware
>> is the wrong way to go about it.
>>
>> Since I don't have the ability to test every hardware combination
>> hopefully someone from atheros can chime in.
> 
> Heh, Atheros is long gone. But your comment made me remember the good
> old times and smile :)

Oh yeah, QCOM bought Atheros just before I got my first job there. 
Wasn't sure if the remaining devs still thought of themselves "Atheros" 
employees to this day :)

> 
>> Is there some firmware/driver value that can be queried which tells me
>> if broadcast RX is supported?
> 
> A good question for which I don't have an answer. Does anyone else know?
> 
> Do you have a simple test case for this? It would help if people could
> test this feature on their ath10k devices and send us results.

I could try and come up with something. I've been testing with 2 
devices, running the full DPP protocol between... not exactly "simple".

I suppose you could create a station device, register for beacons, just 
sit and see if you see any. I'm not sure though if this is a 1:1 test 
since really its action frame I'm after, and the firmware may treat them 
differently.

> 
>> Or if not is checking ar->hw_rev == ATH10K_HW_QCA6174 good enough?
> 
> BTW instead of checking ar->hw_rev our preference is to add a new
> boolean to struct ath10k_hw_params. That way it's easier to enable and
> disable the feature per hardware version.
> 
>> Or are there sub-variants that may or may not support this?
> 
> There are several QCA6174 variants and you can check the variants from
> ath10k_hw_params_list. For example, hw2.1 or SDIO firmware may very well
> behave different from the PCI firmware. To be on the safe side I think it's
> best to enable the feature only on the hardware versions we have
> verified to work.

Sounds good, I can make it specific to just my hardware and others could 
expand in the future if they need. Out of curiosity is ath9k much more 
limited on unique hardware? I based this patch off one from Jouni for 
ath9k [1] and it unconditionally enables it for the entire driver.

[1] 
https://lore.kernel.org/linux-wireless/20200426084733.7889-1-jouni@codeaurora.org/

Thanks,
James
