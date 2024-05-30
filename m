Return-Path: <linux-wireless+bounces-8316-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 928118D4E0A
	for <lists+linux-wireless@lfdr.de>; Thu, 30 May 2024 16:34:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28407281A8C
	for <lists+linux-wireless@lfdr.de>; Thu, 30 May 2024 14:34:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A8B01E4AD;
	Thu, 30 May 2024 14:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LLae4bLS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 324B317C202;
	Thu, 30 May 2024 14:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717079645; cv=none; b=SQlzvFUchoAMxHmMRXrSR/tBOLKhnCXDjMod+wIgmlJbcmUTFiuHosu0f/A2QdT4igj4UiLhdIWL3vIhJS0qb2P6RMzh+aayefKH1e45ZPbeZsk4cgsOtSLehvIQ993vGqnn3d5M/f0UN0BVe44LSONbUj9dIaV6e5+2NOyqfpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717079645; c=relaxed/simple;
	bh=s8mucTal+7mxWZj/2n+kTWV7jjqo0lfn15CSNyIWMQU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e/2PwhxmY9sUp7ppQl+5Aua4JyDqopeOhjMYsUeaAPIv2PrkXpKVvIGc9qHlOr7vXL8dD3TveN3JlMbZKzfUO9VWuQOeChjQMBai79thCuHlhKMi44CxL66CAw+8mHBKm/USf5+bHa8RXBxYv1ZlugzV22ZapPaO5/R63+Na3b4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LLae4bLS; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-dfa4ad7f6dfso868795276.1;
        Thu, 30 May 2024 07:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717079643; x=1717684443; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=s8mucTal+7mxWZj/2n+kTWV7jjqo0lfn15CSNyIWMQU=;
        b=LLae4bLSZrQKD2iKl2BiZPQN1aZPJqhDEIxWxu70ACwVIqIWKq6ujn5qmHQfpEUnKX
         sGDAlC60tcgHurV2cpEe4jDeVv7n6eBJm6AG1v6oPZleI4d1WeMcfDy6hQXqUYNOVSsK
         cfD6Q73gb9STiyuycC5jfbw8Sml0fmdkshrJ57qw73SNtW8NEd7eE13jUt9DeMjsobqJ
         W1UlVYH+ldiD4z/bTvQoEqALVl5yx4xkYD+jfI4qxW32ff7v/IDLV4TGyczvwRrFwUML
         XtD8Cfr6Fi5hJZNTUWD9c1slBrj5Qgg2pLXJQqsorUi7Mf8P/132Aj4msuAyzZ6FjWvl
         5Dqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717079643; x=1717684443;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s8mucTal+7mxWZj/2n+kTWV7jjqo0lfn15CSNyIWMQU=;
        b=iCvTjIuX40bWXeGT13vEkkRdMf5j9moKJnTUmcOxB/MjLAs62p7GiW2wNCu/Gb+d6p
         kJmNLJqFI8dZX87vY1wSrupRyPoTZ1gAjVtf2RJtwNy/T4+e2TcrIaMmCUiluQnX72aX
         mEf5vM6NOF72Tez21ifsPSxpymOlah4YnR5mfb8DEdjXITkzg7iWJSbCaW5EawlZr4Ps
         SRptzkNAavhUZHpccsKptBwPLjgBGeJVKv2fnxE6xK0K2KUsuZ1NhnfuKP6HTgW9hs1Q
         Hp3nMuyjSKirrUMoL4xJbiZucKW84/ZsdOy6eXBBZOy/eGhTQPmTuV6ba/zGPiQayD9h
         fxjg==
X-Forwarded-Encrypted: i=1; AJvYcCWAs9vJYzDzvJAY9b/qbaqP40l7AqhDGao9eKKyDWlxrTbrCP9F0UdRZZF753AY0rqC9BpYfuOeN+xrmnq4we27Wun/pT3my2+itlA9uIoDB6273ZK13oSBjYnNFZuSYMoH5HE8qFg/mAJAfu4=
X-Gm-Message-State: AOJu0YxtcVVjskywtdLRfr87lMM77WXeSEK1/6qFKkrQYN/zXXZJUZ+U
	AUME9adm7AS1vGphmvPgd8v0hWqh6jsvpN+zvqhCdQx1bJ0HHja/UU8/3vWgE8fzS9q4TnXM6wS
	SVqebgDKW+NsJ2fK2N1UWFcZ/Hw==
X-Google-Smtp-Source: AGHT+IH1+lnHEQvHNTpCk4g1n3rMoXnDu8bTP/csyPUE5UnH2FmDuqVwGY9sq+kDGBDBiH5RCuTrPOILlP9jMChVO/Q=
X-Received: by 2002:a25:ac0e:0:b0:dfa:57e4:2df8 with SMTP id
 3f1490d57ef6-dfa5a5e77ffmr2589681276.23.1717079643016; Thu, 30 May 2024
 07:34:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <13e848c1544245e6aef4b89c3f38daf0@realtek.com> <20240528110246.477321-1-marcin.slusarz@gmail.com>
 <801bd77995184b1fa35bf4a32ab3a036@realtek.com>
In-Reply-To: <801bd77995184b1fa35bf4a32ab3a036@realtek.com>
From: Tim K <tpkuester@gmail.com>
Date: Thu, 30 May 2024 10:33:52 -0400
Message-ID: <CA+shoWSt44WxS6s=z8wR3AMRYFj9tuxWdkwVLG5i2mU34jn4Xw@mail.gmail.com>
Subject: Re: [PATCH] wifi: rtw88: schedule rx work after everything is set up
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: =?UTF-8?Q?Marcin_=C5=9Alusarz?= <marcin.slusarz@gmail.com>, 
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, =?UTF-8?Q?Marcin_=C5=9Alusarz?= <mslusarz@renau.com>, 
	Larry Finger <Larry.Finger@lwfinger.net>, Kalle Valo <kvalo@kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

> I gave this suggestions too early, since we have not gotten test result from Tim.
> I will change them to "Link:" if no ACK from Tim while merging.

Hey all, thanks for reaching out!

Sadly I'm not able to work on this project right now, but I've
forwarded this email to a few colleagues to bring them in the loop.
Did you have a timeline you were looking at to close this off?

- Tim

