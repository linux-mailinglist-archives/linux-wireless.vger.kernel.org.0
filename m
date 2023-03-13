Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA7346B710C
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Mar 2023 09:20:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbjCMIUj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 Mar 2023 04:20:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjCMIUi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 Mar 2023 04:20:38 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BBD3252A7
        for <linux-wireless@vger.kernel.org>; Mon, 13 Mar 2023 01:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678695637; x=1710231637;
  h=from:to:cc:subject:date:message-id:content-id:
   content-transfer-encoding:mime-version;
  bh=l3RVY44U/S3vYGwqVkHlPCEz0BpC+YKmHm2YmBLUynY=;
  b=CSFU4q4AfKJeJ7KN1DzWKc3fsvNrmd/XZYo5PwC4TjwGDVNCg0L2e0b6
   5wq/jM8EkRVhinYioi86biYJlcKw8TftSUnUhe8/ZPxPV+BtzN6NyqOjY
   diig1JdkDiQ5vu+K+01Zx97DaYnUAuUY+EYcv3ctUgL2ttUeFQVO2bZjj
   n+BlceTrHCpp1EUhIwie6pGpi35vnThzsMCUwX+M1/Cc0jgsNcePs8aE3
   068ZkpdySrKs4ZFSUBkHnQs0M/b/hUkuhHUhPb6sCnFM03QgNTFGfIDXm
   YQuPV7OjCsAj0d8CuHmqyqwtbn5ntrXPwTnZ1epfRFVNbhuJAmCN25m65
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10647"; a="337111582"
X-IronPort-AV: E=Sophos;i="5.98,256,1673942400"; 
   d="scan'208";a="337111582"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2023 01:20:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10647"; a="821860353"
