Return-Path: <linux-wireless+bounces-11186-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5456C94CD95
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Aug 2024 11:48:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC9DF1F21599
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Aug 2024 09:48:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8119B194A61;
	Fri,  9 Aug 2024 09:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Sz2o6YZY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013064.outbound.protection.outlook.com [52.101.67.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A039F194A42;
	Fri,  9 Aug 2024 09:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723196788; cv=fail; b=PYtgj0BwSunGoQrAr606c/YrvcLf6enAN1TLWIWvbaeWUmM05tOA1k79AGNwaFTNKO/9F2onrUyHaJaddE/u9L/yy1qOSfZfvstauypRDkSGDjC9/HVWnFtmtR0Knde4tVlnxO6N9YCJg+OUczCnukAzYRw56ELucpyBLToe820=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723196788; c=relaxed/simple;
	bh=znWLtTkFM76wGBuVsUdfZMDp40n4XqPUorbBvxwHMzQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=i/qTn164bIOYqyzejsmszXJkAJEQdZGvvrQdtuDz7k+K+4IB1Akbr7KRT7igCcf0xGJGVixIurJS8V1pUV9nWySRCuVkXXBIhf0OuvZ/bNoCX0Ebup5SQQHyHknbjarpmtC5zy1v7wKwCTQiYbGurrtmLHZ0AzWK+zY5UhH+HLU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Sz2o6YZY; arc=fail smtp.client-ip=52.101.67.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FbonYZ7ke312MdB/NtTbYwZ8+n5d35Y2EmOdWHxlfjdQpDTkUvil0IEd2dxvurLjY67bSj1F0htx2fPHGNqGACP+0GY8nR4BEN3xjS8tg3tfmsiIpTWimImBbRHMfgbm/kjjXOFmPxDhoOQwrtizLirRImwU+btd3HKmsWa1jXNrEeTvOje9Htf8mQGZPElC4+qN64Ix9jn2jS0H/cePLC9SkihY1iAbI3ZXk9/X20yUYToFu1cE8zzq92vMg12xltSIXQ2FoRg9P4hdWlvTFkMpykT2mqpSCwvO3yBuvQzpD2TQQB0LpX5GSTNO5fNCQi5uBC5jZfSEU4qGZcFgOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D3boSOwEh0i1qO6vUWvAJ9pNPb0xhMcSZHsWqmugtc8=;
 b=dMruA+ySyZLbajpAsoeTM9OgU+om5hyxWSkVNenb+jZ8daCSpFZ8yXPvBd0Xoio5bbWxgMYoQo6d7AXsmd1dq+iDkssd4zdem7/YIEtYRDoAeVNJDZKOcZwngeazcQC4w6nVnOmuAna0cQ22b6xwsv3kyNp9D+zKWXEvBlHx3yt+oKY1SQc6PomZtGvj4ovgdTK9Sgofeovg13mmi4sioUKket8I93EKu8rJU+BRpQhbAcc6SGXHb1ZYXSB+UZHFTMAFJCG9zw4Bp9IUnjmjHPI/6Yd49/SWbNgHh/w7ZGHgQWevg1hEyOqhenT+W51FDEPayhJtIvTphwGZkNBU2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D3boSOwEh0i1qO6vUWvAJ9pNPb0xhMcSZHsWqmugtc8=;
 b=Sz2o6YZYm/9g/K5ITQfyIEwLcHPo+LOs0EhdpbAfYNG0GJk5yiMybxy/wYd8Y9a5dw1meU5+33yfb869NjLEyjrWwrd0HEKebOIhvhxcJNuBlZS/1HYJmzZbu8CeHSpcYmSKb4L9MorNAPNEMshGtxMvkNMoWzPfA7PZfJfN0cnhCmvlFXJ7+sv9b2jqoc7KCLdBOjRJ5C55NK6oBx+kI0GETzrdeh2e8UOiVMn59P7/grY6DRZf0Yh8Ewk1T6teTLhwYDnorwYGZ3e7xu4f12SqGvDpWam+39gmV7B50LFRrWN3CLua1fWLncrYerFa3iD6TPvng4qLkUSt8nUGFw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by PAXPR04MB9229.eurprd04.prod.outlook.com (2603:10a6:102:2bd::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26; Fri, 9 Aug
 2024 09:46:21 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257%5]) with mapi id 15.20.7828.023; Fri, 9 Aug 2024
 09:46:21 +0000
