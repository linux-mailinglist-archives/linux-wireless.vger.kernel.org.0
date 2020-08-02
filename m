Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C31E92357E9
	for <lists+linux-wireless@lfdr.de>; Sun,  2 Aug 2020 17:07:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726281AbgHBPHb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 2 Aug 2020 11:07:31 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:22210 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726631AbgHBPHb (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 2 Aug 2020 11:07:31 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1596380851; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=uiQ6p4J6M/PWgQQEVQArcScApjO41SK4n5ktfHYW6Kk=;
 b=YORq4/v9o93nOw+S5bfViNyGyccQ9twZsXg95Xh+O/KmLcpztVl5MIZNPVIZ2vcshJs7yerz
 jnDOmVyGenu/3C1w01dJljLOLfUNvh4LJAllSe0BU+HzQX6mfbIe8Z7boiTPxIAsaFhpqljU
 3fsc4QOhrwH2D4f7gks0+95cUTI=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n18.prod.us-west-2.postgun.com with SMTP id
 5f26d69b849144fbcb456473 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sun, 02 Aug 2020 15:07:07
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 9A4C9C433C9; Sun,  2 Aug 2020 15:07:07 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 50749C433C6;
        Sun,  2 Aug 2020 15:07:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 50749C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3] rtw88: 8821c: coex: add functions and parameters
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20200724054208.31115-1-yhchuang@realtek.com>
References: <20200724054208.31115-1-yhchuang@realtek.com>
To:     <yhchuang@realtek.com>
Cc:     <linux-wireless@vger.kernel.org>, <tehuang@realtek.com>,
        <bigeasy@linutronix.de>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20200802150707.9A4C9C433C9@smtp.codeaurora.org>
Date:   Sun,  2 Aug 2020 15:07:07 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

<yhchuang@realtek.com> wrote:

> From: Ping-Cheng Chen <pc.chen@realtek.com>
> 
> Without this patch, RTL8821CE will not have coex support,
> and will crash the system because of the NULL pointers
> for the coex functions.
> 
> While RTL8822C series are WiFi + BT combo chips, it needs
> the co-existence mechanism for the device to work on both
> WiFi and BT without interfering each other. And the coex
> support has already been added before, most of the mechanisms
> are implemented. The driver should just add corresponding
> functions to operate on different types of chips and its
> coex parameters.
> 
> Fixes: f745eb9ca5bf ("rtw88: 8821c: Add 8821CE to Kconfig and Makefile")
> Signed-off-by: Ping-Cheng Chen <pc.chen@realtek.com>
> Signed-off-by: Tzu-En Huang <tehuang@realtek.com>
> Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>

Patch applied to wireless-drivers-next.git, thanks.

7b080e085943 rtw88: 8821c: coex: add functions and parameters

-- 
https://patchwork.kernel.org/patch/11682059/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

