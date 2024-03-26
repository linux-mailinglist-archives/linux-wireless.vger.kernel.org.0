Return-Path: <linux-wireless+bounces-5275-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D0DE488BCD4
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Mar 2024 09:51:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 655B82E432B
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Mar 2024 08:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1640418E1F;
	Tue, 26 Mar 2024 08:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lcc3uM4M"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EC5E17722
	for <linux-wireless@vger.kernel.org>; Tue, 26 Mar 2024 08:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711443118; cv=none; b=htrVZrRjhXhUQyaHUwuY0QUUJHab9IM/z+rQJ2b3fJeL36hEIOENOy9XvR1LBVnYSX+RKl0Rcg+Wv7e1QNWPZ4+TWhG419z/uEKCoMKbIAyI+U5eeNsZEdoaGrcdOb9QoInmyEDlQpeSlbf/fBUjxd3Ae0kRFesdxUor44V9B/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711443118; c=relaxed/simple;
	bh=LPq5puB/AoAbnGrL3Lrnux2nfeEcajXmEsJKjYYTpBw=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:
	 References:In-Reply-To; b=GWVooWKiKOEYxOyCsq0lQjmgWukHhB5wdc3+lWBFq2zxkbT26hEXzesJ/wEiS1U22pSwPUglxeWpy/U9ESSmag6XkRkEpX8yR0ht/EC1KiRt/vfWMyaKa70ex8Ff3rF14JBuXv7U3kaK7pTGzo7VH3WKjUu2o/5R2cunSCUR5xI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lcc3uM4M; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2d094bc2244so69308561fa.1
        for <linux-wireless@vger.kernel.org>; Tue, 26 Mar 2024 01:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711443114; x=1712047914; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LPq5puB/AoAbnGrL3Lrnux2nfeEcajXmEsJKjYYTpBw=;
        b=lcc3uM4Mi4PSMoe+7TdFcXnlfZWKaiduvbe0yjQ8EkMobmlgVUqv0PMHL9E7OcxyPE
         c9E3KzojRzXfQ+Sfw36dH2aP9X29BB9aHPaqr2HAynSsCw0Y9NLL81/RD81MgIOWKYJC
         +H62bGJBUq/93p9BBJh5FP6Qb+c7+xqm86/tQz7MwZMoDJ7aB+FIBKGhjPkhbGOMhN+g
         mSXG3vae7yvSF0vuXRZRzVazp8m3gPC2F/CeRHZz1dE3heBBx0hODnO3SkVSfBizXa8V
         Gw22TuVDJ6h0XvKPQQ27P/CMABSX3mpVWGcjLUl/Ay7buFuDIrHhKwcn/elGeNHqIkE5
         8VGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711443114; x=1712047914;
        h=in-reply-to:references:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LPq5puB/AoAbnGrL3Lrnux2nfeEcajXmEsJKjYYTpBw=;
        b=OZ2umEZCxr3kWCB39b+ZV4GWR25e7/PclLcezGIpdR8rv3lPUicPvc9Zl7cfNoELpe
         o0Et1GV4Hr0xSGSo+j9U6aBIT5mfodRrZjdeJtsG3omWWoSihigEfIUR9qQI2oZcMBLf
         Ujh6xDJI9M7mw4xtO5c/ThCtZ1OSBA9PJtZ3owgluYewgqn8ZbXiceP4zBssTyvS+ST0
         7ciGrUWXdBXF3GJ+UROVIu1c4tZNYqWCmdER0VwxgD1/a7Ctmpa9Q/xygCJf1kBae9IE
         65VcFK7Ptcid+e6S3bpqtu54LTzFKbkqOER9CVrMpl47InVcawIDc7SEEJaFzIYJ7EfG
         WeuQ==
X-Forwarded-Encrypted: i=1; AJvYcCUQa0dO1pZOMNplYMDI/3lqWD/og9Iw0SEoAJEyATXiV9eFk0Zty9w9v0f0BFZuTuclaxqQ/HHJZx8k/5PsfUqdlbdwzUUA7JSopNNgbr8=
X-Gm-Message-State: AOJu0Yw3o1CD+W285n6TtiC11u2eAhi+pS7M/C7gyox/FinhDdmS/OnN
	WOVs3HR4dacNEvr2zuaoPXVl7+X5Q37mWvLgwHQkRhwT9wG0wMwv
X-Google-Smtp-Source: AGHT+IFX3VNb9DzZwEsNo6n00jE6XoCmwTrIEsgdiT/IQPOuxs2Yd3q63We9EiLndllbslH7oed4kg==
X-Received: by 2002:a2e:22c4:0:b0:2d4:92d8:920f with SMTP id i187-20020a2e22c4000000b002d492d8920fmr6497104lji.33.1711443111483;
        Tue, 26 Mar 2024 01:51:51 -0700 (PDT)
Received: from localhost (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id u2-20020a05600c138200b004146bcdde06sm10965720wmf.6.2024.03.26.01.51.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Mar 2024 01:51:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 26 Mar 2024 09:51:50 +0100
Message-Id: <D03JY73HKNJ3.2IV95NSJ4PCZS@gmail.com>
Subject: Re: [PATCH v12] Add JSON output options to 'iw' for scan results
From: "Nicolas Escande" <nico.escande@gmail.com>
To: "Johannes Berg" <johannes@sipsolutions.net>, "Isaev Ruslan"
 <legale.legale@gmail.com>, <linux-wireless@vger.kernel.org>
X-Mailer: aerc 0.15.2
References: <206d1b47b7ece7ccd1c371d23ae1f1c6.legale.legale@gmail.com>
 <f3ab160dd84e936134c6aa60e2f6d0fcf4d61e4c.camel@sipsolutions.net>
In-Reply-To: <f3ab160dd84e936134c6aa60e2f6d0fcf4d61e4c.camel@sipsolutions.net>

On Mon Mar 25, 2024 at 5:32 PM CET, Johannes Berg wrote:
[...]
>
> And that stuff is a really pointless output in JSON, for JSON it'd be
> much more useful to output an object with actual (integer) values, and a
> flag to indicate 'basic', or something.
>
> Anyway ... I think you're hyper-focused on exactly the wrong thing.
>
> Arguably, for scan results, the right thing to do would be to just
> output the raw elements in the JSON, and not do any of this parsing.
> Then you can use your favourite parsing library (dpkt? tshark? ...) to
> actually understand the data there. We really don't need to expose the
> element parsing logic of iw, especially not in a bad way like this.
>
> Also, outputting the *string* data in a machine-readable format like you
> do now has very little value, and yet it ties us to a specific output
> format that we'd probably have to consider stable. Bad idea.
>
> So I guess I'm saying yhou should abandon this line of changes in this
> code entirely.
>
> Much more interesting, IMHO, would be to focus in pretty much anything
> _else_ in the iw code, e.g. the output of 'iw dev', 'iw wlan0 info',
> statistics, etc. Maybe 'iw list' and similar too.
>
> Although I suspect that what we really need is better access for tools
> from nl80211. Maybe the "JSON" output format should just dump the raw
> nl80211 message attributes that are involved, or something.
>

+ 1 on this one. The whole goal of json is to be machine readable, it shoul=
d not
be just be the same output as iw (which is text/user readable) but with jso=
n
syntax / separators insted of \n & \t

> johannes


