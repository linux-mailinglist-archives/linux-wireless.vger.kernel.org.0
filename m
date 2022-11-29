Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73F8763B7C3
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Nov 2022 03:22:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234891AbiK2CWV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 28 Nov 2022 21:22:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233537AbiK2CWU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 28 Nov 2022 21:22:20 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 646152AC7D
        for <linux-wireless@vger.kernel.org>; Mon, 28 Nov 2022 18:22:10 -0800 (PST)
X-UUID: 0dd8c4a8c1e2461a8eff9dfe26aef51e-20221129
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=m3Tkh+VS/YBfrBbRFyczCfRaSEayVuvAVOOrVhSPnhs=;
        b=HWVe6l1snsln5sNlayFB/1OTmjskqLASELD+rI1UmewSG/C6YT9oC8p0+sGCNbEbEF9MxNTZYZWWsmn/E0CcaijLGeDLdIJlMMJFAB2eBjeHTwhz2YRZ/02BESWsrkGCGRK9s3q/7CtqiYNms3XFKYM/WjK3bqeV+61CoYScH24=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.14,REQID:25522fba-2990-46dc-a55f-b6393f9c62ea,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-INFO: VERSION:1.1.14,REQID:25522fba-2990-46dc-a55f-b6393f9c62ea,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
        elease,TS:-5
X-CID-META: VersionHash:dcaaed0,CLOUDID:af227c17-81a9-4b5f-95c6-b6b92590fd73,B
        ulkID:221128172644MWLIZQ46,BulkQuantity:10,Recheck:0,SF:38|17|19|102,TC:ni
        l,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:40,QS:nil,BEC:nil,COL:0
X-UUID: 0dd8c4a8c1e2461a8eff9dfe26aef51e-20221129
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1146994065; Tue, 29 Nov 2022 10:22:01 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Tue, 29 Nov 2022 10:21:59 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n1.mediatek.com (172.21.101.34) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Tue, 29 Nov 2022 10:21:59 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B1dLNSN5slhH2rfI7cNUThuDJuMHYGDg2uzfKogZwS8sicZYrcV1bxpwNrIXAk9b2T0UvIWfVU1ro1OyIJ9lSt/jwhwK8aXb6N4GisrBOWzFxynKVjS3TddkAyxoQZOB19j3jyBmncBfOrYuqe+pe47eqwbukiAgC43pFqJTz8p2NA7nqNfwxrvqVEieqAlmQ0PPDQVUVX2r79eAeCXKvDT9gkRIA8T3RqzEwtKIFX659I+mPRnsJnd2JT21s+pAZtqV/AXXk1EzIon+quteGC5E5aFDg7EiQSoiD3qoFCOxmHfobPDGWQViMtzD2tIgYElm4XjsDOFRjTCzvcoeyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m3Tkh+VS/YBfrBbRFyczCfRaSEayVuvAVOOrVhSPnhs=;
 b=GIZr1g2Go9bxUPTMa67wlf8IaPArAk7stmzh1TDT7dfkC75+L9BZMvlm+kDzG0RQIauKo03abue24CpQ/6zAoKV5RMQjvQRFFXlX/IvGvLCwhBDZAumcadiiqcedvl6QyyQZGHDdCAm0CQbMXtZZu0sqel32EXrm9KzvN+dCVT7HHYgdxqNqkBAJnbiDiWx1IrjeM+LuehwwtyEfZFQhtJ48Hbk5Tq/5ToXk8xzoAL9ekguc8oB7espnVvriSs9fuVyxKl50MJApaZ2Xliwcy8nP8Yrf8ZvvSlJxIX98n/ANxvZhVvW5Fy+oUAPwIW+ULycq7ui/4hfRrddP7gNaSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m3Tkh+VS/YBfrBbRFyczCfRaSEayVuvAVOOrVhSPnhs=;
 b=uyFVeQhJHv9LcvkHhj1VDApqxOES1XPV978k0uqnF/iQPOx+aF13u/MEsavBvN+5mEdQ66vt3K/dZCv623/NjuMNIcVYVUxdQJirtKFUClEMffXXiF3dB77ROQStyjG4YczXoyF0ZXzCWeeoePS+aW4tP0Jg8Ok8w/8Y17MVeNE=
