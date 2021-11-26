Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C12F645EB38
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Nov 2021 11:22:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231382AbhKZKZM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 26 Nov 2021 05:25:12 -0500
Received: from m43-7.mailgun.net ([69.72.43.7]:42719 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230336AbhKZKXM (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 26 Nov 2021 05:23:12 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1637922000; h=Date: Message-ID: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=rf1Qj/gQ+mNKKp3kFoBiOBpr5ndsPA7Rx+um94+xG/g=;
 b=hHow+HuotFsO2Wl+8M/bl9xzy5mW/ph3W/Bu0kCS+eOWhtV5XjFydD2o2+WA7Xa5RNGUXoj2
 x05wlZomg09p6PwCUEcDtXPOG1VnTYFIMKZhKc2MjyFCsgaYz6JGUKF3YDwj22e+Ec8TtAJH
 6ZldJnqwMRTBLF87HtCbGQcD7v0=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n10.prod.us-east-1.postgun.com with SMTP id
 61a0b4ba3553c354be1efea4 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 26 Nov 2021 10:19:38
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 694BBC4360D; Fri, 26 Nov 2021 10:19:37 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        MISSING_DATE,SPF_FAIL autolearn=no autolearn_force=no version=3.4.0
Received: from tykki.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D3F1CC43617;
        Fri, 26 Nov 2021 10:19:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org D3F1CC43617
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wcn36xx: Use correct SSN for ADD BA request
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1637604251-11763-1-git-send-email-loic.poulain@linaro.org>
References: <1637604251-11763-1-git-send-email-loic.poulain@linaro.org>
To:     Loic Poulain <loic.poulain@linaro.org>
Cc:     linux-wireless@vger.kernel.org, wcn36xx@lists.infradead.org,
        Loic Poulain <loic.poulain@linaro.org>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <163792197409.23943.7303108798447763543.kvalo@codeaurora.org>
Date:   Fri, 26 Nov 2021 10:19:37 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Loic Poulain <loic.poulain@linaro.org> wrote:

> Since firmware uses its own sequence number counters, we need to
> use firmware number as well when mac80211 generates the ADD_BA
> request packet. Indeed the firmware sequence counters tend to
> slightly drift from the mac80211 ones because of firmware offload
> features like ARP responses. This causes the starting sequence
> number field of the ADD_BA request to be unaligned, and can possibly
> cause issues with strict/picky APs.
> 
> To fix this, we retrieve the current firmware sequence number for
> a given TID through the smd_trigger_ba API, and use that number as
> replacement of the mac80211 starting sequence number.
> 
> This change also ensures that any issue in the smd *ba procedures
> will cause the ba action to properly fail, and remove useless call
> to smd_trigger_ba() from IEEE80211_AMPDU_RX_START.
> 
> Signed-off-by: Loic Poulain <loic.poulain@linaro.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

23cddeb5a770 wcn36xx: Use correct SSN for ADD BA request

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/1637604251-11763-1-git-send-email-loic.poulain@linaro.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

