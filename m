Return-Path: <linux-wireless+bounces-24607-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A7FFAEB01F
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Jun 2025 09:32:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 732AC4A7823
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Jun 2025 07:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1AB4224AE0;
	Fri, 27 Jun 2025 07:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HaSfYuhl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AE9D3C2F
	for <linux-wireless@vger.kernel.org>; Fri, 27 Jun 2025 07:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751009510; cv=none; b=nykypwgPeepw8WoMLqZt9hdlk8abJkBhJPmQMk1NUbzdpiORgKouTnvz0GyZNxhHu6KFG+mGTnmM18vhOHQ3C93RA9fA90l83vhMpIRAqKcUpzFYbvghRnmP7RSVjWApQPO+ubzNsdDCG0G5yFJQK9faqm8Lk5937Y6oeo/fwa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751009510; c=relaxed/simple;
	bh=sn0WeSM24B/vzlgYYF7p/UbB3vjcQLKlmQkOWEDTPa8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=UeBB4hnRzpP8X/iT69z5EaJcSTFH0dXIBmK/jt0XrytkgSTohCtm70hLaZD8pUsIwIp7DMFCEvxBQ5bMxsWOYFV+OV+cOV9L7kdRs+qGEmaZCjBcU1O7oUcDFf9yL1LmjTrarUdFGQ42vJFpF+73REiZTiFPdCMVsi7AIHdxdWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HaSfYuhl; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-451e2f0d9c2so12544445e9.1
        for <linux-wireless@vger.kernel.org>; Fri, 27 Jun 2025 00:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751009508; x=1751614308; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sn0WeSM24B/vzlgYYF7p/UbB3vjcQLKlmQkOWEDTPa8=;
        b=HaSfYuhl7m7v7RMJ+fSQtK+59IszPRdwBORbcmj/xAGjiTdbZoGm9Q6/RNojNPuApn
         8bmSBHrgkIwbhxdhl4c4pMslPk4JXMFCgtX98vIEn7g1Q+BbRTQq6oHXh/VOm1YMtNY6
         JaU0fs2+mxaWn0P3DjS8rk/CSB0Et1tvWstYF1B92Z6WDza/mLKbEk8oPiYWFVdIo/yy
         aNBd3qdbTgB34lG4GKsYTW8iJGTAw4mN9II8WMu0Gux6MpTjV9gRt4z1GBp9Kv3kBmP4
         /zHGIU+PGhQGeenkbslLuLvZvk/0ZUh6oMyKsDniuLU9MUEOV+t2MOHJFMBI1gWSqP7I
         ZgiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751009508; x=1751614308;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=sn0WeSM24B/vzlgYYF7p/UbB3vjcQLKlmQkOWEDTPa8=;
        b=jSZgCvlMKsbNIVNHlCozwag6MkwzEOcm5hZgLkG8jIsv7khYMvBzWfR0sASuUO6ZFK
         kcZARIgzKCzcONe7Yq9xhjo48Gkaqh9/JoBk5BoRGJ9+jm17yWLf066w3NNucKNHnhzq
         UisMoa7Qz4QZLGvyFjh3gvtmjMPNR9lngqBcytAO5y64LjuPwpsYmB521in1bL6vBahR
         IJmnYTQ/0G904cHc0OhbCTf3a3N4C1LSbggjIQKrQGJCQmiZwCjytD5oUfB8sBh3qFyK
         WHm4weMoE+EiwMsPymarw0baTq81SsxoPrOX4JzyV+vb2Ir2l+m654z4bMVwjkv9hC+P
         Pmmg==
X-Gm-Message-State: AOJu0YxEi05tRKpOQdz+HR00A4I28Fx8dQgy+CHI8+WCWvaTJdtjFNJQ
	GZcK4u4hTfUIG9JAcHDY141JKxyYk828lFgvDVibOhWjOPGHu8nJefyTLLGlbw==
