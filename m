Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 588DF65B2AA
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Jan 2023 14:32:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229966AbjABNcM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 2 Jan 2023 08:32:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjABNcL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 2 Jan 2023 08:32:11 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B0165F55
        for <linux-wireless@vger.kernel.org>; Mon,  2 Jan 2023 05:32:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672666330; x=1704202330;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=dP5lmSuwUfhtI2fFEJpUqPuWyr3EGZ+7IZQFBEpZHnQ=;
  b=I9zyi/4T3V+Lio4olRt5YcX0vzEB6OIxvBjlO9X2OyGRWQFJyfZ7BYmB
   nrrNLFTJ1Ga8CTeq/Mb+u/ffaqAb2TeOTbTG5FvqMnA2NsNpdeOrboeho
   3WZ9H2ddOlm/gC+iZ7haKWtlqAGBLHEv2N89ehbzXNEDlTD1z6zfC7brf
   zERhwGRTuI8CJFwP/5+Wrm8yfkqoZrreDipYU8v44V9LuUJFrm6l7lwqW
   +xuF1C/plL1/J+Q6yBZtIaUe1jetJ1nJig+wFnmoFnO03JY5WV7zRcZrO
   4x3l8EHLBwSASMf+nYZJFDiU6ewgjm8DlJkmu4DvxOL87fJAYNS8zUZpu
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10578"; a="319184334"
X-IronPort-AV: E=Sophos;i="5.96,294,1665471600"; 
   d="scan'208";a="319184334"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2023 05:32:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10578"; a="656477114"
