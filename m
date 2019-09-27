Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE768C0165
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Sep 2019 10:46:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725946AbfI0Iqf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 27 Sep 2019 04:46:35 -0400
Received: from nbd.name ([46.4.11.11]:43956 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725882AbfI0Iqf (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 27 Sep 2019 04:46:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:Reply-To:Cc:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=+zfpdam6NRBwmt0c2h2XcTFyz5jjd8uajCUOVj7o/Mo=; b=rkirmYLz9s/ftzcyZ79LRd172A
        9+A1yJ0KcAtQtbh9ilULLmViF/I2r75onEkVIRGmYnDF+cT6Vtt2bCSC+to1vXgUMyqcZwKKjfrYu
        +V1zq10BYCBdSRWzrcCaVpdANYl16eI9oy9vXKsSuRDAxmCqlDrwO3Vq2nNgIs7A0MK4=;
Received: from p54ae9b80.dip0.t-ipconnect.de ([84.174.155.128] helo=nf.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1iDltZ-00072d-MX; Fri, 27 Sep 2019 10:46:33 +0200
Subject: Re: [PATCH 05/15] mt76: track rx airtime for airtime fairness and
 survey
To:     =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@redhat.com>,
        linux-wireless@vger.kernel.org
References: <20190926174732.42375-1-nbd@nbd.name>
 <20190926174732.42375-5-nbd@nbd.name> <87v9teyw40.fsf@toke.dk>
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
Message-ID: <6af9b976-48e8-64c2-dffe-b3eaa03b9c73@nbd.name>
Date:   Fri, 27 Sep 2019 10:46:33 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <87v9teyw40.fsf@toke.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2019-09-27 10:35, Toke Høiland-Jørgensen wrote:
> Felix Fietkau <nbd@nbd.name> writes:
>> +	switch (status->encoding) {
>> +	case RX_ENC_LEGACY:
>> +		if (WARN_ON_ONCE(status->band > NL80211_BAND_5GHZ))
>> +			return 0;
>> +
>> +		sband = dev->hw->wiphy->bands[status->band];
>> +		if (!sband || status->rate_idx > sband->n_bitrates)
>> +			return 0;
>> +
>> +		rate = &sband->bitrates[status->rate_idx];
>> +
>> +		return mt76_calc_legacy_rate_duration(rate, sp, len);
>> +	case RX_ENC_VHT:
>> +		streams = status->nss;
>> +		idx = status->rate_idx;
>> +		group = VHT_GROUP_IDX(streams, sgi, bw);
>> +		break;
>> +	case RX_ENC_HT:
>> +		streams = ((status->rate_idx >> 3) & 3) + 1;
>> +		idx = status->rate_idx & 7;
>> +		group = HT_GROUP_IDX(streams, sgi, bw);
>> +		break;
>> +	default:
>> +		WARN_ON_ONCE(1);
>> +		return 0;
>> +	}
>> +
>> +	if (WARN_ON_ONCE(streams > 4))
>> +		return 0;
>> +
>> +	duration = airtime_mcs_groups[group].duration[idx];
>> +	duration <<= airtime_mcs_groups[group].shift;
>> +	duration *= len;
>> +	duration /= AVG_PKT_SIZE;
>> +	duration /= 1024;
> 
> On an earlier patch of mine you expressed concern over divisions in the
> fast path. Does this mean this is no longer a concern? Or is the
> compiler doing fancy things with the constant division here? :)
I made the constants power-of-2, so that the compiler can turn them into
bit shifts. I verified the disassembly: no divisions left in the code.

- Felix
