Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BDB56182B14
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2020 09:21:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726299AbgCLIVA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 12 Mar 2020 04:21:00 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:63909 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726000AbgCLIVA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 12 Mar 2020 04:21:00 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1584001260; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=SJVpS4rryZOSoVPs1JvqNkJxEB+vynpRFt2HSiofSY4=;
 b=DdxOvZvISH+/5J4IOv1TBr6fwM76budtZAOwooc0nYA4aZ5K5t5hbWT6TAVLFHJIc0x5uBVl
 B+Ibow9h52sW1OzK7Imz2s46wz13P3TTZz8jbd6+vHT49JFE5MbL2zVBWAfb7OtMHwgpI4lu
 qD7+jFy5MNyKLpKsa/nwIjse3n0=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e69f0e0.7faaf59445e0-smtp-out-n02;
 Thu, 12 Mar 2020 08:20:48 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 6A40FC433BA; Thu, 12 Mar 2020 08:20:47 +0000 (UTC)
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E5973C433CB;
        Thu, 12 Mar 2020 08:20:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E5973C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] Allow qca988x family to support ack rssi of tx data
 packets.
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1581575451-948-1-git-send-email-yiboz@codeaurora.org>
References: <1581575451-948-1-git-send-email-yiboz@codeaurora.org>
To:     Yibo Zhao <yiboz@codeaurora.org>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Yibo Zhao <yiboz@codeaurora.org>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20200312082047.6A40FC433BA@smtp.codeaurora.org>
Date:   Thu, 12 Mar 2020 08:20:47 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Yibo Zhao <yiboz@codeaurora.org> wrote:

> Hardwares tested : QCA9887
> Firmwares tested : 10.4-3.9.0.1-00036
> 
> Signed-off-by: Yibo Zhao <yiboz@codeaurora.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

5637c4ca961b ath10k: allow qca988x family to support ack rssi of tx data packets.

-- 
https://patchwork.kernel.org/patch/11379917/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
