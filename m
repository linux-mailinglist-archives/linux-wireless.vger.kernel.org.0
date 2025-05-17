Return-Path: <linux-wireless+bounces-23117-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0986CABAC2D
	for <lists+linux-wireless@lfdr.de>; Sat, 17 May 2025 21:53:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB55A3BE68B
	for <lists+linux-wireless@lfdr.de>; Sat, 17 May 2025 19:53:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC4F717E4;
	Sat, 17 May 2025 19:53:33 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from AS8PR03CU001.outbound.protection.outlook.com (mail-westeuropeazolkn19012058.outbound.protection.outlook.com [52.103.33.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 095384B1E77
	for <linux-wireless@vger.kernel.org>; Sat, 17 May 2025 19:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.33.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747511613; cv=fail; b=e7eCr1fBzE0qjWymAcUCAg9SO9/bP2m0dqrCnrc86m9K3Jxz1nUxY7A1bNd04zrvZj/sC+5V8gd3fnhwp9hX91+L0c5ihRQpf07iCVOg2HR91ded+27cMkBiHPOirhhKWV2AM63U0krDi9S1Pp25vq6YGI0Aln1PXuWOUw0Efgw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747511613; c=relaxed/simple;
	bh=76hv7YunkVsRg6pmRwR55eZ5Z+CE/xZY10BMdRSFeYI=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=r1pDjQ1JE/EVV8D2chtxVzRgH8+7/cGXLBEryPgtah+htSdHX/OIeI6wBl1Uh1fbr4wQlxXJU0REe7Ph/cQMYSTIya9jyRZATwHz08F7TU56DnullZGvUhCa2rmxfxKNOgXOsQ7v37zojvrYtdQ7utr0Ffg+I9xekY11x+NJ8Nk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rapan.cz; spf=pass smtp.mailfrom=rapan.cz; arc=fail smtp.client-ip=52.103.33.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rapan.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rapan.cz
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qqhLNeJRxcJDzaP+X//DzinKuFV9BufHOPrA53b1sWIDwPciq53JimQozsBFKdvyzn2s9m09xscqPizly23Wwq9GtCQKQz/D0lAVWIPHy5EF1Pg72kAQdgYJkZ728I4AdHPntgAdtfp+t0BD+MwCUJ01VtV7qqEUD3QFqNlDKBoOQ62QX5Kj8RYg6LIsMLcFRboDTirHIWkasqtrAiljSAbFL7G6YP8TSjspX49VoS5k/6tu6Ec/jd1CL8vBcAqgz3KHl0cDERrDTyyVRf/wpae+GnQB+d7M8D8PGGfscdZ2RtXMUPi7XpIyTqzfNDJhN6pIGKYdn1eQppoqnUZjXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jHhuD+SKvmjhShJufIFkwA+7zxG5vU/4tqpZWnjcCzs=;
 b=fIruKLeg+T56brVIQpRR9eFgw2nUMJbCfduMD8ZHPzCwk2o7ba3A1qHnNtVY3W0+tsbwOGt+QN2corswL6aNoXzzT8pGEErhqbufMk3s5WrNXAf30d7Fo44kbXt1mdfOPhlJP/bFL01GUmNb5mvrcPA5ftS9GFYLne5dG+jISxnBLNw/x63B9NZKc8X4QVPiCwMcVJogU3ALNqVrEBujsJ26ATcn7G3EiX9c4k1tK3gjoAxF1+fMpPj+s0WiydUcRwHJMPC9wAS9L6MBxE5biUSZ4FAH/mcZEeNNGDtwG2uBIP8VvHuGYpIfL58r0NmfLs2lhAZZcDhVtXJ24iOIhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from DB6PR08MB2693.eurprd08.prod.outlook.com (2603:10a6:6:1c::13) by
 DB3PR08MB8841.eurprd08.prod.outlook.com (2603:10a6:10:43c::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.33; Sat, 17 May 2025 19:53:28 +0000
Received: from DB6PR08MB2693.eurprd08.prod.outlook.com
 ([fe80::e6db:6f9a:2c0b:acb7]) by DB6PR08MB2693.eurprd08.prod.outlook.com
 ([fe80::e6db:6f9a:2c0b:acb7%5]) with mapi id 15.20.8722.031; Sat, 17 May 2025
 19:53:27 +0000
From: =?iso-8859-2?Q?David_Rapa=F2?= <david@rapan.cz>
To: "ath11k@lists.infradead.org" <ath11k@lists.infradead.org>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"jjohnson@kernel.org" <jjohnson@kernel.org>, "johannes@sipsolutions.net"
	<johannes@sipsolutions.net>
Subject: [PATCH] ath11k: add support for dynamic vlan (ap/vlan)
Thread-Topic: [PATCH] ath11k: add support for dynamic vlan (ap/vlan)
Thread-Index: AQHbx2OkXnFc6lM2sUO0yo3YvwE4ig==
Date: Sat, 17 May 2025 19:53:27 +0000
Message-ID:
 <DB6PR08MB2693ADF1B27329C7BCED7AA5DF92A@DB6PR08MB2693.eurprd08.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB6PR08MB2693:EE_|DB3PR08MB8841:EE_
x-ms-office365-filtering-correlation-id: 469616d3-b47f-48a9-f30c-08dd957c7df9
x-ms-exchange-slblob-mailprops:
 Cq7lScuPrnoSu68Y5FdRDlCPOBk43FEto4axgr+a4en4tQufMkczX2EmhGRq7gXrBkjdUgei8lfTYkIfBktg5QcU29Joq7mH5PZeZTR3lQoyMejSwKth1Bh/jCLJKMGcaKE5wSVBZtGLxeNzufeeS9MIgt0AbbF6BUk9oZ6sFI718ilYtk9knFCH9HdCFElwQdJOd5zVV6p6YN3RLd+eMrEpxsYO4o/TyV5VFcy8fml04Jf2wKPba15RaV4aTf3LhHC+h8iBD0OCwX+GuNowoXBuSsJ9k0rnjfk/K+NE0OscsiU0WAcPBi03efXcff0UbgsF9bOpbFlkWBDVcPxSNPfcx1AeKvG27TgdfspAyHDwL9kSznI4VBXAY8/joeWGMJX0xjnvW6DLKNTkPi9x2HCm+22weXIr5q3GD+nG9WTdDEeqhUgtFoXaRh4Dkbkj11G+Oev3joWnu1YLGRkISMOVdVhwa/VEqdjxwuf8jlRxTUhj8WvK2yM3mMThGmDQXw3j93UxCd5vDnaGl+5qvSHVzhqtZlqCiIyph90/n5Xj3UOBOXplMseUFZ9lK5PLlrxt7egP92h20Lizsl0s7cf9fgHnqszKxyqVXIS1RSeg/SzuYVrRZFxUpacUCim/QBuIALyLsel4c1nQukZ+3k6Fr7h5xnNm8nxnoXuogtCgbfjF7Fb5Zt6kEagqdkQa3bO8pT6zvpwX+UYoRsYmz+bVBgMtHNF9L1vsiKgVqLuHOFJI9mC3d75pe9P0391e7WP3JxNCH0E=
x-microsoft-antispam:
 BCL:0;ARA:14566002|7072599006|41001999006|19110799006|8062599006|15030799003|7092599006|8060799009|461199028|15080799009|102099032|3412199025|440099028|19111999003|12091999003|1710799026;
x-microsoft-antispam-message-info:
 =?iso-8859-2?Q?F8s1VRlKGScAI8mu2MQGeDeyj70RSK/j8mTjXCoRFQo1K1U1bQmV3xnJ/z?=
 =?iso-8859-2?Q?0S/dBfbmg6v5NtVatZ9xS6kPfeBZgbRUU2DE6K0hZ3ULECzTwKke683Msn?=
 =?iso-8859-2?Q?UR8DosL3/L4gSHP/acOlH4jZkxh8Bdb3Jub9aRL+sZOiKVQaOfHudiiztq?=
 =?iso-8859-2?Q?ctfk1fl4VEJq3d4fRpM+cgJ7SOydQGuFnoUHVJNYeb1TnyN4emqh99org9?=
 =?iso-8859-2?Q?oGE/9rMpu82gWb5ClS01eCDRpV8w0B6KA9zlqMu3jgHxwJ7c57vXhwKc+N?=
 =?iso-8859-2?Q?JWGT1MtKPEW6ZnN1WbcJJ21cRDN/lXTcPYaPH1c2wKjCFioSfJDUiDcivD?=
 =?iso-8859-2?Q?5Ij4UhXk1hTOidnc/gMButs0xQnibj5DFwsXUYU8fFsNbJrmUig4ePh4bm?=
 =?iso-8859-2?Q?m94+aWv/OfjrZkVBRNv7aAoSqViWdfCZJpca+iBLvk08F/CKteBFfxBIQC?=
 =?iso-8859-2?Q?RR5xtAL61DNPwFp3foDpjKGpAiLo3auNxW0fQKOa6mduoESr6uSrnJqq/e?=
 =?iso-8859-2?Q?Oh+Oh9yHSTY2dKS+ZTzs9k+T/c2Rzi0h0uuNzyTrHPboCQBSO9t//vJXEq?=
 =?iso-8859-2?Q?cHEFzr9TuuqZppNlbi2LSrjy2pNc7vywrIR1sdgX/83zXmO0zaVGqMtSg5?=
 =?iso-8859-2?Q?XdTOwvMdzlHmbbk/oKrF5y+s6kRM/IM992j6JIwaN9YmwPCPsosxYeGhaG?=
 =?iso-8859-2?Q?odDyXndwh3nwHr+8GH7lktIkPFvPF0qpTcPNybYuBUkMowa2OBAqa8C6aS?=
 =?iso-8859-2?Q?32KIX4UwbB2RpRUp52H3nx1K6KKSjJiihLBz9QgJ8B2gJYdqqOK/P+TBei?=
 =?iso-8859-2?Q?cqbYx8+wLf0Ko0z7A6KGWrcYtE/sGTXTS2eV/WaFmWDdqUqEgxxDFWSSJK?=
 =?iso-8859-2?Q?3J03ze2K0RSc5dRi2HB921gyLf0PRLIxT1RcUSIoq4hc3eM7YPmCD31NxA?=
 =?iso-8859-2?Q?amkJyjErhfDgqM4/1mJ3PEkIsfR39J0DXWyUAZ8u4txyuIrPrYs72BZtba?=
 =?iso-8859-2?Q?C2fiTxwTjYOSeZJVIFF/Q7hM1BeCJVxR/cMfndDq44rL57Lyzv0SQgWXAE?=
 =?iso-8859-2?Q?k3wE8t7FVil3xqX6CIGa+UJBZUti+qRETJQvfT7UQljFLYPND4hRPzGXHL?=
 =?iso-8859-2?Q?tDwBhSoD8g6106VeydVggcilQPFkjKFuj5VXx6ZBs+wsk30rg5fB1nqQE1?=
 =?iso-8859-2?Q?J+VY+z80lu3gCDkEjTyXvx5u/x3FQaXM0WwCJj1wy1p0ZP0EFxNbLqudlx?=
 =?iso-8859-2?Q?83ua1ZwhbJS6dwgIDyHZg6rrM5QL89CV7Mba8b1+Oopgg43pKEYa6WlK1l?=
 =?iso-8859-2?Q?zxMfzsMTJSuJMfG4RAtyNSAeJP155Ei6HvfAdBaUsHLW4vQ=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-2?Q?KApqZGwXgez58lKMs88nqoaFWZRxnSQ4dqQcD7C78c4kR1wli2ujOkX24z?=
 =?iso-8859-2?Q?LSDpKQSHq1Tf2U+3/mNBpI3AkccPX1VTXCiCc0ZkREMyx6W8KcsfMA3ADa?=
 =?iso-8859-2?Q?6SXn8a3ynW2auvVGUPcCeqE8pj2r70Dw/gzxanOMMp1QnR6rIwU7FShu9v?=
 =?iso-8859-2?Q?4OghYgZiKyCfv462abj621C5OcvsWxMvb4AvGuh89BRD8iFRDbQS36aOPx?=
 =?iso-8859-2?Q?odevsuIwT1N4HA1ekBcbvVFzkF/xFA4ysGQEkDFkhwTMJlaKrytwrnJgIf?=
 =?iso-8859-2?Q?pzUhb24dSyNCV+YRG8V+IZa4AtDb8gO7rmp+91r2cbfy8LkNu6Kck6Ajm/?=
 =?iso-8859-2?Q?ltxzbnm4dJeCcVUn58iID2VaJLX+NfYkqeo6dTqE75Q7brQShtsX1K2eI7?=
 =?iso-8859-2?Q?/fGiWyIPM+lYMmBGO6OhIYxggev4N6YW0vqk5GAEfpTorICa08TqRcG6Ee?=
 =?iso-8859-2?Q?YAlwOlU7PNssUtQppckW4lNsX9KIJVYW4CXAnNE/9JgTNiVHeIRIbUocg2?=
 =?iso-8859-2?Q?UiM6ML1n1Y9H1G27DbQaVKUG/btcB6HNVZ7pzyY2gg1+UZN0jirPrVKAlS?=
 =?iso-8859-2?Q?MLLI9AWV8bOYTXlDgeOWvDTWGUKZ08phzMf+5aLcc5WSjka0+IICUtWBFD?=
 =?iso-8859-2?Q?PpdSNGKJa8ZkQiX3CvMvtsL25A0BgqkeGPs94eo/jzsmvzMw82P4stg0N2?=
 =?iso-8859-2?Q?9uZRt6khpXKAc+vhAz4XW5kWg+Nk0/zxyHO9SUz0lu24dhqGg2UtFVUDLQ?=
 =?iso-8859-2?Q?xMf2+EvL0ew9TXRtyaQMtH/AAD4K+ifyeQbwgm/tWi4jApBy5KnBsFX0q6?=
 =?iso-8859-2?Q?tQ7T5u81CfoaYEncQCS3FWYnFul6+kcsfejjDMGYAOal+tKT7yogXwktTC?=
 =?iso-8859-2?Q?5qQgxD48PeyjNuuGhTC7SrGD20idZlhm4cvYrkjCTXoj3D68VB52wbjrNc?=
 =?iso-8859-2?Q?QDoH2NdvPbuNCP2MN6xEcJehzYIAotV/7Yv55QJt9U+2oorvkjc5jGl52r?=
 =?iso-8859-2?Q?SRXHRSbQNwGGumblkd6a0Ox3ntZLp6SPLZPGVqXVsDelIj8ZP/zAr49Hkz?=
 =?iso-8859-2?Q?hM9bsYbdGal4+LFMVwND2miShWhOIA+Xip+kEpq3dgJOgOxVaFoHD0+7NX?=
 =?iso-8859-2?Q?TVqKEEE6fY8cm8dZzwWeN5/YYQoVTwyehRoxtLsQMI+rnV1Wi6i2zww45P?=
 =?iso-8859-2?Q?qIHPeaSyuBxeHGy24LDJ+fQd9dGwqWKkcHAzzj0UBsC3V3Jb6DBhFBXklH?=
 =?iso-8859-2?Q?QN5iINyo2D7T5X6YXQdzZ7T25YnQHDWzyqU5FfC8GoXQjVVOoY24mTuLzB?=
 =?iso-8859-2?Q?UbaT9HLh8O1Xxt6QBZK4xCc7kw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-de33f.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB6PR08MB2693.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 469616d3-b47f-48a9-f30c-08dd957c7df9
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2025 19:53:27.8479
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR08MB8841

ath11k currently lacks support for dynamic vlan (AP/VLAN), so this patch=0A=
adds feature advertisement in '__ath11k_mac_register' alongside=0A=
all the other neccessary components supporting its function, including=0A=
prerequisites for software encryption of VLAN group traffics.=0A=
VLAN unicast packets shall be taking 8023 xmit path if encapsulation=0A=
offload is enabled and multicast/broadcast then 80211 xmit path.=0A=
=0A=
Metadata info in dp_tx added to notify firmware that the=0A=
multicast/broadcast packets are encrypted in software.=0A=
=0A=
Tested, long-term in production environment using OpenWrt platform=0A=
installed on multiple AX3600 with FT.=0A=
=0A=
Tested-on: IPQ8074 hw2.0 AHB AWLAN.HK.2.9.0.1-01385-QCAHKSWPL_SILICONZ-1=0A=
Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.9.0.1-01977-QCAHKSWPL_SILICONZ-1=0A=
=0A=
Signed-off-by: Seevalamuthu Mariappan <seevalam@codeaurora.org>=0A=
Signed-off-by: David Rapan <david@rapan.cz>=0A=
---=0A=
 drivers/net/wireless/ath/ath11k/core.h  |   1 +=0A=
 drivers/net/wireless/ath/ath11k/dp_tx.c |  79 +++++++++-=0A=
 drivers/net/wireless/ath/ath11k/dp_tx.h | 197 ++++++++++++++++++++++++=0A=
 drivers/net/wireless/ath/ath11k/mac.c   |   3 +=0A=
 net/mac80211/tx.c                       |  19 +++=0A=
 5 files changed, 297 insertions(+), 2 deletions(-)=0A=
=0A=
base-commit: ff8069c7cf3eb0fcd53adebdf341b6aaa98bdd3b=0A=
=0A=
--- a/drivers/net/wireless/ath/ath11k/core.h=0A=
+++ b/drivers/net/wireless/ath/ath11k/core.h=0A=
@@ -120,6 +120,7 @@ struct ath11k_skb_cb {=0A=
 	u32 cipher;=0A=
 	struct ath11k *ar;=0A=
 	struct ieee80211_vif *vif;=0A=
+	u32 pkt_offset;=0A=
 } __packed;=0A=
 =0A=
 struct ath11k_skb_rxcb {=0A=
--- a/drivers/net/wireless/ath/ath11k/dp_tx.c=0A=
+++ b/drivers/net/wireless/ath/ath11k/dp_tx.c=0A=
@@ -79,6 +79,42 @@ enum hal_encrypt_type ath11k_dp_tx_get_e=0A=
 	}=0A=
 }=0A=
 =0A=
+#define HTT_META_DATA_ALIGNMENT	0x8=0A=
+=0A=
+static int ath11k_dp_metadata_align_skb(struct sk_buff *skb, u8 align_len)=
=0A=
+{=0A=
+	if (unlikely(skb_cow_head(skb, align_len)))=0A=
+		return -ENOMEM;=0A=
+=0A=
+	skb_push(skb, align_len);=0A=
+	memset(skb->data, 0, align_len);=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+static int ath11k_dp_prepare_htt_metadata(struct sk_buff *skb,=0A=
+					 u8 *htt_metadata_size)=0A=
+{=0A=
+	u8 htt_desc_size;=0A=
+	/* Size rounded of multiple of 8 bytes */=0A=
+	u8 htt_desc_size_aligned;=0A=
+	int ret;=0A=
+	struct htt_tx_msdu_desc_ext *desc_ext;=0A=
+=0A=
+	htt_desc_size =3D sizeof(struct htt_tx_msdu_desc_ext);=0A=
+	htt_desc_size_aligned =3D ALIGN(htt_desc_size, HTT_META_DATA_ALIGNMENT);=
=0A=
+=0A=
+	ret =3D ath11k_dp_metadata_align_skb(skb, htt_desc_size_aligned);=0A=
+	if (unlikely(ret))=0A=
+		return ret;=0A=
+=0A=
+	desc_ext =3D (struct htt_tx_msdu_desc_ext *)skb->data;=0A=
+	desc_ext->valid_encrypt_type =3D 1;=0A=
+	desc_ext->encrypt_type =3D 0;=0A=
+	desc_ext->host_tx_desc_pool =3D 1;=0A=
+	*htt_metadata_size =3D htt_desc_size_aligned;=0A=
+	return 0;=0A=
+}=0A=
+=0A=
 int ath11k_dp_tx(struct ath11k *ar, struct ath11k_vif *arvif,=0A=
 		 struct ath11k_sta *arsta, struct sk_buff *skb)=0A=
 {=0A=
@@ -97,6 +133,9 @@ int ath11k_dp_tx(struct ath11k *ar, stru=0A=
 	u32 ring_selector =3D 0;=0A=
 	u8 ring_map =3D 0;=0A=
 	bool tcl_ring_retry;=0A=
+	bool is_diff_encap =3D false;=0A=
+	u8 align_pad;=0A=
+	u8 htt_meta_size =3D 0;=0A=
 =0A=
 	if (unlikely(test_bit(ATH11K_FLAG_CRASH_FLUSH, &ar->ab->dev_flags)))=0A=
 		return -ESHUTDOWN;=0A=
@@ -189,7 +228,10 @@ tcl_ring_sel:=0A=
 =0A=
 	switch (ti.encap_type) {=0A=
 	case HAL_TCL_ENCAP_TYPE_NATIVE_WIFI:=0A=
-		ath11k_dp_tx_encap_nwifi(skb);=0A=
+		if (arvif->vif->offload_flags & IEEE80211_OFFLOAD_ENCAP_ENABLED)=0A=
+			is_diff_encap =3D true;=0A=
+		else=0A=
+			ath11k_dp_tx_encap_nwifi(skb);=0A=
 		break;=0A=
 	case HAL_TCL_ENCAP_TYPE_RAW:=0A=
 		if (!test_bit(ATH11K_FLAG_RAW_MODE, &ab->dev_flags)) {=0A=
@@ -208,6 +250,33 @@ tcl_ring_sel:=0A=
 		goto fail_remove_idr;=0A=
 	}=0A=
 =0A=
+	/* Add metadata for software encryption of vlan group traffic */=0A=
+	if ((!test_bit(ATH11K_FLAG_HW_CRYPTO_DISABLED, &ar->ab->dev_flags) &&=0A=
+	    !(info->control.flags & IEEE80211_TX_CTL_HW_80211_ENCAP) &&=0A=
+	    !info->control.hw_key && ieee80211_has_protected(hdr->frame_control))=
 ||=0A=
+	    (skb->protocol =3D=3D cpu_to_be16(ETH_P_PAE) && is_diff_encap)) {=0A=
+		/* HW requirement is that metadata should always point to a=0A=
+		 * 8-byte aligned address. So we add alignment pad to start of=0A=
+		 * buffer. HTT Metadata should be ensured to be multiple of 8-bytes=0A=
+		 * to get 8-byte aligned start address along with align_pad added=0A=
+		 */=0A=
+		align_pad =3D ((unsigned long)skb->data) & (HTT_META_DATA_ALIGNMENT - 1)=
;=0A=
+		ret =3D ath11k_dp_metadata_align_skb(skb, align_pad);=0A=
+		if (unlikely(ret))=0A=
+			goto fail_remove_idr;=0A=
+=0A=
+		ti.pkt_offset +=3D align_pad;=0A=
+		ret =3D ath11k_dp_prepare_htt_metadata(skb, &htt_meta_size);=0A=
+		if (unlikely(ret))=0A=
+			goto fail_remove_idr;=0A=
+=0A=
+		ti.pkt_offset +=3D htt_meta_size;=0A=
+		ti.meta_data_flags |=3D HTT_TCL_META_DATA_VALID_HTT;=0A=
+		ti.flags0 |=3D FIELD_PREP(HAL_TCL_DATA_CMD_INFO1_TO_FW, 1);=0A=
+		ti.encap_type =3D HAL_TCL_ENCAP_TYPE_RAW;=0A=
+		ti.encrypt_type =3D HAL_ENCRYPT_TYPE_OPEN;=0A=
+	}=0A=
+=0A=
 	ti.paddr =3D dma_map_single(ab->dev, skb->data, skb->len, DMA_TO_DEVICE);=
=0A=
 	if (unlikely(dma_mapping_error(ab->dev, ti.paddr))) {=0A=
 		atomic_inc(&ab->soc_stats.tx_err.misc_fail);=0A=
@@ -216,7 +285,8 @@ tcl_ring_sel:=0A=
 		goto fail_remove_idr;=0A=
 	}=0A=
 =0A=
-	ti.data_len =3D skb->len;=0A=
+	ti.data_len =3D skb->len - ti.pkt_offset;=0A=
+	skb_cb->pkt_offset =3D ti.pkt_offset;=0A=
 	skb_cb->paddr =3D ti.paddr;=0A=
 	skb_cb->vif =3D arvif->vif;=0A=
 	skb_cb->ar =3D ar;=0A=
@@ -272,6 +342,8 @@ fail_unmap_dma:=0A=
 	dma_unmap_single(ab->dev, ti.paddr, ti.data_len, DMA_TO_DEVICE);=0A=
 =0A=
 fail_remove_idr:=0A=
+	if (ti.pkt_offset)=0A=
+		skb_pull(skb, ti.pkt_offset);=0A=
 	spin_lock_bh(&tx_ring->tx_idr_lock);=0A=
 	idr_remove(&tx_ring->txbuf_idr,=0A=
 		   FIELD_GET(DP_TX_DESC_ID_MSDU_ID, ti.desc_id));=0A=
@@ -348,6 +420,10 @@ ath11k_dp_tx_htt_tx_complete_buf(struct=0A=
 		return;=0A=
 	}=0A=
 =0A=
+	if (skb_cb->pkt_offset)=0A=
+		/* Removing the alignment and htt meta data */=0A=
+		skb_pull(msdu, skb_cb->pkt_offset);=0A=
+=0A=
 	memset(&info->status, 0, sizeof(info->status));=0A=
 =0A=
 	if (ts->acked) {=0A=
--- a/drivers/net/wireless/ath/ath11k/dp_tx.h=0A=
+++ b/drivers/net/wireless/ath/ath11k/dp_tx.h=0A=
@@ -17,6 +17,203 @@ struct ath11k_dp_htt_wbm_tx_status {=0A=
 	u16 peer_id;=0A=
 };=0A=
 =0A=
+/* htt_tx_msdu_desc_ext=0A=
+ *=0A=
+ * valid_pwr=0A=
+ *		If set, tx pwr spec is valid=0A=
+ *=0A=
+ * valid_mcs_mask=0A=
+ *		If set, tx MCS mask is valid=0A=
+ *=0A=
+ * valid_nss_mask=0A=
+ *		If set, tx Nss mask is valid=0A=
+ *=0A=
+ * valid_preamble_type=0A=
+ *		If set, tx preamble spec is valid=0A=
+ *=0A=
+ * valid_retries=0A=
+ *		If set, tx retries spec is valid=0A=
+ *=0A=
+ * valid_bw_info=0A=
+ *		If set, tx dyn_bw and bw_mask are valid=0A=
+ *=0A=
+ * valid_guard_interval=0A=
+ *		If set, tx guard intv spec is valid=0A=
+ *=0A=
+ * valid_chainmask=0A=
+ *		If set, tx chainmask is valid=0A=
+ *=0A=
+ * valid_encrypt_type=0A=
+ *		If set, encrypt type is valid=0A=
+ *=0A=
+ * valid_key_flags=0A=
+ *		If set, key flags is valid=0A=
+ *=0A=
+ * valid_expire_tsf=0A=
+ *		If set, tx expire TSF spec is valid=0A=
+ *=0A=
+ * valid_chanfreq=0A=
+ *		If set, chanfreq is valid=0A=
+ *=0A=
+ * is_dsrc=0A=
+ *		If set, MSDU is a DSRC frame=0A=
+ *=0A=
+ * guard_interval=0A=
+ *		0.4us, 0.8us, 1.6us, 3.2us=0A=
+ *=0A=
+ * encrypt_type=0A=
+ *		0 =3D NO_ENCRYPT,=0A=
+ *		1 =3D ENCRYPT,=0A=
+ *		2 ~ 3 - Reserved=0A=
+ *=0A=
+ * retry_limit=0A=
+ *		Specify the maximum number of transmissions, including the=0A=
+ *		initial transmission, to attempt before giving up if no ack=0A=
+ *		is received.=0A=
+ *		If the tx rate is specified, then all retries shall use the=0A=
+ *		same rate as the initial transmission.=0A=
+ *		If no tx rate is specified, the target can choose whether to=0A=
+ *		retain the original rate during the retransmissions, or to=0A=
+ *		fall back to a more robust rate.=0A=
+ *=0A=
+ * use_dcm_11ax=0A=
+ *		If set, Use Dual subcarrier modulation.=0A=
+ *		Valid only for 11ax preamble types HE_SU=0A=
+ *		and HE_EXT_SU=0A=
+ *=0A=
+ * ltf_subtype_11ax=0A=
+ *		Takes enum values of htt_11ax_ltf_subtype_t=0A=
+ *		Valid only for 11ax preamble types HE_SU=0A=
+ *		and HE_EXT_SU=0A=
+ *=0A=
+ * dyn_bw=0A=
+ *		0 =3D static bw, 1 =3D dynamic bw=0A=
+ *=0A=
+ * bw_mask=0A=
+ *		Valid only if dyn_bw =3D=3D 0 (static bw).=0A=
+ *=0A=
+ * host_tx_desc_pool=0A=
+ *		If set, Firmware allocates tx_descriptors=0A=
+ *		in WAL_BUFFERID_TX_HOST_DATA_EXP,instead=0A=
+ *		of WAL_BUFFERID_TX_TCL_DATA_EXP.=0A=
+ *		Use cases:=0A=
+ *		Any time firmware uses TQM-BYPASS for Data=0A=
+ *		TID, firmware expect host to set this bit.=0A=
+ *=0A=
+ * power=0A=
+ *		Unit of the power field is 0.5 dbm=0A=
+ *		signed value ranging from -64dbm to 63.5 dbm=0A=
+ *=0A=
+ * mcs_mask=0A=
+ *		mcs bit mask of 0 ~ 11=0A=
+ *		Setting more than one MCS isn't currently=0A=
+ *		supported by the target but is supported=0A=
+ *		in the interface in case in the future=0A=
+ *		the target supports specifications of=0A=
+ *		a limited set of MCS values.=0A=
+ *=0A=
+ * nss_mask=0A=
+ *		Nss bit mask 0 ~ 7=0A=
+ *		Setting more than one Nss isn't currently=0A=
+ *		supported by the target but is supported=0A=
+ *		in the interface in case in the future=0A=
+ *		the target supports specifications of=0A=
+ *		a limited set of Nss values.=0A=
+ *=0A=
+ * pream_type=0A=
+ *		Preamble types=0A=
+ *=0A=
+ * update_peer_cache=0A=
+ *		When set these custom values will be=0A=
+ *		used for all packets, until the next=0A=
+ *		update via this ext header.=0A=
+ *		This is to make sure not all packets=0A=
+ *		need to include this header.=0A=
+ *=0A=
+ * chain_mask=0A=
+ *		Specify which chains to transmit from=0A=
+ *=0A=
+ * key_flags=0A=
+ *		Key Index and related flags - used in mesh mode=0A=
+ *=0A=
+ * chanfreq=0A=
+ *		Channel frequency: This identifies the desired channel=0A=
+ *		frequency (in MHz) for tx frames. This is used by FW to help=0A=
+ *		determine when it is safe to transmit or drop frames for=0A=
+ *		off-channel operation.=0A=
+ *		The default value of zero indicates to FW that the corresponding=0A=
+ *		VDEV's home channel (if there is one) is the desired channel=0A=
+ *		frequency.=0A=
+ *=0A=
+ * expire_tsf_lo=0A=
+ *		tx expiry time (TSF) LSBs=0A=
+ *=0A=
+ * expire_tsf_hi=0A=
+ *		tx expiry time (TSF) MSBs=0A=
+ *=0A=
+ * learning_frame=0A=
+ *		When this flag is set, this frame will be dropped by FW=0A=
+ *		rather than being enqueued to the Transmit Queue Manager (TQM) HW.=0A=
+ *=0A=
+ * send_as_standalone=0A=
+ *		This will indicate if the msdu needs to be sent as a singleton PPDU,=
=0A=
+ *		i.e. with no A-MSDU or A-MPDU aggregation.=0A=
+ *		The scope is extended to other use-cases.=0A=
+ *=0A=
+ * is_host_opaque_valid=0A=
+ *		Set this bit to 1 if the host_opaque_cookie is populated=0A=
+ *		with valid information.=0A=
+ *=0A=
+ * host_opaque_cookie=0A=
+ *		Host opaque cookie for special frames=0A=
+ */=0A=
+struct htt_tx_msdu_desc_ext {=0A=
+	u32=0A=
+		valid_pwr            :  1,=0A=
+		valid_mcs_mask       :  1,=0A=
+		valid_nss_mask       :  1,=0A=
+		valid_preamble_type  :  1,=0A=
+		valid_retries        :  1,=0A=
+		valid_bw_info        :  1,=0A=
+		valid_guard_interval :  1,=0A=
+		valid_chainmask      :  1,=0A=
+		valid_encrypt_type   :  1,=0A=
+		valid_key_flags      :  1,=0A=
+		valid_expire_tsf     :  1,=0A=
+		valid_chanfreq       :  1,=0A=
+		is_dsrc              :  1,=0A=
+		guard_interval       :  2,=0A=
+		encrypt_type         :  2,=0A=
+		retry_limit          :  4,=0A=
+		use_dcm_11ax         :  1,=0A=
+		ltf_subtype_11ax     :  2,=0A=
+		dyn_bw               :  1,=0A=
+		bw_mask              :  6,=0A=
+		host_tx_desc_pool    :  1;=0A=
+	u32=0A=
+		power                :  8,=0A=
+		mcs_mask             : 12,=0A=
+		nss_mask             :  8,=0A=
+		pream_type           :  3,=0A=
+		update_peer_cache    :  1;=0A=
+	u32=0A=
+		chain_mask           :  8,=0A=
+		key_flags            :  8,=0A=
+		chanfreq             : 16;=0A=
+=0A=
+	u32 expire_tsf_lo;=0A=
+	u32 expire_tsf_hi;=0A=
+=0A=
+	u32=0A=
+		learning_frame       :  1,=0A=
+		send_as_standalone   :  1,=0A=
+		is_host_opaque_valid :  1,=0A=
+		rsvd0                : 29;=0A=
+	u32=0A=
+		host_opaque_cookie   : 16,=0A=
+		rsvd1                : 16;=0A=
+} __packed;=0A=
+=0A=
 void ath11k_dp_tx_update_txcompl(struct ath11k *ar, struct hal_tx_status *=
ts);=0A=
 int ath11k_dp_tx_htt_h2t_ver_req_msg(struct ath11k_base *ab);=0A=
 int ath11k_dp_tx(struct ath11k *ar, struct ath11k_vif *arvif,=0A=
--- a/drivers/net/wireless/ath/ath11k/mac.c=0A=
+++ b/drivers/net/wireless/ath/ath11k/mac.c=0A=
@@ -10324,6 +10324,9 @@ static int __ath11k_mac_register(struct=0A=
 		goto err_free_if_combs;=0A=
 	}=0A=
 =0A=
+	ar->hw->wiphy->interface_modes |=3D BIT(NL80211_IFTYPE_AP_VLAN);=0A=
+	ar->hw->wiphy->software_iftypes |=3D BIT(NL80211_IFTYPE_AP_VLAN);=0A=
+=0A=
 	if (!ab->hw_params.supports_monitor)=0A=
 		/* There's a race between calling ieee80211_register_hw()=0A=
 		 * and here where the monitor mode is enabled for a little=0A=
--- a/net/mac80211/tx.c=0A=
+++ b/net/mac80211/tx.c=0A=
@@ -40,6 +40,10 @@=0A=
 =0A=
 /* misc utils */=0A=
 =0A=
+static void ieee80211_8023_xmit(struct ieee80211_sub_if_data *sdata,=0A=
+				struct net_device *dev, struct sta_info *sta,=0A=
+				struct ieee80211_key *key, struct sk_buff *skb);=0A=
+=0A=
 static __le16 ieee80211_duration(struct ieee80211_tx_data *tx,=0A=
 				 struct sk_buff *skb, int group_addr,=0A=
 				 int next_frag_len)=0A=
@@ -4257,6 +4261,8 @@ void __ieee80211_subif_start_xmit(struct=0A=
 {=0A=
 	struct ieee80211_sub_if_data *sdata =3D IEEE80211_DEV_TO_SUB_IF(dev);=0A=
 	struct ieee80211_local *local =3D sdata->local;=0A=
+	struct ieee80211_sub_if_data *ap_sdata;=0A=
+	struct ieee80211_key *key =3D NULL;=0A=
 	struct sta_info *sta;=0A=
 	struct sk_buff *next;=0A=
 	int len =3D skb->len;=0A=
@@ -4281,5 +4287,18 @@ void __ieee80211_subif_start_xmit(struct=0A=
 	if (IS_ERR(sta))=0A=
 		sta =3D NULL;=0A=
 =0A=
+	if (sdata->vif.type =3D=3D NL80211_IFTYPE_AP_VLAN) {=0A=
+		ap_sdata =3D container_of(sdata->bss,=0A=
+				 struct ieee80211_sub_if_data, u.ap);=0A=
+		if (ap_sdata->vif.offload_flags & IEEE80211_OFFLOAD_ENCAP_ENABLED &&=0A=
+		   !is_multicast_ether_addr(skb->data)) {=0A=
+			if (sta)=0A=
+				key =3D rcu_dereference(sta->ptk[sta->ptk_idx]);=0A=
+			ieee80211_8023_xmit(sdata, dev, sta, key, skb);=0A=
+			rcu_read_unlock();=0A=
+			return;=0A=
+		}=0A=
+	}=0A=
+=0A=
 	skb_set_queue_mapping(skb, ieee80211_select_queue(sdata, sta, skb));=0A=
 	ieee80211_aggr_check(sdata, sta, skb);=0A=

