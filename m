Return-Path: <linux-wireless+bounces-24477-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A1FAAE807E
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Jun 2025 13:01:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB4C4163E59
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Jun 2025 11:00:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76B67284671;
	Wed, 25 Jun 2025 11:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="EMJQkoC5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B34258CD4;
	Wed, 25 Jun 2025 11:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750849242; cv=none; b=evheTRed3vlHUUoragAXx8Hqk61jW3CyqjkOH2ZExAtWABeNlM39w+dCnKDtS5YDGJGY2IKQ8U+cGGEsXsnByekViUOyShwWNhEVVNJmPssuqnSH+k30aVK5XSmAqgPUR3PvU/XEzMlviWid6GZ/gHUJQ9iki2A4nAKpH3uSLMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750849242; c=relaxed/simple;
	bh=+x6fSB/WQHcp0Vug5wWQWdVUJtkKQUUmSyIUSu/li1U=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=MIPoVmDhQmekYD6TsGIO4pxuRrIzkajgLy0VCsq29VluCwwYpaWKf7VKlQSYfZ/QNohH1LmxIKI4xbBlbnQu7qmVEuM4Jhg6Y4EfaNDUu46Ljr9bSKsq3ZabjdTfoz/ULMDSdrVdQ5JYxqQPdbOo0Z1azLWG0JNImaRB4UiLGog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=EMJQkoC5; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:
	Cc:To:From:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=IgTZ8Doaenns0kp6CShEz6lSSfLEv08t3KTz58dMq24=; b=EMJQkoC5JNoF48oFw9eQq064dB
	qqtHg0ny2kZgJMYBU5xwAkh8CAez0GyaiTNIIGwfHB+AfC3atp8/vIW2dxVD467ydq0HJfjD1Du61
	SfD8/LU5m1GWYmTZiG4G5MVN+bf3pMXbG6FJwJFz7aS6eUyONmbSlpDmepBfYHMjKKmM=;
Received: from p54ae9243.dip0.t-ipconnect.de ([84.174.146.67] helo=nf.local)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1uUNrX-003V5L-2c;
	Wed, 25 Jun 2025 13:00:19 +0200
Message-ID: <3903ee21-c87d-4a2c-b688-d64a5796b6c0@nbd.name>
Date: Wed, 25 Jun 2025 13:00:18 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 RESEND] wifi: mt76: mt7915: add wds support when wed
 is enabled
From: Felix Fietkau <nbd@nbd.name>
To: Shengyu Qu <wiagn233@outlook.com>, pkshih@realtek.com,
 lorenzo@kernel.org, ryder.lee@mediatek.com, shayne.chen@mediatek.com,
 sean.wang@mediatek.com, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com, johannes.berg@intel.com,
 miriam.rachel.korenblit@intel.com, christophe.jaillet@wanadoo.fr,
 greearb@candelatech.com, howard-yh.hsu@mediatek.com,
 StanleyYP.Wang@mediatek.com, deren.wu@mediatek.com,
 chui-hao.chiu@mediatek.com, quic_adisi@quicinc.com, gustavoars@kernel.org,
 razvan.grigore@vampirebyte.ro, linux-wireless@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
Cc: Sujuan Chen <sujuan.chen@mediatek.com>, Bo Jiao <bo.jiao@mediatek.com>
References: <OSZPR01MB84342A0E21AAD111ED7AF6B198B82@OSZPR01MB8434.jpnprd01.prod.outlook.com>
 <TY4PR01MB1443294C4D36DF73852B4E79B9878A@TY4PR01MB14432.jpnprd01.prod.outlook.com>
 <26e6c7f7-a35f-4ebb-a55b-ade2ac7c20bb@nbd.name>
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
In-Reply-To: <26e6c7f7-a35f-4ebb-a55b-ade2ac7c20bb@nbd.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 25.06.25 12:18, Felix Fietkau wrote:
> On 24.06.25 16:11, Shengyu Qu wrote:
>> Hi Felix,
>> 
>> Please, tell me if this patch needs any polishing. I really don't know
>> why this patch still not get merged after such a long time(and 2x
>> resend), especially it already got a Reviewed-by and is a bugfix.
> 
> Hi Shengyu,
> 
> sorry it took such a long time for me to take a look at this patch.
> I don't see how it can even work properly in its current form, because
> of at least one bug:
> 
> When switching from non-wds to wds mode, the code calls
> mt7915_mac_sta_add in order to create the new sta. However, after
> changes that I made a while back, this function does not actually upload
> the station to the MCU anymore, since it is called on the NOTEXIST->NONE
> transition before assoc. Without corresponding ASSOC/AUTHORIZE events
> (handled by mt7915_mac_sta_event), the firmware doesn't get any data for
> the new wcid.
> 
> That said, I finally got around to starting to rework your patch myself.
> I will let you know when I have something ready for testing, hopefully
> later today.