Received: from TY0PR03MB6354.apcprd03.prod.outlook.com (2603:1096:400:14a::9)
 by TYZPR03MB7084.apcprd03.prod.outlook.com (2603:1096:400:33e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Tue, 29 Nov
 2022 02:21:58 +0000
Received: from TY0PR03MB6354.apcprd03.prod.outlook.com
 ([fe80::320d:30ac:41ac:b1a3]) by TY0PR03MB6354.apcprd03.prod.outlook.com
 ([fe80::320d:30ac:41ac:b1a3%7]) with mapi id 15.20.5857.023; Tue, 29 Nov 2022
 02:21:58 +0000
From:   Ryder Lee <Ryder.Lee@mediatek.com>
To:     "nbd@nbd.name" <nbd@nbd.name>,
        =?utf-8?B?RGVyZW4gV3UgKOatpuW+t+S7gSk=?= <Deren.Wu@mediatek.com>,
        "lorenzo@kernel.org" <lorenzo@kernel.org>
CC:     =?utf-8?B?RXZlbHluIFRzYWkgKOiUoeePiumIuik=?= 
        <Evelyn.Tsai@mediatek.com>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?utf-8?B?TGVvbiBZZW4gKOmhj+iJr+WEkik=?= <Leon.Yen@mediatek.com>,
        =?utf-8?B?U2hheW5lIENoZW4gKOmZs+i7kuS4nik=?= 
        <Shayne.Chen@mediatek.com>,
        =?utf-8?B?U3RlbGxhIENoYW5nICjlvLXmm4nkvakp?= 
        <Stella.Chang@mediatek.com>,
        =?utf-8?B?S00gTGluICjmnpfmmIbmsJEp?= <km.lin@mediatek.com>,
        Sean Wang <Sean.Wang@mediatek.com>,
        =?utf-8?B?U291bCBIdWFuZyAo6buD6Iez5pi2KQ==?= 
        <Soul.Huang@mediatek.com>,
        =?utf-8?B?WU4gQ2hlbiAo6Zmz5b2l5a+nKQ==?= <YN.Chen@mediatek.com>,
        =?utf-8?B?UG9zaCBTdW4gKOWtq+eRnuW7tyk=?= <posh.sun@mediatek.com>,
        =?utf-8?B?RXJpYy1TWSBDaGFuZyAo5by15pu45rqQKQ==?= 
        <Eric-SY.Chang@mediatek.com>,
        =?utf-8?B?Q0ggWWVoICjokYnlv5fosaop?= <ch.yeh@mediatek.com>,
        =?utf-8?B?Um9iaW4gQ2hpdSAo6YKx5ZyL5r+xKQ==?= 
        <robin.chiu@mediatek.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH] wifi: mt76: mt7921e: introduce reboot notifier support
Thread-Topic: [PATCH] wifi: mt76: mt7921e: introduce reboot notifier support
Thread-Index: AQHZAKCqNbhXUlkP/U23NqP8IGBqnq5UFcCAgAEIBwCAABOqgA==
Date:   Tue, 29 Nov 2022 02:21:58 +0000
Message-ID: <6d384293807fce236aae4e7af1bad8780efe4c59.camel@mediatek.com>
References: <28482de35c4f1589dcf96b662a48bc558fe46e8f.1669361180.git.deren.wu@mediatek.com>
         <14f4381a-d424-f84a-bc85-f4b25e6f1641@nbd.name>
         <dc2ee8517043831471f22324493acaac201196da.camel@mediatek.com>
