Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A270836E7C1
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Apr 2021 11:15:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232734AbhD2JP3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 29 Apr 2021 05:15:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232775AbhD2JP3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 29 Apr 2021 05:15:29 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9933C06138C
        for <linux-wireless@vger.kernel.org>; Thu, 29 Apr 2021 02:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=VGDlYRlwVHim7LKwCC6m3qNRU+CLFW9Mai1RkAipq8g=; b=CGhKQ1V3+x2GrNiK4+9fgkRAec
        jrpAfSN45EAOwKi7re3eLlRl3GCByuWGH3+CQCanMYrPRDKg2N/CyNlmULHAI7LFg6fyX2yQT15VC
        dO1exagpffw3z/hCGmsqhDtseU+xEyhfiJw38swzXrxGqgD81zWfVLkMbcRhcVB1OJkU=;
Received: from p4ff13bc6.dip0.t-ipconnect.de ([79.241.59.198] helo=nf.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1lc2kr-00011y-9p; Thu, 29 Apr 2021 11:14:41 +0200
Subject: Re: [PATCH] mt76: move mt76_rates in mt76 module
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com
References: <a8da66822d9dbfd7afbebcd915f1c4e1bb59d41f.1619685085.git.lorenzo@kernel.org>
From:   Felix Fietkau <nbd@nbd.name>
Message-ID: <3d5251c8-dfad-7b46-4603-3df3f50c5770@nbd.name>
Date:   Thu, 29 Apr 2021 11:14:40 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <a8da66822d9dbfd7afbebcd915f1c4e1bb59d41f.1619685085.git.lorenzo@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


On 2021-04-29 10:32, Lorenzo Bianconi wrote:
> Move mt76_rates array in mt76 module and remove duplicated code since it
> is shared by all drivers
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  drivers/net/wireless/mediatek/mt76/mac80211.c | 16 +++++++++
>  drivers/net/wireless/mediatek/mt76/mt76.h     | 15 ++++++++
>  .../net/wireless/mediatek/mt76/mt7603/init.c  | 13 -------
>  .../net/wireless/mediatek/mt76/mt7615/init.c  | 33 ++---------------
>  .../wireless/mediatek/mt76/mt7615/pci_init.c  |  4 +--
>  .../wireless/mediatek/mt76/mt7615/usb_sdio.c  |  4 +--
>  .../net/wireless/mediatek/mt76/mt76x02_util.c | 16 +++------
>  .../net/wireless/mediatek/mt76/mt7915/init.c  | 36 +++----------------
>  .../net/wireless/mediatek/mt76/mt7921/init.c  | 32 ++---------------
>  9 files changed, 48 insertions(+), 121 deletions(-)
> 
> index e1b2cfa56074..b46097ea334a 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7603/init.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7603/init.c
> @@ -304,19 +304,6 @@ mt7603_init_hardware(struct mt7603_dev *dev)
>  	return 0;
>  }
>  
> -#define CCK_RATE(_idx, _rate) {					\
> -	.bitrate = _rate,					\
> -	.flags = IEEE80211_RATE_SHORT_PREAMBLE,			\
> -	.hw_value = (MT_PHY_TYPE_CCK << 8) | (_idx),		\
> -	.hw_value_short = (MT_PHY_TYPE_CCK << 8) | (4 + _idx),	\
> -}
> -
> -#define OFDM_RATE(_idx, _rate) {				\
> -	.bitrate = _rate,					\
> -	.hw_value = (MT_PHY_TYPE_OFDM << 8) | (_idx),		\
> -	.hw_value_short = (MT_PHY_TYPE_OFDM << 8) | (_idx),	\
> -}
> -
>  static struct ieee80211_rate mt7603_rates[] = {
>  	CCK_RATE(0, 10),
>  	CCK_RATE(1, 20),
I think you can drop mt7603_rates as well and replace it with
mt76_rates. The rest looks good to me.

- Felix
