Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E0B2416D1C
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Sep 2021 09:51:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244507AbhIXHw3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 24 Sep 2021 03:52:29 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:39434 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236429AbhIXHwU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 24 Sep 2021 03:52:20 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1632469848; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=6zccmjdrHo+ekRUZS+8j7DEY4Vf+wTOSBKi2rSCaWBE=; b=PtkD+8b6OU2gTCU4aswR+bF/OYVS0kRkJPnb660JtloaVLTaXii5thpAoPZaGJ/O0ehr5Z01
 rlI5UciyKxF3w8CDvcKYvGjlvmddq37G3r0PFkQ58tlrDj3Ojb21sYwE+cBZxxoI9tbOiG+G
 AMeoUx9278maQnfTVKy7yBXkCig=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-west-2.postgun.com with SMTP id
 614d8345096ba46b979ff0e9 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 24 Sep 2021 07:50:29
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 499F4C4360C; Fri, 24 Sep 2021 07:50:29 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from tykki (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 17429C4338F;
        Fri, 24 Sep 2021 07:50:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 17429C4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Ramon Fontes <ramonreisfontes@gmail.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-wireless@vger.kernel.org, davem@davemloft.net
Subject: Re: [PATCH] mac80211_hwsim: enable 6GHz channels
References: <20210922142803.192601-1-ramonreisfontes@gmail.com>
        <167f632eb19944b5711a584218e57b51da85df96.camel@sipsolutions.net>
Date:   Fri, 24 Sep 2021 10:50:24 +0300
In-Reply-To: <167f632eb19944b5711a584218e57b51da85df96.camel@sipsolutions.net>
        (Johannes Berg's message of "Wed, 22 Sep 2021 16:29:37 +0200")
Message-ID: <87fstutnsv.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Johannes Berg <johannes@sipsolutions.net> writes:

> On Wed, 2021-09-22 at 11:28 -0300, Ramon Fontes wrote:
>> This adds 6 GHz capabilities and reject HT/VHT
>> 
>
> It'd be nice to add a version to the subject, with -vN on the git-send-
> email commandline :)

And don't forge the changelog either:

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches#changelog_missing

One day I'll write a bot to send these wiki links :)

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
