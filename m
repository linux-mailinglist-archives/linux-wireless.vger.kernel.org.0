Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78185597879
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Aug 2022 23:00:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241493AbiHQUyz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 17 Aug 2022 16:54:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241532AbiHQUyt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 17 Aug 2022 16:54:49 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A412BA6C48
        for <linux-wireless@vger.kernel.org>; Wed, 17 Aug 2022 13:54:44 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id r4so19001292edi.8
        for <linux-wireless@vger.kernel.org>; Wed, 17 Aug 2022 13:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc;
        bh=2fdBb826NfBb66pZFWpn0a/qxInEwJkMzAUTuOVUxrI=;
        b=V9AutVVXU41U5pW29LnjmdtbopLsGKVHV6QQPAg48JQQ+X225VDCf1Cz+iWD/J8Keu
         QlWbgcZJGR1yrXsQlZprOVcU8EC7mN4fYQEcqIYdAK8a3rUhjPtCGdeo6SnKzwLhHdMY
         PkCKAbnz4DVkGW7/JGIGZ5UnmMwvZAuaTHffu+brTRCGLmG9Lcs5NcHibbQyivUPNoPP
         qjNarxCqKAa7wxBpvdUprBeP4BgdbSa1QAvrowc0T4Ttu6Mek/HJ6YwCGEehn32CYdMU
         h4puA5yyXHk0nCNmTp8F14cAZFtG5ApHub8tLlYMr6R2kggRjGQoRJNBfLe9qdz/VakX
         wzrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=2fdBb826NfBb66pZFWpn0a/qxInEwJkMzAUTuOVUxrI=;
        b=G5PmUNoIhlQ4djjV6QahBsaLqLMdyJPW8QdT7oENmxLm7hM75zp+IvVSn+BaxeJddA
         w6Y5oJpHMUf/gIZQnrfhS45JBAm2kVyLBSJuCCIXSpNUv89rtsomad/Wvb9CsDWfDUPY
         /2I8FYqA5IInaj7pByckbiZbDsJIjDNkEfqJpRjdh0ZJ8GsaeCmpTkaBdi6jTpoBZAbH
         +WXf5HxgBq/SPYGd/LAceA3LMKqEa5XYb3C39cXz7N7lz1ddX4epHEV0NJPuTcygc4S0
         eNS4FzoRWniXmTfzDgo7dD9n1bVd2pGp/OHe8a1VB4yhrTNQfA03OAk3Wt3U2zrCjPTv
         jtTQ==
X-Gm-Message-State: ACgBeo3BfJ4oiOrt5ZzVYmPzIo9LltvBCjTOeaKdtY9EMNTZNLMA3YFM
        MfRRf2TE77lhK3RIH557JQ==
X-Google-Smtp-Source: AA6agR4v+PijnFweYvMKtPYy6Jx6NTY8wvOGtd9XXvPAk+uVcFdtuGX48xgmPV3OyaToAXA9wkefbw==
X-Received: by 2002:a05:6402:50cc:b0:43e:6860:58fc with SMTP id h12-20020a05640250cc00b0043e686058fcmr24260981edb.243.1660769683167;
        Wed, 17 Aug 2022 13:54:43 -0700 (PDT)
Received: from [192.168.25.160] (ip-176-198-174-045.um43.pools.vodafone-ip.de. [176.198.174.45])
        by smtp.googlemail.com with ESMTPSA id k18-20020aa7c052000000b0043bbbaa323dsm11395537edo.0.2022.08.17.13.54.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Aug 2022 13:54:38 -0700 (PDT)
Message-ID: <3e916f23-66f3-61af-de95-8ea34d4fb696@googlemail.com>
Date:   Wed, 17 Aug 2022 22:52:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: rtw88: "timed out to flush queue 1"
To:     Ping-Ke Shih <pkshih@realtek.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
References: <6415466b-f745-df14-2a0b-40861bd1ea10@googlemail.com>
 <004699d134ee41aeb2ed0e31c2517b76@realtek.com>
Content-Language: de-DE
From:   =?UTF-8?Q?Frank_Sch=c3=a4fer?= <fschaefer.oss@googlemail.com>
In-Reply-To: <004699d134ee41aeb2ed0e31c2517b76@realtek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Am 17.08.22 um 10:47 schrieb Ping-Ke Shih:
> Hi
>
>> -----Original Message-----
>> From: Frank Schäfer <fschaefer.oss@googlemail.com>
>> Sent: Wednesday, August 17, 2022 4:18 AM
>> To: Ping-Ke Shih <pkshih@realtek.com>; linux-wireless@vger.kernel.org
>> Subject: rtw88: "timed out to flush queue 1"
>>
>> I tried wireless-testing today to see if the recent rtw88 patches are
>> fixing the problems I'm facing with my rtw8821ce device.
>> The device now associates much faster and the tons of "failed to get tx
>> report from firmware" messages are gone.
>> However, the device disconnects very often and the log shows lots of
>>
>> [   20.900786] rtw_8821ce 0000:02:00.0: timed out to flush queue 1
>>
>> messages, which is new.
>>
>>
>> A typical section from the dmesg output:
>> ...
>> [   13.099028] wlo1: authenticate with f8:d1:11:xx:xx:xx
>> [   13.128833] wlo1: Allocated STA f8:d1:11:xx:xx:xx
>> [   13.128846] wlo1: HE not supported, disabling HE and EHT
>> [   13.128848] wlo1: EHT not supported, disabling EHT
>> [   13.128849] wlo1: bad VHT capabilities, disabling VHT
>> [   13.128852] wlo1: VHT operation missing / VHT not supported
>> [   13.634812] wlo1: Inserted STA f8:d1:11:xx:xx:xx
>> [   13.772803] wlo1: send auth to f8:d1:11:xx:xx:xx (try 1/3)
>> [   13.775493] wlo1: authenticated
>> [   13.775501] wlo1: moving STA f8:d1:11:xx:xx:xx to state 2
>> [   13.775676] rtw_8821ce 0000:02:00.0 wlo1: disabling HT/VHT/HE as
>> WMM/QoS is not supported by the AP
>> [   13.812815] wlo1: HE not supported, disabling HE and EHT
>> [   13.812822] wlo1: EHT not supported, disabling EHT
>> [   13.812826] wlo1: HT operation missing / HT not supported
> Does your AP support HT or VHT?
> Can you change another AP that support VHT?

