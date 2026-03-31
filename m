Return-Path: <linux-wireless+bounces-34231-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YMStAF4bzGnHPgYAu9opvQ
	(envelope-from <linux-wireless+bounces-34231-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 31 Mar 2026 21:07:10 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 86CA63705C4
	for <lists+linux-wireless@lfdr.de>; Tue, 31 Mar 2026 21:07:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 008D53068A1F
	for <lists+linux-wireless@lfdr.de>; Tue, 31 Mar 2026 19:06:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCC33223DE9;
	Tue, 31 Mar 2026 19:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=HOTMAIL.DE header.i=@HOTMAIL.DE header.b="ZHHNBOz/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from MM0P280CU009.outbound.protection.outlook.com (mail-swedensouthazolkn19011034.outbound.protection.outlook.com [52.103.34.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D4C39022E
	for <linux-wireless@vger.kernel.org>; Tue, 31 Mar 2026 19:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.34.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774983984; cv=fail; b=u553JL2mFFkr4LXJ33+MujvezT4lVCnEx9ZZ3VUlLlQf21eSf9jzw/ca4OodihRlDW8Zj2S4sbgRmQiVwijSrz2TSJFcICgZuSUTr7PCuWhWg3pj8yIaJ5SZOA48t0Utu3R5kBeaAOw9Z31FyniIPyfIYpmLAM6qU/w9QUwNAiY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774983984; c=relaxed/simple;
	bh=wH48D/a0XgDSEtch+HOr7SPX6JzTgG1Q8GlqEFG5NvM=;
	h=Date:Message-ID:From:To:CC:Subject:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rEs55Lzs1MYya/yMjm9fZ0rwqRLQFnC4RPxy5JHLjzKPBNC3MbXLgBCuMQewh2jQ0gqxh2KCbCvZHvJ+FkJ7/E7qRMDRwgm/RBEHl2/pFKsSpElgs7auOgfKEE3kSD+gCmbiegiK06nzdTdCZEgWOayhgUDDFDvuMGrRr8RoWhI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.de; spf=pass smtp.mailfrom=hotmail.de; dkim=pass (2048-bit key) header.d=HOTMAIL.DE header.i=@HOTMAIL.DE header.b=ZHHNBOz/; arc=fail smtp.client-ip=52.103.34.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=exbG+NNt/f3YkJXuHrerMB+qtnDkl2QEYb1HecoGolohblvAlvyv731P0+DujLM+DSeVOCgbGirHftBpRaVNIZcCTRlKA6kRaau29/ArJnUkejiBKAUraFwXPWN81tewdDbcfnKJe+0ocBoKYXHRGdWQFJIi1m62RDWX9dTpZtuJ5Hxf6Sif21GzJOVBIEAF+FZ+7yUKagw+S41lJ1aod/KVy9HVpcPLn/UViUkTvWfQqgXLtXvM0349RNBaCeQq4WGubj3mfl+jqaqtkKvVLZmMPGRamjHew0nixEZum9vucAzOohKw/JtOzIvnA88Cu6GDNqoMV83hM/CXKy993A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/pb1vlHZlFsnRKjsSBruWJx+M+stwyDPNZwdA6OslBo=;
 b=JrH73R2Jp3QzHITzXYhRaYlqQ7P6J9DCwpBQyDPw7Lm0YpDk2NeDGT2kGwA1glCmLqzhamL9EYFlar7iN8g41NjY212ZBklEHPH7MoNZI0Q4YScY2XuSnEeExb5BBUtotTRKH+ugf+LnbflsV3FNMZVHRXlY7TJIQXrBLvhACqt465Og+bRYau6xTrUYpaJmf8u+zmBNrITlKgAS76UxKKNfa+uPmicxvx8BQ4EZJdrxFqovXX2drEVMlKbObAY9CZ2nMSmOxhLNoMaotwT/ZcLIanlAVks/oU9WpDIW4DnaqQQaOkrZu+W1TBlPpYQ9DrNj8B0sbat9B73o3v/rxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=HOTMAIL.DE;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/pb1vlHZlFsnRKjsSBruWJx+M+stwyDPNZwdA6OslBo=;
 b=ZHHNBOz/FCDtT4UHx4CJnD1m1tr5Q1+xHIsLsFoakoZP3cfQpwYqx0jcihuwZ2gRRAY73qmIg147BPbrJIFpcRUENz2NF6eYEbtKq/5/BXwnVwJObe54JcvCYB7yX4Oi57DjgG52mMjYGnTwLMdEJN9XL8aY3eZQTDHXuKYglybWBsnNdp/AmN/JlmNpu5C+7uvMO+hTzc/vVogdVLD5KU0/x6azKVL+6Aav1JnA9U8ySODsLAkzTVmYQjGS/0WokZ8miK+07kgJQPj10FDzaKwknvxFh0s8ls+ilalrce0bqDes+n2G2bWvL0ZD0MT/cCY9QN+e/E3JpGs5CWGdEA==
Received: from GVYP280MB1518.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:19b::9)
 by GV5P280MB2028.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:376::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Tue, 31 Mar
 2026 19:06:21 +0000
