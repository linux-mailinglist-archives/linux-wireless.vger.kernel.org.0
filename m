Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00EB87213FE
	for <lists+linux-wireless@lfdr.de>; Sun,  4 Jun 2023 03:41:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbjFDBlR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 3 Jun 2023 21:41:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjFDBlQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 3 Jun 2023 21:41:16 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01olkn2081.outbound.protection.outlook.com [40.92.99.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7593E1A7
        for <linux-wireless@vger.kernel.org>; Sat,  3 Jun 2023 18:41:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mgol6+GSNHIf2RQdBQBL1Wp2CG7675wXfBJGsRQvcE0ZExPlHyv1D48brpWFLb0mbWwuhPr89poy/37Vd4l3/gXdkX1SeGbWuw3Ypz+SdkjW0okEfOFgi/kVk9skdZ++vBAVHMN/fzBV2ObhByOReX1PDp4B/M8CbXKC9Z7+kNAEM9QvN3yQJ4IxEhXuAA5zJ6oovrIzMzAnHDC0U9OycNUvHgDl0z63oqb3Fw3fiCS+MQvR4xXWHyKrCnFrQMFYD4/CVw2ER+w7dtsd4l4cyRkk/U/ZkrirfhX2OuCbWwpenYJcD7/u7MlHKaIDimlnqDa4GBTNjr7fQPb6P+iCwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=62+L0LMggabZIjqW/phxyp3+i7C2Gbte6Mc+NCjvvrk=;
 b=JHQYjAM2Jzp8DtvBC4LmSM+YGAcj5JlxHP0irujXI81IjiTeb3QFx8HL8NJEVPzQXvVKNChz8OJ7L5KtWMlKTb8NIPghQ1kiJjiDZu+Ik/TfqO65i/RnwYIhZ8g0M6ikWqH7og/w0G3ZwfywNyRFP64cSTtaEErt2zRqZhljvvMW5XjdEhWWL/GBwtCrhCL04ZcVGtxvITdFZJHvjRoqJyJlN8zFaZDmbg8b2SjD9zMV0nQKvlDZvqn+gaXoTQdxiSp2Z0f3IIvGmW1QQii7SCyoC8KXpKsbK43SVpMfdL0mkC139lNALNbWT6gcili2c4p3BmsQ2ASIjppeBiYqYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=62+L0LMggabZIjqW/phxyp3+i7C2Gbte6Mc+NCjvvrk=;
 b=nx3pJXOAGRqj6zGtwbsT4OzyQfyLeoM7NDUJN5jrSASVsBG9xfvqOry6TsVjxKwCrkBlPZiGm/d6ozSktjJBR3b8lVj5QvAoKlXwO3jBkQzkm8QdquJ8pVSM0nSf3qbLeIKmqesCSVyvUQTbSraVZNTgAUR7WEwRK83y4zAv3Ct12tF4/ocrpAOWgm0wpbvYiRA6RKFppwQ2DKMGQZ11xdVip02OUJO7cozFN0eoZBFpprimsdPHUh+dCA38G/3BsPJhSzvnPcjILa+ygPxpsovGMIot3JnqkPknEOiLM6Kw16ZBmolt+yd5Quugqs15NuI7mitLu61lg4RdxJJXAw==
Received: from TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM (2603:1096:404:8041::8)
 by TYWP286MB3621.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:394::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.31; Sun, 4 Jun
 2023 01:41:08 +0000
Received: from TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM
 ([fe80::ca7e:d73d:ba3f:64a6]) by TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM
 ([fe80::ca7e:d73d:ba3f:64a6%5]) with mapi id 15.20.6455.030; Sun, 4 Jun 2023
 01:41:08 +0000
From:   Shiji Yang <yangshiji66@outlook.com>
To:     jirislaby@kernel.org
Cc:     ansuelsmth@gmail.com, chunkeey@gmail.com, kvalo@kernel.org,
        linux-wireless@vger.kernel.org, mcgrof@kernel.org,
        mickflemm@gmail.com, robimarko@gmail.com, toke@toke.dk,
        yangshiji66@outlook.com, yangshiji66@qq.com
Subject: Re: [PATCH] wifi: ath: add struct_group for struct ath_cycle_counters
Date:   Sun,  4 Jun 2023 09:40:57 +0800
Message-ID: <TYAP286MB03154F9AAFD4C35BEEDE4A99BC4CA@TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <d68c4b38-88e1-02ef-5779-08b93fd0d47b@kernel.org>
References: <d68c4b38-88e1-02ef-5779-08b93fd0d47b@kernel.org>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [z7CUuVcRVQwDq3C3tqu02dslmBhp72n6bSynM2Kz70E=]
X-ClientProxiedBy: TYWPR01CA0023.jpnprd01.prod.outlook.com
 (2603:1096:400:aa::10) To TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:404:8041::8)
