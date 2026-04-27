Return-Path: <linux-wireless+bounces-35412-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +P9cCpDV72nXGgEAu9opvQ
	(envelope-from <linux-wireless+bounces-35412-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Apr 2026 23:30:56 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E1E547AA91
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Apr 2026 23:30:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3BF1D30091CC
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Apr 2026 21:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A71FD2F7478;
	Mon, 27 Apr 2026 21:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dX7LcybM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 535F740DFD3
	for <linux-wireless@vger.kernel.org>; Mon, 27 Apr 2026 21:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777325449; cv=none; b=ZD651Qjq879RfkHDWAwb9sZlwjIODdNwOd17RF09O7EcNbwsVhDgHNkAUEJ+J+zZ2e+LhdLKIiNjGuySobI2tUMp+F1b3afWIUunpgSN7pi+WAPRvc8mvELgvF0JI09VJvyvOrh1fJo70H9ft71T9HeneH3tmt4jQ/1VdYogQjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777325449; c=relaxed/simple;
	bh=dZMg/iO3WT67p6o6CMNxNJ1RmI2LZm00xdN5WPD7stk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tujOPPSqkFjiyN3Vd2cFApHLr8VcgBDedogKKktForrryXwMU55HzslsKrcdZtBagirjztq+qMZ4HR8a6zp1mowT0thfeZl62sMXTWh4dEkD2C0NHcOWwzWDhk0sW7d78j4p1eC3Ybu4iUYmIuI+hNYwljlYLzHQc3KzO2OWOEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dX7LcybM; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-48334ee0aeaso112153755e9.1
        for <linux-wireless@vger.kernel.org>; Mon, 27 Apr 2026 14:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777325447; x=1777930247; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NGrdIB6e54iBDZR36z7TGsqEMccCh06sjtzlRZbmXwk=;
        b=dX7LcybMRiOfFpKYoUU8olH26VcIC5Grhp8wmLerbHBb1o6JYgobj1AIaN4uoj6YCb
         jbCSo7GtNds/+YIDXNHTWkM2pHPPAddjnlnmABE6+6dy+uw9FKwd1IPoXc24zDHANJH9
         9kMxUEL5+Wx7zUWgEvYNCqzV/qZIQZvGZDiCz7w0Z0ZneDhkuk0cKbmzTkFH1qmHntSB
         n9IP2NovUY1AsqaMzHXv8z7ixhehnJxG6J5Bqwix+Jau+0VA/uQ1dB5zT7oB2mj8AlBk
         xExfIXoFU+FKgcBdPPwUNMxrxxI7TOLdsk8E+5oTgQWQD3FTUSoay3WGt4XeFTn4Mgqw
         ByLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777325447; x=1777930247;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NGrdIB6e54iBDZR36z7TGsqEMccCh06sjtzlRZbmXwk=;
        b=qM/eRjd7oLnQzqg6mU0RLJOVNOpwC+9LvHIisfcvYV+IaFh1ikSOCNUD0EccPqoyr3
         xRAov/nOP7ZwkjX25I2RL7Hc7Ir6HVu2vJPZcXrGZ64Y3CJm1VOLtP7F1evboD7UJ3HD
         9pUaWN44wQxHoM2iW932l5MH80gLsA3YZls0beEH0LlvSPU+0CH17g+U3OHrHTWGDn/p
         WQaaV6EaR5Kz4CIx5AaLDI32KEF4Y6BjQpzrvzPBpOQAdx6tEVUEa7YWR6UYnZQSoDxI
         ThWHYtxu428RRGGf2Euih9rIRnmJcVfCVdWRt4ixiIU7pCUcV49PTr8qodMNEEsV5PB4
         OXZQ==
X-Forwarded-Encrypted: i=1; AFNElJ/CihLuzWpYbXZ7Qx6RVWkMtnpvbgAHkeW+uD5oEdWz926pcxACn4fasVXvKfZy5zUo+HnYSS2FAKSvuDBF+w==@vger.kernel.org
X-Gm-Message-State: AOJu0YyPNxkUdum24lgoQM5letkCBkKB+Dq5GoCqnsoZ/+Iw1jnJ+agR
	Q6PUz5wz/nNhdsWkDO6UQhufSdP/IdYrXRK2fWKheFL38WRBYsZOe4qH
X-Gm-Gg: AeBDietRA+7v9q18TzMZ4Gu+OlNpVXCm4ErGXRXVY+oFuMYpDd8lU+2DjwmwiZVL6mh
	A53hsAcQW3mhq9fl4jPZA4L35at6lktEKQh3M2KIKNTmy9s+hXITGmuMSJ/9aHQPlf2XWZjVcnC
	ta4Fv5/Da7IpKXpDgWHqWnJbKqFOkcA19srfqhyuCCa+XvHX5ubZbLfssjmCm61rgCkTZZUGCJL
	mKcvu/TxEtnWG0JtLQxFIt2XXX0Tg8Fn8DkPRwiuUR5Sr/wjXsdS7KI5y0Q6pmptiGjIAtxniFE
	+OR2+6UXLRjv3+LiGdJaeekYxCX/DwA85VA/AzNLTWGZyx2BfJ2Z9eydQUJHCV3RjSACqSqmwel
	lwEFgJ2msIYbdpRTKSgjNbCnDXDqkAWSQBWHJylcDK7YtDb0dEddLNls+iyEzF9uJ2scRz4GGCT
	3Kx5/yp/V1PUV1aq1VzvsdxB9c6qqUgoNMF5OnIOst
X-Received: by 2002:a05:600c:3b96:b0:485:35d3:ce59 with SMTP id 5b1f17b1804b1-48a77aefe5amr5438685e9.10.1777325446601;
        Mon, 27 Apr 2026 14:30:46 -0700 (PDT)
Received: from [192.168.1.50] ([81.196.40.93])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a77449ce5sm7309135e9.0.2026.04.27.14.30.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Apr 2026 14:30:46 -0700 (PDT)
Message-ID: <4f40d96c-4cd5-4e01-846b-745e346b6744@gmail.com>
Date: Tue, 28 Apr 2026 00:30:43 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] wifi: rtw88: Hard system freeze on RTL8821CE when
 power_save is enabled (LPS/ASPM conflict)
