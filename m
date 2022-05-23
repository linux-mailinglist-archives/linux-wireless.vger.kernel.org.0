Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B0C0531316
	for <lists+linux-wireless@lfdr.de>; Mon, 23 May 2022 18:23:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236906AbiEWOJR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 23 May 2022 10:09:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236900AbiEWOJM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 23 May 2022 10:09:12 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42EFE590A8
        for <linux-wireless@vger.kernel.org>; Mon, 23 May 2022 07:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1653314951; x=1684850951;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=KsH5sYE2u2YRHQc9eXQt5Tfd+tPOiENJz897/d76V4Y=;
  b=sE7HJvz6gwHmZW/OH02BURyegu4KtskZDIu93KWqlUcT3n1r1r3/zYLJ
   gE1JMlSI/bDOLp/nr4v67npdxIvnUJPimwCDDdL+oJIpXrPMKdfBCcrj2
   xrE+tjv9VgNZk80jUAkKoqmZPZoFS04JQWspRZwr5bcet4Q9oC5unTEV3
   dOa6Ld0wdEMQFN5wZCeyiYggGdM+1+JR2x5ombCgyTaO/ZaZgctT0En6M
   besjmFMaJ/mK+I7U3H+vE4wSrpf2UyUBT+qo/bsq2Q5eznznKu4F2puEH
   JvEIa4D0U785anhJTH7pK1gSXACKWzfDpWoj0jbydvNjZFMv7TGVPRP5m
   A==;
X-IronPort-AV: E=Sophos;i="5.91,246,1647327600"; 
   d="scan'208";a="165280792"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 23 May 2022 07:09:10 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 23 May 2022 07:09:09 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Mon, 23 May 2022 07:09:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mZtFLDZuWzeXy4ppJdC5dc9fE5KBueaAjcuGWVKJxJrNeMIOFEGpQs/NPKvqk6tEc3eiQoEeN+ff1RuCJys8Svqjl/U35Vc5QgZbNb2uckKb0SQpvK3OO7Y08/wXm21kVHeoVpT1IwcVAyueHTZxI9zyYJB1D99cvxk2pWfZTo+hdckmFSLG/rsUmZVaiEqAmB+HHKmQQ+IFzNBVqrAqJrjmfsKLEzbJ31MY28zuneH7EffSpZs3ua5p2vGY7gWi8zQWRqRpJ5NjVbgHkXiO4A1Ct+GClhBMbqtRDYEyduMtRrxP/NoHVekUBIWj+K13kNkUxTpM1qPHIufBnXBdYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tH34q5DUTaS4NO+saZpHmJDS1O8nIf305oT33HboKPY=;
 b=iNKuPQbAkAprnpH5MqyCiXc/HM+gFQjU929TRkLYaX8pPPEFf7UiXnAFtneRwwBWcUsekBOLR9Mo5fPepT38+G0jta9yuTXOdjwcPGV/6FX38LJ27pKTOhVQugIJS3lXW3K5YIvttamFVQ/nsdLksGetvpaQdeluYLy1LFh0F9oSRHxSlTHi9PabVn+Ec/HVmGpz5L+CvTGpZeAra23bfnVBoXsTIYgz2mbhykL/K6Jl2u0B7JpteO9dutBM1iw0D6/8IlCxBKdEC6IWmzD5oYpHKMcwFzh0X+LQbjWGNQkCkSxqBVOIKBXZpNkEPRg+0EyaVX2dpdlraUMmKkaTQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tH34q5DUTaS4NO+saZpHmJDS1O8nIf305oT33HboKPY=;
 b=tMMtcgkIh69471Ob5AF/yg8tvXrK1825lWNkfGp5yeeL68HsrRNAyrolvzrAMUxF+Xu8PHtJVPxu584biMwcQUvLFbQACr++/5i5jrX23IJd+kQ1o8rsGNOP7I5ScVEtCrwsfiDZCcRfCk2OZSkCwKXtZeaO58XdbllGMnpZqvY=
