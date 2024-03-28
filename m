Return-Path: <linux-wireless+bounces-5468-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3AE18902FB
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Mar 2024 16:23:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4D011C29A0E
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Mar 2024 15:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32F5142061;
	Thu, 28 Mar 2024 15:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D/BlgZbT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3D1812F5AF
	for <linux-wireless@vger.kernel.org>; Thu, 28 Mar 2024 15:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711639413; cv=none; b=baGfT8Fpx5CN+Z/YjqXCVUJzxX1rvaNNcThaRUw+46z681PUu/7RAXztMUjdipbZ1TeNsB5ND8xdOWA9h/sLoYhlMgxXWoKYkx402MU74lBrxlzbtiIWlNcNyadgVNx06+GR56w19+VZfJdJJb5VJIgGTweI57VbKPCtMp1Gx6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711639413; c=relaxed/simple;
	bh=VQFXtnC5NuXBZE1529dN4XXJ4jzTy6Zk5JLfYNv6zX8=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=WPR+55le4pw58SZrUMD3lDAkViP1AErcvQ2+OthFNpcHdWJE7DoMDjUX33A0oP1xI2BgM9Ev+vbHRUzC870Burr6xdVzzpkRzg7Xx6p2r4Xp5k0PakWbmVY5vnMvW5jCDQGYsXPDsJV5MW09im8p+HkHAx7RE9CmZwZjDO8Q6zQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D/BlgZbT; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-5e152c757a5so698293a12.2
        for <linux-wireless@vger.kernel.org>; Thu, 28 Mar 2024 08:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711639411; x=1712244211; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vhC2Az8FCwQVaMqEG4Rh9Jbbc/IUpRYOfEemirbmdfM=;
        b=D/BlgZbTgJvioAOTRSYLt2dL7x9Flh0UzqMapZVXhTfAmEXn97dkL29TsFJuU1YAGt
         eFwYN3cQ/ld912Nps3mDR13gp34jhNbFCAxjmoSyzQpneURP9Qr3uK4wFLmB165X6BL5
         9AyBxOs+D5M9ExSqkaxmu6JfqlWuW4ITFAUCNlj80UEvKrV+kCRfWjnLWBdDuWrej2Gk
         wjkk+3yg6G4wmOUND2s2toN2TPaIzx/KTbP78ohRnS8MbChlEXjMJLhiNW6VI+XIwufs
         MHpLkbxk73wnDGuxY+tZiG791Vr0ehRxqLr+dQIbHQsoV/R+Auq+r+3hKsRUeYxCCEV8
         5jAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711639411; x=1712244211;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vhC2Az8FCwQVaMqEG4Rh9Jbbc/IUpRYOfEemirbmdfM=;
        b=PWS8LTxD5m+ilM1qhGSyecs8z4Uxawyh8db0d1Bj/S7xYn1VADUakeRFFNSPvW5O9A
         xK0qn1uY0esMCYDSdZOPvwzwHiUEwJT6JkL0UgJg15hlSJgYe5XWLDfNj5Wujpx8+UKP
         PX5BlmPLYTmAE8FuMD+XVVWlsTqOgymknN+1RlSg+7zqjvR5SyF+9ThcCqFO6k9oozgT
         n2PBLL1oSdRGbv0A4idv9RRNfUIoEZmztJVG/fdtA5DtngKIRSpIUmvKmXdKyzIj8D9G
         7bYqvXTqoHgvMJRYMdUTiIqTkdYoG9nqSgXvMHIFTIJ6nu82Yt6gY1GBsLVZpgWKyP5j
         661Q==
X-Gm-Message-State: AOJu0YwyR5Yyzr2hfTX400jGBRg/NLhgAUROiDA2rYXBj4/psbwrraBS
	/VeXNrXUm40cb+BQDP4zwgzC/qM+YdS1kzGhSMZ0ZQ1XCLuBdl/btnQdEafI
X-Google-Smtp-Source: AGHT+IGWo1bGo8ZfcbffUDMYcfboqa5hc7yPs9Cvsh2XZA4bERfcH8L2yrCyfMfO0bLjG5V7q7gNkA==
X-Received: by 2002:a17:902:d54c:b0:1dd:7059:a714 with SMTP id z12-20020a170902d54c00b001dd7059a714mr3510132plf.30.1711639410676;
        Thu, 28 Mar 2024 08:23:30 -0700 (PDT)
Received: from [192.168.254.87] ([50.39.172.77])
        by smtp.gmail.com with ESMTPSA id l5-20020a170902f68500b001e06cc3be27sm1711163plg.253.2024.03.28.08.23.29
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Mar 2024 08:23:29 -0700 (PDT)
Message-ID: <055b857a-83f0-4abb-b6ff-f0eaaf572e64@gmail.com>
Date: Thu, 28 Mar 2024 08:23:29 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "open list:MEDIATEK MT76 WIRELESS LAN DRIVER"
 <linux-wireless@vger.kernel.org>
From: James Prestwood <prestwoj@gmail.com>
Subject: No way to cancel SAE after CMD_AUTHENTICATE?
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

I noticed some odd behavior where userspace is unable to cancel an SAE 
connection until associated. If you issue a CMD_AUTHENTICATE then 
immediately (or prior to association) send a CMD_DISCONNECT the kernel 
will not cancel the authentication and afaict ignore the CMD_DISCONNECT. 
The kernel will continue to send authenticate events, and even retry 
authentication until the retry limit after CMD_DISCONNECT is issued.

I see the checks in cfg80211_disconnect which seem to back up this 
behavior where its essentially ignored if not "connected". I'm not sure 
where to actually fix this since the auth retries are internal to 
mac80211. Since the device isn't even authenticated I'm unsure what 
value/structure to even check in order to detect this situation and 
clean up. But there needs to be some way to cancel the authentication, 
right?

Thanks,

James


