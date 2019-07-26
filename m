Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D457776B0A
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jul 2019 16:06:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727119AbfGZOG0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 26 Jul 2019 10:06:26 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:56078 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726364AbfGZOG0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 26 Jul 2019 10:06:26 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 7CB5161A6F; Fri, 26 Jul 2019 14:06:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1564149984;
        bh=19BZEf1DFED5lHi5DYyxFy5UVVSdaZ88gNljF/twtns=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ke0XfmlxCihDXuZM5FceJudxO2ODzlQnUQD4guZlwIGHCz1Cl3HjSM/OrRUyer5he
         f+7IZDmFnBeX7XYcth0scRM3Y36VUoeJtGVN0mTHvAWbNnYpE79GViAgIJE8A4LIcB
         Rpe2bLODLD1/vTUGZgBK0yRCV72s9OQi+4Niklx8=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 2766561A5A;
        Fri, 26 Jul 2019 14:06:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1564149982;
        bh=19BZEf1DFED5lHi5DYyxFy5UVVSdaZ88gNljF/twtns=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=GkUfkY2frMBlQ751zK9RvVQICbQ8HUUJh9TgjIa3+6PzIcc+1BNg7tMKysEJqYA6v
         PfkL71obdjaSBfbrdUcjR+gEu7Wc+WW+j5KhzBlBg7EQXHu0S20YlnurU8iYbncEQA
         tOsBblpsJMX4QsjhDap7ibloZsAY1BAaUXUOQyrg=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 26 Jul 2019 19:36:21 +0530
From:   Karthikeyan Periyasamy <periyasa@codeaurora.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org
Subject: Re: [PATCH] mac80211: reject zero MAC address in add station
In-Reply-To: <0cc7d0c578b60730e77ecd03e2df240dd1b393a0.camel@sipsolutions.net>
References: <1563959770-21570-1-git-send-email-periyasa@codeaurora.org>
 <0cc7d0c578b60730e77ecd03e2df240dd1b393a0.camel@sipsolutions.net>
Message-ID: <fd6e7a7e0746b861bbbd660bf54cc675@codeaurora.org>
X-Sender: periyasa@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

>> Don't allow using a zero MAC address as the station
>> MAC address. so validated the MAC address using
>> is_valid_ether_addr.
> 
> Theoretically, all zeroes might have been a valid address at some 
> point.
> I see no reason not to reject it, but I'd like to know why you ended up
> with this now??
> 

Its a Wireless fuzz testing tool (codenomicon) which sends out different 
types of frames to the AP. It actually tampers legitimate wireless 
frames (Probe, Auth, Assoc, Data etc..) and will send to the AP. I 
thought allowing a zero MAC address station is not a valid. so validated 
the given MAC address. Just for curious, which case all zero address is 
a valid MAC.

Thanks,
Karthikeyan
