Return-Path: <linux-wireless+bounces-12301-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93B9296766E
	for <lists+linux-wireless@lfdr.de>; Sun,  1 Sep 2024 14:28:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 209D01F21A8C
	for <lists+linux-wireless@lfdr.de>; Sun,  1 Sep 2024 12:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2918170A3E;
	Sun,  1 Sep 2024 12:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="10x6gg1e"
X-Original-To: linux-wireless@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2041.outbound.protection.outlook.com [40.107.93.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C12131C36;
	Sun,  1 Sep 2024 12:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725193713; cv=fail; b=AB4pJBN2mCwCXFSV5S1pTywCLohSxLoNSjHT1JJsjSRWbKPt9BV6qLCHzwXd/k7GfKrg3WvFy7AVGUgope3D0TzKDbhetxEKZQbCvDr0L5Wb67D+qesQNDU+hlan91sZ62hlFQ9NqRc02sSN6mJsA2G3E+jbNUL0anEuyHrqjJA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725193713; c=relaxed/simple;
	bh=fDp/KczfG6mf+4yGFc/kKAhZhb8cFMZlARlWFaOprqQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DnMODVVtF5T42xsFp/vCSvQiiQAz8Yht25aN8gzagjr/uxugOVwzjG30qJBr9Nr9M8uSya88FJ5bwJSw7U3CdTmNs16YCYfYjv28USKUKB7fqCvUGldUXBidXp8GRwZ/TuK4Iji09IVtvM9PN+Hys2YM3wDgREU/Dhn9UvVdBIA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=10x6gg1e; arc=fail smtp.client-ip=40.107.93.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gP/B35jDtxyaGV0SjMZ/gyFiU0H7YOjlyRH66QackN4lnC8nfTWIUtPAP47v6nTrSxFnnnMnLerrsm3UfGyp5p1C23pKFTlMMTRul4RqAxBpe78ufFBxuEY0RB3m5A8ZrNjplWfBE/PtAgNnWAzyyCz0p/v14/cMdgGipU2qejnfVM3efJSvrDt0bcmXZDI/4SnZrBSnc92zWLPSRTEX/+JsSa81kYrKMUhabXHq0N2CnBT/8U5j5JKJU220/19FkWspNvpo8m75N4pgmrgQN6LBEkdmmj+18kt8bTmmky1V37OBbxI5JncFqasdRKUf0KFAcj2ifD7CJMMJr+Ea2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kZIDzCaPtSizD5wDX3P6E+ceDSLkuG6h4aWwygqDsd8=;
 b=X1A+5JPiGH4lGYQdPwiagaMU+Pk5pyQn3FGVztSIsvBJ/VGiqf5CqQDl6XDaB+B/UfS2oxOTgwL8VjJrLMDD2JWBW+4wG3KhLv7d6BJ4N0XInQIK0kmp0h+hqMIMqrh8KpE+/+XtnKbaZNOvk2Vt2+vfYKaKvOHOrk7v8zj3nSvx2WwwGR7ht88Ked2SZdmlSUVnQ2eU0NvIAGH1OD3A9tB0b3elJ6SOxb0vZ8VXzCkX4Q2VCuFsifSlj8Kw5YAhwIetgm2qVGM9/sSFOZJwm0RzOJjhOVl0XEMumFeC5en+P62ZmgYOikyffmskgHBl7lZhOofYlQfbbvE7U76IYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kZIDzCaPtSizD5wDX3P6E+ceDSLkuG6h4aWwygqDsd8=;
 b=10x6gg1eDVIjJ25SVhpa7ggW5pS3cCradqrdQfXs+1Q3xSW2dET5Ou5fz4OaC1PFlvaIlnOLeuXoPh4epxHLlExQyrOfPAEtvJudFPvIjoB3L3Lhsl46APMQ8kEv8N9zQ8sYePMJ3wRjlA5vDHDb1ijdAhHpl2jQX2OMxqJ4Td8=
Received: from MN0PR12MB5953.namprd12.prod.outlook.com (2603:10b6:208:37c::15)
 by SN7PR12MB8604.namprd12.prod.outlook.com (2603:10b6:806:273::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.23; Sun, 1 Sep
 2024 12:28:27 +0000
Received: from MN0PR12MB5953.namprd12.prod.outlook.com
 ([fe80::6798:13c6:d7ba:e01c]) by MN0PR12MB5953.namprd12.prod.outlook.com
 ([fe80::6798:13c6:d7ba:e01c%5]) with mapi id 15.20.7918.020; Sun, 1 Sep 2024
 12:28:26 +0000
From: "Pandey, Radhey Shyam" <radhey.shyam.pandey@amd.com>
To: Li Zetao <lizetao1@huawei.com>, "florian.fainelli@broadcom.com"
	<florian.fainelli@broadcom.com>, "andrew@lunn.ch" <andrew@lunn.ch>,
	"olteanv@gmail.com" <olteanv@gmail.com>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"wens@csie.org" <wens@csie.org>, "jernej.skrabec@gmail.com"
	<jernej.skrabec@gmail.com>, "samuel@sholland.org" <samuel@sholland.org>,
	"heiko@sntech.de" <heiko@sntech.de>, "yisen.zhuang@huawei.com"
	<yisen.zhuang@huawei.com>, "salil.mehta@huawei.com" <salil.mehta@huawei.com>,
	"hauke@hauke-m.de" <hauke@hauke-m.de>, "alexandre.torgue@foss.st.com"
	<alexandre.torgue@foss.st.com>, "joabreu@synopsys.com"
	<joabreu@synopsys.com>, "mcoquelin.stm32@gmail.com"
	<mcoquelin.stm32@gmail.com>, "wellslutw@gmail.com" <wellslutw@gmail.com>,
	"Simek, Michal" <michal.simek@amd.com>, "ajay.kathat@microchip.com"
	<ajay.kathat@microchip.com>, "claudiu.beznea@tuxon.dev"
	<claudiu.beznea@tuxon.dev>, "kvalo@kernel.org" <kvalo@kernel.org>,
	"u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
	"jacky_chou@aspeedtech.com" <jacky_chou@aspeedtech.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-sunxi@lists.linux.dev"
	<linux-sunxi@lists.linux.dev>, "linux-rockchip@lists.infradead.org"
	<linux-rockchip@lists.infradead.org>,
	"linux-stm32@st-md-mailman.stormreply.com"
	<linux-stm32@st-md-mailman.stormreply.com>, "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>
Subject: RE: [PATCH net-next 10/12] net: xilinx: axienet: Convert using
 devm_clk_get_optional_enabled() in axienet_probe()
Thread-Topic: [PATCH net-next 10/12] net: xilinx: axienet: Convert using
 devm_clk_get_optional_enabled() in axienet_probe()
Thread-Index: AQHa+0pG63PUtkZMO0CxH+tw1ly4FLJC3IsA
Date: Sun, 1 Sep 2024 12:28:26 +0000
Message-ID:
 <MN0PR12MB595396074210F8390ACE409DB7912@MN0PR12MB5953.namprd12.prod.outlook.com>
References: <20240831021334.1907921-1-lizetao1@huawei.com>
 <20240831021334.1907921-11-lizetao1@huawei.com>
In-Reply-To: <20240831021334.1907921-11-lizetao1@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB5953:EE_|SN7PR12MB8604:EE_
x-ms-office365-filtering-correlation-id: 876b0a59-e770-4baa-491c-08dcca819443
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|921020|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?bJYMnDsh8IA25jdXaXv8+XY7DbFLBqmeVroW/A5UiOw8Cu8YQq8dvrtQ3K4G?=
 =?us-ascii?Q?qPrmJliYLAubA3qJ2p3lMci+xYMWKOTAkia0/Jb7Hleg0Iw4zonxRBh3CWiC?=
 =?us-ascii?Q?6rmeKV58uTTp+hBPBxC8kv81cNnHRux0J7OzX5f4hCDybjx7z1GKqDZt9FxC?=
 =?us-ascii?Q?1VP+WTlnucY1aFhWjHdaUv3kKU0G1T8R9XVn087xNnqTI/CfKLQWbFV4m0cY?=
 =?us-ascii?Q?5Tp1LsuQCLlfAbmmCvs3T1t72twPbswsx0OOX7N7IHb4AWhOj1htsaHdFy//?=
 =?us-ascii?Q?Rgp04jMVvE/7xoTvEil9gwCPQ9P083ueI7hRjZbVNSteOLLI/sKzIzhfSQ23?=
 =?us-ascii?Q?cT3xn5XNUgUW+U8tK8czYfZE+zS61YKt3czZsiHMVqte/aux53ecTeMCD8Wd?=
 =?us-ascii?Q?KlwovSTIBZCJC2dLzG9Cu20wm1b5SYNhmiGQvQzoIYkbAaxnqPxQWeAMXpIz?=
 =?us-ascii?Q?0rTKjkXIBTtfK2zN1dzJBspwcEEIdA0rKpkFOVLZSRJwKeWuGenktLJG1afz?=
 =?us-ascii?Q?NEJNiu6f294CIg6RU1Fhqs+GezOra1vhGhbnlu6fekuZr5lothZ3kh9o/r2x?=
 =?us-ascii?Q?P6fBolCnWADJYem3ApAw6j3FPzs08B6XWxrhW6540AiDI8nC523jNQnWhf3A?=
 =?us-ascii?Q?vlNA3e8ckgP2YISOub6miMbs9ZwcI335KAGeRfxZyCtWFBLSI823us1m0Hzb?=
 =?us-ascii?Q?WIiVLYLHTYncvQFWjfXs1c9FH86OT6HbWXAmYhiVdrO1d0dWhfag4BTFbXAL?=
 =?us-ascii?Q?I6Ln0xiXIh5i+v91pf14Y/tEBFzMzX3R3ckWVRXQQi9aeZSsaJxPPCbwb1Za?=
 =?us-ascii?Q?fpIXYWWej/MtNC4WR67LsYpGDmoLR3Uo6aLCrpQb5+yqpsJhL6baMVgFaGqk?=
 =?us-ascii?Q?Xrx2mGF6Yk33WSq5krxQJnJJ3Inc0pVRtsUCkKmZgEilvZHq5PLXiB5brUAk?=
 =?us-ascii?Q?YgpnqhNcpiHo5bX4aVQikB3iNpU6MEXc3I6wz/GJjFlCuToaG5QXhUXpiNxc?=
 =?us-ascii?Q?XKaEYRKAGaZG1pjgHpaWwZLdlRzI2mt3v/A+pIkYgCvsQlK+Sd65kRlTjmsx?=
 =?us-ascii?Q?3L/IwXtWFpmDZzQxQkfQkc4KA9nGzlsUPlehqTiU1j69MV7V3a+WFuHzoonx?=
 =?us-ascii?Q?XcUHgUyjw06k3ih26rwTyN/jHOMWVWZYPbwl0h8QE0DxTd1lghdWcyN/tvhc?=
 =?us-ascii?Q?M/EJgRy3tnl6jJlgw7wxgBxZdNvK4fJM5w0G+T+2xagB29RIYtVspMLlS5ZI?=
 =?us-ascii?Q?2DMlWzTmepAGLP8c8CTpliFLBz/r1OyKPAhB/egdeGGG5e3LSRMyH8wF5jMS?=
 =?us-ascii?Q?m5OKSZ5FGzthgUw6mooqvI84cTqV45DhC3mXBwJd+D1bSoBzVYL1k5Et6jKr?=
 =?us-ascii?Q?Wfm9wWP3ITIpbYT4ZsvH/tdspllox3vjlSkoRHlWiYiOzwHn5nADopgVx0PB?=
 =?us-ascii?Q?uLGCbdysHhc=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB5953.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(921020)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?aqtELvTOmnVChDQmRMyrlpWAN+03B2i29VZvtg0uW9HfmWAj2PvDTpgggSKh?=
 =?us-ascii?Q?V+sUcCTTLLe513UzhV6OM4vtUuFeYc4wV2l2RjZIKpxPC1hjHa4VkPQiyA8J?=
 =?us-ascii?Q?IrRXvJD6wLsKP4o1RIuAtFgxzRHNovs7zXV12+HDCwIy5t9dMIa6qQioI38Y?=
 =?us-ascii?Q?m0CA83h9Zfwv+URzG34ZIimFqzZ4Hsuc58sSJNb4+H1OZ5f2bzqWgrL+m+9n?=
 =?us-ascii?Q?MdK4/9hJgJF7c5IlxvwMGwqd+02kGYiVvl6/OM4s/97Q6BiU/SqH8sjbRl7i?=
 =?us-ascii?Q?9hRoIDgS9D6PlE2zAsYwinVAvNEg86IFUTvFMYyvRNyzWFT2TW906MfRy8uI?=
 =?us-ascii?Q?2oOz9oK8OhFihBMd+eHpjXbXeCGHHVhdP2dYcfaZnsynlfKIwN/TKs207alG?=
 =?us-ascii?Q?H3PRH4ZwQLsTzFgOEXOGlZn3yG89Dha8n+x1jbICfpSSYiS+QweDmJ3TSMeF?=
 =?us-ascii?Q?1EzxClbVRvPMbrOg40+Q/KY3cOBn/2ppqHAKv2+D3+Zwa/ZYDyTgi2yd8DNG?=
 =?us-ascii?Q?xidqOeVIMMkrfzUU+NDpXIX8GxlshIjzeXDQ/gLK2AFDgh6OKQxl4IsYsVpZ?=
 =?us-ascii?Q?kjrKi5fAEFNM1B+Qo4dps/WjYIMWde4zlwr8Z3I30VBSgl0bMJdwVIFHF0jf?=
 =?us-ascii?Q?EaBuOIgdcN3EB5d7BZ1XmW7RrOWEIWNwyC/tVR3OvYHbr4yAYjRoW7AWoET4?=
 =?us-ascii?Q?VjMQ+2Mc+g23es2oCtPAqjxxX64kYtMoVJC3hk85pcZTh3/s/ENtRGZ/prf7?=
 =?us-ascii?Q?o+7tH4YfWnmRa50awoI8BSMUSZ/pO/ckHdEQu3MvOjsMyRCSCvbxtSCP42Uf?=
 =?us-ascii?Q?3Y8FWEYGp+i39q3Gvh750M5sVAIkTLOVC676YMiepBaWFGe7zmntXBmzUfbJ?=
 =?us-ascii?Q?uSGTfX2ByZJCI6KsnGRVxdl3qw9emnv3NkXxobUB5w3l4ZdKJe7d/fUQP2cJ?=
 =?us-ascii?Q?0U+1PSgmBxEr485THTZGV1F5qB15FrDhW1R1Dn/45Q2ChAIIJ6SRRtrW9EPt?=
 =?us-ascii?Q?GhtbvtGUH5CO5W7Emqtq7n6OjnMta9MZQ7Ys9EPmS/EwMhI9RJR2TsF7yPGL?=
 =?us-ascii?Q?XYC2cW5YVG4kjWbCtMCG60AScJNig5OlNJFyA5WK0ppWEBUjIhLD3qhMO1sa?=
 =?us-ascii?Q?wwqbkKkOEUf+vawi8kH1LYP/HabmcbLPpyEJZChAoooebl/VffUDbGki2uNM?=
 =?us-ascii?Q?jDbUthtYmdnJvwyqMduHmMicFR2iQ2OI1y1efvUU9NE17swlJkMPtWykB+fu?=
 =?us-ascii?Q?A3F5R3vuk4h36EaQCpomenoaK6S30gbXyS1LahF70XPIHdISGdFvW2+YkO/O?=
 =?us-ascii?Q?r99UA+NkX/4n2VrK46EZSYSrpi5CdJ3DrGoF4a96wH4CS9mWj2KdeBWFXez4?=
 =?us-ascii?Q?Z6Mi0zplt0GRVmy6I7Qj7AG46Dp19E3CIX/r7UqlWlaFkoBYqr1BvxZmk+M9?=
 =?us-ascii?Q?0H7YEualazc0VKl4AWnMhQrX9OA8f6iSZ02Fz4lBiXOPZ/Ii/W3dVdA+NgMq?=
 =?us-ascii?Q?xpeMRo/6yOerBOQGfvq3JAQ7zXAt7gY/19uCC0EoAF2YP0aS3/1l+/EZJobk?=
 =?us-ascii?Q?MpBVgIkVM9WrnKqyHMc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5953.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 876b0a59-e770-4baa-491c-08dcca819443
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2024 12:28:26.6537
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ff/gvG5IG8HJLPxpN9R2EgVL6VjkF2ek3x+oYxKPXbtNQYObqEsglvQAmtqHWvMu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8604

> -----Original Message-----
> From: Li Zetao <lizetao1@huawei.com>
> Sent: Saturday, August 31, 2024 7:44 AM
> To: florian.fainelli@broadcom.com; andrew@lunn.ch; olteanv@gmail.com;
> davem@davemloft.net; edumazet@google.com; kuba@kernel.org;
> pabeni@redhat.com; wens@csie.org; jernej.skrabec@gmail.com;
> samuel@sholland.org; heiko@sntech.de; yisen.zhuang@huawei.com;
> salil.mehta@huawei.com; hauke@hauke-m.de;
> alexandre.torgue@foss.st.com; joabreu@synopsys.com;
> mcoquelin.stm32@gmail.com; wellslutw@gmail.com; Pandey, Radhey
> Shyam <radhey.shyam.pandey@amd.com>; Simek, Michal
> <michal.simek@amd.com>; ajay.kathat@microchip.com;
> claudiu.beznea@tuxon.dev; kvalo@kernel.org; lizetao1@huawei.com;
> u.kleine-koenig@pengutronix.de; jacky_chou@aspeedtech.com
> Cc: netdev@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-
> sunxi@lists.linux.dev; linux-rockchip@lists.infradead.org; linux-stm32@st=
-
> md-mailman.stormreply.com; linux-wireless@vger.kernel.org
> Subject: [PATCH net-next 10/12] net: xilinx: axienet: Convert using
> devm_clk_get_optional_enabled() in axienet_probe()
>=20
> Use devm_clk_get_optional_enabled() instead of devm_clk_get_optional() +
> clk_prepare_enable(), which can make the clk consistent with the device l=
ife
> cycle and reduce the risk of unreleased clk resources. Since the device
> framework has automatically released the clk resource, there is no need t=
o
> execute clk_disable_unprepare(clk) on the error path.
>=20
> Signed-off-by: Li Zetao <lizetao1@huawei.com>

Reviewed-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Thanks!

> ---
>  drivers/net/ethernet/xilinx/xilinx_axienet_main.c | 15 ++++-----------
>  1 file changed, 4 insertions(+), 11 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> index fe6a0e2e463f..48b41e95aa74 100644
> --- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> +++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> @@ -2584,22 +2584,17 @@ static int axienet_probe(struct platform_device
> *pdev)
>  	seqcount_mutex_init(&lp->hw_stats_seqcount, &lp->stats_lock);
>  	INIT_DEFERRABLE_WORK(&lp->stats_work, axienet_refresh_stats);
>=20
> -	lp->axi_clk =3D devm_clk_get_optional(&pdev->dev, "s_axi_lite_clk");
> -	if (!lp->axi_clk) {
> +	lp->axi_clk =3D devm_clk_get_optional_enabled(&pdev->dev,
> "s_axi_lite_clk");
> +	if (!lp->axi_clk)
>  		/* For backward compatibility, if named AXI clock is not
> present,
>  		 * treat the first clock specified as the AXI clock.
>  		 */
> -		lp->axi_clk =3D devm_clk_get_optional(&pdev->dev, NULL);
> -	}
> +		lp->axi_clk =3D devm_clk_get_optional_enabled(&pdev->dev,
> NULL);
> +
>  	if (IS_ERR(lp->axi_clk)) {
>  		ret =3D PTR_ERR(lp->axi_clk);
>  		goto free_netdev;
>  	}
> -	ret =3D clk_prepare_enable(lp->axi_clk);
> -	if (ret) {
> -		dev_err(&pdev->dev, "Unable to enable AXI clock: %d\n",
> ret);
> -		goto free_netdev;
> -	}
>=20
>  	lp->misc_clks[0].id =3D "axis_clk";
>  	lp->misc_clks[1].id =3D "ref_clk";
> @@ -2915,7 +2910,6 @@ static int axienet_probe(struct platform_device
> *pdev)
>  		axienet_mdio_teardown(lp);
>  cleanup_clk:

I also find that there is goto to cleanup_clk when devm_clk_bulk_get_option=
al/
clk_bulk_prepare_enable fails which is not correct but as it is existing bu=
g it=20
can go a separate patch.

>  	clk_bulk_disable_unprepare(XAE_NUM_MISC_CLOCKS, lp-
> >misc_clks);
> -	clk_disable_unprepare(lp->axi_clk);
>=20
>  free_netdev:
>  	free_netdev(ndev);
> @@ -2939,7 +2933,6 @@ static void axienet_remove(struct platform_device
> *pdev)
>  	axienet_mdio_teardown(lp);
>=20
>  	clk_bulk_disable_unprepare(XAE_NUM_MISC_CLOCKS, lp-
> >misc_clks);
> -	clk_disable_unprepare(lp->axi_clk);
>=20
>  	free_netdev(ndev);
>  }
> --
> 2.34.1


