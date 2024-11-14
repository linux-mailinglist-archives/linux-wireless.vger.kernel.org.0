Return-Path: <linux-wireless+bounces-15299-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2D249C8BF0
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Nov 2024 14:38:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 885CA287979
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Nov 2024 13:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94BF01799B;
	Thu, 14 Nov 2024 13:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="feYxDNLE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE39817588
	for <linux-wireless@vger.kernel.org>; Thu, 14 Nov 2024 13:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731591440; cv=none; b=W0Lc6tTzod4pf0hk7gbIOWmUZSIDj6e7RkSX0UqDfpi/HA4RrNFhwllmHFokNefsVly1m9wF15yy+li4/zQMtN9b6ThQ9cXCiXMdoHKIw4q6sN81HcJfVJbE9uKe3ANVkl9KAo+6jbFXc9aIutYo2SAZcaYJEaHHvFQgrEW+6K4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731591440; c=relaxed/simple;
	bh=5X1ZpsKSU0QhwpzYrAtSyjoABESMuqE9pOmv2FiSD5Y=;
	h=Date:From:Subject:To:Message-Id:MIME-Version:Content-Type; b=ri4Zi2iIGg01GLXb8g1gvX5y21OgNvpb0cEk8VXBwRCgxB8cgGD8j0WM3M3Cpp4/kANMALdGkJqatjUd8+QFoSgjQbMkVIOvhZEFrKDsIgsVKqSkuIu8YzeUPLoI1ydECsg2xBrl++ftvXg5zXMeuXDY2y0rbADYdyXiajZ4l3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=feYxDNLE; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a99f646ff1bso87239266b.2
        for <linux-wireless@vger.kernel.org>; Thu, 14 Nov 2024 05:37:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731591436; x=1732196236; darn=vger.kernel.org;
        h=mime-version:message-id:to:subject:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7Yeo1SGKcqEsihVzpyVTcSd70J4bKLLuUTI6sCSVKWg=;
        b=feYxDNLE0Gc/klfiVldirCuLzWBG+eurTyzMw8l+NygDGs7+rRbf8VIEx/2KS5Jrvx
         fmwr3thkDr5fTYgjzozDrkDHZmczWtnTrnYhQQ/K898mm6gBlmDyr2upxJxPG9kmBW5g
         3Oz0DWiKRVMsR58F2/qMqzYLSTPGJ0FvGkHEikDaivqwP2W5l7rOlwrj0NZa4r9nPhco
         Ji31ykWOswdP0+56QevXVo+V6JE3ykTstgLDLfZJ8xZlWwUMw4NhonzQjGT/vSqWBpsw
         mZmhgI4Y1qfG7tj4Pj6OI2U3XIcjiTE+Z4ZR4J+g/R9CwWuluEQnOMXl2zRve9AqylAC
         /g0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731591436; x=1732196236;
        h=mime-version:message-id:to:subject:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7Yeo1SGKcqEsihVzpyVTcSd70J4bKLLuUTI6sCSVKWg=;
        b=PxM/zkrl6cGnRon2xxc9DORt8hxWGh3XWbvk9Gnw07z3qVDF3GXM8hBstLH3FogR4m
         QMtkD35s3lqeOfPnkc9FnIsSXImZiZcvtcGXf5OAcdubMEEguZ4al4sSql+AvrkQtm3n
         Mt9bJAw5gwmHfSTjtYRfYoG0SGhPxsnWoK8UWWaEhLF2qYBLD/TnAlaaYQKFQO36r9P7
         EZBh0QjnpqQkoytNce1wfA6fGQQYbLRH1Rx5yS5NHEOeMkSPp7jbgaCFYHt3803MvsA7
         v10dAZjLCUbh+yuOQ6XA8fhvVVrWLVWaHhmVMQB+QFS6oqaXA4B7m5UWj/9Xr13/5lMC
         Kp0w==
X-Gm-Message-State: AOJu0Yy3grfxvMVk/Mr9F510L/A+zTT8c9oAYuLVyisnElPI3ON2pNMp
	R5ZjBktjJVBmOAOFhVClpdvuXcbtw1hVm7TQqSbfOHQTmnu9RRrlhXyXZreD
X-Google-Smtp-Source: AGHT+IHL7/Mb+EKh/Tqm0g35cbX3XDO1rG+jAhtcXjoPlf2Z6M5Cw7XLuxO4nRtQVnZ4N6VmVhYgIg==
X-Received: by 2002:a17:907:1c90:b0:a99:36ab:d843 with SMTP id a640c23a62f3a-aa1c57ae894mr971034866b.38.1731591436324;
        Thu, 14 Nov 2024 05:37:16 -0800 (PST)
Received: from [10.96.0.24] ([185.107.56.142])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa20df50a97sm66320466b.61.2024.11.14.05.37.15
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 05:37:16 -0800 (PST)
Date: Thu, 14 Nov 2024 16:37:06 +0300
From: Shadi <shadisalman11@gmail.com>
Subject: Update regulatory rules for Syria (SY).
To: linux-wireless@vger.kernel.org
Message-Id: <UH0YMS.VC3MBEUCWKPP2@gmail.com>
X-Mailer: geary/46.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed

Hello,

I'm a Linux user in Syria. We don't have any rules dictating which 
frequencies we use indoors. However, the regulatory rules in db.txt 
specify only 2.4GHz networks to be used. This default behavior is 
currently not allowing us to connect to most of the wireless networks 
in Syria. Which are mostly 5GHz networks.

Can you please update the regulatory rules so that the default behavior 
does not ban those networks ?

Thanks for your understanding.



