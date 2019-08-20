Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 18A5B95C50
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Aug 2019 12:32:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729686AbfHTKcD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 20 Aug 2019 06:32:03 -0400
Received: from nbd.name ([46.4.11.11]:37280 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729589AbfHTKcD (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 20 Aug 2019 06:32:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=G12kepHNo4d/aWlX/r6KKesBBnEBpcHlYG9XPxPrp/c=; b=h6p7VoBQI0mLtHlnnOo+zHrdl0
        YOGsuB6x1hWAyxaOGPh9rI2Tq6QkJkq/LvF4B1jCEnB6CsdVPF4bqxbadRr/AZrvLt7G5LHfhJwQc
        e/d6VqDpkA6ZVHm7IoUC4NIX9jB1q6HR2UZFErsfnNiLY9nP+EnStCDps/642QjiwHz0=;
Received: from p54ae9443.dip0.t-ipconnect.de ([84.174.148.67] helo=nf.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1i01Qj-0006Hs-36; Tue, 20 Aug 2019 12:31:57 +0200
Subject: Re: [PATCH 5.3] mt76: mt76x0e: don't use hw encryption for MT7630E
To:     Stanislaw Gruszka <sgruszka@redhat.com>
Cc:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>, Roy Luo <royluo@google.com>
References: <1565703400-10623-1-git-send-email-sgruszka@redhat.com>
 <CAJ0CqmXM4NRMYU6Lt_a4f+DXE2bVmhYrjQbgxHG0g=N+o3TeQw@mail.gmail.com>
 <20190815100936.GA21775@redhat.com>
 <727fd528-16c1-e3b3-e1a9-2edbcbdddee7@nbd.name>
 <20190819110639.GA6037@redhat.com>
From:   Felix Fietkau <nbd@nbd.name>
Openpgp: preference=signencrypt
Autocrypt: addr=nbd@nbd.name; prefer-encrypt=mutual; keydata=
 mQGiBEah5CcRBADIY7pu4LIv3jBlyQ/2u87iIZGe6f0f8pyB4UjzfJNXhJb8JylYYRzIOSxh
 ExKsdLCnJqsG1PY1mqTtoG8sONpwsHr2oJ4itjcGHfn5NJSUGTbtbbxLro13tHkGFCoCr4Z5
 Pv+XRgiANSpYlIigiMbOkide6wbggQK32tC20QxUIwCg4k6dtV/4kwEeiOUfErq00TVqIiEE
 AKcUi4taOuh/PQWx/Ujjl/P1LfJXqLKRPa8PwD4j2yjoc9l+7LptSxJThL9KSu6gtXQjcoR2
 vCK0OeYJhgO4kYMI78h1TSaxmtImEAnjFPYJYVsxrhay92jisYc7z5R/76AaELfF6RCjjGeP
 wdalulG+erWju710Bif7E1yjYVWeA/9Wd1lsOmx6uwwYgNqoFtcAunDaMKi9xVQW18FsUusM
 TdRvTZLBpoUAy+MajAL+R73TwLq3LnKpIcCwftyQXK5pEDKq57OhxJVv1Q8XkA9Dn1SBOjNB
 l25vJDFAT9ntp9THeDD2fv15yk4EKpWhu4H00/YX8KkhFsrtUs69+vZQwbQcRmVsaXggRmll
 dGthdSA8bmJkQG5iZC5uYW1lPohgBBMRAgAgBQJGoeQnAhsjBgsJCAcDAgQVAggDBBYCAwEC
 HgECF4AACgkQ130UHQKnbvXsvgCgjsAIIOsY7xZ8VcSm7NABpi91yTMAniMMmH7FRenEAYMa
 VrwYTIThkTlQuQINBEah5FQQCACMIep/hTzgPZ9HbCTKm9xN4bZX0JjrqjFem1Nxf3MBM5vN
 CYGBn8F4sGIzPmLhl4xFeq3k5irVg/YvxSDbQN6NJv8o+tP6zsMeWX2JjtV0P4aDIN1pK2/w
 VxcicArw0VYdv2ZCarccFBgH2a6GjswqlCqVM3gNIMI8ikzenKcso8YErGGiKYeMEZLwHaxE
 Y7mTPuOTrWL8uWWRL5mVjhZEVvDez6em/OYvzBwbkhImrryF29e3Po2cfY2n7EKjjr3/141K
 DHBBdgXlPNfDwROnA5ugjjEBjwkwBQqPpDA7AYPvpHh5vLbZnVGu5CwG7NAsrb2isRmjYoqk
 wu++3117AAMFB/9S0Sj7qFFQcD4laADVsabTpNNpaV4wAgVTRHKV/kC9luItzwDnUcsZUPdQ
 f3MueRJ3jIHU0UmRBG3uQftqbZJj3ikhnfvyLmkCNe+/hXhPu9sGvXyi2D4vszICvc1KL4RD
 aLSrOsROx22eZ26KqcW4ny7+va2FnvjsZgI8h4sDmaLzKczVRIiLITiMpLFEU/VoSv0m1F4B
 FtRgoiyjFzigWG0MsTdAN6FJzGh4mWWGIlE7o5JraNhnTd+yTUIPtw3ym6l8P+gbvfoZida0
 TspgwBWLnXQvP5EDvlZnNaKa/3oBes6z0QdaSOwZCRA3QSLHBwtgUsrT6RxRSweLrcabiEkE
 GBECAAkFAkah5FQCGwwACgkQ130UHQKnbvW2GgCfTKx80VvCR/PvsUlrvdOLsIgeRGAAn1ee
 RjMaxwtSdaCKMw3j33ZbsWS4
Message-ID: <7b46ab63-d69d-f389-b3c2-245cbe11c7b7@nbd.name>
Date:   Tue, 20 Aug 2019 12:31:56 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190819110639.GA6037@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2019-08-19 13:06, Stanislaw Gruszka wrote:
> On Thu, Aug 15, 2019 at 12:20:54PM +0200, Felix Fietkau wrote:
>> On 2019-08-15 12:09, Stanislaw Gruszka wrote:
>> >> Hi Stanislaw,
>> >> 
>> >> Can you please try if disabling/enabling the tx tasklet during hw key
>> >> configuration fixes the issue?
>> >> Doing something like:
>> >> 
>> >> tasklet_disable(tx_tasklet)
>> >> mt76x02_set_key()
>> >> tasklet_enable(tx_tasklet)
>> > 
>> > It does not help with the problem.
>> > 
>> >> Moreover, have you double checked if there is any performance impact
>> >> of not using hw encryption?
>> > 
>> > I didn't observe any, but realized on this machine I have
>> > aesni_intel encryption accelerator. After rebuild kernel without
>> > CONFIG_CRYPTO_AES_NI_INTEL, 'perf top' showed extra 20% of cpu usage
>> > in aes_encrypt() when sending data with HW encryption disabled.
>> > 
>> >> If so, I guess it is better to just redefine mt76_wake_tx_queue for
>> >> mt76x0e and run mt76_txq_schedule for 7630e:
>> >> 
>> >> void mt76x0e_wake_tx_queue(struct ieee80211_hw *hw, struct ieee80211_txq *txq)
>> >> {
>> >>         if (is_mt7630(dev)) {
>> >>             mt76_txq_schedule(dev, txq->ac);
>> >>         } else {
>> >>             tasklet_schedule(&dev->tx_tasklet);
>> >>         }
>> >> }
>> > 
>> > Not sure about reduction of lock contention for which the tx_tasklet
>> > was introduced here, but looks ok for me as fix.
>> I think if we work around the bug like this, it can easily come back to
>> bite us again later. 
> 
> I'm not into workarounds any kind, but this is really strange issue,
> maybe FW bug that triggers just by slightly different driver behaviour.
> 
>> I don't see any logical explanation as to how this
>> makes a difference with hardware encryption.
>> Also, I think it would be helpful to figure out what key operation (if
>> any) triggers this, adding or removing keys.
> 
> Seems not to be related with set_key operation at all. We set 2 HW
> keys at the beginning and hang happen after some tx/rx traffic
> without any re-keyring.
> 
> I'm not sure why disabling HW encryption helps. Maybe it is due to
> ordering or timing. With SW encryption we spend more time in mac80211
> before pass skb's to the driver. Or maybe we just mix some HW keys 
> and SW (group) keys in way that FW does not like.
> 
>> Maybe it could also help if we change the order in which the WCID table
>> entries are updated, i.e. changing MT_WCID_ATTR first when removing keys.
>> 
>> Maybe temporarily clearing MT_MAC_SYS_CTRL_ENABLE_TX before the key
>> update and setting it again afterwards could also help.
> 
> I tested below patch and it did not help.
Can you test if disabling hw encryption only for shared or only for
pairwise keys makes any difference?

- Felix
