Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C57D77B3DB9
	for <lists+linux-wireless@lfdr.de>; Sat, 30 Sep 2023 05:03:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233909AbjI3DDH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 29 Sep 2023 23:03:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjI3DDG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 29 Sep 2023 23:03:06 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3565DFA
        for <linux-wireless@vger.kernel.org>; Fri, 29 Sep 2023 20:02:57 -0700 (PDT)
X-UUID: d8e03fe85f3d11eea33bb35ae8d461a2-20230930
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=4eMjFWFxyEr0N4kc/S5cuuaMUpFh3yjnbQqscYltruQ=;
        b=D5yW0SjckIKyXO/IEW541N6L3joCP165fRR7qWvKYmSzNYQWscNVZ033B2ss/Lbmz9xFhisZNOT4J0EQd0+tCA6IyGZPEebotikGqiOokFFTL8wjuykG4tdSDHni7mn5yhy3wPun0wXDuGnYuvs8c9doPn/W8rgJUlTTTmlbIWc=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:e35ef2c9-4db6-4212-adb7-d4d092af8b63,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-META: VersionHash:5f78ec9,CLOUDID:7ddc8614-4929-4845-9571-38c601e9c3c9,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: d8e03fe85f3d11eea33bb35ae8d461a2-20230930
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <deren.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 980712401; Sat, 30 Sep 2023 11:02:53 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Sat, 30 Sep 2023 11:02:51 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Sat, 30 Sep 2023 11:02:51 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z0CWerXj2N0SS76szb/v7Bg1nWs1bnlPbrhweqsamZRVisNNOhEdi0mf6vuRCu5Vjn3RrnwHIrEPhY4oBZVE3v/zFjdsjN51ltE02FdF3LhPNaCPH1yFiWIEZM3lS3wScIEN9R7InJ0I2Uy/ZNUz/ceUiFs6NGwJYUXNfE0ol3c1eTZTNKMtSafBVqGo+MnAlRA3F6BUYGp+eJ+YxerActA5quayWU/SaoUZw/mUMLPa7aA3VMyRxNrYIWwW5+6hZ4KsGo4ZTYdbm85zumshUllqwlFgPHgdhLScqL68UCDWK9Nr5tYlES2Yqgmbo8bwfZWVjJssp2hvXvxNKsW/0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4eMjFWFxyEr0N4kc/S5cuuaMUpFh3yjnbQqscYltruQ=;
 b=ZRsKnXfY9kTJOf0/0h2QdYHAdAuN5lqenqgSom6///9y1ba001nsCnrbtCZ0qXGSY2lRiE8cBdfFb8GNQLIvDE63IF4GYAr4AYySUWRXONsrU8ZEgZoYZfdSUVSa3y1iqIrEp/VCrD0KFqoOCr4oW7NjGtBRcUkKD0+2wZ44Le9i0W+cdhkFGYmWOMOKTifU5Fdx0Q5sracmjBWVYFwFBCocrNFelKrB1ij0sZrAptDi2qm9bD/cW5DToleziJH2ZwQbQ8seYbiPrGd1ZRkQQUQN1AGNA5qRBd+gIshILUZAvFvUkY1CYyghyJ36cZMJTaBsgETEnNptm9L4SdMoeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4eMjFWFxyEr0N4kc/S5cuuaMUpFh3yjnbQqscYltruQ=;
 b=q5JS/7fCwgJ0Fo6hNZDZDiG8qRjjEjdwAYMmF1bPcb/diIckSJkUqAGwePk3ZfXrSXJQ6gtJdL6PTL515lQy0/m68EDI5JJJ1kOBboHFisvcrAfO8pmydWkTviYPpg7x6sMcoYUEQ+veXhbzNX5U1e8qLjP/y46MeuQBsQRGWik=
