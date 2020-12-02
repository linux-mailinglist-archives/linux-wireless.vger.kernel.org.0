Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2BB32CC619
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Dec 2020 20:03:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729110AbgLBTBx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 2 Dec 2020 14:01:53 -0500
Received: from m42-5.mailgun.net ([69.72.42.5]:19458 "EHLO m42-5.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727891AbgLBTBx (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 2 Dec 2020 14:01:53 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1606935694; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=08rW4kD1mpn+dXCPLI2VaqMThkdXayUwlN0OFvRLAGA=;
 b=dkBNneIhp0EEEWiLSLx7Ti6NGpYFpqS3Gy5SjTdm4EOF8ZAgXldJlm47nBFhi0VkRts6jgrx
 1rMdCRdiwMswpwlhJkbHQvFTkCwFEtPkT/lFSbPZBoxZY4/Qqu8dzeMCtetyT/4Xa1K7GiKE
 f4ugkmHvkLKvogCZi3/H3Y47j/M=
X-Mailgun-Sending-Ip: 69.72.42.5
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n10.prod.us-west-2.postgun.com with SMTP id
 5fc7e46f07535c81ba09c436 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 02 Dec 2020 19:01:03
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id A90E3C43460; Wed,  2 Dec 2020 19:01:03 +0000 (UTC)
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 99431C433C6;
        Wed,  2 Dec 2020 19:01:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 99431C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 08/12] iwlwifi: update MAINTAINERS entry
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <iwlwifi.20201129151117.a25afe6d2c7f.I8f13a5689dd353825fb2b9bd5b6f0fbce92cb12b@changeid>
References: <iwlwifi.20201129151117.a25afe6d2c7f.I8f13a5689dd353825fb2b9bd5b6f0fbce92cb12b@changeid>
To:     Luca Coelho <luca@coelho.fi>
Cc:     linux-wireless@vger.kernel.org
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20201202190103.A90E3C43460@smtp.codeaurora.org>
Date:   Wed,  2 Dec 2020 19:01:03 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Luca Coelho <luca@coelho.fi> wrote:

> From: Johannes Berg <johannes.berg@intel.com>
> 
> Reflect the fact that the linuxwifi@intel.com address will disappear,
> and that neither Emmanuel nor myself are really much involved with
> the maintenance these days.
> 
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> Signed-off-by: Luca Coelho <luciano.coelho@intel.com>

Patch applied to wireless-drivers.git, thanks.

abfccc3af786 iwlwifi: update MAINTAINERS entry

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/iwlwifi.20201129151117.a25afe6d2c7f.I8f13a5689dd353825fb2b9bd5b6f0fbce92cb12b@changeid/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

