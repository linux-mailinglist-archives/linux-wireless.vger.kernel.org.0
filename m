Return-Path: <linux-wireless+bounces-33111-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wA7fH2DbsmlMQQAAu9opvQ
	(envelope-from <linux-wireless+bounces-33111-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 16:27:28 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1478D2746BA
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 16:27:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C8EBE30DBE02
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 15:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA55B33263F;
	Thu, 12 Mar 2026 15:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=HOTMAIL.DE header.i=@HOTMAIL.DE header.b="RGVdZW0g"
X-Original-To: linux-wireless@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazolkn19013072.outbound.protection.outlook.com [52.103.51.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50B5D31F996
	for <linux-wireless@vger.kernel.org>; Thu, 12 Mar 2026 15:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.51.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773328623; cv=fail; b=HO4YOzsq7NRbG0CkRBV0BgRxdG+s5VKgyOx9M2kxSBUl5Bx46IUHqXr2av7ZQn71ZgDII0ouiXVg4JMILD0VC2FXiUK/2WJAkldELYt2QAu7ueml4idwaSK/HvGLQHk8yBO19XhdoCsg/dNPPcVr8Lzggry/+a6zGUK7T051Wrg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773328623; c=relaxed/simple;
	bh=h3jkxiRWT2fz91WZNYqzYNiLuuI+keq8DyI29WLTU1I=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=lCb53+OOR4L3GUz0Wz/q0tJ8Ev1tRFKytxM1NWq6HMeCyV0eR1ehMG8p/N2wisQL0S95RQIdPmKYttgB/sEtlWSnv9Yea0ldCmTG193Fz9aQ2UR5E8hjpH7AqIZ1oqOBhFBhXrpAiyq6rSWGE6btNafTFZYvS/9JKqHSUkJUlV4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.de; spf=pass smtp.mailfrom=hotmail.de; dkim=pass (2048-bit key) header.d=HOTMAIL.DE header.i=@HOTMAIL.DE header.b=RGVdZW0g; arc=fail smtp.client-ip=52.103.51.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ov19VyPnv26Wx+6JK6+I6pIr5P7RqK1itFgC7yvuCHHBemsa8tJNNi/h+TtJgs4lZPzuA/bvYvKJoWuHRw44O9vXxhvPYdew6sfCKrYE23gDOw1qa3E42xwDuj9Njlm9prH2MRCXMWmQHAWClf/rYjHq06Glc6yJwsloXPUs+3T/7T1npTYYe9xhjqFPynazHH1ITrBw80fISHJBBHGIy/rYyIWgBO/bMqdB0mpmMM7OWLnL2+I1vFw578xmLz/GmM3FyO0wt4Y7rfxzzrOJM048EB4J+idFp2yjS9P3SPLpnTMfD5q2sQGXlEC6ZUhAOYds4roM8xQ/tnLkjn4w8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FywSk9WQtiJttrecCTQszfaq9jxSEE8gy8bVJ0l4eI8=;
 b=mEYKI5U3MkkkmCwkbsyXyoZXiVs6qSfu5BGZZfTUiHoGYC7dkzKEtF5elPWZLuX9PKSouA/s/UVUIZMZq/xofgnqfKyhw1CnRkdoQ8R978MvHy/I/BHBWNDRXTH7ZrOBC8WC6nf9I++FB2eHsRYVoyvW34TdnpPXGdKp+7iq67lvlIJIdLs5iyPx1ywMBKBvFrQLIM4ra8yOnuhZX5SThJ16N5gbIf8lgVdcwFbug4NhekSzsnelyVsM5QVSKKUDCeAK8ZuqOCkOmbJqLdxWUNeeFTdDxsnYGQLMeo0UzgodbLzb8xKQ+1p0P2wvL8t1xtISJuG0cZcjmv392DxLbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=HOTMAIL.DE;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FywSk9WQtiJttrecCTQszfaq9jxSEE8gy8bVJ0l4eI8=;
 b=RGVdZW0gm4Q4nxDarLURCOxm+W8GZAllWjKdB/74yaR/Pu30tacDMv+c5+O/p3MAUxaVF6plYOKjLw6gXMmgNraqMdaxJlF5Fy2IsQpd9/NZg5nWLZjYl2nWoiPVMglqJ44lsCmiSnANTM+cYYORvXdMFwQSqc1Tp/ZOQSQBuizJ3eRne7vfgXZkgjJ+SL6X3xnWu61gzskrE4XsOVUMds+6ZRh17Re5unnYUWlX9Xfv9OSG5k+5qYUdL2ZGvGoXQmi4mPHW6S6ct+Jpb5BbuUFyv9mVD/s88skjvHYiFyPdl4sWrwCgw7BdD9VwjBcKZt+AIMASWyOa7GJ0WJN65g==
Received: from AM7PPF5613FA0B6.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20f:fff1::851) by DB9P251MB0357.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:10:2cb::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.12; Thu, 12 Mar
 2026 15:16:59 +0000
Received: from AM7PPF5613FA0B6.EURP251.PROD.OUTLOOK.COM
 ([fe80::1ed:268:bd65:b36c]) by AM7PPF5613FA0B6.EURP251.PROD.OUTLOOK.COM
 ([fe80::1ed:268:bd65:b36c%8]) with mapi id 15.20.9700.010; Thu, 12 Mar 2026
 15:16:59 +0000
From: Masi Osmani <mas-i@hotmail.de>
To: Christian Lamparter <chunkeey@googlemail.com>
Cc: linux-wireless@vger.kernel.org,
	Masi Osmani <mas-i@hotmail.de>
Subject: [PATCH] carl9170: rx: gate data frame delivery on STARTED state
Date: Thu, 12 Mar 2026 16:16:58 +0100
Message-ID:
 <AM7PPF5613FA0B610E009DF7A1C575C0E599444A@AM7PPF5613FA0B6.EURP251.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0216.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e4::20) To AM7PPF5613FA0B6.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20f:fff1::851)
