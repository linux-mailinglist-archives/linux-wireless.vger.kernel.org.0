Return-Path: <linux-wireless+bounces-15885-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7003F9E3B53
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Dec 2024 14:35:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8ECF6B39A70
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Dec 2024 13:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C78E01D63EC;
	Wed,  4 Dec 2024 13:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hLl8WkiH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 408331CDFCE;
	Wed,  4 Dec 2024 13:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733318435; cv=none; b=r/7m5kv3eoSb36e3A+zOE33TAyS5xQO9AxaGDzOak6hg8qXSLv+dOXJPOzYZmH0WzXcRHE9tVy13sI8XOUxmibXEIlghw2qi1iB/0JIKYYEN9xzP/TTsKRhCnXNOfXADiIKS7kvqio/QrDLQpvex7X4bw38xkR20UdCPBWxUle8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733318435; c=relaxed/simple;
	bh=0TxWXdNFkki88u5J/bhHHT4PpXFvvjxKAI5piXepKc8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jmDw8nguBO2rGM7HmlwTWKDnBYS32J2WkrQ/aXZDENnUUWzg9l9fM+6toVfK3CbHZRgXruc2OsyUNT4ip3e5LoqvtaxVTyUaBX2AnkO/fChSu68XoQ+TLkfFs5fPUYrVgPILriN3/mJlB+vuHqYDTJWyTRpQ4PMn5fftqW61oOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hLl8WkiH; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3ea45abb4e1so2866403b6e.3;
        Wed, 04 Dec 2024 05:20:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733318433; x=1733923233; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QRlTkMqs9ZfBQR47T3aGcTc0QhtFrpV0/8QrOOsn3DQ=;
        b=hLl8WkiHOZsi7AIq0MxAuPYvELZi+0+7geTrr9y57qYyKZXGiJ+vXIjTgasC/LLJ76
         bcsWnDSDpCOQtavJBvdMVHBWvSYhp7ZGyKQ+RNcCsUgvTwQLOBvJ9XFsBnIQsfsTK96o
         l1/c2oRE6Lq5TGHBJTCR8uEWWRjnKTlNx7xqEjv93bcNP6f6YJxgYprMRbIMlQToHrQV
         tAm4hXiS+uX33S4pFCs6RgWa+316BmOHRCDheGuI6k3F1sU8W5ovvknK2ohaVD3qfRGa
         E0zfJn/pAQ/7/Dr/lieQ/SVd3CVY4M0Z0e1n1xSdDe0e9Sj8PSyS8NTgDFdtndyGZlqG
         oLkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733318433; x=1733923233;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QRlTkMqs9ZfBQR47T3aGcTc0QhtFrpV0/8QrOOsn3DQ=;
        b=LPZAQ86U9ZhEtOyG+gpnjjM9kYk5XHQutXDPbo9KyZf1rMAXDo8R5BWMe17SWyYjWW
         qXdYJrCYdbZFMX/422/eHly4u7AKo/6xFSeH0U1Os5dZVXonM81EcsKxm42HucXd0Zj8
         4gCeZ8T/mE/L3jp2sMT1gbmd7mH/3xiZ6uJPA9kZGANTLZ2/p9Hx3L6RqIBt20NN84vE
         jLnixxhB4XQrOnPPKzvJa+jLzALvJfVURUL5k9IcRaEW+xAAd3UQ8Jwwoxzr4RWHXK6K
         QMkyB/yIQsch1Ixelzg2qbvjFndOaX0mr0V+npuoBb8cL8E5ac1+sYISXZ/Qdp9rL8iE
         wjHA==
X-Forwarded-Encrypted: i=1; AJvYcCWqsScDkXFdJv4ieK7E8QDysErqNEt3aRyjDwCJmrO6sI8pecK/FOKmpTW4/zF10aVGJpNc9BSM6GauuOYFwg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxA1AgoSMLGd1ew7jWLrfU3N2s8tojxZPiMQ1ISPjY8vxORSuQR
	S7+Zhy32MUuQ/WzXpOFMVYlJrO6+H1kzSxThckVehkVlMs1ad/HvwI2Hz4kySpppfxb0U4oEL0l
	C1vM2sq6yAHk5+oOCpzYoVYFVk9s=
X-Gm-Gg: ASbGnctQbAE2TKYsEsaIMA4zBKKKHL7OCRSI2M8Yqk6l1pI+M1okc6xaZf9idtA/WKd
	COyLJMxYjeQ90ySb6I4FjBxfgX4g0g/HTzetBhEntc4sL6D5ElUv/8RbRjy5UZA==
X-Google-Smtp-Source: AGHT+IGym5HijAH6xZgFbwx7wkr5e+fjQxB5fmzYUz/Lq2LCltytJWzJhJu2LJrm/Vrxd98GVE0VCYf2njyfreUHaTM=
X-Received: by 2002:a05:6808:238a:b0:3ea:3f06:4302 with SMTP id
 5614622812f47-3eae50ab5f9mr6914568b6e.33.1733318433276; Wed, 04 Dec 2024
 05:20:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241203130655.45293-1-donald.hunter@gmail.com>
 <20241203130655.45293-3-donald.hunter@gmail.com> <20241203180008.64720493@kernel.org>
In-Reply-To: <20241203180008.64720493@kernel.org>
From: Donald Hunter <donald.hunter@gmail.com>
Date: Wed, 4 Dec 2024 13:20:22 +0000
Message-ID: <CAD4GDZxU-nafwtf2-NaB75hnOKkJo401sD0UWk2E30iHm1uwYg@mail.gmail.com>
Subject: Re: [PATCH net-next v1 2/7] tools/net/ynl: support decoding indexed
 arrays as enums
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Johannes Berg <johannes@sipsolutions.net>, linux-wireless@vger.kernel.org, 
	donald.hunter@redhat.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 4 Dec 2024 at 02:00, Jakub Kicinski <kuba@kernel.org> wrote:
>
> On Tue,  3 Dec 2024 13:06:50 +0000 Donald Hunter wrote:
> > When decoding an indexed-array with a scalar subtype, it is currently
> > only possible to add a display-hint. Add support for decoding each value
> > as an enum.
>
> Makes me wonder if we should factor this code out into a helper.
> But there aren't too many sites with this code so fine either way:

I'll look at potential refactoring as a follow up.

> Acked-by: Jakub Kicinski <kuba@kernel.org>

Thanks,
Donald.

