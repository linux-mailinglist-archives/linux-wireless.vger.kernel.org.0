Return-Path: <linux-wireless+bounces-33091-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kP0ECbSXsmnENwAAu9opvQ
	(envelope-from <linux-wireless+bounces-33091-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 11:38:44 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 69CC3270687
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 11:38:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1A4633013FC5
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 10:38:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA5C73090D5;
	Thu, 12 Mar 2026 10:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=HOTMAIL.DE header.i=@HOTMAIL.DE header.b="E0bM1vCb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazolkn19013080.outbound.protection.outlook.com [52.103.33.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EEFA3BBA03
	for <linux-wireless@vger.kernel.org>; Thu, 12 Mar 2026 10:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.33.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773311904; cv=fail; b=I1DhR8vYG2bkuuU3OpkequpPunhUTOujQRKz5msjSCk3RKCJIbxi7fExoNc4Dn6a9VtIypJ6OQEDPapsnHbIdgu3R5FXwHKJ4NUe2cR5TzSQunx6tr4G+h61wc6TQpyZ/vZJLg209LtFEtuF//nEQRi8YY1uPffLzC288eS8l9M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773311904; c=relaxed/simple;
	bh=Cms/xFsOc2ficofpO1Iak3Z3GerJH5hdtPM6Uf4SJBI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AXyFbFICi4lgSXBpksu8QWrZeUJ/PaFjz0bQUeqlqoTfmoWVp5kD25LbkbDLSsv3my2571kqhF5Ppu3m0FuQRb4bH/24A5pZcq8sII4yYA+XXAtfwtRyVczqEBJ2nVx+t4/ZEh+3SbjtguDRZFdm1lnkP1kIvEf5pw8bzlGqfbw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.de; spf=pass smtp.mailfrom=hotmail.de; dkim=pass (2048-bit key) header.d=HOTMAIL.DE header.i=@HOTMAIL.DE header.b=E0bM1vCb; arc=fail smtp.client-ip=52.103.33.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G3jUoV7pGnBr5nvh8Ro50SNj4vaQqZrVCFXCpXR28/7iqW33GRXh1E9Evz3rSDGafwHvIOXy1jca1YN4ZKuoJI081GmxnWrY3M6n99bxJOpuyc7inbS6fAHgfTfgWdclrHKXI6RvTaC0YkiKeAegLwIoKiTpcStDHI0GzPd1zTA3GCzKZVF5wknyVC5zSCYRXZ26KHXwuJfBQb2ao9SC21Sh43V6/yk8EPGEaEhdzZLRn7XJVrMzqBjBwq0Bz1Z3+GYQypDtkA8NKsnEDuhyUc2Jw7+CDsFbVtGQVpzr6ef9yM5t8zgVs8uzDVph7ZFimqMkZ606R/csQBlLn2xOnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5ytpYsKJMf878232db8UhCLxljxDsMp3Guqx1uZVVfc=;
 b=ccVpLn5v1YhgedV7ilWUGUt3uBrqqceHm3UoOvZxNN1kZH5HiPlTX1QI1KScthp3Ww4zuHjSDb/hmr1crY/ifeR3I3wNieX91M+OsKuW1YIAq9w2HQvlRxlmzzZhbh3k+QdDOGt/fpDGO4YOrCeM3qZEy0frdSfexsYakm/74vCyh7oNuuLbd4rkEDzx3hNpwrfj9gKKCKVoAqJDXzfwEAQRHIZpMVv9R6yOUUkbYSTTRKaiQ6fStH0XpWCFIpDdQZe9ckyQx3bp/l/x5/QrqfxIGiAuefkYpwbk6AwQ7ZK9c1HyutnWJdAapUalNf+tjDVBSdrWGMEE29TCckBamw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=HOTMAIL.DE;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ytpYsKJMf878232db8UhCLxljxDsMp3Guqx1uZVVfc=;
 b=E0bM1vCbc1uUeRm1095qkzKn9UnMg6mkCzhOkJ4ogKvLnVS85fhf1vKgbDAiY6jHuuGC5I2FPfZho98PpR1AYqBUbCyoS39/fUQObOgBN3TnSHVCtUVCARL4FcBaJUpWx5QP7RTOWEOsw588AyfTgMbgdX7Gkp1QQMkrdRUc0Lf5tqT06rkCY62z9Ww+TRjw+k0L2c5xfjy7cHAkRQBbu1pob4DBGjqG0KtQ24DlZnk9YfKbyUb0KzFdDPtrq25M1bV3UDj4O1WmlmR19OwrATyQZj5Jearh1F1IuME0sk05byx3UI326IFkU/9lk0rgIHbqVxH5cNihEdsYD9Rfvw==
Received: from AM7PPF5613FA0B6.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20f:fff1::851) by PA2P251MB1058.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:102:40d::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.25; Thu, 12 Mar
 2026 10:38:21 +0000
