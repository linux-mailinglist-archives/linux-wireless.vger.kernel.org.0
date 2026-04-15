Return-Path: <linux-wireless+bounces-34808-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gPeiDe+232lVYQAAu9opvQ
	(envelope-from <linux-wireless+bounces-34808-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Apr 2026 18:03:59 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8150C406333
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Apr 2026 18:03:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 041B030342A3
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Apr 2026 16:02:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A0A43264F3;
	Wed, 15 Apr 2026 16:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=freebox-fr.20251104.gappssmtp.com header.i=@freebox-fr.20251104.gappssmtp.com header.b="Ysi2ejSE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B25C331619B
	for <linux-wireless@vger.kernel.org>; Wed, 15 Apr 2026 16:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776268941; cv=none; b=Oi4NZJ46WL87KMIe8KutB73Vh8/OBweJiFx8R+k18iyeEnaPdO15lDQnN/41gqO7mbbkkp8kEBmHrh35GoCVedWprp/vo62HUoxsXOTpYwn+yoOjhGb17n5uD5ngTAfyFTVJeEmae349LoP6oF7XZIgYBqv2QsOVJ5gvOxPCgAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776268941; c=relaxed/simple;
	bh=fjACtKvPHRtGF1SPcxaa4P86YugKlVBxFvWpt+6u+58=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W/ubhpqeP3CeQ7IgTK/Gha3fFmwsd5jr7o3Buwuec8MMeV94zkvxR0N2hfFLjPtiiNWtfZXE46Ed4Zg2riFU51SivNgaG79srSINFaStWiXc0kpvsMc+F8ktYh8XMgIaLty1kgk8q/aZijG6T/HbIy6Q1uAD5celLcSQFI26rCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr; spf=pass smtp.mailfrom=freebox.fr; dkim=pass (2048-bit key) header.d=freebox-fr.20251104.gappssmtp.com header.i=@freebox-fr.20251104.gappssmtp.com header.b=Ysi2ejSE; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freebox.fr
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-43cfac48bc7so4900849f8f.0
        for <linux-wireless@vger.kernel.org>; Wed, 15 Apr 2026 09:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=freebox-fr.20251104.gappssmtp.com; s=20251104; t=1776268938; x=1776873738; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dYcVn5mqmvaYXv9y2UznJ3QPXaEL/HtDEqzEbCONGqM=;
        b=Ysi2ejSEHodAOOOKF9KmrGK9tx25SArF8Egc/o7DRgz9ktehIzMcyh9gGoNhdFcXnx
         tLkz8gwFjOMT2/Z9aSQ+gOoZeFJUiU8cpa0U3Jf7QbbTvOMmdNTIVdFpPtj0jMBZLIZJ
         RBht3h9FyjXYo+kUKEjEg7vCZHOAG7OTjdvORHF4tWgxuRSyWpqtb//WdJ77K9MvvRNq
         xwpaH3bwPjwehZOL0Tz5uoST4EALRNtb91eHrLGkYntOa3kzrVTBxJCbhR2u36EbPvQe
         4Djs0xQM+dHpa2qW4iYdotVKLYHhuJANRvM6REyenuNKrFKjWdBLiZtXpd/dp9Pgl8Ml
         Rypg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776268938; x=1776873738;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dYcVn5mqmvaYXv9y2UznJ3QPXaEL/HtDEqzEbCONGqM=;
        b=df/RP4GDdVSqXLyv2IlKix/r1uzmWU1D0ED2V8K9h7KvepUGP1N5OnXsiQi1hxx6yk
         Ti35jRom1ny4hYRNBSIOHKzv3oNUA/aIW/AHDD9acvyu2v8W53NqB+HQAFLJekPiCLzn
         iQBn5x84RtNk1hC4wTyBdvaglJOVXYGT0hkZARLZ790V+dlAjTYYyaNIwWgU2Z/blMcE
         5MEw6xZEe8ahW8BGHNARB2ZYt/b07whcvbtP/M7rC/qGXAnMFG/jB8WKqNb80eWFZ7GA
         +EF0X+wAFO3s2dOdtvgAB8dIuAVesaigrGE4fSVbONbP22rYSk+g/MXQZIjTGISThFb5
         1B5A==
X-Forwarded-Encrypted: i=1; AFNElJ9+5sqUGjhP6fOaX7aA8C7IAeqdNUgalxZHa8wy4WJ/n9iFZd2kXf44g6IueFK8lZNWCPKAOoOFpuVRScQJQg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwW+7VWCuEDsqE+7XHJcRDzJFa3hD4IUL7Kqh2RrAGsqjj1Ck9e
	UpS9yPahEIBecnrLswgIdveNRh00b12M2qak/tzbArfssVLsVy9Uzy5v9lHUPRfkuyk=
X-Gm-Gg: AeBDievN3OzeZoqT924o5TUZJc0ZWv2DRfwP8gt6pLm+c2SH180DbnWwL8q+WdXib4k
	l0q76BZP6WzuunfdhFVIopuNdygl8kOp58slxJJJblcKplG9BK3FKNDqopy5MK/k3p/pXLViZk4
	XzWR5pvrWqWQpvKh93ZSc8Sm5/HiFUroIwCud4y9xy8/ElMF+BDylb/Zk8SBMZghcqnMWwQnV5H
	xa1EF7tXAJzpm1tNo9GjSiCRvy7A4Nd0UfGE29v0xyCgWbhjMklrK/gRSUdraclp+sKzMcHPaWy
	/Q1Ur7PDiAJVVY8FVkdTiaggjx1+sOGlM3m9IMFjsE4lSPDdA8ziWE0B7Ktc+b8uhzKMGMAhvs7
	67+CS4ARBG70qiB3BkDUJy5BEtWYr+wjOv+GB+/YoPQTi7YZ8sdUR5R2vbQh2oTvoLLmhumBlKc
	KOUKeRbix7lxBQtL2CJc44pgiV+KuaeoKvNd/JV9CRcBCI+hBrU1/zkLuvoX33SVz3
X-Received: by 2002:a05:6000:2886:b0:43b:93af:e124 with SMTP id ffacd0b85a97d-43d642c7992mr32537416f8f.26.1776268938032;
        Wed, 15 Apr 2026 09:02:18 -0700 (PDT)
Received: from [192.168.108.101] (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43ead3553d7sm6080652f8f.9.2026.04.15.09.02.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Apr 2026 09:02:17 -0700 (PDT)
Message-ID: <5633ace2-45df-4ee6-a41f-831de3e90d60@freebox.fr>
Date: Wed, 15 Apr 2026 18:02:16 +0200
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
Cc: Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
References: <20260415124514.284345-22-johannes@sipsolutions.net>
 <20260415144514.32ad98454543.Ia9692671b699164edcc0bdaf4fdbdbefc50b18f8@changeid>
 <ddfdac5d-602f-4f67-80bf-d41924b0b7e7@freebox.fr>
 <b5a0822b7ebf8e816e096e6a628db6b21fad40ef.camel@sipsolutions.net>
From: Pablo MARTIN-GOMEZ <pmartin-gomez@freebox.fr>
Content-Language: en-US
In-Reply-To: <b5a0822b7ebf8e816e096e6a628db6b21fad40ef.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[freebox-fr.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[freebox-fr.20251104.gappssmtp.com:+];
	TAGGED_FROM(0.00)[bounces-34808-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,freebox-fr.20251104.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 8150C406333
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 15/04/2026 17:42, Johannes Berg wrote:
> On Wed, 2026-04-15 at 17:22 +0200, Pablo MARTIN-GOMEZ wrote:
>>
>>> + * @ht_oper: HT operation element (or %NULL if HT isn't enabled)
>> Might be some nitpicking you can ignore, but HT operation element is optional when HT is enabled. With the current comment, someone might (wrongly) deduce that if `ht_oper` is NULL then HT is not enabled.
>>
> 
> Not sure how you mean that, but not really? If the AP has HT then it
> must have HT operation, otherwise the clients can't use it?
Oh my bad, you can ignore my comment. I wasn't sure if HT operation
element was mandatory, so I quickly checked the standard and the wording
of second table of 6.5.3.3.2 misled me in thinking it was optional ("The
parameter is optionally present if dot11HighThroughputOptionImplemented
is true; otherwise not present.")
> 
> johannes
Pablo MG

