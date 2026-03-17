Return-Path: <linux-wireless+bounces-33335-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6ORODK4auWn5qgEAu9opvQ
	(envelope-from <linux-wireless+bounces-33335-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Mar 2026 10:11:10 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DAC672A6461
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Mar 2026 10:11:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D4D2930364F6
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Mar 2026 09:11:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC1023563C2;
	Tue, 17 Mar 2026 09:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=HOTMAIL.DE header.i=@HOTMAIL.DE header.b="FHP8FNgb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazolkn19010003.outbound.protection.outlook.com [52.103.33.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C206355F41
	for <linux-wireless@vger.kernel.org>; Tue, 17 Mar 2026 09:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.33.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773738667; cv=fail; b=lI9r234TThXPDCHCikQ49va6pY4bNRZhrwT49QirG2M01YO+5XE//G6rJazuae9OGG/eMlnw28VOqJg7cJtPqcN4UdSLFtLdoAVGMwwie4LJpew0v+48hV8c40fqswWxQonWIPMfrX+vl4KvB6fEuwKeu9Q72OMICpHsF9CqU4Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773738667; c=relaxed/simple;
	bh=6UhRTMUGklF7F5Mh9W2FQ42VlLrwb3/mgQilwC1VhpA=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=ZK8eZSw3k3UvL5pHYhKD5uykcTHBY/FBka/gR+ThqimVOe9J+xzHvBBbYmo4dNbfmv3SNSttFkfgA3TNucUZy+pmhNCtNqSVFz29FlBr0ggIxOButF0aNmxSAvQwXDsYSJnyLTx+h8I8ai2YKGXJCx6FCukvV3rm3pqljzvMVr8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.de; spf=pass smtp.mailfrom=hotmail.de; dkim=pass (2048-bit key) header.d=HOTMAIL.DE header.i=@HOTMAIL.DE header.b=FHP8FNgb; arc=fail smtp.client-ip=52.103.33.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QbSTwAAAXUDZ9gDeGLLnQ3RCptxzGg3qSXOoZHEdD9BPDkZlNqeDd1eNGXjn7DyNJPiCSS8TV+5aHfYfDbAhYkJYdiFt+n0x8R9MV7ckCASn0HWB7TpneEETTgfbgW3evvG1ALUyn70Bqs9JUjDdfYLAG/xp5DcGkTQ74qILurSIg6oc85DSWgDfgbm0uT9+9jZDAg9S9DzZyz+fx6bbX5e15GW4BcbHXiOKz0FT0aPYrRj7CSB15uWDJosRVQg1c9oMwo2EPLswrRPQGDRbSg2HL9j/TW9VNxUWBTYnQ7dSh3MEOdv8g5v/5Gy9JtxMex1w+unik4zjcsMDlunXlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Z+WxaiMdTqNfXFlcN18FnhRQdpU9eVb9s4N6qkOCCc=;
 b=yHnot2iIKfQIXIrYB7lnDe3W/x8i61mwaoMp+oCBbI6iacKKtRfNxUlIiUUqJLJzVLukql+9/4EzB/W8maYiy1ko9wUR+m0zFfN4Vu3LIlJ7vNn1F/mhm0zulB5EMn9rntXyZMreeb6CK63VdMeCf9X6cd/SvyD/eCR8GTGffGUW6E3Js9NPuLaWal6iwCyKo7CTEr2AxfG2kBTicxuPKEbtzxKwAtaDaNZla+hznDJ3tEBk2s7nZji7bkBjmicT3gdeOut/VA5cRt5IijC5G1MF465mc0k/ifccse1+T1xTsb65P53csP48kLOlBretrI2zCzzB4I+vxkc+k2xJsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=HOTMAIL.DE;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Z+WxaiMdTqNfXFlcN18FnhRQdpU9eVb9s4N6qkOCCc=;
 b=FHP8FNgbD65Nx8m5IvahLGSDKeTErEm+v09RoRxj3gZgjY1D1w79eaaMt2+58AMgyKamYAWXT1MzElONejJiKNYaKI9bXPLRx/dvBI0eBt3nwP32EwoboO1RWQXlsDViToPCRX/tljVLZiXaJ1MaRGqpb60mNI+JdJ3sY/xd/MseAxdmqmoHOtbS/q9LsC+KEdyiDvwcwh2tMwNViQRLvgegka6QWNCG7P7jGwQMk7/VmWTyViphY92Zu3x9Z46fkP7VXMZQxxsW68FRjTtchL3meT0fPuSV45PmRSHXm1LnJswdnXNyMQ3mwM7DxJQk9WGtb+dEp3kvPR+r4hC1pg==
Received: from AM7PPF5613FA0B6.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20f:fff1::851) by PAXP251MB0579.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:102:284::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.18; Tue, 17 Mar
 2026 09:11:03 +0000
