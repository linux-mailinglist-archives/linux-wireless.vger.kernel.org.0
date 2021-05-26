Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8175B39199F
	for <lists+linux-wireless@lfdr.de>; Wed, 26 May 2021 16:13:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233376AbhEZOPO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 26 May 2021 10:15:14 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:45385 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233313AbhEZOPO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 26 May 2021 10:15:14 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1622038422; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=n6PHiisgHgQlDORx6QefX5AK85Ela8tk1Mj69iUrWqM=;
 b=VSu9lcfeezENP8f6cPwUPSW5kSavZ9upAVwPS3cAjtsoxbh0l6Fl99lLZsgoUAqy9HMCRBW1
 vpwMHjFWs77RRR0DiSzhVN7ZACdIaMSTXIKvAeiaM3xqRIZjmDCYRrHWVcX4MGNbBxGNZq5L
 lpzpL1z2ay8Ql1uSMBjW2HXmeI4=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-east-1.postgun.com with SMTP id
 60ae5796ceebd0e93289384b (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 26 May 2021 14:13:42
 GMT
Sender: mkenna=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 460F6C43217; Wed, 26 May 2021 14:13:41 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: mkenna)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D8827C433F1;
        Wed, 26 May 2021 14:13:40 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 26 May 2021 19:43:40 +0530
From:   Maharaja Kennadyrajan <mkenna@codeaurora.org>
To:     Sven Eckelmann <sven@narfation.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH v2 0/3] Add support to configure beacon tx mode
In-Reply-To: <4581459.tLtf2NohVe@ripper>
References: <1619696874-30072-1-git-send-email-mkenna@codeaurora.org>
 <4581459.tLtf2NohVe@ripper>
Message-ID: <4038b2868605da158392bd4c65d10c66@codeaurora.org>
X-Sender: mkenna@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2021-04-30 12:45, Sven Eckelmann wrote:
> On Thursday, 29 April 2021 13:47:51 CEST Maharaja Kennadyrajan wrote:
> [...]
>> Beacons can be sent out in burst(continuously in a single shot
>> one after another) or staggered (equally spread out over beacon
>> interval) mode.
>> 
>> V2:
>> 	Addressed Johannes's comment on v1 patch.
>> 	Updated the commit log.
> 
> Still it is advertised as vif setting but the code itself shows that it 
> is a
> phy setting (as you would expect). Or is it a potential feature for a 
> device
> to send some beacons staggered and some beacons as burst?

[Maha]: No, it won't allow to send some beacons in staggered and some 
beacons in burst
mode. It will send either staggered or burst mode at a time in a device.

> Kind regards,
> 	Sven
