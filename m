Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1CBC740F27
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Jun 2023 12:47:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229861AbjF1Kr3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 28 Jun 2023 06:47:29 -0400
Received: from forward500b.mail.yandex.net ([178.154.239.144]:46778 "EHLO
        forward500b.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232021AbjF1Kpa (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 28 Jun 2023 06:45:30 -0400
Received: from mail-nwsmtp-smtp-production-main-19.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-19.sas.yp-c.yandex.net [IPv6:2a02:6b8:c14:4081:0:640:557:0])
        by forward500b.mail.yandex.net (Yandex) with ESMTP id 4EF805EDFA;
        Wed, 28 Jun 2023 13:45:27 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-19.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id QjJQlZ8WtmI0-b9khKQuZ;
        Wed, 28 Jun 2023 13:45:26 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1687949126;
        bh=jhSJJwLypBMG4fycLn+e2MXPHfurYPB+9rN6izzluGk=;
        h=Subject:From:In-Reply-To:Cc:Date:References:To:Message-ID;
        b=BV2BNtmEVpMI4P6sTvqVIaNoXFxukqmCm7KuVLwG5wx6X29lawDYcLRTuuurjNCwG
         aR5pw3Hc496qfFouJhj9qrCP+MllLml1AH5Xed51g04n02DjC+CHbgQ5cEOn7380qC
         uGw9JuiZKbxL/eYXxxLyzxFt1iiWKuG14zZ0ZIEM=
Authentication-Results: mail-nwsmtp-smtp-production-main-19.sas.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
Message-ID: <4482488b-35d8-a2e8-259b-0a39ddffecba@yandex.ru>
Date:   Wed, 28 Jun 2023 13:45:26 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Content-Language: en-US
To:     David Laight <David.Laight@ACULAB.COM>,
        Larry Finger <Larry.Finger@lwfinger.net>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Kalle Valo <kvalo@kernel.org>,
        Jonas Gorski <jonas.gorski@gmail.com>,
        "lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
References: <ef4750f8-8de5-dbfc-2c0b-3400d30d83e5@lwfinger.net>
 <20230627151411.92749-1-dmantipov@yandex.ru>
 <d0825edd2a3c4bbba72685340f547c9e@AcuMS.aculab.com>
From:   Dmitry Antipov <dmantipov@yandex.ru>
Subject: Re: [PATCH] [v2] wifi: b43: fix cordic arithmetic
In-Reply-To: <d0825edd2a3c4bbba72685340f547c9e@AcuMS.aculab.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

T24gNi8yOC8yMyAxMToyNCwgRGF2aWQgTGFpZ2h0IHdyb3RlOg0KDQo+IFdoYXQgYXJlIHRo
ZSAodTE2KSBjYXN0cyBmb3I/DQoNCldlbGwsIHRoaXMgaXMgYSBraW5kIG9mIGEgQyBsYW5n
dWFnZSBwdXJpc20gaW50ZW5kZWQgdG8gc2lsZW5jZQ0KDQp3YXJuaW5nOiBjb252ZXJzaW9u
IGZyb20g4oCYaW504oCZIHRvIOKAmHUxNuKAmSB7YWthIOKAmHNob3J0IHVuc2lnbmVkIGlu
dOKAmX0gbWF5IGNoYW5nZSB2YWx1ZSBbLVdjb252ZXJzaW9uXQ0KDQpvYnNlcnZlZCB3aXRo
IFc9MTIzLg0KDQpEbWl0cnkNCg0K
