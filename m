Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8B942AB63C
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Nov 2020 12:11:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729119AbgKILLn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 9 Nov 2020 06:11:43 -0500
Received: from m42-4.mailgun.net ([69.72.42.4]:20149 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727303AbgKILLn (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 9 Nov 2020 06:11:43 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1604920302; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=JlwkkZSPKLDrn3Aqz3GTmEpqAakP0sXxOwj3633Qj7A=; b=eFToaKH7KQq27tIo/oVdP/SK8XTMom/QtKJnx4xUWA+ESGMgRAAKxFu6hsvtgyL69q1VUj5d
 7PTs4IYw6eCvyvJOJEOX8h49j9JnkW9S2cvrjsAQjmN6yTHA0B0jZvmdwH1X4mG9aOrcQOv3
 +eruQmmejQwsghd1APyS54nyPTo=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-east-1.postgun.com with SMTP id
 5fa923ee02f4ee380196e206 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 09 Nov 2020 11:11:42
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 559C0C433C8; Mon,  9 Nov 2020 11:11:41 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from tynnyri.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4611EC433C6;
        Mon,  9 Nov 2020 11:11:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4611EC433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>
Subject: Re: [PATCH 8/8] cfg80211: remove WDS code
References: <20201109095747.113720-1-johannes@sipsolutions.net>
        <20201109105103.8f5b98e4068d.I5f5129041649ef2862b69683574bb3344743727b@changeid>
Date:   Mon, 09 Nov 2020 13:11:34 +0200
In-Reply-To: <20201109105103.8f5b98e4068d.I5f5129041649ef2862b69683574bb3344743727b@changeid>
        (Johannes Berg's message of "Mon, 9 Nov 2020 10:57:47 +0100")
Message-ID: <87lffa6azd.fsf@tynnyri.adurom.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Johannes Berg <johannes@sipsolutions.net> writes:

> From: Johannes Berg <johannes.berg@intel.com>
>
> Remove all the code that was there to configure WDS interfaces,
> now that there's no way to reach it anymore.
>
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>

[...]

> @@ -675,10 +673,8 @@ int wiphy_register(struct wiphy *wiphy)
>  		     !(wiphy->nan_supported_bands & BIT(NL80211_BAND_2GHZ)))))
>  		return -EINVAL;
>  
> -#ifndef CONFIG_WIRELESS_WDS
>  	if (WARN_ON(wiphy->interface_modes & BIT(NL80211_IFTYPE_WDS)))
>  		return -EINVAL;
> -#endif

What about out-of-tree drivers? Should we have (or do we already have?)
a some kind safe guard if an out of tree driver tries to use WDS?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
