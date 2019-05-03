Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 982B712BFD
	for <lists+linux-wireless@lfdr.de>; Fri,  3 May 2019 13:07:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727425AbfECLHJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 3 May 2019 07:07:09 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:51078 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726396AbfECLHJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 3 May 2019 07:07:09 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id D1D6F60E57; Fri,  3 May 2019 11:07:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1556881628;
        bh=yIKJRIZdelLZOg0RH08ruz2IDQDLuCeHtYEyJ1svdtQ=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=BVjzbW0/d0icck08gn/12Q3Uvu4DsSvfOwMHwYdMisjgdCKhbLmacagOSNgFHvd39
         XErTYrikfaDobPgw2q3m9mOqWL91BY349gqotJZRbqFOCoAVWcnma3GaPJzhs9P+P6
         1hevSfk6dXC4wJNQyYJJ0TlePyg9X1naFtKGj+2c=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id F1143608D4;
        Fri,  3 May 2019 11:07:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1556881626;
        bh=yIKJRIZdelLZOg0RH08ruz2IDQDLuCeHtYEyJ1svdtQ=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=n/N0SB/5jCbtFRSD310ocyilBW9Jkr9L4YtNTX8hh/az3+gE+zCEncrTWrmF5v4du
         /WXTNrENwSyzEFBdCox0vgcDgjg+Tc77LVYwGCMItCnJIuKrI8K+sAAzb2iKDh36HK
         Jufds865swFEo9ltwbRFx+anhpmxfPcxo87jzi3E=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org F1143608D4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     <yhchuang@realtek.com>
Cc:     <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH 5/6] rtw88: mac: remove dangerous while (1)
References: <1556879502-16211-1-git-send-email-yhchuang@realtek.com>
        <1556879502-16211-6-git-send-email-yhchuang@realtek.com>
Date:   Fri, 03 May 2019 14:07:03 +0300
In-Reply-To: <1556879502-16211-6-git-send-email-yhchuang@realtek.com>
        (yhchuang@realtek.com's message of "Fri, 3 May 2019 18:31:41 +0800")
Message-ID: <87r29fkd9k.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

<yhchuang@realtek.com> writes:

> From: Yan-Hsuan Chuang <yhchuang@realtek.com>
>
> Not to use while (1) to parse power sequence commands in an array.
> Put the statement (when cmd is not NULL) instead to make the loop stop
> when the next fetched command is NULL.
>
> Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
> ---
>  drivers/net/wireless/realtek/rtw88/mac.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/net/wireless/realtek/rtw88/mac.c b/drivers/net/wireless/realtek/rtw88/mac.c
> index 25a923b..7487b2e 100644
> --- a/drivers/net/wireless/realtek/rtw88/mac.c
> +++ b/drivers/net/wireless/realtek/rtw88/mac.c
> @@ -203,17 +203,14 @@ static int rtw_pwr_seq_parser(struct rtw_dev *rtwdev,
>  		return -EINVAL;
>  	}
>  
> -	do {
> -		cmd = cmd_seq[idx];
> -		if (!cmd)
> -			break;
> -
> +	while ((cmd = cmd_seq[idx])) {
>  		ret = rtw_sub_pwr_seq_parser(rtwdev, intf_mask, cut_mask, cmd);
>  		if (ret)
>  			return -EBUSY;
>  
> +		/* fetch next command */
>  		idx++;
> -	} while (1);
> +	};

I dount see how this is any better, with a suitable bug you can still
have a neverending loop, right? I was thinking more something like this:

count = 100;
do {
    ....
} while (count--);

That way the won't be more than 100 loops no matter how many bugs there
are :) Of course I have no idea what would be a good value for count.

-- 
Kalle Valo