Received: from GVYP280MB1518.SWEP280.PROD.OUTLOOK.COM
 ([fe80::6328:bea5:c218:593f]) by GVYP280MB1518.SWEP280.PROD.OUTLOOK.COM
 ([fe80::6328:bea5:c218:593f%4]) with mapi id 15.20.9723.018; Tue, 31 Mar 2026
 19:06:21 +0000
Date: Tue, 31 Mar 2026 21:06:19 +0200
Message-ID:
 <GVYP280MB151865F3C7F074FBB3DA91C79453A@GVYP280MB1518.SWEP280.PROD.OUTLOOK.COM>
From: Masi Osmani <mas-i@hotmail.de>
To: Christian Lamparter <chunkeey@gmail.com>
CC: linux-wireless@vger.kernel.org, ath9k-devel@qca.qualcomm.com
Subject: Re: [PATCH 02/10] carl9170: mac80211: advertise RX STBC capability
In-Reply-To: <8a8ad3fa-d32e-480c-a2a3-421c262023bf@gmail.com>
References: <AM7PPF5613FA0B6ACC91029B589B12E12639444A@AM7PPF5613FA0B6.EURP251.PROD.OUTLOOK.COM> <8a8ad3fa-d32e-480c-a2a3-421c262023bf@gmail.com>
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0179.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9f::15) To GVYP280MB1518.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:19b::9)
X-Microsoft-Original-Message-ID: <42771bcd1840a7a222b61ac10249214b@hotmail.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVYP280MB1518:EE_|GV5P280MB2028:EE_
X-MS-Office365-Filtering-Correlation-Id: e268b5cd-6c28-4e44-075e-08de8f589851
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|15080799012|12121999013|5072599009|23021999003|461199028|8060799015|19110799012|51005399006|440099028|3412199025|4302099013|10035399007|26121999003|1602099012|40105399003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YH+QdR8uuhRcxeICE1HXWNEtzJ8mqFTH1UGX6N16CgQP1y4gyXLHPRdnotgy?=
 =?us-ascii?Q?ka24Kh9pHBLbLAsD8Fv8ZE427M7nUv7fnD6HVLpTg7Q9zylFCaFrRsxYbMwE?=
 =?us-ascii?Q?y+koQCcybnTVcTp8vnsxtntI3/0MwzfUTcaEEWtANCxAwlLqOCUd8K+CzGXc?=
 =?us-ascii?Q?CnA1XYENp3FEulxkFrOThdFDH4G37E9ICcuRFDksLpw3N1yix09zuVryEuNW?=
 =?us-ascii?Q?t3V0td5X73xxgNaV/cTO0Ef7sOQXvsCSuarPT1HBKYsaZqSiwt/WK6DnJC4J?=
 =?us-ascii?Q?dd67ci58GBDEQA034jK9IYdutFNSpugDoxipaE/TcaJE8C/dQZZPz7f1XUDH?=
 =?us-ascii?Q?ZeEl5QI05j7uZtekQ+HsC2FcvNULzsT+hX+iSg6AomR3LSozEi3YVN3/vITq?=
 =?us-ascii?Q?104Ok2BmOrEg+l9BZbnzzGWL7gOg0aKjGS5jd0GSG+wxSZRV/yO4ZHt1qsrH?=
 =?us-ascii?Q?4Gfifdgwn7/pmmuJwyMLqWIcvhpZZAudiDAjsn/1oQWkky+hkiOFWxTVElEl?=
 =?us-ascii?Q?jiOYoLBIbLtNg+kUTs6eD7XP/GQW6biEjUl8FucWcKAUxMNqN3dR0f+KYTKo?=
 =?us-ascii?Q?AgwvElsnYtCORrDKfLyRrdPU9y89dPcSU6kHGi6qRypM1SptRA0aikKB3eQZ?=
 =?us-ascii?Q?oOgqt1wWl7cjKy9iud7NJm0+YpyZmcsEvwaAbHBqsbYU2vRH8sF/3oUlydEs?=
 =?us-ascii?Q?6BXfMoI21gLGUj0CNnkjRL1U36opm+ao736RDMyfzlldvxLxz/OlRN6sB/tJ?=
 =?us-ascii?Q?AoI0NRkJL2at4Tzz6uyi/7N1ewlBNSnrzsV7buKL2LJ+yQHupg8mAQOc33+t?=
 =?us-ascii?Q?fzwxLQ6Yn4rVG4bnJhcWlQHYJZ8RrMH0VX2VV40N3LSi02TKbe/lVsM+M/H9?=
 =?us-ascii?Q?rw+hI2IHSu2NoD4vgssmgeq7B8e7jdWE3qX6hjQUdqlK5xYUH04BkIj6bW5H?=
 =?us-ascii?Q?VSMDTyIWLpYlm6YjvkJQvuOu/VM89NrGClGQSQprlIOeZsAgpNCQLruTRnZL?=
 =?us-ascii?Q?VA1g3l9fnpvvmk4mFn6W7op4e5zRHYp8uRx+9HA+AKXv6CPeTZCyCgg0Nz0J?=
 =?us-ascii?Q?i92POCYAdA6MxE6w/1aDSvFHnYov54Mzbj1tN7Ae3oHs+h7wyZU=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?j5bUBuLK1hyNb1wQCFmY15rhcS8r7qRcsfi+g3BH1uc44Y7VrDmwGD2EERpm?=
 =?us-ascii?Q?gpn0CTvqSoweelxGZWU/m6spRSAZNI5JqbavwlqkQgViAn3X6URE3uMig4mI?=
 =?us-ascii?Q?7UBNX66fkKN2G7zAph6cQUbQd/MMX6ovuyLHRRER/vojo2u2eRgIG24f8sm3?=
 =?us-ascii?Q?+/E7rV6jMWFMm6ayWzu9maL4Na6mFu+EWI9Yag36uCyn7u/62MaXgC7GoWmH?=
 =?us-ascii?Q?IQLbBbUNiFw1Nlm1xJVHXd46nTOCjiKgN613DA/iMgqDxan5DbkLD7WUBaEP?=
 =?us-ascii?Q?VF/hswdZNylr593Ce+mP8/B4rPtyZN44ru+iLq2Ey7HwrP8PxEmIWzxSkkVV?=
 =?us-ascii?Q?SuT1xz3TRu2/R5qHni594x3NMWj/Cs5lB3kzv21dAPXaKZJ/n24D8FTu6DcN?=
 =?us-ascii?Q?OdVhJr02MDwDjEE0li/n5T1DULkYkhDkUrVD/fyEPj3OFHacaT9oLYSajYKf?=
 =?us-ascii?Q?CtzdPfP8XKiE0ZWB1bLnR/+YmUEQ771Zkhd748osIn3Hz8RSewZesByOeXjX?=
 =?us-ascii?Q?2oYvAzT2j5/5Y+tSayrRCP5HnHEirralCyR4B7wrHNLq0Ft06qHDGfVfo0Jw?=
 =?us-ascii?Q?DTfFmJ20naPpllSXpx33OlsOJrALL8hjooZ3n0G9xsp29CNa45Q9qc3oUUqH?=
 =?us-ascii?Q?KMG6zBUggL+khy0bZ1RKknMdeCZqzowIFBJ1/nCPiG4NA38GutYu0Yls5Jtr?=
 =?us-ascii?Q?uOssxXkKrQvyhifzCM3eR9spGVQmNBUPjdi+Xd9QEohbG6t/NxGXJS/R0/7Z?=
 =?us-ascii?Q?4HXFN9RxZs4qADA2+QquBeDv86qKQuZDp+FJt0iZhcxru35rNpGsyYQOltkv?=
 =?us-ascii?Q?IdPCtGEittnhDKo8397i5AdbOggJHxM4yX4xqNwsJA6917dfjrH8OVSuId+v?=
 =?us-ascii?Q?CUiqPtSaGxAB1u/y+wv/QJqcL2O6w+SCbeBY3wx06+EAsXOJBMwmGHZzFt0H?=
 =?us-ascii?Q?CEzZyzR4KBRB6eCz94YgClCCCumpPxKOnmmORhqoVOKXld7GXiSYr7qqex6E?=
 =?us-ascii?Q?nqLyUiEVbnzoYaQ9KSUPzSF+yDvKTCalfBNq7YpQgH5KtSj4IyGx6DibM6ay?=
 =?us-ascii?Q?99Shfw1QjUQUdc8FJ0gBZKXygd/ekzboa4QdaeeXUQz2DiraHVC2ojqKqGHz?=
 =?us-ascii?Q?FaIIFKhTk0uLni5Hl8WEzrNRvIMobpUTyun5ZMyT7RGrRH74sYp25ypz2HNP?=
 =?us-ascii?Q?gNa2mKZB6JRW95zR6F2Xy3JBhYhrSHSnrHhvFZzLtim/s7kMQvtB189w1hen?=
 =?us-ascii?Q?TFMWDAP3yWGirdUrvXivs+lkPEZoTYsBLjtwlwrzFqDx9dXpTRAHBlTkZlEY?=
 =?us-ascii?Q?BI4vzU1wwRHbm3NaFyJ0qDRCr1qvsVK5NRoJYmtWfSMivL7KtAlixpJQ/QrB?=
 =?us-ascii?Q?1x14qzDKtcGzzew1Nal3JOMbP08H?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-10872.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: e268b5cd-6c28-4e44-075e-08de8f589851
