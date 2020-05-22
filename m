Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62AF31DF328
	for <lists+linux-wireless@lfdr.de>; Sat, 23 May 2020 01:47:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387403AbgEVXrD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 22 May 2020 19:47:03 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:23827 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726546AbgEVXrD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 22 May 2020 19:47:03 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1590191222; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=Gx02i5Yb6v30cf4xupak+zCn9HyVT81kHQxKTCg+eZM=;
 b=kN+e7WrCXr5LXYQk7EinOlzC3rD/vL8G2YBuVBUSSI0GH1W9JHmTArn+RnCxPljKyPdeMZDR
 npUQ/jg+vOOyQ8DYDiozRbrdHDPa4zL0fibHXYSBKa9t8zOPECt/1sfmB9FItj0eB4i1q0cO
 dlacpslu2T/sMxfTegPP39Q86lk=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5ec86465.7f542c9a1730-smtp-out-n01;
 Fri, 22 May 2020 23:46:45 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 47B27C433C9; Fri, 22 May 2020 23:46:45 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED autolearn=ham
        autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: pradeepc)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 10425C433C8;
        Fri, 22 May 2020 23:46:45 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Fri, 22 May 2020 16:46:45 -0700
From:   Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH v2 1/9] cfg80211: Add new channel flag to identify 6GHz
 PSC channel
In-Reply-To: <fa1879bf357c091277972b2a370799fdf6192ae3.camel@sipsolutions.net>
References: <20200522072431.27601-1-pradeepc@codeaurora.org>
 <20200522072431.27601-2-pradeepc@codeaurora.org>
 <fa1879bf357c091277972b2a370799fdf6192ae3.camel@sipsolutions.net>
Message-ID: <05fcfc43f2d59dd549a65a83ab60df60@codeaurora.org>
X-Sender: pradeepc@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2020-05-22 13:38, Johannes Berg wrote:
> On Fri, 2020-05-22 at 00:24 -0700, Pradeep Kumar Chitrapu wrote:
>> 6GHz channels are divided into preferred scanning channels(PSC)
>> and non-PSC channels. One in every four 20MHz channels is a PSC.
>> Spec mandates to use only PSC channels as primary channels for
>> setting up BSS on 6GHz only AP.
>> 
>> The set of 20 MHz channels in the 6 GHz band, with channel center
>> frequency, ch_a = Channel starting frequency – 55 + 80 × n (MHz)
>> are referred to as preferred scanning channels (PSCs) where,
>> n = 1, …, 15 as per IEEE P802.11ax/D6.0.
>> 
>> This flag also will be used when making scanning decision on
>> 6GHz channels.
> 
> Is there much value in exposing this as a *flag*?
> 
> We have a similar patch, but it just adds the function and everyone who
> cares can call it. Do we really need to precalculate that?
> 
> johannes
Thanks Johannes for the review..

IMO, accessing flag would be faster instead of computation, as this info
is handy (already in cache) when accessing ieee80211_channel.
However, considering general usage for this info would be only for 
control
path, it should be ok to expose function instead of maintaining separate 
flag.
Please let me know your suggestion..


Thanks
Pradeep
