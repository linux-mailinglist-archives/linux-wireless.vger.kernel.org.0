Return-Path: <linux-wireless+bounces-33090-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0BsMNbCXsmnENwAAu9opvQ
	(envelope-from <linux-wireless+bounces-33090-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 11:38:40 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E638E270679
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 11:38:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 709383013192
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 10:38:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65A9F1FDA61;
	Thu, 12 Mar 2026 10:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=HOTMAIL.DE header.i=@HOTMAIL.DE header.b="MCIrooqE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazolkn19013080.outbound.protection.outlook.com [52.103.33.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBE573876DA
	for <linux-wireless@vger.kernel.org>; Thu, 12 Mar 2026 10:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.33.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773311903; cv=fail; b=hyh646CYPPcRcbrMuNI0V7MxB3QuKHAFbN3bCCW7D5otWFl8pDG2UKhlcHbi8Fe0zyKOWJiFp3uJcutjngzgVuiWVwxHsQfRsvjAXLKoJQXWWgkA0gqYOw8t97hQHyOdUMzecwyQLSczHA2eSm3BblAZtbbgTxFpfzCh0NQtjus=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773311903; c=relaxed/simple;
	bh=h85ssN8TFPuMnp+617LB0RQzKMHPpLRCrIMhfSyUzRs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Qh2DNCXWE/XXdeHM9jnvnqAiVyyDugI2HNP/S8mCddPutE09yXh2edI5hN3Qq8RQ/Ax/qvWS01gcbpoFS4B7Zbr1DRnV3uXPF6s6548Ubul/Nbvgk5vQiipU6mNm0UAYd6XquoZRuGJ1tYNjlWYXM8lVkPE9uNsCc6M+elH5cwg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.de; spf=pass smtp.mailfrom=hotmail.de; dkim=pass (2048-bit key) header.d=HOTMAIL.DE header.i=@HOTMAIL.DE header.b=MCIrooqE; arc=fail smtp.client-ip=52.103.33.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ry/UnEYAH7yP+LtIo+GypNpuxdqiTD08e0XbAap1ljbsoTVdHFGwYcEUdm8kP53gmyK8g6Qj/7sVvwpeYGZno1B4Jk6jPCsVLp2EkNoH0vPKOQR+Hfni2+oJBH8avj+H4/du9VHDHgBSalE8IjFWmP3BaGIwpgiOFA0p9FhebWLxTfo7CsnGYFrmE1T/Wr5xbD9tImO8DpLvIk/EYd5y+3Eu1jAGJPc4av65Sha1YS7Xt/ByuNEx92GiFZbWELV9yfMfF+4lVXCyE75Fvxlu/5pWcT8xQXWzPMRy/Nh1TNo1j1GKYfCVJ5ixyLA2P3SPm9v0Fs2dZ0pEPLsWvhG6XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e+DxJ19QwP0S+7L5IhF2FJ5oQBrDSFweZwCNuCfgNgo=;
 b=rmjsI1Lly+DNkQZsxlQ+KtxzPwc+IPdNUGKWmn9gS4a+wuRlU/B+twtv6ke1B4HMTKWhka4Zq/BxGmP4pFw6NnSsy0EuON22iUwPoTKPuYnV6lSSxDSeBGjhDMMcYSEhOkZIjQ+GI/tpVDBiu/tl6dJvavDosQsdOGxFGAyEJ+6p1RXOexZvrAZivbZQR8qEt5AKfAEkVWCGXFyfE8bfiBNqIKkW+Hjj5RByvPMoBxt1A2xAqJmFEjTQX+KFF4zey2PX/Ei6tT68z3rewtzAY92Ia31LijR83hpEmr+/4IWW5H1xLEIzZTsk1ykWShMEezs7tYLplCVesacdE+l/2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=HOTMAIL.DE;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e+DxJ19QwP0S+7L5IhF2FJ5oQBrDSFweZwCNuCfgNgo=;
 b=MCIrooqEWghcLPS+VFfvc6h0rEmIwti3Cf6dnjUTrRS8KZvKsEtKWgJs2SYLoOlhIHrGtSAomm/Z+LOu0ZCMWdLHmELpFxl+vRYiHbDv7geDFST5GzqXD2PtoXoe7DIzSsFGfnmCqmwUG1B+4r4A5pl9+QB4swL+UOeWmB0LL89dczcapAJXodYb8KQ6tkgGkIOhD6i9Qf/pJU6x0qLRZgAPQQZoFWr+1uvxafcON9GVDBeX6S99yUw93xprjWMQAbqYQyr7kPhTe879M++hOF72vFK4vOMe9EIFMJtdbgfZjk1LLSD948ZFIFyp3MZirBrgWeqM3nJB/ogDnDYmYw==
Received: from AM7PPF5613FA0B6.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20f:fff1::851) by PA2P251MB1058.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:102:40d::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.25; Thu, 12 Mar
 2026 10:38:19 +0000
