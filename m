Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A28E1B253C
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2020 13:39:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727120AbgDULj1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 21 Apr 2020 07:39:27 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:58912 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726691AbgDULj1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 21 Apr 2020 07:39:27 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1587469166; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=MHYJbNz6ipw5UNrRMw20t/cPhwMrWUiOngdnmW95rQ4=; b=Usj9zhvhYt6cARAxRTCFLRyDeyLC3HGNLPcj/sY7HFWNm10dt0ryZTtdTxW6g7oHcYsqr5i4
 YSeDPdd/pF0UpLMqNMKXZud/UNC5r+fYUQYiWH9D1AIi6MJ4lH4E8TvZUStW9Fa5Ycnbqgz1
 xZraxbJOnN+j8Qx/rtXc9EFowbM=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e9edb6e.7f3ea97437d8-smtp-out-n04;
 Tue, 21 Apr 2020 11:39:26 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 1BD05C433CB; Tue, 21 Apr 2020 11:39:25 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D90EDC433D2;
        Tue, 21 Apr 2020 11:39:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D90EDC433D2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Raz Bouganim <r-bouganim@ti.com>
Cc:     <linux-wireless@vger.kernel.org>, <d-levy@ti.com>
Subject: Re: [PATCH v2] wlcore: Adding suppoprt for IGTK key in wlcore driver
References: <1587461946-31727-1-git-send-email-r-bouganim@ti.com>
Date:   Tue, 21 Apr 2020 14:39:20 +0300
In-Reply-To: <1587461946-31727-1-git-send-email-r-bouganim@ti.com> (Raz
        Bouganim's message of "Tue, 21 Apr 2020 12:39:06 +0300")
Message-ID: <875zdtoyon.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Raz Bouganim <r-bouganim@ti.com> writes:

> This patch adding support for new cipher suite - AES-CMAC in wlcore driver.
> This patch is required for support PMF/WPA3 connection to install IGTK key.
>
> Signed-off-by: Raz Bouganim <r-bouganim@ti.com>
> ---
>  drivers/net/wireless/ti/wlcore/cmd.h  | 1 +
>  drivers/net/wireless/ti/wlcore/main.c | 4 ++++
>  2 files changed, 5 insertions(+)
>
> diff --git a/drivers/net/wireless/ti/wlcore/cmd.h b/drivers/net/wireless/ti/wlcore/cmd.h
> index f2609d5..1d14bd1 100644
> --- a/drivers/net/wireless/ti/wlcore/cmd.h
> +++ b/drivers/net/wireless/ti/wlcore/cmd.h
> @@ -458,6 +458,7 @@ enum wl1271_cmd_key_type {
>  	KEY_TKIP = 2,
>  	KEY_AES  = 3,
>  	KEY_GEM  = 4,
> +KEY_IGTK = 5,
>  };

The indentation is still all broken up, look at the end result:

enum wl1271_cmd_key_type {
	KEY_NONE = 0,
	KEY_WEP  = 1,
	KEY_TKIP = 2,
	KEY_AES  = 3,
	KEY_GEM  = 4,
KEY_IGTK = 5,
};

Can someone help Raz with this?

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
