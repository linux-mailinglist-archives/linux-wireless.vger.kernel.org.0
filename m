Return-Path: <linux-wireless+bounces-34223-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KI+sCkkZzGnHPgYAu9opvQ
	(envelope-from <linux-wireless+bounces-34223-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 31 Mar 2026 20:58:17 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C139D37046A
	for <lists+linux-wireless@lfdr.de>; Tue, 31 Mar 2026 20:58:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EF9683031BE6
	for <lists+linux-wireless@lfdr.de>; Tue, 31 Mar 2026 18:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC919390230;
	Tue, 31 Mar 2026 18:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=HOTMAIL.DE header.i=@HOTMAIL.DE header.b="I19I01Rz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from MM0P280CU010.outbound.protection.outlook.com (mail-swedensouthazolkn19012057.outbound.protection.outlook.com [52.103.34.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28B942FD7D3
	for <linux-wireless@vger.kernel.org>; Tue, 31 Mar 2026 18:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.34.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774983492; cv=fail; b=tPBRDEbGAAXlzRZ88wD+3uoGklvobXiDnz6h1UXa/m81aq3PaSWlXQMOss+qXo8hL01Sbj5sa71wltpdVYAlTV3FUe+5i7mR4qF1bw6ZYOIUsfg8560vxfGVADJV2gGOFeHLaX6a94YNUsmquh4cTVwFcx0xvRdPRUN0bMx+5oI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774983492; c=relaxed/simple;
	bh=km6iq2Qhdj/vCTayvoonal37OOQAwtAfzdpzFX9//FQ=;
	h=Date:Message-ID:From:To:CC:Subject:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MediusaMy0FYDnKL57pvc75oMKdwSyiwFHgIR9koOstJ1ytUXBgMa/+AVlE9GPyV/wITFn2ql2Fr73nujgHJHr16eu8Jq0/VPFL1EkW1hUHRVCsRnLPPEoduTzvkInEIadzfLRjPYia6JjRw6PEK5UCsOEb2FhjdUKuvzEPKC9c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.de; spf=pass smtp.mailfrom=hotmail.de; dkim=pass (2048-bit key) header.d=HOTMAIL.DE header.i=@HOTMAIL.DE header.b=I19I01Rz; arc=fail smtp.client-ip=52.103.34.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qUHuIk5KNhkGfxXmmCSF+bKauWC8yYPdYdjAs3g30s4ywAwkTZeiTsO3ZN02OfDdD7F/fjVVOJUuyc2/XXzVx3eirQxDBly7VYRwpeSguscMsdxs1700kQ4NJxEenABtZGUzssLn0SHykv/EOs5sm3qJh693waFbfjIKCjBfJLecb2IHUteNttf9A1MnxFaEiiIfihcrcn52PHMzo2C38bagbKvc1fPIrYooYQjKdd5YHq+eZ4X7SbjX8GFQczZox1oMRBWGnC6vxsbqPH9kss949DaP0J/bQA/AoCBFMy7cwhjZZwdlner/9y/IBsZ+SHYGzuVFGEkjVGb5NclA6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VEG3IPGrl5dqEiL90mtoK8FEv9/UMw+3JU/iCYbcvq4=;
 b=aFhxsn4PzP1TdRxcSBKO5k4un+TkIGPHlUDHPm6WG5edsgRHtynzn6XVo5qaOXx94yLD+O9UNLgDzVOdor4g1yYReKke9CtuPlOD8aQs8nc+bk9r1hLog3LIdKNPK9BB4zVFDE8W2L34TRUBYtWXbKRkvRgrxTF9voLnE+/qhxTJNumiZvHFUxCEW29rtEv+K6Aoh7c2wYlKTqQ4Z0fdD3E70JxIl4bfVwFS1MN03giO1e/gVGiDD6kJrLY707Qj6WK9y2GRWrZkz68YgRW8Yjr0vtu+k5Tf8j+OjnlSYcpRUrcn4DaqHNuFUFqNfCZnGtp/mB9G+wGgxA6sUFvp/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=HOTMAIL.DE;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VEG3IPGrl5dqEiL90mtoK8FEv9/UMw+3JU/iCYbcvq4=;
 b=I19I01RzXUVeROY6Z9IguigD4uwGQ22Gqk6L02HqYBJbHHxx3Wv9ztf0U1yEp5s0kk/I+wvjxv5HSwWvsg+sODOhZxE3vrD5FQ9MdHSmXqKLo+xxYAj6AsU19J29ag0Uv9y+guTKgvZn3FtTuS1+ZSD0+GkN4gYoc3YU5f1xLY0crmOn/LNboJnzAmrNIxAvzKWk6HEISfHD8GFqA/zGqmOuz9DmTUEnJ2Th/n1rcfydk9n/bUi7BN1yKqoG8XOOKs0pC4PqkyzscX1/Pch2EZL9WKxeUxtgA+d9Q5ugYhJfCK26xmCPHm7VohSi4qT0WqDFlveCb8vbWv1dWkAbVg==
Received: from GVYP280MB1518.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:19b::9)
 by MM0P280MB0978.SWEP280.PROD.OUTLOOK.COM (2603:10a6:190:2::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.28; Tue, 31 Mar
 2026 18:58:06 +0000
Received: from GVYP280MB1518.SWEP280.PROD.OUTLOOK.COM
 ([fe80::6328:bea5:c218:593f]) by GVYP280MB1518.SWEP280.PROD.OUTLOOK.COM
 ([fe80::6328:bea5:c218:593f%4]) with mapi id 15.20.9723.018; Tue, 31 Mar 2026
 18:58:06 +0000
Date: Tue, 31 Mar 2026 20:58:04 +0200
Message-ID:
 <GVYP280MB1518ACA778AB548B7099DF869453A@GVYP280MB1518.SWEP280.PROD.OUTLOOK.COM>
From: Masi Osmani <mas-i@hotmail.de>
To: Christian Lamparter <chunkeey@gmail.com>
CC: linux-wireless@vger.kernel.org, ath9k-devel@qca.qualcomm.com
Subject: Re: [PATCH 13/16] carl9170: rx: gate data frame delivery on STARTED state
In-Reply-To: <17fe2464-e8a1-4f2b-a024-a78bcf460bcd@gmail.com>
References: <AM7PPF5613FA0B6ADFF8016B03CAA1A9DEB9441A@AM7PPF5613FA0B6.EURP251.PROD.OUTLOOK.COM> <17fe2464-e8a1-4f2b-a024-a78bcf460bcd@gmail.com>
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0160.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:99::9) To GVYP280MB1518.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:19b::9)
X-Microsoft-Original-Message-ID: <acb0e2af72a20c667399a7b1ebb30c50@hotmail.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVYP280MB1518:EE_|MM0P280MB0978:EE_
X-MS-Office365-Filtering-Correlation-Id: 966c2baf-83f7-473e-aa03-08de8f577149
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|23021999003|19110799012|461199028|8060799015|21061999006|15080799012|51005399006|5072599009|440099028|3412199025|12091999003|13041999003|26121999003|40105399003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?a0DNwD2IHtF6rp7ADwVWThCHHX8Ciok3myvEHsBBbmEhzC7WVxWUkCm8jzEi?=
 =?us-ascii?Q?BQZkZda6mtJ5Xo5SHlnoFxshJ63Fzbt9svGU5ib2RDEDZ32sPzgGVJasPqr2?=
 =?us-ascii?Q?e5ZrtnujwOx5YYBiyZmtuK6CtkX6zawA6Mpqa3KZHFGBfsvBRDAj+X8wRc/3?=
 =?us-ascii?Q?+0B4pSV6lXtzsAOgrWTU7e64K2gSXaW0K9i1BXdqyJJFii/5lek3abdR72W5?=
 =?us-ascii?Q?cTG5dK2KNtPJzn6Uz415+0qYLTfMiiaIw0ZtaXkgEnOyx6xR1SMC5tYVd5mI?=
 =?us-ascii?Q?xwxIrTdhaUau7L9JPyC1bLH4EEuvnwBPMN6ffiO+Y1o9ZPe62OECN0c6r2/3?=
 =?us-ascii?Q?PI5E7ybAHUn80G31BzGAtjrFfPDEk1QAjQJgamO6xBcq4puN47U0NjyneTgV?=
 =?us-ascii?Q?StDmUKAwyUpGr6h/TNde88GtCxeTrtdt62eiAqnunP4ILMfTdzwuymX26iss?=
 =?us-ascii?Q?dHhE0W+wq3nH+1UhOCHxaWGP99+vkgCD6Nor97aBiOXfhntvsLAHTRwCwk0/?=
 =?us-ascii?Q?RXwEGrcGBNT6nuC+bp/pXDuAZP8OGApSbQ/02ii8KSBqyLCcyWN0tVM09XEc?=
 =?us-ascii?Q?fCBM05HPybRHAo6O4iBvwprteu2jeN7tmAJhH4xAy3YNfHvHBL+UTMVNvUbS?=
 =?us-ascii?Q?jMk7SMIeHoLCHCCLhSLUjZweWO9BqgP3mvaGBEF30dGGVOo6m/4pWzk4CH1P?=
 =?us-ascii?Q?5Oxkz+K5EpFfMACJRd+YupfXDZ6egcodsATy5Q8IBZbqMf79rP9kl+8k3aMa?=
 =?us-ascii?Q?8Y/+mgsvPtaR2GSlmVq98iBdqGKiQxH5ZyQoMk8V7PxIeTEgmN1269uxyemZ?=
 =?us-ascii?Q?8tdtGyhNhJQPepdSMgp2on+Lvsz2CnK7eJb38bUxoWBCn/VWtDghqjfF8hGT?=
 =?us-ascii?Q?Aid60bacQ+FzknNKrqH9ObAzHt4hvkmAoz4rTY6IyGpYgZPQMzwWr/vTFLOS?=
 =?us-ascii?Q?N9J04DubuTyxR/qcj0yWqYF0eiWb8kXuBFMpqF60yJMdyCsYZuVv/QghQ9yU?=
 =?us-ascii?Q?1e+hyeqFXDf8aPDw7nOxy2U3z4vJDDNU5hgORSufSYHi/L0=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Aqr//UdDp7gZ/OpRffw0P4Lnct0ryK2h9vT7ECUE6IQCkPKJjY6BKB4BT0Aj?=
 =?us-ascii?Q?yWdRKXoIYkFLjqUM7EIuS2ih5oWeQtZNAcQ/cSgmH6iklPnDQjF0jFgrfJvp?=
 =?us-ascii?Q?MDFaXq9TWk5YD16wkFeZ2vniPg87EpVeEYCmy+xqPUxF4+vtZj0dYFRW6Sqt?=
 =?us-ascii?Q?JEdDTp6jKgmqbajDd0CkCBZ9jW4GZv+gC98Iuf5y4D5dmv4DKhqrGBYVDIe+?=
 =?us-ascii?Q?9TB3uXjv4OqIYYN7Km4497PgLsHjmcEeamN2rfzyI1yxnSRaXbtCNpgdzRuv?=
 =?us-ascii?Q?quDl+JXsix2jsJoJQYqvBv4RbnsmcbzNL3oYPp49r6GLtvjmSQOx6Vnc9tNi?=
 =?us-ascii?Q?/FJdnEu/MRuOKBldxYlHcDnbKZtWhpkhNICy39gAp1PF6Wy4VXyTVryIr8gX?=
 =?us-ascii?Q?bFdPncOnguS/pi3rhh5dCiomUcP2RgCmv71/MO1rfYVd/zbGVJgnvMZ+06G/?=
 =?us-ascii?Q?Q7eEiyTi+nqRNZC52j+wjZefg7zxty7nKznFtxNRgl7Wnbb8epJKlszHs+s9?=
 =?us-ascii?Q?F1RMLGdpj7WA54omJjLYgcYKRxxuhb1jKVWlRp+vqdr4pzB8nzgBLCltOb2R?=
 =?us-ascii?Q?PydAfFz49xdd7ZS6SHb9LAVeXKLtRqcdjLQ3+7TPgOy/gsYjxUG9WjZM84LU?=
 =?us-ascii?Q?vgdzO7hmYh2MKuZkQ+rU94pzIxOiFPbsDafcZvL3NNf8ineJcdnfFJmUZsMA?=
 =?us-ascii?Q?P5Q+yzTiZg1SR5jw3bMoGaA8zvZDh/OqNui5CyfkldrFNbZWePaxUEB2M54q?=
 =?us-ascii?Q?xwplCd7+7Mz2SRW8uY/xi1Dqtxlr87yqKwXU43NmfdVOIdVQH2yFOhkjIFE+?=
 =?us-ascii?Q?p1SnuqpNcVgp9mlH+SSnK/xIIhbbxSTeGZIQzy2L9vi5C+v9q0mgelUoA76B?=
 =?us-ascii?Q?lg/8Q/bqYDYk6+SR4e3u88oidtVSOxPxuI71PH/Mlau3D/g8eUWfEHXEpUoq?=
 =?us-ascii?Q?FLGivkXdRrGGAQXOng6uj18jfW6IP8YtiCuBbt37SugL6vbHiaShDphKcjnz?=
 =?us-ascii?Q?SN/Brpf5Qbxspf4jCA2iqnypWYDIKXXWVVNeg74tvbCHcxrWGaBz1u7M578Y?=
 =?us-ascii?Q?WemF8wYXw2ikR5UiIt7mNwpKQYqYRHZDAOwl2taXlMA3KZmaQhk0D5DczOEW?=
 =?us-ascii?Q?cpwJrnIugqR6GAwAQvt70gguYCX3WjGX+YUqd6sr8+qWIaARsoyF+iZ4jJGO?=
 =?us-ascii?Q?3jO0XThnDwfU5MA28d+wEtSN5x8jLOlFIlRIQFtikfvp71G1U+gZUZEhQJGA?=
 =?us-ascii?Q?im36Yxox1yPP5eGx4nyBxhROcTU3NMKeueyShz3TCXD01Ynasmxc+pIByJ+m?=
 =?us-ascii?Q?m9bmu5VunSaM720RYYjiLZ9ildDWsCbE5l3O1f3yM4PYNMpx31Yb7qr2Y6bJ?=
 =?us-ascii?Q?Zjdoi4YMz5EP3hNB7FrHT/ifwMie?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-10872.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 966c2baf-83f7-473e-aa03-08de8f577149
