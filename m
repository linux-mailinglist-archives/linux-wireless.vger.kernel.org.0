Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 963CEB64E2
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Sep 2019 15:42:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729957AbfIRNl7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 18 Sep 2019 09:41:59 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:60752 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728555AbfIRNl7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 18 Sep 2019 09:41:59 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id CCAA7606E1; Wed, 18 Sep 2019 13:41:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1568814118;
        bh=EBe0S3RdVZqmtXYYAvgIsB4ZA32+LQjM+vdV4XS17ms=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=YgEMAMVKxVtajKykYJHc+9RNhbmc0kVzqFF3QkdCq4pOc34RQpjWC+ohu48/eHdyT
         5IxVxLbXjhHfUmKiSkHKK6pG7vcHBlxoXQzI023WhhB4mBNtheDqdrR7+mpLO9OJJf
         MVa/PY+XdGm380QcVlC10d5II0DRvodes4RGgi9Q=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 8AFB26133A;
        Wed, 18 Sep 2019 13:41:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1568814118;
        bh=EBe0S3RdVZqmtXYYAvgIsB4ZA32+LQjM+vdV4XS17ms=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=YgEMAMVKxVtajKykYJHc+9RNhbmc0kVzqFF3QkdCq4pOc34RQpjWC+ohu48/eHdyT
         5IxVxLbXjhHfUmKiSkHKK6pG7vcHBlxoXQzI023WhhB4mBNtheDqdrR7+mpLO9OJJf
         MVa/PY+XdGm380QcVlC10d5II0DRvodes4RGgi9Q=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8AFB26133A
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Bob Copeland <me@bobcopeland.com>
Cc:     Balaji Pothunoori <bpothuno@codeaurora.org>,
        johannes@sipsolutions.net,
        Ashok Raj Nagarajan <arnagara@codeaurora.org>,
        linux-wireless@vger.kernel.org, ath10k@lists.infradead.org
Subject: Re: [PATCH v4 3/3] ath10k: add support for controlling tx power to a station
References: <1553856587-21611-1-git-send-email-bpothuno@codeaurora.org>
        <20190402223709.GB8910@localhost>
Date:   Wed, 18 Sep 2019 16:41:54 +0300
In-Reply-To: <20190402223709.GB8910@localhost> (Bob Copeland's message of
        "Tue, 2 Apr 2019 18:37:09 -0400")
Message-ID: <871rwdbu1p.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Bob Copeland <me@bobcopeland.com> writes:

> On Fri, Mar 29, 2019 at 04:19:47PM +0530, Balaji Pothunoori wrote:
>> From: Ashok Raj Nagarajan <arnagara@codeaurora.org>
>> 
>> This patch will add the support to control the transmit power for traffic
>> to a station associated with the AP.
>> 
>> Underlying firmware will enforce that the maximum tx power will be based
>> on the regulatory requirements. If the user given transmit power is greater
>> than the allowed tx power in the given channel, then the firmware will use
>> the maximum tx power in the same channel.
>> 
>> When 0 is sent to the firmware as tx power, it will revert to the default
>> tx power for the station.
>> 
>> Tested Hardware : QCA9984
>> Tested Firmware : 10.4-3.9.0.1-00013
>
> I tried this on qca9984 with 10.4-3.9.0.2-00040, which claims to support
> this feature, and it didn't seem to work:
>
> - with global tx power limit set to 30 dBm, I started an iperf from station
>   A -> B
>
> - while iperf underway, I did tcpdump on a monitor on B and looked at signal
>   level in radiotap, in this case around -75 dBm
>
> - on A, changed the per-sta txpwr limit for B to something (tried as low as
>   1 dBm).  verified via printk that it went through to the driver / firmware
>   command and reported no error
>   -> result: signal level unchanged
>
> - on A, changed the global tx power limit to 1 dBm
>   -> result: signal level dropped to ~ -95 dBm
>
> Reading the description above, now I'm wondering if the txpower is
> max(sta-power,global-power)?  If so, that seems a bit unintuitive to me,
> or at least isn't what I hoped for.  I'd prefer to have per-sta power
> setting override the global power.

Balaji, please reply to Bob's questions. I missed this thread while
applying v5, sorry Bob.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
