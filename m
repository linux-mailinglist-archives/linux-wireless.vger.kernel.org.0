Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D54146378C3
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Nov 2022 13:24:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229490AbiKXMY3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 24 Nov 2022 07:24:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiKXMY1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 24 Nov 2022 07:24:27 -0500
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01olkn2079.outbound.protection.outlook.com [40.92.98.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27AABD53B2
        for <linux-wireless@vger.kernel.org>; Thu, 24 Nov 2022 04:24:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XN5B8ihtjY3QYbZ8Qj787gIryImbRYDiZKmb9FIkAqLMPazMSLQhxMNybJczHigI46oDR9OlIu5Gz6lo2dGd0KZAMalX/EktyJ3zNVKYp7nkDGq/Xr4n/mz07I06LACK0JjlfiRevoJWHEGltbrQsbPv1GQTo/UISAJ+Tzb8LB/BA1Qq1aTiVsnt4R/HH1Njjv6u5uxzhdE46L+obhTNbL9FigTU0kbV7nqsC8zMr0maveJ8exa2kKomDGutlOw47Hs9hHLBdgtzwqUxJEaZ3uhs89ywwUXbyu7ITCN2qx9uTz2izOPzYxlXNzEYcONvAcN0Lv4qVYSjDSf75Tp1tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SdYnICXMnXtA2IfU1fh49d03Fv/j6G8tKDfCYneh7Bw=;
 b=Y2D3kLHQvwCfOwS6UPbz6ByKxKW+NWVgAz3wakFBOOVeat4/uXgI1vPxdv4llrL4YPyu0G0xPwfO/xh8w6Hh6LQGejXT/5ZMVPF2gzVwe5pIcT41upixI5iTcve7Z7dhy3dkkDEKUopki5Tz8BXT7p4glhexcgybJBXYSbZQfcmeFPtDdxG8a0q7mmaYQaKfbNQA+DctZrRBx5mqcQdoycHiRUSUw0ZOWJI8ZvmkekFs3Vh6NkBftc6gqYmLlComEvt7PPPMKGWOygJnCpJIAndO4M2G4JG8XJjoMVh9rRGmOOV5YHkOU+3Akbb1DyEGuQTogM2VDWSy3KJXtp+y7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SdYnICXMnXtA2IfU1fh49d03Fv/j6G8tKDfCYneh7Bw=;
 b=T3o9aRDkGx2oFjuVoI0hZYcGwqTY5T6ITjzGuxi1KhVTwP5ylpfV8Rza9qjImIDsFhHlW4qDPALjjPUcng9OCvXDBt/0U34gcT6WSlcEh/ME9FpHaBFTnEHawp3udXgtOGfjY8snLqb01FS45W+J9PbQObeu/kamZ0dOUNK0g9HFPq46tqOqMUYms9vU9kFwg6kYmHiVoE0vpxy6ldyUeQeBgVO622XHJWc7m06/69Wu+2fdSkEksaLvsuMv2AdVfg4Wv8q0eSueWBOZTJlqFueFAU3J/V1YAuPKnCUg3phimXzWQDxWQM5XyfBiysJc9QFELqEjXmsuGlo8CJg1UQ==
Received: from TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:252::12)
 by TYWP286MB3173.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:2d1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.19; Thu, 24 Nov
 2022 12:24:24 +0000
Received: from TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 ([fe80::3b28:a466:3ae7:876e]) by TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 ([fe80::3b28:a466:3ae7:876e%7]) with mapi id 15.20.5857.018; Thu, 24 Nov 2022
 12:24:24 +0000
Date:   Thu, 24 Nov 2022 20:24:17 +0800
From:   Shengyu Qu <wiagn233@outlook.com>
To:     Arend van Spriel <arend.vanspriel@broadcom.com>,
        Andy Green <andy@warmcat.com>
