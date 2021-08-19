Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C0073F1C5D
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Aug 2021 17:12:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240168AbhHSPMr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 19 Aug 2021 11:12:47 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:10509 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238877AbhHSPMp (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 19 Aug 2021 11:12:45 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1629385929; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=KdL9zZ7z2BMejhvt7EYDcVcjZ27ZcugEHillxqlriic=; b=CNVeeu91LLDApHL9e89UEW1uuUDc7LtLYlDOGRZmjZ1KMbrv6pr5zHOJ72+OXJB8e2bTeSIn
 srX1qSXVIbXNgoKN2FqpiF13GNbOKqAAVZEcdMBXnXHtAiGagJjzQ7kaQc/m/YO19mrkRnmO
 zyM6nOvTmCw9SK7CgHXKOdMSTOA=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-east-1.postgun.com with SMTP id
 611e73d69507ca1a342708e6 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 19 Aug 2021 15:08:06
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 0D1EEC43616; Thu, 19 Aug 2021 15:08:06 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from tynnyri.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C8584C43460;
        Thu, 19 Aug 2021 15:08:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org C8584C43460
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     greearb@candelatech.com
Cc:     linux-wireless@vger.kernel.org
Subject: Re: [PATCH v5 07/11] mt76: mt7915:  add support for tx-overrides
References: <20210804134505.3208-1-greearb@candelatech.com>
        <20210804134505.3208-7-greearb@candelatech.com>
Date:   Thu, 19 Aug 2021 18:08:01 +0300
In-Reply-To: <20210804134505.3208-7-greearb@candelatech.com> (greearb's
        message of "Wed, 4 Aug 2021 06:45:01 -0700")
Message-ID: <875yw1bhgu.fsf@tynnyri.adurom.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

greearb@candelatech.com writes:

> From: Ben Greear <greearb@candelatech.com>
>
> Allow setting fix rate on transmit without using full testmode
> logic.

Why?

> txpower, dynbw, retry count is not currently supported.
> And, probably later need additional logic to not apply this
> txo to non-data frames and to smaller frames, to allow
> ARP and such to go through while also forcing test data frames
> to arbitrary tx-rates (rates which very well may not be
> received by peer.)

Please include an example how to use the debugfs file.

IIRC there was a similar rtw88 patch adding a debugfs to force setting
the tx rate. So what's the consensus, are we going to allow each driver
have their own custom interfaces setting tx rates? In my opinion this
should go via a generic nl80211 command, but if people think having
custom tx rate interfaces is ok I guess I need to reconsider.

As this patch needs more discussion, please separate it from rest of the
series so that it can be applied separately.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
