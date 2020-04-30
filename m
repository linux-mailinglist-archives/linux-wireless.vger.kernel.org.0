Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CBAD1BECE7
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Apr 2020 02:14:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726284AbgD3AOS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 29 Apr 2020 20:14:18 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:60129 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726279AbgD3AOR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 29 Apr 2020 20:14:17 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1588205657; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=fU54na2RUjcf3e3R4dc33+lS3Yr4XkMyOmmi4nyz5TA=;
 b=BYyaMdZDBskjvv/7OAzyoThGQ2K+fOLaSbTWbQXv569vQcnNkK87kKPtMsnh11dzgdZcNTAB
 cUUs8q/kdaQe1QkLOqf9xrI0A9Cmb1dqB9vkWc62drhpr2p6Rpnj5/Dzf8nh3pDd9mny60n3
 SkGzobffXYk+IRt7G18RiTN5mhU=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5eaa1853.7f0f2b9500d8-smtp-out-n01;
 Thu, 30 Apr 2020 00:14:11 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 77F23C433CB; Thu, 30 Apr 2020 00:14:10 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED autolearn=ham
        autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: rmanohar)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 490BFC433D2;
        Thu, 30 Apr 2020 00:14:10 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 29 Apr 2020 17:14:10 -0700
From:   Rajkumar Manoharan <rmanohar@codeaurora.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org
Subject: Re: [PATCH 06/10] mac80211: add HE 6 GHz Band Capability IE in assoc.
 request
In-Reply-To: <faba71a22ecf46d3b2caf0166943ec4e2dc1c6c5.camel@sipsolutions.net>
References: <1587768108-25248-1-git-send-email-rmanohar@codeaurora.org>
 <1587768108-25248-7-git-send-email-rmanohar@codeaurora.org>
 <faba71a22ecf46d3b2caf0166943ec4e2dc1c6c5.camel@sipsolutions.net>
Message-ID: <cbe6e16fcaebe13053955ff50b351c7f@codeaurora.org>
X-Sender: rmanohar@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2020-04-29 07:33, Johannes Berg wrote:
> On Fri, 2020-04-24 at 15:41 -0700, Rajkumar Manoharan wrote:
>> Construct HE 6 GHz band capability element (IEEE 802.11ax/D6.0, 
>> 9.4.2.261)
>> for association request and mesh beacon. The 6 GHz capability 
>> information
>> is passed from driver through iftypes caps.
> 
> Oh. I had some patches for this too but Luca never sent them out...
> 
> I'll have to check the differences to see if either of us missed
> something :)
> 
Great.. Would like to see yours changes. I also posted similar changes 
in hostapd
for AP mode. Please check them as well.

-Rajkumar
