Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE8D56FBDAD
	for <lists+linux-wireless@lfdr.de>; Tue,  9 May 2023 05:32:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbjEIDb3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 8 May 2023 23:31:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234437AbjEIDax (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 8 May 2023 23:30:53 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78731210A
        for <linux-wireless@vger.kernel.org>; Mon,  8 May 2023 20:30:51 -0700 (PDT)
X-UUID: e2ed944eee1911ed9cb5633481061a41-20230509
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=lX9TjDbT/sgdfrIZYFIhg0E+31mGuLufyhtoYP1vg5g=;
        b=oIvp6FIJMEAdf6flfl1srGtVDOYNHb4SWgz+G3lwWfaLSuvRfYu1hry3SBS/9BuuXEDEseXn6zlpJPqez59vfd/GIC7wSi/7cPqnq3THVSWJYmCCAx5JjcGoYRKUusQgJxMG1cQobSeVsWpra4vYev/+Zs/PQzmTzS5oSYnvky4=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.23,REQID:e154a858-dd4d-48f0-aa89-5ba8baf74198,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:697ab71,CLOUDID:0a2137c0-e32c-4c97-918d-fbb3fc224d4e,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-UUID: e2ed944eee1911ed9cb5633481061a41-20230509
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1865567160; Tue, 09 May 2023 11:30:46 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 9 May 2023 11:30:45 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 9 May 2023 11:30:45 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eU821eUI7QX9wREEvkuLjbVkhONKYC7qQQ9pSwB9zSmhg3N0CkTfjzjjt5okEOm+b/OrmhPddx63GOSF8ptlvBndGRvj/en1hWZQkr+7uZccWhFRrdZOu0RmXW76gY+PCqzZtRKbuoZbpO4+2KltvqP2sessDSsa99RZF1vZ7t10cIGo/o/IGZ4Z2QlGrL16mNpWMh9RgMha8diUZFCJF0e9SK6g7nViT2ztKsejt5bDRGQ42VXFLACM8bpFJs9lX6nLcRJNNBfWBh0Xyo5f8ogrmcSPDXng5jaOpRFlwnN7PvnhzpH0WtA7AXIuTkr3elPyfCoNCAFX3HOQjVUB5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lX9TjDbT/sgdfrIZYFIhg0E+31mGuLufyhtoYP1vg5g=;
 b=fU+rcwKMHTwB8PlVuH2PY9TM2dsfuVtu5GQ65JfTASxFZi/FvZPaI2h6ll5Z5t9RquHFqZFRKnI1tuZ2wmMeSc5ASbw5npcvCtbh4mcxUGPkgItcokTraVlSCe82aReMOJ99HvfqqWQWLy9dHCLkzVCE4mQGXPrd81Bmtb6bzMPDR47Up6/NBxdIfHu/xFXp/+oLU9b/v8trgJbXcuz5WqQSbXUtPpSwHeryO7ffnqbDXUJPniQ3Ok8kmJfYyTyScmZCbO4gaWkW6jrLu7J7FS2uYCElXvnmCGqmklXoZiICABWtQ7xXPpI2aTaCeryMwDTBgGvH7kpc7A07VXXQKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lX9TjDbT/sgdfrIZYFIhg0E+31mGuLufyhtoYP1vg5g=;
 b=BiKmnA1IwG0reIoHy2OCje+vt+NfDnuUqd/IS0HRuhRxotyRQZYZ5vLGG6ZZWbKRybZyBzS65kp4ilxpS1W+TUcQxeZB8WcAYgS5/EnW/ire9LalAbdvdxoS7gShwCpBQAWaqguyLg4EX6UW3VyfdzNt98CR3dusdyG0jmr5YhI=
Received: from SG2PR03MB6343.apcprd03.prod.outlook.com (2603:1096:4:17a::6) by
 PUZPR03MB6909.apcprd03.prod.outlook.com (2603:1096:301:ff::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6363.32; Tue, 9 May 2023 03:30:41 +0000
Received: from SG2PR03MB6343.apcprd03.prod.outlook.com
 ([fe80::6384:b7d8:4b3:ce4b]) by SG2PR03MB6343.apcprd03.prod.outlook.com
 ([fe80::6384:b7d8:4b3:ce4b%5]) with mapi id 15.20.6363.033; Tue, 9 May 2023
 03:30:40 +0000
From:   Ryder Lee <Ryder.Lee@mediatek.com>
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "nbd@nbd.name" <nbd@nbd.name>
CC:     "lorenzo.bianconi@redhat.com" <lorenzo.bianconi@redhat.com>,
        =?utf-8?B?U2hheW5lIENoZW4gKOmZs+i7kuS4nik=?= 
        <Shayne.Chen@mediatek.com>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?utf-8?B?RXZlbHluIFRzYWkgKOiUoeePiumIuik=?= 
        <Evelyn.Tsai@mediatek.com>,
        =?utf-8?B?Q2h1aS1oYW8gQ2hpdSAo6YKx5Z6C5rWpKQ==?= 
        <Chui-hao.Chiu@mediatek.com>
Subject: Re: [PATCH 5] wifi: mt76: mt7915: report tx retries/failed counts for
 non-WED path
Thread-Topic: [PATCH 5] wifi: mt76: mt7915: report tx retries/failed counts
 for non-WED path
Thread-Index: AQHZgiQHyxO2itqYfk6M8ZdJzITICK9RSPkA
Date:   Tue, 9 May 2023 03:30:40 +0000
Message-ID: <29a970276ebd7f525ff026464a78672c174d2ace.camel@mediatek.com>
References: <5cc3ad59270940a3c4229a4c780e106b1b0fe53c.1683587774.git.ryder.lee@mediatek.com>
         <3310ca7b17946743fefba41698b64bf0aba318a3.1683586271.git.ryder.lee@mediatek.com>
In-Reply-To: <3310ca7b17946743fefba41698b64bf0aba318a3.1683586271.git.ryder.lee@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SG2PR03MB6343:EE_|PUZPR03MB6909:EE_
x-ms-office365-filtering-correlation-id: 16cd9bbb-d86d-4390-6b5f-08db503dc394
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hPsHEOeZE+nahcDn6cubfg2ucw4FIiiZdWWys2uAK4WoT2jKOfVCayYPB4I6x69FEi2dMKemlqVOQFSGn8LSbo0Nkmk0rxmytOmrJdAi2gmLEG/VmlRaMpZhCQuqPS2oIfo/YCRyC90gFC94mo+mYbpbctRSmyncvbKMp4rQ3W6GduTeW/hBWHZstJyiPrJFWfpMFJ5dMQBYG/wWCMZbP+jidwCrUeekKRnfA/hKFC+K9YUqNl/bXFAIJE+10d4yYtLeATeqzeKVaIz94/vlxXSUCPI0MjXgaM/eXsztdHttK3QS+tbBiDTdxEaDi5HgM9Kw6yFrGOiZfZB7agCbfuFRuAPom7sGX+AUkZNyyFvdGiNa0R1XpBApHf88F1p4OejhTEj7YLTVyUJd7jmIDfFbuh8Zqyr+OhbPyT26EMh9j7q1K0WLbJE+SHNXJ7lU1sYYYfPuaFqmO/Sgb4bd3XPQsfZ5023LpUwX76Hh7Ty64PqGbjCRwVwczRGIxq5OQvEWd1yA258aUdJCfRFZBcHuoK1GsTyUw3yG+2F0vvrW+DHJnIezU5TRWg2ftVykRosdnGMc7z9Q/R5OVqvTFLxSSpvtzZlcx5Og+H/9+oNWCvLaXdDLCQQ8hzobDANdI338EwGA3gdMUpQxp++kVGYTsHNuYzDAJ5hu3dDXi2I=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR03MB6343.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(346002)(396003)(376002)(136003)(451199021)(86362001)(66446008)(36756003)(316002)(91956017)(54906003)(4326008)(66556008)(66476007)(64756008)(478600001)(66946007)(76116006)(110136005)(6486002)(8936002)(4744005)(8676002)(5660300002)(41300700001)(2906002)(71200400001)(38070700005)(186003)(122000001)(38100700002)(107886003)(26005)(6506007)(6512007)(2616005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T1FxbGlrWWIzWk1NT1ZkNWY0RFhMbCt4TXFYZjlIb3psQlEyWmdXTjJEbHBt?=
 =?utf-8?B?TE5INGJFdWNrVFFSeUQyOG5PRjRRb2k3aVVGZ1ZMS3I3SUhZbXArZHVzNTVj?=
 =?utf-8?B?N1FySGJvVjRyZUpwdUl0dFJPNzNmWWF1RGo0d2Faam1XM0psc2dIcElWVThO?=
 =?utf-8?B?KzFpWnp2QU9oZStML0JuODIwanZ0UjFPcEY0SEhHNE5Cb1hzYUZ5QmZ3WDhl?=
 =?utf-8?B?akJteW1nS3lpV1IrdytxUGZBV0VMNUFpRlhXOXY2dDlvc1FnY0NyWjlCR0JZ?=
 =?utf-8?B?S3Z0amxYdlVmQU4yc3hpRDljTFFVUkdVUjhIR2liT09wYmNvbGZvYlA0MVk5?=
 =?utf-8?B?bEUrQkVjNlMyRXIydk50ZzEwUUUvcWNFNzRoc0NrWGI2UEhHK3MydGJRSTY1?=
 =?utf-8?B?Sm9CVnowWGJsRzN1c3NXMTBpYXJzZ0NmNmRyUU52ZlNHRXRmenhQTTBFYmdT?=
 =?utf-8?B?SmtZQWF2MFlWMkVVd2Jnd3dCM0phV28vVHdmUEVaejNmTnRZSlQ5N2tUM3B6?=
 =?utf-8?B?Z1dUbXlHTVhDNVJJdWpqSzViZ0FIWkRMK1Byd1I0UnhTQmdROHNNZjBHYk9C?=
 =?utf-8?B?dmVQUmt5MlZwbDhvYjBCUmlxT2E4Tklnd0lDV3gwNFVOdFhPZXB1SThlTlU4?=
 =?utf-8?B?enVpNDMrd0Y5cExCVGJkUU1MMUpkbGhPelVYUmVLRnlZSCtaSVk3aXF4Y282?=
 =?utf-8?B?ejRWTEFHZjRnWDMrYWY4eHc1TVBlMVRWTXNiall5Tno5WmZ3bEJaRjFDMnpt?=
 =?utf-8?B?c1huUGlDWWsxemUzd0Nwb0xLaWVjcG9lTG0vbVU2YWFwbS81R1NpbkdxL21j?=
 =?utf-8?B?MDF1K3BYdHRpYUJ0UklxSFcvWTA2cm95bTRjYm50eHpGTjZ1dmhUbTV3UFcw?=
 =?utf-8?B?OVVEbHBVZXZvL1lMbU51aUFISS85ZFVMT3Y4ZytFWWZnTitMTU9TVElJMENB?=
 =?utf-8?B?cThaY2JTYnhjUVpzR08zcGduRU9kbWp2b3N4aGIvVHpRTDhIT3ZTVkhKVzI2?=
 =?utf-8?B?RGtDcTFWL3VueTNqRzZadzRwUjlhcWxpMFhkNUlSMzVQMUt5VVNuckZnemNh?=
 =?utf-8?B?anlWWjZoMTAxNWY1QkVlQVZmZGdpM0lSM2pYTEk4ekcvVTN1ZTk3WVdmV1ZQ?=
 =?utf-8?B?OUhYN3ZXVVFDczh4Qnh0MVZPMmlpZEc2VCs0ak9jdUErbFdiVkdOcGx6WHc3?=
 =?utf-8?B?SVVLWXY5WVNKS1U2NjhXd0l1cUdqc1ovUG5xb3FLV2x6ZEtNODRGSlBSNVlk?=
 =?utf-8?B?U1BFTlhDVUlvalYrQnNLK2dJL2EzMlVTc2ovVGsyUTQwK0hTa1Z0TThkZnpC?=
 =?utf-8?B?TktjZU5aZHFoME1FR1hvUlE0d2RpdWY3djlZbzZSdlNFZmFQQ0t2dmxlSWVB?=
 =?utf-8?B?SGdlVEpJQ2tlNEQ3aWk0cjhSYU0xeW5OL0RhQWxjdEhXeTNWVVlTamtGU2k3?=
 =?utf-8?B?ZlFDTXliWldaVHZhSUNmd3hsbURHdEhPeXlTWnh0b25Gc3F4UzQvdHJVb1BJ?=
 =?utf-8?B?Q2JSc2Erb2MxVHdSUEZHcjIrcXduSTI5b0Z1dUVSSk1ab1RtejIzWEM3TWd0?=
 =?utf-8?B?eU56U3piNGY5N20veG1LU0lXbFYyQW9jNjAyQmtVNWpIekE2MFF5UXJYS0Ft?=
 =?utf-8?B?aEtQK2M5NjZoQnp1a2MvTFJHbVJ4WXBDZnh4QXU1QVN5Qzl0MDBLZkF1akpj?=
 =?utf-8?B?bEZBME5LVi9hTVdLU2FxQ3dEOVhzbU5VRC83UHpXVllvMHQwUlByZ0pPeW1x?=
 =?utf-8?B?ZWFsSTl5SnpjWEVKbktoK09xOHRNR1VHeXNIZmpQSU9rK0hXc0ZmeXJqWHFG?=
 =?utf-8?B?ODJQUHRqV3NVaTBDWTA3d01mdm5VRDQ1N2lCWklDdzI1aXdDaWsxcDFyb2ds?=
 =?utf-8?B?dkZhdkFIOG9BRS83QlJKUmFDVXNTdFpzRWs3OTRTeExYQWFSN1phVnBacVk4?=
 =?utf-8?B?WHp2R0JFd090enJHUTlKQ3pQRGt5ZnNrT0t6alBiRHF5eUNCbVJneG1OSmNk?=
 =?utf-8?B?QllUQzN5ZzQxSk04L0tnUHRkMVFtUEFGMGFpMnlVakh2K2RhOWh0bEdCQzA4?=
 =?utf-8?B?RVk2MEYyOFBiMnd3ekJ2YlRDakgxRWZTclQ0TFFXUTdDSXVUcmtYV1R4SHNy?=
 =?utf-8?B?MDVXdlpjbHN3ZXBPWkNjeWJiaG1DNlI3ajZlbUN0SWRkczVDZ3l0ajdRVHdP?=
 =?utf-8?B?aFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <838CDDE1A60BF048893ECEB1EE3B44E8@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SG2PR03MB6343.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16cd9bbb-d86d-4390-6b5f-08db503dc394
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2023 03:30:40.7206
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CDySuwFSQPO90fV3bLE3enWMHh2QQ1wNjku0RQfnoVBydbyAWOgOT+7jckocKyZr0PcsNgmCaBZr5s0Ok/Fo+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR03MB6909
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

T24gVHVlLCAyMDIzLTA1LTA5IGF0IDExOjExICswODAwLCBSeWRlciBMZWUgd3JvdGU6DQo+IEdl
dCBtaXNzaW5nIHR4IHJldHJpZXMvZmFpbGVkIGNvdW50cyBmcm9tIHR4ZnJlZSBkb25lIGV2ZW50
cyBhbmQNCj4gcmVwb3J0DQo+IHRoZW0gdmlhIG10NzkxNV9zdGFfc3RhdGlzdGljcygpLg0KPiAN
Cj4gQ28tZGV2ZWxvcGVkLWJ5OiBQZXRlciBDaGl1IDxjaHVpLWhhby5jaGl1QG1lZGlhdGVrLmNv
bT4NCj4gU2lnbmVkLW9mZi1ieTogUGV0ZXIgQ2hpdSA8Y2h1aS1oYW8uY2hpdUBtZWRpYXRlay5j
b20+DQo+IFNpZ25lZC1vZmYtYnk6IFJ5ZGVyIExlZSA8cnlkZXIubGVlQG1lZGlhdGVrLmNvbT4N
Cj4gLS0tDQo+IA0KDQpQbGVhc2UgaWdub3JlIHRoaXMgcGF0Y2guIEkndmUgc2VudCBhIG5ldyBv
bmUuDQoNClJ5ZGVyDQo=
