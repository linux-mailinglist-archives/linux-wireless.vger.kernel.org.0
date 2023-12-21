Return-Path: <linux-wireless+bounces-1179-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B4F8A81BF69
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Dec 2023 21:07:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF9CB1C21E88
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Dec 2023 20:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 450D2697A6;
	Thu, 21 Dec 2023 20:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eHOhvKkM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC9236EB63
	for <linux-wireless@vger.kernel.org>; Thu, 21 Dec 2023 20:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-7b8529ce303so15598139f.1
        for <linux-wireless@vger.kernel.org>; Thu, 21 Dec 2023 12:06:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1703189212; x=1703794012; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hGa4HpSCAJBcJua8zvNb9GizD8kC9hwlf6LmyFf2834=;
        b=eHOhvKkMMHruW2oVZHMyoKVz/8EMz03nFmzEgRaqLoBvCRJqd2bOKaO7+2xPf2Sicx
         bB5/CC3bbCRvyTdS6CXk72okbLWF41VNS5cydCkxXzmUoXBru4nqW6Px0L6feIYcjfll
         4OqUrfPtIE+MA0brx1PoDdtfPgCYxMCbCx8d0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703189212; x=1703794012;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hGa4HpSCAJBcJua8zvNb9GizD8kC9hwlf6LmyFf2834=;
        b=liWVlqnSNATMo34SJTubgqQDqm8/zpTN125VlOmLdS7WItYDfPX1MslWnifAGJ+fGd
         GH7nAU2LYmpZNTf4fRODkcBy31H3NhObfqIdU5ohqQ8HZi8jNtU+jAUE+OzBy1hYSkRN
         TBp8r9VImLn/4XToWumEdKdYnvqVO1N/oGn1scP+5XyFTXkeSTDAY77WhMXQxBVOk4gs
         iaZ4p5bBnBvfZ459wAAw27I9jIzgZHR0yNg+qUMcrJFkr9OQ4Rzmhb43vUgeiJBTbceE
         DQ8yAT3rGUv3vhfcUJONJcd9QeFy2MNVI0Y9V2WpYVU2WL+Fcb1awP/0cko4C1njdPe3
         jsaA==
X-Gm-Message-State: AOJu0YypCUloAlVe0wJLJMo8yElw424gqrsChskmvrVXWgvmtOJKHNpQ
	Fq0FNeN1aPkvvZBhGNGdG1mJOex+NUYQeg==
X-Google-Smtp-Source: AGHT+IHJ24hh8AzP+0pbrhZids11wF22fPSqTMJrtHmVYNgPU4p4flxDy/CRTNsy+T1bIzQ72rOreQ==
X-Received: by 2002:a5e:c642:0:b0:7b7:17c0:e19e with SMTP id s2-20020a5ec642000000b007b717c0e19emr583129ioo.0.1703189211933;
        Thu, 21 Dec 2023 12:06:51 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id g7-20020a056602242700b007b457549001sm643626iob.36.2023.12.21.12.06.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Dec 2023 12:06:51 -0800 (PST)
Message-ID: <ae651d3d-58f7-40de-a625-4882cf0efc9b@linuxfoundation.org>
Date: Thu, 21 Dec 2023 13:06:50 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] Add some more cfg80211 and mac80211 kunit tests
Content-Language: en-US
To: Johannes Berg <johannes@sipsolutions.net>, benjamin@sipsolutions.net,
 linux-wireless@vger.kernel.org, linux-kselftest@vger.kernel.org,
 kunit-dev@googlegroups.com, David Gow <davidgow@google.com>,
 Brendan Higgins <brendanhiggins@google.com>
Cc: Benjamin Berg <benjamin.berg@intel.com>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20231220151952.415232-1-benjamin@sipsolutions.net>
 <fab3c87ea726208cbdec03dfd61230e4c8ceb694.camel@sipsolutions.net>
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <fab3c87ea726208cbdec03dfd61230e4c8ceb694.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/21/23 12:39, Johannes Berg wrote:
>>
>> This patchset adds a couple of helpers for kunit as well as tests for
>> cfg80211 and mac80211 that use them.
> 
> I can take this through the wireless tree, but then I'd like to have
> ACKs from kunit folks for the kunit patches:
> 

We have run into conflicts in the past with the kunit tree. I take the
kunit patches through linux-kselftest tree. I do want to make sure there
are no conflicts. I don't mind taking these through my tree.


>>    kunit: add parameter generation macro using description from array
>>    kunit: add a convenience allocation wrapper for SKBs
>>
> 

Adding David and Brendan to the thread for their review.

thanks,
-- Shuah



