Return-Path: <linux-wireless+bounces-12768-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 97078973F31
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Sep 2024 19:23:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D18FF1C2537B
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Sep 2024 17:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C9E119B3D8;
	Tue, 10 Sep 2024 17:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Gb+sysyK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C632B1A38F1
	for <linux-wireless@vger.kernel.org>; Tue, 10 Sep 2024 17:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725988632; cv=none; b=APwR+GKWAOfXlJ03N0U+LMSk6n7e8Cs+4VsJ4k3LImzWzqocY68gtv8shVwj/JUgxtCj9MgrJskICXcVgwliQiVKH03mj7W89x3TB5ksyW27nORzfnwjSn6lKveiF/+dvhKqali5V5T01G3xrgwQ/lexeOwprbb416eNaXKq1ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725988632; c=relaxed/simple;
	bh=oSg1jqSi6Gk43occzaUFP7TUotm9lEyrfyUHl9PfiY0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KMiXiD/mvnj1kjmd3uIvakS73guPQpOfF/N3T6i+Z0tvoju3MjVHzCXsWec/JGf2keXpMXwqRHEUeUwL3/aJMAtpZVm+kN9omsMyLFQS0KTj+yMXxvkttOnNV7Ue06JIYfRfyy8RIlwWaJInOfSGX/G6eSTaoBwEuh/evrId3cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Gb+sysyK; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-717934728adso4203215b3a.2
        for <linux-wireless@vger.kernel.org>; Tue, 10 Sep 2024 10:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1725988630; x=1726593430; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fn/AZ4xb9LMx66eVPn747xkrVzFL0qyHkUKyAmziAvo=;
        b=Gb+sysyKDpHqS0d2zrV25INJPQLpC/BtfGrtmcy0iV+vNQe0k/4wC5jVHOD3cZup52
         wo0XJztMqMaW0FCGJNuVcq0uSjfwXK36e8G6YStrV5oiMYskOtEyxAyAwZdAN6rg06C0
         dQi+F9kQMJE9PkuC7fnXOgMBCZaul4gNCeueQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725988630; x=1726593430;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fn/AZ4xb9LMx66eVPn747xkrVzFL0qyHkUKyAmziAvo=;
        b=NJ1iceo7VpUBvm3cAT7exP/5Vaq56RE+j9U3ZdAEYK4x2rQ8FfPrCKvilFTnIGHFlO
         6F7vNR9I51oucUsd/fWrM8C4hMeYZWOXSTOH72mnduBSwzqKH5zA6h+GYEkTNdfZkFYw
         CzSTt4eEGc+htch5NMxpc8NmRi/aG/qgg2wOBXIC4VwjOaiiLxZudJ0e0ppa69XFCeS+
         wXSJGzn8rp45KQFkkVkNQ41rk9lBguBIAlUbL+1JEBjsNd+40dqQ6XFrDNQgqK+VgEee
         PuSdoMaGacyNccRf0hl2cKC4cto6a7aJBHj0ptvRN6QPNq5GKxwmUw1QO2u5io20t16A
         8YQQ==
X-Forwarded-Encrypted: i=1; AJvYcCUYlDeg6eN66mYd/asOuf1GETRgfYOA/uLmjjlIVyAvqai4PEmKS/zszdBbqyhICW3loxLDvk5fORwgZsvhQQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxIgQjX7Zvutx8zWwrAUICsUjae3T1fmIe5JDSp22MqKH5WyzL9
	WWSYmhxXofFXTjVyeLf4sIht1cM+5SImcuJtSObbrWCWUBJEHjRH4XHEyagbJQ==
X-Google-Smtp-Source: AGHT+IELBBH+BVqW4jojD1yiE+U1VTuTVHaLtVLuYuv3KRyDEoVquQilq1awiMvvsKXH0tH0bFH5KA==
X-Received: by 2002:a05:6a00:2ea5:b0:717:97ac:ef46 with SMTP id d2e1a72fcca58-718e3fe638amr14703295b3a.15.1725988630104;
        Tue, 10 Sep 2024 10:17:10 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e14:7:a9f8:b780:a61c:6acb])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-7daca4d27fesm2743652a12.0.2024.09.10.10.17.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Sep 2024 10:17:09 -0700 (PDT)
Date: Tue, 10 Sep 2024 10:17:07 -0700
From: Brian Norris <briannorris@chromium.org>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: chunkeey@googlemail.com, kvalo@kernel.org, francesco@dolcini.it,
	krzysztof.kozlowski@linaro.org, leitao@debian.org,
	linville@tuxdriver.com, rajatja@google.com,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH wireless v2 2/3] wifi: mwifiex: Use IRQF_NO_AUTOEN flag
 in request_irq()
Message-ID: <ZuB_E1XasAVw52q7@google.com>
References: <20240910124314.698896-1-ruanjinjie@huawei.com>
 <20240910124314.698896-3-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240910124314.698896-3-ruanjinjie@huawei.com>

On Tue, Sep 10, 2024 at 08:43:13PM +0800, Jinjie Ruan wrote:
> disable_irq() after request_irq() still has a time gap in which
> interrupts can come. request_irq() with IRQF_NO_AUTOEN flag will
> disable IRQ auto-enable when request IRQ.
> 
> Fixes: 853402a00823 ("mwifiex: Enable WoWLAN for both sdio and pcie")
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> ---
> v2:
> - Add fix tag.
> - Wireless patches go to wireless-next, submit them in a separate patchset.
> ---
>  drivers/net/wireless/marvell/mwifiex/main.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Acked-by: Brian Norris <briannorris@chromium.org>

