Return-Path: <linux-wireless+bounces-24109-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DFD1ADA544
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Jun 2025 02:52:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4527D188E0D2
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Jun 2025 00:53:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55F01136A;
	Mon, 16 Jun 2025 00:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kuleuven.be header.i=@kuleuven.be header.b="p8Z2JoWe"
X-Original-To: linux-wireless@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11020136.outbound.protection.outlook.com [52.101.84.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 001FBA31
	for <linux-wireless@vger.kernel.org>; Mon, 16 Jun 2025 00:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.136
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750035162; cv=fail; b=cT3t5eIrQkFOmjsjxOZK/DSSudWPbglQziPuD+bpCOqDdvzGo/dCY3zUAbtftAzmarJr+u0QfelalofU3b9V5op7ms2dx5wRoRkIS4q5yyfp/7bZWoQC/J/bj7+iVT/+qH64kmfSbCmbnefNTrsv+EFOSWVQNcGWB59gg/glhFE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750035162; c=relaxed/simple;
	bh=qYnpVQHa3+DgI2bJxh4Vrxt/utxYY4m1wIXo/8BniZ4=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=a1j+cnt2fARg0aUAO4HbPozN3HynCFn9pD4Jscth77gYGYllKgG0ZfKqFs1RQdJZ0U8xop7Gy2hAJ0HkUQvUYubGehB5esrbnSrxzfL8g1Fi3aBcI7SIGzz/HrxcbtghgV8wd64IitPmYfzf1fgqAFw4ob6K3zzSOX2E4hTYqbQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kuleuven.be; spf=pass smtp.mailfrom=kuleuven.be; dkim=pass (1024-bit key) header.d=kuleuven.be header.i=@kuleuven.be header.b=p8Z2JoWe; arc=fail smtp.client-ip=52.101.84.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kuleuven.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kuleuven.be
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OYsTOycI31tv4A5fmYXeoLr/x4EzrI0Ns6fop1engShDS48qfJkc7dKwwzG2EL+1JfPegMv3kUsIrDmtH8ywvGk/4PwYeQO/VPr2kIX6tJeJXB4K2yKXXRumJEw5XrrjAAICqiIpTAIOJK4JAO1kzt6KGJmr0iyFy8NZhKCFhMfjO3I7VIh+m8Jm6sSEOZcBfnD+BNDtBJcoUK0zhSmnKHI0kJJEi5ZqZgEOeQecEx5/yA+fEdp3FCTm0ovhTUtZ90cMpJ9BKXEDYe5mGK9Sobg+9+Y/hUa+lTkJHJDpFOUF0XUa+Of5rcu4jLdxpncDw8/0b50YxFMe7BPe0A8sbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a66b+b/NVTvJwCwS9fcoigEUkr6FRNTHbpW0+fkwsig=;
 b=J/BTI9SQeGGMmuzJrT9JU6VTDuUklyJUrQmOz0fB51ir8yNRhPgS2ZhEyKBsb9gGNuU6dreDQviCbg+BF5hAuU9+uEcM6gz7oNX8f/oLlRRQ4W7bXF3JxTgsH3wfnp0K9FbN5lf/LLl4sLa42/geKqfGITtgqUUgIvYbtjf8jIm+Wra0ykbA2P4QxLDLiclSpT7SlZw3ulD+qpHz0B5B5mHqvPCBiJ/1VIvUb2CHu8BLGAV2Zr/hUUQ15FcIC1bn45ZoOQOkZ1rWPF0ju4u4NwKyGsL4IsSbU9EEG+gkU7enRzRhcjoOfi0laG36sXwVvUN6ijr2bYf3Y3mIBGwPNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kuleuven.be; dmarc=pass action=none header.from=kuleuven.be;
 dkim=pass header.d=kuleuven.be; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kuleuven.be;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a66b+b/NVTvJwCwS9fcoigEUkr6FRNTHbpW0+fkwsig=;
 b=p8Z2JoWe3MRy5aONCSaQlqft9yvi9lOvt0MK4ymJzMnZtO8hrrADIwFG36s6KVFNvU+i7jdZS2kFDo9uu6Ifn3YMpIjgazOEOu1z41S/W9TZQTYuhotrt+E7JMJ4hH+BnvO+IQjAG44iHTRDRMutCDGYUC/72lqssFu1vCpZwIw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kuleuven.be;
Received: from AS8PR08MB9768.eurprd08.prod.outlook.com (2603:10a6:20b:613::21)
 by PAWPR08MB9890.eurprd08.prod.outlook.com (2603:10a6:102:332::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.28; Mon, 16 Jun
 2025 00:52:35 +0000
Received: from AS8PR08MB9768.eurprd08.prod.outlook.com
 ([fe80::2b46:d268:abe9:b0e9]) by AS8PR08MB9768.eurprd08.prod.outlook.com
 ([fe80::2b46:d268:abe9:b0e9%4]) with mapi id 15.20.8835.027; Mon, 16 Jun 2025
 00:52:35 +0000
From: Mathy Vanhoef <Mathy.Vanhoef@kuleuven.be>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Mathy Vanhoef <Mathy.Vanhoef@kuleuven.be>
Subject: [PATCH] wifi: prevent A-MSDU attacks in mesh networks
Date: Mon, 16 Jun 2025 02:46:35 +0200
Message-ID: <20250616004635.224344-1-Mathy.Vanhoef@kuleuven.be>
X-Mailer: git-send-email 2.49.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM9P192CA0027.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:21d::32) To AS8PR08MB9768.eurprd08.prod.outlook.com
 (2603:10a6:20b:613::21)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR08MB9768:EE_|PAWPR08MB9890:EE_
X-MS-Office365-Filtering-Correlation-Id: 6558dab4-95a5-417a-fcb8-08ddac701561
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?D0qWKrmMLAn4WIqQgMlM+h3q6wy+ijTLB12eOKrDOKfP2dUjk9rbyGkuJ/vE?=
 =?us-ascii?Q?h6Vw8Jcl5lHijcb5ZbHml1iTnV+HEBu3hV5Xv5I40aXjO0HfTY9ZAddtRupE?=
 =?us-ascii?Q?R5uvn2bihROnoWPR+iV9D17IFPieZszVrP8FcEvnEoF8PS/swZY7cJh+XE1y?=
 =?us-ascii?Q?WNalVPcZitNRHd2qnpSlEzk0oT2UaxEZaBCHzVCwlveYOUO1xNdvByjuPqzP?=
 =?us-ascii?Q?MPmyKA+lt3Km2WKgUr+pirNeGBGr9/XdtyiyMWorIN8jpBz1+FPX4GD/Z2B7?=
 =?us-ascii?Q?l/Q2xy/UwhrQ1zJR3mMgrqWIZrkc76upf+bxZh1d6I7y2wNrFLWFc8NU3ghl?=
 =?us-ascii?Q?sLwG5zER/IFkAQYSPkQnaCOgSULtWU7ab2BSYbaCEQDbAUps3Wbk5zlwVYIb?=
 =?us-ascii?Q?bAaCkJDQDWX2rz9AXC2RA0sJP7aYws9TIdkn2DzSEjbmha+J1jYPUQGFDNgV?=
 =?us-ascii?Q?kCpoDhzmLjKw6rIsF11xNyKgwMWfGAXLT5IuX4prc+/XSYaxKCmkMWCVShcX?=
 =?us-ascii?Q?WxtbFeOPB5nhKxfXuG4wVyaaYzMkTCbc13qlN7On01MBb0cQoM9rnBSXFgKM?=
 =?us-ascii?Q?yLurm+rjlOWO+fYST1DbPBCCGTAVnfyjaMsa2LkMBUEnXCsQDNhizsFBHyTE?=
 =?us-ascii?Q?FFEP97tVHy6dXksfXv8k4HWlcgA9mtJYA2jgbTQ+/mkvlKcmbu/eiagt9Ow+?=
 =?us-ascii?Q?b8SUQDTstWkNZhnOewhCTKvvmQMXW2zbD4rDeytZwoCvOZnQRqtXXStLowln?=
 =?us-ascii?Q?LRjBnves9F7NEy0QA/N/5iGADyf6s3EuMfuv2o7fmxS8A8uH20lv2Vz3cazH?=
 =?us-ascii?Q?qEv7YxQUN18B5SIbiODN5u8I6NPwpu+yyW7US/YleJFLN2aoa2jqTWpAtPat?=
 =?us-ascii?Q?CZ3DJcC8VKjCTnzpALWxkjgBiqHw5zuPrbuh18A0pkRIzTAZzMJ2pI33FCcF?=
 =?us-ascii?Q?87Gcs/D+twQpapT7/ibMdlyojUiN54W1iOP57Wq4b3ZJHk53pSKEYxqeWG0G?=
 =?us-ascii?Q?S2fyU8b9gEYqfrSAWE4UA9hcQWlmde4LqMUXGMXby8JJhtPbsZE86/Dl/x/H?=
 =?us-ascii?Q?leONSBx/NsICD6DIBbprXtuaKjRuPsWGnUHGtsOD2dL8VyDDSKlGvdYSNlKa?=
 =?us-ascii?Q?VQHqdfDF41tDm5jog5Z4XoZ8RwcDBBDa7TvxnRbIvCaINDtrJvK9e+S+GLfB?=
 =?us-ascii?Q?BzrlXELWyyqi3olR4MvNxGPbJdKwLFipJozbfctDRxmMCovjOtgK7j5h5iDs?=
 =?us-ascii?Q?chhO4p3I6x1IQPLQcQNWzErtQ5MnGMTTDClnEXhAfyUkM/4ZHUsv/d95nCwr?=
 =?us-ascii?Q?R+PBCbLAwCBot47tWbSKns8wsax557xEyde13/2rBNUonvCMyVCqWwfo1fJ7?=
 =?us-ascii?Q?xWMlzE0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR08MB9768.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RhgrxUtClNLVJkzMMhssohRnYeQEXRHxkLXzgAJOeju3MTt4ipZdee5mECYz?=
 =?us-ascii?Q?ev2hNjbHf06qIecykPi7fKqPQKs3UtcADgpdSvoXrawTIo5VyVwRUDKqgUMS?=
 =?us-ascii?Q?6K4KQ5z1qvmRnZTLQkqi71+00gKJaJOckWF/3AOIwy6AsefnGn91F5ujg9wH?=
 =?us-ascii?Q?vlkhjhxnh1j5dRYuQsetkOk4Ta7Kwq6lOQaTdwwtl1EjMiGyBIod2mkR0XtG?=
 =?us-ascii?Q?axQ7aFYZEmP9i+f+bm9A9S62wrR+VArVgnDLZ8L/2PpMINAl2mo+A0uGuiq5?=
 =?us-ascii?Q?UTKd4NmD2ZqxMNgp+P3pRKoKK/IuG8bpFgrFibh/EskDvsT6Iir9VEpMFI3S?=
 =?us-ascii?Q?Ty15v23kyDpn9CaIGTwL/aoz5ThvYDXqIcPMK76e20rLhhGXbz97f+SxJEYI?=
 =?us-ascii?Q?jlgIapzvDOT8aEo2uQpLoZ9AC8DjwxQ4N5YAhzxOf/brb2EPyCF8soh1Dfjl?=
 =?us-ascii?Q?PieEEBIkEUGz471rins+SwA5jl2nXmHHimGcTf24cIGMMQ3kiFGrDKWZqb7p?=
 =?us-ascii?Q?NQcrSJhstzkT+B3deahxpQ0MuWuu67k85T+U1/FLDkp0jD//MBzI2eRHZtrM?=
 =?us-ascii?Q?aPo4F4IB8EVPNy6ogsh48r0OLWL47qyLKaDnQJxbBE8QmLLQZave0xGn+VUN?=
 =?us-ascii?Q?a5+Zb9iHjDUaSWlOxd742J5PWgyop0T+9QUBHi/A7UGqi9noYibo1e9+s6s9?=
 =?us-ascii?Q?Boj7sRuyDWChjd2/crP3quyUwPGsEEMM1JkASb45I1bHEjrDTsF3wez1Rha+?=
 =?us-ascii?Q?kbJlI+TwS8Y4mX2s9FEKjeIuFbq4Uquspr7IpHsiwFqYTj7LBETVSoQQqPs9?=
 =?us-ascii?Q?gthL81Vf2OKXG28a3PLTdIc7ZY0c3JT2eYira0nucLghtBG/wNkpshGLekf+?=
 =?us-ascii?Q?al+NRaFb8dNLF9EsSLurGdyu4PhNKpnz2J+wZeaUkhYc47rNVqRxvTi/EZ7i?=
 =?us-ascii?Q?9mhZqXkYD2B0mdfD9qTpaF9rzjmWy5UgdW+mDCrr0eybk9gB5l9YMlxYUNDY?=
 =?us-ascii?Q?UQYzgJ3d7tgFot2n+K0jH1rY+dERPoJOYx7grrxoFyJXwC2K7qtV434c9lao?=
 =?us-ascii?Q?Ok4wYFK27VEGju63LaMBl1tw3Au0MqERCTZimggXiOAJCUeCSBvQ8qiv0Uja?=
 =?us-ascii?Q?wzL0kkWIPd2PpULdjb8/qkmbvIEgDzMNxUkFD1TU9TYm1MTsME2++tqQslgF?=
 =?us-ascii?Q?tYEJJMTOBUVJT6LSn94zMGqyJ5exfVutLS2SWuAPx2qa/HRiNIU5w0kD8UJH?=
 =?us-ascii?Q?/B7wYACW2oznZciFqniDJHKwULT0YO87TulxR23Q0nR5pefD5mGLAp2mR/jn?=
 =?us-ascii?Q?X4Yh86s7MhVw1z+el8WWi2zwqv0XMN6Q4W/KLqYNlWyIxL8+ETx448cxfO+0?=
 =?us-ascii?Q?bQh/1I8cFPI1LAupLACnYVUcVk5qfvfTo19lA5KLzq0zGO4SQ643iPyRYXWb?=
 =?us-ascii?Q?FF/HsAfMfXBzB2GSWqYVKnS1bel5ISZRHMzDQIa+31o2T0hC9bM5F6UvWgPo?=
 =?us-ascii?Q?gBhZ3WyStrLuSMb7+uVDZSDcOM8NtCs+AjlOqgfW9Wo1EVRo227FbDpujXji?=
 =?us-ascii?Q?C0EfU45S9A1z5VFngR7pEsjJMW5b9G1g9s12cmhoXcJJzcft42p4iDPJgqxp?=
 =?us-ascii?Q?yA=3D=3D?=
X-OriginatorOrg: kuleuven.be
X-MS-Exchange-CrossTenant-Network-Message-Id: 6558dab4-95a5-417a-fcb8-08ddac701561
X-MS-Exchange-CrossTenant-AuthSource: AS8PR08MB9768.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2025 00:52:35.3999
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3973589b-9e40-4eb5-800e-b0b6383d1621
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PHt4fiM5f0onk406CHICvszqIKNSMucXYt0AQXpCEOHu4mP25UdZG3fK2sGim3i/0/ahX4fVeNXthzLaJNYDxqyOeJm4PGPm7am6dojH74s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB9890

This patch is a mitigation to prevent the A-MSDU spoofing vulnerability
for mesh networks. The initial update to the IEEE 802.11 standard, in
response to the FragAttacks, missed this case (CVE-2025-27558). It can
be considered a variant of CVE-2020-24588 but for mesh networks.

This patch tries to detect if a standard MSDU was turned into an A-MSDU
by an adversary. This is done by parsing a received A-MSDU as a standard
MSDU, calculating the length of the Mesh Control header, and seeing if
the 6 bytes after this header equal the start of an rfc1042 header. If
equal, this is a strong indication of an ongoing attack attempt.

This defense was tested with mac80211_hwsim against a mesh network that
uses an empty Mesh Address Extension field, i.e., when four addresses
are used, and when using a 12-byte Mesh Address Extension field, i.e.,
when six addresses are used. Functionality of normal MSDUs and A-MSDUs
was also tested, and confirmed working, when using both an empty and
12-byte Mesh Address Extension field.

It was also tested with mac80211_hwsim that A-MSDU attacks in non-mesh
networks keep being detected and prevented.

Note that the vulnerability being patched, and the defense being
implemented, was also discussed in the following paper and in the
following IEEE 802.11 presentation:

https://papers.mathyvanhoef.com/wisec2025.pdf
https://mentor.ieee.org/802.11/dcn/25/11-25-0949-00-000m-a-msdu-mesh-spoof-protection.docx

Signed-off-by: Mathy Vanhoef <Mathy.Vanhoef@kuleuven.be>
---
 net/wireless/util.c | 31 +++++++++++++++++++++++++++++--
 1 file changed, 29 insertions(+), 2 deletions(-)

diff --git a/net/wireless/util.c b/net/wireless/util.c
index ed868c0f7..639c75c74 100644
--- a/net/wireless/util.c
+++ b/net/wireless/util.c
@@ -820,6 +820,31 @@ bool ieee80211_is_valid_amsdu(struct sk_buff *skb, u8 mesh_hdr)
 }
 EXPORT_SYMBOL(ieee80211_is_valid_amsdu);
 
