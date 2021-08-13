Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16DC83EB408
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Aug 2021 12:29:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240125AbhHMKaA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 13 Aug 2021 06:30:00 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:47603 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239277AbhHMKaA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 13 Aug 2021 06:30:00 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1628850573; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=JMbb3u1CBTlERu7OfhgTVF+ONjo8s0o9ICBhT6ODPf8=;
 b=WWcUA1B37+YFbyT0x+G056pUv/MDLG8b/inJtjLP7O7Ul+n5Mnge2lLC9xH7IbtU1MNlVUBL
 aAZ2zgllbNPxxXhA96lKSP0w4zkq8uU3EeEKfrupg3N+C2H1TIfNuG9rQEB5vqT85p+fJZH1
 jRmel48T3cI6XQzxOUwd9magIKU=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-east-1.postgun.com with SMTP id
 6116498c66ff1079042e4b53 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 13 Aug 2021 10:29:32
 GMT
Sender: wgong=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id C6093C433D3; Fri, 13 Aug 2021 10:29:31 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: wgong)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 48B69C4338A;
        Fri, 13 Aug 2021 10:29:31 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 13 Aug 2021 18:29:31 +0800
From:   Wen Gong <wgong@codeaurora.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH 9/9] mac80211: save transmit power envelope element and
 power constraint
In-Reply-To: <569d85aec8fecc836b5a6f9d40b53dff6e41c1b1.camel@sipsolutions.net>
References: <20210517201932.8860-1-wgong@codeaurora.org>
 <20210517201932.8860-10-wgong@codeaurora.org>
 (sfid-20210517_222034_029448_A9A89D57)
 <d9491db4ece67ac78eb39a1078b91a106770fbb0.camel@sipsolutions.net>
 <1126f8d996e895ae048092b3f8aad19b@codeaurora.org>
 <38e7d9d2eebafa7245a36a0a0396094526eb3efd.camel@sipsolutions.net>
 <1273cc1a399a7457c3d908648a7651c8fe9b93f3.camel@sipsolutions.net>
 <a056e32d4911400fb0822bf02167e91c@codeaurora.org>
 <f61cdc7bae2dd2a645e164ca143b9db402472559.camel@sipsolutions.net>
 <465b6b8535fc17ae51ee2f3116af87bb@codeaurora.org>
 <569d85aec8fecc836b5a6f9d40b53dff6e41c1b1.camel@sipsolutions.net>
Message-ID: <24bcb0c5da824f830f31328781c634b9@codeaurora.org>
X-Sender: wgong@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2021-08-13 18:11, Johannes Berg wrote:
> On Fri, 2021-08-13 at 17:16 +0800, Wen Gong wrote:
>> 
>> yes, it should have some flag/logic to check whether it is BIGTK.
>> If you know it, you can tell me. :)
> 
> Uh, actually, we don't have a secure indication of BIGTK getting used
> until after the 4-way-HS.
> 
>> >
>> Yes, the lower driver also have the max power limit itself. If power
>> calulated
>> from the fake beacon is bigger than the max power limit, then it will 
>> be
>> ignored.
> 
> Right.
> 
>> >
>> The Transmit Power Envelope is not existed in the assoc response, it 
>> is
>> existed
>> in beacon. So it can not use assoc response.
> 
> Right.
> 
> 
> Given this discussion, I think we should just leave it as is, and 
> simply
> not assume that the TPE is protected by beacon protection or such. 
> There
> are a number of other similar parameters, and doing some real 
> protection
> at this level would likely require further spec changes.
> 
Thanks.
I will leave it as is without change for BIGTK.
I will change others patch and send new version.
> johannes
