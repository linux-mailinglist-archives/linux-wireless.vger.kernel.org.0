Return-Path: <linux-wireless+bounces-15776-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 822C99DB2B5
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Nov 2024 07:09:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E48D2825BC
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Nov 2024 06:09:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1952D140E30;
	Thu, 28 Nov 2024 06:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JVYCFcgd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A482A5A79B;
	Thu, 28 Nov 2024 06:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732774186; cv=none; b=kisRzzAoM1BtLZyo7vFI0HXvnuSE9PguypTrH/QebnUQJlwHONjQiwxTMYIEcaacPl0ApxtkJ3aOru7s7ppNUtZG4MtWTwbUxlM+HFYzws1k0cbCElzDnBRqzU4hmasAGCe6WK3mR08A0phphMvc9jQdBLgGpG/1kHBwGSH0Ikg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732774186; c=relaxed/simple;
	bh=FNFX5D6OzAkZN2wzTw875Y3hkNNVy9wZYzC+ym6hvSM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=muLvEskLxJIH4xnYVJKLj6HZPN6zwS5DuSiqCrQEK95DomMP/uJtqLt5IWr/TZd10kgrD1S99cVYQ3J0LkFQDWvO+HAAZJTDLi5ZYxb4dJ4v6P6+eda7gl8azPVw5npKekENCtsaC+sOUwL91VmPEZ0tgtPMj1uGY67mpX3n69k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JVYCFcgd; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-7e6d04f74faso328590a12.1;
        Wed, 27 Nov 2024 22:09:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732774184; x=1733378984; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n2sl7DBRBj5Zmz6ctNu6EcUwAGJvkhaL3L7D0PuR0LU=;
        b=JVYCFcgd+FzHGFVljUFGLBJTckFmzVR4VN/b5uJ/MQUdlpEWpHPUeK02eOtaAGkYsU
         +kSj5OIJw3srFJeboQ5iuHrxJUX4nE8JRJ5Hq8GT9aL6ujnypUEJWk4UW34qTGfb8TgH
         AuL/NGnLMI/i5DAAYfU5sYAqqm59Qye9CW6dT6PQfgJAK7FaK+42k8NBQgrLbJ0z9w69
         LX6b+dEXRSUhH9g3/W36npTjAMkrsOgV/H47Uq9B75o9bz+a788hN61+fNv1hrj+mwWu
         ZmvhHCT6dmrdgQzGk/HL4+7WxGAjHfJccay+cBj8A8wtTGe1+IebpfosVO+l5BkyQFxG
         o0gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732774184; x=1733378984;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n2sl7DBRBj5Zmz6ctNu6EcUwAGJvkhaL3L7D0PuR0LU=;
        b=T6iglUW+72v20H3WO9NOkNQ2roMllBcipatl0HgFHu8SKPvcZAJlzplpa5zLAJTQft
         o1UbH2NwuQWvcUxdeQcSamb3Qps95ifHAxeQ3+tT5q7F1SrT0n+S/DEaTpiMTm9doG/M
         3QDSrai5fgdPSZIxdzIR8KOoRPv/rMbxV6R5AU7WF5BAJskY4DODnwlDhv7O+5DSMdA3
         M/3bVvkSdpNZldEr1fUQDuL1tqYfbWqB5LdoWvDZMK2/3RaL9Jqz0TiKESLj21+cJEAE
         u4qc6gLYuzYjOYTSCwqfgMaGMkpdKXdeYHUMtNgITrvku23GNjCchbdKuNvnF8qNjozU
         icCQ==
