Return-Path: <linux-wireless+bounces-1837-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C6BCE82C4AA
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jan 2024 18:27:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 784FA1F22578
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jan 2024 17:27:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF90917569;
	Fri, 12 Jan 2024 17:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c8MVsOyD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7849417540
	for <linux-wireless@vger.kernel.org>; Fri, 12 Jan 2024 17:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7831aacdaffso565238685a.3
        for <linux-wireless@vger.kernel.org>; Fri, 12 Jan 2024 09:27:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705080448; x=1705685248; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5f5cdbiijVQUJ/1hGWGI7VXRemJLNUAkUSpSuzSBZg0=;
        b=c8MVsOyDMzb1mF1qf2xiPa3ZVblK9teEJgoTUU4JGeBV8ebWkqQ2vXRySnJRTPPnVX
         IpcFZMO1BQQHRhowFFXN0tobjv0RdqRKHkwe6Yfu2FQ2pvLWELCKJ3T+vfBhZ8MQUT+A
         GfWRny3xK8ABJEjXVVPB0T4OZgs851kB/Xecdxkaol3dyLWjlvdtYVarNn0QVqTZWF9u
         jd/7443mLl3IeRA1Wt13uubxy49aLkg/qJr87WeHh7rjEuTkCqwmhIxrHULp4a2h1KuT
         AAiikBuQTl67X1UjUN1E0g5t+Lw75qRmcrMcyBNu2SOZYQbIrQz4QISssFYFf7zcrQGU
         Z7ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705080448; x=1705685248;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5f5cdbiijVQUJ/1hGWGI7VXRemJLNUAkUSpSuzSBZg0=;
        b=Zqey+XjhhP2maTAc5Obf/sWNXvmYyB9R3SICX6e99MVYkdf6h/VMAxXUN2lf1ROAIu
         /ntMwyqbH3CHwWCHH6USM6Z4mzxL0wERk+Y/nnLJ21AagSbKGVwuI8QXEQhRmWSAtbVy
         lytZG9H0RiDE0mKwp4tyyiNWTtGCUd8prPiyjsxHxAr0QdXfy0mGipr4eD9BNP1szvUV
         C87Al3GmcfDU9denFiiYvn15GxvH0UOWtKQhI4BqaNL6U3PTReTV5NRymsL/Ysb2oOzg
         JHlfSewr35fx7qGomN/h4oSI3PFyc69p0l7OL9YB0jz8SaewwdeXD0Tv2b1y2ImeGeO8
         HPOQ==
X-Gm-Message-State: AOJu0Yw0J+eDu2sa9TDXCOYQn2dKs1w1MMZ2RBHnYxO+UlQT5uc6ZO07
	NjA8mSzdgF8AUiH06y4sVXE=
X-Google-Smtp-Source: AGHT+IF3Cce5e2pK2NfK20DlYf3MGpYbbhjXxUYRQSkQA0n45RkHOZF6IBdPNJx873JjOjIVmQf2fw==
X-Received: by 2002:a05:6214:130b:b0:681:132e:6e3a with SMTP id pn11-20020a056214130b00b00681132e6e3amr1732427qvb.3.1705080448248;
        Fri, 12 Jan 2024 09:27:28 -0800 (PST)
Received: from ?IPV6:2001:470:8:94a::251? ([2001:470:8:94a::251])
        by smtp.googlemail.com with ESMTPSA id bs6-20020ac86f06000000b00429d6bd085csm82671qtb.6.2024.01.12.09.27.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jan 2024 09:27:27 -0800 (PST)
Message-ID: <efc80287-1c9a-b298-9390-5e3e277e6d05@gmail.com>
Date: Fri, 12 Jan 2024 12:27:26 -0500
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 5/8] wifi: mac80211: disallow drivers with HT wider than
 HE
To: Johannes Berg <johannes@sipsolutions.net>,
 Miri Korenblit <miriam.rachel.korenblit@intel.com>
Cc: linux-wireless@vger.kernel.org,
 Gregory Greenman <gregory.greenman@intel.com>
References: <20240111161746.3978601-1-miriam.rachel.korenblit@intel.com>
 <20240111181514.da15fe3214d2.I4df51ad2f4c844615c168bf9bdb498925b3c77d4@changeid>
 <037b6a4e-e143-3b69-2ab2-00c4dee75bda@gmail.com>
 <8bf953ad3255982277e8eda484b5b2a367f5a19d.camel@sipsolutions.net>
Content-Language: en-US
From: Jonathan Bither <jonbither@gmail.com>
In-Reply-To: <8bf953ad3255982277e8eda484b5b2a367f5a19d.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 1/12/24 05:21, Johannes Berg wrote:
> On Thu, 2024-01-11 at 15:39 -0500, Jonathan Bither wrote:
>>> +			/* currently no support for HE client where HT has 40 MHz but not HT */
>> where HT has 40 MHz but not HE?
>>
> Yep, typo, thanks. I'll just fix it when I apply it.
No problem.
>
> (Btw, it'd help to trim quotes - no need to quote _all_ the context
> before and after.)
Sure thing, I'll try to be more mindful of this in the future.
>
> johannes

