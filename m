Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFE6421AE6E
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Jul 2020 07:21:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726391AbgGJFUI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 10 Jul 2020 01:20:08 -0400
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:18062 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725802AbgGJFSe (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 10 Jul 2020 01:18:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1594358313; x=1625894313;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Z5N1LpYgqubkFf+HKbgDBBFBDHp5nozj9w9siD3wK2o=;
  b=JFwOgEsLrWSvFF7L60GJ/z7B3zdc9chZad87aOnKTzDnv3WOTgbDHoTL
   HkirK6EX/D93ztDxgJJ+a0hmVf0r21EMq33DswRoeqGYF3qQf6tdULOr2
   yIfsvlf/cLEg6wkg4fCLpkPdLAMWzpU6fTXJ/4yO+Oa2pKOUcw9b3u/MW
   VWILOH43kMOzOlfVeC4oCt1/Ih9S1uLYtySn0O+gaccgbhih6SL/S261e
   ASMA9GkpVCRM1EYSl4c+ZqagL63AgVXnUw128Ok32xHhkZQDt0o33jUcM
   /vHp7lzM1G1HNw9AaO+/E0WPg+25y164f5R727IFnE3yS1QKzlRoZyDZ+
   Q==;
IronPort-SDR: v5wCgZR5Vg1dd/TS3JINSsTXszKNh2Ttv9bSW17yVYh3R6Fh07aHnTJYRWje343dX6+s6ykFAq
 46nfkRbHOaZG5RDah0JZNRlRJXtVnCvi8PUjDgkYW3n/rk1/Vq950oCrTM5L50dapZ2jXWEt4V
 anzbZOtKQt6oXIs6y9VGzlflLCi+Idw7BlcTGx2sdHUbuBX1bla9vk83cx9UmIUB+31+HnnHAz
 dlOohXh8lRaYtRnLB8NpggXknc0XLp6NXaE6z5PhyXQVW/bEk3yt+hK8a6Al6P7ejOgeE5Hlo1
 PUs=
X-IronPort-AV: E=Sophos;i="5.75,334,1589266800"; 
   d="scan'208";a="81311440"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 Jul 2020 22:18:32 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 9 Jul 2020 22:18:32 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3 via Frontend
 Transport; Thu, 9 Jul 2020 22:18:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eBSVnP2LYmV7KCh+a+OBpqc23+hR4mJF3MIpP9PvrBYROGoPeGKi7HRUb9qwmzMCtW8zEqP5ZCfK0yWUdQ99ywbjI3L2B+XxgZM9k+Yia+UVlkCzYtC2Xaw0AuQAVgd/Fknz6h/rnWxGYzJuFi2XEkMpxkYe4ymhY+Np5HreSaw/XsCYVgrqga8CkgkZna/a9pD/4uVI7knWKJCjxh0QtzaORQkyJFiT00CGmnAL5I4BDdSeSCDqNfRkqtaAHnzhxizpjg/0C5U3IAgCsrXz1PbISu1Za7NvHNQ/H/pNQfAcjT0OV2Nil1CSjzhcalMMciVTvWDjJzfqhz8HuacZsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IfXiRCysOLYTdonhb4zV36gjnQ8VlZlFORVfyQMmp6w=;
 b=BsSyI2M8AOCr86Nc7IyeGcM8M4ijavFIRTOrjVhljmAnBCuBKFDrUPsrRZTLDxwL4JnkWJovvu30Vh3qA9RCeRcPRarTBFVRfbumoDiAusTOt4U0nSUqJ03xMU6TMopnPbWfGlhneqgVzV6h/8d4TPEC0tXJysZHuX1geKmU/cLcWcfvVlB1nxyB8yPLZpWJR9lK0+DiVqJN3ZsUMRhdzkqm1AppjRAOHsHmhOzQxu0JYyU/tTWe9kj6qBJ0GL6kk7p94x0nm8ZAT8moCmS73t5s/ZdMIxWhPvWxrNMvxPEbZSPPENSdvUe/6pqfXjA9IkVCuJgqRIiVmhSV82YceA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IfXiRCysOLYTdonhb4zV36gjnQ8VlZlFORVfyQMmp6w=;
 b=tjP49ZpWjp6yVzc13wZuW9MvcwdnFrerNg4WkghH/BO7JTcb35BpSI9+9EdyuCHh9/V+BG10BWjhZd+fL+uwyzYWuH/vNRR0zJOPJH2h1OLO6wR9IFlO7pdzr/+HC8kVgJ1EBSmP39PljLtr38XC2xEURkkoD9cd3FDOIq/SmFc=
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
Subject: [PATCH wireless-drivers-next 2/5] wilc1000: use strlcpy to avoid
 'stringop-truncation' warning
Thread-Topic: [PATCH wireless-drivers-next 2/5] wilc1000: use strlcpy to avoid
 'stringop-truncation' warning
Thread-Index: AQHWVnmMZyc/9L/pxEqjUFhV6Tq1Jg==
Date:   Fri, 10 Jul 2020 05:18:30 +0000
Message-ID: <20200710051826.3267-3-ajay.kathat@microchip.com>
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
x-ms-office365-filtering-correlation-id: eb905cf2-30ef-4442-80c3-08d82490aee3
x-ms-traffictypediagnostic: MN2PR11MB4128:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR11MB4128160B7E0B5C8B5CF43BD8E3650@MN2PR11MB4128.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:393;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lKijJFI91LNibjUD+oOzXy5PnVj/U9Oz8DMTQ8t/td8/5FmFP9Yacp4y76dKiZgWVi0/u5SAuSt1YrZa+0j7ZUwNqnhIkFUUw6iFCiavZNmiyeOvbUqsinr79o2mt1zWgEwp/odWEFm4NVPvFv3SRV8kjbW2QPLAb0PY8kq9t1zQQOWi1n7y8wgw9qMZB0olnFuIiazarZmkBeOkl+zG1+QTenBsHzd3rfHGn+i+fRr2JS6UJjs92Peo0ECHR2lyiRi1bOj7VH2lIoYse6doM/XyP6fAvW2eGge+BWFLyeiIMV0HDG+Zs74BIPYosoTF
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB4030.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(136003)(39860400002)(346002)(366004)(376002)(396003)(2616005)(4744005)(36756003)(186003)(6512007)(26005)(66446008)(66476007)(83380400001)(66556008)(8936002)(71200400001)(64756008)(8676002)(6486002)(2906002)(4326008)(478600001)(107886003)(86362001)(316002)(5660300002)(66946007)(54906003)(1076003)(76116006)(91956017)(6506007)(6916009)(55236004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: hn+AL0VdFF15XjpN68U0UBerS0t+NuPMZgPtxQsyKxbxEmANFR4ErEFYOaCntjMYoedPga3HCX/8qm+paZdAu1Nqb+Nep9w1rTFvRctf85H+1vExmQdLqJZQXrnDUZl02DnG3c6cWnuFyNXoXPgrIxCqkjuUwsq/Ys32JEXPb7EPqoWeAksr4IbKls5Ck3R8csupT/s/V2g9jF4ju2Gm4Zm97t+I1MUN3nsCqtp3yk2aVBTDdigJ21X7mhUvcT4eQ781vJG1ugwWkU7Bi+oujAfsG0mxSuIbCKQdfKBLY4cIo9d3uL/XMLdzJRPcM2ZnCADj//ulCZESGdU4Pt/rnrZe5jMGgH0uFi/SIIWJpX1YzIIKJG/APe8I65Gpzzrc+6rrwBtT6kqFB0G8dGKjm/+eZpsOuXIFdHa03O353lyPgLRyzQw27NFzJIBAKRXN8ItoefX7yxee/ZuLR6EywJTnZRZjPwAv2ecj2Wci2hmiN/mUJy3dbN6DSe+fZPtG
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB4030.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb905cf2-30ef-4442-80c3-08d82490aee3
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2020 05:18:30.0431
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yX9peHgqIrGxICS6kgngSX2bp7bXeLsYrSmtpUdD8JEx928rHHGL8UEYt9X+bD1PrD/TprJbSAOFUNFR/vpVoouT2IvAF/obLm042JK2Lbg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4128
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ajay Singh <ajay.kathat@microchip.com>

Make use 'strlcpy' instead of 'strncpy' to overcome 'stringop-truncation'
compiler warning.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Ajay Singh <ajay.kathat@microchip.com>
---
 drivers/net/wireless/microchip/wilc1000/mon.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/wireless/microchip/wilc1000/mon.c b/drivers/net/wi=
reless/microchip/wilc1000/mon.c
index 60331417bd98..358ac8601333 100644
--- a/drivers/net/wireless/microchip/wilc1000/mon.c
+++ b/drivers/net/wireless/microchip/wilc1000/mon.c
@@ -229,8 +229,7 @@ struct net_device *wilc_wfi_init_mon_interface(struct w=
ilc *wl,
 		return NULL;
=20
 	wl->monitor_dev->type =3D ARPHRD_IEEE80211_RADIOTAP;
-	strncpy(wl->monitor_dev->name, name, IFNAMSIZ);
-	wl->monitor_dev->name[IFNAMSIZ - 1] =3D 0;
+	strlcpy(wl->monitor_dev->name, name, IFNAMSIZ);
 	wl->monitor_dev->netdev_ops =3D &wilc_wfi_netdev_ops;
 	wl->monitor_dev->needs_free_netdev =3D true;
=20
--=20
2.24.0
