Return-Path: <linux-wireless+bounces-3258-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D93184C002
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Feb 2024 23:28:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50AE61C21BA8
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Feb 2024 22:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BE1E1BF27;
	Tue,  6 Feb 2024 22:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D0ckedB8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAEE41BF24
	for <linux-wireless@vger.kernel.org>; Tue,  6 Feb 2024 22:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707258482; cv=none; b=lSyHqpg+5CDSLg72BtNnZbA0OGoMa/PJt7HkevX+FYCwmMRSYVRkZPUu9iBGP7ShFYMsbnBhRNKH9Oq0AEXvapE5S1yW1t2mkWkAxwlOi/yzI3U2ra2ZNYCYcK+yQ1e7lWUxy8VQ3dfyRePvHjQvXSCWKJTpr3fleB5Yal5A38Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707258482; c=relaxed/simple;
	bh=qnNBGRUV4tmDPFPvyfY/K6BZXEfjoT3+uYIWJb8q0Fo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EGXPC1PxNX/YHMVavqcbrLOPORNEPj771fohYKVMuMiQWOKw/eDxdDPNtdwwubmhAok3rdFboKys7ez2kqXI/kZNa5v8Sv+pn8n1r4iGEy69+TIu5haOahfCKnXs0nXLwgMWvB6OvWehUDNdWgeEm8ACAvhKEO188CSIAgR+iD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D0ckedB8; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-40fff96d5d7so2664545e9.2
        for <linux-wireless@vger.kernel.org>; Tue, 06 Feb 2024 14:28:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707258479; x=1707863279; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xxf9BZ05eugzo3w+caVoORK19gvB+NfmrX9pjihd4/w=;
        b=D0ckedB8DlDW89POM8POJ5Ej+gbRGAWynNq1FiVhLQBh6RRmH0amPMLveI7sBNTP2m
         dqIPlYiy/hhpMEiOV0eRbKlZSPlMNJl2RBLRP2jZZR3nHn+kTwsSGPJIT/2/E2waNWmd
         bVyllHVHOuBMJIHhYtXqR2ovkyTKHcaWJ0I7ZrLTf6hwMZ2wsMTXwAq8ink3xT90P9NV
         RNzHJyFljOITKi7UnluX4lW5ryiAZaCEQ6f6PaKNN8gLh0h7wGiaFfyg3G8FU82ygvdn
         lS1WhQUh/T2HMl1xwscOcuC4vfWkeyiwVmNcQqhMpLHksd7UBRShOUnohh34/zP5rniK
         TQiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707258479; x=1707863279;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xxf9BZ05eugzo3w+caVoORK19gvB+NfmrX9pjihd4/w=;
        b=rsrFK73czCa51/1rMmZYV/Stbhog9iM/OaHkRQ6NDIR/hRNw4wMWRf+ZUOqP3UULxX
         y8VnCsouctNWDFsrH0t5Xre7zFLZ78dKBSC7DVWUvho+Hecdvl1OKHhV1+sXrrAR3sCg
         E13NDy0rXoEmsyb9Yd3Ul3iU+Xu2pzE4ImKNom1QB0aZft3GihDxu61eAmKIUcHUMWUO
         reDpKTo27JHjQ6onyXkJucc8JKH8OOOoiFMIWmDvLqkl1XBe71JCYl44SdwhIWBRQ+97
         FooK0vHTVa065qzJEcp8MrtiWG2CSc53u8QUmsGNpulmoAbKCt8eXyDqUTSpFdQ0P3YF
         BlGQ==
X-Gm-Message-State: AOJu0Yy3srMGQ9xmT7dFg8AwV6Z3dHxf7AmQqwMuwDc8Am0NMNefr4M7
	V/ZIvfb83lb7usBog32qNran8HeRhGRlWYTJZDOpLi7bFdw/KLHm
X-Google-Smtp-Source: AGHT+IH3FPwE6qZI4lePimpdihTCu2+4M+goAsWCLr1gg5WBXKJQIG5AopZ+Ybd6K0rzvVEmXu2YjA==
X-Received: by 2002:a05:600c:1e1a:b0:40f:f069:8d13 with SMTP id ay26-20020a05600c1e1a00b0040ff0698d13mr1551786wmb.9.1707258478726;
        Tue, 06 Feb 2024 14:27:58 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXLWt2bHc3pItp0Kj7IueMD5EQlloPokpWmQMwW1zM+SjrL5Y9jYlVFOyeNqvWMRj7oTUx0vZhEFXshjHYXibuMFeAhUW/MF4A4YufmckIKB47o0ufoKm4ViDNtgCxrd01k112UZdUAMQcpB9LkAWqFnA2FWCpI40Q=
Received: from nz.home ([2a00:23c8:a613:101:d819:14c3:eb30:3865])
        by smtp.gmail.com with ESMTPSA id bi24-20020a05600c3d9800b0040fed19162bsm2247380wmb.28.2024.02.06.14.27.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 14:27:58 -0800 (PST)
Date: Tue, 6 Feb 2024 22:27:57 +0000
From: Sergei Trofimovich <slyich@gmail.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, wireless-regdb@lists.infradead.org,
 Chen-Yu Tsai <wens@kernel.org>, Seth Forshee <sforshee@kernel.org>
Subject: Re: wireless-regdb key change broke crda tests after 37dcea0e6e5
Message-ID: <20240206222757.238a24f8@nz.home>
In-Reply-To: <455bafff0d609eb182ba30a5fbf319888e0e961d.camel@sipsolutions.net>
References: <ZcIXGjzrZrXPCBcp@nz.home>
	<455bafff0d609eb182ba30a5fbf319888e0e961d.camel@sipsolutions.net>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.39; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 06 Feb 2024 12:47:35 +0100
Johannes Berg <johannes@sipsolutions.net> wrote:

> Hi,
> 
> > "wireless-regdb: Update keys and maintainer information".
> > 
> > Both `git` `master` version of `crda` and `wireless-regdb` still fail
> > `crda`'s `make verify`.
> > 
> > Should `crda` key the key update as well?  
> 
> Maybe?
> 
> But perhaps the real question is if you should still be shipping crda?
> It was last needed for kernel 4.15, and even the newest stable kernel
> based on or before it (4.14) is now EOL ...
> 
> After that, we had the regdb loaded like a firmware file including the
> signatures, so the whole crda isn't needed any more.

Great point! `nixpkgs` uses `crda` only as a `hostapd` depend and
looking at modern `hostapd` it does not use it at all. I'll spend some
time removing it downstream. Thank you!

-- 

  Sergei

