Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 696E85147FF
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Apr 2022 13:23:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358260AbiD2L0q (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 29 Apr 2022 07:26:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345528AbiD2L0o (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 29 Apr 2022 07:26:44 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DC4332ECF;
        Fri, 29 Apr 2022 04:23:26 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id s27so10150693ljd.2;
        Fri, 29 Apr 2022 04:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to;
        bh=N8UVLZZiTfAWhTX0oeBw19cU46I7085rGpganzk5CW8=;
        b=aX26oHXRZLGO7QTBMkjxvvvkhXZH5XjIeOttGHzagTUZQPJgU2vv0jGlgtY99Zlzuk
         nAAiES3gi2/rhHhP5On4tdxCgtYoU7WBxOxD5Nf/KmjRaBZCP3qfoipVQDEPF0Iv6Qdr
         lfBd5/8rhmz51JvlD85iM8tABrc58n88nJRZEksh6IuHP1Y/Iwm5bSDJst6mmakNx2I8
         t5o4Et6dfyP4VJSCpWZ9UK1qXkTuaoBHTLcxfbMaqIXP2RHEMDTrZUp+dp0qkO82VPu4
         D9WrOUUjI8qLIOsWYKmPLeBee/qWCeKfG/CmnxTPR6whsGfIYEiM74EcPSJMA5oROEvx
         GuzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to;
        bh=N8UVLZZiTfAWhTX0oeBw19cU46I7085rGpganzk5CW8=;
        b=2ns/uoA/+qjxzve9l6nLePka5jy6ggW4522e2A43nXQGLFnzvjRQFk62dNYvY0NfVW
         z5+JR8zTzstBTkt9vZw4OMVZqURtB4bHolFY+LKwG52oG4j4lVSJdhyEDJ2SwzIqvuIu
         UbYJe1pMsFGIAXrf0m0ZKDHqFRsIYP0A6dXadipgYPHRcdZm7idxXvkUC3q9tOPuQPqo
         okKjzwE5I88rrcbIJLyCOMu7UxnGv7+TQSTSNoStWJW4DgjudyfETnKg9RaRChD8jjqx
         FmTAv2XUlJOWtP+JnoYuJ8v1fkYVAuL4mhIo7JE4ytb497NRYYKRw4LMSa03e6NJfNiv
         l6tA==
X-Gm-Message-State: AOAM5320Nv8YVVj20UI+M19zS+wKfTx33s54bCAlxW8B18eJCh7ULkW2
        gNjBgm0THcaTWyN1wPZaFtE=
X-Google-Smtp-Source: ABdhPJwsW5zzIimccUS/DHpzk/UodaDSGEvnk1QYe2HgsbZQPJv38HlDMDu1Nn6wazxltrmJrpqMVA==
X-Received: by 2002:a2e:bd0f:0:b0:24b:23ff:b7a9 with SMTP id n15-20020a2ebd0f000000b0024b23ffb7a9mr23601783ljq.194.1651231404533;
        Fri, 29 Apr 2022 04:23:24 -0700 (PDT)
Received: from [192.168.1.11] ([94.103.225.233])
        by smtp.gmail.com with ESMTPSA id z25-20020a19e219000000b00472230888a5sm215733lfg.121.2022.04.29.04.23.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Apr 2022 04:23:23 -0700 (PDT)
Message-ID: <1d7dcb43-cae7-8e15-ba97-a1cb69447bf5@gmail.com>
Date:   Fri, 29 Apr 2022 14:23:22 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] ath9k: fix use-after-free read at ath9k_hif_usb_rx_cb()
Content-Language: en-US
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Toke Hoiland-Jorgensen <toke@toke.dk>,
        Jakub Kicinski <kuba@kernel.org>,
        Kalle Valo <kvalo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     syzbot <syzbot+03110230a11411024147@syzkaller.appspotmail.com>,
        andreyknvl@google.com, ath9k-devel@qca.qualcomm.com,
        linux-usb@vger.kernel.org, linux-wireless@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
References: <00000000000055348705b43c701d@google.com>
 <3ec24824-00b6-4fc3-8bcf-71b9bbcb69c2@I-love.SAKURA.ne.jp>
From:   Pavel Skripkin <paskripkin@gmail.com>
In-Reply-To: <3ec24824-00b6-4fc3-8bcf-71b9bbcb69c2@I-love.SAKURA.ne.jp>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------rCBFPK9CMZoKhIg2R4chA037"
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------rCBFPK9CMZoKhIg2R4chA037
Content-Type: multipart/mixed; boundary="------------82pu00HS4H15ZPTPk6l0ZZFY";
 protected-headers="v1"
From: Pavel Skripkin <paskripkin@gmail.com>
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
 Toke Hoiland-Jorgensen <toke@toke.dk>, Jakub Kicinski <kuba@kernel.org>,
 Kalle Valo <kvalo@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Cc: syzbot <syzbot+03110230a11411024147@syzkaller.appspotmail.com>,
 andreyknvl@google.com, ath9k-devel@qca.qualcomm.com,
 linux-usb@vger.kernel.org, linux-wireless@vger.kernel.org,
 syzkaller-bugs@googlegroups.com
Message-ID: <1d7dcb43-cae7-8e15-ba97-a1cb69447bf5@gmail.com>
Subject: Re: [PATCH] ath9k: fix use-after-free read at ath9k_hif_usb_rx_cb()
References: <00000000000055348705b43c701d@google.com>
 <3ec24824-00b6-4fc3-8bcf-71b9bbcb69c2@I-love.SAKURA.ne.jp>
In-Reply-To: <3ec24824-00b6-4fc3-8bcf-71b9bbcb69c2@I-love.SAKURA.ne.jp>

--------------82pu00HS4H15ZPTPk6l0ZZFY
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkgVGV0c3VvLA0KDQpPbiA0LzI5LzIyIDE0OjE4LCBUZXRzdW8gSGFuZGEgd3JvdGU6DQo+
IEFsdGhvdWdoIGhpZl9kZXYtPmh0Y19oYW5kbGUgaXMgYWxsb2NhdGVkIGJ5IGF0aDlrX2h0
Y19od19hbGxvYygpIGZyb20NCj4gYXRoOWtfaGlmX3VzYl9maXJtd2FyZV9jYigpLCBoaWZf
ZGV2LT5odGNfaGFuZGxlLT5kcnZfcHJpdiBpcyBub3QgYXNzaWduZWQNCj4gdW50aWwgaWVl
ZTgwMjExX2FsbG9jX2h3KCkgZnJvbSBhdGg5a19odGNfcHJvYmVfZGV2aWNlKCkgZnJvbQ0K
PiBhdGg5a19odGNfaHdfaW5pdCgpIGZyb20gYXRoOWtfaGlmX3VzYl9maXJtd2FyZV9jYigp
IHJldHVybnMuIEhvd2V2ZXIsIGFzDQo+IHNvb24gYXMgYXRoOWtfaGlmX3VzYl9hbGxvY19y
eF91cmJzKCkgZnJvbSBhdGg5a19oaWZfdXNiX2FsbG9jX3VyYnMoKSBmcm9tDQo+IGF0aDlr
X2hpZl91c2JfZGV2X2luaXQoKSBmcm9tIGF0aDlrX2hpZl91c2JfZmlybXdhcmVfY2IoKSBy
ZXR1cm5zLCBhIHRpbWVyDQo+IGludGVycnVwdCBjYW4gYWNjZXNzIGhpZl9kZXYtPmh0Y19o
YW5kbGUtPmRydl9wcml2IHZpYSBSWF9TVEFUX0lOQygpIGZyb20NCj4gYXRoOWtfaGlmX3Vz
Yl9yeF9zdHJlYW0oKSBmcm9tIGF0aDlrX2hpZl91c2JfcnhfY2IoKSBmcm9tDQo+IHVzYl9o
Y2RfZ2l2ZWJhY2tfdXJiKCksIHdoaWNoIHJlc3VsdHMgaW4gTlVMTCBwb2ludGVyIGRlZmVy
ZW5jZSBwcm9ibGVtLg0KPiANCj4gQWxzbywgZXZlbiBhZnRlciBodGNfaGFuZGxlLT5kcnZf
cHJpdiBpcyBhc3NpZ25lZCwgd2hlbg0KPiBhdGg5a19odGNfd2FpdF9mb3JfdGFyZ2V0KCkg
ZnJvbSBhdGg5a19odGNfcHJvYmVfZGV2aWNlKCkgZnJvbQ0KPiBhdGg5a19odGNfaHdfaW5p
dCgpIGZyb20gYXRoOWtfaGlmX3VzYl9maXJtd2FyZV9jYigpIGZhaWxzLA0KPiBpZWVlODAy
MTFfZnJlZV9odygpICh3aGljaCBkb2VzIG5vdCByZXNldCBoaWZfZGV2LT5odGNfaGFuZGxl
LT5kcnZfcHJpdikNCj4gaXMgaW1tZWRpYXRlbHkgY2FsbGVkIGR1ZSB0byAiZ290byBlcnJf
ZnJlZTsiLiBBcyBhIHJlc3VsdCwgYSB0aW1lcg0KPiBpbnRlcnJ1cHQgd2hpY2ggaGFwcGVu
cyBhZnRlciBpZWVlODAyMTFfZnJlZV9odygpIHRyaWdnZXJzIHVzZS1hZnRlci1mcmVlDQo+
IHByb2JsZW0gYXQgdGhlIGFib3ZlbWVudGlvbmVkIGxvY2F0aW9uLg0KPiANCj4gV2UgY2Fu
IGZsdXNoIGluLWZsaWdodCByZXF1ZXN0cyBieSBjYWxsaW5nIGF0aDlrX2hpZl91c2JfZGVh
bGxvY191cmJzKCkNCj4gYmVmb3JlIGNhbGxpbmcgaWVlZTgwMjExX2ZyZWVfaHcoKS4gQnV0
IHdlIG5lZWQgdG8gdGFrZSBmcm9tIHR3byBjaG9pY2VzDQo+IGZvciBub3QgeWV0IGFzc2ln
bmVkIGNhc2UuIE9uZSBpcyB0byBjaGFuZ2UgZS5nLiBSWF9TVEFUX0lOQygpIHRvIGNoZWNr
DQo+IGZvciBOVUxMIGJlY2F1c2UgaXQgZGVwZW5kcyBvbiBDT05GSUdfQVRIOUtfSFRDX0RF
QlVHRlM9eS4gVGhlIG90aGVyIGlzIHRvDQo+IGFzc2lnbiBhIGR1bW15IG9iamVjdCB3aGlj
aCBpcyB1c2VkIHVudGlsIGluaXRpYWxpemF0aW9uLiBUaGlzIHBhdGNoIHRvb2sNCj4gdGhl
IGxhdHRlci4NCj4gDQo+IExpbms6IGh0dHBzOi8vc3l6a2FsbGVyLmFwcHNwb3QuY29tL2J1
Zz9leHRpZD0wMzExMDIzMGExMTQxMTAyNDE0Nw0KPiBSZXBvcnRlZC1ieTogc3l6Ym90IDxz
eXpib3QrMDMxMTAyMzBhMTE0MTEwMjQxNDdAc3l6a2FsbGVyLmFwcHNwb3RtYWlsLmNvbT4N
Cj4gU2lnbmVkLW9mZi1ieTogVGV0c3VvIEhhbmRhIDxwZW5ndWluLWtlcm5lbEBJLWxvdmUu
U0FLVVJBLm5lLmpwPg0KPiBUZXN0ZWQtYnk6IHN5emJvdCA8c3l6Ym90KzAzMTEwMjMwYTEx
NDExMDI0MTQ3QHN5emthbGxlci5hcHBzcG90bWFpbC5jb20+DQo+IC0tLQ0KPiBQYXZlbCBT
a3JpcGtpbiBoYXMgdGVzdGVkICJjaGVjayBmb3IgTlVMTCIgYXBwcm9hY2gsIGJ1dCBub3Qg
eWV0IGFjY2VwdGVkLg0KPiBXaGF0IHdhcyB3cm9uZyB3aXRoIFBhdmVsJ3MgYXBwcm9hY2g/
DQo+IA0KDQpJIGRvbid0IGtub3cuIElJUkMgdGhlIHByb2JsZW0gaXMgdGhhdCBub2JvZHkg
aGFzIHRlc3RlZCBteSBwYXRjaCBvbiANCnJlYWwgaHcsIHNvIHRoZXkgY2FuJ3QgYWNjZXB0
IGl0IGFzLWlzLiBBbmQgbWF5YmUgaXQganVzdCBnb3QgbG9zdA0KDQpZb3UgY2FuIGNoZWNr
IG91dCBbMV0gdGhyZWFkLiBJdCdzIHRoZSBsYXRlc3QgdmVyc2lvbiBJIGhhdmUgcG9zdGVk
DQoNCg0KDQpbMV0gDQpodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvODA5NjJhYWUyNjU5
OTVkMWNkYjcyNGY1MzYyYzU1NmQ0OTRjNzU2Ni4xNjQ0MjY1MTIwLmdpdC5wYXNrcmlwa2lu
QGdtYWlsLmNvbS8NCg0KDQoNCldpdGggcmVnYXJkcywNClBhdmVsIFNrcmlwa2luDQoNCg0K
DQo=

--------------82pu00HS4H15ZPTPk6l0ZZFY--

--------------rCBFPK9CMZoKhIg2R4chA037
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEER3XL3TplLQE8Qi40bk1w61LbBA0FAmJryqoFAwAAAAAACgkQbk1w61LbBA2n
0Q//V77FG5erDZF6hu91w4eQwPM3L+2zE/ERtwJL09Ir9u4JrfFi46H0mPRNYUZUleRhkg0BFlkz
7x8V4FcNS1ETQy10Pd0ruH+k4okPuPlG60n2ugpl8IT/k9aWbVh3+yWdDlqqtyLYirmXfT9NC30m
jFdv/q9nkoIIgbhpgU7N3ja/Lbqs8KqTu40N+wPElIWl1awWsYdqv6pODM8QVAO7Y5StZUlBkudk
VKWm1Dp37Lo5jxwsRN9zYjqVoBSTtjxYNiEJUDIPYbz6qpYg/JOAzbSWtMQaIjTgtkGNBD51i18L
0ZIeI/xeGLJ3LdffW3GLKkYCmPJHpfyPh8a1HhqYOszqLmmITWGdmEOjaUyJdDuvIT2pcw4AAKe6
FqlGV/6BsQUW4KM704fiK6tG51LE33+8otj2Tyq9VoNKmFXv21OzpjKBx0vNFwR/TCAnY/3UnrLl
3TlmVYNIDxhpsa5gjoUBMy6JiGTzYEPFOp6UVThBn9WnOiZYfPWUZ/z3BCY2P06WbJT9aP24l3oW
jmZu+EVbSMpqA8C6M4m6UW9y08g9kRcddHTSpKWFnv/WTYhYNiXOMpW7ICRm7jnY5gEQ4OKATV7q
XvXEk9gjfBow2FOj64s2lb2IgMMfj4wqr1i99LxyHsIz2c7z8tbagu9xAUSZgR5h9YGEoqqP4Xs+
TCc=
=9KQm
-----END PGP SIGNATURE-----

--------------rCBFPK9CMZoKhIg2R4chA037--
