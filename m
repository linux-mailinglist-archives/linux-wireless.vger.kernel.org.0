Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66668228810
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Jul 2020 20:18:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728369AbgGUSRy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 21 Jul 2020 14:17:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728153AbgGUSRy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 21 Jul 2020 14:17:54 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D235C061794
        for <linux-wireless@vger.kernel.org>; Tue, 21 Jul 2020 11:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=7ybedw7b+1HrL+2gV+0HQyzMIL57L2oQSZ9AJ4WhJ/8=; b=etA+ocCPk0lRv78CP0xdDOTdNR
        dkYP7zAAChHoP2OAkAVxAeTOv2Fj7d3MUHTRF6sMFW6llRza5eE0RspEP4eiBb9AxFSJWiYBBBkm/
        vYoqQOBEB7NCYPUsw+jF+pZ+7+JtkhQR7G5k3cIF425MVwO08vRvEbOxANpX4aYOOTCE=;
Received: from p54ae9e66.dip0.t-ipconnect.de ([84.174.158.102] helo=nf.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1jxwpr-0003bf-CP; Tue, 21 Jul 2020 20:17:51 +0200
Subject: Re: [PATCH v3 1/4] dt-bindings: net: wireless: mt76: add power-limits
 node
To:     Rob Herring <robh@kernel.org>
Cc:     linux-wireless@vger.kernel.org, devicetree@vger.kernel.org,
        evelyn.tsai@mediatek.com, Shayne Chen <shayne.chen@mediatek.com>
References: <20200715130134.34988-1-nbd@nbd.name>
 <20200721030416.GA3448943@bogus>
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
Message-ID: <1fb272a4-1b7a-d054-4c63-7fef1237e269@nbd.name>
Date:   Tue, 21 Jul 2020 20:17:50 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200721030416.GA3448943@bogus>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2020-07-21 05:04, Rob Herring wrote:
> On Wed, Jul 15, 2020 at 03:01:34PM +0200, Felix Fietkau wrote:
>> This subnode can be used to set per-rate tx power limits either per
>> country code / regdomain or globally.
>> These limits are typically provided by the device manufacturers and are
>> used to limit sideband emissions and stay within regulatory limits
>> 
>> Co-developed-by: Shayne Chen <shayne.chen@mediatek.com>
>> Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
>> Signed-off-by: Felix Fietkau <nbd@nbd.name>
>> ---
>> v3:
>>  - fix S-o-b order
>> v2:
>>  - merge 802.11ax rate changes from Shayne's patch
>>  - document txs-delta property
> 
> This is an extensive enough change that I think it needs to be in schema 
> format.
Okay, I will convert the existing file soon and then add these changes
afterwards.

>>  .../bindings/net/wireless/mediatek,mt76.txt   | 59 +++++++++++++++++++
>>  1 file changed, 59 insertions(+)
>> 
>> diff --git a/Documentation/devicetree/bindings/net/wireless/mediatek,mt76.txt b/Documentation/devicetree/bindings/net/wireless/mediatek,mt76.txt
>> index ab7e7a00e534..e4859c974ef4 100644
>> --- a/Documentation/devicetree/bindings/net/wireless/mediatek,mt76.txt
>> +++ b/Documentation/devicetree/bindings/net/wireless/mediatek,mt76.txt
>> @@ -36,6 +36,7 @@ Optional nodes:
>>  - led: Properties for a connected LED
>>    Optional properties:
>>      - led-sources: See Documentation/devicetree/bindings/leds/common.txt
>> +- power-limits: contains per-regdomain/channel rate power limit subnodes
>>  
>>  &pcie {
>>  	pcie0 {
>> @@ -76,3 +77,61 @@ wmac: wmac@18000000 {
>>  
>>  	power-domains = <&scpsys MT7622_POWER_DOMAIN_WB>;
>>  };
>> +
>> +
>> +Subnodes of power-limits:
>> +
>> +Properties:
>> +- country: One or more country codes, as used by the cfg80211 regdomain code
> 
> What are the values? cfg80211 is a Linux thing and doesn't belong in 
> bindings.
I'll change the description to leave out cfg80211.
It's a simple alpha2 country code.

>> +- regdomain: "FCC", "ETSI" or "JP"
> 
> These aren't implied by the country code?
You use either country code or regdomain.

>> +If neither country, nor regdomain is specified, the power limits node is used
>> +as a fallback when no other subnode matches.
>> +
>> +Subnodes txpower-2g, txpower-5g:
>> +
>> +Properties:
>> +- channels: pairs of first and last channel number
> 
> What's the range in terms of channel numbers and pairs?
802.11 channel numbers (0-255)

>> +- cck: 4 half-dBm per-rate power limit values
>> +- ofdm: 8 half-dBm per-rate power limit values
>> +- mcs:
>> +	sets of per-rate power limit values for 802.11n/802.11ac rates for
>> +	multiple channel bandwidth settings.
>> +	Each set starts with the number of channel bandwidth settings for
>> +	which the rate set applies, followed by either 8 (MT7603/MT7628) or
>> +	10 (all other chips) power limit values.
>> +	The order of the channel bandwidth settings is: 20, 40, 80, 160 MHz.
> 
> The example only has 2 sets, so which channels are they?
The format is <number_of_sets set_data>, so a set starting with <3 ...>
would contain the values for 20, 40 and 80 MHz and you'd add another one
with <1 ...> to describe 160 MHz.
Sets often contain the same data for multiple channel bandwidths, so
this reduces duplication.

>> +- ru:
>> +	sets of per-rate power limit values for 802.11ax rates for multiple
>> +	channel bandwidth or resource unit settings.
>> +	Each set starts with the number of channel bandwidth or resource unit
>> +	settings for which the rate set applies, followed by 12 power limit
>> +	values. The order of the channel resource unit settings is:
>> +	RU26, RU52, RU106, RU242/SU20, RU484/SU40, RU996/SU80, RU2x996/SU160.
> 
> Could be 8-bit? Doesn't really matter much for the example, but what's 
> the worst/typical case?
Yes, 8 bit would also work.

>> +- txs-delta: half-dBm power delta for different numbers of antennas (1, 2, ...)
>> +
>> +
>> +power-limit example:
>> +
>> +power-limits {
>> +	r0 {
> 
> What's 'r0'? Not documented.
> 
>> +		regdomain = "FCC";
>> +		txpower-5g {
>> +			r1 {
> 
> What's 'r1' and 'r2'? Not documented.
You add an arbitrary number of subnodes (I just used r0, r1, ...)
containing rules with the documented properties.

- Felix
