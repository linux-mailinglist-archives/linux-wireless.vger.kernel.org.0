Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5A2A5EDE0F
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Sep 2022 15:46:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233331AbiI1Nq3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 28 Sep 2022 09:46:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233711AbiI1Nq1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 28 Sep 2022 09:46:27 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10olkn2013.outbound.protection.outlook.com [40.92.40.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 466F99B841
        for <linux-wireless@vger.kernel.org>; Wed, 28 Sep 2022 06:46:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MqqJPR07qRRXE8ktpcIvaxi6Yp3YkTlayIjrUXVTu+4Mg8ErsmeXRTQAd/sH5Y9urDIi2NsWdDRuRm94uj+Yrp4imNBceqxwa+vUlnh+Z+hVegYw5WEIL2uE7m2tgSOrFZMslti2DD9bJFIp++18Pe/yJko+U65wWfXSBDGr2hvztaw8/sP0x8/p3W3TScbv0hC532c5B0NE1q0LFiIVFCLoFLInsVeHq9Z0Y0FYFRm+CFDfRcSS3pF3UBNPr6kYwOiQJnERSmNugGcNdSnIxxOf4yxV+BL+XDxYPzyjTZri667wtGlHA382aEeEetQEzH8fkpJjCoQU9E+NoW7ySg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=732rCGiN5naamCkcuShe5Qn17L1WaTNDfT1TUjmg5Wc=;
 b=Am3qhfoXJXwccL0S5TttmEvWnvv7kzwu71qikktElm8ow2APaZ1GH+bNmxRLeZZe2hlHsf7Oug/7uHKbmQJQ281cbiiMcxBJNl2fZ1uwhdKMh8IIRVqAYDmpYtPjz1zL/odMbhQqt2iEEldGsZvMWJ29Jx4kEHYQHcDtYPU90GomyXzSgJT8NCFCA17UOHh5SAIt1ZYA4dOM9FlCdsVacEvoHhJ9n+Bjhi83pfWlsUDv4aQCyXiP6OGsrGblG1vtePzmbP+qj+tamdft60gbrdKmz1cZKyJsB2/5Wao6VckvJcmqlZJSAG2rCSyp6AriTFAKqUhqE3I3y+k/jcgs9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=732rCGiN5naamCkcuShe5Qn17L1WaTNDfT1TUjmg5Wc=;
 b=BB0d/hBD8OpHe5e6aZXr0mFjgrtPcO2StP0+pzdL2MBCYuEH6ff6/dUh0Foc8M+WtZS8hGQmZCGbOuz11WWi6y9qMqrqppFTheHnmIFZ2o1EKgcFtd2/7gSEdfV2lbuf6/MA1vICIrqEGjcBERrV6aNmiq2jkeiFOcfhErYkgm9j7n70T0qlas1TwDs+ESHwYxOQHdCxfSR9Hnrbrxt8Kl90/MPaTcTiN/X1csiPM2fnhvM63Hi7ofUrU6C3eY0bSqtWXM3RuSbvt1gHm4D+no10B3H8MZlRh0OpPGXKskw+ljD9yJU4vDdzXdpscoN9q/QFwOwGowXaB8VQy2CTGA==
Received: from SN4PR22MB3271.namprd22.prod.outlook.com (2603:10b6:806:213::16)
 by MN0PR22MB3620.namprd22.prod.outlook.com (2603:10b6:208:377::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.26; Wed, 28 Sep
 2022 13:46:24 +0000
Received: from SN4PR22MB3271.namprd22.prod.outlook.com
 ([fe80::90a7:9b60:31eb:171e]) by SN4PR22MB3271.namprd22.prod.outlook.com
 ([fe80::90a7:9b60:31eb:171e%6]) with mapi id 15.20.5676.018; Wed, 28 Sep 2022
 13:46:24 +0000
From:   Mariano Vedovato <marianovedovato@hotmail.com>
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: rtw_8723de Realtek driver issue in Debian 11.5 Bullseye Kernel
 version 5.10.0-18-amd64
Thread-Topic: rtw_8723de Realtek driver issue in Debian 11.5 Bullseye Kernel
 version 5.10.0-18-amd64
Thread-Index: AQHY0zy5T34iddM81U+1MO1UIJjgGq302pLV
Date:   Wed, 28 Sep 2022 13:46:24 +0000
Message-ID: <SN4PR22MB32711526F087B9898CED953DAC549@SN4PR22MB3271.namprd22.prod.outlook.com>
References: <SN4PR22MB3271BACF8FD2F57BEDDACC4EAC549@SN4PR22MB3271.namprd22.prod.outlook.com>
In-Reply-To: <SN4PR22MB3271BACF8FD2F57BEDDACC4EAC549@SN4PR22MB3271.namprd22.prod.outlook.com>
Accept-Language: es-AR, en-US
Content-Language: es-AR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [Rg2LTyE04DCsyr/F40IvIb/4MWvsptaAO5kjRkJcHoA=]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN4PR22MB3271:EE_|MN0PR22MB3620:EE_
x-ms-office365-filtering-correlation-id: 4f07d8d8-1ffe-4fdd-8ecc-08daa157d588
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AUvtqtkzpLFdxQumfpGzqcPZWCMWzuknRPOXlQc/uus9bX9wvGFfkavvBlMaoORNIe3Ej8D7tzdMBzexmWx2NOR/KZgRpnkmyt12dxzVT/hJ536K7+QyYit7l0ti8AgPH5HQ7wu/M6tGeFRYFN7aVY1rKID6KN9sAp1D8DphhJV6M8T1/UREAHyHKwGeQIydFAuaiRlPT13AnC4To4rlI9B0n6XyBggnEjWdgZtjuw63D7AtFCh91r60uYJ0Zzxiiyy1EXpAQ03j7hNRPJxD/cGeGzZrX4oyakPtVPvhB1Koqr7+LFFi4nUMPEgkBPOAXjz+sp5kD9Nbh4XSxApjQyIEr8Z5TncMsx137SHGnr0TIAxm6jA6Ls3HDdnOmXLElZSkgXaXXHACIddomfFup9cb8VZ68BPpDEaTqPAJLryCt0VU6CiVbZblhEMzK1tERqszUfWQtospjUyHIgNl6Tlb4rcmyf66X2t4MWSs3wLwT2eHs7Iyrxx/VQlO/dM3Ss/sbIZs1PNlqJybugUL//Dtg1bbrKLbEvCTVJOoghRLhC/lyE7Vs3Grh54WzYKhovubQr4TYgQ2/1fErk0bHTvuMIvsuuH8KsIekznmZTJVhWpokNdZSAiZI5LjWayO
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?D+m7cCIWGR6q7wNuqAIifHpoGs5314zseqMIxSPHPDPjIVsWrcEJbcwVKe?=
 =?iso-8859-1?Q?pM50tAlQqcbo/Lg+5z7Ozh1mLTAZjDhJRTYkr9QJL6N11/6PEaSrGkLDAe?=
 =?iso-8859-1?Q?xELnvAv6+eSOfABqqB/Kk0gJV9qVuFjWonh43NBKNYuG2zhxZX31usHooe?=
 =?iso-8859-1?Q?SxPVxhbv1uYlXNQbwdyHs0h8m0QCCT/N4v0mS0pDMxdMrWBuoO6bOIGs3A?=
 =?iso-8859-1?Q?Haw1sUyLcRXRo4Ql7t7GNpFtj8FPDu60GhrQCJANBcT/Mn5mJXll1WyIZz?=
 =?iso-8859-1?Q?/KdxRwGwoeg4YTbceyfpuntU5/jANRxWobakPSsQnA0UWiwZuzB0kc7pp3?=
 =?iso-8859-1?Q?hnpipecmwl12OG+Pmaud3JysBuQXoSSjDwQqngyxUoNrf17+kyJEc4NtjW?=
 =?iso-8859-1?Q?p9ZcZjxXlDzw7AkNXKudBpfEENaonz3GOTkQqOuMTtrZdmiYsDXX7YWSui?=
 =?iso-8859-1?Q?ChapoirlTv332aFRWOoGqFtuYxZHND4lNJwbSBBPJW9V7tU+oSA2hhqWhi?=
 =?iso-8859-1?Q?QKMOk6nXPPkqa2DFs6RueqEaq8GuCIxz41ejniKvv132GgO6eiQNXrkgMG?=
 =?iso-8859-1?Q?1qzmD9nwTDOwDiDuohLyy3PXi3SIB8EAJAKL0b1RnPPT3GU7nC+yeWQJhc?=
 =?iso-8859-1?Q?Oz88g/kjM+UuIZtXvjK9k4VRTCLdEFUtxBHQYn2qLjD4EMU4KvO29UBFMa?=
 =?iso-8859-1?Q?b6CiBtr5VyYXFSivEy5VxUqjNGhTf3pdLlQEWBQCrsio58mVfa7Ct+Imje?=
 =?iso-8859-1?Q?azBWqgCnjYhRtZkwhb8XxsKVHiVU/Vjyv36PmxId6chuElnau0b6mchhQ0?=
 =?iso-8859-1?Q?LOtActf3ZE4xAO/y3Bt4FYV084ndNHEZ02QPW+/qf4KGkeSTLaSiDvNicw?=
 =?iso-8859-1?Q?/x43iv5IrIMZYUEvpHhQZYN7jbwJKYDhncd6gH2YF03RJBbZ2xh2cUtrtF?=
 =?iso-8859-1?Q?4Dx/Uiph3m3o9Olg+PuqCwOgA5g8ATt7dYNXw7Dwa3L6dbvEjhPSjWrpk3?=
 =?iso-8859-1?Q?st1E6CaCpBnU9mq5KAE4HEsTc01SCg/U5wxLAg/Z2hGsqsD8pVTNWphQ5m?=
 =?iso-8859-1?Q?55uykPcximBBEvxUrLD5f45vapNeci4x1Z9Zra3IvwaMZO2YC34q47CGbW?=
 =?iso-8859-1?Q?wnK/ypdPNzXBSKoqkgisGCJY9BvnBsyEmhwc02G25hCeUU98tAj7f0TR84?=
 =?iso-8859-1?Q?N+l5H+BB78inI78bYjV5DbwdEnXlBUpOIY3sQ6EgJCHPQqmCSFPxO22FpK?=
 =?iso-8859-1?Q?POGeVDT4Q8E3S7CKAjkUXFNoC2Ka9ECl1o1Ea8dZ0SOvlGXOvkBTcvIUoj?=
 =?iso-8859-1?Q?GlZS2hUibdQ4hevUZx+m24wJuw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-c3c87.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR22MB3271.namprd22.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f07d8d8-1ffe-4fdd-8ecc-08daa157d588
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2022 13:46:24.2913
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR22MB3620
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,=A0=0A=
A few months ago I updated the system from Debian 10 to 11. Always in Debia=
n I had to do the Wifi driver installation manually, the last one that did =
works I downloaded from=A0https://github.com/lwfinger/rtw88.=A0=0A=
=0A=
But, a few days ago, I had to do a clean install. So I downloaded Debian 11=
.5 and again I did the manual installation of the driver.=0A=
In this case, when I reboot the laptop the operating system loading is stuc=
k in "Started Display Manager".=0A=
But, if I login in rescue mode, and of course uninstall the driver, the I c=
an logon normally to the system but without WiFi!=0A=
=0A=
I was investigating a lot, but it seems there is a problem with that kernel=
 version and my driver (there is not a new version of the driver for my wif=
i card rtl8723de) because if I do the installation again, but before reboot=
ing I try what the README of driver says:=0A=
=0A=
sudo modprobe -r rtw_8723de =A0 =A0 =A0 =A0 #This unloads the module=0A=
sudo modprobe -r rtw_core=0A=
=0A=
Due to some pecularities in=A0the modprobe utility, two steps are required.=
=0A=
=0A=
sudo modprobe rtw_8723de =A0 =A0 =A0 =A0 =A0 =A0#This loads the module=0A=
=0A=
Only a single modprobe call is required to load.=0A=
=0A=
I can use Wifi (in fact I am writing right now this email with WiFi working=
 smoothly!), but again in the next reboot the initializing is stuck. No err=
ors I could read in logs.=0A=
=0A=
So, I think that my workaround: "poweroff - poweron, system loading stuck -=
 force poweroff - poweron in rescue mode - uninstall driver - reboot - logo=
n on system - install driver again and use WiFi like a normal person"=0A=
is not enough efficiently.=0A=
=0A=
Kindly ask to you (it =A0indicates from=A0instructions README of driver) if=
 there is a solution for this issue?=0A=
=0A=
BTW, I tried to install Ubuntu 22.04 with Kernel 5.16.xx and the WiFi works=
 fine, but I'm a Debian user since Debian 5 and I don't think to leave it a=
nd I have no money to buy another Laptop for the moment!=0A=
=0A=
If you need something from my side to do a deeper investigation, please ask=
 me.=0A=
=0A=
BR=0A=
=0A=
Mariano Vedovato=A0=0A=
=0A=
=0A=
