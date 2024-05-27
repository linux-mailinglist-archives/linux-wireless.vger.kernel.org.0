Return-Path: <linux-wireless+bounces-8136-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 579528D093D
	for <lists+linux-wireless@lfdr.de>; Mon, 27 May 2024 19:15:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F8742820B6
	for <lists+linux-wireless@lfdr.de>; Mon, 27 May 2024 17:15:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F23721DA58;
	Mon, 27 May 2024 17:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CLoJjkT3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 398C417E8FA
	for <linux-wireless@vger.kernel.org>; Mon, 27 May 2024 17:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716830127; cv=none; b=MeU+37Z1d65RrAve5ti+ca7H6tg6KrowNa9jzE6LqDA9MYd6FQWn6pefLmRyp+/zgPL6ELhEmwqi4DnaPiTxkZ+xB8Ng5L6OOaNtYiDAzLyq0UeKWLcfS+cDjuiylJ95k5o7PVanM/+3Er/Mx+rfRNIphQ81nemivoGcwBCWCS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716830127; c=relaxed/simple;
	bh=4qry9sYDGajJeY4fVsirha9eAWJAMinOGzf9tAKKrEU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nZ1Th66cXzEj0E4MytME1zDeeJt9XgkTUpY7m0enxrxOXdisOXrP+CRm3sj8/zWIwXsDZsq1iqRh6iVYYWc8ppO9xf7rX39TF5EAshTYGBQ1Zulb65Z5K33thuXbUxy/bPZisE6s96bvUIJnBbew3+fcT2EGJxBAOUtdEYmLG7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CLoJjkT3; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-579cd80450fso2134585a12.0
        for <linux-wireless@vger.kernel.org>; Mon, 27 May 2024 10:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716830124; x=1717434924; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4qry9sYDGajJeY4fVsirha9eAWJAMinOGzf9tAKKrEU=;
        b=CLoJjkT3PerAGWAbuDDZ6EcMu4Ox/YX2gS5+91mIVnYbvz0UZz7vtGPrHrcR7clTTr
         lmHKMPg2vsQynAhMVq61CzZNylDc6nb1WuTYOPqj/ySK539VbVjQ3YQ7oPdAKZ6+kG/u
         mSDPiAxM0b59RCB6MifPVir+Qr2wUb4wbHBj5YM40PhfHuLx4YH6wQtJf5rtjSZr5Q9i
         /nk7GxIbEQCkx+A4C1G+W9vpfIGdVKycmpA4JBtCPBmxsMTjXl/5vzDmmQffv0moTvss
         tp/kKYAQpRJBPRNuYsvmlanZxmPM3gI6rMcQ6o8nAgBnRYoV4nq5AAfWct6mXLrf3Ge/
         xf8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716830124; x=1717434924;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4qry9sYDGajJeY4fVsirha9eAWJAMinOGzf9tAKKrEU=;
        b=w0Q0IQUP+82tEv3trIIcKpK+i0SR2UqwT11/YQvIVX6Z602iUNAUCntU4bCEv57E2I
         lpDfzUh/DADvsKObUd/O+p8pb9Rh6FomUW4hL2SrFO89LemaZECEo90PpS/yzIG1ci3y
         h8aGfKFzTCrWVRDKI6ogcB9V/42GVX+h0wB9O/A7zCZ0GcnGM4X2o4piCNcuXRl2P9BZ
         i8IVKAGLMYBgQTvkKGqvG9sMze7flKgme7KpzKL768Sew+9jJkRlQ9Pj3Iqv8dThJjh7
         DVudyDIw94Y2gP3hA596AZH+QE1g84fArthghKhedhAMTmuVv7sgvRaJCMCiI8xyhsmo
         142w==
X-Gm-Message-State: AOJu0YxLw0Mif9dsFiCFn9ZuFsy6h0IqjwPaYTjiuv4dNV6cK0FfVOJC
	/Q8h9aE6v6POJZpRUjL7ZNrLAYjV6fClJCAkg+UWHGKTraTOVLaPd7hkAZHJx6jIvCxU9g3keee
	0OTRf9+CwQMfXiGbHJCyomIPyBYw=
X-Google-Smtp-Source: AGHT+IHjJ+wP9n5sEC8lXKj3gSGhK2wpttCoY3YvuW/20UyHVbIL5o38TlGoaItSPNLjF+9QjuzpX0qcVdgTJeYznsc=
X-Received: by 2002:a17:906:4a91:b0:a59:cd1e:2012 with SMTP id
 a640c23a62f3a-a623e9d499cmr974628366b.23.1716830124226; Mon, 27 May 2024
 10:15:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAAMvbhGyheFdWSrDzM_i10n9s06n3G2wX6O_S68VUZyP-a9p+A@mail.gmail.com>
 <f939f9dfb467d7a1daaf1e69b56f8599ef3eceeb.camel@sipsolutions.net>
In-Reply-To: <f939f9dfb467d7a1daaf1e69b56f8599ef3eceeb.camel@sipsolutions.net>
From: James Dutton <james.dutton@gmail.com>
Date: Mon, 27 May 2024 18:14:47 +0100
Message-ID: <CAAMvbhGdhHUxstdrmnD6ZF_iTxOTfbAgj1QiwZMKLOYf9D2Egg@mail.gmail.com>
Subject: Re: [PATCH] wifi: mac80211: add input validation to sta_stats_decode_rate()
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 27 May 2024 at 06:41, Johannes Berg <johannes@sipsolutions.net> wrote:
>
> On Mon, 2024-05-27 at 00:43 +0100, James Dutton wrote:
> > Validation is required as a result of parameters derived from
> > received wifi packets.
>
> I don't think I fully agree with that. First of all, this data is never
> actually directly derived from the wifi packet (certainly not any
> pointers or the band enum!), even the PLCP contains different encodings.
> Thus there's always already a translation in driver or firmware.
>
> Now of course we shouldn't trust firmware either, but even then there
> are a lot of places, I'd think this is better done at the driver level.
>
Hi johannes,

You mention "certainly not any pointers or the band enum!".
How certain are you about that statement? I ask because received wifi
packets can and do result in unwelcome values for the pointers here.
I did not say "directly derived".

Kind Regards

James

