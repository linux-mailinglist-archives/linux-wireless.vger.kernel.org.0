Return-Path: <linux-wireless+bounces-30834-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BE20D2188D
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Jan 2026 23:18:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B242B3025123
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Jan 2026 22:16:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E7C03B5306;
	Wed, 14 Jan 2026 22:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Exe9xROA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ABD13B5310
	for <linux-wireless@vger.kernel.org>; Wed, 14 Jan 2026 22:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768428991; cv=none; b=uvWzHvmGLjlkEqtaohqr/6tZIVQNBpuTNMBsZkGI5CsykJKpE2viw2O8I8Dmn8YFqzTG7oIbXWM+52uiZvhblBsgkWCf6oc6N/tfPAXj76j9eA4B28C38DX130q0HUJ13mq2z6S5Dhp0D2vFmoNO7/TGuYRsjgYmSYiPC6txlGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768428991; c=relaxed/simple;
	bh=fzvauD40kAimdCckerfZgBpT7JM9LGbZKBC+or+J9L0=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=f6CP3MyyJ/elDLxXBs4fP8mQJe9OYWUeMpXyQ8pMFMyrBvv8XTRLwQjqoPKzfn9HX5HOFj1i8Rv7AaYNCxSPZKZYp+85C0gbmqXMSrB0ZJAsYt3N4uZWhIzNd6MA36ozymUFC4T29W9QZhwKH9n+50BzKOmz7YYB2aOKqkZvwvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Exe9xROA; arc=none smtp.client-ip=209.85.128.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-47ee4338e01so1139685e9.2
        for <linux-wireless@vger.kernel.org>; Wed, 14 Jan 2026 14:16:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768428975; x=1769033775; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:content-language:to:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RUgM3ZyyugB0rf54n39dsTIrI0pwlQCUDXRgUuG9VUM=;
        b=Exe9xROAwkkaZjD5IcEi8noMnStcZY1nFg8gZccna5Z66NeUnUt4eiamrv7u4QqGqj
         wb0nSQiJpKzy97Et099MgyBgtOxKy35UVuyA4fChbiwZaJITApMi8O5/3T3H3E14Xj4H
         LlFq9jn9ygT0CgBY3zxFIQOH2H6oC5gcR1q38Hw1DTGe1554X7UJG+X0Z0HfDaqpm3cx
         efrtac2Wyx++H89jLk1wt/mo+2FP/f6qv6vSIr1Pv9S3FlMCss8UwKqkGRObRwlQhQr0
         P78Z6XRMGSaBBAngouDrPyjJWy4WL09+LiIUSnC4RbvD67w/WMwrYvYl8VkUN4PEPPvy
         8hYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768428975; x=1769033775;
        h=content-transfer-encoding:cc:content-language:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RUgM3ZyyugB0rf54n39dsTIrI0pwlQCUDXRgUuG9VUM=;
        b=eUW4CPvNEL3OoFwjOyITTUFCYhOorAFE7iM2HOwB1TZvsEJPXi61+0RZiL6DyvdHeN
         6awqxpLFMqK/Jk/ZCfQ7eL3CoYi2SKVFfV81NjrygXP9fJZQBoZ5kzxIZqWt7enwb9aZ
         uH7jtc70h3fdMGc0C1eBzrxz2x7J4n8W3horD6WlPQg1/XFN9oDAUzGL4t7oAyCPwZ/p
         o8ds88G8+FWFUOV0F434LvpJPIDGcX9kk3P9kEiAS4PGxViQXhes0VYGWYoFpAggReUK
         a8YwkxOQdREwm3FZnzvGa/08P9nNY4Uff4lieyPk2R1pS+yF+Km5b+6JJ+2BMdNtW//S
         BiMg==
X-Gm-Message-State: AOJu0YwVcLZMfdSkzLTIy+yAe2j+WgTK8nz8o1J3JimyBgYz7eJnP9iE
	ujp3eF1fZ8zsXYxzlUs3rZzztdF4S9pjvHO9TDDc7E9XrRsPL/Dljv91jOxhLCPc
