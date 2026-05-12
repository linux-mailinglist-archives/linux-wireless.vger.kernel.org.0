Return-Path: <linux-wireless+bounces-36318-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +D70ODP6AmokzQEAu9opvQ
	(envelope-from <linux-wireless+bounces-36318-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 12 May 2026 12:00:19 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 40AF851E2DA
	for <lists+linux-wireless@lfdr.de>; Tue, 12 May 2026 12:00:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 57DE2303F2A7
	for <lists+linux-wireless@lfdr.de>; Tue, 12 May 2026 09:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F3964C0425;
	Tue, 12 May 2026 09:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mdj6Vrx9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ACB7399017;
	Tue, 12 May 2026 09:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778579949; cv=fail; b=ub/fG+6VsAEDZU5+4jaYRccAFvLZiOFjMwPteQL4rFVZKmt7Ot3tXWfzikZF97I/DcoYkokaEs9vbxHhk+5ZX2NlZFzxy6TCcnZvbOQHGYyHO0OlLQNwmGhjZnw50/DXTFBe2pN0OmeEy1TYVhpjQJCGToN5u2pKyUN8hjMPX34=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778579949; c=relaxed/simple;
	bh=zEwT6X8sbS9soLeHzFnslMVQc7uISt2yFSBep+oaJ2U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LcOJx6M6ZyZb3ZLG8Zeg+9BSeQMN/pdql9xu0A/KhW933MWpsDiyophBqkq0Y5MAtnrfWT6RuM29QgTIE6H/CKLUX4ltu+hTtWg4gqUYFnzv0xaqYBNV4+W3o3z2/LVbsZMX+KV5E8j4hZ4lvpg/qRZdFkHBNgwoPag+c5jysSc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mdj6Vrx9; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778579948; x=1810115948;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=zEwT6X8sbS9soLeHzFnslMVQc7uISt2yFSBep+oaJ2U=;
  b=mdj6Vrx9h0TxKb965YATGlKATNd+D/xjbkT123UZTXONZBZbzReC9udE
   gorucmQsGTJsHwsp6Jx3RJRIwkHAq7JR3SCpmlDOwCMfUxwn7j2YdT3ke
   yAOdU7Rz11FMzp1WxDTU5JvStRPeG8spm4oNHNRD0YwaXNbUFhsSAnTiJ
   0FhVKB/konAAdslqP0a4Z39PwqXdaedkJeBpgZW3pxDaqrM6/g52q2jn7
   4RMUImrEbJdfHM9NoQqspRlcClJQ5b/0FDMqTU/DG0RiZMjdCzPPpRVaU
   LyOXecMDr0GHuzRK62l51wz8t7T6nngNURpH5N9seqADCGegDD9VYzkdi
   Q==;
X-CSE-ConnectionGUID: zmt34JOKQ++7UIcFTGmspw==
X-CSE-MsgGUID: LDQFo+hsTZOtCscCT3X4vQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11783"; a="79201900"
X-IronPort-AV: E=Sophos;i="6.23,230,1770624000"; 
   d="scan'208";a="79201900"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 02:59:06 -0700
X-CSE-ConnectionGUID: LhXFknTQRvmRZPJI5exn+g==
X-CSE-MsgGUID: Dzc5xkl7Q1GjaEBMwDr83Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,230,1770624000"; 
   d="scan'208";a="233412425"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 02:59:05 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 12 May 2026 02:59:04 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 12 May 2026 02:59:04 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.45)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 12 May 2026 02:59:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZUDiGPMdP9WmzGa+eJZYN3dznmzGUDbX+I5kuw65ylYRPkHSc9+gLzgzkeDNJbPkU8bue6rpZAxba3MhVXlPsU2ltiyeBostIBz9OJnYwLIn8Mj3liPQzTc75FFut4FTgBjF71+vVU9wB7zD6EsslL1co8tftOwiwvQKGFi0VvqJL4+ZkSn6oLx2YNqNb6rEQY+6y90uhWDV4gmqvjOs6YgPzjqYXOWoOxUTLXpxZzjtL1plN6mo7uhfkHrwCcIdQt5IzSQK7zfBr8mvLGb55zs9ZLHmPCe/E3VBtCs19Z3TxILYmoMmE82cNaAhvvZpcp+FtPwXn5iWpkptr5r80A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9rqBP8INn7DoBRu4XLmmQEWdeSEcHv1RQ2f72ubtgdM=;
 b=fs+47twEh1eQkYEWh0xx21PlKIRYJFVhfP5Wr0TulisL1GO17GdR7MQcDWmEl3Zxia1n69ZjNUbhAZsA4XWu3+r5ZILbgBU3zX0HcARGoYFN1D+OvZhxTBsZvEGfFDHoMnhE+V0jq9YAuWxtcl6GR19jKGxv2hkwaofn281Rj0f+HiekrXtpza9CX2bNOpHL1IX34LdsSN9zCJVBEYW8Z9pT1fHjPlIzBYbNbhIwbSUB2L7cNVNYmsRVoluP6zwx4dDwVOo+juhzFzaZL/us9OSnzMlfQQP+4I/2X/ALKjYOZne9RwnE8fX99XWl7b99kwrrHg1s3O1/FTobuiHC+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5954.namprd11.prod.outlook.com (2603:10b6:208:385::16)
 by PH3PPFF1A08ABF9.namprd11.prod.outlook.com (2603:10b6:518:1::d5f) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Tue, 12 May
 2026 09:59:02 +0000
