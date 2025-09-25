Return-Path: <linux-wireless+bounces-27646-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AA930B9D82A
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Sep 2025 08:01:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D71077AE51B
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Sep 2025 05:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5499121D5B3;
	Thu, 25 Sep 2025 06:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="iKuO+mrz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f227.google.com (mail-pl1-f227.google.com [209.85.214.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECC36757EA
	for <linux-wireless@vger.kernel.org>; Thu, 25 Sep 2025 06:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758780080; cv=none; b=mcGaQEVgt5q6Qp9dkLEZg1zxQK4N32bLSghUpo2IFjpkDdEq3U4zh3AC4ZIS54m0ieeFuizxwnwynIqPUTWGm4CpUcbvdZ46Hsf2bOoVQV5prj/Af9gDwAAnL/M7aN6YItJ+PsWYLoa/K5HHoTzMBieXgJh2pZ9YxgPLpshc6qU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758780080; c=relaxed/simple;
	bh=M4DQ6cako/KbCIkULxVrerW7+KLzokn2G8YKqyf9edQ=;
	h=From:To:Date:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=J1mLeDRiYCCZppPEddM+jTD2xYCs6l0GitsL+fJZAVVmv+jTFxbC/xgUxbPEcPtLu1GoGmDTkyosfd9UTpO3Vb0YhOB8dBj9J+l2BGf9hgRQwvMg2UXarvJWf+Scx8kPCF8tnr7aU8WXhGy8W+wR1Wpj1icVUUiHyFZgA5Wjq+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=iKuO+mrz; arc=none smtp.client-ip=209.85.214.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f227.google.com with SMTP id d9443c01a7336-24456ce0b96so6888165ad.0
        for <linux-wireless@vger.kernel.org>; Wed, 24 Sep 2025 23:01:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758780077; x=1759384877;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:to:from:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AlQaW4NJff/8NiELFp0G0mv3OSxJSeuPJWiPsjZSsxU=;
        b=muwLk269J8RqWhwK3tA/jjU2+zMaZek7udQQGYX6If/vOJnns1ViNabcZ6L86vHSp7
         1dLl5/uaOxeJ8uBxnefJYKP920MDmggkBg1tQPePaGYzjTyHUhy/s4Q9XYTiML7QGa6K
         1pYAIaXV4+wd/1METt+1Aii9oC0r9P0JmB0rYSMk/MPKmTnuUaHZsml415R8DWWQP59w
         EI2aCROaSzt63YjPHAXIKHr/TTl+cZKZIPl5B0x0J9O6CHVme8H0jgrv7yc3g1H6YLKO
         pJzuPlLjbaYg6WcWk+bRnYlS5/ZYekw/2cCyZruZMOJAyCwq+vG7hVFxYZdLazHVW9mr
         Zhfg==
X-Gm-Message-State: AOJu0YzkUrIezcEbUhJ7WzCK+KJf6155xdzvziKG5IYTUBVIGVLrfU4x
	NZseem66MNzK61y55BXzDJwOYdDJXtF+q5YZ2Zs1Nqi+xa1xfe54T6EAfr3TEbakal4abt3KyMJ
	NCysDSsw5rJ1lWwj11+HNtDi3D4jwk0EkFHf80jeZ/NSz59uaPzY0872oCLnJcIUUsUzvbqj4KB
	W2+RQK87pvU1WSJLPJ0UnF+v/aYVRnIWL8TF29t1vpwykpBbgXIirMzsTi61Bu8tTTI8ro4soNF
	vXQh9Dhgr1HSJvyOrB0vmIRho9v
X-Gm-Gg: ASbGnct/rwwNQolW0uO8nb1ytGAgRwT9hcs8nFzAHASsYXutheLcV4CxmLeMeuyOYsa
	6v/EMQR887R3JG5VoCJMuTlgvWOJL2MACvqy1S1sLLA3KmtwLuJI+0MkJD5bSFk1XVmyoLRte6n
	Re9p0fhbZy644yImhTTfjFtULfNG7PKKM5SNH5KuSUjwyF3SWe+le+ECpvfp4I7U7Ynd6JvQ8X0
	oatW2ajUh11QhUG3BrKuh0Oyw8zU8BnH/uy2Bi4KXfWWg0wqSNTcWiGqwqbf6LfvIoFPrbb7+Vu
	ypwR0jPdg1dqwC4Okpds9u0XbKe9YC3eP4gBdvHrM/O6Br7cQxua6q5S+iCRNr1PLA7MIIaRZZt
	tC5/g+QbbUe9hSUjC2GpL1GbBual7kxH2TWR7Fu03zs5Pe01uIYQI0KAibhbIIaZlU7CfyPJLNW
	u/Opb6EQ==
