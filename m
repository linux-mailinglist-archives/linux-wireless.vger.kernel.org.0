Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4670446F2CE
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Dec 2021 19:10:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243143AbhLISNx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 9 Dec 2021 13:13:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242961AbhLISNw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 9 Dec 2021 13:13:52 -0500
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1402EC0617A2
        for <linux-wireless@vger.kernel.org>; Thu,  9 Dec 2021 10:10:19 -0800 (PST)
Received: by mail-io1-xd29.google.com with SMTP id c3so7628318iob.6
        for <linux-wireless@vger.kernel.org>; Thu, 09 Dec 2021 10:10:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=egauge.net; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:user-agent:mime-version;
        bh=6zY6sGFCH897+MuLK3bN1StqwLLhauvra45Jzw13JvI=;
        b=BEA6gqTK5d61nG8QFSOynF6LmTMAyDjD45GOmKcN8I7QK0p4vNIaOVoSvtfh0BJ21v
         ett3ByP9AXK9bN1BsGattJWuSMmshpVyE3eyivU2WW0CuZL53haFzx6vxGL4Uuju1X2b
         80c9OTVYQzkICta+QykS10hLOkGc4E/4TTpjcMC4tEMXSeNNNLrU/LvXNqN3B0uILTzF
         RT9fX2dIPJ0OdN+APmUG/BxsoL83shv9s9HleEdeue/RZ1qBfTMYtRP/aQXkca8tfjkN
         InwW4UYgf4/N3QyrGv/2Hhaf/bvF0dBCyh1/nV10OPEvXFzmGfOOi3mzu041ty5GqEYn
         tbBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version;
        bh=6zY6sGFCH897+MuLK3bN1StqwLLhauvra45Jzw13JvI=;
        b=xFQMBaETgLs1YbuOrFLYwl6TlK/SPy/My1hnCMlOCNlWSUo9UWsss1v4v0xmKmS9Av
         mhmoCeAqkZbzF2VE2DngvMfp112WStu1AIV5ocw6lsKfqC0/Bbv6t+zoXBOjDrOSSePZ
         qotjkVUiILMm7I9FDCny05hR1OYpsEYCpThxw3zI5/XBmTFeDC71rAmlT2/JippfmmSa
         JwF0XnHLf31jGfr9NsD4JTtyJezVuQ0zwCDqHDc6vU8sEsY5vbHnYb7ZQc7h9EDhhsBU
         14nK6FjCoefwqpnopdgjHsle30RS1jr1R9cbX0GCVHn/CTHgja9sw416vxPNwirfIs3I
         14og==
X-Gm-Message-State: AOAM5319k4Vw05t0DBfk/++/LX2Fs9vO6a3JZaVKZQqmRVoawKMMg/ea
        NT6J//05eYMZkfTACXB3edOy
X-Google-Smtp-Source: ABdhPJy7sukabRFKVLw9eINYlBCIeOe8i93C3Wcxp6nzaoi+gNbrIz3zHGU0LhmaAtIXcDAjcNWH0A==
X-Received: by 2002:a5d:818a:: with SMTP id u10mr15493285ion.140.1639073418324;
        Thu, 09 Dec 2021 10:10:18 -0800 (PST)
Received: from bixby.lan (c-73-181-115-211.hsd1.co.comcast.net. [73.181.115.211])
        by smtp.gmail.com with ESMTPSA id i10sm263682ilu.84.2021.12.09.10.10.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Dec 2021 10:10:16 -0800 (PST)
Message-ID: <bea03361e0571723f7ef04a0b97ff81086938e96.camel@egauge.net>
Subject: Re: RFC: wilc1000 module parameter to disable chip sleep
From:   David Mosberger-Tang <davidm@egauge.net>
To:     Ajay.Kathat@microchip.com
Cc:     Claudiu.Beznea@microchip.com, linux-wireless@vger.kernel.org
Date:   Thu, 09 Dec 2021 11:10:12 -0700
In-Reply-To: <4bf158ac-18d0-6feb-fbef-dc0739d74487@microchip.com>
References: <0baed35e98144bc7e29681264caf954b659cd481.camel@egauge.net>
         <4bf158ac-18d0-6feb-fbef-dc0739d74487@microchip.com>
Organization: eGauge Systems LLC
Content-Type: multipart/mixed; boundary="=-NEP7zPgnw7hDlwUwcHcm"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--=-NEP7zPgnw7hDlwUwcHcm
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Thu, 2021-12-09 at 09:20 +0000, Ajay.Kathat@microchip.com wrote:
> On 09/12/21 00:20, David Mosberger-Tang wrote:

