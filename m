Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 934727D071B
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Oct 2023 05:48:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376272AbjJTDsN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 19 Oct 2023 23:48:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346903AbjJTDsM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 19 Oct 2023 23:48:12 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2079.outbound.protection.outlook.com [40.107.15.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3C3F1A4;
        Thu, 19 Oct 2023 20:48:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K4OcmlEXehAVkgFqndsMG6Q7JhbFEgmUndvtE26crV7STcZjCGFn5J0el1UBnOPXLsuJYkt2iITmZg2Y6cRFuDxfvSbbV8J5Mp7geuLHtQEkLAkShqE5jOymllH2exb1gT/jLrA5YEhQaGVj7iFYSybs7uu9OLNllw15SkJobQcS/9MN0NkVznQXQSK0Ydgv8OKJ9tQW0QxH3BW7guLKEcYtamjkTzwvAF0SBQxUI5z1RXaRLxrkoH/NhGIKaSsgDBStacXv+/EdKkAQ0xviDCjIyzb17mGcZEZgmTcaAaERMKVjvC/qxUS00smfJZSNUG5DDaDfqq8rfgJO5+Zp/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nW+qYk9QlDu79s+dWSyncXMFDc0yDEgxPID3vXHCHCA=;
 b=fBf8uQXoHVPqHMrkAcMhxQ1r3ZGkQzzUU5IxPplCauUW4a7gaMUbdUacKDBG7U8p82Al3nIdSCIdDAAiRQ/AUdWIgus+7ilEO1tYyH4kysiAWHAMINKr2qSe6gW0UP0Icylee2OWvwAJ5NTbyOB0k7TTr6OFl9+/j0W1rLiIXJmnwj55EQvwDvJtuCvGdqtewjekW0AnzTGm39sj3ItID283Wlo5RRkpcPODYgAUt21DEKzgsyG/dv8mRSbGXPi51lOTHifQtQTBAWkdmeWjV43TesICaseYxmIDAwh/+TSPyvW0DEvyy091uuwznU0WElarsbP+FZIOrurwEQYXMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nW+qYk9QlDu79s+dWSyncXMFDc0yDEgxPID3vXHCHCA=;
 b=UU0p8760r1o0ws7igIq5lPRz2FqKtL707HSDuDxCoTLeCvzJzol7ojiLYDuDKJoXjtaxYrLokllb/XsV/36sb13DG8jR2lVCOtIY/n/D5Wq1D5D4HWG1n5PeocSNEsZTzeKq95QQUz+1L2Mh9rfToojeo9kgxBjMHNQx2UJ6cxU=
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by VI1PR04MB7069.eurprd04.prod.outlook.com (2603:10a6:800:127::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.11; Fri, 20 Oct
 2023 03:48:07 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::34dd:289e:9e8b:9c9b]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::34dd:289e:9e8b:9c9b%7]) with mapi id 15.20.6933.011; Fri, 20 Oct 2023
 03:48:07 +0000
Content-Type: multipart/mixed;
        boundary="_000_PA4PR04MB96388A628D6AB8359D3DAAD0D1DBAPA4PR04MB9638eurp_"
From:   David Lin <yu-hao.lin@nxp.com>
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "briannorris@chromium.org" <briannorris@chromium.org>,
        "kvalo@kernel.org" <kvalo@kernel.org>,
        "francesco@dolcini.it" <francesco@dolcini.it>,
        Sharvari Harisangam <sharvari.harisangam@nxp.com>,
        David Lin <yu-hao.lin@nxp.com>,
        Pete Hsieh <tsung-hsien.hsieh@nxp.com>