Received: from BL1PR11MB5954.namprd11.prod.outlook.com
 ([fe80::656b:8dc4:72b5:7e12]) by BL1PR11MB5954.namprd11.prod.outlook.com
 ([fe80::656b:8dc4:72b5:7e12%5]) with mapi id 15.20.9913.009; Tue, 12 May 2026
 09:59:02 +0000
From: "Bhatt, Avinash" <avinash.bhatt@intel.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"johannes@sipsolutions.net" <johannes@sipsolutions.net>, "Korenblit, Miriam
 Rachel" <miriam.rachel.korenblit@intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Guetta, Kobi" <kobi.guetta@intel.com>,
	"Grumbach, Emmanuel" <emmanuel.grumbach@intel.com>
Subject: RE: [PATCH v2 1/3] dt-bindings: net: wireless: intel,iwlwifi: add
 binding
Thread-Topic: [PATCH v2 1/3] dt-bindings: net: wireless: intel,iwlwifi: add
 binding
Thread-Index: AQHc26vldg7WQr6iSkSIFSGSlz8QlrX/KC6AgAsK4IA=
Date: Tue, 12 May 2026 09:59:02 +0000
Message-ID: <BL1PR11MB5954DF4D777546E6BEDBCCC4E0392@BL1PR11MB5954.namprd11.prod.outlook.com>
References: <20260504095327.30892-1-avinash.bhatt@intel.com>
 <20260504095327.30892-2-avinash.bhatt@intel.com>
 <20260505-nano-seal-of-speed-7d5bc8@quoll>
