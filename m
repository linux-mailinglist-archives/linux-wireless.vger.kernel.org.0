Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C47EB006A
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Sep 2019 17:44:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728335AbfIKPo0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 11 Sep 2019 11:44:26 -0400
Received: from mail-ot1-f45.google.com ([209.85.210.45]:40073 "EHLO
        mail-ot1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728266AbfIKPo0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 11 Sep 2019 11:44:26 -0400
Received: by mail-ot1-f45.google.com with SMTP id y39so23014476ota.7
        for <linux-wireless@vger.kernel.org>; Wed, 11 Sep 2019 08:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=RZx0pS2BjnwE7dAC+J17VEN2CuOg11XJipIEtx5a2sA=;
        b=IUDGKM4KLcZatG+a8/Ubx2AzFzr0EOxnxcy1vml0TiojHkQDm7kEF9ksRX70x+ggB3
         zKGdp5fjozkWhki65zQLQlIiXN+0wwknTtTwgtsu0gLyXjw+uZS79vB0M4tpaSV4XFO6
         uOAzLD/fBv+XBvCM5fDEWUJpPLmbxMd4gcUPuN/x/SlUpNdRm71e1odSa0fnb8+kWWO0
         iOJnzoxkzAAckuu+eSVDUToPWVP9dZm8+BZZ2zViIjugRyMMtKFep8nE+fZZsL7vxL4M
         5P5lw1TuLSwjC/1Q7JQyqTi3PRGnmgYWT27pfZQwvQfPqZlPOJJMxqD3bA5cgwnzUrMv
         DHrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RZx0pS2BjnwE7dAC+J17VEN2CuOg11XJipIEtx5a2sA=;
        b=VCzEp14Aw8XUemIkcFsVaUP7WDcj561J26w5e9c6lVG0FfLjE78eOnHUyIFAUmuS2d
         rXEvdMec7BXilzH6CW50PPvfwhmACTPNP96CH1CGDA6tWvmxp4zuT07CRxrSDIl9EfFT
         0edtf0VVKyCCrgwVf8TIiDifRdgWzyZNU+S25yQbnXoqyJwx7SY3g2ATUSG/clLp8axS
         2UncwdUiyCyXC7OdFk9uPdxt4X9rgz5oUFfGtm2rOH1kjUqo7E3+ymzYKWSIJhtK/4FU
         SourcVmhC59QzvV1LO80D9UEdkpGM8gs3bTXwPj/YuwDdEhNfb66QsUSPfaWca0QvTS+
         1hsg==
X-Gm-Message-State: APjAAAXhrGnYDAL6tEhoC3uafYbVfn/uz46/nh0J36RNBt6mr6kJ3Jy3
        dHkz5k5HXwD5jTzjjPLuU/MOmOTV
X-Google-Smtp-Source: APXvYqzmCjFpiEA6MyW8pLuTjDIwZcPzAxAO8jjdiNXobkMj3x9Otqx1+SOgpa+D1toJRfKVeTBrlw==
X-Received: by 2002:a9d:6a8a:: with SMTP id l10mr27354172otq.97.1568216663671;
        Wed, 11 Sep 2019 08:44:23 -0700 (PDT)
Received: from [192.168.1.249] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id t82sm6817441oie.12.2019.09.11.08.44.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Sep 2019 08:44:22 -0700 (PDT)
Subject: Re: [RFCv3 2/3] nl80211: Support >4096 byte NEW_WIPHY event nlmsg
To:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org
References: <20190906154303.9303-1-denkenz@gmail.com>
 <20190906154303.9303-2-denkenz@gmail.com>
 <4397b67b63d1b1a332afa9010e7f48abd54b49b2.camel@sipsolutions.net>
 <5bd58103-bdb7-b72c-0b64-76c8573ca380@gmail.com>
 <1eac4f853b835fef85cdf33d971382b2f6e7c5a9.camel@sipsolutions.net>
From:   Denis Kenzior <denkenz@gmail.com>
Message-ID: <8b22b64e-5efc-beac-6581-778e47625c89@gmail.com>
Date:   Wed, 11 Sep 2019 08:51:01 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1eac4f853b835fef85cdf33d971382b2f6e7c5a9.camel@sipsolutions.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Johannes,

On 9/11/19 10:28 AM, Johannes Berg wrote:
> On Wed, 2019-09-11 at 07:41 -0500, Denis Kenzior wrote:
>>
>> For my dual band cards the channel dump all fits into a ~1k attribute if
>> I recall correctly.  So there may not really be a need for this.  Or at
>> the very least we could keep things simple(r) and only split at the band
>> level, not at the individual channel level.
> 
> Yeah, that does seem reasonable, especially if we're moving to bigger
> messages anyway. If we do add something huge to each channel, we can
> recover that code I suppose.

So do you want me to drop the channel splitting logic and only allow 
this for bands?  Or just keep this since it is already done?

>> The current logic uses last_channel_pos for some of the trickery in
>> addition to last_good_pos.  So nla_put_failure would have to be made
>> aware of that.  Perhaps we can store last_good_pos in the stack, but the
>> split mechanism only allows the splits to be done at certain points...
> 
> Hmm, not sure I understand. last_channel_pos and last_good_pos are
> basically equivalent, no? In fact, I'm not sure why you need
> last_channel_pos vs. just using last_good_pos instead? Maybe I'm missing
> something.

Sort of.  The way I did it, last_channel_pos keeps track of whether any 
channel info was added or not.  So if NULL, we simply backtrack to 
last_good_pos in nla_put_failure. You can probably use last_good_pos for 
everything and an extra variable for the channel info tracking.

> 
> To me, conceptually, the "state->band_start" and "state->chan_start" is
> basically a sub-state of "state->split", so this is underneath state-
>> split == 3 (I think?), you basically get 3.0.0, 3.0.1, 3.0.2, ...,
> 3.1.0, 3.1.1 ... for the state? Which you have to unwind in terms of
> message formatting, but the last_good_pos should be sufficient?

Right.  And as I mentioned above, this could be done, but you probably 
need another state variable..

> 
> IOW, the only difference I see between the normal split states 1, 2, ...
> and the band/channel split states 3.0.0, 3.0.1, ... is the fact that we
> have to also fix up the nested attributes after we trim to last_good_pos
> on failures. Where am I wrong?
> 

Didn't say that you were ;)

>> Right now only the channel dump uses this (and I'm still not fully
>> convinced we should go to all the trouble), so one argument would be not
>> to introduce something this generic until another user of it manifests
>> itself?
> 
> I was thinking it'd actually be less complex, but I guess I have to try
> to write it to see for myself.

To be clear, I think it is a good approach and can be made to work.  My 
main hesitation is whether doing it now is worth it given the discussion 
at the very top.  But I can see what I can come up with if you want.

Regards,
-Denis
