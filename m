Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 379796CAE2
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jul 2019 10:24:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726485AbfGRIYa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 18 Jul 2019 04:24:30 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54407 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726000AbfGRIY3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 18 Jul 2019 04:24:29 -0400
Received: by mail-wm1-f68.google.com with SMTP id p74so24625147wme.4
        for <linux-wireless@vger.kernel.org>; Thu, 18 Jul 2019 01:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=wjHtC+TlIWovKf+RU690uNWUF5V05S0kXS1oQp90ZOk=;
        b=XKBJQIMFXMwmg5VJRNQBMdwtusgd5YOpeOeup9u5mHk1LQhotjVRlVXqRExhSUX1aH
         YsBHq6fFH5E5VsVtIX4np7UfYk8DpVew2+0AsySXEz2NqWQAMKWqABWVo83cF/BXJ7Pf
         BmvqYOndEoJDErteZQGqe9mkFbo70twSR+igQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wjHtC+TlIWovKf+RU690uNWUF5V05S0kXS1oQp90ZOk=;
        b=m9fzVphZ4/OJbsptozOavyJEXRbDj+HSU5XOAKMRTWQ1Z3An7ECciv1awMYUNhfpQ/
         ZyzIVuBGO2jhMpmldhrtX9ZRur9yuh87Lb3tepX3RoiVfcY1vOoEOHGtSZAcOaydjpBQ
         RyvMCJPYUomaAdyYrPGEp3VaS7hMAoIZQjzFPUGOrDEL8T3+5UPYXxSkv37q+aPAePTP
         mcJSqr80Bef48qlzPw0V7bHqzHVz0NGRjr+RunHYZscc9PEzgxN+hmaoPrQkQNkhxfq/
         qhTj+sfaROMmmEs0nsqvrCtpM9GYgwkm1TTq3C6PSFNV084b7GyWUFtdLFY7IIbQGB3B
         8eHw==
X-Gm-Message-State: APjAAAXA94o1DVC2UKrZ3izuCM0oMZ6DD0XmzmLe25AglAvQvzxkvhE/
        ufVr5XBdZxLBxgPAzO4oPwB5mHXZEsNGPg4AkSFIcn34nAeK7AXNLjAzhOS21bYNsGeCGJblmwT
        A7gTV5XsQEl3N85D5OLxs0Gu24Q9gHzRBUiLugysh4Yl3rwtHRFPt4r8FfTKztmWDGK9iXB2aGW
        HP3qw5KtLLHlm78g==
X-Google-Smtp-Source: APXvYqz/M4q2H+rlW4CjNSv/mdAnyhYTIgQEYmibAQgUdt6CSWoWYlXBwfjtnHJq9Qabc30gp7kMQg==
X-Received: by 2002:a05:600c:2189:: with SMTP id e9mr38885237wme.56.1563438267068;
        Thu, 18 Jul 2019 01:24:27 -0700 (PDT)
Received: from [10.230.33.15] ([192.19.248.250])
        by smtp.gmail.com with ESMTPSA id y6sm30478690wmd.16.2019.07.18.01.24.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Jul 2019 01:24:26 -0700 (PDT)
Subject: Re: [PATCH v3 2/3] nl80211: Limit certain commands to interface owner
To:     Denis Kenzior <denkenz@gmail.com>,
        Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org
References: <20190701153317.27170-1-denkenz@gmail.com>
 <20190701153317.27170-2-denkenz@gmail.com>
From:   Arend Van Spriel <arend.vanspriel@broadcom.com>
Message-ID: <d75d6f90-1691-57fa-ddb2-ece84f5d262f@broadcom.com>
Date:   Thu, 18 Jul 2019 10:24:24 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190701153317.27170-2-denkenz@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 7/1/2019 5:33 PM, Denis Kenzior wrote:
> If the wdev object has been created (via NEW_INTERFACE) with
> SOCKET_OWNER attribute set, then limit certain commands only to the
> process that created that wdev.
> 
> This can be used to make sure no other process on the system interferes
> by sending unwanted scans, action frames or any other funny business.
> 
> This patch introduces a new internal flag, and checks that flag in the
> pre_doit hook.
> 
> Signed-off-by: Denis Kenzior <denkenz@gmail.com>
> ---
>   net/wireless/nl80211.c | 80 ++++++++++++++++++++++++++++++++----------
>   1 file changed, 61 insertions(+), 19 deletions(-)
> 
> Changes in v3:
>    - Fix minor locking mistake reported by kernel test robot
> 
> Changes in v2:
>    - None
> 
> diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
> index ff760ba83449..ebf5eab1f9b2 100644
> --- a/net/wireless/nl80211.c
> +++ b/net/wireless/nl80211.c

[snip]

>   
> -	return 0;
> +	ret = 0;

I suggest to keep the return 0 here for success path and only do the 
below for failure case (and obviously dropping '&& ret < 0'). Maybe 
rename label 'done' to 'fail' as well.

> +done:
> +	if (rtnl && ret < 0)
> +		rtnl_unlock();
> +
> +	return ret;
>   }

Regards,
Arend