In-Reply-To: <20260505-nano-seal-of-speed-7d5bc8@quoll>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5954:EE_|PH3PPFF1A08ABF9:EE_
x-ms-office365-filtering-correlation-id: c141c3e4-425b-4880-3611-08deb00d1867
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|18002099003|18092099006|22082099003|38070700021|56012099003|11063799003|3023799003;
x-microsoft-antispam-message-info: zYbXEZACjnblehoWHX1ltWE4/07N9Ats4roqt7fkAgAWcJgokOJwievafULWlGtrvRhxgW/S9LaZN/P+zQpIVsqVRM55gJigHW0lXNZT/FI+U5ONgJjAl6QzzATk/7Fap5zMVGE+/qQ8uLojMxe2OQ1uMwCwL8w1sY3o+elSPiIc/AR7XhZCWYcJeUHj5G+1LlybhVrckDvlpTARG/qaDFOSsZsfVtznFeG1scG9bhnJ8FFHBC/xzFzJItYn2GetoaMRkiO3wM9qDN1JQvmVJHj1oAB7ohTkTZR6KWJNk5VdModqPZ9J0Ye8Ps1HmCq3pX85OyUruteqU/3vZo+h/6f61pC51ugaQ6OvxxYm/xDk2sPc23PrD4c4N9i1qq73Ey7IpPTIx9LVzAoVMDZaEmjW6K8gnVE2ffZS2FVXBKq4bdIxjT+FaYqcuPfN1cdj8LdJOzHqM4qZp9+zOCBcGu9WOzAjCTIcFEFE3zJsrBsSNNlPLiuw7P/K5wxQRCsfcSC+jhtxr4dvZ8nWMQb6G3gMTr3J/GZdjK8NSPiumsB5ELLZWicKVCSXP9oBN2Dr1jpCsyF+VCbSVndU6m2fDUF9g2MCKNRX73cIdnl5jRJQaVSRp3pCg2iDddvvwFKiwcy9uBavLzggVmX0xZYhUqxeRa+aQXi4t89mgwpDwcFK6gcZMTrBQCUIQPsiER31b9RQvlrAQpJgXlj7aRRlrw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5954.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(18002099003)(18092099006)(22082099003)(38070700021)(56012099003)(11063799003)(3023799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ytzhFlylL1D3b6bXAtB1f3TFCZ627vKth7FHZSqdtotPeEyIQj95uJGYZqkl?=
 =?us-ascii?Q?44BYPdDzuRnfVvFig30WAkCMLQCCekht7U07QCQ91w7Pd5MtZkX4T/7woW05?=
 =?us-ascii?Q?m4uCDPfvQPwXEXn1D/etpkIn/MpavpLNdZpMBwM3afzCkseENVNh3D3M7/OK?=
 =?us-ascii?Q?s5E9RSiaityEEEbIyqGF5QR7O1TMbJ8h7SGs3gPsp3R9htZ+rhZa2IYyZt13?=
 =?us-ascii?Q?vO/67bUYQMLkYmtRdet17Nvncd93g5AQ1UWUKRIBuzBR0TdBvSY+NBqROEOa?=
 =?us-ascii?Q?ArFAla3ec9greZK5yQAkRZeToQkK1rUvBxBeY3typ//Zplmh5pN11F3StR+k?=
 =?us-ascii?Q?Aribnl4CEfyfdndH35QCrsokrHhF64x0EFmBPTl09L5HSlda4/npZwGL0SIT?=
 =?us-ascii?Q?/4laTNHpUFpEP6x23RlUew1vr55KKp92WIW0f1xIhMjboS8Va+KwlGBbS8Lq?=
 =?us-ascii?Q?zryAwy+w8ZHum0F+JpRL6VblC/UAQD6xDaMG/V+thxJiMBtMekSDCxi5nZlb?=
 =?us-ascii?Q?uAaooBiJqrAUnZEurhntQ+Erkm479w86sO27KnubYxlJlFBFArhpfHq64osT?=
 =?us-ascii?Q?MBPIQebXSanSun+SOiinHNGQTvN0zOpzjP25w98+lbRBVXc1kns8yo/uycNi?=
 =?us-ascii?Q?BqYu1SdlIcqcN0sl1Fz9bQHVW57mwiFe2o/7J6jyV3OMQce20ml10GXIMUNo?=
 =?us-ascii?Q?Xdd4VORYE0WWAzArEatKw8x6TC+wfcjiji2teRyn4UtVUFNalNXt/rhcsV69?=
 =?us-ascii?Q?kbxhd2+8Vi2mpmxTVCBpvJvgK/bteBqKOZEoCaYI32IkeVKJgZKbSwOk157Z?=
 =?us-ascii?Q?ZNOfQLsLylSPJU42+m+M1pl4OtmLcU/X5OjbgKDOKXN3mucwm/Axaahe8//X?=
 =?us-ascii?Q?IiPV3futONaDZQ2b4HQE6XmZ1mlk8ONq9KHGZvVGXYuYw/4IUrIfaMZpJm/E?=
 =?us-ascii?Q?5U+7bPCcqgOyOSUeWtlLYDqfpv4Ldro4KIpCgZ5cG6uPRESqnKWPBSs0Szmx?=
 =?us-ascii?Q?shF52jvm3EJJw46c+rl/kmBRtUyI5Il7BOdvIuvVLcYlUkOihohldnEQ5nHA?=
 =?us-ascii?Q?Wj0QXJlIGrDgmKkjltkPTe/2sHjQbu9h/twiTFm0Lv/vBwfw73zlcfyMm+35?=
 =?us-ascii?Q?I4alaz76ou85wUSBQjdOIVjMnkiSbXsbGFoJnnv3yCXn093DpHhVjJjFtj8J?=
 =?us-ascii?Q?MrYczyTgq4F8RcPXZRwoEVzFCXWDx2HoMyNm6oYIw3qgA/D6KT7iZAkcFu0Y?=
 =?us-ascii?Q?SNiSZIt9nW2x1u2MbRYGT2mRqgd8pV7BQXK9qArK9rmy/xJK8i8kVZkvPGhQ?=
 =?us-ascii?Q?ZX6HFa5VGVfbTb0y34P6T5Cm/1ry9JckdjHa56I6RJNQHpJwVPRhXtfja6UT?=
 =?us-ascii?Q?KQ9B+MKEuYmebPt2mpdJh4+sMy3oQ0aXsG37CT0Zpj53sF6QpQ6G1cykOr3G?=
 =?us-ascii?Q?6jJcf6Wdn/6DZ3HE5T7veeTNDTIsfKKlfFQJkCmWSLs3d4g6YDPv8zHkxDPE?=
 =?us-ascii?Q?Ipkj5TiOt7rBvbcCm+BaVvweACWnj+idKMYP+QSHfffnA/7y/lh0rcGJMwtp?=
 =?us-ascii?Q?DjElUc/KZxytocxaeLixDzxlhMjDVOMSMKsVFsPJNi5jBY7F4LSrBIOv35+l?=
 =?us-ascii?Q?pDv+gedGckWaseM5S1tQ0lv8WFwrBpErGFeZ4ayZAnnH65q+Tgk0dx4qa404?=
 =?us-ascii?Q?JTXjzcY2ClGAWVB97aB2D4RLPGT5WNo/R8kgGzmb3hF5rAtcuoFX+daDxAtE?=
 =?us-ascii?Q?QveINKgjXQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: oUv+L2RziwPVWX/IxDZNo43CMLJBXwcwVrXwztO3k+A+/JRsOn9O0DWzEJQzWPFJrFABzQizhtU2hVUrNSNZ/jEHe4hd9X9jPbKZzdVTNfCor6Pv5lYdRdkJsaSF6E9ewZrjwP6Ksf20WbBg5ZTdt0VqfPhUax+22GGY/4jt0ZLtqi/P0S+SNDfeP8cVtzmlLlx+dp2yzj5AM6gu/5UCG0YLq/iNgF7fKC1Qc5HH8xczMcYAQNFuJWSjgV9mEBbWG8qwnayYZSBrhOpNvT3bccGN/wTSun4y9kZ7e64yjU+JZUx9MWDZ+YdD56S6eiKbpKjzImUegR3GuiUH7UJO+w==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5954.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c141c3e4-425b-4880-3611-08deb00d1867
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2026 09:59:02.3164
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4bY6hVFoOP04vnuS7tnckuZIobeCQsVjIZQYI7NDEGEAXkKPcWOpKPhXMfH6m0X07QJGFuPzJV71UUq4VRyVKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPFF1A08ABF9
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: 40AF851E2DA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-36318-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,bootlin.com:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,devicetree.org:url,BL1PR11MB5954.namprd11.prod.outlook.com:mid,sipsolutions.net:email];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[avinash.bhatt@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Action: no action

Hi Krzysztof,

Thank you for the detailed review. Please find our responses inline below.
We are actively addressing all comments and plan to send v3 shortly.

On Mon, May 04, 2026 at 12:53:25PM +0300, Krzysztof Kozlowski wrote:
> On Mon, May 04, 2026 at 12:53:25PM +0300, Avinash Bhatt wrote:
> > Add a devicetree schema binding for Intel discrete Wi-Fi 7 BE200 PCIe
> > adapters.
>
> A nit, subject: drop second/last, redundant "binding". The "dt-bindings"
> prefix is already stating that these are bindings.
> Just describe hardware.

Fixed in v3. Subject is now:
  "dt-bindings: net: wireless: Add Intel Wi-Fi 7 BE200 PCIe adapter"

> > The binding documents OEM platform configuration properties for
>
> No, describe hardware.

Fixed in v3. Commit body now describes the BE200 hardware directly.

> > +++ b/Documentation/devicetree/bindings/net/wireless/intel,iwlwifi.yaml
>
> Filename should match actual device compatibles. iwlwifi is driver, so
> not really relevant here.

Thank you for the guidance. Looking at the other bindings in the same
directory, we see two naming conventions coexist:

  - vendor,chip   - e.g. brcm,bcm4329-fmac.yaml, marvell,sd8787.yaml
  - vendor,driver - e.g. qca,ath9k.yaml, qcom,ath10k.yaml,
                    qcom,ath11k-pci.yaml, qcom,ath12k.yaml
                    (where ath9k, ath10k, ath11k, ath12k are driver
                    names, not chip names)

None of the existing wireless bindings use pciVVVV,DDDD.yaml as a
filename. Our intel,iwlwifi.yaml follows the vendor,driver pattern used
by the Qualcomm bindings. We also anticipate that future Intel Wi-Fi
devices - supported by the same iwlwifi driver - will use this same
binding, making the driver-aligned name forward-compatible.

Could you please point us to any guidance document that specifies
pciVVVV,DDDD.yaml as the required convention for PCIe device bindings,
or clarify whether intel,iwlwifi.yaml is acceptable given the above
precedent?

> > +title: Intel iwlwifi PCIe Wi-Fi devices
>
> There is no such thing as "iwlwifi" device. Again, describe hardware.

Fixed in v3. Title is now "Intel Wi-Fi 7 BE200 PCIe adapter".

> > +      Revision 3 layout: 4 chains x 12 subbands =3D 50 cells total.
> > +      Header (2 cells): ...
> > +      Subband index to frequency range mapping: ...
>
> Don't invent your own syntax. Drop. There are no other bindings using
> it, so why are you coming with something completely new?

Fixed in v3. The revision header cell and its const: 0 constraint have
been removed from all properties. Property descriptions remain as plain
prose bit and subband listings - the structured table headers with
revision fields and internal layout annotations are gone.

> > +        [0] revision - structure revision, must be 0x00
>
> What? If it is 0 then just drop it. Same comments everywhere else.

Fixed in v3. Revision cells removed from all properties. Each property
is now a scalar uint32 or a plain fixed-size array with no revision
header.

> > +        [1] value    - channel configuration:
> > +                       0 =3D active scan permitted
> > +                       1 =3D passive scan only
> > +                       2 =3D SRD channels fully disabled
>
> I have doubts this is regulatory/certification property.

intel,srd controls the operating mode of the ETSI 5.8 GHz Short Range
Device (SRD) band - whether the adapter performs active scanning,
passive scanning, or disables operation in that band entirely. This is a
platform-level OEM configuration: ETSI EN 301 893 and its country-level
transpositions impose per-country restrictions on the 5.8 GHz SRD
sub-band, and OEMs must set this property once per product to reflect
the regulatory certification of the platform. It is not a runtime driver
feature toggle - it is a system integrator constraint that determines
which regulatory mode the radio operates in for that band.

> > +      - items:
> > +          - const: 0
>
> Drop

Fixed in v3. Revision cell dropped. intel,srd is now a plain string
property.

> > +          - enum: [0, 1, 2]
>
> Use string

Fixed in v3. Changed to:
  enum: [active-scan, passive-scan, disabled]

> > +                       bit 26:    reserved, must be 0
>
> Bindings CANNOT be reserved.
>
> > +                       bit 28:    reserved, must be 0
>
> NAK

Fixed in v3. Removed all "reserved, must be 0" annotations. Bits 26 and
28 have no assigned meaning and are simply absent from the binding - the
binding only documents bits that are defined.

> > +        [0] revision - structure revision, must be 0x00  (regulatory-s=
pecial)
>
> NAK

Fixed in v3. Revision cell removed.

> > +      - items:
> > +          - const: 0
>
> No. If it is const, then it is implied by compatible.

Fixed in v3. Removed const: 0 from all allOf/items across all
properties.

> > +required:
> > +  - compatible
> > +  - reg
>
> Missing ref to ieee80211 schema.

Fixed in v3. Added:
  allOf:
    - $ref: /schemas/net/wireless/ieee80211.yaml#

Best Regards,
Avinash

-----Original Message-----
From: Krzysztof Kozlowski <krzk@kernel.org>=20
Sent: 05 May 2026 14:46
To: Bhatt, Avinash <avinash.bhatt@intel.com>
Cc: devicetree@vger.kernel.org; linux-wireless@vger.kernel.org; robh@kernel=
.org; krzk+dt@kernel.org; conor+dt@kernel.org; johannes@sipsolutions.net; K=
orenblit, Miriam Rachel <miriam.rachel.korenblit@intel.com>; linux-kernel@v=
ger.kernel.org; Guetta, Kobi <kobi.guetta@intel.com>; Grumbach, Emmanuel <e=
mmanuel.grumbach@intel.com>
Subject: Re: [PATCH v2 1/3] dt-bindings: net: wireless: intel,iwlwifi: add =
binding

On Mon, May 04, 2026 at 12:53:25PM +0300, Avinash Bhatt wrote:
> Add a devicetree schema binding for Intel discrete Wi-Fi 7 BE200 PCIe=20
> adapters.

A nit, subject: drop second/last, redundant "binding". The "dt-bindings" pr=
efix is already stating that these are bindings.
See also:
https://elixir.bootlin.com/linux/v6.17-rc3/source/Documentation/devicetree/=
bindings/submitting-patches.rst#L18

Just describe hardware.

>=20
> The binding documents OEM platform configuration properties for

No, describe hardware.

> platforms that use Device Tree instead of platform firmware methods.=20
> All properties mirror the existing equivalents in structure and=20
> semantics, covering SAR power limits (intel,wrds),
> 6 GHz AP type support (intel,uats), static power limit (intel,splc),=20
> channel puncturing (intel,wcpe), 320 MHz per-MCC enablement=20
> (intel,wbem), ETSI SRD channel configuration (intel,srd), 6-7 GHz UHB=20
> country enable bitmask (intel,6e-uhb), and additional regulatory=20
> override properties.
>=20
>=20
> Signed-off-by: Avinash Bhatt <avinash.bhatt@intel.com>
> ---
>  .../bindings/net/wireless/intel,iwlwifi.yaml  | 430=20
> ++++++++++++++++++
>  1 file changed, 430 insertions(+)
>  create mode 100644=20
> Documentation/devicetree/bindings/net/wireless/intel,iwlwifi.yaml
>=20
> diff --git=20
> a/Documentation/devicetree/bindings/net/wireless/intel,iwlwifi.yaml=20
> b/Documentation/devicetree/bindings/net/wireless/intel,iwlwifi.yaml
> new file mode 100644
> index 000000000000..210063c6183d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/wireless/intel,iwlwifi.yam
> +++ l

Filename should match actual device compatibles. iwlwifi is driver, so not =
really relevant here.

> @@ -0,0 +1,430 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) # Copyright=20
> +(c) 2026 Intel Corporation %YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/net/wireless/intel,iwlwifi.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Intel iwlwifi PCIe Wi-Fi devices


