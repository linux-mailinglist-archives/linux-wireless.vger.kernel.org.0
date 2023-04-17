Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C20B66E505A
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Apr 2023 20:42:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbjDQSmW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 17 Apr 2023 14:42:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjDQSmV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 17 Apr 2023 14:42:21 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB44E26B8
        for <linux-wireless@vger.kernel.org>; Mon, 17 Apr 2023 11:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1681756936; x=1713292936;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=g7P4kBfXhsouXa5mghOc0gz4owa8Ez+VPMK7PstBzKM=;
  b=115r2eB3e8eSIpoa50grnnusdLIu/1dszQHcYyyPtdS/oO7Zex2Q7Lyh
   hcONdNSv+qse/H6DREGVm57dM6Q4GZ2NYvuJiqAaV3fLJUiX0TltuFgOI
   SDwjP7pI2naxxaUDEhBJTXNUSOLwEsoZeKVi4BoE+XsRXS7kCU5TIErDR
   wY4a2bdJ1vVpX4NzvgnkUuixs+EM698dOicZ7hlVcR2zs5G07Li69Bg2q
   l/4fLy79FzkarUDTfQ5x2xsaM1xrNuB/vx6FmTSgEofLtG5qcXnElnxv9
   983BtXFA+F7kKkyL7tfUHbB8vpAZoZvgPSRuXtbLghBPggUflz+vGE5Wn
   g==;
X-IronPort-AV: E=Sophos;i="5.99,204,1677567600"; 
   d="scan'208";a="147474686"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 17 Apr 2023 11:42:16 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 17 Apr 2023 11:42:15 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Mon, 17 Apr 2023 11:42:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PeSpBI+0LjUUo+8tk1mWWXPEvY+9d4iPoKlYFLK9gvO46zLopWEJvBCtfeBp13mZJSugsTwRZ1Puwa/M6+HpANWPYYq7NiJZpYkNqvuP5msXMo0hVLJVboHhWc6T4sYgs5nWf1wA9EZPxxGbtTsu2W4LeprP/IFVo/4vhKSvHi4fWtfX1xaWDi1Oldjz+eNZWeRWOEgx5FLjj3IVTjdeUtcfmJlRTRl6Zecu3ntWf4gZV5qOp82w5UVe2bLmsmrKQUZUhG3j/wHo2WkKKvyBblvYgFcZRpkjGImJ204I2jVGEXLaGD95uX98b3iOjz7u3CUxUa8BoFaTj07vRE7PuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FLEtGoWIkOmCjwlJYSRuLk+1SRJgZSGa6QrhPafhbjI=;
 b=Ud1olruSQQj0e5e3fCA8yD7igMFEGQns2e+oc1llAB2eeuB/xUvfL6h4PD9qJAdl+7Ek1KGYlEVDQcdZRmOv9dQBdqDd6/+eHJHJklC9PftUxLz0md/7dT9RY5u/Y+pTb6Lfz7UDs1Pl+YTWJcoIUBhbNWuDPO82eL6nfUY9nra5rTOvYoYWOKTVAV4xo8IV4Gyzf4ufU+FezBDRM+HpoiYwPViHsG5xYD357/1u/IDnvXxqo/J3tMqKVwXGLLvaadk+Yv75t26xVaPJWhLT4Kdh3ZF8nMCw5B90VA4LN8qrnGHtt83rvcBO4M12ZCyNxkU68Xy3TJUD6XqefqKtRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FLEtGoWIkOmCjwlJYSRuLk+1SRJgZSGa6QrhPafhbjI=;
 b=DNtURd4fwCb6UUg1h1RLrlTizy2vH1AMEY9VWJpn1TPWVhAtsKPyjtE8E1S1nCbqtxidk59wMppVd1SgZBkK6njQBMfC1e5klHJwGqs1vgS9shXiiZodoglq/ulE+uiWcOzc41dTJAmHcS3mERD08qKCroKnrYiPRVQAvccSEYE=
