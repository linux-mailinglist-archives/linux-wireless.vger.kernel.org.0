Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 017AA51A552
	for <lists+linux-wireless@lfdr.de>; Wed,  4 May 2022 18:21:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353337AbiEDQXM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 4 May 2022 12:23:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353323AbiEDQXI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 4 May 2022 12:23:08 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B39446678
        for <linux-wireless@vger.kernel.org>; Wed,  4 May 2022 09:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1651681171; x=1683217171;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=j7XYIGoq/EbhVAslnZ42wQOI6Nh4xcjyUHiR/sOGxwU=;
  b=m73Q72FKBAFD1OmNUJPBYWKKR+Mvdc5XsZ7BGpW5PGyL+7tzXo6+1c/1
   cJMuMu70lVP6WCap6nlx82umM5V2w3ZyDtNBytvHcIEsMNxCrsuAx8G/P
   thcrXjOFdU+hub9LNHK8Rd3fbLMV/Gq7bBQa9VEzhNIRUkTNmuYy8sWhQ
   1HCSLVDt94ZDdIg1kBurfA/kCfmkcOF7ooC4rbAUTzB6ftEp3cef8C69M
   2MZYV6UF+Z5GZBoHEQEMZ8eu/HHSWHiUh4cEXWxJXR75lVm9q0LtIDfG7
   AUKOCHiM6DpQ3jIBfyvBrHkilQZRlVcpKywJlvDbp4oaVJ/59EGw1PNiI
   A==;
X-IronPort-AV: E=Sophos;i="5.91,198,1647327600"; 
   d="scan'208";a="162723825"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 04 May 2022 09:19:30 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 4 May 2022 09:19:30 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Wed, 4 May 2022 09:19:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ifYMKlw/JaIYF9qXiuPS01dAJM/u9VUrEwAvql5e955e41ZRMOoV4F6eU5y3pPavpceQpTljKDa5Hx6tRBqsylmYKJ7U4pKM7PQ+i15kxGuCvkvpI+4Tm7MfDoR0qQoDwjlB/d2sldVXewDDb93M3TP7yLv0atP8HOTKTxyxMTxnoIMLB3eu0qn6apY3fU45+pcqlcZ+PQ4dIP3FAl6oKobc4fGsDoa5S89Kx2GgSRK2d/DtlMkt+qNiS99Db1TDa6nMzsOCdXFXdYLtWVmwE1mZmtO9F9ip7jjHmv3GbbZUFRt6TnPlRj7HJTdIFDe/ox52Qeq9s7eAnAjUi8IBbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8F4fEAvFW1CPAsTBXRYfeeddmOyJzm9u3ZfHMEaWFFc=;
 b=Ds7zAWB5lpvdeTbdXBdiW6EySlI+2K2n+RB3zPcMG7XnOw/DOC/MQjQsIgrMx7bXkrAQ2aLIWcM+jSpwUrki03vMqGWCjkZO4bW2qLM1vpT2J7BPNHB2aq1nOhqo6LIikoZT27v3PVyeJ0RjCkPJaKkUoyjj1UYlWRIhPO80hhrurvYsFVFVfgkEZ4y1PmABiGpLjfITdb5c51XqoYinS+L2aPm0nMyYgIHniXguCreeQcFtExDNt6KpbZKIPEBeRlXlfsVvvJmh//Qndpo13xxFQyzmVjGjuPfvaZHWljmjGe3KFARyX2owv6Blke1itx54sDhkX+tWLnkMKCyrrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8F4fEAvFW1CPAsTBXRYfeeddmOyJzm9u3ZfHMEaWFFc=;
 b=a79o/drEFFycAixJSTdPM0QQJixXpB0q0rz0rEUNfwDQK1VcUhFWv7bbnCp6VGzjP0zvXrn30qyR+CZhJyjZlGa4gaK4Q9a4EyW3PkHEiv/y6Y7/ef9FJ7aGPQik7me7F/A64EfB/Btlgw/wyqFzp/icREIisQTIYh2QYu1RdrU=
