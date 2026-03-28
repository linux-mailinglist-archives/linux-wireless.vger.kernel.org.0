Return-Path: <linux-wireless+bounces-34109-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kINqLGkjyGnyhAUAu9opvQ
	(envelope-from <linux-wireless+bounces-34109-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 28 Mar 2026 19:52:25 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4808434FAFA
	for <lists+linux-wireless@lfdr.de>; Sat, 28 Mar 2026 19:52:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7E6383004D03
	for <lists+linux-wireless@lfdr.de>; Sat, 28 Mar 2026 18:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF99231A07B;
	Sat, 28 Mar 2026 18:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AHrXhrzY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 497C0337BA6
	for <linux-wireless@vger.kernel.org>; Sat, 28 Mar 2026 18:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774723940; cv=none; b=SQiTt9NIOh57MTolo9kJW2K56vjcGnQBTMmO0GsbEjuKIMq5epcCAVbfrC4ULjKGqWbaws8UEo4qyr2UeYXIGiHBV11iyTELTvrQMt8WPEYFvpieUqfVUC2ld5aDPJSn5AJVgeigBbWeAWJqlPpLVGJKClvKTls9Neec7qg2GXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774723940; c=relaxed/simple;
	bh=SOoad42V5ojIVPEtnZNAUJVSCXLgcfwtR3LALNMX96s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FOlhTV1kYgjj7CmBoXZyXZ4C7en0erjOz6br0Bh2+iZYb0uubDF1HbvHy2ZcWDSkpS82EOfrrQz9Wf8Cq4wmcZEFvdEC27clHTNnW3NsmiNFP1U5+qMaFSS6nodHYF2hGOs+F0s7gAxdUWY67shgZfQytEaDx7XpVhX0ZIqdFDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AHrXhrzY; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-48334ee0aeaso27222005e9.1
        for <linux-wireless@vger.kernel.org>; Sat, 28 Mar 2026 11:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774723938; x=1775328738; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wWaMes09VbJA0eu/5mK0JBrbn1EAM0ibD7TXD1gN1LI=;
        b=AHrXhrzYr5HwGo3Se64YLqn4hQgqWg55fsRGhIjrpxsvK38jTGEDD36YUYlSi4kutI
         3zWzaHr96qKRCpgSOqsKuoC+GSB9yPxrsNdlY9mLbQnOWu8Ls3FOxohj/tWUwNYhsHsa
         Bl8zgQTNZjGstHj6QiRoPlQbZxahI0RWudkTfmh5luaj52iVM1w0sSJswl/aHIs8oNcd
         vpjREbUjrYsHq8UJ30f2m3B/ubk30zq5ltL2t1f/MZSjfWQcHVcXyRrv6zI3vBDaE1Cg
         yFsavTvKgO400rFQaTgW3To14wsXo0w/HwjceT/m0xgZXSZKFPyUzKtRJ6IpaV9L9rnh
         NiVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774723938; x=1775328738;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wWaMes09VbJA0eu/5mK0JBrbn1EAM0ibD7TXD1gN1LI=;
        b=O4YakIyLfvGj5tg3Z2rc2dXiFcfXxVXHzhnR8J0nXU6sqGYJ52Ve0Tm35nWlk16dHt
         GYCn3Avlj47+t4TE4WwDHkAaISidu28JQza8jyAnNREY6QlHGMHyif3ypwO/S2d9GEOi
         jtxDqYi++FdCIV6zTjborAVQJmBoGZMbpSv0Q0H8OzWQMo18I+EKEuGko23Du7+Uj8ZM
         CnEexwkLxnvxwvEQxB1pEB72DaswQswK818gRjlmn5lVCd0RQ/c82JUSaqGEbhCXmHJj
         1NN7kCZB+Ws3oJkoqXFq2j0oaNx/PMppwwD3Vh4R0pj0wV9X01zv+dX3LPIM1wuSPSch
         KMzQ==
X-Forwarded-Encrypted: i=1; AJvYcCVHgnIdKwJYfnIR+Ln3WHu3TGKSEBjo9lt+QqGP6OItwznxr4P8w5QLOjncmN0We9kAj8goXqgmSb6BEdj2PQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywg2mBMju7o0DXXNIEde1YSsUqVpdc83CLvL3CwFnpF1/yvf0o8
	ZCvXs5/Q8U86zPbLaSzr9QMzM8qjA0Dq6/i8dhSuNFBAHTe4D4LONyE+
X-Gm-Gg: ATEYQzxj5wKW3akJ8UiJOrukhBn8CB9Rd8mkkrDflY/UQe1ciOhJ/CJjv85ydEFwPO7
	2MgxhlerCi2MLMbau3wrx9QW25vKSxlfORB4RIq7bF4TCQz0GTv/lcKnyPlUf5xOywBEgjYf382
	tvZj+tL7itIq7eGE90CzqYYu6L+SphSijjqlzXJ/bySY5TG35PzF9VpaJgz89UPOxmd3KRY2mXk
	Tt+pgZT45p8kM+g+kFwuC9HFcDnVne+I3tF8E9GTzRrxLDAbnTAbsX+oooy2uLsiPA0Q9S/5sto
	q6SycVDyZ6tw8mqvBU7fdo8S7mNiwr+VRsO8/mGw1qM9LdRNKBjO8R28P7swgvs6xwsTVWg6n49
	7/DEJ1CjOplE4mG1wa9lK3iGOO3GEmFYfYT7Ezb1nLRjfr+ZxTHZg25cVX/Z4kICENqfgyttTx+
	P+VCBHDEFJTES8A9dy54Pl6/zGLwnu2w==
X-Received: by 2002:a05:600c:6085:b0:487:288:1198 with SMTP id 5b1f17b1804b1-48727eda73cmr114620325e9.22.1774723937265;
        Sat, 28 Mar 2026 11:52:17 -0700 (PDT)
Received: from [192.168.1.50] ([81.196.40.93])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48722d236a9sm301655295e9.11.2026.03.28.11.52.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 Mar 2026 11:52:16 -0700 (PDT)
Message-ID: <a5ea6373-8c07-4fcd-95fc-d87ce6aef6d5@gmail.com>
Date: Sat, 28 Mar 2026 20:52:15 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] wifi: rtw88: Hard system freeze on RTL8821CE when
 power_save is enabled (LPS/ASPM conflict)
