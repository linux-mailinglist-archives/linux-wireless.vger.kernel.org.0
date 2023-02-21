Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1C9B69E7FE
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Feb 2023 20:05:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbjBUTFC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 21 Feb 2023 14:05:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjBUTFA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 21 Feb 2023 14:05:00 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F4DE4ED6
        for <linux-wireless@vger.kernel.org>; Tue, 21 Feb 2023 11:04:55 -0800 (PST)
X-UUID: 9ebd3742b21a11eda06fc9ecc4dadd91-20230222
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=1CtrMh2h/UfrmZTw6zukhHuDFfWN+D+h/yOnbmcv7Y4=;
        b=G6r4upxgTaxpTU8hpio2L9+my326/WJWVrVlMMV7xBT/CaAGOzZ9XpF7ANzmDwB2dBnUTWZiWFPvKY34+BEm2llZVtrxGvHvWAcmaMyB/vi9kvdanRZYFkzr/9C/OhLAfxXV8sIbUC+IKKknmswgH3Xp/v02oiPL8c90+JHtddE=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.20,REQID:5968c809-8941-4285-8b9b-1603818ff77d,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-INFO: VERSION:1.1.20,REQID:5968c809-8941-4285-8b9b-1603818ff77d,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
        elease,TS:-5
X-CID-META: VersionHash:25b5999,CLOUDID:aba04426-564d-42d9-9875-7c868ee415ec,B
        ulkID:230221175746DQHC8AQG,BulkQuantity:5,Recheck:0,SF:17|19|102,TC:nil,Co
        ntent:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:40,QS:nil,BEC:nil,COL:0,OSI:0,OS
        A:0,AV:0
X-CID-BVR: 0,NGT
X-UUID: 9ebd3742b21a11eda06fc9ecc4dadd91-20230222
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1934867068; Wed, 22 Feb 2023 03:04:52 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Wed, 22 Feb 2023 03:04:50 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n1.mediatek.com (172.21.101.34) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Wed, 22 Feb 2023 03:04:50 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TF5cMNUKfsaiLrHGZbMDCDSZnYQVTQdPCvjsPEZPADj10qw6G6yo78as7Mt5PTYsafVeOLKbW0B+Q3F5QSrfbSo6pmAMiKBlFHob7OZUVTX0bU1Dm4aOb9dmDbp05OPjgXTWqIQ3s4Im1f3st/R4JhjmbbQuDtdKV62LkuWiemr99lpcH6Mod/P13tOtq2ERMnyK65Opp/WkxycU3FHTGB9/WzxkxqG8HFB/gODFKO7iVSP51p6lZyC8fbOxW0UNIBT7swavbhVkppvzMad7jAebX+CCJoVX45AeoxaByTKJi6zd0NjVBzzD+qykXx6zuKR5mOAaCJd64sfJ0OK6Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1CtrMh2h/UfrmZTw6zukhHuDFfWN+D+h/yOnbmcv7Y4=;
 b=MYXa0jWXL21SqA62E9DToMT70JNdjf/+xOXIQ3XCrH3rQRsCCMZGxSybd7GYj85CJjSJ5WeoRTJXG2cY5dX8Ite8dLV702l8uwkC4tUIqy04NUNyseEH1It7JHzEanpnhVWfeQfbR1oWjd/CQ30CDLM2GYM/U7KASLNc/bkSzd6PU548+J9CCdC1CNYB5jj7kU9LGmoJveivY2Hug95U9lsHDcen7KWQWU2bXW2ifwjbG1He4Qzzo6HBqZ8gC2nOkRTpOdaFXHH+j2J4cX8pXJzBxGp4fR/daA8MlpoMQ3cwWVUxsjSBt9mCajNIrQWqgF/vXHKtlZ61E/HydcgZ7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1CtrMh2h/UfrmZTw6zukhHuDFfWN+D+h/yOnbmcv7Y4=;
 b=MxwvXshheyTuraitMAmG4y62tbtRuwG1xcPRcrqogqRL8cEHOPJxrDrDrn1v4IwmpFm0HIHhZCqNpmKs0+/NDIn0hJtZz9U5WcGwkhmSMz0UhykV2OLxb7N38HVGC3dwO6gZ/dsZfPTOF2kEfir0yQWAl2jng06yfHyh02dGmao=
