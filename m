Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF2496C06C2
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Mar 2023 01:12:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbjCTAMe (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 19 Mar 2023 20:12:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjCTAMd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 19 Mar 2023 20:12:33 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0405718B28
        for <linux-wireless@vger.kernel.org>; Sun, 19 Mar 2023 17:12:31 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id m20-20020a9d6094000000b0069caf591747so5914816otj.2
        for <linux-wireless@vger.kernel.org>; Sun, 19 Mar 2023 17:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679271151;
        h=content-transfer-encoding:in-reply-to:from:cc:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=MPKKxBGurVcJpOp8++Iur8ThzKKZcWzxBXDor1oGeek=;
        b=bYba7EBq994Uj8nb3GJoazsGFdm/eagxvMZMyBbHncWBT3fgRaakHman60nqOkhBzh
         JaLl/iTHltCRppDxp+58je7/YdHmtjjQJ0cJNpYHlU/amKaLDj0JgOVF1GluT31KGCxu
         Hs8SFfiskNCoWjlW+L1RAtgbtJR7Mtzew//FFEMR9oK9x/kpM4JCulOcDa0rg5Y52png
         UQJW5GkWL2sqAbUHyAczgWDahtMDXyoNT7fKfau2Twi2ufHEK3Gqi1wk6Do/Th0r4vn6
         2jjoqliuhzrvOfMBqhx4d8mBSyz9kUi5ZX2MRV9lpgJ86JLMy1ghSATZMUq5Qd5RrEms
         Zzlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679271151;
        h=content-transfer-encoding:in-reply-to:from:cc:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MPKKxBGurVcJpOp8++Iur8ThzKKZcWzxBXDor1oGeek=;
        b=CsNW3lfwUjIiGi03FAmlAWSfT/vozC2p7ELq4OCZlgHdYb1OacDM5LmwGlrQpIFxMP
         LPGyuwnQjwA1fA3BZWISr8UIw/eJ63vqBqzmUx10D3xiDdGw6POeJR0ll7T36cI10V7j
         GRfEcrj7TFIESKWMKMYm+iJ2tuJjYJZBMUmO5vBWz3SVpojDZlzF0MfVEXpQNNK4otlw
         QmzMqxk6D8WAdumVmOdCEt229pgDzAPFQnS8ONpKH5EDnBy3OpuPG8rtspSEeC8QIQcr
         e9/d+i/WiqRmcwQLEe8NSEKXtPKjBZ/3rcCyy5HKwlV2Ho+ckOD+yUR1b5J4IVqkC36E
         6DHA==
X-Gm-Message-State: AO0yUKXO3vaH0DU3KWowNCHX4hUb6DQp0muVEStwrE/cqkaoTNQ9d3jp
        VX/xrDEoDPyK3+OMGnEP60/03t2AfbI=
X-Google-Smtp-Source: AK7set8WNMYD4JmOWdSCNeJgBuPr4g/YvbYtZXXK3A5y4lgSdKwHSKtOnlCi8sPSzBNlW/kOevHk8w==
X-Received: by 2002:a05:6830:1d4c:b0:699:dec2:7c62 with SMTP id p12-20020a0568301d4c00b00699dec27c62mr3450401oth.32.1679271151172;
        Sun, 19 Mar 2023 17:12:31 -0700 (PDT)
Received: from [192.168.1.119] ([216.130.59.33])
        by smtp.gmail.com with ESMTPSA id k17-20020a056830169100b0069f14187a8csm1320676otr.4.2023.03.19.17.12.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Mar 2023 17:12:30 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <1db6b607-faff-9ae2-0cf3-567d9c86e4ba@lwfinger.net>
Date:   Sun, 19 Mar 2023 19:12:29 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: Kernel 6.2.4 and WiFi with BCM4345
Content-Language: en-US
To:     arm@lists.opensuse.org, Michael Ayers <anothergrump@runbox.com>
References: <e26eeebb-4fb0-5506-afbc-e9b56b849211@runbox.com>
 <c09e012e-7abd-7304-3721-799758a7f0e3@lwfinger.net>
 <cc6e8c12-33b7-7c42-345b-c3212b13bc77@runbox.com>
 <fa88eb52-7194-ecb2-0590-f554a12485ec@runbox.com>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>
From:   Larry Finger <Larry.Finger@lwfinger.net>
In-Reply-To: <fa88eb52-7194-ecb2-0590-f554a12485ec@runbox.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 3/19/23 14:35, Michael Ayers wrote:
> 
> On 20/03/2023 08:24, Michael Ayers wrote:
>>
>> On 20/03/2023 07:58, Larry Finger wrote:
>>> On 3/19/23 13:20, Michael Ayers wrote:
>>>> Kernel 6.2.4-1-default has broken wifi on the Pinebook pro, kernel 
>>>> 6.2.1-1-default works fine.
>>>>
>>>> Logs give me so much information that I am not sure where to begin.
>>>
>>> The first piece of information would be to tell us what what device you have. 
>>> The Pinebrook Pro web site says that you have an 802.11ac (Wifi 5) device, 
>>> but not who made it. The output of 'lspci -nn' or 'lsusb' would be useful.
>>>
>>> You should also run the command 'sudo dmesg > dmesg.txt', and post dmesg.txt 
>>> at pastebin.com, or some similar site. Report the URL back with the ouput of 
>>> the two commands above. Do not attach dmesg.txt to your reply. There are 
>>> thousands of readers of this list that do not care, thus they should not be 
>>> forced to download such stuff.
>>>
>>> Larry
>>>
>>>
>> The wifi device would seem to be a Broadcom 4345 and if I've done this right 
>> this: https://pastebin.com/rz2wnuVt should be the link to dmesg.txt.
>>
>> MIke
> 
> 
> Sorry that is the wrong dmesg link it should be: https://pastebin.com/SE0DV7XP

Mike,

I just noticed that the linux-wireless list was not in the Cc list - I added it. 
I also changed the subject to help catch the attention of the Broadcom 
maintainers. I am definitely not one of them.

Your device is a BCM4345, which uses the brcmfmac driver. The dmesg output that 
you posted shows the firmware loading, but nothing happens beyond that. This is 
the point where I would expect the user-space code such as NetworkManager to 
take over. What code do you use to control wifi? Did that change when your 
kernel was updated?

Larry




