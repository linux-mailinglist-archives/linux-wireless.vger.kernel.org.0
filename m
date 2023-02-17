Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF54669A7DB
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Feb 2023 10:09:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbjBQJJI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 17 Feb 2023 04:09:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbjBQJJH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 17 Feb 2023 04:09:07 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C84EA5FDD
        for <linux-wireless@vger.kernel.org>; Fri, 17 Feb 2023 01:09:02 -0800 (PST)
X-UUID: b4bf3bceaea211eda06fc9ecc4dadd91-20230217
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=RD0QFxU0jF2GAiare+eUVeCKS6xG89x67Rqsy2pZtrA=;
        b=Vl0ldVA0AGZP0rEytLpsYj9v5Tixcvj4aL6Cz+ln6t4lumuXYt6jRD9YQPgZLdIKsZgt16ij5E3X4XPDMqBLvBQGfrFBFZTGkE48Oh85Sd9Hk/z77Y8C+k/yAqUioajkG4qrQN653rFR0XjUe+8ZnXndcKcCW7tXoV+mnGr88dw=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.19,REQID:2f61bbac-b3a2-480e-83f1-f79959c900cc,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-INFO: VERSION:1.1.19,REQID:2f61bbac-b3a2-480e-83f1-f79959c900cc,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
        elease,TS:-5
X-CID-META: VersionHash:885ddb2,CLOUDID:2d1c50f3-ddba-41c3-91d9-10eeade8eac7,B
        ulkID:230217170858M1A5NUYQ,BulkQuantity:0,Recheck:0,SF:17|19|102,TC:nil,Co
        ntent:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,O
        SA:0,AV:0
X-CID-BVR: 0,NGT
X-UUID: b4bf3bceaea211eda06fc9ecc4dadd91-20230217
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1150846409; Fri, 17 Feb 2023 17:08:55 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Fri, 17 Feb 2023 17:08:54 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n1.mediatek.com (172.21.101.34) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Fri, 17 Feb 2023 17:08:54 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SAPiWervqVL7mx07RvKDRlcvDL48q+ATYT2915EKjOPZ50Qj4M0bu4EP4yl1BnJv2Gm34NsZaf2jvA5ny4jIr34UR2wcFa33U6Q3tkrow0fx84C3FHUDV4RofR3I3dnBr/MmeqN2FNxuQjU2+qVMx6nHb8N3cwoezpa0lOWv8gktkb0dqxaberpzQLWzqXpcgykeB2HGonfs1Mgv71Z0zUsVZa7xCJzctD8CEw1+cmUSczhM6oMP+tLAqOVCF0IOGRoSnzK1oUl1Ox/ySAIg4QmcSN9ngZwFb8keSYY6MyTuIwEwZAABwiNnvsmReCQyIkM1sQI3de/azFeDBPeNVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RD0QFxU0jF2GAiare+eUVeCKS6xG89x67Rqsy2pZtrA=;
 b=JTvSbNOPTsNvYxhG1kRjt8He/PCDktM3EmvHZHBpKQgq9QJIccDeVS283VnkBivi7FnRgYln3VLXkupUbugwGyZWCxGrYr7qAbe0AehHLKivQetoQZuBonBtmc/u8pD3THjOVbuN5M3IhzYuL55E+QDuSTiUti/0NeC7G+OhAHJJgBckUZS8m3jjSNp5caKyMR3b9czTVghs7jqw0bCWKSEpxXfh2PhcqYln9yd5rlnkUi+bn4yUhnbsbk/MhEFZuInaTL7m6ONa8fX8kZ5IMzn3OUi2j5zIehPlROM0ECl/7mobZRln+7xTpqO6PyfoGDfkpzD4ph5ngVoTN1dvdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RD0QFxU0jF2GAiare+eUVeCKS6xG89x67Rqsy2pZtrA=;
 b=Ev8I1Q8k0HhhmLmtEo5SlXWugDNFw9R+sThkKibj23w3aah0K8yxIMT2bl7XX6bOpt10506EcNWnBtV+6KpTbaWypsxC4WSb5QEXdWjOi5T15h4hZCXbI2ig08O0Op5t3U85ZoZTOd8s8JKM2JC90CP7oDwgAA3id/LIN5C4WiQ=
