Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71FB77ED1C5
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Nov 2023 21:05:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344274AbjKOUFh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 15 Nov 2023 15:05:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344277AbjKOUFf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 15 Nov 2023 15:05:35 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62863B8
        for <linux-wireless@vger.kernel.org>; Wed, 15 Nov 2023 12:05:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700078732; x=1731614732;
  h=from:to:cc:subject:date:message-id:content-id:
   content-transfer-encoding:mime-version;
  bh=jyTU4CpF+HNQ+XliTSlP+fmsnoP0PSbudXubc95qUGw=;
  b=B7e0Ynhd21rvWV0ZYlKzGfL214RvRSjWGDFXVefidxgEH32a/G+04WtI
   a2K/PX6Epg3BqPE/9YxUX/9VnjQVJ5BF2LKV2i9f4zP4tcjSLfyX3lpU6
   3MQbE+iv1GVqCIuJfptFo5ECNz35ND6uFHqmYZyg6jXr6V5UnT742bt0w
   /zDbm52WJ/wc1CoBFlECEY/8U2VFcG0jJFS94ZQjZXVNaTVp7pn3jn9NW
   r8XICuA1A8+iaNdgO2cDWEUseZEFuxmqtrD0x8jAZLv3U3dvZNlCrpkrE
   jtNT0bjSml0gGc2/uS9wA9RvzEQacynnrbT8T/utQ+6Y+AbRLnVu3TJbq
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="477167917"
X-IronPort-AV: E=Sophos;i="6.03,306,1694761200"; 
   d="scan'208";a="477167917"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2023 12:05:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="768696723"