X-Forwarded-Encrypted: i=1; AJvYcCX6hPohhm1AElJ1WxSH6fIjijCyxBGdPA923GO9rof92Kww9Pd4FB9QBNmpUlugxpX+2UTmabpEbHBZW76dBJc=@vger.kernel.org, AJvYcCX8ZPYxhLCR6Km5gV+Tq1vK5xXn9ofKJEO2r0CiJk5RzxlQEUZs/PPZLXCOkV7gDnJs2exCzbijdRqm9WU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyO4gXBBhjNN2yM734quxxYK5XhVoeoyrv6Om53HzzXg4KpOP7T
	ufwduQSjT9mBEFzXG11WQG5Qnqu/iQYcqImf/3xzd4JIncforxO9
X-Gm-Gg: ASbGncsYRoPhfjB5kag0MOOuzdDlGRdYapL76azPE/SgFWn5NltlBLH/kCTsGqotvMm
	RbMjnozxWalPsKkHGP/+TZOMNTlfovk/oOK6cPCm4psVMzXiNO7Q2RHaQz43Gd5T88vw6QKWhXd
	T2kpXSWxcnepAHw8usojp8K0TfR2frtISjSdgGsGu56vPkXo6M+1n43/2Lb0kvZ2TVq9rmEfuR8
	yxEKBYTFe6zR0wT42SZrwLmjQcBGdjfpXpep4GYU7f5iEYIgGYbCjDwH6M=
X-Google-Smtp-Source: AGHT+IFZPjyCmsQWAiAm+6M27f4qo+6s3Q2xz+nj6OTaaxFwdNlTWRqmmwWrbADa4Y/wOn9Ajf8AmA==
X-Received: by 2002:a17:902:ebc4:b0:205:7007:84fa with SMTP id d9443c01a7336-2151d870174mr34999085ad.28.1732774183312;
        Wed, 27 Nov 2024 22:09:43 -0800 (PST)
Received: from LAPTOP-SQ5KB8RN.lan ([222.249.179.118])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215218f479asm5642875ad.41.2024.11.27.22.09.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 22:09:42 -0800 (PST)
From: Baichuan Qi <zghbqbc@gmail.com>
To: quic_vthiagar@quicinc.com
Cc: ath11k@lists.infradead.org,
	jjohnson@kernel.org,
	kvalo@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	markus.elfring@web.de,
	zghbqbc@gmail.com
Subject: Re: Re: [PATCH v5] NAK
Date: Thu, 28 Nov 2024 14:09:31 +0800
Message-Id: <20241128060931.94100-1-zghbqbc@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <f0077f4f-922d-56b1-a5b7-bb01e4462e87@quicinc.com>
References: <f0077f4f-922d-56b1-a5b7-bb01e4462e87@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Thanks for your reply

The reason I submit this patch is that the current 
`ath11k_ce_rx_post_pipe()` NULL pointer check does not ensure 
that `dest_ring` is NON-NULL. And it is not clear to show the 
filtering of tx ce pipes

> This does not really fix any real issue. Please check ath11k_ce_alloc_pipe()
> where initialization would fail if anyone of pipe->dest_ring and
> pipe->status_ring allocation fails for ce pipe used for Rx.

When the driver is running normally, the results of the 
following three are equal:
---
(pipe->dest_ring || pipe->status_ring) // current code
(pipe->dest_ring && pipe->status_ring)
(pipe->dest_ring)
---
However, when some errors occur and `dest_ring` is abnormal,
the OR operation cannot guarantee that the pointer is NON-NULL.

> This will always fail as the caller loops through all the supported ce pipes
> and ce pipes used for Tx will not have either dest_ring or status_ring.
> Please ensure the patch is tested properly.

I tested [PATCH v5] and indeed the wrong return value will lead 
to wrong results when the pointer is null.

Please refer to [PATCH v4].
Link: https://lore.kernel.org/ath11k/20241127114310.26085-1-zghbqbc@gmail.com/
Although it does not return an error code, it can ensure that 
when an unknown error occurs and causes the status of 
`dest_ring` and `status_ring` to be different, the subsequent 
code will not access the null pointer, which will only 
cause the driver to fall into loops.

Thanks for you read.

Thanks
Baichuan Qi

