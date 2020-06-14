Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F0F01F860E
	for <lists+linux-wireless@lfdr.de>; Sun, 14 Jun 2020 02:54:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726578AbgFNAyV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 13 Jun 2020 20:54:21 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:35706 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726272AbgFNAyU (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 13 Jun 2020 20:54:20 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1592096060; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=RJUxEdRk9END3qUuwRtSai9ux5Ij1zPb5JPbXMR8VIo=;
 b=naBHs75mdzao1NVa22afSIA+enOo25INJUl74UE5mAslh+UDnIc14GNEyyeDeU/T6GKyi3Lk
 SFMcKego03dAiKfgvSb3RPA1DiTk+djOnC+qUhMdaCWswDiaiazMpZg++nCENwYUBtTS9Gh4
 Xseqa1dx97G1m8oiW9w/dY4VySs=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-east-1.postgun.com with SMTP id
 5ee5752fa6e154319fd121e0 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sun, 14 Jun 2020 00:54:07
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id C4C43C433CA; Sun, 14 Jun 2020 00:54:06 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: alokad)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 49618C433C8;
        Sun, 14 Jun 2020 00:54:06 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Sat, 13 Jun 2020 17:54:06 -0700
From:   Aloka Dixit <alokad@codeaurora.org>
To:     Arend Van Spriel <arend.vanspriel@broadcom.com>
Cc:     johannes@sipsolutions.net, linux-wireless@vger.kernel.org,
        alokad@codeaurora.org
Subject: Re: [PATCH v3 0/2] Add FILS discovery support
In-Reply-To: <43f3871e11a02055a6662fc6aa5cf682@codeaurora.org>
References: <20200602013844.26275-1-alokad@codeaurora.org>
 <21731442-f74f-339d-15a4-8dd18b68638a@broadcom.com>
 <43f3871e11a02055a6662fc6aa5cf682@codeaurora.org>
Message-ID: <030d7422a6e19547de5012dac2934326@codeaurora.org>
X-Sender: alokad@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2020-06-13 17:47, Aloka Dixit wrote:
> On 2020-06-04 00:38, Arend Van Spriel wrote:
>> On 6/2/2020 3:38 AM, Aloka Dixit wrote:
>>> This patchset adds support for FILS discovery transmission as per
>>> IEEE Std 802.11ai-2016.
>>> 
>>> This is the next version in the series given below:
>>> FILS discovery and bcast probe resp support.
>>> Unsolicited broadcast probe response support is now split into
>>> a separate patchset.
>> 
>> Hi Aloka,
>> 
>> What is your motivation for the split? As you stated earlier FILS
>> discovery and unsollicited probe responses are mutual exclusive as it
>> only eats up airtime to do both. I tend to agree to that earlier
>> statement so I would like to see some arguments for doing the split.
>> 
> 
> Hi Arend,
> Two reasons to split the patches:
> (1) Unsolicited broadcast probe response is specific to 6GHz whereas
> FILS discovery is applicable in all bands. I haven't added a check for
> 6GHz for the former in nl80211 and mac80211 code because I expect the
> application and driver implementations to add it.
> (2) IEEE P802.11ax/D6.0 mentions that a device "may" skip FILS
> discovery transmission and instead schedule unsolicited broadcast
> probe response (if enabled) in 6GHz, but it is not mandatory.
> So it made sense to have two separate attributes and let the driver
> and/or FW implementation decide if both can be active at the same
> time. nl80211 and mac80211 shouldn't make that decision.
> With separate attributes, having separate patches are easier to review.
> 
> 
The second point I added above is not entirely correct - if unsolicited 
broadcast response is active then FILS discovery must be omitted, but if 
it is not active, then also device may choose to send probe response 
instead of FILS discovery.
But that decision should not be made at nl80211 or mac80211.

>> Regards,
>> Arend
>> 
>>> Aloka Dixit (2):
>>>    nl80211: Add FILS discovery support
>>>    mac80211: Add FILS discovery transmission support
>>> 
>>>   include/net/cfg80211.h       | 25 ++++++++++++++++
>>>   include/net/mac80211.h       | 31 ++++++++++++++++++++
>>>   include/uapi/linux/nl80211.h | 46 +++++++++++++++++++++++++++++
>>>   net/mac80211/cfg.c           | 46 +++++++++++++++++++++++++++++
>>>   net/mac80211/ieee80211_i.h   |  7 +++++
>>>   net/mac80211/tx.c            | 25 ++++++++++++++++
>>>   net/wireless/nl80211.c       | 57 
>>> ++++++++++++++++++++++++++++++++++++
>>>   7 files changed, 237 insertions(+)
>>> 