Received: from CY8PR11MB7393.namprd11.prod.outlook.com (2603:10b6:930:84::18)
 by PH0PR11MB5879.namprd11.prod.outlook.com (2603:10b6:510:142::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Mon, 17 Apr
 2023 18:42:13 +0000
Received: from CY8PR11MB7393.namprd11.prod.outlook.com
 ([fe80::120a:e19e:e1d9:4711]) by CY8PR11MB7393.namprd11.prod.outlook.com
 ([fe80::120a:e19e:e1d9:4711%5]) with mapi id 15.20.6298.030; Mon, 17 Apr 2023
 18:42:13 +0000
From:   <Amisha.Patel@microchip.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <Ajay.Kathat@microchip.com>, <Claudiu.Beznea@microchip.com>,
        <Amisha.Patel@microchip.com>
Subject: [PATCH v2] wifi: wilc1000: fix for absent RSN capabilities WFA
 testcase
Thread-Topic: [PATCH v2] wifi: wilc1000: fix for absent RSN capabilities WFA
 testcase
Thread-Index: AQHZcVxTbYUBq6/w3kmQK+MqPhbi/g==
Date:   Mon, 17 Apr 2023 18:42:12 +0000
Message-ID: <20230417184145.12593-1-amisha.patel@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR11MB7393:EE_|PH0PR11MB5879:EE_
x-ms-office365-filtering-correlation-id: a7c1141d-b1c3-4f6b-b32e-08db3f73759e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cxWYW92s1g0aRhKn9UoH616H5Dm8bQjtxh7JqDCUR+eJoZRIU7VgjCYsBWlnlnPlEa7r0FLtOhN/T+cGjR72C90gwe71WBlQ63NnZQVSBnZLL0hUxO3p+VhNbHd/PMRdyuoHbg1Bg9BI9egWPJ0YESzY8nzOCErKQKo3nLRIEGGxhmkT9M1vlJJOdL/KYuhhQdycC2uYV57N8/bDZrn4h0IK/9+e1C+Rj5uLWXAMSlDAFP+FTPjedoYMQ10EEyZmDdtSFzeejG24sFsZxpNFz5pPU+VAUs4szqgH5i8bpkmOzbme1Uf3p61pz3PNwKTA1eIDTWX2cjkz5MoRuJ/mNY7tDBVNMTHhLBHaA2GSRD+RL7OTQtgt1/IugcVap4dgM73ufGPH2JJCnfQdN4UNFw1GLji5/igrQXTBHZRQVfcxFPUFRGDgtypBDZCs8MlSsvbWz8P49zUOgFmgOU9bYopw86DEBSs4B8nrNCfKuvjkSSkprOcHCn+7Sf8qossVf3GOcmJMpuKqZjc6wVAj0jOz/4SOpccV2zaidFKCtpiePo7nO+0kn7Pg9vr8N3XJ9MK22PCVUz2B109aa3wNouWFM6x+x/PlRqf7zITNg1sIwHB4FuxoKmRT1FpFeTFo
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7393.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(136003)(396003)(39860400002)(366004)(376002)(451199021)(5660300002)(71200400001)(6486002)(76116006)(6916009)(66476007)(66556008)(2906002)(4326008)(66946007)(66446008)(36756003)(64756008)(91956017)(86362001)(8936002)(38070700005)(122000001)(41300700001)(38100700002)(478600001)(316002)(8676002)(54906003)(6506007)(6512007)(26005)(1076003)(2616005)(107886003)(186003)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?TYRmegDHTL8hxw1lPiIl6lZElckYoGX9l7bJz9CpX20bK61B8RZrW3iSYx?=
 =?iso-8859-1?Q?t1ILSUbKXtngue1jKc4bxDhInelU4DxQJNCY8RcyQcszO0slzkGhQzN4qd?=
 =?iso-8859-1?Q?Fp2d0nPQyItUQaJD9cK4zqYIwJ4N2PNDXjVnY1TOWPtuLqZGwzWL8L5lIO?=
 =?iso-8859-1?Q?DW1Bz8qxO2EcTWc+yFupvxl8QZI2uZF9RynTKblR0pNEbhQiZ9CKRHUZXe?=
 =?iso-8859-1?Q?UBPZl0zcD5DRNFamWwTafPzqswcmxjqse+B6RzUGe4isG/Es6MfQH9z/gE?=
 =?iso-8859-1?Q?UKXYf15IDFe87T+wkU2BCCtbaqejtDKAHjUdt4DjYHldYSfubz90mj7Ixd?=
 =?iso-8859-1?Q?mw2NIFrNmwYgrjJXKV+lg1AQz6aKHjdKe4ZgxjQd/vsty9yfJSsvQOLmis?=
 =?iso-8859-1?Q?lQ/yM6WK54cgXw4+AG+7ol97yYO8TGGAMfch8ZZA6wfzuiuUisJCsV+h31?=
 =?iso-8859-1?Q?qnqqkxO1BKaWUpBrjP0uNamm5yKHubhzI4uH/nk4EjNpP6Aa463osImnqe?=
 =?iso-8859-1?Q?GKGtG2J8VaZ2aX0gJW7vCupDRrI70f5epQeCiDEshn9ERt5Kdr43gUR9gt?=
 =?iso-8859-1?Q?eTVahn5jqWOip6C7E4iniqmWqFG08NEE/89Qw4kVJHUBcxYFXzo5zVDe4M?=
 =?iso-8859-1?Q?bppc37nCUYto07R1xImpm/+6raVA/oOQ/DJ1GY7Y+TD+PRwZvlvDb4yxeH?=
 =?iso-8859-1?Q?31v5YspuKD1l3Y4q1W9TcMYhTwJr7edFTMzsa6iAViRfMuP5RuDKtB186k?=
 =?iso-8859-1?Q?acwdKvZuRXgL4mJfrmatPVYGocErQtZtGhOIO//1DHu0SwIi2ItjmRmjxX?=
 =?iso-8859-1?Q?FVYbH1osMRGZ9GtMW4tdIRdImiLFkVf1VVBHnCl8eixOWsCvFYgbOR2Ibw?=
 =?iso-8859-1?Q?T89NM2kMViMK34hl5qQ2Uw974SYrgW0qfeS3QwkGrmerq8Dc+xe2oBz1D4?=
 =?iso-8859-1?Q?HjwxQIOTON4U1MSxH2z88I4aLREjdnuT1qA2wCfW8Y2Ma8NqZVuUwEc7Cl?=
 =?iso-8859-1?Q?xr72tuqsmNteFJTaJ65qa4wla+O27fzKDC0AOi0uPsa8D549Th4Exhob9d?=
 =?iso-8859-1?Q?0zFl2QKTjyTPl2KbDUNMGrcWy2dEfUjKeheK2nvrNTKrmhhyEsbyCQHChi?=
 =?iso-8859-1?Q?0ni2cWdIj0l2XpFPk7bfmbfNNksGDaw2UOcBRwfeU8iFRX0DqjU1cIBeEj?=
 =?iso-8859-1?Q?EB3Bd4CYLLYgHINBdib8y+2/3yF/Si/L96f9UANY8o/sUS/cE3zmS6iKyh?=
 =?iso-8859-1?Q?aIyGQJkndmdz1r0Z0d5f/Qy7sj/enzcaVqJfZLp0pyniGVmrbjsVAN//O8?=
 =?iso-8859-1?Q?PY/n1VGdsH+y4KdT3W7xKf2WQvNO0SrEVjkb0PfzieKr46vp/zSFt8Z5J+?=
 =?iso-8859-1?Q?vehGEOhqWNIRFZoKP3mJed1XgTA5CLPeU1KI2/gdDEFRo7zvAWgyTz24aD?=
 =?iso-8859-1?Q?OJ4QfQxMCnA33ITpeIPqQtJHdUL4VHgm0iV6AfwOiKGae0vVJNa8qDMOQb?=
 =?iso-8859-1?Q?TZprzDnXHHT59FNZJxCV2+LxlQC2bvYDyzObaJ53qS7/y4HhwA7zRwDec1?=
 =?iso-8859-1?Q?x5OxX0+5hoyXlDzGpt6XpbWxYyzLwmXVvTmecFNgeUeiMRn5RNH9jE6YYg?=
 =?iso-8859-1?Q?lRNDlfe9fDLFyeLfVr8OeGAiVi00VcLmc9vPXavbEmGdkdKIP04u4n/w?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7393.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7c1141d-b1c3-4f6b-b32e-08db3f73759e
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2023 18:42:12.9727
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o8Sts2t9+Eb/RkBURBB3JXOLJiZp/aDZ5KoFlmRbyUP0zn94h0M8cZDvwyy9mRPsSqOwfz801xqbd8EW6W5T8jzX20uakf5kwVp6Tv16Pqs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5879
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Mandatory WFA testcase
CT_Security_WPA2Personal_STA_RSNEBoundsVerification-AbsentRSNCap,
performs bounds verfication on Beacon and/or Probe response frames. It
failed and observed the reason to be absence of cipher suite and AKM
suite in RSN information. To fix this, enable the RSN flag before extractin=
g RSN
capabilities.

Fixes: cd21d99e595e ("wifi: wilc1000: validate pairwise and authentication =
suite offsets")
Signed-off-by: Amisha Patel <amisha.patel@microchip.com>
---
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
