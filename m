Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2BA77E966F
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Nov 2023 06:18:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbjKMFMz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 Nov 2023 00:12:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjKMFMy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 Nov 2023 00:12:54 -0500
Received: from CAN01-YT3-obe.outbound.protection.outlook.com (mail-yt3can01on2082.outbound.protection.outlook.com [40.107.115.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1C21107
        for <linux-wireless@vger.kernel.org>; Sun, 12 Nov 2023 21:12:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jaBZCs9COGQh4Wb5oZSp6G0mQkqj832ReyRtyv6hA+3xi6wAqJ6RcBYtlwEwNkIVzU2OWopOHR1y++6h+2J6FF6WictEvs1SX5TqWGGABoGd7XtNQd23e56bkognGD+0ioU432ER5eDU2Yj5B6AC2VQfsXXfo6yggPZP+0mfvghaTexThN/uuyNpZHq/Ksn7GICpEI4h41J3WspPMCg5+WxPM+PXv7hssrSgz/2+BjDuwspthfGgpx9YyE60wenYZIAZ7z4jYBw8wQYjdi4Cn3wuZgK6zX8uhA3+w4YjjrOau0+5iB08Snv1foy7TF9j7quateNM5+cqQdun/pDWCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QeIW8gl5PNVv99+ED9kxAUt4vl753KHlWT0Aw8d06/E=;
 b=CiX6hFpZW6Zj6MR9aOk3vSZAdNswcw378pkAccwmtuSh8qgKTk47UdIsqunGFb5CqB94fUfmXdFTb/LGq25kaModfiBvOkkmkCv3ejUvrJEMZjVQahbg68+goFEzymDZkjcyEr2XnCT3my4HdqRI1xSXpZmq1w6Y6DiNDhfg64vghVjqhEgbzl7eR+SlGNxFk/13DJ/t66PWJWL6XvE/9xhXRRT23z+wujUezR3231pS1cAmIsKGDUAsq7g1so9/pDMK+LlZ4R2nWsS8GnoBwrZ1Q1m+wLsVuXpqVM/zN8PHcGPHqVEJDqTLYRJ4ZxDYppNNXfifwPVYdCdZILVwCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ucalgary.ca; dmarc=pass action=none header.from=ucalgary.ca;
 dkim=pass header.d=ucalgary.ca; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucalgary.ca;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QeIW8gl5PNVv99+ED9kxAUt4vl753KHlWT0Aw8d06/E=;
 b=TB1dkcwJaq/NbQVyjy/tgGu0HmJwjVluz6RV+zHotpuE+mbYiHbl56C2vqHLbc+sOdM7lqnBLMlb1w3wl00yQh9XrvxNfrBzOm9U6hJo1emDYeNqgnrhwbdv1lE2sQtjdMfAa0R1yXx71w8dPUAeZw8Io0gamSSE58CxVGp386g=
Received: from YQXPR01MB3302.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c00:4a::23)
 by YQXPR01MB6382.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:4d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.19; Mon, 13 Nov
 2023 05:12:47 +0000
Received: from YQXPR01MB3302.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::654:1e5c:182c:3985]) by YQXPR01MB3302.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::654:1e5c:182c:3985%6]) with mapi id 15.20.6977.029; Mon, 13 Nov 2023
 05:12:47 +0000
