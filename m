Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 821D07CF884
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Oct 2023 14:16:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235424AbjJSMQD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 19 Oct 2023 08:16:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235387AbjJSMP7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 19 Oct 2023 08:15:59 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01olkn2023.outbound.protection.outlook.com [40.92.98.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E5921BFC
        for <linux-wireless@vger.kernel.org>; Thu, 19 Oct 2023 05:05:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HiQrR/hX9T/MKz+6318pgAeWXcw6IuOqCDMKtYNbdoWjhUmrjRlnkzkIhwZG7h5WTmB9J1DkTWtvYwrKkJ7OLVWvfD70YjkP+l9ncXdPux6CcfuxnYYIdw0B431LZnsT9QC40riiYt9usEaLxpz+494pnB/rllJa1NuqHOss5x2KVRt4IzLCXKwDLHpA9SnCnmKgZXmXlPuzY0gwZAMk2iv4aO7hMmTx6omG255Q+HC7e3cppfHf8ATfzuWA7kpYPFL3R3ZLakEveLedr2hZSbGelOcqaWc9+pK5ZFF3c+dpd2x1BjZDrc15W10HbA0sYaU/ndmYY6q8ModxlrXo3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A7LqdcbocKMtv2JYSc0mpiGLRBWNSRkZbXD8Hp5h54U=;
 b=hTjJQHpYrwC5aH5uAXi24TrUXWWn909mJbpuXXnbNM9OIffurALBlW19jGNDFS/GYJYFMpzwnfbUuVFQXcRH+k2PHq98uQxMTaAc0nS4oLovl7ndhMHcy+brxTvc/I7x6BUzcILKyvMaRTAsHSGqAGEsesRBrhriTwY2Oej6yFGXOmSu98Ovte6gVdaLTSMNV8jrK/0eYTPaSqN90JVVaG2Khui5HS0FzooVXxTJy7nvSqZkFOcUcYkkwwFlcEp4ov7APWNgTv++ZTUk/96L4QqubIBtcFc5mFTkrg31x3XZ0wC/79K4rRZkEUES+cxzkf/IqNDyUPp0BcSescmHag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A7LqdcbocKMtv2JYSc0mpiGLRBWNSRkZbXD8Hp5h54U=;
 b=Zs5wcKfWnl5aayRjNuCU0T12sa6xAKk7sCcIAxN2WN/Mi8aknptvIBHcrTzTYAoSOiVDN6Jvd505aV1HIXkbRBtJ9bPgKVxUWJuzsXXXMYYBAtjYLEa3yR1580J6Xv5gYoKTdyUTtREp1bU9+eJ+wm6BZysSiZyYfBASA03IxBGa9FiUBOe2R/bmfI8lMtQuG1krpQg3Nfzg1VbnGx88tvHWdQ5sdBbhlp3beszY2a5EIrNj7IH1D2ZK7PCzNgJdzsKlkE/EMlDwsV/k/5J67p2aGe+odz3pdV82HAzIcCV4OH7f8XzvIUjEIxMwk+fHQ9Q/z8JT/qk/LJg3YTlKUA==
Received: from TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM (2603:1096:404:8041::8)
 by TYWP286MB2729.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:24c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.24; Thu, 19 Oct
 2023 12:05:24 +0000
Received: from TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM
 ([fe80::465a:2534:4d99:a25b]) by TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM
 ([fe80::465a:2534:4d99:a25b%6]) with mapi id 15.20.6907.022; Thu, 19 Oct 2023
 12:05:24 +0000
From:   Shiji Yang <yangshiji66@outlook.com>
To:     kvalo@kernel.org
Cc:     helmut.schaa@googlemail.com, linux-wireless@vger.kernel.org,
        stf_xl@wp.pl
Subject: Re: [PATCH] wifi: rt2x00: fix rt2800 watchdog function
Date:   Thu, 19 Oct 2023 20:05:13 +0800
Message-ID: <TYAP286MB0315BFF338DEE34898A20584BCD4A@TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <169769882877.117236.15856778587852752332.kvalo@kernel.org>
References: <169769882877.117236.15856778587852752332.kvalo@kernel.org>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [86viw6Vn5dttNjyB3P9DqV97wtZ4PRy2]
X-ClientProxiedBy: TYCP286CA0065.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:31a::6) To TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:404:8041::8)
X-Microsoft-Original-Message-ID: <20231019120513.3890-1-yangshiji66@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYAP286MB0315:EE_|TYWP286MB2729:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f57ff7c-08a7-4380-5ebd-08dbd09baca8
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SwAS5PYjUq6//uIfA6B/HPWJ9Ivf+rLb+4VNjoP/2ToCIDX70XAWEAUbPgu6zOTLCSthDNgE4iaUgO6BYCquDsc17k/h/6DjG/GxOPnmnBuojp/1/nGCZC1xsoPTOnlTzq2Es3elnLD6XPudNOZupTjNt/rtF1Cj3oj6nqpkDH23cvOBXCpnyorfjNYE9dwjAZe2POcfwP/eN8Fnhj+/7kE9wdTAD1f1/tKROBIUdlN9je8j2k7p92oby8ZwpVE2sG6bDvMFWRx7OenpEdcKa9606UFFT4Ji4eLuilu22if1XpkGq5eoJysVMdNtp+5HlSQPC+5R+V8du/e0H8XjIaEiaoayWYF34/5gSObw4s3uWDXNYlKkHVzp14DRmuTg0FzzT+MaBapLXwvxhpYXsK5kfFs3fbjvAobcL7UzzVZPJYlPgHjzu7W1HOpvmFoO0D1FtQJENRR8R7GSlo47E8gONPo3yoGoC7ffK9qrNjhB9oX8fKKHsXeS45jrgluj6M7esPHGj28UjkL2q29cMkEq6Ea/vIcFAAGmcCCxlO2iAGy7l4Xk5da0NqfOR4YwEKy4HjBjezkMyw6AO8JEPJAgyou+ZBsHsqJrPNqY3QY=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?b+T9jJcpcbKg7FQ1YbiZDNVa2Jtlvg6ajBvjHZn/P20TyuyghlUDx2qrQ9HD?=
 =?us-ascii?Q?5sCutm7b772Ag7Z9Ejwlualwj4DKpob+j0ggkI0nUcuz9GkQ9oKL5Nvqq2We?=
 =?us-ascii?Q?OHaHkJGQqNuh+gpEw2KTxM94kHQJTZyC8OjA92dEj6UYq9Fk6JWTfPBzJ9SZ?=
 =?us-ascii?Q?GhrgMmo0MtJFHHveTDHxMdZnsg3mR+b+8UqgArteDt8RngJn8qEGUy99T9E8?=
 =?us-ascii?Q?ImkvMqLf3CWcWEIbDBcCHiSkGASu1PFtA59gsdLlwdm3zSNv/sJ8q8xIP+wT?=
 =?us-ascii?Q?TYvwLIEeaE9AJh33nInoKNhIu7+rDuRZYrIuBjtqrXZlDeK3a4LsSAC+k6gO?=
 =?us-ascii?Q?5ZlOh4uojbLfUDxt/w+XSuscOsm1CveWXPZWLhHFb1Ku2hDo/CF55LwWrzV5?=
 =?us-ascii?Q?ah2yv5c4tVeWcdN2znCYk+4r5oj1eqC0yUFVzHP3+f5xoYtNJelFxGn8rDNT?=
 =?us-ascii?Q?kb1aUEmSQi0e3vezro7h5n2VqQSEHVmcabdDBl7xUmVc8uOtonQFmjqcnBGG?=
 =?us-ascii?Q?kkrRbK3B8Ks8C8sdOi74UNTjHM32nxsTgrKURD9rBAHP9lMpNAdtpUU/nkxw?=
 =?us-ascii?Q?yeWtnfCInPdX/lopCSVF02bqqWrZ7UwkH/8EMjDiSmoWoi/1d56+cTRIuYAt?=
 =?us-ascii?Q?PCWmhFiZDKo/09IOLJ2Ii8oAr/uEPIinihuwbtrcqGehRzyt+c2VV24BZylD?=
 =?us-ascii?Q?Aj7/C/H1urfHelZ85itGjWlpDLNCzFusbhG6KZArlTb3cdrF2ua3Sss7oOaX?=
 =?us-ascii?Q?CPHEQLNb/qP7lYFpdvV/nlSFJL1pAy7nCjwx59uGByiYt4hOAtqWWCnXtv+q?=
 =?us-ascii?Q?X+j1libu2ZTEa/ZKvr8WvVG0LOd7rIlFvbtg/fAVFYgnlRSorSB7hcswnn40?=
 =?us-ascii?Q?dbbEtrIPNssQUtKN/Shrfrv7qNBOXB/b7txl/ynWqhYJ3dJyCJAQ6Pq5J4kw?=
 =?us-ascii?Q?oVz8afFPOYtoSl5h5Yq99hD5aERelZsIva683TLTRiNVLKQNbJSmeeht7OD6?=
 =?us-ascii?Q?RQY4VEtIaIgjRp7M96Y2PoqP9dXSVSL2+X3yWD9aI92yM1QOJ6saLBF1PIus?=
 =?us-ascii?Q?r9olktJg+Bz6O6xgESkd76H+NhkWOEgg37aZzfAsgM8by8vjlAID7N+/MIpO?=
 =?us-ascii?Q?F69hnJw/vqIcewXQxlwD4rt9a2bXVeOvl3fIHqSbNQXc1lvDt/fUQ0XMAU65?=
 =?us-ascii?Q?aWnA0+4Thgi5NVxs80FST6tGrYKPpaj67P0DNF5qDb1jE/daAo0uSp71ugE?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f57ff7c-08a7-4380-5ebd-08dbd09baca8
