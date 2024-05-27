Return-Path: <linux-wireless+bounces-8113-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 507128D0572
	for <lists+linux-wireless@lfdr.de>; Mon, 27 May 2024 17:10:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2F161F25A40
	for <lists+linux-wireless@lfdr.de>; Mon, 27 May 2024 15:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42361167DAC;
	Mon, 27 May 2024 14:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="MxaxndTP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10olkn2026.outbound.protection.outlook.com [40.92.41.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66717167DBA
	for <linux-wireless@vger.kernel.org>; Mon, 27 May 2024 14:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.41.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716821361; cv=fail; b=n69CwbS1HvD2Ztlnr1xkCjw5C/ZLvS2Ka9CDNxonwaAv7e8h2yHxwtK9tBdm/WM5ZdgFysX1u54rhcbcfjC79f9L/v9PBmFwCbeje10vy8inU9Us6ggc7u19+nPD9d9lWPSkaHICbKToar5RFKWq+2/YyfQsih+X8MnmT3lf7SA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716821361; c=relaxed/simple;
	bh=Af1PSik4ZkFb21ahPsbou9b1pdBree43D/793SDLHRE=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=l4gKtQ8dn7Tz5VLsoTnlWSJ0EVjCRyT2NxTtax4m8shq+/qeROb4mFNmg0mjn11TgmVd4btJaHsgomTEbRHT8TbxAIP1Z/WVeR6kZzuNQrjGor/zTW6Bm2RCfvz5Hmlp3l/xCQN61vxmxQFj3YseClhcrUa7yVpPyZ46ZODySKA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=MxaxndTP; arc=fail smtp.client-ip=40.92.41.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q1/KcLmAi2KssHH6XyrRD6E6aU0IUXS9qBM3yM0WUh3arXO3Oc/KklW7J5t8yvozB7Z8surnE63Dqg07LH8WpQXvqndYAQB6LMb3qYVa0hz0vv+rbjaobcsYXwiXE8H0djU8oj3x7khZjDwHAsx/9fJU8hgOExDUvGFKaqYwtY5eSnVEuHr4XtYM6RWqO2i/xipppK5UA7Az5ZxKqS0XBmeOwXHCUb6FTJmrX6S2k6L5MQHMf9M6wPVrnyshOb14SILfLWHF7eAZuWETo0e2V/DjIdfWgO0XIlwXaeUjyg7oHahVOhbrZfpjDpl2hoLbg3cHPVENArbhuMrjdOFnNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c16twVbHTyzOXB9QxMrq9gg4eYu2tALWs19GzlPb0kw=;
 b=XYb+Dz29EWAgDpMsMV57YPYSClxtvc1pWDb4h4A7kcfb3iQmcZNER6QrJRtWmVh6INZK22uYWemB8ZB33IqSjb03yfCS2B1gtIjDzwQCTrHMLRjpz2JRqYLMtKj9ccZXGTlDjzYqzVaN2B7IChFwSemvOaeSlS5MK3lQtAIROpHzeSb5AgWw7Z7vieU+ep1xzJThGlaFTcvKClNil8bX/6hv9UT/y4wrN4PshuCvchRKenvqNJ+Zw6tXav9zk0P5PRfSKsVgfYWtBIEYCa25cLBvxbCTcFMdvPt5m7vEVvYzmJjMyxp3tZ2vfJPM15iIaev4iH5PBXMWJIXMUcOS4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c16twVbHTyzOXB9QxMrq9gg4eYu2tALWs19GzlPb0kw=;
 b=MxaxndTPLzVpK6a+X+46rQUms/CDJFsbo7t9Oh3p2VCeaLLu26vhzJpfvEH650MCVWZIfFb4XRn0YiEwn3XvhXiAv3MUZZyYEiH1iMY5u8CxoOVSxvmTqMsLenb2pVn9a/WWTYjl4lDEgLhZCvvM0K/FWHCcvIF950OTKpTF+rRbRll0raBSjKbkshvdSqSs8xTbTWSFj+wZjcHCVRKNwNt8jChCRX9Qa/aCLwx7lh3oLE99+df0k1LdUfzL0qraR9IrJt4v9TdQLbxjK6+jo/L6xoDgh5IkZI4PH3kLnfQ8CZzTHmYMnYGp0XcxqCmGyyZKVn41AqrsTZZGNPDqag==
