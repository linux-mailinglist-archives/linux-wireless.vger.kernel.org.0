Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83871410BEB
	for <lists+linux-wireless@lfdr.de>; Sun, 19 Sep 2021 16:34:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232629AbhISOfo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 19 Sep 2021 10:35:44 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:39999 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232537AbhISOfn (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 19 Sep 2021 10:35:43 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1632062058; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=AWCONV14urNUq4czq5gXObi3oJ1UL0RYjlDcTr1YGqs=;
 b=FVJ1re8j4KQkpJxP/GtCMYjNR85BB23VXqau8WDaGV2Yj7wfvHAPQ0T4oinyU1MluNTftkJU
 IyggxU0btgNz3vQsjkhUqsBOJlfGLAuBUOfqZazudZRr4gvTS8ApIxNWwLDpXAlExonZoEZR
 zSGYc4AqMmjIFO6dL1B/B+gu0+M=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-east-1.postgun.com with SMTP id
 61474a67bd6681d8edbc3254 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sun, 19 Sep 2021 14:34:15
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id EF5FCC43616; Sun, 19 Sep 2021 14:34:14 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        MISSING_DATE,MISSING_MID,SPF_FAIL,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.0
Received: from tykki.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 36873C43460;
        Sun, 19 Sep 2021 14:34:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 36873C43460
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/2] iwlwifi: mvm: d3: Fix off by ones in
 iwl_mvm_wowlan_get_rsc_v5_data()
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20210831081802.GA9846@kili>
References: <20210831081802.GA9846@kili>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Luca Coelho <luciano.coelho@intel.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Mordechay Goodstein <mordechay.goodstein@intel.com>,
        Sara Sharon <sara.sharon@intel.com>,
        Naftali Goldstein <naftali.goldstein@intel.com>,
        Dan Halperin <Dan1.Halperin@intel.com>,
        linux-wireless@vger.kernel.org, kernel-janitors@vger.kernel.org
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-Id: <20210919143414.EF5FCC43616@smtp.codeaurora.org>
Date:   Sun, 19 Sep 2021 14:34:14 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Dan Carpenter <dan.carpenter@oracle.com> wrote:

> These should be >= ARRAY_SIZE() instead of > ARRAY_SIZE() to prevent an
> out of bounds write on the next line.
> 
> Fixes: 79e561f0f05a ("iwlwifi: mvm: d3: implement RSC command version 5")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> Acked-by: Luca Coelho <luca@coelho.fi>

2 patches applied to wireless-drivers.git, thanks.

27a221f433b7 iwlwifi: mvm: d3: Fix off by ones in iwl_mvm_wowlan_get_rsc_v5_data()
b6a46b4f6e4b iwlwifi: mvm: d3: missing unlock in iwl_mvm_wowlan_program_keys()

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20210831081802.GA9846@kili/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