The AP is a 802.11n device with 2.4 GHz only.
Looks like a good test case. ;)

I can't test anything else for the next 2 1/2 weeks. :/
I'm on vacations here.


>
>> [   14.318955] wlo1: associate with f8:d1:11:xx:xx:xx (try 1/3)
>> [   14.561324] wlo1: associate with f8:d1:11:xx:xx:xx (try 2/3)
>> [   14.571012] wlo1: RX AssocResp from f8:d1:11:xx:xx:xx (capab=0x431
>> status=0 aid=1)
>> [   14.571052] wlo1: moving STA f8:d1:11:xx:xx:xx to state 3
>> [   14.571208] wlo1: associated
>> [   14.649252] IPv6: ADDRCONF(NETDEV_CHANGE): wlo1: link becomes ready
>> [   14.649610] wlo1: moving STA f8:d1:11:xx:xx:xx to state 4
>> [   20.900786] rtw_8821ce 0000:02:00.0: timed out to flush queue 1
>> [   21.392784] rtw_8821ce 0000:02:00.0: timed out to flush queue 1
>> [   21.904779] rtw_8821ce 0000:02:00.0: timed out to flush queue 1
>> [   22.044770] rtw_8821ce 0000:02:00.0: timed out to flush queue 1
>> [   23.312776] rtw_8821ce 0000:02:00.0: timed out to flush queue 1
>> [   25.444803] rtw_8821ce 0000:02:00.0: timed out to flush queue 1
>> [   25.960816] rtw_8821ce 0000:02:00.0: timed out to flush queue 1
>> [   27.249290] wlo1: cancelling AP probe due to a received beacon
>> [   31.168781] rtw_8821ce 0000:02:00.0: timed out to flush queue 1
>> [   31.604945] rtw_8821ce 0000:02:00.0: timed out to flush queue 1
>> [   32.572767] rtw_8821ce 0000:02:00.0: timed out to flush queue 1
>> [   33.832856] rtw_8821ce 0000:02:00.0: timed out to flush queue 1
>> [   36.461025] rtw_8821ce 0000:02:00.0: timed out to flush queue 1
>> [   37.405071] rtw_8821ce 0000:02:00.0: timed out to flush queue 1
>> [   37.889031] rtw_8821ce 0000:02:00.0: timed out to flush queue 1
>> [   39.641417] wlo1: cancelling AP probe due to a received beacon
>> [   49.293315] wlo1: cancelling AP probe due to a received beacon
>> [   58.861319] wlo1: cancelling AP probe due to a received beacon
>> [   68.669330] wlo1: cancelling AP probe due to a received beacon
>> [   78.205321] wlo1: cancelling AP probe due to a received beacon
>> [   80.793042] wlo1: detected beacon loss from AP (missed 7 beacons) -
>> probing
>> [   80.824424] wlo1: No ack for nullfunc frame to AP f8:d1:11:xx:xx:xx,
>> try 1/2
>> [   80.851851] wlo1: No ack for nullfunc frame to AP f8:d1:11:xx:xx:xx,
>> disconnecting.
>> [   80.889060] wlo1: moving STA f8:d1:11:xx:xx:xx to state 3
>> [   80.905202] wlo1: moving STA f8:d1:11:xx:xx:xx to state 2
>> [   80.905230] wlo1: moving STA f8:d1:11:xx:xx:xx to state 1
>> [   80.905233] wlo1: Removed STA f8:d1:11:xx:xx:xx
>> [   80.905338] wlo1: Destroyed STA f8:d1:11:xx:xx:xx
>> ...
>>
>> FW version is 24.11.0.
>> I tried with and without disable_lps_deep / disable_aspm, but that makes
>> no difference.
>>
>> Any ideas ? Anything I can do ?
>>
> It seems like link quality isn't good. Please turn off power saving
> by 'iw wlo1 set power_save off' to see if it can help.
> And, use 'iw wlo1 station dump' to check link quality.
> If 'signal:' is lower than -60, it will be bad.

Turning power saving off has no effect.

Signal level is -60dBm (+-2dBm).
Not that strong, but shouldn't that be enough for a stable connection ?

Frank

>
> Ping-Ke
>

