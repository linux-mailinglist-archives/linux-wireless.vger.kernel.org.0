Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 542263DB723
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Jul 2021 12:28:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238396AbhG3K2O (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 30 Jul 2021 06:28:14 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:62130 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238274AbhG3K2N (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 30 Jul 2021 06:28:13 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1627640889; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=J1V0sxXmiVZC4oOGGO4PUc8fsmDPnaErViXC0bbs0Fs=;
 b=ouw6M11Jm8OJF6ltHkUxPZHnUqzW+OJVQEtS99gUBDITIvNC9ob7LrQhLnl1IKT6F6dRILuD
 7c5PXMezqCXi6ciCqhNoCEWz5bxWDEPNmtI4y8JpQnyOKYuJxFWFvv4YVfDNcZQPJadhFXHS
 utdFfkk/OkJVU8F7Je7YgW47Dqs=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-west-2.postgun.com with SMTP id
 6103d42f9771b05b2475eba0 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 30 Jul 2021 10:27:59
 GMT
Sender: wgong=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 05110C4323A; Fri, 30 Jul 2021 10:27:59 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: wgong)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A1BEBC433D3;
        Fri, 30 Jul 2021 10:27:58 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Fri, 30 Jul 2021 18:27:58 +0800
From:   Wen Gong <wgong@codeaurora.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH 6/9] mac80211: add definition for transmit power envelope
 element
In-Reply-To: <a8c4be501b85bcfe478d9597f4d6f90b2887c57c.camel@sipsolutions.net>
References: <20210517201932.8860-1-wgong@codeaurora.org>
 <20210517201932.8860-7-wgong@codeaurora.org>
 (sfid-20210517_222029_289940_80C21857)
 <a8c4be501b85bcfe478d9597f4d6f90b2887c57c.camel@sipsolutions.net>
Message-ID: <6d287d059a598c54d9932cd66328f1c3@codeaurora.org>
X-Sender: wgong@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2021-07-23 17:31, Johannes Berg wrote:
> On Mon, 2021-05-17 at 16:19 -0400, Wen Gong wrote:
>> 
>> 
>> +#define IEEE80211_TPE_MAX_IE_COUNT	8
> 
> Is this actually a spec limit?
> 
> johannes

Yes,
In "9.4.2.161 Transmit Power Envelope element" of "IEEE Std 
802.11ax™‐2021",
It show 4 types in "Table 9-275a—Maximum Transmit Power Interpretation 
subfield encoding".
And it has 2 category for each type in "Table E-12—Regulatory Info 
subfield encoding in the United States".
So it it totally 8.
