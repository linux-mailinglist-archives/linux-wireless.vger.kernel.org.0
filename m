Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D0821E8ECD
	for <lists+linux-wireless@lfdr.de>; Sat, 30 May 2020 09:05:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728657AbgE3HFW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 30 May 2020 03:05:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726843AbgE3HFV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 30 May 2020 03:05:21 -0400
X-Greylist: delayed 53148 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 30 May 2020 00:05:21 PDT
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A542EC03E969;
        Sat, 30 May 2020 00:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=2OBufPQoFXMLUJ8IsnqyQTwHGOG7uH3gtIDWCufmzmY=; b=qGi68XKZ8oRRIHbIuSWXW7OaIu
        EkrRYKgcP74Yb6/MPxXnnG0c2wjrGd1lLb5Zmf3ru8CPv84MOJIZWTGGNeH9h0m5O4Zp5bbsDjow1
        2lkffpcrTiv4b/NvKp7UqHLYVXFTnBZKg9wTvX7j1a/Nbd0wEFKlHDJnoK9GI9tRX6f8=;
Received: from p4ff13c20.dip0.t-ipconnect.de ([79.241.60.32] helo=nf.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1jevYV-0001kb-UA; Sat, 30 May 2020 09:05:20 +0200
Subject: Re: [PATCH 1/3] dt-bindings: net: wireless: mt76: add power-limits
 node
To:     Rob Herring <robh@kernel.org>
Cc:     linux-wireless@vger.kernel.org, devicetree@vger.kernel.org
References: <20200529161929.24751-1-nbd@nbd.name>
 <20200529212637.GA2994957@bogus>
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
Message-ID: <76ea310a-bca3-dd50-0569-be69b975fefa@nbd.name>
Date:   Sat, 30 May 2020 09:05:07 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200529212637.GA2994957@bogus>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2020-05-29 23:26, Rob Herring wrote:
> On Fri, May 29, 2020 at 06:19:27PM +0200, Felix Fietkau wrote:
>> This subnode can be used to set per-rate tx power limits either per
>> country code / regdomain or globally.
>> These limits are typically provided by the device manufacturers and are
>> used to limit sideband emissions and stay within regulatory limits
> 
> How do other WiFi chips handle this? If this is added to DT, then it 
> should be common for all WiFi h/w.
Most devices store this data in EEPROM, and the way it's handled also
varies across different chips. QCA has EEPROM data that only provides
limits for edge channels (called "conformance test limits")
The only other example I could find of a driver that stores it in DT is
mwifiex, which uses an opaque short array of bytes that is passed to the
firmware directly.
So I don't think it makes sense to put this in the common bindings.
On the other hand, I did try to keep the format as generic and
extensible as possible, so we could always move it over from mt76 to the
common binding once we encounter another driver that needs something
like this.

- Felix
