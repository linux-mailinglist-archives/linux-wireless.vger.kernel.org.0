Return-Path: <linux-wireless+bounces-36313-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CJn2F9bpAmpKygEAu9opvQ
	(envelope-from <linux-wireless+bounces-36313-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 12 May 2026 10:50:30 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CB93851D09F
	for <lists+linux-wireless@lfdr.de>; Tue, 12 May 2026 10:50:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 97F2C307824F
	for <lists+linux-wireless@lfdr.de>; Tue, 12 May 2026 08:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20D71389DE3;
	Tue, 12 May 2026 08:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ob8LcxcG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B432A3876CE
	for <linux-wireless@vger.kernel.org>; Tue, 12 May 2026 08:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778575699; cv=none; b=MBc3bKlWwiDthDEeHCTOhDRyA+dnpv4hebCiQGRdRGd22Of3NwO21YI3QeEIf8/Fc4Ltw7/uruLWp3XaScYskrwSy2tb0KjXGR3xrlPp4rRDfCSA2h1uLPqs0YbiZj0iiBA5p9l4FTcX1q4HtI5alxpMcv1Ty74SicgorIUTWrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778575699; c=relaxed/simple;
	bh=IlUzYZxqBAH0Q6WDCPJrudBD5c5TZ+XGUokZlRc6Po0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XnTAaq4zy/5huSnFfzg9PjePD+JnEkFIwU6RpsOyrNbt7Y4Fm9ItTKzGn10m9V/BIs9og/d1Ztw02FQYzl++YfAzammHV8+6Uh81jyvg2fvbbLn3mw59vKqHLH733gVEEgpQtKvmlDNz8cB5DcBGyhCn3nS5wNA6+bsF0bGoSm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ob8LcxcG; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-48a563e4ef7so47232245e9.0
        for <linux-wireless@vger.kernel.org>; Tue, 12 May 2026 01:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778575690; x=1779180490; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Xj1G1pSEqbcJ5QxMmU1lhUr+tLYTe93/lkIQVH+0lO0=;
        b=ob8LcxcGj6XyPo4ggOsCs8NTrHAMZu/pDto7Dqlvz1XgxnZYMzcxy+ByUtEdtjMuLV
         bj9z5yLxm8DQriX89/hkZSo4HUKrPpC9iPqy4nUoSBA0bgt52mHPTKsdlbXW+kT7p5r1
         BfP3th50+QTq5ksg8J7ro7nWi3b1/8X9Eti2bt4/6P//mBln86t9mHJTZ8jHBAie8pcZ
         PybVr6kDXuYAPubY8F79OFVPDasygipSGeGG+q71iaQV0Y5DLNYFEkrC8LVnvwcQ/mZ0
         g9/ICFelMEsRyrpKNlvASS04k/09W5mmDSpChl+RKxOELKuvfIBUzLOeavwGOyJuCign
         r6/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778575690; x=1779180490;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xj1G1pSEqbcJ5QxMmU1lhUr+tLYTe93/lkIQVH+0lO0=;
        b=Fw0MKwIStPecem+UJvjiZOs3lxo1PwanceAtDHgL41EgJrlf+yf+W/XW0F9WGDSgsb
         txLW2jcIEEDKw1iEdl8YvtayXwo/X0+Djba4hi+pe9A6SDbBDU6rQTYRDdwKD+0+c+Zp
         1dAx8QBaV12g4TWZmW8wutHXhOy6PJAi7KrHa76qCz7DMH950KhBl3bIa8VYr4cB7D/O
         b0NxShWmFM4ZFhyjyEFIl6mn0LK0kjqHRbvN9IMPmJ2WASLddWv/QQRBD19nqGhmpDrk
         dksfc9tNnDpigqvDHynW4edCqTbxX8EDMkwfMonH+vjHpXH/8nTu/+i9OchXU17Zg7kv
         XgTA==
X-Forwarded-Encrypted: i=1; AFNElJ9ztuG0I8H4dUBTCugBmtAt320FD6zaGRJGQXTE6axsY6JvcFU3OsS+0cKhl5n69zKRc9w0Fh1L3ND14hitRA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzYq6lDtUg/Pxo0DAiNzb1DE/Y4Zx8MS2lMIdrGqGpnk/EC0GtR
	QxKPPDfe5ld/psrOafE+AquRCyFhYcnkw5dtizIygeA0jabuvQ37rMW1
X-Gm-Gg: Acq92OFix0OvPbdAXf7+uY2uk1VJRadYQYfDoWP0GzmVAifE4VVE4h/89HXGQlAiSSc
	qsQax7ihXLemvV1yNXWaaABL+4/7snS0GQYXty8Gh2XH4Kzm5JYZjvdCJfhhB4EAW5PLrMfMcp6
	mZYxhOeWfFhJxU5GuKItsvT0zrWj8Ee79s5i/f8mTpQRI9+ypCmF/0hLXaUSe3w650QBsz5C0zv
	kZZQVyOps4F0J98203rIya2lhSX+jNB8GoXasOUMtJdNhSd3shFA7gGRy9C6e40hdbLluYN6e4l
	pWANrLBMOFMYRpCN0SlR2JJUX/AdTBmFd6VjmQ0d8bKDpazK2mcjfX+ySCKqWfIWi/kNqby4jeL
	s7Ur2Yu8tOA7SuZKwVkW/Mc83yO8np5L68lue3dd2SJeLOZuz3aaUoIkWZrYq1+bm6w4zBUTMp2
	95+GHM5F9dxXRZldxZVbU0NiV2E7/eiA==
X-Received: by 2002:a05:600c:c166:b0:48a:93f8:dd02 with SMTP id 5b1f17b1804b1-48e8fe7227cmr30377025e9.14.1778575690240;
        Tue, 12 May 2026 01:48:10 -0700 (PDT)
Received: from [192.168.1.50] ([81.196.40.93])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e906b04a9sm50467325e9.7.2026.05.12.01.48.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 May 2026 01:48:09 -0700 (PDT)
Message-ID: <90a92b9c-98dc-4852-bde2-73558d9508b5@gmail.com>
Date: Tue, 12 May 2026 11:48:07 +0300
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
References: <2bc415d6-f0ae-42ab-8ffa-19cfb1df5954@gmail.com>
 <20260512003559.44110-1-lucid_duck@justthetip.ca>
Content-Language: en-US
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
In-Reply-To: <20260512003559.44110-1-lucid_duck@justthetip.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: CB93851D09F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-36313-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On 12/05/2026 03:35, Devin Wittmayer wrote:
> On Tue, 2026-05-12 at 01:27 +0300, Bitterblue Smith wrote:
>> Good, good. So how did you avoid the crash?
> 
> If you mean the crash at
> https://github.com/Lucid-Duck/rtw89-usb3-gap/tree/main/evidence/crash-2026-04-11

No, not that one.

> -- that was BE-gen DACK calibration and is unrelated to this
> USB 2-to-3 switch-mode patch. Four AX-gen adapters concurrent on
> one xHCI host complete switch-mode and RF calibration without
> DACK errors.
> 
> Devin


