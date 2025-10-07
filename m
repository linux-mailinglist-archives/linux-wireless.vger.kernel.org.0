Return-Path: <linux-wireless+bounces-27849-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ABCDBC08F5
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Oct 2025 10:11:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6FADF4E05B9
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Oct 2025 08:11:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0071257858;
	Tue,  7 Oct 2025 08:11:22 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazolkn19011025.outbound.protection.outlook.com [52.103.39.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F10EC2550AF
	for <linux-wireless@vger.kernel.org>; Tue,  7 Oct 2025 08:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.39.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759824682; cv=fail; b=C02S4PYPrFQO1sSGLov8Dle1OQ9bGcow2ff+4udXaTru77QbJfFBuSXaizARjhLVFGLq28AHcB2jGCrg2eaOkx0Gr7vW8nHKjJ7w9GIFV5uojeijh05knCPXhTnStIPfFV4j9frkol9H/omPu8a4Ad8oxqyCta2eXMLHvwn667Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759824682; c=relaxed/simple;
	bh=4q2/r5h04+/j4ChWX41fEJSiGmGRHW2rflqRcu7svCE=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=FUaPPIj1mlBo9Ggz/WuX7eVoAH2cWCHViMhffeUcqkZqVsRU8KQCfok89RM2HGMuhO+1d2QM7GWeXvcHYQ7roqRWFJ7y0QUl4TmKErclSUhIoT9gdr8Lllap4EDsbERF9pI3c5EAstT+K3Y+HTigzNvj2USfnND/LwCENpIpSY0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=outlook.de; spf=pass smtp.mailfrom=outlook.de; arc=fail smtp.client-ip=52.103.39.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=outlook.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ntE7rj7j1sogx0xprzepLth1nngWVsi4ssyIH6mIpLkoFqbL1YyJTnYv2hALepStdjWhO2gtDi1gR5gSwNAqnSP0gZfOXbOj0Mp2BGIc7srG6DYKyvJYF8vIzpRAWup3owpkTaZiWljZwN4dRfWPuwRQeK4sOn4a0aoF+rac6E3IgHTZ15SUcjODCM+9yWC1gPmGjXNvx6OV/kNwZuwtmSTETVa3sMioSWk1EoL2zIWailsXze+AkEs0yNS9LYCdWgS6x+zMmCHQETSoQysb9HoN7y9X3kWcASknm7+TQ7ph9CxUViVlioAQvsS+fWn9VYsuwcS4SJ1mZn9IhsH//A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aX+Sa+g3JxYQdmRZvAEhVm9iZwqXmPV/pvfdfF3SINY=;
 b=hZWvmYpgJG9UJ2pS4YCdJ/ElC4SawgAacLK2QOY5flCuoDpEI/sd7Gln5R/pZUGw3IAygMIPbWmL5Q3J6F6raDd3PXo2j8L58f4qhbDy9SmCsOlHjBsJlDKjNcBG91EAw/ZMJqtAK0Sid/kSs5CiUpFFaT1B0isXoVXlHx7ttxTQQquroIOCqGoAsnkKnVdfdoLaFT+uInviAduhI+tGPec6wWpvtLDiYHZIH3evil1jTK1JK5cvb1b1xEfF9IiMsAh7CqirG6dnqF/vs3GtJuEYgisQP+0t5Oq8sdD3mXn8tMa3Y2dm9vRZnk4hy5PitWWH9AASvxb7h2FrRpgrfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from GV1P250MB1433.EURP250.PROD.OUTLOOK.COM (2603:10a6:150:284::10)
 by AS8P250MB0007.EURP250.PROD.OUTLOOK.COM (2603:10a6:20b:35a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Tue, 7 Oct
 2025 08:11:18 +0000
Received: from GV1P250MB1433.EURP250.PROD.OUTLOOK.COM
 ([fe80::5957:21ce:d025:7747]) by GV1P250MB1433.EURP250.PROD.OUTLOOK.COM
 ([fe80::5957:21ce:d025:7747%3]) with mapi id 15.20.9160.017; Tue, 7 Oct 2025
 08:11:18 +0000
Message-ID:
 <GV1P250MB14333A5BF24623C4753A10E1E8E0A@GV1P250MB1433.EURP250.PROD.OUTLOOK.COM>
Subject: [RFC PATCH] ath11k: add ath11k_mac_op_flush_sta to properly flush
 pending packets
From: Florian Maurer <f.maurer@outlook.de>
To: Jeff Johnson <jjohnson@kernel.org>, ath11k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
Date: Tue, 07 Oct 2025 10:11:16 +0200
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1-1 
X-ClientProxiedBy: FR4P281CA0260.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e8::7) To GV1P250MB1433.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:150:284::10)
X-Microsoft-Original-Message-ID:
 <3851002fc48cd95f674710c7535ced7826ffcdec.camel@outlook.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1P250MB1433:EE_|AS8P250MB0007:EE_
