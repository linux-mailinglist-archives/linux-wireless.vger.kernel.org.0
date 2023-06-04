Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AB9A72164C
	for <lists+linux-wireless@lfdr.de>; Sun,  4 Jun 2023 13:11:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230051AbjFDLLt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 4 Jun 2023 07:11:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231287AbjFDLLs (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 4 Jun 2023 07:11:48 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 102E5F4
        for <linux-wireless@vger.kernel.org>; Sun,  4 Jun 2023 04:11:44 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-5149c76f4dbso5809831a12.1
        for <linux-wireless@vger.kernel.org>; Sun, 04 Jun 2023 04:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685877102; x=1688469102;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bXNYTn2qKqkOWT7uNJQHLgNgA9/Sl0lMil5N8h1lz0g=;
        b=iSrsnmaz4hhljlA+Em+VdM1JRP6SJ0in6TlCt2FiBQDnfkzk2lw0MdSXwwMZM5acDm
         dcycSKB1DzxXCNrQS8WwrH000/Hwk8496G898WqHbfHCcdwIxcKxk2Jr64L6yuKVuzVc
         gqivdtWwTsvPt84wJoXBglw/olz62FcNs6IQh0hTEC5nicnzFcKnLwIYpuKj9IOxS20u
         g7PC+WskBIMPBFfp3FJ4ksnOw0exUqQEp6nOBYECBEGvMUiHhnT4dx7XqK+PLdvAfP3M
         osTXI++GVjXTB2X0zGPEeo7lnVnqLo4QdfkSszq/QHFNN48sbhSHuvf9bKr0UIIzeCYt
         g9lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685877102; x=1688469102;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bXNYTn2qKqkOWT7uNJQHLgNgA9/Sl0lMil5N8h1lz0g=;
        b=L5ZsWaLISVR538VXW0c4vM5Q7sfPGmnXItfgSidhKqVRn5rP0qJ5s/OD9et6BikDt7
         Uo3w2ZuVJ8cnqoj4qFs2EFZgSdhcWb/T5LoGPIlt3VIDDYsNmbrbkfWpb8b1ldiO6Ma/
         Rne6P2a3HdMdrfZCcV+Cup5NX6mvCfXgiLigFHeWWd3TUkQPklFV3nHdkAbju8h6ZgBm
         GCN2jK+ZKnUyFEsqDenvJ1VawmJ5sO5OT7cuPzoQpzfAYQi5vpNwEW4lVW6lOfCjxfDL
         gcH8QDVHGphdLtjuJ5brX49RTIABPNQCNmd/4oYQ1KrHpbj4TrTRRCjzIjVvUj3CpLxO
         89eQ==
X-Gm-Message-State: AC+VfDwSfXYBSd0Ga0zSIeUd1+YASuctG8LiCVwXxsYy3ByfNtL7bJlg
        owuKktX9wT5ESTg7DxqDppxC4sl3QgX78A==
X-Google-Smtp-Source: ACHHUZ5+1Kitdyh4bDWab+rIspQ8gWAbIla2QTUJgvmMlN74ZvKzPCfGDcGiErxbbRAkZBnF3BygSQ==
X-Received: by 2002:aa7:d8d5:0:b0:510:d6b3:a1c2 with SMTP id k21-20020aa7d8d5000000b00510d6b3a1c2mr5294039eds.27.1685877102254;
        Sun, 04 Jun 2023 04:11:42 -0700 (PDT)
Received: from shift.daheim (p4fd09d7d.dip0.t-ipconnect.de. [79.208.157.125])
        by smtp.gmail.com with ESMTPSA id z15-20020aa7d40f000000b00514b2a9ce60sm2660693edq.81.2023.06.04.04.11.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jun 2023 04:11:41 -0700 (PDT)
Received: from localhost ([127.0.0.1])
        by shift.daheim with esmtp (Exim 4.96)
        (envelope-from <chunkeey@gmail.com>)
        id 1q5le9-000Yek-0V;
        Sun, 04 Jun 2023 13:11:41 +0200
Message-ID: <582d6f32-23f8-6175-19da-f0b4c97393f5@gmail.com>
Date:   Sun, 4 Jun 2023 13:11:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] wifi: ath: add struct_group for struct ath_cycle_counters
To:     linux-wireless@vger.kernel.org
Cc:     ansuelsmth@gmail.com, jirislaby@kernel.org, kvalo@kernel.org,
        mcgrof@kernel.org, mickflemm@gmail.com, robimarko@gmail.com,
        toke@toke.dk, yangshiji66@qq.com,
        Shiji Yang <yangshiji66@outlook.com>
References: <TYAP286MB0315EC437BF53C8DB2B5D022BC4EA@TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM>
 <TYAP286MB0315FA0080ABAE79CC842899BC4CA@TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM>
Content-Language: de-DE
From:   Christian Lamparter <chunkeey@gmail.com>
In-Reply-To: <TYAP286MB0315FA0080ABAE79CC842899BC4CA@TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 6/4/23 03:48, Shiji Yang wrote:
> Thank you all,
> This patch may not look so beautiful, but its main purpose is to raise
> some awareness about this strange compilation warning.
> 
> This problem only occurs in mips gcc 12.3 (maybe only on arc mips/ath79).

It also occures with PPC464/APM82181. Could it be that that it occurs on
"big-endian" archs?


