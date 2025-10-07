Return-Path: <linux-wireless+bounces-27862-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E416BBC1A7A
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Oct 2025 16:09:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E25CA4F89BA
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Oct 2025 14:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E71E52E1EE1;
	Tue,  7 Oct 2025 14:07:09 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazolkn19013014.outbound.protection.outlook.com [52.103.33.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5A102DC337
	for <linux-wireless@vger.kernel.org>; Tue,  7 Oct 2025 14:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.33.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759846029; cv=fail; b=djsb81xe6BmcCrQ/usV1FDAasVtJJ48vAxBmwOQM0PFJDXA7dP6vgyZS0lXWc5uVqxweZPAfCxbA1/p9cHRD3BaLXp3ULa3ZBOAtSrKYxmmjgEkmZ19jBHJKSLdPm6b0/F6x3VyhVXI72FNuVwmBxBqZScFJD2d3Bu5zEswarvU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759846029; c=relaxed/simple;
	bh=2a1UoYf3lZcd/18m9/gDGwmxK6l2M4UfFlD2bwhb5Tg=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=HLu45D/4JzY7+ciFTnw74fQ7LmIailXMqEAYNVNhVqfyg69MBE9cPqeFzAG2t7V72wM9+9gTUQUHlRuLawRhs7jMH0+2a0CKL5KEhz1jRF99+/EhgL6kBqYYFH6M1pkL93Gw38Y3S4wciVnVJJKCmDyV+ko4/CedKUClA/fejj0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=outlook.de; spf=pass smtp.mailfrom=outlook.de; arc=fail smtp.client-ip=52.103.33.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=outlook.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ktP+TqmE3a7yGusrgfV9tySvxGoNKo0jqOumThL87qGjIzReF65nPKH8LqESttquE5G+vOZl1la8OqU1B1DSKvugpTMI6Ku/E2nweIkpES7OjwOSPTp7v77lDAhwMAVgrm/MNqFcTlBIchFKxQW+iQ0IQDqwKapq0SgBougJ5cmmWTwnrOlHcnfUMNY94DChz1/CkGzb7LmnKvVqfPeNTG5V5DDc6duSUZqunhEiltLpvzCq6a34o6sQUzFvgP8CB26/h3ShwdEXhzRssDBYymxpcjM191obaSo2fFSEBBc+g6RmHM2DtkM/ENIOJJAWtLY4YBrWS78TZ0+SdIhCtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=duT+da21CcEfA7gruaTzjFx3SzuaUwQSpeHFOK6NVus=;
 b=AgiQ1TyZnG25iJNUl3RZA7BJ2yL/NBH7V0faicvqBKlkWQ6SoMIikhkm2qOAO9/RP0jfcJaxXc6HsyuJDgw0DWUGJKrDqnyTvdgElUb61uOIssd4orl7Jwg+ICQHW0KLwUlQX5xi/WmsRqwJXsj68te5OhcZpKQUorklz27xAJ906paTXps6C2Tz1YUMeP6FPgV2weeSCCI3845t2Z4r6Xm7TCM59lWKlcpZppIUPnajZQ/sQUKfjWjydaOMpPl8/xDhXMx2QO/rkoAF8L6F2NlPUHJjhwI2xtO7kiWdTWkcjGIrKxsX5Np7NIj6jA1U5sxp0UhFH0k1P0v7tp1xNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from GV1P250MB1433.EURP250.PROD.OUTLOOK.COM (2603:10a6:150:284::10)
 by AS8P250MB0838.EURP250.PROD.OUTLOOK.COM (2603:10a6:20b:573::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Tue, 7 Oct
 2025 14:07:05 +0000
Received: from GV1P250MB1433.EURP250.PROD.OUTLOOK.COM
 ([fe80::5957:21ce:d025:7747]) by GV1P250MB1433.EURP250.PROD.OUTLOOK.COM
 ([fe80::5957:21ce:d025:7747%3]) with mapi id 15.20.9160.017; Tue, 7 Oct 2025
 14:07:05 +0000
Message-ID:
 <GV1P250MB14333099108FC4461F201AE3E8E0A@GV1P250MB1433.EURP250.PROD.OUTLOOK.COM>
Subject: Re: [RFC PATCH] ath11k: add ath11k_mac_op_flush_sta to properly
 flush pending packets
From: Florian Maurer <f.maurer@outlook.de>
To: Sebastian Gottschall <s.gottschall@dd-wrt.com>, Jeff Johnson
	 <jjohnson@kernel.org>, ath11k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
In-Reply-To: <236b48e6-43c3-4d2e-a864-3ba627101c90@dd-wrt.com>
References:
 <GV1P250MB14333A5BF24623C4753A10E1E8E0A@GV1P250MB1433.EURP250.PROD.OUTLOOK.COM>
	 <236b48e6-43c3-4d2e-a864-3ba627101c90@dd-wrt.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Oct 2025 15:59:16 +0200
User-Agent: Evolution 3.56.1-1 
X-ClientProxiedBy: FR4P281CA0105.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cb::18) To GV1P250MB1433.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:150:284::10)
X-Microsoft-Original-Message-ID:
 <f0bfc816f0683ee594482d0f3b84532f7f6a98b2.camel@outlook.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1P250MB1433:EE_|AS8P250MB0838:EE_