Received: from SI2PR03MB6194.apcprd03.prod.outlook.com (2603:1096:4:14e::9) by
 SEYPR03MB8066.apcprd03.prod.outlook.com (2603:1096:101:16e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.27; Sat, 30 Sep
 2023 03:02:46 +0000
Received: from SI2PR03MB6194.apcprd03.prod.outlook.com
 ([fe80::3d1b:4de0:a1e9:eafc]) by SI2PR03MB6194.apcprd03.prod.outlook.com
 ([fe80::3d1b:4de0:a1e9:eafc%7]) with mapi id 15.20.6838.024; Sat, 30 Sep 2023
 03:02:46 +0000
From:   =?utf-8?B?RGVyZW4gV3UgKOatpuW+t+S7gSk=?= <Deren.Wu@mediatek.com>
To:     "nbd@nbd.name" <nbd@nbd.name>,
        "lorenzo@kernel.org" <lorenzo@kernel.org>
CC:     =?utf-8?B?TWluZ3llbiBIc2llaCAo6Kyd5piO6Ku6KQ==?= 
        <Mingyen.Hsieh@mediatek.com>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?utf-8?B?TGVvbiBZZW4gKOmhj+iJr+WEkik=?= <Leon.Yen@mediatek.com>,
        =?utf-8?B?Um9uZyBZYW4gKOmEouiNoyk=?= <Rong.Yan@mediatek.com>,
        =?utf-8?B?U2hheW5lIENoZW4gKOmZs+i7kuS4nik=?= 
        <Shayne.Chen@mediatek.com>,
        =?utf-8?B?U3RlbGxhIENoYW5nICjlvLXmm4nkvakp?= 
        <Stella.Chang@mediatek.com>,
        =?utf-8?B?UXVhbiBaaG91ICjlkajlhagp?= <Quan.Zhou@mediatek.com>,
        Sean Wang <Sean.Wang@mediatek.com>,
        =?utf-8?B?S00gTGluICjmnpfmmIbmsJEp?= <km.lin@mediatek.com>,
        =?utf-8?B?U291bCBIdWFuZyAo6buD6Iez5pi2KQ==?= 
        <Soul.Huang@mediatek.com>,
        =?utf-8?B?UG9zaCBTdW4gKOWtq+eRnuW7tyk=?= <posh.sun@mediatek.com>,
        =?utf-8?B?RXJpYy1TWSBDaGFuZyAo5by15pu45rqQKQ==?= 
        <Eric-SY.Chang@mediatek.com>,
        =?utf-8?B?Q0ggWWVoICjokYnlv5fosaop?= <ch.yeh@mediatek.com>,
        =?utf-8?B?Um9iaW4gQ2hpdSAo6YKx5ZyL5r+xKQ==?= 
        <robin.chiu@mediatek.com>, Ryder Lee <Ryder.Lee@mediatek.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v2 6/6] wifi: mt76: mt7921: support 5.9/6GHz channel
 config in acpi
Thread-Topic: [PATCH v2 6/6] wifi: mt76: mt7921: support 5.9/6GHz channel
 config in acpi
Thread-Index: AQHZ80Vgd2CTryafOUeNVHSSRCfLDrAyrqCA
Date:   Sat, 30 Sep 2023 03:02:46 +0000
Message-ID: <0a45200ad39209d8955b5580b0d36444d7c5ad5a.camel@mediatek.com>
References: <cover.1696039301.git.deren.wu@mediatek.com>
         <f01bcf001c896a74e36ac9905bece382efb13b0d.1696039301.git.deren.wu@mediatek.com>
