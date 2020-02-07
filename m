Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A4A8D155CA8
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Feb 2020 18:12:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727005AbgBGRMq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 7 Feb 2020 12:12:46 -0500
Received: from nbd.name ([46.4.11.11]:59074 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726897AbgBGRMq (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 7 Feb 2020 12:12:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=CLXV4F/fqL5YIKr/WBzNVf/TWliO6iGIF7sm9EdI5gM=; b=hqooMWs3IkFcbECWork8Y3W+nK
        fLwCGyEuZEvGpocRhm2XxNspfXpQdrcm3ER/qE7QIcw0X6McF7PcT38IJAkpshZ/kv2yaqUon0+Hq
        Os0JaLiaF5Jtn9jKU/Ov5UYUveynmfYqyTxyJsyYa8wSFXMbVeNo8g4jg2EyMw9MkK04=;
Received: from [80.255.10.202] (helo=nf.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1j07BI-0001Kp-Dd; Fri, 07 Feb 2020 18:12:44 +0100
Subject: Re: [PATCH 2/3] mt76: generalize mt76_mcu_rx_event routine
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org
References: <cover.1580945999.git.lorenzo@kernel.org>
 <0b2e476900157cd99417328e661e71a6ffedcb6a.1580945999.git.lorenzo@kernel.org>
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
Message-ID: <9206f86a-8bd5-1f43-482d-8027e1a60d42@nbd.name>
Date:   Fri, 7 Feb 2020 18:12:39 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <0b2e476900157cd99417328e661e71a6ffedcb6a.1580945999.git.lorenzo@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2020-02-06 00:53, Lorenzo Bianconi wrote:
> Rely on mt76_mcu in mt76_mcu_rx_event signature in order to reuse
> it in usb code
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  drivers/net/wireless/mediatek/mt76/mcu.c          | 8 +++++---
>  drivers/net/wireless/mediatek/mt76/mt76.h         | 2 +-
>  drivers/net/wireless/mediatek/mt76/mt7603/dma.c   | 4 ++--
>  drivers/net/wireless/mediatek/mt76/mt7615/mcu.c   | 2 +-
>  drivers/net/wireless/mediatek/mt76/mt76x02_txrx.c | 3 +--
>  5 files changed, 10 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/net/wireless/mediatek/mt76/mcu.c b/drivers/net/wireless/mediatek/mt76/mcu.c
> index b0fb0830c9e1..a2936f8de915 100644
> --- a/drivers/net/wireless/mediatek/mt76/mcu.c
> +++ b/drivers/net/wireless/mediatek/mt76/mcu.c
> @@ -42,9 +42,11 @@ struct sk_buff *mt76_mcu_get_response(struct mt76_dev *dev,
>  }
>  EXPORT_SYMBOL_GPL(mt76_mcu_get_response);
>  
> -void mt76_mcu_rx_event(struct mt76_dev *dev, struct sk_buff *skb)
> +void mt76_mcu_rx_event(void *data, struct sk_buff *skb)
Why the void* pointer if we have the mcu struct in a common place in
struct mt76_dev anyway?

- Felix
