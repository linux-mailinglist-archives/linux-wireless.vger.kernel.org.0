Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BFC0114DDE4
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Jan 2020 16:32:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727234AbgA3PcV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 30 Jan 2020 10:32:21 -0500
Received: from nbd.name ([46.4.11.11]:59948 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727191AbgA3PcV (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 30 Jan 2020 10:32:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:Reply-To:Cc:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=6yj8DEtc28xF7z11uWcAdjFo/OeCwKaoqQigukYOK0Q=; b=LulzDCzOsu4YpwWtkj9kz6mxkG
        +yZ+Cf2td0x92d7O/DpikLg7mFpRSKbsEjSjmFBdriX0vwaFRWwaTgk6BTcezuOp7xjKN/NBd5uIv
        wYKD9BlmWEVi/Gc8WcbmFcRtjN2yCXJTfetbbIGPhhd2BbbCnm/4L9vtpQXxOIFSziEs=;
Received: from [178.162.209.135] (helo=nf.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1ixBnm-0004y9-7P; Thu, 30 Jan 2020 16:32:18 +0100
Subject: Re: Strange performance issue when using two devices at once
To:     Marlon Smith <marlon.smith10@gmail.com>,
        Ben Greear <greearb@candelatech.com>,
        linux-wireless@vger.kernel.org
References: <1580323191.26012.48.camel@gmail.com>
 <2e80a485-892d-3b29-19c7-38a9caa14f4b@candelatech.com>
 <1580325769.26012.54.camel@gmail.com>
 <6bcff97c-3b9b-7fa9-5101-80aca367ff84@candelatech.com>
 <1580327314.26012.59.camel@gmail.com>
 <c8788984-3de0-b41c-e2a1-66b67d0674a6@candelatech.com>
 <1580395439.26012.75.camel@gmail.com>
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
Message-ID: <0c80b739-b190-1a33-47d1-a04692a948c7@nbd.name>
Date:   Thu, 30 Jan 2020 16:32:17 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <1580395439.26012.75.camel@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2020-01-30 15:43, Marlon Smith wrote:
> So I did a few tests and got some pretty interesting results.
> 
> With the two devices connected to the access point and performing
> slowly, I changed the MAC address of one of the devices (Just from a B6
> to a BA). Immediately, both devices began working properly!
> 
> Back to the original MAC address, I looked at my sniffer, and I do not
> see any evidence of one device acking another device's frames. With one
> device sitting idle and the other transferring data, I see high numbers
> of retransmitted frames, and then an eventual ack from the correct
> device, but very little activity from the idle device. While this is
> happening, the device driver indicates that it is dropping lots of
> duplicate received packets.
Here's the cause and an approach for fixing it:

The MAC_BSSID_DW1 register configures the Multi-BSSID mode. It can be
configured for 1, 2, 4 or 8 BSSIDs. This controls what MAC addresses the
chip will respond to. The driver always sets it up for 8 BSSIDs.

The problem here is that the chip has a hardcoded pattern for how those
BSSIDs are allocated:
Depending on the number of BSSIDs, the lower 1, 2 or 3 bits are used to
encode the BSS index. This means that when 8 BSSIDs are enabled, the
lower 3 bits are effectively masked out on the MAC address filter that
decides which frames to ACK. Because your MAC addresses are so close
together, both devices try to ACK the same frames at the same time. This
will not be visible in a sniffer, since they will be transmitting at the
same time.

I'd say the first step in fixing this is to make the driver set
MAC_BSSID_DW1_BSS_ID_MASK based on the MAC addresses of configured
virtual interfaces. For older chips, this MAC address pattern cannot be
fixed.

However, on at least RT3883, RT3352 and RT5350 (and thus most likely
also RT5370), you can set BIT 21 in that register, which changes the
pattern. With that bit set, the second interface only sets the local bit
of the MAC address, and from the third interface on it adds (idx-1)<<2
to the first byte. That gets rid of the MAC address conflicts.

Hopefully someone familiar with the rt2x00 code will read this and write
some patches :)

- Felix
