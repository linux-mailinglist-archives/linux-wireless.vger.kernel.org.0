Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AE136378F4
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Nov 2022 13:36:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229507AbiKXMf7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 24 Nov 2022 07:35:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiKXMf6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 24 Nov 2022 07:35:58 -0500
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01olkn2074.outbound.protection.outlook.com [40.92.98.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7849488B7C
        for <linux-wireless@vger.kernel.org>; Thu, 24 Nov 2022 04:35:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g83UXizJyISbW/E1vYgVhlK4MeNYocw67Ge/owSAELSF+tm0ITIjxFBPb35k+LyHPsEpQxTY5KcDqb2Hlw7XLPlsZltspr3XF1eEuRYpbJ8qPuIIQAsGb6SyzXzxIe8sVC2ucQXb9t+W61ZKJPCdP0Vu8yhLSa7jyfQAM8rAM1NBlyUQIKA23oIcscHEfiraF+HfzVsgb+apZXjHHhSDuJo5mIC0sYjAJ6Ip4BOI3rO5lGkeEEkigSx/qTQpQvAQ2gsdVaaVyOdmW55OeYm24xdnHRjQFvQmDlTBGBBQ5WUN1TVk4rdCSJe3G5z6ruGNP5q9Moe1aOY1X4VaYMEN3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QwBuxs7p2F6syQf427yTFUdrXg9Cnxgoaz2JXIplTPE=;
 b=kfXhoL5aIV8eFDXg/ysJkqjffRtjHTwOaR62hJnQ3z3cpUVnK1G7YA3VVKojgoIiKfSLu3VWG4SvxgyLqR8NLmV+JwbMxRUQadUhiA4qw0+IQzQJE/0XqDsnYVJDpj028fsGdSlfuJ9G8rQtM4Du/KQo4T6kOB3wkw2tld40G7XHpiOo/phN18g/9Es2nsEBzBSBKoACSqlFJ1O4MVjjn1wXT3LBcyJ+q7TiZvJwPSxDggLU65xpVsxS7GgeLnKhp4fkGqVslwx+ozn0Q9sUpWFNMxZsUmRqW7Lf/wI4Q+LauHhLarJb4sTkAe+IVmplXz1k4eBTZYMzKGeEM5Nm3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QwBuxs7p2F6syQf427yTFUdrXg9Cnxgoaz2JXIplTPE=;
 b=YEDxHigwV9m+VsmKIN11Zi2S831f0iW2Gu6ZJ2cHg1C7dJmbmX5mmuylENywHtKlBDUanKn3/lGaYaVuJM0sFXPEEJiDVfToktL4y7OoHzEIfPPS2Y4maz+9S4VGSZRscpXVr6qcqihoHtgDs/WenYOLX8p9NTchaKqVJRQxzrAvj6wIhwXDodBwJgicqZ6vEt1VejcqjpCqVhYh9c9k4kNZka/rwfMNGoJb4HzkoI0H8286Ae5vP+NATKF9el6BClfel1zMDeMIGRVaUnqn5c+2icGDxkzmsQLuZqS9ogu6Mm4c1uIncHGV2O8EfyWImxzMCPWUHCymXQwAs9K6Og==
Received: from TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:252::12)
 by OS3P286MB2600.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:1fb::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.19; Thu, 24 Nov
 2022 12:35:55 +0000
Received: from TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 ([fe80::3b28:a466:3ae7:876e]) by TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 ([fe80::3b28:a466:3ae7:876e%7]) with mapi id 15.20.5857.018; Thu, 24 Nov 2022
 12:35:55 +0000
Date:   Thu, 24 Nov 2022 20:35:47 +0800
From:   Shengyu Qu <wiagn233@outlook.com>
To:     Andy Green <andy@warmcat.com>,
        Arend van Spriel <arend.vanspriel@broadcom.com>