Received: from AM7PPF5613FA0B6.EURP251.PROD.OUTLOOK.COM
 ([fe80::1ed:268:bd65:b36c]) by AM7PPF5613FA0B6.EURP251.PROD.OUTLOOK.COM
 ([fe80::1ed:268:bd65:b36c%8]) with mapi id 15.20.9700.010; Thu, 12 Mar 2026
 10:38:21 +0000
From: Masi Osmani <mas-i@hotmail.de>
To: Christian Lamparter <chunkeey@googlemail.com>
Cc: linux-wireless@vger.kernel.org,
	Masi Osmani <mas-i@hotmail.de>,
	ath9k-devel@qca.qualcomm.com
Subject: [PATCH 08/10] carl9170: phy: enable antenna diversity for 2-chain devices
Date: Thu, 12 Mar 2026 11:38:03 +0100
Message-ID:
 <AM7PPF5613FA0B6344DB5885359FAFC80D69444A@AM7PPF5613FA0B6.EURP251.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1773277728.git.mas-i@hotmail.de>
References: <cover.1773277728.git.mas-i@hotmail.de>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR5P281CA0038.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f3::8) To AM7PPF5613FA0B6.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20f:fff1::851)
X-Microsoft-Original-Message-ID:
 <4ddd3961caf55c2cf29c799002c73a06104d073a.1773277728.git.mas-i@hotmail.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7PPF5613FA0B6:EE_|PA2P251MB1058:EE_
