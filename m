Return-Path: <linux-wireless+bounces-3613-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8332855DA2
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Feb 2024 10:17:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75FB228498C
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Feb 2024 09:17:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6538A13FFF;
	Thu, 15 Feb 2024 09:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h/TXmp3G"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD11017584
	for <linux-wireless@vger.kernel.org>; Thu, 15 Feb 2024 09:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707988655; cv=none; b=nDag+ghOFe/OWsZ0eEv2qAOjF2IY66rxFcZwFCtEzrUiU6nS+SqsVCot8ymEjutBYurDCLsH8iTiTDkywLkiYXpMVq4zATMtmGQrkpcZGqPY6YvJB21v9hqVetE719X24XC3huIdy9hMO5GqE0OVmCj1s8DKL2EMrA+pWGrBcbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707988655; c=relaxed/simple;
	bh=tT3oLKhm5Bn4BEL6TakBOhyqzgbyYpIAqgtukyH6op0=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:
	 References:In-Reply-To; b=IGLjWRAzbfo4KOuiMQpa2OESkyt12tasM7AfE/NBmX15eXivjWdpeCcFmoZh3pKgNBQCkTrxUgZfmgbTX/ITIu4mXjF3PCMG3aedN88rHj50HRsEmezIyaMDGrBCp6Fec581mhRNoTGm7fwLwdrfnM+IvZMV/pMH+mJRGs6AsNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h/TXmp3G; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-40fd72f7125so5311195e9.1
        for <linux-wireless@vger.kernel.org>; Thu, 15 Feb 2024 01:17:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707988652; x=1708593452; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tT3oLKhm5Bn4BEL6TakBOhyqzgbyYpIAqgtukyH6op0=;
        b=h/TXmp3GdAd7Kbd9J+AohohbpkD+LnsMAIAoqju3PXOdcub0lNUCHYiyLr2fllhLEs
         YE1+dl/V4YpMLmIUNWwqFBjDAGKm0rOO7ysHz+0BG48hm3RbQa6u408CvKMahPaxVU+b
         SAJ4wQ/0ZTLlxx4rbszSt33F3QoIMWnWZDFWQqvCwO2l3cTog/Jsqo/J5c1lQbIuDsa9
         yBi4wH4l2RO54mvNZUiImrBaguwkuTB1cEGIkKzT1sXE8ifTGpMwZAFNe5P0ya99j+50
         vRaFMTju5REGZn7/h3FChGI7J9WXOjgKENIi5s3fIjEHawG55MGjfljOA6jFg9TQOI2J
         v65Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707988652; x=1708593452;
        h=in-reply-to:references:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tT3oLKhm5Bn4BEL6TakBOhyqzgbyYpIAqgtukyH6op0=;
        b=Cf+z4K42kVOqbvvHMNcrlVEf+7M+pNMQ8V8WEw3ygIH9urwXDraI4qhCZ80yoQg7FO
         Fu0JdIrdCqpyXuupySiN6Y5kM52fZoI3SiXNAHKAfnJTV9vBI4WWt8YdGeBM7nrXzWv3
         95NbvhkDGFjKiAsPpvJHY45lVa2PY2IZFYetpgRfb8PZC8trzJjM4mwcxYuDaA12uuGn
         xB49Qx++dUT4CYGUQphQBMbPKlA8g9tSVmUfRuzHh4Ch4PM2IoY545QMt7MhATEiCJt3
         JsvDtZ9TDGa4BK1R2J4pFpHqHTPMrSVn7PZCJ0fGfPny6qCAXvBy8W97bU4c0lwS/4/X
         xRGQ==
X-Forwarded-Encrypted: i=1; AJvYcCWD3oc5DfVLRiULRo8RlxSUP5PG7x5NRldWmRT4jpdz48H5cmyzEcVBV8QZdS+AYIlfAenBs2Xp1LhWGKja46ajOZmCfLk8kFMT9SIH3oQ=
X-Gm-Message-State: AOJu0Yzm6GNQ3j5R8IwojMXxjOI21uHEp9P9dkGOfbofDOIdEaByQwLL
	HIFCuEUha8UegdCFmxli+5KlGZ/VMu7fVPli5jCjK/NYFiyDBxA+
X-Google-Smtp-Source: AGHT+IFvfePUjkXq9EK/I0Le9avVegh9x8GPz2ZP2dqiVxQigqMc1Tt9g+RfVNGcp0f4NB3GeKUp9Q==
X-Received: by 2002:adf:a4cc:0:b0:33c:dd02:f652 with SMTP id h12-20020adfa4cc000000b0033cdd02f652mr128863wrb.10.1707988651716;
        Thu, 15 Feb 2024 01:17:31 -0800 (PST)
Received: from localhost (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id r15-20020a5d4e4f000000b0033cf2063052sm1136979wrt.111.2024.02.15.01.17.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Feb 2024 01:17:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 15 Feb 2024 10:17:30 +0100
Message-Id: <CZ5JG26I3ZI9.25T3WOY4XM8WB@gmail.com>
Subject: Re: brcmfmac AP mode
From: "Nicolas Escande" <nico.escande@gmail.com>
To: "James Prestwood" <prestwoj@gmail.com>, "Johannes Berg"
 <johannes@sipsolutions.net>, "KeithG" <ys3al35l@gmail.com>,
 <linux-wireless@vger.kernel.org>
X-Mailer: aerc 0.15.2
References: <CAG17S_MOiC43F2wXMG-Y6nQgitZQJs18jESQJrX+aC6=MQb6ew@mail.gmail.com> <e0825627-4652-4c5a-ae29-33c270a38bc0@gmail.com> <311c594bddde32bacd45acbfa6f40fa7670e51c6.camel@sipsolutions.net> <4eda39b4-3b16-4f01-a241-50409d34ce33@gmail.com>
In-Reply-To: <4eda39b4-3b16-4f01-a241-50409d34ce33@gmail.com>

On Wed Feb 14, 2024 at 8:31 PM CET, James Prestwood wrote:

[...]

> I guess I'll also ask, what _is_ the target use case for STA + AP=20
> interfaces running concurrently? If scanning is unreliable then=20
> connecting would also be most likely? so what can you actually do here?

One very common use case of AP + STA is the multi AP setup. EasyMesh works =
that
way from what I recall. In this setup, you connect first with the STA then
create an AP on the same channel, so no scan involved when both AP & STA ar=
e up.

