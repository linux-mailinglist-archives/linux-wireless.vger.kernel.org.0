Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91D83721407
	for <lists+linux-wireless@lfdr.de>; Sun,  4 Jun 2023 03:48:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbjFDBsX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 3 Jun 2023 21:48:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjFDBsW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 3 Jun 2023 21:48:22 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01olkn2086.outbound.protection.outlook.com [40.92.98.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADA0AA6
        for <linux-wireless@vger.kernel.org>; Sat,  3 Jun 2023 18:48:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GPzDPsBj8IL3elIncvo7pSWf/KTIsskDLT7GV41L7edIRRtFMB4KFHMezL7rR+trR79UzfcZw8pdf0YDZQCaQE+zwnWXVC11wKRmYD5/EdJILPFzm2MGsLa04cV2GS93y5vU7x7aphpL6B1B9EBqG89AEwyGBwqBCxIuKjv8YSt2zZ9u1kInidVkxWi3Xnwn2msQ1ritYWcVnCTKbqJ57Kr5ly3Ct07eQxmXttOkCytf/Byy3rYfV6Bs1NtbQh9HW+ggR9xpkFNULZFwqLiktGWqTzPdR8968pX9iJQehxprTmH5FdR+Yhze2BdGA9RFnphL1Zo+XIcPs0Oj0cbOyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CqM5Ur3OqfSii5p2F2NBmLAZ6PyrjqB4eOnwB9647vU=;
 b=BGJ6aYeiZ/PeYD7zqBm+JHZQ1WNzcRgOCQ/Jv0Lz79HKAsQQP9MMnPgEGNAD4OD0ba89vTrpUCc2ptMFCx1vFevghNm3IvqDqsrN8f5r0Gpi0MYPk/doUp0tlBHLcJgh7FM2SU68wUCZeS/3Be9aWnCD29hnIrqbwWXG6YLaq8MOU4MkzJWcR4htG9ceBuSgzWe7UdXJYU6cqFtfnjhOCzVHmkAfBWyCmDvyKXmByV5zR3OXI0ackXuvOesRu6iKNRV+v7FqOIqivrPvteCtuwYDxeuiTNRxXSN+CVbO6ME4dDxKkMFfXo4gkjO6s9k9wY1hIKd/ej4pNZGn/iNN1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CqM5Ur3OqfSii5p2F2NBmLAZ6PyrjqB4eOnwB9647vU=;
 b=LYUl28kB0heLkDiKlF+mnXeJ0N646f9OioYE5gudwSN4QOeAZsGRCGZnweDCimjYqRwu6L6x1mj1t/kLW9ocygr1IYr5a0zCbi92bqdTC+tZgmd7HpgXdHoRtFsh3zWwaQXXYGRSLQgZLiKKh/9T1FmL4zy4ckEpmnAj9BRFMMFX56b9rjJU+0Zfoo5zzmsK9Lckln61m7mE4fOcMjtrgW3dLUOpk2aB5tHS6dBRTq0UPBJPnl2vreARrgnINxR2u8k5OKKq4IlUpFnvmXV5cYG8qGVzTjRB1mVWJU0zAqMyXl3C6qPnq5ZOPyq/GatqDMS3WJcuTlQgyoHsKUHp6g==
Received: from TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM (2603:1096:404:8041::8)
 by OS3P286MB2760.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:1f2::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.31; Sun, 4 Jun
 2023 01:48:16 +0000
Received: from TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM
 ([fe80::ca7e:d73d:ba3f:64a6]) by TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM
 ([fe80::ca7e:d73d:ba3f:64a6%5]) with mapi id 15.20.6455.030; Sun, 4 Jun 2023
 01:48:16 +0000
From:   Shiji Yang <yangshiji66@outlook.com>
To:     yangshiji66@outlook.com
Cc:     ansuelsmth@gmail.com, chunkeey@gmail.com, jirislaby@kernel.org,
        kvalo@kernel.org, linux-wireless@vger.kernel.org,
        mcgrof@kernel.org, mickflemm@gmail.com, robimarko@gmail.com,
        toke@toke.dk, yangshiji66@qq.com
Subject: Re: [PATCH] wifi: ath: add struct_group for struct ath_cycle_counters
Date:   Sun,  4 Jun 2023 09:48:05 +0800
Message-ID: <TYAP286MB0315FA0080ABAE79CC842899BC4CA@TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <TYAP286MB0315EC437BF53C8DB2B5D022BC4EA@TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM>
References: <TYAP286MB0315EC437BF53C8DB2B5D022BC4EA@TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [1RZWOnimJ4tvsjt/YqdI4n5xYZBraKf6]
X-ClientProxiedBy: SI1PR02CA0010.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::17) To TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:404:8041::8)
X-Microsoft-Original-Message-ID: <20230604014805.2850-1-yangshiji66@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYAP286MB0315:EE_|OS3P286MB2760:EE_
X-MS-Office365-Filtering-Correlation-Id: f2183c56-0c26-4a1c-3d2e-08db649dc3f2
X-MS-Exchange-SLBlob-MailProps: ScCmN3RHayEuKAx9GOqaR13NPwfDAOmfq35/5dxlU1nR7/AX+DiNTZIxvdKbiGxhr4PkOLfUAfxb0QO3P0fWVT3VguBmki1vPTycqUcPeFpHvAP4YriiRLPU+nkON3605Z13cvCkIrOI4DL4n8phtzgYAszeN/Rw4olJMvSxTOvlJwsk/rAMLGg5GLmSY/E95zKtM6OZJDKg4MMkesggpx3LOX1+gRE7kVMVhOlynzH40L3Sj7IFirpchymaPNyIO0K1+Pd37uY5spPBho++KAwdDVsih5oH70DtLoEHKy5GdLg6RZzmH4enes89DMxfBffIl1rD+DGwauae27Yq5akBpy8H40FWVYJtOzDx+Q7gq5pLYhzuTqEEArxsTOHE+/VLxDj3iWjR3GmbOYJOWyAhTUU2USL9RobCAujZRaqqQ33ovIaUJ2Oq93aeY2p95aOgIc/ahTnHcPPX4cTIiVfsNjRQvOhshYj1zASDhEL42quBDXm7Q+1QaVJUqtUQBKB511h1tbIoDzDsBMqfKNf/xnqmH8AAJGFsAsWggPizpXwbAJO3mQjsyyxNRQwmVvXacb1TD4AL+AXLj+3L06jh6plwbCcFF4D4pBEQECIFXQuNeyCAmWFs9+qI3pzcQQIyCBIKbqQs9IdtX9plQKHZ4d/Rrhkyq/kxS9uKCxLFx6H+ABMYwkJiwNx6g+Qnwvm/ZWmq2qj77dwSwlufIIXvr+H+WYTmwe69GIcCCCI=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1FDLNWskV+PHdQcExXjHuIZFlDzE5wvNN9UNFhy9oBaGc+0Qjypa5jZN4OZC+3xaXGY+4xlZKlTUvuJFqJOoXHrP/Zb8FQkG4u3SC89iQ1onKgcoF+r1LO7tHAOF4QBX+lUsFONWzD+2slDeso5PANABwHQV+ya6RLT8FtAzgZgEZC2I9dJjQ+ZuRljXAAqlZBWM+1ZPANzhJ0mKyv1nW/pIKRHu7M/d39/m1RtSHr+QDL50huozmZ8ep40b5Kc8l3kKbKkPFETpUgVR4HJv56ktsIwgHxM1Jf4zIlFf8nSde3E1wSklbnfoRR8qNgTkWcdnAzc4XJCUiFRq1yVS3csGnFy/vHK++/uDdiyGTRHlJ6x6CEqLmVkWdp1KZi5SG/esvf3OhUZfycA4ajp/dFk+HgA4pa9CRAp7GjQEQ78PGhSYdU3+hcyeKJfdqUT+3XkI+Jhm2j3N8IE2lYBHe2/MROY5tdsNmzkPwMC1izt5+AMl3TtnpG+tPkIdaW/Y0zqwT2h3uivo2U4jGzS+Lx6FQc0+I4p6SrXdwtxDS4Z7M6i/RKP9u4ncRYKWbg6ziuVtJG45PYvKWY9yEFPnfRJ6bOycQlU1+cym4NS6wK5vkQ18YrN7FEqv7/q5iF8BS1dugG29It6gK8ZcSXI7Cw==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8N+BQHa+Mjsnp7rud0w+aG7Rnem4REtZEVkOvJOVtoJgoQ554kU3mjzZhccT?=
 =?us-ascii?Q?z5dl/2L3+HrdVk6cjeuzC8tnIS8sJeYrd8VayvNhd+iILSM/k8fQcsBBPCbi?=
 =?us-ascii?Q?FbM3OvASD0Pqqu7qK/5owDLxAnEIWFbHHA8eBNGt1E8V2LcuLwKM/oAS6Mu4?=
 =?us-ascii?Q?pUTHfPwO80jcTQcit+QlmZp7AIiF7VbnAbkqoNZyjauORXJTln1Mew1lgUEi?=
 =?us-ascii?Q?pLyYT9v8FSZ0ycjzIkugLvNSs+sVp3OTyowY/MW41zU1buXXOft6/tsHuwcA?=
 =?us-ascii?Q?OmgSAnCq1pzPGrTV7v6q5XfwM5VMx2yS3Ao0bI59RdytPtTnj54pJNeEEogR?=
 =?us-ascii?Q?qGuG503+vNzLpQ7NOvk0b3sKS0LwOIvvhQbyBCDBXuKMcPLCbMRoCc7reDY2?=
 =?us-ascii?Q?LgTJR5f1OIRL1/bDigBQc6LzM8NBS0eYLRibVUJbHq64mCGDnuVtq96jvk0s?=
 =?us-ascii?Q?SYbh7Vfc2KGfj6f6vwvH3aRi2dw0NjgN1u6XZal5vQsD6N75w3nN6553O15l?=
 =?us-ascii?Q?Dssa1FTCJGJi8dxSIedpeZJV+gEcvpcVIHoIVVLKIBB2WFsZzS03EqkNSv2O?=
 =?us-ascii?Q?LpYE0QlkzR7x203pLiFoXNcvHAhcaf0Cbu8JU6KNZPbM3N+puiGq8QScBlux?=
 =?us-ascii?Q?uwgHmTE1vJ5nz7lknUUoz/gdrMN7R3nEK5w+6zFubozc2P7PBSx4MquhCtt1?=
 =?us-ascii?Q?fhAH9VRYcvgeMeaXlr3dYFk8eLWtYOhSSxlBYSYRJ7h5RvizR++p8qc66znk?=
 =?us-ascii?Q?lefXqMfG4tYelQcv+ZENP6+oP3vgRgbc1coSm0p6e+psZu0CwrnHGL5BBLX3?=
 =?us-ascii?Q?s94BqAyhL3Ylr0sqgou0tnjbUzmS6JK9uCZwasYjXSVsNBMSEr/6pUSzqyQq?=
 =?us-ascii?Q?99JOpB0iKw9ftzUhgDSEnxV5zF2jseBa3z5PQyL+TyzzWnur5mlB2FfN6zLo?=
 =?us-ascii?Q?nnTbuC+441LEE/H5BaJE9Q1uFQd8ifZR7syDEcvLy/Mwv2jrspMQXX/TccV3?=
 =?us-ascii?Q?xWQ8bQ2xZbkCEHCzUgqCZ3wXGWlAgH/HnZtXuoNLuZ7xg5UAJY0kl+JJYfZU?=
 =?us-ascii?Q?e/d5SqfXAXsPcuh239alywZBURt6QUlROgqwu9kGVi/MxTS2UWAckq7nn0YG?=
 =?us-ascii?Q?fQFYhT2rFxxt4Rxz5h1bIjGDuSTDOzaSIik170N8vfVkqsgMwGgoGZg00Tpu?=
 =?us-ascii?Q?OXudnwElncdEPbyGR4q0jASo1lLeefPh+5S55BU0uEqUF8JDp9HplA+/Xrs?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2183c56-0c26-4a1c-3d2e-08db649dc3f2
