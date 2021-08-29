Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B51803FAA30
	for <lists+linux-wireless@lfdr.de>; Sun, 29 Aug 2021 10:34:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234817AbhH2Iev (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 29 Aug 2021 04:34:51 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:50590 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232155AbhH2Iev (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 29 Aug 2021 04:34:51 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1630226039; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=CqkqfMg4oJW+NR5ZcbNrA7JWamc2AiDMt7QGrsowWPs=;
 b=hJJi638w/8mmlFBJpsN3NkmzP55olTu7RuYeBS40pmK85bA6XJJUryXMGflQ5wji+8Jfrf7l
 Kp0SpW9+8Y9lSTsHEchuOwxrZaXoV4wkPSwQRGayR0Q9BZ8/Mw7pRWSOJrQihX61y+VGtdqu
 UVIS8FsAEZddc6P0XDeS7SWJu+A=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-west-2.postgun.com with SMTP id
 612b46764cd9015037362467 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sun, 29 Aug 2021 08:33:58
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id C99BDC4360C; Sun, 29 Aug 2021 08:33:58 +0000 (UTC)
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2E41EC4338F;
        Sun, 29 Aug 2021 08:33:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 2E41EC4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2] wilc1000: Convert module-global "isinit" to
 device-specific variable
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20210828151346.3012697-1-davidm@egauge.net>
References: <20210828151346.3012697-1-davidm@egauge.net>
To:     David Mosberger-Tang <davidm@egauge.net>
Cc:     linux-wireless@vger.kernel.org,
        Ajay Singh <ajay.kathat@microchip.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        David Mosberger-Tang <davidm@egauge.net>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-Id: <20210829083358.C99BDC4360C@smtp.codeaurora.org>
Date:   Sun, 29 Aug 2021 08:33:58 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

David Mosberger-Tang <davidm@egauge.net> wrote:

> Move static "isinit" variable to wilc_spi structure to allow multiple
> WILC1000 devices per machine.
> 
> Signed-off-by: David Mosberger-Tang <davidm@egauge.net>

Patch applied to wireless-drivers-next.git, thanks.

50cbbfd41e9f wilc1000: Convert module-global "isinit" to device-specific variable

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20210828151346.3012697-1-davidm@egauge.net/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

