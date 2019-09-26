Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3EC61BF366
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Sep 2019 14:53:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726758AbfIZMxs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 26 Sep 2019 08:53:48 -0400
Received: from nbd.name ([46.4.11.11]:37964 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725768AbfIZMxr (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 26 Sep 2019 08:53:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=PgfaL7kAdJ5065sz1aXBV1oyDb5cna3C7xcf4wBeMLw=; b=cSQYQulKUjIwrKLwLdPPtwWbF0
        VRxAESd0QXXzKUfBLUWClujUb+WwL65ELyMU6W2jtuac5CpC7SViICAGz9Jfbh9eh9r9dF7c2t/98
        qkGeaalqWbtBK2NEje7OrV6BbpbhNippqRflkyjQYsRTzVKKE5WQvvghjQykoyoB2stU=;
Received: from p54ae9b80.dip0.t-ipconnect.de ([84.174.155.128] helo=nf.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1iDTHE-0005oY-3G; Thu, 26 Sep 2019 14:53:44 +0200
Subject: Re: [PATCH RFC/RFT 4/4] mac80211: Apply Airtime-based Queue Limit
 (AQL) on packet dequeue
To:     =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@redhat.com>,
        Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org,
        make-wifi-fast@lists.bufferbloat.net,
        John Crispin <john@phrozen.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>
References: <156889576422.191202.5906619710809654631.stgit@alrua-x1>
 <156889576869.191202.510507546538322707.stgit@alrua-x1>
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
Message-ID: <08f0ed6e-b746-9689-6dc8-7c0ea705666d@nbd.name>
Date:   Thu, 26 Sep 2019 14:53:43 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <156889576869.191202.510507546538322707.stgit@alrua-x1>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2019-09-19 14:22, Toke Høiland-Jørgensen wrote:
> From: Toke Høiland-Jørgensen <toke@redhat.com>
> 
> Some devices have deep buffers in firmware and/or hardware which prevents
> the FQ structure in mac80211 from effectively limiting bufferbloat on the
> link. For Ethernet devices we have BQL to limit the lower-level queues, but
> this cannot be applied to mac80211 because transmit rates can vary wildly
> between packets depending on which station we are transmitting it to.
> 
> To overcome this, we can use airtime-based queue limiting (AQL), where we
> estimate the transmission time for each packet before dequeueing it, and
> use that to limit the amount of data in-flight to the hardware. This idea
> was originally implemented as part of the out-of-tree airtime fairness
> patch to ath10k[0] in chromiumos.
> 
> This patch ports that idea over to mac80211. The basic idea is simple
> enough: Whenever we dequeue a packet from the TXQs and send it to the
> driver, we estimate its airtime usage, based on the last recorded TX rate
> of the station that packet is destined for. We keep a running per-AC total
> of airtime queued for the whole device, and when that total climbs above 8
> ms' worth of data (corresponding to two maximum-sized aggregates), we
> simply throttle the queues until it drops down again.
> 
> The estimated airtime for each skb is stored in the tx_info, so we can
> subtract the same amount from the running total when the skb is freed or
> recycled. The throttling mechanism relies on this accounting to be
> accurate (i.e., that we are not freeing skbs without subtracting any
> airtime they were accounted for), so we put the subtraction into
> ieee80211_report_used_skb().
> 
> This patch does *not* include any mechanism to wake a throttled TXQ again,
> on the assumption that this will happen anyway as a side effect of whatever
> freed the skb (most commonly a TX completion).
> 
> The throttling mechanism only kicks in if the queued airtime total goes
> above the limit. Since mac80211 calculates the time based on the reported
> last_tx_time from the driver, the whole throttling mechanism only kicks in
> for drivers that actually report this value. With the exception of
> multicast, where we always calculate an estimated tx time on the assumption
> that multicast is transmitted at the lowest (6 Mbps) rate.
> 
> The throttling added in this patch is in addition to any throttling already
> performed by the airtime fairness mechanism, and in principle the two
> mechanisms are orthogonal (and currently also uses two different sources of
> airtime). In the future, we could amend this, using the airtime estimates
> calculated by this mechanism as a fallback input to the airtime fairness
> scheduler, to enable airtime fairness even on drivers that don't have a
> hardware source of airtime usage for each station.
> 
> [0] https://chromium-review.googlesource.com/c/chromiumos/third_party/kernel/+/588190/13/drivers/net/wireless-4.2/ath/ath10k/mac.c#3845
One thing that might be missing here is dealing with airtime accounting
of frames that remain queued in the driver/hardware because the station
is in powersave mode.

- Felix
