Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1BB651A544
	for <lists+linux-wireless@lfdr.de>; Wed,  4 May 2022 18:19:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353101AbiEDQXG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 4 May 2022 12:23:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236143AbiEDQXF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 4 May 2022 12:23:05 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21B0746648
        for <linux-wireless@vger.kernel.org>; Wed,  4 May 2022 09:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1651681167; x=1683217167;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=4GMr5UEP8JMEPnvsInnkmcjGZUWA8jXiDyzuUYkrArY=;
  b=wLg767zF4fP5UqKOd70lV5+K+SoYyizLEU4L5jxBsTqQJKE4EdvqDE6+
   WSsaJQfgB6rQfRGvLzdzjAI0FH3rXEpMOP8spb9Z0XXolpozxv5F/RGNS
   NEdLTNqDSzmYlMCYgvAqH0PCQ1iEqb90IWXDCQvZRR5tLxubdwmpRpA+H
   rZiDuQl5qt/JGkuyoycb0kMwgeutoKgYKvmQQp6z+u9bngnCWfuZGnpF0
   x4hBdRc/5CVGU5raE2NuQ3MiF/1mGyPJcszF0t/QTjkAaFYi06L1nXI64
   VHMMzTu652SoLCThhbfXcRnxw/grUzXMcQXxtF66yS4+8Lc0Xdcy5K7C1
   Q==;
X-IronPort-AV: E=Sophos;i="5.91,198,1647327600"; 
   d="scan'208";a="162723811"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 04 May 2022 09:19:27 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 4 May 2022 09:19:27 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Wed, 4 May 2022 09:19:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jjr0geQgG/SvVaDHU3Kh0hBv+Pia+vUKgTqGdiZRfhapNmtgJ/SuM5MSjr+ywhU+IpMHxRVtcrGCigZ+GA3wThW5uA+Zw5KyGkXD8iMFWNRAexNwPiYtDwq5vwOmXcLKV8kUyXM4vy6Mjgd6VkI56qiX1MNWjRewv1Y4arzBBeypz95Phr0cPD+xfL9AVjH7kH2Z9fiVS66ANN782pScnQANeeRwKfJH7IcDdXi5yWZKwD1bHur6A7O3A1PxS058mkP6KWQTOr5byGcMd+mItC+XYuX+8yzq4CIEOI5SceaeXicXkUQiuzm6vK7OeNYDxA8osaq5/94Cq/2oZBQZhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rF9wsDt6+WbWExWzA8254CFXVMbueQpHgGgJTMUT7JM=;
 b=Pre8CRJF7aq8p36ccbTjDBD7csc8iT1KRWFPbH2yMLNTVoSiu8k4JCiXjTDO+jiaT69KBnAIfrFe8pjZAN703bt/pzoar16J9Ieecm4mHYVXTrPt85af5XOki/ofp9t8moKttWMZn31Biz0Nr+IE385+Yq8VjuFigg1BQ9f/zS/T/HQNJuCL6wTuRd96Gi/OZmu3LR90kjvMQ+IcSFvsbVHTpR3uqDd7BFNLnE422eKNHgf0W11geUH2F5dnFvjhEx8fkoWGBCqxGiU2HVOyYh0LMGP+sLn6HFxWWPqk8DzwFXua/GNQPrpBRbC13xXPXfF7LpNuLqZFHkRqY9XoZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rF9wsDt6+WbWExWzA8254CFXVMbueQpHgGgJTMUT7JM=;
 b=GH/JJ9ueiaxBL0K5/MUQ39aTS4FovMr5xjFOxAFdn5EdP7Z+UyJs9enXiprF3rNxEdAdD1EXBykJdKoprTsbCHvZMfocn1B/j2AuUA85d+906OXJwAsWPcI5RcOWXS3FE+wSaS70HIof65JEwi37hOxaStJj3WHYt2wgdGKRim0=
