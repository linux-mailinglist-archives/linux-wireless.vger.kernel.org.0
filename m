Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1A9F1C4F36
	for <lists+linux-wireless@lfdr.de>; Tue,  5 May 2020 09:35:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728360AbgEEHfZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 5 May 2020 03:35:25 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:25392 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725320AbgEEHfY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 5 May 2020 03:35:24 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1588664124; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=jdXUih/dw2RAA3j/VDK1UHup5SgT35MJVZ77UKLjMnw=;
 b=bInVxl63vo+PYLucWplCXEgsJJQXZKVFwfQkUiaBrX4yT9MGrClNBCv9DmkuPYHmf0jFbwCp
 60SZzCWwDMWh+vU0+xIxuwPlNFQBhlfXLHm0zJKMWb2VqP0EMaWuW4a1KWiwXhdM2aph8o5t
 Y78KStquKSgJ/n5FYVblqYvzEz4=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5eb1172e.7f1b780d21b8-smtp-out-n04;
 Tue, 05 May 2020 07:35:10 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id DC8D8C433BA; Tue,  5 May 2020 07:35:09 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B6844C433D2;
        Tue,  5 May 2020 07:35:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B6844C433D2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2] ath10k: remove the max_sched_scan_reqs value
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20191114050001.4658-1-wgong@codeaurora.org>
References: <20191114050001.4658-1-wgong@codeaurora.org>
To:     Wen Gong <wgong@codeaurora.org>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20200505073509.DC8D8C433BA@smtp.codeaurora.org>
Date:   Tue,  5 May 2020 07:35:09 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wen Gong <wgong@codeaurora.org> wrote:

> The struct cfg80211_wowlan of NET_DETECT WoWLAN feature share the same
> struct cfg80211_sched_scan_request together with scheduled scan request
> feature, and max_sched_scan_reqs of wiphy is only used for sched scan,
> and ath10k does not support scheduled scan request feature, so ath10k
> does not set flag NL80211_FEATURE_SCHED_SCAN_RANDOM_MAC_ADDR, but ath10k
> set max_sched_scan_reqs of wiphy to a non zero value 1, then function
> nl80211_add_commands_unsplit of cfg80211 will set it support command
> NL80211_CMD_START_SCHED_SCAN because max_sched_scan_reqs is a non zero
> value, but actually ath10k not support it, then it leads a mismatch result
> for sched scan of cfg80211, then application shill found the mismatch and
> stop running case of MAC random address scan and then the case fail.
> 
> After remove max_sched_scan_reqs value, it keeps match for sched scan and
> case of MAC random address scan pass.
> 
> Tested with QCA6174 SDIO with firmware WLAN.RMH.4.4.1-00029.
> Tested with QCA6174 PCIe with firmware WLAN.RM.4.4.1-00110-QCARMSWP-1.
> 
> Fixes: ce834e280f2f875 ("ath10k: support NET_DETECT WoWLAN feature")
> Signed-off-by: Wen Gong <wgong@codeaurora.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

d431f8939c14 ath10k: remove the max_sched_scan_reqs value

-- 
https://patchwork.kernel.org/patch/11243015/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
