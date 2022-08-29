Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFF475A4336
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Aug 2022 08:27:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbiH2G10 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 29 Aug 2022 02:27:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiH2G1Y (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 29 Aug 2022 02:27:24 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79C564B0EB
        for <linux-wireless@vger.kernel.org>; Sun, 28 Aug 2022 23:27:23 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id m5so9786727lfj.4
        for <linux-wireless@vger.kernel.org>; Sun, 28 Aug 2022 23:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=VWWhzQYOJYmKYEvMvpj/k5/jRSFeG6RXp63LJ7w0hVM=;
        b=DlZwyqvMPjn9q7RTFNFefRdHJ9N1DCgo/6UbbUjWQxxbnWQKNgSvZhipTxbA8we+0K
         RZ4AwvnHqscE70w232igZ8cnwA94cu5RxOcccvuAA5B7DNdX6TrD2Bv3V8qqh6fiKgWd
         18qc65FXANU8UWpb1uOnUG3FydNR5kZgqtBkYRFW8eW6Yg4AqScvITQm+ojjtebisaPX
         uAKVNCMSF/Wg4DKn8JC7rzx1aq5YVFiYKjsijxm1DiW1HkGMX6UXSmeNkee4A8JwT/AK
         Yq3wV83dwmGN98Z3uScKEKZYmpQziit74H+XMaFuNDnyuRzhHCGMwTIi/KCohYPTXHgG
         ovaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=VWWhzQYOJYmKYEvMvpj/k5/jRSFeG6RXp63LJ7w0hVM=;
        b=HSI63u5xg54fDBuisYVDMNDyRrjODfEspXP2HGdspxwXt9afbN1M2ZwCBOrynvX449
         sFTUSfscPE7u1RIuL4JtJt3AsLP7XDUVVreFm/OuGOAEj5BBs4200W4qVudtURkaJSfi
         qaOxvNL9BqkBcoFYXxI4CJJVMr4Z1UnWNv7NBWAlkCfu/q7ixQeHAoJlnFQZLkYTg2w6
         TfSrZAQu3QyEw8zKyaS9bJlFycCJYmLFiBQXjWlINLOGMlXTnVht/4gwo+fSHWpARrTy
         GQ+ylUyMGDK57xZECpfDlYxfJQcYisqldShPDUgDHE3ejfe0AgN4UXvsnaGvIWqG54xo
         1XBQ==
X-Gm-Message-State: ACgBeo3fr+9zqaTdhcjU8K+aSvpLnKRR/tQKWCp+oNBlhidr8KE/Psp5
        uubIVjU+UqYOiwtV9CMz5hktd31RQ6N5Nw==
X-Google-Smtp-Source: AA6agR5HLmedpY/e6Gf+gxzMrQlhbF+vYFGB2BUkcCn9huWXNlu5gZbEdeW1PVWwUNXUGh/5HhP+HA==
X-Received: by 2002:a05:6512:ad4:b0:492:c013:2359 with SMTP id n20-20020a0565120ad400b00492c0132359mr6478787lfu.376.1661754441779;
        Sun, 28 Aug 2022 23:27:21 -0700 (PDT)
Received: from [192.168.8.100] ([176.59.56.247])
        by smtp.gmail.com with ESMTPSA id q15-20020ac25fcf000000b0048b03ec561fsm1160940lfg.150.2022.08.28.23.27.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Aug 2022 23:27:21 -0700 (PDT)
Message-ID: <b4b5a72e-4ad2-e249-c71c-c64cf5902a66@gmail.com>
Date:   Mon, 29 Aug 2022 09:27:19 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH 0/4] ath11k: Enable low power mode when WLAN is not active
To:     Manikanta Pubbisetty <quic_mpubbise@quicinc.com>,
        "Limonciello, Mario" <mario.limonciello@amd.com>,
        ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
References: <20220720134959.15688-1-quic_mpubbise@quicinc.com>
 <ad99d238-dc1a-3233-fc6b-0cd49e428903@amd.com>
 <6daefd60-dcbc-06e1-8091-ea225690edf8@amd.com>
 <ecce8764-1760-4617-49aa-c111305ebd55@quicinc.com>
 <7e00cc36-3a07-92e2-c60e-a3c8939b407e@amd.com>
 <ccdb8f94-0879-2c06-5b48-25c2340d1659@gmail.com>
 <7df6efae-0797-a27a-1372-db7ad16e71d2@quicinc.com>
Content-Language: en-US
From:   Mark Herbert <mark.herbert42@gmail.com>
In-Reply-To: <7df6efae-0797-a27a-1372-db7ad16e71d2@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


On 8/29/22 08:30, Manikanta Pubbisetty wrote:
> On 8/26/2022 2:31 AM, Mark Herbert wrote:
>>>
>>>> The changes that I have posted will not work on other targets like 
>>>> WCN6855 as is. It requires additional changes and therefore lots of 
>>>> testing.
>>>
>>
>> Will the changes be possible for QCA6390 as well?  Currently this 
>> chip only activates power saving mode when it is connected, but 
>> behaves badly when not associated to any network. So there is a 
>> chance that this kind of solution will help.
>>
>
> Not associated to any network as in Wi-Fi is ON and not connected or 
> Wi-Fi is off?
>
> Manikanta

The way it works now.

I boot my laptop (it is Dell XPS 13 9310). If the network is available 
and QCA6390 associates with it - the CPU package  goes for PC10 state 
for about 70% of time on idle. Even if I disconnect now it will be still 
good.

But if I boot my laptop and never connect (associate to any WiFi ) - the 
CPU will never reach below PC3 with WiFi on. If I disable WiFi - it 
reaches PC10, if enable back - again PC3.


The point is QCA6390 need to be associated to network after boot (or 
hibernation resume) before it activates powersave mode. If this very 
first associatiion is not happening - it will eat battery as mad.

For now I've workarounded it by setting a systemd timer service to check 
if the WiFi is not  associated for f 3 minutes and if it is not - switch 
wifi off.

But it is very strange why this first association is mandatory, because 
if this forst association after boot happened - QCA6390 behaves 
perfectly with WiFi on but not asociated. And continue to work perfectly 
until hardware restart (reboot or hibernate resume) - then again first 
association is needed.  I was thinking that it is happening because the 
ath11k_mac_vif_setup_ps is called only after the association so I've 
tested the patch to call it earlier, and still no luck.

