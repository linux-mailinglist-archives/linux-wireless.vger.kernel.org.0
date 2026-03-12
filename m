Return-Path: <linux-wireless+bounces-34248-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mNdMKs4wzGmwRAYAu9opvQ
	(envelope-from <linux-wireless+bounces-34248-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 31 Mar 2026 22:38:38 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3417A371318
	for <lists+linux-wireless@lfdr.de>; Tue, 31 Mar 2026 22:38:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A87EA3072D3B
	for <lists+linux-wireless@lfdr.de>; Tue, 31 Mar 2026 20:38:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1547C44E043;
	Tue, 31 Mar 2026 20:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=HOTMAIL.DE header.i=@HOTMAIL.DE header.b="nEoJZQh4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from GV3P280CU013.outbound.protection.outlook.com (mail-swedencentralazolkn19010035.outbound.protection.outlook.com [52.103.35.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD02A3B6371
	for <linux-wireless@vger.kernel.org>; Tue, 31 Mar 2026 20:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.35.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774989510; cv=fail; b=c8CI7Wf6AuMpyiKo5MnHxO7qa/POlpalmxs7vpFhzUGA+2vxmNPUA6j0DvTu6JIVRBxPu0Qk3wmf2qlrz0RXhSBdhK9bPrAIPOecJiYrawyfyJNHeesLpNyIRyTUof84jBjBR6WzGB5oRwARyOlW3XWDlvBLooUt/Vb5bCBhDt8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774989510; c=relaxed/simple;
	bh=w3jvkNlt49N9bbbmPUo4sI2/3+2Wc3E3yOPHxunmpxo=;
	h=Message-ID:From:Date:Subject:To:Cc:Content-Type:MIME-Version; b=anr5y1eC+sZB+IZ4XYysbD1VSnNiXOskvR1FMXrHIlA8GS4gYLkQAlz8natiSB/2Jo2v3/ODhGTfDhaxx9YPpnpJLBqg7p0Gew6zqAgycxUCcXeq9aAuRyOn55eFGZyxX36dbiLcLK0tKj7Im0jJ397MzGADI5MmaLCAFDfu/n0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.de; spf=pass smtp.mailfrom=hotmail.de; dkim=pass (2048-bit key) header.d=HOTMAIL.DE header.i=@HOTMAIL.DE header.b=nEoJZQh4; arc=fail smtp.client-ip=52.103.35.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=txYxTfxnEsTjQyJYThFWajxUiZROttYlEoT9T/E3Y0QZi/MEqGWmY49XoeUPR/nZJzlqVzA/7oAm9Yb0/HtZ6oAMBgN2bsF/T55Gv6u/xR4YgBJeseBPvAlPheiIkLkQF/Zfin8OUXDIj+02XXWLgoTL8ae2VoCQjzJqBaYHtW+3aS5qFaL+q9nG5DuwcNY0f8bZDsOxXOdc01sjMXgGPDL3GFV3gpcLcIdSAPsQ6JwU0iDskLcjSQnE8Aaq1pG1V1MB46FS1X9fcXxC5RQlWdnFBOucNJ+ErWblGLA3X+cEWiLxkpV0fT5zwspR8614BQowsi6Q4MSYkJhLfL5u1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dp7WDm6vJETDjyEGFVIGQua7hM7fjv7FGQw063lOcHo=;
 b=odVhOZAAuaV5vVX+cHFNthX+70G7GtlXnhjfwVppYAq981R1p1GOFItIjjDRaiArDQdR+lSoGK4hcQ9SXX15eJzG3U1Tgjvao8FJq4EnuPs4e4OxfAQjnOqNCIVe0/ZAd9hGzZQqUal/5eA17XNtWiR59xsuTkHrRv5y5j4D35nfs6PzBzCh0h3MTa1AFVWPJcmscJdeWJv9yzgY/nVQkigzWLiFNko3A3f91xPdhFwb8FfbgRmVpXSUobDAhz2uhwAmQW2G++z5Vh23+3Avbe7o6bnOvgrd23xuWXku/4gJr/rfP8exQ1XYZYwd3+lBYtfcPsrx48L5g0JjIa4USQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=HOTMAIL.DE;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dp7WDm6vJETDjyEGFVIGQua7hM7fjv7FGQw063lOcHo=;
 b=nEoJZQh4txXez8LA5k+2fhfyWJgaTC/DzNTfjj2qHlWn12qzFFvrwQmj84xD/n+rL5EQz279XrmZcVP/V0fpqHmWpeW3HGR8tjE2Sjp4pFbxZyiQuTvz1iCyJ/xu/yKaMAfpkjslacglpUibORn3aJTFiE4bTvzvUe37g347Qx63j1YwJhBreW0J3Ulinpw0L8CGiK8jPcouZH2o9g77Gr5e6X8POTKIqMnY4s4UKbiGE8edcoUEAikyuAaqtoQlM43wfWYEtIoH20HWGW1bkENSas37itW2MQECo9CaF+IueTBUJRGK0nXbrnjl0qsei4+vZAy4J+Pfg3KxId7YnA==
Received: from GVYP280MB1518.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:19b::9)
 by MM0P280MB0851.SWEP280.PROD.OUTLOOK.COM (2603:10a6:190:3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.28; Tue, 31 Mar
 2026 20:38:25 +0000
Received: from GVYP280MB1518.SWEP280.PROD.OUTLOOK.COM
 ([fe80::6328:bea5:c218:593f]) by GVYP280MB1518.SWEP280.PROD.OUTLOOK.COM
 ([fe80::6328:bea5:c218:593f%4]) with mapi id 15.20.9723.018; Tue, 31 Mar 2026
 20:38:25 +0000
Message-ID:
 <GVYP280MB1518D5CA4601F15C5506B66C9453A@GVYP280MB1518.SWEP280.PROD.OUTLOOK.COM>
From: Masi Osmani <mas-i@hotmail.de>
Date: Thu, 12 Mar 2026 02:04:02 +0100
Subject: [PATCH v2 04/16] carl9170: rx: remove stale TODO comment in
 carl9170_rx_mac_status
To: Christian Lamparter <chunkeey@googlemail.com>
Cc: linux-wireless@vger.kernel.org,
    ath9k-devel@qca.qualcomm.com
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0178.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9f::7) To GVYP280MB1518.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:19b::9)
X-Microsoft-Original-Message-ID: <abb5ea706dca3b97e9637095dc217b0a@hotmail.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVYP280MB1518:EE_|MM0P280MB0851:EE_
X-MS-Office365-Filtering-Correlation-Id: 88363559-d997-4155-1059-08de8f65755a
X-MS-Exchange-SLBlob-MailProps:
	KW6s2gPZH1eaZMsDFrtnScTYUpn8LGIXh2GNqQbFbRRxWc+hE3nqSUzqO20DuaWwEddOej3Nxtk4hi0cMEiiwMF7QNR9RgeTDsZDoSsU2rPf+NtIz3Ft6KjbCY5EHPMeJgXW+y+1p6fl8tZp3tAsk0O3gxt7yTaT5MqQ/S0+0qJrD3TtgP6/1TXToMDh3J5kB555v5Oy8qxBqGrEsGLfu9kIa4zPa0iqHGeX60uSBvH7n5NQ0pB6pEvJz+9rX1MzN5AdC8VLlUkAfQPEX2JvrnaCtR4E3JSsAURB3pox2wrcwy7TSAJliaKXxIFPCYk7C0yHnp6zSVRWUvf816Td9zBGP6oM5Ie6E9ZiRR0f7AlAa1EvpPY86UO7oav4Mep0wShqbN8tuNMMr+RHxfSNocw6dllemnHlelUWgTRfMsfmF4liAqQtS0Vyf2OCp3DW4nU9IxDK1/zridjE1naLZ+jb2oCnUso0zer3X/ofVghaXv1wH8vmYFAWEEQoB90aW3Mnyx8yxl2jx/214XKQqasJhKWlJaPcTl798ShOc+n47u8vCaOvvPcvNdCT3VFpKcNHtTBY8L5jjXqAzRIIMWJUbibymyKNQ2Zw1HiP5Ug4tkrfGSD3IBzGHvzc7K69CWFCyHGqj66u6jLUgIlT0OovbibXsXromeh25vKDpbqfrtjyPhDHunlrpllxFOG+XvvEYZhURsiLXEq7h5iLCGoA5f1sF17nqV0YLcor3rw=
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|51005399006|8060799015|23021999003|41001999006|5072599009|5062599005|19110799012|15080799012|461199028|26121999003|13041999003|40105399003|440099028|3412199025;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VKiKpQ18f6J3bdGrcLBEHdp2w6ZMbes8FgzNF/NWgOB2VYuqjCIA6AN7ZFpa?=
 =?us-ascii?Q?N4FMqyxmNHo3YHqED4LVqCaaYFUA6+jmc0bc9ceCIWPJOhh3cIVaY2Bzx1t2?=
 =?us-ascii?Q?FzlDVaLl4sjuF8ohtBRx6njETP3XCJYxmp2d9gPBgQ7tFnEBjiDFCgjjYVE3?=
 =?us-ascii?Q?EOTkK8SpTkxQIePqE9oqoqcGAib/qPYaPDjqdyygvl5Z/5zWpukL+W86mkwU?=
 =?us-ascii?Q?sokYO9YQ/bhfxAWMmdQJK/0NIH3KtmLecSNDirv/Bd9slfXttJteimels+tz?=
 =?us-ascii?Q?HX+hdSqoXJWGwdNbj5NgimDwQcQy4fPT9AhMnBP0nle87Sc0tP/ASwAh2naX?=
 =?us-ascii?Q?NDj3vzrmI/SJ7QZBBybypv5Jbqttw0uZqneY+dzc6lNhaB7TDzSBwc0/p4do?=
 =?us-ascii?Q?Wr9tprROVmaYdn6FWqhIBljDqOeLb0UvMw0vmBQZjIMMYV/eZV8fAEl9uHPR?=
 =?us-ascii?Q?oVvqom28UXpL2uPSEqdAK0KT1tkR3L4o0jvl0QIDJoK1ENx2RDz9HlGsFkSK?=
 =?us-ascii?Q?CZCRMQ7C77s+XR/mjPuksNodBt1+dSvAP4rs5KbJfMjtHVYSvdJBb+iFVRUu?=
 =?us-ascii?Q?zq64tvgKBdOaoaymN+OU7XoUZqVM7hKSyr9ZqE9zdMrbrzOfFpZY7QC5pk6w?=
 =?us-ascii?Q?5TKmbSpqiLE79tnzBPBJG1lN4zf682zVBffc+7JpHkSdqacAqbicvlJ+IU3g?=
 =?us-ascii?Q?oFzROKZ6170/xpdefhB35MhBSkyhD7MefThrjY0GCKNk9NEBsYEW2VI/9fHi?=
 =?us-ascii?Q?yLBOr3snrQS2d7H79X+LWYflInw6a0kd5SZ3+FGeqIBAlty1K3SGDWblSAWt?=
 =?us-ascii?Q?shf989lG2/fIHyKBjl7j+AN1NEYeehHE6J1fMXWp9uHCKAoDDhMaacPQZPPP?=
 =?us-ascii?Q?dP8tP7yidb4nlgzG2DMXSq7bQZqyIY9UTHARcBG6m7z2LbRH/3LTimSCmgGx?=
 =?us-ascii?Q?aZq8St+E0kqPH6HmG397ppZwHXU8X1uLVkcQ46i3wot6p1Wj+oFJ+5yQ8612?=
 =?us-ascii?Q?96mODM6kz0uz+j8XMM1ev9QHw9WRIthB89JvdUHf/x8Fz3U=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xfWbeTVSBgS8rWKmy7GHL/XiDSll7QoquN5tjbZLzi1rVnsrA/XOugTqSbxS?=
 =?us-ascii?Q?waqbcvr9hix5S8r6H8HJvK8LM54KLSAgemgnPNB8ShsmLwTeMWyPq3RieOP/?=
 =?us-ascii?Q?DHgWatkYj8WbmXc5+J0s5uNZ3DwR5T/o/Kqo7/L1N9ydggbgwmMiJ20RInZB?=
 =?us-ascii?Q?8gDBeoNzY4UoXauQi/B+LiQb7RJ3wbAunkz+wDzh+N4vbXzN9Hxx2hzXYOry?=
 =?us-ascii?Q?mUfgUQ+f1SVMj+AfGmC3U81PIXlgvw5xWLbcZV849ScS0qoHH0mfWGG4aGLY?=
 =?us-ascii?Q?QCcezDxSeVZfCARcuRWkvBvn8/pv/6Gk894AAORe+/5rteH8U2QnLGXReOKn?=
 =?us-ascii?Q?4xXRSKPBBbSzpmNiGMeWaDAkGVncJlcoxE1k4IujtNV/vigjalkR+nS8Uqqi?=
 =?us-ascii?Q?Ah4n0wpVVZoxLh2vP79J2O1Z28+lES9tHhYf/XyHo0/2EDviaadMpmt1hO5z?=
 =?us-ascii?Q?+crhLH+iDlwdFQAgSZUAUx6/lLy5xitUm1BbfHuO5lzrO5/QgPUm6dcRurH6?=
 =?us-ascii?Q?pJUm1ZRNVsaXG8CI3AJpIAHrneALLrxnR1KNiwi3TOhuv3AkCNWXMbq8nNro?=
 =?us-ascii?Q?9tga889L365qIkXv7GMFVwwlkRyoJGssAOw2kRu4ZPJFZKsElQtqTlof/A9f?=
 =?us-ascii?Q?Jfh/RirMGtSXNCkvUTBFGnCkuBFwPeGQYaEF+Gieeg7aM22cWpAxqUM+FHs+?=
 =?us-ascii?Q?riO3fHIA7I9X4iLn/6p5+nZ4L0whhzxNS644C4zO5QArh5YF5pk5+fxXNFsL?=
 =?us-ascii?Q?evgujby3+LcuC2CY1s0CZMipCV1ksDiTlTUBHQWFCVbpWFm90sb+HKMvHdWI?=
 =?us-ascii?Q?Tvcqt3CDgfCpMzbs21XF0hmaIeFMBBbmfuVIxpMGhY/gyVjVh2CqswjXWmNn?=
 =?us-ascii?Q?Nd5UUJN3SP0oVvVe1XzHCt4zrn3Tucd0MJQPZcy2eWwl+aUtosuXnzzpTTRi?=
 =?us-ascii?Q?tc3OGqfJTy6KKrffUEJDrh+szYJ7rqiKNLw0hZA1IZWXQt5QLRZedjsaHxky?=
 =?us-ascii?Q?t7z8r+OB3Wf1omwMH83laYJY/C0fWq2jCBVGx1Exdwwb9Orz6T6IqgLDkQJH?=
 =?us-ascii?Q?HzWAG/Y9e/8FJpcdv3JdQsht7ovP2mCHdGgqevj/lZszfYoBnglxUe7GCqiB?=
 =?us-ascii?Q?gTbMoC4FJxK2IJrLdnb0DZFLOu93ysHn0DQ8UpDSRjw212cAPLK6Q6i1ciAN?=
 =?us-ascii?Q?6redb0y4DcqA1UpBhnixDqj3CTtMRNk44i+8jASdAArB5aeaRqRXuQ1brL9t?=
 =?us-ascii?Q?d7auXG9mCGM6zN+pxEeCaSXKTpDO2wj+L23iILrY9vfpvm0zFXoaYzxX97d1?=
 =?us-ascii?Q?0n3asRkSlXv5ptd1FiCrR9sf9RBhNngTH8hGSbvtjqBgluT6zB0FA6oUv3nl?=
 =?us-ascii?Q?nqzrzyECp3Yc90HL9L558MMOE6cV?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-10872.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 88363559-d997-4155-1059-08de8f65755a