There is no such thing as "iwlwifi" device. Google for it - I see "Intel(r)=
 Wireless Wi-Fi Drivers for Linux".

Again, describe hardware.


> +
> +maintainers:
> +  - Avinash Bhatt <avinash.bhatt@intel.com>
> +
> +description:
> +  Intel iwlwifi IEEE 802.11be discrete Wi-Fi adapters connected over PCI=
e.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - pci8086,272b
> +
> +  reg:
> +    maxItems: 1
> +
> +  intel,wrds:
> +    description: |
> +      Wi-Fi Regulatory Domain Settings (WRDS). SAR (Specific Absorption =
Rate)
> +      transmit power limits per antenna chain and frequency subband. Val=
ues
> +      are 8-bit unsigned in units of 0.125 dBm.
> +
> +      Revision 3 layout: 4 chains x 12 subbands =3D 50 cells total.
> +      Chain A and Chain B are the two physical antenna paths; CDB Chain =
A
> +      and CDB Chain B carry separate limits for simultaneous dual-band
> +      operation.
> +
> +      Header (2 cells):
> +        [0] revision - structure revision, must be 0x03
> +        [1] mode     - bit 0: 0 =3D SAR disabled, 1 =3D SAR enabled;
> +                       bits [8:1]: set to 0
> +
> +      Followed by 4 chains in order: chain_a, chain_b, cdb_chain_a,
> +      cdb_chain_b, each containing 12 subband values:
> +
> +      Subband index to frequency range mapping:
> +        [0]  2.4 GHz  ch  1-13   (2412-2472 MHz)
> +        [1]  5 GHz    ch 36-64   (5180-5320 MHz, UNII-1/2)
> +        [2]  5 GHz    ch 68-96   (5340-5480 MHz, UNII-2)
> +        [3]  5 GHz    ch 100-144 (5500-5720 MHz, UNII-2e)
> +        [4]  5 GHz    ch 149-188 (5745-5940 MHz, UNII-3/4)
> +        [5]  6 GHz    ch  1-45   (5955-6175 MHz, UNII-5 lower)
> +        [6]  6 GHz    ch 49-93   (6195-6415 MHz, UNII-5 upper)
> +        [7]  6 GHz    ch 97-115  (6435-6525 MHz, UNII-6)
> +        [8]  6 GHz    ch 117-151 (6535-6705 MHz, UNII-7 lower)
> +        [9]  6 GHz    ch 153-183 (6715-6865 MHz, UNII-7 upper)
> +        [10] 6 GHz    ch 185-233 (6875-7115 MHz, UNII-8)
> +        [11] 6 GHz    ch 237-253 (7135-7215 MHz, UNII-9)
> +    allOf:

