Return-Path: <linux-wireless+bounces-34957-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mN+AL6eJ4mlq7AAAu9opvQ
	(envelope-from <linux-wireless+bounces-34957-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Apr 2026 21:27:35 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CD3B41E3CB
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Apr 2026 21:27:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CF89E30263E5
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Apr 2026 19:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 320713AF67C;
	Fri, 17 Apr 2026 19:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="hjameGpW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yx1-f98.google.com (mail-yx1-f98.google.com [74.125.224.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A72D3B6364
	for <linux-wireless@vger.kernel.org>; Fri, 17 Apr 2026 19:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776454014; cv=none; b=ilWaktonnK8c0ajr1hfh8Xvgs9wf3w1xbA4pI/cwcLD8qyIjsgeqEWGAIyJD8GXhpl+qTUskPuwsYa0KIVYlBU3q0sYVuEm8eDgDcca7u0usqF2hHjLsGn01jPbMsktgalDiPRUjFn7FQZJJ+DLapGWAKC5hfKn0TwSe+nR/MVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776454014; c=relaxed/simple;
	bh=c46MhwJjv3+RX6D1Ajl2g2/Z8vW4GKzlDlrVDuAkbm4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=SKRu8L5/f/r762JluIiXkHjqlkwo5zwBnRqe0SkrjpWSABCEwii5LNT/ege1/kIz9aJItOWs3LW4hg+CuopjLwGy4k2a6GrYiDpIw6av4wCiiAe0S4MSzLMRKsB76ZiaIwBnzmgaBGIKQ5+jPtqdV/gqKQLRiaLUcMjV2Qq/FfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=hjameGpW; arc=none smtp.client-ip=74.125.224.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yx1-f98.google.com with SMTP id 956f58d0204a3-64d5a7926cfso1136529d50.2
        for <linux-wireless@vger.kernel.org>; Fri, 17 Apr 2026 12:26:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776454011; x=1777058811;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=psFzhtTARPiia800y0nrnAWpk78pBCr1jh1L3zJLkQM=;
        b=fubpj9ziTLlKJbqKVUCWXYRC5US1XCxo62DxajxzrR8O7WaQ/QIoER722UCWJSg1Eh
         O4r6015u/ZSpLUZ5bQvD1YEpFFZdeADUmeQcl1gxHcYTGSo2Px8r2QMPqIu5GduaKe2u
         7OjeFexEl0Rk1Db4lE2Csz36NMfTfGTbsTugIArvQZ0HFtLSwCY/FCSjLjunos0Z5vq1
         Q0gMKR+Nr6IuB05NNX/tDXWjeVCVBSg2bMBSmZ/rhRFGhan/ImrmZBrtOC65gMXA2twW
         p1gOOriBOAnZLpW87E4aMSfNPgbYX8f+kk9iQa96zl4NXsBg4E4CdSvv5NQvfqV18VKj
         802Q==
X-Forwarded-Encrypted: i=1; AFNElJ8KLxjVv7Kgd2rJOo6fuxVgzWAXJhlLAjvA+F3l3RWSWa+wF0har6tm11f9vzH32zFkUqFX8CyIrhJ0opyyCQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwkJUOQ1JQAt4JRjA8ZObFF+eeGBjNAisweCyqRjFioSlmg4pkU
	FIVjwffGmDrt1Z4KuJ2gezIto3TbXqtl9DUevnnj+CC4jNrmsKtF319rWEOdwKVuou1UurRxiRg
	Xzom5c92p75N88E3eH2Pn6GBt9het9euAAAMKtSG38TcBTTCFWBC8J7Hc45lEUIdzVCL8Sil1ro
	WrBQpF11M7saIxcnz8VBeLpo8ymg38cZ6pQwUJXYEGeFkrvRyQ6SMx60Fwun5ybv//0x9csDOip
	FqFvDxGtJ0cn3vk9sbY73vuctJM
X-Gm-Gg: AeBDiesDOLLyDHsSvFfaUEAhnbzFObuncGu1lPLk16o/KTnj/0i1kh4CzmQfcZ3Epi4
	o+jF9NvHqA+HM5+/Y2hjx6CdmLNpZolLmhF67EFJcb9cCNF5FhDkM+GPiQwXmKijYn1651FHXVA
	MFTAkuYxsoN3pVSJBaqCeVSWMyOzw3aEEei0wuDVTAQ27GAmJjystmGy2V0FQWrxT1lNBLJl9N/
	fTN8hmoK+KijGlXNvIL40aHTkINsKhLfoIYRwSRGXs94C/Ud6PGv+wElFQopio1XhHR7M/BO6e8
	RiVRFuvzpYQ+xyXr8lHoOhNoydXUpnrck3zVnsLamjId1CE4LaOdn/Cb2EP8/lVn9rEC5HU3jD0
	eK3cjSYlHfNdVU8KgNg3xxoV0jCPj1y/2anC8WmYd6zbKrIUTboFrk227nY7QuBY8Q1eclLiWRL
	fRFhSxjgigcy/X2M3+gno6NhRPuylJ4jZZxcfxx0V/Znr/vcSEMV6W2zOTVwQrbTcFijK5XYA=
X-Received: by 2002:a05:690e:124a:b0:651:b13e:f9ef with SMTP id 956f58d0204a3-65310803d3fmr4114962d50.14.1776454011376;
        Fri, 17 Apr 2026 12:26:51 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-15.dlp.protect.broadcom.com. [144.49.247.15])
        by smtp-relay.gmail.com with ESMTPS id 956f58d0204a3-65314e5ee4bsm184858d50.26.2026.04.17.12.26.51
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Apr 2026 12:26:51 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8d4c2906fdfso119530085a.2
        for <linux-wireless@vger.kernel.org>; Fri, 17 Apr 2026 12:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1776454010; x=1777058810; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=psFzhtTARPiia800y0nrnAWpk78pBCr1jh1L3zJLkQM=;
        b=hjameGpWH4EbSHFy8CTngzV2FV2yvLZMnArhOnKoIS1eJ6YsIbMrzUwiCHvN+EhkpX
         V0N1qTbp8G8A3I77kyBnMDUo0+15JmUHuUqVEB+MveOzXGaQ13eogRd3N0DhvFWDiS4b
         LqM09cdgieYslVKapxFBuDXqUF3CijFvAOq7g=
