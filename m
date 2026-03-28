Return-Path: <linux-wireless+bounces-34113-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MMChLFZByGnviwUAu9opvQ
	(envelope-from <linux-wireless+bounces-34113-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 28 Mar 2026 22:00:06 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3861C34FF55
	for <lists+linux-wireless@lfdr.de>; Sat, 28 Mar 2026 22:00:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6BBCA300A302
	for <lists+linux-wireless@lfdr.de>; Sat, 28 Mar 2026 21:00:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D707136CDFE;
	Sat, 28 Mar 2026 21:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="An5oOjpd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F82336C9D0
	for <linux-wireless@vger.kernel.org>; Sat, 28 Mar 2026 21:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774731603; cv=pass; b=tfU8IDMnGTQkOselOouFH/55y7WZ3nfGRf1BFHOi3C3FxpnZ5M/MHB1p37ebV1/n4Mjh/FLUcXoF4BjBvI40olFRE4FyZ5fWtN7Nix4ecJQ28zuLEWiRul+VOn3bfXgiSxbcyk22q7bwc/Vl+uQEMBdS3tJUxxC41gcdl9/fjEI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774731603; c=relaxed/simple;
	bh=gUF6jml86u5eXORyhkeHL4Z9Q89i78jGwClSi9WREU4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ev2u5eu8t9fYOkGQWpMys/ftkGWM9m+TiiGENabUh8eF16NP6ET/r6IKDcNB1USUFxfbeYboAuIdCazLIxtEq8q0YyjV061XoVuRfjREgqMt3A9m5m85ampYoDmUuZQjcZc+NWH4oeCqqr70VxCg2BxT6BagvlpBw0m2JbpoDNI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=An5oOjpd; arc=pass smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-40946982a78so1158279fac.2
        for <linux-wireless@vger.kernel.org>; Sat, 28 Mar 2026 14:00:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774731601; cv=none;
        d=google.com; s=arc-20240605;
        b=C7EHXiwhrcDSQvD+u3LW7h3bjboaNFD83PhcVDgijSGUMu0bcjmO0qz1Tb5XZiOfL6
         knc7zw5u66VmjSl74bmmLBbdAY/R1AnkLXPezjRGVNkEMIw9S7wWBvNK5kt348zV5aWT
         ZU72xQW9+uqUIQQMwJRSYhg0lnbXNfQe9ksSI3mwwaiE60li1H86UrMCzcc2puZkEDLj
         ++0/pLuofyOQIc7KgNfGCITy3FUN2xjvCH5YnM0zPt+Tsq+GuracGIWyRWr4Htbt9DMJ
         XP0j0Gd1HOaCXZDztqhDFaddI//QS9/iZj2M7Qq5j77rJJJlBWzpYHW2xQCfXVkShiLX
         eYew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Fv8m+M5IDJxeNba0GImApUXrgAHRHtobjKP26It5Yy4=;
        fh=6oklrprLbTVdj+bR17ZBqz2Z918bkI0wkR8o3O/mWoo=;
        b=dmjsfOI0HMAtIfVIjymR+kBRbGUVLP2bWveGsOwddZyEE9MQs0OdW6Ciy+WjmawCSk
         67v/kqlIjSL866IKZVtl5nAhlOtDBfzb4A1at7VAvMCnAxne4guRZWornMlDc4GvJ66J
         xbPXkUuL8vHjvPyEWNzb2AnGcbiztx2PrJqUlG3Djhtw1du+IYWI0+PhIcLZpZcpfX8d
         73o8JlHhUH5H9B6gCPCS3IbOKNVNIDDhmTrfIgSokpIKm1Obd5pR27cQrjrETOGewvXv
         g1YaBuWOVYBgTsVOKlzQfRoMYZ9SLNIMn93aCYcVKwEd+Uo1oSS6Y3IJJwlw9oisKSqn
         D+LQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774731601; x=1775336401; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fv8m+M5IDJxeNba0GImApUXrgAHRHtobjKP26It5Yy4=;
        b=An5oOjpdXu6FCb3HsZPDYYgSLSshBvM54DhCvqvQToF0Azt28VWaoyHyZ2gIuyn0wl
         S+C6JUmtyTlOuhd1FfugxDiNH/yUPGOgkPpC0+seMBYPzwJgCh42wXuHpgn+DYKdpq0K
         0PrgPnrEAHq+l7cETfTSfq9p0tg28zftfO4svhK8znCa5XsU5Wnmd7fSqLJSeXAj3aKV
         3H30lZBNQXsUM/4NqZ2Bb+J8j8ZGFpQWJGiHbvV11fJNFINPpGyCGWPNPobLqJqU+7We
         84Crk/q0nZJ2ml4BqY87JlwVxySasqrrM7QQIc3GsgdRvCHy8BG9QjN5M1/V1zUlHGjz
         EDbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774731601; x=1775336401;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Fv8m+M5IDJxeNba0GImApUXrgAHRHtobjKP26It5Yy4=;
        b=D/LedFFT4DOm7PzXLNsUSPhE7G05rZmppgUSLz5hva16I3y2u0lJ0da2hmElL6Y1Dk
         CMDHQbbfx9EJpEQqmr4MCLJEIhm1SJDD3AfKXEqIroE9g5lv9qMKefTGXHfRErZu0mNG
         2Do6FvI8zQ5/WCGYObxk7qyo5Go0IsG8CTe/jRydDVmrg+TOKIlrenV/2SmQgxLOUxiB
         G2r0nieE+qbS0chDAXF8GBhycaWyKASri8LdU+9lEijoj26LzqG6112ztP0PAMRShhjN
         uYUsV01LbttW4hNUPp1R5dKaRcOTPYAW9IIguE8RLqvwESXmHoQ7xV9MSxAAr9ADm/Hy
         QM7w==
X-Forwarded-Encrypted: i=1; AJvYcCVXLPhsMXFe/TImPfhrd+BZjkQSL/3WcvGSHaV6rdC90I+/PItqu618uwO4Qnc0FWH57HwILnevUJeP2GCGBg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxLD4JJKWhelaDA6MlpAq8NfrMw9+ZsW5Nx+OEMyV1ZLJbfknF4
	/PCVVeIIicTX8FtMCGXSQ4r5q43fmlUazgcFZRUN1fI+k84bdIAHWl/Wt6seCBno1AlB2zq28TD
	hJWTmUOh004G5ysvZz/9mipueuiLTQ3xZDWqFtlBa8lYu
X-Gm-Gg: ATEYQzzVd3OTo0lHHRcGC+p5p3grSfKw3+MszefxyBPOU/haA0HPECb9TYJsYiuUZyy
	QzJOhIeESKOZZhcADSfN1+klV/CJOMeAiOGtuTq/s4iZt/EZehprEEp+gBujPpvjQlZoceaJm1D
	Lr8TuzEEr8Dl0lZbNBFVJ5NAk1314y7WFr36Fvn2NKaneiRCKQaXCjeYwOgyG9++TuKdeVvU2J8
	DJN9+j7+8Ue0nZqP5i/iaCAmDBU3BWX5BfhWjRVACQkQg7HEOS44Ctj7/wwoXRjf0Fv9Vk2dEIc
	BPD13G5MQVhkbL8bvZI=
X-Received: by 2002:a05:6808:4f21:b0:464:2570:8805 with SMTP id
 5614622812f47-46a8a399ef2mr3321077b6e.3.1774731601345; Sat, 28 Mar 2026
 14:00:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALdGYqSQ1Ko2TTBhUizMu_FvLMUAuQfFrVwS10n_C-LSQJQQkQ@mail.gmail.com>
 <CALdGYqQ3tS_aQpmf7xLkaCG9W55ATQXP=tnRNdjBAG8waqg8yA@mail.gmail.com>
 <dbe78a09fafe4a0ab16cd691049896a8@realtek.com> <CALdGYqQ3JQgFvvjiqh-ck8UqUQpAoJ0zeUzEL4i4Un8qPmqxJA@mail.gmail.com>
 <CALdGYqQuS5EOWCaeimr6PY758feF-DPo5i3XFwoQ8ewf4xnm7A@mail.gmail.com>
 <b231d63665334ac786e808610fe4a1e9@realtek.com> <CALdGYqSd61wxNrPDui+m-S+Na_is-RM18-=L6xm-Jf4QQ+-DOg@mail.gmail.com>
 <a8e187e1b40e4a35bbeb3bc3a3d21821@realtek.com> <CALdGYqRPcDRctCpNSJFatXvqMKLFiiRGXZoQa3KJwfwutHJEwA@mail.gmail.com>
 <ba9790526e4e42c386642a05fcbc2f34@realtek.com> <CALdGYqQ5U2USCqVEixoDda1Xd2ugBakh1K1QkaKAU7HPSTTNWg@mail.gmail.com>
 <CALdGYqQ_RCOwa2J-GsEyCxCQ4bztyxSzbc+6eYNesBSaY3Nt-w@mail.gmail.com>
 <da30a61b-dad0-48ff-a283-3dd8e9bdf91d@gmail.com> <CALdGYqS53=MmG4yCLwgV+RJAZ=U8Aqi8QQZFZ5oFMernhSyxTg@mail.gmail.com>
 <5eb90d6d-e590-4c9e-91c8-1ba315f45304@gmail.com> <CALdGYqRkX8=XMOePeauxvSTDZFLEYyJZKCtoxCzqaNwdO6BNnw@mail.gmail.com>
 <a5ea6373-8c07-4fcd-95fc-d87ce6aef6d5@gmail.com>
In-Reply-To: <a5ea6373-8c07-4fcd-95fc-d87ce6aef6d5@gmail.com>
From: LB F <goainwo@gmail.com>
Date: Sat, 28 Mar 2026 22:59:24 +0200
X-Gm-Features: AQROBzBZ-pW_sqX9nfJuvNE_uZKzILfJU5XE2bfZfwMzXEflJZHpDMlaqhvGu2w
Message-ID: <CALdGYqTjSpAjPR7akMowhkQKVJsZmr4G47g6s+y4guFRMpYS2Q@mail.gmail.com>
Subject: Re: [BUG] wifi: rtw88: Hard system freeze on RTL8821CE when
 power_save is enabled (LPS/ASPM conflict)
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Cc: Ping-Ke Shih <pkshih@realtek.com>, 
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-34113-lists,linux-wireless=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[goainwo@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid]
X-Rspamd-Queue-Id: 3861C34FF55
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Bitterblue,

Thank you for the thorough analysis of the RX descriptor fields.
I found your observations very insightful =E2=80=94 especially the 24-byte
MAC address offset and the DRV_INFO_SIZE anomalies.

I fixed the second print_hex_dump to start at rxdesc + 56 as you
originally intended:

-               print_hex_dump(KERN_INFO, "", DUMP_PREFIX_OFFSET, 16, 1,
-                              rxdesc, 40, true);
+               print_hex_dump(KERN_INFO, "", DUMP_PREFIX_OFFSET, 16, 1,
+                              rxdesc + 56, 40, true);

The corrected patch is compiled and installed. I will send a new
full dmesg with the additional data after the next reboot once
some events accumulate.

I'm ready to test any further patches you or Ping-Ke may propose,
including the DRV_INFO_SIZE filter or any other approach. Just let
me know.

Best regards,
Oleksandr Havrylov

