Return-Path: <linux-wireless+bounces-14134-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 401B49A1B22
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Oct 2024 08:57:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0432528984F
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Oct 2024 06:57:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 404B61991C3;
	Thu, 17 Oct 2024 06:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S4WYBpTA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8389199955;
	Thu, 17 Oct 2024 06:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729148233; cv=none; b=HN2bJzumIHHn7sBhYS86Cf6+7mUHkwfSGPkyH8xGlIWd8tMDY4/FUSoywY5f+iKNxRLlzM7Vl5qICsI7SQlp8vahLBGhv3PEhkNMk75q00d7o3La5YPo/9z6MBuBUF3b29iLfajSdIKy02j0PWkYpC/mBC0iAfLgmPDSeCCGqNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729148233; c=relaxed/simple;
	bh=shtix6Vyx5HBndb6WI7X44kldclZ5gMnq8azhK9OOKE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZkozH6Jq/kWGpAYPL9hsjzv2kSj2XYwzsqWR0f4XmPOvjdnhMjW39hgZtNlzQIInrw5VgVPqXX/3p8kXZV3Ji84tj862R1AohHP2idYboOfzVJZLhAyqq3kJg5OmXK6NWvz44Qzyz4pT5RjfkFAGJItf8uue4aNltFdNCAy8Ml4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S4WYBpTA; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3e5f835c024so326931b6e.2;
        Wed, 16 Oct 2024 23:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729148230; x=1729753030; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hvRvosvvlInmc5nTg/6cdvc7/Szsbe6+XJ5j1b95qIg=;
        b=S4WYBpTA9V7KBO3IKU7QHn7hZRf9l+NzTN9OMVkg6hqxMCxo1IgILr+GZSf/13TqBq
         OSEc2dHoMx91znC6UNntfO6sk6D/SKUcYgDppXcd/oIzKUkAUAhbmvjmgb/G+nOJ0RNk
         nYwpYlhULo4WMGmAlDZZ82w+MqlZjc97+OtorDddgSEnWbAB6b98vJuLL3F2Y+el920o
         gKswrHthTo3Gu0TRLZsd6IXH2e5e0zYlbcbyzURilU5Z9tOUIvyBxibjG8ratB6wsLZV
         FZQ8QwzEruSUcR6bLPMHv87N9Lio6fyk5FATVw1c3pNsvhxfoEiko2mLJ3qKmu8hGZb9
         ChqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729148230; x=1729753030;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hvRvosvvlInmc5nTg/6cdvc7/Szsbe6+XJ5j1b95qIg=;
        b=J2iB1/WULjLZiESaM4AeTFtG877xiirR7DMIzKwLHkwSlLVLPV1DtmKaNuyuxfIo6W
         YVDrq5aBm1GcJgeXVd6l2KmVAy1wvmLRKJNYnEv8/SjmUSGynIHpTYaPz8ag2cbLn0SW
         HeocU+xSx8W/5hp6WTehfvGEvVy/lD6U2h9ua6bYcJyt/nyZyETaa4IAYhVC+rjZM487
         kw+eOEr09tB99SZ7RjGUfS++r3AsEXJBEr4Wd1QR8Ud1zibR+Tkgarr8Sm7kc+meJp6x
         Sg89w35yOz8WoG+lSjz2iDKcH+R0vFwNPq/4izMPXk0yqxWg09DdMM2BUqsVUdnprxzb
         +6XA==
X-Forwarded-Encrypted: i=1; AJvYcCUDtAqGSRWqKi2NJEAgJeaLwKgLu48TKukvbn1atUSlnpP244o4fusXj8GXMQoPEgvqlEXKPI8D2Mc9fm1jnJw=@vger.kernel.org, AJvYcCUI4sk4GZySGt7amgJXHQ7hncxMwlcjwN5PhWUV7hSo9uvRBHMwTl36ek8GfF2PI5nUpXmKb+uOkziifk8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxhg5bKcNrJbNP7nZodWsUYMuSYbZnrzoQQcIHOIz9tEZFgSUEo
	//1cqJ9onN/Ngkqmi6LO+IDlnWo0eUVFTBdfmn70d+Emac2UWN4c
X-Google-Smtp-Source: AGHT+IFS/PFID+fQBk/3FX/YxH/oX621qepd442RlZ2cJYJ06pljfbm4uZRR6iorUD1sNZlBK8dWAA==
X-Received: by 2002:a05:6808:2021:b0:3e0:36a7:710f with SMTP id 5614622812f47-3e5f024a7fbmr5664005b6e.20.1729148230603;
        Wed, 16 Oct 2024 23:57:10 -0700 (PDT)
Received: from archlinux.. ([2405:201:e00c:517f:5e87:9cff:fe63:6000])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-7ea9c6ba33csm4292808a12.17.2024.10.16.23.57.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 23:57:10 -0700 (PDT)
From: Mohammed Anees <pvmohammedanees2003@gmail.com>
To: pkshih@realtek.com
Cc: kvalo@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	pvmohammedanees2003@gmail.com
Subject: Re: [PATCH] wifi: rtw88: Refactor looping in rtw_phy_store_tx_power_by_rate
Date: Thu, 17 Oct 2024 12:26:45 +0530
Message-ID: <20241017065645.5409-1-pvmohammedanees2003@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <c0f6c6c3b87c4d048ad9f42dc1dfaed9@realtek.com>
References: <c0f6c6c3b87c4d048ad9f42dc1dfaed9@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Oops, I sent over the wrong patch with typo,
I'll make sure to fix that in the next version.

> I feel compilers can optimize the check for the band, and we can just remove
> the else condition. Or
>   if (2ghz)
>      foo_2g();
>   else
>      foo_5g();

I do agree with that but I feel, it would be
better to make it independent of compiler
optimization, thoughts?

Let me know what you think is better, that is 
whether letting it be if - else, or using a
pointer.

thanks

