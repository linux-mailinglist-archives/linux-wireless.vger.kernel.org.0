Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0F3254378D
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Jun 2022 17:36:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244050AbiFHPgP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 8 Jun 2022 11:36:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244387AbiFHPgN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 8 Jun 2022 11:36:13 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E182A344C8
        for <linux-wireless@vger.kernel.org>; Wed,  8 Jun 2022 08:35:59 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id i66so28476705oia.11
        for <linux-wireless@vger.kernel.org>; Wed, 08 Jun 2022 08:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=mUKKS3cJ8iOHXwd2YPNnCnAj+pZPoyTyV0wh010O0fQ=;
        b=LSe7kGcIxQijJtWyI2Kvx6gaNWlLlgcmdIK9vzglRIaQheaPCPuQUwxkfB6IPUxSv0
         Zip44mg36Ta1DBEPWu8aiKJbidquJBkGySF5/U2wVhUKN5iITtR682TX4jiFQT/acX/+
         tDukq1pdzBQPil65LeU9z8UxqtHS6aopWM6B8RolyiXfVGqT/0CHo/DsQ5eOvkdSzgKN
         PO4MrHjWBTKsy7f5Pc0uUFCz+6oRE74fCmnkSzbHSMdKDSRe1dvoflme0wxY9Uy1AjDl
         jh/tG4UaRlZSte4+PuS7j6WUVGwoCva1ZrGR33NghpS2RZTQaVfTQ4ZO/YzUrlaaogDg
         sUNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=mUKKS3cJ8iOHXwd2YPNnCnAj+pZPoyTyV0wh010O0fQ=;
        b=J0Qmc4JB17FCnD1eZY/AK8EVXqxXWycw2jPeIjFpZRPhMksRryJPsG8qdY0jX7tKne
         T/hDWj9GSWO0Wh+fz4ylolCMVcVJ1nFHrYulJ5FZ9N3shS0WsMoolamGsYkXKjpsgQYg
         XK2zub4+cIBB1VIl8JDEbf8sB0+IYfU0n3wLt2/0+y5iXqbMZyXCy1fcPM7g2K9oP0TO
         bpMwNPYLS4IhUKGpLqIk8hkFV1bjlkq7AYqDC7sl8+SjjLgiidxnrAKpihjvo3D+dRIf
         ooc2igzWAdbaa02UB9BPfrLHKQM/EvYOx4kSPQSGLv+eVEKGAbOUEUFmXRsmoO8zNo+z
         76MA==
X-Gm-Message-State: AOAM531pg2FykONQ33ng2KOFanK7qAZaRwEoFAHfPEBffYdw+HLMas0k
        7AwzNDqCLo7YcoaGQ0Olq8g=
X-Google-Smtp-Source: ABdhPJyQZh9RBvJ00oc0oCXPX0WqIrN//ZaQqgyBq6DV23jWNr2vFGwMfRZNi0bgeW/70/IXRNncRQ==
X-Received: by 2002:a05:6808:2382:b0:32e:bf4e:fa93 with SMTP id bp2-20020a056808238200b0032ebf4efa93mr2633135oib.33.1654702558994;
        Wed, 08 Jun 2022 08:35:58 -0700 (PDT)
Received: from ?IPV6:2603:8090:2005:39b3::100e? (2603-8090-2005-39b3-0000-0000-0000-100e.res6.spectrum.com. [2603:8090:2005:39b3::100e])
        by smtp.gmail.com with ESMTPSA id hc12-20020a056870788c00b000f33804cea9sm9428315oab.36.2022.06.08.08.35.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jun 2022 08:35:58 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <d705a771-90a6-98c7-b1dc-32fba1136678@lwfinger.net>
Date:   Wed, 8 Jun 2022 10:35:56 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] rtw88: 8821c: fix access const table of channel
 parameters
Content-Language: en-US
To:     Nathan Chancellor <nathan@kernel.org>,
        Ping-Ke Shih <pkshih@realtek.com>
