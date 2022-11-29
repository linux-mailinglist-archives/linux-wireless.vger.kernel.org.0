Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FEB863BA15
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Nov 2022 08:00:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbiK2G77 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 29 Nov 2022 01:59:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiK2G76 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 29 Nov 2022 01:59:58 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F2A225C40
        for <linux-wireless@vger.kernel.org>; Mon, 28 Nov 2022 22:59:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669705198; x=1701241198;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=J+ZwZah/Sy/y4ibyOGbBDgOVTO86ba46C+WPb/jt2sE=;
  b=PONrwP/K2yHbYo5hfXnrbEfVq6BrCEIgyVDr4L7KHwFFRvuNKgC239B+
   eIIUGkm/0offVLWjgxcYj9muFmC0XgqFBR2XAJzNWurYRSRnTM/aicCY3
   BcIXTKZIUmTAj/UJJzMeHqIRYVv2rSl73nzYwKkRWUl/ncOthskJA6UYk
   onbTrLfDsfxHY9SforQ/6kQvEwh36xD6ZIbye2fYOa8rLt44o29DBH7KP
   4UKZfRGO/lz71csSDRhL0c/UHlla9SzqqapbhyJai7HtYB0VXtDRg1PFC
   F+aVN4I5H4R9v7OgJrDsMwq68iRRWKSr6vTz94ldDprpTGNmb+qs6EuW1
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10545"; a="312667614"
X-IronPort-AV: E=Sophos;i="5.96,202,1665471600"; 
   d="scan'208";a="312667614"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2022 22:59:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10545"; a="749715436"
