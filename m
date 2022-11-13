Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 612F4626EA6
	for <lists+linux-wireless@lfdr.de>; Sun, 13 Nov 2022 10:10:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235215AbiKMJKn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 13 Nov 2022 04:10:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232676AbiKMJKm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 13 Nov 2022 04:10:42 -0500
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01olkn2057.outbound.protection.outlook.com [40.92.98.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47E7F11C3A
        for <linux-wireless@vger.kernel.org>; Sun, 13 Nov 2022 01:10:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mljv9Du6ZqfDiiaUWSC55sh+4zjPvxTJGvwfzIY81HoS5RvUoDCbX8HvL8S/kFkJs6xm3/G9QCxS7T4sbvWyeWudm2vjNKBk9GdnAmnqlspX5jUJA1Fc5CyDpmcw9PBjy1ZDR6jNKSsgXwEwoobJO2TzjN/4IzfN+TOk4R7kUj8kYV0cWdKao0RbCWt+M/Y2tZdnoUJOYQPFc+sGh2K/8IByOpnPtJSptDyChsYZm6Hvorm0LWO+w4SCsD51xc5VGLkWGFe/8U5uar8cXOZ0xr2tamoKlLCFFlEI9o7BtNFBK6xV9DnkPrbXwa2l3wdWHABvFruGAByIuQ7oqGdaCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=26WyIC90RYOVa8DMMDmG9qdeR8wQ7LoXohIAcJ2jj3Q=;
 b=a3QmV25JEXDhXtBijkv6kaVMc8lr6XtFcDKeJ/j+/jdjXMT5xRP8cPjjPz4vfc4kgHSPPTynL2f+TvsrcAXzWnTfWVaei/3sxm4kzqIat6g7Bn+hbR1JbaqmS8RMvS/GEXWjPC5SjIqIk6ksG27RfUwivm9n7Cx6p66DBS/sgmoGCL8ko2zGZQJsutMsh70ePvBqcP41lX9vXWqk/kUOM+DWRsxcd9vuNz4hXctnv5KKVLA/5LXeFBFrxVzPXDfdHUbmbXhLLgk6XqSdLvt8wAYOj1CQ0ij9G1R2/DtU3quu8TQwwX2D95Pq+lRoz4AD8ambR9j9STmMoUwpJlmROA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=26WyIC90RYOVa8DMMDmG9qdeR8wQ7LoXohIAcJ2jj3Q=;
 b=aKTBXJzpD4L0cn11R1afROHUmuVzriZ4nEvu7olV5msi5RuEd8/xtaiYCNZvdIoeUJjOtdFFMAts2yLTsUvlB7X1L5kWKTABBqPBswDJeffSDb410jqpcyms+awA7xHNdzXkZG2C755eQxFFeA3mytKbcvdpMpgYPG1V4ZqgjEx5COWnjuoNtKnt3orR8oMP+By3jBxcm6/WkMiAZZdIlzXaHBG6/ObPkQwVm2DFTopQMTRWARpiyQwbrlHHgvK8nSj2OA7uCc/N8YCZs9AsNZFyCEDuH6Eiyj1j0rP+vwTmDJnBgbPdaUOpQZauQVZoAD75WT6I1sw5SlVzMGNRYQ==
Received: from TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:252::12)
 by TYCP286MB2622.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:241::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.16; Sun, 13 Nov
 2022 09:10:39 +0000
Received: from TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 ([fe80::38d3:c4eb:fa2c:3953]) by TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 ([fe80::38d3:c4eb:fa2c:3953%7]) with mapi id 15.20.5813.017; Sun, 13 Nov 2022
 09:10:39 +0000
Date:   Sun, 13 Nov 2022 17:10:32 +0800
From:   Shengyu Qu <wiagn233@outlook.com>
To:     Andy Green <andy@warmcat.com>, arend.vanspriel@broadcom.com
CC:     franky.lin@broadcom.com, linux-wireless@vger.kernel.org
Subject: Re: AP6275 / bcm43752 pcie on mainline brcmf
In-Reply-To: <08416710-655a-c87c-a599-3fe2563f7de4@warmcat.com>
References: <TY3P286MB26114DD461F50814980453E598029@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM> <08416710-655a-c87c-a599-3fe2563f7de4@warmcat.com>
Message-ID: <TY3P286MB26116261C165BD4B0B249EB098029@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-TMN:  [dGpZaB4pNCYKxPCDGJ4DEKLwNLigKr8b6DuDeiqZz6Y=]
X-ClientProxiedBy: SG2PR02CA0061.apcprd02.prod.outlook.com
 (2603:1096:4:54::25) To TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:252::12)
