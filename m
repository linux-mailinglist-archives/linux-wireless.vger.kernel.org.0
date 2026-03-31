Return-Path: <linux-wireless+bounces-34232-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CCK/IGMbzGnHPgYAu9opvQ
	(envelope-from <linux-wireless+bounces-34232-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 31 Mar 2026 21:07:15 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D6A13705CB
	for <lists+linux-wireless@lfdr.de>; Tue, 31 Mar 2026 21:07:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7614330782BE
	for <lists+linux-wireless@lfdr.de>; Tue, 31 Mar 2026 19:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ED41223DE9;
	Tue, 31 Mar 2026 19:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=HOTMAIL.DE header.i=@HOTMAIL.DE header.b="thUvctqV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from MM0P280CU009.outbound.protection.outlook.com (mail-swedensouthazolkn19011034.outbound.protection.outlook.com [52.103.34.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E631F38CFE7
	for <linux-wireless@vger.kernel.org>; Tue, 31 Mar 2026 19:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.34.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774983986; cv=fail; b=uMpefEPXRoHn7lv7JvnZpAdK4Zi7FIvJeh5aHLuuWevJ7XDGfSc+/xQDpHDdry25ycyw+mZ+ZrOpZanQMz8GeRKDNdmpw1VgGkTrMpZqbS5Ygbvw4dLKpIEMQFWsqyWgRfOPceYqFXp/pnmr/m2Er0FD5Bcb+eJpaf2QEfPZXcQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774983986; c=relaxed/simple;
	bh=OUe7rdY/Nvm2cLGfFeBfrcgHVIEiAkqC84wzO45OiZc=;
	h=Date:Message-ID:From:To:CC:Subject:In-Reply-To:References:
	 Content-Type:MIME-Version; b=T2pk5GuY5IRLPEOXCJ+u4A5lFxi/RszQsLUFQOHveBdDV/HwFxVwLek2oS/oic3e4SQLmym26CIPnzRlUluEl/bNyv/Xi4n8OP4QKjXF+qChjee7yD8ScQoIA0es0lF28UE8oZeqklix4daid1QlnqyBAcLAqyi4zCHBqi0GC6Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.de; spf=pass smtp.mailfrom=hotmail.de; dkim=pass (2048-bit key) header.d=HOTMAIL.DE header.i=@HOTMAIL.DE header.b=thUvctqV; arc=fail smtp.client-ip=52.103.34.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rm9DwAryQiKVKZ9tShEshVv794oWgQOflz8HSE3yhQaWRr98vFSJIadMj9k4Cepu6e1AMU78RQM/WKgAwyVDZc9QFU97O1NfdT481EwPyOQh7M8keNo8wKVAADY3B0p/N6+wOu6pDp6gLo1ELPA4H0/qJqK229W7kOD3g4ShCa/AHkmFFDDn+ATz7YYhVFxXEW0KamAU9wkmzQ0tQcAqAQezaqriLOJCXpk5yjvqnkCbiykINQpJJGyJfqdirwhb3/Qn/YZgHCEhMb7a7LJmnH79YifRttET6B2GrjHnjCtDDQnC4esmO2opQ2KebV4uDx24y347E3soslFTmogrig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MtVpiZkvtkS9hjCPxVefSCZAtKaRwizNZnX7gs8CKi0=;
 b=ygNfr/KUwv9BmPw10jY4z/FLL/pgK2+8V07O3B5l0Ic+tGeGUlKW3eX1GkPwz9RfNnnmSwfQ+UugCR/c8/0q/L5dDot1RF73M7ugunpARMEGEuNFLudZ9w2asMI6CqsDRANZQx5dEmAMimjxje1/u6shRVjZ6PJo9ovTu2qoMIRUzlUY+phaEAPnbMfNldmJxDiw0/qw3hOEF77LYDc+AtGpJsbBZnyqoIUA4BNqrEKX1uGO8DZusojzm197RLC95lKv/zMCUVR49OW6i+QKsgEE05c2KZlCIHudTKOqy3woqJvdJX7JvM+5aLjoXf83AaJSxGcS6joeVzGMZ0P9LA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=HOTMAIL.DE;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MtVpiZkvtkS9hjCPxVefSCZAtKaRwizNZnX7gs8CKi0=;
 b=thUvctqVQgOlmAuRSWMXxDLvXaubR7Fc3SADEFNG+543Vr0o2bObGQwekawRO9RHLtLRljJw9QR5w1hOl2dCxhi0rggGUyUQkh/I5cXSBZCaFdib4aX/jepc7QxU9ZlZ6qu0665sZnb8Bb4ptDRi0zzvb4LzSqgx1LeCdxTod1ztx562Bx7rQ+7L/AkUbSNiY4E5DtY1kdFzv6LYEfn49JiDBOMwP4JwWqPeO5ofdVQkjNNypmFfH7LG9yFXNWU3djBG6OZbe7W63xKtrYDe5v9HDW4w2+rasG1jbCcNZHyh6yuZMNZTj/2/qN86oVQTD+fhwW0M9jDSY65vdJcv3w==
Received: from GVYP280MB1518.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:19b::9)
 by GV5P280MB2028.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:376::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Tue, 31 Mar
 2026 19:06:23 +0000
