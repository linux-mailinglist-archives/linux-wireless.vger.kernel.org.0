Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0886E626EDC
	for <lists+linux-wireless@lfdr.de>; Sun, 13 Nov 2022 11:05:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235231AbiKMKFJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 13 Nov 2022 05:05:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbiKMKFH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 13 Nov 2022 05:05:07 -0500
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01olkn2067.outbound.protection.outlook.com [40.92.98.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EE84E0D8
        for <linux-wireless@vger.kernel.org>; Sun, 13 Nov 2022 02:05:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JWwSgPjF6qpC9uy0Kg3pzHNCzYni09L31vK68JaZyuRw4kEZPL8Ozu6qNrjBsLc5WZjfdjqkd2lNSROS++vNl83u7h/dC89OleMkNl4uO3Llxi6QX7p4ZScJDx6Jg9DLl1m5bJfHs/adL4EelDD0B2t4LN6vXn1uerRIStdbT2jQ4HVNxnL/v8nM3/CcRcJfoP+o/d+B5VGdBxleKGqLzRIju8pQGbwhVQRmr/7CmXFEv6SFy5RdDZoGsD7ZO9MJFAtpZR77oMjjXQiP4CarCIB8/bfySXl9KFg7fWGAHfyYLJUqBjX0KGV3+B905GydAOtx1HoWmkax3czBT+Iq/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lWoaZN4dPxHqJfb+EDCpqhB716IR0wj02QXQP92vIAg=;
 b=FoYgvtDWUGBfzgjFsuf3cq19WUUgcVHuhIB2HI70k/vT8HDtK4sBr02pTadKn9B6W+hNtFBiEheEeuveetVuiwf8sYjbSzypAMXJ2aKKoyFKpvSIo+TzdH2Mwqn2yN5o5nHJaIFrWIqKTAaImcMVd+7Rv2rnrecaeIjOwGQlfHsxx90FOWYE8USQwKlgWr0GxoQ4EepKrg17LceAD49MA+YwvWfrAZyuFDywFv4JYxJ4WKj0na28jIBajRuZ3FOAnTYA0BGjX526CxHlKHQucOp4kQDKQOL6QcbXLi/ZRS8HUaVj8gWAZCa/cWxJo1JCecYxWOoriXurt+wqr6UbdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lWoaZN4dPxHqJfb+EDCpqhB716IR0wj02QXQP92vIAg=;
 b=iZ+WrJ3vCaG5clkmj3LUGVfaP+gQJoJrWollZ2KedviAKtduJ6SqkHkaubW0h/YJMwqCotQqEMqWGlOnFOEll/kik1fY5wf1kfx2DDbrzTPtXhNe1KpVm7SfVFNuHGCRfMzzA+EGtaaL8jPBlx1j18QfDFQttsxJO+DyvzG+94DqNdS5SkCFGzR5J/zGvwvqYC53C4GBLfSyVHymptbkhJaNXJnGu/jkmrKD9rQkfGQGZaaH48AlSobnXT4NXYu1QpkwMH9PD660Db5B9tjpddFL4P3dZL44DOAwSpetKViEK8SGnyltXyD7lixXPYVsj54H6iwoN76nocLiFXcukA==
Received: from TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:252::12)
 by OSZP286MB1848.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:165::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.16; Sun, 13 Nov
 2022 10:05:03 +0000
Received: from TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 ([fe80::38d3:c4eb:fa2c:3953]) by TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 ([fe80::38d3:c4eb:fa2c:3953%7]) with mapi id 15.20.5813.017; Sun, 13 Nov 2022
 10:05:03 +0000
