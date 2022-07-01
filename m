Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C13A562FBE
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Jul 2022 11:22:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232405AbiGAJWC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 1 Jul 2022 05:22:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231781AbiGAJWB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 1 Jul 2022 05:22:01 -0400
Received: from esa.hc3962-90.iphmx.com (esa.hc3962-90.iphmx.com [216.71.140.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB3AF58FED
        for <linux-wireless@vger.kernel.org>; Fri,  1 Jul 2022 02:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qccesdkim1;
  t=1656667320; x=1657272120;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=9cwqWOdAFiWPPt2gOtwgyZSM40qWuuI9TG0yu2cSP6E=;
  b=WeBxQwT5GrRSwLxPzvHF7JxR1f0Jlom4rPvREZ3ny/8XTUNFGZNsTOT7
   a0y6HX9wEK+hngS+F7I4aJiiRXwaA+NPuMpoC5SZIOtPFkvkuQchLFcb9
   Sw2I3YpNIJ9pTi0D1pkFCiNhx0GobZb5jx/JlM1sbhMfUUp4yuihq3n4S
   E=;
Received: from mail-bn8nam12lp2172.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.172])
  by ob1.hc3962-90.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2022 09:21:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LQDozExcS7uED1f6YDii84EltxeDPyOT3nHo+rltYa99yFnEqOrAnY6y4Y85fMKShXV2tXxGDQm5ThaRA9GiV1ImD6W8MwuParVnfO0F1dtmDeTUk3Ka7vCtMPJnFjQipwkTUGFd7caBLd7FAPKHoxGFp3ryVyDUT9lFPpAS5mO6d/fN4WUDRkvAsWcF3eNUqp8kjcm0bNIGny3FaSS4EV2Xl0eboMBQGt9Q6lCTdpkmkcMHQG/AcA2/UpEbaHTwHRzL1EqYHky8bOVMzo0fvXylZf+YBo9gbhXHl9Ir48GGemw6HAGl00JGvPGnmYw0ZGeOB4UwJOzMh5sx3A1UwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9cwqWOdAFiWPPt2gOtwgyZSM40qWuuI9TG0yu2cSP6E=;
 b=fQbkDbE6wGMJXlE1but9I9Faxl/W071cWW1h1IYgY+MNT5NvtbS2O7Vq45m8pNqX1c/sFnDnCsqN7cwXjm7AZVLCCGt+2dNxuLVPOjZ26cdc4eDv08WdPfdNtNsupkjaVaDLVJB3aeMDM2cFpZNKfI7bZn77P+P7fSKKM3iBA776AmtuRvImjZ7cnIyP24PoUo6IUMzDDPk+OtA39tsYI/T2LMlL6g65LajtcLQL7/ik8jKLurFtLewDTvyOH9Oy/ySXuT+PpqFj/C3p4WXJ7jx0mztRsIqyRatte8z1oN17zW9wJhG2mcUaBdpAMOEcKd914Yh4LbYCmWBfONleeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
Received: from SN6PR02MB4334.namprd02.prod.outlook.com (2603:10b6:805:ac::20)
 by CH2PR02MB6887.namprd02.prod.outlook.com (2603:10b6:610:8d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14; Fri, 1 Jul
 2022 09:21:57 +0000
Received: from SN6PR02MB4334.namprd02.prod.outlook.com
 ([fe80::70cb:fc3b:3525:43b7]) by SN6PR02MB4334.namprd02.prod.outlook.com
 ([fe80::70cb:fc3b:3525:43b7%7]) with mapi id 15.20.5395.015; Fri, 1 Jul 2022
 09:21:57 +0000
From:   "Sriram R (QUIC)" <quic_srirrama@quicinc.com>
To:     Johannes Berg <johannes@sipsolutions.net>,
        "Sriram R (QUIC)" <quic_srirrama@quicinc.com>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH 0/3] Mesh Fast xmit support
Thread-Topic: [PATCH 0/3] Mesh Fast xmit support
Thread-Index: AQHYfLaXMbJihDi2mEOB7VV8wA6h161pVU0AgAAGcSA=
Date:   Fri, 1 Jul 2022 09:21:57 +0000
Message-ID: <SN6PR02MB4334670B5FD85EB6940A64F8F7BD9@SN6PR02MB4334.namprd02.prod.outlook.com>
References: <1654857639-12346-1-git-send-email-quic_srirrama@quicinc.com>
 <98e3a2743ab770fbd3f14dca14b62105c8457bf6.camel@sipsolutions.net>
