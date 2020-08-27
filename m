Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63C4C2547C3
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Aug 2020 16:54:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726972AbgH0NNa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 27 Aug 2020 09:13:30 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:24143 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727822AbgH0NMg (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 27 Aug 2020 09:12:36 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1598533956; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=hmEshxg1YF0Iyn3XmSVpYlfwZnsUShJtTsrCAfkPOmg=;
 b=F/cmM+1P2yWQlz1X5ZkF+Qyi4PnHQJ2sa2nwI10ZEbTeSoTklxftyownTR4n/Mm0ycevD4jd
 w7cuTfMXdDP3Vb7YWjd+oWZn1ff6uiW+9Yy5kMx8IJbyuDM8/P6Mp7mUeWDP5oIdByVoP9LW
 Pft2K1BK3LE4IiHqvCmFZ92s1go=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-west-2.postgun.com with SMTP id
 5f47b1438741f54bbdbbb4e8 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 27 Aug 2020 13:12:35
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 95088C43387; Thu, 27 Aug 2020 13:12:35 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 9D9E9C433CA;
        Thu, 27 Aug 2020 13:12:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9D9E9C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 5.9] mt76: mt7615: use v1 MCU API on MT7615 to fix issues
 with
 adding/removing stations
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20200812102332.11812-1-nbd@nbd.name>
References: <20200812102332.11812-1-nbd@nbd.name>
To:     Felix Fietkau <nbd@nbd.name>
Cc:     linux-wireless@vger.kernel.org
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20200827131235.95088C43387@smtp.codeaurora.org>
Date:   Thu, 27 Aug 2020 13:12:35 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Felix Fietkau <nbd@nbd.name> wrote:

> The implementation of embedding WTBL update inside the STA_REC update is buggy
> on the MT7615 v2 firmware. This leads to connection issues after a station has
> connected and disconnected again.
> 
> Switch to the v1 MCU API ops, since they have received much more testing and
> should be more stable.
> 
> On MT7622 and later, the v2 API is more actively used, so we should keep using
> it as well.
> 
> Fixes: 6849e29ed92e ("mt76: mt7615: add starec operating flow for firmware v2")
> Cc: stable@vger.kernel.org
> Signed-off-by: Felix Fietkau <nbd@nbd.name>

Patch applied to wireless-drivers.git, thanks.

d1c9da9e4c93 mt76: mt7615: use v1 MCU API on MT7615 to fix issues with adding/removing stations

-- 
https://patchwork.kernel.org/patch/11710607/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

