Return-Path: <linux-wireless+bounces-19779-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CA69A4EBBA
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Mar 2025 19:33:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7209616811E
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Mar 2025 18:28:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AFF427816D;
	Tue,  4 Mar 2025 18:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LrAVeA9r"
X-Original-To: linux-wireless@vger.kernel.org
Received: from beeline3.cc.itu.edu.tr (beeline3.cc.itu.edu.tr [160.75.25.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAA7E24EAB4
	for <linux-wireless@vger.kernel.org>; Tue,  4 Mar 2025 18:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=160.75.25.117
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741112359; cv=fail; b=EeMD0OYT35sJjriZ9DtVvtoPvvlnN3BvQDNmmGjWd3LRdNRh5giJMXN2M3uZ0UYbgzUvHgCe1kfIKU8syyHVKsJt5eAaa7sDFCQdM7zyz5oHNJM01erNu00zPVYhOKE2yigaOPxaem0nSnYzTmoYw4i+iGEmbopd3iMygT79Qi0=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741112359; c=relaxed/simple;
	bh=m/kuQieIX2XgrmgXLtwT4vTUgIKfVCEgdlUnyaVsc4E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EWFdmqOrpfBtZuG+otVp1fxjhW2M2hhBCI4tbsRXGdCs1lJi4XLbVl3A62cpl+LOZ/pKDk9X3Rl818RRO5m7Z2X1IIEHQLtwjcEHlouT99sm7bzSE++p2OPMgWYs1JXbole0QMtXEO6NusGMJx5t4pJhlwsWjXdDbm7ZwqfwmqY=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=none smtp.mailfrom=cc.itu.edu.tr; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LrAVeA9r; arc=fail smtp.client-ip=192.198.163.9; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; arc=fail smtp.client-ip=160.75.25.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr
Received: from lesvatest1.cc.itu.edu.tr (lesvatest1.cc.itu.edu.tr [10.146.128.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by beeline3.cc.itu.edu.tr (Postfix) with ESMTPS id DCCE340D1F4F
	for <linux-wireless@vger.kernel.org>; Tue,  4 Mar 2025 21:19:14 +0300 (+03)
X-Envelope-From: <root@cc.itu.edu.tr>
Authentication-Results: lesvatest1.cc.itu.edu.tr;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=LrAVeA9r
Received: from lesva1.cc.itu.edu.tr (unknown [160.75.70.79])
	by lesvatest1.cc.itu.edu.tr (Postfix) with ESMTP id 4Z6dj75yxfzFxTB
	for <linux-wireless@vger.kernel.org>; Tue,  4 Mar 2025 17:43:39 +0300 (+03)
Received: by le1 (Postfix, from userid 0)
	id EFCD54273F; Tue,  4 Mar 2025 17:43:30 +0300 (+03)
Authentication-Results: lesva1.cc.itu.edu.tr;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LrAVeA9r
X-Envelope-From: <linux-kernel+bounces-541845-bozkiru=itu.edu.tr@vger.kernel.org>
Authentication-Results: lesva2.cc.itu.edu.tr;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LrAVeA9r
Received: from fgw1.itu.edu.tr (fgw1.itu.edu.tr [160.75.25.103])
	by le2 (Postfix) with ESMTP id 2D631421D5
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 16:47:30 +0300 (+03)
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by fgw1.itu.edu.tr (Postfix) with SMTP id EFC423063EFC
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 16:47:29 +0300 (+03)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E639F1890ADB
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 13:47:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F538213257;
	Mon,  3 Mar 2025 13:47:10 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A2E723F396;
	Mon,  3 Mar 2025 13:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741009625; cv=fail; b=lrPCLe2d/C/Rs2H02tXmTzyYxzOZza2TgnW7kcd+yA26uA41wMY5NIX6gdgk/ueB5ebXWyOQpfrMrnxd7t56JNImsebaJTpiIy5bd90HNpq9lmgRTb83c1VcKQTUL3fhVyWpo6zdfb+uc0l3Kst5+kWPuVrupydArxKqs6o3+hc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741009625; c=relaxed/simple;
	bh=m/kuQieIX2XgrmgXLtwT4vTUgIKfVCEgdlUnyaVsc4E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LLMHJi2WntH+/jFkTzDx1lIfZk7d5KndsvmkvMQ8yU5sKRIAM8j+xVH2k+Y1cK9JwZ3/GSs+qKfiEl2cr93Ka1kGr2uSrwyeEJA/Q+DggnY525aox8rnn9AzqRwkPKaVdf3Vjsy1ZpIZA03B5AAF5yS9cOX/nR8s+Z96r/GkDwM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LrAVeA9r; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741009624; x=1772545624;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:mime-version:
   content-transfer-encoding;
  bh=m/kuQieIX2XgrmgXLtwT4vTUgIKfVCEgdlUnyaVsc4E=;
  b=LrAVeA9rzhaPK4m2PFdIln6a7cq/sDK8iNOaxGGRHaqLI8EYVu0meoFv
   u7z/r6UqeHzwkNTRPDQHLTUXbKhwdk1hJL3HQMy118gw8HiU936/Tl72j
   kqFxb8dyyVDUA6bU3w7THG1porAw+Saai0yQPbyk+pi0XFh9f2BO+rsAQ
   bTSwkA9KouzBsAjMrsa6yAS3mrrtBpZtiIU734YvOeZt/NfP3k7FeXCVH
   lhe8FqExHHWwVsuDeuUtwR4IGeolo7BIiXo7xg0clVU3jXt+KBXvYymu8
   H2IReEilx4mKhJ+cLEs6O8E40NnXNu/ikyHV4N13ejQXnpOBLOVijgK9z
   Q==;
X-CSE-ConnectionGUID: d6iOQlfdQAOAg1+xcoZPEQ==
X-CSE-MsgGUID: HkO0F/QkT8OfmHwWEmyJAg==
X-IronPort-AV: E=McAfee;i="6700,10204,11362"; a="52522433"
X-IronPort-AV: E=Sophos;i="6.13,329,1732608000"; 
   d="scan'208";a="52522433"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 05:47:03 -0800
X-CSE-ConnectionGUID: jkKcoZD+SYSWPJZ3ffxopA==
X-CSE-MsgGUID: 43GZLUiDSwSEJOCBR++uWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="122139966"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 05:47:01 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 3 Mar 2025 05:47:01 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 3 Mar 2025 05:47:01 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 3 Mar 2025 05:47:01 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eAaTrEYZskpXBSPB+u8dUrYwyJckJ0F4JNYh5+9EnbZ2+5MtMXqDrTYqYCKMsGhwKBNXfiy+rqZBrtaXaVyaXDHs5GWDlLiXBzOoZpOjZ+qiRscXgLZXZAzZg6aeK0pxz8vEMs1VQstFl2njctlG2d/a0VSaZiphZGe5YlKWR8/JRTRwpxSXmazv/elJ7n8I2oNpuUIZNQadQQ6CmKYiAVICAJ/InlboY6mI4gRGGDiDA6zcGX5doFchiPMGcbddK9vT18D0eMJquxL/yjxnbNQFJjPXkUwm3/tSAHPPo8ovQMRcGsRpGxpoMXanD60SXnGKTDEvxrpRt2Mbik19dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1lCUaAfh7NqSb6MQUPttDUkhXntzHQkWwe/XI1IjAXM=;
 b=dobhLWXrTaLkCRUMAkleqm9zN5UMHP4ZWu+ChazD58v2oQKwGl6XIgz8kVLv4iVh2teY+HkDz4yOD5keiopA8zeEFkqaNfkyeLYsWgveJUk5OXEhwwQ6ZxHNMTO2vNaviDWzyCgDg8Ve5FSjwE9d8YHX9RZP7F0efqsA959aMKS7SWZv/qz0Mwk7wx187R5ESKCPnXOBqugsOktMqzq32RKgWUbf2oXEA2kQlgNA6VUxMAXY/DAe8sWmKK4tZcL7zRQJPCH8ht/mTKxPvNo/gnAqeQo0nJ1zG4tjvP/JK5qYCNZNyzZjM9P1oCPChcDylgpCP0rL4uqYVauI89Fx1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB7964.namprd11.prod.outlook.com (2603:10b6:510:247::9)
 by IA0PR11MB8336.namprd11.prod.outlook.com (2603:10b6:208:490::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.26; Mon, 3 Mar
 2025 13:46:58 +0000
Received: from PH7PR11MB7964.namprd11.prod.outlook.com
 ([fe80::1b60:d7c9:1b2a:2a7f]) by PH7PR11MB7964.namprd11.prod.outlook.com
 ([fe80::1b60:d7c9:1b2a:2a7f%6]) with mapi id 15.20.8489.025; Mon, 3 Mar 2025
 13:46:58 +0000
From: "Berg, Benjamin" <benjamin.berg@intel.com>
To: "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
	"Markus.Elfring@web.de" <Markus.Elfring@web.de>, "davem@davemloft.net"
	<davem@davemloft.net>, "Berg, Johannes" <johannes.berg@intel.com>,
	"kvalo@kernel.org" <kvalo@kernel.org>, "quic_srirrama@quicinc.com"
	<quic_srirrama@quicinc.com>, "gregory.greenman@intel.com"
	<gregory.greenman@intel.com>, "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>, "kuba@kernel.org" <kuba@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "edumazet@google.com"
	<edumazet@google.com>, "Korenblit, Miriam Rachel"
	<miriam.rachel.korenblit@intel.com>, "pabeni@redhat.com" <pabeni@redhat.com>
CC: "horms@kernel.org" <horms@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "cocci@inria.fr" <cocci@inria.fr>
Subject: Re: [PATCH RESEND] iwlwifi: Adjust input parameter validation in
 iwl_sta_calc_ht_flags()
Thread-Topic: [PATCH RESEND] iwlwifi: Adjust input parameter validation in
 iwl_sta_calc_ht_flags()
Thread-Index: AQHbjD7QpN77/r5imE6nKxR9LH86KbNhbPcA
Date: Mon, 3 Mar 2025 13:46:58 +0000
Message-ID: <529d640929c2349f2dfe6c3de20331b5b809fcfb.camel@intel.com>
References: <40c60719-4bfe-b1a4-ead7-724b84637f55@web.de>
	 <1a11455f-ab57-dce0-1677-6beb8492a257@web.de>
	 <9cb634c8-d6e6-32bc-5fd6-79bf6b274f96@web.de>
	 <22e24ec8-283f-49e9-b7b0-555e8113c250@web.de>
In-Reply-To: <22e24ec8-283f-49e9-b7b0-555e8113c250@web.de>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB7964:EE_|IA0PR11MB8336:EE_
x-ms-office365-filtering-correlation-id: e319515d-10f5-40bb-1869-08dd5a59de3b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|10070799003|376014|7416014|38070700018|921020;
x-microsoft-antispam-message-info: =?utf-8?B?VWVoZVdNOUsva0pwRzVBOUd0YWdyOTJmc0hrUVdNUldjd2tGRjhmQm9DbWFL?=
 =?utf-8?B?UFE0c2l1L3RWMjZOSTNxN0pjTFhqb1lyc01FU0U0MTBsUjY2cDhxVENRRWZS?=
 =?utf-8?B?bkprR0FabUZoTUtqNjc4dDdOQnJuTCtPYUJHeXZiT0phaVgzQUNOSVh6dlJL?=
 =?utf-8?B?RXYvem1ManVUeDdmMHBGclplZmltNHJWSTVxZ09IOFE4SlJZYjcvUkZqcHBj?=
 =?utf-8?B?MFBPRVA1U2J0SGV5bHVweXVxSGhsMHkyU2NPSm15b1VVMW5FR0ZIN0lHb2tJ?=
 =?utf-8?B?YmhqSUhqWjBYWkRNSVlhdlIvdG5lVSsrK0tBS1Q0TWY3TVZKZG9QNEhRYXRh?=
 =?utf-8?B?Tk02M3hvSWEwMmRWRlFmQncwZTgxNzdrU1VaMEoyNCtYaGV2MU5lTTM4VUEy?=
 =?utf-8?B?d2kyNEYrQW0vQzJIQU1STHBPeDdYZDZHQkRWdzVoVGpBZ3lFYnQzVEZWTVly?=
 =?utf-8?B?UHRjNVJtRDRvTWZ6czYwL2tuYmovU0swRkhGZGoxOEs0UEp5LzQxTjlhV0pv?=
 =?utf-8?B?R3BrUjZ2eUFtdFliWjBMQ2ZvN3VuN0ZZNmJIblhrTlZBYU4zTXVBQW8wc1Vr?=
 =?utf-8?B?NW9oMVFWaWgwcDl3RmRjZWxrdTdpdXlUS2VUZHhMRUpnaFFxY3ZadUQzR3p6?=
 =?utf-8?B?VFlKaTZWUVdjeEdIU2pVOEJkdG94TitGMWVRUVVUM1Q1eFRoQkQrSnl1RWVy?=
 =?utf-8?B?NEtMRUZuWTBhMEdUaE54SGxwcUJHOTZsajVkbG9lNWpHckpEMllCUWxRcTZt?=
 =?utf-8?B?UFVKSDhFRUpWa2MrUmw3QjdaQnQ0YnJkK1ZIM1JnS2VMbS9EdklKU3ZEdFlX?=
 =?utf-8?B?dnR0S0YxaDdiWFVuaVZXVlIyMjZuWThIcTRub1g2aThQVjE4VFdva1dzQ3Jm?=
 =?utf-8?B?SFJKckEvV2pMcUpxZ0RuVkZRSU9qYkQ0Y0c0MTA2dHNNVGdZQXo1L2U3N2lk?=
 =?utf-8?B?MWxpMTRsdmtmVU9RS0hRZVFMTytWTmVBRVpJS1hTa2lvbzJtQzc0YlF4aE9E?=
 =?utf-8?B?V1FvN3ErVmlteUJwZlI4YVNBZEF4Y3hsak1RcWVNdmRVZVpsMkl3eGdwSGRP?=
 =?utf-8?B?TUlMcktvVXdIUTY1KzFGZjJnV0VsYkdwSDVpa3I1dzNvM1lBV0hXcC9waHRx?=
 =?utf-8?B?amNzOWFaM1lWdHVFeWhXNVBTeW53cmJwNmYycFpadEVsOXI1REhCaUVaZ3di?=
 =?utf-8?B?d1UyVkpPbi9ObDRuM0FXMTZFMmxlaFhtQXYxL1BLTnR6cnZnYWk3YkJNUWRO?=
 =?utf-8?B?TTdmU0ZkSTFndFRTOTBhd3gwOVcwakpIN3IycXVWVWZxanhBek96VFFSREp2?=
 =?utf-8?B?K3RjWCtnWThEMmRvTWdZUmhzSTZYVk9ReHRlZEh1WnRqb25tZWs1am1ud0dB?=
 =?utf-8?B?YUhlMXNxV1AxMDhPdnp0N21EOG5UMithdzUrMHJMV051OWtEZThPOXdDZTFD?=
 =?utf-8?B?YTZXcS9vNVNGZGdQSkZVUFcyY2g4UnhkM2RVbThOL0lBZ1Q0WEx0SDJjMU5k?=
 =?utf-8?B?azM0NTFSVjMyWXJzM2Z1eEVaTDlXUHpjbFBzS1l0cS9lRXB4Wm41aW81S3lq?=
 =?utf-8?B?Qk1PUUdtYjFMT0FPUCtpcG5sMExVcEZ5djRBZm83aGhSekVLSU9GT2dZaWN0?=
 =?utf-8?B?d0RlUUMwTlg3TDAyUDNZbmNWY2RYdHVDZTc0aWY5VVlST1VqSGVpcW16dVVC?=
 =?utf-8?B?MlE2MG10VTc2eFlDWnNkK2NKNXovV0tYUUhGeXBNVW5rcDJ2VjJEMGtxbUZi?=
 =?utf-8?B?alBvM1BYVGl2WmhsazBrdGIzNUZRTHUxMDd5SDNJOFhadUVWVEp4SGE2NTY3?=
 =?utf-8?B?MFE1R0w2V0hHQzlHOHdPcXh3Z0l4dmc1QzArYldyVWZZZDdYN25tQlFOZ1pF?=
 =?utf-8?B?VE9BZVhBMUtSTXFnS3BqRDRWdHk3ZkFrbUNUMnFsTkQzL3dzR1EyUDhjVTRh?=
 =?utf-8?B?ZjlPdlRKeUYwdDhscGtsVllVS0JsblBtenl0NHFjQS9uVHhETDZueXpGSStY?=
 =?utf-8?B?UWppTHpZc0N3PT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB7964.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(10070799003)(376014)(7416014)(38070700018)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S0gxOS9KamZsWVBCWWFBaFZmWGtzeVNqUk1yRmNmQzBNblJQLzlJS3BkY3BY?=
 =?utf-8?B?aE1aYnI1MkpoYzI5WHlUcHhqQWRCTmVLN0dTNTc0QnhORGJBUmoxc1h3blBI?=
 =?utf-8?B?b0dHNEVNRDhndTI2YUcrelNSYitzQWg3bThqR2FQNGpmNnBSUSs4ZVFFQnFX?=
 =?utf-8?B?enNqSm0xejN2WDJ6SDR1bjg0dlVjK2xkeFNIcXBlZzFML1VCUDVrRnpqUmcv?=
 =?utf-8?B?SlBHSENHREkwUWY4emJzL3ZLeW5MYUR6bGlmMkpJY1JJU3doNUxybFg2Vk53?=
 =?utf-8?B?Ri8wZGJFWnc2ZklHQTQ3bTBFLzdaZ2NLVUpRRS9FQVFnZkpxK2JJdUYwVzV1?=
 =?utf-8?B?eWNXZ2tKcmZqQ0RocHZkWDczb2hVREF3a2lyYmVGbHZjV01kaWdNZ28vbno5?=
 =?utf-8?B?MmV6d0NhdWFxSjJ3aUhNaGZ2S0doM2ZEbE5PMGo4SVhGY1IwUmJwN0hmTzYz?=
 =?utf-8?B?YzFmYVFZdGNuMHI2dC9SbEtrZ0QyK0F0ZHY0UUpqY09Ia2U2ajRXYlNSV2J0?=
 =?utf-8?B?bExJWXV2Rk1IM2dEVjdVcytuWE5STEtTeWU3ejVhekovdFJvR1VkcEdSeXJL?=
 =?utf-8?B?RjI4dmx4NGRFbjdWSDJ3OHFCajZqYzI0dUtNZFBTRmFpeUo0MWtaNG1NZ1l5?=
 =?utf-8?B?Y2VIUEhOS3dHN1hRbGJ3dDdOb1BVbVFORFhENlZDTlpJVW1nV0ovb2hXNW92?=
 =?utf-8?B?OW5MOVRia0VMRnpUOTB2MGdMNTJSWEFuWElMNUtNSitUMUg0OHRtSUhqYm56?=
 =?utf-8?B?RFUwdzNEWTJ3RFd0VUtYRWl2aVpiTkZXVElOSVNEWnJCYXJWNnEySWNGbWZU?=
 =?utf-8?B?MGZrUlpjN1EzcE1DSDZNRnplNm1IbWExOVNMUnBrbEZXSFAwUDNCdjhKdHJ4?=
 =?utf-8?B?b0J3WlkrS2dtdDkybkg5Z2thQUVKb2plaDN3dnRPWU04Y3V3VElwMi80QjFo?=
 =?utf-8?B?OHpzTWExVWovYmN5Z1dYbUE2ZjZJRmtwMVo1d0Zwd3FWYTdIT2VCTlA2UWlq?=
 =?utf-8?B?WHByQ2QzNFhwOFdVNDIwQWJsak40Yk9aV21TV0Y3d2RYOWEremNHdlpidllh?=
 =?utf-8?B?VkJLZlUwQjZCUFpuRDAvNjRqeVk1VVNUU0NCZk1Ob1QydnB4WFJjN1lUdHRR?=
 =?utf-8?B?ZVBrNm1TUHUvdzUyUEE1djFlSzNleGhVQUtQbGphek5YSXZUaEw4c3pxSmNR?=
 =?utf-8?B?Tkxyd0ozN0R0anZ3U1h1QmNzQkJKN0t2cnNSa3hjYVlaSndrQTVhUFpPanBC?=
 =?utf-8?B?K2plS2ZhOWZ4S3EyM1FiaVFaSi9LL215VTlaYU15Vkg0WkxzYWxIOFNLSlQ3?=
 =?utf-8?B?RzgzS0t0Q2J5R3UraVlxUXM4aFV6Um93bmJHdlBreGREUzRyeFhkR1FiMU12?=
 =?utf-8?B?Zlp0QXF4bTZzYldpMG5HcU5YZTdyMkZJNDgwRE15STQzbDUwb2gxR3hYUDFq?=
 =?utf-8?B?QjI0c0orOGxNeDB5YUpOUjVURWN3NkpUY3ZEbFR5K2pPaHpRYW9OeldmeWs2?=
 =?utf-8?B?TFNHWnhnL0psb1ZzNFF2bGFiT09BTjY1RUxzZWlIblZIelhxeCtCdW1vQ0pu?=
 =?utf-8?B?bVFBMWFJdktsYkFsbytVRWg3cXF6a0grR3F6eUxoam5EajF1QUo3Z20waG96?=
 =?utf-8?B?VG9tSFhRSjR5MXRJTCtVSytRU3RLSXBFYVcyTTJqUzZrdTJBdUIxU1FBaGNW?=
 =?utf-8?B?NWpjc0JYaTE2ZWxBT2haMkk2QW94YlN2dWxpTHZwRlAzNzBSVzNYbFZDS0xK?=
 =?utf-8?B?dWxEeGsxU3daODA4VUZ2WXdkZUpYZnRCbkNWVi9JVnVLTytpaFcrR1BHTEU2?=
 =?utf-8?B?dDFzQTRYM0ZDUWZaNUJtdkhoZmZGQWptekprenJUcjNDNHk0Vi9IOURvM3BB?=
 =?utf-8?B?Z0E0NVR1WWUwRk1lU0MvK3YvdmduMGw3WmhydWEyUW9WRjgyamlOQUZIemth?=
 =?utf-8?B?UWlndTJVekQwZzdlL2VlL2FPbEpNZnJ2cU9uRlFDK2J4ZkpSUkRjS2lPOXl4?=
 =?utf-8?B?dHBFeTdGL09TbzNCbmZGTi9rUkkvblpOenN6TXNGSEVkQ3hwOVRXRUE0MlVn?=
 =?utf-8?B?QVh4V3J4cE1CYTN0VFhtQ1RlQ1IyeU45Nk1tNHllTzBwMndJdzUvT3dSd0I1?=
 =?utf-8?B?SThIdllhMjNmbGt6SUYzL0FNaHF3YWx0RGduSDkxcmkyeEF6aE00UDM0VFM2?=
 =?utf-8?B?U2VZT3NyOTBPVmxXaGtaSGxBVFdlbktYRFBTaFd2ZTY2T1E3QW50M2hlTCt3?=
 =?utf-8?B?SSszWVlJQ05aM3RnY0tuWkNQSnBRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <341285465845ED4C956DFAFA92FBA564@namprd11.prod.outlook.com>
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB7964.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e319515d-10f5-40bb-1869-08dd5a59de3b
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2025 13:46:58.3185
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U4BT6zAvZaaO4GR/Fhvhqr8cAhnR10ULScDiJM/0wIsUe3Qns+yCX1La5rAGUSR7n15eJ76/zFOD5lHkSKtCOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB8336
X-OriginatorOrg: intel.com
Content-Transfer-Encoding: base64
X-ITU-Libra-ESVA-Information: Please contact Istanbul Teknik Universitesi for more information
X-ITU-Libra-ESVA-ID: 4Z6dj75yxfzFxTB
X-ITU-Libra-ESVA: No virus found
X-ITU-Libra-ESVA-From: root@cc.itu.edu.tr
X-ITU-Libra-ESVA-Watermark: 1741717040.49936@8E1X5x5y1H+3dDHUoLXmEw
X-ITU-MailScanner-SpamCheck: not spam

T24gTW9uLCAyMDI1LTAzLTAzIGF0IDE0OjE4ICswMTAwLCBNYXJrdXMgRWxmcmluZyB3cm90ZToN
Cj4gRnJvbTogTWFya3VzIEVsZnJpbmcgPGVsZnJpbmdAdXNlcnMuc291cmNlZm9yZ2UubmV0Pg0K
PiBEYXRlOiBXZWQsIDE5IEFwciAyMDIzIDE5OjE5OjM0ICswMjAwDQo+IA0KPiBUaGUgYWRkcmVz
cyBvZiBhIGRhdGEgc3RydWN0dXJlIG1lbWJlciB3YXMgZGV0ZXJtaW5lZCBiZWZvcmUNCj4gYSBj
b3JyZXNwb25kaW5nIG51bGwgcG9pbnRlciBjaGVjayBpbiB0aGUgaW1wbGVtZW50YXRpb24gb2YN
Cj4gdGhlIGZ1bmN0aW9uIOKAnGl3bF9zdGFfY2FsY19odF9mbGFnc+KAnS4NCj4gDQo+IFRodXMg
YXZvaWQgdGhlIHJpc2sgZm9yIHVuZGVmaW5lZCBiZWhhdmlvdXIgYnkgbW92aW5nIHRoZSBhc3Np
Z25tZW50DQo+IGZvciB0aGUgdmFyaWFibGUg4oCcc3RhX2h0X2luZuKAnSBiZWhpbmQgdGhlIG51
bGwgcG9pbnRlciBjaGVjay4NCg0KSSBhbSBhIGJpdCBjb25mdXNlZCwgSSBkb24ndCBzZWUgYW55
IHJpc2sgb2YgdW5kZWZpbmVkIGJlaGF2aW91ciBoZXJlLg0KDQpUaGUgY2hhbmdlIGlzIG9idmlv
dXNseSBmaW5lLCBhbmQgSSBndWVzcyBvbmUgY2FuIGFyZ3VlIHRoYXQgaXQgaXMgbGVzcw0KY29u
ZnVzaW5nIGFzIHRoZSBjb21waWxlciB3aWxsIGdlbmVyYXRlIGEgd2FybmluZyBpZiBvbmUgdXNl
cyB0aGUNCnZhcmlhYmxlIGJlZm9yZSBhc3NpZ25tZW50Lg0KDQpIb3dldmVyLCB0aGUgY29kZSBp
cyBib3RoIHdlbGwgZGVmaW5lZCBhbmQgY29ycmVjdC4gSWYgc3RhIGlzIE5VTEwgdGhlbg0Kc3Rh
X2h0X2luZiBpcyBuZXZlciB1c2VkLCBzbyB0aGUgZmFjdCB0aGF0IGl0IGlzIGVmZmVjdGl2ZWx5
IGEgTlVMTA0KcG9pbnRlciBbb2Zmc2V0b2Yoc3RydWN0IGllZWU4MDIxMV9zdGEsIGRlZmxpbmsu
aHRfY2FwKV0gZG9lcyBub3QNCm1hdHRlci4NCg0KQmVuamFtaW4NCg0KPiBUaGlzIGlzc3VlIHdh
cyBkZXRlY3RlZCBieSB1c2luZyB0aGUgQ29jY2luZWxsZSBzb2Z0d2FyZS4NCj4gDQo+IEZpeGVz
OiAwNDZkMmU3YzUwZTMgKCJtYWM4MDIxMTogcHJlcGFyZSBzdGEgaGFuZGxpbmcgZm9yIE1MTw0K
PiBzdXBwb3J0IikNCj4gU2lnbmVkLW9mZi1ieTogTWFya3VzIEVsZnJpbmcgPGVsZnJpbmdAdXNl
cnMuc291cmNlZm9yZ2UubmV0Pg0KPiAtLS0NCj4gwqBkcml2ZXJzL25ldC93aXJlbGVzcy9pbnRl
bC9pd2x3aWZpL2R2bS9zdGEuYyB8IDggKysrKysrLS0NCj4gwqAxIGZpbGUgY2hhbmdlZCwgNiBp
bnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
bmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvZHZtL3N0YS5jDQo+IGIvZHJpdmVycy9uZXQvd2ly
ZWxlc3MvaW50ZWwvaXdsd2lmaS9kdm0vc3RhLmMNCj4gaW5kZXggY2VmNDNjZjgwNjIwLi43NDgx
NGNlMDE1NWUgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdp
ZmkvZHZtL3N0YS5jDQo+ICsrKyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkv
ZHZtL3N0YS5jDQo+IEBAIC0xNDcsNyArMTQ3LDcgQEAgc3RhdGljIHZvaWQgaXdsX3N0YV9jYWxj
X2h0X2ZsYWdzKHN0cnVjdCBpd2xfcHJpdg0KPiAqcHJpdiwNCj4gwqAJCQkJwqAgc3RydWN0IGl3
bF9yeG9uX2NvbnRleHQgKmN0eCwNCj4gwqAJCQkJwqAgX19sZTMyICpmbGFncywgX19sZTMyICpt
YXNrKQ0KPiDCoHsNCj4gLQlzdHJ1Y3QgaWVlZTgwMjExX3N0YV9odF9jYXAgKnN0YV9odF9pbmYg
PSAmc3RhLQ0KPiA+ZGVmbGluay5odF9jYXA7DQo+ICsJc3RydWN0IGllZWU4MDIxMV9zdGFfaHRf
Y2FwICpzdGFfaHRfaW5mOw0KPiANCj4gwqAJKm1hc2sgPSBTVEFfRkxHX1JUU19NSU1PX1BST1Rf
TVNLIHwNCj4gwqAJCVNUQV9GTEdfTUlNT19ESVNfTVNLIHwNCj4gQEAgLTE1Niw3ICsxNTYsMTEg
QEAgc3RhdGljIHZvaWQgaXdsX3N0YV9jYWxjX2h0X2ZsYWdzKHN0cnVjdA0KPiBpd2xfcHJpdiAq
cHJpdiwNCj4gwqAJCVNUQV9GTEdfQUdHX01QRFVfREVOU0lUWV9NU0s7DQo+IMKgCSpmbGFncyA9
IDA7DQo+IA0KPiAtCWlmICghc3RhIHx8ICFzdGFfaHRfaW5mLT5odF9zdXBwb3J0ZWQpDQo+ICsJ
aWYgKCFzdGEpDQo+ICsJCXJldHVybjsNCj4gKw0KPiArCXN0YV9odF9pbmYgPSAmc3RhLT5kZWZs
aW5rLmh0X2NhcDsNCj4gKwlpZiAoIXN0YV9odF9pbmYtPmh0X3N1cHBvcnRlZCkNCj4gwqAJCXJl
dHVybjsNCj4gDQo+IMKgCUlXTF9ERUJVR19JTkZPKHByaXYsICJTVEEgJXBNIFNNIFBTIG1vZGU6
ICVzXG4iLA0KPiAtLQ0KPiAyLjQwLjANCj4gDQoNCkludGVsIERldXRzY2hsYW5kIEdtYkgNClJl
Z2lzdGVyZWQgQWRkcmVzczogQW0gQ2FtcGVvbiAxMCwgODU1NzkgTmV1YmliZXJnLCBHZXJtYW55
DQpUZWw6ICs0OSA4OSA5OSA4ODUzLTAsIHd3dy5pbnRlbC5kZQ0KTWFuYWdpbmcgRGlyZWN0b3Jz
OiBTZWFuIEZlbm5lbGx5LCBKZWZmcmV5IFNjaG5laWRlcm1hbiwgVGlmZmFueSBEb29uIFNpbHZh
DQpDaGFpcnBlcnNvbiBvZiB0aGUgU3VwZXJ2aXNvcnkgQm9hcmQ6IE5pY29sZSBMYXUNClJlZ2lz
dGVyZWQgT2ZmaWNlOiBNdW5pY2gNCkNvbW1lcmNpYWwgUmVnaXN0ZXI6IEFtdHNnZXJpY2h0IE11
ZW5jaGVuIEhSQiAxODY5MjgK



