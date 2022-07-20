Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7957957BB08
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Jul 2022 18:03:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232073AbiGTQDW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 20 Jul 2022 12:03:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229899AbiGTQDT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 20 Jul 2022 12:03:19 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CC4F54050
        for <linux-wireless@vger.kernel.org>; Wed, 20 Jul 2022 09:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1658332998; x=1689868998;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=agMHJUtS8wAPlgav5zk7QPhmFnWGX8CQUSKb6esfNBU=;
  b=lTGb5XQrAmkdI0EShk/q6wDltXWtO1sLClhv7+fpHhmRAG0JvZamfGkx
   eaSeeVEOOkGST96b1SCd9/0XkPSGvJx+Xr2XwhhvIDo72RQgYAMMA/Ocw
   aHSUzprfNIGmzKM003vQnFZN6Z2Ih1hlqlVAqWCBMbONQjQFDZm0l3HW+
   yqvm6A0/E7ASBDbIMyT0EEpn+cW1X8tod7o+BPH+fh8CvrJE23vFlbj89
   k16k7ky5jCwJh2U5Hv5AfU/Bf5MXbfDjiatcwf36NyqCjAESILM4odLfE
   qIr8abigYkXA96+RBtsOGdK44OoECpCH0czQQOcyAhGT1cA26atzl0boO
   w==;
X-IronPort-AV: E=Sophos;i="5.92,286,1650956400"; 
   d="scan'208";a="105374573"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 20 Jul 2022 09:03:17 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 20 Jul 2022 09:03:17 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Wed, 20 Jul 2022 09:03:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hyb6bcfHRLrejIH3L5GQ6j01nBosUlWI8+5aPKJKreoxTgU36MN0JuNYZ01U5zm8yodSIYybHLGU//86ra/NU5WuXredIrKK0dnHNEzSMadR83ugJeBvLgRruTTGSNqzHUuXFZL5/9fUV3s3GB4G6YvzcKEbRrhorf+sq31Hd3nAzGHJQZ5jW1gJTOK1lWzBL3VWbLis8XzJC1qnS/r0teHKw7bv23MixYxtxDPwATINKifma36oeJY1GUkxafHlQnumoF0GhSJ0muOIoHOBPnKVoAefBLcaPkq0+hShX378LUtgCe+etRJYoRpju9ctUGENagf5wxjUtuxbCMSV5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ftrMiV6VMVlwoMbZdE0HMC6S5ovsuJL42MQCigkBjOY=;
 b=fIqu9uOZ8P5TNJiYTBVm1e9LSZcxIZPiy+Vqd5qelLhglPO/q88xuyPk6nNrUTyaOF/RRXnZeefcnK8lRvQEeTcwBM2rTI80qv4FZ38e3emPMEGQ9SO34YxvGPqpwPY4uc+4HMzcE+19w4fKRNAkBALRA8ABxvusEfpBlYfHz3oQyIue/pyUAZfIzRao5WP1YRoUzQ53dM9z4ZsTIheoZSBLVVOK5fswgmVGP1SMi0I3mtXu/JMimwoZQIG8O99xMV3q/VZlAfPMuk9vYKmPzrN4FpKLz0qPPRV7d74G6f2fhoODyglu6Q7gmuVAZ52Av9NtJEuFKPVeJtIaLqA3+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ftrMiV6VMVlwoMbZdE0HMC6S5ovsuJL42MQCigkBjOY=;
 b=cm8gjLlnRlyNl7Xxpg+4oofG25+8eV4h53xROEOkXHcSk6XXa1sMXJIEg4xc4dmqFOOhnalS7qN0/KJ7O7ooec0hFxeIcvccJ1Zm/sVwopWIC8aHLzShitvahn3kYrWIBGpUhi/CCcZRLq8b2c6vWR6xF933o2/dHX2zYpuePwQ=
