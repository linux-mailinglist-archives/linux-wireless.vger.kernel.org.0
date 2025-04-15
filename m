Return-Path: <linux-wireless+bounces-21555-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD4B0A8A368
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Apr 2025 17:52:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09BD318862A7
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Apr 2025 15:52:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91CBF158858;
	Tue, 15 Apr 2025 15:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="eSKuHHw1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazolkn19011024.outbound.protection.outlook.com [52.103.43.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA9784315C
	for <linux-wireless@vger.kernel.org>; Tue, 15 Apr 2025 15:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.43.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744732330; cv=fail; b=HKM36pE4rDiLn6Bh+3J9LCbL0dgMR8I3/vc5xoV23bQpQeTTYjnioh9sT3k3DE4xEU7GuOGU14ilfJ3kShVaYIbLPYf470Ir+ygUMKCKh3dDKrv7SINDj7ML6q4wMmhETJszKfLQM0apKpvMZ+hDoQxKOeOhBy+k2e9BBGLxexk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744732330; c=relaxed/simple;
	bh=HHLYkhy4of8I51P+Yzfjhv/a3Ltk2KWEHxYJUkSLnsw=;
	h=Message-ID:Date:Cc:From:To:Subject:Content-Type:MIME-Version; b=OsIBKweDQxaZwDVdeTy95r3f5+Lm9O2Gpq078l60x/SAa5n4Co+AM59CFlN6l5b6/VJbg/QjcYiAwH6SQpyOGpYYXiqXHHhBl/SAqVWLilhVY6HURyJQ/Woy/XZdGv6FXqsS0o6wFNJefVTIh17dmAvXfVlLxrxZ7ZDsxFcK0zo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=eSKuHHw1; arc=fail smtp.client-ip=52.103.43.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rjDV60ADmcwqFo96jKhPGmrqYJOEPoY4iuZJ9UycfqCpFXlid9cKpHugkOWJe5Xy8pY+ayFZH/16RVj/8RMDiSic4QZnNaCIT6xQ3wCLB2D0tYlTspjBXX6yYukOuH1IfY07F6RWJkiykz815cKIbWZ5WWQtFDMrhm8jaY7L8bU3a4ew/zfbIctrf5dlvE/FGpjIVAAbXPmLmusNNasfZMfOeMRobfKni8CXKe8KpRlf1VEkQ6skhqvAWI4WbM5HltyZm6P0VV5WiiKfEZg6WDBOOFbEOrQJZdnDLAFi6YgQWWtVpFK5hn1wnKUyabs4HGndABdqY2uBsIBjI6H7CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HHLYkhy4of8I51P+Yzfjhv/a3Ltk2KWEHxYJUkSLnsw=;
 b=AL84GwJf2XrYZ641ENoBuZviwud7pQkCWX6fFXU983j5BDAVkhu8NBiGXugD150n/p14W3hZgk3uRRhJWCdR1YxiWtvMFd5ud3mgRCgOwXJkshgGM+Ml5KyNAQrc/Pk+4sPf6cSfQFP5YEA8BL/FV5wBumYAEkL8zIxzRFnz825CR6moKjYHSTPHmlf7EcAn8HDTK/0eybp96TNjRXW5jrVM+Zeb7oGUF/79VBtweaG4qJSjqkSJFEqNjywryu9x36sHtw2swVi0Re9g58D9f0jfHY6RLG6r2oy0/XBQln/7EIcvkV7Gdq8rj/tSpJFXomQKqgq3asjBUiJjMsQgow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HHLYkhy4of8I51P+Yzfjhv/a3Ltk2KWEHxYJUkSLnsw=;
 b=eSKuHHw1f2PFM6KQ8BnpZrWMlcdHVFPpqGmmytlI15XQ14fb1iY7k5mCp27CnMci3RqXR47ozoZWHt4fod27UBRRoPuoDWkMcPmcQPngHM6u34K/wOeuJrjqWKvvocZu9HObyHrVuut2fhq/fYagMUXAr8fqowuTgl6mBSNXAFu6MMn+h08EdxcYOkKz45yv2i4G0wrzTORl85HBeT3CtFblZZVZV0u6RBVEArbgCSze59FEasUc8h3lJ+7FvLRzKNRprZoLBEqVvg9HQ/bSoFeJkvP37ev5IjkS2aUE3OIxjZEayItCL9x7nHHzcEnqC40Be6GFDg1Q/9/LXB0cTQ==
