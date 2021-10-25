Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C153143912B
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Oct 2021 10:27:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231685AbhJYI3w (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 25 Oct 2021 04:29:52 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:50958 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231519AbhJYI3o (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 25 Oct 2021 04:29:44 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1635150442; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=3oQbzqRRdL8+x0aQm5Jf5ctmhHZ6BiFyGzG+UwXMaQ4=;
 b=vDN+HFbkdjAEPUjUnVmY3NHNDtJBvPX2RolBJdaV7af/6elHi5G/T6sNElFawR5ezCQ/zfoQ
 LIfvfHIpC3ag4pePo35aD/2Jy969R2vPS/zQlNap9QBNBs2+Llj4uUO+Q6RocxNN+eXGiErU
 9y1r5VIBCTW2XdroK/v9QKHhBc8=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-west-2.postgun.com with SMTP id
 61766a5cfd91319f0f13a6bf (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 25 Oct 2021 08:27:08
 GMT
Sender: vjakkam=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id AD12AC43616; Mon, 25 Oct 2021 08:27:08 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: vjakkam)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 34D97C4360C;
        Mon, 25 Oct 2021 08:27:07 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 25 Oct 2021 13:57:07 +0530
From:   vjakkam@codeaurora.org
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org
Subject: Re: [PATCH] nl80211: Indicate SA Query procedures offload for AP SME
 device
In-Reply-To: <69995d6c767edcea15ef7645fabc0e39c0dc7960.camel@sipsolutions.net>
References: <1634210331-9001-1-git-send-email-vjakkam@codeaurora.org>
 <612e80125878bae6fccbb72701381832a8a6029c.camel@sipsolutions.net>
 <5a1f654e3406e99c816afbc762519fea@codeaurora.org>
 <69995d6c767edcea15ef7645fabc0e39c0dc7960.camel@sipsolutions.net>
Message-ID: <7c5b87329c58ac2b68329573f587f8d7@codeaurora.org>
X-Sender: vjakkam@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2021-10-22 18:59, Johannes Berg wrote:
> On Fri, 2021-10-22 at 18:56 +0530, vjakkam@codeaurora.org wrote:
>> >
>> > So how's that going to work with older hostapd? It'll be offloaded, and
>> > then hostapd doesn't know, so it's still going to disconnect them?
>> >
>> > So should be that hostapd also opts in to this driver behaviour?
>> 
>> yes, we have to update hostapd also with new implementation based on 
>> the
>> feature flag.
> 
> That wasn't my question. My question was what happens if you have a
> hostapd that's *not* updated?>
> 
> johannes

Apologies for not clear answer in my previous reply.
Yes, If hostapd is not updated, it's going to disconnect the STAs.

We should update hostapd also to opt in this driver behavior.

Thanks,
Veeru