X-MS-Office365-Filtering-Correlation-Id: bf43ed84-8182-4764-df7e-08de05aacb2c
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|6090799003|8060799015|19110799012|461199028|15080799012|23021999003|5072599009|12121999013|4302099013|3412199025|40105399003|440099028|10035399007|1602099012;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aEkvWkRuTFhuK1VMb2VwbkVqV0x1QUtlU0hTM3IyWkZWMTE0ckRMQnNPN3B1?=
 =?utf-8?B?WFU0UFdGbXk2c0VSNDI3UUFYQzlRNGRlOE9MbEVWMVREREt3a0djL3JEYWIr?=
 =?utf-8?B?UUNpUEN6L21NUHhIRWhQcG0vSlVwRmxZY3V5eE9Ic0VyWUhEN01uOE9TbTR0?=
 =?utf-8?B?MnlnN25KMWs3S0h1TlNPbzRQLy9QUDZSYVdBTVpZMHR2NEp5S3dXbzIzZUhs?=
 =?utf-8?B?bEU1cDBWeEZ3U1BEUE0weTZJL09hT01jZ29BU3NZeUMxSmdHSURlZkgyLzZI?=
 =?utf-8?B?Wk04MWNTVk11TndUN29EVUNtYWpEUTA5RkUrSFhSZ2kwM3A5amhHTWdoVkJo?=
 =?utf-8?B?amR1QS9Gc0tvRVJtM0pWcDBTSExsWmVaVmZvb0c0YjFYeC9jclVZa1RxaE5N?=
 =?utf-8?B?enFJL1FKQ1YzU1BXbFlYWDJ2ODR0UmFyVG5meWEvMXVYTUJwZEpLcEtkbG0w?=
 =?utf-8?B?ZkNEcHJSTTBGQldUaitjMlJvY2Z4NkoxN1BRS1NFcDhMNUJRQ3lUMkxRdlN0?=
 =?utf-8?B?MHo5Tk5ja3Z1TzNnSzk5WVhBcVJmeVFyRkhNS3BNbFBLTVpyR1dOYURBd0NO?=
 =?utf-8?B?TkpYRUdoQzlOZlVUYVBEcmJLdWxoeHo4WlVsck8rSFNCelRyS1QzLzlMOG1j?=
 =?utf-8?B?eThTdTFDUEJzK2taQkIrbHhNNXJlZ3FacUJodVVXMXZuc28rRWpMQmxyV0g0?=
 =?utf-8?B?Wktlcm9qNWFDcVpDbnpFOUF2ZjE5WkNENGxCZlcxWE51RVg2VlRRVERhQnRv?=
 =?utf-8?B?Rm4yZzhwNnMxcnpiWHNvNEUzRXFmeG5yNWxtZXh0L3NHQ3BJUVU2RTJXZEFk?=
 =?utf-8?B?M3NRYjFuUEZ6cEZJbzF5dEhJV1BaV0kwR2F6YmFERkNEa2c3YWkrcnhzclpP?=
 =?utf-8?B?YWdvQ0VoVzZ2QnRJRmFzUUxZbis0aDRNeWFPTm4rUGFGZ2JOM0ttTVl3VW85?=
 =?utf-8?B?dHAvMzAvY21nTjNkOGkxM1pkL0dEeGIxbWo2WHVMeG9meHczU045T1ZkMytv?=
 =?utf-8?B?bTJROFR4d01qMmxMSjVpODVNOFZqUWRaUHE4QkhtcUtZL1pCWEFvUXlpaGF6?=
 =?utf-8?B?Y0JzQlB5MjhJUk1VOXBlSHhrYks0YmdvNWRHV01TNXFBUUwzMjM2ZnpYdi9y?=
 =?utf-8?B?TXZoVkhldGpmdnNLV2lhaHR6OGc2Zzk3Y1IzS3NsaTZsSElTbzA5WUo3MUZM?=
 =?utf-8?B?YUVaRWNDU0VQT2dEV0U5Vmk0aDltNXBnTU1oZG55NzJFVGhqaEJGendBMURl?=
 =?utf-8?B?OGozNW5HcDdibURRUExGZWVzakxlT3JxNENSTGlDZm5pRkJKMUhJcjlKUVdo?=
 =?utf-8?B?VzVaOEJPOTZ3SGRNV3FiZVlIdWY5b3UxQm01cGIzdCtkcC9ydEI5aXpvWnM5?=
 =?utf-8?B?L3g5Qy9kSmlSdC9OQjhVNDBrRU0rWjhIcHNRSmZVSm9UcVg0eTFFbkhIdHVo?=
 =?utf-8?B?dWx2S0txUDJKaGt1WlFHMmVFZGNIUkpmQ09RbXRkbW5mK2NWb3dWQitwd2pD?=
 =?utf-8?B?Z0xRaDVEQmt2Qk91WjY2enVsL1JaWlQ2V0drbjA5SVpKUDR5WWlHVnZ2RE82?=
 =?utf-8?B?VXJ3bU1SUEU0d0FoNHJSdndLdmpHTUhkQ1VlM3lQTk56NWFaVkZlME5LUy9k?=
 =?utf-8?B?MWNSSE5jQXEvc3JZWTVnNFBRT2xHUDNQU3RRb2ZCaHpQd04vZU5HQnlDN2li?=
 =?utf-8?B?dUFjTGkyU1dES2gyM0NURE40blpSVXFmZGdoQ0JadW5PMHBLNVBGMUpxYzZm?=
 =?utf-8?B?ZVVYdzNVUC8weWQ4OG1Bd0FmR2VKSlNYMi9nZ3oyK1F5cGFHOFBWeTA3cER3?=
 =?utf-8?B?UkNEeUJlc00xTE50MkErQT09?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SmozREMxQ09Tb2NWVlNDbmNkV3FDZ1hRazBpRDRialB3aWsxTHQ0NzBtbE9J?=
 =?utf-8?B?bmpvbmV3YmY0V0xDYzR2UElobGhJc0lObjFMTUUxdlQrTDBLcWcxVDRFQmpI?=
 =?utf-8?B?NmFHdUFLTjlBOG82UFNFVEEybmhVYkhJVlhEZWNPMk1pcGNaNjJSUVA2SjRo?=
 =?utf-8?B?QnlEYk9rSWlsK1lJaUtEaWZsWFBWbThzOUkzY1FYS1RSa3NuU0pBYW82NGpz?=
 =?utf-8?B?TjV5YWw3bUlMM1gwVURWRE94NTNkeDJUL29KRFRrckZYSUMvck54Sm43NHhL?=
 =?utf-8?B?MFBWaGd3ejYxZE5RQXNkbmJTVnV1U1BEQUtrWjd6R2pYUEwza3B3Qmd5akdE?=
 =?utf-8?B?MEVlc3pMNlJUWS9TRnozTXMwL1k4M2hVcGZpZVlETkQ1V1JpWUVzV1Y2YnV4?=
 =?utf-8?B?Q1F5eUNtU09Eb1dyakZNZ1EweGNSWks4UFowOVEvNVhBSTA0WmxMSE16MlNY?=
 =?utf-8?B?Um4xTTVLQkcycit4cmF2QURBbGc4a2xTVGZ5V1BaU1g1aVIzMDdHaWNSWmNM?=
 =?utf-8?B?Uk9yUzYzQkdNdXRJNjJ0NG92bUJmK0krT2oyYmE5RzJaY0x2WW5hckZhNnBr?=
 =?utf-8?B?SHF6SXlRRzdsaGM4bllZRFJKRFR6ejFEbTZ1MzRGaXp3UmRlS0F6R0pQSExF?=
 =?utf-8?B?dk9VcWhFVDZpdTVmODdTQmJBNk1EUy9Bak5BbjA0NjVianFnSzlaQ0lsbmdS?=
 =?utf-8?B?cXg5TDZvNlJsY1BaeUN4TVhlbW1waTZKTW1ONG1BeXpzcGJIZ3lhV3NTVGpE?=
 =?utf-8?B?U09TZ3oweWtEeVZyREQyait3eC84eHJiQlNLcUpzdFhXalJ6MWcvRXNXVkJK?=
 =?utf-8?B?NWc0dW5sTzlsMTM1MUFZZklqQTVuU0xuOW04eDF6ZG80Z2MyZUk4eEFOZmRC?=
 =?utf-8?B?NG1Tdit1RGxLZGMrTkluN3JrM0lGNWk4eTczSmJDVnoyTHE5RTJaTkNoeEh2?=
 =?utf-8?B?K3JnNHZEK3p6UFFlT0VLZWQ5bm1DTG95c3E3Z0JBR0VvRGVKOTNwc3pENGxk?=
 =?utf-8?B?eVFsSWN5UVBSWHJxV3FGa1FVN01mWXQrUXhZRFZ2dTNUZ2RiMklTRDUrajd3?=
 =?utf-8?B?UHkvbmY5Vlo0Vm5FVjg3SG95YnIycklUb3dCd2NiRm5rTVZSWm13SG5CTlI3?=
 =?utf-8?B?UnVyamNyNGZPaUdBeUxlZXNFSXc2Q0YvUU5iSzBwRFE2bTRCZ2JYU3dYQ3hv?=
 =?utf-8?B?YmxYMllVTHpJMjlwYWtpNDVFK2c3aVRBQXN2OWpWczdKbHptcS8wc005ZFdN?=
 =?utf-8?B?OVEvM01KYVFsbW14UDRGbmJwSDVNSklFYlZnVHZDN0VFU1d1SEcraFVKYzNm?=
 =?utf-8?B?bUZjWmZyYU9rbGZqYTVJOHArOXpqb2JUREdieUZOUmpQYWVoMDNDUjZVcVc3?=
 =?utf-8?B?SGsvS1B0bm9nRTFPMDJtU3V0aHhLbEw4Um9RUEZzYnV2RHZRT1RXRGI3eXBz?=
 =?utf-8?B?dXM5dXJLTzU0TFh3eHdDZ1FibktkcHl4QzM1aTI1MUJ4eWU5VG5mZ2MycW0z?=
 =?utf-8?B?cU1wSW5qS1B6bXNqd2Y1UnNtVTdyWDV1bm1sa2tVRG5nQzlnSW5UcTNpbkJs?=
 =?utf-8?B?cE41Y2xqZkN3Yk9ST1NsZU11MVhHRkJtOWRRMXVDREtoWmljTWprM2laRGRH?=
 =?utf-8?Q?DIMUWV/twumJOXWwqHWxRhVzPWUf/rCq81m1zbVTkNnY=3D?=