Received: from TY0PR03MB6354.apcprd03.prod.outlook.com (2603:1096:400:14a::9)
 by TYZPR03MB6819.apcprd03.prod.outlook.com (2603:1096:400:201::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.21; Tue, 21 Feb
 2023 19:04:49 +0000
Received: from TY0PR03MB6354.apcprd03.prod.outlook.com
 ([fe80::cdcc:fb2c:cc34:8360]) by TY0PR03MB6354.apcprd03.prod.outlook.com
 ([fe80::cdcc:fb2c:cc34:8360%8]) with mapi id 15.20.6111.021; Tue, 21 Feb 2023
 19:04:49 +0000
From:   Ryder Lee <Ryder.Lee@mediatek.com>
To:     "johannes@sipsolutions.net" <johannes@sipsolutions.net>
CC:     =?utf-8?B?U2hheW5lIENoZW4gKOmZs+i7kuS4nik=?= 
        <Shayne.Chen@mediatek.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?utf-8?B?RXZlbHluIFRzYWkgKOiUoeePiumIuik=?= 
        <Evelyn.Tsai@mediatek.com>
Subject: Re: [PATCH 1/2] wifi: mac80211: introduce
 ieee80211_refresh_tx_agg_session_timer()
Thread-Topic: [PATCH 1/2] wifi: mac80211: introduce
 ieee80211_refresh_tx_agg_session_timer()
Thread-Index: AQHZQvhNg/XMHPbh9UaJA+rO7kUbpq7TbbAAgAALzICAAALQgIAAAn+AgAOo34CAAAswgIAB/Q4AgACY4QA=
Date:   Tue, 21 Feb 2023 19:04:48 +0000
Message-ID: <3519e733bb3ba72b307a9fe6f92086f9fbd6fb63.camel@mediatek.com>
References: <7c3f72eac1c34921cd84a462e60d71e125862152.1676616450.git.ryder.lee@mediatek.com>
         <44f956b493e33bf394b2947b77e7c86f394b28ed.camel@sipsolutions.net>
         <fea6defb05d0f39d99bce96ea22e8c92d1a939ab.camel@mediatek.com>
         <fb3ab2d925fdeae2e7cc778419c1476102b9f85f.camel@sipsolutions.net>
         <56190740441a6740e9edf761ab2167edc51f20c3.camel@mediatek.com>
         <c05a8b20b5d4429b1c42ef2398ff2bf760bd7eae.camel@mediatek.com>
         <ed37dd9cfba8d0ec7b50f932742156aaa57843e9.camel@mediatek.com>
         <a3f50c4b4e75ff53a5611c3ef2d6345d4324cedb.camel@sipsolutions.net>
In-Reply-To: <a3f50c4b4e75ff53a5611c3ef2d6345d4324cedb.camel@sipsolutions.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY0PR03MB6354:EE_|TYZPR03MB6819:EE_
x-ms-office365-filtering-correlation-id: f69714d1-fe13-4e60-d903-08db143e80ff
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9mihOORFJzW+nPx7S7BeUsApypYP6av4xh7KRyfZakuJSi3Jr2Y8n3sg2AEB1PaRbvuJBIQaYQ3geGqYPK1YtQcmD2Ze6NfhzA7eFNx7WHbuvu1TeF3yK8rS6HPWEW/K135skKT8rTo/3vc7u0J4iHLeVqdX37KTpqiDg93PouiC6zBvKJHTkZsn1ok+bPmVkunfeDE0QrUsCcz1JdQ3gxdMOJ/oHsjG+tDHodxNEQhuSIignk2uOtyuz3Gp65xEEibRzfQLGfG8poELYjVyKlj1O0QHQwx7/jduwJoEmIIQxa/e5BMU+XuNug1EilRitqebOv59EL7kRyVmrGi0LdNO65ooOu4pvQwQi7pmZigQFjSM1P5He3HSxgk4SSe9avnG3pz5dVqYISbDLvYnRtnvxW1Pp42Y0Axqmf24WdzzSwzdAPbSXLQMXYRRX2v+M+mAtfqLZRAl+YKzfqxsYX3b99pqrJYYwNacdNHOTVD7EVgKyhDmVgE+fMTdyT7fO6Gy+7L16gm6jBCyNbfRDdtNy/IVIqJ2r7RcCE7XVpdG/7bjetHOO+qi/faoq6k4p7FBXi+AKTzd0mJTuLUH83If+lCRmm1LScZGrs9HE5nwGH4aQJ9d6vwXtk+lnZ8b96KklIEQ3px2Zj9eWDdPEwVVo15q/CO6h1w36jPDIhNEJ+4O/haZb1x2ccteeWRAwGDuBc8mQeOmWHz5ekitTw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY0PR03MB6354.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(396003)(136003)(366004)(346002)(39860400002)(451199018)(2906002)(41300700001)(316002)(83380400001)(5660300002)(4744005)(36756003)(8936002)(86362001)(91956017)(66476007)(66446008)(6916009)(4326008)(8676002)(64756008)(38070700005)(76116006)(66946007)(66556008)(122000001)(38100700002)(54906003)(107886003)(71200400001)(2616005)(6512007)(6506007)(186003)(26005)(6486002)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MHJwZ2hkc2ZINEtUN0NPMnVaWW12eER0UWxsRUJoY0NNb2dnZjB3N015KzVB?=
 =?utf-8?B?Qnkzc202SGVhN092RE95VVZUVTlhc2Q3Y01hMlNCY2pFL0FVSUlrZnF3MG41?=
 =?utf-8?B?YXJEbWRjeENLN0hsMEFES1pwd0RQN25hUGZMMmEzakFpaVlJK1ozR0ZNWmc1?=
 =?utf-8?B?ekN4eUxXbnZJRmk3bENwMVgxbi9sWFh6Y3JmeW5KV2JMVm9yS2dqaG1VcWNT?=
 =?utf-8?B?WDhLeEVCaWlUcU1SY1E1VDJnTm9tUmlRa1R3Sm42aGtveG9NU3dhWUJTZUx4?=
 =?utf-8?B?Z2ljZzFVdEZuTGd4ZkR4K1hqNElISjlRYjYrdTlrTFB2VFFXT1RMbDVaMFRn?=
 =?utf-8?B?UkRzOXFCbTRIR2N5SnRBZEZRajJrU21EcjdOYXk3OWhOZjluL2xpNWl0a20v?=
 =?utf-8?B?TUdUY2lWZjNFOWJhNFd2dW9XSEhPeGRIZHFkMnNubTB1d2dtWDYwZjZhdzQ2?=
 =?utf-8?B?NU5BR3BhVXJwbXltd0ZKY3lqUk5VbjMyV2c2MjBEUVBZUHA2SGdmNWhyOHBi?=
 =?utf-8?B?NWE2VGhqNlJxNTBIUEx6YWJTK1I4QU1HNVc2RVljTzRuMGc4Z0tLSEhHdHlm?=
 =?utf-8?B?Q2YxWk40aEEvS2xLRkVJTENVQ2ZKcnhOWldFazQveVAzUzhpekdHbFdkTEhr?=
 =?utf-8?B?b0d5Qm10RmhNeGt0cTg0Z2NGdVcxOE41K2tDT2FUV1NrTUFWeGV5eVhTUVpX?=
 =?utf-8?B?bWFTWS9BcktBMFZZd25kU3QrSUoxRi9uU3FPMmNXMWNQRGlodUtDaU5zaXZi?=
 =?utf-8?B?em9JQTZMRWh6eENzR1E1d1ZLa1FITEkyaWc4TzNpU1dsemxDVTJsZXVDRXUz?=
 =?utf-8?B?RFJSdnYydHBIU1BpcE9XU2FDNkdoNnljb1llcUIySGdPUVNTU2pVZUNqR1Nx?=
 =?utf-8?B?b0l1SFlkM0g4UUNWU093bUpQMlRERkFSN1dIMVhYQkliUTRRWFAwVlhjdVAz?=
 =?utf-8?B?L2w3ODNXN1J0dnlkZW5LaVlEa1YzeFFzTFFIZUhYK2dwampla0t3QWZsZUtP?=
 =?utf-8?B?bGpKR1E1TFBGUUt6YmxUZVdJNnN4dWQ4Wm82UmZNcitVZTkvM2UxQ3pNbC96?=
 =?utf-8?B?QlpsTGg2RzMvU2FsRUR2SzV1aFdHbkFxRC9nV21TU1hyNWVkMUxMdGhYc2Ni?=
 =?utf-8?B?ZGRBYkVNVkVsRVQ0YWR2eHFHU2RXZ0Y4Y0VjeDNTdzZjdkdIRjZLb09jVUls?=
 =?utf-8?B?UCsvZXZLMmRTQllQM293cnpqUXJTNnU3UCtpSjJ6dElINU9OOE10blNKTXd5?=
 =?utf-8?B?ZnhBNWR6cCsva2FZU0h2Rm1Bc2p5SWZqS2tkMjF6eFlqVm1CYkVmb3lVQVJq?=
 =?utf-8?B?K0pBMVNlUjdCNjJwYlpZdU5iQ0sxa1dGYVgzSkVhZFQvUzdyYSttVW1lbTFC?=
 =?utf-8?B?NWJ4L3R5eDd4dUdIR0IybjVwL1lDV0pBcGtFR1JGVzJqWnFPczZtQ1A1MWhG?=
 =?utf-8?B?Q2tlOTZjRUpYREpmWWQ5QXBsVlZ6L3FkdjRmOTZnSVdkWnVpSHFYL3RaSVha?=
 =?utf-8?B?MlJKbjVDdUtTeG5YSFUwVzA2czZldW9mV05LQ0pzOWlGVkZrNXlMczZwNGNm?=
 =?utf-8?B?Wk50QUkycTRsY0s0MitJVU5mQ2MrSytkeWlURGZvWGFNSE5LWUFtVVpiRVQr?=
 =?utf-8?B?b0ozNllWSEgrYzg0dHdvK09XbzJKQ3JRQlo2UWJMck1mK3RDbEJYTTQ0Yjly?=
 =?utf-8?B?b3BOeFFLOUplb05YcmREd0RYVVVJbUtYZGUrYVFTZVhRRndaNHZBbUhZdTdq?=
 =?utf-8?B?UVY5dlQrRHFURnFIRzJkQVBzd0tlc2grUnNCckhJZExmbERvUE5vaU8xdEVj?=
 =?utf-8?B?RU9WRGJJeDN3dDNYbmF3ZzhZUlY0YUhvQ0JlVG5jb2VlRDA1MWF2OGs2UzJq?=
 =?utf-8?B?TnJkQ2s1ZmdCT0RnVEJZdVIwcjBNdU84SEZvU2FCNmF2a25qTExUMTNUdEY0?=
 =?utf-8?B?bUlFb2swUWNTbDVTNUlFM0Y0VmkrZWM2YmF4NEUxUGxGRHN3YXV2ZVBsay9o?=
 =?utf-8?B?OXRHNkpybnNpc0IxK0ZYRnpnc04yYmExc2JxSXNGQWc5UmdhTm9BL0VLeXlE?=
 =?utf-8?B?VXE3dnB0Z1YxWHFveldJV3l0RElIZ29VNDRXS0d4Mm9PeEtBYXZ2bkpoOXF5?=
 =?utf-8?B?UmxiV0hUN2V1Y0tzNTM2bm1QZjhXT2RZVlNEdE9mNElQK2EvNkIyaHNuUzU3?=
 =?utf-8?B?UFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <65A9D67F78E72845BA71ABFCA408F72E@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY0PR03MB6354.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f69714d1-fe13-4e60-d903-08db143e80ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2023 19:04:48.7210
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B6s/ykQlHT6IndvgeczEDtIBdg/Px9I53VIocL5DY0vInGcYAVQxycK8P2wabFbQt1Mg+g5PF2AcCyLLV4ruaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB6819
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

T24gVHVlLCAyMDIzLTAyLTIxIGF0IDEwOjU3ICswMTAwLCBKb2hhbm5lcyBCZXJnIHdyb3RlOg0K
PiBIaSwNCj4gDQo+ID4gPiA+IFNpbmNlIHRoZXJlJ3Mgbm8gYW55IGtlZXAgYWxpdmUgcGFja2V0
IGJlaW5nIHJlY2VpdmVkIGJ5IGhvc3QNCj4gPiA+ID4gc3RhY2ssIGxlYWRzIHRvIG1hYzgwMjEx
IGRlc3Ryb3J5IEJBIHNlc2lvbi4NCj4gPiA+ID4gDQo+ID4gPiANCj4gPiA+IE1vcmUgc3BlY2lm
aWNhbGx5LCB0aGUgQkEgc2Vzc2lvbiByZWxpZXMgb24gY2xpZW50IHNpZGUncyBUeCBkYXRhDQo+
ID4gPiB0bw0KPiA+IA0KPiA+IFR5cG8uLi4gSSBtZWFuICpvdXIgc2lkZSouIFNvbWV0aGluZyBs
aWtlIHRoaXMNCj4gDQo+IFNvcnJ5LiBJJ20ganVzdCB0b3RhbGx5IGNvbmZ1c2VkIC0gSSB0aG91
Z2h0IHRoZSBpbml0aWF0b3Igb25seSBzZXQNCj4gdGhlDQo+IHRpbWVvdXQsIGJ1dCBJIHNlZSBu
b3cgdGhhdCBpdCdzIG5lZ290aWF0ZWQgYW5kIHRoZSBhY3R1YWwgdmFsdWUgdXNlZA0KPiBpcw0K
PiBmcm9tIHRoZSBjbGllbnQuDQo+IA0KPiBXaGljaCBleHBsYWlucyBiYXNpY2FsbHkgZXZlcnl0
aGluZy4NCj4gDQo+IA0KDQpZdXAgLi4uIGFmdGVyIGFjY2VwdGluZyB0aGUgQWRkQkEgUmVzcG9u
c2Ugd2UgYWN0aXZhdGVkIGEgdGltZXIsDQoqcmVzZXR0aW5nIGl0IGFmdGVyIGVhY2ggZnJhbWUg
dGhhdCB3ZSBzZW5kKiAtDQpzdGFfdHhfYWdnX3Nlc3Npb25fdGltZXJfZXhwaXJlZCgpLg0KDQpU
aGUgLm5ldF9maWxsX2ZvcndhcmRfcGF0aCgpIG9mZmxvYWRzIHR4IHBhdGggdG8gSFcsIHNvIGl0
IGNhbiBvbmx5DQpyZWx5IG9uIG90aGVyIHdheSB0byByZXNldCBhcyBtYWM4MDIxMSBpc24ndCBh
d2FyZSBvZiB0aGF0Lg0KDQpSeWRlcg0KDQoNCg==
