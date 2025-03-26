Return-Path: <linux-wireless+bounces-20856-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 99DD2A71BF7
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Mar 2025 17:36:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1F1F189AE45
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Mar 2025 16:37:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13CB21F709E;
	Wed, 26 Mar 2025 16:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V0SFewDQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A3C416A395
	for <linux-wireless@vger.kernel.org>; Wed, 26 Mar 2025 16:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743007006; cv=fail; b=aHMiXX/UFUweMl8Yp1cLoOSqr06AQ747uGmEoA7UWLtUK2xc/8F1lzk2DFUwte+HecH9ao/T7b0eq5zy1KL8m36cQtF/8T5F+zdU0ZRxSgKB+HZDyq/2RxDh33WEjJZ+Oo/Fh2QovEBEbuyCKwvJRW+HtFhxsvrgtBxnC7CuLGw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743007006; c=relaxed/simple;
	bh=Qr4RgvCJYvpzJx98gM7wwtElDm01keh3E2srd59sdfw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fJeCoY527zX1sxwJHWaN+xR9RpA21Bal43pPu/cf5cqXJJHHnYgC1FG8ll0OsyEBVjdp/j1CUamROSW5WmDHt5VeZN9goHtMIm2AioqJkEp/U7x5+37XJVpaXLd2HRVRdK0KMSQllyR5cS7WSwNg4taJHpSV8FYCVP1hWlr/ZAE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V0SFewDQ; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743007004; x=1774543004;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Qr4RgvCJYvpzJx98gM7wwtElDm01keh3E2srd59sdfw=;
  b=V0SFewDQpfQ2yO1XVFLiHwmDdaN3SL55QBr14TgdcOUUVv/ALTtcgzww
   dUjs2A2CTTL/Y/5JRL7LyezNZyp5QboXOtO6Sirnw/99o5tmVi+ymUMEd
   Ou5dKjTwFfQS9xK8lcU1YsYYlJqWs1SfymrIeEde7vF8TWIJAb6lCbsJK
   OVrps8vol02LohBP9nnGO5+BLveFpzAWGhM0eSdCXgBCTXKEeAGRlZoRk
   CVup1zMr1eQ2OsIZjy1HqcCD5b0/0cWITDZZgYv2eOdfR2M3OENU3ne5x
   JIuYEkAZZS3riH0dcKr4tjx0tOl8vyUKo9jRvFOF/7mdxl5pjz0GYdhNM
   A==;
X-CSE-ConnectionGUID: TGu7MjcGRMiwlKByWUmL8w==
X-CSE-MsgGUID: 1BSz0dssQy+J8yAB4EDnew==
X-IronPort-AV: E=McAfee;i="6700,10204,11385"; a="54968174"
X-IronPort-AV: E=Sophos;i="6.14,278,1736841600"; 
   d="scan'208";a="54968174"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2025 09:36:43 -0700
