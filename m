Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F26FC6EB167
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Apr 2023 20:10:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232021AbjDUSK3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 21 Apr 2023 14:10:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231910AbjDUSK1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 21 Apr 2023 14:10:27 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3D4B2137
        for <linux-wireless@vger.kernel.org>; Fri, 21 Apr 2023 11:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1682100624; x=1713636624;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=bebZslGPhAfq6duQVkdkC6TRYVExeqqFU4pJdQHEn3s=;
  b=vtvlTqm+zuAOM39BdWR0Objuel6YTq0K+bEd4RHkO52tUChCwoRl9olM
   KKsVw5faVHNmDOdCglOSIxn6TvnYRfmWso10DNybv2QPTuG9wXpv2Z1Ol
   88+OOA6VH7FcjgfF4XzDfXfHWPhdeERPlGdOSFX3dsZl+dTA6uvsxwObq
   q5iNWa2jlaiSZ6yDXsDRCyCtnfgV6Inktpd0XaUx1r8/ptqAS6mQekQEE
   nilWvKkLrcCd+bANVY+SnOgsHRB2wekWm6w8diHHSwQ7xEMU/2aw8696g
   WBPSbc67BqvBz9CELAl0sm8gFia9QImvrdAVnHaudlix1L4sqG/PiePg9
   w==;
X-IronPort-AV: E=Sophos;i="5.99,216,1677567600"; 
   d="scan'208";a="148338664"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 21 Apr 2023 11:10:23 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 21 Apr 2023 11:10:22 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Fri, 21 Apr 2023 11:10:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IFcMuulZkZsl2lsFJLjGbBE2hMyID8rvo40mzz4QhsK6+SDdv69/3XMmrRnnGLWSmcjQI42ylnwtNOMgX8HRiyAYlVg+suSEgPB7EgZPBd0nAsOpPMQxvFexuOrvxUVZU1Q9l96mM96yDLBbj7CSjbB0tSx8R4Y74tEkRCuqne6Wpa9nidfoQ1BwrRDTbvvsLl0oJMsWIkbaHOX9ODpfJnzM03G7MwW7Dzes9Cbrob71WizDtq5K3KkXuqbxeunDV6dbpraMlGz6NIa8HHc50VBtXpy915cUfjj8pkCTwS0ondevUb/buiyzSLUoTUpzXqxxGw6pgvOeea8cozdhiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=swpRFEcxzU1DVCN+3t36Jh8kQdHwolHG+TMG6r9NlGA=;
 b=akfEeIDwosoNGHo2T5PS/CLq3kvm0yPAhrshCx+Lw9+SbMVTR5SHiTxvhKaiGDY895g48BJNlcIifpcTtIyYfx9cjBq+nvXr5n8ha01hAqrk0VnXvlycHioW1qxCNl9jzTI0IioftO0qPtocFShNTCtfENDjl3HqYdGhxlA8FUJVuY7YqlkyE5rKxgp9iHsPYBjf524edNYrY2O+wsWPKgfgg43IxvvL4cgOxTsF2hB78Zc65gWZqszNt1vNFIg8VvgCFb8BRYcR5GeXH/3IC5LmE/OzjXeuzfYyoU+bwG04U9510sXe/02fC9i3KG5il6SoTzrjy6DH08+dYTD37g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=swpRFEcxzU1DVCN+3t36Jh8kQdHwolHG+TMG6r9NlGA=;
 b=ZteqCuanOcRUCt1nM0g9Z8xiguZV+2VkLv/W5A4P9fsAJz2fJxvAAs0g4WsS6n6CW4MH9n6NE2EK1aNnBf9CeSJFO1LjykPgOaXAKGTQY1No0w+zw8rmf22RDOGVJpJive+VgWJgCoouiUaqKsh9LvGgP6cHqLJy2SOQqKfp7vo=