Subject: [PATCH v6 0/6] wifi: mwifiex: added code to support host mlme. 
Thread-Topic: [PATCH v6 0/6] wifi: mwifiex: added code to support host mlme. 
Thread-Index: AdoDCDtnHg9WHjidSq6kmhUFkN75Gg==
Date:   Fri, 20 Oct 2023 03:48:06 +0000
Message-ID: <PA4PR04MB96388A628D6AB8359D3DAAD0D1DBA@PA4PR04MB9638.eurprd04.prod.outlook.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: <PA4PR04MB96388A628D6AB8359D3DAAD0D1DBA@PA4PR04MB9638.eurprd04.prod.outlook.com>
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR04MB9638:EE_|VI1PR04MB7069:EE_
x-ms-office365-filtering-correlation-id: e4ab9d19-20e3-4fa8-ae89-08dbd11f5ef9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: brCWPGPyXdJmOpn8wj4BAHsNhEOKHelrdFu5IIREEU1iyDHArL1QlQAgVNmMSnWKVDGAKVbvRKJPpDqJCFc1+NEH9MTpNj4dQL0UOV8aKzzFBXTDuRkR1zI+3EBzbUhyebTC+j8bNJdzDpip3fuM0EETQdJJ/rvUpYIIbAcDjBeIFbSc99B+SGpR2pcdt4C6cfkQc7Oh0Ro3O+C3Fc6XjsH4aFcSq4n6vT1fzQYYqI/Hc1Qnwwp2m8laAU5h6dy6H7O0CLOLw4XZmOY1/KB/d+Jux5sbQ0wnKbJI3rNScL5jKhLUUXJnsnC6nPihT2/BO0N8rVWu73e36g29f5WxtswnTGnWhmTPy08+Gl0RYEPa0cwA0A2iTWJf8hHdUMxV5egSeE5byldSMyx0YiVKHmrbupzBCv64Vz/eddjRE59cwqRbmsLyA5esCi2WRHnY+cgHpuINelfZmL7HkivpMG9f4lqWBFagVWNMb2SoZIayAm/81d+AAKhBCb/mxBiTy4mk2Lh4nT38l2rnFYAtFljQv9TH/yzVp2j0nSG/Fq9PpIy4AnrwHvICov1rmoRwkmKt09L6xHRubb27iidjGAC6Ynz3bQRXVH05hMhQTINLlBsyeWtHvBxB5yyM51Hb
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(136003)(376002)(39860400002)(346002)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(55016003)(38100700002)(41300700001)(4326008)(5660300002)(8676002)(8936002)(52536014)(86362001)(33656002)(2906002)(122000001)(478600001)(83380400001)(9686003)(4743002)(7696005)(26005)(71200400001)(6506007)(316002)(38070700009)(66946007)(76116006)(54906003)(66476007)(6916009)(66446008)(64756008)(66556008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?etNMzgr/6+6PnrH9Jpjtkmp9mzhhWC2+WCv0oV762JLoujX2n1rIioDV4L4Z?=
 =?us-ascii?Q?Lxq/et7UDMGRxeRvqpAroxUIBhXhTSBftV+nnZc3dCEpRcmr10ohBw6Mc6SK?=
 =?us-ascii?Q?DfYRSIyIXJ+LwXl23qz+yoCh6VVeWpPuVV1tS9pcXg9bjR6JLR2C9tmT7gpk?=
 =?us-ascii?Q?U5BSyZuFXLsDbgX9CbGBsnSFUSzpyeLjosJ2e+yo4FSkEXkvULHXG8O7dgHG?=
 =?us-ascii?Q?I1Eh04EPtJO3+8U+xBvVP+EcEtlJpEbWKX8rVWIl792+hIdUqEx/tTHMJvMC?=
 =?us-ascii?Q?YrcRo2uSvSAUJsm7hSRecf7eaiKn/h/Kxu47EbRkBXqWiZGcpUlAMrRSKIEC?=
 =?us-ascii?Q?VBx5+rVLwKtQesxrowP4KpezR/+h30J9DXe3aKLYEg5hangj83XvDOtlVwcG?=
 =?us-ascii?Q?BcYaneMY+yiNjXc7gN3pJlt/cHkE2EJTSZ9MpagJ2amh/kIf+8ogT6rQ0fp8?=
 =?us-ascii?Q?TLN8Oqk4ZMR85gJfHOpoDQmx8c3nbcIR78wIbL+jF/QmEqaJGQoqdq6pnqlS?=
 =?us-ascii?Q?CdL0Ynzh2e1YaFAW7MkH8n+Q3BorSc3JKHO6I/DmWQbRU1r34P7REgvjeMBC?=
 =?us-ascii?Q?1/f1pkdJVKXNCSSLBUrnvnVcw8KbL7dwSgQoCp/n1gf2lyBTzl+iI722BK1I?=
 =?us-ascii?Q?GldNoXOyFekHlPQ+axFoYbqThs/NAmB7/Dj/UdtAsTXvFGIfEqupGKQvDyNT?=
 =?us-ascii?Q?LHtD4zjh62nSAjzZbFy91ESthchGpq3gYDHmFR1IDIXNbVBbACJlThzdFISz?=
 =?us-ascii?Q?0WR17vx6+Ltqu0NX8E7Y5qpby3bidYXMHbhpms5lhY9KV29I/wclmOaezc/v?=
 =?us-ascii?Q?QMHYPINHhEeZD/mhJc/fEHxkNl+D24l2PZr91anWhr/TixlDK7tSUhVpzIQl?=
 =?us-ascii?Q?3UbzZpZxj/33pWSiKW8fRpZcDWA7N+b8c9Zu3lEQ/E130MXV4sxgdU7y0uln?=
 =?us-ascii?Q?Ihcz40/i9AN8G0a5neH76BOHE3QQ9pBOzoQxGm/aMMBh1lX8TIuSlgt7WxEH?=
 =?us-ascii?Q?lENuoA6DsZCU02jsH9oESOOWBamuv/m21bX7OJ9h5zra+IjlSupGpUbi71a1?=
 =?us-ascii?Q?QnMxdU/vvV01cFefxKJ7Kc5QFNNLoT7Lffm0JCMEH2+QP+/CrlkoqxDfNwvR?=
 =?us-ascii?Q?mFKdpVrw0VHC+6S1ZaNhj0+u9IR1V2rY5WrpXdYJ9rerpV9rhLpnUxVInw+d?=
 =?us-ascii?Q?EAZmkfVJmepxOeN0xT6U7ibtbjhJHH14H1ljt9rci9vw00NN/9C/Ayw3aOHQ?=
 =?us-ascii?Q?5LiYkF3Xmot9FDVqjESbDsole9mEr1bxGk/nszjQx3KLB5+JeEfO+dolLzFA?=
 =?us-ascii?Q?vuUhgd8twWJMardI2gL6zSe7RsB5wYiXX9txy0oYtTwjpyizS+gB4wyo8bw5?=
 =?us-ascii?Q?u3MI+UHecjSGVgkIoJCzNR5OnftnuiHdKHAZNImu82vZQG510kyhaMKLv52K?=
 =?us-ascii?Q?zHgTFc4mSXmev14K5lfkTbFDGGj8WvqM6pkKs1gjk/zaYgdpVfDdbBZrYjHS?=
 =?us-ascii?Q?YbjrYsgpeJCXLAW/imDmlE49eoYG7eVogobhh5CE30oBDEUGPAvEgBE6fuPe?=
 =?us-ascii?Q?9rj7wliXvoZgkO3e6OSVwakBtYm6gNjJdhzy4Dbi?=
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4ab9d19-20e3-4fa8-ae89-08dbd11f5ef9
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2023 03:48:07.0088
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UjqTjVhxEcx8siwXEDki1emBK+jN3YocsX9wD4fM2H//sxCHnVnRQHdTHGq/A6RXJJm6DriLbN7v826qNHZ4VQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7069
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

--_000_PA4PR04MB96388A628D6AB8359D3DAAD0D1DBAPA4PR04MB9638eurp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Patch v6:

Correct mailing sequence.

Patch v5:

1. Add host base MLME support enable WPA3 functionalities in both STA and A=
P mode
2. This feature requires a firmware with corresponding WPA3 key API support
3. This feature and regression test have been covered for IW416
4. This feature is currently enabled and tested only for IW416
5. Changelogs since Patch v4
    a. Enhancement: Add WPA3 AP mode support
    b. Bug fix: In WPA3 STA mode, device gets disconnected from AP when gro=
up rekey occurs
    c. Bug fix: STAUT doesn't send WMM IE in Association request when assoc=
iate to WMM-AP

Patch v4:

1. Correct one bad code segment.
2. Add code to check firmware key api version for host_mlme.

Patch v3:

Clean and clear commit message.

Patch v2:

1. Checkpatch error: pwe[1] -> pwe[0].
2. Remove module parameter 'host_mlme'.
3. Won't advertise NL80211_FEATURE_SAE if host mlme is disabled.

David Lin (6):
  wifi: mwifiex: added code to support host mlme.
  wifi: mwifiex: fixed group rekey issue for WPA3.
  wifi: mwifiex: fixed reassocation issue for WPA3.
  wifi: mwifiex: fixed missing WMM IE for assoc req.
  wifi: mwifiex: supported host mlme for AP mode.
  wifi: mwifiex: added mac address for AP config.

 .../net/wireless/marvell/mwifiex/cfg80211.c   | 420 +++++++++++++++++-
 drivers/net/wireless/marvell/mwifiex/cmdevt.c |  34 +-
 drivers/net/wireless/marvell/mwifiex/decl.h   |  12 +
 drivers/net/wireless/marvell/mwifiex/fw.h     |  36 ++
 drivers/net/wireless/marvell/mwifiex/init.c   |   4 +
 drivers/net/wireless/marvell/mwifiex/ioctl.h  |   6 +
 drivers/net/wireless/marvell/mwifiex/join.c   |  64 ++-
 drivers/net/wireless/marvell/mwifiex/main.c   |  10 +
 drivers/net/wireless/marvell/mwifiex/main.h   |  13 +
 drivers/net/wireless/marvell/mwifiex/scan.c   |   6 +
 drivers/net/wireless/marvell/mwifiex/sdio.c   |  13 +
 drivers/net/wireless/marvell/mwifiex/sdio.h   |   2 +
 .../wireless/marvell/mwifiex/sta_cmdresp.c    |   2 +
 .../net/wireless/marvell/mwifiex/sta_event.c  |  18 +-
 .../net/wireless/marvell/mwifiex/sta_ioctl.c  |   3 +-
 drivers/net/wireless/marvell/mwifiex/sta_tx.c |   9 +-
 .../net/wireless/marvell/mwifiex/uap_cmd.c    | 182 ++++++++
 drivers/net/wireless/marvell/mwifiex/util.c   | 104 +++++
 18 files changed, 919 insertions(+), 19 deletions(-)

--=20
2.25.1


--_000_PA4PR04MB96388A628D6AB8359D3DAAD0D1DBAPA4PR04MB9638eurp_
Content-Disposition: attachment; filename="winmail.dat"
Content-Transfer-Encoding: base64
Content-Type: application/ms-tnef; name="winmail.dat"

eJ8+IvNzAQaQCAAEAAAAAAABAAEAAQeQBgAIAAAA5AQAAAAAAADoAAEJgAEAIQAAAEYyOENCNzAx
RUMyQzgyNDI5Q0VENjI1NEFDQ0UxRjI4AF0HAQ2ABAACAAAAAgACAAEFgAMADgAAAOcHCgAUAAMA
MAAGAAUASgEBIIADAA4AAADnBwoAFAADADAABgAFAEoBAQiABwAYAAAASVBNLk1pY3Jvc29mdCBN
YWlsLk5vdGUAMQgBBIABAEAAAABbUEFUQ0ggdjYgMC82XSB3aWZpOiBtd2lmaWV4OiBhZGRlZCBj
b2RlIHRvIHN1cHBvcnQgaG9zdCBtbG1lLiAACRUBC4ABACEAAABGMjhDQjcwMUVDMkM4MjQyOUNF
RDYyNTRBQ0NFMUYyOABdBwEDkAYAvDMAAFoAAAACAX8AAQAAAFEAAAA8UEE0UFIwNE1COTYzODhB
NjI4RDZBQjgzNTlEM0RBQUQwRDFEQkFAUEE0UFIwNE1COTYzOC5ldXJwcmQwNC5wcm9kLm91dGxv
b2suY29tPgAAAAALAB8OAAAAAAIBCRABAAAAmQUAAJUFAADGCwAATFpGdeZeih5hAApmYmlkBAAA
Y2PAcGcxMjUyAP4DQ/B0ZXh0AfcCpAPjAgAEY2gKwHNldDAg7wdtAoMAUBFNMgqABrQCgJZ9CoAI
yDsJYjE5DsC/CcMWcgoyFnECgBViKgmwcwnwBJBhdAWyDlADYHOibwGAIEV4EcFuGDBdBlJ2BJAX
tgIQcgDAdH0IUG4aMRAgBcAFoBtkZJogA1IgECIXslx2CJDkd2sLgGQ1HVME8AdADRdwMApxF/Ji
a21rBnMBkAAgIEJNX0LgRUdJTn0K/AHxC/AYMiBQGIARwCB2Nug6XGwLgGUKgSJECFB6cglwYwVA
AMADEAuAZwogEgBxClBuY2UuCyI8IaU1Ii0xLiBBmmQcYGgZEAVAYmESABEF0ExNRSQAdXBwHQkR
IAnwAaAecCBXUJRBMxxwdSRgdGkCID0HQGkp0AeRC4AnoG90YSHgU1RBIABwHGBBLlAjgARxIjUy
JwBUaPsEABxwZRiACHAZ4AlwJDA2aQlwBCBhHHAtsG13/wrAGeAD8CrhBaEtwSiAHcCjI9IpQ2tl
eSuBSShG/SI1MyyNK1IJcAnBBBAp4f8cwSeBEdAaMCegCeEb0RoxgxxSBbFJVzQxNiI1djQsjSzB
YwhwCXACMGz/MFAo1BxgK1IzghxRAiA3kbU0/jUnAEMZowkAZwQgVwCQJGEhljQiNSA8cWF5JwBF
bhmhJHAHgAIwOl8nEylDK5UwrTxyYicAQtZ1I/AuIHg9kEkDoClD8ysSBGIsIAEAHWA7URgw/nQE
IA3hG+EYUCNgHFYrkdx3aDRBCcAIYHAtYTAy3G9jNyEOADwYYz/5KxG0VVRBsG8HkAuQJxaAxwVA
EgArYVdNTTUgKDD9KpFBBBBE4AcwKdItYzOSv0PTJ8BI1BngGJBIAi0rkH8krzuzJg86YCMlAiA0
AWH/HGAFoD6SMuA9UiSWLHEnIm9O80rhEcAFkGsuGDAyYXxwaSHwBJAzMzTyJ2Jf3G1sB4AknyHD
MyIuHnCbA5ErUmNWURvCbW0qMLsjgDMRYRgwU+8hwzJM3786YVFBCrAhwgSQA2ByPZAAcHdlWzFd
IC3SPlvDMF1PuVI9QDSBbSuydSkRCrFhB4AboietU1cnWCYxkVcCICcFQA9OwBtyBAAZ4E5MODAA
MjExX0ZFQVRAVVJFX1NBSGFmvydUU6I24g3hN+NYLUQz4IkN0CBMKpEoNikiJv88cAPwLiA9kC5Q
ZpEQMD2Q/07AAQBQiChWYtdYJmZvQFH/HFFEKgQBClA5MylCaW9qfP8JcEpDSRRsH20vaqlXcDMh
/y+ySCQ08kpDLWJwn2b2KFX/HFFi2DTyK5V0T2b8AMFnYi8zAncGG+EuIGdYLSAu5XxALxhQdC8D
8AlwHnDNBBAvAMAaIWxsfUBm9NAvY2ZnYYMuc/A8cEh8IDQB0CArf44tuzwGehBpUpJ8f32MbUHB
x0+gc/B/ICAzNH9wgJ9nga99mgWBbC4h4H8CIJ8OkH9whI+Fn32pZneHk/mHwzM2f3GIX4lvfakL
gP8qMH7VPHCEQYw/jU+OWkTgfzeAh5KPkovxkA+RH32pavZvC4CPRjaEQYRvlM99i/8jkZbXHpCT
v5i/mc+Hlylw/5uPnJ99mh5BlteTn6A/oU79DeBvmtefP6QfpS+mMIelviCIKXxCqE+htwGQX4Nx
/y8yftOqX3xfrD+tQEHQT4L7fuGH4jiEWa8vsD+tMZLU37HUhCCEX6fvtD9fDNCD1NwgObJft499
uHVSUK1S/63WsjCIIX+Ftm+7H7wqKdD7tZO9kjCXcr5ZsjEuIMAB61ERGbJkQaA5FnAqgRIAw2EB
AiBzKCspQaDEQScBAB5wxMQtKSI8LS33AzAsFg6gLgBQIksVQslQAAAAHwBCAAEAAAAUAAAARABh
AHYAaQBkACAATABpAG4AAAAfAGUAAQAAACYAAAB5AHUALQBoAGEAbwAuAGwAaQBuAEAAbgB4AHAA
LgBjAG8AbQAAAAAAHwBkAAEAAAAKAAAAUwBNAFQAUAAAAAAAAgFBAAEAAABcAAAAAAAAAIErH6S+
oxAZnW4A3QEPVAIAAACARABhAHYAaQBkACAATABpAG4AAABTAE0AVABQAAAAeQB1AC0AaABhAG8A
LgBsAGkAbgBAAG4AeABwAC4AYwBvAG0AAAAfAAJdAQAAACYAAAB5AHUALQBoAGEAbwAuAGwAaQBu
AEAAbgB4AHAALgBjAG8AbQAAAAAAHwDlXwEAAAAuAAAAcwBpAHAAOgB5AHUALQBoAGEAbwAuAGwA
aQBuAEAAbgB4AHAALgBjAG8AbQAAAAAAHwAaDAEAAAAUAAAARABhAHYAaQBkACAATABpAG4AAAAf
AB8MAQAAACYAAAB5AHUALQBoAGEAbwAuAGwAaQBuAEAAbgB4AHAALgBjAG8AbQAAAAAAHwAeDAEA
AAAKAAAAUwBNAFQAUAAAAAAAAgEZDAEAAABcAAAAAAAAAIErH6S+oxAZnW4A3QEPVAIAAACARABh
AHYAaQBkACAATABpAG4AAABTAE0AVABQAAAAeQB1AC0AaABhAG8ALgBsAGkAbgBAAG4AeABwAC4A
YwBvAG0AAAAfAAFdAQAAACYAAAB5AHUALQBoAGEAbwAuAGwAaQBuAEAAbgB4AHAALgBjAG8AbQAA
AAAACwBAOgEAAAAfABoAAQAAABIAAABJAFAATQAuAE4AbwB0AGUAAAAAAAMA8T8EBAAACwBAOgEA
AAADAP0/5AQAAAIBCzABAAAAEAAAAPKMtwHsLIJCnO1iVKzOHygDABcAAQAAAEAAOQAA3987CAPa
AUAACDAjE3g8CAPaAQsAKQAAAAAAHwDZPwEAAAAAAgAAUABhAHQAYwBoACAAdgA2ADoADQAKAA0A
CgBDAG8AcgByAGUAYwB0ACAAbQBhAGkAbABpAG4AZwAgAHMAZQBxAHUAZQBuAGMAZQAuAA0ACgAN
AAoAUABhAHQAYwBoACAAdgA1ADoADQAKAA0ACgAxAC4AIABBAGQAZAAgAGgAbwBzAHQAIABiAGEA
cwBlACAATQBMAE0ARQAgAHMAdQBwAHAAbwByAHQAIABlAG4AYQBiAGwAZQAgAFcAUABBADMAIABm
AHUAbgBjAHQAaQBvAG4AYQBsAGkAdABpAGUAcwAgAGkAbgAgAGIAbwB0AGgAIABTAFQAQQAgAGEA
bgBkACAAQQBQACAAbQBvAGQAZQANAAoAMgAuACAAVABoAGkAcwAgAGYAZQBhAHQAdQByAGUAIABy
AGUAcQB1AGkAcgBlAHMAIABhACAAZgBpAHIAbQB3AGEAcgBlACAAdwBpAHQAaAAgAGMAbwByAHIA
ZQBzAHAAbwBuAGQAaQBuAGcAIABXAFAAQQAzACAAawBlAHkAIABBAFAASQAgAHMAdQBwAHAAbwBy
AHQADQAKADMALgAgAFQAaABpAHMAIABmAGUAYQB0AHUAcgBlACAAYQBuAGQAIAByAGUAZwByAGUA
cwBzAGkAbwBuACAAdABlAHMAdAAgAGgAYQB2AGUAAAALAACACCAGAAAAAADAAAAAAAAARgAAAAAU
hQAAAAAAAB8AAICGAwIAAAAAAMAAAAAAAABGAQAAAB4AAABhAGMAYwBlAHAAdABsAGEAbgBnAHUA
YQBnAGUAAAAAAAEAAAAaAAAAegBoAC0AVABXACwAIABlAG4ALQBVAFMAAAAAAAMAAIAIIAYAAAAA
AMAAAAAAAABGAQAAADIAAABFAHgAYwBoAGEAbgBnAGUAQQBwAHAAbABpAGMAYQB0AGkAbwBuAEYA
bABhAGcAcwAAAAAAIAAAAEgAAIAIIAYAAAAAAMAAAAAAAABGAQAAACIAAABOAGUAdAB3AG8AcgBr
AE0AZQBzAHMAYQBnAGUASQBkAAAAAAAZnavk4yCoT66JCNvRH175HwAAgBOP8kH0gxRBpYTu21pr
C/8BAAAAFgAAAEMAbABpAGUAbgB0AEkAbgBmAG8AAAAAAAEAAAAqAAAAQwBsAGkAZQBuAHQAPQBN
AFMARQB4AGMAaABhAG4AZwBlAFIAUABDAAAAAAAfAPo/AQAAABQAAABEAGEAdgBpAGQAIABMAGkA
bgAAAB8ANwABAAAAgAAAAFsAUABBAFQAQwBIACAAdgA2ACAAMAAvADYAXQAgAHcAaQBmAGkAOgAg
AG0AdwBpAGYAaQBlAHgAOgAgAGEAZABkAGUAZAAgAGMAbwBkAGUAIAB0AG8AIABzAHUAcABwAG8A
cgB0ACAAaABvAHMAdAAgAG0AbABtAGUALgAgAAAAHwA9AAEAAAACAAAAAAAAAAMANgAAAAAAAgFx
AAEAAAAWAAAAAdoDCDtnHg9WHjidSq6kmhUFkN75GgAAHwBwAAEAAACAAAAAWwBQAEEAVABDAEgA
IAB2ADYAIAAwAC8ANgBdACAAdwBpAGYAaQA6ACAAbQB3AGkAZgBpAGUAeAA6ACAAYQBkAGQAZQBk
ACAAYwBvAGQAZQAgAHQAbwAgAHMAdQBwAHAAbwByAHQAIABoAG8AcwB0ACAAbQBsAG0AZQAuACAA
AAAfADUQAQAAAKIAAAA8AFAAQQA0AFAAUgAwADQATQBCADkANgAzADgAOABBADYAMgA4AEQANgBB
AEIAOAAzADUAOQBEADMARABBAEEARAAwAEQAMQBEAEIAQQBAAFAAQQA0AFAAUgAwADQATQBCADkA
NgAzADgALgBlAHUAcgBwAHIAZAAwADQALgBwAHIAbwBkAC4AbwB1AHQAbABvAG8AawAuAGMAbwBt
AD4AAAAAAAMA3j+fTgAAAwATEgAAAAACAQCAE4/yQfSDFEGlhO7bWmsL/wEAAAAuAAAASABlAGEA
ZABlAHIAQgBvAGQAeQBGAHIAYQBnAG0AZQBuAHQATABpAHMAdAAAAAAAAQAAACIAAAABAAoAAAAE
AAAAAAAAABQAAAAAAAAAAAAAAP////8AAAAAAAALAACAE4/yQfSDFEGlhO7bWmsL/wEAAAAcAAAA
SABhAHMAUQB1AG8AdABlAGQAVABlAHgAdAAAAAAAAAALAACAE4/yQfSDFEGlhO7bWmsL/wEAAAAo
AAAASQBzAFEAdQBvAHQAZQBkAFQAZQB4AHQAQwBoAGEAbgBnAGUAZAAAAAAAAABAAAcwL1hMPAgD
2gECAQsAAQAAABAAAADyjLcB7CyCQpztYlSszh8oAwAmAAAAAAALAAYMAAAAAAIBEDABAAAARgAA
AAAAAADIpSWxiCOSSoOqZJAKpKsqBwBPPiDQ/CbdRK5hB1o6Ct0nAAAAAAELAABPPiDQ/CbdRK5h
B1o6Ct0nAAIhGpURAAAAAAIBEzABAAAAEAAAAB4PVh44nUqupJoVBZDe+RoCARQwAQAAAAwAAADx
AAAAeizbi1AAAAADAFszAQAAAAMAWjYAAAAAAwBoNg0AAAALAPo2AQAAAB8A+D8BAAAAFAAAAEQA
YQB2AGkAZAAgAEwAaQBuAAAAHwAiQAEAAAAGAAAARQBYAAAAAAAfACNAAQAAAPwAAAAvAE8APQBF
AFgAQwBIAEEATgBHAEUATABBAEIAUwAvAE8AVQA9AEUAWABDAEgAQQBOAEcARQAgAEEARABNAEkA
TgBJAFMAVABSAEEAVABJAFYARQAgAEcAUgBPAFUAUAAgACgARgBZAEQASQBCAE8ASABGADIAMwBT
AFAARABMAFQAKQAvAEMATgA9AFIARQBDAEkAUABJAEUATgBUAFMALwBDAE4APQBDAEIAMAA0AEYA
NgA1ADkAMQBBAEQANgA0ADQANgBCADgAQQBBAEIAQwA5AEIANgA1AEQAQQBFADkAMgAwADcALQBO
AFgARgA1ADcANgAyADQAAAAfACRAAQAAAAYAAABFAFgAAAAAAB8AJUABAAAA/AAAAC8ATwA9AEUA
WABDAEgAQQBOAEcARQBMAEEAQgBTAC8ATwBVAD0ARQBYAEMASABBAE4ARwBFACAAQQBEAE0ASQBO
AEkAUwBUAFIAQQBUAEkAVgBFACAARwBSAE8AVQBQACAAKABGAFkARABJAEIATwBIAEYAMgAzAFMA
UABEAEwAVAApAC8AQwBOAD0AUgBFAEMASQBQAEkARQBOAFQAUwAvAEMATgA9AEMAQgAwADQARgA2
ADUAOQAxAEEARAA2ADQANAA2AEIAOABBAEEAQgBDADkAQgA2ADUARABBAEUAOQAyADAANwAtAE4A
WABGADUANwA2ADIANAAAAB8AMEABAAAAFAAAAEQAYQB2AGkAZAAgAEwAaQBuAAAAHwAxQAEAAAAU
AAAARABhAHYAaQBkACAATABpAG4AAAAfADhAAQAAABQAAABEAGEAdgBpAGQAIABMAGkAbgAAAB8A
OUABAAAAFAAAAEQAYQB2AGkAZAAgAEwAaQBuAAAAAwBZQAAAAAADAFpAAAAAAAMAN1ABAAAAAwAJ
WQEAAAAfAApdAQAAACYAAAB5AHUALQBoAGEAbwAuAGwAaQBuAEAAbgB4AHAALgBjAG8AbQAAAAAA
HwALXQEAAAAmAAAAeQB1AC0AaABhAG8ALgBsAGkAbgBAAG4AeABwAC4AYwBvAG0AAAAAAAIBFV0B
AAAAEgAAAALToW5oK7xvTKks2ZxcMBY1AQAAAgEWXQEAAAASAAAAAtOhbmgrvG9MqSzZnFwwFjUB
AAADAACAUONjC8yc0BG82wCAX8zOBAEAAAAkAAAASQBuAGQAZQB4AGkAbgBnAEUAcgByAG8AcgBD
AG8AZABlAAAAGwAAAB8AAIBQ42MLzJzQEbzbAIBfzM4EAQAAACoAAABJAG4AZABlAHgAaQBuAGcA
RQByAHIAbwByAE0AZQBzAHMAYQBnAGUAAAAAAAEAAABwAAAASQBuAGQAZQB4AGkAbgBnACAAUABl
AG4AZABpAG4AZwAgAHcAaABpAGwAZQAgAEIAaQBnAEYAdQBuAG4AZQBsAFAATwBJAEkAcwBVAHAA
VABvAEQAYQB0AGUAIABpAHMAIABmAGEAbABzAGUALgAAAAsAAIBQ42MLzJzQEbzbAIBfzM4EAQAA
ACYAAABJAHMAUABlAHIAbQBhAG4AZQBuAHQARgBhAGkAbAB1AHIAZQAAAAAAAAAAAB8AAIAfpOsz
qHouQr57eeGpjlSzAQAAADgAAABDAG8AbgB2AGUAcgBzAGEAdABpAG8AbgBJAG4AZABlAHgAVABy
AGEAYwBrAGkAbgBnAEUAeAAAAAEAAABEAQAASQBJAD0AWwBDAEkARAA9ADEAZQA1ADYAMABmADEA
ZQAtADkAZAAzADgALQBhAGUANABhAC0AYQA0ADkAYQAtADEANQAwADUAOQAwAGQAZQBmADkAMQBh
ADsASQBEAFgASABFAEEARAA9AEQAQQAwADMAMAA4ADMAQgA2ADcAOwBJAEQAWABDAE8AVQBOAFQA
PQAxAF0AOwBUAEYAUgA9AFQAaAByAGUAYQBkAEYAbwByAGsAaQBuAGcASQBzAEQAaQBzAGEAYgBs
AGUAZAA7AFYAZQByAHMAaQBvAG4APQBWAGUAcgBzAGkAbwBuACAAMQA1AC4AMgAwACAAKABCAHUA
aQBsAGQAIAA2ADkAMwAzAC4AMAApACwAIABTAHQAYQBnAGUAPQBIADQAOwBVAFAAPQAxADAAOwBE
AFAAPQAxAAAAQAAAgAggBgAAAAAAwAAAAAAAAEYAAAAAv4UAABDWajsIA9oBCwAAgAggBgAAAAAA
wAAAAAAAAEYAAAAAgoUAAAAAAAACAQCACCAGAAAAAADAAAAAAAAARgEAAAA2AAAASQBuAFQAcgBh
AG4AcwBpAHQATQBlAHMAcwBhAGcAZQBDAG8AcgByAGUAbABhAHQAbwByAAAAAAABAAAAEAAAAJXT
wAeuMKpKmHFdJ2CGsDIDAA00/T8AAB8AAICGAwIAAAAAAMAAAAAAAABGAQAAAC4AAABhAHUAdABo
AGUAbgB0AGkAYwBhAHQAaQBvAG4ALQByAGUAcwB1AGwAdABzAAAAAAABAAAAsgAAAGQAawBpAG0A
PQBuAG8AbgBlACAAKABtAGUAcwBzAGEAZwBlACAAbgBvAHQAIABzAGkAZwBuAGUAZAApACAAaABl
AGEAZABlAHIALgBkAD0AbgBvAG4AZQA7AGQAbQBhAHIAYwA9AG4AbwBuAGUAIABhAGMAdABpAG8A
bgA9AG4AbwBuAGUAIABoAGUAYQBkAGUAcgAuAGYAcgBvAG0APQBuAHgAcAAuAGMAbwBtADsAAAAA
AB8AAICGAwIAAAAAAMAAAAAAAABGAQAAACAAAAB4AC0AbQBzAC0AaABhAHMALQBhAHQAdABhAGMA
aAAAAAEAAAACAAAAAAAAAB8AAICGAwIAAAAAAMAAAAAAAABGAQAAAC4AAAB4AC0AbQBzAC0AcAB1
AGIAbABpAGMAdAByAGEAZgBmAGkAYwB0AHkAcABlAAAAAAABAAAADAAAAEUAbQBhAGkAbAAAAB8A
AICGAwIAAAAAAMAAAAAAAABGAQAAADYAAAB4AC0AbQBzAC0AdAByAGEAZgBmAGkAYwB0AHkAcABl
AGQAaQBhAGcAbgBvAHMAdABpAGMAAAAAAAEAAABIAAAAUABBADQAUABSADAANABNAEIAOQA2ADMA
OAA6AEUARQBfAHwAVgBJADEAUABSADAANABNAEIANwAwADYAOQA6AEUARQBfAAAAHwAAgIYDAgAA
AAAAwAAAAAAAAEYBAAAAUAAAAHgALQBtAHMALQBvAGYAZgBpAGMAZQAzADYANQAtAGYAaQBsAHQA
ZQByAGkAbgBnAC0AYwBvAHIAcgBlAGwAYQB0AGkAbwBuAC0AaQBkAAAAAQAAAEoAAABlADQAYQBi
ADkAZAAxADkALQAyADAAZQAzAC0ANABmAGEAOAAtAGEAZQA4ADkALQAwADgAZABiAGQAMQAxAGYA
NQBlAGYAOQAAAAAAHwAAgIYDAgAAAAAAwAAAAAAAAEYBAAAAOAAAAHgALQBtAHMALQBlAHgAYwBo
AGEAbgBnAGUALQBzAGUAbgBkAGUAcgBhAGQAYwBoAGUAYwBrAAAAAQAAAAQAAAAxAAAAHwAAgIYD
AgAAAAAAwAAAAAAAAEYBAAAAOgAAAHgALQBtAHMALQBlAHgAYwBoAGEAbgBnAGUALQBhAG4AdABp
AHMAcABhAG0ALQByAGUAbABhAHkAAAAAAAEAAAAEAAAAMAAAAB8AAICGAwIAAAAAAMAAAAAAAABG
AQAAACoAAAB4AC0AbQBpAGMAcgBvAHMAbwBmAHQALQBhAG4AdABpAHMAcABhAG0AAAAAAAEAAAAO
AAAAQgBDAEwAOgAwADsAAAAAAB8AAICGAwIAAAAAAMAAAAAAAABGAQAAAEQAAAB4AC0AbQBpAGMA
cgBvAHMAbwBmAHQALQBhAG4AdABpAHMAcABhAG0ALQBtAGUAcwBzAGEAZwBlAC0AaQBuAGYAbwAA
AAEAAAACBQAAYgByAEMAVwBQAEcAUAB5AFgAZABKAG0ATwBwAG4AOAB3AGoANABCAEEASABzAE4A
aABFAE8ASwBIAGUAbAByAGQARgB1ADUASQBJAFIARQBFAFUAMQBpAHkARABIAEEAcgBMADEAUQBs
AFEAQQBnAFYATgBtAE0AUwBuAFcASwBWAEQARwBBAEsAVgBiAHYAUgBLAEoAUABwAEQAcQBKAEMA
RgBjADEAKwBOAEUASAA5AE0AVABwAE4AagA0AGQAUQBMADAAVQBPAFYAOABhAEsAegB6AEYAQgBY
AFQARAB1AFIAawBSADEAegBJACsAMwBFAEIAegBiAFUAaAB5AGUAYgBUAEMAKwBqADgAYgBOAEoA
ZAB6AEQAcABpAHAAMwBmAHUATQAwAEUARQBUAFEAZABKAEoALwByAHYAVQBwAFkASQBJAGIAQQBj
AEQAagBCAGUASQBGAGIAUwBjADkAOQBCACsAUwBHAHAAUgAyAHAAYwBkAHQANABDADYAYwBmAGsA
UQBjADcATwBoADAAUgBvADMATwArAEMAMwBGAGMANgBYAGoAcwBIADQAYQBGAGMAUwBxADQAbgA2
AHYAVAAxAGYAegBRAFkAWQBxAEkALwBIAGMAMQBRAG4AdwB3AHAAMgBtADgAbABhAEEAVQA1AGgA
NgBkAHkANgBIADcATwAwAEMATABPAEwAdwA0AFgAWgBtAE8AWQAxAC8ASwBCAC8AZAArAEoAdQB4
ADUAcwBiAFEAMAB3AG4ASwBiAEoASQAzAHIATgBTAGMATAA1AGoASwBoAEwAVQBVAFgASgBuAHMA
bgBDADYAbgBQAGkAaABUADIALwBCAE8AMABOADgAcgBWAFcAdQA3ADMAZQAzADYAZwAyADkAZgA1
AFcAeAB0AHMAdwBuAFQARwBuAFcAaABtAFQAUAB5ADAAOAArAEcAbAAwAFIAWQBFAFAAYQAwAGMA
dwBBADAAQQAyAGkAVABXAEoAZgA4AGgASABkAFUATQB4AFYANQBlAGcAUwBlAEUANQBiAHkAbABk
AFMATQB5AHgAMABZAGkAVgBLAEgAbQByAGIAdQBwAHoAQgBDAHYANgA0AFYAegAvAGUAZABkAGoA
UgBFADUAOQBjAHcAcQBSAGIAbQBzAEwAeQBBADUAZQBzAEMAaQAyAFcAUgBIAG4AWQArAGMAZwBI
AHAAdQBJAE4AZQBsAGYAWgBtAEwANwBIAGsAaQB2AHAATQBHADkAZgA0AGwAcQBXAEIARgBhAGcA
VgBXAE4ATQBiADIAUwBvAFoASQBhAHkAQQBtAC8AOAAxAGQAKwBBAEEASwBoAEIAQwBiAC8AbQB4
AEIAaQBUAHkANABtAGsAMgBMAGgANABuAFQAMwA4AGwAMgByAG4ARgBZAEEAdABGAGwAagBRAHYA
OQBUAEgALwB5AHoAVgBwADIAagAwAG4AUwBHAC8ARgBxADkAUABwAEkAeQA0AEEAbgByAHcASAB2
AEkAQwBvAHYAMQByAG0AbwBSAHcAawBtAEsAdAAwADkATAA2AHgASABSAHUAYgBiADIANwBpAGkA
ZABqAEcAQQBDADYAWQBuAHoAMwBiAFEAUgBYAFYASAAwADUAaABNAGgAUQBUAEkATgBMAGwAQgBz
AHkAZQBXAHQASAB2AEIAeABCADUAeQB5AE0ANQAxAEgAYgAAAAAAHwAAgIYDAgAAAAAAwAAAAAAA
AEYBAAAAOAAAAHgALQBmAG8AcgBlAGYAcgBvAG4AdAAtAGEAbgB0AGkAcwBwAGEAbQAtAHIAZQBw
AG8AcgB0AAAAAQAAAHQEAABDAEkAUAA6ADIANQA1AC4AMgA1ADUALgAyADUANQAuADIANQA1ADsA
QwBUAFIAWQA6ADsATABBAE4ARwA6AGUAbgA7AFMAQwBMADoAMQA7AFMAUgBWADoAOwBJAFAAVgA6
AE4ATABJADsAUwBGAFYAOgBOAFMAUABNADsASAA6AFAAQQA0AFAAUgAwADQATQBCADkANgAzADgA
LgBlAHUAcgBwAHIAZAAwADQALgBwAHIAbwBkAC4AbwB1AHQAbABvAG8AawAuAGMAbwBtADsAUABU
AFIAOgA7AEMAQQBUADoATgBPAE4ARQA7AFMARgBTADoAKAAxADMAMgAzADAAMAAzADEAKQAoADMA
NgA2ADAAMAA0ACkAKAAzADkANgAwADAAMwApACgAMQAzADYAMAAwADMAKQAoADMANwA2ADAAMAAy
ACkAKAAzADkAOAA2ADAANAAwADAAMAAwADIAKQAoADMANAA2ADAAMAAyACkAKAAyADMAMAA5ADIA
MgAwADUAMQA3ADkAOQAwADAAMwApACgAMQA4ADYAMAAwADkAKQAoADEAOAAwADAANwA5ADkAMAAw
ADkAKQAoADYANAAxADAAMAA3ADkAOQAwADAAMwApACgANAA1ADEAMQA5ADkAMAAyADQAKQAoADUA
NQAwADEANgAwADAAMwApACgAMwA4ADEAMAAwADcAMAAwADAAMAAyACkAKAA0ADEAMwAwADAANwAw
ADAAMAAwADEAKQAoADQAMwAyADYAMAAwADgAKQAoADUANgA2ADAAMwAwADAAMAAwADIAKQAoADgA
NgA3ADYAMAAwADIAKQAoADgAOQAzADYAMAAwADIAKQAoADUAMgA1ADMANgAwADEANAApACgAOAA2
ADMANgAyADAAMAAxACkAKAAzADMANgA1ADYAMAAwADIAKQAoADIAOQAwADYAMAAwADIAKQAoADEA
MgAyADAAMAAwADAAMAAxACkAKAA0ADcAOAA2ADAAMAAwADAAMQApACgAOAAzADMAOAAwADQAMAAw
ADAAMAAxACkAKAA5ADYAOAA2ADAAMAAzACkAKAA0ADcANAAzADAAMAAyACkAKAA3ADYAOQA2ADAA
MAA1ACkAKAAyADYAMAAwADUAKQAoADcAMQAyADAAMAA0ADAAMAAwADAAMQApACgANgA1ADAANgAw
ADAANwApACgAMwAxADYAMAAwADIAKQAoADMAOAAwADcAMAA3ADAAMAAwADAAOQApACgANgA2ADkA
NAA2ADAAMAA3ACkAKAA3ADYAMQAxADYAMAAwADYAKQAoADUANAA5ADAANgAwADAAMwApACgANgA2
ADQANwA2ADAAMAA3ACkAKAA2ADkAMQA2ADAAMAA5ACkAKAA2ADYANAA0ADYAMAAwADgAKQAoADYA
NAA3ADUANgAwADAAOAApACgANgA2ADUANQA2ADAAMAA4ACkAOwBEAEkAUgA6AE8AVQBUADsAUwBG
AFAAOgAxADEAMAAxADsAAAAfAACAhgMCAAAAAADAAAAAAAAARgEAAABcAAAAeAAtAG0AcwAtAGUA
eABjAGgAYQBuAGcAZQAtAGEAbgB0AGkAcwBwAGEAbQAtAG0AZQBzAHMAYQBnAGUAZABhAHQAYQAt
AGMAaAB1AG4AawBjAG8AdQBuAHQAAAABAAAABAAAADEAAAAfAACAhgMCAAAAAADAAAAAAAAARgEA
AABKAAAAeAAtAG0AcwAtAGUAeABjAGgAYQBuAGcAZQAtAGEAbgB0AGkAcwBwAGEAbQAtAG0AZQBz
AHMAYQBnAGUAZABhAHQAYQAtADAAAAAAAAEAAACCDAAAZQB0AE4ATQB6AGcAcgAvADYAKwA2AFAA
bgByAEgAOQBKAHAAagB0AGsAbQBwADkAbQB6AGgAaABXAEMAMgArAFcAQwB2ADAAbwBWADcANgAy
AEoATABvAHUAagBYADIAbgAxAHIASQBpAG8ARABWADQATAA0AFoATAB4AHEALwBlAHQANwBVAEQA
TQBHAFIAeABlAFIAdgBxAHAAQQByAG8AeABVAEkAQgBoAFgAaABUAFMAQgBmAHQAVgArAG4AbgBa
AGMAMwBkAEMARQBwAFIAYwBtAHIAMQAwAG8AaABCAHcANgBNAGMANgBTAEsARABmAFkAUgBTAEkA
eQBJAFgASgArAEwAdwBYAGwAMgAzAHEAegArAHkAbwBDAGgANgBWAFYAZQBXAHAAUAB1AFYAVgAx
AHQAUwA5AHAAYwBYAGcAOQBiAGoAUgA2AEoATABSADIAQwA5AHQAbQBUADcAZwBwAGsAVQA1AEIA
UwB5AFoAdQBGAFgATABzAEQAYgBnAFgAOQBDAGIARwBCAHMAbgBTAEYAVQBTAHoAcAB5AGUATABq
AG8AcwBKADIAZQArAHkAbwA0AEYAUwBrAEUAWABrAHYAVQBMAEgAWABHADgATwA3AGQAZwBIAEcA
SQAxAEUAaAAwADQARQBQAHQASgBPADMAKwA4AFUAKwB4AEIAdgBWAFAAKwBFAGMARQB0AGwASgBw
AEUAYgBXAEsAWAA4AHIAVgBXAEkAbAA3ADkAMgArAGgASQBkAFUAcQBFAHgALwB0AFQASABNAEoA
dgBNAEMAWQByAGMAUgBvADIAdQBTAHYAUwBBAFUASgBzAG0ANwBoAFMAUgBlAGMAZgA3AGUAYQBp
AEsAbgAvAGgALwBLAHgAdQA0ADcARQBiAFIAawBCAFgAcQBXAGkAWgBHAGMAcABVAGwAQQBNAHIA
UgBTAEsASQBFAEMAVgBCAHgANQArAHIAVgBMAHcASwB0AFEAZQBzAHgAcgBvAHcAUAA0AEsAcABl
AHoAUgAvACsAaAAzADAASgA5AEQAWABlADMAYQBLAEwAWQBFAGcANQBoAGEAbgBnAGoAOAAzAFgA
dgBEAE8AdABsAFYAdwBjAEcAQgBjAFkAYQBuAGUATQBZACsAeQBpAE4AagBYAGMANwBnAE4AMwBw
AEoAbAB0AC8AYwBIAGsARQAyAEUASgBUAFMAWgA5AE0AcABhAGcASgAyAGEAbQBoAC8AawBJAGYA
KwA4AG8AZwBUADYAcgBRADAAZgBwADgAVABMAE4AOABPAHEAawA0AFoATQBSADgANQBnAEoAZgBI
AE8AcABvAEQAUQBtAHgAOABjADMAbgBiAGMASQBSADcAOAB3AEkAYgBMACsAagBGAC8AUQBtAEUA
cQBhAEoARwBRAG8AcQBkAHEANgBwAG4AcQBsAFMAQwBkAEwAMABZAG4AegBoADIAZQAxAFkAYQBG
AEEAVwA3AE0AawBIADgAbgArAFEAMwBCAG8AcgBTAGMAMwBKAEsASABPADYASQAvAEQAbQBXAFEA
YgBSAFUAMQByADMANABQADcAUgBFAGcAdgBqAGUATQBCAEMAMQAvAGYAMQBwAGsAZABKAFYASwBY
AE4AQwBTAFMATABCAFUAcgBuAHYAbgBWAGMAdwA4AEsAYgBMADcAZAB3AFMAZwBRAG8AQwBwAC8A
bgAxAGcAZgAyAGwAeQBCAFQAegBsACsAaQBJADcAMgAyAEIASwAxAEkARwBsAGQATgBvAFgATwB5
AEYAZQBrAEgAbABQAFEAKwBhAHgARgBvAFkAYgBxAFQAaABzAC8ATgBBAG0AQgA3AC8ARABqAC8A
VQBkAHQAQQBzAFQAWAB2AEYARwBJAGYARQBxAHUAcABHAEsAUQB2AEQAeQBOAFQATABIAHQARAA0
AHoAagBoADYAMgBuAFMAQQBqAHoAWgBiAEYAeQA5ADEARQBTAHQAaABjAGgARwBwAHEAMwBnAFkA
RABIAG0ARgBSADEASQBEAEkAWABOAGIAVgBCAGIAQQBDAEoAbABUAGgAegBkAEYASQBTAHoAMABX
AFIAMQA3AHYAeAA2ACsATAB0AHEAdQAwAE4AWAA4AEUANwBZADUAcQBwAGIAeQAzAGIAaQBkAFkA
WABNAEgAYgBoAHAAbQBzADUAbABoAFkAOQBLAFYAMgA5AEkALwB3AGMAbABtAE8AYQBlAHoAYwAv
AHYAUQBNAEgAWQBQAEkATgBIAGgARQBlAFoARAAvAG0AaABKAGMALwBmAEUASAB4AGsATgBsACsA
RAAyADQAbAAyAFAAWgByADkAMQBhAG4AVwBoAHIALwBUAGkAeABsAEQASwA3AHQAUwBVAGgAVgBw
AHoASQBRAGwAMwBVAGIAegBaAHAAWgB4AGoALwAzADMAcABXAFMAaQBLAFcAOABmAFIAcABaAGMA
RABXAEEANwBOACsAYgA4AGMAOQBaAHUAMwBsAEUAUQAvAEUAMQAzADAATQBYAFYANABzAHgAZwBk
AFUANwB5ADAAdQBsAG4ASQBoAGMAegA0ADAALwBpADkAQQBOADgARwAwAGEANQBuAGUASAA3ADYA
QgBPAEgARQAzAFEAUQA5AHAAQgBPAHoAbwBRAHgARwBtAC8AYQBNAE0AQgBoADEAbABYADgAVABJ
AHUAUwBsAGcAdAA3AFcAeABFAEgAbABFAE4AdQBvAEEANgBEAHMAWgBDAFUAMAAyAGoAcwBIADkA
bwBFAFMATwBPAFcAQgBhAG0AdQB2AC8AbQAyADEAYgBYADcATwBKADkAaAA1AHoAcgBhACsASQBq
AGwAUwB1AHAARwBwAFUAYgBpADcAMQBhADEAUQBuAE0AeABkAFUALwB2AHYAVgAwADEAYwBGAGUA
ZgB4AEsASgA3AEsAYwA1AFEARgBOAE4ATABvAFQANwBMAGYAZgBtADAASgBDAE0ARQBIADIAKwBR
AFAAKwAvAEMAcgBsAGsAbwBxAHgARABmAE4AdwB2AFIAbQBGAEsAZABwAFYAcgB3ADAAVgBIAEMA
KwA2AFMAMQBaAGEATgBoAGoAMAArAHUAOQBJAFIAMQBWADIAcgBZADUAVwByAHAAWABkAFkASgA5
AHIAZQByAHAAVgA5AHIAaABMAHAAbgBVAHgAVgBJAG4AdwArAGQARQBBAFoAbQBrAGYAVgBKAG0A
ZQBwAHgATwBlAE4AMAB4AFQANgBVADcAaQBiAHQAYgBqAGgASgBIAEgAMQA0AEgAMQBsAGoAdAA5
AHIAYwBpADkAdgB3ADAAMABOAE4ALwA5AEMALwBBAHkAdwAzAGEATwBIAFEANQBMAGkAWQBrAEYA
MwBYAG0AbwB0ADkARgBEAFYAcQBqAEUAUwBiAEQAcwBvAGwAZQA5AG0ARQByADEAYgB4AEcAawAv
AG4AcwB6AGoAUQB4ADMASwBMAEIANQArAEoAZQBFAGYATwArAGQAbwBsAEwAegBGAEEAdgB1AFUA
aABnAGQAOAB0AHcAVwBKAE0AYQByAGQASQAyAGcATAA2AHoAUwBlADcAUgBzAEIANQB3AFkAaQBY
AFgAOQB0AHgAeQAwAG8AWQB0AFQAdwBqAHAAeQBpAHoAUwArAGcAQgA0AHcAeQBvADgAYgB3ADUA
dQAzAE0ASQArAFUASABlAGMAagBTAEcAVgBnAGsASQBvAEoAQwB6AE4AUgA1AE8AbgBmAHQAbgB1
AGkASABkAEsASABBAFoATgBJAG0AdQA4ADIAdgBaAFEARwA1ADEAMABrAHkAaABhAE0ASwBMAHYA
NQAyAEsAegBIAGcAVABGAGMANABtAFMAWABtAGUAdgAxADQASwA1AGwAZgBrAFQAYgBGAEQARwBH
AGoAOABXAHYAcQBNADYAcABrAEsAcwAxAGcAagBrAC8AegBhAFkAZwBkAHAAVgBmAEQAZABiAEIA
WgByAFkAagBIAFMAWQBiAGoAcgBZAHMAZwBwAGUASgBDAFgATABBAFcALwBpAG0ARABtAGwARQA0
ADkAZQBvAFkARwA3AGUAVgBvAGcAbwBiAGgAaAA1AEMARQAzADAAbwBCAEQARQBVAEcAUABBAHYA
RQBnAEIARQA2AGYAdQBQAGUAOQByAGoANwB3AGwAaQBYAHYAbwBaAGcAawBPADMAZQA2AE8AUwBW
AHcAYQBrAEIAdABZAG0ANgBnAE4AagBKAGQAaAB6AHkANABEAGIAaQAAAAAAuy0=

--_000_PA4PR04MB96388A628D6AB8359D3DAAD0D1DBAPA4PR04MB9638eurp_--
