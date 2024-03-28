Return-Path: <linux-wireless+bounces-5499-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 40CE3890C7E
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Mar 2024 22:29:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4861B21CEA
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Mar 2024 21:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE1CF138493;
	Thu, 28 Mar 2024 21:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SwTgD1ZB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EBE2137C3A
	for <linux-wireless@vger.kernel.org>; Thu, 28 Mar 2024 21:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711661344; cv=none; b=u4tP1PwR1RVSaA1iUl1IKIghhnMLsdTSDhWH2k0lDz47IRAZwNryufQOUJfL/3REYwVw8ss+AkXLniPuVUcYyQjNbDGrw8qADZVuC/t9/bjkY3FJxMJ7e6IxGqwbHfnSXxgA7vlIOA6U+3q42ZNS4/TQv+kzzRUYrEZEJPOKy3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711661344; c=relaxed/simple;
	bh=R2NqZQeZpRiK5pfJUsHmjyv9bSF5G9cxTMQv5+Ergmk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FQcbXjhLQlGT6AR1HMcMXaUtYW5bBa46Mcwd5Ub2VHTq/bDa5Cj7CTkhYdRpsMHn7Zwk4kT2qQQhv2NZGp5PM01QhnIZT0752CmDuW/kJRYN2lFllVdtSoyMkQPPHLfzvzJrQHWiSwVVT293CXlb8Mi/T6bSM69BBOL0q9i1VZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lwfinger.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SwTgD1ZB; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lwfinger.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-229d01e81f1so759546fac.2
        for <linux-wireless@vger.kernel.org>; Thu, 28 Mar 2024 14:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711661341; x=1712266141; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=MhcN77WPOel7sYhLn1IXDVh5R504ybD/DA7ChmTuSjM=;
        b=SwTgD1ZBqNk0cOXN9SNBVq7Asqj+Bkx/7VC9rmfBIBDnKmQQ1c8S6lRVSoDrJNymzf
         +A/pwQgnciP3zcRRrptDbWa+ROFTLTq3ajVXeMrzkUcSuS9OP19p80+oaNjCVsWrPnV0
         7xSkv31C5/OQa0a8jL5k92sGXLITN6/aM5UvgtWzgAMviT7JXpbZCnLRrOMKOC02NREL
         7Y5l/5CjMu9xeqFJYzP8lO9o7G/Hrpg2unn6l5vSfqZ01QD5BR9v0w/8H+TUrqv9Y4Ox
         oMCRUlfWy05ursAn4ZKI45AxSpYEH56O9OtYOokNVMe53F2cAOC9O30jE4r6ipz3wEXg
         6KKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711661341; x=1712266141;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MhcN77WPOel7sYhLn1IXDVh5R504ybD/DA7ChmTuSjM=;
        b=rd0NyT2SdnEB4L1GpkmP0exkOTEQpkEyI4UITQ1R6Y4bm51p03ZF6Y1g47G/69s7hI
         uv40o+mxSNgv5OqCXoH9vFQMzjoqu/LC3gpk8ol+JwUASO6jl7kInwFSKkyagbYHzqMb
         U7tvKVDG+F05FP3KlQCXcAqfDGzgdANS8IlKFV98ZIw5qJHwoLD1MP7ULq2hUaak1WK7
         cnq183ouHUqKW04ySGZTSZjcH/44tHkVToeAe/xem6V4KP/Oj19HdQRbjBuSsxR2NnXi
         S6B7XK8Z5H895c+4ewTZSvlmG7PyW8mYt/mwhUjKuM2HCelrpM5xsp1QvN9/0Rm+QaHk
         3YyA==
X-Gm-Message-State: AOJu0YzpP/GbduItNuwuHbw624mSAD6sq/UJ7L3jzYB+LV8qkIaTCDeU
	0IZnUjXa8q4meXIxDgj9tmCfWB7OsP3FY/YiqdjJs0WUNSpkH8wOUH/w159N
X-Google-Smtp-Source: AGHT+IEbUMr9ZK7yrgPitjRYdBgen2NtmwkaszPh4LbJTfeSuh0ziEIE+8QhBlXpAF/69rVeS3/sKw==
X-Received: by 2002:a05:6870:1b1b:b0:21e:bd75:1947 with SMTP id hl27-20020a0568701b1b00b0021ebd751947mr443191oab.59.1711661341680;
        Thu, 28 Mar 2024 14:29:01 -0700 (PDT)
Received: from [192.168.1.119] ([216.130.59.33])
        by smtp.gmail.com with ESMTPSA id pu23-20020a0568709e9700b0022df838baa8sm20323oab.0.2024.03.28.14.29.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Mar 2024 14:29:01 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <60ed1494-f67e-4932-97bc-4d0a8ef28904@lwfinger.net>
Date: Thu, 28 Mar 2024 16:29:00 -0500
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Is RTL8822CE with Kernel 6.1 for imx6
To: =?UTF-8?B?5pa95bCP5LiwKOWMu+eUqOWItuWTgeS6p+S4mumbhuWboi3ljLvnlKjliLY=?=
 =?UTF-8?B?5ZOB6ZuG5Zui5pys6YOoKQ==?= <shixiaofeng@weigaogroup.com>
Cc: linux-wireless <linux-wireless@vger.kernel.org>
References: <f9206f84-554f-42af-8bd1-22e3ce087900@lwfinger.net>
 <AGUAKADXHiG7jCbFWYcjOqqy.3.1711649471074.Hmail.shixiaofeng@weigaogroup.com>
Content-Language: en-US
From: Larry Finger <Larry.Finger@lwfinger.net>
In-Reply-To: <AGUAKADXHiG7jCbFWYcjOqqy.3.1711649471074.Hmail.shixiaofeng@weigaogroup.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 3/28/24 1:11 PM, 施小丰(医用制品产业集团-医用制品集团本部) wrote:
> Hi Larry:
> This week, I tried 5.4,  5.15 and 6.1
> 
> Only 5.4 works for 8822CE module.

Without any error messages, there is little I can do to fix it.

Larry


> 
> 
> 


