Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A7774E3FD1
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Mar 2022 14:50:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235869AbiCVNwQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 22 Mar 2022 09:52:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235858AbiCVNwP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 22 Mar 2022 09:52:15 -0400
Received: from esa.hc3962-90.iphmx.com (esa.hc3962-90.iphmx.com [216.71.140.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67F2B49CAF
        for <linux-wireless@vger.kernel.org>; Tue, 22 Mar 2022 06:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qccesdkim1;
  t=1647957044; x=1648561844;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=uOs0Ix8xHLgozkBtnVsqGAxcGTavdoh3zZvideMhdeQ=;
  b=rL4pgi6jsDSHleaNcLO2zkMe0aInEcuGobIkU++rTYOTykUJkU5RYddM
   Bv1+Jo9GLEnudE1Oqo0Jgupwko5aJxOTBX8w6jOfm4VIOUbJt0JqItALq
   hK6zqXZK3ymN1O1VnmifjhnKn+HqISJbQFT8d3b6/8UaPHKIqx6qvO6YZ
   w=;
Received: from mail-dm6nam08lp2049.outbound.protection.outlook.com (HELO NAM04-DM6-obe.outbound.protection.outlook.com) ([104.47.73.49])
  by ob1.hc3962-90.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2022 13:50:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ig6YNESzp/fhIhY4ZG2zgFDTBXfVaxDmLnQke/X8fN2PuoYA+cgW31bPsUugzgToGNjoWKe+gHHrJ0fqKWxIVVz852d0aHdBsN9HhdsMvTx/Hljv7ZLSz5o3dlrckVno60uNwozIdfJrIe+egrLRGXSknGQgCfrONBQ/ngZ+sY3FR9fDh7cQKNtf17svUGoniVyvq+E8IlPtFRHtIeA3tP+sZSgdRbL4Vqb5F5ceHE381iANV2AzBIL4Al93Lk77a9lN/HGBIsVKljhEVhPj110hd+wMfE3t6w1IhS3Mu4HnLMaE1nt8v4Xx3k2iPO2ICHQnQKCJhITVhbR7Rxhs6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uOs0Ix8xHLgozkBtnVsqGAxcGTavdoh3zZvideMhdeQ=;
 b=mIQ7IeA8ThlDWlC8XS8kyIHyny6kYDGdNFBT66Tqq+jUZN2SpXcHAKqBHWFqYMM4QlsKngnv7wVj8umQdsygsNAKObiXU6AAFEdFQMUidljD1cROaS/4pBCCdfcUN4Fw/bYD9O/lL74ji4f/kKU6Fn8+SAEbpb3BhCkXanKt0hR+OZ7NAZHUr1s+zZQ9AhnuNOsKhvF6C3iEbPPkF4yMlHyYTedDl8CxAspdsHcMEzKz3i9I1j6PCr1yZH1gTufvZipzbsQdQQ7tZ+x/v1bDYUPotKo/ENZ6/vBPKBvVMZifLx2//5TMJYC7Vn3Xx9php2UNmyPOO4XUEGjPtLn14A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
Received: from DM6PR02MB4937.namprd02.prod.outlook.com (2603:10b6:5:1a::16) by
 SJ0PR02MB8643.namprd02.prod.outlook.com (2603:10b6:a03:3fd::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.17; Tue, 22 Mar
 2022 13:50:39 +0000
Received: from DM6PR02MB4937.namprd02.prod.outlook.com
 ([fe80::68c2:f8b4:f787:211e]) by DM6PR02MB4937.namprd02.prod.outlook.com
 ([fe80::68c2:f8b4:f787:211e%3]) with mapi id 15.20.5081.023; Tue, 22 Mar 2022
 13:50:39 +0000
From:   "Rameshkumar Sundaram (QUIC)" <quic_ramess@quicinc.com>
To:     Johannes Berg <johannes@sipsolutions.net>,
        "Rameshkumar Sundaram (QUIC)" <quic_ramess@quicinc.com>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "ath11k@lists.infradead.org" <ath11k@lists.infradead.org>
Subject: RE: [PATCH 1/2] mac80211: add support to configure 6GHz non-ht
 duplicate transmission
Thread-Topic: [PATCH 1/2] mac80211: add support to configure 6GHz non-ht
 duplicate transmission
Thread-Index: AQHYIkgqfAgpLdnS+EWoRYfPSRKpZ6y6KrAAgA9VNCCAAD8mAIAB5AFw
Date:   Tue, 22 Mar 2022 13:50:39 +0000
Message-ID: <DM6PR02MB493734ADBBC6C996845B9EF3E9179@DM6PR02MB4937.namprd02.prod.outlook.com>
References: <1644914581-21682-1-git-send-email-quic_ramess@quicinc.com>
         <1644914581-21682-2-git-send-email-quic_ramess@quicinc.com>
         <a517835c51a5eaf00e87fdaaef47546f70ff0d42.camel@sipsolutions.net>
         <DM6PR02MB4937C53041172E9A52846A0BE9169@DM6PR02MB4937.namprd02.prod.outlook.com>
 <a537c6e02afbfa26eec2a54dbd8bc649f77ae3a3.camel@sipsolutions.net>
In-Reply-To: <a537c6e02afbfa26eec2a54dbd8bc649f77ae3a3.camel@sipsolutions.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=quicinc.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9666fb9b-ea18-40c1-2759-08da0c0af31c
x-ms-traffictypediagnostic: SJ0PR02MB8643:EE_
x-ld-processed: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d,ExtAddr
x-microsoft-antispam-prvs: <SJ0PR02MB8643679E13F825695F97363795179@SJ0PR02MB8643.namprd02.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GfgQISZN6XKnCXaC5usA9N7/dnuffu6xyTcLymPk0dlzqnFDGYJEoxraYU0/pWpLLQ3UTZaxFOX2z3Z8R6Bj40YcxUHdUmYRvKlm1K6hk/TGgadHvQchYmcgWB5ny34p9OYhva091TdyIT/d0O7f1RQfgQZWHnuJpDV7HPuz26LSsKHRd08bbn5dLEFdhH9rtm0zAlX4k+gi7Ck9HgRvaw+4SL5Z340qzglWIq6aMwb3M2M/g0vHAiYaCyAhfSRbkYl8Lijqb3tEhL05RR+ny6zq2Ur3CO0rgYYZPYBS83zLEmDtsEyUAMzfpPxJL5lZmlxlx7CGqtLV6xiBu7ijDzlk5q8YTBbwEgSHPNnXHdcZQep8QST9NoYU1Gy+CP9gJZ73DZhz0+pFLyVxjYdWgBMoDisPQdWKmYNHsIV0QUXKsCz4hvj2k2WHjle9Buy8RuGl25od4de8aAOOK4SBJOQWDfUTtK6roBh7D8JpWYLvaTfwR6DVm6kQ02+7PGDSv14lOy54PSYFhxahhsm6ljH1ibPmudXr0Sr2vBNDA0q3WiUT4sqqh+Gqpn8fIBh1sIlCPiuIV2OF1eBtzkQ337iXDrf3lI/nAuT9lyrV2L6lOqXz9DyjRMJMz2ZRtYK4qi3IOd5O82skqpaAgVmqmyPxJUYTIpkV+p9M1YPhWgcTR9mxDhVB6FkEVWeNQoY32APAgWpkTxhLEV4wrdziDg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR02MB4937.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(83380400001)(4326008)(2906002)(52536014)(66476007)(66946007)(8676002)(66556008)(64756008)(66446008)(76116006)(55016003)(186003)(26005)(508600001)(6506007)(9686003)(8936002)(7696005)(53546011)(71200400001)(38070700005)(316002)(122000001)(86362001)(5660300002)(110136005)(54906003)(38100700002)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aTRNdFhIdTlLL1plSnJldVRXbStETVlxTGYvL2VvNnRzMVBZdFpSNzRHTng3?=
 =?utf-8?B?eTlqaHpKNjZuM1N2d3VnZGxzOEdYV3pGdStESzd5RSthU09NUTNJSlk5S3ZX?=
 =?utf-8?B?dnRDY3BkbE95SFJiQTF2VVpkdHZoVFJ3T1FCL2V0TFh2SGhRRnBsdWt1ZUQ0?=
 =?utf-8?B?WTVyVDRiVTZMS2RGa0FWOEFpOTBjWlRNQk5LZlpya1BZOVduQldmcUtxK3cy?=
 =?utf-8?B?VGF4amllUGN5YzdtQnV4NEYydXRFK1I3cnRmODRNL1lEY29DczR6R1l5N1BR?=
 =?utf-8?B?SkExSXZrQjZWWTRsMnNZbWpmQi9KZ1QvbUV0eGlnTDZDUjBzd2dCS0ZnYUY4?=
 =?utf-8?B?azV1bU0vekdYRWMxQ1pDTVRpMjZDK0hEN2dSSzQ1bFI1Q3hXMVVhT2p0dFFL?=
 =?utf-8?B?Yy9UcFNLdEF6anNSOEtVWUhiZXdKRm5EYzRGcFBrRG9sd094aFZZdzd4UkEz?=
 =?utf-8?B?STMxOUY1YkJEYnE3dlVTUTErWnQxM3Z2SmQ2dUVLS1dDWjVRUGhGQU5RSkVv?=
 =?utf-8?B?aWZVOHVJbkorSVRHbmkrR3NsVmdTd1hRZ0w3VEdDZFM2ajBOendiTVMvQ2Jh?=
 =?utf-8?B?M3AzMy9tN3FNZi8rY1hwYjFzK2FHcnlDNGdZYXE0Yjl4Lzc5U0R5eGpkalov?=
 =?utf-8?B?SjRYRFk5ZGJaaW15cTNEYXUwdkN6ZHZSVnk4ditCaUJkbE1JLytXVUJKTUJm?=
 =?utf-8?B?TG5rd3Z5WFRrbUF2L2M3YXkraXorYzhlRjRyaUFYOHl4WG0yQ283dkZOY3ZT?=
 =?utf-8?B?NndSeHFIWDBWNzhnbEFtOU9tY0lraFRoM2RDR0NxQUE2Q25OOWpuTlFLbXh4?=
 =?utf-8?B?T3locUZhNWZ4WTR0ZkcrWXBNdVhPT2ExOFRDcWJmcGh3ZXdwWXNsWk9QeVdw?=
 =?utf-8?B?MTRZd1RoV3dIazYzRXFzbit2NndxQ3hkVTBUajFnNElMZVBtVXp1M0JNbEFS?=
 =?utf-8?B?dER6Y0grY2pkS2xRZm5jOXVSdEw2Nkx5ZHFUbFJLNWxhanhremFkQjBxcUlv?=
 =?utf-8?B?eGQ5Wi8zQzBwS1grUUJHdjlqS1VKY3Ava3ZvQytxd0E1ODAxcEFzREpzUEh2?=
 =?utf-8?B?NjRNaWxjQ1RhMUppbkRxODF4aENwRnhxOCtTUEFHRGZWdExLK0orenNoR3BM?=
 =?utf-8?B?S0RJdnB5WUNjYjVMNzJqSEZlbmdHY2h5TlZoM0RNQzZsQ3l0elZ5U2dNYUgv?=
 =?utf-8?B?Tjd0dXRZc0NyLzVrNDFlNTBMcytHQlN2eWEyTFlpdVk4SUUxUTk4bEZUaTE2?=
 =?utf-8?B?TDB0Q0lubmJqMThFNDBRZWZKdHF6Nzk5emNUR1RVaTBzUGozNiszYUc4d3Zi?=
 =?utf-8?B?dExXTDRCK1YvRTF0ano1QnVZV3ViOWtEVUJiWXNTelVkN3ZzTzBDV1JoREpx?=
 =?utf-8?B?T3pFOXY1OVd2NnVKeHg5SW8xbFFUOUp0Uks3eHc4bGRobkY3cjdSVHhLNHpy?=
 =?utf-8?B?bmltYXAvQThSdURiVzJqQ3F0Z2ZiRjJIeGl4dTJURzl2d1hWT01xMFhQTk1I?=
 =?utf-8?B?ZE1YSDdRaXdjWWtiaXl6a2ZxZ2F2czlyVEJWa2xBQXpPK3VMeElJSUEreFMx?=
 =?utf-8?B?U1o3azEyMmF2Nkh3cEhmUmZWSDdCT09oZ3lJaGNGSG5WRE5JR08yU01pYnpq?=
 =?utf-8?B?QzdHdjhRcXNsQm9JdlprNmtVbzUyKzNIR0hhUGFoSXpTL1lLdFdRNlBWRXNu?=
 =?utf-8?B?TUVGVXNVSWs3WkVpSUtNOHBiVzVTQVVUa1dKU3JvN2xPZ3BMUHNEdjg5aVFC?=
 =?utf-8?B?UVRvRlpWTWtuZkN4Q1dkS1FjeGJzMDF2WXJQVXE2Zm1QZ0xZbUo4MS9jQ2Q2?=
 =?utf-8?B?aGNaRjNEbXVLOHBBRm81QkVoaVVYd3pLNE1YYjJXMDg5bEJVVWtaaXpKM1d1?=
 =?utf-8?B?M2ZsRkJHdjJPOXRkTGJHcUI2TC9qT0ZHSnVFbkx3cDJGeldFalEvaEpJS1hs?=
 =?utf-8?Q?eu5c6FPkP7uP85x8akZWO7Dx/Eq4nwrw?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR02MB4937.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9666fb9b-ea18-40c1-2759-08da0c0af31c
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2022 13:50:39.3167
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rjpS0dc1rHEGh7rj7WRHzVcKT91fzpXDVRt5ATzP68BP1uqfMPIPqOYg7NM0u2kKCZR1fX4yQPataGGT1fZwDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB8643
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEpvaGFubmVzIEJlcmcgPGpv
aGFubmVzQHNpcHNvbHV0aW9ucy5uZXQ+DQo+IFNlbnQ6IE1vbmRheSwgTWFyY2ggMjEsIDIwMjIg
MjoyOCBQTQ0KPiBUbzogUmFtZXNoa3VtYXIgU3VuZGFyYW0gKFFVSUMpIDxxdWljX3JhbWVzc0Bx
dWljaW5jLmNvbT4NCj4gQ2M6IGxpbnV4LXdpcmVsZXNzQHZnZXIua2VybmVsLm9yZzsgYXRoMTFr
QGxpc3RzLmluZnJhZGVhZC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCAxLzJdIG1hYzgwMjEx
OiBhZGQgc3VwcG9ydCB0byBjb25maWd1cmUgNkdIeiBub24taHQNCj4gZHVwbGljYXRlIHRyYW5z
bWlzc2lvbg0KPiANCj4gT24gTW9uLCAyMDIyLTAzLTIxIGF0IDA1OjEyICswMDAwLCBSYW1lc2hr
dW1hciBTdW5kYXJhbSAoUVVJQykgd3JvdGU6DQo+ID4NCj4gPiA+DQo+ID4gPiBJIGFtIHdvbmRl
cmluZyB0aG91Z2ggaWYgdGhpcyBzaG91bGQgZXZlbiBiZSBkZXRlY3RlZCBmcm9tIHRoZSBIRQ0K
PiA+ID4gb3BlcmF0aW9uIGVsZW1lbnQgaXRzZWxmLCByYXRoZXIgdGhhbiBmcm9tIHRoZSBiZWFj
b24gcmF0ZSBzZXR0aW5ncw0KPiA+ID4gdGhhdCBhcmUgc2VwYXJhdGUgaW4gbmw4MDIxMT8NCj4g
PiBUaGlzIGlzIGEgQlcgZGVwZW5kZW50IGJpdCBpbiBIRSBPcGVyIElFIGFuZCB1c2VyIHNwYWNl
IGNhbiBzd2l0Y2ggQlcNCj4gPiAoQ1NBL2NoYW4gc3dpdGNoIHNjZW5hcmlvcykuDQo+ID4gV2hp
Y2ggY2FuIGNhbGwgYXNzaWduX2JlYWNvbiBkaXJlY3RseSwgSGVuY2UgYWRkaW5nIHRoZSBsb2dp
YyBoZXJlIHRvDQo+ID4gY292ZXIgYWxsIEJlYWNvbiBjaGFuZ2UgY2FzZXMuDQo+ID4NCj4gDQo+
IFllYWggYnV0IHN0aWxsIC4uLiB3aHkgZG8gd2UgdGFrZSBpdCBmcm9tIHRoZSBjb250ZW50IHJh
dGhlciB0aGFuIGFkZGluZyBhDQo+IGNvbnRyb2wgZm9yIGl0Pw0KU28sIFN1Z2dlc3Rpb24gaGVy
ZSBpcyB0byBhZGQgYSBuZXcgTkwgYXR0cmlidXRlIHRvIGNhcnJ5IHRoZSBpbmZvcm1hdGlvbiBm
cm9tIHVzZXIgc3BhY2UgZm9yDQpTVEFSVF9BUCBhbmQgU0VUX0JFQUNPTiBOTCBjb21tYW5kcyBh
bmQgdXNlIGl0IGhlcmUsIGlzIHRoYXQgdW5kZXJzdGFuZGluZyBjb3JyZWN0ID8NCj4gDQo+IGpv
aGFubmVzDQo=
