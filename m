Return-Path: <linux-wireless+bounces-17577-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 78FCBA130C7
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Jan 2025 02:29:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E365161EDB
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Jan 2025 01:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08A2B1CAA4;
	Thu, 16 Jan 2025 01:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hf3LEtuy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2289424A7ED
	for <linux-wireless@vger.kernel.org>; Thu, 16 Jan 2025 01:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736990980; cv=none; b=BuRPBDPvze3GFAQOJkJgRl9/jZsdxYIBhN87NmPxYSsXmupL5t8T9nx3OjJxF2EWoMd1WAbv8ErXS17u3B0Wc8BmAeVA2m+G3afen8uZL/MzgY88DT1gkZ7oHlioKj3vzSHFJGqKKIS207RrDCHawS/VRHFdP29PmJLlYS3MHkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736990980; c=relaxed/simple;
	bh=l6d6z0QYl6ovKo3Hwn0KibZ/xIEO8FxuFcOmfV/Rgaw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KXHLpq/T/MUGPrtHVXy7Zaui80sXWt/HzvXwA/iZmaMRmaEAN6rrlsG09ERexCbjhrbXDnyq1PBbn1GF+xYX6tsrsNrMkEDqXTaz8Er//6a2/An9e8558STc479u/iop7fu/kFckBl7euGweqqsWqpg3Zyr2nmP4/jI1vPCp96E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hf3LEtuy; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5401bd6cdb4so441354e87.2
        for <linux-wireless@vger.kernel.org>; Wed, 15 Jan 2025 17:29:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1736990977; x=1737595777; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=K9T7mV2vVb98CXuz1Onh9zlMAsvGv9rLwOLXA+rehiw=;
        b=hf3LEtuyk45LEGRJm/D4VgjhnuyVRLXGihir9e7ml+75ZaWIDPW+lOKgRchoLkn9gT
         dASPhJBKcRTNGq8n4GtlzUdEgLcaDq2M4M3W0uZICUpOJey3wVwglQIAgbsskxTcrwc3
         m32Mkat9wfjecph/feXuQNxgXLomzvyGJQ2xYwXZO/Qe52ibikmA65Vjs0jSLp+8s2xy
         N1IapGyHQEAEgLAJvd/Arw7H4Xpw2yIrXevImgQmmsqij8MZb41J5JUifMlCZnXXRN6j
         lZaDVtIKNx1RyW5J+eossN1moZz7r6TxoQW+86xhSWuZtHeUR9qLtr6GhS+RcJb2vV6E
         RTnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736990977; x=1737595777;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K9T7mV2vVb98CXuz1Onh9zlMAsvGv9rLwOLXA+rehiw=;
        b=j+6xAIzgy9lgN+L4Nn5oTShk9NTw4kbm9/4WE57f+XVfbp5CVBFJNtQUhJq2YL3TD8
         WSXy1tf5rTj95LHYCYzu4fSYQE8HOz5LNBgNJ1xswCOgmH6Gklsmh5hUvs7Rn2/j0yZF
         f8bVOMGiAb2h5Eepcv+XTfGvSEUAnCHU9TVy4dDTjP9jHcr8YNwAEGzgeyaBbYBDPzf0
         Jz2iOgIZGA8APgMjL0IkKJD4wXnfdqU+DCbTBdnhjmrwlBEtZYOlsVbPLxgJbMzGZUFE
         9guyblfpvY0QFTQ9bI+AcmJ//rYu66blJvGe6tdwv/QXY/VzPqMfnB4ALEaYjQXzpbCX
         q+5Q==
X-Forwarded-Encrypted: i=1; AJvYcCVz17icIfOTlvqvm6HRxOx3a0jqsu2EoZ7I6OlugYlb6rUlWs6mBGI1UgOuNdagxVBXD0/A/8QnnkvChKHSsw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwMN0p/jxCAX1MPxik77+GOg00IJD30bAUa4iFCVwrNqKeDRS2W
	lYiWnYB3zux9YhY1KgZh6ezsI42buGFZjl54Shwrqqo5TqDsOr3EC8iEzvN8EVY=
