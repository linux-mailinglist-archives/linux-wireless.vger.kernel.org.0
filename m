Return-Path: <linux-wireless+bounces-34241-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4OEyC90lzGnuQQYAu9opvQ
	(envelope-from <linux-wireless+bounces-34241-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 31 Mar 2026 21:51:57 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C4518370DB7
	for <lists+linux-wireless@lfdr.de>; Tue, 31 Mar 2026 21:51:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 36805302AC0D
	for <lists+linux-wireless@lfdr.de>; Tue, 31 Mar 2026 19:51:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 447EA3914EB;
	Tue, 31 Mar 2026 19:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=HOTMAIL.DE header.i=@HOTMAIL.DE header.b="VuFcLtjn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from GV3P280CU013.outbound.protection.outlook.com (mail-swedencentralazolkn19010043.outbound.protection.outlook.com [52.103.35.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D032A371D04
	for <linux-wireless@vger.kernel.org>; Tue, 31 Mar 2026 19:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.35.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774986715; cv=fail; b=NDFm4nUpEVHP6pBBVye/a1hqsp7fQenJBo7EUEG4LrO7wPKtfOLn96AVmxKsq+L2LNqK2cNeWeEXRRz18FIEoNVqibXBB4CvwZXydHZD7f06InZy+TJvKZMYOEdk33DcFfxkNttU3y6i2YTMzvvNKbLhed7W7X1gS9xjenOPCdA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774986715; c=relaxed/simple;
	bh=Yxy5iIjYJdpE4iSnGdcuKpIsywBezn2+4+8VpKD1sVI=;
	h=Message-ID:From:To:CC:Subject:Date:Content-Type:MIME-Version; b=FQ9W6N6DW6cZ7WOX7safur0uWy4Hi9SRS9TJHxcOOY8S0xSseh+SnxgD8NFqWijqXhe/X/Sng9Wt0GSXGZoctnhToh59oBRMEGthOiel0kh7Z3NMGnXliIZQiRpAZszTJ5PCiJWYWVyOj32V/YTl+Pai3N83w++gXp+aHaSNBXE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.de; spf=pass smtp.mailfrom=hotmail.de; dkim=pass (2048-bit key) header.d=HOTMAIL.DE header.i=@HOTMAIL.DE header.b=VuFcLtjn; arc=fail smtp.client-ip=52.103.35.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qk5lSg/8YDaNoZHMqePsGU6wuORA860YdPONBP9a8hnZtu21Jce2oqd4E64G1G8wqK2TVGo9G1z90aHq8g2GAbWHV2ArW+gMy/k6igpC++h7HSn2jC5laupX8xHYzryoadWz8RA0kSPU/PhVdFJ1C8jG9gCXuS0WUbTNuUlcP4ldapQczP167o3X0tebj1PCw/K6JpePsOGMxbZ1fSGmF2rq+7MRLsSMCDN3JsaavpdPmg+LOBmXwGVqOaa3/STgNH3z/y41NP5VNfKpWy1oHeywCSjJ7DHqnt1wmOhEfKRHlDo12/TP6ejJeK4mQqZW358EwlwPz2eqdzaCsDt8jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xHcAsEHoCBFRTc9aDJt4Z/CBTcKMVRlpQG20KJtieQo=;
 b=byzQE5npRZE9FWjuRv0u4Lt4HC50iNry9LcELpUcio/o1OjhxWrFEKV2M5xcB8PCvrR3ekoCdCwK1uMhjMQth3VXXnNFQ3nLV4LY/KG86RAajwWJgkwiZLO5k+fPTcvLv+Xs3B/AzVFRSuu81wJ4AHYhRunoBdJi1M7YvLfbhgNjNZKzFxk9WVXaiANzGCl8r6CR5rIiSz/BqEV8zAtAE/RHKNwAMkob5MuR8I8HhjG28xSpaS4cpWmZdKQKvyV+/0oAHtwa0udxayWamVWwEk6GBeejJjfMTWNu1XvVhEQT3wjfofU09bDsxPdzFdcHr/GOQ44zwY6QIrzq1AuAWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=HOTMAIL.DE;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xHcAsEHoCBFRTc9aDJt4Z/CBTcKMVRlpQG20KJtieQo=;
 b=VuFcLtjn69WLT6IbbsRsxCEYWNw/i10z0/wsAS6flvMngxKb99YFCyS91yMTIW9nypMvualUUGPWfRl7EG9tSDzypAJU0JH/+uAS4JYUtdwTaFnAOJ5GbIaG9q3gUrE13IwlmbQFxfU8WrbxZF/OKUurAE//RXVbB9foes55i5YegPT3qKENBohROxNfEBMjORDkG5J9HhMFBU+nGjtm5KSMyXA36gx0Pcizow/te9rcOxEfzcO4G81r1udbRqcfP5AYHZ10YwulCHWZZOhsTq1eAxnbgpbgRZwhHP0C9qNyBuPQrsoKz1uqy+bXldmVIrXWg3LKmWktkK3pR+vwoA==
Received: from GVYP280MB1518.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:19b::9)
 by GV3P280MB0433.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:10::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Tue, 31 Mar
 2026 19:51:51 +0000
