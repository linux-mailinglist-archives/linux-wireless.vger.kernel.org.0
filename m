Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F84074B76E
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Jul 2023 21:43:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230516AbjGGTnF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 7 Jul 2023 15:43:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230245AbjGGTmy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 7 Jul 2023 15:42:54 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22FB226A9
        for <linux-wireless@vger.kernel.org>; Fri,  7 Jul 2023 12:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1688758877; x=1720294877;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=4nbJsR4YZGvfpLyALStJYuq/7OmxN+NxDyQBzFSAKO0=;
  b=ytez5EfgzGH+5/K3uDc6cYwpLvB1dHe41b/HU7pgt74Hney/vw+wtvoZ
   OpE3UUN2BduxE8zkb0qU9RBkM8Q1eFkZXHyCRE0oYyI2I+Sc3QUghrsCz
   kO2IaUrSMjcpKNjmfVtsO6RBjjNK3wzQ8r3IAyZ+Ux1JFLgMk3U2wuZa5
   M3xhfjzf7ejD61oFas1t8pEujgrDHYdxL+ZwfdjX72h0m33Gn29grCddW
   /D7AxEUZDFHWPg2dvmfvE5vJpMbRuB9tikHrIW3wC0BK0hRYj5XgowFuW
   MN6H+I0y0d+mbDq/4RD4jpokAgdlBNZYOz1jM4oFc8ceV+yTHOeNmngva
   Q==;
X-IronPort-AV: E=Sophos;i="6.01,189,1684825200"; 
   d="scan'208";a="223667797"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 07 Jul 2023 12:41:16 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 7 Jul 2023 12:41:16 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Fri, 7 Jul 2023 12:41:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PF0ioLCHTx0d4J0KXH7fnY+byjcNo4sraEGiyqdxS7hqN79cDuFMHj58e/ir71vDeoQ3Sk+OuEhVkUKTyK5diabqLV2HOrokh3LG9S/xd5rYCQbjGNECv4j2x04pBy/P53LNpEBfBV9n5TMMbr0mDnZh1BgyMpk+9X124t0LYSmrGJh8WwWUqG3vf7UKgbL3buudbzYRBgfGTsNCryjAynfOzEXkbhtSnZ5l++AEFWqUQlLATFChPVdm/tspXqpNEMTIN9TAhWRl3REaiF3ro1xypLfpTheiawzy/K7oFWHHOjvTYeW1+HSJF/6AOfe8pCOi53HPRbpFfdquZS5Kew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nh+WeOPsj95AQYnL7atLJZ4PxgsGtMihYG0H6mykr+Q=;
 b=YZWq5SEWz1Y0liVL4465elkhHMDuer7G8vyFQL6eo9SRRbzmj/0DnU4o5XaTh0SbKlyvDcRCaigW6BV80kQYFTRVLN9GpY/ZEDHBcEBd/h7Fqd4hZffuBH0lo3ex9xo8SBjhZIYHSlsTaaLZ+9s2SWHze0CqU7dCR7hT+A4w7QJzOpttQ83YmjOVSGE9Kyo4jnu12eETm58xDslneJzLTyNekuJW17owLyBDbgBSke4x6Ct+zeR9zX8YEBvRf160UEkPPMrX65qtD8fd73C5mnu+E93KWwTjwP93pRUrnrNFbv1fI00kvopprmAWTGwWo6UPnUs6Kktr2fdzmqCzCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nh+WeOPsj95AQYnL7atLJZ4PxgsGtMihYG0H6mykr+Q=;
 b=AkTYxznBpkVPeJ04HyLPzSkZ0gwctyGE1IvvLJiK1cDCAtwDqi1RDcozKBMxu3yz4v8CRJXcb771SrIz9g3+ek6Mnz1BmwKsGwtOx1nmfrAbfcD4PZYnzUNcxCZSBW8bPpsKKAy2TuCuEPdEbwKHX0VomahTeytwCXiLlan4Grs=
