Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D5BE4D76A8
	for <lists+linux-wireless@lfdr.de>; Sun, 13 Mar 2022 17:12:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231139AbiCMQNj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 13 Mar 2022 12:13:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229983AbiCMQNh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 13 Mar 2022 12:13:37 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B8005548B
        for <linux-wireless@vger.kernel.org>; Sun, 13 Mar 2022 09:12:28 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id o64so14949634oib.7
        for <linux-wireless@vger.kernel.org>; Sun, 13 Mar 2022 09:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=mJpFMVuCYlnW7eWtSw4TfTI3vUlrflzAPWRAZBXH+0w=;
        b=nPLvdYJSV4Hbi2c9b+S9jNijStYQsOEHxSyQ5KylvDx7eHe/apJ9zWNv6gy5gnXaOo
         HYhepxAVpyvKwh9cr/bsgFBvtzcq7FgoUWyjtOPQkSK2ThssiL/JUXTGN/atlbJOjtUs
         czuvStAavF3g+rHTd5mDIfJNNJsgey+Zf6pO83A85KCEmsFX6jTWuYJ839Rsavwnp0nT
         onJ+t3wR252/uLL1aEMnq81M4z5J39ooi19pde6g49TqXGn8F9+orkULPDjJZfJ1IGui
         arUHI049bhLLXatTyVM2rAd1g21Yq0haW31UxH0SPg4J3i8iIbdKFcuW/EWjPn+B7xlT
         925A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=mJpFMVuCYlnW7eWtSw4TfTI3vUlrflzAPWRAZBXH+0w=;
        b=faWxlTv5jSxADe/szhV6WZYnCi+GJj8TPqmjlAMR83BdUHNGoBg1mO3ITS3OqvXWXI
         Nb89AEJ1/1JQM+IvRHTUm4S2OgX7U9f5Z4B8LJ0445S5OVVS4OkCEnCJYXL3U1jVtPid
         HqE5fz9r9RESvnaRxGCV7M/xCCF9wGPuy3wMbxYG/4qWKi0E9hAP7DiYWYCAsZJEAQ2O
         QfLskV2sSFLL03cdeHdj/QWcvJvjUDE3+YuVZxzcq0e7NMGBQ8cySwWhvV0Kf0SRYE+/
         lkWgHGmEi/OHi8syKCR4OFCV++b6ApGM2xCFrFap9v0JHFzyCFqud3Vv2gmq8iQHmjtE
         wqhw==
X-Gm-Message-State: AOAM532oWrDKvP6VWGGNuCFC5mQGhXMturINypzftpgJZYKxQ/5caVt4
        FuwImdb9DjmHGuTAaDmIC/0Mx4FwwdQ=
X-Google-Smtp-Source: ABdhPJyip1xpDoo797x6abdj145AXLlJDKGvfSL5k6g2UdtfXp/A1JlWO5pNnLNlq/SO0U7YpsRyvQ==
X-Received: by 2002:a05:6808:30a4:b0:2da:38a2:5840 with SMTP id bl36-20020a05680830a400b002da38a25840mr12045184oib.86.1647187947460;
        Sun, 13 Mar 2022 09:12:27 -0700 (PDT)
Received: from ?IPV6:2603:8090:2005:39b3::1064? (2603-8090-2005-39b3-0000-0000-0000-1064.res6.spectrum.com. [2603:8090:2005:39b3::1064])
        by smtp.gmail.com with ESMTPSA id m26-20020a05680806da00b002d797266870sm6587764oih.9.2022.03.13.09.12.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Mar 2022 09:12:26 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <18140c6b-bb33-8f3d-b371-fe518d6da47a@lwfinger.net>
Date:   Sun, 13 Mar 2022 11:12:24 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: No support for Realtek 8821CE RFE Type 6
Content-Language: en-US
To:     Stuart Longland <stuartl@longlandclan.id.au>,
        Pkshih <pkshih@realtek.com>, Kalle Valo <kvalo@codeaurora.org>