X-Microsoft-Original-Message-ID: <20260312151658.50077-1-mas-i@hotmail.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7PPF5613FA0B6:EE_|DB9P251MB0357:EE_
X-MS-Office365-Filtering-Correlation-Id: 52e2a253-4eda-4c72-9ab6-08de804a680f
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|461199028|5062599005|41001999006|8060799015|19110799012|51005399006|21061999006|12121999013|23021999003|15080799012|440099028|3412199025|12091999003|3430499032|13041999003|40105399003|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OoZBMSacqdZQOdKoJ7Sk5mKPsUuUYykPZebY5+SSrBED+HybxF4rxrabilWA?=
 =?us-ascii?Q?V1GzA8/6w0rcOKVMXj+ax0WOLl04+ZuZjImESDsfRBvCVPKpCFXHw/Djtg20?=
 =?us-ascii?Q?BtbRkphoRCLDjfBh96qdDlonlsvHsSLwQQOPnFcmKNpCQXymH38jfYd2tMHk?=
 =?us-ascii?Q?8Y4jSiTSkhPUAO2KCvccRdLrmewkWd70OHi3QsZu0cC8KATEKVDjlh6Wmq46?=
 =?us-ascii?Q?r6wqdBnNqrgGS0dVnftPvawrDuop1bZQF6ZN5HqtfAXcY9wll1w1QdrZhLsb?=
 =?us-ascii?Q?tDyNPHFhallBbICDKv5SnoZIwYwXGRXgBy9kZ9DgKK5JNbXTJoeKM9yG86Fs?=
 =?us-ascii?Q?fTgz4O4+w7hgLUJbnzU5BKqaWs50+Xz3wRuXlPE9ocxIdaS/WUtBlsEyyk3P?=
 =?us-ascii?Q?dYtf0mXOlMqUEoVXar8YtUuDCZgSEPUlaDi9zrGSKw6/Ny1J2yd2Iq786D5O?=
 =?us-ascii?Q?CiG2c05SgXwxFOvj8cDFzlidec0zFiTVFG3YKy9UuxRI+O9Ds2lPqaqByiQH?=
 =?us-ascii?Q?zu292RndOFH8FOXFsyYSvNzRZ7G/KKSIhEX9ouR/23KB3isPb4VDUV8rfrMO?=
 =?us-ascii?Q?ngU3r+t9qedrXz1ycP8R8chTnf2st3QmcYoMNfQj2xgYvLV+ZfhbO1VL70Vb?=
 =?us-ascii?Q?1mjCIhhwcg9DB+BA4XPU8kvjJDLbe8q8vc8oWZQQxGBJuqP8Bhg/tlCCk2F9?=
 =?us-ascii?Q?lHKro9raEVDtQ2uTx+aggoZxkMUvLqAMJcP1A77q1rk90apV22JcsXwVwom0?=
 =?us-ascii?Q?arKrkYc0RICMIC9V37uOSUNDipUkKgsEHsg+YLCgQfao9XN26yo9amiJlZqP?=
 =?us-ascii?Q?vVXRvumOo+Dipmhsr3xZxUnoohLv6QzpVKYpc64CrGqC7vGz7VfsKXneKkf1?=
 =?us-ascii?Q?Mv5uknf741LfKtcMfTHmX2A/9edguJHbyhmZQJAmAxgmmOqJ6F9Mz4nBr75b?=
 =?us-ascii?Q?9iIb3PRZFkStdxeleNWi/1c3mjkiZSzySylk62106QbafF0tJ13MrnZRIuRZ?=
 =?us-ascii?Q?/HHJDchJOLBrj5GEBrJqz3imnbWjUXvZeiUUSO/v3UrDKGyHIAi2ZZ2Sy/0o?=
 =?us-ascii?Q?M1PBaufycIOzLLRF/TH0F827Hossu652Tl/tfyIhvU3AilvsqZmBVan/OIye?=
 =?us-ascii?Q?xgmnBEyM1ayc?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?o3o3bciqb+hZ9TJuGvnsiz21I/nftxDfms+KzqOiDEtUNrXQSRS300XiW0S/?=
 =?us-ascii?Q?Q4TtygBRdfFCc+ocKweUQLbU3GR7mc8AYixlGUqWVhXDrQDeKmlQpMeuFw14?=
 =?us-ascii?Q?qjUIhhOsb1rtLvOQM+Q+6xBlW0BBuxf8GLWMRsAwPGBod41hE4nIohC9GucO?=
 =?us-ascii?Q?zttYDD/t4HqwUt9jh1rV3z+1S4ZorW2ZwAGEzIqkAStb8VwabkqSk50gM9PJ?=
 =?us-ascii?Q?yw5rdZvravusCkEsjyXrqB+x00zjEN4SwlZQCfK4rPw8uUoFzhFuSJHj2SBD?=
 =?us-ascii?Q?8jS6/AoTOBabJ5reGSCAYcaTYPfHNs0K20EJSTQ+O0ZZs114liuB2n9CmNm2?=
 =?us-ascii?Q?rRFfUcy6AQg8VRIe0WDMVxCB7oGNj4YgxmDpDZRxndEcHTUYE1b0rhrDZCZ0?=
 =?us-ascii?Q?B2dNqIc3H3cpNUSYFbR2DIgPpuc8gG9tuUaULmxEBI+lhrDUg0kSXb5qOxSv?=
 =?us-ascii?Q?v5GREnxHZ+sPHC4J0H/XwwxBoHrHVCtKb4zS5CcBAC3cafU9xCEIvd2KG+j1?=
 =?us-ascii?Q?MJvXmHXgdxTUaVMaju+SVBliy0feK0+BGhs6wEEkMxJ4lobBs8xUVM/ALb7s?=
 =?us-ascii?Q?CeaHKP5z+hCL9QoaJMbtSQlZUA1XHF3+O+P94VwVKkxPAGYrBPQSkHBxwQGv?=
 =?us-ascii?Q?bVevGVmDiU3DUw40qVcD+qQpSDeJ9x7ednBM9yWMn+gql+GfkIltbv3fcSZY?=
 =?us-ascii?Q?l0aWxAvhDxt1RC6v8kiSAv+s6kVJs7X32KNVTtZY6lL/Svn7EftHgNB5tlaE?=
 =?us-ascii?Q?BUuCuznPnwE3QAkl9USYM34TGAX3QTMIe5D7HQ09kGVers8S3NQm211w7Mjg?=
 =?us-ascii?Q?sW/VKXGVApZui/d99P5jHrtqqdySd1M5Bp3GPIbBFQV6V/4b00d3VXCIlUxB?=
 =?us-ascii?Q?iy3oWBRtlm2mG9yTb4OBB++f5MQgIlAoZ6MSpt/xKmhq/AUCtON+8TAKeL4m?=
 =?us-ascii?Q?H3wugVoWA36sw4D0XtRF9/8Uvg9MhHH0EwsVKAgoqenjxVC2FK39yXjU+pix?=
 =?us-ascii?Q?/hjLc3st3fz14ZhzAgoGBWtYdXZ4KNqKfvM/xBgApuGgg91WSROdCQ7qonQ6?=
 =?us-ascii?Q?7pIoBmB2s8vEy4rgXBEzu72pjrh9Rs+c3qRvcfRooLPmCfrdxovz7iXEMEFO?=
 =?us-ascii?Q?Etxqtp8ndaH4QRm+Kr37V7F6Kp1sXwkiq6aQk2Gpxiu6KCsb5LLyNbZesUJs?=
 =?us-ascii?Q?zozJ5TrF6SLMJZcKGkdJ4YeJGxAAx0TO7pGYLePqOJc2rswLK+qll0Z2J3gV?=
 =?us-ascii?Q?cRMmH2MFNCmqW2Q9S8HpoHU5XVm6TvW7J2iL+zwz/PlZfa8mHUUqzWr9jn02?=
 =?us-ascii?Q?RJDjNfFJ7edWkc0RIYY225Dt6DwEjDZdmps94gYewCHzk8jXK4gknZ+DuwUP?=
 =?us-ascii?Q?qbKNSgSy35VVmxHxdKA625EJZwD0?=
