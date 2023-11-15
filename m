Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 437237EC927
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Nov 2023 18:02:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231598AbjKORCH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 15 Nov 2023 12:02:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230106AbjKORCG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 15 Nov 2023 12:02:06 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BD0819F
        for <linux-wireless@vger.kernel.org>; Wed, 15 Nov 2023 09:02:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700067722; x=1731603722;
  h=from:to:cc:subject:date:message-id:content-id:
   content-transfer-encoding:mime-version;
  bh=7jZ+tXG2WDakqcKkZPZw3HSM7idAGxhR9jRke0F2TNI=;
  b=VY8g31g6F9GdrS2h+jvufXAsJwnnGFfQzAAQtgJDcvSiztBnsiIRbYKY
   IJMjvYFsBvnKhbAlAwYNuTzJGxYsUijoSXiPEvAv079yxzCsXu3Oub2/d
   3Q1WONRWvdHp2M/FkStyldts+vTZWJjFxfZdFcpaRx9dKJo+u/5ssZ2et
   u6El+6isRHRfEFWXXzGf83i+NXZE6yqwICYTEhzxTrxPDNaJ3mhkhOF6P
   yHaTjdFbFf8MP8xkoXBYEjg+uWip3+fbezZmmWisiJzPawVik8XnvPJrb
   LP7sVwuhxd7uxn63w7h2mJd2Lp9os9ATp3Sfrp4WfsubYwtEUUqLxUhrv
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="394831789"
X-IronPort-AV: E=Sophos;i="6.03,305,1694761200"; 
   d="scan'208";a="394831789"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2023 09:01:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="714933374"