Cc:     Bogdan Nicolae <bogdan.nicolae@acm.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
References: <CA+ORkNR97EvqPzHu-CoJXwKGH-HQ4B++57RE88MEF-mG=D=Jeg@mail.gmail.com>
 <46a80ab50f594ec1af1016ca272e82fd@realtek.com>
 <CA+ORkNQ_shEZGYQUmRT-_uSp3xkFA2fvfUbyGXzGkP6AmqXf6Q@mail.gmail.com>
 <e57352ddd0644463b398d6dc0a6e6a86@realtek.com>
 <CA+ORkNSzju=Oj4wy8s258exeWOSLEHRAfCoS+ViF-rprdtEr6g@mail.gmail.com>
 <3f5e2f6eac344316b5dd518ebfea2f95@realtek.com>
 <20220313140141.6c736d8a@longlandclan.id.au>
 <20220313152451.692c1508@longlandclan.id.au>
From:   Larry Finger <Larry.Finger@lwfinger.net>
In-Reply-To: <20220313152451.692c1508@longlandclan.id.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 3/12/22 23:24, Stuart Longland wrote:
> On Sun, 13 Mar 2022 14:01:41 +1000
> Stuart Longland <stuartl@longlandclan.id.au> wrote:
> 
>> On Mon, 8 Nov 2021 03:28:07 +0000
>> Pkshih <pkshih@realtek.com> wrote:
>>
>>>>> 2. If you boot this system into Windows 10, does the 8821CE work properly?
>>>>>     If so, please give me its VID/PID of PCI.
> 
>> … now to try that patch.
> 
> The patch as given does not apply, but I managed to hand-fiddle it:
> 
> --- rtw8821c.c.orig     2022-03-13 15:13:34.406747572 +1000
> +++ rtw8821c.c  2022-03-13 15:14:20.292573052 +1000
> @@ -1498,6 +1498,7 @@
>   static const struct rtw_rfe_def rtw8821c_rfe_defs[] = {
>          [0] = RTW_DEF_RFE(8821c, 0, 0),
>          [2] = RTW_DEF_RFE_EXT(8821c, 0, 0, 2),
> +       [6] = RTW_DEF_RFE(8821c, 0, 0),
>   };
>   
>   static struct rtw_hw_reg rtw8821c_dig[] = {
> 
> This indeed fixes the problem:
> http://static.vk4msl.id.au/2022/03/13-rtl8821ce/patched-dmesg.txt
> 
> [    4.166495] rtw_8821ce 0000:03:00.0: enabling device (0000 -> 0003)
> [    4.173911] Loading firmware: rtw88/rtw8821c_fw.bin
> [    4.185625] rtw_8821ce 0000:03:00.0: Firmware version 24.8.0, H2C version 12
> [    4.273629] rtw_8821ce 0000:03:00.0 wlp3s0: renamed from wlan0
> [    7.186954] rtw_8821ce 0000:03:00.0: start vif 0c:cf:89:ac:ac:be on port 0
> [   16.074249] wlp3s0: authenticate with 7a:45:58:c8:b4:33
> [   16.692213] wlp3s0: send auth to 7a:45:58:c8:b4:33 (try 1/3)
> [   16.693038] wlp3s0: authenticated
> [   16.711971] wlp3s0: associate with 7a:45:58:c8:b4:33 (try 1/3)
> [   16.713480] wlp3s0: RX AssocResp from 7a:45:58:c8:b4:33 (capab=0x1111 status=0 aid=15)
> [   16.713526] rtw_8821ce 0000:03:00.0: sta 7a:45:58:c8:b4:33 joined with macid 0
> [   16.713795] wlp3s0: associated
> [   16.832337] IPv6: ADDRCONF(NETDEV_CHANGE): wlp3s0: link becomes ready
> [   17.241966] rtw_8821ce 0000:03:00.0: failed to get tx report from firmware

Stuart,

Yes, that patch has fallen through the cracks. It has been in my repo at 
git://github.com/lwfinger/rtw88.git since Dec. 31, 2021, but is not in 
wireless-drivers-next, and not in the mainline kernel. I have added the 
maintainer for the wireless drivers to this reply, and I will follow up with him.

Larry


I recommend the GitHub repo as it will get such fixes much more quickly.