CC:     franky.lin@broadcom.com, linux-wireless@vger.kernel.org
Subject: Re: AP6275 / bcm43752 pcie on mainline brcmf
In-Reply-To: <f80c4a64-d987-0f59-418d-adf419fcb054@warmcat.com>
References: <TY3P286MB26114DD461F50814980453E598029@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM> <08416710-655a-c87c-a599-3fe2563f7de4@warmcat.com> <18470a1e910.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com> <TY3P286MB26115A58795F264893CCB40198029@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM> <184720fc920.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com> <TY3P286MB26118BD94839F752CADCCF5298079@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM> <625f1d5d-e137-7ad7-96b9-92035e87df8b@broadcom.com> <638afa8e-a393-410c-3182-0d8e9b6da17d@warmcat.com> <1848793db88.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com> <3a562a50-0cef-4879-3691-3258596f5213@warmcat.com> <1cbb3bf5-fd70-e9db-2405-640178862857@broadcom.com> <6c3f592e-3e20-edef-ce7a-cde8988eef2d@warmcat.com> <9fe8caec-453a-28c1-04d3-5966200b8db1@broadcom.com> <f80c4a64-d987-0f59-418d-adf419fcb054@warmcat.com>
Message-ID: <TY3P286MB2611EE62F08BAD5BE66BB284980F9@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-TMN:  [XKvzmpL2mtJgRh/4r01KQm/ambrCBqM4]
X-ClientProxiedBy: SI2PR02CA0022.apcprd02.prod.outlook.com
 (2603:1096:4:195::23) To TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:252::12)
