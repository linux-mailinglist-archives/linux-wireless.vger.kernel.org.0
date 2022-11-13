Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DBF9627053
	for <lists+linux-wireless@lfdr.de>; Sun, 13 Nov 2022 16:53:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235344AbiKMPw5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 13 Nov 2022 10:52:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235312AbiKMPwr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 13 Nov 2022 10:52:47 -0500
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01olkn2042.outbound.protection.outlook.com [40.92.98.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D311E09A
        for <linux-wireless@vger.kernel.org>; Sun, 13 Nov 2022 07:52:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i6m8onQhISrftR0vqLogxFGhbXHqm91TSGnvODXn16wiV/DezdUD704t5paK5PuAObEoLCvpbsSWD3RSTVGSxeO+So6uPvZBtp7JHfOxckUENeTxWssP8eOK6tGZwlsCQhnyCPFfkWkvDd7Pm9UCiwPgas5WkRifvaJ0AfCE9yA3LiufYiNxLOooeFlDkKsjSmuLUdwZ8rJi0dGHPurM0i20Jldgrn7vHn4jNp5gkYRbAztZY5BmomMBRKaZbvLPuKmvEBiLQ6iR+xcw/kzuOLLY+XZjoMfgAqFmm9BugpkwW0Nflov4/jqpjjwqpKK6+IHzNfXp47j8yS5Y2vnmgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tvVVbNefCPFMTdGGhsli2wkZF+/jkHIH2tmD6Yz6iMY=;
 b=fk5fw6MCigNEGQEUrgXyd44sr5fQ+DeMDthl0QrUqfQ+Oa+2WBGwiYk9hgAmPmbvbUCMzZ1EDRElGNInnWrMDpqVoClY6sUILwfMrAZbQ1Kqx4TNpWBf0Q9iR/c7GLgJ4KJqaeckxidfrBgz8jngUbo/cHhJJEVFij2OtMJLKpiXqxlMecz69V0VT3ww9jouwiPqQj08QA2qBiAvoXv912/orcZJTqOJ5LDb/ETOQlq4ym0yW8svIlEOp7fKrKFTv9SdLvgKH5G7wb/geRnORwoD+Qdh2k4xs8nvaIMsimw39TAIxtHIMI8wM2mhPrIQg9BubGzS2+9uroYJsqkGLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tvVVbNefCPFMTdGGhsli2wkZF+/jkHIH2tmD6Yz6iMY=;
 b=fxzuOeUiwgDBbVzXm5371hWDaeE1Z+l2UPA2XkOG9YPiCwLhUfaQVAIEu/IHBU9z4jrW8UZSSOOinumvnX/VdFcJSuIAgQcsd5S5DVGqOWEqpqw8dCeX1cGAYoAzxP70Bt/P4hRybuXRVjH9iqnTObPl8HKLJSj/nMK8rkFSxWXMyUUHwQjrmPOpVr5GYuwVQymMDD27o/ooXZZxj4Ynlwv+DtnbB+nKRx3uln9Gk9V7LBzlJ9Q/CBWSJCxT6krGN540d3BPKrXPN/hGJIAfR7YlUVmJiRenOfJw/2d4ln6DKfxvbJwhKSupQ2MQrPkS+VmwyUi4pGN//OeNMBPlzQ==
Received: from TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:252::12)
 by OSZP286MB2160.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:189::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Sun, 13 Nov
 2022 15:52:43 +0000
Received: from TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 ([fe80::38d3:c4eb:fa2c:3953]) by TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 ([fe80::38d3:c4eb:fa2c:3953%7]) with mapi id 15.20.5813.017; Sun, 13 Nov 2022
 15:52:43 +0000
Message-ID: <TY3P286MB26115A58795F264893CCB40198029@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
Date:   Sun, 13 Nov 2022 23:52:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
To:     Arend Van Spriel <arend.vanspriel@broadcom.com>,
        Andy Green <andy@warmcat.com>
Cc:     franky.lin@broadcom.com, linux-wireless@vger.kernel.org
References: <TY3P286MB26114DD461F50814980453E598029@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
 <08416710-655a-c87c-a599-3fe2563f7de4@warmcat.com>
 <18470a1e910.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
From:   Shengyu Qu <wiagn233@outlook.com>
Subject: Re: AP6275 / bcm43752 pcie on mainline brcmf
In-Reply-To: <18470a1e910.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TMN:  [/UXbVYOIBtMLtGfY0WBB3ju/lQJ5S95q]
X-ClientProxiedBy: SI2PR04CA0006.apcprd04.prod.outlook.com
 (2603:1096:4:197::13) To TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:252::12)
