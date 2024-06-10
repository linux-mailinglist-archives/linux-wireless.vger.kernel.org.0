Return-Path: <linux-wireless+bounces-8752-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B3A5902339
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Jun 2024 15:58:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70D911C2244F
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Jun 2024 13:58:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 327318286D;
	Mon, 10 Jun 2024 13:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=softing.com header.i=@softing.com header.b="QqKF5PmI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from DEU01-BE0-obe.outbound.protection.outlook.com (mail-be0deu01on2097.outbound.protection.outlook.com [40.107.127.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F39D8287C
	for <linux-wireless@vger.kernel.org>; Mon, 10 Jun 2024 13:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.127.97
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718027461; cv=fail; b=al8S+3ohUdl38CmJWaPm4raqkmt5rf6rx1JZ/1RLrGmygDEzG4+av4VQ9L2PFumHbrqdCLF9j9BBiQayUzbOlFHKxRmhsyiP7Gn5BodLDg0JekL332IW14HHBUgIHJEVh8MYnyXy7BA9HJzie9nQ5N+kxy066zNRe7YhdVOT+5U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718027461; c=relaxed/simple;
	bh=QMef+sa117iySPfY3j1sU3nX3D5NQKdSzpArC60x1M8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gwoc0jGgZT+e0wkNIpq9oXxstfD+uPnCnFc066Canp6as0V3sUMG5+f5uzs+0Ubfyxxg3mora9bU5dxTS88O3tNpdXGOf7umFT+yVz6BcTOH9PCsFECIwUxC46nexUvezgrgW9o5CVfHwk92aVCO1Uq5D1fjB3S1gIaUkqzFaRk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Softing.com; spf=pass smtp.mailfrom=Softing.com; dkim=pass (2048-bit key) header.d=softing.com header.i=@softing.com header.b=QqKF5PmI; arc=fail smtp.client-ip=40.107.127.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Softing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=Softing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iXH0YujcKUssuczBnw+hdYgQeB0epj0WeH0uHgDCAkXAnTzoeLFiMT7Vi6rl0LkpW2ZSIujlcbp35c749hgtpemGqRkODQlltHgeRQGk036ZG69aFX2xqrnPlN8bzADC2IP3LRO4Cfr3bIIiXeDxxVtwxn+j6WzyeTJ49aNnwfb2TJ9Fz8DjRvRhoZi4mUvIqJag7H83jpbq1YImynWuQPeDBO3NEuG4bdlD8PuaNoRoNdCy1sLdwmOyKMCA6b/p6M5F8mSYyP31GoEWrJYZRlyOWqYVwU5w7VXgyhd0j7j0XC1cjVV6gOXsSM+rKo9kkCeEq23a51B7Gi+O5BDqFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QMef+sa117iySPfY3j1sU3nX3D5NQKdSzpArC60x1M8=;
 b=lYOCJvN3WsBbhxivrB1hwcUdytg2nOfBiCdu7kNBGX2E8dXiiZvQ7ssYeE0uzsfI9D6PQPB7zy96RoG2AdrnCosjdKvHAjxDskGyyYB2+Wi+qcx0e8eVfpJ76LvGeP2YceTlF+XYIO4DAYXG19zfm6GQJJQ/XWbGzZxVceofTBzAvoMOW7NXkf+SRNug8R1jIpFH0RFMclDbjTapzIYoJO75qtHs31nHkxFnMr/QHzYqAHf4WKrjn3PJ60/2acCpRIsJpbwIcmXjCAFBf52DUdWOK1MylOZmwg7mBJi9GTZtnkZnF7f64UgcCxGYB2St2cLrbH3luMpCXpCbJ86i+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=softing.com; dmarc=pass action=none header.from=softing.com;
 dkim=pass header.d=softing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=softing.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QMef+sa117iySPfY3j1sU3nX3D5NQKdSzpArC60x1M8=;
 b=QqKF5PmITv3FznJxNotew8kdOSjhwPjPePQMjUvOxmBxPx6oZOmN7Jjxi16LR112vj3OBw12y658dWE7NX9DVsFKojgonuZQylG2IFWRqkySccvSgc5pEVTe9sKLS3hnmVoZ+MxG/nRXRv2JXlukuUBR7xzjwLUUTQ4gZ5X8FhI3IrkyKuJqEpKZ8BDyhhLh57u4YhRgjXWAOn7L8riKYWn9G+O7/rk2kCrPsvZEup/5UDWgkLEhQ3PzP9Z5suKl0tffrizFfgEZ1ieKGwTxiL7vLlo3Yl3cM14GO/ReDOLSO0itlAJbOonDgxdMR5+4yy81G75IQweh9FPWYYPIQg==
