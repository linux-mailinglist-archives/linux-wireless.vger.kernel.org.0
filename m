Return-Path: <linux-wireless+bounces-15443-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB9699D0942
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Nov 2024 07:05:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 669C6B233F2
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Nov 2024 06:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B11014658B;
	Mon, 18 Nov 2024 06:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="h1O6cVvK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70C10142E78
	for <linux-wireless@vger.kernel.org>; Mon, 18 Nov 2024 06:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731909810; cv=none; b=JxhL8P41yLQ1U6wsk8Y+Kbv18NCgbExx6xVUi75Afg1M6JnxOmvy1LFCu/Asss8Kqyx5VV9f7wZWHk+OwVM/c2p6JBZJDOZElfqXVdlcnIjcAs8Fuetyw5GLkyKSpLu15wToK3FKatqAZo/9iKwF4256jieOgdtqKS4sbl4GQdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731909810; c=relaxed/simple;
	bh=4BAXl/N5qs5x1KD1SM9rYhuStYyPUTHtfJIvrbnxABo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VN4zA5CCeZWU1iqj0OahK8lP1j+dS18RqY7gkI3pXxjBPo8xcuVrLx8Cl+mwN4oLhUH/RUtG1I1zCMvBK8o3olwXoCupkzN9d/HsjgNC+eEw0LbcBwkXZpCqb5LwDtA5/IcdHNgPgBfzELTEnEoYZ8G38qLIm0xhtc/YmKehy00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=h1O6cVvK; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-432d866f70fso32961685e9.2
        for <linux-wireless@vger.kernel.org>; Sun, 17 Nov 2024 22:03:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731909805; x=1732514605; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AR8vRiyQWafhkwLMuApVW/fxma/Zo6ed3zIRAdgzhAY=;
        b=h1O6cVvK6aOIMYaUWJprIfXU8YVaS2b3GxbNg/wa1glq40lKAnNvDEFZLYoyRym1A+
         eEoX30YAmEouelMstFimJmFcpUs7hDyVBjMAjuhWUgOPoNBwlPQC6hOHuDFcL+SLCRAJ
         QrCOAMVoL/Mz6vwSrDFRt2aqDMo2L8qZ1osUoPgfHn9pR4xqVWgVGkEJgyPsn6I2gpWA
         EtVBM0CSJD09rajrVnWOsmMqKeTnmu6m4XumK6kYW6s6IlkqJvEiLs9kPBB7XCOFDQFB
         syKEIB3lY4BR/YGuB4Va5/QWR2MTiGja+m6tM1RhmzopuTcJ1aiCaWLEKcwmSo/P5twq
         bWEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731909805; x=1732514605;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AR8vRiyQWafhkwLMuApVW/fxma/Zo6ed3zIRAdgzhAY=;
        b=BoPqBb/iL6ICH+HZXWsrA2+6TRgPR4QwmyK8lxXkkagymH9w/MAwzDo7dIKZ1NBaDt
         XZilnfMhc5oUxssBA5OdN8Dgwj/19jXsKrba17dz+l5yP6Eo1bFgniRyYr5GQThKAqRO
         pAUMc1raot70tQkDFm9ub68kLsNof2RdwjLWGWpT+YDl5/QBUHKs5mAyGRA+tn7xqSo0
         buqZYMCmT2gLjYnnLqmFD/pkhIy+aNicJVOfqI1wZ/KNBQvbkezsZhVwChje3EzYjHW+
         TZq697WZMD46QNUm5uEpr7aG/1rwo3+a2QVBgtfH5RfTZ7MG4BrW2LuL9IpH5kWMlj2W
         tu4A==
X-Forwarded-Encrypted: i=1; AJvYcCUlskI7kkY0KxnmfyOHHxZpTSOHOZNAHOJ8YVMPfgMJ80neYvcapVfBxElXctW6HVLL+8GOHfPOFmc3TH7GbQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzt2Z2F28oaRusuKbgV6ZwB3j6khNqb/9myWmhDTMCqdqK1Rm1l
	F4Of1bnm2Q9aiuZc0i6UZ/u9u2m5n/WeVZT/ZND2vs5/SyY/5UH2eUmjsZzlX6o=
X-Google-Smtp-Source: AGHT+IGbozm5imyvI1diBD8cPltGKKe70Wh5xUrFEtI3IIMcZHzRvhf6hhocFPZiJAaaikEibw1ZfQ==
X-Received: by 2002:a05:600c:1382:b0:431:5d4f:73a3 with SMTP id 5b1f17b1804b1-432df74f0d4mr84755155e9.18.1731909805553;
        Sun, 17 Nov 2024 22:03:25 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3823ef97042sm4424753f8f.35.2024.11.17.22.03.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Nov 2024 22:03:25 -0800 (PST)
Date: Mon, 18 Nov 2024 09:03:21 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Shayne Chen <shayne.chen@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>, Kalle Valo <kvalo@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] wifi: mt76: mt7915: Fix an error handling path in
 mt7915_add_interface()
Message-ID: <98b8f06d-e8b7-4a49-8508-ea87c385bd30@stanley.mountain>
References: <b9d8fbfc19360bfe60b9cea1cb0f735ab3b4bc26.1727639596.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b9d8fbfc19360bfe60b9cea1cb0f735ab3b4bc26.1727639596.git.christophe.jaillet@wanadoo.fr>

On Sun, Sep 29, 2024 at 09:53:40PM +0200, Christophe JAILLET wrote:
> If mt76_wcid_alloc() fails, the "mt76.mutex" mutex needs to be released as
> done in the other error handling path of mt7915_add_interface().
> 
> Fixes: f3049b88b2b3 ("wifi: mt76: mt7915: allocate vif wcid in the same range as stations")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> Compile tested only

Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>

This fix is still required.

regards,
dan carpenter


