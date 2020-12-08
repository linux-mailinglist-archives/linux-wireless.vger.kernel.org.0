Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E870B2D25D3
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Dec 2020 09:27:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728214AbgLHI0t (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Dec 2020 03:26:49 -0500
Received: from so254-31.mailgun.net ([198.61.254.31]:63107 "EHLO
        so254-31.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728191AbgLHI0t (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Dec 2020 03:26:49 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1607415984; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=xq3oy99zl2gR3nMQordnnBYArUynP/cy+s33+204NZY=; b=h6ClbUnqO7RQxaN1g2sHLi68KcLxTbZh0RvH9W/GclLb5B8RK1b4rhd8SxOOo/ra05B8d4KC
 6bxHSC7Df//agKXSlY7+iql0sJUvtXVjNrNCEel6LW6pnjUSh/1QWOcPj8qXVwpsR6ZoNuW9
 thLntheUSlDhda7uwgyAoLGg0P8=
X-Mailgun-Sending-Ip: 198.61.254.31
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-west-2.postgun.com with SMTP id
 5fcf389096285165cdaf9a8e (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 08 Dec 2020 08:25:52
 GMT
Sender: saiprakash.ranjan=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 2A2F1C433CA; Tue,  8 Dec 2020 08:25:52 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from blr-ubuntu-253.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: saiprakash.ranjan)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7E7D8C433CA;
        Tue,  8 Dec 2020 08:25:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7E7D8C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=saiprakash.ranjan@codeaurora.org
From:   Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
To:     youghand@codeaurora.org
Cc:     ath10k@lists.infradead.org, briannorris@chromium.org,
        dianders@chromium.org, kuabhs@chromium.org,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        pillair@codeaurora.org,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Subject: Re: [PATCH v2] ath10k: skip the wait for completion to recovery in shutdown path
Date:   Tue,  8 Dec 2020 13:55:24 +0530
Message-Id: <20201208082524.20451-1-saiprakash.ranjan@codeaurora.org>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20201126171553.2097-1-youghand@codeaurora.org>
References: <20201126171553.2097-1-youghand@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, Nov 26, 2020 at 9:16 AM Youghandhar Chintala
<youghand@codeaurora.org> wrote:
> --- a/drivers/net/wireless/ath/ath10k/snoc.c
> +++ b/drivers/net/wireless/ath/ath10k/snoc.c
> @@ -1790,9 +1790,6 @@ static int ath10k_snoc_remove(struct platform_device *pdev)
>
>         reinit_completion(&ar->driver_recovery);
>
> -       if (test_bit(ATH10K_SNOC_FLAG_RECOVERY, &ar_snoc->flags))
> -               wait_for_completion_timeout(&ar->driver_recovery, 3 * HZ);

You are skipping recovery in ath10k_snoc_remove() which is a remove callback
and also called in shutdown callback. So that means it is also called when
you unload the ath10k module and not just when the system reboots/shutdown.
While it makes sense to not skip recovery in shutdown/reboot sequence because
the system is going down, it might very well be needed in case of unloading
the module because we expect the system to be up and stable after unloading
the ath10k module and we should be able to reload the ath10k module smoothly.

If you remove that now and try to reload the ath10k module, won't that leave
the system in possibly an inconsistent state because we skipped recovery in
module remove and then we are trying to load the ath10k module when the
recovery is not yet complete? In other words, you need to test ath10k module
load/unload as well in addition to reboot tests to make sure this works as
expected or else you will need a separate shutdown callback which skips the
recovery part.

Thanks,
Sai
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
