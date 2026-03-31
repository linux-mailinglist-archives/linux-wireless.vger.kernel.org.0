Return-Path: <linux-wireless+bounces-34234-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GLQDK1oczGnHPgYAu9opvQ
	(envelope-from <linux-wireless+bounces-34234-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 31 Mar 2026 21:11:22 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F93C37064D
	for <lists+linux-wireless@lfdr.de>; Tue, 31 Mar 2026 21:11:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EB7EA30A166E
	for <lists+linux-wireless@lfdr.de>; Tue, 31 Mar 2026 19:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AAC43A3839;
	Tue, 31 Mar 2026 19:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=HOTMAIL.DE header.i=@HOTMAIL.DE header.b="mMfMqO6t"
X-Original-To: linux-wireless@vger.kernel.org
Received: from MM0P280CU009.outbound.protection.outlook.com (mail-swedensouthazolkn19011027.outbound.protection.outlook.com [52.103.34.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1807223DE9
	for <linux-wireless@vger.kernel.org>; Tue, 31 Mar 2026 19:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.34.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774983991; cv=fail; b=dT5fZ0itL4OpyqV/Q13QDiVhRcL21suBZkZfaw6Ozqzl5unErUOX2Z6RYeA8kruK1hV/9z3WgscF7Dt1OG6dUT4kn/C31tvKkuOLLzbIzXTl9DgEUhzWoEG9fFA6z28wRnnmAOViNRWzT0ogflvGT4C48pA+aTHyQ3TW+G8LYTE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774983991; c=relaxed/simple;
	bh=OEhyXE7HLhkJu4jxmniDhC8wuaujXj3paS26UF5NVck=;
	h=Date:Message-ID:From:To:CC:Subject:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qPXaEVxWvCBHp2oY9f82KbsgrKQJ6GG0QeQdpKJmcxtAOW/pzf6stcpjFqOQvNcO5tAEEXRynTn/ZY9MxvZy706ZNlot6LNi9qk5/rBNP1OAsPUv/EvmCplKI5yYRvbz67Hzil5IKkce9o9u9dbxS+3spqZfAVVEca42s5+3MEY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.de; spf=pass smtp.mailfrom=hotmail.de; dkim=pass (2048-bit key) header.d=HOTMAIL.DE header.i=@HOTMAIL.DE header.b=mMfMqO6t; arc=fail smtp.client-ip=52.103.34.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JNOHpADPT5631rPizCJ+EUorkLzrAnvv/yeZOFECfk3lov2Ax/b40zzvJ0XXRFYV0sOBiBOiWlgAB3ZDKlwZ0iNM2QHtZywOtVN7U+EFupbM6c8jGbGpAzMZHYiTehI2M9O4vMto3H6KDx9tKVoHVvTJ1c5KZO+H2GshFVueS1IeLud1ZmgC3h9W8ZMjo7TkzHG6L2xFp2RIkg1E7WLpzwYs7ioXgdMgf+l/TJI9WuNaomW+HhzYntDBGVpBLz9HbL86qs7byInnOWXobSlvkIC5g9kyr4z2sTbYjuan0m6fIwfMPgnECIbmEn42lCWvZ4XFaW/lqh3dZiiXiepHTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ef2Ij3U7VFcoL1T0O4SmfHEo3v1TJizpYGbwLZE3RDQ=;
 b=tlxkErpsPK+bfeYrd6gbm0QhCnwL9KQL1IZoxXl8G1C1By4/qHSLA/ui1QfOwBZEEXBfzNM+AuNkxGPJZ8CnACEbjyoUy81dDJ9YJ1Lkb8x1aRuSzP/zqG+EcrHwuJVWNPi2De8AflRGlVpbMSZc8hpjJjTjxY0GzNen78zNVdioj7QXC/XYo6o5c3n1dMrTATjMfUPxwfvky6VbouSXeAoqhw7PofMYT9epPamQk8pSiab0B+nvjcCdDbPTXbBCIPwS8Idol4noDzbkRdMkbEWc1V31zWgt6VQ3Sy9rs9YW6SsYy9GU37ByVNapqdZN9W5Ij0juf8xSXbPzSscQDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=HOTMAIL.DE;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ef2Ij3U7VFcoL1T0O4SmfHEo3v1TJizpYGbwLZE3RDQ=;
 b=mMfMqO6tB8c0RqD39Np923GHLQ4G+NqazQ29e6pIrs/OfWzi2XwMiiKFOKQdkL+dU3vb2Gii6ZvU5k+nAuwhfVD3qHwNFOhSwkUX5GVddQ2FCAoosy/pH5c6YxXQRjaWylDc5eYKIwl5Iw+FPyDumoHn2nKhKKeecD1fH7L1CVUM0n/z8lIvvL/g8ekvgY4FJEu0FGV3hGDdhmebscpbqejsl+ABQ0tX7FRgZIBMoIltiepw924jqa+nqHO+Tp1MPH9hdBL+7SEv9wiyTfL+81kfPoUAQrw21MD6k76s7/kpzYh0b8SxlMSabik8PYDCHF0zkQASJRQeJ++fZeDQMA==
Received: from GVYP280MB1518.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:19b::9)
 by GV5P280MB2028.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:376::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Tue, 31 Mar
 2026 19:06:27 +0000
Received: from GVYP280MB1518.SWEP280.PROD.OUTLOOK.COM
 ([fe80::6328:bea5:c218:593f]) by GVYP280MB1518.SWEP280.PROD.OUTLOOK.COM
 ([fe80::6328:bea5:c218:593f%4]) with mapi id 15.20.9723.018; Tue, 31 Mar 2026
 19:06:27 +0000
Date: Tue, 31 Mar 2026 21:06:25 +0200
Message-ID:
 <GVYP280MB15187353282B2DB39605C8BE9453A@GVYP280MB1518.SWEP280.PROD.OUTLOOK.COM>
From: Masi Osmani <mas-i@hotmail.de>
To: Christian Lamparter <chunkeey@gmail.com>
CC: linux-wireless@vger.kernel.org, ath9k-devel@qca.qualcomm.com
Subject: Re: [PATCH 09/10] carl9170: fw: enable DFS radar detection
In-Reply-To: <093b7bad-2ecc-47af-9763-958283a102d6@gmail.com>
References: <AM7PPF5613FA0B6E8DE143A385080A72F139444A@AM7PPF5613FA0B6.EURP251.PROD.OUTLOOK.COM> <093b7bad-2ecc-47af-9763-958283a102d6@gmail.com>
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0444.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c6::6) To GVYP280MB1518.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:19b::9)
X-Microsoft-Original-Message-ID: <567cbff657dd989e473cda51c0cfd1f8@hotmail.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVYP280MB1518:EE_|GV5P280MB2028:EE_
X-MS-Office365-Filtering-Correlation-Id: c4d96467-ce6a-4ba6-e5df-08de8f589c11
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|15080799012|5072599009|23021999003|461199028|8060799015|19110799012|51005399006|440099028|3412199025|26121999003|40105399003;
X-Microsoft-Antispam-Message-Info:
	FTB7rdeSuy0Wn8hIEcLI9Jj0nhQ7mmYLabSi6fAIobWRObkxvjSFXJeIevwmVqbWy89BhGxOiMHhVOtapaVqjILUOo2P+xA3kZ7EKlogliJd08yjvpuMgNAEGej8McwfnLRCQaTWOSUdbhPVw9WxErlOY/rZPlF7SNW6CNf6lReobXhVMZLYlZwdtdgR9Y9ZkxE3B/F3RegZG+BQ/H0LbiCitwiSh0bTyppeppaGJyV/0HgfD43oYfURJavNZK659wkDqLt6HKoswkXWgJ+oiyYJJvn/FpNhMfsTZNSMgpVL89OWo8LL5mP+UqualJrlU7Bz5g7OMhda+ocyqOguYruGWDSL9dmhv/65qbiwmW12kp0x3xJqWxMGc4HtwHOECSKzHMfV1ur63X58QN4xIZ2fl5XS3G+5BAOaiv6sfWnkkQJkmmHKcD4cNgFZ8BHvZhYrFCOdKdqZGieOJEwHQUSxct7u3dm6j3jAc+w0rFSNLFsNlSlyJehJOjuF1yI81Oic5wVbjrHE1hSVXqgIj5W7ozskztT1SrivzyKo75jLhsSHDd7jDS3tyVRyUfmclRubjZe7FoF0ncU5E8pTCluf8gdCec0vRpKS4ip3yflwODrCQWFup2iguiP3EvSvcR1A1Arzn1dxZ0WfG9MpomVFLjcb7EZxWwnKWNYJafZ7L4zjGucRiacuZi8CtQ+ICisnlrbwRk+BWMYapLJKmwvbnDyhcEbpXDoa615A8D+1cqWFv81sFxWeeFuvWEiBZDE4lQSTy3tGCnymBS513aGp8bKsiwaCDgVw11pPEPTwSxqEERuIOtaP0DmiuQgok2iBMNtonLKeksNhc60wVqdBxh0XAqEjpkoQMZweza+qOiNKgYUrY0R79b2rvDuzwOJTFT/uzgUlXxI/1m7ujovD12itEC2Iy6eyLHCcrf7QyS6cJBzGuqJ8zf4KzmKo
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ROeint1El3Ha6WGYStYd3kOEvfnuXRXsg+di3G4zI5zzXZBqBBRZFL31HJYx?=
 =?us-ascii?Q?9NEHiOM7dSdHHtn3TDUH2E8v4Hf0HtYKpMZafN8FPSCZC5TEn+RN6wcI/7GD?=
 =?us-ascii?Q?rCCHP4gw3SbdD2lKtrY0Cqis1HWwVaOVLaCdMdJOFbhzw2B2FaBT2HaprMJ/?=
 =?us-ascii?Q?9FOlvZ9b6ROBYZK27DwkE9SjNr4vl5Vn/y00BIaP+YM8KpxhEGnpwMDbbKYW?=
 =?us-ascii?Q?/p5u5EczWfVIu2tVK+uy4ZZ5tZzqfYOkut0xEpx/y1xx2PT0uYN/3QuMxFxd?=
 =?us-ascii?Q?ihiif1gNx0N2zTqpQNRF25iG4exY4MP9C/DOHfdDaiYyhNJazp6Z4HQ9XYP/?=
 =?us-ascii?Q?X/WP65VCE9Nudz76cybS056HCWB+saH4SNPqpuSGulHBHi8CoZ2fsYtRxEIH?=
 =?us-ascii?Q?hHglOlGbk0tSDFuj1RSNw2FHGS25E7FRk1XI3X5k2YKPZr5dUPPGeu3VTVD7?=
 =?us-ascii?Q?jzcfN/K0b6u0dPUDqnNoCobpGolrlBZ+6tm6Kch40fu+haoYOOSTlsufjQpY?=
 =?us-ascii?Q?HAGhGauBihzw22qJiMIUQdi32txQD9ix1oy1PU+ZW2dr/czf4hs2kfjC0xv6?=
 =?us-ascii?Q?vWyW/RivSUB+sY+mSU3RYUCMqTpQRXB7tAB3Z+6/FAYCNDVHoAOubZj825z6?=
 =?us-ascii?Q?9eCX0DKb126lj9oma10TNnhooZqgTSy8g4wrtsUxx8spbci4Roa0OMnN2tPA?=
 =?us-ascii?Q?PEXrm5YPAdHcKQTcyDIZUHgGB9gBPVnbuTbV235yZ1dZ11CmQZnESxrHmiX8?=
 =?us-ascii?Q?KRmgVDVTqms0uepBsa1EJrtvaB4Q291lwpv3KRDLixHIEDKHH/k3vFbnVieN?=
 =?us-ascii?Q?3l8qP13Wx8LjI6CBsNWnpk/KEejByeKBlDUCqWRVtSioGEa1GW//46DOHXyu?=
 =?us-ascii?Q?1EvweMcfQoVfuKmEBM/4Kycryot1Ahqs7zTyDzMpwWfmWJF+KyfcqrI9TAYQ?=
 =?us-ascii?Q?DfhCi1yRCwMoqzbQTsB4nr0QS3JABIeovd55MtPwhb3XprPR94XF4fMsHzhr?=
 =?us-ascii?Q?MIH7OZVjGyXe7TnNNxarW5OlKwKCb4QvuAiJaSTIKHPPNj/AL9o2dVFvhdUQ?=
 =?us-ascii?Q?zYLbniGWq/0YK6zMry5nDLJCpqtbCQHwsYTixCrZ2EfyLd09wMaRLGtu5x7w?=
 =?us-ascii?Q?LAjf72G0ogSCukfMK9RV6CWu8Y5zc9OiATvztcOVoVGZNW3yHHhq+5xS6Fo9?=
 =?us-ascii?Q?JWPrMMcxM7fnN9TsISCBuiMydY9MVb3qwADh7XxAktt8H0Q3oERTyR85fgw5?=
 =?us-ascii?Q?dVhl0VxEZ6RpAk4bNbFt6jrdJNSKIDePRVhz5l8GHjcUzPog/EWBATKEUUJA?=
 =?us-ascii?Q?31b53op6DbIZ0pcw05ru/PA5+O7SIglDKimBYYL9BloNPkPX6jfdCJPG4I47?=
 =?us-ascii?Q?KqZMIQAYBc6wxW4rG1ctXHDsMeal?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-10872.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: c4d96467-ce6a-4ba6-e5df-08de8f589c11