Received: from CO1PR11MB5172.namprd11.prod.outlook.com (2603:10b6:303:6c::10)
 by SN7PR11MB6851.namprd11.prod.outlook.com (2603:10b6:806:2a3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.25; Fri, 7 Jul
 2023 19:41:13 +0000
Received: from CO1PR11MB5172.namprd11.prod.outlook.com
 ([fe80::ea9c:8971:305c:c5c6]) by CO1PR11MB5172.namprd11.prod.outlook.com
 ([fe80::ea9c:8971:305c:c5c6%5]) with mapi id 15.20.6565.025; Fri, 7 Jul 2023
 19:41:13 +0000
From:   <Ajay.Kathat@microchip.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <Claudiu.Beznea@microchip.com>, <Sripad.Balwadgi@microchip.com>,
        <Ajay.Kathat@microchip.com>
Subject: [PATCH v2] wifi: wilc1000: change firmware path from 'atmel' to
 'microchip/wilc'
Thread-Topic: [PATCH v2] wifi: wilc1000: change firmware path from 'atmel' to
 'microchip/wilc'
Thread-Index: AQHZsQr8xYfyiYJXlkSvmHc+dTfaZQ==
Date:   Fri, 7 Jul 2023 19:41:13 +0000
Message-ID: <20230707194025.47085-1-ajay.kathat@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB5172:EE_|SN7PR11MB6851:EE_
x-ms-office365-filtering-correlation-id: 1e50de95-cf8d-4ea4-3137-08db7f221f81
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6IkGrdzqJrNEED/+zLNzrKqYQJNxzaWYFSYAV1blp3QzvfEe7InFPd7SiA2FOIkcjMuwXKwqcFKD8cAw8T/GB6IlJO2VeyxhkOBUBrD8PjZ7eM6TWmvQurDCwVGjb0cd967BC+BIS2xuTbsfutGBoYIgJS6sik1C0hNI8RTOc6+/Ofv/ioaWNCSaTwekQu1ofL1UFt3IgwHqkP5+MSGW8ukc6xZRnLJ4IHD7+IfOgLgsQKuQ6V2KOwBeWFimAtdBmp6DUEAHCthq61wME7DSrdVvUNLtIl72FYzdiajA/BSLsywtHpPznDKMYIwgnWtZl5w4ikHTBJZsVG0flhLn5X3AqxRsK52Oekq7enMIq40e+K5kH97EYQAeKFIjtye7e7tMgffI90UpVPw2t0CZhGf4AZcuko2fYmoRWewCjErsOE3MtqV89Pw7hFSmKGG9buZPLdo4355mCMK23QI30pcqXZ2tlc7TZ+QdjLWiBKK3tXa/hShMvCLLP5jkuZBs49BtTGtSqSRjFbAdAiWtDJhp9JzweF2XkXGw0oGFffQoIYiK5RTeOMcE5MOisHf4NMJW7jzRJJRgfw+n6pDvQuwfbwEbtcNgFNldbnoO9P9Bs5HjMosYvWunBRxDUqDr
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5172.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(376002)(366004)(396003)(346002)(39860400002)(451199021)(122000001)(38100700002)(36756003)(86362001)(38070700005)(6512007)(41300700001)(8936002)(107886003)(26005)(5660300002)(71200400001)(6506007)(1076003)(186003)(2616005)(2906002)(83380400001)(478600001)(76116006)(66946007)(316002)(6486002)(54906003)(8676002)(66556008)(91956017)(4326008)(66446008)(64756008)(6916009)(66476007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?fXY4Gp699MJIgWnRZib79Ce2JZgRDM4GEtFlmPGPpv+sPlqKKfBMVEQ0ep?=
 =?iso-8859-1?Q?0V71uCwKlBdHjsPdHh9FZ3baGtu3eG7d56d+o5Sn7Jq+rIIFgVW/Pi0/d/?=
 =?iso-8859-1?Q?OsG9ZJ+KBa4Rr5gFryNxUQNa3rVZnqkU6zZp8TFqWq2CXob/GaPj2ZLL4I?=
 =?iso-8859-1?Q?BRHugHVnSJs9e0pRaIXJpqXTlfEnHYa1uPrpp09nux4e+V078n2MXr/IT5?=
 =?iso-8859-1?Q?3RJKWiisrK0PTsPp3Ds9IY0ymZhLzNjD3zWpQSj+w2jBXMoiIbh3mh63xS?=
 =?iso-8859-1?Q?XLMPsfH2CwWoEXx7LY2gFPGYV5yBAJI3hdSc2JlyA63VBLFFtgWoHH0fs/?=
 =?iso-8859-1?Q?S1c639KuYTetX+zaViUUfuyxmQf1I7QRwFqqvr30SJ7tXOHwS6/dWu7Eus?=
 =?iso-8859-1?Q?OAKqg5iWCfcngMrIss+YkelxDVBkkpPFGaXlJl3S92fWbugG9j60RHfwPE?=
 =?iso-8859-1?Q?PauwZx4Nwz53ZdnEuhUvjUhMOtdgrvNof6Saiz5wVxl7Tvgi3fv3FuWCcH?=
 =?iso-8859-1?Q?brqYR1MKhl20GTwQiauRryrhqR3VutJU7kh31gy9NGbNvcOKRC7Y1MCsgK?=
 =?iso-8859-1?Q?5V6u1TmAwA3GMYAWlxiRORA3OXwUd6sg3WxTVI5G7trozRMR1aW6Dj3O0T?=
 =?iso-8859-1?Q?/FA8gFcsMKE2+yMMH0W98+NnEBm9+svXIEd5AxDe1w3naiQxnWuhXtpBRN?=
 =?iso-8859-1?Q?wZo8RFUbjEJQngzjnQzMAqevqKKRQAP1QyxsPyXq9vnsPJNu6pBA1VSVyZ?=
 =?iso-8859-1?Q?1lrcBPRRsOr/q8AKw/oQlyTq5vH0I/bnI/zorgUtypKrdCt83K4nBWLKn1?=
 =?iso-8859-1?Q?LzXdFVsdPApjhQghqqZcRj8AZBZxMWaNhoCY6M7tDzMa3oMySy4jAM9WG2?=
 =?iso-8859-1?Q?ZRY1Olw70KN6N/7buYYXkMJML11MRtk4UwQMbp3bsV7ZGafox5ZNUllrKb?=
 =?iso-8859-1?Q?sOAHJiSSgKcbN3ivwT12xieDccrP/mV0V/3vM5O10WjzPXg/h8JAHJLpht?=
 =?iso-8859-1?Q?VMpunBB5d/grTfzTw315PZePF2Gd6jMHw5xz0lEsFuP438a/qhAxl0/lW8?=
 =?iso-8859-1?Q?pn7IgKremse8gRuefAH8ohVdF9FV4aX6ad8pFEk+q9IWjD+/FOAlWNtFvv?=
 =?iso-8859-1?Q?k/hJHR8zGmy8yu/W7MpOBINZcaajoU8gmy6JGWfSu07hoOocgNKPSrFUN3?=
 =?iso-8859-1?Q?obFYotgFmfam84ypLQyS8DDk8o8V1yxJVwDfVOPpmbYF4/+qyNHGjm9izY?=
 =?iso-8859-1?Q?1Ny7CsXBuBZfX4IpBsbFdHLOdZErjahh0R06T4DwlQ8w2QMExkLsuCP3+P?=
 =?iso-8859-1?Q?A55GHHvagLP5vhRIlX+zuhSaiW2Or/MekbvsXO20YMaP8xhJ0ZpdhexeDZ?=
 =?iso-8859-1?Q?2HGhTKZ4iBoUYBRrITnV4sQxKLgWdSdhmV5kL/rZr+U/Qu+14f/0ngadV+?=
 =?iso-8859-1?Q?oFoF4el88luKZON8KR6kTzq2KzFxszDJAu6nU1obxabeBq7DqZ/HAqtc3l?=
 =?iso-8859-1?Q?5OPCm2hwKueO928GazeIpS4THm0OOQc4e6hK/6edNyyx7MRdo45QARuS2f?=
 =?iso-8859-1?Q?n+fWC2EJOabAQnmHVLksvjruOMcW7aXrJlHmmTPlnxt4OEpFULMasN3ea0?=
 =?iso-8859-1?Q?0oWvDeatl3DHMhHrhBE5VJo8MAoEYFWfgw9CB10VI+9g0CLMycf7Qa2A?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5172.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e50de95-cf8d-4ea4-3137-08db7f221f81
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2023 19:41:13.6823
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZIW+P2m0zespi3kLPaQOyvv6MqwIs24QL/puDFY9TNk0iDfM/rnstfXlb60vosrf8Crz90y36A/9Mo4oVmBwWNklUhTcP8w6QBJTusX15hY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6851
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ajay Singh <ajay.kathat@microchip.com>

To inline 'linux-firmware' path with driver, the firmware path is changed
from 'atmel' to 'microchip/wilc'. The path change will be submitted to
'linux-firmware' repo.
For backward compatibility, when the updated kernel and older
linux-firmware that has firmware at 'atmel/' path are used, add a fallback
method to read firmware from 'atmel' path.

Signed-off-by: Ajay Singh <ajay.kathat@microchip.com>
---
 changes since v1:
  - load firmware from older path when firmware is missing at new path for
  backward compatibility.

---
 .../net/wireless/microchip/wilc1000/netdev.c  | 33 ++++++++++++++-----
 1 file changed, 25 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/microchip/wilc1000/netdev.c b/drivers/net=
/wireless/microchip/wilc1000/netdev.c
index e9f59de31b0b..c0dd7072decc 100644
--- a/drivers/net/wireless/microchip/wilc1000/netdev.c
+++ b/drivers/net/wireless/microchip/wilc1000/netdev.c
@@ -19,10 +19,13 @@
 /* latest API version supported */
 #define WILC1000_API_VER		1

-#define WILC1000_FW_PREFIX		"atmel/wilc1000_wifi_firmware-"
+#define WILC1000_FW_PREFIX		"wilc1000_wifi_firmware-"
 #define __WILC1000_FW(api)		WILC1000_FW_PREFIX #api ".bin"
 #define WILC1000_FW(api)		__WILC1000_FW(api)

+#define WILC1000_ATMEL_FW(api)          "atmel/" WILC1000_FW(api)
+#define WILC1000_MICROCHIP_FW(api)      "microchip/wilc/" WILC1000_FW(api)
+
 static irqreturn_t isr_uh_routine(int irq, void *user_data)
 {
 	struct wilc *wilc =3D user_data;
@@ -187,14 +190,27 @@ static int wilc_wlan_get_firmware(struct net_device *=
dev)
 	chip_id =3D wilc_get_chipid(wilc, false);

 	netdev_info(dev, "ChipID [%x] loading firmware [%s]\n", chip_id,
-		    WILC1000_FW(WILC1000_API_VER));
+		    WILC1000_MICROCHIP_FW(WILC1000_API_VER));

-	ret =3D request_firmware(&wilc_fw, WILC1000_FW(WILC1000_API_VER),
+	ret =3D request_firmware(&wilc_fw,
+			       WILC1000_MICROCHIP_FW(WILC1000_API_VER),
 			       wilc->dev);
-	if (ret !=3D 0) {
-		netdev_err(dev, "%s - firmware not available\n",
-			   WILC1000_FW(WILC1000_API_VER));
-		return -EINVAL;
+	if (ret =3D=3D -ENOENT) {
+		netdev_info(dev, "firmware not found at[%s], try [%s]\n",
+			    WILC1000_MICROCHIP_FW(WILC1000_API_VER),
+			    WILC1000_ATMEL_FW(WILC1000_API_VER));
+		ret =3D request_firmware(&wilc_fw,
+				       WILC1000_ATMEL_FW(WILC1000_API_VER),
+				       wilc->dev);
+		if (ret) {
+			netdev_err(dev, "[%s] - request firmware failed %d\n",
+				   WILC1000_ATMEL_FW(WILC1000_API_VER), ret);
+			return ret;
+		}
+	} else if (ret) {
+		netdev_err(dev, "[%s] - request firmware failed %d\n",
+			   WILC1000_MICROCHIP_FW(WILC1000_API_VER), ret);
+		return ret;
 	}
 	wilc->firmware =3D wilc_fw;

@@ -1007,4 +1023,5 @@ struct wilc_vif *wilc_netdev_ifc_init(struct wilc *wl=
, const char *name,
 }

 MODULE_LICENSE("GPL");
-MODULE_FIRMWARE(WILC1000_FW(WILC1000_API_VER));
+MODULE_FIRMWARE(WILC1000_ATMEL_FW(WILC1000_API_VER));
+MODULE_FIRMWARE(WILC1000_MICROCHIP_FW(WILC1000_API_VER));
--
2.34.1
