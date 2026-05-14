Return-Path: <linux-wireless+bounces-36418-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GCo4Jj8JBmpOeQIAu9opvQ
	(envelope-from <linux-wireless+bounces-36418-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 14 May 2026 19:41:19 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4151C545764
	for <lists+linux-wireless@lfdr.de>; Thu, 14 May 2026 19:41:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9615B30087DA
	for <lists+linux-wireless@lfdr.de>; Thu, 14 May 2026 17:41:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D36733C532;
	Thu, 14 May 2026 17:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="QbEF/Q7u"
X-Original-To: linux-wireless@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F6292F90C5
	for <linux-wireless@vger.kernel.org>; Thu, 14 May 2026 17:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778780477; cv=none; b=HkTTQluBXqlsSngIi5w7ZaDe7WjzMGaONRYXJVIJcoltoIvr/r0NRSN0V7LSsem2pcFlCPl8kB355BZcQ13wHiRzow5l4jspYwhg6YtiXCsOJy/mk43tbQ3zpNF9qGkpg1aMMG9Q6ZM8ZFjYEL/QyMJrHgtYpVYRi8BQC2v6Ztk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778780477; c=relaxed/simple;
	bh=A4eQNwEufa/UVJ0SyaYMDTn9AJeEivYhnzt6j296YY0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SBkYQnKBPbhLJDbhLuAfTeNiSEckEuCl4+kT92+UxDqzd9ZgJfYO7uYmFGBz0waxjvjVbrndr0emgGf9GChDGgCoite3m2br75sqHkTgnMBenjKE+sHHO10psDD5Akv4B55nZ08uJnizWLci9nn4jM+PZpIfrKcDsUZEbVLymN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=QbEF/Q7u; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=xvrNQ7oegyf1conhVFaSwBesDOKZPibtSx+sDDbUDd8=; b=QbEF/Q7uTacsKZ2quO0kkiEx/p
	37iOMw8I92V4FlcfEaeKMkwwlIInEIDilnaMhI0GzEfkoF1P7BfrDJSddND7OxwBw5rs08DDjYd/A
	Tuf/ok4MJ0cFg2tX2urOaI1P56H0IaTQWm7YlN7jHvXdi2HBbD3rL6lGrTrKGuXp0FJat7HTy7yoX
	KmjDRkyWhIqQmasPadnfg1n1ekwumMcsR58pj+keN4WDTutlcXQrLIjcY5jwR/E0O8grIs3wQ7Y/6
	fAhejANL0jSm2NpB1cLXxcujv5BS3BIKk48PhYm1OUnI4HgAnzN+6m+R0LeIBPiUlLFInxNM6OeFr
	rPdLASsw==;
Received: from 179-125-79-241-dinamico.pombonet.net.br ([179.125.79.241] helo=quatroqueijos.cascardo.eti.br)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1wNa3c-000Aok-IY; Thu, 14 May 2026 19:41:13 +0200
Date: Thu, 14 May 2026 14:41:09 -0300
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: linux-wireless@vger.kernel.org, kevin_yang@realtek.com
Subject: Re: [RFT rtw/rtw-next] wifi: rtw88: check if center channel is
 supported before setting
Message-ID: <agYJNW7Mxt0dOfTw@quatroqueijos.cascardo.eti.br>
References: <20260413053601.13037-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260413053601.13037-1-pkshih@realtek.com>
X-Rspamd-Queue-Id: 4151C545764
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.36 / 15.00];
	R_DKIM_REJECT(1.00)[igalia.com:s=20170329];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[igalia.com : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-36418-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[igalia.com:-];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cascardo@igalia.com,linux-wireless@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.184];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,realtek.com:email]
X-Rspamd-Action: no action

On Mon, Apr 13, 2026 at 01:36:01PM +0800, Ping-Ke Shih wrote:
> From: Zong-Zhe Yang <kevin_yang@realtek.com>
> 
> Some unusual center channels may be assigned to driver. However, RF
> doesn't really expect them, and then warnings happen due to lack of
> TX power limit configurations. For example, center channel 114/130
> with 80MHz. So, add a check before setting the channel.
> 
> Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

Hi,

I have tested this patch and it does prevent 80MHz from being used.
However, RF seems to accept those center channels with 80MHz just fine. I
can get up to 600Mbps with UDP while I can get past 300Mbps after applying
this patch.

Should we apply something like [1] instead?

https://lore.kernel.org/linux-wireless/20260306-rtw88_channel130-v1-1-ff25a5bc930a@igalia.com

Regards.
Cascardo.

