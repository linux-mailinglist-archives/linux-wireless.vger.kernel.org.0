Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F2BA194761
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2020 20:22:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727611AbgCZTWZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 26 Mar 2020 15:22:25 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:26603 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726067AbgCZTWZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 26 Mar 2020 15:22:25 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1585250545; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=64E+nL6RpQ1sJSbBZTs5xkAxedmth9tYUmjGCvtmLQE=;
 b=JQqxQemLF7mjNPg7fL864RoAlKxZEWwWUQlUVoduJGgrSamNv8LpEXh012uzok7Qtc/8Yd/4
 wZBTeY2RHUyYuQ4EGcFeVWNF+TBI/HJiaoxiZ/LgHnco463sGbh1jY/gbOl8iXmGf3rgaCAd
 EJxShgX8PJHjyBOflrt7wtrI2c0=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e7d00f0.7f7d64b446f8-smtp-out-n04;
 Thu, 26 Mar 2020 19:22:24 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 1605EC4478C; Thu, 26 Mar 2020 19:22:24 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5FE20C433BA;
        Thu, 26 Mar 2020 19:22:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5FE20C433BA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] rtw88: fix non-increase management packet sequence number
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20200326020408.25218-1-yhchuang@realtek.com>
References: <20200326020408.25218-1-yhchuang@realtek.com>
To:     <yhchuang@realtek.com>
Cc:     <linux-wireless@vger.kernel.org>, <tehuang@realtek.com>,
        <briannorris@chromium.org>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20200326192224.1605EC4478C@smtp.codeaurora.org>
Date:   Thu, 26 Mar 2020 19:22:24 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

<yhchuang@realtek.com> wrote:

> From: Tzu-En Huang <tehuang@realtek.com>
> 
> In previous setting, management packets' sequence numbers will
> not increase and always stay at 0. Add hw sequence number support
> for mgmt packets.
> The table below shows different sequence number setting in the
> tx descriptor.
> 
> seq num ctrl      | EN_HWSEQ | DISQSELSEL | HW_SSN_SEL
> ------------------------------------------------------
> sw ctrl           |    0     |    N/A     |    N/A
> hw ctrl per MACID |    1     |     0      |    N/A
> hw ctrl per HWREG |    1     |     1      |HWREG(0/1/2/3)
> 
> Signed-off-by: Tzu-En Huang <tehuang@realtek.com>
> Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
> Reviewed-by: Brian Norris <briannorris@chromium.org>
> Tested-by: Brian Norris <briannorris@chromium.org>

Patch applied to wireless-drivers-next.git, thanks.

2542469d1258 rtw88: fix non-increase management packet sequence number

-- 
https://patchwork.kernel.org/patch/11458951/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
