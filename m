Return-Path: <linux-wireless+bounces-29392-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DEF40C9030C
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Nov 2025 22:27:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9F46D4E0EE7
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Nov 2025 21:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADAB3311C13;
	Thu, 27 Nov 2025 21:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d1PlBzvm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF0D92E173B
	for <linux-wireless@vger.kernel.org>; Thu, 27 Nov 2025 21:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764278818; cv=none; b=CEvko/WQaqcR0GP+jNOvpljqBomYeHs9VCYS9t9XTxr353I5Bh8Qs2hEc7PyG9czHarWg1Lzr3/hSVKcKm5h/ivzEB2QWzHcsdiA4aOvFM2TpRSM82hI0IpH+tjuF/YjuD9+esomDyru8rbQQs4pTWw/or4XRUpmtI2mUoJjT/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764278818; c=relaxed/simple;
	bh=q4hpz2S2uj12Saavk5yPZtx1lTekPEsisRUbKlPPypA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=V7PtqQOSgKTLsfWd7zoPe1XmaV27Ef+Kav0PjrQfPpKPizMdXLjhj6b+lD+ZNEzcC/C95Hlbg2ft5/2G1tO+5fE+HzU7M/d31YHLMNL3MUoYg7gPqbQ9F9741HXgajoJpirhu3fXA4ZK1JpVk8GOsMHjc+flmsPsN/RywEcMiB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d1PlBzvm; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-640aa1445c3so1994911a12.1
        for <linux-wireless@vger.kernel.org>; Thu, 27 Nov 2025 13:26:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764278815; x=1764883615; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=q4hpz2S2uj12Saavk5yPZtx1lTekPEsisRUbKlPPypA=;
        b=d1PlBzvmhO/08+qAyED4dMUtYk21DKxiQJkEjZUBFzsp9i3vRBNuT+f6gYeWkc8wEa
         1+/SiqDzCsqo2yV6pbngtucDZHnvjacIe0AR9tap4/RYhKQD7sfWeMLIulXLoVLt1Wu/
         ILbDkTMoQeeMCBj3WZNZEv2cuEgT9wEzQD9PB+1GCN9GEPtExFkv9v9N1to98Z4dH2P8
         pLdtu+Fblb2jbnBjehqYDJl6yE12Qzdty/ypZ7Wghe3rQLtM2j6KBP3XC6sqFXqAg3D/
         +S82UT1oPpTLdbd/eQJAEzz0kZAm/KN5Zs4lJvTQ85nGSTtpaM2cofu0hl+iD8uWfNQe
         iL8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764278815; x=1764883615;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q4hpz2S2uj12Saavk5yPZtx1lTekPEsisRUbKlPPypA=;
        b=Ua7ZJ+clHVtxqVEFkeg7KfRoFLIqBY6OQY8bf9tYfGnOxWYrJSs6N09Apoq+4WkP4q
         3tEow/dCM+MRcVIcpUmAfm36bib/z01FylZMq7r0g+Lr33xb+8gxeH1hLpYmyxkpVVbc
         85xoTLieFMOCoPBfbwGYwhyGVYRADSFCOgn5hM3fMMriQRNXl+3GHMmMIF94umvje+th
         zyyAjSt5bRh5HZ3vylDilYVlde6NB9pIqwYqnRTFUgqCaF8x/lVBzUrJ5FhMTg3aEO48
         ktIj0uMifylKe+BxOU2WivEGaQxTS0btQuYMhEmFo0HbsAuLkaY0njYg6DG4lfrby+hT
         fSfA==
X-Gm-Message-State: AOJu0YxkP/DTjKB1OLHouLKnQgWjaw2tiy8rby/Oc0jDIw7szKNS/Q96
	mXT0wsIp/rwWz5RAMC22pjAOOkXzLSfsd1wZCOqpvjLA2W4KQcD/OnHtbQBJR2tqfEAXIXlTfy8
	LxF7FbYM07ZIz4IovD9qEwHy9livo4wKcKQ==
