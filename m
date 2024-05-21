Return-Path: <linux-wireless+bounces-7863-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 524558CA777
	for <lists+linux-wireless@lfdr.de>; Tue, 21 May 2024 06:43:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA6B72822A5
	for <lists+linux-wireless@lfdr.de>; Tue, 21 May 2024 04:43:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 573242BCF9;
	Tue, 21 May 2024 04:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j/waz2XM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6F062B9A4
	for <linux-wireless@vger.kernel.org>; Tue, 21 May 2024 04:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716266614; cv=none; b=USj9Zy+DQLL+2COB1rykm1peZstH+5BNPAgD8+drDFhSeU9XvXLzPGWyLTikISuZxNvDs+fYgGm5q+aHHfauBmFIkDcBMfyF8wOtt88Aw9hUz6auo7oLPMhf5BdFg798431v7OmNNI66mGyORDJLrSkBmVJLS+a0ZZQMemr4sOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716266614; c=relaxed/simple;
	bh=CB+j1bQwAIQQACQ11R1Vht+rgN6HlChnMRjVgrqXgKg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n0Cywunr40RdZiN3V9sSAx4mAN+Tk/NlXdEG3117UKfn7pqwr6S0QVQgJPoGB7rTB4+26AMtFGiaCEb9VzdW3uXSbe/IluP0Sjm4ppLzdjw/UuLmk9QB5WSe/9DmMF4nyabP6f0Bo/+AtQ/E6SwzCl6tc/xa00Z4bg6H9hg6vHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=j/waz2XM; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-572f6c56cdaso28777a12.0
        for <linux-wireless@vger.kernel.org>; Mon, 20 May 2024 21:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716266611; x=1716871411; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OIZgyK26myZGOgK2O/gVC12eJCOj7y2cWrgpVuquN3A=;
        b=j/waz2XMYWkOt3Y0j9yEjr++ZLEcqT2eUdLtfHbNEMwiv5qTI76yvj8xIu6ZpjXQyD
         qmW9mWv5ezEE8eU8y7IA3tnPxaCZ0iSLhVnT/WZ8i3pXqXfpXDcfliod0aTh+d88V/6J
         SoM3Qbs2RYhdHHzYYRtO8O8KDy9sJLIqQbPP6p/OQgNX8DDQ83vaKdKRUlHqDMKbnfaT
         BrOnP0A0IRduqAzq2pqjdb/zS8RvXQTZgi/oX7U3gLwr0srR9nOBC8Z0453Zapo7n2+O
         A2RUpFiepHhbKuX6CK5nDgaPBpINctG/nr6r2ZqNl5/HMskv2VdOuyE+d5hDY77eWfcP
         2QKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716266611; x=1716871411;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OIZgyK26myZGOgK2O/gVC12eJCOj7y2cWrgpVuquN3A=;
        b=t6kfgXNWd5uBuTEUmkJjQ+ZykZLu3unS9prFDkIqFDcO0aSqlxsjkNF+XQlnqQI6zI
         j2dhlzkHfacyZtpfU4eknV3VpKDflt7dIv5swD0rRgmJ89kzCuKlKfHBrjVbNhfMCXq8
         jLOkk4c25hq1ZsjcFtWtzEj7AaPvuWk7AaLgLD+ddAk2DO6HXidoN86ZbRx8q3oZBJze
         QI75t9J9pcdnGGd2K68b19U2BqYmaJbvNr6Hab4DuAbNiDy0DsN4bfzxLOBnY/ig/nKr
         pq2gALjSr3yXYhUqnnVs3rChzsH8ToHB0Ue3SozYZuh+iz9YX4O4KdmYAQtIY0ZowXNa
         f7dQ==
X-Forwarded-Encrypted: i=1; AJvYcCWgeHvq6QBeo0HtAudY+2vmmfZBFsplZ8JCEKK7JcJdgKZIQrqh+KKcWRO8BWD7BgewziEfCep3IyTL9adsr5EUi67qFDDlBe+trSMTeXs=
X-Gm-Message-State: AOJu0Yzj3k/H54zQiEZkxZMqMQP0Qx/rFhczTON6fnIBWOMN4FCQeTAB
	bVfaD1fvauPpeAkQawpjHBSAIr7ab2ehazJes0PVK6Fc2qxwGuwbcoVmZ9ou6oasnpaRFl3t1Mq
	jEFZYD5Yf+JGoP7Co46GUIE6SW80x0K94U1O/
