Return-Path: <linux-wireless+bounces-24797-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A90F0AF7DF8
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Jul 2025 18:35:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A0F24823A9
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Jul 2025 16:35:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 106262550D2;
	Thu,  3 Jul 2025 16:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UY5FOgby"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E1FE158535;
	Thu,  3 Jul 2025 16:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751560536; cv=none; b=iHbFtHlUaEXMofunICr+WLBoP2i/0EcIQpqqujDLZ7Cw5zayPa01Mx8yoGuLn8Z7QoGtVctm7x34C9bmdKyMiGNgerYtEaBHs/z3mLrFqyP45/uMlTqYx2kRHf5NSyv95+ih/OaeNPMObIunpYpk7efgpYdKVyxyccJjoULr/48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751560536; c=relaxed/simple;
	bh=mitvISWYz9VXM4jc5Q04XMHY5jFnGMTPup9ISmOOkYg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gJ9jpFy10p7Iu7N+ERRQYynpSg0SEr1EHWJq7uLrOmpHIwW+aPbibqKiCZ/1vnL8VLQdbsa+CYmoCAXJYf9xrTJRR2MsP/4atkzdqvnciii+wNCJyQTM2ViKCRA50I01UuSt5Q7bpk+1NCALUZHHtT1h3PX5YoE0hhy/ZjZHG3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UY5FOgby; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-710bbd7a9e2so857b3.0;
        Thu, 03 Jul 2025 09:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751560533; x=1752165333; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=utBS017XFgzQ0zp8Wqpxes+6RofiALZItP1TdxQEbKI=;
        b=UY5FOgbyBBj+kSSZpBFIsg8aTN3KuofERMODv1/VLegb2csYRXt0QZmyRzLfYM9ApQ
         kf3XsOC52LXL/+7R3Exf40yz+UjyJjJUsVzqwOVvpbxwys0WMNVdBUgl+nqS7b8oVoiN
         20Ec8cOnP2vepiTP5KnPMLhfIKMgs52E+MH4N4KhQcyRKfex0afMq1tVN2Ld4Hc4VNe7
         tnLeFObkdai4YkbtMk1RRP04cHrXBr5lEoW5BrSIEvBmW9vFI5xw1n0amMJaMjfjxc3M
         TpbSq3/29YLU2hHWk5nmadz/sEOeN7r3PfFQxvWOVly5BN3JwzlL9/n7R3+4jO5EIEhd
         ampg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751560533; x=1752165333;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=utBS017XFgzQ0zp8Wqpxes+6RofiALZItP1TdxQEbKI=;
        b=QRzDwDWir3RHUcWtUxQC7Mz4QINvh2rQSjsBz/phYJjT08Wi+cUkd7Y6NAKbK414nU
         SW3YQ3yawxLI1+qlZ8zUWQw1ixW5bFYe35uUuumY/18KNHvnYKGb89ImaiSgCfZLmw/7
         jNK+oeSeHeMwa52ckNXIYFYZikHuhcA7/Up5UisMurmRBBQt0BCtqZheVgVbODatbtUy
         PM89DU8+8LnVtI9zTxu3CQcQIseYqQcZ6vD0ahwj2kx3S7YpoAFTS55MppokmYdwuQhi
         pHJjFkBe7XDYWK064pzdXY0gGr2/3T/IcDrOYoVoGIId7kkg8MZaSu04kpjrgbBs9CXR
         iivg==
X-Forwarded-Encrypted: i=1; AJvYcCUGIwfUbeWwol2SPRIo21a55i02R8g4zrvirM7m9VAiW0mMXAkpTSevEdPqrIMqPMEU+QAOCyujoA/hZco=@vger.kernel.org, AJvYcCVEsw6Ebqk4kNaDmrgLgxsVPHkk7IGQ3e08DqzOVK1PM1vmY7KNFdiOlFxGfVBgpohMSLJomYoj9bin1hUHZuc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdRiKrnNwY4YxXtEFXeKgoIZutQjY+aFZvopm4dBa0gndmKPAE
	7Hh0s8U+ggFlhPO/4HhYMI/Yy9e0HcdvuE92IK+jmj0HCGuU3NqSq7HCHD4H4LkiyDRhL/RWBLy
	tV0Ex+EgsV/I7CwoMu1QjdNwTAuBgTlM=
