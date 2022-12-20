Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45FD76527D6
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Dec 2022 21:24:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233914AbiLTUYj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 20 Dec 2022 15:24:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbiLTUYh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 20 Dec 2022 15:24:37 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E4123AF
        for <linux-wireless@vger.kernel.org>; Tue, 20 Dec 2022 12:24:36 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id v124-20020a1cac82000000b003cf7a4ea2caso12010552wme.5
        for <linux-wireless@vger.kernel.org>; Tue, 20 Dec 2022 12:24:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=c2bFmxYT3zvM7I3Ys48664PKtgjsbzVbriVicmQMdGw=;
        b=jSWkCIpHIW4m8uVPwg+nUCL1OBhT77YlzX+W02eY3BqewrtkOLe7Y8cmO1xVMGLGEO
         oqVG9ZWCwgVjxq22ZJ1A3PuOwmgd/YqnJMgsZx+jAqHL4v3YkKzj1faqXDkHFQk53Ll9
         l9m5fH401mTOEp2kbdiOHog/0mAIIoHJ43eyR+YGmIC+GA4I8HoMDlduckAuQmW2bpBw
         dJMc0VU1YADCD4EqbLcLXJSZed4ebQYmt4KV/c6daIhBZ2vqm+1y4z1B3Nl2FJND1evC
         m2RV9vSqAhDhNKCoxanLhNXP3KkkwC1GVpDqPp7U39yqtQoOqZVqqqVRIrG3acgwLFl8
         yIcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=c2bFmxYT3zvM7I3Ys48664PKtgjsbzVbriVicmQMdGw=;
        b=29tyIqxGKHXnAFRukSqzHwNiXWb158JY9jD35lM1PWJuZzw4hJIQOQ53Izaq7FEVny
         Kx4kDU33fO23gshypUAw2Fzr4e+pplzm5SoHEqwtHlNExWQchgdBcqUeDDJzl7naMw4q
         /MXlIBM43sHWywUPCUT5Cpx62c6g4LlfgUesDzvNvkCXgAHdwow+EvfX/qR2GUXw99Nj
         U4pUeJcfRLtrXbjk1XpF49iE5GiNPa30pgpS97oUP9ItnpreQ6VK0parufezO6i6BGHe
         ZxEGjOiHBR9daF5Ac4LLMZ7ZW9FiX4au64L7kHWnpSXd7gSBdJnyf+PmNQwJXcjyyz+o
         tF8Q==
X-Gm-Message-State: AFqh2krOmbYEFQlztbTdo8oQLwptq7JTlbe94Eulg/DZXbQKxj8WciTG
        QrWh+64CGa9UPMr0i7IBZRb/fOcAlH/l/VImDk/K2OZckk0=
X-Google-Smtp-Source: AMrXdXuSq2yf8Bgcpq6fUuZvxIgsc4lWZnigfzRkTDiOBwUub5E5UWnIZpQ+V3PWDTcGplUP5UMTnk6O7SL83ywOuFc=
X-Received: by 2002:a05:600c:22d4:b0:3cf:a6e8:b59b with SMTP id
 20-20020a05600c22d400b003cfa6e8b59bmr1503613wmg.128.1671567874927; Tue, 20
 Dec 2022 12:24:34 -0800 (PST)
MIME-Version: 1.0
From:   Dave Taht <dave.taht@gmail.com>
Date:   Tue, 20 Dec 2022 12:24:21 -0800
Message-ID: <CAA93jw6NJ2cmLmMauz0xAgC2MGbBq6n0ZiZzAdkK0u4b+O2yXg@mail.gmail.com>
Subject: a nuking the mac80211 changing codel parameters patch
To:     reiser4@gmail.com,
        Make-Wifi-fast <make-wifi-fast@lists.bufferbloat.net>,
        OpenWrt Development List <openwrt-devel@lists.openwrt.org>,
        linux-wireless <linux-wireless@vger.kernel.org>
Content-Type: multipart/mixed; boundary="00000000000067467f05f048399c"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

--00000000000067467f05f048399c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

This is the single, most buggy, piece of code in "my" portion of wifi
today. It is so wrong, yet thus far I cannot get it out of linux or
find an acceptable substitute. It makes it hard to sleep at night
knowing this code has been so wrong... and now in millions , maybe
even 10s of millions, of devices by now.... Since I've been ranting
about the wrongness of this for years, I keep hoping that we can
excise it, especially for wifi6 devices and even more especially on
6ghz spectrum... but just about everything, somehow, would benefit
hugely if we could somehow do more of the right thing here.

I'd tried, last time I got this bee in my bonnet, tried to nuke this call h=
ere:

https://forum.openwrt.org/t/reducing-multiplexing-latencies-still-further-i=
n-wifi/133605/

As it is, I really encourage folk, especially with mt79 and to some
extent mt76 ac or ath10k, to try out the attached patch, measure tcp
rtts, and throughput, etc. A slightly less aggressive patch might suit
wifi-n....

