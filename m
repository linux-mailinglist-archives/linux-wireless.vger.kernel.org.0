Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 74C8F188815
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Mar 2020 15:52:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbgCQOwS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 17 Mar 2020 10:52:18 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:37903 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726812AbgCQOwS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 17 Mar 2020 10:52:18 -0400
Received: by mail-oi1-f195.google.com with SMTP id k21so22021290oij.5;
        Tue, 17 Mar 2020 07:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ecR1Q8eBSDGpmsPXI5s5h5OW1t7Z861Vgx2tdv3FnXk=;
        b=M73VUuxgxkAIX/ocDUVEUTlCgJ8KHTL6VWjeH54w4zFFZDtkniU3HZmsXZ8cRjx9SZ
         iMVnldkfezJpuyIXdNUZs1deTLMHrwUENRf832zkxpCzawDTcrwBvI5caGFIB419DJKZ
         HIJdVwv+ROFcmPkSmViyNyn+B6OzpRr3SqvxJO9WpQYvJyhbg06+VjTBCqxa/ksZpTn/
         vPnVmQCiCyphkzpb1SclHw1OtQWGWDjuroBAtH+aSnnxZ1+WQLnm7ykFLShSOn3gUFpq
         pECcMoWKMeBxIIIPEdmLTbnO8Xfcn8peASfRgLeawPjPJrzRBT6Ls5R/EEuy17cizVqW
         kNTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ecR1Q8eBSDGpmsPXI5s5h5OW1t7Z861Vgx2tdv3FnXk=;
        b=qtsFFYXGMkhDQezIGnHg2yxKGky4y7TtAzL9MyToV4p3+GsAT+llUwgatz6okHtrwu
         lZr2z4ZlsPOsqtwNRHW3HeFhFRLyODNk+hyRZI08gsE+easlwfB3CTzudqmIt/iuMin+
         3u2IdX7o+4SwKdRrKN7jY6h5OI2LCxraeBadbT3RqVYBO9uzO1Zq5kUgeGwBpWuxgNgl
         C7PeKSJtzjtT1BhiOj1gS1VkTyVrCU2adzww0XRk4ur9WEBPVT4/T97H7gBO5Pttotrg
         CTA+JKnky9CLZV6nD6WSge/DeW9UiLdaN6HMP2hX2wF6ZUm07RmgYqQbTVYJluK89rzm
         pZJg==
X-Gm-Message-State: ANhLgQ2THtvcaIEqD8FvWFxyjZXdDmSBrjVB7Am70EAF++RguORFVKJU
        0daS8Dnr5fvT9QHJXGjmWQL7LVTv
X-Google-Smtp-Source: ADFU+vsIaoTFpOvKki2DRF5YUDh4a0WfOkHZ9PIMSzhF/46X4oNIYN6IERXbjZ52QimF6y2g84nWZw==
X-Received: by 2002:aca:52d0:: with SMTP id g199mr3824119oib.59.1584456736636;
        Tue, 17 Mar 2020 07:52:16 -0700 (PDT)
