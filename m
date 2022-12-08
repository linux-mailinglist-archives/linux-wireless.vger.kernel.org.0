Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C0A6646FEF
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Dec 2022 13:44:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbiLHMod (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 8 Dec 2022 07:44:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbiLHMoc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 8 Dec 2022 07:44:32 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1DE663D71
        for <linux-wireless@vger.kernel.org>; Thu,  8 Dec 2022 04:44:24 -0800 (PST)
X-UUID: b8880b1e7bf344aa9259bc4d798ceda2-20221208
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=RS9+UjMGm796BD27oqgrB1cbcGxywRf4GHt1/AjFfu8=;
        b=YwVhe1vJr4wEOX/sEltwhZxKcSXEJbU1dM0+evOhapxOw0UZakoZsT3aLmKaj2tn7IaBGkwdlvmfEaBTUDO3y79wT4zOe8CMNswQt7wr9Yp/yC6XGfDrT0oFCbs7x/nXwTwtMnZRdjyXOdqxeggQXZN4/UfmAbOMFCrEzRETl9Q=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.14,REQID:407ef545-ddde-475a-b855-5eb7395c3478,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:51,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:51
X-CID-INFO: VERSION:1.1.14,REQID:407ef545-ddde-475a-b855-5eb7395c3478,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:51,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
        elease,TS:51
X-CID-META: VersionHash:dcaaed0,CLOUDID:ce55ee16-b863-49f8-8228-cbdfeedd1fa4,B
        ulkID:221208204416QXRK23AW,BulkQuantity:0,Recheck:0,SF:38|28|17|19|48|102,
        TC:nil,Content:0,EDM:-3,IP:nil,URL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,C
        OL:0
X-UUID: b8880b1e7bf344aa9259bc4d798ceda2-20221208
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <howard-yh.hsu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 189962879; Thu, 08 Dec 2022 20:44:14 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Thu, 8 Dec 2022 20:44:13 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Thu, 8 Dec 2022 20:44:13 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kopJewaXk9ODGjl7iKWNkXTp6VwAUmMjlrm1GQJlERUjtoaoijpvw8t0joqbBVKMDMdiK0WQkmwDG9BfJYDeUfMXtbVOVmwDOoh0pQEpiIRXVc4qMTpejLacuutdlBEMGq3ledfsjX8doT/E8oeIL4EFaxT2qSfBXSFqw0zUNRmCFluQ1ekPXquNtUSX6NhSfrwgfAcVDlClAW859ouNWrXCN9nEWnsxbj3pUpJ1dXG9rqzRxhwKYT/35UjLm4QuwPeKWVYUpvB8DrXfN1UJCYLbkeae3gp6eGpusRuMux8aF3iffyHh5utO++4fP5RnCixNozC4cKcUorIQURX7TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RS9+UjMGm796BD27oqgrB1cbcGxywRf4GHt1/AjFfu8=;
 b=SL7DdWfsFxTRKD8Yl61XyrdkGjzYgCrXrBVWWYahWQZ1zj157bCqW3jWNBvgtQClpFptzXCQmqoO23lH8gBCrFShdvY6mukmjLM8MAWp5266c8mjGkunr8otAUJHGQUJh1sr7ss5Wk8Z1mCjgWhMn6M4QBBts3WYqJ2xtyK5gFey2KhTJlulyyaWZ47ZLEogf/E/+fhKt9+0R4m5/nHT29m0HU0n8HdXIsBwEX1kMgiANNZFrjFcLVXmYRy7kREfNmpXH6HBYHAKG1s/T6PzVBFw7ompD/QuJ0gLF8EfpFAZoPE+RDv5ZB2ysPBEb/xZNiiF+yLQP8MXAIzKK1+kjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RS9+UjMGm796BD27oqgrB1cbcGxywRf4GHt1/AjFfu8=;
 b=X7QEGemsmKyp3J+nWrpLzyR+U6ItOtpVeFLY4fdDczAA4AeU2f6wa3Gh+lohGRLIlopCVPQE4+mS6q6dBrrIsgxGyC/9RFvBemamQE4z5vd5AntFqmIbOSnPavxSoOLNn3Cjp1rqH7zY2Qi9gDCn5Sop9JZ/rUETSlzBCSDiItM=
Received: from TYZPR03MB5280.apcprd03.prod.outlook.com (2603:1096:400:3c::13)
 by SG2PR03MB6826.apcprd03.prod.outlook.com (2603:1096:4:1d5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Thu, 8 Dec
 2022 12:44:11 +0000
Received: from TYZPR03MB5280.apcprd03.prod.outlook.com
 ([fe80::c9dc:fa12:fdff:e22f]) by TYZPR03MB5280.apcprd03.prod.outlook.com
 ([fe80::c9dc:fa12:fdff:e22f%7]) with mapi id 15.20.5880.014; Thu, 8 Dec 2022
 12:44:11 +0000
From:   =?utf-8?B?SG93YXJkLVlIIEhzdSAo6Kix6IKy6LGqKQ==?= 
        <Howard-YH.Hsu@mediatek.com>
To:     "nicolas.cavallari@green-communications.fr" 
        <nicolas.cavallari@green-communications.fr>,
        "nbd@nbd.name" <nbd@nbd.name>
CC:     "lorenzo.bianconi@redhat.com" <lorenzo.bianconi@redhat.com>,
        =?utf-8?B?U2hheW5lIENoZW4gKOmZs+i7kuS4nik=?= 
        <Shayne.Chen@mediatek.com>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?utf-8?B?RXZlbHluIFRzYWkgKOiUoeePiumIuik=?= 
        <Evelyn.Tsai@mediatek.com>, Ryder Lee <Ryder.Lee@mediatek.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v2 1/3] wifi: mt76: mt7915: rework
 mt7915_thermal_set_cur_throttle_state()
Thread-Topic: [PATCH v2 1/3] wifi: mt76: mt7915: rework
 mt7915_thermal_set_cur_throttle_state()
Thread-Index: AQHZCfxXOdbv7eeeQ0eA50ObjfXAg65iFC0AgAHdYwA=
Date:   Thu, 8 Dec 2022 12:44:11 +0000
Message-ID: <1813da6bd8bf9448474ee0f61c23ba4d07470c55.camel@mediatek.com>
References: <20221207052500.10855-1-howard-yh.hsu@mediatek.com>
         <20221207052500.10855-2-howard-yh.hsu@mediatek.com>
         <8e8cfe60-c040-bf02-665b-a980852864aa@green-communications.fr>
In-Reply-To: <8e8cfe60-c040-bf02-665b-a980852864aa@green-communications.fr>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB5280:EE_|SG2PR03MB6826:EE_
x-ms-office365-filtering-correlation-id: fbd4febc-5862-4d90-b1ea-08dad919e7c4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7Vyi2evBsOPNKqgLtM3S9rvYkauzfGos4wb2/hd3cIZoic2zGF3hR6+rZg1qlhbH7RQ/1cZq6Q+GcBasaorVJLpsuqngBr2b5Dptw0oaEbGHVwIRUccSxE4XKW2DxMBxgP/wEGV4Cjkc6vgyMTPdPtT/Ly0x+7F15OOtUgPAXd/UanfrvS62Xg81JeVpZ23exEUoiW4BUNLzI5r3ZPVLDhHgLlzvuCKEjI2Z62CRv62Dvx7HUWapbjq85FKr17WwJJbk6tp6UIpLkbobPj04Tun+mRQTzdHXCDnAAUv2T+FR65/kV4iJu/VxjotR30/2xNqMCWIIwUWNq3Hr1NDabx2foRrgPWPg6EtCBrApozwLojTcTQTA/BqJGapRroAN+1VN6OWNrTzjteDjCREH97RElsgdKQ8xeZLEP6xZnZH4/98TxfvYndhATZLIwzttXMdgfp0TSLyhDbw4iG8O0VPLta7ofq//fe5LBwlVoAo8Gg09lw75VKpqKY0CjAqPMeJNXLdDm3X2qfCp+9RoB7hj+mYqiQpUyrXyl0y3IQQq/JTRmvMKRa+ATis9/xtaI0MlT4ZYpHQ1IchCjSwb4TU/0QS3NUNtAOXPQV5qk3vP3IeFHVZQEmdBCnMxLcxLyOWSbm2n4j6NgSy7WXR0oRNFLwFLJ5Ll2y4QY/fLx+Xqe5Xd6OQEANEYvidS5iH6iumW3c+Scizrdv7oZrmTbA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB5280.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(396003)(346002)(136003)(376002)(39860400002)(451199015)(38070700005)(85182001)(54906003)(86362001)(316002)(110136005)(71200400001)(36756003)(76116006)(5660300002)(6486002)(478600001)(41300700001)(66556008)(2906002)(66476007)(64756008)(4326008)(8676002)(66446008)(8936002)(66946007)(53546011)(6512007)(122000001)(6506007)(26005)(38100700002)(2616005)(186003)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WkZNcXVJTnhmOXNkYXlaVzNIRG12aGs0TkZJK3RvZnRWMWQ5b1JHcmdnd0lF?=
 =?utf-8?B?SUh5S0k2WDUxeVpkRjV6M0FYWUtNS0JaWkVEV3ZzTUpsS3hpV3JHUEhQSGF2?=
 =?utf-8?B?Ri9YZCtVZEt5VnpOTklYL2Q4QkkrTzNaYzZTUk9VUkZpRkdIaU9zU1lzSUFQ?=
 =?utf-8?B?WFdUN3FGRndpODJnUkVHbEN6bHpGZzJ3V2FUYTZneExicXMyUHVLN3J1MXU2?=
 =?utf-8?B?UzVvSnFqZ053RnVMekU3RUtHTjJXUXRPaTVyN3o0VHZ5b2w0TFVha3k5akZq?=
 =?utf-8?B?N2JWdHhDbzUxOTF1K1NSM1doL3hmUm5qTC92NnNJOEkrT0NLaHlMYmkxdWhr?=
 =?utf-8?B?OVc4bzYvcjBzL1R3L2piQjM5NTJmUkhMQXVwakxPUzF0R1pKYzhSUWVpbW1s?=
 =?utf-8?B?Rlg1VkxKSXBmY0NuU1NCaEtGRG84VkIwRDNuQTY3RUYwRnh4UGhmbVRJZEdN?=
 =?utf-8?B?WG9EbFdTeFhrdjRkNDcrL3J1ZmpoeEJ2OXRBdlBSNWZMNStsV09xcWRZNzdZ?=
 =?utf-8?B?VGRRWDU1VkFEa1grbVBBcCtSNGp0OFBMWmlYd3VySndyeFdXbkIvcXpYRjV2?=
 =?utf-8?B?MnNKczBzcmNBaGRRM1FXNG1JYmRJZFA1TFEwUjkyTENMekFhZE81RU9lYWZO?=
 =?utf-8?B?eWpiRmZ5cVNUN3Fqek9iSzB0TmpXVkh3RjBsVUNUbjcvSnNSMGJuTnFBZGRM?=
 =?utf-8?B?ZFltMXphdk1DVzVYaE9ZUXQvb0MydlJDQzBoWjNDWjhxRFE1ZzJmY3JuTDcv?=
 =?utf-8?B?T2xWQlRzNEx0N2ttWUprWVNRY25jZytRWFJYamg1Q2xCaUd4VFRLMzZueEM4?=
 =?utf-8?B?VUxVK0szdXZuWlRma3Vjc2ZyUUtkMXhjSDBGcW54MXBEV3JhbHVSeWgxOFR3?=
 =?utf-8?B?cmx6Qm85Y2E1b1pWWHM5T3hyZ1JmdDRVd0poTkpsR1RWMnJaM0ZyMjliUUZi?=
 =?utf-8?B?K09kK2psUVMvN2I5WmxXMDVIMTQrK0FQMTRsZWN2ZWJnQTU4ZWxWWTJCdCtK?=
 =?utf-8?B?SzFQMXBJbHMwaTNsS3U4c09wSEVaYXVpdHJVSk5IL2NFcVQwK2ZaS1I1bmxR?=
 =?utf-8?B?ODFQOXA3cElHay93Vzh5aUdSMTVVSlM2WGI3R003Y2FOcTVNNTFuNHJUWGIv?=
 =?utf-8?B?c0lKZjBhNTdPYkloMTU2Mk1IUGsxcnRtYWJiUHlySFV4VERyb3o1bnlXVERC?=
 =?utf-8?B?cTBrcHBFSENETnhIWm0zU2g5dVBkbGJkUWYyaTBweTZ2M0hyaXpjTTNuTUI3?=
 =?utf-8?B?bjEwaVY0TVJLcjc2QnJzY3IwcnRkN1g2K2NQZVZyY3M0SzF1MFlxU2x0SzBp?=
 =?utf-8?B?bE5YZlU4MW1TOFlkRnhUaXZNTnVHemZmUmh6UThPdGpyYTE3dnRrbDFWSjF5?=
 =?utf-8?B?TW80L1MrcjFNRjA2L0hqeVRFRnJRS0dEZlplcjY1QitxZ2dkZWxXajIzbHdy?=
 =?utf-8?B?dU95Skxud3hhOEZmUE01STJWcXhrSlgwVHBBUVR4QVZvUEVhTzFTQkVRcG9y?=
 =?utf-8?B?UTRqZUc1OFdwT2hKTHhJckMrMW9uYVptR2k2TzJXVDJiQ2JabTc2TnRLTENx?=
 =?utf-8?B?UitSQitHTndtdjJ6RkNuL1hyUTZBY2hWWk5GSEsrZlR5Q3djamVhZXFRc3Zl?=
 =?utf-8?B?bVFMUU9CM0Z4a0tYQXo3U0VGZDdkcmRQL1NPaDE4eEFDM1c4dW5Bd1lndUNF?=
 =?utf-8?B?bzV0OFR6Z0JxVmZZSkhJbmtjaUZtSUxzOHVZNkR4aDJ5SmlwL24rMi9sbHUv?=
 =?utf-8?B?ZzNWVkdEYUJ6eFN0M3FPR0xJaFlVd0p5MTE4QkZjYitIY3kyaTVjMlQ4Ti9a?=
 =?utf-8?B?RmswV0RJVWNxT2ozU1VnZGpXS3B1MXdPazlmMEFFMXNrRTIyOG1xbHdOL1NX?=
 =?utf-8?B?VnBXdUZ0MmVPdUR1eFU5SEhSTnN3cVZHM0QvNjZwdDhSbENLZ0QrNk1ONEVX?=
 =?utf-8?B?emtBSTZPWnhnaDlVWU5SWUQxbXZPeE93TXVURVppVktKSlBnZVNGYU9XZmEx?=
 =?utf-8?B?S05RdXpOMHRPbUJzOFhWWW1uUHJ4dlZSaUNQTEU0MHJ6K3djZXdiS0JndHNs?=
 =?utf-8?B?Qy9iSUpycTZ4SmV6ZkxtVWJOK0RTZnVpTDhYTWNzKzVMdzlaN2VFREhHcEZO?=
 =?utf-8?B?U3pzUU9GaWg4QW5XMXE5bFVYWTVqeFh2UnBsNTRtakJQTGh3MnBMaEd3RStS?=
 =?utf-8?B?c2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <914AE7D9F24A3847B5FF047FC8F0E5A6@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB5280.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbd4febc-5862-4d90-b1ea-08dad919e7c4
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Dec 2022 12:44:11.1714
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YPv1TVnte8fysQ2KFH8JhHAqNooSwpgy0AJmi0b9f8t6Q8cCkKaPUM4c6FTaMx6x5iGjiVmwAvH1WvrzPTz04WM0pSOyX2VEOhNlvHf7nig=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR03MB6826
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,RDNS_NONE,
        SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

T24gV2VkLCAyMDIyLTEyLTA3IGF0IDA5OjE1ICswMTAwLCBOaWNvbGFzIENhdmFsbGFyaSB3cm90
ZToNCj4gT24gMDcvMTIvMjAyMiAwNjoyNCwgSG93YXJkIEhzdSB3cm90ZToNCj4gPiBUaGlzIHBh
dGNoIGluY2x1ZGVzIDMgY2hhbmdlczoNCj4gPiAxLiBUaGUgbWF4aW11bSB0aHJvdHRsZSBzdGF0
ZSBjYW4gYmUgc2V0IHRvIDEwMCB0byBmaXggdGhlIHByb2JsZW0NCj4gPiB0aGF0DQo+ID4gdGhl
cm1hbF9wcm90ZWN0X2Rpc2FibGUgY2FuIG5ldmVyIGJlIHRyaWdnZXJlZC4NCj4gDQo+IFlvdSBh
cmUgbW9kaWZ5aW5nIHRoZSBjb29saW5nX2RldmljZSBwYXJ0LiAgVGhlIGNvb2xpbmdfZGV2aWNl
IGlzIA0KPiBleHBsaWNpdGx5IGNvbmZpZ3VyZWQgdG8gaGF2ZSBhIG1heCBzdGF0ZSBvZg0KPiBN
VDc5MTVfQ0RFVl9USFJPVFRMRV9NQVggDQo+ICg9OTkpLCBzbyB0aGUgdGhlcm1hbCBzdWJzeXN0
ZW0gd2lsbCBwcm9iYWJseSBwcmV2ZW50IA0KPiBtdDc5MTVfdGhlcm1hbF9zZXRfY3VyX3Rocm90
dGxlX3N0YXRlIGZyb20gYmVpbmcgY2FsbGVkIHdpdGggYQ0KPiBoaWdoZXIgDQo+IHZhbHVlLiAg
SXQgd2lsbCBhbHNvIHByb2JhYmx5IGNvbXBsYWluIGlmIGdldF9jdXJfc3RhdGUgc3RhcnRzDQo+
IHJldHVybmluZyANCj4gdmFsdWVzIGFib3ZlIE1UNzkxNV9DREVWX1RIUk9UVExFX01BWC4NCj4g
DQo+IEFuZCwgYXMgdGhlIGNvbW1lbnQgYmVsb3cgaW5kaWNhdGVzLCB0aGUgdGhlcm1hbCBzdWJz
eXN0ZW0gZXhwZWN0DQo+IHRoYXQgYSANCj4gaGlnaGVyIHN0YXRlIHByb3ZpZGUgbW9yZSBjb29s
aW5nLiAgU28gaWYgOTkgbWVhbnMgIm1heGltdW0NCj4gY29vbGluZyIsIA0KPiAxMDAgY2Fubm90
IG1lYW4gImRpc2FibGUgY29vbGluZyIuDQo+IA0KPiBBbHNvLCBsYXN0IHRpbWUgSSB0cmllZCwg
dGhlcm1hbF9wcm90ZWN0X2Rpc2FibGUgZGlkbid0IHdvcms7IEl0DQo+IGRpZG4ndCANCj4gZGlz
YWJsZSBhbnl0aGluZywgdGhlIHByZXZpb3VzIHRoZXJtYWwgdGhyb3R0bGUga2VwdCBiZWluZyBh
cHBsaWVkLiANCj4gTWF5YmUgYSBuZXcgZmlybXdhcmUgZml4ZWQgdGhpcywgYnV0IHRoZSBrZXJu
ZWwgY2Fubm90IHNpbXBseSBleHBlY3QNCj4gdGhlIA0KPiBmaXJtd2FyZSB0byBiZSB1cCB0byBk
YXRlLg0KPiANCg0KVGhhbmtzIGZvciB5b3VyIGNvbW1lbnRzLiBMZXQgbWUgZ2l2ZSB5b3UgYW4g
ZXhhbXBsZSB0byBjb25maXJtIHdpdGgNCnlvdSBpZiBJIHVuZGVyc3RhbmQgeW91ciBjb21tZW50
cyBjb3JyZWN0bHkuDQoNCjEuIFRoZSBjdXJyZW50IGNvb2xpbmcgc3RhdGUgb2YgdGhlIGNvb2xp
bmcgZGV2aWNlIGlzIDUwIChjdXJfc3RhdGUgPQ0KNTApLg0KMi4gVGhlIGNvb2xpbmcgc3RhdGUg
aXMgc2V0IHRvIDEwMCBmb3IgImRpc2FibGUgY29vbGluZyIuDQozLiBUaGUgdGhlcm1hbCBzdWJz
eXN0ZW0gZGVjaWRlcyB0byBkZWNyZWFzZSBzdGF0ZSBiZWNhdXNlIHRoZSByZXN0IG9mDQpzeXN0
ZW0gaXMgY29vbGVyLiBBbmQgdGhlbiBpdCB3aWxsIGFkanVzdCBpdCBkb3dud2FyZCBiYXNlZCBv
bg0KY3VyX3N0YXRlLCB3aGljaCBpcyAxMDAuIEZvciBleGFtcGxlLCB0aGVybWFsIHN1YnN5dGVt
IHNldCBjdXJfc3RhdGUgdG8NCjkwLiBCdXQgb2J2aW91c2x5IHRoaXMgd2lsbCBtYWtlIHRoZSBw
ZXJmb3JtYW5jZSB3b3JzZSB0aGFuIGF0IHN0ZXAgMSwNCmV2ZW4gdGhvdWdoIHRoZSBzeXN0ZW0g
aXMgY29vbGVyLiBUaGUgZGVzaWduIGZvciAxMDAgbWVhbiAiZGlzYWJsZQ0KY29vbGluZyIgd2ls
bCBtZXNzIHVwIHRoZSB0aGVybWFsIGdvdmVybm9yLg0KDQpMZXQgbWUga25vdyBpZiB0aGVyZSBp
cyBhbnkgbWlzdW5kZXJzdGFuZGluZy4gQW5kIEkgd2lsbCByZW1vdmUgdGhlDQpmaXJzdCBjaGFu
Z2Ugb2YgdGhpcyBwYXRjaC4NCg0KPiA+IDIuIFRocm90dGxlIHN0YXRlIGRvIG5vdCBuZWVkIHRv
IGJlIGRpZmZlcmVudCBmcm9tIHRoZSBwcmV2aW91cw0KPiA+IHN0YXRlLg0KPiA+IFRoaXMgd2ls
bCBtYWtlIGl0IGlzIGltcG9zc2libGUgZm9yIHVzZXJzIHRvIGp1c3QgY2hhbmdlIHRoZQ0KPiA+
IHRyaWdnZXIvcmVzdG9yZSB0ZW1wIGJ1dCBub3QgdGhlIHRocm90dGxlIHN0YXRlLg0KPiANCj4g
VGhlIHRocm90dGxlIHN0YXRlIGlzIG1vc3RseSBzZXQgYnkgdGhlIGtlcm5lbCdzIHRoZXJtYWwg
Z292ZXJub3INCj4gYW5kIA0KPiB0aGUgdXNlciBoYXMgb25seSB2ZXJ5IGxpdHRsZSBjb250cm9s
IG92ZXIgaXQuICBUaGUgdGhlcm1hbCBnb3Zlcm5vciANCj4gcnVucyBldmVyeSBYIHNlY29uZHMg
YW5kIHdpbGwgY2hhbmdlIHRoZSBzdGF0ZSBpZiBpdCB0aGlua3MgaXQgaXMNCj4gdG9vIA0KPiBs
b3cgb3IgdG9vIGhpZ2guDQo+IA0KPiBUaGUgZGVmYXVsdCBzdGVwX3dpc2UgZ292ZXJub3Igd2ls
bCBhZ2dyZXNzaXZlbHkgc2V0IGl0IHRvIHplcm8gaWYNCj4gdGhlIA0KPiBzeXN0ZW0gaXNuJ3Qg
b3ZlcmhlYXRpbmcsIGZvciBleGFtcGxlLg0KPiANCg0KSSBkb24ndCB0aGluayB0aGVyZSBpcyBh
bnkgY29uZmxpY3QgYmV0d2VlbiB5b3VyIGNvbW1lbnQgYW5kIHNlY29uZA0KY2hhbmdlLiBJZiB3
ZSBrZWVwIHRoZSBjaGVjayB0aGF0IHByZXZpb3VzIGNvb2xpbmcgc3RhdGUgc2hhbGwgYmUNCmRp
ZmZlcmVudCBmcm9tIHRoZSBuZXcgY29vbGluZyBzdGF0ZSwgdGhpcyB3aWxsIGJvdGhlciB1c2Vy
cyB3aG8gb25seQ0Kd2FudHMgdG8gY2hhbmdlIHRoZSB0ZW1wMV9jcml0IGJ1dCBub3QgdGhlIGN1
cl9zdGF0ZS4gSXQgaXMNCnVucmVhc29uYWJsZSBmb3IgdGhlIHVzZXIsIGlmIHRoZXkgd2FudHMg
dGhlIG5ldyB0ZW1wMV9jcml0IHRvIHRha2UNCmVmZmVjdCBpbiB0aGUgZmlybXdhcmUsIHRoZXkg
bXVzdCBzZXQgYSBkaWZmZXJudCBjb29saW5nIHN0YXRlLg0KDQogDQo+ID4gMy4gQWRkIGRldl9l
cnIgc28gdGhhdCBpdCBpcyBlYXNpZXIgdG8gc2VlIGludmFsaWQgc2V0dGluZyB3aGlsZQ0KPiA+
IGxvb2tpbmcgYXQgZG1lc2cuDQo+ID4gDQo+ID4gRml4ZXM6IDc3MWNkOGQ0YzM2OSAoIm10NzY6
IG10NzkxNWU6IEZpeCBkZWdyYWRlZCBwZXJmb3JtYW5jZSBhZnRlcg0KPiA+IHRlbXBvcmFyeSBv
dmVyaGVhdCIpDQo+ID4gQ28tZGV2ZWxvcGVkLWJ5OiBSeWRlciBMZWUgPHJ5ZGVyLmxlZUBtZWRp
YXRlay5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTogUnlkZXIgTGVlIDxyeWRlci5sZWVAbWVkaWF0
ZWsuY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEhvd2FyZCBIc3UgPGhvd2FyZC15aC5oc3VAbWVk
aWF0ZWsuY29tPg0KPiA+IC0tLQ0KPiA+ICAgLi4uL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2
L210NzkxNS9pbml0LmMgICB8IDE4ICsrKysrKysrKystLS0NCj4gPiAtLS0tLQ0KPiA+ICAgMSBm
aWxlIGNoYW5nZWQsIDEwIGluc2VydGlvbnMoKyksIDggZGVsZXRpb25zKC0pDQo+ID4gDQo+ID4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3OTE1L2lu
aXQuYw0KPiA+IGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc5MTUvaW5p
dC5jDQo+ID4gaW5kZXggYzgxMGMzMWZiZDZlLi5hYmVlY2YxNWYxYzggMTAwNjQ0DQo+ID4gLS0t
IGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc5MTUvaW5pdC5jDQo+ID4g
KysrIGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc5MTUvaW5pdC5jDQo+
ID4gQEAgLTEzMSwxNCArMTMxLDE3IEBAIG10NzkxNV90aGVybWFsX3NldF9jdXJfdGhyb3R0bGVf
c3RhdGUoc3RydWN0DQo+ID4gdGhlcm1hbF9jb29saW5nX2RldmljZSAqY2RldiwNCj4gPiAgIAl1
OCB0aHJvdHRsaW5nID0gTVQ3OTE1X1RIRVJNQUxfVEhST1RUTEVfTUFYIC0gc3RhdGU7DQo+ID4g
ICAJaW50IHJldDsNCj4gPiAgIA0KPiA+IC0JaWYgKHN0YXRlID4gTVQ3OTE1X0NERVZfVEhST1RU
TEVfTUFYKQ0KPiA+ICsJaWYgKHN0YXRlID4gTVQ3OTE1X1RIRVJNQUxfVEhST1RUTEVfTUFYKSB7
DQo+ID4gKwkJZGV2X2VycihwaHktPmRldi0+bXQ3Ni5kZXYsDQo+ID4gKwkJCSJwbGVhc2Ugc3Bl
Y2lmeSBhIHZhbGlkIHRocm90dGxpbmcgc3RhdGVcbiIpOw0KPiA+ICAgCQlyZXR1cm4gLUVJTlZB
TDsNCj4gPiArCX0NCj4gPiAgIA0KPiA+IC0JaWYgKHBoeS0+dGhyb3R0bGVfdGVtcFswXSA+IHBo
eS0+dGhyb3R0bGVfdGVtcFsxXSkNCj4gPiAtCQlyZXR1cm4gMDsNCj4gPiAtDQo+ID4gLQlpZiAo
c3RhdGUgPT0gcGh5LT5jZGV2X3N0YXRlKQ0KPiA+IC0JCXJldHVybiAwOw0KPiA+ICsJaWYgKHBo
eS0+dGhyb3R0bGVfdGVtcFswXSA+IHBoeS0+dGhyb3R0bGVfdGVtcFsxXSkgew0KPiA+ICsJCWRl
dl9lcnIocGh5LT5kZXYtPm10NzYuZGV2LA0KPiA+ICsJCQkidGVtcDFfY3JpdCBzaGFsbCBub3Qg
YmUgZ3JlYXRlciB0aGFuDQo+ID4gdGVtcDFfbWF4XG4iKTsNCj4gPiArCQlyZXR1cm4gLUVJTlZB
TDsNCj4gPiArCX0NCj4gPiAgIA0KPiA+ICAgCS8qDQo+ID4gICAJICogY29vbGluZ19kZXZpY2Ug
Y29udmVudGlvbjogMCA9IG5vIGNvb2xpbmcsIG1vcmUgPSBtb3JlDQo+ID4gY29vbGluZw0KPiAN
Cj4gICAgICAgICAgICAgXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXg0KPiANCg==
