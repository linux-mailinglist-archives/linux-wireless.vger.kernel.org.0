Return-Path: <linux-wireless+bounces-9467-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC080913CA7
	for <lists+linux-wireless@lfdr.de>; Sun, 23 Jun 2024 18:15:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 759651F22720
	for <lists+linux-wireless@lfdr.de>; Sun, 23 Jun 2024 16:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24960BA41;
	Sun, 23 Jun 2024 16:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nSosmcif"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 812C32904
	for <linux-wireless@vger.kernel.org>; Sun, 23 Jun 2024 16:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719159322; cv=none; b=Enw/v/5bgi9S/CT9UdXfgh3NbSVv7p34JOqJH8+eusuZTixmMhh9bJz9WuIWCPwLhUCZRLKskqDAOF4EWhVr5UZZkCLZeW1onHNkOVpc9AZo+cr82DP6CC4dpq4nvNz9ZcoTs2I4j4HhBUwnkIssLssbmBq9RW3OrvvVrTfhPaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719159322; c=relaxed/simple;
	bh=6kCaO/LmdVGbxRrfa8VHrVY1Rdv+4GHyGNjHEigzqoY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=emmTbD3gUoFz96Zcm7/RIY4ofHXs1kJPBFNp+qdx8qpSXnQ5Fx8ys7WDP61oG3hOtxGAisbmQ8C1LWeSZsBya8/4hIHW8vxDQIe3Cpx/HOAsHx1pyFgWJVgmW+9B8YhShCM/RKLtzlEEwkP0kjCPK3awS+yi+IqcBDbEZM1E5e0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nSosmcif; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-52c7f7fdd24so4139609e87.1
        for <linux-wireless@vger.kernel.org>; Sun, 23 Jun 2024 09:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719159318; x=1719764118; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6kCaO/LmdVGbxRrfa8VHrVY1Rdv+4GHyGNjHEigzqoY=;
        b=nSosmcifLqn4q+ot3UIanG3+sqzgIXS+FC4UHA22l6abBniLtMZSJbm0cjRclD4x4a
         23/e7Glley9ZIGY4PH7/uAZ6tsmjX+x1oIyMm2YlKUIL+EGwGf0Y0j7ymKcyPsRt7hTw
         HszmkWYfpLiHAG7hSTJM+ITb3IOyV3W4zJ5mcVrTALo8Wp0LTqDYIvlGcZXwn63QhOS6
         no3UYRsMoj7J75QcffaLHRwGrgJ7YwxUqiHxuVbu86Jr9pBwE3V8sLJyMeR8T+GvxZlZ
         p6unuP9c1f05Jiky0UZYhlZJGAU3+JrT7xP9mXT2ndsEJxumf7JNCBgiecbqUmqusslY
         oJUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719159318; x=1719764118;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6kCaO/LmdVGbxRrfa8VHrVY1Rdv+4GHyGNjHEigzqoY=;
        b=Fk6RrNOmg48wu3VpW+iwHQKvSH+IY2ml9lv2xg7UnQndNVeRV2z8n1znfMwC/CsmDi
         mY+bQIeMSGKK6Lwvvd5FMZOBsyI7J7cG/4+S8kUkC5FeixsYt+EF/CKMUzLpJ78x0Apm
         5HmMoXzZLejZ8LZ6mVhUMEYp1rJ7wv5h7mhByPM75C2yTvN5THAu+7wnWYUJ7bywEMBK
         G23ap7VoHBlPZx/vdoHrzLNhzmz8OWsF4GTf/+QF2NVJQvVDKB32RIj3g8K8RyAOKudX
         0WxjlKJFLHXaYGb4UQoeAnp/KMMaXAZ1WwedC5ondKIL3AmO6RhRAJto0AWhGZgxwj7S
         +OMg==
X-Gm-Message-State: AOJu0YzDYnf4XoNj83qsNk9sxLmiWc7ncC7fwGdHOiu1AT+kdjMIMsHU
	aGBIuTwh5LnOCwDGB88yJOUcZ7nLqI6ORRKUHpwjgbwg4/pJbJFX5fW2Q7XFEw9ndlVwR3bd5ZL
	D24hAKoijffoWVy53wOfJE49D6hKPPQzJ
X-Google-Smtp-Source: AGHT+IGayXYYwi3bhK/KErmgjgcjdurvWOBaZFGYVQc8NNr//HZmr0gBCuMc59B1dWQkkCF9NXfUfSOm8T5mFIKEq48=
X-Received: by 2002:a19:ca1d:0:b0:52c:850b:cfc6 with SMTP id
 2adb3069b0e04-52ce183b0d2mr1279111e87.38.1719159318277; Sun, 23 Jun 2024
 09:15:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <77997185-86a6-41c5-af7a-74e4e9064437@lwfinger.net>
In-Reply-To: <77997185-86a6-41c5-af7a-74e4e9064437@lwfinger.net>
From: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Date: Sun, 23 Jun 2024 18:15:06 +0200
Message-ID: <CACna6rzBfexn=UbDhD+Pev5nAOJ+SAQmu_yHuaq+eRB1KVty_A@mail.gmail.com>
Subject: Re: Larry Finger
To: Denise Finger <Dwanderer@lwfinger.net>
Cc: linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

23 cze 2024 o 01:02 Denise Finger <Dwanderer@lwfinger.net> napisa=C5=82(a):
> This is to notify you that Larry Finger, one of your developers, passed
> away on June 21st.

I'm really sorry to hear that. Larry had been contributing to Linux
for about 18 years. He assited me with my own first contributions. My
sincere condolences.

--=20
Rafa=C5=82

