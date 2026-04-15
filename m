Return-Path: <linux-wireless+bounces-34803-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uBXODuet32lCXwAAu9opvQ
	(envelope-from <linux-wireless+bounces-34803-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Apr 2026 17:25:27 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2844B405DEA
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Apr 2026 17:25:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 42EF630011B8
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Apr 2026 15:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B87193B389E;
	Wed, 15 Apr 2026 15:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=freebox-fr.20251104.gappssmtp.com header.i=@freebox-fr.20251104.gappssmtp.com header.b="Or9Cilkb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE2DD318B9C
	for <linux-wireless@vger.kernel.org>; Wed, 15 Apr 2026 15:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776266559; cv=none; b=rXeCLSkMroEmyzIXQJ7ykdKLM8jY1g/CyEvW2hn0ta0rhckD2CpiP+VvfG600EMMZiuqZe6+0BeN0WjnvPz+LLzR8ozO6MHj2dz+9cB6d4sPfGiTZar5sH86car3VTH3NgugNY2jU7RBFpdZItaRjmv14PFT/Z46TbLduLQ3yTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776266559; c=relaxed/simple;
	bh=SVRgQMpIZlPU177CEKHoPKtfHj7o25fE0SuXztoWNMc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eUSwgN1wCVcE0YEgLHag4tPL193XZMTY/X8+N7tkOaZl0wv2XAUBYkamm1uRKtp0VWsUW/bEjbHYgvvm0zMaiR0w/1dYQ+oRqqWT8y5NpfG86OFL5LkeEMQ/XTRQXpjha13cbmwjA5KxANJxDQ6r0uIqZX7p85jZV9EsDNnAF0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr; spf=pass smtp.mailfrom=freebox.fr; dkim=pass (2048-bit key) header.d=freebox-fr.20251104.gappssmtp.com header.i=@freebox-fr.20251104.gappssmtp.com header.b=Or9Cilkb; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freebox.fr
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-488ba840146so68596495e9.1
        for <linux-wireless@vger.kernel.org>; Wed, 15 Apr 2026 08:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=freebox-fr.20251104.gappssmtp.com; s=20251104; t=1776266556; x=1776871356; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TpLuX14jFRTEp7qYxTRDlZqUlqJZLFJY0PthlfxjeuI=;
        b=Or9Cilkbz7wJZlOpBdyDBhjgcpVGbyvjUwLWk3hV/fQpHvf5CYr+7anMtGH8YXChvw
         ttPZkjB27LETRNY5oK2sOxmxBo7xFhnakAmPAM6x816suuk65hNHv9EzShFA73Y4LwoJ
         o5GW4i4Y1ArmJGbV0S2nkHAe0GGmmbC3mtvJjm8kQcTg8b1ufzmnNtgbrHkKCHbrFn4c
         icHDzck3hDnAYaCs/EaNSkhHbul3/FA+m3zk5pqy4VEbvnqPIDS0guZ4ZE8BnTT8UpeQ
         6MmuaMiL5Pq1dckeDTLRyTQ18pr9HkEhXiUO7TPtOEJMbo9c1tB6B1tFqYogj61nLZBO
         5pnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776266556; x=1776871356;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TpLuX14jFRTEp7qYxTRDlZqUlqJZLFJY0PthlfxjeuI=;
        b=AHzaRbG9fcYnnv8wxK8YnCucgnE48Qb/8bnA/D75D4P6UuqF+Y+EEn0MrKieGND5Bv
         PP+bdD/Us5VfzWhyRXOu5eq20Z997Pef8MOmPBI9xCnO/BbfoBEv8CLq2nbwCy3NlcOS
         edytQ9WRtGyXPDmOcIraNoTsRgH0m+fFqSo2FTNCafboP7RVJbbZox+fLt/RoOo4b4sB
         9NV6T3/kg+hcGb08Hs3NVDRYzeejDrHPi4R77zVfiITp1nvQauez23CI9bXY7KLO43oB
         iKir6BsJ9Nx83Qc2Ou/vxjhJlX71mr1bQFLqCNLqZl4f8rPLWMKSGtNhl4MKMrkmV/OG
         8Atg==
X-Forwarded-Encrypted: i=1; AFNElJ8JIAenQPpY0Se9UH+g/DUfwQ0zS4mpxecsDpO20WhTbo2BzgZtCN6qbdKgqJecS/CGPWbw/dV0P0jMakrg7g==@vger.kernel.org
X-Gm-Message-State: AOJu0YxmoEEUXd72CCm1sGN1ULfJyIruLvKL7nrkZ/v24DIVLjvJthkS
	kR84j1d0lo23HwDEW5WQHIZqgYt0+Ntbw80VfttasqH6T5fgOYXzMLMY34UxUXoSinI=
X-Gm-Gg: AeBDietdtE4Zn+qMoVuWVvlq0KUYtrUH8qrwILJEIf3ZQQi8n761eGI/GO5ok9kRM2e
	/3Mf7UsBcTRqlZQo+bE84EaMGvfTSvVND5vpgP/zjrD9V+jL9sxpsJ1SczD/7/4JQTfPBNcne3T
	2R8x/iaO/4Bo9es++SVHdg0xbndanL1k04D6Nv+4U7shIzyooeZ3ayLsee+W4+L6qX/wQdvfMYs
	g5EMz2j1AN0zFpEUbQUYlF7tLdTVLEF+TDJmbtNw7PkEFzGD0045Lw7PxPkZcGRWWgy/B23PSMo
	h3mMLnKEQYlbmfoS04kAVyMjgj3YMencMZ5pylbfGcInYZsNlQGIzGebfhOsb29F9T9jiSq0UvG
	KIZlxSu1YpeeSQHTCyJvN/CJlKPubTXb8kchP6mb/5atxmbesOf1dtwEVjBcluPAjb9jpiShd/Z
	ZpeEKaVF2R0/VDkIGwsFdW1TjNembFKLtPnafVEzFA2J+sUYdgmq+FE6dCmTxlnwSM
X-Received: by 2002:a05:600c:628b:b0:488:904b:f31 with SMTP id 5b1f17b1804b1-488d68603ffmr280061195e9.22.1776266556263;
        Wed, 15 Apr 2026 08:22:36 -0700 (PDT)
Received: from [192.168.108.101] (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488f0e63351sm28992565e9.3.2026.04.15.08.22.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Apr 2026 08:22:35 -0700 (PDT)
Message-ID: <ddfdac5d-602f-4f67-80bf-d41924b0b7e7@freebox.fr>
Date: Wed, 15 Apr 2026 17:22:34 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 17/20] wifi: cfg80211: provide HT/VHT operation for AP
 beacon
To: Johannes Berg <johannes@sipsolutions.net>, linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
 Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
References: <20260415124514.284345-22-johannes@sipsolutions.net>
 <20260415144514.32ad98454543.Ia9692671b699164edcc0bdaf4fdbdbefc50b18f8@changeid>
From: Pablo MARTIN-GOMEZ <pmartin-gomez@freebox.fr>
Content-Language: en-US
In-Reply-To: <20260415144514.32ad98454543.Ia9692671b699164edcc0bdaf4fdbdbefc50b18f8@changeid>
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
	TAGGED_FROM(0.00)[bounces-34803-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[freebox.fr];
	RCPT_COUNT_THREE(0.00)[4];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,freebox.fr:mid]
X-Rspamd-Queue-Id: 2844B405DEA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 15/04/2026 14:42, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> In addition to providing HE/EHT/UHR operation, also check
> and provide HT/VHT operation, so that drivers have it and
> can use it, e.g. to correctly calculate station bandwidth.
> 
> Reviewed-by: Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> ---
>  include/net/cfg80211.h |  4 ++++
>  net/wireless/nl80211.c | 18 ++++++++++++++++++
>  2 files changed, 22 insertions(+)
> 
> diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
> index 7070e577342b..a40ab36b8edb 100644
> --- a/include/net/cfg80211.h
> +++ b/include/net/cfg80211.h
> @@ -1398,6 +1398,8 @@ struct cfg80211_rnr_elems {
>   *	attribute is present in beacon data or not.
>   * @ht_required: stations must support HT
>   * @vht_required: stations must support VHT
> + * @ht_oper: HT operation element (or %NULL if HT isn't enabled)
Might be some nitpicking you can ignore, but HT operation element is optional when HT is enabled. With the current comment, someone might (wrongly) deduce that if `ht_oper` is NULL then HT is not enabled.
> + * @vht_oper: VHT operation element (or %NULL if VHT isn't enabled)
>   * @he_oper: HE operation IE (or %NULL if HE isn't enabled)
>   * @eht_oper: EHT operation IE (or %NULL if EHT isn't enabled)
>   * @uhr_oper: UHR operation (or %NULL if UHR isn't enabled)
> @@ -1427,6 +1429,8 @@ struct cfg80211_beacon_data {
>  	bool he_bss_color_valid;
>  
>  	bool ht_required, vht_required;
> +	const struct ieee80211_ht_operation *ht_oper;
> +	const struct ieee80211_vht_operation *vht_oper;
>  	const struct ieee80211_he_operation *he_oper;
>  	const struct ieee80211_eht_operation *eht_oper;
>  	const struct ieee80211_uhr_operation *uhr_oper;
[...]
Pablo MG


