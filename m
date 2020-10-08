Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0314287AB8
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Oct 2020 19:12:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731227AbgJHRL5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 8 Oct 2020 13:11:57 -0400
Received: from z5.mailgun.us ([104.130.96.5]:24400 "EHLO z5.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731842AbgJHRLz (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 8 Oct 2020 13:11:55 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1602177114; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=eDg1AMsDiju1F4f8kJgLBd5n2RO5yCih+OMkV+2tsI0=;
 b=FKeH2AcIr8SgBVvC+xUHZGSJelN38lhQpcDalLlQXKRCu3xrsU5Kve7yiNBDdxPKuEXwvUjs
 zCnteUNIHswilOgSBw99TBylyePzFf/GJHL+zzjBqI6kpo7Dd7jrZnifhBUDkHM92U3ANMcx
 z5Pf2Kh4l9WT5VG9a9D3KmH4Kv0=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-east-1.postgun.com with SMTP id
 5f7f48284f8cc67c31dba197 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 08 Oct 2020 17:11:04
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 04C87C433F1; Thu,  8 Oct 2020 17:11:04 +0000 (UTC)
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id EB8C2C433CA;
        Thu,  8 Oct 2020 17:11:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org EB8C2C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 01/13] iwlwifi: mvm: get number of stations from TLV
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <iwlwifi.20201008180656.863ab470babc.I393223392f36436663c4e66add03fefe77b74e60@changeid>
References: <iwlwifi.20201008180656.863ab470babc.I393223392f36436663c4e66add03fefe77b74e60@changeid>
To:     Luca Coelho <luca@coelho.fi>
Cc:     linux-wireless@vger.kernel.org
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20201008171104.04C87C433F1@smtp.codeaurora.org>
Date:   Thu,  8 Oct 2020 17:11:04 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Luca Coelho <luca@coelho.fi> wrote:

> From: Nathan Errera <nathan.errera@intel.com>
> 
> FW is changing the max number of supported stations. To adapt to the
> change we get the max number from the TLV and act according to the new
> number.
> 
> Signed-off-by: Nathan Errera <nathan.errera@intel.com>
> Signed-off-by: Luca Coelho <luciano.coelho@intel.com>

13 patches applied to wireless-drivers-next.git, thanks.

be9ae34ead42 iwlwifi: mvm: get number of stations from TLV
90824f2f3390 iwlwifi: mvm: read and parse SKU ID if available
7ef3e2246638 iwlwifi: update prph scratch structure to include PNVM data
70d3ca86b025 iwlwifi: mvm: ring the doorbell and wait for PNVM load completion
f0d748ad459e iwlwifi: mvm: stop claiming NL80211_EXT_FEATURE_SET_SCAN_DWELL
43dc85b5ec54 iwlwifi: support an additional Qu subsystem id
64f55156f7ad iwlwifi: mvm: don't send RFH_QUEUE_CONFIG_CMD with no queues
df7203736938 iwlwifi: mvm: re-enable TX after channel switch
f9084775deb9 iwlwifi: mvm: prepare roc_done_wk to work sync
aa4936b11c6c iwlwifi: mvm: add a get lmac id function
2c2c3647cde4 iwlwifi: mvm: support ADD_STA_CMD_API_S ver 12
bebc14db4eb7 iwlwifi: mvm: avoid possible NULL pointer dereference
a48d400cc444 iwlwifi: pcie: fix 0x271B and 0x271C trans cfg struct

-- 
https://patchwork.kernel.org/patch/11823163/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

