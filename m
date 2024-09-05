Return-Path: <linux-wireless+bounces-12530-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 582D696D988
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Sep 2024 14:59:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9004B20F63
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Sep 2024 12:59:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A99C19B5BB;
	Thu,  5 Sep 2024 12:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="CD+/pCk5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81E89189BB5;
	Thu,  5 Sep 2024 12:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725541176; cv=none; b=bnIYjvTjmN3/ROpXZWDCU484DmsqYI1WJhjH+3BjYREhSglDsXbnf9TnNbcJR/J99b12waKbhIDPNe46aH0znIGsvqhrMnaxcQI5PoHQeZw7a84UNXOYCbUAHshv/q2Q66EbMvGlcSPTXw6snczbl159JQZkB9yhpaSBQAkrWOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725541176; c=relaxed/simple;
	bh=U8KsPidIOseHcU9fJbkYzs1/1HWUJ+Su99UJG+hwyHk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WuLGg0SiUeomfUKM/d42mdSjgz+zxPwFGIPQLKb21+bespDCC3sU1olThFMHskH2j15RAJQY5Qs69bpfkw3gXfD+bGdF95vbB1hxAjRTtRwyb0nuWA0rBD3cO+vDeG7PL3WB5jQjQRF2IxeN/mfV3TurUCOdeoQ13F5FyOOsC0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=CD+/pCk5; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ZAq/WJxRl2xBJIxFJpgtsT4PJFM/lj/rAoqJbf9U0sA=; b=CD+/pCk5mtH51Q16lJ4sroXiZs
	I6R3hgwZZzlSWkq9EP5RDAEf+R2m6QBmuEaDqRZlhqW1iru/OffZH96DdDtO/RB06oLGuVQe4Ji76
	46HWpIYojIOQdyuzhsWozqMGZ5mcH9vd/o37J3lNAwKT7O0jiA4i1Z3ygc7jelnSPPgQ=;
Received: from p4ff1376f.dip0.t-ipconnect.de ([79.241.55.111] helo=nf.local)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1smBeZ-009Esk-2q;
	Thu, 05 Sep 2024 14:31:59 +0200
Message-ID: <49a385d0-9ffc-468f-b7de-83abfa1e18f0@nbd.name>
Date: Thu, 5 Sep 2024 14:31:58 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6] wifi: mt76: mt7915: add wds support when wed is
 enabled
To: Shengyu Qu <wiagn233@outlook.com>, lorenzo@kernel.org,
 ryder.lee@mediatek.com, shayne.chen@mediatek.com, sean.wang@mediatek.com,
 kvalo@kernel.org, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com, daniel@makrotopia.org,
 miriam.rachel.korenblit@intel.com, money.wang@mediatek.com,
 StanleyYP.Wang@mediatek.com, meichia.chiu@mediatek.com,
 chui-hao.chiu@mediatek.com, johannes.berg@intel.com, quic_adisi@quicinc.com,
 sujuan.chen@mediatek.com, allen.ye@mediatek.com,
 linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Cc: Bo Jiao <bo.jiao@mediatek.com>