Received: from TY0PR03MB6354.apcprd03.prod.outlook.com (2603:1096:400:14a::9)
 by TYZPR03MB5693.apcprd03.prod.outlook.com (2603:1096:400:8b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.12; Fri, 17 Feb
 2023 09:08:51 +0000
Received: from TY0PR03MB6354.apcprd03.prod.outlook.com
 ([fe80::cdcc:fb2c:cc34:8360]) by TY0PR03MB6354.apcprd03.prod.outlook.com
 ([fe80::cdcc:fb2c:cc34:8360%9]) with mapi id 15.20.6111.013; Fri, 17 Feb 2023
 09:08:51 +0000
From:   Ryder Lee <Ryder.Lee@mediatek.com>
To:     "kvalo@kernel.org" <kvalo@kernel.org>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "lorenzo.bianconi@redhat.com" <lorenzo.bianconi@redhat.com>,
        "nbd@nbd.name" <nbd@nbd.name>,
        =?utf-8?B?U2hheW5lIENoZW4gKOmZs+i7kuS4nik=?= 
        <Shayne.Chen@mediatek.com>,
        =?utf-8?B?RXZlbHluIFRzYWkgKOiUoeePiumIuik=?= 
        <Evelyn.Tsai@mediatek.com>,
        =?utf-8?B?TWVpQ2hpYSBDaGl1ICjpgrHnvo7lmIkp?= 
        <MeiChia.Chiu@mediatek.com>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH] wifi: mt76: mt7996: fix radiotap bitfield
Thread-Topic: [PATCH] wifi: mt76: mt7996: fix radiotap bitfield
Thread-Index: AQHZQRc/zTNM/PVv30iB9j2Cu2bn3q7S3LcA
Date:   Fri, 17 Feb 2023 09:08:51 +0000
Message-ID: <e270026fd4a1da4c054816158102610759936f82.camel@mediatek.com>
References: <79c72b8b101f561bae2350b7945cb41bef86aa83.1676095591.git.ryder.lee@mediatek.com>
         <87pmab49mz.fsf@kernel.org>
