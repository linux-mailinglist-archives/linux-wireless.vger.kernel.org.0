Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6600E65DE1A
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Jan 2023 22:09:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239591AbjADVJq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 4 Jan 2023 16:09:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239634AbjADVJp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 4 Jan 2023 16:09:45 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED5541D0D6
        for <linux-wireless@vger.kernel.org>; Wed,  4 Jan 2023 13:09:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672866582; x=1704402582;
  h=from:to:cc:subject:date:message-id:content-id:
   content-transfer-encoding:mime-version;
  bh=xcMUxeAu2QDZiopGaM0TZJ8VwoDp2J+cO7bmII9P79E=;
  b=hlrrEq67ZLmTpTPW+YWX+jb+wTP/LPM4nrqOlbbm8lp0aHLyIp0sVsYY
   WVf6LwfLpK8eMRPUMHror407u1q9nRP/9lE7+LIjyE6Tyb9tJEzpVzdBV
   bkzqMGIW/3BmWgzwE5/pwmC5CGAPPSp6i5o8VY87Hb2YeaXKZbYsZE3QI
   zxhFyGcRjCZ1MFsarJr3jxdeDF7IhDFnVQGB0dZ2pwJSkyO2VD7jp9r69
   HgjrStdWvmnk6IiRnOccSqhR2I8tObHP9E2IDVuGRxgQHnLcNNaFpUyLZ
   cT8J6l5hYoPnPuVZ6xE/7/eGi2TCLNr3o/pmuA/l3Zu5K1e/B0788Lhe0
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10580"; a="384335956"
X-IronPort-AV: E=Sophos;i="5.96,301,1665471600"; 
   d="scan'208";a="384335956"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2023 13:09:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10580"; a="797673319"