To: LB F <goainwo@gmail.com>
Cc: Ping-Ke Shih <pkshih@realtek.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <CALdGYqSQ1Ko2TTBhUizMu_FvLMUAuQfFrVwS10n_C-LSQJQQkQ@mail.gmail.com>
 <CALdGYqQ3tS_aQpmf7xLkaCG9W55ATQXP=tnRNdjBAG8waqg8yA@mail.gmail.com>
 <dbe78a09fafe4a0ab16cd691049896a8@realtek.com>
 <CALdGYqQ3JQgFvvjiqh-ck8UqUQpAoJ0zeUzEL4i4Un8qPmqxJA@mail.gmail.com>
 <CALdGYqQuS5EOWCaeimr6PY758feF-DPo5i3XFwoQ8ewf4xnm7A@mail.gmail.com>
 <b231d63665334ac786e808610fe4a1e9@realtek.com>
 <CALdGYqSd61wxNrPDui+m-S+Na_is-RM18-=L6xm-Jf4QQ+-DOg@mail.gmail.com>
 <a8e187e1b40e4a35bbeb3bc3a3d21821@realtek.com>
 <CALdGYqRPcDRctCpNSJFatXvqMKLFiiRGXZoQa3KJwfwutHJEwA@mail.gmail.com>
 <ba9790526e4e42c386642a05fcbc2f34@realtek.com>
 <CALdGYqQ5U2USCqVEixoDda1Xd2ugBakh1K1QkaKAU7HPSTTNWg@mail.gmail.com>
 <CALdGYqQ_RCOwa2J-GsEyCxCQ4bztyxSzbc+6eYNesBSaY3Nt-w@mail.gmail.com>
 <da30a61b-dad0-48ff-a283-3dd8e9bdf91d@gmail.com>
 <CALdGYqS53=MmG4yCLwgV+RJAZ=U8Aqi8QQZFZ5oFMernhSyxTg@mail.gmail.com>
 <5eb90d6d-e590-4c9e-91c8-1ba315f45304@gmail.com>
 <CALdGYqRkX8=XMOePeauxvSTDZFLEYyJZKCtoxCzqaNwdO6BNnw@mail.gmail.com>
