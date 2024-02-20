Return-Path: <linux-wireless+bounces-3822-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E0EE585C3E5
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Feb 2024 19:47:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97AEB1F23C1B
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Feb 2024 18:47:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9061212F58D;
	Tue, 20 Feb 2024 18:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q0cuCoEx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1D1F130AD9
	for <linux-wireless@vger.kernel.org>; Tue, 20 Feb 2024 18:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708454698; cv=none; b=q8sWmL0f7pSKAZ6o4o9gepnKeXrQwa9MPWhy+7zQczHHGyhMzxf3ajo7HIDREBQDD4aQ0zr8ajndTtpuYLA0SBez6GOW9znvnrbtf0VV2RptpfoVk6UG0MgRFuMXeOh5CxSVjmH2ENFw6ZKfla01pgGONsuDMOp5N4z2Cv/KN4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708454698; c=relaxed/simple;
	bh=tbJhwdL5CpbPKbtQ9mCFnx/RYmGwgvHGCQvAR2HFfwk=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=CEgV472rIyoQm8VRfJVgcyScXEEnbAgRG81O3y5U8uCXN8uA17qC0rN5YdXXtMK6Mme+hs2mq6gvPJrDoNvqzOsrYHpZt6kLUhvm2sihniqHxReQmFPpoAWvPKjGfWlYevasSnGpf+SB0wu7f13/qRRqb7LnHG1jtreN/twHxzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q0cuCoEx; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-50eac018059so8661137e87.0
        for <linux-wireless@vger.kernel.org>; Tue, 20 Feb 2024 10:44:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708454695; x=1709059495; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9ecrs0mrShdhXLESbWFdhwhIzwusWUWXEPBDal4bXT8=;
        b=Q0cuCoExM/lxDWjSVMJivk4r/IMV9pHKJBd/5AT8EG9fmYWtjVbhtDP5H6mA+altq/
         xxm/Qr34k8JuQb0T1V3jyJhw0Lwl+qWmU6hITvDETbHeX617qONeCYHzfoca/n1Ok0kP
         tZfNO1Cf6xK4mB2ZtX4DJL0gAwbu0RFbm2W50LtXp4CRLB2NYzenpI/Y9iI3dw0icyuO
         duOQy9V7JD4J4mq88TJZQHdjMJtbe+Wdn3FrTkPfbVAfecEE1kZMEqRVr3BBsCS0kGvt
         UmXx4tBjf6M3ZwRvxaoxy7Ifa33ZoZdLJdaOylHFrkpTUPVT2nlmhbU+xbmfF0xMi78y
         Amxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708454695; x=1709059495;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9ecrs0mrShdhXLESbWFdhwhIzwusWUWXEPBDal4bXT8=;
        b=XKcLt1jXRv/LkimpK4WOe4o37IjaRg0B+9C8FhXrD7WQswkbr1FdkYF8kE5Dk7aX0f
         f2xP5HsW07PW90fnYiDHH8xWJ+AH5as7PzgHwA9zpOwTY01aXdQQ7nMxcKRJtxOZtBKh
         HPdKr8lyhOq7DJ+3aGqHVFCwE5tVkyg+fWT8IuPHPBkY5l0Ca8kF4im1PjRWOLxIguAO
         +xhU6rM8FXJ1nLJX7IvlrHQwH836e8Jq0MhsVqTHjGvfspcX5kll/TAG1ifcpgCEcNYo
         7i59taZ7P/I1qIcg14AQWdknI7iEi2E0RDSL4V+olSIcOeT4P6Yj7/Ne21i/XN45vCG+
         uILA==
X-Forwarded-Encrypted: i=1; AJvYcCWv/LTAL2gJgdoDpBO97eoxBstemyiOzhlBIWKYKqVA8X7e/MyvyGjQ08DZ9xRzIFZyOeW9J/ucdIiLXMCw8ws0w9vGCLzhK2GGkDt2oT0=
X-Gm-Message-State: AOJu0YwvX5J6A0eZdWvjhAwHz73B1dCosHDMyEEIpVhqkN2M65Q7qjjI
	C3fSIXw7XjDsgFJJFd0nTH5v6QWk+oce65yCA5Gy2z3AbRAETLxc
