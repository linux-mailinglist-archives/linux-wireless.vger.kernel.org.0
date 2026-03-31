Return-Path: <linux-wireless+bounces-34233-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KBo0AmkbzGnHPgYAu9opvQ
	(envelope-from <linux-wireless+bounces-34233-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 31 Mar 2026 21:07:21 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 89EB53705D2
	for <lists+linux-wireless@lfdr.de>; Tue, 31 Mar 2026 21:07:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F23EB306A384
	for <lists+linux-wireless@lfdr.de>; Tue, 31 Mar 2026 19:06:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC80A223DE9;
	Tue, 31 Mar 2026 19:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=HOTMAIL.DE header.i=@HOTMAIL.DE header.b="JDatfuDL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from MM0P280CU009.outbound.protection.outlook.com (mail-swedensouthazolkn19011034.outbound.protection.outlook.com [52.103.34.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A293A2553
	for <linux-wireless@vger.kernel.org>; Tue, 31 Mar 2026 19:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.34.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774983987; cv=fail; b=t5GoPAxdvw3/vequQCBsWd7Yb6BrXnx3hjLhv2BKCW0VHlcFJBjm7uYDgqsOtujvwhqoAAeM8o7GSXtrIPplrN3/pT7txL48x/YH2dwg8S+25soPvCTdhroN9QD/dflNbx38zS88kvmjtt7OHU/VdGmcobBmduC/k0kJ7n+zLBg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774983987; c=relaxed/simple;
	bh=dMGGyH2BXWjwJzCN6dQn+6GaS6gdl+omoMmsf379ops=;
	h=Date:Message-ID:From:To:CC:Subject:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tWGxh0BSdpEA921YtE8utbg/+cByM+NsmW5Yv4bek7MgNtlbr8ruWOSaO5atUROPOJ0ydP5uIOtL6r7B91KV9Uvh+wDYGhDCshpomS1ADYTPxsaKittJc7GF516HSK1HjNS4Gp7kjCbwXgqyXA5v7k647LO/3cd+yS+u/fw25Is=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.de; spf=pass smtp.mailfrom=hotmail.de; dkim=pass (2048-bit key) header.d=HOTMAIL.DE header.i=@HOTMAIL.DE header.b=JDatfuDL; arc=fail smtp.client-ip=52.103.34.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EZSPTfBBXpOK4tV8lYVYfgdsyGsnTPQvyHKH+t6anvJsDaSI2pGcgonBkth3CI62pefdWbCZ75Kgbr7K/lcXic0ysyoh4rouLdP2tyzuuBYkDGlMIS3Di1AGGNrvLoaYjsjYvd5ByJKWujU73U6YzW8VsefFS3fEKOMBplObfaaJxg0vE1tnWUkTegeq5AJBr+Jpt7yvmcN5W3Pg8mRnBQE/yemD9MaPJEINlAdsrd44bLFeXQPN4M6UjrUS5d8CCxDM+RVERpMzr2AU8LcnvKNfTN7rEsFCOg07GXNRDlFTqjkov3hz5K93RBNqabsNyOk/dYBUsKkWQA6lAswztw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SC3oPP86v4vdKm0VRiqeznpJMHvqo6JpzyNnYo4Q3ZI=;
 b=GJoHOEb8zwSxXHzNj69TfTbVC8y3T+TWFFCo4BZ3r2nXCErjdbEZEAF0JIEjuJTKHLBOv9NzYU2Rtx9E0olhGu+5TZ6QEF7BiqrDlzdZlEC25UgqhWh++r0lzDcOSu26Vw0Ttq53sSsHS5k6pKN1qGJZeCRiv7Jpi1F8/BBmCY3DKjRj6A3kbdqnR67uePArPD+qfRN3cEU7Olcu20kI6/A7fWXGwNFQlMV1eR8S1qLCrWzvbqZFXoR4+8B+FwdIAG/+4Ow96bC5TM2eIEd52XZvy/5Qco2DdiXzxlS3pwNnpFtfm5Jnlm2T/VcmycqdmGPPk+q5qzzbedP1HywxcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=HOTMAIL.DE;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SC3oPP86v4vdKm0VRiqeznpJMHvqo6JpzyNnYo4Q3ZI=;
 b=JDatfuDLzwh3gHKlxy9H0VekpRxfz0YZ0GwNAcjMee+a29GQ7mtrk5mn0v91OL/K5VWNc4s4j/BwROxpYuXLVY56gao0IAqvtlS8Q7TipbrHTT0QJDYHVr17WclNEJ1LOGB56KJm9JwBlL7vBtO9OzKm5wrZbY9wr1RtFimIciQyv/P3hjdWKxDa0nWJ/I3ZubbzV3F78ZRtfOxVnSJttSQzaa88sGmxkTgm37Ewcdv6HW86z/tTjMOqGAzkTIUw1XLGfVjToCLBb/DbmWT3VonV2adqG5BaFudE32WXKj+s6Wy36lDbneV83/qsSk5cSk9A3ZlQaYyGl33mtio+oA==
Received: from GVYP280MB1518.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:19b::9)
 by GV5P280MB2028.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:376::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Tue, 31 Mar
 2026 19:06:25 +0000
