Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F06036B8D4D
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Mar 2023 09:30:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229493AbjCNIaL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 14 Mar 2023 04:30:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbjCNIaJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 14 Mar 2023 04:30:09 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 610D9149B0
        for <linux-wireless@vger.kernel.org>; Tue, 14 Mar 2023 01:30:03 -0700 (PDT)
X-UUID: 6485d5cec24211ed945fc101203acc17-20230314
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=Y+jwJYNDktJRcEqYKdPFq15UkCt32iWUGOVazsrRHj8=;
        b=bD9/2ewM+LArNM2czpe+Wv67z5Dp4Qko5lutiCPzn4hV1tPfFIPM30eqb5Tbqtjudv0f6GwvBeqfXHzpwCCbuU6o5jPMOCOR/VKFea7O2Ia7K36KL35ROSTPIhJAqulyNuJs5vClqV/3yAPvLXlNVhPsjddYHECp71YBjQHLsVI=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.21,REQID:62061e1a-021b-4e66-bedc-61820c861cd7,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:83295aa,CLOUDID:61edbef5-ddba-41c3-91d9-10eeade8eac7,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-UUID: 6485d5cec24211ed945fc101203acc17-20230314
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw02.mediatek.com
        (envelope-from <michael-cy.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 351551108; Tue, 14 Mar 2023 16:29:52 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Tue, 14 Mar 2023 16:29:51 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.25 via Frontend Transport; Tue, 14 Mar 2023 16:29:51 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=evDjyQJJX8mpBlH4MUmmirIQVNB0D/snVi2OwP5gaT14ds5qeTLbKFxhH4u1W3OI8W0cq+qE/2EBzzIoVz/vKQjYdARPhXFUDUP6ABSLXbgU5K1qrjQtDb/qYb/zWIBb3CwLVL/EEf2eAbN2AfCihwHCqIY9x5NJEeyE7yH8LlW49aud417399kGnWkiZhi8DWj+X5eO97exAi1DVLf7TknN/dHMc+QfDGlfDMBduzznXhw8qTBhVJXXPXbXD0JEpHl1uCF7KanA7s8ilsYGAmd+TR0YzytyHMHbj92oQI00i4WSAXJ3TjH8tObj8a/PLSet2kqEnsF+dQdBCo8/nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y+jwJYNDktJRcEqYKdPFq15UkCt32iWUGOVazsrRHj8=;
 b=NA6acbTijkJSiQA3GmR2SXh9Kf1htf2bOLRBBSoy/YT08EfLyPy+D1/NPZ/k9veegb0XunwwTeY72ISH06QweKHymzuluQdA57x6yzAa6SxSiX/qgQXzNJgCiH0n6tv5GyTEDvNm1A/rQ5SqvFMGbXx9cZhCJkIVX9uH+rXHniqAu+T9gxKtcW6gxLygWs+CpoR0Xih0Gi/gzpks4KbgWgGkKn9U0ETn9DngUQ0wjOGbtbejmg6miKqU+I9aphxsjjvpflBtsy8eLM4C4zt3aYR/77iWGprMFHKvZ0Ysrt6SjWtOKBtgBQJS0Bxr/MVLKN+ggh0SWbXk7Teu54yedA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y+jwJYNDktJRcEqYKdPFq15UkCt32iWUGOVazsrRHj8=;
 b=e8vk+vsBMmUfmwApdpCl6fNNOpe8/5vnq1fzcsiB6ezgSJTMx7hBNOvaqb03xefQ+ZeWiweXzc0fHFCl3gp8XtHXiJCGRNl6OQzivG2lR8L+G7p9bt4O3iIva52pt7oCzlXOWHHdOIYSkv9aCR+zdWUmC5oONKql6HtA0Klp+j0=
Received: from KL1PR03MB5507.apcprd03.prod.outlook.com (2603:1096:820:50::6)
 by KL1PR03MB7054.apcprd03.prod.outlook.com (2603:1096:820:dc::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.22; Tue, 14 Mar
 2023 08:29:49 +0000
Received: from KL1PR03MB5507.apcprd03.prod.outlook.com
 ([fe80::a826:a86e:abc3:e552]) by KL1PR03MB5507.apcprd03.prod.outlook.com
 ([fe80::a826:a86e:abc3:e552%6]) with mapi id 15.20.6178.024; Tue, 14 Mar 2023
 08:29:49 +0000
From:   =?utf-8?B?TWljaGFlbC1jeSBMZWUgKOadjuWzu+Wuhyk=?= 
        <Michael-cy.Lee@mediatek.com>
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "johannes@sipsolutions.net" <johannes@sipsolutions.net>
CC:     =?utf-8?B?RXZlbHluIFRzYWkgKOiUoeePiumIuik=?= 
        <Evelyn.Tsai@mediatek.com>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?utf-8?B?U2hheW5lIENoZW4gKOmZs+i7kuS4nik=?= 
        <Shayne.Chen@mediatek.com>,
        =?utf-8?B?TWljaGFlbC1jeSBMZWUgKOadjuWzu+Wuhyk=?= 
        <Michael-cy.Lee@mediatek.com>, "nbd@nbd.name" <nbd@nbd.name>,
        =?utf-8?B?TW9uZXkgV2FuZyAo546L5L+h5a6JKQ==?= 
        <Money.Wang@mediatek.com>,
        "lorenzo@kernel.org" <lorenzo@kernel.org>,
        Ryder Lee <Ryder.Lee@mediatek.com>
Subject: Re: [PATCH] wifi: mac80211: check the control channel before
 downgrading the bandwidth
Thread-Topic: [PATCH] wifi: mac80211: check the control channel before
 downgrading the bandwidth
Thread-Index: AQHZFeW7Ufe4GFzX60OkXD2JlsAcjK6kFeeAgFZLJwCAAARYgIAADRSA
Date:   Tue, 14 Mar 2023 08:29:48 +0000
Message-ID: <c9a31a6c06fe7a48df1d7871ac563b6f71cd4436.camel@mediatek.com>
References: <20221222091354.14050-1-michael-cy.lee@mediatek.com>
         <277f8db1f790931aaac0f94ba0ea69efcb6ba3ac.camel@sipsolutions.net>
         <70f19f86043750c8f164c316496a8690709fc062.camel@mediatek.com>
         <386c21d475215c95966bbac6b0853e2715081789.camel@sipsolutions.net>
In-Reply-To: <386c21d475215c95966bbac6b0853e2715081789.camel@sipsolutions.net>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR03MB5507:EE_|KL1PR03MB7054:EE_
x-ms-office365-filtering-correlation-id: a4cb4053-5fb5-4644-302d-08db24664655
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gihf72d0nhpft5Ev5SVsxoVXT0O1syYCFiUA+NJ5zbQcGSFioQdhl77RPxIVMlxw+9Br1GBZ8SB69HcJGMRgGmg0PCHfiGMI3SZ1f0jDr9GUXh7AMQW9xI5AfWXgxiVc1H35xoNUYO8hw2/V5N2fpxEjYI5jZ5AJ5aNUaHMjicTtAL2pa5rd4JRzLIQix4hqq2ZZcWmO6zUFY9yQyYKC2WzSpXvUBLCfWEjffF1sIHrAzgsoamXo9Uy9Ym6Df6KB24KiYEh+3F++zIFvvzCLrr3rqmFJEj6dMBEGZVEhxYlt0L+GRg+5nVufJH+7tkIVnjBhXoYzvtXJC22hv68suLsoPlQDL2ON/nGCf44rR9/+4rEdskDaBhRjEPl0PAeZW/seaHh98qZS5tPUk/ldOWl0nmek9wVbZyuq5Hui6trOS0db05m8jGo9dynVyOJX0J8SlVY9zBWPCstL5PYRG5usp9S620c42RkSm4U42HptuWJnwKfhy6ZJabp5p6Dr45o+lbfQfcRAiNBSrM82uoCzPGdopU1y9cZgTMi3d1hZlwWiDqbUK1ACn7nsjpK2Io74J+pd65Fb0Kja8ILvS8NmrHqTuYTRqaSiCLpeN6J7J9Evq38KYDbyggH41zDJCMg4MJanNB5SQembFuC7fgcDkPmcZJ9N1xk75BGvGWxuhbrj0WZ15iYPvsnD5AaYKdUYxIkWJuMgjfzQ2WO0d+Qi1LmMdggnndIkL4XUQzI/H8ePnLcPGWkXJsxMqD5y
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB5507.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(39860400002)(136003)(396003)(366004)(376002)(451199018)(85182001)(36756003)(186003)(54906003)(38100700002)(110136005)(316002)(478600001)(86362001)(5660300002)(71200400001)(64756008)(6486002)(91956017)(2906002)(66446008)(66946007)(66476007)(41300700001)(107886003)(4326008)(66556008)(76116006)(8936002)(8676002)(122000001)(38070700005)(26005)(6506007)(2616005)(6512007)(83380400001)(66899018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QVc1MHhOSTMzVU5oclpXcG9CWmFJNHpVcksyZTgrbHVzMmgxVFlJeEV5VkZK?=
 =?utf-8?B?MWNpb25UOEdFZEpTV21NcTYwNDJQOFNyT1hBQWN5SndVNElCSTN4YW94SGhJ?=
 =?utf-8?B?T04zNC9Va25taFNENmlxMHYvN1c3Q2ZJMzlmRldieGZsY0VNOXBaUzU4ZGt6?=
 =?utf-8?B?NGU3Znl2cjRUSU9ZSm9lT2hPeWVwN210WXBwWGxFcTNLWHc0bFVEMlpPRXc2?=
 =?utf-8?B?RjFQUTFDdmZrODlJN2hNajFkTXdyVjFJNFJmdnhKWnZVOUZsLzlHaXhnY3NM?=
 =?utf-8?B?U2VZREE4VUlMOUwwWjZERVYzb3FWUVlKSU5BYkFvR0NDUzQrVllXTDRXWGFU?=
 =?utf-8?B?NUsvbVR4Sk5xUHZycTNseXJ2cVFQNnc0QjZZOHE2dE5lajh0Z2tiQ3Y5aFJD?=
 =?utf-8?B?QjFUYXBIT1huU0hzZCsxVktxOEluVmJjT1RUZkxzS3VBNlREdE9OU0t6anA3?=
 =?utf-8?B?TGtFV1cvYVhiK0taazZXL0VrZUt2ZG9OYU1vanUweHJvYVc3WUNPRkp1ZnhW?=
 =?utf-8?B?NDJ4bUJrRC80RUdXRElVNUhNZW51Sk0vVDNqWTFGN0pJbmVvaFVVekpmY3Ft?=
 =?utf-8?B?c0VvNStnN1RlRVlqVW1odzB6T2JTWjJjcVp0Qmd1MEwzUzcvLzQ5UTE2dm4y?=
 =?utf-8?B?dFRDbmhqcHdDcTdHQURnTXBUTFVkbU9qZnprczk2aUdITVBwaGVvQVVmMFk0?=
 =?utf-8?B?VExLWFgyelFxMlh6MXRBNnR2alBsditsNFJjeHJVaGtFaURGWHpuTVVESGJB?=
 =?utf-8?B?UXVJd2NGSHVqbHUzVTNZdDdubW1OTlhKd0F3c3hoTE8rMnUzVXlkRE1xa24r?=
 =?utf-8?B?QnBBenl5YUFLYkxOSlpGTTUwR2RBdXprTm1sWE52eStJUHg0TDIwMGRjdUtn?=
 =?utf-8?B?amoxR2NxYVh0VlhaWC9XTVBpSnJoY2laTHZ6Mk16Tmg4TXE5YWFjSk14emkx?=
 =?utf-8?B?TEd5SWltSy9uc0wzWnBYN0Z2THV0YjlEQ3ZEWTNIM2NpWDJkell2MUVyOFc4?=
 =?utf-8?B?V08rcVptaGRTZ3ptZ3lwdUR5OWZwdE1TSHd2UFl0VjRlKzczT1JOMXROQXZV?=
 =?utf-8?B?MTB3TTRxdFpTRWpmeklHb2lGNDlqOGtoUXIrYitKZUhQaUc4RURidW1XMFlC?=
 =?utf-8?B?ZkwvMGpuYzYrUTVjQ0syMGttSldvSCtWRjNybnNVSWdyN0xNNEUzUU1jM09v?=
 =?utf-8?B?Qm53d3ZndFFZVW1wTlRiZXJMWFVWQXVXdEpuM0cxZ1ZUSTBCKzdhTFlWT3B6?=
 =?utf-8?B?bFE5WEN0LzltSjMxMms3bnlJYS9uMnF1VVpaY3UzQjdVejUyNUtnTm1mR1hR?=
 =?utf-8?B?ZTdyUjdSVEo0TjZiaXc0VTMvYTdSWHJnZ29PUVo4d0ptQzhlUHJaZ0FaYTlt?=
 =?utf-8?B?QTdyeE1QWE5yNm01eDNhV3RHWG8wbzR1bDJRcGphMXBqeEtHN1BCSENLdjhQ?=
 =?utf-8?B?OGp5QlgvV2t6bmFYeDZ2ZjhnNFM3YWlRS004ME83eEdoQXoxcm9xWVFGc25S?=
 =?utf-8?B?bCs1T3BxUjc5cGpSUVB6NGRsOXBQUHIxTHQ5dlVLOWRpWjZ0S1IwSDFjcUND?=
 =?utf-8?B?MzdXVTZyTXJ5YnJ6bzEveld5TkRRbDlFUDdpOUlmNk9rcUgrSjF5dXA0V2R1?=
 =?utf-8?B?ZjF5bm1lM0htT0hVTldkS0o0dzMvT3VMNzR2cUVaSkpIMHoxUy9mT1lvQjVO?=
 =?utf-8?B?ZlkzWGc1ZDRTWUV6Z1BlbVFSSDF2UmIvUUFYTFRxUmkrelBKWEJUc1kwNXoz?=
 =?utf-8?B?bzR2RzlyUUwyODZXdmpYNGVaRlBIQTcrcWtDRlYyTmlQeW0rNnhEcjBmTTJw?=
 =?utf-8?B?cjg1T1NXclh1ZWxMd1ZNVVRNVkwrUXFuYzM5dWRjVjZLZTU3VnhNNGthN1F5?=
 =?utf-8?B?Uk91UUJBa2N6OS9zdmVxdlBaMXpPTkk3TjFVOTBrb015RmJJSGRnd01scE9Y?=
 =?utf-8?B?UUg5d3NSN2F5MDF4VmJWN3Q3KzRKTE5zSktxUDY1QlZoeUhka3FtL3ZXTEFj?=
 =?utf-8?B?dC8ybHpSSWY2c0x0L3lEZXkxd01FRFdGNWNLc2dhVTl3SWN5enVIRDZhL0R2?=
 =?utf-8?B?ZDlhTEQxVjBJK0tzcnJISk9ZV0RHMURtbjEwbjd4RmVhenZ2bW9sRFZpbW4z?=
 =?utf-8?B?cmRhWTNVTFVtczF4Y0lvSlh5S0ltV0JGNFdyT1pkNVFUekNYOStUT1BEREhx?=
 =?utf-8?Q?ezmyByiqCqngZbUTOpNSMFk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <20703DED60540641BCBC52F32A864030@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB5507.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4cb4053-5fb5-4644-302d-08db24664655
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2023 08:29:48.7996
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VspT8RtLYsqR4S6apaBGOoU16pE8LvtER3RfJ7cN38L5ffnbqGOuyBXT6YaCm/FBJ6tweD+sAR1aI8RzlcdBTr+YPR880ymPs66SUsamnH4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB7054
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,RDNS_NONE,
        SPF_HELO_PASS,T_SPF_TEMPERROR,UNPARSEABLE_RELAY,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

SGksIA0KDQpQbGVhc2Ugc2VlIHRoZSBpbmxpbmUuDQoNCk9uIFR1ZSwgMjAyMy0wMy0xNCBhdCAw
ODo0MiArMDEwMCwgSm9oYW5uZXMgQmVyZyB3cm90ZToNCj4gSGksDQo+IA0KPiA+IFRvIGRlYWwg
d2l0aCBzdWNoIGFuIGVycm9yIGNhc2UsIEV4dGVuZGVy4oCZcyBTVEEgaW50ZXJmYWNlIHdvdWxk
DQo+ID4gZG93bmdyYWRlIHRoZSBjaGFubmVsIGJhbmR3aWR0aCAoZnJvbSA4ME1IeikgYW5kIHJ1
bg0KPiA+IGllZWU4MDIxMV9saW5rX3VzZV9jaGFubmVsIHRvIGNoZWNrIGFnYWluIHVudGlsIHRo
ZSBiYW5kd2lkdGgNCj4gPiBiZWNvbWVzDQo+ID4gdGhlIG1pbmltdW0gMjBNSHouIA0KPiANCj4g
Q29ycmVjdCwgYW5kIHRoZW4gaXQgZmFpbHMuDQo+IA0KPiA+IFNpbmNlIHRoZSBjb250cm9sIGNo
YW5uZWxzIGFyZSBkaWZmZXJlbnQsIGRvd25ncmFkaW5nIHRoZSBiYW5kd2lkdGgNCj4gPiBjYW5u
b3QgbWFrZSBpZWVlODAyMTFfbGlua191c2VfY2hhbm5lbCB0byByZXR1cm4gMC4NCj4gDQo+IFJp
Z2h0Lg0KPiANCj4gPiBGaW5hbGx5LCBFeHRlbmRlcuKAmXMNCj4gPiBTVEEgaW50ZXJmYWNlIGJh
bmR3aWR0aCAoaWZtZ2QtPmZsYWdzKSB3b3VsZCB1c2UgMjBNSHogYWZ0ZXJ3YXJkLg0KPiA+IChJ
bg0KPiA+IHRoZSBjdXJyZW50IGtlcm5lbCB2ZXJzaW9uLCB0aGUgZmxhZyBpcyBsaW5rLT51Lm1n
ZC5jb25uX2ZsYWdzKQ0KPiANCj4gQWxzbyBjb3JyZWN0LCBidXQgZG9lcyBpdCBtYXR0ZXI/DQoN
Ckl0IG1hdHRlcnMgYmVjYXVzZSBFeHRlbmRlcidzIFNUQSBpbnRlcmZhY2UncyBpZm1nZC0+Zmxh
Z3MgaXMgY2hhbmdlZA0KZHVyaW5nIGJhbmR3aWR0aCBkb3duZ3JhZGluZyBhbmQgcmVtYWlucyBj
aGFuZ2VkIHRvIHRoZSBuZXh0DQphc3NvY2lhdGlvbi4NCg0KPiANCj4gPiBBdCB0aGlzIG1vbWVu
dCwgYSBob3N0YXBkX2NsaSBjaGFubmVsIHN3aXRjaCBjb21tYW5kIG1pZ2h0IGJlDQo+ID4gaXNz
dWVkLA0KPiA+IG1ha2luZyBFeHRlbmRlcidzIEFQIGludGVyZmFjZSBzd2l0Y2ggdG8gUm9vdEFQ
J3MgY2hhbm5lbCAoY2gzNikuDQo+ID4gQmVjYXVzZSB0aGUgY29udHJvbCBjaGFubmVsIG5vdyBz
eW5jaHJvbml6ZXMsIEV4dGVuZGVyJ3MgU1RBDQo+ID4gYXNzb2NpYXRpb24gYXR0ZW1wdCBzdWNj
ZWVkcy4gSG93ZXZlciwgRXh0ZW5kZXLigJlzIFNUQSBpZm1nZC0+ZmxhZ3MNCj4gPiByZW1haW5z
IGluIHRoZSBmYWxsYmFjayBzdGF0ZSBhbmQgdGh1cyB0aGUgb3BlcmF0aW5nIGJhbmR3aWR0aCBp
cw0KPiA+IDIwTUh6DQo+ID4gaW5zdGVhZCBvZiA4ME1IeiB3ZSBleHBlY3QuDQo+IA0KPiBTbyAu
Li4gc3RpbGwgbm90IHN1cmUgSSB1bmRlcnN0YW5kLg0KPiANCj4gQXJlIHlvdSBzYXlpbmcgdGhh
dA0KPiANCj4gIDEpIHlvdSBoYXZlIGEgcmFjZSwgYW5kIGhvc3RhcGQgc3dpdGNoZXMgY2hhbm5l
bHMgd2hpbGUgdGhlIGNsaWVudC0NCj4gc2lkZQ0KPiAgICAgY29kZSBpcyBpbiB0aGUgbWlkZGxl
IG9mIHRoaXMgbG9vcD8NCg0KTm8sIHdlIHRoaW5rIHRoZXJlIGlzIG5vIHJhY2UgY29uY2VybiBz
aW5jZSB0aGUgbG9ja3MgYXJlIHdlbGwtDQptYWludGFpbmVkLg0KU28gdGhlIHN0ZXBzIGFyZToN
CkZpcnN0IGFzc29jaWF0aW9uIGZhaWxzIC0+IGhvc3RhcGQgc3dpdGNoZXMgY2hhbm5lbCAtPiBz
ZWNvbmQNCmFzc29jaWF0aW9uIHN1Y2NlZWRzICh3aXRoIFNUQSBvcGVyYXRpbmcgb24gMjBNSHop
DQoNCkV2ZXJ5IHN0ZXAgc3RhcnRzIGFmdGVyIHRoZSBwcmV2aW91cyBzdGVwIGhhcyBmaW5pc2hl
ZC4gDQoNCj4gDQo+IG9yDQo+IA0KPiAgMikgdGhlIGlmbWdkLT5mbGFncyBhcmUgbm90IHJlc2V0
IGNvcnJlY3RseSBmb3IgYSBuZXcgYXNzb2NpYXRpb24/DQoNClllcywgb3VyIHBhdGNoIHdhbnRz
IHRvIHNvbHZlIHRoaXMgcHJvYmxlbS4NClNpbmNlIHRoZXJlIGlzIG5vIHdheSB0byByZXNldCBp
Zm1nZC0+ZmxhZ3MgYWZ0ZXIgYmFuZHdpZHRoDQpkb3duZ3JhZGluZywgd2UgY2hlY2sgdGhlIGNv
bnRyb2wgY2hhbm5lbCBiZWZvcmUgZG93bmdyYWRpbmcgdGhlDQpiYW5kd2lkdGguIElmIHRoZSBj
b250cm9sIGNoYW5uZWxzIGFyZSBkaWZmZXJlbnQsIHdlIGRpcmVjdGx5IGZhaWwgdGhlDQphc3Nv
Y2lhdGlvbi4NCg0KPiANCj4gDQo+IGpvaGFubmVzDQoNCkJlc3QsIA0KTWljaGFlbA0K