Received: from BE1P281MB2420.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:43::7) by
 FR2P281MB1979.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:2d::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.16; Mon, 10 Jun 2024 13:50:53 +0000
Received: from BE1P281MB2420.DEUP281.PROD.OUTLOOK.COM
 ([fe80::8de2:b2ba:4092:939a]) by BE1P281MB2420.DEUP281.PROD.OUTLOOK.COM
 ([fe80::8de2:b2ba:4092:939a%4]) with mapi id 15.20.7677.014; Mon, 10 Jun 2024
 13:50:53 +0000
From: "Sperling, Tobias" <Tobias.Sperling@Softing.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: "Le Suire, Michael" <Michael.Suire@Softing.com>, "pkshih@realtek.com"
	<pkshih@realtek.com>, "johannes@sipsolutions.net" <johannes@sipsolutions.net>
Subject: wifi: mac80211: unencrypted message in 4-way handshake
Thread-Topic: wifi: mac80211: unencrypted message in 4-way handshake
Thread-Index: Adq7OqrIXwNmhc6ZT92PlJydhITGNgAAMsqA
Date: Mon, 10 Jun 2024 13:50:53 +0000
Message-ID:
 <BE1P281MB2420DA2C6AFF94E525306302EFC62@BE1P281MB2420.DEUP281.PROD.OUTLOOK.COM>
References:
 <BE1P281MB24208AB02DAEACAE9AF4B5C5EFC62@BE1P281MB2420.DEUP281.PROD.OUTLOOK.COM>
In-Reply-To:
 <BE1P281MB24208AB02DAEACAE9AF4B5C5EFC62@BE1P281MB2420.DEUP281.PROD.OUTLOOK.COM>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=Softing.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BE1P281MB2420:EE_|FR2P281MB1979:EE_
