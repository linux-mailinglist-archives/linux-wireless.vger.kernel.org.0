Return-Path: <linux-wireless+bounces-21404-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86DBAA84E40
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Apr 2025 22:31:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2FD39A56AE
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Apr 2025 20:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D31A290094;
	Thu, 10 Apr 2025 20:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dQIqs26W"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAC651CEACB;
	Thu, 10 Apr 2025 20:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744317087; cv=none; b=Muw+w0TywHxpvjFi6yaaQWemgk0ks9j87a6ZSrENUqj0kw/JoktAZSTJ51OuZQW0rxixBbKpuWmxs9Evf5iYXhZtrRQHJJ2BncZEBhkYltdLW+SGYpVjLWzPOcylTvGINP8aiqU1TlG5iltGjWFuW33O4bXLCAinpDrCU/7TEmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744317087; c=relaxed/simple;
	bh=NxpQFlw6f7L2R3J5eNPi9qFp9lIFC9OIiytf+y/FSmE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D8WUBb5QBixAUGVkQFum7oKc/gmyNVLL5Ub29U/ZAfpXccKUT93+Ws7UhoKIEF7f0yuOEFzefwjgdNxhyXfYcNvlDewtjh+MzF56kIwQZu+EM00aR7kkmvNXmrv/YLyaSKpFqc7JCanLOGLBMx/nLa2jK5xP3BfxH/B+B7hrOlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dQIqs26W; arc=none smtp.client-ip=209.85.222.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-86d5a786c7cso548551241.2;
        Thu, 10 Apr 2025 13:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744317084; x=1744921884; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NxpQFlw6f7L2R3J5eNPi9qFp9lIFC9OIiytf+y/FSmE=;
        b=dQIqs26WiapW/fvv1X5DeGyvaY4Yf2pgWDWSHXM47ROFA2GuqVE4+j8nBv2df7OZmT
         n17C2VQ2cYOynUXg+C0uq9QVAvj7OUzOQlEo2eJrOJN3PLoSvkrRvi740DfucE0kB1cj
         XQCJErHBHhBw+83S4hdTV1EjMQCMpD8xv9eNQe7EGj6bduQ2JxOqIogI45uTrKfqN8Bb
         +oZ2mqS2DtnU0qYC94hwZoLs/lbLy3thnuUDbp/QFpE7Jdz+YPiokxV91hIZfP1PKgEX
         v4UIlP8564RBm83AzQuNVJ0BlSLkCfgL0ZYNMcockbLQ6HkLpmfuJbDmpY79zrmA1E2c
         91Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744317084; x=1744921884;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NxpQFlw6f7L2R3J5eNPi9qFp9lIFC9OIiytf+y/FSmE=;
        b=Z6yENqnwt7LqEbeNXC4/Ob5U+8uHn13U5b7WadUbqqCYElMuaKVTSeEKL+1GIsAYmW
         ilPc4cSbPv53AkoAPABF/6B/u/b0hvmWQHculUx9SFZBsLgx/7zVrT6WzLvnILQO0cth
         BBg0tLbMqbyEL2ShPcj1KKAGfs/BmEbsQHJZuHGdd4orRuuNpnhJUq9hVY0JoEi0Fshj
         wsf+nWKm7WcJ2F1FSwC5H9+V/qBT2U395tdJfZcRZy+sOCu5BWiH0CZCEVgg1W4ZHz6m
         VY+dIWJaoN/sL8J7zEmGaysyJWSzqhfDmhKE1y/z/QBPMx2AdRZFhZ96pLXO5cF4Yd1q
         AXFw==
X-Forwarded-Encrypted: i=1; AJvYcCUKqQQkybySkTdaJvs7TXeNNnsCoaRr8GTfZ/3YIDXWlyBono6uy8Xo/2LABQWtEG6yVsazchfK6/bEc/E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAqy8QNFkVIGWFwrplcueuWhGYOwBtKPdDa55f6VOJJrrriYc0
	fboZ3dBd6nMrsp5E8uhR4Sbf7H2867LFclS08hKp4L5sG3G3gOcaF5NUW8RjjilrDpjqHHoMvAv
	cN2u+KUsCRQsSAcN08LV2or+X4gRR1g==
X-Gm-Gg: ASbGncuVepOnTgVMnijqkvFE89cH72KyYntTKQwQmlHCAClOC9ilPF+4Rm2DnlOZ40b
	NYU2k4PqkdyeKbxdGoHbQ1abvTtXQdFINylXZbo/HbR/ZaCclwWv5VbYAG3e2/ajRuFZGh8vjwp
	A5Mtq9rQuRfyP7QmvzxPmZAQvnk8SYkHVoRFo=
X-Google-Smtp-Source: AGHT+IGpkQT8+tGZKPjRJPzXpQgj5TNkgnXW/EznGexoBQ/GvGuQDhUlhbeGDXZCuv7AC5fLJIvQO6o4mF5uCm+4+Lo=
X-Received: by 2002:a05:6102:3309:b0:4bb:b809:36c0 with SMTP id
 ada2fe7eead31-4c9d35c5eccmr4239438137.20.1744317082084; Thu, 10 Apr 2025
 13:31:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250410004130.49620-1-rosenp@gmail.com> <87plhktgwy.fsf@toke.dk>
In-Reply-To: <87plhktgwy.fsf@toke.dk>
From: Rosen Penev <rosenp@gmail.com>
Date: Thu, 10 Apr 2025 13:31:10 -0700
X-Gm-Features: ATxdqUE2MASratXaiwZ3TQ9YovT3u3h7OwvHIQxUlqYvCWa3QkIthPnj8mxha9g
Message-ID: <CAKxU2N-PpA2JLZu2Yt6-UOwW+7TEZfjJoiULve-jqnyyd-Sipw@mail.gmail.com>
Subject: Re: [PATCH net-next] wifi: ath9k: use devm for irq and ioremap resource
To: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@toke.dk>
Cc: linux-wireless@vger.kernel.org, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 10, 2025 at 4:06=E2=80=AFAM Toke H=C3=B8iland-J=C3=B8rgensen <t=
oke@toke.dk> wrote:
>
> Rosen Penev <rosenp@gmail.com> writes:
>
> > Avoids having to manually free. Both of these get called and removed in
> > probe only and are safe to convert.
>
> Erm, huh? The request_irq() change in ath_ahb_probe() is literally the
> same change that you sent once and that we had to revert. Not taking any
> more of these, sorry.
You're right about this. The first change is correct as it happens
before it is assigned to sc. Will send a v2 without irq changes.
>
> Nacked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.dk>