X-Gm-Gg: ASbGncthucmBi2+6JPa7lri71tTKa8cXxRdggg9UefJKNc8zRql9wWHdQQu+w0VWpNn
	72sSal31HOuS1BwP4rAz739Bzl0fh2Sj4aIZ//Wn/mwDpQo2SrvhpJ0tUOM2J7WfRJA7mv67gnl
	z/QEMXq9byR5Og6p1w9UqFS7Xrs7M5Fdf3UWpQF115MF0lxMeyhm4cD+Vy60xIfl884xrsXjN8e
	w0=
X-Google-Smtp-Source: AGHT+IH/iyPTFqL3M3jHfprWGyO2TfoMbrPC7NbrggZ1Yo0bYJAC8QHCPeDEMdhCNBakZBK3OaY2qZtlskNgpVcnuS0=
X-Received: by 2002:a05:690c:9993:b0:70f:253d:f278 with SMTP id
 00721157ae682-7164d2d0f01mr107532887b3.15.1751560533232; Thu, 03 Jul 2025
 09:35:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250702065908.430229-2-moonhee.lee.ca@gmail.com>
 <DB29OMQH4W9Z.1GPKEZBBIRSTS@gmail.com> <CAF3JpA7wM4JBdd6OvGS+hmv0UahcW=h4HrPNDwRNhduk8iKsWw@mail.gmail.com>
 <1f13328a55c54fb49d8ca1dd72bc5de23f161ac8.camel@sipsolutions.net> <6ecced8b962cf3a6f5056a87aa3442c49941e74c.camel@sipsolutions.net>
In-Reply-To: <6ecced8b962cf3a6f5056a87aa3442c49941e74c.camel@sipsolutions.net>
From: Moonhee Lee <moonhee.lee.ca@gmail.com>
Date: Thu, 3 Jul 2025 09:35:22 -0700
X-Gm-Features: Ac12FXwg4u1q7mSzj9AU16Ms01bFVIpviQb0K31UMy7j7IsxJBZgw4Jou9gHLgw
Message-ID: <CAF3JpA7ZeG5uxLJr1NQBBzF=UZRi4sj4TSfBw=Pvx7xb1NCqTw@mail.gmail.com>
Subject: Re: [PATCH wireless-next] wifi: mac80211: reject VHT opmode for
 unsupported channel widths
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Nicolas Escande <nico.escande@gmail.com>, linux-wireless@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev, 
	syzbot+ededba317ddeca8b3f08@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"

Hi Johannes,

On Thu, Jul 3, 2025 at 8:09 AM Johannes Berg <johannes@sipsolutions.net> wrote:
>
> I'm not entirely sure that'd be correct. 320 MHz can only be used on the
> 6 GHz band, so clients must be at least HE, but I'm not sure that VHT
> opmode notification frames are completely illegal for them, even if
> they'd like use OMI instead.
>

Understood. That clarifies the case for not filtering out 320 MHz, even when a
VHT opmode notification is present.

On Thu, Jul 3, 2025 at 8:11 AM Johannes Berg <johannes@sipsolutions.net> wrote:
>
> n/m, it just did that quite explicitly. I really want to get rid of all
> that 5/10 MHz code, but we still have S1G so that might still happen
> anyway, and I expect for S1G VHT operating mode notification frames
> _are_ invalid.

To address this, I plan to reject the set of channel widths that are not valid
with VHT opmode. This includes all channel widths below 20 MHz, as well as
20 MHz without HT (20_NOHT), which is also incompatible.

Would the following logic for v2 be acceptable?

    /* reject channel widths not valid with VHT opmode */
    switch (width) {
    case NL80211_CHAN_WIDTH_5:
    case NL80211_CHAN_WIDTH_10:
    case NL80211_CHAN_WIDTH_1:
    case NL80211_CHAN_WIDTH_2:
    case NL80211_CHAN_WIDTH_4:
    case NL80211_CHAN_WIDTH_8:
    case NL80211_CHAN_WIDTH_16:
    case NL80211_CHAN_WIDTH_20_NOHT:
        return -EINVAL;
    default:
        break;
    }

This allows valid HT/VHT channel widths, including 20, 40, 80, 80+80, 160, and
320, to pass through while filtering out values that would otherwise trigger a
WARN_ON.

Best regards,
Moonhee

