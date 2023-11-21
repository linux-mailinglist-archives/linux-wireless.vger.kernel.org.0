Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB6FB7F34D0
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Nov 2023 18:18:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230399AbjKURSh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 21 Nov 2023 12:18:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230052AbjKURSf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 21 Nov 2023 12:18:35 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11olkn2010.outbound.protection.outlook.com [40.92.20.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1CFAD1
        for <linux-wireless@vger.kernel.org>; Tue, 21 Nov 2023 09:18:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S6hpMmjGKtkOcRtznVIkmu43dZVeQoZgV0K7Ld6Y51SRHq0EY6Oab4ogxe74CZjgKvWGW5HccEjNduZetdmHV1yb+fxZBVt2SYoPuTyoWrXF8Ny+SBGo1m3eKGrQ7AS81j+CsJAFKwSX9gkECOZVX7JQebiVeXA70jLKdVk+OxXWbZP2XYDNLkmrGOSxdPGpJ7SOl2lHB678/2Dec8lNO75LUWVsTy8MIWiKNHW8b+LXfwmc5VifHxvXcbYE3qQO4HBcoJMrTSI7Ga3FQf5r3j7ZlX8NzyNmfdAp9KX502WKBehec4vc7uVAe/MLl7nVui5dT7TATmmq7BA6WU7PkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+LZ6MO/U2v66tzOT636+RsT17mWAjgpqeVmoTm0R0Lc=;
 b=nZaI5HRd84+1XZpqIOzNpbIuRazf70Zj3Ogt+jN+8s6P8b8bi/GLGBVM2+JgXw8JRp6XhQL7kHi7fUOyHrk9Tc+b+2Pc607dIJ815u+BcB8agImvnZsb47PZQEhbDI0qI39UvpCAaMY1guLNLmZkznGj7l0XpLVbsdlJmWIPMTVo/gQWjvVG2P+YUyFv+2NNvHowUx4gI/XSwjDEFAXaTDWDOYmMXnF49jOO5U2t4br25RCwpIa2GiLwZnvgeNPXIyoup2mVBLo97JFcCLWlfTEEA/fun7yOdabhj7g3GqcnnN8Of6SC6Uy8NJF2wLfpYPAS1K6rA/hogMB8XotPFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+LZ6MO/U2v66tzOT636+RsT17mWAjgpqeVmoTm0R0Lc=;
 b=DxPi3NuWs9gOZIc+HKkNWb4BJ5+JU7pdjuqcJOFj86mmqKoy5vOe4J19ZYBJCFVAIUpTqaXpmc3xD1Qr5qn1b4GxAIQFzwdyEpLWkPaO52I5tT5HvGJMC8GAXm/1336ZN1/zbgHXF4XhqMv+aHWOUwBSELFobpaPeghdPxR9sByy55mpmr6Y64kn7p4pmf1UheF3Sju1cXZUR7+9vkKD26OYB59w7VfSuLNP915Q5gczj73S1aobLZeHt/AkBielWyXfsxNHr+m3R3PQbqL8a/bk0lwABFI2fF3bX0ckvu/RWbNBCvpWHZZGRgZAUd0OUNG1LudutZssiXmzIb7sDA==
Received: from IA1PR20MB5049.namprd20.prod.outlook.com (2603:10b6:208:3a7::16)
 by BY3PR20MB4556.namprd20.prod.outlook.com (2603:10b6:a03:3b2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.27; Tue, 21 Nov
 2023 17:18:29 +0000
Received: from IA1PR20MB5049.namprd20.prod.outlook.com
 ([fe80::6d06:82ec:16e5:ede5]) by IA1PR20MB5049.namprd20.prod.outlook.com
 ([fe80::6d06:82ec:16e5:ede5%7]) with mapi id 15.20.7002.027; Tue, 21 Nov 2023
 17:18:29 +0000
From:   Jay Sweat <jjsweat@outlook.com>
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Realtek 8822ce p2p support
Thread-Topic: Realtek 8822ce p2p support
Thread-Index: AQHaHJ6/35nL8BzLVE+iP+/w63/TCg==
Date:   Tue, 21 Nov 2023 17:18:29 +0000
Message-ID: <IA1PR20MB5049CDB1D4CBA0FD5B68F15DA8BBA@IA1PR20MB5049.namprd20.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-tmn:  [suTbYbiArA6iZufhVWgWtfqivuS6cLqEmRO+SyNxbi4=]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR20MB5049:EE_|BY3PR20MB4556:EE_
x-ms-office365-filtering-correlation-id: eb2db329-c29f-482a-2d9a-08dbeab5e191
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Zxo2D/tkzT3S0M4SO4hMeNL8Hkp8YlutQdEAgHZ0owWEngHRytGuTQz/4FnHJrspBvh3++e3OeyO7L2ujVgkNGF/3MdClNIuQ1jLGhVtXIGi3R6nXogfSJIMyZCiyM4aAWNxDr/4B+MXRuRLByuryALWCOELGHUkHz1nT6aqyv5G7nETrUFM0En0JXz1ACFiyo9DIQvIcBjjA4LhQVtLFvWlJnC5RpLisbAMif5AK1yJhJgJhKSP/RgicpZQRQMnWmNNszLu2lk4ZNcCrUbUmh7mCclEcL6E8AWbCU6FFRZVplxuUoL4fJmXrvpY0jqnaRhqZKMy2fRG6lU9ds+xnoNk3zVxzYq9dkXivSaiMtoPcZXSy70JTNwmZW2yTseJkcEV4G3yXfkuwbjnuqzf26eZgdU8Fq0im1CSSmBaRe8ci+EQKVhcI2AwNtTehpq0c+hwaekh0DFTAOU0TMXypwbENJBqe4x7vXtQd8KlytkWQrF+RGBLnirOs31LObSIM+w25CpC6LjXN8dgBZI8xM2uSvK9xiVVqOnbw2k4XkP++Mt/muKGsOfqbc0IZ44U
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?rofr8Ucg0NG+LuoiGgX1nmXFobVP1fLM0Ym2l6UuuD/4XVAJ1Ev2hqLkyNK+?=
 =?us-ascii?Q?TbcBy3hvAcYM9VKuEcp34STt+dbPOp4NZzVeeZYkEezKqMqmeJOHcBgGF1EA?=
 =?us-ascii?Q?3WvTgxRtydOHjI18nF2MvmpQhLlRX/Af3tPqsiNVLg3CV77e+uUJFGv1Iur9?=
 =?us-ascii?Q?NyybA45R/dGZsO/v6+GjkO4y/ukfDqCvWIm0mXL5WEeH4cpxPDRZYlFzlFLK?=
 =?us-ascii?Q?s01E9wIEtlbq/YQ0W5+v3mAUd2CepVdOS7JX8G6v7IxYOcwG6g33U9Nu6TAZ?=
 =?us-ascii?Q?Ba4paLlHe79Utzneu+1q68t3zVuVnmZwn6P+6xtMbdxD5wek/heMKpxMlgqV?=
 =?us-ascii?Q?H70PJtshYd4Xeyuki3OxleZSweQo8CTVKw8RFkSgOw7+NsIuUGOHLwobN33S?=
 =?us-ascii?Q?uxuYTuE4ReFFMIaBmdn/h4/IxnMkdrPy+2qqB+SBYbZewG+09+kg/gfch7Kr?=
 =?us-ascii?Q?TxFlH0uUk26oGXkrV4t5A5n30qkAxe3uc9C2g05ggosVMQKl9QlcpJ86cFYI?=
 =?us-ascii?Q?N4gQEgr5I4EgIeMixj/4wXfpEZavSrimv12Lt2ZTZueXWcRRxXR3sSwV0G2P?=
 =?us-ascii?Q?j+ylaiDzPb+k9t/vtH27yRSurY/HJEvdd5k+32DWfFN0orcZvYjAqznakoCR?=
 =?us-ascii?Q?OfC7fHz58r0QAO7SUWbNaK0Bn/AO75dXHb4RCihgRZqFct81wUClGR6GETIw?=
 =?us-ascii?Q?DIAJxcm1Z+8kDGpo/8RY59drzHB3K5zqtwGjaoZ0AtlmYEK7uOMZE74+qRvT?=
 =?us-ascii?Q?/U+ECwYDZeULTwpDVN4F7g6W0+4LKapd2gkdbQF16kXvxLdx7v7sSmY4SEJJ?=
 =?us-ascii?Q?9XTk5mdFaC65gOucFGvdCEoLs505uKtVf1gMYS6R0S0rAEfkGbD8iFkvMBEb?=
 =?us-ascii?Q?C/JlJX2+TnWdrl6JplyOH4FIrqwYNLTnrsiNu1SCovg5h77RzKQRkwCK0c5e?=
 =?us-ascii?Q?EwO97ZlYFZjpo6WLlfH03AKpdjJe0VHks1bVocPCfnAx1f1uAtEcqQFdKlJu?=
 =?us-ascii?Q?rcjlnFwmj+bArd2EaCQTO/Qx9FeNV6SbRh1fOMK3eXFHk8wNL+h21xMAyFrH?=
 =?us-ascii?Q?ztlnJvIIWi2np3xPQpnjXhQvIFsMQgrAM+nlcwYAeQxA5Vf7xHOkHOZNfh5l?=
 =?us-ascii?Q?683oz7+q+Bk00LiISp0PxNBZQhjDwD7t2udWUKy90uA6/oQrIXTEJZtfuIgK?=
 =?us-ascii?Q?56LgSoxkd9nl5P10IRCUbGI5COsNPzhn4dt5GtAeZCZ3C0rDr+s7wVTq+zc?=
 =?us-ascii?Q?=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <0907DD8805B5B54089405253DEE067B1@sct-15-20-4755-11-msonline-outlook-9803a.templateTenant>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB5049.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: eb2db329-c29f-482a-2d9a-08dbeab5e191
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2023 17:18:29.7218
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR20MB4556
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello,
I am trying to enable miracast via gnome network displays, which requires p=
2p, on my arch linux device with a soldered realtek 8822ce adapter. As far =
as I can tell, then hardware supports p2p ( linux says so and miracast work=
s in windows) but it is not enabled and/or implemented in the driver. I was=
 just wondering if this was a feature that would be added or if I am just w=
asting my time.=20
Thanks! =
