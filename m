Return-Path: <linux-wireless+bounces-36496-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sEdAIghDB2oCvAIAu9opvQ
	(envelope-from <linux-wireless+bounces-36496-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 15 May 2026 18:00:08 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AAFE55290E
	for <lists+linux-wireless@lfdr.de>; Fri, 15 May 2026 18:00:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9CB183055BDF
	for <lists+linux-wireless@lfdr.de>; Fri, 15 May 2026 15:45:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA5153EFFC9;
	Fri, 15 May 2026 15:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ntu.edu.sg header.i=@ntu.edu.sg header.b="Na9C+nLY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11013030.outbound.protection.outlook.com [52.101.127.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF923EFFC1
	for <linux-wireless@vger.kernel.org>; Fri, 15 May 2026 15:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778859659; cv=fail; b=LxnqHK8i6d/Oy4Dg0lqS4tzPzRaxi4Oh2yiYYF4DOrKIVG1iMPvJnDVX3vUYvxaxDUDuABr+1Q9JeNP+E2TqDwa/2ufgOwvuO6mmONublThFMWSIKNHCJaXbIS2KP3PNkkcqJRaGl9U0LevIokVGWnR8uiK4Ty4+wS58R47qbJM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778859659; c=relaxed/simple;
	bh=rNSyGNJ1hVkEMwRxPfcZ+1IdyIT7ZPN9ocgHLlQOKww=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=bC5xzFYZga3E905w5HsVa9NPYf+aerMTM33dymVBOfySTeaO27Clh4EzSKagTOuRE8oAgfWdzlX5oRyYDusCtgRqbChVqhTgc61O1XclpbFxla8JFu6IMf33kkZ+xriTnKXdlA4flP1X/98DpaxWRWHMribpELbMx0LSVL8PTUc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ntu.edu.sg; spf=pass smtp.mailfrom=ntu.edu.sg; dkim=pass (2048-bit key) header.d=ntu.edu.sg header.i=@ntu.edu.sg header.b=Na9C+nLY; arc=fail smtp.client-ip=52.101.127.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ntu.edu.sg
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ntu.edu.sg
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=msxEKdJmLn0zQaUu5v4IO4mJYz+x8j94LmgM6OiGuVAiqZDAthbjUX4/mwlE7+QEHNG7+VEq68Fqox3aQ5MR/S1TtH4NBl0O7EaZ2JvBwToB8tegJbvsfhFluJgHsM3wZxlbkoQT4mvj8qKviK++ozz8dqt2I81FIgNi8MY7k6be8xubjn5OWHTc+LX6h9LZStp/Tg6ZravsJ7gjPcZHpE+g+gONjt4wTpTtiOsdrN6yVgkWOS1ajdbkEcNVcEE8M58hYxD4+gPxoh359SIF0uleAmvSw+d1uZoGB2yQGVBgzBm5CGGO+nA0qUACxp4qjsR2gpETFR/muSj4Z3i/9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rNSyGNJ1hVkEMwRxPfcZ+1IdyIT7ZPN9ocgHLlQOKww=;
 b=OiPg2ESnoWIUaiDeuf0AY0QR3jHQ4t7vFY2MxMsPMcjDBaBlGnbeKVmCeJCfF7V9YIQG3OcmRCvNcfGKpzRT4ITEL8fHIrw0ssPbr7pJdgc7U4XSIgHinUn+HvTADPK8/TTIlDVWMEmlmOpL4OHNsykK0JeNjNDHnH4vgqtchLCzmp3zbI3IOaDJe8Ukn250QSQQf+8c2NXOIGWAgroioob/XDzThRr9RFHMeW+PhYCRuRIATAKea0nB0JmRuNskm1gvNdnr71RfXDm7OkoojH/g61zVJYxrFF0m8xH5+YsKNUxtL+YzgJOB6V/rkBnyDr5sbGzOrMUiYKtRZIczqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ntu.edu.sg; dmarc=pass action=none header.from=ntu.edu.sg;
 dkim=pass header.d=ntu.edu.sg; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ntu.edu.sg;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rNSyGNJ1hVkEMwRxPfcZ+1IdyIT7ZPN9ocgHLlQOKww=;
 b=Na9C+nLY2S6rCoxTTXBR7pKVThJNkleVYPwtU/rQ3IsAQ+wTEhsEcmFy5pt+Fl7aPq0w5Xl7/6lokxbApMz2dwddxM5dkftjwCibpkmqHvANdJXsvQrVcVLV1aZSvKkWyOVrvPcckQqo1NhUhvPpPffP822gllBgJHnYE1dS79v5NfpiMotmKFuJ3vIkmvV/cezOJtCtuCxxjhOfGFuMvJxE+bepmv5amL5R6NtwUT2xG6Vp5rRC6SKfHzH9usB0rqBROC/FfSX/3fKYlblEM3nZGfGokGEkqxLQUJsEJaVZq1QofFVYZBZSNs4yHLYAYGDXVpQDN79sh8tnWkAzEw==
Received: from TYZPR01MB6758.apcprd01.prod.exchangelabs.com
 (2603:1096:405:a2::6) by TY0PR0101MB4466.apcprd01.prod.exchangelabs.com
 (2603:1096:400:21e::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.19; Fri, 15 May
 2026 15:40:48 +0000
Received: from TYZPR01MB6758.apcprd01.prod.exchangelabs.com
 ([fe80::bbb1:1ecd:fe69:9743]) by TYZPR01MB6758.apcprd01.prod.exchangelabs.com
 ([fe80::bbb1:1ecd:fe69:9743%4]) with mapi id 15.21.0025.016; Fri, 15 May 2026
 15:40:48 +0000
From: Xie Maoyi <maoyi.xie@ntu.edu.sg>
To: "johannes@sipsolutions.net" <johannes@sipsolutions.net>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Question: nl80211 testmode_dump and prepare_vendor_dump  continuation
 missing netns recheck
Thread-Topic: Question: nl80211 testmode_dump and prepare_vendor_dump
  continuation missing netns recheck
Thread-Index: AQHc5IDBcj0CX9y5xE+fLFwQAUOndg==
Date: Fri, 15 May 2026 15:40:48 +0000
Message-ID:
 <TYZPR01MB67585C3E22F1E7EE1A801741DC042@TYZPR01MB6758.apcprd01.prod.exchangelabs.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ntu.edu.sg;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR01MB6758:EE_|TY0PR0101MB4466:EE_
x-ms-office365-filtering-correlation-id: 95bf0266-febe-43ee-4cc9-08deb298562b
x-o365: NTU-OFF365
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|786006|11063799003|56012099003|18002099003|38070700021;
x-microsoft-antispam-message-info:
 3rcs9+89bv1ktkNzbC3tqCZMWAVWSqQZsarND+pqE5s+6BGUT6jsBbLSS5hWzLRX80PZwlRd7kdKDLW3sLZcGKuzBog5t3eSAeyOUVuLwRMISfT+3Iue4eLgW6v31Ty+MUz6bp+H/TV9AqBujlZzk1r5vNVtdtJAZNuXxTwcjTU7HaHKHxeH/CBZ5Z3nzHnecrNpuoWDCdPBj3Q82N5kQmyQFNYQRA21XxPcfmobWtUWPXBByMkHD7AgjPeFcuUssuVkpF6fiQCaajJzgryvzJCyo6enCwAcCa4S9R4Wvn0RM7Bbq5grTtyVGN0MeGmHfpNGF7PWA0yChR3ORH3X/dQ58Hh2s9sNO2qkF0+vvZmzQPIdlnz0i8Z0PQLaro7WIXet6kGWzhnvewO7E8bGAv+eGioPDn25kXE6Y6HXGxHZfOw8bMZrrNn4Rwt9Hs7iHd1b5M86F3iLUz+qP7TCy2K04egzhIZoS40+8/5zrDEIKKZ6xAI0vsjdZc3BgRWstvvcs/cVV16TMjBsFBvzXU7YLd6Zlx0h9Q7Q7LB2iF0Vv4yY8nfOBYCULAmopq55PMWF2dj9GNPWZKuUdn8cFV87BvwEGZXajITedKj/5eett22UrkzwLHtmjSFja29UnkWGpuXRWWUFqLb9nCO8gJhogzcO5u2SmiTzSwSrZbeSA79KbxlYBvjFbt+/jVe+
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR01MB6758.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(786006)(11063799003)(56012099003)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?hax4U+3hLNbKTKYyNGdx0S58ijcE/JxQCDVmkIPurrYtzmmGjafz6JXoml?=
 =?iso-8859-1?Q?b/F9Al4MsezJ2lqaO7Q3DTQwMdkhebEWTy/UAKAkAvc/tKh/M9j01vadSj?=
 =?iso-8859-1?Q?0OhFLkiSYcNKEN1b8Ke3T1fyACnWmkR9Xa+QJSn24hOBFp6MniwxgPQt3E?=
 =?iso-8859-1?Q?BBJ+wrA7mf6IiSiSoSttDOmsxKjpKGUZ5CdYuDd001FciZevUByCtgD6Q+?=
 =?iso-8859-1?Q?cFGdzGc5kc6yCUVs0fyPEYu/S8FfVG60x1Ix9MxOx5WsGX0MXJWnEon1ZF?=
 =?iso-8859-1?Q?6SKXQYGMHzl4yOdAUdkyB/UXhJCJnInSDZjmCsow6yAI1Jr14tGqX0XlRJ?=
 =?iso-8859-1?Q?ZN24OjWwMJyyLsJG5BKP2PwmuohUVrcgA1m3Y2JWZu28VYnlglkoGNQe15?=
 =?iso-8859-1?Q?G6l9G7v4G/8RvXacaqBbxwH3LaDOd6dEEHI8uF8guUjqb+LQ0DWhgAWlvM?=
 =?iso-8859-1?Q?c60ubQ/LzH1Mz0P7rGQ80oepnp8MxC2DK9VUqk3Vuzn46/dQm3RKryLZPo?=
 =?iso-8859-1?Q?B0WqjZ+TgMrHrN1P72b4v30zLx1hn8b0+D9UkyhLaTGdI+AR86IBYRxt4q?=
 =?iso-8859-1?Q?AEpTFciwdfs5sbIhMvPwqcSSqalAUQmhg8QCVCempRy43p+NRwwCSLbYSQ?=
 =?iso-8859-1?Q?iovAus5TLuBYB0faEeslwTf7EsjOnDv/D1tJopqnVCq5+Xqa+cYGVE3N/A?=
 =?iso-8859-1?Q?zLA1Z01zj7l4Rdvm8kbCAUMMNn0Oa1lFl4/O9PTq8WozOzlMwWSyIygvde?=
 =?iso-8859-1?Q?mIf/071D/fE1aCULE+AARSQDlty1vUrydcveKoT9+fA8C70iWBWR6xgS0u?=
 =?iso-8859-1?Q?pYN8vX3DSinqLfPthejNYzD4bqpScYXTDu49zTWBGdDlYLBkLW5Huel2Eg?=
 =?iso-8859-1?Q?/jQPE82r00C5suCDNwPGJ6efHdkUGeTdooEr+YgFSK1aBvsP+dRgFmytCm?=
 =?iso-8859-1?Q?y1e3QTqY4Uhc6L6G66sDRQ1mW+OOUYPeBtDjZyv+FEfLUtPuaEbABo5vTF?=
 =?iso-8859-1?Q?DRJWQmfMvwRbHlwFvnkepng4TbsZdg66WmHSw5pDwRwvI92YMyRKA9uZip?=
 =?iso-8859-1?Q?viJDTVB+nn86FAHNaT3M7HpKDDBMpBiZYpEjpuYMKpVZM5JnaDT3z/KeuS?=
 =?iso-8859-1?Q?qc5QBjfynsR9o1LUu9F1gdk9cOEvb2XyrdUGRLmmK15K8f7lf78Q6JYnsB?=
 =?iso-8859-1?Q?fShIRiMSIXsutWMVfgrzJWdR0PFtQUNAgzpUStN+9di1EMgyzxUo2XmJM6?=
 =?iso-8859-1?Q?7vnf3yPzlUqz+KGSs0g6OeAzGRY7RYFdxzoQL+tNIE3M2TCxEVFwQiEpxa?=
 =?iso-8859-1?Q?kW2MsKVgNTialVKrlqbxDvwgrm/yvBwX4l6WF3OUNl/yo0ATTWvbsy1d9B?=
 =?iso-8859-1?Q?6o4zmDotrjAjO5OfpAzrdAXrqIyqMKJxdciLFVttbm2Z6Ygvakw7xzUbx2?=
 =?iso-8859-1?Q?AMTz3EZR0ciW1uRntI9p2f0htuJaohXaseNkpj9MlwKg3y0jfYblTHhBkU?=
 =?iso-8859-1?Q?IU2Tgx9x86LMWtRC2dn+QWEpdQZykRJHaKa6vumTU2XKezIWjMXVplXD9t?=
 =?iso-8859-1?Q?lqiJT9g5zyHTVPEdhbHzZXZ20YlDn4anQKJJFKUpnb8O9uVlvKT9jR48GU?=
 =?iso-8859-1?Q?+dgjiNa5s1/pUsNbq3Pu4WIOxqdLBByr28gB5tSzYrXlzAltWeh6Tcwbpw?=
 =?iso-8859-1?Q?dhZMSekm2lgo0yTF3y2JjOsp5Gw6Y5GIM/zHUcALEpPL2wlSlQRysymClC?=
 =?iso-8859-1?Q?ZSbU8zb4w8l5/3oWkw5Z8RRUdcU7jjKfYH1oNgkkgpesx8NyRXCyJMsBee?=
 =?iso-8859-1?Q?VVto3/29DVTeeO8VPk9HI4y3PGAmco0=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 95bf0266-febe-43ee-4cc9-08deb298562b
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2026 15:40:48.3565
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 15ce9348-be2a-462b-8fc0-e1765a9b204a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KNNPlzx+rdc0g4OW9e7zouTvaXqhrM/qDYL3dNHDdQ2SiJkFwn1+cPCyFR1yvJAfFd8csSN4jr38snhnIHDuSLftvw6T4w4d8JgzUqq9/n4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR0101MB4466
X-Rspamd-Queue-Id: 8AAFE55290E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[ntu.edu.sg,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[ntu.edu.sg:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_EQ_ADDR_ALL(0.00)[];
	TAGGED_FROM(0.00)[bounces-36496-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[ntu.edu.sg:+];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maoyi.xie@ntu.edu.sg,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,TYZPR01MB6758.apcprd01.prod.exchangelabs.com:mid]
X-Rspamd-Action: no action

Hi Johannes,

After your acceptance of 79240f3f6d76 ("wifi: nl80211: re-check
wiphy netns in nl80211_prepare_wdev_dump() continuation"), I
looked at the other dumpit callbacks in net/wireless/nl80211.c.
Two sites read state from cb->args[] across continuations without
a comparable net_eq() recheck.

Site 1: nl80211_testmode_dump().

The continuation branch resolves rdev via
cfg80211_rdev_by_wiphy_idx() on cb->args[0]. It does not verify
that wiphy_net matches sock_net(cb->skb->sk).

Site 2: nl80211_prepare_vendor_dump().

The continuation branch resolves wiphy via wiphy_idx_to_wiphy()
on cb->args[0] and proceeds. Same gap. This helper is called by
nl80211_vendor_cmd_dump, so a fix here covers that path too.

I notice one practical limit. No in-tree mainline driver currently
registers .testmode_dump or wiphy_vendor_command.dumpit, so the
paths are latent today. Out-of-tree drivers may register either.

I wanted to check with you before sending anything. If you read
these as the same class of bug as 79240f3f6d76 and a short series
mirroring that fix would be useful, I would be glad to put one
together when it fits your queue, or to drop the thread if you
prefer.

Thanks,
Maoyi
--
Nanyang Technological University
https://maoyixie.com/
________________________________

CONFIDENTIALITY: This email is intended solely for the person(s) named and =
may be confidential and/or privileged. If you are not the intended recipien=
t, please delete it, notify us and do not copy, use, or disclose its conten=
ts.
Towards a sustainable earth: Print only when necessary. Thank you.

