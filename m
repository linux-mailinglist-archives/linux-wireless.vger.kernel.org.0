Return-Path: <linux-wireless+bounces-34115-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yJRsJh5OyGmSjwUAu9opvQ
	(envelope-from <linux-wireless+bounces-34115-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 28 Mar 2026 22:54:38 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 30BCA350144
	for <lists+linux-wireless@lfdr.de>; Sat, 28 Mar 2026 22:54:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2821D30098A1
	for <lists+linux-wireless@lfdr.de>; Sat, 28 Mar 2026 21:54:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D552F346A01;
	Sat, 28 Mar 2026 21:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EoZWo0wP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 939B37262F
	for <linux-wireless@vger.kernel.org>; Sat, 28 Mar 2026 21:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774734875; cv=pass; b=jBlDqYsETAYwH2cDyLLzM0W4IXey/aS4jw9bAIi9rwB0Wrd3zqla4RS5lMOJYgb0da135YfruTtpyERjq0MhodWg6rDstFadcP+ZznJ6e4lr4/N1OBvQbUU+fuWKa1bkoo9qmTUS4XquUugpHl+1SBBtVxvfB9gCPLBH+Q7IlQs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774734875; c=relaxed/simple;
	bh=agm4DlKPrOhQQVzbueYrQ9DTR/5kHYnU/9EvEGYk1m8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FvESC/Qeq7WR4nN3SrsG9cGnowdaFWquh7NA5c83EfJf/JcNCfpURLG6+2XURRgKmDxE/ZogTPOrUQKg2MaMqu9BAu5FoEGDJfWgikvvHHvX0cx2VmIPX+P71VA/oKuqBr5ImTXaSFeCWFeOFr5apW8lnV8T+/TjizCVl0szbjc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EoZWo0wP; arc=pass smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-46704fbf62dso2041079b6e.1
        for <linux-wireless@vger.kernel.org>; Sat, 28 Mar 2026 14:54:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774734873; cv=none;
        d=google.com; s=arc-20240605;
        b=HyypgeD51kfDi3M6ndDvOIoNl5PzDEk/7S0hT5YsVTMAFLyQS0qvy1K4KbiXp/PIIl
         f++UexIKcKX6abRo5Rig+nh0JmQNEE8ZvrfK7m16ewBe9nGp3yjxF+OM5iagGO3qOYLZ
         o62fNsH2pZH+MeG3OsZuO2fhewUhs5fOJw3SjREH9antKY5J0Ugqt/+EQoC7x3UkrvUU
         rJRKFzWfLXuYaiQ7TQGap2OBTjlSwHmfE6HhPHF+12Y+Hhj9EB9E4ZIEpws4odncDE6J
         UisACS9+VqiOXL7jUNCsk43VbrBaFsDVYgyV5yrcdKhBq/DbFefidGKOfQDIY2j2f2a3
         ou0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=douIUZIHwKW0S9KCSITiu5EiPn+Cka6iEY+X9k42rKc=;
        fh=SU94mY86giBeRs0gTQaX6JpnA9Mlx25RzwJLzO9ny8I=;
        b=AvU7B7Nk30OsRPkMoFWESxK2Wy0MUZyegXGjLaHr9wxliYUox9Fhlw4ufe478TvIVG
         lbUE4In4rK55+bpEpndSeLW+WB5JBdxdz6ZFbgme5zPSlWbOSbwam/rWtyqIkj0NBVRE
         KWMT8Hp1f7qYIKf0XwZ8yJRYR71dAYqR/FPVl+sjRh/ryjCV+l0Jp2fzlUZ47BoX+U/P
         BYow/2fYhFgudImkjtO2X8x8dMUlOUB+kXvPAsxS2ytEI18utK2csUo7F3u0gLCYAOqp
         y5LhTwObsKe4jzPl3DM0KeMYYgVYPE7BrNN0pYAtwHIpMRGZTWWgc6dEvD4lLiwYYGRY
         0OBg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774734873; x=1775339673; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=douIUZIHwKW0S9KCSITiu5EiPn+Cka6iEY+X9k42rKc=;
        b=EoZWo0wPhW8T4cgdiMKcBEczkwzolX+6nbXaP8bo23gctx7U4b+pNx6YI5xhAHrf6s
         znNRTzoP70fUthMBvo8t/6P1nG6dCk94IWuInNCINnTLXk7bT5vksRbUBNOSO4CF2uCG
         zfVrJeImtBgD5XQ3CeOfF7VOisEVl8EM5q4/iN831Zv1ZuFq11rutXGB5h2fI5lysvDD
         OpNgySSHg65U3pLkcHXa/VbEB5cIoQ8VtmLTL8avNU14YH5fkTFd0SHkT20rDBze6Wwa
         FOQ5cGF4CqLDcvcoN48SkZtbAe0nqwWnbVPK2UE1XI+mVS1PlurmNw5PZ8TAbetZl7mY
         NYuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774734873; x=1775339673;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=douIUZIHwKW0S9KCSITiu5EiPn+Cka6iEY+X9k42rKc=;
        b=VBNTh3kqvPoOvfKtptxKx7Y7Bp1zGj7mbRpkSDv8mRb7jeNHrk3aqpuLN27JYHxHLS
         P9XOR/Adkvg7ds8pwnu/+WgQGCqvvinyFi/7un5/FHkrsbYHBptfw2GBfuD8GTAA2F6i
         PwlWYLJurKxR/A+da+gIiHyDWxmVf5nbwRZRMs0OW+JZPqZJ+8A7eprQzur1xhuiY3dp
         AmG6KIU3iDJHgQIc6fLcGWb4ayuIywykeZH2Elhf1fX7wWYjyRIXW60br0vjUk2BXJsK
         Q0ey/V/w1vQ5MKhoMw59Z90f237oSDxBGid4mtQnPaZw7ZuUiLUaBL/hsnAKXc9X6/QH
         YQmw==
X-Forwarded-Encrypted: i=1; AJvYcCXB8JjrQJLzXlIib3rEOkGe3+RYbtMacrtXOLUBeTfzhm2gM6hvztaCxCEBHCe0KQIZK4Yi7K2G9UN9V1L33Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YyoIsqQ+dOlZfHa9IsHqkdC294fO9WMlS0oLlgkqpFcB59h9i/S
	q+9pp3yuyU+v0wh2y3iIg6OmsdovpU18aAo73va6k7rNyMHJ3BiQ6L9SDU0hYHfXamj3Pqh7hwd
	m0x7pMthmo4V0I+eCqgL1cuv7obiv5y0=
X-Gm-Gg: ATEYQzy8H5ak52qDqJQBJAmdqLNmDfE8u8A85phGSH5/mNj77NeG0jWKjT+lxsQge0O
	lfKfkXAPZMJwd4SQpkIy05VHbe88+leLplAvkcAHrm2iUr7ZrSfwEE94XFaXsvOIy5HxaGLF5LV
	MPG6K+zxMpPgSxDYAuDrvWGF9w81LrT09273JQSuEnkrREcD0qZI6QpxGVIBFJ4J7b0JoTKc97+
	rH1S+1a7P5rCmZYW76bnkHNoSZ83yPRAvTpX1HeSk83uHGby1piBhxy84TfaJGr93GAL0uugCWU
	wuGSO+q6
X-Received: by 2002:a05:6808:6f92:b0:467:32c1:ad01 with SMTP id
 5614622812f47-46a8a639de3mr3780775b6e.50.1774734873484; Sat, 28 Mar 2026
 14:54:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALdGYqSQ1Ko2TTBhUizMu_FvLMUAuQfFrVwS10n_C-LSQJQQkQ@mail.gmail.com>
 <CALdGYqQ3tS_aQpmf7xLkaCG9W55ATQXP=tnRNdjBAG8waqg8yA@mail.gmail.com>
 <dbe78a09fafe4a0ab16cd691049896a8@realtek.com> <CALdGYqQ3JQgFvvjiqh-ck8UqUQpAoJ0zeUzEL4i4Un8qPmqxJA@mail.gmail.com>
 <CALdGYqQuS5EOWCaeimr6PY758feF-DPo5i3XFwoQ8ewf4xnm7A@mail.gmail.com>
 <b231d63665334ac786e808610fe4a1e9@realtek.com> <CALdGYqSd61wxNrPDui+m-S+Na_is-RM18-=L6xm-Jf4QQ+-DOg@mail.gmail.com>
 <a8e187e1b40e4a35bbeb3bc3a3d21821@realtek.com> <CALdGYqRPcDRctCpNSJFatXvqMKLFiiRGXZoQa3KJwfwutHJEwA@mail.gmail.com>
 <ba9790526e4e42c386642a05fcbc2f34@realtek.com> <CALdGYqQ5U2USCqVEixoDda1Xd2ugBakh1K1QkaKAU7HPSTTNWg@mail.gmail.com>
 <CALdGYqQ_RCOwa2J-GsEyCxCQ4bztyxSzbc+6eYNesBSaY3Nt-w@mail.gmail.com>
 <da30a61b-dad0-48ff-a283-3dd8e9bdf91d@gmail.com> <CALdGYqS53=MmG4yCLwgV+RJAZ=U8Aqi8QQZFZ5oFMernhSyxTg@mail.gmail.com>
 <5eb90d6d-e590-4c9e-91c8-1ba315f45304@gmail.com> <CALdGYqRkX8=XMOePeauxvSTDZFLEYyJZKCtoxCzqaNwdO6BNnw@mail.gmail.com>
 <a5ea6373-8c07-4fcd-95fc-d87ce6aef6d5@gmail.com> <CALdGYqTjSpAjPR7akMowhkQKVJsZmr4G47g6s+y4guFRMpYS2Q@mail.gmail.com>
 <CALdGYqSC3WXLCKGSmRh4g9SJkegZN4qGvpiVMBK_U+qRqpE8og@mail.gmail.com>
In-Reply-To: <CALdGYqSC3WXLCKGSmRh4g9SJkegZN4qGvpiVMBK_U+qRqpE8og@mail.gmail.com>
From: LB F <goainwo@gmail.com>
Date: Sat, 28 Mar 2026 23:53:57 +0200
X-Gm-Features: AQROBzDiolyA9wr6KQD0HAk4jkrf5qW4nIE8Svw-Qw_K9Kb3qaz80ACEoNA-Sv4
Message-ID: <CALdGYqSXoDp36gPD3D3b=-JXHXZCkmMcvE2K2jWwdNyg=JYfpg@mail.gmail.com>
Subject: Re: [BUG] wifi: rtw88: Hard system freeze on RTL8821CE when
 power_save is enabled (LPS/ASPM conflict)
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Cc: Ping-Ke Shih <pkshih@realtek.com>, 
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-34115-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[goainwo@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[]
X-Rspamd-Queue-Id: 30BCA350144
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Bitterblue, Ping-Ke,

Apologies =E2=80=94 I made errors in the hex dump analysis from my
previous message. Corrections:

  pkt_len:     I wrote 0x588 (1416), correct is 0x1588 (5512).
  drv_info_sz: I wrote 5, correct is 1 (raw) -> *8 =3D 8.
  macid:       81 (I didn't mention this, but it also confirms
               corruption =E2=80=94 it should be 0 or 1).

The is_c2h =3D 0 part was correct for that particular frame.

Sorry for the confusion. I should have verified the bit field
extraction more carefully before sending. Please disregard my
specific calculations and rely on your own analysis =E2=80=94 you
clearly have a much better understanding of the descriptor
layout than I do.

I remain happy to test any patches.

Best regards,
Oleksandr Havrylov

