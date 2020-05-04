Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F4201C4A9D
	for <lists+linux-wireless@lfdr.de>; Tue,  5 May 2020 01:52:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728278AbgEDXw5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 4 May 2020 19:52:57 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:54474 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728182AbgEDXw5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 4 May 2020 19:52:57 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1588636376; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=W+xBFP8RMJ4u9yTMXqLo5r5356v0vha2BJ3QKZbB5RQ=;
 b=uDvu9gy1FpTtL94fnZhf/Vgd5o2uloVAUdn7IYH1onTEhM9sAi8nv0s7QDzXkEwH75xXHYA8
 SN82Kjok3M5BWn4HDY1qOTrCqswuijiMfprNn5cVRffd8MiMiCuIQboHJfOb2pU3cQNMu7Xz
 nZ9Oj42JFSJjAAfbP/IrXfYeGBQ=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5eb0aacf.7f1e7b3735e0-smtp-out-n02;
 Mon, 04 May 2020 23:52:47 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 1C111C433CB; Mon,  4 May 2020 23:52:46 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: rmanohar)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 96F74C433D2;
        Mon,  4 May 2020 23:52:45 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 04 May 2020 16:52:45 -0700
From:   Rajkumar Manoharan <rmanohar@codeaurora.org>
To:     Ben Greear <greearb@candelatech.com>
Cc:     Markus Theil <markus.theil@tu-ilmenau.de>,
        linux-wireless-owner@vger.kernel.org,
        linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        kvalo@codeaurora.org, ath11k@lists.infradead.org
Subject: Re: [PATCH 1/2] ath10k: use cumulative survey statistics
In-Reply-To: <323b4d4f-a967-cf63-6f5a-04f53802c50a@candelatech.com>
References: <20200504154122.91862-1-markus.theil@tu-ilmenau.de>
 <f772b7bf0eac31516a4e28719c1938f2@codeaurora.org>
 <323b4d4f-a967-cf63-6f5a-04f53802c50a@candelatech.com>
Message-ID: <4b03993ba81a8e9ebb1203c0b8aa90f6@codeaurora.org>
X-Sender: rmanohar@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2020-05-04 16:49, Ben Greear wrote:
> On 05/04/2020 04:46 PM, Rajkumar Manoharan wrote:
>> On 2020-05-04 08:41, Markus Theil wrote:
>>> ath10k currently reports survey results for the last interval between 
>>> each
>>> invocation of NL80211_CMD_GET_SURVEY. For concurrent invocations, 
>>> this
>>> can lead to unexpectedly small results, e.g. when hostapd uses survey
>>> data and iw survey dump is invoked in parallel. Fix this by returning
>>> cumulative results, that don't depend on the last invocation. Other
>>> drivers, e.g. ath9k or mt76 also use this behavior.
>>> 
>>> Signed-off-by: Markus Theil <markus.theil@tu-ilmenau.de>
>>> 
>> 
>> IIRC this was fixed a while ago by below patch. Somehow it never 
>> landed in ath.git.
>> Simple one line change is enough.
>> 
>> https://patchwork.kernel.org/patch/10550707/
>> 
>> -Rajkumar
> 
> Have you tested this with wave-1?  Lots of older, at least, firmware
> has brokenness in this area.
> 
Yes. It was tested in wave-1 as well. Venkat replied to your comment on 
original change.

-Rajkumar
