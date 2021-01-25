Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70A1F302620
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Jan 2021 15:16:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729298AbhAYOLg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 25 Jan 2021 09:11:36 -0500
Received: from a1.mail.mailgun.net ([198.61.254.60]:46256 "EHLO
        a1.mail.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729171AbhAYOIr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 25 Jan 2021 09:08:47 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1611583684; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=eE+j5G3AHurYGidfRjN7A3PxjKJJsSCezYoKuHySqF4=;
 b=G+hrPRr9K5ryvI8dCP3MfWva1/wbfe6b3pBZjlfCVLfW7orjVK/3kvuShf1FI4h9H6LJgeap
 SjQ4Lb4iU1qj2ylVrWS9aEiXEYsexbznJdM8v/+tuuxNbUIzgYfanoz/ietotYYdHChttdPV
 VJV1Nofo408BzZUvbsv+1FRB6aA=
X-Mailgun-Sending-Ip: 198.61.254.60
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 600ecd9f5677aca7bd9d4e64 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 25 Jan 2021 13:54:39
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 95478C433CA; Mon, 25 Jan 2021 13:54:38 +0000 (UTC)
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 719A0C433C6;
        Mon, 25 Jan 2021 13:54:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 719A0C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH for v5.11 01/12] iwlwifi: mvm: skip power command when
 unbinding vif during CSA
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <iwlwifi.20210115130252.64a2254ac5c3.Iaa3a9050bf3d7c9cd5beaf561e932e6defc12ec3@changeid>
References: <iwlwifi.20210115130252.64a2254ac5c3.Iaa3a9050bf3d7c9cd5beaf561e932e6defc12ec3@changeid>
To:     Luca Coelho <luca@coelho.fi>
Cc:     linux-wireless@vger.kernel.org
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20210125135438.95478C433CA@smtp.codeaurora.org>
Date:   Mon, 25 Jan 2021 13:54:38 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Luca Coelho <luca@coelho.fi> wrote:

> From: Sara Sharon <sara.sharon@intel.com>
> 
> In the new CSA flow, we remain associated during CSA, but
> still do a unbind-bind to the vif. However, sending the power
> command right after when vif is unbound but still associated
> causes FW to assert (0x3400) since it cannot tell the LMAC id.
> 
> Just skip this command, we will send it again in a bit, when
> assigning the new context.
> 
> Signed-off-by: Sara Sharon <sara.sharon@intel.com>
> Signed-off-by: Luca Coelho <luciano.coelho@intel.com>

12 patches applied to wireless-drivers.git, thanks.

bf544e9aa570 iwlwifi: mvm: skip power command when unbinding vif during CSA
5c56d862c749 iwlwifi: mvm: take mutex for calling iwl_mvm_get_sync_time()
34b9434cd0d4 iwlwifi: pcie: avoid potential PNVM leaks
1c58bed4b7f7 iwlwifi: pnvm: don't skip everything when not reloading
82a08d0cd7b5 iwlwifi: pnvm: don't try to load after failures
a800f95858d0 iwlwifi: fix the NMI flow for old devices
0f8d5656b3fd iwlwifi: queue: don't crash if txq->entries is NULL
ed0022da8bd9 iwlwifi: pcie: set LTR on more devices
98c7d21f957b iwlwifi: pcie: add a NULL check in iwl_pcie_txq_unmap
2d6bc752cc28 iwlwifi: pcie: fix context info memory leak
6701317476bb iwlwifi: pcie: use jiffies for memory read spin time limit
3d372c4edfd4 iwlwifi: pcie: reschedule in long-running memory reads

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/iwlwifi.20210115130252.64a2254ac5c3.Iaa3a9050bf3d7c9cd5beaf561e932e6defc12ec3@changeid/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