X-MS-Exchange-CrossTenant-AuthSource: GVYP280MB1518.SWEP280.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2026 19:06:21.1118
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
	TAGGED_FROM(0.00)[bounces-34231-lists,linux-wireless=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.999];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[GVYP280MB1518.SWEP280.PROD.OUTLOOK.COM:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,HOTMAIL.DE:dkim]
X-Rspamd-Queue-Id: 86CA63705C4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/21/26 7:47 PM, Christian Lamparter wrote:
> No, not that I can tell.
> https://git.kernel.org/.../ath9k/common-init.c#n204
> | if (AR_SREV_9280_20_OR_LATER(ah)) {
> |     if (max_streams >= 2)
> |         ht_info->cap |= IEEE80211_HT_CAP_TX_STBC;
> |     ht_info->cap |= (1 << IEEE80211_HT_CAP_RX_STBC_SHIFT);

Same situation as the SGI patch: AR_SREV_9280_20_OR_LATER is an ath9k
MAC silicon revision check that does not apply to the AR9170's ZyDAS
MAC.  I should not have used it as justification.

Confirmed working on our hardware (Fritz!WLAN N, AR9170):

  iw phy phy0 info:
    Capabilities: 0x196e
      RX STBC 1-stream

With the patch applied, 802.11n APs transmit STBC frames to us and
they are decoded correctly.  The device has been running with this
capability advertised for several weeks without errors or instability.

The AR9170 has 2 physical RX chains (rx_mask == 3 from EEPROM) which is
the hardware requirement for STBC 1-stream reception.  The OTUS driver
source (HalPlus/OTUS_FB50/hpphy.c) does not gate STBC on a silicon
revision — the 2-chain baseband is sufficient.

I will send a v2 with the commit message corrected to remove the ath9k
silicon revision reference and base the claim on the 2-chain hardware
configuration and observed behaviour instead.  Happy to add a
module_param like the SGI patch if you prefer.

-- 
Regards,
Masi Osmani

