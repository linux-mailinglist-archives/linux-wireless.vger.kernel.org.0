Return-Path: <linux-wireless+bounces-8800-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EF84903F5F
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Jun 2024 16:59:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 197641F22371
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Jun 2024 14:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A22C012E78;
	Tue, 11 Jun 2024 14:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TXBL+HqZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45ACD12E61;
	Tue, 11 Jun 2024 14:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718117955; cv=none; b=BNj2BkXNeFA/E940HTP30jCIGKo1TwvuoZZY0xzKoPvA1IrrOp/vcnUh4TGn91j9aHxfdsXk8xsqYH+DXDujH/xzIIeM5xVJWIsd4r6yzsTUB/cXFB5h43OftHpZV3VAjU9c+d/Pq0wzqmyWYNmDmsdfa7i2/63cAAd4wlmZGnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718117955; c=relaxed/simple;
	bh=sy1v37dTQAOugfjUcXUFJL/CtJgCG26TLqkvTQl1784=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jFUitpiMRWIjYw7tYl8p9h4y5JNc1X473KNPDqZ0Fi20VrObMohWzg3VdvNsdmD/VEXfJHoWt0nPrZV//3z6SY6VbZkjq0UTLuDtYsgD762Ee4XBAngxtaNQmlte7aeTt3OtxhZIKcj/cu+uGVWLLvLQs8T/dESRKB2n57OWVAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TXBL+HqZ; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2c30a527479so413150a91.3;
        Tue, 11 Jun 2024 07:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718117954; x=1718722754; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sy1v37dTQAOugfjUcXUFJL/CtJgCG26TLqkvTQl1784=;
        b=TXBL+HqZRY9n3eSA6Y074Zk/6c0rQ0zxn0QectTL/q2aY2XGe/E3lAlBNWhsH4hkXa
         5XVDGM2wujlMvyLfKA/72FdDDXoz8K0GwZ2dDaZTHurQZHJBu2VBctuo0PJJD666wFSD
         zw8O0FwHGIPrQvoi+2AYocpId4TTDixQzSqQYwf8H94eG1c+PXGMziMU0GXSexJaT9G2
         SLFFtX0s6u1c1e9GlPC9p6Cbuwsfyy/70Umlw11e34CeAdwQqG+TIgG/n69xe+FIc9WZ
         /jjTgQ6CQw3EoM8Itrc74OPKQk8uBo/DFx5J6dvSEK4j4QnhSFz0PTZA/ObroJ+vb5w0
         LLjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718117954; x=1718722754;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sy1v37dTQAOugfjUcXUFJL/CtJgCG26TLqkvTQl1784=;
        b=J/8O3DLdJ8G1T7bAoACq7/pDNjBxeTtygOR5T0QmLM46pVGhiILrbsuZbeO8Z/UTk/
         a+pFk/JylyNm6w/A/rJMEmKvhwERYtm4nOt/67BHV5hi407XzEaSHh0h3bwvlr7HMxJJ
         T9A/6/NAwp0Qz/CDMP2pKe9p0uRGVmaVqiQejG9B0awokhPve0IKzQJE6gdBwMXuwqD0
         1ErvqiaEjFqjapvoCaimVDCp7o5v2VVL3D1SyUjwL8eQLW/oalyXLeoeAKOz0evywOiq
         Y+PVXQWycwoHtDDmkKEURNHfQOInkMJ3YZtKulwaP2z+0rxZHQojZz7e0CQbVkhcJ3I/
         uKxQ==
X-Forwarded-Encrypted: i=1; AJvYcCUROqJkb1xOnCRUASaAQSGuU/XTwgwtVwtxZ8zznJ8AykktE2i60OjsPIlpdNhFCoJVzD7V4xvTipKBEPRJ1bc=@vger.kernel.org, AJvYcCVN8KqwZv2XRFj5QZZbhipZIJZSYdeIPiRcrNpxX8UtyTfst7ApCR2tAgxh0z87xgi0AjUKyfS6LDZJsVw=@vger.kernel.org
X-Gm-Message-State: AOJu0YztrIrWf/jzT0fUGFHqvI7Px5wukPKiTeKbCztGkcxw3KN7lKw/
	kGfQzI1x9nFtcaYnGnDqn/5HpD2tb+ZBWMQDDDCq4v9NNavpAbHj/SW2V/E5Yb07WcncTz+4JJg
	MhuXTk9K2H8PTWLMLj2gjYWQuQ9Q=
X-Google-Smtp-Source: AGHT+IEEa2qRt46GzuqPa4X2/ITWYiu+vjUvlGqM2l49WAQuZPD09hPvJ8hdcgzut7Q5IOFdaITkFIqNDkHMBtlwwFA=
X-Received: by 2002:a17:90a:bb82:b0:2c2:f042:d96d with SMTP id
 98e67ed59e1d1-2c2f042da4cmr7648103a91.4.1718117953572; Tue, 11 Jun 2024
 07:59:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOMZO5A7+nxACoBPY0k8cOpVQByZtEV_N1489MK5wETHF_RXWA@mail.gmail.com>
 <3fbb5317d9ff33ef1b60ca8297537335ce86a79d.camel@sipsolutions.net>
 <CAOMZO5Aufe7zAE7TFVprvRreamYd9=RHjybjaEz2O9WaPksV=Q@mail.gmail.com>
 <95163ee547da95964c16f87a38d3326ae4da3253.camel@sipsolutions.net>
 <CAOMZO5CYDsh70u3To7HYXVki_MzzhFyCCHkigt_Es7o_+XG3oA@mail.gmail.com> <7a8e220d77d7e30a0cfaf984404ef2f57eaa785f.camel@sipsolutions.net>
In-Reply-To: <7a8e220d77d7e30a0cfaf984404ef2f57eaa785f.camel@sipsolutions.net>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 11 Jun 2024 11:59:02 -0300
Message-ID: <CAOMZO5BktgtaSPzCf3WOOnkD2n+fj3FeQEfHeT7CYFL+tCHeaw@mail.gmail.com>
Subject: Re: iwlwifi: Regression after migrating to 6.6.32
To: Johannes Berg <johannes@sipsolutions.net>
Cc: miriam.rachel.korenblit@intel.com, kvalo@kernel.org, 
	Jakub Kicinski <kuba@kernel.org>, linux-wireless <linux-wireless@vger.kernel.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 11, 2024 at 11:50=E2=80=AFAM Johannes Berg
<johannes@sipsolutions.net> wrote:

> It should be an address (so that's fine), but I don't see how it ends up
> not being page-aligned if we request to map a page and 4096 bytes??
>
> Is that platform "weird" with strange page size, or something?

It is an NXP i.MX8MM, which is ARM64 with a 4KB page size.

Thanks

