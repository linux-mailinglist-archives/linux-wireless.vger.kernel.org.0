Return-Path: <linux-wireless+bounces-16362-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 803639F0679
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Dec 2024 09:36:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 901C21628F8
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Dec 2024 08:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77FFD1AA1C4;
	Fri, 13 Dec 2024 08:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HYb+pMXl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E54C81A8F89;
	Fri, 13 Dec 2024 08:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734079009; cv=none; b=FGUbjPnzW5ldWdy14/9IGpauBUVoM5mj8J48JkayjFf2xmWUCtm8o/o1CvoET43sz/3qUnYf/CR3GYLYlO1KFU5MhRPnIAOUBUriIIPa1rZyuSv89iKHP1fAMEUhIzFxrgH3aGpSUkxCYO949Y34N8YmGQ1esePHpn7vG2f7wec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734079009; c=relaxed/simple;
	bh=JKyRigM/AhzU/31X9Efi+u7E+mLq71Us/+kxx01u0P4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iDXDvedxQXMWD7AqlMy4vDlDe0tuYqFsqKgBeVfzqJGskp1k7cytqhIqNLrPfBPfutxfedyfw46HK2rvWztUEUyZ4l/3ab0akGiVc8ITVfKouEQGfJAVeCogQ5+BHLkX7llt03UNQPp8fujQ0p6W6mvOqXCuKgSHr/ms33Z9H8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HYb+pMXl; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6d932b5081eso13962806d6.1;
        Fri, 13 Dec 2024 00:36:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734079007; x=1734683807; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KRt1MXIvY7wy4Sl3wPWxh5TWbRsTuTxrC9cGCSyNao0=;
        b=HYb+pMXl4M0TO+weMu9d66JzvQcGQy+Pj9lH04i6waO+RvK/BOFkh40PZ07NFc38yt
         /5P2wVkrdhNDidVvCsN92cCmyyQ7/Yx/zzYy/x1pzdzCX1zWVWGNNosf5TMyYTadXklT
         ExTQcuA7/g0E0/oHAgO03zMCofQxI9zkxZy/zpYN5525PD6cLjpUIPcxwgTfGtc940rO
         rUxFNqtmyNEorbLFsQwRclMUGThaTBF5eX6eHzyqp0xiAZCLvFudWfWGQNpRD6c6YRN7
         LIKWKYm4VUHImpeo42djJBsK9WwEE5Clsk3ZEyFf5HGs8IQHJzS/s+h6sKP1vrGJCW8x
         Liog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734079007; x=1734683807;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KRt1MXIvY7wy4Sl3wPWxh5TWbRsTuTxrC9cGCSyNao0=;
        b=DiIYo8Epymq10u5zNQdvXdW1AOz1JqJLt9o3wnp6iCTPGg5FbBL4/SQ40OE1jorIFH
         IoZ0Pei3cnlQf+uy+DWQmQOPP79TSEd25jIGIE/tPL3Vf9mEQJ+GlI1pTPGQAjq37OxM
         IZR0kO9WAgfKVtHRgh3h+rXPRbmr8iQhMOOsMIqwxl6Qq1kQ0CiOOkF71QWdSF8mRK+g
         UkMqOQKrvvRA1f5VG3xxOOQHXA3F6XCD5Dwf370eOTKjOGNnFWDlCKqPmlzxuEuX/Ny4
         3mcRbDosW6PBtU68Q1JNU+e4bjW7Egwanx4qXQqGF867JU6ZCQ/RFBJvj2Guor/WX6GM
         /s7g==
