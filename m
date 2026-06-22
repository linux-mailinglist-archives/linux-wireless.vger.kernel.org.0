Return-Path: <linux-wireless+bounces-37979-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id B1ouFiVLOWpsqAcAu9opvQ
	(envelope-from <linux-wireless+bounces-37979-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Jun 2026 16:48:05 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D14206B0734
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Jun 2026 16:48:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=fastmail.com header.s=fm1 header.b=fo52QLK1;
	dkim=pass header.d=messagingengine.com header.s=fm1 header.b="E F2zwWm";
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37979-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37979-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=fastmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4960A3013B86
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Jun 2026 14:48:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C29F30B521;
	Mon, 22 Jun 2026 14:48:03 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 894B130ACFF;
	Mon, 22 Jun 2026 14:48:00 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782139682; cv=none; b=Ll35qzz7+w+alopQi7Grtsf6FR0yx9pJIT0qdRpu7Yt3cb3tgLldvAEKd6ZpeW0ntqffhQxQauvtbslKPAlFSSvxKuON5Rcy1t0N9QFPSTYvMUskex5xYgRCrny2GBB1jyJe/OkXgEjZkMAQpVNc9u/Adw6QSaoya+lCr7dEKVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782139682; c=relaxed/simple;
	bh=LRqT9CXP94vcXNi8mfrbufiq2p7n+Jh9AbhFwXkS8Cg=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=pT7uGuUNa6MjCVK4iRKkMEvCpmTihUCmmUKEy0h3VbF6rFKxdKnlxYIUg7iimDlwEmCyPcG0PmTqNkXod5uF91saSjfKUs2BmPJBsOp5/0UzBWkdGUIDYo6N8uuLUBN+6dFiu+0g9CXcDj8hYW2I7bEB3Rjz0akP6UYwNpUPfkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=fo52QLK1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EF2zwWms; arc=none smtp.client-ip=202.12.124.154
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 6F2757A0177;
	Mon, 22 Jun 2026 10:47:59 -0400 (EDT)
Received: from phl-imap-05 ([10.202.2.95])
  by phl-compute-10.internal (MEProxy); Mon, 22 Jun 2026 10:47:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1782139679;
	 x=1782226079; bh=M2659gtcxMVEQZO4mkI1E6kleF2yDmchAhllkLWkU/Y=; b=
	fo52QLK1URlzttdkmJlYezKrHz6sm1rYWQCcO2WRvY8zw1IP0D3XkJhLCcCg6emk
	Ni80vqNj4Jc7Y35+A2DKaoCH3vSAT2+TQ6LfrfGNdQIZK9bDeJqKI92fxaSIxyBf
	G/pEvrACwwk25tDRbvurAIPFP0YrmdJdw5wSV285MjBFJulyDjXgzixBymlz+9iw
	5xIhRdQMNJW/zrxs9GX7CwCU0V8I4TVSjMBZPZnEhw9D/rtlkp+h3XTyMd1ErMsN
	900LEKXkhiqe6oQwQCOwFOQ9W3qnYkV9CNusX4Cu+uqMrzrvXHfxweIhV2uyeJ2d
	Dwkk+lXP1S76TZRKA2pN9A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1782139679; x=
	1782226079; bh=M2659gtcxMVEQZO4mkI1E6kleF2yDmchAhllkLWkU/Y=; b=E
	F2zwWmsvn8XpjTPxAcD5AW6tFjdpBdL2V1N5MQTrwOUbTdsHgWQx4nPgBcAGl0PP
	KUp4YZZOkbz+JFBrsGJDKxVu8/A7273fhecu0CX2f5VWei4M5nEnkg5+eFijVzo6
	mpNQk8CSSfBlkKhCEsHUKCffb0VWi6nGZ1xOqA6YsDfSEz0xsOmoBU7QrpGPuIGF
	v5DkMqqp+/ipAig660X6+v9e+k1EwXnJHOhD0zsmNQdH5WuZTemFR4LjLdHxbyrW
	wqmAvwxYPoeR9JohnC/NTavi5uEqtn5Ule02Dxb4BFxcet8ELGepf8hnjkMXSuVz
	/Qkq2/RnjjB+J7mBg2I0Q==
X-ME-Sender: <xms:H0s5apescLhiaE2TD1izIUoXBy_Wc11wf2VNamwLOHTbOvDDOfOeFg>
    <xme:H0s5aiD6y6sVGxScSfclx1Qw8fsijjLKmmfeyiPezdnKtSXm5qjAd4jxFJWrjjHU8
    SYwpnPQqpA2cqIGamRhkaetHGtTXw1DnV3ta7m0RGH6U__OG6XmdB8>
X-ME-Proxy-Cause: dmFkZTEIGtLYtB1yOIbbZXbAJoAY+PZw6pjJQysjTCj5y+QkiA8JOPwZwxEnfKGsq6iI0s
    84JBOQ4RXhl0brUTx+VxMTJ5YPQ40QXRuRThqDTNyFfekApt2knMDgQ6KeYqSNci17qcfx
    /TsrQBUfo1WMBe4OkAG6u0p7x9KjooQ5+V95xv0Cln2BZh19eBTGuQ/8COr2ja9Is1TxEJ
    vRdd6rvZO5A31rKj0vSCM4s1eFIZmHndd68dQyPEWsgHZzj6JsQuT86lelUpHIf0G4lF40
    Lx9tkwO7VI1aASWMAv4lpQ5+ol8HfgwFAn/7MQ007OLeyghv7XWGIxkgiL6GMEQGlcaCJT
    KzQRUGAzROxVjQz5rROsHkgCanKhbQMygQMYrWRbJVNw0xhYKyNYD/vrrmbSF4WfG+ozG0
    4uEEibgsHitPtfSd0/GEDmggmFd/WBmY3vxn0sVpf+iLFt/GatATNqjHX9wsu49IahENhK
    QADSHYneQHA0OqnwwLaOkUgcA3Stzvips+IEF7wSAw14SprWD65WTji4cEPPDZy00vee3N
    jZSk4KR7IvRqABlP3qIyGFuQIKvHXfxH8PpRNCzmCNOww8SS/nke3IsqIL/jSTybChjb0k
    DtG89WKvyz0Z6uILqOzOol/vO7WcslEFsK+a5OVO1Xz6XSG6+deO5Qv/YUFg
X-ME-Proxy: <xmx:H0s5ahl9s36tOT8RpyOnDj6iUlZtqByIqO5hgGjm-n0KfdZJ3Wxzdg>
    <xmx:H0s5aoQHc4Qe-0ChAHsiD8Qc5fHwydhzvOQEYHOQt36UBGk9Vg6Qlw>
    <xmx:H0s5arLeVavkYS2AF6RyPeFQchxTwsKBxVK1WCqsO8s2xlGBYLgHig>
    <xmx:H0s5amCk6NyUDSrCj1lozwUfH2F2osLXDoIklF6OARKIJlJIH9EOtA>
    <xmx:H0s5aoFa9VbEJ9ueVquZhBrQ0Z2xAMbOpyzvctOwLzXRByOYiHogSH31>
Feedback-ID: ie66e4b64:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 047A4182008A; Mon, 22 Jun 2026 10:47:59 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 22 Jun 2026 16:47:38 +0200
From: "William Hansen-Baird" <williamhb+wireless@fastmail.com>
To: "Ping-Ke Shih" <pkshih@realtek.com>,
 "William Hansen-Baird" <william.hansen.baird@gmail.com>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Message-Id: <0919ba01-c203-4280-bdb1-13137ea80da4@app.fastmail.com>
In-Reply-To: <09c4f473026841bcb36f9187b5ebc9a5@realtek.com>
References: <20260614135508.70307-1-william.hansen.baird@gmail.com>
 <20260616141620.91081-1-william.hansen.baird@gmail.com>
 <20260616141620.91081-2-william.hansen.baird@gmail.com>
 <09c4f473026841bcb36f9187b5ebc9a5@realtek.com>
Subject: Re: [PATCH rtw-next v2 1/3] wifi: rtlwifi: fix disabling of ASPM for RTL8723BE
 with AER flooding
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.15 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[fastmail.com,none];
	R_DKIM_ALLOW(-0.20)[fastmail.com:s=fm1,messagingengine.com:s=fm1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-37979-lists,linux-wireless=lfdr.de,wireless];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[realtek.com,gmail.com];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:pkshih@realtek.com,m:william.hansen.baird@gmail.com,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:williamhansenbaird@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[williamhb@fastmail.com,linux-wireless@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[fastmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[williamhb@fastmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[fastmail.com:+,messagingengine.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D14206B0734

> The commit can resolve problem from original report, so it seems like
> this patch to refactor to resolve your case as well.
>
> I'd remove this Fixes. How about you? 

That makes sense, I agree. It's more of a refactor to accommodate my default hardware state rather than a strict fix. 

I will send a v3 dropping the Fixes tag and applying the other requested changes.

