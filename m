Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6B69429CF6
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Oct 2021 07:14:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232254AbhJLFQy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 12 Oct 2021 01:16:54 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:42057 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231254AbhJLFQy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 12 Oct 2021 01:16:54 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1634015693; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=ewy6nzJ9f9n9mIG+k3m0sYDU1XuPo3jv+zFPGhYiSug=; b=kAKvz0v03L9MVAy90EaKOnDN0Xs1Y9c+WmAojkiOLS4dNBKljgo6EuHsVx4LNjyy0E7K6vT4
 4FNoe/+KeQWGpteXUIGY5PklYIDEj3LPTXf6Xc0e9TogaAifXgr7KKquz6zUNswZeUPjERL7
 bY/X3djfiSMMCScHk5yA4bQsLd8=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-east-1.postgun.com with SMTP id
 616519cb446c6db0cb053314 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 12 Oct 2021 05:14:51
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id DEC4BC4360C; Tue, 12 Oct 2021 05:14:50 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from tynnyri.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A24A3C4338F;
        Tue, 12 Oct 2021 05:14:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org A24A3C4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     greearb@candelatech.com
Cc:     linux-wireless@vger.kernel.org
Subject: Re: [PATCH] mt76: mt7915: add debugging for MCU command timeouts.
References: <20211011205406.23485-1-greearb@candelatech.com>
Date:   Tue, 12 Oct 2021 08:14:47 +0300
In-Reply-To: <20211011205406.23485-1-greearb@candelatech.com> (greearb's
        message of "Mon, 11 Oct 2021 13:54:06 -0700")
Message-ID: <878ryy25a0.fsf@tynnyri.adurom.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

greearb@candelatech.com writes:

> From: Ben Greear <greearb@candelatech.com>
>
> Print information about whether the message is the first timeout,
> and also print info if we manage to recover after a timeout.
>
> Signed-off-by: Ben Greear <greearb@candelatech.com>
> ---
>
> NOTE:  Not sure this is really something folks would want upstream, but
> maybe it helps someone else trying to debug this driver.

If the patch is not ready for upstream it's a good idea to mark it as
RFC, that way the maintainers can skip it automatically.

> +	if (mdev->first_failed_mcu_cmd) {
> +		dev_err(mdev->dev, "MCU: First success after failure: Message %08x (cid %lx ext_cid: %lx seq %d)\n",
> +			cmd, FIELD_GET(__MCU_CMD_FIELD_ID, cmd),
> +			FIELD_GET(__MCU_CMD_FIELD_EXT_ID, cmd), seq);
> +		mdev->first_failed_mcu_cmd = 0;
> +	}
> +	else {
> +		// verbose debugging
> +		//dev_err(mdev->dev, "MCU: OK response to message %08x (cid %lx ext_cid: %lx seq %d)\n",
> +		//	cmd, FIELD_GET(__MCU_CMD_FIELD_ID, cmd),
> +		//	FIELD_GET(__MCU_CMD_FIELD_EXT_ID, cmd), seq);
> +	}

No C++ comments and no commented out code, please.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
