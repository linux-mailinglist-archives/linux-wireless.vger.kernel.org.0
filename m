Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B551E1E8075
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2020 16:40:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726928AbgE2Okp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 29 May 2020 10:40:45 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:48005 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726887AbgE2Oko (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 29 May 2020 10:40:44 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1590763244; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=BUj7s4pvc98qo3N86HPtbN3l58TciCtICok+8Pc6bMo=;
 b=r6rdg0Na9yWyvOEBJlUErYIKg2rVPF/6N9goCkAKs4WFET0PMfRCFMRe8qFk0j15r9R0ApmE
 x8ZtoTnSEZAZOF5VtEQ4q1m/JTTHDmWP4TDMfHGQlu1D0DPmpyNjvBeTKj4jTDkgOJ+kOI41
 XqEtlGaA2UBRjSDTEiYAeUa5pOs=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-east-1.postgun.com with SMTP id
 5ed11ee82c54998475acd235 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 29 May 2020 14:40:40
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 9B196C433CB; Fri, 29 May 2020 14:40:39 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: murugana)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4C5F2C433C6;
        Fri, 29 May 2020 14:40:38 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 29 May 2020 20:10:38 +0530
From:   Sathishkumar Muruganandam <murugana@codeaurora.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH 1/2] mac80211: enable TKIP when using encapsulation
 offloading
In-Reply-To: <f2b8fb0783b270a177ee900168fdc1fbc9253e3d.camel@sipsolutions.net>
References: <1587720951-9222-1-git-send-email-murugana@codeaurora.org>
 <1587720951-9222-2-git-send-email-murugana@codeaurora.org>
 (sfid-20200424_113624_468114_4CC488DE)
 <d4e39180f0a8a8b07dc558c9439b66cd2c3aec07.camel@sipsolutions.net>
 <7fb606edf1e5c7ab5b1446d637768ee7@codeaurora.org>
 <aaa53c3a9cf6788cb653eb574073a1a0bcc5e6bf.camel@sipsolutions.net>
 <4bab3197997bb2dd6555ff920c5dd1cb@codeaurora.org>
 <f2b8fb0783b270a177ee900168fdc1fbc9253e3d.camel@sipsolutions.net>
Message-ID: <92eddf5d153781b2698ad258aac2fbe4@codeaurora.org>
X-Sender: murugana@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2020-05-29 18:16, Johannes Berg wrote:
> On Fri, 2020-05-29 at 17:59 +0530, Sathishkumar Muruganandam wrote:
>> 
>> Yes, currently only tx encap support is added and rx decap support is 
>> in
>> progress to do TKIP MIC error reporting to userspace via
>> cfg80211_michael_mic_failure().
> 
> Yes, but can you actually call that? It requires a netdev. I don't 
> think
> you can easily get it from the vif?
> 

Yes, that's right. Currently the plan is to add new mac80211 api for rx 
decap where
we can call cfg80211_michael_mic_failure() and not called directly from 
driver.

Whether we can expose netdev to driver for doing such cfg80211 call ?

Thanks,
Sathishkumar