X-IronPort-AV: E=Sophos;i="5.96,301,1665471600"; 
   d="scan'208";a="797673319"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga001.fm.intel.com with ESMTP; 04 Jan 2023 13:09:42 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 4 Jan 2023 13:09:41 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 4 Jan 2023 13:09:41 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.176)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 4 Jan 2023 13:09:41 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AkF87VxHhz5EoI7Og4Iy6AA7GGUlCa2RjcQuflInG8AnH5PYVsCxBm6aCdOqYcY8m78xnFne0u0NsRqIe9oYJB4b5hEsLoO9lajY+9tUykPytXdoz+KOzttCzqVdFcv5xjyAxDINvugcXCO1AYF07rXDrtyfKC61a5RATJ24JRNSnFG5upTLZkOFvGnsQK+CsUO3mgOVCYea7RK3yFvhTxwrYPy4w8PB1oZa7bNSvMTD45hD54jaVc3EAiXYFsqVXalHrcr3ynAkecmzPkMk3IkbTW7PV1F3hDxXXC9ycEHrMaZfwiQ9dPWmJR2APCKm3g8aZ9uHipi3WEEh7Saj0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xcMUxeAu2QDZiopGaM0TZJ8VwoDp2J+cO7bmII9P79E=;
 b=g4vyF9tqpFTc5EXbnSIRHmW16D6T5C68LXtX6TqrNweGHKKRPVNvad5p+7Q2VYscOXjpaQBTfJRpniTKBWn3H8NyrGFQr+6TvO6nrVdErmqHwK23uYeSyim9Nr1YE+2uzr3Rp0DRNfrm8j+5SllVo5twJZSr32o28ALSooW5TI16OV+NUFsggjm72WP8p7nUPMZSlEOG7bG7aNfNFoOTstl/RhwrEyofjECAh0bf4A1HTku5j3/fmHnlGpxEWL/C2DMg4H1DzcHp/eF5PcQwnW75btDfkS+6cpo9YOuHKxRukVgHg5FPUTpkt1+jIGlDLM5vLyCmL+97q6JJ5DPcyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5987.namprd11.prod.outlook.com (2603:10b6:208:372::8)
 by SA2PR11MB5034.namprd11.prod.outlook.com (2603:10b6:806:f8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Wed, 4 Jan
 2023 21:09:39 +0000
Received: from MN0PR11MB5987.namprd11.prod.outlook.com
 ([fe80::1c42:3e93:5a97:a280]) by MN0PR11MB5987.namprd11.prod.outlook.com
 ([fe80::1c42:3e93:5a97:a280%5]) with mapi id 15.20.5944.019; Wed, 4 Jan 2023
 21:09:39 +0000
From:   "Greenman, Gregory" <gregory.greenman@intel.com>
To:     "linux-firmware@kernel.org" <linux-firmware@kernel.org>
CC:     "Hutchings, Ben" <ben@decadent.org.uk>,
        "kyle@infradead.org" <kyle@infradead.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "Ben Ami, Golan" <golan.ben.ami@intel.com>,
        "jwboyer@kernel.org" <jwboyer@kernel.org>,
        "Yang, You-Sheng" <vicamo.yang@canonical.com>
Subject: pull request: iwlwifi firmware updates 2023-01-04
Thread-Topic: pull request: iwlwifi firmware updates 2023-01-04
Thread-Index: AQHZIIDbu6PwsFMpYUK8SAT96mbX0A==
Date:   Wed, 4 Jan 2023 21:09:38 +0000
Message-ID: <0f2d6fb13fe09bc7cd0a74d7c57cdbc03f979071.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.42.4 (3.42.4-2.fc35) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5987:EE_|SA2PR11MB5034:EE_
x-ms-office365-filtering-correlation-id: a979a166-8f02-4fa1-6488-08daee97fdac
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CAKe33ZTDdXdO33iW6ZXZtqpfvbFg0xT5U9xNFJ6PO5DA2uZ7Te7gNddINs6OOP1eU7DrLQHdgYqbbTQ/erpnYE8FHBj97l280yiSxI3i5xAjCdTBAlGDbZaHEbjZeALAvYWJ7ubfOMLD3k+D99OUdC8zxu5BPfutRCQ3hR54fh0Rme/FCn3fURF2ApPt1YTkuFQ/LuCe34EjAttoyIiehqjgugqaqKu4U+n79+vQTUwuCqzGEKjghM12QTfxRkgcl30LK0fxWDAn2pMO8lfDE53uu9UsTJMcNZX+GF84Nd6sXFitTBqgxcMzqNPdA92mApnYxA+TASX0EFma2c54uAGNceQIyE8owq5qj6OP35aVWhT+tTcrax+pDGvvMSARqJLxKZWDZ766hhPamQT8LVfNQrpWmP3l6Iwp9eT+zzsBiP40rvlS8ihWbfVcENAQMywLCvoJ232j2iJvG2nDAA1OwuN0H5EQre/AI06Ywi87Gr4pEp2BhA4uWGWHU/5TGsQBxb42n7IbKRTtLnEzZZ0JzywW38sljeB3JDCRMgeZ5Qcdq8soszKAoX5a/VvA1talSc36UoCKFuKokXQaerb/VgQaywwcUzGmzDwecQvQGdPkDa4Z77PiJXR4p+MRfHbsRWTimaN6baRySjoTa8O/WkdtscHHRMHLwEuaLwSarr2kWrMHiSLxtC7fHUoNiSex9EjsF+QE+5MQYGG9G5JdfqVgC0tlcAISen2LNA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5987.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(396003)(366004)(136003)(39860400002)(376002)(451199015)(83380400001)(2616005)(6512007)(186003)(26005)(6506007)(86362001)(38070700005)(36756003)(82960400001)(122000001)(38100700002)(41300700001)(4326008)(8676002)(15650500001)(2906002)(5660300002)(8936002)(6486002)(71200400001)(966005)(316002)(66556008)(478600001)(76116006)(66946007)(91956017)(19627235002)(66476007)(6916009)(66446008)(54906003)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b0xQVFFkalEwME1OaFM5Rlo1L0JuQ0NLdEFLdnhGa1FlSmk2dFhjMEhJS1Ix?=
 =?utf-8?B?aTJlUE5tMGxnTFZDS0M0VDF2cUxPRXEvQ2FZdlI1Z1o2d1doZExQWWRaL2Rj?=
 =?utf-8?B?UHJaNnZLTTdNRythWktNbkVJQkNaVjRucEh3OGNDWEt0bUFHTFdneE5BUHpw?=
 =?utf-8?B?SDZ4MjhTVkxWeXkvYUJHcWZ2MjZtOWpRL0R2M2VJak8vRmFxbG95NzU2am4z?=
 =?utf-8?B?OS8wVDFnRVpnQU5jVFlCQU9JTkFnZ3QyKzd1TjBNVjZDd25FeEZSTlRYZzF2?=
 =?utf-8?B?SGVDUE05SHF1bDdRV0k2NjNBT2VSUzZVcmpSeWFKdXNzeHJBb0FaYXFxSWUx?=
 =?utf-8?B?RGdEMmJOMmJWNlBDaXNzb2dLbkMvQlpXQnowSHJ0dm5ORDF2S2l2ckVmZXps?=
 =?utf-8?B?Z01mUi81S3lSR2VhemFwTXNnSU4zekx2OG5UMXFWUUQxSDNhWndDbi9Jb2li?=
 =?utf-8?B?eURtd0RvVVBtbU45L25ubUhLdGdRcTNjcGdKYVl0K1ZnTUFIMHlVMW5MVjN6?=
 =?utf-8?B?VWhHQUZoSld3NGZvRjhxQ3JPeWNsVy95Kzdlc0M1WE8xTmdOSGNySlByNVpy?=
 =?utf-8?B?WnZReDg4Wis5K0h5RDdpNmdoYVkyZEZqRzJ2SFJEa3JOQlJOYzhtVHBSNUMw?=
 =?utf-8?B?VXhMUTNReTJFZUlBWUFPSFBUVEkvRkxoNmRUSGE2WHUxc1F6aGc3SGhWeGRG?=
 =?utf-8?B?b1E4TnhiT3hsOWxrSmlsOHJJMjlFamlJOXQrTjUxajQ1VjVYSGdTRFBibnd3?=
 =?utf-8?B?RDZnaTVWdmxEdXNZdTF3cDdGeHUyRFdmV1I2SURLdmwxanNhd3M2MFNjb3ha?=
 =?utf-8?B?OGJOdXVsVE1XdFFTaDJDeGR5WWZGQ3RHaVNEMUV1czROSlpPRjRHQUQ2UlBw?=
 =?utf-8?B?VjhvRGdOM25sWENuZUIxVDRkYUZ1WEZHZEsrWUVvUStKM29Jc3h3aDlBem54?=
 =?utf-8?B?bmtnVmZyalRJaVVrckE5ZncwOWluTUlhNkNUMFp6N1RkOG1rRXFJdlNhclRH?=
 =?utf-8?B?RG9aZ1lEampCcDl6eG4zWWEvMnB4SGNEcnFRKzJzdjZ3UEJzeURDdmU0U2pY?=
 =?utf-8?B?MVd5TVphdmkwQnNrUVhodU1kTUJDOWJDTS9TNmk3WWw2VEF1a256SDRCMXFv?=
 =?utf-8?B?VFBwWWVwS1VHVzV3MTVMVnM1VUU1VFNKVDljTk1kNGhmV2R6RXN4M2tTRFVq?=
 =?utf-8?B?NnJacnJ0N0hiL29pYm5aQnh1eHVuRWhDTXpvWXd4dGp2V2g2QVVtb2FWS2tn?=
 =?utf-8?B?RVEvV1lBYjBnWStaR2xrSlpXUndoVnV6eW4xbWh3cE9VUUJKaDI0Q1pmTHl0?=
 =?utf-8?B?Q2tjdzUrV1FvMG9lY2h2WFlramdMRWVncVlBMUNnTXRxYXNLOFpLSXMwYXZL?=
 =?utf-8?B?dHFvbWh2aUw2NmlSQmdLajFaZEsraUE1N2M4RkU3T2YzVzZleS83MUxRdVAw?=
 =?utf-8?B?SW5tMTVqYnRaeEtQYld4WjN4T05YV3ZsVk5HcGs0MXNzcmlRTjB3cURKSUcw?=
 =?utf-8?B?NFp1WW05a1M3Tm9BQ2J1anhLMmd4ZG8xNCtkVHhnOXNtbnhWS0ZaRndvWHJj?=
 =?utf-8?B?K2Y4NEtyU3NIOFRTQ3d3dGVoY2hvbURNQWZYMWJHVld3MVNZeFpCNDVRRlA3?=
 =?utf-8?B?MG50YUFaK0paaVdsSTNvNUF3V2krbE10eVVaOVVlUzE3Vjh5dE0xTFlBdWpI?=
 =?utf-8?B?TTJJVmc3SEU1dGc5T2dSRGhzVVhCZVF5ZTBJNWJVM2R2c3FwWGRmd0tzNWRk?=
 =?utf-8?B?d0dGVi8zT1hRd2tuMlBVdTByaFhvaXJXNWVCTURhVU1kZVZIQXNYK1B2NTI3?=
 =?utf-8?B?RjRLK0ZZOVdsL3JpVktxSDlIam00QURiK3NDRnV5STkwandWY2hnck5Ubkcy?=
 =?utf-8?B?U1FYUW5qQVQ3QkJOMU9CTTVYUXBwTWFVT0VCUWVhWC8wdmpTQWxKWC80S3Jk?=
 =?utf-8?B?YnNFMXpKMFFnQ09PTnZXVGdvSGRsZFRWam83cnhkQ0JkSHhvclBiVFZtNVh4?=
 =?utf-8?B?b0M4cml6U2Y5YXA5Q01jbWo1S0I4UWZOKzVOdXZ6amd5aEprcGdvSTJCRm8x?=
 =?utf-8?B?N0l4Z3p4U3hvRUlyeWoydVVUL2JLZGxzdzZWbldZR0xtUnh5N0lldHZUbXdH?=
 =?utf-8?B?L1FNc2xKQWZGZUs2VzgzWHAwdUQ0Qms2bk5IY1NTRGFhbVRxR3d5aVBlS2Nu?=
 =?utf-8?Q?7dGuy4knT4IY5kR11RIywfY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1446E910C6A4C3478823612234270B6C@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5987.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a979a166-8f02-4fa1-6488-08daee97fdac
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jan 2023 21:09:38.9596
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: suA/lEOXh9p2/XoqioxapqLLPpoUk7cT0T4RrsxJNhDmgDc9C27roOL8E++Z+VepzzmC9xLddvXz23qxMMPUgDKf6BoCrGj7Ryfen1Y7pTg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5034
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

SGksDQoNClRoaXMgY29udGFpbnMgc29tZSBuZXcgZmlybXdhcmVzIGZvciBhbGwgb3VyIGN1cnJl
bnRseSBtYWludGFpbmVkIEZXIGJpbmFyaWVzLg0KDQpQbGVhc2UgcHVsbCBvciBsZXQgbWUga25v
dyBpZiB0aGVyZSBhcmUgYW55IGlzc3Vlcy4NCg0KLS0NClRoYW5rcw0KR3JlZ29yeQ0KDQpUaGUg
Zm9sbG93aW5nIGNoYW5nZXMgc2luY2UgY29tbWl0IDRlZTIwMTQ3OGQzZjA2M2ZkODI5NmQ3NzNh
ZWVhZjBkNzJiZmI4MGY6DQoNCiAgTWVyZ2UgYnJhbmNoICdmb3ItdXBzdHJlYW0nIG9mIGh0dHA6
Ly9naXQuY2hlbHNpby5uZXQvcHViL2dpdC9saW51eC1maXJtd2FyZSAoMjAyMy0wMS0wNCAwODoy
MjoxNSAtMDUwMCkNCg0KYXJlIGF2YWlsYWJsZSBpbiB0aGUgR2l0IHJlcG9zaXRvcnkgYXQ6DQoN
CiAgaHR0cDovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC9pd2x3aWZp
L2xpbnV4LWZpcm13YXJlLmdpdCB0YWdzL2l3bHdpZmktZnctMjAyMy0wMS0wNA0KDQpmb3IgeW91
IHRvIGZldGNoIGNoYW5nZXMgdXAgdG8gZGVmMWUxNjlhN2ZlNTcxZWIxYTBmZDMwNmM4ZmM4ODUx
OTA2YjdkZjoNCg0KICBpd2x3aWZpOiBhZGQgbmV3IEZXcyBmcm9tIGNvcmU3Ni0zNSByZWxlYXNl
ICgyMDIzLTAxLTA0IDIyOjUwOjA4ICswMjAwKQ0KDQotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQpGaXJtd2FyZSB1cGRhdGVz
IGZvciBpd2x3aWZpOg0KKiB1cGRhdGVzIGZvciA5MDAwLWZhbWlseQ0KKiBhZGQgbmV3IGZpcm13
YXJlcyAodHkvc28pIGZyb20gcmVsZWFzZSBjb3JlNzUtNDcNCiogdXBkYXRlIGNjL1F1L1F1WiBm
aXJtd2FyZXMgZnJvbSBjb3JlNzYtMzUNCiogYWRkIG5ldyBGV3MgKHR5L3NvKSBmcm9tIGNvcmU3
Ni0zNQ0KDQotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tDQpHcmVnb3J5IEdyZWVubWFuICg0KToNCiAgICAgIGl3bHdpZmk6IHVw
ZGF0ZSA5MDAwLWZhbWlseSBmaXJtd2FyZXMgdG8gY29yZTc1LTQ3DQogICAgICBpd2x3aWZpOiBh
ZGQgbmV3IEZXcyBmcm9tIGNvcmU3NS00NyByZWxlYXNlDQogICAgICBpd2x3aWZpOiB1cGRhdGUg
Y2MvUXUvUXVaIGZpcm13YXJlcyBmb3IgY29yZTc2LTM1IHJlbGVhc2UNCiAgICAgIGl3bHdpZmk6
IGFkZCBuZXcgRldzIGZyb20gY29yZTc2LTM1IHJlbGVhc2UNCg0KIFdIRU5DRSAgICAgICAgICAg
ICAgICAgICAgICAgICAgICB8ICAzNyArKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0t
LS0tDQogaXdsd2lmaS05MDAwLXB1LWIwLWpmLWIwLTQ2LnVjb2RlIHwgQmluIDE1MTg3ODggLT4g
MTUxODc4OCBieXRlcw0KIGl3bHdpZmktOTI2MC10aC1iMC1qZi1iMC00Ni51Y29kZSB8IEJpbiAx
NDg5NjY4IC0+IDE0ODk2NjggYnl0ZXMNCiBpd2x3aWZpLVF1LWIwLWhyLWIwLTc3LnVjb2RlICAg
ICAgfCBCaW4gMTQwNzczNiAtPiAxNDA0MDQ4IGJ5dGVzDQogaXdsd2lmaS1RdS1iMC1qZi1iMC03
Ny51Y29kZSAgICAgIHwgQmluIDEzMjU1MDAgLT4gMTMyMTcyMCBieXRlcw0KIGl3bHdpZmktUXUt
YzAtaHItYjAtNzcudWNvZGUgICAgICB8IEJpbiAxNDA3NzUyIC0+IDE0MDQwNjQgYnl0ZXMNCiBp
d2x3aWZpLVF1LWMwLWpmLWIwLTc3LnVjb2RlICAgICAgfCBCaW4gMTMyNTUxNiAtPiAxMzIxNzM2
IGJ5dGVzDQogaXdsd2lmaS1RdVotYTAtaHItYjAtNzcudWNvZGUgICAgIHwgQmluIDE0MDY3NTYg
LT4gMTQwNDE4NCBieXRlcw0KIGl3bHdpZmktY2MtYTAtNzcudWNvZGUgICAgICAgICAgICB8IEJp
biAxMzY5MTkyIC0+IDEzNjU0ODQgYnl0ZXMNCiBpd2x3aWZpLXNvLWEwLWdmLWEwLTc4LnVjb2Rl
ICAgICAgfCBCaW4gMCAtPiAxNjY3MjM2IGJ5dGVzDQogaXdsd2lmaS1zby1hMC1nZi1hMC5wbnZt
ICAgICAgICAgIHwgQmluIDQyMDkyIC0+IDU2MDQ4IGJ5dGVzDQogaXdsd2lmaS1zby1hMC1nZjQt
YTAtNzgudWNvZGUgICAgIHwgQmluIDAgLT4gMTcxMTEwMCBieXRlcw0KIGl3bHdpZmktc28tYTAt
Z2Y0LWEwLTc5LnVjb2RlICAgICB8IEJpbiAwIC0+IDE3MTI3NzYgYnl0ZXMNCiBpd2x3aWZpLXNv
LWEwLWdmNC1hMC5wbnZtICAgICAgICAgfCBCaW4gMjgyNTIgLT4gMjgyNTIgYnl0ZXMNCiBpd2x3
aWZpLXNvLWEwLWhyLWIwLTc5LnVjb2RlICAgICAgfCBCaW4gMCAtPiAxNTE3MTQ4IGJ5dGVzDQog
aXdsd2lmaS10eS1hMC1nZi1hMC03OC51Y29kZSAgICAgIHwgQmluIDAgLT4gMTYyMDAwNCBieXRl
cw0KIGl3bHdpZmktdHktYTAtZ2YtYTAtNzkudWNvZGUgICAgICB8IEJpbiAwIC0+IDE2MjA3MDQg
Ynl0ZXMNCiBpd2x3aWZpLXR5LWEwLWdmLWEwLnBudm0gICAgICAgICAgfCBCaW4gNDE4NzYgLT4g
NDE4NzYgYnl0ZXMNCiAxOCBmaWxlcyBjaGFuZ2VkLCAyOSBpbnNlcnRpb25zKCspLCA4IGRlbGV0
aW9ucygtKQ0KIGNyZWF0ZSBtb2RlIDEwMDY0NCBpd2x3aWZpLXNvLWEwLWdmLWEwLTc4LnVjb2Rl
DQogY3JlYXRlIG1vZGUgMTAwNjQ0IGl3bHdpZmktc28tYTAtZ2Y0LWEwLTc4LnVjb2RlDQogY3Jl
YXRlIG1vZGUgMTAwNjQ0IGl3bHdpZmktc28tYTAtZ2Y0LWEwLTc5LnVjb2RlDQogY3JlYXRlIG1v
ZGUgMTAwNjQ0IGl3bHdpZmktc28tYTAtaHItYjAtNzkudWNvZGUNCiBjcmVhdGUgbW9kZSAxMDA2
NDQgaXdsd2lmaS10eS1hMC1nZi1hMC03OC51Y29kZQ0KIGNyZWF0ZSBtb2RlIDEwMDY0NCBpd2x3
aWZpLXR5LWEwLWdmLWEwLTc5LnVjb2RlDQo=
