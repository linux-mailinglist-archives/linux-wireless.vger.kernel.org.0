Return-Path: <linux-wireless+bounces-14894-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F3609BBCDA
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Nov 2024 19:06:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 910F81C20BDC
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Nov 2024 18:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F78D1C9B68;
	Mon,  4 Nov 2024 18:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MVKp93oF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D02F9224F0
	for <linux-wireless@vger.kernel.org>; Mon,  4 Nov 2024 18:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730743613; cv=none; b=awoQJOsU2eZF79AHobldyqO/H8yaSHfbA9ojJmsNDZ0vnZKiL44SsA4BHWzEm8NM/SP9QWhLcPQo+5s83IbDObEEWs6tUTgpTt17rO7wV2n3IcjAJGT29lVbstvKNBIuIovj5owzVd4dKhv5TfDGJS++xHW77PY1UxjrGmt/lyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730743613; c=relaxed/simple;
	bh=f1LuNbWhHgohwcA9vB/DncE5CodJ8RZlb2iGhbl0WYs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rOxvurMSPfeZmFiCnJUoerbc8VamKy0C83ahH4p/faEU1tl/lTCxQkXwFt27pmA+MQh4l8zfK910OZqzQfUwgeOM3CArzg4EiOEW3++XI/F42VGFKLh1RPoN69YL4ka9O0tezejDfJildCVY6bVYfczprc+o7PiYzfsyEp5uXJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MVKp93oF; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4316cce103dso54665975e9.3
        for <linux-wireless@vger.kernel.org>; Mon, 04 Nov 2024 10:06:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730743610; x=1731348410; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=66XTrEb8XaLsaKj3AWJmhH0Y8WJaTZ1L7Zwc9s+LDGo=;
        b=MVKp93oFGTl35Ou8Wv3WkQm9uiiGoD8FvV8KHqy47I74BVQN7tbcLj9mI6jiIh+9I0
         p9pkgyWWW4NK42qr/95mx/KWuQ95HAwqpR0mz2wsJ3Pf4N1p4PDsy5FmQ5VMIMxKR+ip
         cdMCAtGhWiORKjYtrDpwEG2Pi+YETFfUNWJH6556//bN6ThQVIDtbaiXh6OUUGW8cLEM
         5nutSoo2omGfaRrwZvezv9q/EWBzDqcKTJq/pnW0zfH1RvW63OAiBOSC/IUbDA1a1gZ6
         sUdQYjptMhjvRfzt9iJoyjw2QEA3iNP975e9Yr3QhB+D5h8rjfI6PS4Qp5w0fzrnDCeC
         L+Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730743610; x=1731348410;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=66XTrEb8XaLsaKj3AWJmhH0Y8WJaTZ1L7Zwc9s+LDGo=;
        b=qgKik3oK3B9RQxHb7IlLKPEadgSdD631fQeXLV0jLX0N8gEwqFuYdY+LBlRIz/cFcW
         aieqernILHvyi4OBJEyjG4Y1VzG8db14d1pp53F0v+WDbRoYLU9SeWh9IWT5mdmo9gdm
         SNz95W9YnTfl0KfNWz7iKdg0qHCboxNAp6HCnM51cT41h0wBBBynxww8lPDdnyHPscTC
         dOLHf85lCaDyEXpmDEoEp6Z62u8ZBmneDSzdDs/JewGlj2TB5psemWG/DcSSY1oX5iep
         V2if6Kl2zy01b2uqtTTMoPCR/LySRv7rwNPLX/Xv8n+ABrmB62/6YYIU9HjAcFDeGJI9
         t/7Q==
X-Forwarded-Encrypted: i=1; AJvYcCWsPlwzigMSVGkvKSRnlOfsH3U50GoxOKsv+jt2D1pTGMD74tjlo55T4o+OuOHqN7/8WfkrQACB3lLKSau/lw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxVXU9jUv/6LG7bsxM8qWpApaBe2yAe0pUEU2cM/9+31Rqw/Oys
	nbtOGZ1mOmwXY272tgykWhfAG/fOKy33flpgdphYufrCZGJqjWdVN0rIxM/UsA==
X-Google-Smtp-Source: AGHT+IFp7IQDS2hXq6mWxig9ITdshgx9KZGNhtvynyA1yZU4S6SmADpBS/0Uu6xNlztEC4/gEjlquQ==
X-Received: by 2002:a05:600c:a07:b0:431:4b88:d407 with SMTP id 5b1f17b1804b1-432868a5b83mr126649945e9.5.1730743610212;
        Mon, 04 Nov 2024 10:06:50 -0800 (PST)
Received: from localhost (65.0.187.35.bc.googleusercontent.com. [35.187.0.65])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431bd9ca8eesm189508925e9.43.2024.11.04.10.06.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 10:06:49 -0800 (PST)
Date: Mon, 4 Nov 2024 18:06:46 +0000
From: Aleksei Vetrov <vvvvvv@google.com>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Johannes Berg <johannes@sipsolutions.net>, Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Dmitry Antipov <dmantipov@yandex.ru>,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] wifi: nl80211: fix bounds checker error in
 nl80211_parse_sched_scan
Message-ID: <ZykNNj30iMlB2KgZ@google.com>
References: <20241029-nl80211_parse_sched_scan-bounds-checker-fix-v2-1-c804b787341f@google.com>
 <ZyjyEl4kzFXz7tTB@google.com>
 <83ba4f8e-44bb-4cc4-bf59-3e4051a67a9e@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <83ba4f8e-44bb-4cc4-bf59-3e4051a67a9e@quicinc.com>

On Mon, Nov 04, 2024 at 09:10:15AM -0800, Jeff Johnson wrote:
> It has not slipped through the cracks, it is being tracked in patchwork:
> https://patchwork.kernel.org/project/linux-wireless/patch/20241029-nl80211_parse_sched_scan-bounds-checker-fix-v2-1-c804b787341f@google.com/

Today I learned of a new tool, thank you!

> The wireless maintainers have a lot of work and it can take weeks to process
> new patches.
> 
> Have patience,
> /jeff

The initial response on v1 was almost instant, so I was surprised that
v2 took much more time. However that response was from linux-hardening
guys and I didn't took in account that now I need the maintainer
response that will take much more time.

Thank you again for taking your time to look into my patch!
--
Aleksei Vetrov

