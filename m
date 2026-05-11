Return-Path: <linux-wireless+bounces-36270-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +FlUCclYAmosrgEAu9opvQ
	(envelope-from <linux-wireless+bounces-36270-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 12 May 2026 00:31:37 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 69DA1516EEC
	for <lists+linux-wireless@lfdr.de>; Tue, 12 May 2026 00:31:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A2145301081A
	for <lists+linux-wireless@lfdr.de>; Mon, 11 May 2026 22:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF55B38332E;
	Mon, 11 May 2026 22:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rqsetq6C"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33FCE38331E
	for <linux-wireless@vger.kernel.org>; Mon, 11 May 2026 22:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778538443; cv=none; b=QA6fdD8K3nOurFxLhd0aThTPTg/+6wS81ZnJHu03MqPb8+0kGrNWLRPHGHLyH3/ErrOxsWJaqO1luiXV9QOS1hioh5vj3UjXv4MX0NsNOOAo4FaVA6F8cQbcHqnNdr5rslFORoU7yO9iDeusci5Vbl9bn0AP5I2TsXIB+VMSdbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778538443; c=relaxed/simple;
	bh=FWlyBh2q5V+zPZMy+exr9+ArEJtrhdsx0i5p6S0h32U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TR2dyQ9+Xp+tStgh29FSGqnyoQK7kRvCjf636981XDk89ScongGma7YpgPYs9y803P6D89ukzzzV1IZkmNazOARtSZZYSpU3X0U43I7fjTTUFBqDEqgZL56tnC1+vy5gIu1txSUa1X3omEZdnwGhpINp1QPRK1Hd8221sYejgv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rqsetq6C; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-44509921fbcso2446086f8f.3
        for <linux-wireless@vger.kernel.org>; Mon, 11 May 2026 15:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778538440; x=1779143240; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kZ+TNFFo0ZvACDVJbx2uKJL3MGxTnCe+bTWA4bE1edA=;
        b=Rqsetq6CbA1op4pJNLYcSdicU4MXsATlyJ6Ofozvp8bXPdr7UC5GxFiNTFZb+84ZcP
         /EVmZr94c1cBbfmWkJyozt3hld7d/B7KeJZUP9uWuzx8IYJ2t2yZJbxWCmR4NAcqZ7rJ
         +WOR1rP7ORmBXGV6RSpT4EQSaOILRwYcXnWMTFw5q13poQ6sLjtxE7lNHufpdNgLsDx3
         7mhUG7LyDQf/zvrIQMLoNZ6VXU6/T9/XyEs59snJkistqJfOATbEnsonBln27QjqyrnC
         HNCsHQG4fRh/3G0zeC08DDb7XQkBk9JixLOkX5n9MsQeKtnXPw5mo09YwFs8aF08Aicw
         KuMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778538440; x=1779143240;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kZ+TNFFo0ZvACDVJbx2uKJL3MGxTnCe+bTWA4bE1edA=;
        b=IJNGbBMNdVYtlFFd7B83p6zMtnWpnlPO+MW00KkFLXh8XyvQ8FG3rWVf6Uubagub/b
         Q5VUD1sAJiIPbKPQckheWCgOUwDSc+RSskID8ETWfBmmdmvz9huXSEs7yf9W2nj8nLea
         2L45UlnyO5yeNrHApjkbYNJFqnuqRXkFgNr/pTZiJN2i0J/YTWWZP39INDUCVsHW6SAZ
         HSGkcS6feRAdaOVqKIlBFqR5v8PxIlNiVgVXZF2+y/qgZraHWpDYLnia8MSTCQ39Vu+Y
         Oe7FHq4Yfb4s/ZyK4S06KZFLtZ+qHolbATHY6HYl9D8Jiv5sdfarFHTe4PD1c2G0FHwJ
         wrYQ==
X-Forwarded-Encrypted: i=1; AFNElJ+6LD+nK56Ebrx+V36V2pUJuMmsNVTgl9CODxouFTy5RM8jWi9UFHmop8zhuFhcH0oUd/aX7cXLOY9Rv+e3aA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/0E4Q2Qj/YtDLHrltEWpznttAsJ0ybg8YoSqu/sUNil/Tv6Ob
	t+6uXOMVY1UKiaQOHO5OWdS8ndjRBLC8QvhtmU4RCfw+ffU2emLtYuLy
X-Gm-Gg: Acq92OGQSsCkiz9sh40hIpB16dXTIPYBcWHSDfWsmH2AQZcJ+JpmsWI4sqibYcFMYy5
	jtis/ca5Pa1c9GQn4fDq416ofKC3wVi11/CGhDJ6eHjMNKQDW6qTMfJcQfKYszjtY/IHbkWYnVZ
	iE38o7Z4eoJTF6DjdaCaZg/aJwCbm3IT/ST1YuoLZrMMYTsFt74FyLOsSTUtE09Wv/oL7AfKER5
	JtpfOn1/jwWXP53/c1tL57EjuC9beBvgeQSEaLssz00fyMOXRhB/ZZddBqqsh1lHC5ryqHTu00h
	Zdz7MiGn69JGbwMhKEdHeBG64pENrx/Yi6XChldBIxB0VonJNPASwez6cmUMNUqNDLjkz8NFjgv
	xOx4TCTleZ/uVhoBlC0u7XjBTapbd/VI1L8fQ+FkoXWsgJgjx1sWj54jWaVaTpB1DTUGyRbAHDQ
	Om/PtBVWLM+Du81P3xZB67cNa9Sfu5YQ==
X-Received: by 2002:a05:6000:4381:b0:44f:ba97:6d8c with SMTP id ffacd0b85a97d-4515ce1c7f9mr41603131f8f.23.1778538440445;
        Mon, 11 May 2026 15:27:20 -0700 (PDT)
Received: from [192.168.1.50] ([81.196.40.93])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4548e6a6470sm24300117f8f.7.2026.05.11.15.27.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 May 2026 15:27:20 -0700 (PDT)
Message-ID: <2bc415d6-f0ae-42ab-8ffa-19cfb1df5954@gmail.com>
Date: Tue, 12 May 2026 01:27:18 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rtw-next v2 1/1] wifi: rtw89: usb: Support switching to
 USB 3 mode
