Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6267557BB02
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Jul 2022 18:03:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230195AbiGTQDS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 20 Jul 2022 12:03:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229899AbiGTQDO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 20 Jul 2022 12:03:14 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47DD4545E6
        for <linux-wireless@vger.kernel.org>; Wed, 20 Jul 2022 09:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1658332992; x=1689868992;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ulYoKxdOWuQwdkRrF4KiuuDyrMsKL5iYTrSvccEfovY=;
  b=LMjkXGb0wPVnfN079YaqDDRp1b1MAWyiREarA4ibSCCJ741MiOleDW7D
   wYuT8KYLQiu7T4JOimswdnTOuGFGNBf80ZLwcHZQ2E0U+yCMuF3gKJ/Ln
   Gk8arS3JsXUaQwY3vZl2+SkRf2XoIxz9+gTmTdF9ea4e7djN5rwhnThZk
   6V3/vLcxDhO3sAqpuC7uIBrkQ/UU4XY7EjTCsb+TFPc2pMxqYVZHkgpSZ
   NGnzmJgVjqzzGEMGO5+gL9XUw9rI5KJcMbgNYsyTsOgYKOByw73RRkoBh
   OUiUsor9tUt1HPMhWJZ1zs6rcFNsrSRomfUYE7gXQ1FbG8GolDsXi44tB
   w==;
X-IronPort-AV: E=Sophos;i="5.92,286,1650956400"; 
   d="scan'208";a="105374459"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 20 Jul 2022 09:03:08 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 20 Jul 2022 09:03:08 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Wed, 20 Jul 2022 09:03:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T+3e/Sm09MTx0aZ6N7TF6qu7AXJNtzFO4ecuNnLGcX0QGVKAHtR2jRzznHh+3DfskK8DzlbhkgUhHDK53q56hhKR8jwycsfeWkcjjXv/XFYjYATVi4h2QQWd9fdH/1MtPMjHGItc8d5ZDyiwRYobgqEbqspKKV9QaeTV2VfljsTvJWaPtP6qsO6Jn3SHwl9b5FzBci81sYv1/EOQELdbd7GrLNvI2c1cYKW4Z/9qGZYFgbfd10bTs6eLh21dFYQAD3vwZgy1SjLG0vQcHxdP4YkL6pvMV942jsirbvIDrS5XGBDRlCn9aBuy2HB1aZyHzPowABB0tBL+TlrSEjz3lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4VaSb1OG4mMAr+Ml2yFAYWwGO7fA11CR1swOdW+YiZ8=;
 b=hFUJ3dOKYymil5nvf7W6iyne+XS4qpzVxDTJlEBd2Za23KGBc/KTk+3QfQSNZUdHZ0r0c2Kq5lHJ+iCaVW/eQom/GITRLHV7MIEod0bhR36mmU0sLvxgUJDNa2tooEIytfyOiMvh23IPaj4V12tFt1tpfY0Jg9EBhDcmEY9bx9n1Ip9TeICIzcML/oHZ1nglEFgPaFyqS2ScHK3AgyJ+jWJnxEncvWDYoznspoD5vOZF+DjpMaZhPnvjqSBx2wQdbxdsfwSDo6j6jYT50PoRbGhhNBC3vCzsDUjbCit0KUM7jo79oYvb85lbgb6Gskpl7gaj/WvQ4H98luUUhoafqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4VaSb1OG4mMAr+Ml2yFAYWwGO7fA11CR1swOdW+YiZ8=;
 b=BToet6U8ukzz7Ij0uIt927x6Io8j5TJ0EfYMqvqbap93KiU8RcpWZgirgpMEQHvt75uovjjsv6t9RvXLvTsSgxLcuSt5fDKALLwg8X/nO7bf75xO6bULjHHlayjMayBwZ7QpoVDTGYInT0w/PHvu7AXVxJT3gFulV70k5n7hjlQ=
