Return-Path: <linux-wireless+bounces-33073-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SGwlNVeBsmm6NAAAu9opvQ
	(envelope-from <linux-wireless+bounces-33073-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 10:03:19 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 055A926F551
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 10:03:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 29EB0300CE5A
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 08:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 696C538B152;
	Thu, 12 Mar 2026 08:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Cw5O64mQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013040.outbound.protection.outlook.com [40.107.159.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A3182868A9;
	Thu, 12 Mar 2026 08:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773305889; cv=fail; b=JMzR1Hbd7z4lzedXwX841Mk3YKn7ePXmSFo6C2Pyi9JBaT4HZAnT3XdWApVfpH7QnCOTleYzjEtPjzomLH/0tRVnhAmixqq3gRHaZvpz7JoEW3VOhd+DRxZqJt9WLkIFYzq8wlAp3TKgy0LT32qtscdEGLkOkuriFmehndxkXIg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773305889; c=relaxed/simple;
	bh=VNuGk/07z5Moo7ftmTraiNVgR1HnIAISvIxhsKkPRJY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=IfnYz/bYEnzw436hpYeU+GrCXoaXkQN/OhluQqx2sdWxhBTtsnfenIdYGsfrv7NSJBwoSb2M8edbTZZcvw4lqh2nJM+ve3qSeBLPVTpbWLCQKdNHW8CHq08jYuJrxsq3otB5vGF0wta59QXeWZAlGusNjdCiq9KUMKRFuSDStfQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Cw5O64mQ; arc=fail smtp.client-ip=40.107.159.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f4m/IcsxsdmQCaWdADVeZ6eyv78oCwnejbif/k8DbcoL8My+RhgcgM66L/d3O7t8kfHjcBLDbfZdpLSzDevoASApnUrIV7vvQIx2pHZ5E9hxQGVxQ4UqtZln8ccBG2mQfFd3Guz2CsB+DefQtMU+kIxTjRheytfMvNHCQGDTjqkXTSFHi51GOWogvFXxhfpPF+K+YLd3T+N5SFlyiB9sJylIP6jEl42B3EAeLGUJhOf0UDXq0SzjGMscqREVV2zd7bBnaB1P2BlNH0jn4+IEzd0ohryOups1Wyu/cJPXayz6A8nefHkqdm38yyJ/9pXjpcTAstszMfhgGaqh+RW8nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2Eob1sLKqC1dCgV/riweBbb+upmMNLuhJd+So7sRLKc=;
 b=XDwpzxT2+Ihudavc0eL71l78U/homboAO4bqPv+FZWNFsoV5rfZNwY1ce1qAVAE9662w0MAaXQfb1m3j7MdX9qr4RbWP2g7e0meyJxO6mj7P+xRdrwKRQ5o1ONxcmjymisTvfQDR0g03q0g89C0mkvwJlM/qle56QUl8TUzWUGdiFXz40xNrhD0sNRQZgj8jjkjnIU9ERmTLlj1VEprAjs3GCr/xBBeM2M/CkvNrY25bgRaMuhLLVvB10rRpLvrCyGKYJLcN1YiQMQBypbU4Y9y+JfEgHfnaEU+pwsPEGbh3PsgFnpkTIyHv5S9k3IE9u6HHVYGlJyhg7eAD3bwPmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Eob1sLKqC1dCgV/riweBbb+upmMNLuhJd+So7sRLKc=;
 b=Cw5O64mQcnOgO3g6+gJeYAb5TSbgwBl4zG1EUgCAm+fX9QoSD8TPEpdN9UUBTztu2LdCgvcznNf/7dzXM3rIZOOOfkdkBUDbvsV2QEFMwdlWYpCjYYUxfu3CORZtjt3cO4C4CUzEWQ5zR29TiVJr4r2u7b/hAKRpjaPyXs858eiNwtN/+MxavMeAdrdKNVhoeE46TggpX4l6L32bW5fXHGsLC3WJ0/sisGQLkpREcBF5/KZYujj6a3BCiOiHkIeHNkAmounAgILWz41Z0Z7N5iMPc0hEDzyUgNuPhF98NGjdNR5ktvmS/1U3QOwkceJ9q7Lb8ykuLId7vKf1DKqh0Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9255.eurprd04.prod.outlook.com (2603:10a6:102:2bb::13)
 by DBBPR04MB7897.eurprd04.prod.outlook.com (2603:10a6:10:1e7::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.12; Thu, 12 Mar
 2026 08:58:03 +0000
Received: from PAXPR04MB9255.eurprd04.prod.outlook.com
 ([fe80::1eb5:3ebc:9f11:f20b]) by PAXPR04MB9255.eurprd04.prod.outlook.com
 ([fe80::1eb5:3ebc:9f11:f20b%4]) with mapi id 15.20.9700.010; Thu, 12 Mar 2026
 08:58:03 +0000
Date: Thu, 12 Mar 2026 16:56:08 +0800
From: Jeff Chen <jeff.chen_1@nxp.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	francesco@dolcini.it, wyatt.hsu@nxp.com, s.hauer@pengutronix.de
Subject: Re: [PATCH v10 00/21] wifi: nxpwifi: create nxpwifi to support
Message-ID: <abJ/qONShVDAuyhI@nxpwireless-Inspiron-14-Plus-7440>
References: <20260305143939.3724868-1-jeff.chen_1@nxp.com>
 <9b0144261da2ce7f5ef0a533928732cc43459e40.camel@sipsolutions.net>
 <abDh2mBYTqbhKz/H@nxpwireless-Inspiron-14-Plus-7440>
 <8ebc201c976f11cce4802e9e34c1f479ee190ac8.camel@sipsolutions.net>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8ebc201c976f11cce4802e9e34c1f479ee190ac8.camel@sipsolutions.net>
X-ClientProxiedBy: FR2P281CA0015.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::25) To PAXPR04MB9255.eurprd04.prod.outlook.com
 (2603:10a6:102:2bb::13)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9255:EE_|DBBPR04MB7897:EE_
X-MS-Office365-Filtering-Correlation-Id: cd29e97f-be9f-408a-8d61-08de8015784f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|52116014|376014|1800799024|366016|22082099003|18002099003|56012099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	odzX8h9CLvga6n6X/3yYJYZCMFI6eaPGMStXndlRlF8+VLL1Dif1RmQs0c6O3rlaB2nznxaAJqrYYoYpVXEsEzR80/qjWTwIDVhhOJ0HfUWG46QmEpFnUHASBjXiY9DOlP++8k5clJVxN1oZtLS2j6ZzJYPdr708UvtmYCp/4LhfDQ9I+9cmXmt/jWs0gN+sIluhLMtUFxuB95azDQ9bkP6TpYDTFJor4SAFNiV3fttBhc7Dw0u6JfbUJoPT0wqfFf+yTBKL3AcHTms5SYM/3XcU7s6LHJXuI40iLrOv3Za1eoUtRTV2wHxe4XnpP70f2j2cKZGuJzzDPkKCBvFQA6mSFhDtUrocFOZM6AImv8wyHB2oUKSa+96j9M8xUmmZ3J7SMsCdjYxbT8A+QsaMijRCdKQQOfItJbR+jOUtLcCsJ/OGUaTZY/S/spXCzw+NWuvfcJ89nVAh4nbV7bIZ+UliXFqyB1MBnHqOR4m5NDVkgKSjJIiz0d7p/tp1OUO3pHINtggI5q5Em2YSzBB14folXhufgg7rujG5VQd6rkPW7h3JGIZb3zyln2c+H8aqdraRpdrJ1gkL0R2gzqPmsZfzhXjGewjOKgDUc6lXrGlKDRV9/YtOalgXKdIFu4qSLh3ZeHmPCx8ke9J0306/RiVGj3mSfayE12JmFaxTDLaBaXe/9cl90onmaXYZcuD/oPZNxTUt4n/MBg+s4PZO2iNfSzNZfPqqmNebojMVawwMUMi+9iva2m1vUht4/c42+i/FtZjldKc7WLA7I3MlKMW6zXhjrnj5+zkrW/+VrJs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9255.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(52116014)(376014)(1800799024)(366016)(22082099003)(18002099003)(56012099003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NzBOcWdsSWVDUWR6YzdUT3hVbjRGa1lRV2xSbGg1RlFaaFZNSEVWNnN1b1Rm?=
 =?utf-8?B?N3pWc1N1RkdDUzI2L3FpSkl6NlFtRUYvVExCNlpzWlhBb01nWE5YWUhwUjBw?=
 =?utf-8?B?c082MUVWajhOanZGT2toa3NPb01yTEdlSHdqMVpCbzFncTZ6SHZSZGNuMy9O?=
 =?utf-8?B?NHlTcmZLNnlvWHFORjVHTHUwR3A1RU9UbldIVmxnOGMyRHEwOER2SWxud05z?=
 =?utf-8?B?cHRzaG5aWXFaUFJpY3JzdEFHZ3dwNmR1TjVWNWRPdC9BOWVmLzJZb0VUUnRD?=
 =?utf-8?B?Y2RTNW9QMFZaS1poMnpucnQ2TDdLbDFBV0NFQlYvM1NzZGZaZ09ZWjNQUTB5?=
 =?utf-8?B?MndUZjZNVFNoTHNjU3JFNFlQK3pVTTYxL1NoN0xscmVYUXBEMmFodkswYzRv?=
 =?utf-8?B?dG5DWXk3RG1OeDVRZERWM0ROb2p2dzUvT09zblg4bVVhOFpaVlp4UEYxemZV?=
 =?utf-8?B?YWkydUY0MnlrUmJ1dXFSNkJjejJqbW44WWJ3UnYrWldjeTBydnNDbUdsbExt?=
 =?utf-8?B?WE5aZG81NEZ2ZUZIQmNSbFd6R2pEUlhYMXdoZGFDQU9lN0lhMFpWQXlwOTQ3?=
 =?utf-8?B?aThPd1ZRdjhhTFVyaTJuem1wcThDRUt5RmpxR2JBRWdIYjZyS2IvN0hnWk1L?=
 =?utf-8?B?eFZRY09tUk9rcVBNUmVWUFo5SE1abWFTYnNlb0M3VVp6K1NtbkRFQ3JGOW5a?=
 =?utf-8?B?aE9TSi9FZkVRVTZ2RmZrVFdrRHZQWGhjb3gzakFxMmJDTzc3elFMQnlONDdR?=
 =?utf-8?B?djRMYkZoNStjQmc4RGY0YVRXVnJUVys0dHNrVERvWDJHK29lTy9GbWlqaEgz?=
 =?utf-8?B?aVBGSWpLRktRRkpUVWFuT0luL2g3ZzdCc3BiYkRKaXBPMitIeTR5a0hidUtN?=
 =?utf-8?B?emZGVmlFNTNxZk1wbVpDUDZmTUlHYnBIRzB2Vm9rM1RCWFVGaERrWlRhUHdn?=
 =?utf-8?B?cEg5UzNFR0k2Mnh5OVZoSDlOa0xDRGE0cFV0RWd4WWY1cktTaTk1ekI4UXNw?=
 =?utf-8?B?Sk43cng4eW5XUFhRNHA3MmduK1hxUldGMVJKa0N0em9CL2ZLeHFDUk9oTWV2?=
 =?utf-8?B?eG15NGUvQ1FGdXhDWEdmNGR1b3lzTjVKOGc2eFpaakRFZVYxRi9lOXZvZFF3?=
 =?utf-8?B?TmNtempoWDkxRGsxTmZBRStwYm8wclJUaEpxUUJiYlNhUVlseCthMk1OSFNX?=
 =?utf-8?B?MVJiVVE1TFZPb01JRGVydGlKL0xvbUplZDNBblE1OUIzdFpvZVJuTC9nZEJs?=
 =?utf-8?B?WnZxZmtJckQrSlNxUGFiR3BncU5MaWJXU01WQWFlcU9aOGdFOU5ONE5BcDZk?=
 =?utf-8?B?ZUFQTnhoSXVoQU81dTk0WXJEeUFNTW5EckRNNXUvdEhlMkVDQ2JHSnNWQlZx?=
 =?utf-8?B?bEpxbnk4MXYycXlQMk02SDJQb2tYcFMySjhzU2pUWXFjcnBuQTF6VTAvUE1N?=
 =?utf-8?B?cVhRTVdLZFlKN2Nrb1lRVDQ1RCtubnFaTnlMdGlWaXlFNW9ZVVB5dmw1VDFP?=
 =?utf-8?B?b0U2NzZCVTkyOURTMlQwTmZ5MWkvT01sN2JqUmRQQVI0YS80WmVZb0dxVGJ1?=
 =?utf-8?B?eTFnODg3RXhGUm9ma2NaL0kwaUhqTG9EWFIzWFpvNlF1aW9HUDlCa3pmbmpz?=
 =?utf-8?B?RkxpSkZqU1JCL2F0UFVtejRlVlJPRi83NFFGclBlMm9yTTBrdmFGVUNidnNM?=
 =?utf-8?B?NHh2TDErMUtjL2JCRDdpbTZlbWZLK3BwRExVNGhsSnRMWGlmU05aTVFpM3Jy?=
 =?utf-8?B?blB2ZFJQMUZzVm8xZWhTMERlcCt2TEV0N0tRL0gzZHo5aGRKTWxyMnlvQnJs?=
 =?utf-8?B?OThSRG9kMG9YelcraFBUT0tDRStQQmljQnhCTEJPak45U011cWVsZHJVaFE5?=
 =?utf-8?B?d1IwTFZEaG11ZWZud21yZ0QvSDZTMXQ5QUMyb2JGQm9PMkhzMFJua3drT0Fa?=
 =?utf-8?B?T243d2lTNHd3cG5UK2xpaW5Hbm4vUk9CN3VsUmVFYXJZY3hCNXMrUkcwb2Ni?=
 =?utf-8?B?TjBydUZjR0pjUmtFR0NscG02UlNRc2JBcGFBYVRCcVp5YXJvTXNWSEw5R1VS?=
 =?utf-8?B?cVRXc1A2Wnc5QkJSeTRZMS9oNlhjbk9yUk5nQXNKRzBUWVA4aXhRZksrOEZi?=
 =?utf-8?B?NFRsVGFtVEFpTUhGN0c4T2lLUElHck5nUWxnR0UzMjFMZFpsZzVnZ1F6RnFj?=
 =?utf-8?B?VDgwZW9tZW5vUVFWdW9GZXdWQ2VuOFhRbjZseTdjV0hrMmllSEtENENlY0No?=
 =?utf-8?B?NDZ2OGczc2c5Y1JwT2xiODB1aWlTckVyQ3RiVXpIWDVsWmlDbVFmazBjTU5R?=
 =?utf-8?B?MzdTL1lxdExUem1mTEMvdUNwUngwZU1uZFhBcGNrWFhlZ1ZMZ3BFQT09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd29e97f-be9f-408a-8d61-08de8015784f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9255.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 08:58:03.7116
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wbjadBH2AFCL3rH+sjpPXsOhD+TNDQH8dBMQgEjIRiyY9B/eeRhqyz5ogNk1hN22BIbuPkYxGDo03QO5lHSr0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7897
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-33073-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.chen_1@nxp.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nxp.com:dkim]
X-Rspamd-Queue-Id: 055A926F551
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 11, 2026 at 08:02:45 AM +0100, Johannes Berg wrote:
> On Wed, 2026-03-11 at 11:30 +0800, Jeff Chen wrote:
> > On Fri, Mar 06, 2026 at 10:19:43 AM +0100, Johannes Berg wrote:
> > > On Thu, 2026-03-05 at 22:39 +0800, Jeff Chen wrote:
> > > > This series adds a new full-MAC Wi-Fi driver `nxpwifi` to support NXP
> > > > IW611/IW612 chip family. These chips are tri-radio single-chip solutions
> > > > with Wi-Fi 6(1x1, 2.4/5 GHz), Bluetooth 5.4, and IEEE 802.15.4.
> > > > Communication with the external host is via SDIO interface. The driver is
> > > > tested on i.MX8M Mini EVK in both STA and AP mode.
> > > 
> > > How exactly was it tested, it doesn't even build ;-)
> > 
> > Hi Johannes,
> > 
> > I’d like to double check whether it was caused by the missing IW61x SDIO IDs in sdio_ids.h:
> > #define SDIO_VENDOR_ID_NXP           0x0471
> > #define SDIO_DEVICE_ID_NXP_IW61X     0x0205
> 
> Probably? I didn't really check too much what the failures were, it's on
> patchwork and you can check yourself. I just briefly checked that it
> wasn't a false report.

Hi Johannes,

Thanks for the clarification.
I checked the patchwork build checks, and the failure is indeed caused by the IW61x SDIO IDs
not being defined.

> > These definitions were not yet in wireless-next around 2026-03-06 when v10 was tested, and
> > only appeared in linux-next after 2026-03-10.
> > Could the build issue you saw be due to these two IDs not being defined at that time?
> 
> Obviously that would be an issue, and they still don't appear in
> wireless-next, which tree do they actually appear in? There's usually
> very little to no cross-tree merging going on before it all hits Linus's
> tree, but it has to build before that happens, so I don't know how you
> expected this to work?

Right, understood. The IW61x SDIO IDs currently appear only in linux-next, not in wireless-next,
and the patchwork build logs confirm the build failure is exactly due to these IDs being
undefined.

For v11, I’ll add a small temporary patch with local fallback #defines (guarded with #ifndef) so
that wireless-next can build independently without relying on any cross-tree merges. I’ll drop
that patch once the IDs reach mainline.

Thanks,
Jeff

