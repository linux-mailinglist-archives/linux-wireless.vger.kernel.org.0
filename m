Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FBCE4C55A8
	for <lists+linux-wireless@lfdr.de>; Sat, 26 Feb 2022 12:27:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231502AbiBZL22 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 26 Feb 2022 06:28:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231442AbiBZL22 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 26 Feb 2022 06:28:28 -0500
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2135.outbound.protection.outlook.com [40.107.22.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89F9C4F46A
        for <linux-wireless@vger.kernel.org>; Sat, 26 Feb 2022 03:27:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XpJPD/WtQUM27+I+qlwn/c7QeSm5w3z7TiCzPd6BzBBjQ1Vlqi8a3r6EIfAO9DqSy2BHENLTqOuiZ0K+IDhccssYRxQKzeR30+qJWVmlvRMGEyESfWXT5jBpjWqTAAVkL8LLZyv/GyPed1NmygFzVtsAYpJAw5KikadByMNhKqVKBgZQZb8En0Q8eD6o7J0laLif3vUd/Rf8jUuceJvtK58x11VTfN4B2QK/HvFbEuQuqI1XHbzFCLJQe/kjLCaG/iyQM6PZk+2l5DmPZf0GoftPv/x4SWY39n/EK/kx8y5ip7GhfPphAhPg3+PCUZZbBJwQYr4jwCtr9xzNzH7mJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vmrDugf2MKE5Ja3ZmN3rHVMRCo/jKqFpDGmo1uQ/VYE=;
 b=D/3i76rJVXdOuQezSCR5KhWn+xh5hIAweLQFcD6cgPRKdt/lcJwl5hBhru5lXnBRblopc0eVgo+Ndq8+FknZeyqdQCe1T4WoY5vSzm+nqAxKSvizQhvdMg3jzDo6hgGI2q/UiDKOT2lmHI/t/FuXr+FEyxQldGvo6cgldmfHHBSZgnzGsKEVtDuTvqoLUidZA3qvX1Rjvk7akA2KoVZxgrYOYYs6lsMYB2Dm6w5R2ek4hm+g2Q22TfqoWij7F8p9Ub4TlCLBZ9/QVdIy0CxU7HDCDDhudEe2io7j2LDjSp6AOmvCTuCDbccPTNG0c/qpmoi8gpYGNusht55ftIaEiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bang-olufsen.dk; dmarc=pass action=none
 header.from=bang-olufsen.dk; dkim=pass header.d=bang-olufsen.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bang-olufsen.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vmrDugf2MKE5Ja3ZmN3rHVMRCo/jKqFpDGmo1uQ/VYE=;
 b=mWbqBFqEgaTFtbdMkFSn9d0YZUUy5p3V8O9iMSHpPnzxHGNwDlS/+4ZOGWYzBYApLgWUKECABhBY91Axq/HuNaUu3+z5FwKsmSswdwXJZxdSUYbCVf1a7ZeZvrLMZQEXVnT4j3MNFuFmHi6x4eP4PlOQz73Ex0Q0ntmS8dGdW4M=
Received: from AM6PR03MB3943.eurprd03.prod.outlook.com (2603:10a6:20b:26::24)
 by PAXPR03MB7636.eurprd03.prod.outlook.com (2603:10a6:102:1de::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.25; Sat, 26 Feb
 2022 11:27:47 +0000
Received: from AM6PR03MB3943.eurprd03.prod.outlook.com
 ([fe80::6123:22f6:a2a7:5c1e]) by AM6PR03MB3943.eurprd03.prod.outlook.com
 ([fe80::6123:22f6:a2a7:5c1e%5]) with mapi id 15.20.5017.022; Sat, 26 Feb 2022
 11:27:47 +0000
From:   =?utf-8?B?QWx2aW4gxaBpcHJhZ2E=?= <ALSI@bang-olufsen.dk>
To:     James Prestwood <prestwoj@gmail.com>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH] brcmfmac: include missing AP scan feature
Thread-Topic: [PATCH] brcmfmac: include missing AP scan feature
Thread-Index: AQHYKas3uPpI3oxfi0CdVC9vzqacgw==
Date:   Sat, 26 Feb 2022 11:27:47 +0000
Message-ID: <87k0dhdg0d.fsf@bang-olufsen.dk>
References: <20220224181809.2808754-1-prestwoj@gmail.com>
        <87o82ud09z.fsf@bang-olufsen.dk>
        <a6fc2d3b3fbd4ed2149fd85a21f7aae8f7fdc926.camel@gmail.com>
In-Reply-To: <a6fc2d3b3fbd4ed2149fd85a21f7aae8f7fdc926.camel@gmail.com> (James
        Prestwood's message of "Fri, 25 Feb 2022 15:22:27 -0800")
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bang-olufsen.dk;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: eb86554c-36ce-4b2d-be11-08d9f91b03d8
x-ms-traffictypediagnostic: PAXPR03MB7636:EE_
x-microsoft-antispam-prvs: <PAXPR03MB763600E710FE8D71EE120553833F9@PAXPR03MB7636.eurprd03.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bnP+VDnTT4ZOYicCfhKpxo7WTOzNci/WHNhH06qarKsrju8GrX11AxulfKQE62b1dgFvI6R9oqrdAQaUDQ67lK6c1dkKJMM0rXYrs3dlFAx1TO/7NkuOjs35jzaPz4ZjZGmgQqilTFI9rSyNa1THl4Pm/OApkDBStrlOdY5U7PKbdQma10oB6IR+/CmNnpPM8TA283sh9KVPIghr6COn55wkLCJxeGJYMeXxcNDWHUe/NnspLDc+HXifBy3sYHBZqclIHOmQqknhRywez5S8r2mgsZZ/UlxFmv0ir8bn0woo3bq1aSut82xeSsQRvTVHH0x3UYyTwbtoOm5K/hbbOgqG6U7KWMJjtom7fVnZj8B//OrYYW1TXGToe4VwnhKuMM/dJhb+ofv9SOSxaAQgfUBIy+Ms86lP+2vVOMI9YmE3Ltcc+KGjW723KGV+zqd3sxxRjmje3WO+EF0sdzxIfNzJjWkZ8PoonVqv5SqloraTx0E9HHY6D1qrHbAEQMPSkQgUI/3Fd6XjdVNrFoLefTlji81Bds+3SloBDSymHD9Did+iPf3FwNs3Zv+yHbUYO+edcy73qa/xgk9I2KBt6m56FU6CRBUN33MLoO8CwxNkvNCCJOtlpl//5UN/ZcXwtUdaeep54/IlKv+WR0QPeQUjYt76uBa6Q1xnoUQ4/xOy6on38SYvg0gEVVyrm+0kE7RZiy54iuTGfiyVb2A3WkIiQB3CQ5OmqpMziPUqYyM4gQBPvbuIA0jirT2JQQxWjVjP1VTs09GoVal3EmxMQOQmM2RVtk01vvLj5r2TsoY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR03MB3943.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(122000001)(38100700002)(38070700005)(85182001)(86362001)(6916009)(316002)(508600001)(6486002)(5660300002)(85202003)(8676002)(76116006)(66446008)(966005)(66476007)(66556008)(66946007)(8976002)(64756008)(66574015)(91956017)(2906002)(83380400001)(6506007)(36756003)(8936002)(6512007)(2616005)(26005)(4326008)(186003)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WjhKYXppdXlIWE55a3ppSUZZS05uRGpCOTBpQ0RtQ2YvQ3BqcHhrL2lNZVVK?=
 =?utf-8?B?SVBiWlNUVDJJYkxMRlgrWHM4bDNzTHBOcWphM2xkVDBnSHlBSi95VVdSbE1V?=
 =?utf-8?B?TjAxUzVFZVdQODBBbFMvU1ZYV0hNc3lFa0RXNnA3TytwMVUvWjlUbGZ2ODhC?=
 =?utf-8?B?YkFNNzFzN2ZyeEpQdmZXMkZ2eXc3dmJYRXEyRUorODJYWkdwNnYrMSsvcldU?=
 =?utf-8?B?cEdNSmF5Q1ppQzZxSy9RMFVSSU0reE9YNDl4SUxEM0RLVWx3MWYwVUpZeGdK?=
 =?utf-8?B?bm9tSmVwcG9ZbnRON3VIbksvMEF1OTVydFdSdUNmT0M5UFZ3cFVnZFN4dUdH?=
 =?utf-8?B?bTcvbkVwYnp0dGtpZVdVVE1DVWFFc1dGWDBwSFR4TnV2VzhLaHRvSDRuL0Yr?=
 =?utf-8?B?MjFLbnVINHl1b2RmYlNoNnhLejUwT3BtbGNmYnZ1T0VPT3pEVi9rRzAybXE4?=
 =?utf-8?B?cTA0SWhBZmtQOVN6NEVJV1o2V1d2cjhFcmVjWG1HMDJWcTFzeisyeEZ5Zndo?=
 =?utf-8?B?UjhGdXpnSnQ4d0pOb2Y5N0lCekZncDdjV20za3RiKzYxK1pJTjJSQ1R2U3B3?=
 =?utf-8?B?UjRyUEFpelJyVjdlZWpFRFdMekF1QVFUNTRGTnVlMVRWemkvT1FVWFg4QUZ0?=
 =?utf-8?B?Q3lScWNvZk53SFVNVkpNYmlSS3NrbkNlVXpnWVJieDNKWkt1OVMwWkJoaGlZ?=
 =?utf-8?B?ZUhOQ3hCSWNGVEdhNkdlN1NxZFJhdzgzUWlvaWQrcm1kQ2thSU8vZ2VkcjNP?=
 =?utf-8?B?OHN3NXlYYUJUaU5sWXhmbjJhdjJwUHhVazhka0p0bFpxN09zMyt6eVVZK0lR?=
 =?utf-8?B?cDZVMHVoZlFJQjNwOGM3RGNjOEg0T2VpcTJNQUZKY2VzY3E3b0dDTEVuNHJz?=
 =?utf-8?B?RThjK05MVkRMSXIybnlnZWg1UUVGUjh5ZE5zWEZGT0xMRXdwRG52NnM3dG9E?=
 =?utf-8?B?OUxEcEx5R2RMeW1tR295cHhKcjUxc2xTT2lKNG52ak1Ka0VjN2l1R3Z0Vktu?=
 =?utf-8?B?Tmx6SlBNZkwyWTEzbmlhaDU3eDdFd0NISGllSXV4NjNFa0p1YURlVjZEdW5n?=
 =?utf-8?B?TDY5bFkxdXdoUjU0UlFJZVlNV3o4bklrNGFzbmVvemY2WUd5QWZlb1V1OVdE?=
 =?utf-8?B?TUlUSHU1NUNlZC8xckkvUWNSTDZmWEdiMHVGbFNYQTRwVnlXNkRvY3EwU2lS?=
 =?utf-8?B?cXJoMWMwRGVxcTVSU0cvdXF4d2xGeVhtaEJPc29wc3JkTHRHODhJdkkzMEtB?=
 =?utf-8?B?UHFLRjRmelloSzZYZkxnRjhRTStYTHhvVUNCTWlJN2VuZUR6ZkJFNGJtOEJo?=
 =?utf-8?B?OEt5Q1duSXlZem1jU2FDUXp1TmZocitTL0JBWFF2VmNZeXlxQjJMdzB3eWNR?=
 =?utf-8?B?Vy9WcWVOTTV1a1ZLR0xHTk1BTy9DY09Qb3lCdmo2czhrdjFHVWFJOXRaVGpP?=
 =?utf-8?B?aDV5anpHMktlRm9OVzdnL25FazVmYlZJa0pvV0UxSys1T3hONHlGbEpSb0xK?=
 =?utf-8?B?RE14bFNDZmFUREx6VUdlSnVDZ2lqeU1DcW9rZHNJdUI3bG5kZjhWMEJRQ3p3?=
 =?utf-8?B?d1RnSm1nTTNjNFg1aUtwdTR1MVVlY0pmNFZlOU5GTXN3TVlvd0prSkhidEZG?=
 =?utf-8?B?R0kwUEtQNjU2SGM4UWRIMUU3TkY0RUx5MmhRZWFYams3eUZWbWZiWVZCczBl?=
 =?utf-8?B?YlI4aWFoM2lXUUVhRWxOU2xpVFEwSlY3akdMRSs5VDBpVXFpekg5dHc1M1dN?=
 =?utf-8?B?TWhWMU13THRZYUFVdjZkdlVoQ3BTK1FDV2pua21nM0RKYml6M0IvaVdFOC9R?=
 =?utf-8?B?Y0lkSml1Y01BanBCK1laSW9rclJpMk5hZmxHRGpWbkRVQ1ZZSTFtcVZLTTZl?=
 =?utf-8?B?aHdzUHlRbFFvMVR3UTFNcjRab2dxVzA5anpNUVJaUWhtMW1tcmFzTmd3V3ov?=
 =?utf-8?B?RW5WTCtkWjBscmFLZUFRa2V1ODNQMDVWdXZLUWNUVDhxS2NxbmxXNUJES2Yr?=
 =?utf-8?B?eEpSQkxtSGREWGx1MkZBdG1TQnVjVDFaekEyUjlPRVZ6WkRZaHFHNmRUSWNR?=
 =?utf-8?B?U0VNTjJNRXR0aVpXKytmSFljTGtiT1NYN0o0RUdiUi9oejMwWVZlOE9Hd3hw?=
 =?utf-8?B?bytYK0RxMDdpYXFLcHZDdmNRRmhSbzMyKzhDdW5LRVBCTTRUU2M3SWlNbFd1?=
 =?utf-8?Q?YGILnBCzQPRdi5J8cX3LPVA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <38341F6DC718834C9648856FB687DA65@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bang-olufsen.dk
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB3943.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb86554c-36ce-4b2d-be11-08d9f91b03d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2022 11:27:47.3292
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 210d08b8-83f7-470a-bc96-381193ca14a1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UpW7R06jSMfbqAuMpIWnJPbSwu1RiTnoiFje3RCxHYll1tflAofpk9JRv22cPED9la07ZbvEMLSoZ3VI9xHrDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR03MB7636
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

SGkgSmFtZXMsDQoNCkphbWVzIFByZXN0d29vZCA8cHJlc3R3b2pAZ21haWwuY29tPiB3cml0ZXM6
DQoNCj4gSGkgQWx2aW4sDQo+DQo+IE9uIEZyaSwgMjAyMi0wMi0yNSBhdCAyMjo1NSArMDAwMCwg
QWx2aW4gxaBpcHJhZ2Egd3JvdGU6DQo+PiBIaSBKYW1lcywNCj4+IA0KPj4gSmFtZXMgUHJlc3R3
b29kIDxwcmVzdHdvakBnbWFpbC5jb20+IHdyaXRlczoNCj4+IA0KPj4gPiBUaGlzIGRyaXZlciBk
b2VzIG5vdCBhZHZlcnRpc2UgdGhpcyBmZWF0dXJlIHlldCBzY2FubmluZyB3aXRoIG9uIGFuDQo+
PiA+IEFQIGludGVyZmFjZSBhcHBlYXJzIHRvIHdvcmsganVzdCBmaW5lLg0KPj4gPiAtLS0NCj4+
ID4gwqBkcml2ZXJzL25ldC93aXJlbGVzcy9icm9hZGNvbS9icmNtODAyMTEvYnJjbWZtYWMvY2Zn
ODAyMTEuYyB8IDIgKysNCj4+ID4gwqAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspDQo+
PiA+IA0KPj4gPiBJJ3ZlIHN1Ym1pdHRlZCB0aGlzIHBhdGNoIG1haW5seSB0byBzdGFydCBhIGRp
c2N1c3Npb24gYWJvdXQgaXQuIEkNCj4+ID4gZmluZCBpdCBoYXJkIHRvIGJlbGlldmUgdGhhdCBB
TEwgYnJjbWZtYWMgZGV2aWNlcyBzdXBwb3J0IEFQDQo+PiA+IHNjYW5uaW5nDQo+PiA+IGluIHdo
aWNoIGNhc2UgdGhpcyBmZWF0dXJlIG5lZWRzIHRvIGJlIGxpbWl0ZWQgdG8gdGhvc2UgZGV2aWNl
cw0KPj4gPiBvbmx5LiBUcm91YmxlIGlzIHRoZXJlIGlzIG5vIEZXIGZlYXR1cmUgZm9yIEFQIHNj
YW5uaW5nIEFGQUlLLg0KPj4gPiANCj4+ID4gSW4gYW55IGNhc2UgSSB0aGluayB0aGlzIGRyaXZl
ciBuZWVkcyB0byBzb3J0IG91dCBpZiBpdCBzdXBwb3J0cw0KPj4gPiB0aGlzDQo+PiA+IGZlYXR1
cmUgb3Igbm90LCBhbmQgYWR2ZXJ0aXNlIGFzIHN1Y2ggcmF0aGVyIHRoYW4gbGVhdmluZyB1c2Vy
c3BhY2UNCj4+ID4gaW4gdGhlIGRhcmsuDQo+PiANCj4+IEJ5IHRoZSB3YXksIHdoYXQgYXJlIHRo
ZSB0eXBpY2FsIHVzZS1jYXNlcyBmb3IgQVAgc2Nhbm5pbmc/DQo+PiANCj4+IEkga25vdyB0aGF0
IGhvc3RhcGQgZG9lcyBhIHBhc3NpdmUgc2NhbiBvbiB0aGUgQVAgaW50ZXJmYWNlIG9uIHRoZQ0K
Pj4gYXNzdW1wdGlvbiB0aGF0IHRoZSBkcml2ZXIvZmlybXdhcmUgd2lsbCBnYXRoZXIgY2hhbm5l
bCBzdXJ2ZXkgZGF0YSwNCj4+IGJ1dA0KPj4gdGhhdCdzIG5vdCBhIHVuaXZlcnNhbGx5IGFwcGxp
Y2FibGUgYXNzdW1wdGlvbi4gTm90IGFsbA0KPj4gaW1wbGVtZW50YXRpb25zDQo+PiB3aWxsIGRv
IHRoYXQuDQo+DQo+IFdlIGhhdmUgc29tZW9uZSB3YW50aW5nIGl0IGZvciBvbmJvYXJkaW5nL2Nv
bmZpZ3VyaW5nIGEgbmV3IGhlYWRsZXNzDQo+IGRldmljZS4gV2hlcmUgb24gYm9vdCwgaWYgaXQg
aXMgdW5jb25maWd1cmVkLCBpdCBzdGFydHMgYW4gQVAgYW5kIHdhaXRzDQo+IGZvciBhIGNsaWVu
dCB0byBjb25maWd1cmUgaXQuDQo+DQo+IEEgY2xpZW50IHdvdWxkIGNvbm5lY3QsIGhhdmUgdGhl
IGRldmljZSBzY2FuIGFuZCBwcmVzZW50IGF2YWlsYWJsZQ0KPiBuZXR3b3Jrcy4gVGhlIGNsaWVu
dCB0aGVuIHNlbGVjdHMgYSBuZXR3b3JrIGFuZCBwcm92aWRlcyBjcmVkZW50aWFscy4NCj4gVGhl
IG5ldyBkZXZpY2UgY2FuIHRoZW4gc3dpdGNoIGJhY2sgdG8gc3RhdGlvbiBtb2RlIGFuZCBjb25u
ZWN0Lg0KPg0KPiBUaGlzIGlzIGEgcmVsYXRpdmVseSBjb21tb24gcHJhY3RpY2UgSSd2ZSBzZWVu
IHdpdGggSW9UIGRldmljZXMuDQoNCkFoIE9LISBBY3R1YWxseSB3ZSBkbyBwcmV0dHkgbXVjaCB0
aGUgc2FtZSBoZXJlIGF0IEImTyB3aXRoDQpicmNtZm1hYy4gQnV0IHJhdGhlciB0aGFuIHN0YXJ0
aW5nIHRoZSBBUCBvbiB0aGUgcHJpbWFyeSBpbnRlcmZhY2UgKHRoZQ0Kb25lIGRlZmF1bHQgY3Jl
YXRlZCBieSB0aGUgZHJpdmVyKSwgd2UgYWRkIGEgc2VwYXJhdGUgQVAgaW50ZXJmYWNlIHdpdGgN
CnRoZSBlcXVpdmFsZW50IG9mIHRoZSBmb2xsb3dpbmcgY29tbWFuZDoNCg0KIyBpdyBkZXYgd2xh
bjAgYWRkIHVhcDAgdHlwZSBfX2FwDQoNCkhlcmUgd2xhbjAgaXMgdGhlIHByaW1hcnkgaW50ZXJm
YWNlLCBhbmQgdWFwMCBpcyB3aGF0IEkgY2FsbCBteSBBUC4NCg0KSW4gdGhhdCBjYXNlIHlvdSBj
YW4gc3RhcnQgdGhlIEFQIG9uIHVhcDAsIGJ1dCBzdGlsbCBkbyBzY2FubmluZyBvbg0Kd2xhbjAg
KHdoaWNoIHJlbWFpbnMgaW4gc3RhdGlvbiBtb2RlKS4gRG9uJ3QgcXVvdGUgbWUgb24gaXQsIGJ1
dCBJIHRoaW5rDQp0aGlzIGlzIHRoZSBjYW5vbmljYWwgYXBwcm9hY2ggd2l0aCB0aGlzIGRyaXZl
ci4gSXMgaXQgc29tZXRoaW5nIHlvdQ0KaGF2ZSBjb25zaWRlcmVkPw0KDQo+DQo+IE90aGVyIHRo
YW4gdGhpcyBJIGNhbnQgc2VlIG11Y2ggZWxzZSBvZiBhIHVzZSBjYXNlIGJlc2lkZXMsIGxpa2Ug
eW91DQo+IG1lbnRpb25lZCwgZ2F0aGVyaW5nIHN1cnZleSBkYXRhIHRvIGNob29zZSBhIGxvdyBs
b2FkIGNoYW5uZWwgKEFDUyBpdHMNCj4gY2FsbGVkIEkgdGhpbms/KQ0KDQpZZXMsIHNlZSBob3N0
YXAvc3JjL2FwL2Fjcy5jLg0KDQpTZWUgYWxzbw0KaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGlu
dXgtd2lyZWxlc3MvOTY2NTI2NjktMGNhZC04Y2RiLWZiZTEtNGRmMGY3MTYxMTAyQGJhbmctb2x1
ZnNlbi5kay8NCmZvciBzb21lIGdydW1ibGluZ3Mgb2YgbWluZSBvbiB0aGlzIEFQSS4NCg0KPg0K
PiBTYWRseSB0aGlzIG9uYm9hcmRpbmcgdXNlIGNhc2UgaXMgcXVpdGUgcGVyZmVjdCBmb3IgRFBQ
LCBidXQgc2luY2UNCj4gQXBwbGUgY2FtZSB1cCB3aXRoIHRoZWlyIG93biBwcm90b2NvbCBEUFAg
d29uJ3Qgd29yayBmb3IgYW55IHByb2R1Y3RzDQo+IHRoYXQgd2FudCBjcm9zcyBjb21wYXRpYmls
aXR5Li4uDQoNClllcywgdGhpcyBpcyBhIHJlYWwgc2hhbWUuIEFuZCBJIGhpZ2hseSBkb3VidCB0
aGF0IEFwcGxlIHdpbGwgYWJhbmRvbg0KdGhlaXIgb3duIHByb3RvY29sLg0KDQo+DQo+PiANCj4+
IEtpbmQgcmVnYXJkcywNCj4+IEFsdmluDQo+PiANCj4+ID4gDQo+PiA+IGRpZmYgLS1naXQNCj4+
ID4gYS9kcml2ZXJzL25ldC93aXJlbGVzcy9icm9hZGNvbS9icmNtODAyMTEvYnJjbWZtYWMvY2Zn
ODAyMTEuYw0KPj4gPiBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL2Jyb2FkY29tL2JyY204MDIxMS9i
cmNtZm1hYy9jZmc4MDIxMS5jDQo+PiA+IGluZGV4IGZiNzI3Nzc4MzEyYy4uYjZhNTBlNjVkYmY2
IDEwMDY0NA0KPj4gPiAtLS0gYS9kcml2ZXJzL25ldC93aXJlbGVzcy9icm9hZGNvbS9icmNtODAy
MTEvYnJjbWZtYWMvY2ZnODAyMTEuYw0KPj4gPiArKysgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9i
cm9hZGNvbS9icmNtODAyMTEvYnJjbWZtYWMvY2ZnODAyMTEuYw0KPj4gPiBAQCAtNzcyOSw2ICs3
NzI5LDggQEAgc3RydWN0IGJyY21mX2NmZzgwMjExX2luZm8NCj4+ID4gKmJyY21mX2NmZzgwMjEx
X2F0dGFjaChzdHJ1Y3QgYnJjbWZfcHViICpkcnZyLA0KPj4gPiDCoCNlbmRpZg0KPj4gPiDCoMKg
wqDCoMKgwqDCoMKgfQ0KPj4gPiDCoA0KPj4gPiArwqDCoMKgwqDCoMKgwqB3aXBoeS0+ZmVhdHVy
ZXMgfD0gTkw4MDIxMV9GRUFUVVJFX0FQX1NDQU47DQo+PiA+ICsNCj4+ID4gwqDCoMKgwqDCoMKg
wqDCoHJldHVybiBjZmc7DQo+PiA+IMKgDQo+PiA+IMKgZGV0YWNoOg==