X-Microsoft-Original-Message-ID: <B50CA27F-27D7-4FBB-AF5C-66824272DFDA@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY3P286MB2611:EE_|OS3P286MB2600:EE_
X-MS-Office365-Filtering-Correlation-Id: 09663288-b0e1-46f1-eccf-08dace186d33
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FAQ3sdtHMap86yQ8XlIzaxLcVgHfl/Mey3v0aCln2MjsSJNUYmhBU7d1/8XRypyaKhzEZMJ7L5oX8NffkKr5kEJOe861fzxeg10FMobyC2cZ8GTk/k1T0FxHfcPaYtDkcl5aM+09QeiirH4Up9E23YIhdg61/5a2e9oWu9RpypcSJiAjYNg3a5hrhsDCaZNyOhQeNkgCQwBiEJW7sMKOdhD+Pvq+Ked7AljLgoT3k/8kVf/6gCHHdjt8F5B6bPA2yiXyPhXk5c/OqQy4y9d16xcjkUd+/n2LHDB0XpuLzWK+wmaFDgc2eDkjWhlzzHIuLQ1HAXknFQRy8Sfhnchq6y3UVYenhm6exRk+JF0yEnDDOdNabb3ke+P7vqfe59F/8XsFdBBr/eP9D1wAubxdeIy6O8bBBr96w10XX2BUdirQ8XESGsHsC+XxXvvtLlZZkKIBIqB1LbGKANVsl97mGOiD0XGN3DTZ35Vo29GY+7wbczkhavaXAEoTgwL2oeVjGm6gBhPKPEYTYaTgUDXemlwCzC/EVq1JZfUjkB7yPvJmAjqeAUw/8mDoM7xpxClwUOG/LI8smUw7rjveCk9wcKtburTBe+xr/27pEiaBRqqBR4dcUvh58460Bob8idCBKIjxCZV/aDA/PlzQIYwy5w==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K1AwZ3RvTHpWL0J5MkJJYUV6eUNZVnNiNEV2VEFKQ0lyZlk0ZER6QXN4R2xt?=
 =?utf-8?B?RnMvZk55Z2NmNERseWtLZHhGcm9ldXVYdkt1REgzT0llWlozOFpPQ1Rnbmc2?=
 =?utf-8?B?ZnBtYlVKaStxQWZlcjRXd2RZbVk2UDN6SzVXa1JNb3dtMDFFUk9sSzBEajBh?=
 =?utf-8?B?eDhONitEZFk4MGNNbllmYWMrY0hjdkI5MGh1eVcrcUhHY2lCMWl2TEM4QkRm?=
 =?utf-8?B?Z1pyVWszYTVLdWhiRXEzdmk0LzNHTEZrQlZvSFhQYzM1eFk4b2ZRSkVBMlY2?=
 =?utf-8?B?bm84OHJWQ3I3REZ4YmE1Z1VzTFB1RVFnTGQ0dlg2UGUyMWhSSHdSMloxU1l2?=
 =?utf-8?B?VlU2R1lvNnZSQi9YODN2aTFGSHpQUklWeUdBSHY2QXB5ZlFPdllab1B4bDhZ?=
 =?utf-8?B?U2o3eTBlSWFiZ0tLMXRLSlRCTjZwTnN3K1YwWTBTL1lKcWNUQmJ1U01PTnYw?=
 =?utf-8?B?QThybVUzdVhhb2c2c1lvVFVWVjJVSlF6N3dJQnU2ODduazJtUHY1Y2Y4OE14?=
 =?utf-8?B?bUVpTE1KZ0FVTmJwaFd2Wmh0eGl2RHdNdERtYkM5VXFOQVBMOWJRV3I5SExZ?=
 =?utf-8?B?VVRLTmNhc0VILzNFajBiNWwrcXVZZzFpQnRlZHNxbTJWZzNGR0YwVzlMZzhH?=
 =?utf-8?B?cVd1RmNpMmhzMU9CNkVGczE1YTJwY0xrNkxoRGxDQWlEcG5jVFpUQllqWGFp?=
 =?utf-8?B?K2FJZ2NCbC9WdHd0N1dXWkxNbVNWVWRrdXVSTkNjaTBXRzZxS3prRUpOZVpG?=
 =?utf-8?B?WEdEVzJ3VkxiMTFlcU80VHRLYUVvUlhSUFYrOTROUDl1WUkxTjYxcnpHMjlz?=
 =?utf-8?B?N3o2bzBIRGR2NmlzOXN3YWprWlI4N0RaTUNSdGZ2bEpkYmtFdnBscG15aGxF?=
 =?utf-8?B?ZlNCWnNhVVZ2K0hxQWgrVmgxWm9UUnA0K0V0N2dnZmttbXlhVEVVS3gzMXB6?=
 =?utf-8?B?OWU1WEowU2cwZjBkL01yaTl2dldUL1F5RERyOE1WTTlyRXYreUI0MkZaR3Fp?=
 =?utf-8?B?cVZDSWwySGJZbXgzbmlnMnRXeFV5VkpYcThmdHBtZWVWb2F4NVRaU3ExSERF?=
 =?utf-8?B?MUJDMTU4cGpIZTdXamZtN1ZrdUZUM2RncEEvRDJmRlZ2RC9zYmx6SGpUeEpF?=
 =?utf-8?B?L0RVZWNRRlEybFFybnNCU2tmRmNkNGdtaXFwZVl4RndiekxCdFBQTHBKb0xW?=
 =?utf-8?B?M0tuSmE1ZmkzSHcxdnk3Z1FiUjVCTnBTUlA1VUVJaW8vWjlBeUoyYm5EZjRO?=
 =?utf-8?B?VXJVZ2ZJa0JMNVBJSVAvT3BhdS8rc2Rob1BvZVdHY2doaHpiWnczdGVYVXJk?=
 =?utf-8?B?WnN0SjBtczhjY0dMbUVZZklGclRZYXhhZWJ0TXc4b3NQQjlHK29kYStUMzlZ?=
 =?utf-8?B?TTE3a052R2grUWpNODhDRTlQNFJiLzljRlpHb1FtQit4SDE0THdNZjQ4cDNH?=
 =?utf-8?B?RlFUd1g1V0RQT20zTVNBUWE5clYzU2p6c2NMVTJ1V0hJT0FNOUYwR3kyUFZE?=
 =?utf-8?B?SWpsdE1ZQzdic25lV0JaZ0x0SWwxOWVCaElxcHFLaFpRcnFueFd0dkZOQ21T?=
 =?utf-8?B?aXpZczlHT3NpL0VkK3B0WGVRejFTa0oxdXFyaUc3cUgwWlI3ZC9mTzVlOWM0?=
 =?utf-8?B?bGZrVHV5YU9HY0l1WHpNSmdRRlIwRmcrWVI5c0RvRXJKdGxlMHo3ZU93Ri9w?=
 =?utf-8?B?cklHcFovSEhIRGIvaGVCM3oyclpIV0RHbUprcjRQbXZYemh1WVZGZlBBPT0=?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09663288-b0e1-46f1-eccf-08dace186d33