X-IronPort-AV: E=Sophos;i="5.98,256,1673942400"; 
   d="scan'208";a="821860353"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga001.fm.intel.com with ESMTP; 13 Mar 2023 01:20:37 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 13 Mar 2023 01:20:36 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Mon, 13 Mar 2023 01:20:36 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Mon, 13 Mar 2023 01:20:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q6koSTeQmFgs5z99vlbfQ9APunNUjadwOH2tdfJ3+kLlyThT2pz+tR+6ELzw4Q4r3JCcBnnk4sNVSpo+W1opWr9fvgbXPGGNG+0P6daB1ryx1OrjJzh68i7BJCWL5kneh3LO07ps0je+8Dtckk3BXvUd0V3V+/x5qXe1x3wdDQN8nh0Jv8b0LZkt97APd2P5arhTp+3wwllgMegY41PY62YlqVmlBrsf55hDwyXo5XrmJOv7F00sH3oD2kPzZuJKUF5ERrKeQEeWhNlfxclecrgBx8lNImgNABei9Nxx0XuwbxLkFKeGDjWoH7F6IYxRlw5iCRcRvqhWozolPE9tNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l3RVY44U/S3vYGwqVkHlPCEz0BpC+YKmHm2YmBLUynY=;
 b=Vteus2M4kWb2bkylc5BTOqDJBogXcGifnfEQVVb2fhs9DqKcpG5h1+KDF0YANUjwNhdzWxLDAfOrbT0bGGRfNobFD57g6Fqg2vnkmRjLTzOrgaywc42Lj+0UDVMgVKcTHqNyINpGKPt5jRbANg10m+TSzOaLVWiVzJJBKS8t6phgZIxubtMDVqd9wE0CToWaYUgBwW2/T7ixiJmIgvxlLcIk9yu2avd6pMQ1wq3oY4zw8i3pOko7JhMVUeMcQ4FJ7LBYLyvEwoytkPSRLW0KhD7nlVU+6QNGLsQG7I9B0aYJSHjxQg45/EoRjxUpfMNUHYZeIIeAaaiX5YIL8nwDrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5987.namprd11.prod.outlook.com (2603:10b6:208:372::8)
 by DM4PR11MB8092.namprd11.prod.outlook.com (2603:10b6:8:184::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.24; Mon, 13 Mar
 2023 08:20:29 +0000
Received: from MN0PR11MB5987.namprd11.prod.outlook.com
 ([fe80::4bd3:d6f5:8a5f:5330]) by MN0PR11MB5987.namprd11.prod.outlook.com
 ([fe80::4bd3:d6f5:8a5f:5330%6]) with mapi id 15.20.6178.024; Mon, 13 Mar 2023
 08:20:27 +0000
From:   "Greenman, Gregory" <gregory.greenman@intel.com>
To:     "linux-firmware@kernel.org" <linux-firmware@kernel.org>
CC:     "Hutchings, Ben" <ben@decadent.org.uk>,
        "kyle@infradead.org" <kyle@infradead.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "Ben Ami, Golan" <golan.ben.ami@intel.com>,
        "jwboyer@kernel.org" <jwboyer@kernel.org>,
        "Yang, You-Sheng" <vicamo.yang@canonical.com>
Subject: pull request: iwlwifi firmware updates 2023-03-13 - fixed
Thread-Topic: pull request: iwlwifi firmware updates 2023-03-13 - fixed
Thread-Index: AQHZVYSq1gNiXRIJKk+l+NbHX2t7JQ==
Date:   Mon, 13 Mar 2023 08:20:27 +0000
Message-ID: <7d3659e81094ca968fb2847176a410e27634df2f.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.42.4 (3.42.4-2.fc35) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5987:EE_|DM4PR11MB8092:EE_
x-ms-office365-filtering-correlation-id: 8c3921a9-1a22-4982-69a1-08db239bcd4e
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: y9xyAI2KHZzKNyzeNkvTCJI5XYK8ek7G8rbsi5n/xISZeOxCIvjBTO8aw6ZmA0IVYmhWLMA5wjYAajlEja/EEfTmppwfRIgVBMVS18u3ckX9uFD4EHsi+xtGT+VCt9485U4IKlUx7NMX7mfw997py8saffLFhGVz+4IiJj1qNvAOzPqZ/5pawyvtr5FEehMRZ02uGatFvDSuTejpRNdA/Lm+vntMujNDaFrk+eNOgv5KXPEIEmzD64B6xUGRGW3OQcff6UhHiolbO95aM5D+2bz9FSE7qZ82P1PBqsQCAUNJwOIm86aPfJLsmM/ghepl3TBrTj617cTPZ5PfDEbVVSFzB+CvICxY5PVJQf+MGoX6U+5zB3tZYPB9Nbfc5RLj0t/q+agldkBmRTJeD11VbbsCw5yhejIN5EaBE4ECus+zDgjApdU0TYDRXSxz7KrSLkNOxUJ3g+z0Q2QsDQi6XCzS2JCu4+x3Qj1o3JDgDlFwbd/Hm7I31P1tgXOJYHvJOInZoITSueLmycdHA8FAXNt0K3LVfnP6h5hnALB9kAoxq+w3bsrv9OuoVdYSXqSP1cWsBUiHBvEEP1FUoBgu1zyF/Rhw+r1rRmpmnjqiNs6UibzXZXcqNodRvhxChgUrdP7bKK9dwfe1y0+yS0Y7dfIDMbhv2lXqOmx/KQxyVCCe+GkbxquskPrFlYidsDO/
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5987.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(136003)(366004)(39860400002)(396003)(346002)(451199018)(76116006)(41300700001)(54906003)(91956017)(478600001)(8936002)(66446008)(64756008)(8676002)(66556008)(66476007)(66946007)(4326008)(6916009)(86362001)(38070700005)(36756003)(38100700002)(122000001)(82960400001)(6506007)(186003)(71200400001)(966005)(26005)(6512007)(5660300002)(15650500001)(2906002)(316002)(6486002)(83380400001)(2616005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YWQxMUJEQ3JkVXcxU1JlR1VnbUdVTVFWdGI3N2FEOTR3b3B6WHFQY1N0bE5p?=
 =?utf-8?B?RURMMDVZSnBoQUY0RjhwUDBCRURBV0hOVTRxR2RWRU40cGlEaCtKcHpFeG1O?=
 =?utf-8?B?OEV0d0xWMkZGNjVaNDFWZzNQc2xRRWQrcVZJWGJUR2p3ckRxNGxMNE5CNzF6?=
 =?utf-8?B?YXJmejBKbFJ0ZUZHcUhSUzBpUEVOOHhndjNvbEVyem9tUk5iaWIyTnNlcjZU?=
 =?utf-8?B?REd6anQ4djkzSFRqVldibkU5Ym5DcllxWTM5TlRiQWdiYXFvMVpaL0dGcTJM?=
 =?utf-8?B?RkRNdmJJRnVEczYwdXdaWTVCMnRuWEVVOGVQZnpNcnNmNU02VDdiUDNmRTQ5?=
 =?utf-8?B?SVNSeTBtdVFETVJwSWh0Zkd1UGtEWWc0UzZ6UkRKeDN2M1psUWhmQUh0YjVG?=
 =?utf-8?B?RGt5QlB2ejd5UGJyNUhuSnFUclB2em8xT2tYQmE0K1VGdy9NWW1pTkt4WTgr?=
 =?utf-8?B?ejNEcmZYMU0ra0d0cUtFa3NZVVgvYytXV2FreWhONmZCL0VaTGttcVJ1L2xD?=
 =?utf-8?B?VVlON1VFWUFTc0V0MVhhWkF2ZTNoVlo2djdIVjRBMUlzMmV6dEM1UmlhUXVv?=
 =?utf-8?B?c1ZDYUJUdUdjTDM0TmNUak1kNWpaUEdnOHpJVFdKcG1vL21BTDNqWndNZmVq?=
 =?utf-8?B?YXErTGQ2UVcvN3lPZHlFWVgrTHQycDJ2bjFWdUxkWkdRTUhGOThiSytMUEV4?=
 =?utf-8?B?K0R6SXk1SDM5NEdJZndsM1lnOUMvQ3g3emFTRE1NTkdFQi9HakQyYzZHRG9K?=
 =?utf-8?B?YU9GYnV0cXdnblgwVDFMYXdCWUU5TytvWjBXR0tEOGt5TkVUTloxbzhsUVEv?=
 =?utf-8?B?TjVrelV0OEZ1STd2Yk5IZGZQcWlVRUZ6UnBhWDllT3hVSG9UemRrZ0hES3Vj?=
 =?utf-8?B?UjRkY2lmWWZBZHU2VGRaSE5ZeVpNQUdVSzE2MXpyc3dnUVFIQThRb1UzdHdF?=
 =?utf-8?B?Z1pCN0krMTlxZ2pSZjc4ZmxjOUsyd0dOeHY3TGx0QjlPNHJvT0NDVW5NRm10?=
 =?utf-8?B?T1lYZWxLa3FmYm1Rc0xzOUhoN0FpUTljc3ZHQ3U0SDgrRlgrY2dla2pHVExn?=
 =?utf-8?B?cVpwbUttRWdBOVNjaFFiVU8vTlhGSHhKS1hSOGhvNkFHZjVNSjR2cS9qZnpy?=
 =?utf-8?B?WC95WUxrOWZGbnMzL2xFOFpaa0habGNMTzZ2Vmx4VytUd1V3OXNXRjVERHVD?=
 =?utf-8?B?S2hiUGFvZzlzaHRIM0Uva0RmU05QbGg3YWVtSlFtL2EvRWJ0Y3pxYndCOTJJ?=
 =?utf-8?B?NTkwT3NDaVVFU3BnYnBZdzN2Z293TnVUY1BpZmF1NUhCdTFsK1pYb1JPeFpG?=
 =?utf-8?B?SjBkeEtzME1obE9ZbTVqTFFsSmYrcDZxeWRRSFlXd3dHRE9lSEZnOWloU05N?=
 =?utf-8?B?Q3pWTGJMZjdBWm1SMVBERUt2a2pOMUJhWVJlcVZnZkVMODM2VnJqTjR3cCtO?=
 =?utf-8?B?M0R0c1pMOWFBNElreStNclBDaXM3RVlaK2VUYUlPWmFUaXVhN200WWFZcGlP?=
 =?utf-8?B?U3BJTnh5MU54dytlK2dPVUcvbCtVd2syRXhDZ3ZRVjNsUk9aL3lIVStwa3dY?=
 =?utf-8?B?bTRTa1RVOGY3SEo5NmhjZFcwckRlNFQxK05WZjF1a2VtY3JiaXFmUVhiczJV?=
 =?utf-8?B?K2M2QTlkMTE0eklaUzNWMDhybEE3bnFzSjQ5b2tLUDl6L0ZHSlJzOUF6bU9w?=
 =?utf-8?B?Q2M3ZlR4eFM3c29jck5sWCsxbmlERDNnM0czWHFlTEFxSTdtSkEzbkV1Q3pB?=
 =?utf-8?B?aEl3SVF4cDJIc1RZK29IOXFDUVV1Vlc0dHFyQmdkNkR5dTljcXBwdHZMMlJl?=
 =?utf-8?B?cHUzMUtrWlA4b2Nzb294RC9NS3dBS2gxQ2hxTktlOEV4bUFGeUpwVGllRlhE?=
 =?utf-8?B?NUZBcm14MW1JdGpteGJaMm4yLzZadTAwOTFFTmFkKzJyQVUwMzdPVmtzUHpq?=
 =?utf-8?B?aExkaERSMDc5Sy81SFV4ek1kclVXMno1dE5UK0dROXkxU0VVVXlYeGJ5MEhN?=
 =?utf-8?B?cDhtUTlJN2lkK0UrUW91UUR0VkRlVmRoTDZkK3k3OXJjUEw1Y1VuMm1hcFhM?=
 =?utf-8?B?TzE1V09JUGoyWldOeDRnYzhFRkxjd1U2V2tnQVRwK1M0NlJpeUZ2M05YS3NO?=
 =?utf-8?B?aDlPK29tbmd0c0UwZk03ZUJSQzA2STA4TS9NUm5qc1NoSE05c2hjbnh1L1RP?=
 =?utf-8?Q?wvHwitAyAOp8NCddfJusa0Q=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9653F4739149BC4193F0BB27FC3EECB0@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5987.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c3921a9-1a22-4982-69a1-08db239bcd4e
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2023 08:20:27.4272
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xup0fIjBufIsHC2buJMUw0/gDnixUb8SV1zI67psABIXIBMlI/V6qTXR5pcagmV8HJBRTXwBK07aWpsSd2DYpVWfpUTGivFcruhT9Gn4Fzc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB8092
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

SGksDQoNClRoaXMgY29udGFpbnMgYSBmaXhlZCBwdWxsIHJlcXVlc3Qgd2l0aCB1cGRhdGVkIGZp
cm13YXJlcyBmb3IgU28gZGV2aWNlIGZvciBvdXIgY3VycmVudGx5DQptYWludGFpbmVkIEZXIGJp
bmFyaWVzLg0KDQpQbGVhc2UgcHVsbCBvciBsZXQgbWUga25vdyBpZiB0aGVyZSBhcmUgYW55IGlz
c3Vlcy4NCg0KVGhhbmtzLA0KR3JlZ29yeQ0KDQpUaGUgZm9sbG93aW5nIGNoYW5nZXMgc2luY2Ug
Y29tbWl0IDU4OGRkMDcxMzRkYWY0YjBmNmY3NDY5OGYyNGVlYjc0ZWJlOTAwMTI6DQoNCiAgcWF0
OiB1cGRhdGUgbGljZW5jZSB0ZXh0ICgyMDIzLTAzLTEwIDA3OjQwOjI1IC0wNTAwKQ0KDQphcmUg
YXZhaWxhYmxlIGluIHRoZSBHaXQgcmVwb3NpdG9yeSBhdDoNCg0KICBodHRwOi8vZ2l0Lmtlcm5l
bC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L2l3bHdpZmkvbGludXgtZmlybXdhcmUuZ2l0
IHRhZ3MvaXdsd2lmaS1mdy0yMDIzLTAzLTEzDQoNCmZvciB5b3UgdG8gZmV0Y2ggY2hhbmdlcyB1
cCB0byA1YmMyNzlmYjE2MWQ1MjliYWFmOGU4MzdkOTAwMjM1ZmJiZTliZjJmOg0KDQogIGl3bHdp
Zmk6IHVwZGF0ZSBjb3JlNjkgYW5kIGNvcmU3MiBmaXJtd2FyZXMgZm9yIFNvIGRldmljZSAoMjAy
My0wMy0xMyAxMDowNTo0NyArMDIwMCkNCg0KLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KRmlybXdhcmUgdXBkYXRlcyBmb3Ig
U28gZGV2aWNlIGJhc2VkIG9uIGNvcmU2OSBhbmQgY29yZTcyDQoNCi0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCkdyZWdvcnkg
R3JlZW5tYW4gKDEpOg0KICAgICAgaXdsd2lmaTogdXBkYXRlIGNvcmU2OSBhbmQgY29yZTcyIGZp
cm13YXJlcyBmb3IgU28gZGV2aWNlDQoNCiBXSEVOQ0UgICAgICAgICAgICAgICAgICAgICAgICB8
ICAgOCArKysrLS0tLQ0KIGl3bHdpZmktc28tYTAtZ2YtYTAtNzIudWNvZGUgIHwgQmluIDE1NjA1
MzIgLT4gMTU2MDUzMiBieXRlcw0KIGl3bHdpZmktc28tYTAtZ2YtYTAtNzQudWNvZGUgIHwgQmlu
IDE1Nzc0NjAgLT4gMTU3NzQ2MCBieXRlcw0KIGl3bHdpZmktc28tYTAtZ2Y0LWEwLTcyLnVjb2Rl
IHwgQmluIDE1ODA5MDAgLT4gMTU4MDkwMCBieXRlcw0KIGl3bHdpZmktc28tYTAtZ2Y0LWEwLTc0
LnVjb2RlIHwgQmluIDE2MDIwNjggLT4gMTYwMjA2OCBieXRlcw0KIDUgZmlsZXMgY2hhbmdlZCwg
NCBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQ0K