References: <TY3P286MB26111E4DB0841A176DF8E44E98BE2@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
From: Felix Fietkau <nbd@nbd.name>
Content-Language: en-US
Autocrypt: addr=nbd@nbd.name; keydata=
 xsDiBEah5CcRBADIY7pu4LIv3jBlyQ/2u87iIZGe6f0f8pyB4UjzfJNXhJb8JylYYRzIOSxh
 ExKsdLCnJqsG1PY1mqTtoG8sONpwsHr2oJ4itjcGHfn5NJSUGTbtbbxLro13tHkGFCoCr4Z5
 Pv+XRgiANSpYlIigiMbOkide6wbggQK32tC20QxUIwCg4k6dtV/4kwEeiOUfErq00TVqIiEE
 AKcUi4taOuh/PQWx/Ujjl/P1LfJXqLKRPa8PwD4j2yjoc9l+7LptSxJThL9KSu6gtXQjcoR2
 vCK0OeYJhgO4kYMI78h1TSaxmtImEAnjFPYJYVsxrhay92jisYc7z5R/76AaELfF6RCjjGeP
 wdalulG+erWju710Bif7E1yjYVWeA/9Wd1lsOmx6uwwYgNqoFtcAunDaMKi9xVQW18FsUusM
 TdRvTZLBpoUAy+MajAL+R73TwLq3LnKpIcCwftyQXK5pEDKq57OhxJVv1Q8XkA9Dn1SBOjNB
 l25vJDFAT9ntp9THeDD2fv15yk4EKpWhu4H00/YX8KkhFsrtUs69+vZQwc0cRmVsaXggRmll
 dGthdSA8bmJkQG5iZC5uYW1lPsJgBBMRAgAgBQJGoeQnAhsjBgsJCAcDAgQVAggDBBYCAwEC
 HgECF4AACgkQ130UHQKnbvXsvgCgjsAIIOsY7xZ8VcSm7NABpi91yTMAniMMmH7FRenEAYMa
 VrwYTIThkTlQzsFNBEah5FQQCACMIep/hTzgPZ9HbCTKm9xN4bZX0JjrqjFem1Nxf3MBM5vN
 CYGBn8F4sGIzPmLhl4xFeq3k5irVg/YvxSDbQN6NJv8o+tP6zsMeWX2JjtV0P4aDIN1pK2/w
 VxcicArw0VYdv2ZCarccFBgH2a6GjswqlCqVM3gNIMI8ikzenKcso8YErGGiKYeMEZLwHaxE
 Y7mTPuOTrWL8uWWRL5mVjhZEVvDez6em/OYvzBwbkhImrryF29e3Po2cfY2n7EKjjr3/141K
 DHBBdgXlPNfDwROnA5ugjjEBjwkwBQqPpDA7AYPvpHh5vLbZnVGu5CwG7NAsrb2isRmjYoqk
 wu++3117AAMFB/9S0Sj7qFFQcD4laADVsabTpNNpaV4wAgVTRHKV/kC9luItzwDnUcsZUPdQ
 f3MueRJ3jIHU0UmRBG3uQftqbZJj3ikhnfvyLmkCNe+/hXhPu9sGvXyi2D4vszICvc1KL4RD
 aLSrOsROx22eZ26KqcW4ny7+va2FnvjsZgI8h4sDmaLzKczVRIiLITiMpLFEU/VoSv0m1F4B
 FtRgoiyjFzigWG0MsTdAN6FJzGh4mWWGIlE7o5JraNhnTd+yTUIPtw3ym6l8P+gbvfoZida0
 TspgwBWLnXQvP5EDvlZnNaKa/3oBes6z0QdaSOwZCRA3QSLHBwtgUsrT6RxRSweLrcabwkkE
 GBECAAkFAkah5FQCGwwACgkQ130UHQKnbvW2GgCeMncXpbbWNT2AtoAYICrKyX5R3iMAoMhw
 cL98efvrjdstUfTCP2pfetyN
