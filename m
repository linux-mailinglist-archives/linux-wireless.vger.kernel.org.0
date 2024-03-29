Return-Path: <linux-wireless+bounces-5521-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0408B8911F2
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Mar 2024 04:25:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B31FB28B64F
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Mar 2024 03:25:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AF5A37165;
	Fri, 29 Mar 2024 03:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SqCSLKCA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA1DA33CC4
	for <linux-wireless@vger.kernel.org>; Fri, 29 Mar 2024 03:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711682699; cv=none; b=n5QmU4z04bDW4exjWo5JbmJOMsmLqgDo+/PjeD1m8l3s4D9sHCTMN5KVlVSJ4U2VsYx/YATnABwlEOKVEepSWqQztiqET6tAKJOeREjAUdSzCtffYuq0yi/HuaoX6gkEUntNTBJgkgZ/X/EXFQUGbuZbXc3JetccAWSL+OSDMjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711682699; c=relaxed/simple;
	bh=rhkFBuy+oFu5smncVQWKBqaJ/075Re1Jo45E531SXbs=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=SuDwF6dQ/TjH5ndHP7IBaUAOv9gOKmebsqQdOJLRLxR43P4nXxEDiblTjDS/Fv1c06OuBSkxYjwbPAdwg3a+yILMSJECytgLLuhf1BtHhR6qWDQskp2ZuJ9BMg80oMJWO5KYpSvxEFeqkK7jc4Y6x0MkjKkpJvbMkZt9JI6OEQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SqCSLKCA; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6e7425a6714so1416780b3a.0
        for <linux-wireless@vger.kernel.org>; Thu, 28 Mar 2024 20:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711682697; x=1712287497; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rhkFBuy+oFu5smncVQWKBqaJ/075Re1Jo45E531SXbs=;
        b=SqCSLKCAVA/OkPSUCfAgb/pQ6Tdl5bdE0o3oyIydm/nsvDyUklO7f25NA2G1jBMkqE
         tmoyEsjvuJ95WpiFLmP5JorKgNKgRkx14hUu8hhZeTtkUSHTcWg3VGc98XpAuZ1p/a1d
         yH4HhunwQWGViJetoEUvJqzTcveIPlf2wsMD8rPUpjBg98SAPsa0aTrjiHawwnv3gYnG
         NuVvoR67uPQRqnhgE3P0oRt21S37xLnnrutZ91yZ3haFDd25r+lVy7O4a2VDJPnAuLc4
         mihQbw3+SpsLyXibmdnKk5Y6jDUfY6Woh2NkSKugZC10WcUY6y2vnDigJNKOAbXIMEJi
         KM1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711682697; x=1712287497;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rhkFBuy+oFu5smncVQWKBqaJ/075Re1Jo45E531SXbs=;
        b=O2Lg0Cks4eyr0pt4kHqUp83oCsDdkaY36Dv1/eU7zXIjhM+mjOH+oymShJBq035pOu
         Nl1WJ69E/WMTVxwuS2RNK22sDzeCuGPqh0zJY3tLKC3a8hZwPXyS4IWdKzS6gs0P2Ee1
         aVxBVfHiVOtlBPtGkn1LnisLlI83MhKMVo5hdEtUfJY2EC1/OeNZyd26l12IqJPHEn5h
         K7bOmCrwfgk26cdbN2MhuenJL6xggtPPRn51DV1lFzoWVqjzG34IX8gtFBALEW/1U6TJ
         cq1qgj2kwIWMiQdJrApTX1MLp7D+K1ELp5NqjQPakfkf5iVHrjKlp5pJcsg2VR/vu4Vt
         YtdQ==
X-Gm-Message-State: AOJu0YxtujoG68Cvn+JqDuQUgw9oFrBm/Ddu9bbKFB0zMV1+BO0Q683J
	LgDzQptEwja1HA4UUx9YmuI+xb1jp47Lhn/uHPJcfK4AktNpnUXDc1OeIG58
X-Google-Smtp-Source: AGHT+IEEgOhqOOj5Ynr0ipIzu6fWUZK2FiRDnyF7eHVoEbFVg8GMALqle8Fnzd69TUMKlwzWpO1q+w==
X-Received: by 2002:a05:6a00:3a23:b0:6e9:74d7:7092 with SMTP id fj35-20020a056a003a2300b006e974d77092mr1334588pfb.24.1711682696689;
        Thu, 28 Mar 2024 20:24:56 -0700 (PDT)
Received: from smtpclient.apple ([159.196.169.81])
        by smtp.gmail.com with ESMTPSA id z25-20020a656659000000b005e47afd5c5dsm1798388pgv.37.2024.03.28.20.24.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Mar 2024 20:24:56 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.500.171.1.1\))
Subject: Re: [PATCH] wifi: mac80211: ensure beacon is non-S1G prior to
 extracting the beacon timestamp field
From: Richard Kinder <richard.kinder@gmail.com>
In-Reply-To: <3009b152cd9f95065860d2de6b7ff8ee5775e579.camel@sipsolutions.net>
Date: Fri, 29 Mar 2024 14:24:42 +1100
Cc: linux-wireless@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <2E32B9D8-F9BC-4ADE-A501-9B9E3D0E75FF@gmail.com>
References: <20240328005725.85355-1-richard.kinder@gmail.com>
 <3009b152cd9f95065860d2de6b7ff8ee5775e579.camel@sipsolutions.net>
To: Johannes Berg <johannes@sipsolutions.net>
X-Mailer: Apple Mail (2.3774.500.171.1.1)



> On 29 Mar 2024, at 5:28=E2=80=AFAM, Johannes Berg =
<johannes@sipsolutions.net> wrote:
>=20
> On Thu, 2024-03-28 at 11:57 +1100, Richard Kinder wrote:
>> Logic inside ieee80211_rx_mgmt_beacon accesses the
>> mgmt->u.beacon.timestamp field without first checking whether the =
beacon
>> received is non-S1G format.
>>=20
>> Fix the problem by checking the beacon is non-S1G format to avoid =
access
>> of the mgmt->u.beacon.timestamp field.
>=20
> Huh, how did that end up being a problem, since iwlmvm with older
> devices is the only driver using that flag, and it doesn't support =
S1G?
>=20
> It's still correct, but it shouldn't be a problem now?
>=20
> johannes

Hi Johannes,

Thanks for the quick reply, much appreciated.

The motivation behind the patch was that a similar pattern is shown in =
lines
6315-6316: the same flag is checked along with !ieee80211_is_s1g_beacon.

If it is guaranteed that an interface running at non-S1G frequencies =
cannot
receive an S1G formatted frame at this point in the receive path, then =
the check
for is_s1g_beacon can be removed. However, could a malicious actor form =
an
S1G formatted frame with appropriate MAC addresses and trigger this path =
on
the older iwlmvm devices?

Regards,
Richard=

