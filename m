Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B7CBEB907A
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Sep 2019 15:16:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727329AbfITNQm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 20 Sep 2019 09:16:42 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:40378 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725842AbfITNQl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 20 Sep 2019 09:16:41 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 81B6461418; Fri, 20 Sep 2019 13:16:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1568985400;
        bh=rUHfeIczuED1/o6lZPJ3TUjPOVuQyAqF6bAfwhLl0Yk=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=Fl/H2wEPX2w63rUTnOpFTA0pIOsnMfmW4cz19oggv2MtI89cVutOja2dwkEhLuTjL
         T5yX7BhklhCnRJAnIkY+TzA1+f6Sfuxyazi2I0saLb/zS756m+QCuNHTXd5F3QITc1
         VoAP+XceRCb1Ea6SKTcgLDpkteFwmFqy2xlGftHg=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from tynnyri.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4F05E61544;
        Fri, 20 Sep 2019 13:16:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1568985399;
        bh=rUHfeIczuED1/o6lZPJ3TUjPOVuQyAqF6bAfwhLl0Yk=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=Q4VAL7Mjo0WtgFxpnAXxTg7SXp0vwAamLJAjR7SuVllSKJOMR8l9IOW5Ia+3fsqR3
         /0y57+1HoaoT8uQpTZo8YQTQfZoYPy7xFzPKm7d31XkdClPqVp6t9TVZVNNa0m+FXZ
         64NZFfVv4GWlSFPtZeJNxlwqvQCONgF8nq/3sqBs=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4F05E61544
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Jean-Pierre TOSONI <jp.tosoni@acksys.fr>
Cc:     "linux-wireless\@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Re: mac80211+ath9k AP fails to honour power save mode from client
References: <AM4PR0101MB23055B57EF8BEBA8D478554CE4C80@AM4PR0101MB2305.eurprd01.prod.exchangelabs.com>
Date:   Fri, 20 Sep 2019 16:16:36 +0300
In-Reply-To: <AM4PR0101MB23055B57EF8BEBA8D478554CE4C80@AM4PR0101MB2305.eurprd01.prod.exchangelabs.com>
        (Jean-Pierre TOSONI's message of "Thu, 18 Jul 2019 14:52:05 +0000")
Message-ID: <874l17jeff.fsf@tynnyri.adurom.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Jean-Pierre TOSONI <jp.tosoni@acksys.fr> writes:

> Context:
>
>  I am using one device in AP mode, the other in client mode.
>  The client uses wpa_supplicant to do *background scan to other channels that the data channel*.
>  I am running iperf (UDP) *from the AP* to the client.
>
>  My device is Cavium development board-based (Octeon III CPU), equipped with Compex WLE350NX.
>  It used to work correctly with kernel 3.18 and an old 2015 wireless backport.
>  Now I updated to kernel 4.9 and the wireless backport 4.19.32-1, the
> last one from the OpenWRT trunk. (previously I used
> backport-2017-11-01 with the same failure).
>
>  I am running wireshark with Airpcap to spy the wireless link.
>
> Problem:
>
>  When the client scans offchannel, it correctly sends nullfunc frames around the offchannel period, with the PM bit set then unset.
>
>  However, during this time, the AP continues to send data to the client.
>    
>  This results in a lot of lost frames, though I set the powersave buffers to high values on the AP side.
>
>
> After some research I saw that the same kind of problem was fixed [1]
> and even re-fixed, but since there where so many changes in the queue
> management, I cannot really compare his work and the current state of
> the driver.
>
> Any idea / patch / directions of research ?
>
> J.P. Tosoni - ACKSYS
>
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=5519541d5a5f19893546883547e2f0f2e5934df7 

This an old report from July but sounds a pretty serious problem to me,
and power save problems are difficult to detect by normal users which
makes this even more important. Has anyone else noticed anything
similar?

Something which would help a lot is to bisect when the problem appeared.
For example, if you can connect your ath9k board to an x86 device you
could start testing upstream kernel releases[1] directly from git
(v3.18, v4.9, v4.19 and so on). With an upstream kernel release I mean a
release directly from Linus' tree:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/

This way there are no out-of-tree patches applied, and we can also rule
out backports problems, which makes it easier to find the root cause.
Just first make sure you that you can reproduce the problem with the
upstream kernel so that you don't waste time bisecting which is not
there :)

First find what is the last working release ("good") and the first
release which has the bug ("bad"). This way it's a lot easier to find
the culprit and fix it.

You can checkout a specific release like this:

git checkout v4.9

And even better if you can then use git-bisect to find the actual commit
which broke it:

git bisect start
git bisect bad v4.12
git bisect good v4.11

https://www.kernel.org/doc/html/latest/admin-guide/bug-bisect.html

Please do let me know how it goes, this issue should be fixed. Power
save problems are always tricky and cause bad user experience.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
