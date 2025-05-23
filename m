Return-Path: <linux-wireless+bounces-23355-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E565AC21D1
	for <lists+linux-wireless@lfdr.de>; Fri, 23 May 2025 13:14:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 895C91C04DB6
	for <lists+linux-wireless@lfdr.de>; Fri, 23 May 2025 11:15:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D592622B5AC;
	Fri, 23 May 2025 11:14:51 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02olkn2023.outbound.protection.outlook.com [40.92.50.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DC1A7464
	for <linux-wireless@vger.kernel.org>; Fri, 23 May 2025 11:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.50.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747998891; cv=fail; b=j/QriwJtYtzJPdrbMjhAysJYu0djNJ0adxg8vnB8IPiBNXtp6r0wVErt32qZ3ltRKvJHwYueZPbuz9ASf4xdat7uiwoln7PUwktMQuOF7z38Qt7sit9a2mWsLMr0Cea+lHF1yFwmgXGBprHk9CJpqSPdtgjgO2qkK2aLqDb7If0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747998891; c=relaxed/simple;
	bh=VSKQw2N1UJw2UrVASlJTE5CfUuHhG6/ytMr3wAPSKxQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YBggW3DQ/LI0QTiEP6+KtJ/QBQZpO29XfLs+BZJ6D2zs0nheMS/xf38CGx1+QTyGTGFtov+0yY4C/0VD6t0uX+a1wIOHxDDy5Ao7p2gkvmobCF9R1D4bnsYTzy87nB0AGFkSPkLzxlOZ7GqDMtawxZLcWeGnnvpohifSbksKcYc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rapan.cz; spf=pass smtp.mailfrom=rapan.cz; arc=fail smtp.client-ip=40.92.50.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rapan.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rapan.cz
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e0zWSqM7JQgylKOQaAfwwTj2xF1lma3CzPRIXr5K2c0sgPsR9yqahDgxyGnN7QZ3T5AoXfHQpuMxw/0I2NDFP+v/X/U+cTv2zvgY5nxglXsEKVdU4I2xKDG3mu/Sayi9u0bWyyboLWP0ArzzMzIUrLQRcmJO7z2x30YIxIkbJHlm1nagr1/m3Wp18B4q4kAlosBOZtbqW2bDZx3ddCJDNDrSh3kM10okoedHZSDGsKQvfXMo9bag7YDz5J7kYnfv4wzq/GKQyrFpcWN3IovmN+5zpscgVKphfxp2WrzS1KTHozdOXu9jBu0c8RwL6B/guPC0Bi0n9LTvMWB2hrIf0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KIJjFN1dxwpfX+5k2uVd/mJrv6uXzLypjKvQtIfcvqY=;
 b=rqgmzOPApiAcef57mUrx0Pe6gjJ5Lx7ez23XMpouMXDqqPVT1jPc7E7MxaeSRP2QCmbOEO3kfDjy70Fa58QydfoRWHFS+sSLkJOjIx7LnHWdxKz7uuDHAiZSwGa/05arnWrv2fporBrtIIbMLkgQ5YitlTftV4xCNfUR4R6372LzzbQViI/b9cE5AEYYQhxnghg5rAs7tLgkFpqPTa0/z1JeIjoeAQn87wXc+xmnKInNbfBSDzjNBw1lyw8emjnMb5Yk1fTupK3w+1ZNejqf3LQ7OYc4M7mB/3Jtn7RHVP6q1mQknpvupuvc1ckJecMAh6hASv2eoT+/kuJZ5ol4Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from DB6PR08MB2693.eurprd08.prod.outlook.com (2603:10a6:6:1c::13) by
 FRZPR08MB10997.eurprd08.prod.outlook.com (2603:10a6:d10:136::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.21; Fri, 23 May
 2025 11:14:46 +0000
Received: from DB6PR08MB2693.eurprd08.prod.outlook.com
 ([fe80::e6db:6f9a:2c0b:acb7]) by DB6PR08MB2693.eurprd08.prod.outlook.com
 ([fe80::e6db:6f9a:2c0b:acb7%5]) with mapi id 15.20.8722.031; Fri, 23 May 2025
 11:14:46 +0000
From: =?iso-8859-2?Q?David_Rapa=F2?= <david@rapan.cz>
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>, "ath11k@lists.infradead.org"
	<ath11k@lists.infradead.org>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"jjohnson@kernel.org" <jjohnson@kernel.org>, "johannes@sipsolutions.net"
	<johannes@sipsolutions.net>
Subject: Re: [PATCH v2] ath11k: add support for dynamic vlan (ap/vlan)
Thread-Topic: [PATCH v2] ath11k: add support for dynamic vlan (ap/vlan)
Thread-Index: AQHbycvDkq2dkCsRe062F053HU3AWbPdSFeAgALLoPY=
Date: Fri, 23 May 2025 11:14:46 +0000
Message-ID:
 <DB6PR08MB26932C97770999E8577ABFEEDF98A@DB6PR08MB2693.eurprd08.prod.outlook.com>
References:
 <DB6PR08MB26934CD2145BE9BC3DF6980ADF9FA@DB6PR08MB2693.eurprd08.prod.outlook.com>
 <4f68159d-3d90-44fe-b932-511ff3fe7d55@oss.qualcomm.com>
In-Reply-To: <4f68159d-3d90-44fe-b932-511ff3fe7d55@oss.qualcomm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB6PR08MB2693:EE_|FRZPR08MB10997:EE_
x-ms-office365-filtering-correlation-id: cf41fef9-0370-45e1-6e5f-08dd99eb06df
x-microsoft-antispam:
 BCL:0;ARA:14566002|7092599006|8060799009|8062599006|19110799006|15030799003|41001999006|15080799009|7072599006|461199028|4302099013|3412199025|440099028|12091999003|10035399007|19111999003|102099032|1602099012;
x-microsoft-antispam-message-info:
 =?iso-8859-2?Q?kS/Ioih69ar/i45EUVtPg1l6+s0xj8quxU+cX+TgyJqHOju+1PRRmi6Gxk?=
 =?iso-8859-2?Q?sW8OYey0Utm8BQlTQP3WHs3q1env12XJfuPU3DfoO1f6wxEW0QdpMMAfcE?=
 =?iso-8859-2?Q?kkBtt2DXHWgGvIYlwo4t5rYCTmVmq8iVuUbxZgb1/MebFHjAwz/WRZRyxk?=
 =?iso-8859-2?Q?MsRTr0sfySLB6BEbPHWb52jTeJveN9CQCndqImzksIVGupYfsDtLuvnLOo?=
 =?iso-8859-2?Q?++1VXuQs3nOduobxix4QWVqektJ9j8e6VEWFyd0yVciLF4lfYfCtYsFrk7?=
 =?iso-8859-2?Q?eC7cJoGb83f1WmAgutCubHLEipCv+4Yqj5+phXBRVIl+oPg0jset1Ec/Ph?=
 =?iso-8859-2?Q?oT93kXxCBWDU7QtCSFinbviOJRycrZkWAVxAkWvdQJfHsowE+95buDqRSR?=
 =?iso-8859-2?Q?2FrVVAT574d4L7qbe1jS7CDNbzOXjDCIQ2uOyBNCtIl9JB/U3710TXcQ5a?=
 =?iso-8859-2?Q?WErtpVCHLoCc/v9Qn4YFQ02RxtozwKqf+0+1pbVgJtvYMpmMLpwQ6iB5e2?=
 =?iso-8859-2?Q?mttps5t9X+DygmD2i8pRT7H9uNarQnAZc9RD505TQwOWDBH4dQzphJaMRi?=
 =?iso-8859-2?Q?9N6zxQdw8bDVnBi1rZZFo/X/7gZvQlibVU/colDE3skCy3Yy4/4vim9eNl?=
 =?iso-8859-2?Q?MlwulIahIOKbP1Wh/UAa+h7AGyJ96iiga1Gk+ET36EQHwAmcoV23xTOALg?=
 =?iso-8859-2?Q?69RXZndtTX7DlewOn7xemCBNNsnAqxIz2tSiSwRYj8f28+qGUgIMl+KaTF?=
 =?iso-8859-2?Q?yDPIdfw/jQdsWDkxLFB4UPwoHe4HyreILzYzA6mKChvHJ9zc6f7IOMCYxa?=
 =?iso-8859-2?Q?mMmN06tgCFbq3kwtIU2zkADn72aW9HsFb1c2xAcJzhe6idNAlHUY2MZPl+?=
 =?iso-8859-2?Q?5WswG+1UDIvC1B2HrZNT7/cO05zolDlID6FG5J3ni/fcZ2iUAYh32F2Gfm?=
 =?iso-8859-2?Q?KYGD01GiKcsLTEZab+rtaufdjmYwWoaaAURhn0jj7Zhgt6oHTboERzaczt?=
 =?iso-8859-2?Q?d/opdDrZlLqubIIiyTU7P9X1Cg2ks+XkP6XE+yozgb4mgAiPocLcA6Vu1B?=
 =?iso-8859-2?Q?if/XzECZ2RGd1K3dI9aTeE5yAMKOXigrJw8Yq/loTYTxTpVjiS7ppg35QM?=
 =?iso-8859-2?Q?Xns07VUFqq5MaSspDzjShYLtzxKjoYkmG49O+h6VFAUerKPBzx1tLtBvxs?=
 =?iso-8859-2?Q?tJZNkl4lck0OIw3Af5Hj1GzpoIj2jMdswq1NjCKN2hxMskXt02ib55r3vY?=
 =?iso-8859-2?Q?qRlfBaA8t8TK1pCJK9GZgPd5D9rTUjKhpQuis18YAPgyFarjq0NIMPwUxB?=
 =?iso-8859-2?Q?MSdwpUpxfqGA2lc+ta7HTjDUvJbi/C2usX+LxWRz9v+DMTyjgH0hRaePa/?=
 =?iso-8859-2?Q?8PnIFrJv63UGrHU9cx2tgxbL1ocHZ8eVqiSwdufudyQuy/vSztxoVe3h+o?=
 =?iso-8859-2?Q?lPzEjypbEqekMXKMJgbJIimx3OOI8n1iOST3KYHTHse7CR5Y51YxyTOtwA?=
 =?iso-8859-2?Q?9yTkgTY+iArv/Bz1rrOFhK?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-2?Q?CflXeDbWq+oJ0SqtmZa9Uejduw0r7M4AoCFFuDp6BRfrqk6VoPhM6dlTRN?=
 =?iso-8859-2?Q?v89cj9tnhMGWPoxZxLH1NcoytnbeZyGQfaWi5m9qZKnuRYdFqPHP8h8dzJ?=
 =?iso-8859-2?Q?tnxTNU8mXkWXC8gQ0CxfinkE1aq7/jI1/Ryz85RweTMP60C+UNAZIpwFEq?=
 =?iso-8859-2?Q?GWEPdangpsgo60Opnlm9ZFpUZhf/Kau5NTd4sm9f+BAMOH/p1zrNh+E+AV?=
 =?iso-8859-2?Q?82UqY9gou0NAj7TknKkfcLTTlrNNeOIViBj0BYDMPK/uweiYSe6zRhvznj?=
 =?iso-8859-2?Q?TQO9BdIEDluAriC4OrU8tWHidpiSH9XIvJRvbfGDD4hr/EpMbGsmOoktps?=
 =?iso-8859-2?Q?LtKlnL7RptSFjHZFgdFH8C6N6hGkvcEPVFGaVgPRl59ZRSsqcBg+h26LcU?=
 =?iso-8859-2?Q?jcgZfWzM90N+Q3SGoe3dKKjFvuAlvT7hiS+Y/aO31+tfleTFTvilf2ZsNe?=
 =?iso-8859-2?Q?8Bx9lCjIh0oGorYpts/dFn0LxS2na77P8IZ0f9va4fv7DCEJDbpw30AcN+?=
 =?iso-8859-2?Q?M0uK/wX/zKBpLucEAbxya4yFX/i4iJTdX8gsKAMyDkTEsIy3cz8M2U3cUB?=
 =?iso-8859-2?Q?ZBZvWqNsdJ9NYOljhkOe2V5aQVGnDsOX+0h9tPwhplF+ilLZnfmFC1JOGU?=
 =?iso-8859-2?Q?JWHY7jjPB7nBgyj7KejbBb7GYcA7sOI1VxkV18PzWo0SMhvXRWiYRGGTMa?=
 =?iso-8859-2?Q?PjHO/dDQNVz40MQdHHi/7hmXLeW1Ne2paM/g2dGiqCCBlekYBU/1iDCsYn?=
 =?iso-8859-2?Q?g2HbiqaX2GMSKgpaRwzQdlF3NSG4kHKGMt0b6ef+buxSMcd9dFyaymuDJh?=
 =?iso-8859-2?Q?B+ZK8BAe7wgM5D8bbpZfOftX8Z7ELumEpILXS54hT/tMoxQDpmLsn8WUw3?=
 =?iso-8859-2?Q?p4QSusbY1hWFfnlQ/wojTi9+0wBLSCwGMpkFYm8xqgqLZZO1GCu4kj+XKB?=
 =?iso-8859-2?Q?MnPBoNeO54uRhjgf/79MD4AKTF31wGCIzw5PYSeBRt+rNeU/wsWJofGK1V?=
 =?iso-8859-2?Q?XTS8YouCQoUo/Fp3iKiCeRxQJxHR2BrDupcNxxbkw5ZIJmz0Wln2D4IvMo?=
 =?iso-8859-2?Q?fCP5LlMknofp0kN4cnVX2ByZjjh2bnT/AYm78LoCo6j+n7xzLGtpktkUj0?=
 =?iso-8859-2?Q?kbRqBHp/qf3cvkzIvM2dl5IjTb05Y+96jLKlaQDqJyC04nWfvOYSd8XTRc?=
 =?iso-8859-2?Q?U8mQ5aTdIJvp5DwRIr1W6ITZu5q+hdHklqgDxMV34mxynMAuchQCt7+xJZ?=
 =?iso-8859-2?Q?a2m3bJh07HxwCb/IPQ+GeOgVJJuxAZBLWVDaaFikhhx8qsRmUjncuuP+LC?=
 =?iso-8859-2?Q?mbNjO9lOq8eSx/aIeas1OolJog=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: cf41fef9-0370-45e1-6e5f-08dd99eb06df
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2025 11:14:46.7935
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRZPR08MB10997

Hi Jeff, thanks for the feedback. I tried to fix all the problems you menti=
oned and now I have submitted v3.

________________________________________
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Sent: Wednesday, May 21, 2025 6:32 PM
To: David Rapa=F2; ath11k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org; jjohnson@kernel.org; johannes@sipsoluti=
ons.net
Subject: Re: [PATCH v2] ath11k: add support for dynamic vlan (ap/vlan)

On 5/20/2025 2:16 PM, David Rapa=F2 wrote:
> ath11k currently lacks support for dynamic vlan (AP/VLAN), so this patch
> adds feature advertisement in '__ath11k_mac_register' alongside
> all the other neccessary components supporting its function, including
> prerequisites for software encryption of VLAN group traffics.
> VLAN unicast packets shall be taking 8023 xmit path if encapsulation
> offload is enabled and multicast/broadcast then 80211 xmit path.
>
> Metadata info in dp_tx added to notify firmware that the
> multicast/broadcast packets are encrypted in software.

Use imperative mood in your commit text
https://www.kernel.org/doc/html/latest/process/submitting-patches.html#desc=
ribe-your-changes
>
> Changes since v1:
>  Move 'cpu_to_be16(ETH_P_PAE)' to earlier condition and add
>  'ieee80211_is_qos_nullfunc' check so QoS NULL Data frames are
>  properly send as open type frames with TID 7 in ethernet encap.
>  WIthout this change are as QoS Data with TID 0.

patch revision history goes after the "---"

>
> Tested, long-term in production environment using OpenWrt platform
> installed on multiple AX3600 with FT.
>
> Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.9.0.1-01385-QCAHKSWPL_SILICONZ-1
> Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.9.0.1-01977-QCAHKSWPL_SILICONZ-1
>
> Signed-off-by: Seevalamuthu Mariappan <seevalam@codeaurora.org>
> Signed-off-by: David Rapan <david@rapan.cz>

Who authored this code? You are submitting it as the author, but the S-O-B
chain implies Seevalamuthu Mariappan was the author.

> ---
>  drivers/net/wireless/ath/ath11k/core.h  |   1 +
>  drivers/net/wireless/ath/ath11k/dp_tx.c |  82 +++++++++-
>  drivers/net/wireless/ath/ath11k/dp_tx.h | 197 ++++++++++++++++++++++++
>  drivers/net/wireless/ath/ath11k/mac.c   |   3 +
>  net/mac80211/tx.c                       |  15 +++
>  5 files changed, 296 insertions(+), 2 deletions(-)
>
> base-commit: ff8069c7cf3eb0fcd53adebdf341b6aaa98bdd3b
>
> --- a/drivers/net/wireless/ath/ath11k/core.h
> +++ b/drivers/net/wireless/ath/ath11k/core.h
> @@ -120,6 +120,7 @@ struct ath11k_skb_cb {
>       u32 cipher;
>       struct ath11k *ar;
>       struct ieee80211_vif *vif;
> +     u32 pkt_offset;
>  } __packed;
>
>  struct ath11k_skb_rxcb {
> --- a/drivers/net/wireless/ath/ath11k/dp_tx.c
> +++ b/drivers/net/wireless/ath/ath11k/dp_tx.c
> @@ -79,6 +79,42 @@ enum hal_encrypt_type ath11k_dp_tx_get_e
>       }
>  }
>
> +#define HTT_META_DATA_ALIGNMENT      0x8
> +
> +static int ath11k_dp_metadata_align_skb(struct sk_buff *skb, u8 align_le=
n)
> +{
> +     if (unlikely(skb_cow_head(skb, align_len)))
> +             return -ENOMEM;
> +
> +     skb_push(skb, align_len);
> +     memset(skb->data, 0, align_len);
> +     return 0;
> +}
> +
> +static int ath11k_dp_prepare_htt_metadata(struct sk_buff *skb,
> +                                      u8 *htt_metadata_size)
> +{
> +     u8 htt_desc_size;
> +     /* Size rounded of multiple of 8 bytes */
> +     u8 htt_desc_size_aligned;
> +     int ret;
> +     struct htt_tx_msdu_desc_ext *desc_ext;
> +
> +     htt_desc_size =3D sizeof(struct htt_tx_msdu_desc_ext);
> +     htt_desc_size_aligned =3D ALIGN(htt_desc_size, HTT_META_DATA_ALIGNM=
ENT);
> +
> +     ret =3D ath11k_dp_metadata_align_skb(skb, htt_desc_size_aligned);
> +     if (unlikely(ret))
> +             return ret;
> +
> +     desc_ext =3D (struct htt_tx_msdu_desc_ext *)skb->data;
> +     desc_ext->valid_encrypt_type =3D 1;
> +     desc_ext->encrypt_type =3D 0;
> +     desc_ext->host_tx_desc_pool =3D 1;
> +     *htt_metadata_size =3D htt_desc_size_aligned;
> +     return 0;
> +}
> +
>  int ath11k_dp_tx(struct ath11k *ar, struct ath11k_vif *arvif,
>                struct ath11k_sta *arsta, struct sk_buff *skb)
>  {
> @@ -97,6 +133,9 @@ int ath11k_dp_tx(struct ath11k *ar, stru
>       u32 ring_selector =3D 0;
>       u8 ring_map =3D 0;
>       bool tcl_ring_retry;
> +     bool is_diff_encap =3D false;
> +     u8 align_pad;
> +     u8 htt_meta_size =3D 0;
>
>       if (unlikely(test_bit(ATH11K_FLAG_CRASH_FLUSH, &ar->ab->dev_flags))=
)
>               return -ESHUTDOWN;
> @@ -189,7 +228,12 @@ tcl_ring_sel:
>
>       switch (ti.encap_type) {
>       case HAL_TCL_ENCAP_TYPE_NATIVE_WIFI:
> -             ath11k_dp_tx_encap_nwifi(skb);
> +             if ((arvif->vif->offload_flags & IEEE80211_OFFLOAD_ENCAP_EN=
ABLED) &&
> +                 (skb->protocol =3D=3D cpu_to_be16(ETH_P_PAE) ||
> +                  ieee80211_is_qos_nullfunc(hdr->frame_control)))
> +                     is_diff_encap =3D true;
> +             else
> +                     ath11k_dp_tx_encap_nwifi(skb);
>               break;
>       case HAL_TCL_ENCAP_TYPE_RAW:
>               if (!test_bit(ATH11K_FLAG_RAW_MODE, &ab->dev_flags)) {
> @@ -208,6 +252,33 @@ tcl_ring_sel:
>               goto fail_remove_idr;
>       }
>
> +     /* Add metadata for software encryption of vlan group traffic */
> +     if ((!test_bit(ATH11K_FLAG_HW_CRYPTO_DISABLED, &ar->ab->dev_flags) =
&&
> +          !(info->control.flags & IEEE80211_TX_CTL_HW_80211_ENCAP) &&
> +          !info->control.hw_key && ieee80211_has_protected(hdr->frame_co=
ntrol)) ||
> +         is_diff_encap) {
> +             /* HW requirement is that metadata should always point to a
> +              * 8-byte aligned address. So we add alignment pad to start=
 of
> +              * buffer. HTT Metadata should be ensured to be multiple of=
 8-bytes
> +              * to get 8-byte aligned start address along with align_pad=
 added
> +              */
> +             align_pad =3D ((unsigned long)skb->data) & (HTT_META_DATA_A=
LIGNMENT - 1);
> +             ret =3D ath11k_dp_metadata_align_skb(skb, align_pad);
> +             if (unlikely(ret))
> +                     goto fail_remove_idr;
> +
> +             ti.pkt_offset +=3D align_pad;
> +             ret =3D ath11k_dp_prepare_htt_metadata(skb, &htt_meta_size)=
;
> +             if (unlikely(ret))
> +                     goto fail_remove_idr;
> +
> +             ti.pkt_offset +=3D htt_meta_size;
> +             ti.meta_data_flags |=3D HTT_TCL_META_DATA_VALID_HTT;
> +             ti.flags0 |=3D FIELD_PREP(HAL_TCL_DATA_CMD_INFO1_TO_FW, 1);
> +             ti.encap_type =3D HAL_TCL_ENCAP_TYPE_RAW;
> +             ti.encrypt_type =3D HAL_ENCRYPT_TYPE_OPEN;
> +     }
> +
>       ti.paddr =3D dma_map_single(ab->dev, skb->data, skb->len, DMA_TO_DE=
VICE);
>       if (unlikely(dma_mapping_error(ab->dev, ti.paddr))) {
>               atomic_inc(&ab->soc_stats.tx_err.misc_fail);
> @@ -216,7 +287,8 @@ tcl_ring_sel:
>               goto fail_remove_idr;
>       }
>
> -     ti.data_len =3D skb->len;
> +     ti.data_len =3D skb->len - ti.pkt_offset;
> +     skb_cb->pkt_offset =3D ti.pkt_offset;
>       skb_cb->paddr =3D ti.paddr;
>       skb_cb->vif =3D arvif->vif;
>       skb_cb->ar =3D ar;
> @@ -272,6 +344,8 @@ fail_unmap_dma:
>       dma_unmap_single(ab->dev, ti.paddr, ti.data_len, DMA_TO_DEVICE);
>
>  fail_remove_idr:
> +     if (ti.pkt_offset)
> +             skb_pull(skb, ti.pkt_offset);
>       spin_lock_bh(&tx_ring->tx_idr_lock);
>       idr_remove(&tx_ring->txbuf_idr,
>                  FIELD_GET(DP_TX_DESC_ID_MSDU_ID, ti.desc_id));
> @@ -348,6 +422,10 @@ ath11k_dp_tx_htt_tx_complete_buf(struct
>               return;
>       }
>
> +     if (skb_cb->pkt_offset)
> +             /* Removing the alignment and htt meta data */
> +             skb_pull(msdu, skb_cb->pkt_offset);
> +
>       memset(&info->status, 0, sizeof(info->status));
>
>       if (ts->acked) {
> --- a/drivers/net/wireless/ath/ath11k/dp_tx.h
> +++ b/drivers/net/wireless/ath/ath11k/dp_tx.h
> @@ -17,6 +17,203 @@ struct ath11k_dp_htt_wbm_tx_status {
>       u16 peer_id;
>  };
>
> +/* htt_tx_msdu_desc_ext
> + *
> + * valid_pwr
> + *           If set, tx pwr spec is valid
> + *
> + * valid_mcs_mask
> + *           If set, tx MCS mask is valid
> + *
> + * valid_nss_mask
> + *           If set, tx Nss mask is valid
> + *
> + * valid_preamble_type
> + *           If set, tx preamble spec is valid
> + *
> + * valid_retries
> + *           If set, tx retries spec is valid
> + *
> + * valid_bw_info
> + *           If set, tx dyn_bw and bw_mask are valid
> + *
> + * valid_guard_interval
> + *           If set, tx guard intv spec is valid
> + *
> + * valid_chainmask
> + *           If set, tx chainmask is valid
> + *
> + * valid_encrypt_type
> + *           If set, encrypt type is valid
> + *
> + * valid_key_flags
> + *           If set, key flags is valid
> + *
> + * valid_expire_tsf
> + *           If set, tx expire TSF spec is valid
> + *
> + * valid_chanfreq
> + *           If set, chanfreq is valid
> + *
> + * is_dsrc
> + *           If set, MSDU is a DSRC frame
> + *
> + * guard_interval
> + *           0.4us, 0.8us, 1.6us, 3.2us
> + *
> + * encrypt_type
> + *           0 =3D NO_ENCRYPT,
> + *           1 =3D ENCRYPT,
> + *           2 ~ 3 - Reserved
> + *
> + * retry_limit
> + *           Specify the maximum number of transmissions, including the
> + *           initial transmission, to attempt before giving up if no ack
> + *           is received.
> + *           If the tx rate is specified, then all retries shall use the
> + *           same rate as the initial transmission.
> + *           If no tx rate is specified, the target can choose whether t=
o
> + *           retain the original rate during the retransmissions, or to
> + *           fall back to a more robust rate.
> + *
> + * use_dcm_11ax
> + *           If set, Use Dual subcarrier modulation.
> + *           Valid only for 11ax preamble types HE_SU
> + *           and HE_EXT_SU
> + *
> + * ltf_subtype_11ax
> + *           Takes enum values of htt_11ax_ltf_subtype_t
> + *           Valid only for 11ax preamble types HE_SU
> + *           and HE_EXT_SU
> + *
> + * dyn_bw
> + *           0 =3D static bw, 1 =3D dynamic bw
> + *
> + * bw_mask
> + *           Valid only if dyn_bw =3D=3D 0 (static bw).
> + *
> + * host_tx_desc_pool
> + *           If set, Firmware allocates tx_descriptors
> + *           in WAL_BUFFERID_TX_HOST_DATA_EXP,instead
> + *           of WAL_BUFFERID_TX_TCL_DATA_EXP.
> + *           Use cases:
> + *           Any time firmware uses TQM-BYPASS for Data
> + *           TID, firmware expect host to set this bit.
> + *
> + * power
> + *           Unit of the power field is 0.5 dbm
> + *           signed value ranging from -64dbm to 63.5 dbm
> + *
> + * mcs_mask
> + *           mcs bit mask of 0 ~ 11
> + *           Setting more than one MCS isn't currently
> + *           supported by the target but is supported
> + *           in the interface in case in the future
> + *           the target supports specifications of
> + *           a limited set of MCS values.
> + *
> + * nss_mask
> + *           Nss bit mask 0 ~ 7
> + *           Setting more than one Nss isn't currently
> + *           supported by the target but is supported
> + *           in the interface in case in the future
> + *           the target supports specifications of
> + *           a limited set of Nss values.
> + *
> + * pream_type
> + *           Preamble types
> + *
> + * update_peer_cache
> + *           When set these custom values will be
> + *           used for all packets, until the next
> + *           update via this ext header.
> + *           This is to make sure not all packets
> + *           need to include this header.
> + *
> + * chain_mask
> + *           Specify which chains to transmit from
> + *
> + * key_flags
> + *           Key Index and related flags - used in mesh mode
> + *
> + * chanfreq
> + *           Channel frequency: This identifies the desired channel
> + *           frequency (in MHz) for tx frames. This is used by FW to hel=
p
> + *           determine when it is safe to transmit or drop frames for
> + *           off-channel operation.
> + *           The default value of zero indicates to FW that the correspo=
nding
> + *           VDEV's home channel (if there is one) is the desired channe=
l
> + *           frequency.
> + *
> + * expire_tsf_lo
> + *           tx expiry time (TSF) LSBs
> + *
> + * expire_tsf_hi
> + *           tx expiry time (TSF) MSBs
> + *
> + * learning_frame
> + *           When this flag is set, this frame will be dropped by FW
> + *           rather than being enqueued to the Transmit Queue Manager (T=
QM) HW.
> + *
> + * send_as_standalone
> + *           This will indicate if the msdu needs to be sent as a single=
ton PPDU,
> + *           i.e. with no A-MSDU or A-MPDU aggregation.
> + *           The scope is extended to other use-cases.
> + *
> + * is_host_opaque_valid
> + *           Set this bit to 1 if the host_opaque_cookie is populated
> + *           with valid information.
> + *
> + * host_opaque_cookie
> + *           Host opaque cookie for special frames
> + */
> +struct htt_tx_msdu_desc_ext {
> +     u32
> +             valid_pwr            :  1,
> +             valid_mcs_mask       :  1,
> +             valid_nss_mask       :  1,
> +             valid_preamble_type  :  1,
> +             valid_retries        :  1,
> +             valid_bw_info        :  1,
> +             valid_guard_interval :  1,
> +             valid_chainmask      :  1,
> +             valid_encrypt_type   :  1,
> +             valid_key_flags      :  1,
> +             valid_expire_tsf     :  1,
> +             valid_chanfreq       :  1,
> +             is_dsrc              :  1,
> +             guard_interval       :  2,
> +             encrypt_type         :  2,
> +             retry_limit          :  4,
> +             use_dcm_11ax         :  1,
> +             ltf_subtype_11ax     :  2,
> +             dyn_bw               :  1,
> +             bw_mask              :  6,
> +             host_tx_desc_pool    :  1;
> +     u32
> +             power                :  8,
> +             mcs_mask             : 12,
> +             nss_mask             :  8,
> +             pream_type           :  3,
> +             update_peer_cache    :  1;
> +     u32
> +             chain_mask           :  8,
> +             key_flags            :  8,
> +             chanfreq             : 16;
> +
> +     u32 expire_tsf_lo;
> +     u32 expire_tsf_hi;
> +
> +     u32
> +             learning_frame       :  1,
> +             send_as_standalone   :  1,
> +             is_host_opaque_valid :  1,
> +             rsvd0                : 29;
> +     u32
> +             host_opaque_cookie   : 16,
> +             rsvd1                : 16;
> +} __packed;

we should not be using bitmasks with packed in upstream code.
QSDK may have done this, but it's not ok upstream
and why isn't this being added to hal_desc.h?


> +
>  void ath11k_dp_tx_update_txcompl(struct ath11k *ar, struct hal_tx_status=
 *ts);
>  int ath11k_dp_tx_htt_h2t_ver_req_msg(struct ath11k_base *ab);
>  int ath11k_dp_tx(struct ath11k *ar, struct ath11k_vif *arvif,
> --- a/drivers/net/wireless/ath/ath11k/mac.c
> +++ b/drivers/net/wireless/ath/ath11k/mac.c
> @@ -10324,6 +10324,9 @@ static int __ath11k_mac_register(struct
>               goto err_free_if_combs;
>       }
>
> +     ar->hw->wiphy->interface_modes |=3D BIT(NL80211_IFTYPE_AP_VLAN);
> +     ar->hw->wiphy->software_iftypes |=3D BIT(NL80211_IFTYPE_AP_VLAN);
> +
>       if (!ab->hw_params.supports_monitor)
>               /* There's a race between calling ieee80211_register_hw()
>                * and here where the monitor mode is enabled for a little
> --- a/net/mac80211/tx.c
> +++ b/net/mac80211/tx.c
> @@ -40,6 +40,10 @@
>
>  /* misc utils */
>
> +static void ieee80211_8023_xmit(struct ieee80211_sub_if_data *sdata,
> +                             struct net_device *dev, struct sta_info *st=
a,
> +                             struct ieee80211_key *key, struct sk_buff *=
skb);
> +
>  static __le16 ieee80211_duration(struct ieee80211_tx_data *tx,
>                                struct sk_buff *skb, int group_addr,
>                                int next_frag_len)
> @@ -4257,6 +4261,7 @@ void __ieee80211_subif_start_xmit(struct
>  {
>       struct ieee80211_sub_if_data *sdata =3D IEEE80211_DEV_TO_SUB_IF(dev=
);
>       struct ieee80211_local *local =3D sdata->local;
> +     struct ieee80211_key *key =3D NULL;
>       struct sta_info *sta;
>       struct sk_buff *next;
>       int len =3D skb->len;
> @@ -4281,5 +4286,15 @@ void __ieee80211_subif_start_xmit(struct
>       if (IS_ERR(sta))
>               sta =3D NULL;
>
> +     if (sdata->vif.type =3D=3D NL80211_IFTYPE_AP_VLAN &&
> +         get_bss_sdata(sdata)->vif.offload_flags & IEEE80211_OFFLOAD_ENC=
AP_ENABLED &&
> +         !is_multicast_ether_addr(skb->data)) {
> +             if (sta)
> +                     key =3D rcu_dereference(sta->ptk[sta->ptk_idx]);
> +             ieee80211_8023_xmit(sdata, dev, sta, key, skb);
> +             rcu_read_unlock();
> +             return;
> +     }
> +
>       skb_set_queue_mapping(skb, ieee80211_select_queue(sdata, sta, skb))=
;
>       ieee80211_aggr_check(sdata, sta, skb);


