Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACB6778D2B7
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Aug 2023 06:24:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238589AbjH3EYH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 30 Aug 2023 00:24:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239495AbjH3EYG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 30 Aug 2023 00:24:06 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C77171A3
        for <linux-wireless@vger.kernel.org>; Tue, 29 Aug 2023 21:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1693369444; x=1724905444;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=iBycOKn3hRcKTsJ+YGcvJKiPyFggPrIcYOGY/F8Nqgo=;
  b=FRMG62ryDtYz1p+Ns00Ra7UI5aVJGmqFveGG6iCmRSapqx62v8syFiWz
   NGB92qcmuur1ckPevbyFHoE4leNBbpSFs5jqfVdXvzJsnI+xSe+Lir81L
   uO9UL8I2aj7e3YwjadmkyzOKIJFZNet76zB4HGBWyC0k0R3W08K7GnM9D
   CsiIqJYY9am3DOY+/keNObiPGSwMd9RPkKzhHTD6lmgiU4CWxsMIE/l+4
   tXhgKgxWn+dZcjthD3zjTWCQ1UkSQmCqac+O5Lsl+1j7O3cT9FO13xtqr
   DlGtcgl5BDNhuLVX1z0ILjAM7HbG3M0YhV5qylVXS8/AJm8ACUv4aHl4Y
   g==;
X-IronPort-AV: E=Sophos;i="6.02,212,1688454000"; 
   d="scan'208";a="1969579"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 29 Aug 2023 21:24:03 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 29 Aug 2023 21:24:02 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Tue, 29 Aug 2023 21:24:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D7+/1rZHziFFx4sdm1hCb1W1FvVsH5i5xbjm7Q2niR0kk5tFZ7OxErdlpf4zTJR9IRYb0HNj8iQh+2qhy4j+vCqL7tCMxVbBbBM3g2/vFzt+38YkK50sOEoEXz0f8Nj/2ONMpTc8S8LE0GFctKtzm1XSrPv9sDDWMMaWNaoklPcj4GFK8+xPy7NunT6HyiE+AjUtbfCBtUyiybahF5Hggne2vtEolxU7012kQNpZ9AiEfPQpvCnDO6lMZ8U2LCXelX22iHUwXj7U+G0LNyOjebTAiSt13AMZeU2EmJCv3JFnjwmA9J4M16SweLMnnaKZsnHTFLTBgUCh3ZeqsrvZsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WdAcJ4IQIZqlv8SBAPTtSw1fwkzlnweBm1rw4Q0DBQg=;
 b=V/hwbEwbI8I9dwR9cVUWcmYolOgnqp0PWz/2DBjnvyz2jzvjfXcbJT/oSDJW/zakpweC4eXhQFc1AeCF77xT36sYhRwCL+XBumSb2xFjSc1S0BFLz1ekuMpokhhjTZjwHBy7PpXASPpfchCNfzWvxPhGvDOdZyQmV2HCLAZE/MLbsnikXpqoat2d+jaTXvMB7f19H8lFZBuwOdS5ONmNd86SS8VNXdOtaIm+H1dFPI0VsrK7MhdqZKq37oV/s1ani1j3fBWE6xIQx9ruoEd/HaVWhcSiQsdQ3mU+8N8iYF0fV0r2+gTAEIrTNTJhOi2nMCB+T4/CP9xtIgVpZzGffQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WdAcJ4IQIZqlv8SBAPTtSw1fwkzlnweBm1rw4Q0DBQg=;
 b=lSKHRfOV72RhKdHOQVlcV4Pv7TXHtV7vbgxDX2HD3y4CeUo33wmVXXgvxzynyw1fmlWAHbeVQKMlQjRf2ZIk5gdshWjKJ46GbkWnXBsFcD+gtBi8iSvkoo87fdQBebLLvdHWII9Jr6AcNtNxw0jEfGJBVveFD7efQs5DYThtqS0=
