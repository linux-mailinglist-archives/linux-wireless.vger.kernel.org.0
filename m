Return-Path: <linux-wireless+bounces-25604-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A3D3B08E79
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jul 2025 15:47:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB8947AE280
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jul 2025 13:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E64AF2EE962;
	Thu, 17 Jul 2025 13:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b="xpNA0Vos";
	dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b="QYiTWilU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from e3i105.smtp2go.com (e3i105.smtp2go.com [158.120.84.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33C132EE29B
	for <linux-wireless@vger.kernel.org>; Thu, 17 Jul 2025 13:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=158.120.84.105
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752760012; cv=none; b=nX3hjJMn1U1GghS6nWtTy7zJDT316XECKt0pStOxwwNs2PFh5pJUDHf7DtJKlwGeyuH3zM+/PK7raqwsXLco/E1n6ZTbDbMm/I8uW13Dn4NqlxcKZrKvXS/9iGeGIDdLgbWJ8hbSDsTmdDw+BUBnAqztbXtcprkrDIayMv/vdxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752760012; c=relaxed/simple;
	bh=2AFVLZpaDJuvTy/9IR0EjWZDdFrNKje4FwspU0zrMDo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sn+3VJuyMg26Fd8VEp8YuluSDGTLlTrPLpDGWp8NSjw6DCQuWnFrN+UkCbnIirl5LWPwB7MYa8TIlnmK6p7YXibw1tuLjirr/TdNAyq0z4rhiMxwKXSGQ6ZhBBRb+pAdNkDdUQz7qDNXqWqUiLf+QtRkjoMyqEJhP8Hrp5oxwWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt; spf=pass smtp.mailfrom=em510616.triplefau.lt; dkim=pass (2048-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b=xpNA0Vos; dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b=QYiTWilU; arc=none smtp.client-ip=158.120.84.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em510616.triplefau.lt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smtpservice.net;
 i=@smtpservice.net; q=dns/txt; s=a1-4; t=1752759099; h=feedback-id :
 x-smtpcorp-track : date : message-id : to : subject : from : reply-to
 : sender : list-unsubscribe : list-unsubscribe-post;
 bh=U+rA0WL2vtAgdbnb0RO7hJmpVlrm4hMeQOrhAQBOlvs=;
 b=xpNA0VosGSlPYeFWZWkhoOymccu91BWSghcn64r6pZhIR/ihaBfsiZnldIa8Jf8E+y4f7
 SqbkYbpVH8n1QqJcMRmiolz5AkM+Teh1/eBhraHzgKbWIHbGoj0wWjD1SCq0H2AhWSZpE1i
 tIGsBNpMX4ntWnAZQeCJ2AFY5vG6B8kQvMv6eLEkT6mzgFMRzL2UK5b7lcAzVSp44iDxTFo
 fPAL39+XMnsGEYtC7P4EHY0rE4D1P6Rf6y1y5EWBsl3I89gWWaD003gbagsZN9ggfND96Sk
 MDDQgpbOVeNPDpW+ixbJBG944MGDwGA1+w5UxN5vVVMhsdnbOPZPGZFyyuAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=triplefau.lt;
 i=@triplefau.lt; q=dns/txt; s=s510616; t=1752759099; h=from : subject
 : to : message-id : date;
 bh=U+rA0WL2vtAgdbnb0RO7hJmpVlrm4hMeQOrhAQBOlvs=;
 b=QYiTWilUNMVDNrsh3/jZURVmaDAeBJoMT0AAfMI2lWC5qluuhrEsE63A2ItirtexYPFTY
 GI6SlqYN1wRlRIUvk/L0+3U29lsrD9wqOgnrmf6sNRwyDEQl+L99eHFZUJc2B9L20qogjtZ
 Piz7Ol/ORfa+WiaOa2maB5bpKBAPQvFdZRmqJGiAogoovn+LQJ3NWNvfXXp8Z9M0/A/k+YZ
 a6jFlLFX0eGovJ2z1B6DDQSMPqDdryB7ueY64ENz/GNcsp7Yc5WQ+NEd3v2aZv8sJgQ18lW
 xKJKGHoY/kBHkO0NZd7/9+a3aar7uPUBEBRKRurgYqmB6pzMogDrUpNz621A==
Received: from [10.12.239.196] (helo=localhost)
	by smtpcorp.com with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.1-S2G)
	(envelope-from <repk@triplefau.lt>)
	id 1ucOhx-4o5NDgrvtl6-ppbp;
	Thu, 17 Jul 2025 13:31:33 +0000
