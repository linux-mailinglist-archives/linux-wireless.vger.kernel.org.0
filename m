Return-Path: <linux-wireless+bounces-4651-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF8FC879FA5
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Mar 2024 00:21:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CFE41C212C0
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Mar 2024 23:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88B6C4D59F;
	Tue, 12 Mar 2024 23:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eLdfezOJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C55194D108
	for <linux-wireless@vger.kernel.org>; Tue, 12 Mar 2024 23:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710285707; cv=none; b=aEG/x20D6poAXFHK/JwugdLY+Ao0yW4DAsxD35UIKam3zTGDslsTZ9QIbRX/8EOixl/T2kSaxEYpKqciGYPdPNWiy2Ik1oiQFmN9B9xIjkrnh9n2hhQNOdZcRNcQRBUO5lLIA9PHhuePIAKBAad6Mu0+8OxNet9iqfVFkjzM/T4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710285707; c=relaxed/simple;
	bh=5P3rpX6Z7Akn4vNHtlzzlg4mBYF6KIIDgaxBsnImyzg=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=SrDkKteDhk56Cv9+QEo5OOQL4WRwoIQq9QNmlHolMwKzxzKWP0kZrTIgaI6EZSiyo911X34DUjsXTAIfuFF0nXl8QHUCXTz4HQyV103Z3UlkAZ/qn4aBqMFABeqbTG4dEC1O6UWogH+0fNa4ifJiou3SW3vhabw+vaG0WQMwSmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eLdfezOJ; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-41329b6286bso16042525e9.0
        for <linux-wireless@vger.kernel.org>; Tue, 12 Mar 2024 16:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710285704; x=1710890504; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5P3rpX6Z7Akn4vNHtlzzlg4mBYF6KIIDgaxBsnImyzg=;
        b=eLdfezOJ/PEZUBFvEjKMMKpsi1GuqRT3MDEZzu/fVG4FzWBrYtqx1VKapSH9QQpF7q
         iYZCtRkTP+dyauwNV2D2wMGOJWHs2hj29Av+C9ncWs+VUqMnlDkQxXDFztsYSzCK5Liq
         fuG27TBwpG1A9zN0gmzy9jj742Kjxwj+0v/CB+hxJlpFOBLM4eLOCgUmvNNPeDXhRFLe
         Nj2jyai5zaOyzerseNR0D8+puu+iSYluvsUVyZlVQpdpm99nMwJTTysC3Cj7TJ2rFC38
         1/cJEfZ7KB0rEqGAPsSVT/Uikt0ax2gcDjXkRMPBFmHlV7bo40Miqg4XtKudywDdh8iI
         mTDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710285704; x=1710890504;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5P3rpX6Z7Akn4vNHtlzzlg4mBYF6KIIDgaxBsnImyzg=;
        b=r/+enyP2Gc/A5NLFprDLp2JeEv14Lw/gNEI+pMm+Bsr+fNGtuAuXP93RVWnb+x96u9
         zP/SmraLwdmBfxuoaJa9V7I4x+UwFLH/ZQRJ0izTCE3O5HAzBvIWeZ0fAntRkspiWgnW
         ZTmislVqoHDbLtFcB/NKFmj9rYGsbc6bwTBeRPXnGDWRXf74RNjNa1W8GlR3MJ5E/3xE
         0DVRzhgHmA11JP+bBQ2aPN/82C84Bmp5tQ+VWDTs/Boj9bL8C3WW14OHvWgKCHz1xiBZ
         RThHI75cLXMobXa/Hz15HXdGhsJdEntMuRxk9nN6wQBgStb3JKin4zkWtFHa8EbGVCuj
         z+/g==
X-Gm-Message-State: AOJu0YzNLAi9kiZBS17PpyluijyUtpwaVc2B05UZDD5epf6hFFyxodA0
	p7/z1em46UuD+J8py/R/1Xto7OIfb9Qx7qJ37nyu7qD5PP9LhatN+UCs300S
X-Google-Smtp-Source: AGHT+IHlrcnXARowMYpQqjiqOz9N3IsAuiQ8RKV2vbh0jfK8XqPp49Bw+7jBPWN7NznA8Wohr8Fs6g==
X-Received: by 2002:a05:600c:548c:b0:413:271a:1e5e with SMTP id iv12-20020a05600c548c00b00413271a1e5emr1029910wmb.38.1710285704032;
        Tue, 12 Mar 2024 16:21:44 -0700 (PDT)
Received: from [192.168.1.50] ([79.119.240.211])
        by smtp.gmail.com with ESMTPSA id w9-20020a05600c474900b00412706c3ddasm376939wmo.18.2024.03.12.16.21.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Mar 2024 16:21:43 -0700 (PDT)
Message-ID: <19743f05-5c95-41ad-bdb9-3694e5d2bb41@gmail.com>
Date: Wed, 13 Mar 2024 01:21:42 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] wifi: rtlwifi: Move code from rtl8192de to
 rtl8192d-common
Content-Language: en-US
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>,
 Larry Finger <Larry.Finger@lwfinger.net>,
 Stefan Lippers-Hollmann <s.l-h@gmx.de>,
 Christian Hewitt <chewitt@libreelec.tv>
References: <e1922019-21eb-4013-a35f-0077167e92cf@gmail.com>
In-Reply-To: <e1922019-21eb-4013-a35f-0077167e92cf@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

rtl92d_dm_check_txpower_tracking_thermal_meter() is actually
unused in rtl8192de. Should I just delete it?

I don't remember why I made it static, but that introduced
a warning.

