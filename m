Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D340928A9B8
	for <lists+linux-wireless@lfdr.de>; Sun, 11 Oct 2020 21:37:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726120AbgJKThc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 11 Oct 2020 15:37:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726087AbgJKThc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 11 Oct 2020 15:37:32 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28A9DC0613CE
        for <linux-wireless@vger.kernel.org>; Sun, 11 Oct 2020 12:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=t+TL1U9ATFrnvcxEvpx5NcXpCLcm2ex+63jpmjVkYVI=; b=aAwU3JaBO5NNlLIF0TEdYTcO87
        w6lsiun4yGESpIAthlkB17vf0PvNOyRT1BBNOTzXdMG3pK/Pfoa46o0weitkYaYVkq0Y7G0I/ywS4
        ERS51g0B3Ts7Nyc0hSjFTwtkV1H63uK1TGfGcExu7DWdlZUyrWfctWrnSimq4gyMPTCM=;
Received: from p54ae9462.dip0.t-ipconnect.de ([84.174.148.98] helo=nf.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1kRh9p-0006lH-HN; Sun, 11 Oct 2020 21:37:25 +0200
Subject: Re: [PATCH 02/10] mt76: testmode: add snr attribute in rx statistics
To:     Shayne Chen <shayne.chen@mediatek.com>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>
References: <20201008112904.10620-1-shayne.chen@mediatek.com>
 <20201008112904.10620-2-shayne.chen@mediatek.com>
From:   Felix Fietkau <nbd@nbd.name>
Message-ID: <e0e661ed-f351-043d-d151-bf30dd766925@nbd.name>
Date:   Sun, 11 Oct 2020 21:37:25 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:78.0)
 Gecko/20100101 Thunderbird/78.3.2
MIME-Version: 1.0
In-Reply-To: <20201008112904.10620-2-shayne.chen@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2020-10-08 13:28, Shayne Chen wrote:
> Support to display snr value when dumping rx statistics.
> 
> Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
> Reviewed-by: Ryder Lee <ryder.lee@mediatek.com>
> ---
>  drivers/net/wireless/mediatek/mt76/testmode.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/net/wireless/mediatek/mt76/testmode.h b/drivers/net/wireless/mediatek/mt76/testmode.h
> index 02c9495..4015f1d 100644
> --- a/drivers/net/wireless/mediatek/mt76/testmode.h
> +++ b/drivers/net/wireless/mediatek/mt76/testmode.h
> @@ -101,6 +101,7 @@ enum mt76_testmode_stats_attr {
>   * @MT76_TM_RX_ATTR_RCPI: received channel power indicator (array, u8)
>   * @MT76_TM_RX_ATTR_IB_RSSI: internal inband RSSI (array, s8)
>   * @MT76_TM_RX_ATTR_WB_RSSI: internal wideband RSSI (array, s8)
> + * @MT76_TM_RX_ATTR_SNR: signal-to-noise ratio (s32)
I think u8 makes more sense than s32 as a type for snr.

- Felix