> The "chip_wakeup" & "chip_allow_sleep" API's are required to configure 
> the wake-up registers in wilc. These registers must be configured 
> correctly when the power save mode is enabled.

I see.

> > Here is what I see: on a system configured for minimum power consumption
> > (all unnecessary daemons disabled, Ethernet unplugged) I measured 1,180 mW
> > when the WILC chip is in RESET (the ENABLE pin is always high on our
> > platform).
> > 
> > With the wilc1000-spi/wilc1000 modules loaded and the WILC chip
> > running but without being associated with a WLAN network, measured
> > power consumption was 1,460 mW, regardless of whether chip sleep was
> > enabled or disabled.
> 
> Did you test by enabling the power-save mode with "wpa_supplicant" or 
> using "iw" command. For power consumption measurement, please try by 
> disabling the PSM mode.

No, I have not played with power-saving mode.  There are some disconcerting
messages when turning PSM on:

[ 1764.070375] wilc1000_spi spi1.0: Failed cmd, cmd (ca), resp (00)
[ 1764.076403] wilc1000_spi spi1.0: Failed cmd, read reg (000013f4)...

The driver does still work, but occasionally, I get long streams of these
messages, sometimes it gets to the point where there are so many that the
watchdog timer ends up rebooting the system.

> The chip-sleep code is needed to configure the registers properly for 
> wilc and not using these sequence would have impact on sending the data 
> to wilc, especially when the PS mode is enabled.

How about something along the patch below then?

With this patch, I see the following iperf3 performance (120 second average):

PSM on:
[  4]   0.00-120.00 sec  47.6 MBytes  3.33 Mbits/sec    0             sender

PSM off:
[  4]   0.00-120.00 sec   201 MBytes  14.0 Mbits/sec   12             sender

In terms of power consumption:

   baseline                : 1.2 W
   PSM on, idle            : 1.2 W
   PSM on, TX @ 3.33 Mbps  : 1.7 W
   PSM off, idle           : 1.5 W
   PSM off, TX @ 14.0 Mbps : 2.4 W

  --david


