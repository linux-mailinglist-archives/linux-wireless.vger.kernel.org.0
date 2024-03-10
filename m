Return-Path: <linux-wireless+bounces-4525-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0EE88774D9
	for <lists+linux-wireless@lfdr.de>; Sun, 10 Mar 2024 03:03:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80C221F2127C
	for <lists+linux-wireless@lfdr.de>; Sun, 10 Mar 2024 02:03:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55200ED8;
	Sun, 10 Mar 2024 02:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X9TpsZSL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A81C4EC5
	for <linux-wireless@vger.kernel.org>; Sun, 10 Mar 2024 02:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710036180; cv=none; b=utTi8P++NGY3NA8jBeEIyz1YpOptyuM3qwoO+7vu5gotBZq4xvtiaYi1+EA8hzAc6PuRmG5VsQtzEOCF20KM9cNT18Py4+TZbn3s5/d7ut/T6TfPyC3ADJ3IfmWgT7JihJ5bsvrcaBiIVQ4q4BgCRqyFZ94yC2hBdVoXF7kPpj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710036180; c=relaxed/simple;
	bh=p0sxo0ufuzidpfpXIINl9CS0RLkbxA2mlkIy6H1xpjs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EAiFDVEe0RJh7oLr2RYphAI2JiL4iJamVYkCZa9pCE+jFZvOY7rkep8zjBzwk8TFkt6WcRd2pQN9nC1Z2odn7YXRWHxQ44LS2epjdzPYvWz91gUDw1KYcyA8z8nKvUU0xIfYln0PWiIeNinBo+LLgKBDXjnW5nqHhnjhDgWvSFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X9TpsZSL; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-690c1747c3cso7426146d6.0
        for <linux-wireless@vger.kernel.org>; Sat, 09 Mar 2024 18:02:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710036177; x=1710640977; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RAsyNx9RRvHmqpg8IRE0aWW1qLeMnDq+gZ1NcfQF3s8=;
        b=X9TpsZSLNeX4c2jm0indVSob6J5r2hFmVEIzlSP3DiuWS/GBoiktOMinlDnnfE1W0p
         C7e3qy22YGy9ubPLcz7ox9aYgojIk5GCH024C7x3h5gwrmVitkfgSUAh1WYyAg4NBrHI
         hLNupXqGn8giiTTjgvhL7D9GEam78890U7l0cBTtTGcoxlxGIrXBcij8pZAy+32kVSRI
         N3q8cZV+wjLOm8OCDdoKZa0lZ3ULc2yj4eMxVhM8fmd3dzM7g5gZp8pGDyydOzv4DJCO
         TDTvyITE1Y86lk40REBJrkzYdsb0sWA1TYotJoYcik+86mvQeWtFbntvQ7PoIvG+7k/1
         1UUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710036177; x=1710640977;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RAsyNx9RRvHmqpg8IRE0aWW1qLeMnDq+gZ1NcfQF3s8=;
        b=gEupf7EkW7NU5mgZ3/c0xrYMpD5U3Tha7L+e/AnT7q+4TgFCU58xgzwV/JaBj3QiBR
         2MoTds6UXGFvd0EwgVYiTRcm+vkDcH36eYGMAs57dibHl5RhwOnyRRMbszEN79z6p7jk
         /ygNJrkHJQwKLt2m4f78zGAdsRsA7ODuzdAYttb3hH0QQkCkZGxYG1QsdVQwcHxGhzhQ
         BPV5qSbhCvlQBUGTvTu3BBhHF529nQunAOy+TWnLLRYRuBA1W15DAtDJnHljTRcci7Yy
         RjBex2NKYD3+Y3Vvv7sn6S6j978sugEMI10aDxf+EYLi3223dOhI+EjqNgnnxBXNssTj
         6DGQ==