x-ms-office365-filtering-correlation-id: 1af9a39e-c503-4e7b-10be-08dc895458a6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?DMsdu3Zwpnd9Zp3YRrZTgtZt4X//5WQBEpxNYWchcK3KzyMSD6+ZIJPHpMEO?=
 =?us-ascii?Q?qz13w6p1TBvrLvZs10HmuPvvlYhkCJqq11danG+wfcaO5XNEV9lg8+IG0VKn?=
 =?us-ascii?Q?sgV9VpgmhOZPRTCxiN7Mp/CUecXIVkZE/H6vLTWeiuBL1ECbo95o6vF7FDv6?=
 =?us-ascii?Q?0lS6pQuo3ZriwkrGrOu8L0JGlltmJ/pBPYi6A0BYNhuZXn2UXdILrGNMfr0O?=
 =?us-ascii?Q?rFX52prupiLUVbLTmU39qO32KB37EpUjbW7+egpnMShWs86JbQKLMJmyMdJq?=
 =?us-ascii?Q?2hW4hm0nhwKfKLDDgBlNWCRKLVxJktQfn5Cx4+Md0pIqUVzMAmgZB+M8EoLa?=
 =?us-ascii?Q?GU0/9aVkVsv/RYRB3VzvRUEcmcLD2E3bOen+Pum6nMrzhv608TF3jMoTwIMM?=
 =?us-ascii?Q?g1bltzDvoeMnjQf5EK2nw9TSAUQe1YgY6kS3BW/QP6kUe+DXNkaFCzqPenxu?=
 =?us-ascii?Q?qam7CBesRNybCq9CHSrYugnb57nDpQhtrI2H4CJGX8EE5tUHv95+9bJUgGdv?=
 =?us-ascii?Q?3o6pfa9PmpNhiZ+AG2Yw1rZsioFRSJyonFotJNk2sd2eJevEqCxAzCBKvm/o?=
 =?us-ascii?Q?gQ+fuxBiPlp831v5R60sZMZZEj+lEq4kTU+j8G7T5jOZaJE5YUu/nYDZwGWH?=
 =?us-ascii?Q?q8oHUbOasZSxCJfAO9P5NBxAqK+V21RpvgcbYzsSA+cs+xkPzQHOPRqIA80X?=
 =?us-ascii?Q?l+TuMRJpI52spaFSdrsuz6eBYrBBSGn6Tir8/VSuQpueLRuOIVsT6Gf06Yni?=
 =?us-ascii?Q?pQeDAEWgHnvxomDZy1hnOL5DQGTMrPDdpaJOOLCcHiEuCmHKiWLmoGxdvH0v?=
 =?us-ascii?Q?PyDidqirh0MePKpp2get9tNbAuV/W+PDklDWNvBETLD0hx7otetavkBSE6dj?=
 =?us-ascii?Q?q2PANX+8BvPGyTqp0N5T+n20IbT9l98neKXoCm6HcIcXKE+FjrAfbGNrzpri?=
 =?us-ascii?Q?MqAuwL+Xb/fBr+fZyMdkdBCpHxTKcKPQ+mJwi0l87pHUTAb3SF6h5x3qRvL7?=
 =?us-ascii?Q?GeMsbdzZEsoZJUojd8TQDWaOga2gsCerv/wOxAQ62hpiDltL5Q7MeOXOHbeR?=
 =?us-ascii?Q?Fj0tdGDyuIZ2i1en7xxXXztroLqGx0h7DPiSBaAshQpRu4X6qIkn8P6xSKLL?=
 =?us-ascii?Q?uIV3atzuAWCtaDeQhV3nZt0OYbNpHzkSViD6JAo1xu4NMFYkqFMNmIhWk0Xz?=
 =?us-ascii?Q?2UlvYlgsMGPCIINQRWzmQGI3oTHvxKTERqKw8tprP1xmgsCwYt/KcYqdrW4f?=
 =?us-ascii?Q?ly94QjWyoFN6IcSJ3yiLpjcbGEZwtKbkRJtmsMdS+0yVjjnNog2IMStX+13M?=
 =?us-ascii?Q?ESgUUcSIK5WHxSzjsBAYqMQOxVHsnVjA1F0fbDiLfZkSDu896oq/dMv+qXgg?=
 =?us-ascii?Q?JS92f0o=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BE1P281MB2420.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?r0qeyWeL0ab87Uw7b3r281AuvkOl5yM6NaIgvXJ6MQtTc3QLFqvoX096aGbo?=
 =?us-ascii?Q?zBUP9SrjizqzwskF2XTtSr2RMJPBg8E4YBw7GKuiVtVfAykcvCZtLUfx4Y/V?=
 =?us-ascii?Q?8S9MW/EpKZlc73U2goMg8p1j9LQmhUDkYhbjNo/Q2PGVtd4ac7ii6ocMqzD+?=
 =?us-ascii?Q?YgdqAef8o4it4rNyOOz/zudA0kq+kUjXag5qXvTH8/Mq0iex/UQpLk8Suzlx?=
 =?us-ascii?Q?xtUc+JfK4tcPSMkWS2OxQJZN19ZzZjbevWYhcBRDGVG8Z0ehZ4kgcM2PapHa?=
 =?us-ascii?Q?jtViRW+LM9+BIBdWGKswOPu67s79Xb65pa2G5cZNcUQU5vqQuQ5M3PJd8lwT?=
 =?us-ascii?Q?HZuG9oex9LYHrZg3MPZG18YAzJYNSEaMolT6aoHLncfauCzTSG1AYTLPgP5T?=
 =?us-ascii?Q?0bxDOPip2nl5Zy4gpvuO9n+Tb82rtcUkN9cflFTtFh4YsSGsaPFqrTK1bVcQ?=
 =?us-ascii?Q?0pI13ba8vnPWBaVvhS+gwIcVc0Lulg4sOGp1wt9Qg+RiXs27+CcjLflZeu/t?=
 =?us-ascii?Q?SOmeyjo4bqcK0Acw7gv4xRDtOkCbhfS7Mr5f0pn+qS1EtaUlsRtKM5j8q4LU?=
 =?us-ascii?Q?bpFZJSZcIxRzkTPEttA57rOrVHj+XjOHz2u9TB03AV6XMfoVdbfaBZbUQJL3?=
 =?us-ascii?Q?sp2/8W8DS4ighP+puewTSJML+VWTrs3kcfrA5VCCSTTdltBRR/n00lj5pa8d?=
 =?us-ascii?Q?rJ1bh/tzGUUWXZGGsa25WT21Rp6CHpSdTMLEbWZLwNLqYuD03b7JXBponjip?=
 =?us-ascii?Q?KTHyjG72Q64w4Wdar9OI+xxsgYZI/pyVZNGKV0A9ledazNlCGWlAZA9F3nzZ?=
 =?us-ascii?Q?4r58wQvjBxU3k1hb+AeQ8J0apJ/nh0t3NBS9XrEZK+LJ7PQoN3isttNP11on?=
 =?us-ascii?Q?IH+IStCtNDTFjjp2iVUTOzk0HvqQ98ytf1JaE5CkZ7vIDUfZYEji8BvGffdO?=
 =?us-ascii?Q?E8GVvf9b/bFexbl+KKC3D4DlWhrV8BIVMm0OlN+fcF1UZu0h4FbTjctYw5r/?=
 =?us-ascii?Q?+mLgTTYTDJf94CHRaghLIogP5cQhow9b+BAu4LNzY9Ta8g5ep9U6RAvtKsWE?=
 =?us-ascii?Q?nE2T71UEyY9TjKbdwDa3Y2qZdIuU5PeqTYRv7EwFvA0ST5r4j12JpObH1cgN?=
 =?us-ascii?Q?acoG/Kjrmi1d0V0Ix9pCd0S26BKXUcRRrHRbDhRK5kqwI6oZ+mhXfjAN4Byf?=
 =?us-ascii?Q?7clcznres9ByCjXXNy7mVOtbqrLUwYx80tnTDPdNezFy0wa/M0zi9poVWnMa?=
 =?us-ascii?Q?ZsmFOu8S1elUwoDFydcJdaErBwNp0htImDEDCojGHPgXnCWNt9ChuSPAZ1B1?=
 =?us-ascii?Q?rzQSSkIFGXa/j6pTghmNdImbIZykJ0VlGYi7s6cgJC390ZegCGCtj8t+UGYT?=
 =?us-ascii?Q?fdWfx7zhzUmuJBQObJmPEyAD4sjaBA9VfNgMa46gwMW2hZFt0RXwPfeM1hzQ?=
 =?us-ascii?Q?2T/EBKDrj+3t8GCJTQoZhYk/p8lH5BK6QDUnZI9px+UN/28KsW4Ql7LNl3Lv?=
 =?us-ascii?Q?KLFpzU98brQpMq55R1JVeDJm9dD6lKJLBIfs9IXJxUickKMemUih8VBTETof?=
 =?us-ascii?Q?0LRLpJx+kRTwa46b5skXnaUdj9lRwO9DBDjky5CtSRn+011t0v4fxiY+eWvh?=
 =?us-ascii?Q?R5QOEXhagQhBqI20+ST++3YC6nT6AS5Y9zG/pbBl/99JBR1V9y4DsNNxG2YD?=
 =?us-ascii?Q?uqUzbw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: softing.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BE1P281MB2420.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 1af9a39e-c503-4e7b-10be-08dc895458a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jun 2024 13:50:53.6929
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fe3606fa-d397-4238-9997-68dcd7851f64
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cpSVAVAvoWq0lkqa4t5A7KswnoFRnAW/mcbvIDWydaEQwaayB1EQ+fFkiZflynroY+kgfdjdDvQ1KFRx+1MAF72K0gssrovx8XlFP5QGbiw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR2P281MB1979