In-Reply-To: <f01bcf001c896a74e36ac9905bece382efb13b0d.1696039301.git.deren.wu@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR03MB6194:EE_|SEYPR03MB8066:EE_
x-ms-office365-filtering-correlation-id: 80a53fea-9ca6-43a7-00e0-08dbc161b90c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yx+wYGlJP959+zh2klqU8ZdkPTn3vivF53FhubCCvttVGRZliJcrMmMSzn1Llr0yLt9OOKak26z0+FU0E8lJqSRtqB55VdI3cPOxRDxz0v02IjtiYJ3rBFX9s8fpVUl9Cv20b5ereAxI5GD6QpSp8asuiJfNfgBPV6gkldIgrUsdreO1i9TaP/T2wWG96ggNMdXOMaEHEfwFTeBWKUrFhdGAufhkMVEL9olRCDTra4q4m36Idb6iwUU6X4thUessUrk0k7nrgvehxbsDiL72yM644iRTMqX+SZt7TowLC4oJZnKk4XGWb9ZvMJg7m9h3FP4sCa+SBlod8VwqG/13E0sdPvdp8j53QRZjiRzRGN7ndRU1adD3V0F59A+qQvOodagGeSOJLuX4Hik3MhJo8dXXhA8OJEdKpJD/Usq7VHdHY4SVVmCeEJSUJIFvi0TTnDCn12Ruh8iSBPbb5AEPaj8snXCrU1xQXd3MAaiFzp9Nlbl87O9Bi9MHfMU4ZJFzV4ozIujgG+HefMIOB7FeYD6ynW+O9TIKRI6ppDJ7x455htP9kVVUv98tsTWBwGtWbnl4PudsWEa0lwbGNnr6hf33Xy7gD2gJm0Zx9P3GCtuy3cmNWLDpYR68AHLij1iN073CDZbZ5+L0TJTwQdPbIkCz7sQJPUN0iUXist1Oh30=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB6194.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(39860400002)(376002)(346002)(396003)(230922051799003)(1800799009)(451199024)(186009)(64100799003)(2616005)(6512007)(6506007)(83380400001)(6486002)(478600001)(2906002)(26005)(71200400001)(4744005)(316002)(66946007)(110136005)(76116006)(66476007)(54906003)(66446008)(91956017)(66556008)(64756008)(8676002)(4326008)(8936002)(41300700001)(5660300002)(36756003)(38100700002)(86362001)(85182001)(122000001)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NnBCRjRlNVZUNFNyMmVNeEFYdzdqVXRVWXlTeVlOb1ZiblRCYTJpVkNJTi9x?=
 =?utf-8?B?eFlQbk9idkpSRTJEWnd2MlRGTzd4bmtqZzgyTEZ2OStsbzlJcVZQVkV3TS9i?=
 =?utf-8?B?ekhxbEhuMWtaL25STVBHN0M0MXg3N1ZtcGM3UXhRT3EyV3RHQlRZOTNTdXFn?=
 =?utf-8?B?ejVHYjRpR2lPbU0wd2xHUzJhNnFjY3lwT1htTUpyUUNaUkkyMW9KMXVIU0tG?=
 =?utf-8?B?NHlNWFY3cXhYQ05kS28wM3dXYVpybXp0N1lzRCtiQzdBSUZhZFF4bjhESncw?=
 =?utf-8?B?cm9rY0pmSndkZy8yL0Vqc21ZTWxxd2ZRano3WlB1NS9EeVdEeEFCRG1yWEor?=
 =?utf-8?B?TWNuWFZtOE5HWkFneVFtVmZySzEvN21NTCtTNG41UjJseUdGSFVHRTdZNHJs?=
 =?utf-8?B?bndsZTBsMWYzQk5rclBYUXp0Tmx1dUZDdVVCdENHTThVVVB4OHphcklBd1hB?=
 =?utf-8?B?MmhUQ2FxMWNDUXVRTTY0MzRyeEZMNXMwLzI2cFdib1NHUmRlZ0dvVUVXcXJ2?=
 =?utf-8?B?d0ZlOUJPUlJnc1loeHVCanhkU2l4VVQ4TzZyUE1lVTNQR2VzRHFtenFiYlhX?=
 =?utf-8?B?OHFKOXdiTmQ1MWVrQmcxYyt4bnlUMDlPUE5nSCt3RmVnaXR6OVpaYy9XSnd5?=
 =?utf-8?B?VFdhN1pTekozNUhDVExhaEZ2cUNNazJaVnVBNGxJVUxpbW5YZDNBakFHVmRs?=
 =?utf-8?B?dmxhMFJucjdzZnJjeDVnVHRVWnJySXpkSnhvZVQ4dHlXSFhDblBZeGZEYTNt?=
 =?utf-8?B?b01BaUhhMjcwMnVVeG82Ym5EK01MdjJFdjZPZUl5bjBvS0JRcTdMOVhvSmMz?=
 =?utf-8?B?NjRpcThqd2EzTUJjQS9iV1doaXdTRUZubDV6VVB5MExxMVBuUU9RNWFkeG9M?=
 =?utf-8?B?QkQxL3o5dXlxNkNNSnhjZFJidERJdmJnemRWWVU1bjRDWmIzaEV5emc2R0dF?=
 =?utf-8?B?bFl3UDI4Q3M2TlFzZ3U5TDRweDVOVjlzTk9DWDFSQS9OMTh5enIvUUlmV0Vp?=
 =?utf-8?B?bjFCUE1XbWNEUW0wNmVPNjYyT0F0MGJUYm9mL0lhUTRhbytrZzFjSzdyNGh3?=
 =?utf-8?B?MlRnRDhMV1hLZGNuU0NPTldRRkVSRUhRcW4rekRwbmxTVmtXaHVNT0hlRjRS?=
 =?utf-8?B?bE9nODBFaDdFK1dzNmpmMXRZWFJNZC9uSzM5WFpVblpPazBaK3BicVRsam9B?=
 =?utf-8?B?a0ZWdUVIQlB1S2FtQzZCRThrZGlBbVhLRkVpSE1IVUI1RDNDUTFGRWh2MUZ1?=
 =?utf-8?B?K0RkZ1UwRWtua1FqbFZPNkoyK2V1emxLU0g4dk1CNWRJMXlCTVovbVFEU2Rr?=
 =?utf-8?B?Rm9XbFpuRjVXc1NGM1hqd1RpbGVoc0NOb284aVV0ZVJONFVFV2NoYXVvLzBT?=
 =?utf-8?B?SzRUeitNUERlMktEeTFpUzYwSW9HdlhaWjRXY054R0UybS83UGdjMXhFUDV1?=
 =?utf-8?B?VVVvOTcyMlhKYSswMU1yTXJTaEdYWjV1ajRJZDhUUE9QREFBT21tSmRldjN2?=
 =?utf-8?B?WnpTODRhVThJZ2o3VDJaTDBSSlVrOHc3V2ZJenJKb2crM0tQbzRrK0FIc3BY?=
 =?utf-8?B?d0RvVXZQazlKZ216ZFMrSTdqaWgwWlkwLzhKS3NKMUdrOVp3KzZtMGZzRXE4?=
 =?utf-8?B?eEcwUWNtU3M3amN2MTczeVJtenhCRkZPc3dpRmFBdFRSQWJzWVFsZlltTDZG?=
 =?utf-8?B?QmlNdFUvMENYWkYyUUxiOGxnSzRvdU9nMW15ZXhpdGE4cGN6aU5VV0xrSzF4?=
 =?utf-8?B?MmRlTmJSb0lTK1ROOWd3bmxuNFhxZHNEYnJQcS9hTFViWE01eVlYbUo1N3Rp?=
 =?utf-8?B?T1RYeVN3Tk1TdWRaU1hFNEUwZjJlb3QrZ042cUlIZ3BJSW1LSmRUWEk3dlV6?=
 =?utf-8?B?WVh4akJ2clQwSHJGV0hlWTMvN0V6ci96aFJVZ2MrWHR6OXNWZTJia1dpS2pU?=
 =?utf-8?B?bjg0N0dUNmI4ako1eDdqZ2Njc2dySGJEcUdyTC84eEVySU5GaTVydWNVSFlD?=
 =?utf-8?B?a3Eyb0QxM09vOFdSTXNJT3ZRZ29FRUR2WWcvQTdDbVloYzhmZDBuWUplUmow?=
 =?utf-8?B?OGdVMVMzanovMU5JWXJwT0ovV3NMRnhOV0gvUGxTY2FweC9XbXVCU0VJeXU0?=
 =?utf-8?B?QjJIcTlaYzVIbVFlN29uOUUvWU03NXNTdkVJZEU5QzU5TjM3dWZCR0NiWC9o?=
 =?utf-8?B?bnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <920CAC831DF7AA428843F964CBBA5440@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB6194.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80a53fea-9ca6-43a7-00e0-08dbc161b90c
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2023 03:02:46.3297
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TD2XCa7dN4/o7Fb+Yq2rgVQjn1ZgMV/vLUeVyEv3YIqBJziu6XmUeCJrUW0OSkk6T9w7SZLwayB4i/BJV3850w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB8066
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--0.607700-8.000000
X-TMASE-MatchedRID: h20DFeLkM8/UL3YCMmnG4ia1MaKuob8Pt3aeg7g/usDkMnUVL5d0E1lz
        o9zSKaiK/2QKRsl+Tb5queEjGolvX79d522UzRMFIyvp1AQXH8sIjen4m7yaqr0rWM4nIpJrEXD
        /MNCYe71SCBJNX+PnoX51/Ce39OcTzrfv4DmGmcUpoxDq3DugMn0tCKdnhB58pTwPRvSoXL2ZMP
        CnTMzfOiq2rl3dzGQ1GpeevGsoI5c2SX6mp/FFN3yDXLJWVhGHrAXiNrbUgfuesLLBMKIXaP9H/
        KlpsG4Q2nfOiaEahKnWDWIwgBm7+qd/WxzbspwI+Dm1ePrPl7C5ZyimlDMxyA56xhuba2WuZ86K
        Y3oNT3zIO0Si2Tuenn7cGd19dSFd
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--0.607700-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 708B9E91098007F0D32929F0529F48562BE01A33DBBB6D1106D0300CAD6442022000:8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,T_SPF_TEMPERROR,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