In-Reply-To: <dc2ee8517043831471f22324493acaac201196da.camel@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY0PR03MB6354:EE_|TYZPR03MB7084:EE_
x-ms-office365-filtering-correlation-id: ac3da471-f92b-4338-b828-08dad1b07dd7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: v46AI5D6vkZxkoCA6tyvjyqlg1uma0uNnFp3Z0DwlXQw3juXNlan7KeqqwN8nfM+QsmND+Ptn2G12NO2fpXhfkC8dHpNUo2bLjmiixR0JJHvL+SL3vT3IBtTFmIfaE9/KaInVVjqZ7xYk9vetgNmqb4HUWlfXuynpvwVZm5yaOoMUSViOV5Kl0w6Lo+E+dPMWg7KLJx8u07QxMg0bzAP7LvO/XwyN3l9XeW76NkGpaJ+m5T9FbwaKJuev+Q553REsf9vQzlG2NOf8R3Cgk9Z8jpFNXqMEwYXqEeO+1TzRpTV9/4DT90ZKba1xMw/Q7ZOADPE9icHkejxHX9q8VSofTFSEoGNNstb3Aa01522sV6RCdFK2Eg7Mh/iJuRCsIvepZOtL5Px1h+wPQkrxozftYVQJfaD9XavTgjcDl3qOJP53oslbD2UGz3bTMZIXpQN2nRYzb7BLJkr4mMvp3qczYNJk0GO35CRUbgICNM73/tSJT0wpNcsXSicWgWlZby+N6YwyFpD2K/Cfbw1fw7FG5pLSwk9dshEcplab36pv0Mxk0CsPAzIEovp0RGsjRkcXMYsgmHwQAoA5JutjY4pwfZPADYnAi155ikQhsgxymSz0wr8zBglJw9DtHLGSC4S+tZhFqBwgaZH1rgubBooVcuQMIiaeSxYKGIH8dyE2rT+QLw3rCGYBxVjen7N9S2u7RTdRntbPKZkTMaMzhkKDA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY0PR03MB6354.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(346002)(136003)(366004)(376002)(451199015)(2906002)(53546011)(186003)(6486002)(36756003)(6512007)(478600001)(6506007)(71200400001)(122000001)(26005)(38100700002)(86362001)(38070700005)(83380400001)(2616005)(41300700001)(66556008)(66446008)(64756008)(8676002)(66476007)(66899015)(66946007)(4326008)(4001150100001)(8936002)(5660300002)(76116006)(316002)(54906003)(110136005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OXRSNVVTWmhWbGtuUWJrRk1rTjZHdXdvQmJkZHFjMk0zOFBDZnNtb1gyMTEv?=
 =?utf-8?B?QnpUSG1NeVVEd2dzaG5qM1VkNEtpYzZDbm9IdlBHczlGakdFdHFoQjJ6VDRX?=
 =?utf-8?B?VjlIdXhWNTZyUUYxQmFqYzRTYXZzMEl3UUlCTFEwMU5jTTNwdnczaHdSUkRR?=
 =?utf-8?B?NVBVa3B2eitDWEVCYjR3ZzJBMVNSRXIyWGY0M3VLQVlJZWduVEg0VUhvNXU5?=
 =?utf-8?B?eHhYTVJXTlFHL0J5MkZaMDNCQ2h4UnZvVjdTRSs3eWpQRmloUnRrZyttYnlk?=
 =?utf-8?B?R2tocDFQeDI2czBQankxQVdBemF5ejIyVkMxY3VJUzI1TmphM3hDVUlZTjlK?=
 =?utf-8?B?eHduY1pOVEp0VGJuZ3V2c0hBQitYQ3ZXaFJ6MWFoNmVxZ1BsMWtaaUdlc25M?=
 =?utf-8?B?WWVzRGlUQWtVQjlDaFlMSERNbUVrZ1RkQUlSdk5ZTlFyNHRSN2d1TXBKYk50?=
 =?utf-8?B?THRwVXRpMEM5TTRUaVBuWnZpTDlBUGY5SGdRekhPYi9va2JOT29xK3BZWmVV?=
 =?utf-8?B?YjRLSzkyaE8vdFJSWW05Y0NyN1NpV2NoeHRROHJSU1N5REdQNjNGYytQZ1dl?=
 =?utf-8?B?MjUwU2RlSUJYd3RHREtHT1JOWHBzN1FBcGUvTDRWZ25DdGF3dkdpeVUvbG80?=
 =?utf-8?B?NU1VaE5CbTdvSUJSUnBVM1FjTkc4VzhTRW9GSDQySXU1dTU2L0djaUQ5ZWNz?=
 =?utf-8?B?aG5YSE9jR0xyU25EQS93OFhMUUpMUWNKYVg5dzdNVmMwZEpRV1hlM3RkRzBh?=
 =?utf-8?B?azNPZ1JoYkhxLzBUMmd1S1NzWTZvemh2ajJHQk0wN2h2QXdvblpIR1ZWOU8v?=
 =?utf-8?B?VDFpNEd4V3dlU3diMUpHWG1jNkx3VExIR1N6VGtBaGEwYlZHOFpqZUJiVktL?=
 =?utf-8?B?VVh2c2luT2J2dkxBeEJMV0gwelFLL0ZKMENBVUYrN1Vja2VNaDBqRlBWRDdE?=
 =?utf-8?B?T3ZnRTlMajFBRXRXUE90UGVsTHB4SlptMll1MDZjd0NlaisyVVZkeXZ4dE1P?=
 =?utf-8?B?ZEluSDVJaXlxU0JScDJ6ZStMd3drTHNsb2tibVpTNk8wSGVPYXZTa29xTzdG?=
 =?utf-8?B?elphemd1RmxHOVZGV0lGM0xkeEI1UTU5QTI5K3ZmQktET1VQV0JEYkhqWTJO?=
 =?utf-8?B?a01YZmpsL1diSW9CSmt4T3k4eXJmY2ZnbVlzb3JIWnNWZDg1RjBRdkxSR3NY?=
 =?utf-8?B?djhpdjMrQVNnWDE1Q2NCR3ZEeEQxTVk5UXpsYXZHMWcrTnc4L2VUSXFWbjRX?=
 =?utf-8?B?b1M4SjIvUmxJdm9rQ3hOQndaN3pJTTBwVU5NU0x4cWdOZWd3dVgwRUo3Q0o0?=
 =?utf-8?B?SFlRclV4bVdSTmMvZXBaMnpPNTkvR2RLbDU0RGlzbWFSMWtudjI1NEhGRGF5?=
 =?utf-8?B?ZDJtWGt5NTB5V3pIRUF4b0k5ZWVYNm1KcFdZaDI4bWQ2Z0gzSlNPendhdWdO?=
 =?utf-8?B?TEhITjQ4aFVNTnBDc1lTb045UlQ2U2IwaE1IZTNQbUNqNFlFemNOc21zUVRx?=
 =?utf-8?B?aStWWlNURm5NSmlsMW9HaExJOW43M09vbFdXL2ZXbjBiM1A0bUFlYURiWmEy?=
 =?utf-8?B?N0FIVXB5c0ZWN1JHOUZXaUFLR25tR1hrdnUrTXBTY3U2ZURYZ0JraFZ2d1g4?=
 =?utf-8?B?Z2dEZ29mOEJPWlBWb1VrTHJadnNMVVVMMWZJQWF0QkdmMm0xamdCWU42dFhK?=
 =?utf-8?B?eUlET0dxTnBxdTZrVWRpRUxFbTJyanJVaXZJUlNWRTVxN1dieEhPN3VGOXRV?=
 =?utf-8?B?U0lsd1crbHdHa1p2Zm95NVBYQTM4ZlgwZjEybm5ueUVWZ3J6dzdIZXRiSk1Z?=
 =?utf-8?B?K1YybXVEekoyUXpUbGMzVmllVGJlb3NmeW9MNTY3YTl5Zm9GbmdpM09VTWZP?=
 =?utf-8?B?N2tmS0JjbEVoVkhtQWpjQ3JmVzBvaDhwMHNoVjdLUjlVOGZUVG1rTldMVnZL?=
 =?utf-8?B?TFRrTTNnUHRFOWNWNFd1TVVzUXRGdXZLWnFqeWZoN2ZZc1dUdHM0bXRBaDVQ?=
 =?utf-8?B?dXdKQkdNMit2bEE1TGRzZU9iQVpqdWdiY21Bd0YvWkQ3UEJDa2NVclpxR3hx?=
 =?utf-8?B?bUVIb21JYzJsZTZMZmQ1cEtNUHJBQmJWcTlUTllTRHc0ckpKQngva2lLVnFq?=
 =?utf-8?B?MnhDRk5UQjRrVGx3WjZtWC9yVDc4am1GMnI4QTZ5R3UzeklKMSt2UU9aY2pO?=
 =?utf-8?B?WFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <588FDF776DE9BD4BB25630306C1D74B1@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY0PR03MB6354.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac3da471-f92b-4338-b828-08dad1b07dd7
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2022 02:21:58.1616
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3rkD4qquS4DinjaXz9dQQxz/vaHOICjNPA9N3ubWIGCpz5F0egozHzBOGWdE3S1HxSzNhOIdgU5z11WHk1VaWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB7084
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_MSPIKE_H2,RDNS_NONE,SPF_HELO_PASS,T_SPF_TEMPERROR,
        UNPARSEABLE_RELAY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

T24gVHVlLCAyMDIyLTExLTI5IGF0IDAxOjExICswMDAwLCBEZXJlbiBXdSAo5q2m5b635LuBKSB3
cm90ZToNCj4gSGkgRmVsaXgNCj4gDQo+IE9uIE1vbiwgMjAyMi0xMS0yOCBhdCAxMDoyNiArMDEw
MCwgRmVsaXggRmlldGthdSB3cm90ZToNCj4gPiBPbiAyNS4xMS4yMiAwODozNiwgRGVyZW4gV3Ug
d3JvdGU6DQo+ID4gPiBGcm9tOiBMZW9uIFllbiA8TGVvbi5ZZW5AbWVkaWF0ZWsuY29tPg0KPiA+
ID4gDQo+ID4gPiBTb21lIGNvbWJpbmF0aW9ucyBvZiBob3N0cyBjYW5ubm90IGRldGVjdCBtdDc5
MjFlIGFmdGVyIHJlYm9vdC4NCj4gPiA+IFRoZQ0KPiA+ID4gaW50ZXJvcGVyYWJpbGl0eSBpc3N1
ZSBpcyBjYXVzZWQgYnkgdGhlIHN0YXR1cyBtaXNtYXRjaCBiZXR3ZWVuDQo+ID4gPiBob3N0DQo+
ID4gPiBhbmQgY2hpcCBmdy4gSW4gc3VjaCBjYXNlcywgdGhlIGRyaXZlciBzaG91bGQgc3RvcCBj
aGlwDQo+ID4gPiBhY3Rpdml0aWVzDQo+ID4gPiBhbmQgcmVzZXQgY2hpcCB0byBkZWZhdWx0IHN0
YXRlIGJlZm9yZSByZWJvb3QuDQo+ID4gPiANCj4gPiA+IENvLWRldmVsb3BlZC1ieTogRGVyZW4g
V3UgPGRlcmVuLnd1QG1lZGlhdGVrLmNvbT4NCj4gPiA+IFNpZ25lZC1vZmYtYnk6IERlcmVuIFd1
IDxkZXJlbi53dUBtZWRpYXRlay5jb20+DQo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBMZW9uIFllbiA8
TGVvbi5ZZW5AbWVkaWF0ZWsuY29tPg0KPiA+IA0KPiA+IFRoaXMgZG9lc24ndCBqdXN0IGFmZmVj
dCBtdDc5MjEuIFRoZXJlIGFyZSBzb21lIHBsYXRmb3JtcyB3aGVyZQ0KPiA+IHNpbWlsYXIgDQo+
ID4gaXNzdWVzIGhhdmUgYmVlbiByZXBvcnRlZCB3aXRoIG10NzkxNSBvciBtdDc2MTUuDQo+ID4g
SSB0aGluayB3ZSBzaG91bGQgbW92ZSBzb21lIHBhcnRzIG9mIHRoaXMgdG8gbXQ3NiAoYW5kIG10
NzYtY29ubmFjKQ0KPiA+IGNvcmUuDQo+ID4gDQo+ID4gLSBGZWxpeA0KPiA+IA0KPiANCj4gU3Vy
ZSwgSSB3aWxsIHBvc3QgbXQ3NiBhcmNoICsgbXQ3OTIxZSBpbXBsZW1lbnQgaW4gdjIuDQo+IA0K
PiBSZWdhcmRzLA0KPiBEZXJlbg0KDQpUaGlzIGlzIGFuIHVzZXJmdWwgZmluZGluZy4gbXQ3OTE1
IHN0aWxsIGNhbGxzIHdmc3lzX3Jlc2V0IGF0IHRoZQ0KYmVnaW5uaW5nIG9mIHByb2JlKCkgdG8g
ZGVhbCB3aXRoIGJvb3R1cC9tb2R1bGVfcmVsb2FkIGlzc3Vlcy4NCg0KUnlkZXINCg==
