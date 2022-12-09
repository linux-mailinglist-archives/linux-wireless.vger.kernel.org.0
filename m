Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7367648264
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Dec 2022 13:32:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbiLIMce (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 9 Dec 2022 07:32:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbiLIMc3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 9 Dec 2022 07:32:29 -0500
Received: from nbd.name (nbd.name [46.4.11.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECFDC6B98A
        for <linux-wireless@vger.kernel.org>; Fri,  9 Dec 2022 04:32:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
        s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=zLAYh7J7MCcQ9Zr2D9WTagKED7WM0Gt1qiQUujmF1YA=; b=TwWqTrXdFcacPSiy24umCeOiF6
        esL/SyPs6YIdxKb7yFzj91N0p7c60NdAD3U6YwRdBl7pHh5ndUkZN2EtE2ohaQKnyPFHe1vr+ooxi
        zYvtJylNmnNMMi56AtlcqIfo4BbwJ+cjY2P55ej1d14azZNoNgGNHpok7xMWxbPomnFg=;
Received: from p200300daa7161301844ecc957173cc8d.dip0.t-ipconnect.de ([2003:da:a716:1301:844e:cc95:7173:cc8d] helo=nf.local)
        by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <nbd@nbd.name>)
        id 1p3cYC-007P8o-OS; Fri, 09 Dec 2022 13:32:24 +0100
Message-ID: <c4f01e3e-4ae6-3d60-4fd0-b8d8bc5f4573@nbd.name>
Date:   Fri, 9 Dec 2022 13:32:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.1
Subject: Re: [PATCH,v2] wifi: mt76: mt7915: add wds support when wed is
 enabled
Content-Language: en-US
To:     Sujuan Chen <sujuan.chen@mediatek.com>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        Bo Jiao <bo.jiao@mediatek.com>,
        Haitao Shang <haitao.shang@mediatek.com>,
        linux-mediatek@lists.infradead.org
References: <e603722d58079af98c57a3dc117274d824d1d832.1669798063.git.sujuan.chen@mediatek.com>
From:   Felix Fietkau <nbd@nbd.name>
In-Reply-To: <e603722d58079af98c57a3dc117274d824d1d832.1669798063.git.sujuan.chen@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 30.11.22 10:18, Sujuan Chen wrote:
> The current WED only supports 256 wcid, whereas mt7986 can support up to 512 entries,
> so firmware provides a rule to get sta_info by DA when wcid is set to 0x3ff by txd.
> Also, WED provides a register to overwrite txd wcid, that is, wcid[9:8] can
> be overwritten by 0x3 and wcid[7:0] is set to 0xff by host driver.
> 
> However, firmware is unable to get sta_info from DA as DA != RA for 4addr cases,
> so firmware and wifi host driver both use wcid (256 - 271) and (768 ~ 783)
> for sync up to get correct sta_info
> 
> Tested-by: Sujuan Chen <sujuan.chen@mediatek.com>
> Co-developed-by: Bo Jiao <bo.jiao@mediatek.com>
> Signed-off-by: Bo Jiao <bo.jiao@mediatek.com>
> Signed-off-by: Sujuan Chen <sujuan.chen@mediatek.com>
> ---
> v2:
>   - drop duplicate settings
>   - reduce the patch size by redefining mt76_wcid_alloc
> ---
>   drivers/net/wireless/mediatek/mt76/mt76.h     |  6 +++
>   .../net/wireless/mediatek/mt76/mt7915/main.c  | 24 +++++++++--
>   .../net/wireless/mediatek/mt76/mt7915/mcu.c   | 13 +++++-
>   .../net/wireless/mediatek/mt76/mt7915/mcu.h   |  1 +
>   drivers/net/wireless/mediatek/mt76/util.c     | 40 +++++++++++++++++--
>   drivers/net/wireless/mediatek/mt76/util.h     |  7 +++-
>   6 files changed, 82 insertions(+), 9 deletions(-)
> 

> diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/main.c b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
> index c40b6098f19a..46a9e4f0396e 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7915/main.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
> @@ -1115,6 +1122,13 @@ static void mt7915_sta_set_4addr(struct ieee80211_hw *hw,
>   	else
>   		clear_bit(MT_WCID_FLAG_4ADDR, &msta->wcid.flags);
>   
> +	if (mtk_wed_device_active(&dev->mt76.mmio.wed) &&
> +	    !is_mt7915(&dev->mt76)) {
> +		mt7915_sta_remove(hw, vif, sta);
> +		mt76_sta_pre_rcu_remove(hw, vif, sta);
> +		mt7915_sta_add(hw, vif, sta);
> +	}
> +
>   	mt76_connac_mcu_wtbl_update_hdr_trans(&dev->mt76, vif, sta);
>   }
>   
I suspect that this may a bit racy if there is concurrent tx activity 
(e.g. for EAP auth). Not sure if this could cause problems for the 
firmware or other kinds of bugs.

While my idea may need some rework of the existing functions, I think a 
better flow would be:

1. mt76_sta_pre_rcu_remove
2. save old wcid
3. mt7915_sta_add
4. synchronize_rcu()
5. remove firmware state for old wcid entry

- Felix
