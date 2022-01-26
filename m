Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C1E149C415
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Jan 2022 08:12:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237651AbiAZHMw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 26 Jan 2022 02:12:52 -0500
Received: from mga17.intel.com ([192.55.52.151]:36267 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237642AbiAZHMu (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 26 Jan 2022 02:12:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643181170; x=1674717170;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Ow0941+cj0tsEupEvuNV4gebExzEBy20A2SjFXbTib8=;
  b=FTh4hJZeCUIwOZDwb0d60dmbsbDUm7HUUIjk+iVP12/a1y8TinshiUqG
   d06h2VsL2ywOLkfbzOC0y89CyDLi6qGXlPNjhlKESEK2fLoEtsu+n7At3
   po97NGPY6vRrapX1HV+CY5IcrSz+9RayjEVWVY7aOrxktTMj0OVmF514a
   MJ2x9AbQDxVEr4M4yzeCPm2yQ5lrpsp+NYwbICApalUGhju6TG3n1y3DK
   o0nfM4rKeDYlXsF7rIbIQ+Wr2NLzRmjexhLmmASeSXPRWDEyGC3h8/Ihx
   t8LkQ9Peh52FVSINJWgNli+pGOq03LdXAPJ1KLQluAXY6y/4ZaPZEERM3
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10238"; a="227168579"
X-IronPort-AV: E=Sophos;i="5.88,317,1635231600"; 
   d="scan'208";a="227168579"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2022 23:12:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,317,1635231600"; 
   d="scan'208";a="628218186"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
  by orsmga004.jf.intel.com with ESMTP; 25 Jan 2022 23:12:50 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 25 Jan 2022 23:12:49 -0800
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 25 Jan 2022 23:12:49 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Tue, 25 Jan 2022 23:12:49 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.170)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Tue, 25 Jan 2022 23:12:48 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i7rZly7TIEvwVUilb1qbOtHMlvJZu71O626xJ4IOM9cMSGDCnMzdaTwbdygqt3aJqP+8kpqMqd+K2Symh5fy6OP5l/XfFOfVsYmg3w5z3iy8+X5UuMAxAFlm8yFJVisPBJ389Ab46Q4Yl9HT9ZqpdeuftHxXMAJAgPizl+XaMR5ZgD4wmUqb6pK7ccVzvkpstqHGVH3XWia1/V66Ym1kFQbS3n4IopRCaRvYKO+Ix9I9EmAD18NSW+0Flr+sxm3FkTogJW1c1vqFmCbNv8CH/LL3qlObGmmGXmyJoOHeB/6+rEbI8PWdcobiILidwd2quyCa0Kay/tJXSVEaFBJvsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ow0941+cj0tsEupEvuNV4gebExzEBy20A2SjFXbTib8=;
 b=gZANO+ECG1y/bS/i9WWMGmB87pmGeMONhC8UgBb/uNTccjlEtrnmqL2WP1pb5mSwWLXVRD+4ZvQR42uuBo9zMclanOpY3zqgtSL1+h67pg7XNX1HkHKT3T4MMP5mnhRs6fNlfy/Ga9NlJKR01BgJEYS3lFdvOD4eJkb7zMDlyFP4RfivpOWwZ7YfJgIhgUg/fobJV6SgaTiXD/hWGIWiba4JuLEu26xlunNw9xZn9hsMu+GTYVLq5nC/LoPr2bCANzBBOhI4AlqJ0dR1bX9vtXdIlxZRzwvsrU6s6tOn1k8vl+Oey7UV+q/r0W8LYEFZiwliPKMUI3LbURcgqO50Kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from BYAPR11MB3207.namprd11.prod.outlook.com (2603:10b6:a03:7c::14)
 by SN6PR11MB2895.namprd11.prod.outlook.com (2603:10b6:805:cd::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.7; Wed, 26 Jan
 2022 07:12:47 +0000
Received: from BYAPR11MB3207.namprd11.prod.outlook.com
 ([fe80::9977:f8a0:e268:24f5]) by BYAPR11MB3207.namprd11.prod.outlook.com
 ([fe80::9977:f8a0:e268:24f5%5]) with mapi id 15.20.4909.017; Wed, 26 Jan 2022
 07:12:47 +0000
From:   "Coelho, Luciano" <luciano.coelho@intel.com>
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        greearb <greearb@candelatech.com>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>
CC:     "Ben Ami, Golan" <golan.ben.ami@intel.com>
Subject: Re: iwlwifi problems, maybe firmware related?
Thread-Topic: iwlwifi problems, maybe firmware related?
Thread-Index: AQHYEkCI4ctfUOxXUU6iV5VLFX3SGKx0ammAgAAnxgCAAFGLgA==
Date:   Wed, 26 Jan 2022 07:12:47 +0000
Message-ID: <cb3e4991c19659ab73cc0d9c12e8b7dbba9d652d.camel@intel.com>
References: <92b00b94-aff6-8108-06d1-932b77f9d218@infradead.org>
         <04761964-e3b3-b2f7-78a4-bbc3507ad676@candelatech.com>
         <0ee64c55-1326-addb-7c9c-c922373f78c0@infradead.org>
In-Reply-To: <0ee64c55-1326-addb-7c9c-c922373f78c0@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.42.3-1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a317f056-0191-438e-cddc-08d9e09b419f
x-ms-traffictypediagnostic: SN6PR11MB2895:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <SN6PR11MB2895548C886E3DFDF6670BA790209@SN6PR11MB2895.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IXutVAild5G8upOQ36EItnWvqm7oEknMHUI8dnFP597GMWrre+0mh7UoX7FItYIIen+5zgZ6o+Q3F8c3bQV8C++Emah65/EI32UMcHHUvHSJwn26gHZg2Ou4kqJ7Y2oSlG5NFKcFGf/Br8xYkWqo+F3fYNsDcNORLFsvfsvk5UEofYP04OOZQ0iDLVq4H58r1KVHKz2SCDz9FKwwAeeuykAmGDTDBQwxEIakdDvh/JBkrp8SasiS+Pem6cjgo2qSzdThI8ltU7hlphMDGJbiYH8iUzCy1c9RUbBPALtRIGpVorOCZc+OmJphA9VJucsvgy3rRLgJl3kEFLx21u1uLrAFEO3J0yJ/HtrQuewaQSLcQfI3kiN0vUa89GIIewapIn5CUYUp7X1ozUI/70F3l9ZGLRFYXRrISWoCvkIuO0JMDNrzYNnGRvqKOxhOGSomWhM00fJz3WARVv/1N/CmLJEKhHNC/yV60Nlp4DG2Hz9moF1c1Il47JPAjvPkL/89NHzGWQheIBhRrjC5J7Pv9am7Jhb5yd0Tp8ssJ0sT0ZhMnuwFkZLFT1+sFO11NoL6MyRAKqpQDPOwKxtznTnhBy3fKiZ0am1BHSgbbrKwEchryhlChmx4qBOodOgbJfDq49s9rT451CcK4juU/jeIND2jn9C8PuekWyiOiYDhdbSibBWRcHx6OwHmlr2HhDRY9Qr1sYPvRMi+pmewSGZ5Iw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3207.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(508600001)(66446008)(8936002)(2616005)(82960400001)(66476007)(64756008)(8676002)(316002)(71200400001)(6512007)(2906002)(4326008)(38070700005)(83380400001)(6486002)(26005)(53546011)(6506007)(186003)(122000001)(38100700002)(5660300002)(76116006)(86362001)(91956017)(107886003)(66946007)(66556008)(110136005)(36756003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S3cvZWxET09VNTJRY3puTmJpVlA5YWlKbmJjUzFkUnZIZ1VzL2Q0MFR4b1d1?=
 =?utf-8?B?bjdJaVprVXFaSVZRbXF3cytjZ2Z0UWd0eFI1Ukt5NVFFVVJjSnUvVzl2T1Z2?=
 =?utf-8?B?UFU4Q1lMNmdaTENMbWs4dHVqZnpEMHY5WGplcEJXRm1tVjdoQk13amZjeGNT?=
 =?utf-8?B?NDlTSVh6WWRJYkpTQ1pndHJUNmVTWWtpcTdsMktMUENJdXQwekRZZ3lNdVk2?=
 =?utf-8?B?RXZ5U29Fd3RCOC9GbGxzdVArSVBXdktpb0JjWldKWW1JR0E1bWg5YWx5YWI3?=
 =?utf-8?B?Yk9JeFJTUnJWQ1FBQnJJRU5ONGtZTzU1U21HSDQzN2YwOUlqRHhwTWMydE9o?=
 =?utf-8?B?SzVwVzQ0a0xMMTlib1g2WkRnc0g5dUV0QnlaSGNDMFBBOGJTWnZpZXlYMUNQ?=
 =?utf-8?B?TkpOblkzWlhhRVV2VDhRQy8yMGpkYzRxM3RpSDFIcmF0b1ZMNFNYTUtud0ZC?=
 =?utf-8?B?c0ZzWWx1MUIwT0RmWXE3NUVXWGRXUzA2ZzJ4d1o4Zk5iSHd2SFVST2ZjbHNC?=
 =?utf-8?B?dS80Qnd0RkdBR2xmdENzaGRuakpFT3NqSTRDK2FCS2FsL2plQkRHSzBqak9D?=
 =?utf-8?B?QUdHLzBGVDFxdnpSV2Flc293cFpDY0ZRYXcxOW1YeUdreENHMFUwaVNDelpW?=
 =?utf-8?B?SzhNc1UzcUgwN3pHT2s2TmdBcFhHRlBqdlZqTzNzaTRlZ2xSTFJnQ3B4U1lu?=
 =?utf-8?B?djBxcTQwdFd5VGo0NnEwa0RnZ3RvRFhqUXdZNXRXT3BSemVBV2lKS250M0dm?=
 =?utf-8?B?eGwwYUZ4WVpWMzBuZEJidE9QVFpseUpoSVJqaGg2L2E4QkhQbXJ6K3ZmVmxX?=
 =?utf-8?B?Uy9OM1hlbGxGMjJhaUtucEF1TUxwNURQZytuR0ZqRHhIUFd4NGlWM1BDS25K?=
 =?utf-8?B?MncxanIyZHNXdlVEWEpDeWFzcnBMczdKbG9Ib2pkdXRJbUZvcTQ2aGN0WUhr?=
 =?utf-8?B?THB3aFd1Q3g2QmdIYjVWYUxWQlhkL2pVQ2NybFpiRDEyc05tdlJianEvZ0Jp?=
 =?utf-8?B?ZU9GSlVHR2R6NzFXMkFJT05rbGE2Ull3YlFMWmEzbGFpY0IwbWw4T3l0MStE?=
 =?utf-8?B?MUpHZnF0NmZhYlN5Y05iTWw1OTd5R09nWjRjd05ESkc1TnF5MysrMTNGcWxv?=
 =?utf-8?B?Qm1iSElOMHVFUE8vYjBMKzFKVG93SHMvcmhhSkVpK0RLanF6anVHek9VeDlH?=
 =?utf-8?B?S2QyYnltMnlOdCtTVkNTeXVBTnNGNitzcE1jYjdHTE4rUk1hR282eVVBaHdE?=
 =?utf-8?B?N1RWTjlweGlPa3QzeXIvZXlzWGhsNURSZ2wxVWhwVjJVY0NEYTFVN2hLTnA4?=
 =?utf-8?B?UEFZRlJESG5FaDJBeG9JT1VBR0I0NzV3UW9YUUY0dU5tbEw0RW5sdUpPbEZt?=
 =?utf-8?B?U2piaW41Z0ZjMDJzZ29oUDZsRDBDVTJmZUpic1RRY1Nsd0orSEd6a052bVhW?=
 =?utf-8?B?Kys0NjdNQlBZSFluc0dTdm1zNkNTekpnM0lJNndKU3V6YlZ4czIzaFVZZW9K?=
 =?utf-8?B?WWpRMHNoNVB3MXQxeWVPK3VJVVBRbmRuSmlFWkRDbmJFMm9oVHNoS2h0UHBn?=
 =?utf-8?B?cDh1S204cXBMc09iSDY3NHdST2Vsb3JyUml3cHcyQWh2c0doQ0taYzlFSHZB?=
 =?utf-8?B?cHBiMGdicnZwWkFWRUhWSE5YcC8welpZeENGUnVub1U0T0I4TnV3UTZEMzQ5?=
 =?utf-8?B?YmE1WUpHNmNHVXhMV1UrRmJmb3cvWTM5MWI1bHdWSndrKzlKWjgvZDI4SGtO?=
 =?utf-8?B?aklpOUlhcWZ0WHdMYkVWbU13YmRabEJaY3ZJTDUwcUliOTBtSEduKzRSWE5J?=
 =?utf-8?B?czZJNWl0ZUx4ZXdtYThPb0gzSzdnOUZ6Q1JnamM1TWVpNENPM0NyZ09xVk9o?=
 =?utf-8?B?VWVzUUpLUWpyeEJwSzJRUjJaYVlSNklod1V2UGVEbURZWUh5djhJbEUwbys3?=
 =?utf-8?B?WWFPVjcwVGJRNWpLMEczTWxCbExKNENONUhhcWQ0RkVLbUZoRm10RGloR1hr?=
 =?utf-8?B?aTNUYkNUTzhVMWJiaitxYU5lRUVjaWp1bk8wVUFtQ000WEloZTBuNVhZMUl3?=
 =?utf-8?B?ci9ZcXFjcHpJV0x0TkM0Sm9JS1lPQUJkL1hPSitnVWVCOTJYM2NOeFY0UC9Q?=
 =?utf-8?B?UU5GTlZYTFFQd1MvRzAvb0pnL0JvckZuVG1hVUxsVjZsUElvOTdMZmJBUE5K?=
 =?utf-8?B?QUsxb1I1cTVpVkVNYkMvQzNWY0VibGMyTVpESnU1aHdEc2RZZWZMd0dHN2cy?=
 =?utf-8?Q?JtMQIouFFPLNPzGqA14rE+HSC5xJGdVfvtzQt+ln2g=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <82D550D6D6C8AA469D59EA64FC0BD379@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3207.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a317f056-0191-438e-cddc-08d9e09b419f
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2022 07:12:47.4086
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MJlSOlR9gma0VEMc1fWhMzTg47N2fCy34w3ARL6qGFQ+E7c0GNudNHNSqZ+HA4huyR1RvutVNPuK9hUZEXsmYbY1csktr9AV+hmhzTpC1l4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB2895
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

SGksDQoNCkFkZGluZyBHb2xhbiB0byB0aGUgdGhyZWFkLg0KDQpPbiBUdWUsIDIwMjItMDEtMjUg
YXQgMTg6MjAgLTA4MDAsIFJhbmR5IER1bmxhcCB3cm90ZToNCj4gDQo+IE9uIDEvMjUvMjIgMTU6
NTgsIEJlbiBHcmVlYXIgd3JvdGU6DQo+ID4gT24gMS8yNS8yMiAzOjA4IFBNLCBSYW5keSBEdW5s
YXAgd3JvdGU6DQo+ID4gPiBIaSwNCj4gPiA+IA0KPiA+ID4gV2hlbiBJIGJvb3QgNS4xNiBvciA1
LjE3LXJjMSwgSSBnZXQgbWVzc2FnZXMgbGlrZToNCj4gPiA+IA0KPiA+ID4gaXdsd2lmaSAwMDAw
OjAwOjE0LjM6IGFwaSBmbGFncyBpbmRleCAyIGxhcmdlciB0aGFuIHN1cHBvcnRlZCBieSBkcml2
ZXINCj4gPiA+IGl3bHdpZmkgMDAwMDowMDoxNC4zOiBUTFZfRldfRlNFUV9WRVJTSU9OOiBGU0VR
IFZlcnNpb246IDg5LjMuMzUuMzcNCj4gPiA+IGl3bHdpZmkgMDAwMDowMDoxNC4zOiBsb2FkZWQg
ZmlybXdhcmUgdmVyc2lvbiA2Ny44ZjU5YjgwYi4wIFF1Wi1hMC1oci1iMC02Ny51Y29kZSBvcF9t
b2RlIGl3bG12bQ0KPiA+IA0KPiA+IFdlIHNlZSBub3RoaW5nIGJ1dCBjcmFzaGVzIHdpdGggdGhl
IHZlcnNpb24gNjcgZmlybXdhcmUuwqAgUmVtb3ZlIHRoYXQNCj4gPiBmcm9tIHlvdXIgL2xpYi9m
aXJtd2FyZS8gZGlyIChhbmQgbWFrZSBzdXJlIHZlcnNpb24gNjYgb3IgbG93ZXIgaXMgdGhlcmUp
LA0KPiA+IGFuZCByZWJvb3QgYW5kIGl0IHNob3VsZCB3b3JrIGFnYWluLg0KPiANCj4gV2VsbC4g
WWVzLCB0aGF0IGRvZXMgbWFrZSB0aGluZ3Mgd29yayBmb3IgbWUuDQo+IA0KPiBJdCdzIG9kZCwg
dGhvdWdoLCB0aGF0IG9wZW5TVVNFIFR1bWJsZXdlZWQgd2l0aCBrZXJuZWwgIkxpbnV4IHZlcnNp
b24gNS4xNi4xLTEtZGVmYXVsdCINCj4gKHdoYXRldmVyIHRoYXQgaXMpIGFsc28gd29ya3Mgd2l0
aCBubyBwcm9ibGVtcy4NCj4gDQo+IFRoYW5rcyBmb3IgeW91ciBoZWxwLg0KDQpUaGlzIGlzIGJl
Y2F1c2Ugb2YgYnJvYWRjYXN0IGZpbHRlcmluZy4gIFRoaXMgZmVhdHVyZSBoYXNuJ3QgYmVlbg0K
c3VwcG9ydGVkIGZvciBxdWl0ZSBhIHdoaWxlIGFuZCBub3cgdGhlIGZpcm13YXJlIHJlamVjdHMg
dGhlIGNvbW1hbmQgd2UNCnNlbmQgdG8gaXQuDQoNClRoZSBlYXN5IGZpeCBpcyB0byBjb21waWxl
IGl3bHdpZmkgd2l0aG91dA0KQ09ORklHX0lXTFdJRklfQkNBU1RfRklMVEVSSU5HICh3aGljaCBz
aG91bGQgbm90IGJlIGVuYWJsZWQgYnkNCmRlZmF1bHQpLg0KDQpJIGhhdmUgcmVtb3ZlZCB0aGlz
IG9wdGlvbiBmcm9tIHRoZSBkcml2ZXIgbm93IGFuZCB3aWxsIHNlbmQgdGhlIHBhdGNoDQp0byA1
LjE3LXJjKiBhcyBhIGZpeC4NCg0KR29sYW4sIEkgdGhpbmsgd2UgaGF2ZSBhIGJ1Z3ppbGxhIGZv
ciB0aGlzLCBkbyB5b3UgcmVtZW1iZXI/DQoNCg0KLS0NCkNoZWVycywNCkx1Y2EuDQo=
