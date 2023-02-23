Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB1FE6A0D8F
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Feb 2023 17:07:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234035AbjBWQHi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 23 Feb 2023 11:07:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233437AbjBWQHh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 23 Feb 2023 11:07:37 -0500
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 480674E5E7
        for <linux-wireless@vger.kernel.org>; Thu, 23 Feb 2023 08:07:33 -0800 (PST)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-17264e9b575so6946028fac.9
        for <linux-wireless@vger.kernel.org>; Thu, 23 Feb 2023 08:07:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=IugHgxPx3I6LiYRElPbvTu4212FD7y+QXnyxDhHvRWU=;
        b=QodCGIQXJboell/IAKzoa+k/DWBDeUfYnB4AT1wV5eyfcG1kPJkEjpXqieD0ihZOFE
         V1aycISh0CpKYZi/FyLvdN9XROyy9mGAEzWTCYsWQ+JmZGx8beEnoDlCYzrJYYJHvvOr
         ZzCFjdbecEeNw60OoxqezUNDNfJJdlcAyDe1EkIxgmY+BZs2zWyLLyoJBsG0W0u1JNl3
         FaV1OLqsumx9g+d6IUPbrMQB5upAgyDHGKbQxB5whU6LZwflg2qkL442xG6TGPiBqzQ1
         imJhAIJzTNcULMhGjsoM9cY5jgV15AqTSHpFVe3qeMx4OdxS0wER3yxXWiVz1clGpwzI
         NlBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IugHgxPx3I6LiYRElPbvTu4212FD7y+QXnyxDhHvRWU=;
        b=FmKgDycYvtojbBTLUkUxdDTCjHnKtTF2VkszSidWk3WPv9fx2EbTZ5UQXCs0neABoZ
         8avC00cH1wlaXNnbjlelka7PuPWRdauLtQSMRBQMhlnbGIzGbDEOhUXfaGvK+h7FQurw
         CWViMwafbx1StB7goOzJtPkIgMNz84S4M0QkTw8dsgez/Z84oJyviHOu5rEmhG1kgx7u
         kXbKDUwAS5LfwcC6dlppWtrHRvWP8gVEUZ2snA3l6JknSFM9CUcTsZFFhjAM95BP9TaB
         m6ULGaCHQLw7b8daC6+eGKbuieHDBGxQ7unuTKN4XrrQoR2xtXXAkde/WO5OILC3+MKX
         xPFQ==
X-Gm-Message-State: AO0yUKWKEFs1Gdesen4GODVf7f1DQS0S/zCMElU1E3CQ++I16z4Jg/gV
        AqvnXbz8Ykhnu1YpxkpwaA6AWH+DDGo=
X-Google-Smtp-Source: AK7set8YV3HGkgbDFuQ3d0OWtLFvI8UMHHe2QxEMHkkMmiTUpThw7QMIc6RtYkm1wSAVRP7WZq+h3Q==
X-Received: by 2002:a05:6870:b251:b0:16d:e5d7:d9c1 with SMTP id b17-20020a056870b25100b0016de5d7d9c1mr11293815oam.51.1677168452373;
        Thu, 23 Feb 2023 08:07:32 -0800 (PST)
Received: from [192.168.1.128] ([216.130.59.33])
        by smtp.gmail.com with ESMTPSA id h17-20020a056830035100b0068bd922a244sm2925456ote.20.2023.02.23.08.07.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Feb 2023 08:07:32 -0800 (PST)
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <c4f8074a-3f01-5d4c-864f-a0144eb46d46@lwfinger.net>
Date:   Thu, 23 Feb 2023 10:07:31 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] wifi: wext: Eliminate log spamming in
 wireless_warn_cfg80211_wext()
To:     Johannes Berg <johannes@sipsolutions.net>,
        Kalle Valo <kvalo@kernel.org>
Cc:     linux-wireless@vger.kernel.org
References: <20230222204945.6716-1-Larry.Finger@lwfinger.net>
 <2564165999cf5319e58aa0898a2866612f8af293.camel@sipsolutions.net>