X-IronPort-AV: E=Sophos;i="6.03,306,1694761200"; 
   d="scan'208";a="768696723"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Nov 2023 12:05:31 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 15 Nov 2023 12:05:30 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 15 Nov 2023 12:05:30 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Wed, 15 Nov 2023 12:05:30 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.41) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Wed, 15 Nov 2023 12:05:28 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UOTJ/3bh5EtesmNZiHajIQ/JoDhegCQ70tz/BWNF/oE18usLdbwP5LK8iUKiYGfUwaWtdisopgJ8Zn18nX9Ovg6dpaGKnqaC3tVt0ByqIMDQ1PG26BNqlcko0cSpTC85qDqbfTbgKEAFr2FsbJ2x+858hzeooVev3CNxV+m1YnLv1NMhldLuM4MSvxXMJrY71TYtI1Pjdm1XE78vCgoqWOdEMv2s6dUFWoiyT/vp8yjpz5wKd4aaiAMOJOnk1FhqUbd+nip/5t0IS8WlAwhBoDOGpsBtmMCr6+mvFFmXS2JgW4obtTcx8l5bmdtUiiZ0yC4avgNvz0Lgt3Owngv0/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jyTU4CpF+HNQ+XliTSlP+fmsnoP0PSbudXubc95qUGw=;
 b=UNR0rnMSPOhjF6/Ybn8RlHiQXG0LrALmXLG7yXtQSgkGDv+5BEQLf3UJ6gFt1wqV/sccIsTFeS2+vabZNRZbkBa2mlYkBlpRPeegQNL5zV/MjIhnPU+aa8UoZjWVuY907nEFd2CIW/Jg3qKlHIP9XS+v8snnqMxjbYHZcqFuCc7/9hGmh+jsFIIR5ikRQoeXTJ0cvXvpvhZa/GYhPfr4md07FIZoM2/VShd/46TL0dnZ7iEGFt2g2V2ujKMD/Vt8gtAzBZqsozLqp0FSa4Fknga2UO4uGjHjHCcceOkz/ZOeMW9pYtTNfOgwGXpdl7bONwZH87iHa9KfDrSXf1Uo0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5987.namprd11.prod.outlook.com (2603:10b6:208:372::8)
 by SJ1PR11MB6297.namprd11.prod.outlook.com (2603:10b6:a03:458::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.18; Wed, 15 Nov
 2023 20:05:24 +0000
Received: from MN0PR11MB5987.namprd11.prod.outlook.com
 ([fe80::b045:b0aa:bae8:706]) by MN0PR11MB5987.namprd11.prod.outlook.com
 ([fe80::b045:b0aa:bae8:706%6]) with mapi id 15.20.7002.019; Wed, 15 Nov 2023
 20:05:24 +0000
From:   "Greenman, Gregory" <gregory.greenman@intel.com>
To:     "linux-firmware@kernel.org" <linux-firmware@kernel.org>
CC:     "jwboyer@kernel.org" <jwboyer@kernel.org>,
        "Yang, You-Sheng" <vicamo.yang@canonical.com>,
        "Hutchings, Ben" <ben@decadent.org.uk>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "Ben Ami, Golan" <golan.ben.ami@intel.com>,
        "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>,
        "Grumbach, Emmanuel" <emmanuel.grumbach@intel.com>,
        "kyle@infradead.org" <kyle@infradead.org>
Subject: iwlwifi firmware updates 2023-11-15-fixed
Thread-Topic: iwlwifi firmware updates 2023-11-15-fixed
Thread-Index: AQHaF/8RF/KQUlrK2kCT9rHfZK0dzA==
Date:   Wed, 15 Nov 2023 20:05:24 +0000
Message-ID: <a2cd0356c69d1e0c1f0489bad22ecab7b9e589a0.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.42.4 (3.42.4-2.fc35) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5987:EE_|SJ1PR11MB6297:EE_
x-ms-office365-filtering-correlation-id: ee7a1913-e740-412e-3e81-08dbe6163421
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Li0PdjUu8rNAtK6NBulg30KLEOb3AaiFUq08fPHavBaJ/H0e3GnlhZEWuPCOefKiqR9x6lPOxcbc9e8p8NhWSsevxQe8PJIbR3H3qZWp8uNUrztvieP6wyDAawmMwr7XSAlb1vtu421U7KUK2LMg/VIf2ZPkETL6IT+PLpR3kh24yGpN8hNwUaKSjxio9iwoHh8ThjNXX1HHQd6kp/OKPFzxQ1siQ/rBwU/BKJmx+dtZ7XktT+tTwKm1rWhJLwFXhkDeuHFl6Gi5/QnnOiaDwi9gdpQcEcYtBIWADIdReTyMpjNAfhAcO+ztbnlTJRyUAVfgymQxkPfYbUTBpG5DxWXk9YVUM4ACItPz6hwXp3sm8a3h8eHn7P9bSE2Pw/SlMEN2BJlci/ZkLWdpAn4AdFTmqU/PnStXCAIOghEowtulRqFHLQnFG54yLF5oyo8y346KNB2R96djGVJeiPZtfRjsCrnxr88kWie/EZyXMt8lnbf3rIB1OUc9djp7TFIsKnkjWO8JkDzWyHTqU62ch98yg8HdUv0vgYa4EWPL/bFwN311fNbEOKJfMiVOmuATZEyKD6TNM2iaITuN9Gg7jByQ4Lv/nbiIUTkXcMuVY+M=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5987.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(346002)(366004)(396003)(136003)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(38100700002)(2616005)(76116006)(38070700009)(6506007)(66446008)(8676002)(6512007)(2906002)(4001150100001)(26005)(5660300002)(4326008)(66476007)(36756003)(6916009)(64756008)(54906003)(316002)(66556008)(8936002)(91956017)(83380400001)(41300700001)(66946007)(71200400001)(478600001)(6486002)(86362001)(82960400001)(122000001)(966005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TFp4bkRnc3Mxak5FQ09SRkxlNklITTd4Rnc0S25RTXJQSnV6REJFN2UzNXpw?=
 =?utf-8?B?WnlvSW1PdC9WQUJNWC9Vbld2TC9qNHZIY0VYTUNkeWZsM1kwa1ZmQzIxdnpu?=
 =?utf-8?B?NEtnalZhQUVKMWIyMWtRV2xSVFNQQkF6UTMvRUpxZ2l3V3FIMzZMR3Jab2Vr?=
 =?utf-8?B?eUFlL3k5Z3BKMGl4YmZSQ0pIR0FyS05OMjlFdkE5TGd5YVRHYUZaS0JPK2hw?=
 =?utf-8?B?clJCUW42Z1RRQmtISDhsL251Q04yUkZTd2t0UXNMYmhLVnZ3Y002a3kwam5N?=
 =?utf-8?B?TTFKNnc1NzZPMmp6M2lkeGl4SCtERHo1OFNSSlUranFIYUhTdW1qNkVrLzFs?=
 =?utf-8?B?MzNoZ2pOQlowVHcwWWh2K09LRytsVEhJbHZ0dFpzY1JSYmY3cmM1eUV1MUFB?=
 =?utf-8?B?cTBhcjBGU1B3SktEU3FCdWZnNSsxNWMwRmtJNkZOVEc5cDJlUXJKZG8xOEl1?=
 =?utf-8?B?eHhJZkVaQ29udGVIdURFVVFvdXU0YTczeDY3ZUx4MmlrZUNpYzdPOVRNNVZN?=
 =?utf-8?B?VDBxOE03MFNFVSs5TTR3RzZXZjNwOUluUk92TlRYNk8vSjh5MitnTzhMR2RP?=
 =?utf-8?B?SG1kMDlScEJ5SU5RMTRCVUhDczR0RTRvdDJFb3lTQTJ6dDZzVFZkMnZyK3hX?=
 =?utf-8?B?TVBEVG52UFNkMkMyQ2tEQTRpOFF0SVRUWHZiZFhSL2poYkk0aXQ0eS85dFV6?=
 =?utf-8?B?RXRRNkhtRVUveDRhb0hhZENKcTRWbytCV1N4VGhpdE1RQTdrUXpvT1NBZjdv?=
 =?utf-8?B?V1QrSkIzQnlDd3JybjZqWUhzOGVNTHI4dkhBWkRnVUlmMVp6dHFkc0drTTVJ?=
 =?utf-8?B?ZS9RNjcyNElabUk2a2hhbTBNdzE1TDNYSCtZME44VlloM0FzbkNCVlNUOGMv?=
 =?utf-8?B?RDloMW84M2hkZDM5eU1CdHRhNTVMUm94VFQ3d2YwUmh6WUVwVENJbHo1WUJV?=
 =?utf-8?B?YytSM1B3TmxMdFhlQlZneUFDZGFSYTB2YWxKWm5UOE0zUXNCejVFdUtMT2dR?=
 =?utf-8?B?U0FRMlJvMGh6ZDdaZEovMzZGdHZpUm1aWldXOW9sa05veStLUFFZN0hRaWw2?=
 =?utf-8?B?MHhjN1p6eWZldFFuazZDcUpnc3I3VDF3dUlqazFWcmpMamhOclU1RUI4WERQ?=
 =?utf-8?B?b2plaWVzOGhTZFM5bFozbEtNNFRybDVxUTFRZ1oxVm92N0M1anFCbG12dTUy?=
 =?utf-8?B?bXVsM1EvL1k3SmN1RW5uN3lnejhLOVlUckRTTlczMEY3eGRWbmFVbFBuQ09D?=
 =?utf-8?B?ODVqeW9VSENOaG0rSnUvYWRtMDZlU2RyRk84RG5ENnJ5L053M0RWQU1SUzlV?=
 =?utf-8?B?YUNsWGJUQkh3UnF5N0t0T2NCcG84NStOR3h1ZlJxdFlHVVdRNzE0dzMzdlZw?=
 =?utf-8?B?bjVmaWVMdFFhSWtxUklUeldQWWtSWGxrWW4wbnVscTJmLzVyblFhVHlUbHBY?=
 =?utf-8?B?NzJIMjBjYjlnZmo1cHNJcUV4QkU2SXd2NGQvT0xrVEFEaWpNMDFrQ2hvb1py?=
 =?utf-8?B?OEJMRm03dzBTNy91ZTdtVDFRY3EzWi93NjdERUlSZWVyUXdJdnhLWW5IMFdO?=
 =?utf-8?B?ZVVGZ25od1JFOEN1TE5iZGI0c29hUk5VQTgwK1ZIWGdwbTNBYnpxbUFYZHJW?=
 =?utf-8?B?eUpMcUNiT21ZdXdCb2REUjRibHNaVGJUL2JRS3Jpd3BxNktWWmhlMERNdjBE?=
 =?utf-8?B?K1ppQ0FFMk5QU3VDaHVmT0dVc2hQNDJ6bGJReGZvc21kejM5VVJjRWJoT1pZ?=
 =?utf-8?B?am5ld1lmS2FaZW1YbnpxM3ppS01jTVBlMVBJSlNZbUxuMEFMWVVJYlNVOFYr?=
 =?utf-8?B?SVcvNVhINmJMUzV0Vm5MVTFaaDErWmFuWjdZRFFlMWdxWmpZY2JOZ3JmSkxV?=
 =?utf-8?B?NmpXM0dWSkJ4UHBWOUlwbmI1c2p0QXdBNkE2S2pnN0d1enZDMDVlOGZKdTI5?=
 =?utf-8?B?WEpLY0ZYeUs5bFJ5anpRWVpFVlhIc3piL2xuOEgvVHZpakFxQVZpMXh3UCtm?=
 =?utf-8?B?QmEvL2FYOXFTSjZkRi9YM1E4V2ZJRzgwMlJ0MHdZRU9xZ1dnQi9nK3VZaFdQ?=
 =?utf-8?B?Qk0rMDVMdGsyM1NWRWh0aVFxUlRPWE43S1RNNmJ0eGNDZEFYTWlseThEVVdD?=
 =?utf-8?B?dmNBVzhGSHRXUTJuQ05vUmYyVVM0dnJBYldCaFFlNDNPWitWQ3NUODdwN3Uz?=
 =?utf-8?B?QVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <79FA0A1F9D01484E966CDAA8F351153A@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5987.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee7a1913-e740-412e-3e81-08dbe6163421
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2023 20:05:24.0828
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qfAuhTrzTW8SKxVzPM5MJVJnOTk6wS/ewvFJ6PltiElNnfv/K9e+gdS1Pfj5f7sOqmdU3GDxQrfcB/YHFnl0kr6Q0goC4eWDXV8AvIJ1WHE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6297
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

SGksDQoNClRoaXMgY29udGFpbnMgYSBmaXggZm9yIGNvcmU4My01NSBmaXJtd2FyZSB3aGljaCBo
YWQgYSBzaWduaW5nIGlzc3VlLg0KDQpQbGVhc2UgcHVsbCBvciBsZXQgbWUga25vdyBpZiB0aGVy
ZSBhcmUgYW55IGlzc3Vlcy4NCg0KVGhhbmtzLA0KR3JlZ29yeQ0KDQpUaGUgZm9sbG93aW5nIGNo
YW5nZXMgc2luY2UgY29tbWl0IDEyNGI2NjM5NmFjN2E2ZGNlNzI0ZDA0YWM3YjNiY2VmMWRiMWQ1
NTE6DQoNCiAgTWVyZ2UgYnJhbmNoICdyb2JvdC9wci0wLTE3MDAwNjg5NjUnIGludG8gJ21haW4n
ICgyMDIzLTExLTE1IDE3OjI0OjQ2ICswMDAwKQ0KDQphcmUgYXZhaWxhYmxlIGluIHRoZSBHaXQg
cmVwb3NpdG9yeSBhdDoNCg0KICBodHRwOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9r
ZXJuZWwvZ2l0L2l3bHdpZmkvbGludXgtZmlybXdhcmUuZ2l0IHRhZ3MvaXdsd2lmaS1mdy0yMDIz
LTExLTE1LWZpeGVkDQoNCmZvciB5b3UgdG8gZmV0Y2ggY2hhbmdlcyB1cCB0byAxOWVhOWM5YWYz
NWVlZDdjMjEyZTc3Y2Y4ZjM2NmQxODBlN2M3NzkyOg0KDQogIGl3bHdpZmk6IGZpeCBmb3IgdGhl
IG5ldyBGV3MgZnJvbSBjb3JlODMtNTUgcmVsZWFzZSAoMjAyMy0xMS0xNSAyMTo0NDowMiArMDIw
MCkNCg0KLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLQ0KQSBmaXggZm9yIHRoZSBuZXcgZmlybXdhcmVzIC0gdGhlIG9yaWdpbmFs
IGNvbW1pdCBoYWQNCnNpZ25pbmcgaXNzdWVzLg0KDQotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQpHcmVnb3J5IEdyZWVubWFu
ICgxKToNCiAgICAgIGl3bHdpZmk6IGZpeCBmb3IgdGhlIG5ldyBGV3MgZnJvbSBjb3JlODMtNTUg
cmVsZWFzZQ0KDQogaXdsd2lmaS1nbC1jMC1mbS1jMC04Ni51Y29kZSAgfCBCaW4gMTg0MDExNiAt
PiAxODQwMTE2IGJ5dGVzDQogaXdsd2lmaS1tYS1iMC1nZi1hMC04Ni51Y29kZSAgfCBCaW4gMTY5
NTc4OCAtPiAxNjk1Nzg4IGJ5dGVzDQogaXdsd2lmaS1tYS1iMC1nZjQtYTAtODYudWNvZGUgfCBC
aW4gMTY3MDk0MCAtPiAxNjcwOTQwIGJ5dGVzDQogaXdsd2lmaS1tYS1iMC1oci1iMC04Ni51Y29k
ZSAgfCBCaW4gMTUyMDYzNiAtPiAxNTIwNjM2IGJ5dGVzDQogaXdsd2lmaS1zby1hMC1nZi1hMC04
Ni51Y29kZSAgfCBCaW4gMTY3OTc4OCAtPiAxNjc5Nzg4IGJ5dGVzDQogaXdsd2lmaS1zby1hMC1n
ZjQtYTAtODYudWNvZGUgfCBCaW4gMTY1MzgzNiAtPiAxNjUzODM2IGJ5dGVzDQogaXdsd2lmaS1z
by1hMC1oci1iMC04Ni51Y29kZSAgfCBCaW4gMTUwNzM4OCAtPiAxNTA3Mzg4IGJ5dGVzDQogaXds
d2lmaS10eS1hMC1nZi1hMC04Ni51Y29kZSAgfCBCaW4gMTYzMjQ2NCAtPiAxNjMyNDY0IGJ5dGVz
DQogOCBmaWxlcyBjaGFuZ2VkLCAwIGluc2VydGlvbnMoKyksIDAgZGVsZXRpb25zKC0pDQoNCg==
