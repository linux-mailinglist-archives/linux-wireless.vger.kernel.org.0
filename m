Return-Path: <linux-wireless+bounces-31956-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OGGSKbKJlGm+FQIAu9opvQ
	(envelope-from <linux-wireless+bounces-31956-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Feb 2026 16:30:58 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0951F14D937
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Feb 2026 16:30:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 82C323028366
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Feb 2026 15:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBEBC281368;
	Tue, 17 Feb 2026 15:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=freebox-fr.20230601.gappssmtp.com header.i=@freebox-fr.20230601.gappssmtp.com header.b="qKBLWRV5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC721FF1C7
	for <linux-wireless@vger.kernel.org>; Tue, 17 Feb 2026 15:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771342255; cv=none; b=Q63ZyJ4pqWnEAvJdubKybWqK27xA5zANjMR8212hTm8/YJnocvUNc/RSFzu1mowQnwrHIIO+jjwqeinjweB6njduDBFdE8O3HX68ZWShamFbVi6HJuUMIrr0m44KavVDFjLqugtJ3wglpL9ffvkDua7QYgIgJs5gGziwcXH7YZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771342255; c=relaxed/simple;
	bh=NNxjhUuhmlZpVgXQcbI8Zt0KEzp2ft2miqfJGMIQyIY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J35akFtDX9EvB0Ecmy+2Q7GmmGzFMk9j9X9e1iuJrWdRR3MMlye3DzO7LFCBKkvvs7qhM8Oe04EiQrXp0wao/hap6Df0Axi0tY7SDqrLH+oRP4KJh5UlULLeTvKxqqH8p2b8g6OD0GlghT757nUSL/LDCWIH+IGlgegp74pEphE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr; spf=pass smtp.mailfrom=freebox.fr; dkim=pass (2048-bit key) header.d=freebox-fr.20230601.gappssmtp.com header.i=@freebox-fr.20230601.gappssmtp.com header.b=qKBLWRV5; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freebox.fr
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b8845cb580bso775533366b.3
        for <linux-wireless@vger.kernel.org>; Tue, 17 Feb 2026 07:30:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=freebox-fr.20230601.gappssmtp.com; s=20230601; t=1771342252; x=1771947052; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=es07r57iIFqqs418cgRl1V776G7PeKmmAzr8+Su+tgY=;
        b=qKBLWRV56gdCeOdzx+nUjHOBTa4vEUFJBk/TB1udOo1FZxUe02oyGYXIqvJambd/cb
         7eSxWQy1PRHrBAn80HEmPeUDtMVQPYkklCCup/xuBuE08WavcW58QGDf+IsKkMZIYFZf
         FDeFuSifiCYNndGX0px+LEHWqWSRyVcHUm2ASRyQtocp0BQyIYTbDRQn+Ot/Kh/rQ4ju
         TfygLyo5/RS1dnMK4P+DtVZJs+2b3II/Eoz7ltdgRdQUDa2UKoXlI22Yq2kAyChKatT9
         VQKbffy7Cd2sNdRbNmJ7DKalgQaB7mSFZBLwDsUG/5HLyCWWfI0TIEtQlOcMOIVmrT1X
         KmvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771342252; x=1771947052;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=es07r57iIFqqs418cgRl1V776G7PeKmmAzr8+Su+tgY=;
        b=Bkeqqg35xlsKWT3R5w6KemjvIhyUPdUKGH++cG8r1ZY1Qob0i2NHWHZFSzP15dNZlb
         HR6iYqovwxaS8LBf9MABYsRzcwrqAuABWFeAKqm9aK+SlYUQAxLCB5nrEkSXH8bjIhUr
         3q1ubDWh6UoZFV9m9IOtZwVLQ8GOznAInM8dPAb2KloCJkl5+8AXUDfNSF3Fm8mTpTcj
         IrtAEQBEy3+pd9vxUz07UBsmAvQkDzceILAm+Jpv8IAY+OFJ7sfUe6JFG+muN0JNoaZH
         zNOUNx5tyhO2enIuzajatdgsF1umVn1Lu1BhjWZxomm0s3LsE0wq+lZByL/Lk+xFlOxe
         n8+Q==
X-Gm-Message-State: AOJu0YxuUxEAP001QGTWaak1WVs1w9WBtyhVWw1FUIgz+eNNJOJeXl3L
	Yc0ZxyVdj+cEsTAOHIIQGadj6giMkDjLp+ECz+PNnnBzRMYDS9Ndv4rinwV6B95bwyM=
X-Gm-Gg: AZuq6aIEkL+voc4lXTgXtUthLuqOF4JQbzSReHlL4iCbyi9dldhV9qp5wuD2CerX5Kp
	9j4Jszao8UBJ8VNmHCG0Htw8PCM6IpwmwbUsmRBAQkXtGwyROaLpBQN9i1rAvPweeUZXfhpwSwa
	devm50d3ryd4eapC6ezBMr0Ft4aVmw7t+mauf0FuhuW00TuWbO5PchJyAJqYUrH9e5DLB6vOuCO
	SFOrWLvoeYUS1bOv/64Htr9MfP289aJ0XMs6qdEWeKjXdPX8VlRpvxOj1siNrPty7amktIF3sJd
	7CocYka4K/jMGPHZD6CVjVuP20E376Y/8dyIyb2yi79qZZwAmIBQI92nWfKrqZzrJmCCnpupQ4K
	sofLtSsNpneLUui1FbS4yMSyiszUrZs2wFxAz9eFJUpYkoUhcvg97DAY62dk/8kdRaqHBahdtvl
	HWES2AqEk96r0HN6KAvyuQ4RYqjITgsfYicO7WjvQ3BZuslEwC9npenA==
X-Received: by 2002:a17:907:c23:b0:b87:3beb:194a with SMTP id a640c23a62f3a-b8fc3cb90cfmr647801766b.44.1771342251546;
        Tue, 17 Feb 2026 07:30:51 -0800 (PST)
Received: from [192.168.108.101] (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8fc766531asm358778266b.50.2026.02.17.07.30.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Feb 2026 07:30:51 -0800 (PST)
Message-ID: <5d380297-29a1-4095-b78d-bc76bfeed131@freebox.fr>
Date: Tue, 17 Feb 2026 16:30:50 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless] wifi: mac80211: Fix ADDBA update when HW
 supports reordering
To: Johannes Berg <johannes@sipsolutions.net>,
 Remi Pommarel <repk@triplefau.lt>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
References: <5806bab7e46506d3c300ab4eb66989d42936aeb0.1771323902.git.repk@triplefau.lt>
 <f1243e86eea72999581d33c6f97ff9015ce71542.camel@sipsolutions.net>
 <aZRnlPA_uY9uWuKr@pilgrim>
 <d142f76473a03c76c780390f0352ffbb03566e48.camel@sipsolutions.net>
Content-Language: en-US
From: Pablo MARTIN-GOMEZ <pmartin-gomez@freebox.fr>
In-Reply-To: <d142f76473a03c76c780390f0352ffbb03566e48.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[freebox-fr.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-31956-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[freebox-fr.20230601.gappssmtp.com:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[freebox.fr];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pmartin-gomez@freebox.fr,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,freebox-fr.20230601.gappssmtp.com:dkim,freebox.fr:mid]
X-Rspamd-Queue-Id: 0951F14D937
X-Rspamd-Action: no action

Hello,

On 17/02/2026 14:59, Johannes Berg wrote:
> On Tue, 2026-02-17 at 14:05 +0100, Remi Pommarel wrote:
>> On Tue, Feb 17, 2026 at 12:30:08PM +0100, Johannes Berg wrote:
[...]
>> we want the driver to decide if it wants to support timeout update ?
> Not really, there's no driver that _can_ to support it now, and it seems
> unlikely any driver would _want_ to support it.
>
> And if so it should probably not be IEEE80211_AMPDU_RX_START but rather
> some new IEEE80211_AMPDU_RX_UPDATE thing. But I don't think any driver
> would implement it, I don't see why anyone would want to, this flow is
> in the spec but never really used.
I've checked, and both mt76 and ath11k/ath12k drivers supports a BA 
update (but none of them supports the timeout though) through 
`IEEE80211_AMPDU_RX_START`. mt76 stop the session before starting one 
new (function `mt76_rx_aggr_start`) and ath11k/ath12k checks if a 
session is active to either modify it or create a new one (function 
`ath12k_dp_rx_peer_tid_setup`).
>
> johannes
>
Pablo MG

