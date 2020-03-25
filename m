Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6DBD0192D9D
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2020 16:59:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727781AbgCYP7v (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 25 Mar 2020 11:59:51 -0400
Received: from mailout1.w2.samsung.com ([211.189.100.11]:36781 "EHLO
        mailout1.w2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727538AbgCYP7v (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 25 Mar 2020 11:59:51 -0400
X-Greylist: delayed 309 seconds by postgrey-1.27 at vger.kernel.org; Wed, 25 Mar 2020 11:59:50 EDT
Received: from uscas1p1.samsung.com (unknown [182.198.245.206])
        by mailout1.w2.samsung.com (KnoxPortal) with ESMTP id 20200325155439usoutp01508591ffca7828a14b64ff9290636e57~-lw3cTaqr1594715947usoutp01E;
        Wed, 25 Mar 2020 15:54:39 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w2.samsung.com 20200325155439usoutp01508591ffca7828a14b64ff9290636e57~-lw3cTaqr1594715947usoutp01E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1585151679;
        bh=uBgUiE+mFJd1LVOwXrKx1shwGlQmL1udUQmQHttm5gg=;
        h=From:To:CC:Subject:Date:References:From;
        b=Pmu389Ynsfb+mIST//8nyaeIoE2AvRGhxjV/JFMXsGTMQWms8aVnDE1P2SCIY8Z+j
         t/OOcbLFLTbZW/pjqQ+51DsRVrNeguZW7JDNZRoZgkCUKeCQqkWh7CuP7WcPkIz5hL
         B2PjF8Aw0l4+yEwrV022Nk8A+V/gswFVGt8HKXHA=
Received: from ussmges2new.samsung.com (u111.gpu85.samsung.co.kr
        [203.254.195.111]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200325155439uscas1p29039a95c2f8ea80bf9b33ccda74278f5~-lw3LrEk22217222172uscas1p2o;
        Wed, 25 Mar 2020 15:54:39 +0000 (GMT)
Received: from uscas1p1.samsung.com ( [182.198.245.206]) by
        ussmges2new.samsung.com (USCPEMTA) with SMTP id E3.65.20517.FBE7B7E5; Wed,
        25 Mar 2020 11:54:39 -0400 (EDT)
Received: from ussmgxs1new.samsung.com (u89.gpu85.samsung.co.kr
        [203.254.195.89]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200325155438uscas1p19c02d00cfd32dac911df3df7a5390eba~-lw2uZVRr0211002110uscas1p1g;
        Wed, 25 Mar 2020 15:54:38 +0000 (GMT)
X-AuditID: cbfec36f-5c7ff70000025025-65-5e7b7ebfc066
Received: from SSI-EX3.ssi.samsung.com ( [105.128.2.145]) by
        ussmgxs1new.samsung.com (USCPEXMTA) with SMTP id B5.12.59698.EBE7B7E5; Wed,
        25 Mar 2020 11:54:38 -0400 (EDT)
Received: from SSI-EX4.ssi.samsung.com (105.128.2.229) by
        SSI-EX3.ssi.samsung.com (105.128.2.228) with Microsoft SMTP Server
        (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
        15.1.1713.5; Wed, 25 Mar 2020 08:54:38 -0700
Received: from SSI-EX4.ssi.samsung.com ([fe80::d5ff:a0cf:b920:78a4]) by
        SSI-EX4.ssi.samsung.com ([fe80::d5ff:a0cf:b920:78a4%7]) with mapi id
        15.01.1713.004; Wed, 25 Mar 2020 08:54:38 -0700
From:   Geoffroy Letourneur <g.letourneur@samsung.com>
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linuxwifi@intel.com" <linuxwifi@intel.com>
CC:     Gilles Mazars <g.mazars@samsung.com>,
        Martin Bourreau <m.bourreau@samsung.com>
Subject: Geoffroy LETOURNEUR: Samsung AX200 system integration on Nvidia
 Nano.
Thread-Topic: Geoffroy LETOURNEUR: Samsung AX200 system integration on
        Nvidia Nano.
Thread-Index: AQHWAr2wsmsOeqOOfECn+0wE7X7A4Q==
Date:   Wed, 25 Mar 2020 15:54:38 +0000
Message-ID: <8096A04E-8692-4DC3-A8D0-8F85FF972799@samsung.com>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [105.128.2.176]
Content-Type: text/plain; charset="utf-8"
Content-ID: <D9173ED5D62FA74294D632B07A3295E1@ssi.samsung.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuplleLIzCtJLcpLzFFi42LZduzrOd39ddVxBsef8Fu8WXGH3aJz80RG
        ByaPxXteMnl83iQXwBTFZZOSmpNZllqkb5fAlTFnx0PWghaeijfPVjM1MN7h7mLk5JAQMJH4
        3HCduYuRi0NIYCWjxP4L/WwgCSGBViaJnb9SYYpWd29hhyhayyhx9c4FFgjnI6PEzsYVrBDO
        AUaJizdPsoO0sAG1vOv6zAJiiwiUSLy+OAHMZhYIkfhx9SfQPg4OYYEAieaN5hAloRKXH55g
        h7D1JPa+fA5WziKgKtFzooEZxOYVsJP4++YnWA2jgKzEtYWroUaKS3w7upIZ4lJBiUWz90DZ
        YhL/dj1kg7AVJe5/f8kOspZZQFNi/S59CNNO4vvdcIgpihJTuh+yQ2wSlDg58wkLRKekxMEV
        N8DelRA4wyaxcE4H1HgXiTM7XrNC2NISV69PhYq3M0oseOIK0TCFUWLr5L1MEAlriSd7TrNB
        bOOT+PvrEeMERuVZSF6YhXDeLITzZiE5bxaS8xYwsq5iFC8tLs5NTy02ykst1ytOzC0uzUvX
        S87P3cQITCSn/x3O38F4fknyIUYBDkYlHt4NltVxQqyJZcWVuYcYJTiYlUR4N6dWxAnxpiRW
        VqUW5ccXleakFh9ilOZgURLnffDoZayQQHpiSWp2ampBahFMlomDU6qBMdOqKHH5dK1rDmau
        F1pOKev+cP+xQV97v/Bp3Q/mlb8Sjk8otvcrLJ2Wv79zU+ELtaMPfHZuOxJ5rOLRVondD1l4
        mqZ/vSG6an6PbNE8hmBptRWnv/jvmiq6e97f7iWeIvL98/snieRsSlo5IaBgfcVM1/SMq0fM
        mFy/2+RbcHlaX5Jvlr8vosRSnJFoqMVcVJwIAOQye2MgAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprMIsWRmVeSWpSXmKPExsWS2cA0UXdfXXWcwZ9ePYs3K+6wW3Runsjo
        wOSxeM9LJo/Pm+QCmKK4bFJSczLLUov07RK4MubseMha0MJT8ebZaqYGxjvcXYycHBICJhKr
        u7ewdzFycQgJrGaU+L/gEguE85FRYtvvvVCZA4wSE85fYwVpYQNqedf1mQXEFhEokXh9cQKY
        zSwQIvHj6k9mEFtYwE/if/snqJpQiQdfJ7ND2HoSe18+B4uzCKhK9JxoAKvnFbCT+PvmJ1gN
        o4CsxLWFq6Fmikt8O7qSGeJUAYkle85D2aISLx//Y4WwFSXuf38J1MsBVK8psX6XPoRpJ/H9
        bjjEFEWJKd0P2SE2CUqcnPmEBaJTUuLgihssExjFZiFZNgth0CyEQbOQDJqFZNACRtZVjOKl
        xcW56RXFhnmp5XrFibnFpXnpesn5uZsYgVF1+t/hyB2MJ04nH2IU4GBU4uHdYFkdJ8SaWFZc
        mXuIUYKDWUmEd3NqRZwQb0piZVVqUX58UWlOavEhRmkOFiVx3uViC6KEBNITS1KzU1MLUotg
        skwcnFINjJzHHV0U/q44yTvRPXiacoSOtcH/hXzV5v+bShpznyWneZ7OftlzrcogavGB9fsa
        N7875DGvhnmyx5XMa96N51ZNn3CUc6J7Wknh7dVuK2u6S2+bvdypP/fCrwmyF1aLeon51Iim
        CzdGTJGp0ygVEuOcp9d+YCN/dq7841uBMzydXUxTPxWvUWIpzkg01GIuKk4EAIQauLCmAgAA
X-CMS-MailID: 20200325155438uscas1p19c02d00cfd32dac911df3df7a5390eba
CMS-TYPE: 301P
X-CMS-RootMailID: 20200325155438uscas1p19c02d00cfd32dac911df3df7a5390eba
References: <CGME20200325155438uscas1p19c02d00cfd32dac911df3df7a5390eba@uscas1p1.samsung.com>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

DQpIZWxsbywNCg0KSSBhbSB3b3JraW5nIG9uIEpldHNvbiBOYW5vIGJvYXJkcy4gSSB3b3VsZCBs
aWtlIHRvIGNvbm5lY3QgdHdvIGJvYXJkcyB0b2dldGhlciB3aXRoIEFYMjAwIHdpZmkgbW9kdWxl
Lg0KT25lIGlzIGNvbmZpZ3VyZWQgaW4gaG9zdHNwb3QgbW9kZSBhbmQgdGhlIG90aGVyIG9uZSBp
cyB0aGUgY2xpZW50IGNvbm5lY3RlZCB0byB0aGUgaG9zdHNwb3QuDQoNCktlcm5lbCBWZXJzaW9u
OiA0LjkuMTQwLXRlZ3JhIGFhcmNoNjQNClVidW50dSBkaXN0cmlidXRpb246IEJpb25pYw0KVGhl
IGlkZWEgaXMgdG8gdXNlZCBob3N0YXBkIGFuZCB3cGFzdXBwbGljYW50IGRhZW1vbiB0byBzZXQg
dXAgdGhlIG1vZHVsZSBhbmQgY29ubmVjdCB0aGUgY2FyZCB0b2dldGhlci4NCldwYV9zdXBwbGlj
YW50IGFuZCBob3N0YXBkIHZlcnNpb24gVjIuNi4NCg0KSSBpbnN0YWxsIGFsbCB0aGUgZHJpdmVy
cyBmcm9tIGludGVsIGFuZCBmb2xsb3cgdGhpcyB0dXRvLiBodHRwczovL3dpZmkuaHlwZXJnZWVr
Lm5ldC95b3UtdG9vLWNhbi1oYXZlLWEtc3ViLTIwMC0xMWF4LWNsaWVudC8NClNvIEkgY2FuIHNl
ZSB0aGUgd2xhbiBwaHkgd2l0aCBpZmNvbmZpZyBjb21tYW5kIGxpbmUuDQpXaGVuIEkgdHJ5IHRv
IGxhdW5jaCBob3N0YXBkIGluIGF4IG1vZGUgd2l0aCB5b3VyIG1vZHVsZSBJIGhhdmUgdGhlIGZv
bGxvd2luZyBtaXN0YWtlLg0KQUNTOiBQb3NzaWJseSBjaGFubmVsIGNvbmZpZ3VyYXRpb24gaXMg
aW52YWxpZCwgcGxlYXNlIHJlcG9ydCB0aGlzIGFsb25nIHdpdGggeW91ciBjb25maWcgZmlsZS4g
QUNTOiBGYWlsZWQgdG8gc3RhcnQgd2xhbjA6IEFQLURJU0FCTEVEIGhvc3RhcGRfZnJlZV9oYXBk
X2RhdGE6IEludGVyZmFjZSB3bGFuMCB3YXNuJ3Qgc3RhcnRlZA0KDQpDb3VsZCB5b3UgaGVscCB0
byBzZXQgdXAgY29ycmVjdGx5IGhvc3RhcGQgPw0KDQpCZXN0IFJlZ2FyZHMNCg0KLS0NCkdlb2Zm
cm95IExFVE9VUk5FVVINCkVtYmVkZGVkIFNvZnR3YXJlIEVuZ2luZWVyLA0KU1NJQywgUGFyaXMN
Cg0KRW1haWw6IGcubGV0b3VybmV1ckBzYW1zdW5nLmNvbTxtYWlsdG86Zy5sZXRvdXJuZXVyQHNh
bXN1bmcuY29tPg0KVGVsOiArMzMgNiA0NSAxNCAyNCAzMg0KDQoNCg0K
