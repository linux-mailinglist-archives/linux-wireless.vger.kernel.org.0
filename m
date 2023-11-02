Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B0FF7DF33A
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Nov 2023 14:06:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347434AbjKBNGm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 2 Nov 2023 09:06:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344822AbjKBNGl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 2 Nov 2023 09:06:41 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01olkn2036.outbound.protection.outlook.com [40.92.99.36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC1EE112
        for <linux-wireless@vger.kernel.org>; Thu,  2 Nov 2023 06:06:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xgnh/s99oZH3eY52nSwoGywVR+0NkfR4zxLOKcI6wKICHxp1a9La3ww4fhL6pSGXr8HWGKfhIb+bCtY9Zz7G++WGnnshWY5IDDkESy08/gufk82Q+icRKU/jMx1qPZp5AP6HEt4FDD5SRrmMajVu4Lpba3JtEg5AlAmAVHVUuQ0EBWsQs1L7S3oKOLKCnNCJvEjoECXorZznXr5VZrvrIEA+A0hzKTm9NnN+n7p6M+IYKoyepbQ7hla6CW6NGZf8B1cdhEgOqRP8UT08fAGNFcRgTanqU/VLd1pPJpNAZaqXjAX4K5NoK9LvAlTCa8z0l+CPjsZieoxfwhUkx9e2uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3/7ycuyr+h22gPUmIIC0myl+8XYOgn7QClVrSeDzeiY=;
 b=guJzKGSS0JM5tdY/FMSSeUJ+TZUS+a9SCzutzwg4mjzwAg2/vO6Ivv8bpV90QbadEwe2lVE/1EnWDGshqN1HWL9vFhEofMKle7Mudy6lnd2mZKxR4IeWmUQ8Cw+KuOrDIMeV+7wg+5g+4oBgIJfeh29nbgGIzRTZiWfivI/efMYQ2nYP+c5wfgX6CbnBu08C7qZnCdRmS6qYdZ4LK31MNMPwgihy6TS4KAMHGHH3lXKJ1IJY14zar5vXsL7t4o32cWf0h6vsvn2Zeb8Cd0aVExfc65ujkPocXytNB6x8KBURK136JMvzwXwjOs1psGUSlufR5Bztpqu85seo1rdX/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3/7ycuyr+h22gPUmIIC0myl+8XYOgn7QClVrSeDzeiY=;
 b=ZQGHg5JZZiszdGor9nm/BP3hrK0DMjATLPnjIx0KFazK9v1/NA/iNRzhh+gvI2+tp3/0Ffy7QBNDpPcEIaAg5uPcWK46887+fO2NJ39Pz9BKVBdbKNQzhOWufvVFgvLSInvx6ZMIJKHkEx2mYKbGAEEcLLOVXd8H1DuChSwM0DSiK8kwU2pt4XHgWOyZc0/Pqavd7qFafn9bvv2q2lPyXM5ha8FQWdZDPz0BNzmvFifurzY6yz1vz7gVFhfdlyLDtopTTJZZdMd4tUJe50FaFj+LmK9SrCxn9wlqpjNLZPcgeW7dKrG8tjX1jIfpNs7gzxzLCIg5EET3FVjjeL9ZRQ==
Received: from TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM (2603:1096:404:8041::8)
 by OS3P286MB3242.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:207::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.21; Thu, 2 Nov
 2023 13:06:36 +0000
Received: from TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM
 ([fe80::465a:2534:4d99:a25b]) by TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM
 ([fe80::465a:2534:4d99:a25b%6]) with mapi id 15.20.6954.019; Thu, 2 Nov 2023
 13:06:36 +0000
From:   Shiji Yang <yangshiji66@outlook.com>
To:     stf_xl@wp.pl
Cc:     kvalo@kernel.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH 1/3] wifi: rt2x00: introduce DMA busy check watchdog for rt2800
Date:   Thu,  2 Nov 2023 21:06:17 +0800
Message-ID: <TYAP286MB0315AE5107EA8E7E702EB94BBCA6A@TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231101155655.GA559463@wp.pl>
References: <20231101155655.GA559463@wp.pl>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [7A3daMPNMPdOztqUOtBYDcwe0dgBe8IW]
X-ClientProxiedBy: TYCP286CA0092.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b4::10) To TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:404:8041::8)
X-Microsoft-Original-Message-ID: <20231102130617.6944-1-yangshiji66@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYAP286MB0315:EE_|OS3P286MB3242:EE_
X-MS-Office365-Filtering-Correlation-Id: 43a8f52c-c9a3-491b-1ef5-08dbdba48a74
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bg03yw6RBlVqC8Mb9EDkCLwzXaO3aX1RCSBEyQm2iRJTIYFhRz3OxJRIo2Np/jLNu69fXeqZYygiTByhY1ccybxo5CmaH9SZKQW/90uqZrulSzFkj/8ljUAQlxAkIjnqJLsPdahvkNAMvQPwTFEiP9eDHKXHFaxgmQl1f2w0p0hOIjN3BO8cDIBhTkb+czfn4pakmGxQBQi16BRycGRXfeFdzQ7nRK5CybN/1BY/WrH3RBIIyGS7mgx4JLIhtxAfFM7xj1YKDjG/uOIDZZHT5FSQscTGfv2fri8XsDT/mrNfcnmQKfvqvC/SVQSogUISscCQ21zbNHSp7x1DapH48BxlunFR++rZbweJP9xOxjAXlZpUsS+y4h3b99706bcZ2FOa00USoTrHDqOsY1zcVN8eDEmh0W8+Cuu1DDdfKbpD0zWcfDp/DPwhvmBMEtH7y77Phgf0bduoRTBasFU1p0ORLRvqDEmz2FTXkm7zMd/QCspendDkLQNHY3a7ltF3PA31HovN320HPOH9n4B4Zh9ITH6X1mqLBlVX2C6rcH1LqlxAG4Iknbzvm4qllTQs
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PseJ7I+u1Oer2ochrqQ7/LmmF1A4MEpCIre0NB5/fSRRoGwpzAyDegiI3K+B?=
 =?us-ascii?Q?0dr7pvymERFzpqlj4RUs/dbJmn1CoqmRxoiiBwQTlvq20p1uG+6Gdp6RqEXI?=
 =?us-ascii?Q?+bzi098qDPl+ADL0jtbgSBH3iZdaCjmz7K8q4zz9JGGTiGjjpB55DMEUM4jg?=
 =?us-ascii?Q?ppFXwdm2tJ+NCI+AMTrXBGu4voOouYjj+VNYkhJnFnrj/xJve98lyeeZxbOJ?=
 =?us-ascii?Q?5ssAsXuy+3tE/KlhYgXa1wvSMqP7B6G1niGqcmbaLAw6C70HYKdFU0PPo2/M?=
 =?us-ascii?Q?b/hOVxcChXW2U8p3vMS6Cqbbvvm0ThjpMgn1xxoBIYsm1DiNinAE3GgTTxNu?=
 =?us-ascii?Q?ZqFfnu0Ltwg3jUDC2nFrudXle+WyLWoEMzjCHdrlfNXNiIg661LsveRILYMl?=
 =?us-ascii?Q?wTG9Wp3etqfw4nBiSR7X4oiaO4lLctzOdCnM9ajrF6bcSoHZsuJh6fkGvgtK?=
 =?us-ascii?Q?bja5KYsHeiTzLqUBvHTtTOVXFjcc9w/omRUdcJo8PNIi2nOe6+h7yKHI7vB9?=
 =?us-ascii?Q?fIZZltLj/BSDVPUYJW1gzr/obdzEW8PBben1THu6opDOC+zK2ROQYesFWa1P?=
 =?us-ascii?Q?uAWgKZNWr8tEQqR+DEaXZjq3w/8WqjlCndGj9QzEh3f8WKZI5jsMtzRbALd0?=
 =?us-ascii?Q?DZNHqJnFxuVNUc5+K6CIExa+qZ2HjbEEW1v8NVAluWHVHA2AJ48C4DFrFBzu?=
 =?us-ascii?Q?Q3O/xNLeOBdcLlbeGISQ521bPGHchP4ekIQWkpy7N8dlCUxHFfzmsxbARJYb?=
 =?us-ascii?Q?MZRtv10sB7gq12v1+VxbtkY0Qdj7QMoojbTRfxgQ+o0BNineevPXvgDWxXSH?=
 =?us-ascii?Q?dsIhUf8jBMrPQjSSZvvq/enDptgrXkai4AIdltVYDHGXgxErFrJ4SYUMm4wA?=
 =?us-ascii?Q?pfjwrqKyo7Glmimh2bpk8XgZUUZcTCRcmRPZe7Cpm7bqdN3dgsb6Ez+Tbf9t?=
 =?us-ascii?Q?w0oOM8XIcgzLVZj/MKQXxhi6zrQFkJUbsQIOAWkw50J8mvZ0iMldsMrZABbH?=
 =?us-ascii?Q?RQoAoyQ4ljQdP0Ur6QQVm1qwWQnCGTFIVua9iYMdh0cCZD1l87yuGTrDh+oP?=
 =?us-ascii?Q?nzMGpS2GKoan7QjGm53dw5IFzvf+zNx+uIIEedbUMsk5YM2lM85QuqRTrCwc?=
 =?us-ascii?Q?kKVA5dFeVT4fEJdgBUeTkDW0GOmb2JtpEuk0SUPKF3zHIQO0Pee0OR5lLwex?=
 =?us-ascii?Q?fPbwN78Lv/+Iw3Z/JHPyp4bzDZbHMxZK3AN0tlz23KtqqI+5zAPwFM7nHoE?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43a8f52c-c9a3-491b-1ef5-08dbdba48a74
