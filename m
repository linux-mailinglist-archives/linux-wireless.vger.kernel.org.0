Return-Path: <linux-wireless+bounces-8781-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 504A490348C
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Jun 2024 10:00:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 945E4B2C6F8
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Jun 2024 07:56:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 684FB173320;
	Tue, 11 Jun 2024 07:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=softing.com header.i=@softing.com header.b="QrvZxhNA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from DEU01-FR2-obe.outbound.protection.outlook.com (mail-fr2deu01on2134.outbound.protection.outlook.com [40.107.135.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC33A173322
	for <linux-wireless@vger.kernel.org>; Tue, 11 Jun 2024 07:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.135.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718092532; cv=fail; b=ugBWijueAizXcm+Od1hHIAq6R+91kR3aJMMOSeEI0m1qHwFztBzB/dA1t9MZQ82S/jUe1bdFdFe6n2v4lUZ9enlUMaslNBaPSBYbQY4Eh97XS3Wz2QbZilBwCZmLHHImcFwAOkOu7z97pdRc8BXPcO7xNmDrrGKCPKUplhL1FIA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718092532; c=relaxed/simple;
	bh=jll04c5g14r8o/RMwtPD8Je7JDoi/FOQt58d7DXo8Ms=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qx1kGSrSGtv+mh7EWmE+lD9T4x7dWimSYouZ2PoSGwdvw2OKyn0oQg70LURuZl/paPnEbdS95CJhxjpEukwJYSoCPF4Dx5wx89Pit28+tzhYvAlu2bKJqTEhCi21/Wzhmo69WfzgNfHFYsmOoU86PwGIMeb/jrLstOpzdp4Me2Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Softing.com; spf=pass smtp.mailfrom=Softing.com; dkim=pass (2048-bit key) header.d=softing.com header.i=@softing.com header.b=QrvZxhNA; arc=fail smtp.client-ip=40.107.135.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Softing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=Softing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RfahdZ77Qap5eAh7xJ9Fn112ostU/3PvZyRD3jQceTg0d/p3MVa5rQwjX00CzxbnoxndSVPnsMZvhEXP9DGPBkLB56v0Lz5Fnp7jJZ+YKQ0MwWIAYQ/xBnF53xoQ+F23AcMlbOQEFLR0BS48yY+k8kCF1jjgeJQv033GVY/kEeVlOsiSsmyAlC1uo0MeJP00uk1j9rkW/i3eNa3VoikvrqxiB/3j6VRiq28zTT5drB+sE8bT82oWo5JXb6YEf1slP1DhQzABZY6EcXwG39WUZV+CzHRWou1Ct0js3nA34Jd9oi5Q/lCjwcIfM7BChW9VqKme7lUkkVP3hNo/Dew7tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jll04c5g14r8o/RMwtPD8Je7JDoi/FOQt58d7DXo8Ms=;
 b=KTljpEBP17d0cI0EwpWPCYDqzXATZTTnW9E7NdNBFXRCCf8UxnoxBB8glLPg7r9au9IOhjQxSlVOIh0CKgTbETiODP8OpsqFNHXaX2ibW5sRIkGQCnJ/fKwA/1iGb5r7AQOLUcEmWuoD/IwN+vbpg3hnM5sVJaHoYC71r67lRO86FfC1/rrM8eAFjreKU1tyHtrz1NDOwiO7YonsijVSMb4ZDpuzTevIGMcqvrpwcInSuVDf35nBY8t1DqOWggfkK0434dY+y7VEKgoSFxorYrSmsIx26s7Sj5LhEKGYBCEuoFgNab0h7QuEHpA+Cfeu8l8g53LAeT9IiPQvkYEtZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=softing.com; dmarc=pass action=none header.from=softing.com;
 dkim=pass header.d=softing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=softing.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jll04c5g14r8o/RMwtPD8Je7JDoi/FOQt58d7DXo8Ms=;
 b=QrvZxhNAwzidRcUHvqui6IVpjiQUN25g/1nY0xZ4AGPUGgW/igpdvoOIjYnYCAZm3RpneHYTyI0fTlV1hcoHlF1vTAKPilPl2kmep0+bgm/zWlOhK1R8OgcsXfHfC+GPN2M4AvFJN5s6ZqNLzQlNen8WMTuPThLnup6xrl9FLcFg+Z4YlPWZjx1b7F9deS25sHsqGnNpWpXOITziu7pSK+EvX9X2Itf+0BkfYOvjUK2uKz6q26P597A7ZTjrq1Nqcq4V1M859hlZaCq/3lrHqiyE9npq/BQtqOvYEvB2Ad+zeXDXOmU4KzmbA3wFuUofXQEham/3eG4Be1neoYBjPQ==
