Return-Path: <linux-wireless+bounces-35837-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sIMlEHiT+GmwwgIAu9opvQ
	(envelope-from <linux-wireless+bounces-35837-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 04 May 2026 14:39:20 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C9E7B4BCFD5
	for <lists+linux-wireless@lfdr.de>; Mon, 04 May 2026 14:39:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1BADD301A1FA
	for <lists+linux-wireless@lfdr.de>; Mon,  4 May 2026 12:38:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E8493D349B;
	Mon,  4 May 2026 12:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ntu.edu.sg header.i=@ntu.edu.sg header.b="rplSfWFQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11012041.outbound.protection.outlook.com [40.107.75.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D22F3D0917;
	Mon,  4 May 2026 12:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777898326; cv=fail; b=fDxAV+OAmVK+hveezvLNsMKsSDnBffd4c2dIYUcbmyjSwt+FjeyL0Uar8glxjsPKd8M+i7rupfO5zrx6gOOIEESj6hR49iESAZr0WLMxzTMbLebrq+kaq5EK+5r5owKA7G4wv5O6kZtKPLF933lfJxBolLla4/8BwLJP6UwDcMA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777898326; c=relaxed/simple;
	bh=4A40EVt+UzL8i4zb6Ud98D2zTJgVQbfqLq+2zS6lX9I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nqf6RJJexGyNyRB3VuCb798uNcCZdgPcUpdQ0wjBjVps6FpTdHOg9/Q5GX8IqQhwOUnPMuDZQSnwvY7pP8WhwqzTLUZFAXswgSKF8fTKtQCcRVB2xyEGUYi7i4uJQr9hw9wocEcgEOmveDp8y1wdCA6AWkWosZPeJ17UOLfwTXY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ntu.edu.sg; spf=pass smtp.mailfrom=ntu.edu.sg; dkim=pass (2048-bit key) header.d=ntu.edu.sg header.i=@ntu.edu.sg header.b=rplSfWFQ; arc=fail smtp.client-ip=40.107.75.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ntu.edu.sg
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ntu.edu.sg
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D3wRZowdchJdmpCb4rC85cy90X09JiZvn1/BI+68MSsWAygAncmPlSaaB4B8HbOvxtQZ8xtcoWDXVt3doaoF1Kh6R0BLiLBP4vw2BmWDdaiil08yq02djL/OYjM08uor+TK43ID7OH4LPb8m31v3LyY9bLm0z65mro0kUJ0k80XFZw7fRJu35W06W2Ysx7NZsx23tvL+dM6ULSnQ4kQmeyeNsMVRvwx9Ns+sa93zFluaUsBrRTwGGmykMcJFu0XzDRpwRAxRbArvVdnVWmoErHBQlqfIRqNGumezr29ePAacGlZtOjm5nU6YQfPaKW25NYh5ZY03GSqSsOhxDO2oMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4A40EVt+UzL8i4zb6Ud98D2zTJgVQbfqLq+2zS6lX9I=;
 b=jBYFboL34/Mqr5JKafGS7qxXgykH30a4Uuh29h/ZxcG7qpeLXzwiJoQu2oSKSd/Gz8d5SlBWZREYCGjIVGfU14JFQh5B/jj6pPMSnx3c8kyE2ZnGH/6/7roe9N1vW/DoXF/e88mk+pnMunCHPNN5XZSsfMHSeazdg8/2XHgPr7LkHbow665LIb65WV6LHjSgqabxQCcV47ip9GkGEO6GSCpZqIGwfe07KBdOXik87L/5XSeTwqz+zdy6uJEqdnhTr4b/k+nY0CDeSjdJgh+KIn3dWziWe4zDZ0iaHquqMoxxVNoMlMMs5F1bpJMFMcAyZSlXFvTs+fN3eUq2i6dxsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ntu.edu.sg; dmarc=pass action=none header.from=ntu.edu.sg;
 dkim=pass header.d=ntu.edu.sg; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ntu.edu.sg;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4A40EVt+UzL8i4zb6Ud98D2zTJgVQbfqLq+2zS6lX9I=;
 b=rplSfWFQBrcmoyNZJOedqODsYG6akNV3jCfxiU1lrToRmFwjHpwaLNOUEh/w3OzOqj6qwGUNUvfyVEoOvEypTgGz0PWhEpXUlaFGilz8SYl6B2wDveTNjSom3Rj98zj3cXkJ3DLx8dn4gZ3hL94h12h/q6V31gRvkku3dQZ+wgL2wnCrprQryT5HUO0p2cnQTK3tqLtsZyoOrrX6JPu0IFrMNf7AYVkfXwXk12Z130dhGCnqvj3RQP7ZHrrz5qc4SNl+LaN6O/PnqJPSWBOVnIOOlzOudc/FMFzQ9AyZsImHPK8ry79ZJuLaHf/Zff8GORJGQhhhNq7kZj5E3hRf6w==
Received: from TYZPR01MB6758.apcprd01.prod.exchangelabs.com
 (2603:1096:405:a2::6) by SEYPR01MB7941.apcprd01.prod.exchangelabs.com
 (2603:1096:101:300::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Mon, 4 May
 2026 12:38:39 +0000
Received: from TYZPR01MB6758.apcprd01.prod.exchangelabs.com
 ([fe80::bbb1:1ecd:fe69:9743]) by TYZPR01MB6758.apcprd01.prod.exchangelabs.com
 ([fe80::bbb1:1ecd:fe69:9743%4]) with mapi id 15.20.9870.023; Mon, 4 May 2026
 12:38:39 +0000
From: Xie Maoyi <maoyi.xie@ntu.edu.sg>
To: Johannes Berg <johannes@sipsolutions.net>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: nl80211: SET_WIPHY_NETNS does not check caller's CAP_NET_ADMIN
  over the target netns
Thread-Topic: nl80211: SET_WIPHY_NETNS does not check caller's CAP_NET_ADMIN
  over the target netns
Thread-Index: AQHc2sfEDoUrMnJQYES6zpBNK7u1erX9ikYAgABDc3k=
Date: Mon, 4 May 2026 12:38:39 +0000
Message-ID:
 <TYZPR01MB67588CC073DEC87C0A595314DC312@TYZPR01MB6758.apcprd01.prod.exchangelabs.com>
References:
 <TYZPR01MB6758FE8FDBB58A6CAA4DC6BBDC302@TYZPR01MB6758.apcprd01.prod.exchangelabs.com>
 <316680e2dc0103774bf0cfb77f60341a85ef5b81.camel@sipsolutions.net>
In-Reply-To: <316680e2dc0103774bf0cfb77f60341a85ef5b81.camel@sipsolutions.net>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ntu.edu.sg;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR01MB6758:EE_|SEYPR01MB7941:EE_
x-ms-office365-filtering-correlation-id: 1ed16db4-eb11-4331-c6fb-08dea9da1175
x-o365: NTU-OFF365
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|786006|376014|366016|22082099003|18002099003|56012099003|38070700021;
x-microsoft-antispam-message-info:
 AvmxtckydiseWuIfLBpvqK2gj6Dt8vuuAzzSaW3phPva/hsN7hbUTBoU4BVLBiNzxyrlME5UB+rt9N+r5MWgoYYpbFoe7RKAPDb5NaAJX2VQOD2/ha9j9GUqA2HygR8aqgtQgfeIT6zmk+//3ZVcglJuwEy+U8lAxaunkYT2Ao25XCTB9o68SvDNXGzGniFO29+ODG1eqBmsmMLQ3I8N/3LcbVYGB6W25FQViEWgSPNooT+2MTN30hvjiCCmqZk2ocApgOrhPjKVD2xZS1VfokCPrDOLNPCYkQhahWzzuRVgi9UAFppLVTBN1KjT7wkN+X3+LPs/dvKA2NRDcES4daxp7Q5qFy3Agl9273wkmSN1Oed0VohO+htd7DesCtVLtJz3RJTmSy3aFl2Mfv8YMOS20etU6Myo0To8mtBQch+aXjUogetuHG4sJxAnfna84B6gzuNwGRbmPatlNQV+elo8T1S+Y/V7ULDjrrEUEPBi9uqjvnUsIYvFaUyrLT2i9AHPGqEE41TzUfH83VVNaQmYIp+FQiEhG2JQX6DFq49xl8Z4rU0g4zMIiNn6dkwSp8daG+RhkOhz3kYQdyjopepQBa9TuqqY2sNFMwfQM0yReXEeRJPM9Kedu1KY1Odh/N40/Q9JHg2scbFSyjaMEi0spywduRoXHNY6ADPRoBoMfmXYt29c5djRCYREVq1v
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR01MB6758.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(786006)(376014)(366016)(22082099003)(18002099003)(56012099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?BXjHjNtQ/kwu8jKHWAMixEX6HBaiCHJNZgn0dA2lQooL/9dSv0Ioneoyq/?=
 =?iso-8859-1?Q?Wes94+CLxgNeGpWdSZqHcJtXGTBF39dwHDL9NrZyDO9cTAN4wdij1MtQfb?=
 =?iso-8859-1?Q?sj89bOMsEnp+qBgfG2yPGmeVLvNnFtkaG+PqnnqlZ9j5TYQeqYVRbYGOlF?=
 =?iso-8859-1?Q?HKHlmvXrvNI5MCt7Ghk1bjFlCfyTYFPOqfhvzH9r+KwptqAZCXo152iPFU?=
 =?iso-8859-1?Q?JqpE64+Mjzg7OUZtUpmj1X7FuchJ9DNsKb1wMU6InyzRn5FJPctz05k8ci?=
 =?iso-8859-1?Q?A9mOKevlBL7uFFc5fg+RL0Kb3QdUsUZmySWx+wDqFn/O9/xyQ9ParQESa8?=
 =?iso-8859-1?Q?Sd/V1YdLKBuw3Jo4y+Adf+n/4rL/dv87nzDZjNnOa0+BicS1Fq54MrbO4r?=
 =?iso-8859-1?Q?xQe0d9iA2iVix7U5XKq+z0vWp4oa9MffJmxw34fOBDy0c+tMhr9EHxetD3?=
 =?iso-8859-1?Q?w0urLUhWQF4MxVu9DZXV0iny4Z3D+ctM//d+J+c+uj7wMzRsqYz8ozpxZ5?=
 =?iso-8859-1?Q?pezH2I/E10hU0YGZu9w6kmv2sGztvD6dvKCK8SWXY4aXLirlJ+GNLa8epW?=
 =?iso-8859-1?Q?jK7IVjO/jHyw7ZFlyjzYnsaZ7nlcY1seYvYdSBZZd8XzXNjmmmE3DpCurF?=
 =?iso-8859-1?Q?SlTCekbwHhOUsFH2HUVaTwsyxGkuI3yQIUFabLk40DpIk7nE8rsiK2oMeD?=
 =?iso-8859-1?Q?Y4RC0QFbHHOjVfe5xxL3HuZRYey8eh2ZuKUNXzYEGVS6VyVLDevSsRmYsH?=
 =?iso-8859-1?Q?QEzN9Dfh5oHXZO8DRnbezy22boEDcOTs3M619yi5VRZ9zS1UcvFd9B380F?=
 =?iso-8859-1?Q?zHZgdtQ1/2RFFrVSFWd7D7nzgKbYsdqztM33d/4yF3EQbYn56t4EKQ5XJm?=
 =?iso-8859-1?Q?Zv9yn7xyw/uImiXdHh8Y+aJDVnMe+kAT4aF5/Q0gv/Tcd6y9hk5Qn1FWdn?=
 =?iso-8859-1?Q?ggt5OVCGH1/S26aqWQvwxlWSWdwqVzI3cRvAxFUdgLYVMPm/1uSnlsuiQC?=
 =?iso-8859-1?Q?fUWqxkxp4eIzxJRCSIEo56jDBZCivjK4vbxmdqpux9OYkcnXfPPBd/Ropu?=
 =?iso-8859-1?Q?tNyRTpiqTqXhE2F4g9lLNesDmTKaOlvC56YCLbN+li982puwU2vPHeW/3z?=
 =?iso-8859-1?Q?tjsHn66NXzSY+imetdhyoSg14uk86z4t9ynZJZ/ZJuxVaiOqPLmk4cWjNF?=
 =?iso-8859-1?Q?8ucSgj4RKTCYUZRb0vJYnCT2ZlEo50Z1c7QMTuAm4GT7NHDEMJ3HuvROYQ?=
 =?iso-8859-1?Q?Jxeri5JMGlosjUU5hV9JTIJ3gI0pX5vdGgf9QjiV19TB17IVkDBEJvm9kM?=
 =?iso-8859-1?Q?NIbvyyiHanjeLn8efIHPm+eKH2R9WriPft8VOKXVHy6D7BH79LRp0roL3D?=
 =?iso-8859-1?Q?ZXjp1WZMd8qNk66aBvPupdJ5BDNmAUOy50fh7sROL5UQpb1SJeJvT+GR8c?=
 =?iso-8859-1?Q?o17vWKcKR8QFSVYxMh5tE+8H1tX9sHmeNF/d4prbn6DumBEK53MVVhF5gc?=
 =?iso-8859-1?Q?wl1q8A8/n7rE+FfzIJ15XL3H+57N7QsmXxAoiiHFYfrNkaY7qgxnPl3TiO?=
 =?iso-8859-1?Q?sSo5SsNj5x+RhT2VoDnuNVE8vdfKfczlKhoK8v1tT3LYzRH4KKSBjbtPkP?=
 =?iso-8859-1?Q?wijN3gCFCqicrivg0qefZyZhwVG7ZdHiKpDsOipSwLt6MWYw9sS89+MFp5?=
 =?iso-8859-1?Q?1gNbNQUmgnLPOYbspGtMqA220Wip+5lbTaMipCXHenlZEkUTKDHs+seryp?=
 =?iso-8859-1?Q?nKJR+kgq41rjC0QlRbr4kF5vE1Eto0SwnkpK1E2m+g5DVfp7QPngSoGUWO?=
 =?iso-8859-1?Q?beMEW9nC3mea7lr7Yv4s1SYoqjJw7AM=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: ntu.edu.sg
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR01MB6758.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ed16db4-eb11-4331-c6fb-08dea9da1175
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 May 2026 12:38:39.3658
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 15ce9348-be2a-462b-8fc0-e1765a9b204a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Gvlk+6KekeMNT5OBRfc4ntliMavKO3Ubwrx7WUcWqxZgTplLU8TgVZtCXqZGCJ0HiwKumrEEtgFNbjfaOn7LJyM8Dc47gVUNiEB8F99hDI8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR01MB7941
X-Rspamd-Queue-Id: C9E7B4BCFD5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[ntu.edu.sg,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[ntu.edu.sg:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-35837-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[ntu.edu.sg:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maoyi.xie@ntu.edu.sg,linux-wireless@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On 5/4/26, Johannes Berg wrote:
> I guess that's more a question of convention than anything else?
>
> But I guess we should follow the netdev convention:
> ...
> which (also?) requires access in the target netns.

Thanks. I will send a patch that mirrors rtnl_get_net_ns_capable() in nl802=
11_wiphy_netns().

> This seems ... inconsequential? After all, moving a wireless device
> between namespaces doesn't really change the physical layout of the
> machine. Perhaps that'd give someone access to the SSID of some hidden
> network but that's not really a secret anyway since it's over the air.
>
> Maybe we should fix it for clarity and convention, but I don't see it's
> really an issue?

Understood that the impact is small on its own. I would still like to fold =
it in for the clarity and convention reason you mentioned. The fix in nl802=
11_prepare_wdev_dump() continuation is one net_eq() line. It brings that pa=
th in line with nl80211_dump_wiphy() at line 3437 and the scheduled scan du=
mp at line 4420. Both already do the check on every iteration. Happy to dro=
p it from the series if you prefer to leave it as is.

I will post a 2-patch series shortly. Both patches are already verified end=
 to end on a KASAN VM (the EPERM PoC log was attached to the original repor=
t).

Best regards,
Maoyi
Nanyang Technological University
https://maoyixie.com/
________________________________

CONFIDENTIALITY: This email is intended solely for the person(s) named and =
may be confidential and/or privileged. If you are not the intended recipien=
t, please delete it, notify us and do not copy, use, or disclose its conten=
ts.
Towards a sustainable earth: Print only when necessary. Thank you.

