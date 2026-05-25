Return-Path: <linux-wireless+bounces-36881-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4F1CDIU/FGoXLQcAu9opvQ
	(envelope-from <linux-wireless+bounces-36881-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 25 May 2026 14:24:37 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D84C5CA6FC
	for <lists+linux-wireless@lfdr.de>; Mon, 25 May 2026 14:24:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A3DC93004C95
	for <lists+linux-wireless@lfdr.de>; Mon, 25 May 2026 12:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99AFC3806B6;
	Mon, 25 May 2026 12:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="cuNNAQju"
X-Original-To: linux-wireless@vger.kernel.org
Received: from SY8PR01CU002.outbound.protection.outlook.com (mail-australiaeastazolkn19010021.outbound.protection.outlook.com [52.103.72.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E01D30C17E;
	Mon, 25 May 2026 12:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.72.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779711871; cv=fail; b=hU7H3we6zXU7SoWebbnFn1EVLUExiF9b/S1tQbzvn0oE+d9fHNMx34CkOhmtYkj3aB6lrq4gScOXWecjgOL4JJRAECuzylsp2EWmNsfi74R1MJZxW//pg02tp9tnkkSew+5Nb2wp3P8ZWdKaWDr5s9GbLgPYKvqBgcerejw4L3Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779711871; c=relaxed/simple;
	bh=ZZDp7b4Z1RqZXPyycoWj2Iplu1+pOaw+bC46EXTRtrw=;
	h=From:Date:Subject:Content-Type:Message-ID:To:Cc:MIME-Version; b=KJ+4q44BCBDOt8RCejC6dqAFdnNTjapUYlBoQ/QgOiPbOaqgHVTk0hfTg5MLg90noeG6C8spADcZEV63pnXqsAWvuvhzfjM8/btffQpoGTPB1B9/qXveiZDpkqiYcj/CZ6IHrw1CsQGbr9gF/0LIZV0QzsE8WBGk/40RDvWZUSQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=cuNNAQju; arc=fail smtp.client-ip=52.103.72.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W1mB7n6V7baKXewQZESz00ljii0LH/UQuBlJeMitk/xklUrXmIDb9wJJpjiateE4AnAAr7aLKr+q4rKYJb3ORWnBCjOu1dp9D6qWnXucFNP2i7zDLIGeKeNZGq5oEuiF24Gy14n5nMRrHvn6nXmDUicivr6BqDpYVn8Zg28xDflR62U9Hk481fNnYpG7AFMLkZ5gyLtNjnfn6k0G6xchsvR1u9MnJiC28UApyQwpPhJtYFo4Y++B4SaQNA33NPFsw5tEZAOVaRqZjuWn9elsrNpllZ/GvyvWTlLGPj8xVOusMOThedtOcHgaEIkaQM22YPwSSoSQI+14ruZt0MwF2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4LzU9Lo3nd2tda9Sne1CGPUq7co1VPhhaNxm13u7708=;
 b=na8Pd+sd6R0THglqVBe9ottpfQyuZyvHgxObToP9ve9RUhOml4GrhcnQuVA9YCqOK0OxZNQEGUQFoQZLiSWoPdWc7KXEBJVEjXCkEbLXSE3HIMvHiHtFirTIYBpGWDLmbcHXF/Zx348U+I9ukCVG9+MsJuFvs63hOgJdrEhH0mzgcPosHD5LfqmEUTgqOXM2ZOT7sWm5QaIEUSQhnhZVxlf0kt04M8KNo8Kxx4L+QURi+DaG9rPCcpmoh/QJV40zrJQBpzAil7Wd1cTppDPEv+9MhR/3ppD9NkKgOm2iar2qk2jD4wFCUaNLdIyuvsuk9IMhd4cKP4O4USwk9YvGNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4LzU9Lo3nd2tda9Sne1CGPUq7co1VPhhaNxm13u7708=;
 b=cuNNAQju8pElwAwhICGUppPE6gYY5r0HVwT6ba6QhrT/9YVDSyWb/+R2Zo8uo0gnU94YeyA5rSl2po33qS99xXszee2KHTQBi0uECPDoDZgyi0bMatWjPhwUdHYCofQTrvgjUF/X7xLm58XSlEW1oDiRXjGt/gT452yDnGl3J05WhBQdVGnxO318Zp+3MIwis1VTgZuHyFGTaAt5BvjOj63lezlvu3HXsZPOTUp8LX0Dss217GHbuMs0NraFC3oEpNrt7tKwWcbAo4e4B9+B5sttq41ql8/7e54frXA6srhEO5olTk3i9+qX5o6/4EWrkdFtxnMwJqhy05FFLYzAUw==
Received: from SYBPR01MB7881.ausprd01.prod.outlook.com (2603:10c6:10:1b0::5)
 by MEYPR01MB7837.ausprd01.prod.outlook.com (2603:10c6:220:166::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Mon, 25 May
 2026 12:24:24 +0000
Received: from SYBPR01MB7881.ausprd01.prod.outlook.com
 ([fe80::7cd2:d6e8:3fa0:5f0c]) by SYBPR01MB7881.ausprd01.prod.outlook.com
 ([fe80::7cd2:d6e8:3fa0:5f0c%3]) with mapi id 15.21.0048.016; Mon, 25 May 2026
 12:24:24 +0000
From: Junrui Luo <moonafterrain@outlook.com>
Date: Mon, 25 May 2026 20:23:35 +0800
Subject: [PATCH] wifi: iwlwifi: dvm: fix off-by-one in iwl_rx_dispatch
 command index
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID:
 <SYBPR01MB788132C407BF55CD4391C91DAF0A2@SYBPR01MB7881.ausprd01.prod.outlook.com>
X-B4-Tracking: v=1; b=H4sIAEY/FGoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDUyNT3bTMitRi3URjo6SkVCMLcyMDEyWg2oKiVLAEUGl0bG0tALqgWz5
 XAAAA
X-Change-ID: 20260525-fixes-a32bbe287204
To: Miri Korenblit <miriam.rachel.korenblit@intel.com>, 
 Emmanuel Grumbach <emmanuel.grumbach@intel.com>, 
 Wey-Yi Guy <wey-yi.w.guy@intel.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Yuhao Jiang <danisjiang@gmail.com>, stable@vger.kernel.org, 
 Junrui Luo <moonafterrain@outlook.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1976;
 i=moonafterrain@outlook.com; h=from:subject:message-id;
 bh=ZZDp7b4Z1RqZXPyycoWj2Iplu1+pOaw+bC46EXTRtrw=;
 b=owJ4nJvAy8zAJVb4wiKgu++DA+NptSSGLBF7t0hPSdMD+svtpe+4Gczhnvvkn8GLgNyb5+QeZ
 LSZ2J4p/9VRysIgxsUgK6bIcrzg0jcL3y26W3y2JMPMYWUCGcLAxSkAE3kzlZHhi6/ol4n8AnOq
 VcxZjZYHOGmY9+/m9LzMuCP08Yn8yPCXjAwnQ+cFMFkHB+RoPO+r2+c2xeaEfu3ny4eKOhrfnyj
 S2M8HAAdMRvA=
X-Developer-Key: i=moonafterrain@outlook.com; a=openpgp;
 fpr=C770D2F6384DB42DB44CB46371E838508B8EF040
X-ClientProxiedBy: TYCP286CA0372.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:79::20) To SYBPR01MB7881.ausprd01.prod.outlook.com
 (2603:10c6:10:1b0::5)
X-Microsoft-Original-Message-ID:
 <20260525-fixes-v1-1-3b597c1bad38@outlook.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SYBPR01MB7881:EE_|MEYPR01MB7837:EE_
X-MS-Office365-Filtering-Correlation-Id: 535d81e5-83c0-4c35-89b4-08deba588e3f
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|55001999006|15080799012|41001999006|23021999003|19110799012|12121999013|8060799015|5072599009|6090799003|5062599005|24121999003|22091999003|24021099003|51005399006|3412199025|440099028|40105399003|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YWlXNUZNQWdWK0hnVmlLNXJxL0VLNEcrNkg2bkQ5N2ZBN1RidUlWUGRtRGho?=
 =?utf-8?B?ZFFrUEh4cUhvUGl5Y0lPNE9aT1BuZDF1ZENtVlA1SzBYeEx0OWUvc1hXZXdS?=
 =?utf-8?B?eGtjdEhZcVBlTG1helo1NEFWTE0wRUd4TWJGcGNFdkhndnoyTlBFc3lVaWFN?=
 =?utf-8?B?WmJOTWlFSitKUVZ0WkRWSlJpamh2RWlMSGRybm5XRFhETjg4NFVYUWo2c2RK?=
 =?utf-8?B?dHRiWmw4aSthelpXMDUxLzVtQ3ZyakRIUVJpUC9qYk1WcFE1UjMwMkdvUFBM?=
 =?utf-8?B?cjFhN2EySVRUT1BaM1ZuNGR5S2NWSFo1R3QvWHBHTzVxN1EzQnE1QUJhZ0pN?=
 =?utf-8?B?dGZpeXpVa2F4MjFhb25pQ2JLU2RnaXk1QnNiYjZrcHdFL2d5NXRHYXBKRGd6?=
 =?utf-8?B?Tnh2cDl1VWd4NkVOTVJBRmJpWjRSMmpQZ2VTWjQvbkdjWGJjL2RkNzF2aEdI?=
 =?utf-8?B?bW9SVGsvWTMyWXkzUGJYNldyUUExUWswdW5KQUFQSnYyNThPaTlqTHBwbG5r?=
 =?utf-8?B?RlJKdkxOM0w3WlNSVTN2Z1dnZVNLaDRybzYzYkhHRU1JcXpMOXJJSHBiRUly?=
 =?utf-8?B?eGVlaTA0dWtpOXNoUjVrZnlFa0tPdW9aN3BIM21xcjluVG5uMDVZaEhPNnZi?=
 =?utf-8?B?QjdpZnU0SUZ6eVJJenFMeExXS2I5d0JIUmpGb29EUkV0NHgxVWlzbEI2dkpQ?=
 =?utf-8?B?TVh1cEZkcFVUTFVQVEQrMkxQVVV5NUs2T2tVa3RHQXNMMGtuUTk0allEeDhU?=
 =?utf-8?B?ajdNVXA1cWdnN2hJNTBEL0RZSFQ3K21yMmh5cVBYYXVLVzVibDJXUHNCWjF2?=
 =?utf-8?B?YitWczc2VUwwa29mSzg4V0RKNXFyZk02UmNBNkVLSWJlWmw2S2lDOE9lc2Nq?=
 =?utf-8?B?Zk15VnlCU0V6aW1wM3NYZDFOd1NRS28xbWhpWHNkbDBWbU9JY2h4bC9oaTdp?=
 =?utf-8?B?ekNacTV3dFJTWVpVc052VnlnMlBnUkxZMkxuejdhWXBNdlRsZ1kvQjhGY3Nl?=
 =?utf-8?B?NnhxTERKeDBvcGhxQkY3Vmt4d0pyNHUxMXhtZTFSTS9SOFZNRlgzM0x1YW5L?=
 =?utf-8?B?Q1FNdGdsbVBsQ1I0TitzTGU2TnFhc0N5UWx3ZDg5TjVpY1BEUUZiYitKKzVC?=
 =?utf-8?B?alhWUlpNcFdQMmc1NGZJUW1Bb0dvSUF0UWFZdTQySjRNZGhJTkRFODlDbXBp?=
 =?utf-8?B?c3lRYk1IL2l3cHVkZTNBazFmVVBleGwxUWd0RjJZN3oxU1NxVGU3bVhlSi94?=
 =?utf-8?B?cS8vaUhCaU1qRFFSS0VPczVFSnJyTGh1cnJ3elIrUUREOXI3MjgvZlM1eVdw?=
 =?utf-8?B?ZFNzTjREME1xNUpHYnpGREhnNEp0bmtleWpxRW04MzZrbHRXT3FKejhmNmt3?=
 =?utf-8?B?bngwcGNxaDJXUFBZcmJNYmFvZmY3ZFRLMERMaE9DWFZVMWNiRTg5T20yWnY4?=
 =?utf-8?B?cm9FV2pranFhSHlRQjdOMHFEYzdzWWtabFc4eENRaHl5aWZQS2ZuR0lOdXB3?=
 =?utf-8?B?ZDc4ZHpET244Q2JSQlhMK0s2TXRyRXdKRFhkWmFmWGVZZXB6b3JqeVdsYmFC?=
 =?utf-8?Q?BgPnbynFXCHlzpwb1q9qT6w2ylIrn7iB+Duxc5lLz2lwhY?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d3FJRHhFUG45QjB4cys3Yy9vK1VxUTFUU2srTGhpSEFYYWwyUWhTdWcxTSsv?=
 =?utf-8?B?c0NtRUpXcFgydzMxT1FIMkg5Mld5K3JKQThsdjQyVndjN2U5VzlManAwS0U1?=
 =?utf-8?B?UHhZQjBuOXcybmlmZStDUnl3NjdqQmxvMFBtazBuVytmVnVybWRoNENhNklw?=
 =?utf-8?B?VVowcnd3Y3R1WnlBSE5KSkl6aEZTSWNycndRQ2kzM0RrSkxldmNNUGdOOUpF?=
 =?utf-8?B?T2lKay9xUDRCTEtlT1FIQVhSQ1U1NXlXcDF0blFDOForUjF5Q3E0RlBOYnp2?=
 =?utf-8?B?eitlSkt5dy9Ld1cxTVVSd1FLbS82RUdaZ2JQZkVOb2NhWHVhSlhKUkYvKzBK?=
 =?utf-8?B?SXNaZHlSS2Y3ZWRnc1E4aFVINGYrdEo0UWR0QXNNVjh1bjgxc05IQ1VOVGk4?=
 =?utf-8?B?OHM3RU9ma0tVcTRtWmRLZ2wweEppNmVDdkpTZlNzYlU5dUFQbVl4Y3JPZGlM?=
 =?utf-8?B?ei9sUXkwNi8yWm1YOE93SWFTb3FBK3FxMGVSWVNiVkZPNlZRc2c5MmxqYzIx?=
 =?utf-8?B?a0xxeUFmVmtpS29xWjhYKzhiTDlwdXByZ0JKUC85ZGozUTZiQytsNXhsRExX?=
 =?utf-8?B?bnFOOWJPOThaZ2FNb1lLK2l2VW1UZHpzU1dEMXVKVUxMRklhZ0FqQTQ5djJk?=
 =?utf-8?B?SlJTWUJ0b0xyTHBaVkdweWJwL1d0MGFjbkNwVnpyZ1dHYUE2RkpNNWdSQ3c2?=
 =?utf-8?B?aHdQQUkrU3M4dFlmVy9UTWxvckQxeEJoc2pVNUMwbTVOWDNVYWsrR0NIZFZ5?=
 =?utf-8?B?cFJ6VDNVckNneERzNjludUdpWFgydkFOLzcvaWowdUhBdzB3Tlg2dWtaSHJ2?=
 =?utf-8?B?SXRkTk5kamtueU5OM21lTkVHU0ZkQ0ZieWtkMnpMVGtMVHpOVU1RQ2NtKzVP?=
 =?utf-8?B?Slh0bzNIUC9Ra3NSaWc2Y2xWT3Y2RDBJdFRxdVBTMmdYZCtRZGgzdTB3L0xK?=
 =?utf-8?B?NnpZSVRDQ2hZWVdSMWlsdWtxeFVwcm5lL0ljWncvWExwQXgvdGdUL1kzV3gv?=
 =?utf-8?B?dENHMDA4ZUJQbmtkd2hldWs4Z2h5bm9yMWhSeWNjNHRnaGZuZW9uN0NJK1Y1?=
 =?utf-8?B?Ym9uTzNDRFBqbjVhbjZVZGtycldOQzhyaEp2RTcyczlwUnRlaXBhK1k5UDdz?=
 =?utf-8?B?V1hiTDRlek51YTZEbGU3NDU0V0JxTDhoY1pFdlN4TW9mVWtiaVZOYmtGRHVz?=
 =?utf-8?B?T3huMyswY3RtM2hYSmVGenJtaFM4bjM1NGVyL3FFckRZSzM4S2FjQzVSczFs?=
 =?utf-8?B?Qk93ZW14aEpDWWRCdk53MEhxREZaZm1HTGNBQ29rYTkvV0JFR1JNRFdWSnY3?=
 =?utf-8?B?UjZ1c1RhV0F4MFRiS0pXdjdYMnJ2NTl3SHJGZFB3RVg5NTN6UVE2RXVJaUlD?=
 =?utf-8?B?d1RVUHdtOFJWb2VXVG1ta2tPeE1yVFM3NW5tWDRKb2ZETmRvU0VNRm1hdCts?=
 =?utf-8?B?Slhaa1FmLzJYdklqMk9Dd3hiMWNXNGVodGtkUW8yOG4yc2l4b2hQVXFTWXRx?=
 =?utf-8?B?Yk05eFltcng3RERXMk53Yk9WWFNjb2tFYko2dFdMbXplb2d2dXcwM0MxSTBE?=
 =?utf-8?B?NEpHZG9ZNVZscmVsWm5uOEhseVREMGJCczFTbXpxdHFidWNxRUUrU0EzU3o5?=
 =?utf-8?B?VDhzZldpVzRidkptdFFYUnI4VUp1VXZlOCttNXdEUWoxZXYvUzlTdWZrTGtj?=
 =?utf-8?B?Yk5FUmwzZVFJd1RPYTJBWXN5S3N3WnQweE9ZWFljNnlFZVVPOU8vejl1ZG4x?=
 =?utf-8?B?dEgzdmlXR2FaTmxsSFBrd1pOTTlXL2xvaFl3SmNrZkorS2ZmMFUxMnovdzhY?=
 =?utf-8?B?ekV6cFFzd1oxWmJWakNxQmtIYXlmcGd6Vi9ZWjVsS2MwOHNZL3BzVTVLeGxi?=
 =?utf-8?B?U2xBRnVwaVVOemNjNk53ZkVvK0ZMM0h3Rm5jc0EzdHJIUnc9PQ==?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 535d81e5-83c0-4c35-89b4-08deba588e3f
X-MS-Exchange-CrossTenant-AuthSource: SYBPR01MB7881.ausprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2026 12:24:24.4297
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MEYPR01MB7837
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,outlook.com];
	TAGGED_FROM(0.00)[bounces-36881-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[outlook.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FREEMAIL_FROM(0.00)[outlook.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[moonafterrain@outlook.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,outlook.com:email,outlook.com:dkim]
X-Rspamd-Queue-Id: 2D84C5CA6FC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

iwl_rx_dispatch() indexes priv->rx_handlers[] and priv->rx_handlers_stats[]
by pkt->hdr.cmd without bounds checking. Both arrays are declared with
REPLY_MAX (0xff = 255) entries, but pkt->hdr.cmd is a u8 spanning 0..255,
so cmd == 0xff reads and writes one element past the end of each array.

The OOB read on rx_handlers[] lands on the adjacent notif_wait field,
whose ->next pointer is non-NULL after init, causing the function pointer
check to pass and the kernel to call a heap address. The OOB increment on
rx_handlers_stats[] corrupts rf_reset.reset_request_count.

Add a bounds check against ARRAY_SIZE(priv->rx_handlers) before indexing,
so out-of-range commands fall through to the existing debug log branch.

Fixes: 1ab9f6c11b00 ("iwlagn: move the Rx dispatching to the upper layer")
Reported-by: Yuhao Jiang <danisjiang@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Junrui Luo <moonafterrain@outlook.com>
---
 drivers/net/wireless/intel/iwlwifi/dvm/rx.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/dvm/rx.c b/drivers/net/wireless/intel/iwlwifi/dvm/rx.c
index 088302a238de..a5a58cf331d4 100644
--- a/drivers/net/wireless/intel/iwlwifi/dvm/rx.c
+++ b/drivers/net/wireless/intel/iwlwifi/dvm/rx.c
@@ -1008,7 +1008,8 @@ void iwl_rx_dispatch(struct iwl_op_mode *op_mode, struct napi_struct *napi,
 	/* Based on type of command response or notification,
 	 *   handle those that need handling via function in
 	 *   rx_handlers table.  See iwl_setup_rx_handlers() */
-	if (priv->rx_handlers[pkt->hdr.cmd]) {
+	if (pkt->hdr.cmd < ARRAY_SIZE(priv->rx_handlers) &&
+	    priv->rx_handlers[pkt->hdr.cmd]) {
 		priv->rx_handlers_stats[pkt->hdr.cmd]++;
 		priv->rx_handlers[pkt->hdr.cmd](priv, rxb);
 	} else {

---
base-commit: c369299895a591d96745d6492d4888259b004a9e
change-id: 20260525-fixes-a32bbe287204

Best regards,
-- 
Junrui Luo <moonafterrain@outlook.com>


