Return-Path: <linux-wireless+bounces-29572-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EBA74CAB95E
	for <lists+linux-wireless@lfdr.de>; Sun, 07 Dec 2025 20:29:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BBD2F30111BA
	for <lists+linux-wireless@lfdr.de>; Sun,  7 Dec 2025 19:29:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 822312D8DCA;
	Sun,  7 Dec 2025 19:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l9/nvL03"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5CEF270552
	for <linux-wireless@vger.kernel.org>; Sun,  7 Dec 2025 19:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765135752; cv=none; b=kjF/qMCEfF+eBQjZ6hilLn5DGu9A9516LwMsZJ4f/0n6ZkyQhS4hQuOFPPqW7/XpLJVEHSruZZ8dWISZ6leurjYsYW0i5/txTwQqxmE8DOd+W1f4ztI+u6Xwr1JmgvCr0SmuDA5VRrZNrVC9D+SW3nZnmp/QEBR8JqYc2Y5jgWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765135752; c=relaxed/simple;
	bh=Opu2+OL/DwS9JbMvMpOEdTVE51EH8OVgiRsdsv9c8zI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qp1aruB8rajJGtMG9ECTfktbAmFZeUxqZVoXbxQB+2xvEEUZSJnPTiyZQytT/0gisiE7DZAFjJE5GGvljHYiBY9tfBwvWZXUA+EZ/HiiFpJ3Gr6R8LwaqKSSKljYyGQ8jUvkiE/oAyax6I+aWRDpyhPId9Vx6tdL/C9X2PhkOlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l9/nvL03; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-8823e39c581so55405046d6.3
        for <linux-wireless@vger.kernel.org>; Sun, 07 Dec 2025 11:29:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765135750; x=1765740550; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Opu2+OL/DwS9JbMvMpOEdTVE51EH8OVgiRsdsv9c8zI=;
        b=l9/nvL03OlUjc+W8pHAGIewQZ3hmxaw+QOPxfLip2V3rf8BJWOo34iNYq8+QBhWpke
         TR9rjcbXvNtbeEixSuhR0a8gdbRPPg0TcOjdPxTfm/hsLZsC/IDfQxYwl+41LniKd/x/
         d0OtEbhJ8HyqxJCZ1Bsi0pb0ow+dNyafzOqB0bU9edgmsnN22rEHvvCtt8q7AAzTiupD
         ivZLmusT/n2iDiIfZhM5IJ4+nSRdVVQ2UrPsUkQ20HDw1dQljH61yT9pSMkaR8NGQyBU
         TOPn4fSrjMfbyrsFehKCcudazqMYAWUurTrCR5OxwPA3pUwYJdWvITl/nWKJaAw/5mKr
         UM1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765135750; x=1765740550;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Opu2+OL/DwS9JbMvMpOEdTVE51EH8OVgiRsdsv9c8zI=;
        b=DmoylLMoZfwZ1kryrFcDkNDO4qqg/SvyyIPZ6VkrCySJetDmBW0FN7B1esx1MTEj/2
         RyWz49+0DSH/fKVcoAG8H/7sZP1XIrs2qWQpgzuMhgovCyCSitBj9VWJCQF1jrjRiE0V
         oJMLI3joK2CqDLQqdrd8uMWkIGR7km2XbzIzIeF2h1nMmRx0f19M8c8Z3JcBL2xFfc4d
         Qudmro5AwJYrkNJK6hbo2+0VGso3iiWzXSKr9qJyAScyd/OoD8l4Qchrcb2Djr99fxge
         WPQfMbISCALzfY5UHmIl8+EiIm88gN4Gp6oir4In25JOEd4RSdoP4bsAI3/O4awS89NZ
         zJLA==
X-Forwarded-Encrypted: i=1; AJvYcCXAN93cOVEFcFiLgjNviaj6oD6oPUkwxqIhj04p1XtLO7axUu+ZK0OtbRPthI2hIa8IMMVyPtr+E8dFUK2Jnw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzKyc8bwGOor6tkgAOMNcS444P+41kvOuAvyCgf9QeMDTHCMGQ9
	uy0wSv9tu8hoMjbmKkAHCGD1Ow3z5U4qwQT/a8SBT/A4DP8whp9SwYxqcG5NPc7EFkY2TMJaW1i
	uLxIs7a11K2UB5mcuavU91y2YSlzOYg==
