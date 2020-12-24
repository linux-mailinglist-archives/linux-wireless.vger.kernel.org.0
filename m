Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 654402E25FE
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Dec 2020 11:55:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727778AbgLXKxF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 24 Dec 2020 05:53:05 -0500
Received: from mail-eopbgr150049.outbound.protection.outlook.com ([40.107.15.49]:26884
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727641AbgLXKxE (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 24 Dec 2020 05:53:04 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gKOnj/dX8o+rKDBzygnL7FjS8UKJTK8gXsRS2gF8SBtX7kfI1nsfqJKwFOEgTC/h/BUxMSEjtfDt3BA0t63XlAT3YuHRt4drkaSE/qaUKXw00D6TmstqpYGylVtJTTDfUf8tfofGJQLKHn4LIq6Re0BBu1lveaBnA/rjRnraOoYQlrQ9HTmS5LWkXzPDF9sFqWV08CIa4WIwWkx3QGKjkt6EFdR/gtu81tASuk83GyTXKpn5FbyGeJRc00H8B90Or8u/T2pFyw4lz+reFePCpKWc4wQQGP7M+c7V+S5l2q7jt93GTdG5R9Ki20exi+d3nC/omIlOjE6yunAxGZwPPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sr2fc6xGEI++N96F0QOqhnljDJQrdkPSd4ueBVZ4I+4=;
 b=Gsr6Hup/vUYPelZXG63D+cmXf7MrK+MLRNJz7mETCIGOPq79y1lb+hzr8zAgwcwlRcvY0WmJRYoJeg2ogvG1Fpct1wOu5KmqRVH4WolFXsJxh3+jI/5BB/P1+m4yJBad//KPTfwG3P8wbL6xi2QfLsiUeiA52V18uoS5Lv8sB5OE55Vp8/S/KK/NbJgHBRvW+3QD6s9KSpR3bRzyxnr8uGa0m0rGtXY9M1391r7cc+GFQXjWpjDaNwL2lsvxx4iu6rbNpXHLeo0BoPEksR+7c5SpRMk0oIhznU0yb5725szJWVNpV0GEgvQ8zwdCm9oiugeAtMWUhVu50FeawQWvEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vimar.com; dmarc=pass action=none header.from=vimar.com;
 dkim=pass header.d=vimar.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Vimargroup.onmicrosoft.com; s=selector2-Vimargroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sr2fc6xGEI++N96F0QOqhnljDJQrdkPSd4ueBVZ4I+4=;
 b=PEfa2qd9E5/4LafuwTedeE+aiJyW1yTvjOd4pUVx+LYvXgNEZDb0OucXQAI0njiX85NnKoHRK6YOiJCgyvkXK5t9LW+jnStNuoa7xibFr4JQ6fnk66Qb9sCXa00SrDgO293JQSJVdSuAwXb3zXlqLEPZ4DsWGjbYBdqSMX6MSqE=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=vimar.com;
Received: from VI1PR08MB3231.eurprd08.prod.outlook.com (2603:10a6:803:4a::12)
 by VI1PR08MB2784.eurprd08.prod.outlook.com (2603:10a6:802:25::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3676.33; Thu, 24 Dec
 2020 10:52:15 +0000
Received: from VI1PR08MB3231.eurprd08.prod.outlook.com
 ([fe80::c8ee:1d00:addf:b775]) by VI1PR08MB3231.eurprd08.prod.outlook.com
 ([fe80::c8ee:1d00:addf:b775%7]) with mapi id 15.20.3700.028; Thu, 24 Dec 2020
 10:52:15 +0000
From:   Luca Pesce <luca.pesce@vimar.com>
To:     linux-wireless@vger.kernel.org, brcm80211-dev-list.pdl@broadcom.com
Cc:     Luca Pesce <luca.pesce@vimar.com>
Subject: [PATCH] brcmfmac: clear EAP/association status bits on linkdown events
Date:   Thu, 24 Dec 2020 11:51:59 +0100
Message-Id: <1608807119-21785-1-git-send-email-luca.pesce@vimar.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-Originating-IP: [83.103.125.100]
X-ClientProxiedBy: ZR0P278CA0013.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:16::23) To VI1PR08MB3231.eurprd08.prod.outlook.com
 (2603:10a6:803:4a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (83.103.125.100) by ZR0P278CA0013.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:16::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3700.27 via Frontend Transport; Thu, 24 Dec 2020 10:52:14 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e6f3a3fe-e6b1-4196-481d-08d8a7f9f9c5
X-MS-TrafficTypeDiagnostic: VI1PR08MB2784:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR08MB2784FB71FEB0DBABFE6E24CF81DD0@VI1PR08MB2784.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DlmMzYnFfrxF/6T7aiasaTds7ga7i8kX+Srl8mgOA0s/ZFalvoSFP8ELqXuQN08rdD7aay9yPFZ7saHvZvDogWmskQJJy0eZsET3amUP2wAYVQpgX7PJt9mJ3MwZLNQeQAlwJSNFThALcvcbUa8Ll0/jS8MmGwciOBDbqcidRr6ByDfm4OiVCmkrjN+FfjQUGAVTZq9/zeknolGcTTfAV5i+fD9Y0RQEV0VoD9VJlfDmhmQnE9U4Uw/Kxsaa50OJOGuI21MYtoLg+1WL1+Gd8V9Z1HXnvbEgsGtnGaNgIgriqfp5/YCIpWTzvt7u83aY1Rnl/xmsMNTezwdp1LHT2C1QRmaFwnpEGojGmaW3lZvCLZaEghE5XsiU9r9RqRFYEEx3VdIajyxwJhdoApJTzwGt6Ny1TZd3mIvJB24jcF8TFonXXtjZ0K7tYLWRaLQPJJEw2aSjPmJf7Gc8aUZC9A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR08MB3231.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(376002)(396003)(136003)(39850400004)(186003)(66476007)(8936002)(6486002)(6512007)(66556008)(2616005)(86362001)(8676002)(6666004)(4326008)(44832011)(316002)(52116002)(5660300002)(2906002)(69590400010)(956004)(16526019)(83380400001)(36756003)(107886003)(66946007)(478600001)(6506007)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?prukzs6YR7G4DWpLJ8d3MV8QLHXBNonohJwY9xo23b4ImRoj7pxJrMJG+kGl?=
 =?us-ascii?Q?hK8EZsz651qOo7WuQBsb0gwG7+Zg/Nd7DrSX3wEtdBiXvh+BRhbLyCe5No8+?=
 =?us-ascii?Q?81E29MZxmVcFf44xnEAZQoSY0CNH2YLgSgesSXIPbJ+aJWkOUXAVxjUpSfPI?=
 =?us-ascii?Q?zliU+Xd7rRNUsmMSWBruJqlazWZdJlmOtobqK3vpfq64QznkmweXHxKRQ7xj?=
 =?us-ascii?Q?B+likPzziFXhaUYKXyhxyuGdvilXCp4vTae/APSWAmZ9j/xJcB2L4DBGJPF6?=
 =?us-ascii?Q?BE7nwEZwdjXu7kVm9O73H3nh9n92jarEDFSkahPkLpgWwfJspp8GZLult7hT?=
 =?us-ascii?Q?OmvGuCUzn9Ef1Eo6NGWqI638XYQrcK22+hDiEFuboVWqWl7cMefzWxvumSS1?=
 =?us-ascii?Q?lCw9hldEMNWycwoUnJkkV9oslEr1BMTuQdc/G190Aih936RaIFAgabIRTdp4?=
 =?us-ascii?Q?GvvPD4mVt6IvXD9LBTgCjaIBoQbGCRfKVhKJqqUIbbtH8Mty3kKvjHGpfnS/?=
 =?us-ascii?Q?0XovdgCIwofiBnaUiFCjYxBpvjn1AcLYHdkncHyPF4vma2yZsAvFhP866xHn?=
 =?us-ascii?Q?EocMaxndJIlZ90JH0wyJyEI1ToPg0WWFiMJlpQQWr2AOX+DaU+vSg4jGsTJu?=
 =?us-ascii?Q?3ESUZ+dk0m9NQt5dTCjI683SCKGKyUV9kGOlEmOscjmUwkJi2NOMWRhsGL5T?=
 =?us-ascii?Q?BG8CSjZ8qfbsUxeQCxOWnjn2EJernwVwDfIb614ICtCuMNkyHvDo5SXV66m2?=
 =?us-ascii?Q?BmNy0mLCZbgmQREBHUq8hE3mChA13RUXbPgFUnuTyl7TW3BnLCYo9KLVm+w9?=
 =?us-ascii?Q?zcsENndPTWiu3LhKLPyoNfmIjodjGjQRM/29zd5HdkIseFLTs3JOAQwTnG7U?=
 =?us-ascii?Q?ZYJ+b6aJyCQbnNhn4Rhl8i/cabQYkSG5aTLZU8sg4CK2RxtweSz2PXV3fj4J?=
 =?us-ascii?Q?zw0/4qNapQRTaYlNFQ+mgNQZWkUkTmf4lqFdX12wlNOOvCJSv7szAmdqXAQE?=
 =?us-ascii?Q?iLe7?=
X-OriginatorOrg: vimar.com
X-MS-Exchange-CrossTenant-AuthSource: VI1PR08MB3231.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Dec 2020 10:52:15.1196
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a1f008bc-d59b-4c66-8f87-60fd9af15c7f
X-MS-Exchange-CrossTenant-Network-Message-Id: e6f3a3fe-e6b1-4196-481d-08d8a7f9f9c5
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JiL6lC62Rqo8ROrKGBgR7SdlbOXHqZYFzcj/z0EZBA1gcI3Jkdne7AyupWxWFFLXsVqdBfWm6O64P5qgssES9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB2784
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This ensure that previous association attempts do not leave stale statuses
on subsequent attempts.

This fixes the WARN_ON(!cr->bss)) from __cfg80211_connect_result() when
connecting to an AP after a previous connection failure (e.g. where EAP fails
due to incorrect psk but association succeeded). In some scenarios, indeed,
brcmf_is_linkup() was reporting a link up event too early due to stale
BRCMF_VIF_STATUS_ASSOC_SUCCESS bit, thus reporting to cfg80211 a connection
result with a zeroed bssid (vif->profile.bssid is still empty), causing the
WARN_ON due to the call to cfg80211_get_bss() with the empty bssid.

Signed-off-by: Luca Pesce <luca.pesce@vimar.com>
---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
index 0ee421f..23e6422 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
@@ -5611,7 +5611,8 @@ static bool brcmf_is_linkup(struct brcmf_cfg80211_vif *vif,
 	return false;
 }
 
-static bool brcmf_is_linkdown(const struct brcmf_event_msg *e)
+static bool brcmf_is_linkdown(struct brcmf_cfg80211_vif *vif,
+			    const struct brcmf_event_msg *e)
 {
 	u32 event = e->event_code;
 	u16 flags = e->flags;
@@ -5620,6 +5621,8 @@ static bool brcmf_is_linkdown(const struct brcmf_event_msg *e)
 	    (event == BRCMF_E_DISASSOC_IND) ||
 	    ((event == BRCMF_E_LINK) && (!(flags & BRCMF_EVENT_MSG_LINK)))) {
 		brcmf_dbg(CONN, "Processing link down\n");
+		clear_bit(BRCMF_VIF_STATUS_EAP_SUCCESS, &vif->sme_state);
+		clear_bit(BRCMF_VIF_STATUS_ASSOC_SUCCESS, &vif->sme_state);
 		return true;
 	}
 	return false;
@@ -6067,7 +6070,7 @@ brcmf_notify_connect_status(struct brcmf_if *ifp,
 		} else
 			brcmf_bss_connect_done(cfg, ndev, e, true);
 		brcmf_net_setcarrier(ifp, true);
-	} else if (brcmf_is_linkdown(e)) {
+	} else if (brcmf_is_linkdown(ifp->vif, e)) {
 		brcmf_dbg(CONN, "Linkdown\n");
 		if (!brcmf_is_ibssmode(ifp->vif) &&
 		    test_bit(BRCMF_VIF_STATUS_CONNECTED,
-- 
2.7.4

