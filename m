Return-Path: <linux-wireless+bounces-10386-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B6C8937457
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Jul 2024 09:23:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F9C0283C50
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Jul 2024 07:23:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BD3E446CF;
	Fri, 19 Jul 2024 07:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FZkpEJst"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A6047A4C
	for <linux-wireless@vger.kernel.org>; Fri, 19 Jul 2024 07:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721373833; cv=fail; b=R0hRsPlNDsspvcJ9Yba7cv/QwI47JXXOuxtZ+Cvtfv+B03bbc1Ax6lW1+n0ySF9KKg72l8XHwsyrHXHmR7sYEk27vL4RioRG28mnoWOqSnLfIwm0G3MOSdnbXLYyG6EU/bNtXqkxI7K3eDeAiesudaF8jATA8WifbUOpNJuKAPg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721373833; c=relaxed/simple;
	bh=dZXE4+PBGhz+uX9ecACJ0xyqqSTKA7d8h0zmdhpnGc4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uR8tzoHBmYlwvciob0D8X3DTh3RJCAIe+Y7zKuDppqbxMAAkzQej3f3K+8qN/wx2zweOvoE59Cfc8YQXVplWdJ4aoqItK1uklwpxbft9vYtCl6KfFhb1P1ow0YzyCVmOxMhaqtHcgZZgmFwTl2F6PoRi316L7fNM/STWROtkS9s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FZkpEJst; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721373831; x=1752909831;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:mime-version:
   content-transfer-encoding;
  bh=dZXE4+PBGhz+uX9ecACJ0xyqqSTKA7d8h0zmdhpnGc4=;
  b=FZkpEJstD/+UlxnX2/7+C+FpmQmP8zfRlLnEmxAt6mqAyDTv7CkHsRBB
   6ZZjQpOw4wl4NHqJyjHrMa1bkQouJTpK+W0vfEh47wVDHesuq/ADnZZjf
   t4ou4Yd9Rpb1c6GIV0Ouz8Q08iwIsXlFBqcP0X1x06PifgJ+BRjVPIQgG
   JqV2HHDPkyWkXo0KHSIYYTFTj7yOroT+ssMhEmeH6CKl4u077LJXAuYef
   krQ5Ol0TWu9nPpRFWdNfek39Q5M/1pJ8ChQH+hpuK5zNkt0woKDVHJHSm
   HoaKiH5rf/CKpYwSz7KypAR0S23auS/K1YZGFihUg0H9OQJG6MnbcfaBU
   Q==;
X-CSE-ConnectionGUID: LNXKmKOpT7C3E9Sayg4Nng==
X-CSE-MsgGUID: ZAw6YQosThiojOwd8xyPZg==
X-IronPort-AV: E=McAfee;i="6700,10204,11137"; a="44397144"
X-IronPort-AV: E=Sophos;i="6.09,220,1716274800"; 
   d="scan'208";a="44397144"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2024 00:23:50 -0700