X-IronPort-AV: E=Sophos;i="6.03,305,1694761200"; 
   d="scan'208";a="714933374"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Nov 2023 09:01:36 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 15 Nov 2023 09:01:36 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Wed, 15 Nov 2023 09:01:36 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Wed, 15 Nov 2023 09:01:35 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KoG6TxT4YgdVR1qrwBAsGY3dN++5pBxAs12YjRbV+9zlxvK9LVeUUZfwryDaWstnKKRC+SHsW6A3+Xcp+xfG6sK7Xo3QefPv8S3l+5EkNO1oX9FLyuqUiZ986dqaeX4+MO1+olwT3vTbppTHpsq/8aifr0hKS2fSf4udkmxB5cFAUmbc2DL1bmb3wbjjZQ7xeE94SPatTqt75ztnPrfsKnV8TF6V71lSoumYZ6wvTNAeHGdStFo+olx2ULiTPzoAbh5zkmsqemRbJx5W817oDO8twTUfr9X8mifTjA4nQfriLms4iTrIy5Rl3e9xy9i/0peSZsoedU05NNM3wqMtng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7jZ+tXG2WDakqcKkZPZw3HSM7idAGxhR9jRke0F2TNI=;
 b=HZj4RUQmC690UroUx/9uR2OKmj6fslhUxJb90vTGtTIu965ZjHmQSQt++IM+7T+AUFArBybnp3Puc4CAbMEWMNhDqeFSQ0Ebc4inzy2haP6m87/dCG7cofxxBS3CmGD005xseoCgjIqzDIFTyOR4b4d+Hh6lfz2ZMAcYzo8hQqm5zIMA5Gr4JZjkNATza/T6Vff1rcXjIvjy19UzvX+toWnz2Y0I48dHCOZwuOeoKW9qpw+cbX6U71ehIhK3H4Gk1dJOk22EnIicSu1WSAuA2cRPKtdZKE+hXuYXq8DGPtPhThbiAQlyF3e/Wbczb95I8EZV2FNKRgYSUyH87DFKRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5987.namprd11.prod.outlook.com (2603:10b6:208:372::8)
 by SA3PR11MB7655.namprd11.prod.outlook.com (2603:10b6:806:307::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.21; Wed, 15 Nov
 2023 17:01:31 +0000
Received: from MN0PR11MB5987.namprd11.prod.outlook.com
 ([fe80::b045:b0aa:bae8:706]) by MN0PR11MB5987.namprd11.prod.outlook.com
 ([fe80::b045:b0aa:bae8:706%6]) with mapi id 15.20.7002.019; Wed, 15 Nov 2023
 17:01:31 +0000
From:   "Greenman, Gregory" <gregory.greenman@intel.com>
To:     "linux-firmware@kernel.org" <linux-firmware@kernel.org>
CC:     "jwboyer@kernel.org" <jwboyer@kernel.org>,
        "Yang, You-Sheng" <vicamo.yang@canonical.com>,
        "Hutchings, Ben" <ben@decadent.org.uk>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "Ben Ami, Golan" <golan.ben.ami@intel.com>,
        "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>,
        "kyle@infradead.org" <kyle@infradead.org>,
        "Grumbach, Emmanuel" <emmanuel.grumbach@intel.com>
Subject: iwlwifi firmware updates 2023-11-15
Thread-Topic: iwlwifi firmware updates 2023-11-15
Thread-Index: AQHaF+VhSQ/Rc3V1YUuIujacAQPTjA==
Date:   Wed, 15 Nov 2023 17:01:31 +0000
Message-ID: <afd952bc8ba251f060aa9179ba2ad9d20c7058ff.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.42.4 (3.42.4-2.fc35) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5987:EE_|SA3PR11MB7655:EE_
x-ms-office365-filtering-correlation-id: a34ddf45-bdc3-4762-d06c-08dbe5fc841b
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bC8JvN+CFXncOwe301tSiyDsNo0fP+SC/CG01WOqgUusH8RBvyMsrKHfTLVjM4y0RcBOSy/I4n7D33MBsIdsT0ZjNfSO22xAyMJYAE9QaGH7h9Wa3mPE5wGr4z7wvO+3hqZlTcYmOIZBRlDQsxJIvfIWa8PRIZ2DSE2nzk+Z7zkCzy37fTFRZQTchy7RT9qoeUehnPKDVywXN9SZjxtEmQ1erGVw/qg1JW6u/wR14IPbVZPNeaj/gEAe/TPHl1k6FNXuXlDxtezCONW75iLSFf9711XZVo6PjZVj45l7IVCcIiaYyB2b3yt5qQgZrWoZzbktCC7JvIuNoEvwuCjJbexJ/f0dFMrQjM46AYTr4oau7/gELPi7xUHPRiQ2gatH8HmNoVKIYiZ7j1kK2wrZHC1trsZmrDG2NGGIpU4q3s3em3gnoGAtl1WSZYdyiaYwTnSPctogxGPJBjbKJvYf6IV9tvHqnmLNtgfNuGMFj0IodpkxZyLnUw+7S0Od/jKrOV63PIgbPtBaayhSKUUJj3Pbn7dyKLxajQOY6JBOsQuPfCPvldKa54PtBWKV3hjLfyoDVkUh3PXf0BnpLJGAI3sLZLUgSnhqUBvC/LkJor0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5987.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(136003)(396003)(346002)(39860400002)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(76116006)(83380400001)(26005)(41300700001)(6506007)(2616005)(107886003)(122000001)(86362001)(38100700002)(82960400001)(38070700009)(36756003)(64756008)(66476007)(66556008)(8676002)(6916009)(66946007)(2906002)(91956017)(15650500001)(19627235002)(5660300002)(8936002)(66446008)(4326008)(316002)(6486002)(966005)(6512007)(478600001)(54906003)(71200400001)(4001150100001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R0s3dWlTZElQeTRVMWNIdjNFZEhIQ21QMnQwZVpYWVJVK0tLbEplVzQ1S3g3?=
 =?utf-8?B?UFVPeUZKWE9jWDBrclhhTnQ1M0huc3Vxd3E4UXRYZnVCVXVPVWV3RDQvZ013?=
 =?utf-8?B?ci9hOUpxd2twOVVqUEg0Ym0vTUpkOHVrWUhVTzV3QzEyVDM0cXBWUDRadUJk?=
 =?utf-8?B?U0QrbWJQc3h6SW05dkVQb1JEK213UkUvcXdSNW8zcnV0cjc2akc4d200MVlU?=
 =?utf-8?B?azV6NmZMbUlOd3Nod3FnK015amZTdjY2c0lsZHl5WEZGK2VvRlRzYkFBNGRx?=
 =?utf-8?B?ZlhSNlRlbGtGeFVWUEFJM3ExSFRObjdqYzl0U3Y4eVlUcExYMmxtRFUwaUFi?=
 =?utf-8?B?cjZ0dEhiU05OZHY5enoxbmI1dGJONkVwUUZJRFgrWS9iYW9qUHFRQ2hKeEpB?=
 =?utf-8?B?eUhpOWI1WGFFU0ZyelVOVktkK0cyS3czZkNtRU54R2pISmNZbFBudXRnU2Zy?=
 =?utf-8?B?TnE0TUNvZ0xmaGZwbnJuT053ZGpQQ2kyK0RnS004SmwvYWtkQkJkOGVVcnJw?=
 =?utf-8?B?cE9rclNTY1M1QnBDR0hXaUl0MjF1ak54V3Z0dXVpbkoxUGZrNGpsdGVqSit4?=
 =?utf-8?B?WDJ3cW9SUGJjb2ducEJ4Q3p4bUVRU1ZhaGZtQWo4cGtydWd3ZVZaVFJaSjRr?=
 =?utf-8?B?OVU5VGJ3eUhFd3kyL0d0S0VBVEdWWkYrakhqc3IvQ0NkclR5VytEZVJWdHdG?=
 =?utf-8?B?alJBK0c3ZnNza3U2MERSYXF6cDluRkoxYkdGL0ZYZzM3QTh0NG93S3NUUTBa?=
 =?utf-8?B?TFVUR2c4TmNrT1pWcTVZeG9mdUNKNWpBODRCUFhJRkNzKzhzUGp6azBVVUhX?=
 =?utf-8?B?ZGpjWGhMZGxLbGRtR2JhdStYU2RvYlZRTHRZNmlsNFFHWHBoY1BGSXJIM0Nr?=
 =?utf-8?B?VVJsLzA3dkMySGREcGIzaXFySzFKOUtTV2NXejB1QVVzZHVZV0FicTNpaE8r?=
 =?utf-8?B?alpkaXVqYkFUNmEwdXdYUzZaUGFIVFpkeWs2U1RkQ0E0UDdUMFgreHZLa1dv?=
 =?utf-8?B?bTREdlpPL29idVFtbURNY1M1TUE4RkZoRE9GM3pwaWliS3h3SGZvZXJ1dGc3?=
 =?utf-8?B?b0xSREVZQ2IxK2FzVTVKSGtUWldaN1VCbVRBR2lXTWtFcnFhZzY3QUFQaERY?=
 =?utf-8?B?UitGYTJUOVpTQktRRk95Y0lGSWF0MzBPWFI3L3Y3T1doZGFrc3FLSjNvdGNz?=
 =?utf-8?B?azQzTEhwVTFiMmVoVHlhU3QzZWVIY3ZYUjZrZ0dhM2hrb1JOeXg3azJudFlM?=
 =?utf-8?B?NWpjWHVSSWQ0UkJBMzZpUmlLbHRIWWYxMmxGUWJCT2piMHFZWkVyZjg2d3ZT?=
 =?utf-8?B?OXpxR1BQb3Q4U3FhZEJJSWhZN3RlaW9lUmhlK3F1ZkM3UjhNRHhvU3I5V1p1?=
 =?utf-8?B?QjZYMzVCSFNrQ2JMUGlpcUw1SFRlV2ZONUJ3NXJnUTF1dTh4SXlON1Y1U0F1?=
 =?utf-8?B?NmZRSURkY0ZadE0wRnlmcXcxcVlsdHJlV21kMHlQWEJUNTB1eXRUR1MrZ2RX?=
 =?utf-8?B?Q0wvMFZ2ZUJkL0R1cy8wcm5vVk04clpVbHgrTkxxUEEwZkhzV1R1dDdEU3Jo?=
 =?utf-8?B?WDRWdkQ1UUhydUk1emZpZ3ZIZ1hwdUgwdjRNMVlHb0R1bHZjbjFWRGdHcWVk?=
 =?utf-8?B?QStwUnhtTWpoWFF2VnJ3SlVwOEkzN1EwTExzZk5BN1I1b2RsVC9zcThYRzFl?=
 =?utf-8?B?Vm0wY3RRWUNCcWtJajRKcGxRNHRvamoxVEo3RHUyMnY0VlhONUYxVVhFaERR?=
 =?utf-8?B?eXRyMHJiOXVSb3ZUV2ZvZHVXZjExVmhmWm40SzF1Umw0ME9kUFRTKys1d2tI?=
 =?utf-8?B?YXc4RWp0RXFWK2NIb2JIQkNxWFpUMk52Rm82NzgvYnByT3pTamc1Q0YzUFVJ?=
 =?utf-8?B?TWE1Q0FsVFhUM2U0NzdFTEMvdmIwMElQWHNab2lHZnJYeVBwSDNSV0dzZjJp?=
 =?utf-8?B?R25EN3kwSFExd0d3Z2d6VjlrbkNYbldYOFNKbFFnemRveTluQ3c1SWlJTTJS?=
 =?utf-8?B?cWVrSGx2R0pzY0hPNHZRcFQ1a0hadXMxVk5CaHZ4Z21MRWlrdXJxeDBWRDN5?=
 =?utf-8?B?NE5ET2g5c0RkZzQvSXcxN1VGYkZJekt0RkZBVFFmMTVTWk5zQTJQVVdDVVJi?=
 =?utf-8?B?eGxaekxUTmUxcTI3SkdlYVdqN0pZb1ZVT2poUkpmcHVMb0QvUDV5R1FSUFlB?=
 =?utf-8?B?VVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <60ECF3404F3D2542A39D96E17E16158E@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5987.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a34ddf45-bdc3-4762-d06c-08dbe5fc841b
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2023 17:01:31.3404
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TLQ4G4RekbpTNRCCpwCLKENAZVi6YKbujI+AlemORSq1smJcvdZWHUcyqVx0simhEfzkkQVwZLoj7xWOLlVyMBcazV9c2BLgAyMjr1VD0t8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7655
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

SGksDQoNClRoaXMgY29udGFpbnMgc29tZSBuZXcgYW5kIHVwZGF0ZWQgZmlybXdhcmVzIGZvciBh
bGwgb3VyIGN1cnJlbnRseQ0KbWFpbnRhaW5lZCBGVyBiaW5hcmllcy4NCg0KUGxlYXNlIHB1bGwg
b3IgbGV0IG1lIGtub3cgaWYgdGhlcmUgYXJlIGFueSBpc3N1ZXMuDQoNClRoYW5rcywNCkdyZWdv
cnkNCg0KVGhlIGZvbGxvd2luZyBjaGFuZ2VzIHNpbmNlIGNvbW1pdCBiNzJlZWI2MDM5NTBmMzlm
MzIwYzgxMTNlNTZkNjljYmNmZTJjYjQ0Og0KDQogIE1lcmdlIGJyYW5jaCAnbWxpbW9uY2kvcm9i
b3QtcHItaW1wcm92ZW1lbnRzJyBpbnRvICdtYWluJyAoMjAyMy0xMS0xNCAxMjo0MDozOCArMDAw
MCkNCg0KYXJlIGF2YWlsYWJsZSBpbiB0aGUgR2l0IHJlcG9zaXRvcnkgYXQ6DQoNCiAgaHR0cDov
L2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC9pd2x3aWZpL2xpbnV4LWZp
cm13YXJlLmdpdCB0YWdzL2l3bHdpZmktZnctMjAyMy0xMS0xNQ0KDQpmb3IgeW91IHRvIGZldGNo
IGNoYW5nZXMgdXAgdG8gYTA3ZmQwYjk2YjVhZGZiNjYxNGYxMWNhMGJkYjVhN2Y1YjQwNDEwZToN
Cg0KICBpd2x3aWZpOiBhZGQgbmV3IEZXcyBmcm9tIGNvcmU4My01NSByZWxlYXNlICgyMDIzLTEx
LTE1IDE4OjMwOjU5ICswMjAwKQ0KDQotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQpDb3JlODMtNTUgZmlybXdhcmUgcmVsZWFz
ZQ0KKiB1cGRhdGUgbGVnYWN5IGZpcm13YXJlIChjYy9RdS9RdVopDQoqIHVwZGF0ZSBuZXcgZGV2
aWNlcyBmaXJtd2FyZSAoc28vdHkvZ2wvbWEpDQoNCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCkdyZWdvcnkgR3JlZW5tYW4g
KDIpOg0KICAgICAgaXdsd2lmaTogdXBkYXRlIGNjL1F1L1F1WiBmaXJtd2FyZXMgZm9yIGNvcmU4
My01NSByZWxlYXNlDQogICAgICBpd2x3aWZpOiBhZGQgbmV3IEZXcyBmcm9tIGNvcmU4My01NSBy
ZWxlYXNlDQoNCiBXSEVOQ0UgICAgICAgICAgICAgICAgICAgICAgICB8ICAzNiArKysrKysrKysr
KysrKysrKysrKysrKysrKysrKystLS0tLS0NCiBpd2x3aWZpLVF1LWIwLWhyLWIwLTc3LnVjb2Rl
ICB8IEJpbiAxNDA0NzQ0IC0+IDE0MDQ4MjQgYnl0ZXMNCiBpd2x3aWZpLVF1LWIwLWpmLWIwLTc3
LnVjb2RlICB8IEJpbiAxMzIyNDc2IC0+IDEzMjI0NzYgYnl0ZXMNCiBpd2x3aWZpLVF1LWMwLWhy
LWIwLTc3LnVjb2RlICB8IEJpbiAxNDA0NzYwIC0+IDE0MDQ4NDAgYnl0ZXMNCiBpd2x3aWZpLVF1
LWMwLWpmLWIwLTc3LnVjb2RlICB8IEJpbiAxMzIyNDkyIC0+IDEzMjI0OTIgYnl0ZXMNCiBpd2x3
aWZpLVF1Wi1hMC1oci1iMC03Ny51Y29kZSB8IEJpbiAxNDA0ODgwIC0+IDE0MDQ5NjggYnl0ZXMN
CiBpd2x3aWZpLWNjLWEwLTc3LnVjb2RlICAgICAgICB8IEJpbiAxMzY2MTg0IC0+IDEzNjYyNzIg
Ynl0ZXMNCiBpd2x3aWZpLWdsLWMwLWZtLWMwLTg2LnVjb2RlICB8IEJpbiAwIC0+IDE4NDAxMTYg
Ynl0ZXMNCiBpd2x3aWZpLWdsLWMwLWZtLWMwLnBudm0gICAgICB8IEJpbiAyNDYyMjggLT4gMjI2
NjY4IGJ5dGVzDQogaXdsd2lmaS1tYS1iMC1nZi1hMC04Ni51Y29kZSAgfCBCaW4gMCAtPiAxNjk1
Nzg4IGJ5dGVzDQogaXdsd2lmaS1tYS1iMC1nZi1hMC5wbnZtICAgICAgfCBCaW4gNTU1MDAgLT4g
NTUwOTIgYnl0ZXMNCiBpd2x3aWZpLW1hLWIwLWdmNC1hMC04Ni51Y29kZSB8IEJpbiAwIC0+IDE2
NzA5NDAgYnl0ZXMNCiBpd2x3aWZpLW1hLWIwLWdmNC1hMC5wbnZtICAgICB8IEJpbiAyODAyNCAt
PiAyNzgyMCBieXRlcw0KIGl3bHdpZmktbWEtYjAtaHItYjAtODYudWNvZGUgIHwgQmluIDAgLT4g
MTUyMDYzNiBieXRlcw0KIGl3bHdpZmktc28tYTAtZ2YtYTAtODYudWNvZGUgIHwgQmluIDAgLT4g
MTY3OTc4OCBieXRlcw0KIGl3bHdpZmktc28tYTAtZ2YtYTAucG52bSAgICAgIHwgQmluIDU1NTgw
IC0+IDU1MTcyIGJ5dGVzDQogaXdsd2lmaS1zby1hMC1nZjQtYTAtODYudWNvZGUgfCBCaW4gMCAt
PiAxNjUzODM2IGJ5dGVzDQogaXdsd2lmaS1zby1hMC1nZjQtYTAucG52bSAgICAgfCBCaW4gMjgw
NjQgLT4gMjc4NjAgYnl0ZXMNCiBpd2x3aWZpLXNvLWEwLWhyLWIwLTg2LnVjb2RlICB8IEJpbiAw
IC0+IDE1MDczODggYnl0ZXMNCiBpd2x3aWZpLXR5LWEwLWdmLWEwLTg2LnVjb2RlICB8IEJpbiAw
IC0+IDE2MzI0NjQgYnl0ZXMNCiBpd2x3aWZpLXR5LWEwLWdmLWEwLnBudm0gICAgICB8IEJpbiA1
NTQ4NCAtPiA1NTAyMCBieXRlcw0KIDIxIGZpbGVzIGNoYW5nZWQsIDMwIGluc2VydGlvbnMoKyks
IDYgZGVsZXRpb25zKC0pDQogY3JlYXRlIG1vZGUgMTAwNjQ0IGl3bHdpZmktZ2wtYzAtZm0tYzAt
ODYudWNvZGUNCiBjcmVhdGUgbW9kZSAxMDA2NDQgaXdsd2lmaS1tYS1iMC1nZi1hMC04Ni51Y29k
ZQ0KIGNyZWF0ZSBtb2RlIDEwMDY0NCBpd2x3aWZpLW1hLWIwLWdmNC1hMC04Ni51Y29kZQ0KIGNy
ZWF0ZSBtb2RlIDEwMDY0NCBpd2x3aWZpLW1hLWIwLWhyLWIwLTg2LnVjb2RlDQogY3JlYXRlIG1v
ZGUgMTAwNjQ0IGl3bHdpZmktc28tYTAtZ2YtYTAtODYudWNvZGUNCiBjcmVhdGUgbW9kZSAxMDA2
NDQgaXdsd2lmaS1zby1hMC1nZjQtYTAtODYudWNvZGUNCiBjcmVhdGUgbW9kZSAxMDA2NDQgaXds
d2lmaS1zby1hMC1oci1iMC04Ni51Y29kZQ0KIGNyZWF0ZSBtb2RlIDEwMDY0NCBpd2x3aWZpLXR5
LWEwLWdmLWEwLTg2LnVjb2RlDQo=
