Return-Path: <linux-wireless+bounces-5158-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ED01887641
	for <lists+linux-wireless@lfdr.de>; Sat, 23 Mar 2024 01:47:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 800681C20B21
	for <lists+linux-wireless@lfdr.de>; Sat, 23 Mar 2024 00:47:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 886EB7F;
	Sat, 23 Mar 2024 00:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="D3t7J/ea"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02ED9610B
	for <linux-wireless@vger.kernel.org>; Sat, 23 Mar 2024 00:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711154868; cv=none; b=cJl5E4HAdOgBny6MAYRh4Hf6zZRniVFDJxliGgSDABE/zWfTcp/i6dawfhWIT6mQ/4tXsNLaOZa/toAd+0IhMrYIBbv1zgce1VC5RpyMCuxGg8iLHjaZgFuo/DfkWowzC06PmxfpcguqARpCWyHKF88cMkTQdWELbtXKU0L5WMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711154868; c=relaxed/simple;
	bh=YPvEh8GGyAWNYBq9cCuktoirQCoSq8OiWTRgCg8BhaE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y0kBrzVb73VK0OOO74Y8uljHNE/tXIZrzrKS2cb9W1+vgs8UYpFD/NbYFZnVuL+JYS6K8xbJDbV51B6kuB99WmNGb8/EBOi2faNWVaT0X6qDwzZZcqPrgKE9+E2GzFxAJXKesrOUjoPiMjazKgO802JLEJdj3H9Kfa8++gI9+So=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=D3t7J/ea; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1e04ac200a6so19334235ad.1
        for <linux-wireless@vger.kernel.org>; Fri, 22 Mar 2024 17:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1711154866; x=1711759666; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ifwO8MV+U8fHsEV380klKcwxmnbQH9YOBNoSAhp055c=;
        b=D3t7J/eaKYOFmdRC2AjmQk0se5DsuyYrE3SCt5XOpc93UX2s0KznP84EnR8WNErd9T
         1prm6rgEAjxP5j2ZEUNlXnqZGmJc1fmH4VltFmnOFhJ1D+iANwkF0YIc5ii9miOwxpM7
         0DqxLFPMdy/mAGmegeTefZpe0POUetyJzrx6Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711154866; x=1711759666;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ifwO8MV+U8fHsEV380klKcwxmnbQH9YOBNoSAhp055c=;
        b=fcYZGm4UhGKvNTh+V8v5+ZbMOLJ55uA3odMpmoob7+4EO9RrtKPJMDFaSxfuwndAQo
         CRrUEFc5ACMmbet6ScsB7jiojbpbIQlpt9MlTZapb4iPbQqJiXpaVPWVo15Kf3LkLBsU
         bz29nHX2Y2o+4zjYqiiOCx/nzsB3bk4agKcXaowNUiGCOiUAazaVCZoOmRHETyG2K7N3
         v1Pe0cuMvSsyAIqmrc5r1S0QYefYyCs3JgQALkCK10ho9VlWaaQONzKCON95loQjot7m
         SmUzCyWEaaBFPNSQxVyjTEiS2PhucWm9TGb4FkreoqWUzJ9MDydpQpy6Q1qGb05oVfgf
         q0zA==
X-Forwarded-Encrypted: i=1; AJvYcCWqns9q6bd5hVOe7bd4FiBzzX6UhVSlz1uYrcbchG7sXwdrqkkGoarGp9JgjYtZ+cmdaZRRFZW1Sf+nKjlGnWZ9M92ZTVQQ1xFtBpOkbWY=
X-Gm-Message-State: AOJu0YypzljbNbc8ogIwUj2snVpBwqpslUC6dDWof87b0FzK7tW8Ic6A
	GXuKOL749VyTZcO2JhpRQqmgDRaIDwZhmXARyDHPTdsJtkF5POByR0Ul1tg5Vw==
X-Google-Smtp-Source: AGHT+IEYYBQoPCbqgsoBTUzTjsAJmBtl5cuYEV05iAqCeBpp2CszE8iuxt/0ErPK9RSra4XpuJ9x2w==
X-Received: by 2002:a17:903:234b:b0:1dd:69bb:7f96 with SMTP id c11-20020a170903234b00b001dd69bb7f96mr847427plh.6.1711154866269;
        Fri, 22 Mar 2024 17:47:46 -0700 (PDT)
Received: from localhost ([2620:15c:9d:2:c164:9ab4:de9f:5f33])
        by smtp.gmail.com with UTF8SMTPSA id t3-20020a170902e84300b001dcf91da5c8sm372788plg.95.2024.03.22.17.47.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Mar 2024 17:47:45 -0700 (PDT)
Date: Fri, 22 Mar 2024 17:47:44 -0700
From: Brian Norris <briannorris@chromium.org>
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Kalle Valo <kvalo@kernel.org>, linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: add myself as mwifiex driver reviewer
Message-ID: <Zf4msCV3eGqGL6-U@google.com>
References: <20240321163420.11158-1-francesco@dolcini.it>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240321163420.11158-1-francesco@dolcini.it>

On Thu, Mar 21, 2024 at 05:34:20PM +0100, Francesco Dolcini wrote:
> As discussed on the mailing list [1], add myself as mwifiex driver reviewer.
> 
> [1] https://lore.kernel.org/all/20240318112830.GA9565@francesco-nb/
> 
> Signed-off-by: Francesco Dolcini <francesco@dolcini.it>

Acked-by: Brian Norris <briannorris@chromium.org>