X-IronPort-AV: E=Sophos;i="5.96,202,1665471600"; 
   d="scan'208";a="749715436"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga002.fm.intel.com with ESMTP; 28 Nov 2022 22:59:52 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 28 Nov 2022 22:59:52 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Mon, 28 Nov 2022 22:59:52 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.170)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Mon, 28 Nov 2022 22:59:52 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lg47aSHEvcP8B1Hyc1VDoe/KBdNtYX4t+98qLZSoUp4Y/26yhaAKu/uSkzhbPxsX3p+SdzJOfkf3BxKRZivTUeNun4iur7OjM2PDE3h+fGHrjfpFfL1zYwNGyIbb0stJX3ZpdRiz61R6btPwLsgcJujVxlGZlMbVTPmUyL7OzturlhaSYeQJNmo/275MeigDJWtMDocrXYAZDYoC1B7vdDdWKxzsmOt4VhU2AZv+Eq/VYNUqNNR4VArUdFgSCbSEwO+Q3hZ0HqGl49Kd5/RKbbJWpn/S5K/+melB/rNhgvA1kmHmPlEoFQONxP9ramG4w08mZW5qo8SGlgUk7J5xqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J+ZwZah/Sy/y4ibyOGbBDgOVTO86ba46C+WPb/jt2sE=;
 b=KaRKA0AelIAF6vODEQtFfCarHKCWx+6cYix/wnJ+RhhYoch2CxhwbvnWXb4Xrg4O7Ksrd8Veo1sj44umFvghFOT9uC9ADTy2T7EM6Hs4kmDivPZ7mT9c+X+QOn0w/YLfGbxx+gJJ7LEfbaqOtFyfqgLVy6qPtWKtCiqMECNX76mOtnX8UVqXTGxnNYgiplNujMvcAkDSdWzegDvHZm8ojeV5eBv6DilxeNSolHuY4/LYKxUwwFqd2qp5mNJlX0kD9EUCIh3PPMOWNfaRhZiCB/np0AEL5JBTr6Tc5Jx3k60U0DfwDzKPn08nOJ1mSQk1o0QqmIBgded5pLkIdMSUgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB3897.namprd11.prod.outlook.com (2603:10b6:5:4::26) by
 DS7PR11MB5968.namprd11.prod.outlook.com (2603:10b6:8:73::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5857.23; Tue, 29 Nov 2022 06:59:51 +0000
Received: from DM6PR11MB3897.namprd11.prod.outlook.com
 ([fe80::f4a9:cfb1:932a:438f]) by DM6PR11MB3897.namprd11.prod.outlook.com
 ([fe80::f4a9:cfb1:932a:438f%5]) with mapi id 15.20.5857.023; Tue, 29 Nov 2022
 06:59:51 +0000
From:   "Otcheretianski, Andrei" <andrei.otcheretianski@intel.com>
To:     Wen Gong <quic_wgong@quicinc.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "Peer, Ilan" <ilan.peer@intel.com>
CC:     "ath11k@lists.infradead.org" <ath11k@lists.infradead.org>,
        "quic_drohan@quicinc.com" <quic_drohan@quicinc.com>,
        "quic_vjakkam@quicinc.com" <quic_vjakkam@quicinc.com>
Subject: RE: wifi: hostapd:/wpa_supplicant MLO Re: [PATCH 00/27] another set
 of MLO patches
Thread-Topic: wifi: hostapd:/wpa_supplicant MLO Re: [PATCH 00/27] another set
 of MLO patches
Thread-Index: AQHYwcdECXMEe3QNQ0ujvgfkz4HwEK3SFYGAgAm29vCALOJTMYANEhCAgD7HAYCAAABK4IABIs8AgABQ5CA=
Date:   Tue, 29 Nov 2022 06:59:51 +0000
Message-ID: <DM6PR11MB38979D307490C7DDA235A7B7F5129@DM6PR11MB3897.namprd11.prod.outlook.com>
References: <20220902141259.377789-1-johannes@sipsolutions.net>
 <6175bc95-201c-cfab-2ae6-9ba77e830394@quicinc.com>
 <09556b33ad998ad243cf75dbc230f3b07349a87e.camel@sipsolutions.net>
 <935ef9e9-2092-e3f0-0edd-4aa29f4fa775@quicinc.com>
 <e01e75013f71ede7b29f2751238935e7147796f2.camel@sipsolutions.net>
 <f3afceb8-8120-12c7-74b9-caa3abce5cb8@quicinc.com>
 <DM6PR11MB3897D1A4E13419D9F938F559F5449@DM6PR11MB3897.namprd11.prod.outlook.com>
 <96bcc467-c530-46de-8f91-c5eb0af7a368@quicinc.com>
 <776991f3-384e-f487-83b7-e1fbfd40cc4f@quicinc.com>
 <de54f4e0-810b-70a0-7629-39a2957ecd3d@quicinc.com>
 <a3edddb2-82e4-2c79-564f-1918b59aead9@quicinc.com>
 <DM6PR11MB3897D1DE6EB7A89F4F6A6A16F5139@DM6PR11MB3897.namprd11.prod.outlook.com>
 <4390cf15-50e6-9941-15b7-4927d1afc976@quicinc.com>
In-Reply-To: <4390cf15-50e6-9941-15b7-4927d1afc976@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB3897:EE_|DS7PR11MB5968:EE_
x-ms-office365-filtering-correlation-id: 078b1337-fa40-4cd7-792f-08dad1d74fc9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KaSzMrBXhxTLcZCs/rO119A5YXPKXPtIb7FLoUSiNbHisrGQUY9dJc/699bRj6pA+BlAhN8LGWAr0BzQykxCvTholBOwZ3b43TDn4yraWkpnvVL4D9ppSX0jl3oc+nhHGsomjN6i9iCFC+CGCkB43eyF6jI509IiO5IQfOJK98D6b9q0fk1urFcmejDMPzU2LsLAY0WDQSouY3J8HqZu/2R7yV09xQcsJPBPTw6wrkOzi8FUwqiKk5/8IMxRFe2HIkEEtQzgxSNTYx/e2voflX0ha8s+nhofo+d3On2kncXnRV4W5D01POShnIPpZZAbT+rhsvQCipIkmHjf1E8sVgc5wSJJ+lKa36pAl/EV7xTgtC/RlTR5ARWPqIKeewTccK+xVETEpV5DWOH6ilTdMz9wUinUO1JX4o+YM6awqQFdDNzf2uqiWJ0GNRk5u6fyJgYPRVtrt7pn1Ae3dYEhLxxiLipIn17dY8SHKkLRz+/Q5Nfw6CwwkWIMDuBUpcWi097U5dp7NqMU4ks9nP0/kbBnQChKbcJRgm61L98FyTN9wBq/wS3oL5ACn6gk2ql6l+u3rtiyXXw5QZ+s9rgmbtF1/80GUB+3XF6SgiOmT2upG/5QeV3f+F4RlGdGdxJjRFF6bI74AVDQEGDXfpen4Z6iC4Bi93fPp2ncjBXyvsZ+hiLTTLx8d7STkTFaCt8F
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3897.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(396003)(366004)(346002)(136003)(376002)(451199015)(26005)(33656002)(558084003)(316002)(9686003)(71200400001)(55016003)(6636002)(54906003)(110136005)(6506007)(82960400001)(122000001)(7696005)(38100700002)(2906002)(66556008)(4326008)(66446008)(8676002)(64756008)(66946007)(86362001)(66476007)(8936002)(5660300002)(76116006)(41300700001)(186003)(478600001)(52536014)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NUNOb2FsendPS096ZE5HVGg5bm9TMmxMYm4yeFlMSlZmTGsvYlBtN2g5dDBn?=
 =?utf-8?B?RUgvalpUdlFIMUNGUC96MmZuaDFuOVF1R2FLeGk3bDhZTVd1QitPV3hZTS83?=
 =?utf-8?B?dVg4aUNDdEFkNktMd3JYOTZiQUdrcHN5Mmpaa2tXZm5aUm1PZzczWTcyU0Za?=
 =?utf-8?B?cU5GaFptQTN5Qk40eFVESmxFZXdWb2d0MWtXUGs4eGh1M0xXbWtZU2xkRFoy?=
 =?utf-8?B?WTBXVkwzMVFjMjErTXV1eDk1ZWsrMWExSmZxYkwyRnNPVDJmNGs4Vm82bGFM?=
 =?utf-8?B?ZHhRRzM1akRQVkNvTEZlN3JGaUtsUTMxa0x5QkVtWkZXUjFwOGxVMTVJOVdP?=
 =?utf-8?B?cWFJSVNZUGo4Z2g5UlRqaFA0NmE1VEpETDJhd1FCK0ZjUUVTSXRqd2dtaTZl?=
 =?utf-8?B?UkFlSFRCWjRqbmNmYmlDdW9VdlVDNkQzZDVYUXpXNkYrSVpxNXY2ejZObm0r?=
 =?utf-8?B?Q0dwS2JrOFJYbXhCWHBUVjJyNk4zREdNVXhzb2tYSExnUVFyTEY0Mk1Kb0pM?=
 =?utf-8?B?a1R0Sk1LVWRuRnd3clVPdWFRWjRVNDMzamVWVU9KenVXSk9sckxoaXNpLzlD?=
 =?utf-8?B?MnlCWUpDQ3hhbWp5Vlg5QWNkQ3FISkp3RkFSNzU2UEdOK2NaMkczdWR4bzNp?=
 =?utf-8?B?ZjFudE8yc09lZTdpQzhVaGhUQ0dLd1lsNUNlbmd2OHZkS1ZyZlhxcDdzQlBR?=
 =?utf-8?B?MjVSd0E5ekxocWtSam9hdlV6SEZWdGVCYU9zWXNkNFJhOVlKR0krZVQ3cUNh?=
 =?utf-8?B?R2ZSQk9neG12MGhZdEIrQ0FIamkxeDBxSmdUN0JOZHdBdGZIWGFEdUU3Z0lT?=
 =?utf-8?B?R0dia1lBOVg5ajdnblpXZmx3YjVjK0ZLSkYwenJ5RFFZcjV4KzlGMStxVldU?=
 =?utf-8?B?dXRMTFJyREZ3cWhZNEg5MFFkUW5iMGQydmdtb3IxV21RV20xUkZUWDVQdEV4?=
 =?utf-8?B?VDlkdFFhdGNQSGxEOUp2dU9Ud1gzbzBuWjRtS1VqMnBsNngwaERVZ1V2WjdB?=
 =?utf-8?B?dWw0Q1drWlRuTGdRNXlLZFJXWTUrRSsvWDJMdDRyempTWlVwb3RPdnNzUEhy?=
 =?utf-8?B?bmhRZmFVazAvZlpKbkszTEJtdEZPZjJZNEZobzdTWUZDdTZ4bTUxVGlJUVdC?=
 =?utf-8?B?amlPSnpneGMyd0ZkUVc0Q0daVXgwdm1uV2piNG1vSFFWT1M1Y3lCR2pURWhU?=
 =?utf-8?B?WGhEblhtR0p0eTdRV3hxdlFkNmh2ckxzeWRBUjg3SG5tZVMycEFlZHAweWxD?=
 =?utf-8?B?bTBPU0ZqMWtwOTV0WCtoUHlRQ0FsVE1HUThacml0RHNwT3FCVFRXaE80c1hz?=
 =?utf-8?B?dk4vdElIVU1JQ29Ha0pQWnI0SVFSeTNQbWEwbUF0QzVNVVNwaFlzREZkZTJP?=
 =?utf-8?B?UGhIcVRnRGNqRk5tV0h3cWs3ektDaHJzNkVGTXR6TzBQSGdadXRTWm1rR3Zy?=
 =?utf-8?B?Smc1YmJURm5CS0N4cGt0Y0I5REk4UGZVSWNkOWFVMy9iZWJxVnZ2ZXptKytJ?=
 =?utf-8?B?OElTNnhGaUtOVU1nTHc3R2RiQVNiSHFEQ2lYS1lKbjlnRWJXQmd0RkhCQjAv?=
 =?utf-8?B?b2pJSDVtS3BKaWZzbDkwMDRUcG5VMjNQNFVadEJTK1djc2M1ZEZCcnlhSGh6?=
 =?utf-8?B?YWtHWkVLbDZMbnI5eTJvajRINlgyZklrYmkvWE5IbXo0ZVdvQURzdHJnVjQ5?=
 =?utf-8?B?bmcxcTJ3NEsrcktXRDFMdFlKVkdwNlBOV1BRek9OWUlKMDRNZnpuYzEyTGwx?=
 =?utf-8?B?YzR2L3FqUEVrVTNJK3EyT2EwWi81R2xtOEdYWXNPNTFFMzVWSVB0SXRiM1Bo?=
 =?utf-8?B?aENOd0gxK29PZVBuUmE2RWlVQmlWSlpZWjdGOXN1anBabjNXK1JFdnZSZFpW?=
 =?utf-8?B?cGNhY1JwV0JXd0ZlN0Vtbmh0dGNxb3JUNDgyNFRTK213NDR3RnROcHNqc0dM?=
 =?utf-8?B?aElleDlqa2pmenR1VXBrMjZQbEFZTHBXSk5TV29yOW5FVmt0ZzRIdFZlRzlP?=
 =?utf-8?B?UXlPd1VXVUE2eTVDVmxzUWVKMG9TNVV3TmJTWk14UU4rNWx6NTI0MGdOVitM?=
 =?utf-8?B?ZzRyeG9WRnpGSjUzUzhkVEVNb0pkSGY1SHBMSXprZ256UEtRby9adTExUTBl?=
 =?utf-8?B?WUZtRlJhZ040RVdHeWpMN3NzaEorclkvQzZwc2t3UmxGUDU5SHV0a256eU5t?=
 =?utf-8?B?eHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3897.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 078b1337-fa40-4cd7-792f-08dad1d74fc9
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2022 06:59:51.2655
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vFlkR8pLxaMl8kyB8RAPtJJ5cHGr6u2HLf+LngeX/Dwk/FyxSTwjlK/6AqwedtGYIWXj+o9QFNDrtsSgoRUqReIuz0Hb7jDMOjpG/lbg610=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB5968
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

PiBUaGFua3MgQW5kcmVpLCBkaWQgeW91IHRlc3RlZCB5b3VyIHN0YXRpb24gd2l0aCBzaW5nbGUg
bGluayBvciAyIGxpbmsgb3IgbW9yZQ0KPiBsaW5rPw0KDQpUZXN0ZWQgd2l0aCAxIGFuZCAyIGxp
bmtzLCBidXQgc2hvdWxkIGFsc28gd29yayB3aXRoIG1vcmUgbGlua3MgYXMgd2VsbA0KDQpBbmRy
ZWkNCg==