X-Microsoft-Original-Message-ID: <2a2b9f47-1308-54f2-1413-2f1deedf6e5f@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY3P286MB2611:EE_|OSZP286MB2160:EE_
X-MS-Office365-Filtering-Correlation-Id: eb9ef90b-afc3-47d3-627d-08dac58f18ba
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f5NkLddLZMkmGHEcKHeEQuEswr/91xnz195lv0AV1+NgbYjFezQ6eEon7j3z8GJYgdfcEvLYOnmU4wi4F/1AOEn5tVH6Mj9OnFWVHtzD88m7HLZrBdABLJuYMu5oYJOtnH2OMZrdXCqp+KnvGB1NBd6tucVmYHWoofpW92HYyjTFUo+pcRyobdEEcGE6uT0wSThtttdKEoZySLMGOl/TAktJr6VZDpw1umK11QwxdhAxXAFHPhbO5kQevYNQJO7bHsQfAlzh7pdErHsaTloQIKqsUV18sIp0yd7vYKqYT8ATkwPxhdDvV/kZHd4i4/LcdAzeGw6KJnaG1yVCnT4jA1WYjc8Lc1rqE2xU9Xza6xdALoxjhIgC2i7WpIwN6DZsQs6Mf4BFYnXK5H4dwMRUzghwFrni9NkgQU4+RyM8US5OkVTqX7xQtNI/h/gwwvHEk7eQs/lMmlc4H/HtPQ3vWM4pBkkcSPIiqeEU7PoSeyiNMeqJrffmvvRS4cIXOdNr6Sg9fWJCibjVbeV6tgsviD3q05oJqsPo2vIPm8DQxkBdtkuPWY3+NoTvhvNpImMPa060DUZSAyqR8xsC+QIy6RhIWOUtt23XgQ4o2SQl31KzgEV+M8VpMiShuwDBPDpQOuwWHI8nGRP74xT1DfMIXvePquf277NFYEMweRMI6TBUPYcSxEphuUuQ2ygVae5X
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SmhxVmZTUnM1TXptUlZJN0w1aVNYQVhmQkFRUVRPTlZCZzJST3M5S05xRHhy?=
 =?utf-8?B?RFVTMUh6Z3V4c2t5aFBCVmNCMmxEaWZpS2R4YmYwS3BTZDhPNUoyZlNIN1Bk?=
 =?utf-8?B?RVNEVUc4ODRMcU5VT0l5aG5JN0kxaGV4MkF0V1pCSHFRWENrd0lVZUdQT01o?=
 =?utf-8?B?ZDdvdlFrVnVJNU9hY0x6Wng0aXRERVI4NUM5dzg2UlVHb1daVUY5UXY0VjBE?=
 =?utf-8?B?dEc4WlU2czFQMjhzOWhuM2JYNW95blcrM3dXeGlJL0dta2F0M0laUjNiV2RJ?=
 =?utf-8?B?V0QydGcyZ1BXR0N0TDhocEJ5RTZEeHFJbFpPZDMya2VZbEo1c3VXVm1BaG5V?=
 =?utf-8?B?Uy95TlBFcjhFWFNvb1lTak15ZHhTRkhsR25ibkNNTE11NVgyWHMrWmlycHp0?=
 =?utf-8?B?ZWQxTVFacFZnbzNtclBGNTQrL2VnSTRIdldNclFwcUlmOWVGUkhVSi9MblBJ?=
 =?utf-8?B?UkZPM3pvUE5xL3F0bmdBMDd3QTQyM0RubzhvKzBMdjN6Z25kOXdGUkNhR2U2?=
 =?utf-8?B?NGlxN25vc2ZQdUNvRnlvMVBRdzcwZzF3bDZhdmI4d3dyd1FEMGtBc2IyTU1Y?=
 =?utf-8?B?MjJQSDZNaFhrbTVPdE9GcGIreE82RUt5TS9pek12ZDdaNlZiaHFXR2oxUS8r?=
 =?utf-8?B?OXdtKzdUS3lEVHQvOWdCRlpYRi94aDdJdkxvNjNwY1d2VUhzYWU4Q014WFhO?=
 =?utf-8?B?THpnWVZ4UFRTMUprcVluQm95dlpwRzZVbGIrSlEwV242dmMzTXFQb1g1U1ZN?=
 =?utf-8?B?NnN5NCtraWJ1M0VTSEF3dUNyQ2x0cDJzTDBtZjh3OFVOWFE3RUhMblBuV2pM?=
 =?utf-8?B?bFpJQndvemoxVHFnMmIwOElJdDFuSXFHbldYS2hMZzhhSlgyUzRWekFjejVL?=
 =?utf-8?B?MWpuRElKZjdvcUZISWVDZzgxd3dBc2tpRG1aNllkdisycC84U3lHaGZxNmhI?=
 =?utf-8?B?R0p4S2NZUHVkaFFLYzRuSWpTNlNTc25PS20wRFphRzJIZjZZVDZyVjZjYXFN?=
 =?utf-8?B?UU8wc0dCZERUT3Z0bStTK0xYOHZwU1ZvdlZTb1VOTFprOE9xbUxYVzNCZjds?=
 =?utf-8?B?bVBhVTZIWWhpZTBGZ0RlZWZsWUJkNjk5WHBoM05aRWNubWxhMHRQdFAxVGtk?=
 =?utf-8?B?ZU1VMkJVNXBqbWZtTzUvQVdVYkI0bUs0ZkRqODhlN0JGaUZiYmZXdUI5WXVa?=
 =?utf-8?B?VmJUcENtalY1SlFZUDM5eHE3NmJ2TVZRWHBVZXB2WFBnRmpXUmlaNzhiUmgr?=
 =?utf-8?B?VFNJNjJPdlI3QkVEWks0eHNLU0ttMGtoYlhoMitUWXVGYzQzMEN4V21qemRT?=
 =?utf-8?B?eWsvWEVSNmh0WXBheCtpUTZOOFJub0c0UXA1VkJTbzlyazRJSFBrWlM1S0NU?=
 =?utf-8?B?cDhpcy9TbDR2WUtDTmtXYkp0NHNMWW9rek9FMmNydlY3cDN5ZnZ0STVjZHRD?=
 =?utf-8?B?Y2pLc1ZVVEgxT3U2R01HU1RzczE2MmhpTzRqWEMxcy9PR1V4TEdHaXNzc2ls?=
 =?utf-8?B?VDBiditXVlJ0SlF0Rk1XcmlpbHd0ZkVlSGs5OHExSE1POVV6ZFRtSjVINVpD?=
 =?utf-8?B?SnlIV00vSkY0QWFHN1RXcGJFbTFUWCtlN3pzVjFKb0ZOSkVuWk1IRUxDZTZB?=
 =?utf-8?B?b21EWjR1eU1XTzlkbE5EaXd5OUYwUXVDdUpwbHFQUE5hekhibWIvUHV5a3ln?=
 =?utf-8?B?bDdDR2J4c1pkRy84SEZML3VPODBXZUtra3FabEFMRVhxNUdRY3JGclRBPT0=?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb9ef90b-afc3-47d3-627d-08dac58f18ba
