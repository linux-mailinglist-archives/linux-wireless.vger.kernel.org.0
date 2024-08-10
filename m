Return-Path: <linux-wireless+bounces-11251-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCD2194DC12
	for <lists+linux-wireless@lfdr.de>; Sat, 10 Aug 2024 11:45:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1CBD1C21110
	for <lists+linux-wireless@lfdr.de>; Sat, 10 Aug 2024 09:45:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F7B01514EE;
	Sat, 10 Aug 2024 09:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="SSulglNs"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28AEB15252D;
	Sat, 10 Aug 2024 09:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723283113; cv=fail; b=okgJKGcJZs9ZlnyBtH+LbwdWbUrEGjX75xf1sanTFRtBc//h61kGpJNZUy1VDt3cROHRAsipvxrEneyH+Q3DDCtpfMOIiIQ6ew18W07ay2AjKO/DD1FmHxgQLxvEIjopPtKVaS+NgN5BLw97ho2SsxrPUPUIyt42DdradIIAxRw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723283113; c=relaxed/simple;
	bh=x+E8VKux6WdjTvrYBoUTXcoRAf5gjQbwvfZWfEyB1W0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=J4pEimJAKSUJJjNEt9obL3DEU3hIaMqCqDYlz56KV2DnUCzHwR37owLXvNFywWdAnzy3pQruQybIkKL3279WPUK5C1XO81IOjQ9EVO+l+OYSAjDW6wSL1nte+aOL928zs2Y0iyQ6/gHDxWcK6K8c3hq/3p5wUz+F9gwWBq/eSv0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=SSulglNs; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47A9hEEM022813;
	Sat, 10 Aug 2024 02:44:15 -0700
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 40x5eqr16w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 10 Aug 2024 02:44:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gW+16Mr5H6/rjZBGFpuid8pgNaXq9V/2YoVC4+QehIKmi7yn89vp/taM87X4qUMithIheP+EPeToyPPsQmXRNAUR5nNaOb1kCdpR2CpsTl3vdCiXut7P70xREipIp5e2Io5FB8NRrCKpcb2dPjs6q4Qb6ArZi7CmbhdcYQptYpR+tVvSulHC3Ap6LpKcAzeHXb6a8tBaTuvNfsFQRF6wowQf7bIpMyGqGaP4KN1DnqCcj5cjow0ku4HSi5112vPGK0UpbabVMY9hqBt1NDEjJfct9BH7RVZIeKtoMZZYeIHUqdxoC7I9lV92GEbf9QMEct9Q79x3Os526sSMFik/GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LSwAucnzv45W/FAOsEMEt0sFBKhVTVcvevO7/T47HZY=;
 b=HXUFjCtalJZerO0tOjhoQk8gTNiVzkcbT058Iax09cfnYsLtDa7s040YHqDxyLvKEFd98LGAoqkrXSK5ARKDnGWllGLMqSEMTXJemYCIr/6s90dyF+D5vAQycxleTnHit+MJYOzqYuf/Af7Rizy9uPXNc9092pGrdy2zrx80Q93PjTiWhORQ3iOrOqCtv6H7tPiwS1cWA1Xt9fIW8d6Wu4JbGy/asWA+LFZQmcYQ+wwz/oYEHR2G+WnFx3nzevAsQZBebUMUgoK7iYjsVajJE3Ft+8e0e1X5WjwsEY/vQyAdx0SLHIPC5s3MOgo/NVlS4Nyb3aOPjKSGwP0MkHOONw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LSwAucnzv45W/FAOsEMEt0sFBKhVTVcvevO7/T47HZY=;
 b=SSulglNsHtdmh7mc3M1vAsXi2PXxfSnNU7gTgJKXDAhIjKAG+zu3EujJTqEKxw7qaFG2TBfCdgmXd+BWyxV868yPHUe/51ejvXEoPGkEYkFdKUd0N9zysFeUfn5vyuCSRkBNL9RsXpUDCe3NdjSZu73nHVZPAXoQjFWq41jetY0=
