Return-Path: <linux-wireless+bounces-31400-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SJwwHTPjfGkQPQIAu9opvQ
	(envelope-from <linux-wireless+bounces-31400-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Jan 2026 17:58:27 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E6FFEBCBDB
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Jan 2026 17:58:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CF7AA300B993
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Jan 2026 16:58:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 957BB2FCBE3;
	Fri, 30 Jan 2026 16:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mVkltYis"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FBC77260A
	for <linux-wireless@vger.kernel.org>; Fri, 30 Jan 2026 16:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769792303; cv=pass; b=G1iraYw1SinPGnsbfWJEQnRDyyPyjKJ7k3vMpRZg1EgSSPBjaLMx8kWHJwkX2BQwl0IO8CEzIZaCCP0vfAP9NePYrHypTNjP3FS4ulSkWJCRXnEf6SeVIfvwWIAKB21pxFridswjyfEJoQhQVIcLO2s69Q4R7Xt2gCRUb6SEmik=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769792303; c=relaxed/simple;
	bh=jlM6M3vVEOZAFoBsjIcK1MxkCAGcEMxMkkYPrCY4M6I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p0KEjKC3bX1zlhbrMhg9s4/ZQCZb60WaSnDc7SX0+ifgY1E1vhsxhXgs6X5PNk6WLrsK2PALAmKpJByGlSBLAxtbKIwRqMVQqyJMpy965n/FVPiPrw90pWNFgQRis0r5nQvfaXw9Gd4Q9+kITdgIk5cj0SYyOwAs8+BkTBkrFT4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mVkltYis; arc=pass smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-40429b1d8baso779353fac.0
        for <linux-wireless@vger.kernel.org>; Fri, 30 Jan 2026 08:58:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769792301; cv=none;
        d=google.com; s=arc-20240605;
        b=V0U4LqI3/wBTmKoiQjUGM8OGeBopO9BF4+AbLJLAS+Mo/l9H/+TtAaiHPUmP46daLN
         0HgHifsxWSJs5bXu9X0hGxx4dOC3dC7gp6L/C2gN5FlhaRHeKQkexbkNaJiL7kZdBdhY
         r5UtPykBcOtaA9+KHCUCpInIOV0t4PLBkJZzAHJiokq6TmMBaJJFddCD0DSDNYcqy89V
         gMQ1iRtRFEiD+NIAM5g3kWAkPUBjotXJQFdt4br7cVrWXQ8sGAfZ12xG+uBPSbOo4z8L
         ETR2J4sVfuNx8x68a5qe6V8EZ94XKCdwXNZd29WkO/A2NNC1Ffe1YT5NASf5Juej3H9/
         kR8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CwcaydE45ESxTrDz7XDLei5I1JlkRwsNKhO8IM9xIRk=;
        fh=zFCB9yj6tbPtiNOgT9n/qK9LnQKfgtX1AWhCxXtoerY=;
        b=U+B2uRVwrqW52DjdRy+kjwTpuvsUIGQj/Czo42J5QFamrbb1kWNTloE6nTV/4YClth
         mYaXThnZHp5Tc5+krhzIOe52Lss3biogWF9z5JQBSjPLSFDISnDORtvQwvAK/lI5dFM1
         MqSNHmZKt1mPASBUiOfNRQbn7WpehmgLd8o1iU6yWX0wQBBEDLRhAfWYbAKn1qIRF7Xw
         SeC3U8azMpjkRC3LXhb57/7jdL4qBUXUtaWGb33mbVqQFHG/lZK7Uj/Wc3hK0toU8Awx
         ZNdXoBXJRhRo2XiyhcFA3xCj7nUcaj7s36JjbcmUBy8kebrbaESiXiEP/CPaYhAqsypJ
         Qehw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769792301; x=1770397101; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CwcaydE45ESxTrDz7XDLei5I1JlkRwsNKhO8IM9xIRk=;
        b=mVkltYiswAPWaqkipm7sI5RzJ2Zc78r6AFkOp/Qc1FJbSa5S9RasK6p6hMdoQMkGZJ
         a4eUE5mPpUmnlOtpW+zmFVQQuD8ugMOZBngI1u+bGQJlD5klSmU4IDwcKHBjfNtv0YGJ
         TdXAhKyKJQDG0gjGTGip1H8vGG6jJxqjZs89TAPSAUuew2EJsJOsn4l0WnlrjBKRTMbH
         dWGL0bNifm09ywx2GjhHSg+lzNBoZb4qcq/e4E6iU5KGhtkSlba7xy9T4scxon9v/x6M
         Vpp2qqOpSoWomi1QFd9Zbk/NAiz0BnLYLGaoIbrmnme5JEnRjTeuVix5JJkWJUqZ2kCM
         rA5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769792301; x=1770397101;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CwcaydE45ESxTrDz7XDLei5I1JlkRwsNKhO8IM9xIRk=;
        b=mWSrw+MXrbhXgbmdHEDiJ9Fug8S37HL6Vsrw732/vBB7OIU+Lqd7VgIC+fsZ/XiN4L
         ilfDmENBPyCWbFKvWMBqyFJzpTZ/d3H9Zv/gnL7yNeGiqB59Eedp2W8YXkKYhwATZ4Tu
         ZzqQSRIjf6PTdp1kubkDc4s4h9PG4iu8K7LVcu/PIXBSFbizvQRssnAaI4W7JMdSdCK2
         88bN0DJ17kQOOBRWaL0HkMhpelVZXIVVU1Xk669uFgYrX0Oyb+UVlEPzgRTebfe6AZYX
         WAVubeLlz0nDxBdSAoqEZh9XwB/XQWVYncMd87mUixctMJtyygxsBaeiC58o0jmlcnDS
         a7Sw==
X-Gm-Message-State: AOJu0Yw0AUheJDqc9Pvl/SrBepPZShb/qlM9dpwSTBa5TLcP2XPYieaH
	0IgaIowMlkqZXAK/CKC1PGRFnOPY5uJUxQnhgvrfAi27sXGofM1ZpWi1/CpLlAkeaCB2ZR557nk
	8G3eX/SqAnEU/OzOdV29oSI2sRLYXBmAS+47DCnA=
X-Gm-Gg: AZuq6aIzhNDE6dmP7o8ipU4mrGHeWspp0k5KLtr5tAt6dViPGZ0s6IEfLM/JRL2qFkL
	VXdLK30Eh8RkDaPhXpkEfo9tWM93oHVmCsMRX5qOxu5MKSqYzI9/JOPSW3DfDsr4APPjfuMqeGz
	MZ2hvPlR66AdZbnfqgsOYUQ63ZZVU0P7d8mj0iTAWnSw7tOOrhNlDdx80me1+w9fEBn6xME3zil
	LatHgIcIK3Ri0R7OmZfdHe51YECAL9MsdY+hxB72a64D+XmXMnGZWxARbS+1AOI9Tk3ew==
X-Received: by 2002:a05:6820:1694:b0:663:bf:a135 with SMTP id
 006d021491bc7-6630f00434fmr1728884eaf.11.1769792300970; Fri, 30 Jan 2026
 08:58:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPVS0eKn3zEyRekrQP_K3W5n5iVZ44nXkUAAE2=KkNcpq+LeYg@mail.gmail.com>
 <f730f3ca7b1d4fd08795831e13cc8f2f@realtek.com>
In-Reply-To: <f730f3ca7b1d4fd08795831e13cc8f2f@realtek.com>
From: Iohann Tachy <iohann.tachy@gmail.com>
Date: Fri, 30 Jan 2026 13:58:09 -0300
X-Gm-Features: AZwV_QiOzf_77FWIoVgQUmUA-Dt2AaZaxK10rvieqeNBvPIGTBwJ97287ZTmnJA
Message-ID: <CAPVS0eKLicu1Y+MUpLcuwqTU0agEn9m7zyOO_5rgB3vA+gM9Bg@mail.gmail.com>
Subject: Re: Problems building rtw89
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-31400-lists,linux-wireless=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[iohanntachy@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E6FFEBCBDB
X-Rspamd-Action: no action

Good afternoon!
I'll run the " - dmidecode
 - lspci -vt
 - lspci -x"
commands today evening.
and I'll let you know what's the output results.

Regards,
Iohann

On Thu, Jan 29, 2026 at 9:36=E2=80=AFPM Ping-Ke Shih <pkshih@realtek.com> w=
rote:
>
> Iohann Tachy <iohann.tachy@gmail.com> wrote:
> > Good morning,
> >
> > Currently there's an issue where it's not possible to build the rtw89 d=
river.
> > The RTL8852BE card has a compatibility problem with Intel X99 chipset
> > and a hacked rtw89 driver is needed to make it work.
> >
> > I kindly request to read the Github issue:
> > https://github.com/lwfinger/rtw89/issues/396
>
> A fix in Github is to disable 36-bit DMA [1]. I'd like to collect platfor=
m
> info to add a quirk. Please share outputs of below commands
>  - dmidecode
>  - lspci -vt
>  - lspci -x
>
> [1] https://github.com/a5a5aa555oo/rtw89-1/commit/629756ee0232089d298bb39=
8790d4a745b950058
>
>

