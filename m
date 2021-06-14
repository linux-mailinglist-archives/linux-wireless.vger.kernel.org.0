Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D37153A69EC
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Jun 2021 17:19:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232958AbhFNPVN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 14 Jun 2021 11:21:13 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:12966 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232809AbhFNPVN (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 14 Jun 2021 11:21:13 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1623683950; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=TJIzTODCwLEjxwUo1iOeBQyvLl2DkeEOo+G6pbvLs7s=;
 b=QIL+zqn+EQtkPej4un1gYwZID07JJu3UkFmwFuFPyTxbFHcSlTeXRNPQ0EfHWOPcErtluZwN
 2Xk2dHadpYqfxbUBaxar3zLK34xMl792RfSPVlR/mdaeMv42Uj+oeEozoYq2CbEh7M7ABP+j
 JiBsMPI6HIEVj69fU1aX5EkLmp4=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-east-1.postgun.com with SMTP id
 60c7735b51f29e6baec59535 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 14 Jun 2021 15:18:51
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 9DCE7C433D3; Mon, 14 Jun 2021 15:18:50 +0000 (UTC)
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id EDF12C433F1;
        Mon, 14 Jun 2021 15:18:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org EDF12C433F1
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v6 01/12] wcn36xx: Return result of set_power_params in
 suspend
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20210605011140.2004643-2-bryan.odonoghue@linaro.org>
References: <20210605011140.2004643-2-bryan.odonoghue@linaro.org>
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc:     wcn36xx@lists.infradead.org, linux-wireless@vger.kernel.org,
        bryan.odonoghue@linaro.org, shawn.guo@linaro.org,
        benl@squareup.com, loic.poulain@linaro.org,
        bjorn.andersson@linaro.org
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-Id: <20210614151850.9DCE7C433D3@smtp.codeaurora.org>
Date:   Mon, 14 Jun 2021 15:18:50 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Bryan O'Donoghue <bryan.odonoghue@linaro.org> wrote:

> wcn36xx_smd_set_power_params() can return an error. For the purposes of
> entering into suspend we need the suspend() function to trap and report
> errors up the stack.
> 
> First step in this process is reporting the existing result code for
> wcn36xx_smd_set_power_params().
> 
> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> Tested-by: Benjamin Li <benl@squareup.com>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

12 patches applied to ath-next branch of ath.git, thanks.

ba4e967379f0 wcn36xx: Return result of set_power_params in suspend
f2f49601067b wcn36xx: Run suspend for the first ieee80211_vif
5478c41fce5d wcn36xx: Add ipv4 ARP offload support in suspend
6feb634f4d9f wcn36xx: Do not flush indication queue on suspend/resume
c7a61af55976 wcn36xx: Add ipv6 address tracking
1456223c4684 wcn36xx: Add ipv6 namespace offload in suspend
8974e5917b31 wcn36xx: Add set_rekey_data callback
6693f7675c9b wcn36xx: Add GTK offload to WoWLAN path
bedf1169bcae wcn36xx: Add GTK offload info to WoWLAN resume
60f0078b1ebd wcn36xx: Add Host suspend indication support
ebe7c1a6635f wcn36xx: Add host resume request support
1e2e8ee95734 wcn36xx: Enable WOWLAN flags

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20210605011140.2004643-2-bryan.odonoghue@linaro.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

