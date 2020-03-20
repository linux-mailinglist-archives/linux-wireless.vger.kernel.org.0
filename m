Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E0D4E18C679
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Mar 2020 05:29:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726969AbgCTE3V (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 20 Mar 2020 00:29:21 -0400
Received: from resqmta-po-10v.sys.comcast.net ([96.114.154.169]:59309 "EHLO
        resqmta-po-10v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725996AbgCTE3V (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 20 Mar 2020 00:29:21 -0400
X-Greylist: delayed 488 seconds by postgrey-1.27 at vger.kernel.org; Fri, 20 Mar 2020 00:29:21 EDT
Received: from resomta-po-05v.sys.comcast.net ([96.114.154.229])
        by resqmta-po-10v.sys.comcast.net with ESMTP
        id F919jk0yP2WZ8F99ljeRkG; Fri, 20 Mar 2020 04:21:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=comcastmailservice.net; s=20180828_2048; t=1584678073;
        bh=TRdmzlBZKIjp6suR+uwhZUwUF+19FuwsfRRrul9c3mY=;
        h=Received:Received:To:From:Subject:Message-ID:Date:MIME-Version:
         Content-Type;
        b=buB3nxWtkq5dqHDz5UzAj1x5x+8ZoAfGWcRmRR2TCS+xPgY1rBZDYe+oLgYShHq6d
         XJKDtX/yjKR9eAP5CuXzPRP8aH2NmPOHDp3/wU3JFHxUcF6Ypx+0yqaveG2RYXDfWq
         XFP6APu85GfT/kJAQs2FLE/8k6qEeH4h0FpDfClyVJd/iVv979PDcxtHUrgYYTCRCB
         UQCiKVl89qUPSnIKXiseerEy+22d3cJfflSU5srPHym/DS5WPTqgU6wk6a/xwADxgF
         hE3jtJaCti//DGQJ+bwRUp/hpwDY+902qFV13hVcjmxMbWWjnbs9Dhg8VIpmd1XRel
         kbhW64llDt9ZA==
Received: from touchy.whiterc.com
 ([IPv6:2601:601:1400:7284:bb0f:f2d7:bbd9:d943])
        by resomta-po-05v.sys.comcast.net with ESMTPSA
        id F99kjBNiuOfMQF99kjix7e; Fri, 20 Mar 2020 04:21:12 +0000
X-Xfinity-VMeta: sc=0.00;st=legit
To:     linux-wireless@vger.kernel.org
From:   Robert White <rwhite@pobox.com>
Subject: hostapd :: Set attributes e.g. group id on created 4addr interfaces
Message-ID: <920d4a67-a746-d9bf-d318-d9bc130bbe3a@pobox.com>
Date:   Fri, 20 Mar 2020 04:21:12 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Howdy,

It'd be really nice if there was a global up-down hook or something in 
hostapd that would let me set the interface group ID when a station 
interface is created on a 4addr link.

I couldn't find a hook to invoke on device creation; and invoking a 
whole hook might be a little costly.

I don't see a lot of relevant properties to set but group ID is really 
helpful for firewall rules on transient interfaces. Since it can be done 
when doing an ip link add, I'd assume setting the simpler properties 
like this should be available at the API level.

So being able to set that property at a minimum during device creation 
would be really helpful, and there may be use cases for other things.

I don't have the necessary skill set with hostapd to submit a sample 
implementation at this time, so color me a demanding user (ha ha ha).