Received: from AM7PPF5613FA0B6.EURP251.PROD.OUTLOOK.COM
 ([fe80::596d:6ad8:b60c:c9eb]) by AM7PPF5613FA0B6.EURP251.PROD.OUTLOOK.COM
 ([fe80::596d:6ad8:b60c:c9eb%4]) with mapi id 15.20.9700.020; Tue, 17 Mar 2026
 09:11:03 +0000
From: iamdevnull <mas-i@hotmail.de>
To: Christian Lamparter <chunkeey@googlemail.com>
Cc: linux-wireless@vger.kernel.org,
	Masi Osmani <mas-i@hotmail.de>
Subject: [PATCH 1/3] carlfw: add stability fixes for AR9170 USB adapters
Date: Tue, 17 Mar 2026 10:11:00 +0100
Message-ID:
 <AM7PPF5613FA0B6784EE6B1CE5A663476329441A@AM7PPF5613FA0B6.EURP251.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.51.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0241.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f5::6) To AM7PPF5613FA0B6.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20f:fff1::851)
X-Microsoft-Original-Message-ID: <20260317091102.23894-1-mas-i@hotmail.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7PPF5613FA0B6:EE_|PAXP251MB0579:EE_
X-MS-Office365-Filtering-Correlation-Id: e3389fbc-c2df-43d7-1d24-08de84051d57
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|51005399006|6090799003|5062599005|5072599009|461199028|41001999006|19110799012|8060799015|13031999003|12121999013|23021999003|15080799012|3412199025|440099028|40105399003|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QmxmZXNXLzdJTDU5T01QTExiZjBCZ3A2Nmt6VmhWRVB5MVlDUkJRbWg5ekl3?=
 =?utf-8?B?TityU2dsYmFKUHFyNUFWRm45VzBlWTY2bkF6eFNYUE9LcDB5aVBURnVtNXBv?=
 =?utf-8?B?NThYN2RLdkFHRGhvaHJ5dDNHMHlXbjA3SXkxYlI1WU9jOFVybmhpSUNiZlZF?=
 =?utf-8?B?UlBnMHAwenRwallHTTV5c0J1VlowdElQbkFrSkMvVHhaUUZnc2JpWDFZMnZG?=
 =?utf-8?B?WS9UZHBXNnBLS1VqS0c0dENoSGtVSkhwSmFiOEdYMjNZNW0yRnFZZmdKKzIy?=
 =?utf-8?B?UmJhTC8yb3p3VWp1NDNQRU0zT29TMzZma1pBaEp2M1QwZFZTMzFhSUs5emQ3?=
 =?utf-8?B?Tjg3ZTZLTkkwaE9BMXl2eEtxWGhVVW9lTThxczNrcnhaS1lVQysyVFpXelBT?=
 =?utf-8?B?M0dSc0F3VkNNYmpsODRDNmh4MDhPQ1VZcGxVdlFLZG9LK0U0OE5FWUVKc3k4?=
 =?utf-8?B?L0oxbjNJaEVRSXpsMTdUN1BNT3pTSXFMc1U4ODlJUGZ6ZkhzUCs2OTRzQVo0?=
 =?utf-8?B?UFNOZWEyaWlWb1Y0Wk1sM2hqWnR5bWN1K084THhnTURTVlZZZ2I2cER6b3ZX?=
 =?utf-8?B?bkZXK2ZaU1JmbWk5eUk2enFSWjA3NzZNU3JUVFFHTWRwcDhQalJVRXZPOE1y?=
 =?utf-8?B?Vy9nQXVMb2NJS3Q1cjdQYWk5V0gzWUV6bmdRbWEvVnMxczFGa09TSTAvdm54?=
 =?utf-8?B?RXdJOU82Q3VYQ0NQUmRtMGxpUWpaZmpodUlqbExvR1FSREo1SXkySnp1YjBk?=
 =?utf-8?B?NGgwOVVFbStzTzg0NFk2cW1iQXBub0ZCZ0F0WlAreTZsVStzREVnNjV0Tjlt?=
 =?utf-8?B?SzdSRDF4clp5VDFmbnYvM3Erc3FjNVorOVkwMGs0NWVUUkJUd1doWU5BZjYw?=
 =?utf-8?B?Nk93MTRmUFRoemNoajhKWVkwYzVTSVBLeVBDbHU4QVJWcFJCcHlBT2EyTmVF?=
 =?utf-8?B?U1FvbGNFanpnZ2NPVTRrQU5WWlNHMVo2VDFZc05Ob0ZQUjlkYVdBRkNHNDRj?=
 =?utf-8?B?M3hManJGWWdLUTU2OWpkbEpHY2FFalJGazJYbmtEMmRSU1JUS0h5SDFuNFFW?=
 =?utf-8?B?WFh2SXk4bktBS0xhNnZwWTB6dWRtdVRjYlhPV3duaWlTcitoT0lOYms5UjZl?=
 =?utf-8?B?N0h5NTJ4SUkvb1poeDZLVUcvMUQyVnRWeE5pUjR1OHgrdTRGcVRKeGlnV2pV?=
 =?utf-8?B?cWx4NXdMVUlLRDJQbGJzbHROZVcxS3dVMnZtZUdOeXJxWjlLck9qbTBXcXpt?=
 =?utf-8?B?QVZQNlo3cWhVNmVoUndDSEJqcHZ4TE1IVnVadVkwd2RGSFIrVVllM05HTDdR?=
 =?utf-8?B?OU10YitxWUN1dlovS2VDWTRoSW5KaVlvZytkL01pcWh4TlVPejdzVmVDZ1Js?=
 =?utf-8?B?R2lCdkFXbWZNVGoxYm9uYVVKZlJUN0xtcC9yTnV3VmdKVGpscjdwUEdIK21L?=
 =?utf-8?B?Uk1rS0JUZ2s5N0Q2OWhmelgyeG5MSVZ1cWVJNUdRPT0=?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NUVDSDFUbSs2a0h5SkRRY1FHVG1HUHhEdFN1Y3I3RGdxYkIwdG1jYUFJMVVJ?=
 =?utf-8?B?dWNKSE5FK0xKNUhFWWFhY0VMMVVQYUdxa3FLMUVhYzRLY0JFcWwwT0FselJn?=
 =?utf-8?B?QytNdTUwYThmTDgvOCtSS3A3QW1MYU5sWHhKTXBaZEFaK0xES0paS3lBeXBh?=
 =?utf-8?B?cGllQy9yNlVVYTBmbWM4WWsvdEErdVlhTWU5eXUySHBNR2tkYTJaZjF5TVk5?=
 =?utf-8?B?cTNLR0sySXpBQ1RwOW9UNHJLaUJNZHhiK0xBNVBoditKb3FpSFgvUkorR2pz?=
 =?utf-8?B?UU1SVWtscHdVaWtoaG1SeWpqQTBleDQwa0JnZm5lQzFrbmxBSzZqTzY1bHpI?=
 =?utf-8?B?dVRCZW1GOXF0WHJoTzJ2anpkbU5xenJnemJyMjZtRCtBdUhMa3QxMzJhY3dx?=
 =?utf-8?B?cEFETUUwMDlKWjNtVEFhSEIzOVM5Q1p2TkMzdGZKdUJrY0k0YlhwWjNuL1VQ?=
 =?utf-8?B?MVlKOUNVOGJtMjAwTEpiOVdmZTgzSXJuUU1KWVE4TjlFeUpyM0hKQk1CY2tF?=
 =?utf-8?B?RXFCUDNqMVdqZEk2TkZCcUR4WnR3MWQ4Nyt1dERBckRDSVZ3STFEWSsvMDk2?=
 =?utf-8?B?MDhjb3l3YkU3dWlvbDBIWjlYQ1U1UzcxbVU2dXlsWCtHQlRCMTBIbmtKSzlZ?=
 =?utf-8?B?R3dUUFAxZU1pY1MwU3d6K0JEOFpnTURUWlVyc01Ia1FWRmx5QnlyQlpQR3I2?=
 =?utf-8?B?TlFEb2lVbXpxRkdpVmZyMlhlSHA1cE9ML0RCWG1yVFJ2ekI1OUF2c2J5Q1Fi?=
 =?utf-8?B?cENLQlNQVEd0R3pRQ0dYeWZpSG1zclhWdUdYZDdnOElvd2JrZmxIQU9zS1ND?=
 =?utf-8?B?by9KUjRtTFZxM29VMTRISmhQRWtCdnJoQUk3bk1zYkxFdWt1dEpQVThzVGIy?=
 =?utf-8?B?cWhZbCs0QjlQS0VSRFpUT1k0LzZNbTVKdmt5Mi9XWGs3NzIxT3BwR0RDbWNY?=
 =?utf-8?B?OEF5RGM2ZSsvOE1VaHZ3ZHZUZ1JQSHo3Q1ZjNHVMNnh5YVh3TE85dEltd2hG?=
 =?utf-8?B?YTRqSFR3KysxNkM4RGFVblZSV1kwT2FTR0taSlMwODhPbmdnU1pGYVVyNnFS?=
 =?utf-8?B?L09PMTI0STZYRXlyem9keWZUSkkrSDdpVnlmNFQvcVJrOFlCcW41VTlCeFg3?=
 =?utf-8?B?REgzVTFnenM1RHR0TWx3THl6UUg1bkREVTZoSFBrbGpoUmYyRDhWUzZiMURL?=
 =?utf-8?B?ZlVVUWltM3N5aFhMcWF5UmRLM250amZtZXI2WGk0MVRscXhBQWpJK0pGVGxG?=
 =?utf-8?B?OTBJN0pJQUJQWkJiSlBCb1ltTHFycTJGTWNOTWxEWkVVUjROVWJnOXUrcFN6?=
 =?utf-8?B?WE1PaFAvV0NaZXZiNHlnS0F0a0g2aHA2TW9GU3NHUHJVVUFGbklkV0cvNndG?=
 =?utf-8?B?NUhZYlhLbVJsNnl2TVNXQjJ0Y0p6VGtUcWU5eEVwSTBqQmVNc0ZVRFVZTFVm?=
 =?utf-8?B?TmlKTyt0Z1J4aDd4bzk4VFRKbytVemhkRjl0K0EzTjBBbzJrekhnTlRLYnZ4?=
 =?utf-8?B?R3hwWkIyMDZ0UDY5TnZKQzFiblJBS2RnL0ZHdS9IMXR5WGFZNWlZNkRzWkdR?=
 =?utf-8?B?WVA2WXdnMGFVWUppeGxCOVRWektUM2RoeXRWMkFFNy8ybmQrblgvU3MzOWp5?=
 =?utf-8?B?VUhTeGRuUTU2bUdCTjZYS0lPVkg5a2pmdGQyOFF1WmdOZHAyU01CMUVST25J?=
 =?utf-8?B?VzcwQTZMMU8xUk5Sc25CbVlIWnpaYy90OGJWSmtzWjV5dlpxakNTc3pUNTZi?=
 =?utf-8?B?aUM4bUN1dXhmb0ljNGp6TGNuZ2VHWWVVWk5iYjlnQ1pscDJ6MzU1Z1BCYWxu?=
 =?utf-8?B?eHVYd3ZVcGJrQW5BS2Rjc2NydGx0cURGNFpQTkR6aDJKbXpVTW04N3BnMUdN?=
 =?utf-8?Q?FxJextBomyCKL?=
