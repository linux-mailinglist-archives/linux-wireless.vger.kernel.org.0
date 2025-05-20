Return-Path: <linux-wireless+bounces-23188-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3794CABE5E2
	for <lists+linux-wireless@lfdr.de>; Tue, 20 May 2025 23:16:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96DB33AE8C2
	for <lists+linux-wireless@lfdr.de>; Tue, 20 May 2025 21:16:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDFD525E811;
	Tue, 20 May 2025 21:16:13 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03olkn2061.outbound.protection.outlook.com [40.92.59.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1881425B1F9
	for <linux-wireless@vger.kernel.org>; Tue, 20 May 2025 21:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.59.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747775773; cv=fail; b=et+lkdx51/2w3XIbZBA9ol7g90v27V/M+fC4Q/tIHzPx0YIkaqezSjkXO4Vm4pW/zR3qvajDs6N0yg7CzNRPyz3X9IGKkZikShyYLpDVcLHVidD4e4ZBtUOziS/89c1iaJcxF6/Qz/0pKHvmUMojXDnAMW0sx8K15dQhTIU7vDc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747775773; c=relaxed/simple;
	bh=dwbF0Pmkd1VEPLiC/D9j/0GgWAJrZRyPoZYMQWTuMe4=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=jUBZIO4KNPjczEr3wylbid3NJXAnlH4pi50WGmOyhgKcyVaOx6OJ5Jq2CKuFvMom7NiA3K0SIvC/35hg1W+3o3IjL2X2WtWmS66Bg935271/0Yccof62NalaZqWoTF/PA6QVB8K8xQPb1BMGW1Nemc2B+4WQTV6loJ8lRjBrmo0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rapan.cz; spf=pass smtp.mailfrom=rapan.cz; arc=fail smtp.client-ip=40.92.59.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rapan.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rapan.cz
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F0ZrSXDycvuqMCL7Kdp6iVT4IRv+aVoc0arh64QVs8nY/731YND0yYiXtcAgSuMhrjePLE/Wz4y4rZbnnNmb603h4tFqM+zNpVroFX7Kriikk/w6bxd2fkqb1M6hJtWWCjMu3xsPWO5TW3ZTrsfbxAyN6+sVQb2E0coYXTdORHD2RcmvrHoQ0BUe0jFZvX0Ne2gsWQMgAIrTmq6PrmKKEcqb6TrgD2VMIkP9FhYeMAqoqaUwEVtygmyJ0lgc+SluiDS0tufj76+Mel1a0OrqU/VZz7NZ8Rlee81s7efbzohIG4sq332DJmWjbw9uTT03xf9hx1uCmRAw5YHbICWzYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SrLU+GlODFNneKb81JPoWw1gHjOUVoO+9yyiV34oV/o=;
 b=G8+O6QiLZL314xHeS5ADeCa5HPnifiq+QPGYknQPyvfDPRTrpkUxea7pScmBm3sHVoa0lwhcx6Obt13jfxHBuXk9f8EMoqeH1if6ah/M+KpkemHXYhYOVjgs169tbqjNidXpeQNSbpoxXcWKA0R470RfKz7kAN4NcVBarNOh+mcpRC++LcfLxIcs/UijGRxk3ySI+9w8kIp61ZnhkaA6zHE2dvPKgPQxmrQYqSBoEZkZe//PQ5bwFjEy5bUVhwOrSNIhlx169ghydhbGt9Z9dXA1OMA2k5jQjroV9BEBTZtDf07fVohrC8+CqP2krRFvgMKNscXRUVjrk/zyHgI+IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from DB6PR08MB2693.eurprd08.prod.outlook.com (2603:10a6:6:1c::13) by
 AS4PR08MB7877.eurprd08.prod.outlook.com (2603:10a6:20b:51c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.31; Tue, 20 May
 2025 21:16:07 +0000
Received: from DB6PR08MB2693.eurprd08.prod.outlook.com
 ([fe80::e6db:6f9a:2c0b:acb7]) by DB6PR08MB2693.eurprd08.prod.outlook.com
 ([fe80::e6db:6f9a:2c0b:acb7%5]) with mapi id 15.20.8722.031; Tue, 20 May 2025
 21:16:07 +0000
From: =?iso-8859-2?Q?David_Rapa=F2?= <david@rapan.cz>
To: "ath11k@lists.infradead.org" <ath11k@lists.infradead.org>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"jjohnson@kernel.org" <jjohnson@kernel.org>, "johannes@sipsolutions.net"
	<johannes@sipsolutions.net>
Subject: [PATCH v2] ath11k: add support for dynamic vlan (ap/vlan)
Thread-Topic: [PATCH v2] ath11k: add support for dynamic vlan (ap/vlan)
Thread-Index: AQHbycvDkq2dkCsRe062F053HU3AWQ==
Date: Tue, 20 May 2025 21:16:06 +0000
Message-ID:
 <DB6PR08MB26934CD2145BE9BC3DF6980ADF9FA@DB6PR08MB2693.eurprd08.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB6PR08MB2693:EE_|AS4PR08MB7877:EE_
x-ms-office365-filtering-correlation-id: 267de7e0-70b7-4238-4dd4-08dd97e38933
x-ms-exchange-slblob-mailprops:
 30ekHghIwFpWJZJ/S7H67WW7FVejyf+Cf9AsfCCO8sYPha9o97u+5IYL3yOym0YyZZZCNgrqxlJUt+whSDMFHiETkW7PGCkZhqq2JS62oGrBrscTbcb6TMzMtRpivpv883/1C/qzqK9a3OODT+UueEJxgW95LgPgAu8Csq65UOR/P5w350vGKy4IrVdHx8CRE2VRJ4O70LzRZGdv4lSrf2HDVudGOAk78kmsdOCk8YuV9gTE52qY9ZbIepfvIyzRDFDxQQHLWsqlclIbcZxgXsQXxfsbkjeNn+M7FDtix5gL/nU1vGq9qpwSzen1pw5JbDZSt2XqxbU2yW4DQi9q0szSblX5/n122IdO9wIQXzbNM/8ZAUxCnTr5E4XH+RIzrUSX+XbKkuTwZGAT0EXkLSnV/VtpddD6i6PbLXkt+y76niG74SLsb61oxfg63wQveTSIM8M/Go7TpoTFjB6pA58+TP5VHsuKCB3k8IoBTGTKCckU9U2L9t9EcxlHEfBPLoCs4SwpkgR8HldrkoX8gkTmB3pizXtKPjPDAHUEdbavbWuMqeScTDKCVoNSOaUyas5y/v+MGhk9qCOEZcNxWSImUsBIDh2TZxyiVmoKzKxCntY41D6xxS+gh95zVkYNZI8ZxFCH0jruUG8VQmsOt3GEN/rJvskJCWyBeR0ybyVJEy6pVTrXIid3m7PQDgCjlH5R7wilFWgPZ2eSsYgahUyOpuzVjJefSNA1uJERkEv7H1lsT+eOII+ay0zwmG+D
x-microsoft-antispam:
 BCL:0;ARA:14566002|19110799006|15080799009|41001999006|8062599006|8060799009|7092599006|15030799003|7072599006|461199028|440099028|3412199025|19111999003|12091999003|102099032;
x-microsoft-antispam-message-info:
 =?iso-8859-2?Q?ujG6I0ugwU/Izecdr8rK9dKRZQ/Uo33Ot3cRQZA/WVdy2PMIsst2Ex2AKv?=
 =?iso-8859-2?Q?XZ+Z7AVF5qeRA21pnooNstULxvVXMAevsWI72QYu6D4zqMkw7NK1Ls1Km2?=
 =?iso-8859-2?Q?ZmgP4vxF4JE3PKhJ7uWzhdSk9feOmZhbahba+p2ZBNbZ5eLZ1bDAWBj4wH?=
 =?iso-8859-2?Q?2641/WkF4ZX2+81tHCYFd0igEFijxQChr81ln6eXfAtdZfYIYFwF34xL13?=
 =?iso-8859-2?Q?uKDoMlGFvdF1MIwvbPcoiDfUCQ5xUxE/V6ehLS6HM/ZvbgdMIc4XNpWSFf?=
 =?iso-8859-2?Q?bX6RmCOqL9bDMUVwcFwWnLzz9hnh0jLq/peeFnfeXFBdanrboyq21Nkqon?=
 =?iso-8859-2?Q?1cBQ4YDpCQ4RwK7DRX9q7x6V8ttuu1nkj+VxcbK9dmeq2OUBWsZkQXOjv0?=
 =?iso-8859-2?Q?CTXsUIXYnpjiDkMXV33ZH+Pq/iLBqDZeVBQJFR6UVR7d3MKFsDGU5xCwGM?=
 =?iso-8859-2?Q?amZgoNEhPnvSVdd6NWlHZSorsMgQzyG5xaBeHzHX4vSj0NGkKef4RMFFpi?=
 =?iso-8859-2?Q?8mmyEDq6T5ntKQ2doXjXXb23CY0y1OoYR51J4Tj7Fs1b7ULgOD8+zhkSoB?=
 =?iso-8859-2?Q?tl6E59UDEOuoqOld8DV2AFMGZ+xpIPlijj3cWctVEvm0qXDd3jCCLbuuOZ?=
 =?iso-8859-2?Q?BuhbWcI+0ybYW79UI+PnYcJf2UozZvaSZHPdI7cUDymausiRmJgMT6aL+o?=
 =?iso-8859-2?Q?a/Hgxo+HiYysLlxJdUJ8GnoTXFV4wE/XvNq8JWe7gv4OHQdPAmZ0HbQu/0?=
 =?iso-8859-2?Q?c7mRzW6FOPXwfRfIqiQWZzQLvm2DE7DoWPw6eBlBnWf72ANlu4B0qsHQiw?=
 =?iso-8859-2?Q?6+DeOFXmplUkpnPeNurdNw//Bagml89Gk/LgFCbRvMNRouUn/rcBfjbYBw?=
 =?iso-8859-2?Q?ZF9ezousBrLAf+MPl4W+DivcYKjIOI7aj4Xai0irnZCVFQ6W+McFxt5BRz?=
 =?iso-8859-2?Q?CZIsvhEswCJq1y3/8m6dCOTg/elGX5vw33feAPyG3P2MlScESFOF8ai4UC?=
 =?iso-8859-2?Q?eKwShfpHZWc9WA+vB/S0S61IsJWZGOJThNMMdZFxCflVnmjTvs0kKXzLsW?=
 =?iso-8859-2?Q?DmSnVIWenDBOHvHJiHsl8gKjQb9b1mAe5dbZj+0eqsIP49BUnvssmZ3ebz?=
 =?iso-8859-2?Q?XRnnfZdakD33/F8gWEtD50H9F4Lnz8me6RXRa2RF8Iwr3sqVC73dBKAKLC?=
 =?iso-8859-2?Q?m5rIiFTXuHEGEkSt+m1TlaAN9/4aI2LHux5US5YmiRgBZaEvvvd3LvKe4s?=
 =?iso-8859-2?Q?ZAbIaYqpFqECRzss6slRCDJLtvmcwnTJvsgzqAFc5hsQfG/izfMvl0foeO?=
 =?iso-8859-2?Q?nAJDWCvV0qNgv/HztT1pVaxorQ=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-2?Q?K7NbIyY/V9H14HoXfuP9IP8uGem/JH7RmnDLh2wUJ6xkyf1gybaWKWLo4B?=
 =?iso-8859-2?Q?VGQcij4x7iTsmCZdEJtNrcnTZXqIKhZ+UOXTbvhIvlbewaRTzcXQUiVBGE?=
 =?iso-8859-2?Q?0c9AdFVAHRltzT15EkFDWrlsySTY4BjSS/FYtgscAhRufVc8B5NcfL+aSt?=
 =?iso-8859-2?Q?e6PrGmx6Zf0s6coSnsJFtTRI9wrRzQtqc+vGXO0HgyaNN1eFvbh51NpAlk?=
 =?iso-8859-2?Q?1noGvDO3ByVZ5c2/wPJxKds2fwKFiglRt4cCi4SOO1aoSUD+oXizqikeU5?=
 =?iso-8859-2?Q?jscujAguVRtB6T7HZ8UyUk3BvggvjJ2Rr1KHJcVZgPJRAUcsnV87tupVu6?=
 =?iso-8859-2?Q?W4FJthRIY0fH4hMk3IQafU5kBsuP3YJVpXqrK8iozZHzSf+9d0NKolnZjX?=
 =?iso-8859-2?Q?cZoqSdTFF6WF55UHEgr8cU/UMc5Gsd2zGracrtqomajpv6kXiEqPB7GQUJ?=
 =?iso-8859-2?Q?A+X9Ch24EajYoPVrVcusM5PpdGTE8YQxJjKu3AvV1OZSQkhVJD60qVUdgA?=
 =?iso-8859-2?Q?HSE8vurXw19Tc8BKvZAKmxfwVntezzdX4B+50uA+1vjyxfTcVSao8I2nXY?=
 =?iso-8859-2?Q?bwaY6mrkWPoljK6Z1TrUuD+354AV6Tt21wqT6jA6PWoLrU6HoETTTzDFuq?=
 =?iso-8859-2?Q?tDhvpu8tK4N1MuLHSMxFZj3afYp3IcqOVGJbYJHooDD63UiOJ0e9BI5bSG?=
 =?iso-8859-2?Q?IjoO8N8MXf0OXxuET79mhj9/CLgCe7NMNvcSRSMybx2txOnH50jObC5/K1?=
 =?iso-8859-2?Q?1P4oEaV65AtScvqe8izLnX8m66kDZfCHvxMRwTtloIXuCnFIG5H0v0i1tm?=
 =?iso-8859-2?Q?kLDBRu+XOEEwmWxsFEDr0nxngEOcX4JUqCMp2w8Q3A3VUELTX0CKNQIZqr?=
 =?iso-8859-2?Q?O//4vo16ZCEzSLnYPAze1vcuLj6IVChrQrsfe5/APQZBQTi3utzhNwS2EF?=
 =?iso-8859-2?Q?kIUzDp/OEpzHMTFtBqm0cW0Gp8/nNa1930ynQVw5Ktx14Vde++71G4/4su?=
 =?iso-8859-2?Q?IsXh5qsroiM5Qjzj0WItB7ggdxtvh971QNCdlR4GmtWeFl2GqHdKIJK2T7?=
 =?iso-8859-2?Q?5+b2fzD1z0nhlOMyDTwEDyIJEYIbfq5Tb26eFBj2Tq7S4yE/QRFExfQDFs?=
 =?iso-8859-2?Q?8BCmSH0LYbWvrRY/uwt5LZdomBh+qty+g1N0uh+JMSqs0ScrFahF/lIPye?=
 =?iso-8859-2?Q?FfCEz3ANF+7Hrad8TOmSUgvHhAzI0OHRtbsEou/z2B6ixaOVoDjHz+gYml?=
 =?iso-8859-2?Q?PjjCn927I7ofrGOtw5dqTW4qmgSmn339jxERB1Yek4lCtj2hMcj4k4gcrD?=
 =?iso-8859-2?Q?MzbAyI22XHqTvpLNT9ir4aWjSQ=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 267de7e0-70b7-4238-4dd4-08dd97e38933
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2025 21:16:06.9882
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR08MB7877

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
Changes since v1:=0A=
 Move 'cpu_to_be16(ETH_P_PAE)' to earlier condition and add=0A=
 'ieee80211_is_qos_nullfunc' check so QoS NULL Data frames are=0A=
 properly send as open type frames with TID 7 in ethernet encap.=0A=
 WIthout this change are as QoS Data with TID 0.=0A=
=0A=
Tested, long-term in production environment using OpenWrt platform=0A=
installed on multiple AX3600 with FT.=0A=
=0A=
Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.9.0.1-01385-QCAHKSWPL_SILICONZ-1=0A=
Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.9.0.1-01977-QCAHKSWPL_SILICONZ-1=0A=
=0A=
Signed-off-by: Seevalamuthu Mariappan <seevalam@codeaurora.org>=0A=
Signed-off-by: David Rapan <david@rapan.cz>=0A=
---=0A=
 drivers/net/wireless/ath/ath11k/core.h  |   1 +=0A=
 drivers/net/wireless/ath/ath11k/dp_tx.c |  82 +++++++++-=0A=
 drivers/net/wireless/ath/ath11k/dp_tx.h | 197 ++++++++++++++++++++++++=0A=
 drivers/net/wireless/ath/ath11k/mac.c   |   3 +=0A=
 net/mac80211/tx.c                       |  15 +++=0A=
 5 files changed, 296 insertions(+), 2 deletions(-)=0A=
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
@@ -189,7 +228,12 @@ tcl_ring_sel:=0A=
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
@@ -208,6 +252,33 @@ tcl_ring_sel:=0A=
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
@@ -216,7 +287,8 @@ tcl_ring_sel:=0A=
 		goto fail_remove_idr;=0A=
 	}=0A=
 =0A=
-	ti.data_len =3D skb->len;=0A=
+	ti.data_len =3D skb->len - ti.pkt_offset;=0A=
+	skb_cb->pkt_offset =3D ti.pkt_offset;=0A=
 	skb_cb->paddr =3D ti.paddr;=0A=
 	skb_cb->vif =3D arvif->vif;=0A=
 	skb_cb->ar =3D ar;=0A=
@@ -272,6 +344,8 @@ fail_unmap_dma:=0A=
 	dma_unmap_single(ab->dev, ti.paddr, ti.data_len, DMA_TO_DEVICE);=0A=
 =0A=
 fail_remove_idr:=0A=
+	if (ti.pkt_offset)=0A=
+		skb_pull(skb, ti.pkt_offset);=0A=
 	spin_lock_bh(&tx_ring->tx_idr_lock);=0A=
 	idr_remove(&tx_ring->txbuf_idr,=0A=
 		   FIELD_GET(DP_TX_DESC_ID_MSDU_ID, ti.desc_id));=0A=
@@ -348,6 +422,10 @@ ath11k_dp_tx_htt_tx_complete_buf(struct=0A=
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
@@ -4257,6 +4261,7 @@ void __ieee80211_subif_start_xmit(struct=0A=
 {=0A=
 	struct ieee80211_sub_if_data *sdata =3D IEEE80211_DEV_TO_SUB_IF(dev);=0A=
 	struct ieee80211_local *local =3D sdata->local;=0A=
+	struct ieee80211_key *key =3D NULL;=0A=
 	struct sta_info *sta;=0A=
 	struct sk_buff *next;=0A=
 	int len =3D skb->len;=0A=
@@ -4281,5 +4286,15 @@ void __ieee80211_subif_start_xmit(struct=0A=
 	if (IS_ERR(sta))=0A=
 		sta =3D NULL;=0A=
 =0A=
+	if (sdata->vif.type =3D=3D NL80211_IFTYPE_AP_VLAN &&=0A=
+	    get_bss_sdata(sdata)->vif.offload_flags & IEEE80211_OFFLOAD_ENCAP_ENA=
BLED &&=0A=
+	    !is_multicast_ether_addr(skb->data)) {=0A=
+		if (sta)=0A=
+			key =3D rcu_dereference(sta->ptk[sta->ptk_idx]);=0A=
+		ieee80211_8023_xmit(sdata, dev, sta, key, skb);=0A=
+		rcu_read_unlock();=0A=
+		return;=0A=
+	}=0A=
+=0A=
 	skb_set_queue_mapping(skb, ieee80211_select_queue(sdata, sta, skb));=0A=
 	ieee80211_aggr_check(sdata, sta, skb);=0A=