In-Reply-To: <98e3a2743ab770fbd3f14dca14b62105c8457bf6.camel@sipsolutions.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=quicinc.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8c98750e-58e4-45e0-7ae5-08da5b43252e
x-ms-traffictypediagnostic: CH2PR02MB6887:EE_
x-ld-processed: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yb/WmkeJXrIDc2GONB/MS1Cf2w4DQtvoKC43ybfcGZ7j5ICSO8AYKrZe/LOpJYrFuCvR+bZG6yo8Qd1ggODAsczr1Rh+TBQPru2SDLyIRpF7iUGJhRIfv+qtmJ1ULRHubXEg5BLbEzdz40EHleknKJAK9XR6tiQhDNRhP2IdkCZFXsgm1x2LXG1KspN8Pr+tU9I5OqOKa8vWRI1jbMpW7F5OW82RiF4MPpbw59eXENSLIgINEntxAe9xJgAqgyszYkv8eEpUVR2mp605U01cymnpz9ROIoFfseWXSRL83w60tIl7P+B5OnmncFhcbWnk0NSL+EMoAa+aXb99vKhPFA7kJ6q6kGErcbNZXWuV6Sy2tJP9hZQ2xjyL+2A+NaenPudHpfpfGE1OjvejRKP7yJpwUexiY5EScyFrzcXKGdgIwCK+iG8NZBDOAQxg4A8lalID3gx6qX1pYBGgucfrPzRv3ceBQ4jEmsQGCf+PYiHJf5ZYPStXQDK2tZdvYnvBvv4zvvMKVWEiVI+gw4TPqYvVHAgnPLy3J8TCFX2qeVJa8UYaJK5BQPAsIr9e1onn+LWEpSFhUBXl0w27Ac0nZTYP/XIOHjIGFF/Sm/lYiuYP9z/w9AQUtYAPAqHafJpI37/6eN0WZzLi3oAT2AXfn3cawU0xTenKr7N0x3lrjuvs9AN317/cAJCMb3+owftJjprNGy/dOmhLUk5eBCFIAGcaahHCQ7+CFSowuI1dTnHzfdCXNwK1TAG6l9gDIUfALjykVH0MwxnjnojhYlKva76LHG1V1P4v8y2BJ1FoxuR9Pmu+kr0OXejG1bTpQ6v5
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR02MB4334.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(396003)(376002)(366004)(346002)(39860400002)(86362001)(122000001)(38100700002)(83380400001)(2906002)(33656002)(5660300002)(71200400001)(55016003)(478600001)(8936002)(7696005)(110136005)(186003)(76116006)(316002)(41300700001)(38070700005)(6506007)(64756008)(66446008)(66946007)(66556008)(66476007)(26005)(4326008)(9686003)(8676002)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dDI4TzRwYzFTYWp3ZERlMmN5YzVTSHA0akJ0T3Z1NUIvTkFuM1J6UllndVlZ?=
 =?utf-8?B?ZWFZdmw0dDYxYXQ4cTVIUUp5WTlJQjJvMlVhUkU2b1NTTnJlRFJpZktSZUpW?=
 =?utf-8?B?QXUzdEdZSW5jQ1RsNjJLeERXbWVpaXRGMVJ4M2ZqTjc2VVdmM21yOUNxUU9X?=
 =?utf-8?B?VHZwR2x4d3dPNEZMN3hpN1E0V1R6WWtEN1NiR0R2SnhEbktzbFNPZ0d2OGxu?=
 =?utf-8?B?UmdoMmVMeUg4cVJ0VTRGeVRubGh5VlIxcEIyc3kxM0MzZU9QYnhlME1zaWlr?=
 =?utf-8?B?bklTY3IvaFB5ODJGNk94Y0Z0d2t0N3dDNlRtd0xyV3VoTHo2UmxWVG1KYVRW?=
 =?utf-8?B?YzZ4QVZzcVBjMkNvL0lCYWorLzVVZjY5REM4QnIzbCtUYTB6RWgzbjBBdFJE?=
 =?utf-8?B?ZE10L0haU1dscDFYS1dnRHdmODVwUm1rbXUyWnRrc1ZwN3U4ZjYvbFRrbGRP?=
 =?utf-8?B?aGlPQUFURFpKN1RZTms3TFRsYzgybGs3cjdURzJZWHdTMTNySUpVc3pSZkhD?=
 =?utf-8?B?RlFIT3hxQittMGV0MTJCY2k2WWRJVWQzd254aHV4dnVMNjg4RUt6OUZxSnhn?=
 =?utf-8?B?aFMvZVl6anhtZklmTFh3ZEdCaHZNK28vQlMySFF1OUdoUVlnUGVDZlU4RExN?=
 =?utf-8?B?Z0RXb294Ym1xTGo5dnN2U2dhZnBvWW1IQU5uWnhsWGxUSHN4Vnc2dVNBOFVq?=
 =?utf-8?B?SXIvMXd3b2JBbllnRlZSc0gwRlVWU3M5TlNYRkRWTWUrbEx1SHoyall4QkdZ?=
 =?utf-8?B?YTdEcG96YmM5UUVSajNRaXhCNUg1UnhWN2NPMWFoeFFSZ0RwTDIwS1U5TlRU?=
 =?utf-8?B?cTRiY0JUZFRUaWJEYzJOcEFxU2tQYm5EUWJhUE1Jb3FwdE9SZktXaXc0dkQ1?=
 =?utf-8?B?WEhvQkdEbEdncHZqRmc0dWhNRkVmN3VRUFVkQzA2ckxBMmdibkdJNXVKYTRN?=
 =?utf-8?B?Umc5VHpwVUZlVUk0TTNpZlRCTU16UjJxalNEVnFFTVZ3V3RSLy9ROEw4TTZo?=
 =?utf-8?B?QVNZNlZpNSsrWnRxZzdZSENCd0JlWFk0ZjRQbjdCVXdIenRJYmdnLzhpa1ZH?=
 =?utf-8?B?YnA4N1l5MFhnbmhhWk1zZy9sS1UyOGFCcUxIQU41a1FkeHlQd1NXUkUzOGxK?=
 =?utf-8?B?aEY3ZnZHaEU0N0RmdEtVdjBFRHpqWnhXZ0Q1TE1HZWNYbGU3N0tFSmNvaHll?=
 =?utf-8?B?MldaekVaS0t4eG4yblRNYStXZjRDRnZUZEdnbWk3dEh1aWVtb25aWFZWY2hD?=
 =?utf-8?B?OFdFSXhjcVVxbGdGZERNNHpaa0lPcHc5Q3UvYUp3MTRhZGlRZGJHbXgvRHpJ?=
 =?utf-8?B?VkZqZnBvRTNRWUhGRlhRTlgxVUozeHEzS0dYdmJ2alJYS0s3aTArMXBJMmww?=
 =?utf-8?B?cm9NSWcyKzZCZW1tQ2NiKzE2VDlRQjNDS0h6MThWY2NjRWF0b29xU3BNV3dn?=
 =?utf-8?B?U0R5VjNtMjdlaWFRVklzYjZ1akYrSCtTOHMvSjlRVzJoeDJ4WFZaTDF0Q2d1?=
 =?utf-8?B?ek1nUnFkTzhQV0lkMVBLU1ovWFN4UEZIVnpKVmhnc1Z3cmFCRTFTaUUwNkR4?=
 =?utf-8?B?a0tLc1NicS9mSFNoR2k5Um85WUViNjZEc25LS2FQcEJYTDhEbjdJTGdaTnZn?=
 =?utf-8?B?cTdCcXlPemVNR09wR3MyVElzSU1jYVJKRzFrd25RS0U1dXB1VjBieGlvdU5K?=
 =?utf-8?B?WVhZdWoyVGczTDVzR3JpbExPRFJvZ3lBMUd3WkdSYkVtYUdsTnVSemtxYW8v?=
 =?utf-8?B?ZG0yUitDaVdkaEdLV3ZMZTB4Y1lWUVR0dVZrZ2RuRWtJeFA1ekQ4WGQ4MmlR?=
 =?utf-8?B?Z1FmaDVjdWUzUFdvK3hOV3kySVNYb09SRWF2dWdBQXhmbXhmUHdLVDJVYWh0?=
 =?utf-8?B?bjIxemZFMXVpa1hvR1NxUlEyN2VNM20xTnR4U1JEK0ZVZndtQXBpVUNqZ1lW?=
 =?utf-8?B?UzRHb1BXVUFOeGtDY3hWbi9MRnAvOE9PZmxEaWVvbjFsNzFSdk5yOTQvN09F?=
 =?utf-8?B?T2tucTBmZG0vZkQ5ZE85eGw0VmVPL2xjbkFjSzJvc0xsRFZLa2hyQnAySTdJ?=
 =?utf-8?B?eUY5K1hEMTU3RFRJT3orUjVtazdRU3FmeStFNUlVeS93Mk10bXFOTmFkbVJI?=
 =?utf-8?Q?/VrVLz5wrIqAe9AazO99rUiw6?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR02MB4334.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c98750e-58e4-45e0-7ae5-08da5b43252e
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2022 09:21:57.0617
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4L5i7RiQYiIIQhtuci6zR7qHfK9ffZcroVVbedf4Oi2R1EcrQ91V/ilpxuFwG0n9HHQZmzzuMH/Yxjt5gvg5leI5TYEHone1w4CQZHYOxgo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR02MB6887
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Pi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogSm9oYW5uZXMgQmVyZyA8am9oYW5u
ZXNAc2lwc29sdXRpb25zLm5ldD4NCj5TZW50OiBGcmlkYXksIEp1bHkgMSwgMjAyMiAyOjE5IFBN
DQo+VG86IFNyaXJhbSBSIChRVUlDKSA8cXVpY19zcmlycmFtYUBxdWljaW5jLmNvbT4NCj5DYzog
bGludXgtd2lyZWxlc3NAdmdlci5rZXJuZWwub3JnDQo+U3ViamVjdDogUmU6IFtQQVRDSCAwLzNd
IE1lc2ggRmFzdCB4bWl0IHN1cHBvcnQNCj4NCj5XQVJOSU5HOiBUaGlzIGVtYWlsIG9yaWdpbmF0
ZWQgZnJvbSBvdXRzaWRlIG9mIFF1YWxjb21tLiBQbGVhc2UgYmUgd2FyeSBvZg0KPmFueSBsaW5r
cyBvciBhdHRhY2htZW50cywgYW5kIGRvIG5vdCBlbmFibGUgbWFjcm9zLg0KPg0KPj4NCj4+IFNy
aXJhbSBSICgzKToNCj4+ICAgY2ZnODAyMTE6IGluY3JlYXNlIG1lc2ggY29uZmlnIGF0dHJpYnV0
ZSBiaXRtYXNrIHNpemUNCj4+ICAgY2ZnODAyMTE6IEFkZCBwcm92aXNpb24gZm9yIGNoYW5naW5n
IG1lc2ggaGVhZGVyIGNhY2hlIHNpemUNCj4+DQo+DQo+SXMgdGhlcmUgcmVhbGx5IHRoYXQgbXVj
aCBwb2ludCBpbiBtYWtpbmcgdGhhdCBjb25maWd1cmFibGU/IEkgaGF2ZSBubyBpZGVhIGhvdyBh
DQo+dXNlciBjb3VsZCBwb3NzaWJseSBzZXQgdGhpcyB0byBhIHJlYXNvbmFibGUgdmFsdWU/DQpI
aSBKb2hhbm5lcywNCiAgSW5pdGlhbGx5IGl0IHdhcyBzZXQgaXQgdG8gYSBkZWZhdWx0IHNpemUg
b2YgNTAgd2hlbiBSRkMgd2FzIHNlbnQuIFRoZXJlIHdhcyBhIHN1Z2dlc3Rpb24gdG8NCm1ha2Ug
aXQgY29uZmlndXJhYmxlIHdoZXJlIHVzZXJzIGNvdWxkIGNvbmZpZ3VyZSB0aGlzIGNhY2hlIHNp
emUgcHJvcG9ydGlvbmFsDQp0byB0aGUgcmVxdWlyZWQvYW50aWNpcGF0ZWQgbmV0d29yayBjYXBh
Y2l0eS4NCj4NCj5NYXliZSBpdCB3b3VsZCBtYWtlIG1vcmUgc2Vuc2UgdG8gYXV0by1zaXplIGl0
IHNvbWVob3cgZGVwZW5kaW5nIG9uDQo+bWVtb3J5PyBPciBqdXN0IHBpY2sgYSByZWFzb25hYmxl
IHVwcGVyIGJvdW5kIGFuZCBsZWF2ZSBpdCBhdCB0aGF0Pw0KPg0KUmlnaHQsIHNldHRpbmcgYSBn
b29kIHVwcGVyIGJvdW5kIHNob3VsZCBiZSBhIHJlbGF0aXZlbHkgZWFzeSBvcHRpb24sIGlmIHdl
DQpkb27igJl0IG5lZWQgdGhpcyB0byBiZSBjb25maWd1cmFibGUuDQpUaGFua3MsDQpTcmlyYW0u
Ug0K
