Return-Path: <linux-wireless+bounces-11814-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2677695BDD4
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Aug 2024 19:58:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A4170B24DC6
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Aug 2024 17:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56A5B18D64F;
	Thu, 22 Aug 2024 17:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IZ4jB7EL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA6071CF286
	for <linux-wireless@vger.kernel.org>; Thu, 22 Aug 2024 17:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724349516; cv=none; b=O9mqNCOmZRjls3/rnTIBeuWjmxHR9T/uzA3RxJVTmXrL4mcJU0ZoYF4S0lOMa4VDqVidWuj/qiMr6yVvhvQXKh+cmwtSujWIWoaYaG2SVUFY5GYalR6BrbJ2djR31ZqS+sdBz7lyjnEH3W0blA6MySO9KG9GzReyj6FGceJxTNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724349516; c=relaxed/simple;
	bh=S73uaUA0DW8CttN/Jhtd1B233vB6M3ngjcc3vgt+v/U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CimSaSHYNFjI31VpwNho28KCwWbAVjv0nTMKqq3qZ+88eazZK6t98OCl+okHxg0TEtl/qd2yP4M6W6LnaXWyw4wpT9IVvPIXIUaRM5QwyBpm9USkDMeWZOs3SWIRnLpVVkerCtYjFZmv7bC7Gr1RCitVU6AcYGb0QA4mrCOa/hE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=IZ4jB7EL; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-7cd835872ceso794217a12.3
        for <linux-wireless@vger.kernel.org>; Thu, 22 Aug 2024 10:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1724349514; x=1724954314; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6aXl0P5+cZPWz0CJSmKBVPNCrelta2lMo8G0fOIDW74=;
        b=IZ4jB7ELFfR+JOeCXRJumpolI7xWgHqQDn6V8nZu1mlKxl/nIk6kbcIGlXictm6kNq
         N9/r9PmgYKOWZRH9D+m2SwuSxUZtLBbjWDmwdCKAtlmqDryIVMO1P2meROOb3TQ1U54o
         q8o4F8crSjnVyNGw108ohCC7mm/A7PR/TvZn8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724349514; x=1724954314;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6aXl0P5+cZPWz0CJSmKBVPNCrelta2lMo8G0fOIDW74=;
        b=gKFqrLnjoXe2rWB/jSjkhoGYIcf2aJDOMKeL6qLjw/G97JZdGbo5YKEMnWGMzfLncO
         3ax+fWsrzKNWiq3vr1uiuKVQTMl4zZwRYwk7TKExSfGAqL8b6pysjnMcMdHZoK7lgqZn
         LFaPI6TMZzVSHLCSLSZYTKPJ55e4Og22EPKG6MLsgMb3uAkOqD2fDKF+lxlZtzkMHr7R
         gZCsm6iYwHd/Il5e/BqfBWcyS3IL2pV0Ik0hyhC5EZzjWkvvsMGfMeQPAjCKo1OfFPpC
         6ouPrxw+0yfzBftKITfVBFslOoAypCNLLcRkKY2ktUAJdqGEbbj00RbKi9KjiKHt/jvn
         qOIQ==
X-Forwarded-Encrypted: i=1; AJvYcCWwP17hsvOH8DJs0yF2XOJV3SlH3/773Ku+1lAoNyuVWNrCRDC159tFYwvL1sGLyZoIc5dX1Xn6xX6SJhQ8nQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyClkq4sltQQoy6aHkhMX3dieQQs8/7D+Wf7H+/b6E3kBBjUKk2
	cJPB1k/1XkJLevKM9q41BZlask+Xu8rOpwBOVObTuLFQwM/cJykjTog9hByHHHBBR3TUMt9R2sg
	=
X-Google-Smtp-Source: AGHT+IHRCAtfbv2wW3c5v+2i+dD3SGwv1uIaS3D1NnMthKKsznW2OPiT8cq1knA2oMx203qjIZrdww==
X-Received: by 2002:a17:90a:634b:b0:2d3:c303:fe14 with SMTP id 98e67ed59e1d1-2d5ea2caf9dmr6288794a91.40.1724349514149;
        Thu, 22 Aug 2024 10:58:34 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e14:7:414c:5b44:2fea:fb6e])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-2d5eba287e7sm4473583a91.34.2024.08.22.10.58.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Aug 2024 10:58:33 -0700 (PDT)
Date: Thu, 22 Aug 2024 10:58:32 -0700
From: Brian Norris <briannorris@chromium.org>
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Francesco Dolcini <francesco@dolcini.it>, Kalle Valo <kvalo@kernel.org>,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel@pengutronix.de
Subject: Re: [PATCH 01/31] wifi: mwifiex: remove unnecessary checks for valid
 priv
Message-ID: <Zsd8SPnKKJrdJj9W@google.com>
References: <20240820-mwifiex-cleanup-v1-0-320d8de4a4b7@pengutronix.de>
 <20240820-mwifiex-cleanup-v1-1-320d8de4a4b7@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240820-mwifiex-cleanup-v1-1-320d8de4a4b7@pengutronix.de>

On Tue, Aug 20, 2024 at 01:55:26PM +0200, Sascha Hauer wrote:
> The pointers in adapter->priv[] are allocated in mwifiex_register().
> With an allocation failed the function will return an error and
> driver initialization is aborted. This makes all checks for valid
> priv pointers unnecessary throughout the driver. In many places
> the pointers are assumed to be valid without checks, this patch
> removes the remaining checks.
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>

You already submitted this one separately, and it has now been merged.