Received: from BN8PR16MB3009.namprd16.prod.outlook.com (2603:10b6:408:5c::25)
 by LV8PR16MB6571.namprd16.prod.outlook.com (2603:10b6:408:267::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Mon, 27 May
 2024 14:49:17 +0000
Received: from BN8PR16MB3009.namprd16.prod.outlook.com
 ([fe80::9952:18aa:c42a:7dcb]) by BN8PR16MB3009.namprd16.prod.outlook.com
 ([fe80::9952:18aa:c42a:7dcb%3]) with mapi id 15.20.7611.025; Mon, 27 May 2024
 14:49:17 +0000
From: zhefeng xu <zhefeng_xu@hotmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: "Larry.Finger@lwfinger.net" <Larry.Finger@lwfinger.net>
Subject: Issues with rtw_8822cu
Thread-Topic: Issues with rtw_8822cu
Thread-Index: AQHasESb/JUTLXi7wkGXIoti8etmAg==
Date: Mon, 27 May 2024 14:49:17 +0000
Message-ID:
 <BN8PR16MB3009C9AE50574D4EE7EDFB59E0F02@BN8PR16MB3009.namprd16.prod.outlook.com>
Accept-Language: en-CA, zh-CN, en-US, zh-TW
Content-Language: en-CA
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn: [Q06yOfXUbSauNUGUPIfjYvvshwCw909n99Y4CzJhy0c=]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN8PR16MB3009:EE_|LV8PR16MB6571:EE_
x-ms-office365-filtering-correlation-id: 6925c5a1-4599-48dc-6e28-08dc7e5c2f34
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199019|1602099003|3412199016|440099019|102099023;
x-microsoft-antispam-message-info:
 5LqILUAOwVJzA6hParmMjImOTdF8J5/VLfKv/tniZcR9ggDLnHGZxSHv07CMNQOOkETNZRzW61OK86jndrY08cYhzIRpiMvJOzHlTB+dm1KTS72gBCZb9L1I+N/YSaRMxorN1j9WezLJZnK6BIaRKu2t+fnWyKAYaQzEZPfLNJ6KKuMn+rr+KB/t3ZLXFoUNYzDNwVy2Zp+kFy8qg4eie2qtP/3AQLbSCqUpxEjgb+0Bsv8ZE2kLyVkKGGXI4EvrH7wVZhScfqYaB+m/PPQG7RAJ/2eX8vKxctamtqi1CiIczoITGXdjTGIBhN/b0KWmEMiLH4BeuBXVi9WW6bg7t5NV7zauNaU8q0SxREjD3x16PW9KE1wOMS4cEGNLZCRyVxT7uzazC842ewp87jXfEmtQQ0b75wYeY5CJujz3+xHmetswSR+VzZmjK+whMO0MjnsnIBZUYBBenHftN1KD8sAI9suytL4F1EiLUvysc9dcSPEdk5W26u3MN7xzV/GglOGe05yuWWGB0lMRx2IvxtkGXeKAcjPreqjKfWsJeFoqFaAVTke3Gp3T8FBWSD9D47fj5kuIEbEzsMZGdtjAI1Ezh63B7ylIV1JVgX5wCO+0CXw+AzKd3xzjbkICZZHPW1SY6I2WsCdycgnFQf7ni4m34yRfA9mcxjLPD5kFd6s=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?8N8NCEAjRYa4XIQq2RAPBjeJVxUVQVn8ik1xxCI92AVR32J+dc/k0CovCV?=
 =?iso-8859-1?Q?s489lcXLpC7W7BilEGTR3NMVTlSe8DNeIj7w38+WR5bKbn2op0T3PtPPI8?=
 =?iso-8859-1?Q?tpRvIT6TCXfx7sEGxGNafXNVKJp0dsY+LxM/1xtvFfw44bpns/2Rg5jGcs?=
 =?iso-8859-1?Q?3xG8uHEucVeY2whYnw5b1F/tIPdCY0LArwBvFGtkFbPqJIVvuWedRPRnvS?=
 =?iso-8859-1?Q?Ho1oi1CtAwK1NfUm5KyJKDkTnQSdH4Wg04b8S80I8hw/Pefichzs8bW6kN?=
 =?iso-8859-1?Q?C55Lq8CHM75nP6PrWhWBXQ+6YwxnACo/yFpcbOjNJt8G0rUuMToMUtBrKm?=
 =?iso-8859-1?Q?/ILNredfwLcoRk6AKLIRMi7HJo3+woxspmzbn1GZQplOekidDU4Nt0bWEa?=
 =?iso-8859-1?Q?sCt31pmZOzRuabNE6kx11BxAw2DiTotKtl8Ek8qII5/Lmp4Y9nd9wGh19w?=
 =?iso-8859-1?Q?ogZRJ/IrMR8cJxube0xa+YAB7EUXf+4mkrZdqyWbMfeQyw5Nee1aQI9itZ?=
 =?iso-8859-1?Q?v27vhD09+KEJNJAvuqk3HUdasawELHOWwk00wu7zADTiBcesqPSbrrQw++?=
 =?iso-8859-1?Q?ScrWlS9vvLRchb9bzNjjtyW/xxOkvru38TGhMsrcPsY2+1ZBpXEdnrg7Jj?=
 =?iso-8859-1?Q?XmMO/tVM3TYFaDV6+xR6lS9p7xwJcRj9uVz7xpm9fSN+jijvNkCeMj6B83?=
 =?iso-8859-1?Q?v3ZUj2PNfpN4sk6TjMf3GHn83Qy5NWfP6gpZjwFt542YpFo3bXsZdZzaC8?=
 =?iso-8859-1?Q?wHtBGNhJcEWtUYAZp9Cva0Q8Qav4AogyZxrZpJ8FF4pDBAOryVvTc0R2fE?=
 =?iso-8859-1?Q?ZXe0yiV2ZGnJQoTLiKyGWpMCMmdRPFZX3vWqDhtrDOjY19mXJYQg69MxlS?=
 =?iso-8859-1?Q?tahUbykvkgOAeNqg09FD9+zCafuaBI2UxJs2qr9upqdlJHnV4sV2lvyH8L?=
 =?iso-8859-1?Q?+ThqBIR2zMoMck2HCn8n0Kdlsh3dL/fsxncD4DL7sbsa3ts0tpOskjGFky?=
 =?iso-8859-1?Q?5jERLqBTiz8Zdb2vuPb1Ngf84xUUv4hS1VxvjhLE5xmxXlb6Nn8o5bc5TB?=
 =?iso-8859-1?Q?ID7FFsi1TXvuxX0GshCFF2mO8SMR5z6cknabnxhfl9la8xKWEcqHmbhu8M?=
 =?iso-8859-1?Q?h3UBAIPzb73GiHCYLNbTBhZFiLUTN5wBHm8gQzhHxdYkxgykd7aSvDvBqK?=
 =?iso-8859-1?Q?QDgb0MivhZHE/0J6ALc49kF0VcjgRs5RtygnMu4M7Mdu16/nhVlNgJ3nV0?=
 =?iso-8859-1?Q?WW8RmDTSpDYWv/TH4jcyGMQzLTbWCzePepCWu8i5M=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-5ce7b.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN8PR16MB3009.namprd16.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 6925c5a1-4599-48dc-6e28-08dc7e5c2f34
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2024 14:49:17.3807
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR16MB6571

Hi,=0A=
=0A=
Recently I started working on a test of STA+AP setup on rtw_8822cu card on =
a linux system.=0A=
=0A=
The environment I know so far:=0A=
=0A=
linux version: 5.15.71=0A=
=0A=
driver: https://github.com/lwfinger/rtw88, update to commit 31187d3=0A=
=0A=
=0A=
The rtw_8822cu (with cpu model imx8mq) connects to my home router first (co=
uld be 2.4MHZ or 5G).=0A=
=0A=
After that, I start a script to set up an AP hotspot on the same rtw_8822cu=
. script: https://github.com/garywill/linux-router=0A=
=0A=
Then STA+AP can be set up successfully. Keep it running for a few hours bef=
ore I notice logs printed out:=0A=
=0A=
[May27 13:38] rtw_8822cu 3-1:1.2: failed to poll iqk status bit=0A=
=0A=
[  +0.263848] rtw_8822cu 3-1:1.2: error beacon valid=0A=
=0A=
[  +0.005345] rtw_8822cu 3-1:1.2: failed to download drv rsvd page=0A=
=0A=
[  +0.006703] IPv6: ADDRCONF(NETDEV_CHANGE): x0wlan0: link becomes ready=0A=
=0A=
[  +3.941709] rtw_8822cu 3-1:1.2: error beacon valid=0A=
=0A=
[  +0.005257] rtw_8822cu 3-1:1.2: Download probe request to firmware failed=
=0A=
=0A=
[  +0.007050] rtw_8822cu 3-1:1.2: Update probe request failed=0A=
=0A=
[  +0.159816] rtw_8822cu 3-1:1.2: error beacon valid=0A=
=0A=
[  +0.005230] rtw_8822cu 3-1:1.2: failed to download drv rsvd page=0A=
=0A=
[  +0.006030] rtw_8822cu 3-1:1.2: HW scan download beacon failed=0A=
=0A=
[  +0.140620] rtw_8822cu 3-1:1.2: error beacon valid=0A=
=0A=
[  +0.006253] rtw_8822cu 3-1:1.2: failed to download drv rsvd page=0A=
=0A=
[  +0.006221] rtw_8822cu 3-1:1.2: HW scan download beacon failed=0A=
=0A=
[  +0.028311] rtw_8822cu 3-1:1.2: HW scan failed with status: -16=0A=
=0A=
[May27 13:39] rtw_8822cu 3-1:1.2: error beacon valid=0A=
=0A=
[  +0.005346] rtw_8822cu 3-1:1.2: Download probe request to firmware failed=
=0A=
=0A=
[  +0.006826] rtw_8822cu 3-1:1.2: Update probe request failed=0A=
=0A=
[  +0.025609] rtw_8822cu 3-1:1.2: HW scan failed with status: -16=0A=
=0A=
=0A=
After it, I'm not able to find the AP ssid from scan, but the old connectio=
n to the AP still would be alive. (the linux-router script still running)=
=0A=
=0A=
Restarting the linux-router script wouldn't help, no AP ssid seen from scan=
 any more. Interestingly STA still works, ping still can reach remote hosts=
.=0A=
=0A=
I suspect 1 of the cellphones' disconnect from AP could trigger the issue (=
cellphone is in low power), and so far haven't found any way to recover fro=
m it unless reloading the driver.=0A=
=0A=
Please help give me some insights on the issue.=0A=
=0A=
Thanks,=0A=
=0A=
Zhefeng=