X-OriginatorOrg: sct-15-20-9412-3-msonline-outlook-fe3f5.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: e3389fbc-c2df-43d7-1d24-08de84051d57
X-MS-Exchange-CrossTenant-AuthSource: AM7PPF5613FA0B6.EURP251.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 09:11:03.7142
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXP251MB0579
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[hotmail.de,none];
	R_DKIM_ALLOW(-0.20)[HOTMAIL.DE:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-33335-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[googlemail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[HOTMAIL.DE:+];
	FREEMAIL_FROM(0.00)[hotmail.de];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mas-i@hotmail.de,linux-wireless@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,hotmail.de];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[AM7PPF5613FA0B6.EURP251.PROD.OUTLOOK.COM:mid,HOTMAIL.DE:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,hotmail.de:email]
X-Rspamd-Queue-Id: DAC672A6461
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Masi Osmani <mas-i@hotmail.de>

Five targeted fixes for stability issues observed on AR9170 USB hardware
(AVM Fritz!WLAN USB Stick N) during extended operation:

1. cam.c: Add timeout to CAM busy-wait loops. The original infinite
   loops block the entire SH-2 processor if the MAC CAM engine stalls,
   making the firmware unresponsive to USB commands. Add a 10000-cycle
   timeout to prevent firmware lockup.

2. main.c (tally): Use hardware cycle counter AR9170_MAC_REG_CHANNEL_BUSY
   for CCA busy time instead of single-bit polling via AR9170_MAC_BACKOFF_CCA.
   The register is a read-and-clear counter like AR9170_MAC_REG_RX_TOTAL,
   giving accurate channel utilization data to the driver's survey.

3. rf.c: On AGC calibration timeout, disable the baseband via
   AR9170_PHY_ACTIVE_DIS so the driver sees a clean failure instead of
   operating with a half-initialized PHY that produces corrupted frames.

4. wlan.c (RX overrun): Lower the MAC reset threshold from 100% frame
   loss to >50% frame loss. The original check (overruns == total) only
   triggered at complete RX blindness, leaving the adapter nearly
   non-functional at 95% loss without any recovery.

5. wlan.c (PSM wake): After rf_psm() transitions from PHY_OFF to
   PHY_ON, re-trigger TX DMA for queued frames. While the PHY was off,
   hardware could not transmit and DMA trigger bits were consumed
   without effect.

6. wlantx.c: Move wlan_tx_ampdu_reset() after retry queue drain to
   prevent clearing AMPDU state before retransmission completes.

7. usb/main.c: Implement usb_warm_reset() for USB bus reset handling.
   Unlike reboot() which destroys USB PHY state requiring re-plug,
   warm reset preserves the USB connection and jumps to start() for
   full firmware re-init. Includes WLAN MAC, DMA, baseband, and PTA
   reset with BB_WARM_RESET to prevent PHY lockups after repeated
   warm resets.

Tested on AVM Fritz!WLAN N (AR9170, AR9001U) with kernel 6.18.12.

Signed-off-by: Masi Osmani <mas-i@hotmail.de>
---
 carlfw/src/cam.c    | 17 +++++++----
 carlfw/src/main.c   |  7 ++++-
 carlfw/src/rf.c     |  9 ++++++
 carlfw/src/wlan.c   | 33 +++++++++++++++------
 carlfw/src/wlantx.c |  3 +-
 carlfw/usb/main.c   | 63 +++++++++++++++++++++++++++++++++++++++--
 6 files changed, 113 insertions(+), 19 deletions(-)

diff --git a/carlfw/src/cam.c b/carlfw/src/cam.c
index 44cbddd..5273031 100644
--- a/carlfw/src/cam.c
+++ b/carlfw/src/cam.c
@@ -42,31 +42,36 @@ static void enable_cam_user(const uint16_t userId)
 		orl(AR9170_MAC_REG_CAM_ROLL_CALL_TBL_H, (((uint32_t) 1) << (userId - 32)));
 }

