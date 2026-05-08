Return-Path: <linux-wireless+bounces-36102-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4Pu8FhJd/WlWbgAAu9opvQ
	(envelope-from <linux-wireless+bounces-36102-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 08 May 2026 05:48:34 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ACF214F13E4
	for <lists+linux-wireless@lfdr.de>; Fri, 08 May 2026 05:48:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E49243012279
	for <lists+linux-wireless@lfdr.de>; Fri,  8 May 2026 03:48:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 340381DED49;
	Fri,  8 May 2026 03:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="TpA6qMUp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A53E78635D;
	Fri,  8 May 2026 03:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778212110; cv=none; b=Ci+8dnzpnmH5o2ZmqyVo3Szm15Rhtofn9zFsD1OM8Na9actCe4fBIYHLQBnlUnF4iuBgRMFfXXa4Yc/HaevUYgM7yR7qWGorWxrOTQI1kyMAUiotM+bwDGTCI5plv6ZknyalJYuTdSSrEcjIpqdv8bEvq76dmBsAMaljT7Y7CkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778212110; c=relaxed/simple;
	bh=Ew6WsWTrCBF43nJTsVchBpjPneRvLPU+kPRd/GxiwQo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GKI0rwmAP19pfOfGMnwI3z6rcPtG8EpC3REsgeqH4CV1cCxk6/UgIDHShFFeROxCYjJYbTrb4j8xnu5c5s/26maI8V2+uJbBg7Kps20BPhaXh+Ir10xT0oQ/O5pNSFPr3BhkZ0jTfvqAwj5L8zlJJz8nImJupxk80CMV7+98/00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=TpA6qMUp; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6483ltQX33294524, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1778212075; bh=nKZm2WflV2gJiTosq9kMkwvEOp3n+ZhHXYJyc8vhXBA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=TpA6qMUpeWk//KakLkpEn2Z36XGnUqbWIytqJ2HiL5nI0ICLd1f8KUOhyGgJx1O0t
	 ef51cmhZd8Dpk67n7sAjhyeraIqzqAX+2w6fo552vB5uwvUEHRUr/1Kxrh0rU+lQY+
	 VTamqm8VeBVvHFGne4aPFcSB57B1dSwgFyoE1+cYfFy1JQZ8vLWQ2KbHa2T7XXJ7iJ
	 a3ZGhbsFhGnDgpJw1PpuBwhu+haqVCL3DHfTlCisqmLuTT3nDD0VHlUCtswCe64v02
	 k/ZT54zOC29sGmOkFigi9lix2DEl3XlEC7H8jFsFAf2vBRKtr2abk7SY9LUN85u75a
	 dcDrlw799dFLg==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.27/5.94) with ESMTPS id 6483ltQX33294524
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 8 May 2026 11:47:55 +0800
Received: from RTKEXHMBS01.realtek.com.tw (172.21.6.40) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 8 May 2026 11:47:56 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS01.realtek.com.tw (172.21.6.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 8 May 2026 11:47:55 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([::1]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::e6fd:5a3f:8946:92c4%10]) with mapi id
 15.02.2562.017; Fri, 8 May 2026 11:47:55 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: "luka.gejak@linux.dev" <luka.gejak@linux.dev>,
        Kalle Valo
	<kvalo@kernel.org>
CC: Sascha Hauer <s.hauer@pengutronix.de>,
        "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH v2] wifi: rtw88: usb: fix memory leaks on USB write
 failures
Thread-Topic: [PATCH v2] wifi: rtw88: usb: fix memory leaks on USB write
 failures
Thread-Index: AQHc3j/OOu/4/utTZEaDbodmaqilHLYDe5ug
Date: Fri, 8 May 2026 03:47:55 +0000
Message-ID: <25a127932474456f862b0a20f7c60b65@realtek.com>
References: <20260507163709.73581-1-luka.gejak@linux.dev>
In-Reply-To: <20260507163709.73581-1-luka.gejak@linux.dev>
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
X-Rspamd-Queue-Id: ACF214F13E4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,realtek.com:mid,realtek.com:dkim,linux.dev:email];
	TAGGED_FROM(0.00)[bounces-36102-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[realtek.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

luka.gejak@linux.dev <luka.gejak@linux.dev> wrote:
> From: Luka Gejak <luka.gejak@linux.dev>
>=20
> When rtw_usb_write_port() fails to submit a USB Request Block (URB)
> (e.g., due to device disconnect or ENOMEM), the completion callback is
> never executed.
>=20
> Currently, the driver ignores the return value of rtw_usb_write_port()
> in rtw_usb_write_data() and rtw_usb_tx_agg_skb(). Because these
> functions rely on the completion callback to free the socket buffers
> (skbs) and the transaction control block (txcb), a submission failure
> results in:
> 1. A memory leak of the allocated skb in rtw_usb_write_data().
> 2. A memory leak of the txcb structure and all aggregated skbs in
>    rtw_usb_tx_agg_skb().
>=20
> Fix this by checking the return value of rtw_usb_write_port(). If it
> fails, explicitly free the skb in rtw_usb_write_data(), and properly
> purge the tx_ack_queue and free the txcb in rtw_usb_tx_agg_skb().
>=20
> The issue was discovered in practice during device disconnect/reconnect
> scenarios and memory pressure conditions. Tested by verifying normal TX
> operation continues after the fix without regressions.

Did the memory pressure condition happen? and falls into the cases you are
adding? This is main thing I want to know.

>=20
> Fixes: 87caeef032fc ("wifi: rtw88: Add rtw8723du chipset support")

I don't find this commit touching the code related to this patch.

> Cc: stable@vger.kernel.org
> Tested-by: Luka Gejak <luka.gejak@linux.dev>
> Signed-off-by: Luka Gejak <luka.gejak@linux.dev>
> ---
> Changes in v2:
>  - Use ret =3D rtw_usb_write_port(...); style, and check by next line (in
>    rtw_usb_tx_agg_skb)
>  - Remove unnecessary comment
>  - Use ieee80211_purge_tx_queue() instead of skb_queue_purge()

If it falls into the case, you will see some warnings without this change.

Again, I'd like to know if OOM can happen in your test? If not, the test
you are doing will prove nothing, since your changes are executed only if O=
OM.

>  - Add testing details to commit message
>=20


