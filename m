Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA7954F18A2
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Apr 2022 17:40:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378634AbiDDPmm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 4 Apr 2022 11:42:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378631AbiDDPmj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 4 Apr 2022 11:42:39 -0400
Received: from esa.hc3962-90.iphmx.com (esa.hc3962-90.iphmx.com [216.71.142.165])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 529E7387B9
        for <linux-wireless@vger.kernel.org>; Mon,  4 Apr 2022 08:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qccesdkim1;
  t=1649086843; x=1649691643;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=lEPSPo/4E1YP+o6PNNCR2C2egQ5Z60zwYrjQMuWn4PI=;
  b=sEI7RpwXEJm3JxCJAB7CLCXOoALqVawNY395uywihJb4YRhgdjNNqhdq
   E4cWBcUP9SZnj+T9QRHmrBolyl+G925zXb8+gTEhlmUlcoqL4eDvSBfD7
   0KdCmEFMAZLmzo2n+GNb1OcyAWziAA2Tjd9VNSwtGK3d1Gp4STJpLcY/Y
   k=;
Received: from mail-bn8nam12lp2174.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.174])
  by ob1.hc3962-90.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2022 15:40:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FLg5aWoll9Y+9vasfye+TTFuCmCUmhcJiIgy07GsqBPI1BIEfHM2Pf1cPux3OY4IhLC2jSSnmZTBD8xTrw3eGQWeAGOzs9z0h3yOdRxXuRw1Eyi51ecISCagGCRPntIXNZFQDmxV3RUEvm6EHA7safqjKRpj8b5vglolzkea10Np7SLuF55uxmosJ9rccPClNwIvMEkrfZ9dYHD7fo6ZRNjnIuJquEk/4QdS6XDVokpkNFik7TE7x63yOpDvp2OPh+0JvYhecczgJJuL1yMNZXCp2Urnu6Whe1mhytUkHut0ZZKUlzSm4cTdRtAJkjdVGd6aH9CA/EGjV4T734aRpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lEPSPo/4E1YP+o6PNNCR2C2egQ5Z60zwYrjQMuWn4PI=;
 b=SRJbfqBK2qn3+xR3VV+m65UEseDMYlvHH9BskBrRoUNjq0ej0pXzvQVMFuSELNu/sAjiUfe2OBGolLfUkKcEC5fQFhIh4yFTqgDwPKN/eH8uxU7VBqk/YdtyuJ7CY0ukaXhj+afybSkHkVJp37/BD13Uyhy0eWIDnFLqNZB7veLGl9Awzz2GZcMwFTHDogjBD8cDHDJZYfn7D4akf4izQ6COmolmpddVTfDmI8NUDKzLUWRVKWvP+3iJADXkx5CXw4YdcbrSCP2Qvkiq6VXSO170WMTcZtk7RsUTzMYmds0wVBLxDJgVMnHmEjRDP7Y4b01Ai61+sQmpyBl3ik81cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
