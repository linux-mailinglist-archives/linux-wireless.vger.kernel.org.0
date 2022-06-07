Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B48655421CF
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Jun 2022 08:45:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236052AbiFHBDe (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 7 Jun 2022 21:03:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1457146AbiFGXV0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 7 Jun 2022 19:21:26 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADBB53E28BE
        for <linux-wireless@vger.kernel.org>; Tue,  7 Jun 2022 14:25:41 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id i66so25580884oia.11
        for <linux-wireless@vger.kernel.org>; Tue, 07 Jun 2022 14:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to;
        bh=o8U1S34GDx0bHp0NhWMtizvlqLqdERNlNdyKzmkx4+U=;
        b=by6D4BCYbgD+YVeH1LV9bok7CXSN7M3sM9x/DzG+WRKCeNvODXctf1UMvrv3TJpx45
         a2oFS8tMKxKY8RHt4DMYyVqU8tt/8ZX4E0BixrDU/rJumwo5qzgtAu+LUJlaa3dYOrj0
         tDNL7EpzYTNtZBrnBoExIj2qvrjn2o+9a+bhAx5iy/1nqZIUSE8jTi8z9QT5vKiWxB3o
         hotXE6DqSUDZ+qP8yFDYx/9h1rY1dMVgLcxautQG9dyZEjanQzo397/cjfnwf2ihOnZE
         fCFYE2utUq3tqxy8O5rCjfxiu2aZFggu8Rk3bD5NhgiDxVkFDUZz4r4TCg8/QzmAX+2K
         /iIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to;
        bh=o8U1S34GDx0bHp0NhWMtizvlqLqdERNlNdyKzmkx4+U=;
        b=S//DFnA7yGdzqbg82jCuUR0a2tasGikn87jA02RiQuq5fYRdIZzsHz7Mk+CptcwGgW
         eyZJs/B03SF+2ye02MkEpUNrRK9iUOVctO8WY6nfbm1TezBToYfFiXs7LFM6G/6v27x9
         zNkAxZGg9NGSATEGUBru9MYNMOK4V5rabrg9uPgwTPcwDZ6Ir6hLW8XhX7blX8KWJ0V+
         bF8ftc37mZovsiQ+mxu4E7sjmh8oQudKscuj2dX6x6NM6NLujsoMkvGD7FXrvbwAagqh
         pnbxGuw8cnl1LiXSw9Rz7USQlfdkXKJqOO3Bnnt70vfVwtRNvuk5EIRKFfOdRP2uNSNw
         UIcA==
X-Gm-Message-State: AOAM532L20Pc/NVp/qsXZqz64Sh+hY3I/WIwStBdgfBoeMX82zZ4i5a4
        xo5D1EMJeYu+3Ir7YmjmD2eAhUQLfpg=
X-Google-Smtp-Source: ABdhPJzbt/t6fRPL+SuZlHk5uuXAlFNBLU82yCMV7reTC+NNN4+bhs1nTCILQXgNg233txvuphaSZA==
X-Received: by 2002:a05:6808:f0f:b0:32b:a0a3:9618 with SMTP id m15-20020a0568080f0f00b0032ba0a39618mr549505oiw.264.1654637140395;
        Tue, 07 Jun 2022 14:25:40 -0700 (PDT)
Received: from ?IPV6:2603:8090:2005:39b3::100e? (2603-8090-2005-39b3-0000-0000-0000-100e.res6.spectrum.com. [2603:8090:2005:39b3::100e])
        by smtp.gmail.com with ESMTPSA id w5-20020a056808140500b00326cb6225f8sm10917063oiv.44.2022.06.07.14.25.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jun 2022 14:25:39 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Content-Type: multipart/mixed; boundary="------------YrgDnoQ1hV7DXXiBBUtxqYaH"
Message-ID: <e28ce50b-c1e6-74ae-6f57-5f864ba0c93a@lwfinger.net>
Date:   Tue, 7 Jun 2022 16:25:38 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v3 4/4] rtw88: Fix Sparse warning for rtw8821c_hw_spec
Content-Language: en-US
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Kalle Valo <kvalo@kernel.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org, Ping-Ke Shih <pkshih@realtek.com>
References: <20220524153716.20450-1-Larry.Finger@lwfinger.net>
 <Yp+hfo5Uual8ZUkR@dev-arch.thelio-3990X>