Don't invent your own syntax. Drop. There are no other bindings using it, s=
o why are you coming with something completely new?


> +      - $ref: /schemas/types.yaml#/definitions/uint32-array
> +      - minItems: 50
> +        maxItems: 50
> +
> +  intel,uats:
> +    description: |
> +      UHB (Ultra High Band / 6 GHz) AP Type Support (UATS). Per-country
> +      enablement matrix for 6 GHz AP types. Uses byte array format
> +      (DTS [ ... ] notation).
> +
> +      In the 6 GHz band, regulatory rules differ per country and per AP
> +      type: AFC (Standard Power), LPI (Low Power Indoor), and VLP (Very
> +      Low Power). This matrix encodes which AP types are permitted to
> +      operate in each country.
> +
> +      Revision 1 layout (339 bytes total):
> +        [0]   revision    - structure revision, must be 0x01
> +        [1+]  country_map - 338-byte matrix encoding AP type allowances
> +                            per country.
> +
> +                            Countries are identified by their ISO 3166-1
> +                            alpha-2 code (two letters, A-Z each). The
> +                            matrix covers all 26x26 =3D 676 possible
> +                            two-letter combinations (AA..ZZ), most of
> +                            which are unused (set to 0x0).
> +
> +                            Each country entry is 4 bits (a nibble). Two
> +                            entries are packed per byte: the low nibble
> +                            holds the even-indexed entry, the high nibbl=
e
> +                            holds the odd-indexed entry. For example,
> +                            byte value 0x53 means: entry[even]=3D0x3,
> +                            entry[odd]=3D0x5.
> +
> +                            The matrix is stored column-major by first
> +                            letter: all 26 second-letter variants for
> +                            first letter 'A' occupy bytes [0..12], then
> +                            first letter 'B' occupies bytes [13..25],
> +                            and so on for all 26 first letters.
> +                            26 columns x 13 bytes =3D 338 bytes total.
> +
> +                            Each 4-bit nibble encodes AP type allowances
> +                            for one country:
> +                              bit 0: AFC (Standard Power AP) allowed
> +                              bit 1: VLP (Very Low Power AP) allowed
> +                              bit 2: LPI (Low Power Indoor AP) allowed
> +                              bit 3: reserved, must be 0
> +
> +                            Note: each bit is only effective when the
> +                            corresponding control bit in intel,6e-uhb
> +                            is also set (bit 30 for AFC, bit 29
> +                            for VLP, bit 31 for LPI country-by-country
> +                            mode).
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/uint8-array
> +      - minItems: 339
> +        maxItems: 339
> +
> +  intel,srd:
> +    description: |
> +      ETSI 5.8 GHz SRD (Short Range Device) channel configuration.
> +      Controls how the driver handles the 5725-5875 MHz (5.8 GHz) SRD
> +      channels in ETSI regulatory domains.
> +
> +      Layout (2 cells):
> +        [0] revision - structure revision, must be 0x00