X-Gm-Gg: ASbGncsziNkEGiHImBaY2f8q65jF/2hoERDSO9ZKSzf0xn9DLH+JV3rx5zGVQVuk91g
	7eKRlhMfHFw5xkOKrIXIXfl4GQHBlZ1WYAx34siU+fyu1tC+T9pxp185UP1ecSgQ8as12L59M2L
	nYxYz0395mj59SiT2VIH3r11wn42e7blBjhjWQqwaCUTLUfp7XKiwGVqDkkVnuRGgeNi1m06wGK
	o05VPzj6wubHZngFsD9bkdOjQbE6kiI/p2tCqAQNpDPjum9KO21/X0dJ3akqZ7krYoKlHctOOla
	f1ZRn/t6P70qq0foc82E90vJ8TTYjj2otcW5
X-Google-Smtp-Source: AGHT+IGsmCxUgdgnESZu8E5KV1JTbrVec2d1tbzdcd1alvinIyQzFkmE7CReevwd/sdV8PB3Tna87w==
X-Received: by 2002:a05:6512:1282:b0:540:1fec:f321 with SMTP id 2adb3069b0e04-542845b0a50mr10430769e87.41.1736990977304;
        Wed, 15 Jan 2025 17:29:37 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5428bec06fcsm2194284e87.195.2025.01.15.17.29.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2025 17:29:36 -0800 (PST)
Date: Thu, 16 Jan 2025 03:29:33 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Ajay.Kathat@microchip.com
Cc: marex@denx.de, linux-firmware@kernel.org, 
	linux-wireless@vger.kernel.org, kvalo@kernel.org, alexis.lothore@bootlin.com, 
	Sripad.Balwadgi@microchip.com
Subject: Re: [PATCH] linux-firmware: wilc3000: add firmware for WILC3000 WiFi
 device
Message-ID: <snk2vtgflkb5bu2pbuke7hoxpmjy23hspn2pktzplmr3ipnhgg@pz6n4eabguct>
References: <20250115171751.7308-1-ajay.kathat@microchip.com>
 <b558af8a-a72b-4568-8ed7-5be22105a5c6@denx.de>
 <798971cb-0c4c-4e5c-9e90-2488edca49a7@microchip.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <798971cb-0c4c-4e5c-9e90-2488edca49a7@microchip.com>

On Wed, Jan 15, 2025 at 09:19:45PM +0000, Ajay.Kathat@microchip.com wrote:
> On 1/15/25 12:02, Marek Vasut wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know
> > the content is safe
> > 
> > On 1/15/25 6:18 PM, Ajay.Kathat@microchip.com wrote:
> >> This commit adds WLAN firmware for wilc3000 which is supported in
> >> mainline
> >> Linux with commit [1].
> >>
> >> FW version: 16.1.2
> > https://github.com/linux4wilc/firmware.git
> > 
> > containers firmware v16.3 , why add this old firmware v16.1 here ?
> 
> wilc1000 and wilc3000 follow the same version numbering. Since, wilc3000
> firmware is getting added for the first time, I thought to include the
> corresponding wilc3000 firmware version,which is v16.1.2, in this commit.

Please use separate Version: fields for all the firmware rather than
havign misleading and incorrect specification.

While we are at it, do the old ap/p2p/normal firmware also have 16.0
version? If not, the Version clause is incorrect anyway (there should be
an empty line before the unified firmware entry).
Granted that support for non-unified firmware has been dropped in 2016,
maybe it's time to drop these files from linux-firmware too?

> Going forward, both these firmware will be upgraded with a single patch.
> Once this patch is applied, I will submit a patch to upgrade both
> wilc1000 and wilc3000 firmware to v16.3.

Just my 2c, but I don't think that this patch should be applied in its
current form.

-- 
With best wishes
Dmitry