Received: from BY3PR18MB4707.namprd18.prod.outlook.com (2603:10b6:a03:3ca::23)
 by LV3PR18MB6205.namprd18.prod.outlook.com (2603:10b6:408:27b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.17; Sat, 10 Aug
 2024 09:44:11 +0000
Received: from BY3PR18MB4707.namprd18.prod.outlook.com
 ([fe80::e225:5161:1478:9d30]) by BY3PR18MB4707.namprd18.prod.outlook.com
 ([fe80::e225:5161:1478:9d30%6]) with mapi id 15.20.7849.015; Sat, 10 Aug 2024
 09:44:10 +0000
From: Sai Krishna Gajula <saikrishnag@marvell.com>
To: Jacobe Zang <jacobe.zang@wesion.com>, "robh@kernel.org" <robh@kernel.org>,
        "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
        "heiko@sntech.de"
	<heiko@sntech.de>,
        "kvalo@kernel.org" <kvalo@kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com"
	<edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "conor+dt@kernel.org"
	<conor+dt@kernel.org>,
        "arend.vanspriel@broadcom.com"
	<arend.vanspriel@broadcom.com>
CC: "efectn@protonmail.com" <efectn@protonmail.com>,
        "dsimic@manjaro.org"
	<dsimic@manjaro.org>,
        "jagan@edgeble.ai" <jagan@edgeble.ai>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
        "linux-rockchip@lists.infradead.org"
	<linux-rockchip@lists.infradead.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "arend@broadcom.com" <arend@broadcom.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "megi@xff.cz"
	<megi@xff.cz>,
        "duoming@zju.edu.cn" <duoming@zju.edu.cn>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "minipli@grsecurity.net"
	<minipli@grsecurity.net>,
        "brcm80211@lists.linux.dev"
	<brcm80211@lists.linux.dev>,
        "brcm80211-dev-list.pdl@broadcom.com"
	<brcm80211-dev-list.pdl@broadcom.com>,
        "nick@khadas.com" <nick@khadas.com>
Subject: RE: [PATCH v9 4/5] wifi: brcmfmac: Add optional lpo clock enable
 support
Thread-Topic: [PATCH v9 4/5] wifi: brcmfmac: Add optional lpo clock enable
 support
Thread-Index: AQHa6wnZZmQ4lQ/000ShjcZ5lhEIpA==
Date: Sat, 10 Aug 2024 09:44:09 +0000
Message-ID:
 <BY3PR18MB47072A9CC7E1EEB4BD1FC063A0BB2@BY3PR18MB4707.namprd18.prod.outlook.com>
References: <20240810035141.439024-1-jacobe.zang@wesion.com>
 <20240810035141.439024-5-jacobe.zang@wesion.com>
In-Reply-To: <20240810035141.439024-5-jacobe.zang@wesion.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY3PR18MB4707:EE_|LV3PR18MB6205:EE_
x-ms-office365-filtering-correlation-id: f4ba4554-f9ae-453a-149a-08dcb920fc22
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018|921020;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?Tm59C2HVxJOl3Z//2QofhfQTCMyG4gc08TSDfawK5m2ArpLe03D5DKjjFwkI?=
 =?us-ascii?Q?BbepBq77p5tq4E0A0W2KA3Xu/mcfGRPR1o7bUG6mMKJacWsQoI1HvC23Xwl6?=
 =?us-ascii?Q?Jm0fa2uOgkuY7jfH42lQWIneJlVjjTg804GkO38m8Gyih9ywIWW4i8LughrE?=
 =?us-ascii?Q?bhoyDXU2Vc2uw+/5btwKlCd2HUEtsorCQ4QropxoI7AhvjOXTklrWMsfTzAr?=
 =?us-ascii?Q?2AQmgRdP6AO6p4YQjL5zT184807/wBqOudXl3g5L03glC4bgso8JFxPHwpLD?=
 =?us-ascii?Q?N3k3qrQwP+s/HPv0nP/Oy9Xeqnyh/b9ikOJdZHSA1+W2Rk6gw2bwJ0/A92Vk?=
 =?us-ascii?Q?ibvTvdvFD6EW/kg4DUhI4OsL5KiS66Jqo5Iv7ovI7s6dfT+WW8LUE7xKUahI?=
 =?us-ascii?Q?+MnRU1cSZ+YSsE7/Cl8x73XhEV/9OtQXMRN1kd2w4hJlPvtdO1ypyjv1O5zX?=
 =?us-ascii?Q?TfeC9XNVdQbp4TU/QRk3sXVcArqs1DxQ4Op9PodxGDuXW6zUGQpsza4Mhszs?=
 =?us-ascii?Q?hIIHS9DP/xrN1Qx8Um0ltzlsKkiURbTgw4Hmch6O9mTO7RTZMd11yx5gIBSd?=
 =?us-ascii?Q?eUsP7FMBeRKOEsQL6UbFxxscz2CCF4fPtKADfNIdLbFYI6Z8lIhYGdgDX4HF?=
 =?us-ascii?Q?N56U8Qr8bc7d4q6n9PIPbrW2LEMejUgSdylFq85zSO9ZLdYzjGAcF4MCWEcn?=
 =?us-ascii?Q?ACQQ0ItcPX+P742M+OgPKXzC3wRbyqrJAlfn2EWNXho8BRKIO+rcSKCv7f8o?=
 =?us-ascii?Q?TywvsKmcQz8KFWM0PFeyMCnuhDlHpDywFHCDgRc+t7z2haQB6O20IoCrITmP?=
 =?us-ascii?Q?+LOVYkQn66uBkx9rPNCmajEDdHSj7asSeLMSkdvZVw+dz9B6Ps4vfPwwx06H?=
 =?us-ascii?Q?T16lTuHmUN2DZqMkP0Xb7LHH0z2PjANjoG6YX/aS4zIsRvcwbS0ZjxTd8l3g?=
 =?us-ascii?Q?jTRb6P3rxocYN3lFBJXnH4fzHUzo2BdXTx6LAfthcm1ekpzUgg9NXS7ueUsC?=
 =?us-ascii?Q?3Qyf1gITJxH80VuFlmt7N4m0e4dDHBD3V2EFhAjmcd/6nKxOAiqqw0T3o+22?=
 =?us-ascii?Q?q7/crTBfpyOoO0MfIUJc7KVj1ocT/xOtBWXiSWwHAnH7FX79CSZ2Gu73U/ex?=
 =?us-ascii?Q?aoHD+3ltfwSuA+vc1ZcIZJpKDynoDBpgyaA7JKV7kOu/ZZIvoHI1fNg2ocJO?=
 =?us-ascii?Q?iZma8enEGR/e2O4QTC8x7EuWuFni1c5URjJztK1QMGBW8eF8VFfJRAuz6Bve?=
 =?us-ascii?Q?F2eDiiejnkD4ac0xX+UDDZHP9d5d8keIWL1HZ5G3XNRz3UGj3fc2Nl/buQkT?=
 =?us-ascii?Q?bHFBw7vv5MXU8oC/psgmkCnuzDakJ4REqHXGFEye+UvPWhBfT5EEFWBNv15v?=
 =?us-ascii?Q?3wsxIvJqmht4XuILgLFc1sgrB0v/8VI44y7k5ePmjllWsUK+O4dRetZft1Tq?=
 =?us-ascii?Q?0VEqhiqJLqI=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR18MB4707.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018)(921020);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?qGwT3ksBWuF4enfFqZBPmpICrnDTsCNGqiF6ugjIAKUj9d6ZYkaAPiY9F5E0?=
 =?us-ascii?Q?f+BUiC/xWdgkMOLvrj+YQ6mWUZwLO88Mnt3zU3DCab95L5M+1jLvlUFrjQT1?=
 =?us-ascii?Q?FwQF0+D1fMzb3TZM5Asr1uDk1F7M7u5l+famjrXOe+Qv37JLxWJHFblAD9Ze?=
 =?us-ascii?Q?rhAgTRuDJfzc5aj4itakn9tdxsvpeUL6rqZOorzuQ+0V7C5DDIBni1xzSOA4?=
 =?us-ascii?Q?VjXoQ3YJ/5ucoujhvxVSVcDkB7jHFP5RPcmYpO1iCe4BV14xzWFcw/zuHKmG?=
 =?us-ascii?Q?AwM4T8ILGS6SU2Sy/vCN4LLT89Qmp3eKgw5JQSZLhp6KSsnbIfC3D3TWyfbS?=
 =?us-ascii?Q?Yl+IfohDzGsUZyUckN/tP7FsbY06Wnn/J97DzKUHbQ8famHk0wh9yjSGyb4a?=
 =?us-ascii?Q?eth6VFkEAV89KnVU5nsispq9ACtyhV4WG3SCS6xl1NOvzH+WMStauhZd7ioH?=
 =?us-ascii?Q?BbYjUbYRMppm0I/HJUIabO4TKG1QcT61zJrIJASVE5OYpP3r1yQ99iwzPuVL?=
 =?us-ascii?Q?CGvYsSNl70AZUzHQb1zJeVSbKfxSa5h1iFZua2GjjkfqHIpGpIxQoPKiP3i0?=
 =?us-ascii?Q?0uuf5n+eSoQgoQ01tCUZjTkC7ucJmytK+xqD88x0LdYObzY6evgybgxCHJaP?=
 =?us-ascii?Q?RotAaTwXspHeuYcwbeT0obEpm5VJqqqnfbrn9lUgf2xW4nMP3rqJALg2nCH8?=
 =?us-ascii?Q?PrBDTn2dFAnA/W0xHTiWbGruJPZAhImNmS/UcFBAsuVI1/3ym6+jiwDPb3PJ?=
 =?us-ascii?Q?Eoyq6d3B4+3O83vnJewD2U8fAD5Cw7A2jIDRUHNDueXk2AqobZvDAzE31p3I?=
 =?us-ascii?Q?WS1Q2Pg46VZkUOeM5KjyU1FwNbNR2IgIcvn6oFg8INzONc0W/C8e8laqER6A?=
 =?us-ascii?Q?xeM/jTh1UdGPpJIPV1pbl/Vls2YjDz6Pz6+WBAfmgYqhlWAbelQdKgWct0gV?=
 =?us-ascii?Q?Nx3McTgqvfPgsJdYR7PE8GsvHQV4s9UiBBL6ax3V/HqLRiKASAjCeaPDM8Mw?=
 =?us-ascii?Q?c19hjTAk8DLpmlkZL9NXTY+0xQF5z1MBv1gjRJ2Z4vnJkVdhQt7HfTdkWjtC?=
 =?us-ascii?Q?cNB6NADpuRMd+DEux/fLV5o1/qbiBzVtqx0lD1lhnmmY87eXnbrPcgWnEERi?=
 =?us-ascii?Q?BxbzVSrqhP/SzDtatnpEEffa4Xfk/qZZiA53P3Y9IYzJcfaDezq4V5L7gXLt?=
 =?us-ascii?Q?nabsSA60PhUX08MwTqRm7+T8WNKUwQscBzmturlh9fUTzwt1cvAx6DhrRE+1?=
 =?us-ascii?Q?fw/OMGfEBC6nt1aKtWSZTfRVAgZlgvOoSYnecGq5Nyy6iY813fL4eZHBxFem?=
 =?us-ascii?Q?YIAliReTyZZKYthaaaHi+hu3nkY8qQSqBpKjYA/sbaizmLyM9pokM3utsbZz?=
 =?us-ascii?Q?AG+exr7kj/PzZbgJ+tFf91FOnRN4eJeT+0SXH2pbru/ikI+3mLHAMM/49kyJ?=
 =?us-ascii?Q?8/rrLGLxWMn5fDAtpHxRSDx3742LySnpouvye4rBXb+XQGThODeotTcTderk?=
 =?us-ascii?Q?q6Md0jaqlDyfTDE7YYV36WlSOnIXRxW0IBgC9vS4Qp2C87DL6EJZiBk/Zm/m?=
 =?us-ascii?Q?wsg2r9edY9i1PEEpkhcyeuXtwHFNBuFl0awgLDvA?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR18MB4707.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4ba4554-f9ae-453a-149a-08dcb920fc22
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Aug 2024 09:44:09.9575
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xn1wzT7j9DunmLcMImIHfeRT0IckqbgTcOuOcJQqepfVSNygbXpw3l+RZ+cZtzoG0/p0fcNAyZCXr8K2XZtDVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR18MB6205
X-Proofpoint-GUID: -G7yGSkzBLJK3D6REpyZERlXFXmdpExA
X-Proofpoint-ORIG-GUID: -G7yGSkzBLJK3D6REpyZERlXFXmdpExA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-10_06,2024-08-07_01,2024-05-17_01


