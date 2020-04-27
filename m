Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45FA61B97E7
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Apr 2020 09:00:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbgD0HAY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 27 Apr 2020 03:00:24 -0400
Received: from mail-dm6nam11on2125.outbound.protection.outlook.com ([40.107.223.125]:31151
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726543AbgD0HAX (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 27 Apr 2020 03:00:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=faSpu96iYRjrltkQfXJ69avcbkjGF1avJYpOTN0AiPwVYgo161uF57Te87R85GwbLBt9wQPkJKloXFYPcb67h1/dk2ddwF6sKASirRrlGcFqpqlVLK2CyqES8nHByONsNUznX/Oi8P/LR1P6+MZczSGgjnN5Kk/S8eDScyUntHdHDp/vvwO6OIQ7YWR4tZCTSsQF5vsdS0fCvUbodbZdKMUNTRTVdhfzTSe/L6nWI19988XkoFkaoekmfeg7Hiw4QqI1eEHR/MgF7mxQdyhiHOsqKRg/omHoZ/LH3YWDcgtGULEJdQu12R8uoc/YYmWKhDvxV6ApD6RORsc9db2J9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KqwLjPBK88ybm5dc3367G4KXqpTmmy3OBaRuJznbLhE=;
 b=Bj59GzmlBr3P4Zqdrey7JW06QkMH7Tns8R8WMwab7t9cVX8JyC/+2EKT66Kl25tZ2bGCtiOTW0u072moHvQe/HXR8N0R7fHgzsPDhk07FraZQ0XDWm3NHFsHx2kAoNFI5q5NroohiSmn222g4gyM3CT3LkSVE6V783uF/s0zQE5B7/a+RpqtMreOoBEk6f1lhtCtcsxt8SMFtEbZAw7TXIUaS+ulGyjO5Z5jJQbuJaUhhWOFU8TSMX03tTgcsq6fiH0cvIe5g6tWhlMlxKNW5bRGk+ArqWnkdBQyKrC0BpmMeesU47gxRS6MpfeDU0jQQ3NbNeT3vrOwELULBGWkwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cypress.com; dmarc=pass action=none header.from=cypress.com;
 dkim=pass header.d=cypress.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cypress.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KqwLjPBK88ybm5dc3367G4KXqpTmmy3OBaRuJznbLhE=;
 b=jh8sZaDajOGtRcuoI4D2Hcm1yEGcSHLz2A9/0JaGR90sU9enpVmnILzvvLhJd7KmtXiyqEh6i3kZl0QU41uIdBiQ7VQzW7p37RDe4+vWsl+oJot3zeJpIHLbP9aYwk0mI6tFvM7++HtQtfozDZsCjI0nLde/OL5508dUO+cAqoc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Chi-Hsien.Lin@cypress.com; 
Received: from BYAPR06MB4901.namprd06.prod.outlook.com (2603:10b6:a03:7a::30)
 by BYAPR06MB4551.namprd06.prod.outlook.com (2603:10b6:a03:42::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.22; Mon, 27 Apr
 2020 07:00:20 +0000
Received: from BYAPR06MB4901.namprd06.prod.outlook.com
 ([fe80::69bb:5671:e8b:74c1]) by BYAPR06MB4901.namprd06.prod.outlook.com
 ([fe80::69bb:5671:e8b:74c1%3]) with mapi id 15.20.2937.023; Mon, 27 Apr 2020
 07:00:20 +0000
From:   Chi-Hsien Lin <chi-hsien.lin@cypress.com>
To:     linux-wireless@vger.kernel.org
Cc:     brcm80211-dev-list@broadcom.com, brcm80211-dev-list@cypress.com,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Wright Feng <wright.feng@cypress.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Chi-Hsien Lin <chi-hsien.lin@cypress.com>
Subject: [PATCH V2 1/5] brcmfmac: keep apsta enabled when AP starts with MCHAN feature
Date:   Mon, 27 Apr 2020 01:59:59 -0500
Message-Id: <1587970803-77700-2-git-send-email-chi-hsien.lin@cypress.com>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1587970803-77700-1-git-send-email-chi-hsien.lin@cypress.com>
References: <1587970803-77700-1-git-send-email-chi-hsien.lin@cypress.com>
Content-Type: text/plain
X-ClientProxiedBy: BL0PR02CA0041.namprd02.prod.outlook.com
 (2603:10b6:207:3d::18) To BYAPR06MB4901.namprd06.prod.outlook.com
 (2603:10b6:a03:7a::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from aremote02.aus.cypress.com (12.110.209.245) by BL0PR02CA0041.namprd02.prod.outlook.com (2603:10b6:207:3d::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13 via Frontend Transport; Mon, 27 Apr 2020 07:00:18 +0000
X-Mailer: git-send-email 2.1.0
X-Originating-IP: [12.110.209.245]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 844efc89-2201-4f22-e465-08d7ea78a5e6
X-MS-TrafficTypeDiagnostic: BYAPR06MB4551:|BYAPR06MB4551:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR06MB4551B6BFF379A395A2AA0DD1BBAF0@BYAPR06MB4551.namprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:826;
X-Forefront-PRVS: 0386B406AA
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR06MB4901.namprd06.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(366004)(26005)(8936002)(81156014)(8676002)(52116002)(7696005)(86362001)(956004)(5660300002)(16526019)(6916009)(186003)(36756003)(498600001)(6666004)(2616005)(66556008)(54906003)(4326008)(6486002)(107886003)(2906002)(66946007)(66476007);DIR:OUT;SFP:1102;
Received-SPF: None (protection.outlook.com: cypress.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vw4t2I6fmFPoWd6gcjLGnxpUL+yKdhS3jLq46km5Knym9GLQymcaS2L4GX565CZI3NvrdXBGRkw7/F2fdPoPOW7ffyp5An3IHOgEvvzoB3vsJhtUUQrElcS26Sf4E/jim9gFflL7QhyqtDG/3CY9DyXvQ8pQFTWFQyc8XTuAjUbatTVoBN1WbxMVAKrKHjabNrKWOfzAkImaqtfZJD9ZXlWZbJb+w41IyQJi//0AYeYBT6xLv5G3omzhi0wmo+gynAA7WfEBc9FWYLLGZeseX+H5VXreuXLomz3Edwt64ZCQ0V4zxDNBKlN9Sm+RstGAqp+dMBEryTU2TrFGpntGtumF0ML29tZsUmdzX5V71RwuMH/2R39yXKwjGef2GdNU2I6QLP+nUjVavOPxu6lNjDGicEQMHX49/J/z6ecGIo6kwNn5k2YQNgXQJgD6plu4
X-MS-Exchange-AntiSpam-MessageData: p92H2yKyy/f4QdysXyVg4yMnnh6DGzujQSvLaPTk4Zd+346pGwBJ2CBblS5gJK6saAHX+qxtFh3sAK/Lxf1xShV4ri7/3YdSfNIN/aQ340XlD642Tg1vjB5kYf8cTQ/DopLnIZen/VnRsZgxXZX3BJSPe3ZSo68zOXAjF7TCw3V1KqR7AvwQnzK4JqjHG3GnNYx4WemsfHLThxd0yEpxQe/geI+5qd5mF4oM15nGl2jOEgz0Qb21CBd/SfV8t5rOkHowXp2GfadEVA7vUBQy88PigEM8YN48P2EX+o06OySVjiwzSu/y9gPzUn6/rUGdNuCBtDpyf+Wtal78OYMxtcC+uolnS8cYNWu7cUOvR2P6G7ZqZTM69LLeEksh6TLIvReHl1uWoBZPbHH09lagfVjcZ9fjBYYXDLilczKMPKgC9tYycpzJ6hWbDdA8jgNdkfs4Os9gA6zPgqYMh9xqwuSxidXko58L53oZdKb0hprV1inQXm2cdggx3sunPdABZCWyTS38kJKgUUlQ/4QIg8ajVIHXunJdB1jM/hZJjfwx64yELC/oZmg7bTea52pr2guf4hMHplh+1ZPc9ZEpaHxuovO+BlmIzxB8ULcwqj2HCYvslu9qWUJi2tSTw+dZoLAlevG7N4Ypmg7s2JEgHTG8bG4XjYJhe+F1PHA40qQl7z1ZMulLQexashpEwaDstORyGu0LqY+nU8WzcvoOuyA9kZH8EeSoD6NrXp72a3sJHGhcUSRzM50aEz2l+w7xvGqyCJgfqJeqj+GSR8gi8bNDITr349P1WCDpF1MfqKI=
X-OriginatorOrg: cypress.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 844efc89-2201-4f22-e465-08d7ea78a5e6
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2020 07:00:20.2588
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 011addfc-2c09-450d-8938-e0bbc2dd2376
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SeOBTS+CnTVJZ9NFrg24Jdku3LC+VVC7Gkiy+I3uh1N0BKfgirHiok42PuLAWX4E6JNwX6Ht6cHv6Ki1bjn0TQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR06MB4551
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Wright Feng <wright.feng@cypress.com>

When starting station mode on wlan0 and AP mode on wlan1, the apsta will
be disabled and cause data stall on wlan0(station). The apsta feature
with MCHAN(Multi-Channel Concurrent) or RSDB(Real Simultaneous
Dual-Band) can make STA+AP work on two bands concurrently.
Because of that, we keep apsta enabled if firmware supports MCHAN or
RSDB features

Signed-off-by: Wright Feng <wright.feng@cypress.com>
Signed-off-by: Chi-Hsien Lin <chi-hsien.lin@cypress.com>
---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
index fa846471dac2..e54f6fa6dc8f 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
@@ -4727,7 +4727,8 @@ brcmf_cfg80211_start_ap(struct wiphy *wiphy, struct net_device *ndev,
 
 		if ((dev_role == NL80211_IFTYPE_AP) &&
 		    ((ifp->ifidx == 0) ||
-		     !brcmf_feat_is_enabled(ifp, BRCMF_FEAT_RSDB))) {
+		     (!brcmf_feat_is_enabled(ifp, BRCMF_FEAT_RSDB) &&
+		      !brcmf_feat_is_enabled(ifp, BRCMF_FEAT_MCHAN)))) {
 			err = brcmf_fil_cmd_int_set(ifp, BRCMF_C_DOWN, 1);
 			if (err < 0) {
 				bphy_err(drvr, "BRCMF_C_DOWN error %d\n",
-- 
2.1.0

