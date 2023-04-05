Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2185F6D8501
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Apr 2023 19:37:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232198AbjDERh3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 5 Apr 2023 13:37:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjDERh2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 5 Apr 2023 13:37:28 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B923F5FD7
        for <linux-wireless@vger.kernel.org>; Wed,  5 Apr 2023 10:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1680716246; x=1712252246;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=pcAWzb8+DHUNUhM5+ejSsJhown16tholpX5/ayK/yVs=;
  b=J103mj9lYJ9l2BgnCItvmInRs0uva6DmRWjWNDKFPdEecTNBZbQEAmK+
   0Pjp9Ai1QbeA1P9+5MMa0tPKKbMIOW2AWe8tptj8ZseCbqFMI64O4eZv0
   NjIih/qwnw0eHP0s1LgyGwn2B7a4XUiYWRl0t3fyWOdm9pQccN2YKqtZO
   3dol9mYKIkVScPGazi+Sy98Jx694zPHP37ZwxivnRPFSolM7WxaDyt7kr
   yqpgm9RtlzEgvPyROkGMWJZHXkRw8K3wD0hYzpj0ynJ1YqyHTBgr9UgTD
   EZQf/vOPP4hHjBWzOr3V+S3XPKluy/Ruh5aUbmGS5omHhGL5p+UeCcUUJ
   Q==;
X-IronPort-AV: E=Sophos;i="5.98,321,1673938800"; 
   d="scan'208";a="205177550"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 05 Apr 2023 10:37:25 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 5 Apr 2023 10:37:20 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Wed, 5 Apr 2023 10:37:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kCtWsapQfHG9RtjawHLfVWD5btRwsJ4XhDp33nkWDj4DtMNwAyzWo76jnpoGS3YkVzsjtD1JA9Nuldd2VULBMlM/SMDe+QyKjQvSZYe7i+BBvRbT4xa2kIo9t2bpx8ZtnPnPwXMtpGz/Zwp2Sw/9/xfPrGpKagjYPBm5crY2fJilyBRhnDmkjb6/whFBnO9uTukQFHNv1tDf/z2QlbJ7EtT3k6xB6uWQRd5iXqGncqrCnVPRFXu4m3kY6cLMpYJaQQhXnGQmyV58R4okr9l8Zq5lUuCEQMYA91fPIpwuqGVgvnOYfbXYq6xIntg1UegmwT4CVCby6b5K/pY7Bfsuag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4H0BRHJQyF1DX12PUvruIPNWz4a88htmnhfoozgVCdo=;
 b=gwZ+lKn/92tTEm8cdBMkRzTDyTNxTK5FSzdivx9UB7SKncS8ioZlKKMjI0nMvGD75A856Z8UgLK7kKpgWr1KAgXOOJKZ7X/Q006wBC8ZnW6pYGFMbpcTfYzAKj1KBaQDIDVM3VA72dDL2gRmTiSFIoee3NmEWj4oUCxPyhAXKlTDwdgT2YW7CrRB/YBEpTBhvaA3VR6GUoE5y1SikMVDMeRWLbtX9CZGoEsTB0Q2g/445C+EDHtYbhkQAfmbgnMzCyH4b2aUWsVzzGIE01ZCRQQw3XC6uN6sxzvBBcxljRFgGtZpKYKfUuPCtz8L6tFsBf4QVJiu401DsMN500OHPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4H0BRHJQyF1DX12PUvruIPNWz4a88htmnhfoozgVCdo=;
 b=dRZWRUJMTApIbYXndtYdW1+c9gybbfhTB/PUjFqlQw2uyoU1x+WvB4sfoL2mCIrXs6B9mw/eqnXeMNGXqxZU5TNHXb0/N6xlr6PiP2OHQlyD+wmxbJGNHr/Za0IMy0f3pdbFFzYcoFEjIgnbHe2gEPUY6uU8RZMkbQrixLZP1Lc=
