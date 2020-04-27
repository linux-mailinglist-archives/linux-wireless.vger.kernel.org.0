Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1A161B97E8
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Apr 2020 09:00:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726748AbgD0HA0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 27 Apr 2020 03:00:26 -0400
Received: from mail-dm6nam11on2125.outbound.protection.outlook.com ([40.107.223.125]:31151
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726496AbgD0HAZ (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 27 Apr 2020 03:00:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RuFPalVqOg7vlwXOUsMq3/KruTKs0+NKiBtUsf7mwblS+Ao5gTFIknn70fPZLc83kf09Wf0WeUe8Nkyfh63k7bNNc2e0gPDAoG7SqyounHBX7l/UFLQ2/iL9wdUHkLgff37TZf0mq5sglsPeMP7OL8UslI+yXiQAxqIwKpfQZ700MQBYvHAiex/atyvezYQsuI1d582ZYWv/u0xZ0ibdNMXLmsr4PGWlOqWbTkcTGcavaPU7mZxsjhM3qCtQquD6zs0c5cSp9rHSxDaktcZVU334LkIxOTcW/Vb1Sky3MLinNUNjqdGbpcFrRQYwG0rNfQWA+oMaG6lI7Rn6aRB7CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ET6Zh2pGHh/e+G9ZxeuXYCFW3jDs0SwOZuY4mZhQVWE=;
 b=ng/QXC7zzEdRaAcR0LcbIcteXFFFbHeFRQG4vNJhNFLP1s1KbmguiJPGqoTolSxpUpDxLVoq/0uQ1U+GPG3BcVUbsW3Dfvpp4lnXAycVPtlyV9m6cH9HJbrTpIle3Q+2Yo8xQUffo4N/GKjere2xBXpkB9I7CuFS9r/HbMMln1DTXuyIFc+eK2xyY38RvM7nFafVuiMGjWvHhR3rdVOmdV45qVyzbCM9o57VNbX5DNB86co+RJYrgfAT5ilI3n33XD1W5+A6nJ6cXalTIXdCyTI6Qb0727i0DHVgZOOXziQjCRYvSprXSE3B1UnNbnVD052UWwSOXKenOpQgnpVkTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cypress.com; dmarc=pass action=none header.from=cypress.com;
 dkim=pass header.d=cypress.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cypress.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ET6Zh2pGHh/e+G9ZxeuXYCFW3jDs0SwOZuY4mZhQVWE=;
 b=IumRBgHV1FvjN+W76kCBi20o2VF0JZ0jOxGSWEwg+OLjBomjWOUKkKnORqszqVIOVLzgUyNFEtoUaCoj+4PVKgUXLzxOhVY/KG7xXIhluSCAD5OgefRV777uWWw+K3GOW6XuEcZvyX/c5PP/MhTj39FXrYIWjSc0zJPCGmOaz2w=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Chi-Hsien.Lin@cypress.com; 
Received: from BYAPR06MB4901.namprd06.prod.outlook.com (2603:10b6:a03:7a::30)
 by BYAPR06MB4551.namprd06.prod.outlook.com (2603:10b6:a03:42::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.22; Mon, 27 Apr
 2020 07:00:22 +0000
Received: from BYAPR06MB4901.namprd06.prod.outlook.com
 ([fe80::69bb:5671:e8b:74c1]) by BYAPR06MB4901.namprd06.prod.outlook.com
 ([fe80::69bb:5671:e8b:74c1%3]) with mapi id 15.20.2937.023; Mon, 27 Apr 2020
 07:00:22 +0000
From:   Chi-Hsien Lin <chi-hsien.lin@cypress.com>
To:     linux-wireless@vger.kernel.org
Cc:     brcm80211-dev-list@broadcom.com, brcm80211-dev-list@cypress.com,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Wright Feng <wright.feng@cypress.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Chi-Hsien Lin <chi-hsien.lin@cypress.com>
Subject: [PATCH V2 2/5] brcmfmac: remove arp_hostip_clear from brcmf_netdev_stop
Date:   Mon, 27 Apr 2020 02:00:00 -0500
Message-Id: <1587970803-77700-3-git-send-email-chi-hsien.lin@cypress.com>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1587970803-77700-1-git-send-email-chi-hsien.lin@cypress.com>
References: <1587970803-77700-1-git-send-email-chi-hsien.lin@cypress.com>
Content-Type: text/plain
X-ClientProxiedBy: BL0PR02CA0041.namprd02.prod.outlook.com
 (2603:10b6:207:3d::18) To BYAPR06MB4901.namprd06.prod.outlook.com
 (2603:10b6:a03:7a::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from aremote02.aus.cypress.com (12.110.209.245) by BL0PR02CA0041.namprd02.prod.outlook.com (2603:10b6:207:3d::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13 via Frontend Transport; Mon, 27 Apr 2020 07:00:20 +0000
X-Mailer: git-send-email 2.1.0
X-Originating-IP: [12.110.209.245]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2d351952-2827-4f94-6fcf-08d7ea78a70e
X-MS-TrafficTypeDiagnostic: BYAPR06MB4551:|BYAPR06MB4551:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR06MB45510C4211CE78BCB9864020BBAF0@BYAPR06MB4551.namprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 0386B406AA
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR06MB4901.namprd06.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(366004)(26005)(8936002)(81156014)(8676002)(52116002)(7696005)(86362001)(956004)(5660300002)(16526019)(6916009)(186003)(36756003)(498600001)(6666004)(2616005)(66556008)(54906003)(4326008)(6486002)(107886003)(2906002)(66946007)(66476007);DIR:OUT;SFP:1102;
Received-SPF: None (protection.outlook.com: cypress.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1m06YsTID/1rkQaeFxj0tBF+sr+Uuu/BOHrMOt/3QVjwOlYR/OMD8pOJAGwCfgtKarIeAdFUr8G4r1WuJ63KH10Lpqi4OpGqJxbx8P//5/BRuiFrbjbfEPHAPfvy204xUVDypEOHywg4XhyDvGbtbNbZafRwDj1GwP+Bb8ZFSnFV/ng2Teko4AadnmSBAt19dyalMzdXOx4weJu+8Wxx1W4SbjFf+NW85jn08SaQ/SVQij/gtU6R26/rjd/yF1AqwbReBWCIKOKM+eGhwaoLDUfugsSG1HGkDm10+zFOxBFJC+1vPghsl646BVCUPPWi/R6tlVv6reCcO/bVcXpeEKVzMt8/3ibP8ye7Y/VatVKop3FFjxrQHlsFYBRLUZ9aB8MggZ4vQaXaI/PBYCWONjWFFnRbbP7CeBVhfisusH7tVq3ZqYzUG85FkC+5gA+e
X-MS-Exchange-AntiSpam-MessageData: 0AEhp5lHv+JR9yIXuimrfNuwLnjX9ujNB3gWqiq7Tg+cqSktP76woigIq+X7QupR2UFuAxdBb4XpYuX2g007/eCL8WvSUEQQMiKuUGCDBEKChdUYSE6iIzOstTjDNUyWW2x/IbWGpeSICbG9H7+6F4kbaAilMkjwDk4Vvd1k3yhyzfHOuhN79Q0nWbL2bAtBnMhNaoEB33WjLuj8Vy+NmOQpsM5vqYZq04FQ54F0i2mzV634T8ZkqRdluYk1/qWOl4PCBbkpBMAd8FF2m0nLX/JFUfVGZE0wxjrxx4slcc93iZiT8nugEot//gshRYXnKvGLNL8pCU6HWqFPnV3+zyttTut0OGTTVLM6fFdb8wXuYkmdUOXKADnp9FRTKPdc6na6VIG3EB+RmBs/7nwA2vD5HuDZFu2PBPVcyqZAGj4wgJ2HJAgorwprlQVwjc/PkY2OB9lmQDFprmvaYpgYyjGoW7Rgmex4gBhOF7xPceiWxIrUdWTeuqZutBzEyMlvTax7KaaO6JAiT1T56aazIm8ztMg/1zN8F4xtps4FABNnyv4DY7SgQF7fObmtbGoAuNyCaaNHmfabVyHVn4TYiJnXpGr3bv1ztyrE7fJPfr9TQJ2L9k/OIk0bqk3rHaN+KHKtEGT6lUScI0O40NHkR7mB406XrZFKOUV4+v17cOigyrRhsrRH8O3TG7bfxOQw1yAxwoCnUBV92wnvmj5c6OD/qjJ4iTGCYhajyeSckvZinDon6A4F8tQ1kK9ZbAPhNIyUc/OyRseEYOcWhg9TUAcuBZC3WAXk/DIcInNuOwg=
X-OriginatorOrg: cypress.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d351952-2827-4f94-6fcf-08d7ea78a70e
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2020 07:00:22.1467
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 011addfc-2c09-450d-8938-e0bbc2dd2376
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rBkFlj1SXmu5P7Wtney2R6qmXvjtk2i38OQLgj4m/c15a7ahCQuTGDBY9XEEGnBa8+yEu97DXX180LQjcXWv8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR06MB4551
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Wright Feng <wright.feng@cypress.com>

The firmware does not respond ARP request and causes ping failure with
following steps:

1. Bring up interface
   ifconfig wlan0 up or start wpa_supplicant
2. Set the IP address
   ifconfig wlan0 192.168.100.10
3. Bring down interface or
   ifconfig wlan0 down or kill wpa_supplicant
4. Bring up interface again and set the same IP address
5. Connect to AP(192.168.100.1) and ping to AP will be failed.

FMAC clears arp_hostip when bringing down the interface, but not set it
back if setting the same IP address. We are able to see the IP address
in interface info(inconfig wlan0) but the ping still cannot work because
the firmware ARP offload does not respond the ARP request.
Because of that, we remove "arp_hostip_clear" from function
"brcmf_netdev_stop"

Signed-off-by: Wright Feng <wright.feng@cypress.com>
Signed-off-by: Chi-Hsien Lin <chi-hsien.lin@cypress.com>
Reviewed-by: Franky Lin <franky.lin@broadcom.com>
---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
index 436f501be937..c88655acc78c 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
@@ -579,9 +579,6 @@ static int brcmf_netdev_stop(struct net_device *ndev)
 
 	brcmf_cfg80211_down(ndev);
 
-	if (ifp->drvr->bus_if->state == BRCMF_BUS_UP)
-		brcmf_fil_iovar_data_set(ifp, "arp_hostip_clear", NULL, 0);
-
 	brcmf_net_setcarrier(ifp, false);
 
 	return 0;
-- 
2.1.0

