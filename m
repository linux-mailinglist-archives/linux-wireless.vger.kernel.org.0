Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3DD738FB1C
	for <lists+linux-wireless@lfdr.de>; Tue, 25 May 2021 08:42:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231273AbhEYGoT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 25 May 2021 02:44:19 -0400
Received: from mail-eopbgr80080.outbound.protection.outlook.com ([40.107.8.80]:27296
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231197AbhEYGoS (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 25 May 2021 02:44:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OsvsHMIPf71BejdYArTIVpTSOD2cqeCowT2A8WiivLBP99AjcPaOOMx2klL8TK0vXZxXi3+nB2LP0ZPEbC8l+oNIQQouaIBaLTky2vLdRYvykwZFZF/2j7+JTBpTD3p4i7AEVnRgOafmtGojgfp3FoTQPR3w413g2LkAnWj5XJSRTrYexrTWnDi4TN3an5Nkh/9bMUIBpDI5Ii4J6ysZpzVsg63zX1fr1HsUJG3XzWzheD04vwmdBlelxHO4hjdZnNg8LwmRRaikMTjHNBQNH0Ksq90TAUle8gaEErq7KrTBDfAYsV6bF2mdHu76qar1WtMLqQKPKKCSq+5CpzY9+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Re9pHfSAL7QL3U/UKbkHCPtl309UdCEL5k4C55GqpRs=;
 b=JRLeKgn9SnpFRgRIwoFM3FaGEWfGxYeF6W87K1wQ/Zwv4UcLgEfR2a6QtRCuf9czBbeKIxAb1pIZWAQd66GoMrHY++uYr155cmobKmydBuz2mECcVyY9w4Qzx2RY0d9CTumpapLUDaIKlqcRsFaG8B8Gk3CE2gaV6o0Ge9jhbSuhzZS/ItzU06xbx6z9fff5a2qvwBYbwOSAuI51FzZSXKDAwLcEKwTMVOibSDGO4QBYNFLbQXKjFBm8uJ3RzaX9PFYpqKnjM+aGdsoc6NThVwptJneACFMacZWyhQLdnklFwLVfGcENJa3qYcOMEqPbTQT8Pr2WV3K9ld51jFmJVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Re9pHfSAL7QL3U/UKbkHCPtl309UdCEL5k4C55GqpRs=;
 b=Gfayf0vrqKTzso4nLbv0YC5XyW5LyHUR4z9Ap6BuiFqqhkeYfJSAMvE69NeLhp+h1D56XG3vyJn5sxPGtIoqX4rz0mdMj51pqEhr4ENzu34d3ji+I3g8QHznf55aTQ9hIq5Nro1bj0owN3azxHzJdCDEyAmlBtVQ5j6BU37xuOg=
Received: from DB7PR04MB4538.eurprd04.prod.outlook.com (2603:10a6:5:2e::18) by
 DB8PR04MB7148.eurprd04.prod.outlook.com (2603:10a6:10:12d::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4150.23; Tue, 25 May 2021 06:42:47 +0000
Received: from DB7PR04MB4538.eurprd04.prod.outlook.com
 ([fe80::74dd:4a7a:3f72:c85b]) by DB7PR04MB4538.eurprd04.prod.outlook.com
 ([fe80::74dd:4a7a:3f72:c85b%4]) with mapi id 15.20.4150.027; Tue, 25 May 2021
 06:42:47 +0000
From:   Sharvari Harisangam <sharvari.harisangam@nxp.com>
To:     "linux-firmware@kernel.org" <linux-firmware@kernel.org>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Cathy Luo <xiaohua.luo@nxp.com>,
        Rakesh Parmar <rakesh.parmar@nxp.com>,
        Mayur Arakere <mayur.arakere@nxp.com>
Subject: pull-request mwifiex-firmware 2021-05-25
Thread-Topic: pull-request mwifiex-firmware 2021-05-25
Thread-Index: AddRMRR92hX51an2SCObLVa46U9J2w==
Date:   Tue, 25 May 2021 06:42:47 +0000
Message-ID: <DB7PR04MB4538AF222036C6549FF460EBFC259@DB7PR04MB4538.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [116.75.139.158]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bcaa4e29-5b83-4257-0644-08d91f484f2d
x-ms-traffictypediagnostic: DB8PR04MB7148:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR04MB7148969DB7EFB8D6E4CE82FEFC259@DB8PR04MB7148.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:330;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uQdjyGlBZBWa5K93ZCrNiPgj5qZKZsSznze5M48jXY9US0S1epZOaD+Tfser0Uoz8TyT7UQG/Con5yC2GsmsXVVwscUFJwuqDRcyO8cliIyg4ANLDxodINzwXznQuj84g+F6emhZEKmnQj4IOhI71xDMV+84ez9vP7oxDvwoKv91FwSooPVNpHHEE7/WQD6kmo6665r0w4rBBWzTijpmoMvBp/5wFktymL8oHVIXayCMgVUnLgAVwChl95TFUgVBFmRX9+7EicZMyPOT/WS4rL4M9RrrGikzBmYEGzxbEdo54R9iyxHTJaJe+8IiIWZ1rvJepsMw61zZeba34xui3OMQkb+zB974UnoDwMVcqGRaWPdEcwMG234GTpc94K8Ty4vpk/F3RfoYcueJS7FsTjEQna/U5GvR5tkaxLzghViqCECZJKPz2+yVIBrjVpoCq0Hun542ydAntDS/Mi9xpEJku7nH3/o2WyPdw6IFdO/jqA4Rvbon303jTeRDRB4B6gdoKYPIbqPSqmd8ViNWPqlJ4jHs9GeZni2tdIs4m7rBmTx4eiqfjSb01NPleL8oormJmGSwabXYm3SkoVSDQlXe3CVAhuVhkERlO3ekwQ1RIGca37P3S5OjckVQyf3qRxhbbwQT5/jwlCuyf2t0nwVbBX6Y+7Wzz0Z8R5UaDp4F90119vTb7t6YCUDd3Kdd1KYcPdQUqa/p+2NQ0iMmz8uWzmM72PdaHNXKUT9yfmc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB4538.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(39860400002)(396003)(366004)(136003)(2906002)(66446008)(54906003)(38100700002)(316002)(966005)(6506007)(122000001)(44832011)(26005)(4326008)(52536014)(66556008)(64756008)(86362001)(66476007)(76116006)(5660300002)(8936002)(4744005)(9686003)(55236004)(478600001)(8676002)(71200400001)(6916009)(7696005)(55016002)(83380400001)(66946007)(33656002)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?JVg7OlSTQLg4zAQtTBuAhmtgXt5AMxck9pxTi7slJmxzqIlfpUsUlFDDnY3t?=
 =?us-ascii?Q?9SMmrimBHR6eTdAWcXqyhwfrKFx4kla19uslqgo9YxklE5cTb1XkYSGq5SwW?=
 =?us-ascii?Q?Zo+vN6jbbWEDHxPA0ZA5NfK1xWrJKZhjIxBZwHUlBZqGfa7aT2DZ7HvTwuj1?=
 =?us-ascii?Q?Yz9/Nvqx+1pwMvtaogfnC1F8uTK9P+NzKu9zolLzA2ie2q0rLKrkFsAzqFLd?=
 =?us-ascii?Q?iVKojEZjr1jvjRkrJ39dZbu6EEtEUZiFQhD4xBTGLOWG+E+DQTmF1D5SBwhL?=
 =?us-ascii?Q?NafITb77H5taQ3PhrPcLp2CZhKCiDKp+5FMMHZFsjiUiWyrQbDuuWo4S9oWv?=
 =?us-ascii?Q?9GBxTCkm5nXMcGoRwVceQBQWi5EmpRrGFNYwHgXtZkvQnVbUiNWkS1KdMdzN?=
 =?us-ascii?Q?InzVOaWDkG5sVGGwrI4hl6oaT3wnizzT6kVZsZwqhoQyWyu3DUQoxi7HGuHE?=
 =?us-ascii?Q?fd9klc5oMCYa31mokF1I+q3CHydPSwlI3NQbbUuGnxMRS2MmwPOzr6y1oCGi?=
 =?us-ascii?Q?rNRqyq0LKDEjNtvIuQKfp0rL560PhDBqM8TY/cuBoa+/icMD4Fv/D966U5Ya?=
 =?us-ascii?Q?LN1pr4dGxYt9S6pEyBmHIw2YVZFS4oI7dnOwQZi3vKuk2hVO41/4dB6WB9NC?=
 =?us-ascii?Q?lDTE0IMuqD4QJKYkubApzKYvPyNBvIgReLrWt3CMw/yWaEdjbxWzghyDTNfG?=
 =?us-ascii?Q?gJoNKorsfwcOp/Jirr1BfjHx2qgoe4x/NOKEX1z+AwJDjea1PO4Bg5Kvm2Yd?=
 =?us-ascii?Q?neGxGY2af+UA0bBzftRsy/fkGaeLxPGgUchzVWchqnbylgWthzCRG+46rWVM?=
 =?us-ascii?Q?B74Xi9rHb3KXtEXw84mNQEhX24dRgfsWRwRMjq5FnNAVsrNep6PeDIf91mik?=
 =?us-ascii?Q?pRKNnTZWaB5sqNcCxt07idU2NuadmzAZ/Z+fe4KmpAulFqQt5sR3brBnF36D?=
 =?us-ascii?Q?uUPmdg37FPD5DETF/kW78njG2BWCCrgv+vb0k7u3VrxJOpQJ6xSIKSq6MRe4?=
 =?us-ascii?Q?9Xk+ciagUxdrq81q/JhjbbsdPUQIBZve/T+AUumjaboICtWuxWScTKiv7CNW?=
 =?us-ascii?Q?hQW9buy1KstpmvNDq7aUbkarslw0lBrz6tOmzd6+468lJisTDi7e+MYk80/E?=
 =?us-ascii?Q?rmxxeeePbQ63u0cENGVDZcjkJoqo+8868sLHuR0ZhKLmSB5kaTvZ7D9VF3gV?=
 =?us-ascii?Q?CgP7QUg8KX6QHT6ndQFGQG4g9hdMjM5Vxj1MvpV2icBsnNcaBHP/Lb3dhNZS?=
 =?us-ascii?Q?YqUlHIvSj0G+W9VXxe6IQwhlUqIYunGFTWzWKkgLdA2b34Arb204XIvu1HDq?=
 =?us-ascii?Q?EaOGHDW21rUnSunjDN21Bx23?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB4538.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bcaa4e29-5b83-4257-0644-08d91f484f2d
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2021 06:42:47.5688
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0o/Au5fUhU7m7Or7V9BoHDOvnbKbA6rX5RPepQlwZIRraHNNZqFxpJysVy7VkrCrGRpa9tWZnsibUzP1w/5daEPAmowdxUGm07nnnO5VVtI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7148
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The following changes since commit db190ade4569c542cd257a9334f8f8956372f7b3=
:

  linux-firmware: update NXP PCIE-USB-8997 firmware image (2021-05-19 12:57=
:21 -0700)

are available in the git repository at:

  https://github.com/NXP/mwifiex-firmware.git

for you to fetch changes up to 267febb1c43c119a7a65ddabc2c33c28a7803324:

  linux-firmware: update Marvell 8897/8997 firmware images (2021-05-25 05:0=
9:25 -0700)

----------------------------------------------------------------
Sharvari Harisangam (1):
      linux-firmware: update Marvell 8897/8997 firmware images

 mrvl/pcieusb8997_combo_v4.bin | Bin 634228 -> 638992 bytes
 mrvl/sd8897_uapsta.bin        | Bin 701072 -> 717068 bytes
 2 files changed, 0 insertions(+), 0 deletions(-)