In-Reply-To: <TY3P286MB26111E4DB0841A176DF8E44E98BE2@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05.08.24 14:43, Shengyu Qu wrote:
> The current WED only supports 256 wcid, whereas mt7986 can support up to
> 512 entries, so firmware provides a rule to get sta_info by DA when wcid
> is set to 0x3ff by txd. Also, WED provides a register to overwrite txd
> wcid, that is, wcid[9:8] can be overwritten by 0x3 and wcid[7:0] is set
> to 0xff by host driver.
> 
> However, firmware is unable to get sta_info from DA as DA != RA for
> 4addr cases, so firmware and wifi host driver both use wcid (256 - 271)
> and (768 ~ 783) for sync up to get correct sta_info.
> 
> Currently WDS+WED config is completely broken on MT7986/7981 devices if
> without this patch.
> 
> Tested-by: Sujuan Chen <sujuan.chen@mediatek.com>
> Co-developed-by: Bo Jiao <bo.jiao@mediatek.com>
> Signed-off-by: Bo Jiao <bo.jiao@mediatek.com>
> Signed-off-by: Sujuan Chen <sujuan.chen@mediatek.com>
> Signed-off-by: Shengyu Qu <wiagn233@outlook.com>
> ---
> Changes since v1:
>   - Drop duplicate setting in mmio
>   - Reduce the patch size by redefining mt76_wcid_alloc
> Changes since v2:
>   - Rework wds wcid getting flow
> Changes since v3:
>   - Rebase to next-20240703
>   - Sync with downstream patch
> Changes since v4:
>   - Rebase to next-20240802
> Changes since v5:
>   - Fixed build test error reported by robot
>   - Rebase to next-20240805
> ---
>   drivers/net/wireless/mediatek/mt76/mt76.h     |  9 +++++
>   .../net/wireless/mediatek/mt76/mt7915/main.c  | 32 ++++++++++++++--
>   .../net/wireless/mediatek/mt76/mt7915/mcu.c   | 18 +++++++--
>   .../net/wireless/mediatek/mt76/mt7915/mcu.h   |  1 +
>   drivers/net/wireless/mediatek/mt76/util.c     | 37 +++++++++++++++++--
>   drivers/net/wireless/mediatek/mt76/util.h     |  7 +++-
>   6 files changed, 93 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
> index 4a58a78d5ed25..1186a4998faff 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt76.h
> +++ b/drivers/net/wireless/mediatek/mt76/mt76.h
> @@ -28,6 +28,9 @@
>   
>   #define MT76_TOKEN_FREE_THR	64
>   
> +#define MT76_WED_WDS_MIN    256
> +#define MT76_WED_WDS_MAX    272
> +
>   #define MT_QFLAG_WED_RING	GENMASK(1, 0)
>   #define MT_QFLAG_WED_TYPE	GENMASK(4, 2)
>   #define MT_QFLAG_WED		BIT(5)
> @@ -71,6 +74,12 @@ enum mt76_wed_type {
>   	MT76_WED_RRO_Q_IND,
>   };
>   
> +enum mt76_wed_state {
> +	MT76_WED_DEFAULT,
> +	MT76_WED_ACTIVE,
> +	MT76_WED_WDS_ACTIVE,
> +};
> +
>   struct mt76_bus_ops {
>   	u32 (*rr)(struct mt76_dev *dev, u32 offset);
>   	void (*wr)(struct mt76_dev *dev, u32 offset, u32 val);
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/main.c b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
> index 049223df9beb1..dc4d87e004a0f 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7915/main.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
> @@ -745,8 +745,15 @@ int mt7915_mac_sta_add(struct mt76_dev *mdev, struct ieee80211_vif *vif,
>   	bool ext_phy = mvif->phy != &dev->phy;
>   	int ret, idx;
>   	u32 addr;
> +	u8 flags = MT76_WED_DEFAULT;
>   
> -	idx = mt76_wcid_alloc(dev->mt76.wcid_mask, MT7915_WTBL_STA);
> +	if (mtk_wed_device_active(&dev->mt76.mmio.wed) &&
> +	    !is_mt7915(&dev->mt76)) {
> +		flags = test_bit(MT_WCID_FLAG_4ADDR, &msta->wcid.flags) ?
> +		       MT76_WED_WDS_ACTIVE : MT76_WED_ACTIVE;
> +	}
> +
> +	idx = __mt76_wcid_alloc(mdev->wcid_mask, MT7915_WTBL_STA, flags);
>   	if (idx < 0)
>   		return -ENOSPC;
>   

I'd prefer to replace the mt76_wcid_alloc flags argument with an 
explicit start offset argument.

> @@ -1201,12 +1208,27 @@ static void mt7915_sta_set_4addr(struct ieee80211_hw *hw,
>   {
>   	struct mt7915_dev *dev = mt7915_hw_dev(hw);
>   	struct mt7915_sta *msta = (struct mt7915_sta *)sta->drv_priv;
> +	int min = MT76_WED_WDS_MIN, max = MT76_WED_WDS_MAX;
>   
>   	if (enabled)
>   		set_bit(MT_WCID_FLAG_4ADDR, &msta->wcid.flags);
>   	else
>   		clear_bit(MT_WCID_FLAG_4ADDR, &msta->wcid.flags);
>   
> +	if (mtk_wed_device_active(&dev->mt76.mmio.wed) &&
> +	    !is_mt7915(&dev->mt76) &&
> +	    (msta->wcid.idx < min || msta->wcid.idx > max - 1)) {
> +		struct ieee80211_sta *pre_sta;
> +
> +		pre_sta = kzalloc(sizeof(*sta) + sizeof(*msta), GFP_KERNEL);
> +		mt76_sta_pre_rcu_remove(hw, vif, sta);
> +		memmove(pre_sta, sta, sizeof(*sta) + sizeof(*msta));
> +		mt7915_sta_add(hw, vif, sta);
> +		synchronize_rcu();
> +		mt7915_sta_remove(hw, vif, pre_sta);
> +		kfree(pre_sta);
> +	}
> +
>   	mt76_connac_mcu_wtbl_update_hdr_trans(&dev->mt76, vif, sta);
>   }
>  
In order to update the code based on my latest changes and to fix 
potential race conditions on tx/rx packets during the transition, please 
change to this order:

1. copy the sta
2. allocate a new wcid
3. change the wcid index in the copied sta to the newly allocated wcid
4. call mcu functions on the duplicate sta for creating the new sta entry.
5. use rcu_assign_pointer to point dev->wcid[new_idx] at &msta->wcid
6. swap wcid index between real sta and duplicated sta
7. rcu_assign_pointer(dev->wcid[orig_idx], NULL)
8. synchronize_rcu()
9. call mcu functions to delete the duplicate sta's entry (points to old 
wcid after the swap)
10. free the duplicated sta

This should allow mgmt tx/rx to work while the sta is being migrated to 
the new wcid entry.

- Felix

