Return-Path: <linux-wireless+bounces-36492-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IL2dAscaB2rnrgIAu9opvQ
	(envelope-from <linux-wireless+bounces-36492-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 15 May 2026 15:08:23 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 55EC955034B
	for <lists+linux-wireless@lfdr.de>; Fri, 15 May 2026 15:08:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1C7A730142A1
	for <lists+linux-wireless@lfdr.de>; Fri, 15 May 2026 12:57:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A65942DFA4A;
	Fri, 15 May 2026 12:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dlpOYtuC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 269172D46B3
	for <linux-wireless@vger.kernel.org>; Fri, 15 May 2026 12:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778849867; cv=none; b=mwhmPiymj8Bj42HEh6uKrFRUt0MM73DOF67vC9r3WkzBsZ/YeJN8FhXeFs/nitzwyPo234vwEYuN0txaZfBm5b71ZvW4Fz/SKwA9ssVHynrLcNqf6hilaXpeFc/JBChb81nOQRiiGqWYsP/5SwO4OipSCchmfFZdO8LyAKh5tQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778849867; c=relaxed/simple;
	bh=JuEbyIHQNKVq2shsEIVk0SOKxj3Yc5IqX78ZUG/AtAY=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Cc:Subject:
	 In-Reply-To:References; b=iYwvPFb81CtpA5Xf8oe7Qv4+5I9qdd0iPtenPgBuolXSbfbrDfBQ2XPlKABZ3SsggN3GyxEAXbptAk731p1OA4iduftIIafCYd5fVDqzsLwJZtOUDiKIJTnbf/Rh++0lPnaktZYUjmdFgnAEp3qO3qlP0C/W9XFhqLkWHwyb6Yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dlpOYtuC; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-bd373f83042so628802266b.1
        for <linux-wireless@vger.kernel.org>; Fri, 15 May 2026 05:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778849863; x=1779454663; darn=vger.kernel.org;
        h=references:in-reply-to:subject:cc:to:from:content-transfer-encoding
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JuEbyIHQNKVq2shsEIVk0SOKxj3Yc5IqX78ZUG/AtAY=;
        b=dlpOYtuCQOC8S22IEFFzRtS/pZCjizGA4fvUQ7ZcqFztBTOprsFfB0gypEAJozY0W0
         oNnzTX0RuiINsFV9DjqmpMimnI9JC4A84OsxaLD7XqQpvQZTL85VjvMXDf7NunC3JyMA
         ReWdvkUybrLQeo5XSD3GmF2aoRlkSUEa8aye0tqTmKsKwrD5K3t4OsU0UzgfoOL/JEkY
         P935fYg3Zg01wy9ta8R8D1raZ47ThMc0SIz5vh+84bFYK6NMwbpC8hnqke++SfFcNq56
         PrRltMdhJFJRtNo18xY8488bE+FTkSqEeOR2xqO2SD4ttG/r4cxBLTq3h9ycvRvSiDPw
         N3MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778849863; x=1779454663;
        h=references:in-reply-to:subject:cc:to:from:content-transfer-encoding
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JuEbyIHQNKVq2shsEIVk0SOKxj3Yc5IqX78ZUG/AtAY=;
        b=ssEePNfNdxdSCHmDp4gi2/8rvSMqCyps7jVX7PZTdVgt60yZdJpF84FQD+eE9eSsxK
         q3zv5qGnbE5zuSo18RgDvbkQDPakYAE+Uca1g6Jt4WKfFLUehesj/d322/ZyDoQZmEM4
         Lp32W52Q5X3LOawryw1N8Jm0+EPXRryo3SbbPXN9kZbWD5lu/bznUJquZbOsWYDUg+2r
         pcKhwPi1fziSnXIODnPPwTqdOMr1bxI5zw9b5FRqm7Rp+rblwvmP8WqS/zYm0vxDt3Wy
         QA+IWDhsYmnaQhuZyba0OufgMHqElsp0S02fe8E4FYu7Kpr+ubgiZEeM43L3ciYVQ+zx
         5KOg==
X-Forwarded-Encrypted: i=1; AFNElJ9anpv/UUPrNSfOwTUMK/Gmm5cF0F5YWJYJyib2RA9ZWNHQCvvPCrPkrqi8Gd5PS8bdv5mdFPYm5xZr8tI7IA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyApQXweFcYqZ80W1Nu967DW1danHTNdV3cZNUGibP/LRmyEbI6
	PdMeL+TkEyMmt2bJ2UGNIpfQoFUbHuK2FP2wjHAhgE+yiU4yuh7OdQPf
X-Gm-Gg: Acq92OGpMWAjnCsVCU/GeTyhPCs9oUKvKleBi+iSXqqaZQHLtRLDGO89blvC9Nq+Gdr
	DbScn5PM0OEIV+yQ8J9wS5vdTOLm8y0n60J6I3oq9sjhLTUmbExkrnoNTBVSXKtss2y0qAxKgaD
	ZvHmEZo/AuLy3yKHQxluikEd02iDtb8edQRckeIMyhEzV9b5rA0Rxgn367hvt7hArtnaPOjWFVz
	3IPrU3PdaosF9JApQXOwI3YxhzZosnN5lOVdRoqHAFjjVp+xVJ9UMAKLmDw+fvvq7lzqAuPEbNl
	Ac8UBmqaQS2mXRvBbZfQVdkwRxZX37pWbdXxeUtSHhoOVudeXXpkRLdGm4ABFlI7271UuCMS+Yw
	zm+or27GMphIJxHEvdmnmf60QWq8RFbzkkXje41gSZv5Ybkmyu+G1I7jbnRwe+5jYCt1J89BhCk
	gND7k+9BVhudz8eXS1gPlURCopADcvz8I+yDPMK42zj6386YA7/todFg0MgNv3LCsxMf7N0ewjG
	7OfA2Xzh/STkV3K1ApcAsHlQy/Xdi+AwyiSuWekkcOEGZoZpd2rLfDtaMT1NZZTv7S3lHlTehVO
	pX4Q4uPr1oOUSE3WtlH2h/AZNFxe
X-Received: by 2002:a17:907:a807:b0:bd4:f854:27b5 with SMTP id a640c23a62f3a-bd5177da46bmr236055566b.9.1778849863225;
        Fri, 15 May 2026 05:57:43 -0700 (PDT)
Received: from ahossu.localdomain (ip-217-105-56-94.ip.prioritytelecom.net. [217.105.56.94])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bd4f4ded942sm223467766b.36.2026.05.15.05.57.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 05:57:42 -0700 (PDT)
Message-ID: <6a071846.b4198512.207f7f.03be@mx.google.com>
Date: Fri, 15 May 2026 05:57:42 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
From: Alexandru Hossu <hossu.alexandru@gmail.com>
To: gregkh@linuxfoundation.org
Cc: security@kernel.org, linux-wireless@vger.kernel.org, johannes@sipsolutions.net
Subject: Re: [PATCH] wifi: cfg80211: validate common_info length in ieee80211_mle_size_ok()
In-Reply-To: <2026051527-scrooge-oppressor-1500@gregkh>
References: <6a06f87c.643c4978.1f1059.84ae@mx.google.com> <2026051527-scrooge-oppressor-1500@gregkh>
X-Rspamd-Queue-Id: 55EC955034B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.06 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-36492-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hossualexandru@gmail.com,linux-wireless@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-0.996];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Action: no action

