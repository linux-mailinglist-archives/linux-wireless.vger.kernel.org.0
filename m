Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECFC01CD899
	for <lists+linux-wireless@lfdr.de>; Mon, 11 May 2020 13:35:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729707AbgEKLfU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 11 May 2020 07:35:20 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:61501 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729594AbgEKLfT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 11 May 2020 07:35:19 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1589196919; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=IKNFWdB/cl6ekQSgv/lJQx9RBSI05YRCIJLyViH5ZBQ=;
 b=Lyz/08v6llkwSJXEY7E7o26mnQkqoSPiQtrh3/3TBvo2AhWAAeJQ6qsye4tjz3KiZo85vdpz
 ig8yUgY9ZXcoZgQPzSIh2r+i20qX9B12jiyI/aclEkUJYZbiSaU1bY8bbOl71r4rG3AkUiUM
 FWome74cOeaOCMQvOqwMHdsne+4=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5eb93870.7f386c42efb8-smtp-out-n01;
 Mon, 11 May 2020 11:35:12 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 84D41C43637; Mon, 11 May 2020 11:35:12 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A17E9C433F2;
        Mon, 11 May 2020 11:35:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A17E9C433F2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath11k: fix htt stats module not handle multiple skbs
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1588698693-6218-1-git-send-email-pradeepc@codeaurora.org>
References: <1588698693-6218-1-git-send-email-pradeepc@codeaurora.org>
To:     Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>,
        Miles Hu <milehu@codeaurora.org>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20200511113512.84D41C43637@smtp.codeaurora.org>
Date:   Mon, 11 May 2020 11:35:12 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Pradeep Kumar Chitrapu <pradeepc@codeaurora.org> wrote:

> HTT EXT stats comes in stream of TLVs spanning over multiple
> messages. Currently completion is being sent for each message
> which is creating a race where stats_req is being accessed
> for filling in second message after the memory is already
> freed in release operation. Fix this by issuing completion
> once all the messages are received and processed. Driver
> knows this info from DONE bit set in htt msg.
> 
> Also fix locking required for htt stats.
> 
> Co-developed-by: Miles Hu <milehu@codeaurora.org>
> Signed-off-by: Miles Hu <milehu@codeaurora.org>
> Signed-off-by: Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Kbuild bot reported unlock missing in ath11k_write_htt_stats_reset(). Please
fix that and send v2.

-- 
https://patchwork.kernel.org/patch/11529687/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
