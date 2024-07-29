Return-Path: <linux-wireless+bounces-10593-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CD8E93ED63
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jul 2024 08:26:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3921C1F224F9
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jul 2024 06:26:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A62FB8287E;
	Mon, 29 Jul 2024 06:25:57 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from HK2PR02CU002.outbound.protection.outlook.com (mail-eastasiaazon11020103.outbound.protection.outlook.com [52.101.128.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D639183CDB
	for <linux-wireless@vger.kernel.org>; Mon, 29 Jul 2024 06:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.128.103
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722234357; cv=fail; b=PyOfaUYEGC374tB+yIkD3HtrNezCEWx3D4l4+XBfSHWbkKojqWC72ClVRA7izD9tAS7txQW40AX9pznkU8y2JVS4NkE7bND/0tO1bq0yfS6ZQ3cGpMD2ahHEam9+znvL5nE9VkbeSC7rHlXZyqsO5Gw3OAiuzxVRYVEBe5Y1NDw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722234357; c=relaxed/simple;
	bh=V/8lxoDjN9f6ETGvzNkZprCfwpAT7fYO+9y4zrzIrmc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=odvaQ1A+D0n1ITsLWIuXH2FU+HGyAWXVzfSrItD/WGQJUQrrq6wZa/BEY0zYFl792T7LqLrTUTgnATfjvZrAmLDnkodRb0mQrw4e/PxWjVW7aIxQAlwPyqS3eF+/hJhA3weIJFLhhrES8G3942SwyYbgjmjGcDio5rYmDOArV9k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com; spf=pass smtp.mailfrom=wesion.com; arc=fail smtp.client-ip=52.101.128.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wesion.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BmNBUQ8q0IwTsIifDiEyD0aZOXG5kChFu5N0OMfwauy5Z3gOp64BbJIvCa27ywhsVZMm0+SfYZqBPmsKIEp49E+NIwZf44YZJkdivVRDvuThAbYJIuaJQLKz3vIWCEOxPfby1LywZVAWygGYghBqA+CqkfEAMULfg8B2zhhfs0iWRccW4o2l3gY0i7hjiNpYBLaeUs+eznpJ4bAbQIIqAmSYKk7FKkGkkwOzZAXMTYDnD77mnKlEQ71lXjYYfXA9jND07JQok9WHSXNgDt6bWYjR1VA0O4PnAWtN6BTR60qP1vhmsohxkoXaYXOJRuT7VwIUaLr2IRRGB28P2MXbMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V/8lxoDjN9f6ETGvzNkZprCfwpAT7fYO+9y4zrzIrmc=;
 b=sdqzW3KHN/u+CTSz3eqrd0biDhrBA7pbvtJdoo2Y9GKQqtNJ4YJnPJzTVq0yXN6xx4glVvgnsN1nJUT+ZML5VxX4VnZGyyT8H74PXj1+Ayr3QMeMiqk8t2TmjEmEVKkp3NkmyEFx8wEaGb6g928QWVmdPkGB2KdIQu8r0x9a1Ps47ssqWP7Rj7fHCvkVseZ3YP6wO1IGHlsJ8JtISUnj1CMGXRD2IJrhc8+I4/6P3zi/X0g4730ZyqC9zzLjIKk7Fqv00wdPF7XF87tT9u2AsN256UyUvlY2nLdliYSBXAfKCpI2HiYY3VcckjcCV066bK6VbBz3W3br096ssPoP8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wesion.com; dmarc=pass action=none header.from=wesion.com;
 dkim=pass header.d=wesion.com; arc=none
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com (2603:1096:400:26a::14)
 by SI2PR03MB6686.apcprd03.prod.outlook.com (2603:1096:4:1e9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.32; Mon, 29 Jul
 2024 06:25:52 +0000
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0]) by TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0%6]) with mapi id 15.20.7784.020; Mon, 29 Jul 2024
 06:25:52 +0000
From: Jacobe Zang <jacobe.zang@wesion.com>
To: Arend van Spriel <arend.vanspriel@broadcom.com>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"brcm80211@lists.linux.dev" <brcm80211@lists.linux.dev>
Subject: Re: [RFT v2] wifi: brcmfmac: add flag for random seed during firmware
 download
