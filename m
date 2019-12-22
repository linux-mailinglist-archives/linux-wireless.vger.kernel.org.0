Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E905128E75
	for <lists+linux-wireless@lfdr.de>; Sun, 22 Dec 2019 15:13:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725951AbfLVONY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 22 Dec 2019 09:13:24 -0500
Received: from nbd.name ([46.4.11.11]:44258 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725852AbfLVONY (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 22 Dec 2019 09:13:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=m0FgooPBBIw1l4x4W2SABSMsW8gCsRYOEWrhJk0KSk8=; b=trcjrr1L5OUiRNoawN+h04Qicr
        GyfvtVwhZbylyzWYSwPL/rfT2N39PmXENs4hpxRFmblIdqYnOkKWqyp0zowTj3THxKB/3R4NmDjj8
        MEGzqOosu38d0cY9tb6JLFexPwi5O8oOCIkF8qgsKmWJp/w2q11ETb0L6KoKRJZbKj9M=;
Received: from [81.95.5.44] (helo=nf.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1ij1yz-0000ut-DI; Sun, 22 Dec 2019 15:13:21 +0100
Subject: Re: [PATCH 2/2] mt76: mt7615: add set_antenna callback
To:     Ryder Lee <ryder.lee@mediatek.com>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Cc:     Roy Luo <royluo@google.com>, linux-wireless@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Shayne Chen <shayne.chen@mediatek.com>
References: <d3d47e29e2a39c42adfcf912a27b9d19a01d5010.1576381077.git.ryder.lee@mediatek.com>
 <6b3ac6736c0cfa12492f383ec9cfcaad91bfb965.1576381077.git.ryder.lee@mediatek.com>
From:   Felix Fietkau <nbd@nbd.name>
Autocrypt: addr=nbd@nbd.name; prefer-encrypt=mutual; keydata=
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
 GBECAAkFAkah5FQCGwwACgkQ130UHQKnbvW2GgCfTKx80VvCR/PvsUlrvdOLsIgeRGAAn1ee
 RjMaxwtSdaCKMw3j33ZbsWS4
Message-ID: <a29cf0f3-6f7d-9fe5-8d5f-70712963366d@nbd.name>
Date:   Sun, 22 Dec 2019 15:13:20 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <6b3ac6736c0cfa12492f383ec9cfcaad91bfb965.1576381077.git.ryder.lee@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2019-12-15 04:56, Ryder Lee wrote:
> Add a set_antenna callback to setup per phy tx/rx streams.
> 
> Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
> ---
>  .../net/wireless/mediatek/mt76/mt7615/main.c  | 30 +++++++++++++++++++
>  1 file changed, 30 insertions(+)
> 
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/main.c b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
> index 759a66997c6f..70791544a088 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7615/main.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
> @@ -48,6 +48,8 @@ static int mt7615_start(struct ieee80211_hw *hw)
>  		mt7615_mcu_set_mac_enable(dev, 1, true);
>  	}
>  
> +	mt7615_mcu_set_chan_info(phy, MCU_EXT_CMD_SET_RX_PATH);
> +
>  	set_bit(MT76_STATE_RUNNING, &phy->mt76->state);
>  
>  	if (running)
This chunk needs to be moved to the first patch to avoid creating a
regression.

> @@ -635,6 +637,33 @@ mt7615_set_coverage_class(struct ieee80211_hw *hw, s16 coverage_class)
>  	mt7615_mac_set_timing(phy);
>  }
>  
> +static int
> +mt7615_set_antenna(struct ieee80211_hw *hw, u32 tx_ant, u32 rx_ant)
> +{
> +	struct mt7615_dev *dev = mt7615_hw_dev(hw);
> +	struct mt7615_phy *phy = mt7615_hw_phy(hw);
> +	int max_nss = hweight8(hw->wiphy->available_antennas_tx);
> +	bool ext_phy = phy != &dev->phy;
> +
> +	if (!tx_ant || tx_ant != rx_ant || ffs(tx_ant) > max_nss)
> +		return -EINVAL;
> +
> +	if ((BIT(hweight8(tx_ant)) - 1) != tx_ant)
> +		tx_ant = BIT(ffs(tx_ant) - 1) - 1;
> +
> +	mutex_lock(&dev->mt76.mutex);
> +
> +	phy->mt76->antenna_mask = tx_ant;
> +	phy->chainmask = ext_phy ? tx_ant << 2 : tx_ant;
> +
> +	mt76_set_stream_caps(&dev->mt76, true);
> +	mt7615_mcu_set_chan_info(phy, MCU_EXT_CMD_SET_RX_PATH);
This call is unnecessary, because antenna settings can only be changed
when the device is not running.

- Felix
