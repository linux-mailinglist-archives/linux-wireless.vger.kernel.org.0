Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2981651A545
	for <lists+linux-wireless@lfdr.de>; Wed,  4 May 2022 18:19:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353288AbiEDQXH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 4 May 2022 12:23:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353205AbiEDQXG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 4 May 2022 12:23:06 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FC524667A
        for <linux-wireless@vger.kernel.org>; Wed,  4 May 2022 09:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1651681170; x=1683217170;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=nIgCtjA3T/woosBzj+h8Jo8vfh+HiCIkzPYBhLX4RAw=;
  b=HmuhlUoq6Pir2NnG72/HHItP6HUn4jdX7glCiEnwGsfkSDIOoo9g1kx1
   nPGr7LqQwIfKlnTikBzNBUag7Tg0V3TEq9B14Qmk8VkJtBn5zwHxuO3jj
   ptDrb4PgR1BEZNQY2r1JO1SBxFk95eobzWpnutA4PAix/XegARmq0zL/e
   rZ7j5h07/tbkI8WBuX1LLs9uhM0nkombB8c95icKE+S5MtdopANi02skr
   9RtklkQHVv59Xfk/JDuxGaWUqoJRd1se0OCkT2//JiKLry4xiRmu9OKrw
   Vv8kxEI8PE4ptEOJXy5LNqHAkdMBuJOv1MehDXlTU91223LKPsYCg6l5n
   w==;
X-IronPort-AV: E=Sophos;i="5.91,198,1647327600"; 
   d="scan'208";a="162723814"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 04 May 2022 09:19:27 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 4 May 2022 09:19:27 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Wed, 4 May 2022 09:19:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nqcoee7vqm56fvsI4ufjAPgimXXwqYpUHB+GA/ngRZu//Lyd0qu1S8FrND7KSCAIdKnBS1k0Euwr1OC8wBNr0iaTPo57Hf3UR9PqkcsLvIc0RE/Oh6cak0QYGw2vX5o+SKWr37fjEeVKn0ohWnp3Um/XAU/eJvIqRouOC0OKWOxFvdziUv+K8Qwr8gWhjaK7Hoc/gAvQRA34B6DUmtIGWNcnYYkYm0KcnrG1i6qXdZ9/2JddMGP3gm8DqCOzyzditJqIJlj00PAgf1gZeZhjQgXK7zkkgTWCIIwu9s/DG6NnbLPwqnZUsEhCdqyWmQLgUvtRpEDIObg9yRHJSEDZjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mDatDKp90FJsrCHfnlS/I+Olx+O3XfyjayatXTDY/ko=;
 b=MbB0oKocV8TEdcw1eR2j9SmCRlP0kE3EzCn729yj03GGhiQsFvdqETIVfafblczqTXjFURp4fB4gs5QODTGLilDzsxdaVw0eco3gFoQBRzCTVbTYyTcwORHSByBOJZcT21FCLn2oNU9quHosaIJccRaqTKEK3Y7m1UOAsA+0yIy7ydrCGfOhHJMs62Ru9VYqFOPxjfLRCQjPnliH3HcRgjVmveu1URlP47iP+zPN8vkndLgHNgquW3T7tNbLJ3XI71uIgPAa9nXQLwoItNBy5sucHUxLUeN2eQU7riPvF72MuWcGIWtjU1C646xlyjLI2kdwLj3RCU7rW3gqFZ0xxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mDatDKp90FJsrCHfnlS/I+Olx+O3XfyjayatXTDY/ko=;
 b=Z/VizwtZZNvRxAjoKWr3dhyBSOh6ZRRcrhlhO3aA/w1lF2o0PfW9HZvZyJq7FZG9qmaHU/vrxy9KikYgjDGd+F0mjUmAA4tRflPSFecxeWV7fjNCC4NtBqnm6AlVqBN2Tt8PqTFLJpEZrkEhMO+SVEx69yE9aQXq8VJ2FCVQ2Cw=
