Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6521140E3EF
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Sep 2021 19:22:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241527AbhIPQxK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 16 Sep 2021 12:53:10 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:34487 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238471AbhIPQvI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 16 Sep 2021 12:51:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1631810988; x=1663346988;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Kjsk2OwPZMYFn1V6odvO3Mlg5qBwpRrMFPmPPFCuJGc=;
  b=oWU+WdLEPNvSIk1daooXupp1zflqRvw6deznQx9F4xv9oJzOMfEEsfDw
   uPMFK1Hw3FyrvhpuC1I0MDwUtX9a1GprkosH66t9fe8XVnEh09kAXwV4h
   cPbcPYX8YvgMeXF7yvGFViCr8FltfzP0a0GPie/JjvuUqdXHof9qrIqnC
   F16zQ2Yr9vULz6KQSOA6JlLBPB8IxKEyT6UMDjDZrp1ZyBsSmO36dznOf
   2VScDQSgizIFnvjT0piKoNawWPPlNt3/rir8a7ySJKUT5Dwl0sya89IvU
   ci2R6odccoXj4b/eDxJVWgKaXbPYPV13+9gclsRHaqG78YDtvz/zcUtjQ
   Q==;
IronPort-SDR: 3qX+pAxSHYrG5xeF1AIu22+M6SfZycDQJhQtl/75c+Bqiz0odwWTIv6+kpfJU5WSan+7sOH4Tf
 3UpuCHiRG41n+/uEXD4ODGRMSoq/HboNdN81nxUBNDtihSk6zJD7326pk/hOfPyNenbbG8S0z3
 QDRYquI13LyBGgeb3akPHD5bDMwxk6ZKlOs4Wpko/QDA+HngHH2yH8PmAtOVIlyq4FfAlJzUPM
 CO07/EqCzeiXW4oQyWySG86vikb1X4cqDNflLkEYQSVSpx6eaI2nDt00eTsUD63OrIDnBWM9v1
 sYIz/iQjMFR9LC/Uzl/ZPgdy
X-IronPort-AV: E=Sophos;i="5.85,299,1624345200"; 
   d="scan'208";a="144413534"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 16 Sep 2021 09:49:19 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Thu, 16 Sep 2021 09:49:19 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14 via Frontend Transport; Thu, 16 Sep 2021 09:49:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l2Nyv9yVIv7gpFCYujJ6VyyhXoOwbPqpb6oM7SlrOgkYXuNUNkEx7wegQldquM4dXMF5qbjY0NcpBjS7epxb8BsBKnrn2FBI830XPtwc44eO9SQGYWrxxH6T9UfFMwXRg9HnzMdwVbbo+J4EB6pGrzN1vzAw0iQUHwL4PruKOkjYMpnJ/npwLEmLWj861ZLlUCQxfRR7Yi8Ooh/gIFdkY+hV9PDfs9Dsvfb0Yk/DAWfC7E+wr7+quUNqkkRrhbBqjVPNPaP1MWh8BfAIH+CvVAnuETwVg+9gD62N+hSD+ZBtIFXmA5vibCMR/zEbsajpDxizZh4mbTbRTPriAOe6IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=vuvh5FnkckTGhhKvh4g8I4TRALWeS6/11eOLasQxU8Y=;
 b=i0yA4tTnJhmINFj/BHo/GqivAqocj+dbd9c4CFjaA6bMUVQKqEFXa/IBZfyUTSccF1LoZQ8g27Iyx+kqxRpN0gvANHoXcJYbKPCNEQf2Ma5TWgc9p8A2+aE6o0nXYS8SUYaWVq+V7U9OECPn3Vxflale6c776Zazn0saHl2cPFXeAbcbECdDITSmbV6UGeSxZW3nJgKUc6P/cyjWqT6THc7a7zqGPl8EFT4gVgIyFlVxETyigELIN424MX2hbKQkt8zQzsBaABlGcGzCge1gnBk9rLKR2lN+QjaXDOhbONKtulbz0yInPO4CkLqde3drsba48En4XDqgIK9jMHM9sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vuvh5FnkckTGhhKvh4g8I4TRALWeS6/11eOLasQxU8Y=;
 b=LrGkY/co070tt+YOJclz0UCxRAdN3jwds808wsTcogs/WMX8Qg+3n7PUGbNt/3ESyOplWHhLPSJ5NJXzLud4rzGpoKBWoLYkOIZoiimAUBDVe2IqR5lYVU0Iv2liDHoPOAIaqDTrxsKXs3a/xwXaJAIEADy0g5FjGAvtuqWJkBM=