Received: from PH0PR11MB5176.namprd11.prod.outlook.com (2603:10b6:510:3f::5)
 by MN2PR11MB4174.namprd11.prod.outlook.com (2603:10b6:208:154::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.12; Wed, 20 Jul
 2022 16:03:04 +0000
Received: from PH0PR11MB5176.namprd11.prod.outlook.com
 ([fe80::812f:fd29:44fe:6cb0]) by PH0PR11MB5176.namprd11.prod.outlook.com
 ([fe80::812f:fd29:44fe:6cb0%5]) with mapi id 15.20.5438.023; Wed, 20 Jul 2022
 16:03:04 +0000
From:   <Ajay.Kathat@microchip.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <Claudiu.Beznea@microchip.com>, <Sripad.Balwadgi@microchip.com>,
        <Ajay.Kathat@microchip.com>
Subject: [PATCH 3/8] wifi: wilc1000: set correct value of 'close' variable in
 failure case
Thread-Topic: [PATCH 3/8] wifi: wilc1000: set correct value of 'close'
 variable in failure case
Thread-Index: AQHYnFIxs6iET20GYE28HgWm62p+Ow==
Date:   Wed, 20 Jul 2022 16:03:03 +0000
Message-ID: <20220720160302.231516-3-ajay.kathat@microchip.com>
References: <20220720160302.231516-1-ajay.kathat@microchip.com>
In-Reply-To: <20220720160302.231516-1-ajay.kathat@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8be65622-e0df-42ab-1499-08da6a695431
x-ms-traffictypediagnostic: MN2PR11MB4174:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: D5jYS+/5o2R+jxgkn6teA8leR+hObRlyt+5G3Edn5O9JDeshU93BbThPb4mhhyzYpD8pwxF0d3SlLZh0ndR/Z0BBEkJgmEfnTw0kX5XANLGxZARAOsdD/klguAXHsJL5YSyLwW7fBQITHDw6FIFOPwylMgpFssgnSFHKjO6bxPQrPvqHhKUzE6I0weIG6SxRsb57M3Xo02OeoR50VmYbDezP+8pYy98XnXoB63Wxwpf2JWe56meeHFDDahcOws+uJd8to2Ed5ytkNGWA7r0gjD8HcEzd8tgatY5Diwpk6u+Itb/gMyuJnwfgmUOnu1SZJaMAKJaqND26MwTYB6XBOuaCF/yT5JiE0U1XFda6jTKUjN+tz2pjOmzuYOCH7hTNfShTxCbe2nKlkl0H4GypoRxJKsIgzyo9fl9MFCN5oLqPE9V4KenFP2QgSAqUtct8LoHVA04nOLJkNfnmuJmw9XlWHFvYhT0AOQkb25H1SkkcYbCrD0MNgxBK9ptxIVF41deMPoGfkiJHrkBZJHXpwzsKOUcSCW4uxQlYbKpHxMSPjIySIoPAaYMEq//G0UIdw/sIfMskIlZe/ETZxAxuc98wgpSa+GK8TxGcLt9P+JIJrCTuT6tb2dm6RbiIF1f2yDgRlC9YBga6TJ8pzSLM1lAgc9jObuti3YyG3UxgCRLoV1yKFrQyO8LNzxAPt7yJZxF0ebx9Da5doLfWuIrkBK4qcHc21GksaoNaCHGj2sLyBDIRhuTibKPKH1qmGa21e+R6qdrvTaoOBu3KBNc5ewLtFkOfanlukMUkPVPFnL9Ojf3kFB+rezAxNl7kwt5K
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5176.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(346002)(396003)(136003)(366004)(376002)(2616005)(64756008)(86362001)(6486002)(122000001)(8936002)(1076003)(2906002)(107886003)(5660300002)(41300700001)(26005)(38070700005)(478600001)(6506007)(4326008)(186003)(6512007)(71200400001)(4744005)(76116006)(6916009)(54906003)(36756003)(66446008)(316002)(66476007)(66556008)(8676002)(91956017)(83380400001)(66946007)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?1MKexBTT8ax3PYkgKaXGLEIPFG8qLyAjGQhv0lqIay17Sfy6z1135GnBjY?=
 =?iso-8859-1?Q?S7Jpo2p+oO7ETFxfgVfvhy+fJ4whAB6+EQ+bba8zGFh+NgqAaoi974Fjso?=
 =?iso-8859-1?Q?fCNbaRXLiJeoJxC1YYiKkPqrAE73ESPXMMqoxQcdurP+UTHiknI1KOdGTA?=
 =?iso-8859-1?Q?nGhtw+kOBBNe+6bXqmT+JZoF38yLiCDVWFeRn7XIYisF5kYoKvojUTshdp?=
 =?iso-8859-1?Q?ntX/mlL/r91gAJLcrw8a4VXEMaENMlR4KieYFFrQ34I7yjIeQUjc0Crx4a?=
 =?iso-8859-1?Q?7I9OseG1l/NLlXTPpkq9tXn1ZSMEk46yXkVVUq8Enw7itp6LQRNtRy4zH9?=
 =?iso-8859-1?Q?/BuNA4cl1xrG8v/goJuJz4nK8BSo//J6IT68L/1lN4W0gNo0r2qkLESTqS?=
 =?iso-8859-1?Q?GgeCDWqBqxHehTyL5kxDMu8aMBDwh0sIsywkkzSoy745+LscRh6I5HyY34?=
 =?iso-8859-1?Q?lMuIFwYGNYsL0RSu8Vxvz4fNz1EuuQ2Dsq8FcXdY1rewCzqxDHAPZltLu7?=
 =?iso-8859-1?Q?BCNMBniKRLpFDoYKsG8LJAlafaqYOfKlXY2pjLIFFwjyhGzwnVc+7of+sX?=
 =?iso-8859-1?Q?zX3vUFdaU5y7tuQ7D8n+8VbEZwslZ5kX4oVBx2swvuxpYw1keHpb9bfed6?=
 =?iso-8859-1?Q?R6i+WNqJ3K7ZTKNhV9Wjf8sWFrdnBuPanaFBeq8SXw3VffYmTMyCwHFXQ2?=
 =?iso-8859-1?Q?wq5kiJsm4LtdY6Bh4t9rLdCziZKsKJdHp/H3bl/zl3d2xfMP2SxWIVHWAD?=
 =?iso-8859-1?Q?Cfp+9TW3mi8cAIktRmVAlQ9+duFg0wrogvWQEEULxxFvWZDQkMDut1GxMG?=
 =?iso-8859-1?Q?4j5htDv9LyE+d0YHpkQFLcHB7N22nTgrpbSVwMemay9XPr5tHTCfdd30bn?=
 =?iso-8859-1?Q?8j7bRYK0I2yMc10exx17JTuzWrqb8xETongBPQ2UvYLnlHtWWEaA/qPl5R?=
 =?iso-8859-1?Q?DDMTDCOphEHGWqPLyWBqG3FsFQexYQqEJkS6on7DlT6CuYDpQVVJw1Jg9P?=
 =?iso-8859-1?Q?d7Ax0Xh4P1/LADQHiQyHGopD9R0xEhRqfAKNuUJxerTJvLn4VacE/M1cpD?=
 =?iso-8859-1?Q?RWW3taorcDsKKSmMEtWhBcpw39FZmM4//QHJ/+H1ya94pcJhK3Zj1woFlm?=
 =?iso-8859-1?Q?FFHb85Iu8o4M5Aa5WpneV0DDe1yeVgvjo94hm/9p6og19SoMk1m1HbMcHV?=
 =?iso-8859-1?Q?564QfFgZZtbpgh/JvYZxTmyRfO7lpiWo5Y9fW8DYQsD81aiBrIM5qbLPzd?=
 =?iso-8859-1?Q?Y3hPSAhicIo7dE792+BpYTPgVAINk3VMt1WdBhRBpb7jixO/I4AUuGFzoC?=
 =?iso-8859-1?Q?Y4wjK/fSckPdm52HY8OCaty74+8NDIcLwfo959NFr7AzWP8IMKbh3JlHQG?=
 =?iso-8859-1?Q?SBOCjDlAPscSMr84oobmRXc3STvVVzJH/mtrjyEJ7mAo/yxEkz1OBQ9HeV?=
 =?iso-8859-1?Q?JJWtMzFw9qqrwKE4U8BC/9cECli+NyudZESTbo/zEstRVAqe8UxAVzMv7t?=
 =?iso-8859-1?Q?qGI7Taz8/C34ct2rSaPNwl356S5Sz2XNyXrRbbgrbZKCV3bQQ/m5fQz9y5?=
 =?iso-8859-1?Q?newlZ18QsqqgH8Wb35PFfcxVQgvxf2Fs/SrS1CA3iKoN3UPTPOC9VJ+jga?=
 =?iso-8859-1?Q?oZein+EpUZpp1TZ5eh0zprZ5hi6IEGax/cZwafZMGwf0L1+Z3BVisCgZPH?=
 =?iso-8859-1?Q?U+xyi6Yz7fkwk0RiPL0=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5176.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8be65622-e0df-42ab-1499-08da6a695431
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2022 16:03:03.7648
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tuYSNYvzLGlyuLEFV2y56tu35AT0HNGGrC7HrWvCQzBrJA3Emtzn4Ovp2kzoteoMDMX3uc9l4dHhI7KeT3zp6DYFc1XDaA6nqR67wU8IQ/k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4174
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ajay Singh <ajay.kathat@microchip.com>

Set 'close' variable to '1' to indicate closing operation when
initialisation fails during wlan_initialize_threads() call.

Signed-off-by: Ajay Singh <ajay.kathat@microchip.com>
---
 drivers/net/wireless/microchip/wilc1000/netdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/microchip/wilc1000/netdev.c b/drivers/net=
/wireless/microchip/wilc1000/netdev.c
index fcc4e61592ee..7879446f282f 100644
--- a/drivers/net/wireless/microchip/wilc1000/netdev.c
+++ b/drivers/net/wireless/microchip/wilc1000/netdev.c
@@ -472,7 +472,7 @@ static int wlan_initialize_threads(struct net_device *d=
ev)
 				       "%s-tx", dev->name);
 	if (IS_ERR(wilc->txq_thread)) {
 		netdev_err(dev, "couldn't create TXQ thread\n");
-		wilc->close =3D 0;
+		wilc->close =3D 1;
 		return PTR_ERR(wilc->txq_thread);
 	}
 	wait_for_completion(&wilc->txq_thread_started);
--=20
2.34.1
