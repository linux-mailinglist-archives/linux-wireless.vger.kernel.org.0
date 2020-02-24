Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5930916B097
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Feb 2020 20:51:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727187AbgBXTvX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 24 Feb 2020 14:51:23 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:39578 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726628AbgBXTvX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 24 Feb 2020 14:51:23 -0500
Received: by mail-ot1-f66.google.com with SMTP id 77so9863263oty.6
        for <linux-wireless@vger.kernel.org>; Mon, 24 Feb 2020 11:51:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=QJHDxxlUpqirmOL70o4Wg9WtH5pz7rQxKHRJUXBKMO4=;
        b=J5lCyIbwl4I7vJOcWkZC3MsdtdJaGzWVFR+1B3iggBC7h/OFJbxBMdY5Ztom1mdFB6
         NgybmUb3tsnIelNvRkgqZ0f7eBH4DfzNNpcpO1u+6I2orutZWfM6G1jkxmFqwmzf9rup
         4+4cM5nL85sENvRNaamsOKz3+n+VZZqt52ioDuyTZPbDLJXTEGpRtW9X8R/N0NP6v7tM
         odo1Th25wFiuqh9g9HmpcrwHVKVkHGLE77I9VT+t4GFxRaF3Gku7yRLZ2tEmouaOhxVZ
         c4Ouob76UC0rnxzz4WT/fMfHJdz/7ncJ2M6z3H71cAyyn5mlzYc/B9bwgrm9u7CUFXRu
         ZOZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QJHDxxlUpqirmOL70o4Wg9WtH5pz7rQxKHRJUXBKMO4=;
        b=iq/FxSUaXo2RlBS5hbv/J+iM7xyzLWnRZ4MBeGL/7zcbH5otYZCGxtjqWQcFbu5H6l
         4BBYPrPTOstNtAiFuFUVfeWNV+zA8vOYrttaOKeL6RVoTi4UppAXAhW83ciZ1FUDPOf9
         lLYzaW1JrIFh9EHE2ouollqhQoA955tlm2DSHYntrZvvt6F8mXEM8VX89Z7vKhc+rz71
         L9uIGwy05OYnRheXVwmkcOHSAhryrXlztMnOO6vLj2tTVIFtbsReQqfNZqvAiR7mfCiz
         /Kq0svNvtGdLtdZVh+i/Ii1vGs2oQEH63fPl6zON3aTn2Ed4wecO8hmfscozehtSrv6p
         Jhvg==
X-Gm-Message-State: APjAAAWmsC2gGX9e+WgFvxVWsdTOb/NS+N0D7W3kkx6tg66uNNiQ57ec
        9q2dne5gI3X5sOvvT4DQ6kFompRT
X-Google-Smtp-Source: APXvYqw+fv26pvjI4FFBlLVvAPc1srQqXkSlbl9oYMx2IPyGEcDVYJLrZSL+T6ktqC3B7FF59humwA==
X-Received: by 2002:a9d:7305:: with SMTP id e5mr39641299otk.64.1582573882853;
        Mon, 24 Feb 2020 11:51:22 -0800 (PST)
Received: from [192.168.1.249] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id c7sm4836307otn.81.2020.02.24.11.51.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Feb 2020 11:51:21 -0800 (PST)
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
 <048b81db-8e92-7fe0-1f5c-3b6f9ea1a1f1@gmail.com>
 <366b1599374240ef194bf7eb6e1e47a8b675f474.camel@sipsolutions.net>
From:   Denis Kenzior <denkenz@gmail.com>
Message-ID: <978dab89-343a-3fc9-dbdb-7acf87d735ca@gmail.com>
Date:   Mon, 24 Feb 2020 13:35:51 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <366b1599374240ef194bf7eb6e1e47a8b675f474.camel@sipsolutions.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Johannes,

>> So from a holistic point of view, taking kernel + userspace into
>> account, what is wrong with letting control port transport preauth
>> frames if that saves a bunch of resources (and possibly wakeups if the
>> bpf is setup badly) on the system?
> 
> If you paint it that way, it doesn't seem like there's anything wrong
> with it, does it?
> 
> But not sure that's the right color - you could apply that precise same
> argument to, say, transporting DHCP packets over the same path? I think
> you'd agree that doesn't make it right?

But I'm not, and I don't think the argument for DHCP is anywhere as 
strong.  DHCP is typically handled outside of the wifi management daemon 
(though it can be done inside) and is usually something that is very 
much separate from WiFi details regardless of where it lives.

> 
> Just because preauth is a wifi related protocol doesn't mean we should
> treat it in a wifi control path.

But it seems like the benefits outweigh the drawbacks?  At least we have 
been super happy with how control port works for us.  If you take the 
pre-auth path away, I'm really not sure there's any point in (at least 
for us) keeping support for the control port path.

> 
>> Also, the question is what changed your mind?  I asked you specifically
>> if preauth should be included in the control port API and you thought it
>> was a good idea at the time?
> 
> I don't really remember that, but perhaps? Mostly I guess the discussion
> on the hostap list now, I suppose.

I'm not subscribed there.  A synopsis of the discussion (or 
linux-wireless CC) would have been nice.

Regards,
-Denis