CC:     franky.lin@broadcom.com, linux-wireless@vger.kernel.org
Subject: Re: AP6275 / bcm43752 pcie on mainline brcmf
In-Reply-To: <9fe8caec-453a-28c1-04d3-5966200b8db1@broadcom.com>
References: <TY3P286MB26114DD461F50814980453E598029@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM> <08416710-655a-c87c-a599-3fe2563f7de4@warmcat.com> <18470a1e910.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com> <TY3P286MB26115A58795F264893CCB40198029@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM> <184720fc920.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com> <TY3P286MB26118BD94839F752CADCCF5298079@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM> <625f1d5d-e137-7ad7-96b9-92035e87df8b@broadcom.com> <638afa8e-a393-410c-3182-0d8e9b6da17d@warmcat.com> <1848793db88.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com> <3a562a50-0cef-4879-3691-3258596f5213@warmcat.com> <1cbb3bf5-fd70-e9db-2405-640178862857@broadcom.com> <6c3f592e-3e20-edef-ce7a-cde8988eef2d@warmcat.com> <9fe8caec-453a-28c1-04d3-5966200b8db1@broadcom.com>
Message-ID: <TY3P286MB2611D21F3C55717D03121003980F9@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-TMN:  [3U54hCa7L658W0YOaWkGQW58kv/ZPXt2]
X-ClientProxiedBy: SG2PR04CA0190.apcprd04.prod.outlook.com
 (2603:1096:4:14::28) To TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:252::12)