X-MS-Exchange-CrossTenant-AuthSource: TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2023 01:48:16.5972
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3P286MB2760
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Thank you all,
This patch may not look so beautiful, but its main purpose is to raise
some awareness about this strange compilation warning.

This problem only occurs in mips gcc 12.3 (maybe only on arc mips/ath79).
In:

>--- a/drivers/net/wireless/ath/ath9k/main.c
>+++ b/drivers/net/wireless/ath/ath9k/main.c
>@@ -135,8 +135,8 @@ void ath9k_ps_wakeup(struct ath_softc *sc)
> 	if (power_mode != ATH9K_PM_AWAKE) {
> 		spin_lock(&common->cc_lock);
> 		ath_hw_cycle_counters_update(common);
>-		memset(&common->cc_survey, 0, sizeof(common->cc_survey));
>-		memset(&common->cc_ani, 0, sizeof(common->cc_ani));
>+		memset(&common->cc_survey.cnts, 0, sizeof(common->cc_survey.cnts));
>+		memset(&common->cc_ani.cnts, 0, sizeof(common->cc_ani.cnts));
> 		spin_unlock(&common->cc_lock);
> 	}

The compiler will only warn the second memset() `memset(&common->cc_ani, 0, sizeof(common->cc_ani));`
detected write beyond size of field. However, `cc_survey` and `cc_survey` are the same structure.
I have no idea about this warning. I will be very grateful if someone can provide some tips or a
better solution.

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

Best Regards,
Shiji Yang