What? If it is 0 then just drop it. Same comments everywhere else.

> +        [1] value    - channel configuration:
> +                       0 =3D active scan permitted (default behaviour)
> +                       1 =3D passive scan only; device may associate and
> +                           transfer data but must not transmit probe
> +                           requests on SRD channels
> +                       2 =3D SRD channels fully disabled; the device mus=
t
> +                           not scan, associate, or operate on any of the
> +                           5725-5875 MHz SRD channels

I have doubts this is regulatory/certification property.

> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/uint32-array
> +      - items:
> +          - const: 0

Drop

> +          - enum: [0, 1, 2]

Use string

> +
> +  intel,6e-uhb:
> +    description: |
> +      6-7 GHz Ultra-High Band (UHB) per-country enable bitmask.
> +
> +      Layout (2 cells):
> +        [0] revision - structure revision, must be 0x00
> +        [1] bitmap   - UHB enablement control:
> +                       bit 0:     override control; 0 =3D use device def=
aults,
> +                                  1 =3D force-disable all countries not
> +                                  explicitly enabled in bits 1-25
> +                       bits 1-25: per-country/region enable flags:
> +                                  bit  1 =3D USA
> +                                  bit  2 =3D Rest of World (ROW)
> +                                  bit  3 =3D EU
> +                                  bit  4 =3D South Korea
> +                                  bit  5 =3D Brazil
> +                                  bit  6 =3D Chile
> +                                  bit  7 =3D Japan
> +                                  bit  8 =3D Canada
> +                                  bit  9 =3D Morocco
> +                                  bit 10 =3D Mongolia
> +                                  bit 11 =3D Malaysia
> +                                  bit 12 =3D Saudi Arabia
> +                                  bit 13 =3D Mexico
> +                                  bit 14 =3D Nigeria
> +                                  bit 15 =3D Thailand
> +                                  bit 16 =3D Singapore
> +                                  bit 17 =3D Taiwan
> +                                  bit 18 =3D South Africa
> +                                  bit 19 =3D Philippines
> +                                  bit 20 =3D Serbia
> +                                  bit 21 =3D Indonesia
> +                                  bit 22 =3D Azerbaijan
> +                                  bit 23 =3D Paraguay
> +                                  bit 24 =3D Vietnam
> +                                  bit 25 =3D India
> +                       bit 26:    reserved, must be 0

