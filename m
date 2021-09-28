Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C922341B22F
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Sep 2021 16:35:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241249AbhI1OhH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 28 Sep 2021 10:37:07 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:47184 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241220AbhI1OhG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 28 Sep 2021 10:37:06 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1632839727; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=hdFZdGJQlz//wKTa56GRTPUzh1HO1dzfR9oJDIq1l44=;
 b=GRS+9tfu+kzn4UDD8fyPK8aBFP26EtRI9/uBnWZS33KO/hg9sBWoj3I/67PaptkqvlO4I0v0
 3xWg5Zq8Xpy2G8xpHPt2zNV5Fse9XWrakgyhSJyVhaO82cfmFE97ag9qHbyz+T6DBoIE1u/T
 +QTOzBX4ivI6nkDzobLjtjGlNR0=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-east-1.postgun.com with SMTP id
 615328059ffb413149c7d9cc (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 28 Sep 2021 14:34:45
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 359DCC43460; Tue, 28 Sep 2021 14:34:45 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        MISSING_DATE,MISSING_MID,SPF_FAIL autolearn=no autolearn_force=no
        version=3.4.0
Received: from tykki.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 81C65C4338F;
        Tue, 28 Sep 2021 14:34:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 81C65C4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3] ath10k: high latency fixes for beacon buffer
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20210818232627.2040121-1-festevam@denx.de>
References: <20210818232627.2040121-1-festevam@denx.de>
To:     Fabio Estevam <festevam@denx.de>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        hch@lst.de, erik.stromdahl@gmail.com, peter.oh@eero.com,
        aspriel@gmail.com, marex@denx.de, alagusankar@silex-india.com,
        Fabio Estevam <festevam@denx.de>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-Id: <20210928143445.359DCC43460@smtp.codeaurora.org>
Date:   Tue, 28 Sep 2021 14:34:45 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fabio Estevam <festevam@denx.de> wrote:

> Beacon buffer for high latency devices does not use DMA. other similar
> buffer allocation methods in the driver have already been modified for
> high latency path. Fix the beacon buffer allocation left out in the
> earlier high latency changes.
> 
> Signed-off-by: Alagu Sankar <alagusankar@silex-india.com>
> Signed-off-by: Erik Stromdahl <erik.stromdahl@gmail.com>
> [fabio: adapt it to use ar->bus_param.dev_type ]
> Signed-off-by: Fabio Estevam <festevam@denx.de>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

e263bdab9c0e ath10k: high latency fixes for beacon buffer

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20210818232627.2040121-1-festevam@denx.de/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

