Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 237D174206A
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Jun 2023 08:34:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231502AbjF2GeI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 29 Jun 2023 02:34:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230353AbjF2GeG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 29 Jun 2023 02:34:06 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A11761727
        for <linux-wireless@vger.kernel.org>; Wed, 28 Jun 2023 23:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688020444; x=1719556444;
  h=from:to:cc:subject:date:message-id:content-id:
   content-transfer-encoding:mime-version;
  bh=v+wUSa7rCsV4Yj9JUe5xPEtb1IOx1Mm4OupPKzC2GWM=;
  b=IKn+Nd6On44pY2Wy7sVId2iBNx1lJqdxKyo7W3QVVU4QwcvtuNJO8rk5
   xxVT+XamtHoYP0kOvXi3HoWO94XmVAe3NHwnF0n4DFudLANy5Qlrw3vs3
   ZV4MBaYnhXybiOMlejv56PoASg8vUSeoYdocFH8jjPn8o9jmcY1aPbN01
   rt/CIOMD8aV0knpV2NkHcbJpd20HyCLwZmlLLUFj7u8pHQG8rcSpDZktm
   z/PLQDeVEhuR07AHdrDKN0H5vJQNKNzBn4hePnTi3i6WSghaTz0/LlCwl
   yzKct31jnMQRDNiN+HtpczOg4Ywb6prNq4C/vA3VSoXkYzZP13Z48x3kX
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10755"; a="448418817"
X-IronPort-AV: E=Sophos;i="6.01,167,1684825200"; 
   d="scan'208";a="448418817"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2023 23:34:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10755"; a="787276076"
