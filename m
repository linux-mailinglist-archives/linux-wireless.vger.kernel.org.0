Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40B0023343D
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Jul 2020 16:23:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728306AbgG3OXr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 30 Jul 2020 10:23:47 -0400
Received: from mail-eopbgr10051.outbound.protection.outlook.com ([40.107.1.51]:27142
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727776AbgG3OXq (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 30 Jul 2020 10:23:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WMcvxjLgCFAMpjJmapQvCYSyYx6Twep5uw25MEOX/+QElFQYcoTIu/8mz0gtj4vE+7yxzYVuyE3uO2OFx3TGdFz7TcrRjINm4DUqdSoHu3h9y5Hvc0pSAH1ToEurYOsdEWtBs6o3H0Hf1Ms4EbFzZ79focBOJtE7C1iPGM11ygo0u6mg0q7eBRULYj8e0UJAjbhwbNfkulkchYR0ZkWnMZG/Kg//6nzcaoCGaC3X4B+crVgDOC9K6ciOcXK9osmTollv4cE7SCqjVMITYBWF3YfRo+oRlgQJ5vR/04nQvd/lVm6H7rhOIu5EeI8AslWqE1JhicsRQwwVdHGcw87V7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OraqVwuxCKo3o4yoqiEn6lPe8OQDmJzb0ZbzzO/XIjA=;
 b=Rv/azhmUpOl7TL/T+Y/qi9acRGkxldztr2gwa5hnmoSfQdo0qFEWbZ5izIGGB14xIRzbFbJJs39pRYVpnml7XUinzpbkqwf4Fpkab6QyQur1FobnynTLVZXxGRK0A11apx71L3iFN4At2K4gtJiEaCJg+D4auyfBRmcusjXFRgOTMCeQtwd008khxbjmKwFAIj8i3vXg7Pc5cjz3UXaOQqRB3VIZck260oFv2jCLZO9rM9DR5IHW0UZylu40NzbytPQrQGH1AAs00/iD3C42tTaznS8/CEB6YxrU38ideGTNJOjksmovPjAEPLUROUJgyZa7Q+d2wXx21NjuTYmOVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OraqVwuxCKo3o4yoqiEn6lPe8OQDmJzb0ZbzzO/XIjA=;
 b=l74bhI8EExcp/Ij40zRLBTO/xgbh1z+J4pndvINiowG57Iu45orJCcmVA55+BxlXxYnWwsmqBT32Gu6hAm1C2WVLQUS795XhCBmJiDTmiQRsjGbQ7HnYoT5CGIPXS86EZ/q+irOggsccqioQFNcjHjh8AwWuN5CmpUHdCCsPZ+Y=
Received: from AM0P192MB0468.EURP192.PROD.OUTLOOK.COM (2603:10a6:208:45::15)
 by AM8P192MB0931.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:1ea::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.16; Thu, 30 Jul
 2020 14:23:42 +0000
Received: from AM0P192MB0468.EURP192.PROD.OUTLOOK.COM
 ([fe80::5cae:415:1979:1de1]) by AM0P192MB0468.EURP192.PROD.OUTLOOK.COM
 ([fe80::5cae:415:1979:1de1%5]) with mapi id 15.20.3216.034; Thu, 30 Jul 2020
 14:23:42 +0000
From:   Shay Bar <Shay.Bar@celeno.com>
To:     Johannes Berg <johannes@sipsolutions.net>,
        Ben Greear <greearb@candelatech.com>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH] mac80211: Send deauth to STA's upon AP stop
Thread-Topic: [PATCH] mac80211: Send deauth to STA's upon AP stop
Thread-Index: AQHWRVPx7SBnzBH8kkanFbiH9ch/Pw==
Date:   Thu, 30 Jul 2020 14:23:42 +0000
Message-ID: <AM0P192MB0468715C6F76AFD51938CC55E7710@AM0P192MB0468.EURP192.PROD.OUTLOOK.COM>
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
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: sipsolutions.net; dkim=none (message not signed)
 header.d=none;sipsolutions.net; dmarc=none action=none
 header.from=celeno.com;
x-originating-ip: [87.68.129.154]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ca0d5675-bd5b-4e61-7754-08d83494295b
x-ms-traffictypediagnostic: AM8P192MB0931:
x-microsoft-antispam-prvs: <AM8P192MB09310374D0EBD1466A341944E7710@AM8P192MB0931.EURP192.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nOYsA6aazdLZQQtKf9xB4TVR/E1lFRn/pCv/pD0BimpzJKUM1c4BvQ6dpdPvac/YBAsWrqi+O7LPT30k0aXFi77mHNjkU6htH3NE/zHrPa5aoeGGILyqyBI+THRBrlZ1Y9TD2dsJowlsrBm7IjtHeLM3VoegDaqFLKMJgsEYkOVZHGmd7I+NxApOQdtlrUh48adScVumBuVmJMUTMDWphAid3fE7UWK5+Nemn42Gvmp5/KmMzpNmeZRgay11axU67MB/m+Gn+O3IcVp+gCPWuGU5b5yjt6KaQYKSBjpHCpivW4d0DlIwztaMo2rFEgKwk7e6KOriYLzr6NIpD/q/rw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0P192MB0468.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFTY:;SFS:(366004)(376002)(136003)(346002)(396003)(39840400004)(33656002)(71200400001)(52536014)(66946007)(76116006)(66476007)(5660300002)(66556008)(64756008)(66446008)(316002)(110136005)(53546011)(6506007)(26005)(186003)(7696005)(83380400001)(55016002)(86362001)(9686003)(8676002)(4326008)(2906002)(478600001)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: cHEuGHrQnNqnL8DSYeHDdpUVbZA52w17haMt3zxn52Fr+NFHanefvnGwGE60RCd9OWRsXIzpiIvi2nz1fA3yvZff1dZ+gDDU+Z0y5WsY5XExVdNuVC0hmB4zYetJM+WHVsY6TOn0nVHPr6D8RMbd/2coOWsRSt5jIy9Y10lFoui7Hn/8o7HPKhQkam7J76NcjaDrAUdpPKQro5wIR5P9UIEjjk7Xw3istRPv64zOYjcSsb3Ct2RnPatsb9BG8O88Jrct5JRL9Cluek5rmndYjWh5arpflv7AQiULv9zzszJGn2exTsxu/LRfMifGHg/C/UZWPT57AzFHLYo2zSX3Z6fxQBGDUAW7QcXRXcdPs9A2XqkgF53Oo+xFfPX1j3DFQEo4D8iJyNBasrCvVlALNNn/vo/h5Bq91FJqQh7N5sgBAn+YuWK4OOHZ4irhW3jT/We5Wbib7cxlP4HCoehhtF3u5jiG16yjBl4L4c1HldVxPvvsB11X2GUlyeoINfRCuUR4g0XP93mGw9HA1j55fTko2bjNpvZnnt+sR5dxCDmajrofAYfdIJZTAXmxEh53059/hxnl04cLqOVT0oyR6JnppitN7ImaJCPpES5S7P9gdBv4uvPvos/WVWL3jiy93eO5rX1WRr5LCkxQkNDH4Q==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0P192MB0468.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: ca0d5675-bd5b-4e61-7754-08d83494295b
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jul 2020 14:23:42.5150
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: d0pppnubNCi4Td3isdfaAKN5oByHhal8Aq/D0NUf6DJ7CDe1wRt+zoSYNk0WezDDOxkTAjn5LiFF+wyGo5asRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8P192MB0931
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 30/07/2020 17:00, Johannes Berg wrote:
> External Email
>
>
> On Thu, 2020-06-25 at 13:29 +0300, Shay Bar wrote:
>> On 25/06/2020 12:51, Johannes Berg wrote:
>>> External Email
>>>
>>>
>>> On Sun, 2020-06-21 at 10:12 +0000, Shay Bar wrote:
>>>> Hi Johannes and Ben,
>>>>
>>>> To conclude this thread, hostapd doesn=92t send any deauth/disassoc
>>>> upon AP stop (when hostapd is killed _or_ when "ifconfig down" the
>>>> AP interface).
>>> Right. I'm sort of suggesting you just shouldn't be doing this, and it
>>> doesn't seem like most people actually do, otherwise we'd have seen thi=
s
>>> issue before?
>>>
>> I shouldn't kill hostapd? Isn't this a very basic action?
>> What is the alternative for stopping the AP?
> I guess I would say to use hostapd_cli first to "disable" the
> interfaces?

Indeed, using hostapd_cli "DISABLE" will call hostapd_flush_old_stations() =
that will send broadcast deauth.
The problem is (mentioned before) that some stations (e.g. Samsung S8) igno=
re this broadcast (while it will not ignore unicast deauth/disassoc).

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