From: David Lin <yu-hao.lin@nxp.com>
To: linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kvalo@kernel.org,
	johannes@sipsolutions.net,
	briannorris@chromium.org,
	francesco@dolcini.it,
	tsung-hsien.hsieh@nxp.com,
	David Lin <yu-hao.lin@nxp.com>
Subject: [PATCH v2 09/43] wifi: nxpwifi: add 11n_rxreorder.h
Date: Fri,  9 Aug 2024 17:44:59 +0800
Message-Id: <20240809094533.1660-10-yu-hao.lin@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240809094533.1660-1-yu-hao.lin@nxp.com>
References: <20240809094533.1660-1-yu-hao.lin@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0178.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c6::9) To PA4PR04MB9638.eurprd04.prod.outlook.com
 (2603:10a6:102:273::20)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9638:EE_|PAXPR04MB9229:EE_
X-MS-Office365-Filtering-Correlation-Id: db09b283-f7b6-451d-76e5-08dcb8581fc6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|52116014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VwTNdyct9c6w4Q/e6lhNSwtSnZCQjGsNkJlFmXbSkZw+5x1if4TgfhqxXvhZ?=
 =?us-ascii?Q?FeugWE/PxG5l05qKRhCklHO7+YgiA5v4c9jACSoLZnq7i3dc1AzN6irAUG37?=
 =?us-ascii?Q?GzXXTMq1MYCcsVK/rFeZ4+zjrIZKo7RCKhDIM0bhZRD6FqKpr3k6oHawUc2x?=
 =?us-ascii?Q?oHkILPdYsv0bvEFyxif8hOBbdH12lPEOqfILJtirUNaxa642qdkTcV6seB0K?=
 =?us-ascii?Q?0a3tqBChqWinKwq23KMMGSrdI2ZV6b9/P2+J/fhxMP0eFSuPdNbop2+WiDvX?=
 =?us-ascii?Q?1C1JEoFHFLKg4GsuGg3mm4Y1eDcd485pH8ASyQBKqjXmTv1YvOEWf21hIrmC?=
 =?us-ascii?Q?vrR+9k2PUe++Mh9Xd+Kqn6AoYHN9EGRsrHMt26mTqM3+C7YycZdJIDe+9uoK?=
 =?us-ascii?Q?rmAzAgZ/eUHkYSP42+GNFzRJXOoZZYDVlFE6KeHYpOdv6I8FFNAG1ZXWht1Q?=
 =?us-ascii?Q?P5mf6JCb+eNaJ7BEERZ390S7c3YLCyhEqNjVel2TvWjQz8dIGBJnKbiaFI9O?=
 =?us-ascii?Q?xJmWIIqC2tqgy/tYBSoMdrGPGWhMhj8wkDhrzbZkjJ5UesLkhFZxSxZDinir?=
 =?us-ascii?Q?0StcUZQjz+n0CZbY1frnxjzkL6qthPWP2AtbLOILBfH6+tbE3Z/hCgUPzkqo?=
 =?us-ascii?Q?61/WUX5E59EhX6eDYfGXNN3KAW4C3n1MeeeyZCHmhpDV8wjESwAYmqoAQTjT?=
 =?us-ascii?Q?WRXq5UPf96Z+krnrblWDnXYyXbbRsrX29E7F3OkQdJe2fJiAzoNh5Q+zntMd?=
 =?us-ascii?Q?+IkA+Wq9GS0n8+zCPm9ZHByj6urrkYvzF/u3DNZqiKqLFF0ey4SsnDjx7YB3?=
 =?us-ascii?Q?BBttgJ9ghF9jTsRrULoIWPNNTZdhaYSme5g+Hb4g9gWFroPJPRJHSyMXxj+W?=
 =?us-ascii?Q?NUbVof7NdCCdAo+/ypfKZU3WsqXj5D5rKvdav4nhasIyIOdJMECDZWEzkSHi?=
 =?us-ascii?Q?otT8MFYho2/9tz9fpb6XeLqLmMO9QKQOB39ScR4OwyluKPam1pbxM0VNrY05?=
 =?us-ascii?Q?uiGi42xVj43TpefP8cFK8wG/ESWzbDq9mKRTnbbcHDLB7bCqndEUZbdNBBBM?=
 =?us-ascii?Q?q5N+z6vxa+O76qKUXVBzwRqYd/ADyEh59/6kwlOdFcIqOcIGyZ5o6z4GVO/k?=
 =?us-ascii?Q?wguFwbm3BanIZTnAMAVX9t5OYgDMArzUp2NNNeGK3fqJ+gHtODQ6Ee1CKAYJ?=
 =?us-ascii?Q?4PlauXRitqr08393BA9umyodWPIOhLwvXF2jQBx4oNgcxBvjT/kQtlIzUuXE?=
 =?us-ascii?Q?VA5DmOjrRXlh52m3LQkWuUQliSyOYTfW5LyVA7RyLTC7WEfaDXuT/QgoqIzV?=
 =?us-ascii?Q?3NgL74kntG/v+G9ImiroXxJctJR8TMIC6BToKZtP9LDgWA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(52116014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YW7VxbQSYrl6bC1s5FWN0I8CwvfUI34ig/xPfmTosJcokBhg/3P7DguUVkI3?=
 =?us-ascii?Q?uNw8Cio2QHD/4ZOcjfNH3Qm04zXcZWkr1awv8fXvhVCupd1b+M87oR50dXty?=
 =?us-ascii?Q?+9//ZuqTCdpAnzJ7qpvR43oVv9Qq7bSntBk5HU939tFHzgkc1CYmx/EcWVdX?=
 =?us-ascii?Q?ewrR3AVyei9/LwMpbeCGDQcSOqX0MAcXFufq3af3MOYAWo2nvbfsFkAEfTid?=
 =?us-ascii?Q?YG3xrTJ+mZvwEJsxK6aRezdrnlzFidSBd5Fp1i1qGAhPlC19w//eV4Qw0wQy?=
 =?us-ascii?Q?W5/fE7FFN+VJRcA/jqJtuQAiDJUHWSTq4e6lY0RLmiMLWkkdX14RVdjOqWSn?=
 =?us-ascii?Q?0DYOoyqr0tqhA94wQnJiT7twtYPdL5NJ/YLx9M5oKbtZIwOoCZNBsxHGPBxk?=
 =?us-ascii?Q?dyS4XHyl+DbIii+k199LAiiDfkplqbsmzmtMdQRdXwxOQIy1XlTqrQL1DqFB?=
 =?us-ascii?Q?a0EN5KEPj2if65K6zBMetsEHZGc60Bw6XEk6AZ8Gva35KU05p0ax4LduKclj?=
 =?us-ascii?Q?WAVBSOiUD9Ga4li+WWVN1lxxY6+VQJFjkKcqI3S+GpesMn1zSg9tg0NVczZw?=
 =?us-ascii?Q?8n0OXNiAm0lZQ3pXELTevEm07c8Z0wMLFNCGYL8GojUceHpQNr0cxy6A5YBQ?=
 =?us-ascii?Q?TLjo5tlRIWkePkWI0QJ9c2IZiiLVr7s1hdi+zy65++hIbJKWKP/n6BMJjYO0?=
 =?us-ascii?Q?rzeCbQ0c3oEKh3wBEmkQzPDtZXd537BiCGZnopPtSEAqKihHOUh5YEKbOp6+?=
 =?us-ascii?Q?SA4IwPoHwOMdxhbqjBTI6Kg+Brold/vta9qtd84gO9Vj7lHsN93w311oZ88E?=
 =?us-ascii?Q?D+Gec56bQq8fZuIndJD6myys0vHECnLG9Uyz868FIJ8KJc4h5RbXLGYcs59H?=
 =?us-ascii?Q?qBUC36iWlMeMToVxc+jbZW96ASrUvCepTzuhv47mfSbqpt9DzbAlUJYQEl1O?=
 =?us-ascii?Q?pwERRpAAVYIr5f0KwUnBNH3aOZYRTi+FPCV0iGuZSiP620KfA7ZJpgvCGRH1?=
 =?us-ascii?Q?GEuH3AQLi49YhG7a6fXnJhinbNc5r2LHWgx5Yrwn5eXIeJnM4QO7fGblFWM2?=
 =?us-ascii?Q?zQ0uJOBfGZ5JsBKjl40R8MHjPoIYZDKhhAOKFAsjxigD7/MWTDszCf+EspmN?=
 =?us-ascii?Q?rBmf2xLKACZVhBWADwHGVZWCACqzzJoSj69XQ2a1xDVDDHmdziE2BtChvz8K?=
 =?us-ascii?Q?4vmZOjZzLEV9ADBfCwJPhPPmfJxFHeK5sYRd5yFuvbKg6CDX7H2D7L5ubxB/?=
 =?us-ascii?Q?MScuTGszlbUslBnUJ59fkD9XE+LL+CrMLdeBeSYRmqSaK6apHi2blfQkf4sT?=
 =?us-ascii?Q?N9tU1kvm3UEQ1O/uVXENKbly5HWqZZY9OV7+kyifJHw1AWk4HNszQWzC5n+e?=
 =?us-ascii?Q?vbOdx/Zp3GZw8CQJEZAgliIhkzRsZ5MSbL6UUS3vLdaBi+UTa502uOAdMJLX?=
 =?us-ascii?Q?xRL+y+nwbtjYkTgTgny8EJ/Qb5PhTHFcgeNv6o3geK7XCzD296+wBDyJa27o?=
 =?us-ascii?Q?w3ySmCzHObi6WsjNRdxIoX78Arfa/v7sC688qr+aYF9ZyyvK1UhYpeNIqLMg?=
 =?us-ascii?Q?V5H0C4OC8lQ2uh1Q94Y86bU9VQcbZImf+q5AOrf+2vFUbJZpiIh50RlCNPd+?=
 =?us-ascii?Q?xOgvl2i+FHPUOvaR8znpf0oIEW42hJn0TiLiQA8ZvyRx?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db09b283-f7b6-451d-76e5-08dcb8581fc6
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2024 09:46:21.0877
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qwuax0rLl98o3pkjBx/D2u+qPW7EQuQwk9O8SzjX+Dl9W8qqPT+jDoMbjxA8Nkm+lL7C0320zLajqH//GnI1NA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9229

---
 .../net/wireless/nxp/nxpwifi/11n_rxreorder.h  | 72 +++++++++++++++++++
 1 file changed, 72 insertions(+)
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/11n_rxreorder.h

diff --git a/drivers/net/wireless/nxp/nxpwifi/11n_rxreorder.h b/drivers/net/wireless/nxp/nxpwifi/11n_rxreorder.h
new file mode 100644
index 000000000000..9b5dd4899f0e
--- /dev/null
+++ b/drivers/net/wireless/nxp/nxpwifi/11n_rxreorder.h
@@ -0,0 +1,72 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * NXP Wireless LAN device driver: 802.11n RX Re-ordering
+ *
+ * Copyright 2011-2024 NXP
+ */
+
+#ifndef _NXPWIFI_11N_RXREORDER_H_
+#define _NXPWIFI_11N_RXREORDER_H_
+
+#define MIN_FLUSH_TIMER_MS		50
+#define MIN_FLUSH_TIMER_15_MS		15
+#define NXPWIFI_BA_WIN_SIZE_32		32
+
+#define PKT_TYPE_BAR 0xE7
+#define MAX_TID_VALUE			(2 << 11)
+#define TWOPOW11			(2 << 10)
+
+#define BLOCKACKPARAM_TID_POS		2
+#define BLOCKACKPARAM_AMSDU_SUPP_MASK	0x1
+#define BLOCKACKPARAM_WINSIZE_POS	6
+#define DELBA_TID_POS			12
+#define DELBA_INITIATOR_POS		11
+#define TYPE_DELBA_SENT			1
+#define TYPE_DELBA_RECEIVE		2
+#define IMMEDIATE_BLOCK_ACK		0x2
+
+#define ADDBA_RSP_STATUS_ACCEPT 0
+
+#define NXPWIFI_DEF_11N_RX_SEQ_NUM	0xffff
+#define BA_SETUP_MAX_PACKET_THRESHOLD	16
+#define BA_SETUP_PACKET_OFFSET		16
+
+enum nxpwifi_rxreor_flags {
+	RXREOR_FORCE_NO_DROP		= 1 << 0,
+	RXREOR_INIT_WINDOW_SHIFT	= 1 << 1,
+};
+
+static inline void nxpwifi_reset_11n_rx_seq_num(struct nxpwifi_private *priv)
+{
+	memset(priv->rx_seq, 0xff, sizeof(priv->rx_seq));
+}
+
+int nxpwifi_11n_rx_reorder_pkt(struct nxpwifi_private *,
+			       u16 seqNum,
+			       u16 tid, u8 *ta,
+			       u8 pkttype, void *payload);
+void nxpwifi_del_ba_tbl(struct nxpwifi_private *priv, int tid,
+			u8 *peer_mac, u8 type, int initiator);
+void nxpwifi_11n_ba_stream_timeout(struct nxpwifi_private *priv,
+				   struct host_cmd_ds_11n_batimeout *event);
+int nxpwifi_ret_11n_addba_resp(struct nxpwifi_private *priv,
+			       struct host_cmd_ds_command
+			       *resp);
+int nxpwifi_cmd_11n_delba(struct host_cmd_ds_command *cmd,
+			  void *data_buf);
+int nxpwifi_cmd_11n_addba_rsp_gen(struct nxpwifi_private *priv,
+				  struct host_cmd_ds_command *cmd,
+				  struct host_cmd_ds_11n_addba_req
+				  *cmd_addba_req);
+int nxpwifi_cmd_11n_addba_req(struct host_cmd_ds_command *cmd,
+			      void *data_buf);
+void nxpwifi_11n_cleanup_reorder_tbl(struct nxpwifi_private *priv);
+struct nxpwifi_rx_reorder_tbl *
+nxpwifi_11n_get_rxreorder_tbl(struct nxpwifi_private *priv, int tid, u8 *ta);
+struct nxpwifi_rx_reorder_tbl *
+nxpwifi_11n_get_rx_reorder_tbl(struct nxpwifi_private *priv, int tid, u8 *ta);
+void nxpwifi_11n_del_rx_reorder_tbl_by_ta(struct nxpwifi_private *priv, u8 *ta);
+void nxpwifi_update_rxreor_flags(struct nxpwifi_adapter *adapter, u8 flags);
+void nxpwifi_11n_rxba_sync_event(struct nxpwifi_private *priv,
+				 u8 *event_buf, u16 len);
+#endif /* _NXPWIFI_11N_RXREORDER_H_ */
-- 
2.34.1


