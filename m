Return-Path: <linux-wireless+bounces-10858-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20BE69457FF
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Aug 2024 08:15:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9A3A285C42
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Aug 2024 06:15:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65EFD22318;
	Fri,  2 Aug 2024 06:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="BnHlWIOC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B14D420B28
	for <linux-wireless@vger.kernel.org>; Fri,  2 Aug 2024 06:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722579340; cv=none; b=tx+ZpjYXqgVUTBd0ONR03NEKlfLzk/j3j97NJexWsNWPpC5I6VPQ04akD0u9ULzgzhUjldYjtoeY6dAAk5BervH9A5SynGBt8OKZXyTKBPpRI1D4raydwPaebro1uJCpjkcJjB1vMWa/RTTjhZICjcEAls/Xbn4M+ruWLaytLYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722579340; c=relaxed/simple;
	bh=AmqNsV8nqsnLJXl2aXz49KA5sVG/46tml/UVKXJ3gFY=;
	h=From:To:CC:Date:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=nCeTZBfTdD0JHyLTW32ecl9f5TcwWCG4YRKtbrU3j1bH0jqB3oqexgpj1HoserAwBJDKtFc7GqXj0mRMRHj53xt08b5T4PR1gizwe34Ll7QT2C/h2D61ZMidVOyFceeXZ6EF97qpBpbnj1fvVdA+SrVULw3B6juqCQ7mTTlrFTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=BnHlWIOC; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7a1dac7f0b7so488377185a.0
        for <linux-wireless@vger.kernel.org>; Thu, 01 Aug 2024 23:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1722579337; x=1723184137; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FyQb+n4X+KUaDGFpyPWUqKhiSG4T2BXE+nFp2uohapc=;
        b=BnHlWIOCGndf7Itf4DRJetdW6VZjzxWq3juBiy60gjT4y+w7SK8I5NJe5EAvOGlA3c
         4UstsyTb/pq7eKQ7aB9vpAkTdZYzsC9GUpNL14qQJQtnkajyhvRUwhlGKvz75Lexsn5K
         8oaEoMzkPrvq7lD5FYtYnofxSI4fTtft7cQAI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722579337; x=1723184137;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FyQb+n4X+KUaDGFpyPWUqKhiSG4T2BXE+nFp2uohapc=;
        b=MFtHshv9KaMS23TKw0GBjk2Fr4VrFK2VZbkirWDJs3waqKog9Xm14ERa8reogFv6kO
         9tM8h0LEqwuvpQo1kX6710jlfPL8P61K9qNWRGLEIVlFmgh23wyJAMvvfu+BAmlIq2zv
         QZJcxbsQfY5YnpwQ6X8DQde+Wspc3PwrL5qFtpSq7dMnTR0UbsD4jBGkffBUdnAIhms3
         G9bewVPeUNVbci0p4w103MHnTmR4HxtAVOMIwpiUMVPwl+uZ1m4SC90mtY97ApJeRIjD
         RE5ibd7BWtiYXHtjLVuQbBfqiCsxfRDkbBE6X4ug7K6ZlNYf8a5uSJcx27KTqvBkiSRU
         Pe7Q==
X-Gm-Message-State: AOJu0Yw8X9D8QTBu9RIhQk0IFbzdPxTtYG66H6l4JgfDSF93vK9JBHAQ
	E/9C0VsSZeY6j2eyXfyx7XqMPjU+gHkiLY8aIcskfZ6VA2Q16998MyLSEwJuCg==
X-Google-Smtp-Source: AGHT+IHsvQGA8qutqv8vEb8iCAcPIb6DiIMW6AI10kEUxQMKSwNgSW8zoiF1ZVrKynbuE1o0Zu+mHw==
X-Received: by 2002:a05:620a:2988:b0:79d:6dd7:5da0 with SMTP id af79cd13be357-7a34efc1241mr285009485a.47.1722579337426;
        Thu, 01 Aug 2024 23:15:37 -0700 (PDT)
Received: from [192.168.178.38] (f215227.upc-f.chello.nl. [80.56.215.227])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a34f624219sm60788885a.0.2024.08.01.23.15.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Aug 2024 23:15:36 -0700 (PDT)
From: Arend Van Spriel <arend.vanspriel@broadcom.com>
To: Dmitry Kandybka <d.kandybka@gmail.com>
CC: <linux-wireless@vger.kernel.org>, <lvc-project@linuxtesting.org>, Dmitry Antipov <dmantipov@yandex.ru>
Date: Fri, 02 Aug 2024 08:15:35 +0200
Message-ID: <19111bab758.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
In-Reply-To: <20240801101531.6626-1-d.kandybka@gmail.com>
References: <20240801101531.6626-1-d.kandybka@gmail.com>
User-Agent: AquaMail/1.51.5 (build: 105105504)
Subject: Re: [PATCH] wifi: brcmsmac: clean up unnecessary current_ampdu_cnt and related checks
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="us-ascii"
Content-Transfer-Encoding: 8bit

On August 1, 2024 12:15:35 PM Dmitry Kandybka <d.kandybka@gmail.com> wrote:

> In 'brcms_c_ffpld_check_txfunfl()', 'current_ampdu_cnt' is hardcoded to
> zero, so 'txunfl_ratio' is always zero as well and some dead code can be
> removed. Compile tested only.
>
> Found by Linux Verification Center (linuxtesting.org) with SVACE.

Acked-by: Arend van Spriel <arend.vanspriel@broadcom.com>
> Signed-off-by: Dmitry Kandybka <d.kandybka@gmail.com>
> ---
> .../broadcom/brcm80211/brcmsmac/ampdu.c       | 22 +------------------
> 1 file changed, 1 insertion(+), 21 deletions(-)




