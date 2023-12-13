Return-Path: <linux-wireless+bounces-735-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 36AB381108B
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Dec 2023 12:52:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7388C1C2099C
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Dec 2023 11:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 451D125568;
	Wed, 13 Dec 2023 11:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F/RJEoCs"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71E4AB0
	for <linux-wireless@vger.kernel.org>; Wed, 13 Dec 2023 03:52:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702468360; x=1734004360;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=uaQMdUZabwCFs2AryhbAYeufj+XppNT/NhwHLeWU4CI=;
  b=F/RJEoCs2DvYUj3hEf3jQSYtoM6xemaq6RssHtA8znrAjJ62eRBrabqm
   FScpJpxIJBrjV3KSBDRC3GtjPnfUDT24BD/uX6z5XsaUow6z1ZSGyZWYs
   7Dyw7IxuBBiB0/ynXYQWgerhBFmGbj4wkGJ8zsVUbRTpyQtrNn/0P43yd
   gPPeazVyzmSUTtvx4CCsIvif/6CbdTP1agRvXCT3KcndTlcaKSOeAYy2r
   1E0wwTgI0kg3EHVunVngt5lkA3v8zxPVaSnevMJcZ4psiDAzUYtX6WF7l
   Ebul+4b+LYaK27AjAbRjZ8RcY2E2C7fL26dJRvEXHl08PXM2rBYKMpKd7
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="385372717"
X-IronPort-AV: E=Sophos;i="6.04,272,1695711600"; 
   d="scan'208";a="385372717"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 03:52:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="917633835"