X-Microsoft-Original-Message-ID: <0D950315-E358-4F0E-9481-97760182821F@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY3P286MB2611:EE_|TYWP286MB3173:EE_
X-MS-Office365-Filtering-Correlation-Id: af1ba96f-3385-404f-6be9-08dace16d23e
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UBV+98rENvU1L6WsgJjK1oF2/goyUs0zcbpegcSlleRLZyZ0lF0MlCvODmIek3MvL6QDRln1WF6vIxJR7tvPKbswyOTtCUS+iHV1+jnEXtlxUhBFnMahR6UZcavLXUQ8uv+k5ch6Z6E8fNLTCMXOKwA9fvr1NdDxXdY7plAP+7WdDJnc8S+YG0hWbKvK5Bb0MummgH6U+ipcMDhmnK3l5uvg8SPZjP2HWY1yubUuWo3b5ld5AYsPqeBgpf4sEggMOWjTc3gxl7qm/DdnatUXRWXLxVOuqpllzogCY9DiiSJL9kO3+nfV0ADpfgh3BtgzaSvj3b7UinVBemEegonB5QYb6EiWjErAkr+5c95SiT87xWp0cN5b3vf9bhekWVf5gFaIoWLN3dgjINob+yDlX4Z9tJUgfhdXtRJw08yUEz4mkWtAFmRqj6LnMooVtmDbgSxTBP/lHYE/iDzmdDGvDiIC1K5DsCmj1QpfmRnqOiXGgZKXJKEopeCVqCfcmT0fAoJtNwuwzFiWT+7H0nsSgtUORRg/neTgEV9VCGEwtXkXI5W26URs1EaECZHhFpZwP8vJwYsd9IBO3lwedbMAP57E6TvaOinBIfaH3+ZWWFOg/ySGPVL+ZVS1jYCa8Xz3dlKhoyE6zIujrt8Jsir4FQ==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RFZ6eTk2OERmRGxSMlNlT3loOVNkQ1MvVnRzWDFoZ3VsVitlN0FlQXh1NGNU?=
 =?utf-8?B?T2JFRVp1V3dOaWRnbFhTTnFJbzhKWUJqNXduTGdLQkdBTGJpZjBLUjZldmRC?=
 =?utf-8?B?NGlROTVXM0s4dzNueXNydWUxaWc5SGN0eWJucXBNSjlZUm1kY05nN1FsWS9M?=
 =?utf-8?B?Z0VpbThvTmN6V2srU3BUS0IvMFN6cFl4c2dCd3RTR3JyL0dZeXB4aFI5UmZS?=
 =?utf-8?B?M1ZSOE9IRzdHQ3VtZExqSDNpeXNRcXN6a0JoWnVYN2g2YThEVWNIZHNvUFVa?=
 =?utf-8?B?d3VNcmppUGFsY1JLajQrMUVvYkZLbFQvZE0yd1lPN3BwOUVDNWl1aksyVW5S?=
 =?utf-8?B?Q05zd05BbE95TDVtM3NBZWNTWm9iSVgrbVJLWS9TTnpyWDFSOVJDejdyNEp5?=
 =?utf-8?B?NUMvdVZ3ekVPdE44YTNOcGJoSzB3SExBaDZvNjBKWEJtdE9HWUpuRTNkcldU?=
 =?utf-8?B?VEpGM3kyU2h1VW0wbzNzbFZwcXBBdWxoc3FzWldZbUVUYmkza1dzOGRnaEpz?=
 =?utf-8?B?cW5BWDhGUjJzN2xucWN5OXFlaWI5SDhPM1kzamFhWnVPWlFvUWc1M2dCSXNJ?=
 =?utf-8?B?TE9oa3p4cnBrSnFBL0cxWGlFdzFYby9YVG4wTGp2U2x3MXE0dmJ1TkRPRTIx?=
 =?utf-8?B?VStxVklOamtSTmRLdXB2dk5SR2lXZk9UNHJLMWNKNldRbEwzTGZsbUNaNGdZ?=
 =?utf-8?B?Q0xIZnoxazJHMy9hUTM0NTlqbUl3SEhvYVAwcFQ4enA1R3FpMk80dUowczBW?=
 =?utf-8?B?ai9MUUwxUmpFYjJKMldtei9nY2RSdThZeGNLUWtuUzBFdlVLTUw1OTJnRW1H?=
 =?utf-8?B?U0F4aC9NelFYWFExNTByWG5WVk55bEk4MzYrZDFLNDN4SXhUTzJQQ2x3VEIr?=
 =?utf-8?B?MDdIbTJqTXpuaWtVT1lST0gzYnVIbG9uTjRrRVpzdGoxZXVpNE16ekU3Z1ZP?=
 =?utf-8?B?ekFwdEZ1OXFNclo5endTKzcwTGpoNmV2SnhoUzdLV2pUODNZOUJFUzRuOXRn?=
 =?utf-8?B?WERBdHYvelU5UGVoNUcwUk9pMndVMzJrMEtMVlBMQzZocWVUbWZCclNGamRP?=
 =?utf-8?B?eHgyY1cyeURIZThvK09yeGc5TDZaMk1jZVpkcmVuREgzaTR4YVhEYUNxRXJ5?=
 =?utf-8?B?YVdvdlU4WmxMUzA3ZUpNVmtMOGdvd0lJS1pEVTY5T3c5a091QUFpUlh3YkhU?=
 =?utf-8?B?cmluR1JwYUc5MFhva0pwdU9JaHA4STFOUWp6QkRmR2R4MkRFaFQ4MmdTQ28v?=
 =?utf-8?B?ell1LzdXYnhmaWtvSE0yWEJyQmtMZW9VVnFwbVhTR29KbVFuOFUxQ1ZISndp?=
 =?utf-8?B?VzllZHYvM2F5YTE1dWw5Qm5HREdidndSY0dscm14d1U1MkVCRlFLc0FvQWdM?=
 =?utf-8?B?RHlDU0Zld0trYUtsQkkyejV5QjAvUkRnbTY3Y1Yva3dHbDNRRHRTbWtUY3Fj?=
 =?utf-8?B?RW5Ccmo5QkRTYmIxS3JiLzFlQ2praXhrRHV0Zkc2VnZ3UkMzMUY1dm1QL1Qy?=
 =?utf-8?B?dko0TjRHdjhzakFpWEJjcHlQTmtvYTZ0NENjbmVtam9PdDJCOU5qYkNXWW1l?=
 =?utf-8?B?S0lWeVdMOGkxSmsyNks4NHRmcXBNem9DV2ZUYmpZTkZtaHBIcUM2WTkyQkFO?=
 =?utf-8?B?eHNFTFB3ZnRWL0N4ZFp3SmlnVnBRTEJPbnlGWERzVFFUYUpNWTZYYkl3VzFG?=
 =?utf-8?B?S2NhMm5WcytxdjJOblJoUWowMm4zVEl6VktLdnN3VWhFb3FFamxydlBnPT0=?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af1ba96f-3385-404f-6be9-08dace16d23e
