Return-Path: <linux-wireless+bounces-23724-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 253BDACE726
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Jun 2025 01:22:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 677701893E90
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Jun 2025 23:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E11D326FD99;
	Wed,  4 Jun 2025 23:22:45 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03olkn2096.outbound.protection.outlook.com [40.92.57.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66896224AF2
	for <linux-wireless@vger.kernel.org>; Wed,  4 Jun 2025 23:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.57.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749079365; cv=fail; b=eItD7MB6oGzVy3gTMOQfsy3qVXJFq6fUtu1+uBre7Rkm3jiA1pAgcaMcvQGkXU+lpFIeRYK3qB1Xn8Cm3Qqvp1nmyVoLXrcK7zUaq/eUBmKm5pcQ9CZoc4VLKbz3K2SU6v7YiA0kuuIgARUUvfaoZjmKa/GnSfXk4mXsutCZ+ss=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749079365; c=relaxed/simple;
	bh=T8WSp6IYDqH0HtJ4F+z9k6Mab26dqOPTOjqXn2fJ3UE=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=d6qC5blKz9nCV7B5X2i3zyW/lsUfAOY4quDQDCQ8u1KruSV4LMdX04fIVkpXBJOtGdgIS/M9rBabGPISHVnTf3wgu0O82PShTGrYDu+UtIIAaXkd0JGrjkjCoeFLr7H/iFla7iEyXAldMkm32sATQ6Q932nns+XXTu7nW8mTBKM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rapan.cz; spf=pass smtp.mailfrom=rapan.cz; arc=fail smtp.client-ip=40.92.57.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rapan.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rapan.cz
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LM8i52ngU04wt0xXbp98Cw+DXs2mLa/gp+7QD1rjg9QQh4nKeqYJSb3L7OEclC9jVmWu14pFEQ+umfow3e2bsgJMqzhoECrzK8dRWy434RaPqkzJbyX6svEbwDRNAthNEdKgV//5dTQJeYpZELvSoC7ZNfDr0TVib5v3uOXfqDb2Bq9zTKcNIogYhAAkDyJ+tmV+gvAqg8Js0qsYg9k7LSU3oVWZdds6XB7y/yecrVv7fAtB2eqn0HuXlZb0PiaiGF33ID9e1JoyaUR6xh3GvZML3oMLO+gYRgZLTQjnQN///+idM0HJfZiQ21qy/xcyc9jwS/hh3xD6sMH59K72Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SK1/K6ke2CEQvsCvAYcqSuQ4JCsnLN/zqUf5AK04VgQ=;
 b=uqI7XJY9jvK52BclyCr+qcqx9dDiEyNwW0yQ32Ujylw7qY3Xoxxs+VPiLUoM5vWZgSbcCBv5Yk2e44e4yrJXpyZ/JpTucrEvovcqsvMSEYXE/b31XfnzGixjmLUg1p6FyS0ag3chp7CwLpiLCGMoZ8StfO+tZdUZmrGan58pWsa1X99OgxrMvDsmfbdb7OvqPh/RULM2JkvIj8fyYZJ9IyxbrKbbqKAubwT+qgkfeAk7fOWddFlo8hZ3AgYy8VR2liBuJ0gNC+m8oAHqjqs1jhpYcReanMAQjkwrpFVQ/gyyisDAmuKHG6O15UqRJKORlPd6/rl5Z8rKNA9KVYDyTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from DB6PR08MB2693.eurprd08.prod.outlook.com (2603:10a6:6:1c::13) by
 FRZPR08MB11191.eurprd08.prod.outlook.com (2603:10a6:d10:136::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Wed, 4 Jun
 2025 23:22:38 +0000
Received: from DB6PR08MB2693.eurprd08.prod.outlook.com
 ([fe80::e6db:6f9a:2c0b:acb7]) by DB6PR08MB2693.eurprd08.prod.outlook.com
 ([fe80::e6db:6f9a:2c0b:acb7%5]) with mapi id 15.20.8769.033; Wed, 4 Jun 2025
 23:22:37 +0000
From: =?iso-8859-2?Q?David_Rapa=F2?= <david@rapan.cz>
To: "ath11k@lists.infradead.org" <ath11k@lists.infradead.org>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"jjohnson@kernel.org" <jjohnson@kernel.org>, "johannes@sipsolutions.net"
	<johannes@sipsolutions.net>
Subject: [PATCH v3 RESEND] ath11k: add support for dynamic vlan (ap/vlan)
Thread-Topic: [PATCH v3 RESEND] ath11k: add support for dynamic vlan (ap/vlan)
Thread-Index: AQHb1adfoTFPcIeVW0mmho0YmcrzaQ==
Date: Wed, 4 Jun 2025 23:22:37 +0000
Message-ID:
 <DB6PR08MB2693F4C5448E5911E9560E4ADF6CA@DB6PR08MB2693.eurprd08.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB6PR08MB2693:EE_|FRZPR08MB11191:EE_
x-ms-office365-filtering-correlation-id: f6f72086-9b88-43a8-12b0-08dda3beb1b4
x-ms-exchange-slblob-mailprops:
 30ekHghIwFqEAsnBe6Mts21oemuWkGZz7K7wSG4CLOM74a9Z/Bst5F8tjCVO2nbAh6AKapW1N3ua+nmHDkgKnTAYZb92rIz5ou9yiBWF10CAnj2fh9B4+7oWz4xM9zuK8kxFlKpv+yIVpd1SxoS3rLSPQH21zr2bMf7Hei4vN96FPIl9rLl3lTZnlkkdpTrMvmjhQQW1tAiMG7IO6SOdUA63z8vDRFgCwU66ZMaRF4qfXKrTtEZiqjFyxmGQTecOzYyv8EO3NC7JHDLrXE82h/x12gNv7iXtWnr7aagEKRlK9upfPyDaXyYam3X3bFJyz5j3bUwx32keR+9BvFSJHNi8+Q1IQ3dnWpMNORen3RxrgNuEcUqrB2d5r8pMrv7NxECGraPn0+eRA1l9+BHHxEZ7VkvmREEPKqU17FlX+DUpZT4hm1StSXkyh5+1LlZMj6cSuHeJTvXR0GN3lgDNsYZINYnvX7VeBdsbvxBMHW72BfI9SDIgTVC6tJXaievqV/qgYWYbdX9C0afdkWiwD2J301z5n1l/+p9LMCW9ZpNdIZVCMi1oHf4FutfJQNt0GEwHvJYaoncRloLNIbZRVC3hcDLhnhsIhOBX+9b0efKnQKdUnw8LbHCYKn9UwyLIcTe7beK8ZFYLrVClacK2JfqS1MWs5F63XJkQHD60DZi5d0bQqUd0lnm1FK8UYHSBXaPlsL2Yi0qbeW+Sp/1sZ/HWC88K9+8/gdNOZf0GLfIlpZLOQ8LMokXEYtgMamHJ
x-microsoft-antispam:
 BCL:0;ARA:14566002|8062599006|461199028|7072599006|41001999006|8060799009|7092599006|15030799003|15080799009|19110799006|3412199025|440099028|102099032|19111999003|12091999003;
x-microsoft-antispam-message-info:
 =?iso-8859-2?Q?vIffQ3N5k2yY1bhoEhUOe+MGpDSndqa+bDBuGuxiYXSB1Lw18fhCGEiS0s?=
 =?iso-8859-2?Q?YA73Nw6yc8ZK/p0S/z9DwDZjG6Z1H1pE1ONTXkJRP+SG5pVD7VFHqBH4hv?=
 =?iso-8859-2?Q?/Mi78L2pGjvL5C10qrBEIvPCl3WEwrt74ADHcoZDKzQZxqBDnuL1FVe2ST?=
 =?iso-8859-2?Q?VnIc4AosErG8t0FVIAVnvyOZueDfYoUjLoqqGkpL4+XJHthdBUzoT5ffmS?=
 =?iso-8859-2?Q?EvBsUUt1gJeHqefo8rKkKwjjAwNbmQ5BdjfsLjLXhXObdsfad698NRibxt?=
 =?iso-8859-2?Q?qdgkuQirq+K1ss87Hbv0c7NX/kZ+eAJ+xEi/VIUguCeboPOsTwQ6Tr9bd/?=
 =?iso-8859-2?Q?X7d1/HU7Ey2xPSF/dHSgOCcvStHBcMdEexG5S1tu93+GilvYqlDITR50kE?=
 =?iso-8859-2?Q?broilHkQWc618vyTcEih6yxN4k+7wd/kiF7MmPzhXqrM/LiNyBxpj1Cb+N?=
 =?iso-8859-2?Q?nsBoBweMQ6ShyQSyrwYnemjZlS/p67wF+CB4sAwTluyOevQpxNV7mu4eF5?=
 =?iso-8859-2?Q?PDiPbVbn9vKrrUDFJl/MphUPkgla2MZCbKjg65z7yCEfVdFz3JUk8Dz3t1?=
 =?iso-8859-2?Q?ixFfPSsMNT09vDnyLLC4xMeybkEF1N0+HhqywP5Gr9OYi8b/1vWd8kKUjs?=
 =?iso-8859-2?Q?pXbKiSigSO8EbgWy6Vb8M2/xcva7rRVOr6kY6xyN405frIrkhQLsn9PLNW?=
 =?iso-8859-2?Q?74NPXrEtMDxDmACYMoW3FFVti2NPLImZcESgfBqf5YdGlyg1QvLP85MTVl?=
 =?iso-8859-2?Q?6oL4BpfMwOVdlbcI0Lw7InsQvMleC5RGiL+4AIVg1Mhl1vI60nTiB1F5BN?=
 =?iso-8859-2?Q?7zSkOmqUb479rCNXAGs7EFNrFUKZGscYojfkoex8Z4FOoELgmVgjA1lBeM?=
 =?iso-8859-2?Q?A2CMjXJszcIa7Ldj+TCVV1j7OO3JQNjMjkcPHqvHx8tSPER2tAUEJdDo7c?=
 =?iso-8859-2?Q?udRL0/JKKvI5POwdGpWCiIFkzglmKnMW2NM9B1gp5hymlZOIuNTaI4h2T3?=
 =?iso-8859-2?Q?pnkYp9YA55aZ/dfxABdv7SSGXTnNYczoXm7y7djfKbU3ljDxbk5a2URAlu?=
 =?iso-8859-2?Q?y1nG6oeprDrc3B0wmoKFAdulAo5XuoUpfrG+aORA7sFGdkUmFjKRuqOTZn?=
 =?iso-8859-2?Q?GJLQsyfib3Il7wSqiEfTHsOETV7BS4+LcaDExhvY8VIcfpv40cp7P1KZTb?=
 =?iso-8859-2?Q?L0UooqBasZDkfaHMbKb40522gIgzGQXN7SCDlfZ9qS7nNRQAfMWiJibInI?=
 =?iso-8859-2?Q?Hw4SlqmGnJLE4R+zmA0TvHpi3UrqdN7P059BkSGGIYkT4/0905MrJdjHaE?=
 =?iso-8859-2?Q?DZcakfFt2MK5B2imX602xVCCkw=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-2?Q?8po0YLPHGHZUoEeIeGwFW/uuQpAzQRjgp1RktRaxtAo9Kh9YIwEPA4vWr4?=
 =?iso-8859-2?Q?ftGYJDeVAY+kE0xGFOqXrtPGb/9ACEMvxxxzmWpPLipDEByOYJGaq+b8yU?=
 =?iso-8859-2?Q?XCcPcEsZw6oXqTnZrQ3/q4rapRySEGHW2Xs8cmZxiYWlBs+fq4k5+QQcSa?=
 =?iso-8859-2?Q?vaH3EV8aKhWcM4XAJlAqqhROnWZoRtjSqnSflo9tPGWWErye/Fanm04Cxq?=
 =?iso-8859-2?Q?lxvREKIlgtq0AgOO3ZxilradvDpoTXv5UOS+nGFVwJbA+16A9cpNMY8Nc7?=
 =?iso-8859-2?Q?swsrojMQ8Ot/rLv7SixQAbyCgltnkuAjAu0IpU+BQ1OYCKU/sWYng5PE0k?=
 =?iso-8859-2?Q?ZiO4TSSSj/dlVPU1FLktRv12TBleS6GPEezyAB0kuuwv8QbNSpr9KN5y9W?=
 =?iso-8859-2?Q?9gMgHrCBSwODoHULIct4Kuy38Dn8cSLM7qHvpinfXk6CbCD/sjEUS6X9eL?=
 =?iso-8859-2?Q?tDlbIk4fbhT0eJJOgzujjTO/tVJgOiehycTx0Y5nN/oTjLM5ebfRO05SYB?=
 =?iso-8859-2?Q?tbecF/BM5Y2+UQhe4F4K3b1Koi3vNaPoRvTLaay/kl5K9IzWpjHMiXo/yB?=
 =?iso-8859-2?Q?aSHsNR17qfmZAg8G+Rm7DQr8bt6pmNQ0qmHKOa0Xk2eV0N9wF+HX0HgrrW?=
 =?iso-8859-2?Q?QY85HlcRZWiL1UVy5Jw+jaiRlrk3iXIhg5QaMPKIUiSsKdhDF9/vydOYxg?=
 =?iso-8859-2?Q?B+ACJecWlVAr/oiM4vLhVHnykvaOOI/XaPkNNmWIXm3ssDarzsJ3snm639?=
 =?iso-8859-2?Q?sbsc+NYFqZppi6EOBvZbSI4Z6fLNE+ODD7NU1hlUM1o8IRxrP79WHaUmRD?=
 =?iso-8859-2?Q?vy3n7pRTAENRLrTI09D9Tya15fvEYyW50oox/ue+dF/oL97o8G+FO+CkHq?=
 =?iso-8859-2?Q?796gLc48V5Qspwz8RroQkYQC6vs848/gNzF5pGELIwPVAdWLxEnFU6j/yS?=
 =?iso-8859-2?Q?Tyj0kJYlBgbFZ10o1RSaUePw3CHdR5hwQ0sT9ZrjRDW5gvnE9+MsfHLEsi?=
 =?iso-8859-2?Q?Nc1Y4oKd950TLJVARKhWtx2OmrzSzd4oL5iK4pEsQW1wdtJw3N9Kf2uL3p?=
 =?iso-8859-2?Q?hWDZuU+rNvXoi12Qa2cgeBjtCQsCQXJDa/+5or2bjiwDzX8hZ1XGq3a2sl?=
 =?iso-8859-2?Q?X2kGlxlhdn4R2bAQa7Q7Fiom4J5XefJKr71NeJC+epvJ77MkwH9mSxHRWQ?=
 =?iso-8859-2?Q?7IO2iBa2aTmPXn/su5IOHG2Uc6vvtRNgvrP3/NE6z+eY/92roLGX7VYFLq?=
 =?iso-8859-2?Q?NVBnINahEXuqa/GOaNr1e8JR4TSvRA3ZZ9FNTHQhouXp0X70uYb2KVHyA+?=
 =?iso-8859-2?Q?c3gO0qzwQwZgEqsIisAJQc5EsA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-8534-20-msonline-outlook-c6e85.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB6PR08MB2693.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: f6f72086-9b88-43a8-12b0-08dda3beb1b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2025 23:22:37.6396
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRZPR08MB11191

ath11k currently lacks support for dynamic vlan (AP/VLAN), so make=0A=
'__ath11k_mac_register' in dp_tx to register 'NL80211_IFTYPE_AP_VLAN'=0A=
as available interface mode.=0A=
=0A=
Make 'ath11k_dp_tx' in dp_tx to add metadata info to notify firmware=0A=
that the multicast/broadcast packets are encrypted in software.=0A=
=0A=
Make '__ieee80211_subif_start_xmit' in tx to offload encapsulation=0A=
for VLAN unicast packets using 8023 xmit path instead of current=0A=
80211 xmit path.=0A=
=0A=
Tested, long-term in production environment using OpenWrt platform=0A=
installed on multiple AX3600 with FT:=0A=
 Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.9.0.1-01385-QCAHKSWPL_SILICONZ-1=0A=
 Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.9.0.1-01977-QCAHKSWPL_SILICONZ-1=0A=
=0A=
Co-developed-by: Seevalamuthu Mariappan <seevalam@codeaurora.org>=0A=
Signed-off-by: Seevalamuthu Mariappan <seevalam@codeaurora.org>=0A=
Signed-off-by: David Rapan <david@rapan.cz>=0A=
---=0A=
v1 -> v2: Move 'cpu_to_be16(ETH_P_PAE)' to earlier condition and add=0A=
 'ieee80211_is_qos_nullfunc' check so QoS NULL Data frames are=0A=
 properly send as open type frames with TID 7 in ethernet encap=0A=
 instead of QoS Data with TID 0.=0A=
v2 -> v3: Make 'hal_tx_msdu_metadata' struct to comply with current=0A=
 coding standard (no use of bit masks in '__packed').=0A=
 Make key retrieval in 8023 xmit path from=0A=
 '__ieee80211_subif_start_xmit' to be on pair with the standard flow in=0A=
 'ieee80211_subif_start_xmit_8023' where it also falls back to=0A=
 'default_unicast_key'.=0A=
=0A=
 drivers/net/wireless/ath/ath11k/core.h     |   1 +=0A=
 drivers/net/wireless/ath/ath11k/dp_tx.c    |  83 +++++++++-=0A=
 drivers/net/wireless/ath/ath11k/hal_desc.h | 160 ++++++++++++++++++++=0A=
 drivers/net/wireless/ath/ath11k/mac.c      |   3 +=0A=
 net/mac80211/tx.c                          |  15 +++=0A=
 5 files changed, 260 insertions(+), 2 deletions(-)=0A=
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
@@ -79,6 +79,43 @@ enum hal_encrypt_type ath11k_dp_tx_get_e=0A=
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
+	struct hal_tx_msdu_metadata *desc_ext;=0A=
+=0A=
+	htt_desc_size =3D sizeof(struct hal_tx_msdu_metadata);=0A=
+	htt_desc_size_aligned =3D ALIGN(htt_desc_size, HTT_META_DATA_ALIGNMENT);=
=0A=
+=0A=
+	ret =3D ath11k_dp_metadata_align_skb(skb, htt_desc_size_aligned);=0A=
+	if (unlikely(ret))=0A=
+		return ret;=0A=
+=0A=
+	desc_ext =3D (struct hal_tx_msdu_metadata *)skb->data;=0A=
+	desc_ext->info0 =3D le32_encode_bits(1, HAL_TX_MSDU_METADATA_INFO0_ENCRYP=
T_FLAG) |=0A=
+			  le32_encode_bits(0, HAL_TX_MSDU_METADATA_INFO0_ENCRYPT_TYPE) |=0A=
+			  le32_encode_bits(1,=0A=
+					   HAL_TX_MSDU_METADATA_INFO0_HOST_TX_DESC_POOL);=0A=
+	*htt_metadata_size =3D htt_desc_size_aligned;=0A=
+	return 0;=0A=
+}=0A=
+=0A=
 int ath11k_dp_tx(struct ath11k *ar, struct ath11k_vif *arvif,=0A=
 		 struct ath11k_sta *arsta, struct sk_buff *skb)=0A=
 {=0A=
@@ -97,6 +134,9 @@ int ath11k_dp_tx(struct ath11k *ar, stru=0A=
 	u32 ring_selector =3D 0;=0A=
 	u8 ring_map =3D 0;=0A=
 	bool tcl_ring_retry;=0A=
+	bool is_diff_encap =3D false;=0A=
+	u8 align_pad;=0A=
+	u8 htt_meta_size =3D 0;=0A=
 =0A=
 	if (unlikely(test_bit(ATH11K_FLAG_CRASH_FLUSH, &ar->ab->dev_flags)))=0A=
 		return -ESHUTDOWN;=0A=
@@ -189,7 +229,12 @@ tcl_ring_sel:=0A=
 =0A=
 	switch (ti.encap_type) {=0A=
 	case HAL_TCL_ENCAP_TYPE_NATIVE_WIFI:=0A=
-		ath11k_dp_tx_encap_nwifi(skb);=0A=
+		if ((arvif->vif->offload_flags & IEEE80211_OFFLOAD_ENCAP_ENABLED) &&=0A=
+		    (skb->protocol =3D=3D cpu_to_be16(ETH_P_PAE) ||=0A=
+		     ieee80211_is_qos_nullfunc(hdr->frame_control)))=0A=
+			is_diff_encap =3D true;=0A=
+		else=0A=
+			ath11k_dp_tx_encap_nwifi(skb);=0A=
 		break;=0A=
 	case HAL_TCL_ENCAP_TYPE_RAW:=0A=
 		if (!test_bit(ATH11K_FLAG_RAW_MODE, &ab->dev_flags)) {=0A=
@@ -208,6 +253,33 @@ tcl_ring_sel:=0A=
 		goto fail_remove_idr;=0A=
 	}=0A=
 =0A=
+	/* Add metadata for software encryption of vlan group traffic */=0A=
+	if ((!test_bit(ATH11K_FLAG_HW_CRYPTO_DISABLED, &ar->ab->dev_flags) &&=0A=
+	     !(info->control.flags & IEEE80211_TX_CTL_HW_80211_ENCAP) &&=0A=
+	     !info->control.hw_key && ieee80211_has_protected(hdr->frame_control)=
) ||=0A=
+	    is_diff_encap) {=0A=
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
@@ -216,7 +288,8 @@ tcl_ring_sel:=0A=
 		goto fail_remove_idr;=0A=
 	}=0A=
 =0A=
-	ti.data_len =3D skb->len;=0A=
+	ti.data_len =3D skb->len - ti.pkt_offset;=0A=
+	skb_cb->pkt_offset =3D ti.pkt_offset;=0A=
 	skb_cb->paddr =3D ti.paddr;=0A=
 	skb_cb->vif =3D arvif->vif;=0A=
 	skb_cb->ar =3D ar;=0A=
@@ -272,6 +345,8 @@ fail_unmap_dma:=0A=
 	dma_unmap_single(ab->dev, ti.paddr, ti.data_len, DMA_TO_DEVICE);=0A=
 =0A=
 fail_remove_idr:=0A=
+	if (ti.pkt_offset)=0A=
+		skb_pull(skb, ti.pkt_offset);=0A=
 	spin_lock_bh(&tx_ring->tx_idr_lock);=0A=
 	idr_remove(&tx_ring->txbuf_idr,=0A=
 		   FIELD_GET(DP_TX_DESC_ID_MSDU_ID, ti.desc_id));=0A=
@@ -348,6 +423,10 @@ ath11k_dp_tx_htt_tx_complete_buf(struct=0A=
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
--- a/drivers/net/wireless/ath/ath11k/hal_desc.h=0A=
+++ b/drivers/net/wireless/ath/ath11k/hal_desc.h=0A=
@@ -2490,5 +2490,165 @@=0A=
  *		A count value that indicates the number of times the producer of=0A=
  *		entries into this Ring has looped around the ring.=0A=
  */=0A=
+=0A=
+#define HAL_TX_MSDU_METADATA_INFO0_ENCRYPT_FLAG		BIT(8)=0A=
+#define HAL_TX_MSDU_METADATA_INFO0_ENCRYPT_TYPE		GENMASK(16, 15)=0A=
+#define HAL_TX_MSDU_METADATA_INFO0_HOST_TX_DESC_POOL	BIT(31)=0A=
+=0A=
+struct hal_tx_msdu_metadata {=0A=
+	__le32 info0;=0A=
+	__le32 rsvd0[6];=0A=
+} __packed;=0A=
+=0A=
+/* hal_tx_msdu_metadata=0A=
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
 =0A=
 #endif /* ATH11K_HAL_DESC_H */=0A=
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
@@ -4281,5 +4285,16 @@ void __ieee80211_subif_start_xmit(struct=0A=
 	if (IS_ERR(sta))=0A=
 		sta =3D NULL;=0A=
 =0A=
+	if (sta && sdata->vif.type =3D=3D NL80211_IFTYPE_AP_VLAN &&=0A=
+	    get_bss_sdata(sdata)->vif.offload_flags & IEEE80211_OFFLOAD_ENCAP_ENA=
BLED &&=0A=
+	    !is_multicast_ether_addr(skb->data)) {=0A=
+		struct ieee80211_key *key =3D rcu_dereference(sta->ptk[sta->ptk_idx]);=
=0A=
+		if (!key)=0A=
+			key =3D rcu_dereference(get_bss_sdata(sdata)->default_unicast_key);=0A=
+		ieee80211_8023_xmit(sdata, dev, sta, key, skb);=0A=
+		rcu_read_unlock();=0A=
+		return;=0A=
+	}=0A=
+=0A=
 	skb_set_queue_mapping(skb, ieee80211_select_queue(sdata, sta, skb));=0A=
 	ieee80211_aggr_check(sdata, sta, skb);=0A=

