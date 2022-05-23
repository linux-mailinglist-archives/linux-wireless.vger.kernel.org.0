Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D100531284
	for <lists+linux-wireless@lfdr.de>; Mon, 23 May 2022 18:22:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236926AbiEWOJQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 23 May 2022 10:09:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236906AbiEWOJM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 23 May 2022 10:09:12 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 436C5590AD
        for <linux-wireless@vger.kernel.org>; Mon, 23 May 2022 07:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1653314951; x=1684850951;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=QvPShWavlqycyc7emBoGM/bci8w1HSNyYRjB+2WLsK8=;
  b=olCOG9SyU1OUMCQ1ZC7jrlV0dxdrdB6jvJN56MTEQmeavagvMXrt5muK
   +JKx5LI5JN5GiSIeMvy488UzPJqqkv/QHo5GZ3Gvu2AHRuOQAzZB/Ik/x
   zSixx5xAxldXcCciC2YLrRhZLrCcKYRULd8dFTL674o9TqFO3vtMz1hKJ
   QXhw50UXsCJetXGnoL5x/+xaZJytEEaCOG6FsU1sPX87Hj3UfdkDHn4hC
   sHevLRj4hAiaKFPiibG2I7X5tIlbLzGtsFyzyOA6qlCZAbttJCKGusmcz
   1myvc+lpS6qeDEPA/QldlvANcJGHbF6q/SE/fZiYl0raEuaD4c7Csw5wk
   A==;
X-IronPort-AV: E=Sophos;i="5.91,246,1647327600"; 
   d="scan'208";a="164922030"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 23 May 2022 07:09:11 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 23 May 2022 07:09:10 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Mon, 23 May 2022 07:09:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QHmyXrPs11YTdt5XiEAcnEijuYxnnp7KJqoYKKuQGMJZQwAEcueNn++mayyuJyuq0zw4QoDUiHIH0mbCljU/99pS4SOwfiNUxuAdu1HltTPO5aQGGKfShhzoTjDIaLA2+h837OnJ6UvDnonS266hl95ha6Vm2WJaWkJ8JSZAdDc+RAGLenZ6IIeBWHX+pfcrjMkrWSjRIyXfA5RcrVKiGwVAz7iFrof4TutddyQuiX7Uliplw17S6oKOX2pt+VxcRwe5cxdfqTdfpZPWR7/n1Lg4uGEfH+LXYPlpnhvCIxtGj9KrOXabjYvXlBATMmofN0TQ7y0nK0+C31d6TmKZ3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O6OPWaXFTzPjXUf2LRzjG60TuPUkZcQmmsfiZeowXhQ=;
 b=OmFyKAKql909nFNnv7yftbk815fK8Jpx4z92khgyyLBFcLjdoTmr6TI6tip+pd39LYG1uoYbMMhekNAiGLm2j8wEY7XXcyU7RxGAo9Q/qmLjV1BNb4RZzxNXLKm4S3c0umFSccXxEycBRkcx5dWieq29PNfpgo2OgfPyxEY4wAxzwxBCcaM5OQUNh1ZqBXRMPuOtWJP+A9+rNU5uwVf7/sv0Oa6Fs1dQPZtHHHOp1KlzQpaw9WBYr2ZNlwP3YvxxT4julIHZU6nJARCV4sHmiRPsddTHyZkOyVGMxgp0tebG9tjEQU/e+dyt2iCwlcuNYCe+5dgYgAl5rTn4GyX0Ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O6OPWaXFTzPjXUf2LRzjG60TuPUkZcQmmsfiZeowXhQ=;
 b=NfXHE6NqHIYTDlg/uYNT9ewxCmQMaWN1AgBO6V66ySKI0tfzbbAk5yoe1bTlojy+3jv0rM7GmcVpGuXMogFM8HtakJsF5WP2bBn5SJScg3IwOS/G/tMVXiPdFk7MhcgNK1p/KzYATrbS9154VmCsq/6GreVMzlSzNK3+V9PUZ04=
