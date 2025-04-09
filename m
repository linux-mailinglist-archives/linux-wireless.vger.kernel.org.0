Return-Path: <linux-wireless+bounces-21299-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5ACBA81BB3
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Apr 2025 05:50:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD2EA7ADA1E
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Apr 2025 03:49:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93A161A5BA4;
	Wed,  9 Apr 2025 03:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-sbell.com header.i=@nokia-sbell.com header.b="P8AMOa+H"
X-Original-To: linux-wireless@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2089.outbound.protection.outlook.com [40.107.22.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D3B442C;
	Wed,  9 Apr 2025 03:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744170625; cv=fail; b=PPFwSpFJB4hosrE+wvkj75ALIext+EDzU8KUtVOTsNRAxooA18WhUUT0dKVxo0NQKe5bmCH+aGWqaqCpOppDZYjLsAXv9ALKokGTberiSfa9v/6LrKU2Fk5LV9Yu9yGXUC17RcUj9fLTvMoJ3c7uW/MF0JuoUJ2YvAMI4eop3f8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744170625; c=relaxed/simple;
	bh=KNnkSeu9FNYBpzT3ejQZK1+ZYe32FmfN3tFN1mtbHdw=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=SubtVU26qaOH8sytX0RIx9IouNErLLWk4y+hM0+IsTwQDWKJVeft7EhGGi4CeGhdoTTpbZ13dFFejXq5uc6mUrPqe/7JBfnm9mqC+/X1ENii8ZvtitHamk4l5u1W/cO2nlLk7+6pAzulU0G5pbPtJxs8pR5e118+M7q3WvKthjU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nokia-sbell.com; spf=pass smtp.mailfrom=nokia-sbell.com; dkim=pass (2048-bit key) header.d=nokia-sbell.com header.i=@nokia-sbell.com header.b=P8AMOa+H; arc=fail smtp.client-ip=40.107.22.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nokia-sbell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nokia-sbell.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q6RqunQR+eY08iVK2Us9IcHU7tsHHEvKHqNznfk51byKm4noRVLpEWEf+0ypYBkXqNmfBDlY8T5YAQiChQZ+8lJ6ECQd9eq1L5alIsTHnrXkgVohYPej4q3M4L6/yl4AnluO0wmIara1M3Q33RfDZS7sRtCWf59P2IDphHPlyQEmWCO6spAZ/aZAEYXpoZM/oCKN9fWhQUsSfdYVZxLNAkkkcZKbjofdc2V/obJUco0dxqMHA/iJ5aVL05PJGUqMhTKZgy08LwW0pD00uignkmqRXJRD0QcRBoDwlO89nu7pozNJ3Kym1PWuvWb6e+vuA0BYF8ezQp/dUTez4pyEOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RprUxYaDZeN4FIreFIiFk7b9FifCTeYYUbXL6CSl2KI=;
 b=MWxwv0nOecvJQLzeCK5J5dEVHgFSUqgzs5SgvG26mJDu9+q9RBU3Mwqfyp7vOgI8J84Z9wpNTqKgZspx1QHfEfznAQWacPC7PTSkiHkQVnIOa9WKZxsKzssNAao7pHAFQPUDtmsqcB/FiCS8/NOpN4ckW9nNa8XarKgUv4xmzMWluGWtt8iy8PeJ+uV3cFuiWuWbQIs2PdG69UfRNj+9RJJzpDOpqgX5AIzQs9a71XEOcqwMEx+yIbVI06UeVnT3DJV6WTfa6HyNoLSPoXKCA945FNZhWjiqHnMBQ2ZGGx9KRHv01dal8hbW74/ChA0QyCkHZh5K9ghkOcgqOrublA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia-sbell.com; dmarc=pass action=none
 header.from=nokia-sbell.com; dkim=pass header.d=nokia-sbell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-sbell.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RprUxYaDZeN4FIreFIiFk7b9FifCTeYYUbXL6CSl2KI=;
 b=P8AMOa+H8vlXQ93Ob33eHWcZsGty+ES6z9DN+/VlDapkX0oGmjCxYjb/HVRdPwYTYYtxH6x8QOK4jIQN2llBhSCBXYXp/99Mw8v/srgm4hY7z2sSGBt+two16iDhTBZ1Noc++/XwIOEpGPRxYN3XJAQ/YmZnaqxdlvrTzCUqRWmPh7DXd+64T1C7jypQfmTC5eVgDrHfFcjv5xXzStf24FvEEyVD7z9U6BBVoMHnqK4OYI8pBrtAmpSZ80Z4EPfoXjAhmg4/7uV8wXqedRzxbE+8bBywLwBjt0g507aKqJnnTuuSH02XokjRukOXD1/kRyHPQ15yE2iXq7dL+syOBQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia-sbell.com;
Received: from AS8PR07MB7478.eurprd07.prod.outlook.com (2603:10a6:20b:2ad::20)
 by DUZPR07MB9862.eurprd07.prod.outlook.com (2603:10a6:10:4e2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Wed, 9 Apr
 2025 03:50:18 +0000
Received: from AS8PR07MB7478.eurprd07.prod.outlook.com
 ([fe80::6bac:2863:7f96:b6b0]) by AS8PR07MB7478.eurprd07.prod.outlook.com
 ([fe80::6bac:2863:7f96:b6b0%4]) with mapi id 15.20.8606.033; Wed, 9 Apr 2025
 03:50:18 +0000
From: Zhen XIN <zhen.xin@nokia-sbell.com>
To: linux-wireless@vger.kernel.org
Cc: pkshih@realtek.com,
	linux-kernel@vger.kernel.org,
	martin.blumenstingl@googlemail.com,
	Zhen XIN <zhen.xin@nokia-sbell.com>
Subject: [RFC -v2] wifi: rtw88: sdio: Tx status for management frames
Date: Wed,  9 Apr 2025 03:49:10 +0000
Message-Id: <20250409034910.1637422-1-zhen.xin@nokia-sbell.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0011.APCP153.PROD.OUTLOOK.COM (2603:1096::21) To
 AS8PR07MB7478.eurprd07.prod.outlook.com (2603:10a6:20b:2ad::20)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR07MB7478:EE_|DUZPR07MB9862:EE_
X-MS-Office365-Filtering-Correlation-Id: d6f23aae-3a38-4e4a-b985-08dd7719a4cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?w/id9oCB6VovmIr/nOv/8uq3wYRUhhGJenqdkroFHcvDEVTQafnLu/I7R/+F?=
 =?us-ascii?Q?Q6jdszuwj/1x8fUOurnRfbOdEIYPSMXncpEOtEkBDqWIHOtiUwrfEUSHxg8Z?=
 =?us-ascii?Q?W6l/l4VZuwagbQWezkWXPspC8uypYO6IeUOrQ29ehgLHB+8oXR404Lfsyi6P?=
 =?us-ascii?Q?Q+280tSKVDJsbdc4rNXFruNgBWP87X2J4+00vek3KRaV7iOGUE4MOBcMfzIe?=
 =?us-ascii?Q?Ib2uynukvxHQr49uWklhVrINMAB+yWQRIwQkoxtGLbb/W4vPqxmOLPi0135J?=
 =?us-ascii?Q?EWfqZi1dFcS4602sqIEowrEGStNNXu9FA8jFeMmnmxdGF0bQb0Q+Bhb5edbE?=
 =?us-ascii?Q?R1v8wzQWTvlnjKeQA8mjoenk/xW/yAYkKkquumCsa684fPOry4sh9u7vytAc?=
 =?us-ascii?Q?RJa1AVznUfCoEwYzeYMd6Y89SMl5dtF//hl+vDPzXK6JlOQhBqLazcf1wxBz?=
 =?us-ascii?Q?yfXi2jZA3Vb5kjxlabLWUq0TkyhF7oZO87WvKPP7E5+kWqZ7TGjzGqGaoNnO?=
 =?us-ascii?Q?k1T2ETlV7KXzN8VmapZNb9rcD38GpkTA34GmQhl9W9SLYE07nBA/sscmQ3th?=
 =?us-ascii?Q?qDoe4sRi6RDM3eu/+3WlEuyb94Q9wCvh/F9sMPT/5bjx4hI3smjk3rjXWe/Y?=
 =?us-ascii?Q?Ns2UmpBH+pCARo9jB85ZdCAzdKSrPb1YNKAIn/ch6diPSIBh34pxzdS2QQcY?=
 =?us-ascii?Q?cC+Od9lVqA2zQNfoXNP1gkoYVKUw4RaWvLFcSro0sB0Yc/W39x6H69MQB4OT?=
 =?us-ascii?Q?ZX/FmEauSEujmgifwG/tM4KYSxq97LhQUB0933GoAjteo3IQkfS5n7vP70BV?=
 =?us-ascii?Q?hx3OYlNeb/PI1kjYYQE1R2kKR5pFj7MjynuGS0ga/eYztjmCbyEJDOSUuIzR?=
 =?us-ascii?Q?wGNYzafHlQQfyGeyLg7GqrsDl6+h+99LXwgdlI4TWYghBC4hn3fxdOBrqj2/?=
 =?us-ascii?Q?wDeb2aPVlcuPTpuivX9WbykbuU8ZwjlmeheJUwOOYjNDoU98irVD4FUWOULX?=
 =?us-ascii?Q?OjxPKW6mK6F2iAtRj1HR8CdmSLRL0Noh0h0AUaZHIx9FDZ+nQKcJEhUjsVXN?=
 =?us-ascii?Q?5yFJ/cOEgL+QnJeoxW710z3LNBot/8PZd+3omQCBaeCWgyk07JpaMhY1Hqy3?=
 =?us-ascii?Q?yTI0eE13uc0UpO0AHEek9R6ObdvokZ0dRuIo058xSnZKSyPY4J9qs1R0CPTb?=
 =?us-ascii?Q?eckfwNwq7CvbRkzOGCnc2o/bx1OO7LNQkLBkVpigI2SQH/8rcoyj+xPCfysL?=
 =?us-ascii?Q?/QisJ9hKFuwAz2FMgJo91So93QRpTbjeyx9ZftAec6XtYCrWtWS/tlWQTQt2?=
 =?us-ascii?Q?2SDvR22LPPBDXOtg2hm58ZVrac++40q8mBTr7Jjbunkq1vd1WiqcwGJMRtCN?=
 =?us-ascii?Q?7kZRXNjp5J15FL5wtIerrkJTgdEOSReEJnSr9+0sULDJrZWzMQ4PlxUkiOg4?=
 =?us-ascii?Q?GGbRyZevy3M=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR07MB7478.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?n92mhnsXHeKZQ4q1/MeNLgsswi6VqesUlqultKDdpUtYNQ2UDPbzYN1nfrvF?=
 =?us-ascii?Q?XVR8czFT/e0im55Oluv9fVdawf413KbEFAK5P61YVPcFq8JkJGCcp7W4kGil?=
 =?us-ascii?Q?coL6wnbhJOQDNVJxJXi+h0/iCmd0hPE6pES1sK+fBRSbDL8gkvgjFoTO80cG?=
 =?us-ascii?Q?JaNDDg+1DT8f9h9U91h9HJz402pJLiax1x0B78QjvXEXJ9JE5RNZ1WupgBjR?=
 =?us-ascii?Q?llPaX9gjKgyLPD4Y5QKrGf8nxkyQt4X9ohK7jXGo72ftRrFEFv3VH3o5+9zd?=
 =?us-ascii?Q?Z8QWkb0f5v1GWUyWm1ZUuB/yViL5OsduHL5efThRkzgC8RFkoburBrx0F459?=
 =?us-ascii?Q?l8FFHCy4VR57DJEBOojEzO4+3BR1zX0QmU4HmlySi97hlX/34USPYqBmX/U6?=
 =?us-ascii?Q?Qp6nxjRJM7+FJMGEdmCQQitcNvTUJpDsC9aRhwKGyJXgjtZ6spOw8TtpWB1q?=
 =?us-ascii?Q?7V8fUglmUAG3QHuVg8mXrDMdd7FQfSY2q6RAfXMILDPhzQRJ9g6uoJlvWMJP?=
 =?us-ascii?Q?/dn2XNe6/X5/Ei71Fko2/+QAvFoF/MU25Sw1pfEB+Hf/xzt/XIIlqK1ormE7?=
 =?us-ascii?Q?bb9qP9aFxCmHSgd+lwiPZLcdxeYOTcF13SbylDCm2e1eM3OV3vlZeh6+JRJ2?=
 =?us-ascii?Q?LalAPlMLQM4nVdXU+NlhFBwCHsS+7/+rqKfTYRFppgICrvWAFEHrS7OfdAy7?=
 =?us-ascii?Q?VGElKlLAyKxKLF3MXL+3qMfEaNuuo7gx9tLpPDW3q9kIW0G1jubXa5/lDUVG?=
 =?us-ascii?Q?KLbiws9vc0z+ZKEuo0znq6QAt8Z2Kwdcgq9KxJ2+WszzrQ8M1HvUAZHD6wVL?=
 =?us-ascii?Q?+/whtlQEcob1WpXgyBJXWTnsVg1Wc4g+a9grc2fRCRYyIwsKs5OK5gxCr1Qy?=
 =?us-ascii?Q?7Bx2H7K/3t+iVvjmVwbdW4ibkKz/LFoWvG7MacQxAqCg9g7TZwiwuEcvYVpV?=
 =?us-ascii?Q?haTYiVXONySiMQfWp6AMmuEGuI9alq6Cr6mjDXC7RdWfZd3+IQUikoshESaa?=
 =?us-ascii?Q?T5DEa+0u0+J95FE/CXzprHiBlWzL1NUp2MhNSa29jlaspJiva/xGNKnJCqMR?=
 =?us-ascii?Q?ysWTtEEWCeaQD5o8r7kay90ClQ0RZD4TqHzP1cXF5EGRswiFisrqwrrplTP7?=
 =?us-ascii?Q?6wa5L3XutkXhlbGe4eB9Iz/uK6FxqWTxqwrK82HEJeGklTSzPe+CnH3shqdy?=
 =?us-ascii?Q?Pj9Tus1VlVJhtDtIO8A1aZKaoYmqOfmc1uq4y/SE0e0m5wsp7qmyK+zRyzzi?=
 =?us-ascii?Q?LpixtGfGRMFELIeQYYKfYkYgkGM8vErLenJDQUCd/etEFXmjKnTMO+d1/BnF?=
 =?us-ascii?Q?M7sg9wtXUp+CTlX5Xj45e0x9iq2esLQu3P4nPWxoueYBNU3mwq0RO+uaX9Os?=
 =?us-ascii?Q?02OXjz0ouFPYtLZVGmxU1aefWiDf2Unl4+WVwpAWsK08W9mWOCWzD50GxCLP?=
 =?us-ascii?Q?qBAssb+14xYsijXCCduUJYqMZy6/0yEO04mjLtPmlZtbcmw6iljk4YG3xmXZ?=
 =?us-ascii?Q?35hHJ5fzqy2s86GJQKQM83MVmA2XMM+Pk+PNHnM1/rPD81TP9eIpJBFcNXKx?=
 =?us-ascii?Q?/DoWA+YWSgQB6F0sFWL76jHMqRT4CtVw5DueU4VIzDx09MLWyZ9LhJ35q1l5?=
 =?us-ascii?Q?Mg=3D=3D?=
X-OriginatorOrg: nokia-sbell.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6f23aae-3a38-4e4a-b985-08dd7719a4cb
X-MS-Exchange-CrossTenant-AuthSource: AS8PR07MB7478.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2025 03:50:18.1793
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AkL0SWKdxqmbRZ54pnaQdDdcT7Mm2wCjpMICUbB5kGBPsufdC8+Vgo4iAtUKRzc2pR4gO5BZY5p2lneCKEG6W45K1z+xXlUiOTGVDmipnBU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR07MB9862

Rtw88-sdio is missing the tx status report for management frames

Fix this by mapping mgmt frames to queue TX_DESC_QSEL_MGMT

Signed-off-by: Zhen XIN <zhen.xin@nokia-sbell.com>
---
v2: have the right queue for mgmt frames as pointed out by Bitterblue Smith
---
 drivers/net/wireless/realtek/rtw88/sdio.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/sdio.c b/drivers/net/wireless/realtek/rtw88/sdio.c
index e024061bdbf7..4311eb7cffef 100644
--- a/drivers/net/wireless/realtek/rtw88/sdio.c
+++ b/drivers/net/wireless/realtek/rtw88/sdio.c
@@ -718,10 +718,7 @@ static u8 rtw_sdio_get_tx_qsel(struct rtw_dev *rtwdev, struct sk_buff *skb,
 	case RTW_TX_QUEUE_H2C:
 		return TX_DESC_QSEL_H2C;
 	case RTW_TX_QUEUE_MGMT:
-		if (rtw_chip_wcpu_11n(rtwdev))
-			return TX_DESC_QSEL_HIGH;
-		else
-			return TX_DESC_QSEL_MGMT;
+		return TX_DESC_QSEL_MGMT;
 	case RTW_TX_QUEUE_HI0:
 		return TX_DESC_QSEL_HIGH;
 	default:
@@ -1227,10 +1224,7 @@ static void rtw_sdio_process_tx_queue(struct rtw_dev *rtwdev,
 		return;
 	}
 
-	if (queue <= RTW_TX_QUEUE_VO)
-		rtw_sdio_indicate_tx_status(rtwdev, skb);
-	else
-		dev_kfree_skb_any(skb);
+	rtw_sdio_indicate_tx_status(rtwdev, skb);
 }
 
 static void rtw_sdio_tx_handler(struct work_struct *work)
-- 
2.25.1


