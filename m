Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C86D02B17FC
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Nov 2020 10:14:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726311AbgKMJOr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 13 Nov 2020 04:14:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726181AbgKMJOq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 13 Nov 2020 04:14:46 -0500
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ABD6C0613D1
        for <linux-wireless@vger.kernel.org>; Fri, 13 Nov 2020 01:14:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=ZqXYk2ETNE7WFfoledUUVvStmR78ICCQIeEItBNL28Y=; b=i7/VX5hUFc0tJOCr8P1Xw/8hCN
        hXLf9sPgW7BpCFhKs7L8XYiQ/gD5+pgGXEAWwJ9is9BVbNRlfDtEkpa/RHFex3tK0bxvYaZN9x2Tj
        /G6pAQyPLUyCDbl7X+Ut4vsnWVs1ERhLgs7A4S4vCPRhovLbfnjV2TCzFI99TTJVgoYA=;
Received: from p5b206c33.dip0.t-ipconnect.de ([91.32.108.51] helo=nf.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1kdVAK-00017y-7Z; Fri, 13 Nov 2020 10:14:44 +0100
Subject: Re: [PATCH 3/3] mt76: mt7615: support 16 interfaces
To:     Ryder Lee <ryder.lee@mediatek.com>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Cc:     Shayne Chen <shayne.chen@mediatek.com>,
        linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org
References: <879705a8af8fa44c711feb3aa0351c1138aeef6c.1603988327.git.ryder.lee@mediatek.com>
 <a4ad2ad2b3de3ced1ca2a214da598cd0a5fea604.1603988327.git.ryder.lee@mediatek.com>
From:   Felix Fietkau <nbd@nbd.name>
Message-ID: <dc6a370b-cf82-9cbe-1bb5-7df2e4652282@nbd.name>
Date:   Fri, 13 Nov 2020 10:14:43 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:78.0)
 Gecko/20100101 Thunderbird/78.4.2
MIME-Version: 1.0
In-Reply-To: <a4ad2ad2b3de3ced1ca2a214da598cd0a5fea604.1603988327.git.ryder.lee@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


On 2020-10-29 18:11, Ryder Lee wrote:
> When looking for a MAC address slot, start by using main BSSID slots 1-3,
> afterwards use 16 repeater mode BSSID slots, then start using the slots
> usually used for AP mode.
> 
> This search order should prevent unnecessary conflicts with AP mode interfaces
> on the same PHY.
> 
> Note that two PHYs share global 32 omac slots with each other.
> 
> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
> ---
>  .../net/wireless/mediatek/mt76/mt7615/init.c  |  4 +-
>  .../net/wireless/mediatek/mt76/mt7615/main.c  | 55 +++++++++++++------
>  .../net/wireless/mediatek/mt76/mt7615/mcu.c   | 49 ++++++++++++++++-
>  .../net/wireless/mediatek/mt76/mt7615/mcu.h   |  1 +
>  .../wireless/mediatek/mt76/mt7615/mt7615.h    | 25 +++------
>  5 files changed, 94 insertions(+), 40 deletions(-)
> 
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
> index f72506d9f646..496c46f1073e 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
> +++ b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
> @@ -176,7 +176,7 @@ struct mt7615_phy {
>  	struct ieee80211_vif *monitor_vif;
>  
>  	u32 rxfilter;
> -	u32 omac_mask;
> +	u64 omac_mask;
>  
>  	u16 noise;
>  
This also needs to be done in struct mt7615_dev. I've fixed it up locally.

- Felix