X-Google-Smtp-Source: AGHT+IGxr+lKSECoNq17bQFlHv+ABk5Gnn8zA/hMw1aZWdynPsoudvcFoxHrzufaFhR14nUT3glT7w==
X-Received: by 2002:a05:6512:131d:b0:512:b187:ae0a with SMTP id x29-20020a056512131d00b00512b187ae0amr5701728lfu.6.1708454694559;
        Tue, 20 Feb 2024 10:44:54 -0800 (PST)
Received: from [192.168.68.106] (178-191-200-70.hdsl.highway.telekom.at. [178.191.200.70])
        by smtp.gmail.com with ESMTPSA id o24-20020a056512051800b00512ac349016sm1060191lfb.306.2024.02.20.10.44.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Feb 2024 10:44:54 -0800 (PST)
Message-ID: <e99f3e22-7032-441c-83f7-973b701dfb37@gmail.com>
Date: Tue, 20 Feb 2024 19:44:50 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Till Kamppeter <till.kamppeter@gmail.com>
Subject: Google Summer of Code 2024 - Get a Mentor!
To: Alexey Khoroshilov <khoroshilov@ispras.ru>,
 "Luis R. Rodriguez" <mcgrof@gmail.com>,
 linux-wireless <linux-wireless@vger.kernel.org>, dl9pf@gmx.de,
 =?UTF-8?Q?Jan-Simon_M=C3=B6ller?= <jsmoeller@linuxfoundation.org>,
 Daniel Baluta <daniel.baluta@gmail.com>, Vadim Mutilin <mutilin@ispras.ru>,
 Lukas Bulwahn <lukas.bulwahn@gmail.com>,
 Ira McDonald <blueroofmusic@gmail.com>, Michael Sweet <msweet@msweet.org>,
 Tobias Hoffmann <smilingthax@googlemail.com>, Jay Berkenbilt <ejb@ql.org>,
 Nicholas Mc Guire <der.herr@hofr.at>, Matt Germonprez
 <germonprez@gmail.com>, Philippe Ombredanne <pombredanne@nexb.com>,
 Gary O'Neall <garysourceauditor@gmail.com>,
 "Bogdan, Dragos" <Dragos.Bogdan@analog.com>,
 Nicholas Mc Guire <der.herr@hofr.at>, Julia Lawall <julia.lawall@lip6.fr>,
 Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>,
 Rithvik Patibandla <rithvikp98@gmail.com>,
 Dheeraj Yadav <dhirajyadav135@gmail.com>,
 Deepak Patankar <patankardeepak04@gmail.com>, Ian Rogers
 <irogers@google.com>, Bhavna Kosta <bhavnakosta2020@gmail.com>,
 Akarshan Kapoor <akarshankap@gmail.com>,
 Gaurav Guleria <b20099@students.iitmandi.ac.in>,
 B20251 Kushagra Sharma <b20251@students.iitmandi.ac.in>,
 Mohit Verma <b20215@students.iitmandi.ac.in>,
 Pratyush Ranjan <pratyush.ranjan911@gmail.com>,
 Kate Stewart <kstewart@linuxfoundation.org>, benjamin@zephyrproject.org,
 David de Barros Tadokoro <davidbtadokoro@usp.br>,
 Jon Oster <jon.oster@toradex.com>, siqueirajordao@riseup.net,
 peterz@infradead.org, Zdenek Dohnal <zdohnal@redhat.com>,
 Andrei Iosif <andrei.iosif@canonical.com>,
 Danny Brennan <mdannyb11@gmail.com>, Kurt Pfeifle <kurt.pfeifle@gmail.com>
Cc: Aveek Basu <basu.aveek@gmail.com>
References: <0d74749a-52e8-4082-98b3-9efafeb1168f@gmail.com>
Content-Language: en-US
In-Reply-To: <0d74749a-52e8-4082-98b3-9efafeb1168f@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

anyone of you, who wants to be a mentor needs to accept the GSoC terms 
for 2024 before being able to get invited.

To do so, got to the dashboard

     https://summerofcode.withgoogle.com/dashboard/

and expand "2024" to see the terms. Agree to them and tell me when you 
are done with that. I will invite you as mentor then.

If you did not participate in 2022 or 2023 you will have to create a new 
account.

    Till


