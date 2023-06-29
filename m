Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5FF27424FC
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Jun 2023 13:31:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231281AbjF2Lb4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 29 Jun 2023 07:31:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbjF2Lby (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 29 Jun 2023 07:31:54 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F9FE132
        for <linux-wireless@vger.kernel.org>; Thu, 29 Jun 2023 04:31:52 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1qEpsK-00043U-Nd; Thu, 29 Jun 2023 13:31:48 +0200
Message-ID: <3270268e-c926-01e6-65e1-02aa6abfd0db@leemhuis.info>
Date:   Thu, 29 Jun 2023 13:31:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: iwlwifi: AX201 misdetected as AX101
Content-Language: en-US, de-DE
To:     =?UTF-8?Q?Barnab=c3=a1s_P=c5=91cze?= <pobrn@protonmail.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Gregory Greenman <gregory.greenman@intel.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>
References: <gAwMzXEPlQZUgbc6n3yYY2soROKl4-D_JfWwoHW8CMx-LDkDEeAlwcyjOMy767W3eEVxS-e7oEihVh1PNHT-_iznSKneJjW0vu0PN7aQ9K8=@protonmail.com>
 <FFsiCdZPcJ2FItvpkX6E-0LT-gc1m-7JdRKTZ0NB9s7AmhtFt09wmR8fItdeT5xaYybsKsC_cjXuh5i_V97rgq4fJgKOmBmKytjCwSKlnAU=@protonmail.com>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
Cc:     Linux kernel regressions list <regressions@lists.linux.dev>
In-Reply-To: <FFsiCdZPcJ2FItvpkX6E-0LT-gc1m-7JdRKTZ0NB9s7AmhtFt09wmR8fItdeT5xaYybsKsC_cjXuh5i_V97rgq4fJgKOmBmKytjCwSKlnAU=@protonmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1688038312;bafaf617;
X-HE-SMSGID: 1qEpsK-00043U-Nd
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

[CCing the regression list, as it should be in the loop for regressions:
https://docs.kernel.org/admin-guide/reporting-regressions.html]

On 27.06.23 23:55, Barnabás Pőcze wrote:
> 
> 2023. május 26., péntek 19:55 keltezéssel, Barnabás Pőcze <pobrn@protonmail.com> írta:
>>
>> I have an Acer Aspire A315-58 laptop[0], which, according to lspci has the following intel wireless chip:
>>
>>    Device:	00:14.3
>>     Class:	Network controller [0280]
>>    Vendor:	Intel Corporation [8086]
>>    Device:	Wi-Fi 6 AX201 [a0f0]
>>   SVendor:	Intel Corporation [8086]
>>   SDevice:	Wi-Fi 6 AX201 [0244]
>>       Rev:	20
>>    ProgIf:	00
>>    Driver:	iwlwifi
>>    Module:	iwlwifi
>>
>> However, in the kernel message buffer, the following message is written:
>>
>>   [    3.633490] iwlwifi 0000:00:14.3: Detected Intel(R) Wi-Fi 6 AX101, REV=0x351
> [...]
> 
> For the record, I have done a git-bisect[1], and that turned up
> 
>   d2ccc5c1526396aef5196e4dd2ec8538994e5072
>   wifi: iwlwifi: Update init sequence if tx diversity supported
> 
> as the first good commit[0].
> 
> Sadly, that patch (or even the series) does not appear to be easily backportable,
> so it seems likely that current stable kernels won't be able to support this device.

Thx for bisecting.

Thing is: 6.3 will be EOL in about two or three weeks anyway. And Arch
will likely switch to 6.4 (which works -- or did I get this wrong?)
within a week or two. Makes be wonder if it's the best solution for
everyone involved to not resolve this and move on.

Ciao, Thorsten

> [0]: https://lore.kernel.org/all/20230413102635.c2121c8694a7.Ibee3dd8765ef4b7504660fa228a7c7eff78920af@changeid/
> [1]:
>   git bisect start
>   # status: waiting for both good and bad commits
>   # new: [b6dad5178ceaf23f369c3711062ce1f2afc33644] Merge tag 'nios2_fix_v6.4' of git://git.kernel.org/pub/scm/linux/kernel/git/dinguyen/linux
>   git bisect new b6dad5178ceaf23f369c3711062ce1f2afc33644
>   # status: waiting for good commit(s), bad commit known
>   # old: [457391b0380335d5e9a5babdec90ac53928b23b4] Linux 6.3
>   git bisect old 457391b0380335d5e9a5babdec90ac53928b23b4
>   # new: [6e98b09da931a00bf4e0477d0fa52748bf28fcce] Merge tag 'net-next-6.4' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next
>   git bisect new 6e98b09da931a00bf4e0477d0fa52748bf28fcce
>   # old: [088e0c188513b58a0056a488cf5b7df094a8a48a] Merge tag 'platform-drivers-x86-v6.4-1' of git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86
>   git bisect old 088e0c188513b58a0056a488cf5b7df094a8a48a
>   # new: [ca288965801572fe41386560d4e6c5cc0e5cc56d] Merge tag 'wireless-next-2023-04-21' of git://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next
>   git bisect new ca288965801572fe41386560d4e6c5cc0e5cc56d
>   # old: [d56417ad1133fc41752bb9fe37da7ae3187395a4] net: phy: smsc: clear edpd_enable if interrupt mode is used
>   git bisect old d56417ad1133fc41752bb9fe37da7ae3187395a4
>   # old: [c54876cd5961ce0f8e74807f79a6739cd6b35ddf] net/sched: pass netlink extack to mqprio and taprio offload
>   git bisect old c54876cd5961ce0f8e74807f79a6739cd6b35ddf
>   # new: [3288ee5844b74cebb94ed15bc9b5b9d3223ae038] Merge ath-next from git://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git
>   git bisect new 3288ee5844b74cebb94ed15bc9b5b9d3223ae038
>   # new: [d0b6f86fdbefa62fd4ad2acd1aea6c45f9b518ba] wifi: mt76: mt7996: let non-bufferable MMPDUs use correct hw queue
>   git bisect new d0b6f86fdbefa62fd4ad2acd1aea6c45f9b518ba
>   # new: [a0e97ae3f3320a246a79db7372fc23a38556014e] wifi: rtw89: add ieee80211::remain_on_channel ops
>   git bisect new a0e97ae3f3320a246a79db7372fc23a38556014e
>   # new: [d00800a289c9349bb659a698cbd7bc04521dc927] wifi: mac80211: add flush_sta method
>   git bisect new d00800a289c9349bb659a698cbd7bc04521dc927
>   # old: [413be839bfca9a4f6b32b92807ecdc2c2c182d94] wifi: iwlwifi: add a validity check of queue_id in iwl_txq_reclaim
>   git bisect old 413be839bfca9a4f6b32b92807ecdc2c2c182d94
>   # old: [e305a408c5f9c8df06a58e09a23375fd257f081c] wifi: iwlwifi: mvm: move function sequence
>   git bisect old e305a408c5f9c8df06a58e09a23375fd257f081c
>   # new: [217f3c52f00d3419ecdd38a99a7eceecb11679b2] wifi: iwlwifi: mvm: don't set CHECKSUM_COMPLETE for unsupported protocols
>   git bisect new 217f3c52f00d3419ecdd38a99a7eceecb11679b2
>   # new: [5caa82529eabff044c5f3eb254f3a7ff00e9170d] wifi: iwlwifi: Update configurations for Bnj-a0 and specific rf devices
>   git bisect new 5caa82529eabff044c5f3eb254f3a7ff00e9170d
>   # new: [d2ccc5c1526396aef5196e4dd2ec8538994e5072] wifi: iwlwifi: Update init sequence if tx diversity supported
>   git bisect new d2ccc5c1526396aef5196e4dd2ec8538994e5072
>   # first new commit: [d2ccc5c1526396aef5196e4dd2ec8538994e5072] wifi: iwlwifi: Update init sequence if tx diversity supported
> 
> 
>>
>> I then noticed that firmwares 75-77 are available and that there were recent changes
>> to the iwlwifi module that increased IWL_22000_UCODE_API_MAX, so I gave it a go,
>> and built the kernel at ae8373a5add4ea39f032563cf12a02946d1e3546 and now firmware 77
>> is loaded, and that seems to work, at least I did not notice any issues so far.
>>
>> The full logs and other information about the laptop can be found here[0].
>>
>>
>> Regards,
>> Barnabás Pőcze
>>
>>
>> [0]: https://linux-hardware.org/?probe=43069955ee