X-IronPort-AV: E=Sophos;i="6.01,167,1684825200"; 
   d="scan'208";a="787276076"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga004.fm.intel.com with ESMTP; 28 Jun 2023 23:34:04 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 28 Jun 2023 23:34:03 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 28 Jun 2023 23:34:03 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 28 Jun 2023 23:34:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cac02RvhvFGfUrDBBvqoaQPxsp0ulKENJ/hxPcx+iP0bh9le6xZBOHLwzXSeLcB5mY/5FolOvSQrdHR+NpF/uZxZ2wszZCCzyLuH4faE7BR/EKPtnG9YWxD/ZZw9VnN7OA+8egFE3o73ZJHw3IrBxTVmdTfwq1iFSPQsLmc+cg3AmP7HrHwAkffycVwpmV3qgMKmAwXv1wJaI/0Gg7NnIBQuY3yz5Pj7c+oGORtzQgGip00ToRhThs2XIiiD6e5H6nOI6Fu+cHyD82x/Pt2izB0mmHkDEH8yt9rF+/o6MIxrWpC0z32wydzpA1zGIYS9OBKislZttxtXkylmgHcJgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v+wUSa7rCsV4Yj9JUe5xPEtb1IOx1Mm4OupPKzC2GWM=;
 b=SV32MOfzDFJaUss6sTr3Zd9dTP1hAMFNb+4RC4FsOs3ngIamkI4V3TZBjjGgKyQu/P9rc8qOfj8jgATriLbpn/hDsw15IdqFb71/PI0uwtaznpisF8jLvplkkmvMQcIKq3iMJO4gw2o4qIBujBDiTA+bOfz6Gq8EAOnyFDLUENw1AuMJSVJZplvH+UgbuTq5gxRmNRVDSpQfnIn0fivGLTpndrn9NvKFbZJS4De1OlePCONGkVUIbmaxyWEusuZkADgwhkCNySsJ4KUoqQsiW+4t6AQW8bYl4/L5lvIJqNoImdE1xWQ6Idn0TINZkQPJ1IMR52V7pN2S62iLy1gVEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5987.namprd11.prod.outlook.com (2603:10b6:208:372::8)
 by SJ0PR11MB5630.namprd11.prod.outlook.com (2603:10b6:a03:3bb::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Thu, 29 Jun
 2023 06:33:58 +0000
Received: from MN0PR11MB5987.namprd11.prod.outlook.com
 ([fe80::557:ad6a:40f:3ef]) by MN0PR11MB5987.namprd11.prod.outlook.com
 ([fe80::557:ad6a:40f:3ef%7]) with mapi id 15.20.6521.026; Thu, 29 Jun 2023
 06:33:58 +0000
From:   "Greenman, Gregory" <gregory.greenman@intel.com>
To:     "linux-firmware@kernel.org" <linux-firmware@kernel.org>
CC:     "Hutchings, Ben" <ben@decadent.org.uk>,
        "kyle@infradead.org" <kyle@infradead.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "Ben Ami, Golan" <golan.ben.ami@intel.com>,
        "jwboyer@kernel.org" <jwboyer@kernel.org>,
        "Yang, You-Sheng" <vicamo.yang@canonical.com>
Subject: pull request: iwlwifi firmware updates 2023-06-29
Thread-Topic: pull request: iwlwifi firmware updates 2023-06-29
Thread-Index: AQHZqlOvCWhlrOKBIki0IUnq+XUO+A==
Date:   Thu, 29 Jun 2023 06:33:58 +0000
Message-ID: <357e342788eaa17c8bb8113812d67c38df3236c0.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.42.4 (3.42.4-2.fc35) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5987:EE_|SJ0PR11MB5630:EE_
x-ms-office365-filtering-correlation-id: 88f6f663-9e7f-4128-1bf0-08db786ad19d
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hr3/FvQehtw8hEVRnxnakxpRvbr1xHByphuyqjQ4ctWqhH6s0ei9/DsaP2QlTSxJ8SUJk9C5h0TsTkAXpRDzICyD0iheNrUtH4O4l8ltWflOyRfR9mk0MQ/bC0AxigDM8pve3LJuNXnbcTIC08x9JkFgLiSwHWP6jpYlLbKcKceCDkqSR6Lry+IgJNp5LrWNsu5S0+PORWw9xTEokeLprLsD8LL+oKW2F1brfnfd0NtSmbNLwt30azbvcPlkDzHS30ytIcB1Sly9WypIxeZRaxR5r/Opj4IKE7eT2hAGs+mGaZFGv0rNz6dubKJzgcde4YkC3lD5Q2+NLfatdvEB+Hfi/y2nzXB2+gzCKu10xv78fgQDxHEfFUmjq4grhtH6keHnTWfRAzotjCOHpbOAFqES28GI2iMD7gcXjuhJwwKY1pjtUGeBtgO7b+shfegeWVfWqiUSpusB3uJgX4/CSAHj3jBtsK9Ea+kgoBJISxUiFqVOSSWUaAp1x8dAMSAE5ZI2Tgk1y0ipMSEzRRgY+rg4ov+PZbks7p4Mv+nIL8LJnpnKHfyyS9anqHZlXcBP3slqTidpdnGDUGjoHO+4fSirVbHSgm1bOVoPb1loydM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5987.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(396003)(376002)(136003)(346002)(39860400002)(451199021)(66446008)(19627235002)(36756003)(38070700005)(5660300002)(64756008)(91956017)(86362001)(8936002)(66556008)(8676002)(66476007)(6916009)(122000001)(41300700001)(316002)(76116006)(4326008)(82960400001)(38100700002)(66946007)(966005)(2906002)(186003)(15650500001)(478600001)(6506007)(26005)(2616005)(6512007)(71200400001)(83380400001)(6486002)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Tm5LU3BzcFJpUlFCRWsrNncwWWo4QVc5TUtqNjJOUk56NUNiNGxvaHlrL2VP?=
 =?utf-8?B?K1RIdkw3YTNjbE43Vi9KbmJ6ZVhZdGNaYUJjaGxvL0RzdGd2aDNNaFFaUW5Y?=
 =?utf-8?B?Q3hkTytiSSs3Z2syN0liN0h6YWZvcmRpUEY5c0Vib3NSQ2dpd2pFQ1F0TUMy?=
 =?utf-8?B?YkFBMjFzamp2bVo0MS9kZVlpT0xIL1dRL0FQaG1QUUlUVzZMSzZ2NkUzSkVZ?=
 =?utf-8?B?enVnWUZVRUNGa1drRXRUcWUwNCt2ZFBDWVVHdjA2aHRGUW95MEswZndvcjJv?=
 =?utf-8?B?VkFnMjBPaTd0QWNpRVdDMjZTb3BGVk8vK01WdkJMRUZnMmN4bFd2b1hJQWZ0?=
 =?utf-8?B?YXVZa01qekRtYXEvVVhQUFhkS2tiODNTVHoyNTdSK1FCY05QSEhYM2pHNFR4?=
 =?utf-8?B?UjRlRjVBcGRENFJBN0pUUHVhUWRmYVB0VUR1ckpUZGdwd3VrVDQyMDhzQU5E?=
 =?utf-8?B?V3dXUGxZNDlZQzNVODNGb296ektaQXp6ZHpld3J5MTZJdUtLMERWcDNtaGZQ?=
 =?utf-8?B?M2dJeFNWMS9VOHZYelpxR28vb291OEVWVjFieDNNdytjZFpxbzRFWVZZSFJQ?=
 =?utf-8?B?S1ZyMUUwK2o4blJDcXJ4OTlYVkZZY0dBbDhZcHVrRHpBemVqNGRuS3NRSnlJ?=
 =?utf-8?B?QkxwbFBYNnBQeHNLYnUxUGlmNlZnd2wyVzk1TFcwWk42NFJrVk85cm4xOVZZ?=
 =?utf-8?B?K0FqWjRYZVFmMlFDZ0ZBejdEQzVPdkpDN0lKK0lrQ0RJb3lteERhdmIrazY4?=
 =?utf-8?B?aUlmQzRJdGFnMmY2TUt2cUllOGxnRExVdDJhQTF3NHk4cExGc1ZHMmEyYlhy?=
 =?utf-8?B?M1N2REdLMXZiTHVmWlpOWEpPaHMwTXc1b1NJTTRTNkhRK3VPZzhnSmF1NEdx?=
 =?utf-8?B?Mm5jZ3NUdTJUb2hHc1ZaU2tLWFh0N09raXdxL1VEZUFFQ1ZQUitiNndtdlg2?=
 =?utf-8?B?bWpxN2lUdE5qcWdqSklZSDZQbEVCRFhYZnlpWkVHdmpnWUhPTll6T3RjODlJ?=
 =?utf-8?B?T3RzQlhmQXRjMXVoMEZRQnZkUUlJcGhNNGEzN1JReHEzSWNyQ1lwcWphVXRq?=
 =?utf-8?B?ZW5ScTV4OXQ1dDdqZ29yYUQwR0FPZVNUR2ZyTUl4ZlhmcHMxL2ZWNFkwVDU1?=
 =?utf-8?B?b0RKWk42VEdydDF2TzJrNWtNZHJKWGdWQythazNIWk5BTTBBWU91c0M1MWJU?=
 =?utf-8?B?OGtKS1MyQkZDcFQ3enhBNUZOTGhDRUpsdUV0TG5pUXRRS09ETHdFVkJRUGdG?=
 =?utf-8?B?L1NDZjc4aHNXcGszaEVLZ1o1akR3QjBHZ2xKa3E0b0hrTThjVitscmp2YlNQ?=
 =?utf-8?B?WmZVUUltYzlwb3NidUVhUE82c1RiNzN5dFY4UTlHS1orcm1CbVhxSm43b3ZM?=
 =?utf-8?B?L3N3TzI1ekFKUnpnVFRRNEljZE93MkVCNDNhdWxFM1lIWWpabnhpQkRROE5B?=
 =?utf-8?B?ZWxRZGt1M2tGcW5QRFZydktGWUdTcExIaEhtTk1wdkxDeEJsVzJXMFNIMjdK?=
 =?utf-8?B?N2ZOdWpEUU95cnlST0RPVVdBR2VpR00rL2lNVWYzeDFyOUZXVnNDbDBFMkFF?=
 =?utf-8?B?Y3VEMit3Z2Y5M29sN3FtZUhHVGRoWHM3clZJMm9MMExzUXpnNHVyemp4VmVV?=
 =?utf-8?B?ZWJUWC9tdVZSTnE2V0d5ZjNGODdSSHVoRVRZS24xYTRvWlBGcEd2OHA1STJE?=
 =?utf-8?B?MVh6N0pteXZ1RlhINStKZjBBcDhsb2lCTFlwV1liRGRrNHdrSGxlaDBzckI5?=
 =?utf-8?B?djFZZ29FdVJZNmhXNUtHcmtjdlozMHd3bFphaUFrWER1elFoTnpFUi9CSiti?=
 =?utf-8?B?MW5YVGN1QmFSZEJqSnlZV2pnUFJ6MGhHUWFWcEYzd3NFMWxHekZ2YmdqT3JY?=
 =?utf-8?B?VzNqc0hQbnY1Uk50RDRIUU16K3dmc2phQmdSR2graUY2MzFidWFLZFNmQVVZ?=
 =?utf-8?B?TjBtNTFnZHNYdFVFcHA2M1hRa25kVXo1bVBCMk5yUHpmbnJIbFlPNnNZRGpG?=
 =?utf-8?B?ZEJIZGtuTFhhUCtxaWt4aHo2NklFbUt1L1hqckRYdFhtblhRUXAxM3FhNGlq?=
 =?utf-8?B?TjF4V0hWSkV2UW9qcUF4cVh5cHBCb1MvVmN1RHBpTXA3bXBVMngzaGd2RDd6?=
 =?utf-8?B?UWkrVXBzV09TYVBiYmNpcjN5QUI5dzZJRWZzNUF1Y09iTmg5TUVISUtlOXhq?=
 =?utf-8?B?Nmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8DCB60DC09521B4DB0E028404061E56F@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5987.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88f6f663-9e7f-4128-1bf0-08db786ad19d
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2023 06:33:58.1477
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t8EiKRNo6sMr2o38NwMQT2RyZvaDlWtG0KU97Bx4vdyNccFNYUcKmKWL8qstQRDYN3uZ5QGIgMbI/YbTjJ8DXLVF/EYdPF7WtlCWkH1mqVw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5630
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

SGksDQoNClRoaXMgY29udGFpbnMgc29tZSBuZXcgYW5kIHVwZGF0ZWQgZmlybXdhcmVzIGZvciBh
bGwgb3VyIGN1cnJlbnRseQ0KbWFpbnRhaW5lZCBGVyBiaW5hcmllcy4NCg0KUGxlYXNlIHB1bGwg
b3IgbGV0IG1lIGtub3cgaWYgdGhlcmUgYXJlIGFueSBpc3N1ZXMuDQoNClRoYW5rcywNCkdyZWdv
cnkNCg0KDQpUaGUgZm9sbG93aW5nIGNoYW5nZXMgc2luY2UgY29tbWl0IGVlOTE0NTJkYWM1YWJm
YzRjNWI5ODI3Y2Y1NWU3MDFkOGMwY2E2Nzg6DQoNCiAgTWFrZWZpbGUsIGNvcHktZmlybXdhcmU6
IHN1cHBvcnQgeHovenN0ZCBjb21wcmVzc2VkIGZpcm13YXJlICgyMDIzLTA2LTI1IDEyOjE4OjU3
IC0wNDAwKQ0KDQphcmUgYXZhaWxhYmxlIGluIHRoZSBHaXQgcmVwb3NpdG9yeSBhdDoNCg0KICBo
dHRwOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L2l3bHdpZmkvbGlu
dXgtZmlybXdhcmUuZ2l0IHRhZ3MvaXdsd2lmaS1mdy0yMDIzLTA2LTI5DQoNCmZvciB5b3UgdG8g
ZmV0Y2ggY2hhbmdlcyB1cCB0byBiMjU1ZjViOTI5OThkMDI3N2YxMDY4ZTY5NzY4ZTNlNzBhYWU1
MjEwOg0KDQogIGl3bHdpZmk6IGFkZCBuZXcgRldzIGZyb20gY29yZTgwLTM5IHJlbGVhc2UgKDIw
MjMtMDYtMjkgMTI6MTg6NDIgKzAzMDApDQoNCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NClVwZGF0ZSBpd2x3aWZpIGZpcm13
YXJlcyBhY2NvcmRpbmcgdG8gY29yZTgwLTM5IHJlbGVhc2UNCg0KKiBmb3IgY2MvUXUvUXVaIC0g
dXBkYXRlIHRoZSBleGlzdGluZyBmaXJtd2FyZXMNCiogZm9yIHR5L3NvIGFkZCBuZXcgZmlybXdh
cmUvUE5WTQ0KDQotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tDQpHcmVnb3J5IEdyZWVubWFuICgyKToNCiAgICAgIGl3bHdpZmk6
IHVwZGF0ZSBjYy9RdS9RdVogZmlybXdhcmVzIGZvciBjb3JlODAtMzkgcmVsZWFzZQ0KICAgICAg
aXdsd2lmaTogYWRkIG5ldyBGV3MgZnJvbSBjb3JlODAtMzkgcmVsZWFzZQ0KDQogV0hFTkNFICAg
ICAgICAgICAgICAgICAgICAgICAgfCAgMjEgKysrKysrKysrKysrKysrLS0tLS0tDQogaXdsd2lm
aS1RdS1iMC1oci1iMC03Ny51Y29kZSAgfCBCaW4gMTQwNDY3NiAtPiAxNDA0NzA0IGJ5dGVzDQog
aXdsd2lmaS1RdS1iMC1qZi1iMC03Ny51Y29kZSAgfCBCaW4gMTMyMTkwMCAtPiAxMzIyNDM2IGJ5
dGVzDQogaXdsd2lmaS1RdS1jMC1oci1iMC03Ny51Y29kZSAgfCBCaW4gMTQwNDY5MiAtPiAxNDA0
NzIwIGJ5dGVzDQogaXdsd2lmaS1RdS1jMC1qZi1iMC03Ny51Y29kZSAgfCBCaW4gMTMyMTkxNiAt
PiAxMzIyNDUyIGJ5dGVzDQogaXdsd2lmaS1RdVotYTAtaHItYjAtNzcudWNvZGUgfCBCaW4gMTQw
NDgyMCAtPiAxNDA0ODQwIGJ5dGVzDQogaXdsd2lmaS1jYy1hMC03Ny51Y29kZSAgICAgICAgfCBC
aW4gMTM2NjEyMCAtPiAxMzY2MTQ0IGJ5dGVzDQogaXdsd2lmaS1zby1hMC1nZi1hMC04My51Y29k
ZSAgfCBCaW4gMCAtPiAxNzM5OTg4IGJ5dGVzDQogaXdsd2lmaS1zby1hMC1nZi1hMC5wbnZtICAg
ICAgfCBCaW4gNTYwNDggLT4gNTU1ODAgYnl0ZXMNCiBpd2x3aWZpLXNvLWEwLWdmNC1hMC04My51
Y29kZSB8IEJpbiAwIC0+IDE3MDM5NjggYnl0ZXMNCiBpd2x3aWZpLXNvLWEwLWdmNC1hMC5wbnZt
ICAgICB8IEJpbiAyODI1MiAtPiAyODA2NCBieXRlcw0KIGl3bHdpZmktdHktYTAtZ2YtYTAtODMu
dWNvZGUgIHwgQmluIDAgLT4gMTY4MzA3NiBieXRlcw0KIGl3bHdpZmktdHktYTAtZ2YtYTAucG52
bSAgICAgIHwgQmluIDQxODc2IC0+IDU1NDg0IGJ5dGVzDQogMTMgZmlsZXMgY2hhbmdlZCwgMTUg
aW5zZXJ0aW9ucygrKSwgNiBkZWxldGlvbnMoLSkNCiBjcmVhdGUgbW9kZSAxMDA2NDQgaXdsd2lm
aS1zby1hMC1nZi1hMC04My51Y29kZQ0KIGNyZWF0ZSBtb2RlIDEwMDY0NCBpd2x3aWZpLXNvLWEw
LWdmNC1hMC04My51Y29kZQ0KIGNyZWF0ZSBtb2RlIDEwMDY0NCBpd2x3aWZpLXR5LWEwLWdmLWEw
LTgzLnVjb2RlDQo=
