Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7026921AE6F
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Jul 2020 07:21:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726774AbgGJFUl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 10 Jul 2020 01:20:41 -0400
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:28889 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725943AbgGJFS7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 10 Jul 2020 01:18:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1594358339; x=1625894339;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=OJkYJEjqBdX/hZRKoSzOjW0UkkpwScYBqnXbvUZOvq4=;
  b=CD1QAjaxsZI12GoVmkbFQudsW8l+Uki+FXERDZSNHNJtAkgBHfjwG61t
   AguwUiNg3zyl4TizGw7mO3lbGGTf0g7eFUHrq1aeTBCWlkPFaUwvkrqy4
   qwMDP+qtfYfygwjflpFekclpQMmWY70dunKLQbODwNW3VMwXCRqrgJiw/
   Ivf3ei7br5hIrYCfkUIYPq2wlM243/R1DqrfKL2AJSVqC2Uhf+FFTY5tX
   aaangBel+VGkuIonxHAZaPPcPafV67+0Z4jwuZ5jmt/gLhr6yp3e5s+5z
   UY0j4Pfkfg/TYN4miV5pWkKMz470ufstQhjvwvrA6TX3kh17qiZLl20Kp
   Q==;
IronPort-SDR: GcydowhgePmAAGpgg2cLYv2ITHBDl9Zv+tPtTHuaUF6d2Xn2KwWC/9I3hEfJp/8gT7bfvjkLH5
 BoYlcq3u7Y2Sz4Yjpe/PVAsQCfmQ62FKfRaXWxrz3TFfDeQCyUWQGn6Aj9pG0UPYlrzC/KNaVu
 iJpCgJGxUk6HxXR7P67Q8IBis9sHCq7ZIqNw2DI/4DhY4vwrRh+ujSD9zgmvte8rqF8pCXL9xG
 E5BUvNCXWPt5EL1YlY/Z6rNeq+Lz35GWwmuPbcNVTTL9LL845GS34hj0Fo0Wsj5igd+FDC1w18
 8ws=
X-IronPort-AV: E=Sophos;i="5.75,334,1589266800"; 
   d="scan'208";a="82539358"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 Jul 2020 22:18:34 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 9 Jul 2020 22:18:04 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3 via Frontend
 Transport; Thu, 9 Jul 2020 22:18:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DT+0AccF5QqD9bPT2WLiUmsJapOMrGob9zHgrFnzhvVDSzc/oAjbUiLfYMIWPqDZeoLz0HACixoKKE8g0qbAy1HdNZYxi1VrjifY1oKDCHDbSD0WXyni0mNkVpfzzItIUcz3z1tbeLiNv6SjvV7ljeLnDQ7haSlRCOr0K6qGrL8T6U1CEcFT1kGN13VulV8vcdb/87wptk6PRHwfDctVnuU7hU7uUT5035raKM81xhuL5O6ER9lFAJbEjhIARjLE0oE034M20ZVqeVT2nMA+r6DkY61xBG5Fkb1gEfvaivBl1tBHj379i8t0ewTIvs95sAFNaU/mjZ7xJs/rs5U+Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Rm8Uos4S8t0WAyaMJnoQ7WQ3jHcu40PPhuyDVFA+Sk=;
 b=X/W83h6nX543Aym4NBBCYngKMHKfC+UwzmBKjuDL2qnep5X9sYrHxCQoFV2OcwrH64BqIDtQ6rk9LGQ6pfEnN/G2PqJaPYlwvaZkyKcFUDW85ZoVc+nxb1K64uM6Z9sgB4CJEKUG53MBeW8F5UoLPKqICjpyYJK71SGwjbhdvmYO8zL0Z4nUoDneAwRDoJNVihbYtf+dzM5VswTu7Pp0SxQRWRX4LPXlvN7eQQLyGtiYIq34Iw0ni6Ug5eW/a0n2qTrqGHYelb00mx0vDKvF5MN3XjkHSbjoRLMPfa2XFAF5AQCpFI84PAcMXpjnYG8L0MHDlL/kmszt7mhVqLanWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Rm8Uos4S8t0WAyaMJnoQ7WQ3jHcu40PPhuyDVFA+Sk=;
 b=J22od5fm28F9FSyemf4q0AYXvrFX/0BTBpBLiLmNNDWTo+5FYCacSmvqZ0Qy5IuebUFpf8l6PZYJboJ+UwYtOulylmD3yXDWUZLKhh5o3CnFNBH7i4vwGk8N+PNU0ELFSe0z5sUoKWIBsjK9/xTQkQwlXJqAfWI0nnPiY+sOdAo=