X-CSE-ConnectionGUID: Itfvd3QNTn6gJ+aH2jSnAA==
X-CSE-MsgGUID: Z4kM5+sLSYCRqfAPWN2Kog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,278,1736841600"; 
   d="scan'208";a="125655692"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Mar 2025 09:36:44 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 26 Mar 2025 09:36:42 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 26 Mar 2025 09:36:42 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.170)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 26 Mar 2025 09:36:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NaZirz17KGvlT7fen0xIQdLEczHBs1zxLLmz+H5A/28oi8n8FQQ7bzYAwMXU1V5xYrR/bCqk/+8KJ9uf8X4wTbX9SrMB0FRhPdSAKr/Hr4BSXzavr3mvsAYJ3Hn7f0bKADJ+2iVX0Bc5yMElPg3P3XBxSRgQeSmnxuE/igVdcJP3QU+vRcN93lWx0+vuiNysAiDh+USRvDBYifXY06fEIQT4AWnk/9hEo26I+b/nDKNON0rL86LMsnPGvTtNEvODcQR7q3A9bGgmAzr1v0ToNf/43rgN1pYyWub7VEkx2gwzc+7kCc1UReLtBpxph9B/Em+sps1FrrB3R4n4XYXcfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qr4RgvCJYvpzJx98gM7wwtElDm01keh3E2srd59sdfw=;
 b=YPeWoFB2Fljtjaz0JqU/os2gsWPPkCRhFVzW5+HxvyrlWiXzLjoolgRPY41WTC/M0cGlLSDPNYsyCDZ8mgqYlpcTdMqb5vcWDbjL1/kjxk/EhPhuOLXuVdOyzAUTPyzhZqpyLrz17YyJHNGjich1rWonE/12oeogE58M8Y+jx6J02DmKV3VAPX66FwUgrLj8VOmtFQ7mGfLzwYLayokY9++CNAwqkhnFdqoowfg+nk9k70jR6Do9rvRVoVIciljec4D0yqjR3MwrFpB+V4dOXFk9uYpSz+pgdx2wpp4YmEVivDA2W6e3Snvo7H84d6/7FgIaxXwjSLz61/ttIBXC3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB5820.namprd11.prod.outlook.com (2603:10b6:510:133::17)
 by CO1PR11MB4883.namprd11.prod.outlook.com (2603:10b6:303:9b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Wed, 26 Mar
 2025 16:36:12 +0000
Received: from PH7PR11MB5820.namprd11.prod.outlook.com
 ([fe80::582f:ef5b:81c2:236e]) by PH7PR11MB5820.namprd11.prod.outlook.com
 ([fe80::582f:ef5b:81c2:236e%3]) with mapi id 15.20.8534.043; Wed, 26 Mar 2025
 16:36:12 +0000
From: "Grumbach, Emmanuel" <emmanuel.grumbach@intel.com>
To: "chris.bainbridge@gmail.com" <chris.bainbridge@gmail.com>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"kvalo@kernel.org" <kvalo@kernel.org>, "Korenblit, Miriam Rachel"
	<miriam.rachel.korenblit@intel.com>, "Berg, Johannes"
	<johannes.berg@intel.com>, "benjamin@sipsolutions.net"
	<benjamin@sipsolutions.net>, "regressions@lists.linux.dev"
	<regressions@lists.linux.dev>
Subject: Re: [REGRESSION] iwlwifi resume error, bisected
Thread-Topic: [REGRESSION] iwlwifi resume error, bisected
Thread-Index: AQHbASid0CU63h7wCU2RsueU4ZEG+rJMpxoAgAAufYCAA+5CgIAAEYCAgTXmVgCAABwWAA==
Date: Wed, 26 Mar 2025 16:36:12 +0000
Message-ID: <b2674ab2706c2ed81734f2c3d6261511414186bc.camel@intel.com>
References: <CAP-bSRbMbZe9LCE15SCbYNTGZjE_xiAm29qzO_WNVjHsJ6oyyg@mail.gmail.com>
	 <9ada34661b93fa5dfe3b0c66816a62c1a27f22a3.camel@intel.com>
	 <CAP-bSRZm4CyxY1VdtWvZRcfLMwc3njd3OTSd446Q5dcSfjJY=Q@mail.gmail.com>
	 <CAP-bSRbon4O=DCLHvOZHm452Svc3-gsZ133Jn7-TFt8f_Y1CFA@mail.gmail.com>
	 <36b0f88ff0f17e0246037d5f834ac545afa69cf0.camel@intel.com>
	 <CAP-bSRb_f1A=_+A9x8J75socYsKFKDtysZ-m0+6Ks7NdSjQ0-Q@mail.gmail.com>
In-Reply-To: <CAP-bSRb_f1A=_+A9x8J75socYsKFKDtysZ-m0+6Ks7NdSjQ0-Q@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.54.3 (3.54.3-1.fc41) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB5820:EE_|CO1PR11MB4883:EE_
x-ms-office365-filtering-correlation-id: 1103d8c5-1965-42e8-7f6d-08dd6c8451e1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?UTBIV05CYWp3VHF5cGZ0QWgwNUpVaHJORlFZNGFhZEZiUmdyMDhtN1VxemRu?=
 =?utf-8?B?YUluRUFJd0FrQzJMZjN1OVhaN2FkcS93YmxCSW1uV2VJUEQvOWtvZGkrTEVt?=
 =?utf-8?B?cFpaRTR5cmlMVzA3eXNVT21aSWpCZW5sam1tQ2NvUHR0MzVTUkFycnRRM2d0?=
 =?utf-8?B?Q2h3eEw4V3BCZXRDVU5mN25jb3NmTVRMNWp1NlE4dWl4VnVFdjhDblRxcXpq?=
 =?utf-8?B?TFlUbTZGOTdjc0N4SG9Sa09vRnVYQ0RLWWpGTmNxSGhmV1EwNlpzNU5ZTU9Z?=
 =?utf-8?B?YU1rb0hudzNmYTg1R0NTRXpZVFRzQ01xMllicG1zZVkramgzcUE2N2xJQVkr?=
 =?utf-8?B?aXl6eGI2SDRrVzRsV3RHZUg3RE1uR05qU0VCUkZFOTJHaG9EZzV5MVkxdHNY?=
 =?utf-8?B?MmVLVmNGVGFRbFJ0cTFFVHJGQTZVbVBkNDcycTNLQ0czTEpIMXJBUEF1eFMv?=
 =?utf-8?B?VG5mb0xYU2dXUHp3ZnVaUnd5azFOd1ducm9QclcrMFE0Tm9CekZXMzVZd1pz?=
 =?utf-8?B?OWpQZ05QZ0YwV2VlYzU1TEpnRVBiL0w2R2EvVmlLUGJ1dThMQ0RVeHdHUncv?=
 =?utf-8?B?YVcxSW9NZVNuYjBPWThnaDBjS3N3RThEa25PWkJteFdKRnRuMitFMGtZNGNw?=
 =?utf-8?B?WTJmVitlaUhseHluUlVCUEZaV2ZVWEdIRmo4TnBZTFMyUnk0SGhBaEtMU0pm?=
 =?utf-8?B?L3FxTFZFNHNXcDRFZGY2NjBvazV5em5lSVdtSVlSYUJIUlBWK0FZNmRNazBK?=
 =?utf-8?B?VkFBRlIxOGJlWUozVzZVbis4eHdwMSt2VkhOVlFxbXhldENCRnFjeVhPL2tk?=
 =?utf-8?B?SS8rdytpaGFkSk9GejE5TmgwQU9aQUdQRVcyNmRocm5ZTVkrSG9yT29paDdH?=
 =?utf-8?B?Sm5DcHQ0WllvQUpyTGUrU01HM0FSZ0FlLytscEN3QjBuNDNuLzJVYk9TWVRC?=
 =?utf-8?B?Q21yYk9vTW9BR0xRK0tMeHRUN3N4MVFZeDA1Mm9SeVk0SFNkWS9yaG1ZTXhF?=
 =?utf-8?B?emJZc2hwOWIyZ1BUY2JxRFIyRFlhVUI3QjRLeG91QmtmVVdzYkVmbkFwa2Ir?=
 =?utf-8?B?S29jSGRsQlpyREtIU0lMSlFLVWc1eGROMTJLVXFBa2tncEtWU3J3T2ZBM2VV?=
 =?utf-8?B?TFU3K21naFdVdVlFQ0RrN3Y5Zm4rMjJpeTN2QjNlNHE1Vk85S2VuWGYyYlU4?=
 =?utf-8?B?dWw3cktCYks3Y3RoN2J2OUtyUUQ5Y0NwMHErenYxQlE5bGNlQ3pPZXdKdG1h?=
 =?utf-8?B?bllMbGUvT1hOTGU1S01qZWhMb1lhSjhLaGd5cjQ4T3RoaGRidEs1R25Zam5B?=
 =?utf-8?B?U24xcFhUVVNZWUZoWXBLS04wQ3FqNE5sWW1SVVNXWVh1MU1vVWpIazNDOGp2?=
 =?utf-8?B?dnJFeTVUN29Pd0x3ZTFzRCtyRUdBOGtaektQRFJsYzJFTmJvRkJEYThaY1dC?=
 =?utf-8?B?WVluaTJCZWRMbHRqeGVNNnFSUDZBeVJQeUd6Q3ltR2JQVjlVdFl3bU5TYTky?=
 =?utf-8?B?KzBzb3ZWQ3E5VkpyVTNJbS8vNVJOdjArclhwV01VN09veXpyYzlhYVBDWkw4?=
 =?utf-8?B?MWlsd1ljVDgzS29tc2g5VmdWU2xEY3h6aXVpTzdUSnY1THFicHJoRURXd3pZ?=
 =?utf-8?B?S0NQc3p1WVBZZ2huemdqTzR0U2ZRTlVlbzBhK0NhNkFaWmlaRWx0cjI2SWFp?=
 =?utf-8?B?MnVZY3M5UGZRQW90ZEthVW55Y2NIN0pSUnE2WldsVVFOT2JrVnZidUNUVnJu?=
 =?utf-8?B?MGJTaWNiZG1uZ1Z5bGxEaDVhSG52TXZLT3BLZGlYMnRRekUvbHoxSmpVY2VP?=
 =?utf-8?B?V24rSngwMmJsU3NFK3pqaEZuOTlvZHJGTWNYNGlQa1BsbTFHRWx6NkhhRWQz?=
 =?utf-8?Q?0rMx2M7+2Gn1y?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eUs5Y2ZKaGw2WDJZNFhVZXEzSTNYL1RIU2tOUk11TzZLV3lybW1KVGJkY0lM?=
 =?utf-8?B?OXVjT0dKc1Z6eHZVcUVVTWlPMXg0eXptVHZ0K1ZpWm5HV1c4SVFOanUrL2Nk?=
 =?utf-8?B?THErK3FKdnZncHltMDZqWFo2ZUdZd2J3cmE4TXpLN3VuMkw5b0dEakMwYUZy?=
 =?utf-8?B?WWlHT082VFc0TnpwdlNxN2M2QkxteHRrOWtTbzZLbnY0OUVvRDE0VzZKc05C?=
 =?utf-8?B?LzgyMHdZTzgxdFlVNU5zdDJGOTRPaXZic2o5NlBmTG9JeE1SRldkZm93czRZ?=
 =?utf-8?B?Uno1VWFKQVVWdUhsN2h6UC94NWYwVTY3YnFWekdQcnJXTWxVZGNSVHZlZGg0?=
 =?utf-8?B?ZUJFZHZKT1VQOHA2UkR5L2R4ZUxQVHlsTE5vT3lQOTdtbDJ3Qk96K0U3Sllo?=
 =?utf-8?B?NWhOSWZlUHJEekc4RncxbVdZdEJCTDN6bS9IN1pLSE9lVXQ1UFcvb082QW13?=
 =?utf-8?B?SG14ZW4vNENobTNrVFl4SXZYWHRyM1RnNit6QVRuK0lUeGZnSEtIMloyRCt2?=
 =?utf-8?B?cmVxaGdMY0RxakdpcXppSENCRWY0UThkK2VlQ214TUNjeHNHblpLcis1c1FO?=
 =?utf-8?B?YzAvUlFCT3Qxc1VIL0xDR3JhL2c5c3lsaE1PVkdMN1hwaXYxa1NxWXBlOHhj?=
 =?utf-8?B?ak1mTkJPejhMaWppcFdacTYrQmxuS0JrelFkY3p1ZWRTQ21SdWdvUkszVVZl?=
 =?utf-8?B?YlFzZWo5cXc5dEhnVDNyYVZJT0JuUXEzaXJ5N0M4NDk2WFVwK044M0tMbmlI?=
 =?utf-8?B?OEVRM29Kc3hnMzliUFE1NXBoTzN4SExoRkhYTU12aVVidW84dXVGeTRiTlpD?=
 =?utf-8?B?NHJTTW1lSzh6UkEyaTNKVnlxUGplRFlHekcwdG1xQ25sOFlKcXAzdVZubDI3?=
 =?utf-8?B?SnlOdC9Kei9Qb3Bha1k5ZW5Hai9hVmdsYmp2aCtja0RucWhYQ0UybUVSVGJa?=
 =?utf-8?B?elVkTDIxdFpxbVZUWWVUb2twdVJKNVdDd1pVVkZEMEdCOWVOekhhbG9OYzVV?=
 =?utf-8?B?amM0UXBsRDVxY25aUjMzQWMrdmFkaEVrd0dGSktBUktFK1RqU2J0bi9OTmQv?=
 =?utf-8?B?WjcxRzRQZnd5OWh4T0kxcVBndnl4OXUreElPenFmOG9QbUtBb0N2RkwzN1R4?=
 =?utf-8?B?SjdOQUxwRzJGQm5UU1B2RmsyVjE1eVNMeU1RMVV5UnJnREQzYXNEWlIwV0pk?=
 =?utf-8?B?NVdTdUxVbmh0ZEd3UFlWSDl1Nzg1K2ZyY0FRSHBpUlV1SW5SWkowOEFEVkhZ?=
 =?utf-8?B?eVgvWGlXTmZqU3Bma2pzZnFIYW5WeThOMmRtK3hBd2JHZnZ1Vjd2NTRnRE9W?=
 =?utf-8?B?dGhZVGdjeXlxaG1Rck1sekU2MDRpZkRVQkxqSmlNeFo0dWhvMGIvaWVOQUtM?=
 =?utf-8?B?TU00SVNTbTdTa3dBZmk5dFNtRS9XNEhaQmRDZm5sUFBEZVM5dEorT3g5eC80?=
 =?utf-8?B?UFI4RjVKMjNYemRZcGcrUG9XelQ4bVA1YmR2U0puT08zblZ6RnIyNTNHZnR2?=
 =?utf-8?B?RVFnbWc1c3o4d05mQys5SEthZ0lnV3VPS0VRckpXZzdsNEJSQ01uT0xRSmN3?=
 =?utf-8?B?blNlQVBBRkNPd0hVcVkzcFJ2TzZ2bVBJNWp3ZGh2Q1cyMENtalFra25vY2hD?=
 =?utf-8?B?ZXIrUkhRZkV0VkZBcUVkbi9lb3FJd3dmbGpuN0t6Mk5zWDBvRUJkRXhUUmNP?=
 =?utf-8?B?MG5lRnh5VUwzRU5vUGxtLzNReTRNWGViNk50MmpEY2IwT3V1QmUwNmdpeFVF?=
 =?utf-8?B?UlV5WG9kUm9PSjJ2eEt4MHE2QklFRUZuUGxnRUxNUUR4bmRnSzlKa1YrRWF2?=
 =?utf-8?B?eUoxT2EvNmNnVWM1dUxrMmMwbE9JWXVRNDNEeFV2ZHQzWGFEaEJNd0N0dDQ2?=
 =?utf-8?B?N3FtcG5JVzVKWUJDSDdRRGROQmJuSUllT081OUt3bk52SmFoNEsrTWF2OEFS?=
 =?utf-8?B?NHdHazhYRGdGY05LL0hvN2NKa21SSTRNendrSStxSTBYMExpTW9WMXBsRGI1?=
 =?utf-8?B?a1VlREJINmRqL2xBcVF3S0xzOEQwaVNRbU1UVzlvSzFvRjdqaDZKajluL0NY?=
 =?utf-8?B?OGJYVzh6VU16elB5WFFzTUlkVXNZOWFrTVhFT0ZNSTEwUUt6WlZ2Z1lsL0dq?=
 =?utf-8?B?SnBobmZoRFlFYUtLNy9SQlJZRTR1ZzE4TTkyTVcrMCs3NEJDajYzOUxPTm5n?=
 =?utf-8?Q?ZwvdGumSrpRD7RgcAoJRM4U=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <57AFFDB18C18214FA91BE6B72B2C518E@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1103d8c5-1965-42e8-7f6d-08dd6c8451e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2025 16:36:12.1132
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xu0Houiy9gsxUZyshaf9st1VuNF90hoH7tnSEl4bW2NQSIOIlGdGF2jMIisr4fmcP5XNBV42+rv6c8j37zYP0lj+q9UN6kZw4mzqIuesCco=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4883
X-OriginatorOrg: intel.com

T24gV2VkLCAyMDI1LTAzLTI2IGF0IDE0OjU0ICswMDAwLCBDaHJpcyBCYWluYnJpZGdlIHdyb3Rl
Og0KPiBPbiBUdWUsIDEwIFNlcHQgMjAyNCBhdCAxMToyNiwgR3J1bWJhY2gsIEVtbWFudWVsDQo+
IDxlbW1hbnVlbC5ncnVtYmFjaEBpbnRlbC5jb20+IHdyb3RlOg0KPiA+IA0KPiA+IE9uIFR1ZSwg
MjAyNC0wOS0xMCBhdCAxMDoyMyArMDEwMCwgQ2hyaXMgQmFpbmJyaWRnZSB3cm90ZToNCj4gPiA+
IE9uIFNhdCwgNyBTZXB0IDIwMjQgYXQgMjI6MjEsIENocmlzIEJhaW5icmlkZ2UNCj4gPiA+IDxj
aHJpcy5iYWluYnJpZGdlQGdtYWlsLmNvbT4gd3JvdGU6DQo+ID4gPiA+IA0KPiA+ID4gPiBJdCdz
IHBvc3NpYmxlIHRoYXQgdGhlDQo+ID4gPiA+IEhQIEJJT1MgdHVybnMgb2ZmIHRoZSB3aWZpIHdo
ZW4gc3VzcGVuZGVkIG9uIGJhdHRlcnkgcG93ZXINCj4gPiA+IA0KPiA+ID4gVGhpcyBpcyBub3Qg
dGhlIGNhc2UuIFN1c3BlbmRpbmcgd2hpbGUgb24gYmF0dGVyeSBwb3dlciBhbmQgdGhlbg0KPiA+
ID4gcmVzdW1pbmcgKHN0aWxsIG9uIGJhdHRlcnkgcG93ZXIpIHdvcmtzIHdpdGhvdXQgZXJyb3Iu
DQo+ID4gPiANCj4gPiA+IElmIHRoZSBsYXB0b3AgaXMgZG9ja2VkLCBhbmQgcG93ZXJlZCB2aWEg
Ym90aCB0aGUgZG9jayBVU0ItQw0KPiA+ID4gKmFuZCogYQ0KPiA+ID4gbWFpbnMgUFNVIG9uIHRo
ZSBzZXBhcmF0ZSBQU1UgY29ubmVjdG9yLCB0aGVuIHN1c3BlbmRlZCwgdGhlbg0KPiA+ID4gZWl0
aGVyDQo+ID4gPiB0aGUgZG9jayBvciB0aGUgUFNVIGFyZSBkaXNjb25uZWN0ZWQsIHRoZW4gdGhl
IGVycm9yIGhhcHBlbnMgb24NCj4gPiA+IHJlc3VtZSwgZXZlbiB0aG91Z2ggdGhlIGxhcHRvcCBp
cyBjb250aW51b3VzbHkgbWFpbnMgcG93ZXJlZCB2aWENCj4gPiA+IHRoZQ0KPiA+ID4gb3RoZXIg
cG93ZXIgc3VwcGx5LiBJdCBhcHBlYXJzIHRoZXJlJ3Mgc29tZXRoaW5nIGFib3V0IGEgcG93ZXJl
ZA0KPiA+ID4gZG9jay9QU1UgdW5wbHVnIGV2ZW50IHdoaWxlIHN1c3BlbmRlZCB0aGF0IGNhdXNl
cyB0aGUgZXJyb3IsIGFzDQo+ID4gPiBvcHBvc2VkIHRvIGp1c3QgYmVpbmcgc3VzcGVuZGVkIHdo
aWxlIHJ1bm5pbmcgb24gYmF0dGVyeS4NCj4gPiANCj4gPiBPay4uIHNvIHRoYXQncyByZWFsbHkg
cG9pbnRpbmcgaW4gdGhlIGRpcmVjdGlvbiBvZiB0aGUgQklPUyBvciB0aGUNCj4gPiBzeXN0ZW0n
cyBmaXJtd2FyZS4gU3VyZSB3ZSBtYWRlIGENCj4gPiBjaGFuZ2UgaW4gdGhlIGRyaXZlciB0aGF0
IGlzIG5vdyBzZW5zaXRpdmUgdG8gdGhhdCBwcm9ibGVtIHNvIGl0DQo+ID4gcG9wcyB1cC4NCj4g
PiBTaW5jZSB3aWZpIGlzIGF2YWlsYWJsZSBmb3IgeW91IGFmdGVyIHJlc3VtZSwgSSB0aGluayBp
dCdzIGJldHRlcg0KPiA+IG5vdCB0byBmaXggdGhhdCBmb3IgdGhlIGNvbWluZw0KPiA+IHJlbGVh
c2Ugd2hpY2ggaXMgYWxtb3N0IG91dC4gSSdsbCBmdW5uZWwgdGhlIGZpeCBwYXRjaCBJIHNlbnQN
Cj4gPiB0aHJvdWdoIHRoZSByZWd1bGFyIGNoYW5uZWwgYnV0IHlvdSdsbA0KPiA+IHNlZSBlcnJv
cnMgZXZlbiB3aXRoIHRoYXQgcGF0Y2guDQo+IA0KPiBXYXMgdGhpcyBldmVyIGZpeGVkPyBJIHNl
ZSB0aGVyZSB3YXMgc29tZSBraW5kIG9mIGZpeCB0aGF0IHdhcyBwaWNrZWQNCj4gdXAgYnkgcmVn
emJvdCBidXQgaXQgbG9va3MgbGlrZSBpdCB3YXMgZm9yIGEgZGlmZmVyZW50IGlzc3VlIGNhdXNl
ZA0KPiBieQ0KPiB0aGUgc2FtZSBvcmlnaW5hbCBjb21taXQuIEknbSBub3cgb24gYSBkaWZmZXJl
bnQgbGFwdG9wLCBhbmQgaGl0dGluZw0KPiB0aGUgIlRpbWVvdXQgd2FpdGluZyBmb3IgaGFyZHdh
cmUgYWNjZXNzIChDU1JfR1BfQ05UUkwgMHgwODA0MDAwOCkNCj4gLi4uDQo+IGl3bF9tdm1fY2hl
Y2tfcnRfc3RhdHVzIGZhaWxlZCwgZGV2aWNlIGlzIGdvbmUgZHVyaW5nIHN1c3BlbmQiIGVycm9y
DQo+IG9uIGV2ZXJ5IHN1c3BlbmQvcmVzdW1lIGN5Y2xlIChldmVuIGlmIGxhcHRvcCByZW1haW5z
IHBsdWdnZWQgaW4NCj4gd2hpbGUNCj4gc3VzcGVuZGVkKS4gSSBzZWUgaXQncyBhbHNvIGJlZW4g
cmVwb3J0ZWQgZWxzZXdoZXJlIHRvbywgZS5nLg0KPiBodHRwczovL3d3dy5yZWRkaXQuY29tL3Iv
ZGViaWFuL2NvbW1lbnRzLzFnN3lvb2svaXdsd2lmaV9jcmFzaGVzX2FmdGVyX3Jlc3VtZV9mcm9t
X3MzX3NsZWVwX29uLw0KPiANCj4gSSBrbm93IHRoZSB3aWZpIGlzIHN0aWxsIGZ1bmN0aW9uYWwg
YWZ0ZXIgdGhlIGVycm9yLCBidXQgc3BhbW1pbmcgdGhlDQo+IGtlcm5lbCBsb2cgd2l0aCBhIHN0
YWNrIHRyYWNlIGFuZCByZWdpc3RlciBkdW1wIHNlZW1zIGV4Y2Vzc2l2ZSBnaXZlbg0KPiB0aGF0
IHRoZSBCSU9TIHR1cm5pbmcgb2ZmIHBvd2VyIHRvIHRoZSB3aWZpIHdoZW4gc3VzcGVuZGVkIHNl
ZW1zDQo+IHJlYXNvbmFibHkgY29tbW9uLg0KDQpXZSBoYXZlIGFsbCB0aGUgZml4ZXMgbm93IGlu
IDYuMTMuNy4NCklmIHlvdSBzdGlsbCBoYXZlIGlzc3VlcyB0aGVyZSwgcGxlYXNlIHJlcG9ydCBi
YWNrIGFuZCBJJ2xsIHRyeSB0byBmaW5kDQpzb21lIHRpbWUgdG8gY3JhZnQgc29tZXRoaW5nLg0K

