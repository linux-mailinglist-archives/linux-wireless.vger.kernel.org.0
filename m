Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD9F527173F
	for <lists+linux-wireless@lfdr.de>; Sun, 20 Sep 2020 20:58:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726187AbgITS6q (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 20 Sep 2020 14:58:46 -0400
Received: from z5.mailgun.us ([104.130.96.5]:50157 "EHLO z5.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726109AbgITS6q (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 20 Sep 2020 14:58:46 -0400
X-Greylist: delayed 300 seconds by postgrey-1.27 at vger.kernel.org; Sun, 20 Sep 2020 14:58:45 EDT
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1600628325; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=7MFvvWbg+N1Th177I5WRJto68ka/00ve5Z/8Twf+j4w=;
 b=cEHA6iXre/qAygHiYrutQEJl07Sgc3Vf62U5jaVEfbkBKu7cts+UOhr4gLQG13vLqaegY3tz
 7M1ZWHKHrwgiSDYfN1LDM16YrkhCh7XIHeODITghPn04x30bwBX10QZmJ/YOUWnGBzCAU8Kp
 SgvwYNIirZc2gLfoRRQ8/9D2Mqw=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-east-1.postgun.com with SMTP id
 5f67a538f1e3eb89c7b39fd9 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sun, 20 Sep 2020 18:53:44
 GMT
Sender: alokad=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 311DAC433C8; Sun, 20 Sep 2020 18:53:44 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: alokad)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id CBC7AC433CA;
        Sun, 20 Sep 2020 18:53:43 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Sun, 20 Sep 2020 11:53:43 -0700
From:   Aloka Dixit <alokad@codeaurora.org>
To:     Arend Van Spriel <arend.vanspriel@broadcom.com>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org,
        linux-wireless-owner@vger.kernel.org
Subject: Re: [PATCH] mac80211: Fix radiotap header channel flag for 6GHz band
In-Reply-To: <1cada267-3ebf-0bac-328a-3abe2c16cd25@broadcom.com>
References: <010101747ab7b9c0-45fa1c2a-3bb5-44e8-8e6d-457cad2e9845-000000@us-west-2.amazonses.com>
 <1cc7242cd00cd5141a56f17a7f5c80700485aa39.camel@sipsolutions.net>
 <010101747eef4d8b-8b5fdae5-790f-4d19-a2df-fba00350baa3-000000@us-west-2.amazonses.com>
 <9f992ca7731f966fdc45a38a13c202898e92f2b2.camel@sipsolutions.net>
 <1cada267-3ebf-0bac-328a-3abe2c16cd25@broadcom.com>
Message-ID: <eb68b253912675a3e4705ad942ce07d8@codeaurora.org>
X-Sender: alokad@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2020-09-14 02:14, Arend Van Spriel wrote:
> On 9/11/2020 10:52 PM, Johannes Berg wrote:
>> On Fri, 2020-09-11 at 20:50 +0000, Aloka Dixit wrote:
>>> 
>>>> Not that anything even cares ... so there's no point in adding a 
>>>> 6GHz
>>>> flag to radiotap.
>>>> 
>>> Separate flag for 6GHz would have been best option, but I still think
>>> better to set 5GHz as 6GHz frequencies start in 5GHz range.
>> 
>> But why? wireshark probably needs to be adjusted anyway, so it can 
>> just
>> look at the frequency instead? And it would pretend that it's now an
>> "11a" frame ... so that clearly never was important, since that hasn't
>> been true since HT.
> 
> It has been couple of month ago that I looked into wireshark about
> this and I think it is already ignoring the band flags and just looks
> at the frequency.
> 
> Regards,
> Arend
Ok, thanks for letting me know!
