Return-Path: <linux-wireless+bounces-3361-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD2F984E9FB
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Feb 2024 21:57:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7504E292FB5
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Feb 2024 20:57:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3344A3F9F2;
	Thu,  8 Feb 2024 20:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="ziVErLuH";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="R/KvtWQ1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE2F325628
	for <linux-wireless@vger.kernel.org>; Thu,  8 Feb 2024 20:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.154.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707425855; cv=fail; b=CC9JT9Ubc4Fo5gbFIiUVeocvNLk+0WiiKx2EwvUxyhx7RgDzH33rhHJGkZd7/BpLiiuzu1VXi5wGkZljxuaTB90/worpuIGkWEJaV7MoZcrRMETXqUsKzCG03gbVH4TAOKhqDJjv78SrRgQOzKHjg68mwBudaYzX7bnNl0wTEgQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707425855; c=relaxed/simple;
	bh=gvTSSOColOuX6byhMihycjbMgeIlWes/VSNAB6tb+O4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FLDylWpyEQGo1sR2UOvS+VbGQgT5U/4bC7Hp/iqR6MVJigiII6A6vXs9+J7ez0TklzHFyZHwLvvSbr2M5TRe1bv7F+NDLYiFSSdz4Kjmp0l+YCz5tlQ66fXjKrktXDbwqAWLlXMwRZsO8wSJEKosr0JXeeqMrf1w/zX+R4wlZ4c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=ziVErLuH; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=R/KvtWQ1; arc=fail smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1707425852; x=1738961852;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=gvTSSOColOuX6byhMihycjbMgeIlWes/VSNAB6tb+O4=;
  b=ziVErLuHEik1Zeikv2RUIP907cVsHQUI9IOy+ygO2AZoTDBbxmHTT+cD
   IqyT4f8Khp1QnYPR2YoNXb5x6Z55BX9vFACPDsINb/r5eNdfjOVyUfn+U
   m8kvwRSOsvtqrjL6zNH/t7PA92TRKEERXLPEw7dVjpd+9+DZYU4S3EdMe
   ZzWRldRHNWcPPXFvab0xIjgslaQgmLppNjVwrypyQSCTVu2R34izdSoCU
   I02OR1ijQTBZ9pWMTxiCXSoDdvhtG3YG7BhQSfg13T1FNo0X/8VDqjRjS
   hyJBxt+MOmUQ+jPBAt7X/vez51TSQuMLQOo6z9q1QVbndcipTMoUlm1uW
   A==;
X-CSE-ConnectionGUID: YXltieXIQia6pX/Xxx/Jiw==
X-CSE-MsgGUID: TdNTd3XXQwu99ePNP1Mnaw==
X-IronPort-AV: E=Sophos;i="6.05,254,1701154800"; 
   d="scan'208";a="183251460"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Feb 2024 13:57:29 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 8 Feb 2024 13:57:15 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 8 Feb 2024 13:57:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YvToNLx7O/f+l2eYh2yk6DLbg+nSUjhmOs3DWt63V+UESB39+VYxCo7jcv/9JCPFg8BmYhirVQdlL5OGkzKZCMDfYJIKOS4JfLqstUpygFKDDAxL2KoDqjnkQtXWWucQQAU30Oxktsvay+Oc8PVIAvOKivsfF8dOXp6SPpar7q6KgatM5LnzUi5aFEAuhzwbMl4LkoM6yrEk+DJyxe67J0k8bMNfKTAtELr2j/6ro+2tV00S4j8+R235EOWRNaueU4YC8r5CjTl99JnlWxWhr4DeBnWD4rPxxVBz8mnk/l874ZAEmSP3nEb1RYtcN3Yd2LX8zrNyikgoHxV/IGcG1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gvTSSOColOuX6byhMihycjbMgeIlWes/VSNAB6tb+O4=;
 b=QWzKmF/jIxDbPviTn7JMV7caFVbJl8X73iYeOYYxjEbmHrEU9lmW4MJCrmGce/lHALhNeZBVILbPsY4seKbWLLNxrQ005/CfD9zxpCQ2OJShmgyIW3rFmRUOIHLsr3Aw2lzLrXECrhYhGmYInnYei6Yz+JihfxZGT5oUNJxZlg4Denue5RbeVlRreeYHqTE2nseH+VOVkD5kVKhTaODkETYSOmmjgXTMkQok5locqCrH0iyIgqMoc45DXneMIXTaKilCZs2oifMzPY0CP4uDNGQJbsphaxulTk+sONltI8Af6TMcRlXk47ALg0RMnn3ETlBm4Aj6SGRqSS2qzgHv3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gvTSSOColOuX6byhMihycjbMgeIlWes/VSNAB6tb+O4=;
 b=R/KvtWQ1YnpIT9EsAiJZGzrFxlSq1rPzSP1gkmJe6vHulxXcNLRcFAmoPIRy3FKkNHiK1n53AfVuhiIbtPWHa1Ug4F+hzo/kJr9Zus1WcgbcTpO0wS7H8mLWhqq9dV3ECqPhNuo1frhyGsmfJssNOCraVxRdiSfcFx6O5fDf1EDh6OxlCS5I76Emjcf8uA/ebBvLTi8HunBn8fs+Cvb+oSRlNTiOtjiOT6iXFPUmR5qsm3nkXL7pUIJkU2qqWKq2ck3grXM/exQEpfbuGz8MKL+k7onrc61ayzpt9Robryc40RdRXCr39xSTI7oPlB5lVCrr8RGzX9fYImeOyTZbYw==