X-Gm-Gg: ASbGnctoukzUbT8ZaE4TjXhfXo00PdnxabJoX6fqWzsOSMo+mgkLFxlk/o9cffvWYtu
	Ctj6hXlOKbHjKIVxe19A2W7BbWn6nAJynazcXx1IP9wT0FvomPE/3TX3tX7TUKmLz5xoiIZZoHR
	oLqMuA4fKPQbnG+IdrGQL/frqhcNb9GDm1/y2ymAOLF5KUuiXdO2HgM/td0C/u19RW4Dzj7lOBB
	pV7sOiCG/sFBtZHvMzJiY1ok7XWo4LUTHjWeQRbpYXXF7QAMFYvESrVgznIFdh6NgPjjehi/y2c
	ds7rGka8FiVk0xlSypwX6hkpQ0A9657IF6/6SJ5QxM/YE8pqhYAPqNFOsFA56RXUMOO43DQn6H0
	7898fMGwfYuCAfKQ=
X-Google-Smtp-Source: AGHT+IH0LyLYrdKmf3DPLsDNklPgmfuPw+5P0zql/CEgTDuwp2yhva7iCbZKj/XeODsOzg7JnSm5Xw==
X-Received: by 2002:a05:600c:1994:b0:450:d79d:3b16 with SMTP id 5b1f17b1804b1-4538f309394mr18058945e9.14.1751009507308;
        Fri, 27 Jun 2025 00:31:47 -0700 (PDT)
Received: from localhost (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-453823ba553sm70454755e9.31.2025.06.27.00.31.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Jun 2025 00:31:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 27 Jun 2025 09:31:46 +0200
Message-Id: <DAX52ECUSPW5.1P50QHZ8X2QFX@gmail.com>
Cc: <linux-wireless@vger.kernel.org>, "Steffen Moser"
 <lists@steffen-moser.de>
Subject: Re: [PATCH] Revert "ath11k: clear the keys properly via
 DISABLE_KEY"
From: "Nicolas Escande" <nico.escande@gmail.com>
To: "Vasanthakumar Thiagarajan" <quic_vthiagar@quicinc.com>,
 <ath11k@lists.infradead.org>, "Sven Eckelmann" <se@simonwunderlich.de>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a
References: <20250117191455.3395145-1-nico.escande@gmail.com>
 <20e0a239-3d23-473b-5bc8-41bc25a64088@quicinc.com>
 <D9NDQJB4VMWA.V4IPOZOIR46W@gmail.com>
 <0c166b5b-f358-1f39-4569-a1ac388033df@quicinc.com>
In-Reply-To: <0c166b5b-f358-1f39-4569-a1ac388033df@quicinc.com>

On Tue May 6, 2025 at 11:19 AM CEST, Vasanthakumar Thiagarajan wrote:
> Hi Nicolas
>
> On 5/4/2025 6:06 PM, Nicolas Escande wrote:
>> On Sat Jan 18, 2025 at 11:29 AM CET, Vasanthakumar Thiagarajan wrote:
>>> Hi Nicolas,
>>>
>>> On 1/18/2025 12:44 AM, Nicolas Escande wrote:
>>>> This reverts commit 436a4e88659842a7cf634d7cc088c8f2cc94ebf5.
>>>>
>>>> This as been reported by multiple people [0] that with this commit,
>>>> broadcast packets were not being delivered after GTK exchange.
>>>> Qualcomm seems to have a similar patch [1] confirming the issue.
>>>>
>>>
>>> This will re-open https://www.spinics.net/lists/hostap/msg08921.html
>>> reported by Sven. The recommended ath firmware ABI during GTK re-keying
>>> is SET_KEY instead of current DEL_KEY followed by SET_KEY. We are looki=
ng
>>> at other options like some marking by mac80211 for the driver to be abl=
e
>>> to identify if the received DEL_KEY is for re-keying. Also I'm curious
>>> if roaming between secure and non-secure mode is a critical use case.
>>> If not, we can probably go ahead with this revert as temporary WAR,
>>> @Sven?
>>>
>>> Vasanth
>>=20
>> Hello,
>>=20
>> Any news on this ?
>> I would hate for this to sink into oblivion once again given how hard th=
is
>> affects end users when it does hit.
>
> We are working on a driver change w/o reverting the commit, we'll share
> the patch once complete.
>
> Vasanth

Hello,

I might be mistaken but I did not see anything posted for that yet, right ?

Thanks

