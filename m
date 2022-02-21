Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEA334BECE1
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Feb 2022 23:06:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235105AbiBUWGb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 21 Feb 2022 17:06:31 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233190AbiBUWGa (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 21 Feb 2022 17:06:30 -0500
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60122.outbound.protection.outlook.com [40.107.6.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 976F122BE2
        for <linux-wireless@vger.kernel.org>; Mon, 21 Feb 2022 14:06:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OoWbmtfPVU3Hfyniq8KysOFo5yOXNwJLbhxY1RKete7zLk6dLDlslzRwDPZFU86pl465A3ppH2/PYyo9KlrQ1OnpsCjpIBL0WgTz92IjXX7LXszm1UKDh4Sp/K2TzwnkfoayixdKqhMAVcrR4CBNVL48wv3E8fm5zIvOP05127GN6o09L19mmmU0h8AZg8jvkKLq+vlcYheEzhhT73lDEA3TMZhusV93B1DLeJSPRtvLcgr8TuG3ZiC0g2E5syfh9H/kq8hWNRTVx8zpaBTX49OW8p4L4FLmUNzr5npkdfGmW9W4Ho1FNQCOBiXTKhm9BPre4bAzL6DAZrbenrKPAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vl3T9JHhJ7bcku3ixxV1f53PkMvl7dga+ASu7/UnPN8=;
 b=fOm4rmUodBgYrNE0ba1Spzt7agHG9zlhALKwCRnA4PbG+EkbztG401V0Uo+eUe30Zyi+nQgzbQW7FABDTXnKd7RBS2MOW/eYaGckf7H9a4EqP/CuMkjDs2HDoSwf8TZqBRnJMv3vJPmq5A1a784jock3a1ffPQ/aQw3bbCOfEkpMktRn77Z1TgvOcYqDNtTrwf0Yb/aeurAZOWXJ9FrabIuMoDVxEE1VfJ+EkB9z1U9IQFLo+KyIWcBbLErkzsdazbSnUh3XNVNbB6743GFNc5bdu5p/y9pXhmLAfAXdbeBrv5H7ljdjNZyKXBHk9Ykqula5aaTX+NPCs/6K6o/8GQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bang-olufsen.dk; dmarc=pass action=none
 header.from=bang-olufsen.dk; dkim=pass header.d=bang-olufsen.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bang-olufsen.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vl3T9JHhJ7bcku3ixxV1f53PkMvl7dga+ASu7/UnPN8=;
 b=rBaBTjrjOu4DIovhX1n8hFXfwpGT9y7RSGhlKv08/dhtTqFYsAxBcCQ0xtfUsk/TCqVltAUoDFTvOcXYo9j3Mrc/56I8kwEO1uAxf7e6b/M6c+j6GQNSfk1yeh7+k7h7VU063xv1viMJh2IXxbxo1DGGGzlfutAFA0p1jb6bQDs=
Received: from AM6PR03MB3943.eurprd03.prod.outlook.com (2603:10a6:20b:26::24)
 by AM0PR0302MB3396.eurprd03.prod.outlook.com (2603:10a6:208:b::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.27; Mon, 21 Feb
 2022 22:06:03 +0000
Received: from AM6PR03MB3943.eurprd03.prod.outlook.com
 ([fe80::6123:22f6:a2a7:5c1e]) by AM6PR03MB3943.eurprd03.prod.outlook.com
 ([fe80::6123:22f6:a2a7:5c1e%5]) with mapi id 15.20.4995.027; Mon, 21 Feb 2022
 22:06:03 +0000
From:   =?utf-8?B?QWx2aW4gxaBpcHJhZ2E=?= <ALSI@bang-olufsen.dk>
To:     Marcel Ziswiler <marcel.ziswiler@toradex.com>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "amitkarwar@gmail.com" <amitkarwar@gmail.com>,
        "ganapathi017@gmail.com" <ganapathi017@gmail.com>,
        "sharvari.harisangam@nxp.com" <sharvari.harisangam@nxp.com>,
        "huxinming820@gmail.com" <huxinming820@gmail.com>
Subject: Re: mwifiex_sdio_sd8997 and sdiouart8997 firmware
Thread-Topic: mwifiex_sdio_sd8997 and sdiouart8997 firmware
Thread-Index: AQHYIl43S5UHXeCEDUaYYj+bOze0HA==
Date:   Mon, 21 Feb 2022 22:06:03 +0000
Message-ID: <87a6ejj2np.fsf@bang-olufsen.dk>
References: <29ae891b8d244abe4f3681d040a068db83587697.camel@toradex.com>
In-Reply-To: <29ae891b8d244abe4f3681d040a068db83587697.camel@toradex.com>
        (Marcel Ziswiler's message of "Tue, 15 Feb 2022 11:21:46 +0000")
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bang-olufsen.dk;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 93c9611d-6d04-42bb-40dc-08d9f58659fe
x-ms-traffictypediagnostic: AM0PR0302MB3396:EE_
x-microsoft-antispam-prvs: <AM0PR0302MB33961B324AB94379C32DF3F0833A9@AM0PR0302MB3396.eurprd03.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rHGl0OvDWSLvom8D4qp9yOulJf47OaGKX6AJBYx2R2TvCwv9MD5jtCqI8156Dy29G9TVoUm88mwYvQWgOju4o1JWG+GBVn1UD7Ji9W/Y2bQy6JevMNjeDvfLZy91C2JpPDZdQUhyFl9BSAahy+Sj16SLSUmC/XZ9ON+KMoutao/G1/ZC810X1Jdtrr80unNxox+IV6XGfeC+MGmaxq1mWxcbPBziErTVqZZ++g8G2SMCViSXDjwbzd2Gdk/JjRUP3lbKYobXkdhM1uZxVnUbE1fGIhtF39YjXq0lHGrDRlrI1WxdMXG0NazdPWW6dyz7dK30YK95lexBn711ULZATy+2THR/nOyUsF5XCg9TYY2p/k4dncs2sSHQCPxqzHUe2p+GZdr+SRa9St55LBaiqNDfjbqNO+0ZBTFkvCcxbT2Pf+I4gMtncPqRRknEtwFFcmGQcWkpG2xjHFAA+/dTw5wDfUqrAL/Ahnz1iBkkYcCsW3khdsKeUG3MX7VhP2RN8GOjIpsO6nDzWMK1XjJmTLWqy7vh6GIsNeNIAeynahvlBEzIGfMjDki94r0PaYhiwyNLEC1u7S8hazXNX1ltBtFgiASeTifhYV6QBh4UDnrtxbbm8EbD7+jzvAOEpwp7FQ+mErNx7jYVh1X4gMf0BcBduiCP4/4S4gsyQZ6H/2K4iBDoA2CTSKl3ME1wi3o7JwNFRD+GPEdgD3rhCmykrEdXdRG1EwCFCAFgQAWO+4/OTIAfOTKZAFxFljNOAWz3jeOQx65xOYVqnMjUTifZECDqtoCUy7UAlIixAsm8teM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR03MB3943.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2906002)(186003)(6506007)(86362001)(26005)(36756003)(71200400001)(122000001)(38070700005)(85182001)(38100700002)(85202003)(66446008)(66946007)(66556008)(66476007)(6486002)(54906003)(316002)(6916009)(508600001)(76116006)(4326008)(64756008)(966005)(91956017)(8676002)(6512007)(8936002)(8976002)(2616005)(5660300002)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VEpjaUNCMWFKWWVUZldZWVBrTElhR1FIOXdtd0crNFAwclN0ZDZrZUQ5ZWdD?=
 =?utf-8?B?THBSYUFDVXFpYTNnWkQ0ZThpRFFxbi94WlBKL0c5MG9CRWtia1NmY25oM1Rx?=
 =?utf-8?B?SThQRmh4Y29pOUdHbDFDSkh2Ujgva1JxSmpQR0Exa1BOS3hzbG13V3p4emhK?=
 =?utf-8?B?VG5qQ3FNYWlTTkNvZ2hhRTJwRHhEZWd0TTlPVk9XYy9RUGk4b09TUjRPMFBx?=
 =?utf-8?B?MUxhUVlpMWVieEpDMUpzV0tDZkpiSzN1WkhiQVZsVlJRTkNUZ1BVMHBnZmRM?=
 =?utf-8?B?NktJZlF4bmNxbjNxc0RhSkhVVC9VOUhhUG9MbFkwY1d1bWZ1bjRONUFWRHRH?=
 =?utf-8?B?RG5Uc25RZ2cxQ0RFdWExRkdLQ1czMHNOOTZrSlVFTFpQOFJ1d21YQnp6MnNW?=
 =?utf-8?B?dCtvVm5vOU5UdFgrYlVMQ3ZNQVJZOXNrVVdJN2xrYnAweVd2S080cUpyZVFQ?=
 =?utf-8?B?SnJKYkY4aG5sYVh0UmhtTkZzajRybWV4b0NSOTUybURtMWVmY2pRSTNYV21i?=
 =?utf-8?B?YVNGM2E2dGR0UCt3UjQzaUhtUkRBb0QrWjlOODFmaHEva0FSL3dhbFBOa2JP?=
 =?utf-8?B?L01GVlZLNlA4VVViRVZ1NFUzNUtCMXVuNkt5b3kwNGJHVUpDU0pnUTJQRURw?=
 =?utf-8?B?R2lWbWkrOHpXODFCckZPNHNEZ29leE5wbGZpZE5DalpvVm8yRmZORTFyQmUx?=
 =?utf-8?B?eEtZWTN0WDZ6amsyYmZuVjNMTlhsVCsxd29YZTNPZGFTUHVReHhIR3FBWDJM?=
 =?utf-8?B?MkxWRTNhNk9JMGNMaUJ0MmNPVnhuU2l1a1RDUTJHTkJZVXJhQko0WHVFaVZP?=
 =?utf-8?B?d2FXN083eE5XeThWdnl1U05JZ1BObElIZkU1QXJad01xWFVIUkovem5IZlh0?=
 =?utf-8?B?ay8xbmdWMDVGY3dZMHRSRlU3eEdOYVJiS3V5TXBXZi9vbXR0VXhhbkdTMi9O?=
 =?utf-8?B?bklmZGxOSldJVGRTc3J4Y3JiT2ZRRWZSUXB1UmJ5WGY1TzdVa0tVV3AvVXNS?=
 =?utf-8?B?YzNDajlaVERLOGtqYjBGUkNVU3E2S1hkU2FoWGlybTB5bjVicUkrd1k4RnFz?=
 =?utf-8?B?UVpMdlU4bVdxOWQ0ZWpkVERmSVpXKzN2M1FMVHdVN1o3RXFueVllSHhnSm1h?=
 =?utf-8?B?dk13Nkl2VjIwTkRpMVg5TGNEOXpISHBNYWhyanp5SzNCOFNna085ekF1aWNv?=
 =?utf-8?B?eWF1M3BSQVEvUFRQTFo3c3JyVlp6NDZib2Z5NzY5ZzdJcXR1SER1TWJpSXhr?=
 =?utf-8?B?a2RSbEZiWjdIUHhGbDNqSXJLcElJYjJiUDZVWmJ5andaU1dQL3YySmQ3aUxW?=
 =?utf-8?B?VXNPRDM1cFkxdUUvaVBUM0gvRkdic1MzWERPZytOVnFFeDNPemIvNklHQ1lt?=
 =?utf-8?B?Z1ZLTGRxRFZYNG1xWklZTFlCN3M2Q1dCNkU3WUxJMG52WGlZWDhkTHhEZ1Ft?=
 =?utf-8?B?Wjdtb0Y4N3FrbWxzRnh2cnY4eTFpclF0dVA0TGFibkxGcWljaXJRWUMwbHBi?=
 =?utf-8?B?ZW05aG1TeENjaDVBZXlZYlRaQkJXYnVxbWdRNW5jblR2NHBWN0pDS2t0ZnpG?=
 =?utf-8?B?cWdVZUNqZVZubHY2d2FwYkpYWWJndG5ianpEYTVnb3FEdkZ1VkpoaWdGVThH?=
 =?utf-8?B?MHV0WmJ2c0hJU3Znc1dqL0MxNlBwdDk3ZkJwbmFRY1l3NGRIbXhHNEJueUFS?=
 =?utf-8?B?Q0ZJenFrQ1ZOdjFmS1VadU9VZSswTnRJUVBFVE5saWNidFQwVERrdzUxOUZO?=
 =?utf-8?B?cVN3YnRwUzExM3gyWFZEcjUzdzExNWU5NjdtMzZ2NnYyNWtkeGROaDBGNVhJ?=
 =?utf-8?B?Tm5SUSs1c2xEYzZBa0FCcE8wV29CSGZNcU12MDZDeFdRbU5Sc29kOGMraTVy?=
 =?utf-8?B?aGREeUhVd1V6UURIcWdIODZ3UzVDbWx6ZmdsR1V3Z1hXUGwwaDlzQXIzSzFh?=
 =?utf-8?B?RFFwL0grL282d3dmM0ZFN1VzTlJHTEFEcEhHeVZPR2RMMlltVEFOdVpWMm5p?=
 =?utf-8?B?VEYvSkRpZlhKZGppSjhnK2JxeGxjU1MrWkJGeTBPVEZ3MUZrNitjdkpxbWRE?=
 =?utf-8?B?eXNhTzUvOFJSZS83VUZLcHFmL0ZjR3Q2K1hidDE4V1loSU14QmxNRkVPcG9h?=
 =?utf-8?B?c1JLMTRwa0xpWWFBV0pSVVNsbnNMSE8zTnZZZFRpY3drbzQrYWNJUStqTFNX?=
 =?utf-8?Q?QjkxUst5x9Z1J7+ltrD7JU8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B14132FAA58C1B428A30F50C4669BB90@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bang-olufsen.dk
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB3943.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93c9611d-6d04-42bb-40dc-08d9f58659fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2022 22:06:03.3424
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 210d08b8-83f7-470a-bc96-381193ca14a1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H3lUNIWwjIxzcfCT+ullt7PDXrQjkQkFlRbmfkYNrmRsVx/xzEKiEXE5Dvf0I9xAVuxKVh4wLszbKgNCoUAhhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR0302MB3396
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

SGkgTWFyY2VsLA0KDQpNYXJjZWwgWmlzd2lsZXIgPG1hcmNlbC56aXN3aWxlckB0b3JhZGV4LmNv
bT4gd3JpdGVzOg0KDQo+IEhpIHRoZXJlDQo+DQo+IEkgaGF2ZSBhIHF1ZXN0aW9uIGNvbmNlcm5p
bmcgZmlybXdhcmUgbG9hZGluZyBmb3IgbXdpZmlleF9zZGlvX3NkODk5Ny4gU28gZmFyIHRoZSBk
cml2ZXIgaGFyZC1jb2RlcyBsb2FkaW5nDQo+IG1ydmwvc2RzZDg5OTdfY29tYm9fdjQuYmluLiBI
b3dldmVyLCBvdXIgbGF0ZXN0IGhhcmR3YXJlIGhhcyB0aGUgU0Q4OTk3IHN0cmFwcGVkIGZvciBz
ZGlvdWFydCBha2EgV2ktRmkgdXNpbmcNCj4gU0RJTyBhbmQgQmx1ZXRvb3RoIHVzaW5nIHNlcmlh
bCBVQVJULiBUaGVyZWZvcmUsIGl0IGFsc28gcmVxdWlyZXMgYSBkaWZmZXJlbnQgZmlybXdhcmUN
Cj4gc2Rpb3VhcnQ4OTk3X2NvbWJvX3Y0LmJpbiBbMV0gaW5zdGVhZC4gV2hpbGUgSSBzdWNjZXNz
ZnVsbHkgdGVzdGVkIGV2ZXJ5dGhpbmcgb24gdG9wIG9mIGxhdGVzdCAtbmV4dCBieQ0KPiBtYW51
YWxseSByZS1uYW1pbmcgdGhhdCBmaXJtd2FyZSBmaWxlIEkgd2FzIHdvbmRlcmluZyBob3cgZXhh
Y3RseSB0aGlzIGlzIHN1cHBvc2VkIHRvIHdvcmsgd2l0aCBtd2lmaWV4LsKgDQo+DQo+IFdvdWxk
bid0IGl0IGJlIHBvc3NpYmxlIHRvIGRldGVjdCB0aGUgc3RyYXBwaW5nIGFuZCBhdXRvbWF0aWNh
bGx5IGxvYWQgdGhlIGNvcnJlY3QgZmlybXdhcmU/DQoNClNvbWUgTlhQIGtlcm5lbHMgb24gY29k
ZWF1cm9yYSBoYXZlIGEgbW9kaWZpZWQgdmVyc2lvbiBvZiB0aGUgb2xkDQpwcm9wcmlldGFyeSBN
YXJ2ZWxsIGRyaXZlciBsdXJraW5nIHdpdGhpbiwgYW5kIHRoYXQgZHJpdmVyIGtub3dzIGhvdyB0
bw0KcXVlcnkgdGhlIGNoaXAgdG8gZGV0ZXJtaW5lIHRoZSBzdHJhcHBpbmcgY29uZmlnLiBJIGhh
dmUgbm90IHRlc3RlZCB0aGlzDQpteXNlbGYgYnV0IEkgaG9wZSBpdCBjYW4gZ2l2ZSB5b3Ugc29t
ZSBpZGVhIG9mIGhvdyB0byB1cGRhdGUgbXdpZmlleCB0bw0KZG8gdGhlIHNhbWUuDQoNClRha2Ug
YSBsb29rIGF0IHdvYWxfc2Rpb21tY19nZXRfZndfbmFtZSAoYW5kIHVzZSBwcm90ZWN0aXZlIGV5
ZXdlYXIpOg0KDQpodHRwczovL3NvdXJjZS5jb2RlYXVyb3JhLm9yZy9leHRlcm5hbC9pbXgvbGlu
dXgtaW14L3RyZWUvZHJpdmVycy9uZXQvd2lyZWxlc3MvbnhwL214bV93aWZpZXgvd2xhbl9zcmMv
bWxpbnV4L21vYWxfc2Rpb19tbWMuYz9oPXJlbF9pbXhfNS40LjcwXzIuMy4yJmlkPTY4OGI2N2Iy
YzcyMjBiMDE1MjFmZmU1NjBkYTdlZWUzMzA0MmM3YmQjbjEyNzQNCg0KSG9wZSB0aGF0IGhlbHBz
IQ0KDQpLaW5kIHJlZ2FyZHMsDQpBbHZpbg0KDQo+DQo+IE9yIGhvdyBleGFjdGx5IGNvdWxkIHRo
aXMgYmUgbWFkZSB0byB3b3JrPw0KPg0KPiBBbnkgc3VnZ2VzdGlvbnMgYXJlIGdyZWF0bHkgYXBw
cmVjaWF0ZWQuIFRoYW5rcyENCj4NCj4gWzFdIGh0dHBzOi8vZ2l0aHViLmNvbS9OWFAvaW14LWZp
cm13YXJlL2Jsb2IvbGYtNS4xMC41Ml8yLjEuMC9ueHAvRndJbWFnZV84OTk3X1NEL3NkaW91YXJ0
ODk5N19jb21ib192NC5iaW4NCj4NCj4gQ2hlZXJzDQo+DQo+IE1hcmNlbA==
