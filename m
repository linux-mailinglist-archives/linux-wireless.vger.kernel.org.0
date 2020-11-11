Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE6FC2AEB14
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Nov 2020 09:24:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726334AbgKKIXY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 11 Nov 2020 03:23:24 -0500
Received: from m42-4.mailgun.net ([69.72.42.4]:53895 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725859AbgKKIXS (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 11 Nov 2020 03:23:18 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1605082997; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=dkFX6E0yIWhdqL4jLjA5m8xbjtyfaMXK7QDyGRUb1hw=; b=FzFQL1xZ0oQ9rE76EwP5d5m0zYTjMIhtoraaWxW+mNIv295har4dn9eMCg2DgKHln1LErjuA
 9ZC2qzWbeWY+eKCYeIiRdhGTThN1dvvnfhxRcqXy0lyPV4TY8MVlgitSCScpASLASubZPjKn
 s+yTol+WPzblO5edGv2hxUmgFAY=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n08.prod.us-east-1.postgun.com with SMTP id
 5fab9f6a97cfcbc962b3ce3d (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 11 Nov 2020 08:23:06
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 60405C433CB; Wed, 11 Nov 2020 08:23:05 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 59486C433C8;
        Wed, 11 Nov 2020 08:23:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 59486C433C8
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Wireless <linux-wireless@vger.kernel.org>,
        Avraham Stern <avraham.stern@intel.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: Signed-off-by missing for commit in the wireless-drivers tree
References: <20201111081257.30418470@canb.auug.org.au>
Date:   Wed, 11 Nov 2020 10:23:00 +0200
In-Reply-To: <20201111081257.30418470@canb.auug.org.au> (Stephen Rothwell's
        message of "Wed, 11 Nov 2020 08:12:57 +1100")
Message-ID: <87eel0cnff.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Stephen Rothwell <sfr@canb.auug.org.au> writes:

> Commit
>
>   97cc16943f23 ("iwlwifi: mvm: write queue_sync_state only for sync")
>
> is missing a Signed-off-by from its author.

Doh, missed that. But as it has s-o-b from Johannes and Luca, both also
from Intel, I think I'll leave it as is so that I don't need to rebase
wireless-drivers.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