> ---
>  drivers/net/wireless/realtek/rtw88/mac80211.c |  7 +++++--
>  drivers/net/wireless/realtek/rtw88/main.c     | 13 +++++++++++--
>  drivers/net/wireless/realtek/rtw88/main.h     |  2 +-
>  drivers/net/wireless/realtek/rtw88/phy.c      | 18 ++++++++++++++++++
>  drivers/net/wireless/realtek/rtw88/phy.h      |  2 ++
>  5 files changed, 37 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/wireless/realtek/rtw88/mac80211.c b/drivers/net/wireless/realtek/rtw88/mac80211.c
> index 766f22d31079..9d97e8dd0c1e 100644
> --- a/drivers/net/wireless/realtek/rtw88/mac80211.c
> +++ b/drivers/net/wireless/realtek/rtw88/mac80211.c
> @@ -92,8 +92,11 @@ static int rtw_ops_config(struct ieee80211_hw *hw, int radio_idx, u32 changed)
>  		}
>  	}
>  
> -	if (changed & IEEE80211_CONF_CHANGE_CHANNEL)
> -		rtw_set_channel(rtwdev);
> +	if (changed & IEEE80211_CONF_CHANGE_CHANNEL) {
> +		ret = rtw_set_channel(rtwdev);
> +		if (ret)
> +			goto out;
> +	}
>  
>  	if ((changed & IEEE80211_CONF_CHANGE_IDLE) &&
>  	    (hw->conf.flags & IEEE80211_CONF_IDLE) &&
> diff --git a/drivers/net/wireless/realtek/rtw88/main.c b/drivers/net/wireless/realtek/rtw88/main.c
> index cd9254370fcc..08aebb3c5a78 100644
> --- a/drivers/net/wireless/realtek/rtw88/main.c
> +++ b/drivers/net/wireless/realtek/rtw88/main.c
> @@ -868,23 +868,30 @@ void rtw_get_channel_params(struct cfg80211_chan_def *chandef,
>  	chan_params->primary_chan = channel->hw_value;
>  }
>  
> -void rtw_set_channel(struct rtw_dev *rtwdev)
> +int rtw_set_channel(struct rtw_dev *rtwdev)
>  {
>  	const struct rtw_chip_info *chip = rtwdev->chip;
>  	struct ieee80211_hw *hw = rtwdev->hw;
>  	struct rtw_hal *hal = &rtwdev->hal;
>  	struct rtw_channel_params ch_param;
>  	u8 center_chan, primary_chan, bandwidth, band;
> +	int ch_idx;
>  
>  	rtw_get_channel_params(&hw->conf.chandef, &ch_param);
>  	if (WARN(ch_param.center_chan == 0, "Invalid channel\n"))
> -		return;
> +		return -EINVAL;
>  
>  	center_chan = ch_param.center_chan;
>  	primary_chan = ch_param.primary_chan;
>  	bandwidth = ch_param.bandwidth;
>  	band = ch_param.center_chan > 14 ? RTW_BAND_5G : RTW_BAND_2G;
>  
> +	ch_idx = rtw_band_channel_to_idx(band, center_chan);
> +	if (ch_idx < 0) {
> +		rtw_warn(rtwdev, "not support band %d ch %d\n", band, center_chan);
> +		return -EOPNOTSUPP;
> +	}
> +
>  	rtw_update_channel(rtwdev, center_chan, primary_chan, band, bandwidth);
>  
>  	if (rtwdev->scan_info.op_chan)
> @@ -910,6 +917,8 @@ void rtw_set_channel(struct rtw_dev *rtwdev)
>  	 */
>  	if (!test_bit(RTW_FLAG_SCANNING, rtwdev->flags))
>  		rtwdev->need_rfk = true;
> +
> +	return 0;
>  }
>  
>  void rtw_chip_prepare_tx(struct rtw_dev *rtwdev)
> diff --git a/drivers/net/wireless/realtek/rtw88/main.h b/drivers/net/wireless/realtek/rtw88/main.h
> index 9c0b746540b0..a368f1a4a003 100644
> --- a/drivers/net/wireless/realtek/rtw88/main.h
> +++ b/drivers/net/wireless/realtek/rtw88/main.h
> @@ -2241,7 +2241,7 @@ bool ltecoex_reg_write(struct rtw_dev *rtwdev, u16 offset, u32 value);
>  void rtw_restore_reg(struct rtw_dev *rtwdev,
>  		     struct rtw_backup_info *bckp, u32 num);
>  void rtw_desc_to_mcsrate(u16 rate, u8 *mcs, u8 *nss);
> -void rtw_set_channel(struct rtw_dev *rtwdev);
> +int rtw_set_channel(struct rtw_dev *rtwdev);
>  void rtw_chip_prepare_tx(struct rtw_dev *rtwdev);
>  void rtw_vif_port_config(struct rtw_dev *rtwdev, struct rtw_vif *rtwvif,
>  			 u32 config);
> diff --git a/drivers/net/wireless/realtek/rtw88/phy.c b/drivers/net/wireless/realtek/rtw88/phy.c
> index e2ac5c6fd500..a543eaa57f2c 100644
> --- a/drivers/net/wireless/realtek/rtw88/phy.c
> +++ b/drivers/net/wireless/realtek/rtw88/phy.c
> @@ -1630,6 +1630,24 @@ static int rtw_channel_to_idx(u8 band, u8 channel)
>  	return ch_idx;
>  }
>  
> +int rtw_band_channel_to_idx(enum rtw_supported_band band, u8 channel)
> +{
> +	u8 phy_band;
> +
> +	switch (band) {
> +	case RTW_BAND_2G:
> +		phy_band = PHY_BAND_2G;
> +		break;
> +	case RTW_BAND_5G:
> +		phy_band = PHY_BAND_5G;
> +		break;
> +	default:
> +		return -1;
> +	}
> +
> +	return rtw_channel_to_idx(phy_band, channel);
> +}
> +
>  static void rtw_phy_set_tx_power_limit(struct rtw_dev *rtwdev, u8 regd, u8 band,
>  				       u8 bw, u8 rs, u8 ch, s8 pwr_limit)
>  {
> diff --git a/drivers/net/wireless/realtek/rtw88/phy.h b/drivers/net/wireless/realtek/rtw88/phy.h
> index 8449936497bb..98aeb576e24d 100644
> --- a/drivers/net/wireless/realtek/rtw88/phy.h
> +++ b/drivers/net/wireless/realtek/rtw88/phy.h
> @@ -201,4 +201,6 @@ enum rtw_phy_cck_pd_lv {
>  #define RRSR_RATE_ORDER_MAX	0xfffff
>  #define RRSR_RATE_ORDER_CCK_LEN	4
>  
> +int rtw_band_channel_to_idx(enum rtw_supported_band band, u8 channel);
> +
>  #endif
> -- 
> 2.25.1
> 
> 