X-Forwarded-Encrypted: i=1; AJvYcCVb1R0r0pNOCso940VWMjo76v0TYR3jh+hKT0JYZY30r+ScPSbiuBI6IyZTvGDNhtTXFXvDHjPflJtvX1eFGDQ=@vger.kernel.org, AJvYcCXAW+He7NruG2Iln4C+Y1qdXAWusuk9aSwFHtFR4uT4CGY2Va/3E4cPZOT9PTwz1NIZZsKnJRzlhpI4mBQ=@vger.kernel.org, AJvYcCXSo8BFK51oYt8ASz5o5qWqzvZ85BNyUUJ49d8pOP5+MCjpZXWspa+P+1q4u83+cnzRLIYUFbrwA1YAGy3cbpRsKwh+DFQh@vger.kernel.org
X-Gm-Message-State: AOJu0YzakZRUBTi803dEv8duuUu8m5pC4W8OlTtoaQ3ocCXK3xdEpHOu
	ae1uL1MePCr8x9u4P91a5LhRyyv9sTAbNfPjkCTLjw3gYA+y1ePHYpXcRpEq1PrGzw1c+5CNQH+
	oIhMNDer8jcwm/piQztuxn5y1bjo=
X-Gm-Gg: ASbGncufYEyfV7bjyHYFt7wAqyIjYRGF4MCWHkCDr2Xs65irhv2ufEvN1nIYtx+0dDP
	UvTIaUwQrJcUGQET78Ra+qCxbqnZfOAAB/wnQBv4=
X-Google-Smtp-Source: AGHT+IEt1cOWo4VsTmw/6EdhS/KZ00UrsyLMhWiucugMYEeldbYzELrBj4wzlhuYfpJWzQ/nKiHjbqdqIiCiPqivAYk=
X-Received: by 2002:a05:6214:301e:b0:6cb:ee08:c1e8 with SMTP id
 6a1803df08f44-6dc8ca869aamr25025096d6.23.1734079006748; Fri, 13 Dec 2024
 00:36:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241213054610.55843-1-laoar.shao@gmail.com> <20241213054610.55843-2-laoar.shao@gmail.com>
 <Z1vq2-V7vB5KhBR9@pathway.suse.cz>
In-Reply-To: <Z1vq2-V7vB5KhBR9@pathway.suse.cz>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Fri, 13 Dec 2024 16:36:10 +0800
Message-ID: <CALOAHbAD-USZYry6dToxDTM-OO1+Rz0g6XQkCjhzhWDt7g4MGw@mail.gmail.com>
Subject: Re: [PATCH 1/7] vsprintf: Add %pTN to print task name
To: Petr Mladek <pmladek@suse.com>, Linus Torvalds <torvalds@linux-foundation.org>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, x86@kernel.org, 
	linux-snps-arc@lists.infradead.org, linux-wireless@vger.kernel.org, 
	intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org, 
	nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	ocfs2-devel@lists.linux.dev, Steven Rostedt <rostedt@goodmis.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>, 
	Dwaipayan Ray <dwaipayanray1@gmail.com>, Lukas Bulwahn <lukas.bulwahn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 13, 2024 at 4:05=E2=80=AFPM Petr Mladek <pmladek@suse.com> wrot=
e:
>
> On Fri 2024-12-13 13:46:04, Yafang Shao wrote:
> > Since the task->comm is guaranteed to be NUL-ternimated, we can print i=
t
> > directly. Add a new vsnprintf format specifier "%pTN" to print task com=
m,
> > where 'p' represents the task Pointer, 'T' stands for Task, and 'N' den=
ots
> > Name. With this abstraction, the user no longer needs to care about
> > retrieving task name.
>
> What is the advantage, please?

The advantage is that it provides the flexibility to modify the comm
representation to meet future requirements. For instance, we could
rename it to "task_name" and increase its size.

>
> Honestly, I believe that the meaning of
>
>         printk("%s\n", task->comm);
>
> is much more clear than using a cryptic %pXYZ modifier:
>
>         printk("%pTN\n", task);
>
>
> The %pXYZ modifiers makes sense only when the formatting of the printed
> information needs some processing. But this is a plain string.

That makes sense to me.

> IMHO, it is not worth it. In fact, I believe that it is a
> counter productive.

Linus, what are your thoughts?


--
Regards
Yafang