X-Microsoft-Original-Message-ID: <20230604014058.2253-1-yangshiji66@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYAP286MB0315:EE_|TYWP286MB3621:EE_
X-MS-Office365-Filtering-Correlation-Id: a6fc9e1f-f1f2-436d-6869-08db649cc499
X-MS-Exchange-SLBlob-MailProps: ScCmN3RHayEuKAx9GOqaR13NPwfDAOmfq35/5dxlU1lwYDWHo3DRyKkj5pNGmx9x8lmh4jEMfO0ltIGr3sTjIe1kqbk4I1iIOfD1Rbm48MkdlfHbIR2A1nekHyITL5pDpH9nGqJdj8X1hmPxzBkMvZckzerDJYDHdPJTg0tarnF+F3x8zh7y3QVE13eOkucV7A4wQ6xfQtrQ/YkOg+YE2/t9Dz4YOG9PaEyAvsl2RiCsNbiRdAAwbyFwJlhneLlmltz8oeiPWUuL1ZacNVVI/ulei/vKCFCP+1Ld2S543iUdRJ83R+mkzaOjKP+vsrQGjDLgi/nIYrkr/fSJA/KkfnnndQlRmd/HBEUC/PMk+Haz+77lNG3GUeo081KU8YIkb8sHFbI5T0fvXChyhGNaugPG21VYCYOO4E2nlaYXgsVUQgQqMgPFIj7nM/RHOju8T3QVq39N6ojy2zZBU6S1ORmkc6ZShJ3k7f34ToyLRbETS+0Z0x0AGnaX9mEUWz0xPgEluN1vfDQdNh+Ag5+oVatnQklIXBtLWi+EFM9LJnpP//NLSQXXq3308apUmLhtxNZk5duKybCwpnoo1yOu7pj14nzxMXc5Z5lV42Q45jwqN3MezEhw7O0aC552e3IOulpuHQj510KTdTpL7k9Obex/5mg+3O7EDJiW1/+ckxSPr1k76yNhmpJQQx2V/VRl+pT/nZ3SIt+WYGM92gTCATvFxXiRG7tUAIUFoCvJRCA=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fYt0WSGFO7qUtgeAXU7esr1+jfr2DaAyD9iIboMAniSD/02eBbhJFgX8wMIy4nvv7Xc5a3iCSlGZn663B3K/MmAySLL8uGLbhEXA4bdJsQjfAl0HzIJAxxG8CONIZ/g3XBGnyQQyrhEBCkkhy0iui5qar7l2JxKXC4FVm9NyOBidg/iWqfYFIlE7Y+vloFnpQ4tK2vV79zBLGe9YelEXsdOH/HsJnR3DO/oN/SIOfDFUssSCslaxRR9h7LZlfZRzFOiZ3IFnDMJuXc4elz+/RJn6uB8jLHgY7FgdcjYtga5EzOljCkzOO1HeCc9mm/oVSnVYSXOKg/H2dNRwVM0WFiUY5WPsw2NGJZIz3B48CRBW4wXAyURi3cKQvlyxmqVdy0Wid/sf5ciQwG9gisshcknEyUte8HY+TbljW7NWgbK34L83sCmZ1myn3umlIstkAxkGXLEmqY5Ia7LeLtzVKDKWomRZqs6rzaprOZv23vmuy9U8cY0nPw70blH1zBd3p5yEIyzifQjHl5weJDVPh+rv6JjCtme1V/XsSuCpvRqCNA+2TEBg6EatPHBpoSnd88XpDUpFoKX6QG1A7EFWyxQq3CsLj4R4NU68xXUbyN0qb/7oDwoxSCm1hhC7/w1b
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YV+h8fsco4ttMb98ECEpXxQeIEQJoCsVBJX/39re41HnbeyQ4+v9LquCPzcT?=
 =?us-ascii?Q?F4+6p9VcroIeDBxtWAY0pz9zdcJhiFTx1hsbazEnYwyOpcp0eMxTGOTpQilA?=
 =?us-ascii?Q?Bl/HNruutl4HmGcDRslpzfUP50ksMQOEKcAg41yaXb8IWivYimpS4hZVxtsd?=
 =?us-ascii?Q?VRDxyg0lcOHZAgGhIGkB9avLivedMtR+642M6azZzSzTKD893VQVoIBtlrRW?=
 =?us-ascii?Q?BJv/UaH/ReKm6KDPZaKDI5HSFYPNt1XElw/KrL5p6hAZJ8+wI3L4hDmxaXxH?=
 =?us-ascii?Q?gzPQF/6secHXCjBz/BFIr7O41120CxEE9WuN6+6VrONCpX5QjIasjHrJBBlQ?=
 =?us-ascii?Q?66emRdEBvgC2yNQqFgyluX47JMFjX4DJcB6XxXJ/28q6ubiPDw7KYW8LyhQn?=
 =?us-ascii?Q?dSTu9DSkiwvZFyAOTyD35I3XdMlPIAsS+d/cFyWp/TjF42idMsbhVy3KAqTK?=
 =?us-ascii?Q?pG3cjv3wNHEEzjuvFeyZTklNQX0v4uE1NHf5RE921Ub6Cs+PM/8TnqHnE2HR?=
 =?us-ascii?Q?VGn8y64b19GjApfR3nj/vs43sV4h9+mtUoNrHzcS80Ac4exVVjVRIlASZ8Sb?=
 =?us-ascii?Q?jzID6Vd8WQRwtaRomY4VAeovDyN9750tHANsZkEumfLHhGFOinzvpU/68ov0?=
 =?us-ascii?Q?U3fITYyR93iCtWYOu9CWJFZ7hDQ/s+LTCKU5zL+iYvl3FJwkUckBhuBVWrjb?=
 =?us-ascii?Q?q1dTuP/gHO2etFRZYzUKKpaf3Q7upsXZ81k7A6L0WSv8TSIJI0sY/qB1Nl+r?=
 =?us-ascii?Q?sqVg7GBfQGSVxiwpid702pD38lpsDahr7MEWUSOqZg3kP5ED5Qugm+Hlpe6Z?=
 =?us-ascii?Q?WA8RPA6bAh1fz328U4361TLbAVLvsSlNa2AiRi1lp2gYeYuy0299+UWRK4e3?=
 =?us-ascii?Q?1VTlofwaC8uPiomgLgMftQhakx1m9BBPRDHk+sUelq6svCvgsgLBW9GkDF0c?=
 =?us-ascii?Q?pavCuPaud7JPAgdMGcImoLtrIOSmVtUwjrWbz1Kirqc+3as2lacVH5GjBQVG?=
 =?us-ascii?Q?iN1iaDLE3F/S98kWSfa9TE/HtNnzeZpUORicEyeEoYTikzCxNdiSh9oSg44l?=
 =?us-ascii?Q?OC5HnkRmCF9glmgc9Y4Dk/tWoM2ZRZPkeu4vFFachNimP3KYv+CAWUiL8G6X?=
 =?us-ascii?Q?KLhezCJLuC+2HnakAXqYx9E56AkCP0HN6uPY1jw6KMGyrlmaPXdHVq02BVyq?=
 =?us-ascii?Q?7QVXAiTe2LFTeR/dNXLwynKvT8M5f1+T8fMZ63f4ttSASUIGlRO+mbGkscM?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6fc9e1f-f1f2-436d-6869-08db649cc499
