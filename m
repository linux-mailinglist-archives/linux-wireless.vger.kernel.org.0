Return-Path: <linux-wireless+bounces-31728-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ABSQH7pJjGmJkgAAu9opvQ
	(envelope-from <linux-wireless+bounces-31728-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Feb 2026 10:19:54 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FB1E122A66
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Feb 2026 10:19:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5A31230214D6
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Feb 2026 09:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3F49332917;
	Wed, 11 Feb 2026 09:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="XObd+BWZ";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="pgPdLNVR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C14F535505A;
	Wed, 11 Feb 2026 09:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770801565; cv=fail; b=r5wCimj+R1lROjGQFsK5a4Z6pvrpopSwG8f9Seb+ezEqQTKTrH6EpveQu8Qwl168FrFJjWeAc6rQ84vV7Q7JLisZMctifr5/siUiBK5chPsdV/cPZmTYYesntt3JdFRaPJWyEplMG3nCobrBAcBHx7fBa1bESnfGi4rxmJyoUHc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770801565; c=relaxed/simple;
	bh=SmIQnl2+DDFiLntL7b7pauBJ44AUIOTtRDtS/691oNk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UhsXGX2C3njZ7M2GHU2yFrE1N1HRkr176aR6dncxTC7L8jJyv2J/9v4TiGLXUFoo2uymQK+PdxhkkTSzM/fy0Z6JpfXg513lQMPjpRbDRU1hVecuBc9aB3pkK/EoeaPWPzMIBD8J3qZj4MPqasOjJHWepUmN0wVBwP1Ld1s3tO4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=XObd+BWZ; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=pgPdLNVR; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: bd20df28072a11f1b7fc4fdb8733b2bc-20260211
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=SmIQnl2+DDFiLntL7b7pauBJ44AUIOTtRDtS/691oNk=;
	b=XObd+BWZK3QD2ChHt4ajQsxXqWAt9sd/mBEGcJkxYpYLPW3PYyOgIIWmRVO00C4T8wvEfCDtXH5xc6B7eqPT1bMLJM5DbOb/mwYK66YOT8DZH2RlRPDoxtRM2Mn78JGITYGex/YUrQqw7edfQcwRQqovSRDUiaJk9X4iBenUMgM=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.11,REQID:6d8c2f46-1dc0-4a57-888c-075e03f8b5e8,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:89c9d04,CLOUDID:6efd2d5b-a957-4259-bcca-d3af718d7034,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111|836|888|898,
	TC:-5,Content:0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BE
	C:-1,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: bd20df28072a11f1b7fc4fdb8733b2bc-20260211
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw02.mediatek.com
	(envelope-from <ryder.lee@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1881405942; Wed, 11 Feb 2026 17:19:16 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 11 Feb 2026 17:19:15 +0800
Received: from SG2PR04CU010.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Wed, 11 Feb 2026 17:19:15 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eCU7VTGVkMwLxMDQmTccE9sf8UtlkFRztLtkrR4iIDNn+eGphbHU3UkR7yKoQQf5Jt4aUhjdXnCWgYEPYjrDJiIxVzcJC/R1h+BhLAtywGqeYZWnru7vUXFiu3rUqrsq7pjNgSUk1Rpf5bk/e60ncRUBoEbKUHzWYhdE3+SD/e1rqzjHFyBl0wLwYKIUn4Z7VzBxG6rYq/OhgX5FZMGVPc7vlngoABcpWnwWX1hV6tZwy4/9LGX+yQXfip0YCPdGRj8lzYL+k732ZvgTJmgFFXBltyVFtHvP7ZwAzVwA/zrj6mqLCu1ywATojXuf7J2fYORoYwtJmuuggFBA6rf3gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SmIQnl2+DDFiLntL7b7pauBJ44AUIOTtRDtS/691oNk=;
 b=qxn/gts1/fvxzaTcL/IcPUGnM+/kvCOP3Oa8yaxsbTjSGbUpWaHxRSJijpQCmGJfZABdVa9bcL4h+vKlKP2n3VdNJOO9rYw1Om5WmTfrRvoTF+ujyFFcz/pGJ0DZRd2NuMJTClvVXFA7o0rGnCeOysIpACWJvumpX7rCiC3rnKcpW8nsp16d30iEPXi6MkWR+ye0sqaW+66hoRT0zCOSOnDpa8RgMT8eIbj15VnBxc5ey7Lk16xNToKId0FBGogEz5SYg86hzF302rt7ZclzVq8YckN1UfeADV1WsTAkVd9LaFi1hlyg5RLrIyMeicACoRO37+1GY5CRk/dzd+6yfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SmIQnl2+DDFiLntL7b7pauBJ44AUIOTtRDtS/691oNk=;
 b=pgPdLNVRqQ5791hW/joDuWeCxUhbdTlkxTQ6L875wNx6OXQNTdOiDAaw5EDEeYJGKrobqC4f/Rp5zNyE6PxvBu7akbSwNCoRM9Eeht0dR4TQ4xTtLPTbFfAZYugU/1YJSvUvSjBZUKpDIqrbo80z07GwLvtxkYkYivzLgd3gY1g=
Received: from TY0PR03MB6354.apcprd03.prod.outlook.com (2603:1096:400:14a::9)
 by TYSPR03MB8720.apcprd03.prod.outlook.com (2603:1096:405:91::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Wed, 11 Feb
 2026 09:19:09 +0000
Received: from TY0PR03MB6354.apcprd03.prod.outlook.com
 ([fe80::f429:d36c:b36b:a059]) by TY0PR03MB6354.apcprd03.prod.outlook.com
 ([fe80::f429:d36c:b36b:a059%3]) with mapi id 15.20.9587.017; Wed, 11 Feb 2026
 09:19:09 +0000
From: Ryder Lee <Ryder.Lee@mediatek.com>
To: "krzk@kernel.org" <krzk@kernel.org>
CC: "robh@kernel.org" <robh@kernel.org>, "nbd@nbd.name" <nbd@nbd.name>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	=?utf-8?B?QWxsZW4gWWUgKOiRieiKt+WLsyk=?= <Allen.Ye@mediatek.com>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v3 2/2] dt-bindings: net: wireless: mt76: clarify backoff
 limit format
Thread-Topic: [PATCH v3 2/2] dt-bindings: net: wireless: mt76: clarify backoff
 limit format
Thread-Index: AQHcmrhfdLixNmzm402cr6hZjqmOB7V9Cq4AgAAcbICAAAELgIAABKcAgAACKQCAAAUHAIAAAmwAgAADGgA=
Date: Wed, 11 Feb 2026 09:19:09 +0000
Message-ID: <0c7b854e342e2047fbc9fc8e8fd80b67a6ec2bec.camel@mediatek.com>
References: <8fa8ec500b3d4de7b1966c6887f1dfbe5c46a54c.1770746444.git.ryder.lee@mediatek.com>
	 <69521aebefef405bad5117d4d5d5fef4a5dfb7e8.1770746444.git.ryder.lee@mediatek.com>
	 <20260211-miniature-chital-of-plenty-1a71df@quoll>
	 <bd4da0a8522db2991ec0844233efe068323c2578.camel@mediatek.com>
	 <b00c8c18-930b-4cb9-975d-b15118bfc854@kernel.org>
	 <0dceffe2e1344830c12bc1f6516d13c7bb488b99.camel@mediatek.com>
	 <23561f00-9f3f-4d4d-81ae-aab9958bd797@kernel.org>
	 <0572bd6e56ca872e285729ccd4c2201517b66e18.camel@mediatek.com>
	 <388e874d-d9ff-43f2-b010-ca7ac29aa065@kernel.org>
In-Reply-To: <388e874d-d9ff-43f2-b010-ca7ac29aa065@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY0PR03MB6354:EE_|TYSPR03MB8720:EE_
x-ms-office365-filtering-correlation-id: 8a1fd03f-c905-4308-ddd2-08de694e9cd0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?U3lFTGUyTWhCMzJacndQakhZcnhidzNsME94T3c3cjhJQU5maFhGOVhhalNx?=
 =?utf-8?B?SFF1ZlF3dFAvMDBwZ2xGU1hlMWJ6NjFPZEpnK0ltYVhKaUpOeGVSZU96dCtu?=
 =?utf-8?B?czNJRlowdG1OQW14U0dzSXExU2VzN0R6TGtDUFlsVTV1bFFHVURxcG5QcDF5?=
 =?utf-8?B?YVJMOXpwN3pIQjBKZ3dZdElJaHk3NkFISEtlSk9OZ0FpV0FUTFR4T3QwS0Js?=
 =?utf-8?B?T2p3UnFhckVkbkcyWHdFcmJjQllSb0RHUkVxQzI5ZmlSUzVuNERObjNUUElR?=
 =?utf-8?B?S0lKNVZITUcydExQMFZjYTIxTGVzMWQ3ZmxEeFBOb09iSVdyYk9vd09FbXFw?=
 =?utf-8?B?eU8rSGRrRUhCU2lxck5ySSt6Zy83b3BLMVg5WkFqYk5BaEJic3IvbXh5R0gz?=
 =?utf-8?B?dnpHQW9HWk1jV3BFTUR3c2VVaTdGQXNSb3g3V2NHdml1VHZxRFRaR08zWi9n?=
 =?utf-8?B?UDd6WTFpQmd5cmJWOWdFTnlSN3crL0RWNFNKVG5jWGJxWndwa3NMeWZpSUQr?=
 =?utf-8?B?ejJoL1hwR0Z4MzlaTSs4SDZUeFpQVUR6RVd1SUVjMUhTVHlOWkZQYjROZHVa?=
 =?utf-8?B?Y3piTUNUK1pzYmVLbnZPSXptOWZtY0RHL0Z2aEl4TjRrRVErSmI2Z253V0FE?=
 =?utf-8?B?djVyTE51QmlqTVM0dEpYNUFKa1UzVUZwZitRUVJkc0RsdWV1NjBZVXk0MHpq?=
 =?utf-8?B?cnJaZnk1cmhnUVpWSmdET1M5RVN6ZE8zYjhvNTBaeXJuWkF2VVpOd0Zad0hG?=
 =?utf-8?B?Ym8yVU45S3Y5VTNnVW5aU1Y3djFRbFRSc3k3QnBwYi9uTGJ0TUlOTGNCTnRH?=
 =?utf-8?B?K3BLcGtSZitKdGhLZzB2V3l6cE16K3U3TlBJOWZhaFNSek9EalJmbjNkM2p1?=
 =?utf-8?B?UHlHVjZZMGxGN2duUUwzTUlyMUxyOUFJSjZid243SEIvZU0raVBzcVhBTkdR?=
 =?utf-8?B?S1Zta2tnVmR2dHFZUW1wcFdZcHl6QzB5eWhXbG11OGw0aHFjTXZNODRjTWlD?=
 =?utf-8?B?WHJGMzJXSGp3YWdrVnN1WXZHNlA2M0lEekEyZnBrY3VCWkNTZWM3TEpkcEJx?=
 =?utf-8?B?Vnp3Nk1ESVFRVDlSNGFIREdrM1JsakR1bzA2YlYxRzRhWTI5Mnh5WGswN1NE?=
 =?utf-8?B?K2Y2QzZlRFQ2a3UrcVE2cUFha0tiZk1rWlVGb2h6b2FqK3ozMGMzNE9ESlhJ?=
 =?utf-8?B?TW9Ud3RmMkN5akdvSzBpY2VMb0RuNW5MeEx4cWRlOHBPTkVic3ZIa1RYUmJK?=
 =?utf-8?B?Q0hET3lXbDZxN1pwNnF1RG1IZWd6Mml1emM5b2M0Q2VkOFFLb3R1eHBXQVNo?=
 =?utf-8?B?dmVmNzRGd0hDaDVLK3graWtncWV6YnMvc0JiS3krWTlsTEtuY3FGc2V1OHJP?=
 =?utf-8?B?Q1REb2RnLy90RkdtZmJPVkpvRlUyMCtVTkVIa256YlNJUWhFMWwrQldLdFNJ?=
 =?utf-8?B?TEJISE0wbEc5MGNOVzhEb0JHNklzZWZ6Z3NIYmxOZW5YUmhLZGg0ZXlDZStW?=
 =?utf-8?B?aUtkTExWSE5mVlErRFdMY0EvNnlrZitmVWx3YktzOVFwZFNHYWFBVjRyOHFO?=
 =?utf-8?B?dTJPZnV2OXBXNmc1VjUrbmU3QlkrMGNCVFR3OFdYRldHWGxVTDJ6QzV0UHFJ?=
 =?utf-8?B?QWJrdTNJWkg1TVhQYzhET0oycFBULzJVUEZCRjhyOG4vc2M0UUZTQVpNQTY0?=
 =?utf-8?B?QllSWHpQZUhSV21XNmxjbkoxZzJlUzhsRmpOdWxvSHpiSTlSdFEvNnJubUZS?=
 =?utf-8?B?SWFKRWt2UG9SN2NRSUFIUGRibDQzMjhsQ25yZHNkTHVyNVFVQUV2SlNHSEtO?=
 =?utf-8?B?NnN5RlRWWmtLVi96Y0NIeUdQS0U3SWRueHJaWWc2WkRSMmcxTU9mM3pWOW9v?=
 =?utf-8?B?aUVTYjVtYlNVdFQ1WGF4QmFvUW1hOG8yNm9STzZVeWJwTE9tUk55eGdHdGtG?=
 =?utf-8?B?VWdsYjZLSkdBTE5NYTNDVmFycGRkdHVCVGI4ZEdJWGNTSFJVTE1SdVhkazN6?=
 =?utf-8?B?dDlHRTlLZjFhUURyRFhrQjc0UThVcWtNSGxJOWp0N1hNNkV6THVUSERnRW00?=
 =?utf-8?B?SDFSaFJYQmw3MkpvMFZqa203c0ZsaUoydmJ1b2E4dndtcUhnREVUREZMcXNV?=
 =?utf-8?B?Y1ZFMzZoQU1GRXk5N1hGL3JqRlR5RmR3VGdiM1ZDbEgxbmFQUG15Z05PN2wx?=
 =?utf-8?Q?Gxg5yCdZ1xmWr8Epe7qxVM0=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY0PR03MB6354.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZW5QbTBXTUZVeEFNc3R6bVZBSXBoeFdvT01tZkdWTWk1OWlwSzN4Q3liaVhP?=
 =?utf-8?B?dHhISjB0S0FLMkNYL21XTHJ3cDlsYlhyRXlTeG5Xc1hPTXFuTVVIYkpteDlK?=
 =?utf-8?B?WWw0UUNGOUlZN2ZZaHZVaC95aWhBcDdpU2dxL1FHUjk1V3hHdWovU3ZwYWVy?=
 =?utf-8?B?alJZUUtHWmZEdjJtUHhweGJ5MFZUb21LYnhNUmpSR0s0aTZaRGtDZXBrWG5G?=
 =?utf-8?B?QlBQb3FrMWhDVjdySWVsdEg1ZC9OaGhqb0tWdVIra2tyMllINVRBOGoyaHhB?=
 =?utf-8?B?bFA3LzNyU3pHR2NCZTB5dnhtU2ZRRUliZXk2bHN1Yk0xNkE4a0VjWTIxaEll?=
 =?utf-8?B?ek8zOVJsaUErdmF5Mml3eXlFNzZDckNQL0dPQ29XKzA1OVpjVEx2YXR2WUVL?=
 =?utf-8?B?M3pBSXU3enlkUm1RTDJLd3BRZTg3VW5ZdEVJcmRzUDQ2OUcxODZpSWtZdzla?=
 =?utf-8?B?WGZwQ09xZHBCMTEyb0NsMVZWMTR5VVB6N1NjOHAzSVFmS0RQVTF0UElJR005?=
 =?utf-8?B?Z0Y1aG9yL3BaWGVRVDM1eFA1M0g4ZDF2YjhNMXRQQWxxazkvMnR3RXRqT2lW?=
 =?utf-8?B?aVdFbWdnZU1GcHljeUtheDlJSjNpcjRhVG1QT293VE82U2g5L1JPU3V6SnNN?=
 =?utf-8?B?b3NoSXJNdFhTd0tEOW90aGt2b3YwSnRBaDVNK295N0o3YkFESjBZVzFFdXJy?=
 =?utf-8?B?N3oyTk9jTkRlZ2o2MlRGeUF0a2RMTkE3TUVMVnVvRnJWL3llcDJXd29IYTU2?=
 =?utf-8?B?VnNtUFBiOW0yUEovSExqU3ZOcGdJTGFod1ZRenA1ai9NS01TZFllS3VsdlFo?=
 =?utf-8?B?aTZlR3gvcjN2L1hGb3ZoNTVJU2Y1MlB3cHh5SUxOMUFQKzZBdjcvRnpzRnZt?=
 =?utf-8?B?dGlYUENkc3pmOTk2Qm1DNzJhaWs5aE1wN1BFZEYvZm50VjBPZkxCendOZjdC?=
 =?utf-8?B?Z1lBSlVWbUhsRlZQVTU1NzdUVDNpYytuOEdKcXRRVk9DdVMzQnhzZFpnVHdw?=
 =?utf-8?B?cDdUNXNraVFkcUNzalR4WWJrQUhaMkp4aWJxTGFjUXlkN1V6UVVKek1tS0V6?=
 =?utf-8?B?OWZpbHFuKzZhNnRDaXJOYnMwSkV4R2RDaVJaazM4OTFvdTQyclhuTkxOOXR4?=
 =?utf-8?B?Q2gvWTduNytLQkVON0N2NHBzVTcra1Q0Q2Y3N3REM01RZ2xiV2lFM244Wk9U?=
 =?utf-8?B?VFNvc2xBdjJYQzZqajAvUVk4RU5Bc2NYOEc0YjBaTElZaUNxc3Byc2k2VHFl?=
 =?utf-8?B?ekYreFNFSXFVdXlOcXU2a2Rrb3doUTR5WnNGRUI4RjI0UmczU2NDeDVEZUlI?=
 =?utf-8?B?bzhLZ3lSUUpqUS92aXhGN2pYdk11d1NhRFNxYUt2V2E2elloRk5lNmJiMnR3?=
 =?utf-8?B?WTh1cS9Tb2FYNWNybVN3T0lHaVM2UlFuVGdEcWhPQ2N5Wlg2OHcrcEJhaXlE?=
 =?utf-8?B?K0tFTGZGL25PdnJnMFEyeWQ4emNnNmphaStlQXNrajJpanc2ZjJ1OENORCtp?=
 =?utf-8?B?T3B2cEVTNkVDUDk1ZGZEODk5S3hsbmx5M0xKVWhzd0xJaWQ0b0hBZG5FTXYw?=
 =?utf-8?B?OFNRRFZQYlprS01Yc2p6dHBxQ1k1LzFNSnVqQng2RkszWXczc3JURCtKVWha?=
 =?utf-8?B?RndtQ2orQjRXY3hXcGZHYTE4TFZ0V1lKc05ZZHNaa21GVWFlSjQxSVowK2tr?=
 =?utf-8?B?eEFyUXRKZGdDTnV2c2JIWHhTSUxlTkJ1VGNHaVlZcTVaZWM1M0x1dHJVOTFm?=
 =?utf-8?B?aWR1U3hMM0tIRXlGRkVUc3J2WXVYYkdRcU9WaDI5dUd1VmROUVg0Yk4veXdT?=
 =?utf-8?B?dml1QnZPZkRXMFJpVmxsS3pmVnhhSjNIQ3VLWnhlSzBwSmZLbktFSmtzYy95?=
 =?utf-8?B?ZVgvbjlEK2ZKTTZ1cUhFWUR0TC9qU0pQQi85bzhTaXRlcCtmV3h1bDBnRytu?=
 =?utf-8?B?WlRPSmhjWXJoa1hBV1JpMDBRYS9NNUtrcUphUVJpdFk5V3pqa1dOckp0dEJB?=
 =?utf-8?B?eUtET3RUSDY4Tm1BeWlxbGN3U1BBVUdJQ2Q4Y255TzQ2U1Q2NEFjdG1mc2c2?=
 =?utf-8?B?MDM0MGdzQnFZTFRuLzdmWEY5bjllSUtUUCtQd3d5YnNDOGd4ZzQra0RQQ1R2?=
 =?utf-8?B?b3dCcE5hL1o2Y3hoSFU1RWtweWFNOUdMbzlua1V4QXB2MG80VjI0YlJkSVVI?=
 =?utf-8?B?R3NnOUkrZ2hpeFRXWDFOS212eEFrVXBuNGxVTHk0WUtaUzVwazBOMEU2eEJL?=
 =?utf-8?B?Y2wrdFpwQVgwSGFBRkdTTW1mVGVCVmtoV1B6Vk1vUmZuczdORWNyQWp3OVJD?=
 =?utf-8?B?cnRQbUJUSkh5VjgrTUhmZjliWnBoa0lrNXpYTnJTbG5QamltRWJ1ZlNPY2tp?=
 =?utf-8?Q?rkgmSwEleb+zR7hI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FC3A722BADD69440AEFD7E3C38CB3BFB@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY0PR03MB6354.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a1fd03f-c905-4308-ddd2-08de694e9cd0
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2026 09:19:09.1571
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CSpGlZQZ1u/FxYhJondJX9WNUZqT5zkRZ6g4LxoVJszYFNV+mJM4/2Ivy5H7AxOnagtOJPdi2ajqZFnh71Qcmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR03MB8720
X-MTK: N
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[mediatek.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[mediatek.com:s=dk,mediateko365.onmicrosoft.com:s=selector2-mediateko365-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-31728-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mediateko365.onmicrosoft.com:dkim,mediatek.com:mid,mediatek.com:dkim];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[mediatek.com:+,mediateko365.onmicrosoft.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Ryder.Lee@mediatek.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 5FB1E122A66
X-Rspamd-Action: no action

T24gV2VkLCAyMDI2LTAyLTExIGF0IDEwOjA4ICswMTAwLCBLcnp5c3p0b2YgS296bG93c2tpIHdy
b3RlOg0KPiBPbiAxMS8wMi8yMDI2IDA5OjU5LCBSeWRlciBMZWUgd3JvdGU6DQo+ID4gT24gV2Vk
LCAyMDI2LTAyLTExIGF0IDA5OjQxICswMTAwLCBLcnp5c3p0b2YgS296bG93c2tpIHdyb3RlOg0K
PiA+ID4gT24gMTEvMDIvMjAyNiAwOTozMywgUnlkZXIgTGVlIHdyb3RlOg0KPiA+ID4gPiA+ID4g
PiBXaHkgdGhpcyBjYW5ub3QgYmUgYSBzY2hlbWE/DQo+ID4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+
ID4gPiANCj4gPiA+ID4gPiA+IFdlbGwsIGFjdHVhbGx5LCBpdCdzIGFscmVhZHkgYSBzY2hlbWEu
IFRoaXMgaXMganVzdCBhbg0KPiA+ID4gPiA+ID4gZXhwYW5kZWQNCj4gPiA+ID4gPiANCj4gPiA+
ID4gPiBXaGVyZSBleGFjdGx5Pw0KPiA+ID4gPiA+IA0KPiA+ID4gPiANCj4gPiA+ID4gSG93IDFU
MXNzIGlzIHVzZWQgYWNyb3NzIGRpZmZlcmVudCBnZW5lcmF0aW9ucyBpcyB3aGF0IG15DQo+ID4g
PiA+IGV4YW1wbGUNCj4gPiA+ID4gYWJvdmUNCj4gPiA+ID4gd2FzIHRhbGtpbmcgYWJvdXQuDQo+
ID4gPiANCj4gPiA+IFdoZXJlIGV4YWN0bHkgaXQgaXMgYWxyZWFkeSBhIHNjaGVtYT8gUGxlYXNl
IHBvaW50IG1lIGxpbmUNCj4gPiA+IGVuY29kaW5nDQo+ID4gPiB0aGlzLg0KPiA+ID4gDQo+ID4g
PiANCj4gPiBsaW5lIDI0MyBwYXRocy1ydQ0KPiA+IGxpbmUgMjYxIHBhdGhzLXJ1LWJmDQo+IA0K
PiBJIGRvIG5vdCBzZWUgdGhlcmUgYW55dGhpbmcgbGlrZSB5b3Ugd3JvdGUgaGVyZS4gWW91IGp1
c3QgbGlzdCBhbGwgb2YNCj4gdGhlbSwgbm8gZGV2aWNlIGNvbnN0cmFpbnRzLg0KPiANCj4gQmVz
dCByZWdhcmRzLA0KPiBLcnp5c3p0b2YNCj4gDQoNClRoZSBvcmlnaW5hbCBzY2hlbWEgaXMgYSBi
cm9hZCBkZXNjcmlwdGlvbi4gTm93IGEgcmV2aWV3ZXIgd2FudCBtZSB0bw0KZGVzY3JpYmUgdGhl
IGRpZmZlcmVuY2VzIGZvciB2YXJpb3VzIGNvbm5lY3RlZCBkZXZpY2VzLCBidXQgSSBkb27igJl0
DQprbm93IGhvdyB0byBhZGQgYSBjb21wYXRpYmxlIHN0cmluZyBmb3IgUENJZSwgVVNCLCBvciBl
dmVuIFNESU8gZGV2aWNlcw0KZm9yIHRoZWlyIGNvbnN0cmFpbnRzLiBTbyBJIHVzZWQgdGhlIGRy
aXZlcuKAmXMgZ2VuZXJhdGlvbiBuYW1lLi4uIGNhbiBJDQpqdXN0IHdyaXRlIOKAnG10Nzk5NuKA
nT8gT3IgZG8gSSBuZWVkIGEgY29tcGxldGUgYW5kIG1lYW5pbmdmdWwgY29tcGF0aWJsZQ0Kc3Ry
aW5nPw0KDQpPciBtYXliZSB0aGVyZeKAmXMgbm8gbmVlZCB0byBjaGFuZ2UgdGhlIGRvY3VtZW50
YXRpb24gYXQgYWxsIGFuZCBqdXN0DQpsZXQgdGhlIGRyaXZlciBoYW5kbGUgaXQsIHNvIHdlIGRv
buKAmXQgaGF2ZSB0byBkaXNjdXNzIHRoZXNlIGRldGFpbHMuDQoNClJ5ZGVyDQo=

