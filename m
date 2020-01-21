Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 46FAC1437CA
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Jan 2020 08:41:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727453AbgAUHlE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 21 Jan 2020 02:41:04 -0500
Received: from mail26.static.mailgun.info ([104.130.122.26]:29581 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726052AbgAUHlE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 21 Jan 2020 02:41:04 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1579592463; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=mZT02m5WtNm8DGwtlMPRSKxETSGBgxHA89dSYIx5LGc=;
 b=XQ7i3VqbKuzHgJ9NRfHjr9Iy/Pk6CQY0ATN+Y94mKS223xktO8iqfTxYxkXFw5tZAOB088xJ
 /QER5VGSgjuQu0Na1msvlPF41sIAVXNTHyjoU2R60iX+ZLRqKBOQI5yklc9Dz+NUlFTnxX61
 6S395idRiU9ISoPMLtDxddX8eQA=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e26ab0e.7efd85da30a0-smtp-out-n02;
 Tue, 21 Jan 2020 07:41:02 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 81FF8C433A2; Tue, 21 Jan 2020 07:41:02 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: tamizhr)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 08BBEC433CB;
        Tue, 21 Jan 2020 07:41:02 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 21 Jan 2020 13:11:02 +0530
From:   tamizhr@codeaurora.org
To:     Tamizh Chelvam <tamizhr@codeaurora.org>
Cc:     johannes@sipsolutions.net, linux-wireless@vger.kernel.org
Subject: Re: [PATCHv10 0/6] cfg80211/mac80211: Add support for TID specific
 configuration
In-Reply-To: <20200121071724.p6mbyiqjal3jjfin@bars>
References: <1579506687-18296-1-git-send-email-tamizhr@codeaurora.org>
 <20200121071724.p6mbyiqjal3jjfin@bars>
Message-ID: <528d2b83942394ae1aad08ffe7548a8a@codeaurora.org>
X-Sender: tamizhr@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2020-01-21 12:47, Sergey Matyukevich wrote:
>> Add infrastructure to support per TID configurations like noack 
>> policy,
>> retry count, AMPDU control(disable/enable), RTSCTS 
>> control(enable/disable)
>> and TX rate mask configurations.
>> This will be useful for the driver which can supports data TID
>> specific configuration rather than phy level configurations.
>> Here NL80211_CMD_SET_TID_CONFIG added to support this operation by
>> accepting TID configuration.
>> This command can accept STA mac addreess to make the configuration
>> station specific rather than applying to all the connected stations
>> to the netdev.
>> And this nested command configuration can accept multiple number of
>> data TID specific configuration in a single command,
>> enum ieee80211_tid_conf_mask used to notify the driver that which
>> configuration got modified for the TID.
>> 
>> Tamizh chelvam (6):
>>   nl80211: Add NL command to support TID speicific configurations
>>   nl80211: Add support to configure TID specific retry configuration
>>   nl80211: Add support to configure TID specific AMPDU configuration
>>   nl80211: Add support to configure TID specific RTSCTS configuration
>>   nl80211: Add support to configure TID specific txrate configuration
>>   mac80211: Add api to support configuring TID specific configuration
>> 
>>  include/net/cfg80211.h       |   65 ++++++++++
>>  include/net/mac80211.h       |   10 ++
>>  include/uapi/linux/nl80211.h |  140 +++++++++++++++++++++
>>  net/mac80211/cfg.c           |   56 +++++++++
>>  net/mac80211/driver-ops.h    |   27 ++++
>>  net/wireless/nl80211.c       |  287 
>> +++++++++++++++++++++++++++++++++++++++---
>>  net/wireless/rdev-ops.h      |   24 ++++
>>  net/wireless/trace.h         |   37 ++++++
>>  8 files changed, 629 insertions(+), 17 deletions(-)
> 
> Hello Tamizh,
> 
> Thanks for you fixes and patience! The last two versions look pretty
> good to me.
> 
> Reviewed-by: Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
> 
Sergey,

Thanks for your continuous support in reviewing this patchset:)

Thanks,
Tamizh.