X-Forwarded-Encrypted: i=1; AJvYcCW1jZphCkAtIMBeIykY5BTgNUOoFzvzrzGM4hT/xky9lYC7ZAJ2e0wAtX9qo8STH69371CkDlOUTzhfAsG2UsMJI6+xR/j3kF9X0+UrwmE=
X-Gm-Message-State: AOJu0YzM8tsnOHeSLaUjRaQdaIR9dPk7kr2egn0zwZFnTLAgMDdtfiiS
	kd1ZLh5r9f55+A/Rl/bGNW0TTEZT/ndoxro/fcnwLAEvK+1vJKMcgleq3c+ZYigdjzUMrJBYdVH
	BKIt7twGU4hCozR8JLbVcaBLPxHXBwhxAwlM=
X-Google-Smtp-Source: AGHT+IEcFiquADKi81FHsGaK4NEIzoHHM9pOX+Htukc41wNhYE6O5k0Clq+M/JKScLahqRh5tb2AcoYFjitT6RdDN6A=
X-Received: by 2002:ad4:5767:0:b0:690:b863:6ac9 with SMTP id
 r7-20020ad45767000000b00690b8636ac9mr7353457qvx.27.1710036177523; Sat, 09 Mar
 2024 18:02:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <8dbd0dcc292cf15105d09f48c573f7a5.legale.legale@gmail.com>
In-Reply-To: <8dbd0dcc292cf15105d09f48c573f7a5.legale.legale@gmail.com>
From: Julian Calaby <julian.calaby@gmail.com>
Date: Sun, 10 Mar 2024 13:02:45 +1100
Message-ID: <CAGRGNgWxwYART2wh4LozUZJGvvHd2ztMmxLsdB3-8yBd+beqsw@mail.gmail.com>
Subject: Re: [PATCH v9] Add JSON output options to 'iw' for scan results
To: Isaev Ruslan <legale.legale@gmail.com>
Cc: Johannes Berg <johannes@sipsolutions.net>, linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Isaev,

On Sun, Mar 10, 2024 at 12:44=E2=80=AFPM Isaev Ruslan <legale.legale@gmail.=
com> wrote:
>
> v9 changes:
> - remove binary json/iw_json_printer
>
[snip]
>
> Signed-off-by: Isaev Ruslan <legale.legale@gmail.com>
> ---
>  ...utput-options-to-iw-for-scan-results.patch | 3773 +++++++++++++++++
>  Makefile                                      |    2 +-
>  iw.c                                          |   27 +-
>  json/Makefile                                 |   19 +
>  json/iw_json_print.c                          |  221 +
>  json/iw_json_print.h                          |   35 +
>  json/json_writer.c                            |  298 ++
>  json/json_writer.h                            |   76 +
>  json/main.c                                   |   49 +
>  scan.c                                        | 1187 +++---
>  util.c                                        |  333 +-
>  11 files changed, 5281 insertions(+), 739 deletions(-)

I think you need to work on your git processes.

First things first: please consider staging your changes before
committing and inspecting what you're committing there. It's a really
good way to catch "silly" mistakes like "git add"ing the wrong file,
etc.

My process if I were working on this patch would be something like this:

1. Make changes to files
2. git status - note files that need to be staged
3. git add file1.c file2.h
4. git status - verify the files I've added are the correct ones and
that I haven't missed anything
5. (optional) git diff --cached - verify the changes I've staged are
all correct and make sense
6. git commit --amend - amend my commit with the latest set of changes
7. git format-patch -v 9 origin/main - generate patches for my branch
8. Send email with the patches generated in step 7

I also tend to delete the patches generated as soon as I'm done with
them so I don't get confused about which ones are which version.

Secondly: if you're using "git add --all" or "git commit -a" or "git
add *" or something like that which commits or stages all files in the
directory, please don't. You'll do less revisions of the patch and
produce better patches for upstream if you spend the time to check
your changes at every step.

Finally: please add generated files to the .gitignore file (if there
is one) this tells git to ignore those files and it won't report them
in "git status" and won't stage or commit them. "git status" being
"clean" with no untracked files or changes is a really reassuring way
of knowing that your directory doesn't have any unexpected changes or
anything like that and it also helps out with stuff like this.

Thanks,

--=20
Julian Calaby

Email: julian.calaby@gmail.com
Profile: http://www.google.com/profiles/julian.calaby/