Received: from SJ0PR11MB4943.namprd11.prod.outlook.com (2603:10b6:a03:2ad::17)
 by SJ0PR11MB5197.namprd11.prod.outlook.com (2603:10b6:a03:2d1::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Thu, 16 Sep
 2021 16:49:18 +0000
Received: from SJ0PR11MB4943.namprd11.prod.outlook.com
 ([fe80::b095:c8cf:1d0c:a3bc]) by SJ0PR11MB4943.namprd11.prod.outlook.com
 ([fe80::b095:c8cf:1d0c:a3bc%5]) with mapi id 15.20.4500.019; Thu, 16 Sep 2021
 16:49:18 +0000
From:   <Ajay.Kathat@microchip.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <Claudiu.Beznea@microchip.com>, <Ajay.Kathat@microchip.com>
Subject: [PATCH v2 02/11] wilc1000: fix possible memory leak in
 cfg_scan_result()
Thread-Topic: [PATCH v2 02/11] wilc1000: fix possible memory leak in
 cfg_scan_result()
Thread-Index: AQHXqxrKTYewoJ82v068rVAjMR9Fcw==
Date:   Thu, 16 Sep 2021 16:49:18 +0000
Message-ID: <20210916164902.74629-3-ajay.kathat@microchip.com>
References: <20210916164902.74629-1-ajay.kathat@microchip.com>
In-Reply-To: <20210916164902.74629-1-ajay.kathat@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.25.1
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0584b8ef-0864-4c62-6573-08d97931ecb5
x-ms-traffictypediagnostic: SJ0PR11MB5197:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SJ0PR11MB5197B7BF825310626D717B6AE3DC9@SJ0PR11MB5197.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2043;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: N35SZz1MnQw2lvSlckU9LkF8rYsgKtR6KDWkRZEAJxO53q1QRlExdGW42dulgkfmwoLjhRRIyHlnEagGRH7B6w47O6FKEdVRDbDnUgeEjrJGXXbubx0WQZ73GYiUmm/A89zt+qfN3jn2PtCBHmdxH1iQ0Piqx9BcaA5WqQ8ZIA88sf2jKxM+cyddWlBCeAlts5ACrvSsPbwzqAS1PiicrqT9kNvli8HsH1CikeWQepLNtMCAnxWMDLxSsDtjE+oyIkG9VdQzSU+f/cRmraQldsXYL697LxnxlrTizTA0JROz+SHJViGWVmu4xIuMoTkfChqB2uv7GHY/9GWcuBAgIYn93ZCv3pD60m+w+Qq0bjshh8W146J6vRaxxSfxplmgH8JS+yFoUlQtRcvnlCBn89kUq4W4AfVVhxcx2O7uWQonHSgfEkRERB1Qn09Ksql9T6KLR+PrTmBPD0y/Dquzu8CZpR9mabZSI/XDdT/dvaPyZ71aWsIeL7qpj+gcnjIptCLOGvJfEIvmMk/wxNjvPDNoCcXQmuhpi4nVvjaxzdp2nxuFJbU1sngn8/XfE50GdzfQSIKVwo3z7oj79Ut9Ni3vwcF0126U5HPlHOJqedoHBPnmtaoal/3LfYr/G16b0Ku57LpDObWmzK5e3pHcSG/dkXdZsqLVV8Jvtz3xjhehjlNjhN+m5khTvPM193pCjnutgHbi70yV/KgzwmVavg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB4943.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(26005)(107886003)(54906003)(76116006)(8676002)(6512007)(6916009)(66556008)(66476007)(86362001)(64756008)(66446008)(8936002)(66946007)(91956017)(122000001)(38100700002)(316002)(83380400001)(186003)(5660300002)(38070700005)(1076003)(2906002)(508600001)(4326008)(71200400001)(6486002)(2616005)(36756003)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?VM4j4mVwASZ3yBaLwV4Tnz8y6mSpLmMU2ZahhtA1vKFLI3GTZu0N2CdXSb?=
 =?iso-8859-1?Q?YyZcKf/fY3s2LXqnw18ldAnUoseFCB81LTxLU5LKtI6mDGs8IDl3miWnzY?=
 =?iso-8859-1?Q?HlAYJYKc3YvjTNL/m36cRWGRyBQl/dit5xc5/DYWolHZ0owG9ha0lTDSsi?=
 =?iso-8859-1?Q?M7cP65CD2S64XpISLr3x0Cv2D1Cn0Q7dNw2pWvyJAjhWW9uUL5oMfOZ0G+?=
 =?iso-8859-1?Q?dIYr+Zxu2jMVSQag6A0O3q4RlFebE8GjcdF7g5yWahFuDJ86R3BKieR/nf?=
 =?iso-8859-1?Q?S2p6lQTIZZi/UgUy2lHQAzWmlqpWd14sKkk3EcizXmH25UCkdsIU7t9fn7?=
 =?iso-8859-1?Q?FwgJCan3yaxlIBWSCol9Ls4HW8689GZZivyE+g9ZxUDR6TSeEcjXDm1Qcz?=
 =?iso-8859-1?Q?Z6Zxd7ys2vqC6cIz5+id8Qd6Bo30XlkC4bTiM2p9PxYY1cDMFq3SmfF4Sb?=
 =?iso-8859-1?Q?Nnb3KMUjEzEmCSNMcBIB/V9leBNXRqIOh9+bfBaACeiDg90B/8bStISPrO?=
 =?iso-8859-1?Q?74fYjFbOaOnq+HB/UsEZ60E8DtcPoD7U8ROVbumG1rVIgHmBBhMpzdjpvp?=
 =?iso-8859-1?Q?9ukwFI5jkXefHngP75nBiv9trb5/wVZSdkEpoCljlbiBvMCSpdktPAlEXA?=
 =?iso-8859-1?Q?QvTXzAYb3OZS00Ynros6D/QeV5LHke51x8NMhMZWMTrrbeKO4P1XC9zhss?=
 =?iso-8859-1?Q?YxnA2KzYSLlvE4M/y8rsA0Xq+ONLeo0aD2zgSJsdmMT+eylsAdB63fgRWP?=
 =?iso-8859-1?Q?5Mad6iQoOigo/hy8JMZ5AeuaVrIj7kOU+HQWZE0ie7I2/TGGM6ZA1/gtPo?=
 =?iso-8859-1?Q?F2yv/lMaJy4kDagDzGH0Cx8XiWH+4eqdsQmuP/LLZEDrnCUiNNpc6NEP05?=
 =?iso-8859-1?Q?1lLdvobOR5rF8a+zfTu8UAlA6mzSkMmLJfS7ViLoL4Cqa2L2pqY2Cr4hY0?=
 =?iso-8859-1?Q?aP0i2NmxBHIwTPiSNnsd5wQead4uXUgOfckx2mLzMJgm5MDsjhua17mNed?=
 =?iso-8859-1?Q?nwJU62dqz23Cw6jH8Ryab3xgggtSkK8U/Alq+Ld50XHASrzf0HHzf0RELo?=
 =?iso-8859-1?Q?N3Rw9JFZtQ6Hu5B/Z+480JRtOqcZw+B5rqTjwaWKone5BNcVB3IROnAMa3?=
 =?iso-8859-1?Q?Qbh/c9O7BCtxipEqlN4Z94KWfBa9erOCxkJ95wA78d2yoMl6EX7MHaXv68?=
 =?iso-8859-1?Q?tSg98ODin4BbxLHm2aFq3BGomJPgS2i1YhS8Nf5BQ0NCJ+sH72QWo4aL8H?=
 =?iso-8859-1?Q?Qa8jebFa3YI2FoCjCfnM7229Smdn/6of/ae+kogW8i2Ob/vt+P0kO94QNw?=
 =?iso-8859-1?Q?+sSmJaCCMw8Q9OkeD4YmLrPJ4KfZ4MqduTKjeZkHCNSlK4wv5d8WOHEKOG?=
 =?iso-8859-1?Q?tXDU3d5wWB?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB4943.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0584b8ef-0864-4c62-6573-08d97931ecb5
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2021 16:49:18.0369
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sOry3ElcpvcJgGxOJwXEh7k/HH+qIAwxj91t5fcW7/cobhmRJcwGgPvtsSbLQgKUK6qz6d+Gh1pN4bQ1qSmPh6FLf8zof++WszSre+aCxK4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5197
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ajay Singh <ajay.kathat@microchip.com>

When the BSS reference holds a valid reference, it is not freed. The 'if'
condition is wrong. Instead of the 'if (bss)' check, the 'if (!bss)' check
is used.
The issue is solved by removing the unnecessary 'if' check because
cfg80211_put_bss() already performs the NULL validation.

Fixes: 6cd4fa5ab691 ("staging: wilc1000: make use of cfg80211_inform_bss_fr=
ame()")
Signed-off-by: Ajay Singh <ajay.kathat@microchip.com>
---
 drivers/net/wireless/microchip/wilc1000/cfg80211.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/wireless/microchip/wilc1000/cfg80211.c b/drivers/n=
et/wireless/microchip/wilc1000/cfg80211.c
index 530a768547cc..36b87ed38092 100644
--- a/drivers/net/wireless/microchip/wilc1000/cfg80211.c
+++ b/drivers/net/wireless/microchip/wilc1000/cfg80211.c
@@ -129,8 +129,7 @@ static void cfg_scan_result(enum scan_event scan_event,
 						info->frame_len,
 						(s32)info->rssi * 100,
 						GFP_KERNEL);
-		if (!bss)
-			cfg80211_put_bss(wiphy, bss);
+		cfg80211_put_bss(wiphy, bss);
 	} else if (scan_event =3D=3D SCAN_EVENT_DONE) {
 		mutex_lock(&priv->scan_req_lock);
=20
--=20
2.25.1
