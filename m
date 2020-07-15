Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F995220843
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jul 2020 11:10:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730504AbgGOJKR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 15 Jul 2020 05:10:17 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:26360 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730488AbgGOJKQ (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 15 Jul 2020 05:10:16 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1594804216; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=AP3qerqL8lWlKQ51FpUkJr6BUfgajLoMgJS65Ibc7AY=;
 b=j9OigXpsfAe9XKLephppgADOBaidf9CSwTVIpVuMC5HZEU8JYUPsQSPOtEZdbXGW/gYWu20w
 BJqVzD/2gtHr0ZcDhS03kreQ/1rdXHEJsb2p5a+Xgv5e8xatN9kK6kkxUePeB/9FrR0rtdx6
 whCUDlGzmyzPCs6WiKFzB8orM2w=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n18.prod.us-west-2.postgun.com with SMTP id
 5f0ec7f2c9bd2efa2e0fa5bc (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 15 Jul 2020 09:10:10
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 6F9B2C433C9; Wed, 15 Jul 2020 09:10:10 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E29E7C433CB;
        Wed, 15 Jul 2020 09:10:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E29E7C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 1/5] rtw88: 8821c: add cck pd settings
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20200603094218.19942-2-yhchuang@realtek.com>
References: <20200603094218.19942-2-yhchuang@realtek.com>
To:     <yhchuang@realtek.com>
Cc:     <linux-wireless@vger.kernel.org>, <tehuang@realtek.com>,
        <bigeasy@linutronix.de>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20200715091010.6F9B2C433C9@smtp.codeaurora.org>
Date:   Wed, 15 Jul 2020 09:10:10 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

<yhchuang@realtek.com> wrote:

> From: Tzu-En Huang <tehuang@realtek.com>
> 
> CCK PD can reduce the number of false alarm of the CCK rates.
> It dynamically adjusts the power threshold and CS ratio.
> The values are compared to the values of the previous level, if
> the level is changed, set new values of power threshold and CS
> ratio.
> 
> Implement rtw_chip_ops::cck_pd_set() for 8821c.
> 
> Signed-off-by: Tzu-En Huang <tehuang@realtek.com>
> Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>

5 patches applied to wireless-drivers-next.git, thanks.

11fcb119a758 rtw88: 8821c: add cck pd settings
3a4312828ce1 rtw88: 8821c: add power tracking
5f4eab883c6a rtw88: 8821c: add beamformee support
d47e7371b23a rtw88: single rf path chips don't support TX STBC
f745eb9ca5bf rtw88: 8821c: Add 8821CE to Kconfig and Makefile

-- 
https://patchwork.kernel.org/patch/11585435/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

