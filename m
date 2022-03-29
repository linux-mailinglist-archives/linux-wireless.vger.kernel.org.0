Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35AE84EACB9
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Mar 2022 13:58:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236130AbiC2L7w (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 29 Mar 2022 07:59:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231537AbiC2L7v (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 29 Mar 2022 07:59:51 -0400
Received: from esa.hc3962-90.iphmx.com (esa.hc3962-90.iphmx.com [216.71.142.165])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EE852498A2
        for <linux-wireless@vger.kernel.org>; Tue, 29 Mar 2022 04:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qccesdkim1;
  t=1648555086; x=1649159886;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=SurCVjfY4qQZjUYlIQExU3RrnZD05BdEP6WrOV5m3gI=;
  b=Ro7Hj7p+tATQWYnsdLRKofeL/B0vovhhOShvjncLat1KuPwn1WIPdTtS
   T4xQCQwhtwL/krUfdhtzNsZWfYtrWTO7vQRSG4OQtO65OJoBJAHdrIkjC
   eGMnK7UzCSeKWZ4b6f8qUgnK44DWscq3TvXqodcVJbAVeRZLi+IEaSVZ2
   g=;
Received: from mail-dm6nam08lp2041.outbound.protection.outlook.com (HELO NAM04-DM6-obe.outbound.protection.outlook.com) ([104.47.73.41])
  by ob1.hc3962-90.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2022 11:58:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NGLbtK8V8xWm3NKVL0ZOJmqJF1sJUWHvEzmDHNPj2/g7oGWccE7i7E89EvN8s6v4f6KT7c3VxJ3XhqOgz1lEQu7Jov3bv1C95Bl9LD6fauZOhW4aa88ifp/q6n7jOg8uuVfdSCzfqZ1d9dKDL4PKLe1z3bRjJKm62NZrLp+zzNkVBrP8O1xa8yD7Y+B7T8DeEiO3pEW1fmy83ngj6V7HWG5xN+miPoH+MWXbex1/ptAlCXFRffQaT7tXT8iGn7jtCZOlIvr7s6edBL5AzKvDANlruyaQ0plAwo1T+lERXkZbsYWXC2ocbroiwsIcP7p+hqjAYK/k3Nhg/H7ajRNYSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SurCVjfY4qQZjUYlIQExU3RrnZD05BdEP6WrOV5m3gI=;
 b=fmda8d/6DA4hh2ep6P8+5/lvkFtyfdYBYNf61esgCag+ESjDYJvllNHa79PRiWpiteMhIzX9XVdvc9gJJHb63azjkV8n4QLVBNHsKH4EZbK+uWXinbDIpwxZw/WQZxZXjd3i7F7vot3n1FeWUADzTEZIOAO46/OPBy6aoVLtFRafDemlKKClcv5CStUnhb1i9YBnSKfDtUreKHizZzWXykkFynRPz6FTdNEa6Iqp6NugIRfZKijXeOGKGUx69loUDi2utIAZSXLNDq/LeR4UAR/N2HmOaqjzmsKXxzKsKL4dItvQkwNPgOvDPzyq0g0LtsV4PggMoilkg9pSBAt6cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
Received: from BL0PR02MB4323.namprd02.prod.outlook.com (2603:10b6:208:4c::19)
 by SJ0PR02MB7837.namprd02.prod.outlook.com (2603:10b6:a03:327::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.16; Tue, 29 Mar
 2022 11:58:01 +0000
Received: from BL0PR02MB4323.namprd02.prod.outlook.com
 ([fe80::85dc:f089:53fc:b99b]) by BL0PR02MB4323.namprd02.prod.outlook.com
 ([fe80::85dc:f089:53fc:b99b%7]) with mapi id 15.20.5081.023; Tue, 29 Mar 2022
 11:58:01 +0000
From:   "Sriram R (QUIC)" <quic_srirrama@quicinc.com>
To:     Johannes Berg <johannes@sipsolutions.net>,
        "Sriram R (QUIC)" <quic_srirrama@quicinc.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC:     "vkthiagu@gmail.com" <vkthiagu@gmail.com>,
        Aaron Komisar <akomisar@maxlinear.com>,
        "Jeff Johnson (QUIC)" <quic_jjohnson@quicinc.com>,
        Jouni Malinen <j@w1.fi>
Subject: RE: [RFC] mac80211: prepare sta handling for MLO support
Thread-Topic: [RFC] mac80211: prepare sta handling for MLO support
Thread-Index: AQHYQBzWRZGhnyINVUu+1ETsLsPQQ6zQD2EAgARn0ACAABRnAIABuSBw
Date:   Tue, 29 Mar 2022 11:58:00 +0000
Message-ID: <BL0PR02MB43235912B36C8AA0BB1A607EF71E9@BL0PR02MB4323.namprd02.prod.outlook.com>
References: <1648194497-15848-1-git-send-email-quic_srirrama@quicinc.com>
         <20abb029438166d02b5fb47093ea857671fa86e8.camel@sipsolutions.net>
         <SN6PR02MB433497C4F6E9BD97294488C5F71D9@SN6PR02MB4334.namprd02.prod.outlook.com>
 <644dd3e9fdb893245e4a31d681cb534f5197e968.camel@sipsolutions.net>
In-Reply-To: <644dd3e9fdb893245e4a31d681cb534f5197e968.camel@sipsolutions.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=quicinc.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3e1ca995-607d-4d60-268b-08da117b5fbb
x-ms-traffictypediagnostic: SJ0PR02MB7837:EE_
x-ld-processed: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d,ExtAddr
x-microsoft-antispam-prvs: <SJ0PR02MB78371B498CB11E601DC9AAE98B1E9@SJ0PR02MB7837.namprd02.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GPBycHQVrxgtpPXx1bG85KZk9FxQxZCyASdWQqnwkWPyRKXK7k1Q66fBSWVkG+pvI3Hph3gUd5eFbp0hHzS3Cca2UaEhHtYuQdaiu4MhlPD51mQJyhWoBXEW+yquZ5+Rp34fYYWvQKZJlWnzA4Qcdq17IPJ2QnUt0mnqfPSzusB4WHe27EhcJnhzmnfhydJHBEjSrYbmnMTNP0lbf2CNajIDVe7cV78UfD3G18m/C3JVwgcTTB3GhZEX2LeeF+F3qtQz8VFw2swblVs0U1gNJ0ZRk4RdG+1PkousR3od3eteLlehGRbUk3zkA3w/A5X4eJkK8Er3yqbKicofXZXm83VVI8tE91uERaWcy4wpnyqnXDpbvSteh317sl7qZfusiCpW6WG57GL7+jXwDefHviM/hj3BNxIAndJDy4UxrA5CNJBCKzgBjt3y21CT6aTvp9p/OEv/cGzWztoYKmatS6qtN2cTaRxQS4D4pXcwFYD9tGLX2mNwFS79ektRQaex62hNIYVCG+nXo1VTWavAis22kFB5aMJoicUP9VmErGAEGWoZVRP9Ul1Pdbr8bCNeaVphp4NzbXJCp8GqV1HgmsrfKH2I6p8lojiHeteSmdtQYqDAANR+elZ4bHtgXhl62WnI3WIA2pXyHHkO4GGQZRoe/asaFsRTBLN+g+YhFYAAKXJJ4q1+ds2jMkRbDNlXF/+WAVpaBWO7HxJyxN30xA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR02MB4323.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(55016003)(52536014)(86362001)(33656002)(5660300002)(122000001)(4326008)(38100700002)(71200400001)(8676002)(66946007)(66446008)(64756008)(66556008)(76116006)(54906003)(7696005)(6506007)(53546011)(9686003)(66476007)(8936002)(38070700005)(2906002)(110136005)(508600001)(83380400001)(186003)(26005)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TUZRTzJacHJHSHVuM2kvaTZBUitObFRNb2tlVGtkcmZ4bzRqbjMzckhwenNK?=
 =?utf-8?B?bDN4aTl3amVvbmhldzlCSktHMmhTdHRkRDRyNmNNU2NlbTUrOXZHV0s4cW03?=
 =?utf-8?B?YWpIMTZBeHF2czdreCtBeHpncmZLY3c0dDNnUkZ3eG12NGJKcys5VnVmdm1k?=
 =?utf-8?B?dFdTdDErMlZ4VHdkcHdtdVBqZDlBaTc0NGt2d3pUSlQ2d09IdWMxU1hpYlM4?=
 =?utf-8?B?WXdvNnFDM1VtNmtFa3RJOXRjV2NDSmxWbmxBbUF0eStVOFdZMFpwdHRmMzdN?=
 =?utf-8?B?RzF4bHBvRzJYcnZFOUdYK2dpTHZJV2hrQ21tS3VQYVVLa0JsR1ZQOWJEQks2?=
 =?utf-8?B?TGkyemhDbC9pUWljTjhNUW9xVkx1WTIxY3hGUFdJTkZSRUM1OTZtRTE5ekNW?=
 =?utf-8?B?Rk9EVjJjZDRDWTM2KzN2aDFVd1UwbDlablA4MmczdGM5OTZFYkNHSDA1YzJ5?=
 =?utf-8?B?Ni9sdzRjb1lhQVcxUkxvcnI2emJnd3RQcVRzekgvd3d6RVBidmdWYlhaYVpQ?=
 =?utf-8?B?ZmtIcC9DOUZFY01LeTEwcEtSVDFISnFyVUpoWWptY3B4ek0rZnU1YTdid09K?=
 =?utf-8?B?NWQ2dXA2N3hxMWhVRThBTmYveHNBNjNDTjk5QjBPd2ZTdDEyeTlQYmQ2VEhB?=
 =?utf-8?B?OFpFN0cxYVBscmlLQkF1SUg1dkVXOEdNdjl4RmNDUGVJRjA3eWZWcWJLR3hZ?=
 =?utf-8?B?MUJlVklsTnlrMVJmVzAwQnBqNW5aY0pMRjRJMkpBblBCSDh0YlREcXVSRzV0?=
 =?utf-8?B?dlBJTEpYcDN5VHNYakJTMDlLU1pRdkdSaFY0VXV2QVBqZGZ0Z2tXZ2NpYTVU?=
 =?utf-8?B?OWVXYzRWblRyS2R2N0lOeTBTcWdMVDBzQjBzQnNXSjFnYXh5NjVyUENzTzNa?=
 =?utf-8?B?eFo2a3N6L050em85d0ZDMUhkdHpCNkxSVThSN3dmY1YzbklacGxPUmxrdTl4?=
 =?utf-8?B?Z3BhREFuWmNoNW5xU3JLczNWWE9hVmRLV3Vjc3FYbkl0M3JqRVUwY1NiaEVo?=
 =?utf-8?B?Q3ZMVEpUZmk0K0RnZmR1bzc4blRsaG14dmw5SDNaVFhGZ05IWVpnYlhpNUc2?=
 =?utf-8?B?Sm5BRUo5Z2dTelhUOG1kWVgybDV3M0RYK2xNVm0vOGNIVnpZN09WL3hzRTlS?=
 =?utf-8?B?MmZGc2M1cVowcHFON3RiUXl0UFJ6QUhtRVVZcm9JRk5RVjh5SGt3OURwcE4z?=
 =?utf-8?B?K2hZLzAvZ3Zwa2FtUEZmcFRXbUJRa0x0Uk41TlM4dXY5U2JaMWhtM1grTEdI?=
 =?utf-8?B?NWtKVGUwTHBzTzJZR01jb1dTVzR0MXFFMU1OVzN3aW1EUTVUa0Q5QmpuQTBq?=
 =?utf-8?B?Q0I1TVpzV0JIa2ZtcnRMcWRxcGpnZ1cvOXd5K1V2cFVIdXcwa1oxNGY1N1Vk?=
 =?utf-8?B?dUJ2NitHYlV0L0VFaFJGSE5qYlBPaXFKZUtpRFNDTTd1djF5V3BITzZJZ3RG?=
 =?utf-8?B?YjQ3cjVGVzJCSmdVV1R1OTZyNzBUemVraG4ySEJGWFdOZ3p2bnR5aTRBU3o5?=
 =?utf-8?B?ZFB3OURSNGwzVnVibFErdUE0eTgyMER1dlZ6LzA5QW9JUlRSYnduQVJDbGND?=
 =?utf-8?B?VWhYVVpiNHhGRE15YW5jNnRadThpWnc1Rm5nMHJTcEFTeXNKWHhhWkdRbU90?=
 =?utf-8?B?cm5ySlVyaldOeGJ5NWdSWGpYZm5HRlJUTjhOamFoaTE1K0s3dVdlQWFPc3Vv?=
 =?utf-8?B?dWtKYTNld0EvWVNuMXY1NXJpWHdkZ2NkTms5ZmFXaW1XQTczWnc5WUJFT0gx?=
 =?utf-8?B?RHZVczM1aE9wQjJITWFwRXpNTldjWGVsMzFuaUdmZmRJVjBNVFpVSXA2VE1Y?=
 =?utf-8?B?MEFaQ2UvVjAxdFNTN0g4c1R3aTZoOGFhYnVCTWpoMHE2L0ZnM1hZcVVRbG52?=
 =?utf-8?B?dGxnTGxCVXJFb1lzbGtTZDQrWWtCRW9zSjhLWVpIWUlVYmdvY2Z4cXA4M2hp?=
 =?utf-8?B?Z1NLYUE4aTBENU1DM3k3M1JPTzNzSVVpalhLUy9PZENLRE9ENFlZUGs5UFN6?=
 =?utf-8?B?QmRPMmFBYTFnZjBrOTF1REJlRHp0R29YbUgxd3BOM2ZVS1dFYkQxMUI4OEwy?=
 =?utf-8?B?OUZnUmkvZk9VYWRVZ0VTeHZONExiYlRNdnNoV0Q5Zm9pNlpXSS9IWk9ib24y?=
 =?utf-8?B?enYycGUrb25PbDk3OXJqWGpCUXBQWWFkUzcyRmhFMnROQmh6bW9uZmVKNk9x?=
 =?utf-8?B?cSsrbEtjZk5UYjM3UTk2RXZwR0xSS3RDOTRpc1V4cklFOG10U2VsODNTK0lU?=
 =?utf-8?B?NW1PVldIZll5b0RScDFSSWxoZFFDQkVyaWVBR2pHYjZhNWRyUVh4SEg3TEdp?=
 =?utf-8?B?U2VRVTRwTU5GbFk0T3V5bFpKWWxlV0VUckk2MHNPZlRVSnZQUnIxZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR02MB4323.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e1ca995-607d-4d60-268b-08da117b5fbb
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Mar 2022 11:58:01.0315
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ls3K/A/r+ZpeIMcooSJNMf9XbJJWl86qB5X0E6s++8IH0VQCCaH1X2KOl00dE4xtJOF8jmPgxO6pvkScEzJMhXJOs9/pIL2nQsOg4jKe5n0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB7837
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBKb2hhbm5lcyBCZXJnIDxqb2hh
bm5lc0BzaXBzb2x1dGlvbnMubmV0Pg0KPiBTZW50OiBNb25kYXksIE1hcmNoIDI4LCAyMDIyIDI6
NTcgUE0NCj4gVG86IFNyaXJhbSBSIChRVUlDKSA8cXVpY19zcmlycmFtYUBxdWljaW5jLmNvbT47
IGxpbnV4LQ0KPiB3aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmcNCj4gQ2M6IHZrdGhpYWd1QGdtYWls
LmNvbTsgQWFyb24gS29taXNhciA8YWtvbWlzYXJAbWF4bGluZWFyLmNvbT47IEplZmYNCj4gSm9o
bnNvbiAoUVVJQykgPHF1aWNfampvaG5zb25AcXVpY2luYy5jb20+OyBKb3VuaSBNYWxpbmVuIDxq
QHcxLmZpPg0KPiBTdWJqZWN0OiBSZTogW1JGQ10gbWFjODAyMTE6IHByZXBhcmUgc3RhIGhhbmRs
aW5nIGZvciBNTE8gc3VwcG9ydA0KPiANCj4gV0FSTklORzogVGhpcyBlbWFpbCBvcmlnaW5hdGVk
IGZyb20gb3V0c2lkZSBvZiBRdWFsY29tbS4gUGxlYXNlIGJlIHdhcnkgb2YNCkhpLA0KPiA+ID4g
VGhvdWdoIGlmIHdlIGZvbGxvdyB0aGVtIHRocm91Z2ggcG9pbnRlcnMsIHdlIGNhbiBzdGlsbCBh
bGxvY2F0ZQ0KPiA+ID4gdGhlbSBpbiB0aGUgc2FtZSBtZW1vcnkgY2h1bmsgKGp1c3QgYWRkIHRo
ZSBzaXplcykuDQo+ID4gRG8geW91IG1lYW4gc29tZXRoaW5nIGxpa2UsDQo+ID4gbHNpbmZvID0g
a3phbGxvYyhzaXplb2YoKmxzaW5mbykgKyBzaXplb2YoKmxzdGEpLCBnZnApOyBsc3RhID0gKHU4
DQo+ID4gKilsc2luZm8gKyBzaXplb2YoKmxzaW5mbyk7DQo+ID4NCj4gPiBUaGlzIHNlZW1zIGZp
bmUgSSBndWVzcyBhbmQgaGVscHMgdG8gZG8gYXdheSB3aXRoIHRoZSBzZWNvbmQNCj4gPiBremFs
bG9jKCkuIENhbiB3ZSBnbyB3aXRoIHRoaXM/DQo+IA0KPiBOZWVkIHRvIGJlIGNhcmVmdWwgd2l0
aCBhbGlnbm1lbnQgdGhlcmUsIGJ1dCBvdGhlcndpc2UgeWVzPw0KU3VyZS4NCj4gDQo+ID4gPiBO
b3Qgc3VyZSB3ZSBuZWVkIHRvIG9wdGltaXNlIGFueXRoaW5nIGhlcmUgdGhvdWdoLg0KPiA+ID4N
Cj4gPiA+IE9yIG1heWJlIGluIGFkZGl0aW9uIG9yIGluc3RlYWQgd2Ugc2hvdWxkIGFsbG9jYXRl
IGFuICphcnJheSogb2YNCj4gPiA+IGxpbmtzPw0KPiA+ID4gQnV0IG9mIGNvdXJzZSBvbmx5IGhv
d2V2ZXIgbWFueSB3ZSBhY3R1YWxseSBuZWVkLCByZWdhcmRsZXNzIG9mDQo+ID4gPiB3aGljaCBv
bmVzIGFyZSBhY3R1YWxseSBhY3RpdmUuDQo+ID4gVGhlIGFycmF5IG9mIGxpbmsgcG9pbnRlcnMg
YXJlIGFscmVhZHkgYWxsb2NhdGVkIGFzIHBhcnQgb2Ygc3RydWN0DQo+ID4gaWVlZTgwMjExX3N0
YSBhbmQgc3RydWN0IHN0YV9pbmZvLCByaWdodD8NCj4gPiBEaWQgSSBtaXN1bmRlcnN0b29kPw0K
PiANCj4gQ29ycmVjdC4gSSBtZWFudCB0aGF0IHdlIHNob3VsZCBwcm9iYWJseSBrbm93IGhvdyBt
YW55IGxpbmtzIHdlIG5lZWQgdXANCj4gZnJvbnQsIHNvIHdlIGNvdWxkIGFsbG9jYXRlDQo+IA0K
PiAgICAgICAgIG5fbGlua3MgKiAoc2l6ZW9mKCpsc2luZm8pICsgc2l6ZW9mKCpsc3RhKSkNCj4g
DQo+IGtpbmQgb2YuDQo+IA0KPiBCdXQgdGhlbiBhZ2FpbiB0aGF0IG1pZ2h0IGJlIG1vcmUgY29t
cGxpY2F0ZWQ/DQo+IA0KPiANCj4gV2UgbWlnaHQgYmUgYWxsb2NhdGluZyBhIGxvdCBvZiB0aGVz
ZSAtIHNvIG1heWJlIGl0J2QgYmUgd29ydGh3aWxlIHRvIGdldCBhDQo+IGttZW0gY2FjaGU/IEJ1
dCB3ZSBjYW4gYWxzbyBkbyB0aGF0IGxhdGVyLg0KTWF5IGJlIEknbGwgZGVmZXIgdGhlIGxpbmsg
c3RhIGFsbG9jYXRpb24gY2hhbmdlcyBkb25lIGZvciByZWZlcmVuY2UgaW4gdGhpcyBSRkMNCnVu
dGlsIHdlIHByZXBhcmUgYSBwcm9wZXIgcGF0Y2ggdmVyc2lvbiB3aGVyZSBJIGNvdWxkIG1ha2Ug
dGhlc2UgY2hhbmdlcw0KYmFzZWQgb24gc3RhdGlvbl9wYXJhbWV0ZXJzIGJlaW5nIHBhc3NlZCB0
byBhZGRfc3RhdGlvbigpIG9wIGFuZCBkZWNpZGUNCmhvdyBsaW5rIHN0YXRpb25zIHdpbGwgYmUg
YWxsb2NhdGVkIGFuZCBhZGRlZCBpbnRvIHRoZSBNTEQgU1RBDQooY29uc2lkZXJpbmcgYWxsIHlv
dXIgYWJvdmUgaW5wdXRzIG9uIG9wdGltYWwgbWVtIGFsbG9jYXRpb24gZm9yIHRoZXNlIGxpbmsN
CnN0YSkuDQo+IA0KSSdsbCBzZW5kIFJGQyB2MiBzaG9ydGx5IHdpdGggdGhlIGRlZmxpbmsgY2hh
bmdlcyBhbmQgc3BhdGNoIHRvIHVwZGF0ZSBhbGwgZHJpdmVycyANCmJhc2VkIG9uIHRoZSBuZXcg
bGluayBzdGEgc3RydWN0Lg0KDQpUaGFua3MsDQpTcmlyYW0uUg0K
