Return-Path: <linux-wireless+bounces-9793-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D2A791EA55
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Jul 2024 23:29:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C197128207E
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Jul 2024 21:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B1F212C54A;
	Mon,  1 Jul 2024 21:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JNdo8hAd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D778A128812
	for <linux-wireless@vger.kernel.org>; Mon,  1 Jul 2024 21:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719869353; cv=none; b=SgeQWx7S0jPc7afm20uF4u8OsvgwlZ6McTloM84jxClX3RSBdtleI7SezQqi+PuRwzfrlEj8LZX73cM5ahPQDo7QUze1MypYaDF7RY0KyFtAKtx1BUUStire7wiilEJD3aLDgZ/Jfd0hTLWLBHhUtzuwTBWP1jhZyIyhUI9/J84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719869353; c=relaxed/simple;
	bh=lfUTIjx6YyCjnvhOnItybgOP+KpvkHj+ZWYwsxEdjD8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Kz8BP27TW1daKFfYfoN1P1eJrdXEFnNF7cPAutli2TWK5slijQ162kllnLE7+OsmupjgUb2HZmcJ+p5ljc21ReCrWqV0SE1OpdrpkhI2ekDYfNC8izYK2tI/9BsPDtsbTNTIATT8YrxixY6wBgBvJp8y+t27yZ6Gjx2GlHfVnbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JNdo8hAd; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-6439f6cf79dso26725427b3.0
        for <linux-wireless@vger.kernel.org>; Mon, 01 Jul 2024 14:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719869351; x=1720474151; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lfUTIjx6YyCjnvhOnItybgOP+KpvkHj+ZWYwsxEdjD8=;
        b=JNdo8hAdFTTKAfnlKTV5SUGYaNTE7vOKkoJiGs5dq3hQOxDut4T0mygnqxJS4m5FEw
         E1SQXVHcj4YRu8F5y0EVZRJbW1zKXF7dGPSp9jCsO/syV4C+V+7shU/nggZnME92IK24
         gB+a1LVEAUw3f2Dq6bUa8fLhXEBs79esRuTfG0kPhhTNItpyStXMy/pq4PdVL1NX6ejU
         GCp1rfPgQ0YnzZ5j6JU9UP/QDrEEFNi8epMHfZJsHm/3Xd1x3OJNgXh5vUgfSmmmnvxy
         8jI9KgXyMnEUBlmofKG1LWK6sYPiFLmxlBmeiXAJLSe+sQQCF9hpo2Pg9ejgnsOklncP
         3oUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719869351; x=1720474151;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lfUTIjx6YyCjnvhOnItybgOP+KpvkHj+ZWYwsxEdjD8=;
        b=fOwzoaAi76pJ1O11xTVm2IFX9XwfTN6cJpQ+DsXW2nXB+t1uCHS05BXg9O0KJUtLcm
         irb3W+B7ie5J3I+zIBDjAHdWJQ8a6ioZ/I7bnPev+WGt6UKzW+UDPrTacym/A8+cp8In
         IOiqBalEtDbhWuB50F/HF63sIIiZ41hOOlyCNXoxkK1yqJ/J4n/fp8mp0rHc7ojTuR8+
         1Yhdok0aJqKw6Mms4Pgb5bhTGaGduOqA9QS+cIj/CIah8hxdkcP4YCn+VMwuz7W3AQvn
         jHGT4Znp+BDdD57ZBd9/y35Kd8dQk23LsBrhZ/mpTHO9UvgYdaK70/+zBup8Gc7RW3Pi
         5R2A==
X-Gm-Message-State: AOJu0YynPbe3Rzy9X3LEuXPCHb2rqOMfIp14HpXmFl7qEbVvcHOZ6lBa
	x2usRpoy13B95BorX0rJ1zSXT1CSXn8zwHqQZLW6q5Erpm7EmYklk+PHKzKZUZ4J1I6aDzJW6fP
	NhWE6Evn2JAVul0cVQoi7uk9F5cQ=
X-Google-Smtp-Source: AGHT+IG2kIVCFt10ldK3o7kp0BeffsYnoSeGfGkiRugGGGUD2MoHCmwVJI0XxqoyzaMSGIGvyEupcLQbTGt5ZqpM+Pk=
X-Received: by 2002:a81:ab4f:0:b0:62d:1a3:5c11 with SMTP id
 00721157ae682-64c7123c705mr68869227b3.11.1719869350792; Mon, 01 Jul 2024
 14:29:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240628223237.16222-1-rosenp@gmail.com> <8f826bf3e6c2a676c4db37fdfd5b10e364abbb51.camel@sipsolutions.net>
In-Reply-To: <8f826bf3e6c2a676c4db37fdfd5b10e364abbb51.camel@sipsolutions.net>
From: Rosen Penev <rosenp@gmail.com>
Date: Mon, 1 Jul 2024 14:28:59 -0700
Message-ID: <CAKxU2N-L+B_DSTA9nsseDgnzCtgOvtSgd6pShEF-MmA=DQCR7A@mail.gmail.com>
Subject: Re: [PATCH] iw: fix formats under MIPS64/PPC
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 1, 2024 at 3:01=E2=80=AFAM Johannes Berg <johannes@sipsolutions=
.net> wrote:
>
> On Fri, 2024-06-28 at 15:32 -0700, Rosen Penev wrote:
> > __SANE_USERSPACE_TYPES__ needs to be defined to get consistent 64-bit
> > type defines and to fix -Wformat warnings.
> >
>
> How does this even work? Pretty much every file I checked in iw includes
> iw.h _last_ (or close to it), after netlink, nl80211.h etc., so ...?
> Doesn't really seem like it would have any effect?
I only tested compilation of iw itself, not of any project that uses it.
>
> johannes