Received: from PH0PR11MB5176.namprd11.prod.outlook.com (2603:10b6:510:3f::5)
 by PH8PR11MB6611.namprd11.prod.outlook.com (2603:10b6:510:1ce::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.35; Wed, 30 Aug
 2023 04:24:00 +0000
Received: from PH0PR11MB5176.namprd11.prod.outlook.com
 ([fe80::360d:b35b:51e7:f5af]) by PH0PR11MB5176.namprd11.prod.outlook.com
 ([fe80::360d:b35b:51e7:f5af%3]) with mapi id 15.20.6699.035; Wed, 30 Aug 2023
 04:24:00 +0000
From:   <Ajay.Kathat@microchip.com>
To:     <linux-wireless@vger.kernel.org>, <kvalo@kernel.org>
CC:     <claudiu.beznea@microchip.com>, <Ajay.Kathat@microchip.com>,
        <lkp@intel.com>
Subject: [PATCH] wifi: wilc1000: fix sparse incorrect type in assignment
 warning
Thread-Topic: [PATCH] wifi: wilc1000: fix sparse incorrect type in assignment
 warning
Thread-Index: AQHZ2vnNhR7lbjYFek6Ct9UYC+kHDA==
Date:   Wed, 30 Aug 2023 04:24:00 +0000
Message-ID: <20230830042300.87184-1-ajay.kathat@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5176:EE_|PH8PR11MB6611:EE_
x-ms-office365-filtering-correlation-id: d9e4450f-0606-492f-87e1-08dba910efa4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Sd6njsJMsYCcthYA3uLGZ8F7QCWU6Xaw9IgJOuCFMeYvLLNWzbL7632Gmlty25X1XZ8MdLjUWG6r+bNNWdUDBCpIvZfKffRy/vd/qTRkxkn34vD/eYhMP79deSchJFUDIVOtxDvfqEkQj348jDG013P0h7zOOypj2hcNOzX6ydkTxmwO3LahuOOzJSst6MwUuqT2rnMq6H+GYAyO1Q8VCmCmKzQvSKCPH83SlVhp9UxivivqA8oUHhXglxJFL/3G2tDz6Tj9TiWeoZ7+Uw3m+ca6gQsFSNUaciwnv4TCEV6aOt9ZkyY6vWa2XnneclMf+zathfKc0qhlJ5hhlJr4eBolBpHGvWWKy0gFQrokpYU+kDl/SnpbM3V0/34b4447RyI5lPJDwh0KP5ZEJOzX0P6G2wwKs15TuaSM93HsSFUBKvB1uvk4cg4kjLA44RyjLfQJmC2mEQc7VYd0dihG6hBsvweOG1UccdrNEvNmMIC5Lwj53oO3ZqoiO4GXTkZ5JkwQs7TUPYXZBfPl6KIwj7RXKPkpx5HnhuLrXqrvpsckNKU9WIfipgbsTa9zEn41jMyseajyH+Ovyn+ixvNoBNilILDoP1tPOONMnxoj6E4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5176.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(376002)(396003)(346002)(39860400002)(186009)(1800799009)(451199024)(8936002)(122000001)(66946007)(76116006)(478600001)(110136005)(6506007)(71200400001)(66556008)(66476007)(64756008)(54906003)(6486002)(966005)(66446008)(316002)(38100700002)(38070700005)(41300700001)(6512007)(5660300002)(8676002)(36756003)(26005)(1076003)(83380400001)(2906002)(2616005)(86362001)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?3CKHdCz+CUuXSInWTpGyor9w+tBTTSGb+ve3DA12Y6tgTR6P/eGRryUWdF?=
 =?iso-8859-1?Q?ujfpFr3VgjbgfZIwglHz6QS4mYVT4Pr0kFiJsz5uL12AenOGLzYIZ2roty?=
 =?iso-8859-1?Q?sMnYl1EHB3Fyiqm4wMNyZv1udsOJWJRXX7p9yNYwCPKXDs/le4foGgzSZ6?=
 =?iso-8859-1?Q?hFGeZ+sz4u1mitqc7JULF1k8EXVkI/CgwDCK9dXGr8tpnv9Ye0BadiS2l5?=
 =?iso-8859-1?Q?AqZVWVgNCUxtx5tVcEEYjq7eTsAhIfPX1VecX8KkEfcroskLY94h/DzCvy?=
 =?iso-8859-1?Q?cq57Vut7Hvk6Stcx/B5W0UdX6eOg96mVV9I62bw2v0ot35mmsomMNd6vQQ?=
 =?iso-8859-1?Q?sO4HS724Ip6g/YIdFyDUO07/2Cwsmc57Lv0iY3nKTQKR+PHSPaJpScU30k?=
 =?iso-8859-1?Q?B2Igi1sVpYXLpPe0zEXBBfXANOIgMSxH7RD0vfJAGb5dkBx+UwDf2iG28C?=
 =?iso-8859-1?Q?Tw7+PXDUD12NUWFM4BpX2md2+zHMY2XtnMo+76NHIXTtKNYkNrSMQT+e9Z?=
 =?iso-8859-1?Q?UC7X1PIyY6FBMCabzQdrfRxJwwGgCDEPbNQmkReQotuV79y3iV91RSvaf9?=
 =?iso-8859-1?Q?ajZVF399gyPzjPkOBHO7HKqaKDLSNPbkpxMf/8XTf6jZ8uBA2PWVU3p7fs?=
 =?iso-8859-1?Q?V81Ds5Pu7DKd4yqktbEQsb3GV05L8EJ1S5w7q/IKs1sAL4nfBK8jSPfNLV?=
 =?iso-8859-1?Q?zI8tFM02FtdJIgMJ5NcYjAXXzYmW5N9jYOrGeIV+F1GHY7ZD+g7CLoMv1r?=
 =?iso-8859-1?Q?IGXusCWyADqkcsk8WqJ/SXC/10dJiQYQkhGP9Cor7NojAd3a+QySOMsWVe?=
 =?iso-8859-1?Q?ZCndw21i+uekGjIGZ0Yft/DBnL0YeqRM2nzdmWqdlTMur0J5egOzauqNcL?=
 =?iso-8859-1?Q?NOyuZ9S9ugBuxEGY6yO94u3jYxnvVVHwjA9G5cydlP9Ryrg8foKX1AzgQE?=
 =?iso-8859-1?Q?KGa5UVJCQSosc/vxt0LR/Z8JLQNMUS8+cFS1GHJnIQyvpSvsBwC5h8gpBm?=
 =?iso-8859-1?Q?7RCnKSsdwOI1vGuh9UBLaRr3Ty9ekzniinVmtGGodQAs/8nhObL9PtgbXU?=
 =?iso-8859-1?Q?bemr/QcA4rpiObeN3eYuzIO1BTf8EvNl2n5VaMaTNFmIn1mOZZaopCVNB2?=
 =?iso-8859-1?Q?hlkQDOh4OeqRjqBBj+88uwDh3uxEcn/+8DI0nQw3pHh8AgQG37rdsvTLGN?=
 =?iso-8859-1?Q?9ELFgHclRE6B/THzht5L8ycHDnGeLM2ZYICqERQQgYnvyOb1w1Tj0cycm1?=
 =?iso-8859-1?Q?euQFH5D3LhCa+GZCx+eNBHGsfeJBfsB7WTLbtKzqulLE1IBnlVQC1kLUCm?=
 =?iso-8859-1?Q?RKcFytGo4GkNq8UUg77iOLCRCa5q0aPGVGLNMhR96b+IJusls+/oPm+K9n?=
 =?iso-8859-1?Q?gm+bZaFBg/P48MMSQC9C2K1R8MuVeJ0Kh3GGJjRX5+5S6QuA8j0yM/ncal?=
 =?iso-8859-1?Q?fMoeHS4dd78NxwjRoxPFam8K7D6ZzU2GvBmPTU9EU0rF2BmB9f21VOv+iD?=
 =?iso-8859-1?Q?Rf9CrAIL/MAhjleXUhRlbe59HM+zbRehQLsal2tkaGZIMtThkW1C8Mx1HK?=
 =?iso-8859-1?Q?MiZTf4dFbx6ApuqiiMJvrmIn1GCKP16Qg3WnGgTdgMsCVurx4G8PGnySEk?=
 =?iso-8859-1?Q?+pMd4PW4C3aQmZIU2hTQuhfD5uxp4/aSkvZ/VUoP/ArIgzvCZ8BDiKrw?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5176.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9e4450f-0606-492f-87e1-08dba910efa4
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2023 04:24:00.7895
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5DrZvMciLqAgHFaPWhTQpEZsfYUcjxX6gXWX7lDnmItE1KAM6YWlHhsyz2mzxIt2pM4q6JqPcqSTUsH9Joi/qzQILnNA6IiaO/lsb8plK8I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6611
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ajay Singh <ajay.kathat@microchip.com>

Remove unnecessary byte order conversion for 'key_mgmt_suite' since
wpa_supplicant allows any byte order for AKM suite value. The change
also helps avoid the below warning:

drivers/net/wireless/microchip/wilc1000/cfg80211.c:361:42: sparse: sparse: =
incorrect type in assignment (different base types) @@     expected unsigne=
d int key_mgmt_suite @@     got restricted __be32 [usertype] @@
drivers/net/wireless/microchip/wilc1000/cfg80211.c:361:42: sparse:     expe=
cted unsigned int key_mgmt_suite
drivers/net/wireless/microchip/wilc1000/cfg80211.c:361:42: sparse:     got =
restricted __be32 [usertype]

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202308290615.lUTIgqUl-lkp@int=
el.com/
Signed-off-by: Ajay Singh <ajay.kathat@microchip.com>
---
 drivers/net/wireless/microchip/wilc1000/cfg80211.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/microchip/wilc1000/cfg80211.c b/drivers/n=
et/wireless/microchip/wilc1000/cfg80211.c
index b545d93c6e37..390f325bc422 100644
--- a/drivers/net/wireless/microchip/wilc1000/cfg80211.c
+++ b/drivers/net/wireless/microchip/wilc1000/cfg80211.c
@@ -359,7 +359,7 @@ static int connect(struct wiphy *wiphy, struct net_devi=
ce *dev,
 			memcpy(vif->auth.ssid.ssid, sme->ssid, sme->ssid_len);
 			vif->auth.ssid.ssid_len =3D sme->ssid_len;
 		}
-		vif->auth.key_mgmt_suite =3D cpu_to_be32(sme->crypto.akm_suites[0]);
+		vif->auth.key_mgmt_suite =3D sme->crypto.akm_suites[0];
 		ether_addr_copy(vif->auth.bssid, sme->bssid);
 		break;

--
2.34.1
