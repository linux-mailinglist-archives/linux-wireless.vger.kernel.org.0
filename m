Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F37F28DED5
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Oct 2020 12:23:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727445AbgJNKXJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 14 Oct 2020 06:23:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726493AbgJNKXJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 14 Oct 2020 06:23:09 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37B09C061755
        for <linux-wireless@vger.kernel.org>; Wed, 14 Oct 2020 03:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:Subject:From:References:Cc:To:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=opmjH3ZyRO0Bff677ZBbUzYgvMkp277MTfGEMgeatCU=; b=dOhmbIhMtzC/KSlYzY59O9AsWA
        ligtv8fOtHVF8xYckjShbCe4xOMbHtDT7PJ3PX89GRAFa7kfLY2Ntuz0tty/hwvhx4FAg2eaHasi1
        lAxLgFOwVbkRSqsEHQqV/hXD8eAymrw1gwW4q3/KCAFKNzzqDNh91AezOfd8M0/+glmI=;
Received: from p54ae9462.dip0.t-ipconnect.de ([84.174.148.98] helo=nf.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1kSdvx-0003kZ-J4; Wed, 14 Oct 2020 12:23:01 +0200
To:     Shayne Chen <shayne.chen@mediatek.com>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>
References: <20201012125403.8608-1-shayne.chen@mediatek.com>
 <20201012125403.8608-8-shayne.chen@mediatek.com>
From:   Felix Fietkau <nbd@nbd.name>
Subject: Re: [PATCH v3 08/10] mt76: mt7915: implement testmode rx support
Message-ID: <ed34a4ab-91e5-5cb7-1ffa-595d6ac2ef03@nbd.name>
Date:   Wed, 14 Oct 2020 12:23:00 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:78.0)
 Gecko/20100101 Thunderbird/78.3.2
MIME-Version: 1.0
In-Reply-To: <20201012125403.8608-8-shayne.chen@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


On 2020-10-12 14:54, Shayne Chen wrote:
> Support testmode rx and display rx statistic by parsing RXV packet
> type, which is currently only enabled in testmode.
> 
> Reviewed-by: Ryder Lee <ryder.lee@mediatek.com>
> Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
> ---
> v2: change last_snr to u8
> v3: use nla_put_u8 for MT76_TM_RX_ATTR_SNR
>     change snr variable type to u8 in mt7915_mac_fill_rx_vector
> 
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/testmode.c b/drivers/net/wireless/mediatek/mt76/mt7915/testmode.c
> index 5d95766..acab268 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7915/testmode.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7915/testmode.c
> @@ -113,6 +113,31 @@ mt7915_tm_reg_backup_restore(struct mt7915_dev *dev, struct mt7915_phy *phy)
>  	mt76_clear(dev, MT_TMAC_TCR0(0), MT_TMAC_TCR0_TBTT_STOP_CTRL);
>  }
>  
> +static int
> +mt7915_tm_config_rx_filter(struct mt7915_dev *dev, bool en)
> +{
> +	struct mt7915_tm_cmd req = {
> +		.testmode_en = 1,
> +		.param_idx = MCU_ATE_SET_RX_FILTER,
> +		.param.filter.report_en = en,
> +		.param.filter.band = 0,	/* TODO: support dbdc */
> +	};
> +	__le32 mask = RX_FILTER_NOT_OWN_BTIM |
> +		      RX_FILTER_NOT_OWN_UCAST |
> +		      RX_FILTER_RTS | RX_FILTER_CTS |
> +		      RX_FILTER_CTRL_RSV |
> +		      RX_FILTER_BC_MC_BSSID_A2 |
> +		      RX_FILTER_BC_MC_BSSID_A3 |
> +		      RX_FILTER_BC_MC_OMAC_A3 |
> +		      RX_FILTER_PROTOCOL_VERSION |
> +		      RX_FILTER_FCS_ERR;
> +
> +	req.param.filter.mask = cpu_to_le32(mask);
> +
> +	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_ATE_CTRL, &req,
> +				 sizeof(req), false);
Why do we need this?
In order to use testmode you have to set up a monitor mode interface,
which should configure the rx filter settings properly already.

- Felix
