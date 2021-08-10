Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE4F33E557E
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Aug 2021 10:33:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238459AbhHJIdQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 10 Aug 2021 04:33:16 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:18525 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236133AbhHJIdB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 10 Aug 2021 04:33:01 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1628584359; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=Vdw6tPm4oPokrFtxSREvD0rum2LAN2Ai75BjwbZLPCQ=;
 b=rBEbWhYcwO3b26P1Eu87AzV1T3jFVBA4OPv9P2ql3DoCihGs6wtWk3RUROxJT7Pefaqzw0VJ
 n660olWVZawzE6cq9GoFbdX8tpVWqK0o/X2pt4dRrasCp33m94U+B4jQnuFfTI8OM7kNTDi0
 DVVYQmYr7HRobJQdydGRa40UM/8=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-west-2.postgun.com with SMTP id
 611239a6f746c298d9fc4c6b (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 10 Aug 2021 08:32:38
 GMT
Sender: mkenna=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 06517C4161F; Tue, 10 Aug 2021 08:32:37 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: mkenna)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id BE660C43144;
        Tue, 10 Aug 2021 08:32:36 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 10 Aug 2021 14:02:36 +0530
From:   Maharaja Kennadyrajan <mkenna@codeaurora.org>
To:     Felix Fietkau <nbd@nbd.name>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH v4 1/3] nl80211: Add support for beacon tx mode
In-Reply-To: <0e3d0abd-a895-77d8-d3a6-ef6d2616b7db@nbd.name>
References: <1623164855-15910-1-git-send-email-mkenna@codeaurora.org>
 <1623164855-15910-2-git-send-email-mkenna@codeaurora.org>
 <f14e6e6b81978ace4580774981a7e032b4001182.camel@sipsolutions.net>
 <0e3d0abd-a895-77d8-d3a6-ef6d2616b7db@nbd.name>
Message-ID: <0430f508f293d0b5b0d82cc1da78284d@codeaurora.org>
X-Sender: mkenna@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2021-06-29 23:14, Felix Fietkau wrote:
> On 2021-06-23 13:16, Johannes Berg wrote:
>> First, I'd like to see some input from other vendors - is this useful?
>> 
>> I have no objections to it and it comes with an in-kernel driver, so 
>> I'm
>> inclined to accept it, but maybe we should have other modes, etc.?
> I haven't seen any config option like this outside of QCA stuff.
> It seems to me that before getting merged, the documentation should at
> least cover when and why the *user* would configure this implementation
> detail, instead of having the driver/fw make a reasonable decision on
> its own.
> 
> - Felix
[Maha]: I will do the documentation for this in the next version 
patchset.
