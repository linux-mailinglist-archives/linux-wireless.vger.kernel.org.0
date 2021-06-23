Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8984E3B1CC9
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Jun 2021 16:43:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230476AbhFWOpZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 23 Jun 2021 10:45:25 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:15017 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230392AbhFWOpX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 23 Jun 2021 10:45:23 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1624459386; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=8nS7uvAhBiL/5PAeFh5xwF2jqFe3gL8wNzd3Fwa7KW8=;
 b=sg/dO4tnJGz/2fpG1U5f0EX96MsxXNIZNM0fKgA9tb0xNzJKwL9XalSXF3+SmK8y0o970Aen
 kPeSPwrS2r3GAtNKFdO8LyFiamlwoAgdbTEJPFbWBXQ6C768jYvOl/O8Sw11PKBqBHGjhCc4
 4QKPif5iOiMKKySpc/PNNZYnMqI=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-east-1.postgun.com with SMTP id
 60d348645e3e57240b5e2461 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 23 Jun 2021 14:42:44
 GMT
Sender: akalaise=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 98FCBC433F1; Wed, 23 Jun 2021 14:42:43 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: akalaise)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3F6E8C433D3;
        Wed, 23 Jun 2021 14:42:39 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 23 Jun 2021 20:12:39 +0530
From:   Abinaya Kalaiselvan <akalaise@codeaurora.org>
To:     Nicolas Cavallari <Nicolas.Cavallari@green-communications.fr>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org
Subject: Re: [PATCHv2] mac80211: fix NULL ptr dereference during mesh peer
 connection for non HE devices
In-Reply-To: <717ff301-e29c-66d1-c0d7-5efd1b2415ba@green-communications.fr>
References: <1618483625-31097-1-git-send-email-akalaise@codeaurora.org>
 <f7ebb34a0c01b1652defa3929559997c9885c045.camel@sipsolutions.net>
 <717ff301-e29c-66d1-c0d7-5efd1b2415ba@green-communications.fr>
Message-ID: <95cff90ba7d4b69fb71fd59d202c2d67@codeaurora.org>
X-Sender: akalaise@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2021-06-15 19:47, Nicolas Cavallari wrote:
> On 19/04/2021 13:23, Johannes Berg wrote:
>> On Thu, 2021-04-15 at 16:17 +0530, Abinaya Kalaiselvan wrote:
>>> "sband->iftype_data" is not assigned with any value for non HE 
>>> supported
>>> devices, which causes NULL pointer access during mesh peer connection
>>> in those devices. Fix this by accessing the pointer after HE
>>> capabilities condition check.
>>> 
>>> Fixes: 7f7aa94bcaf0 (mac80211: reduce peer HE MCS/NSS to own 
>>> capabilities)
>>> Signed-off-by: Abinaya Kalaiselvan <akalaise@codeaurora.org>
>>> ---
>>> v2:
>>> * ieee80211_sta_he_cap structure instance is initialized.
>>> 
>> How about taking other feedback into account?
>> 
>> johannes
>> 
> 
> I got a crash because of this bug and this patch fixes it. Abinaya, do
> you plan to submit a version with the indentation fixed, or can I do
> it ?

Thanks Nicolas. I have sent the updated patch with indentation fix.

Thanks,
Abinaya Kalaiselvan