X-MS-Exchange-CrossTenant-AuthSource: TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2023 13:06:36.0479
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3P286MB3242
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, 1 Nov 2023 16:56:55 +0100, Stanislaw Gruszka wrote:

>On Sat, Oct 28, 2023 at 08:15:30PM +0800, Shiji Yang wrote:
>> When I tried to fix the watchdog of rt2800, I found that sometimes
>> the watchdog could not reset the hung device. This is because the
>> queue did not completely stop, it just became very slow. The Mediatek
>> vendor driver for the new chips (MT7603/MT7612) has a DMA busy
>> watchdog to detect device hangs by checking DMA busy status. This
>> implementation is something similar to it. To reduce unnecessary
>> watchdog reset, we can check the INT_STATUS register together as I
>> found that when the radio hung, the RX/TX coherent interrupt will
>> always stuck at triggered state.
>> 
>> This patch also changes the watchdog module parameters to the new
>> 'hang_watchdog' and 'dma_busy_watchdog' so that we can control them
>> separately. That's because they may have different behavior on
>> specific chip.
>> 
>> This watchdog function is a slight schedule and it won't affect the
>> WiFi transmission speed. Watchdog can help the driver automatically
>> recover from the abnormal state. So I think it should be default on.
>> Anyway it can be disabled by module parameter 'dma_busy_watchdog=0'.
>> 
>> Tested on MT7620 and RT5350.
>
>I think this will not work on USB as INT_SOURCE_CSR is mmio/pci
>specific. Did you tested on USB ? Or this is disabled for USB by
>default? 


