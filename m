Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0607C78550E
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Aug 2023 12:14:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233966AbjHWKN4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 23 Aug 2023 06:13:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233445AbjHWKNb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 23 Aug 2023 06:13:31 -0400
Received: from mail03.softline.ru (mail03.softline.ru [185.31.132.229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5F55199C
        for <linux-wireless@vger.kernel.org>; Wed, 23 Aug 2023 03:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=softline.com;
        s=relay; t=1692785582;
        bh=ho5GwbroPrqdyAO5X5qAzdsCtznJL8BYTYk6DLlts2k=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=TwsS13qUU9otzSgJvjCs9MyQ5/ZNEdS5k5D9AprS5dR7fkxEfOMfPQHizjOteUHa/
         1qKPI1uWrKqWvlN443F/F1wp1ODB0yX2OjDAyvZ8rQPAMjvsxDwT0Wip0Ms68GD2lq
         3Vfb/t1Hq8EOUOn4Hx1/+puZCPHK97riwLuIr/3NdIP1uRYFjNsE/WTFhMJVLZLudH
         Bm4SoZn9kfiZPchsPxCaGQLUWtkRkk7eroGvTIam9/dMjFph21r2IT7zXfywvnTbdO
         JJodgg6Y28MraATGEBfahagVTaZnKCkAtmFBI2/8DJH75g/jhgjoYGThF2z+s4icgw
         O+rLm5yPh+UTw==
X-AuditID: 0a02150b-b29a1700000026cc-28-64e5dbaecb73
From:   "Antipov, Dmitriy" <Dmitriy.Antipov@softline.com>
To:     "khoroshilov@ispras.ru" <khoroshilov@ispras.ru>,
        "dmantipov@yandex.ru" <dmantipov@yandex.ru>,
        "quic_jjohnson@quicinc.com" <quic_jjohnson@quicinc.com>
CC:     "kvalo@kernel.org" <kvalo@kernel.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "ath10k@lists.infradead.org" <ath10k@lists.infradead.org>,
        "lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>
Subject: Re: [lvc-project] [PATCH] [v2] wifi: ath10k: cleanup CE
 initialization
Thread-Topic: [lvc-project] [PATCH] [v2] wifi: ath10k: cleanup CE
 initialization
Thread-Index: AQHZ1ac/rdoMqZkRDE2ght1O8khBXK/3dGaAgAACzIA=
Date:   Wed, 23 Aug 2023 10:13:01 +0000
Message-ID: <0eed7a68c03555cc815959b9fa32b37657f8aeda.camel@softline.com>
References: <20230823095008.50515-1-dmantipov@yandex.ru>
         <fb14be76-c3af-8ede-38aa-8b88f3cea7b7@ispras.ru>
In-Reply-To: <fb14be76-c3af-8ede-38aa-8b88f3cea7b7@ispras.ru>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: text/plain; charset="utf-8"
Content-ID: <A1B4236430DD94448C63B917F4606D6D@softline.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

T24gV2VkLCAyMDIzLTA4LTIzIGF0IDEzOjAzICswMzAwLCBBbGV4ZXkgS2hvcm9zaGlsb3Ygd3Jv
dGU6DQoNCj4gPiB2MjogYWRqdXN0IHRvIG1hdGNoIHNlcmllcw0KPiANCj4gRG8gbWVhbiB0aGF0
IG5vdGhpbmcgaGFzIGJlZW4gY2hhbmdlZCBpbiB0aGUgcGF0Y2ggcmVnYXJkaW5nIHRoZQ0KPiBw
cmV2aW91cyB2ZXJzaW9uPw0KDQpVc3VhbGx5IGl0IGlzLCBpbmNsdWRpbmcgdGhlIGNhc2VzIHdo
ZXJlIHNvbWUgcGF0Y2ggb2YgdGhlIHNlcmllcw0KaXMgY2hhbmdlZCBzbyB0aGUgZm9sbG93aW5n
IG9uZXMgYXJlIGFwcGxpZWQgd2l0aCBvZmZzZXRzIGFuZCB0aHVzDQpiZXR0ZXIgdG8gYmUgcmVn
ZW5lcmF0ZWQuDQoNCkFuZCBzaG91bGQgc2F5IHNvcnJ5IGZvciBhbiBpbmNvbnNpc3RlbnQgdGl0
bGUgb2YgdGhlIGZpcnN0IG9uZS4NCg0KRG1pdHJ5DQoNCg==