Maybe there's a reason for keeping this code in linux wifi that I do
not understand. But here are my pithy comments as to why this part of
mac80211 is so wrong...

 static void sta_update_codel_params(struct sta_info *sta, u32 thr)
 {
-       if (thr && thr < STA_SLOW_THRESHOLD * sta->local->num_sta) {

1) sta->local->num_sta is the number of associated, rather than
active, stations. "Active" stations in the last 50ms or so, might have
been a better thing to use, but as most people have far more than that
associated, we end up with really lousy codel parameters, all the
time. Mistake numero uno!

2) The STA_SLOW_THRESHOLD was completely arbitrary in 2016.

-               sta->cparams.target =3D MS2TIME(50);

This, by itself, was probably not too bad. 30ms might have been
better, at the time, when we were battling powersave etc, but 20ms was
enough,
really, to cover most scenarios, even where we had low rate 2Ghz
multicast to cope with. Even then, codel has a hard time finding any
sane drop
rate at all, with a target this high.

-               sta->cparams.interval =3D MS2TIME(300);

But this was horrible, a total mistake, that is leading to codel being
completely ineffective in almost any scenario on clients or APS.
100ms, even 80ms, here, would be vastly better than this insanity. I'm
seeing 5+seconds of delay accumulated in a bunch of otherwise happily
fq-ing APs....

100ms of  observed jitter during a flow is enough. Certainly (in 2016)
there were interactions with powersave that I did not understand, and
still don't, but
if you are transmitting in the first place, powersave shouldn't be a
problemmmm.....

-               sta->cparams.ecn =3D false;

At the time we were pretty nervous about ecn, I'm kind of sanguine
about it now, and reliably indicating ecn seems better than turning it
off for
any reason.

-       } else {
-               sta->cparams.target =3D MS2TIME(20);
-               sta->cparams.interval =3D MS2TIME(100);
-               sta->cparams.ecn =3D true;
-       }

And if we aint gonna fiddle with these, we don't need these either.

In production, on p2p wireless, I've had 8ms and 80ms for target and
interval for years now, and it works great. It is obviously too low,
for those that
prize bandwidth over latency (I personally would prefer TXOPs shrink
intelligently as well as bandwidth, as you add stations, some of which
happens naturally by fq-codels scheduling mechanisms, others don't, I
even run with 2ms txops by default on everything myself)

+       return;

Ideally we could kill this entire call off entirely.

 }

A pre-thx for anyone actually trying the attached patch and reporting
back on any results.

https://forum.openwrt.org/t/reducing-multiplexing-latencies-still-further-i=
n-wifi/133605/


--=20
This song goes out to all the folk that thought Stadia would work:
https://www.linkedin.com/posts/dtaht_the-mushroom-song-activity-69813666656=
07352320-FXtz
Dave T=C3=A4ht CEO, TekLibre, LLC

--00000000000067467f05f048399c
Content-Type: text/x-patch; charset="US-ASCII"; name="killcodel.patch"
Content-Disposition: attachment; filename="killcodel.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_lbwng7ft0>
X-Attachment-Id: f_lbwng7ft0

ZGlmZiAtLWdpdCBhL25ldC9tYWM4MDIxMS9zdGFfaW5mby5jIGIvbmV0L21hYzgwMjExL3N0YV9p
bmZvLmMKaW5kZXggOTdkMjRlOS4uNDU3MjA5YSAxMDA2NDQKLS0tIGEvbmV0L21hYzgwMjExL3N0
YV9pbmZvLmMKKysrIGIvbmV0L21hYzgwMjExL3N0YV9pbmZvLmMKQEAgLTI3NjYsMTUgKzI3NjYs
NyBAQCB1bnNpZ25lZCBsb25nIGllZWU4MDIxMV9zdGFfbGFzdF9hY3RpdmUoc3RydWN0IHN0YV9p
bmZvICpzdGEpCiAKIHN0YXRpYyB2b2lkIHN0YV91cGRhdGVfY29kZWxfcGFyYW1zKHN0cnVjdCBz
dGFfaW5mbyAqc3RhLCB1MzIgdGhyKQogewotCWlmICh0aHIgJiYgdGhyIDwgU1RBX1NMT1dfVEhS
RVNIT0xEICogc3RhLT5sb2NhbC0+bnVtX3N0YSkgewotCQlzdGEtPmNwYXJhbXMudGFyZ2V0ID0g
TVMyVElNRSg1MCk7Ci0JCXN0YS0+Y3BhcmFtcy5pbnRlcnZhbCA9IE1TMlRJTUUoMzAwKTsKLQkJ
c3RhLT5jcGFyYW1zLmVjbiA9IGZhbHNlOwotCX0gZWxzZSB7Ci0JCXN0YS0+Y3BhcmFtcy50YXJn
ZXQgPSBNUzJUSU1FKDIwKTsKLQkJc3RhLT5jcGFyYW1zLmludGVydmFsID0gTVMyVElNRSgxMDAp
OwotCQlzdGEtPmNwYXJhbXMuZWNuID0gdHJ1ZTsKLQl9CisJcmV0dXJuOwogfQogCiB2b2lkIGll
ZWU4MDIxMV9zdGFfc2V0X2V4cGVjdGVkX3Rocm91Z2hwdXQoc3RydWN0IGllZWU4MDIxMV9zdGEg
KnB1YnN0YSwK
--00000000000067467f05f048399c--
