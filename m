Return-Path: <linux-wireless+bounces-9240-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AA0690E79B
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Jun 2024 11:57:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 894711C21882
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Jun 2024 09:57:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3D0C12FF86;
	Wed, 19 Jun 2024 09:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bSumNmua"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C9C381720
	for <linux-wireless@vger.kernel.org>; Wed, 19 Jun 2024 09:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718791000; cv=none; b=d+pt10LabId+C+cwueo6SrdCdEwAtmrsWBQLmNTpy7xetpegLansQczJA0TOh26XbZpqOnL1M0JYEmYAPkWqvvHVKZsCVe0GAWgmCWOGAt7QMgHL3nXmEBm/jyyguQlVsXk6aE20t+NemRbJq6ay0Ne3Ok+Vku1BzTYNyZPIIto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718791000; c=relaxed/simple;
	bh=U069fedxP3fiUdw/neBJ4u6RIFjsO29klu0fvtBvX6E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eWeRLVZ6jBjh3geDwRsvFwTaUAUNtor0I5TtiaKisomJmg4N52R40Kv1f80VNile5tSxGF/Q0aCSB6nmatV7mLkSwdunLIZpK2w9gAOkH0TXmq5ChdCD742m9Hlltx8j73JwbyOplBoVlQ5YRwNwuENPhggN312UdPZ4b6c5CLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bSumNmua; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-57d119fddd9so3491a12.1
        for <linux-wireless@vger.kernel.org>; Wed, 19 Jun 2024 02:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718790997; x=1719395797; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U069fedxP3fiUdw/neBJ4u6RIFjsO29klu0fvtBvX6E=;
        b=bSumNmuahOlESGvzQSb7QchTJhJGJRqnAsMdwYB2vO9EK5MDt5/MseGyWk/0cP2yel
         2JA5lAh8YzfwU1oIAlB1JuILJIMWj+CH+VW6faT7NUqZLmba3gtEKRFrbL+Kp7Y/ETrD
         wQhK5ihf1CODAveHDjmhXE96JLEs1te+G5v/a5FDjDuwz5pvrQrRcNFk1rW/DnJwxS78
         1jRg7iCdSA1MkjGcVCklS3IOQMMmKJvqKUnp5asfu4cwsmt1oFEw7wDLwRbTUsU1Dfil
         xFnwLaUX84cl2i6Nt1SOZZTO++Rq4EoeK7evy1BbV5pS9kqJ3GgpTUWRjncwtaxF0gkM
         mnhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718790997; x=1719395797;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U069fedxP3fiUdw/neBJ4u6RIFjsO29klu0fvtBvX6E=;
        b=EZrXt79CKnEPucsuBxjy/+B9Yz4mVQGXGJVyj0mqFeamXXGQJDgTEObsnnZKiw/nAS
         DVtD5msdsDt+7Id2FU/GYpCQWmd33j3eOko2qG9SODbSVsp9H6mF3D2t4zHAWx7O9BAF
         MGd7SZfCh94p0zxi3DtkRi+guYfjTc+DPpR12DWqIT/FqoFFzWMgv1YsOdK29bRLjFSo
         VtcywhZ3xLrbjX/yEY0sP+GcdhvuUwsigATarD4vtOBweobura+wmjvUJxGbXbgrmtfi
         4ErHQ70gQRzJFBUQVE+Gu/C27fcPdsmlXSnk81mojAFVx1koqfNwts3iUkOQF1gOX8s/
         ux4g==
X-Forwarded-Encrypted: i=1; AJvYcCU7WbahmflXpK7r1eyPFcMRz+j2KNb7zq5YMSMHl4vl7LMm29JEKC5rwgA403MdZGtiEmWHWbtPzprMUJGHBuhvVsbzGnCoSr5w2Gp9t4A=
X-Gm-Message-State: AOJu0YwuHw37gKz+yYDdzi4WgGE41vgHaVqrgeR6uI1fTwNLeR61PEY0
	/kAHtZ3Gl+z9Cmgj8RzIXFRfsjHGOJhbdjes5DmiSDhLPGo9nBY5PK/odruAwfWUBTRIOkJmZX4
	xrnbF0xIMnb1VBEn88evc1gZCjZWslvyHBWZ2
X-Google-Smtp-Source: AGHT+IGF8IPjq9R9XtjwrL4FUJ544IilKN39MOW5W8Ji606nsm71k9RdKIAjT3+JGOWkaCCZ3NK2ufxFEqAKVzI+Jx8=
X-Received: by 2002:a05:6402:26c5:b0:57c:cfa9:837b with SMTP id
 4fb4d7f45d1cf-57d0ce92e3amr168655a12.0.1718790996922; Wed, 19 Jun 2024
 02:56:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240615160800.250667-1-edumazet@google.com> <87zfrjk8wi.fsf@kernel.org>
 <CANn89iJ2SHPGVM1mxx4x4WU5X0CcVmmBhSD-FZS5fPs_Z1D01A@mail.gmail.com> <87sex9l0oc.fsf@kernel.org>
In-Reply-To: <87sex9l0oc.fsf@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 19 Jun 2024 11:56:24 +0200
Message-ID: <CANn89iLK2o0_dyGt+OpkCjunzzTGQDFEar3vBDiwZFz9cmC0bw@mail.gmail.com>
Subject: Re: [PATCH net] wifi: cfg80211: restrict NL80211_ATTR_TXQ_QUANTUM values
To: Kalle Valo <kvalo@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Johannes Berg <johannes@sipsolutions.net>, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@toke.dk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 19, 2024 at 11:52=E2=80=AFAM Kalle Valo <kvalo@kernel.org> wrot=
e:
>

> Just the tag in subject claims it's for the net tree:
>
> Subject: [PATCH net] ...
>
> Not a big deal, actually happens quite often. I just usually send a
> reply to remind the net maintainers not take the patch :)
>

I see, thanks. My scripts are mainly targeting net trees, that is why
we see net there :)