X-MS-Exchange-CrossTenant-AuthSource: TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2023 01:41:08.3122
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWP286MB3621
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Thank you for your reply.
>On 02. 06. 23, 6:36, Shiji Yang wrote:
>> From: Shiji Yang <yangshiji66@qq.com>
>> 
>> Add a struct_group to around all members in struct ath_cycle_counters.
>> It can help the compiler detect the intended bounds of the memcpy() and
>> memset().
>> 
>> This patch fixes the following build warning:
>> 
>> In function 'fortify_memset_chk',
>>      inlined from 'ath9k_ps_wakeup' at drivers/net/wireless/ath/ath9k/main.c:140:3:
>> ./include/linux/fortify-string.h:314:25: error: call to '__write_overflow_field' declared with attribute warning:
>> detected write beyond size of field (1st parameter); maybe use struct_group()? [-Werror=attribute-warning]
>>    314 |                         __write_overflow_field(p_size_field, size);
>>        |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> 
>
>Hi,
>
>what compiler/version is this with?

I'm using the mips gcc 12.3 (for arc ath79). It seems to be related
to the compiler, and arm gcc 12.3 does not show compilation warnings.

>> Signed-off-by: Shiji Yang <yangshiji66@qq.com>
>> ---
>> More discussion on: https://github.com/openwrt/openwrt/pull/12764
>
>No "__write_overflow_field" there. Is this the right link?

