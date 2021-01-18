Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9187B2FA672
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Jan 2021 17:40:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405862AbhARQjw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 18 Jan 2021 11:39:52 -0500
Received: from so254-31.mailgun.net ([198.61.254.31]:60265 "EHLO
        so254-31.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405846AbhARQjh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 18 Jan 2021 11:39:37 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1610987930; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=4y4QUpioQ/d+gCmHKOd4UCjbYz4QrhmNC4FQaweBrCk=; b=Qo00eqiiqE9qWgX8ts+n5GFPL1/80RZ75kDka3n0CuzadNlwAEMjXFc74iXUcgiyAsI8/0Uj
 NN7zCVPYRGZBOMUsvGWhQe3SnRk+gDD2CqB/raszQG19F6xhW/c2NQwl96kJUhwQogKVYLnQ
 vVhQamglCMW8qnNQcg3DswgWe/E=
X-Mailgun-Sending-Ip: 198.61.254.31
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-west-2.postgun.com with SMTP id
 6005b97d75e5c01cba984f54 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 18 Jan 2021 16:38:21
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 29C9EC433CA; Mon, 18 Jan 2021 16:38:21 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 97A0FC433C6;
        Mon, 18 Jan 2021 16:38:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 97A0FC433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Wen Gong <wgong@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH] ath11k: add ieee80211_unregister_hw to avoid kernel crash caused by NULL pointer
References: <1608607824-16067-1-git-send-email-wgong@codeaurora.org>
Date:   Mon, 18 Jan 2021 18:38:17 +0200
In-Reply-To: <1608607824-16067-1-git-send-email-wgong@codeaurora.org> (Wen
        Gong's message of "Tue, 22 Dec 2020 11:30:24 +0800")
Message-ID: <87turefbeu.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wen Gong <wgong@codeaurora.org> writes:

> When function return fail to __ath11k_mac_register after success called
> ieee80211_register_hw, then it set wiphy->dev.parent to NULL by
> SET_IEEE80211_DEV(ar->hw, NULL) in end of __ath11k_mac_register, then
> cfg80211_get_drvinfo will be called by below call stack, but the
> wiphy->dev.parent is NULL, so kernel crash.

[...]

> +err_unregister_hw:
> +		ieee80211_unregister_hw(ar->hw);
> +
>  err_free_if_combs:
>  	kfree(ar->hw->wiphy->iface_combinations[0].limits);
>  	kfree(ar->hw->wiphy->iface_combinations);

Incorrect indentation, I'm surprised checkpatch doesn't catch that. But
fixed this in the pending branch.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
