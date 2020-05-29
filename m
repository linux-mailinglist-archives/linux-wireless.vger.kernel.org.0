Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A14E71E7C97
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2020 14:08:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725901AbgE2MIc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 29 May 2020 08:08:32 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:39915 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725306AbgE2MIc (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 29 May 2020 08:08:32 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1590754111; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=8xuvR982bnU6m6GAGHLs7wKJ9EtdhNc3NsS2kBxFMuE=;
 b=JSKhOPJ4xhofUoPl3jS9j7yPyFH3O6pBHzWa40seMm9Ed4wEIEUvN/u6PEjB8TON1gBhGZq3
 2iUnH9UvRQRRMq+fGzt9WX85jFYKvMumRcDhlLg5TmuBa05Wf5pxn5qs+DWD/E0KR5Iz10RX
 iSs9jKFvulCnxEeSRSJIKFaqpJ4=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-west-2.postgun.com with SMTP id
 5ed0fb3237a454afcb6ccc74 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 29 May 2020 12:08:18
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 10953C433CB; Fri, 29 May 2020 12:08:18 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: murugana)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id AAC60C433C9;
        Fri, 29 May 2020 12:08:17 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 29 May 2020 17:38:17 +0530
From:   Sathishkumar Muruganandam <murugana@codeaurora.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH 1/2] mac80211: enable TKIP when using encapsulation
 offloading
In-Reply-To: <d4e39180f0a8a8b07dc558c9439b66cd2c3aec07.camel@sipsolutions.net>
References: <1587720951-9222-1-git-send-email-murugana@codeaurora.org>
 <1587720951-9222-2-git-send-email-murugana@codeaurora.org>
 (sfid-20200424_113624_468114_4CC488DE)
 <d4e39180f0a8a8b07dc558c9439b66cd2c3aec07.camel@sipsolutions.net>
Message-ID: <7fb606edf1e5c7ab5b1446d637768ee7@codeaurora.org>
X-Sender: murugana@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2020-05-26 18:14, Johannes Berg wrote:
> On Fri, 2020-04-24 at 15:05 +0530, Sathishkumar Muruganandam wrote:
>> TKIP was disabled on encap offload mode since if TKIP MIC error
>> reporting is not capable by the driver using encap offload mode,
>> then TKIP countermeasures wont work.
>> 
>> Enabling back TKIP bring-up in encap offload mode to leave the
>> control with the driver to disable hw encap when it is not capable
>> of TKIP MIC error reporting.
> 
> So how can the driver do TKIP MIC error reporting?
> 
> I don't think it can. It doesn't have all the necessary information to
> call cfg80211_michael_mic_failure(), as far as I can tell.

Ath11k HW has capability of reporting TKIP MIC error when hw encap is 
enabled as well, so TKIP encryption shall be enabled.

> 
> I'm not applying this until I see at least the *ability* for drivers to
> do it. I mean, I don't really want to worry about your driver's
> correctness, but if you then turn around and realize that you *cannot*
> actually implement the right behaviour, that's no good either.
> 

Shall we have a ieee80211_hw_flags for the driver to advertise TKIP MIC 
error reporting capability when hw encap is enabled ?
TKIP bring-up will be disabled for the drivers which doesn't have the 
capability.

--
Sathishkumar
