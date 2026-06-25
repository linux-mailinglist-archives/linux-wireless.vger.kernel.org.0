Return-Path: <linux-wireless+bounces-38104-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id EELTIMW9PWpe6AgAu9opvQ
	(envelope-from <linux-wireless+bounces-38104-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jun 2026 01:46:13 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 870A56C92B9
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jun 2026 01:46:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=QKbuiSZo;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38104-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38104-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A90A8300C7D5
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Jun 2026 23:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF1653064B5;
	Thu, 25 Jun 2026 23:46:07 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 905612459C5
	for <linux-wireless@vger.kernel.org>; Thu, 25 Jun 2026 23:46:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782431167; cv=none; b=qnz/mpoosXTyRhPILEqrQNlNpqO4ONq/DQrDDeXVgkyufajsXipKelxus/SHMpqyEneA4q8ZoqPUhlC4qv9CPkjrSHv/viuCSx8JRLYruJqWB/Xw2zrV/Bmj2ZpIFr3ND/mksLNNPh6Ywg8YE9xBrKwL5KbQNmKIzgfh20UsQ2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782431167; c=relaxed/simple;
	bh=jnIzd9eXyM0lY5nLSKWOGJM4W2fxtczCL/IrCKu34m8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uwEICp3GYMnlo0CBIv77WC63jyTxiZr+uk6MM9UlnKXS++lN0cnMsxDKfLYdE/beqIa1HQiFpaB2AT5zBnQWImz0MNucxfrzv2D3GpD+Z2oyIGGkND3Td0DP0UoyRXQY9bQtpZ5UL96HERzO0+gloKYGOfcYV9ya3KtZpxt4FFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QKbuiSZo; arc=none smtp.client-ip=209.85.128.47
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-49249072f03so2009125e9.0
        for <linux-wireless@vger.kernel.org>; Thu, 25 Jun 2026 16:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782431165; x=1783035965; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jnIzd9eXyM0lY5nLSKWOGJM4W2fxtczCL/IrCKu34m8=;
        b=QKbuiSZosEQxQUhbQggRt8UItfhFDmC0tLrLcEL51qtr5EgnZSEtpeEZFqUyzXMXvT
         2d1LKTAq7z9sEbhQrJuBb9uHvJrvksZkeMoKZwZz8Bi9OI5N2aQJLxduu5Nzkn8UpYko
         hSlOhNYr30cD/m+G15lesKfFbbVcZxcIpw73hz3iLW77WmdbLSeFEfhAJXL7LAQiLM+M
         1nY1u8m9xhRVrT4Pds7Q/QI2i4O2BURUIzRQJP/F0L15PzDzXH5k3wrVZBd7ko3XTxdT
         dONZhhAM1Ww2vQF+rshUSJrSi7h+J3DWghGlYVBQxdgidDogObn9VUDy/ZRg9WaCjP6b
         me1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782431165; x=1783035965;
        h=mime-version:content-transfer-encoding:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jnIzd9eXyM0lY5nLSKWOGJM4W2fxtczCL/IrCKu34m8=;
        b=sYC9JqU3iiZmYQDgLR/mmzHofkohGXrPvpkobeBz5GlToXodPaTRJb24DRYERBocEO
         V9hpdc0eWyPklz6IiNk/nwvCLM4B8L11yOb0DbRaGHY0FT1Lqu8Q47qfiACUHV+CkzLc
         rnPoOAYUGIDGxvbkffl/W7flVWFZilSIZ2VgOKsOwQgeAYr1fDqeCsy1miy4Abxf27t9
         U43Iu4sDd/LIbNSGYoay7sA1WtyRArmMFR/WWMw9n8zcdLPmYWZPl8DqFHVpYBeTcDEJ
         G0p4IP2E/iY+N7HhgaDgGkmr59OfXL0O+ojsy/D6zcWySkKAzrKCPGvhckFOf8vSVwUm
         RbNg==
X-Forwarded-Encrypted: i=1; AFNElJ8wz+ZWcaI3RTG+ISxLoADSicIMNqJsANhym37mCx49b8Eb/cszKL77lGij7vlTVpQCh+7+IOgRRlazubLKNg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxFF5MnxlGrFvvTsJanilYcj8IbyMYhvC8ajWbat4NYZ9zOWfNk
	JjfITgCY3LfbtNtF+zKsCh2BjgnehueWyuZ+2q2+BOJc2k5ZR1LgCIaU0XbX
X-Gm-Gg: AfdE7cmGIhWUEEzR1GfdPGdvHxNMgONyLf0sMMJ3kUQKK15m98x4q2aAx9AYD37QfLE
	dJO7Ma78OYfOTvzwp1i4gFdyCjgjfCdYAIjR3aG8zpsdoHuLtMscH++7pniTvB8wuPe3OxwVWzx
	uwAn+W7Kbw/BVUQdpZbUFwRXcxIva2WVOyiTabtQN4lvlVEM7NThpP6dTMm/BQpOmv8nw+ym1m8
	oKum4iTnRtVjR2wQPf9qwFfI2uNtBskscM4cwP66BLzne+uufFlAESUdZG4fVMYB1SMstPWD7sm
	Fsy7qHbKsj6urUHWuX7rCApRXDqSJwnbgqKoF9VwBH3YF6bsmPVAhnXIVft7LgN0Ww4aluJRTvJ
	jsMl4WRVZrJ9FbyYU8chUNJFqggPWcFkLwP2Fz5NpSWGbSglJ6dFXusw=
X-Received: by 2002:a05:600d:6452:10b0:492:1e36:85dc with SMTP id 5b1f17b1804b1-4926689ac37mr53156515e9.36.1782431164934;
        Thu, 25 Jun 2026 16:46:04 -0700 (PDT)
Received: from debian ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46c22c680fasm20285246f8f.34.2026.06.25.16.46.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 16:46:04 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Christian Lamparter <chunkeey@gmail.com>
Cc: Doruk Tan Ozturk <doruk@0sec.ai>,
 Johannes Berg <johannes@sipsolutions.net>,
 Jeff Johnson <jeff.johnson@oss.qualcomm.com>, linux-wireless@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 tristan@talencesecurity.com
Subject: Re: [PATCH] wifi: carl9170: clamp command response copy to the read
 buffer size
Date: Thu, 25 Jun 2026 23:46:03 -0000
Message-ID: <178243116343.3635355.16109712055530784127@gmail.com>
In-Reply-To:
 CAPdMp1oWXvtdvp8D0f32vpvzGa0H9PhprQcACqqoc4Gnyy=f6A@mail.gmail.com
References: CAPdMp1oWXvtdvp8D0f32vpvzGa0H9PhprQcACqqoc4Gnyy=f6A@mail.gmail.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-38104-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:chunkeey@gmail.com,m:doruk@0sec.ai,m:johannes@sipsolutions.net,m:jeff.johnson@oss.qualcomm.com,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:tristan@talencesecurity.com,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[tristmd@gmail.com,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tristmd@gmail.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 870A56C92B9

Hi Christian, Doruk,

No worries at all, these things happen. Both patches address the same
underlying issue from different angles -- mine returns early after
carl9170_restart() to skip the invalid response entirely, Doruk's
clamps the memcpy to ar->readlen.

Either approach works. If it helps, I'm happy to respin my 3-patch
series (the other two patches fix the TX status off-by-two and
rx_stream failover overflow in the same driver).

Let me know if you'd prefer a fresh resend or if you'd rather pick
from what's already on the list.

Thanks,
Tristan