X-MS-Exchange-CrossTenant-AuthSource: GVYP280MB1518.SWEP280.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2026 18:58:06.2213
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-34223-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,HOTMAIL.DE:dkim,GVYP280MB1518.SWEP280.PROD.OUTLOOK.COM:mid]
X-Rspamd-Queue-Id: C139D37046A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/21/26 11:34 PM, Christian Lamparter wrote:
> If what you write is true for an up-to-date kernel, this needs to be
> addressed in mac80211. Under no circumstance should mac80211 behave
> that way... for any driver, in any case.
> Can you please post the panics/errors/warnings?

Confirmed — it is true and you are right that mac80211 is where the fix
belongs. Here is what happened:

On 2026-03-29 we had a complete hard freeze during testing: black screen,
machine required a power cycle. Being a hard freeze rather than a kernel
oops, nothing was written to disk. The journal for that day is empty.

We were able to reconstruct the exact race from code analysis:

  1. carl9170 firmware deadlocks during a restart attempt
  2. ieee80211_reconfig() calls carl9170_op_start() → -ETIMEDOUT
  3. ieee80211_handle_reconfig_failure() clears IEEE80211_SDATA_IN_DRIVER
     on all interfaces but does NOT call drv_stop()
  4. cfg80211_shutdown_all_interfaces() → ieee80211_do_stop() →
     sta_info_flush() / sta_info_destroy_part2() frees station data
  5. USB RX tasklet still running, calls ieee80211_rx_napi() with
     references to the freed station data → use-after-free → hard freeze

