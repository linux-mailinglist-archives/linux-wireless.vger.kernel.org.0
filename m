Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40E49271741
	for <lists+linux-wireless@lfdr.de>; Sun, 20 Sep 2020 20:59:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726326AbgITS7b (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 20 Sep 2020 14:59:31 -0400
Received: from z5.mailgun.us ([104.130.96.5]:50157 "EHLO z5.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726109AbgITS7a (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 20 Sep 2020 14:59:30 -0400
X-Greylist: delayed 300 seconds by postgrey-1.27 at vger.kernel.org; Sun, 20 Sep 2020 14:58:45 EDT
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1600628370; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=oGEonII4FIS7LE9LbWPAeoI26SF/+y+2ZTbpb9fIRh4=;
 b=Iw2A29NMlro4iM56ZrEvKIijZSDAsfk1jDIf68dPMGnmr29B64XhlLeT6Fsxx8dci/DVX8/6
 k1M+EEcuK8NPu74/YQafoPNxthe9Sqm7UcjZe/KE47O4cVGBvjUq91zcGNNC+6JiwjU9c+MI
 S4QbbM/tIBb1a+ixwxczoW+h1jU=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-east-1.postgun.com with SMTP id
 5f67a68ffda7475ccaf1376a (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sun, 20 Sep 2020 18:59:27
 GMT
Sender: alokad=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id A5167C433F1; Sun, 20 Sep 2020 18:59:26 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: alokad)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 52FFCC433CB;
        Sun, 20 Sep 2020 18:59:26 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Sun, 20 Sep 2020 11:59:26 -0700
From:   Aloka Dixit <alokad@codeaurora.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org
Subject: Re: [RFC] mac80211: Add radiotap channel flag option for 6GHz band
In-Reply-To: <87zh5v1pv4.fsf@tynnyri.adurom.net>
References: <010101747ee4b985-86863ec8-33e2-4f78-9d9b-93110bfa29fc-000000@us-west-2.amazonses.com>
 <5225561f9f5c104bc84ab6e7f183de0ab5e0ea6d.camel@sipsolutions.net>
 <010101747eea64fa-83d17384-b161-40d6-8b9d-9dd3bbbe89b4-000000@us-west-2.amazonses.com>
 <87zh5v1pv4.fsf@tynnyri.adurom.net>
Message-ID: <0d0174377e9aa0e7be118a8dca6826eb@codeaurora.org>
X-Sender: alokad@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2020-09-11 23:16, Kalle Valo wrote:
> Aloka Dixit <alokad@codeaurora.org> writes:
> 
>> On 2020-09-11 13:39, Johannes Berg wrote:
>>> On Fri, 2020-09-11 at 20:39 +0000, Aloka Dixit wrote:
>>>> Radiotap header needs a new channel flag for 6GHz packets.
>>>> This change uses value 0x200 for new enum balue for 6GHz which was
>>>> previously used for passsive scan flag but has since been removed.
>>> 
>>> You can't just add to radiotap in a kernel patch ...
>>> 
>>> But also, just today I replied elsewhere saying that we don't really
>>> need a flag at all?
>>> 
>>> johannes
>> 
>> Somehow your reply to other patch didn't show up on the patchwork,
>> don't know why :-)
> 
> Oh, this is making me worry. I do see Johannes' reply on the list:
> 
> https://lore.kernel.org/linux-wireless/1cc7242cd00cd5141a56f17a7f5c80700485aa39.camel@sipsolutions.net/
> 
> But like you said, there's still nothing on the patchwork (even after 
> 23h):
> 
> https://patchwork.kernel.org/patch/11769643/
> 
> I hope this is just a temporary glitch, but if this happens again 
> please
> do let me know about any patchwork problems. It will create major
> problems for us if patchwork starts losing mail.

This is still happening, even your reply did not show up on the RFC 
patch here:
https://patchwork.kernel.org/patch/11771491/
