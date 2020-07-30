Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57A55233B04
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Jul 2020 23:53:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730587AbgG3Vxz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 30 Jul 2020 17:53:55 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:18137 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730552AbgG3Vxy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 30 Jul 2020 17:53:54 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1596146034; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=rLtNgw6dHJHIrGMaL4whUVA8h434vIgTdWSFRpvNr1Y=;
 b=LXoYi0M4lxGBu6BxEumXEytzAgukmavqs5Fjya22VlRiC7yR9Jy0c/e5RIxbam9uiC0vBlTt
 AjBNm3SfQhX/GBSOg8Z2IIA5UZUKBcdrf31S7umorX55dl2mQ1DHi/J8oo6zStVOj0CfHylm
 3hyfJPRgaVCYMSqrlB4Cu3oNVxY=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n20.prod.us-west-2.postgun.com with SMTP id
 5f234165eb556d49a6606a6e (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 30 Jul 2020 21:53:41
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 707D2C433C6; Thu, 30 Jul 2020 21:53:41 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: alokad)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0999DC433C9;
        Thu, 30 Jul 2020 21:53:40 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 30 Jul 2020 14:53:40 -0700
From:   Aloka Dixit <alokad@codeaurora.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org,
        linux-wireless-owner@vger.kernel.org
Subject: Re: [PATCH v4 1/2] nl80211: Add FILS discovery support
In-Reply-To: <54628f052b380e660c37cb9b7c3f224976aa1c83.camel@sipsolutions.net>
References: <20200618050427.5891-1-alokad@codeaurora.org>
 <20200618050427.5891-2-alokad@codeaurora.org>
 <c3dbcc3e4ee2d3596625e8c1226325180444a961.camel@sipsolutions.net>
 <2b1ea1c4baedcb119f4e632b26399071@codeaurora.org>
 <54628f052b380e660c37cb9b7c3f224976aa1c83.camel@sipsolutions.net>
Message-ID: <ca081672e9e3407bec949c963add8530@codeaurora.org>
X-Sender: alokad@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2020-07-30 14:22, Johannes Berg wrote:
> On Thu, 2020-07-30 at 14:17 -0700, Aloka Dixit wrote:
> 
>> > OTOH, if it's with headers, how could it be optional? In fact, either
>> > way, how is it optional?
>> >
>> 
>> Template has management frame headers as well. Will change the wording
>> accordingly.
> 
> OK.
> 
>> I made the template optional because FILS discovery may or may not be
>> offloaded to FW.
> 
> But how would anyone know? Try without it, and then try again if that
> fails? Would it fail? I mean, you also said it was required at least 
> for
> 6 GHz, so wouldn't userspace be better off always giving it - and then
> we should probably make it mandatory so it doesn't fall into the trap?
> 

If the template is not provided, FW keeps sending event to get it.
But as my ath11k driver code is limited to 6GHz, it already throws error 
if template not provided.
Yes, in general it will be better to make it mandatory, I will do it in 
next version.

> However - and here that's my ignorance speaking - can it really be
> offloaded? I mean, is everything in there completely determined by the
> beacon already, and so you have no choice in how to build it? Or how
> does that work?
> 

Yes, the frame parameters are fixed except for the timestamp which FW is 
expected to fill.

>> Yeah, I looked through existing examples for NLA_BINARY, those provide
>> only the higher bound for length.
> 
> Yeah, no way to do anything else right now. But you should have a lower
> bound in the code, I think.
> 

Okay.

>> But I can modify it to range once that is added.
> 
> Later maybe :)
> 
> johannes