X-MS-Office365-Filtering-Correlation-Id: bebb11a6-2ba1-405d-4512-08de80237b02
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|461199028|51005399006|19110799012|8060799015|41001999006|23021999003|15080799012|3412199025|440099028|3430499032|40105399003|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3in2eOPm/8ra4hjdCMfBp6s9x3BJ2MPjavVCgZwYlu+w6kuSsAsjmeiObc4X?=
 =?us-ascii?Q?QtNEwSWm2wVZuLCUtwUJk8rgJI5LNtcNt2ado07HcSPIlUJxU3l+7nl2x5gh?=
 =?us-ascii?Q?rDObWZitr5VD19JgKk51w32WKeSdHT/+ODiy7D5RoDu8pC8EjDvPfakO+DPe?=
 =?us-ascii?Q?wS0Pwnibl0wA0OTzbjE5BQEyNBI2EUOba5YNf4fixoGVzsLwdsR+wCMEMpeU?=
 =?us-ascii?Q?61G/st2DYjcUXtCrOqGV3OTM9aZCVKry4PGXp3+QrltWLub5HybcJVKXsGFx?=
 =?us-ascii?Q?0psNlOgogXIeG2jM4QVuifPIDGPX2LQkWi3WT56E5HGX7FLK4n5V0IKdpTT4?=
 =?us-ascii?Q?84dLEegWpQZxrYefLzfxZlHlb6Ajbs3GH0qAIzGt0dm3tENTdGH1DkSf1QJd?=
 =?us-ascii?Q?d3lBmjuhrp95xzb4c2KKUHGTtOJxqTsvixRuWTquaFaZQfjSBIZa81CDkuIH?=
 =?us-ascii?Q?Fg83GqslDekanDTDGc3E4kbojtEQl8r1vG6ZgXu7cOwG3ueDsacfvOHGAIIv?=
 =?us-ascii?Q?o+zvyUt7H8DSbQerLXZCpK2jSm26nbb5041M0+wm5queNQP3QWAGoU/5ruXD?=
 =?us-ascii?Q?SHo6gfHOMfafS0Simh7IXCkZCmAxQrkFSNyDU8Bhrjxg6uTMbki0iqMKVwqZ?=
 =?us-ascii?Q?nn16KS5JpgupzcE+QADXpXZt6LT0ilqH/vG1SdatinpZnskdFXVqDN+5PI9N?=
 =?us-ascii?Q?eA5Egw0U9xKn+R3ooksBYRHngkU0XLP9gtid2J+N87PkJtoDCudAxqq27Z8m?=
 =?us-ascii?Q?kSrZtd+AkkB5Wj8q8be5SZ6UvpErs1vJ+Gtz4Iu/1Xok1VTtuUOPHodS/Mcz?=
 =?us-ascii?Q?4ukyaxByOvMiLWy1LyyJXgJh0jyB/N7zDLtezEsKUXcc0WGvBqTJ9JJoTchW?=
 =?us-ascii?Q?YefF8GzfAU5BQ1dQ2F+MPaaFA1W4SpnXqzgf4D+fuMg5iVSaOr/gd72t4MJ4?=
 =?us-ascii?Q?dXClN58wtwr8N959SUnjPA=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?I8/v4QcHEPKGyVS4a6LwbL4a4dPRW8nMzM3Ea7JLf4I+3c9zu0xiVdIZIwUo?=
 =?us-ascii?Q?vnVpkdBeMIoJjuXKCeciyEpeR2+FU25tNOpDg29IMNVT4Sn7cNYU+guf0DXM?=
 =?us-ascii?Q?evh0+ZoTuU0PhPk3OkODklb9tYQCUe2yMGE43fcmv3NRaeLrPXNkVPYN7aD+?=
 =?us-ascii?Q?XCvupDAGGFdPBb+GtnrCQ7nZ2aE/Lv+6z/ZwS1tvoQLZnhXM10gZcW2y+2Ww?=
 =?us-ascii?Q?YjoZWzpG2/0C/codtclukRAvElrrs6YbIf1WpMRQB2onCou04ooxJzpOXaOq?=
 =?us-ascii?Q?ujY4cVv0cf6YQaCbtDGMx1bpf4Tjc9MQcirDXiFuel9ITI0crMSKW2yaS6x2?=
 =?us-ascii?Q?PR2TQdPt69+AJnp7cveC34Mn4xF4f7z96sDtkwx8zRrr4p3C1xVw2R9zH+ls?=
 =?us-ascii?Q?89Jm9o0gNlyswNFqxlUPwrp1ken2uvUMswMuWmHKIDoTtBrYi7XZop73GK+X?=
 =?us-ascii?Q?Fui2QsysHXLfdStBTAFa3iT/f59kvNCwMrpoQ/XtGdWjYmYzVCScRflFA51M?=
 =?us-ascii?Q?0peTW9h9iSBpvqrv2+zYHOKPc/VyPCJ665b4ERMWF893CZzlDON/oefhBoV9?=
 =?us-ascii?Q?PuSak90r/BuOLxjz2hayTfnBXGKyh3zaZVirqAQ0TnAldUUSRwzm64bxnj/r?=
 =?us-ascii?Q?XMB7ugl5QH1Vb8ER7JQnNxjq84JpffE5Bml/TsPk0RQr5zpPfFzCMP3bwkcS?=
 =?us-ascii?Q?xHLjDZX7cJNFdvg2ltTgd4+oREZhU9WtM9YqbrZxZtMWIHq4fqfg1csExLBi?=
 =?us-ascii?Q?4QgjX2bL5sDLdWcENRwq9D8xySU4Ds0CQs5Obd8VUj//g7kAVM5ZeiEqRepg?=
 =?us-ascii?Q?YTWcTXG//XQb6JXXfBE9WwEa3A9i5JnBq2zrMbqQwJmPsXGtRfnAi3eJWkKU?=
 =?us-ascii?Q?SZlPbDevB/O51exrXYOG41Qy4bCWNzG1WZrrX0WImaSB+Bqn3E3nvW4hyP0P?=
 =?us-ascii?Q?ALBEfbwXk0mx74nXRwwJ3rIGEoHKd/5ZPGprRC4awLuhBod7awdmEdOJbTCR?=
 =?us-ascii?Q?a1FRabjDa+y9aQ7fQFltn6k15mgp+nMcNm4Et0w87evltRq2CNqkhZsi4lhT?=
 =?us-ascii?Q?3qi4vjWu565UD9zE7cj63MBg/aMzf5N1BrAq8Z1zdEZhzuABZbU5C/Dvo4j/?=
 =?us-ascii?Q?QkqentEqFriBP60/lBPciLtCOSbikH1Y2kSTu1/CYy6YJ4ip6XsP5pfVtPBY?=
 =?us-ascii?Q?j7EGsD5664XXBU4RzUbeZiIp08cDm+HWoolnNnlKYApkRrTYWIa8v16VuGtE?=
 =?us-ascii?Q?xarP3+Dap2SPBZuEsSjOZaLWoKr5i6sviZ83byvOO1O9ngBXXTIzzIRjWOYL?=
 =?us-ascii?Q?ZClXpEMSMOCxusFVRboSS2CRQcxWVAORpSiTDNbtlDgawgnRwTahF0K67pHy?=
 =?us-ascii?Q?KuyuNwU9Uz+Bg1+EINRb5bO2RKm8?=