X-MS-Exchange-CrossTenant-AuthSource: TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2022 12:24:24.0587
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWP286MB3173
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Great work! If you need to test SDIO variant, I could help with it.
Shengyu=20

=E4=BA=8E 2022=E5=B9=B411=E6=9C=8824=E6=97=A5 GMT+08:00 =E4=B8=8B=E5=8D=888=
:22:09, Arend van Spriel <arend.vanspriel@broadcom.com> =E5=86=99=E5=88=B0:
>On 11/24/2022 1:14 PM, Andy Green wrote:
>>=20
>>=20
>> On 11/24/22 09:42, Arend van Spriel wrote:
>>> On 11/18/2022 6:41 AM, Andy Green wrote:
>>>>=20
>>>>=20
>>>> On 11/17/22 21:52, Arend Van Spriel wrote:
>>>>=20
>>>>> I see. So could you load bcmdhd and provide log. Preferably with high=
er debug level. It also has a module parameter for it. I think it is called=
 dhd_msg_level and please set it to 0x817.
>>>>=20
>>>> It's here:
>>>>=20
>>>> https://warmcat.com/ap6275p-dhd-log1.txt
>>>=20
>>> Hi Andy,
>>>=20
>>> Thanks for the log. Together with the dhd driver sources I could make s=
ome sense of it. Perhaps you can try the following hack and see if we make =
it over the first hurdle.
>>=20
>> OH!=C2=A0 I found that the line below should be count, not sizeof(count)=
.
>
>Good job! I was testing you obviously. You passed. Nah, I just feel stupid=
.
>
>>> +=C2=A0=C2=A0=C2=A0 addr -=3D sizeof(count);
>>> +=C2=A0=C2=A0=C2=A0 memcpy_toio(devinfo->tcm + addr, seed, count);
>>> +}
>>=20
>> With that, you were right on the money, the firmware comes up
>>=20
>> [=C2=A0=C2=A0=C2=A0 3.796062] brcmfmac: brcmf_c_preinit_dcmds: Firmware:=
 BCM43752/2 wl0: Jul 12 2022 18:54:54 version 18.35.387.23.146 (g412cc5ec) =
FWID 01-93c53be6
>>=20
>> along with
>>=20
>> wlP2p33s0: flags=3D4098<BROADCAST,MULTICAST>=C2=A0 mtu 1500
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ether d4:9c:dd:f5:bf:7e=C2=
=A0 txqueuelen 1000=C2=A0 (Ethernet)
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 RX packets 0=C2=A0 bytes 0 (=
0.0 B)
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 RX errors 0=C2=A0 dropped 0=
=C2=A0 overruns 0=C2=A0 frame 0
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 TX packets 0=C2=A0 bytes 0 (=
0.0 B)
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 TX errors 0=C2=A0 dropped 0 =
overruns 0=C2=A0 carrier 0=C2=A0 collisions 0
>>=20
>> I will try get it to scan...
>>=20
>> ... any way, good job!
>
>Thanks. Will clean it up and formally submit it. I also had a quick look a=
t the SDIO variant, but not seeing anything obvious there in terms of firmw=
are loading.
>
>Regards,
>Arend
