Return-Path: <linux-wireless+bounces-38825-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id uqLqORqlT2p4lgIAu9opvQ
	(envelope-from <linux-wireless+bounces-38825-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 09 Jul 2026 15:41:46 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 79A06731AE6
	for <lists+linux-wireless@lfdr.de>; Thu, 09 Jul 2026 15:41:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=L7AP56Uf;
	dkim=pass header.d=redhat.com header.s=google header.b=B4IRzah2;
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38825-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38825-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8D2B4301DD33
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Jul 2026 13:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9AD62F549F;
	Thu,  9 Jul 2026 13:40:58 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE73031715B
	for <linux-wireless@vger.kernel.org>; Thu,  9 Jul 2026 13:40:55 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783604458; cv=none; b=hu1JWDUSPj5ZiPuuUXFuEPF+yPyeg1zxW1ANOyPPEFOhZZEO1D+mU4TTIFWSLju5wrRIVnJkv7w2ozlEDZsL9Uz3JZyIXSGnTuOBffCl19lHA5ll0h02vADndgiCFGhXiywTibzHc0MKgPpsLA0YjPWyVT09yGnZ8drVGpQPZVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783604458; c=relaxed/simple;
	bh=CTwd3m3EU5RyubZ4hrQ78npbfiB/tzFKuCO2g5RcURc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FssQZ6Ij8GgYOTXJd4S79lqtSYP3BlPD1CltUoxZcbx5tGsnP6eA5iSVIbcBlSxjcFUYWCL1PNXN8xfMqZV2TTZXxZkQZzu+snUJtPaVyo9S3BDewMQiu4TxNGhgJaMl8lz8lpVWy4v417Ensr76VLKXkjgMA4YScO4dxLvCWjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L7AP56Uf; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=B4IRzah2; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783604454;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XoiO9fU/3IeaFYHV1LTxt3vPWdnCcjD+/AsfyGvDib4=;
	b=L7AP56Uf7/i+930ti7oj1+wX7AIfWpbPvnCu4qQs80bt76VF3PQwqhxVS4unvZM4A3W7lA
	rEYojRhhAOXVMY2wCWOXjjnE3MAGWtsoO6cql6IDfdHEOiVy6BpRTUZgc8DOtydWrnretT
	ubXHC7vmbQufKqK9DsTXwWlwWa6s39E=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-197-e7v_pxA4NFquVK6T6-lrDA-1; Thu, 09 Jul 2026 09:40:53 -0400
X-MC-Unique: e7v_pxA4NFquVK6T6-lrDA-1
X-Mimecast-MFC-AGG-ID: e7v_pxA4NFquVK6T6-lrDA_1783604452
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-493ce4b7777so13875965e9.3
        for <linux-wireless@vger.kernel.org>; Thu, 09 Jul 2026 06:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1783604452; x=1784209252; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=XoiO9fU/3IeaFYHV1LTxt3vPWdnCcjD+/AsfyGvDib4=;
        b=B4IRzah2aO2gS+5qnFUnQRJCBsLdu0HvcT56JQmcglcumGV9Xw0O6u3VNH8PGw9E90
         ez6d64FO/wWGGO+GI+p9WWCNRchVE9tfzJ+Mt3dUSx2Mbihtp6BsC8Fg1ubanx0D2mK+
         hR2JGKcm1OtLhCW7q18tCJ/MRVq5HSl3OuJ+Jjpx5yURs45BiLoMLq5gtQ/l4uZE6aef
         gqAgN4+3nXMgQsR8Ldp4iyCxJ4wsLPUaQuc9hE5edMkXOKBFDTTSE42x/ZA+dh58ehT3
         U+4fdpThf+fLJhm/kGT1/sbnDmhgi8Xe2Pwk/q2EqDfp9mIvklNv+S9/UXqtTgNMGf1A
         Wnhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783604452; x=1784209252;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XoiO9fU/3IeaFYHV1LTxt3vPWdnCcjD+/AsfyGvDib4=;
        b=FCs4k5RZpPAFHvkqYuz8FStbCxJ8i/GvFT+NgrjS0wjs6OHMzhUwCoJshU0I5dkXTR
         9YJ6NQD0ShRUS0Ihdhqp47zy9fPDt+VzF60zUzps+xwwEDLPpMEKJzYhCEVP2at+DkpB
         5wpG0873wbThNCmJsO4+DUCcbHuxGUm4EejjyPPP/mldLq4kvnJfGIQF2SnSunNtdh3n
         9iIXRsoTCuJjSyaJ5FpBA0xN3QFJG3xFPQqxfqxinKeLPrumlthBd7OgLFhpZ+7Q+8pM
         twVPPDpitU9rck5/r/yHgwoClRi3Xn2FZ0PIezBbK4tiZcqiO0WtCtkFxUj27Q4JSTf8
         XMrw==
X-Gm-Message-State: AOJu0YyuOKRD0PIB9XuxnNC9jMf9xIRhGnMB4aFrQG5l41EdXsFpEyoP
	xMpanvABlVAM2hyUi2SjTgdwHxc5HvctEpMon0kmiu+xkeEOi68EjS36JbE1/O2ChXrlfGdq+v+
	RZ5vWYUZVQXo8MdPRjXO2CHQbVBA8ewRsNt6ECQUBmK1cgH1CKJNSdIwyQTGaMSHpxxrVM2/qZM
	9Z
X-Gm-Gg: AfdE7cmphRqCcsd+JZElR7bssE+nFMW4k8ZcPFjiNUNS9RLuRU6rKfUyjjHaIRXDM5y
	IDMhMcTzGoUOYC7W48q5WY0I39SbbuqbshuzEQyo/LILV7uyy/rXwGpI19yZE/I1n4zUxsIIe0c
	0JyHnco1mOi2oMpjdYO/EQEZPgExXVcIAn+R5gNKWgEBOOY4J7jH0YuNiy4nPRnbCsS6y/j3YLm
	yl+StSoRD/sq+RKY71fpLyFDHcmDp8uEu4ZEU7r7UB50aA8pmGbgRWXM98SDm+guyGkZa8F0d6u
	23tb5SrGPFxc4kvABQu2zTvQUD+UlDNAyceiy0xTYiqv52j72UzW+RTqG6nMAKUvNWutzlooS6V
	FEwgGe7xA+a6xFCHTZ1Wf3WHBsLF1opwwY2G7GCu4js2dc/yydCuG0arplUntl+fgh9VKJaoi1r
	+UlmgHtjWdRE4+
X-Received: by 2002:a05:600c:1554:b0:493:bacb:1341 with SMTP id 5b1f17b1804b1-493e6859938mr74190495e9.4.1783604451904;
        Thu, 09 Jul 2026 06:40:51 -0700 (PDT)
X-Received: by 2002:a05:600c:1554:b0:493:bacb:1341 with SMTP id 5b1f17b1804b1-493e6859938mr74189985e9.4.1783604451263;
        Thu, 09 Jul 2026 06:40:51 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:5521:6b10:58fd:68f:7756:389d? ([2a0d:3344:5521:6b10:58fd:68f:7756:389d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493eb66beddsm70856255e9.0.2026.07.09.06.40.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jul 2026 06:40:50 -0700 (PDT)
Message-ID: <ec4db4e8-ce1f-4a08-b400-f4e507befb0d@redhat.com>
Date: Thu, 9 Jul 2026 15:40:49 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] wireless-2026-07-09
To: Johannes Berg <johannes@sipsolutions.net>, netdev@vger.kernel.org
Cc: linux-wireless@vger.kernel.org
References: <20260709115038.243870-3-johannes@sipsolutions.net>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260709115038.243870-3-johannes@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-38825-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[pabeni@redhat.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:johannes@sipsolutions.net,m:netdev@vger.kernel.org,m:linux-wireless@vger.kernel.org,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 79A06731AE6

On 7/9/26 1:49 PM, Johannes Berg wrote:
> Sorry, I meant to send this yesterday, hoping it'd get
> in/out before netdevconf and all that, because it's
> actually really big. Mostly I've now collected many
> random LLM-induced robustness fixes (I can't really
> call most of them security fixes, though there likely
> are a few).
> 
> Please pull and let us know if there's any problem.
I'm sorry I was already finalizing the rc3 net PR (which is already
quite big). I think it's not bad if this one lands in afterwards.

/P