Received: from CY8PR11MB7393.namprd11.prod.outlook.com (2603:10b6:930:84::18)
 by PH8PR11MB6562.namprd11.prod.outlook.com (2603:10b6:510:1c1::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.28; Wed, 5 Apr
 2023 17:37:19 +0000
Received: from CY8PR11MB7393.namprd11.prod.outlook.com
 ([fe80::120a:e19e:e1d9:4711]) by CY8PR11MB7393.namprd11.prod.outlook.com
 ([fe80::120a:e19e:e1d9:4711%5]) with mapi id 15.20.6277.030; Wed, 5 Apr 2023
 17:37:18 +0000
From:   <Amisha.Patel@microchip.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <Ajay.Kathat@microchip.com>, <Claudiu.Beznea@microchip.com>,
        <Amisha.Patel@microchip.com>
Subject: [PATCH] wifi: wilc1000: fix for absent RSN capabilities WFA testcase
Thread-Topic: [PATCH] wifi: wilc1000: fix for absent RSN capabilities WFA
 testcase
Thread-Index: AQHZZ+VFaoRux7AH/kad9DveyKpmhA==
Date:   Wed, 5 Apr 2023 17:37:18 +0000
Message-ID: <20230405173555.6041-1-amisha.patel@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR11MB7393:EE_|PH8PR11MB6562:EE_
x-ms-office365-filtering-correlation-id: 2e627c10-5046-4e0f-1b6e-08db35fc6790
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5nroRymC3okGDpCQSDgxOYFotAVe50MVOxo3BfPt6BIiA2nVJUKdr7azZPgNDh5Nq2Q/vXnvMbaCFudFFuTW0EDyxD/1pA9p/FdasF5Hk7wN6QA/x9ZzI4HzFS4rH3mv1j5bN1062PoZcoOkJNJ/uAgyWU5Fyzd+yHSz/KNqjIbnk+loiDq3SlVgjdY1mYB0UPEvq0nlr37h9atS4BicXmJUdJ1IPRgZaFmYwEBfYfUlcvITPZcEhhxK7MuM6FCRkZeREVE7qP9ax7WiMrrsPvxje+LzyRUYUFlrWTs/Ma4ETbOvdNO529J0wxdCbLQ4R+G9v1vIN24JsIfjLgHjA3cBnCZRQPAYU9ko+0ODDx46hhoGttkEKS/hgu4sf9zoFYVDZk2bdjzn+TgnQTpLyrNeCuWCMzTu6IzfyERQM8WYtdzH0v/ZgSqdNvT1gE7YTnZWRMAMLhsiGP+J6dXi5ZwycnWhRcM3lhAXJxge6+NwAXck4k46b9V+O10gLjMSe496axO+tujy9saQg+SLJCxJ3KxqDSfGPNNul0MMtDYmfl2GMAX8JQjmFWwvS2BGKv6U0I52XzAca5C43mQLm1qVsI0DWMMUVVq3udAVK/it47J4+Y+7bQkS0zX3LzbE
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7393.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(39860400002)(346002)(136003)(366004)(396003)(451199021)(36756003)(6916009)(54906003)(66556008)(8676002)(316002)(64756008)(66446008)(6486002)(76116006)(66946007)(91956017)(66476007)(71200400001)(5660300002)(478600001)(41300700001)(2906002)(8936002)(86362001)(38070700005)(2616005)(186003)(83380400001)(6506007)(122000001)(38100700002)(107886003)(4326008)(6512007)(1076003)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?KszqwVKqLvytEjlbxdo+tc2cp/j1MzrNzBckQfS2Phbbr+Cmc2cBAOnlDY?=
 =?iso-8859-1?Q?tkhvg2ZefLiSy8snpf1+ivl1jTs5ariWytzWXfxg6obD2NRfM2W3ZFNTy6?=
 =?iso-8859-1?Q?24KUIopdyGpKp7ayb+XD9O9QgpsG8fDV5WBZXo+dmTfdfyUY7Uii+Uy3kb?=
 =?iso-8859-1?Q?SqO6srxLncAremQxwph/qT7N3GN05h56itQ51nEiRckX5ER2Wr6ucBc5DX?=
 =?iso-8859-1?Q?TeYIQH3lIgzf+TWeuhe7GbA83oR31IHbgqSVBigEVvxoMfH4mpcuv2RM6x?=
 =?iso-8859-1?Q?Dg3XDdfAsEgv/9X9ug+u9GdN2by1Hw6A+BotoOKCGZUaCA4RMkEewO+ann?=
 =?iso-8859-1?Q?KO9ReemPIYD/1rb43XDDW0fBGa44V98oW9a642DJsbc0AFCPXV713WY47j?=
 =?iso-8859-1?Q?laxweLrahRlWurc9xzsgg1GMVoh6z9VMMBr3wN9zlRqIwBCP8+pbr6MDZc?=
 =?iso-8859-1?Q?+PfX8vGlaA0Z45HUiny/a0uzZOtZXCAnJvmxiqLVlG3og+6VzCazlBd/jt?=
 =?iso-8859-1?Q?lISpK25bjjxYPXYj+/mbxmFO/AYeqIFb3IhC0/DhjxPrXQtnestfgLzFu5?=
 =?iso-8859-1?Q?AkgRPNUhXFUhu+UwxClY004BFZ3+9tHN0lzdwqOR6Gtb0NdL/lGfAOPPNA?=
 =?iso-8859-1?Q?2LA0TLvUIPKWEGlcVMXOznT9E5YKg62rwE96w346Xom7JiFQyfK4Hy7V67?=
 =?iso-8859-1?Q?i1EQ2pVY5NeU2Y2hALeDyUOuUMSZVk78v0lb+HS+ZVKGws60uQwIsiKeTD?=
 =?iso-8859-1?Q?6ILfvudxiGvExaBbWtEl70c2baO/T7Z8stwDaEM0SJRDKZvJgGBitHkUjI?=
 =?iso-8859-1?Q?xCDtYCQoTIN6g7/gdCyrF73aE9tkfoO7SpwUwln1TlGfgCp7b6wjxJKw9e?=
 =?iso-8859-1?Q?fGrdHoz7vgPaPN76Xhf9R5owbE66LYSEi+WLPZ5VdvFOHyeGK5a8ifsR2M?=
 =?iso-8859-1?Q?a5H/8jOPAqHxP6asVwGJlN8QwCU9TnUubA8AwilAUBgtr/rhO6RIT7U20p?=
 =?iso-8859-1?Q?I8NgAthcRZmGssRYNxboAgrBDiPJJZaE8vMa73yNPRxLLMv8ihqy5T91V4?=
 =?iso-8859-1?Q?XDqTVSnezh3YfRAz2TQCmSrITtv0QwXdvTF6uaYxnToHG6m6Vh6HJJcozc?=
 =?iso-8859-1?Q?lNdwTLA/CKaV/+BhWoSai+bZ1Ok6m/0aZWGXdHIDdl0M+Dp8mcakPhC26X?=
 =?iso-8859-1?Q?do4B0F8AKi6NASd8C2chojfE0/f4M2MrGmU72UoZHVL7fic3M1P7pA3WpR?=
 =?iso-8859-1?Q?3jspVSllpj8YRwO6KPDyvLKYRp5eJzb0lHYmZEG9dpaxYDyWKEKU01229O?=
 =?iso-8859-1?Q?u1Pw1LQsOirsk+Ptd1JnKI0IpMjBFjicoDL+PkuW8yaA4MVe1pi8N2rhSJ?=
 =?iso-8859-1?Q?0F2mNCQmtsm3142rfH4rq7QJ9ZPicDFnMAAY8GpLsAWdOEtwlvKQlNHEuX?=
 =?iso-8859-1?Q?ByiC+DPxMfh+QEuXYXhSAelJSzuHAAoB3ZQsioQWU4aoGgPM1fdayubbcv?=
 =?iso-8859-1?Q?EXaUvcSOEvHYgoWvjWW2LEn3VBzi5ZCtUiAsKeEU3NmMszsI7Wz0hIN+mS?=
 =?iso-8859-1?Q?nF245k1lsR2vQoreoK0z5sBMnau1njkTwEIDWBTnbrMeOUfHPUrCmkhjFB?=
 =?iso-8859-1?Q?V+xknGNZfqc+5v+XqKWjl7O90YwZKtssXpomHvo/4jbIVoAJjvlpnX9w?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7393.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e627c10-5046-4e0f-1b6e-08db35fc6790
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Apr 2023 17:37:18.8151
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BWynWpASaBAx7UqrqARTdDiYGuNhtmFkDqs/7k0FvdOeRE/i4bBi1zCsXIBuzYBp/U7wv3urIYM9Z2e3GtrvYND2xb7oox74V7vIqD+HeGU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6562
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Enable the RSN flag to pass cipher suite and AMK information, even when
RSN capabilities field not present (as it's optional).

Fixes: cd21d99e595e ("wifi: wilc1000: validate pairwise and authentication =
suite offsets")
Signed-off-by: Amisha Patel <amisha.patel@microchip.com>
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
