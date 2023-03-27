Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C572F6CA1C8
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Mar 2023 12:55:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231820AbjC0KzL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 27 Mar 2023 06:55:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbjC0KzJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 27 Mar 2023 06:55:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1180C110
        for <linux-wireless@vger.kernel.org>; Mon, 27 Mar 2023 03:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679914461;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=V76E22qmDXGckGrYi+vY+1A5+q7YCqzLqCYN/0yshb4=;
        b=bkD7+anT71PA7xa1xlKbPq7dr/PoceUjkO4mmScNDxoGUymXpWt1/t7jUdFifWAZfKFdJP
        BnRfRFruncfb4NfI/871oNnlPp/QuViE4dt/Mk23/7kP+WOrhTh+Tu2FxyRf0u4JxG8Lov
        Xz454JoD7CT6HMlZ/pCjj2QVJTD2ZaA=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-270-g1JLiFsbMq-DA9IYUdxEWw-1; Mon, 27 Mar 2023 06:54:19 -0400
X-MC-Unique: g1JLiFsbMq-DA9IYUdxEWw-1
Received: by mail-ed1-f69.google.com with SMTP id c11-20020a509f8b000000b00501e2facf47so12080500edf.16
        for <linux-wireless@vger.kernel.org>; Mon, 27 Mar 2023 03:54:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679914458;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V76E22qmDXGckGrYi+vY+1A5+q7YCqzLqCYN/0yshb4=;
        b=IED2zZY5JGTBL/zMw7YbucVLM+/BkiXrYdgThp82haCR8rjPHXuqmgElEJ6vDFMNqo
         ijU9uLYTm0fq8E58WKL+e5LHvySMu9fTBryPQH3Gic7ZT597MTxxQ5VwJbgiKBNIMYWt
         ie7Av4z80i6yZsG/CePVbHv09MzS7pTJ4kx/sVTWhjZ9KNI9jTDUnJwHvzeaRfuCyRsP
         NyVPux20YpmXBCDRKaIEUh1taAI53CbYfbUobuQFCifXQljm6fMXv3SaS6DciK0J7uPk
         dcKzHLbqef7MEjPDLogKLfJApT2BBKZ/ToeaIbnnuVdPXpKMDXrOOImCkJRWVE5QXh9m
         FKrg==
X-Gm-Message-State: AAQBX9cQNr4gQDET/f6jtJppYflsnuCWaQqDttybJFAB4o+IvP6qioFd
        yYSn3JgERVSYN7rFFP/hUc26IlkfNka/zSYD9wR0RY4m+sR+Pf7O4IrreYOwL5Dvf3+INpQN14F
        Gz+eIQ+B+3cGvfsaVJ0osT2lcsx0=
X-Received: by 2002:a17:906:3a83:b0:932:9502:4fd1 with SMTP id y3-20020a1709063a8300b0093295024fd1mr11534131ejd.43.1679914458705;
        Mon, 27 Mar 2023 03:54:18 -0700 (PDT)
X-Google-Smtp-Source: AKy350aVcHT4zO4DMH0LXK+MbRdTA/JysO4mCuc5uXKhBfC82+mTOrJDcI4ZgcbTtDhWGePoyt9AlA==
X-Received: by 2002:a17:906:3a83:b0:932:9502:4fd1 with SMTP id y3-20020a1709063a8300b0093295024fd1mr11534120ejd.43.1679914458465;
        Mon, 27 Mar 2023 03:54:18 -0700 (PDT)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id m2-20020a50d7c2000000b00501fc87352fsm7768528edj.13.2023.03.27.03.54.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Mar 2023 03:54:17 -0700 (PDT)
Message-ID: <1c71e611-42d0-daf6-3ef2-c404561b42f7@redhat.com>
Date:   Mon, 27 Mar 2023 12:54:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: iwlwifi "memcpy: detected field-spanning write" kernel oops
Content-Language: en-US
To:     Johannes Berg <johannes@sipsolutions.net>,
        Gregory Greenman <gregory.greenman@intel.com>,
        Benjamin Berg <benjamin.berg@intel.com>
Cc:     Kalle Valo <kvalo@kernel.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>
References: <68760035-7f75-1b23-e355-bfb758a87d83@redhat.com>
 <569b7058d6a9807a98777bf7a0cfc4b3846477d8.camel@sipsolutions.net>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <569b7058d6a9807a98777bf7a0cfc4b3846477d8.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Johannes,

On 3/27/23 11:50, Johannes Berg wrote:
> On Mon, 2023-03-27 at 11:12 +0200, Hans de Goede wrote:
>> Hi All,
>>
>> I have noticed the following iwlwifi oops with kernel 6.2.0 and newer (1):
> 
> Yes, this was noted before and Kees was working on a fix:
> 
> https://lore.kernel.org/linux-wireless/20230218191056.never.374-kees@kernel.org/
> 
> but the discussion was still ongoing and I don't think he posted a final
> version yet.

Thanks for the reply.

Reading the thread I see that this seems to be an actual bug and there are 
some ideas how to fix this, but it needs someone to actually test the fixes.

I hit the reported oops whenever one of my laptops at home connects
to my home router access-point.

So I can reproduce this at will; and given that I hit the oops I assume
that my home network also actually uses the keys setup by the given path,
so I should also be able to test that a fix does not break the wifi
connection by misconfiguring the keys.

So I'm hereby volunteering to test a fix on my setup.

Regards,

Hans