X-MS-Exchange-CrossTenant-AuthSource: GVYP280MB1518.SWEP280.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2026 20:38:25.7998
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MM0P280MB0851
X-Spamd-Result: default: False [1.34 / 15.00];
	DATE_IN_PAST(1.00)[475];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[hotmail.de,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[HOTMAIL.DE:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34248-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[googlemail.com];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[hotmail.de:email,GVYP280MB1518.SWEP280.PROD.OUTLOOK.COM:mid,HOTMAIL.DE:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3417A371318
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The TODO asked to update netdevice RX dropped statistics for frames
dropped due to unrecognised MAC error flags.  The rx_dropped counter
is already incremented by the caller carl9170_rx_untie_data() at the
drop: label for all frames that carl9170_rx_mac_status() rejects with
a non-zero return code.  Remove the stale comment.

Wiring ar->rx_dropped into netdev stats (get_stats) is handled by a
separate bugfix patch.

Signed-off-by: Masi Osmani <mas-i@hotmail.de>
---
Changes in v2:
  - Change from replacing the TODO comment with ar->rx_dropped++ to a
    pure deletion of the comment.  The drop counter is already
    incremented by the caller carl9170_rx_untie_data() at its drop:
    label, which covers all error paths through carl9170_rx_mac_status().
    Adding a second increment here would double-count dropped frames.

 drivers/net/wireless/ath/carl9170/rx.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/wireless/ath/carl9170/rx.c b/drivers/net/wireless/ath/carl9170/rx.c
index 683343013..4714ee8b6 100644
--- a/drivers/net/wireless/ath/carl9170/rx.c
+++ b/drivers/net/wireless/ath/carl9170/rx.c
@@ -340,8 +340,6 @@ static int carl9170_rx_mac_status(struct ar9170 *ar,

 	/* drop any other error frames */
 	if (unlikely(error)) {
-		/* TODO: update netdevice's RX dropped/errors statistics */
-
 		if (net_ratelimit())
 			wiphy_dbg(ar->hw->wiphy, "received frame with "
 			       "suspicious error code (%#x).\n", error);
--
2.53.0


