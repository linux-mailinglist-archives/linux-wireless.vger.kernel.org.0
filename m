Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00C976AC4C2
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Mar 2023 16:25:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbjCFPY6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 6 Mar 2023 10:24:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjCFPY5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 6 Mar 2023 10:24:57 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8326D30180
        for <linux-wireless@vger.kernel.org>; Mon,  6 Mar 2023 07:24:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678116296; x=1709652296;
  h=from:to:cc:subject:date:message-id:content-id:
   content-transfer-encoding:mime-version;
  bh=zFv3Iz96eFUznHo+urvSyRIECsRUL4v1SxgUOyggr4c=;
  b=iZTErwkwbfNs/pH2NtMOOxHTUBHbem+YxsQprAv9L52o1Fvrixx8XHQ9
   NzGpkJnyPg4gZWtxjb8bclNufBwFpHc0awUDhv5l14bSz4M0nFsi6j9P7
   /lqJccI4OoZPEJrtE7Ir4kyg2mS54e7Pl1yoAOn0gNviDJm1XTwFlyrzf
   Ib4jy3vr6ZoNxZS/3n7Y5dKBJJR6WRqJEJRV6cdnkA8dZw+gfIjRDiohh
   aXPPlDuDRa+9YJ/bP4jYurm1QF8nmsiDLFoIxYOdY19hmRKxjratNhjaj
   BCpKMOUxgENLARdnXSdvLVZtfr7J/+UNWRO/XSJd7OTR2/cpS1HFWegir
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10641"; a="398159992"
X-IronPort-AV: E=Sophos;i="5.98,238,1673942400"; 
   d="scan'208";a="398159992"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2023 07:24:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10641"; a="786275606"