Hello,

recently we moved from a 4.9 kernel to 5.4 kernel and observed the followin=
g issue. To rule out that the issue was already fixed we then tried it with=
 a 6.6 kernel and observed the same issue there, too. To sum it up, the fol=
lowing issue can be observed with kernel 5.4 and 6.6 but not with 4.9.

We are using a Cisco AP with EWC (C9210) and EAP-PEAP as authentication met=
hod. Additionally, a session timeout is configured in the AP (300 s) after =
which a rekeying is taking place. So every 5 minutes a new four-way handsha=
ke is taking place which usually is completely encrypted. However, while sn=
iffing with an external device we saw that the fourth packet of the four-wa=
y handshake is send unencrypted by our clients, when it comes to EAP-PEAP. =
The first three packets are encrypted as expected. In case of the Cisco AP =
the attempt is then rejected with a 4WAY_HANDSHAKE_TIMEOUT leading to a com=
pletely new authentication.

On our clients we are using wpa_supplicant 2.10 with the same config on all=
 kernels and therefore would rule out an issue in the supplicant, as it is =
working with the same supplicant in kernel 4.9.
As driver we are using ath9k for QCA2066 (starting at kernel 4.9) and rtw88=
 for RTL8822CE (backported, starting at kernel 5.4). The issue exists for b=
oth drivers for kernel 5.4 and 6.6. Furthermore, we were also able to test =
a proprietary driver for the RTL8822CE chipset on kernel 5.4 where the issu=
e does not appear. However, latter driver is a full-mac driver not using th=
e mac80211 driver in comparison to the soft-mac drivers of the mainline. Co=
nsidering all the details we highly assume that the issue is to be found in=
 the mac80211 driver.

Do you have some hints where to look at to solve the issue? Otherwise pleas=
e let us know if we can provide some logs or config files.

Thanks in advance

Tobias Sperling

