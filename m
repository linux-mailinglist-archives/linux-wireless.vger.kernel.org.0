Return-Path: <linux-wireless+bounces-34228-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mJ+AFYcZzGnHPgYAu9opvQ
	(envelope-from <linux-wireless+bounces-34228-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 31 Mar 2026 20:59:19 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DA8DA3704AE
	for <lists+linux-wireless@lfdr.de>; Tue, 31 Mar 2026 20:59:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 55F283070799
	for <lists+linux-wireless@lfdr.de>; Tue, 31 Mar 2026 18:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9F323A1A22;
	Tue, 31 Mar 2026 18:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=HOTMAIL.DE header.i=@HOTMAIL.DE header.b="dq4oTl8i"
X-Original-To: linux-wireless@vger.kernel.org
Received: from GVZP280CU018.outbound.protection.outlook.com (mail-swedencentralazolkn19012050.outbound.protection.outlook.com [52.103.35.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D986317158
	for <linux-wireless@vger.kernel.org>; Tue, 31 Mar 2026 18:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.35.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774983517; cv=fail; b=lipc7fD9f0p92DGwUQjBNxpmxkaMnn2CBeyIrkLLWqVadlW6o0YeXU9T+bAm3+yABTrXKgTaddl4Zyb0eBQZHpEH7r3B0WSCGrstPJ5QpJNe5gU3RpWUVVA53iTZWEwouUwLBzzdwYl+uDTaUPFj0zR1KVMcB1nKI7xsaC50FCQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774983517; c=relaxed/simple;
	bh=CKFBHz+Z2GHGdywUqlX2XcDayxJBqX6i7a2kzIqEeP8=;
	h=Date:Message-ID:From:To:CC:Subject:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tUUxYFrXtgtsj9xnuHaiiw1uv2+tirnZWJP4fJUKa5VLzmaAmSC7ESu/n/Q7SunyEHnNEqz0mzC3ux/yzWdOH7do416eUDfJ6DkfUpjVXCliFc7M81J60vpZ2KyxNzg2+p6ssvSnFkjx+uN0LXpv/h9OKkSJqmFqmDTfp6uQL/8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.de; spf=pass smtp.mailfrom=hotmail.de; dkim=pass (2048-bit key) header.d=HOTMAIL.DE header.i=@HOTMAIL.DE header.b=dq4oTl8i; arc=fail smtp.client-ip=52.103.35.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v8f4533G14IyxLlGxWRh+LxNsQXSZl5szHYVDBhnF6xOR5/ppHW2UbElFxMq7sekRtSnrPLMdeEgdphJmdTU1QAMQWp8++gbhdaG47El9eFCZS6JaCdAggKKYObVv6yLFzqtW8LhmyOUD5bDwPR9txJBMJ7qCJlT2YmZRVpf/z6B+GBnCmoU0UUl0oiW6sXN2kpEcIYuxJZD0PrBOcIFG6k3Kges13xVMcA+kZ+cYtLp10xHw/K592cVEeMpqPWaiaFIqtSU3YHgs9q//9j7RXy9jqcSrehWFwN+VSbPZoNwzCCbydHoGIFX65BgrTPRu1k6d/1HhsXyZa+kkW2HbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qpYgp8j8eDPFDzY1AhZFC9WXBy1JMP1EQnyse1iaBIM=;
 b=kRpiOKFXnqxuU8CZ+aLShs+X/QB86IiA6LXfCtFaS2Iun6cTV+sIUfDZhRX54/QyyjYzqlgN+ijd+S67ReTHxWzWUPak1NITriqaSzqJaZGxNoaugBubakvhzifDK2s6ZPVTRkGoCibbM2F36iLHoRft62USSWNFnPtAsWwcAQvYUlFcNPVHo7sZirv/gKDy1ea/YFV6udLbk9yU8nlISoZ5Ok13li44coda/hES4eelZgj+QKM2g+5pA0nePBioXNaGKd1R6ha+b8zLkjRJ9lTdK/lgdXjau3ryG5/3OXmbLIJ+mGPDthR5K5YD1dT2SQ0JbTPQjtPtdXcNB/HVKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=HOTMAIL.DE;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qpYgp8j8eDPFDzY1AhZFC9WXBy1JMP1EQnyse1iaBIM=;
 b=dq4oTl8iq14jTmGqAA28GbQHoB0XvjovepYAGCk3xBFSNqXwhyy3NAwN+C/VCLaxnsX66AR2Mjel2xOrtEN/SwIcdPkrsvIdgnrbOJMGBSVoW+gy608iSHyfy7OQkQ8eUyDNBowTNkVhkuevkbTTs8woVtuz9ukTyC3ESCyZT6xRD+IL2wjd6x0LIvoRlHLtvXQiGuojjk3C3u/weq+1O3TAph0VKurtcKmWn7RYlPe1X7Qxv9jf9VZ6lOEpxer9Kx/a+2Gu5Ukbc/xEwNTyAdszf1wlOcsrAwOITqDSTc/d5NY0wSh4TEzkzuqDEzKc05O5sflWftH7r3EnQRnEyg==
Received: from GVYP280MB1518.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:19b::9)
 by MM0P280MB0978.SWEP280.PROD.OUTLOOK.COM (2603:10a6:190:2::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.28; Tue, 31 Mar
 2026 18:58:32 +0000
Received: from GVYP280MB1518.SWEP280.PROD.OUTLOOK.COM
 ([fe80::6328:bea5:c218:593f]) by GVYP280MB1518.SWEP280.PROD.OUTLOOK.COM
 ([fe80::6328:bea5:c218:593f%4]) with mapi id 15.20.9723.018; Tue, 31 Mar 2026
 18:58:32 +0000
Date: Tue, 31 Mar 2026 20:58:31 +0200
Message-ID:
 <GVYP280MB1518288D81C04F477DA3F3A69453A@GVYP280MB1518.SWEP280.PROD.OUTLOOK.COM>
From: Masi Osmani <mas-i@hotmail.de>
To: Christian Lamparter <chunkeey@gmail.com>
CC: linux-wireless@vger.kernel.org, ath9k-devel@qca.qualcomm.com, Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH 11/12] carl9170: skip cross-band channel changes during sw scan
In-Reply-To: <73153743-e0e8-4f2d-8774-066f53460511@gmail.com>
References: <AM7PPF5613FA0B68A6825857195D5EF51B59443A@AM7PPF5613FA0B6.EURP251.PROD.OUTLOOK.COM> <73153743-e0e8-4f2d-8774-066f53460511@gmail.com>
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0032.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::19) To GVYP280MB1518.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:19b::9)
X-Microsoft-Original-Message-ID: <b34a10890882d5959e30d8eff3a2c23e@hotmail.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVYP280MB1518:EE_|MM0P280MB0978:EE_
X-MS-Office365-Filtering-Correlation-Id: 828e83a6-ed03-4c42-7064-08de8f57810b
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|23021999003|19110799012|461199028|8060799015|41001999006|15080799012|51005399006|5072599009|440099028|3412199025|26121999003|40105399003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7tm4N3Ach7PYVJspZ/AmIMXgbZcp1UEQUchhDx8ivzHp2Jxa0FQZ1sfIuXP/?=
 =?us-ascii?Q?APuajF9udELxTGE2pLFIOJJmI+O+rCahMt6QtJFePPEAyWWyQLjylnjgCOJI?=
 =?us-ascii?Q?hcDtWEpMa6G4oX2cWHcHM5qzsb3brzR30Om6cI2GOj27QRrqm75POoakGshO?=
 =?us-ascii?Q?9SeCT36uT5CI/drtevTdxgRvhA4Mr6fIl9qbcB9KFwj7IMIlyF63fzaMaEt1?=
 =?us-ascii?Q?b58PRLa3QL6iWCxYqXUbNF7dVAnByz1kx7tQ3iTtqLDOHqkESHZsdl9n8G4I?=
 =?us-ascii?Q?MOcaxp6I3xsOYx21IJz0j50SAROCWnt+uFRyllHwdeyBw0YVclq2rbMxuBnN?=
 =?us-ascii?Q?Lh5PMN3rCUAOp4G/lZZTLxy6zVgaNNo95Xx3CJpZUFq/6Aycej5UVcgN90od?=
 =?us-ascii?Q?ODd+Thti2BSyUg+uvDgP7GEZSSd0qvOqNw63QY7bn5Tbui/IvQE8XwfvPlsU?=
 =?us-ascii?Q?iKzdZbecMePDorUSSCztyns0GuuO9XK1wXytt07erEKIE1DxK4Fo9ZzkM7nS?=
 =?us-ascii?Q?LOpQIl/wuIT2ERC+7Yd7g+l+peqL51gDNdr2ye6skMMBrrtbEcfGUd8rAV4D?=
 =?us-ascii?Q?pPgasgY9P7D239tsJf+1ZsVL/OLAQ9pw+J1iUpaqSZAE1YsZgDutNfHbz2TN?=
 =?us-ascii?Q?cTug9jHhqXTlumDRWyRprDSz5mKkra9Vt/LMSjFcXEl60sB6z+NVOpNr7o8Y?=
 =?us-ascii?Q?eoyMoRQ1mEgfYe6XJvExNa1oGsOAYEy/EuU5QGuzPinjmVUtKihgFmiDsZJ+?=
 =?us-ascii?Q?c7LMVMRTwFwrlS+OTNQGYwvUf/jlzo4w2Mvf448MX2531EgLTzFpwVPgO0aM?=
 =?us-ascii?Q?v6xuS18R1XLX2T0wkzlBjLC9qiG9WO2jbEKzdcyRhWlkWkw2zkRa21kSw5GH?=
 =?us-ascii?Q?NkPvjfiB8YBQTacWwglqZODklBi+HaZr7g11UQcFW4szHyme1hOaPuNH9isW?=
 =?us-ascii?Q?IrrieW0JErE8Cm0Z5xMwva0Wh+HSCcTcQm5EggXi0ps=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gGgftpAHGOxgelO1dRk3yha3bzrXTI5RSo3r/WWE7bpFhWjQyzHm4zfjCziX?=
 =?us-ascii?Q?oF02b6OzsuZQ6J8BwZ5vFu7KKnj83UHREuRdc6eezyZqzuGS4b0V0SZgXneU?=
 =?us-ascii?Q?/5QRXMyH5PkUg3iezAK75ME8Nn89ijqPmNVJFCJIeSUSbc7T55NMSWHwZY4E?=
 =?us-ascii?Q?YUyvwUiYJWZ/v4QUXgo6UzTojtiMsI/DW4tIcayVrIYH/wgo39uA9nGZ1Bwj?=
 =?us-ascii?Q?f65L/SETycj9MsuEGWz9V56yNgnvkl5wJFKh7cyOsjqSd4wlTJYz1tmZAfPs?=
 =?us-ascii?Q?oGIbm5qapfnV3voEkgPmsGLpjODLsDTJ5LNJX7nX084hDFA9azm0+uVqa9fG?=
 =?us-ascii?Q?dGpFCDSw7ocbluM+P8S+U5agBbHy87IAykQMQWYg2++EPb33RPtgbgViqM/u?=
 =?us-ascii?Q?4hcfucyiAq+kMd8+0AuiBBwVT2RYHb1RuXjzaiTOJBh6MojZxAEQhJQtYaRW?=
 =?us-ascii?Q?ErTLz9566MOUBXo2P4iUhANmiZPa+ZEuF20j6AtvwTvOjdCiRZUGcYiH16a5?=
 =?us-ascii?Q?TUFLBNNDNGheAZTixjWMuu8YQFFQ3QvWfmclaXbd95+8d3v7oINWv1S0g2hx?=
 =?us-ascii?Q?Ln2/MOrmmXfY7U3JTKLwiGwNb2z1bc0lnnHvQ0gla2bEXTXL2lfrotE7eubw?=
 =?us-ascii?Q?/4OpjKAUePaQRgjOYgdTnmqmfpAFmdON3QV58z0qOtbUzEmYu3hoJjFVQIJb?=
 =?us-ascii?Q?XLBuWBu4QfevVK5a1qeB18XYogmaoA/3M/gfN8QB6/ZTgJOAHZ3dvitAWiHi?=
 =?us-ascii?Q?vU4NpJzbPrDeFS1lcnDo/Z4tc0fnis5WjF2f+guFFbDVIZzafHWAyArrIQLg?=
 =?us-ascii?Q?RiW3qu1gQn5EEzNYYbqn5AmWf8ZBiYV8jNk5SiBnjJmCQyR9NEei7DvdC52F?=
 =?us-ascii?Q?YIj7S/0JuqmCR+2BVn7tK1yb44hi6K3Q2+hHaYj3Zo7jEVhaWw5RSrNN1aL4?=
 =?us-ascii?Q?YSiE+TciDP2H65OD1pxDykXlDNRVwMbI8CLBuvOzpGujeAnYFy+w7xKMehYS?=
 =?us-ascii?Q?VWugcVZ2y+WnxwG6g8QBsng3ZuX6vhR3PgDbzjKKnR9tKyvubrpmpJ2ofZ6B?=
 =?us-ascii?Q?sIsUZnBFkD0oYOBYJt7NfyQg8S9cMMk+cCXBcvZJQM8dHE/IOpU1lrbfsjxk?=
 =?us-ascii?Q?6dewMTGBdezA4Q1b1n5Iqnhfbhzl9xYFUm+r2eSZx9Vd8JjOcaMxLZczO8qN?=
 =?us-ascii?Q?WQRXrsI9ySOMirX5zEkYTvaW7ZVFS9UakIllsbb1ErL8+4DuQ1TV0b3Pr7cd?=
 =?us-ascii?Q?vJj3SkvZGQJP/9VxOWKhCzIEotJe+0ViACYh4hLarUKQvJFh0u1MwKnoaLsb?=
 =?us-ascii?Q?ifJML8/QCeTjssRMrRf5iyEOIAX94g8BZK0qD0aOIl/poX8sWJA/xLw2eq/H?=
 =?us-ascii?Q?cwbua85YLndyb2B1fVzDLYRXnZJX?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-10872.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 828e83a6-ed03-4c42-7064-08de8f57810b