Received: from AM7PPF5613FA0B6.EURP251.PROD.OUTLOOK.COM
 ([fe80::1ed:268:bd65:b36c]) by AM7PPF5613FA0B6.EURP251.PROD.OUTLOOK.COM
 ([fe80::1ed:268:bd65:b36c%8]) with mapi id 15.20.9700.010; Thu, 12 Mar 2026
 10:38:19 +0000
From: Masi Osmani <mas-i@hotmail.de>
To: Christian Lamparter <chunkeey@googlemail.com>
Cc: linux-wireless@vger.kernel.org,
	Masi Osmani <mas-i@hotmail.de>,
	ath9k-devel@qca.qualcomm.com
Subject: [PATCH 07/10] carl9170: main: add exponential restart backoff
Date: Thu, 12 Mar 2026 11:38:02 +0100
Message-ID:
 <AM7PPF5613FA0B6C3933233D4272D36007C9444A@AM7PPF5613FA0B6.EURP251.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1773277728.git.mas-i@hotmail.de>
References: <cover.1773277728.git.mas-i@hotmail.de>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR5P281CA0032.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f3::6) To AM7PPF5613FA0B6.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20f:fff1::851)
X-Microsoft-Original-Message-ID:
 <a7b861f668598df1c42b8202cf73668a22f97d1f.1773277728.git.mas-i@hotmail.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7PPF5613FA0B6:EE_|PA2P251MB1058:EE_
