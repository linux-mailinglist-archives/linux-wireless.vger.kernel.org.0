Return-Path: <linux-wireless+bounces-27761-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 447EABAF01A
	for <lists+linux-wireless@lfdr.de>; Wed, 01 Oct 2025 04:23:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 061731C8A89
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Oct 2025 02:23:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3E8F271443;
	Wed,  1 Oct 2025 02:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b="j7WTbf8v"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 935B027467D
	for <linux-wireless@vger.kernel.org>; Wed,  1 Oct 2025 02:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759285345; cv=none; b=XKOz/Cw9OGCHKrWP0kzKvPXx1imbnGusCQaffqLl/oFyw+kOsme/DWF98HLQOJkDBHEHRcF7l08qTMZbXx/FMhkG/n6Wz9jYY26LVDURhgOYt0sW6p2i7btWlU4W4F5p8/lL704YOi+zz6F3sJGUaV1tXJ2hV85N3LybFInntZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759285345; c=relaxed/simple;
	bh=Up7mUUavwXPjJCGjmwHouTEEB+vbbpXW8+Hhb/r6Wls=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=bFPx2K4X5fZbza/8m0VLlVsGqwOr4kz+e+3W8KUS+kluG3QeMa9VXTakDftiJUFaOmygaWxb6LIe5zLlSfMGMpXV3MH89Zd0pQewRZVCVtppSOaqhDC91KpFwNhZcYEc/9yvDRe7mkXgTuubbiWErViHc3dPQwcya6DlsbNktAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com; spf=pass smtp.mailfrom=morsemicro.com; dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b=j7WTbf8v; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=morsemicro.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-26e68904f0eso68295575ad.0
        for <linux-wireless@vger.kernel.org>; Tue, 30 Sep 2025 19:22:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20230601.gappssmtp.com; s=20230601; t=1759285339; x=1759890139; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Up7mUUavwXPjJCGjmwHouTEEB+vbbpXW8+Hhb/r6Wls=;
        b=j7WTbf8vGhpgA9mOGK/e/1n5R8k0gBPG0tZArlFpO1QRGL4ZL5K6T1QlHA8FnHzsZe
         W1D1jVJeIU4FN5XUmBgYCBiToNAA3Xv0f+VW3iqhIOADvzBtKXMPo0H6OhRzuuZvnZz6
         /o8a5D+4aN2skisue9PUt2ANpvgDLlKX0SLhN2x4cPo3XGo+IvYpWKZpy3Ay+2BETyrR
         ufcj07/OSMyLn1o8DrjSrt+c/KzoNCqRz1UZlN9EJ8jJ+f2Ju8+0bl+lrHCn3nE3gFGl
         oJwX6/z6eEG3uyMrFJeM7eN+s2jI42pq7gFoBztAe8sZcf3gzH3uZS1t//CQreMjjDiL
         LROQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759285339; x=1759890139;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Up7mUUavwXPjJCGjmwHouTEEB+vbbpXW8+Hhb/r6Wls=;
        b=wVmNHOzuL27XgVOBL2EiHvidlklMRJ6dl+FS34xcKV7MjURfMONFxQhjrTAzDL03Fz
         +yoQFUWTtkpWX3fO7dT78mi2MUIc79fa4fPwCemGZEvXUCDuGLu9iwrADY5LwPkkzr7V
         5S2O0znoHpXzcm/DD8itIdbwY3JB/0sh1S/FQd0tfhXUcL6aPhDYtQFiIOG+Gm4b2Q9c
         0zjPLFi6YNYKz0DCVNawonl7a6u08EXk02VJluY0LlblVzBR2RTyhS7x5FDz0ONHQFTJ
         FjJqe3yREOcSCU9GSlhoTs7iv2WcUUF6Ca1bVIja9XsQGGt22eeF8RszkT/y2Wcw7arv
         Pafg==
X-Gm-Message-State: AOJu0YwaqwbBJzLExyc0fzZqOhV3OysBvyzWSB9OJCNRaCnE8vkEb0li
	v+D6eil6rGgRuJU6aeTiUnUPIDBUOS8BBERdkqSTtIlvT+Rb5hxxATV5GPwahqFLr2yVxnEzpW6
	d0Nsdbho=
X-Gm-Gg: ASbGncssNhBf35sGud4Iq43ZgnuzzIldcn1Zw0SJiFlON4n1sCmBiflWpVtSLieTUvK
	zopoEs26dgpa3uttxGshkXbnioWmGds42wyyva3+nMWs2I7c9ztHtSVB2kZl8/CzhD8a3yx62xw
	W2R1OiYd4vXyA3+c3oRhHTgiRcV43ZsyKKLVsEyt4ZV6TxsK77jUsOj4fu9XMMXKhDpXGwksdNs
	OL8i8PgKvjYSf+Y1X8Qg/0y2tZsENQhV0WrpYDEFGN9dUyrlO6QF3Z32RZVAw8wEjHLcPPAjSeF
	+cIKqews+LlRuzRpWEqyflEHpRIcvT1fehoUil9Tf8dm8TG952F7VI4Pq+A1Ns6GuWVqxHLBTNF
	AOgTLdFQvHW5rn5/w8eOd+KuYbuVFjBMvkuERasU+UVhZ344+W+vc
X-Google-Smtp-Source: AGHT+IF0fIZqfwDvTgFqBC9eqB05PnYw7hw3nEmrmko07ktplx2RdCI0xghawa00qq8nrSnhQlb4QQ==
X-Received: by 2002:a17:903:2446:b0:274:3db8:e755 with SMTP id d9443c01a7336-28e7f2f7565mr18866295ad.30.1759285339609;
        Tue, 30 Sep 2025 19:22:19 -0700 (PDT)
Received: from localhost ([1.145.22.120])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-339a6ec129bsm983320a91.8.2025.09.30.19.22.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 19:22:19 -0700 (PDT)
Date: Wed, 1 Oct 2025 12:22:15 +1000
From: Lachlan Hodges <lachlan.hodges@morsemicro.com>
To: linux-wireless@vger.kernel.org
Cc: zandr@morsemicro.com, lachlan.hodges@morsemicro.com
Subject: Tx Power and Antenna Gain inquiry
Message-ID: <6rmkb5zup3i5wnyjg3abkh227wk7hpe5k6mjmf2drpsebpkphj@gec5jtrnh7jy>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

After reading the available documentation and poking through the code, there
remains some confusion around the TX power value in nl80211/cfg80211.

It's clear that the redgb refers to EIRP, as that's the way most regulations are
specified, but while there's a notion of antenna gain passed down from the regdb,
it doesn't appear to be used anywhere. This makes sense, as a driver may not
have any information about antenna gain, so 0dBi is assumed. This assumption
means that EIRP and conducted power are the same value.

However, our driver makes use of a "Board Configuration File" that can contain
antenna gain, and in certified products is likely to have a non-zero value.
Given that we *could* report EIRP, should we? Or is it more appropriate to
report conducted power? Should we report antenna gain or EIRP separately?

Thanks,
lachlan

