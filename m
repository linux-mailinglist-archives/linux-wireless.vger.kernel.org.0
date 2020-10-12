Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FA1A28AC98
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Oct 2020 05:36:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726789AbgJLDf7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 11 Oct 2020 23:35:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726134AbgJLDf7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 11 Oct 2020 23:35:59 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 881F1C0613CE
        for <linux-wireless@vger.kernel.org>; Sun, 11 Oct 2020 20:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=yNJUJW5y6kE3RQZKIJlvBAwYPb5xKZVDlMJ3bAbVlyw=; b=a5I3j0I8kH5d3o9RzZFVPc4V8W
        K05HutY/BKARsiX1/idASE9nIIOy24OBx3dsTRQbrxoiDffQsio9bdzP9ltLpYM9Dia+muCSqMTRa
        vJJp0ifxYlh3gfqTE0OPtpC5uLoBp7kxxBOGLlnGaa4eSWswUngC4iuYTBQAZfZxXaWc=;
Received: from p54ae9462.dip0.t-ipconnect.de ([84.174.148.98] helo=nf.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1kRocs-0001eW-5f; Mon, 12 Oct 2020 05:35:54 +0200
Subject: Re: [PATCH v2 08/10] mt76: mt7915: implement testmode rx support
To:     Shayne Chen <shayne.chen@mediatek.com>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>
References: <20201012032538.21314-1-shayne.chen@mediatek.com>
 <20201012032538.21314-8-shayne.chen@mediatek.com>
From:   Felix Fietkau <nbd@nbd.name>
Message-ID: <4333ebf5-3d19-3165-3275-6e6fac09abfa@nbd.name>
Date:   Mon, 12 Oct 2020 05:35:53 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:78.0)
 Gecko/20100101 Thunderbird/78.3.2
MIME-Version: 1.0
In-Reply-To: <20201012032538.21314-8-shayne.chen@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


On 2020-10-12 05:25, Shayne Chen wrote:
> Support testmode rx and display rx statistic by parsing RXV packet
> type, which is currently only enabled in testmode.
> 
> Reviewed-by: Ryder Lee <ryder.lee@mediatek.com>
> Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
> ---
> v2: change last_snr to u8
> 
>  .../net/wireless/mediatek/mt76/mt7915/dma.c   |  3 +
>  .../net/wireless/mediatek/mt76/mt7915/mac.c   | 37 +++++++
>  .../net/wireless/mediatek/mt76/mt7915/mac.h   |  5 +
>  .../net/wireless/mediatek/mt76/mt7915/mcu.h   |  1 +
>  .../wireless/mediatek/mt76/mt7915/mt7915.h    |  7 ++
>  .../wireless/mediatek/mt76/mt7915/testmode.c  | 97 +++++++++++++++++++
>  .../wireless/mediatek/mt76/mt7915/testmode.h  | 30 ++++++
>  7 files changed, 180 insertions(+)
> 
> --- a/drivers/net/wireless/mediatek/mt76/mt7915/testmode.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7915/testmode.c
> @@ -169,12 +209,69 @@ mt7915_tm_set_state(struct mt76_dev *mdev, enum mt76_testmode_state state)
>  		mt7915_tm_set_tx_frames(dev, false);
>  	else if (state == MT76_TM_STATE_TX_FRAMES)
>  		mt7915_tm_set_tx_frames(dev, true);
> +	else if (prev_state == MT76_TM_STATE_RX_FRAMES)
> +		mt7915_tm_set_rx_frames(dev, false);
> +	else if (state == MT76_TM_STATE_RX_FRAMES)
> +		mt7915_tm_set_rx_frames(dev, true);
>  	else if (prev_state == MT76_TM_STATE_OFF || state == MT76_TM_STATE_OFF)
>  		mt7915_tm_init(dev);
>  
>  	return 0;
>  }
>  
> +static int
> +mt7915_tm_dump_stats(struct mt76_dev *mdev, struct sk_buff *msg)
> +{
> +	struct mt7915_dev *dev = container_of(mdev, struct mt7915_dev, mt76);
> +	void *rx, *rssi;
> +	int i;
> +
> +	rx = nla_nest_start(msg, MT76_TM_STATS_ATTR_LAST_RX);
> +	if (!rx)
> +		return -ENOMEM;
> +
> +	if (nla_put_s32(msg, MT76_TM_RX_ATTR_FREQ_OFFSET, dev->test.last_freq_offset))
> +		return -ENOMEM;
> +
> +	rssi = nla_nest_start(msg, MT76_TM_RX_ATTR_RCPI);
> +	if (!rssi)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < ARRAY_SIZE(dev->test.last_rcpi); i++)
> +		if (nla_put_u8(msg, i, dev->test.last_rcpi[i]))
> +			return -ENOMEM;
> +
> +	nla_nest_end(msg, rssi);
> +
> +	rssi = nla_nest_start(msg, MT76_TM_RX_ATTR_IB_RSSI);
> +	if (!rssi)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < ARRAY_SIZE(dev->test.last_ib_rssi); i++)
> +		if (nla_put_s8(msg, i, dev->test.last_ib_rssi[i]))
> +			return -ENOMEM;
> +
> +	nla_nest_end(msg, rssi);
> +
> +	rssi = nla_nest_start(msg, MT76_TM_RX_ATTR_WB_RSSI);
> +	if (!rssi)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < ARRAY_SIZE(dev->test.last_wb_rssi); i++)
> +		if (nla_put_s8(msg, i, dev->test.last_wb_rssi[i]))
> +			return -ENOMEM;
> +
> +	nla_nest_end(msg, rssi);
> +
> +	if (nla_put_s32(msg, MT76_TM_RX_ATTR_SNR, dev->test.last_snr))
> +		return -ENOMEM;
You updated the comment in the header file, but not this part which
actually generates the attribute.

- Felix