Received: from GVYP280MB1518.SWEP280.PROD.OUTLOOK.COM
 ([fe80::6328:bea5:c218:593f]) by GVYP280MB1518.SWEP280.PROD.OUTLOOK.COM
 ([fe80::6328:bea5:c218:593f%4]) with mapi id 15.20.9723.018; Tue, 31 Mar 2026
 19:06:25 +0000
Date: Tue, 31 Mar 2026 21:06:23 +0200
Message-ID:
 <GVYP280MB1518512DDF2D2097031CC9729453A@GVYP280MB1518.SWEP280.PROD.OUTLOOK.COM>
From: Masi Osmani <mas-i@hotmail.de>
To: Christian Lamparter <chunkeey@gmail.com>
CC: linux-wireless@vger.kernel.org, ath9k-devel@qca.qualcomm.com
Subject: Re: [PATCH 06/10] carl9170: phy: populate per-channel TX power from EEPROM
In-Reply-To: <ec4490af-1156-41b0-9df1-770fe8be6f91@gmail.com>
References: <AM7PPF5613FA0B6E8EAEDB73BAB87748A8C9444A@AM7PPF5613FA0B6.EURP251.PROD.OUTLOOK.COM> <ec4490af-1156-41b0-9df1-770fe8be6f91@gmail.com>
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0125.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::19) To GVYP280MB1518.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:19b::9)
X-Microsoft-Original-Message-ID: <3b1b74d644693a82db75c011bbd2ba62@hotmail.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVYP280MB1518:EE_|GV5P280MB2028:EE_
X-MS-Office365-Filtering-Correlation-Id: 8aabb620-3b20-4572-a344-08de8f589acd
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|15080799012|5072599009|23021999003|461199028|8060799015|19110799012|51005399006|440099028|3412199025|26121999003|40105399003;
X-Microsoft-Antispam-Message-Info:
	vesKUEqjZCbtfwCMuZPIuTLNJgliP+Z3Wrz0mw2UEKzDo2f7UxCUAB1wBnP7beDMAFnH24jzka8wdjxkK15IzZOAVcaUMa5CikcCwKcwQHQnZgVEfSPFpUF0ZD6JwwSS/bUtrG18pyo0mhRz+mouxT+0e3PmbmWZRs/0WcKtMoECNmIoAPbv0lmPFhC/R1sQv5TcrOVUEpFVGz53B7uw+IhxOmlGS/7Y7v6WNItTiSJXX+knG4tbbu3uZ5YicgdBDdaVFIEEk4gRSLDTzsNcNGEruZg6glkeGBH+VAGuY58oUwZh8s236LmGmXlJUaPC5ZBczNcehJ/vZoNMEPF04bN2RbVF7i89naESXfay8Kw4/fVwR5wm93OHOrrod5n0FhKKDjcx7WXAbshdYEuMtigZtUZ7/VbZ4VxhpCUZ1o8dEUZLjAN/yza20PEepB4ytiVg9zI6PCzYWv3d0mo5WSVLjoyhLMPFUFj5H1QYkWc4PLeNh19984GyyhRDOKLhm0g5+gWkAg65il25PIlIjWe3G7XqxnKiqxBgWJ4nGXC0V5X2PMOnEmxAjGZ8JQ0gmRjHvxzxc/xO8LURTLve3JbhKBaCSINMLB+Vb4RYnBsJJl4UWqiWpiMPrJtq2sDMqTws0uDHRKq9p9DFZR6fXjAYucObTCd2XCoV56mNwL8QUOCflO8tApgfDnVNcbySgRusdaLjK50UcIXdO3+L4UGICeqlHw3bx0srwKqCcbYYyvVq3feLJP40rFuYN4EtBo1MpGdDQUL802Iw24DTr8mLAYCcRRDCln/K96nYgTj38ZiVDcfNr+plP+mqcC9833Z9UpxvgJ+62/kLT+WZI1HsFEH6K2mFEZjR0XEbe9IbM48l0LmuyVtxF7dfXIsjHDjsRoNnwXhTmdAu4P1pxhnX3xeqQNHW5vhAlTQA0HMGRMOOFb5XhGgrH04tEs5u
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KJ9tj5jrgnk5NQ1VtCObwOMNHcOiw7syOH7JzKsLcKzuKxmq8p9mi5E3YjcG?=
 =?us-ascii?Q?PAMJmWY5nnRMRQpT4L3YwTFci18jSN4R5BMBhN+xS3GrLduVbOVx+rh2a6m4?=
 =?us-ascii?Q?o0TxxvAUc5alk5tj2ISVR8susfSH8pVdkdtaK6OHSP7CknJYLTndUcH/HTeN?=
 =?us-ascii?Q?tD7POaOAVpXR8FZW00YIl6/PlZBL1lOqTPpjx7AbhJMZN0v9SGZf/8QifqE/?=
 =?us-ascii?Q?yznaJL05+F87lPqZAsvZCsjFlen9+dUgW8EachjmKuOo5uC15JkubfY1OBS8?=
 =?us-ascii?Q?L5/hwpsZFhi5C6hC8SoVyt4yrHwY/FoM8gZK8Z80vxNO0OjoJL4cFNZX5Ykl?=
 =?us-ascii?Q?Hu9jt451kmo3n5rdIBOfsNSJxIa6a1SX89p87RnJHGE0zhv6uj33tuBwoUbR?=
 =?us-ascii?Q?Lepl7RXb6G2/DS+XU3cvy+XzjxtLcefsJydrK6M7mA9BJkrUTpvefj61rcuq?=
 =?us-ascii?Q?42fR5zD9m08HdUrsJSZE2jJJZrB/gdIvhXgYFkUaX/VMniwVb8Pcu2MnyiWJ?=
 =?us-ascii?Q?P8Hkr3Jq35dZh973UA+B/md4omKsjSodaZfl7uQTglQbHryblaEH4L86H6wW?=
 =?us-ascii?Q?sP4rK3+a4IUZJduhCthA0PuVQy7b4npPKCOR9HS4juh5eFOf80yenhl6s7pL?=
 =?us-ascii?Q?eU6ffDO0XhHywSyZJHasqCXpA6oKYsSoAfrKvNn2tvB0j5tkwBH139qjqSfj?=
 =?us-ascii?Q?EMvtB5vfpKe9JHurQATVTabvB7Q92FAhJ+fvsUuTVwrYdPxJOVfPAu38ViZK?=
 =?us-ascii?Q?KrVqn6mIicG006lDi3rXvlzYlODCZ4oT3Ud+RMocmieTJCmTcubEUl5qVOHS?=
 =?us-ascii?Q?UrFP8h4iy+aYeoqsYV/B4wgaX1SkSfRgL0V1X7HIWUEotZBXwdsx+MbWo1bV?=
 =?us-ascii?Q?hD7isf4TPbEnoN48an6RYgu0ZwaJBKa8lE7iuo6zVIXj/CUAJUtBvYbRBz3r?=
 =?us-ascii?Q?EmHMDNvKWHb6JMX05fxuzL9d9MNr+qgsy5phUjyoW5/wvShLixOKfTPsvx9y?=
 =?us-ascii?Q?OV+zLhMyjNZ7s0MEjAmSK9ReVMIMKGlAxG1pu3iXYDG0odaj6VKHbl4//AYH?=
 =?us-ascii?Q?CAjPmrnfkLyJiS4kEiynkqPulibLRwoTd4B6RDn4BRcXnUmb5Kk0KumBeaH5?=
 =?us-ascii?Q?L2fY8C2buRGDx2WIJMWCx6DhCSkdTQS8wjTXx8SUR9G/Jm4AZEUwwL7ASZho?=
 =?us-ascii?Q?yIfDAGRdkdNQpGPeZvqXI4F2o4YtqcEJzkTdWn/JKbSqsMdn2AX8Eo7GdsKW?=
 =?us-ascii?Q?kMR7iwtkD/7RBi/Ti1b1Go5d644LzGoWIQNczxenjWPN9TM3/xYjV7MWUlpz?=
 =?us-ascii?Q?VxaWDe0PVD8eCX9uJ0U7XT0AeeX2SClK9UIoKZw98UKGSQbAycPLqqasGVxi?=
 =?us-ascii?Q?ZwcSM5R8Scmg5Ci22euTysRrnYKB?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-10872.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 8aabb620-3b20-4572-a344-08de8f589acd
