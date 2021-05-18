Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C69DD387E94
	for <lists+linux-wireless@lfdr.de>; Tue, 18 May 2021 19:37:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244414AbhERRib (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 18 May 2021 13:38:31 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:21129 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343605AbhERRia (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 18 May 2021 13:38:30 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1621359432; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=0sMCIsYCMuorGJpaxp925zcBGFQ6EwtE91d4LNKlVtQ=; b=DX21xh9dasPLuAFV9flWHigE420uJMRT2GBBWGnZpw8Vv6s8ufr/pnVGaZkpR7P/tz4RkqwJ
 4+clKyHNrl6pd6DKYiLkeL8+3x3XeB4aemUvmHxpwlAFqwZO64a9qLPJrb+7I9TayMl1FFIb
 HtIUDsbFzlzyl/VmTvz0FXxATVo=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-west-2.postgun.com with SMTP id
 60a3fb3f7b9a7a2b6cf93626 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 18 May 2021 17:37:03
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id A6FADC43460; Tue, 18 May 2021 17:37:03 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from tynnyri.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 11E34C4338A;
        Tue, 18 May 2021 17:37:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 11E34C4338A
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Philipp Borgers <borgers@mi.fu-berlin.de>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org
Subject: Re: [PATCH 2/2] mac80211: refactor rc_no_data_or_no_ack_use_min function
References: <20210518110755.43077-1-borgers@mi.fu-berlin.de>
        <20210518110755.43077-2-borgers@mi.fu-berlin.de>
Date:   Tue, 18 May 2021 20:37:00 +0300
In-Reply-To: <20210518110755.43077-2-borgers@mi.fu-berlin.de> (Philipp
        Borgers's message of "Tue, 18 May 2021 13:07:55 +0200")
Message-ID: <87eee46j0j.fsf@tynnyri.adurom.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Philipp Borgers <borgers@mi.fu-berlin.de> writes:

> Signed-off-by: Philipp Borgers <borgers@mi.fu-berlin.de>

Why? Empty commit logs is a bad idea, even if the reason is trivial to
you it might not be for others.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
