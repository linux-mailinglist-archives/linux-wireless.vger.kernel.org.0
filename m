Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 136754377DB
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Oct 2021 15:26:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231331AbhJVN26 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 22 Oct 2021 09:28:58 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:19157 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230342AbhJVN25 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 22 Oct 2021 09:28:57 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1634909200; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=KadeOTJYtrQkEWqq+GA8by7YAHpQlnzqRRdJflygeL8=;
 b=vG0r2pkI2dSY+Oj8fVCUlDWOjteLkQwtJKiu/8Dww5AHa9DwBwmAd8x725VWFaWI1remz+t3
 Pb/8oGv+FyAUvIWK4XMb7TykUcwDwywWKKeboCOf+0iVVmQJCbBK9VholoAfeqeOlLoM4eKh
 LSwMundB+qBMxx7HGaH7F2n/kEw=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-west-2.postgun.com with SMTP id
 6172bc09321f2400511ef942 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 22 Oct 2021 13:26:33
 GMT
Sender: vjakkam=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 499D1C43460; Fri, 22 Oct 2021 13:26:33 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: vjakkam)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0C991C4338F;
        Fri, 22 Oct 2021 13:26:33 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 22 Oct 2021 18:56:32 +0530
From:   vjakkam@codeaurora.org
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org
Subject: Re: [PATCH] nl80211: Indicate SA Query procedures offload for AP SME
 device
In-Reply-To: <612e80125878bae6fccbb72701381832a8a6029c.camel@sipsolutions.net>
References: <1634210331-9001-1-git-send-email-vjakkam@codeaurora.org>
 <612e80125878bae6fccbb72701381832a8a6029c.camel@sipsolutions.net>
Message-ID: <5a1f654e3406e99c816afbc762519fea@codeaurora.org>
X-Sender: vjakkam@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2021-10-21 21:02, Johannes Berg wrote:
> On Thu, 2021-10-14 at 16:48 +0530, Veerendranath Jakkam wrote:
>> Add AP SME device feature flag to advertise that the SA Query 
>> procedures
>> are handled in driver.
>> 
>> If this flag is advertised SA Query request or response frames from 
>> peers
>> are not reported to userspace. Thus userspace components shall skip SA
>> Query specific validations.
>> 
>> Ex: When AP started with Operating Channel Validation(OCV) support and
>> channel switch occurs, hostapd starts SA Query timer for OCV enabled
>> STAs. Hostapd sends deauth to the STAs which didn't send SA Query
>> request before timeout, Hostapd can skip such validations when this 
>> flag
>> advertised.
> 
> So how's that going to work with older hostapd? It'll be offloaded, and
> then hostapd doesn't know, so it's still going to disconnect them?
> 
> So should be that hostapd also opts in to this driver behaviour?

yes, we have to update hostapd also with new implementation based on the
feature flag.

> 
> Also ... it _really_ would be good if there were upstream drivers with
> these things ...

I fully agree. But unfortunately none of the upstream drivers 
implemented
OCV features within them.