Content-Language: en-US
From:   Larry Finger <Larry.Finger@lwfinger.net>
In-Reply-To: <2564165999cf5319e58aa0898a2866612f8af293.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2/23/23 02:12, Johannes Berg wrote:
> On Wed, 2023-02-22 at 14:49 -0600, Larry Finger wrote:
>> Commit dc09766c755c {"wifi: wireless: warn on most wireless extension
>> usage") introduces a warning when wireless extensions are used with
>> cfg80211 drivers. Although such a warning is desirable, the current
>> implementation overflows the dmesg buffer with thousands of warnings,
>> all of which are the same.
>>
> 
> What are you seeing them from?
> 
> This is rate-limited, so not sure why you're getting so many?
> 
>>   A WARN_ONCE() call is sufficient.
> 
> I think a WARN is inappropriate (it's a userspace 'issue', not an in-
> kernel consistency problem), but I guess we could pr_once().
> 
> But that's not great because it only shows a single application that was
> still using it, not if there are multiple.
> 
> Hmm. Not sure what to do. Let's start with "why are you getting it so
> much". Maybe we can somehow print it less, or try to do per application
> once, or something.

Booting a kernel generated from a wireless-next pull yesterday, my log shows the 
following:

[   22.362531] warning: `kded5' uses wireless extensions that are deprecated for 
modern drivers; use nl80211
[   22.406929] warning: `Qt bearer threa' uses wireless extensions that are 
deprecated for modern drivers; use nl80211
[   22.408054] warning: `Qt bearer threa' uses wireless extensions that are 
deprecated for modern drivers; use nl80211
[   22.953271] Bluetooth: RFCOMM TTY layer initialized
[   22.953284] Bluetooth: RFCOMM socket layer initialized
[   22.953297] Bluetooth: RFCOMM ver 1.11
[   25.015996] wlp4s0: authenticate with 84:1b:5e:f7:6b:02
[   25.019642] wlp4s0: send auth to 84:1b:5e:f7:6b:02 (try 1/3)
[   25.124583] wlp4s0: send auth to 84:1b:5e:f7:6b:02 (try 2/3)
[   25.125135] wlp4s0: authenticated
[   25.125347] wlp4s0: VHT capa missing/short, disabling VHT/HE/EHT
[   25.132592] wlp4s0: associate with 84:1b:5e:f7:6b:02 (try 1/3)
[   25.133570] wlp4s0: RX AssocResp from 84:1b:5e:f7:6b:02 (capab=0x11 status=0 
aid=1)
[   25.135268] wlp4s0: associated
[   26.477742] warning: `akonadi_followu' uses wireless extensions that are 
deprecated for modern drivers; use nl80211
[   26.563342] warning: `Qt bearer threa' uses wireless extensions that are 
deprecated for modern drivers; use nl80211
[   26.564152] warning: `Qt bearer threa' uses wireless extensions that are 
deprecated for modern drivers; use nl80211
[   29.251816] warning: `akonadi_notes_a' uses wireless extensions that are 
deprecated for modern drivers; use nl80211
[   29.319352] warning: `Qt bearer threa' uses wireless extensions that are 
deprecated for modern drivers; use nl80211
[   29.319614] warning: `Qt bearer threa' uses wireless extensions that are 
deprecated for modern drivers; use nl80211
[   29.399084] warning: `akonadi_mailmer' uses wireless extensions that are 
deprecated for modern drivers; use nl80211
[   29.423482] warning: `akonadi_maildis' uses wireless extensions that are 
deprecated for modern drivers; use nl80211
[   29.461984] warning: `akonadi_sendlat' uses wireless extensions that are 
deprecated for modern drivers; use nl80211
[   29.498341] warning: `Qt bearer threa' uses wireless extensions that are 
deprecated for modern drivers; use nl80211
[   29.498974] warning: `Qt bearer threa' uses wireless extensions that are 
deprecated for modern drivers; use nl80211
[   29.539437] warning: `Qt bearer threa' uses wireless extensions that are 
deprecated for modern drivers; use nl80211
[   29.540317] warning: `Qt bearer threa' uses wireless extensions that are 
deprecated for modern drivers; use nl80211
[   37.023881] wireless_warn_cfg80211_wext: 4 callbacks suppressed
[   37.023887] warning: `Qt bearer threa' uses wireless extensions that are 
deprecated for modern drivers; use nl80211
[   37.024151] warning: `Qt bearer threa' uses wireless extensions that are 
deprecated for modern drivers; use nl80211
[   38.739633] wlp4s0: deauthenticating from 84:1b:5e:f7:6b:02 by local choice 
(Reason: 3=DEAUTH_LEAVING)
[   39.020061] warning: `Qt bearer threa' uses wireless extensions that are 
deprecated for modern drivers; use nl80211
[   39.020096] warning: `Qt bearer threa' uses wireless extensions that are 
deprecated for modern drivers; use nl80211
[   39.020279] warning: `Qt bearer threa' uses wireless extensions that are 
deprecated for modern drivers; use nl80211
[   39.020330] warning: `Qt bearer threa' uses wireless extensions that are 
deprecated for modern drivers; use nl80211
[   40.020849] warning: `Qt bearer threa' uses wireless extensions that are 
deprecated for modern drivers; use nl80211
[   40.021068] warning: `Qt bearer threa' uses wireless extensions that are 
deprecated for modern drivers; use nl80211
[   40.024152] warning: `Qt bearer threa' uses wireless extensions that are 
deprecated for modern drivers; use nl80211
[   40.024339] warning: `Qt bearer threa' uses wireless extensions that are 
deprecated for modern drivers; use nl80211
[   47.021033] wireless_warn_cfg80211_wext: 2 callbacks suppressed
[   47.021042] warning: `Qt bearer threa' uses wireless extensions that are 
deprecated for modern drivers; use nl80211
[   47.021529] warning: `Qt bearer threa' uses wireless extensions that are 
deprecated for modern drivers; use nl80211
[   49.021028] warning: `Qt bearer threa' uses wireless extensions that are 
deprecated for modern drivers; use nl80211
[   49.021035] warning: `Qt bearer threa' uses wireless extensions that are 
deprecated for modern drivers; use nl80211
[   49.021183] warning: `Qt bearer threa' uses wireless extensions that are 
deprecated for modern drivers; use nl80211
[   49.021226] warning: `Qt bearer threa' uses wireless extensions that are 
deprecated for modern drivers; use nl80211
[   50.016001] warning: `Qt bearer threa' uses wireless extensions that are 
deprecated for modern drivers; use nl80211
[   50.016748] warning: `Qt bearer threa' uses wireless extensions that are 
deprecated for modern drivers; use nl80211
[   50.025271] warning: `Qt bearer threa' uses wireless extensions that are 
deprecated for modern drivers; use nl80211
[   50.025824] warning: `Qt bearer threa' uses wireless extensions that are 
deprecated for modern drivers; use nl80211
[   54.754126] rtw_8821ce 0000:02:00.0: Firmware version 24.11.0, H2C version 12
[   54.793028] rtw_8821ce 0000:02:00.0 wls1: renamed from wlan0
[   57.017048] wireless_warn_cfg80211_wext: 2 callbacks suppressed
[   57.017051] warning: `Qt bearer threa' uses wireless extensions that are 
deprecated for modern drivers; use nl80211
[   57.017056] warning: `Qt bearer threa' uses wireless extensions that are 
deprecated for modern drivers; use nl80211
[   57.017249] warning: `Qt bearer threa' uses wireless extensions that are 
deprecated for modern drivers; use nl80211
[   57.017253] warning: `Qt bearer threa' uses wireless extensions that are 
deprecated for modern drivers; use nl80211
[   59.017069] warning: `Qt bearer threa' uses wireless extensions that are 
deprecated for modern drivers; use nl80211
[   59.017078] warning: `Qt bearer threa' uses wireless extensions that are 
deprecated for modern drivers; use nl80211
[   59.017394] warning: `Qt bearer threa' uses wireless extensions that are 
deprecated for modern drivers; use nl80211
[   59.017399] warning: `Qt bearer threa' uses wireless extensions that are 
deprecated for modern drivers; use nl80211
[   59.017560] warning: `Qt bearer threa' uses wireless extensions that are 
deprecated for modern drivers; use nl80211
[   59.017568] warning: `Qt bearer threa' uses wireless extensions that are 
deprecated for modern drivers; use nl80211
[   60.202444] wls1: authenticate with 84:1b:5e:f7:6b:02
[   60.740887] wls1: send auth to 84:1b:5e:f7:6b:02 (try 1/3)
[   60.844938] wls1: send auth to 84:1b:5e:f7:6b:02 (try 2/3)
[   60.845879] wls1: authenticated
[   60.846069] wls1: VHT capa missing/short, disabling VHT/HE/EHT
[   60.852850] wls1: associate with 84:1b:5e:f7:6b:02 (try 1/3)
[   60.853804] wls1: RX AssocResp from 84:1b:5e:f7:6b:02 (capab=0x11 status=0 aid=1)
[   60.854594] wls1: associated
[   67.020942] wireless_warn_cfg80211_wext: 14 callbacks suppressed
[   67.020945] warning: `Qt bearer threa' uses wireless extensions that are 
deprecated for modern drivers; use nl80211
[   67.020950] warning: `Qt bearer threa' uses wireless extensions that are 
deprecated for modern drivers; use nl80211
[   67.021136] warning: `Qt bearer threa' uses wireless extensions that are 
deprecated for modern drivers; use nl80211
[   67.021141] warning: `Qt bearer threa' uses wireless extensions that are 
deprecated for modern drivers; use nl80211
[   69.020978] warning: `Qt bearer threa' uses wireless extensions that are 
deprecated for modern drivers; use nl80211
[   69.020985] warning: `Qt bearer threa' uses wireless extensions that are 
deprecated for modern drivers; use nl80211
[   69.020989] warning: `Qt bearer threa' uses wireless extensions that are 
deprecated for modern drivers; use nl80211
[   69.020991] warning: `Qt bearer threa' uses wireless extensions that are 
deprecated for modern drivers; use nl80211
[   69.021244] warning: `Qt bearer threa' uses wireless extensions that are 
deprecated for modern drivers; use nl80211
[   69.021248] warning: `Qt bearer threa' uses wireless extensions that are 
deprecated for modern drivers; use nl80211
[   77.015878] wireless_warn_cfg80211_wext: 14 callbacks suppressed
[   77.015888] warning: `Qt bearer threa' uses wireless extensions that are 
deprecated for modern drivers; use nl80211
[   77.015902] warning: `Qt bearer threa' uses wireless extensions that are 
deprecated for modern drivers; use nl80211
[   77.016408] warning: `Qt bearer threa' uses wireless extensions that are 
deprecated for modern drivers; use nl80211
[   77.016418] warning: `Qt bearer threa' uses wireless extensions that are 
deprecated for modern drivers; use nl80211
[   79.016374] warning: `Qt bearer threa' uses wireless extensions that are 
deprecated for modern drivers; use nl80211
[   79.016388] warning: `Qt bearer threa' uses wireless extensions that are 
deprecated for modern drivers; use nl80211
[   79.016786] warning: `Qt bearer threa' uses wireless extensions that are 
deprecated for modern drivers; use nl80211
[   79.016794] warning: `Qt bearer threa' uses wireless extensions that are 
deprecated for modern drivers; use nl80211
[   79.021806] warning: `Qt bearer threa' uses wireless extensions that are 
deprecated for modern drivers; use nl80211
[   79.021814] warning: `Qt bearer threa' uses wireless extensions that are 
deprecated for modern drivers; use nl80211
[   82.022287] wireless_warn_cfg80211_wext: 10 callbacks suppressed
[   82.022297] warning: `Qt bearer threa' uses wireless extensions that are 
deprecated for modern drivers; use nl80211
[   82.022310] warning: `Qt bearer threa' uses wireless extensions that are 
deprecated for modern drivers; use nl80211
[   82.022818] warning: `Qt bearer threa' uses wireless extensions that are 
deprecated for modern drivers; use nl80211
[   82.022829] warning: `Qt bearer threa' uses wireless extensions that are 
deprecated for modern drivers; use nl80211
[   87.026245] warning: `Qt bearer threa' uses wireless extensions that are 
deprecated for modern drivers; use nl80211
[   87.026262] warning: `Qt bearer threa' uses wireless extensions that are 
deprecated for modern drivers; use nl80211
[   87.026715] warning: `Qt bearer threa' uses wireless extensions that are 
deprecated for modern drivers; use nl80211
[   87.026725] warning: `Qt bearer threa' uses wireless extensions that are 
deprecated for modern drivers; use nl80211
[   89.022467] warning: `Qt bearer threa' uses wireless extensions that are 
deprecated for modern drivers; use nl80211
[   89.022483] warning: `Qt bearer threa' uses wireless extensions that are 
deprecated for modern drivers; use nl80211
[   89.022489] warning: `Qt bearer threa' uses wireless extensions that are 
deprecated for modern drivers; use nl80211
[   89.022527] warning: `Qt bearer threa' uses wireless extensions that are 
deprecated for modern drivers; use nl80211
[   89.022979] warning: `Qt bearer threa' uses wireless extensions that are 
deprecated for modern drivers; use nl80211
[   89.022990] warning: `Qt bearer threa' uses wireless extensions that are 
deprecated for modern drivers; use nl80211

For explanation, device wlp4s0 shows "Network controller [0280]: Intel 
Corporation Wireless 7260 [8086:08b1] (rev 73)" in an 'lspci -nn' listing, and 
wls1 shows "Network controller [0280]: Realtek Semiconductor Co., Ltd. RTL8821CE 
802.11ac PCIe Wireless Network Adapter [10ec:c821]" in the same listing.

There are various tasks/applications that generate this warning early after 
startup, but the ones from `Qt bearer threa' are the ones that persist. Those 
were the only ones that I had seen once the dmesg buffer wrapped around. 
Obviously any kind on "once" restriction would lose information.

In my case, I support devices that need WEXT, thus disabling it in the 
configuration would not work. Logging one per application would entail a bit of 
work, but that would clear up the log spamming and work for me.

Larry