X-IronPort-AV: E=Sophos;i="5.98,238,1673942400"; 
   d="scan'208";a="786275606"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga002.fm.intel.com with ESMTP; 06 Mar 2023 07:24:55 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 6 Mar 2023 07:24:54 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Mon, 6 Mar 2023 07:24:54 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.104)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Mon, 6 Mar 2023 07:24:53 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YRpfwePAz8n/ejUFMl/2BtDF6wfl7h7wlgXOOTkVGMt6SflzcSogPZzWivux2Ra1ThvfU2EiGbchv/q1PFpDaRxJ8qdBS6Brg3OXtBBlMt6lmaZQBYPr8IBeLA5HKzpJKSwmTUVl/9Ci+4lY5zvWDNrgIoM8FWjJX9uLPdeYj8Z0bk3CH5Vuqhtw/IAx1AsCLz3RdDu9UrvtKLKKhbZPOZeYfqRvQS1Yi11D43TmoBK9Q4YqMYVTYChJTkjbg9CNq4jvLLESHxuYFmWTaujAQGhiygN0+Zx8K4jFuKIAQiCLrM6r9Vh5c7yqCgeQDimGBERpjKCgiIMgPnw0uvIeNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zFv3Iz96eFUznHo+urvSyRIECsRUL4v1SxgUOyggr4c=;
 b=OepID6gDXfnhE1I49MSnQP8iBy8mxQ4h3hlAPy3HIN1MJFXLR+w14vbq0YSJ69xQT/NCXsmgMLChy/K9HecSVIjq4aYkW37vLsNVryw0N7pZG+AFSjUZ0UmUnw6d3iJmncVOZGb6cXlDWMubuAkBqo9iB+t6kkNQMfo1mB4n+HSY7ByLd7cfsThxAoYGF2mF/fGQESw2Hve/T+CKw4bljLCOu+2MOb0MLL9XhvDNxwKbn7TS0vzR0R6dZByLH/Ld/vDyU15CJWDZx5v44GNRwrSnT7MsyLiz+CvfnAzTr+FZ4Msg76WmPKhgGQGZqfOhvvitBWs3tuWWE7bpVEEhOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM4PR11MB5993.namprd11.prod.outlook.com (2603:10b6:8:5c::19) by
 MW4PR11MB5775.namprd11.prod.outlook.com (2603:10b6:303:181::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6156.28; Mon, 6 Mar 2023 15:24:51 +0000
Received: from DM4PR11MB5993.namprd11.prod.outlook.com
 ([fe80::b32c:ba39:271e:e768]) by DM4PR11MB5993.namprd11.prod.outlook.com
 ([fe80::b32c:ba39:271e:e768%7]) with mapi id 15.20.6156.028; Mon, 6 Mar 2023
 15:24:51 +0000
From:   "Greenman, Gregory" <gregory.greenman@intel.com>
To:     "linux-firmware@kernel.org" <linux-firmware@kernel.org>
CC:     "Hutchings, Ben" <ben@decadent.org.uk>,
        "kyle@infradead.org" <kyle@infradead.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "Ben Ami, Golan" <golan.ben.ami@intel.com>,
        "jwboyer@kernel.org" <jwboyer@kernel.org>,
        "Yang, You-Sheng" <vicamo.yang@canonical.com>
Subject: pull request: iwlwifi firmware updates 2023-03-06
Thread-Topic: pull request: iwlwifi firmware updates 2023-03-06
Thread-Index: AQHZUD/LZPM3tZLBXkGdkMC+NbsixA==
Date:   Mon, 6 Mar 2023 15:24:51 +0000
Message-ID: <be7951b30f40d753910e607791b20ed4e041023b.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.42.4 (3.42.4-2.fc35) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR11MB5993:EE_|MW4PR11MB5775:EE_
x-ms-office365-filtering-correlation-id: a82e12d7-c949-47e7-fc04-08db1e56ee34
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: diqaTsSTsjSTCCDFMrcJCNkfAbdRy1YhhBWpJixtHF9JWuNlg7lzh6fPUU8v1gLsGSBHYqG6tNL7mekYt0Rm35lxkRSjjbykSOJBaWACPVRML5hbcEGoHS+TpMcSYv++NnWBrnfLqgaeQEL862gRQR5nfyyCZeh27YgpYXX9gmTDedRpoQs9P3SuTmHUQbM08rEjdUrOCKnXY+Ev92+YsBawegaVww93ahzkTNIIwbghrhFUu60E52EkR1c6islAx4zr7sfdh279X5jLsSMJY/cDlO/OwHIvYU5cWueXnE826Jj9SyHiRHTQ7ElKwCwfR7xUNnBjDyiWBZUIxHxp9Q7NJI4fIp8BjQ6gfQFZYDTC/UBhk32IU6zppfiGXi/3PYg3hRlXaMhi/bXAMqpErafsdopVJ2rY+Xhdt4bXUEsVCobuYOeYqXX7MXxySKVTIzMA1OtzL/EITDKKOpks2psNqJ3KXkL/QAA687JyTPNJOC7GLI3+kl2MKkTEMnvldTMdyCbxHASuwzj7aHK5Y1yxfqGWZIh+JcoIifQE5bHxt597OyRjHvxmdZW2klCqmwNOaTu0CsXQdVdQcDIGc7Y8+ArGrq5BbCyO+myRl7A7VrqBcwCgJsXX6hBTCLWjPOUAis+3SdRvrwL4gJTCF9yI7dNgfccMmkeg6mQffOu7okv7AkjrzWHi6Eq33GhMlLx6gLM8J9E6yjnc8G7emlzeN5Ms5VS48yTGBrO6MLk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5993.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(136003)(376002)(39860400002)(396003)(366004)(451199018)(54906003)(36756003)(6486002)(966005)(316002)(83380400001)(86362001)(64756008)(186003)(2906002)(5660300002)(76116006)(15650500001)(66476007)(8936002)(66556008)(6916009)(66946007)(4326008)(8676002)(41300700001)(478600001)(6512007)(6506007)(2616005)(66446008)(26005)(71200400001)(122000001)(91956017)(82960400001)(38100700002)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RlMzSm5KbkZ6Ly9JM2dpVmVybEdzL1J2L1RGUXd5Q3FCd09jRTZBdEd6Zmw1?=
 =?utf-8?B?UVUwUGxvekN3Y0FZVHlKSTJLSVZUc3N6SkdNcDhjRmh2UXh3ckREaG5ZUyty?=
 =?utf-8?B?T09MdFI5bGQ4M2I4b1d3R043NG5qaEJSTkNHaXVMV1ZhcGtyaUFidmljeFIw?=
 =?utf-8?B?QndPeUlIaXhQNXlQUEc3NDNoeW9MYlpJc0lyUzd2aDB3MlQwYnluWjBMMFpr?=
 =?utf-8?B?NGMrMTllaElDOTNodjNIRVBRQ3dwVmhtM2lFdm1rVDl2eWZ5M3p1Unpkc3ZV?=
 =?utf-8?B?cmVDYWljUXJoNDZ2ZHVPcnlMS3VRS0NrTXdGNG1ReHUweXZZd09Tbjc5UmxR?=
 =?utf-8?B?cURBV2ZGWVJndEpobXBjbHduUFRZM0g5T1F0Q2VRaWRhUnhxc0RJNlJXNkJG?=
 =?utf-8?B?enRZc3dpV1dmSXlOTjJ2MDFoRnNDTG5sSW5XdjRVWS84OWo5TU1zZGF2MTRJ?=
 =?utf-8?B?dlhIRWFndk91UFlRaUYrVUdmNXhJSkMwYWdHWUo0ZTlCcmd1M0dndnRreFdp?=
 =?utf-8?B?VHhxYk5aVzJEanU4RjFnQndpakwzenZDRGVpeUlPcU16MXZsZkhJczBiZmta?=
 =?utf-8?B?MEJWWEZQVlNRZ1dwQWpZbmlnRitaVlZHeEJ0Mzc3ZWFWNDYyM0VQNDRqRkJn?=
 =?utf-8?B?ZDNTYkp6OXlidUZmVENDcXlzM3R1dzlPck4wbU5tTkl0QWxWb2o1T0VtUlFK?=
 =?utf-8?B?N0pGK0ZsYktXU1pDUkI0K1NnYXkvSkZ4ejMzb0pHbW9PbnNqdGtDTDF1QWVM?=
 =?utf-8?B?Y2tNR3FuclRDRWFNOTNFcGpOdm9abHRsTVNab3d5ejQvUWtDWklzT2RWaGNM?=
 =?utf-8?B?MXFjNE5QRldNZWpIbzZ6T243Y1M2alJrMXJ4U1FrOURaY1pwZFpSdVlkOFBo?=
 =?utf-8?B?SGJVTlhXNXRaa0NObDMwbG9mTkNaNGpGVUhPOS9iL3l0MC9DR0tRRUpmTFFY?=
 =?utf-8?B?V3FDM01ScnJ0M3g3RFFSSml2STRWempHM2dtaDU3RmNhTjZzWGxJazBEbmIx?=
 =?utf-8?B?OUR0R0xwbFdLVzF5ZFhCUVd5S2MyV2ozWjZ1dlFwK1ZCNnREVlBpV1JZWnNn?=
 =?utf-8?B?KzNJa203eFhaR0w1WDhTdDRRcFptUkRndHI5YzlIZTIvQ0xreS9taWFYdHUz?=
 =?utf-8?B?SXl4NlMraXhpaWtCR1FQUkNidU8wdTVMYXNmVWtVT3l5REZHWXUybjBZNkdy?=
 =?utf-8?B?VGNUQVBHTmQwWFBkL0VDSXJHSzdlRStUY0RYVHN0OWdITk83Tk8rYTBNeEtm?=
 =?utf-8?B?d2JUYzh6ZGcweGlaNTlMTFgyVERIa3VLVFFncTBZVjNhUEVNcjFWVVFVeHd2?=
 =?utf-8?B?RVhQVlU2cnN1NnFtamp4c2Z4eG9WTDBBdk9kOFJGWmdqdFhDaTR1WmdrMmVL?=
 =?utf-8?B?b2lwRGdKMjFhZzEzY2RJMVhmWW8yUjBoc1B4b1BsaWREN0hlNW9mQUI5TWVw?=
 =?utf-8?B?WVdWYXVUMCtDMDFUdWk5UllQQXlJRVVlT1dndTVEZ2xZOGpYbTUxTWMzQWtZ?=
 =?utf-8?B?bzhlMDRCcHRlZTBPRnE1SnlNMCs3Ykd6SmFqUGRTYWFIRlZMVy90UjNJaEhI?=
 =?utf-8?B?ZW5CbWZtNlZKWVltUnVtcVZvWHd1emtlT0JwczBldk9vMEpnNVJGQlk1SXJv?=
 =?utf-8?B?Z3lkQlROKy96UzRuRHR1SGhmOUErcGY4cmwzdzRmRTZBUFhkVWxTVmc3ZVRm?=
 =?utf-8?B?N3RicFZQSnlNOE1sUHVDVm4rQ244dHJlR01zYkE5ZTB3dklOVC80VkFXSFhQ?=
 =?utf-8?B?dzM0VzNwMVBvTTNrODNvQ2dUQ0p6UGgrWmt6L2VPSDJtUUZVNkVuVTQyUW80?=
 =?utf-8?B?L3BrQ3BpV2N2UUZHVk5NWHFSNXE1Ti9MbUZVTDRidUlMa0libjZqKzN0OGcv?=
 =?utf-8?B?aHU2S3hORVAwalo2K25SYTY2MHhaZkZQYWZ5VlZDc3pDOFZlbG1CWFNNQ3Bq?=
 =?utf-8?B?KzB1MTE1QlFxaDdSTnZYQXdVYkVsZzBxQkxUOVlFRllBb29VMXh4VVoxNU9S?=
 =?utf-8?B?ZEtBSGZiK2RQWklxakF0WEI4MExzMStveUtVM0pWZVdLUHZKZDVEN0tJV2R2?=
 =?utf-8?B?RVZyTzBldUF0NEVMcTZDTnpjV3o3bjVDSDU1ZFU3bmt5ZDVtM2dDc0xWTWVT?=
 =?utf-8?B?TzdGaEF0K3ByZWU0ZkpFQ2gxVXU5anJiYmRIRTdSK09xRWIxQUpBdjlzclNz?=
 =?utf-8?Q?PqESC88YNyl1fTUqE/kEdq8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0D33444F7752664BABD45133A5EF080E@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5993.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a82e12d7-c949-47e7-fc04-08db1e56ee34
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2023 15:24:51.5371
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S59GAlLnjs6/ffu60ym4G8vB4oH+TiCrLO3fTRPYWMBBKS+YRYQp9OmeQzVdoD93xUvV485ZYCpDuzNgYUUwjoCwSH9/WZ6Tu2jDSjQ2PWs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB5775
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

SGksDQoNClRoaXMgY29udGFpbnMgdXBkYXRlZCBmaXJtd2FyZXMgZm9yIFR5IGRldmljZSBmb3Ig
b3VyIGN1cnJlbnRseSBtYWludGFpbmVkIEZXIGJpbmFyaWVzLg0KDQpQbGVhc2UgcHVsbCBvciBs
ZXQgbWUga25vdyBpZiB0aGVyZSBhcmUgYW55IGlzc3Vlcy4NCg0KVGhhbmtzLA0KR3JlZ29yeQ0K
DQoNClRoZSBmb2xsb3dpbmcgY2hhbmdlcyBzaW5jZSBjb21taXQgNjA5NzFhNjQ4NWVlNjA0YzQ3
Y2M5MDVmZjc3YzU4M2FlMDAxZjlkZjoNCg0KICBNZXJnZSBicmFuY2ggJ2xpcXVpZGlvLTIwMjMw
MjIyJyBvZiBodHRwczovL2dpdGh1Yi5jb20vZGNoaWNrbGVzL2xpbnV4LWZpcm13YXJlICgyMDIz
LTAyLTI3IDEyOjMzOjA3IC0wNTAwKQ0KDQphcmUgYXZhaWxhYmxlIGluIHRoZSBHaXQgcmVwb3Np
dG9yeSBhdDoNCg0KICBodHRwOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwv
Z2l0L2l3bHdpZmkvbGludXgtZmlybXdhcmUuZ2l0IHRhZ3MvaXdsd2lmaS1mdy0yMDIzLTAzLTA2
DQoNCmZvciB5b3UgdG8gZmV0Y2ggY2hhbmdlcyB1cCB0byA0MzA5NDEyYzBkODcyODk3ZGM5MTNj
N2QyNzk3YmI1Y2UwNTg5M2FkOg0KDQogIGl3bHdpZmk6IHVwZGF0ZSBjb3JlNjkgYW5kIGNvcmU3
MiBmaXJtd2FyZXMgZm9yIFR5IGRldmljZSAoMjAyMy0wMy0wNiAxNzoxMjozNiArMDIwMCkNCg0K
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLQ0KVXBkYXRlIFR5IGZpcm13YXJlcyB3aXRoIHRoZSByZWNlbnQgZml4ZXMuDQoNClJl
dmlzaW9uOiBkYWEwNTEyNSAoY29yZTY5KQ0KCSAgZmUxNzQ4NmUgKGNvcmU3MikNCg0KLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LQ0KR3JlZ29yeSBHcmVlbm1hbiAoMSk6DQogICAgICBpd2x3aWZpOiB1cGRhdGUgY29yZTY5IGFu
ZCBjb3JlNzIgZmlybXdhcmVzIGZvciBUeSBkZXZpY2UNCg0KIFdIRU5DRSAgICAgICAgICAgICAg
ICAgICAgICAgfCAgIDQgKystLQ0KIGl3bHdpZmktdHktYTAtZ2YtYTAtNzIudWNvZGUgfCBCaW4g
MTQ5OTI4NCAtPiAxNDk5Mjg0IGJ5dGVzDQogaXdsd2lmaS10eS1hMC1nZi1hMC03NC51Y29kZSB8
IEJpbiAxNTMzNDQ0IC0+IDE1MzM0NDQgYnl0ZXMNCiAzIGZpbGVzIGNoYW5nZWQsIDIgaW5zZXJ0
aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCg==
