Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 093F23BB803
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Jul 2021 09:40:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230003AbhGEHnb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 5 Jul 2021 03:43:31 -0400
Received: from mail-am6eur05on2043.outbound.protection.outlook.com ([40.107.22.43]:11617
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230025AbhGEHna (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 5 Jul 2021 03:43:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YssdC6oUpV92gTDGSrtWDwDQisqQeBhMWgRGeiFbUmmumcim8cnZD+vr6EB77wJJv1tYPCtXntMUdkMUdzQNL/et7u0tSYUe2p5BXphpghn3qJHHP71Ao2/T/pqR17MhSkV3l565kRhaLt1/tL10/O6Pk4b/iC9STsooyYY3Ii4a0HsNFc5gCVperp0gcuiUtl3YKOj224Hr1SiWDOeDAPL1dAFXszj5/ttjN6JlQB1Hezvj2a0ssR0fFkelHc6ODWJZ3vv8YBUdLVEPfaarMC4fZsmRXN3v+XcBMAsWbLrpPlEGiAvGNB7Vtp1tLYUdAJfx94GFqcCLCYDDKp2Rzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ruCEiiwWk/yR9KrPSdljrQL2rKLj3SZJghEy0Ba7uI8=;
 b=UBZeVGZNLcCAGWhY93PS2wKyyba6S3Eb14S/0h3ssrgHd6H82Mcv0uXEoxGJB/SZH58tuGJ7NwjtIsAHxFEt5DK7Pmgl0gySxWogKTmqCxBJv4+kLnAI5KUJ6UYBkksKhBqCc8U0q3RJ8q21ZehXpLf9PpUq4xF8WVqU34211CX6ykJQLj2Mk0nOmuMGnwMfQH4i3nzIyk5ADVR7P52ouuEYls/+JHnJy9wuyjjciMvfk88lerINTuEnHSwydcZLqBgyw14u5Fp71PZk3AQ+rLl508MTMn2lyf1LdPzSMVNSrfQiv8bUgs9ii0Poi8XU73qzl/5Z/PPJskpME06O/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ruCEiiwWk/yR9KrPSdljrQL2rKLj3SZJghEy0Ba7uI8=;
 b=e3PUSOOdERSGF774G4p0eMchiuQK909KfPJFt5Bkf/1WcmyIANoxFlhFAREGcB5tbO19udTUQGgcVkNzkmvqp5Jzy5LyVjs742ZQdztyjvf84mbKiiie+RU2k/XBnqhNyLlbFIrymHUN2Y81Iq52hSPzeLRWnRe8npgML5ntpGM=
Received: from DB7PR04MB4538.eurprd04.prod.outlook.com (2603:10a6:5:2e::18) by
 DB6PR04MB3144.eurprd04.prod.outlook.com (2603:10a6:6:f::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4287.23; Mon, 5 Jul 2021 07:40:50 +0000
Received: from DB7PR04MB4538.eurprd04.prod.outlook.com
 ([fe80::e998:6b4e:6266:b10d]) by DB7PR04MB4538.eurprd04.prod.outlook.com
 ([fe80::e998:6b4e:6266:b10d%3]) with mapi id 15.20.4287.033; Mon, 5 Jul 2021
 07:40:50 +0000
From:   Sharvari Harisangam <sharvari.harisangam@nxp.com>
To:     "linux-firmware@kernel.org" <linux-firmware@kernel.org>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Rakesh Parmar <rakesh.parmar@nxp.com>,
        Cathy Luo <xiaohua.luo@nxp.com>
Subject: pull-request mwifiex-firmware 2021-07-05
Thread-Topic: pull-request mwifiex-firmware 2021-07-05
Thread-Index: AddxcQKjRi6h+CaVQnyIoYNmH/uK7A==
Date:   Mon, 5 Jul 2021 07:40:50 +0000
Message-ID: <DB7PR04MB453855B0D6C41923BCB0922EFC1C9@DB7PR04MB4538.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [116.75.139.158]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ca9b0a4c-7f02-4a27-d9da-08d93f8835e9
x-ms-traffictypediagnostic: DB6PR04MB3144:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB6PR04MB3144B584CDE2590AC3E7B798FC1C9@DB6PR04MB3144.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:330;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Vu6w71ez76Aivh1KsEXTKPf2MchmZbFQGY0q3Ykx+UegWz9xKxkerW2oFqRjV484eMflfmruOiNXZfCdh8UQ+Us9edsF8snuiqiRCu3vhtYfeEQXvswhGviEkzWP0WMmuwcmmxrn1Tij4/xj202/RYtI7IEE66YbaZx7BOONwAh6CEKCZM92gsduk1btnNb/53L6DgL6SWFbBnzwjjynkp4cEI8jIE5pFOyguab9sRO95rEHKGAeMoeHE6FkeI8M2jUMNPa/c6bBtBbkiDMzs2HqKI24uciTyxytoFxb8pj5n3i4W1pJHrbqtGYTmEf1L7h02CJulz1ndtRWzZcFsJHTBADW9mO07T40ioQI1kKL9ixJAbHW3hC8ii1dpD4uGIO+YnjAqYPzdc+a1nrwsjYzstFyOtwJpfGPUHfDZFWGZwBShlgj0ythtVP9b+Nr1y6ImvL/JYkMUtg3YpRLpNqcbVCGo1CmWkrcD4u0Y+4VVX9B7Kv00dZ8UeECfIS3ECQJGBbPLjD99q53q1+FOILWC9DR+DJksHjBxQ7jP35teX3v+/DShQ+ZiZ+1WFylszkzBu6AWOie45/ZB2K6ts/i7kl2wX8rgGw5ZbpCM1mnA8DEq0Eka1SaOsaOU3d8CbkfFIBYGyxXIsMuy2IVmQ+xuzQTy9cuVrIH/3u32yVZGdwMaiSKhPaa5iu3ZKPlfbN9bii2g5T4hUst1Y5pGbRJMcY723+cRbDWOuE0j50=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB4538.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39850400004)(396003)(136003)(366004)(346002)(376002)(52536014)(66446008)(2906002)(44832011)(71200400001)(66476007)(66946007)(38100700002)(186003)(66556008)(122000001)(64756008)(76116006)(86362001)(5660300002)(8676002)(8936002)(33656002)(55016002)(54906003)(6506007)(9686003)(55236004)(6916009)(316002)(7696005)(26005)(4326008)(83380400001)(478600001)(4744005)(966005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?n+sbqBM7PQXAoy0u1dkc0fHGE4EGftpFMMdBcjK9zDOsZx//3rcT9mjj1OHn?=
 =?us-ascii?Q?oZ7J3iZ/HGqVd8XuFrTj3L7pUBp2gyjAPf64682CwsEtfv+jeCKiP5dcVKJn?=
 =?us-ascii?Q?a/KGpNE8WRDc70xtv8QdWPrh3IEuvhwj/dLk15uZlKzCkZ52ASSDdUYpjg8W?=
 =?us-ascii?Q?uEDppItcbBI2E5H3bS7YCzJofo2c0nMqB5H1QZveIbeGomIgX6rrX+T3aau+?=
 =?us-ascii?Q?9MIZZdIT4GKNYyOZLERvU7V7flQVWFSRUgtOjiZ58iNekoh9fqTDOZ7WXu/O?=
 =?us-ascii?Q?+9WAtbmZqZ+ESJNRo4TG9gIGKZRaVW4bXuqZ7RrA3pOLFdzL8pA9smtsDPs9?=
 =?us-ascii?Q?azLLDUtYtPBAgrEB+qIKvx7FnV+VENdH00fNR5xXx81V6FwYyrXBvEyvlqfH?=
 =?us-ascii?Q?kt/g2fmbOLUqHSWahdJBW/0XiG8TGyxh1uBbe6NSOrz/bUtcCMUqMgljmWoT?=
 =?us-ascii?Q?pOmSEWMVY9Uj0hg0dqr5M+w0gT2lx5JtEffWriM4GjLFU+kmfxsSqTl1p9qq?=
 =?us-ascii?Q?SOPpLNgl9wTwEFGGMVo0hSB2tOTMm5Ax7rWTWPpT1ipdSfsolUZNXtBiKy8j?=
 =?us-ascii?Q?dHCyp43LopxGmC/WO86njpky9qQEITfR7Hy6a7ChHmf9meKsqqcKWiJnMjgC?=
 =?us-ascii?Q?s6+QzCumeSrGj8e5fSNbgNdIOf7cm2ZFjetmUuwn0z4N7jiSSiBurNO7q4fE?=
 =?us-ascii?Q?UCZWUyqSN/GWS+1mymPP6g9UorS7ZzFr82VWxdL9AXtmj9xIXOOW5/RFocoJ?=
 =?us-ascii?Q?1aGTF09ul+1qkJMPgxNzi1TBGIhGCxpWnYwsHhWvR9BvpGEOdLpA28Sw8a//?=
 =?us-ascii?Q?yuGXrkQDne6ocwI60omQWi5ky2wwKPpOUXfjfzmBM6rRUbiwF+FzcECPNceX?=
 =?us-ascii?Q?Hm0kBYT/StVyZvQvlu9HFdZxG9q9+Mcjr4wc8ODXlAcmKkhhqPe5RAw8Octt?=
 =?us-ascii?Q?NmdXACVtJVf1rPwuYBiEqKMcsNlucOc8++Zp6IXyjX7/CufwVzF63ZXUMYQC?=
 =?us-ascii?Q?5636WwB8BFJcK9JpKKT/9OH49lC5zwXclW4xyUGC93fr5Kx+moEInz22AMJ+?=
 =?us-ascii?Q?nX18i493GVQ/XfZjelEa+MRdTgqLM5SLJQ9MSq4eA5tPFhI+wNU4Wgfcx5Zx?=
 =?us-ascii?Q?uHFtWQrA+LfDIo76opf1jBerIZY3ezlm4j6thoi9Q3Q5XjzN5jH4685/cOMl?=
 =?us-ascii?Q?cES7WhsipUNYnekYY2US58d20fmk9gtgZ1FyaqpbE6NXjEruwcJnnqi4I5VN?=
 =?us-ascii?Q?wEfLyl+g/nBuVYSUWJHvsyZ4DDqlQtU62D23PBbZeAFNlgA16vQiwE/Ohcwy?=
 =?us-ascii?Q?OVr3rOUJuzcH1w2CYkt+n43j?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB4538.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca9b0a4c-7f02-4a27-d9da-08d93f8835e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jul 2021 07:40:50.1356
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kFN+scuXtV9D0uvYJ+GPVlprxKVfe7we+76eYHwu8AsAqnGEQwoBmcrEWzsC1zsjKh7kpRMbKOfhFnLN13wVs+Ckf3IPfqzU+65C94ZArJ0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR04MB3144
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The following changes since commit 2a0a062e79b5fe9007e57c0fcd285e683e22373e=
:

  linux-firmware: update NXP SDSD-8997 firmware image (2020-08-03 06:51:36 =
+0530)

are available in the git repository at:

  https://github.com/NXP/mwifiex-firmware.git

for you to fetch changes up to 312ca028298317d2babb54080c056408cdb9448b:

  linux-firmware: update NXP 8897/8997 firmware images (2021-07-05 05:42:09=
 -0700)

----------------------------------------------------------------
Sharvari Harisangam (1):
      linux-firmware: update NXP 8897/8997 firmware images

 mrvl/pcieusb8997_combo_v4.bin | Bin 634228 -> 638992 bytes
 mrvl/sd8897_uapsta.bin        | Bin 701072 -> 717068 bytes
 2 files changed, 0 insertions(+), 0 deletions(-)
~