Received: from PH0PR11MB5176.namprd11.prod.outlook.com (2603:10b6:510:3f::5)
 by BN0PR11MB5710.namprd11.prod.outlook.com (2603:10b6:408:14a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24; Wed, 4 May
 2022 16:19:26 +0000
Received: from PH0PR11MB5176.namprd11.prod.outlook.com
 ([fe80::d0fc:845b:ce0b:11fa]) by PH0PR11MB5176.namprd11.prod.outlook.com
 ([fe80::d0fc:845b:ce0b:11fa%7]) with mapi id 15.20.5206.026; Wed, 4 May 2022
 16:19:25 +0000
From:   <Ajay.Kathat@microchip.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <Claudiu.Beznea@microchip.com>, <Sripad.Balwadgi@microchip.com>,
        <Ajay.Kathat@microchip.com>
Subject: [PATCH 2/5] wilc1000: use fixed function base register value to
 access SDIO_FBR_ENABLE_CSA
Thread-Topic: [PATCH 2/5] wilc1000: use fixed function base register value to
 access SDIO_FBR_ENABLE_CSA
Thread-Index: AQHYX9K5c0qYSVlIhESRqTGCYnkStA==
Date:   Wed, 4 May 2022 16:19:25 +0000
Message-ID: <20220504161924.2146601-2-ajay.kathat@microchip.com>
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
x-ms-office365-filtering-correlation-id: e19441db-f3fb-4e44-766b-08da2de9db7f
x-ms-traffictypediagnostic: BN0PR11MB5710:EE_
x-microsoft-antispam-prvs: <BN0PR11MB571009D8F209B88B707817D1E3C39@BN0PR11MB5710.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ooaxHoVFlxJvdsBc27zFbOl25i6E1trBMn6idMCCrg+CZ9OACR1Gxxq8Oi3qFy39Y1POzWCnoNPeBn8lYnbVUnlDCbBH7XqRCoZyYIB0xeZQfKaK2aoM5bSfprympQdSALhj8IEYzqCZSUpHsoafwJfVsr8cu7/1zJD4M3Y0PxCHTvjWSu+EPmGSplBvvClmwEaJpVT1SxxA+vkn/FIO/QNhEEc7+DOpr9E17avv3fpfq1qlV3+IyVNWE6pUWCh+GAEII7JE5pLsJOF9aLrN8e6krWWk1Zlmg2UYhSeutHazUSGusaaWc1szoQ0Bc4wJbccz6hXf8NnQdlhQTqnHnrF8plM9qTzMlISkfaMF2og9C8dQiByzLKBPjhNEDci0yQgeU01Xc/mohVUbbrF0Qb9zsfhb55GF46qHbzyFhcz62oDXvXAB+l5BTAKfXeyHrqqXWdETIwTDdjtDc8kxamicOakLJT+26JmDpm4nBmkoZrVk20qjB28RoRgZEuq1xAvFekTbWqvflECMllM8yJzw4bRjBY8a/XeZJgjLfUUVEgxkMq/d7kgATzL8/2Dgc2hirHzsuiwDRkahBnaVDSR40kwnGBQnTakC95umrOyzSV4NJsW5WsACk+QqQ1yZAf/OUZxVgKqau/xhwAJ0T2EEW/aPCq9Q7FLmJCL1dBtDyzizdjWOn+t1XLbsy3CA4lGogRyvevZzDrSGsuWvhA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5176.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(36756003)(107886003)(508600001)(83380400001)(316002)(66946007)(6916009)(122000001)(76116006)(8936002)(54906003)(1076003)(2616005)(4744005)(5660300002)(186003)(86362001)(6486002)(2906002)(71200400001)(8676002)(4326008)(66556008)(66476007)(64756008)(66446008)(26005)(91956017)(38070700005)(6506007)(6512007)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?r2qM4t6ZzGQItAUlzQ+TKjkrzHJo7OjTkK34umZwP8DyWeydYH/3YjhKo/?=
 =?iso-8859-1?Q?LRxZJanQEBrp7ZlrJylqKGMdXFdqsI2RRkLW4z+p75E5AaprlvjuEyHu1d?=
 =?iso-8859-1?Q?/ZWJBmUE9VE6Q0SyzoZRULWtkHs173f9LzBzj6c1mysAT0XSMGsMAaCK1/?=
 =?iso-8859-1?Q?YpQI8plDuhgkZyqqxW/hZJBoEPVcQtxuDtnvWhDxOjHvyL5aWYyNOL9NW7?=
 =?iso-8859-1?Q?D6gegTsyRGoc5YsKuXlTKrRETkUGnCV4S3LRusenUvP2tZt6fqYChgf8M0?=
 =?iso-8859-1?Q?PJwghVTNuuF/DJ3MHepAOIgVMriw3YAjzcvW/MY+AqsdnukjK2VLb7DZNh?=
 =?iso-8859-1?Q?cxdUePWV4P0avSujXzJhvyfxD8uSzV+LvUPjKZV+iGo+D/n9/PUE+B6WYM?=
 =?iso-8859-1?Q?LhcNjZ2klrIrLsDUyDLBDGlfSCEPNxrhpNxPH76luHt7AsHBW/2RMB/ILl?=
 =?iso-8859-1?Q?f3392k3h1u3WV+Qk5KWt0znBsA6JChZG8CsMULk3B2gJWZJUYX52A/1on7?=
 =?iso-8859-1?Q?I7cQHvxhE1fV7kItaMbmjIfmffTtXnPR3vFWd1d6ZqQoz6EVKwsTuS4FGc?=
 =?iso-8859-1?Q?zjE+GjvfX+j1O+8RJEXG7I0PVCt07DsWR3iyVHelbeJnIUqmiqYJDibR1r?=
 =?iso-8859-1?Q?LqseWO0Nu23GU+H/KazNfIvjW+U801IcWZfyjY8kDBK6FHLcHJtRBQ9z8R?=
 =?iso-8859-1?Q?BMjHFKxDrarfsL7Liq/aHC9gW4aRJsFds/iRABBGpVU/rI+oIoblUEdIbi?=
 =?iso-8859-1?Q?2m5RM6ien0BnE+7yAv+/CDYbH5bbbjHz7ZQzv2JpR8FpO/G/eNc48gkHCI?=
 =?iso-8859-1?Q?fyBQNA5xHu+ia5Z1Ch0hfAVJvklUe0NaX1XnPlprbHwK4T9uXyLPK/wRIq?=
 =?iso-8859-1?Q?CXLX7bwyV8UasPyR4vJodXeYLK4nIgv9Uo4oaRXG3LMIAItcI/+LI8mhGD?=
 =?iso-8859-1?Q?YSDNfTm3VN+XG62uPtI8HTKwE3f8wiG+lNS1/gbACKGapxIQnWBRRtZsRI?=
 =?iso-8859-1?Q?No3HQkFd1eZ5MYt3pP4Ael+p4AyOeKC07L59odA1DCMDQa+UTufxClvRXZ?=
 =?iso-8859-1?Q?NiirVYz6dWdqbx5Gfqa+x4+UcDfyZ7vhT2HPLMYTdCG10/rO+KEeP/9Sh8?=
 =?iso-8859-1?Q?VV3HD7h5s8+TL0CZtr3m6esdPwBBX2WK4so2IzQaYtKhyt5mUPkAiZvI1C?=
 =?iso-8859-1?Q?kYVOZf8KMiFFq9kTtcAIgXpHkkI4O51Ws0/+n5UrPo09r12nvCTD4uysv5?=
 =?iso-8859-1?Q?ARPwj/PuYNXrtTNo0nHaN3BRDont4LnZ4xT342hXWdutvBgODIMJMocuYT?=
 =?iso-8859-1?Q?xK/ghj5gJs8FcqARPa4WGDiJI/rxwg/tegwp4hPdwCCEhNauzeH506bMdi?=
 =?iso-8859-1?Q?htnO1H9AlTBHrUjk+qNbc7ub8nAmDcaKHJ/WcxgAzKMbyYJ64sWxNMffZO?=
 =?iso-8859-1?Q?sASg8m/TVMi0SkbTztOkpXCoMnU8lmM58zftm8QOLGxnMxN98+2zI5mp+z?=
 =?iso-8859-1?Q?jfodVqmHBFWhhElPAGGpDZv1FPFGoH2XFP+zwI8+NFIsVyAE5xrEujxOgY?=
 =?iso-8859-1?Q?JPFyV8JZ4f6nPhlUFakeljKM7nAPpJwRMx9aRohsIi4wZBQkdv61bOeMy6?=
 =?iso-8859-1?Q?L90LysV3U94R9sCjBm4RWq9+NS+RsNBVvXBp+3hP8FG9orew0nkLq53vVg?=
 =?iso-8859-1?Q?uhfntF++I606Aq7uGgfu0DuU7Rs9n4lPnEcogGodt6I2lFuDxpo+NXp4xV?=
 =?iso-8859-1?Q?p0NRAqTLuYg4wItZNmccC0vKZ5oXDg8djffx78/9eTV6uDZMDZXGinD5mp?=
 =?iso-8859-1?Q?Uq8cKLqF+fvwgqXUQFPvP6wgtMBHtTeeEU2sHPTPk7yDqVNgwQXY?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5176.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e19441db-f3fb-4e44-766b-08da2de9db7f
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 May 2022 16:19:25.9071
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3hGiwjTaJg996dSbVqWBPjkJANvm85w/Xz+odSt5ZtKd9qbJdmiACFHMxZxtU/fT+FgmfDCnVq3LI+Pq7ct7XevZkFOBC4FhaCm2ocnm+9w=
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

The function number was not correct(reset to 0) when host resumes from
suspend state. Use hardcoded value in function base information
register(FBR base address) to re-initialize correctly on host resume.

Signed-off-by: Ajay Singh <ajay.kathat@microchip.com>
---
 drivers/net/wireless/microchip/wilc1000/sdio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/microchip/wilc1000/sdio.c b/drivers/net/w=
ireless/microchip/wilc1000/sdio.c
index ec595dbd8959..7962c11cfe84 100644
--- a/drivers/net/wireless/microchip/wilc1000/sdio.c
+++ b/drivers/net/wireless/microchip/wilc1000/sdio.c
@@ -598,7 +598,7 @@ static int wilc_sdio_init(struct wilc *wilc, bool resum=
e)
 	cmd.read_write =3D 1;
 	cmd.function =3D 0;
 	cmd.raw =3D 1;
-	cmd.address =3D SDIO_FBR_BASE(func->num);
+	cmd.address =3D SDIO_FBR_BASE(1);
 	cmd.data =3D SDIO_FBR_ENABLE_CSA;
 	ret =3D wilc_sdio_cmd52(wilc, &cmd);
 	if (ret) {
--=20
2.25.1