X-OriginatorOrg: sct-15-20-9412-3-msonline-outlook-fe3f5.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: bebb11a6-2ba1-405d-4512-08de80237b02
X-MS-Exchange-CrossTenant-AuthSource: AM7PPF5613FA0B6.EURP251.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 10:38:21.1935
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2P251MB1058
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[hotmail.de,none];
	R_DKIM_ALLOW(-0.20)[HOTMAIL.DE:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-33091-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[googlemail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,hotmail.de,qca.qualcomm.com];
	DKIM_TRACE(0.00)[HOTMAIL.DE:+];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mas-i@hotmail.de,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[hotmail.de];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[hotmail.de:email,HOTMAIL.DE:dkim,AM7PPF5613FA0B6.EURP251.PROD.OUTLOOK.COM:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 69CC3270687
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Enable fast antenna diversity on devices with two RX chains
(rx_mask == 3).  This programs the MULTICHAIN_GAIN_CTL register
to configure main/alternate LNA settings and enables the
CCK fast antenna diversity bit.

The AR9170 hardware has antenna diversity registers inherited
from the AR9285/AR9287 family, but the carl9170 driver never
programmed them.  For dual-chain devices this improves receive
performance in multipath environments by allowing the baseband
to quickly switch between antenna paths.

The diversity configuration mirrors what ath9k uses for the
AR9285 single-chip design:
- Main LNA: LNA1
- Alt LNA: LNA1+LNA2 (combined)
- Gain table: table 0 for both paths

Signed-off-by: Masi Osmani <mas-i@hotmail.de>
---
 drivers/net/wireless/ath/carl9170/phy.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/net/wireless/ath/carl9170/phy.c b/drivers/net/wireless/ath/carl9170/phy.c
index 290c336..bcd9066 100644
--- a/drivers/net/wireless/ath/carl9170/phy.c
+++ b/drivers/net/wireless/ath/carl9170/phy.c
@@ -536,6 +536,31 @@ static int carl9170_init_phy_from_eeprom(struct ar9170 *ar,
 	carl9170_regwrite(AR9170_PHY_REG_RX_CHAINMASK, ar->eeprom.rx_mask);
 	carl9170_regwrite(AR9170_PHY_REG_CAL_CHAINMASK, ar->eeprom.rx_mask);
 
+	/*
+	 * Enable fast antenna diversity for 2-chain devices.
+	 * Configure main/alt LNA with both chains for best
+	 * multipath performance.
+	 */
+	if (ar->eeprom.rx_mask == 3) {
+		val = carl9170_def_val(AR9170_PHY_REG_MULTICHAIN_GAIN_CTL,
+				       is_2ghz, is_40mhz);
+		val |= AR9170_PHY_9285_ANT_DIV_CTL;
+		SET_VAL(AR9170_PHY_9285_ANT_DIV_ALT_LNACONF, val,
+			AR9170_PHY_9285_ANT_DIV_LNA1_PLUS_LNA2);
+		SET_VAL(AR9170_PHY_9285_ANT_DIV_MAIN_LNACONF, val,
+			AR9170_PHY_9285_ANT_DIV_LNA1);
+		SET_VAL(AR9170_PHY_9285_ANT_DIV_ALT_GAINTB, val,
+			AR9170_PHY_9285_ANT_DIV_GAINTB_0);
+		SET_VAL(AR9170_PHY_9285_ANT_DIV_MAIN_GAINTB, val,
+			AR9170_PHY_9285_ANT_DIV_GAINTB_0);
+		carl9170_regwrite(AR9170_PHY_REG_MULTICHAIN_GAIN_CTL, val);
+
+		val = carl9170_def_val(AR9170_PHY_REG_CCK_DETECT,
+				       is_2ghz, is_40mhz);
+		val |= AR9170_PHY_CCK_DETECT_BB_ENABLE_ANT_FAST_DIV;
+		carl9170_regwrite(AR9170_PHY_REG_CCK_DETECT, val);
+	}
+
 	carl9170_regwrite_finish();
 	return carl9170_regwrite_result();
 }
-- 
2.51.0


