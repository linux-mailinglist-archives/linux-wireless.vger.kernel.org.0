Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09C87626E82
	for <lists+linux-wireless@lfdr.de>; Sun, 13 Nov 2022 09:27:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235228AbiKMI1K (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 13 Nov 2022 03:27:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231252AbiKMI1J (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 13 Nov 2022 03:27:09 -0500
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01olkn2032.outbound.protection.outlook.com [40.92.98.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC199CE1F
        for <linux-wireless@vger.kernel.org>; Sun, 13 Nov 2022 00:27:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ayeYXgkI038M/EWXohK5l/YEcQkoN6uOx2CdxSuVN2ZhELqfbWTXV2dIfgyQ9nmZK6Rbr1aGqrv7OUOwFCto+PDbsxJ5IpJPJSDVWKeh5mDcfHLvPspjAtWPOHWC+niRN6cWDw/mDzgkVJxTjkBJTUD21OJR6qb6/QToBhEv66DAymPbxbKOrDN5SWSc431wBytbWEGUD7DWj3++UNV8D2+XSUT7IxyO5rh6qQPnRiByxdkwocLZx90BrHdFQwiueEWwoRcJkbNdP8eaMJDFkLpBfIZHLdvqsb1w7hF/wWAnEe4ZaMZvkPw+OtkMG0b2pFeigv4aTsTy2QKxLb4aYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NfdL/AxSit63vf/6+T1f09I3VuUwyhUEUGpr4l3DGms=;
 b=REo8qRLKjtcKYiEqQvh74jvw1788MwmOZWyGxsuy5ex4k/bjAL0BNtrDkz92mR0uFBJspcHUTbI83QsHpk9c5xgooDf9xyW3GAJONbf1NyaFPtEuEm+AOJ8lgTXJj5z8Lz6i4AeyHzfVJag6+mSBIux5GD6COV9VHSLOGsvctYh8BXulWBbb1XyfWtyZRc/ddQhEOj0fuiY+hEgirSS/W2FPBai9JIiNGI9gIbMal02Jf0692okld3oTKqLfgJZ3CFhFw4M6Oue5mdlk8SqZKj2fmm7rLfwBHg3zHLdomAavnl5yIt2I2QUr/nYAk2oUofxqI0xqoeCwm6lwPt3RpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NfdL/AxSit63vf/6+T1f09I3VuUwyhUEUGpr4l3DGms=;
 b=ng8grzaHNPlvPwdFhHEv+uHymedze8D9UZG3cT/q/lppl9g5o51vTOHPbNdFkOZTdAI14XmYvwnlL4p4dMVgoCuWRGSF59+zLxhFDrkKhmQ4t0+3TRYz6uRKy4JZGMsn8A07A6qFBddzifVvVuuTHlkXuuzq3lTCwLc8GZuEZVnSKABPa7SZINJqEytlw1SRjHIfqPhNEqxidYiPOpqlPG/OZ7b7rG8H9kNASOQDdvnHEbOB/edR2Xr9tpjXbPiSvHSeuQL7UmcJOLkombb8fpLAWmaRYfckir/zrrlTV01VXT+Y5nF2b/1CB368UZLw58ZqDSSQ1KaLKvRt1P1utQ==
Received: from TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:252::12)
 by TYYP286MB1836.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:fa::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.16; Sun, 13 Nov
 2022 08:27:05 +0000
Received: from TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 ([fe80::38d3:c4eb:fa2c:3953]) by TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 ([fe80::38d3:c4eb:fa2c:3953%7]) with mapi id 15.20.5813.017; Sun, 13 Nov 2022
 08:27:05 +0000
Date:   Sun, 13 Nov 2022 16:26:54 +0800
From:   Shengyu Qu <wiagn233@outlook.com>
To:     arend.vanspriel@broadcom.com
CC:     andy@warmcat.com, franky.lin@broadcom.com,
        linux-wireless@vger.kernel.org
Subject: Re: AP6275 / bcm43752 pcie on mainline brcmf
In-Reply-To: <1846076ac88.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
Message-ID: <TY3P286MB26114DD461F50814980453E598029@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-TMN:  [JSTVskRywDHkcVl2Ag/NwPKVbU5LRSoyv3DZi+/sKaQ=]
X-ClientProxiedBy: SG3P274CA0014.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::26)
 To TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:252::12)
