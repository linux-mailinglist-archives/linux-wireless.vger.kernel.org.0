Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C99516B008
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Feb 2020 20:13:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727470AbgBXTMv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 24 Feb 2020 14:12:51 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:36940 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727393AbgBXTMs (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 24 Feb 2020 14:12:48 -0500
Received: by mail-ot1-f68.google.com with SMTP id b3so9753014otp.4
        for <linux-wireless@vger.kernel.org>; Mon, 24 Feb 2020 11:12:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=INJqEsdng3yWnhB/nbmHjB0zOhD8msYYqWSspAAo1nw=;
        b=F8PfG/B3XTnjo+TBBLbcaW91WnC4DRMysl8u41UjH1bJuxRUf5yI547TStsaUNpzVl
         Z9eSlsDYpOlpLEZXq3j+T6gAysgmR308qOzbaQL/VweI09P8IVpk/IiF96Zb6gXByNRe
         kTay/p4/uX3p+sM+1MJoBRDRAZ2ku1x0lB2BqbCD6TT10zURal93z7bKtp8CCrkgW1m6
         bGRPjow+6tg94UAX9WbWp0BO3YuCthqYf6Gb2Z9C6QGpRbNzE4kZ6CNkC2E3jEObdU0e
         TGuPQ/T7WH5rHMJRAD95XGrJnxz+R2ZPTADp/dGzjsL3ge2DmtUF33xZMoD/bGGz3vL4
         e+0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=INJqEsdng3yWnhB/nbmHjB0zOhD8msYYqWSspAAo1nw=;
        b=aAUgLGAxR569BB/FxTk2mytpsvnItyVhyjapmmNxvTlLlMo2FnH5oTieDaZmf4Rgt+
         VUPC09EB6nNipeHb/W1bfM5nh74s3J1N3ON9fPn3mAEOnwKoUrfYZdB83lIUKZdbnmNz
         d7yVjph6UmFMCqcM11D25zvPT37HbFb26MVyJ3XEKVV/UQep8cGbm0mFKk2NCA4XYDGs
         iEb7rW9xmMSzDGjlDP+c5tHMOZwmJm1LF8xSOJRjP81UJD133/vSdb5x6MoFAUVLxA8o
         peEL+xoW3zpk4QV8kf4Ed+WNgtVF/71fXbthxow76jqbj+HN+CSD10UALhkfqZiYV+HD
         wkVA==
X-Gm-Message-State: APjAAAVngZxP0YP7OhwAWvjN//jsWm1T3GQamsiR41Sh+crpK0OzjqNh
        iDJ5r2h6cmOXYze+zLvPtwsQFUlq
X-Google-Smtp-Source: APXvYqzjh3qD8OSoPbmw+w2HiJ7xtSaPhnsGspmkQvSryMZMWxftPcUxKYQFTG1HMD5gUnlW+sID2w==
X-Received: by 2002:a9d:6290:: with SMTP id x16mr39710578otk.343.1582571566043;
        Mon, 24 Feb 2020 11:12:46 -0800 (PST)
Received: from [192.168.1.249] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id t20sm4311984oij.19.2020.02.24.11.12.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Feb 2020 11:12:45 -0800 (PST)
Subject: Re: [PATCH 1/2] Revert "mac80211: support
 NL80211_EXT_FEATURE_CONTROL_PORT_OVER_NL80211_MAC_ADDRS"
To:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org
Cc:     Markus Theil <markus.theil@tu-ilmenau.de>
References: <20200224101910.b87da63a3cd6.Ic94bc51a370c4aa7d19fbca9b96d90ab703257dc@changeid>
 <c9fba32a-6959-a93a-3119-23915053538c@gmail.com>
 <53190ece697ab7d9e83fdd667eaf9e05a4418193.camel@sipsolutions.net>
 <6e723a78-db68-8ffb-986a-4a3961107f72@gmail.com>
 <1a56c641eaa03c99dc9a90208902d8bb1ca1b0aa.camel@sipsolutions.net>
From:   Denis Kenzior <denkenz@gmail.com>
Message-ID: <048b81db-8e92-7fe0-1f5c-3b6f9ea1a1f1@gmail.com>
Date:   Mon, 24 Feb 2020 12:57:14 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1a56c641eaa03c99dc9a90208902d8bb1ca1b0aa.camel@sipsolutions.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Johannes,

> That's a question of how you define "special data packet processing"...
> You're defining it purely in terms of the mechanics of how you handle
> them, but that's not really the point.

Why isn't it the point?  These are the only data packets userspace 
management daemon(s) actually care about and has to setup raw sockets + 
bpf filters for every interface it manages.  The current control port 
makes all of that unnecessary.

So from a holistic point of view, taking kernel + userspace into 
account, what is wrong with letting control port transport preauth 
frames if that saves a bunch of resources (and possibly wakeups if the 
bpf is setup badly) on the system?

Also, the question is what changed your mind?  I asked you specifically 
if preauth should be included in the control port API and you thought it 
was a good idea at the time?

> 
> Preauth frames are _not_ special. They're entirely regular data packets
> as far as wifi is concerned.

Sure.  I already conceded this point if this wasn't clear earlier.

Regards,
-Denis
