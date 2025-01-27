Return-Path: <linux-wireless+bounces-18025-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E790A1D905
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Jan 2025 16:09:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CAC71883D32
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Jan 2025 15:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D944E130A54;
	Mon, 27 Jan 2025 15:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KluhJSZK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7271477F11
	for <linux-wireless@vger.kernel.org>; Mon, 27 Jan 2025 15:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737990571; cv=none; b=F3kI6S/02dVxCCLThIBkxcJNhuorB1nstJ1CeHPNzGQHi4wwCg/kDfFQV9jglWguHiTD97HYf6B3k5jeu/RRV5XckGh8Vo4j1Z7a8nNN3i0k5TVnReJbxUA2nG6QJgW4PP4v7m+CDbnvxjfOdJyrbv6mJ2Y4CtFz4114mims3Jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737990571; c=relaxed/simple;
	bh=EwcaXFgV0xCS4nriJgeU5GOhkTW/UCHC43bQna+e1WI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Kwcsj/DxkeUQmiVeoJpdOBXHai0DSfURjgJSa/SA0+c5ZWKmhq61x7GTYl19ZwzLDsu0OD3+RoEaI0eZs4Sja3850XyCkzwmyIpmjNld3KMsjHfufKckQwofxK849/dcY4tzemvKkYOom5v5kpqJJoD1TjaQ0R86hP0TyU04a58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KluhJSZK; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2ef714374c0so7003402a91.0
        for <linux-wireless@vger.kernel.org>; Mon, 27 Jan 2025 07:09:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737990570; x=1738595370; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+u6EzzWcIGnS4+MejkE3jWALM1FF33F7pQoXeXph8FU=;
        b=KluhJSZKEos6jiniIOy8uYsDcH9077DjvRfM/BoV5ndVDmGfknlmUJBcPKzcTnDx/+
         qszWNagdu2Mp3ipRPe4uDbaHdQO4AzrgLLiS6uZre4BTHHm7Zco1Yb0KVfYq+7NtNLi4
         kI0wbMRsse1JLHSw2gza6Vzut2Pt3lVRz3TkfjYQmYbDxIfsZFCKTIBW6EQPbTtnqdxD
         V5cX52xv7duAzVjaB+oIE7Jtbo+6zLuA4G/SzyWHgY8QUNFMr5cC14Df7xbrofXemLTk
         J4CwVtSbo0EbKdOD7zYjyp6XzQ4c/WEiVDGAC5rm7XqVn+P+Jm7J6EP0k+18uUzuxOzs
         VU0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737990570; x=1738595370;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+u6EzzWcIGnS4+MejkE3jWALM1FF33F7pQoXeXph8FU=;
        b=UG2Vr8HAA3TKaCGnXeyYdv8t4bpFdnPIw7Uxv9vKRMRvAPi/m0RN+ox2ZtszCciwk/
         gi4cqsVKoZypnTi7iYBc8SOeQLcTaT15p9lyaVl+6LHFCC2alwa+S9cTDmW3P6u0vI0j
         npzVKZlKg4pXJc0rsUWEI97iPWHnD1eXAPr8KKEcPtHM7h4OLLH2bCkYqiNd3JJ41WxO
         8mCJmitPRYrF4EggL3bGvrGumOczI3exvfke86k/ATAg1aY0Iwo+5/NZBmXNQtvCBR6S
         4HynpXKKJbtaKisQ58tooZV+jNEY47QwmId1CwXcS5+t5VIQnQ4I/ZiYOggYpgJ2QpUA
         abXw==
X-Forwarded-Encrypted: i=1; AJvYcCVTAA6/SkQJQmzN0wVCekMdoDlD/haQXW7WfzR5wTA5Ba1dWY72J3GMDbZBrG6HXYLF1KyPyPIZea9X9A7L8w==@vger.kernel.org
X-Gm-Message-State: AOJu0YwBoCNqxsfxy/yN5rG0oPnTchIapri+SQOxrjneS+h0T0F8gyqX
	qSIZJs7e9vI5JBE0XZWqihgx9s9iM4GSrga8K1mnPk/kzgXkn3bGU65MNMwldVz/jYghzgW6HRI
	KurDTz77xt1J9fBzl00G4l9AbaVc=
X-Gm-Gg: ASbGnct50mrmElvx0ttb3r8PqUllySPRPqk3J5brWFTXvtJ2XjPwQHE3bnJothn0U6E
	I6xB1MhL2a8YDTCxvbh/v0t8e7tV2q83ghw7JThURgEn1okSafNvANW6LG/i+BCTe
