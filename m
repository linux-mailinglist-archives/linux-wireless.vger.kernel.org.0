Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F0586EDEC6
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Apr 2023 11:09:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233081AbjDYJJs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 25 Apr 2023 05:09:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233391AbjDYJJm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 25 Apr 2023 05:09:42 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5097C185
        for <linux-wireless@vger.kernel.org>; Tue, 25 Apr 2023 02:09:35 -0700 (PDT)
X-UUID: e30ed572e34811edb6b9f13eb10bd0fe-20230425
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=GmwktDlo1mK0K2KXBh4CLzFR93V1Yayxudsergab6ko=;
        b=OOd+gsp4PJFbG9PTw8WmpuINNiDeGJeXNRZPEQXqPel/eytfo5ennEVkXFdeeFPLGVV1VVzUT5C611/7Pl/luF2FV1mR4/B6PUJmv6rP4vmvJelU0zl1FkXU15zOsOHP2xFBN9Svi+9R0opMMK60n9w5ZEj+5UeeKyK0wCj05E4=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.22,REQID:7d28c7b3-3124-4a84-9428-49a19503d83b,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:120426c,CLOUDID:319d13ec-db6f-41fe-8b83-13fe7ed1ef52,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-UUID: e30ed572e34811edb6b9f13eb10bd0fe-20230425
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw02.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 980677929; Tue, 25 Apr 2023 17:09:30 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Tue, 25 Apr 2023 17:09:29 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.25 via Frontend Transport; Tue, 25 Apr 2023 17:09:29 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uo0/sf/mpFqN05KcfI15okgjQBIEtRVR/ivb905/CBEhmZJo6lLMS4ik+dFwu764sAdbJyh54U2y5hhLnC3T6DB/jEtQYvqoP+LtYb+hQHZR7QC3wXFWZI2PemWCGpUpjCsDOgoQCRs2Dr4okOTz5oDdY9NyMtpApKBePF4h5pUciOYyAm0tJjGaidLUQhQG1DS2vV0yCOWJBFQES3b2w5tO8qkv5dhSIX3uMdaWmuUB8RimMI4Lyqi7/loTV5NRYZIn8y3cgkak9WWCwy6BisGWbT17krPzE46sPwJC3m8XCcDieD2fU8d/JJGG/G5wkMmp3nKyRgLBNkFFg8fhEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GmwktDlo1mK0K2KXBh4CLzFR93V1Yayxudsergab6ko=;
 b=ikk1u5UK3364zxnzP3EPoYruFMMKxvadW/MMlYBAnSh4k+jpUz7cRfwj/sKxTLyo4ajY40N8g5ZL4BT2lUyH8K5+GQ0e2Wo12OAgbyImniurO/zl5PEEPAQfetTkuz2KJHHE5hJDGZ9yXAs8d+8NE7cFaGyooH/IVPaI/5CWYwiMWhQ0KuZqfkmV4jOoE+DqZezmA6YzZenbCkiclNHWtXIcY9RokLwDvNPVZvdRjwyDJgRqswbjkqB238NYRa8dpEIqCmse47nub7gpdw2sfwtSUhpgbiaG87HfKFau4ykaJ/c7RM61TWiYYm/fRuHZHPYvXSicm9HtzDC5/jVaPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GmwktDlo1mK0K2KXBh4CLzFR93V1Yayxudsergab6ko=;
 b=XODA1N+tgQ3n6tvVEClR6SU0pbihc/3c4+iloW6/uL7rnPGvCnUhJRitgHMekhxKRNKCgpGI7gmLCTY/qpG1gx84wmgDH2CXOtVDrEIdcvwBujPDILdPYmGkXmJrdKj1aUXUhQJeAw/zzPI/DNL14EZBh6pPFztj9jGENM6A/3E=
