Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 82B481408F8
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Jan 2020 12:33:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726812AbgAQLdt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 17 Jan 2020 06:33:49 -0500
Received: from mail25.static.mailgun.info ([104.130.122.25]:23554 "EHLO
        mail25.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726371AbgAQLdt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 17 Jan 2020 06:33:49 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1579260828; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=Z8+3qloo3rLEuH13odRJ1spLCuP0K9ycA0JSMC8xg1Q=;
 b=FHWO4xa3RMtd5YKcXoLbTRTS6FR85yBzjWhhg7NAJ5TJGkm8I2er7K7bwHJ6q4sq8cwQGfjd
 YbXXIBFJlwZwCyF1oa+8fuhK7kDwQwbQYI3pHtHcEpPn4gbtmrvW4LHO5HmPaIFDg4VrqyqR
 A3oR8SO7jQObY4Hn9W5VOPM8/F8=
X-Mailgun-Sending-Ip: 104.130.122.25
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e219b99.7f9647035228-smtp-out-n01;
 Fri, 17 Jan 2020 11:33:45 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 99BEDC433CB; Fri, 17 Jan 2020 11:33:45 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED autolearn=ham
        autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: vjakkam)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6DFD8C43383;
        Fri, 17 Jan 2020 11:33:45 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 17 Jan 2020 17:03:45 +0530
From:   vjakkam@codeaurora.org
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org
Subject: Re: [PATCH] cfg80211: Enhance the AKM advertizement to support per
 interface.
In-Reply-To: <de5fdc38a085de022f75a23883d9e498e5123e88.camel@sipsolutions.net>
References: <20191223185255.1009-1-vjakkam@codeaurora.org>
 (sfid-20191223_195313_440449_C90A4A92)
 <de5fdc38a085de022f75a23883d9e498e5123e88.camel@sipsolutions.net>
Message-ID: <59798c5a3489b4b2254e04c93104a6d2@codeaurora.org>
X-Sender: vjakkam@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2020-01-02 19:15, Johannes Berg wrote:
> On Tue, 2019-12-24 at 00:22 +0530, Veerendranath Jakkam wrote:
>> 
>> @@ -4587,9 +4598,6 @@ struct wiphy {
>>  	int n_cipher_suites;
>>  	const u32 *cipher_suites;
>> 
>> -	int n_akm_suites;
>> -	const u32 *akm_suites;
> 
> Certainly this also breaks compiling a large number of drivers... ???
> 
> johannes

Thanks, I will correct in v2