Received: from SN6PR02MB4334.namprd02.prod.outlook.com (2603:10b6:805:ac::20)
 by BYAPR02MB4614.namprd02.prod.outlook.com (2603:10b6:a03:5b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Mon, 4 Apr
 2022 15:40:36 +0000
Received: from SN6PR02MB4334.namprd02.prod.outlook.com
 ([fe80::e5a3:e283:efc7:a889]) by SN6PR02MB4334.namprd02.prod.outlook.com
 ([fe80::e5a3:e283:efc7:a889%5]) with mapi id 15.20.5123.031; Mon, 4 Apr 2022
 15:40:36 +0000
From:   "Sriram R (QUIC)" <quic_srirrama@quicinc.com>
To:     Johannes Berg <johannes@sipsolutions.net>,
        "Sriram R (QUIC)" <quic_srirrama@quicinc.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [RFC v2] mac80211: prepare sta handling for MLO support
Thread-Topic: [RFC v2] mac80211: prepare sta handling for MLO support
Thread-Index: AQHYQ2ShGJYmZDfjMUStBmBUa2Mr6azfx1IAgAAjhgA=
Date:   Mon, 4 Apr 2022 15:40:36 +0000
Message-ID: <SN6PR02MB433476576476A9AA7EAF3F95F7E59@SN6PR02MB4334.namprd02.prod.outlook.com>
References: <1648555198-8065-1-git-send-email-quic_srirrama@quicinc.com>
 <467e7f83270a9b1f8e2b32f27b48607e2c2ff480.camel@sipsolutions.net>
In-Reply-To: <467e7f83270a9b1f8e2b32f27b48607e2c2ff480.camel@sipsolutions.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=quicinc.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9fe747b2-5fa2-4a9e-831e-08da165176d9
x-ms-traffictypediagnostic: BYAPR02MB4614:EE_
x-ld-processed: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d,ExtAddr
x-microsoft-antispam-prvs: <BYAPR02MB461420140B94ADBB2D60E2528BE59@BYAPR02MB4614.namprd02.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JN7ksblCV3jOb40Ywithvwvk9GXVlk5rCsqbMezcYhBP7CpFn8dOzJuSMyuENJZQONohT6Auzf2qwDpg0w9NB7mjVtifRINCugqtiUSKIPe6LwAEIOGVenryppOcgo2kvj0BLIKyWQMhG8XiTtatwppfSyNieaha3eQGcdlnBAyYJZsF/nSnp+KsPlyV9vhfcfSte7LNAjvys3+SzXtoqFlJP016Wa+pfPsQEKFCu1tiTRw62D70V/Y+OTnjyDdNLExEIVhg1a2wl3FoIW9XvBXPYYYBt7YounAm0NiOwkIubmiQ0gJbFf7H/ZlfGRU9Q4DWsviaZK7K0QYPZudKUIDt67uVJbmrmkl9/307AhyuG9T/sT75fUkG3h8dw5T1vFE1w0PeoRyjmudhYGtc3R4+w3jPrteikpAh8UkqZheOtld1tsb6hvQpzNgvtuDCqOnmi5SOiEy5/M0N7rO2WKDZw2pDG/5BH4docOXzdDFhGkqfpZh/frChUBThyT9REDS20WKhqGXDCss87hJBZ+byiMwUlLBN6Xl+8PTXT92HalJD1RVlke2E+WFt6q+FLUQet55NJwfizRzgwPfeW8DrG2EKyQKPoSPm6gXBUEhcT2mHMF1rsXoH53Lq8JtSGPcL/iZPeUITZl7vzDye0bSFQpBpbtgXtwCLiJbsGVa9r55qNrGjGeH2VOeGDR5xv2D1iPQPq36Fc6QOKnAS6Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR02MB4334.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6506007)(7696005)(8936002)(33656002)(2906002)(86362001)(9686003)(52536014)(38100700002)(4744005)(122000001)(5660300002)(186003)(64756008)(66476007)(8676002)(38070700005)(26005)(316002)(55016003)(110136005)(66556008)(66946007)(71200400001)(76116006)(508600001)(66446008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R3FsSkNkMnZRVWVKand0RzZjdXdEU21MUkRDTmlySmRnT3YvZ0lXQmYzNmVV?=
 =?utf-8?B?aWw1SkVSRjRQUHBTSW9lY3NzWmhpYTR6a0FMY0FRaWlISFl4NmFPV3FJenQv?=
 =?utf-8?B?RG9sb09XZ3M1TTZyYjlZQXJyOFdaNVdtZ1UrcS9IaXpRcHhKZHZLcjh0bWht?=
 =?utf-8?B?NDc0OEY1WWFMSkpoSEMwc0ZobTR5cXpuN05DVEpUNGJyaW5WOGhLMHA3K05C?=
 =?utf-8?B?RXJEZ0V1VDZhUUF1L1l2dkJTblZQNFA4MmFSWjdmQ1loamtjTzVyVEJMWmxU?=
 =?utf-8?B?Tk5zK2JOZG02RHV1UE5Qd0RIRHk3bVhLOGpDTkdEbS9IL25kc2dVd0NmM0tZ?=
 =?utf-8?B?WW1xSUNQRkM2eWkxNUJsSDE2ZkhCVFdXWnZlUXJLVzRrN3dwNysxZ29rY2Zu?=
 =?utf-8?B?U0ZPQS9oR3BVSlNScDhxT3JYYTFuK05aSi94dWxkL0sxQUFGSTlPWGtrcXJY?=
 =?utf-8?B?V3d5WW9hNEZUNURwWDM3eTgrR0psZDRBODZzZGc0U3JOdlZ5UEVYaXREQTJC?=
 =?utf-8?B?dEExM09hVUNYN1lpNUxuUTZnWURvd0UvNG93aXFxeURieFRSSWp3Sm5DZWMz?=
 =?utf-8?B?VlNIT1kvWHZSSG9VZ0JEU3JQVUZVOHdIY3ZtSUF5NlQxOCsxWDg1TnZGdUdv?=
 =?utf-8?B?blpuT2NjK2ZGMTc4V3h4d0hTUEF3TTZjU0RDNVNJUWp6OGcyRHJQdG5vbXdv?=
 =?utf-8?B?SldXQzl1QWdXQWoxZXJodWljQWNrbW1LVk1NTlIvb3YzVE0wVVZsTWlTYStH?=
 =?utf-8?B?aFk2NVNnVGxVWWNCQ0x3UUNPS1ZqZmg4ZGllZDVJb0w4V1FyWDM4ei9VZnhO?=
 =?utf-8?B?V3pxMElsbExFeTIrQnhtS2V0UVAzK09UQ2hyakUyYzgrTlU3L0E1aVZ5NkRT?=
 =?utf-8?B?YzQxTGp3Uncrd2c3aHRYQ3ZKQlYveThFNU1lOHlVYjU0RVhBaGQ4VHFkTGpB?=
 =?utf-8?B?QmxtSW9PUFNKMnRQTFJiUk8rTkk5VEV2TVdOVFJyMkY0c1J6TXQ1d0JQMUwx?=
 =?utf-8?B?TWtOdkpXZm1FVG9iLzRlWEQwL2g1M0xNOVViZ1orcXBoNDhtTEdVU1ZWdFBL?=
 =?utf-8?B?QW5Tb0ZUUzhQd0JULzJoMDZNS2c0aUpVcHdLanBtUkYzWVg3WFIvYUhUVy85?=
 =?utf-8?B?SWtJcEV0Znd4TWoxZEdmSnNSODlMY2xZZlc2Q3JuNmhiNkR3eXMzbVNtUDF0?=
 =?utf-8?B?ZVlpNnduMS93SlFaVGs5ZStqeWtpVW5xOWhMcDA0UWlZaWR6dGtpR1FKQnNZ?=
 =?utf-8?B?T003dTlwUFBneVoybFB6NHN6bDJFVlVIa0pLbWpDUmw4UHdjTU9XT2NBMjZR?=
 =?utf-8?B?SzhCTjdkWW1qSVdyMHRnMFdWaEZBeUtoamNmNklvT3pyQ21YWVpDM0RqMHgx?=
 =?utf-8?B?clVtM1R4L1czMzFOYWRvRSt6WkIvQmc3MUh4K3A2T2FuTlRrT0lXd2Z4Y3kv?=
 =?utf-8?B?dk9ZZmtZZmVRNDY3SVZTcEVEbDNLWmloaW9XM3YveGIwTnVwZlAzVDJwZGxj?=
 =?utf-8?B?RitXUEtoWG5HTG8zTStKK0g3RDI4QWJYMjQ4bXpwNER2YllSRmVGZlJYZW9I?=
 =?utf-8?B?NFZmeWtUUzE4cnlHZm9HL1NQc3dIMHQ3T0hFZWFORXJuVWJvZVZKK05JZktm?=
 =?utf-8?B?alJja1d6cGlXcDNLYnZiemQ0UmtBUTJXNEY2R2ovWnR4Z1FNMHF4ZG5RREtV?=
 =?utf-8?B?Z0pvTFkwMVFrMndtSC9VejJzUEZkOFhscnQxc1R1NE1LdEM2NFYyRVZmWGRq?=
 =?utf-8?B?eWo1eGVMODlyZkFyQWd4VlMyWUVza3JFR1k1MnNkVnBlV1IzWDlFY09SNDQ5?=
 =?utf-8?B?QXgrcmg2eVUvbDJtTWV5M2Y2aEhFRFk0K2d0OVViOEVwazZVcllwYmhNNW03?=
 =?utf-8?B?ODB0WE9ZaTBkZFlUMlZLZ2lKNUpMWVc3S1EzTkYwdDlhT1RqSDYwcGlZY211?=
 =?utf-8?B?TU41ZCtucllzT1EzcEE4ODJEektuTmk5eHhnVmpQU1IvaXlld2liWVZPUHlw?=
 =?utf-8?B?VytRaFVTd2pkQ1BmWUsyK2lUcGdOZVBKVHhmMDF4LzFyY0FCNGZWSnZ3d2xh?=
 =?utf-8?B?RDZYeWRFNlNXNlcweHNWUDFxVWZFSmd3UlhGeTRReFNxb3pwM3Bla0tFcUZh?=
 =?utf-8?B?WklBTkVGTVV4S2FHd0dwSXpxUHh0LzBGcFdRNDg5ZzJQSEFFSmswRVZOZ0o4?=
 =?utf-8?B?V2FzVWVVWkhmQ3EvbU1JeWVjQU1nTWNPK2tkVVJVV3BIbGtpTzZLbDc0dDMx?=
 =?utf-8?B?aGRId3p3QW42K3I3bG1NN0QxSjFaajZzSXlacG1STVlMRmo2VkZ4ZWs2emZD?=
 =?utf-8?B?bW5PZGJhaDc1bmFzT0VrY0Fnakl3UExDYVZYM1VTaUFMVFd5M3BUZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR02MB4334.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fe747b2-5fa2-4a9e-831e-08da165176d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2022 15:40:36.8006
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Zrsi1dsXsXrtB1FVnyOL+1FSqhCNotPlo27F9ePQ4hz/ob0zoaoodNmbCPMF0XPhKi3dhGfVYX2MVNjsCersfD+IDddU+yjxxJlc0EJ5KdU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4614
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

SGkgSm9oYW5uZXMsDQo+IA0KPiBJIHRoaW5rIHRoaXMgbG9va3MgZmluZSAtIHdhbnQgdG8gc2Vu
ZCBpdCBhcyBhIFBBVENIPyBJIHRoaW5rIEknbGwganVzdCBhcHBseSB0aGUNCj4gc3BhdGNoIGRp
cmVjdGx5Lg0KU3VyZSwgTGV0IG1lIHNlbmQgb3V0IGEgUEFUQ0ggc2hvcnRseS4NCj4gDQo+IElm
IHRoZXJlJ3MgYW55IG5lZWRlZCBmaXh1cHMgYmV5b25kIHRoZSBzcGF0Y2ggdGhhdCBtaWdodCBi
ZSBnb29kIHRvIGtub3cgdG9vLg0KU28sIGluIHRoaXMgcGF0Y2ggKG1hYzgwMjExKSBJIGhhZCB0
byBtYW51YWxseSBmaXggY291cGxlIG9mIGNoYW5nZXMgYXJvdW5kIEFERF9TVEFfU1RBVFMsIFRS
QUNFX0VWRU5UIG1hY3Jvcy4NCg0KSW4gZHJpdmVycywgb25seSBiZWxvdyBjaGFuZ2Ugd2FzIHJl
cXVpcmVkIGluIGFkZGl0aW9uLg0KDQotLS0gYS9kcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRl
ay9tdDc2L210NzkxNS9tY3UuYw0KKysrIGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsv
bXQ3Ni9tdDc5MTUvbWN1LmMNCkBAIC0xNDY0LDcgKzE0NjQsNyBAQCBtdDc5MTVfbWN1X2FkZF9y
YXRlX2N0cmxfZml4ZWQoc3RydWN0IG10NzkxNV9kZXYgKmRldiwNCiAgICAgICAgZG8geyAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgXA0KICAgICAgICAgICAgICAgIHU4IGksIGdpID0gbWFzay0+Y29udHJvbFtiYW5kXS5f
Z2k7ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBcDQogICAgICAgICAgICAgICAgZ2kgPSAo
X2hlKSA/IGdpIDogZ2kgPT0gTkw4MDIxMV9UWFJBVEVfRk9SQ0VfU0dJOyAgICAgICAgICAgICAg
IFwNCi0gICAgICAgICAgICAgICBmb3IgKGkgPSAwOyBpIDw9IHN0YS0+YmFuZHdpZHRoOyBpKysp
IHsgICAgICAgICAgICAgICAgICAgICAgICAgXA0KKyAgICAgICAgICAgICAgIGZvciAoaSA9IDA7
IGkgPD0gc3RhLT5kZWZsaW5rLmJhbmR3aWR0aDsgaSsrKSB7ICAgICAgICAgICAgICAgICBcDQog
ICAgICAgICAgICAgICAgICAgICAgICBwaHkuc2dpIHw9IGdpIDw8IChpIDw8IChfaGUpKTsgICAg
ICAgICAgICAgICAgICAgICAgICAgIFwNCiAgICAgICAgICAgICAgICAgICAgICAgIHBoeS5oZV9s
dGYgfD0gbWFzay0+Y29udHJvbFtiYW5kXS5oZV9sdGYgPDwgKGkgPDwgKF9oZSkpO1wNCiAgICAg
ICAgICAgICAgICB9ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgXA0KICAgICAgICAgICAgICANCiAgIA0KVGhhbmtzLA0KU3JpcmFt
LlINCg==