X-OriginatorOrg: sct-15-20-8534-15-msonline-outlook-5f066.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: bf43ed84-8182-4764-df7e-08de05aacb2c
X-MS-Exchange-CrossTenant-AuthSource: GV1P250MB1433.EURP250.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2025 14:07:04.9943
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8P250MB0838

On Tue, 2025-10-07 at 14:38 +0200, Sebastian Gottschall wrote:
> Am 07.10.2025 um 10:11 schrieb Florian Maurer:
>=20
> > When a STA is marked as no longer authorized, if the driver doesn't
> > implement flush_sta(), mac80211 calls ieee80211_flush_queues() to
> > flush hardware queues to avoid sending unencrypted frames.
> >=20
> > This has became a problem for ath11k because ieee80211_flush_queues()
> > will stop all traffic and call ath11k_flush, which waits until the
> > whole HW queue is empty. In a busy environment this will trigger a
> > timeout warning and stalls other STAs.
> >=20
> > Fix this by implementing flush_sta method using WMI command to flush
> > frames of a specific STA.
> > Flushed frames will be marked as discard in tx complete indication.
> >=20
> > warning print "ath11k c000000.wifi: failed to flush transmit queue 0"
> > was observed on various openwrt devices, and is fixed through this patc=
h.
> >=20
> > Signed-off-by: Florian Maurer <f.maurer@outlook.de>
> > Tested-by: Florian Maurer  <f.maurer@outlook.de>
> > Co-authored-by: Benjamin Berg <benjamin@sipsolutions.net>
> > Tested-by: Flole <flole@flole.de>
> > ---
> > We tested this patch and it solved the problem of flushing the transmit
> > queues taking too long when the AP is busy.
> > We did not confirm if this flush is implemented to guarantee that no
> > unencrypted frames are sent out on station removal.
> > Could someone with more knowledge about the firmware behavior check
> > wether this approach is feasible or if a different approach should be
> > taken.
> > It is not clear to me if the approach taken in "wifi: ath10k: Flush
> > only requested txq in ath10k_flush()" might be better.
> > https://lore.kernel.org/linux-wireless/01d859e8e574a1f5d0b916333fe0b5cd=
a859af9b.1732293922.git.repk@triplefau.lt/
> >=20
> > Regards
> > Florian
> >=20
> >   drivers/net/wireless/ath/ath11k/mac.c | 19 +++++++++++++++++++
> >   1 file changed, 19 insertions(+)
> >=20
> > diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wirele=
ss/ath/ath11k/mac.c
> > index 106e2530b64e..a94649edd4ed 100644
> > --- a/drivers/net/wireless/ath/ath11k/mac.c
> > +++ b/drivers/net/wireless/ath/ath11k/mac.c
> > @@ -8330,6 +8330,24 @@ static void ath11k_mac_op_flush(struct ieee80211=
_hw *hw, struct ieee80211_vif *v
> >   	ath11k_mac_flush_tx_complete(ar);
> >   }
> >  =20
> > +static void ath11k_mac_op_flush_sta(struct ieee80211_hw *hw,
> > +							struct ieee80211_vif *vif,
> > +			    			struct ieee80211_sta *sta)
> > +{
> > +	struct ath11k_vif *arvif =3D (void *)vif->drv_priv;
> > +	struct ath11k *ar =3D hw->priv;
> > +	struct peer_flush_params params =3D {
> > +		.peer_tid_bitmap =3D 0xFF,
> > +		.vdev_id =3D arvif->vdev_id,
> > +	};
> > +	int ret =3D 0;
> > +
> > +	ret =3D ath11k_wmi_send_peer_flush_tids_cmd(ar, sta->addr, &params);
> > +	if (ret)
> > +		ath11k_warn(ar->ab, "failed to flush sta (sta %pM)\n",
> > +			    sta->addr);
> > +}
> > +
> >   static bool
> >   ath11k_mac_has_single_legacy_rate(struct ath11k *ar,
> >   				  enum nl80211_band band,
> > @@ -9920,6 +9938,7 @@ static const struct ieee80211_ops ath11k_ops =3D =
{
> >   	.set_bitrate_mask		=3D ath11k_mac_op_set_bitrate_mask,
> >   	.get_survey			=3D ath11k_mac_op_get_survey,
> >   	.flush				=3D ath11k_mac_op_flush,
> > +	.flush_sta			=3D ath11k_mac_op_flush_sta,
> >   	.sta_statistics			=3D ath11k_mac_op_sta_statistics,
> >   	CFG80211_TESTMODE_CMD(ath11k_tm_cmd)
> >  =20
> why is peer_tid_bitmap 0xff instead of 0xffffffff?
When setting it to 0xffffffff it fails with:
Assertion !CHK_TID_FLG(ptid, WAL_TID_IN_SCHEDQ) failedparam0 :zero,
param1 :zero, param2 :zero.
leading to a device reboot. See:
https://github.com/openwrt/openwrt/pull/20293#issuecomment-3367037471
It works with 0xffff though, but I don't quite know what the firmware
does/expects here. Maybe someone with more information can help.

