Return-Path: <linux-wireless+bounces-32338-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UAKUBY8rpWkQ5AUAu9opvQ
	(envelope-from <linux-wireless+bounces-32338-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 02 Mar 2026 07:17:51 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AE781D3683
	for <lists+linux-wireless@lfdr.de>; Mon, 02 Mar 2026 07:17:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 133113010DAE
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Mar 2026 06:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30189335066;
	Mon,  2 Mar 2026 06:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hNyNvmr0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F54537B417
	for <linux-wireless@vger.kernel.org>; Mon,  2 Mar 2026 06:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772432260; cv=none; b=goiKSh0Z2tjJcpmrUAm1r6TDnqyQIn69UKdmaEmYwKOJ0xkjdwr1cV7phlEl4sTDAmOaZtgCnmedh4H2YEOb+F0WEY6S9N66D02/gYMfZM4ozgqlrq5iz1EGa1vHXrgLlLyqiWmwUo0sRpEqfHdkLi1sfZogF7zI79XhvPZSrHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772432260; c=relaxed/simple;
	bh=TtbtNNtVe6CmLRXYj9faobkevBetQAKcFSHodxgHyBU=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=O9P2BFl6OFh+Dv6GCrnG1vOXAY7+aylJjVdq1aeXROXGmQzPrqVDUIeDkr3Z8dAuknRhBHoh1KQkXByVaLNAbcBQVsOOzYkFwF4NTm15S6b6dUCyLkMdmj1NRW6VQ6PwoAXx12SHlaXCGJaZfIHh7FqNUEuFlLFzGP3e5RmUNs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hNyNvmr0; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-4398f8e2837so3531940f8f.1
        for <linux-wireless@vger.kernel.org>; Sun, 01 Mar 2026 22:17:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772432254; x=1773037054; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TtbtNNtVe6CmLRXYj9faobkevBetQAKcFSHodxgHyBU=;
        b=hNyNvmr0tj2AjJyqaJzYJYTb65O/wg4L2nOTONMm9fzmowoybqQQIzswwLJib6/bBP
         DC8o5oXH1BQQqJTSdFRwcTwTIgEUmrr8k1+B+npvw0uDi7hy8ilboU49yR6xPbIMi83V
         o8ZAuSVzcyw76Qa7VXEgwAYBZSyTuQGvFthpYkxCYgSBbwCTaSw8tUEf/TnIZji3WLkT
         TwaOtl3IQ0DE5r+/7ilRidxkR3Z1n80QHZtT4ItF2KaKhCo2nPfgzAlv2uUBYZNlBuUS
         5Hs6jKTWC2mFNO9o7ug4ixQ8NFH+xjn0ISITwejGgJEvRFrQedv6YF0XzZO+3UnckCLo
         Gakw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772432254; x=1773037054;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TtbtNNtVe6CmLRXYj9faobkevBetQAKcFSHodxgHyBU=;
        b=seCjATlGZBrsSlDDlVNGy7WZnjGZddogkF8GcMJMk2P7eh1++v65LXWvlmxqX1JVnX
         caxoZhtNFJOklLk+AJ0S2ZNMDmJO9BIwImrrynq6R1/GXyCeRbsPpqHAgQ4m86MHA0IO
         v1koq0btNxogqVSRrcM65XA0u3yT6MfW5nt9P7qjf9IDaSAaCA4oTq7HyJw9ilIKjvHo
         rZ5ETt0rEk7xShNrcNtx+GxZx5LxwXXvyDBHuXA96IQ+5ygqgIdW9itwD7fMw4oGhFnH
         nzPTCJUQzrDtA0u7Fgs/jOCZLGwU2H2nTHvL+7nwbCVUhIknKidGycRamzFUj2I8NB8D
         Xy6A==
X-Forwarded-Encrypted: i=1; AJvYcCWiy7H4QdextAwHwr421ELadbWeXbSfKp37WuGIj0XcuNfKq8zzpdz887VXrg3DooUKT/xhkiYIeJnsrS0fgA==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywkp1jHu1YtnYnU0a8ANwimJxAs9RveLwyomZP6AJ3XZFfEXrc3
	no4LchKMMJtrAmDBTn2QLH/JXsXJqiBxeJAf+DG44WRSIFAkrirZo+PfRTojozM+
X-Gm-Gg: ATEYQzxWFBQk1dJdvE2k0s3JBFQlyIqMlY7xhtFv1ib6t43cLLjS9Yk3bdxCjpVTb5L
	BGwd5+7stPAFRquXk3Ga7fav0rhcdB3JrOpHQskKhjktViwZ8AOdk45Y/PU2RwRjp4INV9RflvH
	lqqq84vIx0aNNgRxboNzk/y6qWHngQtn4iW6hEt89pq3HmTPo7pJ0ZpuubYw+7UD8RsiVCUsa1R
	/oSYmT7aTbUqP6/mm3X/fMeCUVNPfU/ShJ1Gy/FrvXzQQCQb1OlGx9vPKFK8CbNulI78HyfNNQM
	PwF3BmwtBI8OU05+13thbxEDDm6NjxjCYZEZqTHug8zFpH8iu+auGS+FoJI2duBorKKC65di7iK
	tj1G7FcroHYh+jRfBKpa744cKCVbUM8flf3GqT/3kbr3hc64gAUbd/42gEdwVUUMl/ZzQNPEW4l
	r/dUQmgMHWg4zwiGRcD3S610GD6ZZ3NvlVwW/V25OEExM07iVP9llqFc7EDXLMJFKPL3ckkVIMu
	xYdRsn7TtAYLIs7sq4WLtwdZ6AS89qQUBkc2Q==
X-Received: by 2002:a05:6000:2313:b0:439:8913:baa with SMTP id ffacd0b85a97d-4399de368bbmr19216091f8f.53.1772432253560;
        Sun, 01 Mar 2026 22:17:33 -0800 (PST)
Received: from smtpclient.apple (static.253.36.98.91.clients.your-server.de. [91.98.36.253])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439ab6ebe56sm13690902f8f.15.2026.03.01.22.17.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 01 Mar 2026 22:17:33 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.400.21\))
Subject: Re: [PATCH] wifi: rtw89: retry efuse physical map dump on transient
 failure
