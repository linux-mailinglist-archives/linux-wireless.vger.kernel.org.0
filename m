Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B3AA61092A7
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Nov 2019 18:13:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728978AbfKYRNA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 25 Nov 2019 12:13:00 -0500
Received: from nbd.name ([46.4.11.11]:37330 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728915AbfKYRNA (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 25 Nov 2019 12:13:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=R1Cu7MszFxGPbf378s5ehXbWfRoChTQHtqJstWeREFE=; b=DPDY79cTbuvuv6Usc+hyuI5Ogm
        oCIQFddGwtLgO8wN8nTIYJzTjtJ5GIw7wblQyqkmrD3xpAaXCC4xiZyHZ5eXz1Vjd/6eB1vpmAPG4
        MMd6XsTy9r/h16WYvQWTFKo0T6bKjb9qyvvYz+ORKV6ba/wbYpKthmvlYRXNY5gVguE0=;
Received: from p5b2067e3.dip0.t-ipconnect.de ([91.32.103.227] helo=nf.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1iZHv0-0004Qw-54; Mon, 25 Nov 2019 18:12:58 +0100
Subject: Re: [PATCH v8 2/6] mt76: mt76x02: split beaconing
To:     Stanislaw Gruszka <sgruszka@redhat.com>,
        Markus Theil <markus.theil@tu-ilmenau.de>
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com
References: <20191121180001.22451-1-markus.theil@tu-ilmenau.de>
 <20191121180001.22451-3-markus.theil@tu-ilmenau.de>
 <20191125130014.GB28102@redhat.com>
 <ec1b9623-2aa1-27c7-abcd-2b39e0d25a0c@tu-ilmenau.de>
 <20191125165932.GB14273@redhat.com>
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
Message-ID: <40c52ae5-85d8-8a65-2b4b-1a52bf1b73ab@nbd.name>
Date:   Mon, 25 Nov 2019 18:12:56 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191125165932.GB14273@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2019-11-25 17:59, Stanislaw Gruszka wrote:
> On Mon, Nov 25, 2019 at 03:07:59PM +0100, Markus Theil wrote:
>> On 11/25/19 2:00 PM, Stanislaw Gruszka wrote:
>> > On Thu, Nov 21, 2019 at 06:59:57PM +0100, Markus Theil wrote:
>> >> +void mt76x02_mac_set_beacon_finish(struct mt76x02_dev *dev)
>> >> +{
>> >> +	mt76_wr(dev, MT_BCN_BYPASS_MASK,
>> >> +		0xff00 | ~bitrev8(dev->beacon_data_mask));
>> > Since you arrange beacon slots continues starting from 0
>> > (i.e. 0,1,2 instead of "random" vif_idx values like 0,4,6),
>> > I think it would make sense to keep
>> > MT_MAC_BSSID_DW1_MBEACON_N = bcn_idx - 1 and set mask unchanged.
>> >
>> > But no strong opinion here, code with bitrev8 looks fine too.
>> I'd like to keep the bitrev8 code, as it saves a copy over usb for usb
>> devices, if MT_MAC_BSSID_DW_BEACON_N is kept constant.
>> bitrev8 should be a rather cheap operation compared to a copy over some
>> form of bus.
> 
> This make sense. I tested the code on MT7630E and after adding missed
> write_txwi function, it works fine. So I think bitrev8 code is ok.
I find the use of bitrev8/ffz a bit convoluted. If I understand the code
right, wouldn't it be equivalent to keeping beacon_data_count instead of
beacon_data_mask and doing:
mt76_wr(dev, MT_BCN_BYPASS_MASK,
	0xffff & ~((1 << dev->beacon_data_count) - 1));
If so, I would strongly prefer the beacon_data_count variant. It's also
cheaper to calculate, though that probably doesn't matter, since it's
not really a hot path.

- Felix