X-MS-Exchange-CrossTenant-AuthSource: TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2022 15:52:43.2217
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZP286MB2160
X-Spam-Status: No, score=0.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_MUA_MOZILLA,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


在 2022/11/13 18:56, Arend Van Spriel 写道:
> On November 13, 2022 10:03:11 AM Andy Green <andy@warmcat.com> wrote:
>
>> On 11/13/22 08:26, Shengyu Qu wrote:
>>
>>> Hello, I'm facing the same problem on sdio version of AP6275 module 
>>> in mainline kernel. But I found a very old version from here could 
>>> work with mainline brcmfmac driver.
>>> Link: https://bbs.t-firefly.com/forum.php?mod=viewthread&tid=3107
>>
>> Thanks for the info.
>>
>> The firmware on the firefly thread doesn't seem to have a CLM blob that
>> the mainline driver wants, just two types of the ~900KB main firmware
>> for AP mode support or not.
>
> A separate CLM blob may not be necessary when it is built-in in 
> firmware which can be overloaded by separate blob, but in that case it 
> is optional.
>
>> It also doesn't have _sdio or _pcie in the filenames... I tried it but
>> although it's different in what it read after downloading NVRAM
>>
>> [    3.775602] brcmfmac: brcmf_pcie_download_fw_nvram: sharedram_addr
>> 0xfa2c05d3
>>
>> (the rockchip SDK firmware says 0xfa1a05e5)
>>
>> it still times it out a few seconds later as unresponsive after the fw
>> load... maybe it is for SDIO only, or the lack of CLM, present in the
>> Rockchip fw, means it won't get anywhere.
>
> That sharedram_addr looks wrong. Probably the firmware is not booting 
> for some reason. Can you provide a URL where I can download the 
> rockchip firmware? My internet search skills are lacking.
>
That error report happens when using sdio version firmware for pcie 
card. If you want a new version of rockchip firmware, check this: 
https://gitlab.com/rk3588_linux/linux/external/rkwifibt/-/tree/linux-5.10/firmware/broadcom

Currently seems only firmware from firefly bbs above works with SDIO 
version and mainline now. And no known version PCIE firmware can work 
with mainline driver.

>>
>>> Besides who I should ask to make proper firmware for it into 
>>> linux-firmware repo?
>>
>> It would also be great to hear if the PCIe firmware from Rockchip aimed
>> at the OOT driver was definitively incompatible with the mainline driver
>> and we have to find a solution for that from Broadcom, or it is expected
>> to basically work.  I realize it might not be easy to get an answer
>> internally but this chipset is likely to appear in more RK3588 SBCs soon
>> since it's the one on the evb.
>
> Right now I don't have enough information to comment on this.
Besides, could you upload the firmware that works with mainline driver 
to linux-firmware repo?
>
> Regards,
> Arend
>
>
