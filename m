Return-Path: <linux-wireless+bounces-39010-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id pH5rFBTeVWpaugAAu9opvQ
	(envelope-from <linux-wireless+bounces-39010-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 08:58:28 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E5EC9751B2B
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 08:58:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=realtek.com header.s=dkim header.b=mI76qIyr;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-39010-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-wireless+bounces-39010-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=realtek.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6078A301CD26
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 06:58:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25B823DEAEC;
	Tue, 14 Jul 2026 06:58:26 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 031022F8E94;
	Tue, 14 Jul 2026 06:58:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784012306; cv=none; b=sYPGqXoZZNp+glvunpLJIBcfYAuu0Cft5YPFmhcmFsHX6rGRfZXexwhp0RWXDm8UjNlMKOPsn5rCQwT5pRO6fxlKAnbVwoFun6Py1SBNcT0CrvrZq8HdgeugIa7e7EEAumG0xmk+iLR8a11LVMDruzH1r88pAdfbE2bYf9vSO10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784012306; c=relaxed/simple;
	bh=fuQ2RRXqFek06eApOhqhlpG77IQplSqVaqzdgmRdqhw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CTNQ4mV2Xok/GTHuSqkeV1y45PtAaJjkxNrX9INTpjPwbUaqrQ5ljo2c05yUY6BNQ04QnL4OsuJsPX+Et51sdkm38600L7fw7uZJUcygZInwgM0hsYlpEm1pq4OwbCeKmHemnmkt4ABlmWZ+PHdYMBIU/7XnklOuGYHdOaJM1jQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=mI76qIyr; arc=none smtp.client-ip=211.75.126.72
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 66E6vmvsF1943012, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1784012268; bh=iGj48yemdWauySdVEsdnGgJJ0oT9G63LD8JsctGOIY8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=mI76qIyrAvl+Y0uGC+dY+9eJWZZJ88t5FcDyCv2Lk4AnrJmGW7LQ2/z11uKF0FmWn
	 wai2Xkkh87mUdQm6q1MH8SJG6swP+nNuShcb1b8486SiUkB/wBU+RNaGB/ZfqYOI+x
	 7CgEJqQvbiaRgGND++eke8Ks1QQtS9QQjaa9s9I6ficw1bEdwbIt5+BzssFwSIErYN
	 a1XcnF7X4BqTSWlswpxmw3F2Mb8KvoOMrtnTzSGmxd08eeWsbixlCi6oRHrE+cexKU
	 lVVDCKFVaP0mmqbVWLqwE1VrZMBKI4bSi5PgDYFS1mT3NzNgeLPJksHvYXZBAKR3DS
	 6SCofsn5kUhkg==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 66E6vmvsF1943012
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 14 Jul 2026 14:57:48 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 14 Jul 2026 14:57:44 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS06.realtek.com.tw (10.21.1.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 14 Jul 2026 14:57:43 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([::1]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::e6fd:5a3f:8946:92c4%10]) with mapi id
 15.02.2562.017; Tue, 14 Jul 2026 14:57:43 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>, Jeff Johnson
	<jjohnson@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"ath12k@lists.infradead.org" <ath12k@lists.infradead.org>
Subject: RE: [PATCH] wifi: ath12k: Constify struct ath12k_dp_arch_ops
Thread-Topic: [PATCH] wifi: ath12k: Constify struct ath12k_dp_arch_ops
Thread-Index: AQHdE1uKB+sp9zTsUkKJ8dFek3N2uLZslSiQ
Date: Tue, 14 Jul 2026 06:57:42 +0000
Message-ID: <2efa694140ce418c8d83a62d3f7b5309@realtek.com>
References: <469d732e2c6f159e1a05e89c7e417c3a10db5fdf.1784010931.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <469d732e2c6f159e1a05e89c7e417c3a10db5fdf.1784010931.git.christophe.jaillet@wanadoo.fr>
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:christophe.jaillet@wanadoo.fr,m:jjohnson@kernel.org,m:linux-kernel@vger.kernel.org,m:kernel-janitors@vger.kernel.org,m:linux-wireless@vger.kernel.org,m:ath12k@lists.infradead.org,s:lists@lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_TO(0.00)[wanadoo.fr,kernel.org];
	FORGED_SENDER(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-39010-lists,linux-wireless=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[realtek.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E5EC9751B2B

Christophe JAILLET <christophe.jaillet@wanadoo.fr> wrote:
> --- a/drivers/net/wireless/ath/ath12k/wifi7/dp.c
> +++ b/drivers/net/wireless/ath/ath12k/wifi7/dp.c
> @@ -139,7 +139,7 @@ static int ath12k_wifi7_dp_service_srng(struct ath12k=
_dp *dp,
>         return tot_work_done;
>  }
>=20
> -static struct ath12k_dp_arch_ops ath12k_wifi7_dp_arch_ops =3D {
> +static  struct ath12k_dp_arch_ops ath12k_wifi7_dp_arch_ops =3D {

Did you miss 'const' here?



