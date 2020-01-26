Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 96D07149A24
	for <lists+linux-wireless@lfdr.de>; Sun, 26 Jan 2020 11:36:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729262AbgAZKgu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 26 Jan 2020 05:36:50 -0500
Received: from mail25.static.mailgun.info ([104.130.122.25]:43246 "EHLO
        mail25.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729145AbgAZKgu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 26 Jan 2020 05:36:50 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1580035010; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=ehBLlDDkn7L0JU9M7qVI14AauqrT7TnPN/+3/cb9EYI=;
 b=SJWke56+vEICM00ZY3YRqF+VNddizMHGX6wZ5CQbFq6XFVKL1t/ElVZLhDWWDG+TFZcI9j8u
 TlXXsaHmXpVG2Z7pbBORI7Dt8SbtggIetMCKr1IroGzvMhMRGMNhMziM61hNGG4LWvneN9QW
 HSkMsrvyaBaP1k1QuJJsaPnHLvw=
X-Mailgun-Sending-Ip: 104.130.122.25
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e2d6bbd.7f9dd0834298-smtp-out-n01;
 Sun, 26 Jan 2020 10:36:45 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 9E2D4C4479F; Sun, 26 Jan 2020 10:36:45 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C371DC433CB;
        Sun, 26 Jan 2020 10:36:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C371DC433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3 1/2] dt: bindings: add dt entry flag to skip SCM call
 for msa region
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20200103134414.15457-2-govinds@codeaurora.org>
References: <20200103134414.15457-2-govinds@codeaurora.org>
To:     Govind Singh <govinds@codeaurora.org>
Cc:     robh@kernel.org, devicetree@vger.kernel.org,
        ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Govind Singh <govinds@codeaurora.org>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20200126103645.9E2D4C4479F@smtp.codeaurora.org>
Date:   Sun, 26 Jan 2020 10:36:45 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Govind Singh <govinds@codeaurora.org> wrote:

> Add boolean context flag to disable SCM call for statically
> mapped msa region.
> 
> Signed-off-by: Govind Singh <govinds@codeaurora.org>
> Acked-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

2 patches applied to ath-next branch of ath.git, thanks.

6ca71a10aee8 dt: bindings: add dt entry flag to skip SCM call for msa region
ab000ea6a393 ath10k: Don't call SCM interface for statically mapped msa region

-- 
https://patchwork.kernel.org/patch/11316913/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
