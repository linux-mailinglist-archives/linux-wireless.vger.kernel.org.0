Return-Path: <linux-wireless+bounces-11644-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 677C9957A5D
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Aug 2024 02:16:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 958971C239DF
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Aug 2024 00:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A9E84C62;
	Tue, 20 Aug 2024 00:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NkLVtR5x"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 115A46125
	for <linux-wireless@vger.kernel.org>; Tue, 20 Aug 2024 00:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724112985; cv=none; b=MgHxQHjwxML1vyEcKVh2rFvMbKZbGTqEDrhEkxszy1aOAiShqodtPeJq51kX9wNYYUP6Nu4omWbxUjX0eggrQ82gDz1XwNuVMOk9uNesbYLEKuOzpqqCyCfs/beu0wsLrzYXtkoO7f2QIKFSA8MjvkzGn7zcGXZ54/QYRwDOZW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724112985; c=relaxed/simple;
	bh=gWVNtklo/DT5OMxK4e8dh2MliUZqgR2m2cnOOfLqdCU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YXwXkf5Q44et0xSA1WSxIgUP1N9eMfR1NiGK6HAJTzCeEenyrZ3ZAWjgnTVXspmk9hsRlnXwGRvOokgpC14+pDRxAVbAjE/qDchpARCg3Qn5sGNwCsVHkt6FF85eiPmQ0rFVtyc3PIHS/xWEqwl6Q4pYUG4atKWjpjT/3Wx82r0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=NkLVtR5x; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-201df0b2df4so37747305ad.0
        for <linux-wireless@vger.kernel.org>; Mon, 19 Aug 2024 17:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1724112983; x=1724717783; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=K9N3cTfP/dg7onHPw5BVcBp+wX7BOvsjJXAFs30MUm8=;
        b=NkLVtR5xkb9x50vJVqcRV+kOepem3C82Pvk4Fl5WlpWYS9HO1o6oICBiFHi+lTYgKn
         ul+4XAAKvxybrhtkUzqGVbUCvUCnmSJ9jTFOUHilhlL4S6RqMalRzrOzT08Aeax0cGwj
         WR1SB/4D0Y6DyQHd+JiT8rA/rEy/64dGg3R2I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724112983; x=1724717783;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K9N3cTfP/dg7onHPw5BVcBp+wX7BOvsjJXAFs30MUm8=;
        b=RuwrI04zBJFmYPC8hMIdgHzXfFFYqGSPTKTK4ydK9O9mvutJJ9S4nbV925Un5vLX6M
         BBlUdU04fHy+Kp0xBFk+v4vGj38uR/dvSrPwAncM0jN/ekJBu1Leb6Ms80wCWj3iZETJ
         FO5HF5MW9HwidsF/gFy7sBrFcw1mzmhqMmFBBpU3t0uL6Q9FJDwlbTrjsnvDF7oxBGnb
         wnO0n744SjXJ1BrJqtMd1zzoTOktG7J5N6yZw02VB2mwXijGB/0luXPflCfb27+xg9Ci
         lylL51U0gk0oNZIYDZq6Y5GaiF79RH1y3FokIqXoBAvSVXH+OeOvI0HKmEzp116904ip
         ttOw==
X-Forwarded-Encrypted: i=1; AJvYcCWMd68O3S20uvOhK78TyNHnfRhI6X/imIhza0LAqlpG8v9Ee8xWGLBptWmXKG9xzgJq1O22CC9ziUr0IOktBw==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywvg5kkLM+/KDERgu8MsM8n1ypLvoSlAY2gLXnHVvw3OnwwMF0X
	NOKyTgaqDyT9VpcA7RiD4nijKVTdirAQnAJ4+3uKaZlzAD5LAXaxxmMroDEEag==
X-Google-Smtp-Source: AGHT+IGdXHDLYADLsciH2qFBjlWj6nZa2mOjwihgQjDQOFwiAOL8MYQVozk0LMShUHg2qILme+Y8vA==
X-Received: by 2002:a17:902:f988:b0:201:ff75:fa3a with SMTP id d9443c01a7336-20203ea01c9mr106734875ad.23.1724112983346;
        Mon, 19 Aug 2024 17:16:23 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e14:7:917:3d68:a539:4ba4])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-2025f819db7sm3116295ad.257.2024.08.19.17.16.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Aug 2024 17:16:23 -0700 (PDT)
Date: Mon, 19 Aug 2024 17:16:21 -0700
From: Brian Norris <briannorris@chromium.org>
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Francesco Dolcini <francesco@dolcini.it>, Kalle Valo <kvalo@kernel.org>,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] wifi: mwifiex: remove unnecessary checks for valid priv
Message-ID: <ZsPgVTYDnN2VW4nf@google.com>
References: <20240816-mwifiex-remove-priv-checks-v1-1-6dd6553e8ed9@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240816-mwifiex-remove-priv-checks-v1-1-6dd6553e8ed9@pengutronix.de>

On Fri, Aug 16, 2024 at 08:56:10AM +0200, Sascha Hauer wrote:
> The pointers in adapter->priv[] are allocated in mwifiex_register().
> With an allocation failed the function will return an error and
> driver initialization is aborted. This makes all checks for valid
> priv pointers unnecessary throughout the driver. In many places
> the pointers are assumed to be valid without checks, this patch
> removes the remaining checks.
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>

Acked-by: Brian Norris <briannorris@chromium.org>

