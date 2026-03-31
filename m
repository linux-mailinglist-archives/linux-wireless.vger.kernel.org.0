Return-Path: <linux-wireless+bounces-34225-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +KaQKnQZzGnHPgYAu9opvQ
	(envelope-from <linux-wireless+bounces-34225-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 31 Mar 2026 20:59:00 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EA7F370498
	for <lists+linux-wireless@lfdr.de>; Tue, 31 Mar 2026 20:59:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 305613067712
	for <lists+linux-wireless@lfdr.de>; Tue, 31 Mar 2026 18:58:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DC702FD7D3;
	Tue, 31 Mar 2026 18:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=HOTMAIL.DE header.i=@HOTMAIL.DE header.b="slZ1upr0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from GVZP280CU018.outbound.protection.outlook.com (mail-swedencentralazolkn19012071.outbound.protection.outlook.com [52.103.35.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECD973A16A3
	for <linux-wireless@vger.kernel.org>; Tue, 31 Mar 2026 18:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.35.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774983503; cv=fail; b=D9o1lEDlfUVq1gv74PoeWCSRv7551EAlnXBaiFqcA9MIfh4YCcvvRCNfpEjDlELPfkjFuoCj9eewa7G4jVdUAHk09WkCj8u4dc/v4aD9FeNkEVYa1YPkRLGeWN5w65RW5la5rc77rxm4zYJKbzz0mAAEwm6C84sUawY0P1MCaIY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774983503; c=relaxed/simple;
	bh=29CZg+iYvYkW7wazjDjA69qaKdl4lhkLryYzgxPGVEM=;
	h=Date:Message-ID:From:To:CC:Subject:Content-Type:MIME-Version; b=DJsC43h5L6kYrwOxGYGy/dnRnA5LbW2zZMaPEDmF6Usiq5TKkBSfoqjcmaAWc6Cva1SQpHn3KqKeSHEyzcxVZeCtT5j3ZvR5muGfpRrBeDpWL9JIqVU4G22vnfKoon2WJ2gBtinnzpTkS3eLCCWPTXKPthZZ+XV1zdmORH5Ud8g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.de; spf=pass smtp.mailfrom=hotmail.de; dkim=pass (2048-bit key) header.d=HOTMAIL.DE header.i=@HOTMAIL.DE header.b=slZ1upr0; arc=fail smtp.client-ip=52.103.35.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dp0XrTEq3sDBqwRrFA7b5irnL2GLtzHmJKGTz47Z8OkXf+zcwC9TAGFt/GjBekrS5075/okVVxA05oAkGDAtlhKdrAlHwD3cEdCM5cbmrvUjkA1XxpPEGeI91hmFXW1+7kwTGR+IupNzFH8eSrMWUxw/KymL63BjXkfc0dpm7me+jrVfmcoB/oN2z9tDQRx9CP+ed3vPmtlCAgteTgghQD0VqFTEUIttspgW4YuHYLCD3iK12nKjld1WznDyrrrrBqWVnrwuTx2nk0dRhWuAXBM0MB20B2AfZTCr+QHZp55dkM4Wk6MfjDtScOPTTlrcGdOdQ3XAVLCAn53tD6+f2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OteJ0qIe2K6COe9pBJyJ0TKAnv8E1F0kTCOlWnzL8js=;
 b=NfOt5hjiL9amENeRTDsvRTMRGeBjOM/lF2VCm/XtoM7S3ZGD4KhWux3FgAu/TEPZiS0oQCOAfXAXKNw5r4eRzTHIQceJTClTibOGFtPf7qgWONkvyUO+tiJuzC5OO6ltXOqopbqTC25EhW6JNcInUNQMe1V0smcnDSAAmUnEDSLOGaNjFdQIkRHlDti1APmvvokJ8jXO17UavMIjnu64nzBhKgDVI6KJRqkG5JrdVu1+9eUqMc0c5nCFJMXBvxtHIbs4cEqSKSXRY/t6B1e/LweXV24j/FlSQYTf1gdJ47Utm3bfcPNg75r78a48a1vkRSEMJN8xkE8L5ip4HX+fJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=HOTMAIL.DE;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OteJ0qIe2K6COe9pBJyJ0TKAnv8E1F0kTCOlWnzL8js=;
 b=slZ1upr0FB1fvduPOfnpwZEExkb4nS8BfbQ5UVM10oeS2PTvpnV+IcVMswjP/QZ6ms5HDAZrLobRB2Y2RTwHmDBqIlYABmJcfCe4ihrvbp2GfZLdWP47Q3IPpoeUZalCeTOnNfxrOdIIBGaPFQQQy2pTmIVpK+0Y722SiFb7w/Iiph6YFogG1cxglVihDANfXoIcpK1bswKPTi93rMdvRxZVU3rKSwkuTjBkOf8crHgRrqSK2l3OU/TFBGS3M25Xc21z7L61ZCBTBaH/FhdafDwPz92hJSgcHX2uRzOxfdjiRO0FvqQc1GArG193cs9yB9VLXXvy9KpNGNIvNNbdKw==
Received: from GVYP280MB1518.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:19b::9)
 by MM0P280MB0978.SWEP280.PROD.OUTLOOK.COM (2603:10a6:190:2::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.28; Tue, 31 Mar
 2026 18:58:19 +0000
Received: from GVYP280MB1518.SWEP280.PROD.OUTLOOK.COM
 ([fe80::6328:bea5:c218:593f]) by GVYP280MB1518.SWEP280.PROD.OUTLOOK.COM
 ([fe80::6328:bea5:c218:593f%4]) with mapi id 15.20.9723.018; Tue, 31 Mar 2026
 18:58:19 +0000
Date: Tue, 31 Mar 2026 20:58:17 +0200
Message-ID:
 <GVYP280MB1518FB3FAA4B157AD47C0DF89453A@GVYP280MB1518.SWEP280.PROD.OUTLOOK.COM>
From: Masi Osmani <mas-i@hotmail.de>
To: Johannes Berg <johannes@sipsolutions.net>
CC: linux-wireless@vger.kernel.org, Christian Lamparter <chunkeey@googlemail.com>
Subject: [PATCH] mac80211: stop hardware before clearing driver state on reconfig failure
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0075.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1e::10) To GVYP280MB1518.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:19b::9)
X-Microsoft-Original-Message-ID: <48fe513847163fba91ebb855ce28ffad@hotmail.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVYP280MB1518:EE_|MM0P280MB0978:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d3423e1-a62c-453b-c684-08de8f5778f5
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|23021999003|19110799012|5062599005|461199028|8060799015|15080799012|51005399006|5072599009|440099028|3412199025|12091999003|26121999003|40105399003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JR22YW1eAXNpRtCALLbwk+jD/4JHC0TMOCkwvVo8SMc/2Ps9eM0MRv73UdGD?=
 =?us-ascii?Q?ChGaiaBXwUCyZ1R6DBBDwOSE1zMlfYnWLFsQoTuBXRHWrFrTSXrXjw4oRZf9?=
 =?us-ascii?Q?MzLb0A/UzAF+8t48LhcwWqcCC078MiMbolRvUjmD3Mdrw6riH1XNK7lMf+u5?=
 =?us-ascii?Q?ch+QYWfiKs+jH7cw8/cVHVbCab0h170XfhyBbQ+cnl9Obl1yXDKBZG216d3s?=
 =?us-ascii?Q?Tz7pIcmIkNwg2xdsOWR4HjA7bzYWMwXfYaO2MEDeRj4fZv5oQ2A2odOMv7cD?=
 =?us-ascii?Q?g8vvkTp5p6RIVtaIG9XEcV8iCidb8rjgRiK+tEbEW/LWcRKoO+8LeyICKQ2j?=
 =?us-ascii?Q?LL0tA6ef1lNPltqGDyh2NmSQ1rsnNnE5atUu2FuOI500VOwxcEveF5mZ0lhs?=
 =?us-ascii?Q?QfCggafcTB7D//D39Awhbo9ikB/Es85S1i4c/NEfg7K4O7gjVrGXqcyLaGMu?=
 =?us-ascii?Q?crBlZYSPES2AqnvFSPkFA3JZwUNL0cFS6pPRbs2OA9ZV/WT2LIB3300OPXIE?=
 =?us-ascii?Q?dKe+mPM6e+bSOUY+US1oiwFSvRCkjHq97shx2xYLrSyTMyvXnrC3l4fgKghq?=
 =?us-ascii?Q?mc1VzoFmS4X+08PnvFNyJ2RtldZJh7scUyBU7lFusklFLAzfJxZSussUd0gN?=
 =?us-ascii?Q?XbNSr2WZcXVfr0mIcEC6b2+hyksLrVmm/TVi7ehI09X8wL0SPoQAC7Zmxm46?=
 =?us-ascii?Q?qRx30ZH6NU1QtC9btMSYIBWl8QAQV/T1ylHuaGRUxuXowwH/qPYr1HgBDzLP?=
 =?us-ascii?Q?zdvQPMvZUlYXIYHOIvpiZW8xZcJmCrsx4BnG66Klb578br8vgr3AJhIw83Q5?=
 =?us-ascii?Q?5Dlni/ulAWcrCuXg2BkLDl2mXD8gE7Oi0+FbON5rhJYM2++bycbU43ScpzIA?=
 =?us-ascii?Q?HESwCHILrXKkrQ817TqAhP8yMlvTSfTd9SbCrBrcn8GKIzocM2VkPndHm4mi?=
 =?us-ascii?Q?/5lXMtGOtT1PGksN8ePctMwGOKq5DLYf+bjip3fGU5WpRv7GUkJ82HPbQ0u+?=
 =?us-ascii?Q?WveA?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Mie0F23hYRr5wW4SScpUUPcBzNIEMtL4cn/rthhb17g8oW5NwH294YwjEunN?=
 =?us-ascii?Q?K7mkDDPOM52gqF51cQ0KRmoSVa7evDrQjcwh5hI9RLAZMdvo6RHk4Y0jen7+?=
 =?us-ascii?Q?+VlIqo/8ERgOZINJxJR3Dy+WylhcU6V4N3HH66N65SLqnqfUsyYVLQ6r/7bd?=
 =?us-ascii?Q?hpmvtEwTi08jTHAdgZqNypLfBx0nBr98N9cKrhWMlVg7qLiRn1SqWWZbh9sv?=
 =?us-ascii?Q?bakRZjcp+e0DsZZ+Pk73RVG44PvWlQvvJnmZ0igxfsxLp2xkCHLs0ql7Qm0E?=
 =?us-ascii?Q?g4ObciB7bw9jYBeFlQ+mq72TRe6/9lVMtE+N+g0l6STsICCmpIMSFi7KCNvj?=
 =?us-ascii?Q?y7Rbi/HA9cdUuPlSSnVrRmNEIX0WM5Idyui91V7XWNTgfXCR6R0Tu204RlHP?=
 =?us-ascii?Q?qcw97Gp+sYKdXU0h4rLwGiiCrSu82AzdBwRUdFXUbUJELfceS4LWp8zuAkVS?=
 =?us-ascii?Q?3FyBdwuJ94DVns05NMpNhhy8sfM7N+EzEpCZhtrXHVr6iGV48CtRddA3jwtM?=
 =?us-ascii?Q?qjC0IBIMghnldCO7HSioSlK2XP3nBSdoNBXHSAgDm0ka1Jrh9xKisbIeL0mV?=
 =?us-ascii?Q?SS4R7CnFzsSK0JGxtN9wcmqKzMlB01TAzKSiOSjW/TqT4r5eQ/prbFGsumM0?=
 =?us-ascii?Q?rvjlmLaz+h6c1HYsQpSV7omic1m7muaj9DN6Fzgk+VW1yscfqWukesOJprqO?=
 =?us-ascii?Q?nVm6uIEt67EVWsnlp9hLhtUKV5gIrOI1UMf+AZKsulgb+t2nwVPuS2HZ8r30?=
 =?us-ascii?Q?zTLj+TIOhOw/p/dtOs+FI8Uwf8bJTZKBoMI7tBQT5sAHIKUKFxO146XUqoNi?=
 =?us-ascii?Q?vQvCIz+wSpZp5cgt/yj8cP39+rLs5g+7jeDyd7KxADr6jPfRn6AdkpMzI9xC?=
 =?us-ascii?Q?r1VSdFltve0xgjnNojlwMmFolbTj7QUS8/lTKjkFvuGLzVv7Ogimfq9Jr16v?=
 =?us-ascii?Q?UYe7wZv9q3cFsRCPHd1HUqV82HVl5MiAPEaWphkqDouUGS2tPaq+gCzAWRfR?=
 =?us-ascii?Q?YI/Yt9XkTiq8Mj6Yh4Phv16ndIUkYxCW7PQahzyQB9Pycgr0dZb/9HHj+FqB?=
 =?us-ascii?Q?Wot0/23CVER3zFZC8UjUedcnFivZRE21rssqvsqkHGyhqXnnonfc5oTjz6Hd?=
 =?us-ascii?Q?xvHRisFZMEfOOIKaGHxA15HfwvrQvy8cQz7UcfUsYdt01LNZQ/5h3mUX1DUj?=
 =?us-ascii?Q?/JSwfo+RvKbu7jBZgrEsowWLRY/nCl9p6hpkNrxLCUqCJoEtcrofu9l8t7kg?=
 =?us-ascii?Q?dl0pPH8xz7stulQbUB8WKSUIUhWbbp2C5ObyBKtPNDyhJgllVHG8kMVhwvg+?=
 =?us-ascii?Q?D7SsHzoRQm5fkffIaAYYEe8Y5IGf9ybMrgz0S39zXh/GAVLtIGbOKQq4q5j0?=
 =?us-ascii?Q?hWyDLmzLpeUHjVmie0jGYYDiSrJC?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-10872.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d3423e1-a62c-453b-c684-08de8f5778f5
