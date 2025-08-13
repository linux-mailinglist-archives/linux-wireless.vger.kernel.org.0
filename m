Return-Path: <linux-wireless+bounces-26379-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FB28B2573E
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Aug 2025 01:08:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A40EC5A7410
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Aug 2025 23:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E4B72FC88C;
	Wed, 13 Aug 2025 23:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JMyjjx1M"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D47E42FC885;
	Wed, 13 Aug 2025 23:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755126468; cv=none; b=XXwUjc3nTj7Xj9kic9yv7HiaLmpmmYl1BSdhgbjd3RcAO2tvDQuTJjpqCzSzh7nMo0q1wWUqBcV5q1qKyI0K0VhmTcGwqwSXsnmNYJA5zGE6Th060SiweeendGQTPXJCH+bjp8PN/1mdu6F4QEXFLOJezFl4YeezXrsvmxoJNWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755126468; c=relaxed/simple;
	bh=vQwIReGvE7EnXMVj0imlJBxCG1dUMJ2402nY8Dzlvwo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O0z9h9w/JJTE2oH1/7LawQowIF1e+ILvXyWEqHUXDT32qsCX3BAs/Q5EFKZPLSv6JxfoMDimZdSTqhF6a2L80M1xQ3VN+8xLi6f/1a9+Ewzu4sBQpnv2zuOqLgaZdQuEmM4Yl1uFCG8mgCOJpnPaelD2zNs7921kNu/qqI8XUt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JMyjjx1M; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e931cb179efso472087276.1;
        Wed, 13 Aug 2025 16:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755126466; x=1755731266; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vQwIReGvE7EnXMVj0imlJBxCG1dUMJ2402nY8Dzlvwo=;
        b=JMyjjx1M391CXe1ao1605IEi/KcZ7QUB9Q9GfVvjrivWAvvz++5mPsiLLZDQ2x0Rw+
         koo0qTQPsBNLdgW0bc1jU2hyahP9Kdo6FrSZE9a14PM4erUTuewlRF+lrjgQK54DDEO9
         tEekWpBGnlWvhCtK/GHlrCDA/qvNOvx7jOv6KywZIUTNy/s03LzdFi9Sn5tStpqDcCn3
         7hJVhIKUWi8875kfhU7NfDx9yGh7Z5acR8RohIHJ5VPZOQzolYev2xOdJijmjoPiauFk
         aDAqIVHHqu4PcnkhGe+m6i9EnU71bpnN7xktRjodTUCm6nwmjRb5CnCn/szr5Xaq3BfZ
         qHgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755126466; x=1755731266;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vQwIReGvE7EnXMVj0imlJBxCG1dUMJ2402nY8Dzlvwo=;
        b=H6jU1csSXGCMz352NtLh//hxOqVhSkkrNGrg4gc0E2gFH8KC/R/pxAlA7iFHsJ35vn
         HyJCPQFKo3dQWyFslG536fFb29e19TcZvpXVM84np9V9bmoPO9ynFEv5KshKZhmIgEpz
         osgGuRTWaRh14+F24p+lPwn1Hsw1q4NH3PX0tT+m1C4t2IF9wR7Wve4RofjoMG5XppAS
         uVS3bS3sIP04gwG48OR3PM7dQIfylcKR+XdLhvzdoC3YhBLJXh33CWhIeOMrHCFf5UOK
         SOEdaY71nlxyBeXRRgiGynnYYA6He6mirhfyVVKWwWystY5/KLjmhNxeYfR9axrQvqNk
         qt5g==
X-Forwarded-Encrypted: i=1; AJvYcCWEeloRLoc2E+NuvMVQIpKBXPR5uCviD/mTyBsA6PpdLtFO+qK0eVaVKTI1w38Xs8pkSvcsjkP6CyNhUc5M@vger.kernel.org, AJvYcCWKjq9fIb9fd21RdiRzouK3JvV4evbfleznHe5njjO+O9CEnk4TdmsR/BslMTuSIuPbQDhfFXoFM0to@vger.kernel.org, AJvYcCXfDuUE+JpjBZZnAPkobGFqGpGc8Au/9hKXqVeDoY+MkHUQrqWCL785oSyEsswouFaZJcesYV9n5zepdw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz84G8dnRezphK1TR3aejGqaVb5xp2ELWsGA62cK1Y/s8BKLD0a
	w8HjIpkHOaAtgYTCMzXWsg8O+84MObKFoJfIEl3QucN5oLbTX7fVPYq8xZtHnHd0JoHYpRbXZNH
	0DrJ1ka8ihREKjtKrG1JcCdE+aeM+VIfU7Q==
X-Gm-Gg: ASbGnctOj7bW5RJBBDhURsZdZYThI2TxXNsJS23ojvD3Lfa0T9Ze4c4qcXvEofW8Hn9
	kwZQ3LPYvlsBk8FmSwAQ4JnqWV/q4DrwDAf122QXM+s+A9b/9DBUdWPJuEwoT70gmvWpiaIn/G4
	riRw6kdwNTChV80ON0GAkzXYqzMBBnl6vv1YgJU2NJhWis8K2PVWkeMSslAchEveOGY3clOqB+C
	jklJNrUQhlgQiN5oAj9YQyqz8WV4Y4=
X-Google-Smtp-Source: AGHT+IE2lhKwF5StowZuPk2/pwn7edNyDsqTTBzKUYJxP/oPbUnvsgBYEsLnm1DCeFkDWNMPMzgKWz/NV07wzPM7Ea4=
X-Received: by 2002:a05:6902:4a81:b0:e8f:e89a:cb76 with SMTP id
 3f1490d57ef6-e931e2a0613mr1000583276.48.1755126465593; Wed, 13 Aug 2025
 16:07:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250812192334.11651-1-rosenp@gmail.com> <eab44630-79b8-471f-8dc1-8c191290d6cf@kernel.org>
In-Reply-To: <eab44630-79b8-471f-8dc1-8c191290d6cf@kernel.org>
From: Rosen Penev <rosenp@gmail.com>
Date: Wed, 13 Aug 2025 16:07:34 -0700
X-Gm-Features: Ac12FXxzSsEaSjdImBy24WOCsoPXhNlLQiQnAtabkoG6TVT-5jk4kfYve1iOfcg
Message-ID: <CAKxU2N8kHd8Sm1gLECekYzuW-APyBNxOi8K2k8yO1qWTqbsPeQ@mail.gmail.com>
Subject: Re: [PATCHv2 0/3] wifi: ath9k: ahb: add OF LED support
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-wireless@vger.kernel.org, =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@toke.dk>, 
	Johannes Berg <johannes@sipsolutions.net>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	"open list:MIPS" <linux-mips@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 13, 2025 at 1:18=E2=80=AFAM Krzysztof Kozlowski <krzk@kernel.or=
g> wrote:
>
> On 12/08/2025 21:23, Rosen Penev wrote:
> > A port of the prior platform code to use OF.
> >
> > v2: use reg instead of led-sources
>
> Where? Really, where? There is no reg in the binding at all. There is
> led-sources, though. Also many other things got changed, the binding is
> completely different and nothing in changelog explains that.
Yeah. The initial was copy/paste from mt76 driver. But then on review
I was told to change led-sources to reg and did not completely change
that in the patchset.
>
> Best regards,
> Krzysztof

