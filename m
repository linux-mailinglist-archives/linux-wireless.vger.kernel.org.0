Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 476DC31FB68
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Feb 2021 15:53:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbhBSOwW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 19 Feb 2021 09:52:22 -0500
Received: from z11.mailgun.us ([104.130.96.11]:22903 "EHLO z11.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229644AbhBSOvp (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 19 Feb 2021 09:51:45 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1613746286; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=4SaqQLWPPpWLbhp8cNWU1t9YxUJttqlt4bIk4OxxuaU=; b=BiHRYDRczVNY9YI/ywaSGaUFsOWl9FEWJjJbACJzv5dcb1LVkVy/WcAK4y1SNJzsYgZq3ERQ
 FkeKIif6LaiG2SrrRNtVw9jIyOSgN3Hx7HWX+5ijtT1HgV4MQhzbREeEVKvciUMlPjWfMiOZ
 LfVBOhi38hbsihEkI5vtwrPGZf0=
X-Mailgun-Sending-Ip: 104.130.96.11
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-west-2.postgun.com with SMTP id
 602fd0517237f827dc64a7a9 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 19 Feb 2021 14:50:57
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 59320C43461; Fri, 19 Feb 2021 14:50:57 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from tynnyri.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 57A9DC433C6;
        Fri, 19 Feb 2021 14:50:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 57A9DC433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Andy Lavr <andy.lavr@gmail.com>
Subject: Re: [PATCH] iwlwifi: avoid crash on unsupported debug collection
References: <20210219133506.ecabe285bc7d.I73d230d555c595fa2d9bf284f80078729fe18aa4@changeid>
Date:   Fri, 19 Feb 2021 16:50:53 +0200
In-Reply-To: <20210219133506.ecabe285bc7d.I73d230d555c595fa2d9bf284f80078729fe18aa4@changeid>
        (Johannes Berg's message of "Fri, 19 Feb 2021 13:35:07 +0100")
Message-ID: <87eehcglgy.fsf@tynnyri.adurom.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Johannes Berg <johannes@sipsolutions.net> writes:

> From: Johannes Berg <johannes.berg@intel.com>
>
> If the opmode doesn't support debug collection (DVM) then don't
> crash, but just skip the callback.
>
> Fixes: d01293154c0a ("iwlwifi: dbg: add op_mode callback for collecting debug data.")
> Reported-by: Andy Lavr <andy.lavr@gmail.com>
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>

Should I take this to wireless-drivers?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