X-CSE-ConnectionGUID: N2ztOlcWQFegIqEf9aOZKQ==
X-CSE-MsgGUID: W6Gry60SSDCCFo4rUjSt/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,220,1716274800"; 
   d="scan'208";a="55566678"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Jul 2024 00:23:50 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 19 Jul 2024 00:23:49 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 19 Jul 2024 00:23:49 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 19 Jul 2024 00:23:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EvZHAT6EVrD1nw+rfg5IKFbr38IqdBOEl75Y9mwzBAKraTr4n+VqdZEQ8Zpk80BmRyJo3GGLFWuSVL2/l6YObvEizwm6i5BgWUyC0rdOLPTU+VCmhrC+X4zZEVC1DtAtTaoDUnOxJuZHTeKTetS0d7jXhr3/0rrV38J3TglFiY8IjkW/YvT2XDpRQZcyYApJDpXIVR4mYGQPglI5j+POnNryu09DLHvu0vPHAB3XMvmoap67vofsOfE0uMPUy9C1ExKR8DkduRfBqGglEthir8cKvSfg356ZI1IIUCCLlvCjmVHrJoA54o4XRqvVkqjZfZkz08Zk01q6uIGnMhl2lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XqPSVxRAayxxlwLoaU3rektD5d4eqV+mlgafTZjpdKs=;
 b=E8GyoX+xgnnbDIhiWPwRyw/ykE03LQXFiJCDdu/yJWfapoR04vh3LkaZ6tB50VRH1LtxEaUyAK/4CAsa+//haPak8fAgqpfRq628MQWD5SC/hVk4mj6tWdlpX9mF2BVDzPi3R4T5MAULZ82P+OOX6rTAYP9D2aff28q0gsxO2TEoA0Gvv00qoCndQ8ikyI89rF0z08M++KJI+QNEequkiRrM1bJDDGdgddcEaXSmLk2WrmQXQE0q5w7PXFAAf4GBWliromHcIgYEj6dZ4tExw1uAw3a6Nusj84XR4ipBf5veXBY1q+ugGym95tDieJ1WpFKtmQi5oXHHz3DC1/ayoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB7964.namprd11.prod.outlook.com (2603:10b6:510:247::9)
 by IA1PR11MB6444.namprd11.prod.outlook.com (2603:10b6:208:3a7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.17; Fri, 19 Jul
 2024 07:22:51 +0000
Received: from PH7PR11MB7964.namprd11.prod.outlook.com
 ([fe80::1b60:d7c9:1b2a:2a7f]) by PH7PR11MB7964.namprd11.prod.outlook.com
 ([fe80::1b60:d7c9:1b2a:2a7f%5]) with mapi id 15.20.7762.027; Fri, 19 Jul 2024
 07:22:50 +0000
From: "Berg, Benjamin" <benjamin.berg@intel.com>
To: "greearb@candelatech.com" <greearb@candelatech.com>, "Korenblit, Miriam
 Rachel" <miriam.rachel.korenblit@intel.com>, "johannes@sipsolutions.net"
	<johannes@sipsolutions.net>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, "Berg,
 Johannes" <johannes.berg@intel.com>
Subject: Re: [PATCH 06/18] wifi: iwlwifi: keep the TSO and workaround pages
 mapped
Thread-Topic: [PATCH 06/18] wifi: iwlwifi: keep the TSO and workaround pages
 mapped
Thread-Index: AQHazS/N3Nvb9PraOk28G6YAQKC3zLHwiXAAgACPhACAAKYkAIALNbyAgADJtgA=
Date: Fri, 19 Jul 2024 07:22:50 +0000
Message-ID: <141e44a9ddb6e5a1a9981c4eacad8c3a5e8f5b52.camel@intel.com>
References: <20240703095906.833028-1-miriam.rachel.korenblit@intel.com>
	 <20240703125541.7ced468fe431.Ibb109867dc680c37fe8d891e9ab9ef64ed5c5d2d@changeid>
	 <a0a7dbf2-b4c5-ddf8-59e9-7e8a067e2f11@candelatech.com>
	 <64fefdf4c689a4fe039917f69b9f6d61aca0db92.camel@intel.com>
	 <4abe931d-f6ec-adb6-9b78-23d4c0c4b1a2@candelatech.com>
	 <3379abec-9251-ac6b-3760-4f1838f31445@candelatech.com>
In-Reply-To: <3379abec-9251-ac6b-3760-4f1838f31445@candelatech.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB7964:EE_|IA1PR11MB6444:EE_
x-ms-office365-filtering-correlation-id: 5d339d1d-1a8e-4984-ea37-08dca7c398b6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?MFVVaWNGZHM2MjJUWnZSVEMwQTlPeHJhSDNLTWZaZm83VklieWN3ODJ6bm1W?=
 =?utf-8?B?RTZVd0NnZHJMcGxtS1NOb1FmdTIyOHhwdEFlN0lGOTJYTTUreC9TQW0wM0Yr?=
 =?utf-8?B?STNuc0JkaHhtazN3dXZYRTdzSkdVT05KRnpZVTRQemc1czZBUHRsNVZhQXc4?=
 =?utf-8?B?ZUdMTUVqWUxEOWQzSkpVbHY4THpHNi9OT2hVNXh0cmdES3krVHNGRlQvN1lk?=
 =?utf-8?B?ZmJqZEYvbnBOa1pPcjI5WUI5MXBMR2dHUWVwZ1ZXTDlGOEJuM2k2blNIa1dF?=
 =?utf-8?B?TUs4Y2Z3T2kyQ0Jmb3JJdnRHVkFqVWZBTk5oZGowdEdXckw1dG8rSGZQUXJo?=
 =?utf-8?B?U0pIKzZjeWovR1kxcUI5eW9TNDIzQVRSSk1jTldZTEFZNmQvQlZQOHNKVEcz?=
 =?utf-8?B?OGJZTUFmK0p2QVhnU0JPdzhjSHV6YjBjM0h4VGMvYkhXWTA4QXQyR3dybkg2?=
 =?utf-8?B?MUtiY2g4YkQ2bVFPN2ZMM1NSOVZRRWM3MEJFQW5YcU1kaFlZck9tZ1o5SVdG?=
 =?utf-8?B?V1VnSG5yVVlrVkxMekJMMkxuRUNYemdSNkgvd0s3YUloejR4eG5wYTRwaVRE?=
 =?utf-8?B?R2xydXAraHdlZWRBYTk1TEo0eS81M3VDSjZkV3RUdzU3SVRaY3k3c2NlNENO?=
 =?utf-8?B?aVcwU3FKNHJHK01BVWZnL1BJSy93NWh4Z0VKakU2SFBRQUsrVnJpNEM0cklP?=
 =?utf-8?B?aGdmV1d4Yk5QYk1vVzdReVd6SVpOb1p1OVA0QUd4bjhSVUFETGdUWjdUdnpq?=
 =?utf-8?B?RFY4R1VhdzA4WDV0NVExNkc1U3d3NWdUTzlZVm9LVE1kczVvMWJPUjhrMXJv?=
 =?utf-8?B?R205WWRBREtHMWZkd0R2TmRWWUpwZTBsTnFNZEdadjFKbUdqK2FzQUxlTk9P?=
 =?utf-8?B?blpkQXZQOHVoTGNQNXBwQ2V5R01yRFZjSUM2RXNlaU9YbzZ1clQzUmJnQnB3?=
 =?utf-8?B?NFQ3bXRXdjdsLzV4Q1d4TU5oVDNpODgreS81eGh2cUhCVmVJVGdMK0V4dThB?=
 =?utf-8?B?UTZwWFhsVmtEOFN2VzNtMDV2TzF6SVowQWcwVjd4WnRkRzgrcjhBUTJ3WllC?=
 =?utf-8?B?M2dLMGNSRS9uRmo0U2FtT3pFMTJXSHNBSkx3bXNnQ3Z3WnNNL3VCQXgvUVM4?=
 =?utf-8?B?QzZzQ0ZkaUF5VUdaNk1LNlErS01MNFk5QTBjUEZlblg4bTZUMUdVcWszd0Zl?=
 =?utf-8?B?OXYzWHVJRDRTV3Mva3RqcCtOWXFJaHdpcjZEd1Q4WTFTalovR0p5VE9pTUdH?=
 =?utf-8?B?UjZyaTdVcXdNVTB4OERPZUI0Vm5ZSTlTU0p4R2ttbjBxZ01mTFBrTm1STUxV?=
 =?utf-8?B?NFBySEQvekVxMTl4UEJweHQ1enlIYWlOZ1F2cXc3cGdhKzVmWTluS1cxb2dl?=
 =?utf-8?B?RnF5TWlvMjhSRzI3Z09TNk1lck0wVndIb2NTOHF4WkdYcHYvRmU2ZXYzcTMv?=
 =?utf-8?B?ZSswV25qN2ZJRE93K1liVmFabFh2bmI3SndvR0FnWXpHbWdiV0MzcDZ4OWJC?=
 =?utf-8?B?T3RhRDlMNk4ra21JRzhHZGlFc1hFL0ZhQ0lHWWErRnROaW5DdXpzNzJVKzZN?=
 =?utf-8?B?bVROK1psSzZiUGZ3bFpoMjliY28wWkZJRi91Yk9FT0pEczExZU54WUNYOXZG?=
 =?utf-8?B?SWN1MWNNN2VFUmkzVHp1ejY3MURPeTVnTDRTbzFPaFdUUmZKVS9DZ2dXSTRK?=
 =?utf-8?B?SG10eDh4a3FGblBiMHhjNlVvRE8yR1pEdER5UEhjS1RmM1I4Y2pRQm56ck1O?=
 =?utf-8?B?RTN3TVFLanJYaGlUc1l4NWFhc21XYTEzbjJCZzIxY1pSNlZxMW1YQVBrOG9Q?=
 =?utf-8?B?Y2E2VEdjVkl4bTAwTnRwL3llS0tRZktvYktmT3lIV241eHNpZUY4R3hLM1k0?=
 =?utf-8?B?eDA0YXZwZ09WUUhCWHJPU3ovL0lxRm5JSlU3akhGMVlsb3c9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB7964.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ellpSUhmeUNIK04zL1FXenA0SEUyNVZidFdHQWllQ29uR3Q5ejkybkxHUUpJ?=
 =?utf-8?B?d25jTGRKQ1FTeVg2azlRQmg0SnJNbTN3SFdNd0ZDTUY0MkhvUkVOeGNQMDky?=
 =?utf-8?B?QkEvVTVpZFI1NXVrekUxK25ST2krQVYzSFBMZjAzNTJhbVBVbnZId3d2V0ZM?=
 =?utf-8?B?amE4ZXc1NEVaeE45V2FSNCthUFYrU25hRENMWWhlaUp2Zyt5Tk5VaGMyenhv?=
 =?utf-8?B?NHo3Si9zSXVwL2NFNUF0KzFLTWVNUWUwbkRrakVrc1NqYzlsdHRKcExpR0Zj?=
 =?utf-8?B?QmFkbGRvNXJUVVlpM1NOb0VrbGhGRUVLOUR4c3lzeTM0VkprUTlTV0dScnpZ?=
 =?utf-8?B?cUdQd08wNFpWaWtoU3ZkeHRQdW1CV3hNb2JMa3VDcUhrMUxHM2I1Q2NVaGVy?=
 =?utf-8?B?NUVTYjZNS0gwd2QzQTByRVdMT0xFOVVPNUpFMDdrY0dCRUpoU1U4akYyYlZx?=
 =?utf-8?B?YXREc0xBMkFnUG03Q1FjTDZOVXB5OWhtcDhXelF6aDlCVW02VGpQdVdaZTFK?=
 =?utf-8?B?YnVuQ2dLa3FRekYzMXZaTGZra3JLM3d2MWZieC8rb2tDd0lpNlBRL0NUVkkr?=
 =?utf-8?B?bFM3d0l6Q3ZDeVRabGM5S0tRaFlvc3FwM1VPMndZZFh5aXl3NW5vRTZ4TjJU?=
 =?utf-8?B?d1dVWUFIMDNmY2doeHd6MWRhblJWQW40Z3NYYWJ4cWZuWEhlNlowb1cva1Zh?=
 =?utf-8?B?SDkzeWNVZUdYK3N2QmNxZGNFUFo2ZkY0VlF4RVp1ZW1URWhiNmNSY2l0U01G?=
 =?utf-8?B?YUJLU2pPdnhNUURxMnFzQ2ZCS2tQU3JwYVREWGg0dVh1dVNWakdYOHA3Q1ZR?=
 =?utf-8?B?S1dvNjFJK0xUL2NSak1nNHNPK1dOUzQ0U2VLdTFxTFZuY3A3NEtET21hNHZ0?=
 =?utf-8?B?ZHlOZlk2bEp2c3FWc0RBaTVxc3dXbkV4bDdZZFBmbzlYZU9INkc1dDNkK3Zn?=
 =?utf-8?B?UHU4RzF4YUREbndGZUZCcFJ0VllNbzdaUnBMV1hFUmNIOHhFeGxvNndEQWVX?=
 =?utf-8?B?eGE1aE9TTVk3UFBxNGFFRGd0REhsckpRVlVIZlVvYksyUk9qeGVRRHNUczNE?=
 =?utf-8?B?cmE2TnE4ZXRPUjZPbE1rTUhPb3NTZmNWL214VWVQRVk4QWh1VUloMjV4UXNs?=
 =?utf-8?B?aEcvSGNFeko2algvdHBDUkZIKzc4ZFpBeU5sMkhmNW9IcWdyRUNTOUtrZGxm?=
 =?utf-8?B?bjAwZlNocVJEYjFvWlhrUy9VVzhpNGZrdzJ3MHpzMTVySDBqdGJDdXhnZCth?=
 =?utf-8?B?ZFZKSkduWVdMVFQ1VCtteVlHRDR3dnByTXkyVDh5V3IvckVTamx2M09hTXB0?=
 =?utf-8?B?SXFKMnZsNkd6MURJSWFCMGE0UDBhVmFuZG5ja0dqR1lHWWp1ZlZIN01IT1J4?=
 =?utf-8?B?VnhQQmNtNzdtVFNpUlNGN0R5STIzVlVmbHpqU3lEVkk0dktTZnUzeXNVTW85?=
 =?utf-8?B?SUFDOWY1WlUzR1JTeDRlK1BaZHFZS294ZHM1bjd3TTh5NWF4ZXpmaytXNjBw?=
 =?utf-8?B?TzFXaDlZcTV3ajMwK2xlSFVDQ2hNOTBuaFhqSHgvYnhyQzlPZmVzZmhUWVpH?=
 =?utf-8?B?c0JpL2hPQlVCRCt1RkRhOE1QSzVFSlh4b1Y2NFBlU3d0eDNubEF5MHlYU09s?=
 =?utf-8?B?V1pvb0M4OWFReDN6bnc0dDZUVGY5ZEJHK2gxWWt0MHg1NTlHK3ZDOVFOeVdu?=
 =?utf-8?B?N1UyOTdxZlpqRTc0V2U3eGNiUDdwSlpSMDlPWTllbk5UWGhyOWtLQ1BWeXRY?=
 =?utf-8?B?NlhFUXJUNHhZUjJIOC8xdEVwSnorMEhjSkc1RHlZZGRPUVdORnRra2ZEWTJW?=
 =?utf-8?B?WDhVTjhNeTNTeDhVRUIrNUd1Qmg0dlFONUhEZ05sYUJLbUtkaERQOHhsRitq?=
 =?utf-8?B?b1poQUtIbUU1MVBlemRUVlExbmtucExNRDd6ZjdlcXZHNzZTTVNVaVp3SFli?=
 =?utf-8?B?Z1JLUEJNNlhhOHB0QUlQOHFMVXBaRHVVVFZjY3JYR1V5ZThHL25JV0h6V2lr?=
 =?utf-8?B?QWlvUEt2akFpK0JRZXp4aHRDbUdjL2RkQ1g0QmhybXk5KzFGRDU1bkxCNU5w?=
 =?utf-8?B?TW9KYzJsSG9ia3M3ZW9IK1pucXA1ZEN4LzUwczNCR0hTaTNRNGVLZEhGOXpB?=
 =?utf-8?B?ZDd6aVMrbFU4elZRTlNOcVNtNHl3T1pjOU9sQkpvSzNEY1ltRC9nd05iTlFR?=
 =?utf-8?B?SHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <639FB4116B8509458ED85DF836398DB9@namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB7964.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d339d1d-1a8e-4984-ea37-08dca7c398b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2024 07:22:50.2057
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iHezBkr2YNTZr+4LH8BmwXnZ0M1a38SjK74hpKsmPDB0VQWo0NoR1ksMXuAt346/b0BdIe67QwbRKpsbmaOxQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6444
X-OriginatorOrg: intel.com
Content-Transfer-Encoding: base64

SGksDQoNCmhhdmUgeW91IGFwcGxpZWQgYWxsIHBhdGNoZXM/IEl0J2xsIGJlIHNsaWdodGx5IHNs
b3dlciB1bnRpbCB5b3UgYXBwbHkNCnRoZSBsYXN0IHBhdGNoIGluIHRoZSBzZXJpZXMgKGFuZCBi
cmVhayBjb21wbGV0ZWx5IHVubGVzcyB5b3UgaGF2ZSB0aGUNCmJ1Z2ZpeCBvYnZpb3VzbHkpLg0K
DQpBIHNsb3dkb3duIHRvIDgwTUJpdC9zIHNlZW1zIGEgYml0IGxpa2Ugd2UgYXJlIGdldHRpbmcg
cGFja2V0IGxvc3MgYW5kDQp0aGUgQU1TRFUgaXMgc2ltcGx5IG5vdCBzZW5kIG91dC4gSSBzdXBw
b3NlLCB0aGF0IGNvdWxkIGhhcHBlbsKgaWYgc29tZQ0Kb2YgdGhlIERNQSBtYXBwaW5nIGlzIGZh
aWxpbmcsIGJ1dCBJIHJlYWxseSBkbyBub3QgaGF2ZSBhIGdvb2QgaWRlYQ0KcmlnaHQgbm93Lg0K
DQpJIGRvIHRoaW5rIHRoYXQgdGhlc2UgcGF0Y2hlcyBoYXZlIGdvbmUgdGhyb3VnaCBxdWl0ZSBz
b21lIHZlcmlmaWNhdGlvbg0KYW5kIHdlcmUgd29ya2luZyB3ZWxsIGZvciB1cy4NCg0KDQpBcyBm
b3IgdGhlIHZhbHVlIG9mIHRoZSBwYXRjaHNldCwgdGhlIHRoaW5nIHRvIGtlZXAgaW4gbWluZCBp
cyB0aGF0IHdlDQpzZW5kIG91dCBsYXJnZSBTS0JzIHRoYXQgYXJlIHNwYW5uaW5nIG11bHRpcGxl
IHBhZ2VzLiBCZWZvcmUgdGhlIHBhdGNoLA0Kd2Ugd291bGQgZG8gbWFwcGluZyBhcyBiZWxvdywg
d2hlcmUgaDEsIOKApiBhbmQgbTEsIOKApiBhcmUgZWFjaCBtYXBwaW5ncw0KdGhhdCBvbmx5IHNw
YW4gYSBzbWFsbCBwYXJ0IG9mIGEgcGFnZSAoaF9uIGlzIHRoZSBoZWFkZXIgZm9yIHRoZSBudGgN
CnBhY2tldCB3aGlsZSBtX24gaXMgdGhlIGNvcnJlc3BvbmRpbmcgbWVzc2FnZSBkYXRhKToNCg0K
VFNPIHBhZ2U6IHwtIGgxIC18LSBoMiAtfC0gaDMgLXwtIGg0IC18IOKApg0KU0tCIHBhZ2UgMTog
fC0gbTEgICAgIC18LSBtMiAgICAgIC18DQpTS0IgcGFnZSAyOiB8LSBtMiAtfC0gIG0zICAtfC0g
bTQgLXwNClNLQiBwYWdlIDM6IHwtIG00IC18LSDigKYNCg0KV2l0aCB0aGUgcGF0Y2hlcyBhcHBs
aWVkLCBlYWNoIG9mIHRoZSBwYWdlcyB3aWxsIGJlIG1hcHBlZCBpbiBhIHNpbmdsZQ0KY2h1bmsu
IFRoaXMgYnJpbmdzIGRvd24gdGhlIG51bWJlciBvZiBETUEgbWFwcGluZ3MgYW5kIGFsc28gYXZv
aWRzDQpwYXJ0aWFsIG1hcHBpbmdzIHdoaWNoIGNhbiB2ZXJ5IGJlIHBhcnRpY3VsYXJseSBleHBl
bnNpdmUgZGVwZW5kaW5nIG9uDQp0aGUgSU9NTVUgY29uZmlndXJhdGlvbi4NCg0KT25seSB0aGUg
bGFzdCBwYXRjaCBpbiB0aGUgc2VyaWVzIHJlbW92ZXMgdGhlIG9sZCBtYXBwaW5ncyAob2J2aW91
c2x5DQp5b3UgYWxzbyBuZWVkIHRoZSBsYXRlciBidWdmaXggY29tbWl0KS4gU28geW91IG1pZ2h0
IHNlZSBhIHNsaWdodA0Kc2xvd2Rvd24gaWYgdGhlIHBhdGNoICJ3aWZpOiBpd2x3aWZpOiB1c2Ug
YWxyZWFkeSBtYXBwZWQgZGF0YSB3aGVuDQpUWGluZyBhbiBBTVNEVSIgaXMgbm90IGFwcGxpZWQu
DQoNCkJ1dCBub3QgYSBzbG93ZG93biB0byA4ME1CaXQvcyDigKYNCg0KQmVuamFtaW4NCg0KT24g
VGh1LCAyMDI0LTA3LTE4IGF0IDEyOjIwIC0wNzAwLCBCZW4gR3JlZWFyIHdyb3RlOg0KPiBPbiA3
LzExLzI0IDA5OjA5LCBCZW4gR3JlZWFyIHdyb3RlOg0KPiA+IE9uIDcvMTAvMjQgMjM6MTUsIEJl
cmcsIEJlbmphbWluIHdyb3RlOg0KPiA+ID4gSGkgQmVuLA0KPiA+ID4gDQo+ID4gPiB5ZXMsIHlv
dSBuZWVkIHRvIGFwcGx5Og0KPiA+ID4gDQo+ID4gPiBjb21taXQgMDAzZWFlNWEyOGM2YzlkNTAy
OTBhNGFjOWI5NTViZTkxMmYyNGM5Zg0KPiA+ID4gQXV0aG9yOiBCZW5qYW1pbiBCZXJnIDxiZW5q
YW1pbi5iZXJnQGludGVsLmNvbT4NCj4gPiA+IERhdGU6wqDCoCBUdWUgSnVsIDkgMTQ6MzE6NDkg
MjAyNCArMDIwMA0KPiA+ID4gDQo+ID4gPiDCoMKgwqDCoCB3aWZpOiBpd2x3aWZpOiBjb3JyZWN0
bHkgcmVmZXJlbmNlIFRTTyBwYWdlIGluZm9ybWF0aW9uDQo+ID4gPiANCj4gPiA+IA0KPiA+ID4g
SSBoYWQgbm90IGZ1bGx5IHRlc3RlZCB0aGUgbGFzdCByZXZpc2lvbiBhbmQgdGhlIGVycm9yIHNs
aXBwZWQNCj4gPiA+IHVuZm9ydHVuYXRlbHkuDQo+ID4gDQo+ID4gSGVsbG8gQmVuamFtaW4sDQo+
ID4gDQo+ID4gU29ycnkgSSBkaWQgbm90IG5vdGljZSB0aGF0IHBhdGNoIG9uIHRoZSBtYWlsaW5n
IGxpc3Qgb24gbXkgb3duLsKgIEkNCj4gPiByZS1hcHBsaWVkDQo+ID4gdGhlIDYvMTggYW5kIDcv
MTggcGF0Y2hlcywgYW5kIHRoZSBmaXggeW91IG1lbnRpb24gYWJvdmUsIGFuZA0KPiA+IHN5c3Rl
bSBhcHBlYXJzIHN0YWJsZS4NCj4gDQo+IEhlbGxvLA0KPiANCj4gV2UgZm91bmQgYW5vdGhlciBy
ZWdyZXNzaW9uIGluIG91ciBwYXRjaGVkIDYuMTAtaXNoIGtlcm5lbC7CoCBCZWZvcmUgSQ0KPiBh
cHBseSB0aGVzZSAzDQo+IHBhdGNoZXM6DQo+IA0KPiB3aWZpOiBpd2x3aWZpOiBrZWVwIHRoZSBU
U08gYW5kIHdvcmthcm91bmQgcGFnZXMgbWFwcGVkDQo+IHdpZmk6IGl3bHdpZmk6IHVzZSBhbHJl
YWR5IG1hcHBlZCBkYXRhIHdoZW4gVFhpbmcgYW4gQU1TRFUNCj4gd2lmaTogaXdsd2lmaTogY29y
cmVjdGx5IHJlZmVyZW5jZSBUU08gcGFnZSBpbmZvcm1hdGlvbg0KPiANCj4gVGhlbiBJIHNlZSBh
cm91bmQgNEdicHMgVENQIHVwbG9hZCBvbiBteSB0ZXN0IHJpZy7CoCBBZnRlciB0aGlzLCBpdA0K
PiBydW5zIHZlcnkgcG9vcmx5LA0KPiBwZXJoYXBzIGJvdW5jaW5nIHVwIHRvIGhpZ2ggc3BlZWQg
Zm9yIGEgc2Vjb25kIG9yIHR3bywgYnV0IG1vc3RseQ0KPiBhdmVyYWdpbmcgODBNYnBzDQo+IG9y
IHNvIGFmdGVyIGl0IHJ1bnMgZm9yIGEgYml0Lg0KPiANCj4gV2hhdCBhcmUgdGhlc2UgcGF0Y2hl
cyB0cnlpbmcgdG8gc29sdmUsIGFuZCBhcmUgeW91IGFibGUgdG8gc2VlIGdvb2QNCj4gVENQIHVw
bG9hZCBwZXJmb3JtYW5jZQ0KPiB3aXRoIHRoZXNlIHBhdGNoZXMgYXBwbGllZD8NCj4gDQo+IFRo
YW5rcywNCj4gQmVuDQo+IA0KDQpJbnRlbCBEZXV0c2NobGFuZCBHbWJIDQpSZWdpc3RlcmVkIEFk
ZHJlc3M6IEFtIENhbXBlb24gMTAsIDg1NTc5IE5ldWJpYmVyZywgR2VybWFueQ0KVGVsOiArNDkg
ODkgOTkgODg1My0wLCB3d3cuaW50ZWwuZGUNCk1hbmFnaW5nIERpcmVjdG9yczogU2VhbiBGZW5u
ZWxseSwgSmVmZnJleSBTY2huZWlkZXJtYW4sIFRpZmZhbnkgRG9vbiBTaWx2YQ0KQ2hhaXJwZXJz
b24gb2YgdGhlIFN1cGVydmlzb3J5IEJvYXJkOiBOaWNvbGUgTGF1DQpSZWdpc3RlcmVkIE9mZmlj
ZTogTXVuaWNoDQpDb21tZXJjaWFsIFJlZ2lzdGVyOiBBbXRzZ2VyaWNodCBNdWVuY2hlbiBIUkIg
MTg2OTI4Cg==


