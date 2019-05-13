Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 42F1A1B2DE
	for <lists+linux-wireless@lfdr.de>; Mon, 13 May 2019 11:30:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728406AbfEMJag (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 May 2019 05:30:36 -0400
Received: from nbd.name ([46.4.11.11]:56882 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726218AbfEMJae (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 May 2019 05:30:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Tt/BANLlImzkjsM3UzyLhwyPn0bAVuqJVjAzJQuIRbc=; b=ZVm36oYPkU7M5FkSIm7QUVrl60
        Cbp6AgVi92hM8hvIAdjxgdYnToQuas4VWEcm/QWXuIrkZJbnM22p/8yGVY4Dk3HdLEcH70Cj3OlFS
        XUrmmIxl/Mm3MuZfsznyuSds77e/w0p8IcaCV2vVht32k/yFjLRaYpYgeZI1kw8vUNok=;
Received: from p54ae9c89.dip0.t-ipconnect.de ([84.174.156.137] helo=nf.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1hQ7I1-0002q2-66; Mon, 13 May 2019 11:30:33 +0200
Subject: Re: [PATCH 3/4] mt76: mt76x2: move mutex_lock inside
 mt76x2_set_channel
To:     Lorenzo Bianconi <lorenzo@kernel.org>,
        Stanislaw Gruszka <sgruszka@redhat.com>
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org
References: <cover.1557567465.git.lorenzo@kernel.org>
 <1527e88fc4a307aa218f515811f2f2c15786caec.1557567465.git.lorenzo@kernel.org>
 <20190513083755.GA13726@redhat.com>
 <20190513091905.GB3127@localhost.localdomain>
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
Message-ID: <26124e15-b410-42d4-631e-4a814176dac0@nbd.name>
Date:   Mon, 13 May 2019 11:30:32 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190513091905.GB3127@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2019-05-13 11:19, Lorenzo Bianconi wrote:
>> On Sat, May 11, 2019 at 12:17:53PM +0200, Lorenzo Bianconi wrote:
>> > This is a preliminary patch to run mt76x02_edcca_init atomically
>> > 
>> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
>> > ---
>> >  .../wireless/mediatek/mt76/mt76x2/pci_main.c  | 16 ++++++++------
>> >  .../wireless/mediatek/mt76/mt76x2/usb_main.c  | 22 ++++++++++---------
>> >  2 files changed, 21 insertions(+), 17 deletions(-)
>> > 
>> > diff --git a/drivers/net/wireless/mediatek/mt76/mt76x2/pci_main.c b/drivers/net/wireless/mediatek/mt76/mt76x2/pci_main.c
>> > index e416eee6a306..3a1467326f4d 100644
>> > --- a/drivers/net/wireless/mediatek/mt76/mt76x2/pci_main.c
>> > +++ b/drivers/net/wireless/mediatek/mt76/mt76x2/pci_main.c
>> > @@ -54,14 +54,14 @@ mt76x2_set_channel(struct mt76x02_dev *dev, struct cfg80211_chan_def *chandef)
>> >  	int ret;
>> >  
>> >  	cancel_delayed_work_sync(&dev->cal_work);
>> 
>> Since now you use mutex in mt76x2_phy_calibrate() you can remove  
>> cancel_delayed_work_sync() and drop other changes from this patch
>> as releasing mutex just to acquire it in almost next step make
>> no sense.
> 
> I agree with you, the only difference is in that way we will perform phy
> calibration even during scanning. If the there are no
> objections I will post a v3 removing cancel_delayed_work_sync and
> reworking patch 3/4
I don't agree for two reasons:

1. If we only rely on the mutex, we're blocking the workqueue. That
might have some unwanted side effects.
2. We really should avoid having the calibration work during scanning,
otherwise this creates extra latency on channel changes, making the
whole scan slower.

- Felix