Cc:     tony0620emma@gmail.com, kvalo@kernel.org,
        linux-wireless@vger.kernel.org
References: <20220608020312.9663-1-pkshih@realtek.com>
 <YqAQTJqOTB2+242p@dev-arch.thelio-3990X>
From:   Larry Finger <Larry.Finger@lwfinger.net>
In-Reply-To: <YqAQTJqOTB2+242p@dev-arch.thelio-3990X>
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

On 6/7/22 21:58, Nathan Chancellor wrote:
> On Wed, Jun 08, 2022 at 10:03:12AM +0800, Ping-Ke Shih wrote:
>> We would like to make chip_info table const, but 8821c uses one field as
>> a variable, and causes core dump. To fix this, move the field to another
>> struct that can be read and written.
>>
>> BUG: unable to handle page fault for address: ffffffffc09f52f4
>> PGD 5b5215067 P4D 5b5215067 PUD 5b5217067 PMD 111f61067 PTE 8000000111e07161
>> Oops: 0003 [#1] PREEMPT SMP NOPTI
>> CPU: 6 PID: 436 Comm: NetworkManager Not tainted 5.18.0-rc7-debug-01822-g89d8f53ff6e7 #1 5cac31ca93432e53341863abfb3332fd98b144da
>> Hardware name: HP HP Desktop M01-F1xxx/87D6, BIOS F.12 12/17/2020
>> RIP: 0010:rtw8821c_phy_set_param+0x262/0x380 [rtw88_8821c]
>> Code: e8 53 f3 c0 d6 48 8b 43 10 4c 8b 63 38 be 24 0a 00 00 48 89 df 48
>>   8b 40 68 e8 3a f3 c0 d6 89 e9 be 28 0a 00 00 48 89 df d3 e8 <41> 89 84
>>   24 54 01 00 00 48 8b 43 10 4c 8b 63 38 48 8b 40 68 e8 15
>> RSP: 0018:ffffb08c417cb6f0 EFLAGS: 00010286
>> RAX: 0000000064b80c1c RBX: ffff93d15a0120e0 RCX: 0000000000000000
>> RDX: 0000000034028211 RSI: 0000000000000a28 RDI: ffff93d15a0120e0
>> RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
>> R10: 0000000000000001 R11: 0000000000000006 R12: ffffffffc09f51a0
>> R13: ffff93d15a0156d0 R14: 0000000000000000 R15: 0000000000000001
>> FS:  00007f4e9b73d1c0(0000) GS:ffff93d83ab80000(0000) knlGS:0000000000000000
>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> CR2: ffffffffc09f52f4 CR3: 0000000103b9e000 CR4: 0000000000350ee0
>> Call Trace:
>>   <TASK>
>>   rtw_core_start+0xbd/0x190 [rtw88_core de79d6bdfd083d102030858972032e5706726279]
>>   rtw_ops_start+0x26/0x40 [rtw88_core de79d6bdfd083d102030858972032e5706726279]
>>   drv_start+0x42/0x100 [mac80211 21e803d0ad10691f64c6c81ecc24c0c6c36e5d58]
>>   ieee80211_do_open+0x2fb/0x900 [mac80211 21e803d0ad10691f64c6c81ecc24c0c6c36e5d58]
>>   ieee80211_open+0x67/0x80 [mac80211 21e803d0ad10691f64c6c81ecc24c0c6c36e5d58]
>>   __dev_open+0xdd/0x180
>>   [...]
>>
>> Fixes: 89d8f53ff6e7 ("wifi: rtw88: Fix Sparse warning for rtw8821c_hw_spec")
>> Reported-by: Nathan Chancellor <nathan@kernel.org>
>> Cc: Larry Finger <Larry.Finger@lwfinger.net>
>> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
> 
> I don't actually use wireless on this machine but my boot finishes and I
> don't see any crash:
> 
> Tested-by: Nathan Chancellor <nathan@kernel.org>

Nathan,

Thanks for testing. As you have likely seen, Ping-Ke came up with a better fix, 
thus mine will not be needed.

Larry


