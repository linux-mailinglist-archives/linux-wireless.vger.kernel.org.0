Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E0B54D373
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Jun 2019 18:16:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732024AbfFTQQh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 20 Jun 2019 12:16:37 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:33766 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726661AbfFTQQg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 20 Jun 2019 12:16:36 -0400
Received: by mail-io1-f65.google.com with SMTP id u13so190242iop.0
        for <linux-wireless@vger.kernel.org>; Thu, 20 Jun 2019 09:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Ql2IMEwYVC1mbSwBK+TDG36+seYz+amfXr8hmAfrbDg=;
        b=sDjX143jf/EzMalTF4GCAXVjCc1maI8c5vbJis3UGOIScM9nGMYmAJUDoHtUAycPTt
         V0jTBzuRg606TANqaiijXSOiokd3vjBBHQ1kDncvUPEDW63uyx6YC/YlquaEyKDVGvDm
         nZHI33o31jMVrFcrsW8SW58iVMa0bWytZL95RsOOLwL4KRSdf9JZg3ZLMr+YyzJDiEv1
         WEctdQc2PbcyXEIjud5Xbl5FeejrjMulc7Mu801prAZZH94tM/0n5q39IgQ9UECb1T6J
         Wn9ocN3abUjvwNDO2aO7JOfQEPAubUdD87hirhrlatV4qHskvawKc9Vl9faMxX4MYs8F
         VolA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Ql2IMEwYVC1mbSwBK+TDG36+seYz+amfXr8hmAfrbDg=;
        b=F/EYTOUlW7LEJ0JH3yQtaE+rzWE8vRD49cuesUnlnBGx2xwzOjCVe9pLbB10U/I43n
         XAje6pAbTN2x371cTx3ye6Y3zwGjJDEzcKnud26Mpmx/+GxfHKmLYxQFPJxFRq23RrXP
         p0eJqvXiaUO/tLLb+8/vfr1slrvc27jr2suX2VUJF0UnWivxZe37xeWDV6PNlLnI2A64
         TARk/x4xmaLaPinpPqLuEOY9Kjaw7UlZ/OyUj25J6FCsa0YnDvEXQidgHObtP9trRFZq
         MFGiQ3QGB3z3Z+y40TUcqisH9m3LmR77wuaXuYs2CzrAds6mlNjT0wBf28WjS6d9yYZb
         /w9g==
X-Gm-Message-State: APjAAAXyVNa8IR4Zkdv3tCcxD1tez8xI0x4QMwomc3pTcBRMGC10PMFr
        kP7crGtvbAnzkZB0BEHmhk60MsvN
X-Google-Smtp-Source: APXvYqwIab44esu6B5m2NH3wV/DaaHbqEBi5G5hqRckBDbmgS0uOrD9hlPU7bWyA2BfgOwZiKTh64A==
X-Received: by 2002:a05:6638:2a9:: with SMTP id d9mr99791834jaq.94.1561047396183;
        Thu, 20 Jun 2019 09:16:36 -0700 (PDT)
Received: from new-host-2.home ([2605:a601:808:1001:37ba:4f0a:192f:f945])
        by smtp.googlemail.com with ESMTPSA id i3sm283476ion.9.2019.06.20.09.16.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Jun 2019 09:16:35 -0700 (PDT)
Subject: Re: [PATCH 3/3] nl80211: Include wiphy address setup in NEW_WIPHY
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org
References: <20190619223606.4575-1-denkenz@gmail.com>
 <20190619223606.4575-3-denkenz@gmail.com>
 <ec1ca95a5789f9001e89e603633b20316d687721.camel@sipsolutions.net>
From:   Denis Kenzior <denkenz@gmail.com>
Message-ID: <7da9b924-78c7-ba72-fecc-a11700a34ff4@gmail.com>
Date:   Thu, 20 Jun 2019 11:16:33 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <ec1ca95a5789f9001e89e603633b20316d687721.camel@sipsolutions.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Johannes,

On 06/20/2019 01:58 AM, Johannes Berg wrote:
> Didn't really review all of this yet, but
> 
>   	switch (state->split_start) {
>>   	case 0:
>> +		if (nla_put(msg, NL80211_ATTR_MAC, ETH_ALEN,
>> +			    rdev->wiphy.perm_addr))
>> +			goto nla_put_failure;
> 
> We generally can't add anything to any of the cases before the split was
> allowed, for compatibility with old userspace.

Can you educate me here? Is it because the non-split dump messages would 
grow too large?  But then non-dumps aren't split, so I still don't get 
how anyone can be broken by this (that isn't already broken in the first 
place).

Anyhow, What is the cut off point?  It didn't seem worthwhile to send 
yet-another-message for ~60 bytes of data, but if you want me to add it 
as a separate message, no problem.

Regards,
-Denis