Received: from GVYP280MB1518.SWEP280.PROD.OUTLOOK.COM
 ([fe80::6328:bea5:c218:593f]) by GVYP280MB1518.SWEP280.PROD.OUTLOOK.COM
 ([fe80::6328:bea5:c218:593f%4]) with mapi id 15.20.9723.018; Tue, 31 Mar 2026
 19:06:23 +0000
Date: Tue, 31 Mar 2026 21:06:21 +0200
Message-ID:
 <GVYP280MB15188BDB9B5557B0D4931BA89453A@GVYP280MB1518.SWEP280.PROD.OUTLOOK.COM>
From: Masi Osmani <mas-i@hotmail.de>
To: Christian Lamparter <chunkeey@gmail.com>
CC: linux-wireless@vger.kernel.org, ath9k-devel@qca.qualcomm.com
Subject: Re: [PATCH 04/10] carl9170: rx: wire up dropped frame counter
In-Reply-To: <ad72370b-b5ea-4cc5-98b0-701ffbe15290@gmail.com>
References: <AM7PPF5613FA0B6AC8119FB64246940D3899444A@AM7PPF5613FA0B6.EURP251.PROD.OUTLOOK.COM> <ad72370b-b5ea-4cc5-98b0-701ffbe15290@gmail.com>
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0434.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d1::7) To GVYP280MB1518.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:19b::9)
X-Microsoft-Original-Message-ID: <2c4694f90cd14ac7f35a6160749b7356@hotmail.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVYP280MB1518:EE_|GV5P280MB2028:EE_
X-MS-Office365-Filtering-Correlation-Id: 0211a61d-97dd-47e5-6f42-08de8f589987
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|15080799012|5072599009|23021999003|461199028|41001999006|8060799015|19110799012|51005399006|440099028|3412199025|26121999003|40105399003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JY3mn5hFHmQFPLK3tsVvJQPAGbel0uIkyejXCAUp+Jd2x3X2UKPpjYQt6Lvm?=
 =?us-ascii?Q?5IdCmwwerEnCQkGWIYtGmNOZMF2WNtYSm3zmaNd3vsvgVHQQiUzxdJHq1T1B?=
 =?us-ascii?Q?fkjhR1oFw4Ne4IdjsTSHEF2wmocXyjLD1LlDV4GYCISihFyrjLUN2SCKaQmU?=
 =?us-ascii?Q?r61cmu5RPoqcUWBvj8spWHoV0wmBkqWB5DHQUlFTN6zY/HvACzLcDzeRXSQb?=
 =?us-ascii?Q?Blkpx2B9r9ZJg1iEL+vB1HhUzq0RUXbv3a2YOHn/vRsH1DVxg+1WvbdWAqZy?=
 =?us-ascii?Q?NNviLgdK14lCb4tyW1Z8ZpgIrA2B0nwZf+BChnbEHCiskDD6BEGZ2CXNJIVc?=
 =?us-ascii?Q?Muo7kDtzcwoTbBBWz1pokVjdgORbNu3ID+iOpAiEkslsr5RFSEWe2wTxL/is?=
 =?us-ascii?Q?feCJhuMLMWmArp7VWV+7Fo8TJNWEOkeI8U5d/7SduwhcK++4264WAvhFmEC+?=
 =?us-ascii?Q?gUpW8dxTLnK7LT0tOynfYNNVfP/3mAVqMEf2p0Ysx4xPXKn/Zb587pY7tAxn?=
 =?us-ascii?Q?19/whPhPi1VDBI6H0WhD6nlfqA0IrjoZPe+BpFAiN9/ovgnu7p518nH1YZpL?=
 =?us-ascii?Q?K7UwkDL6lKtdiicOjPEJTjdLvc0OTnL85eoS3zgnDDVl8W6deJ7VDsUqTWIO?=
 =?us-ascii?Q?Ve+MaNESjWN6X1ncTvcOo3g8NABcUZJ51yMzQy//Gn8tnexX0/Q7PNdmkZb/?=
 =?us-ascii?Q?YRYdipmHGKvh13GNf27GWgYmNt4yV40yzDMXXBKwIn2G5JJolD5o88R8jw8E?=
 =?us-ascii?Q?e4YmozCUeHpO9W7OAPI9yRvBqFV1MoOE3kB5bMkLt+oCDmCwej+1A0hUS/1d?=
 =?us-ascii?Q?ZagPePGXY3K2+fD0kWOikQbPYcivvzy5X1Quh6QS4u0FPhv0XAduF1xMVZ+g?=
 =?us-ascii?Q?5DbcaoSdB3dPUKQ6TVnNsom/d70dS/z7cU6RYQs0EFVH4UO+qn1Qv5H4Kopf?=
 =?us-ascii?Q?Vb/pSqR522psLjoupfOhq2r17UWyufmJ1adJ4PCGUZY=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ioSM+EN6/ECKdE4roGsuKO4WfOeB3Q3bdFiygd5GDhnIy4OvMLKQyd+2GDCz?=
 =?us-ascii?Q?fLHYzcYmIzKLnHRpaLI3ProHSYmPfMZCm6FAdmv2RFFdxNeRptoq5ejQ3meP?=
 =?us-ascii?Q?Tm+VxFz3/KlVgfVgtzbjpgWYQVpBJ5zY7ca8kUNW/1ZRXE2ewiI+xEpW6ADP?=
 =?us-ascii?Q?FwAnn3Jrpeu5z21whhJLG9M60BA2zNXtHh77O6sp95WXVEoguwZKq+yEgV+v?=
 =?us-ascii?Q?cg4asp3eo1D2v1OteFp5iQq7mFlnySA413utW2hi5LqCiuKgOQy6gHViwwpt?=
 =?us-ascii?Q?LKb9dbvSBkybw9/ySRBc4dtK0dDxocKQgrnmOwyrztDcN8MWKs7AT/Z34x+Z?=
 =?us-ascii?Q?XpQ8qcQMnXeR0BC/4vpw0mnU7P0XZs+5zlEKPueRLwvY3bbZVog1LLb0Zzl6?=
 =?us-ascii?Q?s7sAO5exoD+Lu8vomoL7/crTNkhwkpK7SxavsJ7LJnYuLdjRhZu69lToUU9q?=
 =?us-ascii?Q?UkoAFc7Pv4pJm7cFVT//z3awcRgQNayO4Z9nPWKs+A5B3yQFFOODmL6FZWKU?=
 =?us-ascii?Q?gRhceEQ6jG9ug82PXBD1hDSC1BWPG6kN0dT6ZyDH06KG9yT6gSYwJbun8nr2?=
 =?us-ascii?Q?3VATVSO/xAn+p3dewK8Pqsy/UY+3N7LuvP1TmlW/4tjk+Su+8CqAU5z6btyO?=
 =?us-ascii?Q?qNMMVkO1TQar4O8muZUfBEky0rHTPXNvLsXSk4xVDnJfL/LiBRIGf4g/1f5K?=
 =?us-ascii?Q?SxMMx+e6/EpfKsmYfVetiHrhbVLZaEdwHyhTz6++BiL5xG15LoUVb8RJMO3H?=
 =?us-ascii?Q?HV2l3Qe07e/NOB3dOntKPKXUtdsDWBSmO4j1LgzInql12G2jzFzHVQ9D0c2p?=
 =?us-ascii?Q?UMDfYxHneiqqQR0UNUbwqkY57aNGfA97PzC8fEIUY2HKAIUybyQIDSoOzTy9?=
 =?us-ascii?Q?pfoPAs7BJuRjabxw2Wi/VsbMnu2WEUJVJCMrPQy1Hf+ADmTf5B4mIA1biQYQ?=
 =?us-ascii?Q?lSMmgpuyZGikEyCfAgfn+cs3OIlv/IkpAMhFJMuEYt48Zbzzh1nKIB5Owszl?=
 =?us-ascii?Q?M7TqjyZU5f03Dqx8Ia0d93FLqZhGwYf/M0SzSGRSMF/4XRi0cXs4C2HVcFrH?=
 =?us-ascii?Q?4IcCNanOB0ovoie5NdvA2T7Vw2eht136vBZE6uIa+Y2fsNHaAv0Da46u6HeN?=
 =?us-ascii?Q?Qs+R6Vo5nZGd98us1ezIWkhU5WAUaZbWpCGjbUQbak8frCt/HExDV6i6MyVl?=
 =?us-ascii?Q?0VrSgJd8pK3y9/NnPaLqajwAnWxVIK+//TFEK+ihBSzVRh5bPhAkhE8TESQc?=
 =?us-ascii?Q?eFtC0g6h6E1zdvzIt1YdOWKqsLeT4DvhB7GNgKwna05ZzdakfSJ4TR/jK4g6?=
 =?us-ascii?Q?2+UZTU4QiWVxvyunrcOW5IcXSkqF4Xea8RyKClCMFH/nriPzMcDqCPk5nmnK?=
 =?us-ascii?Q?K+x7JvtIh5MEKPDuiVheavVxhg1w?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-10872.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 0211a61d-97dd-47e5-6f42-08de8f589987
