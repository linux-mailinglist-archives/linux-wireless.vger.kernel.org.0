Return-Path: <linux-wireless+bounces-37825-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id edcAONxbMGpSSAUAu9opvQ
	(envelope-from <linux-wireless+bounces-37825-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Jun 2026 22:09:00 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D16E689AFD
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Jun 2026 22:08:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gapp-nthu-edu-tw.20251104.gappssmtp.com header.s=20251104 header.b=Jdap8bir;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37825-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37825-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nthu.edu.tw (policy=none);
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 65B023001580
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Jun 2026 20:08:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05E2D3B42F4;
	Mon, 15 Jun 2026 20:08:55 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A5D929BDBB
	for <linux-wireless@vger.kernel.org>; Mon, 15 Jun 2026 20:08:51 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781554134; cv=pass; b=dD0oW1FXwnNUjM7w07W1CVuZe4tM3gh6gn3WcQ0Eni4wz80YVb1ebGiw1cME61OnETBsDgIcAAPknm9DU7UhMOEJ63ZgX7dfAzv9v8VJCYL7W0qx6PZTH89LLE/n15UZniK5Vm+gvOGyw9zzFnE82kWPn81NhSiFQTB0Gef08JQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781554134; c=relaxed/simple;
	bh=jW2/gGbMfZBCrJEyq5/tJjiYnaXDmD6RewUi/73w+9I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N3y6Ta+mrwOdahdmKyRyFTeIDYeDARW5VYbGKMNlynL/nKPBZUqBRk+p62VX/WlBXr+v6Cdx3Fhiq8IndREHte0npN8AN3fslICb/w+I0fVt4gRrtaR+Qo0C9eKlERF4WlbAGmrJgXZlrJKYIrOFgAagj8FgslRhm9bTBh96Dp8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gapp.nthu.edu.tw; spf=pass smtp.mailfrom=gapp.nthu.edu.tw; dkim=pass (2048-bit key) header.d=gapp-nthu-edu-tw.20251104.gappssmtp.com header.i=@gapp-nthu-edu-tw.20251104.gappssmtp.com header.b=Jdap8bir; arc=pass smtp.client-ip=74.125.82.170
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-307263ad0cbso5824358eec.0
        for <linux-wireless@vger.kernel.org>; Mon, 15 Jun 2026 13:08:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781554131; cv=none;
        d=google.com; s=arc-20240605;
        b=NTyYRT/s6O+HyXPqeU37a7813wo5UpJuZ/CGAAcCgXcMkCH2UYS3TkRPG0jgZZNC8K
         FjEhKn82nPqaJWKjMc1aLQ2k9U8QEKK0h1aNzxc3QI8K1hmHm9X3/hCoBeMELY26MiGp
         qgWVEObmP3SiOh1jDnffujsK6umfHckgehlzpVvbd19jOWrmrJrqrPyGJGsx/vzabAe7
         iwiEoSuXH1K3QQF2iJj3LjsE3kS0+SBtrRv1U5+aOxHxV6oNKdwbsLNIoyP1CQMbAwhl
         vzqFbchkPjHKyzg+jO+0mOTnXAQ8ZTc6eD5qu9cZrNWxzezk5z4gPTSht9PRZwBWlQCr
         P3kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=jW2/gGbMfZBCrJEyq5/tJjiYnaXDmD6RewUi/73w+9I=;
        fh=qM2UQlongwteKjfGnVGVyWpIXqmppeAxdMnUO0tYBxk=;
        b=lD2rdjGwbfmfYclS+a5kn/0XsYksY/dUH6Uj1ErxeEjIt+DavcXsiXhtdgB88paOF8
         QHhzEhbqmfwmhcdVsX5sxjc1Bv2JjtkA3U0lXlq2PyupV2gBNYkP3Gw4TwMsxJSSWUAF
         8EpGkoq6qlAHtahN5UxZcSBi2m21Dv21IAgBoiox8rFxdX9nE6woXFA+lsz4SeYhc+fr
         jKHCUk8K0uOLubtBH+nH6RFqocAOzSGsVaBpYFYrBvJdURZpo44KQP0b+1MUlSmhfzvD
         a8k+pMWB0bC9aiMbnDx1+R/PmZHaa6k4RZ+34xa1wQRfxATusfc6tkw7DoI3MTgNzUOu
         tPzg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gapp-nthu-edu-tw.20251104.gappssmtp.com; s=20251104; t=1781554131; x=1782158931; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jW2/gGbMfZBCrJEyq5/tJjiYnaXDmD6RewUi/73w+9I=;
        b=Jdap8bir5FiiTt+bcQxxKMUatQx9l8zmKPbg64/lNWnynG/LVlpNl7umfXEGRZg9cX
         7bnsdiTY4hT5eL2YedBCn5fGnwXTL1Q+y5Q9AJmJoFG3NFy5oKA9mQhnj3ueYToqJh2/
         lIbmR6zBnd0cY3f7YLBwKcZEDA2OZD7cBeAxtMZpDjFqTmoowJEEw9l7Z8ryot3vY3mr
         G4JAr4LoVq8DrfvPomlIk3S1vIA2KoiGKIxiVLfWaI7daYMXTybaXDSBGkRbKbqU4fkl
         1nCfBOTnhB/7zPJOTola20I5tjhySdX/r07ELEAl8eVBRBDdu8V6TAwK0AuArg4xCsE+
         VjKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781554131; x=1782158931;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jW2/gGbMfZBCrJEyq5/tJjiYnaXDmD6RewUi/73w+9I=;
        b=pry/mWjVrXAhBGpKnRzh+NGEhNQR2Y1gAmnbvu4toR2uUtRHwN4bIzgvI/HgqYpvxN
         qcLf7r9vHNXwMXe2l+czD3AaGn9B6rnDSceZUtHKu6ts8WPwiGSDfZ/qsPToM8+Q3qYk
         1WuyHYHPWHh57lzxGXgzNWRru+NzO44tXKQ2VRmVob8PIm3TwQg8grDOW4RkpPycb9Mg
         YTm3W2QK5heh1DnsiANlt8fzs8bixu/BNSALk/+MS2LAKtBb6dExEsdBRUpZ3yFPRDor
         nWRllQrBTeslnJojIUkWduv3ft3w4A33GjkO7YhXl0SauuVZsIdaw26mLeGxeBumJtiL
         uAHg==
X-Gm-Message-State: AOJu0Yxb0+dKBm1k370f6K0Vgeoe/4gSgnGCGIG1yih+ZAC1mSsq4gti
	9H4ztRk8bwmMVkd887NYhOZLJxSg2MaIlDx2UliH193z85E02/rBNol9lrH94t+2ytORMx6kc/u
	hBDIpEbSFihI4SjqLAfEAMSUkxvdH7yl67sLgaWu6cQ==
X-Gm-Gg: Acq92OG6Xdnp/55iXAR2UGEinOlOlShxV/T4mwPvYifQB4m+P2YUAfWrKj5ga2raVgp
	YoXj7lTGF4l5ir9vvL0rzXOrGmfdYReAklKyDsnG9XGhhDqjUPvsLE/lWFbnNVjmvykq9mXMKqT
	nzOCmDROYbSGOOwsb45cXpEsJt0II8dHKFBTZDqDvRa8xsb+OIam7czqR+2wqkgfXb+vD0q8D5r
	C5GsmSh9aMF6ffri38LwzEuXVjGZpJ/CV/4aEXKbgxdAfbHlT4dLym4XDHNHuJ/frdvTyqwuPlx
	12Wk+IQbmOpzJZSZZvtly9dQKAhnlQU4hQO7SErF
X-Received: by 2002:a05:7300:724e:b0:304:9b48:53da with SMTP id
 5a478bee46e88-3093d25a08bmr6164911eec.26.1781554131144; Mon, 15 Jun 2026
 13:08:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260613170434.23645-1-ku.loong@gapp.nthu.edu.tw>
 <5183c87219e2489eb99c9015cb96a7f8@realtek.com> <8e0121a2437547dd812ded7f5ee4e4f7@realtek.com>
In-Reply-To: <8e0121a2437547dd812ded7f5ee4e4f7@realtek.com>
From: Chen Jung Ku <ku.loong@gapp.nthu.edu.tw>
Date: Tue, 16 Jun 2026 04:08:38 +0800
X-Gm-Features: AVVi8CffodDpRwgzXHVN0UFv86gVAc8usaNIRIXEjkvy0ZQas5_3GX_PDpFowDQ
Message-ID: <CAFS7P6Mxk_QvqfjoE9tYJ5ayPHSL=DYzMPrHFiwyCJg+zhEg2A@mail.gmail.com>
Subject: Re: [PATCH] wifi: realtek: rtw8822c: replace msleep() with fsleep()
 for DPK delays
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Chen Jung Ku <cjku@proton.me>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.56 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gapp-nthu-edu-tw.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[nthu.edu.tw : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:pkshih@realtek.com,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:cjku@proton.me,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER(0.00)[ku.loong@gapp.nthu.edu.tw,linux-wireless@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-37825-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[gapp-nthu-edu-tw.20251104.gappssmtp.com:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ku.loong@gapp.nthu.edu.tw,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,mail.gmail.com:mid,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3D16E689AFD

Ping-Ke Shih <pkshih@realtek.com> wrote:
>
> Oops. The subject prefix should be "wifi: rtw88: ..."
>
> I'll correct subject as below during getting merged:
>
> wifi: rtw88: 8822c: replace msleep() with fsleep() for DPK delays
>
>

Thank you for the review and for correcting the subject prefix !

Best regards,
Chen Jung Ku