T24gRnJpLCBNYXkgMTUsIDIwMjYgYXQgMDE6MzY6MDNQTSArMDIwMCwgR3JlZyBLSCB3cm90ZToK
PiBDb250ZXh0IG1hdHRlcnMgOikKPiBBbHNvLCB0aGlzIGlzbid0IGluIGEgbWVyZ2FibGUgZm9y
bWF0LCBwbGVhc2UgdGFrZSBhIGxvb2sgYXQgdGhlIGtlcm5lbAo+IGRvY3VtZW50YXRpb24gZm9y
IGhvdyB0byBkbyB0aGlzIHByb3Blcmx5LgoKU29ycnkgZm9yIGJvdGggaXNzdWVzLiBUaGUgZ3Jl
ZXRpbmcgd2FzIHdyb25nLCB0aGUgZm9ybWF0IHdhcyB3cm9uZywKYW5kIG1vc3QgaW1wb3J0YW50
bHkgSSBkaWRuJ3QgY2hlY2sgdGhlIHRyZWUgZmlyc3QgLS0gdGhlIGZpeCBpcwphbHJlYWR5IGF0
IGllZWU4MDIxMS1laHQuaDo5MTIgaW4gbGludXgtbmV4dC4gSSB3YXN0ZWQgeW91ciB0aW1lLgoK
V2l0aGRyYXdpbmcgdGhpcy4KCkFsZXhhbmRydQ==

