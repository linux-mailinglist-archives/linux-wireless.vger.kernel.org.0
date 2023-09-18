Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 473387A46BB
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Sep 2023 12:15:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238024AbjIRKPP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 18 Sep 2023 06:15:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240942AbjIRKPM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 18 Sep 2023 06:15:12 -0400
Received: from nbd.name (nbd.name [46.4.11.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70EB9A6
        for <linux-wireless@vger.kernel.org>; Mon, 18 Sep 2023 03:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
        s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=FlPiBPfzITX9DL6CLizuq7axBo1alK0pRSm4MYPYv3g=; b=Pn6cVnHJi0SpybljT7FfkA7/09
        w3of3jRwPEDPwFXs9kpiEK9KP41TzKbTTXZLZ5FmzIVKg0Fcb77dvmoQx+mYgAa+ftBo+z1ioOPMX
        PGscbWl6FdgVon7eXMf0lXRCXkS2Vdxlfx3kWMJd1cdu5qUvuOcsAr7ulZc3PxYzVbBI=;
Received: from p54ae986d.dip0.t-ipconnect.de ([84.174.152.109] helo=nf.local)
        by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <nbd@nbd.name>)
        id 1qiBHG-003vhL-Tc; Mon, 18 Sep 2023 12:14:50 +0200
Message-ID: <c00c641b-f5b3-4bca-8d41-4e048b09a794@nbd.name>
Date:   Mon, 18 Sep 2023 12:14:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] wifi: mt76: mt7996: Add mcu commands for getting
 sta tx statistic
Content-Language: en-US
To:     Yi-Chia Hsieh <yi-chia.hsieh@mediatek.com>,
        Johannes Berg <johannes.berg@intel.com>
Cc:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        Money Wang <money.wang@mediatek.com>,
        Peter Chiu <chui-hao.chiu@mediatek.com>,
        Benjamin Lin <benjamin-jw.lin@mediatek.com>,
        linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org
References: <7554d0a64ff480f1a185f381a59799158fe8bf23.1693549298.git.yi-chia.hsieh@mediatek.com>
 <ef87bde6ef590ce39515a683e33313d1434b3064.1693549298.git.yi-chia.hsieh@mediatek.com>
From:   Felix Fietkau <nbd@nbd.name>
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
In-Reply-To: <ef87bde6ef590ce39515a683e33313d1434b3064.1693549298.git.yi-chia.hsieh@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 01.09.23 08:30, Yi-Chia Hsieh wrote:
> Per peer Tx/Rx statistic can only be obtained by querying WM when WED is
> on. This patch switches to periodic event reporting in the case of WED
> being enabled.
> 
> Signed-off-by: Yi-Chia Hsieh <yi-chia.hsieh@mediatek.com>
> ---
> v2: split series
> ---
>   .../wireless/mediatek/mt76/mt76_connac_mcu.h  | 15 ++++
>   .../net/wireless/mediatek/mt76/mt7996/mac.c   |  5 ++
>   .../net/wireless/mediatek/mt76/mt7996/main.c  | 15 ++++
>   .../net/wireless/mediatek/mt76/mt7996/mcu.c   | 68 +++++++++++++++++++
>   .../net/wireless/mediatek/mt76/mt7996/mcu.h   | 26 +++++++
>   .../wireless/mediatek/mt76/mt7996/mt7996.h    |  1 +
>   6 files changed, 130 insertions(+)
> 
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.h
> index 078f82858621..5aece2046a9d 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.h
> +++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.h
> @@ -153,6 +153,32 @@ struct mt7996_mcu_mib {
>   	__le64 data;
>   } __packed;
>   
> +struct mt7996_mcu_all_sta_info_event {
> +	u8 rsv[4];
> +	__le16 tag;
> +	__le16 len;
> +	u8 more;
> +	u8 rsv2;
> +	__le16 sta_num;
> +	u8 rsv3[2];
> +
> +	union {
> +		struct {
> +			__le16 wlan_idx;
> +			u8 rsv[2];
> +			__le32 tx_bytes[IEEE80211_NUM_ACS];
> +			__le32 rx_bytes[IEEE80211_NUM_ACS];
> +		} adm_stat[];
> +
> +		struct {
> +			__le16 wlan_idx;
> +			u8 rsv[2];
> +			__le32 tx_msdu_cnt;
> +			__le32 rx_msdu_cnt;
> +		} msdu_cnt[];
> +	};
> +} __packed;
With this, I'm getting compiler errors like this one:

      mcu.h:171:19: error: flexible array member in union


- Felix
