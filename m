Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5730E6C90E1
	for <lists+linux-wireless@lfdr.de>; Sat, 25 Mar 2023 22:05:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbjCYVFj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 25 Mar 2023 17:05:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjCYVFi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 25 Mar 2023 17:05:38 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11olkn2010.outbound.protection.outlook.com [40.92.20.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45924D50B
        for <linux-wireless@vger.kernel.org>; Sat, 25 Mar 2023 14:05:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=joSDJizAxqOexzqGWDjN0JtnjHNOBupOuuzSPx1FoSWOc0orovbZbko+X6/LiXCwsUjy/34Kpr6OcsyR2zwk26a44R1Aljq+Hy3FlSrDUX6MzhuEIiopRxOu6n1LsByahRLYQaKlo6gVOfj16ndo4Rk1UUrP24IfLuAF7RONsH46QOA0cAMu4lVnnxAO5urE7j+8AwTIeSfiuN9ctHnnS/McBwXfp0VFa322tovPlZwR3exrYEg2+hrshT9wRSssFd29olF0Ywsqukv9YwVudtQzhZ3CRy0gbDQdksGq3JPUb00SsIKaYZ624aj67/JteDpSDHAws1yLOYgetaiP0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qi8GrOKbJAeEwCWaKkZYXqXStVMdIGHwe+CwCCq+eRQ=;
 b=mE+o3X+aejc0HvBQ3lk9yyDertEEDBMJAkl5sss8d4064JC//SPijqvOTilAghub71KmkltGslMwB6TW+IL+Fd23U3oIG7gM/Z2dvCtaKcvFp8+0nYr9ZwaX3yL5uaMkhduSUqDLl5gYfIrVarEjK2UUd9CIfzUO6rutj6izljuShm5AGpBAwitSpECdFDcgxvVO5FNWMFf28jJ6EARTbGbvGfa71NFW/LC7wNnICXVpJvk5Yz5zQuP6GqMUtdXvBMImQkfOVe9+x/Zes3zRA7uloMZw5aqMBLsXEaCUaCHF/lihSy3VRWrq0U+FOummLVKgdeOZLgfygCUNlqwXoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qi8GrOKbJAeEwCWaKkZYXqXStVMdIGHwe+CwCCq+eRQ=;
 b=tw6Hlep+DHLOWz3TWliOeUQZXRfShBn8yjDRV0aQZOnpocOPQ1VXYfgbj7a+PKGwreNadGVutSyYee+r1SV18EMpjV69fHR8939U0lF/zSLzbWVfn7CNHDzlH03xJ7n1gbtz/WITS+HjD2mbxq4S+8QTqqaRtVMyx2bS1ycKfR/VF1UBVkItf1rXmvc7fiwsebmqP7U1u3rTMb7Ojs+4pMCAFVxrCzjfY3pYcvXmV2qMEGSPnuR+DDcP3WgvId48If00ZomZfX5tZMAr/2TwwOq7b0poL2Es9zeE0twDr9Q8qhjMt6B0KV89asOnRrBFh0pmit4deOO0vMN9ZCW2Jg==
Received: from BYAPR17MB2597.namprd17.prod.outlook.com (2603:10b6:a03:90::32)
 by SJ0PR17MB5037.namprd17.prod.outlook.com (2603:10b6:a03:3b8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.41; Sat, 25 Mar
 2023 21:05:34 +0000
Received: from BYAPR17MB2597.namprd17.prod.outlook.com
 ([fe80::8128:fb8:c7a8:57a5]) by BYAPR17MB2597.namprd17.prod.outlook.com
 ([fe80::8128:fb8:c7a8:57a5%7]) with mapi id 15.20.6178.041; Sat, 25 Mar 2023
 21:05:34 +0000
From:   Any One <mohammed_kalanawi@hotmail.com>
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: TP-Link 
Thread-Topic: TP-Link 
Thread-Index: AQHZX12KT0sc+gR1rE6INcf07ma/Fw==
Date:   Sat, 25 Mar 2023 21:05:34 +0000
Message-ID: <BYAPR17MB2597C578BC6938CD18239EAE8C859@BYAPR17MB2597.namprd17.prod.outlook.com>
Accept-Language: nl-NL, en-US
Content-Language: nl-NL
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-tmn:  [KNAm1RhNsYBrkD7zc2eIJxE56mSrBDfb]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR17MB2597:EE_|SJ0PR17MB5037:EE_
x-ms-office365-filtering-correlation-id: e3de0915-8fb4-4430-86fc-08db2d74ad17
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rv/GZmDomfOSRX3dNREJDYnKPBOUffDcLvpPTdKs5lLSueOu+jMN5KSsSknGVLNTDVpyayGhuf8BnCixkPWaL/dBPNtPzzzMMZXAkemt5dDEKGSjybtwZ8OIDa8hYYnvCJVQLGRCxfswOS4Ger5/gSr0CoH65Y8/vZ9yBf8T1LJfn/5FzGkmMg76uYAtAN+KJxLky2s9oHSe7PwYHHsuj7NlA0jdo9VnVO7z/tFqkwXzMOehfRzQo0sSQfaEMQ6QppO/E4rnv9WnPLTDtmwnq1tMgrBf1FeasvBHeEaz6UAga88q3vk9obJODEcaWN7VDUl37nVR2RAE2bPc9BLPt7dCwypmCJnt8S36P0pXO8ZgTKaAILA2dTZzPBFifs80vfpRtPnLCTWWsEM7zMVqq6S4MOPxuhri/cLG3u8latz6A6h//NldgE7tF3Bf8xSlkCqRhzEOydWZW/p+q0gDn4VzLwWvf8+jDcHKr85IW3rVUtWE1E8Yg4tzwIiXnQLZpNURLvJfzbgUiNUEkUeVxAhNKpCclT/ZDvfwTRdBlncDDIDSbmdmETx+VkEAyzqA
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?nRjmtXnIo5feeZ6YH2f28V4BrPinMe8922eLx64BuOYDkD08Tu6mQuRwOdrt?=
 =?us-ascii?Q?NupY+qfuu3jpV5Dpy3nLRmapZKdaQkZGwC2aA8lwSK44nQPfr8/af7n5R1Sn?=
 =?us-ascii?Q?D2PA/JZGShb4Gwkquek+Fxip/k6EYJJcYsweih6PKv3kvV0hL954dyY6aNsJ?=
 =?us-ascii?Q?vqqV6lQu600HAFMyKICXWZWZtfx1Ilcxp5wOhNn7eBLTpCGyPC7RfPxEdqzx?=
 =?us-ascii?Q?4zd5L7/f+y0KTmCJ+WDRAqQjxjYAql4E1eg3/bx5J1McnR8q3iVB6DkNs+VF?=
 =?us-ascii?Q?X8iXpe9bSZQ/+zFUporNSXRL1beqlsFdn5oHMM4NXB/P1lJYKr9i4s0AxRfu?=
 =?us-ascii?Q?ZQCJZ8zwUOuXOFLqz4nZ122szq9V1anqL5VmDR3ISOTpRPeIQNE/r8XqMI3v?=
 =?us-ascii?Q?wsIBpY5arYDwQCPQS/CTv2pE5L+p8BBlpsNwsa0v35lCqKnP+7jQiTIbFcty?=
 =?us-ascii?Q?lHvS/8lQaZ3RFDbfe6ANrKz45fmzz6+4tEnyeQhTTiPKoVnQ23enRY8+4eqf?=
 =?us-ascii?Q?+5iCHBZXZoPW1QhPda5yWpohHJV0T0LLnwcsXlZFVy0v8j/4XUzcrta1z3dT?=
 =?us-ascii?Q?1Qkx99KIRVmbdywQ48WxnYIBnEAm11sg5ZBPNDuxxkpCE6Wx7lq56EdQIq/N?=
 =?us-ascii?Q?C7+9vzwM8bUP/N4VC9Vjt209CLj4I4RStbQ7LW4ca4R3lUhQfw8Xb5m8sI+w?=
 =?us-ascii?Q?1F7pXbMfeAi8qnx//kiQcfmNa+X59/8MZclA5koeEkRbv6FRY3lzhgyiB5Fm?=
 =?us-ascii?Q?DM2lHNVv9PiTy2I0dfGE5b9DIYB3hHd61jL7EwaQ6QNThW/Zh9sf2tRuQlP+?=
 =?us-ascii?Q?J5+4ssFnLsnXxj9JM6+cROnuUhzY7/Do/n03TcPraSUmikeP0LQjaQJlqNeR?=
 =?us-ascii?Q?0qWEBh07m3dxBLH8KFxrcPdsSe+BwxF0WD9L4vg0ul6uCrRFDdUQ3yDeHxNh?=
 =?us-ascii?Q?GgisH+2F0KLI1xlFB70J6DqB6Z5AH6xSk3IJ4+wSmSpzUpiHKfc59y5RPSp8?=
 =?us-ascii?Q?bPuvPsklRbkiCcrbT34Orn9UOPEOfUdUH1Wne8sn06ifd4fcPoam3Z37Cm5R?=
 =?us-ascii?Q?L6iYXHX+kwM8Uk4qIZrNGbcdca4CiRTkXuDFgp8Eq3HPB5Ow+861UcHSZ5eo?=
 =?us-ascii?Q?i5kSlIwGUTomf/PR72/4bN7rkQgJCU2fL22+ibUfUQ3aMtP/KrPKvkvWns+V?=
 =?us-ascii?Q?lPRaz7QHfla9iOOrBYz8OOD75yzzJ97L/T9QLHvW3Tf1mu5qf2ig5/mPgYY?=
 =?us-ascii?Q?=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7A78AAA2ECD78C4798404515C2D1FEA9@sct-15-20-4755-11-msonline-outlook-cc4c0.templateTenant>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-c704e.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR17MB2597.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: e3de0915-8fb4-4430-86fc-08db2d74ad17
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2023 21:05:34.6044
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR17MB5037
X-Spam-Status: No, score=2.3 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_BL_SPAMCOP_NET,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,
        SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi, support-team=20

I have a question about the TP-Link=20
Its about that I have runned all the commands=20
I see the wlan0 and wlan1mon on my screen=20
When I type ifconfig=20
But when I run the airodump-ng (Blackscreen) ???

Is it about the WiFi-Adapter=20
Because I know that I installed the wireless adapter=20
But still see (Blackscreen !) ???=20

I hope to solve this issue Fast!=20

Kind Regards,
Mohammed Kalanawi=20

Verstuurd vanaf mijn iPhone
