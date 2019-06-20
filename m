Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA6584DAE2
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Jun 2019 22:05:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726338AbfFTUF2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 20 Jun 2019 16:05:28 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:34490 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725903AbfFTUF1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 20 Jun 2019 16:05:27 -0400
Received: by mail-io1-f65.google.com with SMTP id k8so2303813iot.1
        for <linux-wireless@vger.kernel.org>; Thu, 20 Jun 2019 13:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=oV5n+hG/iDk/9OF+6N7nMWGif15jpvZOqqVcrMdGLdQ=;
        b=WlLli7rhK352YrkdYhTWCUxS9keTIV34ykdCozEbWM+IlSiZzPXmB52PmCJffTHs5R
         sU+s9swPh+Y+B4sPRk6AkBpg9n68GAd3WxQWCZRQMYBatKkdEWxu0+joM8Ieqqp8rZBW
         q3bztjPJGUigsPtRKZG952iOeDOIU6pyxpekvHxwBrKrJk5BH6UZGLFJrgM7U/TBD1vD
         W1+batFYwwR2Nw3DjzySYBSSxBC2/H2/EZKzVmUKNKlSANr+UuaCUlFuLSKdIVIVs6wd
         w6gPm3wuO9mxhc314gd0WnYsPOxz3r1p9mVx50QcSA0eEyBupvNMMHgkJFQjnoOYTrGh
         CBFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oV5n+hG/iDk/9OF+6N7nMWGif15jpvZOqqVcrMdGLdQ=;
        b=T20Lws/10t9xpQW9AQTFVkazkWIjzcbDEFz8/QBzcSc0sSjcuz6woB+bFMOQZOKBLa
         rqaEOph1ev3yILACGJjbPhkQZfBye390ZYG5QuGZTwIjmVSmCrcwc1hR6SDjXYHy9Rf7
         BPk2kjyygmcYM55OlkNOcopEMTb+tHZMCWFdDwhbRsdVTtNV4z7ZlmOBekUtkUGmt+Ic
         e4dO/Cw9/1SYhgijSCeQpPiv2MXKmoiYysUZE6yIV6GSsSi/Y/DL3tpWeNmPhvxnPaeU
         z/I0G093R8rqoghiGN+QFmHNMe7/pvg/g7bel093vU93z//52xf5Wp855oJiQvSYmA2M
         5GXg==
X-Gm-Message-State: APjAAAVhlbSS5S/lsqueTAbzw7tbEv++PdN+WmGGWpoVQ9ibJt8qMLtz
        9vy0XCbRJdwEVcxH3tk9fwXBIsGy
X-Google-Smtp-Source: APXvYqyxpzvFAdD9OeI8UOjvAsbx2radk1DWiIu0wUpcAZ+a2VJjsEJ65xcIwaSHGhtE9snqVIp3jg==
X-Received: by 2002:a5d:8ccc:: with SMTP id k12mr9669813iot.141.1561061126855;
        Thu, 20 Jun 2019 13:05:26 -0700 (PDT)
Received: from new-host-2.home ([2605:a601:808:1001:37ba:4f0a:192f:f945])
        by smtp.googlemail.com with ESMTPSA id m4sm560977iok.68.2019.06.20.13.05.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Jun 2019 13:05:26 -0700 (PDT)
Subject: Re: [PATCH 3/3] nl80211: Include wiphy address setup in NEW_WIPHY
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org
References: <20190619223606.4575-1-denkenz@gmail.com>
 <20190619223606.4575-3-denkenz@gmail.com>
 <ec1ca95a5789f9001e89e603633b20316d687721.camel@sipsolutions.net>
 <7da9b924-78c7-ba72-fecc-a11700a34ff4@gmail.com>
 <44923833f1068e360b1f9534a9bbd37be41e4833.camel@sipsolutions.net>
From:   Denis Kenzior <denkenz@gmail.com>
Message-ID: <427f488f-98f5-f888-f079-e2bbbb6eedf3@gmail.com>
Date:   Thu, 20 Jun 2019 15:05:25 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <44923833f1068e360b1f9534a9bbd37be41e4833.camel@sipsolutions.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Johannes,

On 06/20/2019 02:17 PM, Johannes Berg wrote:
> Hi Denis,
> 
>>> We generally can't add anything to any of the cases before the split was
>>> allowed, for compatibility with old userspace.
>>
>> Can you educate me here? Is it because the non-split dump messages would
>> grow too large?
> 
> No. Those messages aren't really relevant, userspace will need to do a
> larger buffer for it.
> 
> The problem is that old userspace (like really old) didn't split even
> dumps. Eventually, we had so much information here that the default dump
> message size is exceeded, and we simply couldn't dump that particular
> wiphy anymore.
> 
> We solved this by splitting the wiphy information into multiple
> messages, but that needed new userspace, so when userspace doesn't
> request split dumps, we fall through all the way to "case 8" and then
> stop - old userspace cannot care about new information anyway.
> 
> The reason it was split into cases 0-8 that are combined in non-split
> dumps is that it was safer that way - there were certain configurations
> where even the original data would go above the message size limit.

Ugh.  So, if I understand this correctly, NEW_WIPHY events that are 
generated when a new wiphy is plugged would only send the old 'legacy' 
info and any info we add in cases 9+ would be 'lost' and the application 
is forced into re-dumping the phy.  This is pretty much counter to what 
we want.

If you want to keep your sanity in userspace, you need proper 'object 
appeared' / 'object disappeared' events from the kernel.  And those 
events should have all or nearly all info to not bother the kernel going 
forward.  It sounds like nl80211 API has run into the extend-ability 
wall, no?

Any suggestions on how to resolve this?  Should NEW_WIPHY events also do 
the whole split_dump semantic and generate 15+ or whatever messages?

Regards,
-Denis