Yes. However, only few of the discussion here is related to compilation errors.

The full log:

make[4]: Entering directory '/home/db/openwrt/build_dir/target-mips_24kc_musl/linux-ath79_nand/backports-6.1.24'
make[5]: 'Kconfig.versions' is up to date.
make[7]: 'Kconfig.versions' is up to date.
make[8]: 'conf' is up to date.
boolean symbol CRYPTO_LIB_ARC4 tested for 'm'? test forced to 'n'
#
# configuration written to .config
#
Building backport-include/backport/autoconf.h ... done.
  CC [M]  /home/db/openwrt/build_dir/target-mips_24kc_musl/linux-ath79_nand/backports-6.1.24/drivers/net/wireless/ath/ath9k/main.o
In file included from ./include/linux/string.h:253,
                 from /home/db/openwrt/build_dir/target-mips_24kc_musl/linux-ath79_nand/backports-6.1.24/backport-include/linux/string.h:3,
                 from ./include/linux/bitmap.h:11,
                 from ./include/linux/cpumask.h:12,
                 from ./arch/mips/include/asm/processor.h:15,
                 from ./arch/mips/include/asm/thread_info.h:16,
                 from ./include/linux/thread_info.h:60,
                 from ./include/asm-generic/current.h:5,
                 from ./arch/mips/include/generated/asm/current.h:1,
                 from ./include/linux/sched.h:12,
                 from /home/db/openwrt/build_dir/target-mips_24kc_musl/linux-ath79_nand/backports-6.1.24/backport-include/linux/sched.h:4,
                 from ./include/linux/delay.h:23,
                 from /home/db/openwrt/build_dir/target-mips_24kc_musl/linux-ath79_nand/backports-6.1.24/backport-include/linux/delay.h:3,
                 from /home/db/openwrt/build_dir/target-mips_24kc_musl/linux-ath79_nand/backports-6.1.24/drivers/net/wireless/ath/ath9k/main.c:18:
In function 'fortify_memset_chk',
    inlined from 'ath9k_ps_wakeup' at /home/db/openwrt/build_dir/target-mips_24kc_musl/linux-ath79_nand/backports-6.1.24/drivers/net/wireless/ath/ath9k/main.c:140:3:
./include/linux/fortify-string.h:314:25: error: call to '__write_overflow_field' declared with attribute warning: detected write beyond size of field (1st parameter); maybe use struct_group()? [-Werror=attribute-warning]
  314 |                         __write_overflow_field(p_size_field, size);
      |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors
make[11]: *** [scripts/Makefile.build:250: /home/db/openwrt/build_dir/target-mips_24kc_musl/linux-ath79_nand/backports-6.1.24/drivers/net/wireless/ath/ath9k/main.o] Error 1
make[10]: *** [scripts/Makefile.build:500: /home/db/openwrt/build_dir/target-mips_24kc_musl/linux-ath79_nand/backports-6.1.24/drivers/net/wireless/ath/ath9k] Error 2
make[9]: *** [scripts/Makefile.build:500: /home/db/openwrt/build_dir/target-mips_24kc_musl/linux-ath79_nand/backports-6.1.24/drivers/net/wireless/ath] Error 2
make[8]: *** [scripts/Makefile.build:500: /home/db/openwrt/build_dir/target-mips_24kc_musl/linux-ath79_nand/backports-6.1.24/drivers/net/wireless] Error 2
make[7]: *** [Makefile:2012: /home/db/openwrt/build_dir/target-mips_24kc_musl/linux-ath79_nand/backports-6.1.24] Error 2
make[6]: *** [Makefile.build:13: modules] Error 2
make[5]: *** [Makefile.real:93: modules] Error 2
make[4]: *** [Makefile:121: modules] Error 2
make[4]: Leaving directory '/home/db/openwrt/build_dir/target-mips_24kc_musl/linux-ath79_nand/backports-6.1.24'
make[3]: *** [Makefile:401: /home/db/openwrt/build_dir/target-mips_24kc_musl/linux-ath79_nand/backports-6.1.24/.built] Error 2
make[3]: Leaving directory '/home/db/openwrt/package/kernel/mac80211'
time: package/kernel/mac80211/regular/compile#4.94#0.95#21.75
    ERROR: package/kernel/mac80211 failed to build (build variant: regular).
