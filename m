Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 689FF10759
	for <lists+linux-wireless@lfdr.de>; Wed,  1 May 2019 13:07:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726133AbfEALGw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 1 May 2019 07:06:52 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:44720 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726052AbfEALGv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 1 May 2019 07:06:51 -0400
Received: by mail-lj1-f196.google.com with SMTP id c6so8714124lji.11;
        Wed, 01 May 2019 04:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=eIL682wGpUi32jDyHiv4YP0KGP3S+mHvqENB0UUgtyM=;
        b=oMhj4EduRZ42J8NPXviNtYfkZPKJ7YbpNc8WdBcU+riYH67W3DL8sqJ49n2S+/EmAQ
         13xl3uHh+fvqWwa2DdGBgOJkueJbtzz2oP8uHPafT/zQz6OYx2Zue0zIj7kbVJb5cOOU
         wYFiR566eev3SMFLDVZxA7s+VUZb+K/dTv7DfdN97ZT4IgWxwjgdJW70f+da00Q5uzSH
         12tBV1OpOiRcgIr5vKBoILgKSJy0Ndf/SisB79kjzGV9Fco+7ehK4StyWr0YpDhrLRWj
         n6UtVgSExg2R17BXUTrA6NH6TpuiBUUoSVbSy8DMiShHJ+aaOlyEAWn9ta2CVzbn9xx9
         lNOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=eIL682wGpUi32jDyHiv4YP0KGP3S+mHvqENB0UUgtyM=;
        b=RhV0Ljylo5B/L/3ULeQMeW1g3xgje7BxcUO5TPMmECSQMYFRy5Z+BAZSEI0GnGdvIi
         PO0nLTfv/DMw/3sLxfAHKRL8vbzX75FsezBA9nv3KwIgpsnm0ghpgEOOA1ymM8Xarfjh
         4dxaePPK1hdSO6HW0T9WtGb/XJDz7BjNM9L/cbjXBhlTd6/UYauAl1hlpd+USwvB7A6v
         xJpzDZQjzYhfq6excQ0qoHuqYuCrQyl66D7IqA8/yroaVEiLheee1xzFYC0mB6r8iESW
         yuOdKA13mc5brlkes6xrdt4W9YslaMMyxXJAcGnbOTTJVmvBfhXmbNDzqG1OvHYQx+KE
         hHpQ==
X-Gm-Message-State: APjAAAUrmIN6dz/M6LymMTu/9fKYPR30m11Qj/+59ez/0RZ8L+gMCX0s
        hqoTJsT3vmv/cSPR1tO0eXBGrYu2
X-Google-Smtp-Source: APXvYqzBeP2zYtry4IBI2Iz6vl5syRChsbEVdT3BRJq343Eu3hIZE5Gky/xF+r2LMbI/e3Q+6Kux3w==
X-Received: by 2002:a2e:2b16:: with SMTP id q22mr39437864lje.20.1556708809355;
        Wed, 01 May 2019 04:06:49 -0700 (PDT)
Received: from [192.168.1.244] (81-233-89-221-no75.tbcn.telia.com. [81.233.89.221])
        by smtp.gmail.com with ESMTPSA id z3sm320851ljg.78.2019.05.01.04.06.48
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 May 2019 04:06:48 -0700 (PDT)
Subject: Re: [PATCH] mac80211: fix possible deadlock in TX path
To:     =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@redhat.com>,
        johannes@sipsolutions.net, davem@davemloft.net,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190427204155.14211-1-erik.stromdahl@gmail.com>
 <87k1fcnd9y.fsf@toke.dk>
From:   Erik Stromdahl <erik.stromdahl@gmail.com>
Message-ID: <656f3938-ef82-c1ce-753c-cb6b9d3c424b@gmail.com>
Date:   Wed, 1 May 2019 13:06:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <87k1fcnd9y.fsf@toke.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org



On 4/30/19 9:49 AM, Toke Høiland-Jørgensen wrote:
> Erik Stromdahl <erik.stromdahl@gmail.com> writes:
> 
>> This patch fixes a possible deadlock when updating the TX statistics
>> (when calling into ieee80211_tx_stats()) from ieee80211_tx_dequeue().
> 
> So is this the fix for the issue with TX scheduling you reported
> earlier? :)
> 

Actually not. I thought so initially, but then, after a few more test runs,
I was able to run into the issue again.

But it does seem to fix the other issue with the RCU stall since I haven't
seen it with this patch applied (could be just a coincidence though).

--
Erik