X-MS-Exchange-CrossTenant-AuthSource: GVYP280MB1518.SWEP280.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2026 18:58:18.9579
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MM0P280MB0978
X-Spamd-Result: default: False [3.84 / 15.00];
	R_BAD_CTE_7BIT(3.50)[unknown];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[hotmail.de,none];
	R_DKIM_ALLOW(-0.20)[HOTMAIL.DE:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34225-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,googlemail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FREEMAIL_FROM(0.00)[hotmail.de];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mas-i@hotmail.de,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[HOTMAIL.DE:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[GVYP280MB1518.SWEP280.PROD.OUTLOOK.COM:mid,hotmail.de:email,HOTMAIL.DE:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3EA7F370498
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Masi Osmani <mas-i@hotmail.de>
Date: Thu, 12 Mar 2026 02:00:00 +0100

When ieee80211_handle_reconfig_failure() is called after a failed HW
reconfiguration, it clears IEEE80211_SDATA_IN_DRIVER flags on all
interfaces but does not stop the hardware. This creates a race window:
cfg80211_shutdown_all_interfaces() subsequently calls ieee80211_do_stop()
which runs sta_info_flush() to destroy stations, while the driver's RX
path may still be delivering frames that reference station data being
freed.

This race was observed with the carl9170 driver: when firmware
deadlocks during a restart attempt, ieee80211_reconfig() fails
at drv_add_interface(). The subsequent interface teardown triggers
sta_info_destroy_part2() while the USB RX tasklet still calls
ieee80211_rx_napi(), causing a use-after-free kernel panic (hard
system freeze, power cycle required — no oops saved to disk).

The race condition:
  1. carl9170 firmware deadlocks → ieee80211_reconfig() called
  2. carl9170_op_start() returns -ETIMEDOUT
  3. ieee80211_handle_reconfig_failure() clears IN_DRIVER flags
     but does NOT call drv_stop() → hardware still running
  4. cfg80211_shutdown_all_interfaces() → sta_info_flush() frees
     station data
  5. USB RX tasklet delivers frames via ieee80211_rx_napi() →
     use-after-free → hard freeze

The fix stops the hardware in ieee80211_handle_reconfig_failure() before
clearing IN_DRIVER state, ensuring no driver can deliver RX frames once
the teardown begins. The drv_stop() call is guarded by local->started
since some call sites reach this function after drv_start() has already
failed (where the hardware was never started).

Christian Lamparter (carl9170 original author) reviewed the carl9170-side
companion patches and confirmed: "If what you write is true for an
up-to-date kernel, this needs to be addressed in mac80211."

Signed-off-by: Masi Osmani <mas-i@hotmail.de>
---
 net/mac80211/util.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/net/mac80211/util.c b/net/mac80211/util.c
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -1614,6 +1614,18 @@ static void ieee80211_handle_reconfig_failure(struct ieee80211_local *local)

 	local->resuming = false;
 	local->suspended = false;
+
+	/*
+	 * Stop the hardware before clearing IN_DRIVER state. Without this,
+	 * cfg80211_shutdown_all_interfaces() tears down stations via
+	 * sta_info_flush() while the driver's RX path may still deliver
+	 * frames referencing station data being freed, causing use-after-free.
+	 * Guard with local->started since this function can be reached when
+	 * drv_start() itself failed (hardware never started).
+	 */
+	if (local->started)
+		drv_stop(local, false);
+
 	local->in_reconfig = false;
 	local->reconfig_failure = true;

-- 
2.51.0

