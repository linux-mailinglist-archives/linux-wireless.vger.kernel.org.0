Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A6291B96BB
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Apr 2020 07:42:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726547AbgD0Fmt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 27 Apr 2020 01:42:49 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:40452 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726349AbgD0Fmt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 27 Apr 2020 01:42:49 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1587966168; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=sEZe8pcTLss18xTyiDJfji3QWugebVZtfz1bG4lV5AQ=; b=qvFMeb3Fr0IK7nUerkxTG8wlgmtVbtAQQ6VeGDWPCD200n+oZ/P1GhgBdaeHRyEh961EoAfB
 tVRzrPkf5BDdKcYUZ4Hwx1JJjT4u+1lglXEgIdD+bzjkj2UWvSWQu4Q/vOGBIZXstwGnWkfu
 6b6XgU7yRu0DD6xc+UrtwFMwuho=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5ea670d7.7efc27ec0538-smtp-out-n04;
 Mon, 27 Apr 2020 05:42:47 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 5D722C43636; Mon, 27 Apr 2020 05:42:46 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from tynnyri.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id CA0BEC433D2;
        Mon, 27 Apr 2020 05:42:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org CA0BEC433D2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     <yhchuang@realtek.com>
Cc:     <kvalo@codeaurora.org>, <linux-wireless@vger.kernel.org>,
        <pkshih@realtek.com>
Subject: Re: [PATCH v2 3/8] rtw88: 8723d: Add set_channel
References: <20200423123022.10176-1-yhchuang@realtek.com>
        <20200423123022.10176-4-yhchuang@realtek.com>
Date:   Mon, 27 Apr 2020 08:42:41 +0300
In-Reply-To: <20200423123022.10176-4-yhchuang@realtek.com> (yhchuang's message
        of "Thu, 23 Apr 2020 20:30:17 +0800")
Message-ID: <87sggpiiwe.fsf@tynnyri.adurom.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

<yhchuang@realtek.com> writes:

> From: Ping-Ke Shih <pkshih@realtek.com>
>
> Set MAC/BB/RF register according to specified channel. The function
> rtw_set_channel_mac() is used to set MAC registers, but 8723D only need
> some of them.
>
> For channel 14, we need to set different CCK DFIR values, so restore the
> values when channel 1 to 13 is selected.
>
> Spur calibration is needed in channel 13 and 14, and we do notch if spur
> is over threshold.
>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
> Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>

[...]

> --- a/drivers/net/wireless/realtek/rtw88/rtw8723d.c
> +++ b/drivers/net/wireless/realtek/rtw88/rtw8723d.c
> @@ -287,6 +287,190 @@ static void rtw8723d_query_rx_desc(struct rtw_dev *rtwdev, u8 *rx_desc,
>  	rtw_rx_fill_rx_status(rtwdev, pkt_stat, hdr, rx_status, phy_status);
>  }
>  
> +static
> +bool rtw8723d_check_spur_ov_thres(struct rtw_dev *rtwdev, u8 channel, u32 thres)
> +{
> +#define DIS_3WIRE	0xccf000c0
> +#define EN_3WIRE	0xccc000c0
> +#define START_PSD	0x400000
> +#define FREQ_CH13	0xFCCD
> +#define FREQ_CH14	0xFF9A

Why this style of adding defines within a function? You use it in
multiple functions in this patch.

The normal upstream style is to have these kind of values defined in a
.h file somewhere.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
