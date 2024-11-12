Return-Path: <linux-wireless+bounces-15206-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 984039C5F89
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Nov 2024 18:54:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 805E8B30278
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Nov 2024 15:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BEB61FF7DD;
	Tue, 12 Nov 2024 15:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TuiPou9L"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BACBD156F5E
	for <linux-wireless@vger.kernel.org>; Tue, 12 Nov 2024 15:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731424148; cv=fail; b=Banb7ZYXigQCR2uXQDim3kdg1TFMYuuvRUUlnXSsl/5k81cm5oQDhve1QS0uz4+7/XZNL6U3MBFJG/ehMVbFzRxktiCUbCBO3ijQJ6Z2EbuCuPSmH7DFpXQzAQ2bcL039qrwaoSdV3wIUAS3UhYfB9nyyZotWMk/tJkYMsp9PuA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731424148; c=relaxed/simple;
	bh=EbuI+VaJIG020rnnAffW2ezPzfTgH2ktmJk7Pbnk9CI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZYpUwQir8sp9wveBZ0LNrTd40hRpDlqpM7FNkaIdES9Dn3ULJ+pFooAo7V5JfCUxLy33utiZ4eFr7/8qm3hoFlNCrZR1ooP6AjVni1dxPnh0gE8IE1vxpVaDmgzdDMK462sd7769wpO3qGS7rN7jBS4vV0FwRHTesdg/gLrceGE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TuiPou9L; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731424147; x=1762960147;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=EbuI+VaJIG020rnnAffW2ezPzfTgH2ktmJk7Pbnk9CI=;
  b=TuiPou9LA4IhM4PP5aeSs9mc7UIPJc3SDIIfy5dX2iDv2ZprvLyrQHyz
   awpvDE7vssREZOfZvrquS6p2TuSYwKHXq+zSxkIXZj6OxlreEEEZGP0DE
   IXWrhCdOkHQzIBtvaIjhfK7mInTFk/4o0sv/FYsrgQhe5hnW4ObZDdOeD
   28IEnfzIlFNUp4rZBn0ubYYMT2llsoE39LqoXH7cR7z6ZzwnA9BHezJxj
   5hkRI9/5oUmPAZoY/5rManxOr1tGxZNkwSesnJGH8m6EOwHdspBV217uv
   Gjd2bhZrtXpdY48wxpD+QDnLJyxL2IH1rFmCh+B96L7yznsv9IS0w6DeN
   A==;
X-CSE-ConnectionGUID: oMRTWvP1T5e6IW16t85UUg==
X-CSE-MsgGUID: q2Mm9jDcR8+uFsNObI1eDw==
X-IronPort-AV: E=McAfee;i="6700,10204,11254"; a="18873066"
X-IronPort-AV: E=Sophos;i="6.12,148,1728975600"; 
   d="scan'208";a="18873066"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2024 07:09:06 -0800
