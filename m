Return-Path: <linux-wireless+bounces-9732-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2F0D91D364
	for <lists+linux-wireless@lfdr.de>; Sun, 30 Jun 2024 21:20:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 802481F210D8
	for <lists+linux-wireless@lfdr.de>; Sun, 30 Jun 2024 19:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BE401527BB;
	Sun, 30 Jun 2024 19:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jvgAD0w3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3C9422094;
	Sun, 30 Jun 2024 19:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719775244; cv=none; b=Q2SLMKKikZlcZMi7qutJoIkC2bnNr16zPfgac94u8jo9ycPCGIKbMRziWwyEYxOOC/ioPdYRv2XvwOocJnRXU7MvmtuwKJoh44GZyJraHHf9N7TDOx3uWvrsIvwawBYxAcek77vGb3ATFto/nwAhwA+aI+CQAuyekSRXc3bPrpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719775244; c=relaxed/simple;
	bh=Qv5LzdKpU0FwSK3HEaxfNczRepA3qdua1Igc7iJvxXE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=f7CGOfMhlbaGwJyWO1WV+zmkYTceZ4cNqgRvlCUE0tq1xACm6vZ+vuUYkiMhDsfIPvg9hXZ03mHaJRON14M375fgXyRfWPS7wrkAJrsITOeJSgM67Q6VAw5VokqoQt984GOB03Fc30MiUhM/jsxYo/tMncIdYdTk8k1Y4zDqoSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jvgAD0w3; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-7163489149eso1626065a12.1;
        Sun, 30 Jun 2024 12:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719775242; x=1720380042; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Qv5LzdKpU0FwSK3HEaxfNczRepA3qdua1Igc7iJvxXE=;
        b=jvgAD0w389NoRbmCnG1kFQmdPohmc6kJY1r6+gsZWj1u8q1sJK/qFAeuz/IYN2qrIS
         7U/2ii4BJw74NNjOREeTZGWj8d5qdaMo62rswAvhZY8xYQuLT5LHf4P83c0q9botRlLE
         VbXRlWiYHSTJuQCwurDvHAuPDt68/gDjn/XS2le1WwYDDiBPPUjcG1iaRBFM18RR/HQ9
         dqFGqdnkeqLONp2cFxKe3HzmgHV/A89QwjnmaLXUGqh4e+HPJ62gwLD7UNVgdaAsl5Wu
         mKisX7Cr+eUFdzY20975mXpKCmQT3l6ia/b/3rPPDgEdXIev+31XgWnIbEyk4ZmhT0Ze
         vKGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719775242; x=1720380042;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Qv5LzdKpU0FwSK3HEaxfNczRepA3qdua1Igc7iJvxXE=;
        b=Ce+oqAyE3okTQZSXhLjWfjqa1LOqCYJZ73zGhgqEtwc4re2IRG3yIfCPd2a0RkRV2Q
         +fBpYT0srqXVV2s8T2c1EA4xjyDUTjeQ5lsQiH0iCM/svKHj3uJzzoOPwOp72YY8zTiR
         78ZLSCIjLV3VGzP1qFo8YRGgC/JaZZQO9DXLSWTSNBEcR91a3eAQCMlBvcZcDzpmFF/9
         WrZUJOHrGJz8ObmeUN7UXt9sic3BvDfs8CEvFJT2n59conIHHHJipDoxVWBrkJ0j2PmE
         Sa8o6KQezb0cuxaAf2S+SvVjqh3Bn4uaCiSCcdQbryydtUxhHebfp+RiD1rSM+iINum0
         AXfA==
X-Forwarded-Encrypted: i=1; AJvYcCVBG0T6ASTL3WkwmhYRvfomTZAlCeKk+9hfopmnXcwSUrWPFHRUmCTtFYykxVEmGR1aImec23BYhv/+mQbLNrBT3dyIrcJAU4U=
X-Gm-Message-State: AOJu0YwEmwFnPbLcOC30Xz4Rm82pFQ+bXm8MhKATScJehRlWaG0Crn9J
	jVmaN6AFdbvC2+DnSmEb94Iu3addLPa5xwdJDc9prgxti6RizPpX
X-Google-Smtp-Source: AGHT+IEHp0UF3jlsTfprDPDQX8sR2LD15VGCEXaWu+GirQ9r41g5WgmKyIXx/EIMn1x1gMloMjq9dQ==
X-Received: by 2002:a05:6a20:8414:b0:1be:c2df:3ecf with SMTP id adf61e73a8af0-1bef6216ebamr6672498637.48.1719775241828;
        Sun, 30 Jun 2024 12:20:41 -0700 (PDT)
Received: from terra ([122.171.22.106])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70801e63ab1sm4979153b3a.36.2024.06.30.12.20.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jun 2024 12:20:41 -0700 (PDT)
From: Forty Five <mathewegeorge@gmail.com>
To: Forty Five <mathewegeorge@gmail.com>, Ping-Ke Shih <pkshih@realtek.com>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Bernie Huang
 <phhuang@realtek.com>, "kvalo@kernel.org" <kvalo@kernel.org>,
 "regressions@lists.linux.dev" <regressions@lists.linux.dev>
Subject: RE: [REGRESSION] Freeze on resume from S3 (bisected)
In-Reply-To: <875xtqjli4.fsf@gmail.com>
References: <875xtqjli4.fsf@gmail.com>
Date: Mon, 01 Jul 2024 00:50:37 +0530
Message-ID: <87a5j2s0e2.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Forty Five <mathewegeorge@gmail.com> writes:

> I applied both patches on the latest master; here are the crash logs.

Just realized I forgot to run the commands to get debug messages for all
except the first crash log (kdumpst-202406301756.zip). I'll send more
logs later.

