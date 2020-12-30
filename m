Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AF572E7A29
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Dec 2020 16:03:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726356AbgL3PDA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 30 Dec 2020 10:03:00 -0500
Received: from mail-eopbgr140077.outbound.protection.outlook.com ([40.107.14.77]:50877
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726336AbgL3PDA (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 30 Dec 2020 10:03:00 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B7gbi0nguQC+I/Mt5i7DLWHLDAy+L9oUJFAUpc786eOOt8FhuSvCI5W60MCbPoLyX5cabjteoB4o3AQgj9cEsiurRCFbs5t2n8w+mY/gzZH9J7bC192B8O6a9Nsv2pcSwBk4HNjjNbXa/uYmNPKfmZr1Ng/efx8PdexccDT2chu/F681JicVhKCLEZfy8goJjbQKNpNdxzc732DcUTQHdVxdOy6sSahX000XR+ASKSdZeD7FS6xIygLGzEl+2gEvw1D/C0c2ZjYrU7Zqz4Iv1Cm1iaRcopXwzBI4p8fNanlarOFr5IcsDm3wW9qYNwN5393+qyqIxUIVPbaQ+AJv/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TP3MV3jUssifsedqIz0OrrVi+O1nhGemqybQfGneOLo=;
 b=R5v1K8cdJaiGS5TbiIk1SZ6TOuaL3IDxij7qZMkdYI1Q82JI1HPJWlRSwVhskHzNS7WJ9wRlHh42iMUlVlvxpiaaYBYhHsDQVG/RwOQYm5REeu82lN2O5Fu3TMmC3D8k0ekxQ125SqP1Fl0BBbyjKwqiNBfeA975xZm6gNpTEcgZ2zjDDZ33WYyUVy8Mw41Rqjnd0/OVD0GvjqY55HEPUw/pG0oChCvkBtZNmgT95If8dbu5rJ493G9E+VeHrHoVhut4LSf4ORjjYaTGaKh9iyYDUkB8f0gfQhkBzNzE+w+rO3tNAAHrI3DnCmPyUIfKiFmrstq85Rfk+fggSad53Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TP3MV3jUssifsedqIz0OrrVi+O1nhGemqybQfGneOLo=;
 b=RNDMbOLm7jLP4E8fan2VJ2cRIz48mxYl1ri3Drx6I+kYm8GZA7iZ2ZFiAZHdqQzyZX9MtR3eC8gPwXGMQ5SSDjlTGEfZw5ERvFN95IJNSLrrJ4+qnV6roRlCuJGtqWP7gSzbLI0X5Ja64HQ+pLBgufvVjAlVgtiw3MBPZwRLjuY=
Authentication-Results: lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=none action=none
 header.from=celeno.com;
Received: from VI1P192MB0479.EURP192.PROD.OUTLOOK.COM (2603:10a6:803:38::31)
 by VE1P192MB0718.EURP192.PROD.OUTLOOK.COM (2603:10a6:800:148::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3721.20; Wed, 30 Dec
 2020 15:02:11 +0000
Received: from VI1P192MB0479.EURP192.PROD.OUTLOOK.COM
 ([fe80::5d66:44ad:84ff:3fbf]) by VI1P192MB0479.EURP192.PROD.OUTLOOK.COM
 ([fe80::5d66:44ad:84ff:3fbf%5]) with mapi id 15.20.3700.031; Wed, 30 Dec 2020
 15:02:11 +0000
Subject: Re: [PATCH] wireless: fix wrong 160/80+80 MHz setting
To:     Wen Gong <wgong@codeaurora.org>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org, aviad.brikman@celeno.com,
        eliav.farber@celeno.com, linux-wireless-owner@vger.kernel.org,
        ath11k@lists.infradead.org
References: <20200826143139.25976-1-shay.bar@celeno.com>
 <34893f267fa37b43d21c19d4c08c090e@codeaurora.org>
From:   Shay Bar <shay.bar@celeno.com>
Message-ID: <212736b1-43eb-a27d-c83d-68f669c8d9df@celeno.com>
Date:   Wed, 30 Dec 2020 17:02:06 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
In-Reply-To: <34893f267fa37b43d21c19d4c08c090e@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [87.70.56.235]
X-ClientProxiedBy: LNXP265CA0070.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5d::34) To VI1P192MB0479.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:803:38::31)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.0.0.13] (87.70.56.235) by LNXP265CA0070.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:5d::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3721.20 via Frontend Transport; Wed, 30 Dec 2020 15:02:09 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d0254f23-9ec6-431e-7618-08d8acd3e28b
X-MS-TrafficTypeDiagnostic: VE1P192MB0718:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VE1P192MB0718D2DF6DFF7F75AAEB2883E7D70@VE1P192MB0718.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kW3SUI+EPFtS8F1EAgwpy7LRMmtb2vJNcXSu/P9n9Q2EYgXAVmIsMh/ir8BUqKrtx9jIQPb073q9mBNqEa7wcs2V451fYYQPzKTfoHSfHaJuXweLQWm+cWa2tOs2pP4ynaOyj+T7Gi8Zh8d3aALlAU/OkPtvVAKBDoCMi5QmmhRNrUl/9sKpwQR8x4frJBfHoBBh45q72n9aj7/ZxibmGJxeyDVzbpx1MHBD1Nff7k1UCSNqZOJRHKJ8bHX1sXEXnye4yJifRrEsCCr6Od1bwmvFNiKhoYwiNWJnzOmeeJHnQRHsj6RLMFdollfe4j7iCOfSGxAHqfMhFbPXxXZNJOZOGiSWZmZZjd/Wn356hWeAEqrzXNFhsTIHzgNNfXS7UOL9Xxk/q2ciuWsgFn/hh4CJb5912HYoUMaoA5wwnRoH0e8G4YGj+olZI2BLeIv+m2VJpz6qKsgbStwNx9s9EBEEI1U6MyYk8psoNFQaE2s=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1P192MB0479.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(366004)(39840400004)(396003)(346002)(136003)(376002)(8676002)(478600001)(44832011)(66556008)(66476007)(66946007)(4326008)(6666004)(2906002)(956004)(6916009)(4744005)(52116002)(2616005)(31686004)(83380400001)(186003)(26005)(16526019)(53546011)(5660300002)(16576012)(8936002)(316002)(6486002)(86362001)(36756003)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?NHZseXU2YUZ3QUFwT0hQcHY4cWwzSjJ6OVdmQk5HTmtVaGFvTUZqOGF3OEI3?=
 =?utf-8?B?c1B2citYKzgwVjhYQWZtajZBQVZqRHJYK0gxWVJZdTd3dnNMOGwxcWRMTjh1?=
 =?utf-8?B?YzM2WUREaExVMEhpcVN0ai9hTHFvV0Njc3RSTkQvSlVyZHpWL0dwTWNFbmlS?=
 =?utf-8?B?TEFDa2J6ekVQdHBZRCtaRFh3YTdXdERaV1BsdXgvRnZJeGI1Uk5rdnRFTXJi?=
 =?utf-8?B?THl5ajBzR1laR085NlFFYXZLbmJnMi9YT3ZqcEpOaU1PNm5pZVh6WXpFZDlC?=
 =?utf-8?B?R3hPeXpKN3BsQjlhMmV5SlNNUmxRV0piQ3owMS9Hb3ZNZ0FIc3Vab0lzMGFW?=
 =?utf-8?B?S01uOWdlVElHcHhSTHRvcHFyaTVhc0IraUNjK2hVeFFBTkJpK2dITGhWaEZJ?=
 =?utf-8?B?eWlSYUs1MEU5VU03Nno0dmFQTExyV0ZoNGJMMEN5ajh6c0ZKdDJaRkpXZkIz?=
 =?utf-8?B?VHlSWS9xVGR3T1pYSlhLclFYcWdaUGFsWEJsckJvWFBHTUc5RU15S3lOS1pk?=
 =?utf-8?B?YXhvTTF5eFVSZkwvRERKSXpPa2g4bDI2dVdtTUExbFZEUFJiSzJKVkJMckRa?=
 =?utf-8?B?VWZnNlRMODhSTHl4QTlQSkNtOExqdkJKY09zZHNOb2NzZWxYQlVNM01lOEE2?=
 =?utf-8?B?TVliRmt2eE1kTk1wVkFLWEJPcFJpdElNQU1tRDVyTkRNZTJTS0xJVDZRNkMy?=
 =?utf-8?B?Yks2ekFhaGFKTUtHNTdsSkFoWjlLNThBRHJhcWNJVXpmVzUrQ2R4ZVRIUG1J?=
 =?utf-8?B?OE5ZTlM3UFdqV2kwRzRIRzdHNjE1LzVXVEp1T0hyRGdnWUs5T0lEY2lqQ1hx?=
 =?utf-8?B?V2d1UHpobkphcy9Kdkk3d0JzSi9aeXBVUXltVGcyTnNweVZLWXpaTXhrSG56?=
 =?utf-8?B?OVNza1RtQTROMUdEUlQ2b21WRnBXUHFYZGtLaHJxRHU2bG5DUlJWQU5FanJP?=
 =?utf-8?B?ZGJyUExPRWlsZXluNnRtZGgyb3NSbVNxcWt1Qk1Nb21qOTFvRE14Nk1Zd2JJ?=
 =?utf-8?B?WXkvanEzVk1Dc2RvdUthSGdVZVYvaVhJeHBMUFFsREFzcVlVa0hGTGFXYnVS?=
 =?utf-8?B?aTFKdGtXcVFsd0lrNzZ2dzJxV1AvUElZbXRRcUtXYVBTN3hYdzh2aWo4Tkht?=
 =?utf-8?B?d2JaY0ZnekxKMWRSOEdBWkQySUVOWkptQy9oMCtYcjg5SmVKc1QxMVJpYkJy?=
 =?utf-8?B?VytpSTRlcWp4S2pzMkRLbVpteG5abW5BcEl3cGlnUEdibnFXWFdjWHFKUExC?=
 =?utf-8?B?clk1MTZrNmVEMDNTUFlzRWNybkM3OEV1NkRqQ0RsQjNTdi9Jek9ZYTAxT2lo?=
 =?utf-8?Q?AC77nT50LN2IMrvzL+rm0BzAVxMBsxEbG5?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-AuthSource: VI1P192MB0479.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Dec 2020 15:02:11.0443
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-Network-Message-Id: d0254f23-9ec6-431e-7618-08d8acd3e28b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0XKEpSS1zhEPyCeiZezB/E3IcAWWKDNAYAnKiuPED+k1vuxOYmJHrLpCrzaYv0+M7uVDoIuOPBSW2+I+0uXG7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1P192MB0718
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


On 30/12/2020 12:57, Wen Gong wrote:
>
> On 2020-08-26 22:31, Shay Bar wrote:
>> Fix cfg80211_chandef_usable():
>> consider IEEE80211_VHT_CAP_EXT_NSS_BW when verifying 160/80+80 MHz.
>>
> When station with below 2 bit and connect to a 160MHZ 11ac mode AP, it
> will try to use 160Mhz width after this patch,
> but it does not support 160M in fact according spec of IEEE 802.11
> .... .... .... .... .... .... .... 00.. = Supported Channel Width Set:
> Neither 160MHz nor 80+80 supported (0x0)
> 01.. .... .... .... .... .... .... .... = Extended NSS BW Support: 0x1
>
> refer to spec of IEEE 802.11.
> Table 9-250—Setting of the Supported Channel Width Set subfield and
> Extended NSS BW Support subfield at a STA transmitting the VHT
> Capabilities Information field
> value of the 160Mhz is 1/2 in the table for upper configure.
> NOTE 2—1/2× or 3/4× Max VHT NSS support might end up being 0, indicating
> no support.
>

You mean for AP's with 1 SS for example ?