Received: from [192.168.1.120] (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id 60sm1121917ott.17.2020.03.17.07.52.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Mar 2020 07:52:16 -0700 (PDT)
Subject: Re: PROBLEM: 5.6.0-rc6 + Realtek RTL8188CUS wifi dongle: 8051 reset
 failed!
To:     AC <achirvasub@gmail.com>, Ping-Ke Shih <pkshih@realtek.com>,
        Jes Sorensen <Jes.Sorensen@gmail.com>,
        linux-wireless@vger.kernel.org
Cc:     kernel list <linux-kernel@vger.kernel.org>
References: <C9F34A4B-E3F3-4D7A-B870-058C8D4871B9@gmail.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
Message-ID: <9ae33061-1595-4387-5767-79437b2ff2ae@lwfinger.net>
Date:   Tue, 17 Mar 2020 09:52:14 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <C9F34A4B-E3F3-4D7A-B870-058C8D4871B9@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: base64
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

T24gMy8xNy8yMCAxOjQ0IEFNLCBBQyB3cm90ZToNCj4gSSBhbSBvbiBEZWJpYW4gMTAuMyBz
dGFibGUgaTM4NiwgcnVubmluZyBhIGN1c3RvbS1jb21waWxlZCBrZXJuZWwgKEkgY29tcGls
ZSB3ZWVrbHksIHdoZW4gbmV3IHJjIHJlbGVhc2VzIGRyb3ApLg0KPiANCj4gSSBrZWVwIHRo
ZSBmb2xsb3dpbmcgVVNCIHdpZmkgZG9uZ2xlIGNvbm5lY3RlZCB0byB0aGlzIG1hY2hpbmU6
DQo+IA0KPiBJRCAwNTBkOjExMDIgQmVsa2luIENvbXBvbmVudHMgRjdEMTEwMiBOMTUwL1N1
cmYgTWljcm8gV2lyZWxlc3MgQWRhcHRlciB2MTAwMCBbUmVhbHRlayBSVEw4MTg4Q1VTXQ0K
PiANCj4gDQo+IC0tLQ0KPiANCj4gVGhlIHByb2JsZW06DQo+IA0KPiBBcyBvZiA1LjYuMC1y
YzYsIGJvb3RpbmcgdXAgd2l0aCB0aGUgZG9uZ2xlIGNvbm5lY3RlZCByZXR1cm5zIGEgbnVt
YmVyIG9mIGRtZXNnIGNvbXBsYWludHM6DQo+IA0KPiAtLS0gY3V0IGhlcmUgLS0tDQo+IA0K
PiBbICAgIDkuNDQ4MzM3XSBydGw4MTkyY3U6IE1BQyBhdXRvIE9OIG9rYXkhICAgICAgICAg
IFsgICAgOS41NzkwMjVdIHJ0bDgxOTJjdTogVHggcXVldWUgc2VsZWN0OiAweDA1ICAgICAg
WyAgIDEwLjQ3NTMwOF0gcnRsODE5MmNfY29tbW9uOiBQb2xsaW5nIEZXIHJlYWR5IGZhaWwh
IFJFR19NQ1VGV0RMOjB4MDAwMzAwMDYuICAgICAgICAgICAgICAgICAgICAgICAgICAgIFsg
ICAxMC40NzgyMTNdIHJ0bDgxOTJjX2NvbW1vbjogRmlybXdhcmUgaXMgbm90IHJlYWR5IHRv
IHJ1biEgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBbICAg
MTAuOTYwMDkzXSBydGw4MTkyY3U6IDgwNTEgcmVzZXQgZmFpbGVkIS4uLi4uLi4uLi4uLi4u
Li4uLi4uLi4uLi4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgWyAgIDEw
Ljk3MTAyN10gcnRsODE5MmN1OiBNQUMgYXV0byBPTiBva2F5ISAgICAgICAgICBbICAgMTEu
MTAxNjkxXSBydGw4MTkyY3U6IFR4IHF1ZXVlIHNlbGVjdDogMHgwNQ0KPiANCj4gLS0tIGVu
ZCAtLS0NCj4gDQo+IE9jY2FzaW9uYWxseSwgdGhpcyByZXN1bHRzIGluIGEgdGltZW91dCB3
aGlsZSB0cnlpbmcgdG8gcmVhY2ggbmV0d29yay50YXJnZXQgKHN5c3RlbWQpLg0KPiANCj4g
QWZ0ZXJ3YXJkcywgdGhlcmUncyBlbmRsZXNzIGRtZXNnIG5vaXNlIFJlOiBydGw4MTkyY3U6
DQo+IA0KPiAtLS0gY3V0IGhlcmUgLS0tDQo+IA0KPiBbMTEzOTEuMjA0NTU1XSBydGw4MTky
Y3U6IFR4IHF1ZXVlIHNlbGVjdDogMHgwNSAgICAgIFsxMTcwNy4wNTA0ODBdIHJ0bDgxOTJj
dTogTUFDIGF1dG8gT04gb2theSEgICAgICAgICAgWzExNzA3LjE4MTExOF0gcnRsODE5MmN1
OiBUeCBxdWV1ZSBzZWxlY3Q6IDB4MDUgICAgICBbMTIwMjMuMDU3MDU2XSBydGw4MTkyY3U6
IE1BQyBhdXRvIE9OIG9rYXkhICAgICAgICAgIFsxMjAyMy4xODc3MjddIHJ0bDgxOTJjdTog
VHggcXVldWUgc2VsZWN0OiAweDA1DQo+IFsxMjMzOS4wNjAxODNdIHJ0bDgxOTJjdTogTUFD
IGF1dG8gT04gb2theSEgICAgICAgICAgWzEyMzM5LjE5OTMxNl0gcnRsODE5MmN1OiBUeCBx
dWV1ZSBzZWxlY3Q6IDB4MDUgICAgICBbMTI2NTUuMDU0MTQwXSBydGw4MTkyY3U6IE1BQyBh
dXRvIE9OIG9rYXkhICAgICAgICAgIFsxMjY1NS4xODQ3ODldIHJ0bDgxOTJjdTogVHggcXVl
dWUgc2VsZWN0OiAweDA1ICAgICAgWzEyOTcxLjA1Mzk0OF0gcnRsODE5MmN1OiBNQUMgYXV0
byBPTiBva2F5ISAgICAgICAgICBbMTI5NzEuMTg0NjAwXSBydGw4MTkyY3U6IFR4IHF1ZXVl
IHNlbGVjdDogMHgwNSAgICAgIFsxMzI4Ny4wNjI3MTJdIHJ0bDgxOTJjdTogTUFDIGF1dG8g
T04gb2theSEgICAgICAgICAgWzEzMjg3LjE5MzM2M10gcnRsODE5MmN1OiBUeCBxdWV1ZSBz
ZWxlY3Q6IDB4MDUgICAgICBbMTM2MDMuMDY1OTg3XSBydGw4MTkyY3U6IE1BQyBhdXRvIE9O
IG9rYXkhICAgICAgICAgIFsxMzYwMy4xOTY2NDFdIHJ0bDgxOTJjdTogVHggcXVldWUgc2Vs
ZWN0OiAweDA1ICAgICAgWzEzOTE5LjA2NjYxN10gcnRsODE5MmN1OiBNQUMgYXV0byBPTiBv
a2F5ISAgICAgICAgICBbMTM5MTkuMTk3MjcwXSBydGw4MTkyY3U6IFR4IHF1ZXVlIHNlbGVj
dDogMHgwNSAgICAgIFsxNDIzNS4wNjA2MjFdIHJ0bDgxOTJjdTogTUFDIGF1dG8gT04gb2th
eSEgICAgICAgICAgWzE0MjM1LjE5MTI3N10gcnRsODE5MmN1OiBUeCBxdWV1ZSBzZWxlY3Q6
IDB4MDUgICAgICBbMTQ1NTEuMDU1MTA0XSBydGw4MTkyY3U6IE1BQyBhdXRvIE9OIG9rYXkh
ICAgICAgICAgIFsxNDU1MS4xODU3NDFdIHJ0bDgxOTJjdTogVHggcXVldWUgc2VsZWN0OiAw
eDA1ICAgICAgWzE0ODY3LjA1MTc5OV0gcnRsODE5MmN1OiBNQUMgYXV0byBPTiBva2F5ISAg
ICAgICAgICBbMTQ4NjcuMTgyNDUxXSBydGw4MTkyY3U6IFR4IHF1ZXVlIHNlbGVjdDogMHgw
NSAgICAgIFsxNDg3OC44NTUwNzBdIHBlcmY6IGludGVycnVwdCB0b29rIHRvbyBsb25nICg3
ODk3ID4gNzg5NiksIGxvd2VyaW5nIGtlcm5lbC5wZXJmX2V2ZW50X21heF9zYW1wbGVfcmF0
ZSB0byAyNTI1MA0KDQpQbGVhc2UgYmlzZWN0IHRoaXMgcHJvYmxlbS4gTm8gb25lIGVsc2Ug
aGFzIHJlcG9ydGVkIGl0LCB0aHVzIGl0IG1heSBkZXBlbmQgb24gDQpzb21lIHNwZWNpZmlj
IGNvbmZpZ3VyYXRpb24gb2YgeW91ciBzeXN0ZW0uDQoNCldhcyA1LjYuMC1yYzUgT0s/DQoN
CkxhcnJ5DQoNCg==
