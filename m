Return-Path: <linux-wireless+bounces-35098-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oFAVExJv5mmBwAEAu9opvQ
	(envelope-from <linux-wireless+bounces-35098-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 20:23:14 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DB505432C22
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 20:23:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0BCEA301707D
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 18:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA2743AD52D;
	Mon, 20 Apr 2026 18:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c14S5itn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9B783AE6E9
	for <linux-wireless@vger.kernel.org>; Mon, 20 Apr 2026 18:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776709377; cv=none; b=kgIK4EMADEhTOwx5LP3Vj8t18s6a4WyIsxYaiVdixdfB122jZfm5o/2E8rZsRMXssi2OAHCLKhZXZ4BdJ0an/e7J8y3TIt3ARx1icDj88FRl3FwfLCHbHyU+VymCAAY6xGHZexFfqFAUgHxr9T6ZI4+Nk4xc6/uto5mmcCh90L4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776709377; c=relaxed/simple;
	bh=XWe4i9QepLP+9h5IN2HkNSB5Qx2RuhDSgDAIiyvm5gE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=X/2NLKl1diyzZXhlQrxkMlo1Q1UbosoJjaXel21M/eFzTSw5b+1iQv7o2fpgx11VYpWad8yzzlIPw8aRKgECSUMriJbfrVdcZKUzqcNhDlDiNL0o7DgYp6LprqXmS9/IzXRxBTi4lvYOYMpaNuKej5amMxtiNepi33Ybr0jCC8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c14S5itn; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-488b0e1b870so52493575e9.2
        for <linux-wireless@vger.kernel.org>; Mon, 20 Apr 2026 11:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776709374; x=1777314174; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GWBG57T8S1tttSb1tFMazgjdhUTWyBl5kZAxLKUyDnw=;
        b=c14S5itnYaqhWkj/lZlwuUtXuB+WZ44m5BwmfaP9QioWWJGhV6xgZXP72AKF4cBhPq
         Bewq0A9htucFlITyHllOqjQX6x2wCLyF1kWI4DU/FE1zhBfz0ls7PO0Kibl9T8hEJE9S
         ipFUMHQlMpdGg5Cp3CCsnr1hT0oYdB66uYfTJP9jrcElRURYr/YQpPpWrAtmgLWtnDat
         m0UCHqItv60Uw1ypIJ3/RqgV3z3rbzULKYMEwZttE7zz8qhAn7g+bWgC87ox8zCLHnK9
         qUv6hGtFYgX5yW9mgGEHyIAYrvn5UDwAFA5mRg9BpAyEjiyQLCtHTuexlbSO3HzM4Yc0
         knSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776709374; x=1777314174;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GWBG57T8S1tttSb1tFMazgjdhUTWyBl5kZAxLKUyDnw=;
        b=XaaQZt1GsfvJPLK2R9xK/EIvzp9VKeSKm3/9BZPUBIsUnxJppzF7nlrtsybQhrTESl
         XV3+nr3V97aYBP1i22c1ekXK77G518sb/Ni8M1omO8JIG2c5jYmGi7UdsBfFImTAC/fP
         Jpw+AFLEKVVo+JZFaQ5e7IocNPGovOREmDAdvr+wE5b7wUnrrJqUaTbX1SZV3AOPG21X
         e1u+A3TnZrM6cTFP9dsRuJYz870Q03Bxt/4/5S0PpYL/XBwlQ2r/EkOLxlO8mpBa3CHc
         ufIK6DH0zryPiloKsBL4nBhoy1at5pcv7mzg+/nOdqozQmUw0ppmLs/sgHD/cHOcmZvn
         fBcA==
X-Forwarded-Encrypted: i=1; AFNElJ9eSInR6XxQLTbGV+VuPwpMv1YyDZjrL9J80SMLJ9S9cHfk3N8jz3HMeLKPZ8xoXaajhPEzxMQN4atA4mQBCA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3SSIV58vflKKuVi1gx6SjiVVGQyUBWetnhExKI4MRIXOXlMoy
	UIsVk33Wfp1dfnBzzfx0Ac1lWXhpqu6mStCMIAoG4b3f5MIxh/5jc+xridmX4A==
X-Gm-Gg: AeBDies3nAu+3pIgcXE/XqH0SpjvNXNwRAR6E9hS265jSBAcff92Ep8b+vPmCymCmUd
	SvQcYgYXkZSn6R2llIgin3fqWz6ukkd0uDI90hvD63uYh4etBczcY2wtrpHw5oLNzgMry1eXife
	rKL2IBl7kVGD3PCFHll0MoiFR7KHbQ4MgCfmPuy5TuitsHX3/weF/ARR19HtvwpLjaiF/snGG8W
	UGLWcabRFQmwcOhDyDsljECZartYzR6lvlth3YzybIJSDEYHfUpxQdNJItSF8rQ92SLhG3XQd3Q
	rF3x2Da9ZRlhwUDa9eEtTb8fuAE3Ptxm+uu3J8HQvcOfsnCMSg1WyO91NRsW1PpLh2kwYPP6qLO
	L9VWc2dYMYny0RDsCwZZC7sSYs1nwh0OOEKDfJsbnd4x93dNPg9wI+1OLU0unAwZyHiMfWp6k3J
	ZQVsirNPjPmdsl3cTPizxca+T0WVraRP1tUTYLu+sI
X-Received: by 2002:a05:600c:a309:b0:488:dfbc:490c with SMTP id 5b1f17b1804b1-488fb765df6mr141548225e9.16.1776709373995;
        Mon, 20 Apr 2026 11:22:53 -0700 (PDT)
Received: from [192.168.1.50] ([81.196.40.93])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fc1393f5sm286817755e9.9.2026.04.20.11.22.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Apr 2026 11:22:53 -0700 (PDT)
Message-ID: <2ba61201-5e3c-4b95-88a1-38dd5812ebf0@gmail.com>
Date: Mon, 20 Apr 2026 21:22:52 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rtw-next v2 00/11] wifi: rtw89: Add support for RTL8922AU
To: Ping-Ke Shih <pkshih@realtek.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
References: <6ba2910d-020c-41bd-86fa-d1b0e0f7a2f5@gmail.com>
 <6c97027e16a5407da0031eb503219a25@realtek.com>
Content-Language: en-US
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
In-Reply-To: <6c97027e16a5407da0031eb503219a25@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-35098-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWO(0.00)[2];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rtl8821cerfe2@gmail.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DB505432C22
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 20/04/2026 11:20, Ping-Ke Shih wrote:
> 
> Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:
>> Two people have tested MLO since v1. It doesn't explode, so I dropped
>> the patch to disable MLO. (It doesn't work very well with MLO, but
>> ¯\_(ツ)_/¯)
> 
> Could you share the link they did? We can check them internally.
> 
> Ping-Ke
> 
> 
> 

One reports that it works fine:

https://github.com/morrownr/USB-WiFi/issues/494#issuecomment-4276727919

One reports constant disconnections and strange errors like
"sec cam entry is empty":

https://github.com/morrownr/rtw89/issues/23#issuecomment-4226769914