Bindings CANNOT be reserved.

> +                       bit 27:    enable VLP active scan, SoftAP, and
> +                                  P2P-GO operation in Japan
> +                       bit 28:    reserved, must be 0

NAK

> +                       bit 29:    enable VLP (Very Low Power) mode per
> +                                  country-by-country table
> +                       bit 30:    enable AFC (Standard Power) mode per
> +                                  country-by-country table
> +                       bit 31:    LPI override mode; 0 =3D use grouping
> +                                  mechanism, 1 =3D use country-by-countr=
y table
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/uint32-array
> +      - items:
> +          - const: 0

No. If it is const, then it is implied by compatible.

> +          - {}
> +
> +  intel,regulatory-special:
> +    description: |
> +      Regulatory Special Configurations.
> +
> +      Layout (2 cells):
> +        [0] revision - structure revision, must be 0x00

NAK

> +        [1] bitmap   - configuration flags:
> +                       bits 0-3: reserved, must be 0
> +                       bit 4 =3D Australia UHB extension
> +                       bits 5-31: reserved, must be 0
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/uint32-array
> +      - items:
> +          - const: 0
> +          - {}
> +
> +  intel,activate-channel:
> +    description: |
> +      Indoor channel activation bitmask. Sets specific frequency bands t=
o
> +      active (rather than passive or disabled) when the platform is
> +      confirmed to be operating indoors.
> +
> +      Layout (2 cells):
> +        [0] revision - structure revision, must be 0x00
> +        [1] bitmap   - per-region indoor activation flags:
> +                       bit 0 =3D enable EU U-NII-1 (5.2 GHz) for indoors=
 only
> +                       bit 1 =3D enable Japan U-NII-1 (5.2 GHz) for indo=
ors only
> +                       bit 2 =3D enable China Mainland U-NII-1 (5.2 GHz)
> +                               for indoors only
> +                       bit 3 =3D enable USA U-NII-4 (5.9 GHz) for indoor=
s only
> +                       bit 4 =3D enable WW U-NII-1 (5.2 GHz) for indoors=
 in any
