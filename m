Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2FAA6FB4EA
	for <lists+linux-wireless@lfdr.de>; Mon,  8 May 2023 18:19:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233557AbjEHQTr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 8 May 2023 12:19:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233993AbjEHQTn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 8 May 2023 12:19:43 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9F67C7
        for <linux-wireless@vger.kernel.org>; Mon,  8 May 2023 09:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1683562781; x=1715098781;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=Lw8uX8WgJToYx9dkDK5V3atibH8n+3TYF43BdT/FRKY=;
  b=Ai8pG6mwSYhjclIysAP8ovaET+Z9MNLxvqqlVYIA0idLM+enI5agtv0X
   DKoL4hqMHtB2ac/K6s5eHICDmhVGxGG/cCdTKhAuYhtNkL0r8BVc4ro9v
   P7vVevDb0cGWzIwp1jtGtyy0AvBTwMpSTTh2fHvW07uHT7XokWjCI3WHU
   f1wKiwVdYwlBb3DsANkT6kMJ9Jg+ZDWjEN3QhnPFGOoTQSXR3nbW95fgR
   b/ijb0pBp4o2Y3PuMESw0GwBrml77JTP+wIhI77GS5K2iTegxoMtpI59D
   M4j0eHHs6T3K62FF1LOjXSOD5p9a6u4MPQGQxf+KtwBwOvSfSXjJi6tHe
   w==;
X-IronPort-AV: E=Sophos;i="5.99,259,1677567600"; 
   d="scan'208";a="212416193"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 08 May 2023 09:19:41 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 8 May 2023 09:19:40 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Mon, 8 May 2023 09:19:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jxu+WbI3OweU6aGer2ADcd9Xnajgl/w4622nv6XFVRpkMYvlZFi11msygv8gBzUWiIznzWcgsIYRJ7HFEK/kZWaq1TPOL7gG/QJK/mK3Aj//b3wSR0XX0kYrIFaEgydxNWiFJc7Nf7d51GO+tmiKqeqDKWfyvJjxdeHg1CbRAoGnqIwJT3H0KtPlXgtHsKJ3Y/A3b0cmU+cRH9g0urSnrhEssxvpa6Etkae3lnXDOv3EBB8Qs0lYtpjKb1BntILlueezf1eX0Ri/IyCf26irj3SA3V0Xgmpa27qyJokzP93+dP9t5xF7RmLYsMZSWvpW50F+VLxzS+z5y9fhB3YEfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=asCF4RzinGPaKQncVg8qRD0t+sE3UUwLxIYlHtmpRCM=;
 b=M72jzkzmMIMh7YGOuYveKaktRKg8tZjh5vRvuk06zYMXkbunmnf8Rr7pwP8ZVrB1Mch0RbPRpYQfG+h25JXikkiuRkeqtlZwo9S0YpD6vGIkuRr3C7IZEdCLdMI3OIZ1lOcrv/qYKgLtFxGG3fcDJCixMB2cWkaB3NhzqbzN7t0jiwkhHrtXkC83DeKETD2BlH/hVoffpKsfARTRv9xFDmzT0KpQiy83zHU2LYJufXuulwaVUAvaNtsBD4X7G5+5AZvxc0P1ExgRYdRtOYFnAotrw3lptgAzkGHIAj+OB6+uqw3PBXfzS1r+QQOmzMXUUmMtAk5tNgb0e1CHTuCg3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=asCF4RzinGPaKQncVg8qRD0t+sE3UUwLxIYlHtmpRCM=;
 b=W571RubV2GKdo815QcPGgFPrP1jJYVRUecEJq2VqvIXHUHcKRga4urWJWVA/yUDoUInzjRg8ag7aT56w5iwDqoTPHDtus6wzXhFNzgPRzCwkbOlrt5YjGmpSqsofo+Nq0rbfajSko1imSkylvvbHsr31vzz60S3LxeCnaHNJu+U=