X-IronPort-AV: E=Sophos;i="5.96,294,1665471600"; 
   d="scan'208";a="656477114"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga007.fm.intel.com with ESMTP; 02 Jan 2023 05:32:09 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 2 Jan 2023 05:32:08 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Mon, 2 Jan 2023 05:32:08 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.107)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Mon, 2 Jan 2023 05:32:08 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I+IcKFULpGAj4H9L/+hHhHgC9c8eDLtL8a5PGq1we4lBjA9dXiq7x/4T3VNHhyR8dq/HZowVg0th1ZgH7xXC78t02nDZagrFBkITJeQhRK5rGQa7gJFW6AxCMJumMiFAo7SQhERQ+6BlF8mk/UZJNbDtxqUpCnThyswZVE5z5MaTj6A6H/k1zmQaWjKD2WexCzESZspaFG5c1mS8ZNLRivWyrzIxGbx+FH2ztjxFEMYf7fat7W3SkIYGTPivxP8mZ35dEMzUkq5Hig8CJQULQT39g2KhDYuTRzd8A+p4CUp/6oMtWVCMmN/JCjxbc0ymXZWzp6WY2Lr/Db4QUBFB1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dP5lmSuwUfhtI2fFEJpUqPuWyr3EGZ+7IZQFBEpZHnQ=;
 b=j6I7odTSghx+lugREz1tjkHbJiVd0tCIlQ+RIFNhqh/t7LXcA9I3XkfO3bOm3CkerIYtbCCJ46W+DqYys2SMDXAVnMKchR5fuq1GZwDaJ/J8XUmiQNxtxS87Mdmw10hEGSWZx2TWEIvl6xEdQEX6a3h4CuulPJydJ2JmWgOd6S/1nPukbRXDF9MvjrNMQ9pq3gk6Ffb7fcYUhPK+t1tpQfw5o7IM2rhycXCI0l7sf0lPofW1cFeqtt2s6q7wxdyc8yaHkuHQLJSO5qgcRdUTqu66cXBVoSM/8le/0IW3Ba07KYvfn4XAy2EcSBlRzpzgmTOshAWh0OvYjLeHpbppCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5987.namprd11.prod.outlook.com (2603:10b6:208:372::8)
 by PH8PR11MB7094.namprd11.prod.outlook.com (2603:10b6:510:216::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.16; Mon, 2 Jan
 2023 13:32:06 +0000
Received: from MN0PR11MB5987.namprd11.prod.outlook.com
 ([fe80::1c42:3e93:5a97:a280]) by MN0PR11MB5987.namprd11.prod.outlook.com
 ([fe80::1c42:3e93:5a97:a280%5]) with mapi id 15.20.5944.019; Mon, 2 Jan 2023
 13:32:06 +0000
From:   "Greenman, Gregory" <gregory.greenman@intel.com>
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "aiden.leong@aibsd.com" <aiden.leong@aibsd.com>
CC:     "kvalo@kernel.org" <kvalo@kernel.org>,
        "edumazet@google.com" <edumazet@google.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>
Subject: Re: [PATCH 1/2] iwlwifi: pcie: add support for AX101NGW
Thread-Topic: [PATCH 1/2] iwlwifi: pcie: add support for AX101NGW
Thread-Index: AQHZHlOZDZ7U6eVjPU258u4ky3iksK6LIIwA
Date:   Mon, 2 Jan 2023 13:32:06 +0000
Message-ID: <b1e7aabf9f1543fda0919a41ca97ead23b298225.camel@intel.com>
References: <20230102024021.2900-1-aiden.leong@aibsd.com>
In-Reply-To: <20230102024021.2900-1-aiden.leong@aibsd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.42.4 (3.42.4-2.fc35) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5987:EE_|PH8PR11MB7094:EE_
x-ms-office365-filtering-correlation-id: 9c39e1e2-6889-480e-38c7-08daecc5bda1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1dg7UTJuPuvDs4xjzxoowVApDDhd7HL4T0bikYQCVEiacd/YYbrsDtdpFcRBsqP04udP3bnOMerPHR9WQsWOyPcu/K1/WiNUO/vugy0/kEGITibGAYYERT7hbm/U2FEjMPqKM/YGB/YnP2YebZ2aff2vPcCL9cnM/nx9m7gb8OTlzbe9r6M5VrCKYDh7ytO0zvtqW1fImevbykRIx/nao1bXNfSzYiJNurDVmw8IgpLb7HzD8/KJDpo3JVyUcgJmNwi4mSTaqHWjf57akaIv3GAVtFcBT2Dk6loZPHO0bciFFhlvu84NwYdYqNpijQNdFy8yGjjushgDDraNjbEkUOZxTdWKFnT02SHMTm+BXNzekLu34TP1rxjpzKwmkGvCmdQSlBGJp5zyfEGROIzBW3j7EPJNTAYZW16c1xWYdaCIh4ysECihIJJ0JQDAhbTTg6Bikaw8ZlcAv1CwND0bokD+os5UnPmBOfHqEcE2hZ3gXI+0G4mXBZ8j0LLiFmF7d2a9S/y7qvnUCQH8k2wfT7cRt4uDahs6amDYEunrrCA5Akyfy4J9jtwHLBEsIQBcD4UhzGySTQmchOFnldBxuCSxdTNu/rtu8+TEmbGxxjDUbxTfBWb7xapJeQN6V4uEscxX5mpaHWNjbCoTEthJyqiMaDCLckV3sR8sQhrywiZay84HqRg/NOgDH8mMdKP+CVcmVV/gEr7UFMeP8+2AbFDnHqthtSNb3ILrzUxCRZM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5987.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(39860400002)(396003)(346002)(376002)(366004)(451199015)(26005)(6512007)(38100700002)(186003)(83380400001)(2616005)(36756003)(478600001)(71200400001)(86362001)(38070700005)(6506007)(6486002)(122000001)(66946007)(66476007)(8936002)(41300700001)(110136005)(2906002)(316002)(54906003)(66556008)(66446008)(8676002)(5660300002)(91956017)(4326008)(82960400001)(64756008)(76116006)(22166006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OU13OWlOYjA3ZmlkOTJqSm8vRzFjWlNncFI4dVFmZmM0ejRWSTBma3NHSFkz?=
 =?utf-8?B?QXI4VWU0akZIU0hwUEo4QXdMOG04eWlKdXVQdWs3Y1NQQW1qbmJnVlU0TWdj?=
 =?utf-8?B?S3hkTkJVR2NOcUpEVDErY3ZhaHRQSllCTkhNS0lMSXMyOFkxdTNobHppL0lB?=
 =?utf-8?B?SDNkNlV3SThzdGhSOGZCd054ay9FRC9ybE1iV1BzRFhad3diaDlLbG5JL3R6?=
 =?utf-8?B?TVFYOEU2aDRIOFJ4dEhaNW9uOU14VlI5bGFyZWJnM3VQRFI3Q0VHaXptUGxX?=
 =?utf-8?B?S1JGbnlqZlpteDZKMlhjR09wTGo1L3VOUEJlMlVuYnVOWXpzUzBESEZ4YVE0?=
 =?utf-8?B?T1M5eHhhVC9HVmE4YXJjYi9GVWxJT3NIYnZ3MmE2SzJrY1h2WkcyOFJoZmR5?=
 =?utf-8?B?UU5JUkhFM3VZNEs5eDluQndHU3VjdmJEMGczL2pzWHE5OVpuQTB0U1dkN2FB?=
 =?utf-8?B?RldwZEpPajVLWnkrczBPYnpOVDFTWjR6N01EWjVWSnozTGFNQUprVkE2NzNQ?=
 =?utf-8?B?UVVaKys2TG0wQVRsSit3Q2ZpajEyZSt3eXJabkRvRXg2b1hsOGFvNG9FUmRJ?=
 =?utf-8?B?V285Q1JZMXJlNHhHSStlWTNTb09UeGxwNzlReWhCWjhOL3BwaTdwV2ZleGpB?=
 =?utf-8?B?a0NHY2hVdlhTUUhWQWdaL3dIRW5XQ3ZVbHBKRWlkVk5yUkhHRXZNMGtqQkU4?=
 =?utf-8?B?MWZqeGpDVThhMGZjTitaK2ZIQUIvTG9jdGtaY1FzSlEzd0RyTlVuQTI2akxS?=
 =?utf-8?B?bFR0NHdOdWVXRXd5RGZRN1M4WVJweWd2SmZnT2VBNXhXMHg0UWY5TWltUFlt?=
 =?utf-8?B?NXVBZTBWT0VIQXpNL2xCa2UxdHFFOGROTmNEa1BYNE5CVUkvNnQ5OHA4UEJI?=
 =?utf-8?B?ZUJhcHJLRUtKMFdybnFqYWw3Nllob1NYVlNVZTBFMVZlcVJUR0xQT0xPcUZt?=
 =?utf-8?B?eFZKZmJnS1VhV3NOdHNGNS81ZkxCY2Z2L1c0Yk1DU2xWR3IvaGxocGtHQklp?=
 =?utf-8?B?c0xIZHhSNXBpYlNvSEREVit3MG8rM3I1S2hPZkMrdEZqUlA4YmpBeFNnZU1V?=
 =?utf-8?B?WUV2akhGTUU0WDMyTUcveWlQV0RSRWttWW1mWnI4azJNamJ2T21xN0QwbnBL?=
 =?utf-8?B?VEVmeER4ZXQ5TVhJeU9CTFNTUU9JQ0dLNUxkQnlCZHZTSWo0cjZ4OFhKR2w1?=
 =?utf-8?B?NXI3bFZHV0wzVGo4UlVYbnFBUTAyZCtSMXNMampxNWNLdVg3YTF0K1I5bGxw?=
 =?utf-8?B?NVUwcHFZZnl0ODZwci9TUlJxd2x3cGUwZmhPUk92T0xpclRpSUs3eHRLeWp1?=
 =?utf-8?B?SkdyTHZZUUJtdUx5OFdGaEJLaDNNYzRVWXZkRE5WS2lZRmQ4U3RmajFFd1Yr?=
 =?utf-8?B?Y2pIVXVoalV1SEFTcnJpQ0d0TFU1ZXA5c2hISERtV2M4TzlUaU9zK2gzT2Z5?=
 =?utf-8?B?dkdLYTI4VzVzT3ovVnNCdkZlZkllNTRHb0doOEhNcldvelZHTUtvZU5FRVJO?=
 =?utf-8?B?ZGZLL2p0SmUxWGEvd3ROc29wMUpXUlF5dk92WktCSHNlSTdncUlOQU5FNTE5?=
 =?utf-8?B?RHR2STdZNkcwZU14elBCUHR4YWVpeWJUaFpxUTg0dmVOYWZCZTNSZUpWeGtz?=
 =?utf-8?B?ajFvQTJ3dmg1MTlKcEVoVU4raDk4RmMrSFl6aXlFYWtQeFIxZjVDY0xha3pC?=
 =?utf-8?B?Z2d4bVh4MksrckwybGdoSTc5cWNrTnZJNVZ5WlRBNnlxV2VGMHJidjV3ZHFi?=
 =?utf-8?B?dE8weXlQV2tiVVZ1UjBjYTl0YXgwU3lsbkNTZ3Qyd1BIZ1M4all6MnBTMzJs?=
 =?utf-8?B?ams5VStGT0RXM1hNQWxpSk0yUkxqaVpwSUpjbUFzaDF2QksvSlBibWs2QUhm?=
 =?utf-8?B?QmgrbUlHZkVrM2dQaHY2dnVLUXQwZ2FwUzIzbXowZHE0ZE02NDJ6dkI2dGFj?=
 =?utf-8?B?Tkw0K2cvdjNxZFBPd0pCamtVN3k1L1NqTktpbytKRUhHUHVtbGRkLzFOTTVk?=
 =?utf-8?B?S3pyRXRPUlU3MzZiN2JSNStUazJ2cXl2RkJFK2x1OElGMDlLNTFUN0dxQmZG?=
 =?utf-8?B?V1FUN2pncmV1MXArUVZZVmlDKzcvT1huWEFzMmxSMlpoU3hobXJKRmluUlVB?=
 =?utf-8?B?RU9sNXFvYnozaG1iUStlSFNaOFlhZCsrZW9HS1hqR2prTjYycFlQZk53YXRH?=
 =?utf-8?Q?Tz7RO9vsENF0BU1melVt03k=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <385E5FD3AE804F40BD3ED9903F9C40F3@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5987.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c39e1e2-6889-480e-38c7-08daecc5bda1
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jan 2023 13:32:06.0362
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DI3GmtWBJuOIoohSxABzjF2H1b4f2+M70yCqB632nFF6Dafvx1bbUOxchTndINfJW73nfwBOiNffSkKT+hhbtNYJPwGDiSSVdCKyViGt6zw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7094
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

T24gTW9uLCAyMDIzLTAxLTAyIGF0IDEwOjQwICswODAwLCBBaWRlbiBMZW9uZyB3cm90ZToKPiBB
WDEwMU5HVygweDRERjAsIDB4MDI0NCkgc2hvdWxkIGhhdmUgdHhfd2l0aF9zaXNvX2RpdmVyc2l0
eSB1bnNldC4KCldoeSBpdCBzaG91bGQgYmUgdW5zZXQ/IFdoaWNoIGtlcm5lbCBkbyB5b3UgaGF2
ZT8KQ29tbWl0IDNmOTEwYTI1ODM5YjEzNDM2YmYwYTIyMTg2ZjE2OThiMjNlYWZiOTEgYWRkZWQg
QVgxMDEgZGV2aWNlLgoKPiAKPiBTaWduZWQtb2ZmLWJ5OiBBaWRlbiBMZW9uZyA8YWlkZW4ubGVv
bmdAYWlic2QuY29tPgo+IC0tLQo+IFJlZiBDb21taXQ6IDkzNTJlZDAxNjVmZjQzMTNhYjM0MGM5
Nzk0NDZjM2Q2NGM1MzFmN2EKPiBUZXN0ZWQgb24gbXkgb3duIGRldmljZS4KPiAtLS0KPiDCoGRy
aXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvcGNpZS9kcnYuYyB8IDUgKysrKysKPiDC
oDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKykKPiAKPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9wY2llL2Rydi5jIGIvZHJpdmVycy9uZXQvd2ly
ZWxlc3MvaW50ZWwvaXdsd2lmaS9wY2llL2Rydi5jCj4gaW5kZXggOTk3NjhkNmE2MDMyLi5hNDZk
ZjEzMjAzNzIgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lm
aS9wY2llL2Rydi5jCj4gKysrIGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9w
Y2llL2Rydi5jCj4gQEAgLTk4Niw2ICs5ODYsMTEgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBpd2xf
ZGV2X2luZm8gaXdsX2Rldl9pbmZvX3RhYmxlW10gPSB7Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIGl3bF9xdV9jMF9ocl9iMCwgaXdsX2F4MjAxX25hbWUpLAo+
IMKgCj4gwqDCoMKgwqDCoMKgwqDCoC8qIFF1WiAqLwo+ICvCoMKgwqDCoMKgwqDCoF9JV0xfREVW
X0lORk8oSVdMX0NGR19BTlksIElXTF9DRkdfQU5ZLAo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIElXTF9DRkdfTUFDX1RZUEVfUVVaLCBTSUxJQ09OX0JfU1RFUCwK
PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBJV0xfQ0ZHX1JGX1RZ
UEVfSFIxLCBJV0xfQ0ZHX1JGX0lEX0hSMSwKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBJV0xfQ0ZHX05PXzE2MCwgSVdMX0NGR19DT1JFU19CVCwgSVdMX0NGR19O
T19DREIsIElXTF9DRkdfTk9fSkFDS0VULAo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIGl3bF9jZmdfcXV6X2EwX2hyX2IwLCBpd2xfYXgxMDFfbmFtZSksCj4gwqDC
oMKgwqDCoMKgwqDCoF9JV0xfREVWX0lORk8oSVdMX0NGR19BTlksIElXTF9DRkdfQU5ZLAo+IMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBJV0xfQ0ZHX01BQ19UWVBF
X1FVWiwgSVdMX0NGR19BTlksCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIElXTF9DRkdfUkZfVFlQRV9IUjEsIElXTF9DRkdfQU5ZLAoK
