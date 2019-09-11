Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D637AAFE6D
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Sep 2019 16:13:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728189AbfIKONZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 11 Sep 2019 10:13:25 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:44789 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728062AbfIKONZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 11 Sep 2019 10:13:25 -0400
Received: by mail-ot1-f68.google.com with SMTP id 21so22648087otj.11
        for <linux-wireless@vger.kernel.org>; Wed, 11 Sep 2019 07:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=bAdIpTZ8oIohVBz3HfgsMq4OBMpmfT9f9i5Ck+jMakE=;
        b=i6Dk9lv9TYY/3ihFvN51ORXPxSDhRbn/apk1ZWWUAqXWzlOB5eU8O9ImbGRe6zpA8a
         2aRH0kPzDzOtpF1rwpOQyFFPAvp+50JeRmq6rxLSMM7GTelPxXVHV5TqyxQ6Fw5cYC7r
         lJhlkkyM+qoMuJGhl39LeAZOtNqKZqY2oW3RaApLzGPI8fF4F97HA/zwKFzW03QKHhLb
         qd2blPbeHEO01u/+/Eh2xPSwpzyUF7TOkGfTydsaDljDgVSBYXaoJmndMB0ZPz7rYucO
         S0EDJC3YJr0bHjN+ZS0KesyrfI3kBDAi/g3kWlFkxQvkJt2FZlnI1tg/geFNIw0VrpyV
         /41g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bAdIpTZ8oIohVBz3HfgsMq4OBMpmfT9f9i5Ck+jMakE=;
        b=neqEX/qdBeDbe04fjzxKWxxAONLzFMbPJw8n7YfdOBkgfEI37zem4iw1RLcocxW7Jf
         T9zrvqGErmIL7hYbhwq6+eanLSmhSMo0O12RdwvVb8360WzXD/QJit+I7GIUoCJhZsPx
         uqPfUhYbLdiz2tuZr/xgKdHbosjL32NtKK+2/BHB+uIfYGx5DCpGiJKpN0sLt1mS2hIu
         0cf6hD0py2scF8s8xdq2gotZ7TG19S0Ar4FEDbr5psERdrbeve1KE5zza4SdXDui7B2L
         eD8VdnxBs85E6magPQdMZou/gV0RF4bRxD9HFBDJ9P/nVdV++Sbtfd2Xf1nB4JOAZ0go
         tyvA==
X-Gm-Message-State: APjAAAWUNidoUQhznj0auhP4XI07HGBa5QSfRGnIj9WzOspSbNYeUySy
        UHjJojY4Nfrm0QdRE5TBZvG4pxnB
X-Google-Smtp-Source: APXvYqwdNKJLzqPpfAXOMqOp+oIbN+l6NdUv4QEpJ/1+P2GzNt1zOakPqxQ+4mrfVM1LZQFpU7I1TQ==
X-Received: by 2002:a9d:6742:: with SMTP id w2mr31070902otm.225.1568211203265;
        Wed, 11 Sep 2019 07:13:23 -0700 (PDT)
Received: from [192.168.1.249] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 36sm8081792ott.66.2019.09.11.07.13.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Sep 2019 07:13:22 -0700 (PDT)
Subject: Re: [RFCv3 3/3] nl80211: Send large new_wiphy events
To:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org
References: <20190906154303.9303-1-denkenz@gmail.com>
 <20190906154303.9303-3-denkenz@gmail.com>
 <127c19b1855302a467a1bdbf2f25f625a0254d9e.camel@sipsolutions.net>
From:   Denis Kenzior <denkenz@gmail.com>
Message-ID: <f48bdad3-f9f8-20b7-b6ff-6248368a7ae1@gmail.com>
Date:   Wed, 11 Sep 2019 07:20:01 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <127c19b1855302a467a1bdbf2f25f625a0254d9e.camel@sipsolutions.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

hi Johannes,

On 9/11/19 4:47 AM, Johannes Berg wrote:
> On Fri, 2019-09-06 at 10:43 -0500, Denis Kenzior wrote:
>>
>> + *	There are no limits (outside of netlink protocol limits) on
>> + *	message sizes that can be sent over the "config2" multicast group. It
>> + *	is assumed that applications utilizing "config2" multicast group
>> + *	utilize buffers that are inherently large enough or can utilize
>> + *	MSG_PEEK/MSG_TRUNC in the netlink transport in order to allocate big
>> + *	enough buffers.
> 
> I'm not sure I see how the applications could do buffers that are
> "inherently" large enough, there's no practical message size limit, is
> there (32-bits for the size).

The kernel caps this to 32k right now if I read the code correctly.  But 
fair point.

> 
> I'd argue this should just say that applications should use large
> buffers and still use MSG_PEEK/handle MSG_TRUNC, but I can also edit it
> later.
> 
>> +	msg = nlmsg_new(alloc_size, GFP_KERNEL);
>> +	if (!msg)
>> +		goto legacy;
>> +
>> +	if (WARN_ON(nl80211_send_wiphy(rdev, cmd, msg, 0, 0, 0, &state) < 0)) {
>> +		nlmsg_free(msg);
>> +		goto legacy;
>> +	}
>> +
>> +	genlmsg_multicast_netns(&nl80211_fam, wiphy_net(&rdev->wiphy), msg, 0,
>> +				NL80211_MCGRP_CONFIG2, GFP_KERNEL);
>> +
>> +legacy:
> 
> nit: just use "else" instead of the goto?

I'm not sure I understand?  We want to send both messages here...

Regards,
-Denis
