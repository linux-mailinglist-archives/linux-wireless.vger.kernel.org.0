Return-Path: <linux-wireless+bounces-26475-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F850B2DA5D
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Aug 2025 12:53:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3F7D7B0950
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Aug 2025 10:51:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 488181D5170;
	Wed, 20 Aug 2025 10:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="PP+DvRDw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013017.outbound.protection.outlook.com [52.101.72.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D64E219F464;
	Wed, 20 Aug 2025 10:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755687181; cv=fail; b=EHE59YkMaMmvDVhi1FiQ9Dx2gd0GiZSyE2PmO1KIz7OSUydBlMYU7uVXzHkneifkh63+MzMH6O5FKejFfPoHv/zCTowH7/6lU+eBgAOiQ1gL3y+AgRYq4d06i3hcHKo18qP0V8p+i7ZkqVX49zLvRwqeWtum8zO4tcG9t+EzGS8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755687181; c=relaxed/simple;
	bh=hZO0lsyeaX8CYclFSUg9DBn8TXfK0cn0X7JJ8KUI69c=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=s12MqEv4kIMIKg9EkCf9p0GGC412cZjxXZ1lAvRA4n1s+heDLtJjEoFZfMe/KhimjDi1eKXcRVyJNX4ZW3ktVfNB7Wi7tntqvWtARa0bvvqu3/SxR556zkMHtug6HdH9EaNleV3LH6428nJOaYspj68X1O4Uy7g8itxzuMhCbKQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=PP+DvRDw; arc=fail smtp.client-ip=52.101.72.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JlZfE8B6Xt0LOIA+AeSKYms2sNM3y4+wTnKeLW8Fzorfms3gBMy3BbFP9Zd6Po8xJYWgGxtlZsMhYgst7OB87MrYX1TNwhPs24a/bfJa0YZU3EEM5ZEKhxikclDq9Vgind6dOHsbROI+HnuPqe0OMKofrDlOPvsBAPx5Teo2C1/RCDFdWkrnK1e9TTjPAxPq0pmU7IEYkrA8HBnv5RLmvuAAse6fIwFelz6uEFj9I3dh6RjBj7H4L7qkR1VTVs33q4mEuYQVwdBSEaqxOBAIusArqdr2Eh3XgTOezD9WNuXQlW3i4B9QLkzXFANJWVKX3CAVaAZ6WleAXH4E1OGWiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hZO0lsyeaX8CYclFSUg9DBn8TXfK0cn0X7JJ8KUI69c=;
 b=sC6T8aPvHK5bqaoJvR5MkpRvYU9GwHqBCvCocWZv2JCtAewI8QBfqu9WxJhLybYl9ARTlDoLKyHk8mymVmUU69XWRtsmjS8DhsoK0ps+rJTol19aCiZZbjeoOslrHCSKLk2hy9PCdlHoeJRXkkTms6SSMksILyQi9RkCFatriu/Nfv3BrBgIBivPZHfyTz2awny6wCjiT+KPnCrmWN78NCTOyV92+WGZVcxy2HCRMi/Eu1VlXUwFe1RjQko55cHWoaYr+8vYVmtNKa65b0eT8ebOqzFLgj3etGOUD9RV91JUOAbAAGnZCRZb15kQgmUw0fXfoK9KmMP5Q/ZY/BayZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hZO0lsyeaX8CYclFSUg9DBn8TXfK0cn0X7JJ8KUI69c=;
 b=PP+DvRDwo/9EBnqVCNX/0d/pyIbjwXYqlusxkV8Jkdd4MQzwQdeBcYj9wRuQq29o4XQ2kk4tQfcCoHpfyiCjJewuMEYIGnQ5GZQvD/LWnvR0SGztpLoPuy0JUfIOLAqsXeSZwcrQ9zpse9sT6G9id9yQifSpnPx0fNn0Lr4/iUjeVBgR8k40wr9Joj2yV9F/37zW+2lOiPrychUQ/9/IkhgvtsU0PnwSCYrXIdRHvyTJSHhKQcQb25oKrHRHkJPw9KtGSNKjK11Yk1XXwDX3gjtZrJfE6jyKM3M1V9LR5+pYiaLrn9KhRYoOsRLO3grTrAMI2s38Fx9vZHqsyO90sw==