X-Microsoft-Original-Message-ID: <ED360641-8F42-4FF0-9348-EFC039ED2B2C@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY3P286MB2611:EE_|TYCP286MB2622:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e94b6eb-7507-4317-445d-08dac556ee93
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XYbnVsshAn/QxSJzLjk2v9gR82ucPolnZJuCh5kwNIDPBA4bTnBkdV3z4mpf6FwgjbafmBHH79/R6hFNULnwM2dmhqh8LLKGy/gkZcPypw6tr0r2YPUBrDe8ytJDdLPWwwL6AD35Wk73Wu4p4PyAQM3fxMWG4MtmQ1tf6FMEK8zFYhHcGgtQKJngCd1ruoB72TlJQWJ/0Hn6GVrU7fquJ3TdDnpKFwns7JFDPACVS5kQ6/nd0r8EGQytwybJlXq0m9qEEoBJ47063yKLYkP7HSO+7fk/3sN2i+WbELaSZrotoJsDnRIigIxBpIC5HOlM6AF9+Zz1eCycDBXyRU5b0GuH++uJtwnj3k0nXFn/5+ucl1ZSSRUnjdrqt5Rfgazoy0G+f0xyeFITatJI1ipjP0hcoHWX9V+2efvYP1Wrwc3zcoTtsm11SgSqNspMP6ofJqBqHVdKaInuB6tqqXlF1/H34utaZA+in042NMjlfr3Dj8UKfe8cWJwXwO1pAT0Ushti7FQh4ZQc8+FRYQKL2JjafJRSpTlGwAeOYOy4cAbej8mBmdl0gImwjl8gA1se4AiAXdKvbro+9tSKMmjg6JjG+3DbSrw+qClZuKl2WA+2640c7QMuUEZobjGKjckN9J0p5fSnrh84GCyxA5Inzc3ERwTRNPWHwA0dH7ip68hMAf5CxJvdl4gkpTM1YnXf
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MEc0MkVySjFDWXUrUkp3NElOVXNuazl6UU1pZmw2aWU1aUdDYVJxNmI2dE1D?=
 =?utf-8?B?SFE5azZTeWF2WnFLL2FIZysrNnowSHEycVZVYURHbnhJN1I1SUxOTEw3aTN5?=
 =?utf-8?B?eTg3b1FxK2FEdWZnMStIOVJHTytFSE9kWWxFNlJnRGY2SmdDRVZvTEUvVjZD?=
 =?utf-8?B?RDBlRllKRk5mMm1HeGZDbndsK21jTWtYQjAxYWY1cTRmSnlRNXYxZlhwQk9M?=
 =?utf-8?B?L0tvZkZXeHoyK2RwZUhlUDEwd1I1dExHMDlQU055bXQzMlBhVmZEOG5VKzJi?=
 =?utf-8?B?UCt6SWJMMnpyTnpxOFM2NURMUEtSVUt1TFhLNThNSVVQaDZBL2Q5OGFnOVFI?=
 =?utf-8?B?NGxMYW9Zd0VZb2hZUldJVWJKc1lLODVMb2ZHMzdoeDQrdlBnRXczL0RIelM5?=
 =?utf-8?B?blQ0ekxiQmFUbDFJcTZjR0U3WEdQcUFIZ1hnR0xvVHBxdHNLRGRpNU02QmJj?=
 =?utf-8?B?MmFvTEs3WXdmZm9yazZOOW83QjhYa2ZCL0o4Z2FDUTEybndsOWw2a3RtbzI1?=
 =?utf-8?B?eGdVa1VGdHByMjdXcEViRUMrNEVUM0VRY0ZPSTQ2MHp4aTVJVXJoZjErdU1w?=
 =?utf-8?B?REk3OGFaTk90dDBmZTFZaDlrWURiMjVOQk5Ec29YaW9WOGdjd2J4aEc3c091?=
 =?utf-8?B?ajVCQlBzeDBxR3VJei9FSVppVnRLZ2FSS2txYktSR2lBakRmZ1lMYmd6WDc4?=
 =?utf-8?B?OFN4Y0pqUnc2d1FxUTAxYjNTNXBpOUl5R0s1NnQrVDdvbXZQclhsWEoyTDFH?=
 =?utf-8?B?T21tQlJ2MmNsTzFidU1LZUVZbUNjQWFydTJvZ29LdlNIY1BrM3hvVUErYVBW?=
 =?utf-8?B?RGpoZ2RBTFdCbVAwTTJ1MzRieG9YdkkrL2VldFo3VCtyRGNVKzJENnlBUkFE?=
 =?utf-8?B?eE9TVUdSaTZBTEZzMnJhMklSQTk1bkk5UXBZSmpZS25TSG5KZSszTmhrZEdN?=
 =?utf-8?B?SDhvYTZmcWdqRE9aNmZCdTNlSjBjWkZOQXgyRVV4TVQ1NDBIT1BRYXcrRTE3?=
 =?utf-8?B?cnFGZnhOSFpKQ0tBekdQc3JsSnBUMFBTbHJtbVZSVk1Nd2lKc3hQK1M2OVRN?=
 =?utf-8?B?T3BrSFA4cFVGVXRoUm9CN0poNzJ4OEVMK2xaVm9EMTdiK2kzY1lmYlpYU0Zr?=
 =?utf-8?B?aW45UHRCTXVMbzVrS2YwSlhPdi9HaFc5c085MkhTOHdVZDBkWlFDU1FrY3RE?=
 =?utf-8?B?RjF3elhqSmxvbjRLdWtpWFpma2NOOHViUVdwOWQwT2RNTFZxK2ZTT083bGpV?=
 =?utf-8?B?cUE4Y2hGWitkKzNjSkZ1bi9kdjE1bENlT2UxTDdjZHEveGJmVkhkVnRKVmdk?=
 =?utf-8?B?NUx2ZEVrZC96OFBqQW9aakpKdmNFMWxCTk1DdzdoQUNVbm8wVGdCOTEwYnJw?=
 =?utf-8?B?ODBYZGUvV2duTi96NXlmQ0lqV3N6TFFTV01sMlpRWi95MUJWOXBsVFB0bUs5?=
 =?utf-8?B?cXc4VWljamY0OXlFRisxcVRpVk5jcEFlWWRSejdUcW5wcnl0SjJKNVd3TEEy?=
 =?utf-8?B?WmZRRGY1OXorY1FwdlJzQmsxQUNWdVJXMXp0SDU3TkhGUTZkSER4LzhqeWhI?=
 =?utf-8?B?dDZEdyt1UkxJRkxZZzkyTDdVVVk1SGRwRmJISjFxc25MVkhUQlJQNTBnc0Zm?=
 =?utf-8?B?ejRxRys0WTFkczJpYTFGZHZ0REsyNXpYYU8rTHhNQkNUYXdkUWtSYnBycC9G?=
 =?utf-8?B?L0xqUkViY2trNFIwWEMwRW1hUjAreVBpMWU2SlJocnhQMHMrUVUyc2JBPT0=?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e94b6eb-7507-4317-445d-08dac556ee93
