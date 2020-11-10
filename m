Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 616DD2ADEB0
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Nov 2020 19:46:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731451AbgKJSqt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 10 Nov 2020 13:46:49 -0500
Received: from m42-4.mailgun.net ([69.72.42.4]:25940 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731431AbgKJSqt (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 10 Nov 2020 13:46:49 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1605034008; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=k6QB2LqisI+Vvb0lPHOXPkpjtl6nCmxUbA1kR6ZiteY=;
 b=l7mDLDnts5jdX6SjX4BrgOyxB5TIhGN5jmWWKMxHpXu4pE/QQhhQZqTDcYhFhvFYM1+uEQxn
 CicmnX5caTSYRedKT4J7BbSamdMH8QQpQg8nEG5iez5dHhAYAuNnq2xnN7tCcND430DU4n8l
 bCn6Dpxd8F4E+VOYf2qlNBXbj/0=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-east-1.postgun.com with SMTP id
 5faae00f1b0f990483b74ef3 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 10 Nov 2020 18:46:39
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 3BF79C433C6; Tue, 10 Nov 2020 18:46:39 +0000 (UTC)
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 29D48C433C8;
        Tue, 10 Nov 2020 18:46:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 29D48C433C8
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/6] iwlwifi: sta: set max HE max A-MPDU according to HE
 capa
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <iwlwifi.20201107104557.4486852ebb56.I9eb0d028e31f183597fb90120e7d4ca87e0dd6cb@changeid>
References: <iwlwifi.20201107104557.4486852ebb56.I9eb0d028e31f183597fb90120e7d4ca87e0dd6cb@changeid>
To:     Luca Coelho <luca@coelho.fi>
Cc:     linux-wireless@vger.kernel.org
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20201110184639.3BF79C433C6@smtp.codeaurora.org>
Date:   Tue, 10 Nov 2020 18:46:39 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Luca Coelho <luca@coelho.fi> wrote:

> From: Mordechay Goodstein <mordechay.goodstein@intel.com>
> 
> Currently, our max tpt is limited to max HT A-MPDU for LB,
> and max VHT A-MPDU for HB. Configure HE exponent value correctly to
> achieve HE max A-MPDU, both on LB and HB.
> 
> Signed-off-by: Mordechay Goodstein <mordechay.goodstein@intel.com>
> Signed-off-by: Luca Coelho <luciano.coelho@intel.com>

6 patches applied to wireless-drivers.git, thanks.

c8a2e7a29702 iwlwifi: sta: set max HE max A-MPDU according to HE capa
fb8d1b6e9798 iwlwifi: mvm: use the HOT_SPOT_CMD to cancel an AUX ROC
1cf260e3a75b iwlwifi: mvm: properly cancel a session protection for P2P
97cc16943f23 iwlwifi: mvm: write queue_sync_state only for sync
edb625208d84 iwlwifi: pcie: set LTR to avoid completion timeout
fe56d05ee6c8 iwlwifi: mvm: fix kernel panic in case of assert during CSA

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/iwlwifi.20201107104557.4486852ebb56.I9eb0d028e31f183597fb90120e7d4ca87e0dd6cb@changeid/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

