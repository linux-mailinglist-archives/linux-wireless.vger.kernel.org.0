Return-Path: <linux-wireless+bounces-24161-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 54BB3ADB76B
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Jun 2025 18:56:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 991CF188CBD1
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Jun 2025 16:56:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C77F286409;
	Mon, 16 Jun 2025 16:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ln8oyH5b"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBBFC1F8676;
	Mon, 16 Jun 2025 16:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750092959; cv=none; b=KhHOY9v1Ie9hF8F01bJz2WvFNaikD0TBXm+Wyd6/mkAdxgllM2k9e8J5PzBTkCC1V10GNvhhsnf8OWVzYdEMk0+g5rJ6VRdqH7lF2WEwrVVdD6mYJdAh1xg4uJtGsvKeAeSH0GiMzHnjO+wI070RNgLGqSIRGlNOSs/XyV8qTw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750092959; c=relaxed/simple;
	bh=phkkbhseVWABN8bFLIhcJUJdIvw1h1ys/1i7E1KA9vo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZqSUMQtsyoRunXIWmGdwbEn65T7j9ylV1NSgSKrABMZ0+H3fO61z/nq094Wn1TCyadhA7MCj3otS06hveYqoH73KDHQ8jEZj/OCd65hW2OrEEObW134xCkSfs5ecVEbfxZVvscP5i7IxCn4wKO0PULpULWiL46/NZrui5nHlo/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ln8oyH5b; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3a365a6804eso3442337f8f.3;
        Mon, 16 Jun 2025 09:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750092956; x=1750697756; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xho9MnGobVDLdr7OZ8vMO8bLISaRTf1UaBU/1qtOO80=;
        b=ln8oyH5bKqJsByrNhd+7vbuYxKIXUrgoIy7y0RKGX71DqiA7D+iWkObJGWBHbJX3BZ
         uLaIgDUcCEc3OHs5zepi5RQ0S62h4k663oVkWT7GYEjHnPNkgFjvlx639PAFh9crYf54
         IAB9RDFj6ORZBpPk3pB4lZW+BXtRiDmsxA1Jg8A6AR2HLrZ5xLW24nBgNBJskmzUR5/T
         ztOJ7lH1kBFTwJN1GsbibbZ18Ig4oxLyoyvCOhSXVQ2CbMLxDbbqxjEVt8iZNeENx9Ql
         czG56DU4YHzc7qe2jobyP7oyNSKBFgJIpiuUmvWnUrY6YbATI2S0wTXrlpT106B2Une0
         ougw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750092956; x=1750697756;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xho9MnGobVDLdr7OZ8vMO8bLISaRTf1UaBU/1qtOO80=;
        b=vfkGBNwOU8Q1ev2y14mpQk9+RnmljAnBgAfZ2sRK2kpxLmLnCqlOXNMk4kLHKCy2WF
         h2xBpijpz9QNcZMugLy60FMiUz3Lh8FDfWE7wnobmMg0KoO9PYvjgFo1epMOY2y055cF
         CeB+ir0FHdpJD7bPrrXo5fIPyKXPeLI0oWCMpg44TvXcxjGWdGQkf75zFCf2iigzReux
         xsy5Yldq+wFmmD9FLXqvu22XnUjWzlhP/aOsKdu4quurEWr6DkmKmYN2Qh22cfs3JlTR
         0UdkFDUHGp32FCTJHRiezbKvA2wNc+/S3lX6Donyh95r98HJizUJKnCStsMaedmgi5Wr
         r4KQ==
X-Forwarded-Encrypted: i=1; AJvYcCVkZa+1eCmzbaCNtrAKFwzE+Q+A6fTTCNhj7souZsa95wHWNY8mGoaIdFdZzDb4VaRA6HWHGt+/zEKJEh0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHOj++Hsy5HBdJJ99st2onSy//P5y0r9YR7O9u+GJy4wp8ufoI
	D7tNbisLddWPAEWEeM3eukAwqMLN11M0f4kmiP6imXq6sUqu7FBFH3WHPJr+HwaV
