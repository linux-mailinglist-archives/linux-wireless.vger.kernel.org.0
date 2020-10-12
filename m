Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45A0E28B083
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Oct 2020 10:45:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727350AbgJLIpa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 12 Oct 2020 04:45:30 -0400
Received: from mail-eopbgr770139.outbound.protection.outlook.com ([40.107.77.139]:16993
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727340AbgJLIp2 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 12 Oct 2020 04:45:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gt4ss/OAe1kTp6COikZ3WaBW5ELbAGN+jPo+cAlqepspWjQlQWf88WSenDtGtUP4dyiCyzStTnYXHQajbCPeAMJNxxEpAQiBMHrS+AaJIMlUZOzOxKVEZ904Lq0SaO+E0ioNNj+tVCw+9jvWHkig4lGADe1jPe+F9R9Doay/Hw9scQGZ0NcFyPOdKJvk3T9ihD0SpgUxnxtJO/vcfT/4ryz8Vv3s1ctgem+JUotycOXnZFOtXa74fyemJBIXmBhAxu4Gl8EbSeq1SkrT4AKINpXWwTVp55bIQoUe50A+gohtMiWwRug2m7Grx4NaavwEyo0h8bE2ZGKIsRn5oRQ+Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J/8VzsGcyFzrDSaoJaEzhFpbDgVLu/UwLq0ORiHsnCk=;
 b=JTdpIBdEex4e90bEFlYJN6VdmE1Xj3Se2zyFsIWT3blzF715mznVF8tbARtnKE9px+vp63t7P2wvzWJ9+7SgpcC5xvr2mCjCVCVE6W4p2ISvVgm4kEnRMfB4OIR3lkXrbiro8I7h85yQKqCjX4GClASK7aYEjBESacsyMJZdzm2Nq5OBtWEk7u6xYqKA1AM1zfqoVg/L4xMWuirAXOgRegSGPkxj4kEw3tw36h/tD3XnUbI8BpVaHTt3TqYta/1Hy5CwIXYF0TXUpAFbu0eu68my3EP7YZ09NNRIk2x+nmIyLtB/FbMWlK4nHElci7WC2aFdWfXGs5MPgPI6lMAUpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cypress.com; dmarc=pass action=none header.from=cypress.com;
 dkim=pass header.d=cypress.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cypress.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J/8VzsGcyFzrDSaoJaEzhFpbDgVLu/UwLq0ORiHsnCk=;
 b=Ernz1b4I7lljLDKPUZWUtU3PEASLdGhPuqzAvgPua5YOLOkm4NrtznpInf7RJ0MxeDScM3gB2134IEPEvNehLd/Fip+tn49E50OR8z6FPlGW+n46SjyHy8DsRrgvHjTGAtSFQgLamF3yRBPFqcyhI50AkqhpeiPA9UOCz9IrTxQ=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=cypress.com;
Received: from BN8PR06MB5889.namprd06.prod.outlook.com (2603:10b6:408:c2::25)
 by BN8PR06MB5380.namprd06.prod.outlook.com (2603:10b6:408:63::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.22; Mon, 12 Oct
 2020 08:45:16 +0000
Received: from BN8PR06MB5889.namprd06.prod.outlook.com
 ([fe80::14ee:f61:60a2:1e48]) by BN8PR06MB5889.namprd06.prod.outlook.com
 ([fe80::14ee:f61:60a2:1e48%5]) with mapi id 15.20.3455.029; Mon, 12 Oct 2020
 08:45:16 +0000
From:   Wright Feng <wright.feng@cypress.com>
To:     linux-wireless@vger.kernel.org,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Kalle Valo <kvalo@codeaurora.org>, chi-hsien.lin@cypress.com,
        Johannes Berg <johannes@sipsolutions.net>
Cc:     wright.feng@cypress.com, brcm80211-dev-list@broadcom.com,
        brcm80211-dev-list@cypress.com,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Kurt Lee <kurt.lee@cypress.com>
Subject: [PATCH v2 1/2] ieee80211: Add definition for WFA DPP
Date:   Mon, 12 Oct 2020 03:43:46 -0500
Message-Id: <20201012084347.121557-2-wright.feng@cypress.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20201012084347.121557-1-wright.feng@cypress.com>
References: <20201012084347.121557-1-wright.feng@cypress.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [157.95.12.33]
X-ClientProxiedBy: MN2PR04CA0033.namprd04.prod.outlook.com
 (2603:10b6:208:d4::46) To BN8PR06MB5889.namprd06.prod.outlook.com
 (2603:10b6:408:c2::25)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from aremote06.aus.cypress.com (157.95.12.33) by MN2PR04CA0033.namprd04.prod.outlook.com (2603:10b6:208:d4::46) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.23 via Frontend Transport; Mon, 12 Oct 2020 08:45:15 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 92187c76-06ce-4ad4-53b7-08d86e8b2419
X-MS-TrafficTypeDiagnostic: BN8PR06MB5380:
X-LD-Processed: 011addfc-2c09-450d-8938-e0bbc2dd2376,ExtAddr,ExtFwd
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN8PR06MB5380ED317DD3A0E5299FBEBEFB070@BN8PR06MB5380.namprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1079;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lxaEtR8m3eiTWbYu0rQoxvdm3gmchkzSa17w3XL+QCm3Qawsf89awImFNc3xfDWSVfh5UEFeo7TNCvEuHjvAwbM5f4W/CvxJkI5Juij18rYMJZCvQvXjus4ArIfXZhY98okcOCUvIN1iHFDyhUNqzpOVade41skjTjMXzEe1vh6Um89y7WL3krSaP8GgD4Vl/IT68Ohsp+0uCiRBQZ44ZP6OYNZ6kGYgkbxlfvKoyEPgkgH7W+y2kKKwtWRgTECh1ofVDpJkSGp+y4VsJH0hlJhVFxahHwTKpTxfn2lzcE0CZpzKxBgO8BFvFF9M7+t3
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR06MB5889.namprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(39860400002)(136003)(346002)(376002)(2616005)(956004)(4326008)(86362001)(316002)(16526019)(107886003)(52116002)(7696005)(5660300002)(26005)(186003)(8676002)(44832011)(8936002)(6666004)(36756003)(66946007)(66556008)(66476007)(6486002)(2906002)(45080400002)(1076003)(478600001)(110136005)(54906003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: K84T5vPyZJPh1grkHMP2V7/J5rvfL6nSq1z7Z3Yn8u4vWKwgmDHCnGSCprM9sFAbJOfrlTFPGTR9W+el9Ddqey4jep/bx6Vfi86MkI4IDC4vLof3wasOwxJcdUidbjIqW2DDL+lXxFzlGB8HwUkUVdZ7mjenUKMyRBK+VYD0hxnHXwgoBHeeUugCSgB+SmXr3o+cOV3nWp7I/kCtTj/BhykXIdzI0Ntyt6AzHXTCeDT1xap4tCt9sN1DHPf+4hNvvFq0UksRCAmF7fHgK1LP98i7OrIf3d6cHJaUyBP+LXLMzLlI/EYq057rVXuQVxp0QO2a0wLGWmKOJp91t6HjPIlQlxb6xo9XJ+pqhB92BCOXLCEV0goeRo8kSXJfw44GZCGI2UDTy+fK/pAj41sOB5tkdcfMG84yaWIoex1bTChrvBjJSjX+NpF2CySyx5tcZcux30T/41HeA3s6i7UoX3HlrBVvIrvuwPQ28oLr4BtY503nhR4feYmedHuw5Cq9aQ/tfMIgph2+h3nger8PBB7uVogxg1kHV0DufsCAMZHgZO4H6nlDa3ikpAj6oPSWwYHnkcQx0pNJYr2scG17C3LSdb4RDqHAVhSUs4BW93TmeyuWotYSjpOZnDi60n21IN+pAhdA+jOXHM+UUTzaOg==
X-OriginatorOrg: cypress.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92187c76-06ce-4ad4-53b7-08d86e8b2419
X-MS-Exchange-CrossTenant-AuthSource: BN8PR06MB5889.namprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2020 08:45:16.1892
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 011addfc-2c09-450d-8938-e0bbc2dd2376
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9w2vnw4d5qrjGBMuGVkKjuKnaYky7e3wF/SSDotxKMh6VbLISdHyVXPFHGsju+4UIvCYXb7znE7ZgCYeiBX/fA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR06MB5380
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Kurt Lee <kurt.lee@cypress.com>

Add Wi-Fi Alliance definition for DPP (Device Provisioning Protocol).

Signed-off-by: Kurt Lee <kurt.lee@cypress.com>
Signed-off-by: Wright Feng <wright.feng@cypress.com>
---
 include/linux/ieee80211.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
index 770408b2fdaf..5e8cc9c3d45a 100644
--- a/include/linux/ieee80211.h
+++ b/include/linux/ieee80211.h
@@ -3417,6 +3417,8 @@ struct ieee80211_multiple_bssid_configuration {
 #define WLAN_AKM_SUITE_FT_PSK_SHA384		SUITE(0x000FAC, 19)
 #define WLAN_AKM_SUITE_PSK_SHA384		SUITE(0x000FAC, 20)
 
+#define WLAN_AKM_SUITE_WFA_DPP			SUITE(WLAN_OUI_WFA, 2)
+
 #define WLAN_MAX_KEY_LEN		32
 
 #define WLAN_PMK_NAME_LEN		16
@@ -3427,6 +3429,7 @@ struct ieee80211_multiple_bssid_configuration {
 
 #define WLAN_OUI_WFA			0x506f9a
 #define WLAN_OUI_TYPE_WFA_P2P		9
+#define WLAN_OUI_TYPE_WFA_DPP		0x1A
 #define WLAN_OUI_MICROSOFT		0x0050f2
 #define WLAN_OUI_TYPE_MICROSOFT_WPA	1
 #define WLAN_OUI_TYPE_MICROSOFT_WMM	2
-- 
2.25.0

