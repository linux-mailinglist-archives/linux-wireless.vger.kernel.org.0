Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57E851E8522
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2020 19:38:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726887AbgE2RiH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 29 May 2020 13:38:07 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:10102 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725601AbgE2RiG (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 29 May 2020 13:38:06 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1590773885; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=u/WtnybzfQDl17fNEUQybCw4WaOXc5lCPriar8g+Ws0=;
 b=fcwgY/M2PLKECgCS3a0fG/8E89gGnVvX+fokYwVUK1JsDZ7Z3NdBOnUG6VtUiwVoqg9KhPCw
 23uPm6qwEYxPfFiGPnJTUBjEI0RfgXLmqCDXdRYhXvpoddxesjttfl5MEq02AG87C67YwWuI
 OxqScHUwtFyi6DCrKXXhCu/dZRo=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-east-1.postgun.com with SMTP id
 5ed1487544a25e00522bb0b7 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 29 May 2020 17:37:57
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 0DD80C43387; Fri, 29 May 2020 17:37:57 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id DBA2BC433CB;
        Fri, 29 May 2020 17:37:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DBA2BC433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] rtw88: 8822c: remove CCK TX setting when switch channel
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20200522091234.24495-1-yhchuang@realtek.com>
References: <20200522091234.24495-1-yhchuang@realtek.com>
To:     <yhchuang@realtek.com>
Cc:     <linux-wireless@vger.kernel.org>, <briannorris@chromium.org>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20200529173757.0DD80C43387@smtp.codeaurora.org>
Date:   Fri, 29 May 2020 17:37:57 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

<yhchuang@realtek.com> wrote:

> From: Chien-Hsun Liao <ben.liao@realtek.com>
> 
> The CCK TX setting when switch channel will fix the CCK to
> path A only, so if the antenna is configured to path B
> (e.g. iw phy set antenna 0x2 0x3 "TX B/RX AB"), then the CCK
> packets can never be delivered to the air if only path B is
> connected with an antenna (it can possibly be transmitted
> through path A, but as path B is configured, the expected
> behavior is incorrect).
> 
> This can also solve the racing issue of CCK TX setting between
> driver and firmware. The CCK TX setting in driver should be
> removed. Otherwise, the CCK TX setting would be wrong when the
> racing occurs.
> 
> Fixes: 297bcf8222f2 ("rtw88: add support for set/get antennas")
> Signed-off-by: Chien-Hsun Liao <ben.liao@realtek.com>
> Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>

Patch applied to wireless-drivers-next.git, thanks.

7967af8de39d rtw88: 8822c: remove CCK TX setting when switch channel

-- 
https://patchwork.kernel.org/patch/11565095/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