Received: from BE1P281MB2420.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:43::7) by
 FR4P281MB4302.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:127::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.17; Tue, 11 Jun 2024 07:55:25 +0000
Received: from BE1P281MB2420.DEUP281.PROD.OUTLOOK.COM
 ([fe80::8de2:b2ba:4092:939a]) by BE1P281MB2420.DEUP281.PROD.OUTLOOK.COM
 ([fe80::8de2:b2ba:4092:939a%4]) with mapi id 15.20.7677.018; Tue, 11 Jun 2024
 07:55:25 +0000
From: "Sperling, Tobias" <Tobias.Sperling@Softing.com>
To: Kalle Valo <kvalo@kernel.org>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, "Le
 Suire, Michael" <Michael.Suire@Softing.com>, "pkshih@realtek.com"
	<pkshih@realtek.com>, "johannes@sipsolutions.net" <johannes@sipsolutions.net>
Subject: Re: wifi: mac80211: unencrypted message in 4-way handshake
Thread-Topic: wifi: mac80211: unencrypted message in 4-way handshake
Thread-Index: Adq7OqrIXwNmhc6ZT92PlJydhITGNgAAMsqAAAhs0lUAHeOR4A==
Date: Tue, 11 Jun 2024 07:55:25 +0000
Message-ID:
 <BE1P281MB2420928438977DCED644AFBAEFC72@BE1P281MB2420.DEUP281.PROD.OUTLOOK.COM>
References:
 <BE1P281MB24208AB02DAEACAE9AF4B5C5EFC62@BE1P281MB2420.DEUP281.PROD.OUTLOOK.COM>
	<BE1P281MB2420DA2C6AFF94E525306302EFC62@BE1P281MB2420.DEUP281.PROD.OUTLOOK.COM>
 <87le3clmsz.fsf@kernel.org>