+#define CAM_TIMEOUT	10000
+
 static void wait_for_cam_read_ready(void)
 {
-	while ((get(AR9170_MAC_REG_CAM_STATE) & AR9170_MAC_CAM_STATE_READ_PENDING) == 0) {
-		/*
-		 * wait
-		 */
+	unsigned int timeout = CAM_TIMEOUT;
+
+	while (((get(AR9170_MAC_REG_CAM_STATE) & AR9170_MAC_CAM_STATE_READ_PENDING) == 0) &&
+	       timeout--) {
+		/* wait */
 	}
 }

 static void wait_for_cam_write_ready(void)
 {
-	while ((get(AR9170_MAC_REG_CAM_STATE) & AR9170_MAC_CAM_STATE_WRITE_PENDING) == 0) {
-		/*
-		 * wait some more
-		 */
+	unsigned int timeout = CAM_TIMEOUT;
+
+	while (((get(AR9170_MAC_REG_CAM_STATE) & AR9170_MAC_CAM_STATE_WRITE_PENDING) == 0) &&
+	       timeout--) {
+		/* wait */
 	}
 }

 static void HW_CAM_Avail(void)
 {
+	unsigned int timeout = CAM_TIMEOUT;
 	uint32_t tmpValue;

 	do {
 		tmpValue = get(AR9170_MAC_REG_CAM_MODE);
-	} while (tmpValue & AR9170_MAC_CAM_HOST_PENDING);
+	} while ((tmpValue & AR9170_MAC_CAM_HOST_PENDING) && timeout--);
 }

 static void HW_CAM_Write128(const uint32_t address, const uint32_t *data)
diff --git a/carlfw/src/main.c b/carlfw/src/main.c
index 8c13bf8..addc883 100644
--- a/carlfw/src/main.c
+++ b/carlfw/src/main.c
@@ -94,11 +94,16 @@ static void tally_update(void)

 		fw.tally.active += delta;

+		/*
+		 * Use HW cycle counter for CCA busy time instead of
+		 * single-bit polling. AR9170_MAC_REG_CHANNEL_BUSY is
+		 * a read-and-clear counter like AR9170_MAC_REG_RX_TOTAL.
+		 */
+		fw.tally.cca += get(AR9170_MAC_REG_CHANNEL_BUSY);
+
 		boff = get(AR9170_MAC_REG_BACKOFF_STATUS);
 		if (boff & AR9170_MAC_BACKOFF_TX_PE)
 			fw.tally.tx_time += delta;
-		if (boff & AR9170_MAC_BACKOFF_CCA)
-			fw.tally.cca += delta;
 	}
 #endif /* CONFIG_CARL9170FW_RADIO_FUNCTIONS */
 	fw.tally_clock = time;
