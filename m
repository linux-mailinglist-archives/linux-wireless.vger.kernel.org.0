Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 478A93A7C46
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Jun 2021 12:44:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231643AbhFOKqC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 15 Jun 2021 06:46:02 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:40104 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231604AbhFOKqC (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 15 Jun 2021 06:46:02 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1623753838; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=eJHUJ3XchNapb61OFLx4Bj9dQxkJA9MLe8GGlEFuNL8=;
 b=YlQDSLNRXGyJqPlrJJI3N58V4+OkgdPnTqJ7cVqDd92XTuZbMwDxbcs/PsJqie7w4I+kyttM
 lkWkqEjJ20b49Sp47KankL2+ZA69EN5i+3PXLlyFgk1cS226/ZlR9g9WVZ24S9gJ/mXRzZXr
 WmsXAnDYyZ+N2d/F3XifiLylL7k=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-east-1.postgun.com with SMTP id
 60c88454e27c0cc77f2a03da (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 15 Jun 2021 10:43:32
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 670B1C433D3; Tue, 15 Jun 2021 10:43:31 +0000 (UTC)
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 20EDBC4338A;
        Tue, 15 Jun 2021 10:43:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 20EDBC4338A
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] brcmsmac: Remove the repeated declaration
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1621844443-38290-1-git-send-email-zhangshaokun@hisilicon.com>
References: <1621844443-38290-1-git-send-email-zhangshaokun@hisilicon.com>
To:     Shaokun Zhang <zhangshaokun@hisilicon.com>
Cc:     <linux-wireless@vger.kernel.org>,
        Shaokun Zhang <zhangshaokun@hisilicon.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-Id: <20210615104331.670B1C433D3@smtp.codeaurora.org>
Date:   Tue, 15 Jun 2021 10:43:31 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Shaokun Zhang <zhangshaokun@hisilicon.com> wrote:

> Function 'brcms_c_stf_phy_txant_upd' are declared twice, remove
> the repeated declaration.
> 
> Cc: Kalle Valo <kvalo@codeaurora.org>
> Signed-off-by: Shaokun Zhang <zhangshaokun@hisilicon.com>

Patch applied to wireless-drivers-next.git, thanks.

5a8e5dae2a22 brcmsmac: Remove the repeated declaration

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/1621844443-38290-1-git-send-email-zhangshaokun@hisilicon.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

