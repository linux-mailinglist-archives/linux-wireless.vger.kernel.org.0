Return-Path: <linux-wireless+bounces-22956-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8AF2AB7411
	for <lists+linux-wireless@lfdr.de>; Wed, 14 May 2025 20:08:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8604F861DC1
	for <lists+linux-wireless@lfdr.de>; Wed, 14 May 2025 18:07:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D12A8280304;
	Wed, 14 May 2025 18:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QQjZv+ux"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F46287507
	for <linux-wireless@vger.kernel.org>; Wed, 14 May 2025 18:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747245867; cv=none; b=RpxVasaVi84+hprK847EdGa1pSKXkJdLNC5o7agA/S6Y//BYwjXu/nSuS6IzFsyG5ZezaZ3llKmXhlyzjFNLrMaALDEM2v09rFPccHHJrp8FpJeRpCcIaRv+POzCS44H+Ve7kIeUBn6/cW3pGPC+zGJ6wiNQhepjTcOTZ+D1MBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747245867; c=relaxed/simple;
	bh=AKWFbSe6pf58ntVN6qxxdbrrM4wxirutoFq/obEQZ3c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q2gTQlbpmEIp53s6YZQ2i6OwD+X/HDZ39I9f9ot8BrFkZDhNPhY7Y82TMlOYss0ko+YQJWmVFKrPE11j4OZvbwoCsUmv/4iqWQ09VrUbBrKkE10QCiLuxNwavS8RbqnfCw8KOn9oUw1ujn+FoGvzmu5beAzPP3DOZozJpPawgj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QQjZv+ux; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-549b116321aso8635048e87.3
        for <linux-wireless@vger.kernel.org>; Wed, 14 May 2025 11:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747245864; x=1747850664; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W1VxtcgtByDMNhk+tu6Y1PXiCoguT4/CJfpsi7F5pnM=;
        b=QQjZv+uxbDM08i1H4WiF8d5/JaYnXMppO9HqKsImlbTyPRwsQuxdZiHi6LH02PDETc
         Jmu2wjttDzw8pORjb6h82oJUlYgmU8IlThhMGPf74nbg8VpOr/mjdEQDet/Gh/0OJ4jK
         2L2TkMRo39KpZXFvJxzA6KlSgqmxt3YZf7CveZowtYZBTi9e5+Js4rNK6GL0Xxfdh8cz
         945aNjzCwxUkVzCdQI444TTRsAgzVeu1iEwXv/eBGQMgrhkO4LfVjLvubaRn0H1tnK6S
         mnZkoYQITTtk0z0ZDOweRppiIsjZYgxMqwtwWOm/Npdw+N+q/wNUUSRjZYWSGx0sKFx6
         pjIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747245864; x=1747850664;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W1VxtcgtByDMNhk+tu6Y1PXiCoguT4/CJfpsi7F5pnM=;
        b=BkZb/SOxUBWm9zf20MpN/T1vKmXCVLZm7ZZWYIGXvjidL4yNQIcLxRXlk4I2YrAC1J
         /6Rm7EVwwHYPNUZtXafMvMA4JBeuyf0zxWuL121y4RCNHbviHW9vjHMRHWt8Ek4zyFf3
         F2Gl4FXOuEZQMLCaK4VZzAQszHPVme2HjEKDDP/DANSnw9vX0tWjc8HfhQ0FzoNZjffk
         mCr8pLFCCyQbYJ8EkM0z6SON9AT5X4RAazbwZYTUWyRdFuoxsb5I2RDlN73DnLM2OEgf
         FKgYcqbpYUkaO1sZo1HJuKmf0TddEEVTlL0ulEy36PtXqiqG66VADZP089zaujRb5P/n
         3+vQ==
X-Gm-Message-State: AOJu0YwgMmo9I4KRujWDB5Z+4jd9mvA/GA/mRxdQE7RSb9HTzR0QQ24d
	DL0y+QttOZb8CdycwoyYw6wV1vn7R7260gPEL96JMmdoGedifoqZLDAslGPJ
X-Gm-Gg: ASbGnctLFrIwajD4sx94TCiKybzwYJEHnu8yvqhRBczPbQoo8v0+1XfUQ7T8BBvhpL5
	uu14XSkQwiGin9zdV0sndajcGSdM9v233w9gBekkrvLQ16q22ukuid9XJX4RpU/ZNGlEsXrWEax
	pcb7aU9JwOm6fFwHw3/3URcXQ38Sy7yU0wl874HwtBTuh1EicUWUKGJJNRmskhsQQSC5bPKuqzq
	GzxU3pxkYtkvyaTZCJJOeV8LELxJEULL2ndKlBcFJBWbVoKJ7aDfaY/hzcNGGfWgBa7n7k/pylP
	sVBSZzzds0wimjTnm7u4piNSP9hR5Bi3vr8Zh94iMb1NSUaud/k=
X-Google-Smtp-Source: AGHT+IHDWKEcYIMEj6Q77vJOqxm7vit6jVCeVnFUTghH3sYkJnjK4hMYY0v3Pfay0jwhbUyEuTaRUQ==
X-Received: by 2002:a05:6512:1111:b0:54e:86f3:5e65 with SMTP id 2adb3069b0e04-550d5fe945dmr1830398e87.56.1747245863721;
        Wed, 14 May 2025 11:04:23 -0700 (PDT)
Received: from hobontica.lan ([192.162.197.131])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54fc64bfd8asm2335644e87.199.2025.05.14.11.04.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 May 2025 11:04:22 -0700 (PDT)
From: Oleksiy Protas <elfy.ua@gmail.com>
X-Google-Original-From: Oleksiy Protas <elfy@ecognize.me>
To: elfy.ua@gmail.com
Cc: linux-wireless@vger.kernel.org,
	Oleksiy Protas <elfy@gmail.com>
Subject: [PATCH] Re: MikroTik R11e 5HnD monitor mode
Date: Wed, 14 May 2025 21:04:12 +0300
Message-ID: <20250514180413.373876-1-elfy@ecognize.me>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <CACC_pfLYxUXPTAo0P9aqeP-xKAMdGsAckg_=j0HO6fRf7rNxoA@mail.gmail.com>
References: <CACC_pfLYxUXPTAo0P9aqeP-xKAMdGsAckg_=j0HO6fRf7rNxoA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Oleksiy Protas <elfy@gmail.com>

After some poking around I managed to find a part of the problem: 
Adaptive Noise Immunity function is disabled possibly due to
the changes in 5f841b4130a639e5f0fbcf4a9b26045d734e4ee6

This patch restores ANI operation (although it doesn't fix the 
issue at all), writte and tested against 6.6.74. If someone is
a maintainer of the driver, I'd love a review and maybe a better
implementation of the same idea.

PS: Sorry if I mess up the email, first time :)

Oleksiy Protas (1):
  ath9k: keep ANI in monitor mode

 drivers/net/wireless/ath/ath9k/link.c | 2 +-
 drivers/net/wireless/ath/ath9k/main.c | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

-- 
2.41.0