diff --git a/carlfw/src/rf.c b/carlfw/src/rf.c
index 5e8d3d8..d695742 100644
--- a/carlfw/src/rf.c
+++ b/carlfw/src/rf.c
@@ -190,6 +190,15 @@ static uint32_t rf_init(const uint32_t delta_slope_coeff_exp,

 	ret = AGC_calibration(finiteLoopCount);

+	if (ret) {
+		/*
+		 * Calibration timed out — PHY is in an undefined state.
+		 * Disable baseband so the driver sees a clean failure
+		 * instead of operating with a half-initialized PHY.
+		 */
+		set(AR9170_PHY_REG_ACTIVE, AR9170_PHY_ACTIVE_DIS);
+	}
+
 	set_channel_end();
 	return ret;
 }
diff --git a/carlfw/src/wlan.c b/carlfw/src/wlan.c
index 4e73a2b..7a01b09 100644
--- a/carlfw/src/wlan.c
+++ b/carlfw/src/wlan.c
@@ -77,7 +77,13 @@ static void wlan_check_rx_overrun(void)
 	fw.tally.rx_total += total = get(AR9170_MAC_REG_RX_TOTAL);
 	fw.tally.rx_overrun += overruns = get(AR9170_MAC_REG_RX_OVERRUN);
 	if (unlikely(overruns)) {
-		if (overruns == total) {
+		/*
+		 * Trigger MAC reset when more than half of received
+		 * frames are dropped.  The original check (overruns ==
+		 * total) only fired at 100 % loss, leaving the adapter
+		 * nearly blind at 95 % loss without any recovery.
+		 */
+		if (total && overruns > (total >> 1)) {
 			DBG("RX Overrun");
 			fw.wlan.mac_reset++;
 		}
@@ -100,10 +106,33 @@ static void handle_pretbtt(void)
 	fw.wlan.cab_flush_time = get_clock_counter();

 #ifdef CONFIG_CARL9170FW_RADIO_FUNCTIONS
-	rf_psm();
+	{
+		unsigned int prev_phy_state = fw.phy.state;
+
+		rf_psm();
+
+		/*
+		 * After PSM wake, re-trigger TX DMA for queued frames.
+		 * While the PHY was off, the hardware could not transmit
+		 * and DMA trigger bits were consumed without effect.
+		 */
+		if (prev_phy_state == CARL9170_PHY_OFF &&
+		    fw.phy.state == CARL9170_PHY_ON) {
+			int i;
+			uint32_t trigger = 0;
+
+			for (i = AR9170_TXQ0; i <= AR9170_TXQ_SPECIAL; i++) {
+				if (!queue_empty(&fw.wlan.tx_queue[i]))
+					trigger |= BIT(i);
+			}
+
+			if (trigger)
+				wlan_trigger(trigger);
+		}

-	send_cmd_to_host(4, CARL9170_RSP_PRETBTT, 0x00,
-			 (uint8_t *) &fw.phy.psm.state);
+		send_cmd_to_host(4, CARL9170_RSP_PRETBTT, 0x00,
+				 (uint8_t *) &fw.phy.psm.state);
+	}
 #endif /* CONFIG_CARL9170FW_RADIO_FUNCTIONS */
 }

diff --git a/carlfw/src/wlantx.c b/carlfw/src/wlantx.c
index a8d0952..2db111e 100644
--- a/carlfw/src/wlantx.c
+++ b/carlfw/src/wlantx.c
@@ -471,11 +471,10 @@ void handle_wlan_tx_completion(void)
 			}
 		}

