Return-Path: <linux-wireless+bounces-35424-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oNMIFUDa72mvGwEAu9opvQ
	(envelope-from <linux-wireless+bounces-35424-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Apr 2026 23:50:56 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C1E1647AF31
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Apr 2026 23:50:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2C22C300951C
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Apr 2026 21:49:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C3903537FF;
	Mon, 27 Apr 2026 21:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jskImuRN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09DB837D103
	for <linux-wireless@vger.kernel.org>; Mon, 27 Apr 2026 21:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777326546; cv=pass; b=VRPgxMkXkNfmQZ3kLE+lkTxTZT/UW5dJ2d1FqgzGtsrmVRc9KAOlh41bf0qyWpEpw1qQ+Lt45EuAsix/AUeea079B6JuSEv4Pm2gUfOSkBXS22ezr2HREXGe3e7Cx33XVXlbwAu4DmTBFpVHXxODqCMCc/W0+lBAhDq4J3Hz7C0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777326546; c=relaxed/simple;
	bh=O1xeSYphxbBUo6advcbUdZ5K2q/yrFU3PoR/8sumaYg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DJ9K34A2/7kTG9H+t3NYEWZ/URgGWL1UhmoGCVfwYgXmr0Z5kTrvFj7VOefYbE9AuhlJCw+5w/rootPQ0sfjSsL8rDmO8I7Uq7+JJ3WAw9bxW6CloXuUV7Qp8SJ6YfgWaMF50d1tgGMLb3RGFiMH8AWafM38iNejhWCIcGUGY30=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jskImuRN; arc=pass smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-7dca4debedaso9250289a34.2
        for <linux-wireless@vger.kernel.org>; Mon, 27 Apr 2026 14:49:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777326544; cv=none;
        d=google.com; s=arc-20240605;
        b=Tw6dYgPDRd2dTqEimsr+zZp6aASlucPkXwTj533ChOVPnui0+Fg0CWk0vJnnf6BdlA
         ywESXCvnxt2ceOu0lRRhYZYIieYpNjpybRFG61PjuLL4oN1V+0rofAsqDiM2ZIIBo4Kj
         8KRcBpOtLYjGR6fZRe8p15z9gg1TeH1O9mEgsSvftsWk/hnWo488+bnIBcDVUqSkduUu
         4p2u2K3RVMJ9jhnAF1vo3Qs9xaUHia2lQmsK2g3cge+3iVnHIGK/rEl4zQubUu5Nzr3H
         vsXhnQRmUqZ16kNv3tzmbRCcuZ0RzshODTki8+olpbxO5VuVnQqLik4lNcbPuITWE7uO
         exPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=O1xeSYphxbBUo6advcbUdZ5K2q/yrFU3PoR/8sumaYg=;
        fh=I745IYCxvJX92pTJDpAauYJmE6BHMOGSPwGQ40p/Ers=;
        b=FD5mZ3i4RGXtwduoc+WvhcdaunXfel+QhugBxWseYVUVQvPMK3M4/odv/VO+/H3DTe
         l1KMUl8CH1KrUzXcJ77h6fdpNV7WEW/xlrpIfvRjPe6gHt6cD0Db7TXe7/EjTy1FSg/7
         9k/IxO1Z+uIYsoU5QJic/crce5iuSLiyi9HIsC1mYy2EFpt6RCCcm3cAX66qjKdJXdtt
         jeoUBZkXYQe1CrhXyRQKgjGpjvbUPz64S+j6do/+uXxFksMB/XyMc8q+BI3Ols7vKLIg
         bbolECZwzurI/XB7og2s5kNuasAqQdM8ozBLeVCsaf8rjUSn/J5rmCeg9rhVoglThr71
         gzPw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777326544; x=1777931344; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=O1xeSYphxbBUo6advcbUdZ5K2q/yrFU3PoR/8sumaYg=;
        b=jskImuRNb+KTkaECDHV5ggIShBEU5qOOAYxOOSNl/yVSs7HSrk1CgpwEpyJImWZQ4M
         chqcPEI7E4udZX2o07qyLcDyjavWSvxBf4FfRKby7RuJoQN+bLYYMA7IRFHj+aVajoPI
         ngoL4VRIg7tNckHw3YTn6tG8hm1MfwV5ChzHTY80RPBHgfzCWQX8bdK4U6eKqTp1jj/r
         Y+3wb1LmZx1phMoSYZNvo7VmQov+0qoDWhb1EfUsfYxG2mKmJ9546lMf8SHrajimExS/
         n281T9JNODQLltaNsDN3Af0I21IIykSOlK5LgMbom9D/YiV418DYM4iKwlaSLdzmy0//
         rmRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777326544; x=1777931344;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O1xeSYphxbBUo6advcbUdZ5K2q/yrFU3PoR/8sumaYg=;
        b=g9sOpolPMlweomhDpujinL97BkwMAtLXdjm7zr3/XX9TQMOLbvFtJS2dhlghd8jjec
         8PGlxyPBohu1g7plzg8UxKd9PBdBzTRpq5IYFWjUBfd/t306D+Vs5QJ1VYExPv4PlAJh
         wJ9h4AXnZ65Bj3iuQDSiikZ3L1izvd46BfByoKvK9Oz/ZSaSgT+8uha6LlZCg8Dsat5G
         B1/1MpvyP9vEX31VZavGOQVSMjOHLimm8RJn5f2B4absa71wVCoCheJvHLFtRRaf2pFN
         V617uiH7tPWZKFWuunqfm87xMIdNMH+Jr5ppDyiVHee3gXrkGtasreKnKq+xl+GDb2N7
         /9yw==
X-Forwarded-Encrypted: i=1; AFNElJ8B415L7qJr1VmdPQm47FYUZPmU5dSRHd9DYxWBFF1r5g3asZ4JuZC6T05lcxtsOI1yVNlT5h1VptU4BXzhug==@vger.kernel.org
X-Gm-Message-State: AOJu0YwfS1/Z85MX1kzfaeulaH0hLZNM2Lw43IkEjiWPEOtdf7Tq48rZ
	FhtC0S+htPB6Lxrdv92+W3E+oTy1z+KVflTg0VZdzd1tM0KYO3Lf6Zc53b8IlmVVI1qemMlYd8N
	OKFRRi2ePV25DS3V9nTcQ3nnBKsvgywkxJijqwZjhCQ==
X-Gm-Gg: AeBDievFJx6GXhfnpajIa79bXDOuO8+PB4IPapqPJC1h7+FE5SdoHIu5kYGmyFmjxJP
	OSIEosDpDvm7JdAQPTVPLoYEgaLF01oFPPWiLvSCNNK7UVArC4lPV0FxKEyzbYV0y9krnJ96el5
	lBEKfoz7AknoKjogAw3NAkMU/KHppdRb20jGbWzj1v0u4wX6xNcrU+o0yAFPOkBbBPjhcpi5HKe
	7ck6BN3cuUmZ4M4JUraQ6UACBtup5G+aO/6cTwd1kXrKJ3/NIYTfwRrfGAzSXmSxiOCQidE1dpP
	104DGm4rXeRa0rLawQU=
X-Received: by 2002:a05:6830:314a:b0:7dc:de0f:b640 with SMTP id
 46e09a7af769-7de99f7c001mr364289a34.6.1777326543884; Mon, 27 Apr 2026
 14:49:03 -0700 (PDT)
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
 <CALdGYqRK+a7-7WEXgp1H-w-1AaQhhbTW9FTWtpmfGN_yXuDGSQ@mail.gmail.com> <4f40d96c-4cd5-4e01-846b-745e346b6744@gmail.com>
In-Reply-To: <4f40d96c-4cd5-4e01-846b-745e346b6744@gmail.com>
From: LB F <goainwo@gmail.com>
Date: Tue, 28 Apr 2026 00:48:27 +0300
X-Gm-Features: AVHnY4JWwXe5CzMO83DmwkiYf5zVIqjOztqsFAVDIDpQr9hwXjcPDxjtztySV2Y
Message-ID: <CALdGYqSAr9kgFQw5=fht1N4Tn3JEZwro8f+JveDGMU3VVYNvzg@mail.gmail.com>
Subject: Re: [BUG] wifi: rtw88: Hard system freeze on RTL8821CE when
 power_save is enabled (LPS/ASPM conflict)
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Cc: Ping-Ke Shih <pkshih@realtek.com>, 
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: C1E1647AF31
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-35424-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[goainwo@gmail.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]

> Will you use the Bluetooth headphones again?

Yes, the Bluetooth headphones (Soundcore Q10i) are connected most
of the time. I regularly stream YouTube audio/video through them
during normal use. So BT coexistence was active during all prior
crash events and during the single "unused phy status page" event
I reported earlier (at 02:59).

In today's stress tests I also specifically tested BT coexistence:
I played audio over the BT headphones while simultaneously running
heavy Wi-Fi downloads, power_save toggling, and Wi-Fi scanning.
No anomalies were triggered.

Best regards,
Oleksandr Havrylov