X-Gm-Gg: ASbGnctynQTnmeF+BzJaZS82Ickc0lOL7JwEpzQNNscTktEoLYQZFXzCkM6k/BKUCFu
	W6Qsp72JiZ8pKgQ50s1UmoOMId/nibPkd2xjRUh2+4EmD4NZhGaDIgzb/cpKJtvxFTseVFdnr+7
	3FLi8VF4j918TsY3rN3k+W7XbeONyplVUhXiihD5PP/th6mSnFnXi54/hLDcy0VlcJcRsdNju9i
	II9ihLqvzgUMRMCddIbZI1yV1N2+wzz0tafLQ//oSA95vkb+sO+xwqS6AXnMXYcFte8AG/az8TB
	2BR0u9u0wmkk+/y/PS5hFrCNBA8bJGcHQJ7GuKWZBhku1TKJZ+zD+ooJINFQiDCgYJ0/q61YDcV
	eu0sBD+lyWjJkrnkvcwJ/HNQpJ/UiOTZJ7je6sotm7iPbaV7KAhwl9HXzIlI2uhPgb2c=
X-Google-Smtp-Source: AGHT+IGtR+QBhNFdNp7SWEEa0Vj7nw1o6INQvcqSillwzViCw9RAnfkoxmt3jtFc3cOXZ/UHxA1Wug==
X-Received: by 2002:a05:6000:4024:b0:3a4:fc52:f5d4 with SMTP id ffacd0b85a97d-3a572e58f3bmr7800562f8f.47.1750092956064;
        Mon, 16 Jun 2025 09:55:56 -0700 (PDT)
Received: from shift.daheim (p200300d5ff34db0050f496fffe46beef.dip0.t-ipconnect.de. [2003:d5:ff34:db00:50f4:96ff:fe46:beef])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a568b090b0sm11512701f8f.46.2025.06.16.09.55.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jun 2025 09:55:55 -0700 (PDT)
Received: from localhost ([127.0.0.1])
	by shift.daheim with esmtp (Exim 4.98.2)
	(envelope-from <chunkeey@gmail.com>)
	id 1uRD7B-000000006nF-3fyK;
	Mon, 16 Jun 2025 18:55:54 +0200
Message-ID: <6bacdb9c-6064-43ea-9dfe-0eca496d1c9b@gmail.com>
Date: Mon, 16 Jun 2025 18:55:54 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: carl9170: do not ping device which has failed to
 load firmware
To: Dmitry Antipov <dmantipov@yandex.ru>, Fedor Pchelkin <pchelkin@ispras.ru>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
References: <3qom4fkg7kp4l3bcgrbivmm2yi2wqrmso7rb5qe3xffjj3k7hz@nc7gx4atzfyq>
 <70de6013-a5db-45c6-8288-e7b211a55a1e@yandex.ru>
Content-Language: en-US
From: Christian Lamparter <chunkeey@gmail.com>
In-Reply-To: <70de6013-a5db-45c6-8288-e7b211a55a1e@yandex.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 6/16/25 12:01 PM, Dmitry Antipov wrote:
> On 6/15/25 10:54 PM, Fedor Pchelkin wrote:
> 
>> So it looks like ar->registered being false here is a "correct" failure
>> condition, i.e. it can be expected when the certain phase of the driver
>> initialization fails and should be handled without any WARNs.
> 
> Looking through Documentation/process/coding-style.rst, it may be
> better to use pr_warn_once() instead; anyway I would prefer leave
> the final decision to the maintainer.

Sure. I think you made a fine point. Grepping through drivers/net/wireless
in the (wireless-testing wt-2025-06-08-24) it seems that this could be the
first  pr_warn_once in there.

@Dmitry, would you please respin the patch? Thank you!

Regards,
Christian


