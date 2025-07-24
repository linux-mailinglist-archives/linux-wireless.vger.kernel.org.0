Return-Path: <linux-wireless+bounces-25979-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95AA4B10239
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Jul 2025 09:49:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0612CAC332A
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Jul 2025 07:48:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3852D265CBB;
	Thu, 24 Jul 2025 07:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EUpsX3lg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CDE31C6FF5;
	Thu, 24 Jul 2025 07:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753343350; cv=none; b=hMS6SmsF7FT2UTAUJz89tdZJmKjcN//LykO2DsvBp+omzye5oVpVufJN6JXNUXv3qwSRuQUzB2Nd7g2ldmfvqgQTdvR4SEMjUXzmMEKrxHJN92gTZL35m11WQ3DoLowC+QfqlA62ILjGDpUMah0dnL5TJsHWw5b/YEv81YXSnYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753343350; c=relaxed/simple;
	bh=d/8QVK8y6ws/QbHuiFBL8hVTd/dAilTt+zbJtKU4EAs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EXBe8h5ECnICLEwSB2S5Xt1V6mQDdJz0orhonxx7rN12FYsR+764uguu2gW30gCqsw5eBLwOPAqWck0r7vQo974ENlDM8wjUvUfUAOPU7W9MrlRgJtoaR7yxpEniAi6O6beF4vEKpgsnGlI8zWJ/UJDwOOvQXbMcgeBWBfYITFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EUpsX3lg; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e8986a25cbfso441925276.0;
        Thu, 24 Jul 2025 00:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753343347; x=1753948147; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d/8QVK8y6ws/QbHuiFBL8hVTd/dAilTt+zbJtKU4EAs=;
        b=EUpsX3lgpFwfN+tE2he4V6QBkcK9dNsWjULujyejqFat8p7v6rCg3aLmpbq/bzSeLg
         nWzNNLdiZor2BVR78EDyrAP+10etS7nhUVAZKjb7U6Xf4+38REcobeK7ZGJP5yT5xDTj
         CAMS3/DZESFJ7/tmBhg+1CxUt5xsCWSIxbtcrIJHhmNWEc1Fud0NPAwsyjD8AZdiWojP
         Y2ZLOvb/ILl9TCjR2mwSypkbE7YbsEbisjrQXTXxOwWTcn0CgD3Z+fA5hzDM6QPFzRhm
         t+v1/z9JBjb+pMU5cdj3blGk5vpK/a0UhXY5rmteVwADjJErSTWWQ4TJhmKScO7cWOn+
         NtvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753343347; x=1753948147;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d/8QVK8y6ws/QbHuiFBL8hVTd/dAilTt+zbJtKU4EAs=;
        b=b+w5LNEfMM4kHcjgswN+hvqTchrRtvUyNuiGYZVh33WDHhSStGjZIrlRSbXo4cl4bo
         vWLPClqIYbeWcnZ99C1uJkUV/AKimZVmslj8qdfHldtTgne4hTcxMA8TOPYZ9gBqonob
         xque4KvEBsGUwxfMWzpXNzk2W7+bgFyLeZBxa2EcikpNOMRUn6iZ9y9HrjGlM/4bba+L
         OFsZD/ho/R+mr2aKJpHP6sXXKydJUaCHKxq/ZE2lXspN0YKM+IS6+WsQK3DXzU2/SHHJ
         UXnyFT6A69TGc2pIPOFhyHn0iD9rCvoeqQjsa4mYmw5ICNZdjWGIgfncUNL5U+9lJkYg
         chJw==
X-Forwarded-Encrypted: i=1; AJvYcCUKrEDrs/caDHuG4fBzvBhFaxko/abigq4AT8KuNlTWmMzTiCfsN/ReF7dMpni52VVR1RZ1TOM21tuqCIyrsw==@vger.kernel.org, AJvYcCVvyCYbrUDdAkTWZp6p5yLTNmT2ub+tteMPYdsGfBsMsWpbM28q5gyo1Y/4zJbwpgU0I46f1/kH@vger.kernel.org
X-Gm-Message-State: AOJu0YwjgA2+49XLVvYtGc+y7rX0ACBH3txntDyDcs1/Cw1fNzIb5YbX
	+u0vSNiLXThLvP15p06AnWamj9piwMsCXpKsWuJM2xxlHJITQgZVe0EKrgcDeTPNAE/b0k9BoY5
	iYpgImJEf5TBK/BS6ZsjlMYai93Jm2ko=
X-Gm-Gg: ASbGncutJvVvipaEBF1dXJtJxvVTfr9AEGAWoH2G2T7S2XGAQj/AkX9ZDhTZ5WDHoG4
	RV3DxbmaOMtFRbXy2vx9Wisv18Iz7pG9j8GERREKTSgUo3qnD5uCZT/4QooGRUr/a87umUO67Dv
	M3CMgXpJXv/bOCt0gZa2OfvDKri1J6AYsl9qJ7/vvNb3nyItVfzG/kPQfEZTYXKek/TJi+8lMGO
	sceGnar
X-Google-Smtp-Source: AGHT+IH7A4sB9RjOrAs7qrdWDTw5qFH4C3xm7jLLxKBplQo6vBecYXyV1xeaYMiKq9tnqtcJInBRTdVLgmoBF+xv2UY=
X-Received: by 2002:a05:6902:18d6:b0:e89:83ee:3bf with SMTP id
 3f1490d57ef6-e8dc5862cc7mr7840966276.13.1753343347605; Thu, 24 Jul 2025
 00:49:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250724071555.442634-2-moonhee.lee.ca@gmail.com> <b81013d8f7cccb19ab126aebc7bc442c641d0f4a.camel@sipsolutions.net>
In-Reply-To: <b81013d8f7cccb19ab126aebc7bc442c641d0f4a.camel@sipsolutions.net>
From: Moon Hee Lee <moonhee.lee.ca@gmail.com>
Date: Thu, 24 Jul 2025 00:48:56 -0700
X-Gm-Features: Ac12FXxmJH-eMjOV40LUbD_GpkxkzA2LCDE6kmfZUjiuahwQV2PQa_PqdwVCFZA
Message-ID: <CAF3JpA5vCOK72Ojy4FTa_MVGz=yYnJ5=vd8x6prMiC7UxBGWuQ@mail.gmail.com>
Subject: Re: [PATCH wireless-next] wifi: mac80211: fix use-after-free risk in
 sta debugfs removal
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	linux-kernel-mentees@lists.linux.dev, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, 
	syzbot+d6ccd49ae046542a0641@syzkaller.appspotmail.com, 
	skhan@linuxfoundation.org, david.hunter.linux@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 24, 2025 at 12:18=E2=80=AFAM Johannes Berg
<johannes@sipsolutions.net> wrote:
> Maybe so, but it really looks like a bandaid?! Why are we trying to
> remove it twice in the first place?

Thanks, Johannes. I agree this patch is only defensive and does not
address the root cause.

I am currently tracing the sta_info_destroy flow to determine whether
this is caused by a duplicate free or an unsynchronized access to
sta->debugfs_dir. If the race is confirmed, I will follow up with a
more complete fix that properly handles the lifecycle.

