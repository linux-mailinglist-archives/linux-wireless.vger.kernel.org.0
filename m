Return-Path: <linux-wireless+bounces-29208-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B458BC753C0
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Nov 2025 17:07:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 87FDE4EC8C7
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Nov 2025 15:49:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA90D22424C;
	Thu, 20 Nov 2025 15:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RhLC6IbP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1BDB35BDB1
	for <linux-wireless@vger.kernel.org>; Thu, 20 Nov 2025 15:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763653687; cv=none; b=dmk+gBdn1UId68BvXrWv5BHVRqNqbPAN2fOoBYlZsVjf7V2RhYTVil7bmgK6Ew/A9DyhdMFzPFjKwdDipEtSwBVyiWbMSJ3P/rX7Rf2qmfZH/58qusTCDcrLLrE7uTdjd6l3bolgqdINJ5XUhg0oxOOcvFlFTsJvYNBOCG1YN7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763653687; c=relaxed/simple;
	bh=IRbkoYxQQluctkVdFLAuwk3fDr64AT/iSdl6QATShR8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QhGMM9AQsQH++Tf393nqbb40DefKIWvro1M4/6qrYlkazbgBEgKWbohbQUzvqrE4MJenUIjRwxp6X70mxIOWHl7s/E1K52wwxoejFiEU1JL0CXQn645UQGYT3v7X3zOw9KEMH4/ivDcrKGEuNII5CkFY6qc0Hlg7FMQ9YaHua2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RhLC6IbP; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2984dfae043so10132155ad.0
        for <linux-wireless@vger.kernel.org>; Thu, 20 Nov 2025 07:48:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763653685; x=1764258485; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AwEkK5jSFZuMDBvUkfBRQTZPPADjedHuieFQnkpw8As=;
        b=RhLC6IbPgBKdg1YJWOUHvFGO8VjTtRvkIxdSKQPxujqBp8vXycTa3xLSZrxHc2exfV
         pnsQUQPxn5l8/2doA+19MSwz1QKVCW76BmHH95oBur6a/vor2jbHNBNyges76/T31sG6
         PzTH8vP7O0L7DkKXvfciFl6s4/V7vBzy3udtQzZNIWDjvxLF9b+hbSRkBs8RPndbolEp
         QXwzkHICbmyac8+mmps8w03OR0PMHjHmqNvVWmftujxU0u2paxu7Am9K2642XxktV35w
         WwskzfvIFuz7TuBXbm1dNBfV6SdtV/qlmrJlH832/n5TV84FW8pbnXNsQ07AZV6HDAeO
         rJ4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763653685; x=1764258485;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AwEkK5jSFZuMDBvUkfBRQTZPPADjedHuieFQnkpw8As=;
        b=bFNEjMGsLhtbcQm93MbSB83oAqwWkOuXp9e+MIArifPDKY7PTkO93s03rhHojTMBfD
         oPV/xzckzLfi/66J4ZHYb+K/9rg7Xc9AKScI/xll8J5A23SqQjvalWNqorIUp800GkWO
         ggcEbVJexSV+O4GitI1Km5dOhUCWhWwWLlHTFC+YelH0vb2HpSgSd+8EjXunTPkYmk6H
         Ti9P4iwGUq1fnyw6jQRdWzEm3qRN6bXjS8ySW1jzqhizUabY+4gvESot1HBipDZUVK4Q
         aT+tI9RWWr9SyavfBg5qxkLs7+kRxZwIqruLq+BVUjHkj41q7ZiMYaGiVWrndosJLRLF
         LNog==
X-Gm-Message-State: AOJu0Yz6qhq2cdiIMw5nSMEpzA4D+j05Ohd8Ya3jFsqIuOt9hv1JB20M
	19S/F1buP+Jpg91DSg09YOdBJth8i6QLdsopNhe+gYETdYR5DznLyp1o
