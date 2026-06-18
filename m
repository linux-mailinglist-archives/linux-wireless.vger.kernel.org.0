Return-Path: <linux-wireless+bounces-37903-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id yqBxExhFNGraTQYAu9opvQ
	(envelope-from <linux-wireless+bounces-37903-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jun 2026 21:20:56 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D7076A2553
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jun 2026 21:20:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=LQEfFJL2;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37903-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37903-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D2791301CA48
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jun 2026 19:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CF0A2F7EE2;
	Thu, 18 Jun 2026 19:20:53 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB5B32DC76C
	for <linux-wireless@vger.kernel.org>; Thu, 18 Jun 2026 19:20:51 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781810453; cv=none; b=RnCm0ZivoTAqc+Q3ub1a8CP21kfwyDKlKZLL8hO+9zIDNgbD6CQwjjCYQUupqyioB/w/QKMO78SAz5ZNTl25nUsuVJLXs6evTSfVSozeb/Bgbis85tFIw5fO9H4ZAlqyHmMTfZO6/HgrlkOnJ+PX3wafSZM2/snHOwLMDlGonH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781810453; c=relaxed/simple;
	bh=3GW4m4A1y4UZ9hMA3qZGpq4IqiAwTyHhdSGihzC+lxE=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=CYU1xxixCA1toubDAtZpo5Mc9D1kqkgv1XVgmO8PD4/McrmC8drxGAic3d0vROis6DbQibZD+FAQe7TGL8SJwcGcpFGM/RxUuMmaZ04TjAI2oZggsaT8EmFwA9C6Vy8jm9wzcEKIEGZhAvNjSydnj/KEcg0KiRNhtpST3VXawj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LQEfFJL2; arc=none smtp.client-ip=74.125.82.51
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-1370417c01cso1914395c88.1
        for <linux-wireless@vger.kernel.org>; Thu, 18 Jun 2026 12:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781810451; x=1782415251; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TngHd0EQTxZ2m3X+bc8uALQ8IHiZcB00GTxJVDwvEVk=;
        b=LQEfFJL2jY8Vxmez9Ofufn0A27dT0kn9E7UYeafF3SvxWxmuXma0tZX4Dbm3FbapRu
         HwYnc8D7SquDgwjl8BLqd3CMiuaoz77YJOhF7M8+O523VNmPp4g+JXOEt6JoRDUbWg7k
         0oMXtlAVsJXFUs2M3Jphh5I7zH7gWpn2vZB7VQGumO/qFXT9mjFyIUE/eFX7xENu+C/0
         Ho4dy4ZnoGULhqpTJhWuX6//ucbAU9OtCgaTXjUN/wgcOuKrrqUwLfPQst+X6vs7oaH5
         E/BZmOcXovkSVIn/QjXfp1oHiX8lLFsnduRVo1yjUSmEMc/JTUfbmKNGfRrH7ex22j7f
         soYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781810451; x=1782415251;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TngHd0EQTxZ2m3X+bc8uALQ8IHiZcB00GTxJVDwvEVk=;
        b=PMhnCWO5YMHUSBAyh7irQ7U9YNvcuu6Vf61y0AHPYU++tQNKDLksZDGOVQUpg/FQbP
         d86kNJCLhSg5HpobO9XOJX2ZMITsIGrvTpFTbWX3lYpQgFv7DCWmwFUt9c7ChMEQYFze
         kPszvTbHnTAGGpK5u48rNPC8bfSB/wQSP4qpuN2TIE8Kkz0qyq6O8tEVkOKfHfd5xYVd
         z9wv4gAazTUYUCTq7d+75VLKJo/w2eNAlZdLLfc1ZLlI/tKPdLl76EmuR4H+tOv5klED
         MJqeY9PA0gw0QpAcsy3n3QxqL1IxdHcsqX/peevH34Y4yOHkwlDR7xVeYn2In0P3SoI6
         dSIA==
X-Forwarded-Encrypted: i=1; AFNElJ8qoG2pg7GY9EcGGGJC0afdvxJEpJeRQAgzGwz6jnixiMp9K6MoMpDaOPLgC1wvfNxCC6huBmQ8/jBALk7LHg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7Om+pzRIFpcwtmbxiqrq5w5R9VnD+czSqthEf7jo4MOgy4I7P
	7OHIgK7EODn/IYZhI2kA1XTIuYyeE9dhyvMVFP0ljtFkP0J2l0d9xG1M
X-Gm-Gg: AfdE7cmH7av+Sw0NeXoCxVeq64vmvLkxUwcWSrBFRoZCsqO7vMT7g/xJgB4zKohe9XS
	58UhOSqmNBW6fwOnIEzLMip7iY33+8hACQ5dAa5hsUGoZsdzm0JQmCkB/V61qJhnUutloe85w1W
	oyENJh5uiT3Ue+KpjowtUVvGa04J3yPmoi2ve9j5681t8zkSkx5WUjZjCBfb0+fCEhPGAgme6/e
	GUz7+HfKlSr0JpCldc2ANiLOYny1jv9H6zSHHwLYKymIMq8A2KzYTpiQCCO/WDEDlokWG01btHe
	58PVnHOTjBfdE6Jb36uOcvBAH2S6nOFuq6/zUemHgau4NCyKRmQTUCKrgX7LbzPnBY13+farQdA
	LMoALyIhw+Rrd3+ZPT2D1NCKLy06pX+QZOs46qr+EcCqRZBYRc80+CKpl72ocgtu9moV4aFMzlq
	XTndElPoW3pNRmb7mDW5FOhvlwXdQcqUMQeoffrGjRpwCGyFlCj7xsbwaSfUudrXKdnUocLEfUi
	OjtCzhM/RzDQme2jEWwoSe/6xjuRg==
X-Received: by 2002:a05:7022:98c:b0:137:9399:fc59 with SMTP id a92af1059eb24-139a365c5cdmr97025c88.21.1781810450871;
        Thu, 18 Jun 2026 12:20:50 -0700 (PDT)
Received: from localhost ([2601:644:8000:5b5d:b427:6f9f:eb5f:94ef])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c066cc0bdsm391157eec.5.2026.06.18.12.20.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jun 2026 12:20:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 18 Jun 2026 12:20:48 -0700
Message-Id: <DJCF38062Q69.1WQ853JSRMFQ9@gmail.com>
Cc: "Nathan Chancellor" <nathan@kernel.org>, "Nick Desaulniers"
 <nick.desaulniers+lkml@gmail.com>, "Bill Wendling" <morbo@google.com>,
 "Justin Stitt" <justinstitt@google.com>, "open list"
 <linux-kernel@vger.kernel.org>, "open list:CLANG/LLVM BUILD
 SUPPORT:Keyword:b(?i:clang|llvm)b" <llvm@lists.linux.dev>
Subject: Re: [PATCH ath-next] ath9k: eeprom: alias vpdTableI onto vpdTableL
 to shrink stack frame
From: "Rosen Penev" <rosenp@gmail.com>
To: =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>, "Rosen
 Penev" <rosenp@gmail.com>, <linux-wireless@vger.kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260617234105.284358-1-rosenp@gmail.com>
 <87pl1ofa6t.fsf@toke.dk>
In-Reply-To: <87pl1ofa6t.fsf@toke.dk>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-37903-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[toke.dk,gmail.com,vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,google.com,vger.kernel.org,lists.linux.dev];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:nathan@kernel.org,m:nick.desaulniers+lkml@gmail.com,m:morbo@google.com,m:justinstitt@google.com,m:linux-kernel@vger.kernel.org,m:llvm@lists.linux.dev,m:toke@toke.dk,m:rosenp@gmail.com,m:linux-wireless@vger.kernel.org,m:nickdesaulniers@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[rosenp@gmail.com,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,linux-wireless@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[linux-wireless,lkml];
	FREEMAIL_FROM(0.00)[gmail.com];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7D7076A2553

On Thu Jun 18, 2026 at 2:51 AM PDT, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
> Rosen Penev <rosenp@gmail.com> writes:
>
>> vpdTableL, vpdTableR, and vpdTableI are never live simultaneously.
>> vpdTableL and vpdTableR are consumed during the frequency-interpolation
>> step that writes vpdTableI; after the if/else they are never read
>> again.  Reuse vpdTableL for the interpolated result (what was
>> vpdTableI), reducing the stack frame by one 256-byte array.
>>
>> The read-via-write in the else branch is safe: ath9k_hw_interpolate()
>> receives vpdTableL[i][j] by value as a function argument before the
>> return value is written back to vpdTableL[i][j].
>>
>> Stack frame size change (x86_64, clang):
>>   before: 0x440 (1088 B)
>>   after:  0x330 (816 B)
>
> Huh? These are static variables, how is this affecting stack usage?
> I assume this is against your previous (broken) patch?
It's only broken on ARM + GCC. GCC + anything else and Clang + anything
else is fine.
>
> Anyway, adding this kind of aliasing to fix a problem that you
> introduced by changing working code with no real benefit is not an
> improvement. I'm OK with fixing actual bugs, but this is just mindless
> churn...
Fixing actual bugs is the goal yes. It makes sense to split up into
multiple parts IMO.
>
> -Toke