X-MS-Office365-Filtering-Correlation-Id: ef462647-4703-4735-7677-08de80237a0b
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|461199028|51005399006|19110799012|8060799015|41001999006|23021999003|15080799012|3412199025|440099028|3430499032|40105399003|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NIZYRpxvPSykQy3QBgH+6n5uqVnYljY6ZPnPynBnz7il5cosPAfJHeXUP6Gw?=
 =?us-ascii?Q?c+TFTcTWCJgIlI8vm27Gytj3w/TlGJ2GfhIDB9NakAzAoTYVOIVGm8NMGWNq?=
 =?us-ascii?Q?/RPsQDR2Dh73IArHWMdEUJsIWQljmv3PWrkWKOW+vgNFoOoVOpjqfyD2nl/X?=
 =?us-ascii?Q?lxiSk2MJyaQMoVvLFx9HMLrL71a8v9oTJE5Fs3KgFkxjbbzNCvrpmPOXDinT?=
 =?us-ascii?Q?Glt7ZEQ29VrpDxduoWl4QWI268uNnWJW4JSDP9nSQpBYM5x2CmC0IqniBJkp?=
 =?us-ascii?Q?VUcLkWKOPDAf6aUNaY0U05vaXmw+Cu4t1ML3ClEv2ag3pLnAdl7WfDgW6r6b?=
 =?us-ascii?Q?rckZNM1qk9ofLfHshixmkG3BpcpCrEonP9IPaEgeRr8Zd9P2efZIgaMmOmfp?=
 =?us-ascii?Q?SknmgjSiaxnu6YKwTJtPag8Xcu3TIP9uO4r3Kh7pBtqdbxK/Tk/TLA7yX1JE?=
 =?us-ascii?Q?AkBK7LRtXdjGJ5It049V0Gq9IbE585Mo5Je7P17K3Ar8+uK1+4rp+pa77xeo?=
 =?us-ascii?Q?Lx7IDjZftXdhiJ4KtuZqzmWnqVN29bpVClyBklgwWfT9ka4rwVTqI/1H09YP?=
 =?us-ascii?Q?FTnwVz0P8zutKp89vuvHaO1dGA3OjlWj1NbdaTntHr8oAQJ07SLDLpI80/oM?=
 =?us-ascii?Q?2nuMCEkcxIQo8yhLDF8stqhAgnp/i02ydkQEM6Q1LLIRLG81ffP6+PlKdbgw?=
 =?us-ascii?Q?cC+05f/KNPKprDmCs0zqh4/PSUf+DGjeijiljRX9gEhG1akzdm/vyVipikoe?=
 =?us-ascii?Q?IUfGivRnttUxd+7sklfVYoDfd8uQBYaSTaAZisC5XFxOT+eu4k9+44pYqFr/?=
 =?us-ascii?Q?/ev/PgV0xyIcz/YD9Pn5Psw59vAx7JSntHQrEr+sis/FZDqp1QdEimC0qznU?=
 =?us-ascii?Q?DG16AiG1uzjTyg0NAe6NkACw7UCG2E2CoNKFuRCYiuzFwfirySI7EEegUISD?=
 =?us-ascii?Q?oj7/LvdDsBtR7acTPpFGcg=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?a8UhdNLgLhpAUrysle1x6qsYqjJmgbpghZBqKxrzNZSS3vwwQDYBUEw8q3al?=
 =?us-ascii?Q?KFzDW2H2CAGaLYcXdk2AS2gLLrK02Awl3cA+VhskwHXjoQ65duAd+6MZbzA+?=
 =?us-ascii?Q?zXh8I1VB+1tljS3sX5fGvUAOZ2uYI8MRTz292MWle18NEAbR0C7etWaUjTiW?=
 =?us-ascii?Q?SSzC3IeSANnpXrQQev7Z4d8NZV6yCA/53cz4lwXjyJhfH/o2zrfohYqTNzpL?=
 =?us-ascii?Q?RfGAAsEUSM5EhSDVMcCQota0qX+WRGgrdORF/Eb9/KZHkhn+n2fVRek5x4jA?=
 =?us-ascii?Q?frgtdUbEh3GephxIkW0edUAAWc21hMcsDynv7y59qLmkndQwBT1qBJYqSFIH?=
 =?us-ascii?Q?DeeoNQJCD98a7rR0ixPCy7rCtwfQhAY5UHTKgG14aVKXn808ypWX+RNgvID2?=
 =?us-ascii?Q?EDEup3XNz1iT+GutJGvMxQjEF5BhCRI+0ah+B+RQkXM8UNm4x7nQ+nCXAzlm?=
 =?us-ascii?Q?ZMmYzQkt/CSFHHcZutxf0Rjfpoitht7TDw9GS20vz1AXlGv0SWOOd2QNmdgP?=
 =?us-ascii?Q?87Oo4uuOaVJ/RWGX3DvFjqI2paafEFVZ3+hXo7BrId51xY4z8kjLoCNzJxZG?=
 =?us-ascii?Q?u0KjEObqolT84MP/vfDSgDtaogMoUL6ZRWWrZLLIrvH8dbWeQTa0Jo6+qc5q?=
 =?us-ascii?Q?PhbLam560zWxwStgXoJtjdd6YVsjY3Ca81+nmslr1ToqOshCt6bGoBmFNY2G?=
 =?us-ascii?Q?MQAwq6CEB0wIP8ywmMegg0nfpkmBI7yFtbig83RY7nFksI4Ygmge6ZBJpf24?=
 =?us-ascii?Q?k9nxIBHImCfxpU1AD9FC5te7YQBVZ01//63ULmXQLOVRNhVWQQVnyZDlFo9g?=
 =?us-ascii?Q?j8HOYgAnt8Sg9ff0rmIVoZGpsc8NQtCO7+Eg77qfZbKbxAuVkJbLOKIkHJVu?=
 =?us-ascii?Q?TCYN5sAY2ONm2dx6d1xERXMFMcc0qOiD3l8yZ/5pQxFb/oI4Kt5k5vTyAvZp?=
 =?us-ascii?Q?gpK9fIGFKHdPe7mLdZdEhnTvG2hUZLy4cm7Dpops6ke4akW8FAj0QmnwbQu0?=
 =?us-ascii?Q?Tiumt6nhaR6TP/Ie8MaVMpg+m2Al2HqPLgwwOTrFLceYUJiFU7k/+sDmc9IJ?=
 =?us-ascii?Q?3bTpLYY4vy4GpckuQHbxEL40BGYayT8p4j+tR57pvTIyu5oBulbod39+kzYZ?=
 =?us-ascii?Q?/7sc7zM0upB0Cg23oPTFMEUl2fDU5qo4/ohzL22VssoTZWrTj+VJriUXukO5?=
 =?us-ascii?Q?YU9x/sKKdkK2/sZHQoX2pKyD5Fuw0CXTIydwmyXFjRopxX3vSjs3gBeW0n29?=
 =?us-ascii?Q?62M4lnooBADP4onTs5KNHqU4mXBKt7s3cVG6f5QiAhGhfmB+SiJ5ElgFu+oY?=
 =?us-ascii?Q?7di344BZ2IZQ4qwnb5N1+9nXk5z8sDvAE31UwogJ/a5jYBPm52sv1ysp6RKL?=
 =?us-ascii?Q?iIcICDgEZyOO+FczYPnRTkDPponu?=