Received: from PH0PR11MB5176.namprd11.prod.outlook.com (2603:10b6:510:3f::5)
 by SJ0PR11MB5600.namprd11.prod.outlook.com (2603:10b6:a03:3ab::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.14; Mon, 23 May
 2022 14:09:08 +0000
Received: from PH0PR11MB5176.namprd11.prod.outlook.com
 ([fe80::d0fc:845b:ce0b:11fa]) by PH0PR11MB5176.namprd11.prod.outlook.com
 ([fe80::d0fc:845b:ce0b:11fa%8]) with mapi id 15.20.5273.023; Mon, 23 May 2022
 14:09:08 +0000
From:   <Ajay.Kathat@microchip.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <Claudiu.Beznea@microchip.com>, <Sripad.Balwadgi@microchip.com>,
        <Ajay.Kathat@microchip.com>
Subject: [PATCH v2 3/4] wilc1000: add WPA3 SAE support
Thread-Topic: [PATCH v2 3/4] wilc1000: add WPA3 SAE support
Thread-Index: AQHYbq6qvTuLXN4jmUugCJjfcMRvPw==
Date:   Mon, 23 May 2022 14:09:07 +0000
Message-ID: <20220523140812.164028-3-ajay.kathat@microchip.com>
References: <20220523140812.164028-1-ajay.kathat@microchip.com>
In-Reply-To: <20220523140812.164028-1-ajay.kathat@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.25.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b2002d2d-2b14-4cb0-76c4-08da3cc5cd82
x-ms-traffictypediagnostic: SJ0PR11MB5600:EE_
x-microsoft-antispam-prvs: <SJ0PR11MB5600D84864110B593998A152E3D49@SJ0PR11MB5600.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pnPaRGRGMq9Qs8J/jYKYSf3tjpjnSSstb7dkTB5vn+c0aa8san8X998gVDM7UgsL9nngUCeUyzK5F4zu/dcg0EwYG3hoEyjH+mWhwzG5EGu2fFHiCDMOToxxz6/HAuqkibrfuWZRT4mL3py/epM3l2cZu1ND4aCh4AhUghpv7EiaZvU55f5i7x2OVtZw5G1wRihF10Mq5iWa03miu6KPpChZIECSEzzGfw8xHMBSoDVFeR6C+rfBu+4+KBUKMtqLitvdI5AkLs4MXHa2k4qU1qg7QNb1ILulljBEnDFOuIcj1r7vBHYnAuIIw1us3Wk9yASXGNQUh1SOxZww3QA4lZ59+4WMJVPebjZctBYu7KUWKZ64WeIREeNpjBCcVCdp1UsyLfrWClnnLfL+NDO1iHCaCLeOo9N4QsjtnpVzBB5X+N6fasgcbgL1Zl0Dp/c4la6YywOZ6+d5OqDB+AEtm+f7zOVQNa5HpICGpg8YaMv4z7bZ0hkKhGJcSNsLTPHNwHzgJK43uB/gKwP+O/3LO3lF3yYmNbU+7yYjjFUJygENwoRdNzlWzX/7oIb6jf9CMOMz/HH9Wa3BV51ye1lu0gK6ytwrU2SvRk3QjP/vWfe4f5rhu1byb9m/Mla+u6ulPLtilXueLyWRgBdKomTR3DX8+O9XO2usvxBBIZMHIvE0VMdB/NLr160noGKiHiCqsTsrak0Z/1swtFeWJh7TLA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5176.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(4326008)(83380400001)(76116006)(86362001)(91956017)(5660300002)(6486002)(36756003)(8936002)(508600001)(64756008)(66446008)(66946007)(316002)(8676002)(66476007)(66556008)(186003)(6512007)(30864003)(6916009)(122000001)(6506007)(54906003)(1076003)(107886003)(2616005)(2906002)(71200400001)(38070700005)(38100700002)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?GFoBkSBB2xfP/3YXWwuZtXQPxkjAg8QKGSUZsBqwaWB/T6Vp/cVl8KbnxC?=
 =?iso-8859-1?Q?BmeRITcnNhDRJmJgh+nPpEjwf24Oz6q2Kt4pJs1OryI2teMtOdLNWnLZKx?=
 =?iso-8859-1?Q?y06HBgpAiXm0bTcOXLC0waC/iW5ccugq1LZY6UfY1EGlWxE2hkvXDDCkHk?=
 =?iso-8859-1?Q?vzu/i8EtDbiFv+HBLw/nMCsxdKa93oIQRNwR2RGbzUrbgYS02DX6ceez34?=
 =?iso-8859-1?Q?GYiX3p+BvCyfMVSDStCx89JwiF9ZWMhWjt7Kc+syR5irpbOHeyi6ccM6cr?=
 =?iso-8859-1?Q?RqM616ZmaSjoLCQ6+xMIVw6IY5BYblV+SxA8X/JhnBoOkIQMmDpzGzqyY1?=
 =?iso-8859-1?Q?loBNsOOsdgq5fqpXBAaj3xiJKbS/9EWL+V4V9tvkcwktsK/pPCCDkdpAc1?=
 =?iso-8859-1?Q?JQXDN6gXOcCxkidkSKpg94BcdV3kR43v8jRZmvYq1XkWggOAkQloirhu/0?=
 =?iso-8859-1?Q?GhQGYS3WUUA6uFbUiI/IytmmQyjLjiKuzsnT9KKfuniArd5kXMo2Sbszto?=
 =?iso-8859-1?Q?zeemgeXxv92dXkHge3z2NcGcM2iQb+ydq5u1tr4lpMtcByAy2hbLwBVYHw?=
 =?iso-8859-1?Q?hOerLM0ebBlYPcj4FjkgFPLuX10iOOIG1If9JPClT2eXeDsuFfaGMrq2x9?=
 =?iso-8859-1?Q?j5ZQCNIU7JiDq4L2n/AhcEM+1BQt9UfJMWRT5LZLGXsgfrW2U7+pknZxv6?=
 =?iso-8859-1?Q?kAHslCPMJ8Qdc7jczedLG4EXeY0lIs3KoJr+Oc+PxA6b4IRaLD3iPXmIQk?=
 =?iso-8859-1?Q?R2i8M+xbQQX/lxhfURf8l8IHMUs+vsbQ2uC5BmlCH9iIV8a9cYFaBH+sfY?=
 =?iso-8859-1?Q?10zkYfg0k4MRTLG0uFw5To+BPt1DFHpjMrLvmioSp9BycGY/hjORkJRYmb?=
 =?iso-8859-1?Q?tJ1JHE9l2I7MuQeKeb68/+/ZqVDbPx/h1E+kxhTr+azI2PFN8TBgXzff7y?=
 =?iso-8859-1?Q?x1dz0BEjhfI0WFE6P6KkUUfmfib+ubpcXwSCf4c9Qq8mXKn6jqCkUHU1Z9?=
 =?iso-8859-1?Q?yoowevaBfGwxKgsCcVJpcp4K6ZfPyEfD1hNlfWP1BP61Tfr2DEBJBp1mYb?=
 =?iso-8859-1?Q?uSI9ezEdNuRIRr5SCUwmSWJWCPnFIzNJFazG9l4e75R933qJO3ACzD9A/N?=
 =?iso-8859-1?Q?4zmmr+JrQ6npdaAK1xK+73Z/MzJtXRvCGVebjzJFhBcbpNyn5ynLu49Fzl?=
 =?iso-8859-1?Q?okJ+LyFXjg+xDckE7d+LNaYWCEboN2OabDUxtH5xNPyR5BpOjYOP44vhw+?=
 =?iso-8859-1?Q?gRSnUEYySzb50psfVfDKJedigOzvSLVfbxYgfUJnlwdHW+dXF0+VV889Ss?=
 =?iso-8859-1?Q?9EnGwujRLYi2aSdKjsREeppmVi0D6zb8x3DuYEoJetLrLqISC3QNQi5IHJ?=
 =?iso-8859-1?Q?FM1DFTLASrcIYNN4wiclwa8NyOJTyv4axusjuGI/p/ZsnZUogB1h1eyqoe?=
 =?iso-8859-1?Q?GlvAAlMjxp+k3FYOw7uOH5IXPcs7uEGeypTE6vLjkDLgoc+LxsbAnObeUQ?=
 =?iso-8859-1?Q?1E2bgxlnVkoTpX0tt1ZX7HWw32r10P2NP8oD/ahJ7M4xxV9prHP9aW8W1a?=
 =?iso-8859-1?Q?D7lpeuQPXF/KJYlmTqbRZZLJRTJii/rpn9ipsEdC5xDVlaK7OmTWwAJEmX?=
 =?iso-8859-1?Q?n0cFIOLqFz6rhKnIoHDsTmjOxz7muNZc8IFP65/0Yc3JL0lBBvEOjgKW17?=
 =?iso-8859-1?Q?+cvV15Nrcq2i7VqIm+UQFOl/XxrUMAeVakLi6YfYM4+iWxwAWstAHseWGU?=
 =?iso-8859-1?Q?KQIzYFPCWYmFG0ghGAFVpxIEvyTHUNfPDdPgxgwTdGtNCcCD0jJLLynRBe?=
 =?iso-8859-1?Q?XNTUBB1/o20rMqAAhicdUMMmfH0FsmhYVrfYYD3WlXO31sXnC9sG?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5176.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2002d2d-2b14-4cb0-76c4-08da3cc5cd82
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2022 14:09:07.9824
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ufgDoUp8GsceizvtNTp4kTkf0RQH6l8dDtyVP3eBY+l4bPjyFmxZ6/yHlHNyHunCGIygGRyyaxwaIStZ95jDfo9b7VNlfV3R2zWXJF8v6SY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5600
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

Enable SAE authentication for AP and STA mode. In STA mode, allow the
driver to pass the auth frames which are received from firmware to
userspace application(hostapd) so that SAE authentication is offloaded to
userspace.

Signed-off-by: Ajay Singh <ajay.kathat@microchip.com>
---

 v2: remove unused variable reported by kernel test robot

 .../wireless/microchip/wilc1000/cfg80211.c    | 62 +++++++++++++++++--
 drivers/net/wireless/microchip/wilc1000/fw.h  |  9 +++
 drivers/net/wireless/microchip/wilc1000/hif.c | 44 ++++++++++++-
 drivers/net/wireless/microchip/wilc1000/hif.h |  3 +
 .../net/wireless/microchip/wilc1000/netdev.c  | 11 +++-
 .../net/wireless/microchip/wilc1000/netdev.h  |  3 +-
 .../net/wireless/microchip/wilc1000/wlan.c    |  3 +-
 .../net/wireless/microchip/wilc1000/wlan.h    |  2 +
 .../net/wireless/microchip/wilc1000/wlan_if.h | 10 ++-
 9 files changed, 133 insertions(+), 14 deletions(-)

diff --git a/drivers/net/wireless/microchip/wilc1000/cfg80211.c b/drivers/n=
et/wireless/microchip/wilc1000/cfg80211.c
index 256026d57a70..ea59ce9fd991 100644
--- a/drivers/net/wireless/microchip/wilc1000/cfg80211.c
+++ b/drivers/net/wireless/microchip/wilc1000/cfg80211.c
@@ -20,9 +20,11 @@
 static const struct ieee80211_txrx_stypes
 	wilc_wfi_cfg80211_mgmt_types[NUM_NL80211_IFTYPES] =3D {
 	[NL80211_IFTYPE_STATION] =3D {
-		.tx =3D 0xffff,
+		.tx =3D BIT(IEEE80211_STYPE_ACTION >> 4) |
+			BIT(IEEE80211_STYPE_AUTH >> 4),
 		.rx =3D BIT(IEEE80211_STYPE_ACTION >> 4) |
-			BIT(IEEE80211_STYPE_PROBE_REQ >> 4)
+			BIT(IEEE80211_STYPE_PROBE_REQ >> 4) |
+			BIT(IEEE80211_STYPE_AUTH >> 4)
 	},
 	[NL80211_IFTYPE_AP] =3D {
 		.tx =3D 0xffff,
@@ -350,6 +352,16 @@ static int connect(struct wiphy *wiphy, struct net_dev=
ice *dev,
 		auth_type =3D WILC_FW_AUTH_OPEN_SYSTEM;
 		break;
=20
+	case NL80211_AUTHTYPE_SAE:
+		auth_type =3D WILC_FW_AUTH_SAE;
+		if (sme->ssid_len) {
+			memcpy(vif->auth.ssid.ssid, sme->ssid, sme->ssid_len);
+			vif->auth.ssid.ssid_len =3D sme->ssid_len;
+		}
+		vif->auth.key_mgmt_suite =3D cpu_to_be32(sme->crypto.akm_suites[0]);
+		ether_addr_copy(vif->auth.bssid, sme->bssid);
+		break;
+
 	default:
 		break;
 	}
@@ -357,6 +369,10 @@ static int connect(struct wiphy *wiphy, struct net_dev=
ice *dev,
 	if (sme->crypto.n_akm_suites) {
 		if (sme->crypto.akm_suites[0] =3D=3D WLAN_AKM_SUITE_8021X)
 			auth_type =3D WILC_FW_AUTH_IEEE8021;
+		else if (sme->crypto.akm_suites[0] =3D=3D WLAN_AKM_SUITE_PSK_SHA256)
+			auth_type =3D WILC_FW_AUTH_OPEN_SYSTEM_SHA256;
+		else if (sme->crypto.akm_suites[0] =3D=3D WLAN_AKM_SUITE_8021X_SHA256)
+			auth_type =3D WILC_FW_AUTH_IEE8021X_SHA256;
 	}
=20
 	if (wfi_drv->usr_scan_req.scan_result) {
@@ -905,6 +921,18 @@ static inline void wilc_wfi_cfg_parse_ch_attr(u8 *buf,=
 u32 len, u8 sta_ch)
 	}
 }
=20
+bool wilc_wfi_mgmt_frame_rx(struct wilc_vif *vif, u8 *buff, u32 size)
+{
+	struct wilc *wl =3D vif->wilc;
+	struct wilc_priv *priv =3D &vif->priv;
+	int freq, ret;
+
+	freq =3D ieee80211_channel_to_frequency(wl->op_ch, NL80211_BAND_2GHZ);
+	ret =3D cfg80211_rx_mgmt(&priv->wdev, freq, 0, buff, size, 0);
+
+	return ret;
+}
+
 void wilc_wfi_p2p_rx(struct wilc_vif *vif, u8 *buff, u32 size)
 {
 	struct wilc *wl =3D vif->wilc;
@@ -1090,8 +1118,14 @@ static int mgmt_tx(struct wiphy *wiphy,
 		goto out_txq_add_pkt;
 	}
=20
-	if (!ieee80211_is_public_action((struct ieee80211_hdr *)buf, len))
+	if (!ieee80211_is_public_action((struct ieee80211_hdr *)buf, len)) {
+		if (chan)
+			wilc_set_mac_chnl_num(vif, chan->hw_value);
+		else
+			wilc_set_mac_chnl_num(vif, vif->wilc->op_ch);
+
 		goto out_set_timeout;
+	}
=20
 	d =3D (struct wilc_p2p_pub_act_frame *)(&mgmt->u.action);
 	if (d->oui_type !=3D WLAN_OUI_TYPE_WFA_P2P ||
@@ -1158,6 +1192,7 @@ void wilc_update_mgmt_frame_registrations(struct wiph=
y *wiphy,
 	struct wilc_vif *vif =3D netdev_priv(wdev->netdev);
 	u32 presp_bit =3D BIT(IEEE80211_STYPE_PROBE_REQ >> 4);
 	u32 action_bit =3D BIT(IEEE80211_STYPE_ACTION >> 4);
+	u32 pauth_bit =3D BIT(IEEE80211_STYPE_AUTH >> 4);
=20
 	if (wl->initialized) {
 		bool prev =3D vif->mgmt_reg_stypes & presp_bit;
@@ -1171,10 +1206,26 @@ void wilc_update_mgmt_frame_registrations(struct wi=
phy *wiphy,
=20
 		if (now !=3D prev)
 			wilc_frame_register(vif, IEEE80211_STYPE_ACTION, now);
+
+		prev =3D vif->mgmt_reg_stypes & pauth_bit;
+		now =3D upd->interface_stypes & pauth_bit;
+		if (now !=3D prev)
+			wilc_frame_register(vif, IEEE80211_STYPE_AUTH, now);
 	}
=20
 	vif->mgmt_reg_stypes =3D
-		upd->interface_stypes & (presp_bit | action_bit);
+		upd->interface_stypes & (presp_bit | action_bit | pauth_bit);
+}
+
+static int external_auth(struct wiphy *wiphy, struct net_device *dev,
+			 struct cfg80211_external_auth_params *auth)
+{
+	struct wilc_vif *vif =3D netdev_priv(dev);
+
+	if (auth->status =3D=3D WLAN_STATUS_SUCCESS)
+		wilc_set_external_auth_param(vif, auth);
+
+	return 0;
 }
=20
 static int set_cqm_rssi_config(struct wiphy *wiphy, struct net_device *dev=
,
@@ -1590,6 +1641,7 @@ static const struct cfg80211_ops wilc_cfg80211_ops =
=3D {
 	.change_bss =3D change_bss,
 	.set_wiphy_params =3D set_wiphy_params,
=20
+	.external_auth =3D external_auth,
 	.set_pmksa =3D set_pmksa,
 	.del_pmksa =3D del_pmksa,
 	.flush_pmksa =3D flush_pmksa,
@@ -1732,7 +1784,7 @@ struct wilc *wilc_create_wiphy(struct device *dev)
 				BIT(NL80211_IFTYPE_P2P_GO) |
 				BIT(NL80211_IFTYPE_P2P_CLIENT);
 	wiphy->flags |=3D WIPHY_FLAG_HAS_REMAIN_ON_CHANNEL;
-
+	wiphy->features |=3D NL80211_FEATURE_SAE;
 	set_wiphy_dev(wiphy, dev);
 	wl->wiphy =3D wiphy;
 	ret =3D wiphy_register(wiphy);
diff --git a/drivers/net/wireless/microchip/wilc1000/fw.h b/drivers/net/wir=
eless/microchip/wilc1000/fw.h
index 237ca348d1f8..9449c5d0b472 100644
--- a/drivers/net/wireless/microchip/wilc1000/fw.h
+++ b/drivers/net/wireless/microchip/wilc1000/fw.h
@@ -110,4 +110,13 @@ struct wilc_join_bss_param {
 		struct wilc_noa_opp_enable opp_en;
 	};
 } __packed;
+
+struct wilc_external_auth_param {
+	u8 action;
+	u8 bssid[ETH_ALEN];
+	u8 ssid[IEEE80211_MAX_SSID_LEN];
+	u8 ssid_len;
+	__le32 key_mgmt_suites;
+	__le16 status;
+} __packed;
 #endif
diff --git a/drivers/net/wireless/microchip/wilc1000/hif.c b/drivers/net/wi=
reless/microchip/wilc1000/hif.c
index 573750356007..5d9d3aba737c 100644
--- a/drivers/net/wireless/microchip/wilc1000/hif.c
+++ b/drivers/net/wireless/microchip/wilc1000/hif.c
@@ -306,7 +306,10 @@ static int wilc_send_connect_wid(struct wilc_vif *vif)
 		netdev_err(vif->ndev, "failed to send config packet\n");
 		goto error;
 	} else {
-		hif_drv->hif_state =3D HOST_IF_WAITING_CONN_RESP;
+                if (conn_attr->auth_type =3D=3D WILC_FW_AUTH_SAE)
+                        hif_drv->hif_state =3D HOST_IF_EXTERNAL_AUTH;
+                else
+                        hif_drv->hif_state =3D HOST_IF_WAITING_CONN_RESP;
 	}
=20
 	return 0;
@@ -665,7 +668,12 @@ static void handle_rcvd_gnrl_async_info(struct work_st=
ruct *work)
 		goto free_msg;
 	}
=20
-	if (hif_drv->hif_state =3D=3D HOST_IF_WAITING_CONN_RESP) {
+
+        if (hif_drv->hif_state =3D=3D HOST_IF_EXTERNAL_AUTH) {
+                cfg80211_external_auth_request(vif->ndev, &vif->auth,
+					       GFP_KERNEL);
+                hif_drv->hif_state =3D HOST_IF_WAITING_CONN_RESP;
+        } else if (hif_drv->hif_state =3D=3D HOST_IF_WAITING_CONN_RESP) {
 		host_int_parse_assoc_resp_info(vif, mac_info->status);
 	} else if (mac_info->status =3D=3D WILC_MAC_STATUS_DISCONNECTED) {
 		if (hif_drv->hif_state =3D=3D HOST_IF_CONNECTED) {
@@ -710,7 +718,8 @@ int wilc_disconnect(struct wilc_vif *vif)
 	}
=20
 	if (conn_info->conn_result) {
-		if (hif_drv->hif_state =3D=3D HOST_IF_WAITING_CONN_RESP)
+		if (hif_drv->hif_state =3D=3D HOST_IF_WAITING_CONN_RESP ||
+		    hif_drv->hif_state =3D=3D HOST_IF_EXTERNAL_AUTH)
 			del_timer(&hif_drv->connect_timer);
=20
 		conn_info->conn_result(CONN_DISCONN_EVENT_DISCONN_NOTIF, 0,
@@ -986,6 +995,31 @@ void wilc_set_wowlan_trigger(struct wilc_vif *vif, boo=
l enabled)
 		pr_err("Failed to send wowlan trigger config packet\n");
 }
=20
+int wilc_set_external_auth_param(struct wilc_vif *vif,
+				 struct cfg80211_external_auth_params *auth)
+{
+	int ret;
+	struct wid wid;
+	struct wilc_external_auth_param *param;
+
+	wid.id =3D WID_EXTERNAL_AUTH_PARAM;
+	wid.type =3D WID_BIN_DATA;
+	wid.size =3D sizeof(*param);
+	param =3D kzalloc(sizeof(*param), GFP_KERNEL);
+	if (!param)
+		return -EINVAL;
+
+	wid.val =3D (u8 *)param;
+	param->action =3D auth->action;
+	ether_addr_copy(param->bssid, auth->bssid);
+	memcpy(param->ssid, auth->ssid.ssid, auth->ssid.ssid_len);
+	param->ssid_len =3D auth->ssid.ssid_len;
+	ret =3D wilc_send_config_pkt(vif, WILC_SET_CFG, &wid, 1);
+
+	kfree(param);
+	return ret;
+}
+
 static void handle_scan_timer(struct work_struct *work)
 {
 	struct host_if_msg *msg =3D container_of(work, struct host_if_msg, work);
@@ -1647,6 +1681,10 @@ void wilc_frame_register(struct wilc_vif *vif, u16 f=
rame_type, bool reg)
 		reg_frame.reg_id =3D WILC_FW_PROBE_REQ_IDX;
 		break;
=20
+        case IEEE80211_STYPE_AUTH:
+                reg_frame.reg_id =3D WILC_FW_AUTH_REQ_IDX;
+                break;
+
 	default:
 		break;
 	}
diff --git a/drivers/net/wireless/microchip/wilc1000/hif.h b/drivers/net/wi=
reless/microchip/wilc1000/hif.h
index c9740457ed58..f1a0a1f042ca 100644
--- a/drivers/net/wireless/microchip/wilc1000/hif.h
+++ b/drivers/net/wireless/microchip/wilc1000/hif.h
@@ -47,6 +47,7 @@ enum host_if_state {
 	HOST_IF_WAITING_CONN_RESP	=3D 3,
 	HOST_IF_CONNECTED		=3D 4,
 	HOST_IF_P2P_LISTEN		=3D 5,
+	HOST_IF_EXTERNAL_AUTH           =3D 6,
 	HOST_IF_FORCE_32BIT		=3D 0xFFFFFFFF
 };
=20
@@ -202,6 +203,8 @@ int wilc_get_vif_idx(struct wilc_vif *vif);
 int wilc_set_tx_power(struct wilc_vif *vif, u8 tx_power);
 int wilc_get_tx_power(struct wilc_vif *vif, u8 *tx_power);
 void wilc_set_wowlan_trigger(struct wilc_vif *vif, bool enabled);
+int wilc_set_external_auth_param(struct wilc_vif *vif,
+				 struct cfg80211_external_auth_params *param);
 void wilc_scan_complete_received(struct wilc *wilc, u8 *buffer, u32 length=
);
 void wilc_network_info_received(struct wilc *wilc, u8 *buffer, u32 length)=
;
 void wilc_gnrl_async_info_received(struct wilc *wilc, u8 *buffer, u32 leng=
th);
diff --git a/drivers/net/wireless/microchip/wilc1000/netdev.c b/drivers/net=
/wireless/microchip/wilc1000/netdev.c
index 3c292e3464c2..fcc4e61592ee 100644
--- a/drivers/net/wireless/microchip/wilc1000/netdev.c
+++ b/drivers/net/wireless/microchip/wilc1000/netdev.c
@@ -835,15 +835,24 @@ void wilc_frmw_to_host(struct wilc *wilc, u8 *buff, u=
32 size,
 	}
 }
=20
-void wilc_wfi_mgmt_rx(struct wilc *wilc, u8 *buff, u32 size)
+void wilc_wfi_mgmt_rx(struct wilc *wilc, u8 *buff, u32 size, bool is_auth)
 {
 	int srcu_idx;
 	struct wilc_vif *vif;
=20
 	srcu_idx =3D srcu_read_lock(&wilc->srcu);
 	list_for_each_entry_rcu(vif, &wilc->vif_list, list) {
+		struct ieee80211_mgmt *mgmt =3D (struct ieee80211_mgmt *)buff;
 		u16 type =3D le16_to_cpup((__le16 *)buff);
 		u32 type_bit =3D BIT(type >> 4);
+		u32 auth_bit =3D BIT(IEEE80211_STYPE_AUTH >> 4);
+
+		if ((vif->mgmt_reg_stypes & auth_bit &&
+		     ieee80211_is_auth(mgmt->frame_control)) &&
+		    vif->iftype =3D=3D WILC_STATION_MODE && is_auth) {
+			wilc_wfi_mgmt_frame_rx(vif, buff, size);
+			break;
+		}
=20
 		if (vif->priv.p2p_listen_state &&
 		    vif->mgmt_reg_stypes & type_bit)
diff --git a/drivers/net/wireless/microchip/wilc1000/netdev.h b/drivers/net=
/wireless/microchip/wilc1000/netdev.h
index 630b1e85e68f..a0d9e981500e 100644
--- a/drivers/net/wireless/microchip/wilc1000/netdev.h
+++ b/drivers/net/wireless/microchip/wilc1000/netdev.h
@@ -185,6 +185,7 @@ struct wilc_vif {
 	struct wilc_priv priv;
 	struct list_head list;
 	struct cfg80211_bss *bss;
+	struct cfg80211_external_auth_params auth;
 };
=20
 struct wilc_tx_queue_status {
@@ -278,7 +279,7 @@ struct wilc_wfi_mon_priv {
 void wilc_frmw_to_host(struct wilc *wilc, u8 *buff, u32 size, u32 pkt_offs=
et);
 void wilc_mac_indicate(struct wilc *wilc);
 void wilc_netdev_cleanup(struct wilc *wilc);
-void wilc_wfi_mgmt_rx(struct wilc *wilc, u8 *buff, u32 size);
+void wilc_wfi_mgmt_rx(struct wilc *wilc, u8 *buff, u32 size, bool is_auth)=
;
 void wilc_wlan_set_bssid(struct net_device *wilc_netdev, const u8 *bssid,
 			 u8 mode);
 struct wilc_vif *wilc_netdev_ifc_init(struct wilc *wl, const char *name,
diff --git a/drivers/net/wireless/microchip/wilc1000/wlan.c b/drivers/net/w=
ireless/microchip/wilc1000/wlan.c
index 48441f0389ca..f3f504d12873 100644
--- a/drivers/net/wireless/microchip/wilc1000/wlan.c
+++ b/drivers/net/wireless/microchip/wilc1000/wlan.c
@@ -968,7 +968,8 @@ static void wilc_wlan_handle_rx_buff(struct wilc *wilc,=
 u8 *buffer, int size)
=20
 		if (pkt_offset & IS_MANAGMEMENT) {
 			buff_ptr +=3D HOST_HDR_OFFSET;
-			wilc_wfi_mgmt_rx(wilc, buff_ptr, pkt_len);
+			wilc_wfi_mgmt_rx(wilc, buff_ptr, pkt_len,
+					 pkt_offset & IS_MGMT_AUTH_PKT);
 		} else {
 			if (!is_cfg_packet) {
 				wilc_frmw_to_host(wilc, buff_ptr, pkt_len,
diff --git a/drivers/net/wireless/microchip/wilc1000/wlan.h b/drivers/net/w=
ireless/microchip/wilc1000/wlan.h
index eb7978166d73..b45e72789a0e 100644
--- a/drivers/net/wireless/microchip/wilc1000/wlan.h
+++ b/drivers/net/wireless/microchip/wilc1000/wlan.h
@@ -305,6 +305,7 @@
 #define IS_MANAGMEMENT		0x100
 #define IS_MANAGMEMENT_CALLBACK	0x080
 #define IS_MGMT_STATUS_SUCCES	0x040
+#define IS_MGMT_AUTH_PKT       0x010
=20
 #define WILC_WID_TYPE		GENMASK(15, 12)
 #define WILC_VMM_ENTRY_FULL_RETRY	1
@@ -423,6 +424,7 @@ int wilc_wlan_get_num_conn_ifcs(struct wilc *wilc);
 netdev_tx_t wilc_mac_xmit(struct sk_buff *skb, struct net_device *dev);
=20
 void wilc_wfi_p2p_rx(struct wilc_vif *vif, u8 *buff, u32 size);
+bool wilc_wfi_mgmt_frame_rx(struct wilc_vif *vif, u8 *buff, u32 size);
 void host_wakeup_notify(struct wilc *wilc);
 void host_sleep_notify(struct wilc *wilc);
 void chip_allow_sleep(struct wilc *wilc);
diff --git a/drivers/net/wireless/microchip/wilc1000/wlan_if.h b/drivers/ne=
t/wireless/microchip/wilc1000/wlan_if.h
index 6eb7eb4ac294..18f13b5643e8 100644
--- a/drivers/net/wireless/microchip/wilc1000/wlan_if.h
+++ b/drivers/net/wireless/microchip/wilc1000/wlan_if.h
@@ -85,7 +85,10 @@ enum authtype {
 	WILC_FW_AUTH_OPEN_SYSTEM =3D 1,
 	WILC_FW_AUTH_SHARED_KEY =3D 2,
 	WILC_FW_AUTH_ANY =3D 3,
-	WILC_FW_AUTH_IEEE8021 =3D 5
+	WILC_FW_AUTH_IEEE8021 =3D 5,
+	WILC_FW_AUTH_SAE =3D 7,
+	WILC_FW_AUTH_IEE8021X_SHA256 =3D 9,
+	WILC_FW_AUTH_OPEN_SYSTEM_SHA256 =3D 13
 };
=20
 enum site_survey {
@@ -176,7 +179,8 @@ enum {
=20
 enum {
 	WILC_FW_ACTION_FRM_IDX =3D 0,
-	WILC_FW_PROBE_REQ_IDX =3D 1
+	WILC_FW_PROBE_REQ_IDX =3D 1,
+	WILC_FW_AUTH_REQ_IDX =3D 2
 };
=20
 enum wid_type {
@@ -789,7 +793,7 @@ enum {
 	WID_ADD_BEACON			=3D 0x408a,
=20
 	WID_SETUP_MULTICAST_FILTER	=3D 0x408b,
-
+	WID_EXTERNAL_AUTH_PARAM		=3D 0x408d,
 	/* Miscellaneous WIDs */
 	WID_ALL				=3D 0x7FFE,
 	WID_MAX				=3D 0xFFFF
--=20
2.25.1