Received: from CY8PR11MB7393.namprd11.prod.outlook.com (2603:10b6:930:84::18)
 by BN9PR11MB5558.namprd11.prod.outlook.com (2603:10b6:408:103::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.22; Fri, 21 Apr
 2023 18:10:20 +0000
Received: from CY8PR11MB7393.namprd11.prod.outlook.com
 ([fe80::120a:e19e:e1d9:4711]) by CY8PR11MB7393.namprd11.prod.outlook.com
 ([fe80::120a:e19e:e1d9:4711%5]) with mapi id 15.20.6319.022; Fri, 21 Apr 2023
 18:10:20 +0000
From:   <Amisha.Patel@microchip.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <Ajay.Kathat@microchip.com>, <Claudiu.Beznea@microchip.com>,
        <Amisha.Patel@microchip.com>
Subject: [PATCH v3] wifi: wilc1000: fix for absent RSN capabilities WFA
 testcase
Thread-Topic: [PATCH v3] wifi: wilc1000: fix for absent RSN capabilities WFA
 testcase
Thread-Index: AQHZdHyIZE4jvlc6AkW1D4oyyUR4PQ==
Date:   Fri, 21 Apr 2023 18:10:20 +0000
Message-ID: <20230421181005.4865-1-amisha.patel@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR11MB7393:EE_|BN9PR11MB5558:EE_
x-ms-office365-filtering-correlation-id: 517584ba-01c3-407b-bfa9-08db4293ab0b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 82JkiCg7dByBBZb4PFwXvEuzCyga7TDb5Y3fjkYo/GYioEqrYVuEwNXr9uz6x7Bb8E4xil00hBsFfkhEsYBEZQg8tuTqnfxlSgJhoMTiDQaPuWHtY5JHnF4vIgnqKHz85f0aNcvtlsPGsjQUqc94srQsCKHUtZgxeLZzEgROZ27iBzX58xXYFcZ3+doh9s3BRcD2FPzHqj0AFK+ctORUXMy/StIGY3pTbkgQyU6jJ2zMtXfQgbTHuhfyWowI71Gw/2fOLFSB2OvIxNV7t3Al/Io5Depn8FnwAl0IQ4K9/RGpOZ4l1Hx/iZTLWek4urzEvUSssvzXG5fXmqHFKJzYVUIs4uuI2+mS4LVonhGiumkXJUIBXyKHRjTIZGN9uSvL8qjihwjOVrfK/i/fatMAn4C9WShxS9KKF8qZbdaBRJ05BjShotmt4Mw3yrn6aveERe0iNgYZ/wXzg2H8P64H74pdpEpi4q+AUqeSW9DJQIB/OWABFepHLOMzbXxUIKNxePr+JtnoyIxC3BMDl6EmhFq9ccahHkeQQ4xnwv9YvvDRnexMXIO8Hwb6CmUwBr0VLsxjoQL15kF4RmnnjmamkcVrFyiTrujseMTsgUbekz7QRRYLluurYvwF5usS6iNi
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7393.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(396003)(346002)(376002)(366004)(39860400002)(451199021)(38070700005)(8936002)(2906002)(38100700002)(8676002)(5660300002)(36756003)(86362001)(6506007)(6486002)(71200400001)(6512007)(107886003)(26005)(1076003)(54906003)(2616005)(83380400001)(478600001)(4326008)(186003)(316002)(6916009)(66556008)(66446008)(64756008)(91956017)(76116006)(66476007)(66946007)(122000001)(41300700001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?k0yUkBklm0U9dadfiEjUOF+L15MhrTnIhq8feGPZ15s3LsyN1zxPVpsRg9?=
 =?iso-8859-1?Q?vYFiXenGNIpLkeDkyTCDuRuOP9CPKoM+DzE8AdqsZDWU5w0C5vhtV2TP/T?=
 =?iso-8859-1?Q?oMplV7jZLDenPbNmztlT764xoJyhiUyOHIMMUWM46MxrXIuTBV7ojuK04J?=
 =?iso-8859-1?Q?C2h11OqHnu9rtx8YuDNWCJnIL66Cx2TVxHxc6/DEM5QDGmIsMg/OanHwVp?=
 =?iso-8859-1?Q?BSK28TrQsYZTi85f4JZmGgEi8yXgCiyApbMec+kp/an+KvLPCq/A3BcXmP?=
 =?iso-8859-1?Q?aAcjxCXOvn2rqx+iA5Y6ngyyBIvGAlP9Ma7Ca7l8BHhCzmvfwSJQEgn/U/?=
 =?iso-8859-1?Q?46mOcK4Toyc0Rb/3eWVZvbOs2Feo1sS2oqnq9xJc1UZwf0XxB1qye9bgLl?=
 =?iso-8859-1?Q?Ua4y4rJe9jLAyJjVDFhFNJhwehI70PLGgHl8m4txFokoO2oZzmuY1Vv9Cq?=
 =?iso-8859-1?Q?/urOxSB/to80E1674QoZyrBEs5cemUjhT6jEa6EJvtLnvH6ftMDaZkz8cE?=
 =?iso-8859-1?Q?29tGX123BAZo2yCen9/ucirAzhfYz7WvoO79TZ2NQ3zkJTLrIU+WX/dKzZ?=
 =?iso-8859-1?Q?qnaz6FclOIflBpqfRIkxfi2St0vJQcfs5795nWtio2fCRRsZEJCuNP0di+?=
 =?iso-8859-1?Q?uy0nk9/8dAA8Hlgz4PlIY+zdsSRxwV6xXwZXyi5xTBY9jzabQzfmFFEXea?=
 =?iso-8859-1?Q?rSjQMGTxB2NxYoIz7S1D67TAdQvkDn8HU7VmrGOshLzHTM1J+VzUxHJLu2?=
 =?iso-8859-1?Q?ZrXA+NmHxxte7vZw9diYXZf1LS+1Xc4lXRLWJ25ROLLg264buXLyo1hjJ8?=
 =?iso-8859-1?Q?TC+Zx9oV9DT429Im25DMhuD5Mo6L6zXTfRIHUZDWIsKG/79DHqGTx6C/MY?=
 =?iso-8859-1?Q?d4lfWwyvg2tF9GrVQYIqOlUChtxa9MfEplnfBIgY8o3TaR0ydV+pLVgyCo?=
 =?iso-8859-1?Q?Pu9HZI0aJgKrMLNOViC1sAh2mtVxSLuSGfXn4uKAwHNc0KCTVgCn7hiGiB?=
 =?iso-8859-1?Q?W+X+lkT2rjYwGap64lrZSwrlmMDPZCSESfaYy+EZ0lo2NUd+E/3SDCgouh?=
 =?iso-8859-1?Q?sIF7Sn/ZVMqlrEY4kHn/9/8SO2N04DTtP2pmmZipTfTWlyg36XDd3dAtsE?=
 =?iso-8859-1?Q?t78LuVyOgPgoD51sCSGJkN1mz3luM9I1MwZPxfhPua+LvXI1zNg6kLxlsL?=
 =?iso-8859-1?Q?YGPRDLo+PDIWS+KYZFvIxnzC9Pd3dJ3uwKV0nxhbcQ5rrb/+Yj/unLMWtr?=
 =?iso-8859-1?Q?Woyg6c9pbJ/30qL1mn1fLAM/+hZ3lz4MBdpd49gMo23HGgdmASHylUmVkr?=
 =?iso-8859-1?Q?NY+dGATh+0qkZpNfOmBV3s9+nQ2xsMiFkhgp2uLxG8BC62o5S4RMGuEMkg?=
 =?iso-8859-1?Q?N0HQW9jIexk8OqovLNpCReVAz2SbBGaxaCPXwrxA48AVJIqOViivRyyNa/?=
 =?iso-8859-1?Q?kLQhW3QWCGKKWjBsE/yiHFNR5QhHQdjl8aM+SBnYpZbC3ebb6soMYmxSb2?=
 =?iso-8859-1?Q?pabZwPueQisfXdcXb+KHnz6StzSGxDssSchcMvDkvvuD5eCckqaBhIVYhp?=
 =?iso-8859-1?Q?pqA47gwq09ozefCvdX866oTlRMdHSX8pivaXkJglnMhGMhGcEDvNt9hIV3?=
 =?iso-8859-1?Q?FWRZtYeFkxP/hvptjJ8m9f9PbK6L2UszSWrgN+BM6hx2EJ+CR+TX7VNA?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7393.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 517584ba-01c3-407b-bfa9-08db4293ab0b
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2023 18:10:20.0304
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: juwh9FLjafqHBXHL+UZuyFmI1BTZfoesB064v8MOYnGTxb6vAPo6Mvt/XoL+Tngrjpeb1f9O06gsV2QgyHllexwneR2zeJusFIa9gfy1f38=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5558
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Amisha Patel <amisha.patel@microchip.com>

Mandatory WFA testcase
CT_Security_WPA2Personal_STA_RSNEBoundsVerification-AbsentRSNCap,
performs bounds verfication on Beacon and/or Probe response frames. It
failed and observed the reason to be absence of cipher suite and AKM
suite in RSN information. To fix this, enable the RSN flag before extractin=
g RSN
capabilities.

Fixes: cd21d99e595e :"wifi: wilc1000: validate pairwise and authentication =
suite offsets")
Signed-off-by: Amisha Patel <amisha.patel@microchip.com>
---
v3 - fixed From field as per review

v2 - modified commit log based on review
---
 drivers/net/wireless/microchip/wilc1000/hif.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/microchip/wilc1000/hif.c b/drivers/net/wi=
reless/microchip/wilc1000/hif.c
index 5adc69d5bcae..a28da5938481 100644
--- a/drivers/net/wireless/microchip/wilc1000/hif.c
+++ b/drivers/net/wireless/microchip/wilc1000/hif.c
@@ -485,6 +485,9 @@ void *wilc_parse_join_bss_param(struct cfg80211_bss *bs=
s,
 		int rsn_ie_len =3D sizeof(struct element) + rsn_ie[1];
 		int offset =3D 8;
=20
+		param->mode_802_11i =3D 2;
+		param->rsn_found =3D true;
+
 		/* extract RSN capabilities */
 		if (offset < rsn_ie_len) {
 			/* skip over pairwise suites */
@@ -494,11 +497,8 @@ void *wilc_parse_join_bss_param(struct cfg80211_bss *b=
ss,
 				/* skip over authentication suites */
 				offset +=3D (rsn_ie[offset] * 4) + 2;
=20
-				if (offset + 1 < rsn_ie_len) {
-					param->mode_802_11i =3D 2;
-					param->rsn_found =3D true;
+				if (offset + 1 < rsn_ie_len)
 					memcpy(param->rsn_cap, &rsn_ie[offset], 2);
-				}
 			}
 		}
 	}
--=20
2.25.1