Hi! Thanks for your information. I didn't realize that they have such
difference. I don't have Ralink USB NIC so I only test it on RT5350
and MT7620. I'll disable it for USB devices in v2.

>
>> Signed-off-by: Shiji Yang <yangshiji66@outlook.com>
>> ---
>>  .../net/wireless/ralink/rt2x00/rt2800lib.c    | 81 ++++++++++++++++---
>>  drivers/net/wireless/ralink/rt2x00/rt2x00.h   |  3 +
>>  2 files changed, 72 insertions(+), 12 deletions(-)
>> 
>> diff --git a/drivers/net/wireless/ralink/rt2x00/rt2800lib.c b/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
>> index 594dd3d9f..6ca2f2c23 100644
>> --- a/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
>> +++ b/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
>> @@ -30,9 +30,15 @@
>>  #include "rt2800lib.h"
>>  #include "rt2800.h"
>>  
>> -static bool modparam_watchdog;
>> -module_param_named(watchdog, modparam_watchdog, bool, S_IRUGO);
>> -MODULE_PARM_DESC(watchdog, "Enable watchdog to detect tx/rx hangs and reset hardware if detected");
>> +static bool modparam_dma_wdt = true;
>> +module_param_named(dma_busy_watchdog, modparam_dma_wdt, bool, 0444);
>> +MODULE_PARM_DESC(dma_busy_watchdog, "Enable watchdog to detect tx/rx"
>> +		 " DMA busy and reset hardware if detected");
>> +
>> +static bool modparam_hang_wdt;
>> +module_param_named(hang_watchdog, modparam_hang_wdt, bool, 0444);
>> +MODULE_PARM_DESC(hang_watchdog, "Enable watchdog to detect tx/rx hangs"
>> +		 " and reset hardware if detected");
>
>Do not have strong opinion here. But please consider to keep old module
>parameter name and make it bitmask, 1 - hang_wdt, 2 dma_wdt, 3 - both.
>Such way, it will keep old meaning if someone is using the parameter in
>script/config.  


I'll update them in v2. Thanks.

>
>I also wandering if we need two implementations. If dma 
>hang detection is superior, it should replace the old one IMHO.
>Or queue hang should be used for USB and dma hang for pci/mmio ? 


Since the DMA busy watchdog will be disabled for USB NICs in v2,
so I think we still need both of them. As for queue hang issue,
To be honest, I never really encounter it on MT7620 in past half
year. Enabling queue hang watchdog just report some wrong resets
for me even when I increased the threshold from 16 to 64. And the
large threshold will make it unable to catch the DMA hung issue.
Anyway, it should be still valuable for USB device.

>
>Otherwise code looks fine/correct to me. 
>
>Regards
>Stanislaw
