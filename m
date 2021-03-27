Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCC5634B91C
	for <lists+linux-wireless@lfdr.de>; Sat, 27 Mar 2021 20:29:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230043AbhC0T2i (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 27 Mar 2021 15:28:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230002AbhC0T21 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 27 Mar 2021 15:28:27 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9106DC0613B1
        for <linux-wireless@vger.kernel.org>; Sat, 27 Mar 2021 12:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:Subject:From:References:Cc:To:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=uYnf1IKlMCYCPygSlBm3j96oJ03ojNQFUX944rUctNw=; b=IW12M+Cv33RD8bzqVwkwQIDqwz
        PvPnwJ7Si+XyPxRZs5cEZpgA2iscMX3oYHhz2Axv5wu8onXGiN+KiXIfhzlWeQVGBvJnJTCOdILzV
        LOCpKHal6HGiPjq+uZNIK4DqJIFoMJvy2FdZjNtfIOBa1zZyxNRYWOk3GroNY0+QdIUE=;
Received: from p4ff13c8d.dip0.t-ipconnect.de ([79.241.60.141] helo=nf.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1lQEbd-0003V0-7C; Sat, 27 Mar 2021 20:28:21 +0100
To:     Ryder Lee <ryder.lee@mediatek.com>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Cc:     Shayne Chen <shayne.chen@mediatek.com>,
        linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org
References: <ae8caa3a01d527e464b09b4932d6cca14b1d49a2.1616831454.git.ryder.lee@mediatek.com>
From:   Felix Fietkau <nbd@nbd.name>
Subject: Re: [PATCH] mt76: report Rx timestamp
Message-ID: <41727e36-e165-5b8e-4d76-be96f61bc83e@nbd.name>
Date:   Sat, 27 Mar 2021 20:28:20 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <ae8caa3a01d527e464b09b4932d6cca14b1d49a2.1616831454.git.ryder.lee@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


On 2021-03-27 08:55, Ryder Lee wrote:
> Frame reception timestamp (low 32-bits) that indicates the value of the
> local TSF timer value at the time the first bit of the MAC header in the
> received frame (PPDU unit) arriving at the MAC.
> 
> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
> ---
>  drivers/net/wireless/mediatek/mt76/agg-rx.c   |  2 +-
>  drivers/net/wireless/mediatek/mt76/mac80211.c |  1 +
>  drivers/net/wireless/mediatek/mt76/mt76.h     |  3 +-
>  .../net/wireless/mediatek/mt76/mt7603/mac.c   | 31 ++++++++++--------
>  .../wireless/mediatek/mt76/mt7603/mt7603.h    |  2 +-
>  .../net/wireless/mediatek/mt76/mt7615/mac.c   | 32 ++++++++++---------
>  .../wireless/mediatek/mt76/mt7615/mt7615.h    |  2 +-
>  .../net/wireless/mediatek/mt76/mt7915/mac.c   | 29 +++++++++--------
>  .../wireless/mediatek/mt76/mt7915/mt7915.h    |  2 +-
>  .../net/wireless/mediatek/mt76/mt7921/mac.c   | 29 +++++++++--------
>  .../wireless/mediatek/mt76/mt7921/mt7921.h    |  2 +-
>  11 files changed, 74 insertions(+), 61 deletions(-)
> 
> diff --git a/drivers/net/wireless/mediatek/mt76/agg-rx.c b/drivers/net/wireless/mediatek/mt76/agg-rx.c
> index 144e8a8910ba..a37b8db979c6 100644
> --- a/drivers/net/wireless/mediatek/mt76/agg-rx.c
> +++ b/drivers/net/wireless/mediatek/mt76/agg-rx.c
> @@ -77,7 +77,7 @@ mt76_rx_aggr_check_release(struct mt76_rx_tid *tid, struct sk_buff_head *frames)
>  		nframes--;
>  		status = (struct mt76_rx_status *)skb->cb;
>  		if (!time_after(jiffies,
> -				status->reorder_time +
> +				(unsigned long)status->reorder_time +
>  				mt76_aggr_tid_to_timeo(tid->num)))
>  			continue;
This doesn't work, you need to replace the time_after with a function
that takes u32 wraparound into account.

- Felix