Received: from MN2PR11MB4030.namprd11.prod.outlook.com (2603:10b6:208:156::32)
 by MN2PR11MB4128.namprd11.prod.outlook.com (2603:10b6:208:139::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.22; Fri, 10 Jul
 2020 05:18:30 +0000
Received: from MN2PR11MB4030.namprd11.prod.outlook.com
 ([fe80::3874:6ace:6aec:deed]) by MN2PR11MB4030.namprd11.prod.outlook.com
 ([fe80::3874:6ace:6aec:deed%7]) with mapi id 15.20.3174.022; Fri, 10 Jul 2020
 05:18:30 +0000
From:   <Ajay.Kathat@microchip.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <Claudiu.Beznea@microchip.com>, <Nicolas.Ferre@microchip.com>,
        <Sripad.Balwadgi@microchip.com>, <Ajay.Kathat@microchip.com>
Subject: [PATCH wireless-drivers-next 3/5] wilc1000: fix compiler warning for
 'wowlan_support' unused variable
Thread-Topic: [PATCH wireless-drivers-next 3/5] wilc1000: fix compiler warning
 for 'wowlan_support' unused variable
Thread-Index: AQHWVnmM3r1PCATXhEWvwUrMYmvu6w==
Date:   Fri, 10 Jul 2020 05:18:30 +0000
Message-ID: <20200710051826.3267-4-ajay.kathat@microchip.com>
References: <20200710051826.3267-1-ajay.kathat@microchip.com>
In-Reply-To: <20200710051826.3267-1-ajay.kathat@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.17.1
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=microchip.com;
x-originating-ip: [49.207.205.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ca4d1de9-1d2f-4614-f8e9-08d82490af30
x-ms-traffictypediagnostic: MN2PR11MB4128:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR11MB4128FC3D2B991B2AAB493E04E3650@MN2PR11MB4128.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:296;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: a6MfX3XVlS5mIxBXkfVq7QovgLaSXTB2efEML5HWE3vMg6nql8LZoCSARkGFgZjSb7bWi5acGTVBfgfnjyZVIxU1btuRfht0Z7JffcGSeRQ4x4UPz4hrTDB4tPfyGWaNdiTAyfqOmq7vWAQUVFBlzQZ8c58CbpYTJT1nuDLIvkJzugR3aY8IoqUmhdja7oB9SntiVfiUeUJyFL9jwRhr6Ugx4NcsDo/7sB5am78VVpyb65enZLxaYCfeWEuvb0XHj1Ck6v+T8UAm8IH3UiSD0meu6a2vMmZxxcAfDTNTypPSsXu4bWdSzpRDjqDnCAjX
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB4030.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(136003)(39860400002)(346002)(366004)(376002)(396003)(2616005)(4744005)(36756003)(186003)(6512007)(26005)(66446008)(66476007)(83380400001)(66556008)(8936002)(71200400001)(64756008)(8676002)(6486002)(2906002)(4326008)(478600001)(107886003)(86362001)(316002)(5660300002)(66946007)(54906003)(1076003)(76116006)(91956017)(6506007)(6916009)(55236004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: SAB4OCgDapj7bmYtSevNrbZB/EiTB6Xr2yj93UzEfsBQqUZxMUOTD2V3MDGQRRXC1T7elZZw5U3gtcZ1DkTVT4KSmF1aCAn2tMX23vzkmao3nagUwgeDI/6MLbcmzIfJTBsmOVRBnw4uU8vwurLJumG9yR3cO0oZs/NtYD9bJhrd4hi8uMoDpzuWahyBiaiHemHTa2F84zTyH670P1k98RNMV9qEbOOpxzFRQ6kNVo5J5Elb2W7X5/KpvANm7b5VPq2OLktxpRB0ozqPGR3gFYnBeyB/3NJBEu3rhO6OwbUsw/pJwu8Pe4D17gvvHoRi1MY9EQbImyfroAT9pkDtDWH2cW6KmW3xiIYrQVDh1GLEQ7Pvp27oULtDBy8WKQ6CM2ZF6xjTljgnr0cIGxnS9Ytxa3nmLHcAPqN/jJrNJh/SmRLok8ne948jJUXpuzxqTeCNssx43PTkEFh49gXN5TK0hodOvzKUs5HCxWTwnNBPlmjkHhS4dA3q6u3tXjNA
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB4030.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca4d1de9-1d2f-4614-f8e9-08d82490af30
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2020 05:18:30.5668
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: a5oh9oUTICiiud+T15pr3fK3DsR/SqFJY6wRh2JR7rIi679KKM+6y7vRVNxWH+5HLJMDL+QzwyCuVqTrnNxe8IDWFYnt661mwwgJudtss5I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4128
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ajay Singh <ajay.kathat@microchip.com>

Avoid below reported warning found when 'CONFIG_PM' config is
undefined.

'warning: unused variable 'wowlan_support' [-Wunused-const-variable]'

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Ajay Singh <ajay.kathat@microchip.com>
---
 drivers/net/wireless/microchip/wilc1000/cfg80211.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/microchip/wilc1000/cfg80211.c b/drivers/n=
et/wireless/microchip/wilc1000/cfg80211.c
index b6065a0d660f..c1ac1d84790f 100644
--- a/drivers/net/wireless/microchip/wilc1000/cfg80211.c
+++ b/drivers/net/wireless/microchip/wilc1000/cfg80211.c
@@ -46,9 +46,11 @@ static const struct ieee80211_txrx_stypes
 	}
 };
=20
+#ifdef CONFIG_PM
 static const struct wiphy_wowlan_support wowlan_support =3D {
 	.flags =3D WIPHY_WOWLAN_ANY
 };
+#endif
=20
 struct wilc_p2p_mgmt_data {
 	int size;
--=20
2.24.0