> In:
> 
>> --- a/drivers/net/wireless/ath/ath9k/main.c
>> +++ b/drivers/net/wireless/ath/ath9k/main.c
>> @@ -135,8 +135,8 @@ void ath9k_ps_wakeup(struct ath_softc *sc)
>> 	if (power_mode != ATH9K_PM_AWAKE) {
>> 		spin_lock(&common->cc_lock);
>> 		ath_hw_cycle_counters_update(common);
>> -		memset(&common->cc_survey, 0, sizeof(common->cc_survey));
>> -		memset(&common->cc_ani, 0, sizeof(common->cc_ani));
>> +		memset(&common->cc_survey.cnts, 0, sizeof(common->cc_survey.cnts));
>> +		memset(&common->cc_ani.cnts, 0, sizeof(common->cc_ani.cnts));
>> 		spin_unlock(&common->cc_lock);
>> 	}
> 
> The compiler will only warn the second memset() `memset(&common->cc_ani, 0, sizeof(common->cc_ani));`
> detected write beyond size of field. However, `cc_survey` and `cc_survey` are the same structure.
> I have no idea about this warning. I will be very grateful if someone can provide some tips or a
> better solution.
> 
> The full log:
> make[4]: Entering directory '/home/db/openwrt/build_dir/target-mips_24kc_musl/linux-ath79_nand/backports-6.1.24'
> make[5]: 'Kconfig.versions' is up to date.
> make[7]: 'Kconfig.versions' is up to date.
> make[8]: 'conf' is up to date.
> boolean symbol CRYPTO_LIB_ARC4 tested for 'm'? test forced to 'n'
> #
> # configuration written to .config
> #
> Building backport-include/backport/autoconf.h ... done.
>    CC [M]  /home/db/openwrt/build_dir/target-mips_24kc_musl/linux-ath79_nand/backports-6.1.24/drivers/net/wireless/ath/ath9k/main.o
> In file included from ./include/linux/string.h:253,
>                   from /home/db/openwrt/build_dir/target-mips_24kc_musl/linux-ath79_nand/backports-6.1.24/backport-include/linux/string.h:3,
>                   from ./include/linux/bitmap.h:11,
>                   from ./include/linux/cpumask.h:12,
>                   from ./arch/mips/include/asm/processor.h:15,
>                   from ./arch/mips/include/asm/thread_info.h:16,
>                   from ./include/linux/thread_info.h:60,
>                   from ./include/asm-generic/current.h:5,
>                   from ./arch/mips/include/generated/asm/current.h:1,
>                   from ./include/linux/sched.h:12,
>                   from /home/db/openwrt/build_dir/target-mips_24kc_musl/linux-ath79_nand/backports-6.1.24/backport-include/linux/sched.h:4,
>                   from ./include/linux/delay.h:23,
>                   from /home/db/openwrt/build_dir/target-mips_24kc_musl/linux-ath79_nand/backports-6.1.24/backport-include/linux/delay.h:3,
>                   from /home/db/openwrt/build_dir/target-mips_24kc_musl/linux-ath79_nand/backports-6.1.24/drivers/net/wireless/ath/ath9k/main.c:18:
> In function 'fortify_memset_chk',
>      inlined from 'ath9k_ps_wakeup' at /home/db/openwrt/build_dir/target-mips_24kc_musl/linux-ath79_nand/backports-6.1.24/drivers/net/wireless/ath/ath9k/main.c:140:3:
> ./include/linux/fortify-string.h:314:25: error: call to '__write_overflow_field' declared with attribute warning: detected write beyond size of field (1st parameter); maybe use struct_group()? [-Werror=attribute-warning]
>    314 |                         __write_overflow_field(p_size_field, size);
>        |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> cc1: all warnings being treated as errors
> make[11]: *** [scripts/Makefile.build:250: /home/db/openwrt/build_dir/target-mips_24kc_musl/linux-ath79_nand/backports-6.1.24/drivers/net/wireless/ath/ath9k/main.o] Error 1
> make[10]: *** [scripts/Makefile.build:500: /home/db/openwrt/build_dir/target-mips_24kc_musl/linux-ath79_nand/backports-6.1.24/drivers/net/wireless/ath/ath9k] Error 2
> make[9]: *** [scripts/Makefile.build:500: /home/db/openwrt/build_dir/target-mips_24kc_musl/linux-ath79_nand/backports-6.1.24/drivers/net/wireless/ath] Error 2
> make[8]: *** [scripts/Makefile.build:500: /home/db/openwrt/build_dir/target-mips_24kc_musl/linux-ath79_nand/backports-6.1.24/drivers/net/wireless] Error 2
> make[7]: *** [Makefile:2012: /home/db/openwrt/build_dir/target-mips_24kc_musl/linux-ath79_nand/backports-6.1.24] Error 2
> make[6]: *** [Makefile.build:13: modules] Error 2
> make[5]: *** [Makefile.real:93: modules] Error 2
> make[4]: *** [Makefile:121: modules] Error 2
> make[4]: Leaving directory '/home/db/openwrt/build_dir/target-mips_24kc_musl/linux-ath79_nand/backports-6.1.24'
> make[3]: *** [Makefile:401: /home/db/openwrt/build_dir/target-mips_24kc_musl/linux-ath79_nand/backports-6.1.24/.built] Error 2
> make[3]: Leaving directory '/home/db/openwrt/package/kernel/mac80211'
> time: package/kernel/mac80211/regular/compile#4.94#0.95#21.75
>      ERROR: package/kernel/mac80211 failed to build (build variant: regular).
> make[2]: *** [package/Makefile:120: package/kernel/mac80211/compile] Error 1
> make[2]: Leaving directory '/home/db/openwrt'
> make[1]: *** [package/Makefile:114: /home/db/openwrt/staging_dir/target-mips_24kc_musl/stamp/.package_compile] Error 2
> make[1]: Leaving directory '/home/db/openwrt'
> make: *** [/home/db/openwrt/include/toplevel.mk:231: world] Error 2
> 
> Best Regards,
> Shiji Yang

