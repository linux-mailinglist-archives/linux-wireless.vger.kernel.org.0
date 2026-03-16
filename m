Return-Path: <linux-wireless+bounces-33289-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cABgAszNt2mDVgEAu9opvQ
	(envelope-from <linux-wireless+bounces-33289-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Mar 2026 10:30:52 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DEE0297050
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Mar 2026 10:30:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 555103003813
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Mar 2026 09:30:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B48325228D;
	Mon, 16 Mar 2026 09:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=georgmueller@gmx.net header.b="dPkHjyhw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F52CEEBA;
	Mon, 16 Mar 2026 09:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773653449; cv=none; b=GYi8i35QrQgcMdDEEpleuhV60vYdlf/7k93M4mOMq0xEtglIigKEA1YuTIPWnp1jx5C5X/Bmhzil9oV7bqqaofw4Vhf1Cmb3K+4QTIOjHkQLCzpQIJkP5B5KtUuE462nCS6MAfcLmLZnbBKVWWuSJDCh1JXPboGBL0sRByVDKrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773653449; c=relaxed/simple;
	bh=RA5akNJMdz38Uq9J939H0rhBqEtcmL2xZcP7ommNiLo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y0tRfo9wK+2VcR4YzONjJntswwKW5fFw8luiabZoEQUw3FXEiZhI8RYQjX+/4aDOt04ksRgB49bJZabMufTJ5Hn80wMW+2IGARP8Ch6n4GuBJ7c5qphf2LrV8i02jR4ErL0o3sdcABAPyzjaBNUB1dKThu+bwfel0rMFK7eZeRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=georgmueller@gmx.net header.b=dPkHjyhw; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1773653445; x=1774258245; i=georgmueller@gmx.net;
	bh=RA5akNJMdz38Uq9J939H0rhBqEtcmL2xZcP7ommNiLo=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=dPkHjyhwsPGLjvx2n3cAPw/ooJnMlrHPf6jxZr8KC2I+hsHx+u0zymzFpjVPmNeK
	 mnQgH3lXBkG2vmPQZV85HAqXCSt1SJ2PhJNMWcOP6qQFXTqMgjzpgNFRFZo2b7c0d
	 f65J8ykfO/ZF+QoDPVWsKF+lMaEfYu/DHkFSmXdNF1Qf7CkdbG597AGjau+zl563h
	 PTefaKI41N63WAfz5nxnXWTu2Zy16xTIVKWPClGpYh8NOZCTpQoRMKuJNf93FmiPx
	 mexJo4ROfR4GsFowDiOAYjNECgnBLj0TLa0/8w2Xyyk7pkHIIkuNskMA26MfuLciU
	 w/OwfcG3Pw34bMfNkA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N33Ed-1vcJAn0Nhd-013cXb; Mon, 16
 Mar 2026 10:30:44 +0100
Message-ID: <3724d77a-8aa4-40ec-9a4a-644cb1439837@gmx.net>
Date: Mon, 16 Mar 2026 10:30:43 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 1/4] wifi: rtl8xxxu: move
 dynamic_tx_rpt_timing_counter from ra_info to priv
To: Ping-Ke Shih <pkshih@realtek.com>,
 "Jes.Sorensen@gmail.com" <Jes.Sorensen@gmail.com>,
 "rtl8821cerfe2@gmail.com" <rtl8821cerfe2@gmail.com>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20260313135321.3196688-1-georgmueller@gmx.net>
 <20260313135321.3196688-2-georgmueller@gmx.net>
 <fbd2420985544f858374468d25e848f5@realtek.com>
Content-Language: en-US, de-DE
From: =?UTF-8?Q?Georg_M=C3=BCller?= <georgmueller@gmx.net>
In-Reply-To: <fbd2420985544f858374468d25e848f5@realtek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:cW6T5nNe7TgpKMi7tI35hM5VDoZuokLpP/pQ7Z/hodjax7AvmmF
 x8G1xvJDUydCeZbk1wsrZe6fKqtCSn+Jtj+FxqXxvBBebQH4rfKxJblnUzCxPS5gR9I7XAh
 NPdhBDwiVpqa8IKfPXxZ4tQ4aQVVDZjAjro5/MVuEFlWz8OGbIG2BcPPzM/uaFpZGH/+pY0
 rrlU0G6H7xGaC0JD36Nsg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:qo/rLLMtkG0=;54UtrWGRlBQFrJEyWVW+LB/Dt5p
 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
 Fbk1kXmctkwe4UU9ksCp6ZK+FFC5Mbapg==
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmx.net,quarantine];
	R_DKIM_ALLOW(-0.20)[gmx.net:s=s31663417];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[realtek.com,gmail.com];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmx.net];
	TAGGED_FROM(0.00)[bounces-33289-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[georgmueller@gmx.net,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmx.net:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9DEE0297050
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


Am 16.03.26 um 07:17 schrieb Ping-Ke Shih:
>=20
> Georg M=C3=BCller <georgmueller@gmx.net> wrote:
>> dynamic_tx_rpt_timing_counter is not per mac_id, but used across all
>> mac_ids.
>=20
> I don't know the purpose of dynamic_tx_rpt_timing_counter. Could you
> share your study?
>=20
It is used globally (not per mac) like this in the vendor driver as well [=
1][2].
Bitterblue Smith gave the hint that this should not be per macid [3], so i=
t should move
out of struct ra_info.

[1] https://github.com/lwfinger/rtl8188eu/blob/master/hal/Hal8188ERateAdap=
tive.c#L248
[2] https://github.com/lwfinger/rtl8188eu/blob/v5.2.2.4/hal8188erateadapti=
ve.c#L285
[3] https://lore.kernel.org/linux-wireless/938ae608-a865-4056-06de-c230d74=
e1847@gmail.com/


