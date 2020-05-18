Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D5951D7856
	for <lists+linux-wireless@lfdr.de>; Mon, 18 May 2020 14:18:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726758AbgERMSW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 18 May 2020 08:18:22 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:34201 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726526AbgERMSV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 18 May 2020 08:18:21 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1589804301; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=hjEoOt20HpxwFiXgkOsa8Ime3TlEucpSSWKUPk+u2bw=;
 b=lxEMAuDOczuAbK8CnzEGYiOxbDDbwMk/AmhcUZbIv+FGhoJvlcX0kE5SG52vL7Vh8MM3VQLS
 gQtFzHr8RsnXOxpnp5kHGCe8K36+1ZYSI7hsk0QntflpUpgTROg1GVg0e6DBQdlTbyW27rrr
 2EGpF6ToELSXh3g5VozpPVBAkI8=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5ec27d08.7f7331af66c0-smtp-out-n04;
 Mon, 18 May 2020 12:18:16 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 92705C432C2; Mon, 18 May 2020 12:18:15 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.3 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE,UPPERCASE_50_75 autolearn=no autolearn_force=no
        version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 223D4C433F2;
        Mon, 18 May 2020 12:18:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 223D4C433F2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] rtw88: no need to set registers for SDIO
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20200515061153.GA15714@ns.kevlo.org>
References: <20200515061153.GA15714@ns.kevlo.org>
To:     Kevin Lo <kevlo@kevlo.org>
Cc:     linux-wireless@vger.kernel.org,
        Yan-Hsuan Chuang <yhchuang@realtek.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20200518121815.92705C432C2@smtp.codeaurora.org>
Date:   Mon, 18 May 2020 12:18:15 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Kevin Lo <kevlo@kevlo.org> wrote:

