Return-Path: <linux-wireless+bounces-36119-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kKebDiD//WkTlwAAu9opvQ
	(envelope-from <linux-wireless+bounces-36119-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 08 May 2026 17:20:00 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 969A84F8999
	for <lists+linux-wireless@lfdr.de>; Fri, 08 May 2026 17:19:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A15883037414
	for <lists+linux-wireless@lfdr.de>; Fri,  8 May 2026 15:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F08743F23DA;
	Fri,  8 May 2026 15:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FbAlsrzO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90F6D2AD00
	for <linux-wireless@vger.kernel.org>; Fri,  8 May 2026 15:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778253034; cv=fail; b=nwfBs9G8ToFkt7ujGxlF+pt6YjCxWN9iwTYVzxNFJvytCl5VA0COAPvlDsDdtEMq3XgEK8t8QTzIt75t1zi0qeqRkHDyPtq5JZG0WIyLBhQtCF66M61Au5XSXK5ceFbwPHNBFgiqpj1RyXcbfca8/sdszk3cqCClG1zYphT0/hk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778253034; c=relaxed/simple;
	bh=3zHuXyIRRXkBCz9wYHLjGDEnL02yi6chDRXkJzcRQ78=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=g122S41mKWC5YHSWkc1cpGSn+NcyMfYoyKtJfytQ47LPg9fYRDvN7ubfIDfvgKGw4rPyDYIMeXOqRGCVvI81p7lLKpBcqNHAHyFrIE+YtGPmTdjPKEGTb2deOjyKKYB2kmQnn8G62Lii7DKUSy8ZZ6KHEsJvEpt7kwngoyii6UQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FbAlsrzO; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778253033; x=1809789033;
  h=from:to:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=3zHuXyIRRXkBCz9wYHLjGDEnL02yi6chDRXkJzcRQ78=;
  b=FbAlsrzOPjDY8qvOlyyw/OqJUu/FWZE7yelUKOHfOVzADU+JRAgiP67k
   +yskj5f1jxjK8WMLc75pAyXQMIvOyBlLqhtnI3CCwB3tnhHtqZ/tWasi6
   xVOQv/PjQwzFdrBVQDTI5/896UbVqtMxBtOa1Vq9di4u+Ch0xbjsH3roC
   jc0rbLfNtVvYQCAP3guPXCpvrXQqK4SJ9PIPmR4aA6Yeg0yg+FCKkm/xr
   pGDtqxgnC1U+NDFHeZD0o8pLXJGMIbNgGeubpOOhO0ob/e8z0voBXC+i0
   eKC3FDB4VM6tevmkQ1h+RrlUd4wUuewmiDVd89ar6KdyRr1xrKNolrYPm
   A==;
X-CSE-ConnectionGUID: DOZIB3EISmCO4PpEdTdSwQ==
X-CSE-MsgGUID: EqvJG+rjT2GTf+fqYHkTdQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11780"; a="96793937"
X-IronPort-AV: E=Sophos;i="6.23,223,1770624000"; 
   d="scan'208";a="96793937"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2026 08:10:33 -0700
X-CSE-ConnectionGUID: AT+7ukQKRwuSSEbxSc1vAA==
X-CSE-MsgGUID: Tvu4ye6vS0WqbiDIM+Vv4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,223,1770624000"; 
   d="scan'208";a="241785111"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2026 08:10:32 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 8 May 2026 08:10:32 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 8 May 2026 08:10:32 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.49) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 8 May 2026 08:10:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N8Owyw0RN2dhB7iu6KM4bnzotSLcEJfAT1uXYmAXTRw4OKNqOtknXCXPNxrsi9hCOsTaGY9fT5ZnxyL6ettcQYu/VLSL1WvQ57vF/OImvE1zmNmuY9v9DRjH9CEphLh6s+IQQinGF6IDz978TgoJSxHUhuwBarYUDKky/CUgPFAIABCAQzeq4uBuGxuSjCb5DPjqlkzoY51NrgREkoeIZgDrig8022YiuhtfvtAkU31WLo0/VcLKqfRUr5C2cYQ/xE1ISWCo2nL9GAlQ4mMW7W6+tEjHQSNN6HVIgZB0KK3tnyvkocP6y3dFQIfSCv3gNbaTMr+OPm0ehwTMrkiFiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3zHuXyIRRXkBCz9wYHLjGDEnL02yi6chDRXkJzcRQ78=;
 b=N3k4rGZOulojw4HmcrcBqRxcL0P9TDMo35NxyI5p0HN1dLs/LqTATHewFq5MahLjcm5SKl+/rPLYeTnqpGjlJCrxJkw3i+8Grpt6rWQWA37f2aA+p7U6uBBs2ENt4OZswlAmBCGdDH8m29KKF2+Uzqw3rIq6JVhuGndJ8fOdzjtrmzf65rK5ZGrvUe3zGFStOcr08v0cF9GrUVVDiIv7Go5uuCjOehh4d7UF5M+otGZ9XSWpYO6CD1aupM9zSYqtAvMKa05E10WT7SsRsyVcjQ+ADmujSk14N8TgtTZ+cYPScA+NIRo5qFfiwg8/Qf712t9uNkTzyEOiWwhjyOr3oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CH3PR11MB7866.namprd11.prod.outlook.com (2603:10b6:610:124::9)
 by IA0PR11MB7695.namprd11.prod.outlook.com (2603:10b6:208:400::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.20; Fri, 8 May
 2026 15:10:29 +0000
Received: from CH3PR11MB7866.namprd11.prod.outlook.com
 ([fe80::5e25:8f9f:880b:bbff]) by CH3PR11MB7866.namprd11.prod.outlook.com
 ([fe80::5e25:8f9f:880b:bbff%3]) with mapi id 15.20.9891.019; Fri, 8 May 2026
 15:10:25 +0000
From: "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>
To: linux-wireless <linux-wireless@vger.kernel.org>
Subject: pull-request: iwlwifi-fixes-2026-05-08
Thread-Topic: pull-request: iwlwifi-fixes-2026-05-08
Thread-Index: Adze1DYY5HTayUnmSRqkmYQtbIh6/w==
Date: Fri, 8 May 2026 15:10:25 +0000
Message-ID: <CH3PR11MB786649D3E235DED83DF9928AA33D2@CH3PR11MB7866.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR11MB7866:EE_|IA0PR11MB7695:EE_
x-ms-office365-filtering-correlation-id: 861bda78-d0ab-4176-cb9d-08dead13eee7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700021|56012099003|18002099003;
x-microsoft-antispam-message-info: OPa9kZ2WJ8LUCqTO/pOrZa+Z30lxDbFQhKuu4G970uvk3LQSpPI53bTpWR9FC9YYbv3WhGPicntsiPsT03/ovsAB7nK9u904Qlc252X1WySBUN6b+T6uqMlCu/Gmu6NInIvsLHSG9TfRmll5jIrn852rTeg43Z0KUvZmJBlaX46epo30CeXba7EioaqzF2dMg+0GBelRmuWJs/MFvfZjOI52o+9DJe8f4iQtoqlFL7+/88m7kG7Tb1AJ3Ca0wTj5YDlGk6MH/HpHeChkNgjC9vmWcedkHvdDc8SjjXQTRSu6aqtX9y1rj8N70tMtmZnKVHRT0AErnScCL5rbvGiteng8FEmHvms6Ec4bfUzeq8MZE2v5/LipNeqSR9htSyGV36fIaBKbbPRRIM8nhb9yTB2e/t+UzDkBC5rDT1Vk4rYbW0jjjurlGF2BPueNy7D9yLBsALmKuS/4TdUo+8BvFp5EJJ3xKjzOSEgwsywXrR8ndPfoivO4ef5AGqv2Uoy+/7pCdkhhO4pomAVSbJFKlPcvrTrGUzd59zUG6IS/cEDmKi6h1kwJmikyq8eX9AAk55+fFyy8KaoR2/9t3QjuVOhaolaAvfLqcjCzt3wur8u+Kgr+DMl/3lnofTzGp0lBj4svdhhgnhD/XImtlKfRL6JUfz281FJHjbm3sAXbNahlIh0Kry+nB0SDoGCVjhnPAR4fPv1LmmHb1S9JezXwZQh4wOfI7woc05Js5vCM9kn4Kbyzs3IQ6J3hmQmObOuT
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB7866.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(56012099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?amZ1V3BZMklURDg1cEJOaUZxQzBHRmwxOFJyMEpFbVNFOHRDanpwMTNyQjVL?=
 =?utf-8?B?c1A4TFl6RnV0dndQUVJyUi9lVkVLWW5pTzlENzR3eGgxV2VoSDEvR1crWk1w?=
 =?utf-8?B?UGI4aFlYSW8wTERGaWFWaU9paGFRWFFlNXVPZWNKTUsvNDNyZVkrN1dXeE9H?=
 =?utf-8?B?cnlUOGxHQWpEa3I3UkNCSVB1b1RFNFlRM3pLL3lSYklPbndtTnJsdzdIN0ta?=
 =?utf-8?B?Q3VmWFRkbXpKMnNRbmdjQ3VEdjg2TFdGOFI2cEZEOExka1UwYlpMQ3dyV1pI?=
 =?utf-8?B?Y3dpWHQwdm9uMFMwdDk0QVZZeVJVZ1FMV2xNU1JHZVhuaHhqeGhmbG1aamdh?=
 =?utf-8?B?Zkw3T2NvK3hNRmQ2djFhN2w0TkE1dU9MMklKQ1R1SWQzT0JUYWhyb0FTMWNQ?=
 =?utf-8?B?V3NzaW1JdGR6VDRJWmtBdEEycHJWaTQvcklNeVN2RE5RNXpDRVhFNjNGMFlt?=
 =?utf-8?B?TnZTN21PWk55a0E2VkNUZ1BPNlVTeHBGOGNIeGgrekUyVHJyMjhtdXNIN1lo?=
 =?utf-8?B?TkZOak1KNTd6RnFOQ1Q0ZFJHUkZTZXlzQXZOR1RNbERScmFva1ZwNUJ0ZENi?=
 =?utf-8?B?SDlaQnVBdFI5UG1FRTRzbFlqOUZpVHZsODhDaWoxR0xpa2RqcFlHSXRLaGVp?=
 =?utf-8?B?ZjJIY1FHS3Zpc01XSHkwOWFzSFVxeGNPWWJ4ZnU5bSt0aURPTnBza0RhK3hv?=
 =?utf-8?B?QmdsWFJQbkVRNXEvSU9iWW1jbGdnaFdIaDh6WjBwRk8wbTY5SFRlZmR5QzVY?=
 =?utf-8?B?aEdSMDRhRURKRUE5RCs5ay9qY3pQdisyRXl1N3F2TjNUTjZTc0lzTFpqY3Br?=
 =?utf-8?B?SUJZenYxbEVIcXN5bHJCYmlMTUxwT3ZkcUxYSzFsaUx4bXBqMWwxeDBtK2Vp?=
 =?utf-8?B?V2k3YkwwTU52NExOendkVUU2M1NyZlRsUmxvZEc1cTZzZjI5TElVRkh0bjZV?=
 =?utf-8?B?ZU5LZjNrK1BVdnZ4MHRtaWxEaU9VM0dLUnZZNjFDRkNHWE5EWW5ndWhxa3dq?=
 =?utf-8?B?T1BPbERHbmNLd001SklMa2ZXOUdBclNFMXc0d25MeDYweDh2NHNQRUNBdW41?=
 =?utf-8?B?NkhsQWJFM2hZcllsS0NkRmdRQUp0Q0N5cXF1RXlRMURyUFRnWlY1Q1V4RXgy?=
 =?utf-8?B?Q015YktSb1hRbCtsRWRBODlYbGtKZmNIQW5nL2U5UmI2cXZ3K2h4MHFjMTU1?=
 =?utf-8?B?UUlrUlFGYXNHdWVOUXM2eG9BUFJUVHZydUIxcWtxRzMxbGVsYnUzMHpBQ2JN?=
 =?utf-8?B?VHNtMWdyK01NdGkxeVRCWS9pajZoT3NjV3RNODViY3JIbGVQSGMwcjUwR2dq?=
 =?utf-8?B?cERzcHB2RmpSc29yMWR1Ykg2b2hUSVY2dXFNQy9wcEZYSnk0RGJERUhuY09J?=
 =?utf-8?B?VjQ1WDBPQ2NiWHpKM0lJb0NnUDFSZ3I3cjFkMDV3YjlSbGVoRUlmYmltb1BE?=
 =?utf-8?B?TFhKUzd2eG84STYzRkEzM0RDdURQbjNwOXpQQjRyVUVZTnlFdnU5bElBUlA5?=
 =?utf-8?B?VE5PZzduN1JCTU92YVd6anFoa25DM3NrVXQ5RS8zNE02b0RMSWRZR0NGWjlX?=
 =?utf-8?B?RmJuSWpxaUNqQkJOampUUlQ2OS93Rkt5ME9ORk1YQ0xHTXFaMnowWE5DUjBz?=
 =?utf-8?B?a0pjM2VTbTUrU0JPQitwTjJCUm4rcG1xNlEvVDRXNmtQcGJMbEtZMEdVbUpm?=
 =?utf-8?B?MkZ2U05pRE51TjQ3b0xGTHlncUFRL3hsYXFXRkZPV0ZLYmdPRThzbVIva1RZ?=
 =?utf-8?B?YlFRYVhUdDlnTjlrYWgybUZVRnArQ0dJVFNFMEduWGZ1TUdqWVFNTFdxM0I0?=
 =?utf-8?B?dW94aURQR2txTDRTYkFpODU0RTV1MUdCclFFT1NMUTJCWTlrRlF1Q3ZEN1lM?=
 =?utf-8?B?ZDFBZG91dkJleHFGcGVtUjRROU90WldFd2ZMYjNtTHJ6SVFtVlQ4R1g5bXR0?=
 =?utf-8?B?U2VYRE8xNnRUdmZPdWIzS1dYZ091OWhvSkJPYnFCRlJ4NmVJWmZHUEQ0dk1a?=
 =?utf-8?B?NkNuSDFrM2RJUzhrMVAvc2NXMTZiTW9CVHpRRTFlUm5TcVVUWXZMY3hQV29I?=
 =?utf-8?B?VXRqZVVzS0ZmeEhEcDZQZDQ1aGdYSEg1dVJwQ0pMVlgyOVJKbVFqc0VvdVJ5?=
 =?utf-8?B?dVJnOUJQaExiS0hDNDAzdW9zQnJzT1cxaXhzc3hwaTAxSzU2ZEF6S2hrdnhM?=
 =?utf-8?B?N2RwbnJ2WWU2U2ZOWFByK0ZVc25jY2dWanV6cjVVNFVhbE5JcEFkbm01NFpW?=
 =?utf-8?B?V0dKRlR3cDIxNzU3VFQwZ0JkcjMzQTA2aFhnTTQ0djdmd2diSFlQN2pMeXhG?=
 =?utf-8?B?V1N4enZqQmdweC9LeFlRRkRPb3lTRk13SzhOU2NkTGkvUEZycldkdjM2eFNm?=
 =?utf-8?Q?hYSm9H4dir9sI4CA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Xfp88KMGF1nsUkA22Uo0jePOISAwCJQ8RkR7P2GR6jDR4TaQFr/cEtf1WmmNYVN1nAndm9+RRP31rCzs0cfWXkPmfPxhuamVJ+zuWV0t4QPloP59BfWR0BELJ8Zn3p/1vsboAjnBTwjlMj03qjZV7QYrWz9lTBLj3yllhxVPEu21lM1a8MByPmVCyRDbBqHom64k/MZY5sWThAOvVoOA/BKt10nDuxeXNdQurue5UfI+TUzYeH6KyYpEckE056Ilb8MYIvR1bQkPKhb/tGtCsIry7SZIONVR/x/Q36TweOdwJS4MD9iyjEBj7lzdvA/ub+zk5sL4K/nqVv26PaSe3A==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB7866.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 861bda78-d0ab-4176-cb9d-08dead13eee7
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2026 15:10:25.6798
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: orTFHkPd1ks6RRKy8FKc+GauyytNVQCNxw/pOZtG3XXbfQ+M51REXbPhhWic1JuTI2pu79fFjGtaF9Tnxt/yuta47qB4PqBCI6jukV9f1qjMkwkjMegr54BpKH3zqwlE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7695
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: 969A84F8999
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.94 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_ALL(0.00)[];
	TAGGED_FROM(0.00)[bounces-36119-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,CH3PR11MB7866.namprd11.prod.outlook.com:mid];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Action: no action

SGksDQoNClRoZSBwdWxsIHJlcXVlc3QgSSBzZW50IHllc3RlcmRheSB3YXMgYmFzZWQgb24gd2ly
ZWxlc3MtbmV4dCBhbmQgbm90IG9uIHdpcmVsZXNzLCByZXNlbmRpbmcuDQoNCk1pcmkNCi0tLQ0K
DQpUaGUgZm9sbG93aW5nIGNoYW5nZXMgc2luY2UgY29tbWl0IGZjZWU3ZDgyZjI3ZDZhOGIxZGRj
NWJiZWZkYTU5YjRlNDQxZTliYzA6DQoNCiAgTWVyZ2UgdGFnICduZXQtNy4xLXJjMycgb2YgZ2l0
Oi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L25ldGRldi9uZXQgKDIw
MjYtMDUtMDcgMTA6MzI6MDMgLTA3MDApDQoNCmFyZSBhdmFpbGFibGUgaW4gdGhlIEdpdCByZXBv
c2l0b3J5IGF0Og0KDQogIGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJu
ZWwvZ2l0L2l3bHdpZmkvaXdsd2lmaS1uZXh0LmdpdC8gdGFncy9pd2x3aWZpLWZpeGVzLTIwMjYt
MDUtMDgNCg0KZm9yIHlvdSB0byBmZXRjaCBjaGFuZ2VzIHVwIHRvIDA2OWU4NWU3Zjg5ZGYzNWMw
ZmIyZWVhMGU5OGQ1YzlhMmFmYTBlMDM6DQoNCiAgd2lmaTogaXdsd2lmaTogbWxkOiBzdG9wIFRY
IGR1cmluZyBmaXJtd2FyZSByZXN0YXJ0ICgyMDI2LTA1LTA4IDEzOjE0OjUxICswMzAwKQ0KDQot
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tDQppd2x3aWZpLWZpeGVzLTIwMjYtMDUtMDgNCg0KLSB3aWZpOiBpd2x3aWZpOiBtbGQ6
IHN0b3AgVFggZHVyaW5nIGZpcm13YXJlIHJlc3RhcnQNCi0gd2lmaTogaXdsd2lmaTogbWxkOiBm
aXggVFNPIHNlZ21lbnRhdGlvbiBleHBsb3Npb24gd2hlbiBBTVNEVSBpcyBkaXNhYmxlZA0KDQot
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tDQpDb2xlIExlYXZpdHQgKDEpOg0KICAgICAgd2lmaTogaXdsd2lmaTogbWxkOiBmaXgg
VFNPIHNlZ21lbnRhdGlvbiBleHBsb3Npb24gd2hlbiBBTVNEVSBpcyBkaXNhYmxlZA0KDQpTaGVy
b3ogSnVyYWV2ICgxKToNCiAgICAgIHdpZmk6IGl3bHdpZmk6IG1sZDogc3RvcCBUWCBkdXJpbmcg
ZmlybXdhcmUgcmVzdGFydA0KDQogZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9t
bGQvdHguYyB8IDE1ICsrKysrKysrKysrKysrLQ0KIDEgZmlsZSBjaGFuZ2VkLCAxNCBpbnNlcnRp
b25zKCspLCAxIGRlbGV0aW9uKC0pDQo=