X-Gm-Gg: ASbGncuzAsce76DnFze0x9LF5V7NHPnz8/UMg6ag7mOcAMfQa8ylEuXc9vY7JtG1jin
	odMYVyHwGVWKzqPrd7/EpQwPc/Z/JZMNfj5kM4NcgTbVRtuIRg+yYP1dcCj0nNgc52M6wChfaKh
	K+u8yKKelG7Ax/lJ3GWpcUyzYx2NLePWVgphClOEvmaGnBfebLV3FfLfScJF0fnEfmNc39i2vh3
	bVr658vktjmmrQAS+Lxi7qnQhEjL0ym8do0zYSCxGPCQvSEQW0wl+wSuk9Su5X8D0qQqzEIzYum
	LYL5hMLtZjGNrTVNkTaI911pWv5k/EwXW2ofjDmDWqjRS9idB0cqyM2HBPUccZWZ0JMAv0hXxY2
	W3KAitk39WpNY8baMLwiAjBIAQ62BNsEUqLu77Dy9ZCm+ttYok1A6RyDaLqnjnhlxH/F/u1RWDN
	IJ2Ev/C14fmKEIqg==
X-Google-Smtp-Source: AGHT+IF1cYNra48Ey1gHhqFXvT0lrq9EADr+g52aTE6gFMaLzYCRvegzk0FcUdwgJ2cryhM1ZFxgkQ==
X-Received: by 2002:a17:903:1a26:b0:26a:ac66:ef3f with SMTP id d9443c01a7336-29b5b03b1cfmr42221615ad.8.1763653685046;
        Thu, 20 Nov 2025 07:48:05 -0800 (PST)
Received: from essd ([49.37.219.248])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29b5b2a7ad6sm30282175ad.87.2025.11.20.07.48.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Nov 2025 07:48:04 -0800 (PST)
Date: Thu, 20 Nov 2025 21:17:58 +0530
From: Abdun Nihaal <abdun.nihaal@gmail.com>
To: Jeff Chen <jeff.chen_1@nxp.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
	briannorris@chromium.org, johannes@sipsolutions.net, francesco@dolcini.it, 
	tsung-hsien.hsieh@nxp.com, s.hauer@pengutronix.de
Subject: Re: [PATCH v7 18/22] wifi: nxpwifi: add core driver implementation
Message-ID: <f2pjxhk2amhubmu4vvhjqcy74u2ine55oswka2ybykgnuajh4x@eyyegw3wfrsx>
References: <20251117110046.2810811-1-jeff.chen_1@nxp.com>
 <20251117110046.2810811-19-jeff.chen_1@nxp.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251117110046.2810811-19-jeff.chen_1@nxp.com>

On Mon, Nov 17, 2025 at 07:00:42PM +0800, Jeff Chen wrote:
> diff --git a/drivers/net/wireless/nxp/nxpwifi/main.c b/drivers/net/wireless/nxp/nxpwifi/main.c
> +
> +	adapter->workqueue =
> +		alloc_workqueue("NXPWIFI_WORK_QUEUE",
> +				WQ_HIGHPRI | WQ_MEM_RECLAIM | WQ_UNBOUND, 0);
> +	if (!adapter->workqueue) {
> +		ret = -ENOMEM;
> +		goto err_kmalloc;
> +	}
> +
> +	INIT_WORK(&adapter->main_work, nxpwifi_main_work);
> +
> +	if (adapter->rx_work_enabled) {
> +		adapter->rx_workqueue = alloc_workqueue("NXPWIFI_RX_WORK_QUEUE",
> +							WQ_HIGHPRI |
> +							WQ_MEM_RECLAIM |
> +							WQ_UNBOUND, 0);
> +		if (!adapter->rx_workqueue) {
> +			ret = -ENOMEM;
> +			goto err_kmalloc;
> +		}
> +
> +		INIT_WORK(&adapter->rx_work, nxpwifi_rx_work);
> +	}

In nxpwifi_add_card(), if the allocation of rx_workqueue fails, then the
adapter->workqueue is not freed in the error path. The function which
frees the workqueues nxpwifi_terminate_workqueue() is on err_registerdev

Should one or both goto in the workqueue allocations error path jump to
err_registerdev label instead of err_kmalloc?

> +err_registerdev:
> +	set_bit(NXPWIFI_SURPRISE_REMOVED, &adapter->work_flags);
> +	nxpwifi_terminate_workqueue(adapter);
> +	if (adapter->hw_status == NXPWIFI_HW_STATUS_READY) {
> +		pr_debug("info: %s: shutdown nxpwifi\n", __func__);
> +		nxpwifi_shutdown_drv(adapter);
> +		nxpwifi_free_cmd_buffers(adapter);
> +	}
> +err_kmalloc:
> +	if (adapter->irq_wakeup >= 0)
> +		device_init_wakeup(adapter->dev, false);
> +	nxpwifi_free_adapter(adapter);
> +
> +err_init_sw:
> +
> +	return ret;
> +}

