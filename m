Return-Path: <linux-wireless+bounces-29632-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BC01CB29E3
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Dec 2025 10:59:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 25C3E3022F10
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Dec 2025 09:59:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49986223DF6;
	Wed, 10 Dec 2025 09:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="bGN3Yd92"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC53A1FA15E
	for <linux-wireless@vger.kernel.org>; Wed, 10 Dec 2025 09:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765360742; cv=none; b=hz76d77wEEC87Qez9e3vyeM1h/UzbLJ+QpAFSTSlfLN17w7puOuOq3R0EnaQUpqt0w/SigF72iHgx/dzMspQ8YJK2lXEK5ZKHYVF8O/Na6wKqjvaQ56d97+Q//sYLHQyVz3Z0CN0sdAK9gZZD8iF84gEMtZ5LGKFwnfue4NVHac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765360742; c=relaxed/simple;
	bh=59Mig0z9xry4gLw/DldHPsViH9PReMTmOj/9Y5QlBjs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Kn596yrF28jH5EhPxGN6C7N163tBz0PJg3AWo+69oTEMZW5zyBrQnabkY9wxWNPSgFGBoY2dF/m3YfNNo1n0VIzO6fYvwo8gn6tlZQWyMLlPefin3959jYMyWFgNhfloc8omtCTx5EVCyrjGkeiQZIUy5Yvh2s7/FQTnIfdB5I8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=bGN3Yd92; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-598efcf3a89so311707e87.1
        for <linux-wireless@vger.kernel.org>; Wed, 10 Dec 2025 01:58:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1765360738; x=1765965538; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=59Mig0z9xry4gLw/DldHPsViH9PReMTmOj/9Y5QlBjs=;
        b=bGN3Yd92J4bvyXCe6Ptq7T/DtZzoWAUf3GMsIab9jPhdbFrtXfliT7lvU136THVSl6
         9wFtMjwF/HeJ6foxUbb+cXgSWaaQVOX4Vs60+Ww1+ALc6dC8OIxd0PS7zUtKhcjYk5mk
         koEqPybXCczJDsrNUCIBhaUQBA4rwcoIe+j0Zn42f1pviYG+v5guZz3fVO7pd47wWcxp
         DngB8LiqT7d80ujGFZRQ0UIlcuhMXsitC7ZYRGr7QmqPaQfXj+bXHKVDDnWdGZEAzkQi
         ycXnAgAMo9iqjRe3Qp0orcNXyBUMZMXgah9+Z2OOAQBXxU5Tpj06ROH0MIWbgdMHvWos
         5oXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765360738; x=1765965538;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=59Mig0z9xry4gLw/DldHPsViH9PReMTmOj/9Y5QlBjs=;
        b=lUelNCYRF9NJqrBlO2X4GSVhqSnOQLabG28gqXbcF3qcO9brqnvfaaMOaipfmrHWJx
         /lXBtFq8SV/3kUHUZed7oREn1i5EN/GR7ymkene/XHUWoPQuvcWnnUT1ICdmkkQMtKsb
         FNkAR1rHkXVyBBluiij8HWeRBzugkK8CUy31VDALVpJhPe1ZZVlkeX4wKCdlTkFdTYZL
         GJr8oUnbdemJKab7hgLSq2PtnoxR4SCoBBAU1BJfoOzD2koYsHM6t4UhLBvwZPG/bRv1
         q87r8V3T72DIOvq0SQ2IyE1vtWcbyc5KdDdAXAUXpDqFrlpHWLnznqLACMUDaj9lFUzc
         hk8g==
X-Forwarded-Encrypted: i=1; AJvYcCXfc1O1xEhi7ZguLtgm7AwOE0ZVjPcxczsGufwv1L7O5NVczJlIcwo9LD+aSjntSPQNdkeM4Q7LGKCChmP3Dg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yym2p8kUtEi9D3eJUoOItwS6xMlgL4bNP0VSHNj5NRGtG4mLRBN
	uRA6GME8xBwJzDGZ4N4z6oXmN/euOQPt8a+73WdcFd2IQyJrbouKslZzE39YHSc18qwIhSS2t5H
	w4/QQNA2wxONwyohUJ/xPMSZs0ud2TUH8Y6Ysfm07vg==
X-Gm-Gg: AY/fxX6eW8+vUGu/DeAF6QORqiuy6DjO38b8wEydUzBoCkQgk0ecTkYLUZkaOwzMq/o
	JDNojB72Ek+/HZpAP2ZmwEarsapwQ6kTsbb97n5M67lKqFhdn2DYeQLo4xhFmzjgIhEGFuK/KOZ
	gHoD54d/JUSXam0STclR0fKuFyfM05Hxz6dTwv0SgXOoWxG+VAFSpGSQ1chDhO9NC2UOXQikmUu
	6nESRPov8iDwJY5W56ikKf6yA57K0YrhYeilpeaIjl0NtgEfBIzzkM3cZeZ80f5khAz3Y5GRz/K
	Vf5WaA+L3A1OrvJYVEKEdk9WJ76p
X-Google-Smtp-Source: AGHT+IGoJnaQHZdYXVnhZ7hWrUX2EK21hpXju9nycXCruk4rys6VvmH66nVPm2dRPpqDbDMTvP6xaR2QVkJO10lCVzc=
X-Received: by 2002:a05:6512:3d10:b0:597:dd9b:d446 with SMTP id
 2adb3069b0e04-598ee472e72mr698646e87.14.1765360737962; Wed, 10 Dec 2025
 01:58:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <d57efe48-b8ff-4bf1-942c-7e808535eda6@gmail.com>
 <dcf31afec1614ce0b5e6c6d7f8cd2cb9@realtek.com> <CAAofZF4Z=O=q96RaTUKFpXiLGEYU84JB+oqfWtTc2njHGgC2Ww@mail.gmail.com>
 <eaef2ed2c7814a5a8fcbea90cce88ea8@realtek.com>
In-Reply-To: <eaef2ed2c7814a5a8fcbea90cce88ea8@realtek.com>
From: Marco Crivellari <marco.crivellari@suse.com>
Date: Wed, 10 Dec 2025 10:58:46 +0100
X-Gm-Features: AQt7F2pri9au_m5sg6mis-Lwce1G-eFlYPs5q2CcnKIRS10zYIzSbb5wr8IeeZo
Message-ID: <CAAofZF5bBQ8ASFhPg6gGd0tVu8nSk07xja+9YWX7af3GMhZyxA@mail.gmail.com>
Subject: Re: [PATCH rtw-next] Revert "wifi: rtw88: add WQ_UNBOUND to
 alloc_workqueue users"
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: Bitterblue Smith <rtl8821cerfe2@gmail.com>, 
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Dec 10, 2025 at 1:17=E2=80=AFAM Ping-Ke Shih <pkshih@realtek.com> w=
rote:
> I think v1 is ok, so I re-open v1 [1], and plan to merge this in -next cy=
cle.
>
> [1] https://patchwork.kernel.org/project/linux-wireless/patch/20251113160=
605.381777-3-marco.crivellari@suse.com/

Sounds good!

> Please prepare another patch for this.

Sure, I will!

Thank you!

--=20

Marco Crivellari

L3 Support Engineer, Technology & Product

