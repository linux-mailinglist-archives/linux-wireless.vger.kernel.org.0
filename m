Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0EB125472B
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Aug 2020 16:43:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727910AbgH0Om4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 27 Aug 2020 10:42:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728043AbgH0OmD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 27 Aug 2020 10:42:03 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39005C061264
        for <linux-wireless@vger.kernel.org>; Thu, 27 Aug 2020 07:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:Reply-To:Cc:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=lEahw9Ris2ttfHJNPreP48zbANFbKI0EPx/V19BkF+U=; b=DtiJRk2YAnTtQ7Is6iAayuaUdV
        kEKggOI1tLJR+k6nNkV49HGW9xDFuQ/rY+Tj3iLFFSCXk5aPTjpCAaFiiAJzLexKqeMzKBgKERk3p
        0RCoc/9dhy5dadToCQV9DP9aMSkoVv/1RIHGbPihxNuORNSPd36h9NhLRO7mTP5QhBBw=;
Received: from p5b206497.dip0.t-ipconnect.de ([91.32.100.151] helo=nf.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1kBJ6C-00038j-BO; Thu, 27 Aug 2020 16:41:56 +0200
Subject: Re: [PATCH v3 01/13] mac80211: rework tx encapsulation offload API
To:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org
References: <20200821084926.10650-1-nbd@nbd.name>
 <20200821084926.10650-2-nbd@nbd.name>
 <ba50a77e7503b226cf01a3d71a87bc968e695eac.camel@sipsolutions.net>
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
Message-ID: <cb4bd1d8-272e-c07c-ed1c-8518910df7eb@nbd.name>
Date:   Thu, 27 Aug 2020 16:41:55 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <ba50a77e7503b226cf01a3d71a87bc968e695eac.camel@sipsolutions.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2020-08-27 14:42, Johannes Berg wrote:
> 
> I was going to not worry about it, but now that I'm replying anyway ...
> 
>> +++ b/net/mac80211/iface.c
>> @@ -43,6 +43,7 @@
>>   */
>>  
>>  static void ieee80211_iface_work(struct work_struct *work);
>> +static void ieee80211_set_vif_encap_ops(struct ieee80211_sub_if_data *sdata);
> 
> Do we really need that, can can't reorder things?
I can try, but the reorder might get messy, since I'd have to move up
ieee80211_dataif_ops and ieee80211_dataif_8023_ops, along with some
functions that they reference.
My preference was to not move around so much code, which is why I added
this line.

>> +static bool ieee80211_iftype_supports_encap_offload(enum nl80211_iftype iftype)
>> +{
>> +	switch (iftype) {
>> +	case NL80211_IFTYPE_AP:
>> +	case NL80211_IFTYPE_P2P_GO:
>> +	case NL80211_IFTYPE_P2P_CLIENT:
> 
> The P2P ones cannot happen here due to the iftype munging that mac80211
> does, suggest you add a comment about that and remove them.
Okay, will remove them. Do you want me to send v2 of just this patch, or
the full series?

>> +		list_for_each_entry(key, &sdata->key_list, list) {
>> +			if (key->conf.cipher == WLAN_CIPHER_SUITE_AES_CMAC ||
>> +			    key->conf.cipher == WLAN_CIPHER_SUITE_BIP_GMAC_128 ||
>> +			    key->conf.cipher == WLAN_CIPHER_SUITE_BIP_GMAC_256 ||
>> +			    key->conf.cipher == WLAN_CIPHER_SUITE_BIP_CMAC_256)
>> +				continue;
> 
> I had to read that a few times to understand it ... maybe add a comment
> that the management frame keys aren't relevant? :)
Sure, will add it.

> But anyway, what I was really not sure about is this function:
> 
>> +static void ieee80211_set_vif_encap_ops(struct ieee80211_sub_if_data *sdata)
>> +{
>> +	struct ieee80211_local *local = sdata->local;
>> +	struct ieee80211_sub_if_data *bss = sdata;
>> +	struct ieee80211_key *key;
>> +	bool enabled;
>> +
>> +	if (sdata->vif.type == NL80211_IFTYPE_AP_VLAN) {
>> +		if (!sdata->bss)
>> +			return;
>> +
>> +		bss = container_of(sdata->bss, struct ieee80211_sub_if_data, u.ap);
>> +	}
>> +
>> +	if (!ieee80211_hw_check(&local->hw, SUPPORTS_TX_ENCAP_OFFLOAD) ||
>> +	    !ieee80211_iftype_supports_encap_offload(bss->vif.type))
>> +		return;
> 
> There are a lot of returns here, some of which make sense, but the
> sdata->bss one seems dynamic and doesn't really make sense? Could it
> change?
> 
> Or maybe we don't care because if it's not linked to a BSS it cannot be
> transmitting?
I think sdata->bss can be NULL while the AP_VLAN is down. We can't check
offload state in that case, so we should return here.
ieee80211_set_vif_encap_ops will be called for this AP_VLAN again from
ieee80211_do_open, when it is brought up and sdata->bss will then be set.

- Felix
