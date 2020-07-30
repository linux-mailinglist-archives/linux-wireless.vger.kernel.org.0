Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 248892334B4
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Jul 2020 16:45:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728337AbgG3Opd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 30 Jul 2020 10:45:33 -0400
Received: from mail-eopbgr30084.outbound.protection.outlook.com ([40.107.3.84]:54149
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726275AbgG3Opd (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 30 Jul 2020 10:45:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dv7FpE9Aktk79JdmT9V7JYVesSnnuIBXqtixkyfvd8abFkqw07xZa64n6OKOeq4bmtYVy/EqVjl4vlrEZJ+/77XXD8AQfI6DtRILATCg9PqQZKcQbhZtjhvAZ9IhaH2qf9TVn3t1CAJmSjtiYoNpyYQoBS+PNijBKxONSdWwH3wtrONTIkckxlOHnDGr0vYagrQ6cBbKbG3TvnSW2c9oXZZLMwaATPkvOtUa5+Xh1gCbgKf6X9luqXKVisiJG/ebtP9hddwOt5bhXENG6f1EH5frNhso5UvIEJBHVMBhRiEaCYwOhvPthTGCfvSG4sQHFoKhCDxRFzpZqoBnshCiRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Y63UN12SAPcFYRowP7/Kw4YN8+Zp/uPLOBUdfkPfM4=;
 b=FccIJHzdo7AF3KvtJ9y55gEhHto8SiZFksLcmxxyyv9GwPkJJCXXSYsx1AZoDRnqb9/2ydbpRhfBl3L9GTBHH0g6ZOAuTFin4O8rmDJYnSpGtX/b2Rx/pbennsE3+MHRleILVBB+Rw4nrEjnQ8sxpKykgrBoJ25a6u2p/rOI7uxLcVu9PY4uPCBVjYKmxQd8ZI8/Px4uc/6MSjKhIrxs2VtJYXVa5P/ONJ81r5/Zrv0P0DzswtT1FxqrZQCB7iK8X9npYWk35c00XURnFxPvye0C3HBReVCmsaG8dw1JNUQ3nEP1/hWNjc9dFM8D1YS4ql5fUIiUgBh7r9AZA/iDDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Y63UN12SAPcFYRowP7/Kw4YN8+Zp/uPLOBUdfkPfM4=;
 b=zUQb7ed40IeSumobtV3NlmJMNEM1TAc/3dP2Nxqir0VcMy21Hu1X7uRyAeapLJbyWef0JMCWIG2Vc/TCyCHFH6bmrf5Hx8JE6WPGA3xniaETcDjkcKcAVpHsob/xeA12X3TYUZN3aXAMYSnCjDnbCazJkhW3ilLhYYLHI2SKRIo=
Received: from AM0P192MB0468.EURP192.PROD.OUTLOOK.COM (2603:10a6:208:45::15)
 by AM9P192MB0949.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:1f8::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.17; Thu, 30 Jul
 2020 14:45:29 +0000
Received: from AM0P192MB0468.EURP192.PROD.OUTLOOK.COM
 ([fe80::5cae:415:1979:1de1]) by AM0P192MB0468.EURP192.PROD.OUTLOOK.COM
 ([fe80::5cae:415:1979:1de1%5]) with mapi id 15.20.3216.034; Thu, 30 Jul 2020
 14:45:29 +0000
From:   Shay Bar <Shay.Bar@celeno.com>
To:     Johannes Berg <johannes@sipsolutions.net>,
        Ben Greear <greearb@candelatech.com>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH] mac80211: Send deauth to STA's upon AP stop
Thread-Topic: [PATCH] mac80211: Send deauth to STA's upon AP stop
Thread-Index: AQHWRVPx7SBnzBH8kkanFbiH9ch/Pw==
Date:   Thu, 30 Jul 2020 14:45:29 +0000
Message-ID: <AM0P192MB0468EDA5B2AB3F8F16FE68C6E7710@AM0P192MB0468.EURP192.PROD.OUTLOOK.COM>
References: <20200618093609.16514-1-shay.bar@celeno.com>
 <d57c8bf64d6ea2e3f7355c2f7ca9b376db7fe21c.camel@sipsolutions.net>
 <AM0P192MB04682E48D814F5F6CAFBF9CAE79B0@AM0P192MB0468.EURP192.PROD.OUTLOOK.COM>
 <2a7b33ace030fdeda96e60b2abd6c70a11f426e0.camel@sipsolutions.net>
 <AM0P192MB0468CA3DA7C8EC62366AC04AE79B0@AM0P192MB0468.EURP192.PROD.OUTLOOK.COM>
 <54236bdd708c53ec2f2a776bb3badcd77c7fecc6.camel@sipsolutions.net>
 <AM0P192MB046896A59F91F976EE7AB287E79B0@AM0P192MB0468.EURP192.PROD.OUTLOOK.COM>
 <6da8757ac90a4d34ed1bdc7c84b40aac06c01af9.camel@sipsolutions.net>
 <f0b038b4-fbd8-0b9b-2c2e-6337f0d408ea@candelatech.com>
 <AM0P192MB0468ED699FC0BE6431812B03E7960@AM0P192MB0468.EURP192.PROD.OUTLOOK.COM>
 <2a607392179a76f0f6fc3cef2e6e141f25dc0254.camel@sipsolutions.net>
 <90ea9478-a42e-be89-0ee1-9e05c2ef8cc9@celeno.com>
 <5bee074dbf19ab71e3cdc90769dbec0c8ada5274.camel@sipsolutions.net>
 <AM0P192MB0468715C6F76AFD51938CC55E7710@AM0P192MB0468.EURP192.PROD.OUTLOOK.COM>
 <903ec27f7423574f644312c701ed45fdafdb7ca6.camel@sipsolutions.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: sipsolutions.net; dkim=none (message not signed)
 header.d=none;sipsolutions.net; dmarc=none action=none
 header.from=celeno.com;
x-originating-ip: [87.68.129.154]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0ba57467-9323-40af-70e7-08d834973459
x-ms-traffictypediagnostic: AM9P192MB0949:
x-microsoft-antispam-prvs: <AM9P192MB094960A5106870AECA43DA4BE7710@AM9P192MB0949.EURP192.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JlGZpEzo5nYx4CsihhcCtO3hAyAQLrizX5HtmoHz+vVm9hmqRjkUJf/PGZt3bNJlw+VCZZSjEfy/m5BfrQgmOn+W0J2fHdWoOee0QXdujSkUdKj0dWlfdXcBHs9l4hcmWgdfeBPaV1QAWW5C2pZYYz8OMuuiX7JadRa8aXcAQrJ5ux8J4S7nzeJonwFg7k/BPCfwTL+z7pdoGGLHRBohRcdlkBW9EYwgTANCauArdOwhAON2C9ZvfXlw18lHT2OVM9R7rdlMH6DchPOxHcpzjYeAoUmbHEsXX86lPS/6TO3ddtxICwDj2YLIpoVQQux72x50/7vaqBuO1WpDGKwUlw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0P192MB0468.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFTY:;SFS:(396003)(346002)(136003)(39840400004)(366004)(376002)(5660300002)(55016002)(86362001)(66476007)(26005)(52536014)(91956017)(76116006)(6506007)(64756008)(66946007)(53546011)(66556008)(7696005)(9686003)(2906002)(186003)(66446008)(478600001)(8936002)(110136005)(8676002)(33656002)(83380400001)(4326008)(71200400001)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: vBdATtRYYcu3463ej07Xeirmr8lH32ZpDXCrQXbx2FrIOAabvb4WQg62mr+lBupFqcZWot/wHuYTagicQtz2FNToxHQwUs3fT7feD4oUmd/SJnDujDdMk6QHYZRTiyEuSR4D8Id7fAdhOO6JzcN8zUDe7gnoXFYx4SJEpGIykApf2qhf2PrTgePd8aQRmB1Z8LFllTSbj58RDB9eg1/Z4yKY4qxAsdiA37zCfqeLHBxQoBDcuCnD8ooLF8mpF6ncGG+kh008X3JsLML94BXNG/F5g7QQQKd6hn8GPerGPygBaQhfpl9AHmk9jsxJibOoa2zLPv80gQKhmx2AmfVhwIcEqBe04ktuc+B/23F5cwvfXGTeTjJ87i9wTSHPfvzWSa7cXIUrdRh3oisrLEY3JkocT2zRmqFBiz3xko943PehcZ+kC6GcyVpnGQVW45Yc/dovhMnp6pJvhilL33YsHrEhbf/cltiGLR6n3XZYzt6wmM5dXo6n2v539CX8z59wN7aowubuSY7ejf+ZqKZW7Kv5ZtqGueunDbhLxg3LECxZ3dD/N2v/xbyJvRj/twmeoTmKWI5p9EjGYl358VITI0atmrAdhmglW8jpHd1jxiUmDmAMnQRim6sAX921Iiy7VCQ65VfXmt2wzpEebQcNRw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0P192MB0468.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ba57467-9323-40af-70e7-08d834973459
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jul 2020 14:45:29.4658
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UHipdeZVrzJUUpxWa4okYIC2EZyi7zKjRtRyoGBnc0dbRGECbXpPP2dnKqYn0PzvgYFd8hO+GSs2xLznby7TFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P192MB0949
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 30/07/2020 17:28, Johannes Berg wrote:
> External Email
>
>
> On Thu, 2020-07-30 at 14:23 +0000, Shay Bar wrote:
>> On 30/07/2020 17:00, Johannes Berg wrote:
>>> External Email
>>>
>>>
>>> On Thu, 2020-06-25 at 13:29 +0300, Shay Bar wrote:
>>>> On 25/06/2020 12:51, Johannes Berg wrote:
>>>>> External Email
>>>>>
>>>>>
>>>>> On Sun, 2020-06-21 at 10:12 +0000, Shay Bar wrote:
>>>>>> Hi Johannes and Ben,
>>>>>>
>>>>>> To conclude this thread, hostapd doesn=92t send any deauth/disassoc
>>>>>> upon AP stop (when hostapd is killed _or_ when "ifconfig down" the
>>>>>> AP interface).
>>>>> Right. I'm sort of suggesting you just shouldn't be doing this, and i=
t
>>>>> doesn't seem like most people actually do, otherwise we'd have seen t=
his
>>>>> issue before?
>>>>>
>>>> I shouldn't kill hostapd? Isn't this a very basic action?
>>>> What is the alternative for stopping the AP?
>>> I guess I would say to use hostapd_cli first to "disable" the
>>> interfaces?
>> Indeed, using hostapd_cli "DISABLE" will call
>> hostapd_flush_old_stations() that will send broadcast deauth.
> Ah.
>
>> The problem is (mentioned before) that some stations (e.g. Samsung S8)
>> ignore this broadcast (while it will not ignore unicast
>> deauth/disassoc).
> Right, you mentioned that. I guess you could work around by disabling
> all stations separately, but ... not really a great solution either.
>
> Perhaps we should fix that at the hostapd level?
>
> Not really sure how much trouble we should go to for bad stations
> though. I mean, it's not like they should be ignoring that.
>
> Maybe they just miss it due to super aggressive powersave, and we should
> send it a few times?

Power save is possible.
I will try sending it 3 times (instead of only 1) and see if it helps.
Anyway, I agree we should not put extra effort for STA's that ignore this b=
cast,
Lets discard this patch.

Thanks.

________________________________
The information transmitted is intended only for the person or entity to wh=
ich it is addressed and may contain confidential and/or privileged material=
. Any retransmission, dissemination, copying or other use of, or taking of =
any action in reliance upon this information is prohibited. If you received=
 this in error, please contact the sender and delete the material from any =
computer. Nothing contained herein shall be deemed as a representation, war=
ranty or a commitment by Celeno. No warranties are expressed or implied, in=
cluding, but not limited to, any implied warranties of non-infringement, me=
rchantability and fitness for a particular purpose.
________________________________