Received: from GVYP280MB1518.SWEP280.PROD.OUTLOOK.COM
 ([fe80::6328:bea5:c218:593f]) by GVYP280MB1518.SWEP280.PROD.OUTLOOK.COM
 ([fe80::6328:bea5:c218:593f%4]) with mapi id 15.20.9723.018; Tue, 31 Mar 2026
 19:51:51 +0000
Message-ID:
 <GVYP280MB151883A5BB2910EE6439DE2F9453A@GVYP280MB1518.SWEP280.PROD.OUTLOOK.COM>
From: Masi Osmani <mas-i@hotmail.de>
To: Johannes Berg <johannes@sipsolutions.net>
CC: linux-wireless@vger.kernel.org, Christian Lamparter <chunkeey@googlemail.com>
Subject: [PATCH] mac80211: stop hardware before clearing driver state on reconfig failure
Date: Tue, 31 Mar 2026 12:00:00 +0200
Content-Type: text/plain; charset=UTF-8
X-ClientProxiedBy: ZRAP278CA0010.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:10::20) To GVYP280MB1518.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:19b::9)
X-Microsoft-Original-Message-ID: <6e85fb01d6550e8dc1a881809dcc08dc@hotmail.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVYP280MB1518:EE_|GV3P280MB0433:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a37b35d-ee16-46fb-0718-08de8f5ef369
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|19110799012|23021999003|5072599009|51005399006|6090799003|5062599005|8060799015|15080799012|461199028|3412199025|440099028|12091999003|26121999003|40105399003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QjZ2alZ2VzhXK05zamUvNG5tbEliMGptaFU5TVVkb21LK3JPaWNYb05wck9Z?=
 =?utf-8?B?bGJoSEtwMjJaNmgzdmFLOTVUVEVZelhNR3J2ZDNNdFE2UTQ4d2ZYNTJPM2pk?=
 =?utf-8?B?SlJlUnBmR1BXd2ttcjhKcTV2V2NlTUhuaWwwVE45STdtRHV1ZXZYK0xzQTFa?=
 =?utf-8?B?dlZvaWVJWkZMWkI4K1JQTXBkaEhTc21PLzRHb2xqWENJYjQrM0ppVER4UGF3?=
 =?utf-8?B?YS80Qk5xOWNEZnF3ZzViclU0YWZLc285bFU3eC9RbWNqV0VoMEhON1BJZzh0?=
 =?utf-8?B?a25RaVkvRVJXaWpCUy9UTzB5Q2VhWFNiZktDaUt5YVFXRWxUZXBXYThUYUNr?=
 =?utf-8?B?cEljRklzTGhXNDA4MVNOZHRXMm5zWFptTjZudjhhVDBYZDRhZkRJWUpzejhL?=
 =?utf-8?B?TDlzYmZjaFRyN2VCT1JaTXFtTkljdXN3Z1h1MUxwSjRERm91RlV0aWI4Y2pV?=
 =?utf-8?B?TDB6cTB0SStwZGxubG1sODNWRU5nL1dwSm81SFkwMndVWXNtL2ZxYlN5UHV5?=
 =?utf-8?B?VVpyaSt5UXJmZlBybGFtME02UmpTMUdDVzZjanZwZ2s5bTBMcUd2VHhybXBS?=
 =?utf-8?B?dWh6Q0JqU25qeGhaUVJnckkyaEVmMGM5S240SVBlVzNCMDZuaXlJMG9veXVM?=
 =?utf-8?B?ZHpDT3pVd0V4dmJPY0VjZ0ZMRWt3NWpFY2Fid2dkYUpnTXlPRm94Q1JBMlBR?=
 =?utf-8?B?d3ZKUzQvTEFqekJhSWsveUFrMG9ORkwvQjlQUHhwYkpxTzFZZjBhQXRsWVJF?=
 =?utf-8?B?bCtQbFo2dHdJT01HMEZGTHJsb1pHSk9BemFPUnREeFF0eWlRRURVSUpWVVor?=
 =?utf-8?B?cDAzQ2Y2VlNUV2svVmxlWG5XRDIvcVpISlNuWjdJbGV1S2xYRXlhbXpjZURu?=
 =?utf-8?B?S0NWd3BSV3dlUzY0Y0lSOGpVNmRkcFNpaWQydnZuazdUYU9MNHNJWG9Jbldi?=
 =?utf-8?B?ZzAvQjlQMndXR3FpMnNGK09QRy8xMnAvaExNVUlVWVZWbnZpMi9JdEEzUWho?=
 =?utf-8?B?UXg1WDAxSVVCVFN1dkl6ejhJT3g4ZnZqZ1VQaHlab00xbFJ1Z1VIaEd6cmFo?=
 =?utf-8?B?bUhqMldQdkdsZzV5Z2pFZE9jQUJXd3VTMFZTdEJod3hxV1NqQnlGWUpsZkw0?=
 =?utf-8?B?SDFZNjVqYVVweFphdU1Ea2puVkhiSm1OL3h5MThXUmRQd3ZCWENNMElMVDYr?=
 =?utf-8?B?WnE2c3ZmbkdJbVc1OFhFVk01RTRQdks3RklsRVFiWUNFUVpUUlc3UUE1OFJB?=
 =?utf-8?B?b3Y1Y1pqOUVqZWhyQmdSb09tK2ZsUHN1R0xvLy96dnZQVi9qQXV2enJxeXFJ?=
 =?utf-8?B?NVRQMGdmU1dYTzlWME9hSWhsRHZJOTVCd2d2TE1wL3dnZWY5c0o3d05Hb3pt?=
 =?utf-8?B?My9GWUdzZkgzbEE9PQ==?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VmZSd3JpNnBmY2JZeVNVT0V3bU10c3k4a1UxSXJVMUM0Y2VRUHZhOTlZbUpM?=
 =?utf-8?B?bUpuTnBEVTJsVTZNZGljWldhWlhmSnM4QUR6c3Z5cDdJSC9vd3hlQ0N1dG1y?=
 =?utf-8?B?R0FOd3k1OGNHcjUyVE9rbnhRSUNGclBGdWxSZWg2S01Wb2tUM2JhS3U4bHE5?=
 =?utf-8?B?djNvNHNyQzQvTXBDbGhCSC9ReGdCRXVuZnAzdlFzMHhBTm81bHRsUGFURU9C?=
 =?utf-8?B?eEl1dUdpYkQyYWNqbnJXSXY5N1NjU3pOalFTZWVBS04yMlc0VGd6L0swaVUz?=
 =?utf-8?B?a0xOaFBPUHJPSm44Z1dlRGliOWNxM0JDS2xUVXd2dlR4WDc1bUExZkF4eG4z?=
 =?utf-8?B?b2tiU0s4KzRkWUdNTmw0Z2FkVkZoV0RzZUdJSDhzMEJOdHNMKzl0Rm9ZRTkw?=
 =?utf-8?B?SmdCdUdmL3RKWmVCczdiWDl3bW9pdlhHaUhSWGplZEhUQXhLdk5ZVUE5M3pV?=
 =?utf-8?B?aDRtUHliNEVTV3pFNSs5dDNZZ3BEeldiMFV1TmdpeWhnZjljYXpObW1QQm9Z?=
 =?utf-8?B?czh5WlpHWE92TCs5VUU4M282QWpWSDkzZXVXbnRsNEp0bGlSYStZUXhlWjBk?=
 =?utf-8?B?MXBRZzZ4QWJHR3VIYkdFZHo3YnkyV1JXQitVRzFPUWFURjZ1RTZpRjJudXhJ?=
 =?utf-8?B?eE4vV2xGdnBEWjhXcmZMTTZ0MXhoZ0c1UENUa292a3ByZ2JOUE5HWVUydTNU?=
 =?utf-8?B?a2lnZDZJN01MemFBYktkV0liTGpkdWVrU3hSa0J4ZjVOdEhTTTd0NWMrOFE1?=
 =?utf-8?B?Q3JHZUw3aXMzVWFBRnd2akUrcXZwendRZExOeENOOC9oczBBNTFvRCtWK1BE?=
 =?utf-8?B?YlNJN3BDWnJIeS9yQW5kSlc4L1B0QjRmVnY0eXB4N2xSeGpxRnVpVmwxNG5r?=
 =?utf-8?B?K2JBcGlZMXJwa0dXRnlncW94UzZuU3I5cTVka2w3d0ZYdXR3T0ZLM3ovNy8v?=
 =?utf-8?B?N1NpeFRnTTFXdUlySzhaUHNQd0t0cmdBTVI3R2ZWckFUQ1lVVHRUR3dwWTJ6?=
 =?utf-8?B?eStBZjV0dHA0cS9hK2c4ZVcrN3poQ0NxMHpOUnppS1U4dEgwUXZpTXE1ZzB5?=
 =?utf-8?B?NmM4VTFjRmg2c3ZudzNYS3gwZzNESEJVbDJ6OU5iZ1lPWW5iaTdVWi9uckNO?=
 =?utf-8?B?cCsyaGc3NmlXUDkrdHQyNUlpRHdIREtaQk9tMUxjTnltZ2ZUMjVNL2dLbjd0?=
 =?utf-8?B?Y1VXdW4wbEVscXFYZWh3SmlQZFNrNGlsd0I1dGdyaTlINXlYazI3VUZEWGNT?=
 =?utf-8?B?VzRTbFA4VFMvRWhNUnRYTTY5ODZ2Ri95a3VpWVdBaWFUSzhlbmk1d3plZ05t?=
 =?utf-8?B?bkg0N2twNWM4bzBxaG11WHA1SXFWbWRiOXJUa1NtM2ZXZ1RlclR0bTFzU1V1?=
 =?utf-8?B?T0llTVVvVHUyRUttSkp1N3l5K2VYNWwwckQ3L0xlaTJlYWltSmU2azNubnJq?=
 =?utf-8?B?T0w0SjcvZWJSR0ZoZXA3eUtCbnRaQTlJVThPN1ZpVEo1Z0dJUHp4a3lyOW5F?=
 =?utf-8?B?QnJJNE1QL09TK2pUN2tZMjRWTHQrVG9Qck9Sbkpvcm5kWWp1Tmx2Y2JndWln?=
 =?utf-8?B?WVhsOHlTN2hCaExFS0kzS2RpMkF3S2pSRG9OdXloV2FwRk9KSXJhaTBiV25p?=
 =?utf-8?B?L1ZqaDk2aEpseU5LT29uTlR0V0VFb3EzNmFBRlkvWUFlckQvR09RM1Ayb0ZG?=
 =?utf-8?B?eGV1NTlZRDlVdkIzY3U0Rm5FZ09QTTdFWGZBZ0FVL2JxTi9sYyt5TDhNL0Fa?=
 =?utf-8?B?bld2ekM3R1RsMlR2S2VBaWEyNUtNSHZZMURIRTJIa2FWY3J2NnJvWHhOVFlH?=
 =?utf-8?B?UnZLWm9TbnJvekk5VGNHcEZyVXIrTHhoUEdndWVlQi9jdW9ManpoS2Fhenho?=
 =?utf-8?Q?IGizl9Iw8Fw/l?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-10872.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a37b35d-ee16-46fb-0718-08de8f5ef369
