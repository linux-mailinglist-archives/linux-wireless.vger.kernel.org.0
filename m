Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 971CA3699A3
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Apr 2021 20:29:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243694AbhDWSaX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 23 Apr 2021 14:30:23 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:44321 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243644AbhDWSaW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 23 Apr 2021 14:30:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1619202585; x=1650738585;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=zYvILP8Rf2g/5EWAsFVuI5Fhp8IkZQfO6GVJIrt8TrM=;
  b=otPbxOaOI2HPgp12xXnTMe1Xq/itdl3LazLxAQdGaDAOFR5RctjSSWp/
   LcG0yLdVCRgwHn83MWUkMa1njQzmGa2rx5YA0uOSnk4TKQTyOJYTkoA26
   emwOxPJZ3aMaDOIBKUZEAwT+TfBSKKWR+TZ6HoV8ms/ZnxsvzBlZv8tfh
   cKFVNDl56G88tYj2TTSWOlnrDZ9kQhHXAyfE4jO/H+Iv7rpSqSxz56w61
   luh0gacDZjnoyX2aMWb0P5R97mtouPjTEXjzhGnFUte2eXDI1B2c8ngbi
   lQ/8M9ehOlsabfYkY1dRKAp+ILQlB+O697uDZKsDSLRYFYERw8AdsZk6c
   A==;
IronPort-SDR: +E5Z6hTJ4+NMJKAfJ51l1YNnPN/POTLtVbVfOxNmdfJLJ9MOlVVuJf+Y78PUG8ctWf7LdDeBPa
 Ol379PqjAU9dvrjtmWgsmak2/9gxHXk0skG3h/eIsV/avc/YPiETsiAU7LHyAmp2nlX6avBzn0
 yj5Vtb30LM3C4op+T79/jtINZVmgQJg4mk42TA8sLyG57umH/aT3rt5SSsCYaoxJKW2FR9wFkK
 FrDuGDfbtzoxh7lEudwuMxiEagxzAv/JZDnQO+rlE/kJLMyyeYOH8RHoeZ7DYY9Xlb6WAK7KbQ
 yDQ=
X-IronPort-AV: E=Sophos;i="5.82,246,1613458800"; 
   d="scan'208";a="111995808"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 23 Apr 2021 11:29:43 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 23 Apr 2021 11:29:43 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2
 via Frontend Transport; Fri, 23 Apr 2021 11:29:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GppFmCQ1C4YOcD2CXvNmaUPe3b+d27f8Bzuru11uPTuoZFC9Ouw0l6Oq3/jPv970hMI7B1WBCURI27VFecY0ZtbMLhX3EeAinB+7LtSC/p0kZzaFc32UNC8X4W8pdX6WXoyyV6Sou3yEcGBmgwyELZ56IwetSxKr7UefqlBL3xf49sTeRVO6rt1yCTn9RN7rL5DZnxmIq6tjfiZGPHS8YS2d5860RnkZYaQ2WIP5If7BH7n+qTqkm8XDDrwU/1YQnGGKuZxHAbAf8Q2Ic0ymRK2vYX7yd8IzaBjiPI2Ib8uwIbg09dhJTu2zgf09YwjAVUhmQOJ7+TyheDsz/1ug0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z8CPrBjyO+vtn+VcXgfWJqfTRkEEerYa6pUCFiNCmuI=;
 b=Lw3B/qkN85LKUVvsFV3YNGySG/y6ZnHd5JxVezqQuj5lV9D8A4VzFWCvp/dcqb0Zf5h9YXO9gEiYe5O+76QCCh9AvZkxQYnE7J9kUezkx8qZlDo4vhcZ/HymbqTCvIMAGYED2o4FvFtAyfXhb1YeLQrCwP8ffkaJ/xXSc3w2A9IZ3y4ML5lJCfGqt9EemugHH7X9yc5K5tFH/adZ9IQckLLOjAz6QMWRg8NYEUfzXLq7BvKAghJ3glJ/fg6Pw/DGPxVGFSki+bTf04xUub4kGIjub6NNvjldybBwy7eBPRzTqgYfSVginibrrQrPfNKm1iMSQlI6oq7AlnqxYLW/BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z8CPrBjyO+vtn+VcXgfWJqfTRkEEerYa6pUCFiNCmuI=;
 b=Zoe/jS0Gw6+1KzdRndoCdS9QS9GxZbkruCjARirL1cMVX5NtuXEnLa/F7dAbU2EJU9Ke/JnjCLOn/G9/XAfCp/Nf54gQBwOHzZeCCjpg2/oO+gCDyV3v+K/+cdjznfkQg5Sh2t0MU7CtJ9dF/C1Od2tRCsnHoiHzmLfMKDKgbww=