X-MS-Exchange-CrossTenant-AuthSource: GVYP280MB1518.SWEP280.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2026 19:06:25.2987
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV5P280MB2028
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
	TAGGED_FROM(0.00)[bounces-34233-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,GVYP280MB1518.SWEP280.PROD.OUTLOOK.COM:mid,HOTMAIL.DE:dkim]
X-Rspamd-Queue-Id: 89EB53705D2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/21/26 8:24 PM, Christian Lamparter wrote:
> Why the need for interpolation here? Don't you just need to look
> for the max(ctpl[idx].power, previous_value) within the band?
> I'm not aware of any high-powered AR9170 devices. Were/are there any?

The interpolation was more careful than necessary.  You are right that
a simple per-band max() across all calibration entries would give the
same practical result for all known AR9170 devices.

The reason I used interpolation: the EEPROM calibration target power
tables store entries at specific frequency calibration points (e.g.
2412, 2437, 2462 MHz for 2.4 GHz).  Channels between those points
have slightly lower target power due to regulatory shaping in some
EEPROM configurations.  Interpolation gives the per-channel value the
AP would see if it queried the regulatory domain.  But in practice,
for the AR9170's flat-ish power curves and unknown-to-me device
diversity, max() achieves the same result.

Regarding high-powered devices: I am not aware of any either.  The
Fritz!WLAN N EEPROM shows 2.4 GHz: 20 dBm, 5 GHz: 23 dBm (DFS
channels: 20 dBm) — nothing unusual.  The main benefit is simply
replacing the hardcoded 18 dBm XXX placeholder with the correct EEPROM
value, whatever it turns out to be.

I am happy to simplify to max() if you prefer — the patch would be
significantly shorter and the result identical for all hardware we
know about.  Let me know.

-- 
Regards,
Masi Osmani

