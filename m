Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 785C669A828
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Feb 2023 10:33:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbjBQJdK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 17 Feb 2023 04:33:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229851AbjBQJdJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 17 Feb 2023 04:33:09 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 208294B507
        for <linux-wireless@vger.kernel.org>; Fri, 17 Feb 2023 01:33:06 -0800 (PST)
X-UUID: 12df6e56aea611ed945fc101203acc17-20230217
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=pMYjaiFQFYlQTluQtFzBF8eeoAVr/s4WJ9QxUu24D3Y=;
        b=f0z96FX/JbNrypo9bpvN1Yk49OZVPToDlfORaOe5WnWV22v4c6aGuaNelSfBKRqM8lOM9aVkzWTEZYtRHuCzPZSQcnUweRINmyvTUTTsdbgoLHweEUUwlRzt6evQQF+81009ev8/cLAO0AfCHWSr/rbEq9ZwMF2A/f6VIXPujSc=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.19,REQID:6ccf867e-5b39-4378-a926-a8856d8311bd,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:885ddb2,CLOUDID:57f5e225-564d-42d9-9875-7c868ee415ec,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0,NGT
X-UUID: 12df6e56aea611ed945fc101203acc17-20230217
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw02.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1241557980; Fri, 17 Feb 2023 17:33:02 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Fri, 17 Feb 2023 17:33:00 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n1.mediatek.com (172.21.101.34) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Fri, 17 Feb 2023 17:33:00 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dbJxALHOX0WP+g+/mHzSAkunMshiJlEVRPRiHRfbCk1X2/MuDieYy4iLtz7LYQiNW2uK14KuoJXcgUaT73TtpTZoxEcCSFOabxoRteP4zAiTtvRDukAM73LLz8/Be4eDAij0ctFyrPTQYE2LuigYeg2A8ii1GTV7A4fwUuCHQkSB3ffqt7f5Y92xAkn5OL1qaoFhiT+xlHXhqI5lgxisjOuQoxkfUdpLq/OB7gJduc8cVu5Lb+7+09MnvtSayUbr8FtqoOYtZj+UUd6gp2sb1vPQwIaOPxN0JoBWzvq2wdPQrsLK3/m3fnN+p3e5NQV6DMADk+YyEDSVEVHPLFfzYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pMYjaiFQFYlQTluQtFzBF8eeoAVr/s4WJ9QxUu24D3Y=;
 b=NQEvzLQrgBRANeLSC3wbIepAybvZpb/Llk/LBkeAdYqtOPwr7yfqHb/YZhIyemTqTVgYxcmFMW6vyJWJg4SS/re8n7dO/bXS7vIrL90tnPYba3XH9vLFhEh6bqBb/yLIMivBbldaJiyI9qlQXB1+Zn5sear7ZIPF1tuUgpy5xFNXZ4iZFEIJu2O9imG6KN2nblGbkj9jx41c5YEnh17nnbsSCUcKKYPQc1cbHlbrq3awnpftpLKMre9Zn/kGKTUjqJlqUnRANmAYwMUj3iLBklChmIFnd9wPLgWPAmOsgACuip+M/yHRqFOInZYjeWYpruamaHYZZen5RlpBV7rbHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pMYjaiFQFYlQTluQtFzBF8eeoAVr/s4WJ9QxUu24D3Y=;
 b=JorS+vrasHSOB5n/3p1sWf2BUGO7lihCSI0pyRhiX0q7a1THorSPXBpW4Fm7GjmPlB7YFkLAbBXDbJm1/ZAwRzLwBa09cK+W8jGbTjRZFXcIB6Xtg20ug1Cfoi/Rh6OuNMZewfuv/TSrKbbgrE9IzV1cLyW3noCGMhq19DYq6qI=