> There's no need to set SDIO related registers when powering up/down the chip.
> 
> Signed-off-by: Kevin Lo <kevlo@kevlo.org>
> 
> diff --git a/drivers/net/wireless/realtek/rtw88/rtw8723d.c b/drivers/net/wireless/realtek/rtw88/rtw8723d.c
> index b517af417e0e..5e0b7999bc8a 100644
> --- a/drivers/net/wireless/realtek/rtw88/rtw8723d.c
> +++ b/drivers/net/wireless/realtek/rtw88/rtw8723d.c
> @@ -2092,16 +2092,6 @@ static const struct rtw_pwr_seq_cmd trans_carddis_to_cardemu_8723d[] = {
>  	 RTW_PWR_INTF_ALL_MSK,
>  	 RTW_PWR_ADDR_MAC,
>  	 RTW_PWR_CMD_WRITE, BIT(3) | BIT(7), 0},
> -	{0x0086,
> -	 RTW_PWR_CUT_ALL_MSK,
> -	 RTW_PWR_INTF_SDIO_MSK,
> -	 RTW_PWR_ADDR_SDIO,
> -	 RTW_PWR_CMD_WRITE, BIT(0), 0},
> -	{0x0086,
> -	 RTW_PWR_CUT_ALL_MSK,
> -	 RTW_PWR_INTF_SDIO_MSK,
> -	 RTW_PWR_ADDR_SDIO,
> -	 RTW_PWR_CMD_POLLING, BIT(1), BIT(1)},
>  	{0x004A,
>  	 RTW_PWR_CUT_ALL_MSK,
>  	 RTW_PWR_INTF_USB_MSK,
> @@ -2112,11 +2102,6 @@ static const struct rtw_pwr_seq_cmd trans_carddis_to_cardemu_8723d[] = {
>  	 RTW_PWR_INTF_ALL_MSK,
>  	 RTW_PWR_ADDR_MAC,
>  	 RTW_PWR_CMD_WRITE, BIT(3) | BIT(4), 0},
> -	{0x0023,
> -	 RTW_PWR_CUT_ALL_MSK,
> -	 RTW_PWR_INTF_SDIO_MSK,
> -	 RTW_PWR_ADDR_MAC,
> -	 RTW_PWR_CMD_WRITE, BIT(4), 0},
>  	{0x0301,
>  	 RTW_PWR_CUT_ALL_MSK,
>  	 RTW_PWR_INTF_PCI_MSK,
> @@ -2324,11 +2309,6 @@ static const struct rtw_pwr_seq_cmd trans_act_to_lps_8723d[] = {
>  	 RTW_PWR_INTF_ALL_MSK,
>  	 RTW_PWR_ADDR_MAC,
>  	 RTW_PWR_CMD_WRITE, BIT(1), 0},
> -	{0x0093,
> -	 RTW_PWR_CUT_ALL_MSK,
> -	 RTW_PWR_INTF_SDIO_MSK,
> -	 RTW_PWR_ADDR_MAC,
> -	 RTW_PWR_CMD_WRITE, 0xFF, 0x00},
>  	{0x0553,
>  	 RTW_PWR_CUT_ALL_MSK,
>  	 RTW_PWR_INTF_ALL_MSK,
> @@ -2408,11 +2388,6 @@ static const struct rtw_pwr_seq_cmd trans_act_to_cardemu_8723d[] = {
>  };
>  
>  static const struct rtw_pwr_seq_cmd trans_cardemu_to_carddis_8723d[] = {
> -	{0x0007,
> -	 RTW_PWR_CUT_ALL_MSK,
> -	 RTW_PWR_INTF_SDIO_MSK,
> -	 RTW_PWR_ADDR_MAC,
> -	 RTW_PWR_CMD_WRITE, 0xFF, 0x20},
>  	{0x0005,
>  	 RTW_PWR_CUT_ALL_MSK,
>  	 RTW_PWR_INTF_USB_MSK | RTW_PWR_INTF_SDIO_MSK,
> @@ -2433,21 +2408,6 @@ static const struct rtw_pwr_seq_cmd trans_cardemu_to_carddis_8723d[] = {
>  	 RTW_PWR_INTF_USB_MSK,
>  	 RTW_PWR_ADDR_MAC,
>  	 RTW_PWR_CMD_WRITE, BIT(0), 1},
> -	{0x0023,
> -	 RTW_PWR_CUT_ALL_MSK,
> -	 RTW_PWR_INTF_SDIO_MSK,
> -	 RTW_PWR_ADDR_MAC,
> -	 RTW_PWR_CMD_WRITE, BIT(4), BIT(4)},
> -	{0x0086,
> -	 RTW_PWR_CUT_ALL_MSK,
> -	 RTW_PWR_INTF_SDIO_MSK,
> -	 RTW_PWR_ADDR_SDIO,
> -	 RTW_PWR_CMD_WRITE, BIT(0), BIT(0)},
> -	{0x0086,
> -	 RTW_PWR_CUT_ALL_MSK,
> -	 RTW_PWR_INTF_SDIO_MSK,
> -	 RTW_PWR_ADDR_SDIO,
> -	 RTW_PWR_CMD_POLLING, BIT(1), 0},
>  	{0xFFFF,
>  	 RTW_PWR_CUT_ALL_MSK,
>  	 RTW_PWR_INTF_ALL_MSK,
> diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822b.c b/drivers/net/wireless/realtek/rtw88/rtw8822b.c
> index 18c5a5a96d90..e0d911bbe534 100644
> --- a/drivers/net/wireless/realtek/rtw88/rtw8822b.c
> +++ b/drivers/net/wireless/realtek/rtw88/rtw8822b.c
> @@ -1550,16 +1550,6 @@ static void rtw8822b_bf_config_bfee(struct rtw_dev *rtwdev, struct rtw_vif *vif,
>  }
>  
>  static const struct rtw_pwr_seq_cmd trans_carddis_to_cardemu_8822b[] = {
> -	{0x0086,
> -	 RTW_PWR_CUT_ALL_MSK,
> -	 RTW_PWR_INTF_SDIO_MSK,
> -	 RTW_PWR_ADDR_SDIO,
> -	 RTW_PWR_CMD_WRITE, BIT(0), 0},
> -	{0x0086,
> -	 RTW_PWR_CUT_ALL_MSK,
> -	 RTW_PWR_INTF_SDIO_MSK,
> -	 RTW_PWR_ADDR_SDIO,
> -	 RTW_PWR_CMD_POLLING, BIT(1), BIT(1)},
>  	{0x004A,
>  	 RTW_PWR_CUT_ALL_MSK,
>  	 RTW_PWR_INTF_USB_MSK,
> @@ -1688,11 +1678,6 @@ static const struct rtw_pwr_seq_cmd trans_cardemu_to_act_8822b[] = {
>  	 RTW_PWR_INTF_ALL_MSK,
>  	 RTW_PWR_ADDR_MAC,
>  	 RTW_PWR_CMD_WRITE, 0xFF, 0x0c},
> -	{0x0068,
> -	 RTW_PWR_CUT_C_MSK,
> -	 RTW_PWR_INTF_SDIO_MSK,
> -	 RTW_PWR_ADDR_MAC,
> -	 RTW_PWR_CMD_WRITE, BIT(4), BIT(4)},
>  	{0x0029,
>  	 RTW_PWR_CUT_ALL_MSK,
>  	 RTW_PWR_INTF_ALL_MSK,
> @@ -1721,11 +1706,6 @@ static const struct rtw_pwr_seq_cmd trans_cardemu_to_act_8822b[] = {
>  };
>  
>  static const struct rtw_pwr_seq_cmd trans_act_to_cardemu_8822b[] = {
> -	{0x0003,
> -	 RTW_PWR_CUT_ALL_MSK,
> -	 RTW_PWR_INTF_SDIO_MSK,
> -	 RTW_PWR_ADDR_MAC,
> -	 RTW_PWR_CMD_WRITE, BIT(2), 0},
>  	{0x0093,
>  	 RTW_PWR_CUT_ALL_MSK,
>  	 RTW_PWR_INTF_ALL_MSK,
> @@ -1794,11 +1774,6 @@ static const struct rtw_pwr_seq_cmd trans_act_to_cardemu_8822b[] = {
>  };
>  
>  static const struct rtw_pwr_seq_cmd trans_cardemu_to_carddis_8822b[] = {
> -	{0x0005,
> -	 RTW_PWR_CUT_ALL_MSK,
> -	 RTW_PWR_INTF_SDIO_MSK,
> -	 RTW_PWR_ADDR_MAC,
> -	 RTW_PWR_CMD_WRITE, BIT(7), BIT(7)},
>  	{0x0007,
>  	 RTW_PWR_CUT_ALL_MSK,
>  	 RTW_PWR_INTF_USB_MSK | RTW_PWR_INTF_SDIO_MSK,
> @@ -1819,46 +1794,6 @@ static const struct rtw_pwr_seq_cmd trans_cardemu_to_carddis_8822b[] = {
>  	 RTW_PWR_INTF_USB_MSK,
>  	 RTW_PWR_ADDR_MAC,
>  	 RTW_PWR_CMD_WRITE, BIT(0), 0},
> -	{0x0067,
> -	 RTW_PWR_CUT_ALL_MSK,
> -	 RTW_PWR_INTF_SDIO_MSK,
> -	 RTW_PWR_ADDR_MAC,
> -	 RTW_PWR_CMD_WRITE, BIT(5), 0},
> -	{0x0067,
> -	 RTW_PWR_CUT_ALL_MSK,
> -	 RTW_PWR_INTF_SDIO_MSK,
> -	 RTW_PWR_ADDR_MAC,
> -	 RTW_PWR_CMD_WRITE, BIT(4), 0},
> -	{0x004F,
> -	 RTW_PWR_CUT_ALL_MSK,
> -	 RTW_PWR_INTF_SDIO_MSK,
> -	 RTW_PWR_ADDR_MAC,
> -	 RTW_PWR_CMD_WRITE, BIT(0), 0},
> -	{0x0067,
> -	 RTW_PWR_CUT_ALL_MSK,
> -	 RTW_PWR_INTF_SDIO_MSK,
> -	 RTW_PWR_ADDR_MAC,
> -	 RTW_PWR_CMD_WRITE, BIT(1), 0},
> -	{0x0046,
> -	 RTW_PWR_CUT_ALL_MSK,
> -	 RTW_PWR_INTF_SDIO_MSK,
> -	 RTW_PWR_ADDR_MAC,
> -	 RTW_PWR_CMD_WRITE, BIT(6), BIT(6)},
> -	{0x0067,
> -	 RTW_PWR_CUT_ALL_MSK,
> -	 RTW_PWR_INTF_SDIO_MSK,
> -	 RTW_PWR_ADDR_MAC,
> -	 RTW_PWR_CMD_WRITE, BIT(2), 0},
> -	{0x0046,
> -	 RTW_PWR_CUT_ALL_MSK,
> -	 RTW_PWR_INTF_SDIO_MSK,
> -	 RTW_PWR_ADDR_MAC,
> -	 RTW_PWR_CMD_WRITE, BIT(7), BIT(7)},
> -	{0x0062,
> -	 RTW_PWR_CUT_ALL_MSK,
> -	 RTW_PWR_INTF_SDIO_MSK,
> -	 RTW_PWR_ADDR_MAC,
> -	 RTW_PWR_CMD_WRITE, BIT(4), BIT(4)},
>  	{0x0081,
>  	 RTW_PWR_CUT_ALL_MSK,
>  	 RTW_PWR_INTF_ALL_MSK,
> @@ -1869,41 +1804,11 @@ static const struct rtw_pwr_seq_cmd trans_cardemu_to_carddis_8822b[] = {
>  	 RTW_PWR_INTF_USB_MSK | RTW_PWR_INTF_SDIO_MSK,
>  	 RTW_PWR_ADDR_MAC,
>  	 RTW_PWR_CMD_WRITE, BIT(3) | BIT(4), BIT(3)},
> -	{0x0086,
> -	 RTW_PWR_CUT_ALL_MSK,
> -	 RTW_PWR_INTF_SDIO_MSK,
> -	 RTW_PWR_ADDR_SDIO,
> -	 RTW_PWR_CMD_WRITE, BIT(0), BIT(0)},
> -	{0x0086,
> -	 RTW_PWR_CUT_ALL_MSK,
> -	 RTW_PWR_INTF_SDIO_MSK,
> -	 RTW_PWR_ADDR_SDIO,
> -	 RTW_PWR_CMD_POLLING, BIT(1), 0},
>  	{0x0090,
>  	 RTW_PWR_CUT_ALL_MSK,
>  	 RTW_PWR_INTF_USB_MSK | RTW_PWR_INTF_PCI_MSK,
>  	 RTW_PWR_ADDR_MAC,
>  	 RTW_PWR_CMD_WRITE, BIT(1), 0},
> -	{0x0044,
> -	 RTW_PWR_CUT_ALL_MSK,
> -	 RTW_PWR_INTF_SDIO_MSK,
> -	 RTW_PWR_ADDR_SDIO,
> -	 RTW_PWR_CMD_WRITE, 0xFF, 0},
> -	{0x0040,
> -	 RTW_PWR_CUT_ALL_MSK,
> -	 RTW_PWR_INTF_SDIO_MSK,
> -	 RTW_PWR_ADDR_SDIO,
> -	 RTW_PWR_CMD_WRITE, 0xFF, 0x90},
> -	{0x0041,
> -	 RTW_PWR_CUT_ALL_MSK,
> -	 RTW_PWR_INTF_SDIO_MSK,
> -	 RTW_PWR_ADDR_SDIO,
> -	 RTW_PWR_CMD_WRITE, 0xFF, 0x00},
> -	{0x0042,
> -	 RTW_PWR_CUT_ALL_MSK,
> -	 RTW_PWR_INTF_SDIO_MSK,
> -	 RTW_PWR_ADDR_SDIO,
> -	 RTW_PWR_CMD_WRITE, 0xFF, 0x04},
>  	{0xFFFF,
>  	 RTW_PWR_CUT_ALL_MSK,
>  	 RTW_PWR_INTF_ALL_MSK,
> diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822c.c b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
> index d697d70170af..4cb85502d8ad 100644
> --- a/drivers/net/wireless/realtek/rtw88/rtw8822c.c
> +++ b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
> @@ -3562,16 +3562,6 @@ static void rtw8822c_pwr_track(struct rtw_dev *rtwdev)
>  }
>  
>  static const struct rtw_pwr_seq_cmd trans_carddis_to_cardemu_8822c[] = {
> -	{0x0086,
> -	 RTW_PWR_CUT_ALL_MSK,
> -	 RTW_PWR_INTF_SDIO_MSK,
> -	 RTW_PWR_ADDR_SDIO,
> -	 RTW_PWR_CMD_WRITE, BIT(0), 0},
> -	{0x0086,
> -	 RTW_PWR_CUT_ALL_MSK,
> -	 RTW_PWR_INTF_SDIO_MSK,
> -	 RTW_PWR_ADDR_SDIO,
> -	 RTW_PWR_CMD_POLLING, BIT(1), BIT(1)},
>  	{0x002E,
>  	 RTW_PWR_CUT_ALL_MSK,
>  	 RTW_PWR_INTF_ALL_MSK,
> @@ -3782,11 +3772,6 @@ static const struct rtw_pwr_seq_cmd trans_act_to_cardemu_8822c[] = {
>  };
>  
>  static const struct rtw_pwr_seq_cmd trans_cardemu_to_carddis_8822c[] = {
> -	{0x0005,
> -	 RTW_PWR_CUT_ALL_MSK,
> -	 RTW_PWR_INTF_SDIO_MSK,
> -	 RTW_PWR_ADDR_MAC,
> -	 RTW_PWR_CMD_WRITE, BIT(7), BIT(7)},
>  	{0x0007,
>  	 RTW_PWR_CUT_ALL_MSK,
>  	 RTW_PWR_INTF_USB_MSK | RTW_PWR_INTF_SDIO_MSK,
> @@ -3832,11 +3817,6 @@ static const struct rtw_pwr_seq_cmd trans_cardemu_to_carddis_8822c[] = {
>  	 RTW_PWR_INTF_PCI_MSK,
>  	 RTW_PWR_ADDR_MAC,
>  	 RTW_PWR_CMD_WRITE, BIT(2), BIT(2)},
> -	{0x0086,
> -	 RTW_PWR_CUT_ALL_MSK,
> -	 RTW_PWR_INTF_SDIO_MSK,
> -	 RTW_PWR_ADDR_SDIO,
> -	 RTW_PWR_CMD_WRITE, BIT(0), BIT(0)},
>  	{0xFFFF,
>  	 RTW_PWR_CUT_ALL_MSK,
>  	 RTW_PWR_INTF_ALL_MSK,

Patch applied to wireless-drivers-next.git, thanks.

07d0f5534935 rtw88: no need to set registers for SDIO

-- 
https://patchwork.kernel.org/patch/11552623/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
