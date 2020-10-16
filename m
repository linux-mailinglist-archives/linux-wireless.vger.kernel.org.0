Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4AEF290C27
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Oct 2020 21:18:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393089AbgJPTSD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 16 Oct 2020 15:18:03 -0400
Received: from z5.mailgun.us ([104.130.96.5]:39625 "EHLO z5.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393083AbgJPTSD (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 16 Oct 2020 15:18:03 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1602875882; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=c0qImR3aS51OWLLNWRbi22/6G+2tCrsJXNPTGoTIJIE=;
 b=QvhuOl2k4ANDCqjbitN1H0mIZ7e1Jya8a2iQSSJnoLbua7FIlWOgIQSRt4sySam7IWw7a7Tr
 OQqxKz9nSfEvENGkeoZUfsJCP1GzMHMxSqr99zwlKTCWHWENQQAe5F8siH2kmS+AhVVqs12Y
 waeVtO17zCCdxlZAk1kRK569zm4=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-east-1.postgun.com with SMTP id
 5f89f1d6bfed2afaa6e866ed (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 16 Oct 2020 19:17:42
 GMT
Sender: rmanohar=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id B1726C433F1; Fri, 16 Oct 2020 19:17:41 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: rmanohar)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 68A0CC433CB;
        Fri, 16 Oct 2020 19:17:41 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 16 Oct 2020 12:17:41 -0700
From:   Rajkumar Manoharan <rmanohar@codeaurora.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org
Subject: Re: [PATCH v2] cfg80211: add support to configure HE MCS for beacon
 rate
In-Reply-To: <7b0080517b301ccd32d03b25b2f16663238959df.camel@sipsolutions.net>
References: <1601762257-14934-1-git-send-email-rmanohar@codeaurora.org>
 <e5b99d2b7215841b184ddcec5ca8498f27795547.camel@sipsolutions.net>
 (sfid-20201008_110659_738848_40D7EFF9)
 <7b0080517b301ccd32d03b25b2f16663238959df.camel@sipsolutions.net>
Message-ID: <21941d6526fa00b9f8e0787537b963b3@codeaurora.org>
X-Sender: rmanohar@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2020-10-08 02:09, Johannes Berg wrote:
> On Thu, 2020-10-08 at 11:06 +0200, Johannes Berg wrote:
>> On Sat, 2020-10-03 at 14:57 -0700, Rajkumar Manoharan wrote:
>> > This allows an option to configure a single HE MCS beacon tx rate.
>> >
>> > Signed-off-by: Rajkumar Manoharan <rmanohar@codeaurora.org>
>> > ---
>> > v2: clear mcs ratemask when beacon tx rate is not set.
>> 
>> I can't believe I didn't realize this before, but ...
> 
> Never mind that comment ... it wasn't there before, I was confused :)
> 
No worries. :)

>> I mean, why not just skip the
>> 
>>         /* Default to all rates enabled */
>>         for (i = 0; i < NUM_NL80211_BANDS; i++) {
>> 		[...]
>> 	}
>> 
>> code? Right now you're first setting it, and then clearing it again 
>> when
>> is_beacon_tx_rate is set ...
>> 
>> 
>> I'd prefer a "default_all_enabled" parameter, and then call the above
>> loop conditionally on it (perhaps moving it to a separate function to
>> not have all the deep indentation to worry about).
> 
> And maybe that should be a separate patch.
> 
Neat.. Will split the patch and send a new series.

-Rajkumar
