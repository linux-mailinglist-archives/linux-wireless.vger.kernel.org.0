Return-Path: <linux-wireless+bounces-21798-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CF33A959F4
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Apr 2025 01:55:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E12E175979
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Apr 2025 23:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B087221FB9;
	Mon, 21 Apr 2025 23:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MhHCnbbQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AAB58632C
	for <linux-wireless@vger.kernel.org>; Mon, 21 Apr 2025 23:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745279733; cv=none; b=bbjFn83GUWe+o/88vBa2gw1zV14htWnM06qPAPTcuVPHWDiTHvItiagKO+k7+c9r16Tqe3a6JtSc0qVLsw9U1uVZVYRLrZdaMsnUE97SZW5LFlo3c0htTyhBBCQAMSjGN4FTjuePzOdAmVElr65p2k1YNV8tGRwXZIaxLCK11Tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745279733; c=relaxed/simple;
	bh=AJWyW3TravrW0pqwKqrkjFzRRarpVKg6jNeX9krfP7E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nxu9EjErWOlZlMW9k0eEl1riXbSksU9O4SSXSQ2NnSGHLATro3L+4v+j83yZP4Wd7eptxduZ98efwVVM3EuI5jzXBKd8cdg+O0LLTK0/nGIDuxmYl57oeMBDkHOHsr89xiyKnfroK61fyrNgfnd2IUIvU4DU+0PBZgTfadxWOuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=MhHCnbbQ; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-73c17c770a7so5760132b3a.2
        for <linux-wireless@vger.kernel.org>; Mon, 21 Apr 2025 16:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1745279731; x=1745884531; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4lIvdhiIp7KfEAT9Ev7PNKTHz6RV3HKg7XqQ+xR01ew=;
        b=MhHCnbbQtu3RnE99VaisY6zdE94TOwwr4cRyjANZEBdqV1cWRWAbF/hUzzw4fTv3fj
         Pj0ktdDS7NKQhXpkswxXCmCC8aFaKnE8PsLHiU0IHPfoKEEs3TE19WWTKMnGf0M87ObW
         AmuW8N3WCXWbb9nx8pgHAEF0fwtkZN4hw+1uE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745279731; x=1745884531;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4lIvdhiIp7KfEAT9Ev7PNKTHz6RV3HKg7XqQ+xR01ew=;
        b=P0Mze/35+T382j5rwg0YoEYXx9euvBSqkKqrR2oIvp7DG7qhrgQCQk2XpopEMWJ6Zz
         BybRj/lb1AbGzyZI7RDg0wBMjAfl6tMCoRZDdfJxHr9KL0JoB8hH5QFtH/wi2Fm0RRm1
         DBmSNoPdWI1Po9H0K+BfYFp6u5IprS0N34e8osjcmd0Ow4+q2AfLgTwJQefQ/CpQp2U5
         RC1mw2Uviw8wLFaFj7H4un6796pfyNPthHTSdTYOkykLVWavvGOQ/XJMQsqg59OL8+kI
         FE3rqwoH6Z5/nLe3Qm7Ej+qEBR+JUlfvWqSIEbF2kzW8mOyR517CULmL8pFK9Bx5G4qO
         GOIw==
X-Forwarded-Encrypted: i=1; AJvYcCXJUa3q7IWm9DiBBNmdl6f8PoVBHAoHf0rAkabWI0W10BTFIpxpwsfsNS/0S/yznz5MLhPg5+zXNgPUkukjpg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzmOQ/YxOJjGVnCwn20VVBhPBrtY+JMOLcGg2FYvznHWERiy45Z
	TynfBO5ZalOM6PEnG/SMbZhaqo6D9h/MZqUF9Qb1hiunfIJ5+8iV3IuE+XLfJg==
X-Gm-Gg: ASbGncv14uHACqJD7SqJNzY0Z7PIL0bnSDiKW+c1AVJ43yCtYttk/lyB2ZZVLD0Onwk
	DrLY+CQ4xz71Kw2EAdaGJ2zumT/YHliYjdSZn654Hdas9oGPSqKQS28/Edi3i7Y6QNAtnHp1Bnd
	589GeKj4DzWp8CpjDAk6qIt0xT4KmyKasZO+nAepULJqyPiTX0+StsojA+fqpyG3rJHBBgk2rpX
	v4fCM/QluUSVvwpI26D3rjUSo8Em/xQMSlmLW8Lj4hPkGR4aNCXLMCipYUmzplJ61FQioq7ZTJA
	iuydqPHWAmgFI3xGUOAs08jrab/zg9kjOw==
X-Google-Smtp-Source: AGHT+IGJ2eXpK7Tw18O1UcFDo8NrVpdLzOhE0cUZMGnvJYX5+9Xh7zn7vlF1w9hXh4UFv6ZoFQfjxw==
X-Received: by 2002:a05:6a21:9987:b0:1f5:9024:324f with SMTP id adf61e73a8af0-203cbd27ac2mr22588881637.31.1745279731393;
        Mon, 21 Apr 2025 16:55:31 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e14:7:a29d:cdf7:a2a6:e200])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-b0db13a4084sm6199432a12.32.2025.04.21.16.55.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Apr 2025 16:55:30 -0700 (PDT)
Date: Mon, 21 Apr 2025 16:55:28 -0700
From: Brian Norris <briannorris@chromium.org>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>
Cc: Francesco Dolcini <francesco@dolcini.it>,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: Re: [PATCH wireless-next] wifi: mwifiex: Don't use %pK through printk
Message-ID: <aAba8H-8KYZJeezS@google.com>
References: <20250417-restricted-pointers-wifi-v1-1-b79cdaae5579@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250417-restricted-pointers-wifi-v1-1-b79cdaae5579@linutronix.de>

On Thu, Apr 17, 2025 at 03:21:54PM +0200, Thomas Weiﬂschuh wrote:
> In the past %pK was preferable to %p as it would not leak raw pointer
> values into the kernel log.
> Since commit ad67b74d2469 ("printk: hash addresses printed with %p")
> the regular %p has been improved to avoid this issue.
> Furthermore, restricted pointers ("%pK") were never meant to be used
> through printk(). They can still unintentionally leak raw pointers or
> acquire sleeping looks in atomic contexts.
> 
> Switch to the regular pointer formatting which is safer and
> easier to reason about.
> There are still a few users of %pK left, but these use it through seq_file,
> for which its usage is safe.
> 
> Signed-off-by: Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

FWIW:

Acked-by: Brian Norris <briannorris@chromium.org>