Date:   Sun, 13 Nov 2022 18:04:57 +0800
From:   Shengyu Qu <wiagn233@outlook.com>
To:     Andy Green <andy@warmcat.com>, arend.vanspriel@broadcom.com
CC:     franky.lin@broadcom.com, linux-wireless@vger.kernel.org
Subject: Re: AP6275 / bcm43752 pcie on mainline brcmf
In-Reply-To: <de7f4df1-54b0-db2e-3d40-3caeda020924@warmcat.com>
References: <TY3P286MB26114DD461F50814980453E598029@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM> <08416710-655a-c87c-a599-3fe2563f7de4@warmcat.com> <TY3P286MB26116261C165BD4B0B249EB098029@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM> <de7f4df1-54b0-db2e-3d40-3caeda020924@warmcat.com>
Message-ID: <TY3P286MB2611977F6E1611A06DAC6D9A98029@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-TMN:  [ekPuW8bywfD7aL8N3g6ldf4ogqZcyLJ6wRSkeyRvhHrwvQ3XhAo+nRSCLVyoGG+171qP+3EdTnQ=]
X-ClientProxiedBy: TYBP286CA0005.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:404:ce::17) To TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:252::12)
X-Microsoft-Original-Message-ID: <7532746A-5AB3-49F3-848D-C59DDAD4720F@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY3P286MB2611:EE_|OSZP286MB1848:EE_
X-MS-Office365-Filtering-Correlation-Id: 8bb616fa-29e2-493d-8988-08dac55e8758
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z7tIwcEsD+xnUyvKveQ8HpYCpqx9D+uUnZhbFl9fTw9ff24od4XU1K5vYRFLIzRKpn+7AtI/E8IWm4CDR7KkMz9GVxMs9zlkDZF2kc/nRCOyRZGEKhQ9XekRySdIuftg1T1K8gImZWtFUDwhrdGdaTIFUG0jszM2Ek2dft5Aca5iK+tx6m8Lc0pwkyuxOFXzxcmMa1vuPV/nEGY7e4CoXoQFzJAUd9z5Bbel/Aq6z8rWrYKb/SaU6T24HidXWCwmRyJuxj6oaJgqFrSX1d/3lzW/kOuHYi6iaPf8obyZqebOojxZXJosgt5qXY6MdgjcL0cgKZqaK1ZOu8kEydYEPxppG+5n2YYUnOA1+gLQEkQFkeLlWuSSheuKx0Q/P0IMFTrYT9r+H226WtczqsEWVvc71OhOrW+c91teGgNUJTcjQfB/XGR16JRSU6uxInIuO/YpIpVweSfakrUaOtceDjfFaaA006RvPr9cjH6YdoTQr9nvQb8btBEMEt5s9wUwEVwXsA22TZfnZV6/yK4/utbeY1M20caUZFMp9bCU1Hxz3VLtn3mWC9S7sRd3wh6sjUvlNnCwz5wwo7qwW1r3S1wmApyOsqs+qN/dOl5kM3buW3HtYvD1JdbrGVuEdElSQTkfDUeELEhZyvbWTooWYmTcpkB6WxEC9Glo0wRP8KW7HxmE9VKi0zcyJbBHKW8H
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VXZYbEFTNExKaDFXUlJ5WE1Eelp5ZklnSTZuK2NsK2dXenRLbCtqMmhuSkpC?=
 =?utf-8?B?ZlphZzBBL2JuZ3dHaGkvSUk0L0hyS1NPN0FTMlJQZWVBaWI2THhNczFRcWJ4?=
 =?utf-8?B?MXY1dHQ1N0ozcUZNbVlFV3hRUjVwc2ZPYjVKVGxOQnJoWmw3eVZYKzEyejlQ?=
 =?utf-8?B?STRCbXltWVZ4TitXSlBaMTVzc0tqdzllWEZ0dFFQY2R5UityZVduK0NIcE5R?=
 =?utf-8?B?Q1hhOVVWOXVlRHA3K0VPSWQxS0VKOUh1K2ZoVG1ieEliQUh3cnl3cUIvV2ty?=
 =?utf-8?B?VnViR0l1dlZIRzZuOE9nN092UEhEZUhZYXIzbjk1dEs2RzR6TUNwZzF2QXJN?=
 =?utf-8?B?Qjh4eTJSNURvaFZTQk51a2R2TzQveU53aWNPUjNsdDJqb2FqL0hYcFZ6TmI0?=
 =?utf-8?B?WHFqVzVVWjFQdG8xUDNNZzRxZzVESUJHOFZYdFQ0aHBtbldsaWMyUDQ2TU5o?=
 =?utf-8?B?TVBwT3NNY3EzZGVCYm40Ris4UFB2ZHdVNUUrd3VSNlUyME1YWkovUnFzbkVs?=
 =?utf-8?B?TFlNMmQ2SzdhaVd6ZzdyU2VoeENCQUpuN0o0ckhvMlZNSXJBMEd0MjZGa2Vn?=
 =?utf-8?B?K3JlaTVEbkZWNi9VelJ1YUMxOUpaUUl6OTNiSEh0aEFTWVBmRzBHalJROHJs?=
 =?utf-8?B?TEpINnpjMDFFRUJLUGw4dzFCK0wzdlNQdjlUcVRCM0Q3SG9xV2lCKzZzbmY0?=
 =?utf-8?B?aEcwUm9VUFRVdUd1WURpK0JpWkJ3RzQ3SVkyb0NURjBrYzdTTEx6QWdWQWdq?=
 =?utf-8?B?K09TVEo2TVFqTDhPc2cvaHhya21qSDdHNUI2V0tZZ0swMVhWVFBzWXdhOEZD?=
 =?utf-8?B?WWVZZnlka096RXhPNEtvNlZxSnBVU05EMlBFMUtqdWVJUGt4cnJBa3lhS2FX?=
 =?utf-8?B?Umw4OWZmM2xiWUNKbU13dllaWmVTK0d0Vm5wSEV0M2ZOTjYyQ1AxN1BsL2tD?=
 =?utf-8?B?Qzc5cVBLN2FCVWFnSXE3OHNqY2tJNHltalJBT1h3cEVwaWZ4RDRjSERrVzhG?=
 =?utf-8?B?T1EySm5rcldkZzZsYXlmeDFGc29VZXMwTnFiQjV0OEp0WkxKZWJTYkEwYUVD?=
 =?utf-8?B?UzZjSGpMTm5uNVFRZ2hsSWV4VGRPOGJvbGlkZC81RytqRWU1bm54MCtoRkc1?=
 =?utf-8?B?WkwrTXk4RnhldFhyV09acEdhV0x2Tm1iS0MxeVl6SUtWNWh4WDI1WksvRHJh?=
 =?utf-8?B?MTFRKy9ueWV4Tlk5b3I3Vkk3REpqZjdNNVJ2WHNYR3VjS2xsUkR5UmpjaWlX?=
 =?utf-8?B?TUY0TUVnamVqcHNJSlBQaTJsYVhhK1VVdERZMm5iVWFaMlRHeFpBa3FqMXFm?=
 =?utf-8?B?N3lMMEtsN2dLb2lCV20ycU85czhBQy9LZDRmdE51akNDUVZTdlpmQUhBeHFl?=
 =?utf-8?B?Ylhjb0hiZDdjajdzaFlydjFQUDQvTHFBK09RUkNUNmpNRCtFRjR3K2Y2VWJo?=
 =?utf-8?B?WlVJRUI4b2dDb2F1WlhxU2pRTDFOVzlTOHJWN2FBdGFmaVdxSHhDT25lUnpJ?=
 =?utf-8?B?ODZNL0xLZHlsQkp2bHExaEh3emNZVVZvS2M4SmxuZGU2K05ENVpraW56dGx0?=
 =?utf-8?B?eFZTaGhoOGVXUkR6OFlocTRYQ0pkeXZVYzBMYWNHKzBGYXNRRjdXcW9BTk9W?=
 =?utf-8?B?R005WTZDZlhWSjVSTXJwSzRRVFNqeWk0OE1tM04vRWs4aEV1b2N4WGNuMXF4?=
 =?utf-8?B?N0J3cVdYdzlYTHJxaytrUXlteHRYWFI0QzFQM0I2ZDVBenE3UDdxMnR5Q1pT?=
 =?utf-8?B?Uk9xcnFka2xZd09TZE1LTkp5NEVNbmRVQWVyWEVRUlQyRTcrbHNLd1FUN0Uw?=
 =?utf-8?B?bERXT2RUaDhLcExBZ0RkUT09?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bb616fa-29e2-493d-8988-08dac55e8758
