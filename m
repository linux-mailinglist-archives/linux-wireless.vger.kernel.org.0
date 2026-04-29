Return-Path: <linux-wireless+bounces-35641-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mP5UMnpm8mkBqwEAu9opvQ
	(envelope-from <linux-wireless+bounces-35641-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Apr 2026 22:13:46 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F39949A033
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Apr 2026 22:13:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 742913014961
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Apr 2026 20:13:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84E2D3890FC;
	Wed, 29 Apr 2026 20:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eOuDi6uU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29FEF3876C4
	for <linux-wireless@vger.kernel.org>; Wed, 29 Apr 2026 20:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777493623; cv=pass; b=lmfWnCdvZ7ZsO8mK4rznM9qn4mL1PrRdEYAH571YK60kxqd3TFLdlx8YcX7SxiVDTwuH7o6IffxJpmL9Js0UKwbU8riiCj0f5PxpavjSKwIy3uZN4smPmwXjaUMPtNlze2o7eGmmmojM3bKAl6ksqcvGBxGm3dMofbj7WWq/PYw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777493623; c=relaxed/simple;
	bh=5wP6LkJY6vRGyZyS7uh3K3fGLiuDH8y1lnGW1WAOflA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZBf1GhsaKNp/qs4VhV7Sd9Q/eETaPjOwlkAvGbpomFFd+JEyuPbgzR+B0zJrjWd57mG6U+V4FO1bFrK36i7+lu0kuZkd5kY4F6VlkXyGBgtxYunw96dhl7qtx8NJD/ActT46cOR81/4RptHPclJlUuvt5NIyjblbwfe82w3O+s8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eOuDi6uU; arc=pass smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-6967080e6c0so137581eaf.2
        for <linux-wireless@vger.kernel.org>; Wed, 29 Apr 2026 13:13:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777493621; cv=none;
        d=google.com; s=arc-20240605;
        b=cU1IadzeJPlSJ9V/PzG1PnXdxkLW7gCjZps6UaKbEikwgMq3p1BHkMT5ZKhVOBJCaT
         f869d39UWaxwDX/RGVjDeyBM0l58Z+m1XtJF5YgpEF+bDEoCjTn91o9uVT/gNajZPB0G
         /j8FZKlolEIJNwPLGIJKDePQJlRqkgmlv3brg9i9wGoib/WIAQgfJIFJeldfMFnfcCso
         Ei0oKlEKs4Q0yPzIc+AzAIU0jplMHyoSQEhIe1O8MOz6nIBrj8diTMmA38Yz4bHc4lg3
         PVWz5fRFJRHwPKIfMkW1FzQv1obKcIgcfASBqsd14RN+CoE/3LBRw3XPOYF/DxJcYhxo
         fHTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=M9z6O9dTKzifPDWK79AGil/a12GYLJLa3ghnQy4B+F8=;
        fh=TVB74/MTZNPYpf3FB9hoxBWPfuIMoSsJi7oNDBuKcyQ=;
        b=JImhTDeRzOBjRRYfHGRiO+JOmgHeNbjYS3ICtIoPAt613QE7O3/INUMtlr0DVN091A
         qAZIscbup/L5Q/npjSw7pNl31XTWYtt/PeZ0QSgiklv474lDvyTRCpYGjhDtDjuKgtqJ
         /WWljDUt6dL4x0L0DL0FkVBUw0p+eeHb2zrDYBIkGBc69P8hN5yTEBVtuYTrp04aUJBu
         77KUN6LzRZQQ5oq/WOG02krDCyLrZa0uTXyxOtJldJXeXiqIR8vCpmX+XXGM99kx0uM+
         74MOfVdfcs90o5Lhb/ajWgS3CnfrCBN2TCWyTkNdTUUenqKKThTvUW7XL8OG3lnB6+X5
         C6Pw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777493621; x=1778098421; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=M9z6O9dTKzifPDWK79AGil/a12GYLJLa3ghnQy4B+F8=;
        b=eOuDi6uUo2nlHWOhVzZBBvgD0C9wS6twUkuvbEX6wu6lkJRPfI5DyMvvbhlZ4840Yb
         ScgaRswbGSjySFRgKtg3pxk1U6Fb12wsRWSriTRxgayZuA0SxxlnhGPY7p/kOTjslnrF
         1EHxMUhGQUHFGR5rvIP5LLB/74DyawH0TkDjgtw/OqM/IezoINTcBcyCaGB2CTM7159/
         1rYz4m4tkG6L++/Np1WuOEPaUnCI3gNvvqBVG4AugC+8gm1VWEWlEQWLYGvnxdhs5YL3
         jiHUgH6iOPtGvscyHjWLo3igaMq3FoDyI70Z0ChAFDjT0qxICzKgp4JTNPcpyyJZe9Ow
         nVvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777493621; x=1778098421;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M9z6O9dTKzifPDWK79AGil/a12GYLJLa3ghnQy4B+F8=;
        b=YrdSdvBLtCi+6MKNUVfhZUSUOMm9+7CEBSokY2loLoVBCDlbtudBWk2Gu65PZBiSbl
         X/QW5LTkgeZtVMPvg2aYgoBOna0XR2cR6TfSgHwhAAKsiXnNd8oct22vOnANX+rjdu89
         GcJ0SL4XCOei9Z1siBsvuNcVsg6WDe8d7ULAsFH3Bu2m4U3OsnZmJhEaMKUqKjFJ1hhG
         V9gO3AeiTv0wLAtVbk8VItMYIteKV6xqV1PTRYojP5SP+5XvlQrv9F8RTfIAgWDkTd2m
         8jLfxIV1d1K3VZSNdM6y8CPJBjebvX25Ozf271heZJpGFmCvVDsZBQKL3G8ZLS6oq6FV
         ZRcA==
X-Forwarded-Encrypted: i=1; AFNElJ8g/QKkBnYEsw82FOHjpMFRtaJcR+jOZ+yi8Ob5Ji4FQS2eeG+a/LFkjTNtHVOu0FeAGFoMc66IKODG/A1HHg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw39rrmkEvj+Ky6ziQGTImShxzYWnnlF6NOrAH38ks+fVcGRcxy
	ZKxB08d0oewWSw2Rwy0kPEOkEEBOPl9fCWB++5yecxbfWD6thMMb2idSh4gxzuWnmhA9603P0bw
	BZRCICyP06t7B6ISY2R4PeEVJg0cDdhqPLzvwYejqUQ==
X-Gm-Gg: AeBDieu3RTlSN9TmCujqJC/zLqhxCzKSYehblQxUoA3E5lKZ6mEtA1qmMfU9PqYMExS
	TgZQiornMOIEmAS2SG6gvDJAMk4SYO9ItJyD+OBPOrUkBfDuItUFyobnKOzjR7Zjxupx0QEsMIt
	ldmuGOfuRwDTODYQ/cbxItsMz8a2VhUCy+iFKvF60o3MVNM1kLZ9O2uy73mVKQsi3jU9Iz8AQyG
	6E8HoEpxNkqRS6vE2zZ9dN3c35HzHAYESPJVPXC6/clkHM3RUQjED9i/n9rJnxwVMJwnYhShxo7
	xOyDtMC3JYRGovN5cZc=
X-Received: by 2002:a05:6820:1998:b0:67e:366b:53b7 with SMTP id
 006d021491bc7-6967a624253mr50003eaf.53.1777493620973; Wed, 29 Apr 2026
 13:13:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALdGYqSQ1Ko2TTBhUizMu_FvLMUAuQfFrVwS10n_C-LSQJQQkQ@mail.gmail.com>
 <CALdGYqQ_RCOwa2J-GsEyCxCQ4bztyxSzbc+6eYNesBSaY3Nt-w@mail.gmail.com>
 <da30a61b-dad0-48ff-a283-3dd8e9bdf91d@gmail.com> <CALdGYqS53=MmG4yCLwgV+RJAZ=U8Aqi8QQZFZ5oFMernhSyxTg@mail.gmail.com>
 <5eb90d6d-e590-4c9e-91c8-1ba315f45304@gmail.com> <CALdGYqRkX8=XMOePeauxvSTDZFLEYyJZKCtoxCzqaNwdO6BNnw@mail.gmail.com>
 <a5ea6373-8c07-4fcd-95fc-d87ce6aef6d5@gmail.com> <6898154c58c84536a0dd4351b3b026fb@realtek.com>
 <CALdGYqT2e+jt+mK-o_bL8hfdEwqZ44fUt9_N6-H4jYp8FpqQJw@mail.gmail.com>
 <5fb2f699626b483b8a0a537960b274f0@realtek.com> <5f9003ca-3bfc-45aa-bf0e-35e9c991629d@gmail.com>
 <faa215f1-ac2c-4072-9603-4baca1d5e07b@gmail.com> <CALdGYqQ+Syz+6weTChA=aXe=DBZSi1c0-7OYhJgkj7ahpR4EUA@mail.gmail.com>
 <CALdGYqSS1WXdqHi1rp+PznVOW9wCF3vDC6qkScUXNV5YHQ=Bjg@mail.gmail.com>
 <CALdGYqSS_4yrKn73UHR3zfgJN98wjR71V=pn+1C4pvg2UXGHyA@mail.gmail.com>
 <CALdGYqRK+a7-7WEXgp1H-w-1AaQhhbTW9FTWtpmfGN_yXuDGSQ@mail.gmail.com>
 <4f40d96c-4cd5-4e01-846b-745e346b6744@gmail.com> <CALdGYqSAr9kgFQw5=fht1N4Tn3JEZwro8f+JveDGMU3VVYNvzg@mail.gmail.com>
 <CALdGYqTRqWO_3aZewGKix=PWROnXXdYiLYS00faBKymhEKcC-w@mail.gmail.com>
In-Reply-To: <CALdGYqTRqWO_3aZewGKix=PWROnXXdYiLYS00faBKymhEKcC-w@mail.gmail.com>
From: LB F <goainwo@gmail.com>
Date: Wed, 29 Apr 2026 23:13:04 +0300
X-Gm-Features: AVHnY4Ioc8tU5if52cCUZy9pRneOcIR1AypUrhLko9YXiz1x_H8IOxQmafwBSS8
Message-ID: <CALdGYqQio_byfdhDdc8hhebg2gDuB1MzFW0gv_39S5JJnN0FzQ@mail.gmail.com>
Subject: Re: [BUG] wifi: rtw88: Hard system freeze on RTL8821CE when
 power_save is enabled (LPS/ASPM conflict)
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Cc: Ping-Ke Shih <pkshih@realtek.com>, 
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 2F39949A033
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-35641-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[goainwo@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[]

Hi Bitterblue,

I've been testing your patch on my HP Notebook (SKU: P3S95EA#ACB,
board: 81F0, RTL8821CE [10ec:c821]) for the past several days.

Test environment:
- openSUSE Tumbleweed
- Kernel 6.19.12-1-default
- Patch applied via DKMS (rtw_core, rtw_8821c, rtw_pci, rtw_8821ce
  rebuilt from patched sources)

Test conditions:
- Continuous Wi-Fi use (streaming, downloads, browsing) over ~48-hour
  uninterrupted sessions, including suspend/hibernate cycles.
- Bluetooth coexistence active throughout (audio streaming
  simultaneously with Wi-Fi).
- Power save mode toggling, Wi-Fi scanning under load.
- The system previously exhibited reproducible kernel freezes caused
  by a NULL pointer dereference in rtw_fw_adaptivity_result() preceded
  by a burst of corrupted RX descriptors; those freezes are completely
  absent since applying the patch.

Results after 48+ hours of testing:
- Zero kernel oops, panics, or BUG traces.
- Zero rtw-related kernel errors of any kind (the added pr_err_once
  validations haven't triggered, effectively catching/mitigating
  bad frames without log spam).
- Zero RX/TX errors on the wireless interface (2+ GB received,
  400+ MB sent without errors).
- No system hangs or freezes.

The system has been fully stable under all tested conditions. Thank
you for the fix!

Tested-by: Oleksandr Havrylov <goainwo@gmail.com>

