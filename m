Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F02F18ADA4
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Mar 2020 08:53:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726366AbgCSHxy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 19 Mar 2020 03:53:54 -0400
Received: from mail-dm6nam12on2100.outbound.protection.outlook.com ([40.107.243.100]:45696
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725812AbgCSHxy (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 19 Mar 2020 03:53:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ULg2Olz16TrDTLCs0a7nnrRf2ByKes8s7p6K39vVpV2BTdRdyueeNJtK09e4Nu69XNMdKdqQdb2jMnxn/KrVMJLE1pBDVpce+zv2mMMreFhuK0ZMSPbztZIPAGi//6ZOxT25dDvniGyRGaDWmI7IwXzyu8SFnBl+HGdhr7PB+lcPwDnZgMSGeJmUCgc+WdOIfEwI9QCMSj1d/1sJfYD+bzMt3zumvDG5z0Ap9Qjx0gcDGXOwc/vIDiv6IuuPIYbKlMd4dM/sLbCknZXnusuqRcNKZruQUCtVdGava3qDTSdGH+egkHCCzqx+SlUsV2HHuSPcnRMQcMj43VQnFhAPkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3r0Q4MVRGzNII3MDlnkxSMcbeTuCJpb9CboCrMyEeGc=;
 b=ZGKgPp0D/yXYuHi+IOlZIcROOH88jP2aIxmoeMQuM47oXWsgOzV+iWFqdL29g+W4AwvW8spigtlFrmc6i/jlgl8NAE+ChgQ/DjyjPaK/udYZiFi49ZHJJ5eMDuf2MBr6fkJwJXbFZ2ck1tABLg5APKYOLBhfFRKoHgPAwK4rBcqC63Pv0JAFnKcFhmHYDe6HDmJvTv4C4tJMBsf81fGGoYeahIKww5oqg/iF2+np2m63z5z2Krpi15HEpZ2QJJ6oo0ofWP5g4JdG/JChS2G2uJ2rUrU5FYZGUqm/ebSOhcHPbw8nzS1rmlJrctZtsBeWtqtYjACDfcNGMvALgkSHPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cypress.com; dmarc=pass action=none header.from=cypress.com;
 dkim=pass header.d=cypress.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cypress.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3r0Q4MVRGzNII3MDlnkxSMcbeTuCJpb9CboCrMyEeGc=;
 b=Vax4GU4cWwD4kCKgH1gJCeFpwatUylMLwOx3itgyRvij9mMe1j4k7ueg05SqaH9rg5zxbWCgIsQ9A6pPJqKjpG0h2Rg0Z2kPkAHriCTU2VtrzrjiLSn755Gm+sy1fPEmky2Zhtilaw2NDVd0zoPhQN4bI1mgAQYNiC7GRk6Bg0g=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Wright.Feng@cypress.com; 
Received: from DM6PR06MB4748.namprd06.prod.outlook.com (2603:10b6:5:fd::18) by
 DM6PR06MB4585.namprd06.prod.outlook.com (2603:10b6:5:17::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.23; Thu, 19 Mar 2020 07:53:50 +0000
Received: from DM6PR06MB4748.namprd06.prod.outlook.com
 ([fe80::299a:b6f7:1338:e451]) by DM6PR06MB4748.namprd06.prod.outlook.com
 ([fe80::299a:b6f7:1338:e451%7]) with mapi id 15.20.2814.018; Thu, 19 Mar 2020
 07:53:50 +0000
From:   Wright Feng <wright.feng@cypress.com>
To:     arend.vanspriel@broadcom.com, franky.lin@broadcom.com,
        hante.meuleman@broadcom.com, kvalo@codeaurora.org,
        chi-hsien.lin@cypress.com
Cc:     wright.feng@cypress.com, linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com
Subject: [PATCH 1/3] brcmfmac: support AP isolate
Date:   Thu, 19 Mar 2020 02:53:24 -0500
Message-Id: <1584604406-15452-2-git-send-email-wright.feng@cypress.com>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1584604406-15452-1-git-send-email-wright.feng@cypress.com>
References: <1584604406-15452-1-git-send-email-wright.feng@cypress.com>
Content-Type: text/plain
X-ClientProxiedBy: MN2PR20CA0043.namprd20.prod.outlook.com
 (2603:10b6:208:235::12) To DM6PR06MB4748.namprd06.prod.outlook.com
 (2603:10b6:5:fd::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from aremote06.aus.cypress.com (12.110.209.245) by MN2PR20CA0043.namprd20.prod.outlook.com (2603:10b6:208:235::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.18 via Frontend Transport; Thu, 19 Mar 2020 07:53:49 +0000
X-Mailer: git-send-email 2.1.0
X-Originating-IP: [12.110.209.245]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 22d8547e-fcd8-4114-22ec-08d7cbdaa96b
X-MS-TrafficTypeDiagnostic: DM6PR06MB4585:|DM6PR06MB4585:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR06MB4585309C7FB56AADD1C23C2AFBF40@DM6PR06MB4585.namprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-Forefront-PRVS: 0347410860
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(39860400002)(346002)(376002)(136003)(396003)(366004)(199004)(44832011)(52116002)(36756003)(8676002)(81156014)(81166006)(8936002)(6666004)(956004)(2616005)(316002)(16526019)(186003)(66476007)(478600001)(66946007)(6636002)(26005)(6486002)(7696005)(2906002)(4326008)(66556008)(5660300002)(86362001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR06MB4585;H:DM6PR06MB4748.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
Received-SPF: None (protection.outlook.com: cypress.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mSvl1b5kiG37jQIRaMrHOK/DN1PLIQVRSu53mUq47YVp8XQh8+DL23zRkJZ1fDi286Pl2QhZZ/XkjdmwySGzQTnFszJRl7t5x3kyAfAA8Imi4RMtkJEcN9trOD3//lbdn8EVmHIyswF0cEi2Zr8AHU9t8Au4pVNiLG7QY/Z9Rl9bYydTYrt9avgg6JMVOb/ExgrILnqYJoLFWwv9VT/lsoU/WPZbEUxvXBwAusJC/J/AJCGmNUjTZNHVgKAG9MxM36GYT4dT5XQ0Vndo3qhlBiMRgoVwTy2egMqi92Lo97QLZVx0VhsXtpTaLQw/aXFKbRVNf1dc3Ykkoafn+I7D7aBkRk5pn1MwbsRx2Bp2dKopiGIugyV6Gzh95ueqaAwT6TK/tBcfeAhh7C58upujcznS6dAoo0sUG2E6tSAu1FVeXJe7i/HDDwTDaSK3lAAz
X-MS-Exchange-AntiSpam-MessageData: uKf/ffVAvVQ1OnwYdsXV32uEzWfValYqITrYMgrW/D+pCAXk5BAL0Hm5Vi4XAGZpSqAtDwGSXdag7pzAHS0tSoK979izMo4KZLTif9StW2jV3ADC4a6Wlln4SL3jd4OOpSbWWmS5zn8Z5SP7Jnwyqg==
X-OriginatorOrg: cypress.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22d8547e-fcd8-4114-22ec-08d7cbdaa96b
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2020 07:53:50.4792
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 011addfc-2c09-450d-8938-e0bbc2dd2376
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MwixINFVSwp8x5BxcpvQam+kwlvTk8wLq9VjG8OMZzfvjZP04f4flTOl5DDSENWkCufmqbnuU9Np/PgARP8GAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR06MB4585
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hostap daemon has a parameter "ap_isolate" which is used to prevent
low-level bridging of frames between associated stations in the BSS.
For driver side, we add cfg80211 ops method change_bss to support
setting AP isolate from user space.

Signed-off-by: Wright Feng <wright.feng@cypress.com>
Signed-off-by: Chi-hsien Lin <chi-hsien.lin@cypress.com>
---
 .../wireless/broadcom/brcm80211/brcmfmac/cfg80211.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
index a2328d3..eb49900 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
@@ -5376,6 +5376,26 @@ static int brcmf_cfg80211_del_pmk(struct wiphy *wiphy, struct net_device *dev,
 	return brcmf_set_pmk(ifp, NULL, 0);
 }
 
+static int
+brcmf_cfg80211_change_bss(struct wiphy *wiphy, struct net_device *dev,
+			  struct bss_parameters *params)
+{
+	struct brcmf_if *ifp;
+	int ret = 0;
+	u32 ap_isolate;
+
+	brcmf_dbg(TRACE, "Enter\n");
+	ifp = netdev_priv(dev);
+	if (params->ap_isolate >= 0) {
+		ap_isolate = (u32)params->ap_isolate;
+		ret = brcmf_fil_iovar_int_set(ifp, "ap_isolate", ap_isolate);
+		if (ret < 0)
+			brcmf_err("ap_isolate iovar failed: ret=%d\n", ret);
+	}
+
+	return ret;
+}
+
 static struct cfg80211_ops brcmf_cfg80211_ops = {
 	.add_virtual_intf = brcmf_cfg80211_add_iface,
 	.del_virtual_intf = brcmf_cfg80211_del_iface,
@@ -5421,6 +5441,7 @@ static struct cfg80211_ops brcmf_cfg80211_ops = {
 	.update_connect_params = brcmf_cfg80211_update_conn_params,
 	.set_pmk = brcmf_cfg80211_set_pmk,
 	.del_pmk = brcmf_cfg80211_del_pmk,
+	.change_bss = brcmf_cfg80211_change_bss,
 };
 
 struct cfg80211_ops *brcmf_cfg80211_get_ops(struct brcmf_mp_device *settings)
-- 
2.1.0