To: LB F <goainwo@gmail.com>
Cc: Ping-Ke Shih <pkshih@realtek.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <CALdGYqSQ1Ko2TTBhUizMu_FvLMUAuQfFrVwS10n_C-LSQJQQkQ@mail.gmail.com>
 <CALdGYqQ_RCOwa2J-GsEyCxCQ4bztyxSzbc+6eYNesBSaY3Nt-w@mail.gmail.com>
 <da30a61b-dad0-48ff-a283-3dd8e9bdf91d@gmail.com>
 <CALdGYqS53=MmG4yCLwgV+RJAZ=U8Aqi8QQZFZ5oFMernhSyxTg@mail.gmail.com>
 <5eb90d6d-e590-4c9e-91c8-1ba315f45304@gmail.com>
 <CALdGYqRkX8=XMOePeauxvSTDZFLEYyJZKCtoxCzqaNwdO6BNnw@mail.gmail.com>
 <a5ea6373-8c07-4fcd-95fc-d87ce6aef6d5@gmail.com>
 <6898154c58c84536a0dd4351b3b026fb@realtek.com>
 <CALdGYqT2e+jt+mK-o_bL8hfdEwqZ44fUt9_N6-H4jYp8FpqQJw@mail.gmail.com>
 <5fb2f699626b483b8a0a537960b274f0@realtek.com>
 <5f9003ca-3bfc-45aa-bf0e-35e9c991629d@gmail.com>
 <faa215f1-ac2c-4072-9603-4baca1d5e07b@gmail.com>
 <CALdGYqQ+Syz+6weTChA=aXe=DBZSi1c0-7OYhJgkj7ahpR4EUA@mail.gmail.com>
 <CALdGYqSS1WXdqHi1rp+PznVOW9wCF3vDC6qkScUXNV5YHQ=Bjg@mail.gmail.com>
 <CALdGYqSS_4yrKn73UHR3zfgJN98wjR71V=pn+1C4pvg2UXGHyA@mail.gmail.com>
 <CALdGYqRK+a7-7WEXgp1H-w-1AaQhhbTW9FTWtpmfGN_yXuDGSQ@mail.gmail.com>
Content-Language: en-US
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
In-Reply-To: <CALdGYqRK+a7-7WEXgp1H-w-1AaQhhbTW9FTWtpmfGN_yXuDGSQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 1E1E547AA91
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-35412-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rtl8821cerfe2@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

On 28/04/2026 00:19, LB F wrote:

> I will continue monitoring over the next few days to confirm long-term
> reliability.
> 
> Best regards, Oleksandr Havrylov

Will you use the Bluetooth headphones again?

