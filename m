Return-Path: <linux-wireless+bounces-31236-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IF5WDazkeGlftwEAu9opvQ
	(envelope-from <linux-wireless+bounces-31236-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Jan 2026 17:15:40 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A8DAE978F2
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Jan 2026 17:15:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DDA503043231
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Jan 2026 16:12:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D4BD35FF42;
	Tue, 27 Jan 2026 16:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=freebox-fr.20230601.gappssmtp.com header.i=@freebox-fr.20230601.gappssmtp.com header.b="QMpb3DY0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8496D22B5AD
	for <linux-wireless@vger.kernel.org>; Tue, 27 Jan 2026 16:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769530342; cv=none; b=QdNTxNiYBUP23T0M66/Gu/i8t5iTh5+DA4IGUETRy2RtQpMCOujrE+H55/WlaVrO+S739Zoe9UCNNy+3r65dfZWhjOOOn09uyki+HTEjHx9hSdJZmXLvi6CD7XLqfqBRiLFTdLOzSkrjkrn6R68JnoRK5lk96DxZpYrQ2BLbIUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769530342; c=relaxed/simple;
	bh=v8Gr65xUT+ff0PQd+mp5gvptNqEdD7hZBSr/28Cuu3w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QN5+3PRR5DKsamug1lYAZukbKAuydJdY2P+3AKaxCnfvHqriua4+1ObWe3ocwMk1sWg9nu+wyHYwMN/KC6iUPsZTVrA4j7TkQ/MY2qwm7lSITPV8mt8o3K9y/RG6+lkzsEl4Oj2QfsAdY7jnvQ5fObU15mj6HoqhYuskRWNeTfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr; spf=pass smtp.mailfrom=freebox.fr; dkim=pass (2048-bit key) header.d=freebox-fr.20230601.gappssmtp.com header.i=@freebox-fr.20230601.gappssmtp.com header.b=QMpb3DY0; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freebox.fr
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-64b92abe63aso11754314a12.0
        for <linux-wireless@vger.kernel.org>; Tue, 27 Jan 2026 08:12:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=freebox-fr.20230601.gappssmtp.com; s=20230601; t=1769530338; x=1770135138; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=A/zfLsFMMruW4ZNk7z3DxWWozQd6lHc40f1JUxxKvY0=;
        b=QMpb3DY0idzObiB3MzzljuKfLsd7W7FUFDrZ5VbVdkPrmbnnG5yhnkJzXMRaSQjP33
         cRRvpRsz0jTYSeWW3GlS5dsNhp7RFHRc7uJdM9WSkwD6A2oBvDjArQLS7NDQ5K497+dP
         BPWiWvTkNOIDyfEepQyno2gN2dYkq4lNa/jvux9+9uffVBEkPlcWAdb9GBfn3dkEkebm
         auAS2ilyrnufjcUaoCHtCsNKDuI6zF3qo5sJ72E+Xm9Tt6+VFJhut3rbdHGKZYnzB46a
         DVMjKZgWQVkZ81r9r/de5iVV0Pu7cR7tCWRbn1gKBu0AdSwYXOgKJUaVGS/+QCvdvrMi
         iM1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769530338; x=1770135138;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A/zfLsFMMruW4ZNk7z3DxWWozQd6lHc40f1JUxxKvY0=;
        b=qG4U4xRHGg6K+tS6ggbZelD7/ogEcpUdEoGJz1fddINb0/TuHbJo73NUQ8NjIHDWEc
         dBRtLoWNkwoXS/uNJ4BSkMpT6dhPtzsX0ZgfbwkBtXRgZlDagU8HQZL/UFZZBDD88NRX
         pcdqkiOpEY7W49Ib7SFalIbDIaZE5TD+1fJvabHjFrxQDr+K56o2LP0yuvbPiUS30ZEQ
         izATjy6InASKtWilLxKtGa+vO4b8sBzoE2Oc9XlroHnEabZkSLisDo8yOpn6sJcUCkR6
         GflpG31G+olmsnalP8ag1oyV76/2ZcnOIY2Vj6kgCL5w6h0XOBx8+l/eLhEPkLN1uSKm
         1bDA==
X-Forwarded-Encrypted: i=1; AJvYcCX5IrTb9x9+tgaosUofCKuLmMXibZWeKTm2NTD2635h2C9xdUOjipCULVunqFoNRR0o7k+l3xuTMQPBImnJ/A==@vger.kernel.org
X-Gm-Message-State: AOJu0YzNrj3EvK0IdlQB5pBh5vTIYfZ+UdZgN2V9Tvjf3QvYhclkb6Ke
	IyAXKdxDgKJitYkhusCPm4PzPhFpcEb2C2BGk0N/ekLsw2XgMkJotgZbbEHGbAj4a55Asuq9xhg
	+F03w
X-Gm-Gg: AZuq6aJGjU3N3FV0uxdevbrhLaiqc1fUWeuQ+Fh0H4savPacjT2LQDk9sX3xyRV+CKv
	elW9pLNO5pP1mpuyyQoTc99VS3fILKAY7DqGCaMATqb/VN2mtqTuBKMkwESzC0B7hyx4ewUJS48
	SqO+n9O+9beQgGLzz8zkl7W0veDGeddNP9bYNfkH7T8igVLdGOTKP8biGRzlvmsfs5RCgzjY8iZ
	TlGs0sEnNZy6Xt/QTMvngvVzxSYRV2GfkFD6tqfQU5AkgnPCR0OIAR5IirSlab9gnlz6KMtk+/y
	NtvY2dzqkqnW4h771bL6Qhk0cyCf9jduxoqZ0ew2NByFO6Jo6ZHkJlORx3QxfTzgLAKII7sQ683
	IKkE4bUMPrVZDsR6fLTfahtuHw6QKZbun5C8kLigo7CkFPkxuLVh0oKpugpxgIPIUmPpNIsW354
	A5o0iUOa/m98r1SwpaoIe+ri4Kq4aY1oVgNXQMR2BC8quuABLJhp8n
X-Received: by 2002:a17:907:1c0a:b0:b88:dc6:3967 with SMTP id a640c23a62f3a-b8dab423069mr184503766b.40.1769530337563;
        Tue, 27 Jan 2026 08:12:17 -0800 (PST)
Received: from [192.168.108.101] (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b885b75d632sm813653166b.48.2026.01.27.08.12.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jan 2026 08:12:17 -0800 (PST)
Message-ID: <b9b2cf39-8989-40c9-8ffa-b1626217b773@freebox.fr>
Date: Tue, 27 Jan 2026 17:12:16 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless-next v3 3/3] wifi: mac80211: add initial UHR
 support
To: Johannes Berg <johannes@sipsolutions.net>, linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
References: <20260127141005.583581-5-johannes@sipsolutions.net>
 <20260127151005.751175e8035e.Ieec940b58dbf8115dab7e1e24cb5513f52c8cb2f@changeid>
Content-Language: en-US
From: Pablo MARTIN-GOMEZ <pmartin-gomez@freebox.fr>
In-Reply-To: <20260127151005.751175e8035e.Ieec940b58dbf8115dab7e1e24cb5513f52c8cb2f@changeid>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[freebox-fr.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[freebox-fr.20230601.gappssmtp.com:+];
	TAGGED_FROM(0.00)[bounces-31236-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[freebox.fr];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pmartin-gomez@freebox.fr,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email,freebox.fr:mid]
X-Rspamd-Queue-Id: A8DAE978F2
X-Rspamd-Action: no action

Hello,

My comment below:

On 27/01/2026 15:09, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
>
> Add support for making UHR connections and accepting AP
> stations with UHR support.
>
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> ---
> v3:
>   - use uhr_oper instead of removed uhr_capa
>   - fix indentation (Jeff Johnson)
> ---
>   include/net/mac80211.h     |  33 +++++++++-
>   net/mac80211/Makefile      |   2 +-
>   net/mac80211/cfg.c         |  14 ++++
>   net/mac80211/ieee80211_i.h |  17 ++++-
>   net/mac80211/main.c        |  13 +++-
>   net/mac80211/mlme.c        | 131 ++++++++++++++++++++++++++++++++++---
>   net/mac80211/parse.c       |  20 ++++++
>   net/mac80211/rx.c          |  21 ++++++
>   net/mac80211/sta_info.c    |  11 ++++
>   net/mac80211/sta_info.h    |  80 ++++++++++++++++------
>   net/mac80211/uhr.c         |  29 ++++++++
>   net/mac80211/util.c        |  34 ++++++++++
>   12 files changed, 373 insertions(+), 32 deletions(-)
>   create mode 100644 net/mac80211/uhr.c
[...]
> @@ -1040,8 +1064,15 @@ static inline u32 sta_stats_encode_rate(struct ieee80211_rx_status *s)
>   
>   	r = STA_STATS_FIELD(BW, s->bw);
>   
> -	if (s->enc_flags & RX_ENC_FLAG_SHORT_GI)
> -		r |= STA_STATS_FIELD(SGI, 1);
> +	switch (s->encoding) {
> +	case RX_ENC_HT:
> +	case RX_ENC_VHT:
> +		if (s->enc_flags & RX_ENC_FLAG_SHORT_GI)
> +			r |= STA_STATS_FIELD(SGI, 1);
> +		break;
> +	default:
> +		break;
> +	}
Not sure this change should be in this commit

Best regards,

Pablo MG