--=-NEP7zPgnw7hDlwUwcHcm
Content-Disposition: attachment; filename="wip-chip-sleep.diff"
Content-Type: text/x-patch; name="wip-chip-sleep.diff"; charset="UTF-8"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21pY3JvY2hpcC93aWxjMTAwMC9oaWYu
YyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21pY3JvY2hpcC93aWxjMTAwMC9oaWYuYwppbmRleCA0
NGU5M2NkNWUzZGYuLjA5YWE1Y2VkMTlkMyAxMDA2NDQKLS0tIGEvZHJpdmVycy9uZXQvd2lyZWxl
c3MvbWljcm9jaGlwL3dpbGMxMDAwL2hpZi5jCisrKyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21p
Y3JvY2hpcC93aWxjMTAwMC9oaWYuYwpAQCAtMTkxMiw2ICsxOTEyLDcgQEAgaW50IHdpbGNfZWRp
dF9zdGF0aW9uKHN0cnVjdCB3aWxjX3ZpZiAqdmlmLCBjb25zdCB1OCAqbWFjLAogCiBpbnQgd2ls
Y19zZXRfcG93ZXJfbWdtdChzdHJ1Y3Qgd2lsY192aWYgKnZpZiwgYm9vbCBlbmFibGVkLCB1MzIg
dGltZW91dCkKIHsKKwlzdHJ1Y3Qgd2lsYyAqd2lsYyA9IHZpZi0+d2lsYzsKIAlzdHJ1Y3Qgd2lk
IHdpZDsKIAlpbnQgcmVzdWx0OwogCXM4IHBvd2VyX21vZGU7CkBAIC0xOTI3LDYgKzE5MjgsOCBA
QCBpbnQgd2lsY19zZXRfcG93ZXJfbWdtdChzdHJ1Y3Qgd2lsY192aWYgKnZpZiwgYm9vbCBlbmFi
bGVkLCB1MzIgdGltZW91dCkKIAlyZXN1bHQgPSB3aWxjX3NlbmRfY29uZmlnX3BrdCh2aWYsIFdJ
TENfU0VUX0NGRywgJndpZCwgMSk7CiAJaWYgKHJlc3VsdCkKIAkJbmV0ZGV2X2Vycih2aWYtPm5k
ZXYsICJGYWlsZWQgdG8gc2VuZCBwb3dlciBtYW5hZ2VtZW50XG4iKTsKKwllbHNlCisJCXdpbGMt
PnBvd2VyX3NhdmVfbW9kZSA9IGVuYWJsZWQ7CiAKIAlyZXR1cm4gcmVzdWx0OwogfQpkaWZmIC0t
Z2l0IGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWljcm9jaGlwL3dpbGMxMDAwL25ldGRldi5oIGIv
ZHJpdmVycy9uZXQvd2lyZWxlc3MvbWljcm9jaGlwL3dpbGMxMDAwL25ldGRldi5oCmluZGV4IDE1
MjQwODIzMmQ1MS4uZGIxNDlhYmM1ZDBkIDEwMDY0NAotLS0gYS9kcml2ZXJzL25ldC93aXJlbGVz
cy9taWNyb2NoaXAvd2lsYzEwMDAvbmV0ZGV2LmgKKysrIGIvZHJpdmVycy9uZXQvd2lyZWxlc3Mv
bWljcm9jaGlwL3dpbGMxMDAwL25ldGRldi5oCkBAIC0yNjcsNiArMjY3LDcgQEAgc3RydWN0IHdp
bGMgewogCiAJaW50IGNsaWVudHNfY291bnQ7CiAJc3RydWN0IHdvcmtxdWV1ZV9zdHJ1Y3QgKmhp
Zl93b3JrcXVldWU7CisJYm9vbCBwb3dlcl9zYXZlX21vZGU7CiAJZW51bSBjaGlwX3BzX3N0YXRl
cyBjaGlwX3BzX3N0YXRlOwogCXN0cnVjdCB3aWxjX2NmZyBjZmc7CiAJdm9pZCAqYnVzX2RhdGE7
CmRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC93aXJlbGVzcy9taWNyb2NoaXAvd2lsYzEwMDAvd2xh
bi5jIGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWljcm9jaGlwL3dpbGMxMDAwL3dsYW4uYwppbmRl
eCBkZGQzODI5OTYyNzUuLjBlMGUzMjVkMzk2ZSAxMDA2NDQKLS0tIGEvZHJpdmVycy9uZXQvd2ly
ZWxlc3MvbWljcm9jaGlwL3dpbGMxMDAwL3dsYW4uYworKysgYi9kcml2ZXJzL25ldC93aXJlbGVz
cy9taWNyb2NoaXAvd2lsYzEwMDAvd2xhbi5jCkBAIC0xOCwxMyArMTgsMTMgQEAgc3RhdGljIGlu
bGluZSBib29sIGlzX3dpbGMxMDAwKHUzMiBpZCkKIHN0YXRpYyBpbmxpbmUgdm9pZCBhY3F1aXJl
X2J1cyhzdHJ1Y3Qgd2lsYyAqd2lsYywgZW51bSBidXNfYWNxdWlyZSBhY3F1aXJlKQogewogCW11
dGV4X2xvY2soJndpbGMtPmhpZl9jcyk7Ci0JaWYgKGFjcXVpcmUgPT0gV0lMQ19CVVNfQUNRVUlS
RV9BTkRfV0FLRVVQKQorCWlmIChhY3F1aXJlID09IFdJTENfQlVTX0FDUVVJUkVfQU5EX1dBS0VV
UCAmJiB3aWxjLT5wb3dlcl9zYXZlX21vZGUpCiAJCWNoaXBfd2FrZXVwKHdpbGMpOwogfQogCiBz
dGF0aWMgaW5saW5lIHZvaWQgcmVsZWFzZV9idXMoc3RydWN0IHdpbGMgKndpbGMsIGVudW0gYnVz
X3JlbGVhc2UgcmVsZWFzZSkKIHsKLQlpZiAocmVsZWFzZSA9PSBXSUxDX0JVU19SRUxFQVNFX0FM
TE9XX1NMRUVQKQorCWlmIChyZWxlYXNlID09IFdJTENfQlVTX1JFTEVBU0VfQUxMT1dfU0xFRVAg
JiYgd2lsYy0+cG93ZXJfc2F2ZV9tb2RlKQogCQljaGlwX2FsbG93X3NsZWVwKHdpbGMpOwogCW11
dGV4X3VubG9jaygmd2lsYy0+aGlmX2NzKTsKIH0K


--=-NEP7zPgnw7hDlwUwcHcm--

