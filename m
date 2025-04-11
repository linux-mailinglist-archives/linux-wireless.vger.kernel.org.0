Return-Path: <linux-wireless+bounces-21440-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C29BA85947
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Apr 2025 12:17:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 255653AF84A
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Apr 2025 10:15:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 684EC278E51;
	Fri, 11 Apr 2025 10:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="unknown key version" (0-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b="h/R4gUEd";
	dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b="G1DrCE+M"
X-Original-To: linux-wireless@vger.kernel.org
Received: from e2i655.smtp2go.com (e2i655.smtp2go.com [103.2.142.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9699F278E68
	for <linux-wireless@vger.kernel.org>; Fri, 11 Apr 2025 10:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.2.142.143
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744366536; cv=none; b=q9M6AV5FHvqxnXsU+9YG/uQepplmGpL5vf7Asnn+V9rO5PNbDTZ9Kcexih5F631m1oWw2UzatgYbGAC3sOIwyhbvc5j1W4UwVaI5bQK1pu348aNK8IFxvouVBvtS/0emIZK9fOMJFi5Ia7+GimZXqGuDuXmhJPrEKrFpvB5bcGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744366536; c=relaxed/simple;
	bh=PWNSQc6TOmToyxJPxRmIfaUxC8jmVIYtwGAloEpfCXo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JPTyKyiHhZQaoI9dou/JSBwEuXXMurhAh5dOtJVWhFxXwup6OZY3PGV1DQwNczdLR8Gg1oGZ7mUH+C1qmIufqDJ9zPacGXSeKM7BUUNNoXH/CIus2rXidPrmRBembB9XJRH7Oj9jwT9lptl4AssB0eLVWzeykTVxz0pjjLPmOIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt; spf=pass smtp.mailfrom=em510616.triplefau.lt; dkim=fail (0-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b=h/R4gUEd reason="unknown key version"; dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b=G1DrCE+M; arc=none smtp.client-ip=103.2.142.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em510616.triplefau.lt
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=smtpservice.net; s=maxzs0.a1-4.dyn; x=1744367433; h=Feedback-ID:
	X-Smtpcorp-Track:Message-ID:Subject:To:From:Date:Reply-To:Sender:
	List-Unsubscribe:List-Unsubscribe-Post;
	bh=FT6H7ZVT7qjT0tHeNL6ZfiwPZh7QsXu9tJmoUMdPOTM=; b=h/R4gUEdMQ2+epYwTejYW/KtKm
	FCxf6cL5udLnq/ivJcSEzBPTASrayuTy2+OEY3SUgA0Yo75rDTSDxZri3Qrs/YZ8cuhStc3QzH1oA
	zBRpjFTHDJaEjFZOVGoqEsp1ZTzzzLyI57kM5SE1281R1s+KrLWzd27mgn4JGlhFhDgInf9NDJZAo
	Vc+yP+quKPdjL14kPg9Iqv2AVxOxYd0kh7xaLvjhQVw1WLNUsITG2VO0lz+yTkHYBqMea0BrfiSy4
	tD1bzsLoK3imA3FvJbUcvagnKdm5v1dxNsT1zGhwTcrFWjAofILEWI/TmsVsuHGW+iyEYtl4lZpwH
	uJ6jwaIQ==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=triplefau.lt;
 i=@triplefau.lt; q=dns/txt; s=s510616; t=1744366533; h=from : subject
 : to : message-id : date;
 bh=FT6H7ZVT7qjT0tHeNL6ZfiwPZh7QsXu9tJmoUMdPOTM=;
 b=G1DrCE+MSC2NRGeuEXAOcvnLqgUsYHyGnHK7CvuyPqn+r/Kwa6K6Q/17mqIPhSd9g/JpS
 7P85QQbaF/ZJ49I1Y3wP7HqKBzC4wSVunweYbaesxQNTbcdMCPAREw8SWjDao4WLqo+XKLf
 A8gXvHK6GrhAal46yUO8tZrL2vBmWup4VZVQRL28Ug3EmzvsRgc72I73sbuX+Z8dqCWRaRn
 kQfaE+QDHVUgyLQ7Rdcn+mgtsaTAL3EDU2oU05NMXh6JF5bTMQAtKIi0Dtjbckli2vhmq3I
 cQI85AiSx+aDL3VZwGoz2yt8qiV8pRDssrDRN+TJJmFY016UrN8V2d23d74Q==
Received: from [10.139.162.187] (helo=SmtpCorp) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.94.2-S2G) (envelope-from <repk@triplefau.lt>)
 id 1u3BNh-qt4DyW-Nr; Fri, 11 Apr 2025 10:13:05 +0000
Received: from [10.12.239.196] (helo=localhost) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.97.1-S2G) (envelope-from <repk@triplefau.lt>)
 id 1u3BNh-4o5NDgrpqqr-lFwP; Fri, 11 Apr 2025 10:13:05 +0000
Date: Fri, 11 Apr 2025 12:06:35 +0200
From: Remi Pommarel <repk@triplefau.lt>
To: Bert Karwatzki <spasswolf@web.de>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
 johannes@sipsolutions.net
Subject: Re: [PATCH wireless v2 1/2] wifi: mac80211: Update skb's control
 block key in ieee80211_tx_dequeue()
Message-ID: <Z_jpq26P99qzPP1c@pilgrim>
References: <06aa507b853ca385ceded81c18b0a6dd0f081bc8.1742833382.git.repk@triplefau.lt>
 <20250410215527.3001-1-spasswolf@web.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250410215527.3001-1-spasswolf@web.de>
X-Smtpcorp-Track: xTYCxRJLbNMz.HbZxGv1vVrQD.BuTyaAF6buh
Feedback-ID: 510616m:510616apGKSTK:510616sBGiWowcYh
X-Report-Abuse: Please forward a copy of this message, including all headers,
 to <abuse-report@smtp2go.com>

Hi Bert,

On Thu, Apr 10, 2025 at 11:55:26PM +0200, Bert Karwatzki wrote:
> This commit breaks the mediatek mt7921 wireless driver. In linux-next-20250410
> my mt7921e Wi-Fi controller is no longer able to connect to a network.
> I bisected this to commit a104042e2bf6 ("wifi: mac80211: Update skb's control
> block key in ieee80211_tx_dequeue()").
> 
> Hardware:
> 04:00.0 Network controller: MEDIATEK Corp. MT7921K (RZ608) Wi-Fi 6E 80MHz
> 
> This debugging patch reveals that the change causes key to be NULL in
> mt7921_tx_prepare_skb().
> 
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/pci_mac.c b/drivers/net/wireless/mediatek/mt76/mt7921/pci_mac.c
> index 881812ba03ff..3b8552a1055c 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7921/pci_mac.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7921/pci_mac.c
> @@ -13,6 +13,7 @@ int mt7921e_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
>         struct mt792x_dev *dev = container_of(mdev, struct mt792x_dev, mt76);
>         struct ieee80211_tx_info *info = IEEE80211_SKB_CB(tx_info->skb);
>         struct ieee80211_key_conf *key = info->control.hw_key;
> +       dev_info(mdev->dev, "%s: key = %px\n", __func__, key);
>         struct mt76_connac_hw_txp *txp;
>         struct mt76_txwi_cache *t;
>         int id, pid;
> 
> 
> So why is info->control.hw_key not updated by ieee80211_tx_h_select_key()?
> 
> diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
> index 34f229a6eab0..2510e3533d13 100644
> --- a/net/mac80211/tx.c
> +++ b/net/mac80211/tx.c
> @@ -631,8 +631,10 @@ ieee80211_tx_h_select_key(struct ieee80211_tx_data *tx)
>  		case WLAN_CIPHER_SUITE_WEP40:
>  		case WLAN_CIPHER_SUITE_WEP104:
>  		case WLAN_CIPHER_SUITE_TKIP:
> -			if (!ieee80211_is_data_present(hdr->frame_control))
> +			if (!ieee80211_is_data_present(hdr->frame_control)) {
> +				printk(KERN_INFO "%s %d: setting tx->key = NULL\n", __func__, __LINE__);
>  				tx->key = NULL;
> +			}
>  			break;
>  		case WLAN_CIPHER_SUITE_CCMP:
>  		case WLAN_CIPHER_SUITE_CCMP_256:
> @@ -641,19 +643,23 @@ ieee80211_tx_h_select_key(struct ieee80211_tx_data *tx)
>  			if (!ieee80211_is_data_present(hdr->frame_control) &&
>  			    !ieee80211_use_mfp(hdr->frame_control, tx->sta,
>  					       tx->skb) &&
> -			    !ieee80211_is_group_privacy_action(tx->skb))
> +			    !ieee80211_is_group_privacy_action(tx->skb)) {
> +				printk(KERN_INFO "%s %d: setting tx->key = NULL\n", __func__, __LINE__);
>  				tx->key = NULL;
> -			else
> +			} else {
>  				skip_hw = (tx->key->conf.flags &
>  					   IEEE80211_KEY_FLAG_SW_MGMT_TX) &&
>  					ieee80211_is_mgmt(hdr->frame_control);
> +			}
>  			break;
>  		case WLAN_CIPHER_SUITE_AES_CMAC:
>  		case WLAN_CIPHER_SUITE_BIP_CMAC_256:
>  		case WLAN_CIPHER_SUITE_BIP_GMAC_128:
>  		case WLAN_CIPHER_SUITE_BIP_GMAC_256:
> -			if (!ieee80211_is_mgmt(hdr->frame_control))
> +			if (!ieee80211_is_mgmt(hdr->frame_control)) {
> +				printk(KERN_INFO "%s %d: setting tx->key = NULL\n", __func__, __LINE__);
>  				tx->key = NULL;
> +			}
>  			break;
>  		}
> 
> @@ -662,9 +668,13 @@ ieee80211_tx_h_select_key(struct ieee80211_tx_data *tx)
>  			     tx->skb->protocol != tx->sdata->control_port_protocol)
>  			return TX_DROP;
> 
> +		printk(KERN_INFO "%s: skip_hw=%d tx->key=%px\n",
> +				__func__, skip_hw, tx->key);
>  		if (!skip_hw && tx->key &&
> -		    tx->key->flags & KEY_FLAG_UPLOADED_TO_HARDWARE)
> +		    tx->key->flags & KEY_FLAG_UPLOADED_TO_HARDWARE) {
>  			info->control.hw_key = &tx->key->conf;
> +			printk(KERN_INFO "%s: info->control.hw_key = %px\n", __func__, info->control.hw_key);
> +		}
>  	} else if (ieee80211_is_data_present(hdr->frame_control) && tx->sta &&
>  		   test_sta_flag(tx->sta, WLAN_STA_USES_ENCRYPTION)) {
>  		return TX_DROP;
> @@ -3894,6 +3904,8 @@ struct sk_buff *ieee80211_tx_dequeue(struct ieee80211_hw *hw,
>  	 * The key can be removed while the packet was queued, so need to call
>  	 * this here to get the current key.
>  	 */
> +	printk(KERN_INFO "%s: info->control.hw_key = %px, setting to NULL\n",
> +			__func__, info->control.hw_key);
>  	info->control.hw_key = NULL;
>  	r = ieee80211_tx_h_select_key(&tx);
>  	if (r != TX_CONTINUE) {
> 
> This patch reveals that tx->key is set to NULL (in the @@ -641,19 +643,23 @@ chunk)
> and so the updating of info->contro.hw_key is skipped:
> 
> [   17.411298] [   T1232] ieee80211_tx_h_select_key 647: setting tx->key = NULL

That means that we are trying to send non management frames using
AES_CMAC, or BIP_* cipher, aren't those ciphers used only for group
management frames ?

> [   17.411300] [   T1232] ieee80211_tx_h_select_key: skip_hw=0 tx->key=0000000000000000
> [   17.411307] [   T1232] mt7921e 0000:04:00.0: mt7921e_tx_prepare_skb: key = 0000000000000000
> 
> If I revert commit a104042e2bf6 while keeping the debug patches it shows that
> the for mt7921e the key is never updated in ieee80211_tx_h_select_key(), mt7921e
> relies on the key your patch is setting to NULL.
> 
> Is this a problem with your patch or with the mt7921e driver that just got
> revealed by your patch?

Not sure yet, do you happen to know which kind of frame mt7921e is
trying to be sent using this NULL key ?

Thanks,

-- 
Remi

