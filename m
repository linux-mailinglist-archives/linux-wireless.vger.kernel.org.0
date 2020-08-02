Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABC652357F4
	for <lists+linux-wireless@lfdr.de>; Sun,  2 Aug 2020 17:13:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726347AbgHBPNU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 2 Aug 2020 11:13:20 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:57574 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726150AbgHBPNU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 2 Aug 2020 11:13:20 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1596381199; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=kTJ9EwEergVazsadxuSJN8MS/2CcrhHH6Ff1wRagCa4=;
 b=p9thJCt6GoCudac+FU+iIJtNlRPGfXqjnXHSCHVn5CwuZeLe3y5CJMatEZKXXwAD9tEAY6Z2
 ZKgm0UKYi2QiuKl0TElnyUOhUHwguorlVup1j8xNAo/2vdOx8fzGuNxqghwB2vUJDUaUQaoY
 12nP9TLIjoSsN5UYwFRQoPKjyAU=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n16.prod.us-east-1.postgun.com with SMTP id
 5f26d7f3798b102968febc1c (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sun, 02 Aug 2020 15:12:51
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 98E99C43391; Sun,  2 Aug 2020 15:12:50 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 84BDEC433C9;
        Sun,  2 Aug 2020 15:12:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 84BDEC433C9
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] wilc1000: Move wilc1000 SDIO ID's from driver source to
 common header file
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20200717051134.19160-1-ajay.kathat@microchip.com>
References: <20200717051134.19160-1-ajay.kathat@microchip.com>
To:     <Ajay.Kathat@microchip.com>
Cc:     <linux-wireless@vger.kernel.org>, <Claudiu.Beznea@microchip.com>,
        <Sripad.Balwadgi@microchip.com>, <ulf.hansson@linaro.org>,
        <pali@kernel.org>, <Ajay.Kathat@microchip.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20200802151250.98E99C43391@smtp.codeaurora.org>
Date:   Sun,  2 Aug 2020 15:12:50 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

<Ajay.Kathat@microchip.com> wrote:

> From: Ajay Singh <ajay.kathat@microchip.com>
> 
> Moved macros used for Vendor/Device ID from wilc1000 driver to common
> header file and changed macro name for consistency with other macros.
> 
> Signed-off-by: Ajay Singh <ajay.kathat@microchip.com>
> Acked-by: Ulf Hansson <ulf.hansson@linaro.org>
> Acked-by: Pali Rohár <pali@kernel.org>

Patch applied to wireless-drivers-next.git, thanks.

c83e2a6e2fbb wilc1000: Move wilc1000 SDIO ID's from driver source to common header file

-- 
https://patchwork.kernel.org/patch/11668967/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