X-MS-Exchange-CrossTenant-AuthSource: GVYP280MB1518.SWEP280.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2026 18:58:32.4732
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
	TAGGED_FROM(0.00)[bounces-34228-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[GVYP280MB1518.SWEP280.PROD.OUTLOOK.COM:mid,HOTMAIL.DE:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DA8DA3704AE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/15/26 10:58 PM, Christian Lamparter wrote:
> I do see the point here and I can confirm that to this day, this
> causes the described annoyances.
>
> @Johannes: Is this "stay within the band" something the driver should
> do, or could this be moved up to mac80211/cfg80211?

On the @Johannes question: I believe the driver is the right place for
this. The issue is hardware-specific — the AR9170 requires a full
baseband cold reset and AGC calibration (200 ms firmware RF_INIT
command) for every channel change, and cross-band switches add a
clock domain change (44/88 MHz ↔ 40/80 MHz) that frequently causes
the AGC to time out. Other hardware with lower channel-change cost
would not need this restriction.

A mac80211/cfg80211 layer fix would either need to become
hardware-capability-driven (a new flag) or apply universally — both
seem heavier than warranted.

Since sending this patch I have also implemented a complementary fix
(posted separately as BUG-014) that handles the -EIO return from
carl9170_set_channel() during a scan more gracefully: instead of
counting it as a failure that cascades into a device restart, the
driver now returns 0 so mac80211 advances to the next scan channel
silently. The two patches work together — this one prevents the
expensive failed attempts on cross-band channels, BUG-014 handles
any that slip through.

-- 
Regards,
Masi Osmani