X-Microsoft-Original-Message-ID: <E8553A7D-8F61-400D-B4F3-8FD9673819B0@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY3P286MB2611:EE_|TYYP286MB1836:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a8e58dc-337f-4f78-af42-08dac550d64c
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Fu5Q41rDQIl2GUGTxbkUN4JZT+YoYPgE4iBQcwgvGZdRGFjjktLpxGcpm1gaBtNXmqZQWlyVEeeXTmSw9GHtpT0mSB7aWdo4kxDKQylm+8iS1NbLovi1gpuT+08BQteTz0UTU+iX6F24aQh2CUcnPa96OOPMY6m4il5+VzXBdJT+FSttAUdv8Uj8cIpRdpAeF8Z2aNKUq9Z+hDMgOCUAgJap2b9IzSx4kDpBDp/39/PIhCP4tnBxVm6xQdolVvO/mADoOI9qXiu+wVZ6ftSYRBLcpVkxmggYrZWo1M/DzO5507yf84RaRsptDRUVxHszAAmLQmtBClfo9ootS30Vb+95g69McL0nURZ1OEcRFBkeLPxS0xV3ruy8Y0CFv+x+gtPCN64PnbB9rucc3VuZnQESH4kLHWivNXPrFswtu9RyQ0OI0zhsLlBDWRsZhOrmDw0+vhxRJIHre2y2sthROUEWBQbgSKb+tFS0aoL6kF4SSjM3k85cRX3GHYRTcHOd0m2OXg32sNU3gMQqQFN5MgH8Gcd6+U4CzOSnRC3vWOGsZrGbvoOK2FKQmiFAEmTDRRtMEcNGwgkJNCY0S8eyievlnqF8nUG7qK5mpYmcvpaTX418PkLNKxroWjc/glH/y0Gw3AUrO4KTVF2XntPFbE7IWl8eEDYTlYcX8TP3tKSbMhBK0/norMyb3ja6g9pM
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V2tWamRuTXNsejlBZ2ExME5NQnptSElIVjc3cnhOZ2dhVGJCSXB6VFVrL2Jr?=
 =?utf-8?B?VTFkMWt1NjBuVFpocTJHMDNCSGQwZno2d2Myano2alVLK0k1TFVyRklYK3FG?=
 =?utf-8?B?OEJxN3NWR0ZSTXloVlVoUE5zc0d3Nys1Y3RnUU5tWWVaTjhLRXhQRlZVcFBh?=
 =?utf-8?B?cHppVmJCTWFXKzRRWEZwaU9ZcHhTaEVYV0NKNFcwenNCK1dhMkd4SlN3S3Zl?=
 =?utf-8?B?QmxNWjZBdm9ObS9nUEVkMkQ2a0gydzRQdVA5QjY3bDUzT3JDUmNZV3o0MXp1?=
 =?utf-8?B?MFBrQm0zQVBmanJpU3oyNVpteS9Ybnd0MlFUQjYzZ3BYM1hBM216emJQT0g1?=
 =?utf-8?B?WjVCaEM1LytYWURpYXREcXNSQ1ZKUlVJWTA4SlkwU1YrLzVBTldLeTFVaXYy?=
 =?utf-8?B?aXFUUnpnNHZGeGV1TnlLNTJGekdpU0hEcnFvZTV1WjUzVGxSMzlucGRLei9W?=
 =?utf-8?B?ZU9xM2xqTlA5ajlZUGZmQTcrWGRHWjZ2SUxOQ1dJRGhKdS92N0lXZVVkOWNS?=
 =?utf-8?B?eVNSY3FObms1cGNzWGxaeUl1NDRoRU16UTI5YnY2WW9pcE1vMnpQUDR0ZUc3?=
 =?utf-8?B?andsMmVBaEJNNWVtMklTZ0lSU0xybGx2enRYczFWNERHNXUyWkExMzRTQVlz?=
 =?utf-8?B?U1pNVTQ0MHR2U1B0ZWp4Y0xhMFEyTDdWY1FHV1hSR2FiVVBCSXRta3VuL1Rt?=
 =?utf-8?B?TzZ1UW9MSE9CSjQ5SFJyK1pNRFJnbSsvMEZiYlp3YzY3L28wRGExOXZPek1J?=
 =?utf-8?B?VUY2VXFXWXpIV3Y4VWdQaHlwMWdvMEVMUGpZWUJvWTQ3eVZkd3lWSnY2TTBw?=
 =?utf-8?B?dDdYbW80Y1Iya1BnanpVbUIrbWx0K3E5NDVISEhoTmRJdTlxaXVHckhnbldO?=
 =?utf-8?B?T2ZyWkJ4VkJzK0lGM0VRdHFNaHYvNTRVU3RubkRGOFloZDdxS0Q0eWttZTJn?=
 =?utf-8?B?eHlkRXhJK2RrNmMzN3FMT0F0ZlM2TlNUbVdKcXQxU1NCZ3pSSE9wODFFdkFJ?=
 =?utf-8?B?ajlaR2FNNkJ2cGZwT0NsMEJJWkZCUDAvQnI2cno2MHkzOU9TYzI0Q3pEMVFX?=
 =?utf-8?B?Nll1NGtBZXVzWmVqNUhBbGFyR1pNdUUrb0NpRHc1LzZGamZLVGtIa1N2N3hV?=
 =?utf-8?B?ZEN3djlpc3lyNTQwaXp3bGk0cDZESXEyWmcxTFNmelRsY05QTjAwMGdWaURi?=
 =?utf-8?B?clZRcjRFL1M5S0MrMWVzb3ZCNUN1MklHL1MzUnFnRGFabmZHTDFPYXhuRXBV?=
 =?utf-8?B?ajhoOXpRV1hpbWVSdE5QSzRTZkN5Mk1NS3ZDakNSajB5aCszSnUvalRhRkxh?=
 =?utf-8?B?YnNldVl6WWRxZGxEMDlWT3IrS1FiYmo1bGxuRk1hb1pyaEZjOXA5RkRDMW43?=
 =?utf-8?B?SHpiM0VOd2JERUMvc1pVdWhkdDUwTFlzU3V3YW1MeUdKbkFVRjRVc1hDa2Iz?=
 =?utf-8?B?SWc4NE5oR2lQbldzY3hTTVVMR0Y5U3F3L01qcGpNWkdWdXd1YUJQTEN3NFk4?=
 =?utf-8?B?TWZKdW5wbDhMTis3T3d4ZWQzcGVLNVBJUHlNSkhsRkxXN3JEZmtXb1M2UWZz?=
 =?utf-8?B?WW1yaEFsKzROR2RaQlRmYXRSYUdjTVF0a2I4OXpTUi95ZFc0RTJXcHJxMmtT?=
 =?utf-8?B?Qm53NFFzUkVNcHBTRTFTc0hvd1hYenBZS29nMUdiRzBybVNRWk1qSkdlcExG?=
 =?utf-8?B?WTRrQm1WYlArZnR3ZkJmdHFXR3p2VzFaUERsYXpWbTdWQi9PMjdSNEVBPT0=?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a8e58dc-337f-4f78-af42-08dac550d64c
X-MS-Exchange-CrossTenant-AuthSource: TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2022 08:27:05.2425
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYP286MB1836
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello, I'm facing the same problem on sdio version of AP6275 module in main=
line kernel. But I found a very old version from here could work with mainl=
ine brcmfmac driver.=20
Link: https://bbs.t-firefly.com/forum.php?mod=3Dviewthread&tid=3D3107
Besides who I should ask to make proper firmware for it into linux-firmware=
 repo?

Shengyu
