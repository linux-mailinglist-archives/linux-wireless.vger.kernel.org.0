Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 64957B6138
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Sep 2019 12:16:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729083AbfIRKQK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 18 Sep 2019 06:16:10 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:48263 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729381AbfIRKQK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 18 Sep 2019 06:16:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1568801768;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=i67xqtI2vcG8BpM46PyzUmSV2sn6raIhV4PJs0Si30k=;
        b=GwUnpjM5y65onkyYg9rQ9Hn/kZLoae7mtCVtpDtkmhBM31wap8lxEVbxzT+h7Wm244MJGu
        uU/kBa07fd+sWpDA2S5MsvNlGh99Ggv44xL5+OChqASFUKgw6J3M3X0uUP5X56a55rU+OV
        SBKvgZHoTfcOtVNJLXEYabBhpQM4gg4=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-7-n4GsdzQxPWi-8c2X01XLwQ-1; Wed, 18 Sep 2019 06:16:07 -0400
Received: by mail-ed1-f70.google.com with SMTP id h12so1409177eda.19
        for <linux-wireless@vger.kernel.org>; Wed, 18 Sep 2019 03:16:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=i67xqtI2vcG8BpM46PyzUmSV2sn6raIhV4PJs0Si30k=;
        b=TVarDUQylxjk2/bZAVB+tdzeplG1s76P4WWcOngocwDuOz83UOeUbumJyOfVOdxRIO
         plPC3Xmjg32yL7hgfjEAWRYs54X48oDLoJy6rMRb975v01VBn+HEpW7h80cl8zLBBkvk
         e/ywQ93ghNQzZTF2eArp4LQsVddkroXSzTcAUdOsF+ghzk9qHjnIb5t5opSSUPSPc7WT
         3AL7OAoXZAUBWs4j0YC4urQxQF2rLVUP0+gJ3hiSZ6Wjtqtp1/YqDI9MuT85SvZLv7uJ
         01PasqXBrZzBWYSbYPXMjeb1WUTUjCHj7AmEYIg0KLxFQ2J91I4XrCpQdZuRRiLXBau6
         icBg==
X-Gm-Message-State: APjAAAVwqaBUt5nDwuH4bZlHfN7pXk1ZYuibnrYLpZ0+UQL38yOX2eiF
        sZrtaJBy6Yp7daNiNmCtHthjTJC5r1SyepAYjvPdXyMJ/UaPOMOoKK5gy43OnpeLDPD0KMyYr6D
        kk4NwEXRcDhCe6+pMSPs5YMi5wjo=
X-Received: by 2002:a17:906:4985:: with SMTP id p5mr8828348eju.106.1568801766170;
        Wed, 18 Sep 2019 03:16:06 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzGSKU6d3VLwTQCGsjgk9CbzqyDu0cGBKhPz/3eZvqfBWhgwugxFVt0FjMVU1iJA91GQxqDHQ==
X-Received: by 2002:a17:906:4985:: with SMTP id p5mr8828332eju.106.1568801765968;
        Wed, 18 Sep 2019 03:16:05 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk (borgediget.toke.dk. [85.204.121.218])
        by smtp.gmail.com with ESMTPSA id a20sm928820edt.95.2019.09.18.03.16.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2019 03:16:05 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id AE07518063E; Wed, 18 Sep 2019 12:16:04 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Yibo Zhao <yiboz@codeaurora.org>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-wireless-owner@vger.kernel.org
Subject: Re: [PATCH 3/4] mac80211: fix low throughput in push pull mode
In-Reply-To: <595c99a36c4f3e3eb131894d85c09746@codeaurora.org>
References: <1568639388-27291-1-git-send-email-yiboz@codeaurora.org> <1568639388-27291-3-git-send-email-yiboz@codeaurora.org> <6684ceecde399edeb31c594f889a403440c78142.camel@sipsolutions.net> <8e4cd872d082c6bce598c87411a2125f@codeaurora.org> <87lfumiq3w.fsf@toke.dk> <595c99a36c4f3e3eb131894d85c09746@codeaurora.org>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Wed, 18 Sep 2019 12:16:04 +0200
Message-ID: <871rwdj4ez.fsf@toke.dk>
MIME-Version: 1.0
X-MC-Unique: n4GsdzQxPWi-8c2X01XLwQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Yibo Zhao <yiboz@codeaurora.org> writes:

> On 2019-09-18 05:12, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> Yibo Zhao <yiboz@codeaurora.org> writes:
>>=20
>>> On 2019-09-16 23:27, Johannes Berg wrote:
>>>> Without really looking at the code -
>>>>=20
>>>>> If station is ineligible for transmission in
>>>>> ieee80211_txq_may_transmit(),
>>>>> no packet will be delivered to FW. During the tests in push-pull=20
>>>>> mode
>>>>> with
>>>>> many clients, after several seconds, not a single station is an
>>>>> eligible
>>>>> candidate for transmission since global time is smaller than all the
>>>>> station's virtual airtime. As a consequence, the Tx has been blocked
>>>>> and
>>>>> throughput is quite low.
>>>>=20
>>>> You should rewrite this to be, erm, a bit more understandable in
>>>> mac80211 context. I assume you're speaking (mostly?) about ath10k,=20
>>>> but
>>>> I
>>>> have very little context there. "push pull mode"? "firmware"? These
>>>> things are not something mac80211 knows about.
>>> Hi Johannes,
>>>=20
>>> Thanks for your kindly reminder. Will rewrite the commit log.
>>>=20
>>>>=20
>>>>> Co-developed-by: Yibo Zhao <yiboz@codeaurora.org>
>>>>=20
>>>> That also seems wrong, should be Toke I guess, unless you intended=20
>>>> for
>>>> a
>>>> From: Toke to be present?
>>> Do you mean it should be something like:
>>>=20
>>> Co-developed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.dk>
>>> Signed-off-by: Yibo Zhao <yiboz@codeaurora.org>
>>> Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.dk>
>>>=20
>>> Am I understanding right?
>>=20
>> I think the right thing here, as with the previous patch, is to just
>> drop my sign-off; you're writing this patch, and I'll add ack/reviews=20
>> as
>> appropriate. And in that case, well, no need to have co-developed-by
>> yourself when your name is on the patch as author :)
>>=20
>> -Toke
> Sorry, I think I have missed checking your reply, please ignore the=20
> wrong signed-off in PATCH-V2.

While you're re-spinning, could you please add a changelog for the
changes you make? Makes it easier to keep track :)

You can add a cover-letter with a full changelog instead of having a
separate changelog for each patch; that's what I usually do...

-Toke