X-MS-Office365-Filtering-Correlation-Id: c0935b36-55b9-41fa-81d8-08de057917ab
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|19110799012|15080799012|23021999003|8060799015|12121999013|5062599005|5072599009|6090799003|461199028|1602099012|39105399003|40105399003|4302099013|3412199025|440099028|51005399003|10035399007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eDZRc0tFNEg5RG1VMm52N0lmalpkWnlyN0dCc0lud01KNjhSRUdlQ1lOeFd1?=
 =?utf-8?B?Rys0N3gvR2xwSUx1bWRTdG5iMHVzU0RyT0VFRElPZ2dDR1VXNGY2WkZBNjRM?=
 =?utf-8?B?WkJyU3B1dVkrMXNrQW1oZGNyV09tMEo5N2JLQmFiZjBYUjNEdEgveXo0U0Zn?=
 =?utf-8?B?RGdaR2d0WGlmQTlsNS9HVkN2a21WL3hjWUNic0VySlQxbEdKamttWkdjeGFk?=
 =?utf-8?B?MWVza0RyaC9aY204dysrTmY0dWt2RlE4OHFCQUxtNWdnTFIvTERCT0VsZW1p?=
 =?utf-8?B?bU41TGhxY01ZTVYwNVFqWEtXTTdyd1V3aGlvL2FjWVJHcnhYdXNLaG5JTk1S?=
 =?utf-8?B?cTlmZUpWZTJoZFhYZGJCR0YweFd0VHhqcEt1K1Jiem4xdTFENENHNm9pZW5t?=
 =?utf-8?B?TUdicHFWQ1Y1RU9jTFJaQ21oMlFHRGFpMUhKak45dVNKSnNhL05KdEdJdUpn?=
 =?utf-8?B?NHJRUTF0M3RjRWd2RWRCMFA4MTZyeDMzODljNW9TcGJ4YmJ6L2QycUFBSENU?=
 =?utf-8?B?aTdZSWhxZjJsdXhkbW5RNGxJRlpkZ2I4Mlk2UVBPSG45Sm54OWlsTFJlWmxD?=
 =?utf-8?B?cDN6Y09kWFF5cm8wWlBUd2FvdnpaM3hjME1XNWVwVytVVlVDKzZMWVA2MThq?=
 =?utf-8?B?M2ZMY2liOXphZDdoeWVDSUE0MnltTWttZkdoNmg2WXhRTXd1dDJqVnVsaDY5?=
 =?utf-8?B?S1o1RndTU0VoTS9CMXpsUnpDQmVHKzB4L2ZTSEJwcHJtUEhTTHluQVNrZEZh?=
 =?utf-8?B?NHRqaEFDSDduU09YdkNhczdVZHdrZ1JnL1AxZVVYV2g5cEhpOVhrL0o5alZR?=
 =?utf-8?B?cERjeUhJN3hZb0lSMDNYQlBRbmJydVRMV1MvemIvYXFYMndHZm1aYjFLMGtF?=
 =?utf-8?B?dEVZb3ZHWk1YcXd6cnZyUTI5MS9SbmoyR0dVRjNHYW45bXZ6S2FqR3pLOWZ6?=
 =?utf-8?B?Q2txTE95c0RDQmtITHl1S3hxUDVuSkVCanNRVDFJSHdaMEt6bHpYeFVoT2Zu?=
 =?utf-8?B?RFUwaCtvVzNTUkZ4L2FFSi9tcmZHeFRGNkFRejBSY003eVpDM3ltSkRNQ2NC?=
 =?utf-8?B?dmZ4eERmeU5mNk9NcXJUaVRsa1RITzRTMVY3RTI3T1VmU3RtSnprMTJ3dng4?=
 =?utf-8?B?R0l6ZXVDVFExN2Z5OTNhckRVK3RpUU1GYWlvS0tmVFBmWDNHU2hEZnBLUVZG?=
 =?utf-8?B?TWVTSGRhbnNVL3pIYnFVb0JHbXp2TEhKVXZ1OUs0Q0l6TFgvYk1hb1hJTkZL?=
 =?utf-8?B?b1dxY1dRelZEcks0Umg2L2JYZytyc0F5NHc0WGhVd1ZTWHRIYUNIVDVwaVlq?=
 =?utf-8?B?eFI3cHpveVZaMEN0VFdmTFZGOEVvdFhOTUJiNUNFZXN3QnNRYzZ5MFA5ZE5D?=
 =?utf-8?B?UDV1blMreExCTm5EeEpWTDFWYkRGWmFRbVRlOFpYSXEzUHA1TDA1WVEwSVVp?=
 =?utf-8?B?ejRzdHk5UW5xZXIwNkhyTEpFSnMzeVBUb002cGZKRW5ONzFLeVF1UnIzZlZq?=
 =?utf-8?B?ZEtsOERIbTA3WUpJY25meFdrd2tIMzBKa2s4cVNHYStTQ290cW5tSGszMitI?=
 =?utf-8?B?Sk0yWnZkZUxTdVJrYlBBZkV6N01MRmJNRnpwQ3cyY1VRL0VTS2hPaDFrTnVH?=
 =?utf-8?B?UHBING16ZzFET3phZGcxa2pzM2JFZ2YyN3lXWlhNMHpPckFzZTArL2Z3bHFC?=
 =?utf-8?B?SGtISjVCdm5MYUR3N1hZYm9YeTFDNFdGemNHNEs0YXRSNjlLalRWZXJaRm83?=
 =?utf-8?B?RDdabVpjUUphYXdackl2ejk2NEN1ZE1vZlE3ajFvTG8yV2lUVnVEREkwWmpG?=
 =?utf-8?B?SkQ3YnZ1RGQ0RDgyVm1Qb0oycTdYZmRBeUFBYTYvR00vLzh3aFdmZ21PRG5Z?=
 =?utf-8?B?QmRKYTFaSlpkUWFTYUJ3NUJFdzZZcm04WWo5LzdoajFDUFU3eXFjSHRmMGQ3?=
 =?utf-8?Q?N8jLHxsl7Gi4QDZmhE5F2/OKvUlN59SK?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QWRXdVlzanpnRXJYMzRlK1F2b1k3bVFCdWVHcEtsUHVYSU5lekdPV0FmRXlY?=
 =?utf-8?B?Yk1SS3pRamxRYjEvdHltMDRUS0xRZVl4ZmRZVm5zeldya0o0SFJkUXYxY0c4?=
 =?utf-8?B?Q1o3bVVRMFlIdkNpTUtRY2l6dmEzelM1ckFnSFhXZ1oydGRaWXlvdE5SSDdE?=
 =?utf-8?B?Z0FKVWt4S2pJMTMxSFVjWjdVcnhJclpWZkhZNHAySG5IM2RxdVU3TTNMWWJB?=
 =?utf-8?B?QVJpWlFJTHpmbUdBSVFLYzdnL2lSVzZxNzQxSkl2TkxyMFpWYVlYRlFGbFFZ?=
 =?utf-8?B?bmlENExEbm5MQjJNMEtOVW8yQ0hCZC9HK1V4dzdXME1CbElsZkxTa25RbjNl?=
 =?utf-8?B?NlhwZU5RWXVlcDdHVWhpVEdEdXJ4RlZ3QWhySnp1L1ZCZlRxNTdFR251cGVr?=
 =?utf-8?B?bzVmM0dJeUtWMXBKVU4zN21OQVcrM0krQzI1UDFqSm5rd3NBWm9qNzdRWUJ6?=
 =?utf-8?B?cTl6TFBlWFVwYk5ZQndrN1BTNGJ4V3VlN1JEVVVoTnJXV2tSVW93NzVBU203?=
 =?utf-8?B?a2Q4Z091ek1EdGVVYWNZVVl1MzVjY3ArMGtXbEQ0TU05S3NBTnF0RGJiQzNB?=
 =?utf-8?B?b1JOV0xzdFp1S2V3Y09QU1YyeTVaVGxrMVJYRElhWStFcE1VUFZuSlBnNjFx?=
 =?utf-8?B?ZE5EZzZ1NHRWVTdXeC9Fbnp2cURIV2NCOTZ4TS9EektUUEFMWTdHMHhXRHZL?=
 =?utf-8?B?aURnZ0wvZ2lKZUtBVytvRUZiRlR3TnNjMU1BeU80TVhVc0Z5czZhLzQyT205?=
 =?utf-8?B?a2FsTnJqZlFkRHRCV21ZeldPblMyemVPQXBJL2M4RFRTRjJLZGhiUmI3OU1N?=
 =?utf-8?B?ZFZFbnVuY1o5R2VnMXEyUWUxVUhVQWRRSGFZY2VQdk8zMzJjaTRRNFEzTDFK?=
 =?utf-8?B?eGtvYmZVOTh5WTJGQWVqZzBzaUVKTHc2LzB2NHZQL1Z1ZkNJTDkvV2RBL0RM?=
 =?utf-8?B?eFZGeHFNdFdjTWhqZVJnQURmSzVpbGE1c1BaMENJVHFPQkpCTHVhcXBnaVFX?=
 =?utf-8?B?SHFJemhRNE55ZFkyNndpTVZObHdGUDBBM010OHZIay9Ja1RPZFBsVW53THZr?=
 =?utf-8?B?azZ6L09YTFZvYmZGaDlLWisyWldxREVFbzd3ZkJPSlltQ2NCU3REOXJSYUdR?=
 =?utf-8?B?SVZoMWJDUm1aV0RhY0M0S016VndtT0VITTNEbSt2dkliVm56VDZzb0ZTVDll?=
 =?utf-8?B?QmVqUHY5UVNJazJ4MXliR3FTTmd1V1NBRDZxTUNndGV3Tlo0ZXFBcWhxMDRm?=
 =?utf-8?B?eEQ2eGdxSm5DN1RlY2hwUkh0aWcvYnZVVTFBUFMzam1nUysveVFISzh0NnQy?=
 =?utf-8?B?ZEQwZTdxZm5CcTgweUZ3Zyt0amZHazlPVDJrZm1LKzd5TmZZRzJaSncvemJG?=
 =?utf-8?B?Z0JJTlRtZHpnMmFWaEVybmxlNEhRT1lXZFFpbHk1dTY0cEsrWlpJUWtFWDNw?=
 =?utf-8?B?Q0hqTXRIRkxwQUQ5OFF5R3U5dHl0WS9VYWU5emJVckQ0d2E1a085V0dCM3lG?=
 =?utf-8?B?ZUFBdzBQakJrZGh1Q2t6T1FUVEJQWUZzSTMvbnA4dTZFNC9jdVFPYVZjQlNq?=
 =?utf-8?B?RGVQRDczRXhuQktDdnlMZXlvcmNLcS9qam1wdzg0SWlIMnBhL1dRY0U5V3Bx?=
 =?utf-8?B?QXNzVXduQlNqQm9LNmpFK0lCWGFJSDJrUHEwS3pzUFUzRFpaVU9EL2N0N3No?=
 =?utf-8?Q?AqS+m+htsPB93YT8PAdS?=