make[2]: *** [package/Makefile:120: package/kernel/mac80211/compile] Error 1
make[2]: Leaving directory '/home/db/openwrt'
make[1]: *** [package/Makefile:114: /home/db/openwrt/staging_dir/target-mips_24kc_musl/stamp/.package_compile] Error 2
make[1]: Leaving directory '/home/db/openwrt'
make: *** [/home/db/openwrt/include/toplevel.mk:231: world] Error 2

>> ---
>>   drivers/net/wireless/ath/ath.h                | 10 ++++++----
>>   drivers/net/wireless/ath/ath5k/ani.c          |  2 +-
>>   drivers/net/wireless/ath/ath5k/base.c         |  4 ++--
>>   drivers/net/wireless/ath/ath5k/mac80211-ops.c |  2 +-
>>   drivers/net/wireless/ath/ath9k/link.c         |  2 +-
>>   drivers/net/wireless/ath/ath9k/main.c         |  4 ++--
>>   drivers/net/wireless/ath/hw.c                 |  2 +-
>>   7 files changed, 14 insertions(+), 12 deletions(-)
>> 
>> diff --git a/drivers/net/wireless/ath/ath.h b/drivers/net/wireless/ath/ath.h
>> index f02a308a9..4b42e401a 100644
>> --- a/drivers/net/wireless/ath/ath.h
>> +++ b/drivers/net/wireless/ath/ath.h
>> @@ -43,10 +43,12 @@ struct ath_ani {
>>   };
>>   
>>   struct ath_cycle_counters {
>> -	u32 cycles;
>> -	u32 rx_busy;
>> -	u32 rx_frame;
>> -	u32 tx_frame;
>> +	struct_group(cnts,
>> +		u32 cycles;
>> +		u32 rx_busy;
>> +		u32 rx_frame;
>> +		u32 tx_frame;
>> +	);
>
>This is horrid.

Yes, I agree, but this can avoid making more changes.

>>   };
>>   
>>   enum ath_device_state {
>> diff --git a/drivers/net/wireless/ath/ath5k/ani.c b/drivers/net/wireless/ath/ath5k/ani.c
>> index 850c608b4..fa95f0f0f 100644
>> --- a/drivers/net/wireless/ath/ath5k/ani.c
>> +++ b/drivers/net/wireless/ath/ath5k/ani.c
>> @@ -379,7 +379,7 @@ ath5k_hw_ani_get_listen_time(struct ath5k_hw *ah, struct ath5k_ani_state *as)
>>   	spin_lock_bh(&common->cc_lock);
>>   
>>   	ath_hw_cycle_counters_update(common);
>> -	memcpy(&as->last_cc, &common->cc_ani, sizeof(as->last_cc));
>> +	memcpy(&as->last_cc.cnts, &common->cc_ani.cnts, sizeof(as->last_cc.cnts));
>
>So is this.
>
>Care to elaborate why this is needed at all, provided we copy/zero a 
>whole structure? And describe it in the commit log, not in random 
>external sources.

Thank you for the prompt. I will pay attention to the format of the patch next time.

The compiler did not complain here. But in

diff --git a/drivers/net/wireless/ath/ath9k/main.c b/drivers/net/wireless/ath/ath9k/main.c
index a4197c14f..8608a29a1 100644
--- a/drivers/net/wireless/ath/ath9k/main.c
+++ b/drivers/net/wireless/ath/ath9k/main.c
@@ -135,8 +135,8 @@ void ath9k_ps_wakeup(struct ath_softc *sc)
 	if (power_mode != ATH9K_PM_AWAKE) {
 		spin_lock(&common->cc_lock);
 		ath_hw_cycle_counters_update(common);
-		memset(&common->cc_survey, 0, sizeof(common->cc_survey));
-		memset(&common->cc_ani, 0, sizeof(common->cc_ani));
+		memset(&common->cc_survey.cnts, 0, sizeof(common->cc_survey.cnts));
+		memset(&common->cc_ani.cnts, 0, sizeof(common->cc_ani.cnts));
 		spin_unlock(&common->cc_lock);
 	}
 
Here, memset() is used to zero the entire structure. The compiler will only warn
the second memset() `memset(&common->cc_ani, 0, sizeof(common->cc_ani));` However,
`cc_survey` and `cc_survey` are the same structure.

>
>thanks,
>-- 
>js
>suse labs
