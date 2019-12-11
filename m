Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 966D711A8F0
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Dec 2019 11:31:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728912AbfLKKb0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 11 Dec 2019 05:31:26 -0500
Received: from mout.kundenserver.de ([212.227.17.13]:40211 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728881AbfLKKb0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 11 Dec 2019 05:31:26 -0500
Received: from [192.168.0.66] ([92.154.77.116]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.184]) with ESMTPSA (Nemesis) id
 1MFbiK-1iVhCA3rhO-00H89i; Wed, 11 Dec 2019 11:31:20 +0100
To:     =?UTF-8?Q?Krzysztof_Ha=c5=82asa?= <khalasa@piap.pl>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org, Kalle Valo <kvalo@codeaurora.org>
References: <m34l02mh71.fsf@t19.piap.pl>
 <20191209102808.12014-1-nicolas.cavallari@green-communications.fr>
 <m3h827jqlv.fsf@t19.piap.pl>
From:   Nicolas Cavallari <Nicolas.Cavallari@green-communications.fr>
Autocrypt: addr=Nicolas.Cavallari@green-communications.fr;
 prefer-encrypt=mutual; keydata=
 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
Subject: Re: [RFC] Allow userspace to reset IBSS stations to fix aggregation
 issue
Message-ID: <f698d508-3d19-1be1-0425-0b2d9f402728@green-communications.fr>
Date:   Wed, 11 Dec 2019 11:31:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <m3h827jqlv.fsf@t19.piap.pl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:eNgjHt9MuyC5DHdXH/cFhVezykmN0/QrxPPDZmjjeEJ/ER3EsBE
 /WDKjDzUltsHGBbdURxMplWcNbyrx5TUx8Ag7+EVGS5fPOZqIi9r/qqKfEZOar004LKP1wg
 L8tp5OdzV4eKCjvKx7dw1bLFSCrSvmlgdlVnHAStwqmnl3SUld+i9cWWzSToVU5j2Yzt9wc
 mFtSJqUhrNkknMQNDRRng==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:700d5iOhG6g=:ZSEjc3KUimfS3tiOdGjXGL
 VNjoSG4y4t54pItij1IwoVJwHoXYuiUkte1cp0PA009GDM+7zl3LboiMzi1pBU0UW2XOOVbq+
 wQKL+Dk8i/GvDcDXqqnVprjg+kbm9jbDvkjIbCOpXeYTh0EoObDUW6EEuwQIgmK+WqcLxPZmP
 OKjOWDDRrDBBD0ylFzUKzaq33t8CX4fdNwzOP5OLa7CxHLkRLT71aSVUQYDN1HaNsdmZVFf/D
 eVQda4xpbdn8u83GwoX8f2c5JxgNXzgKP2Lf1VccUnX3JJlgAtpEqnFa+m4Y2GJVpCSPaHq/f
 PafDC+2nOz+Sp+T2v5gShfBa68panxQEZ/vtPcR7rMQWQpJekFkPJBl/fKGRBl+03e4zfDDzO
 +nXlF11MmX/e0QU4YKhEVsvpYXB+CMHYp/Q0kc8vcvE3Vzq7oZ0W3HKdDPVPMwufgZgDucuwk
 nbZI3OWFC1Dbqo7o6gX42IDyOdi0X3xo/qspbBvk6RyqeYVUT/rVrzzfnmBWgtjEYfROwc4DY
 EjlNeXQaVwRuadZivAn+v/H8zCDCZGX/qH4mJSlGrTCkwiEU499BywkaLTffYY4k3GNV2Jw6l
 FV8Ry1duVu6PbLpbGNAwY4HZCHNgrafkY4QUqarbe6IcelIMYV6JaptYlebOuCBB+17V/FarX
 r8avjkSQgfX3gU9ou3yYR5gu0y795bBNKo8s7qTw5WxAi52i2gWJ1n+pqPMYjEFg51/p7bdEN
 HzR3NTauIL31BlB55ZcioJrP78YLLxr2uK75bV27anlGrs7ahRXC8yF58SAU1WTTb2/0jHs4G
 g2McLZzL4le6MFxMuwJ4Szjd95IdH1dJH35NNihNLRzeRE1p2Fy1dec6tv//wK+8rc0KqTdYE
 HVItx3EJXEaYGFvIvfKHH6erp1X14LW1k3ELvZDIjUlqIdJ7ZDX/DRf3aDJtH6
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Krzysztof,

On 11/12/2019 07:58, Krzysztof Hałasa wrote:
> Hi Nicolas,
> 
> Just to make sure everybody is aware that it would only be a partial fix
> - unencrypted ad hoc mode (the simplest thing available) doesn't need
> any userspace and thus must be fixed in the kernel. Alternatively this
> functionality may be moved to wpa_supplicant and only then userspace fix
> could really fix it completely.

A partial fix is better than no fix.

In any case, the IBSS-RSN and unencrypted IBSS cannot be fixed the same way.
Having the kernel automatically reset a station while wpa_supplicant may have
started a 4 way handshake with it had already lead to problems in the past.
Which is why the kernel no longer reset stations (52874a5e).

In any case, the unencrypted ibss case is probably much harder to fix, since
even in a linux-only world, there are probably fullmac drivers for hardware that
don't reply to open system auth in an open ibss. Anyway, this patch allows
userspace to fix it, using whatever policy the user chooses to detect it.