Received: from DBBPR04MB7740.eurprd04.prod.outlook.com (2603:10a6:10:1ee::23)
 by DBAPR04MB7318.eurprd04.prod.outlook.com (2603:10a6:10:1ab::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Wed, 20 Aug
 2025 10:52:55 +0000
Received: from DBBPR04MB7740.eurprd04.prod.outlook.com
 ([fe80::7a71:369b:fb82:59d7]) by DBBPR04MB7740.eurprd04.prod.outlook.com
 ([fe80::7a71:369b:fb82:59d7%5]) with mapi id 15.20.9052.013; Wed, 20 Aug 2025
 10:52:55 +0000
From: Jeff Chen <jeff.chen_1@nxp.com>
To: Gallissot Mathieu <Gallissot.Mathieu@fronius.com>
CC: Brian Hsu <brian.hsu@nxp.com>, "briannorris@chromium.org"
	<briannorris@chromium.org>, "francesco@dolcini.it" <francesco@dolcini.it>,
	"johannes@sipsolutions.net" <johannes@sipsolutions.net>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, Pete Hsieh
	<tsung-hsien.hsieh@nxp.com>
Subject: RE: [EXT] Re: [PATCH v4 00/22] wifi: nxpwifi: create nxpwifi to
 support iw61x
Thread-Topic: [EXT] Re: [PATCH v4 00/22] wifi: nxpwifi: create nxpwifi to
 support iw61x
Thread-Index: Adv7B52mU5UDxz+jT+K2qBGBtnR/zgWtlt2A
Date: Wed, 20 Aug 2025 10:52:55 +0000
Message-ID:
 <DBBPR04MB7740ED7F14AA11C344FBE84C9C33A@DBBPR04MB7740.eurprd04.prod.outlook.com>
References: <cb3be497fa7a45e68d9be6f9b8bc47b5@fronius.com>
In-Reply-To: <cb3be497fa7a45e68d9be6f9b8bc47b5@fronius.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DBBPR04MB7740:EE_|DBAPR04MB7318:EE_
x-ms-office365-filtering-correlation-id: 61656a37-e56d-4726-bec5-08dddfd7b7c7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|19092799006|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?Pl84243XNVZLVd7uNhoTjY6JmrhYVaw93BmOLhmGBXB5dFMo0PkBT8d7n8RT?=
 =?us-ascii?Q?aX1cDCpfAoz+LDpoUy+F3tx/Cj2OrAoErv7SWII/z2zTPzNcq5EZ57UR7Fq4?=
 =?us-ascii?Q?9ft/FeW/8KptSzmDHuXvvajKdOSoqH4nXASPkKRXJj7g2iOTD9e4zr+l0DLw?=
 =?us-ascii?Q?8s3HBqiLm3lEdG9BS6kNEpc4++aGIHBJyTjvkOHBjwnPzCJwENVWo5OhtNZG?=
 =?us-ascii?Q?F+AXtodYMwNzIevSPKd99RIkbCrqt1sCVXB70tdvHewmSfp2IG3NhF3STu3K?=
 =?us-ascii?Q?oPTIPz83bnSt5vfoOe7DZv8t+TBaePO23xqpcOKo7Lanhk5gv93EK0qRJJWM?=
 =?us-ascii?Q?RHbZMy520n4VjBBpysbth5NBwhHwfjjnKWv0+/DHHPHWh0zJV8lGS5Rlvz5T?=
 =?us-ascii?Q?rughIVMB/H2Z6qfGAcOBAPn9nZeZAVQX1kwuSOFsvtyM61apdWGEeJ9oHs17?=
 =?us-ascii?Q?wm3HrCXxlwFi20RHRGNS5EjNhTbwzHIDYJmn40wmFSvC9GEHxzPANlry1Z1q?=
 =?us-ascii?Q?unUy5ecEIBqRJ+iiw+0dDhWD9r/8Buq79qrSeTqtO8elT1EHR4/Q9O6FyXTz?=
 =?us-ascii?Q?PrcQGfjtMcXXKJbmETPzp8PbpiDh94zjJQscLUhzU8sZUNJAfBvE/mMAuvZd?=
 =?us-ascii?Q?dFyTHcFkDyGr7q1/DPshj88Ns7ML9XOxWB+DGxevE7sdkTw3TNXsg2eQmAmc?=
 =?us-ascii?Q?GJ6qV+9J1z9HfCPfhVUUtp/slLTDqIQy1A/qlEOVYltGPcArtWmDxpuK+/7d?=
 =?us-ascii?Q?+5D2hxFaEcESwXkImZnXGlJpAOXbfwSd/NDCaMYi4swg8uYuFw6ufdkNkc6f?=
 =?us-ascii?Q?aIIPqMZxxPlfGQAqUzIgVsQmzwFV8lw504Xxy4ECFVkMU7oGxU+PHXpoP18L?=
 =?us-ascii?Q?E5YVYKI5JuIBfGR/7+P+NvjapN+hsMRfLtyyuSd+tpcaBnBCJIxq7II+r/v/?=
 =?us-ascii?Q?71MjLi7Z9k/H2jm9vbVR0aB5FULPWzlbTT/F8LYtJiqt0wBQpbUilQq4b/tN?=
 =?us-ascii?Q?U2EghhRhKeSUQe8vhifTW7kcW2xGV12JYTMZugvRbSCK8rqHpSSgwF4f+q8C?=
 =?us-ascii?Q?r+qpcVVBDjdr+AP6Aa+gvUes8f+B1HFDG96qBJoTUw9/PmW583L4fPpvuyB9?=
 =?us-ascii?Q?fNt3kxC92w+6zTlBEPad37+xoDnTh/fRGpDq8HSQ8GeStbp1qX8p0+rivg9X?=
 =?us-ascii?Q?mVSy3E2Fs0zbzjX9ysooRGjNyIGu12Hss6aoZrQW9VC+4ONOJ7UazsK4pSXz?=
 =?us-ascii?Q?YMfBg9Hc4NPGQquz3z0bD1kClzMjtfz6IdFyqHc7/9sAnAPlKpIwR4/Oqy3c?=
 =?us-ascii?Q?RQDWxQrU5j0/TX0fTDXRldWULoU7vx9ZT4OrexqZsf4zet/Ao6ky8cxXFe23?=
 =?us-ascii?Q?inYdU75yXgBqEvHH4vcgcJkGS+awmSVqveZjuMrdX+bdHEkMA2Lz8nxOXd75?=
 =?us-ascii?Q?nKR0Kk+mAFU9dTcNyT4RxdzwGUDY7vyDKCRg3Qu38+lkz1ArcuCtNQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7740.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(19092799006)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?jx0jcjG33WUgT5BZmZPZ1m3VjGTL8pDxolefGXPC8rNaz+2tMbfoQqXY9TOM?=
 =?us-ascii?Q?dMBjq4qqkTY+OWHXZke6s6XJcqUEN6M60LTifKx8WLSm4QmSH8ohhWu3f6x8?=
 =?us-ascii?Q?fsRfP00etUX8g48U9T0CipBzw3Y/Vnjqr54dZjy9AJXS8y5Jd3JaN3n9fvQJ?=
 =?us-ascii?Q?oWBWG8WW1T9BVZndWy4iGqNzG0vPH937+W0PcRvE8YzAOWY3zcY4A5SyDFRM?=
 =?us-ascii?Q?2YLfVzgbjlLH/6jsyrg7CwPGMuJnp0Yf9GtDO7xmDS5ma0HHgBsMFtlfEKDN?=
 =?us-ascii?Q?mQDyjd4G/b7Y2ipdsH+JNb5xJpMjVHtmGnRSeJchkF02C5N8KnxdUkn5r2tB?=
 =?us-ascii?Q?IVmi2I0aqpwSlPavW7MxadE8v94/0e2rhS4Xrkrc00UzMeb736UueXiSUV9Q?=
 =?us-ascii?Q?30m83ZBDDpp0eAGQJtclN2YGunnkFZnCbX2y/BvvQ4/NUWxIJ7/e1Etd7+CI?=
 =?us-ascii?Q?/TbVrJS2IMU6cu0uuCsX1Ee8TWj4+uiAumf1sXQ/kWKaQoeWfh9q11dUj/cs?=
 =?us-ascii?Q?OJnh0NVPI8iTPETqqbnB8lWaNBqCX4hmmptfDYiU3UqdhCCPTM+55qQNsxhF?=
 =?us-ascii?Q?8lKoQmIMH8vfABMvu/m6MO1WCOyy3gvzlfjWtAzQMnm3rjN8zYl79e6XFeWy?=
 =?us-ascii?Q?18v6vxfInavIexwUFVNuBkgQ4uP2DdewWBCcDfXU5spultrVE63KLNUKk6Wp?=
 =?us-ascii?Q?0nU5WVRi1NoQFY31QSbZI3mpolKJv/SBNjJdqhhLFC9SKysYk+zBw1venr85?=
 =?us-ascii?Q?auFz2LQqtyKSWGbOCIJXPyN2q0dCaA3k238+xlcDIIiNH0dB2w5TzU7qPZnP?=
 =?us-ascii?Q?0xC4kYEyxRqQFlbxAYMnIQr9NTIDgdptFg+p+kiTKwMkqxqBoFoNhqwaJBS9?=
 =?us-ascii?Q?Z41V3/SKhqs87A2PiXBX02ghBorgei43xyL/hYyxHfgh7L61aZErgeSw1X+f?=
 =?us-ascii?Q?Kbeqm0IpTsfvuhJK5h6dsosMcmV8Xq+3kfkdMcMgBLd+kraCcnU4FJnbkjnT?=
 =?us-ascii?Q?UEWHEjyZQoBGePw5vlJBH9wdnT9/5ntLrRa7IQRRN/i9iFiWUIGls/DoV5kj?=
 =?us-ascii?Q?WFLgQDY5PdndeIgEy+Z6Tpz4KEFjCm8hO8cxkcfey4Ipk96unOQAtYq96+UU?=
 =?us-ascii?Q?lyrMTZv9+AZYwbNxA56LU4fzj2M0afyp8D0f6EKx5AvnBjCUKdd7QALOtZ7D?=
 =?us-ascii?Q?PmF09rJ7/czO/5FTZifluGgbY3D5jtFHLWvlFyZtKPCeYH55ErWYmloDXHB+?=
 =?us-ascii?Q?wI/KKuK9VS2mM1QvhZRetaYIQQJVKB5te10UjgdPHZSUQUG1HUL3nYpgO/oM?=
 =?us-ascii?Q?5GWSoLj0o4BoXKkuPO/4oEVf2raURs33ihDUINAwcc6ThwjZNnrKXPY4tMVg?=
 =?us-ascii?Q?q0AZ9bIPHlVoU9k5j6LAWVBb7zQWdgKDWPjFdd49mfpoS4O1g/3+0w/4Q+aL?=
 =?us-ascii?Q?Al6jFkRYRyOSOMk8IpOddQ7bi2nkZCexa46wHfU/QfJdiCSapbN5WK5LpWHB?=
 =?us-ascii?Q?MtIr6CZt+zD9d2vN8i7/bvd6Nrr5nnhakbro3Vwh3Hj55kcpaQ1+5YKYXSkn?=
 =?us-ascii?Q?wJDKw2jbESlAGy79bOg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7740.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61656a37-e56d-4726-bec5-08dddfd7b7c7
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2025 10:52:55.0576
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: j6lpYB/g1tVicTxfyX2TOJaD/o8fwNlvJzx/teZzdF7ZX12kt2YIJeQ7ySw7Sun/fPXSe+or78jVuN+MYlYoaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7318

Hi Mathieu,

Apologies for the late reply, and thank you for catching the build errors.

I've fixed the build errors and posted the updated v5 patch series.
You can find the series here on Patchwork:
https://patchwork.kernel.org/project/linux-wireless/list/?series=3D988195

Thanks and regards,

Jeff

> Hi,
>=20
> I've been try to compile this patch on 6.12.33 (commit id
> e03ced99c437f4a7992b8fa3d97d598f55453fd0), I've got the following error
> messages. Which version of kernel does this patch applies?
>=20
> Thanks,
> Mathieu

