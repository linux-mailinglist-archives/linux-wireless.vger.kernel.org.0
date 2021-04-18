Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FE34363427
	for <lists+linux-wireless@lfdr.de>; Sun, 18 Apr 2021 08:38:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229982AbhDRGih (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 18 Apr 2021 02:38:37 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:25648 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229871AbhDRGig (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 18 Apr 2021 02:38:36 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1618727889; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=5jYJ5892KJ9ge3ApIJ+5qfiHSzfUfa7tg+GIi04WoN4=;
 b=K9ZbUpbUfE+JMLtp/xQuBymZuAM0TMb1G3hNnll447tkEQnvjmLq/VRstlo2sJNqYPiRiLid
 nEh50Bq4yxvSFipyGvFWTQBFasH+B7ZteAKhkWp6TjO0qvas7A/rbnE74tJvhPoCSvV7uMaO
 TwbD0HTfyXVk0hnCqJtqNKm3loI=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-west-2.postgun.com with SMTP id
 607bd3cae0e9c9a6b6fda7a3 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sun, 18 Apr 2021 06:38:02
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 6D20AC4338A; Sun, 18 Apr 2021 06:38:02 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        MISSING_DATE,MISSING_MID,SPF_FAIL autolearn=no autolearn_force=no
        version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 44EE1C433F1;
        Sun, 18 Apr 2021 06:38:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 44EE1C433F1
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH for -next] iwlwifi: pcie: don't enable BHs with IRQs
 disabled
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <iwlwifi.20210415164821.d0f2edda1651.I75f762e0bed38914d1300ea198b86dd449b4b206@changeid>
References: <iwlwifi.20210415164821.d0f2edda1651.I75f762e0bed38914d1300ea198b86dd449b4b206@changeid>
To:     Luca Coelho <luca@coelho.fi>
Cc:     luca@coelho.fi, jikos@kernel.org, hdegoede@redhat.com,
        johannes@sipsolutions.net, linux-wireless@vger.kernel.org
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20210418063802.6D20AC4338A@smtp.codeaurora.org>
Date:   Sun, 18 Apr 2021 06:38:02 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Luca Coelho <luca@coelho.fi> wrote:

> From: Johannes Berg <johannes.berg@intel.com>
> 
> After the fix from Jiri that disabled local IRQs instead of
> just BHs (necessary to fix an issue with submitting a command
> with IRQs already disabled), there was still a situation in
> which we could deep in there enable BHs, if the device config
> sets the apmg_wake_up_wa configuration, which is true on all
> 7000 series devices.
> 
> To fix that, but not require reverting commit 1ed08f6fb5ae
> ("iwlwifi: remove flags argument for nic_access"), split up
> nic access into a version with BH manipulation to use most
> of the time, and without it for this specific case where the
> local IRQs are already disabled.
> 
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> Signed-off-by: Luca Coelho <luciano.coelho@intel.com>

Patch applied to wireless-drivers-next.git, thanks.

c544d89b0d67 iwlwifi: pcie: don't enable BHs with IRQs disabled

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/iwlwifi.20210415164821.d0f2edda1651.I75f762e0bed38914d1300ea198b86dd449b4b206@changeid/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

