Return-Path: <linux-wireless+bounces-37944-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8O5PKrqgN2rvPQcAu9opvQ
	(envelope-from <linux-wireless+bounces-37944-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 21 Jun 2026 10:28:42 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0135F6AA748
	for <lists+linux-wireless@lfdr.de>; Sun, 21 Jun 2026 10:28:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=NgqDyZMI;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37944-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37944-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B1DC130103A1
	for <lists+linux-wireless@lfdr.de>; Sun, 21 Jun 2026 08:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5B2D273D6D;
	Sun, 21 Jun 2026 08:28:37 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68C801A6836;
	Sun, 21 Jun 2026 08:28:35 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782030517; cv=fail; b=aFnOU8/yY8HqMMsmx5IROPzc0FOBLJQg/Opr1m7oDM46MzFBMrCRAHy0iWI2UH1j5StxuU8tlp+qv4N7eblOivtKHGRdh70cCEKUMZB2Xztl+HCpUMqIKmVQVbUpsJPPpktdnxL5k4dqDSqxkeQMTVFbf9jKCZvlFV65GUTH5xk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782030517; c=relaxed/simple;
	bh=64w3pEGbEqiZmxoNZGbSJKA8Io/Go+EAyRQfdrE53Wk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fR1CkQqcDYp+mL4SfK4Twj56Xcd1JaWVyIwiVAoYzw4rJ+13UtQpl/eXkr05CqTZpEjHJOHu7fEi0gHCztox2AcQ5lQ0FxTNEnWH3sCNI0iXL7Avk4Z7lMNm9quCDcxPq/yp4iPVfNJiWGSdaSeWG5o+EUdgWUtpYqUdVl9wydc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NgqDyZMI; arc=fail smtp.client-ip=192.198.163.7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782030516; x=1813566516;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=64w3pEGbEqiZmxoNZGbSJKA8Io/Go+EAyRQfdrE53Wk=;
  b=NgqDyZMIwsZeW1qZYJFj7z9KD8YWHwlAbriD+j1iRDu7izSBB4yopS2n
   OfgeJGoeQvClIlWAdVEiS8Qf1B/NDxohmAyPhUuuFI993s2TYlQbDoCUO
   0nuz55sQBR9oTlTiKgs2pnes2EhPI2ykJTwaRHrhsD76ZQgSwyUcAt0zC
   /tp2W+Hg0A3N3/Chmj/KOK1A3A+F2xY40038hzLsXmQtIorzvQVybOtmE
   uh3B33I6ty5dAzLnShOUR2bVtEcFPdcaLsimPQpscenm9vJGo2+BxjqJw
   majWY6hd4blwnRWG50sthtHIBHFZcvNRTLfvUigMrjbDAkrrVo/7yo081
   A==;
X-CSE-ConnectionGUID: FcZ+ObfiReqbzkN55fW91w==
X-CSE-MsgGUID: S71YYwCyRf+jocAxicpPWg==
X-IronPort-AV: E=McAfee;i="6800,10657,11823"; a="108338154"
X-IronPort-AV: E=Sophos;i="6.24,216,1774335600"; 
   d="scan'208";a="108338154"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2026 01:28:35 -0700
X-CSE-ConnectionGUID: A2a/9AceT2eQWH1FdLj9TA==
X-CSE-MsgGUID: 9I3YG0pnQw2RHt86b8D17Q==
X-ExtLoop1: 1
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2026 01:28:34 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sun, 21 Jun 2026 01:28:34 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Sun, 21 Jun 2026 01:28:34 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.0) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sun, 21 Jun 2026 01:28:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cVAq4v8ydC4CsLSU3O95Slxv+/TW2nYSpQYMvC0IJCFGIPAXuGap6yKgRW7m4Zy8eEvl5/hb5vnTQc+kCfRWfWMq6TRQNbTApeE6S5/p7qyZmhzY6SZ7UMFo+PgNNvjk4tfS6ElFCpPAWhs40tpVUECIfAfdiP+TeZzxBxR/UwPhrfypF+6SM4FXJ77UE2MWH89g5OdxXoiHHobkKmJzCXxK5UhNQFNzzkO/psb+obCfsc6tHk7s+77WZJXrNzY1taKICmtTcsGWNJPZnWW81/E3HbwJ1paJTQzaB2CZz9YMmH6xZnIeUsemR3DSTiTJSgCh0Y5NakarLqPGfp0kYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=64w3pEGbEqiZmxoNZGbSJKA8Io/Go+EAyRQfdrE53Wk=;
 b=fNdw+Ci2VBhnBfTMriPKNnzR5A2ymxGE8Ok9CtZBc68H5FYE7mPyowXd7QaRB4es77OMDxPx3kcp0HxlAKueu9xLHPaLPPuUqkoMpOu4ABKhE6xorAIFN22bLKxerHJ83Ok1YyOD6eoVtMdmhJVJ0y6DvmAvqcy+Sr8sxWUumsGHoE81RFjaWNdkIrJ2uV3PjM+c45QI/7gY1hW3/Uqu9dpnll8TGWiaPWqx7pYus2Ww2mo5EY3XHflyOds96FQY+HqMGEBfrQtos4OAmVfF2aEW1FF2+tgn4fA5zmJXE3LvMznleaZkFGeOCmbJzjnmGh5ViC5TtlNPHHlnnfWA9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB7494.namprd11.prod.outlook.com (2603:10b6:510:283::18)
 by SJ0PR11MB5181.namprd11.prod.outlook.com (2603:10b6:a03:2de::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.18; Sun, 21 Jun
 2026 08:28:26 +0000
Received: from PH0PR11MB7494.namprd11.prod.outlook.com
 ([fe80::e642:c73c:6d80:5083]) by PH0PR11MB7494.namprd11.prod.outlook.com
 ([fe80::e642:c73c:6d80:5083%5]) with mapi id 15.21.0139.009; Sun, 21 Jun 2026
 08:28:26 +0000
From: "Grumbach, Emmanuel" <emmanuel.grumbach@intel.com>
To: "lukas@wunner.de" <lukas@wunner.de>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "Korenblit, Miriam
 Rachel" <miriam.rachel.korenblit@intel.com>, "helgaas@kernel.org"
	<helgaas@kernel.org>
Subject: Re: [PATCH] PCI: Disable NoSnoop and Relaxed ordering for Intel
 wireless BE200
Thread-Topic: [PATCH] PCI: Disable NoSnoop and Relaxed ordering for Intel
 wireless BE200
Thread-Index: AQHdAUruh/HWEZwEC0iMA6tK8iUSn7ZIqESAgAAE+AA=
Date: Sun, 21 Jun 2026 08:28:26 +0000
Message-ID: <3a421216a83574232f9311849590fb7c4a358325.camel@intel.com>
References: <20260621065451.21650-1-emmanuel.grumbach@intel.com>
	 <ajecdx3HYj5rqJBZ@wunner.de>
In-Reply-To: <ajecdx3HYj5rqJBZ@wunner.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.60.2 (3.60.2-1.fc44) 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB7494:EE_|SJ0PR11MB5181:EE_
x-ms-office365-filtering-correlation-id: 66a2287a-ab21-4866-4981-08decf6f10e6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|22082099003|18002099003|56012099006|11063799006|4143699003|38070700021;
x-microsoft-antispam-message-info: C9npviLgLq8fULj9Ng+D6DLoZPCO+OMM8zbtDFpjghzm3IlaXutXnDnXLWALEqc3FPJIb94eXqugx9iSOfiMgT0Il8ONpeCxsfOBLLiee5tN51uHmrBZkCcQQStQAaPxobIN43LUi3OrLfvSSeNe0IrJpzc6G5Xf0Yv0/lWj27XFCgDeqq5FVBhRglCVcapYqVR0sDHoTxSYpumziov+VQdMUQT8HhQFM1pl9kdIrzTfdZlhnud4kL9J4qofsU7IgmFMCHr6ciH8yNphBk5+SM2BaAY6rrNw4QGnPunwOtReU7QGZk0jjyqyI64Ataz0wrYwaM+X/t/FmX+oi8qEXmF7LQPGVR28vW60C0vbOa9XGkHbe7JWa60LPu6RS+CkE5WBR3FNoSprm4TE80u2ri64X6VoXwGNFDoTfngU3qlvMc0mIOIxSNzpFhRTcjShGe4xpcZcYBnfikJdtDdJjBXnogC15kCs6NlM7jG61Njsaj1yfMkVfEDC75wXueHl+WhmeIUfabKvfG8iP6C3mmtWo5LVVCq7iWwTLvvhd8sQtWc1Z2oyY6CdGO+ok3e9l0MgPK626rUfV+mcZ782H9svKuBR/RGc494/pTTeHv3BCivfLSASEOlxwwuxBfSQNmfWvvIuWIdU+rGZ2eCb7w1TsS+85RVhNa9yyynsbB01QXQGXZAij6lVQemGG+x5qfADngL0xOAjowTMn/is5FXDBYMJA4N5zsX3/tnugWg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB7494.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(22082099003)(18002099003)(56012099006)(11063799006)(4143699003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bmFTY1BpZE52T1dDbE0rZTlCMkY0Wjl6cXRKSkNlVXFaN0I2RHlaWDJ0ZDNC?=
 =?utf-8?B?RmFwczFkQXUwTGdHYTJrMDFNajhzMEpqSERIa3ZJZ2hERTFHN0FlWTl0dG5v?=
 =?utf-8?B?ZzgvU3QwWmV6ZWx1TzNFc2RUT0xwTllENmJuRzF0b2xyWWtKb3h2L1NJczd1?=
 =?utf-8?B?ekkwZ0xDdHJGUHZLZ1lrS2JWa0sxUVgwV0wwRTNlekdBZ1grYytsaEtvdTND?=
 =?utf-8?B?VGNNZG1uQmF5N08rbWJlWWJxYU4zU21IMlVUVXFDOU1ocjhJaHErTkhHelN5?=
 =?utf-8?B?VzNaK1o5bnVrT2I3blplRHhzRjZzQUlzVC9Zc3p5RG1WM3UybDlUS3UrSm5o?=
 =?utf-8?B?MFJrVTFsV0YwY0QyRnA0cVBncXd6UHdFTDNMUWNscktCbnNmNXFJQnJ4cnJF?=
 =?utf-8?B?TTkrRXJ0RGFXVm1IalZmV3oycTk0NjZJd2JLUWVMTTNiVnd1bkVsdHI3OEtD?=
 =?utf-8?B?Y3FqZmFCeUI5ZGl1VEVhVk1HRW1Qbk5EMERqY3JBQzdUU1BCOGo3L0hRY2Nn?=
 =?utf-8?B?dHhyUFE2aEw4UjNMK2VBdHE4NzEzL0RKbDlraDU5ZVIxVS93MjVSTWF0Z0x5?=
 =?utf-8?B?QUlpSU9TY1cxSE1ONmd4U3RlSytjRG9WVzZLb0ZMdzhzRjZjUk0xYkp1ZUlO?=
 =?utf-8?B?WVA0eDFmZHdRNFEyVFRXL3dGWDBheXZLcjVwQXZsemdMcDQvNVZ3a3E0SS8r?=
 =?utf-8?B?c3pnYWNSMTBJL0xmNDM3ZEE5SkdIbENIa3NxdEFGTkZsOVRaTFZMMG80NEdl?=
 =?utf-8?B?U1hEaTdlK0hGVTFOZzEwQ0FSUk1zZFZSeFFMTmk0ZzdEaU1RQU5uckNNMCtn?=
 =?utf-8?B?SDh5N1RCbGFDVnc1bXhTWklhaVRKWk4wZWZxYWJ6emtlMzJGcjNnQlhqUmJX?=
 =?utf-8?B?LzJxTkwrS0hQbitCZ0lCdDdmeHdWb3FnWHpVZVk2dFNTUEk5WkFHbDQrZU5U?=
 =?utf-8?B?S0k0ZmdFNnpib3JFaE1jQUkyU0VINllXa3A2aG5kVEZmQ1o0R1N3N2xUTlhp?=
 =?utf-8?B?OXl6enVka2szeG1QYjNoc3RLOUlweS9kSjJSeEFqazlLUHByalBpOUhoN0Zv?=
 =?utf-8?B?MENiSUhaUnVDd3JQN2VNRXlNRkxPYlNEOUwwM0NpTC9PRkpEVEo4NFo0aFZy?=
 =?utf-8?B?WW1paytKYmZxUktZS0Zydkg5cnJaR1JUSFM5WXpMSkpiU0ZJNXJveVl2cmFt?=
 =?utf-8?B?K0F2UldQWldQVnBNRHEweGlEbndwbTk2cldPdnh5aE9sRWhhS0p2MnlDUzJz?=
 =?utf-8?B?aThRQ0NqMlNJSGN2TlVFd2d3Qmp5VUtVTyt0VmVYT3dBQkpnRjVRN0Mwckkx?=
 =?utf-8?B?aU41ZGI2T2JTajRWWlJvTHI5MEdaN3VIKzNFV1J4aWpDU3djbGFHSURyUlNh?=
 =?utf-8?B?TytZSy9mQVpsVDlacTRxd1B0VHVUalloVWc0VVNPS0NoNkx3NXcvYU4rc3JQ?=
 =?utf-8?B?RWxjUHVTMlJZVHZ3SXRkZjQ2LzhQY3lvcEltbjR0L21uRS9HVE4yUlVZT0pP?=
 =?utf-8?B?cytLZkJMNFV1TDVrTjhZMDdEeDN5WlhyMHY1QnVub0dWZ2s2bjRzV05mNHFP?=
 =?utf-8?B?QS90eHJXdXI2alg1V0tGV0tsSWtXbTNFdEJZRkpwZmovUys3MUh5ZDdoSVBa?=
 =?utf-8?B?V1MrNUhlRHNCK25nNWtXSzFoRy9tK0l0bDZ5V2VNTVRPczVWbENvWk5aY3hU?=
 =?utf-8?B?dS9XOGFFUytaUU1vL0p0dklKeS9Zemp1Z2FUelJlaHdOU1dTc2lpZUFSeldx?=
 =?utf-8?B?ZitUaWw0SVlySThZeW5CTVNHVGwvdlhJcFlZY1dUSm05QVhabFVXak4yUFky?=
 =?utf-8?B?WTRtcnU1S2ZBY3p3WGt6MU41RFJ1S20yVWlucGNDNitVR3dqZTNESGsvNjc4?=
 =?utf-8?B?YXJ2d25yYXZhaGxpdjNUQVQyZnNaaGJXTkhlcitFZ1Z2UllxN1I2aThGcTdv?=
 =?utf-8?B?ZUU2LzkwbDc5ZEQ1Nit5ZnpIcjdwWmVNb1Z3VmlpTUlMTmxkQjNza2UrV0xU?=
 =?utf-8?B?STNjcVl2WmVsQ1B5clZlT1pscDVJN2pyWU9Ta21GdGwwNHJhbU5wZ0ZJRWtK?=
 =?utf-8?B?UjVkQXFzSkJJRk15RkNuRVdqRDAvZzZpZy96M1pYV3JCMWpJZVZUb25aa3lo?=
 =?utf-8?B?N3ZtM3FIZWhJVE1Pb1g5WXU3UGJ5WVgwMWcvY3hYei9Zdng5cDNmd2hKQSt6?=
 =?utf-8?B?YXBVTjNpNlNiNGVmV2hENkUzNE5kLzM5amNERmZEa0lZTnVGNWw5eTdXSHFG?=
 =?utf-8?B?emFWZVJNVU12TCtjaDJkRDZ5ZEMwUWlrZnJER0I5MGhPYkNlTTVxdnF3U2Nl?=
 =?utf-8?B?YkdNWjAwbDNyTk1QZEY0WDV6V1pHbUk3OUkyeFBQdlRWM21vRGMzQVpUdjJW?=
 =?utf-8?Q?WUZK7CjPjMVFmV6I=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <211F1EF455A9474883275170D020FDDC@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: kpgWnXT9arjsoB31w1onDqET15073PPrJ9/ANzBC9QCjoqm7h0AXYLFlJCwEg+4alGeNeDEar7anVWakkwL73VUDoftklM+ZPd+zJcGCAoLEHSoBE16DKkaFUNUiJPlkKHz8lGNYVBoWO3VrvLV2cAxw6Hp/EUajnpGnx/xjrbRanJNeXgQwVYLmhPP9tx2NyUkCyRLe/kUntlSc1h3zsSZCE6SVWdeRojmqV64l8qTURy4YGdLSO9wciEx/RjJKEnMwwZkLrXEn9vge2XUf3pBP6Y+dsvxswsAJ8JiL+SKtLD08beOXi/dMjPt2M4RdaDOH39fs4U8TS4OCNLiU6Q==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7494.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66a2287a-ab21-4866-4981-08decf6f10e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2026 08:28:26.4787
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JrZ86NLWidh3Pboxh6gI37zA8367EKd7SCD5zLC4QyoFQkM6P3yd6NES18s13hkIvRL4ZwjKPKLoe+0qatdYHXAcraUrYz+VjNti/d8jLcQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5181
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.06 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:lukas@wunner.de,m:linux-wireless@vger.kernel.org,m:linux-pci@vger.kernel.org,m:miriam.rachel.korenblit@intel.com,m:helgaas@kernel.org,s:lists@lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[emmanuel.grumbach@intel.com,linux-wireless@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-37944-lists,linux-wireless=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:mid,intel.com:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp];
	DKIM_TRACE(0.00)[intel.com:+];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[emmanuel.grumbach@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0135F6AA748

T24gU3VuLCAyMDI2LTA2LTIxIGF0IDEwOjEwICswMjAwLCBMdWthcyBXdW5uZXIgd3JvdGU6DQo+
IE9uIFN1biwgSnVuIDIxLCAyMDI2IGF0IDA5OjU0OjUxQU0gKzAzMDAsIEVtbWFudWVsIEdydW1i
YWNoIHdyb3RlOg0KPiA+IFRoZSBJbnRlbCB3aXJlbGVzcyBCRTIwMCBkZXZpY2UgZmFpbHMgdG8g
Y29weSB0aGUgVExQIEF0dHJpYnV0ZXMNCj4gPiBmcm9tIGENCj4gPiBSZXF1ZXN0IHRvIHRoZSBD
b21wbGV0aW9uLg0KPiA+IFNpbmNlIHRoZXJlIGlzIG5vIGNhY2hpbmcgaW52b2x2ZWQgdGhlIGRl
dmljZSBhbnl3YXksIGRpc2FibGUgdGhlDQo+ID4gTm9Tbm9vcCBhbmQgUmVsYXhlZCBvcmRlcmlu
ZyBvbiB0aGUgcm9vdCBwb3J0Lg0KPiANCj4gSXMgdGhlcmUgYSBwdWJsaWMgU3BlY2lmaWNhdGlv
biBVcGRhdGUgd2hpY2ggY291bGQgYmUgbGlua2VkIGluIHRoZQ0KPiBjb21taXQgbWVzc2FnZSBh
bmQvb3IgY29kZSBjb21tZW50Pw0KPiANCj4gDQoNCk5vdCByZWFsbHkuDQpXZSBqdXN0IGhhdmUg
dGVzdGVkIG91ciBkZXZpY2Ugd2l0aCBKZXRzb24gVGhvciBhbmQgc2F3IHRoYXQgaXQgZG9lc24n
dA0Kd29yay4gSGFwcGVucyB0aGF0IHRoZSBQQ0kgY29udHJvbGxlciBvbiBKZXRzb24gVGhvciBp
cyBkb2luZyB0aGluZ3MNCnRoYXQgdmVyeSBmZXcgUENJIGNvbnRyb2xsZXJzIGRvIGFuZCB0aGlz
IHVuZGVyY292ZXJlZCB0aGlzIGJhZA0KYmVoYXZpb3Igb24gdGhlIEJFMjAwIHNpZGUuDQoNCldl
IGRvbid0IGhhdmUgYSBtb3JlIGZvcm1hbCBwdWJsaWNhdGlvbiBhYm91dCB0aGlzIGlzc3VlLg0K
DQoNCj4gVGhhbmtzLA0KPiANCj4gTHVrYXMNCg==