Received: from PH0PR11MB5176.namprd11.prod.outlook.com (2603:10b6:510:3f::5)
 by BN0PR11MB5710.namprd11.prod.outlook.com (2603:10b6:408:14a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24; Wed, 4 May
 2022 16:19:25 +0000
Received: from PH0PR11MB5176.namprd11.prod.outlook.com
 ([fe80::d0fc:845b:ce0b:11fa]) by PH0PR11MB5176.namprd11.prod.outlook.com
 ([fe80::d0fc:845b:ce0b:11fa%7]) with mapi id 15.20.5206.026; Wed, 4 May 2022
 16:19:25 +0000
From:   <Ajay.Kathat@microchip.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <Claudiu.Beznea@microchip.com>, <Sripad.Balwadgi@microchip.com>,
        <Ajay.Kathat@microchip.com>
Subject: [PATCH 1/5] wilc1000: increase firmware version array size
Thread-Topic: [PATCH 1/5] wilc1000: increase firmware version array size
Thread-Index: AQHYX9K4wsanpHFvcEi1AQZILSkwXw==
Date:   Wed, 4 May 2022 16:19:25 +0000
Message-ID: <20220504161924.2146601-1-ajay.kathat@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.25.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8fcd3b3d-28cb-48f4-9450-08da2de9db16
x-ms-traffictypediagnostic: BN0PR11MB5710:EE_
x-microsoft-antispam-prvs: <BN0PR11MB5710CA0153E44158D2D8A3D6E3C39@BN0PR11MB5710.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NM2fhqKxcSWl6jeBHxH14Grre8Cqgq1CJdzO+7dNB8N/H8iyOHe70jSewu2mUdcoEeYGvzeFDGBGwFSj8TtP4rUd9+TdNXyPI1cxPJz4XzkeWj9sNNlAtG4gYdy7UtvaF98Pp/Q2GHzhwLd6VsY8TwJslcYDj7i5DvcvC3GbivceqAqq3CpUQrOzzHG97vFXn2egvQPImr3ZV/PWvGOo9IMOmcLlZXj8HT1WlCnX88rReMDtISsYbdJKie8cfowNVwjZjjK8tVgZT+EqIxa4LOxBpiY9bgxXvJXr4H7NbT9RxgrH88fVrCLFYqV3yV12EpFLRt06jXXiOU9mi07oBgCqyB8YBSFbjrP37mWVl7H5TJt1t+6g51r4PFyrbDhfZ0EkuQUJitg3OPMaatj//TxXumE+UuXj/maUdBbATYwSi+mbeRQ/H8nCI4qqL/3lB8Ntl4HXdQZJPNuRQdwPeba4TSGHx3payXXtV2LHIQgmZ6fQ3Z98/vZA6xI6ui9Er8TubxpgdGJzxddV4TFnrLbkRqChvjBtJB5lphimiRH68Tto0Dwtvu/QgJnEQsfKYjxo4upMWJp18/dv1ts125Xk261ud9huav7N7rqszmbZOT905HfGTYerL/J+X2xuvx8MuQQjRXioriRRNYX/fL47ImOqeVAYtIbYrF/Vsw2UnT9xaQaTbnHk5M73YzCXbZcbKtAlqFWR54JV+CyyvQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5176.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(36756003)(107886003)(508600001)(83380400001)(316002)(66946007)(6916009)(122000001)(76116006)(8936002)(54906003)(1076003)(2616005)(5660300002)(186003)(86362001)(6486002)(2906002)(71200400001)(8676002)(4326008)(66556008)(66476007)(64756008)(66446008)(26005)(91956017)(38070700005)(6506007)(6512007)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?vZlhI6DoYrx7NSG7VHrn41CTVfopYEMlPuuGZkO2/ZlssC3zlcNAFXZI7I?=
 =?iso-8859-1?Q?nrfXN5RhRI24dx1UsUMr7Ds83a1shoY/MDVW2MXJSAT0FN4lxlznuPHcUh?=
 =?iso-8859-1?Q?UCqYnkRCHPf+AfeN894keqMSZESgHpyUhhTtJEss/8+TuKRge4sXo93Nbc?=
 =?iso-8859-1?Q?CbUXwu3UfOj3VaS97Mku+8RWSKiT6ejyAO6LYpEqq95z7BgBpgZkafCpDs?=
 =?iso-8859-1?Q?BISM/qDgNWYBMUNzqmlSrgIYyrWyn0Udr06k7GpQIBDP40NMgcxJLl59Sp?=
 =?iso-8859-1?Q?qpvZc9s7pZ7ZnJNxMKYP1q371cSZBs8er3kf2kF7sTcgZg2h+QnNplphQ7?=
 =?iso-8859-1?Q?92yTn/D14sTetZa3TlY0V7fsIu2PhJfyFYTuj2khjer62n3BLbBQr3/j5C?=
 =?iso-8859-1?Q?gXpiM8pnbJMGyGJaDeC5aIeIjlMEpBCte64DKN0vWO2V34aMQ2cLvd4keP?=
 =?iso-8859-1?Q?XrqmKOc3lAA0YIrSW5Wt83lGpId6nC+ph+1uvrKjmCQIziDfDAvdPNnEK0?=
 =?iso-8859-1?Q?kfXKNDGmf/+aWbAOk01DDbWq00DYBd43HnTOecJmiRqAsuj7V2FRjD/bKk?=
 =?iso-8859-1?Q?cGq/pW/ID6zEhWkxwrmvczqAEtlAoDXt6FawtS4qcqrfyFCmOLwCTMmZ2j?=
 =?iso-8859-1?Q?yUrOstTnu+jW9ybeBZNKw72IPel1zed1Yi85sNF/IV0/IsiDf70o/bbJ8/?=
 =?iso-8859-1?Q?mOU2bATTEB1DjDqDTxDmpBAW5/n7qjCak3EAAEoXUkopbiyK4HRyDpW5kQ?=
 =?iso-8859-1?Q?pFbn9dLFQFYWyi760l6OacF8rTexgjnss5LlFxdUYSUGmF6DTwTBV2+QjW?=
 =?iso-8859-1?Q?TtRY9FDtAcLQ/OtbIyyyLuvsm+DX4XKTWz5sg2dJp7v9uXNyCDnD78Cikb?=
 =?iso-8859-1?Q?3YH1IT2UqScJj0G8GkInSpmUHZtTaYC3fayx96fhX/zXYegf7seVYE7hyb?=
 =?iso-8859-1?Q?6TaVMp/57aj+H8+iBmZiN3cjXs3xSagArJjBXDzVXhkn7x2DgUrVOsRdqP?=
 =?iso-8859-1?Q?+3ZqHWxgCBcWZCKf0VajaBlFAtNQ92fZnW/9mEpeyOwfzED68407o7Btnw?=
 =?iso-8859-1?Q?Qmy37ttOC1WbMJvus+8OtXrPQBJinXXF3VxykU22ST2vQlbNU6GZGhNxdb?=
 =?iso-8859-1?Q?k2vpisQSPseQPcCC8ebBAnZgt7kAPnIjYjyXZCXCyDAV2CmQ3zAp7d0FwH?=
 =?iso-8859-1?Q?bL6c7u7omU96fXwP0duAy/NzYI7owRF8JzaoKbcEbwBhuQzV9g1xqqHpXt?=
 =?iso-8859-1?Q?YjmFtJczqC70RsGR+vOKrmvEVTJ1PUwGvkYrgtbS89XDK4lahjp5kFVhUp?=
 =?iso-8859-1?Q?lvzdHYMMQ0O5sddN4/OKxb9miLcwsqROkePTGP5cghI2N3ImGiyicMAbkf?=
 =?iso-8859-1?Q?a8QyaYjPCQIQuxtI+kUMHd402vxtOBi9qOQUajVh5FJ+YsXXn6xOydQkax?=
 =?iso-8859-1?Q?5Iwe0KilMbYB+mcClyQEL+Mku1I+7Ba6Z4qNXEEJIX2ZHWMvePDjaBbSbb?=
 =?iso-8859-1?Q?LO5cSuzZfGhUX3D7J7usNuopV/eu2yeJj1njKqr5OAn+Mox0+W3p8DRbOI?=
 =?iso-8859-1?Q?0o6EUQGo91EDTzS21WJJboqVd4/Tj56AevrqwV1lSxMSehzdj1FjWXGvel?=
 =?iso-8859-1?Q?9S7LQ9xNMMCpn3T0lI5CKXsTXDGYBfWUrV/VkqbBJ5HXXeasdHo3do+pGc?=
 =?iso-8859-1?Q?LrFKrGHfaYaGKQafhx6bZ8vZLTJBiOleGnNO74SveKu9YhOJNNL0e7OAil?=
 =?iso-8859-1?Q?t0YNaaYU9NhN5Mu5rhA7qkxYE3z6nAyD3HfWD4kyksUuKEQ/LxeCrzVaRE?=
 =?iso-8859-1?Q?AEg7RmdCsByGyypNuwCGbUOhVp7BjgUz4Y96dOY+xkAOHOGg0SuE?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5176.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fcd3b3d-28cb-48f4-9450-08da2de9db16
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 May 2022 16:19:25.2354
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lTJNEakACjcLEhxPCizKlOEyNX1wZ0tf9iWxNPT8+251l670son2guapUqe3QOJWyJkrP6dd+2lGFFrUfL3Yyg5tkvOWf3aqyFJhIRaHNTc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR11MB5710
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ajay Singh <ajay.kathat@microchip.com>

Increase firmware version array size to hold complete version information.
The firmware commit id(Build:) information is also part of the firmware
version string.

Firmware version format:
WILC_WIFI_FW_REL_XX_XX Build: XXXXX

e.g.
WILC_WIFI_FW_REL_15_6 Build: 12804

Signed-off-by: Ajay Singh <ajay.kathat@microchip.com>
---
 drivers/net/wireless/microchip/wilc1000/netdev.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/microchip/wilc1000/netdev.c b/drivers/net=
/wireless/microchip/wilc1000/netdev.c
index 643bddaae32a..3c292e3464c2 100644
--- a/drivers/net/wireless/microchip/wilc1000/netdev.c
+++ b/drivers/net/wireless/microchip/wilc1000/netdev.c
@@ -14,6 +14,7 @@
 #include "wlan_cfg.h"
=20
 #define WILC_MULTICAST_TABLE_SIZE	8
+#define WILC_MAX_FW_VERSION_STR_SIZE	50
=20
 /* latest API version supported */
 #define WILC1000_API_VER		1
@@ -522,7 +523,7 @@ static int wilc_wlan_initialize(struct net_device *dev,=
 struct wilc_vif *vif)
=20
 		if (wilc_wlan_cfg_get(vif, 1, WID_FIRMWARE_VERSION, 1, 0)) {
 			int size;
-			char firmware_ver[20];
+			char firmware_ver[WILC_MAX_FW_VERSION_STR_SIZE];
=20
 			size =3D wilc_wlan_cfg_get_val(wl, WID_FIRMWARE_VERSION,
 						     firmware_ver,
--=20
2.25.1
