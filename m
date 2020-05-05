Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEAFB1C5EE7
	for <lists+linux-wireless@lfdr.de>; Tue,  5 May 2020 19:32:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730215AbgEERcT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 5 May 2020 13:32:19 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:34474 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730184AbgEERcT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 5 May 2020 13:32:19 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1588699938; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=FNnEUcIGcED2zOGUrSu/QDzHYpQ9xz/VzkKxw++slEM=;
 b=L2nu+8qNH3xPQztASUbqmO6RN3A6sAdKix22dWG26C5Tyl31otR4AViuxx8hunYy6hMNScBH
 cLloHy7ypyDQFbX2to+udA6iRfMdQKFJmoUPbrxmGrsLJildk1xJYC2J8oop9dQHyo7NVz1V
 o7YA5ixPXJ+nrYEAWgQYWn93LEY=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5eb1a2de.7efd0eaad298-smtp-out-n02;
 Tue, 05 May 2020 17:31:10 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id C7CBCC433CB; Tue,  5 May 2020 17:31:10 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: rmanohar)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 592A3C433BA;
        Tue,  5 May 2020 17:31:10 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 05 May 2020 10:31:10 -0700
From:   Rajkumar Manoharan <rmanohar@codeaurora.org>
To:     Markus Theil <markus.theil@tu-ilmenau.de>
Cc:     linux-wireless-owner@vger.kernel.org,
        linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        kvalo@codeaurora.org, ath11k@lists.infradead.org
Subject: Re: [PATCH 2/2] ath11k: use cumulative survey statistics
In-Reply-To: <c786e982-fcd6-2368-6b2f-f09b265654d6@tu-ilmenau.de>
References: <20200504154122.91862-1-markus.theil@tu-ilmenau.de>
 <20200504154122.91862-2-markus.theil@tu-ilmenau.de>
 <85fa2d5f9183b3a12c5283b800f3750f@codeaurora.org>
 <c786e982-fcd6-2368-6b2f-f09b265654d6@tu-ilmenau.de>
Message-ID: <61f3dcc195fa4d877ddbd161523142ec@codeaurora.org>
X-Sender: rmanohar@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2020-05-04 23:53, Markus Theil wrote:
> Am 05.05.2020 um 01:37 schrieb Rajkumar Manoharan:
>> On 2020-05-04 08:41, Markus Theil wrote:
>>> ath11k currently reports survey results for the last interval between 
>>> each
>>> invocation of NL80211_CMD_GET_SURVEY. For concurrent invocations, 
>>> this
>>> can lead to unexpectedly small results, e.g. when hostapd uses survey
>>> data and iw survey dump is invoked in parallel. Fix this by returning
>>> cumulative results, that don't depend on the last invocation. Other
>>> drivers, e.g. ath9k or mt76 also use this behavior.
>>> 
[...]
>> Markus,
>> 
>> It depends on type of survey request is given to firmware. In ath11k, 
>> firmware reports
>> accumulated values. So the above addition is wrong and report double 
>> value. Have you
>> tested this change?
>> 
>> -Rajkumar
> Ok, so please drop both of my patches. My assumptions were incomplete
> and too humble. I just assumed, ath10k and ath11k both use incremental
> surveys.
> 
Markus,

The ath10k driver still counts survey stats incrementally. But it should 
be handled by sending
appropriate survey request_type to firmware.

-Rajkumar