X-MS-Exchange-CrossTenant-AuthSource: GVYP280MB1518.SWEP280.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2026 19:06:27.3816
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-34234-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,GVYP280MB1518.SWEP280.PROD.OUTLOOK.COM:mid,HOTMAIL.DE:dkim]
X-Rspamd-Queue-Id: 1F93C37064D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/21/26 9:11 PM, Christian Lamparter wrote:
> Which values did you use? The best I can find are in ar5008_phy.c
> | conf->fir_power = -33;
> | conf->radar_rssi = 20;
> | conf->pulse_height = 10;
> | conf->pulse_rssi = 15;

I used values adapted from ath9k ar5008_phy.c with adjustments for
the AR9170 register encoding.  The mapping is:

  ath9k ar5008              AR9170 patch
  fir_power   = -33    →    FIRPWR   = 33   (magnitude, sign implicit)
  radar_rssi  = 20     →    RRSSI    = 12   (scaled for AR9170 format)
  pulse_height = 10    →    HEIGHT   = 6    (scaled for AR9170 format)
  pulse_rssi  = 15     →    PRSSI    = 1    (minimum threshold)

The scaling differences are because the AR9170 RADAR register fields
have narrower bit widths than ath9k's.  I used the maximum values that
fit without truncation, targeting sensitivity rather than specificity.

I must be honest: I have not tested this against actual radar
transmitters.  I have no access to radar test equipment.  The patch
wires up the existing firmware RADAR event to ieee80211_radar_detected()
and programs the registers with reasonable defaults — but whether the
thresholds are appropriate for FCC/ETSI compliance is unknown.

If you think the values are too aggressive (too many false positives)
or too conservative (missed detections), I am open to adjusting them
or dropping the register programming entirely and just wiring up the
firmware event, leaving register tuning to operators with test
equipment.

-- 
Regards,
Masi Osmani