Date: Thu, 17 Jul 2025 15:21:17 +0200
From: Remi Pommarel <repk@triplefau.lt>
To: Bert Karwatzki <spasswolf@web.de>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	johannes@sipsolutions.net, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH wireless v2 1/2] wifi: mac80211: Update skb's control
 block key in ieee80211_tx_dequeue()
Message-ID: <aHj4zS_3uhDRhzDn@pilgrim>
References: <06aa507b853ca385ceded81c18b0a6dd0f081bc8.1742833382.git.repk@triplefau.lt>
 <20250410215527.3001-1-spasswolf@web.de>
 <Z_jpq26P99qzPP1c@pilgrim>
 <1df3a3df19b77e3b8d1f71a3a93c61221ff46a6b.camel@web.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1df3a3df19b77e3b8d1f71a3a93c61221ff46a6b.camel@web.de>
X-Report-Abuse: Please forward a copy of this message, including all headers, to <abuse-report@smtp2go.com>
Feedback-ID: 510616m:510616apGKSTK:510616sBGiWowcYh
X-smtpcorp-track: tT_gXoYkorvC.jl35aod29ly9.qZebfA7ByG1

Hello Bert, Johannes

On Fri, Apr 11, 2025 at 01:10:02PM +0200, Bert Karwatzki wrote:
> Am Freitag, dem 11.04.2025 um 12:06 +0200 schrieb Remi Pommarel:
> > Hi Bert,
> >
> > On Thu, Apr 10, 2025 at 11:55:26PM +0200, Bert Karwatzki wrote:
> > > This commit breaks the mediatek mt7921 wireless driver. In linux-next-20250410
> > > my mt7921e Wi-Fi controller is no longer able to connect to a network.
> > > I bisected this to commit a104042e2bf6 ("wifi: mac80211: Update skb's control
> > > block key in ieee80211_tx_dequeue()").
> > >
> > > Hardware:
> > > 04:00.0 Network controller: MEDIATEK Corp. MT7921K (RZ608) Wi-Fi 6E 80MHz
> > >
> > > This debugging patch reveals that the change causes key to be NULL in
> > > mt7921_tx_prepare_skb().
> > >
> > > diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/pci_mac.c b/drivers/net/wireless/mediatek/mt76/mt7921/pci_mac.c
> > > index 881812ba03ff..3b8552a1055c 100644
> > > --- a/drivers/net/wireless/mediatek/mt76/mt7921/pci_mac.c
> > > +++ b/drivers/net/wireless/mediatek/mt76/mt7921/pci_mac.c
> > > @@ -13,6 +13,7 @@ int mt7921e_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
> > >         struct mt792x_dev *dev = container_of(mdev, struct mt792x_dev, mt76);
> > >         struct ieee80211_tx_info *info = IEEE80211_SKB_CB(tx_info->skb);
> > >         struct ieee80211_key_conf *key = info->control.hw_key;
> > > +       dev_info(mdev->dev, "%s: key = %px\n", __func__, key);
> > >         struct mt76_connac_hw_txp *txp;
> > >         struct mt76_txwi_cache *t;
> > >         int id, pid;
> > >
> > >
> > > So why is info->control.hw_key not updated by ieee80211_tx_h_select_key()?
> > >
> > > diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
> > > index 34f229a6eab0..2510e3533d13 100644
> > > --- a/net/mac80211/tx.c
> > > +++ b/net/mac80211/tx.c
> > > @@ -631,8 +631,10 @@ ieee80211_tx_h_select_key(struct ieee80211_tx_data *tx)
> > >  		case WLAN_CIPHER_SUITE_WEP40:
> > >  		case WLAN_CIPHER_SUITE_WEP104:
> > >  		case WLAN_CIPHER_SUITE_TKIP:
> > > -			if (!ieee80211_is_data_present(hdr->frame_control))
> > > +			if (!ieee80211_is_data_present(hdr->frame_control)) {
> > > +				printk(KERN_INFO "%s %d: setting tx->key = NULL\n", __func__, __LINE__);
> > >  				tx->key = NULL;
> > > +			}
> > >  			break;
> > >  		case WLAN_CIPHER_SUITE_CCMP:
> > >  		case WLAN_CIPHER_SUITE_CCMP_256:
> > > @@ -641,19 +643,23 @@ ieee80211_tx_h_select_key(struct ieee80211_tx_data *tx)
> > >  			if (!ieee80211_is_data_present(hdr->frame_control) &&
> > >  			    !ieee80211_use_mfp(hdr->frame_control, tx->sta,
> > >  					       tx->skb) &&
> > > -			    !ieee80211_is_group_privacy_action(tx->skb))
> > > +			    !ieee80211_is_group_privacy_action(tx->skb)) {
> > > +				printk(KERN_INFO "%s %d: setting tx->key = NULL\n", __func__, __LINE__);
> > >  				tx->key = NULL;
> > > -			else
> > > +			} else {
> > >  				skip_hw = (tx->key->conf.flags &
> > >  					   IEEE80211_KEY_FLAG_SW_MGMT_TX) &&
> > >  					ieee80211_is_mgmt(hdr->frame_control);
> > > +			}
> > >  			break;
> > >  		case WLAN_CIPHER_SUITE_AES_CMAC:
> > >  		case WLAN_CIPHER_SUITE_BIP_CMAC_256:
> > >  		case WLAN_CIPHER_SUITE_BIP_GMAC_128:
> > >  		case WLAN_CIPHER_SUITE_BIP_GMAC_256:
> > > -			if (!ieee80211_is_mgmt(hdr->frame_control))
> > > +			if (!ieee80211_is_mgmt(hdr->frame_control)) {
> > > +				printk(KERN_INFO "%s %d: setting tx->key = NULL\n", __func__, __LINE__);
> > >  				tx->key = NULL;
> > > +			}
> > >  			break;
> > >  		}
> > >
> > > @@ -662,9 +668,13 @@ ieee80211_tx_h_select_key(struct ieee80211_tx_data *tx)
> > >  			     tx->skb->protocol != tx->sdata->control_port_protocol)
> > >  			return TX_DROP;
> > >
> > > +		printk(KERN_INFO "%s: skip_hw=%d tx->key=%px\n",
> > > +				__func__, skip_hw, tx->key);
> > >  		if (!skip_hw && tx->key &&
> > > -		    tx->key->flags & KEY_FLAG_UPLOADED_TO_HARDWARE)
> > > +		    tx->key->flags & KEY_FLAG_UPLOADED_TO_HARDWARE) {
> > >  			info->control.hw_key = &tx->key->conf;
> > > +			printk(KERN_INFO "%s: info->control.hw_key = %px\n", __func__, info->control.hw_key);
> > > +		}
> > >  	} else if (ieee80211_is_data_present(hdr->frame_control) && tx->sta &&
> > >  		   test_sta_flag(tx->sta, WLAN_STA_USES_ENCRYPTION)) {
> > >  		return TX_DROP;
> > > @@ -3894,6 +3904,8 @@ struct sk_buff *ieee80211_tx_dequeue(struct ieee80211_hw *hw,
> > >  	 * The key can be removed while the packet was queued, so need to call
> > >  	 * this here to get the current key.
> > >  	 */
> > > +	printk(KERN_INFO "%s: info->control.hw_key = %px, setting to NULL\n",
> > > +			__func__, info->control.hw_key);
> > >  	info->control.hw_key = NULL;
> > >  	r = ieee80211_tx_h_select_key(&tx);
> > >  	if (r != TX_CONTINUE) {
> > >
> > > This patch reveals that tx->key is set to NULL (in the @@ -641,19 +643,23 @@ chunk)
> > > and so the updating of info->contro.hw_key is skipped:
> > >
> > > [   17.411298] [   T1232] ieee80211_tx_h_select_key 647: setting tx->key = NULL
> >
> > That means that we are trying to send non management frames using
> > AES_CMAC, or BIP_* cipher, aren't those ciphers used only for group
> > management frames ?
> >
> > > [   17.411300] [   T1232] ieee80211_tx_h_select_key: skip_hw=0 tx->key=0000000000000000
> > > [   17.411307] [   T1232] mt7921e 0000:04:00.0: mt7921e_tx_prepare_skb: key = 0000000000000000
> > >
> > > If I revert commit a104042e2bf6 while keeping the debug patches it shows that
> > > the for mt7921e the key is never updated in ieee80211_tx_h_select_key(), mt7921e
> > > relies on the key your patch is setting to NULL.
> > >
> > > Is this a problem with your patch or with the mt7921e driver that just got
> > > revealed by your patch?
> >
> > Not sure yet, do you happen to know which kind of frame mt7921e is
> > trying to be sent using this NULL key ?
> >
> > Thanks,
> 
> I modified my debugging patch to print mgmt->frame_control, if needed I could
> also insert a nore complicated function printing out frame types using the
> ieee80211_is_*() functions:
> 
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/pci_mac.c
> b/drivers/net/wireless/mediatek/mt76/mt7921/pci_mac.c
> index 881812ba03ff..cfbe7e1e4713 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7921/pci_mac.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7921/pci_mac.c
> @@ -13,6 +13,9 @@ int mt7921e_tx_prepare_skb(struct mt76_dev *mdev, void
> *txwi_ptr,
>         struct mt792x_dev *dev = container_of(mdev, struct mt792x_dev, mt76);
>         struct ieee80211_tx_info *info = IEEE80211_SKB_CB(tx_info->skb);
>         struct ieee80211_key_conf *key = info->control.hw_key;
> +       struct ieee80211_mgmt *mgmt = (void *)tx_info->skb->data;
> +       __le16 fc = mgmt->frame_control;
> +       dev_info(mdev->dev, "%s: key = %px fc = 0x%hx\n", __func__, key, fc);
>         struct mt76_connac_hw_txp *txp;
>         struct mt76_txwi_cache *t;
>         int id, pid;
> 
> and get this, while unsuccesfully trying to connect (also note that one time
> getting a key worked):
> 
> $ dmesg | grep prepare_skb
> [   11.775642] [   T1227] mt7921e 0000:04:00.0: mt7921e_tx_prepare_skb: key =
> 0000000000000000 fc = 0xb0
> [   11.800047] [   T1227] mt7921e 0000:04:00.0: mt7921e_tx_prepare_skb: key =
> 0000000000000000 fc = 0x0
> [   13.365330] [   T1227] mt7921e 0000:04:00.0: mt7921e_tx_prepare_skb: key =
> 0000000000000000 fc = 0xb0
> [   13.370257] [   T1227] mt7921e 0000:04:00.0: mt7921e_tx_prepare_skb: key =
> 0000000000000000 fc = 0x0
> [   16.468481] [   T1227] mt7921e 0000:04:00.0: mt7921e_tx_prepare_skb: key =
> 0000000000000000 fc = 0xb0
> [   16.472407] [   T1227] mt7921e 0000:04:00.0: mt7921e_tx_prepare_skb: key =
> 0000000000000000 fc = 0x0
> [   16.542017] [   T1227] mt7921e 0000:04:00.0: mt7921e_tx_prepare_skb: key =
> 0000000000000000 fc = 0x188
> [   16.549581] [   T1227] mt7921e 0000:04:00.0: mt7921e_tx_prepare_skb: key =
> 0000000000000000 fc = 0x188
> [   16.597120] [   T1227] mt7921e 0000:04:00.0: mt7921e_tx_prepare_skb: key =
> 0000000000000000 fc = 0xffff
> [   16.612263] [   T1227] mt7921e 0000:04:00.0: mt7921e_tx_prepare_skb: key =
> 0000000000000000 fc = 0xd0
> 
> Here we actually go a key:
> [   16.614478] [   T1227] mt7921e 0000:04:00.0: mt7921e_tx_prepare_skb: key =
> ffff89c275297230 fc = 0x4188
> 
> [   16.654273] [   T1227] mt7921e 0000:04:00.0: mt7921e_tx_prepare_skb: key =
> 0000000000000000 fc = 0x3333
> [   16.698286] [   T1227] mt7921e 0000:04:00.0: mt7921e_tx_prepare_skb: key =
> 0000000000000000 fc = 0x3333
> [   17.735855] [   T1227] mt7921e 0000:04:00.0: mt7921e_tx_prepare_skb: key =
> 0000000000000000 fc = 0x3333
> [   17.837355] [   T1227] mt7921e 0000:04:00.0: mt7921e_tx_prepare_skb: key =

[....]

I have ordered a mt7921 card so I could reproduce this and finally took
time to debug that. The issue comes to the fact that mt7921 uses 802.11
encapsulation offloading and as such we are calling
ieee80211_tx_h_select_key() on a 802.3 frame.

This function casts the skb data as a 802.11 header regardless the skb
is 802.11 or not in order to decide if the info->control.hw_key needs to
be set. So the hw_key is likely to remain NULL in ieee80211_tx_dequeue()
and because mt7921 driver needs this key to be valid data frames are
dropped.

Will send a patch so that ieee80211_tx_h_select_key() does not try to
get info from a ieee80211_hdr mapped on 802.3 packet data (i.e. when
IEEE80211_TX_CTL_HW_80211_ENCAP is set).

Thanks

-- 
Remi