+static bool
+is_amsdu_aggregation_attack(struct ethhdr *eth, struct sk_buff *skb,
+			    enum nl80211_iftype iftype)
+{
+	int offset;
+
+	/* Non-mesh case can be directly compared */
+	if (iftype != NL80211_IFTYPE_MESH_POINT)
+		return ether_addr_equal(eth->h_dest, rfc1042_header);
+
+	offset = __ieee80211_get_mesh_hdrlen(eth->h_dest[0]);
+	if (offset == 6) {
+		/* Mesh case with empty address extension field */
+		return ether_addr_equal(eth->h_source, rfc1042_header);
+	} else if (offset + ETH_ALEN <= skb->len) {
+		/* Mesh case with non-empty address extension field */
+		u8 temp[ETH_ALEN];
+
+		skb_copy_bits(skb, offset, temp, ETH_ALEN);
+		return ether_addr_equal(temp, rfc1042_header);
+	}
+
+	return false;
+}
+
 void ieee80211_amsdu_to_8023s(struct sk_buff *skb, struct sk_buff_head *list,
 			      const u8 *addr, enum nl80211_iftype iftype,
 			      const unsigned int extra_headroom,
@@ -861,8 +886,10 @@ void ieee80211_amsdu_to_8023s(struct sk_buff *skb, struct sk_buff_head *list,
 		/* the last MSDU has no padding */
 		if (subframe_len > remaining)
 			goto purge;
-		/* mitigate A-MSDU aggregation injection attacks */
-		if (ether_addr_equal(hdr.eth.h_dest, rfc1042_header))
+		/* mitigate A-MSDU aggregation injection attacks, to be
+		 * checked when processing first subframe (offset == 0).
+		 */
+		if (offset == 0 && is_amsdu_aggregation_attack(&hdr.eth, skb, iftype))
 			goto purge;
 
 		offset += sizeof(struct ethhdr);
-- 
2.25.1