Content-Language: en-US
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
In-Reply-To: <CALdGYqRkX8=XMOePeauxvSTDZFLEYyJZKCtoxCzqaNwdO6BNnw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34109-lists,linux-wireless=lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rtl8821cerfe2@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4808434FAFA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 28/03/2026 15:40, LB F wrote:
> Hi Bitterblue,
> 
> Thank you for the quick feedback. Full dmesg from the current boot
> session is attached (dmesg_boot0_clean.txt, 332K, 3349 lines).
> 
> It contains all 76 "unused phy status page" events with both hex
> dumps (4-byte grouped and byte-level) in full, plus all surrounding
> kernel context.
> 
> The interesting observation you made about the MAC addresses being
> 24 bytes lower than expected is very helpful — I hadn't noticed the
> offset discrepancy. If you need the adapter and AP MAC addresses
> for reference:
> 
>   Adapter: 8c:c8:4b:68:d1:63
>   AP:      6c:68:a4:1c:97:5b
> 
> And yes, adding a NULL check in rtw_fw_adaptivity_result() seems
> like a good defensive measure regardless of the root cause.
> 
> Let me know if you need anything else or a different format.
> 
> Best regards,
> Oleksandr Havrylov

I made a mistake with the second print_hex_dump. It was supposed to
print from rxdesc + 56. But not to worry, I think this is sufficient.

Some of the frames have what looks like a valid PHY status at byte 24:

[ 9926.365048] cachyos-x8664 kernel: rtw_8821ce 0000:13:00.0: unused phy status page (7)
[ 9926.365451] cachyos-x8664 kernel: 00000000: 05da26ac b587f0af 0aa2e765 f48d78f5  .&......e....x..
[ 9926.365475] cachyos-x8664 kernel: 00000010: 3ffe9e00 49d11a5c 00002701 012a0000  ...?\..I.'....*.
[ 9926.365496] cachyos-x8664 kernel: 00000020: 00000014 20000000 000000e2 0000000a  ....... ........
[ 9926.365537] cachyos-x8664 kernel: 00000030: 0000001c 00000000                    ........

But RTW_RX_DESC_W0_SHIFT is not 0. Then rtw88 looks for the PHY
status in the wrong place, in this case at byte 25. The official
driver always looks for it at byte 24:

https://github.com/lwfinger/rtw88/blob/master/alt_rtl8821ce/hal/rtl8821c/pci/rtl8821ce_recv.c#L272

Unfortunately fixing that won't be enough.

The way rtw88 configures the chip, RTW_RX_DESC_W0_DRV_INFO_SIZE is
supposed to be either 0 or 4, but in these frames it has many other
values.

In this case:

[ 9986.214022] cachyos-x8664 kernel: rtw_8821ce 0000:13:00.0: unused phy status page (2)
[ 9986.214512] cachyos-x8664 kernel: 00000000: 95515588 50ad66d1 893f252f 77ef35ae  .UQ..f.P/%?..5.w
[ 9986.214544] cachyos-x8664 kernel: 00000010: 3ffe1e00 4d626889 00404288 684bc88c  ...?.hbM.B@...Kh
[ 9986.214572] cachyos-x8664 kernel: 00000020: 686c63d1 5b971ca4 1ca4686c 73205a97  .clh...[lh...Z s
[ 9986.214599] cachyos-x8664 kernel: 00000030: 4a670000 000b2000                    ..gJ. ..

the 802.11 header immediately follows the RX descriptor (there is
no PHY status, which is not unusual) but RTW_RX_DESC_W0_PHYST is 1.

In station mode RTW_RX_DESC_W1_MACID is supposed to be 0 or 1 (I think),
mostly 0. In these frames it has many other values.

RTW_RX_DESC_W0_PKT_LEN sometimes exceeds 11454. In one case it's 0.

In many of these frames bytes 25..31 don't look like a PHY status
or 802.11 header.

If we can't find the reason for these weird frames, maybe the best
way to filter them out is to check RTW_RX_DESC_W0_DRV_INFO_SIZE.
It takes care of 67 out of the 76 weird frames in dmesg_boot0_clean.txt.