X-OriginatorOrg: sct-15-20-8534-15-msonline-outlook-5f066.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: c0935b36-55b9-41fa-81d8-08de057917ab
X-MS-Exchange-CrossTenant-AuthSource: GV1P250MB1433.EURP250.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2025 08:11:18.3122
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8P250MB0007

When a STA is marked as no longer authorized, if the driver doesn't
implement flush_sta(), mac80211 calls ieee80211_flush_queues() to
flush hardware queues to avoid sending unencrypted frames.

This has became a problem for ath11k because ieee80211_flush_queues()
will stop all traffic and call ath11k_flush, which waits until the
whole HW queue is empty. In a busy environment this will trigger a
timeout warning and stalls other STAs.

Fix this by implementing flush_sta method using WMI command to flush
frames of a specific STA.
Flushed frames will be marked as discard in tx complete indication.

warning print "ath11k c000000.wifi: failed to flush transmit queue 0"
was observed on various openwrt devices, and is fixed through this patch.

Signed-off-by: Florian Maurer <f.maurer@outlook.de>
Tested-by: Florian Maurer  <f.maurer@outlook.de>
Co-authored-by: Benjamin Berg <benjamin@sipsolutions.net>
Tested-by: Flole <flole@flole.de>
---
We tested this patch and it solved the problem of flushing the transmit
queues taking too long when the AP is busy.
We did not confirm if this flush is implemented to guarantee that no
unencrypted frames are sent out on station removal.
Could someone with more knowledge about the firmware behavior check
wether this approach is feasible or if a different approach should be
taken.
It is not clear to me if the approach taken in "wifi: ath10k: Flush
only requested txq in ath10k_flush()" might be better.
https://lore.kernel.org/linux-wireless/01d859e8e574a1f5d0b916333fe0b5cda859=
af9b.1732293922.git.repk@triplefau.lt/

