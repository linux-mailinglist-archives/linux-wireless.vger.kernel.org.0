Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C026A2DCCBB
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Dec 2020 07:51:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726841AbgLQGuz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Dec 2020 01:50:55 -0500
Received: from so254-31.mailgun.net ([198.61.254.31]:22191 "EHLO
        so254-31.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726503AbgLQGux (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Dec 2020 01:50:53 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1608187827; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=Ww4v7MTHov39K9UP8xOZg3TU6Ab9s0FmA5nCrJFB4IA=;
 b=pYtlt1ZWnq834ocJz9HDQXfYOF9e7eodrr6U8ROmUUC23xWFlE4DRwdzrvaNKqrmUmmrYHuV
 SMq4x8hhuc/xa80wAiJhWjr//vuQiSSL5uMmDaNbIZHEvV1A3gHZINAS/HHSlpDeexDrlJLs
 HOYIWfH1OmYkyMFa/U1vIE8uzfA=
X-Mailgun-Sending-Ip: 198.61.254.31
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n09.prod.us-east-1.postgun.com with SMTP id
 5fdaffab0564dfefcdcef385 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 17 Dec 2020 06:50:19
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 3BB49C433ED; Thu, 17 Dec 2020 06:50:19 +0000 (UTC)
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D36C2C433CA;
        Thu, 17 Dec 2020 06:50:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D36C2C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2] ath10k: Remove voltage regulator votes during wifi
 disable
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1607713230-18382-1-git-send-email-pillair@codeaurora.org>
References: <1607713230-18382-1-git-send-email-pillair@codeaurora.org>
To:     Rakesh Pillai <pillair@codeaurora.org>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org, briannorris@chromium.org,
        dianders@chromium.org, kuabhs@chromium.org,
        youghand@codeaurora.org, Rakesh Pillai <pillair@codeaurora.org>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20201217065019.3BB49C433ED@smtp.codeaurora.org>
Date:   Thu, 17 Dec 2020 06:50:19 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Rakesh Pillai <pillair@codeaurora.org> wrote:

> When the wlan is disabled, i.e when all the interfaces are
> deleted, voltage regulator votes are not removed. This leads
> to more power consumption even when wlan is disabled.
> 
> Move the adding/removing of voltage regulator votes as part
> of hif power on/off in SNOC targets, so that these voltage
> regulator votes are there only when wlan is enabled.
> 
> Tested-on: WCN3990 hw1.0 SNOC WLAN.HL.3.1-01040-QCAHLSWMTPLZ-1
> 
> Signed-off-by: Rakesh Pillai <pillair@codeaurora.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

5f1aa93ffa1f ath10k: Remove voltage regulator votes during wifi disable

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/1607713230-18382-1-git-send-email-pillair@codeaurora.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