To: Devin Wittmayer <lucid_duck@justthetip.ca>, linux-wireless@vger.kernel.org
Cc: pkshih@realtek.com, johannes@sipsolutions.net,
 linux-kernel@vger.kernel.org
References: <639b2f23-bff3-400f-b5ef-e7d0c39196bc@gmail.com>
 <20260511200339.33682-1-lucid_duck@justthetip.ca>
Content-Language: en-US
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
In-Reply-To: <20260511200339.33682-1-lucid_duck@justthetip.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 69DA1516EEC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-36270-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rtl8821cerfe2@gmail.com,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On 11/05/2026 23:03, Devin Wittmayer wrote:
> On Mon, 2026-05-11 at 21:14 +0300, Bitterblue Smith wrote:
>> Are you quite sure you tested this?
> 
> Yes. Full test matrix is in the v2 cover letter (PATCH 0/1) of
> this series:
> 

Good, good. So how did you avoid the crash?

> - DWA-X1850 A1 / B1 (RTL8852AU)
> - BrosTrend AX1L / AX4L (RTL8852BU)
> - BrosTrend AX8L / EDUP AXE5400 (RTL8852CU)
> 
> Six adapters, x86_64 Tiger Lake xHCI + aarch64 BCM2712 / RP1 hosts.
> 60 plug-cycles + 30+ throughput cells captured 2026-04-11 to
> 2026-05-07. USB enumeration verified at SuperSpeed (5000 Mbps) on
> every patched cell.
> 
> Per-cell raw evidence for the May 2026 expanded matrix (40 iperf3
> JSON files per cell, byte-counter deltas, pre/post link state,
> pre/post USB enumeration speeds, per-iteration timestamps) at:
> 
> https://github.com/Lucid-Duck/rtw89-usb3-gap/tree/main/evidence/may-2026-laptop
> 
> Per-adapter summaries:
> 
> https://github.com/Lucid-Duck/rtw89-usb3-gap/tree/main/adapters
> 
> If the Tested-by trailer should be annotated with the specific chip
> list, I will add that when, and if, a v3 is needed.
> 
> Devin


