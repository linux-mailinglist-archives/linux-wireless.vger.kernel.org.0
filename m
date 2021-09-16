Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C929840E3EE
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Sep 2021 19:22:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343493AbhIPQxI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 16 Sep 2021 12:53:08 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:30349 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345834AbhIPQuz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 16 Sep 2021 12:50:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1631810975; x=1663346975;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=O03shHD9AdVydntQLPB9UvlRSddx4mPV4LS2537TdOA=;
  b=yDa55hRq9RBFl6fOw+tlcYuogRqO7Dozug8tqAMT8vwjCf2rX+0fIYu6
   FEYXnmZSPfi1k9IkHXvFTJR0fDSc0FJQNRrBQaoD0GJ+rLqpbMoLiEpry
   FSRN39rK9Ah0iUeVOZV3/6fRwUOGxPU1ObGpaFzySd5os0ZhE9tE4kjmN
   EYxuSykUGFsbhGBdS7zy5J29IdglN7ybcMqmyGedKb+C/faSkjr+ITYg3
   sOtQdFtlxSDQpi9AHcxPtjyB20M18nBnVEYiKq1/AnbQ98bDS37mIEszN
   yS8Ahft9maORNVX2xgDDyu6OqIZLtArPwC7OUCLjFHuzFRgV6BgDQ59y8
   g==;
IronPort-SDR: uEEikgJ6O7qHyOciPLZ5SEh+toz/acig2TZrDLH8VhEQ6OEbEat5zCKWFeSmT1QYZhUp5ihBC3
 BtbBJ78R2zvFDBbvNRhAdZdso+VF9FAY8oBt1KiWj2kW6v0tc5aLuRnL90YMajwoNnkMRDVBrC
 bcLPTXcl7CUGIWdYPCE0c8Kk+YlsiRH54BeL67LSR0klpnNuhJvpOmrcLyPt51h32ZhTnRJl6a
 mEVgR5p4HVOoPBnHBekxxxe3bk68teLHZd1zsmsYk+GG7DqKypBtYr33kvx1D5ZsnXYgx+ca6R
 NnSuZA5d1g4JconeWkwKwAt9
X-IronPort-AV: E=Sophos;i="5.85,299,1624345200"; 
   d="scan'208";a="136238769"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 16 Sep 2021 09:49:19 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Thu, 16 Sep 2021 09:49:18 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14 via Frontend Transport; Thu, 16 Sep 2021 09:49:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=InrkrmFAMgDHoXMGCGkgV9wMeIoWEniKnFG/GsRVUo8JXkyN+4Zbeucs4YzkFvNCJdlbRUbKKJVmbaKvhH5JLY8fF77+eetUZAfPN/vjKERp3xElSzheGoH0U5w96U2MQ3Sb0qdI9v+NdplxDfJJon5OglMbr11fMGWAcg+ZUGUNCuCCvYXclFpwc1C+WqjT4CbGzTiXmC3pIldmUUgxaHcJFCgL5F7KGkHyYQUhJduQBJUJlRqO7aUCzBuO2Ja7c73kUfrELRedCtYtx5idXyiHgCTs3xGHNmC2nuJgXGq30ZLU+15LEhM4cNjZ/qh+nhwS0nxzOWnEO2HE3xPtrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=VquF/l+ZDjSNEtda0L5aYIDfvPQGk47PnAnunGjyW9k=;
 b=eK67mSEcu1KyPcDmp0r2cPyAHCoMQtaQTRbpmutlkkrj2qYOOBzbRNI0hSyT7FyrsQOg9bHcRVvo8bLtaOZAMaUR8v4tQ101rBieQ4QRbs9XmCXXRvonhQXcoaolftMhCm8LFy7UvE/hvgBRfqG0onx538o+GJlzIIMk/m7YnB1Nqujp4oI0Wtg2wNQEMAPm/tiPCsBr8D6UAxp6fVuQGJgAgABkBfYiZJzWruiWTeYjpw3FXweMy906jWaJXp5FIPyDaPXTQw7o++OxAW/N8yyycH3ZANcmnmkRI8LI6uZ2bGiOquSMqVWOPX8/RMVqualTX9Rcc0uQdoWXwSjKaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VquF/l+ZDjSNEtda0L5aYIDfvPQGk47PnAnunGjyW9k=;
 b=rw3iH1VAbDMzixZap7WZ37asvW/CC+30q0giApsNJV0wJwToiA/RnhVdEVkpVwFBYK7tXwPzfPqBXVqt1iWwP+3wxvTAxIgKxZcBfrIEVaWD4XT0PA52h90oZo4R1xEn03T7u8dPbodcFHAj43xs8LCa7WIpP9mPPw4OUNmygt4=
