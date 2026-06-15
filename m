Return-Path: <linux-wireless+bounces-37802-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id C/reHZalL2rfDwUAu9opvQ
	(envelope-from <linux-wireless+bounces-37802-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Jun 2026 09:11:18 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C8E16840DD
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Jun 2026 09:11:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=nxp.com header.s=selector1 header.b=VpS1yCO7;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37802-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37802-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=nxp.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 51CCB3003806
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Jun 2026 07:11:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AA7B1D8E01;
	Mon, 15 Jun 2026 07:11:14 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013053.outbound.protection.outlook.com [40.107.162.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 169F013AA2D;
	Mon, 15 Jun 2026 07:11:12 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781507474; cv=fail; b=pbhMZmk9GObmIu5d5/0X7ucC2LiOSROSZak3oWzneF4/Y2Y+Ss1Lf7/rdBZVAN4LTT5DWl1Jm7QWNfTZR8+EqSAW5Ch1NmVjEYBvJ7wZy6Ea2tEJ3s7FfVV/m2PqcDPusq+cW5Maua5+zueemkeAetCK1+Xib42K/jKZTx7hMWc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781507474; c=relaxed/simple;
	bh=0FBuA9IYWuOkyANE6C6cb9CCI2f4rdHwP2DHpHlXfsg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Z2fjtBYvJIvjtUdrau0vagjYBNNutJzfxTwpAsooVO2VUsMPLngfHqjwQcvW9yeUX7Jth843NS5i5pZlSXnizXXltq2RvxdXNRIpSHBU7AVokhbgmtrZKyl0f60mHBylJF323CQ4mCDTP2jKnMOUP0rYdkzIDEwA5aMO8muOL4o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=VpS1yCO7; arc=fail smtp.client-ip=40.107.162.53
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W2auz7EdNZY6ylZtC7bto0jCa6XjP03tqiG6+TSGhe6nIRA+hK/1wU9woLAGx/p84PsIQzrKsVJ/n5VACtDaERdWarCvZt7sqMFIA2QQiqnPi2UZUP0nTQFCZJx5cJx2m7/rod/hxnyhFH+AqgdBGIzGJ8+KPgKEjG7SICs8bpep0ZV9R0Y44Ji9rEzaGV7GYzF1ITvAsOaT5SPmAK00ZBUoKz7nAwbjw3ylcWWuxZ+KgcTJmiPp6K0kfR1orMij3yIMOh2ASQER/HQW/qu9CB40I2nPSROZGI9PAsQdkhoYVdunJ+7l6vDDvWw3aD3wAyU4Hm+Btx0SOM67mloTrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+XbbzzYjlPOaKG8U/6hpFiGljpTOJlMphjibu2IP1mQ=;
 b=w5PkzPT72cKNnGOA/vrdTVN9jet3yjel4fsju3bT3juzhdCju/HxKRUDcKIQOyLNM+9FUQkeBTEVL56NG3rVRgy0cICMVutiq7MPgqMr1ECUSjSJvq9s/Hgs+RKrfE1TZg82TzPSly7d/miHf2KfaKpqSYiRT/Ahq+f3pQAR/8j1gftQSxI/bLc6Kcm8wDzy21qtVq51ldES4/woWC/OTL9+eBT19/0ZBjzKQYOH/1cdJDe3dytq5i1sy70dr3uQ4hYRr1uw6bnJjmK08LuPg1r0MfHF5I8gIkSMik/dYuKFMI7UROUja+63IuyWlv0cCxXNcuYEWRxE77+L82T4XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+XbbzzYjlPOaKG8U/6hpFiGljpTOJlMphjibu2IP1mQ=;
 b=VpS1yCO7baHE5MFMaLGzpBzRNqZZLMqP9D0wIzVpzwxwtKEUUND+0j8XUJhFT7Jyo02q8qqcd7V22ypXIsOrfnfH4o6OUyiGvc64SD23ZlNm2SDDMLZgGk2msm4yJtf3bewSaSog8yBlnfnnwsxqBfI+RizMdgZVu+K7kQ8kRyi5uaaHmMBVIBNJicmcCGl7iYgiKTdfFJxAIMu22BTtrhel7ziAmUuD7vM2s0ayCH2HnYNL59mqxZDCuKgCg2Q2G0UDD2SdhuNA1fZPm6JUvAWWzlbnUuYjTnLPYzHX1lXfDLahKQ1Ees1wKCBVtbHqUizWnlcL2wvg7VqABTVcRg==
Received: from AM6PR04MB5239.eurprd04.prod.outlook.com (2603:10a6:20b:7::12)
 by VI0PR04MB10688.eurprd04.prod.outlook.com (2603:10a6:800:25c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Mon, 15 Jun
 2026 07:11:09 +0000
Received: from AM6PR04MB5239.eurprd04.prod.outlook.com
 ([fe80::fa76:ead:9e21:f84e]) by AM6PR04MB5239.eurprd04.prod.outlook.com
 ([fe80::fa76:ead:9e21:f84e%6]) with mapi id 15.21.0113.015; Mon, 15 Jun 2026
 07:11:09 +0000
Date: Mon, 15 Jun 2026 15:11:24 +0800
From: Jeff Chen <jeff.chen_1@nxp.com>
To: Rafael Beims <rafael@beims.me>
Cc: Brian Norris <briannorris@chromium.org>,
	Francesco Dolcini <francesco@dolcini.it>,
	Rafael Beims <rafael.beims@toradex.com>,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH wireless-next v1] wifi: mwifiex: fix permanently busy
 scans after multiple roam iterations
Message-ID: <ai+lnN/mjS0mycdV@nxpwireless-Inspiron-14-Plus-7440>
References: <20260612122547.1586872-2-rafael@beims.me>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260612122547.1586872-2-rafael@beims.me>
X-ClientProxiedBy: FR4P281CA0046.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cc::9) To AM6PR04MB5239.eurprd04.prod.outlook.com
 (2603:10a6:20b:7::12)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB5239:EE_|VI0PR04MB10688:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f930191-c7e7-4f00-4f12-08decaad4672
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|376014|52116014|366016|1800799024|23010399003|19092799006|56012099006|11063799006|3023799007|22082099003|38350700014|18002099003;
X-Microsoft-Antispam-Message-Info:
 K/BRxEohbu54QRcr6MOjGxvJNMn0+Uuq38e7o748jDZc7ST3jtHBM5i11/i1hz6oIKgqGhZqoP1aSBO1TEvMnBRsR2MpK4jTSb7jOECNiKE49hn0RDS3DIY5T1U+kKpVft6AgNSO/PiZmNO+QBbpYLXJYgj1SbNPdI2x1fwZXUT7sC5Gliu7u8InfeBZL1x/CSc1EYRvFM80W3hC2zb5szPlyoQusKprMZZCefjD1Nux0qFuIhHo2IqoGOgU4owNk2daNokdDUoBf/DyZ6sjvIjTOYAj9sAlLqZJm6piOF4wi7ZIPwAbGISgzRyw3VPq8i0Cv2oAR9ZT9ukmg9/OshU+viNVR9qhMpV3/Vy7UkocNVIwnVhypu531mMU0iR4+vp/qaTLtgztZMqrkMUzE0pKgloZNP7TcmA61+YFUo2REzO3UvT+0R/FPIK3/UccXuT6DMA+9hbL7taY2i8Ha+Fs4zu9DUYFN83neyICimwoyVk/M7eErvonceEnpWMkgT3GvvQEfPWVET8B43QHMugFTmjvxwFESPoUnbOB+J89teD2bDeVbqTJJDiKU0rI7EaF9pcykhVicAJd4u2twFxcAgsi6Il5wDqkAgFJSFmZFEYRmDmjy9ZlLNrWV0BKwy1cAdQKZ/m9kftcqeOWIXr+5O4TDseo/gGO6+xC2b0fsYglYPXNaAG1fSNaqP6CB1u+vfw8YInFBN74cTSG/9LFQFJC3IJbrcL61HXvc3qDFmN8J6qCrAzVP46OaH+w
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5239.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(23010399003)(19092799006)(56012099006)(11063799006)(3023799007)(22082099003)(38350700014)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?dmtnaHAzWGVsdnUzZnhaWjBmU3NraXN1eEhqVXA3Y3BKZ1RNcFdFakFLQU8x?=
 =?utf-8?B?ZXh5MWUvK2VmRlQ2M0NKMVBmL0FRbGtQbW9SZ0cra0tyd2tKY21RRG1DdDdJ?=
 =?utf-8?B?NlEySGlmZ1hhUTR2NEd1S0gxSXFONm4wRW1LaElSQ2xpaS92alRaTUVyazVl?=
 =?utf-8?B?UTQ0UHFBRWR3T1hNR0EzK25ZUXE4L044SDNPTGkwT2t2VnMra3NXT0Qwc0NX?=
 =?utf-8?B?TE5XV0ZZcXgrSDdZYnJ4NkNNcHl3c0RoTzFzYW1OR3h1RksvakpnSTN2NTRU?=
 =?utf-8?B?clFvMmkxZkNNa3hIUmRXV0xKVnlxNUczanFnOGdWL2RKbGMyUmR2OFFrZ3RS?=
 =?utf-8?B?Z2FmTjhVMkJ5WmkrQXh4Y2ZBSmQvVmIvMTdXVVNNK2tubnJiSmFZVUZDM2k2?=
 =?utf-8?B?TEVDOHpCbDFOdThNSmdvSWZhQmhNNDl0MUpUakhuM0M2YXkyelZiMVhXOUlR?=
 =?utf-8?B?bmI0QnF3L2JZYlhBM2JoNlJndlVCeUZYQmtvM09vY0NlMWd3T29pQ0JUaDNl?=
 =?utf-8?B?SlBVYWVJQzc3djcrSFMwbXlqbDBTaUxlRTdDeUlQSXNLNVlrUEdRTUlab0Vx?=
 =?utf-8?B?eW40MEJadGtZVm9HNTNERE52cEQ0L3RuQzFBNGlHaVhlMlkrQkRnT0thSHJx?=
 =?utf-8?B?RHVOS0grWHhWNWNtcFYzVDRHZ2VuaWxKRFlBTWxhYy9QMkNaUnk0RWRGc0lI?=
 =?utf-8?B?djZpMVVaai9PcldMdGNLNVBjVWNVU0ZkdnNPSUEvMjQ2NXh5VTNlRENMKzAw?=
 =?utf-8?B?MGZQcCtzcERKSkowNHlSM1JFN3pOYjRKQlpSTTVIOTRTNXdqQkdyMkJUemh6?=
 =?utf-8?B?VXM1MEg0SG9pNVNLZ2JXTXRoWDlxS0pIc21GVGh1ejMwMlY4SHdidFA3RjVH?=
 =?utf-8?B?NzZKcTJuSHZLRGZjd0VUam5wRUVMVzZCckY4S3RYSVNCUkEyeWcrSjAwVXZQ?=
 =?utf-8?B?UmQ3cmVNVjhpQjVIenpadE9OQnpZQ1FTUWxDMFozbVB1SE5RL0g1cThjZHlD?=
 =?utf-8?B?Y09ZKzdRcy9IZ0lreGlybzdHVmh2c1F5ZWwweDhjbGllQnFDMDhWM0tyTzNa?=
 =?utf-8?B?MGhmQ2lpNTdYVy9GcGRBeEM1dHpMaUI3QWRiaENFbm9zVnhteElmaFJIclA4?=
 =?utf-8?B?Qk5JQXBBOEZva2l4ZW8xVlJkeXU5ZlZEOUFLUEViQ1pwdkRnS3B4QzN6dk1n?=
 =?utf-8?B?V1VoVUdNNVRscWxkaGFnbm56cmIyZDdjbVVtRU1KRkUvM0Q5TmV4VGRvNlpE?=
 =?utf-8?B?dFRXak5BM3FqZkdBTE5sWVdNYW9KMlZLRHVMam1Xend3SG10M3Y5V241Tzhm?=
 =?utf-8?B?Sm11d1Y1eXlPN0pmTDU2YlpFdkFQdFF6ZDRIYnZnemxLemZhdUtZc1UyQ2pt?=
 =?utf-8?B?R1doNTJRS3JEMUI5VlRnakwyRW1nZURzUit4cXZFMy9tMUFQTGZsYUVzMGlk?=
 =?utf-8?B?eTAxdnVxQXZTQU52MmlFQm5TeTB1aUFZdUtRYzNIMDFZNWVXbm1ReTE2Zmpm?=
 =?utf-8?B?bkkyNjh4ZWNQdng5TytGNHRUcEJBWi9DZjJqdlBJOHgvTy9sa0tyMzhrb2hx?=
 =?utf-8?B?NEgvcUttNWR0TFZ2UkxubWowN2h4WXFjdGFPSXlQV2JnY2ZCUmppT2tlN2U4?=
 =?utf-8?B?YXdJbWlCZDh4eXJBenFZTlZPeFdSbUxHTzl0VnpCaks2MWRGTUdkVm85am8x?=
 =?utf-8?B?UmZBYnhYYXh5cWZTUEdoYm9PTjBxWXoyakw3UEtqVFkzQXNnbXVQMUdBRzc0?=
 =?utf-8?B?b1YxQysvWVdwdlJadFZVL09hNjAzaEExQWtQdVpsYTZQeFZrT2JWV0IwU2l0?=
 =?utf-8?B?c0V2Z2FPbTlwTWxObGhpZkJSdXhhZ3NCT1ZPanZOYzByWnM3T2pETm5WUEZT?=
 =?utf-8?B?SGVva0hFMmhEYUsvMVdsdU50YmVIODBJa2xwTzUxY1c4aGpmODdYNjR1TGE4?=
 =?utf-8?B?bDVpR0x4RkNvNnkzLzNLa0tIUWVQWFdNWUVkbzFSc0hTQlVSbExCaDFtT2lU?=
 =?utf-8?B?bTArMmdWZTk1TTVha2pOeGxpZGNuR3o2MkdHdlFCU21Wc2lTSDI4ZTQrSWVC?=
 =?utf-8?B?K2toTmJEd2lZYXZzVlJsd1JPQWtyTXJ0U042aWw4aEpiUG15bFNaUVZraXBT?=
 =?utf-8?B?L0Jva29hTXQ2NXM3VGZZbnVJbTkrRm9FeTFkSEdJVkpPK0RvL0FIYkh6azNo?=
 =?utf-8?B?aG5sdU1MUGtweURCaGIycXdsOThTRXJnUWdxNndEZ1JPTWp6ZS81V0ZlTGdZ?=
 =?utf-8?B?ZER6aE9ZN0hObW82bUIrS2toeUhCMDBBaDV2clFBUzYvenk2N24xZWphVmIz?=
 =?utf-8?B?Ti9mTXFxYXNXZUw3cXF5b0Q4dTltOHNrM0hUQjI2T2NpTU5lNWxNQT09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f930191-c7e7-4f00-4f12-08decaad4672
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5239.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 07:11:09.6886
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fVkYY+Xkj1fuXyCruTHAO15H10ZbZ/dpHFtpBMYZITzS2VOdrHFS7rbzSnQ7s1VT31YAymWBW4k8m98dv6yjbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10688
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-37802-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[jeff.chen_1@nxp.com,linux-wireless@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:rafael@beims.me,m:briannorris@chromium.org,m:francesco@dolcini.it,m:rafael.beims@toradex.com,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.chen_1@nxp.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp,toradex.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0C8E16840DD

On Fri, Jun 12, 2026 at 09:25:46 AM -0300, Rafael Beims wrote:
> From: Rafael Beims <rafael.beims@toradex.com>
> 
> In order for the firmware to sleep, the driver has to confirm a
> previously received sleep request. The normal sequence of evets goes
> like this:
> EVENT_SLEEP -> adapter->ps_state = PS_STATE_PRE_SLEEP -> sleep-confirm
> -> SLEEP -> EVENT_AWAKE -> AWAKE.
> Before sending the sleep-confirm command, the driver must make sure
> there are no commands either running or waiting to be completed.
> 
> mwifiex_ret_802_11_associate() unconditionally sets
> ps_state = PS_STATE_AWAKE when it processes the association command
> response, outside of the normal powersave management flow. If
> EVENT_SLEEP arrives while the association command is in flight,
> ps_state is PRE_SLEEP when the association command response is parsed,
> and the forced AWAKE overwrites it. The deferred sleep-confirm is
> never sent.
> 

Hi Rafael,
Thanks for the clear analysis.
Agreed with the fix — association response handling shouldn’t override ps_state.
For reference, the NXP downstream driver also doesn’t update ps_state in the
association response path, so this is consistent.

Reviewed-by: Jeff Chen <jeff.chen_1@nxp.com>

