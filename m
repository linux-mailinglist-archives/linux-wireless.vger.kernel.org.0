Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 352E33F3BE2
	for <lists+linux-wireless@lfdr.de>; Sat, 21 Aug 2021 19:46:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234275AbhHURq4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 21 Aug 2021 13:46:56 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:60803 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234160AbhHURqx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 21 Aug 2021 13:46:53 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1629567973; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=DcK/OGJk6ACbAcRkWtOSoJuwTGWJyDfcDuxnGGY8Hq8=;
 b=Kz303e7yfp0J+r+SLXTlE9JpEZoihugWrlZQsqAZjPs/sAc9AJ/g34QFWu8tqENDsWz/h617
 Lp/Z/175RQnxkD2dlXwxdQqfvmyjtZbsQaKUALxKuIFtc+1Urz75YEtx8OYLCMr/8h/oUedD
 jdGqI1pD4a7XpRhX91ZlvlIJvxM=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 61213bdb2b9e91b688d01778 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sat, 21 Aug 2021 17:46:03
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id C9AF3C43617; Sat, 21 Aug 2021 17:46:03 +0000 (UTC)
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6527CC4338F;
        Sat, 21 Aug 2021 17:45:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 6527CC4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/3] wilc1000: use goto labels on error path
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20210806081229.721731-2-claudiu.beznea@microchip.com>
References: <20210806081229.721731-2-claudiu.beznea@microchip.com>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     <ajay.kathat@microchip.com>, <davem@davemloft.net>,
        <kuba@kernel.org>, <linux-wireless@vger.kernel.org>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-Id: <20210821174603.C9AF3C43617@smtp.codeaurora.org>
Date:   Sat, 21 Aug 2021 17:46:03 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Claudiu Beznea <claudiu.beznea@microchip.com> wrote:

> Use goto labels on error path for probe functions. This makes code easier
> to read. With this introduce also netdev_cleanup and call it where
> necessary.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>

3 patches applied to wireless-drivers-next.git, thanks.

dc8b338f3bcd wilc1000: use goto labels on error path
f36a0ee599c9 wilc1000: dispose irq on failure path
1d89fd1a39d1 wilc1000: use devm_clk_get_optional()

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20210806081229.721731-2-claudiu.beznea@microchip.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

