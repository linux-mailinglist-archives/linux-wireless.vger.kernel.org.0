Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55FE31B2286
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2020 11:19:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726120AbgDUJTz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 21 Apr 2020 05:19:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725920AbgDUJTy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 21 Apr 2020 05:19:54 -0400
X-Greylist: delayed 6995 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 21 Apr 2020 02:19:54 PDT
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F5DBC061A0F
        for <linux-wireless@vger.kernel.org>; Tue, 21 Apr 2020 02:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Agu+e59UTJ1eH7kgr9QshH1Ld07sqWMnOvlVMqaeCE4=; b=IPX7UwZPYR6MenvL6wSpufxVCj
        4C0vbz9sEY52k+cmM3qFD6OPOpZW7PALVQYH/Fw0JerTuzUHeQWNgXJCy0BYEtXVimRPc7wnj1cFt
        BXni30E234FK5ryIoBfRzrS7aZI/n2m1IlUSd6ulFz1ecVQOJUNzF62DnNyrK0AQvVdw=;
Received: from p54ae965b.dip0.t-ipconnect.de ([84.174.150.91] helo=nf.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1jQp4J-0003UW-Io; Tue, 21 Apr 2020 11:19:51 +0200
Subject: Re: [PATCH 3/3] mt76: mt7663: fix up BMC entry indicated to unicmd
 firmware
To:     sean.wang@mediatek.com, lorenzo.bianconi@redhat.com
Cc:     ryder.lee@mediatek.com, linux-wireless@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        Soul Huang <Soul.Huang@mediatek.com>
References: <1467d47fd111b5711fa74410833153bdc9e01b72.1587445885.git.sean.wang@mediatek.com>
 <99b919b29ad60437749d5f30dc8c68ccb3df89f3.1587445885.git.sean.wang@mediatek.com>
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
Message-ID: <5fe74f29-caa7-7e0e-3f31-f9d464397123@nbd.name>
Date:   Tue, 21 Apr 2020 11:19:50 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <99b919b29ad60437749d5f30dc8c68ccb3df89f3.1587445885.git.sean.wang@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2020-04-21 07:20, sean.wang@mediatek.com wrote:
> From: Sean Wang <sean.wang@mediatek.com>
> 
> BMC entry for MT7663 unicmd firmware should be a broadcast/multicast entry,
> not a unicast entry, that is GTK rekey offload would rely on.
> 
> Fixes: 138860679b2a ("mt76: mt7615: add more uni mcu commands")
> Cc: Soul Huang <Soul.Huang@mediatek.com>
> Suggested-by: YF Luo <Yf.Luo@mediatek.com>
> Co-developed-by: Ryder Lee <ryder.lee@mediatek.com>
> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> ---
>  drivers/net/wireless/mediatek/mt76/mt7615/mcu.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
> index 045bde7f554d..e8caa2c7981e 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
> @@ -1339,7 +1339,7 @@ mt7615_mcu_uni_add_bss(struct mt7615_phy *phy,
>  			.short_st = true,
>  		},
>  	};
> -	u8 idx, tx_wlan_idx = 0;
> +	u8 idx, tx_wlan_idx = mvif->sta.wcid.idx;
>  	int err;
>  
>  	idx = mvif->omac_idx > EXT_BSSID_START ? HW_BSSID_0 : mvif->omac_idx;
> @@ -1349,10 +1349,9 @@ mt7615_mcu_uni_add_bss(struct mt7615_phy *phy,
>  	case NL80211_IFTYPE_MESH_POINT:
>  	case NL80211_IFTYPE_AP:
>  		basic_req.basic.conn_type = cpu_to_le32(CONNECTION_INFRA_AP);
> -		tx_wlan_idx = mvif->sta.wcid.idx;
>  		break;
>  	case NL80211_IFTYPE_STATION:
> -		if (enable) {
> +		if (enable && !is_mt7663(&dev->mt76)) {
mt7615_mcu_uni_add_bss is only called on mt7663 with offload firmware,
so you can simply delete the entire if (enable) { ... } code section.

- Felix