X-Google-Smtp-Source: AGHT+IGX8Rncf2X5ll/LDcPy6e7NBCxzEjCBoxNwC/ZewP9Brf6v9SIFgZvkghI3vrvyJWD4EADtmpcT7pucGjRUQYo=
X-Received: by 2002:a05:6402:8cd:b0:572:57d8:4516 with SMTP id
 4fb4d7f45d1cf-5752a710019mr443481a12.2.1716266610661; Mon, 20 May 2024
 21:43:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0000000000007b02500614b66e31@google.com> <550cc81a3dffd07ec1235dc32fd7bbde22d9bf57.camel@sipsolutions.net>
 <CA+fCnZe_fuT2y4ryFeb8A49k19MY3Nct79JCoGwQh0hjcq6bqA@mail.gmail.com>
In-Reply-To: <CA+fCnZe_fuT2y4ryFeb8A49k19MY3Nct79JCoGwQh0hjcq6bqA@mail.gmail.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Tue, 21 May 2024 06:43:19 +0200
Message-ID: <CACT4Y+ak6D2tY0b8JOFq4kKvfPRtv+GkFFE23jc6qTrx6mTqVw@mail.gmail.com>
Subject: Re: [syzbot] [wireless?] WARNING in kcov_remote_start (3)
To: Andrey Konovalov <andreyknvl@gmail.com>
Cc: Johannes Berg <johannes@sipsolutions.net>, 
	syzbot <syzbot+0438378d6f157baae1a2@syzkaller.appspotmail.com>, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com, Aleksandr Nogikh <nogikh@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 10 Apr 2024 at 12:56, Andrey Konovalov <andreyknvl@gmail.com> wrote=
:
>
> On Thu, Mar 28, 2024 at 12:45=E2=80=AFPM Johannes Berg
> <johannes@sipsolutions.net> wrote:
> >
> > On Thu, 2024-03-28 at 04:00 -0700, syzbot wrote:
> > >
> > > ------------[ cut here ]------------
> > > WARNING: CPU: 1 PID: 2400 at kernel/kcov.c:860 kcov_remote_start+0x54=
9/0x7e0 kernel/kcov.c:860
> >
> > This is
> >
> >         /*
> >          * Check that kcov_remote_start() is not called twice in backgr=
ound
> >          * threads nor called by user tasks (with enabled kcov).
> >          */
> >         mode =3D READ_ONCE(t->kcov_mode);
> >         if (WARN_ON(in_task() && kcov_mode_enabled(mode))) {
> >                 local_unlock_irqrestore(&kcov_percpu_data.lock, flags);
> >                 return;
> >         }
> >
> > but I have no idea what that even means?
> >
> > > Workqueue: events_unbound cfg80211_wiphy_work
> > > RIP: 0010:kcov_remote_start+0x549/0x7e0 kernel/kcov.c:860
> > ...
> > > Call Trace:
> > >  <TASK>
> > >  kcov_remote_start_common include/linux/kcov.h:48 [inline]
> > >  ieee80211_iface_work+0x21f/0xf10 net/mac80211/iface.c:1654
> > >  cfg80211_wiphy_work+0x221/0x260 net/wireless/core.c:437
> > >  process_one_work kernel/workqueue.c:3218 [inline]
> > >  process_scheduled_works+0xa2c/0x1830 kernel/workqueue.c:3299
> > >  worker_thread+0x86d/0xd70 kernel/workqueue.c:3380
> >
> > It's a worker thread. Was this not intended to be called in threads?
>
> I think the problem is that the KCOV annotations in the NFC code are
> buggy: kcov_remote_stop() is never called if the loop in nci_rx_work()
> exits on one of the breaks. With the recent addition of the nci_plen()
> check, this started happening often. But breaks existed in the loop
> before that too.
>
> We need to move kcov_remote_stop() into the loop and call it every
> time the loop exits.
>
> Dmitry, could you PTAL and confirm this? You added the annotation for
> NFC, AFAICS.


Missed this before somehow.
The other breaks seems to be from the switch, so should be fine:
https://elixir.bootlin.com/linux/v6.9-rc6/source/net/nfc/nci/core.c#L1528

Tetsuo, thanks for fixing it.

