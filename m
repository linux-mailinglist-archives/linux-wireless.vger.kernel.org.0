Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5371D11ED40
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Dec 2019 22:51:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725948AbfLMVvS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 13 Dec 2019 16:51:18 -0500
Received: from nbd.name ([46.4.11.11]:48258 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725747AbfLMVvS (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 13 Dec 2019 16:51:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=pHdx7g8W1iXiLk9PHTD44+WnfLwdqPAhrPV78zvsbTo=; b=Hm934iBIJcHZ2CMjfZ5o+moYIV
        a6tvuz1s6nJQ77d9+4fWZIjBVeFxwau6tfUKdCoBv7fd3U8pWKs+S0W87dm8AlymOar2P0HFYNhI4
        8tmAq1809rtE6Q/vDbvA1Y6UQrdeYSAUySVl7DUzOzaA+wBBQ94uV7Vy9yUZUdd2Xx14=;
Received: from p4ff13e83.dip0.t-ipconnect.de ([79.241.62.131] helo=nf.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1ifsq8-0002dH-DB; Fri, 13 Dec 2019 22:51:12 +0100
Subject: Re: [PATCH] mt76: mt7615: introduce LED support
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        ryder.lee@mediatek.com
References: <378747af00fdd3e64e9f5d7724f1b84759f95e8f.1576074028.git.lorenzo@kernel.org>
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
Message-ID: <20c2faaa-7709-8486-a799-02e6ce5b7ef9@nbd.name>
Date:   Fri, 13 Dec 2019 22:51:11 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <378747af00fdd3e64e9f5d7724f1b84759f95e8f.1576074028.git.lorenzo@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2019-12-11 15:21, Lorenzo Bianconi wrote:
> Initialize brightness_set and blink_set callbacks to
> mt7615_led_set_brightness and mt7615_led_set_blink in order to enable
> LED support in mt7615 driver
> 
> Tested-by: Deng Qingfang <dengqf6@mail2.sysu.edu.cn>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  .../net/wireless/mediatek/mt76/mt7615/init.c  | 58 +++++++++++++++++++
>  .../net/wireless/mediatek/mt76/mt7615/regs.h  | 27 +++++++++
>  2 files changed, 85 insertions(+)
> 
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/init.c b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
> index eb7c6b9e3d4d..c25ba5fc3cdc 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7615/init.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
> @@ -196,6 +196,58 @@ static const struct ieee80211_iface_combination if_comb[] = {
>  	}
>  };
>  
> +static void
> +mt7615_led_set_config(struct led_classdev *led_cdev,
> +		      u8 delay_on, u8 delay_off)
> +{
> +	struct mt7615_dev *dev;
> +	struct mt76_dev *mt76;
> +	u32 val, addr;
> +
> +	mt76 = container_of(led_cdev, struct mt76_dev, led_cdev);
> +	dev = container_of(mt76, struct mt7615_dev, mt76);
> +	val = MT_LED_STATUS_DURATION(0xffff) |
> +	      MT_LED_STATUS_OFF(delay_off) |
> +	      MT_LED_STATUS_ON(delay_on);
> +
> +	addr = mt7615_reg_map(dev, MT_LED_STATUS_0(mt76->led_pin));
> +	mt76_wr(dev, addr, val);
> +	addr = mt7615_reg_map(dev, MT_LED_STATUS_1(mt76->led_pin));
> +	mt76_wr(dev, addr, val);
> +
> +	val = MT_LED_CTRL_REPLAY(mt76->led_pin) |
> +	      MT_LED_CTRL_KICK(mt76->led_pin);
> +	if (mt76->led_al)
> +		val |= MT_LED_CTRL_POLARITY(mt76->led_pin);
> +	addr = mt7615_reg_map(dev, MT_LED_CTRL);
> +	mt76_wr(dev, addr, val);
> +}
> +
> [...]
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/regs.h b/drivers/net/wireless/mediatek/mt76/mt7615/regs.h
> index 26d121646787..3234ae0761b8 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7615/regs.h
> +++ b/drivers/net/wireless/mediatek/mt76/mt7615/regs.h
> @@ -345,6 +345,33 @@
>  
>  #define MT_TX_AGG_CNT(n)		MT_WF_MIB(0xa8 + ((n) << 2))
>  
> +#define MT_LED_BASE_PHYS		0x80024000
> +#define MT_LED_PHYS(_n)			(MT_LED_BASE_PHYS + (_n))
> +
> +#define MT_LED_CTRL			MT_LED_PHYS(0x00)
> +
> +#define MT_LED_CTRL_REPLAY(_n)		BIT(0 + (8 * (_n)))
> +#define MT_LED_CTRL_POLARITY(_n)	BIT(1 + (8 * (_n)))
> +#define MT_LED_CTRL_TX_BLINK_MODE(_n)	BIT(2 + (8 * (_n)))
> +#define MT_LED_CTRL_TX_MANUAL_BLINK(_n)	BIT(3 + (8 * (_n)))
> +#define MT_LED_CTRL_TX_OVER_BLINK(_n)	BIT(5 + (8 * (_n)))
> +#define MT_LED_CTRL_KICK(_n)		BIT(7 + (8 * (_n)))
> +
> +#define MT_LED_STATUS_0(_n)		MT_LED_PHYS(0x10 + ((_n) * 8))
> +#define MT_LED_STATUS_1(_n)		MT_LED_PHYS(0x14 + ((_n) * 8))
> +#define MT_LED_STATUS_OFF_MASK		GENMASK(31, 24)
> +#define MT_LED_STATUS_OFF(_v)		(((_v) << \
> +					  __ffs(MT_LED_STATUS_OFF_MASK)) & \
> +					 MT_LED_STATUS_OFF_MASK)
> +#define MT_LED_STATUS_ON_MASK		GENMASK(23, 16)
> +#define MT_LED_STATUS_ON(_v)		(((_v) << \
> +					  __ffs(MT_LED_STATUS_ON_MASK)) & \
> +					 MT_LED_STATUS_ON_MASK)
> +#define MT_LED_STATUS_DURATION_MASK	GENMASK(15, 0)
> +#define MT_LED_STATUS_DURATION(_v)	(((_v) << \
> +					  __ffs(MT_LED_STATUS_DURATION_MASK)) &\
> +					 MT_LED_STATUS_DURATION_MASK

Why are you using separate _MASK fields and macros using __ffs in
bitshift instead of FIELD_PREP like the rest of the code?

- Felix
