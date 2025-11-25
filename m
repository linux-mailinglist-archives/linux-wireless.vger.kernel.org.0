Return-Path: <linux-wireless+bounces-29319-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85A67C83999
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Nov 2025 08:00:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32F9E3AAA8E
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Nov 2025 07:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7C1F18DB35;
	Tue, 25 Nov 2025 07:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="H9UGQ4ak"
X-Original-To: linux-wireless@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazolkn19010016.outbound.protection.outlook.com [52.103.13.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEB02218AB9;
	Tue, 25 Nov 2025 07:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.13.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764054049; cv=fail; b=MxDmnViDGyhGcwA9t5eXfinoV+uUCJRTPIQDVvxbCWAPN0m8iuuJUembN9pw8fpiO2cGjfpwuOLaZHBRWZUI36jF0KZMpWKZnge2BxfrAfCAcvjA4AikcOdbhscwkjCI7XRJnlw10MhwaPo0E0WdDbSdyfnxhwXX2cR5yAOxzF0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764054049; c=relaxed/simple;
	bh=eJa51FBmAzAgWjbK53O6nlbSmnvAs80f2bXHNkztOzY=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=NlhzLXseY3vmgaoeFUuWUxuA0sov4kW4SqQ+UNNOV/SoDgoyL4sDR7YYlpN3MPYl6eDRdnO9y9I3uLSDt8Zo8YCuZttNgqczoAFp4YYYi6jnS3nM+b7kGGVyzJpieADXpcFrmB3Q32Bh2k2QDBBa9kx79ktB6sEayn5azUYxcjY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=H9UGQ4ak; arc=fail smtp.client-ip=52.103.13.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AeRsHkHzM6JHXCLpdP/HWr0q5Qa/hEGMbZ7IQ3PKEJ5q/h1vkcPjLVfrKnvxd4PuayGX4XTeB0j9NPI2Idzg6NRYuD3ol9gVntxeNT3tiUgYCHt0KeBxd2GkfN3V5n8V2HNLeMV+DT3jUXWS/nZ4CWkfaTbtqRgzFld86aaMb/hCT9eQMHLBNiHdiOIorHP4nigRKqzHEU1+j1yPJniQCWTXEkfhac6603a11VMuDF0dbi+l4laJbe0KpycTAMVP3G8k114kWbCie0TzSyoRUFw9jaB/YaVTH8ACmGHC4YUi8ceha+/ZWRjhIxoy9hcnjiFp/bpKUD76+kzahavwKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eJa51FBmAzAgWjbK53O6nlbSmnvAs80f2bXHNkztOzY=;
 b=IHAV3iMCAaiJU0gp2k0rxHoRrskf/BaVQtcN93r63LgdagHcCz85STv91pmqtMlpIrDPsAFRRjqGXmr4FRswuOCqtFgjsjEkiFkSfxxVrW127XSW2ASLSzXUFTm4PFcNJO4CV+mA3VGVisNArNMSt0sMwjVWxTbBB+6sP5opsT8NO18TVhasQzDqjRkVAZXFloH57YJhSdInpILs/LpMVoyddOxn16/R6eDBQbQLRU1XV28129l284M0LRHtlmtkkRW50fQWlGGUSS38+jfFQVBV2+Oy1u7QPrdRTb9OK72KPfn6LHmoq9e5andUQIYHwvp4aSaLl95ApCAn8ubYgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eJa51FBmAzAgWjbK53O6nlbSmnvAs80f2bXHNkztOzY=;
 b=H9UGQ4aklutIX9EyrmbQ09Cqjb+zjsVxzvcTSd8iaDJdPV4Sbsz+JQepJTc3wGWKfZmeAGRuuXkB3HhUt8fP0a/iVJIzzYv+KWejE56C2WsEUglfFsVr2qSs7uRK9tRf+xbOTtWka/ehLyrNw/DYZ3a5Duq4sySXMk7Z/QMzsmoJxQ53kQp3KSWbCS7hBkjdoQZpbYUSeHlLxgXt62sj+l8gYJh6LJn8nnZ5OK4oiiUbNeKOeCj5BCUslCuct7GzosGisBSp5iEpagc+GWHf5nQ0UG3iRdklOI9nqJJyHT0wM/qCQsuWluRBmtj57JeK9UbWKnMkCfDmk5sjVgrq6g==
Received: from SA2PR10MB4460.namprd10.prod.outlook.com (2603:10b6:806:118::23)
 by SA1PR10MB7815.namprd10.prod.outlook.com (2603:10b6:806:3ac::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Tue, 25 Nov
 2025 07:00:45 +0000
Received: from SA2PR10MB4460.namprd10.prod.outlook.com
 ([fe80::59c5:5e37:ba2b:6bd4]) by SA2PR10MB4460.namprd10.prod.outlook.com
 ([fe80::59c5:5e37:ba2b:6bd4%3]) with mapi id 15.20.9343.011; Tue, 25 Nov 2025
 07:00:45 +0000
From: Les Boys <lesboyspp43@outlook.com>
To: "pkshih@realtek.com" <pkshih@realtek.com>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH v1] realtek/rtlwifi: ensure unicast is reinitialized to false
 in each iteration
Thread-Topic: [PATCH v1] realtek/rtlwifi: ensure unicast is reinitialized to
 false in each iteration
Thread-Index: AQHcXdjNdJ4zlsJI6k+HyP/79rWKVw==
Date: Tue, 25 Nov 2025 07:00:45 +0000
Message-ID:
 <SA2PR10MB44609AAC5888DC0334D140E0A6D1A@SA2PR10MB4460.namprd10.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA2PR10MB4460:EE_|SA1PR10MB7815:EE_
x-ms-office365-filtering-correlation-id: 67e79a23-ee47-48e5-57ae-08de2bf05b14
x-ms-exchange-slblob-mailprops:
 znQPCv1HvwX/rjKUHtq9BXoRMpkRDIvwk3HbW3RSi9/zcWjkgBWx2R+BZYBa1IXZ1AYkhbVNtyhhNK5C3rk5EIfzzsGBRjkjx8n/3ZXv8h1zYc4/y1rBk+kCbUvlMpVgstN+LanAuvn3ZJnl6/s8WALVX250iB5+bwByEywG5gX9Sd681Vr5L8fzcYDvbrr3Douu/PwMGACRgENePXCeQfsELypxp8W9dIXPB//Vy38BKTPQ2AsR+z650LXKEQhlw8azn1ot/vlPDnuKQ4cGVLFRHKGYKM80CazK4QN3oJp4uccZjKVfaDmYjgMTBjGv9RJkK1UaOo3RX7fcNhWftmH/g79DeD14QVezbqZiMft7Q2pHZPZPPc67mW5juPTNRSAXsuy5YkXfR2xpYjJuHSH3E81N0iwBVtNeL1S0BmZPeczfDXNjY8aSXzUjGzfbt6CD8/84oGnGx4HjSo5BaWqwYZ3uDIhGwxYoYxIZHypA9ZaQeFjvz41asEQ/Eg5WSzSp1xYD/+5OoIe5L2WWSs+NazXZM2SdROgYTwlAFvQN7+cqwuXdyK0OlaLo55+yEOwH2fETU+VunfmLRMsmqU3ObIlNMHcE5PafVEZiOkfvPQ9G50RRAvcQQOYfOxKtWArx2Pn1DChDpzffsuzCcSkDzFPBLgHB2+vgCKROds46tYZu5SAlWEiOuvuVmaVLhMiaxexwCHXvTfb6+0fJ/Qhkr3qlvr9pL+LJjlKI+beZ5LImp+z7RMlW1V0AFpNCaeW4v7oZ+aA=
x-microsoft-antispam:
 BCL:0;ARA:14566002|8060799015|8062599012|39105399006|19110799012|461199028|7042599007|15030799006|15080799012|31061999003|3430499032|40105399003|3412199025|440099028|102099032|26104999006;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?E+SIU4zoJMNEtxGc1x4dtUwakxZ80aAHHXNwM7zJ6rGWGl4WYl0N9ScRWN?=
 =?iso-8859-1?Q?gv/oysTpxXaTR+mj4XeUCpyvzVljH2DbGvtPZaBTa+Kh12MRf9UWGl0X+0?=
 =?iso-8859-1?Q?4rwX1/JStTU9BZ1frHkAC8DdgqzHoSS6Ku77vy7MPdxdwOUb4Uryh0Gtnw?=
 =?iso-8859-1?Q?m4ozHmKlqeiHRHKvDFa5fwZzEt/UECwOa2ZMKiSYNC7Kn5MT23MO0A+iWN?=
 =?iso-8859-1?Q?D+6xAc2vy0A5tReLjW3ZJtsf7Z9eFEmzISx4RSzduYkkJX2dQpSOK79Ggu?=
 =?iso-8859-1?Q?Bk6KjegWsWHulN09tiP7w+KMDaW2dwOyNbDAoMWc6fRhHmWxkYGFN2LBLZ?=
 =?iso-8859-1?Q?4KaSXKqsX4tdliGsccQps52QpzwjEIBL83eI9yB6+iDexI9mdnkDz5eTa4?=
 =?iso-8859-1?Q?uf//xcN7g5o12fkp0+ReI3Jc/yepOyqX7MaWMfuIbAduyMBtVE57+nckv2?=
 =?iso-8859-1?Q?NTbDHy9ZOTar3ake7VjqcPVPuuGv4En3fWHdbofIkEeifIaAT3T8xvERqK?=
 =?iso-8859-1?Q?dkl1eBsBEizxoQdW4+QO9BB098DkfaCn1FjI1dIoM+HsVjFfyi2s9duhGW?=
 =?iso-8859-1?Q?kP/EW9KiQZbCYNMKmgfBfJcVfhQCQ1AysPZNQ/j+xFre/ztVzufkMWw7hx?=
 =?iso-8859-1?Q?n+RYGR6LWKaAZBGrXbPWJeuH2jVKd9rmng0I4NUB2E4I5bf6ytK72pRto0?=
 =?iso-8859-1?Q?OeB/sRDm6l9biCY6byWWjQ8cvTH+P7bJJD57KnaibqP69N08saqNM4NFSy?=
 =?iso-8859-1?Q?SWTkhParHme2hO7A3kx0C/m2EBce6OmicPeAQ+jIjDAm0DqQStk7OJ66uy?=
 =?iso-8859-1?Q?CQNMEXwfu/qIPRKeK2VFNbctiAoclXnIjGGnSVChqTHiIAZCwVGihCpivU?=
 =?iso-8859-1?Q?nbUs840CC9HoWDBmh/AuA5OubTdWh+CjyZApvE2dipWCwuevVx7PwrQUOI?=
 =?iso-8859-1?Q?fPfyS4utqXsDj/q9m8xso/xDife0k4wzYg7IjpP1k2d6jdL1LnG1XIs8f8?=
 =?iso-8859-1?Q?lNTut7/t+Ee0PXf1m8NROIrfK+QAOLCUo5ZoGRCJmWIeZpptJBFzyPHlyK?=
 =?iso-8859-1?Q?D8vzilnRbEmPV/ISMtSzEEjuLbbpVp2Q1bIyC0i8VzJkNbAJVDGy73dm8Z?=
 =?iso-8859-1?Q?dQqouEoKTIQrdmcpowli4W9hQ/T1+PgAqt/3M8l7I6Ad8qESAPzh0gocHf?=
 =?iso-8859-1?Q?VXj57cEt73Er37yvINfyl9ILnwsPuLOTAMYwDAV41mHvBzfkhjZZxkBfBV?=
 =?iso-8859-1?Q?Q2ENGow5jUf5w1aeYPDlRYVutIirtYxdVRlGp1NsQADcfSEgSrekRKc2cw?=
 =?iso-8859-1?Q?hLxKYa9V6G7oJFaOhefoOWCR8A=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?aAIZv505uEa750RIP3LxGqVpNRfVAPRebYF3Z4J5culsXkLGcDcrBeYfKD?=
 =?iso-8859-1?Q?rzcAY4IphqrfaE3+dPOMOMwGoAY+teeoBJG/bFnyVkXYXRIOrlehO+00mI?=
 =?iso-8859-1?Q?GEEcPBQsgZbN512rtkxaebyUSGhXRW2XWkeFYEWafqIQr6TcfG9hRNUftT?=
 =?iso-8859-1?Q?IIjPKNMBNu1Bu9H7oAMees81bySopLurT7vzJTgpLD3EbjY+13ywkwUzGJ?=
 =?iso-8859-1?Q?mor6joydNznepIX6pghehW9Yqr2rGGxD29X5AhxUumMFdN/NybVQRiYhj1?=
 =?iso-8859-1?Q?HeP6u/fpRaru7u6tpWrQDlEFwIPJpeqR3+e0zrA8i7EkUlL3N2TCPqAFCI?=
 =?iso-8859-1?Q?OrssLD1rCiOGL/cuL/m30Mr5F/ot5LXydfCOlhui9AOXV2vK+6i64980hS?=
 =?iso-8859-1?Q?gUM0u+PJQCiOaQH1//fZfziJ8UyHYbsUsnPYY7Nrk0Qc+tFL2ZWVgjPMgC?=
 =?iso-8859-1?Q?5IlAjHz5Y8z+u+ziRJavAD1hA9I3GADp+c9jSpoVO4l/9VTYuQK5SiunGB?=
 =?iso-8859-1?Q?L7fb1SI9taqxs0Znakcls3eCyMP4fMcFQo4ztY0yu+d/cL0FKJTNznYqui?=
 =?iso-8859-1?Q?EJ00sFiGNV6gIzhVZ0nL3mF1E1dVDGN1WFj95G2epgl9HcnzTVm0sykLCe?=
 =?iso-8859-1?Q?Aukhn6aceZwH1X3hG/BeqdWq/vFWlsBWkiMIsh/kA7OcSWN/jZ+BAe47r2?=
 =?iso-8859-1?Q?XAbxuzSYDBE9hODeYZ++hTRbGcqyetj5tUR2/MIWkTPcTO/4hn2nuDqtyy?=
 =?iso-8859-1?Q?nXVJ4jQQo3+AcpnQj0A+Qt/u7xi8UGmbtyvfh4RxEkt7anRKVnu5Izxw8D?=
 =?iso-8859-1?Q?peW6SQrCcniBl0Sdy1XTPT8bq0Rqfc2qykqQyjM+s3gPkuctR7g6L4Wra7?=
 =?iso-8859-1?Q?cR6J6liAgEDbjEwZntUqNDUDWg8MUSybFtt+Ro/58a9745LsohIfC9ZSge?=
 =?iso-8859-1?Q?j9EFGUbXfZbHItUAUlvGyj7IMYFuQ6sif/3j/FrVpEzGN9+nZGN/AqcUp2?=
 =?iso-8859-1?Q?6fRY+BZn7XZbYgLJyARqg9lxy79loydmg4UwNx8zZgpBL9P1CL7eifxUT/?=
 =?iso-8859-1?Q?aVfQuwv4UvsyhuIsgTrhe+gTvL2U1tFQj8lamV0FiQNFrZE8lDO8I+SNO/?=
 =?iso-8859-1?Q?7D+c/1Zt8wpR+3YvuN9IrOAiZAtc4NKps+wcyO8/5woJY20P8IOgp6QNZJ?=
 =?iso-8859-1?Q?QQIJ25uemYoL/b2YJdNwW/ERJDaC4Etsa9HG3VhQiZfiqq2fGGb23x6Xyb?=
 =?iso-8859-1?Q?Qw3THpdapbf2OLjIieucK8WkjBXlpMCbcU4KKkHpc=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4460.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 67e79a23-ee47-48e5-57ae-08de2bf05b14
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2025 07:00:45.2807
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7815

Previously, the unicast variable was only initialized once during the funct=
ion execution. Therefore, if unicast was set to true in the (n-1)th iterati=
on, it would affect the nth iteration. This patch resolves the issue by rei=
nitializing unicast to false at the start of each iteration.=0A=
=0A=
Signed-off-by: LBLaiSiNanHai <lesboyspp43@outlook.com>=0A=
---=0A=
=A0drivers/net/wireless/realtek/rtlwifi/pci.c | 2 ++=0A=
=A01 file changed, 2 insertions(+)=0A=
=0A=
diff --git a/drivers/net/wireless/realtek/rtlwifi/pci.c b/drivers/net/wirel=
ess/realtek/rtlwifi/pci.c=0A=
index d08046926..fe7140328 100644=0A=
--- a/drivers/net/wireless/realtek/rtlwifi/pci.c=0A=
+++ b/drivers/net/wireless/realtek/rtlwifi/pci.c=0A=
@@ -752,6 +752,8 @@ static void _rtl_pci_rx_interrupt(struct ieee80211_hw *=
hw)=0A=
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 memcpy(IEEE80211_SKB_RXCB(s=
kb), &rx_status,=0A=
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0sizeof(rx_st=
atus));=0A=
=0A=
+ =A0 =A0 =A0unicast =3D false;=0A=
+=0A=
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (is_broadcast_ether_addr=
(hdr->addr1)) {=0A=
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ;/*TODO*/=
=0A=
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else if (is_multicast_eth=
er_addr(hdr->addr1)) {=0A=
--=0A=
2.44.0=