Received: from TY0PR03MB6354.apcprd03.prod.outlook.com (2603:1096:400:14a::9)
 by KL1PR0302MB5426.apcprd03.prod.outlook.com (2603:1096:820:46::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.34; Tue, 25 Apr
 2023 09:00:52 +0000
Received: from TY0PR03MB6354.apcprd03.prod.outlook.com
 ([fe80::d6f0:880d:41c4:8086]) by TY0PR03MB6354.apcprd03.prod.outlook.com
 ([fe80::d6f0:880d:41c4:8086%3]) with mapi id 15.20.6319.033; Tue, 25 Apr 2023
 09:00:52 +0000
From:   Ryder Lee <Ryder.Lee@mediatek.com>
To:     "lorenzo.bianconi@redhat.com" <lorenzo.bianconi@redhat.com>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        =?utf-8?B?U2hheW5lIENoZW4gKOmZs+i7kuS4nik=?= 
        <Shayne.Chen@mediatek.com>, "nbd@nbd.name" <nbd@nbd.name>,
        =?utf-8?B?RXZlbHluIFRzYWkgKOiUoeePiumIuik=?= 
        <Evelyn.Tsai@mediatek.com>,
        =?utf-8?B?Q2h1aS1oYW8gQ2hpdSAo6YKx5Z6C5rWpKQ==?= 
        <Chui-hao.Chiu@mediatek.com>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH 1/2] wifi: mt76: mt7915: rework tx bytes/packets when WED
 is active
Thread-Topic: [PATCH 1/2] wifi: mt76: mt7915: rework tx bytes/packets when WED
 is active
Thread-Index: AQHZd1E/IqIoGQZaBUSYrd5WE73rd687twyAgAADMQA=
Date:   Tue, 25 Apr 2023 09:00:52 +0000
Message-ID: <00f1427faabd54d260aca8d083c1dd4e190d4c75.camel@mediatek.com>
References: <d9466e4641a7db661058896f4ccd4bba4a9cdb3b.1682411744.git.ryder.lee@mediatek.com>
         <ZEeUF8T8gmjGIk5e@lore-desk>
