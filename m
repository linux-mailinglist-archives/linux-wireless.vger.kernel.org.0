Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2BF5279787
	for <lists+linux-wireless@lfdr.de>; Sat, 26 Sep 2020 09:31:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728902AbgIZHbr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 26 Sep 2020 03:31:47 -0400
Received: from pop32.abv.bg ([194.153.145.222]:55830 "EHLO pop32.abv.bg"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726149AbgIZHbr (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 26 Sep 2020 03:31:47 -0400
Received: from smtp.abv.bg (localhost [127.0.0.1])
        by pop32.abv.bg (Postfix) with ESMTP id F17AC1FC1F;
        Sat, 26 Sep 2020 10:31:44 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=abv.bg; s=smtp-out;
        t=1601105505; bh=2JG59DfDcpyEPXtMwuKDRywBB+vtxtcZ2b59fzsksj0=;
        h=Subject:From:In-Reply-To:Date:Cc:References:To:From;
        b=ALdStKb+UpEQgGcalKh7WXdB8XNocj32c8cOUyZReaY11z1pcbHUI+MNPeYSPOrQV
         0IvJ9YglISWUC/Es0zcT9QHQHFrE0DLvtpsc9cfWbw8A4YD4kulmJEwjWhwchZMEi/
         +ksbj/kW32xN1vdTUTYaKRAWjAA4YAQL+X8VKdM4=
X-HELO: [192.168.192.3]
Authentication-Results: smtp.abv.bg; auth=pass (plain) smtp.auth=gvalkov@abv.bg
Received: from Unknown (HELO [192.168.192.3]) (87.118.177.198)
 by smtp.abv.bg (qpsmtpd/0.96) with ESMTPSA (ECDHE-RSA-AES128-GCM-SHA256 encrypted); Sat, 26 Sep 2020 10:31:44 +0300
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [PATCH v2] mac80211: fix regression in sta connection monitor
From:   Georgi Valkov <gvalkov@abv.bg>
In-Reply-To: <3762d906-31ff-8386-b9ea-d7b06ea07397@nbd.name>
Date:   Sat, 26 Sep 2020 10:31:42 +0300
Cc:     linux-wireless@vger.kernel.org, johannes@sipsolutions.net,
        openwrt-devel@lists.openwrt.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <E4065653-11EF-4E3C-8767-2F9789609026@abv.bg>
References: <20200922102434.42727-1-nbd@nbd.name>
 <FD88F09D-5FEA-4A15-B586-95843830F737@abv.bg>
 <3762d906-31ff-8386-b9ea-d7b06ea07397@nbd.name>
To:     Felix Fietkau <nbd@nbd.name>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


> thanks for testing and for your insight into this issue.
I=E2=80=99m happy to help!

> On 2020-09-26 06:41, Georgi Valkov wrote:
>> Hi Felix!
>>=20
>> With your latest suggestion, it takes between 10 and 17 hours for the =
connection to drop, then long five minutes to reconnect.
>> Notice the order of code execution in the original code of =
ieee80211_sta_tx_notify():
>> probe_send_count is always cleared when ack is true. But before =
clearing probe_send_count, we need to check if =
ieee80211_is_any_nullfunc() returns true and probe_send_count > 0: if =
yes, we must call ieee80211_queue_work(). You cleared probe_send_count =
ahead of time, so the condition to run ieee80211_queue_work() will never =
be met.
> The condition in ieee80211_sta_tx_notify may not be met, but
> ieee80211_queue_work is called from ieee80211_tx_status_ext in that
> case. Any idea why that is not enough?

Whenever that condition is met and probe_send_count is reset there, =
ieee80211_queue_work() is called for sure. Could that be the problem? =
Because in the original code we also check the result from =
ieee80211_is_any_nullfunc(). We can also add a trace e.g. printk() to =
shine some light on the order of events, hopefully without flooding the =
kernel log too much and without impact on the performance?
You can send me patches directly without committing to master and I will =
test them.

>> To spare your time, I did spend one week to find the cause, then =
another learning every detail about the code and testing various =
solutions, including those you proposed. While I do not have experience =
with mac80211=E2=80=99s design, I=E2=80=99m quite good at preserving the =
exact behaviour during large scale refactoring. And in my fix I tried =
changing as little as possible to keep the patch small, preserving both =
your changes and the original design behaviour.
> And the reason I'm still proposing changes to it is because your patch
> does not take into account no-skb or 802.3 tx status.
> I'll try to make a v3 patch that leaves more of the original code =
intact
> at the cost of a little more duplication.
Good point. You are familiar with how it should work, and I only know =
the changes. You can add the common code into a new function to make it =
easier to follow.

I=E2=80=99m curious: the original RX code used to call =
ieee80211_sta_tx_notify(). Do we need to clear probe_send_count or do =
anything else there? I suppose you removed that because it will be =
performed later. Either way we should not touch that before the issue is =
resolved.


Georgi=