In-Reply-To: <87pmab49mz.fsf@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY0PR03MB6354:EE_|TYZPR03MB5693:EE_
x-ms-office365-filtering-correlation-id: 4fd39b13-cb15-41ba-8ace-08db10c6961e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mDiwwdb40dg2zcGV0vpVH2+wE/MsBS4AROOPQldfnBEmFPuygfovF0aWDZ7nSIJEaVqR8zEmuSayxlfgIFy7aF0/MkyoSEC5iIIR3S4iuEQu9h1tQd/ZxjnXOFJsuST36tyIaC0n8lGtbYjq47m26t600zBZM28Fio5Ig6mWNKEcwMrszo7vtynZwuPOkD5ME56iYx/T3enBnFz4O3RFYdnaQSD46FWbrqAqzHP4WMlH+evaTNWU+c2OhsZBnLew+6r3HNFo0NImjUp7UFKXarwUzkcqtjDqWHJ4SlC3mc+8sTkq2p2I0WIKXD4ThgzOOOvnIj1qx6eS+loGPsOXx+hpCj7GjXyzzbU37UjvPlLMyNwl5R8ea5DR09pKZwdHxyVXIqkSe0NlQfA2dIGZich8KWZ/XKzfT1IWTkqBmQLJXK3lYz5X8R4mgsG0fMU7K+cDCVLWNmchj1whZ4hl43q7oc9fYBvwe6iAEHArMQS7N4eZWhxcbXVX/SM4yiu6iHSKvQU0S4FV3PSuS13uyON87lNY2UK+GKnb/HjAjdNQv0yz0QW3kLvjmXY5CBUWaeiFH/TjS2uV5h6Usy21zHbjrYFxEvrgQzZfsDSRAqYfZvvGM8kd53mpA/uf79U96Rl+2Ruk9fcXEGUP8kbqJVn8USiMcAzj6qTu4HpMgyzIBnAraXP+SgjxBBgXeQp4
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY0PR03MB6354.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(39860400002)(346002)(396003)(376002)(136003)(451199018)(36756003)(38070700005)(86362001)(66446008)(8676002)(4326008)(64756008)(91956017)(66476007)(66556008)(66946007)(76116006)(8936002)(5660300002)(6916009)(316002)(54906003)(41300700001)(6486002)(83380400001)(2906002)(4744005)(38100700002)(6506007)(478600001)(186003)(26005)(6512007)(71200400001)(122000001)(2616005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NmpKN1l6aUNlbEh1S1lndHVqTDhNTVVZNkUzcnczZ0dZNnlEY0JUK2VVbFMy?=
 =?utf-8?B?Z3RpZkN4VFlqdlc4bys5cVF3OE5mOTRETDU3aHZIRE9VRUp6L0dzREVxaEhr?=
 =?utf-8?B?VmRSLzZRWWhwZ3RwcmZoSUxPTExKYXp0cGhaL2hwalMzUGY3VGo1QllGakNW?=
 =?utf-8?B?eUJmYWhybEsxRHNpVDh0VlZnWGUvdDVveUlweHJnU2ZOdmRBYUJjWEpZeW9V?=
 =?utf-8?B?TkxmU0hwNU1HNWlTa2UwbzYyTllhMU54NzBIOXl5NzdwQ2piOEJJdlM1bzZa?=
 =?utf-8?B?cnpjY1cxZ2orbHc2ZDNyTXRlcU45TWpLRWZUbnJEYml2WTFOdDRQZG9Xamg1?=
 =?utf-8?B?d1hMdDRrb3F0YU5pc0lRZ1ZvSXhyRzJMaFdoWmtPN0tzYXJzYTVCVmtnYkg3?=
 =?utf-8?B?T3pYQ0grWU1vQ0hWbGIvMWpUQXJuaHVJMkpYd1R0OHRic0NjVjFFRGJPTUw2?=
 =?utf-8?B?elhQajhNZHlJeWlGRkNkeWQ4cmc2UWFYYitMdU5OWTJaQk02RENtZCsyUWlh?=
 =?utf-8?B?Rm1pM1ZQai9DbFl3VnorcnZJYnU3cWhuMkJ0aE1lUnUvMzdtN2VIMXhPSnBU?=
 =?utf-8?B?a1V4S2NWcG5LbjhLT1VZbDVNNmw3QU9sYk9WblRNRithdDR2Y3pIOGYwdm0y?=
 =?utf-8?B?NGl3eER4bnRaSEJJbWcrcU5FdEhva1Z0cWhzTnhQaThsODVsSmFwaUpZazh3?=
 =?utf-8?B?cDFvNkNiQWZIWEVIWTI2YmJTbHhTMGx1dGErMHRMaUt6YkM4NkUwa2hEZXdG?=
 =?utf-8?B?L3krZjl3U2RPSlNZblZoZEV2dGlOZVFOa1YyM2FnODd4NUxrMCswZlVOdmtj?=
 =?utf-8?B?YlZQYUdKa2FhODNTRDJTSHQ4TlJiUjFLVzQvZ1dLMzdDcjFPWFd0aXB3WjJX?=
 =?utf-8?B?Z0pYdloxTzBza0duWTJ0NnJ6anhtN2ZyanRzMXFXVldpb0c0TE9kY0E5SGJs?=
 =?utf-8?B?QWd2MFpUNGF0TGxCVEszNXl4WHluOXpHRlZOeUcwc3VYd29FUmtIa3dIZWFR?=
 =?utf-8?B?VUNkQU5FQVp5b3MzaWpSOHUwSjFpaDlqV25qTU5aQVo1YUkvVnYxTnd5YW5X?=
 =?utf-8?B?YkhOb0N4Wi9idXR5SUZKL0JpU1k0K0VueEQyMVU2UjIzNVlRRkV3VTRCYzF2?=
 =?utf-8?B?Z3NQbGRjcG4vL0JHeC9mZ3hCZ2k3TXRoY2g3dEVlOFMzRGFUbHpFRkNzUEMy?=
 =?utf-8?B?ZTI3Qnd2OFhHbzZVT0lYZm1wMGpKZTBpRFptcHpSQmFxWUZJTnhSQWRwbGg3?=
 =?utf-8?B?bmMrYVY5ZVBNZ05KS1J1S09VbnJzTklibFhvdVpBZEx6a0ZWS25UV3AxQ3Vh?=
 =?utf-8?B?OE92d0dwR1dUOFdmRE9zc2VtT3RjbmRpOEhpN3dVcGxrelE1Zk1rcHBGOEY2?=
 =?utf-8?B?UGhSaklGd2l0cCtxb2l2UGIwOXBqVXNsa0dhWmppRUVxVlZkM2R1cGNGTVUv?=
 =?utf-8?B?UnpSMDlnOUxEdjRHUXRZN0FlVWt3a2MraGJsaEhKWWVTYlU0Kzl3TGQ5RWxr?=
 =?utf-8?B?ZFdYa2dZcFpIWVYreEZ1SUhMdTFFNmNTOXIyNmRUMXNldTdHZkhUQlZoUkRh?=
 =?utf-8?B?STQ1MVRuUWMvenZJeHRLYnN6V3hvUXhHa1BjMlJHZitSb0JSZHpxRlNURFYz?=
 =?utf-8?B?alRmbFpaRnlqdkdRVit0RXcwYVdBVU9ISzd3UGh5R25UdVg5WFpTcGhaVjRt?=
 =?utf-8?B?d0pnWnlZaFJ2Y21OZklYL1M0ckNuWndPZUl6VENMcWcwRDJOWGZWYjlyLzM0?=
 =?utf-8?B?WlVBQ3piRldLTHU5TVVsc2tJc1Ewb3RBRG00S1c1akhXNkx2SmY2UGJ6Lzhw?=
 =?utf-8?B?Q3BoWVpVWHlEMnlEL3JmNkZKYUVFOXlXUjFXL2ZZNXV4NTJ6ZnhEd0ttTXVP?=
 =?utf-8?B?VWlUOUhZeGpWTTBWSHlZZ3dCRmxobGZEeHNZckpHL09pbVVPVWdmcUIrTGZs?=
 =?utf-8?B?SkhOdmtqVzJ5VGh5Vk1VL0grM0dYNlhQeTY1eEZiZ2dEU3hQWjJCejA1bUc1?=
 =?utf-8?B?dkdmZ0g2K0UrUnppZEEvRmdrNUx4M1NBRkZ1M3Q0empnMkdJeWdjbGx0NzdR?=
 =?utf-8?B?dGNIYmpiTWdPUGtucGRyVHFwZGRPSXpIRUJoa1pWUVF5YXFuUWdiKzNNTXlq?=
 =?utf-8?B?dGdvaEdxMlJwNXRybUlsNGYwZHZ3eFNtSnFHT3Vadmc5OHQ0TXZhSXhBWHlS?=
 =?utf-8?B?RFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <ED3407D527DA7F4692ABC292826C99B3@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY0PR03MB6354.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fd39b13-cb15-41ba-8ace-08db10c6961e
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Feb 2023 09:08:51.0741
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OXaZBMHikW5ZBxgN6nWu7uHNx1FoxrfyC6UJVIVlzSPvJ5ZFFZnLhlPclzRm63z5HxmYyI6lhc6UBVXGXfRQUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB5693
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

T24gV2VkLCAyMDIzLTAyLTE1IGF0IDEwOjI2ICswMjAwLCBLYWxsZSBWYWxvIHdyb3RlOg0KPiBS
eWRlciBMZWUgPHJ5ZGVyLmxlZUBtZWRpYXRlay5jb20+IHdyaXRlczoNCj4gDQo+ID4gVXBkYXRl
IHJhZGlvdGFwIGJpdGZpZWxkLg0KPiANCj4gVGhlIHRpdGxlIHNheXMgImZpeCByYWRpb3RhcCBi
aXRmaWVsZCIgYW5kIHRoZSBjb21taXQgbG9nICJmaXgNCj4gcmFkaW90YXANCj4gYml0ZmllbGQi
LCBuZWl0aGVyIHJlYWxseSBleHBsYWluIGFueXRoaW5nLiBQbGVhc2UgYnV0IG1vcmUgZWZmb3J0
DQo+IHdoZW4NCj4gd3JpdGluZyBjb21taXQgbG9ncyBhbmQgbWFrZSBzdXJlIGFsbCBNZWRpYXRl
ayBlbmdpbmVlcnMgdW5kZXJzdGFuZA0KPiB0aGUNCj4gaW1wb3J0YW5jZSBvZiB0aGlzLiBUaGlz
IGlzIG5vdCB0aGUgZmlyc3QgdGltZSBJJ20gbWVudGlvbmluZyBhYm91dA0KPiB0aGlzDQo+IHRv
IHBhdGNoZXMgZnJvbSBNZWRpYXRlay4gTW9yZSBpbmZvIGluIHRoZSB3aWtpIGxpbmsgYmVsb3cu
DQo+IA0KDQpHb3QgaXQuIEkgd2lsbCByZXZpc2UgbG9ncyBpbiB2Mi4NCg0KUnlkZXINCg==
