Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96187321158
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Feb 2021 08:23:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbhBVHXo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 22 Feb 2021 02:23:44 -0500
Received: from z11.mailgun.us ([104.130.96.11]:33793 "EHLO z11.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229908AbhBVHXj (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 22 Feb 2021 02:23:39 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1613978600; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=e+SVH7EHYgjRp/N590kzkadwrIymMLdY+1yN4VQncUA=;
 b=lzq2QAnUImeO99q0BWriB2wrQEJK6MqexT7sCZxnzNDFpqiW+ZkI5uWppuo0POihi5YK/mG9
 VZT5ZnNAuQQghBf8+/ac1yoqzm9J1qxqgfwv1A2TnmjvN58t5e+j7qvVWaCUfjoMB4LnKt6H
 Xp8qNZjO9SjQ7DMx9XZsce/vlIQ=
X-Mailgun-Sending-Ip: 104.130.96.11
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-east-1.postgun.com with SMTP id
 60335be39946643859ba2b17 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 22 Feb 2021 07:23:15
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 5E796C433C6; Mon, 22 Feb 2021 07:23:14 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        MISSING_DATE,MISSING_MID,SPF_FAIL,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A9FD2C433CA;
        Mon, 22 Feb 2021 07:23:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A9FD2C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] iwlwifi: avoid crash on unsupported debug collection
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20210219133506.ecabe285bc7d.I73d230d555c595fa2d9bf284f80078729fe18aa4@changeid>
References: <20210219133506.ecabe285bc7d.I73d230d555c595fa2d9bf284f80078729fe18aa4@changeid>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Andy Lavr <andy.lavr@gmail.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20210222072314.5E796C433C6@smtp.codeaurora.org>
Date:   Mon, 22 Feb 2021 07:23:14 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Johannes Berg <johannes@sipsolutions.net> wrote:

> From: Johannes Berg <johannes.berg@intel.com>
> 
> If the opmode doesn't support debug collection (DVM) then don't
> crash, but just skip the callback.
> 
> Fixes: d01293154c0a ("iwlwifi: dbg: add op_mode callback for collecting debug data.")
> Reported-by: Andy Lavr <andy.lavr@gmail.com>
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>

Patch applied to wireless-drivers.git, thanks.

4538c5ed0f7e iwlwifi: avoid crash on unsupported debug collection

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20210219133506.ecabe285bc7d.I73d230d555c595fa2d9bf284f80078729fe18aa4@changeid/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

