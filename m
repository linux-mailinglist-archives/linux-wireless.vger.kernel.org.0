Return-Path: <linux-wireless+bounces-12328-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0192496823C
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Sep 2024 10:43:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F2CBB20BCD
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Sep 2024 08:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A54321865FE;
	Mon,  2 Sep 2024 08:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ahXGpis6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012005.outbound.protection.outlook.com [52.101.66.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9525717C9B3;
	Mon,  2 Sep 2024 08:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725266617; cv=fail; b=UUEsasZhMwG2JUqAEHBSVA1EX2T5G2SHTvx6QzvoObnpKc4VXCoDgA5aQP6kSOv9aAsdgsBzQsGsROrL/7AOru3W/836ai2H0nzKI9ZuAFDZeKK7wm3b0unpyHYvHls2RtU6kO00p7nOnl46znyQmKwJCLf5MIct66xU+tLhf9Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725266617; c=relaxed/simple;
	bh=b3RXCAQHOOdhM0M5CmldBELhDhY6lSnD1eEoR1FsLhE=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=b36dsGnekZs2BTC3y1ys5jw/ZZqCKld/gWQkCNTOCwUQ6BgnWlNwNSrZiKjS72ESCYm05nOyuu03peQ09JgdmFrweJ1GAtvLrZrxjtZhLfNBjM69/EZaB1rqwYpbmsteagB6+uuVSFvKp+sPzGRvjURNG8w+7Cww0no2eYv1obs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ahXGpis6; arc=fail smtp.client-ip=52.101.66.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RamH+pf3YFvDWVdhoBwjJNnmD4O2YlRaqITOelvUIJpz+hdzEaCAhbiF9lQOspYbidCpeCRJY6PJR6ADuqneoY/fqMiXFrZQ7ckfHwWe7c+T13sCfgfcDkw1Gdz4ymRCtngDOcg88rC2P1jlN2oZJfl/vEqnjGG6jUuOshPkPDt3bXEVc11dHGOiv8oAbpiVm7nm7RrgfcUDSeMDzHOSfE4UI93BWGYujzLc+mF/R51ljv2if/mlcL0DVUKH/7lXNk9LuP22EZkBz2olprcdyrrYFtAUoO0TJraQCCO3TqPW3cWqpI7A1DPCYICKWgFK7LHdwC3rSeZsGOILi7oEKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e2ZiwTQOfaloPkx8qIRjoksUT+6RoELbjKxOcQpY50Y=;
 b=tbI8iF44hVsE2hjg1W7wZPru+cfdzcLJyWdIa9ZuyH2k4xTDVjjxbWa+CziuJ24yGxdpiIQieSw2Q2iULKtbdVGllmnZrsz8wDsSoaYz4+WHuSMKFDZQIzUI9ch6Qi3d8ZlpAz3oPaiOxNdSVF83hSbXZVNBvFLkV6sxuGY3t7L7s+1CU5x8DZm0n5qFlrIPdqUOvwG0bM5AY+t0vcjdXAqd8mgUS7j/tgw+17sHguy/M8TbLUBG39RExhaMRHJUM80ud4w5IO6KNb4ZS1TjWxLyd0Is4wRJmWwrPGjM1PstY8vCedHZA58gyweyvz2MM4UzB7kCCVQKsu6dUxR2DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e2ZiwTQOfaloPkx8qIRjoksUT+6RoELbjKxOcQpY50Y=;
 b=ahXGpis6k4Hc76sPBPSx6LGLPe0bot+FLzgA5m7suCZANQJYsNgT86fDjHJbY/UeglCgRFp6pUR0VJ1R8cq7QOZR9MtmY2pzTb2h3HN/XXPqKOmnUh3piLz3w1TG0jLmG6a5aNJTNWlAyymWuWVn2O0wqHAH+hK5K/4T5lQfJk4magk7P3LuI1Qxu9+C8GsNrxJZdRKoCXVn7Hf+7gnMTIQzwEdsByVdBryHmQeto/dKfPTuVTCfSWLqEOv4QC5si47tnvJpC4NH3p6lvPU9ANR5FDouv8HKuH+CwdbncwvxMeEzhSfPY/UnhXBOFKXAJGZMPdLbrdvd/+R5Q2mDew==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by VI0PR04MB10856.eurprd04.prod.outlook.com (2603:10a6:800:267::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.23; Mon, 2 Sep
 2024 08:43:31 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257%5]) with mapi id 15.20.7918.020; Mon, 2 Sep 2024
 08:43:31 +0000
