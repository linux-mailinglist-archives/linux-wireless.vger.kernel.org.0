Return-Path: <linux-wireless+bounces-10080-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 909FF92A756
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Jul 2024 18:30:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 491EF281F2F
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Jul 2024 16:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D4DB145A01;
	Mon,  8 Jul 2024 16:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dhqJ81ch"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21BF213C806;
	Mon,  8 Jul 2024 16:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720456236; cv=none; b=BJ/2QkJix8wcImSgwxZyL1NClTBTaRP9Bbi6BW6mtcV4Mdceqgldf9ZjFosUtMW/3zpELdZJF+veG9dCXQasnNoeggdb8+sbN/ITWHoO8nffjYt7y9xV7DfpPHbrSnQRKkin6slV099hHMNReFRhE4rA89gMyTfYKuysWizJwk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720456236; c=relaxed/simple;
	bh=ZSzzoKuc4n1mCJoVWKuUN95DVawIAjXwvH0TinrfKjk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EabTmFykuoimbsJdRJtlrDOH9KoQmxFfFsZrLt8qOo0606Uu3+TbIuJDSHl5FprmdkoTeJEsrGxQRHD2vwc//ghkmFrDGeY4oRAhaM5uDqxhFJSKnwt20CNu6L5iP/IknQBC7aK9Jau/f5B9mP3lGb3Hq4Vklib31fxSdceS8/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dhqJ81ch; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-70af0684c2bso2513638b3a.0;
        Mon, 08 Jul 2024 09:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720456234; x=1721061034; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZSzzoKuc4n1mCJoVWKuUN95DVawIAjXwvH0TinrfKjk=;
        b=dhqJ81chpPWaZg8sG4yMha7j08rEQgbhcEMaMwnzxY/zTwzbNgUqWpesJk/b9aDKFn
         K0lN02EaS7p3wzB1cjWxp4GHiEMDU01BcVlOLWD6Ye3XvMKo72vShbbiDuJSgvl2RlhG
         3YVZ1Kh/z3RwywOWBUGXCZ6nEZp4aWPW/QVCWNU6y8lzwU/XDM3PSEVXC4xVLl6PEPGY
         QpNsOvKOSseM20f8R0psCwjcNTELyISVYJcgXQJtHKMaKyQ+vad/m6uSW0zyQ2LJfPxd
         tc1YoRtKEe9Jn/UXd0GmZ39t5shlKvfiZRntaFkIeBdmIb4Vo9AQ7nHZ9K3wbUXlL6sW
         YNUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720456234; x=1721061034;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZSzzoKuc4n1mCJoVWKuUN95DVawIAjXwvH0TinrfKjk=;
        b=XgpuRMO73FX8JVJ13J80TflnE9BxSZDSoxBjl50qobkbfLmUF8a/KlhBVjlwCT2tFb
         Mu+W4M/vaBnaiw9he0zEivkll+Fdba45jjDBR6xXFI82geML6GaArwbGHPmOM8owkZ/F
         5aAZc/MOrk+lzH/m50XpLeAxeBb8+d7IZ+RTISyjUKolvoIF8cbCrUCJSPdl/u5EN53P
         JK4tFODxFE+wcPQdC4sHiXmrJU5wNRmnVLCNKG1xac0DLfJfgdac2jYa1F7a3nuVs+xo
         0jwBCcuBlQTrshYyI6dYK3EXWxBOhd7aoOn7VRsRBGPePDYoKeteGkteYv6WC6BLgfak
         DpKw==
X-Forwarded-Encrypted: i=1; AJvYcCVEVm3zn7g7iQ97sCXqRhsu7u2Igcg9Szye7FDvTkFIxBua0OpwStBA/HmKrLS6Nu8l0xv92xbUHQgBWNo2OgQhorSEyPGznCQ=
X-Gm-Message-State: AOJu0YyNizU7pqpM9DfB3wazG8hAimNlyymyJ81C1zVvg/n3KEnlNTPE
	X2OG8Fbs9RCsUCphaPm8zw1prXr5zBRcSd47zJOUXLUZm0wI7YmayxDgJwhv
X-Google-Smtp-Source: AGHT+IEXEWiB527X/hCtqLLU1j3dA87Wm0WNEf1RGNZAxDxg5UUMYNj41l59GStire7J85rfi66RHA==
X-Received: by 2002:a05:6a20:9186:b0:1c0:ef24:4125 with SMTP id adf61e73a8af0-1c0ef24b42amr3686843637.26.1720456234268;
        Mon, 08 Jul 2024 09:30:34 -0700 (PDT)
Received: from terra ([122.171.22.106])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b439c3213sm52074b3a.194.2024.07.08.09.30.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 09:30:33 -0700 (PDT)
From: Forty Five <mathewegeorge@gmail.com>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Bernie Huang
 <phhuang@realtek.com>, "kvalo@kernel.org" <kvalo@kernel.org>,
 "regressions@lists.linux.dev" <regressions@lists.linux.dev>
Subject: RE: [REGRESSION] Freeze on resume from S3 (bisected)
In-Reply-To: <draft-87msmrdgkb.fsf@gmail.com>
References: <draft-87msmrdgkb.fsf@gmail.com>
Date: Mon, 08 Jul 2024 22:00:29 +0530
Message-ID: <87h6czdexm.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

> I'll get to work on the bisection, and send the log here when it's
> done.

Just to confirm - I should apply [1], and no other patches, during the
bisection, right?

[1] https://lore.kernel.org/linux-wireless/20240517013350.11278-1-pkshih@realtek.com/

