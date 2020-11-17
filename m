Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D37372B5E34
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Nov 2020 12:24:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727940AbgKQLXd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 17 Nov 2020 06:23:33 -0500
Received: from z5.mailgun.us ([104.130.96.5]:26165 "EHLO z5.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727814AbgKQLXc (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 17 Nov 2020 06:23:32 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1605612212; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=/nBFgKD2bJFMbV0ZsU+vDy7WtK2/bGU0SK7Mac8HD9s=;
 b=tURE0AmWkNOCFHbJLOSSm2r+GiJ5uakTRVWAq1EjUJrMuNYmnHJvmcLpSh45swZ4xAx0EXZW
 SalGkQwcDv1mrxeB/ANYIaDCnr33CUldwUdKDZS3WAnQNWLaniOyvUNwlu4dlddF3BCRoMVW
 aFRP3/hzT1doKTrafrhGQFU5sNo=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n10.prod.us-west-2.postgun.com with SMTP id
 5fb3b2b4ba0e43f35526382e (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 17 Nov 2020 11:23:32
 GMT
Sender: vnaralas=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 365FEC43466; Tue, 17 Nov 2020 11:23:32 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: vnaralas)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 79D44C43462;
        Tue, 17 Nov 2020 11:23:31 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 17 Nov 2020 16:53:31 +0530
From:   vnaralas@codeaurora.org
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        Arend Van Spriel <arend.vanspriel@broadcom.com>,
        linux-wireless@vger.kernel.org, ath11k@lists.infradead.org
Subject: Re: [PATCHv2 1/2] nl80211: vendor-cmd: qca: add command for ap power
 save
In-Reply-To: <60c779b7c17b8ea40c2bba08d8fca98e83581580.camel@sipsolutions.net>
References: <1598257589-19091-1-git-send-email-vnaralas@codeaurora.org>
 <4b4a0d79a243c1c3b8044730da0493c96ba294bf.camel@sipsolutions.net>
 <871rilf2th.fsf@codeaurora.org>
 <dbaa655c3f15f800f73b7c19f2b1a054@codeaurora.org>
 <87eelr1oq9.fsf@codeaurora.org>
 <f6c148a3-73de-1481-5f63-2deecb599468@broadcom.com>
 <81ced18ac5b87a17cf31797cf91669bc@codeaurora.org>
 <87sg9rtugu.fsf@codeaurora.org>
 <60c779b7c17b8ea40c2bba08d8fca98e83581580.camel@sipsolutions.net>
Message-ID: <83bafd0a110106096110afd24b8e1304@codeaurora.org>
X-Sender: vnaralas@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2020-11-06 16:11, Johannes Berg wrote:
> On Mon, 2020-11-02 at 21:44 +0200, Kalle Valo wrote:
>> vnaralas@codeaurora.org writes:
>> 
>> > On 2020-10-22 13:30, Arend Van Spriel wrote:
>> > > On 10/21/2020 7:19 PM, Kalle Valo wrote:
>> > > > vnaralas@codeaurora.org writes:
>> > > >
>> > > > > On 2020-09-29 13:10, Kalle Valo wrote:
>> > > > > > Johannes Berg <johannes@sipsolutions.net> writes:
>> > > > > >
>> > > > > > > On Mon, 2020-08-24 at 13:56 +0530, Venkateswara Naralasetty wrote:
>> > > > > > > > AP power save feature is to save power in AP mode, where AP goes
>> > > > > > > > to power save mode when no stations associate to it and comes out
>> > > > > > > > of power save when any station associate to AP.
>> > > > > > >
>> > > > > > > Why do you think this requires a vendor command? I mean, that seems
>> > > > > > > like
>> > > > > > > fairly reasonable - even by default - behaviour?
>> > > > > >
>> > > > > > I have not studied the details, but doesn't AP power save break
>> > > > > > normal
>> > > > > > functionality? For example, I would guess probe requests from
>> > > > > > clients
>> > > > > > would be lost. So there's a major drawback when enabling this,
>> > > > > > right?
>> > > > >
>> > > > > This AP power save feature will not break any functionality, Since
>> > > > > one
>> > > > > chain is always active and all other chains will be disabled when
>> > > > > this
>> > > > > feature is enabled. AP can still be able to beacon and receive probe
>> > > > > request from the clients. The only drawback is reduced network range
>> > > > > when this feature is enabled. Hence, we don't want to enable it by
>> > > > > default.
>> > > >
>> > > > Yeah, we really would not want to enable that by default. But what
>> > > > should be the path forward, a vendor command or a proper nl80211
>> > > > command? Any opinions?
>> > >
>> > > I would go for a proper nl80211 command or just add an attribute for
>> > > use in NL80211_CMD_START_AP or deal with NL80211_CMD_SET_POWERSAVE
>> > > when operating in AP mode.
>> > >
>> > Sure, I will go with the existing NL80211_CMD_SET_POWERSAVE and I will
>> > send next version.
>> 
>> Better to wait first so that we have concensus on this. And need to
>> check if NL80211_CMD_SET_POWERSAVE is even suitable for AP mode.
> 
> I suspect that SET_POWERSAVE might be confusing.
> 
> Perhaps just with an attribute used in START_AP (and CHANGE_BEACON if
> needed) would be sufficient?

Actually this ap power save configuration is applicable for per pdev. 
So, I don't think we can use START AP command here.
I would prefer to go with a new NL80211 command. Please share your 
thoughts on this.


> 
> johannes