X-MS-Exchange-CrossTenant-AuthSource: GVYP280MB1518.SWEP280.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2026 19:06:23.1515
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-34232-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,HOTMAIL.DE:dkim,GVYP280MB1518.SWEP280.PROD.OUTLOOK.COM:mid]
X-Rspamd-Queue-Id: 3D6A13705CB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/21/26 8:03 PM, Christian Lamparter wrote:
> No, that would cause it to be counted twice.
> This is because in the parent function carl9170_rx_untie_data() [...]
> already has the "ar->rx_dropped++;" in the "drop:" error code path.

You are absolutely right.  I missed the drop: label in
carl9170_rx_untie_data().  The correct fix is to simply remove the
stale TODO comment without adding any counter increment — the drop:
label already covers all frames that carl9170_rx_mac_status() rejects.

The original TODO read "update netdevice's RX dropped/errors
statistics" which refers to the netdev stats (ndev->stats.rx_dropped),
not the debugfs ar->rx_dropped counter.  That wiring is handled by a
separate bugfix patch which maps ar->rx_dropped into get_stats().

Corrected patch:

  --- a/drivers/net/wireless/ath/carl9170/rx.c
  +++ b/drivers/net/wireless/ath/carl9170/rx.c
  @@ -340,8 +340,6 @@ static int carl9170_rx_mac_status(...)
   	/* drop any other error frames */
   	if (unlikely(error)) {
  -		/* TODO: update netdevice's RX dropped/errors statistics */
  -
   		if (net_ratelimit())
   			wiphy_dbg(ar->hw->wiphy, "received frame with "
   			       "suspicious error code (%#x).\n", error);

I will send a v2 with this fix and an updated commit message explaining
that the counter is already incremented by the caller.

-- 
Regards,
Masi Osmani