X-IronPort-AV: E=Sophos;i="6.04,272,1695711600"; 
   d="scan'208";a="917633835"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Dec 2023 03:52:39 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 13 Dec 2023 03:52:39 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 13 Dec 2023 03:52:39 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 13 Dec 2023 03:52:38 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BjdOty9Yzhh8oEDOd3vYZmb+N71jG/GsnR+eOF0k3B2gZxeeafQQPm7EDaqelN65miZPEM7PMOwur6dgZfvM8gW3gPWCk9H49nmnBIpG+mc5iA4U9+8qmIQQ50CoEDAY737SJvb40+H7ajbWNbpNqzE6XKB2rP3SyPamgLeiTSRvsnXpqEv1Lqac1GvlXfX+2r1XCby91y8WDd0cp1EJpc1uDP0rzinuro541fW0NRq2SGV3LLY0MTGtqFqELBohuAKnHeJTWzS5XCQR49EHQcoQZmf4SW0fmWT6SKbUlXiH6/ov+OX/LjfURpMR+4wqJPceALLOarSL1wVtOmUHnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uaQMdUZabwCFs2AryhbAYeufj+XppNT/NhwHLeWU4CI=;
 b=HZn7CCvKrSXubvoE4+HlWksvq1BZRsRrhqCZNvVCKKgVamQ4x1dGv2hRo8L2YwGDf5pd/Wy6XdQVYcPq4JU2SNKx0GJEQdeSuH4Yx5fsBvC8RlXfAZAC4whs6EGISBZO/Ov1pWD7ifO3IotGuEAtuLfN8hJbnnn0YzJ7HU6meewPQ/cM8r11bODIuLZD7ScK5EwVqCL+gweh4r/9xSQ7Q4duBetEV/sTuBkaQQI945Gl0o+0X0cV5d1yCKZts6Pt4OD67gR87+xnJfi30bRAGVGAIjjSfDz8nNKBympL9bvyvt30FNZO1UKlqTZFYtTK9j7noi8p7JiXR47iXremHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM4PR11MB6043.namprd11.prod.outlook.com (2603:10b6:8:62::8) by
 PH0PR11MB7523.namprd11.prod.outlook.com (2603:10b6:510:280::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Wed, 13 Dec
 2023 11:52:31 +0000
Received: from DM4PR11MB6043.namprd11.prod.outlook.com
 ([fe80::4f50:37e1:d19:cc36]) by DM4PR11MB6043.namprd11.prod.outlook.com
 ([fe80::4f50:37e1:d19:cc36%3]) with mapi id 15.20.7091.022; Wed, 13 Dec 2023
 11:52:31 +0000
From: "Peer, Ilan" <ilan.peer@intel.com>
To: Johannes Berg <johannes@sipsolutions.net>, "Korenblit, Miriam Rachel"
	<miriam.rachel.korenblit@intel.com>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"Greenman, Gregory" <gregory.greenman@intel.com>, Jouni Malinen <j@w1.fi>
Subject: RE: [PATCH 06/14] wifi: cfg80211: Update the default DSCP-to-UP
 mapping
Thread-Topic: [PATCH 06/14] wifi: cfg80211: Update the default DSCP-to-UP
 mapping
Thread-Index: AQHaK2mRrxuL2hBpb0mDmxS+sJxsd7ClZ2aAgAG3OyA=
Date: Wed, 13 Dec 2023 11:52:31 +0000
Message-ID: <DM4PR11MB6043807D61F27FAF100EA43BE98DA@DM4PR11MB6043.namprd11.prod.outlook.com>
References: <20231211070532.2458539-1-miriam.rachel.korenblit@intel.com>
	 <20231211085121.8a1c7d1f0034.I50aed38be78ae9aea052938e2cb6b5800010ecd4@changeid>
 <71ab1f7295860699713a018c69503f63d903a0be.camel@sipsolutions.net>
In-Reply-To: <71ab1f7295860699713a018c69503f63d903a0be.camel@sipsolutions.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR11MB6043:EE_|PH0PR11MB7523:EE_
x-ms-office365-filtering-correlation-id: 958e4b86-464b-4e70-832b-08dbfbd1fd28
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +1rxYGZHavLBf9P7Bdz1eM5QQjgxxhEui6pXifotB/02tkEDZ+Z+gB4dmgshC6KHFIi9/udHvXJ+bl656ZBJDuTsjn+W1u2tuFgN1lHtrWQ14i0tvsFi0rRfy+7J1uCiYaHOzUuUVJLdNWc4xBWHPtk625OiK5MoF92qH9flFnMnHGV4XpQ6kidsPM9R8qGxSsxBJGpYuIu48IL81oBwXbf6f75BU5YadIvDf71Kz3BAxeJQHyB4lE5+b/ym5M7bzq67itjJ/oe8bTmQMXGqtUKtG2pNqbhMqQzW1J1B/pbn9Vt9UHPmwtqEJ4sj87s71qqfFCu5sVCI8udgwIHOu6UWHj2UeLjnJVpWct/3hzUIZWnx2oBLMQyBH5kdYYUWpQmFUg3uXtO+OejsEIrNGGqMu8jt9SK7BBtRl44kGV86iOkCnZlGUmUT9qAlOQBisW6HFEyoS7elLYI4AZCI0eA71pWdHFsOww5a7kFoq1KKNBwBWQzIJkkOdnTAqDtX2RYQHx2y3J9mUCj4mgka9xxBUjuPCeNsobjg+jIvQ8mBOjoZT7WBXn1pOsTo0S+7cOfEVbLSApRDfG3HLvViWUG4n/iMp0LCXHRpb1iPuXE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6043.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(346002)(396003)(39860400002)(366004)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(26005)(83380400001)(82960400001)(38070700009)(41300700001)(33656002)(38100700002)(122000001)(5660300002)(8676002)(316002)(15650500001)(4326008)(8936002)(54906003)(4744005)(2906002)(86362001)(6506007)(53546011)(71200400001)(9686003)(6636002)(66476007)(66946007)(110136005)(64756008)(7696005)(52536014)(66446008)(66556008)(478600001)(966005)(76116006)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QzNEQndOQjd3RWxsekJLbytZWUIwdkVzNDRVMG5JeHRGM0VuR2NJYVV5Zklp?=
 =?utf-8?B?SUhBRy93dFBnbEpRcE0wQUZzZnN4MVJoT2xKczBLNmEwd0V4ajRxWldIQXhq?=
 =?utf-8?B?Y0ZFR1drUy9KNmE0NG9ORTlTazlzLytyVHdrNVhxZmRrZzZnaEl4S1hDTmtC?=
 =?utf-8?B?Ump6S0FwNlFQOE9lZkVZMGh1UEwxVCtOU21hbzNzWUJ5ZGxVdmhNbEY2MjM1?=
 =?utf-8?B?MHhqV2RyTEdXT1lMbGtGVUxlTTByVWhYeGowOU0rbzZreVpDQzBjazNvcm82?=
 =?utf-8?B?bmpnM3hJbEFka2lRdEhKSHRubDBXWS9KZVB2SjkwOTNLby95VEVRaktPK1RK?=
 =?utf-8?B?Rzh3TU9QZGYvWVRSNGZFTzlUNitaVTJ6VW1mNXZaa1JTZ2JZWmxOSmJPSXBT?=
 =?utf-8?B?YWhXT2hPUHlCeXJFWlIwWXhZanlmV2hqM1VLTVJQN2lMUjYraGtMZVZGYmFM?=
 =?utf-8?B?NWJjQndCRllxbHpzUzJCV01jejgrOGJlUURyQ2NvNENMTXovUCtvMjNaUHJW?=
 =?utf-8?B?MUtuaVFhbE9aK0lYL0xkaTZVdkF0SFFuS3BUaS9oSFMyaFAzUzdnR21pODl2?=
 =?utf-8?B?eDhMb28vTkNVU2FPWGpBYmRFdjQ2Nk9LZk5CQjMzOEswRkovWXk5dEhQSWQv?=
 =?utf-8?B?UlVzeEpreUVrODBUeTNOL0hOVjZkQnM1OFRXSll2ZDJqaFJtbFJUTXBUelJP?=
 =?utf-8?B?RkRmS3YyUUg3U0ZvRHhMMzlnY0x0L2lreTVEd2p3aFFWUkRDcEYxUks1WkNz?=
 =?utf-8?B?OVl3NXMxdnJQL2JDSC9uU3JkS0w4QmRubDNFVjFSYzlmZmxzSWhMT1NmVkVV?=
 =?utf-8?B?azR5d1Vwb1F5QjE2dDJHYS9XU0x4bVpERkpkd0wxRmIzM0p6THQxWE9BSDNY?=
 =?utf-8?B?K1JMTEx2cUlNbjBwUEV1UTRFVDM5T1FVejNoSzc3ZGwwQS9CM29TcU82dVhQ?=
 =?utf-8?B?R09ianhJL3JwUWkzNmlSTlhLQ0JYN2tZdXlCcFpkM2wxdmZkb1BHSTRQeDJz?=
 =?utf-8?B?eWxueGg4eUU5eXpxOURLa0xRWk12VDczcUF5aXo4d0dBR1VrWTE2cXk5a2Rp?=
 =?utf-8?B?dE0zVUxSK1d3dW9TVU5mcld3emVNWitWNHROWU8xMVh5M0M4cXR4L2ZjMEdt?=
 =?utf-8?B?VTVlV0N6ZUdoMDlsR29EVG9aL2ZXVjZES1FNTldsMHRmNFpIQUgzbk5uSVgr?=
 =?utf-8?B?WkQxS3pKUzYzN05NWjlsYXFEZXZ1WmtKVWNXdlNXOVNKZiswWDQxekFnN2ls?=
 =?utf-8?B?ZnN4c0N4TUZQN053eEh0am5URDRJY1R5Mk1zZnpLV09mb2dXWTRPbzdaRzly?=
 =?utf-8?B?NGkyeE96NWdzNDI0QW14OTdqNGRrS0xKZHlOOEhCNmRrK0Y2Mml1ZkdwcWt3?=
 =?utf-8?B?cG9EdXU0Z0l4VVpFVFI3OVFoaG5GRjFTRWdSRWxwMzdYck5YcVpncHJ0VlVq?=
 =?utf-8?B?Uk9tUHF1UEZ4a3VSTVNTWU9jY1BNWnd2Sk1RU0x0R1RoeG8xUWhoQjY3a0Q5?=
 =?utf-8?B?a1N5cWtnOGlMUUhZclZjSDY1cVNkWGNieDM2OXpLUGVGUFpST1ZVYmhuTXcv?=
 =?utf-8?B?QTBWSWNpQkVJcGU1aU5SR0dwTEZpeEp0b0JIVHpNc1luT29MNjdzMzJ5NGQ3?=
 =?utf-8?B?ZXRUdmlpMlI3MXp5Wm9JcHFoU2hOREUzUnI3cjh4ajZtczlRdFRTOHJMQ2ZU?=
 =?utf-8?B?c0d0K0tpV2hPRXlnZEhDSjVZdDljVVZpS3FxSlQzdGtaOWU0Wm0wSEI1OHp2?=
 =?utf-8?B?N2I0OGlVRWFJMEVrU1RMSlFjTzFwQXBqYkVPZ0dJWndiZmpGTEhYLzZWcjNy?=
 =?utf-8?B?VFZzMkhRSDRTSkJQUFM2anhYbUlpYXNDN1A0TnVSK3V3SEN3bFJENmg5UkJ0?=
 =?utf-8?B?cWJNQzh4Y21GNmFLWTRKdW1CUnpuN1ZCdHhOZnJmUytWcXR1Z1RWa2VjcGFr?=
 =?utf-8?B?RW1QUjhLWmJZc2FCM2plRkU1eHJjVzNVUlFhMlZHRmYyUlgwOU05L0VvNG5T?=
 =?utf-8?B?NXBZU1NsdnJvb1FkdmpEYklXNlUxaENkUnAzZzkwTmJ4YkQrT3NxbU9ZRG9J?=
 =?utf-8?B?d21XQlF1NExrUGVnVzE3Ny9hSVRMMUNCa2dXbzVCaUNyZCtZWUdlcitwUXZG?=
 =?utf-8?Q?ba6KPYiFnZa1dofIyC9q7SaLN?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6043.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 958e4b86-464b-4e70-832b-08dbfbd1fd28
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2023 11:52:31.6721
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nPvjB+DckiaPnXYhTqLQZXJeudVlcnNfaIBf5o+W57fOt5QhqW3SRSPq2ozcTaUiEX/oWqy5U/fYYpyZkvvA5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7523
X-OriginatorOrg: intel.com

SGksDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSm9oYW5uZXMgQmVy
ZyA8am9oYW5uZXNAc2lwc29sdXRpb25zLm5ldD4NCj4gU2VudDogVHVlc2RheSwgRGVjZW1iZXIg
MTIsIDIwMjMgMTE6NDANCj4gVG86IEtvcmVuYmxpdCwgTWlyaWFtIFJhY2hlbCA8bWlyaWFtLnJh
Y2hlbC5rb3JlbmJsaXRAaW50ZWwuY29tPg0KPiBDYzogbGludXgtd2lyZWxlc3NAdmdlci5rZXJu
ZWwub3JnOyBQZWVyLCBJbGFuIDxpbGFuLnBlZXJAaW50ZWwuY29tPjsNCj4gR3JlZW5tYW4sIEdy
ZWdvcnkgPGdyZWdvcnkuZ3JlZW5tYW5AaW50ZWwuY29tPjsgSm91bmkgTWFsaW5lbiA8akB3MS5m
aT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCAwNi8xNF0gd2lmaTogY2ZnODAyMTE6IFVwZGF0ZSB0
aGUgZGVmYXVsdCBEU0NQLXRvLVVQDQo+IG1hcHBpbmcNCj4gDQo+ID4NCj4gPiBUaGUgZGVmYXVs
dCBEU0NQLXRvLVVQIG1hcHBpbmcgbWV0aG9kIGRlZmluZWQgaW4gUkZDODMyNSBhcHBsaWVkIHRv
DQo+ID4gcGFja2V0cyBtYXJrZWQgcGVyIHJlY29tbWVuZGF0aW9ucyBpbiBSRkM0NTk0IGFuZCBk
ZXN0aW5lZCB0byA4MDIuMTENCj4gPiBXTEFOIGNsaWVudHMgd2lsbCB5aWVsZCBhIG51bWJlciBv
ZiBpbmNvbnNpc3RlbnQgUW9TIG1hcHBpbmdzLg0KPiA+DQo+ID4gVG8gaGFuZGxlIHRoaXMsIG1v
ZGlmeSB0aGUgbWFwcGluZyBvZiBzcGVjaWZpYyBEU0NQIHZhbHVlcyBmb3Igd2hpY2gNCj4gPiB0
aGUgZGVmYXVsdCBtYXBwaW5nIHdpbGwgY3JlYXRlIGluY29uc2lzdGVuY2llcywgYmFzZWQgb24g
dGhlDQo+ID4gcmVjb21tZW5kYXRpb25zIGluIHNlY3Rpb24gNCBpbiBSRkM4MzI1Lg0KPiA+DQo+
IA0KPiBUaGlzIGJyZWFrcyBhcF9xb3NtYXBfZGVmYXVsdF9hY20gYXBfcW9zbWFwX2RlZmF1bHQg
dGVzdCBjYXNlcy4NCj4gDQo+IEhvdyBzaG91bGQgd2UgaGFuZGxlIHRoYXQ/DQoNCkNvcnJlc3Bv
bmRpbmcgY2hhbmdlIGZvciBob3N0YXA6ICBodHRwczovL3BhdGNod29yay5vemxhYnMub3JnL3By
b2plY3QvaG9zdGFwL3BhdGNoLzIwMjMxMjEzMTEzNzM1LjI4OTQwOC0xLWFuZHJlaS5vdGNoZXJl
dGlhbnNraUBpbnRlbC5jb20vLg0KDQpSZWdhcmRzLA0KDQpJbGFuLg0K