X-Gm-Gg: ASbGncsv5SAJAJTtydproOOCPRW+Nlg8r3zOKZa+MqaMOjJ8CbB7dn4zPMY59cs8hca
	MjRzuB3tcVwuDDHXj2wa90nAYZPcRzXGj5PUnKVPrcHp6VV37qZto3+mD2WiaywJj+IEEhLsIbz
	T9RyGJiwBQo8e4LcENQApRUfTdcX2CLQGkiXvz8UbHXmLax9BnDxKbucuCCf6Z9JkrZPT6Jt7WH
	7aJ8xHMT7ospTGPpCQOUuHi/Bc6Mr21tEqw/Iv9oWZOb9b3rwtfk3Bskf4ONxfVT59zcPg+z/EE
	1FuhieyXws9RhHjJVVbtvlMO7R0=
X-Google-Smtp-Source: AGHT+IHjR3mLmPnj9fRaa7D59Q5OP/l7CbN+/RdhM+PjFVUL8+kj6fWBqmoyD4tFOMFEsNhTEVep7TjIbtGOzuXKODA=
X-Received: by 2002:ad4:5ba5:0:b0:880:4ec0:417a with SMTP id
 6a1803df08f44-8883dc4c363mr100694556d6.55.1765135749856; Sun, 07 Dec 2025
 11:29:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251201011457.17422-1-daleyo@gmail.com> <20251201011457.17422-7-daleyo@gmail.com>
 <7ea43ef2-b453-46cf-a35e-ea11ca1dbe24@kernel.org>
In-Reply-To: <7ea43ef2-b453-46cf-a35e-ea11ca1dbe24@kernel.org>
From: =?UTF-8?B?SsOpcsO0bWUgZGUgQnJldGFnbmU=?= <jerome.debretagne@gmail.com>
Date: Sun, 7 Dec 2025 20:28:33 +0100
X-Gm-Features: AQt7F2oFhC8Mb-l4_CfaR4BEBfSn1QIKcrxVG9maohU2gcvVq5WClxflVEf0V1E
Message-ID: <CA+kEDGEjR7cGA0zZfuKkYg37mJZs3Fn7eKbgkB6hdjDLtGxjRQ@mail.gmail.com>
Subject: Re: [PATCH v2 6/8] dt-bindings: wireless: ath12k: Add disable-rfkill property
To: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>, 
	Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Dale Whinham <daleyo@gmail.com>, Johannes Berg <johannes@sipsolutions.net>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jeff Johnson <jjohnson@kernel.org>, Jeff Johnson <jeff.johnson@oss.qualcomm.com>, 
	linux-wireless@vger.kernel.org, devicetree@vger.kernel.org, 
	ath12k@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le lun. 1 d=C3=A9c. 2025 =C3=A0 08:34, Krzysztof Kozlowski <krzk@kernel.org=
> a =C3=A9crit :
>
> On 01/12/2025 02:14, Dale Whinham wrote:
> > From: J=C3=A9r=C3=B4me de Bretagne <jerome.debretagne@gmail.com>
> >
> > rfkill should be disabled according to the Surface Pro 11's DSDT.
> >
> > https://lore.kernel.org/all/20250113074810.29729-3-quic_lingbok@quicinc=
.com/
> > has added support to read the ACPI bitflag when ACPI is supported.
>
> It wasn't merged. If it was, reference commits, not random emails.

Good catch, It was merged in commit c6a7c0b09d5f, we will reference
this commit instead.

> > Document the disable-rfkill property to expose one specific feature
> > (DISABLE_RFKILL_BIT) for devices described with a DT, so that the
> > feature can be disabled.
>
> This is just a circular logic. Add property to have property in DT so
> that you can use feature.
>
> No, describe the hardware or actual problem instead.

Point taken. Would something like the following be better?

"For some devices, Wi-Fi is entirely hard blocked by default making
the Wi-Fi radio unusable, except if rfkill is disabled as described
by an ACPI bitflag on those models. Add the disable-rfkill property
to expose the DISABLE_RFKILL_BIT feature for devices described
by a devicetree."

> You still need to answer Rob's questions.

Indeed, we didn't answer another question, sorry. Here it is for
reference:

> [Rob] Assuming it belongs in DT, why is this ath12k specific? Could be
> for any wireless chip...

Agree, it could be applicable to any wireless chip, it should be moved
somewhere else. Would ieee80211.yaml be the right target file for
this property? Or any other file suggestion instead? Thank you.

Best regards,
J=C3=A9r=C3=B4me