X-Gm-Gg: ASbGncs6weuQjAlpJemMXF8BSHAJfsmDJYfCjN9teiJpYc8Eh4cYvfChh2gEZBWmRII
	L06vcdlT/rp9ohbr7NMOVBVpO4sN1eDTFqra2g1fvsrwhOE+IFCHmFDclS2optZtDAAiRaMo2E4
	sNF7aytxOVMa3YeHwmfJpbhETlU9hKfHBBM3E0W1ODmejdG+OTXaQlBFYCsOtKWnsr28QM0uPLq
	HR1qWjpAur5aTwLRJpNlEeG/rjUUc3I3pV/k4v0H9xNDpvY4My5hWaHDW/tTgkK/BmgoHfWH2fi
	zsJ0Hm/cXkfK2MEnu14=
X-Google-Smtp-Source: AGHT+IE78GZIOBcKUzptIB7A66deBJKVLKwRTmqWAv4Mw8EBG/nEpL0XI0HkFD78ErPkGLGOfD9X1mwUbRpkElxDu9E=
X-Received: by 2002:a05:6402:2354:b0:640:6512:b9f with SMTP id
 4fb4d7f45d1cf-64555d04263mr23740766a12.28.1764278814894; Thu, 27 Nov 2025
 13:26:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rosen Penev <rosenp@gmail.com>
Date: Thu, 27 Nov 2025 13:26:43 -0800
X-Gm-Features: AWmQ_bmZ2fhfNpKHBHCKRg0e5y2clexjbhqD_AW9HJupjncapn5jThEvL99gu1k
Message-ID: <CAKxU2N8+bS5EDM-HhYCt0V-tAMB2Zn69cahBBhQk=6tkU024xA@mail.gmail.com>
Subject: Intel 3168 broken on kernel 6.17.9. 6.16 works fine
To: linux-wireless <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Output from 6.17 dmesg:

iwlwifi 0000:08:00.0: enabling device (0000 -> 0002)
iwlwifi 0000:08:00.0: Detected crf-id 0x0, cnv-id 0x0 wfpm id 0x0
iwlwifi 0000:08:00.0: PCI dev 24fb/2110, rev=0x220, rfid=0xd55555d5
iwlwifi 0000:08:00.0: Detected Intel(R) Dual Band Wireless-AC 3168
iwlwifi 0000:08:00.0: loaded firmware version 29.0bd893f3.0
3168-29.ucode op_mode iwlmvm
iwlwifi 0000:08:00.0: base HW address: xx:xx:xx:xx:xx:xx, OTP minor version: 0x0

There's also iwd dmesg spam:

invalid HE capabilities for xx:xx:xx:xx:xx:x1
invalid HE capabilities for xx:xx:xx:xx:xx:x0
event: connect-info, ssid: X, bss: xx:xx:xx:xx:xx:x1, signal: -76, load: 52/255
event: state, old: autoconnect_quick, new: connecting (auto)
event: authentication-timeout,
event: connect-failed, status: 1
event: connect-info, ssid: X, bss: xx:xx:xx:xx:xx:x0, signal: -78, load: 96/255
event: authentication-timeout,
event: connect-failed, status: 1
event: state, old: connecting (auto), new: disconnected
event: state, old: disconnected, new: autoconnect_full
invalid HE capabilities for xx:xx:xx:xx:xx:x1

6.16 output:

iwlwifi 0000:08:00.0: enabling device (0000 -> 0002)
iwlwifi 0000:08:00.0: Detected crf-id 0x0, cnv-id 0x0 wfpm id 0x0
iwlwifi 0000:08:00.0: PCI dev 24fb/2110, rev=0x220, rfid=0xd55555d5
iwlwifi 0000:08:00.0: Detected Intel(R) Dual Band Wireless-AC 3168
iwlwifi 0000:08:00.0: loaded firmware version 29.0bd893f3.0
3168-29.ucode op_mode iwlmvm
iwlwifi 0000:08:00.0: base HW address: xx:xx:xx:xx:xx:xx, OTP minor version: 0x0
iwlwifi 0000:08:00.0: Registered PHC clock: iwlwifi-PTP, with index: 1

Note the extra PHC clock message.