X-MS-Exchange-CrossTenant-AuthSource: TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2022 09:10:39.0271
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB2622
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Actually you can use any other clm info blob with this firmware as I tried.=
 I also uploaded this to armbian's firmware repo. Hope we could get the pro=
per firmware uploaded by Broadcom soon.

Shengyu

=E4=BA=8E 2022=E5=B9=B411=E6=9C=8813=E6=97=A5 GMT+08:00 =E4=B8=8B=E5=8D=885=
:03:06, Andy Green <andy@warmcat.com> =E5=86=99=E5=88=B0:
>
>
>On 11/13/22 08:26, Shengyu Qu wrote:
>
>> Hello, I'm facing the same problem on sdio version of AP6275 module in m=
ainline kernel. But I found a very old version from here could work with ma=
inline brcmfmac driver.
>> Link: https://bbs.t-firefly.com/forum.php?mod=3Dviewthread&tid=3D3107
>
>Thanks for the info.
>
>The firmware on the firefly thread doesn't seem to have a CLM blob that th=
e mainline driver wants, just two types of the ~900KB main firmware for AP =
mode support or not.
>
>It also doesn't have _sdio or _pcie in the filenames... I tried it but alt=
hough it's different in what it read after downloading NVRAM
>
>[    3.775602] brcmfmac: brcmf_pcie_download_fw_nvram: sharedram_addr 0xfa=
2c05d3
>
>(the rockchip SDK firmware says 0xfa1a05e5)
>
>it still times it out a few seconds later as unresponsive after the fw loa=
d... maybe it is for SDIO only, or the lack of CLM, present in the Rockchip=
 fw, means it won't get anywhere.
>
>> Besides who I should ask to make proper firmware for it into linux-firmw=
are repo?
>
>It would also be great to hear if the PCIe firmware from Rockchip aimed at=
 the OOT driver was definitively incompatible with the mainline driver and =
we have to find a solution for that from Broadcom, or it is expected to bas=
ically work.  I realize it might not be easy to get an answer internally bu=
t this chipset is likely to appear in more RK3588 SBCs soon since it's the =
one on the evb.
>
>-Andy
>
>> Shengyu