X-MS-Exchange-CrossTenant-AuthSource: TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 12:05:24.3163
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWP286MB2729
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, 19 Oct 2023 07:00:30 +0000, Kalle Valo wrote:

>Shiji Yang <yangshiji66@outlook.com> wrote:
>
>> The watchdog function is broken on rt2800 series SoCs. This patch
>> fixes the incorrect watchdog logic to make it work again.
>> 
>> 1. Update current wdt queue index if it's not equal to the previous
>>    index. Watchdog compares the current and previous queue index to
>>    judge if the queue hung.
>> 2. Make sure hung_{rx,tx} 'true' status won't be override by the
>>    normal queue. Any queue hangs should trigger a reset action.
>> 3. Clear the watchdog counter of all queues before resetting the
>>    hardware. This change may help to avoid the reset loop.
>> 4. Change hang check function return type to bool as we only need
>>    to return two status, yes or no.
>> 
>> Signed-off-by: Shiji Yang <yangshiji66@outlook.com>
>
>Is this patch ok to take?


Hi! I think it's ready. I've been testing it for a few weeks.

>
>-- 
>https://patchwork.kernel.org/project/linux-wireless/patch/TYAP286MB0315BC1D83D31154924F0D39BCD1A@TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM/
>
>https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
>

Regards,
Shiji Yang