From:   Wenli Looi <wlooi@ucalgary.ca>
To:     =?iso-8859-1?Q?Toke_H=F8iland-J=F8rgensen?= <toke@toke.dk>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Kalle Valo <kvalo@kernel.org>
Subject: Re: [PATCH v3 00/11] wifi: ath9k: add support for QCN550x
Thread-Topic: [PATCH v3 00/11] wifi: ath9k: add support for QCN550x
Thread-Index: AQHZqt/G/aBE/A4XSUiJTbXxp5sFX7B4iQFx
Date:   Mon, 13 Nov 2023 05:12:47 +0000
Message-ID: <YQXPR01MB3302EAE07CAC3989D352C054B2B3A@YQXPR01MB3302.CANPRD01.PROD.OUTLOOK.COM>
References: <20230629231625.951744-1-wlooi@ucalgary.ca>
In-Reply-To: <20230629231625.951744-1-wlooi@ucalgary.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ucalgary.ca;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: YQXPR01MB3302:EE_|YQXPR01MB6382:EE_
x-ms-office365-filtering-correlation-id: 34087b3d-0e7f-491c-bfb1-08dbe4072cfb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7sTwfE8v3vP44G13kqMC7kZdgXqtsHydX/tt+xU2FonDKO2KAUeg/xFFJkLmvW1aGi8vKxFtSd5WxJ4NFTlNs4RLSYigJUEoj9pB4yaMeYqu9ArEEBAFrshV6PSSYjBI7hKRWvJCHW81eniAwJVG34olimIglrrgSDC25Zc5kb7Dktene2RxPNnv7aoIzgK6R7fMdzyXb6b+SNw+qdaLbJZwhHI22IFQQ6jpH1MiXwSNSSsS3dgE0+z1h9o9r8Og2ZqD5IPtqOm2LffO59tgzbRbxOLo9NHHcWrsg3yXULs+L488o8oOesEHyKEgsYhjIfxrmNnGsuc4bop5kDg1YQ56k8kE6meHcvrOnUmgHG1lqKItK/RY69B7/p7d1H4VrKzzuCEvbVpLRc26avley0Wqg5+2JY8b5lniGO0L/7VEXMnp/ZVMh6182+QhZV+LkTxdDZ5fJK/H9M9aOZe0lk/LdaHMEuCXdYLPRR5i9ANqooCwg1T062ioNI7wf8+2O2LYJ0Jh4rU4/+rtGZ2Lxw0B3WqyZgq0bDyWYloVcVfz4sTWWeMuBMcV1bXhqlKBJUYp0BCDmds0d/5AIIQg/HE2nY90dw5fjpV+mngoXWM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YQXPR01MB3302.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(346002)(39860400002)(396003)(366004)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(33656002)(38070700009)(8936002)(83380400001)(316002)(26005)(66446008)(64756008)(91956017)(786003)(54906003)(6916009)(76116006)(66946007)(66556008)(2906002)(4744005)(966005)(66476007)(52536014)(4326008)(55016003)(5660300002)(478600001)(8676002)(71200400001)(6506007)(7696005)(9686003)(122000001)(38100700002)(86362001)(41300700001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?n4xE0UHkZ5hTFk0x7maNghUG+m4uDy/CM0Nec4X7j1lMRlUDVzNM8CbS9j?=
 =?iso-8859-1?Q?XN7KLFp6eF5TNEoyog1sicOSssHoNufqeLElqVBysU3TQ1cW4YmsoSgSsJ?=
 =?iso-8859-1?Q?LO6DY2jaC+9cDM4bGpvW4D3WIQa+LPv3hFHSHJqoAk05kZetDZEo4CK2d1?=
 =?iso-8859-1?Q?rQ58PNCAXMNW8gDaHAUvU/8nOFvL8Ne8r1Na0PMzAmu2dEpJi8TbAST1m1?=
 =?iso-8859-1?Q?ulaTARzoSP1bcs6kfAa9+UVHbb2kt6xjMG/reL0JagDgpzgOSwWPUmd4cE?=
 =?iso-8859-1?Q?uHHwnGmZyBQRausn7QTkVGlDzVrGPNo4emkPlwxLhNsslyhdzMMmsi/ycN?=
 =?iso-8859-1?Q?eEU8J+w3Z9TYZ7TpuXzYOcs3yJlR5oNZ3fpWob2vel/8gAATJ4niLwZfC5?=
 =?iso-8859-1?Q?VTY/SMNb7+9Ag8gzmw8dORaAvgEh4GAdRk3Qz0iPtx1gF+t9g7B4lKPvWU?=
 =?iso-8859-1?Q?hHVQiO/Hu59ZFFrlDIqcCbQ6eTxYnnw7w09hIVTUYACH6Z3/q224eSquYh?=
 =?iso-8859-1?Q?cAEsw1VJJGHzm7RLrinTplLfahKE7sQo9hB7UTbJUOiMpNgwRjEnXzN+Aj?=
 =?iso-8859-1?Q?B+2ldn3N26WooZWS1WZqppGMetURouwHCs+CGshe7lQfZ0y4HQ/GnXFO0S?=
 =?iso-8859-1?Q?EjH2BD6p/0TiqFudcr0RUEbHgi6Pk7VdZrNHb63b+l4bxh6Me+VfNym2Kp?=
 =?iso-8859-1?Q?3yaMXcf5lkvS+it7uEExJ1GkMeyCwQHrkJ7nm4cT0nITTaWucqgLHR7iUE?=
 =?iso-8859-1?Q?vbovC6NV4De9RfU3CWXu3Gg506D4p0QMtydCS1GI9/Qca3jb0SYtG2PTj+?=
 =?iso-8859-1?Q?tvcRxA+ea1GY1M5MrioUA4Zg+MuQY6GHZy7iR4CPKrxY69Cl3um1UFt9WV?=
 =?iso-8859-1?Q?VskPT0011nFisk1OfPIz1mWO0MVNkhSL0qxqoEScHILsuX5ZR5RxGZjAHo?=
 =?iso-8859-1?Q?HKhxUC1bxrDtPEiPVGwzDKo2ZrtDgj+Y+ONyudJbORGs9eghMktA+dzCrC?=
 =?iso-8859-1?Q?wC/KNgKpBVUGOkW3JVkgxDh42VQ5AfN512isTAj1R1hjFzwH9onyMm4h4f?=
 =?iso-8859-1?Q?zWzKrhq4Eq8Y2uw4sjqrpXFTfRi6jsHhWncJPn6HGalqMeLLIXBVaJNQ5q?=
 =?iso-8859-1?Q?in5tFQPXp5M0VQ0qOVR68KBwvYbicmFBGVICZ0MmvT0z1NA/yAi1dTEyhJ?=
 =?iso-8859-1?Q?txNMYwdIXEHvNn8zTtBNP8PiCK2y5yDZ1QHIcKZcuBEZYfac42pEghdfID?=
 =?iso-8859-1?Q?hovBJ+D7hL+2TbMRGM+7wC1ttJAXRTAcpvgHkziyl/nCiTvsi5tokLh/wJ?=
 =?iso-8859-1?Q?SiQ47fTYoveGYUAkP+4hVrKpljq6Z8aqi3EbcjM3iCUak/8LR9f7nJADoJ?=
 =?iso-8859-1?Q?h1YfHrPRYO+z0AI8ZKCopr497xeyh4C6XWCk0PsCh3+lyFiXKKigB7oc0v?=
 =?iso-8859-1?Q?Jdd0NLqwzxzAHemJrknL+fTCiC0KCR8nFaq6t174iolBOU0mnAGnOVX1E5?=
 =?iso-8859-1?Q?/+D/i2/fr5a+CI/z4CQ6N4PthJSe9imm9w8QxR3WactuAN0GLqUdRMZsVq?=
 =?iso-8859-1?Q?Pwgqg/JV0dfEseU6g/8sV+uS+JsDZRaxjSq6zlFhskMfFrtgHmWKBBMDMB?=
 =?iso-8859-1?Q?eJyhK73kvv4vs=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: ucalgary.ca
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: YQXPR01MB3302.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 34087b3d-0e7f-491c-bfb1-08dbe4072cfb
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2023 05:12:47.3515
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c609a0ec-a5e3-4631-9686-192280bd9151
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lWMwU6wmWL7vLWj7rdMzlrDgqM08lZiA2oLtUKwP2Tuf0GL+PLwwmjMwykjtII24ogmUZQGwnzV4Cs/AGsKDeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQXPR01MB6382
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

I've updated the following github pull request to show how this patch can b=
e incorporated into OpenWrt to provide 2.4GHz wifi support for all QCN5502 =
devices: https://github.com/openwrt/openwrt/pull/9389=0A=
=0A=
There are prebuilt images for all existing QCN5502 devices, and it is also =
possible to build from source for any device.=0A=
=0A=
Hopefully this can provide some context on how this driver can be useful, a=
nd can be a source of feedback from others who try out the driver.=
