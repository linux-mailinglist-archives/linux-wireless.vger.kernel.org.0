Return-Path: <linux-wireless+bounces-27805-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 01BF2BB8C72
	for <lists+linux-wireless@lfdr.de>; Sat, 04 Oct 2025 12:40:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD7E6189A117
	for <lists+linux-wireless@lfdr.de>; Sat,  4 Oct 2025 10:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 362C3254B19;
	Sat,  4 Oct 2025 10:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gyJxyF/a"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EDE826281
	for <linux-wireless@vger.kernel.org>; Sat,  4 Oct 2025 10:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759574447; cv=none; b=sOEb7r0+t3ILkUR23mU+7REHHKxGar1t5rFtadLzPDs1wTMkCGGRKrKRETInK2uQGzwsabp7YB7Wm42L0WvMa3dEdX2Jt+tCLOxbqw3m2++szwbUlpgYHunVNIGNfj6fbxmu6ajWTrNYuZ5xvI61/lbL1JSnQUgmFs/KSIyzhbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759574447; c=relaxed/simple;
	bh=CxJyVI6f/VZSxGdtkS1513lnZw1Ti10YZjyQeydEVs0=;
	h=From:Message-ID:Date:MIME-Version:To:Cc:Subject:Content-Type; b=lInur6u3WqDRM3+J1dfrEg5f9IaLfsdBV5rbsEcUZkiuEg50iQQ+NUq019ZITEQgGd+zUYBq6l1RJLIGT5XCS9uiNut0s6dYZv/KFIh41u80AqYVRx0gP0kdrhXd4RUEzka2GITW6yK14RteVw1WSTCVXULc5TdCsm2p3wibTIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gyJxyF/a; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-57a960fe78fso3373292e87.2
        for <linux-wireless@vger.kernel.org>; Sat, 04 Oct 2025 03:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759574443; x=1760179243; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:cc:to:content-language:user-agent
         :mime-version:date:message-id:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xhmW8jJYdppFzGWtIB5Vpr6Pj6ixAp4KG5I9YLNLeEA=;
        b=gyJxyF/aoKiWeEU3OPfeojhg0vSnsRuabbFen1zOr++6ki7eMvxb1o/JPiAbaTxuJv
         MzSHlzwK6bqY1nh/xn2uDmCxDmkLBSzDRc1aZtZHCw8tOMG9l1leaoxkHexv0hKfqfkh
         CaYL5xpm9LX4+w0/VW7dNX4nbs2ECgWkGvM58wcRli6FpZ9vAHx1EvZ9FyiPYoooqQzB
         dcBy2Y7gGeGlBl04eitcavE1GnsKpbcISI3N1xXFIZC7POozSlYEaMwUnagJitQpiJbD
         FqeX0hYFabvqrpwDie2MPy7gYmIwGgwp5x2Ixisv0ojfUVLYMdKEQv6FexYY3QXPJWCw
         wI6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759574443; x=1760179243;
        h=content-transfer-encoding:subject:cc:to:content-language:user-agent
         :mime-version:date:message-id:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xhmW8jJYdppFzGWtIB5Vpr6Pj6ixAp4KG5I9YLNLeEA=;
        b=uWKD3Fh9qq8bQZXT6vU6NbdQFYeL/ia/F+JY+MyhJBJWOsNSsQOBBX6UNJDJfESsyi
         dObe0jOwObIfxIMO/eCdAe8Phs1yVBrfohOwNpa7+8OpnaJAOhQxFDxjm4Blisw/zBQp
         kUP8PtY//r5BBUmdw5o+A0I/c4thmd2HUn/WU6a0gcrKl836B0r15k88WJGgW/w9oaE5
         h0LX9TS9BU4nWy7ac2GRkTdGZSUViiKPtg0KjtbRFUQmlIeRAW8zq6Poi6Z7dhxtzcWb
         dI4WDQoYN78frF3qg0tjxah/qb4gK4DqrHSflMVx6lZ+ArtG3Uym73i5evLkK9bndQoW
         le2w==
X-Gm-Message-State: AOJu0YxMGlc1aqq/fxAaJmqfze6GAbgp8bTnCSitW+tUx+EjPrFLHRir
	4jd38fQdmxSouMvci+YrOdIW1Nrj6OFxIEXt1+FCdkvHJOxmQxYLp8HUUmpzMQ==
X-Gm-Gg: ASbGncvgFUicAXztU6Tg1FUG8HCJ5alPtM9tNvBYwnRj2CI3kQ2BjoQmRRkhO0+WjPB
	LBIgdLePBE90pkFneRndnkKFnwwANY8rIliVlvh+9JqYfBi+EzBXNJ9JiklmZAIarntYMT6pO3S
	KXxOmOdA2Bdqka5kwEjXsfIVOBvsM9/GjREmynRZzMdgOfJBpn0m91nZ0MncowdO9y+apryRy8M
	WPTyMaNeyig5GyhMc+T7uICH6sUupan6nsK1HssjWd/xfhwKsFRJfQQvi++D6HTF3RRe9xJyyR/
	5eDYNoLjuY/ZHb+ve4OqmCbVvxeb+qOQHut8WLm9boM35OfcembFm+XFjUx/M//2PlkxqiJXugI
	u0dbPf+NTFtqjyjXqiA/X4FBK7tOvJPgZslWL5RIJjfKZzVpI9yTQkJ1fcDHZdyfkQXA62H8D0i
	PoYBGq/hEm
X-Google-Smtp-Source: AGHT+IG6bzm/OFjWWDzzJQnAznCc1Tnlid+nL82BR83SlJTbSGElwP5jc2lsB7objpYqr3fvB9wIig==
X-Received: by 2002:a05:6512:3f23:b0:58b:189:871b with SMTP id 2adb3069b0e04-58cb9473319mr1806236e87.5.1759574443046;
        Sat, 04 Oct 2025 03:40:43 -0700 (PDT)
Received: from troynas (host-176-37-53-238.b025.la.net.ua. [176.37.53.238])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-58b0114033dsm2709143e87.53.2025.10.04.03.40.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Oct 2025 03:40:42 -0700 (PDT)
From: Dmitry Geurkov <d.geurkov@gmail.com>
X-Google-Original-From: Dmitry Geurkov <d.geurkov@gmai.com>
Received: from [192.168.1.116] ([192.168.1.1])
	by troynas with ESMTPSA
	id XwptGKr54GgICwAAVAQQrQ
	(envelope-from <d.geurkov@gmai.com>); Sat, 04 Oct 2025 10:40:42 +0000
Message-ID: <d2e09391-d2fd-4456-ae45-103239dbac74@gmai.com>
Date: Sat, 4 Oct 2025 13:40:05 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: linux-wireless@vger.kernel.org
Cc: wireless-regdb@lists.infradead.org
Subject: wireless-regdb: Update regulatory rules for Ukraine (UA) on 6GHz
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

6GHz wireless band was recently allowed by Ukraine government for WiFi 
6e standard indoor use.

Could you please add the appropriate setting to wireless-regdb

I'm not familiar with wireless-regdb format nor an expert on wireless 
technology to create PR myself

You can find all needed information here

https://eba.com.ua/en/v-ukrayini-dozvoleno-vykorystannya-novitnoyi-radiotehnologiyi-wi-fi-6e/ 
<https://eba.com.ua/en/v-ukrayini-dozvoleno-vykorystannya-novitnoyi-radiotehnologiyi-wi-fi-6e/> 


https://mrt-cert.com/en/gjxw/4323.html 
<https://mrt-cert.com/en/gjxw/4323.html>


Best regards from Ukraine

Dmitry Geurkov