From:   Larry Finger <Larry.Finger@lwfinger.net>
In-Reply-To: <Yp+hfo5Uual8ZUkR@dev-arch.thelio-3990X>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This is a multi-part message in MIME format.
--------------YrgDnoQ1hV7DXXiBBUtxqYaH
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/7/22 14:05, Nathan Chancellor wrote:
> Hi Larry,
> 
> On Tue, May 24, 2022 at 10:37:16AM -0500, Larry Finger wrote:
>> Sparse lists the following:
>>
>>    CHECK   drivers/net/wireless/realtek/rtw88/rtw8821c.c
>> drivers/net/wireless/realtek/rtw88/rtw8821c.c:1880:22: warning: symbol 'rtw8821c_hw_spec' was not declared. Should it be static?
>>
>> The warning arises because the external declaration for rtw8821c_hw_spec
>> occurs in rtw8821ce.h, which is not included in rtw8821c.h. That line is
>> moved, and the now empty file rtw8821ce.h is deleted.
>>
>> Symbol 'rtw8821c_hw_spec' can be made constant.
>>
>> Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
> 
> I bisected this change as commit 89d8f53ff6e7 ("wifi: rtw88: Fix Sparse
> warning for rtw8821c_hw_spec") in linux-next as the cause of one of my
> test machines failing to boot with the following stacktrace:
> 
> BUG: unable to handle page fault for address: ffffffffc09f52f4
> #PF: supervisor write access in kernel mode

Nathan,

Thanks for your excellent report. Does the attached patch fix your issue?

Larry


--------------YrgDnoQ1hV7DXXiBBUtxqYaH
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-rtw88-Fix-BUG-in-rtl8821ce.patch"
Content-Disposition: attachment;
 filename="0001-rtw88-Fix-BUG-in-rtl8821ce.patch"
Content-Transfer-Encoding: base64

RnJvbSBmNmIwMmJiZTk1YzA0MDJmYjIzNzhhNTRlNTRkYjllMGNjNDU4N2RkIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBMYXJyeSBGaW5nZXIgPExhcnJ5LkZpbmdlckBsd2Zp
bmdlci5uZXQ+CkRhdGU6IFR1ZSwgNyBKdW4gMjAyMiAxNjoxNTowNyAtMDUwMApTdWJqZWN0
OiBbUEFUQ0hdIHJ0dzg4OiBGaXggQlVHIGluIHJ0bDg4MjFjZQpUbzogS2FsbGUgVmFsbyA8
a3ZhbG9Aa2VybmVsLm9yZz4KQ2M6IEpvaGFubmVzIEJlcmcgPGpvaGFubmVzQHNpcHNvbHV0
aW9ucy5uZXQ+LAogICAgbGludXgtd2lyZWxlc3NAdmdlci5rZXJuZWwub3JnCgpJbiBjb21t
aXQgODlkOGY1M2ZmNmU3ICgid2lmaTogcnR3ODg6IEZpeCBTcGFyc2Ugd2FybmluZyBmb3IK
cnR3ODgyMWNfaHdfc3BlYyIpLCBydHc4ODIxY19od19zcGVjIHdhcyBpbmNvcnJlY3RseSBt
YWtlIGNvbnN0CnRvIHNpbGVuY2UgYSBTcGFyc2Ugd2FybmluZy4KCkZpeGVzOjg5ZDhmNTNm
ZjZlNyAoIndpZmk6IHJ0dzg4OiBGaXggU3BhcnNlIHdhcm5pbmcgZm9yIHJ0dzg4MjFjX2h3
X3NwZWMiKQpSZXBvcnRlZCBieTogTmF0aGFuIENoYW5jZWxsb3IgPG5hdGhhbkBrZXJuZWwu
b3JnPgpTaWduZWQtb2ZmLWJ5OiBMYXJyeSBGaW5nZXIgPExhcnJ5LkZpbmdlckBsd2Zpbmdl
ci5uZXQ+Ci0tLQogZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydHc4OC9ydHc4ODIx
Yy5jIHwgMiArLQogZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydHc4OC9ydHc4ODIx
Yy5oIHwgMiArLQogMiBmaWxlcyBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRp
b25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydHc4
OC9ydHc4ODIxYy5jIGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydHc4OC9ydHc4
ODIxYy5jCmluZGV4IDQyODQxZjVkNTAyYy4uZmZlZTM5ZWE1ZGY2IDEwMDY0NAotLS0gYS9k
cml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0dzg4L3J0dzg4MjFjLmMKKysrIGIvZHJp
dmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydHc4OC9ydHc4ODIxYy5jCkBAIC0xODc3LDcg
KzE4NzcsNyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IHJ0d19yZWdfZG9tYWluIGNvZXhfaW5m
b19od19yZWdzXzg4MjFjW10gPSB7CiAJezB4NjBBLCBNQVNLQllURTAsIFJUV19SRUdfRE9N
QUlOX01BQzh9LAogfTsKIAotY29uc3Qgc3RydWN0IHJ0d19jaGlwX2luZm8gcnR3ODgyMWNf
aHdfc3BlYyA9IHsKK3N0cnVjdCBydHdfY2hpcF9pbmZvIHJ0dzg4MjFjX2h3X3NwZWMgPSB7
CiAJLm9wcyA9ICZydHc4ODIxY19vcHMsCiAJLmlkID0gUlRXX0NISVBfVFlQRV84ODIxQywK
IAkuZndfbmFtZSA9ICJydHc4OC9ydHc4ODIxY19mdy5iaW4iLApkaWZmIC0tZ2l0IGEvZHJp
dmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydHc4OC9ydHc4ODIxYy5oIGIvZHJpdmVycy9u
ZXQvd2lyZWxlc3MvcmVhbHRlay9ydHc4OC9ydHc4ODIxYy5oCmluZGV4IDI2OTg4MDFmYzM1
ZC4uNGY3NjkzN2RhNGVmIDEwMDY0NAotLS0gYS9kcml2ZXJzL25ldC93aXJlbGVzcy9yZWFs
dGVrL3J0dzg4L3J0dzg4MjFjLmgKKysrIGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRl
ay9ydHc4OC9ydHc4ODIxYy5oCkBAIC04NCw3ICs4NCw3IEBAIF9ydHdfd3JpdGUzMnNfbWFz
ayhzdHJ1Y3QgcnR3X2RldiAqcnR3ZGV2LCB1MzIgYWRkciwgdTMyIG1hc2ssIHUzMiBkYXRh
KQogCXJ0d193cml0ZTMyX21hc2socnR3ZGV2LCBhZGRyICsgMHgyMDAsIG1hc2ssIGRhdGEp
OwogfQogCi1leHRlcm4gY29uc3Qgc3RydWN0IHJ0d19jaGlwX2luZm8gcnR3ODgyMWNfaHdf
c3BlYzsKK2V4dGVybiBzdHJ1Y3QgcnR3X2NoaXBfaW5mbyBydHc4ODIxY19od19zcGVjOwog
CiAjZGVmaW5lIHJ0d193cml0ZTMyc19tYXNrKHJ0d2RldiwgYWRkciwgbWFzaywgZGF0YSkJ
CQkgICAgICAgXAogCWRvIHsJCQkJCQkJCSAgICAgICBcCi0tIAoyLjM2LjEKCg==

--------------YrgDnoQ1hV7DXXiBBUtxqYaH--