Thread-Topic: [RFT v2] wifi: brcmfmac: add flag for random seed during
 firmware download
Thread-Index: AQHa4SXW/1EHZWDHk0CUxxPx7MBqPbINOn/OgAAC1V4=
Date: Mon, 29 Jul 2024 06:25:52 +0000
Message-ID:
 <TYZPR03MB70019A591F0717F365A3392280B72@TYZPR03MB7001.apcprd03.prod.outlook.com>
References: <20240728193904.35820-1-arend.vanspriel@broadcom.com>
 <TYZPR03MB700147CA6C80F34B8E3D5CC280B72@TYZPR03MB7001.apcprd03.prod.outlook.com>
In-Reply-To:
 <TYZPR03MB700147CA6C80F34B8E3D5CC280B72@TYZPR03MB7001.apcprd03.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wesion.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB7001:EE_|SI2PR03MB6686:EE_
x-ms-office365-filtering-correlation-id: 42ac4e3c-9c77-4733-86de-08dcaf974b7d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?P32OECLY0rpbGX1svdg8m+ap6teRkgtdoVdNiRCbxADMJT7tQeqfczQgvp?=
 =?iso-8859-1?Q?oZ5XOgHGS0A61KJEOe7ke8LAPH3Rr5JG+Dpr1MJiHER6xVfnM0VllL9hTJ?=
 =?iso-8859-1?Q?tNtJU5ayUJbaV2o2YhG8ijColiACUGbunv2rZmNsqYZAbR3apMwUEUHZLK?=
 =?iso-8859-1?Q?d6fCEhQrX+gm5aaKKofDym54WAGCyRJzlVPt/1p7FtPuheb+p8CTQoY3cd?=
 =?iso-8859-1?Q?RQTiGrfwmNa4bFm3ojJfpe8tleCjWj8idraU4Ndw3snrhEJCxts3fId3zr?=
 =?iso-8859-1?Q?8wgnlmayRMW5qguM8UznIIKG25ZH5aPIW7V+kxD7p09afjmOkH1s7EGR8T?=
 =?iso-8859-1?Q?bOOXTC8jz9fDXVkdMcPMKsqgdGQTMO1qTm78h5fFNGUySvT2f7UC/ACvMe?=
 =?iso-8859-1?Q?MYci0pO6g8UPnxnHBUhfgswrxuqWdm/jkDlgmG6b1D4TdxmKKbXsT2skNd?=
 =?iso-8859-1?Q?YsETBI3t3neUdFS5iL6xmQ5Zpjkz+V2DXCS0G+f/t1MHL6298d5ABMlssS?=
 =?iso-8859-1?Q?9Ivl7dV3t4CmKEtS14cXo3pfkaTeH4/ndEaKbVTPHQdvPNN/VjTBcFdO1R?=
 =?iso-8859-1?Q?qhRMR0f75yp8MU6xozXF6lv5mGUuEtdG/y5jKxzUhSj/v6pGIDkVkt6PvB?=
 =?iso-8859-1?Q?TzoX2BWXyYAnwK5UMVyYMZcNKKC+EeqEdTN0MPvcTN3FhuC6ieM9JdLAWX?=
 =?iso-8859-1?Q?pWFaF9ikLWzG7/hR8MnKeBF0KHesVHWtyvD25WCvT/s1+4cb+hgmd2LiAk?=
 =?iso-8859-1?Q?9f4LOZJiDUrM5xagyDiS37b38UNEAE5P/n/tVN2xLS/o90P9b0vfoeU8vq?=
 =?iso-8859-1?Q?98QTmY5d1snUz+r6X8OkNs41xduwK84GbDmq+39EuxT3tvfshxPcy/dIOb?=
 =?iso-8859-1?Q?J38cBWQNt97VepwcDG1Fch838KWwPR9JaQZ9pkTDXb4mH/b69015TpMUus?=
 =?iso-8859-1?Q?wVk69KNuQUK5Ju4buBDL6t/hLGz3Vd6+fIQvZuLCC/Z/7p7rV0LdVm3LdE?=
 =?iso-8859-1?Q?Jx/qvpknrwZLxKmhtCDj03P92ntlvrzBXiPaHY6NCDxwB8Gi03wnDMIftA?=
 =?iso-8859-1?Q?BpVtF/nXupp1KXoPWlCltaySwWI6WLOnLAbTkw4QJ0Jb9ovIarFTuPu2rZ?=
 =?iso-8859-1?Q?UgOMfQ3SEilaUHZh0O+LcGHSoM9BXYGcSU8btJgKasMzk5jnRWeYG9Bulw?=
 =?iso-8859-1?Q?ovQsbGGBDePmCp30lSYHbwbMoGJ0681e3rGnmYMHXOkyhkDsgChD67gUSN?=
 =?iso-8859-1?Q?fnDGSX/hEeuLqhl5INEs7VKeEbWZz5w+Ho8gpbZDBGM/6zL8QkmrNlLz3w?=
 =?iso-8859-1?Q?3r/Mbj9iXVB8Z+BslmcPQeqU4+A8kt/BHOicHlkl1pr5cOtTORDJ6yI2Ws?=
 =?iso-8859-1?Q?qbhU8AX5Zhp+nlWBSIPl3998RUstAGZuFWjz60rqi0Uzud0S4zeieNGKqr?=
 =?iso-8859-1?Q?GAgdOkAdriWp+N2o8BUl3v6kH53O/fIl2gZm3A=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB7001.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?kWm2pENasQudyngUJcU923UZKDADHp9yjriN3Sm0Hmtsr06JmWL5n5ecL+?=
 =?iso-8859-1?Q?WtD2Hmfn9UbiVD0UbEDodYf3+v++2+skNPV57tIRAhQoOm4zl54L2yFUHd?=
 =?iso-8859-1?Q?ceIqekJCLpelPDevKOc0G06nwMZH+s/L6MdXbme2isuXF93yBNF8rPhefa?=
 =?iso-8859-1?Q?h1hKUwpihm6KLBS+y5UCBY32mw21+fIjlR/pJMfJx0IF2l0FCJD/ilfUAH?=
 =?iso-8859-1?Q?IEAVNzh6t5ls1gqBs1gvu8toUvk1q2dFWoVnax5aL86koJMwDRhDQAyQrE?=
 =?iso-8859-1?Q?eYr1Ai73bNZ9hC7AoT31Y8nT7mURoJpP9OVVqihQc4lTuEjU03ZYNzB/W4?=
 =?iso-8859-1?Q?NU83vb0YNkX4yLIt+pz2n8RSnngvg4aWonlM2WUdxKHARrOwNm0iArwHZd?=
 =?iso-8859-1?Q?ZT6b5JgZZKqWk0KeKnf/OyP6epuAMOjtswLRYHRxh+fDq5HWhgaveHJKyV?=
 =?iso-8859-1?Q?fxBaHfIZmLgtTDYU3RP9tepMHalQcdieWym6QIaMp2lScH4MkCk+lSCVnR?=
 =?iso-8859-1?Q?4e9obxNbPZbCP+eRoE1VG/n8zFEmhU5LP8SO2V8ZBjxVoKsamnwewbixYA?=
 =?iso-8859-1?Q?nouDiWcKbaY3YOQjfVUqX8h1zDDf9jkCQxuBYjWsq/zXOxeC/SGuDzJ6gk?=
 =?iso-8859-1?Q?8jbxeO0GyFo57+gAu1hBIJ5AlcSe90xF2S9NZcrSHa5r9GwVSqt629Vobn?=
 =?iso-8859-1?Q?fmbwjvJPMI2zj/fFZ6fMPJKs+IUYa+Y9kNDx0tNJ3IjQEDiBAZdNRsp0vn?=
 =?iso-8859-1?Q?8f4xM7gRtCPY/+g6vpapKmXQT2b8l6ibCsSUGgkVe4VzbvkmMADfGUL2t7?=
 =?iso-8859-1?Q?RrVrwsQlO4jOgi2XnaKVF4Y3fsFHJis5WiPpQuSz5Bv5kqFZvT1672ObRW?=
 =?iso-8859-1?Q?guIO8p7Q9ajxZ7TeEBi2bmDQwfPeqGXtJVreXGw3oQ+K6c/Isnv8aJxLYD?=
 =?iso-8859-1?Q?6TBOZozhMM7HogDGStdvdtRF43bB3SDIwxSeXNZR3QqPIVzzYzCF7xRF6S?=
 =?iso-8859-1?Q?MgrB5Mg+8cQpO2+3OxUR3DQU39/efzy/gTklADyL7j/5d/vUiE0W6kWocT?=
 =?iso-8859-1?Q?Hufw2ZmGIvOcsn3jZ6ZJ1bohWYYLBtManGRS8Bj5B2PemE6ZTQVrZXwkDr?=
 =?iso-8859-1?Q?ZTBtZQZi3kdkL6OBmKAy62Obc64p68fgkDWYzM58Sa3Sr6AVsAFN0ExXSs?=
 =?iso-8859-1?Q?pmV5uMWGYxc9Wi9iLc9xnIUmt2Esy6LKOudu59IdsbWEnA2D1h12F65PZz?=
 =?iso-8859-1?Q?8tgcl3WOYoeqxRgXGIkeq+4G07ryzSyncPmx0kYMbp4AqXJmfCLGOvu9l8?=
 =?iso-8859-1?Q?wDiMhYlHhQa8eWv0iIBNbPo5a7qfqyKMjal14+1MgC1FiDAH5SaFU4ZhAy?=
 =?iso-8859-1?Q?gYyYnQSYW3iuDmo5FwfR+Rpcr7x6gW9I+mMUJ8BMhJKin2kwhXiuO+kVCp?=
 =?iso-8859-1?Q?UT1L96jklnorrMlF4rNxSO6SJxSi2NfoOapBIMx+QSJEm1TYqYaq1HTcBe?=
 =?iso-8859-1?Q?vQaorLLBawEB9eLhYv+0nUmWrVE85rKqy7z0Zv5fWMgDbqUyEGJThaSFOp?=
 =?iso-8859-1?Q?zhBByIUNrnSJ99/zfbxFBaATggl2DY/C8BsTktNZrhajui/utXNojdMwwV?=
 =?iso-8859-1?Q?dFors77/HDGea34V40TioVpAVNTw553VQ+?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: wesion.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB7001.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42ac4e3c-9c77-4733-86de-08dcaf974b7d
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jul 2024 06:25:52.0922
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 2dc3bd76-7ac2-4780-a5b7-6c6cc6b5af9b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YsnL5VSwIW8WILWQTpx9Dhfn7GCrGNVbqn1tHChsyU4lBoFyI6PHD17t2VeNoPyYzXDItQdF+X6ew+Zq75IJ3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR03MB6686

> I found that in drivers/net/wirless/broadcom/brcm80211/brcmfmac/bus.h has=
 already prepared an > enumeration like these.=0A=
> enum brcmf_fwvendor {=0A=
> =A0=A0=A0=A0=A0=A0=A0 BRCMF_FWVENDOR_WCC,=0A=
> =A0=A0=A0=A0=A0=A0=A0 BRCMF_FWVENDOR_CYW,=0A=
> =A0=A0=A0=A0=A0=A0=A0 BRCMF_FWVENDOR_BCA,=0A=
> =A0=A0=A0=A0=A0=A0=A0 /* keep last */=0A=
> =A0=A0=A0=A0=A0=A0=A0 BRCMF_FWVENDOR_NUM,=0A=
> =A0=A0=A0=A0=A0=A0=A0 BRCMF_FWVENDOR_INVALID=0A=
> };=0A=
> So should we delete them? Because you also changed BRCMF_FWVENDOR_ to BRC=
MF_DRVDATA_=0A=
=0A=
Sorry, please ignore this comment, I didn't notice these were two enums wit=
h different purposes=0A=
=0A=
---=0A=
Best Regards=0A=
Jacobe=