X-MS-Exchange-CrossTenant-AuthSource: TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2022 10:05:03.5595
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZP286MB1848
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Almost same, except I'm using sdio driver (radxa rock 3a+their a6 module (A=
P6275S)). And I'm using mainline 5.19.8(self-compiled armbian edge) while I=
 was testing.

Shengyu=20

=E4=BA=8E 2022=E5=B9=B411=E6=9C=8813=E6=97=A5 GMT+08:00 =E4=B8=8B=E5=8D=885=
:41:19, Andy Green <andy@warmcat.com> =E5=86=99=E5=88=B0:
>
>
>On 11/13/22 09:10, Shengyu Qu wrote:
>> Actually you can use any other clm info blob with this firmware as I tri=
ed. I also uploaded this to armbian's firmware repo. Hope we could get the =
proper firmware uploaded by Broadcom soon.
>
>Thank, I tried this, it did accept to download the clm part from the Rockc=
hip SDK firmware.
>
># ls -l /lib/firmware/brcm
>-rw-r--r-- 1 root root  30993 Oct  3 08:40 clm_bcm43752a2_pcie_ag.blob
>-rw-r--r-- 1 root root 743607 Nov 13 08:45 fw_bcm43752a2_ag.bin
>lrwxrwxrwx 1 root root     46 Nov 13 09:19 fw_bcm43752a2_pcie.clm_blob -> =
/lib/firmware/brcm/clm_bcm43752a2_pcie_ag.blob
>lrwxrwxrwx 1 root root     20 Nov 13 08:38 fw_bcm43752a2_pcie.rockchip,rk3=
588-evb1-v10.bin -> fw_bcm43752a2_ag.bin
>lrwxrwxrwx 1 root root     36 Nov 13 08:47 fw_bcm43752a2_pcie.txt -> /lib/=
firmware/brcm/nvram_ap6275s.txt
>-rw-r--r-- 1 root root   8709 Nov 13 08:44 nvram_ap6275s.txt
>
>But it's no happier after the NVRAM download part.
>
># dmesg | grep brcm
>[    3.530116] brcmfmac: brcmfmac_module_init No platform data available.
>[    3.530303] brcmfmac 0002:21:00.0: enabling device (0000 -> 0002)
>[    3.530362] brcmfmac: brcmf_chip_recognition found AXI chip: BCM43752/2
>[    3.531325] brcmfmac: brcmf_chip_cores_check  [1 ] core 0x800:65 base 0=
x18000000 wrap 0x18100000
>[    3.531329] brcmfmac: brcmf_chip_cores_check  [2 ] core 0x812:82 base 0=
x18001000 wrap 0x18101000
>[    3.531334] brcmfmac: brcmf_chip_cores_check  [3 ] core 0x83e:16 base 0=
x18002000 wrap 0x18102000
>[    3.531338] brcmfmac: brcmf_chip_cores_check  [4 ] core 0x83c:65 base 0=
x18003000 wrap 0x18103000
>[    3.531342] brcmfmac: brcmf_chip_cores_check  [5 ] core 0x829:26 base 0=
x18004000 wrap 0x18104000
>[    3.531346] brcmfmac: brcmf_chip_cores_check  [6 ] core 0x844:2 base 0x=
18005000 wrap 0x18105000
>[    3.531350] brcmfmac: brcmf_chip_cores_check  [7 ] core 0x840:15 base 0=
x18010000 wrap 0x00000000
>[    3.531354] brcmfmac: brcmf_chip_cores_check  [8 ] core 0x827:35 base 0=
x18012000 wrap 0x00000000
>[    3.531358] brcmfmac: brcmf_chip_cores_check  [9 ] core 0x240:0 base 0x=
00000000 wrap 0x1810a000
>[    3.531362] brcmfmac: brcmf_chip_cores_check  [10] core 0x135:0 base 0x=
00000000 wrap 0x18112000
>[    3.531365] brcmfmac: brcmf_chip_cores_check  [11] core 0x135:0 base 0x=
00000000 wrap 0x18113000
>[    3.531369] brcmfmac: brcmf_chip_set_passive Enter
>[    3.641635] brcmfmac: brcmf_chip_set_passive Enter
>[    3.642156] brcmfmac: brcmf_chip_tcm_rambase: 43752 OK
>[    3.642159] brcmfmac: brcmf_chip_get_raminfo RAM: base=3D0x170000 size=
=3D1310720 (0x140000) sr=3D0 (0x0)
>[    3.642187] brcmfmac: brcmf_chip_setup ccrev=3D65, pmurev=3D35, pmucaps=
=3D0x84565f23
>[    3.642193] brcmfmac: brcmf_get_module_param Enter, bus=3D2, chip=3D437=
52, rev=3D2
>[    3.642207] brcmfmac: brcmf_alloc Enter
>[    3.642231] brcmfmac: brcmf_fw_alloc_request: using brcm/fw_bcm43752a2_=
pcie for chip BCM43752/2
>[    3.642235] brcmfmac: brcmf_fw_get_firmwares enter: dev=3D0002:21:00.0
>[    3.642241] brcmfmac: brcm_alt_fw_path FW alt path: brcm/fw_bcm43752a2_=
pcie.rockchip,rk3588-evb1-v10.bin
>[    3.646995] brcmfmac: brcmf_fw_complete_request firmware brcm/fw_bcm437=
52a2_pcie.bin found
>[    3.647006] brcmfmac: brcm_alt_fw_path FW alt path: brcm/fw_bcm43752a2_=
pcie.rockchip,rk3588-evb1-v10.txt
>[    3.647308] brcmfmac: brcmf_fw_complete_request firmware brcm/fw_bcm437=
52a2_pcie.txt found
>[    3.647312] brcmfmac: brcmf_fw_request_nvram_done enter: dev=3D0002:21:=
00.0
>[    3.647484] brcmfmac: brcmf_fw_request_nvram_done nvram 00000000c4269a3=
0 len 5968
>[    3.647491] brcmfmac: brcm_alt_fw_path FW alt path: brcm/fw_bcm43752a2_=
pcie.rockchip,rk3588-evb1-v10.clm_blob
>[    3.647911] brcmfmac: brcmf_fw_complete_request firmware brcm/fw_bcm437=
52a2_pcie.clm_blob found
>[    3.648197] brcmfmac: brcmf_chip_tcm_rambase: 43752 OK
>[    3.648200] brcmfmac: brcmf_chip_get_raminfo RAM: base=3D0x170000 size=
=3D1310720 (0x140000) sr=3D0 (0x0)
>[    3.723260] brcmfmac: Download NVRAM brcm/fw_bcm43752a2_pcie.txt
>[    3.723895] brcmfmac: brcmf_pcie_download_fw_nvram: sharedram_addr 0xfa=
2c05d3
>[    3.723899] brcmfmac: brcmf_chip_set_active Enter
>[    9.721628] brcmfmac 0002:21:00.0: brcmf_pcie_download_fw_nvram: FW fai=
led to initialize: 0xfa2c05d3
>[    9.721657] brcmfmac: brcmf_detach Enter
>[    9.745615] brcmfmac: brcmf_bus_change_state 0 -> 0
>[    9.745623] brcmfmac: brcmf_proto_detach Enter
>
>CONFIG_BRCMUTIL=3Dm
># CONFIG_BRCMSMAC is not set
>CONFIG_BRCMFMAC=3Dm
># CONFIG_BRCMFMAC_PROTO_MSGBUF is not set
># CONFIG_BRCMFMAC_SDIO is not set
># CONFIG_BRCMFMAC_USB is not set
>CONFIG_BRCMFMAC_PCIE=3Dy
>CONFIG_BRCM_TRACING=3Dy
>CONFIG_BRCMDBG=3Dy
>
>I have the AP6275 module EN signal with the gpio wired to it as an "always=
-on" gpio regulator in DT, and don't use the hacky rfkill thing the rockchi=
p SDK came with.
>
>It's on top of 6.1.0-rc4.
>
>Does your setup differ from this?
>
>-Andy
>
>> Shengyu
>>=20
>> =E4=BA=8E 2022=E5=B9=B411=E6=9C=8813=E6=97=A5 GMT+08:00 =E4=B8=8B=E5=8D=
=885:03:06, Andy Green <andy@warmcat.com> =E5=86=99=E5=88=B0:
>>>=20
>>>=20
>>> On 11/13/22 08:26, Shengyu Qu wrote:
>>>=20
>>>> Hello, I'm facing the same problem on sdio version of AP6275 module in=
 mainline kernel. But I found a very old version from here could work with =
