Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE77A7A9FA0
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Sep 2023 22:25:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231786AbjIUUZe (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 21 Sep 2023 16:25:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232284AbjIUUZO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 21 Sep 2023 16:25:14 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C709B90F25
        for <linux-wireless@vger.kernel.org>; Thu, 21 Sep 2023 10:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695318447; x=1726854447;
  h=from:to:cc:subject:date:message-id:content-id:
   content-transfer-encoding:mime-version;
  bh=yk4thS+B/lrBcn20upbQ9nqjYjMLLJt7oabl9ryG7fs=;
  b=GpaPyEO5E00NVSet2R+RQpbDMXSjtSK7j+QXCZW4pCbIHw9FNbgLKpa+
   bosdCym7kS0uQkFShmX9rd00d28gCycqWu2dljRuJFVW7Wh1fkOpVqdZV
   xkc6TgsBTT4/FQz3dT13QbJNz4FcPY75/dGek8vtr+Z+QbBllF+MPVJv8
   j/Fecj+3Ab4nfU+NgkVyD4e+4NF13zb5AjHLHAOBMMqv8/7ozeKl+McG9
   kZx58iOS/nUGovbsDFDFd2gpiZxLsf9VtWXLhHpw2KhgcLgOeYqR/+oA1
   YI1F+3ex040n5LCagzgn/3MJ6oQ/VMZSsVsbozNeQXOPgRXH8fSYdfPnE
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10840"; a="377840094"
X-IronPort-AV: E=Sophos;i="6.03,165,1694761200"; 
   d="scan'208";a="377840094"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2023 08:07:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10840"; a="837323307"
X-IronPort-AV: E=Sophos;i="6.03,165,1694761200"; 
   d="scan'208";a="837323307"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Sep 2023 08:07:31 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 21 Sep 2023 08:07:31 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 21 Sep 2023 08:07:31 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.172)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 21 Sep 2023 08:07:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jeb4mz6GLLkCc0HxawlbnhSePcbeNsaTOxuAEjJdUFPNDw7uM4LmzKk4gS55sHmXGxStd2HDcT8Gii1hyreV4WHjMAs21PWtVKS4Zfze9+F3Z2SyIKvM/dgl/30rsI7XUpT7DWZFDsmMGbES1w8UU9xCzWwvF0V1BBWEdi0EKbph1EIkdc33sny0eLw/cASZhyv/vP6ne3uUNKT2IP/T4dbfosxYjTlhGYQm/mpiJFQClGPGbIoOfhartMryzAcr7zXX8/82+DpWouwoA+qJr6d8I9i2EHqwXZk9KqeXdwj9yqUWqBTB0zRx79FLVsRGkEsUpVJydPBLlZ4t+YAz5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yk4thS+B/lrBcn20upbQ9nqjYjMLLJt7oabl9ryG7fs=;
 b=JxMa9f+TwcANpB33MSfuAVz1YZ3d6j1i5NOz3zuTTiYfX9gD/3iyCSiqC9Iewy88hs2JweHgawaJLBYEGsW6PUdqBNYE8tKI76dRiXLrWMRPNbrMeBESKrkzr8nYmQTWUrc8NwSYuKyfE9lYd3h7UUqoA7QLdkO8JdLWurBuuuzwwZlZG9rH+8yZwBhcWF00bxwfYvgLIHInEkxVaiOE/WSurUgv59GX6ATIYFT0bTAmW53RKzB26vO1HHIoFBmxgogbL7EiuGJnlwXDxQd7PS7ITe1LTVgtLpwJhBtcW0hIrSL1VNQVfs0hG98gwj+Lh6ISBEhWZ7arFbMyr2727g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5987.namprd11.prod.outlook.com (2603:10b6:208:372::8)
 by PH8PR11MB7070.namprd11.prod.outlook.com (2603:10b6:510:216::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Thu, 21 Sep
 2023 15:07:26 +0000
Received: from MN0PR11MB5987.namprd11.prod.outlook.com
 ([fe80::fe36:eb09:813b:5e01]) by MN0PR11MB5987.namprd11.prod.outlook.com
 ([fe80::fe36:eb09:813b:5e01%4]) with mapi id 15.20.6792.026; Thu, 21 Sep 2023
 15:07:26 +0000
From:   "Greenman, Gregory" <gregory.greenman@intel.com>
To:     "linux-firmware@kernel.org" <linux-firmware@kernel.org>
CC:     "Hutchings, Ben" <ben@decadent.org.uk>,
        "kyle@infradead.org" <kyle@infradead.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "Ben Ami, Golan" <golan.ben.ami@intel.com>,
        "jwboyer@kernel.org" <jwboyer@kernel.org>,
        "Yang, You-Sheng" <vicamo.yang@canonical.com>
Subject: pull request: iwlwifi firmware updates 2023-09-21
Thread-Topic: pull request: iwlwifi firmware updates 2023-09-21
Thread-Index: AQHZ7J1UQ1pgZELqIkKBAjT8f4QSFQ==
Date:   Thu, 21 Sep 2023 15:07:26 +0000
Message-ID: <692109191855dc0faebcf2aa710b8ef8e83dfcdb.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.42.4 (3.42.4-2.fc35) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5987:EE_|PH8PR11MB7070:EE_
x-ms-office365-filtering-correlation-id: dc369728-e661-4bb3-3f15-08dbbab4775f
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ax4JB0iA/Cnlh8XcDlemlV12rY4J23EmkKVQgtQMXnFYTdzeZDSpq4L88msMRsY3BWGYfv9C8gHtjEMj4udKcLWDO8paWVItKhJi5vQPcyvnX/+BwzO3VQnqEOOzPyOa2J21BTAEs2Bk1C8X83r4SQ62IifWxmDg6tZSisrZKoinl5BrDLYgfsEw/2bp9STYFmYqdH2mZbM1Bi/5slDiAylnxrshUK1RBo5jDRZrbBb3gNYmZZAhIGX24ISfa9hVsAp3TmrNrNVqXwFwFEPpwNR9KcIAcRZ9Cqc/7DhKqcQI/lTwU6oGh9E2DgemgfVXYxcsFFg92BqtLyvFqG2/wEqoNybQEANTLfpqWgsOpHuAvNLBWlGbE5suxSfEXMVnhFJGfGEOExg7GjeXOAVqod22ntBBHbspW8ji6gpMMc5gXlOQPzd2/Ze1OSQ6giewzBnQqIwXJhTCkOOXyU7Ju/PwisjfEiFEfWZ17JMyhZVRqzqInaEoHHvLFZiBjdhzo7wJMw69ky8oBKumaCD8qoSPirA2feSpksWoinABRdNT/LxROlju7K7ZYvZxkyOkjbvlRgKWt+1AKrxVmefgerZNMP9dFgM2zZmvipByd1s=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5987.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(39860400002)(376002)(396003)(366004)(1800799009)(186009)(451199024)(6512007)(6506007)(6486002)(2616005)(26005)(82960400001)(4326008)(8676002)(5660300002)(8936002)(15650500001)(2906002)(66556008)(41300700001)(6916009)(36756003)(54906003)(76116006)(91956017)(316002)(64756008)(19627235002)(66476007)(86362001)(66446008)(66946007)(122000001)(38070700005)(38100700002)(71200400001)(966005)(478600001)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cURKZ1B0aS9Lall3MDFDMmdZTk9JT0pHR09FYkRTd0k3aVZLZklFRFJPM0gz?=
 =?utf-8?B?U3Y1Z3RieGpIYisyR3V0UHNnRURkL3pMS2tsaURjN3NuWXBzdlh0TlZqdjl3?=
 =?utf-8?B?Y0FWTjdEaVlCUThZTVhXSk4vZVlZWDVVN3lIL3RGaG1qVFJYdEJUNkdyVW5w?=
 =?utf-8?B?b0Z3SzdkQkV3c2dMOFFDK0pGcElzOVRPL0tZOGJtbnJoV1pvT1haVkEvQ3lO?=
 =?utf-8?B?SFJHbVRwajZCQm42NlRTZXlLczhWTlBVeHRTSFh5MmcxMW13Q2MzbG80NFRN?=
 =?utf-8?B?OE11a2p3bnJsdmo5S3hwQWlqM0tvUGs1eStFUmw4eUNkVEVZcmVUL3lUVlFy?=
 =?utf-8?B?VkFqbWttejJOYlMxTXlzNUFFZEVPRzNZbU02NVFZUUw0YzVJMHZYdTBScUpF?=
 =?utf-8?B?QjBjd2Q4WUpSdmJHZEdkU2FueVhKMGEzZ3ZiZ0VqNnVQRXV3dGtkOG9XL1dN?=
 =?utf-8?B?Z3F5aTRmS1BtUkEwSmxzZzBHaVZ5Q1ltYkNvWG5iV2N2akZ2L0ZnM2VNMGZB?=
 =?utf-8?B?N1BhY3h5YnU2SWxvWTVsajVZbG56MS8wdGM1Qmx5UlZyUk0vQkhYRjJuTXl1?=
 =?utf-8?B?TlhOZ0VNeVNuVTc1RUtzcUdieW1DMDNxdGxXUTRGT2ZpOTdRYjE1MHgxcDRx?=
 =?utf-8?B?Wis2Smdjd1RKTWRPSTJKeHRxdGxaaEQvV1pxRU4rSDlLVGlNL2Y2K0V5V0w2?=
 =?utf-8?B?ZzB0VXpsRWlXVkVKSDdEMmV6VlRNY0hCTkwxdlpNUEdSb1JuVlVXait2dzJj?=
 =?utf-8?B?dDZyZkY1YjhSek9ROFdHVlY0Y2VKc1k2bGFUQU5MSTVlbDRrT1JlWHVBVEpD?=
 =?utf-8?B?TEJSTzNHT2xRWXpVcVNEYkNtbkpLY2FHbGpUV2lCN2xZaHhyamxkK2o5TDN0?=
 =?utf-8?B?cElRR0UxMVVGaEhCYWI5WmN1WFFjMzFpbEN3amVCeHRRck5BVWRuVk9Xb21s?=
 =?utf-8?B?aTYvZDZibU56RjEvNnZEaEpXZWQ4TXp6aDg2MnMzMWhqZmt5YXBnYzBMbTRE?=
 =?utf-8?B?ejRUZTRtNkVPa295WEhLc1orWEtVUHRuK1o0dkR0WVpXSy9aZXRXbE5XVVVj?=
 =?utf-8?B?Nk84OXFFTzl3RFJ1bytJV2djVWp5WWEyM0luWDVGWjUrN0dxWnI4K3JoTWJ0?=
 =?utf-8?B?R01IbnpzTnF5NWZ6dVEyL3RabTZ2djF1MzFkY0dsai9zalUzOWdVMy9PQVVT?=
 =?utf-8?B?SlliM1dkdDZ2M0FzMTJaWHFHMk1yZXBEUEd1VUhvbU9ETW1manNiM28zcWtX?=
 =?utf-8?B?SkE0RU11aUNRcTVrb201UGcrYjdkWXFqQVZ2Y3BKRml2Z0luU2xWSnVCQXJq?=
 =?utf-8?B?enl0dTJKazFvZ0k1WmlhSHNOYmRXSG5jaGtCakVhWkxoOWRoR1ZMdlNUM1Az?=
 =?utf-8?B?dlozYlMvLy9mWFp3VWVEb2lGSDljRmpPZkg5RGhBYm54QjkzaVQ2ZXNpMll1?=
 =?utf-8?B?eXFuSW9mTDJFZ0RkeVpmWXMxb3NRRVI4Ty82cnkvZDdNRlNYUFlNYXgyL092?=
 =?utf-8?B?SGRhN1owL09IQndTUHFDS29ybUQrcTVDZ3BDZzJXU2Nva2luNGpsZEhqMi91?=
 =?utf-8?B?a2tybUV4VksxT2pETWhFNlpDTDhKV1dwTSs2d01aZG9GTk9QTXc4K2pjMVRo?=
 =?utf-8?B?azRDYnlWZW9QQlI4dnB5NVA5bXk5Ymo1a0IxOGl5czdDVU50d3dPYnZHOXZG?=
 =?utf-8?B?dHVGTmMrZFAwUFd4SlV0Qk5MMTZYK3MxSklrNmpEQmE5S3gyOS8wNTVHS0c5?=
 =?utf-8?B?SURyQVgzZllqZjFRYmZEVThhMEtmYWFJVW5MTW9tUnJtOEdEc0M4OFBvdFFz?=
 =?utf-8?B?UkMzOFNMQ0IrZVp0bHJzWmIrYTdCckNteWxwb28vRCt3bHV6aVJWVTBQaW1H?=
 =?utf-8?B?R0ExT3lSaS9ldzNjaXdRbWFFc3pIWHhGWHNlM1VFcWRQVTdhbkRPUUwydjFG?=
 =?utf-8?B?VFRWT242SXJITFRUSG1UUmJMMnVKMGRya2dhL3Jqck1oYUt6cndCRjZlc0FR?=
 =?utf-8?B?K0hTRHBpaTdST3FiQUVCeTdTYnRGL3UvVWhEdncwRkhvWWNSay9rU3p3Slpm?=
 =?utf-8?B?MUwrbStnQ1I2VmtRUXZIdklWelVqQU9hVUFrdGo1REhYWDF4Rk1QalhnM0tl?=
 =?utf-8?B?LzBkK09INlo2ekJxRDlHU2VwVk5FWjFUME4rSURlbVF1QnpiVkdNV1kxVDBI?=
 =?utf-8?Q?c0arPFftkDh4RX66pdn1k7o=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C4113912CB693C45BA3F4712DD471F30@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5987.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc369728-e661-4bb3-3f15-08dbbab4775f
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2023 15:07:26.2480
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PM8V0xS6GszaQu5i71Yg5yzrdD+FedoM4Lvqr3Do5tVcsjBm4OqMGWGwTDr85FtmiovjzENa1xpLk9JnIhXQAaq2hybd1Gz7VNAXSCUpaHg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7070
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

SGksDQoNClRoaXMgY29udGFpbnMgc29tZSBuZXcgYW5kIHVwZGF0ZWQgZmlybXdhcmVzIGZvciBh
bGwgb3VyIGN1cnJlbnRseQ0KbWFpbnRhaW5lZCBGVyBiaW5hcmllcy4NCg0KUGxlYXNlIHB1bGwg
b3IgbGV0IG1lIGtub3cgaWYgdGhlcmUgYXJlIGFueSBpc3N1ZXMuDQoNCi0tDQpUaGFua3MsDQpH
cmVnb3J5DQoNClRoZSBmb2xsb3dpbmcgY2hhbmdlcyBzaW5jZSBjb21taXQgMzY3MmNjYWI5MjM3
MzE1ZGIyZjNhMjhhNDdmOGFjMTA2MmE1YTM1ZToNCg0KICBNZXJnZSBicmFuY2ggJ21saW1vbmNp
L2ZpeC1tZXJnZS1yZXF1ZXN0cy1jaScgaW50byAnbWFpbicgKDIwMjMtMDktMTggMjA6MTk6MzIg
KzAwMDApDQoNCmFyZSBhdmFpbGFibGUgaW4gdGhlIEdpdCByZXBvc2l0b3J5IGF0Og0KDQogIGh0
dHA6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvaXdsd2lmaS9saW51
eC1maXJtd2FyZS5naXQgdGFncy9pd2x3aWZpLWZ3LTIwMjMtMDktMjENCg0KZm9yIHlvdSB0byBm
ZXRjaCBjaGFuZ2VzIHVwIHRvIDc2NTQ5MmI4YjkwZTM5ODVmZTYwYjNjZjhkMzg2NTM4YWEzOGI2
YWM6DQoNCiAgaXdsd2lmaTogYWRkIG5ldyBGV3MgZnJvbSBjb3JlODEtNjUgcmVsZWFzZSAoMjAy
My0wOS0yMSAxNzo1OTowMSArMDMwMCkNCg0KLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KaXdsd2lmaSBmaXJtd2FyZSBmcm9t
IGNvcmU4MS02NSByZWxlYXNlDQoNCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCkdyZWdvcnkgR3JlZW5tYW4gKDIpOg0KICAg
ICAgaXdsd2lmaTogdXBkYXRlIGNjL1F1L1F1WiBmaXJtd2FyZXMgZm9yIGNvcmU4MS02NSByZWxl
YXNlDQogICAgICBpd2x3aWZpOiBhZGQgbmV3IEZXcyBmcm9tIGNvcmU4MS02NSByZWxlYXNlDQoN
CiBXSEVOQ0UgICAgICAgICAgICAgICAgICAgICAgICB8ICAyNCArKysrKysrKysrKysrKysrKyst
LS0tLS0NCiBpd2x3aWZpLVF1LWIwLWhyLWIwLTc3LnVjb2RlICB8IEJpbiAxNDA0NzA0IC0+IDE0
MDQ3NDQgYnl0ZXMNCiBpd2x3aWZpLVF1LWIwLWpmLWIwLTc3LnVjb2RlICB8IEJpbiAxMzIyNDM2
IC0+IDEzMjI0NzYgYnl0ZXMNCiBpd2x3aWZpLVF1LWMwLWhyLWIwLTc3LnVjb2RlICB8IEJpbiAx
NDA0NzIwIC0+IDE0MDQ3NjAgYnl0ZXMNCiBpd2x3aWZpLVF1LWMwLWpmLWIwLTc3LnVjb2RlICB8
IEJpbiAxMzIyNDUyIC0+IDEzMjI0OTIgYnl0ZXMNCiBpd2x3aWZpLVF1Wi1hMC1oci1iMC03Ny51
Y29kZSB8IEJpbiAxNDA0ODQwIC0+IDE0MDQ4ODAgYnl0ZXMNCiBpd2x3aWZpLWNjLWEwLTc3LnVj
b2RlICAgICAgICB8IEJpbiAxMzY2MTQ0IC0+IDEzNjYxODQgYnl0ZXMNCiBpd2x3aWZpLXNvLWEw
LWdmLWEwLTg0LnVjb2RlICB8IEJpbiAwIC0+IDE3Mzc2NDQgYnl0ZXMNCiBpd2x3aWZpLXNvLWEw
LWdmLWEwLnBudm0gICAgICB8IEJpbiA1NTU4MCAtPiA1NTU4MCBieXRlcw0KIGl3bHdpZmktc28t
YTAtZ2Y0LWEwLTg0LnVjb2RlIHwgQmluIDAgLT4gMTcwOTkwMCBieXRlcw0KIGl3bHdpZmktc28t
YTAtZ2Y0LWEwLnBudm0gICAgIHwgQmluIDI4MDY0IC0+IDI4MDY0IGJ5dGVzDQogaXdsd2lmaS1z
by1hMC1oci1iMC04NC51Y29kZSAgfCBCaW4gMCAtPiAxNTQ5MDg4IGJ5dGVzDQogaXdsd2lmaS10
eS1hMC1nZi1hMC04NC51Y29kZSAgfCBCaW4gMCAtPiAxNjc2OTEyIGJ5dGVzDQogaXdsd2lmaS10
eS1hMC1nZi1hMC5wbnZtICAgICAgfCBCaW4gNTU0ODQgLT4gNTU0ODQgYnl0ZXMNCiAxNCBmaWxl
cyBjaGFuZ2VkLCAxOCBpbnNlcnRpb25zKCspLCA2IGRlbGV0aW9ucygtKQ0KIGNyZWF0ZSBtb2Rl
IDEwMDY0NCBpd2x3aWZpLXNvLWEwLWdmLWEwLTg0LnVjb2RlDQogY3JlYXRlIG1vZGUgMTAwNjQ0
IGl3bHdpZmktc28tYTAtZ2Y0LWEwLTg0LnVjb2RlDQogY3JlYXRlIG1vZGUgMTAwNjQ0IGl3bHdp
Zmktc28tYTAtaHItYjAtODQudWNvZGUNCiBjcmVhdGUgbW9kZSAxMDA2NDQgaXdsd2lmaS10eS1h
MC1nZi1hMC04NC51Y29kZQ0K
