Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C651C3B33DE
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Jun 2021 18:22:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230015AbhFXQY4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 24 Jun 2021 12:24:56 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:48068 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbhFXQYz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 24 Jun 2021 12:24:55 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1624551756; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=5Ij7jIb35U00aSmbfLy+4qCyeXroDxTj7cgJjlu2msA=;
 b=Pt13/IweA8BjZW0SVF1lve7C3cRmU4Y8NQyzadkrkSbeuoF/4fHDXEI6e4eAE3fkG/l+nN+7
 4Hl1N1m6S8N2JROV2765rO10E/CueieybDvPhDLIsrSY2Wd+VyQSZAdpElwlB7PXbp6hddeJ
 qGDP/Q5pMX0/XPRB6UVQ3eP5+hg=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 60d4b1357e5ba0fdc0c5f7c3 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 24 Jun 2021 16:22:13
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 3EB4FC4338A; Thu, 24 Jun 2021 16:22:13 +0000 (UTC)
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 48318C433F1;
        Thu, 24 Jun 2021 16:22:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 48318C433F1
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] iwlwifi: acpi: remove unused function
 iwl_acpi_eval_dsm_func()
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20210624052918.4946-1-kvalo@codeaurora.org>
References: <20210624052918.4946-1-kvalo@codeaurora.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org, sfr@canb.auug.org.au,
        luciano.coelho@intel.com
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-Id: <20210624162213.3EB4FC4338A@smtp.codeaurora.org>
Date:   Thu, 24 Jun 2021 16:22:13 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Kalle Valo <kvalo@codeaurora.org> wrote:

> Stephen reported a warning:
> 
> drivers/net/wireless/intel/iwlwifi/fw/acpi.c:720:12: warning: 'iwl_acpi_eval_dsm_func' defined but not used [-Wunused-function]
> 
> The warning is correct and the function is not used anywhere, so let's
> just remove it.
> 
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Fixes: 7119f02b5d34 ("iwlwifi: mvm: support BIOS enable/disable for 11ax in Russia")
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
> Acked-by: Luca Coelho <luciano.coelho@intel.com>

Patch applied to wireless-drivers-next.git, thanks.

c2a3823dad49 iwlwifi: acpi: remove unused function iwl_acpi_eval_dsm_func()

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20210624052918.4946-1-kvalo@codeaurora.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

