Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B94612E0638
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Dec 2020 07:48:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725818AbgLVGsR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 22 Dec 2020 01:48:17 -0500
Received: from mail-vi1eur05on2077.outbound.protection.outlook.com ([40.107.21.77]:33872
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725785AbgLVGsR (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 22 Dec 2020 01:48:17 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bh+p6AXS9Uy43Rhb5a/kTeahhgIOFQIDROeQOrUjYMjAQO9ZbRXpvROULoIcoB2SfnjwG07TIFZzikAJYYEyVt34CSDvrQwbuDeHZB1f5mkKKwUuPgA6RFrDHro0S5d6jBUPz3TXL09v23P5YjrdNUvBXLkKWcmHQZcnFasOi+sRX2khrTi4bhCo80ZQTuEpElkTjXLVuith+3hdffJdVl2V9J1RQODuN1Oxqzjgu7qczPcpYKP7KQZuIProcAq5o3Sub7FBXCWq+if17uJVHmufWULCJJSURWoGgiYnKlG9Kxrw1ByOCrwRcnP1vyPQLGL8lusIvH5ldOeM5OLIyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PiWtPNKvFQzCgTAyt1jX+NlK43FKFWV+1DrchWjpgg0=;
 b=lNESUVQhQqhX4ArzbfA7A6XMtZKrQgwe/evi+KGsHIvmDWFwK8PixkmsOr8KpL/ATbjc7i0OAVw6kc298hVvUEV/6vHQTcsQy7yMCntZBuvvo3vHZF6ad/NCHoGB+82EQELcMp4gKAcpovmXeiNi3lUkpZHg7BgS5MwQTUVtmISVrKHhSAZ5cZYwVbR8hSGBXlBuse1i4FCAQ4Aovr/9o9hJKQNH4crRHZ9kaZablKwC2VPwhy3eRy+XAFJGy/TWMUCfxXQKrdlmG1WlyjZUHtif4yevUKLFG+1WE42A+cNexVWxwz8xM80Swb4+Ud7pTCFCVZMR30xv2ZVrK4kYVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PiWtPNKvFQzCgTAyt1jX+NlK43FKFWV+1DrchWjpgg0=;
 b=IRcaLcMm+kRg1h+4dDGXBJk8jGbEiHkYxG1WXDAe22vQPKDz5EuNRaPDeJN5LrmSipdIdjIHALxfgc2aSMtaAhItgrn2O49EkrydSuxKbgiqf97wgOSPUcrwcCOb+IBVV6ekRfBsQsBKW1M64FEnwbwziKsycVy2Ux8FCZhgHx8=
Authentication-Results: sipsolutions.net; dkim=none (message not signed)
 header.d=none;sipsolutions.net; dmarc=none action=none
 header.from=celeno.com;
Received: from AM0P192MB0468.EURP192.PROD.OUTLOOK.COM (2603:10a6:208:45::15)
 by AM9P192MB0904.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:1ce::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3676.25; Tue, 22 Dec
 2020 06:47:29 +0000
Received: from AM0P192MB0468.EURP192.PROD.OUTLOOK.COM
 ([fe80::11ec:bf60:fa41:1ff5]) by AM0P192MB0468.EURP192.PROD.OUTLOOK.COM
 ([fe80::11ec:bf60:fa41:1ff5%6]) with mapi id 15.20.3676.033; Tue, 22 Dec 2020
 06:47:29 +0000
From:   Shay Bar <shay.bar@celeno.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org, aviad.brikman@celeno.com,
        eliav.farber@celeno.com
Subject: [PATCH] mac80211: 160Mhz with extended NSS BW in CSA
Date:   Tue, 22 Dec 2020 08:47:14 +0200
Message-Id: <20201222064714.24888-1-shay.bar@celeno.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201221141441.17613-1-shay.bar@celeno.com>
References: <20201221141441.17613-1-shay.bar@celeno.com>
Content-Type: text/plain
X-Originating-IP: [87.70.106.27]
X-ClientProxiedBy: LO2P265CA0176.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a::20) To AM0P192MB0468.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:208:45::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (87.70.106.27) by LO2P265CA0176.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:a::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3700.27 via Frontend Transport; Tue, 22 Dec 2020 06:47:27 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2853835b-7013-4226-c5fc-08d8a6457369
X-MS-TrafficTypeDiagnostic: AM9P192MB0904:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM9P192MB09041A608AE2F09F8FC7A066E7DF0@AM9P192MB0904.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IcACDEcUtma+ey7ws5iIeF4bVzrxfPJe+LhTr5RmYAR8HKWPMjFxYUA1AjYUCE+5tw01aZXFjKPCIl3d61GdXLQcZJ6t89YTbNatdxDIhjmMUWdqElldWwfCmVuQyzuG8e94KUw55zTOX90RtPwhDbRfGXs+IoblPVI408dlQ38zhTcDqurRB/hiBn2JagHJKHg1Xewq9tHmhO20c3G6AeLpiw0/S2vAYpEihRWbqkG7MmB57yJI8qhCfOGi0SBV0diFGv8h6FAF5mLrufhrw/5ShsbIafkH9dUXDQb4vqUA6eP1oploVxHS8TqStoALH5pEs9rGYBwY7YqaWYkqXykQ5DzwG3RuYBu2p3fAFWrCrGcQXfzNFl4WlSJCG5Tvf0prRaa5LGuTg7dmJ/oxPXmb7hb5XcO0hl7Pg23FwIvzlz4wLGOt1i/sN8WK0Zd3GjNWBYxYVUiCTt5HMb4okQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0P192MB0468.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(346002)(136003)(376002)(396003)(39840400004)(366004)(478600001)(4326008)(2616005)(66476007)(316002)(6666004)(66556008)(1076003)(6486002)(8936002)(36756003)(956004)(6512007)(69590400010)(44832011)(66946007)(5660300002)(16526019)(107886003)(8676002)(6506007)(86362001)(2906002)(83380400001)(52116002)(186003)(6916009)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?L30O8P9kgoQLm+vKTZfFyk5SSiMvIyY1A4fdH9O4BM/32lFG1fOZWpyZrR/z?=
 =?us-ascii?Q?S0gfY+vA5gg2rwiIlx/gNoDuubB+c0XzbUy0g+ns4y023ersEadRqKU5R8NN?=
 =?us-ascii?Q?9VhVGejQSNFYtk4O2/zddrKkcaPWfarD9xA9NbY2BU9LQHJrtWB9kFe2ernS?=
 =?us-ascii?Q?sTAYq29os/lLp6BEwnOhtFxcmWeUgO43UvqCVM0oqyK9mltsOFaFOgtwlRys?=
 =?us-ascii?Q?ioiYIfsnyvdcbKlNw+hHGH8wH/GJ1TsX8H335tX/xj7Waw/2WuBLuvZrDma2?=
 =?us-ascii?Q?atOe/jiyzxqdDBlM+2NiDzj+CWWiI+VVLu7IK9CbPmv9Gff1TXQ91RMxIvOY?=
 =?us-ascii?Q?I0wW2gHae6LkYzcFEoFirzZAPGTb+gePDV9LkiWlds6QSI1xcOZNNqnip8Lk?=
 =?us-ascii?Q?znuvnvjXVyeiwRCiQleo6tEPM9QbE5y5t8s8BV1NrWz8BacaANPAOBRtPxPl?=
 =?us-ascii?Q?zKRpktoYRmdNWbbCMFfe6g2wOu8TglAvljcRjuefP1VbXGqjEcJyZp9t89Hm?=
 =?us-ascii?Q?HRrad8d52QfbQtDbMex7oeSeFAO3tiqah9oapEi+e2pvHdYzaiMa0a7YFw5s?=
 =?us-ascii?Q?xXZVxNIPmiMTCam0Q0/AKWjDd7KJW+Ttp29pDOF7xCpG9QS+4VqEf8yvuZgu?=
 =?us-ascii?Q?Nc3Xx5MyH/xiWVNVi1sXAbRQeP5qaRl3A/vLtJqIKyNOk+LDIhl1zqupKDGp?=
 =?us-ascii?Q?M2MXgbx0PQZtxnpXFWIMA9AP3jg9cnbrk+buYPvIj8gzQQEgTg5P3dj4ztdP?=
 =?us-ascii?Q?D/PcMQZZF+HyE7PBltjGso+b0Ztq6/8N57P8IkFgJBXWNH4WgTaTQmnoxyt6?=
 =?us-ascii?Q?K/rBOk+X6qc5uJdxGIi5cyx7s67IrTwyGtyp3ojxxkGmMJjLGTDDpyS/2NG7?=
 =?us-ascii?Q?LuLJX48r9gh5nh02jtvU4GlONSHQDzATj3kznlfqsmMB1biGkYKQxsldFd4o?=
 =?us-ascii?Q?rAasj0zR9hONCi7WF6SLzly6xfO+Bvlyhv0GiqDnuccq6YItBpCzF3KT0kFo?=
 =?us-ascii?Q?Rk8U?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-AuthSource: AM0P192MB0468.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Dec 2020 06:47:29.1131
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-Network-Message-Id: 2853835b-7013-4226-c5fc-08d8a6457369
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fsv8IbdPAvTVlXWn7zp21gr+1KVx1KMXuph2td1Iv5tOBKA4Qg8dwhuKwoK65hRWeEVdrBT3B7N/Fb+H7THlJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P192MB0904
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Upon receiving CSA with 160Mhz extended NSS BW from associated AP,
STA should set the HT operation_mode based on new_center_freq_seg1
because it is later used as ccfs2 in ieee80211_chandef_vht_oper().

Signed-off-by: Aviad Brikman <aviad.brikman@celeno.com>
Signed-off-by: Shay Bar <shay.bar@celeno.com>
---
 net/mac80211/spectmgmt.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/net/mac80211/spectmgmt.c b/net/mac80211/spectmgmt.c
index ae1cb2c68722..9acbf5fab542 100644
--- a/net/mac80211/spectmgmt.c
+++ b/net/mac80211/spectmgmt.c
@@ -133,16 +133,18 @@ int ieee80211_parse_ch_switch_ie(struct ieee80211_sub_if_data *sdata,
 	}
 
 	if (wide_bw_chansw_ie) {
+		u8 new_seg1 = wide_bw_chansw_ie->new_center_freq_seg1;
 		struct ieee80211_vht_operation vht_oper = {
 			.chan_width =
 				wide_bw_chansw_ie->new_channel_width,
 			.center_freq_seg0_idx =
 				wide_bw_chansw_ie->new_center_freq_seg0,
-			.center_freq_seg1_idx =
-				wide_bw_chansw_ie->new_center_freq_seg1,
+			.center_freq_seg1_idx = new_seg1,
 			/* .basic_mcs_set doesn't matter */
 		};
-		struct ieee80211_ht_operation ht_oper = {};
+		struct ieee80211_ht_operation ht_oper = {
+			.operation_mode = (new_seg1 << IEEE80211_HT_OP_MODE_CCFS2_SHIFT),
+		};
 
 		/* default, for the case of IEEE80211_VHT_CHANWIDTH_USE_HT,
 		 * to the previously parsed chandef
-- 
2.17.1