X-Gm-Gg: AY/fxX4wuHmeRLgEO3SCkIRvZrOqv3FggNdbWxRheJJnFxJjyGk/zsiLLPOhJ6DUH7W
	CAlCvZ99FRSCPiD7hh/UjvqT5LTGjbFDfp+WGhD0Hb4XH8oNApdjf8+/1Q2ae1JI1gXUT6JTNB/
	7ERQkOJM1IIp0J68Ova70ils2Zz41P5aC1aK/HXDPZIEJN76rpysVXlnFzmnJ3LFBBfIVmA9cyP
	lAREqVUDLTUlxwvBr645WzI0sVL4Oh4wvZJt5+Ve7shA/8moEplOevk3tOchpx6X9Q6aZyV1DzN
	EA5UtWvfSEdVIOuvk2aeqFtA29o4hvdB3clp7lEWY6F8dh7mggQnKjeHeQbWTiQ1wNkwhWSjGxt
	3/N1r0FyMrdgMQy9jyptVwd62vvCQeplHRdli8O86NfrjcBG4PeQ9UVvhs/9WjDsBqPYYbfKhmb
	kYeBwAMeKrvTaVJhr07IRcD5S6JA4SXKypwJ3jD8/CGGZ9jAdMKBRsDE7/MecnyEhqhY8=
X-Received: by 2002:a05:600c:524c:b0:477:429b:3b93 with SMTP id 5b1f17b1804b1-47ee3350464mr50429645e9.18.1768428974996;
        Wed, 14 Jan 2026 14:16:14 -0800 (PST)
Received: from [192.168.68.113] (193-80-180-232.hdsl.highway.telekom.at. [193.80.180.232])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-434af64a778sm1679153f8f.3.2026.01.14.14.16.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Jan 2026 14:16:14 -0800 (PST)
Message-ID: <2ce9b56f-edb0-4c3f-8fdf-251a20f103bf@gmail.com>
Date: Wed, 14 Jan 2026 23:16:13 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Till Kamppeter <till.kamppeter@gmail.com>
Subject: Google Summer of Code 2026 - Project ideas page for the Linux
 Foundation online
To: linux-wireless <linux-wireless@vger.kernel.org>
Content-Language: en-US
Cc: Aveek Basu <basu.aveek@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

the Linux Foundation will apply again as mentoring organization in this year's 
Google Summer of Code.

Perhaps also this year security-related projects and projects about AI/ML are 
especially welcomed by the organizers at Google, like in 2025.

Everything is going as last year, especially allowance of open source newcomers 
and not only students and flexibility with the end of the coding period and the 
3 project sizes, large (350h), medium (175h), and small (90h).

On January 19, 2026 (in 5 days) the application period for mentoring 
organizations for the Google Summer of Code 2025 will start and the deadline 
will be Feb 3.

To be successful, we need a rich project idea list so that we will get selected 
by Google.

I have set up a page for project ideas for the Linux Foundation's participation 
in the Google Summer of Code 2026:

https://wiki.linuxfoundation.org/gsoc/google-summer-code-2026

Please add your ideas to the sub-page of your work group. Also remove project 
ideas which are already done in one of the previous years or not needed any more 
and make sure that all contact info is up-to-date and all links are working.

At each idea please tell for which project size (Large (350h), Medium (175h), 
Small (90h)) it is intended, the level of difficulty (Easy, Intermediate, Hard), 
and mark clearly your security-related and AI/ML-related project ideas (with 
something like "**SECURITY**", "**AI**", "**ML**").

Having security and AI/ML project ideas and also not only large-sized projects 
raises our chances to get accepted.

Make sure to not talk about "students", but about "contributors" instead. I 
have, at least partially, taken care of this when I have copied your sub-group 
pages from last year.

Also make sure to remove the "**TO BE UPDATED**" phrase after having updated 
your project ideas.

If you have problems mail me with your project ideas and other editing wishes.

The ideas list is in the Linux Foundation Wiki. If you want to edit and did not 
have the edit rights already from previous years, please tell me and I give you 
edit rights. I need your name and e-mail address for that. If you have an 
account at the Linux Foundation, use preferably that e-mail address, but having 
an account at the Linux Foundation is not required.

Please also take into account that the deadline for our application as mentoring 
organization is Feb 3 and after that Google will evaluate the applications. So 
have your ideas (at least most of them, ideas can be posted at any time up to 
the contributor application deadline) in by then to raise our chances to get 
accepted.

Please also tell us if you do not want to participate any more with your 
workgroup, so that we can remove your sub-page.

    Till