T24gU2F0LCAyMDIzLTA5LTMwIGF0IDEwOjI1ICswODAwLCBEZXJlbiBXdSB3cm90ZToNCj4gRnJv
bTogInJvbmcueWFuIiA8cm9uZy55YW5AbWVkaWF0ZWsuY29tPg0KDQpIaSBGZWxpeCwNCg0KSSBh
bSBub3Qgc3VyZSB3aHkgdGhpcyBwYXRjaCBpcyBub3Qgc2hvd24gaW4gd2lyZWxlc3MgcGF0Y2h3
b3JrLCBidXQgaXQNCmlzIG1lZGlhdGVrIHBhdGNod29yayBhbHJlYXkuIEd1ZXNzIHRoZXJlIGlz
IHNvbWV0aGluZyB3cm9uZyBpbg0KYXV0aG9yJ3MgbmFtaW5nIHBhcnNpbmcuIEkgcHJlZmVyIHRv
IGtlZXAgdGhpcyBwYXRjaCBpbiBtYWlsIHRocmVkIG9ubHksIGhvdyBkbyB5b3UgdGhpbms/DQoN
ClJlZ2FyZHMsDQpEZXJlbg0KDQo+IA0KPiBUaGUgbXRjbCB0YWJsZSwgY29uZmlndXJlZCBieSBw
bGF0Zm9ybSB2ZW5kb3IsIHByb3ZpZGVzIHJlZ3VsYXRvcnkNCj4gaW5mb3JtYXRpb24gZm9yIDUu
OS82IEdIeiBjaGFubmVscy4gbXQ3OTJ4IHNob3VsZCB3b3JrIG9uDQo+IGNvcnJlc3BvbmRpbmcg
Y2hhbm5lbHMgc3VwcG9ydGVkIGJ5IG10Y2wuIFRoaXMgcGF0Y2ggd291bGQgcGFyc2UNCj4gdGhl
IHNldHRpbmdzIGluIG10Y2wgdGFibGUgYW5kIGFwcGx5IHRoZSByZXN1bHQgaW50byBjaGlwIHNp
ZGUuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiByb25nLnlhbiA8cm9uZy55YW5AbWVkaWF0ZWsuY29t
Pg0KPiBDby1kZXZlbG9wZWQtYnk6IERlcmVuIFd1IDxkZXJlbi53dUBtZWRpYXRlay5jb20+DQo+
IFNpZ25lZC1vZmYtYnk6IERlcmVuIFd1IDxkZXJlbi53dUBtZWRpYXRlay5jb20+DQo+IC0tLQ0K
PiAgLi4uL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzkyMS9tY3UuYyAgIHwgIDQgKy0N
Cj4gIGRyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3OTJ4LmggICB8ICA2ICsr
Kw0KPiAgLi4uL3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3OTJ4X2FjcGlfc2FyLmMgIHwgNTMN
Cj4gKysrKysrKysrKysrKysrKysrKw0KPiAgLi4uL3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3
OTJ4X2FjcGlfc2FyLmggIHwgIDIgKw0KPiAgNCBmaWxlcyBjaGFuZ2VkLCA2NCBpbnNlcnRpb25z
KCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiANCg==
