Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD51B3AD846
	for <lists+linux-wireless@lfdr.de>; Sat, 19 Jun 2021 08:49:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233730AbhFSGwC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 19 Jun 2021 02:52:02 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:15010 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233725AbhFSGwB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 19 Jun 2021 02:52:01 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1624085391; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=KeG18jbZNALQyif+ToGJhZBzD7AAiN6vNQWpjqlIm4I=; b=bAa9E64UeWfq5gLWjnydL8kSF2s/W+jMucdBVPKdbmSo4UyQqhrSQH0fXqEMrXDrLeQdoLYy
 o45s4Op/LK7h7gEEfb9yC1aeJZ1VF9kiOjpGxYLDOvM6cjMUWitAjVbQ6l24jWrCcsxhqJfc
 jG+6QC3P6eiYZmsIY64iM9tHGYw=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-east-1.postgun.com with SMTP id
 60cd938e6ddc3305c49f8df1 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sat, 19 Jun 2021 06:49:50
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id A2F38C433F1; Sat, 19 Jun 2021 06:49:49 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from tykki (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0E183C433F1;
        Sat, 19 Jun 2021 06:49:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0E183C433F1
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Felix Fietkau <nbd@nbd.name>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>
Subject: Re: pull request: mt76 2021-06-18 v2
References: <771ad327-c637-ddaa-494c-bde1832eefec@nbd.name>
Date:   Sat, 19 Jun 2021 09:49:44 +0300
In-Reply-To: <771ad327-c637-ddaa-494c-bde1832eefec@nbd.name> (Felix Fietkau's
        message of "Fri, 18 Jun 2021 19:33:55 +0200")
Message-ID: <87im2aic1j.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Felix Fietkau <nbd@nbd.name> writes:

> Hi Kalle,
>
> here's an updated version of my first pull request for 5.14
>
> - Felix
>
> The following changes since commit 0c33795231bff5df410bd405b569c66851e92d4b:
>
>   Merge tag 'wireless-drivers-next-2021-06-16' of git://git.kernel.org/pub/scm/linux/kernel/git/kvalo/wireless-drivers-next (2021-06-16 12:59:42 -0700)
>
> are available in the Git repository at:
>
>   https://github.com/nbd168/wireless tags/mt76-for-kvalo-2021-06-18
>
> for you to fetch changes up to a7818339958c7d7940a102ccf88cf73260074344:
>
>   mt76: mt7921: allow chip reset during device restart (2021-06-18 19:22:10 +0200)
>
> ----------------------------------------------------------------
> mt76 patches for 5.14
>
> * mt7915 MSI support
> * disable ASPM on mt7915
> * mt7915 tx status reporting
> * mt7921 decap offload
> * driver fixes
> * cleanups
> * mt7921 runtime power management improvements
> * testmode improvements/fixes
> * runtime PM improvements
>
> ----------------------------------------------------------------

Almost there :) But one commit is missing your s-o-b:

----------------------------------------------------------------------
Commit

  7c649aa4de81 ("mt76: move mt76_rates in mt76 module")

is missing a Signed-off-by from its committer.
----------------------------------------------------------------------

I think it's faster if you can test the commits yourself before sending
the pull request. I'm using Stephen's scripts but I don't remember
anymore where I got them. But Greg has his script available and I assume
they test the same stuff:

https://github.com/gregkh/gregkh-linux/tree/master/work

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