X-MS-Exchange-CrossTenant-AuthSource: GVYP280MB1518.SWEP280.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2026 19:51:50.8947
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV3P280MB0433
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[hotmail.de,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[HOTMAIL.DE:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-34241-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,googlemail.com];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FREEMAIL_FROM(0.00)[hotmail.de];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mas-i@hotmail.de,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[HOTMAIL.DE:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,hotmail.de:email,HOTMAIL.DE:dkim]
X-Rspamd-Queue-Id: C4518370DB7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This patch fixes a hard system freeze (requires power cycle) observed
when unplugging an AR9170 USB WiFi adapter while under traffic, or when
any driver that uses ieee80211_reconfig() encounters a firmware deadlock.

The race: ieee80211_handle_reconfig_failure() tears down station tables
while USB RX tasklets can still deliver frames that reference them
(use-after-free). Calling drv_stop() before clearing IN_DRIVER state
closes the race at the root cause.

Tested-by: Masi Osmani <mas-i@hotmail.de>  [AR9170 USB, Linux 6.18]

---

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
ieee80211_rx_napi(), causing a use-after-free kernel panic.

The fix stops the hardware in ieee80211_handle_reconfig_failure() before
clearing IN_DRIVER state, ensuring no driver can deliver RX frames once
the teardown begins. The drv_stop() call is guarded by local->started
since some call sites reach this function after drv_start() has already
failed (where the hardware was never started).

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
Regards,
Masi Osmani