Received: from SJ0PR11MB4943.namprd11.prod.outlook.com (2603:10b6:a03:2ad::17)
 by SJ0PR11MB5197.namprd11.prod.outlook.com (2603:10b6:a03:2d1::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Thu, 16 Sep
 2021 16:49:17 +0000
Received: from SJ0PR11MB4943.namprd11.prod.outlook.com
 ([fe80::b095:c8cf:1d0c:a3bc]) by SJ0PR11MB4943.namprd11.prod.outlook.com
 ([fe80::b095:c8cf:1d0c:a3bc%5]) with mapi id 15.20.4500.019; Thu, 16 Sep 2021
 16:49:16 +0000
From:   <Ajay.Kathat@microchip.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <Claudiu.Beznea@microchip.com>, <Ajay.Kathat@microchip.com>
Subject: [PATCH v2 00/11] wilc1000: add chip wakeup support and few fixes
Thread-Topic: [PATCH v2 00/11] wilc1000: add chip wakeup support and few fixes
Thread-Index: AQHXqxrJNnEC6e3TWUisxhLDPofljg==
Date:   Thu, 16 Sep 2021 16:49:16 +0000
Message-ID: <20210916164902.74629-1-ajay.kathat@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.25.1
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 65e07aea-ebf4-45ed-888a-08d97931ec06
x-ms-traffictypediagnostic: SJ0PR11MB5197:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SJ0PR11MB5197416121BD65A780A54A5AE3DC9@SJ0PR11MB5197.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:361;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: k7JkotBAw1fqDAZsERNojqTyZ6wYXpkXWQAv9bfxF/AFFuxSjABagE6OzV+9WE2sH66fQU7VhUAE5jkis+kJGoTC/L/UFv7hsIksSSuxyd8IaPssUE539K977UNbE56TVubTjupzoWuX5lapDclr+WVcxwcHX6bUmOg721KnXRTX3/8t8ChLs/XPP/gtZzTFBDFFQsWpkFLz5vU9GPi6mVpGjGnxTCPTCC5Ar1BN65Y0btsUMP9wvq0hAd1/dOI7QH0/g+d9tEqCtNtBhUAd/3cdcUb4SYjzTTU5vMtDAaRK0W0ak8RBh3F4qAtoiF1cBPLSBBwhjSStwpyIXuW/JxEFiwiRj3J9AOvKfgmUPJ6Iy3isHhz8AQhYsSVMPnbKIHlCLkVbI66jfARPcdlgoKoL5VJIkkxdlTahBDskHl2JQtp1dRe1B2R3KheY6vQyLjroJ4el9wcUqNC3dT9L7zIGCC9K7uNC60jXp2DP3jOyH35lb7yYkjH0bSs5zMC7QOhLBYACQqyO4cbBRmVYTRv4m0kdDJX7PEopSgj3PlVb5DgLvJ5n8zeRQ2QT3FNNYaNl+aKzxcIfzbMqT+CgdzX2sx5HZkLGliuLVZmodmmw8dXFsmIKBJFb5kPpEAEFabRVuxRTVoFgSKRZctCmIwQ1xAIqMQeHYoRVw82Hc1hKRNHRvFs3HGlJ+4gJw8Sd5cPWOsv54oewafp4OT7Kiw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB4943.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(26005)(107886003)(54906003)(76116006)(8676002)(6512007)(6916009)(66556008)(66476007)(86362001)(64756008)(66446008)(8936002)(66946007)(91956017)(122000001)(38100700002)(316002)(83380400001)(186003)(5660300002)(38070700005)(1076003)(2906002)(508600001)(4326008)(71200400001)(6486002)(2616005)(36756003)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?cEWAuTFrL1iKgjp+JWJbz/r2gIwV3+JsLMMou2g7amkv5i/3F0x97xjFkJ?=
 =?iso-8859-1?Q?i0MaNEMEwvFx7q8N8dgN2FpeSYgdidR/oiVAfwBR3z5m2f0ShhPsnyj9tg?=
 =?iso-8859-1?Q?NGtxXXOViPveECLDHAfPjvz3KGnUZ4OP38CBbx7aLV38VQ+IqwOQSGOtd8?=
 =?iso-8859-1?Q?7oDgwwIvTs7XV11ewprraMmkl45uYi7rXB8posAEc1WmlL66jwmA4Cdl7v?=
 =?iso-8859-1?Q?1ANBfCExQ485lLzCrEIzjb/YkyvBwUU9TONpF9TBUOaLiB+pTEssqE1WGY?=
 =?iso-8859-1?Q?2x5ciPAbt221QqaOU0fYFSut/DDCsUB7Z8huCQBVsNKvkGShnRkIn0FTfL?=
 =?iso-8859-1?Q?2yvCGwRDks9+Rrrnn53j29Y//3O9qXb0hcsKjCNUTKhe1IVM7wJh5hZuGF?=
 =?iso-8859-1?Q?kFBhWAmb4WI6WDEgyGoUckIZNVr9SN5B9zHA2CgpLX+djefHmDgdfGTY8s?=
 =?iso-8859-1?Q?ntHt4AbhFUncq4J81mqqqaPElpVLiDMRExlEPsHzVEBAIVioNzAevSuFH8?=
 =?iso-8859-1?Q?KS9arU4aa6XoGb4zQqzFNmbhi0HVXyBwOoeY2K/g97h1pda1NMMZabq3wZ?=
 =?iso-8859-1?Q?fdOaWIupvfga9ce/oItC8UfrbS0GDmG3cuAcHVODQu//5JBxTF+4ILJm28?=
 =?iso-8859-1?Q?XL3fzX1RRUsnjsxkJFjx8Q6BMBfiOo1d9pvsRNN12MUE4xvaRu2Cf7I0r9?=
 =?iso-8859-1?Q?ssjM4kSnccYUxxg5X1sdCIcSTlEsTY69s4ILdLXX41L4A3R8jItl0s8llD?=
 =?iso-8859-1?Q?YQYB2Kf6+96nJjqkkjKWIvKo70SnZ4yGGyXMgBpnlv/55Vy3VVr+rGNkcq?=
 =?iso-8859-1?Q?BBLTnD2ynlBevupsNf8jeXnBNl4cZNXYWkwuozuawBDooty3ezzE4lAb7h?=
 =?iso-8859-1?Q?9KDlYGCdBRe6zjBLyKrvKjA7953hlyA++ggTqEAHGZlAZ+3RObGVp73RoY?=
 =?iso-8859-1?Q?tUj/90m/4KdoRfX7t9Z5bVNXlRcoyPSfbUHAcVM1hqenXZjMtIQr4gasf4?=
 =?iso-8859-1?Q?cI0//ECgjeTR8EwJZxKZCzV5s3kPr7emM44067Zg/VQk6tTNVqBqUQdNXn?=
 =?iso-8859-1?Q?MFm0rmJA9VpqpLPjoYFVoXNJrCVaJJn04tgWSftHa/lNkXVnLKfWhaVroI?=
 =?iso-8859-1?Q?Xjiuz6XFovhBLnXMzPQus1Fvd4fQvOdWqUVbyFJe6LLBJ7FsiOCU/Eci4r?=
 =?iso-8859-1?Q?S3nYSVx0hrEPyiO453Wf1r16pNPl7RwOgWtHZysGOxcLzdJ+dho3J6li3i?=
 =?iso-8859-1?Q?uKyQNHA2jxKyC06Qrd3FjpyO8xByBrANc+ilLAR+Igh/q97kkQlf32gYjI?=
 =?iso-8859-1?Q?XF/vZ+HhGbGRExGjzzxwZVCaEbcKDWu9WLC2+2/h/0+kI5hbTHy79WYKRI?=
 =?iso-8859-1?Q?1DDF2FOdq6?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB4943.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65e07aea-ebf4-45ed-888a-08d97931ec06
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2021 16:49:16.8341
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JSqDFv+iTSis5yHHpYD0prXqffmTqkR7/7aCQS/sI8qgTOj9tPgfA1L56rCKHwcb0YGHyu1wBY2eOxADxAhQLc2Ots5AI2S+V7SkdFaIv/I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5197
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ajay Singh <ajay.kathat@microchip.com>

The series contains following patches:
 - add chip wakeup sequence support required for PS mode
 - new WID to handle passing of WOWLan info to FW
 - add reset command support for WILC SPI bus
 - few trivial fixes for WILC SPI

Changes in v2:
 - updated commit details to address the review comments
 - used pr_debug instead of pr_info in patch#8
 - removed patch#9 as those changes already merged to mainline

Ajay Singh (11):
  wilc1000: move 'deinit_lock' lock init/destroy inside module probe
  wilc1000: fix possible memory leak in cfg_scan_result()
  wilc1000: add new WID to pass wake_enable information to firmware
  wilc1000: configure registers to handle chip wakeup sequence
  wilc1000: add reset/terminate/repeat command support for SPI bus
  wilc1000: handle read failure issue for clockless registers
  wilc1000: ignore clockless registers status response for SPI
  wilc1000: invoke chip reset register before firmware download
  wilc1000: add 'initialized' flag check before adding an element to TX
    queue
  wilc1000: use correct write command sequence in wilc_spi_sync_ext()
  wilc1000: increase config packets response wait timeout limit

 .../wireless/microchip/wilc1000/cfg80211.c    |  11 +-
 drivers/net/wireless/microchip/wilc1000/hif.c |  31 +++-
 drivers/net/wireless/microchip/wilc1000/hif.h |   1 +
 .../net/wireless/microchip/wilc1000/netdev.h  |   2 -
 .../net/wireless/microchip/wilc1000/sdio.c    |   1 +
 drivers/net/wireless/microchip/wilc1000/spi.c |  91 +++++++++++-
 .../net/wireless/microchip/wilc1000/wlan.c    | 134 +++++++++++-------
 .../net/wireless/microchip/wilc1000/wlan.h    |   5 +-
 .../wireless/microchip/wilc1000/wlan_cfg.c    |   1 +
 .../net/wireless/microchip/wilc1000/wlan_if.h |   7 +-
 10 files changed, 210 insertions(+), 74 deletions(-)

--=20
2.25.1
