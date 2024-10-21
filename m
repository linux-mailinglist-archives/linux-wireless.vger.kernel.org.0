Return-Path: <linux-wireless+bounces-14273-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D0EF9A6C2C
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Oct 2024 16:33:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 195AC283248
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Oct 2024 14:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E4D410A1E;
	Mon, 21 Oct 2024 14:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TcXD3XNl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D54351D175B
	for <linux-wireless@vger.kernel.org>; Mon, 21 Oct 2024 14:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729521211; cv=none; b=i1h4LvJ8Q6tK+VY51ELXC2nK+yibjch8Cplo7slYRhQcYQuU8q3Vbt0guk7dmh++IY5FKe0x8rhBT83f2B/ggzKb7OlM6Gg7y4BXEGTiqtamkzK9SChShmNVkX047u67bI4IDtggxmAO19meJrcGlpDVdWCkjwH2hw9ELUgDaW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729521211; c=relaxed/simple;
	bh=WC4r5nT+P30EZMByL8qDhc7I4ROzqMtt+CkC0BU7EJo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MWyJ934j44DICDt8xTjDgYP0TDbJXbMbQO4FrwlmpYy4eA/qhXcKPUH/SCOn7Hb7NgoFaw25i/D7jwxuAQrPVMqnnwDfuZmSfJmhf6OjW/FkvQakevPGeRaZqCiMcHcAIEDWBBYwdR/yUbnE0X8oyZe8hOBUR81SMV+WLbFJ95Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TcXD3XNl; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-20cdbe608b3so37159025ad.1
        for <linux-wireless@vger.kernel.org>; Mon, 21 Oct 2024 07:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729521209; x=1730126009; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xXcNGCx8R/h6DnznmoiuyzzGuU08XBAyXTEE1fx+zDs=;
        b=TcXD3XNlpJ3aIDFStbP/fAoXKQhalKa3XP9cyKxFEvnRZrt+iCmY/8qlkbu13t4HzG
         zeHlWcnuOGYUv3sjCY41u0J6gUenHaqM/1cnIzymye03gOkFTyHdH45+jETWuBDPASpu
         kFDkMmVisjApG5BI1bRMPgoaicx1TLa4r0ZiAbLATto6egiXcfAXyqzZfB3tS4at//aq
         EPcTNsl63as6CItXCZEiWJIZac7zRIR00B7AfEK2ioZSBryMLzq1fW5dKjSrd7I0JR4z
         inRI8VVvKAubqoAzViqdzvMpg9hJRH75rP5lyHWBAZOKX83lcBHCncym3oSAhtp02ehG
         DVZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729521209; x=1730126009;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xXcNGCx8R/h6DnznmoiuyzzGuU08XBAyXTEE1fx+zDs=;
        b=GaNcCWVVxy308vlf+AQ2IMhrLoXDM/QrBKmt5xDyYyEH4TN+rZq2MOjijckHXY9Jki
         iVINiug9eJlNGI+r9hYc6zQl8S2+XQY2BnwIVtc5x8p+am232pf0JYH/DRIGWtOrhFCZ
         VOu7j6o07EN9KC+nUubD/QF1+2iGDraPGRxI7T2vp5jkumcROdoLtTrSlKGwLn5dETbd
         0OgK7xq3kdiUnBZT9WSFojFaTHXjMeDNQ7xlmaq1QwC7gvZAKQpsp0OHO9M1FMFfhBCH
         buKhBr8AszGiYdf0w9Y+tpxI6/m6GogfcNGUXDq0FeZ78HNhj3TVRwvYaHLlcOuaM9CV
         pTEQ==
X-Forwarded-Encrypted: i=1; AJvYcCXYafe4VewpkYNTW7xDELR8OR/8St0bbw1b6Tj9W0KLCBgON/+TQqujUxjuIpMwmifiLiWW+V7sjsV+C4NgGA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxTIjqYqG1pregKtcjP32tTtiQCJcSZ6EWVzElU3BHcp1/NYwug
	L3BTXj+HMBnUqiZ4Y0zeYOO2eJpvo/wvwVp8aSf36G4NGMd6dJs2
X-Google-Smtp-Source: AGHT+IERko4J5g3Y5FtrovF6cjPJHBQn4RMxKj0/W17G1UwZDrfbNyImPvvVaXIFrVV4lt0+B1NWsA==
X-Received: by 2002:a17:902:d50c:b0:20c:5533:36da with SMTP id d9443c01a7336-20e9492fc14mr2005185ad.42.1729521209120;
        Mon, 21 Oct 2024 07:33:29 -0700 (PDT)
Received: from localhost.localdomain ([103.149.249.231])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e7eee62c2sm26680625ad.20.2024.10.21.07.33.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 07:33:28 -0700 (PDT)
Date: Mon, 21 Oct 2024 22:33:28 +0800
From: Jianhua Lu <lujianhua000@gmail.com>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: ath11k@lists.infradead.org,
	linux-wireless <linux-wireless@vger.kernel.org>
Subject: Re: ath11k-firmware: QCA6390 hw2.0: Add bdf for Xiaomi Pad 5 Pro
Message-ID: <ZxZmODYOgdQ3CHUG@localhost.localdomain>
References: <ZwR1hu-B0bGe4zG7@localhost.localdomain>
 <bba049d4-39f2-491b-a5e5-ebae0a77fe45@quicinc.com>
 <dc92b42f-a71d-4ca9-bde2-92c3ed30718a@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dc92b42f-a71d-4ca9-bde2-92c3ed30718a@quicinc.com>

On Mon, Oct 21, 2024 at 07:23:59AM -0700, Jeff Johnson wrote:
> On 10/21/2024 7:21 AM, Jeff Johnson wrote:
> > On 10/7/2024 4:57 PM, Jianhua Lu wrote:
[..] 
> sigh, correct link:
> https://git.codelinaro.org/clo/ath-firmware/ath11k-firmware/-/commit/4c8ae2fb2b78d5b0bebed63fe8b0f348f9fbc33e

Thank you!