X-MS-Exchange-CrossTenant-AuthSource: TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2022 12:35:55.3002
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3P286MB2600
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Seems SDIO variant load firmware correctly without any modification, but al=
so reports this -52 error while scanning.
Shengyu=20

=E4=BA=8E 2022=E5=B9=B411=E6=9C=8824=E6=97=A5 GMT+08:00 =E4=B8=8B=E5=8D=888=
:26:45, Andy Green <andy@warmcat.com> =E5=86=99=E5=88=B0:
>
>
>On 11/24/22 12:22, Arend van Spriel wrote:
>> On 11/24/2022 1:14 PM, Andy Green wrote:
>>>=20
>>>=20
>>> On 11/24/22 09:42, Arend van Spriel wrote:
>>>> On 11/18/2022 6:41 AM, Andy Green wrote:
>>>>>=20
>>>>>=20
>>>>> On 11/17/22 21:52, Arend Van Spriel wrote:
>>>>>=20
>>>>>> I see. So could you load bcmdhd and provide log. Preferably with hig=
her debug level. It also has a module parameter for it. I think it is calle=
d dhd_msg_level and please set it to 0x817.
>>>>>=20
>>>>> It's here:
>>>>>=20
>>>>> https://warmcat.com/ap6275p-dhd-log1.txt
>>>>=20
>>>> Hi Andy,
>>>>=20
>>>> Thanks for the log. Together with the dhd driver sources I could make =
some sense of it. Perhaps you can try the following hack and see if we make=
 it over the first hurdle.
>>>=20
>>> OH!=C2=A0 I found that the line below should be count, not sizeof(count=
).
>>=20
>> Good job! I was testing you obviously. You passed. Nah, I just feel stup=
id.
>
>No it's great, the point is it directly identified the root cause without =
access to the platform, it's not so easy.
>
>>> ... any way, good job!
>>=20
>> Thanks. Will clean it up and formally submit it. I also had a quick look=
 at the SDIO variant, but not seeing anything obvious there in terms of fir=
mware loading.
>
>I only have the pcie module not the SDIO one.
>
>For the scan situation, he understands what is being asked via connmanctl =
"enable wifi", but he feels something wrong
>
>connmanctl> enable wifi
>
>connmanctl>
>Enabled wifi
>connmanctl> [  272.174946] ieee80211 phy0: brcmf_run_escan: error (-52)
>[  272.174956] ieee80211 phy0: brcmf_cfg80211_scan: scan error (-52)
>
>
>connmanctl> [  275.133157] ieee80211 phy0: brcmf_run_escan: error (-52)
>[  275.133166] ieee80211 phy0: brcmf_cfg80211_scan: scan error (-52)
>
>
>connmanctl> [  284.138852] ieee80211 phy0: brcmf_run_escan: error (-52)
>[  284.138856] ieee80211 phy0: brcmf_cfg80211_scan: scan error (-52)
>
>52 is EBADE, I recall you mentioned that the scan api had been changed rec=
ently... is this possibly related to that?  Grepping around for EBADE near =
the function it mentions, it tries to take evasive action if it sees one in=
 some places already.
>
>-Andy
>
>
