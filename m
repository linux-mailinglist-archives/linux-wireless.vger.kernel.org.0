Return-Path: <linux-wireless+bounces-4708-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D95A487B486
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Mar 2024 23:45:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16CA11C211CB
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Mar 2024 22:45:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8A105A106;
	Wed, 13 Mar 2024 22:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HvQnXbu1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2F2859B56
	for <linux-wireless@vger.kernel.org>; Wed, 13 Mar 2024 22:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710369901; cv=none; b=kWaXuASHxqd3Vd8yWhV4XIkXF6Qv1wCV+DuiMgaWWk3CFAS4cGBSKOGiZmcm1NlbX8wMiElWxLi5qAI9BaWL5G3hTlOMVpDv466jnBCX8cIfktketnAY9R/j9J4DErvlPkHPtf7REo1pT8W3NSlR0lNxdE+LEzppdMm4B4M85ZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710369901; c=relaxed/simple;
	bh=0Qg3Ly1OVMXH9MoVNxuk/Hj/xljMcK6e9zcsl+/9TZ4=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=IJrLsodDQRfpO9VgabcF7zsxn8GO3uySIIXS3lRTmOKz/4PiJvmrLGV6yf0HbsK4fUlEPb/ywWNxXCNUohJtmeDJirW9mmllvAF3V6Yt/3SCmeoDi/aF710TaE0eFN5Pm7aNk8fgLe+OuRFwrDedScKAAsL/wQCE3TrPh0lIz+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HvQnXbu1; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-33e82c720f8so368045f8f.3
        for <linux-wireless@vger.kernel.org>; Wed, 13 Mar 2024 15:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710369898; x=1710974698; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dZJZPnASUtJl8Qt1NDiLn0hQSkcb90aRf9ElbYq74V8=;
        b=HvQnXbu1+aA8ysUGGZKnoJ1dODsZmCR3DuxJXuc6X3hfT2yBy11JBjyIzk1X2hXEHc
         qqhObiOA2/u1k+NK/9DMgkoHw5tJf52GuX0otJeSkab1Uo0P/rY5bYeR28fMAiqhth3b
         lLWcVRETwKzq+tOSzpS11/AzZF9HxnGCgGQ9KDhStAbEyaGxMqxDKEySrL7NlO9fv0ev
         oGQMC6PYdDZ3+YpoRGWyIdvORTnrgOZvfafuap8sfbrOAWU3sG5nu4fvXf91v5rf67Wr
         nVnICo6j4SnHcw43hv70x2zO9MoRvtFJhy9ZDDln6YPB5etlg+eMmtrZJSCSc/WonBoU
         m5Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710369898; x=1710974698;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dZJZPnASUtJl8Qt1NDiLn0hQSkcb90aRf9ElbYq74V8=;
        b=pnoqCiRFCpQn0JP/fc46d/fpXGZhapJrfU2trgMjHe1JURY9kxNuB2FYPJE3nveRhL
         Jx+UCbDMfp5+p8UMtdNUru7aotluhSgsr7vdrykLWuhsMTPq65n793SK23dDl75ynzW4
         zR4R2DzqTGEtlXRq4DYskeCRy1IXFsP4BEjHbjbbaBCwCqy13XZRNsAPL+c9sPB7IT6q
         AhIS/d/wLgkYAJFN95LYEcOtbPM3/ZgUEHSK87t1lmOM6913s+t/9Wr+BK3RblCp7NLI
         AL9W5XG2ZeFhyDGGHBjp0KRtsGasFZOot4SIhF8RehU9qRbrkKgo5hW841iF2hSVdpgx
         UNyw==
X-Gm-Message-State: AOJu0YwvOmriKOEpYivMG9QEOV0+0hyqpGD56N4ZlRRkW9oOOlK1F6tb
	B+HjLvTTfj3u6tjccHAvgAmtvPufVBiEns8di/BfrYJYeiaj+ViH
X-Google-Smtp-Source: AGHT+IG33u6SVQQogrd83KrF4uXDj75qmh5Bkgp7gcS+NXxRy2wko3OSEA9pVP5x1bLXSRnF6FsUDw==
X-Received: by 2002:adf:e4ce:0:b0:33e:ae46:fa6 with SMTP id v14-20020adfe4ce000000b0033eae460fa6mr1853wrm.36.1710369898278;
        Wed, 13 Mar 2024 15:44:58 -0700 (PDT)
Received: from [192.168.1.50] ([79.119.240.211])
        by smtp.gmail.com with ESMTPSA id bn5-20020a056000060500b0033e49aebafasm176437wrb.3.2024.03.13.15.44.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Mar 2024 15:44:57 -0700 (PDT)
Message-ID: <7efc3fc5-db37-4fd0-a561-0e2c14107393@gmail.com>
Date: Thu, 14 Mar 2024 00:44:55 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Subject: Re: [PATCH 1/3] wifi: rtlwifi: Move code from rtl8192de to
 rtl8192d-common
To: Ping-Ke Shih <pkshih@realtek.com>, "s.l-h@gmx.de" <s.l-h@gmx.de>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
 "Larry.Finger@lwfinger.net" <Larry.Finger@lwfinger.net>,
 "chewitt@libreelec.tv" <chewitt@libreelec.tv>
References: <e1922019-21eb-4013-a35f-0077167e92cf@gmail.com>
 <20240313064917.527110c4@mir>
 <4c4aa8160119935e48f9da679b502f80da4c0fc7.camel@realtek.com>
 <20240313071850.61a42e4f@mir>
 <cdee2e123ce2845f757ba74751f4871999fd5c5a.camel@realtek.com>
Content-Language: en-US
In-Reply-To: <cdee2e123ce2845f757ba74751f4871999fd5c5a.camel@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 13/03/2024 08:25, Ping-Ke Shih wrote:
> On Wed, 2024-03-13 at 07:18 +0100, Stefan Lippers-Hollmann wrote:
>>
>> The performance is okay - the driver has been working reliably all day
>> long (WPA2SAE and WPA2PSK/ CCMP, 2.4 GHz and 5 GHz, against an
>> ipq8071a+qcn5024+qcn5054 AP running recent OpenWrt).
>>
> 
> Thanks. Both PHY rate and throughput look good. 
> 
> Bitterblue, Can you make a record in commit message of the last commit
> that enables 8192DU?
> 
> Ping-Ke
> 

Sure, I will do that.