Regards
Florian

 drivers/net/wireless/ath/ath11k/mac.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/a=
th/ath11k/mac.c
index 106e2530b64e..a94649edd4ed 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -8330,6 +8330,24 @@ static void ath11k_mac_op_flush(struct ieee80211_hw =
*hw, struct ieee80211_vif *v
 	ath11k_mac_flush_tx_complete(ar);
 }
=20
+static void ath11k_mac_op_flush_sta(struct ieee80211_hw *hw,
+							struct ieee80211_vif *vif,
+			    			struct ieee80211_sta *sta)
+{
+	struct ath11k_vif *arvif =3D (void *)vif->drv_priv;
+	struct ath11k *ar =3D hw->priv;
+	struct peer_flush_params params =3D {
+		.peer_tid_bitmap =3D 0xFF,
+		.vdev_id =3D arvif->vdev_id,
+	};
+	int ret =3D 0;
+
+	ret =3D ath11k_wmi_send_peer_flush_tids_cmd(ar, sta->addr, &params);
+	if (ret)
+		ath11k_warn(ar->ab, "failed to flush sta (sta %pM)\n",
+			    sta->addr);
+}
+
 static bool
 ath11k_mac_has_single_legacy_rate(struct ath11k *ar,
 				  enum nl80211_band band,
@@ -9920,6 +9938,7 @@ static const struct ieee80211_ops ath11k_ops =3D {
 	.set_bitrate_mask		=3D ath11k_mac_op_set_bitrate_mask,
 	.get_survey			=3D ath11k_mac_op_get_survey,
 	.flush				=3D ath11k_mac_op_flush,
+	.flush_sta			=3D ath11k_mac_op_flush_sta,
 	.sta_statistics			=3D ath11k_mac_op_sta_statistics,
 	CFG80211_TESTMODE_CMD(ath11k_tm_cmd)
=20
--=20
2.47.3


