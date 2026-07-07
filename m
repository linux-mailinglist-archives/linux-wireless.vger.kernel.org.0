Return-Path: <linux-wireless+bounces-38765-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id fw3aAWkiTWqKvgEAu9opvQ
	(envelope-from <linux-wireless+bounces-38765-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Jul 2026 17:59:37 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AF1171D95F
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Jul 2026 17:59:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="Bs/v3vlG";
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38765-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38765-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7E3E930221DD
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Jul 2026 15:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDF0F32B10A;
	Tue,  7 Jul 2026 15:47:23 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E273264C8
	for <linux-wireless@vger.kernel.org>; Tue,  7 Jul 2026 15:47:22 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783439243; cv=pass; b=rOqG1nFF9KggbaGjhv7/R9oFz2ZF/zd0Wbfo8zkrQR4Y29RkyhBA52e1WYBvA1eDtgUYPX3lhBBB8oOFaE1TpSE/GYYSWQVyqXz1b+Mlilqvw8u4cVW4SvRRpR64sJJzdtKOIG51jg4hZXStFe7uVhEj7LsQWNYKmgxvzVyWdD0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783439243; c=relaxed/simple;
	bh=C7beHt04Po2pKdpDqjaujbHHdPkz47RZ4lpkmcTP92g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i7hOze/KfRy6XJTN3XTcEY6T9eW2GugYvjze0u+w8tt2REs73bPyhorTOYtxso2Vm3OvYNwjiqfLqR31LfFrn10ZPKC1kHGJNG1g8a8FZGltYofUEPkV6RUt20v1Tzrj09GQOyCVixvNcKOYLJ42khJGyZiHRObzekr5x8ErUkw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bs/v3vlG; arc=pass smtp.client-ip=209.85.128.177
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-80bb8287d99so55383767b3.1
        for <linux-wireless@vger.kernel.org>; Tue, 07 Jul 2026 08:47:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783439241; cv=none;
        d=google.com; s=arc-20260327;
        b=sXh03PdpegBpdZymGSYaD8sVqEjf97QezBvixR9Xa87Yts/0EfZz/NHqt7z2Z6ZDVi
         Da3UM6xKcr/fMLrcSl9qCovxW5CIZWtm4LTcA6fyS1FI1bL2BFK1NcIJG8m+YFhDhwnV
         WyOf3WEikWJVb89/eudAOGr2Nyzcb9zkQmVy1OR92ytMfMPeCBtvp1SHkyulBM6pD8RP
         3w5ZDuMsfrNUZWc31pQpZp69nnfPjSUi1rIsp8XVAuj88zbm2Tsg1sC7Un9LIvihqvYH
         Mhneh1U6QG985IUR+Mj4wiG7LyA/YkE3jxb9LwHRZl5puvlemHOwHnjVr4SrZxh/8Y9d
         lgEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=BtjXgaFwIpxqiNBLx7dSmYCZSK8klOTuRw8RGDy3Bww=;
        fh=xk47FdY2/WztT0MKAjWBYhSMOiqU0OLawrAEVp16mt0=;
        b=C1MrBGyKdB3lxhn9NbpyYUg3MxmQm/0mouimP5RnX+MOrsoSIXivBheCfHO74EnpiA
         5A7qJeu1eRrbhISR2TcEIRVxs/miiv/scjF0tozB/PlQ65m0zFW7GgCOs6MrUMKVnZmW
         eI4SQZJgLgG/gc5q2Ce8W4/KhBZ9LgoGyDenBAe7sHet2KSeXsWdqKDD/aM1e8JOZS6C
         r1wftTqHMOv36nkrtbhfTUgzq6G0BNqQQe8bUzGR8rZA9PckEMfDoBJecC34meGeMhr0
         XT83FDXOzE2wM9BJj3IDKR1u3mOhcXz/n83PRvXU3UzeVRaGVlnLv9dEnbfng0iYtZXt
         62cg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783439241; x=1784044041; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BtjXgaFwIpxqiNBLx7dSmYCZSK8klOTuRw8RGDy3Bww=;
        b=Bs/v3vlG2VfMc1TTThwIVi6yxNBT5CqKQ6FoZKpzvFCvlAJhYW7hTEL3QG5NSdQuGH
         vyJFSJmcj7Ig9l1R4ER69dBkmHVupyAZCin3QjYs5j4YVL7Y35AhnxP6y2KbYc+x3fFZ
         36V+vYE6zFvkh/J6vN8CmrWmi5DrmhGwahtMjri5NeSyIIquAssKeMlAFEZbMiGMin1N
         UyumiZ6hBqMg/J/IPbfj9E/EsZhdyzpbwgSSWpaHs9epS2GdWkxXIOnCKWTRR6u9NNkp
         v0h5Uyeb+MwwsH7l7Vb6UVAmRhVX1PWfUq+5ie4GrQbRSl8BN1+l7PLfcikGul2BgVls
         4jtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783439241; x=1784044041;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=BtjXgaFwIpxqiNBLx7dSmYCZSK8klOTuRw8RGDy3Bww=;
        b=CpWCpbJMfs9gDAeVdFUdA34fVE/Rq7CKJsAujUnm1eL/pi/RxtQKtdQY+4mmVGMmr6
         DaXYHUqcgWVN/LyoaA74QxY98txCETHYxsFUdA5Iye2qb9OO2ZddxQQDHajwXPcIioKd
         YYhaLbN1ASfS1NzT8m6PUBdcCEZDTzell+CzqRZpuvK9tfvJ0otvrRrfz4NiNvuPxce2
         aiU4prMtoxs7a5dU0VOECcw1cvgS3O6RLyon5jhXTq3mM/GL8SR8b90Q/OcLuHiwjLo4
         jAX4uomX1A+h0FTC40zEJrkLLuTs2nLn8M7sWjZtF1r05m+ZhHNVV5VaEWXXYxl+pdm0
         2I8w==
X-Forwarded-Encrypted: i=1; AHgh+RpViVGaS44I+dLV7zndZVh7dQGjgOxFwRVAx3oYD98bianaboNQoAu6wys1cXJXi9zhpQr3rN1N6Xu4UqTpDg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyU4+u7NwVSrY3aIqxULlOnmOItA/1p6hdHqCP6m8yBx2aalhOe
	2qIgP+T+ZvYEIctUcUttIc0AhGAz/813W3qMkqm7MQyMNfszDWio0YdsIucmTGsDBOM0GNoBuC7
	AZVwhhjPSeTgWVlaYCk9m/YmzpBobjFJfjudkWDIP90Y7
X-Gm-Gg: AfdE7clPn9byiN2frYBFd1mY6ezAbqYc3/XqMzC/8xIuXsPzZB64NTs7XWD91UP5u9P
	ojWJmCFgWz4Mit0hEphNyEtE5oJsCVu4BnfuNnQnVdaYlgU6hzMnMxx4g4OPfWxiJpgLCdSAx5V
	bvGaaTSDY+PbehPrMpZyt6/uOcgtdIcmrEkJGuZHej+I+PiklTo4qNm/u0+ctvheF/wy1BNDGJI
	6ML7p3uy8Z60Zar5HOA1XqgWHs1aGyvbN2CpPQxpQSbQaUIhm+tSB6fVdU39CAtpCJkNZXlPA8=
X-Received: by 2002:a05:690c:c04:b0:80d:e214:c2bc with SMTP id
 00721157ae682-81be36b4928mr40576047b3.35.1783439241244; Tue, 07 Jul 2026
 08:47:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260707134925.106972-1-zzzccc427@gmail.com> <d39f212a-5161-4d00-bc38-bcdc5fee2658@candelatech.com>
In-Reply-To: <d39f212a-5161-4d00-bc38-bcdc5fee2658@candelatech.com>
From: Cen Zhang <zzzccc427@gmail.com>
Date: Tue, 7 Jul 2026 23:47:09 +0800
X-Gm-Features: AVVi8CdB3fyflVgh_Vg3RjHtr-38pHCsfEFTYzRO2NyE_pRfXIHwjrgRRgANo5o
Message-ID: <CAFRLqsXHZ75ktX0gb3HbJHyPLHa_iFr=qA8Z-G0Lz1ZEfLQKjQ@mail.gmail.com>
Subject: Re: [PATCH] wifi: cfg80211: reinit wiphy work entries on runaway drain
To: Ben Greear <greearb@candelatech.com>
Cc: Johannes Berg <johannes@sipsolutions.net>, linux-wireless@vger.kernel.org, 
	baijiaju1990@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:greearb@candelatech.com,m:johannes@sipsolutions.net,m:linux-wireless@vger.kernel.org,m:baijiaju1990@gmail.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-38765-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[zzzccc427@gmail.com,linux-wireless@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[sipsolutions.net,vger.kernel.org,gmail.com];
	RCPT_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zzzccc427@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5AF1171D95F

Hi Ben,

Thanks for your review and comments.

> Even this likely leaves the system in a bad state since requested work
> items would be skipped.  Probably should also increase runaway_limit quite
> a bit as well (that has worked OK for me), maybe remove it entirely.

Fair. Hitting the guard still means pending work gets skipped; this patch only
avoids leaving those work entries with stale list links after the
existing drop path.

I was hesitant to remove the guard in the same change, because the
flush-all paths run under the wiphy mutex, and a work item that keeps
requeueing itself could otherwise keep flush, suspend, or unregister
stuck there. Raising the limit sounds less risky, but I would want a
concrete reason for the new value rather than picking one arbitrarily..

Best Regards,
Cen Zhang

