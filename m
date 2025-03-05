Return-Path: <linux-wireless+bounces-19797-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B762A4FD3C
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Mar 2025 12:09:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8D2F3A3E50
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Mar 2025 11:09:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 223D8205515;
	Wed,  5 Mar 2025 11:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="IH7rDbTB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazolkn19010012.outbound.protection.outlook.com [52.103.43.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3A7220469F;
	Wed,  5 Mar 2025 11:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.43.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741172992; cv=fail; b=agr1to+gDOPEuLdVhYkHGVB6jl8gSvooCjGt0IJL0f1GlkMh8owJDAg2l6mPUQsK3OKeYiZXxupnW2QhW4IwdaIivLfg5TvlxHoveh8BZypERNbzDr9vLI1T9cZKeS6P5p7qpZqHazZw33uA1emh8vkAQTfenS0nbqYsxO7U6pI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741172992; c=relaxed/simple;
	bh=DFcLK88b/2pV73cjaEigoedx58Yv92FRIxG2lIqOTec=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=k4ucRC9wl1CFrc09FSULIyqSpvV9KSlcl501R8GK6Y8J5YQN64Z9e8a5RHWfALUiOBPX769bh7fT/alwCm4WGGklsdUfNVqTkY2kAphWZwCMjgpxzoNzp2a6GgOmK2nrxQvPBge0g9nK59kA15e5e3WE2XxfAK+/tO8TVXVkWsI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=IH7rDbTB; arc=fail smtp.client-ip=52.103.43.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DOaM0MRyWFHy+sgtBq6vSlSCv2eRkY5chmXnskEyWY03Eyn7V/zLrLsT7SCnpoHumi23L8Nu+usOSbjNoSphEhFM23Jb6Gw+pZeZsOnOxMLWsGwOsen8ahShq847gvkqgMiikJJg6dhQv/wT0K547RF+Y87Bol2LSM6GOO0x2BRGemKP5SgVmUVBWY0rljZIYp55jocmtBcS1E8tkR10stJA0qQPxzcvZ+B+Yh5iglMrnHqNlzvO0apU9gFC4NHM8VD8Qrq9a18G1GmlErs25vhngwQRHAgrEa636+hrYJp6lwcqbXXUZEUFcHYuIlycieMg21Qi7wVezJ/Vtr8Fgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gsnAZ0vv+qJz5NA6QcQgW/Hu9j/0UHudVfcL9jR4gO8=;
 b=h8DVhhSZU0r60tkiDPFc99hfshKYlSvkWhI/vmZpi0zE4RqKhmr3k5a/DtgjrmTvcCzHspTq/wgukmYt+mvlckCFU2f8PjsoH0H2L33BEuNqZfT02UDUHvUglGm7cAjm7l6Y+kY2AmrqRZ+WT7K8KHfRzN1vORtdpuP0s5lrOgxu9SjVMDKMu/04DU6XTXvv1TCw+Doy6rAzfPkejFrF9hgDLB2Lqkk1Dvz3eaxUXq019ZoonxMTYTifkwUIy1OfJERjsTx16FHhAdaojE4dNQsXQ85zgRWx92lqvO287UErKErEB21nIW5dfmXl30CsOZbElykL/VT9HT4Zcn8Zuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gsnAZ0vv+qJz5NA6QcQgW/Hu9j/0UHudVfcL9jR4gO8=;
 b=IH7rDbTBZkaPI7nzJC02B0zBtDG18aVclTAoegl2Ctxb2V7b0Q0vDpt93OUk6SXcSlJ6Qslamp/xiVpnBG2Ye2th/OsoLqBt+D96T/lhPNk9ha9XxDyFXrz7kqBKhdLoBiaEcq/hYFo7LHxf/ah6slUhKM0WzoNbTE+L18jnxaFWOd5EdaFbJY4bYTAOeNWpN31cyk6A/YOYkyfMtKCUBVADs4ayP1TSr8sDcx0PA0KJVcJEZYbmU2zHcVNsGZaBIruyn5gdcZ+veH4+wX9R25tTPWgwjb4eyriea1VHOvmJPbDjvo4OheSKSQhNfvtvD3Oby1vh9TTiYncOLILBiw==
