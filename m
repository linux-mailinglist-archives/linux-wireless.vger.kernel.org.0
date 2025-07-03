Return-Path: <linux-wireless+bounces-24788-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46F84AF6E0C
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Jul 2025 11:02:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F3E11C25DF1
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Jul 2025 09:02:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E04422D3733;
	Thu,  3 Jul 2025 09:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bYMp0EcQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52ABA2D0C94;
	Thu,  3 Jul 2025 09:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751533339; cv=none; b=jwn3L00sU3vXLeUksrjTde5aao4GStiinndH76hGWOhgUDx9DdxwggYhdeBoE/hlm0cUSBOVviOrLzrhLPqK8uCJADcxrUdQKkN84dOSMY3/AFsQo+HPD1OaIxYTXYovjslN67Sx24hBTlfzQhorhjZED6iXayMQy5vaw2OHh6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751533339; c=relaxed/simple;
	bh=r9iNBHzBMwWsOC2LNoiI/v8Ks+Adv9SBboC7T9eoqaU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T6KiExIh5g2KI4wnKn6MNs4rD3m+l7u9wNXCPJo6z6ALFPut65hvcZ5ievSCArVO467yVnfUT3ZLeatIFJLO6WQpw7zj/YSy54NtrrBFP44GrCTaJTKgzom6eG4y3l9CWS9clkBmRsF4eCI6QPEq7mX108yBtEi9TF327RwqIYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bYMp0EcQ; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-70e1d8c2dc2so53820497b3.3;
        Thu, 03 Jul 2025 02:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751533337; x=1752138137; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dua4EX6vICZ4ncNmnpExr5W8cwU+tQuHJtXdNhi/iGU=;
        b=bYMp0EcQOaK1pbRYdCB0BzQgu8oBFEgJcHeBy+2sBC+7prvtzpiG9b6BeLglvZEJtl
         Nfo+qdrSMmreJikNYREYUtBVWVID2l4mNRzLSd19AFKSN8DOmj86I4KnhhB4/l8FrQ2r
         HNDet7iQ8xZkOfpTaG0FAxwQRPbbDzPQ2Tg6t3KYZQqhgW7yCaP92+KMXpCeTmCRHJ3q
         TuEIe81dV1JHqUXKTL8bbpjLONx6IL3Jkey0Tu8yS5kGAPDsljtd1x+/fegqie2jgj/0
         SPcRifCk6/wPLgQ6z1zbDYACBz/HoPy38HjJ84jAK3eL/E1QU2CTz9dkNsZFzE2FsZcq
         ycHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751533337; x=1752138137;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dua4EX6vICZ4ncNmnpExr5W8cwU+tQuHJtXdNhi/iGU=;
        b=L2gk/RYxZuhgSIgZQ5kLQ89iYqDgExDr+0Uwi+n8CIIzk7fsd4xh9BcjBsY6G3ViCY
         J6ECWYcUrV6kQwpxFPukO3kpML/gn7fZmF+d+nXX2MWPgPmUflIvJMkX5MwB0sB7RRON
         mh8ov8pbV0cEodnukQwqflzYmtDlfarBcJRoQ0hRIzvWrasrBZR3iStuMvYockjfj1+1
         4/hf1Mp9rmmW1/SE7geKBlp3nP9zZ0M/SyM9kMH2ZVfMmZIdIjxxDHaPHfaOKNMVKQht
         Sd6oXcH+unbYJUaelvW9rHA85Ivqyi61f/7LjIPhovO/cyHmXU+FOuJVZoPgGdpIGaXt
         AMjw==
X-Forwarded-Encrypted: i=1; AJvYcCUQqAJQeII2xB8e28HgHhfZ8mCSGmzWM2u4RRXfeNubtRacFRoJNKDPN5Gl/sAj5WGxF0EFqj1JUqW7/JhAZbU=@vger.kernel.org, AJvYcCWDthsPrxh9y/e9PndDfxyRqrrAiVz+HUpyLRiB8jCaqu0DoP82zuq75bYvWc0mDksQzsMx0d+6006To2o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdPUrMg6oiXCeUMSTiux4LIIgDOi9LYKLBjcR8d/UvTVPSmD1v
	BD+AMbSWisFb+MBF+f2eau4iaVDi0nKNREFZXaOqlcJKrXWhihDSag3VzvWkdO1DwGZg4chyaF2
	4SH9RaTdfRzploiikDqXSqqnjITguSBbWFQaYJUo=
X-Gm-Gg: ASbGncsnvmCKb3ql2NJ5QWhiUiXzL4NjcG4OGa5TqKuZflR7nFwX5dB2fFHOHrQi+gu
	lTyilCZQpiVJ9lErc1KeiqVZym0Z9oTKNPUIk+Az0hDVnsPEMU7QD29odoixF4IRwlNqamv40t+
	NtUh/pD8WB7jUSQpG4vUShz/5LVkhYMZf8xyOCZ8/RWAAJxpa/ge7iLGTUNKA/EkJzumqaeAJYZ
	5m+fu+swkmeVf8=
X-Google-Smtp-Source: AGHT+IFPagC/bJXD/I8xAFfYmmHWH8z3OLkpesDap76h+qYDoOuGP8g36pSAUapeCBHboIP7KJtMiM5WqD9+MQ8t/7I=
X-Received: by 2002:a05:690c:fcc:b0:709:197d:5d3c with SMTP id
 00721157ae682-7164d2c7e12mr90141507b3.11.1751533337096; Thu, 03 Jul 2025
 02:02:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250702065908.430229-2-moonhee.lee.ca@gmail.com> <DB29OMQH4W9Z.1GPKEZBBIRSTS@gmail.com>
In-Reply-To: <DB29OMQH4W9Z.1GPKEZBBIRSTS@gmail.com>
From: Moonhee Lee <moonhee.lee.ca@gmail.com>
Date: Thu, 3 Jul 2025 02:02:06 -0700
X-Gm-Features: Ac12FXxcX-6zWRjtsp0bKhB4_ffVbC4IS-cAUihVV3UL7VYsPXyWVqyR0taTsEQ
Message-ID: <CAF3JpA7wM4JBdd6OvGS+hmv0UahcW=h4HrPNDwRNhduk8iKsWw@mail.gmail.com>
Subject: Re: [PATCH wireless-next] wifi: mac80211: reject VHT opmode for
 unsupported channel widths
To: Nicolas Escande <nico.escande@gmail.com>
Cc: johannes@sipsolutions.net, linux-wireless@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev, 
	syzbot+ededba317ddeca8b3f08@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Nicolas,

On Thu, Jul 3, 2025 at 1:12=E2=80=AFAM Nicolas Escande <nico.escande@gmail.=
com> wrote:

> Is this really specific for VHT ? or for HE /EHT as well ?
>
> > +             switch (width) {
> > +             case NL80211_CHAN_WIDTH_20_NOHT:
> Because this seems weird for VHT
> > +             case NL80211_CHAN_WIDTH_320:
> And this did not exist for VHT either
>

Thanks for the feedback. The intention was to handle VHT opmode notificatio=
ns,
as noted in the commit message, but the check incorrectly included widths t=
hat
are not valid for VHT, such as 20_NOHT and 320. I will update v2 to reject =
any
invalid widths, not just 5 or 10 MHz, and restrict the check to the valid s=
et
for VHT: 20, 40, 80, 160, and 80+80.

Best regards,
Moonhee