Received: from PH0PR11MB5176.namprd11.prod.outlook.com (2603:10b6:510:3f::5)
 by MN2PR11MB4174.namprd11.prod.outlook.com (2603:10b6:208:154::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.12; Wed, 20 Jul
 2022 16:03:05 +0000
Received: from PH0PR11MB5176.namprd11.prod.outlook.com
 ([fe80::812f:fd29:44fe:6cb0]) by PH0PR11MB5176.namprd11.prod.outlook.com
 ([fe80::812f:fd29:44fe:6cb0%5]) with mapi id 15.20.5438.023; Wed, 20 Jul 2022
 16:03:05 +0000
From:   <Ajay.Kathat@microchip.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <Claudiu.Beznea@microchip.com>, <Sripad.Balwadgi@microchip.com>,
        <Ajay.Kathat@microchip.com>
Subject: [PATCH 5/8] wifi: wilc1000: get correct length of string WID from
 received config packet
Thread-Topic: [PATCH 5/8] wifi: wilc1000: get correct length of string WID
 from received config packet
Thread-Index: AQHYnFIxWRWMAbsz1ku8PVk/c/upZg==
Date:   Wed, 20 Jul 2022 16:03:04 +0000
Message-ID: <20220720160302.231516-5-ajay.kathat@microchip.com>
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
x-ms-office365-filtering-correlation-id: f1602021-c99d-418a-1008-08da6a6954fc
x-ms-traffictypediagnostic: MN2PR11MB4174:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2GD60Fpgw6VBl98mp1DgLAZ6WCnv5UV1WJpAVhU+Gog1p8PfbkFoaTmuFaf0b22eSHWyjURonvmqYcK7TqvKytSncsIm0W9MNj+cQzx4dQCb2p5PhP7tILWhCIMXZc31juRXE8cVmOmj66yDaSUWNJYhNh25BZUcY/etMzx2CG2BoeDUDHAK8s90NL0sFQdu7A2kbswA+vcW8Aj+tyTucMwqLp5Z3WUT9N2mTv3vK3ht6s+6i2+OoCmOdJ+IcyGDmhvMC4Alv6ntPwNQQyBkuk3v5T+iUh0LH9JXKjurzl98Jxw6RFQt1ZwdG3DMyACz1uOng8DkA6Z75jKRTPtq4nuj+1wfqQrNidDIG5I6PHFuHYqrBrECT9cT8JtsGt+kS3f9R8nkfjew2rjIOwRNv0GtLigLg64k2JURvsJZ5qyGYaxgMz1HwW+XTtlW67J30iyxJmsrWmAzA1oSIVKP10vI2m+Z9dt/RdCfCv/acdZZF6WmoHqF9+V4b/7sGngz4GIXOKx95qBMNVxtkVZhghvq5s6+SZkeYW56au6fNtASsvszTnl11Dh/TKZZ5UrqvyeIDo+8ZejILPEr0ObODUwM1hk2AUUveHAw0BjbTAtWO/2pWyYAGe1Y8ll2sK4rebxCUGP0A7iWqC66r8+/a8yrhw7spjpsNfJjYcvSfemxZHKdhAq6KEvlxyt2DYbuBPofRVCLTVRWdFJ2U+P2KfZGOmerYIHgQGF50Br4lGdC0EJozWxyPef0qFojWdHDWUapbD48IJjxqyYfWvHBpitTwKBLSFAIpwj2VWAo2cMMCxBh3KXd+iE788WQO5Iv
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5176.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(346002)(396003)(136003)(366004)(376002)(2616005)(64756008)(86362001)(6486002)(122000001)(8936002)(1076003)(2906002)(107886003)(5660300002)(41300700001)(26005)(38070700005)(478600001)(6506007)(4326008)(186003)(6512007)(71200400001)(4744005)(76116006)(6916009)(54906003)(36756003)(66446008)(316002)(66476007)(66556008)(8676002)(91956017)(83380400001)(66946007)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?1lYjxfPJTxP3553VYedjIHGuD5GTFpgwMny4jTNCGC1I5PZJV1M8TWywul?=
 =?iso-8859-1?Q?rCAvqtyTcbhxfE+G+RZD+zkAsjQhmW6RDGWf/dgVx4oyXmOnEUlhTyf/7+?=
 =?iso-8859-1?Q?ys1zoqUP49K75bq2CB2BcOWHlyi3EE8HmQdNliWxv8eNpC3jR2rEMLDRrE?=
 =?iso-8859-1?Q?0OA3S0XKsOd0BCQ9Hsf6wkaTm4dVojaw6iSQFXSKTS62KpI9m9WILGPjlx?=
 =?iso-8859-1?Q?Mn8hebelZg681tYJ/d+9z+pw7ahX4pkvaDQn7LjIfkVus1mUuueuxsoksu?=
 =?iso-8859-1?Q?grvdIXbc02WH6heTu3jKTT2PMqg+8uONy0zSge2SHhkCgdyZ2FtK3eCPWw?=
 =?iso-8859-1?Q?7m2GJgMYtEvnSiFB3GUM2VzhFsowpO4dTTf67uqiGILlzDT0Zt2wM3xvIE?=
 =?iso-8859-1?Q?Vmpws7vNIrPsBVP1qPUPqcYGS8LKlqNKNBaI/K2PfZ2l7LndjkH7JcDpJk?=
 =?iso-8859-1?Q?uUtbz2cU6+V2rynKrIeAjnL95YR9ptFcmEe8o5GwG7SogFY0p2UW/3KfeK?=
 =?iso-8859-1?Q?IcojTKtXBplAvngoSaO3p+tqZl+KhT/JEvzxB1kWYD4nsL3LapEBLVJF8A?=
 =?iso-8859-1?Q?yzjR4K2zQN0Yac/VAU7LhVUQ46J/rU2IjdwPNn1S3t7j24UoQpkApxnImz?=
 =?iso-8859-1?Q?diJ7/2i8RGMqU8wGSyyw4gF4RqFBLh7+7TAZRXEaHNlKR59VDYyrpztKG5?=
 =?iso-8859-1?Q?aGzCYiBTZqfFza2wpiU/VFYPG636MJisGlHPQ9fO74wlwqMxSKSkpVZoGP?=
 =?iso-8859-1?Q?1ESYtyzqGmYqA5PDYgbq1tc19gkR1kp/J35uzjeIF9GIeFvvtpHl/G7yao?=
 =?iso-8859-1?Q?AVSpGzEJnNDRTrjvYYw6xb1vR3xG0oQhkmauSidh1fb3YWhdsPrPIx5IJ6?=
 =?iso-8859-1?Q?ESd52cO5l1dJTYiH45xSQySHZDsTkIMW+lcVLicNZ2ZcpetTndfQdbA/h9?=
 =?iso-8859-1?Q?0wo00YS5vPJaTRUpP/hZYEi2pW9jEkN9S54z4MpVItW8cnzfS3YsR6HSwh?=
 =?iso-8859-1?Q?ndkGo5pLXtdaBCSE/ZboOSleQIQKb8DI79/FC+rFioNteXJbnGpHaaPZiu?=
 =?iso-8859-1?Q?Gk+9Db9yNvl0VZylOB6Zps9dbs159bj0+UGl0uE2UGea42mIhYMl8ePY+I?=
 =?iso-8859-1?Q?Q+NaN+vWkIJqFpPIW3jYNbqSbjTLRrmr5EpW11zyK9Ceda7tn5GLMaYXdd?=
 =?iso-8859-1?Q?x8C8cVoJwhInR0+taLZdQREOi4vUNWy2bjnBeYP8U8zkwiKtihq8mB4zAi?=
 =?iso-8859-1?Q?V0lnodBb9SvzlUlOj4NvFyfkWiNXGVRsxZ6RMMfhz4rrsqAb5S+PGybrm9?=
 =?iso-8859-1?Q?7IPD1otrO2oXMNfLK5olMkZ/HZZwfClhWo2wn082VVvoP2Fm9ahGWTaTa3?=
 =?iso-8859-1?Q?9Hw1Ll9sSkIqP6aqmMUjswmvj2RX1qT3bXt+IeO993TdUaqaFNSc2LbWLA?=
 =?iso-8859-1?Q?P/ppr9dWGYLVDjtMrrGeXUuYxybaEQ3pjB7n1q2m2b4w4dnD9cgvcAJK4+?=
 =?iso-8859-1?Q?XqQI670tr70z1pU1B8vM/rfVaWAlbaXW6TPXaaE7YdDxeXpy21H7IzyQZH?=
 =?iso-8859-1?Q?s4TkREIP2SnbqIPXfXS3E9aH9uVtjPwOitP2iX63BM+Sv9yhA6noX6j5R7?=
 =?iso-8859-1?Q?jBAXv+/9qDCZrCqfp/fFXah0Hshc6/OV/jXE97kwSu4owcg9CV+fCr7DH0?=
 =?iso-8859-1?Q?ff+5DpypnpPqbzpiqCo=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5176.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1602021-c99d-418a-1008-08da6a6954fc
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2022 16:03:04.7646
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sC9Jg0ZilIfRLWjZgwlVqj+KLXb4vtHYHW/Zc6T23qWF6bTX8W2I9ATLyeL2gnE7IVHIj7Yi5ifSOjseQeLFZpcBdhCyykFsVRR3uuzQlmU=
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

For string type WID packet, the data length is received as 16-bit value
so use 'get_unaligned_le16' conversion API to extract the correct length.

Signed-off-by: Ajay Singh <ajay.kathat@microchip.com>
---
 drivers/net/wireless/microchip/wilc1000/wlan_cfg.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/microchip/wilc1000/wlan_cfg.c b/drivers/n=
et/wireless/microchip/wilc1000/wlan_cfg.c
index 60eaf62fd164..131388886acb 100644
--- a/drivers/net/wireless/microchip/wilc1000/wlan_cfg.c
+++ b/drivers/net/wireless/microchip/wilc1000/wlan_cfg.c
@@ -181,9 +181,10 @@ static void wilc_wlan_parse_response_frame(struct wilc=
 *wl, u8 *info, int size)
 				i++;
=20
 			if (cfg->s[i].id =3D=3D wid)
-				memcpy(cfg->s[i].str, &info[2], info[2] + 2);
+				memcpy(cfg->s[i].str, &info[2],
+				       get_unaligned_le16(&info[2]) + 2);
=20
-			len =3D 2 + info[2];
+			len =3D 2 + get_unaligned_le16(&info[2]);
 			break;
=20
 		default:
--=20
2.34.1
