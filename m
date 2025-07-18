Return-Path: <linux-wireless+bounces-25650-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 78DCAB09EE5
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Jul 2025 11:15:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86A92177470
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Jul 2025 09:15:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0FA7298267;
	Fri, 18 Jul 2025 09:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="EdYT4YgT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CBA8298261
	for <linux-wireless@vger.kernel.org>; Fri, 18 Jul 2025 09:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752830129; cv=none; b=qIKbsL+6pTKJ7Ro9gguakpAzKU7DQvoqO5PL82dvCgo+y1T9Qk0dYUQRGvQfDGI60zMtehP+H3XnjaAMhpdCELGFxwurTuGcFmyQPV9gZjz+cjFC3fLX6qnl1CcQJnFxE0ImGuAZzL3iR9gEKf12QRitXfMeiqiAiEPElx9Y9qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752830129; c=relaxed/simple;
	bh=OirKHy6cmPZm5+tt+jd/N5BcMkSgFa4hTzP5z7TzfuE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Kg5Zr425/IDASmsHyGlY6u/CpkyzZAM0iWoM1MmBaSzHgusq7rls3KQY2iXkXl4JSsAFEZZx5vp05mdEKbdSLqFaLQGBCxtfHmrmjc6WNbcrXK+CDKtSU8Xnic7ohp4sOWk5kha9Qs5mJFgqCAYEkWZJV6KjnvJ1YbcBCtuBa/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=EdYT4YgT; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 56I9Cr9821358635, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1752829973; bh=JU/D1u80IAGlxNvBKN9XLOhXRwokeSEddkNQjmjDT6Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=EdYT4YgTNfTWufUyh31G1xVn7VUfmPyOYdVfizCWwrPLOhRdcFAffKzXz8votfxgV
	 3xv9/63YxnTN+162ETBFUrgaF4Jd416M1VKQs/7sMgGQ8prCR/BWi9CirRuJ3KvYLm
	 aUc7sU2DW4076BetHu0yTmby41GEnNUr0Aap3YzMUQqCtDbr0xCamuTKE7QqusYhh/
	 6mfMqGGiFs9Eoq3iv+RSPMe/xblxKvM4+55BNfhqnIsJnavtaen2IzbKCb2OOruUsU
	 xYOzUj5/H36vSmBvV8jOEKUEnZsEQhos6ZKEijvE9gBiUSQHzzwrDDzXbMmRhiVUxd
	 mJLIE8rLjKD6A==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 56I9Cr9821358635
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Jul 2025 17:12:53 +0800
Received: from RTEXDAG01.realtek.com.tw (172.21.6.100) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 18 Jul 2025 17:12:54 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG01.realtek.com.tw (172.21.6.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 18 Jul 2025 17:12:53 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::81fc:50c6:85d5:cb47]) by
 RTEXMBS04.realtek.com.tw ([fe80::81fc:50c6:85d5:cb47%5]) with mapi id
 15.01.2507.035; Fri, 18 Jul 2025 17:12:53 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Nithyanantham Paramasivam <nithyanantham.paramasivam@oss.qualcomm.com>,
        "ath12k@lists.infradead.org" <ath12k@lists.infradead.org>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH ath-next v2 2/3] wifi: ath12k: Fix TX status reporting to mac80211 when offload is enabled
Thread-Topic: [PATCH ath-next v2 2/3] wifi: ath12k: Fix TX status reporting to
 mac80211 when offload is enabled
Thread-Index: AQHb9490SpnHrcjKUkyO9X2R+DBAhLQ3mHNw
Date: Fri, 18 Jul 2025 09:12:53 +0000
Message-ID: <1ae4000edd954cf492e95bdb059c89b2@realtek.com>
References: <20250718025513.32982-1-nithyanantham.paramasivam@oss.qualcomm.com>
 <20250718025513.32982-3-nithyanantham.paramasivam@oss.qualcomm.com>
In-Reply-To: <20250718025513.32982-3-nithyanantham.paramasivam@oss.qualcomm.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

> @@ -578,6 +579,8 @@ ath12k_dp_tx_htt_tx_complete_buf(struct ath12k_base *=
ab,
>         struct ath12k *ar;
>         struct sk_buff *msdu =3D desc_params->skb;
>         s32 noise_floor;
> +       struct ieee80211_tx_status status =3D { 0 };

With '=3D {}', no matter how the struct changes, you don't need to change t=
he
code accordingly.=20

> +       struct ath12k_peer *peer;
>=20
>         skb_cb =3D ATH12K_SKB_CB(msdu);
>         info =3D IEEE80211_SKB_CB(msdu);

[...]

> @@ -805,6 +830,12 @@ static void ath12k_dp_tx_complete_msdu(struct ath12k=
 *ar,
>         struct ath12k_vif *ahvif;
>         struct sk_buff *msdu =3D desc_params->skb;
>         s32 noise_floor;
> +       struct ieee80211_tx_status status =3D { 0 };
> +       struct ieee80211_rate_status status_rate =3D { 0 };

ditto.

> +       struct ath12k_peer *peer;
> +       struct ath12k_link_sta *arsta;
> +       struct ath12k_sta *ahsta;
> +       struct rate_info rate;
>=20
>         if (WARN_ON_ONCE(ts->buf_rel_source !=3D HAL_WBM_REL_SRC_MODULE_T=
QM)) {
>                 /* Must not happen */