In-Reply-To: <87le3clmsz.fsf@kernel.org>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=Softing.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BE1P281MB2420:EE_|FR4P281MB4302:EE_
x-ms-office365-filtering-correlation-id: 2d451329-8c5a-4e3c-b177-08dc89ebda9a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|376005|1800799015|38070700009;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?LY6PhqnPobqemhPktBHToh1MeuzMl4WWZqXlwFzehvt91qtZ2Cm2LNvbcTXx?=
 =?us-ascii?Q?2yx6mLW55eLWdDPaIis9HsL4GGQ881wy0/xZxqJhwpCkod6q2ENZpeioa3qB?=
 =?us-ascii?Q?MUPwQW0An/gMW0ay5G6STU6oIt0H/P0UmePvqYPGqCQWYUDcLSJYCcktPdQh?=
 =?us-ascii?Q?DLQeE9I8s4bM1dcy/U5T1tNgOACKD/5zqa8ygGoTuvh4kpw1gCmkFlRjIk6H?=
 =?us-ascii?Q?/nTeVCBxSmJirdc8RRX0YEElHdExZo+6xFdSMrqTn8cd27ObS8cDYQyhZJ5W?=
 =?us-ascii?Q?ziRvuhH5okqSm/kZ59/zYJVc37s+TX8ml0MOrmNypCe2sR5f6a/etTOBmkJg?=
 =?us-ascii?Q?W2gVMKtoRw8WdopXdumktFp7zT/U9wn/YSnG0YY12M2HpBz34fDK9ZrelrmJ?=
 =?us-ascii?Q?YucK33RPoYdQcRktaWCQ4jr8XPCgw97n9QjXqzthSjT4WwVuvosGAkkK41v2?=
 =?us-ascii?Q?s6W7L0dCD66Luuh1k+eGWk4pcMiotHaFEoLIs2JoB4dz2Pck0Wkedn7NPUDo?=
 =?us-ascii?Q?Hs79JXTt1LXOTwmBCCmNG0YbyDgApfg1mt0IVp+URoj/sPhImg8MVuJ8nWVA?=
 =?us-ascii?Q?/vtfcmOldn5lINta/OdkpP818e58sYK+Ze9TqCbKzJjwQqJRrdn0b1BhlFnd?=
 =?us-ascii?Q?jKXW3JKgKbNrPCGZMS4Z9yhhH+x87bplYLbMHOIw9xmFiDwAkiZhA00fceik?=
 =?us-ascii?Q?J7CteZ8bcSAvajnsceMoyVCMTx/JxzqujyPgU6rnoXh/UEv5/jIi5mqSbFs3?=
 =?us-ascii?Q?Jp3RIQ+zNmziTfpAJb780lmnVzuPBirYNRWiDJ6pq1rGJ2paGPahuLEtAjj8?=
 =?us-ascii?Q?HpEy5ZNeeBDGfdygQ/bZZF+jmFlahKkwShNwt9I5X+AucMw6kodneqCs19e2?=
 =?us-ascii?Q?NJnm6yHvF+sNOS7iAtxCmaPhdijWe2i+kpQiS50amZXM+EpW6u9/6Lbbx/6h?=
 =?us-ascii?Q?XpslB9tRXRK+MMlfEiH7nl8TKdk9aNguDkrECDmkKUtbIzvpsZcjw3CqpHtv?=
 =?us-ascii?Q?QjbcS62Xdr5z3vSDlrI4ypqoNoxcafgB8fOUpTqNeo9xXpqhmuBZ0DRcWVxH?=
 =?us-ascii?Q?Wea4VdGu9DFd1FXsk4uyoTXlD6RUirjMQEpADZt5jwn3mYqZTLAkf9wOATi4?=
 =?us-ascii?Q?Bt1BkM2NkFRyZfvAyOlBSBGOybDk9hu4nIHC7EsqjaPWdUH8baNzHEHLv1Mo?=
 =?us-ascii?Q?SxhpKBouT/JW9SKpUG0yAujPpdZI3+y/2uHexFWFw2s0wU31RTwDMTij+HGd?=
 =?us-ascii?Q?lNSOVMxGdTCqAqaxdIocKY3mdRFmUUPW0fFDJjOus98iMZqNTHkYSw6shK/k?=
 =?us-ascii?Q?80mPO/Y52Fr8Icenf91Amgw0JfuoGfACaaxp+Sf/dxRik+rFwvzmJspzaV2a?=
 =?us-ascii?Q?ZvhC65w=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BE1P281MB2420.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?0SsO2R1KRS2bXccLWg0I6EOsp0qfQ3RAjjbZz7cQ5sy1rBCiuEkaCsY3avW1?=
 =?us-ascii?Q?jhDLrL7B5xYtJHdA77HBEKGTYYYT6mnpKBme5UNc56ckCo1F3TfmCLo6SlXQ?=
 =?us-ascii?Q?Fr0E7pjisu+WfaSDMdWKwKcAZBJG/5gySrWa8Kp0B6remVUfykiPMvwDb6Mx?=
 =?us-ascii?Q?5l2cRWw69O3mDdDGn4BWN5saDSp/G89P6H2Seuh10nIf6UZ2arn3j8f07OHz?=
 =?us-ascii?Q?iPFv7WmTR4+L1aH1/Mwmyjz+P3Pbr6tC6BLWpVdgsfdufPH2t/Qn7tQXCmK0?=
 =?us-ascii?Q?g56PW32pACV9VJ9Q87kmLzTwkZDHwPrVrkCREAAH6Q6UOmKQj9y9o47aaUCb?=
 =?us-ascii?Q?AGXh2yABTyxNRAYpahnW6RN+qKwghS38TsrLHyPfQodFneTF5jyKlRCu9F/h?=
 =?us-ascii?Q?yD3g+8kUGrBWTvNfdxstz5PoOycZE9o1NXZICzvV/WDnsqlL6aWYozWoSjTz?=
 =?us-ascii?Q?GZLe1kmyERrCO188D+XkSg+d0C9cg9U8YDxQt6WZFWzGRW7Lwe82rphQVpaB?=
 =?us-ascii?Q?ERvBby5QVX6GRecfQQtvAtjxjWD5JvLNG7pz6PhxnHztoRth8RfrHz05PBTC?=
 =?us-ascii?Q?Q2SVFqj8GdMB3A+OuiNOYhTBZPmPzSvX0YKHArGg2/4xHYN+2bRq+B6KRlx+?=
 =?us-ascii?Q?mKjjBCFP+WGOGlEJtzlrFWojEie5n7+UxWZ6CKg23BfEiZxZyCO/tvB6YbvM?=
 =?us-ascii?Q?82+JFf5xHFlodGZ8ektTA22Tks0vNB2cJjb1J+Q0lgdx+Law3G5jjns/TUsS?=
 =?us-ascii?Q?R03MX77I4F11QtnJojJe9Iv45gTrjIfOXz3tAheKSCNMBuCIAGnCRp1VBq2M?=
 =?us-ascii?Q?fhDvoFl0a91xGha4b7ZbVCA59K/8seyEDweyBYcTdqO8jJjdKHkO2+07E6O5?=
 =?us-ascii?Q?c+5+rOnIl7SkC3TZb2+IglO/1CQwlsVKsaitzN89TAzNC3Dkd8fk2aAGPPHb?=
 =?us-ascii?Q?1/qaLd4nZQ45DXtqD+yQ2fmov4dLk7hkAonj/a+x69HosCwfktRyDr3eeBVY?=
 =?us-ascii?Q?w+YjedjzhGkLa+LlWX9MhPuKSclG/Ax48MbJTq9lyD8j8nOzDRluJ5dh82aU?=
 =?us-ascii?Q?xxotHVBzqDUBh5gBE09caYh1O+WAYGjizFBP1tOBPIzevctcuJO4L2mEhBqO?=
 =?us-ascii?Q?j2GCOAKvGtHTyqt8SvWxxPEfmWO9MXXgzVgaPiq99IgR/uReHs0q/katYl+M?=
 =?us-ascii?Q?x9AAglgzKSU1bYawi7c3ZuEbfaLp8gJ1KgzqBi8xPZX8uBvPO8cO873TS1Vp?=
 =?us-ascii?Q?WStTUSH8ETFfmZjQKgUNq4hlQoinXKaHviNfs1/NTrSiaADkk9YN7Yvjda23?=
 =?us-ascii?Q?jTu7821pPGX2gEyRULdwDLbgYg4EPlN6ivsNQkQwBhAgaTObIWfjVRN0cqf7?=
 =?us-ascii?Q?xwd8zKGKIwt9wl1XsnzQRrhf3lzWlpUdTI0mVaFv3EPI83DmZptDfeePJtOb?=
 =?us-ascii?Q?l8DTVXnTaaxglTy9KLQuSzUk165g3ldxpzASF41vO0WmDZSXH1iRpTlLtDMt?=
 =?us-ascii?Q?R3m/+BLHjRVMSx4fg14PfGAjLjiv+e95JWRcAkmTA4kW2lzwujR6WWUUd8Mj?=
 =?us-ascii?Q?eJJsEKQcxN/5f0/7ks2UzGiareZspiFZaJb51y+9z6RSHVih4zi4EFOrGLmY?=
 =?us-ascii?Q?GQ=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d451329-8c5a-4e3c-b177-08dc89ebda9a
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2024 07:55:25.7153
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fe3606fa-d397-4238-9997-68dcd7851f64
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qEB/Ljs03V5DWCMUCgsLjd1hISOF1kz8rnlMOmpOA/WQ5Q7V+9bh8fYCvAFlCTu6t7Xe7s2Z8ZnT/UjotjzlD/SQG6M7H74xAzz6esiyY/8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR4P281MB4302