-		wlan_tx_ampdu_reset(i);
-
 		for_each_desc(desc, &fw.wlan.tx_retry)
 			__wlan_tx(desc);

+		wlan_tx_ampdu_reset(i);
 		wlan_tx_ampdu_end(i);
 		if (!queue_empty(&fw.wlan.tx_queue[i]))
 			wlan_trigger(BIT(i));
diff --git a/carlfw/usb/main.c b/carlfw/usb/main.c
index 4199a21..9147c80 100644
--- a/carlfw/usb/main.c
+++ b/carlfw/usb/main.c
@@ -295,6 +295,63 @@ static void disable_watchdog(void)
 	set(AR9170_TIMER_REG_WATCH_DOG, 0xffff);
 }

+/*
+ * Warm reset: re-initialize firmware without destroying USB PHY state.
+ * This allows the host to re-enumerate the device after a USB bus reset
+ * without requiring a physical re-plug.
+ *
+ * Unlike reboot() which calls turn_power_off() and jump_to_bootcode(),
+ * this preserves the USB connection and jumps directly to start().
+ */
+static void __noreturn usb_warm_reset(void)
+{
+	disable_watchdog();
+
+	/* Disable baseband to stop PHY activity */
+	set(AR9170_PHY_REG_ACTIVE, AR9170_PHY_ACTIVE_DIS);
+
+	/* Stop WLAN DMA */
+	set(AR9170_MAC_REG_DMA_TRIGGER, 0);
+
+	/* Stop USB DMA without full power-off */
+	andl(AR9170_USB_REG_DMA_CTL, ~(AR9170_USB_DMA_CTL_ENABLE_TO_DEVICE |
+					AR9170_USB_DMA_CTL_ENABLE_FROM_DEVICE));
+
+	/* Reset PTA component */
+	orl(AR9170_PTA_REG_DMA_MODE_CTRL, AR9170_PTA_DMA_MODE_CTRL_RESET);
+	andl(AR9170_PTA_REG_DMA_MODE_CTRL, ~AR9170_PTA_DMA_MODE_CTRL_RESET);
+
+	/* Reset MAC power state */
+	set(AR9170_MAC_REG_POWER_STATE_CTRL,
+	    AR9170_MAC_POWER_STATE_CTRL_RESET);
+
+	/*
+	 * Hardware reset: WLAN MAC, DMA engine, and baseband.
+	 * Without this, the PHY/RF can lock up after repeated
+	 * warm resets, causing -ETIMEDOUT on register writes
+	 * and cascading driver reloads (phy0 -> phy29 -> crash).
+	 *
+	 * BB_WARM_RESET resets PHY logic while preserving
+	 * calibration-friendly state. start() -> init() will
+	 * reconfigure everything via the driver anyway.
+	 */
+	set(AR9170_PWR_REG_RESET, AR9170_PWR_RESET_COMMIT_RESET_MASK |
+				  AR9170_PWR_RESET_WLAN_MASK |
+				  AR9170_PWR_RESET_DMA_MASK |
+				  AR9170_PWR_RESET_BB_WARM_RESET);
+	set(AR9170_PWR_REG_RESET, 0x0);
+
+	/* Clean DMA memory */
+	memset(&dma_mem, 0, sizeof(dma_mem));
+
+	/* Clear firmware state */
+	memset(&fw, 0, sizeof(fw));
+
+	/* Re-enter firmware from start() which does full init
+	 * and sends CARL9170_RSP_BOOT to the host. */
+	start();
+}
+
 void __noreturn reboot(void)
 {
 	disable_watchdog();
@@ -377,7 +434,7 @@ static void usb_handler(uint8_t usb_interrupt_level1)
 		if (usb_interrupt_level2 & AR9170_USB_INTR_SRC7_USB_RESET) {
 			usb_reset_ack();
 			usb_reset_eps();
-			reboot();
+			usb_warm_reset();
 		}

 		if (usb_interrupt_level2 & AR9170_USB_INTR_SRC7_USB_SUSPEND) {
@@ -409,7 +466,7 @@ static void usb_handler(uint8_t usb_interrupt_level1)
 			fw.suspend_mode = CARL9170_HOST_AWAKE;
 			set(AR9170_USB_REG_WAKE_UP, 0);

-			reboot();
+			usb_warm_reset();
 		}
 	}
 }