mainline brcmfmac driver.
>>>> Link: https://bbs.t-firefly.com/forum.php?mod=3Dviewthread&tid=3D3107
>>>=20
>>> Thanks for the info.
>>>=20
>>> The firmware on the firefly thread doesn't seem to have a CLM blob that=
 the mainline driver wants, just two types of the ~900KB main firmware for =
AP mode support or not.
>>>=20
>>> It also doesn't have _sdio or _pcie in the filenames... I tried it but =
although it's different in what it read after downloading NVRAM
>>>=20
>>> [    3.775602] brcmfmac: brcmf_pcie_download_fw_nvram: sharedram_addr 0=
xfa2c05d3
>>>=20
>>> (the rockchip SDK firmware says 0xfa1a05e5)
>>>=20
>>> it still times it out a few seconds later as unresponsive after the fw =
load... maybe it is for SDIO only, or the lack of CLM, present in the Rockc=
hip fw, means it won't get anywhere.
>>>=20
>>>> Besides who I should ask to make proper firmware for it into linux-fir=
mware repo?
>>>=20
>>> It would also be great to hear if the PCIe firmware from Rockchip aimed=
 at the OOT driver was definitively incompatible with the mainline driver a=
nd we have to find a solution for that from Broadcom, or it is expected to =
basically work.  I realize it might not be easy to get an answer internally=
 but this chipset is likely to appear in more RK3588 SBCs soon since it's t=
he one on the evb.
>>>=20
>>> -Andy
>>>=20
>>>> Shengyu