> > Hello,
> >
> > recently we moved from a 4.9 kernel to 5.4 kernel and observed the
> > following issue. To rule out that the issue was already fixed we then
> > tried it with a 6.6 kernel and observed the same issue there, too. To
> > sum it up, the following issue can be observed with kernel 5.4 and 6.6
> > but not with 4.9.
> >
> > We are using a Cisco AP with EWC (C9210) and EAP-PEAP as
> > authentication method. Additionally, a session timeout is configured
> > in the AP (300 s) after which a rekeying is taking place. So every 5
> > minutes a new four-way handshake is taking place which usually is
> > completely encrypted. However, while sniffing with an external device
> > we saw that the fourth packet of the four-way handshake is send
> > unencrypted by our clients, when it comes to EAP-PEAP. The first three
> > packets are encrypted as expected. In case of the Cisco AP the attempt
> > is then rejected with a 4WAY_HANDSHAKE_TIMEOUT leading to a
> completely
> > new authentication.
> >
> > On our clients we are using wpa_supplicant 2.10 with the same config
> > on all kernels and therefore would rule out an issue in the
> > supplicant, as it is working with the same supplicant in kernel 4.9.
> > As driver we are using ath9k for QCA2066 (starting at kernel 4.9) and
>=20
> QCA2066 with ath9k? ath9k is a driver for 802.11n hardware and QCA2066
> is 802.11ax generation, how would that work?

Right, somehow I collected the wrong info for the ath9k driven device. Sorr=
y
about that. It's an AR958x adapter for the ath9k driver.