Received: from SJ0PR11MB4943.namprd11.prod.outlook.com (2603:10b6:a03:2ad::17)
 by BYAPR11MB3493.namprd11.prod.outlook.com (2603:10b6:a03:81::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.22; Fri, 23 Apr
 2021 18:29:40 +0000
Received: from SJ0PR11MB4943.namprd11.prod.outlook.com
 ([fe80::5da7:92e6:d6c9:64b3]) by SJ0PR11MB4943.namprd11.prod.outlook.com
 ([fe80::5da7:92e6:d6c9:64b3%7]) with mapi id 15.20.4065.024; Fri, 23 Apr 2021
 18:29:39 +0000
From:   <Ajay.Kathat@microchip.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <Claudiu.Beznea@microchip.com>, <Ajay.Kathat@microchip.com>
Subject: [PATCH 00/12] wilc1000: added chip wakeup support and few fixes
Thread-Topic: [PATCH 00/12] wilc1000: added chip wakeup support and few fixes
Thread-Index: AQHXOG6f05pyT6CEU06oRygC9TnEDQ==
Date:   Fri, 23 Apr 2021 18:29:39 +0000
Message-ID: <20210423182925.5865-1-ajay.kathat@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.17.1
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=microchip.com;
x-originating-ip: [106.51.107.119]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: abba89dc-3fa0-4bab-00c3-08d90685c1b4
x-ms-traffictypediagnostic: BYAPR11MB3493:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR11MB34939204B6B1D42355791672E3459@BYAPR11MB3493.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BraAXsQQmC0s2ClFKZD709AAroiounjhdIg4/VDcLSJYY+mw12YUxUX2b+Ci4gVF6aMYGm9pvUU1L/FTUMTpbP3maazeUsNKZ7PQqOoPbUvOYrmeim10LXMSye4UbRKfLwSjANJs1MQwedMryp1m89iFz4oLLJlByaZgVhYAjM2fkGWY+Y+hlIOEpIv7QXJH3L6T46v6jZya/TQ8j8X21IIoBtHhVMA2EBN6/a/26dSDBdv64Un0sXY6mJkpcBIkkXCJJqAkQ7puBVIe8fwh7EmcRTxWQ/5QL/6Nn3tQVHC9YGkLef5XLUUYEiYrU6hPKW8dhk382QCvbuj3CpN0ZTgmWQEXURGRZ3/ZzQM4eqwqSlOIDkD19bDHpn8zEe3JEhvM7mrlJ49hegCDAn/vGfspgXuov1/c/3e0RVinCz9ctMI6O4fMXHRzZqEDiqnmwkbac/xDVZ5RZgVx+kFikQSC7XND6/twLdSEokkVI/+SlnIdiM8gZ6edoNMoaNTKoBxVTpc0cTwWlL5CcA9oGavyLlCVRdVbM0XTM1eGvHEfLz+KygIGzHhzUnEnFU3jOI2PoCyFT/lD339ej1E5+dzeKzrqlZY+CRF5Dy46wKY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB4943.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(39860400002)(136003)(366004)(346002)(376002)(86362001)(83380400001)(8936002)(66946007)(6486002)(122000001)(66476007)(6512007)(8676002)(2906002)(54906003)(5660300002)(4326008)(38100700002)(6916009)(107886003)(2616005)(71200400001)(186003)(478600001)(316002)(36756003)(76116006)(64756008)(1076003)(66446008)(26005)(6506007)(91956017)(55236004)(66556008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?e9v+wDLLqhwfVQlugAL4TKshm3wbzdhlS5NSSqlexZMvAsS5kOJH0fEa4r?=
 =?iso-8859-1?Q?bk4fYfjdn1JSglKL7BqeCFxI4jez+5CjSGuFeK7l9RE34tdCHvHwsKYTZ5?=
 =?iso-8859-1?Q?4yQUPTjf75CYEfKF89oP3FBR2Grxmi6mLANohEiHpPSOrDIgIdT4Hut+sF?=
 =?iso-8859-1?Q?tIwhgTI+HlwCEpAwTRMXkWjrPqhJBrATSU+vL9EvJCjppAzUDWmq+xzhbo?=
 =?iso-8859-1?Q?5UwwYMxD7R4f02LeF4mIpNzaAxNbN1SJYC+RKuHG1vTmXSVsLTBs7w6asV?=
 =?iso-8859-1?Q?M3ctzNIU+cMFqo5TQ1wFwH6IkoPG9nQnsLaH7LmiUsNMSSToHAS0T66e3/?=
 =?iso-8859-1?Q?HCyoQkPkulPJaPxzrBzOm7YBaRaCoxjMqAR14ItKlT1mBN1Z3vUF3lGjqN?=
 =?iso-8859-1?Q?g3WBsyNLqi2khPxqwNaj3TxsWZ8iLJJF/geT9xMtm167irhfo69V3peKyG?=
 =?iso-8859-1?Q?GkUyxigFaV+IqzziQuq3Kq4CG4l3S/+1YuL7nm9fhCssdLRG4mHHQsXd95?=
 =?iso-8859-1?Q?Ywq8m0rv9E/gXdAGHET+E8NOm40NN0T5dtIbRw1FURbjZsR3l3DWEV8M1v?=
 =?iso-8859-1?Q?l+6w54Mbwk6Z7otCWutwZb84o4Tqq3hzfr3nOM0RgvREVlorKFPqRNmRzP?=
 =?iso-8859-1?Q?osflIN0N6MHNpE2lpiuS3Z0oektoazV6+J1pv9FiQcz3gS4AEaJ+kHfHOk?=
 =?iso-8859-1?Q?T3+fEuBUCnaMEzt7ErlgDwnqnoG4y9Z7ExCcZVmhBKfHtOhrjyL5jh0pnf?=
 =?iso-8859-1?Q?L/RvIjJxHoEcvgmlkgdiuMuUZMElbxKSuVaXuwiumKJzI5dLdp97cSHcrg?=
 =?iso-8859-1?Q?9ASYxSSzDQKQ7/tZiaYvN+8ebNnSRl3zQtupvvVquISHS+MFiOt8V5wsEv?=
 =?iso-8859-1?Q?lA3CU/uZ3151QFf53dCZ5jFXyOd7uVwV9y6VdyeLn4ysKJ/+KOW2xonhwn?=
 =?iso-8859-1?Q?T4QYCr+IRDru3XDlC/eQalbvC3eAHQo0h6Hxhe6nd0PBrQjK2j62Pt9AvT?=
 =?iso-8859-1?Q?eeTtBj1hTpkEHkCA0UyeeIJ5fwUI8b7891u4qOb+X+b+dOMmc+YKbTmDSQ?=
 =?iso-8859-1?Q?l+J0CrJ7VaRc8SdztM1D1cmrrTqIHb7712/+vaF/vkQT6K0gJCz+Hea6zU?=
 =?iso-8859-1?Q?rAOWDLXl7hxkUzdqXCfLgfeY5ZQDdK2ss0H2M4Iy7mYyH7DZZ9YQ1aZZ1U?=
 =?iso-8859-1?Q?ih7gu8Qr1aqT3pL1fZ1cSstBQXFJuj/4gBeLu5Vy9I5CmTbxu375awlt6/?=
 =?iso-8859-1?Q?862U+D7we+kdaglc4gan0VVkxmMax0z/IVeUUE2ClRxEx1pyMfTPF0YL9j?=
 =?iso-8859-1?Q?+QXOVBBiWYTZHyHS9sadIQxt5Y4axVmmN6HS9M0JzJhEalwpkibl48cqI6?=
 =?iso-8859-1?Q?YRyqS9mRjIw/4M7cLRAA7xHhcayK3saw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB4943.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abba89dc-3fa0-4bab-00c3-08d90685c1b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2021 18:29:39.8747
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HOvzbvkSEI4T+ngkGDLyTSBD9o0qBJoLxJTR9Je9rpfMeSAp9bFfCrrGlPV/06DpbjufWvYwlJte8CSQUH3qYsp1AWNzN13C4np2M3CZXag=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3493
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ajay Singh <ajay.kathat@microchip.com>

The series contains following patches:
 - added chip wakeup sequence support required for PS mode
 - added WID to handle passing of wow info to FW
 - added reset command support for WILC SPI bus
 - few trivial fixes for WILC SPI

Ajay Singh (12):
  wilc1000: move 'deinit_lock' lock init/destory inside module probe
  wilc1000: fix possible memory leak in cfg_scan_result()
  wilc1000: added new WID to pass WOW info to firmware
  wilc1000: setup registers to support chip wakeup sequence
  wilc1000: add reset/terminate/repeat command support for SPI bus
  wilc1000: handle register read fail issue for SPI bus
  wilc1000: ignore error response for SPI clockless registers
  wilc1000: invoke chip reset register while FW download
  wilc1000: avoid 'isinit' static by moving inside priv data
  wilc1000: added initialized variable check before processing
  wilc1000: use write command after read in wilc_spi_sync_ext()
  wilc1000: increase WILC_CFG_PKTS_TIMEOUT timeout value

 .../wireless/microchip/wilc1000/cfg80211.c    |  11 +-
 drivers/net/wireless/microchip/wilc1000/hif.c |  31 +++-
 drivers/net/wireless/microchip/wilc1000/hif.h |   1 +
 .../net/wireless/microchip/wilc1000/netdev.h  |   2 -
 .../net/wireless/microchip/wilc1000/sdio.c    |  14 ++
 drivers/net/wireless/microchip/wilc1000/spi.c | 113 +++++++++++++--
 .../net/wireless/microchip/wilc1000/wlan.c    | 136 +++++++++++-------
 .../net/wireless/microchip/wilc1000/wlan.h    |   6 +-
 .../wireless/microchip/wilc1000/wlan_cfg.c    |   1 +
 .../net/wireless/microchip/wilc1000/wlan_if.h |   7 +-
 10 files changed, 240 insertions(+), 82 deletions(-)

--=20
2.24.0