Received: from PH0PR11MB5176.namprd11.prod.outlook.com (2603:10b6:510:3f::5)
 by PH7PR11MB7122.namprd11.prod.outlook.com (2603:10b6:510:20d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36; Thu, 8 Feb
 2024 20:57:09 +0000
Received: from PH0PR11MB5176.namprd11.prod.outlook.com
 ([fe80::613:fb5:737:dae8]) by PH0PR11MB5176.namprd11.prod.outlook.com
 ([fe80::613:fb5:737:dae8%7]) with mapi id 15.20.7249.038; Thu, 8 Feb 2024
 20:57:09 +0000
From: <Ajay.Kathat@microchip.com>
To: <davidm@egauge.net>, <linux-wireless@vger.kernel.org>
CC: <alexis.lothore@bootlin.com>, <kvalo@kernel.org>
Subject: Re: [PATCH] wifi: wilc1000: correct CRC7 calculation
Thread-Topic: [PATCH] wifi: wilc1000: correct CRC7 calculation
Thread-Index: AQHaWYOoYJJRJwbDg0+vhMW2POpdoLEA77oA
Date: Thu, 8 Feb 2024 20:57:09 +0000
Message-ID: <563535fa-964c-480d-8e6d-1678de5e057c@microchip.com>
References: <20240207050736.2717641-1-davidm@egauge.net>
In-Reply-To: <20240207050736.2717641-1-davidm@egauge.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5176:EE_|PH7PR11MB7122:EE_
x-ms-office365-filtering-correlation-id: f53c76f5-54ad-4727-6700-08dc28e8840c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 09T+Dw7CDA/+13fwhnhqVriyjCYFeW4RdjOc0VpTDC099VSSpyPokf6qTOMVao8MIjr2nLHOVc19wtpo0BL9VvCQuM2zEfWAsBskGK4hoqLgYz+89KcmOywSxmejeHUzRvUJij6MrKH7QuAaoaEL1xEj9vsWDEoxEYB1h6PnjuPkTWV9Qebu5woG338lifhwzk0LsG1MHho/tNrd/ogaxtNjhrdfXdjiUUW7UKRigKebsz9nTfAO1GqPkW9vT/lx2xriEzC8APRzG40ueivAFYBOOLo4euxzirTrBDqFOui5oNecPZZ0N1YHbcWtSlNNuRXDZNwv5QGWtirntgaPvOW6DvMxBt5Y5//k2FX47T9cGYslpPK74b/5Yg5U+7JTSijrJX3YXUVsjikBY0gEbIYBN9/KlKbR1XVyifhKT5pDTtS+4KPD/uGM56E+1VmMYn0kFdCI16ygkk6N2IUCRZhe0F9iWeXx0/btkTNcpOvT6FsXSSTSukdFLMJJrSSRj7J7Al19DiyW0gFCvFd+bXDszhYWqQv2xEI9m3UMGpNR7dpaIZtwb5YMALmQeV8QbpBriNQ/HsK9zPImD3PBeaKV6mQNzeP4NT4Etdo7Rys=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5176.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(376002)(346002)(39860400002)(366004)(230922051799003)(230273577357003)(451199024)(1800799012)(64100799003)(186009)(41300700001)(66556008)(38070700009)(64756008)(66476007)(66446008)(110136005)(66946007)(36756003)(76116006)(54906003)(316002)(8676002)(5660300002)(4744005)(4326008)(8936002)(2906002)(83380400001)(31686004)(38100700002)(71200400001)(2616005)(6506007)(6486002)(6512007)(53546011)(122000001)(478600001)(966005)(26005)(31696002)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UUdOY1FwWWVMcDRvWGxQOHkyVm1FZ1RZVnZ5VkRXRi9ua3ZCZnJTVmtzajUw?=
 =?utf-8?B?QUtXVC8rS285WFk5L2h3eWRIanNZZ2ZKcHNVRkRSRGEwbWJwZWM0a3lKNEkz?=
 =?utf-8?B?MnpzRHQ0dzhOVEVHcGhialBkbnpHNFRFL0dFWCtPODJaSlBTQWRRMkU4bGlU?=
 =?utf-8?B?YjY4RzhCSlJ3cUtrN3ZIaGp3d3NKelgvcktEUDNoMkNaMERDdm9nOFhEcFEx?=
 =?utf-8?B?SnNvOVdzT1h0Nit4WitBcUkwRkN0bGpWMW9WUnpWRkJKcUpjUnh6bC9kcHJh?=
 =?utf-8?B?Z00zRm9mOVNCNnN1R0JXS0czK3BtbTh2Q3E0eGJhNUo1ZFVyTVVZSU9HTEhW?=
 =?utf-8?B?M2NBWi9MeXp4TExOajZxTDRrQVRDNG1UY3Q0RDRUV1FuQ3BoeHpMRWl1OHpt?=
 =?utf-8?B?YWZLTVNPSFFadytrZHp3ZWovSmE2ZU1xVElRYTNkYS9ibUJ4S1lSU0QveEFJ?=
 =?utf-8?B?M0JxNFhNK0lJMkhkdVFtc3dBODgxcTZsM1BwOVA0WlJndFpJWGo4QVpsV2JB?=
 =?utf-8?B?ell5endpRmlBQWJYb1JhSERBWEFMWmFzZkR2K21Ka0NmV21BM09XcWxWZElT?=
 =?utf-8?B?T0F0SmFCWGR1YTNwa21FSHdpRnJtMWV0eVRaaitHandUTEpYbDRabmV0bW9j?=
 =?utf-8?B?L2ZvZW9GU1dHZVdxWVVpclV0Z0ZWdHZLN2E2em1BS2RTbi9rTXlOSElYQUU3?=
 =?utf-8?B?S0RFRjVUVE10Wmk5c2E2bXpKenBNZGJqdEpPMXBobFRac05OQUd4RjhqY0E3?=
 =?utf-8?B?TUdwUjRXa3JUaVRkUEdPYnBnY0orRGRtMVR3dkdVZkJvYjJDMEZORFczKzdj?=
 =?utf-8?B?QlVURE43MzNrQVhsblF5U2t3SDU3NDVDcDNWNmF4bmp0K2dVVk5mVjZsbzNn?=
 =?utf-8?B?SmlpTW5LUi9CSWFCUUhoaDhDVGNOeGVWQXh1WUltWUZHbXl3aEl3VVdGM0U1?=
 =?utf-8?B?THNDTTJ0OFEzWk5IbXF1SlNWcTl3b3E2ZlNnRWVFSUcyWlpMZ1Jub1VicCtj?=
 =?utf-8?B?cTQyd0xYWTU0cjEzenlnR0JZYm41SGt3aDRlZmJYVzVHdk5ia2JiN3oxS2RL?=
 =?utf-8?B?WEZMTzNqMWRRN2tLUFJHRU1ySVU0b2xkejBuWFBCaWw3TEZYZTR4RlM3VjBK?=
 =?utf-8?B?TFNaMDFrV0lEZE1icmxicjMreHcySXVPY0lQWVJCK2tST1BGeWlqOEdwbURi?=
 =?utf-8?B?Wlc0N1A4Q2hWejNmSTluVGZKWklNT0Q0d0JPWjE1a1pOeHVaSncxM2g0RGxO?=
 =?utf-8?B?Z3h1Tkc4UmxoSnhyWk9pU1I3dEdsWWhUTnhzMkdGYkZmOEZUNWdKSlNDLzJi?=
 =?utf-8?B?Ryt3TFhpbnVnckVwWlBKb3BJKy9vZS9lTE5wemxUclZkMytHa3pIL0dsVy96?=
 =?utf-8?B?M2hpcWg3YkZ5S3R5UU91UjR5eGpZdXhvWEpNckU0eVNVTTMzWEY1QnRzWW9k?=
 =?utf-8?B?ZVlQRkk1Z3RGSDV5NXJjdmE1UmxObTlwR2w5Y0ZQQ0NKM2lNckNnb1VWR2NI?=
 =?utf-8?B?ajBVOTVYMTY3K3Q3dktvNU9xNTVzNEJObGpHQmRmdm40eUc1N2lVeThmVWdt?=
 =?utf-8?B?ZWc5a2UxSVBQbFpQdzFqQWJJUERYTGJWY3FKMlA0enpsZEQ4NU5ib2RtYmZZ?=
 =?utf-8?B?L0ZZcDFpcXYwMEZ1NEExSWkzNjRCSkhnd2pVTFdoUXBNdTN0dk0rQWJ2R0dr?=
 =?utf-8?B?K0Nudm1OU0UyMFpSRy8rT000bGk4TFVvQk1KaEJ4bVdDL3ZUa0NBTjNybEQx?=
 =?utf-8?B?em1ncTBjajBJeGpTa291TDgrQXRyeHlTdW84THQyN1hWQVVuMDVrNnRTOFpL?=
 =?utf-8?B?Q1NOMWV2MFdKRVhoRlZVSUVKSXltZnlwamFxc0pPUFc2TG9pbXhURHZDOHVG?=
 =?utf-8?B?emdQUkZ1aHZIQzUzRWZVc2UvelFoSktWaVB2MDcxckdjNSt0UlBmYkxWQVNw?=
 =?utf-8?B?ZGhTOC9OQnRIUGNYR1JiM1V2SWl1UmpMRm9aS05OVU5Cc0tEbVM2MU5tZFBW?=
 =?utf-8?B?djd0SWx2emN2WWlWVzdWS3ZiVEtRYlU4RW5oQ3VudWhBenVCcURlV09VcHFx?=
 =?utf-8?B?bis4N3R4bkdCL0xJYkpsbE5rRFJqeTQ4NEVNazB3bG85UTcxQXFzV3ZDVVVz?=
 =?utf-8?Q?XsmB+X8lE2CJ5eLo7u6WvFh55?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F3FC255B68B6C24683F134A2F25DB76B@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5176.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f53c76f5-54ad-4727-6700-08dc28e8840c
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2024 20:57:09.2434
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dnqPvNBeiVqgl+TfDFpqGu1dNxTBMyFxQqoivtleif2kSxGAubUprru6dz0jrkTbXrXqNpGxksNwnofbcOXdWUaaDxe76SbHVEeV7QdDzPk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7122

SGkgRGF2aWQsDQoNCg0KT24gMi82LzI0IDIyOjA3LCBEYXZpZCBNb3NiZXJnZXItVGFuZyB3cm90
ZToNCj4gRVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1l
bnRzIHVubGVzcyB5b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBEb2N1bWVudA0K
PiANCj4gICAgIEFUV0lMQzEwMDAvQVRXSUxDMzAwMA0KPiAgICAgQmFyZW1ldGFsIFdpLUZpL0JM
RSBMaW5rIENvbnRyb2xsZXIgU29mdHdhcmUgRGVzaWduIEd1aWRlDQo+IA0KPiAgICAgaHR0cHM6
Ly90aW55dXJsLmNvbS95ZXIyeGh5Yw0KPiANCj4gc2F5cyB0aGF0IGJpdCAwIG9mIHRoZSBDUkM3
IGNvZGUgbXVzdCBhbHdheXMgYmUgYSAxLg0KPiANCj4gSSBjb25maXJtZWQgdGhhdCB0b2RheSB3
aXRoIGEgbG9naWMgYW5hbHl6ZXI6IHNldHRpbmcgYml0IDAgY2F1c2VzDQo+IHdpbGMxMDAwIHRv
IGFjY2VwdCBhIGNvbW1hbmQgd2l0aCBDUkM3IGVuYWJsZWQsIHdoZXJlYXMgY2xlYXJpbmcgYml0
IDANCj4gY2F1c2VzIHdpbGMxMDAwIHRvIHJlamVjdCB0aGUgY29tbWFuZCB3aXRoIGEgQ1JDIGVy
cm9yLg0KPiANCg0KVGhlIGNoYW5nZSBsb29rcyBva2F5IHRvIG1lLiBKdXN0IGN1cmlvdXMsIGlm
IHRoZSBjb21tYW5kIENSQzcgZmFpbHVyZQ0KaXMgb2JzZXJ2ZWQgZHVyaW5nIHRoZSB3aWZpIG9w
ZXJhdGlvbiBvciBpdCB3YXMgY3JlYXRlZCBieSBleHBsaWNpdGx5DQpjbGVhciBiaXQwIGluIHRo
ZSBjb2RlLiBPZnRlbiBJIGhhdmUgdGVzdGVkIHdpdGggZW5hYmxlX2NyYzcgZW5hYmxlZCBidXQN
CmRpZG4ndCBvYnNlcnZlIGludG8gYW55IGNvbW1hbmQgZmFpbHVyZS4NCg0KDQpSZWdhcmRzLA0K
QWpheQ0K