> -----Original Message-----
> From: Jacobe Zang <jacobe.zang@wesion.com>
> Sent: Saturday, August 10, 2024 9:22 AM
> To: robh@kernel.org; krzk+dt@kernel.org; heiko@sntech.de;
> kvalo@kernel.org; davem@davemloft.net; edumazet@google.com;
> kuba@kernel.org; pabeni@redhat.com; conor+dt@kernel.org;
> arend.vanspriel@broadcom.com
> Cc: efectn@protonmail.com; dsimic@manjaro.org; jagan@edgeble.ai;
> devicetree@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-
> rockchip@lists.infradead.org; linux-kernel@vger.kernel.org;
> arend@broadcom.com; linux-wireless@vger.kernel.org;
> netdev@vger.kernel.org; megi@xff.cz; duoming@zju.edu.cn;
> bhelgaas@google.com; minipli@grsecurity.net; brcm80211@lists.linux.dev;
> brcm80211-dev-list.pdl@broadcom.com; nick@khadas.com; Jacobe Zang
> <jacobe.zang@wesion.com>
> Subject:  [PATCH v9 4/5] wifi: brcmfmac: Add optional lpo clock
> enable support
>=20
> WiFi modules often require 32kHz clock to function. Add support to enable
> the clock to PCIe driver and move "brcm,bcm4329-fmac" check to the top of
> brcmf_of_probe. Change function prototypes from void to int and add
> appropriate errno's for return
> WiFi modules often require 32kHz clock to function. Add support to enable
> the clock to PCIe driver and move "brcm,bcm4329-fmac" check to the top of
> brcmf_of_probe. Change function prototypes from void to int and add
> appropriate errno's for return values that will be send to bus when error
> occurred.
>=20
> Co-developed-by: Ondrej Jirman <megi@xff.cz>
> Signed-off-by: Ondrej Jirman <megi@xff.cz>
> Co-developed-by: Arend van Spriel <arend.vanspriel@broadcom.com>
> Signed-off-by: Arend van Spriel <arend.vanspriel@broadcom.com>
> Signed-off-by: Jacobe Zang <jacobe.zang@wesion.com>
> ---
>  .../broadcom/brcm80211/brcmfmac/bcmsdh.c      |  4 +-
>  .../broadcom/brcm80211/brcmfmac/common.c      |  3 +-
>  .../wireless/broadcom/brcm80211/brcmfmac/of.c | 53 +++++++++++--------
> .../wireless/broadcom/brcm80211/brcmfmac/of.h |  9 ++--
>  .../broadcom/brcm80211/brcmfmac/pcie.c        |  3 ++
>  .../broadcom/brcm80211/brcmfmac/sdio.c        | 24 ++++++---
>  .../broadcom/brcm80211/brcmfmac/usb.c         |  3 ++
>  7 files changed, 63 insertions(+), 36 deletions(-)
>=20
> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
> b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
> index 13391c2d82aae..b2ede4e579c5c 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
> @@ -947,8 +947,8 @@ int brcmf_sdiod_probe(struct brcmf_sdio_dev
> *sdiodev)
>=20
>  	/* try to attach to the target device */
>  	sdiodev->bus =3D brcmf_sdio_probe(sdiodev);
> -	if (!sdiodev->bus) {
> -		ret =3D -ENODEV;
> +	if (IS_ERR(sdiodev->bus)) {
> +		ret =3D PTR_ERR(sdiodev->bus);
>  		goto out;
>  	}
>  	brcmf_sdiod_host_fixup(sdiodev->func2->card->host);
> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.c
> b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.c
> index b24faae35873d..58d50918dd177 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.c
> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.c
> @@ -561,7 +561,8 @@ struct brcmf_mp_device
> *brcmf_get_module_param(struct device *dev,
>  	if (!found) {
>  		/* No platform data for this device, try OF and DMI data */
>  		brcmf_dmi_probe(settings, chip, chiprev);
> -		brcmf_of_probe(dev, bus_type, settings);
> +		if (brcmf_of_probe(dev, bus_type, settings) =3D=3D -
> EPROBE_DEFER)
> +			return ERR_PTR(-EPROBE_DEFER);
>  		brcmf_acpi_probe(dev, bus_type, settings);
>  	}
>  	return settings;
> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c
> b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c
> index e406e11481a62..f19dc7355e0e8 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c
> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c
> @@ -6,6 +6,7 @@
>  #include <linux/of.h>
>  #include <linux/of_irq.h>
>  #include <linux/of_net.h>
> +#include <linux/clk.h>
>=20
>  #include <defs.h>
>  #include "debug.h"
> @@ -65,17 +66,21 @@ static int brcmf_of_get_country_codes(struct device
> *dev,
>  	return 0;
>  }
>=20
> -void brcmf_of_probe(struct device *dev, enum brcmf_bus_type bus_type,
> -		    struct brcmf_mp_device *settings)
> +int brcmf_of_probe(struct device *dev, enum brcmf_bus_type bus_type,
> +		   struct brcmf_mp_device *settings)
>  {
>  	struct brcmfmac_sdio_pd *sdio =3D &settings->bus.sdio;
>  	struct device_node *root, *np =3D dev->of_node;
> +	struct clk *clk;
>  	const char *prop;

Small nit, please check if reverse x-mas tree order need to be follow here.

>  	int irq;
>  	int err;
>  	u32 irqf;
>  	u32 val;
>=20
> +	if (!np || !of_device_is_compatible(np, "brcm,bcm4329-fmac"))
> +		return 0;
> +
>  	/* Apple ARM64 platforms have their own idea of board type, passed
> in
>  	 * via the device tree. They also have an antenna SKU parameter
>  	 */
> @@ -105,7 +110,7 @@ void brcmf_of_probe(struct device *dev, enum
> brcmf_bus_type bus_type,
>  		board_type =3D devm_kstrdup(dev, tmp, GFP_KERNEL);
>  		if (!board_type) {
>  			of_node_put(root);
> -			return;
> +			return 0;
>  		}
>  		strreplace(board_type, '/', '-');
>  		settings->board_type =3D board_type;
> @@ -113,33 +118,39 @@ void brcmf_of_probe(struct device *dev, enum
> brcmf_bus_type bus_type,
>  		of_node_put(root);
>  	}
>=20
> -	if (!np || !of_device_is_compatible(np, "brcm,bcm4329-fmac"))
> -		return;
> -
>  	err =3D brcmf_of_get_country_codes(dev, settings);
>  	if (err)
>  		brcmf_err("failed to get OF country code map (err=3D%d)\n",
> err);
>=20
>  	of_get_mac_address(np, settings->mac);
>=20
> -	if (bus_type !=3D BRCMF_BUSTYPE_SDIO)
> -		return;
> +	if (bus_type =3D=3D BRCMF_BUSTYPE_SDIO) {
> +		if (of_property_read_u32(np, "brcm,drive-strength", &val) =3D=3D
> 0)
> +			sdio->drive_strength =3D val;
>=20
> -	if (of_property_read_u32(np, "brcm,drive-strength", &val) =3D=3D 0)
> -		sdio->drive_strength =3D val;
> +		/* make sure there are interrupts defined in the node */
> +		if (!of_property_present(np, "interrupts"))
> +			return 0;
>=20
> -	/* make sure there are interrupts defined in the node */
> -	if (!of_property_present(np, "interrupts"))
> -		return;
> +		irq =3D irq_of_parse_and_map(np, 0);
> +		if (!irq) {
> +			brcmf_err("interrupt could not be mapped\n");
> +			return 0;
> +		}
> +		irqf =3D irqd_get_trigger_type(irq_get_irq_data(irq));
> +
> +		sdio->oob_irq_supported =3D true;
> +		sdio->oob_irq_nr =3D irq;
> +		sdio->oob_irq_flags =3D irqf;
> +	}
>=20
> -	irq =3D irq_of_parse_and_map(np, 0);
> -	if (!irq) {
> -		brcmf_err("interrupt could not be mapped\n");
> -		return;
> +	clk =3D devm_clk_get_optional_enabled(dev, "lpo");
> +	if (!IS_ERR_OR_NULL(clk)) {
> +		brcmf_dbg(INFO, "enabling 32kHz clock\n");
> +		return clk_set_rate(clk, 32768);
> +	} else {
> +		return PTR_ERR_OR_ZERO(clk);
>  	}
> -	irqf =3D irqd_get_trigger_type(irq_get_irq_data(irq));
>=20
> -	sdio->oob_irq_supported =3D true;
> -	sdio->oob_irq_nr =3D irq;
> -	sdio->oob_irq_flags =3D irqf;
> +	return 0;

....
....

>  /* Detach and free everything */
> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c
> b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c
> index 9a105e6debe1f..f7db46ae44906 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c
> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c
> @@ -1272,6 +1272,9 @@ static int brcmf_usb_probe_cb(struct
> brcmf_usbdev_info *devinfo,
>  		ret =3D -ENOMEM;
>  		goto fail;
>  	}
> +	ret =3D PTR_ERR_OR_ZERO(devinfo->settings);
> +	if (ret < 0)
> +		goto fail;
>=20
>  	if (!brcmf_usb_dlneeded(devinfo)) {
>  		ret =3D brcmf_alloc(devinfo->dev, devinfo->settings);
> --
> 2.34.1
>=20
Reviewed-by:  Sai Krishna <saikrishnag@marvell.com>