Here's my first draft:

---
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 14927a92f9d1..f1d1b0ebd074 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -28,6 +28,9 @@
  
  #define MT76_TOKEN_FREE_THR	64
  
+#define MT76_WED_WDS_MIN    256
+#define MT76_WED_WDS_MAX    272
+
  #define MT_QFLAG_WED_RING	GENMASK(1, 0)
  #define MT_QFLAG_WED_TYPE	GENMASK(4, 2)
  #define MT_QFLAG_WED		BIT(5)
@@ -1181,6 +1184,7 @@ void mt76_wed_dma_reset(struct mt76_dev *dev);
  int mt76_wed_net_setup_tc(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
  			  struct net_device *netdev, enum tc_setup_type type,
  			  void *type_data);
+
  #ifdef CONFIG_NET_MEDIATEK_SOC_WED
  u32 mt76_wed_init_rx_buf(struct mtk_wed_device *wed, int size);
  int mt76_wed_offload_enable(struct mtk_wed_device *wed);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c b/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
index b287b7d9394e..ec2287459587 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
@@ -1385,7 +1385,7 @@ static ssize_t mt7915_sta_fixed_rate_set(struct file *file,
  
  out:
  	vif = container_of((void *)msta->vif, struct ieee80211_vif, drv_priv);
-	ret = mt7915_mcu_set_fixed_rate_ctrl(dev, vif, sta, &phy, field);
+	ret = mt7915_mcu_set_fixed_rate_ctrl(dev, vif, sta, &msta->wcid, &phy, field);
  	if (ret)
  		return -EFAULT;
  
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index 9400e4af2a04..e3e65848a17f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -1991,7 +1991,7 @@ void mt7915_mac_sta_rc_work(struct work_struct *work)
  		if (changed & (IEEE80211_RC_SUPP_RATES_CHANGED |
  			       IEEE80211_RC_NSS_CHANGED |
  			       IEEE80211_RC_BW_CHANGED))
-			mt7915_mcu_add_rate_ctrl(dev, vif, sta, true);
+			mt7915_mcu_add_rate_ctrl(dev, vif, sta, &msta->wcid, true);
  
  		if (changed & IEEE80211_RC_SMPS_CHANGED)
  			mt7915_mcu_add_smps(dev, vif, sta);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/main.c b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
index fe0639c14bf9..0227ea8665f1 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
@@ -747,7 +747,13 @@ int mt7915_mac_sta_add(struct mt76_dev *mdev, struct ieee80211_vif *vif,
  	bool ext_phy = mvif->phy != &dev->phy;
  	int idx;
  
-	idx = mt76_wcid_alloc(dev->mt76.wcid_mask, MT7915_WTBL_STA);
+	if (mtk_wed_device_active(&dev->mt76.mmio.wed) &&
+	    !is_mt7915(&dev->mt76) &&
+	    test_bit(MT_WCID_FLAG_4ADDR, &msta->wcid.flags))
+		idx = __mt76_wcid_alloc(mdev->wcid_mask, MT76_WED_WDS_MIN,
+					MT76_WED_WDS_MAX);
+	else
+		idx = mt76_wcid_alloc(mdev->wcid_mask, MT7915_WTBL_STA);
  	if (idx < 0)
  		return -ENOSPC;
  
@@ -836,7 +842,7 @@ int mt7915_mac_sta_event(struct mt76_dev *mdev, struct ieee80211_vif *vif,
  		addr = mt7915_mac_wtbl_lmac_addr(dev, msta->wcid.idx, 30);
  		mt76_rmw_field(dev, addr, GENMASK(7, 0), 0xa0);
  
-		ret = mt7915_mcu_add_rate_ctrl(dev, vif, sta, false);
+		ret = mt7915_mcu_add_rate_ctrl(dev, vif, sta, &msta->wcid, false);
  		if (ret)
  			return ret;
  
@@ -1267,6 +1273,40 @@ mt7915_set_bitrate_mask(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
  	return 0;
  }
  
+static void mt7915_sta_wed_set_4addr(struct mt7915_dev *dev, struct ieee80211_vif *vif,
+				     struct ieee80211_sta *sta)
+{
+	struct mt7915_sta *msta = (struct mt7915_sta *)sta->drv_priv;
+	int min = MT76_WED_WDS_MIN, max = MT76_WED_WDS_MAX;
+	int idx, prev_idx = msta->wcid.idx;
+	struct mt76_wcid wcid = msta->wcid;
+	int state;
+
+	if (!is_mt7915(&dev->mt76))
+		return;
+
+	if (msta->wcid.idx >= min && msta->wcid.idx < max)
+		return;
+
+	idx = __mt76_wcid_alloc(dev->mt76.wcid_mask, min, max);
+	if (idx < 0)
+		return;
+
+	wcid.idx = idx;
+	state = msta->wcid.sta ? CONN_STATE_PORT_SECURE : CONN_STATE_DISCONNECT;
+	__mt7915_mcu_add_sta(dev, vif, sta, &wcid, state, true);
+	mt7915_mcu_add_rate_ctrl(dev, vif, sta, &wcid, false);
+	rcu_assign_pointer(dev->mt76.wcid[idx], &msta->wcid);
+	msta->wcid.idx = idx;
+
+	synchronize_rcu();
+
+	rcu_assign_pointer(dev->mt76.wcid[prev_idx], NULL);
+	mt76_wcid_mask_clear(dev->mt76.wcid_mask, prev_idx);
+	wcid.idx = prev_idx;
+	__mt7915_mcu_add_sta(dev, vif, sta, &wcid, CONN_STATE_DISCONNECT, false);
+}
+
  static void mt7915_sta_set_4addr(struct ieee80211_hw *hw,
  				 struct ieee80211_vif *vif,
  				 struct ieee80211_sta *sta,
@@ -1280,6 +1320,9 @@ static void mt7915_sta_set_4addr(struct ieee80211_hw *hw,
  	else
  		clear_bit(MT_WCID_FLAG_4ADDR, &msta->wcid.flags);
  
+	if (mtk_wed_device_active(&dev->mt76.mmio.wed) && enabled)
+		mt7915_sta_wed_set_4addr(dev, vif, sta);
+
  	if (!msta->wcid.sta)
  		return;
  
@@ -1729,15 +1772,19 @@ mt7915_net_fill_forward_path(struct ieee80211_hw *hw,
  	if (!mtk_wed_device_active(wed))
  		return -ENODEV;
  
-	if (msta->wcid.idx > 0xff)
+	if (msta->wcid.idx > MT7915_WTBL_STA)
  		return -EIO;
  
  	path->type = DEV_PATH_MTK_WDMA;
  	path->dev = ctx->dev;
  	path->mtk_wdma.wdma_idx = wed->wdma_idx;
  	path->mtk_wdma.bss = mvif->mt76.idx;
-	path->mtk_wdma.wcid = is_mt7915(&dev->mt76) ? msta->wcid.idx : 0x3ff;
  	path->mtk_wdma.queue = phy != &dev->phy;
+	if (test_bit(MT_WCID_FLAG_4ADDR, &msta->wcid.flags) ||
+	    is_mt7915(&dev->mt76))
+		path->mtk_wdma.wcid = msta->wcid.idx;
+	else
+		path->mtk_wdma.wcid = 0x3ff;
  
  	ctx->dev = NULL;
  
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index cf948628e588..26497b580eb6 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -1359,6 +1359,7 @@ mt7915_mcu_get_mmps_mode(enum ieee80211_smps_mode smps)
  int mt7915_mcu_set_fixed_rate_ctrl(struct mt7915_dev *dev,
  				   struct ieee80211_vif *vif,
  				   struct ieee80211_sta *sta,
+				   struct mt76_wcid *wcid,
  				   void *data, u32 field)
  {
  	struct mt7915_vif *mvif = (struct mt7915_vif *)vif->drv_priv;
@@ -1430,7 +1431,7 @@ int mt7915_mcu_add_smps(struct mt7915_dev *dev, struct ieee80211_vif *vif,
  	if (ret)
  		return ret;
  
-	return mt7915_mcu_set_fixed_rate_ctrl(dev, vif, sta, NULL,
+	return mt7915_mcu_set_fixed_rate_ctrl(dev, vif, sta, &msta->wcid, NULL,
  					      RATE_PARAM_MMPS_UPDATE);
  }
  
@@ -1439,17 +1440,19 @@ mt7915_mcu_set_spe_idx(struct mt7915_dev *dev, struct ieee80211_vif *vif,
  		       struct ieee80211_sta *sta)
  {
  	struct mt7915_vif *mvif = (struct mt7915_vif *)vif->drv_priv;
+	struct mt7915_sta *msta = (struct mt7915_sta *)sta->drv_priv;
  	struct mt76_phy *mphy = mvif->phy->mt76;
  	u8 spe_idx = mt76_connac_spe_idx(mphy->antenna_mask);
  
-	return mt7915_mcu_set_fixed_rate_ctrl(dev, vif, sta, &spe_idx,
-					      RATE_PARAM_SPE_UPDATE);
+	return mt7915_mcu_set_fixed_rate_ctrl(dev, vif, sta, &msta->wcid,
+					      &spe_idx, RATE_PARAM_SPE_UPDATE);
  }
  
  static int
  mt7915_mcu_add_rate_ctrl_fixed(struct mt7915_dev *dev,
  			       struct ieee80211_vif *vif,
-			       struct ieee80211_sta *sta)
+			       struct ieee80211_sta *sta,
+			       struct mt76_wcid *wcid)
  {
  	struct mt7915_vif *mvif = (struct mt7915_vif *)vif->drv_priv;
  	struct cfg80211_chan_def *chandef = &mvif->phy->mt76->chandef;
@@ -1497,7 +1500,7 @@ mt7915_mcu_add_rate_ctrl_fixed(struct mt7915_dev *dev,
  
  	/* fixed single rate */
  	if (nrates == 1) {
-		ret = mt7915_mcu_set_fixed_rate_ctrl(dev, vif, sta, &phy,
+		ret = mt7915_mcu_set_fixed_rate_ctrl(dev, vif, sta, wcid, &phy,
  						     RATE_PARAM_FIXED_MCS);
  		if (ret)
  			return ret;
@@ -1519,7 +1522,7 @@ mt7915_mcu_add_rate_ctrl_fixed(struct mt7915_dev *dev,
  		else
  			mt76_rmw_field(dev, addr, GENMASK(15, 12), phy.sgi);
  
-		ret = mt7915_mcu_set_fixed_rate_ctrl(dev, vif, sta, &phy,
+		ret = mt7915_mcu_set_fixed_rate_ctrl(dev, vif, sta, wcid, &phy,
  						     RATE_PARAM_FIXED_GI);
  		if (ret)
  			return ret;
@@ -1527,7 +1530,7 @@ mt7915_mcu_add_rate_ctrl_fixed(struct mt7915_dev *dev,
  
  	/* fixed HE_LTF */
  	if (mask->control[band].he_ltf != GENMASK(7, 0)) {
-		ret = mt7915_mcu_set_fixed_rate_ctrl(dev, vif, sta, &phy,
+		ret = mt7915_mcu_set_fixed_rate_ctrl(dev, vif, sta, wcid, &phy,
  						     RATE_PARAM_FIXED_HE_LTF);
  		if (ret)
  			return ret;
@@ -1640,15 +1643,14 @@ mt7915_mcu_sta_rate_ctrl_tlv(struct sk_buff *skb, struct mt7915_dev *dev,
  }
  
  int mt7915_mcu_add_rate_ctrl(struct mt7915_dev *dev, struct ieee80211_vif *vif,
-			     struct ieee80211_sta *sta, bool changed)
+			     struct ieee80211_sta *sta, struct mt76_wcid *wcid,
+			     bool changed)
  {
  	struct mt7915_vif *mvif = (struct mt7915_vif *)vif->drv_priv;
-	struct mt7915_sta *msta = (struct mt7915_sta *)sta->drv_priv;
  	struct sk_buff *skb;
  	int ret;
  
-	skb = mt76_connac_mcu_alloc_sta_req(&dev->mt76, &mvif->mt76,
-					    &msta->wcid);
+	skb = mt76_connac_mcu_alloc_sta_req(&dev->mt76, &mvif->mt76, wcid);
  	if (IS_ERR(skb))
  		return PTR_ERR(skb);
  
@@ -1673,7 +1675,7 @@ int mt7915_mcu_add_rate_ctrl(struct mt7915_dev *dev, struct ieee80211_vif *vif,
  	 * and updates as peer fixed rate parameters, which overrides
  	 * sta_rec_ra and firmware rate control algorithm.
  	 */
-	return mt7915_mcu_add_rate_ctrl_fixed(dev, vif, sta);
+	return mt7915_mcu_add_rate_ctrl_fixed(dev, vif, sta, wcid);
  }
  
  static int
@@ -1704,8 +1706,9 @@ mt7915_mcu_add_group(struct mt7915_dev *dev, struct ieee80211_vif *vif,
  				 sizeof(req), true);
  }
  
-int mt7915_mcu_add_sta(struct mt7915_dev *dev, struct ieee80211_vif *vif,
-		       struct ieee80211_sta *sta, int conn_state, bool newly)
+int __mt7915_mcu_add_sta(struct mt7915_dev *dev, struct ieee80211_vif *vif,
+			 struct ieee80211_sta *sta,  struct mt76_wcid *wcid,
+			 int conn_state, bool newly)
  {
  	struct mt7915_vif *mvif = (struct mt7915_vif *)vif->drv_priv;
  	struct ieee80211_link_sta *link_sta;
@@ -1715,9 +1718,10 @@ int mt7915_mcu_add_sta(struct mt7915_dev *dev, struct ieee80211_vif *vif,
  
  	msta = sta ? (struct mt7915_sta *)sta->drv_priv : &mvif->sta;
  	link_sta = sta ? &sta->deflink : NULL;
+	if (!wcid)
+		wcid = &msta->wcid;
  
-	skb = mt76_connac_mcu_alloc_sta_req(&dev->mt76, &mvif->mt76,
-					    &msta->wcid);
+	skb = mt76_connac_mcu_alloc_sta_req(&dev->mt76, &mvif->mt76, wcid);
  	if (IS_ERR(skb))
  		return PTR_ERR(skb);
  
@@ -2413,10 +2417,20 @@ int mt7915_mcu_init_firmware(struct mt7915_dev *dev)
  
  	mt76_connac_mcu_del_wtbl_all(&dev->mt76);
  
-	if ((mtk_wed_device_active(&dev->mt76.mmio.wed) &&
-	     is_mt7915(&dev->mt76)) ||
-	    !mtk_wed_get_rx_capa(&dev->mt76.mmio.wed))
-		mt7915_mcu_wa_cmd(dev, MCU_WA_PARAM_CMD(CAPABILITY), 0, 0, 0);
+#if IS_ENABLED(CONFIG_NET_MEDIATEK_SOC_WED)
+	if (mtk_wed_device_active(&dev->mt76.mmio.wed)) {
+		if (is_mt7915(&dev->mt76) ||
+		    !mtk_wed_get_rx_capa(&dev->mt76.mmio.wed))
+			ret = mt7915_mcu_wa_cmd(dev, MCU_WA_PARAM_CMD(CAPABILITY),
+						0, 0, 0);
+		else
+			ret = mt7915_mcu_wa_cmd(dev, MCU_WA_PARAM_CMD(SET),
+						MCU_WA_PARAM_WED_VERSION,
+						dev->mt76.mmio.wed.rev_id, 0);
+		if (ret)
+			return ret;
+	}
+#endif
  
  	ret = mt7915_mcu_set_mwds(dev, 1);
  	if (ret)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
index 086ad89ecd91..989f24cb49eb 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
@@ -278,6 +278,7 @@ enum {
  	MCU_WA_PARAM_PDMA_RX = 0x04,
  	MCU_WA_PARAM_CPU_UTIL = 0x0b,
  	MCU_WA_PARAM_RED = 0x0e,
+	MCU_WA_PARAM_WED_VERSION = 0x32,
  	MCU_WA_PARAM_RED_SETTING = 0x40,
  };
  
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
index 2e94347c46d6..c781058a416f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
@@ -455,8 +455,16 @@ int mt7915_mcu_add_dev_info(struct mt7915_phy *phy,
  			    struct ieee80211_vif *vif, bool enable);
  int mt7915_mcu_add_bss_info(struct mt7915_phy *phy,
  			    struct ieee80211_vif *vif, int enable);
-int mt7915_mcu_add_sta(struct mt7915_dev *dev, struct ieee80211_vif *vif,
-		       struct ieee80211_sta *sta, int conn_state, bool newly);
+int __mt7915_mcu_add_sta(struct mt7915_dev *dev, struct ieee80211_vif *vif,
+			 struct ieee80211_sta *sta, struct mt76_wcid *wcid,
+			 int conn_state, bool newly);
+static inline int
+mt7915_mcu_add_sta(struct mt7915_dev *dev, struct ieee80211_vif *vif,
+		   struct ieee80211_sta *sta, int conn_state, bool newly)
+{
+    return __mt7915_mcu_add_sta(dev, vif, sta, NULL, conn_state, newly);
+}
+
  int mt7915_mcu_add_tx_ba(struct mt7915_dev *dev,
  			 struct ieee80211_ampdu_params *params,
  			 bool add);
@@ -472,7 +480,8 @@ int mt7915_mcu_add_beacon(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
  int mt7915_mcu_add_obss_spr(struct mt7915_phy *phy, struct ieee80211_vif *vif,
  			    struct ieee80211_he_obss_pd *he_obss_pd);
  int mt7915_mcu_add_rate_ctrl(struct mt7915_dev *dev, struct ieee80211_vif *vif,
-			     struct ieee80211_sta *sta, bool changed);
+			     struct ieee80211_sta *sta, struct mt76_wcid *wcid,
+			     bool changed);
  int mt7915_mcu_add_smps(struct mt7915_dev *dev, struct ieee80211_vif *vif,
  			struct ieee80211_sta *sta);
  int mt7915_set_channel(struct mt76_phy *mphy);
@@ -482,6 +491,7 @@ int mt7915_mcu_update_edca(struct mt7915_dev *dev, void *req);
  int mt7915_mcu_set_fixed_rate_ctrl(struct mt7915_dev *dev,
  				   struct ieee80211_vif *vif,
  				   struct ieee80211_sta *sta,
+				   struct mt76_wcid *wcid,
  				   void *data, u32 field);
  int mt7915_mcu_set_eeprom(struct mt7915_dev *dev);
  int mt7915_mcu_get_eeprom(struct mt7915_dev *dev, u32 offset, u8 *read_buf);
diff --git a/drivers/net/wireless/mediatek/mt76/util.c b/drivers/net/wireless/mediatek/mt76/util.c
index 95b3dc96e4c4..9fa60d380ede 100644
--- a/drivers/net/wireless/mediatek/mt76/util.c
+++ b/drivers/net/wireless/mediatek/mt76/util.c
@@ -42,12 +42,19 @@ bool ____mt76_poll_msec(struct mt76_dev *dev, u32 offset, u32 mask, u32 val,
  }
  EXPORT_SYMBOL_GPL(____mt76_poll_msec);
  
-int mt76_wcid_alloc(u32 *mask, int size)
+int __mt76_wcid_alloc(u32 *mask, int min, int size)
  {
+	u32 min_mask = ~0;
  	int i, idx = 0, cur;
  
+	mask += min / 32;
+	min %= 32;
+	if (min > 0)
+		min_mask = ~((1 << min) - 1);
+
  	for (i = 0; i < DIV_ROUND_UP(size, 32); i++) {
-		idx = ffs(~mask[i]);
+		idx = ffs(~mask[i] & min_mask);
+		min_mask = ~0;
  		if (!idx)
  			continue;
  
@@ -62,7 +69,7 @@ int mt76_wcid_alloc(u32 *mask, int size)
  
  	return -1;
  }
-EXPORT_SYMBOL_GPL(mt76_wcid_alloc);
+EXPORT_SYMBOL_GPL(__mt76_wcid_alloc);
  
  int mt76_get_min_avg_rssi(struct mt76_dev *dev, u8 phy_idx)
  {
diff --git a/drivers/net/wireless/mediatek/mt76/util.h b/drivers/net/wireless/mediatek/mt76/util.h
index 260965dde94c..bca2893f980e 100644
--- a/drivers/net/wireless/mediatek/mt76/util.h
+++ b/drivers/net/wireless/mediatek/mt76/util.h
@@ -27,7 +27,12 @@ enum {
  #define MT76_INCR(_var, _size) \
  	(_var = (((_var) + 1) % (_size)))
  
-int mt76_wcid_alloc(u32 *mask, int size);
+int __mt76_wcid_alloc(u32 *mask, int min, int size);
+
+static inline int mt76_wcid_alloc(u32 *mask, int size)
+{
+	return __mt76_wcid_alloc(mask, 0, size);
+}
  
  static inline void
  mt76_wcid_mask_set(u32 *mask, int idx)
-- 
2.49.0