X-Google-Smtp-Source: AGHT+IGVgD8wsBNO9HaP0Y2FD3bARVApgGsYc5Hfaqtt+CPaXyCl+Z6Hd0vZn50lxsxGf7Gn51yhNhbjGGxK+QmLndY=
X-Received: by 2002:a17:90b:2dc1:b0:2ef:e063:b3f8 with SMTP id
 98e67ed59e1d1-2f7ff2ba81bmr20793345a91.7.1737990569495; Mon, 27 Jan 2025
 07:09:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAG17S_OwtNxetb7XzsxkZcygH_CWkZx15evQZkThb3WjqpiKTQ@mail.gmail.com>
 <CAG17S_N6Gw1G8e5dh_1cm3P2DNt_gSbQSAKWd27hvpMZui4yxg@mail.gmail.com>
 <CAG17S_NgkTQ5wT5nb=6FZZ9gnVMTqOWfWJve47JmfOoVAHZy8A@mail.gmail.com>
 <CAG17S_Oq+RGOZpE+xa-CV8=VtmJu7G8GWxfVYqg1edEG9wC+yA@mail.gmail.com>
 <CAG17S_NdA9LdwmA_XfvPOVrhCdqp+BOtAssH0=RE-VSjg=WFnA@mail.gmail.com>
 <CAG17S_O6Bpc+JhhUuDvE70a+ef9wt9D7jG1gMJDNo1qZCUOg8w@mail.gmail.com>
 <194115affe0.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <CAG17S_O7HbPFB0gubWWP9P-Oecps8K_LG0Y7YDo5DbNGKSLjpA@mail.gmail.com>
 <CAG17S_MwJC+h7O-htyUxEgB4zHKeGf+9B4QaQ6ZLiVStU_Egkw@mail.gmail.com>
 <CAG17S_NfqFjjaWj6vGS1HXux6JDy0QKcg8aQAR=aOzNGhO0a3w@mail.gmail.com>
 <eace9233-1b65-4793-8abe-abd3c640dba8@gmail.com> <CAG17S_MfQ+FjWQJoiNs30rt4u1O9Z_FXFB7BiS6RAQsG9ReNkA@mail.gmail.com>
 <CAG17S_OigLj3j=tS2BKYpoKOWKVs=XOBS-YFn26SzF9r+ZpLzA@mail.gmail.com>
 <CAG17S_Pj6UaA-yaGDUCwr8+M+L760PU0NvB1sAzGGNCp4xKatg@mail.gmail.com> <8c36a8c0-0246-4009-b79b-890e1f0a7aaa@gmail.com>
In-Reply-To: <8c36a8c0-0246-4009-b79b-890e1f0a7aaa@gmail.com>
From: KeithG <ys3al35l@gmail.com>
Date: Mon, 27 Jan 2025 09:09:18 -0600
X-Gm-Features: AWEUYZmW3L6Yj0HRbpi8kaLlsRPs_B9BYnc6HUz_q5W0EyA3nWjtVXw77rADv4I
Message-ID: <CAG17S_NNtyU0eXzsWgrjJEjcqDHPLrbSkvnEboSg-fZebdV3dg@mail.gmail.com>
Subject: Re: brcmfmac SAE/WPA3 negotiation - Part 2
To: James Prestwood <prestwoj@gmail.com>
Cc: Denis Kenzior <denkenz@gmail.com>, Arend Van Spriel <arend.vanspriel@broadcom.com>, 
	connman@lists.linux.dev, brcm80211@lists.linux.dev, 
	linux-wireless@vger.kernel.org, iwd@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I just tried this and it connected 2x once from a saved key and a
second time from a new key.
Will continue testing and let you know, but this may be it!
Thanks so much for all the support.

On Mon, Jan 27, 2025 at 8:29=E2=80=AFAM James Prestwood <prestwoj@gmail.com=
> wrote:
>
> Hi Keith,
>
> On 1/25/25 8:37 AM, KeithG wrote:
>
> <snip>
> >> With wpa_supplincant, before the AP sends the 'PAE:', we get this
> >> which is not in any of the iwmon logs with iwd:
> >> < Request: Set PMKSA (0x34) len 92 [ack]                              =
14.561627
> >>      Interface Index: 3 (0x00000003)
> >>      PMKID: len 16
> >>          05 cb 9d 0d 9a c6 7c 42 77 b5 d2 23 f0 62 f7 4d  ......|Bw..#=
.b.M
> >>      MAC Address D8:3A:DD:60:A3:0C
> >>      Unknown: 287 len 4
> >>          c0 a8 00 00                                      ....
> >>      Unknown: 288 len 1
> >>          46                                               F
> >>      PMK: 254 len 32
> >>          35 28 07 cb 94 de 82 e7 0a 5c 73 d3 e4 1f 88 ae  5(.......\s.=
....
> >>          74 84 82 66 86 8d b5 aa 79 cb 75 d9 75 8d da 3a  t..f....y.u.=
u..:
> >>> Response: Set PMKSA (0x34) len 4 [0x100]                            1=
4.562171
> >>      Status: Success (0)
> >>
> >> Is there any more info or help I can provide?
>
> Looks like the only difference between IWD working and not working is
> when it includes the PMKID. This is due to the new PMKSA feature which
> looks like it requires some extra work on brcmfmac (using SET_PMKSA).
> Try disabling PMKSA in main.conf with:
>
> [General].DisablePMKSA=3Dtrue
>
> This should hopefully get IWD reliably connecting.
>
> Thanks,
>
> James
>