From: David Lin <yu-hao.lin@nxp.com>
To: linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	briannorris@chromium.org,
	kvalo@kernel.org,
	francesco@dolcini.it,
	tsung-hsien.hsieh@nxp.com,
	s.hauer@pengutronix.de,
	David Lin <yu-hao.lin@nxp.com>
Subject: [PATCH v2] wifi: mwifiex: avoid AP and STA running on different channel
Date: Mon,  2 Sep 2024 16:43:11 +0800
Message-Id: <20240902084311.2607-1-yu-hao.lin@nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGXP274CA0018.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::30)
 To PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9638:EE_|VI0PR04MB10856:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c037058-23e0-49a7-d895-08dccb2b5281
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zdT7k/TZHojPYTz5GqmxrT57Hgkdjh0TD7bJKESRslKZyeJnbtV9DgKhwJI4?=
 =?us-ascii?Q?SEjagB2wpYSnG6aHmThIQVHxZPZo612ByZj7HXQlFHIlYofQWbSHAb89FnV8?=
 =?us-ascii?Q?dX+OCB9l6EUKmKiiM1B9HtduFT1era/Je2A82w+yUG/m5omNkXwtYKwKVcnQ?=
 =?us-ascii?Q?iuLx5DcTrGj9zk3IcBp2gvkEwMy6zVcgpEiO/9asrQZZ7GbewwUaxQLl2m0s?=
 =?us-ascii?Q?nBRSrqlmzvHqjf1V4PdFIm1d9wfUNBEv3vhp3UqNdHWkL3Oc5hAAAIftNWAI?=
 =?us-ascii?Q?KmwlH/0V5Ex7Syu2nWCbeJ3S5KXRMtsjvj+EPHgXyXpx9qdPvFDTYXXT1DnH?=
 =?us-ascii?Q?8E/ADGYTwW5EUqgFQR777nMBkz6weKdLtLL/nHbK233JGd3n8Q0p+DStKvNM?=
 =?us-ascii?Q?BiTnF6kriRq+bV54fPgUOBZiZ4KjmnPMRzFUuYztNkO/3EkZjyz6m03uAK8S?=
 =?us-ascii?Q?91M2esL2oCAzSoz8ewxOd5QoY5fcF92SVj3+3CjB1gse6apSVhO8Hg6TUpjo?=
 =?us-ascii?Q?3t2BruDwHHfPVc/mDJUcBIW7gmZ93TMOGzQCWJeHm/2iVCe88NABzPcV5Mh2?=
 =?us-ascii?Q?Xc2c/wIzrtQYV160788UV30x1Hmi2EazLbZge5eQA1wJB+i4tclpfnpi38BL?=
 =?us-ascii?Q?K7GwUCVlgMPAlvWnQdu/Rx1dPFDKK4Esed75KlShPU47ZEsN0upToc+MmQOE?=
 =?us-ascii?Q?RQ3P6EDIBMCMOVE9WfcfB8ka9On3DYAZvjOg8+uWilMfR7IG2UHiEKwAMIqO?=
 =?us-ascii?Q?ENWH3IXBhlt9Dv08Xcj5j/21ZUPaUeIGP4O5PWzRf/HCEHrdntiN/pPnVy5C?=
 =?us-ascii?Q?Czb9wH3P/IwklZ2PHaKmnYuYPn9JPS1d1GoQrrvBMWzooaDh1IjffgQ4mlyV?=
 =?us-ascii?Q?ckxZGfJ94flKfDOql44mNG4mIuthAkxlrQ2dRqFSiB+EXMUeALDoRUab4rZv?=
 =?us-ascii?Q?5a/Rtl7JuQhfSk/QivAIB4XCEopczVW5ipJ8LLYsFZ6J9DYgFOWmTot1vpBU?=
 =?us-ascii?Q?PXpZCHnPUhQO3Z57uK5/qjAEVBlGcTbSk7IHnINFi1KTXMphgbR3a/9xYa/F?=
 =?us-ascii?Q?A4CwTu43jQN2I480gfy2Hrl+uNgjfJRpaYZEUv/ypZ+Jt2jNTLfttV3tNSM0?=
 =?us-ascii?Q?QyqnSDh6MYANlctvOyCEem0nGLg/N/kQ2BfJf5BsgW0v/P7XSk5Fix0f1BDV?=
 =?us-ascii?Q?dK6xkwkcd0PHQzlpZDcRPaDW6srxQgmuljLdUOFCARB3m5tGq3ozXDn0jK0x?=
 =?us-ascii?Q?N8wZVJu73bCHrtgB/bOQT9V50xwM73BsyZn5+ihFrpVddIhuJZCjg31ke2Hz?=
 =?us-ascii?Q?FLA31KbtqcwYlL8gHUhhD6QXR/hq0ekqTwp5qsEnewxqnQWrQWkzbl/s2IeT?=
 =?us-ascii?Q?2J4xERATfXbmhhAHphbqan/U2vCqYC2SYuJA8/eRtSTKR+uVaQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NKXxupDqnIujRAdMwT+a/CLhNJQi0M20ASIPkOTLA5+4h2BuT4yBHbxUmhEk?=
 =?us-ascii?Q?tXEm9cpMzVz1KpS97HUBtYjVz+AHmde1h4hIid9grM8PK6RvE4YsO3E4QLBO?=
 =?us-ascii?Q?59j/qCvoLgrzbQYyBOAcWt3HQzp6BX3SSIj/U3iSOIy1zO1zKC/kIGfDdeSh?=
 =?us-ascii?Q?e7uPNpVsZvq0ismsqiq8vu6mBESFEUVdjsdZdObJ5lrMhXhcyRNYXrQB9RNV?=
 =?us-ascii?Q?rDgqyfikK21/FwBwSxmqTKuUJF8wJNmq51KBMlMjhDPkfCmUSYnHpOrfI1m8?=
 =?us-ascii?Q?kF9Qb57IdhlaC35G3OcVmrX+EgyX70zuTypvOVN1XRlydhDVe29VcMVVS9d/?=
 =?us-ascii?Q?B7cpY9LWSGhc6SBMG0MvaS8x7O30XJSwxyY6sx2qmr2eKabWlSAWWEsVlNLG?=
 =?us-ascii?Q?cHx6J83+vfwH/9e5++cP4XwbYxMG7fCw7Q4CfcDkjBL5cRqSH0oStaW6oG2N?=
 =?us-ascii?Q?i1GeMAyihQupXVS8b8Hxq38m4Y+iB3nxmzMbUYtT6vBUWXbjkaXX7eRsfLPT?=
 =?us-ascii?Q?E/99LbLjDr7XVe//dwuXu+1ZG+61ysZGL39OM7kUJW0XkaUVC5GZymr8GiCt?=
 =?us-ascii?Q?vyDXRTJ/WCkzwuX6ArBmb0HHlefIxQG1mUPzwB7vTIbqorhEXOSqGlJG2Mju?=
 =?us-ascii?Q?U4q+EJksQMkBe9SfE4pu1/dDi6JAsAudMHi8JEVGOhEGhLgbwoTNLLVZB4oI?=
 =?us-ascii?Q?qEk27rvwxK1uArJYYezxcOH4QuHgv28fNREWn51Ek9OF2s78LfV6YtdnN873?=
 =?us-ascii?Q?nNizNHNLIwfytO+rZy7No91Fs4do+xvexh2lS4RurIu9spo4iX0d95OMyIeF?=
 =?us-ascii?Q?NsyqxP0n0sOuuqcrm481qracW6CWRFzYSrdpNOUp3ur52aCw0/4bL3uGllza?=
 =?us-ascii?Q?/3jMuh88/oSejN4OL62tM7/rHLN44qrURGKguM+2AUR1ISQQkAfjSG4acoWJ?=
 =?us-ascii?Q?mvJBQjrE8UsFEVujJjerrNS31EoSUC1XDQQa6edwuaps80s9HkP3zSBpiTVl?=
 =?us-ascii?Q?uL1XPpQb80XFACjtir1htOP7EDo/HtG/nfczmoRzgja2fjO0cZg658Jy4sBv?=
 =?us-ascii?Q?ywSpJ/9WoVOcpBldLjlJnFKDpjY+9XPS6RPHC7ers1rue6/E5tGgrR9bM9oT?=
 =?us-ascii?Q?I50YVR7+zZ8DEwV09Wx7t/d0wjtDHikBzerMukbMf6GnWUouC/PtERFg176h?=
 =?us-ascii?Q?3I2rsTfAlW2uUowoLRJ4/UX0B+NsuEjGBoXV8cmwyyGfHa3IumwxyJysa5Vn?=
 =?us-ascii?Q?9qQMfEhR42pdbzvQp+EqzB45b6TR3xrrzNiEaij2J8tM6+TlRlaqH2TEXiH/?=
 =?us-ascii?Q?dEuBW12vH4fiw2UZv0JSgs2CS9R6KjXB/0lkBLeyM3ZvaXxkfGEHVI6/m3ka?=
 =?us-ascii?Q?Af1o3uddJrTOIeJ+H7IELgnnnUce3TkTkrVfys/ee4G85EHpIw6vP37g3NVa?=
 =?us-ascii?Q?kT0S5w7h/NrnVsw+FnXZNt0urvvpaDsYLsHPEW/53b8y9r/Mk/h5UqjSQ1hG?=
 =?us-ascii?Q?b02ZrkwqBjV1G18Q07AkR10IQbFK2zJ795vqRA3tf8oNYzagARbNf5uWROnt?=
 =?us-ascii?Q?mrtXz7lOuwYQR9TxLXLxnYsUR+nqOObWGVQzGkPC?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c037058-23e0-49a7-d895-08dccb2b5281
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2024 08:43:31.1068
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9zOajsvam+K6UmaKJ1F//nmafV4GpigkJBCrt/dL4hObLcfE7VhsZZ6Rcz90HXgpuOSQaLPL4CxgghIYauqReQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10856

