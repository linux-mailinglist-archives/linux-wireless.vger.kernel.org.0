Return-Path: <linux-wireless+bounces-33232-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +LWLIK6ItWn11QAAu9opvQ
	(envelope-from <linux-wireless+bounces-33232-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 14 Mar 2026 17:11:26 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DCA1028DD30
	for <lists+linux-wireless@lfdr.de>; Sat, 14 Mar 2026 17:11:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6317C3014BF2
	for <lists+linux-wireless@lfdr.de>; Sat, 14 Mar 2026 16:11:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B62C10E3;
	Sat, 14 Mar 2026 16:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="ANFA6gT5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azolkn19012023.outbound.protection.outlook.com [52.103.10.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E68B72EA468
	for <linux-wireless@vger.kernel.org>; Sat, 14 Mar 2026 16:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.10.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773504676; cv=fail; b=oxZU89F4N0C2qTe6Cv/+ukz0m5L3MmjbWSIjCQsa6kHzFOgcsj8X35hZXZixPmog5JZidoIzfQxLQIU8QnzjImU+oJ3Y+aFW1sUlcYmw42V8t4TGj/dukihkl+JbKXVULPg6mSVLGoGnj4WY+HHJkfIStXPRRnKxmFJ4Ye8QV+s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773504676; c=relaxed/simple;
	bh=wjrUy+pN/UaFEBCYlKS7H/DB28lqX/oJIOsVgK2HHy4=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=KaqdxfYPnLyLEKn2t4/o5AlbVFIPTIPjZygL+pQVrfAGbbtJqBJawjccEPKjjqIEG4kEYVJFmBWRuC7UEUO440zfe/Vunl93UHQqYqff85mPTdqAW1vjF72gA4m4D8De+R3O+zsm4AQZH4FkUn4MztLI36Pg7MKHg4UdJOqCmYk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=ANFA6gT5; arc=fail smtp.client-ip=52.103.10.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ep0vclY4k2CbVaLfKfZZJsLfJBiPeERMrTD75hSUIY2rAS2h7RsOOTpTlTdd6tv7RhxShjcSPEeDw5GASfckVztHNi761YU+88oT7RA3awkhyBS9ynMbX6/OLUnAvlPHJJQ38JCZxg2i10K086HILGszEx3Kp8sj2Ribx7xjImNtXRIL7+CNmKUC9ovx8KPLMINxYbkSv3fmYv7jTLzO9p2ge1bH6BS5Utyz+DgYweKcidt7VSBtc1s/c+NJSj8qsrWBA0bVQgWm6XJnRHhHZ3f856KYnIkZDrrlU8r5Z8keOEaCb2zjRdAPtvaqS+5cEyswY4GHUXN3eoaGvghoUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=04/rsBHdkczZKghmXykjmLj+Qw1xJJ+6XNLl71/Q7GA=;
 b=YpraZ5XnjlFwJuT/a8mV70GdHmZcFbdRCKp9k1uaudG3ti+w5zdjzMD+06G9BKt/kEc9uMVNFdyol8okzwPoaKC7uKkztgoy1sBIqFPCc8gabV+kDeQos28iW7+IiyRh0pT9Xx9lmt/zagmha6bVCgg5uAoqsA8d+dxQmfEom9prkpKtx6Sb+4w90zaQaeRD0Lo4x5mb110bT30BBtuwK+vEuf0qtv8hTx5iazX83fwEJZhtFb1TndTgpV44XYNDMdnzVvwMuduJfZ9VkQC9RniMhzMigQ7+7OY5v4vkUyv+E4wh7iELXfatenaRvypaET0EMfGO8GLILGLWNAFIag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=04/rsBHdkczZKghmXykjmLj+Qw1xJJ+6XNLl71/Q7GA=;
 b=ANFA6gT5xMjLORqKI2pzKSuR/0ypJ/waAzPxkuL9LblYjV8an+w+yylkOeJhYePTvnUveMtaCY/u01HvBQgs/lqUAsM0u10DS9Ng1pNhnA1KjgGfMyY+zTs66KojgOWRUiJeaCRbI3NW5+ywtRYwYCNk8g4ojcv+HxNNh6MgOFFPyoe7H25InAJgtG6i2T65/pJugMFnW0KeLNToz1/zcfFDtsQhxtvlfBVytRoyRtEjxleDa+4A0j5ZrGFwYBCv18YwBNS2L60FwE05okmYe2EVGQp02+YJgdWBNGLPUarMtSPH8ib+lAhMiIXjhh7aOrS1FVuEYH2vtoKMXSa9lA==
Received: from SN6PR05MB5806.namprd05.prod.outlook.com (2603:10b6:805:103::11)
 by MW4PR05MB8916.namprd05.prod.outlook.com (2603:10b6:303:132::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.13; Sat, 14 Mar
 2026 16:11:13 +0000
Received: from SN6PR05MB5806.namprd05.prod.outlook.com
 ([fe80::72f4:b6a1:932e:6f0a]) by SN6PR05MB5806.namprd05.prod.outlook.com
 ([fe80::72f4:b6a1:932e:6f0a%4]) with mapi id 15.20.9700.010; Sat, 14 Mar 2026
 16:11:12 +0000
From: Roi L <roeilev321_@outlook.com>
To: imitsyanko@quantenna.com
Cc: linux-wireless@vger.kernel.org,
	Roi L <roeilev321_@outlook.com>
Subject: [PATCH] qtnfmac: use alloc_netdev macro for single queue devices
Date: Sat, 14 Mar 2026 18:08:49 +0200
Message-ID:
 <SN6PR05MB58064E57FE979CE7B2BF7EF3DD42A@SN6PR05MB5806.namprd05.prod.outlook.com>
X-Mailer: git-send-email 2.53.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TL2P290CA0029.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::19) To SN6PR05MB5806.namprd05.prod.outlook.com
 (2603:10b6:805:103::11)
X-Microsoft-Original-Message-ID:
 <20260314160849.2735-1-roeilev321_@outlook.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR05MB5806:EE_|MW4PR05MB8916:EE_
X-MS-Office365-Filtering-Correlation-Id: 40ba0336-9fcd-4e63-7100-08de81e44fc0
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|15080799012|19110799012|8060799015|41001999006|5062599005|23021999003|5072599009|53005399003|40105399003|440099028|3412199025|26104999006|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BoG+b1aliA3Uo7kCtfl8pz3ysWmhpSUidg42PuPhuWKEySVpCZrKUfPg71vH?=
 =?us-ascii?Q?NhmnT4rj8YmXAowQKRaqghYtY+GrdpMvpWoAa7zEDnrFl0r/FhSrFBG88rAp?=
 =?us-ascii?Q?qXdsTpeTzC7W1F7iwR/1ZycpjxAxqeiGW6S04ANpqnOItGJpA9ZT2F/SUVFm?=
 =?us-ascii?Q?zHaUm0g+/6KxGFP8oAbfOyg8uKhqG4jsxNt6Qsgve6xD5PdcdVyk/wD/U5Vx?=
 =?us-ascii?Q?ENjtom10EQ18m/hvICVb+XrOTwEp7GM5NqZFzgnaSKiQZh/QVSQf50zufvsq?=
 =?us-ascii?Q?wGxfCR7ECXCbP9dU/MGypbwF16ETBc6Ts+8X8uh+Sr0KUtcdXWpC3E45s6b2?=
 =?us-ascii?Q?N/zNCk7xVIF8gu36wUSR64m8+PqXlWt8+8XTWvJ9eizWab0DUxLAVGfBVsgl?=
 =?us-ascii?Q?jlNAOCDBx0yY2eCHKkm9VK0vY9cUBK1iazDgbCOIuM4bj02HR7U6qOAYmIQ1?=
 =?us-ascii?Q?k/qvwi4pgQPvDZEWh1p9DgMw9z1W2yeyQX7mDapTj1jX3xYSQd6jSV1Iu2st?=
 =?us-ascii?Q?JaDS77qLcce7UinMMKpw2GC1wtmSW9UtwVt9jBoJfteamj+9zvyLhV896PJk?=
 =?us-ascii?Q?uy/KyMHbMwBDyJoAvjQaQPs4JscN0rnXAkWyi1xR4RGOKABVS+BryC1xuRHd?=
 =?us-ascii?Q?2C4bL0Qta88xWRxFE12UQr3ytL7w7P3L0qOAyCec/ZUVipM5St8SzQt7RS+S?=
 =?us-ascii?Q?tQ0xLszfI8FzRa3ZP/bx4M450JOOsRgB3RhxQ7C9WgPo5KN4JvvYiMAjmaNN?=
 =?us-ascii?Q?8CxKdSAaQnD+Nao7rJqBEYSdn2k/TH27Vj1LQAAcwO5DsHmp9IzrAlLMpMvw?=
 =?us-ascii?Q?sscsnzO6ak7rE+yeIrXgc417evXOzOvPXZlKjo/1pwwMLOLhUsPzYVkDagfj?=
 =?us-ascii?Q?S0z3SnXRILHhTRuC+WIVNJru13XccOCn9ai0B6/WmmHs4K3onIg+jEvZR7ID?=
 =?us-ascii?Q?FdttKLeWSdGb3xYJRK92Xmtny6bRlNB+9FzR459icrY7eIUl2rFiJuy+yrnY?=
 =?us-ascii?Q?vqeVezJGbMDHJrUUTQ8yzI7LEg=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lHAVrO+PGqRyE47LVstshtdCsaXZIAz4b/TWjS5NkPAUNbl9gxxeW1JhalDg?=
 =?us-ascii?Q?T5ybWEJw+vsCU/xvrmR6nZnQpJ0Kt27zwhHGEErqZlCAR+B4Slit1Z82U7P6?=
 =?us-ascii?Q?FqqDyLmeR0T7wGlEgS7MSMgEpS3eaz9dNpCOy/zboEV6gZkQR5xL5vtlfd7Z?=
 =?us-ascii?Q?3nLr8yf0v6ThGzmGSqFEXXphBSjLiLIxjGWtdWjvVGEJJlmKzu/K0U23xYBK?=
 =?us-ascii?Q?q31HIZWa77JvIi5zR45wE39ewYFL96ur/LbLmrpL1igOld/HMEDiLGSl+1AM?=
 =?us-ascii?Q?rR88VXSI25NAGFopvPPwFfRu3fIMSggiFI8vYj/VtkqdrrgURgfjJ1KSzkrd?=
 =?us-ascii?Q?IZ1t84hukKpwZmv6QIJLsRSET0Z3D/xA4rhxoJZOiKpJmkrMsxgJyZR7IcGa?=
 =?us-ascii?Q?KZUaeOiAPSVM5lFjdgaJifIfqeSXSE8LDqKBIFKSqMI/F7K/MreouqK5Tg/F?=
 =?us-ascii?Q?4X6C3LafRNObiaRpw+8JTm5wVA4RBdfunlvXrzkmTw2iYNHwWoH/H8H9LvzZ?=
 =?us-ascii?Q?iM67RTchT0IMe/lLEQ3FF4Ef8trteuTMw8z01lDlh0VB2XEvPh5RzDIhetEd?=
 =?us-ascii?Q?+3eCpawwY4C8WzPa/1YWQsFv7WsNSTbF/HJYWaADwTZb5UuZJEAyj/SynQmF?=
 =?us-ascii?Q?uP5LhLGn3pnIa4adJ8cswxpLBMErB99hQZD7WQx9kRxJajypUXJXcUNrxEBA?=
 =?us-ascii?Q?zi8JhHKEMi2w6GN+n2gz/mVk7zNdjn+TjnSTWYfNlGeDyrvtKCboG8DEaWLJ?=
 =?us-ascii?Q?7nk3HGXelgHmFLST9SvbyMT6voygIM156ttJPPwySRofFDMLV4Za+wpTYEWl?=
 =?us-ascii?Q?g7B2ypuxc2TOpICyu+SwQZancajDVfAXz/apEGnLe9UBUgZ3vzdr4LHYuFg4?=
 =?us-ascii?Q?sjt3Hxl7x+taXXEgf+lEvm/Tv/Fe91EqKRXDKdcdWQKNxb/LQxk0B2hhMob3?=
 =?us-ascii?Q?rGNAUq7O2dHfBCwvDo69ZOBU+FiTSqvy26JcKHDtZsBf704O8zTiQRzbam8J?=
 =?us-ascii?Q?GNn0tcz6r8DLkKoNp2MiG6Uf+U8StR2tHbRK5wF9pHZ6/TTkrq0RUJjLOzna?=
 =?us-ascii?Q?t/DfZiZbaiWM6ajVEqOvYLAC7/W3Zigt0kPS+92EaoMby/gmbkkd7vNcr20o?=
 =?us-ascii?Q?o+MshTZq6kXXkm+lvp/z/4Hl2IxdzwypTIkAGo0VktPHAgho3C+JdwG6Csx+?=
 =?us-ascii?Q?+jL/kl4WwsCil6Rq73Pytc2OihKWMIMQDDJ9cEdavSGe7w9VVZ8y5qNAB+Q4?=
 =?us-ascii?Q?ha2MRHXTc1DzqwOLfxaYDyxZcW2JdE54AaaV1CFtaqcggMFqI9ycVUuf6/tF?=
 =?us-ascii?Q?lEyQ75rDh3TC2QRLUxvQuZtfO/kNHH16EyK127psZgOHw5xESwdSvi/q1J0i?=
 =?us-ascii?Q?xRST03BzW+7Yo2jkXHkrppeMD5EG?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40ba0336-9fcd-4e63-7100-08de81e44fc0
X-MS-Exchange-CrossTenant-AuthSource: SN6PR05MB5806.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2026 16:11:12.8613
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR05MB8916
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-33232-lists,linux-wireless=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,outlook.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FREEMAIL_FROM(0.00)[outlook.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[roeilev321_@outlook.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[outlook.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,outlook.com:dkim,SN6PR05MB5806.namprd05.prod.outlook.com:mid]
X-Rspamd-Queue-Id: DCA1028DD30
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

alloc_netdev is a macro for single queue devices, so there's no need to
call alloc_netdev_mqs with a single tx/rx queue.

Signed-off-by: Roi L <roeilev321_@outlook.com>
---
 drivers/net/wireless/quantenna/qtnfmac/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/quantenna/qtnfmac/core.c b/drivers/net/wireless/quantenna/qtnfmac/core.c
index 0c106709ae29..fece048f7ca0 100644
--- a/drivers/net/wireless/quantenna/qtnfmac/core.c
+++ b/drivers/net/wireless/quantenna/qtnfmac/core.c
@@ -452,8 +452,8 @@ int qtnf_core_net_attach(struct qtnf_wmac *mac, struct qtnf_vif *vif,
 	void *qdev_vif;
 	int ret;
 
-	dev = alloc_netdev_mqs(sizeof(struct qtnf_vif *), name,
-			       name_assign_type, ether_setup, 1, 1);
+	dev = alloc_netdev(sizeof(struct qtnf_vif *), name,
+			   name_assign_type, ether_setup);
 	if (!dev)
 		return -ENOMEM;
 
-- 
2.53.0


