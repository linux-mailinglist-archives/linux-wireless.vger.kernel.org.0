Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4FE28B5764
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Sep 2019 23:12:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726668AbfIQVM4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 17 Sep 2019 17:12:56 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:22527 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726134AbfIQVM4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 17 Sep 2019 17:12:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1568754775;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QiemktB+P3N/GEfmW+MKZJP+wYiESC5rsqS8LBxmPzk=;
        b=dJREil5Oait2s6Iu5DWSQ4NXHXkc72z0fgE77MXvwPU66Cg4JfW2TctHf+0FLjHqiBWuLw
        M73ag/wFkPKMdZlmeginJf3+ZseP4tOvOeqxXQZJB2cP7eik03OXSS4RSELxoGxg/bU/D5
        iAzW/0sR7LQq+/P6vEzKjoPVavhs3gw=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-301-4EeZPMMuOb6FIrA6m1U62w-1; Tue, 17 Sep 2019 17:12:53 -0400
Received: by mail-ed1-f70.google.com with SMTP id s29so2950992eds.21
        for <linux-wireless@vger.kernel.org>; Tue, 17 Sep 2019 14:12:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=QsNXQII0b/hVtJPOGBZPLEU9w4W7+7j0E1yxUVa+EH4=;
        b=VhLPpCv1hKFxF4/cYF/qIKd8vHwZ4qeUtlRX9tCB9cNQHKj/ZNTVT2Oqw0/AysDv6r
         ihN8H8KAZrpGY15xXM/qi4SQlvAWglDOCZjsGu11LP9jOT9y7x5ZsQHW9RlhEDVHKeCT
         Iy/6bAQCbekb9FyTfIq/IyEttD/dyU9o5OhAi8JLkdXtPMsC4xbQPzTROPHJjDliEtJt
         +O9wtUhzoQrl/PoSGUZX6R9iYscvUQ5+QCfm2PwtAmU/YmAbepR3szwruzntS+aQLB66
         oOtwkYxv3OpTAJuACiPjE0+lBuCStIQxTxvVe8iLW1Ykn+nlihJyGKfOltxlNUxu7AKl
         3TMA==
X-Gm-Message-State: APjAAAXY6Nops+DitO34Bm5HA93IyGD0dCohIpTc/3jHnXv2kul2AG8h
        d4LS/14YGXKAh334hmSdLQDon0tbDQnKOJw8HuN8q5QX5q0ufxHOnyY6dpHviaqKSpTYgzHIP87
        /DK2NGXO6qMsSxan/OgbBpV5/0ik=
X-Received: by 2002:a50:ab58:: with SMTP id t24mr6854408edc.131.1568754772898;
        Tue, 17 Sep 2019 14:12:52 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwRA7NHjKCA535vf76iWEHhOAKFbmQpLrfYd8hhQqMp1T2bLnH1lhfLyyXWyjNfLdb1TRnUMA==
X-Received: by 2002:a50:ab58:: with SMTP id t24mr6854398edc.131.1568754772744;
        Tue, 17 Sep 2019 14:12:52 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a00:7660:6da:443::2])
        by smtp.gmail.com with ESMTPSA id s4sm406666ejx.33.2019.09.17.14.12.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Sep 2019 14:12:52 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 971C41800B9; Tue, 17 Sep 2019 23:12:51 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Yibo Zhao <yiboz@codeaurora.org>,
        Johannes Berg <johannes@sipsolutions.net>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-wireless-owner@vger.kernel.org
Subject: Re: [PATCH 3/4] mac80211: fix low throughput in push pull mode
In-Reply-To: <8e4cd872d082c6bce598c87411a2125f@codeaurora.org>
References: <1568639388-27291-1-git-send-email-yiboz@codeaurora.org> <1568639388-27291-3-git-send-email-yiboz@codeaurora.org> <6684ceecde399edeb31c594f889a403440c78142.camel@sipsolutions.net> <8e4cd872d082c6bce598c87411a2125f@codeaurora.org>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Tue, 17 Sep 2019 23:12:51 +0200
Message-ID: <87lfumiq3w.fsf@toke.dk>
MIME-Version: 1.0
X-MC-Unique: 4EeZPMMuOb6FIrA6m1U62w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Yibo Zhao <yiboz@codeaurora.org> writes:

> On 2019-09-16 23:27, Johannes Berg wrote:
>> Without really looking at the code -
>>=20
>>> If station is ineligible for transmission in=20
>>> ieee80211_txq_may_transmit(),
>>> no packet will be delivered to FW. During the tests in push-pull mode=
=20
>>> with
>>> many clients, after several seconds, not a single station is an=20
>>> eligible
>>> candidate for transmission since global time is smaller than all the
>>> station's virtual airtime. As a consequence, the Tx has been blocked=20
>>> and
>>> throughput is quite low.
>>=20
>> You should rewrite this to be, erm, a bit more understandable in
>> mac80211 context. I assume you're speaking (mostly?) about ath10k, but=
=20
>> I
>> have very little context there. "push pull mode"? "firmware"? These
>> things are not something mac80211 knows about.
> Hi Johannes,
>
> Thanks for your kindly reminder. Will rewrite the commit log.
>
>>=20
>>> Co-developed-by: Yibo Zhao <yiboz@codeaurora.org>
>>=20
>> That also seems wrong, should be Toke I guess, unless you intended for=
=20
>> a
>> From: Toke to be present?
> Do you mean it should be something like:
>
> Co-developed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.dk>
> Signed-off-by: Yibo Zhao <yiboz@codeaurora.org>
> Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.dk>
>
> Am I understanding right?

I think the right thing here, as with the previous patch, is to just
drop my sign-off; you're writing this patch, and I'll add ack/reviews as
appropriate. And in that case, well, no need to have co-developed-by
yourself when your name is on the patch as author :)

-Toke

