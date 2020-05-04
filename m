Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE5B31C326F
	for <lists+linux-wireless@lfdr.de>; Mon,  4 May 2020 08:09:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726578AbgEDGJD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 4 May 2020 02:09:03 -0400
Received: from mail-bn8nam12on2092.outbound.protection.outlook.com ([40.107.237.92]:14944
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726410AbgEDGJC (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 4 May 2020 02:09:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UwMoRXgIEWbsBe9hxbHiRCRLvZu3zlLXXy+hnCKEdwjTxR9nPWQvF65d2Hpba099j+7ZL32QvSgjcEakZwbtr5rx57oN+IdBZxq8V84heHJm2URZ4F+AG027S/m8/jyyaujOSCBDGeZ6aFHUTqXdkjXhJ/pcG5RXTfoBiXvUHsoOL4TpRjay8PCasJSp3Qdv00AMEHRd1wUx5yGq8hbSoxJBKC47kqgIWjz8kioT01jCdWvpIJY3DkQrndm4YTeE/MConjKfpcuPmA+8RqFMJbwKbAcG6Iw9CUvEDQLVPRkMKdTfuJdMSz7IOZahcpcVV/H+cEhEOnjb9GzagERUIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xt7FX1Grz18H29crfJNZ5W6boKUb/aV+ztGherQr3D8=;
 b=N0xu00o0rstwNOQTknj+EupxY8+4kcB8qVKfSIsQeXLXr894gWp/l+uusXD+zaRe93OZumikRVBIuSthB909GF3dqHiWzFlrudITrtvMWWM1/EHK32TYYq7LdafxXuTFcVt5THxmG6pGYyuaSWjc39EW3OnSUN0Dhr/B2tiEYn468+rMXVg4tWAx2qgFE1606ZaDk0HDHSLZjMdfr0uaNpS6ZdAqKkRwb8Kq7wzZP9s83AoPj+MvLZbIDEbqOF1kPVLmcmhmASbgwH0pCn8nFmQUzBYtmbLAyfqKm2rSeJzjn144eywK8WvkAg/i8sO2Xpdf6RxulSxB7nxpj9ab7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cypress.com; dmarc=pass action=none header.from=cypress.com;
 dkim=pass header.d=cypress.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cypress.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xt7FX1Grz18H29crfJNZ5W6boKUb/aV+ztGherQr3D8=;
 b=KWPtJzzYwADm0jMEAsFeI9ZPHvFZv+dwv0BJIHEcLlkka/qoOVW0w7SBrE80GeDpBOKp5Be/XqUn7rIgtPCkyKeS50m2dn07TbKSJOPqrYRKp16X30ZDqkrgdMvBdIqqhTsYxfG8Bh+Uz3soX4qIyjtpRoKg/YK7DJSvx/HwafE=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=cypress.com;
Received: from DM6PR06MB4748.namprd06.prod.outlook.com (2603:10b6:5:fd::18) by
 DM6PR06MB4283.namprd06.prod.outlook.com (2603:10b6:5:1e::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2958.29; Mon, 4 May 2020 06:09:00 +0000
Received: from DM6PR06MB4748.namprd06.prod.outlook.com
 ([fe80::ad0b:eda4:4eb8:b8d7]) by DM6PR06MB4748.namprd06.prod.outlook.com
 ([fe80::ad0b:eda4:4eb8:b8d7%7]) with mapi id 15.20.2958.027; Mon, 4 May 2020
 06:09:00 +0000
From:   Wright Feng <wright.feng@cypress.com>
To:     linux-wireless@vger.kernel.org, chi-hsien.lin@cypress.com
Cc:     wright.feng@cypress.com, brcm80211-dev-list@broadcom.com,
        brcm80211-dev-list@cypress.com,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Kalle Valo <kvalo@codeaurora.org>
Subject: [PATCH 1/3] brcmfmac: support the second p2p connection
Date:   Mon,  4 May 2020 01:07:31 -0500
Message-Id: <1588572453-194663-2-git-send-email-wright.feng@cypress.com>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1588572453-194663-1-git-send-email-wright.feng@cypress.com>
References: <1588572453-194663-1-git-send-email-wright.feng@cypress.com>
Content-Type: text/plain
X-ClientProxiedBy: MN2PR01CA0061.prod.exchangelabs.com (2603:10b6:208:23f::30)
 To DM6PR06MB4748.namprd06.prod.outlook.com (2603:10b6:5:fd::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from aremote02.aus.cypress.com (12.110.209.245) by MN2PR01CA0061.prod.exchangelabs.com (2603:10b6:208:23f::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.19 via Frontend Transport; Mon, 4 May 2020 06:08:59 +0000
X-Mailer: git-send-email 2.1.0
X-Originating-IP: [12.110.209.245]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3755ff32-c665-43b7-dbff-08d7eff1a305
X-MS-TrafficTypeDiagnostic: DM6PR06MB4283:|DM6PR06MB4283:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR06MB4283B37442A8149B80937A66FBA60@DM6PR06MB4283.namprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 03932714EB
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lLXk9ohww6ZvaYNLL7eqsIP75vLr64CvoUL87qyWfWjThojDq0w7pVRsZS3W1yo3EC571rKGEZ897eLJshk59E2bXj5Hjsiq6Py4HoCxQIxIQrsn094jwG6iIV5uEfiuwXJ7J9f9+W0N9yLCMpQgCFaX51pB1/LYnr6xEQvYKapATbZdSxWxMaY0ZSBJhzbxuT1L4HFNvQUU7+r4Et0hPgLQ5FIqEmpXGFT9MjuMm4NpDCL3MAegXUaQHtxLrz6fBOAWQsXs0CDS7yHfGKoN98OBF8HBnMtknxoJSkP87ZuPYD/9kzfSAEAmrjVc4CIenG/8WkauYkefkBcitQXcC/2tfddJr7z9iNgbt6fBVRKz5R8Pm1hb0/xKX/B0sT42rtZtFsl3VaKPNOyh7BAs8EhbEscMlyR6rJYtbQb8vMZjEPEEQ0REj5UqBRFjmZYu
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR06MB4748.namprd06.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(396003)(39860400002)(366004)(136003)(346002)(376002)(66946007)(66556008)(16526019)(186003)(66476007)(2906002)(26005)(44832011)(7696005)(36756003)(86362001)(52116002)(2616005)(956004)(6636002)(8676002)(5660300002)(8936002)(6486002)(316002)(4326008)(54906003)(478600001)(6666004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: 0OE+ElbIOHtjc+3zDqWfQZaNv7M2z991PakYEd1jA4ncscMq43XT4r4HP0jSe8nffFaRp1aTJyV2qfV78EsVRgiueYvP9EZHTeBqwHOIolv+OdZegw8/XFpzhCNr4LKNr0qDg67M9PMe16BSENfvcJojyfXqza922SEh6Xjfnj4qpa3tBF6Qay/ylITVdwajzFhrWX7dVtWEHoMrA1BoeQn63IHl034eija4ZbNef50w6xFHl8f6r5NyTnbFoWliKCEWTwlX52u/t+IIY9YBQ9BpfwoaEgZM37QJ2aBRp03QIH3c11sFMWOOWley2aXj8YqGabz16UrYTGW90aeerlThepOtWfFT9jiRRDYwpGMWXCM9VR5FdceEUgZ2B67o3J34zF+BxG4EzLug+RfZsT9vZoLfqgZWlxgkgGwyuae1NoJmgdItRF7LciZ+FsWpyz5yZgzaS2bpUVaEHzexsVrIqshl6sHLiZymB7sYN1p9KtyLwcljcyz+jWCMJWJzk3tHJt5eB3MECj26M+YKEgma9AfG25s7tjjrfvOtE8mrXgaGct9NZTRgtazo9XdJakDFZo+9fhmxu/LW/rY0l6ebxl+boR9vW3ARWL1hZ52Kni6TwzPHJMcQ7hyzf5dHvtTMlncUU+hPM4l288lUwnuHZo3flec6t7zFDFs49vdEzq9mqUeaoeGtORY/3vfpKu+VirwtjUEil28Vbctddi8t/3yW4dvfUPXEJrvtsqaaux1UtSko3z6ruYbKHI47eGZBogERbp/mW3t7LFXNCfR4sTWVPVXaepsXAKB25k4=
X-OriginatorOrg: cypress.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3755ff32-c665-43b7-dbff-08d7eff1a305
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2020 06:09:00.0539
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 011addfc-2c09-450d-8938-e0bbc2dd2376
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pcUKFmCv/4qBA5R8APpdeKe3A6V8CGKgTDEqLN2rTQVqtIEodjAjEJH7tkza15UkFT1m7v4Njj29qq1dGq+i/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR06MB4283
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

With RSDB feature, firmware is able to support two P2P-AGO or two
P2P-GC at the same time. So we add the second p2p connection type
to map to the second P2P connection bsscfg.

Signed-off-by: Wright Feng <wright.feng@cypress.com>
Signed-off-by: Chi-hsien Lin <chi-hsien.lin@cypress.com>
---
 .../net/wireless/broadcom/brcm80211/brcmfmac/p2p.c | 56 ++++++++++++++++++----
 .../net/wireless/broadcom/brcm80211/brcmfmac/p2p.h |  9 ++--
 2 files changed, 54 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c
index 1f5deea..521b507 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c
@@ -17,6 +17,7 @@
 #include "fwil_types.h"
 #include "p2p.h"
 #include "cfg80211.h"
+#include "feature.h"
 
 /* parameters used for p2p escan */
 #define P2PAPI_SCAN_NPROBES 1
@@ -474,9 +475,13 @@ static void brcmf_p2p_generate_bss_mac(struct brcmf_p2p_info *p2p, u8 *dev_addr)
 	 * BSSCFGs need to simultaneously co-exist, then this address must be
 	 * different from the P2P Device Address, but also locally administered.
 	 */
-	memcpy(p2p->int_addr, p2p->dev_addr, ETH_ALEN);
-	p2p->int_addr[0] |= 0x02;
-	p2p->int_addr[4] ^= 0x80;
+	memcpy(p2p->conn_int_addr, p2p->dev_addr, ETH_ALEN);
+	p2p->conn_int_addr[0] |= 0x02;
+	p2p->conn_int_addr[4] ^= 0x80;
+
+	memcpy(p2p->conn2_int_addr, p2p->dev_addr, ETH_ALEN);
+	p2p->conn2_int_addr[0] |= 0x02;
+	p2p->conn2_int_addr[4] ^= 0x90;
 }
 
 /**
@@ -1994,7 +1999,7 @@ int brcmf_p2p_ifchange(struct brcmf_cfg80211_info *cfg,
 
 	if_request.type = cpu_to_le16((u16)if_type);
 	if_request.chspec = cpu_to_le16(chanspec);
-	memcpy(if_request.addr, p2p->int_addr, sizeof(if_request.addr));
+	memcpy(if_request.addr, p2p->conn_int_addr, sizeof(if_request.addr));
 
 	brcmf_cfg80211_arm_vif_event(cfg, vif);
 	err = brcmf_fil_iovar_data_set(vif->ifp, "p2p_ifupd", &if_request,
@@ -2149,6 +2154,27 @@ static struct wireless_dev *brcmf_p2p_create_p2pdev(struct brcmf_p2p_info *p2p,
 	return ERR_PTR(err);
 }
 
+int brcmf_p2p_get_conn_idx(struct brcmf_cfg80211_info *cfg)
+{
+	int i;
+	struct brcmf_if *ifp = netdev_priv(cfg_to_ndev(cfg));
+
+	if (!ifp)
+		return -ENODEV;
+
+	for (i = P2PAPI_BSSCFG_CONNECTION; i < P2PAPI_BSSCFG_MAX; i++) {
+		if (!cfg->p2p.bss_idx[i].vif) {
+			if (i == P2PAPI_BSSCFG_CONNECTION2 &&
+			    !(brcmf_feat_is_enabled(ifp, BRCMF_FEAT_RSDB))) {
+				brcmf_err("Multi p2p not supported");
+				return -EIO;
+			}
+			return i;
+		}
+	}
+	return -EIO;
+}
+
 /**
  * brcmf_p2p_add_vif() - create a new P2P virtual interface.
  *
@@ -2168,7 +2194,9 @@ struct wireless_dev *brcmf_p2p_add_vif(struct wiphy *wiphy, const char *name,
 	struct brcmf_pub *drvr = cfg->pub;
 	struct brcmf_cfg80211_vif *vif;
 	enum brcmf_fil_p2p_if_types iftype;
-	int err;
+	int err = 0;
+	int connidx;
+	u8 *p2p_intf_addr;
 
 	if (brcmf_cfg80211_vif_event_armed(cfg))
 		return ERR_PTR(-EBUSY);
@@ -2194,9 +2222,21 @@ struct wireless_dev *brcmf_p2p_add_vif(struct wiphy *wiphy, const char *name,
 		return (struct wireless_dev *)vif;
 	brcmf_cfg80211_arm_vif_event(cfg, vif);
 
-	err = brcmf_p2p_request_p2p_if(&cfg->p2p, ifp, cfg->p2p.int_addr,
-				       iftype);
+	connidx = brcmf_p2p_get_conn_idx(cfg);
+
+	if (connidx == P2PAPI_BSSCFG_CONNECTION)
+		p2p_intf_addr = cfg->p2p.conn_int_addr;
+	else if (connidx == P2PAPI_BSSCFG_CONNECTION2)
+		p2p_intf_addr = cfg->p2p.conn2_int_addr;
+	else
+		err = -EINVAL;
+
+	if (!err)
+		err =  brcmf_p2p_request_p2p_if(&cfg->p2p, ifp,
+						p2p_intf_addr, iftype);
+
 	if (err) {
+		brcmf_err("request p2p interface failed\n");
 		brcmf_cfg80211_arm_vif_event(cfg, NULL);
 		goto fail;
 	}
@@ -2228,7 +2268,7 @@ struct wireless_dev *brcmf_p2p_add_vif(struct wiphy *wiphy, const char *name,
 		goto fail;
 	}
 
-	cfg->p2p.bss_idx[P2PAPI_BSSCFG_CONNECTION].vif = vif;
+	cfg->p2p.bss_idx[connidx].vif = vif;
 	/* Disable firmware roaming for P2P interface  */
 	brcmf_fil_iovar_int_set(ifp, "roam_off", 1);
 	if (iftype == BRCMF_FIL_P2P_IF_GO) {
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.h b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.h
index 64ab9b6..d2ecee5 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.h
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.h
@@ -14,13 +14,15 @@ struct brcmf_cfg80211_info;
  *
  * @P2PAPI_BSSCFG_PRIMARY: maps to driver's primary bsscfg.
  * @P2PAPI_BSSCFG_DEVICE: maps to driver's P2P device discovery bsscfg.
- * @P2PAPI_BSSCFG_CONNECTION: maps to driver's P2P connection bsscfg.
+ * @P2PAPI_BSSCFG_CONNECTION: maps to driver's 1st P2P connection bsscfg.
+ * @P2PAPI_BSSCFG_CONNECTION2: maps to driver's 2nd P2P connection bsscfg.
  * @P2PAPI_BSSCFG_MAX: used for range checking.
  */
 enum p2p_bss_type {
 	P2PAPI_BSSCFG_PRIMARY, /* maps to driver's primary bsscfg */
 	P2PAPI_BSSCFG_DEVICE, /* maps to driver's P2P device discovery bsscfg */
-	P2PAPI_BSSCFG_CONNECTION, /* maps to driver's P2P connection bsscfg */
+	P2PAPI_BSSCFG_CONNECTION, /* driver's 1st P2P connection bsscfg */
+	P2PAPI_BSSCFG_CONNECTION2, /* driver's 2nd P2P connection bsscfg */
 	P2PAPI_BSSCFG_MAX
 };
 
@@ -119,7 +121,8 @@ struct brcmf_p2p_info {
 	struct brcmf_cfg80211_info *cfg;
 	unsigned long status;
 	u8 dev_addr[ETH_ALEN];
-	u8 int_addr[ETH_ALEN];
+	u8 conn_int_addr[ETH_ALEN];
+	u8 conn2_int_addr[ETH_ALEN];
 	struct p2p_bss bss_idx[P2PAPI_BSSCFG_MAX];
 	struct timer_list listen_timer;
 	u8 listen_channel;
-- 
2.1.0