Received: from PH0PR11MB5176.namprd11.prod.outlook.com (2603:10b6:510:3f::5)
 by SJ0PR11MB5600.namprd11.prod.outlook.com (2603:10b6:a03:3ab::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.14; Mon, 23 May
 2022 14:09:07 +0000
Received: from PH0PR11MB5176.namprd11.prod.outlook.com
 ([fe80::d0fc:845b:ce0b:11fa]) by PH0PR11MB5176.namprd11.prod.outlook.com
 ([fe80::d0fc:845b:ce0b:11fa%8]) with mapi id 15.20.5273.023; Mon, 23 May 2022
 14:09:06 +0000
From:   <Ajay.Kathat@microchip.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <Claudiu.Beznea@microchip.com>, <Sripad.Balwadgi@microchip.com>,
        <Ajay.Kathat@microchip.com>
Subject: [PATCH v2 2/4] wilc1000: remove WEP security support
Thread-Topic: [PATCH v2 2/4] wilc1000: remove WEP security support
Thread-Index: AQHYbq6qgc7qBh09cUe66LVmqiN6zA==
Date:   Mon, 23 May 2022 14:09:06 +0000
Message-ID: <20220523140812.164028-2-ajay.kathat@microchip.com>
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
x-ms-office365-filtering-correlation-id: a68fa46c-0c22-4206-d400-08da3cc5ccd6
x-ms-traffictypediagnostic: SJ0PR11MB5600:EE_
x-microsoft-antispam-prvs: <SJ0PR11MB56001D07D71636E6BCDD24C6E3D49@SJ0PR11MB5600.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lc1U4ztkv2R+xDmdRDLKhRtOY6ngNl80dLIiqE56TzRk8RiJYjSOSVw01w3dcRfGVjg/ikXy3C3Lt3ZBvL5/BYLEGBT+216gm+aiyCSNIvQ6YLd7vL5L1jI8kxWMM6l4afr4+X4V/4guDSL73542JkDv7WUSu3ZvJ+jozAg91ab3FBVTp+sF43E0ksKUPVQUpm+kKmuJybpyuSq/jdB3GZbZrkcET0sibaIqZGJ4pWO+ogfFKF4DugNlztitedktND1BgFUmRW9nzEaSPA6n61IN8Taa4kubBSjz+VM44YqMv/agbHXCujZ+TS21n7rXNSCxvBMPHX5XqyH9kbnu6gGUvBBBOGheXL8wKLhooOhWaRxilkvjCXCjarGIzOZurEPsMgvdZsu/ZWmFJw0pub1RM4dXv/10trZV69dmCZGlgWZWxwet6Xs/tHW3GJ7DXfGKy7iL8ZLAOBQJxWM8nk9eoMO2c5449IJ6w1z8EiwnskBlsZOsFxAPzsTXmPIwrmTd7JKd0rFr5CfzNhQztV7wtP6MGqYxdNFKp6d+VOzkQ8aVjaK3ucYY/h8kZDT2EuxKV9cNet2togK7C7fNKSfgB1Ffu29Bqvdntji/pDRvvOIJo0y0zWsxqQhFWhcUQm+YSuzePTD+4MsL5tKirTAc2/apBgneXGFWHdW1WFq+d+xwWdwiKL1HZNRUgl7RA60itow4LOZgKsaAOvTYbA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5176.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(4326008)(83380400001)(76116006)(86362001)(91956017)(5660300002)(6486002)(36756003)(8936002)(508600001)(64756008)(66446008)(66946007)(316002)(8676002)(66476007)(66556008)(186003)(6512007)(6916009)(122000001)(6506007)(54906003)(1076003)(107886003)(2616005)(15650500001)(2906002)(71200400001)(38070700005)(38100700002)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?8zIc+Jh9DR6/zvztf8/WK2PJevYwhre480UWCVVisuBoC3+HWZIX+rOx5/?=
 =?iso-8859-1?Q?5zfRUy6vZAcc+hI3bLE2xvoA3riKbaKbgm6mPm07imjLrSWoSdZWPjZ92C?=
 =?iso-8859-1?Q?T/JPB1oMDCpEbVKbER3MAkwEgy5YuZJqrGhNYBp3Ykd52N2reul97RgS2J?=
 =?iso-8859-1?Q?aADDHOUYHjiFu+qblwzqqy8UWTbXOXoacNdcA+3zcsB/5mK33PQqQd27go?=
 =?iso-8859-1?Q?8ehHqH9f+4cA+1AnaMvgeOqXJUHU2q1Xv3BFEZSOAxjH6YeCXDPR37aYvi?=
 =?iso-8859-1?Q?moStT51e6qMQPFmG9UqDxxU69jdKKh9VJk+jSltw4OtSsq0fB1LUCYj/LW?=
 =?iso-8859-1?Q?3mOrNEtLobdtnUWw+0s2YYShnAneMY+m1e2yOdGdCceGYD9SHt+7G6ktNa?=
 =?iso-8859-1?Q?77WVx5z8zKK397xP+weUMD1gVNVaskoLl+ggh2m+WNLAtMT9soJ+QPKLD+?=
 =?iso-8859-1?Q?QmsnCMj7LCJuZss6gK7y1CvpowKsu9FvBGCCxaSxUIPZnxpmcZAK4mONls?=
 =?iso-8859-1?Q?Lfib9gbv+05Sh0sQ+ioVbaBPBLREU5XMdJqhQNW/KsW6RzoBhvjsBs73zR?=
 =?iso-8859-1?Q?6ZI8bLRR9N5vejJqtotvkPkMoplNkFkOPt3rz2BmQ1egyd1b7h3Z7AIKz/?=
 =?iso-8859-1?Q?JRCwgBm+a0f2XbfP2ziFeiGWDebVIrdK/sgUDSTBuoaO7vBNhBti6oNs7M?=
 =?iso-8859-1?Q?v5OFfbVQ+oiqXLdQJAUf3jAOSODNYaN5ELKQSdsdTJacQbNlxp0jhPqRi6?=
 =?iso-8859-1?Q?+UrqpyxtX2Imkk3yW1EbFGMBoBio7Q99PayWOz4zw5fkIfS0BoZAqhIbpD?=
 =?iso-8859-1?Q?jHFUOFmGysdxutNMSVI5PmN/AsA6Wbu48uKsSOGvBM9WX9bFJLZ8/OR0ew?=
 =?iso-8859-1?Q?9bCWxOHAENUPyhxIOZzwNzLFLCCX2Hq6GN3LA2QlCdHC+EpYgsLfpo670T?=
 =?iso-8859-1?Q?WHtxCgdeJ2l6Au6Qj/ITrtuoR4piZMSMYYuw4fQJkK7MTnZMKOuY9KsNGr?=
 =?iso-8859-1?Q?ACPifL4EsuZsWht8fFJlnccBgm8pjDvvdctmcxB92FEPqVloDQr26BlPrc?=
 =?iso-8859-1?Q?+FYP0n3otTjro/25ET02FqC4CxwzkW/0CfVVXIhmm5n7JSr+ngitIoVnbe?=
 =?iso-8859-1?Q?QWCJzYEQeF1PVFS41Sl0i++14Enthz4xzAX5R+DMZWDzuFD17jIKKBmTsW?=
 =?iso-8859-1?Q?bB3BzXO+Rv2/Rcx1DezRGq+pCuNRxREGnvXNAwQwh+Eson4veXnGRnyoi4?=
 =?iso-8859-1?Q?jSpitxtv4OWBDVsUBXKuhOrdxBVXsoK2EiJEMMuPYUvFE9fU7+NjpgoHv3?=
 =?iso-8859-1?Q?RhMAHuwokiqwem61WQW35srxeffYAfBjxlHIDAhHdtbnjrEYRt0Thyw03d?=
 =?iso-8859-1?Q?WyD+Kj0dTQ0HK2gqIMDOT3q7PNHOQNoOUcrlZ0hgRhMTuZYJ0XsV49clpX?=
 =?iso-8859-1?Q?wLX5T0NKMx+CpU1fpsb74ZG2hMR2bgMGDBT//828yk1qvE4kuHLuGlV3v4?=
 =?iso-8859-1?Q?GmkadV6qTCEbOBWuvGNyQ36/lsusqpHh+HXC4/s9FrGV/3MhK/RHUaYBnC?=
 =?iso-8859-1?Q?3EoAtGtsBTEASCRcLubAlCr9HCkrYDwCCyICkxMRFc0NkRgIroY/NMMQEp?=
 =?iso-8859-1?Q?WNVfPHcHKltToFUyIf+5sMa1LmK8Ak1Q6esNwZHV3QzSPip95ZegTqny1b?=
 =?iso-8859-1?Q?IOFZ+lNv8fZPxEnWCjvWd5N83LKLuCjpfDV+ABrIaFL7Qxt9Cg+Gb/rIVI?=
 =?iso-8859-1?Q?L7beF+37042JBIOTkDgCklL2Em+M/EzBdiCDjao7ui88+xW5qFl50MXbkw?=
 =?iso-8859-1?Q?gtJLpMO/bgjOHpSJunzpP9ChGZiAlI/WsyWDeVT0tAhlqrzOJcxs?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5176.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a68fa46c-0c22-4206-d400-08da3cc5ccd6
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2022 14:09:06.9033
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KGLgrhtm7GgCmPTW4UilZtZjrSOnuVixaOG3snjL2EnxuosoP6+LyKpglvbV1ZifKLrdb5q+NneXxqEUw9AjwRPpjeGGzTgFBYDXIgylDZo=
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

Deprecated WEP security for WILC driver as well as in firmware from
15.6 FW release onwards. After WEP security removal, freeup some codespace
which helped to add new features like WPA3 etc.

Signed-off-by: Ajay Singh <ajay.kathat@microchip.com>
---
 .../wireless/microchip/wilc1000/cfg80211.c    |  76 +------------
 drivers/net/wireless/microchip/wilc1000/fw.h  |   6 --
 drivers/net/wireless/microchip/wilc1000/hif.c | 102 ------------------
 drivers/net/wireless/microchip/wilc1000/hif.h |   6 --
 .../net/wireless/microchip/wilc1000/netdev.h  |  10 --
 5 files changed, 2 insertions(+), 198 deletions(-)

diff --git a/drivers/net/wireless/microchip/wilc1000/cfg80211.c b/drivers/n=
et/wireless/microchip/wilc1000/cfg80211.c
index 8d8378bafd9b..256026d57a70 100644
--- a/drivers/net/wireless/microchip/wilc1000/cfg80211.c
+++ b/drivers/net/wireless/microchip/wilc1000/cfg80211.c
@@ -313,32 +313,9 @@ static int connect(struct wiphy *wiphy, struct net_dev=
ice *dev,
=20
 	vif->connecting =3D true;
=20
-	memset(priv->wep_key, 0, sizeof(priv->wep_key));
-	memset(priv->wep_key_len, 0, sizeof(priv->wep_key_len));
-
 	cipher_group =3D sme->crypto.cipher_group;
 	if (cipher_group !=3D 0) {
-		if (cipher_group =3D=3D WLAN_CIPHER_SUITE_WEP40) {
-			security =3D WILC_FW_SEC_WEP;
-
-			priv->wep_key_len[sme->key_idx] =3D sme->key_len;
-			memcpy(priv->wep_key[sme->key_idx], sme->key,
-			       sme->key_len);
-
-			wilc_set_wep_default_keyid(vif, sme->key_idx);
-			wilc_add_wep_key_bss_sta(vif, sme->key, sme->key_len,
-						 sme->key_idx);
-		} else if (cipher_group =3D=3D WLAN_CIPHER_SUITE_WEP104) {
-			security =3D WILC_FW_SEC_WEP_EXTENDED;
-
-			priv->wep_key_len[sme->key_idx] =3D sme->key_len;
-			memcpy(priv->wep_key[sme->key_idx], sme->key,
-			       sme->key_len);
-
-			wilc_set_wep_default_keyid(vif, sme->key_idx);
-			wilc_add_wep_key_bss_sta(vif, sme->key, sme->key_len,
-						 sme->key_idx);
-		} else if (sme->crypto.wpa_versions & NL80211_WPA_VERSION_2) {
+		if (sme->crypto.wpa_versions & NL80211_WPA_VERSION_2) {
 			if (cipher_group =3D=3D WLAN_CIPHER_SUITE_TKIP)
 				security =3D WILC_FW_SEC_WPA2_TKIP;
 			else
@@ -373,10 +350,6 @@ static int connect(struct wiphy *wiphy, struct net_dev=
ice *dev,
 		auth_type =3D WILC_FW_AUTH_OPEN_SYSTEM;
 		break;
=20
-	case NL80211_AUTHTYPE_SHARED_KEY:
-		auth_type =3D WILC_FW_AUTH_SHARED_KEY;
-		break;
-
 	default:
 		break;
 	}
@@ -487,14 +460,6 @@ static int disconnect(struct wiphy *wiphy, struct net_=
device *dev,
 	return ret;
 }
=20
-static inline void wilc_wfi_cfg_copy_wep_info(struct wilc_priv *priv,
-					      u8 key_index,
-					      struct key_params *params)
-{
-	priv->wep_key_len[key_index] =3D params->key_len;
-	memcpy(priv->wep_key[key_index], params->key, params->key_len);
-}
-
 static int wilc_wfi_cfg_allocate_wpa_entry(struct wilc_priv *priv, u8 idx)
 {
 	if (!priv->wilc_gtk[idx]) {
@@ -552,33 +517,6 @@ static int add_key(struct wiphy *wiphy, struct net_dev=
ice *netdev, u8 key_index,
 	struct wilc_priv *priv =3D &vif->priv;
=20
 	switch (params->cipher) {
-	case WLAN_CIPHER_SUITE_WEP40:
-	case WLAN_CIPHER_SUITE_WEP104:
-		if (priv->wdev.iftype =3D=3D NL80211_IFTYPE_AP) {
-			wilc_wfi_cfg_copy_wep_info(priv, key_index, params);
-
-			if (params->cipher =3D=3D WLAN_CIPHER_SUITE_WEP40)
-				mode =3D WILC_FW_SEC_WEP;
-			else
-				mode =3D WILC_FW_SEC_WEP_EXTENDED;
-
-			ret =3D wilc_add_wep_key_bss_ap(vif, params->key,
-						      params->key_len,
-						      key_index, mode,
-						      WILC_FW_AUTH_OPEN_SYSTEM);
-			break;
-		}
-		if (memcmp(params->key, priv->wep_key[key_index],
-			   params->key_len)) {
-			wilc_wfi_cfg_copy_wep_info(priv, key_index, params);
-
-			ret =3D wilc_add_wep_key_bss_sta(vif, params->key,
-						       params->key_len,
-						       key_index);
-		}
-
-		break;
-
 	case WLAN_CIPHER_SUITE_TKIP:
 	case WLAN_CIPHER_SUITE_CCMP:
 		if (priv->wdev.iftype =3D=3D NL80211_IFTYPE_AP ||
@@ -676,13 +614,6 @@ static int del_key(struct wiphy *wiphy, struct net_dev=
ice *netdev,
 		priv->wilc_ptk[key_index] =3D NULL;
 	}
=20
-	if (key_index <=3D 3 && priv->wep_key_len[key_index]) {
-		memset(priv->wep_key[key_index], 0,
-		       priv->wep_key_len[key_index]);
-		priv->wep_key_len[key_index] =3D 0;
-		wilc_remove_wep_key(vif, key_index);
-	}
-
 	return 0;
 }
=20
@@ -713,13 +644,10 @@ static int get_key(struct wiphy *wiphy, struct net_de=
vice *netdev, u8 key_index,
 	return 0;
 }
=20
+/* wiphy_new_nm() will WARNON if not present */
 static int set_default_key(struct wiphy *wiphy, struct net_device *netdev,
 			   u8 key_index, bool unicast, bool multicast)
 {
-	struct wilc_vif *vif =3D netdev_priv(netdev);
-
-	wilc_set_wep_default_keyid(vif, key_index);
-
 	return 0;
 }
=20
diff --git a/drivers/net/wireless/microchip/wilc1000/fw.h b/drivers/net/wir=
eless/microchip/wilc1000/fw.h
index 1114530d03e4..237ca348d1f8 100644
--- a/drivers/net/wireless/microchip/wilc1000/fw.h
+++ b/drivers/net/wireless/microchip/wilc1000/fw.h
@@ -41,12 +41,6 @@ struct wilc_drv_handler {
 	u8 mode;
 } __packed;
=20
-struct wilc_wep_key {
-	u8 index;
-	u8 key_len;
-	u8 key[];
-} __packed;
-
 struct wilc_sta_wpa_ptk {
 	u8 mac_addr[ETH_ALEN];
 	u8 key_len;
diff --git a/drivers/net/wireless/microchip/wilc1000/hif.c b/drivers/net/wi=
reless/microchip/wilc1000/hif.c
index 71b44cfe0dfc..573750356007 100644
--- a/drivers/net/wireless/microchip/wilc1000/hif.c
+++ b/drivers/net/wireless/microchip/wilc1000/hif.c
@@ -1038,108 +1038,6 @@ static void timer_connect_cb(struct timer_list *t)
 		kfree(msg);
 }
=20
-int wilc_remove_wep_key(struct wilc_vif *vif, u8 index)
-{
-	struct wid wid;
-	int result;
-
-	wid.id =3D WID_REMOVE_WEP_KEY;
-	wid.type =3D WID_STR;
-	wid.size =3D sizeof(char);
-	wid.val =3D &index;
-
-	result =3D wilc_send_config_pkt(vif, WILC_SET_CFG, &wid, 1);
-	if (result)
-		netdev_err(vif->ndev,
-			   "Failed to send remove wep key config packet\n");
-	return result;
-}
-
-int wilc_set_wep_default_keyid(struct wilc_vif *vif, u8 index)
-{
-	struct wid wid;
-	int result;
-
-	wid.id =3D WID_KEY_ID;
-	wid.type =3D WID_CHAR;
-	wid.size =3D sizeof(char);
-	wid.val =3D &index;
-	result =3D wilc_send_config_pkt(vif, WILC_SET_CFG, &wid, 1);
-	if (result)
-		netdev_err(vif->ndev,
-			   "Failed to send wep default key config packet\n");
-
-	return result;
-}
-
-int wilc_add_wep_key_bss_sta(struct wilc_vif *vif, const u8 *key, u8 len,
-			     u8 index)
-{
-	struct wid wid;
-	int result;
-	struct wilc_wep_key *wep_key;
-
-	wid.id =3D WID_ADD_WEP_KEY;
-	wid.type =3D WID_STR;
-	wid.size =3D sizeof(*wep_key) + len;
-	wep_key =3D kzalloc(wid.size, GFP_KERNEL);
-	if (!wep_key)
-		return -ENOMEM;
-
-	wid.val =3D (u8 *)wep_key;
-
-	wep_key->index =3D index;
-	wep_key->key_len =3D len;
-	memcpy(wep_key->key, key, len);
-
-	result =3D wilc_send_config_pkt(vif, WILC_SET_CFG, &wid, 1);
-	if (result)
-		netdev_err(vif->ndev,
-			   "Failed to add wep key config packet\n");
-
-	kfree(wep_key);
-	return result;
-}
-
-int wilc_add_wep_key_bss_ap(struct wilc_vif *vif, const u8 *key, u8 len,
-			    u8 index, u8 mode, enum authtype auth_type)
-{
-	struct wid wid_list[3];
-	int result;
-	struct wilc_wep_key *wep_key;
-
-	wid_list[0].id =3D WID_11I_MODE;
-	wid_list[0].type =3D WID_CHAR;
-	wid_list[0].size =3D sizeof(char);
-	wid_list[0].val =3D &mode;
-
-	wid_list[1].id =3D WID_AUTH_TYPE;
-	wid_list[1].type =3D WID_CHAR;
-	wid_list[1].size =3D sizeof(char);
-	wid_list[1].val =3D (s8 *)&auth_type;
-
-	wid_list[2].id =3D WID_WEP_KEY_VALUE;
-	wid_list[2].type =3D WID_STR;
-	wid_list[2].size =3D sizeof(*wep_key) + len;
-	wep_key =3D kzalloc(wid_list[2].size, GFP_KERNEL);
-	if (!wep_key)
-		return -ENOMEM;
-
-	wid_list[2].val =3D (u8 *)wep_key;
-
-	wep_key->index =3D index;
-	wep_key->key_len =3D len;
-	memcpy(wep_key->key, key, len);
-	result =3D wilc_send_config_pkt(vif, WILC_SET_CFG, wid_list,
-				      ARRAY_SIZE(wid_list));
-	if (result)
-		netdev_err(vif->ndev,
-			   "Failed to add wep ap key config packet\n");
-
-	kfree(wep_key);
-	return result;
-}
-
 int wilc_add_ptk(struct wilc_vif *vif, const u8 *ptk, u8 ptk_key_len,
 		 const u8 *mac_addr, const u8 *rx_mic, const u8 *tx_mic,
 		 u8 mode, u8 cipher_mode, u8 index)
diff --git a/drivers/net/wireless/microchip/wilc1000/hif.h b/drivers/net/wi=
reless/microchip/wilc1000/hif.h
index 77616fc77575..c9740457ed58 100644
--- a/drivers/net/wireless/microchip/wilc1000/hif.h
+++ b/drivers/net/wireless/microchip/wilc1000/hif.h
@@ -151,12 +151,6 @@ struct host_if_drv {
 };
=20
 struct wilc_vif;
-int wilc_remove_wep_key(struct wilc_vif *vif, u8 index);
-int wilc_set_wep_default_keyid(struct wilc_vif *vif, u8 index);
-int wilc_add_wep_key_bss_sta(struct wilc_vif *vif, const u8 *key, u8 len,
-			     u8 index);
-int wilc_add_wep_key_bss_ap(struct wilc_vif *vif, const u8 *key, u8 len,
-			    u8 index, u8 mode, enum authtype auth_type);
 int wilc_add_ptk(struct wilc_vif *vif, const u8 *ptk, u8 ptk_key_len,
 		 const u8 *mac_addr, const u8 *rx_mic, const u8 *tx_mic,
 		 u8 mode, u8 cipher_mode, u8 index);
diff --git a/drivers/net/wireless/microchip/wilc1000/netdev.h b/drivers/net=
/wireless/microchip/wilc1000/netdev.h
index a067274c2014..630b1e85e68f 100644
--- a/drivers/net/wireless/microchip/wilc1000/netdev.h
+++ b/drivers/net/wireless/microchip/wilc1000/netdev.h
@@ -45,12 +45,6 @@ struct wilc_wfi_key {
 	u32 cipher;
 };
=20
-struct wilc_wfi_wep_key {
-	u8 *key;
-	u8 key_len;
-	u8 key_idx;
-};
-
 struct sta_info {
 	u8 sta_associated_bss[WILC_MAX_NUM_STA][ETH_ALEN];
 };
@@ -63,8 +57,6 @@ struct wilc_wfi_p2p_listen_params {
 };
=20
 static const u32 wilc_cipher_suites[] =3D {
-	WLAN_CIPHER_SUITE_WEP40,
-	WLAN_CIPHER_SUITE_WEP104,
 	WLAN_CIPHER_SUITE_TKIP,
 	WLAN_CIPHER_SUITE_CCMP,
 	WLAN_CIPHER_SUITE_AES_CMAC
@@ -132,8 +124,6 @@ struct wilc_priv {
 	struct net_device *dev;
 	struct host_if_drv *hif_drv;
 	struct wilc_pmkid_attr pmkid_list;
-	u8 wep_key[4][WLAN_KEY_LEN_WEP104];
-	u8 wep_key_len[4];
=20
 	/* The real interface that the monitor is on */
 	struct net_device *real_ndev;
--=20
2.25.1