X-Forwarded-Encrypted: i=1; AFNElJ8fN22rCh9NqhbQSGJMXLSXmsW8JHCcIAR7VLpuLGGTb1BakL1jiTwccwz4jl+F5v0Oul39Xz/uRAfJQTIGMA==@vger.kernel.org
X-Received: by 2002:a05:620a:2986:b0:8d7:a2b3:3aab with SMTP id af79cd13be357-8e792b5d38cmr612160085a.58.1776454010430;
        Fri, 17 Apr 2026 12:26:50 -0700 (PDT)
X-Received: by 2002:a05:620a:2986:b0:8d7:a2b3:3aab with SMTP id af79cd13be357-8e792b5d38cmr612155385a.58.1776454009744;
        Fri, 17 Apr 2026 12:26:49 -0700 (PDT)
Received: from [192.168.178.26] (f215227.upc-f.chello.nl. [80.56.215.227])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8e7d64cbbdbsm198331985a.12.2026.04.17.12.26.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Apr 2026 12:26:49 -0700 (PDT)
Message-ID: <de97fcd3-2ea5-4855-bfb1-99483a87deaa@broadcom.com>
Date: Fri, 17 Apr 2026 21:26:46 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: brcmfmac: Fix potential use-after-free issue when
 stopping watchdog task
To: Marek Szyprowski <m.szyprowski@samsung.com>,
 linux-wireless@vger.kernel.org, brcm80211@lists.linux.dev,
 brcm80211-dev-list.pdl@broadcom.com
References: <CGME20260416093428eucas1p2fde898f84c1e15dd94d1ecb52707c72b@eucas1p2.samsung.com>
 <20260416093339.2066829-1-m.szyprowski@samsung.com>
Content-Language: en-US
From: Arend van Spriel <arend.vanspriel@broadcom.com>
In-Reply-To: <20260416093339.2066829-1-m.szyprowski@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[broadcom.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34957-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,broadcom.com:email,broadcom.com:dkim,broadcom.com:mid,samsung.com:email];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[arend.vanspriel@broadcom.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 5CD3B41E3CB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 16/04/2026 11:33, Marek Szyprowski wrote:
> Watchdog task might end between send_sig() and kthread_stop() calls, what
> results in the use-after-free issue. Fix this by increasing watchdog task
> reference count before calling send_sig() and dropping it by switching to
> kthread_stop_put().
> 
> Fixes: 373c83a801f1 ("brcmfmac: stop watchdog before detach and free everything")
> Fixes: a9ffda88be74 ("brcm80211: fmac: abstract bus_stop interface function pointer")

Looks good to me. Maybe add stable?

Acked-by: Arend van Spriel <arend.vanspriel@broadcom.com>

> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---

[...]

> ---
>   drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)

