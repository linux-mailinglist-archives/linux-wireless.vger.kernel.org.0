Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2AFC915BC5E
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Feb 2020 11:07:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729653AbgBMKH5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 13 Feb 2020 05:07:57 -0500
Received: from mail27.static.mailgun.info ([104.130.122.27]:42099 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729428AbgBMKH4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 13 Feb 2020 05:07:56 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1581588476; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=HzTg8m7BlycQ6NpwXhbJ+usbAHDIsZRw2k2HjXqwSy4=;
 b=KLvTLSYuvig4aQCCnYjoUOeRF3btRXHHeJxyOMzqYhJlq3n56hJNQMp0rt3jDk+rA2Q+S+HO
 MA8cv1V+y/xPRvftKG6jVtDJzwuFAmU/R3yqyi8uQNBq+cJ8yk+D+HU9I0B5nDiNaVkewVTq
 kIC0XlQpyfYUMelCZpgsIARqOgU=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e451ffb.7fad6e3ebc70-smtp-out-n01;
 Thu, 13 Feb 2020 10:07:55 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id A27CAC433A2; Thu, 13 Feb 2020 10:07:54 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 504AEC43383;
        Thu, 13 Feb 2020 10:07:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 504AEC43383
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3] rtw88: Fix incorrect beamformee role setting
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20200207084729.24882-1-yhchuang@realtek.com>
References: <20200207084729.24882-1-yhchuang@realtek.com>
To:     <yhchuang@realtek.com>
Cc:     <linux-wireless@vger.kernel.org>, <briannorris@chromium.org>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20200213100754.A27CAC433A2@smtp.codeaurora.org>
Date:   Thu, 13 Feb 2020 10:07:54 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

<yhchuang@realtek.com> wrote:

> From: Tzu-En Huang <tehuang@realtek.com>
> 
> In associating and configuring beamformee, bfee->role is not
> correctly set before rtw_chip_ops::config_bfee().
> Fix it by setting it correctly.
> 
> Signed-off-by: Tzu-En Huang <tehuang@realtek.com>
> Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
> Reviewed-by: Chris Chiu <chiu@endlessm.com>

Patch applied to wireless-drivers-next.git, thanks.

aa7619a39ace rtw88: Fix incorrect beamformee role setting

-- 
https://patchwork.kernel.org/patch/11369973/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
