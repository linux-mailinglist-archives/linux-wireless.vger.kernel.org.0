Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48A142F5DBA
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Jan 2021 10:35:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728475AbhANJet (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 14 Jan 2021 04:34:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727778AbhANJer (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 14 Jan 2021 04:34:47 -0500
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6FD2C061575
        for <linux-wireless@vger.kernel.org>; Thu, 14 Jan 2021 01:33:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=NoyuDLH/uTNtcownHjy45bgi6oB6avEVSl4tL4ZrXdE=; b=Gk2pDQd6svRbj9hZ6kLeg+aUCQ
        MC0ESatxg/M81/0SGc3OzpqT4Mi4aG4UM07iuVcXjTC7Ay8z9NYM+HaxzJL1I9/xTiXbkeR3S7TqU
        GgXIKZcqUP5dRR0OT5xQ0Do6U6SSTm5E/l2mF98yz9VdvoefqscDRzJmgPQc7hRDouLw=;
Received: from p54ae91f2.dip0.t-ipconnect.de ([84.174.145.242] helo=nf.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1kzz0k-0004yu-C7; Thu, 14 Jan 2021 10:33:46 +0100
Subject: Re: [PATCH] mt76: testmode: add support to set user-defined spe index
To:     Shayne Chen <shayne.chen@mediatek.com>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>
References: <20210105054124.5946-1-shayne.chen@mediatek.com>
From:   Felix Fietkau <nbd@nbd.name>
Message-ID: <a2d8b06c-f4d7-b460-f988-8fe7b9b50540@nbd.name>
Date:   Thu, 14 Jan 2021 10:33:45 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:78.0)
 Gecko/20100101 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210105054124.5946-1-shayne.chen@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


On 2021-01-05 06:41, Shayne Chen wrote:
> Add spatial extension (spe) index as a configurable parameter in testmode.
> This is used for specifically configuring TX path, such as different
> WF TX priority, number of antennas and spatial streams.
> 
> If spe_idx is not set, TX path depends on tx_antenna_mask; otherwise,
> both spe_idx and tx_antenna_mask are referenced to decide TX path.
> 
> Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
> ---
>  drivers/net/wireless/mediatek/mt76/mt76.h         |  1 +
>  .../net/wireless/mediatek/mt76/mt7915/testmode.c  | 15 ++++++++++-----
>  drivers/net/wireless/mediatek/mt76/testmode.c     |  4 ++++
>  drivers/net/wireless/mediatek/mt76/testmode.h     |  2 ++
>  4 files changed, 17 insertions(+), 5 deletions(-)
> 
> index 7efad685a17c..f215b377d7fb 100644
> --- a/drivers/net/wireless/mediatek/mt76/testmode.h
> +++ b/drivers/net/wireless/mediatek/mt76/testmode.h
> @@ -29,6 +29,7 @@
>   * @MT76_TM_ATTR_TX_LTF: packet tx LTF, set 0 to 2 for 1x, 2x, and 4x LTF (u8)
>   *
>   * @MT76_TM_ATTR_TX_ANTENNA: tx antenna mask (u8)
> + * @MT76_TM_ATTR_TX_SPE_IDX: tx spatial extension index (u8)
>   * @MT76_TM_ATTR_TX_POWER_CONTROL: enable tx power control (u8)
>   * @MT76_TM_ATTR_TX_POWER: per-antenna tx power array (nested, u8 attrs)
>   *
> @@ -56,6 +57,7 @@ enum mt76_testmode_attr {
>  	MT76_TM_ATTR_TX_LTF,
>  
>  	MT76_TM_ATTR_TX_ANTENNA,
> +	MT76_TM_ATTR_TX_SPE_IDX,In order to avoid breaking the ABI, please only add new entries at the
end of the enum, above the "keep last" line.
I'll fix it up locally this time.

- Felix
