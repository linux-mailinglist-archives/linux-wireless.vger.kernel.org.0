Return-Path: <linux-wireless+bounces-34796-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oBGrG0aS32nYWAAAu9opvQ
	(envelope-from <linux-wireless+bounces-34796-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Apr 2026 15:27:34 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 58CBA404C63
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Apr 2026 15:27:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5D37B300C6CE
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Apr 2026 13:27:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECB853A759E;
	Wed, 15 Apr 2026 13:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=freebox-fr.20251104.gappssmtp.com header.i=@freebox-fr.20251104.gappssmtp.com header.b="C7AaQmzS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 186DF37CD40
	for <linux-wireless@vger.kernel.org>; Wed, 15 Apr 2026 13:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776259648; cv=none; b=CC+xEHDkZoH9f7brw5VbPrLcSQO4w3AvpgNaUob2fe8x1w0UcZDGy6XxOYXFeQOlGDAFGm+uMZ6DZKY8ARGTL7oJdmk7C7H4CpAp6WUoFB/5Yi+gtWSb7XeBsRAy1Fv1WQjLmYtw+McX/Wt89hIomvqJJO8NtMt3KPVNqx5AJYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776259648; c=relaxed/simple;
	bh=RryjuW7D6wFsYvdkC6r51PQnhQUVOTR87iFxg0ZOPPY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VXHzoo0mou9WDO0mHTwmU3bia5urq4TrdGaJ+Sxd7aTJAtWkARs8KgxNt7LHVq9yK8Vj3B2UBIV+FWJORNLAqlo2YS6JWnvF1Lu5nj62GeMhntJd5wKQX69JiOQ+zg+alNWShfgFkUBADAJQi7jbwDl1bK1xO1V50Yy/UUo7maU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr; spf=pass smtp.mailfrom=freebox.fr; dkim=pass (2048-bit key) header.d=freebox-fr.20251104.gappssmtp.com header.i=@freebox-fr.20251104.gappssmtp.com header.b=C7AaQmzS; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freebox.fr
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-48334ee0aeaso67008945e9.1
        for <linux-wireless@vger.kernel.org>; Wed, 15 Apr 2026 06:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=freebox-fr.20251104.gappssmtp.com; s=20251104; t=1776259644; x=1776864444; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mlGD8n5yS6OtrV5NZXNllCe7VLCWfgTIdtosmWt7NTw=;
        b=C7AaQmzS30Tue/mupRamDKg6HUR/7phxbOSTPiw0ZZg3txVEqmRaIGhEy3H272jW84
         4fOPv7UcSUPoMUZUAtRsZez1KcbgTC3lkBrS+BasKwN9exAGL4qdLyPrLQfqqBpGCKzb
         JyJSKkCPIVywHp+FUMTXxDp9bRSwO4X7Q+Nywy9DyeTDBs9H63uEMifaSZfKqLscB0ui
         Eb+x5YCfmp8NqQTvrQ8tzEZoIuzcma88FJJ0jG2l/upfi9qpXumfzp5WsJf005GWZma/
         l2638HZSjN276fXwYMT4GbljBMgskJuUYG5rPb27u4vG7IFz0MP912hI0lto0H1vqtCX
         J3Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776259644; x=1776864444;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mlGD8n5yS6OtrV5NZXNllCe7VLCWfgTIdtosmWt7NTw=;
        b=B5Ri7LxryueiqqR4MPDhtb9CXOuuNx+IEEABlJ3NLMUfCVTBolCt98Jrkj5f8bseVo
         4ZfSXmsDewwavrfl5+cq1U1eQrwh96D+26HcKrWL1+4fz1mM4h6ppnKWmddqZKr1M+2/
         yxp5RAELkCJyoHyNH77qdjTYWi7/Yy9d30gICtLufJW2wSIFGVYsAAyNrXserhA5AtwB
         0yw99tqJpDpMhjdJuT3DdLSo2G0wUaAPYyx3dLsj3dxelQefR4adJdzw/DlpnFxATab9
         XtKZrkkNdZtL1cOW8mVgQf2vGNYncdpXssSIabWhzZAQbBASOAPP7+CfWle/PbeoYUGr
         sZEw==
X-Forwarded-Encrypted: i=1; AFNElJ+rjMHf3x89MMnDpJCqn0ngITq6rQvyr7RR00fOsEgp1qMxkvz0xVkqQBa6IRGq3UJiWehDCKjPkcOOaMPPEw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwP2QMx+DBdNfjePa4pRXJ9WHln+6CQRdU0rw/elmoifZ7gCNsj
	zyIYKboQgJNacpNDrkhXl/S3Wp247OSPzU77DNytu5pdT09+bWs6wJ1NU79Zv/i1HVA=
X-Gm-Gg: AeBDietDSqWVZFsuuVN6UaFgfuH7Fkz8aogvoHBSfgbP8Yzk61OGKFRVEo97Fm9r4K4
	xxKYjaMAwG/r6l2yqZ4bT7+PgbXqfAVsfL7O9UFH1L3HyQWUO3d3xkl0nPDuSLEzZzMPeCYM22F
	Q+0AGqtnB6kso+H1K6qUMcvVQyWJLZ6pdGsRsA0JxD++kwoItqemXGI1U1uAJUDJbe2TiwhxSEi
	qvsRyOpfJlcSd2D1idR80r+JLRAjoqEuwTTcT1nbeked6tuHzzaPQOsf6fu6Op0ipcL9wUaH2cq
	7iDKXi+PZV+RMAqTKZnml1j1nqIl+bpx3x9E1da/48O99Fn/72EDJeKFd12pdt3RcPjR24aIIUF
	x62L0sjzTXf/n1GN/XZHaBRGINNH6Z5f/s/ApqvxS/R9ZvU0oQXVIg6K/l2/VuMuIuv0vO//UnN
	9lNWpkHrlK4v51xjgEMvUULfr8bsTu5RW1SzpJ5m36LWhcZ+Cmh/Rb8yChMS7lhPvVgM262ef91
	Xo=
X-Received: by 2002:a05:600c:c0da:b0:488:b043:5efd with SMTP id 5b1f17b1804b1-488d682628dmr264829625e9.13.1776259644138;
        Wed, 15 Apr 2026 06:27:24 -0700 (PDT)
Received: from [192.168.108.101] (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43ead3d5ea9sm5435535f8f.21.2026.04.15.06.27.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Apr 2026 06:27:23 -0700 (PDT)
Message-ID: <e3af2190-3941-4ec8-9c59-91eafc6eb156@freebox.fr>
Date: Wed, 15 Apr 2026 15:27:23 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless-next] wifi: radiotap: add definitions for the new
 UHR TLVs
To: Miri Korenblit <miriam.rachel.korenblit@intel.com>,
 linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
References: <20260412152605.73e682d0c8c3.I5a0c858467c852b7a2a00f580bd073af29c37705@changeid>
From: Pablo MARTIN-GOMEZ <pmartin-gomez@freebox.fr>
Content-Language: en-US
In-Reply-To: <20260412152605.73e682d0c8c3.I5a0c858467c852b7a2a00f580bd073af29c37705@changeid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[freebox-fr.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[freebox-fr.20251104.gappssmtp.com:+];
	TAGGED_FROM(0.00)[bounces-34796-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[radiotap.org:url,intel.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,freebox.fr:mid,freebox-fr.20251104.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 58CBA404C63
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello,

On 12/04/2026 14:26, Miri Korenblit wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> Add the necessary definitions to create radiotap UHR TLVs
> for UHR sniffers.
> 
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
> ---
>  include/net/ieee80211_radiotap.h | 190 +++++++++++++++++++++++++++++++
>  1 file changed, 190 insertions(+)
> 
> diff --git a/include/net/ieee80211_radiotap.h b/include/net/ieee80211_radiotap.h
> index c60867e7e43c..6c2210a253cd 100644
> --- a/include/net/ieee80211_radiotap.h
> +++ b/include/net/ieee80211_radiotap.h
> @@ -95,6 +95,8 @@ enum ieee80211_radiotap_presence {
>  	IEEE80211_RADIOTAP_EXT = 31,
>  	IEEE80211_RADIOTAP_EHT_USIG = 33,
>  	IEEE80211_RADIOTAP_EHT = 34,
> +	IEEE80211_RADIOTAP_UHR_ELR = 37,
> +	IEEE80211_RADIOTAP_UHR = 38,
Why are the values 37 and 38 but below in the doc 35 and 38?
>  };
>  
>  /* for IEEE80211_RADIOTAP_FLAGS */
> @@ -602,6 +604,194 @@ enum ieee80211_radiotap_eht_usig_tb {
>  	IEEE80211_RADIOTAP_EHT_USIG2_TB_B20_B25_TAIL		= 0xfc000000,
>  };
>  
> +/*
> + * ieee80211_radiotap_uhr_elr - content of UHR-ELR TLV (type 35)
> + * see https://www.radiotap.org/fields/UHR-ELR for details
The URL gives a error 404
> + */
> +struct ieee80211_radiotap_uhr_elr {
> +	__le32 known;
> +	__le32 sig1, sig2, mark;
> +} __packed;
> +
[...]
> +
> +/*
> + * ieee80211_radiotap_uhr - content of UHR TLV (type 36)
> + * see https://www.radiotap.org/fields/UHR for details
Error 404
> + */
> +struct ieee80211_radiotap_uhr {
> +	__le32 known;
> +	__le32 data[9];
> +	struct {
> +		__le32 known, info;
> +	} user[];
> +} __packed;
> +
> +enum ieee80211_radiotap_uhr_known {
> +	IEEE80211_RADIOTAP_UHR_KNOWN_SPATIAL_REUSE		= 0x00000001,
> +	IEEE80211_RADIOTAP_UHR_KNOWN_GI_LTF_SIZE		= 0x00000002,
> +	IEEE80211_RADIOTAP_UHR_KNOWN_NUMBER_OF_UHR_LTF_SYMBOLS	= 0x00000004,
> +	IEEE80211_RADIOTAP_UHR_KNOWN_LDPC_EXTRA_SYMBOL_SEGMENT	= 0x00000008,
> +	IEEE80211_RADIOTAP_UHR_KNOWN_PRE_FEC_PADDING_FACTOR	= 0x00000010,
> +	IEEE80211_RADIOTAP_UHR_KNOWN_PE_DISAMBIGUITY		= 0x00000020,
> +	IEEE80211_RADIOTAP_UHR_KNOWN_DISREGARD_OFDMA		= 0x00000040,
> +	IEEE80211_RADIOTAP_UHR_KNOWN_CRC1			= 0x00000080,
> +	IEEE80211_RADIOTAP_UHR_KNOWN_TAIL1			= 0x00000100,
> +	IEEE80211_RADIOTAP_UHR_KNOWN_CRC2			= 0x00000200,
> +	IEEE80211_RADIOTAP_UHR_KNOWN_TAIL2			= 0x00000400,
> +	IEEE80211_RADIOTAP_UHR_KNOWN_INTERFERENCE_MITIGATION	= 0x00000800,
> +	IEEE80211_RADIOTAP_UHR_KNOWN_DISREGARD_NON_OFDMA	= 0x00001000,
> +	IEEE80211_RADIOTAP_UHR_KNOWN_NUMBER_OF_NON_OFDMA_USERS	= 0x00002000,
> +	IEEE80211_RADIOTAP_UHR_KNOWN_COMMON_ENCODING_BLOCK_CRC	= 0x00004000,
> +	IEEE80211_RADIOTAP_UHR_KNOWN_COMMON_ENCODING_BLOCK_TAIL	= 0x00008000,
> +	IEEE80211_RADIOTAP_UHR_KNOWN_RU_MRU_DRU_SIZE		= 0x00010000,
> +	IEEE80211_RADIOTAP_UHR_KNOWN_RU_MRU_INDEX		= 0x00020000,
> +	IEEE80211_RADIOTAP_UHR_KNOWN_DRU_RRU_ALLOC_TB_FMT	= 0x00040000,
> +	IEEE80211_RADIOTAP_UHR_KNOWN_PRI80_CHAN_POS		= 0x00080000,
> +};
In the other radiotap fields, the `known` fields are (as far as I
checked) have the same order than the data, but here, for example,
`PRI80_CHAN_POS` is before `INTERFERENCE_MITIGATION  ` in `known` but
after in `data`. Any reason for that?

[...]

Pablo MG