X-OriginatorOrg: sct-15-20-9412-3-msonline-outlook-fe3f5.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: ef462647-4703-4735-7677-08de80237a0b
X-MS-Exchange-CrossTenant-AuthSource: AM7PPF5613FA0B6.EURP251.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 10:38:19.4733
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
	TAGGED_FROM(0.00)[bounces-33090-lists,linux-wireless=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[hotmail.de:email,HOTMAIL.DE:dkim,AM7PPF5613FA0B6.EURP251.PROD.OUTLOOK.COM:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E638E270679
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When the AR9170 enters a bad state (firmware errors, command
timeouts, TX queue stalls), the driver can trigger rapid-fire
restarts that prevent the device from ever stabilizing.

Add exponential backoff to carl9170_restart(): if a restart
request arrives before the current backoff window has elapsed,
the request is throttled.  The backoff starts at 500 ms and
doubles on each restart, capping at 30 seconds.  A successful
restart resets the backoff to zero.

Additionally, use named constants for the firmware error
threshold (CARL9170_FW_ERROR_THRESHOLD) instead of a magic
number, and add a window-based counting approach to avoid
accumulating sporadic errors over long uptimes.

Signed-off-by: Masi Osmani <mas-i@hotmail.de>
---
 drivers/net/wireless/ath/carl9170/carl9170.h |  2 ++
 drivers/net/wireless/ath/carl9170/main.c     | 27 ++++++++++++++++++++
 drivers/net/wireless/ath/carl9170/rx.c       | 10 +++++++-
 3 files changed, 38 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/carl9170/carl9170.h b/drivers/net/wireless/ath/carl9170/carl9170.h
index a2ffa62..2eedb2f 100644
--- a/drivers/net/wireless/ath/carl9170/carl9170.h
+++ b/drivers/net/wireless/ath/carl9170/carl9170.h
@@ -301,6 +301,8 @@ struct ar9170 {
 	bool needs_full_reset;
 	bool force_usb_reset;
 	atomic_t pending_restarts;
+	unsigned long last_restart_jiffies;
+	unsigned int restart_backoff_ms;
 
 	/* interface mode settings */
 	struct list_head vif_list;
diff --git a/drivers/net/wireless/ath/carl9170/main.c b/drivers/net/wireless/ath/carl9170/main.c
index dcedcb1..ebf9fa9 100644
--- a/drivers/net/wireless/ath/carl9170/main.c
+++ b/drivers/net/wireless/ath/carl9170/main.c
@@ -492,6 +492,7 @@ static void carl9170_restart_work(struct work_struct *work)
 	if (!err && !ar->force_usb_reset) {
 		ar->restart_counter++;
 		atomic_set(&ar->pending_restarts, 0);
+		ar->restart_backoff_ms = 0;
 
 		ieee80211_restart_hw(ar->hw);
 	} else {
@@ -505,6 +506,9 @@ static void carl9170_restart_work(struct work_struct *work)
 	}
 }
 
+#define CARL9170_RESTART_BACKOFF_INIT_MS	500
+#define CARL9170_RESTART_BACKOFF_MAX_MS		30000
+
 void carl9170_restart(struct ar9170 *ar, const enum carl9170_restart_reasons r)
 {
 	carl9170_set_state_when(ar, CARL9170_STARTED, CARL9170_IDLE);
@@ -519,6 +523,29 @@ void carl9170_restart(struct ar9170 *ar, const enum carl9170_restart_reasons r)
 		return;
 	}
 
+	/*
+	 * Exponential backoff: if restarts are happening too frequently,
+	 * increase the delay before accepting the next one.  This prevents
+	 * restart storms when the device is in a bad state.
+	 */
+	if (ar->last_restart_jiffies &&
+	    time_before(jiffies, ar->last_restart_jiffies +
+			msecs_to_jiffies(ar->restart_backoff_ms))) {
+		dev_warn(&ar->udev->dev,
+			 "restart (%d) throttled (backoff %u ms)\n",
+			 r, ar->restart_backoff_ms);
+		atomic_dec(&ar->pending_restarts);
+		return;
+	}
+
+	ar->last_restart_jiffies = jiffies;
+	if (ar->restart_backoff_ms == 0)
+		ar->restart_backoff_ms = CARL9170_RESTART_BACKOFF_INIT_MS;
+	else
+		ar->restart_backoff_ms = min(ar->restart_backoff_ms * 2,
+					     (unsigned int)
+					     CARL9170_RESTART_BACKOFF_MAX_MS);
+
 	ieee80211_stop_queues(ar->hw);
 
 	dev_err(&ar->udev->dev, "restart device (%d)\n", r);
diff --git a/drivers/net/wireless/ath/carl9170/rx.c b/drivers/net/wireless/ath/carl9170/rx.c
index 414d499..bb909b5 100644
--- a/drivers/net/wireless/ath/carl9170/rx.c
+++ b/drivers/net/wireless/ath/carl9170/rx.c
@@ -46,6 +46,14 @@
 #include "hw.h"
 #include "cmd.h"
 
+/*
+ * Time window for firmware error counting.  Sporadic errors are
+ * normal over long uptimes; only a burst of errors within a short
+ * window warrants a restart.
+ */
+#define CARL9170_FW_ERROR_WINDOW_MS	10000
+#define CARL9170_FW_ERROR_THRESHOLD	3
+
 static void carl9170_dbg_message(struct ar9170 *ar, const char *buf, u32 len)
 {
 	bool restart = false;
@@ -54,7 +62,7 @@ static void carl9170_dbg_message(struct ar9170 *ar, const char *buf, u32 len)
 	if (len > 3) {
 		if (memcmp(buf, CARL9170_ERR_MAGIC, 3) == 0) {
 			ar->fw.err_counter++;
-			if (ar->fw.err_counter > 3) {
+			if (ar->fw.err_counter >= CARL9170_FW_ERROR_THRESHOLD) {
 				restart = true;
 				reason = CARL9170_RR_TOO_MANY_FIRMWARE_ERRORS;
 			}
-- 
2.51.0