The fix is in mac80211: ieee80211_handle_reconfig_failure() must stop
the hardware before clearing IN_DRIVER state. I've prepared a patch
and am sending it separately to Johannes Berg:

  mac80211: stop hardware before clearing driver state on reconfig failure

  When ieee80211_handle_reconfig_failure() is called after a failed HW
  reconfiguration, it clears IEEE80211_SDATA_IN_DRIVER flags on all
  interfaces but does not stop the hardware. This creates a race window:
  cfg80211_shutdown_all_interfaces() subsequently calls ieee80211_do_stop()
  which runs sta_info_flush() to destroy stations, while the driver's RX
  path may still be delivering frames that reference station data being
  freed.

  The fix stops the hardware in ieee80211_handle_reconfig_failure() before
  clearing IN_DRIVER state, ensuring no driver can deliver RX frames once
  the teardown begins. The drv_stop() call is guarded by local->started
  since some call sites reach this function after drv_start() has already
  failed (where the hardware was never started).

  --- a/net/mac80211/util.c
  +++ b/net/mac80211/util.c
  @@ -1614,6 +1614,18 @@ static void ieee80211_handle_reconfig_failure(...)
     local->resuming = false;
     local->suspended = false;
  +
  +  /*
  +   * Stop the hardware before clearing IN_DRIVER state. Without this,
  +   * cfg80211_shutdown_all_interfaces() tears down stations via
  +   * sta_info_flush() while the driver's RX path may still deliver
  +   * frames referencing station data being freed, causing use-after-free.
  +   * Guard with local->started since this function can be reached when
  +   * drv_start() itself failed (hardware never started).
  +   */
  +  if (local->started)
  +      drv_stop(local, false);
  +
     local->in_reconfig = false;
     local->reconfig_failure = true;

I've also added two driver-side guards (sent separately as BUG-012/013):
- carl9170_echo_test() in op_start() to fail fast if firmware is dead
- IS_STARTED() guard in op_stop() to skip USB writes if op_start() never
  completed

These reduce the probability of hitting the race but do not close it —
only the mac80211 fix prevents any driver from hitting this path.

The carl9170-side patch 13 (this series) remains necessary as defence-in-
depth: even with the mac80211 fix, the IS_STARTED() gate prevents frames
arriving during the brief window between drv_stop() and teardown.

-- 
Regards,
Masi Osmani