In-Reply-To: <ZEeUF8T8gmjGIk5e@lore-desk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY0PR03MB6354:EE_|KL1PR0302MB5426:EE_
x-ms-office365-filtering-correlation-id: 26312b39-25fc-460a-773a-08db456b92ab
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Av7VJm0881vONCkEcZPrJIG9BfvRY8OghS56jYfvnM+X2HwRBOQ/SIJ63m7Fnv78tguQwA1lHgdUWR8jfUP/mEA9ZdTQaqk5Ts8NCE47U7+smK3lkjd0lnI7O5HchtDSkwx4A6RbwZhNisgA0qsDoaWVjKILAwusY5QIBpx4wGZDSSCMIoS+yTFYHiMp8O2cGvcXvwpbdzHUX8zpD7p6lm5ZYvw+MmjrB9xmjvzElQo2z870lPAKNUSypkHmq2X3mTbU3/jlZGhIRacMbRfSALZnR+bVgjiNzELkKo5a8EEAMNKgVeSdxY8EIrSGZttWnFmUB30N22QRdUf+Q3ua6wKGtdeHZL69hmxCOQCLjQP8xuQXEZJsXvj94waKVqfMNH4wqKwC5zzYIQ1G7y5Zclb09DrsDS0CNrEgE/zl+8v6sA4AOTJiz3+aF5bbgMMl6yRytNU1heSLzdOWPF+47x+7EcXHoxY0Qymtuw1VmZRNu3Hu6r/RUWfVJ9yeL+qLPMQ9zG4nrHwJZEZayvrwmWd9L/Tfk3IEzE9P2l1fSSCCAzlVV06jBuBfNVwj9CGyijtPVt77yErVQ1x7iTi3cvRTu8WRkw7hk8hFRmRZwgZjGE7izuLJRf7cbpb+27WG
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY0PR03MB6354.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(376002)(136003)(346002)(39860400002)(451199021)(2906002)(86362001)(26005)(186003)(6506007)(6512007)(83380400001)(66556008)(36756003)(478600001)(66446008)(66476007)(66946007)(76116006)(64756008)(6486002)(71200400001)(54906003)(38100700002)(2616005)(122000001)(41300700001)(316002)(4326008)(6916009)(5660300002)(8676002)(8936002)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VCt4K1R1QXZqaTVKZ3pIYWQ3T0c0b2pEQVZLR1hIdkUwNjNIVnllY1UwemJL?=
 =?utf-8?B?a3dVS2V0a0dJZ3U1QUV6dTNWOS9JUWhpQkd6REZYWi80UlFrSjhvSlRRZWE0?=
 =?utf-8?B?aEhYNTVnYkRiaDJIbU41SllLNEpQcEFmZ3o1RXhQQjMremNJaFQrVFhiN3Y5?=
 =?utf-8?B?VjFmdlNueVVveDJJcmdlekxLODRJVnhOaWNiaHpHU045QU11S0VNSi85b2FP?=
 =?utf-8?B?Mm5HT0pIc2p1UVdjZU1mMFRKdEdmL2U0bmh0dmR5SlZKNythZlhQVXlFUnJK?=
 =?utf-8?B?UU5iT2NXUU5kV3dvbXFyMW11dm1DNG96MWVvbzVNNFgvb1dRRG1ubUJleTM3?=
 =?utf-8?B?VzE0SzQ0SGFDZHlsbjZBNGQrd0ZmaEdDdVkxdFIrQ2NLMWhsY3VZRDlJS0lD?=
 =?utf-8?B?dm9XYjRqcC9xR2tiaXNVZFZmbTM3WUowcUJ3SDlCU3J0WXBjVGFUeFgzamJ3?=
 =?utf-8?B?L0E5RTlhMG5PcFJVUmQxZGZkM2I0Y21uOW12MXRvWUFTcHBUZ0krbzlrSFd6?=
 =?utf-8?B?dk1hTzQwb3MyUnlIQitaUjM0OWM0QzI0SXhUZWVaRlVzM0pwQWVSSzIzN1Zv?=
 =?utf-8?B?UUZld0NtZ01yRmREQWNzek5QbllrNzlmL3ljU2U4dzcvVm9HZjBNeXhVaHBi?=
 =?utf-8?B?cC81c3hYNXkxZkMvNCt2enVpRTk5VWVSRGhUTEdYeGxYT1E0bU41YndTT1o0?=
 =?utf-8?B?ZXk2VHhEZEpMcDZlc2xOYkx0VkhJOTJ3dTlBMkp2YXlabCtINTFETndTeDBZ?=
 =?utf-8?B?NEZTcE5LSmZCcDl5eHYvdzR2c3ZJd0dDbWRRQW9zUVkxd3NnVkVlODBwRzBW?=
 =?utf-8?B?SHhIUlBuMVdmT1o0ZHY2eXM4RlhzeHFodEdDRzhPbFR4SmF0UXZLSjNhd3R5?=
 =?utf-8?B?aGhiejdMQkdQdU92MVFsdHR5QTAza1FQbFN5dENGTTUybnk0bDN4Sks1NXNV?=
 =?utf-8?B?R0Z5WlRHS0RhZHNRRXd0bHRhaHNGVUt4cytoOVBicDlkSGtFR29vbzRRRm9T?=
 =?utf-8?B?UEMvMGw1Mm40SW5sQnhLR2gwemFXTFdhUU96NWJPaVgwK25lNHFJZHQwQ2lu?=
 =?utf-8?B?bTdTM2lEOGlQL0ovVk9qcU1wRVBhUG5VWTBoR2ViVjVQakhYVUREeEZvbjRM?=
 =?utf-8?B?Qlp3UVBHSmpHUnA5YkR4VW1QekttbFJjb00vOVpEVXZEZGlDRi9pOUI5TDl0?=
 =?utf-8?B?NHBoMWRoWVJ4UWVVcWo3RHl6d0pQMHNRcXRzSm1FTlVHZnJQNnB5R3Q0bDNi?=
 =?utf-8?B?alA1U3M5b2J4U0FlbmN1bmVFdjFXSit0UktjYW5mNWZDQm84NW5KT3RjZm1M?=
 =?utf-8?B?QmFYdjFiY0JDbllqSlRqcVpyN09uaXBCMjdFUXF5cGt5bUxRQnNSUVZreTM2?=
 =?utf-8?B?eFlyTHUwZzZTOEtMOUsrdDhoaFd2VXE4c2FUZnFpdGtkdE9XZC9MOXRTYUxt?=
 =?utf-8?B?TXBKeDhTbThnM1p2elRramZCc243cExXeStFSzZIZGk5NmtPY243QmJHSTFR?=
 =?utf-8?B?ZTZoYXZhRUUzVW5jeSs3ZHJPc0xJeTJTYkx5dmtMVjc4RmFqSkRPcnVMYjZJ?=
 =?utf-8?B?bUpHSm1aZ0lNWERYMzhWdTNEUnlyZzBZUTM3TiswTjNxU3B6bjBlMDcrUktM?=
 =?utf-8?B?RmltVVkyMHNybGxhSmNCT3k5YUp5WktuYVFidVRyNThqV20xVHUwNlZKZVZD?=
 =?utf-8?B?VWZPZ0Y3SzVLcTlDVFBwTHJ3aG55WXE2SFg1YkxsalVid0lpdXZVdzJWN1Az?=
 =?utf-8?B?U2RxUXRVQ3pqaS9MS1Job2QzR084WUxnVHh4RW1hRE9Ed1UrV3h3UVh4UUdX?=
 =?utf-8?B?Q3N3R2hTaTBzOHF6ZDRYQ0F3VjlzdmZ1YTRSaFVPNGpUWGcrVGpvRHpnUTF5?=
 =?utf-8?B?MUNHUjh4eTBic2lvaERTTHcweUdzQUtqdkx4Mnczc1VpWDd1WmE3TU53OG5X?=
 =?utf-8?B?WUEzc25iMi9va09yTUtqeVB5R0YyZ3NvWW9CeVdLOWdydWdSaUREUzFlMmRv?=
 =?utf-8?B?cmVMNmRlMXIyYTZyNm9udTZjZzVsOWtiVnhXZGJBVExQd0dlZjNVWGlmZGo1?=
 =?utf-8?B?aFYxWkw0TkhWQzQ5ZWorVDU5bEEyMmpCUWx4eHpmaGdjSHRWRC9CYXlhaFVV?=
 =?utf-8?B?MHZnUzZQNWJwZitQRXY1Rkd3NjA5ZlpGMlRjSUVMYlBDc3A2TG50SmJkd01T?=
 =?utf-8?B?Q2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7C95AE1DC4A0434D916E66EEEC85FF7E@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY0PR03MB6354.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26312b39-25fc-460a-773a-08db456b92ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2023 09:00:52.7380
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9B8cyQfnjtOQZNaALDHlWNupyIeBibXAqCyo9gyq6ZvUmkwlQQdK6l41sMpRGyxzGaj+dlVzmlrtC39ErU5liQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0302MB5426
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