X-CSE-ConnectionGUID: oo8xf8W0T22dPpPfFs9pKg==
X-CSE-MsgGUID: Ut9Dz1giREG6gXrd5QaRDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,148,1728975600"; 
   d="scan'208";a="87471305"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Nov 2024 07:09:06 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 12 Nov 2024 07:09:05 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 12 Nov 2024 07:09:05 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 12 Nov 2024 07:09:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HVvUDOYrVWkmTMO/KPKCDWSt0srivaZQRMc+vRlKXou+JG0DCVOzgXUISPaitO/stagTjLxnAqCfHP6/7O5YllmCSZ6F+MR4/tGBmYc9q4TT5fiNuQKHzEdXXwFowq8VE1Yu3BMnxIuQ9I8cC450EzhhK15voXfoOZYJS92+ZLLDP15VNkb4v2uSKzNlnQKH1I89eaLxPNBRPER0Xe7i0bFGw48INLzKhZL4Y+hNoS8+zamKFhbgbXVGOz82OYZCDoBMErJJ2EJO/3m9Hvp+ZFMdqAvsaJH6utLEa63ifrjP70XNL/v9ZORJgaFZdIKJWWpraoJ++Tq3vFa3lECujQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EbuI+VaJIG020rnnAffW2ezPzfTgH2ktmJk7Pbnk9CI=;
 b=Y7R9jakIZV6m1winBEo86PFNSCNb6WNb9s1BpYu4yt5A9OSq1609RMOJjK342aWLXdS5RceWhp8+g3BdDkOAk1qnhXU9HPBJ/b8MAG4tXuN0ivaA9/rpmBjk8pTiDjBwJEDaHyO+3fqbal2C8kH2ly81ZiPyRTqCT3+VNeUVBe9nkLH9dgpYCrUUESH5wO4YMrq9p2rqRDNUWa8DLIH+w/ckU+8Jsvjxc1EJUMRC9PA2PJ0UWKDHye5Ovbjy0WLV+1u8xKr+t+tUG42QptONMXunejtRAB0mXhh99J4pDHK44ScHch7VnG9qa5GXTtkfUilANP2rFzq6rVl9lTlz4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA1PR11MB5825.namprd11.prod.outlook.com (2603:10b6:806:234::5)
 by PH0PR11MB5190.namprd11.prod.outlook.com (2603:10b6:510:3c::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.29; Tue, 12 Nov
 2024 15:09:00 +0000
Received: from SA1PR11MB5825.namprd11.prod.outlook.com
 ([fe80::41f9:e955:b104:4c0b]) by SA1PR11MB5825.namprd11.prod.outlook.com
 ([fe80::41f9:e955:b104:4c0b%3]) with mapi id 15.20.8137.022; Tue, 12 Nov 2024
 15:09:00 +0000
From: "Grumbach, Emmanuel" <emmanuel.grumbach@intel.com>
To: "dan.carpenter@linaro.org" <dan.carpenter@linaro.org>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Re: [bug report] wifi: iwlwifi: support fast resume
Thread-Topic: [bug report] wifi: iwlwifi: support fast resume
Thread-Index: AQHbNOd+8svcudxEdE2gtsJsxw2uaLKzvh+AgAABq4A=
Date: Tue, 12 Nov 2024 15:09:00 +0000
Message-ID: <dc61804f99db18dcac4b28955000e939f2df18ae.camel@intel.com>
References: <c6a40af0-a649-4f9d-9245-dc6d6381cc10@stanley.mountain>
	 <77a57d6ffaa90080178dddec26f6cc3f45534c03.camel@intel.com>
In-Reply-To: <77a57d6ffaa90080178dddec26f6cc3f45534c03.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.54.1 (3.54.1-1.fc41) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB5825:EE_|PH0PR11MB5190:EE_
x-ms-office365-filtering-correlation-id: 22f0f075-191c-43c9-0e97-08dd032bf001
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?bEc3aUpyQ1BiZW15ODQ1dnFIdzZOU0xJMVFwaHJYTm8wcnNWM3JxSDBqekxo?=
 =?utf-8?B?QnNGdUJCMXBBejJ2S2h0S1FzaTZQdkhDTUM4T3E5LzJIMk1IRm92a2x1MFhv?=
 =?utf-8?B?TmN3KzVUQ0M2bjJhOHVaQldvVWgyZjIzYkg3dUxiUFJhNXo4N3hkdUdSODI0?=
 =?utf-8?B?eDBockZWWjd4ZUNrZWlPT2QwTnZyMEprTGRuRWdleDRhbk94aUNWR1duajZD?=
 =?utf-8?B?eVhCTGRmcEc0cUJ0UER4a2EzV2ExRVY5MlJnUzVlUUhGZmdnb2xVVnE1b0pZ?=
 =?utf-8?B?QXRlYW9oYzVFVzh2VHlvNkl1VWNwRGFTYkFicHNUU1ZGMWFhcFFDZnpzTXVW?=
 =?utf-8?B?a0JsOTA2MUl6Ui9YYXBzQ1R1ZFFIZW9BNlZuaUZ3VlROSUpvZ01MbnFEUlJa?=
 =?utf-8?B?dTA2L2xYRzI3N0tiMnhOYUx5b1kxK3lyQnNqdUxoVU91blpSckxBandxZ3gr?=
 =?utf-8?B?ZGR6cDg2UFZaOFA1dWxldWRKTWRtam1POUZ6TVJSczZwYnpFcFpwMDRoU3M3?=
 =?utf-8?B?REpPSzNJUU5JZ3BtYkFjT0dXMkM3dXRYU2E0R1RTbXB5cXJNTWx1NkdRa3F3?=
 =?utf-8?B?SnBJSHdUemlVK1c5ekwxTmI5OERIdUlMMFFwZ3JWeWRmTTMrRU8zenJ2QWhE?=
 =?utf-8?B?RjkrWG83TmF4NUEvWGc0eExxeXh1clFzMjdkVXRoRkYzakhTaDRXS05CN25L?=
 =?utf-8?B?ZlczUCtPOEJvNGZnWVVZZmNWcEtRd0tvb1NxRzlwYXo4d0pYTkVralBSWmVS?=
 =?utf-8?B?YkpTMGZ0RTlsd3lnTjVkU0hXUTNjR1h3WlFyQUxCa21pN2pZS05sYzBDeWhB?=
 =?utf-8?B?Ri9ETkRLbTYvOFJtTEVJTFFCZFhRSkN1L2NmSGFoa1BjNEErcjFXbDVKRkQz?=
 =?utf-8?B?dTZreE0vcHdReU1mZXVMMmxaeDd5UXZlSzN4bEo1NjVINTJmY2FZK0lvMGRm?=
 =?utf-8?B?R2pYUlUycXlOUEZVNFBVeXZPV3FhS0xGYTd6NkQ4MHEzRU1rc0tvTUV0TVZn?=
 =?utf-8?B?VWdCb0t0QW5CTEMxeEVrZ1VGc1BaclFoYmZnbTZwWmYvRDdWUWxvNnU1OEdQ?=
 =?utf-8?B?a2JvdkxoSXRnSGdXQWdleWJ3UWNmSUVpZlV4Vk00Z0hHMC9mUS9BVWpvZWRn?=
 =?utf-8?B?d3VOZUgxT2NMTjlUV0haclc2S2dlKzZzVTBrS3FEZTFhVDN5RG04THN0R0JZ?=
 =?utf-8?B?UXpWVDhEeDNZa09WdWhEYWhoZklMWGFnakRON3I5Rm8zUjkzWVZ5YWVzUlVr?=
 =?utf-8?B?R1YyS0d4VWs4dVhSQmRFbE90cTF6YkRNUTQ0WFpNSzAwcHI1QjZicDBpZnZI?=
 =?utf-8?B?dUJXZnJ0cHRFcTYrTVk2U2tYYnRSc0JWTm84V2hwcWpDUWVSS2JPYjJ4NEt6?=
 =?utf-8?B?dDJjTHphRWFueURnZUdjcHpRdnd1RUtCclNyNEFvRXFwekNmZHhWZnFmZUtH?=
 =?utf-8?B?bEhDTUQydWdWRHlqRnRabDdpTVVPRE9nd1NWZGdwVm9QVHB2NVRTMjJ0Y1Ix?=
 =?utf-8?B?VlQyUGpTRXJaWk53NXcwTVgyOTRUelBHaDROYUlSdG4rS2dNZ1I4V2Mxam9S?=
 =?utf-8?B?L0NNR3pSYzNPQTVqcWFJL1ZKck5ncEVoL2EvQ2pXTVoyeVEwTWt6NzNKRFhz?=
 =?utf-8?B?bzFiTlR3d2MxdjllODdnVXpTRUhLVFdVaGRnR2NzZHcrSDhXby9EdjdydHli?=
 =?utf-8?B?N3lKV3E5UGhXTW1jYUJVNDNYbGZFL3p0MTEzQjUxenhpbUtkRnRVUk5xYzhs?=
 =?utf-8?B?b09SekNUc1FBY2d2ZEFLWWtIZ1NXTlRSRnA0d0RKUGF3aEpTQUFDZVhtV3Uy?=
 =?utf-8?B?LzIwQ24xcFh2dGR6dnlWejB6ekRZM3MxTThWOGtaYWJIUU4ySkJIWjZPczQx?=
 =?utf-8?Q?QBdohE1AA3oja?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB5825.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SUprRHljaTJsR0J1MDM1djVlTXdNS2lBY3pyR016R1VTZkVKbzcrMHErcE00?=
 =?utf-8?B?c1lmNHF1bC9mbDJIbWYyOFdZZU01NnlJTXpOcDhnQUphMEhFdmZhNVFXOW9R?=
 =?utf-8?B?NmZxcytKUHNKejl1ekJBYWdXQlJ2aFFUOXljQjkram1XbVFqaDlYSFhDajlB?=
 =?utf-8?B?WjhVOWJNb2JNeW1vU3l2cGl5TW1xL3BxZ2ZxUEFoQ09uQzlQRVBXM0o4THdJ?=
 =?utf-8?B?TTE5akFHWXpjWUJWYkU3T2d6MlhWdi9WVWk0ZGU1SWRvdE13VWZMTUdxdDly?=
 =?utf-8?B?RzRpcjZHREhtMGpzVWR0YVVNeG1rNDdjNTlmRG9WbTJpZGZHVVN3T01aQXY4?=
 =?utf-8?B?NkJDTTd4eldEMjV2enpSUGdYMmZ0VWNqbTFqQjJpYzZPWnNmdUxOemVGR2Zm?=
 =?utf-8?B?b0JReFlTR0tqQXBIdUtzOFRDZDlyVkNiMVFvKzNwZXQ5ZURXKzVkTEhYNUJX?=
 =?utf-8?B?bTRpT0twcnFLQWVvRkNmcVoyVzI2K2hnUytYa050OUFOWllWM2JlaGVGa2F1?=
 =?utf-8?B?RmdpK2l0KzRaeXMwUE1meFNpcFJEODM0cWVOblJFdERCZWNQNFFlTlpUUEUy?=
 =?utf-8?B?Y1NPM1VCUG5vbG1QYUdmTnk4ZkpTQ25LeHZja0Z5dWhWQTdDRXhLUjNoa1dP?=
 =?utf-8?B?bEp2U1dwK3JJeU4vQ3NCUzhrV3M4ZE50bTl0NXRDNW9LQm1UeUdMUTEwWUZT?=
 =?utf-8?B?STFWZGRqYU1NdGxlVW1jN1VsZzNXVFZIK3QzQjJmQlRCbFNtRmhSSVdEdjl5?=
 =?utf-8?B?N05LK3NZS1d1R1J1M1VkWjRWdXUvN3pOdlhLazZSaHE4eG5HMll3aWRIQWpU?=
 =?utf-8?B?NDlBeXRzZ2N5L2lhRDI3dGpxVVN5VzFPWDA4RUt2cjJ2VFUvdlFQazhRREpz?=
 =?utf-8?B?SjJDYVVGVXY0R3AxcWpaaHB5QXc5Tk5maHRhTlVwY2N4QXQxNEk3ZGhrZlAz?=
 =?utf-8?B?MFdCMGt3Q2ZWOHFkb0VRSnR0SVUxVDluN0RiR3NkTHJ5UEdYSktMQVh2MGhI?=
 =?utf-8?B?Rk9ZVHczcGp6U1Rla1UrQjV2UnZjTXhtd2l5cWh3OUNIVGZtU2loYVBKTmtt?=
 =?utf-8?B?bC9SMlJ0ejFodVZEd2ZVTC8vSEt0VWtmbDZVa3h0R1RUVUZQQXdKdFF1UG5E?=
 =?utf-8?B?dzJHRUdUellVQjZ1blZjNlBJRFV2c0JFTnV0NERSUTczcGtPZ3JNbFQ2Wi9D?=
 =?utf-8?B?cWEwejgrWThBRDl2bEZnMWRMZE1JNEwyNEdCNWY0OGc2TlNDRytMb1dpeWJ6?=
 =?utf-8?B?dDJhTzlxeTJWeWtuYmNRRWVtZ01YT0FZVEtkMmZRanlKL3ZPMWoydTFOUC9R?=
 =?utf-8?B?NUtiQjNUR3lZWlJnK2VnRWhvczRQOVZZZDE4dGc1U0N4RjBHNE4yN1VSeHNH?=
 =?utf-8?B?bDlZWk8wNFJPVVltY1VWOEtSSEhuU3JHS0p0YW5JRm5QTXluU0pVazVydzV2?=
 =?utf-8?B?K3RER0E2NGFwMzV6S1ZSb0FubjZCMDZoT00yWXpNTTBaTldHOWkrZ21qQkxI?=
 =?utf-8?B?VU9iRlQ3S2I3REE2NUlwNDdYQVkyK3NCc1BBcEVscW5XUTBaL01vMllFVzR5?=
 =?utf-8?B?RFFzU29BbVRYdVYvcnMrYTdIRWhkY0FEMVkzY0pqeGwwdXVvRHBxSytGYURm?=
 =?utf-8?B?NnlOUk52VVdwTnJrbDlKVXRUdURYckFiQm9ob3ZwVFBmYU5TQlBvWWdtSXZN?=
 =?utf-8?B?Z0tkTWo0bmpnY1ByV05qZmFaY2RMOW5zMERuL0NRUVlUUmdjNStPRHJvOERw?=
 =?utf-8?B?NW0xc2xOdHdmNGNEQ1Z4VjBUVzBFY0RTc090eGVaQ0N4QmplOGRldk1aZ3lk?=
 =?utf-8?B?anBWcWdKdlc0QU4xYlkrTFJZaXNid3NRK3U4QVZoMURIeWVKS3pyQ0Fxdmor?=
 =?utf-8?B?UVZ0c1NoZWU5NkF0eVVsUUpuanlIOCtBbXhuTW9pRGNvUittTDJkN0Q1Q0tp?=
 =?utf-8?B?MEplMm5pWmk2Vk9XNlh1eUx6TDNpT2FOclNYWityYlFranBWK0lGbCsrdSt6?=
 =?utf-8?B?Sk5PU1ZtUE9kNElUeXVBSzFkOXo2cWdQQnErTzB2QS9SRlI3UXFkcXhtUnFR?=
 =?utf-8?B?RzhyWDRvRUs1Mm5FNjdPNWVWcURIWmkrQk5uRWFheGx3V1k1M3FBM29nSFV1?=
 =?utf-8?B?VnJkYkxSTjZMVEYrSUltTmJyM0ZaVWxoZVhmWmpPblYzd2NVMW9aSmxJWnR5?=
 =?utf-8?Q?maR8SK93TTQkUzLVqSBBbZU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <30A4EE647A65AA4383655EB2B774C336@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB5825.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22f0f075-191c-43c9-0e97-08dd032bf001
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2024 15:09:00.1275
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M7syG2MYFAPUPunTGWgmckKUsQQO18A6Yt0s8ySOkjY+LVQk6WdKKlxVRiXiV9F6rqHmx6xCD51OE7Q2+p0neDbZD4nJlAV+5W8iGaRFrJw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5190
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI0LTExLTEyIGF0IDE3OjAzICswMjAwLCBHcnVtYmFjaCwgRW1tYW51ZWwgd3Jv
dGU6Cj4gSGVsbG8gRGFuLAo+IAo+IE9uIFR1ZSwgMjAyNC0xMS0xMiBhdCAxMjo0NCArMDMwMCwg
RGFuIENhcnBlbnRlciB3cm90ZToKPiA+IEhlbGxvIEVtbWFudWVsIEdydW1iYWNoLAo+ID4gCj4g
PiBDb21taXQgZThiYjE5YzFkNTkwICgid2lmaTogaXdsd2lmaTogc3VwcG9ydCBmYXN0IHJlc3Vt
ZSIpIGZyb20gSnVuCj4gPiAxOCwgMjAyNCAobGludXgtbmV4dCksIGxlYWRzIHRvIHRoZSBmb2xs
b3dpbmcgU21hdGNoIHN0YXRpYyBjaGVja2VyCj4gPiB3YXJuaW5nOgo+ID4gCj4gPiAJZHJpdmVy
cy9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9tdm0vZDMuYzozMTIxCj4gPiBpd2xfbXZtX2No
ZWNrX3J0X3N0YXR1cygpCj4gPiAJZXJyb3I6IHVuaW5pdGlhbGl6ZWQgc3ltYm9sICdlcnJfaWQn
Lgo+ID4gCj4gPiBkcml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL212bS9kMy5jCj4g
PiDCoMKgwqAgMzExMiBzdGF0aWMgYm9vbCBpd2xfbXZtX2NoZWNrX3J0X3N0YXR1cyhzdHJ1Y3Qg
aXdsX212bSAqbXZtLAo+ID4gwqDCoMKgIDMxMTPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHN0cnVjdCBpZWVlODAy
MTFfdmlmCj4gPiAqdmlmKQo+ID4gwqDCoMKgIDMxMTQgewo+ID4gwqDCoMKgIDMxMTXCoMKgwqDC
oMKgwqDCoMKgIHUzMiBlcnJfaWQ7Cj4gPiDCoMKgwqAgMzExNiAKPiA+IMKgwqDCoCAzMTE3wqDC
oMKgwqDCoMKgwqDCoCAvKiBjaGVjayBmb3IgbG1hYzEgZXJyb3IgKi8KPiA+IMKgwqDCoCAzMTE4
wqDCoMKgwqDCoMKgwqDCoCBpZiAoaXdsX2Z3cnRfcmVhZF9lcnJfdGFibGUobXZtLT50cmFucywK
PiA+IMKgwqDCoCAzMTE5wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIG12bS0+dHJhbnMtCj4gPiA+IGRiZy5sbWFj
X2Vycm9yX2V2ZW50X3RhYmxlWzBdLAo+ID4gwqDCoMKgIDMxMjDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgJmVy
cl9pZCkpIHsKPiA+IAo+ID4gaXdsX2Z3cnRfcmVhZF9lcnJfdGFibGUoKSByZXR1cm5zIHRydWUg
b24gZmFpbHVyZSAobWVhbmluZyB0aGF0IHdlCj4gPiB3ZXJlbid0IGFibGUKPiA+IHRvIHJlYWQg
dGhlIGVycm9yIHRhYmxlIHNvIG1heWJlIHRoYXQgdGhlIHR3byBlcnJvcnMgY2FuY2VsIGVhY2gK
PiA+IG90aGVyIChkb3VibGUKPiA+IG5lZ2F0aXZlKSBzbyB0aGVyZSB3YXNuJ3QgYW4gZXJyb3I/
KcKgIEFueXdheSBpZgo+ID4gaXdsX3RyYW5zX3JlYWRfbWVtX2J5dGVzKCkgZmFpbHMKPiA+IHRo
ZW4gImVycl9pZCIgaXMgbm90IGluaXRpYWxpemVkLgo+IAo+IFRoYW5rcyBmb3IgdGhpcyByZXBv
cnQuCj4gSSdsbCBzZW5kIGEgcGF0Y2ggaW50ZXJuYWxseSB0byBmaXggdGhpcy4KCkFjdHVhbGx5
IHdlIGFscmVhZHkgaGF2ZSBhIGZpeCBtZXJnZWQgaW50ZXJuYWxseToKCmh0dHBzOi8vZ2l0Lmtl
cm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L2l3bHdpZmkvYmFja3BvcnQtaXdsd2lm
aS5naXQvY29tbWl0Lz9pZD1kOWI5OWVkY2YwNjE2YTI4NDg2MDA3MWEyZWFhM2I0YjJkYTFlNTc3
Cgo+IAo+ID4gCj4gPiAtLT4gMzEyMcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlm
IChlcnJfaWQgPT0gUkZfS0lMTF9JTkRJQ0FUT1JfRk9SX1dPV0xBTgo+ID4gJiYgdmlmKSB7Cj4g
PiDCoMKgwqAgMzEyMsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBzdHJ1Y3QgY2ZnODAyMTFfd293bGFuX3dha2V1cAo+ID4gd2FrZXVwCj4gPiA9IHsKPiA+
IMKgwqDCoCAzMTIzwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCAucmZraWxsX3JlbGVhc2UgPSB0cnVlLAo+ID4gwqDCoMKgIDMx
MjTCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfTsKPiA+
IMKgwqDCoCAzMTI1wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgCj4gPiBpZWVlODAyMTFfcmVwb3J0X3dvd2xhbl93YWtldXAodmlmLAo+ID4gJndha2V1cCwK
PiA+IMKgwqDCoCAzMTI2wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAKPiA+IEdGUF9LRVJORUwpOwo+ID4gwqDCoMKgIDMxMjfCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCB9Cj4gPiDCoMKgwqAgMzEyOMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIHJldHVybiB0cnVlOwo+ID4gwqDCoMKgIDMxMjnCoMKgwqDCoMKgwqDCoMKg
IH0KPiA+IMKgwqDCoCAzMTMwIAo+IAoK

