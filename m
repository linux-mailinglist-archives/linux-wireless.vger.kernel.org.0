Return-Path: <linux-wireless+bounces-35257-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id s9fSCE/Q6mknEQAAu9opvQ
	(envelope-from <linux-wireless+bounces-35257-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Apr 2026 04:07:11 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 25DB2458F2D
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Apr 2026 04:07:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4F6793011585
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Apr 2026 02:07:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 683B423E342;
	Fri, 24 Apr 2026 02:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="pkDf7tbv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azolkn19011034.outbound.protection.outlook.com [52.103.12.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C75782AEF5;
	Fri, 24 Apr 2026 02:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.12.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776996427; cv=fail; b=bQpBqC0HH6jzQBo/QRRjGFXPLlDERhckQAgJ0WuGnx1kZnNBF1OsRrWG1KE0/OO4lXsx+rAX2774DdjT1PrkrmnzNTR55fmzzG/W+IyPtUVPaLb+SqAfPhMLEkrpKNiTNTetlgjJ9UFw9NB7aS+bafc0tIfNDtPN+cJtBNkdSdo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776996427; c=relaxed/simple;
	bh=LaMSSsJL7SrkYdNqjuzJBnnPf3AFVwCY8Vp9Umv1tfk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XDuZVI14jIFQyUttrehRQjyLxug+UGhk/5XKzfpVq2wHNHM2VgF7brMvJPTNS3hYTiWSSV60bhwtF//IR35EHptm3NB9tVWLeXsrKzqzRqMbNL11aaYnel7pn/1XAWxd5vO3kSKyg7x7fp+QBCo4xCkqfW28rn2Dx4zzGtpn+OQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=pkDf7tbv; arc=fail smtp.client-ip=52.103.12.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hs3lZtXU1s3pL5BRv7wryfNOEFAk0eeroz/NrgM6ifydN0jDRhJv8B1gF0uHO64vJ3aGgp9zPEDglWHQJ5TMOurrnNXW4irTMr5o2QD8SVHQbNd1JlTgzJOggBx20lJ7Qdq84wa+wTaTCj4A8QTOg+y7oVVMyqqMvAuHI0kSlX13TbCY3jDhWiYjkm8E1uaJ3MOsavDVL+dExFZq8zrhmWRV8YTbm5J2GNG9kBOg3b2qOC+fsNyExDt4Rn8ESXpHOA1WMd0zBLFuiBmzR2mnHyUt0WBkyvN5yUn+lhpUuVMXQLalJzUqo24jACh48u8EOmGaaDXWCR/z0Rwf6Ey+WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j/oAe5WAJR0Hau8bnlbPZKUUWTns+NjCrP+ar8tn4pY=;
 b=daePu4DqvPVeIg5XCTeV9cCPbev0FzXn4BtY5JDyJa/Wxgux8qHRl5E2OvVuyLf0VQwYHdroI2kLDv4CXFm8p0GSQcayDX+xc0Abbx/FGF92kpOwqQTanOB+aW/Hs1MsZ8AUDHqPWAyyBI9VwWa0nRWesMUaxRc3tU4+NCincyCbZbCt8g1h5HEqCtj8BAIVMOsMpdvi78SHZqYSF1oz23htrZLkqX8TPfKxRbSJCEDvAuZijiFwONjQu3rQIztDo6AV2bEf4bWfLveidIUGV04ens6n31mYl/PhUQtTlbItJzvXJwHorqiZTgdDGIYVHLg83ak4zpnVHgbj8hDveQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j/oAe5WAJR0Hau8bnlbPZKUUWTns+NjCrP+ar8tn4pY=;
 b=pkDf7tbvgbmp48LibP1mvYb1eA1Tyh7j+ywHYwYRAZ2Fei6NR/pVHtOodJpz2bV/ub3tTLxqODzsFfv/fhM5UO0smDU8xHAEB7xYbkP6wEYuLlN5Dq0rbYT2MC6tJi3yCw8ODOw0v502qMRylmEB6ggoN8W5S7t4RynyzzfzBzc7SL1w1lBCESpbZYZImkp4fGVGUm9hZtmEax0GGi5brdSahfqW7zRKx0j3qkuxdxaZjAe7RTJE5KWbsPAFYA20BIGuD1MnX1PiZysLXZMBADToQ6MgCtCVFI8pEcqa2KDp9AZWHI5mnXls44qeKWCFUU/oN0kNryvaxKQ7fVHOBg==
Received: from IA2P223MB1199.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:4ab::20)
 by BN0P223MB0215.NAMP223.PROD.OUTLOOK.COM (2603:10b6:408:15e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.22; Fri, 24 Apr
 2026 02:07:03 +0000
Received: from IA2P223MB1199.NAMP223.PROD.OUTLOOK.COM
 ([fe80::af53:cbf1:1f4:2519]) by IA2P223MB1199.NAMP223.PROD.OUTLOOK.COM
 ([fe80::af53:cbf1:1f4:2519%5]) with mapi id 15.20.9846.021; Fri, 24 Apr 2026
 02:07:03 +0000
From: Kyle Farnung <kfarnung@outlook.com>
To: =?iso-8859-1?Q?Santiago_Ruano_Rinc=F3n?= <santiagorr@riseup.net>, Jeff
 Johnson <jjohnson@kernel.org>, "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>, "ath11k@lists.infradead.org"
	<ath11k@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: Mark Pearson <mpearson-lenovo@squebb.ca>, "koike@igalia.com"
	<koike@igalia.com>, Kyle Farnung <kfarnung@gmail.com>
Subject: Re: [PATCH] wifi: ath11k: Add two missing Lenovo IDs to the quirk
 table
Thread-Topic: [PATCH] wifi: ath11k: Add two missing Lenovo IDs to the quirk
 table
Thread-Index: AQHc02ZBYMNwSv09nEeYknyNqqNCq7Xtc5tg
Date: Fri, 24 Apr 2026 02:07:03 +0000
Message-ID:
 <IA2P223MB1199153665E2AFF709BD2F52D02B2@IA2P223MB1199.NAMP223.PROD.OUTLOOK.COM>
References: <20260423211458.458911-1-santiagorr@riseup.net>
In-Reply-To: <20260423211458.458911-1-santiagorr@riseup.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA2P223MB1199:EE_|BN0P223MB0215:EE_
x-ms-office365-filtering-correlation-id: 576be4bf-cb23-4d69-4b0c-08dea1a62d98
x-microsoft-antispam:
 BCL:0;ARA:14566002|8060799015|31061999003|41001999006|8062599012|39105399006|24021099003|21061999006|19110799012|461199028|37011999003|15080799012|15030799006|1602099012|40105399003|4302099013|3412199025|440099028|10035399007|102099032;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?o7y4/3sWVywzjsWWaCX+3kKfXBK5zAlUCmUXLNwk4x79cKTeyl1y90mCJU?=
 =?iso-8859-1?Q?DmHJOXFoqXcVlolhjpiirWKX2bH/iphEmo7UYatdag+z3Se7wZ2ybZgszA?=
 =?iso-8859-1?Q?CL+PHEkdjUkWt1XNLM6vi+VL+nzLLX2Lo5QiWChxKriY/ZgMn7fNTd/zDC?=
 =?iso-8859-1?Q?IUD9B3F45LyfFIWVtx/A1c+hrPxqoqBBGKWQGE3uifEdU1B4JVcNryFYcs?=
 =?iso-8859-1?Q?2ZPUSU6jvyBwnZaa+Dw7OgpXWCEchPmdjNSyroK7/jWtjS/Y7JRwFzK/4e?=
 =?iso-8859-1?Q?a2qXXDDMX/3mzEdNFgd7bq634QvCChEAx7Uvxfc6FcUXhdHZEEim7Q10Az?=
 =?iso-8859-1?Q?U2biPnoMOHzkRNK4N2vpIIyXRUE997xVO8OvEMiGk+OYVaCRJ3+nOGD0FC?=
 =?iso-8859-1?Q?vLhNrSlUYEeYf6czu4GYz2NOcdH8sGtvk9EfPs4IzGAHIRA5a7FaGa9OvR?=
 =?iso-8859-1?Q?oa5D0bzF1yZQOPC+dkbW2NklBfbssIH+fgIuSA8I1LTO2LKwtY+iRPParD?=
 =?iso-8859-1?Q?bzV+KBuHFrcVbRvkwO6lzXoPyrzXOo9o2VkxhtfOiGaBeKpRbxhyWwNPAg?=
 =?iso-8859-1?Q?gVudRFsDlk3wvZCaxoMT53Ee3pm1hmtwZpKdOMWQ4jceLaDDbMmcJ+Zfd8?=
 =?iso-8859-1?Q?fkFSu49bvijihePZMBHELy9+j7Lgln3+oOFv+RgoO1pC4O9dtJ+Q8jKEye?=
 =?iso-8859-1?Q?tfQ30dtXJu8oo9d/usxTzP3Fp6AnmMjQ4SM4h8+Vge7Fs2krptyzdr0jm3?=
 =?iso-8859-1?Q?chVZiv/U0tayvi70cNLggnMXbyoYcitp0FObGf6yiziIYkwTid6qd6nHpM?=
 =?iso-8859-1?Q?q80lJv+k9uaLr/Wdlcq9TCjFrEYr+dWi29k1d23CaGzqD0CFrpT7qzCfrK?=
 =?iso-8859-1?Q?KKIY3bYCG7ObM2NVeMAF8WtqCMNnLElih1EiBDS1xGcBPoGX2QoQeX7yak?=
 =?iso-8859-1?Q?u652q/JiPTP3IljqJK4vn1ZF0CkFN63w7sowKBwk03sz5OXC1ZP2RyRLsc?=
 =?iso-8859-1?Q?Pr6clPF6lpwf5FSELHAnR6yj5jTb5UB5BmoiyxPi3Xv2Dt1l0/7r13V69M?=
 =?iso-8859-1?Q?T1MOiGXSfMhgDpKmgB2PWlaHQEZVD0toEkfYzVntzRPKe38qEhgFOg9vxr?=
 =?iso-8859-1?Q?EW2k/ioDmSv8dorXyGDl7xZKevqAY=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?+fo7oKYeNrI6Td57xZlujoR6xEGEVv5V9u6M7k/ZIR8ptLdEcF/DRSwPsY?=
 =?iso-8859-1?Q?nYXHVC0ndyaxtgU8xka+pNb7QdTh53mpiKj/K2ZWFJzqIGVgqTYRAH+mlI?=
 =?iso-8859-1?Q?ausmw0f5zU1MrJ7Pf6tLpeRsEQT7gmirKVjR/lKu6VvIhWhYxQqG1PHClB?=
 =?iso-8859-1?Q?QaYZAKADUcXK2LZ/WAUyiEbK9foUadsqfwvzOaeDLa7dCX7S7kqc8plqLC?=
 =?iso-8859-1?Q?Z2HNWDCdagrbbIp+ka6WxSKX8nDenO5hz5bVOZdCm7+OweAwX+kBqbPyDZ?=
 =?iso-8859-1?Q?oERtOZW+unTVnGD1nXqfpe7SM6wIfN3cuXYJZgVvzbvyT8ppetY+496Q37?=
 =?iso-8859-1?Q?/xA8Ne6SN9JKZIhtgMehJps47Yq0N6Ie+F1BVtwZyG8Gz5i1VYgwKJfpK1?=
 =?iso-8859-1?Q?shmPakhq/qCptRZK4xNWxjTjmnZZ85UVQ+pgWr9spfLz1nlceuwaeuj2S7?=
 =?iso-8859-1?Q?/OKkLNIHoz6No3hYwKC5uvJXEjkgcOjlcOB2T0jHRFK4YOD97p2bSkXf2x?=
 =?iso-8859-1?Q?ADcshVWGKI4NkfQ70hRmQgEpxL1aqCYwEGc+wS8hy2/t4vveDyLpB+S3uX?=
 =?iso-8859-1?Q?zM+XikFZN1ko0MUzSQLFOATRAr/ytdnWjb7HXqrwgrHTTL2OblrkdywnEA?=
 =?iso-8859-1?Q?riWCfl5LPcW/gupa6wcovT5UxO0ULgt27vYbsQ4+ATXYGt6icB3zhN7wta?=
 =?iso-8859-1?Q?agLZtUpG7RXNeZhWoQ0nUsVDhMWS+e3xOMXFb9yRt6pvsg3NVn1mvTm+JB?=
 =?iso-8859-1?Q?tmLY+C8/R8Up3MZtqLZH+zWk4mrs3zApIeOQmP8VfHbTPiVSBADKlC51zZ?=
 =?iso-8859-1?Q?2DoHPP6sqYL0HgqPnbX8oYyOdQbKvGytpIzZTFmvWiZIUu5YhRe/85CVgM?=
 =?iso-8859-1?Q?eSq97vbkuhFkVRbzzdJdftJbyAgey8S69sQlm9QIaeOwBq49e1ZY3qfPv4?=
 =?iso-8859-1?Q?X10vdsnEZ4QKd4q+BYwMUUyxC5gnPDh/lYrKqS0gUNf88c6ZHIUeSa+kdm?=
 =?iso-8859-1?Q?gto9jkuncfkGaYwyxcpGayg2bSpF7v6HqDKRB+zBQebo0V9j6WwU1pMkeX?=
 =?iso-8859-1?Q?d6T5h/qHHtwjGAjqsxA9WWuTuYlKRefTwQL1zyKf+CRgLQOpvlk36k8utu?=
 =?iso-8859-1?Q?fWUBvuILx+mPV3tx8QuA0MdymykXjovYWEhgpWHOVrxZyI/7so384OhdQf?=
 =?iso-8859-1?Q?Fc0/Ei3rY/JwP6/ATq4CiessW6jJpOFx/VuNyvMgUiJpZtjqJeQCyX9fKL?=
 =?iso-8859-1?Q?VZMamotRovwCRX4legGfA4zXDlzmNo4fjMY2YEqLwYJ5it8vFp8Tu/lrzn?=
 =?iso-8859-1?Q?X5fFw9m+VCWtf6wqTsoYN2JCsQgUJxZItgLT+tDbZTZ7/0w5qHvaYI5Qb+?=
 =?iso-8859-1?Q?TsIXViLDTwX8fmelCxiOyL1Obpx1JfsGfDKgTnfOfWBDn2T0EIs7oI4oK5?=
 =?iso-8859-1?Q?kapGnfOFrS3zfbiIPFlsh1xR/RneZV9U+Z4F1g16YthVyIOL7mNEyGgQkI?=
 =?iso-8859-1?Q?o=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: IA2P223MB1199.NAMP223.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 576be4bf-cb23-4d69-4b0c-08dea1a62d98
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2026 02:07:03.4712
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0P223MB0215
X-Rspamd-Queue-Id: 25DB2458F2D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[squebb.ca,igalia.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-35257-lists,linux-wireless=lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[outlook.com];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[outlook.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kfarnung@outlook.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,outlook.com:dkim,outlook.com:email,infradead.org:email,lenovo.com:url,IA2P223MB1199.NAMP223.PROD.OUTLOOK.COM:mid]

> =0A=
> =0A=
> =0A=
> ________________________________________=0A=
> From: Santiago Ruano Rinc=F3n <santiagorr@riseup.net>=0A=
> Sent: Thursday, April 23, 2026 2:14 PM=0A=
> To: Jeff Johnson; linux-wireless@vger.kernel.org; ath11k@lists.infradead.=
org; linux-kernel@vger.kernel.org=0A=
> Cc: Mark Pearson; kfarnung@outlook.com; koike@igalia.com=0A=
> Subject: [PATCH] wifi: ath11k: Add two missing Lenovo IDs to the quirk ta=
ble=0A=
> =0A=
> Commit 0eb002c93c3b4 ("wifi: ath11k: Add missing platform IDs for quirk=
=0A=
> table") added some Lenovo platform IDs to the quirk table to address a=0A=
> wakeup from suspend issue [1].  However, at least two more platform ID=0A=
> are missing in that table: P14s Gen 5 AMD, as reported by Kyle Farnung [2=
]=0A=
> and P14s Gen 3 AMD.  This commit adds one ID for each.=0A=
> =0A=
> [1] https://bugzilla.kernel.org/show_bug.cgi?id=3D219196=0A=
> [2] https://bugzilla.kernel.org/show_bug.cgi?id=3D219196#c23=0A=
> =0A=
> Tested-on: P14s G3 AMD.=0A=
=0A=
Lenovo products have a pair of IDs, you'll want 21J6 [3] and 21MF [4] as=0A=
well. I submitted a patch myself [5], but I've been investigating another=
=0A=
symptom.=0A=
=0A=
I have the same "wake on power removed" issue, but I have another issue=0A=
that's more annoying where the wifi just dies randomly. I only have the=0A=
wake issue when power is disconnected, not when power is connected again.=
=0A=
I mostly leave my device connected, so I only realized the behavior while=
=0A=
doing the regression testing requested in the other patch.=0A=
=0A=
[3] https://pcsupport.lenovo.com/jm/en/products/laptops-and-netbooks/thinkp=
ad-p-series-laptops/thinkpad-p14s-gen-3-type-21j5-21j6/21j5=0A=
[4] https://pcsupport.lenovo.com/us/en/products/laptops-and-netbooks/thinkp=
ad-p-series-laptops/thinkpad-p14s-gen-5-type-21me-21mf/21me/21me000pge=0A=
[5] https://lore.kernel.org/all/ba4d194b-6d31-4d8a-a6a6-da116f9f56ac@oss.qu=
alcomm.com/=0A=
=0A=
> =0A=
> Fixes: ce8669a27016 ("wifi: ath11k: determine PM policy based on machine =
model")=0A=
> Signed-off-by: Santiago Ruano Rinc=F3n <santiagorr@riseup.net>=0A=
> ---=0A=
>  drivers/net/wireless/ath/ath11k/core.c | 14 ++++++++++++++=0A=
>  1 file changed, 14 insertions(+)=0A=
> =0A=
> diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireles=
s/ath/ath11k/core.c=0A=
> index 3f6f4db5b7ee..56938d5d42a1 100644=0A=
> --- a/drivers/net/wireless/ath/ath11k/core.c=0A=
> +++ b/drivers/net/wireless/ath/ath11k/core.c=0A=
> @@ -957,6 +957,13 @@ static const struct dmi_system_id ath11k_pm_quirk_ta=
ble[] =3D {=0A=
>                         DMI_MATCH(DMI_PRODUCT_NAME, "21K4"),=0A=
>                 },=0A=
>         },=0A=
> +       {=0A=
> +               .driver_data =3D (void *)ATH11K_PM_WOW,=0A=
> +               .matches =3D { /* P14s G3 AMD */=0A=
> +                       DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),=0A=
> +                       DMI_MATCH(DMI_PRODUCT_NAME, "21J5"),=0A=
> +               },=0A=
> +       },=0A=
>         {=0A=
>                 .driver_data =3D (void *)ATH11K_PM_WOW,=0A=
>                 .matches =3D { /* P14s G4 AMD #1 */=0A=
> @@ -971,6 +978,13 @@ static const struct dmi_system_id ath11k_pm_quirk_ta=
ble[] =3D {=0A=
>                         DMI_MATCH(DMI_PRODUCT_NAME, "21K6"),=0A=
>                 },=0A=
>         },=0A=
> +       {=0A=
> +               .driver_data =3D (void *)ATH11K_PM_WOW,=0A=
> +               .matches =3D { /* P14s Gen 5 AMD */=0A=
> +                       DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),=0A=
> +                       DMI_MATCH(DMI_PRODUCT_NAME, "21ME"),=0A=
> +               },=0A=
> +       },=0A=
>         {=0A=
>                 .driver_data =3D (void *)ATH11K_PM_WOW,=0A=
>                 .matches =3D { /* T16 G2 AMD #1 */=0A=
> --=0A=
> 2.53.0=0A=
> =0A=