Received: from CY8PR11MB7393.namprd11.prod.outlook.com (2603:10b6:930:84::18)
 by IA0PR11MB7953.namprd11.prod.outlook.com (2603:10b6:208:40d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Mon, 8 May
 2023 16:19:37 +0000
Received: from CY8PR11MB7393.namprd11.prod.outlook.com
 ([fe80::120a:e19e:e1d9:4711]) by CY8PR11MB7393.namprd11.prod.outlook.com
 ([fe80::120a:e19e:e1d9:4711%7]) with mapi id 15.20.6363.029; Mon, 8 May 2023
 16:19:36 +0000
From:   <Amisha.Patel@microchip.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <Ajay.Kathat@microchip.com>, <Claudiu.Beznea@microchip.com>,
        <Amisha.Patel@microchip.com>
Subject: [PATCH] wifi: wilc1000: Increase ASSOC response buffer
Thread-Topic: [PATCH] wifi: wilc1000: Increase ASSOC response buffer
Thread-Index: AQHZgcjhXtj+hIJCrU+IfaMyxwn9bg==
Date:   Mon, 8 May 2023 16:19:36 +0000
Message-ID: <20230508161848.3509-1-amisha.patel@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR11MB7393:EE_|IA0PR11MB7953:EE_
x-ms-office365-filtering-correlation-id: 78acd668-6be8-4493-3632-08db4fe00471
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qI0ilod3sTssTC+Iu0q3/Zk3XhT9D0tGv5XsoDROIvHUZD4w23CF0/VJtXGxRlCb69lmSfrs2esJqqtax2iPO23+HCABtiNcoOgHe4CA3oUYNIL8cHJYp60PEmbDGw7CxomvPJF6qdfUjhm+0lFJlpAcn5g/0WRRUqxBDWBelTcXU2pXW9t31PcpmHk0ORRupv86N+F6N9PKlFwg4vwNMZv5Tbg7kiOBh17dhArlkSQu1Uvxvyp8TdPZ22rc7rZDEunX4Y0jrOLJC1ld0DsHtND1Hh2VxFheA55pdhErjugWW52/lok03lb5uQ4ZCAcb2Vy90Z2ZI3O8cZZz8U6vp3O/dPWiFY0HBIKM7UqD0HaFYETzZjASgR9mtaE5jkG6A84+G9w4oHEIJN6TFzP/S/cpIRu8aKxfpTLb6ltHGxj/wBqHOYEz7QPJz6Rvpp/NAO1ewYn/Y80gO0tf2Zy+nbmvsY77npdUNAhZ2Qn7CbWJP/QmJib8QRcHMc3uSL2Ro1HS1kqSH3LMPo/CJgzh5jy89QmHHDqPYE5AqvhbE3T8Z6uG+ra+MNE/672aw3xSbFm1K0mNlTLESO07VdDZWm2fEhIFq8EC0I+1BF7NiBnI34/6S1Y/yXpJx09EyJmh
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7393.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(366004)(346002)(136003)(39860400002)(376002)(451199021)(107886003)(26005)(6506007)(1076003)(6512007)(6486002)(83380400001)(2616005)(36756003)(38100700002)(122000001)(86362001)(38070700005)(186003)(71200400001)(54906003)(2906002)(8936002)(8676002)(316002)(41300700001)(478600001)(91956017)(6916009)(4326008)(66476007)(66946007)(66446008)(5660300002)(66556008)(64756008)(76116006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?mxxIKOCCyQr1pXvavhSY1INWi9Qa6g0QJVOUUYmnG30hB4OFVKHNtToYkV?=
 =?iso-8859-1?Q?6NXrpMIV8gdEq2LCMLL8eG6H/7aDw5oBPVYc2cXJMNSS2aFYvCOG7ss87O?=
 =?iso-8859-1?Q?EcekWfV1i4GIVuCR9DBxhW4Jv9YqNtSgDPRspZ4LbSYdf5X0u0FAY5Rk9K?=
 =?iso-8859-1?Q?YFPPjYt8GhxdbHt4fam33GDWWuCP+8VpFTn12nB4zh2RPL8cLAsKXM4QF/?=
 =?iso-8859-1?Q?HDUau5Nagoe71vk2TrJs2sluQJGZrsS4zkZL4MJVUdtvJF4p7OsJGNGk3X?=
 =?iso-8859-1?Q?bfXpPunPhap0QIiYfElQLf9+CijauF3wFdn+PT4+SWln1aEfBXWFV2PFn4?=
 =?iso-8859-1?Q?/02YLEbccDEJGAVELvudwK4/vVCD1ydeib8kdEql/fW8INFzuj0HkPUBDh?=
 =?iso-8859-1?Q?ebLw1WA1A38uiVg3rQzVQ9XLt/rFtM8djYLfxgxY7itNgHHStXEAP+8fqa?=
 =?iso-8859-1?Q?F9eR8qsrrELIk5EaWCiD+4uy2Bk/T22cIILfRXOQorX1W4FASxtYQ/T23L?=
 =?iso-8859-1?Q?0/uxpETytRc4uT3drqbXXOuGPdjrYw01RIqvrT9wU4vpLRz6HlJnLNxwXF?=
 =?iso-8859-1?Q?chKz207+LTvSXRPuubWwN/HA0GXV1CuV0r0HazHXTYAMXU62xDil2u1JJz?=
 =?iso-8859-1?Q?iRzsGCdItFsyb819ZVyX61/5SEInyJ2ceRgHLzOWrM70naxbnGT30rRKRE?=
 =?iso-8859-1?Q?ipjNiNIWyTwl6uiu90ENuY1bNxcseN9/Gl/8RjE1gQUZcsxlbS+ZRGvC65?=
 =?iso-8859-1?Q?bU1ZDna85Co0ih0CXeKmXueoCttCh+qxLmt4hRFxwTmo9Tl3/nTPSAl13B?=
 =?iso-8859-1?Q?8AMveiIN912iEDoz3b/95jAFvtObbm15Hq5sII3OHGuv5nZcFTTX82Cv/C?=
 =?iso-8859-1?Q?2AR7ud0cC4q85kScBSfmGJArWxzo8AwfK/rxYYHYrdChqnnsuo6QvjzZLT?=
 =?iso-8859-1?Q?4+ZIQNotKRaVmWVV2aymBO89kfx419y1N9RVJPWKwdnR1Xz+T6TsXKHOIj?=
 =?iso-8859-1?Q?X5CcEb3ItEVtTM3MGslF16dxe4my12ehNsSwOawZsWkAXrP+Ul0UVixEap?=
 =?iso-8859-1?Q?UKujZkJj0CoAMaXyklQECOOUkM8gJmc1e1UnLFOJ1wrZ2KbNHeoK13FKM1?=
 =?iso-8859-1?Q?pMBT1qxDYw8Hyc83mBtm2UstZRvMA2qtlWfcpZ/y12HgY9+ICcQTEA4vqj?=
 =?iso-8859-1?Q?SNW+DLtB/F9WvHZjmizx92/hsJEnU42M7syGjH7UeyjRlbuSqS+uyi34hU?=
 =?iso-8859-1?Q?P0Z2t0RFheY8/tpmFapubkwfBrIOtyHQZPV1udWdZ+lV1e0MZpDqi1RnEq?=
 =?iso-8859-1?Q?YcLCV6BTqAkmUF4wI3mrm3oNqK66QN7w9h3R3Owads4qfsY6HZCWnwdxfQ?=
 =?iso-8859-1?Q?EKYVPAZzT3+0mnE6U5YSvQoZ0gvBLL5kohj4cYBbnpa1InBFPZ5dyt5nEo?=
 =?iso-8859-1?Q?oXTyuT7PuGVPbyjyDPejEqqyxCVKehpVEYidewrOZfP4kVax7gIGlLCC1j?=
 =?iso-8859-1?Q?URmmC6vQ8DhF6HuQzgCLtR4+CXhOzYJn8bBIPvDjBWP+VFHGogYMmBa0A9?=
 =?iso-8859-1?Q?iIedsMoSfiUo1a6D6E/rA2RiK+BX0TVG/GZX+zuhGYrra9cSWvzGcTgCpL?=
 =?iso-8859-1?Q?I0to/njE0KrzHVebm9b3mqAG673YAX1aL84LlVx+Jpp7y7247FTv99xg?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7393.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78acd668-6be8-4493-3632-08db4fe00471
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2023 16:19:36.8712
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: m9RnFK4MSSNc00PXzgw+JZxnvDet6SZsVnRPjLy1z0RvxLl3dW+eAeVpVHf1dA6lzFOxlGJvPTiGaN0v0brIb3hZ/NEafM2td7l9irYi5Lw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7953
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

In recent access points, information element is longer as they include
additional data which exceeds 256 bytes. To accommodate longer
association response, increase the ASSOC response buffer.

Signed-off-by: Amisha <amisha.patel@microchip.com>
---
 drivers/net/wireless/microchip/wilc1000/hif.h      | 2 --
 drivers/net/wireless/microchip/wilc1000/wlan_cfg.h | 2 +-
 drivers/net/wireless/microchip/wilc1000/wlan_if.h  | 2 ++
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/microchip/wilc1000/hif.h b/drivers/net/wi=
reless/microchip/wilc1000/hif.h
index baa2881f4465..8e386db72e45 100644
--- a/drivers/net/wireless/microchip/wilc1000/hif.h
+++ b/drivers/net/wireless/microchip/wilc1000/hif.h
@@ -30,8 +30,6 @@ enum {
 	WILC_GET_CFG
 };
=20
-#define WILC_MAX_ASSOC_RESP_FRAME_SIZE   256
-
 struct rf_info {
 	u8 link_speed;
 	s8 rssi;
diff --git a/drivers/net/wireless/microchip/wilc1000/wlan_cfg.h b/drivers/n=
et/wireless/microchip/wilc1000/wlan_cfg.h
index 614c5673f232..7038b74f8e8f 100644
--- a/drivers/net/wireless/microchip/wilc1000/wlan_cfg.h
+++ b/drivers/net/wireless/microchip/wilc1000/wlan_cfg.h
@@ -30,7 +30,7 @@ struct wilc_cfg_str {
 struct wilc_cfg_str_vals {
 	u8 mac_address[7];
 	u8 firmware_version[129];
-	u8 assoc_rsp[256];
+	u8 assoc_rsp[WILC_MAX_ASSOC_RESP_FRAME_SIZE];
 };
=20
 struct wilc_cfg {
diff --git a/drivers/net/wireless/microchip/wilc1000/wlan_if.h b/drivers/ne=
t/wireless/microchip/wilc1000/wlan_if.h
index df2f5a63bdf6..254a046e3b1b 100644
--- a/drivers/net/wireless/microchip/wilc1000/wlan_if.h
+++ b/drivers/net/wireless/microchip/wilc1000/wlan_if.h
@@ -10,6 +10,8 @@
 #include <linux/netdevice.h>
 #include "fw.h"
=20
+#define WILC_MAX_ASSOC_RESP_FRAME_SIZE 512
+
 /********************************************
  *
  *      Wlan Configuration ID
--=20
2.25.1
