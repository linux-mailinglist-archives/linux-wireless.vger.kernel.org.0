Return-Path: <linux-wireless+bounces-29481-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EBABFCA1CEE
	for <lists+linux-wireless@lfdr.de>; Wed, 03 Dec 2025 23:22:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DB568300248B
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Dec 2025 22:22:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B67D329A309;
	Wed,  3 Dec 2025 22:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=murata.com header.i=@murata.com header.b="YqSvWD12"
X-Original-To: linux-wireless@vger.kernel.org
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11013063.outbound.protection.outlook.com [52.101.127.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 935CA27FB25;
	Wed,  3 Dec 2025 22:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764800523; cv=fail; b=gqOcEPmsVqyoWG1isQ1yEnrS0JnMqng4cDl1Cz87ugNNUDFRkzTV1hrWnxUdIcvICI1BFYb2evZW20Wz1Qf6iaxONOualBl8luqnQRSVKwIutBsX0z1oe58G/DXIXlJveXVuLyhrriuvPLy7k5Pcbjwmcede+bgMecwypc7Ef2s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764800523; c=relaxed/simple;
	bh=HtmmtqTyPzntLrdvBKmWZI2gmlJJblSmshuyE3OrL48=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=s1SghrGEgt7sK5gIOscIxeQ4QRITonRW/VrS2diFUTTu59Qy/H3WuTI3V+2uPpbcKaqofKTiL282uODoi2CR4FxTs/kWz2lj+rCjue6yV//d0A1kx2Jil4r5/EiCHmEFbBFE0+f1sRi2Fj0oWIKNCZiGktABo00XQzlWrOmcibk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=murata.com; spf=pass smtp.mailfrom=murata.com; dkim=pass (2048-bit key) header.d=murata.com header.i=@murata.com header.b=YqSvWD12; arc=fail smtp.client-ip=52.101.127.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=murata.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=murata.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gRFdS5NNhcm3DwxWQyDdnYSaM601IrGyMdq+cY8ourUK6dI6ip/tfdqtSwRlqAXNjticUay3ApXEl2hn5CsGFrI17uTcAME7t9+pniKCMQIzIvKqMIxk66HMcLkunBvv2bRFaPzNxUuiFecETPb4HkKL8rMN+RnVXQ5yc2149mimM1nBimh9axgrqYlrQyrUDCr/U/vd9K3zAqNGvbBY5eNtIczFz0IwwXxTqHQscDLIfFS1Dfb0A/vPxxNwu+0OP++xhj2UH5qZsGueQp4xUj9bBgY59hroDKRH6Zl6UPPq2F+xotmTB/CaLhopvavLYncFTi59DwHkXwGdYifRlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HtmmtqTyPzntLrdvBKmWZI2gmlJJblSmshuyE3OrL48=;
 b=lZaQKJZZ6+CIoibdqbaOl1gTChzx6INxp5o9f2WTz/4lwC17KfU8Ul6p9t23p3Wc6mqTf54wW995xCByN3DVuzhKdH9At0gjmhPnxuMWoJvigLsGl1OyfVBR/yJqgK42xd1460D89dq3JfPeYWqiP3L3KxBnvRiIxSDALNa+jrVDZukya2ZK1ivclS5MNjvCuzZXN+DPC/UzV6+HcXjWVi7X6YxoTVpATZr7kGvunHfX4ZsDCgaX9h+GdpI7ITdLLVwSE8Xgn7Fv0T/yjZ7GDsZXQwAjkV9lXvPS6+OlBY394Zb65AkD5bxN4Tk11jfS37DiQI34P8ioQ4L0q1DWAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=murata.com; dmarc=pass action=none header.from=murata.com;
 dkim=pass header.d=murata.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=murata.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HtmmtqTyPzntLrdvBKmWZI2gmlJJblSmshuyE3OrL48=;
 b=YqSvWD12SFPdopd8u+KW91pHAK4KeS5aCzPGVYVzMd7I7f9xDWJq5zcbZsJi6sWSc9Y7OuDrM1XcYZK6S6gHY+zZqhHVzXRL5xzENVCI4XzVOhEPGtfc0N0o5hMkFaHagkKi5O9e5CBTCZ0lKzooPXJFuBjL+f3GWYvpOZEp2TBjMZMym8aLlWpGOH/BiBTfMB0yDJpxSKl1SpmzFjaoDLdMe+xzLuf6Ub+wf8ANaxtxSld52HB+4LSPIMYNpxivkMNuFjhGLMaGJ4BwexNofcqsH6K/ynJMy0Wzv0a2j6g8v4EH/NzBMR7CaGdCX9Hh8HRrwZhM385N9cSY3Dnomw==
Received: from SEYPR03MB7777.apcprd03.prod.outlook.com (2603:1096:101:143::7)
 by TYZPR03MB8781.apcprd03.prod.outlook.com (2603:1096:405:6b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Wed, 3 Dec
 2025 22:21:39 +0000
Received: from SEYPR03MB7777.apcprd03.prod.outlook.com
 ([fe80::fa2a:8777:977d:e718]) by SEYPR03MB7777.apcprd03.prod.outlook.com
 ([fe80::fa2a:8777:977d:e718%7]) with mapi id 15.20.9388.003; Wed, 3 Dec 2025
 22:21:39 +0000
From: Jameel Valai Kareem <jkareem@murata.com>
To: "jeff.chen_1@nxp.com" <jeff.chen_1@nxp.com>
CC: "briannorris@chromium.org" <briannorris@chromium.org>,
	"francesco@dolcini.it" <francesco@dolcini.it>, "johannes@sipsolutions.net"
	<johannes@sipsolutions.net>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>, "s.hauer@pengutronix.de"
	<s.hauer@pengutronix.de>, "tsung-hsien.hsieh@nxp.com"
	<tsung-hsien.hsieh@nxp.com>
Subject: Re: [PATCH v7 00/22] wifi: nxpwifi: create nxpwifi to support iw61x
Thread-Topic: Re: [PATCH v7 00/22] wifi: nxpwifi: create nxpwifi to support
 iw61x
Thread-Index: AdxkopOanDORvBvPS1ucv56RVd6YKA==
Date: Wed, 3 Dec 2025 22:21:39 +0000
Message-ID:
 <SEYPR03MB777734E5CCF02CD4727DCBA4D4D9A@SEYPR03MB7777.apcprd03.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=murata.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR03MB7777:EE_|TYZPR03MB8781:EE_
x-ms-office365-filtering-correlation-id: aadad5c1-f56f-4d95-6502-08de32ba543f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?kRoTAsC2dVQ67AlHECM8FmUM+wGTayOi9ZL96M3Cl7FFaboenPQX/JUQIrWW?=
 =?us-ascii?Q?CtFvnRJCOqQW3QCaVI8CR550uVDqThKpJ5P0XFmsXV5GqEVNuxqKPc1yed+o?=
 =?us-ascii?Q?tDB8yUck64smWCtmUutYL21dYfY/AssxNepqNgu3T3kou0u/zHbo/CKW+0BI?=
 =?us-ascii?Q?eBun6HZY7ClShyItRMJeurfWcI8UwwvbRFLadHyGmxoaimYrtcrKWmwrHxci?=
 =?us-ascii?Q?k77Mrg+7x7N5gxdjCMgMuEL8oGannGGbu7nT8xXG3WbtAO6eGCyVhM2fWwZh?=
 =?us-ascii?Q?hgqIRPx2rfO7W9A5m1BapV2Qmk2ZnpNim8Axv4GemgFC9FA/DkLFJej0X5zU?=
 =?us-ascii?Q?Ko801Ja0qR4EpeDd3XlX3XcsLL5Et6tYCIHwI3JyvvLAQooVR8MxQC+QbvtT?=
 =?us-ascii?Q?qgcEPG4YWpNdZpG8+pYbe3H3E4Q0ePZrJbVrr72KCyq5vAoI0UMWhqPSQPrD?=
 =?us-ascii?Q?Cg0d1cU+6KkKVc06WmjaXiY+4ZSpQHL3gW5RAchBXmM/K7+Imws4CIXDjELS?=
 =?us-ascii?Q?ibTvajuh9WCezeZ46sy4ajmtFEOs5Wr9kZGknR6Q+CExUr7q+7o1CPhYcPs5?=
 =?us-ascii?Q?lD6sD8P+GW9bzmA0PUGACzGKEQMS815M3ZTXkfmOgxBnWONGYWwxrAOMIdMk?=
 =?us-ascii?Q?3M/LguUZLQ/KHX3TzQjLT1ETMRZOPB/r7preNqUI62QeVKnSzxSaiRm6rKh3?=
 =?us-ascii?Q?2amzNuoodiZzb2z4LGMNg1T/SouVetAi7wJb0yWdw4L4iIW74Zyl6mL7T9YU?=
 =?us-ascii?Q?gZ5g5uV2oQjGCFz7VIKHUZxIeoVkziozPb9ACWuVU1T/IEo9B5I5ti76MOHC?=
 =?us-ascii?Q?ozefyrlroxssTIM2mR1IKYBFiGOcAcSiEqUGZbLT3sC2t79dpPiqE3ISlWo4?=
 =?us-ascii?Q?DnCtw50D6FRH+L370LWYZb1U2kavy0x4nGkrbm3MnWWglKGxdsHKQ0lWdZ0K?=
 =?us-ascii?Q?P+kWk1Qpdnl6mV5amuCNOvFt9bgiKhJUAvxWlSET5QzaICRbMIkAZR3pw+fb?=
 =?us-ascii?Q?pTg9NJRAxbpC3Y/x/7oX4mVNhxxPWhyLZPGEyGBFpu8ezVLJeQnU57Oze0Qn?=
 =?us-ascii?Q?nMKzkVAi0DVjhQbtewYl+MwXD1JOaPUdTkNNy81Yb7iZ6PV11cV7lPmiOkqA?=
 =?us-ascii?Q?wpksSAaGPdrjz9lbgzFHbsEzTCLkfwRziXgEaqscXcFJARzlW3Ger35cjcBr?=
 =?us-ascii?Q?TADxPhfGK6PTCDjeZnPJJlyvx0nPvYCA9pPPCXUQPWQZXYzLPOKfb78DfhNW?=
 =?us-ascii?Q?/4xHxnJqdcFzSei7SMGGMBZdI4CaAYhAlo6XmnOFQzLa1x99vioB1vhYSfg3?=
 =?us-ascii?Q?uN6KCMFpVzMO1Ts+BPoldAvE2lewct8WUv513osQkhTnek8q6QwSUjf87Tb8?=
 =?us-ascii?Q?6KN0sPfANYHkICBJUUtCDOudzN1gCGsq8ooBSiuuZyCjw50ns6+2ZRWAxFmZ?=
 =?us-ascii?Q?bYz8n6YuW9bevDjd5freFq7U3/q6uKhwO5rVqRPRpLMpjdxW73XBy/YaW/A9?=
 =?us-ascii?Q?C2AlsvLTi4GIovdGESel/rBHyX+yZtMQ+aAH?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR03MB7777.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?vnAg17dBFV7RWN+U8+hjjU/YoVB2KPgrtQtXuEjFe22gdUpqH+wKeBgtwApW?=
 =?us-ascii?Q?+Aw6fJeguMMtOa0qOIyDYSMJr3Wbxuupe7qL33kHTg2pffI8Q/qOUfPf2d4Z?=
 =?us-ascii?Q?XmjSF+09KN26wZ5PvwEQX9TeoElgP3d2K20mg4Q0k+goqheQOXXO0uWKS0z/?=
 =?us-ascii?Q?naFcIwZfIAvZ1rKKcCx+UlMq5KTiyoM8Mrf7rbQ559GX4mlq3j1ZCqJl2dTB?=
 =?us-ascii?Q?gIEqYsVVWLYSo81rzgv5JNlr2RquGD53ls30W+hAb3OHorTPXpTwE3VjBCKN?=
 =?us-ascii?Q?jrUHZlj+vp9kHtQX6ltbwBwsSq5J6JwmCNNqe7VwVk154uJ70gGzbl8j9SgH?=
 =?us-ascii?Q?KBGFeKOSpFlVsyIvVlFMbkwR8kSndkL/yx5fDHDLh7wukuJhhM5qRTSKNF/v?=
 =?us-ascii?Q?f1Gsjz+uh+T/isdAFCNZB3wIqOS0BwS88DBsrRgc42Fb5K24iR6+kFyFBRFu?=
 =?us-ascii?Q?o84F8jpbRdaTDVdZmPpzXsDmh+MnzSfeIDSsgwai1N26EBE7EuUrPSNCp93s?=
 =?us-ascii?Q?5hJq8lYlSufPY3HwYDqHgimp0XZppZMyVL5mbtpZlzBZWepX5dKSInMUdJtq?=
 =?us-ascii?Q?pBujK4tLZtle+4UMbyfGbnobljIpm0wWa91YE1xYfsyd5KK5mZ4umXsQQkab?=
 =?us-ascii?Q?HlyWGJSnb7gYuFHFRCxaVxR6y+zriMieV16ZDn/paQ7x9aNuiKsPsc1PihpM?=
 =?us-ascii?Q?+EXIxNZ9yJBufKNzApGEmk1Bf2V/LSiMM/EaqT082vObE6SrWoYCRbhZ67Li?=
 =?us-ascii?Q?buWP9kSzwH2Rp0Hy29JT66peDNpLu7HJfIZhj/b+zwryZI0onAVKrDh+m4kO?=
 =?us-ascii?Q?aiN9/qQ8zX+KarQdamWeA6XH9fx2//03TYwnwLR2Ro/frjIPIWEt8/+zCkJ4?=
 =?us-ascii?Q?rAMnRW9s+6d0GcNiISLog1gUPmykrdNjZ12jJcXSZgqjzBpevCwzqq+EKcrC?=
 =?us-ascii?Q?DaLHiI7iz7bqRdf7Ne7QMTZO3PCYrVyxhclu/OzaN5JR0Ihj+UrBLZLDmszH?=
 =?us-ascii?Q?W+Fp/uy3iO2z1x5tqnaLetxfj21I8gGghP+f3EzICV2fYmMb9IKSg1OcR9jc?=
 =?us-ascii?Q?Nt3Ao5Y5IsHTwaupA08BF8UP9LtT/kzt29ksmaY19+AqAnbWazKwCEPj61yp?=
 =?us-ascii?Q?2V3voivNwpuphsDXhZbfcxCOZJvV+RF20VPINwcQNkw+qftii4tQTwfqDU80?=
 =?us-ascii?Q?mDpWEeJZxokTMPMr0NIVp1GJ2r7K1OAEV/0iKC9BwuY1NsCAyJrN00C2pPiE?=
 =?us-ascii?Q?+z+W234D+zcjhjZWsHyxJrN0p4kxDNwp3KRzVoaMDXrLIB7khOsGDU6nclVS?=
 =?us-ascii?Q?MbvuSIIw2DDj6TR0bZlJ+YoKF5iQYkHIvQlYAtbxmO7sEltpLzBkxHhvPL0x?=
 =?us-ascii?Q?p9h3FehAPpgZg1DkSgBISoOjnLiP1dxNVdiNH9Hn8wHPalpaYxPQ/7768zlC?=
 =?us-ascii?Q?qaP5TpKyeRpuY0XkhnRtlgZ1x8ZDjQeElr8SD9H0D+o+K6NO7oy3Y52XqQQ3?=
 =?us-ascii?Q?+dK+hyLeX3IQ9U7FTS/wv4hYVILyYZCI4NYXcvhft0IRS2ACBFc5qyPeOo3Y?=
 =?us-ascii?Q?esu/voSk/aG/E8SlWF4ved8SqrMMQuT9qPySRQcw?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: murata.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR03MB7777.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aadad5c1-f56f-4d95-6502-08de32ba543f
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2025 22:21:39.1345
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: afff1096-7fd8-4cdd-879a-7db50a47287a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M5+dGda7Qon6T6mrAJ5uSldLFXlk+rEvBG//fXSjFZhpkmnjO2He0WsKiT33ANfHA92/pqYdNGF8pgfvkuhHkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB8781

Tested-by: Jameel Basha <jkareem@murata.com>

CONFIDENTIALITY: This message contains information which may be confidentia=
l and privileged. Unless you are the intended addressee (or authorized to r=
eceive for the intended addressee), you may not use, copy or disclose to an=
yone the message or any information contained in the message. If you have r=
eceived the message in error, please advise the sender at Murata by reply e=
mail and delete the message.

