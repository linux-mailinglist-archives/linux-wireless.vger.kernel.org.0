Return-Path: <linux-wireless+bounces-18703-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D00EA2ECCF
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Feb 2025 13:48:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B6571622D7
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Feb 2025 12:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 744E1C2FD;
	Mon, 10 Feb 2025 12:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XW2NZvEL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3B5A1EF0A5
	for <linux-wireless@vger.kernel.org>; Mon, 10 Feb 2025 12:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739191680; cv=none; b=PdMGBTBFvN/e+rhn1xjpCShl1uTCDnLDpDoMSUPZ54ctxyMTt5tzME5xoaOKC1wgRBLPq5twKI35AbWlIOXDeK6HT1Bx3X4jfJa3I+aQVHjGntdodeKFcG0jbuIo3Y7vNTcGshxOes52iVfqSObV5icz3y8VmYfkSKSG2gmenGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739191680; c=relaxed/simple;
	bh=sw4GIsTupaH+lw8i0Nwr5L7XDu0thVQ7gAEmZQ0sbUg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R+PHKVgKmXgByDfdgDCuvTqzugPPiT+bUPxfzip/wo+MdUj5nbUAhI8uFSPY5yuLUA+QGrluvEmPgXlCh83sZ/vSQ5PNkyzdBL6MqKb7sFTK7+BdCkHFKOdE5Ow8gc7DSsB3i0YC8hFyslkBmxF/fJ1lm5wDxT171mSnuysCqYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XW2NZvEL; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e5b29779d74so3760038276.2
        for <linux-wireless@vger.kernel.org>; Mon, 10 Feb 2025 04:47:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739191677; x=1739796477; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sw4GIsTupaH+lw8i0Nwr5L7XDu0thVQ7gAEmZQ0sbUg=;
        b=XW2NZvELK3nafMCZYyGljgtFyVaL7MfvrJaBpzjr0DFZgKQelZK8XeIcGe5HmD+zN8
         mfI0YMyhK3Wszt/A8a1dPJMYClfEzoxERiSrKc5oAvANC/lUV0exx5waUzVjNSUazaws
         0Ur/fKursEr0rXzdzhJYJHBm8K5RgvJ28aTNp+n6NrgysF7PFB7Q9GV9yHUIpWrtTDYQ
         42R9kHwQyt8H7213v/1Yf4ZMLLEqxaFRcoMyb3liQZhmifZmp1CF6is++EXzeWYXZsTN
         Qm5hAhZ/yaOxpTJwD+JtXlAOxE0tOjNv/FdT+L2JMzxwU52a1Z5ULKeQIR8at7+ffpDs
         IopQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739191677; x=1739796477;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sw4GIsTupaH+lw8i0Nwr5L7XDu0thVQ7gAEmZQ0sbUg=;
        b=ISc0g81W8Gx0+jVXkxlYrQsmCeEzNv1uJW3uC8IPnHOsDjaIIDD4MImvckc99/esrK
         VMr/xt/TjgCNtDTxGeEeWC/StsehtA8vLQ5dyXBe3/LqLuKojCY1BGqNwBM9vy9n9SwP
         9bIxd9G2PLgOWWI2eojs7jZ5817LS1VrryH1WIPLUK4dMkPj3g4Pfm5BQ+pnTcIEfWbW
         5jxb+pLDDwYxIs3HL2RCWy0A6ehi3ijcF1uOL8VwSRvLIvRpIc6bITmUhsDh27Gbgnd/
         klBFGTSXxTCsaJ5a3u/vZiI2eG0PHHZYX+/0xIxIjM4Hv7tz1z/e3aupGn6ARvX6IAvg
         N+HQ==
X-Gm-Message-State: AOJu0Yx4Omdfp8hC5BXvniojc02S6P1JJBvx+IetXfPdXh+MXJgS6QPq
	cRywtG6QC2sDqt6MIaliZ96ERzXi+TXcwtvXqvu6w0TigGsav4WbyMyEj+M0O3oKKkN+S0OX+yr
	4bf98xfBFNcfFVdatMrJSNNpwUl9p79pmo5SUYcZ5iRyA40tTVSY=
X-Gm-Gg: ASbGncsEaLOA8xhkBWPTu7s5vyr2aPFSVyk8Ux3RMyswvXg1II8meAf5n9YGcz/3aj8
	pJ6DeujeqClrJKo1KplaZAghKu97MO+2v04NW/ppfQHjG6ym2hj+PrUtpYzlBP+Rl4/AMb19GuQ
	==
X-Google-Smtp-Source: AGHT+IHCARCr3W2dsFBPoy0teQ9rJvEN+LQ+nr51lkt6u9aAaTFigHQA3uE9MDY3wAtkCUkPpWDJGs8q+V4NX86c+fw=
X-Received: by 2002:a05:690c:9989:b0:6ef:6a71:aa55 with SMTP id
 00721157ae682-6f9b2345b63mr118817667b3.0.1739191677606; Mon, 10 Feb 2025
 04:47:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cd1b13d4-b01d-4237-813e-bd48c55d9ca9@matthias-proske.de>
 <CAPDyKFr=XyLg2VjuEq1ZTrdAwSJJmYFDn9wSFj4zWD1+ZB9MTQ@mail.gmail.com>
 <6aa67bad-5712-441e-a24b-f787474472bb@matthias-proske.de> <CAPDyKFooyDSPu7RG18sp9cV1ndRPpg5yia1BAiqtb-c3cOqv5Q@mail.gmail.com>
 <efb9b9b7-bf56-4b3f-87eb-afd356453e62@matthias-proske.de>
In-Reply-To: <efb9b9b7-bf56-4b3f-87eb-afd356453e62@matthias-proske.de>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 10 Feb 2025 13:47:20 +0100
X-Gm-Features: AWEUYZkEspBPxh6Dm0nzMsm9DEgeqY_Rih6Dn3IzNI5XKW2fr4WXaZ5Q7HUECLM
Message-ID: <CAPDyKFqH+YHu-uxmTN_LJi7Q2DjcRLx2WBu6-hKsaz+3T0L+iQ@mail.gmail.com>
Subject: Re: DT property keep-power-in-suspend and how WiFi drivers use it
To: Matthias Proske <email@matthias-proske.de>
Cc: linux-wireless@vger.kernel.org, brcm80211@lists.linux.dev, 
	brcm80211-dev-list.pdl@broadcom.com, linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

[...]

> >>>
> >>> The corresponding SDIO func-driver may call
> >>> sdio_set_host_pm_flags(func, MMC_PM_KEEP_POWER). In this way, the mmc
> >>> core will leave the SDIO card powered-on during system suspend.
> >>> Although, unless it's really necessary, it's ofcourse a bad idea as it
> >>> would mean wasting energy when the system is suspended.
> >>
> >> Just to get my understanding right: The brcm_fmac driver would be the
> >> SDIO func-driver in my case, right?
> >
> > Correct. The one that is registered with sdio_register_driver().
>
> I guess I would just write a patch for the corresponding SDIO
> func-driver, adding a DeviceTree property directly in that SDIO
> func-driver (not the mmc host driver) so this can be enabled just for
> these specific boards, or would you suggest a different solution?

Right, a DT property indicating that we can't power-cycle the SDIO
card is probably the correct way.

We have a bunch of properties already in the host's node related to
this, so adding another one there should be fine too, I think.
Otherwise, an SDIO func device may be described in a child-node of the
mmc host's node (see
Documentation/devicetree/bindings/mmc/mmc-controller-common.yaml).

Kind regards
Uffe