> +                               country where the band is permitted
> +                       bit 5 =3D enable Canada U-NII-4 (5.9 GHz) for ind=
oors only
> +                       bit 6 =3D enable USA + Canada + WW U-NII-4 (5.9 G=
Hz) for
> +                               indoors only
> +                       bits 7-31: reserved, must be 0
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/uint32-array
> +      - items:
> +          - const: 0
> +          - {}
> +
> +  intel,force-disable-channels:
> +    description: |
> +      Selective Wi-Fi band force-disable bitmask. Allows the platform to
> +      permanently disable specific frequency bands regardless of regulat=
ory
> +      domain.
> +
> +      Layout (2 cells):
> +        [0] revision - structure revision, must be 0x00
> +        [1] bitmap   - per-band force-disable flags:
> +                       bit 0  =3D force disable 2.4 GHz (channels 1-13)
> +                       bit 1  =3D force disable 5.2 GHz (channels 36-48)
> +                       bit 2  =3D force disable 5.3 GHz (channels 52-64)
> +                       bit 3  =3D force disable 5.5 GHz (channels 100-14=
4)
> +                       bit 4  =3D force disable 5.8 GHz (channels 149-16=
5)
> +                       bit 5  =3D force disable 5.9 GHz (channels 169-17=
7)
> +                       bit 6  =3D force disable 6.2 GHz (channels 1-93)
> +                       bit 7  =3D force disable 6.5 GHz (channels 97-113=
)
> +                       bit 8  =3D force disable 6.6 GHz (channels 117-15=
3)
> +                       bit 9  =3D force disable 6.8 GHz (channels 157-18=
5)
> +                       bit 10 =3D force disable 7.0 GHz (channels 185-23=
3)
> +                       bits 11-31: reserved, must be 0
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/uint32-array
> +      - items:
> +          - const: 0
> +          - {}
> +
> +  intel,11be:
> +    description: |
> +      802.11be (Wi-Fi 7) per-country enable bitmask. Controls whether
> +      802.11be operation is permitted in specific countries.
> +
> +      Layout (2 cells):
> +        [0] revision - structure revision, must be 0x00
> +        [1] bitmap   - per-country enable flags:
> +                       bit 0 =3D enable 802.11be in China (CB/CN)
> +                       bit 1 =3D enable 802.11be in South Korea
> +                       bits 2-31: reserved, must be 0
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/uint32-array
> +      - items:
> +          - const: 0
> +          - {}
> +
> +  intel,splc:
> +    description: |
> +      Wi-Fi Static Power Limit Capabilities (SPLC). Sets the platform th=
ermal
> +      power limit for the Wi-Fi core in mW. Omit this property entirely =
if
> +      no platform power limit applies; the device will use its certified
> +      maximum in that case.
> +
> +      Layout (2 cells):
> +        [0] revision    - structure revision, must be 0x00
> +        [1] power_limit - maximum platform power budget in mW, must be
> +                          non-zero (a zero value is equivalent to omitti=
ng
> +                          the property)
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/uint32-array
> +      - items:
> +          - const: 0
> +          - minimum: 1
> +
> +  intel,wcpe:
> +    description: |
> +      Wi-Fi Channel Puncturing Enablement (WCPE). Enables 802.11be chann=
el
> +      puncturing for specific regulatory domains.
> +
> +      Layout (2 cells):
> +        [0] revision   - structure revision, must be 0x00
> +        [1] puncturing - per-country enable bitmask:
> +                         bit 0: 1 =3D channel puncturing enabled for USA
> +                         bit 1: 1 =3D channel puncturing enabled for Can=
ada
> +                         bits 2-31: reserved, must be 0
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/uint32-array
> +      - items:
> +          - const: 0
> +          - {}
> +
> +  intel,wbem:
> +    description: |
> +      Wi-Fi 320 MHz Bandwidth Enablement per MCC (WBEM). Controls whethe=
r
> +      320 MHz operation is permitted in specific countries.
> +
> +      Layout (2 cells):
> +        [0] revision       - structure revision, must be 0x00
> +        [1] wifi320mhz_mcc - per-country enable bitmask:
> +                             bit 0: 1 =3D 320 MHz enabled for Japan
> +                             bit 1: 1 =3D 320 MHz enabled for South Kore=
a
> +                             bits 2-31: reserved, must be 0
> +
> +                             Each bit takes effect only if the installed
> +                             module is certified for 320 MHz in that cou=
ntry.
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/uint32-array
> +      - items:
> +          - const: 0
> +          - {}
> +
> +required:
> +  - compatible
> +  - reg
> +

Missing ref to ieee80211 schema.


> +additionalProperties: false

Best regards,
Krzysztof