Received: from TYCPR01MB8437.jpnprd01.prod.outlook.com (2603:1096:400:156::5)
 by TYRPR01MB13931.jpnprd01.prod.outlook.com (2603:1096:405:217::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.29; Wed, 5 Mar
 2025 11:09:44 +0000
Received: from TYCPR01MB8437.jpnprd01.prod.outlook.com
 ([fe80::83e7:751f:f3af:768f]) by TYCPR01MB8437.jpnprd01.prod.outlook.com
 ([fe80::83e7:751f:f3af:768f%5]) with mapi id 15.20.8489.028; Wed, 5 Mar 2025
 11:09:44 +0000
From: Shengyu Qu <wiagn233@outlook.com>
To: nbd@nbd.name,
	lorenzo@kernel.org,
	ryder.lee@mediatek.com,
	shayne.chen@mediatek.com,
	sean.wang@mediatek.com,
	johannes@sipsolutions.net,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	miriam.rachel.korenblit@intel.com,
	nicolas.cavallari@green-communications.fr,
	howard-yh.hsu@mediatek.com,
	greearb@candelatech.com,
	christophe.jaillet@wanadoo.fr,
	benjamin-jw.lin@mediatek.com,
	mingyen.hsieh@mediatek.com,
	quic_adisi@quicinc.com,
	deren.wu@mediatek.com,
	chui-hao.chiu@mediatek.com,
	gustavoars@kernel.org,
	bo.jiao@mediatek.com,
	sujuan.chen@mediatek.com,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Cc: Shengyu Qu <wiagn233@outlook.com>
Subject: [PATCH v8] wifi: mt76: mt7915: add wds support when wed is enabled
Date: Wed,  5 Mar 2025 19:09:37 +0800
Message-ID:
 <TYCPR01MB84374EEAC0DDDA4223B8997298CB2@TYCPR01MB8437.jpnprd01.prod.outlook.com>
X-Mailer: git-send-email 2.48.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PS2PR02CA0051.apcprd02.prod.outlook.com
 (2603:1096:300:5a::15) To TYCPR01MB8437.jpnprd01.prod.outlook.com
 (2603:1096:400:156::5)
X-Microsoft-Original-Message-ID:
 <20250305110937.3516115-1-wiagn233@outlook.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB8437:EE_|TYRPR01MB13931:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a714cd2-d3dd-4714-4532-08dd5bd63ba4
X-MS-Exchange-SLBlob-MailProps:
	Cq7lScuPrnpFX5gNBgVui9nZ6J+Gucr/JPZtvp8w7FGpkKHiDBOWBq45bWWUVhYJ2WtwyEKK6LkspaBULo20Gb7uy7olpMDV18Yq81EbAJFnHQgk7s0PaZ7fL5EsIiiUqHHazNJPqt4QB3wQR4oDbDNlpmUdhshbiK+cMsXfm7h/XoCde5zLRxMWi6+WfIJUodFg6H+k6VX3QuLu/uairkK8YFoaR3/r3As3pxAM094era6f3YC0Kseno4BE37a9uQGhYakqHXM07RV2R77bfix1JWd2bxO4SLS9U0hErUG486as63CwvZ8RS+gQwtSvws3hyIN1tlNwx+PO23ZI0nYXBC85A3DfcsQAonC+Dxt+dtmdKsmhkL/iyNvrrZjqoS3pULbhogV9K8iVKd5uiwxTa6jksySzEgIw2U/S6GbLiTm+ESZ1crUgtFPZwivB7LiYPEG4n657hY0YiUePXezCwlIujKKNoBTI3btjdOYrA3ODNN8+FUCv7m6oqvtfF95/996I/HjoDLhpkT5qGuH+ypqx2H/jI3gzUvPUMBy/Jkk+C0x57lmIun2pL6/uGMrIFUz0iCGtdIhj068nHzJvH24wJwJVoEDWJnAow1Kh/GIaJt0cq7z6qJStzzH54qh9+/xCt1ETYUx9d4KDcjNwwCG7gPDjcIwlCfQv1QKVuXRmnZxAX/B+akkgdIwjXkMb39lVOYT8RuqCzkLCLRu32HDFDWQDyoZTZjJyEs1c/Bvm+VhxmP3GdLjTCY1nON9/K45EISI=
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|15080799006|5062599005|19110799003|5072599009|8060799006|461199028|7092599003|12091999003|19111999003|41001999003|440099028|3412199025|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TDbH6dqMXTI9AYjGt5wVIGx6xukN/Qwd2DuYn7pB619eK9JkqH+4Soj4ScNY?=
 =?us-ascii?Q?FcAOQCK7RDpK/W10pr8ziM3DdvgeY2L+gQQbnXp2rj4lCP3DXhKTYZ2KMfKx?=
 =?us-ascii?Q?sEXBAD5LGrCxij3fdJRP7KPxb45ilD/xxm0ty9fc6bz9XfJ4QCKubqS1tQu/?=
 =?us-ascii?Q?XV2E8w3FIt3DuEtkvzXFKDpG53OqyfP+bMEGHQeiaI1Ukc5k86rVQTqdanHi?=
 =?us-ascii?Q?eTg+Q3wvwGRwUP1huxfKTWZUBz4SrHkAQDvKnpjeUfFtxk4kmJbt/qtCz7kI?=
 =?us-ascii?Q?hj0Vm9+zvfKMKtBsi1bJ6F6tmuw7aERaDDcCDviUjaJe/IVRGP7orx2b1AWW?=
 =?us-ascii?Q?5QUW3e7V/rO2cHkwtY+PfPvWgCnYPxTHXXcG3XkcKdC1Rjrt4Y7sQ6JhXYTA?=
 =?us-ascii?Q?toZodYBYzveoZxrZQauS71HQGupz4qs25iohf0gvikwhlw+x/BB8KJG6+5eL?=
 =?us-ascii?Q?qW0E/j1o9lg3g/tVM2eSCZF8al39CFZjZBkdHEToJGIUzS4Msc8mO94KuMHv?=
 =?us-ascii?Q?5mSJYiWiTT+y3L3hPyIX647xNvvHJvTaruQm+3hK7alNc681eIwcdv5EJAsZ?=
 =?us-ascii?Q?xSS9cvvUJY/NZ+K52mlxwd4P0TWZhoJGz39xo8HFQW/hh10y8FpA9Qxu5uv8?=
 =?us-ascii?Q?98rzttB+14I9FMVGg921PZ4k0X3uxh1Rkarfjt5GKprTvGtJLFg9ZHT0SBSN?=
 =?us-ascii?Q?Ksx2FTX7JTtD8KU5bH4wppm5TsZo53+Bd5sbj92h3tepEPPxIesvRef6K+W3?=
 =?us-ascii?Q?3VjcK/3FmEZ1YKw/QhmyUn6shxHMmBRE4cE+7Pd1L0mrsoo236vIKEl9V3+i?=
 =?us-ascii?Q?VLoW1tYqLzW+DzZXOvane51qeIm9kJsRJr2NePHeOlTM2lYEjFKFSzNKorOo?=
 =?us-ascii?Q?yxIHNH/S+IJN0mX31854FtC4BbPv14ews9GW1J683gIDE3AphVilmcEOL7uc?=
 =?us-ascii?Q?P2VhIhGw4ZZnjhZeGxFS05WRDLJb/tt2rK7jXSg+6T93l+jBCVioiubKSsaO?=
 =?us-ascii?Q?eevHHqIQo+zKJwMebYafwAt8JEBtPgS0ptRDyOEWDbScFRZOBVcZOh4I4U0x?=
 =?us-ascii?Q?3Mu8RucCmomgPNvznF1bK3sb1GFwk0TzRDm5SBMRc+E+BvDXkY2e+ri+LhlM?=
 =?us-ascii?Q?nMD8y0O/o9+pNHeYRF9S82xVYQIay1IZMx1gKHcQSskFEibGAPW7sfnEMliR?=
 =?us-ascii?Q?XRauwmrKf2Lpp1Qa/US9D4g5XVmwEi8lAavfF0hIFghvnKRjEiN9GxycZNI?=
 =?us-ascii?Q?=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?87AgJEU0mjWHYkfvwz9+H2yAOdTQl/1ROUwN+tFWCEMCEv+37LXs8u9ZgL5J?=
 =?us-ascii?Q?A3+Paj43Ju8W1PRSrXWzqi3Thsc4nASAVbAc5Q5WrzKdqQ7Qb+JVzD013AnF?=
 =?us-ascii?Q?CAYHXgnyV3+wErg7kXcfseQ6erR4Tk6sWk/dalxn0M0tAgkrgkMczpEZkKzH?=
 =?us-ascii?Q?qHv1dsJIMkffw9Cu2hunuPyf8sQ8vj8H7nJ1M8FRHGEtrRe+MrMWeg7QNByX?=
 =?us-ascii?Q?jXwiKarPaevEcyN51symC74fbbn8vUXcnmTh8r6UWPTmKNb2hiaQilu8Pfrr?=
 =?us-ascii?Q?ObqCctxgtudzHIsvzv6bKUZJx1270ui3YDvAla3gFwvcyyWM+TjKWanBYVNM?=
 =?us-ascii?Q?cinJcjKOjXiBbuONtnWiAxLfQCdR/NQUwCnbd5RO7xU5ytE0MJDJaxaeZwzU?=
 =?us-ascii?Q?lBkoHf/YXdlqmNQ//+7gtxQJuLvVjBVjEGoUF1vDZxIAhfVVN/SLBMwhpy7z?=
 =?us-ascii?Q?lV+uH0KsUOw8ZbOFHevdsaty4pywuN+kiHOQ3Xcb8XbL3cdYlwEqFkBIumjS?=
 =?us-ascii?Q?RnH1VUE++2yYOCjmcGleptNwhBFDtsWZZ5vqPsxdEgxMkok4BjCjXIPCOQSG?=
 =?us-ascii?Q?7hV/cTh2IxRYAX0l2q0JA2jWK5cWqJi/5Uqxpd9ibwsGC083YYiIFJjZvfoz?=
 =?us-ascii?Q?GTOEhd9VTOhHyFI8UMPREW2tjLahkfLSe0IU95ba9+1Fv65fp8NZlck8Gvxh?=
 =?us-ascii?Q?TBvPoQDhZka5TPc7/r2L+g6a8u8wKu9Y8IexJX72kaBBcsc0aHHthCluE4+X?=
 =?us-ascii?Q?cETTrjN7iMvVM+DebpTXErtQKQTbZOJasDk49nGxxZ5/hrAQfq8gak5pKOYg?=
 =?us-ascii?Q?AuQX2n1XsAlOs3RtziY5DV8PE27cGsyvfx2N6RQ5fDK1gDq0FSFCSMuTOI5u?=
 =?us-ascii?Q?uYao/KTt7WesgwchN7TTsDbJLYljm+BNHc4AV0iPfkoZkEheRmhtGLTjMPLN?=
 =?us-ascii?Q?30uQZw8bNGHCriGYUlBkL0NGmT0r0gb7D+E7QQVSU17VGa2Ztnud3tx/Ys/B?=
 =?us-ascii?Q?Viy/G6gZ5pi1App+UVNaMyohNQT4M7XQl5bkxKOiHk+PYF1yxHy0bP6bmnbw?=
 =?us-ascii?Q?39WT8hhwfsZJiKtfuo2RjaG0l8EdNFojrebMfPTnEAyeDUF9H7QK++EkPCm0?=
 =?us-ascii?Q?G56YKjAEe6ygdg/4hFShqMsuGB3G5rLiVLWqzqrtNyqhp6bvSo1kB6vpN9IN?=
 =?us-ascii?Q?okKlKI57ZfuO2BeN4pThgv2jNkrJeo5EJN/CIFSCBHHZPaI5PghZbu7KhNKI?=
 =?us-ascii?Q?NxOkDKFcfvd9W3+kTNjeVOovBMEjWrvbj9b5NWOAzSycSh7XFUJMnyeFpcJf?=
 =?us-ascii?Q?CjI=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a714cd2-d3dd-4714-4532-08dd5bd63ba4
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB8437.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 11:09:44.3409
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB13931

The current WED only supports 256 wcid, whereas mt7986 can support up to
512 entries, so firmware provides a rule to get sta_info by DA when wcid
is set to 0x3ff by txd. Also, WED provides a register to overwrite txd
wcid, that is, wcid[9:8] can be overwritten by 0x3 and wcid[7:0] is set
to 0xff by host driver.

However, firmware is unable to get sta_info from DA as DA != RA for
4addr cases, so firmware and wifi host driver both use wcid (256 - 271)
and (768 ~ 783) for sync up to get correct sta_info.

Currently WDS+WED config is completely broken on MT7986/7981 devices if
without this patch.

Tested-by: Sujuan Chen <sujuan.chen@mediatek.com>
Co-developed-by: Bo Jiao <bo.jiao@mediatek.com>
Signed-off-by: Bo Jiao <bo.jiao@mediatek.com>
Signed-off-by: Sujuan Chen <sujuan.chen@mediatek.com>
Signed-off-by: Shengyu Qu <wiagn233@outlook.com>
---
Changes since v1:
 - Drop duplicate setting in mmio
 - Reduce the patch size by redefining mt76_wcid_alloc
Changes since v2:
 - Rework wds wcid getting flow
Changes since v3:
 - Rebase to next-20240703
 - Sync with downstream patch
Changes since v4:
 - Rebase to next-20240802
Changes since v5:
 - Fixed build test error reported by robot
 - Rebase to next-20240805
Changes since v6:
 - Fix potential race conditions on tx/rx packets during the transition
 - Rebase to Felix's newest codebase
Changes since v7:
 - Fix build fail
---
 drivers/net/wireless/mediatek/mt76/mt76.h     |  9 ++++
 .../net/wireless/mediatek/mt76/mt7915/main.c  | 45 +++++++++++++++++--
 .../net/wireless/mediatek/mt76/mt7915/mcu.c   | 18 ++++++--
 .../net/wireless/mediatek/mt76/mt7915/mcu.h   |  1 +
 drivers/net/wireless/mediatek/mt76/util.c     | 37 +++++++++++++--
 drivers/net/wireless/mediatek/mt76/util.h     |  7 ++-
 6 files changed, 106 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 132148f7b1070..638ee9fae0c73 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -28,6 +28,9 @@
 
 #define MT76_TOKEN_FREE_THR	64
 
+#define MT76_WED_WDS_MIN    256
+#define MT76_WED_WDS_MAX    272
+
 #define MT_QFLAG_WED_RING	GENMASK(1, 0)
 #define MT_QFLAG_WED_TYPE	GENMASK(4, 2)
 #define MT_QFLAG_WED		BIT(5)
@@ -73,6 +76,12 @@ enum mt76_wed_type {
 	MT76_WED_RRO_Q_IND,
 };
 
+enum mt76_wed_state {
+	MT76_WED_DEFAULT,
+	MT76_WED_ACTIVE,
+	MT76_WED_WDS_ACTIVE,
+};
+
 struct mt76_bus_ops {
 	u32 (*rr)(struct mt76_dev *dev, u32 offset);
 	void (*wr)(struct mt76_dev *dev, u32 offset, u32 val);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/main.c b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
index 3aa31c5cefa6a..c489130b6ae2a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
@@ -745,8 +745,15 @@ int mt7915_mac_sta_add(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 	struct mt7915_vif *mvif = (struct mt7915_vif *)vif->drv_priv;
 	bool ext_phy = mvif->phy != &dev->phy;
 	int idx;
+	u8 flags = MT76_WED_DEFAULT;
 
-	idx = mt76_wcid_alloc(dev->mt76.wcid_mask, MT7915_WTBL_STA);
+	if (mtk_wed_device_active(&dev->mt76.mmio.wed) &&
+	    !is_mt7915(&dev->mt76)) {
+		flags = test_bit(MT_WCID_FLAG_4ADDR, &msta->wcid.flags) ?
+		       MT76_WED_WDS_ACTIVE : MT76_WED_ACTIVE;
+	}
+
+	idx = __mt76_wcid_alloc(mdev->wcid_mask, MT7915_WTBL_STA, flags);
 	if (idx < 0)
 		return -ENOSPC;
 
@@ -1271,6 +1278,10 @@ static void mt7915_sta_set_4addr(struct ieee80211_hw *hw,
 {
 	struct mt7915_dev *dev = mt7915_hw_dev(hw);
 	struct mt7915_sta *msta = (struct mt7915_sta *)sta->drv_priv;
+	int min = MT76_WED_WDS_MIN, max = MT76_WED_WDS_MAX;
+	struct ieee80211_sta *pre_sta;
+	u8 flags = MT76_WED_DEFAULT;
+	int temp_idx;
 
 	if (enabled)
 		set_bit(MT_WCID_FLAG_4ADDR, &msta->wcid.flags);
@@ -1280,6 +1291,30 @@ static void mt7915_sta_set_4addr(struct ieee80211_hw *hw,
 	if (!msta->wcid.sta)
 		return;
 
+	if (mtk_wed_device_active(&dev->mt76.mmio.wed) &&
+	    !is_mt7915(&dev->mt76) &&
+	    (msta->wcid.idx < min || msta->wcid.idx > max - 1)) {
+		pre_sta = kzalloc(sizeof(*sta) + sizeof(*msta), GFP_KERNEL);
+		memmove(pre_sta, sta, sizeof(*sta) + sizeof(*msta));
+
+		flags = test_bit(MT_WCID_FLAG_4ADDR, &msta->wcid.flags) ?
+			MT76_WED_WDS_ACTIVE : MT76_WED_ACTIVE;
+
+		temp_idx = __mt76_wcid_alloc(dev->mt76.wcid_mask, MT7915_WTBL_STA, flags);
+		((struct mt7915_sta *)pre_sta->drv_priv)->wcid.idx = (u16)temp_idx;
+		mt7915_mac_sta_add(&dev->mt76, vif, pre_sta);
+		rcu_assign_pointer(dev->mt76.wcid[temp_idx], &msta->wcid);
+
+		temp_idx = msta->wcid.idx;
+		msta->wcid.idx = ((struct mt7915_sta *)pre_sta->drv_priv)->wcid.idx;
+		((struct mt7915_sta *)pre_sta->drv_priv)->wcid.idx = (u16)temp_idx;
+		rcu_assign_pointer(dev->mt76.wcid[temp_idx], NULL);
+
+		synchronize_rcu();
+		mt7915_mac_sta_remove(&dev->mt76, vif, pre_sta);
+		kfree(pre_sta);
+	}
+
 	mt76_connac_mcu_wtbl_update_hdr_trans(&dev->mt76, vif, sta);
 }
 
@@ -1726,15 +1761,19 @@ mt7915_net_fill_forward_path(struct ieee80211_hw *hw,
 	if (!mtk_wed_device_active(wed))
 		return -ENODEV;
 
-	if (msta->wcid.idx > 0xff)
+	if (msta->wcid.idx > MT7915_WTBL_STA)
 		return -EIO;
 
 	path->type = DEV_PATH_MTK_WDMA;
 	path->dev = ctx->dev;
 	path->mtk_wdma.wdma_idx = wed->wdma_idx;
 	path->mtk_wdma.bss = mvif->mt76.idx;
-	path->mtk_wdma.wcid = is_mt7915(&dev->mt76) ? msta->wcid.idx : 0x3ff;
 	path->mtk_wdma.queue = phy != &dev->phy;
+	if (test_bit(MT_WCID_FLAG_4ADDR, &msta->wcid.flags) ||
+	    is_mt7915(&dev->mt76))
+		path->mtk_wdma.wcid = msta->wcid.idx;
+	else
+		path->mtk_wdma.wcid = 0x3ff;
 
 	ctx->dev = NULL;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index 9d790f234e82c..32c5aa1a361e8 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -2385,10 +2385,20 @@ int mt7915_mcu_init_firmware(struct mt7915_dev *dev)
 
 	mt76_connac_mcu_del_wtbl_all(&dev->mt76);
 
-	if ((mtk_wed_device_active(&dev->mt76.mmio.wed) &&
-	     is_mt7915(&dev->mt76)) ||
-	    !mtk_wed_get_rx_capa(&dev->mt76.mmio.wed))
-		mt7915_mcu_wa_cmd(dev, MCU_WA_PARAM_CMD(CAPABILITY), 0, 0, 0);
+#ifdef CONFIG_NET_MEDIATEK_SOC_WED
+	if (mtk_wed_device_active(&dev->mt76.mmio.wed)) {
+		if (is_mt7915(&dev->mt76) ||
+		    !mtk_wed_get_rx_capa(&dev->mt76.mmio.wed))
+			ret = mt7915_mcu_wa_cmd(dev, MCU_WA_PARAM_CMD(CAPABILITY),
+						0, 0, 0);
+		else
+			ret = mt7915_mcu_wa_cmd(dev, MCU_WA_PARAM_CMD(SET),
+						MCU_WA_PARAM_WED_VERSION,
+						dev->mt76.mmio.wed.rev_id, 0);
+		if (ret)
+			return ret;
+	}
+#endif
 
 	ret = mt7915_mcu_set_mwds(dev, 1);
 	if (ret)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
index 49476a4182fd1..c3dd0cb4a5d38 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
@@ -278,6 +278,7 @@ enum {
 	MCU_WA_PARAM_PDMA_RX = 0x04,
 	MCU_WA_PARAM_CPU_UTIL = 0x0b,
 	MCU_WA_PARAM_RED = 0x0e,
+	MCU_WA_PARAM_WED_VERSION = 0x32,
 	MCU_WA_PARAM_RED_SETTING = 0x40,
 };
 
diff --git a/drivers/net/wireless/mediatek/mt76/util.c b/drivers/net/wireless/mediatek/mt76/util.c
index 95b3dc96e4c45..7fac9c79ebdf3 100644
--- a/drivers/net/wireless/mediatek/mt76/util.c
+++ b/drivers/net/wireless/mediatek/mt76/util.c
@@ -42,9 +42,11 @@ bool ____mt76_poll_msec(struct mt76_dev *dev, u32 offset, u32 mask, u32 val,
 }
 EXPORT_SYMBOL_GPL(____mt76_poll_msec);
 
-int mt76_wcid_alloc(u32 *mask, int size)
+int __mt76_wcid_alloc(u32 *mask, int size, u8 flag)
 {
 	int i, idx = 0, cur;
+	int min = MT76_WED_WDS_MIN;
+	int max = MT76_WED_WDS_MAX;
 
 	for (i = 0; i < DIV_ROUND_UP(size, 32); i++) {
 		idx = ffs(~mask[i]);
@@ -53,16 +55,45 @@ int mt76_wcid_alloc(u32 *mask, int size)
 
 		idx--;
 		cur = i * 32 + idx;
-		if (cur >= size)
+
+		switch (flag) {
+		case MT76_WED_ACTIVE:
+			if (cur >= min && cur < max)
+				continue;
+
+			if (cur >= size) {
+				u32 end = max - min - 1;
+
+				i = min / 32;
+				idx = ffs(~mask[i] & GENMASK(end, 0));
+				if (!idx)
+					goto error;
+				idx--;
+				cur = min + idx;
+			}
+
 			break;
+		case MT76_WED_WDS_ACTIVE:
+			if (cur < min)
+				continue;
+			if (cur >= max)
+				goto error;
+
+			break;
+		default:
+			if (cur >= size)
+				goto error;
+			break;
+		}
 
 		mask[i] |= BIT(idx);
 		return cur;
 	}
 
+error:
 	return -1;
 }
-EXPORT_SYMBOL_GPL(mt76_wcid_alloc);
+EXPORT_SYMBOL_GPL(__mt76_wcid_alloc);
 
 int mt76_get_min_avg_rssi(struct mt76_dev *dev, u8 phy_idx)
 {
diff --git a/drivers/net/wireless/mediatek/mt76/util.h b/drivers/net/wireless/mediatek/mt76/util.h
index 260965dde94cf..99b7263c0a205 100644
--- a/drivers/net/wireless/mediatek/mt76/util.h
+++ b/drivers/net/wireless/mediatek/mt76/util.h
@@ -27,7 +27,12 @@ enum {
 #define MT76_INCR(_var, _size) \
 	(_var = (((_var) + 1) % (_size)))
 
-int mt76_wcid_alloc(u32 *mask, int size);
+int __mt76_wcid_alloc(u32 *mask, int size, u8 flags);
+
+static inline int mt76_wcid_alloc(u32 *mask, int size)
+{
+	return __mt76_wcid_alloc(mask, size, 0);
+}
 
 static inline void
 mt76_wcid_mask_set(u32 *mask, int idx)
-- 
2.48.1


