Return-Path: <linux-wireless+bounces-7103-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CA7038B9397
	for <lists+linux-wireless@lfdr.de>; Thu,  2 May 2024 05:09:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BBD1CB20FB4
	for <lists+linux-wireless@lfdr.de>; Thu,  2 May 2024 03:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66B351AAD7;
	Thu,  2 May 2024 03:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="l2BrBpXw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87EAB1643A
	for <linux-wireless@vger.kernel.org>; Thu,  2 May 2024 03:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714619377; cv=none; b=B69zViokvEGdwOiqYS6UAXJCD9TduaP5lSvuG55HmZP/gZfva0xlL6//is2Zze936GuE3MADsn4pSwkj5t/G5N9H/rLA82gmBrPTUxmc/IPfI7eufuDlIhHYPXmAAlxo8KO00PpIrgicnLekMrgpEl/ZuQkooG4iPcpkawVkLrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714619377; c=relaxed/simple;
	bh=ObnqFPVJOTz/epn03UheMK7LRvxMU5jZn7hFT/Hpy60=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NQD2dzFGn8W2xVB52DnWvJoOzDJDu2GUquKYlC3q43NG6FFNBS6RL5RwEU1Qg7YogFRVW6n8W9iQFSKhYERACgjA8ByXWnZPkpy2BwGnhN3uFX0LB3uuFJyHZxx+tqF6ASCLR4VTZ60+zDMEndsEsIkHoYx0gb4VUeRe9bj+dNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=l2BrBpXw; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-6ef884f86e9so1108421a34.0
        for <linux-wireless@vger.kernel.org>; Wed, 01 May 2024 20:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714619373; x=1715224173; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EKgwrwTMRQLSvRu8Y+P7h6K1IEMLBlHp60PU8wkB+Tc=;
        b=l2BrBpXw99T0OxKVhwO4ObGOYxbOMQTp/p/8kX2aFnb3TBH+1OAebl3jhB/K6tkrqS
         JKH3YuHNX4Y9g9LeRcXRZ77UvyGg2A+FazA+ruEyJBxZhdMT7B89/yAHsoa9UwAhT4BJ
         FE3cZWFeqitKje5HfKBqRxmW9FEmmvyMWa2Qg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714619373; x=1715224173;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EKgwrwTMRQLSvRu8Y+P7h6K1IEMLBlHp60PU8wkB+Tc=;
        b=GQQd7QJvD+lpjMuX4QyFNuP2UPOKwYCbQHpM4N5BetTh9sjV5g6/J1fdrL+zHRpXEM
         rgJrDZj3KN3SvvCANLhuikNBzouwY0Xi3AaJFMtcMgUvbTLx2/rjRk+IathFoF1ZqkPR
         1xX00LcVtOe9bGCWqGY5TGVyNx5OG8K9GfA9wOZllp+06Z0nGbbv/v9pu87vCliDtJqx
         n2AzKaPPZ3lPFVhMkx5P3kGq/m8GTMcXt/UBQQy60uIhffKXxZTA6SnZWA+JEBcuuaHj
         qmXBPTFHeZ5/YmJDzh+vp+cS4i7BnJpFtnpXrifoqBvwBaqKWvDmibBQEEFDNTwODgIk
         i2Og==
X-Forwarded-Encrypted: i=1; AJvYcCXkttsHpf4TzznPxGjBTKDWhsmdEedzXzt+FR4KkKuxvvVkamzjmLfkP34ExcSNMxq8fSkZ5DA/cNHEjMeJsUA7MaN01Y+Pynw5A8msBrI=
X-Gm-Message-State: AOJu0Yz+ib7cE1P1zWaTzyF67dF+eGHNZwPuJDczGwm7t5jmXSEpPH8C
	FDB3AQEVKIa1vk+4T+sCzJ3+iFch3M5zL/6jljl+uIlNXuAddduYK3ED3qF75A==
X-Google-Smtp-Source: AGHT+IF6cchS2nf9nvU4tH6sibgafgLKaNFYJ0b+TDZI9sKzN9Y5depOzEmZDH9tk2s/8AQg1mmTyQ==
X-Received: by 2002:a05:6871:d283:b0:22e:b736:7c18 with SMTP id pl3-20020a056871d28300b0022eb7367c18mr1224381oac.27.1714619373630;
        Wed, 01 May 2024 20:09:33 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id u33-20020a634721000000b0060ec09873fbsm102002pga.7.2024.05.01.20.09.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 20:09:32 -0700 (PDT)
Date: Wed, 1 May 2024 20:09:31 -0700
From: Kees Cook <keescook@chromium.org>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>, Kalle Valo <kvalo@kernel.org>,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] wifi: rtlwifi: Remove unused structs and avoid
 multiple -Wfamnae warnings
Message-ID: <202405012008.38A5EB34F@keescook>
References: <ZjLFIa31BGPVCGh1@neat>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZjLFIa31BGPVCGh1@neat>

On Wed, May 01, 2024 at 04:41:37PM -0600, Gustavo A. R. Silva wrote:
> Wflex-array-member-not-at-end is coming in GCC-14, and we are getting
> ready to enable it globally.
> 
> So, remove unused structs and fix the following
> -Wflex-array-member-not-at-end warnings:

Heh. Yes! Very effective. :)

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

