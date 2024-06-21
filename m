Return-Path: <linux-wireless+bounces-9445-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E1AA0912E11
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Jun 2024 21:44:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C3EB1F25268
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Jun 2024 19:44:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 213A617B50D;
	Fri, 21 Jun 2024 19:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eZJgdQbm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB23D17B4FE
	for <linux-wireless@vger.kernel.org>; Fri, 21 Jun 2024 19:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718999041; cv=none; b=SB3agcd+7Zx/vkVPOyNBkVMC9cLKcEeDxpknFoXHZjQiBsorflB4+++o+53ZQrnmJbllvpGxAlXqFpFXrVyw86HurHnbvJGU6CbrgAuoFX8EOc40vVJz+gQkOXtBamdEWkxEE5etN1pGXjho4K3tlZRZf9L+A9xBugP+IPNIH1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718999041; c=relaxed/simple;
	bh=FckWlNcKkH86nEpWwvTUlItzowssczEyxh04y6cUrQk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ROpCRtYrPyhH5W9sVtGGMz2QWV98K2cyh6QY2jCdTuQe0wvq/pT+gAq0H2ND6DN2VdVZGUA+ksA9146BcSDhYWIH5aapE3nOYSpOgO8kpciUKi2fjoQu5NjyvvtHgk2464BywfIhYMLi0O+AO+K1/jg+V4IyXpu9UNjLvsiFr14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eZJgdQbm; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-711b1512aeaso1858994a12.3
        for <linux-wireless@vger.kernel.org>; Fri, 21 Jun 2024 12:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718999039; x=1719603839; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QkIb7gf2bHPY6dWL00bChK5hdPR/pt0YWtKvdJeMO1w=;
        b=eZJgdQbmgG8QABErn3eHs6NgV6U+qFywFRI5mikC+OFIC5ct0+EXXqL1+O/3qWu4ET
         8n1iBq6/7x9lDbSD2E9Pd9HbghFiXGm860LYdoD6SOBmkSRNR4DMCCbIIU+DVudT+CLN
         NvX5Pvyiuj6wppXJRuQjQmUgeFRTb8/+o/xHfOj/zNsVDIK5I6nOR8HANSDx9t7DD9ri
         e7VKZ6Xv80W9BnwmGMgxLge0CVnrItEj8WRKe4sYFVxF+3TjRdsRWuOqgrMy2LJLJa5Y
         /mtGwrxRTlGvnukZh/1/5Q1dmzYJqo2bxV16Y0yqbaNziBOsR2KXpnri2ZRiA/wq622a
         uaAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718999039; x=1719603839;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QkIb7gf2bHPY6dWL00bChK5hdPR/pt0YWtKvdJeMO1w=;
        b=EaFz5xSYUzn3pL88kEBFK13NcnlpHKdfxnHRIUzO1T/uLBYkBn9txSpCXQW92XLeHd
         i1CnaUnZ9osDq9S7yX7yaMFik6zGN1PFCS2YKfZbmPattZVE8QlR++7TWi7jBzcLD/WM
         RDwyPWeouxpLEQlK3QzVkTg6VB5BL0Jhffa8mU/4nmLmqBN1kzF7G+8bx2MtmEtyWxjg
         Rtlr3A2XJY7D6jK+enAdHGZCCy0a3CbRhqVzBf2kk8OWCbUKHaSh18GxRlotJ684gVsD
         +qMCtlhYQ9r4d7C+25ZusxdWmMEBBcO7W8ab1QOHQ6lBx3bmVOx0JtuIfhUPrRb4RKBf
         dFCA==
X-Forwarded-Encrypted: i=1; AJvYcCWPUI/n2An/cGApGAvtMPA31slWNLXpU4UXso+jnyxYtBz9Uu0ihBwnL+AOu7UpFfmvRX2DQRJgl1+t0ieJioPTeaKNKzHcdxaO9b8onAw=
X-Gm-Message-State: AOJu0YzKAPb4YpsSp/l2zOO05DqvIrdNjlneNLUh9Pj+4XbCOQJWFgJn
	Y9ye4R7eZRs4ryvb481+fjE1l9KJK+4PRTrWbYUmUE9NbB3h8c6KuV0GjHQe3hu3nTBGoF7byMC
	a9QhWwtZnuan+FNHfM7l/pc8VfCE=
X-Google-Smtp-Source: AGHT+IG/VHNVGO8lR86yTQZFauMxfnJ6vv1yrqpGRdYmFybn/jp3wU2ZU3njC7MVpJ6AVq5rCdQRmUr7DWOzhI/1Isk=
X-Received: by 2002:a17:90a:4a17:b0:2c8:893:2c1b with SMTP id
 98e67ed59e1d1-2c808932c47mr4517482a91.21.1718999039034; Fri, 21 Jun 2024
 12:43:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240617122609.349582-1-arend.vanspriel@broadcom.com> <1903bdacb28.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
In-Reply-To: <1903bdacb28.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
From: KeithG <ys3al35l@gmail.com>
Date: Fri, 21 Jun 2024 14:43:47 -0500
Message-ID: <CAG17S_MPxPms32e=s8szVOBHQk=tikN5sjO_pa8r1as0V2Q5ZA@mail.gmail.com>
Subject: Re: [PATCH] wifi: brcmsmac: advertise MFP_CAPABLE to enable WPA3
To: Arend Van Spriel <arend.vanspriel@broadcom.com>
Cc: Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org, 
	brcm80211@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 21, 2024 at 12:32=E2=80=AFPM Arend Van Spriel
<arend.vanspriel@broadcom.com> wrote:
>
> On June 17, 2024 2:26:25 PM Arend van Spriel <arend.vanspriel@broadcom.co=
m>
> wrote:
>
> > After being asked about support for WPA3 for BCM43224 chipset it
> > was found that all it takes is setting the MFP_CAPABLE flag and
> > mac80211 will take care of all that is needed [1].
> >
> > [1]
> > https://lore.kernel.org/linux-wireless/20200526155909.5807-2-Larry.Fing=
er@lwfinger.net/
>
> Tested-by: Reijer Boekhoff <reijerboekhoff@protonmail.com>
> > Signed-off-by: Arend van Spriel <arend.vanspriel@broadcom.com>
> > ---
> > drivers/net/wireless/broadcom/brcm80211/brcmsmac/mac80211_if.c | 1 +
> > 1 file changed, 1 insertion(+)
>
I think I get what it is supposed to do, but am unsure of how to do it.

the modules referred to in that link (b43 or ieee80211) do not appear
to be loaded:
# lsmod | grep 802
8021q                  49152  0
garp                   49152  1 8021q
nf_conntrack          180224  1 nf_nat
cfg80211             1032192  1 brcmfmac
rfkill                 49152  7 bluetooth,cfg80211

How do I set this up to work on RPiOS?

Regards,

Keith

