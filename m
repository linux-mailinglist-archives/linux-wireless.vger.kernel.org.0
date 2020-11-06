Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17A382A912B
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Nov 2020 09:22:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726662AbgKFIWl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 6 Nov 2020 03:22:41 -0500
Received: from m42-4.mailgun.net ([69.72.42.4]:36949 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726653AbgKFIWl (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 6 Nov 2020 03:22:41 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1604650961; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=sRdBmCfzatWbAVTb9wJNNBZw1R43b3wB8RADWXLzxl4=;
 b=ZJcFff7X4upx+BhDNCGDN5mELMvTiEyRcUD9VY1rpStoy9vtnd1DlLR//fvwvbg1aQGHH8Qp
 fdwAQXj1AnlGxFnXKb3GLMBNVdQ5oEMJBTwCx/lkNUkmr+4BuMKvtSLK/m0g8prY0eV+hj2J
 kavtxrNEy9KsSmRzN8YPuhqt1Kc=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-west-2.postgun.com with SMTP id
 5fa507ca1d3dde441c62f389 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 06 Nov 2020 08:22:34
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id A0FEFC433C9; Fri,  6 Nov 2020 08:22:34 +0000 (UTC)
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 478D6C433C6;
        Fri,  6 Nov 2020 08:22:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 478D6C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] MAINTAINERS: update maintainers list for Cypress
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20201030085610.145679-1-chi-hsien.lin@cypress.com>
References: <20201030085610.145679-1-chi-hsien.lin@cypress.com>
To:     Chi-Hsien Lin <chi-hsien.lin@cypress.com>
Cc:     linux-wireless@vger.kernel.org, brcm80211-dev-list@broadcom.com,
        brcm80211-dev-list@cypress.com,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Wright Feng <wright.feng@cypress.com>,
        Chi-Hsien Lin <chi-hsien.lin@cypress.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20201106082234.A0FEFC433C9@smtp.codeaurora.org>
Date:   Fri,  6 Nov 2020 08:22:34 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Chi-Hsien Lin <chi-hsien.lin@cypress.com> wrote:

> - Update maintainers' email with Infineon hosted email
> - Add Chung-hsien Hsu as a maintainer
> 
> Signed-off-by: Chi-Hsien Lin <chi-hsien.lin@cypress.com>
> Signed-off-by: Wright Feng <wright.feng@cypress.com>

Patch applied to wireless-drivers.git, thanks.

d85b4b2bf2d4 MAINTAINERS: update maintainers list for Cypress

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20201030085610.145679-1-chi-hsien.lin@cypress.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

