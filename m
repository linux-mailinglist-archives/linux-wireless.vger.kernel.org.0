Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 639C2318560
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Feb 2021 07:53:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbhBKGwG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 11 Feb 2021 01:52:06 -0500
Received: from mail29.static.mailgun.info ([104.130.122.29]:50966 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229642AbhBKGvq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 11 Feb 2021 01:51:46 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1613026286; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=2KpP5YTgEZT/MqWx9oBGC3EcB2HHt0YvagbBL1reDRU=;
 b=RBKuUEN9MMERe4Bxro5wWQZrbKQEmTODtfh3kMca7Y7Cc7Ih5TLALUXDmOMqGLz52e03gxtl
 yTShBvPUnPqwKmHrEaNxxX6nE4kwu0eqHLhZl6n3CgleOzDNKzyJsum5M/CZydGvIDzbRlsc
 QQLy5CUAjx2uNBG6zzSnu5H6Do0=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-west-2.postgun.com with SMTP id
 6024d3d4d5a7a3baaed4913c (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 11 Feb 2021 06:51:00
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id EBF7BC433CA; Thu, 11 Feb 2021 06:50:59 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        MISSING_DATE,MISSING_MID,SPF_FAIL,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7E460C43461;
        Thu, 11 Feb 2021 06:50:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7E460C43461
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 3/5] ath10k: change ath10k_offchan_tx_work() peer present
 msg
 to a warn
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <3b1f71272d56ee1d7f567fbce13bdb56cc06d342.1612915444.git.skhan@linuxfoundation.org>
References: <3b1f71272d56ee1d7f567fbce13bdb56cc06d342.1612915444.git.skhan@linuxfoundation.org>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     davem@davemloft.net, kuba@kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20210211065059.EBF7BC433CA@smtp.codeaurora.org>
Date:   Thu, 11 Feb 2021 06:50:59 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Shuah Khan <skhan@linuxfoundation.org> wrote:

> Based on the comment block in this function and the FIXME for this, peer
> being present for the offchannel tx is unlikely. Peer is deleted once tx
> is complete. Change peer present msg to a warn to detect this condition.
> 
> Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

83bae26532ca ath10k: change ath10k_offchan_tx_work() peer present msg to a warn

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/3b1f71272d56ee1d7f567fbce13bdb56cc06d342.1612915444.git.skhan@linuxfoundation.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

