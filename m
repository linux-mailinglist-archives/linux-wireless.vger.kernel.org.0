Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DFCC1BBC3F
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2020 13:17:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbgD1LRH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 28 Apr 2020 07:17:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726740AbgD1LRG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 28 Apr 2020 07:17:06 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7944BC03C1A9
        for <linux-wireless@vger.kernel.org>; Tue, 28 Apr 2020 04:17:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=XOhDfptpwh2eyxeLvzb+d+hOxPoOaH2iB/kxQVxTMjU=; b=h+vklNke7tDARomiV32fLLXcqE
        c0ikX46g+ToZh/daC5uxCo39tXdxw1Fl330bhsYG3eIpPh0xDE0V8OGsqd0LSrDYIGaognX3uJ+VN
        DZhCEt0KL7nZTigZr0lqIRObH10ZuGkluowmTkMkc6NYF8dlsOckmVfJ4PbukrMZSrDA=;
Received: from [80.255.7.108] (helo=nf.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1jTOET-0000qa-RX; Tue, 28 Apr 2020 13:16:57 +0200
Subject: Re: [PATCH] mt76: mt7663: add the possibility to load firmware v2
To:     Kalle Valo <kvalo@codeaurora.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com, linux-mediatek@lists.infradead.org
References: <db72b648024aba3243ee3b7deceb548c9bc2bdf1.1587911939.git.lorenzo@kernel.org>
 <87ftcnj2be.fsf@tynnyri.adurom.net>
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
Message-ID: <fd49291e-173e-20b0-ee67-c4f519ce8419@nbd.name>
Date:   Tue, 28 Apr 2020 13:16:56 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <87ftcnj2be.fsf@tynnyri.adurom.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2020-04-28 13:07, Kalle Valo wrote:
> Lorenzo Bianconi <lorenzo@kernel.org> writes:
> 
>> mt7663 firmware v2 is used for embedded devices since it has more completed
>> features in AP mode.
>> Add the capability to specify in mt7615 Kconfig which firmware load first
>> (v3 or v2) and fallback to the other one if the selected firmware fails
>> to load
>>
>> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
>> ---
>>  .../net/wireless/mediatek/mt76/mt7615/Kconfig | 13 +++++
>>  .../net/wireless/mediatek/mt76/mt7615/mcu.c   | 50 ++++++++++++++++---
>>  .../wireless/mediatek/mt76/mt7615/mt7615.h    |  6 ++-
>>  .../net/wireless/mediatek/mt76/mt7615/pci.c   |  2 +
>>  .../net/wireless/mediatek/mt76/mt7615/usb.c   |  2 +
>>  5 files changed, 65 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/Kconfig b/drivers/net/wireless/mediatek/mt76/mt7615/Kconfig
>> index e25db1135eda..c04d6a182bf0 100644
>> --- a/drivers/net/wireless/mediatek/mt76/mt7615/Kconfig
>> +++ b/drivers/net/wireless/mediatek/mt76/mt7615/Kconfig
>> @@ -38,3 +38,16 @@ config MT7663U
>>  	  This adds support for MT7663U 802.11ax 2x2:2 wireless devices.
>>  
>>  	  To compile this driver as a module, choose M here.
>> +
>> +config MT7615_OFFLOAD_FIRMWARE
>> +	bool "Prefer client mode offload firmware (MT7663)"
>> +	depends on MT7615E || MT7663U
>> +	default y
>> +	help
>> +	  Load MT7663 client mode offload firmware (v3) as primary option
>> +	  and fallback to MT7663 firmware v2 in case of failure.
>> +	  If MT7615_OFFLOAD_FIRMWARE is not selected MT7663 firmware v2
>> +	  will be used as primary option.
>> +	  MT7663 client mode offload firmware supports low power features
>> +	  (hw frequency scanning, scheduled frequency scanning, WoW,
>> +	  802.11 power save) but is more limited in AP mode
> 
> Why does this need a compile time config? Wouldn't some kind of runtime
> configuration be better?
I don't think supporting runtime configuration is worth the extra
complexity of adding an API for shutting down and restarting the
firmware and dealing with potential errors along the way.

Both firmware types support AP and client mode. Which one you use
depends on the kind of system you're building for.

If you're building an embedded AP, you don't need any low power offloads
and may want to support more than 32 clients, so you'd disable this
configuration option.

If you run the driver on a laptop or desktop machine, you will most
likely stick to the default.

If you want to switch without recompiling, you can always just delete
the set of firmware files you don't want to use. The driver will fall
back to the other type.

- Felix