Current firmware doesn't support AP and STA running on different
channels simultaneously.
FW crash would occur in such case.
This patch avoids the issue by disabling AP and STA to run on
different channels.

Signed-off-by: David Lin <yu-hao.lin@nxp.com>
---

v2:
   - clean up code.

---
 .../net/wireless/marvell/mwifiex/cfg80211.c   | 17 ++++---
 drivers/net/wireless/marvell/mwifiex/util.c   | 44 +++++++++++++++++++
 drivers/net/wireless/marvell/mwifiex/util.h   | 13 ++++++
 3 files changed, 69 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/cfg80211.c b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
index 722ead51e912..3dbcab463445 100644
--- a/drivers/net/wireless/marvell/mwifiex/cfg80211.c
+++ b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
@@ -781,11 +781,9 @@ mwifiex_cfg80211_set_wiphy_params(struct wiphy *wiphy, u32 changed)
 		break;
 
 	case MWIFIEX_BSS_ROLE_STA:
-		if (priv->media_connected) {
-			mwifiex_dbg(adapter, ERROR,
-				    "cannot change wiphy params when connected");
-			return -EINVAL;
-		}
+		if (priv->media_connected)
+			break;
+
 		if (changed & WIPHY_PARAM_RTS_THRESHOLD) {
 			ret = mwifiex_set_rts(priv,
 					      wiphy->rts_threshold);
@@ -2069,6 +2067,9 @@ static int mwifiex_cfg80211_start_ap(struct wiphy *wiphy,
 	if (GET_BSS_ROLE(priv) != MWIFIEX_BSS_ROLE_UAP)
 		return -1;
 
+	if (!mwifiex_is_channel_setting_allowable(priv, params->chandef.chan))
+		return -EOPNOTSUPP;
+
 	bss_cfg = kzalloc(sizeof(struct mwifiex_uap_bss_param), GFP_KERNEL);
 	if (!bss_cfg)
 		return -ENOMEM;
@@ -2463,6 +2464,9 @@ mwifiex_cfg80211_connect(struct wiphy *wiphy, struct net_device *dev,
 		return -EFAULT;
 	}
 
+	if (!mwifiex_is_channel_setting_allowable(priv, sme->channel))
+		return -EOPNOTSUPP;
+
 	mwifiex_dbg(adapter, INFO,
 		    "info: Trying to associate to bssid %pM\n", sme->bssid);
 
@@ -4298,6 +4302,9 @@ mwifiex_cfg80211_authenticate(struct wiphy *wiphy,
 		return -EINVAL;
 	}
 
+	if (!mwifiex_is_channel_setting_allowable(priv, req->bss->channel))
+		return -EOPNOTSUPP;
+
 	if (priv->auth_alg != WLAN_AUTH_SAE &&
 	    (priv->auth_flag & HOST_MLME_AUTH_PENDING)) {
 		mwifiex_dbg(priv->adapter, ERROR, "Pending auth on going\n");
diff --git a/drivers/net/wireless/marvell/mwifiex/util.c b/drivers/net/wireless/marvell/mwifiex/util.c
index 42c04bf858da..6512562c9fb4 100644
--- a/drivers/net/wireless/marvell/mwifiex/util.c
+++ b/drivers/net/wireless/marvell/mwifiex/util.c
@@ -323,6 +323,50 @@ int mwifiex_debug_info_to_buffer(struct mwifiex_private *priv, char *buf,
 	return p - buf;
 }
 
+bool mwifiex_is_channel_setting_allowable(struct mwifiex_private *priv,
+					  struct ieee80211_channel *check_chan)
+{
+	struct mwifiex_adapter *adapter = priv->adapter;
+	int i;
+	struct mwifiex_private *tmp_priv;
+	u8 bss_role = GET_BSS_ROLE(priv);
+	struct ieee80211_channel *set_chan;
+
+	for (i = 0; i < MWIFIEX_MAX_BSS_NUM; i++) {
+		tmp_priv = adapter->priv[i];
+		if (tmp_priv == priv)
+			continue;
+
+		set_chan = NULL;
+		if (bss_role == MWIFIEX_BSS_ROLE_STA) {
+			if (GET_BSS_ROLE(tmp_priv) == MWIFIEX_BSS_ROLE_UAP &&
+			    netif_carrier_ok(tmp_priv->netdev) &&
+			    cfg80211_chandef_valid(&tmp_priv->bss_chandef))
+				set_chan = tmp_priv->bss_chandef.chan;
+		} else if (bss_role == MWIFIEX_BSS_ROLE_UAP) {
+			struct mwifiex_current_bss_params *bss_params =
+				&tmp_priv->curr_bss_params;
+			int channel = bss_params->bss_descriptor.channel;
+			enum nl80211_band band =
+				mwifiex_band_to_radio_type(bss_params->band);
+			int freq =
+				ieee80211_channel_to_frequency(channel, band);
+
+			if (GET_BSS_ROLE(tmp_priv) == MWIFIEX_BSS_ROLE_STA &&
+			    tmp_priv->media_connected)
+				set_chan = ieee80211_get_channel(adapter->wiphy, freq);
+		}
+
+		if (set_chan && !ieee80211_channel_equal(check_chan, set_chan)) {
+			mwifiex_dbg(adapter, ERROR,
+				    "AP/STA must run on the same channel\n");
+			return false;
+		}
+	}
+
+	return true;
+}
+
 static int
 mwifiex_parse_mgmt_packet(struct mwifiex_private *priv, u8 *payload, u16 len,
 			  struct rxpd *rx_pd)
diff --git a/drivers/net/wireless/marvell/mwifiex/util.h b/drivers/net/wireless/marvell/mwifiex/util.h
index 4699c505c0a0..16f092bb0823 100644
--- a/drivers/net/wireless/marvell/mwifiex/util.h
+++ b/drivers/net/wireless/marvell/mwifiex/util.h
@@ -86,4 +86,17 @@ static inline void le16_unaligned_add_cpu(__le16 *var, u16 val)
 	put_unaligned_le16(get_unaligned_le16(var) + val, var);
 }
 
+/* Current firmware doesn't support AP and STA running on different
+ * channels simultaneously in normal mode.
+ * FW crash would occur in such case.
+ * This function is used to check if check_chan can be set to FW or not.
+ *
+ * Return:
+ * %true if check_chan can be set to FW without issues.
+ * %false there is already other channel is set to FW, setting of
+ * check_chan is not allowable.
+ */
+bool mwifiex_is_channel_setting_allowable(struct mwifiex_private *priv,
+					  struct ieee80211_channel *check_chan);
+
 #endif /* !_MWIFIEX_UTIL_H_ */

base-commit: ae98f5c9fd8ba84cd408b41faa77e65bf1b4cdfa
-- 
2.34.1