Received: from PH0PR11MB5176.namprd11.prod.outlook.com (2603:10b6:510:3f::5)
 by SJ0PR11MB5597.namprd11.prod.outlook.com (2603:10b6:a03:300::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13; Wed, 4 May
 2022 16:19:26 +0000
Received: from PH0PR11MB5176.namprd11.prod.outlook.com
 ([fe80::d0fc:845b:ce0b:11fa]) by PH0PR11MB5176.namprd11.prod.outlook.com
 ([fe80::d0fc:845b:ce0b:11fa%7]) with mapi id 15.20.5206.026; Wed, 4 May 2022
 16:19:26 +0000
From:   <Ajay.Kathat@microchip.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <Claudiu.Beznea@microchip.com>, <Sripad.Balwadgi@microchip.com>,
        <Ajay.Kathat@microchip.com>
Subject: [PATCH 3/5] wilc1000: fix crash observed in AP mode with
 cfg80211_register_netdevice()
Thread-Topic: [PATCH 3/5] wilc1000: fix crash observed in AP mode with
 cfg80211_register_netdevice()
Thread-Index: AQHYX9K5kogwjz9cOUmXVoMCp0LCgw==
Date:   Wed, 4 May 2022 16:19:26 +0000
Message-ID: <20220504161924.2146601-3-ajay.kathat@microchip.com>
References: <20220504161924.2146601-1-ajay.kathat@microchip.com>
In-Reply-To: <20220504161924.2146601-1-ajay.kathat@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.25.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9cd09fed-f918-49fc-2004-08da2de9dbce
x-ms-traffictypediagnostic: SJ0PR11MB5597:EE_
x-microsoft-antispam-prvs: <SJ0PR11MB5597A053F4998D5C5F853FDAE3C39@SJ0PR11MB5597.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6TwySxJg1KTCSl7S10N4H0K1i/SdBaJTpa7MnHBObTmXt2DT02Bdm1yeTKNeIKT24g1nV4RxkQAOkkiHIKhxbgW9OHurkn3zqxxl84LbYh1xzY0lWDAaFXK+xswBsjsMDUumFo6Y1mBxcV8VOdsNG2KZTwqOqtAnddQGigHTMvNS0hkxefo9UKAvZ9Id6y3jIXpIYGi2r5Ref0xl9sntqquVFBAAbaMAwQploHZc0MGW6/fjD7BDoSRlkMcmjx5nCADvWzZnmu5nLvPzNbo5jg3EvWkEM7uDh0ASnk+hlhPec1SOwwGlLVeCG2kmm1N+7qoxYbdMemr44Uh7OP3kWeEAnThCqA096hv834qcVhERIYcYxIKglZ1O/oiyB+3mLGuMpoZteQvQyHko+QIaoYCT0jxp9UtbiIHNcoEmdOtbvoyycdLydBgkH/UBOxQMVfTyTMDmyZEnhZdqt0CKcvysOt3we5CA/+ocXlTB2OZVknfQl9rjYFpywTlxvAB9hyTe2uLloPpG1RHa3UzlRLxl4U5JGXfwfPd5mwrwFPGSDcmV86Dbrtc/6zBxpQeJTrva8xfl9w5xb9Hd5GHw0oW1zFzqcL1KST9489g1esfr9IHTMo48Zf3VnZDCgsco8EGU1wg0LXgYUCdTvL6oRMywzNO1sSgg9vk7qHLMlv7ojZ0GqMlSACRXaZPa9SRxRPkLEXT8Q3vdt0BdqgPtMQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5176.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(36756003)(38070700005)(38100700002)(6486002)(122000001)(2906002)(8936002)(6506007)(508600001)(1076003)(4326008)(86362001)(6916009)(186003)(6512007)(26005)(71200400001)(2616005)(54906003)(5660300002)(316002)(91956017)(107886003)(8676002)(83380400001)(64756008)(76116006)(66556008)(66476007)(66446008)(66946007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Z12x0fwDKshR2y7608t7GY1CpUjRTH1JGrt6hxMmRdBFwWVA2M18kyumBd?=
 =?iso-8859-1?Q?yGQAroodd8cwA5FwXpXlJV/pMToj/9pTCIussybNYS0ULxptKWX7YUDP/y?=
 =?iso-8859-1?Q?IVCtMZgKo4esyVEPWhhNm5lqQPAS3bL6M3F2r+V8fVpGZQ1CR5TYUz6lE8?=
 =?iso-8859-1?Q?gb3+vL3Xjk7uETpT33qzdg7vG4WA2Xr54se6K++PungsNqXHrQnOeSVu3H?=
 =?iso-8859-1?Q?jc6r3yE6+60Us2eAUflBUjrv7ScaKa2MpVbBUGUxqer82OrrQLJN4xXbnr?=
 =?iso-8859-1?Q?L7he40n4/FKxTR2nPfMFKXfm4kq07yquVa8ownQXgSICuBIIk2bgWrTQ1c?=
 =?iso-8859-1?Q?so1tbt6RcGLbOTcCIXWsrPM/L58evJU+7fgzA3MBVW23rDfKB++uI93psq?=
 =?iso-8859-1?Q?8D0waD170RYBbyfBff4KFJMDPAz+pl3CJjG0sX3a0oBa7ZaiMAGnQ+U89e?=
 =?iso-8859-1?Q?uH2gJ8qITFL8yPd9IcsV3Tk2b0u6UORNpsxNZpq8DsDBvXy8GUCXSgYAJQ?=
 =?iso-8859-1?Q?Wr5qLOv94Gcpgy40pn/++7azoOF1HCGbj0YX/E9ABNYFC0m8S0GaDI6g4V?=
 =?iso-8859-1?Q?BhR++eqiOKvT3HbH5Vaj8jtfh7ViO8w/8I0Ke0n+/2ATO92IkjMAOGNItK?=
 =?iso-8859-1?Q?ECMyBBx30enxwstlAumz/lkvRpevq7+Nj9lHLb3HS9e/dWRBqq4rSj/gcg?=
 =?iso-8859-1?Q?mZrJYlAbezPdVOVddPVQ9alio/zOzQJebkQEyFgy0k1HA6aZyrVfVK7DKu?=
 =?iso-8859-1?Q?qAi48no3vfikBknpdkN8JYhZqiRsu9nhQnINUe9bZUas+rgsabpqB2uFBu?=
 =?iso-8859-1?Q?fyKJ5h9bS55xcExn+rYxMpqySSyIEz7a6zSI57Tc9wmPQuC79vMPYSHeMj?=
 =?iso-8859-1?Q?iqIfHuKfU8MMpSiumC3xz7LuyMC3R4vLYf3jC1WOHW8g1qa47rtAY1DfXI?=
 =?iso-8859-1?Q?ZnCm0D7r586PagJjzyH5gLchl4oiOBa00MhnBjQ/LxJAxOHdQ92wKegIo5?=
 =?iso-8859-1?Q?FumWoz/06M8ShfmuuJMUWri/qaexvByeQSTNHhKXvP1YUYKzckbi4iSW7U?=
 =?iso-8859-1?Q?3HbGWlvgdsVQU+Dgx394m6BMcpXt2huMOiRjWHQ6uaM1pSRqlnLvYmuP2A?=
 =?iso-8859-1?Q?ZBBMWhmqBL897kLx7kaLBWT7csZM5opWtARJGSsCqZF/emQo18cVeLX40U?=
 =?iso-8859-1?Q?6tanlxDcddwOxl+AGwgCr6X4sCEzWIlwE3qR/fpbfcxEq45mhfFlOrACTZ?=
 =?iso-8859-1?Q?PfdifxXlVxBkp+GXddN6VVpeQWlt0piD62/DkXv7o3AmAen8a2KC8Dm+aC?=
 =?iso-8859-1?Q?4z6TPEmKq1KD9yw0VmrhhYFIR2AltmWSPcrxkSBLt474zyPiuRMpKM8eQC?=
 =?iso-8859-1?Q?Ey9qNaJBn1YJusKDcypYKYWt8tOgrHwUntsOTOfzr60631Kvq9SUzkFtu8?=
 =?iso-8859-1?Q?orOUxq9sFOkUJYR1+XLBTbvnNjW6e9+teYoLGUGwXi84wOOnE3+JEbMqQB?=
 =?iso-8859-1?Q?klrOh7TRHwrVumr8pVEa7hvG9KIjGE7bxNbQFyu/sx/JWWPHjpMjsnyUMK?=
 =?iso-8859-1?Q?lIVZka/GhjGflMp38HxC//mMOeefj3wkoNVSp+StjmaCosAs8gIxlc0Mc+?=
 =?iso-8859-1?Q?NFqn+giAXrFZLKVHZhOWvE+koN1Ex5ds9NP68xrB52y7afXuO1tOTkYtmW?=
 =?iso-8859-1?Q?D8wI2e29MjFz4uPiJRVXSujDPPlTbR2XhmKJvIZvKdL5aqhwtGbLJrXn3i?=
 =?iso-8859-1?Q?wJze6avYu6J90EHulbZNf9WLU+Cw1m4qGc6ic1FOtZ4s5meqZBSjBNr47z?=
 =?iso-8859-1?Q?ea7sLAIUc9KW/NZGqQXggREeO8ADJEeVkJIQww01TJreUAoh/ayk?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5176.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cd09fed-f918-49fc-2004-08da2de9dbce
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 May 2022 16:19:26.4382
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lGjSsG9H1x6dq7x1NEXir5wL7WUQxiENHcI4vFcqJq8V0S+urqQQ6qLztFzixdojl3spxddZbxv01IRiGOQeJUEP1EiZL5jV9Yf/Ve8APlY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5597
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

Monitor(mon.) interface is used for handling the AP mode and 'ieee80211_ptr=
'
reference is not getting set for it. Like earlier implementation,
use register_netdevice() instead of cfg80211_register_netdevice() which
expects valid 'ieee80211_ptr' reference to avoid the possible crash.

Fixes: 2fe8ef106238 ("cfg80211: change netdev registration/unregistration s=
emantics")
Signed-off-by: Ajay Singh <ajay.kathat@microchip.com>
---
 drivers/net/wireless/microchip/wilc1000/mon.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/microchip/wilc1000/mon.c b/drivers/net/wi=
reless/microchip/wilc1000/mon.c
index 6bd63934c2d8..b5a1b65c087c 100644
--- a/drivers/net/wireless/microchip/wilc1000/mon.c
+++ b/drivers/net/wireless/microchip/wilc1000/mon.c
@@ -233,7 +233,7 @@ struct net_device *wilc_wfi_init_mon_interface(struct w=
ilc *wl,
 	wl->monitor_dev->netdev_ops =3D &wilc_wfi_netdev_ops;
 	wl->monitor_dev->needs_free_netdev =3D true;
=20
-	if (cfg80211_register_netdevice(wl->monitor_dev)) {
+	if (register_netdevice(wl->monitor_dev)) {
 		netdev_err(real_dev, "register_netdevice failed\n");
 		free_netdev(wl->monitor_dev);
 		return NULL;
@@ -251,7 +251,7 @@ void wilc_wfi_deinit_mon_interface(struct wilc *wl, boo=
l rtnl_locked)
 		return;
=20
 	if (rtnl_locked)
-		cfg80211_unregister_netdevice(wl->monitor_dev);
+		unregister_netdevice(wl->monitor_dev);
 	else
 		unregister_netdev(wl->monitor_dev);
 	wl->monitor_dev =3D NULL;
--=20
2.25.1
