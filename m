Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 098C462BDC9
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Nov 2022 13:28:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233200AbiKPM2f (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 16 Nov 2022 07:28:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233212AbiKPM2S (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 16 Nov 2022 07:28:18 -0500
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01olkn2051.outbound.protection.outlook.com [40.92.98.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6955CE6D
        for <linux-wireless@vger.kernel.org>; Wed, 16 Nov 2022 04:25:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H9xKVxT1gF6/iCHc5daZGUW6mzhsXhrZgDrtd8a+i6Q+0EPI4Zscb0IYLV2Mo1S1libfuL9aqTvx317l06+HZPM2pJYDz/juYUSSLjEEsu/wmehUaduM5r/aiM797WRXO7YB0yQ/qSkrS5FIulNgEl16csruMnLVc2VP1zLd+8M4LMlBQKWcxEJM+WlBYv2s+8xvPK2/beqUJ4fdBK6bD7xw0z5grCg6jKbpVEM1Op9h0JHF/lLmV38nDfrjD83L1L+26WFAtnKJ6tiLvYP2ExLtssGzG2DEoZNn47X+2XKkMaborENbtVQuEln56wxHwu9fSCiI7ASweNmG5sXWkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5DrLnmigtP3X1N+LNP6YjfgCfsspn0URFf12+JcUQCg=;
 b=YBfPYDtciflXN6323NNu8ls0lLbl2bPxEjhyxUT3bcybZslFJH6bzMroMp3O/p2mQLyNAYaBuUHWzODSTQ8mikjviRx6smXTlPiFgr9FAre8sFtNsuxvVTkGwQUdGCpjmatDrDcKl4tD+2jnqtlZiYr4LACRdQ6IBk+oQi+9YFCbNhKUkFbm9peey1GSwF7sfajPDUnwY9jyFqnBT3gZDD03Uc15/RurdBjOPIvCrI2P1PXC2UjjG5OAM/nOenKfxKgL4221VqCFo1sMIwRiWwzVjTbgEf8yNyOk0bE1Kq/JsKi/SXWxZBl0ppurc+CMsNcCXLN0VUb49OG/2bw3VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5DrLnmigtP3X1N+LNP6YjfgCfsspn0URFf12+JcUQCg=;
 b=jNs1Y498SIzVJ5rX+T8hMTcFM8NsNhUtKHO5n2TDQr74veLPksMDThGzi5Qge+M15K9bw9CJR0lg8DJdqfcHpNHY2V67By/uTlpLAsGAYVYgNNCK7EO2WVb52dpMiI3BjSLtALWuRFSqfHUwUkpSU4SQdXB9WINQzABOWUfyVjRDZLvYKCixpZO3g91XXVPOqxVFSkeHgB7FYrkmv3EWzd8mxxFtnDKIx3e326HwE9ECZ8RMZvyTOHTzrnma4qHIL00EVGxW3FDWwQYAAU0TyCiP6JGvECeEonRIOJfHLqtcLCUfs0h42D3cCp3ewd7yfiBDu7x6ABNvkt5po0Sgyw==
Received: from TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:252::12)
 by TYCP286MB1537.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:17a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Wed, 16 Nov
 2022 12:25:23 +0000
Received: from TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 ([fe80::38d3:c4eb:fa2c:3953]) by TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 ([fe80::38d3:c4eb:fa2c:3953%7]) with mapi id 15.20.5813.017; Wed, 16 Nov 2022
 12:25:23 +0000
Date:   Wed, 16 Nov 2022 20:25:16 +0800
From:   Shengyu Qu <wiagn233@outlook.com>
To:     Arend Van Spriel <arend.vanspriel@broadcom.com>,
        Andy Green <andy@warmcat.com>
CC:     franky.lin@broadcom.com, linux-wireless@vger.kernel.org
Subject: Re: AP6275 / bcm43752 pcie on mainline brcmf
In-Reply-To: <184720fc920.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
References: <TY3P286MB26114DD461F50814980453E598029@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM> <08416710-655a-c87c-a599-3fe2563f7de4@warmcat.com> <18470a1e910.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com> <TY3P286MB26115A58795F264893CCB40198029@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM> <184720fc920.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
Message-ID: <TY3P286MB26118BD94839F752CADCCF5298079@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-TMN:  [vWHOnCCP9XuRrhPqRNjBwebJzTy9fheTx+05it0VVrQ=]
X-ClientProxiedBy: SG2PR02CA0126.apcprd02.prod.outlook.com
 (2603:1096:4:188::11) To TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:252::12)
X-Microsoft-Original-Message-ID: <A97B84E0-8872-40D0-A7CD-5F314531E3B4@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY3P286MB2611:EE_|TYCP286MB1537:EE_
X-MS-Office365-Filtering-Correlation-Id: 9af34022-eb50-496d-6e20-08dac7cda21a
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t2hvKMW0NPSk5PPdNaQ3BQB1BYazhk6020MCJ2kxYjR04oEZusqNRZ40kZ7QfakB3y631PzwhwQhz97ijxlvKEZInXxu1lyLlNrl7K4zR4HQPmjagUX19yYQSG5CmVYgQ2RmpgXo50j6yNSjkPzFKctufOfKJQo0T5BECTllHsF7v1XRG5cnBxp9IgD517T0vlgr6XwFtiJWj0HVCftEUnPiQbZzDH30uOyue0ph+g7f2X8SV3KqFk0I85Avuexg4EAxgVNPgtL76sGUC4K5vAIEMjKNRjcGCODykn9Eg5NHaW/0KFtMkBIesOMH8U32FmgjIWVXZntT1KvqIbQNReAgqEb2lcfhlVsPpH3xJtmJ521KrpLhKbjFSn/h0vv1H0VTSYHbSGQvYKEKYpyw1IwurjC03t4+wtF2huilGvOAmGULB+f1H4GinyLQsPNt8yz+PpYSNACcdVC2TFnAjC9eF4E3tRTnjSNCHeYEB46oZz2QjqYb8VB3POooAsY3sNf2MAqNrsl5RZP2OWVz4HipYba9VZ0YIRGtUe5frVYcwP3ZJ3aMyBcF4M3C0760uSpevTYM1N1qapjYlDi7GeKZTZQwCa7aC3kp6UfaCgVVYFw8N4WG8qfEG2qyg/cDsAzE2hnf/5Fs4vH1pLYLl0ZphpvshFBYsiAC0RHKSe1GNyHkF1PwqEC6oBMXnYPI
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RERLY0Q3dnplQnkwK2pCSEZSZW55ZWpyVkhlNVdNVFB1YjNENGRWRHdxNWpO?=
 =?utf-8?B?S2EyTWRUemJwdVRYbkkyd1ZITjl2Z2ovb3VadkVEYVdxNG5hcG5CZCtJS3Ba?=
 =?utf-8?B?aE5RaGtXUDFaL3c5M1BIUlVUNUpNbk5SRWt1Vk9BN3J1bkFiQXMxRlBlNitE?=
 =?utf-8?B?eFpJdExDQUx2QzBrWlpyeFFhRllDVDRGQ1pmRUpZVnp5NXlPck1BUEJlK01J?=
 =?utf-8?B?THBlWnltMy9HckVtK1RVZjhYNkZIWGJvNzVQa3VrTU8wTW5FWERpODcyazB4?=
 =?utf-8?B?Wit2K0xwRTdnbGdnckh5UjFFc1F0TGpFZ1NzRnpha29rRzdYYm14K0p1QXh1?=
 =?utf-8?B?bDl3RFp0blpmMkhGbUc5eXZuaFgzZ3V2Umx0a0xuSmRveTZVaEl1UTJvS1BP?=
 =?utf-8?B?Skk4VGxmSy9OSFJXejNCUFJ4WkNxbEJrRVlwdzNoQkg5WnJZNnJhdyt5NStq?=
 =?utf-8?B?c3JXK0xpbDBPdXVhQTh2Y2ZQZU5NdHVlNHl5NkQzUDhlZlBqaEphSjNETUlo?=
 =?utf-8?B?cElvMHAwQ0N1Rk9lemZQb1NrZWdjb1lvazJ4M3lJSlh3MmJSRHY4SFp4SkJ1?=
 =?utf-8?B?YTNFdS9XaXRWS0NiOWh2QlMyOG1EcGF0VGMrTCtxZDUwMzI3VElmZ1h5MDJq?=
 =?utf-8?B?bFRwVnVUcjB0OXlxUnlBNFhHOTFRVTJtd2M1R3Q0T2VBdzlndFAzbjFJUmdT?=
 =?utf-8?B?MTU3b2tOVEFJRzBNUVJpeUJjNThmclRFa1NZYnJoaitqVjFiNGM2cmRkTmlD?=
 =?utf-8?B?aktWRFhUZERRalNCTHRsUFR2QktFZW5kaVlMUWxEdWpMd0xuSVY0YitoNENE?=
 =?utf-8?B?V0o1TmtLZTlwUTE5bE9zclN4aGFWUllISW5yOU40dEl3L1hCa0YzWTlwZ1Fm?=
 =?utf-8?B?T0tmNnRRbVRHeXRHVUFkOW5yR2E4ajkzN0JKUVV6bFpSSGdSTXBUY3J3WjZ5?=
 =?utf-8?B?cis2ejBEdDRMZjF2Y2dFOUNYRjBkMHUvZjVLeFM0eHFMTS9zMUttckovN3d4?=
 =?utf-8?B?NlhQUEo3UFkrYWpYUmdXVklSOXpuZmE0OFc4WDhGVGIvNHljUTBHa0h2RjZi?=
 =?utf-8?B?S3N1VTNIczUzaml2UnptRnl4cStQNnB1N2Vtby9LTTBOUXdybzFqUFZhL0sv?=
 =?utf-8?B?NVUrV01lUEtaWS9SUDlEMEJhTXhoS1UrR0VNV0JGRmZqbXVKLzd3YjZNTkg3?=
 =?utf-8?B?RlVnM2REeFR2bGQwYnlQOGtkOVZ2TDAxeFJOQkFzb1ZBQnV6N044dUFSazlw?=
 =?utf-8?B?VFBEV3I1eXBOWjJ5bzB2MjU0SmpnekZIQ08zZjhlZmNNSzhHMU1sRnBWdmZu?=
 =?utf-8?B?MEZkYWR5WnBMQUhTRTdCRTh0Z29idTB4dm9uS1lTTEdveG5iQkozNCtoajVz?=
 =?utf-8?B?Qk1TSUhSRUtDenJiV3ZTZjFwdEl4dFBvZ2l5dU1USFNPcEN1bDlqRTFReERh?=
 =?utf-8?B?TjhqbGFsck1MZjRmbVNXQWoxdFArRDh5c1JxK1VQZWE2TVdaMjVaT3RXZGVV?=
 =?utf-8?B?Z3J4dFkvOFd6WGI4bjYxdStGSlowRWFMMkZLTmhBdU4wQmc4MDBUQ0lNcGlx?=
 =?utf-8?B?QXlaUU9DczFvWnZzdzB0STFtcTJYOWxNbnZubWdncUdDaHpVK3pEelFiUFdP?=
 =?utf-8?B?TU1MZXpBc1FMeTlSbWNqbWZIN0thOUFRcEtZejZEU1k3eGVJb042RzJtb1Q1?=
 =?utf-8?B?d3JkaEwwSzNMVkZ2enV5SXRjVzVjeU5YQXJTZzdEMVJkSi9PUDBwVm53PT0=?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9af34022-eb50-496d-6e20-08dac7cda21a
X-MS-Exchange-CrossTenant-AuthSource: TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2022 12:25:23.2128
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB1537
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Got a new version of downstream driver and firmware here: https://gitlab.co=
m/rk3588_linux/linux/external/rkwifibt/-/tree/linux-5.10-gen-rkr3.4

=E4=BA=8E 2022=E5=B9=B411=E6=9C=8814=E6=97=A5 GMT+08:00 =E4=B8=8A=E5=8D=881=
:35:49, Arend Van Spriel <arend.vanspriel@broadcom.com> =E5=86=99=E5=88=B0:
>On November 13, 2022 4:52:45 PM Shengyu Qu <wiagn233@outlook.com> wrote:
>
>> =E5=9C=A8 2022/11/13 18:56, Arend Van Spriel =E5=86=99=E9=81=93:
>
>[snip]
>
>>=20
>>=20
>>>>=20
>>>>> Besides who I should ask to make proper firmware for it into
>>>>> linux-firmware repo?
>>>>=20
>>>> It would also be great to hear if the PCIe firmware from Rockchip aime=
d
>>>> at the OOT driver was definitively incompatible with the mainline driv=
er
>>>> and we have to find a solution for that from Broadcom, or it is expect=
ed
>>>> to basically work.  I realize it might not be easy to get an answer
>>>> internally but this chipset is likely to appear in more RK3588 SBCs so=
on
>>>> since it's the one on the evb.
>>>=20
>>> Right now I don't have enough information to comment on this.
>> Besides, could you upload the firmware that works with mainline driver
>> to linux-firmware repo?
>
>I honestly don't know what entity provides the ampak wifi module. I guess =
it is coming from Synaptics, but I am not sure. I rather fix the mainline d=
river to make it work with the firmware (if possible) instead of releasing =
a specific firmware for mainline.
>
>Regards,
>Arend
>
>
>