X-OriginatorOrg: sct-15-20-9412-3-msonline-outlook-fe3f5.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 52e2a253-4eda-4c72-9ab6-08de804a680f
X-MS-Exchange-CrossTenant-AuthSource: AM7PPF5613FA0B6.EURP251.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 15:16:59.7239
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9P251MB0357
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[hotmail.de,none];
	R_DKIM_ALLOW(-0.20)[HOTMAIL.DE:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-33111-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[googlemail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,hotmail.de];
	DKIM_TRACE(0.00)[HOTMAIL.DE:+];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mas-i@hotmail.de,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[hotmail.de];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,HOTMAIL.DE:dkim,hotmail.de:email]
X-Rspamd-Queue-Id: 1478D2746BA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Do not deliver data frames to mac80211 unless the device is fully
started.  After carl9170_op_stop() the driver state drops to IDLE,
but the USB RX path can still receive frames from the hardware.
Without this gate, ieee80211_rx() may reference station data that
sta_info_destroy_part2() is concurrently freeing during interface
teardown, causing a use-after-free kernel panic.

The race occurs when ieee80211_handle_reconfig_failure() clears
IN_DRIVER flags without stopping the hardware: cfg80211 then tears
down interfaces via ieee80211_do_stop() which calls sta_info_flush()
while the driver's RX path still delivers frames.  This was observed
when carl9170 firmware deadlocks during a restart attempt and
ieee80211_reconfig() fails at drv_add_interface().

The gate is placed in carl9170_rx_untie_data() just before the
ieee80211_rx() call, not in the USB layer, because firmware command
responses (including CARL9170_RSP_BOOT needed for firmware upload)
must still flow through the shared RX path via
carl9170_handle_command_response() which returns before reaching
this point.

Signed-off-by: Masi Osmani <mas-i@hotmail.de>
---
 drivers/net/wireless/ath/carl9170/rx.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/wireless/ath/carl9170/rx.c b/drivers/net/wireless/ath/carl9170/rx.c
--- a/drivers/net/wireless/ath/carl9170/rx.c
+++ b/drivers/net/wireless/ath/carl9170/rx.c
@@ -683,6 +683,14 @@

 	carl9170_ba_check(ar, buf, len);

+	/*
+	 * Do not deliver data frames to mac80211 unless the device is
+	 * fully started.  After carl9170_op_stop() the state drops to
+	 * IDLE, preventing a use-after-free when sta_info_destroy_part2()
+	 * races with ieee80211_rx() during interface teardown.
+	 */
+	if (!IS_STARTED(ar))
+		return 0;
 	skb = carl9170_rx_copy_data(buf, len);
 	if (!skb)
 		return -ENOMEM;