From: Christian Hewitt <christianshewitt@gmail.com>
In-Reply-To: <c764f16a880a400686c8c5f639fa98c3@realtek.com>
Date: Mon, 2 Mar 2026 10:17:20 +0400
Cc: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <903C7E52-033F-455E-89DC-B78C67C0C732@gmail.com>
References: <20260301042422.195491-1-christianshewitt@gmail.com>
 <c751f9505a664f6895bacecb62bc534a@realtek.com>
 <E6E752BD-5F3D-4F30-9820-CB44FA767E69@gmail.com>
 <c764f16a880a400686c8c5f639fa98c3@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>
X-Mailer: Apple Mail (2.3864.400.21)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32338-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[christianshewitt@gmail.com,linux-wireless@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	MID_RHS_MATCH_FROM(0.00)[];
	APPLE_MAILER_COMMON(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[realtek.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6AE781D3683
X-Rspamd-Action: no action

> On 2 Mar 2026, at 10:04=E2=80=AFam, Ping-Ke Shih <pkshih@realtek.com> =
wrote:
>=20
> Christian Hewitt <christianshewitt@gmail.com> wrote:
>>> On 2 Mar 2026, at 9:47=E2=80=AFam, Ping-Ke Shih <pkshih@realtek.com> =
wrote:
>>>=20
>>> Christian Hewitt <christianshewitt@gmail.com> wrote:
>>>> On Radxa Rock 5B with a RTL8852BE combo WiFi/BT card, the efuse
>>>> physical map dump intermittently fails with -EBUSY during probe.
>>>> The failure occurs in rtw89_dump_physical_efuse_map_ddv() where
>>>> read_poll_timeout_atomic() times out waiting for the B_AX_EF_RDY
>>>> bit after 1 second.
>>>=20
>>> I'm checking internally how we handle this case.
>>>=20
>>> [...]
>>>=20
>>>>=20
>>>> For context, firmware also fails (and recovers) sometimes:
>>>=20
>>> Did you mean this doesn't always happen? sometimes?
>>=20
>> It=E2=80=99s another intermittent behaviour observed on this board =
(and not
>> related to the issue this patch targets). It occurs less frequently
>> than the efuse issue and the existing retry mechanism in the driver
>> ensures firmware load always succeeds.
>=20
> As intermittent behaviour, it might be not worth to try DMA.=20
>=20
> Recently, we have some patches related to PCI hardware settings. =
Please
> use the latest driver including patch [1] to see if it can be stable.
>=20
> [1] af1e82232b98 ("wifi: rtw89: pci: restore LDO setting after device =
resume")

The efuse fail snippet that I posted alongside the patch was from a
Linux 7.0-rc1 kernel so that patch was already present.

>> We has seen similar log because of 36-bit DMA. Try below to force 32- =
or 36-
>>> bit DMA to see if it can resolve problem in your platform.
>>=20
>> I can experiment but this doesn=E2=80=99t happen often so I probably =
can=E2=80=99t
>> provide meaningful feedback.