Received: from TYCPR01MB8437.jpnprd01.prod.outlook.com (2603:1096:400:156::5)
 by TYCPR01MB6319.jpnprd01.prod.outlook.com (2603:1096:400:7f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.36; Tue, 15 Apr
 2025 15:52:02 +0000
Received: from TYCPR01MB8437.jpnprd01.prod.outlook.com
 ([fe80::83e7:751f:f3af:768f]) by TYCPR01MB8437.jpnprd01.prod.outlook.com
 ([fe80::83e7:751f:f3af:768f%3]) with mapi id 15.20.8632.036; Tue, 15 Apr 2025
 15:52:01 +0000
Message-ID:
 <TYCPR01MB8437DD90C8825B785787C58298B22@TYCPR01MB8437.jpnprd01.prod.outlook.com>
Date: Tue, 15 Apr 2025 23:51:56 +0800
User-Agent: Mozilla Thunderbird
Cc: wiagn233@outlook.com
Content-Language: en-US
From: Shengyu Qu <wiagn233@outlook.com>
To: linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org,
 Sean Wang <sean.wang@mediatek.com>
Subject: MT7927 support?
Autocrypt: addr=wiagn233@outlook.com; keydata=
 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
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------S75HCA80WGt81gqe0OTh9JsF"
X-ClientProxiedBy: SI2P153CA0028.APCP153.PROD.OUTLOOK.COM (2603:1096:4:190::9)
 To TYCPR01MB8437.jpnprd01.prod.outlook.com (2603:1096:400:156::5)
X-Microsoft-Original-Message-ID:
 <3223f9bc-6c36-4f37-8301-b293e6f2024a@outlook.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB8437:EE_|TYCPR01MB6319:EE_
X-MS-Office365-Filtering-Correlation-Id: f3e9e3ee-5729-4887-b88c-08dd7c35763d
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5062599005|461199028|12121999004|8060799006|19110799003|5072599009|7092599003|15080799006|6092099012|13095399003|440099028|3412199025|26104999006|26115399003|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DduE3v/YQ6TYHPQhploJlaUnPht1ag/m2pI272i5XM+wvBApZtgd30gPcxfK?=
 =?us-ascii?Q?2VoFL+At6+sAtt6PzDf+WSjX85GROTCYzUqi/elfDzj5neenvPosw1yNWsBm?=
 =?us-ascii?Q?/T9luldIZDubFC+8d29cD3pfQhGVB1tb5SiMOZ35m2jERFaj1ChNPpB377RM?=
 =?us-ascii?Q?ziwJ5d2vzgM40kRleX+iPCQpn9gCij9a2aWmEvH/HZmsDHNDdi534ShVBfW+?=
 =?us-ascii?Q?PGxh2CuenFoZ08o7iP9XTYQ1itRiau3wOtLygYl9QYtayUCEbWh1/uS8dH30?=
 =?us-ascii?Q?fjMDQthinY5/I3qn4WwI0PI6CwzYSNyM4IWCHAdG6BtRc+/7YEkhpzPzHacz?=
 =?us-ascii?Q?V7FSycASFoLIRcTIIqYfV8mOdfnUJh5cBTA+08jXDDvdUpR1HCc04gg47AUL?=
 =?us-ascii?Q?lnPJlhtG94GA5ceRLqDHP7w8PHFbgo6K4B/r1p/md6xxtO5bn3jauNz/jMZK?=
 =?us-ascii?Q?VvIUolLCVtz9LLPsBSfbq2YTLxWXqBQguHc9lKQMFprVW2OIwwmnEDdYinsG?=
 =?us-ascii?Q?hmqSpgTIS2FL39zyHGysJkAdiV10d2Elacx1MevN2BMQgFnMgIhA+ePmeG83?=
 =?us-ascii?Q?Xp5L8/T0HLM6OsLA1uAcmX925nJ25ftEYbSXZa5oVZjIyPOerEgr5/1sGd1Q?=
 =?us-ascii?Q?HX4GKQQ08ms278RbUvJD9cTgZU8+4xWDhnvxBs5dSEVsK6hh2c5/Qdp6HTpa?=
 =?us-ascii?Q?/c52f3Ss2ZLa07d3zikoSzE/YbeeLntODXRe9ek4qNCTkGvKJagUKh0YAhPu?=
 =?us-ascii?Q?iyG36MB4Mlk+WCP40XCrecAfsGeXfbXYB1GyM/yfGURs45bFZ4h2puj2baLf?=
 =?us-ascii?Q?IICxV2xJldMyIwqiuHNEw0UpJKbACjC3waoCymgL43De5UoCtXZz0sTFB1lk?=
 =?us-ascii?Q?/KGOS0HTnHf3xzBA7Xs8hYiRUFxqnvXqKJTrLRr8/22B8yW5LhmmGws2QZgA?=
 =?us-ascii?Q?dxsV4BXfVCzJpCUMUjfTeMUaYE2jNn04x9XY2Eyl0fnZ+d9uwTtW5l3xCwn3?=
 =?us-ascii?Q?Hfj5v2QSo1sZ/FJpUzJndw1efk2yxMMoxAya6VZ70m8Hrtu3HC7S3bXT/6QE?=
 =?us-ascii?Q?w+NDOvfUzpz65Dxz76dDc4/JM3zyAwBnH1kvZM4mxbxcCHrU1MtJB5vztg2L?=
 =?us-ascii?Q?eEQ83gmEbycFKvNmqZNmnT/72mkyCPIPri2hUD8TYFiPPPQMP7r7kdC/NU20?=
 =?us-ascii?Q?/zSiq/poIC/iLK28I6m3yflzrPL17OV43gpKmf9qwmxQPuGp2rF5DEo4/hgb?=
 =?us-ascii?Q?M23RXyL3wbLW0rv9ipTugo/oGeEHMnjHiZA/5/DadzahY8rkGfZfcL5I/9+k?=
 =?us-ascii?Q?ouTKHupyeZ+c5EM9RqDIbTtqykQMQxJR7O3ZGSJPFyZZsw=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2IqaeY/7EFhIY5jqF0HWV5u9HS3+gSaEaCKsaTsR3bqmvUUggLmzt7wYMXqg?=
 =?us-ascii?Q?rlds48SNlvWJeIruert2FPpUSdLoeiVwDGgr5/RgA+qN+OVbEY2bkv+NI1rV?=
 =?us-ascii?Q?8KqMI2aoQ3KP5vSZ3VgjpPbVZKX3Fixo6cQ/9WIhqbUDPjWaUYLt733UZ188?=
 =?us-ascii?Q?LE9gauQ9qEnC+MZllHUK3K94cHjVbiVaqytKZ564y3fHuM1KYkkhXtj9Yhs/?=
 =?us-ascii?Q?uJyLJqR/hFqxGTSOoc1clSzOvuwczZ0iufjqxWHXP24FTYttx4l8oYF4BvC0?=
 =?us-ascii?Q?yYidIZMK+S4Swr4PMEsq+ttpYSyBH0EgV803bRJbbK5raW9I71wK/4PHFdo2?=
 =?us-ascii?Q?DcaXrPJKYFxdAXxtKW/h6DQuaxNNF5m5q7e+LM5eaZ37HhGTT65IUW/E7mUB?=
 =?us-ascii?Q?F75B5Uyr4U3z1nLSIJoRzPITS2mPm6m5ZSc0eov3eOseJMUiO9kpNuM+yCJc?=
 =?us-ascii?Q?pkVXIqZETBL5uP+5kfb82Udx6mVrQ7bb8ZUVx1ppM1qDXETzX1ufsoMOU8Cf?=
 =?us-ascii?Q?+BN1WtCM7SBlCIzmQGC6dCtOFTmN0tlQjrXomf5ra/1XkLV6jpeLtZLtjKUb?=
 =?us-ascii?Q?tJO/Y8StBXn74AXYHYxmSNVQyBC8LbIhooQu6XR8YlyOT7qFTDsnCvNMrfRx?=
 =?us-ascii?Q?xIlOBjyiCYOmz25yqSCQE9DboE+UUtglEzQUXrZA0Wvn6v3be+Ildh6ID6c1?=
 =?us-ascii?Q?PfEyPDhdBbRbdBZtw/RXqjYx3ixUdbFnLqt9RcP28oN+ZvtKEjm4GrhJZ/rV?=
 =?us-ascii?Q?JoEBSkWzvclGO0qzQ4A0AVLGroEJjdoSMumcx+25VulEck+0HuCDP+7iAwlb?=
 =?us-ascii?Q?jV5HcIAvafdMkF2xAyxhQgeBafzCCTT45hQsPaUqXLP51XBxdWIZmTHCAN+Y?=
 =?us-ascii?Q?+JRSGQ11ULwaUQJhp5cSi7bRt1yI/Sppa7n1/LJJaorKAVCuiG+330Ivp7Ct?=
 =?us-ascii?Q?bdp+bB9W+gU02ctZe3YBAWZ0X9o+xqPm64J/xpyReRh49fviR50zNVUlq2AY?=
 =?us-ascii?Q?MDzRFK80QcOajDySAWzzyZb6zUrskmiITfLNdD+Zm4yk9K7zay2yuyx0/H1L?=
 =?us-ascii?Q?pm2zWvanDJdgEX7+TvyQNDXe8k5Pk/xflBaIgSpRz8RxQd9MlHyJSK0Fa3XG?=
 =?us-ascii?Q?pTx/9dm6ZDKExKrjzYHx08eoKc83FBe5tl4MhOlOahc6CBqhZCIs5NgWlPku?=
 =?us-ascii?Q?YSlZuL748v/thyacUkYGy86TQ22+nHEE6mQxxJCxEGIOFBkpLxj1OkfRAxUl?=
 =?us-ascii?Q?cIzTvQkgf9UZ02MQWj3w74eA9X8U34j+++Tpr5aE0TwmQflrFtgGAVo0er1O?=
 =?us-ascii?Q?5kM=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3e9e3ee-5729-4887-b88c-08dd7c35763d
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB8437.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2025 15:52:01.9016
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB6319

--------------S75HCA80WGt81gqe0OTh9JsF
Content-Type: multipart/mixed; boundary="------------NER8SGXhPpP6z2qOaZjMgTLJ";
 protected-headers="v1"
From: Shengyu Qu <wiagn233@outlook.com>
To: linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org,
 Sean Wang <sean.wang@mediatek.com>
Cc: wiagn233@outlook.com
Message-ID: <3223f9bc-6c36-4f37-8301-b293e6f2024a@outlook.com>
Subject: MT7927 support?

--------------NER8SGXhPpP6z2qOaZjMgTLJ
Content-Type: multipart/mixed; boundary="------------YGmx39wX06kIot5oNus9VS69"

--------------YGmx39wX06kIot5oNus9VS69
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGVsbG8sDQoNCkl0J3MgYmVlbiBhIGxvbmcgdGltZSBzaW5jZSBNVDc5MjcgaGFzIGxhbmRl
ZCB0byBtYXJrZXQsIGJ1dCB3aGVyZSBpcyANCml0cyBsaW51eCBkcml2ZXI/IERvZXMgbWVk
aWF0ZWsgbm90IHdhbnQgdG8gc3VwcG9ydCBpdCB1bmRlciBsaW51eD8gT3IgDQp3ZSBqdXN0
IGhhdmUgdG8gd2FpdCBmb3Igc29tZSB0aW1lPw0KDQpCZXN0IHJlZ2FyZHMsDQpTaGVuZ3l1
DQo=
--------------YGmx39wX06kIot5oNus9VS69
Content-Type: application/pgp-keys; name="OpenPGP_0xE3520CC91929C8E7.asc"
Content-Disposition: attachment; filename="OpenPGP_0xE3520CC91929C8E7.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
scUnWnv8sErY943hM8MUsMQ5D0P2
=3DUrys
-----END PGP PUBLIC KEY BLOCK-----

--------------YGmx39wX06kIot5oNus9VS69--

--------------NER8SGXhPpP6z2qOaZjMgTLJ--

--------------S75HCA80WGt81gqe0OTh9JsF
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEET/yoGP3p5Zl+RKVuX75KBAfJsRkFAmf+gJ0FAwAAAAAACgkQX75KBAfJsRlB
sBAAmcmjPw2e9gALxoGXD7krkJuER7Qi2KzLkH4MPWMo8oejkWQ0yTdkXESEpVK98vUeMO3LwLJk
9xskPTcCO0yNp2Ul74gxFcDSKlTRqJSX+q08/IbAnWdkAyvmFZE1ZDY4pWK4BAN3CO28WArvNigX
f04Hx9xACi4HpAxkdtDYsykIZlvicddEHp4u1T/p3ZUGgpW49XHyP96zIADLTLDd/DEd8QXEJgtP
5Srh1Fo9A5sCy2zljED2mHBEZcWchZc34DtZ5tEGK7H125Ra5vQXoqPSao4DcgQFbEWfW5DWGXcH
J6IdMAFqsgfZ167+Q5qh+U9u668QNaHfYeYkJlI9C0zU1tFgSQBhjujWX2wZGGH4645XDguDUH2D
6rvGznduBYNHzaGmswNsApPMu60HLxrFworpK9iig50A6tvV5TxTwsgnbcFW94RGK1DSU4mRNVWN
K5Oo6dDwdvqAnikE8XsrG67pK/CBcwowbVH47tkJVF/SKuGlOjoZhT/3bV5phnp13F0c4aVGqbNs
CFAN6V5BLZDaR8YDuL7ZP3uHqc0eQ1JfZUBfo+Elp8StgjbLlDeFrD/u/6xzfMdFCSbFtIRlI/+h
fE8t8kfNdYjb3yF0ynbP9UBdgHRrvDeyuaSOkcURtlVE3QyN+YoegboG46l23RvVOFEpvHHHOxpz
bpI=
=/Mru
-----END PGP SIGNATURE-----

--------------S75HCA80WGt81gqe0OTh9JsF--