Received: from TY0PR03MB6354.apcprd03.prod.outlook.com (2603:1096:400:14a::9)
 by KL1PR03MB5836.apcprd03.prod.outlook.com (2603:1096:820:81::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.13; Fri, 17 Feb
 2023 09:32:58 +0000
Received: from TY0PR03MB6354.apcprd03.prod.outlook.com
 ([fe80::cdcc:fb2c:cc34:8360]) by TY0PR03MB6354.apcprd03.prod.outlook.com
 ([fe80::cdcc:fb2c:cc34:8360%9]) with mapi id 15.20.6111.013; Fri, 17 Feb 2023
 09:32:58 +0000
From:   Ryder Lee <Ryder.Lee@mediatek.com>
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "johannes@sipsolutions.net" <johannes@sipsolutions.net>
CC:     =?utf-8?B?U2hheW5lIENoZW4gKOmZs+i7kuS4nik=?= 
        <Shayne.Chen@mediatek.com>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?utf-8?B?RXZlbHluIFRzYWkgKOiUoeePiumIuik=?= 
        <Evelyn.Tsai@mediatek.com>
Subject: Re: [PATCH 2/2] wifi: mac80211: add LDPC related flags in
 ieee80211_bss_conf
Thread-Topic: [PATCH 2/2] wifi: mac80211: add LDPC related flags in
 ieee80211_bss_conf
Thread-Index: AQHZQWUR/eiZgBIi90GdYt1pa56pi67S4tiA
Date:   Fri, 17 Feb 2023 09:32:58 +0000
Message-ID: <428bc02cc384e168d4ede46bcf3f05ccc33ccdf8.camel@mediatek.com>
References: <c1a6ef2f42e26a6e0473d4fb2ce1b572f8448d87.1675893838.git.ryder.lee@mediatek.com>
         <4e5cff1c538cbd9ecca171e0e4d6fddd87c3dfa0.1675893838.git.ryder.lee@mediatek.com>
         <165dcb98f58e8d6049d89d8e4ebb326b8fe631b8.camel@sipsolutions.net>
In-Reply-To: <165dcb98f58e8d6049d89d8e4ebb326b8fe631b8.camel@sipsolutions.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY0PR03MB6354:EE_|KL1PR03MB5836:EE_
x-ms-office365-filtering-correlation-id: 41730ec7-4d81-47c4-a440-08db10c9f4ae
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tTr8jJap4UZZ+5eKj9Pq+eTGFL0Hi9oiWljFAic7QlwLdXtrl/KZwl+IM7zqu1gevPytn62+uDU7cPlpExCp5nzQpTvNdaF/ufEMEBIBwYu8cgxn725x5B/M35BYvj5o4MM1O07XQ10L4LDqtY/hl0g2b86yhPheiKNPUdf2++AcbMgQ71XYqwJA+EtQD6s9XP5A9W4fK97517tKhAGuo1+pqN2ijUtCqPKvL+4o00gBDttt0aw9xjSxJ7PoJ91CxKmuOf5kHPGOePvT+jwWHptAuq2heVEM5o9TJnl8TTSmGugd1kXCgckPcnpHgb8v6/1wn4ixuHUFXVbJbl5Ccj+OBowYAF6VVLVs02JdHudHkhLPW9oDJMzB+atZ45IyqSFKqtJW1gQZBnHe9Br2ATZl8tv2SRQkuoc2Ft8ZmGhPJfp85HDSovWA8xRUttWC45x3LOZO3zYOhpYkzibnmd0xWMAWbPRWwsjQ1l8UEB2KfngB1K0GBN7LIeqbuVt3CofUz2TNm/aJlsWEp3YYDMclk9S5ubxXdMoAEGmStoUZ9Kn3/BX7NiewZq5vpGW+/Ug1zTPShC21gfOrzXHgAI2+0Assn6P59N5FAribstEPXvFxTnpl6RjR7zYQ1s3b5LSfXDZq4XEloc0gCVyYA1wXaEzv36OYbVWZvRndVLSNGJ+coF2Akd/40cJ+79aa3N4OWCitnGQwVDNjmptJwuN2GociXeh1oQdYy7o08RwMO4wv8cP3O2Z+P+QupCmd
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY0PR03MB6354.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(136003)(346002)(39860400002)(376002)(396003)(451199018)(86362001)(54906003)(316002)(110136005)(38100700002)(8936002)(5660300002)(38070700005)(2906002)(76116006)(66946007)(66556008)(41300700001)(4326008)(66446008)(64756008)(66476007)(8676002)(6486002)(2616005)(6512007)(71200400001)(186003)(26005)(36756003)(6506007)(478600001)(107886003)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N3VjRW5QaENJMGJJblA4WVh6cWtXNm1abGRLd1kzbnFCeW5lcGE5TEVHOGRu?=
 =?utf-8?B?ZzBNSlJFcnhHYm9tSjJ3S1h5K2ZEL1pRVGFXSUtRUmlnMVFnUzFzeDlYc2dT?=
 =?utf-8?B?T1h1T3h3Wkl2Smdtc09oSmp1QVVBRXhqejhWTEwrZUFuL21OQU1rSGFla0RF?=
 =?utf-8?B?bTZOR2JUQjhCQlBXYzF2V1B3RUxnZHVCcWNnVU5aZzVRbUx1MVlkU1E2Nytt?=
 =?utf-8?B?V1dPcTcxNXhSdEp5bDRlb3RFWFhLQXdwOGRMdWZZejFibzlZNVdOajRCM1ZP?=
 =?utf-8?B?N053V3N1Q1psUHhUdFR3dm5ET1EvV3RnKzZSRlVmSEpqaE16NUZPc2tyQmYr?=
 =?utf-8?B?UGRjVHdTL3R1VnNKb0duVW1GL3dmbXNRc2p2SzUyK3RQd01VN2xCWTJVYlJO?=
 =?utf-8?B?QXFiaDNOZDRIci9YTDRDbnJNdEFjZ1A2OUJhSnhmMnlPNkw2WjdYNWw0NS9O?=
 =?utf-8?B?VXBPNDJxUE9XdVo3TGpWMmMrN2FRMitjYXZZd2pWNTlJYWhlZTlHV2E2QjJk?=
 =?utf-8?B?YVk0KzZseHY3c01KaEtwNUszdnFYaW9Dd25zRzhTdlB5bk1BQUx2em91Z05j?=
 =?utf-8?B?cFI1SU55NnBSNnZHSkN5dktMbXJXVkxvSUNpYjRTeWdvL0s1WjVobGdXeFlV?=
 =?utf-8?B?c2tlS1V1cFRETW5MY2ZYbG1xN0ZFamNCRW8zaUgyMi9ERERPQ1JHN09IMm1n?=
 =?utf-8?B?aFk3S3J1TktGMkJqOFNNeWZrZ0QzNEZmK0RjOGNxSko2ZFBDbURwVFBuNEgw?=
 =?utf-8?B?NHZud1dMV1JidGQzaEJEZTNLM2dWcTZlSXBHZlpSeEhPa1pTMlA1UzdqVm1t?=
 =?utf-8?B?RHJaZDJIT3VWNWZGQlFTSDZrZVh1Q1RxQ2VtNVJiL1NjaXdpZ1U1NCtEQWpL?=
 =?utf-8?B?OHZkWng5OFRZN3o1cmpmUVRyV2UrWkFaRnlqZTJ2VUVLVFBKb3B5M21XK2t5?=
 =?utf-8?B?d09kZDkwc0VhY2pXbG9NK0lBa0JqdDVocTBkR1pQWEoxaHZiWmVCUmNTM2pJ?=
 =?utf-8?B?YWhYTmFpNkFYRVQwZVp0K3hmL0lxSHVrRXF3aTJnYkExSEwycWR4M3d4emxS?=
 =?utf-8?B?eEZMYUc0bXUycDFQN0JLelpaVFlFMEJFSmVjdGdyMzR2R2tzZ3RMOC9kOVdz?=
 =?utf-8?B?R1B2bWxoQ1hGbC9QNkNQVTljc1MvbFEzdGdCNHVCSlRBODVqMDVyQ1Y5Zjlz?=
 =?utf-8?B?NGliWHZzZ2s5d3lBS3lIM3kreWxmOUN3RHI3bWRvSmoxY0hBWW0rZTVWVFpo?=
 =?utf-8?B?NzJrMmp0eVVkemFialJjeTZWYnB1dVJxR1JYb3N4dDVGRStRbnpRaVR5akpT?=
 =?utf-8?B?TDhDWmZaV2FGazVxZnRSNlBNVmdxQXlSWFJDazdDbnFSckpvNXdINW5jamts?=
 =?utf-8?B?eGY2MGlCVUdGbDA2TnRyU29raHFmWUlhS2dXU0RjNUswNTkvYlR4MjMweDcx?=
 =?utf-8?B?NjNjYWJxTTYwV2h4K2dwYk1PTHA0cis0czBKWGFCV0ZIR1c3OFJKdXIrQzBu?=
 =?utf-8?B?SVdtOTVTUnBsekMvNWVFMzROZ0JuVFBiZmk5cElmM3ZHK0h6UzlkQTg5UUha?=
 =?utf-8?B?cTc5d0V0RU9wT0hNZmlsd25rV2xMWjNCbzdsL2lPVzlTRE8zRGplNkxPNnRD?=
 =?utf-8?B?UGtwLzIrZ1BJN0FsTUZTQlJLZ3I1N21wQnRmK0Z0T0NiUHRHaU9iKy9xYThj?=
 =?utf-8?B?VmFsRFFwaHJUSmRmZGZFUjFOOVpJTCtMTVdhT0dnYUVWNkdKdVBUVGxiNmkx?=
 =?utf-8?B?VzI5N3Q0d0pKaFE1NjlYaXJieC80b3A4aVRwRWxwbDZ1QVZUanpJeEtJdjRj?=
 =?utf-8?B?Qk9NdThNL2doZWZFUzdmZW11UDQxRkxKOTU5U1BaVEhCTnMvbGNZU2dTZkVp?=
 =?utf-8?B?Nml1RmZGcEZ0Y2VVOFcwLy9yc0lsVkZxVTFmYXdVUWtneHRUaG1yandtdGZu?=
 =?utf-8?B?SW9yWHMyanpBWERaMFVPcWd0SXl4bVJTc05JNG5CNjJjWFZ4QUdUUC9rK3dT?=
 =?utf-8?B?WHRQWVh1dFJ5Ymk0L2loVVdtMm5lQmVLWEZEb3I2MUNJVFRCM2MwZHdQQTZM?=
 =?utf-8?B?bzNJblVEMTVnZVVKUi9SWWFZR1dFM3AxdjlSNGZONWQ2dGNhRnJCYlRCZ05G?=
 =?utf-8?B?aUNKMnluUFFKYW5tVExGOVFudzV3RlhzVmhxcndkZXo1ajZsajhVWFRabjVY?=
 =?utf-8?B?M1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <38AE0D7B9A85B14B9AD5C51B73171C01@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY0PR03MB6354.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41730ec7-4d81-47c4-a440-08db10c9f4ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Feb 2023 09:32:58.2301
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6QW4/zUgTh8BKSbSxoo8nQMCy3CuHZta3xP7vYIMj1SCgVYMFlcgi+8++Z0Kx6H73FkpSgBW3EqXZ9DJ4BdisQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB5836
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

T24gV2VkLCAyMDIzLTAyLTE1IGF0IDE4OjQzICswMTAwLCBKb2hhbm5lcyBCZXJnIHdyb3RlOg0K
PiBPbiBUaHUsIDIwMjMtMDItMDkgYXQgMDY6MDkgKzA4MDAsIFJ5ZGVyIExlZSB3cm90ZToNCj4g
PiBUaGlzIGlzIHV0aWxpemVkIHRvIHBhc3MgTERQQyBjb25maWd1cmF0aW9ucyBmcm9tIHVzZXIg
c3BhY2UgKGkuZS4NCj4gPiBob3N0YXApIHRvIGRyaXZlci4NCj4gDQo+IGFnYWluLCBob3N0YXBk
DQo+IA0KPiB3aHkgZG8gd2UgbmVlZCB0aGlzPw0KPiANCg0KVXNlciBjYW4gY29uZmlndXJlIGhv
c3RhcGQuY29uZiAiIyBMRFBDIGNvZGluZyBjYXBhYmlsaXR5OiBbTERQQ10gPQ0Kc3VwcG9ydGVk
IiB0byBkZWNpZGUgaWYgYW4gQVAgbW9kZSBoYXMgTERQQyBjYXBzLiBUaGV5IGFyZSBhY3RhdWxs
eQ0KbG9uZy1zdGFuZGluZyBjb25maWd1cmF0aW9ucyBvZiBob3N0YXBkLCBidXQgaGF2ZSBuZXZl
ciBiZWVuIHByb3BlZ2F0ZWQNCnRvIGtlcm5lbC4gT25lIG9mIG91ciB1c2UgY2FzZXMgaXMgZm9y
IGNlcnRpZmljYXRpb24gc2V0dXAuDQogDQo+ID4gKyAqIEBodF9sZHBjOiBpbiBBUCBtb2RlLCBp
bmRpY2F0ZXMgaW50ZXJmYWNlIG93bnMgSFQgTERQQw0KPiA+IGNhcGFiaWxpdHkuDQo+ID4gKyAq
IEB2aHRfbGRwYzogaW4gQVAgbW9kZSwgaW5kaWNhdGVzIGludGVyZmFjZSBvd25zIFZIVCBMRFBD
DQo+ID4gY2FwYWJpbGl0eS4NCj4gPiArICogQGhlX2xkcGM6IGluIEFQIG1vZGUsIGluZGljYXRl
cyBpbnRlcmZhY2Ugb3ducyBIRSBMRFBDDQo+ID4gY2FwYWJpbGl0eS4NCj4gDQo+IHdoYXQgZG8g
eW91IG1lYW4gYnkgIm93bnMiIHRoZSBjYXBhYmlsaXR5PyBIYXM/IFVzZXMgaXQ/DQoNCkNvcHkt
YW5kLXBhc3RlZCBmcm9tIEBtdV9taW1vX293bmVyLCBidXQgaW5kZWVkLCAiaGFzIiBpcyBiZXR0
ZXIuIFdpbGwNCmZpeC4NCg0KPiA+IGRpZmYgLS1naXQgYS9uZXQvbWFjODAyMTEvY2ZnLmMgYi9u
ZXQvbWFjODAyMTEvY2ZnLmMNCj4gPiBpbmRleCA2YmYxY2RmMjU0ZjYuLmEwODAwMTBkYThmYiAx
MDA2NDQNCj4gPiAtLS0gYS9uZXQvbWFjODAyMTEvY2ZnLmMNCj4gPiArKysgYi9uZXQvbWFjODAy
MTEvY2ZnLmMNCj4gPiBAQCAtMTI1Miw3ICsxMjUyLDE2IEBAIHN0YXRpYyBpbnQgaWVlZTgwMjEx
X3N0YXJ0X2FwKHN0cnVjdCB3aXBoeQ0KPiA+ICp3aXBoeSwgc3RydWN0IG5ldF9kZXZpY2UgKmRl
diwNCj4gPiAgCXByZXZfYmVhY29uX2ludCA9IGxpbmtfY29uZi0+YmVhY29uX2ludDsNCj4gPiAg
CWxpbmtfY29uZi0+YmVhY29uX2ludCA9IHBhcmFtcy0+YmVhY29uX2ludGVydmFsOw0KPiA+ICAN
Cj4gPiArCWlmIChwYXJhbXMtPmh0X2NhcCkgew0KPiA+ICsJCWxpbmtfY29uZi0+aHRfbGRwYyA9
DQo+ID4gKwkJCXBhcmFtcy0+aHRfY2FwLT5jYXBfaW5mbyAmDQo+ID4gKwkJCQljcHVfdG9fbGUx
NihJRUVFODAyMTFfSFRfQ0FQX0xEUENfQ09ESU4NCj4gPiBHKTsNCj4gPiArCX0NCj4gDQo+IE5v
IG5lZWQgZm9yIGJyYWNlcy4NCj4gDQpPSy4NClJ5ZGVyDQo=