T24gVHVlLCAyMDIzLTA0LTI1IGF0IDEwOjQ5ICswMjAwLCBMb3JlbnpvIEJpYW5jb25pIHdyb3Rl
Og0KPiA+IEZyb206IFBldGVyIENoaXUgPGNodWktaGFvLmNoaXVAbWVkaWF0ZWsuY29tPg0KPiA+
IA0KPiA+IDEuIE1peGVkIHR4X2J5dGUgY2FsY3VsYXRpb24gLSBuZWVkIHRvIGhhbmRsZSBib3Ro
IChub24pYmluZGluZw0KPiA+IHBhY2tldHMNCj4gPiAgICB3aGVuIFdFRCBpcyBlbmFibGVkLg0K
PiA+IDIuIFBQRFUgYmFzZWQgVHhTIGNhbiBvbmx5IHJlcG9ydHMgTVBEVSBjb3VudHMgd2hlcmVh
cyBtYWM4MDIxMQ0KPiA+IHJlcXVpcmVzDQo+ID4gICAgTVNEVSB1bml0KE5MODAyMTFfU1RBX0lO
Rk9fVFhfUEFDS0VUUykuDQo+ID4gDQo+ID4gVG8gc29sdmUgYWJvdmUgaXNzdWVzIC0gc3dpdGNo
IHRvIHVzZSBUeFMgcmVwb3J0aW5nIGZvciBhbGwgdHhfYnl0ZQ0KPiA+IHdoZW4NCj4gPiBXRUQg
aXMgYWN0aXZlIGFuZCBnZXQgTVNEVSBUeCBjb3VudHMgZnJvbSBXQSBzdGF0aXN0aWMuDQo+IA0K
PiBJdCBzZWVtcyB0byBtZSB3ZSBhcmUgZG9pbmluZyBtdWx0aXBsZSBsb2dpYyB0YXNrcyBpbiB0
aGlzIHBhdGNoLiBDYW4NCj4geW91DQo+IHBsZWFzZSBzcGxpdCB0aGVtIG9uIG11bHRpcGxlIHBh
dGNoZXM/DQo+IA0KDQpPSy4NCj4gPiANCj4gPiBOb3RlIHRoYXQgbXQ3OTE1IFdBIGZpcm13YXJl
IG9ubHkgY291bnRzIHR4X3BhY2tldCBmb3IgV0VEIHBhdGgsIHNvDQo+ID4gZHJpdmVyIG5lZWRz
IHRvIHRha2UgY2FyZSBvZiBob3N0IHBhdGguDQo+ID4gDQo+ID4gRml4ZXM6IDQzZWFhMzY4OTUw
NyAoIndpZmk6IG10NzY6IGFkZCBQUERVIGJhc2VkIFR4UyBzdXBwb3J0IGZvcg0KPiA+IFdFRCBk
ZXZpY2UiKQ0KPiA+IENvLWRldmVsb3BlZC1ieTogUnlkZXIgTGVlIDxyeWRlci5sZWVAbWVkaWF0
ZWsuY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFJ5ZGVyIExlZSA8cnlkZXIubGVlQG1lZGlhdGVr
LmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBQZXRlciBDaGl1IDxjaHVpLWhhby5jaGl1QG1lZGlh
dGVrLmNvbT4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3
Ni9tdDc2LmggICAgIHwgIDIgKy0NCj4gPiAgLi4uL3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3
Nl9jb25uYWNfbWFjLmMgIHwgIDggKy0NCj4gPiAgLi4uL3dpcmVsZXNzL21lZGlhdGVrL210NzYv
bXQ3Nl9jb25uYWNfbWN1LmggIHwgIDEgKw0KPiA+ICAuLi4vbmV0L3dpcmVsZXNzL21lZGlhdGVr
L210NzYvbXQ3OTE1L2luaXQuYyAgfCAgNiArKw0KPiA+ICAuLi4vbmV0L3dpcmVsZXNzL21lZGlh
dGVrL210NzYvbXQ3OTE1L21haW4uYyAgfCAgNiArLQ0KPiA+ICAuLi4vbmV0L3dpcmVsZXNzL21l
ZGlhdGVrL210NzYvbXQ3OTE1L21jdS5jICAgfCA3NA0KPiA+ICsrKysrKysrKysrKysrKysrLS0N
Cj4gPiAgLi4uL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzkxNS9tbWlvLmMgIHwgMzAg
Ky0tLS0tLS0NCj4gPiAgLi4uL3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3OTE1L210NzkxNS5o
ICAgIHwgIDEgKw0KPiA+ICBkcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L3R4LmMg
ICAgICAgfCAgNiArKw0KPiA+ICA5IGZpbGVzIGNoYW5nZWQsIDkxIGluc2VydGlvbnMoKyksIDQz
IGRlbGV0aW9ucygtKQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC93aXJlbGVz
cy9tZWRpYXRlay9tdDc2L210NzYuaA0KPiA+IGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0
ZWsvbXQ3Ni9tdDc2LmgNCj4gPiBpbmRleCA2YjA3YjhmYWZlYzIuLjBlOWY0MTk3MjEzYSAxMDA2
NDQNCj4gPiAtLS0gYS9kcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzYuaA0K
PiA+ICsrKyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3Ni5oDQo+ID4g
QEAgLTI3Nyw3ICsyNzcsNyBAQCBzdHJ1Y3QgbXQ3Nl9zdGFfc3RhdHMgew0KPiA+ICAJdTY0IHR4
X21jc1sxNl07CQkvKiBtY3MgaWR4ICovDQo+ID4gIAl1NjQgdHhfYnl0ZXM7DQo+ID4gIAkvKiBX
RUQgVFggKi8NCj4gPiAtCXUzMiB0eF9wYWNrZXRzOw0KPiA+ICsJdTMyIHR4X3BhY2tldHM7CQkv
KiB1bml0OiBNU0RVICovDQo+ID4gIAl1MzIgdHhfcmV0cmllczsNCj4gPiAgCXUzMiB0eF9mYWls
ZWQ7DQo+ID4gIAkvKiBXRUQgUlggKi8NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvd2ly
ZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc2X2Nvbm5hY19tYWMuYw0KPiA+IGIvZHJpdmVycy9uZXQv
d2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc2X2Nvbm5hY19tYWMuYw0KPiA+IGluZGV4IGQzOWEz
Y2M1ZTM4MS4uODQ5ODVhOTg5MjkzIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvbmV0L3dpcmVs
ZXNzL21lZGlhdGVrL210NzYvbXQ3Nl9jb25uYWNfbWFjLmMNCj4gPiArKysgYi9kcml2ZXJzL25l
dC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzZfY29ubmFjX21hYy5jDQo+ID4gQEAgLTUyMSw5
ICs1MjEsOSBAQCB2b2lkIG10NzZfY29ubmFjMl9tYWNfd3JpdGVfdHh3aShzdHJ1Y3QNCj4gPiBt
dDc2X2RldiAqZGV2LCBfX2xlMzIgKnR4d2ksDQo+ID4gIAkJcV9pZHggPSB3bW1faWR4ICogTVQ3
Nl9DT05OQUNfTUFYX1dNTV9TRVRTICsNCj4gPiAgCQkJbXQ3Nl9jb25uYWNfbG1hY19tYXBwaW5n
KHNrYl9nZXRfcXVldWVfbWFwcGluZygNCj4gPiBza2IpKTsNCj4gPiAgDQo+ID4gLQkJLyogY291
bnRpbmcgbm9uLW9mZmxvYWRpbmcgc2ticyAqLw0KPiA+IC0JCXdjaWQtPnN0YXRzLnR4X2J5dGVz
ICs9IHNrYi0+bGVuOw0KPiA+IC0JCXdjaWQtPnN0YXRzLnR4X3BhY2tldHMrKzsNCj4gPiArCQkv
KiBtdDc5MTUgV0Egb25seSBjb3VudHMgV0VEIHBhdGggKi8NCj4gPiArCQlpZiAobXRrX3dlZF9k
ZXZpY2VfYWN0aXZlKCZkZXYtPm1taW8ud2VkKSAmJg0KPiA+IGlzX210NzkxNShkZXYpKQ0KPiA+
ICsJCQl3Y2lkLT5zdGF0cy50eF9wYWNrZXRzKys7DQo+IA0KPiBJIHRoaW5rIHRoaXMgd2lsbCBj
cmFzaCBtdDc5MjEgdXNiL3NkaW8gZHJpdmVycy4gSXQgaXMgZW5vdWdoIHRvIHN3YXANCj4gdGhl
IGNvbmRpdGlvbnMgc2luY2UgbXQ3OTE1IHN1cHBvcnRzIG1taW8gb25seSBtb2RlLg0KPiANCg0K
T0suDQo+ID4gIAl9DQo+ID4gIA0KPiA+ICAJdmFsID0gRklFTERfUFJFUChNVF9UWEQwX1RYX0JZ
VEVTLCBza2ItPmxlbiArIHN6X3R4ZCkgfA0KPiA+IEBAIC02MTAsOCArNjEwLDYgQEAgYm9vbCBt
dDc2X2Nvbm5hYzJfbWFjX2ZpbGxfdHhzKHN0cnVjdCBtdDc2X2Rldg0KPiA+ICpkZXYsIHN0cnVj
dCBtdDc2X3djaWQgKndjaWQsDQo+ID4gIAkJc3RhdHMtPnR4X2J5dGVzICs9DQo+ID4gIAkJCWxl
MzJfZ2V0X2JpdHModHhzX2RhdGFbNV0sDQo+ID4gTVRfVFhTNV9NUERVX1RYX0JZVEUpIC0NCj4g
PiAgCQkJbGUzMl9nZXRfYml0cyh0eHNfZGF0YVs3XSwNCj4gPiBNVF9UWFM3X01QRFVfUkVUUllf
QllURSk7DQo+ID4gLQkJc3RhdHMtPnR4X3BhY2tldHMgKz0NCj4gPiAtCQkJbGUzMl9nZXRfYml0
cyh0eHNfZGF0YVs1XSwNCj4gPiBNVF9UWFM1X01QRFVfVFhfQ05UKTsNCj4gDQo+IEkgdGhpbmsg
dGhpcyB3aWxsIGJyZWFrIGFjY291bnRpbmcgZm9yIG10NzkyMSwgcmlnaHQ/DQo+IA0KDQpXaHk/
IEkgZG9uJ3QgdGhpbmsgbXQ3OTIxIHN1cHBvcnRzIFdFRC4gSXQgc2hvdWxkIG5vdCBnbyBpbnRv
IHRoaXMNCmNodW5rLg0KDQo+IFJlZ2FyZHMsDQo+IExvcmVuem8NCj4gDQo=