X-Google-Smtp-Source: AGHT+IHIx8Hzf0CCcDOHyAImkPRQ81M++nRvfAPqbl7pqibiJOuuVPiWsKcTJrr8Bu6wDJPGzUW0CKszwj+r
X-Received: by 2002:a17:903:2383:b0:242:5f6c:6b4e with SMTP id d9443c01a7336-27ed6be479emr17752605ad.7.1758780077001;
        Wed, 24 Sep 2025 23:01:17 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-121.dlp.protect.broadcom.com. [144.49.247.121])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-27ed66de8e4sm843635ad.22.2025.09.24.23.01.16
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Sep 2025 23:01:16 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-b335fbe7c0dso78268366b.1
        for <linux-wireless@vger.kernel.org>; Wed, 24 Sep 2025 23:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1758780075; x=1759384875; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=AlQaW4NJff/8NiELFp0G0mv3OSxJSeuPJWiPsjZSsxU=;
        b=iKuO+mrzhX7W7IragXCayjE95v6DHUTfAmY4UgKqwzZkNCx7GAd1JssIkfVu/PzXsp
         zsUiSCDrFm7frYx9JNODOOXIabKTfXTJI+xdqYL2jO+awXeZxmYyXTBQUBD8vS9kDTz4
         /2STKYxVwwGrBIfzAhYRI+qHIAs5K1kt+4BHg=
X-Received: by 2002:a17:907:9618:b0:b04:97df:d741 with SMTP id a640c23a62f3a-b34bb8f1220mr224055766b.44.1758780074602;
        Wed, 24 Sep 2025 23:01:14 -0700 (PDT)
X-Received: by 2002:a17:907:9618:b0:b04:97df:d741 with SMTP id a640c23a62f3a-b34bb8f1220mr224051566b.44.1758780073964;
        Wed, 24 Sep 2025 23:01:13 -0700 (PDT)
Received: from [192.168.178.31] (f215227.upc-f.chello.nl. [80.56.215.227])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b35446f79besm93207966b.69.2025.09.24.23.01.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Sep 2025 23:01:13 -0700 (PDT)
From: Arend van Spriel <arend.vanspriel@broadcom.com>
To: <linux-wireless@vger.kernel.org>, <brcm80211@lists.linux.dev>
Date: Thu, 25 Sep 2025 08:01:13 +0200
Message-ID: <1997f762428.2873.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
In-Reply-To: <1997f6d2b48.2873.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
References: <MW2PR02MB3674333A04868446C75C39EDB51CA@MW2PR02MB3674.namprd02.prod.outlook.com>
 <1997f6d2b48.2873.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
User-Agent: AquaMail/1.55.2 (build: 105502562)
Subject: Fwd: Re: hostapd Kernel Crashes with IOS
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="us-ascii"
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

plain text version

--- Doorgestuurd bericht ---
Van: Arend van Spriel arend.vanspriel@broadcom.com
Datum: 25 september 2025 07:51:25
Onderwerp: Re: hostapd Kernel Crashes with IOS
Aan: Chris Spargo chris@streetlogic.pro, linux-wireless@vger.kernel.org, 
brcm80211@lists.linux.dev, brcm80211-dev-list.pdl@broadcom.com
CC: Jonah Finkelstein jonah@streetlogic.pro, Parker Borneman 
parker@streetlogic.pro

> Hi Chris,
>
> No problem. The null-deref seems straightforward enough so determining the 
> issue should not be difficult.
>
> One thing that I noticed in the log is:
>
> hostapd[1149]: RX_ACTION category 10 action 6 sa 62:a7:67:fb:82:3e da 
> dc:a6:32:7b:12:1c len 28 freq 2462
> Sep 02 17:23:08 raspi hostapd[1149]: Ignore BSS Transition Management Query 
> from 62:a7:67:fb:82:3e since BSS Transition Management is disabled
> Sep 02 17:23:09 raspi dnsmasq-dhcp[1143]: DHCPREQUEST(wlan0) 
> 192.168.237.234 62:a7:67:fb:82:3e
> Sep 02 17:23:09 raspi dnsmasq-dhcp[1143]: DHCPACK(wlan0) 192.168.237.234 
> *62:a7:67:fb:82:3e Pixel-7*
> Sep 02 17:23:18 raspi hostapd[1149]: nl80211: Event message available
> Sep 02 17:23:18 raspi hostapd[1149]: nl80211: Drv Event 20 
> (NL80211_CMD_DEL_STATION) received for wlan0
>
> So the claim that the issue is observed with iOS device and not with Pixel7 
> seems incorrect.
>
> Regards,
> Arend




