Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 186B71408FE
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Jan 2020 12:34:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727665AbgAQLeH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 17 Jan 2020 06:34:07 -0500
Received: from mail26.static.mailgun.info ([104.130.122.26]:64702 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726371AbgAQLeH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 17 Jan 2020 06:34:07 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1579260846; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=IVTvsdFHsyPS95Rjy+xQHtpW/tYPzQJL2Wcgi7Ip3QM=;
 b=Z+NBgOLz8TZPCIlL6WUlXeilZ3lmc3asW0jhtp0bAHApH65ZcoIWWUSdwljzTnM6rQWmDW/a
 2GsepZtNR+se5mf9PlcxmRP42WbT/LGs0162Iopo4Tl8mnEuRlZBWZzRjH5SJzWhGObQQtwK
 2afux9WcQDCsVnoNI5wl1M4LeVk=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e219ba9.7fe46906f730-smtp-out-n03;
 Fri, 17 Jan 2020 11:34:01 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 84B33C4479C; Fri, 17 Jan 2020 11:34:01 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED autolearn=ham
        autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: vjakkam)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4E9CEC43383;
        Fri, 17 Jan 2020 11:34:01 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 17 Jan 2020 17:04:01 +0530
From:   vjakkam@codeaurora.org
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org
Subject: Re: [PATCH] cfg80211: Enhance the AKM advertizement to support per
 interface.
In-Reply-To: <6d2d94e01552f5713266add9e4909c85266e53ab.camel@sipsolutions.net>
References: <20191223185255.1009-1-vjakkam@codeaurora.org>
 <6d2d94e01552f5713266add9e4909c85266e53ab.camel@sipsolutions.net>
Message-ID: <69277bd9d6abac200c2dcd931521d084@codeaurora.org>
X-Sender: vjakkam@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2020-01-02 19:11, Johannes Berg wrote:
> On Tue, 2019-12-24 at 00:22 +0530, Veerendranath Jakkam wrote:
>> 
>> @@ -2437,10 +2472,8 @@ static int nl80211_send_wiphy(struct 
>> cfg80211_registered_device *rdev,
>>  		state->split_start++;
>>  		break;
>>  	case 15:
>> -		if (rdev->wiphy.akm_suites &&
>> -		    nla_put(msg, NL80211_ATTR_AKM_SUITES,
>> -			    sizeof(u32) * rdev->wiphy.n_akm_suites,
>> -			    rdev->wiphy.akm_suites))
> 
> I don't think you should break this for all existing cases.
> 
> johannes

Thanks, I will correct in v2
