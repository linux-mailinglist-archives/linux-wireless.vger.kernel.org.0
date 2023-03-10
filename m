Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBC196B3396
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Mar 2023 02:17:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbjCJBRg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 9 Mar 2023 20:17:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229801AbjCJBRa (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 9 Mar 2023 20:17:30 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 107F8C5628
        for <linux-wireless@vger.kernel.org>; Thu,  9 Mar 2023 17:17:22 -0800 (PST)
X-UUID: 4c61fa7cbee111eda06fc9ecc4dadd91-20230310
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=5eHL9GD3w6c5piWaJ+WHZbrimcBYcVVkR0mH+gOtkc4=;
        b=JIjxeWUMyBWsQV4shBVHr+vfHljQt0+7wlWwUmPl+n0LLH0gv72R0sbh9gARb77waQMbhREQOgVIq+UOe/V8psz4rf7TBkYCfuomAkpoH00vje+fyM6jfFdhRJQeFeMfHop6WKnEpvqa6EccBjJ4Z9AcBctjZ/uNP881/1dFqB4=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.20,REQID:7cd65914-a6f5-44ea-a83f-5b2704aa4364,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-INFO: VERSION:1.1.20,REQID:7cd65914-a6f5-44ea-a83f-5b2704aa4364,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
        elease,TS:-5
X-CID-META: VersionHash:25b5999,CLOUDID:ece8c7b2-beed-4dfc-bd9c-e1b22fa6ccc4,B
        ulkID:230310085035FNWT3EWD,BulkQuantity:5,Recheck:0,SF:38|17|19|102,TC:nil
        ,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:40,QS:nil,BEC:nil,COL:0,OSI:0
        ,OSA:0,AV:0
X-CID-BVR: 0,NGT
X-UUID: 4c61fa7cbee111eda06fc9ecc4dadd91-20230310
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <deren.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 932611777; Fri, 10 Mar 2023 09:17:17 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Fri, 10 Mar 2023 09:17:16 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n1.mediatek.com (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.25 via Frontend Transport; Fri, 10 Mar 2023 09:17:16 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JusTM2F9rs5kLN0+wkWTTk2rIZnNS7bmiBWqOth8a9vapKu3+iOgUBYWBmrCQI38pIe2fLKZaag7/YAxApM3kX0AVsdljlGroLZ5iKdHo+zvmfB4zQDRoirz8q+JccSQ8dMT7wbmqymubtq9ymmileVcU+6sm27b12dZoSCYq/hSEFU5lM+x+HhmspPZpxf+PcRn++pRoHRDYeLg41LlyskriCmhFSggF/EMVTYaMtAFqzRCUmS0lhvU5/t71a1lUECuvyqJfmeKmnZX1JnFe7oNW5nX7UveP+4EdDpTxZe2/qtNM2h+FzF06jtueDIB15FQVkT+FJ0hlKn46lt9eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5eHL9GD3w6c5piWaJ+WHZbrimcBYcVVkR0mH+gOtkc4=;
 b=E5WhmB0LjRm545kY/F9khMc8X2TIhedcWX8OgLWzjla053+8peaya2nPHT4Ox7HsWM1+/Sh/IX3ENr+wmphEvRDSlmrmjyU2yaXO9vCcICDs5EwYeVmt3oN9216oWlwDjqcXX+2cACmV9xwq+IbAxgx+6XKnnuSqBAFnqVEtvKuhdds+j+rFfDrweFqTIk3ZFtFyFLpC9+FTU4aTY4aN20geCKDXQAjIM1POUobrHfS6Y+faysd0WEJBnAHoE8f5p83e8qYzj9H3ADBGA9Fhnx8nHDtEwxJOQh47W6+F+sPJGqHY3YOP45H7YR/M7TwapLmwHubRqWjqjzg5gpQYcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5eHL9GD3w6c5piWaJ+WHZbrimcBYcVVkR0mH+gOtkc4=;
 b=oDKiDAN92+E4+ehAIGnIMFkqqfl7oaXF1o7Oxe4870A+Lp9B491sosxubIwYu6xnFwyaeQF+TyuJ9LgDn526DNvX4cK8ysq+Zb8XqQrEcKv9xdi4WCl/HA/O4CmJqTJlpUNmq+q5bGW9015UTaz0DaiOQofG4CZlMHTpZU+ufD0=
Received: from SI2PR03MB6194.apcprd03.prod.outlook.com (2603:1096:4:14e::9) by
 TYZPR03MB5883.apcprd03.prod.outlook.com (2603:1096:400:123::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19; Fri, 10 Mar
 2023 01:17:14 +0000
Received: from SI2PR03MB6194.apcprd03.prod.outlook.com
 ([fe80::bce2:8119:6bbf:cc07]) by SI2PR03MB6194.apcprd03.prod.outlook.com
 ([fe80::bce2:8119:6bbf:cc07%6]) with mapi id 15.20.6178.019; Fri, 10 Mar 2023
 01:17:14 +0000
From:   =?utf-8?B?RGVyZW4gV3UgKOatpuW+t+S7gSk=?= <Deren.Wu@mediatek.com>
To:     "greearb@candelatech.com" <greearb@candelatech.com>,
        "nbd@nbd.name" <nbd@nbd.name>,
        "lorenzo@kernel.org" <lorenzo@kernel.org>
CC:     =?utf-8?B?RXZlbHluIFRzYWkgKOiUoeePiumIuik=?= 
        <Evelyn.Tsai@mediatek.com>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?utf-8?B?TGVvbiBZZW4gKOmhj+iJr+WEkik=?= <Leon.Yen@mediatek.com>,
        =?utf-8?B?U2hheW5lIENoZW4gKOmZs+i7kuS4nik=?= 
        <Shayne.Chen@mediatek.com>,
        =?utf-8?B?U3RlbGxhIENoYW5nICjlvLXmm4nkvakp?= 
        <Stella.Chang@mediatek.com>, Sean Wang <Sean.Wang@mediatek.com>,
        =?utf-8?B?S00gTGluICjmnpfmmIbmsJEp?= <km.lin@mediatek.com>,
        =?utf-8?B?U291bCBIdWFuZyAo6buD6Iez5pi2KQ==?= 
        <Soul.Huang@mediatek.com>,
        =?utf-8?B?WU4gQ2hlbiAo6Zmz5b2l5a+nKQ==?= <YN.Chen@mediatek.com>,
        =?utf-8?B?UG9zaCBTdW4gKOWtq+eRnuW7tyk=?= <posh.sun@mediatek.com>,
        =?utf-8?B?RXJpYy1TWSBDaGFuZyAo5by15pu45rqQKQ==?= 
        <Eric-SY.Chang@mediatek.com>,
        =?utf-8?B?Q0ggWWVoICjokYnlv5fosaop?= <ch.yeh@mediatek.com>,
        =?utf-8?B?Um9iaW4gQ2hpdSAo6YKx5ZyL5r+xKQ==?= 
        <robin.chiu@mediatek.com>, Ryder Lee <Ryder.Lee@mediatek.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v2] wifi: mt76: mt7921: use driver flags rather than
 mac80211 flags to mcu
Thread-Topic: [PATCH v2] wifi: mt76: mt7921: use driver flags rather than
 mac80211 flags to mcu
Thread-Index: AQHZUOdIE6Gvpg2aOEOFn62Xr2FRvK7zMs4AgAAHeoA=
Date:   Fri, 10 Mar 2023 01:17:14 +0000
Message-ID: <ebee436e9aec0977eea089373c9e4ed145453ab3.camel@mediatek.com>
References: <0c2eed5226aef8e7e219c748b9d20cb234cf9f8f.1678186986.git.deren.wu@mediatek.com>
         <79728d21-400d-d294-f48e-a2ee091869bf@candelatech.com>
In-Reply-To: <79728d21-400d-d294-f48e-a2ee091869bf@candelatech.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR03MB6194:EE_|TYZPR03MB5883:EE_
x-ms-office365-filtering-correlation-id: fa5a0990-014e-45f2-ccc9-08db21052e92
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cFVtrYpZreSTKOHHf6KV9msSHt2RJgPJDtjxbjxmBUQjYnRbztKu4P3rq7HM0bJqaQZPZSnOnwf2pD0Qr1G0yA0I+vlFGG1kO0Bg5EfLHMSnInlxQq/sUKsMEyB3Ss+3wqaoTNFbFRwVob+5tX5b4e6G6FrdfO2m1u2P+YBqNyiXNTe4NnhyuyAP1ktdVBtyJrLrqiA8mRY6NGbcALW2g6EEbQKE4cAABpeljgBzMsED4w6+1aYr25PiCVoOxc+s0jj7ucwLFBREVEUqPXREw/O1ImM+xdO4VE/g/hgYsmekZLRqsex4qMIIkgPjnZ71WBKHsO5vftjrMGGNDs5fdUyChFhOXm1Y2k3yP7xK2HXVGiH0hA6kDBh+KUrnXBxzLX6lHxZIhJmH4M9OTeqgnKv9s+nDylefPQL72YILPqEtCC53TqKKel64lDLJmVIyudNNvm720diqjmPpwvmmTZ7oXeJlzs0IOaiawSncqf8bKS64DeIaxTqaVnJtlpE553PZ+f24h3YJl2BAEaBLtbUvIMAJ2ndGDJRyb50azeuqW3D2CBurIj9uccJfShWTO6ntBaX5eTLpmkWLC9zbS5GDUYFSlO1Q35+iWrt4eXgKYVbDyhpBfBeZLp90n91urm2FG5G9MZg73yCmwIfj4pUqUeKlUXpqg2MPZC0P1WzEXPej2E7sDfCqtNgLMZbAVvdQUSWn7ak4l267xpnI4Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB6194.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(376002)(39860400002)(396003)(366004)(136003)(451199018)(85182001)(36756003)(5660300002)(83380400001)(26005)(6486002)(71200400001)(6506007)(6512007)(2616005)(53546011)(186003)(478600001)(38070700005)(91956017)(4326008)(8676002)(66946007)(76116006)(66476007)(66556008)(66446008)(8936002)(64756008)(41300700001)(86362001)(110136005)(54906003)(316002)(38100700002)(122000001)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SWpVTzFyVmpYeUlHeWlMOHBBcm01c2kyTytKOVlQWmdpcnAyalZLVlRxSXRK?=
 =?utf-8?B?VDRaZTVmaFlGYVZJd3hsOVA0bVNBYXkweGxJWGtySXNjWFRTZVo2ZXk1SkJI?=
 =?utf-8?B?VlM4aWNMOGNYY1ZpWkdxWDN0OEtnYzBLcy9jL2N4b0hiWVRhVGxPb290cmxU?=
 =?utf-8?B?aXZPNHU3bjVXcTBXK3JEY05nUitJRE8raDhPZjJiRU5JRDV1bGs4RUhZaEZM?=
 =?utf-8?B?cVFUTmVsUFhWVUdXdDhrbE9oSWxzanowR3cvOG56QThTeXkrL24wMkJ1ZzBn?=
 =?utf-8?B?N2lqSDFMczA1Wi9IY0N1NzBZUXd0U2svbDBKVnMyTm5jZTBSMlIrL0JGaDJO?=
 =?utf-8?B?dXozNzJZeGpHZ0dsVFV1N0E4TVhodVRVSlBMRnd5N0hncmFObTI0bjF6YjFk?=
 =?utf-8?B?TlBqMkdyVkprSXh4RWJrWTdWU2E1bWVNOGJKQkJ4d2x6aWo4U3BRN2prc1h5?=
 =?utf-8?B?UTBxdEpiVXcweDA5MzVhK2N1aTZ3TUd6ekx0dDAvanBYM1R4ZWw4ZzNYdldD?=
 =?utf-8?B?Y0NvSHdVMklXU0t1dlhpN0hRVVN2ZSs0NzgxRHRVMER0YTJ2L2J2b3ZLYnY3?=
 =?utf-8?B?bytaWm1UWHVLMUNETC8xR2tYeitiNVdITERqV3pCR3RGekhiK3V6TVd5aEc5?=
 =?utf-8?B?VjBVSFN5M1BmdVREcXhkVXpUVkpYR0I2andjMXI0ZmgvcmtoTEdyeTBaWHUx?=
 =?utf-8?B?YURCLzdyWTllZ0dNaVQvUG81YlpRS2IwWnVkWEt3VDcweUVNU2N1TzFsdzBH?=
 =?utf-8?B?UEM2MzBMOHNXbXk2cWt4cTFzU0hPMnJjakdvbjF6YUp5SmRQWTZVSHFtL1hj?=
 =?utf-8?B?aHNTZitrR0tUYXdQQVlGSkNaZ0xGNTV2ZlpqclRRekZCUzcwK210VE02R1B2?=
 =?utf-8?B?NFYrR2RaV3c1RXRIVUNzMlZDaTY2YlFxZVJuZ3Y2aW9xSm9oNm1HaFE5RWlx?=
 =?utf-8?B?aXg5bGNEWkd1WStZUUtWS0RTNGd2c3Z5TWZkRlgvY0o5WEl2TTdwNFVTNVlE?=
 =?utf-8?B?ZHJGWTljQkp4MlJDN1hpTEQ0eTA2eGFoa0xYcEhnNkNEajFZWEJVcEwvMmF3?=
 =?utf-8?B?eVhlVG5Jd0R1WnZQdzRvMXFZOW5reTR1S0gzam0xNUZKM3ZzOXBBWi9HNk5u?=
 =?utf-8?B?NmdTYjFiRTA0aG1HR0RKRWpIN0dPS2x5UGhRNk1mWk5ZTysrT2Z0NDJUa2hR?=
 =?utf-8?B?ZldOM1F6WUFQeUFiOXFtOCs5NHhMejBjL3IvUHN4RGJpREdpLzdjR2R2OXdN?=
 =?utf-8?B?NzJwWXpOdWI3WitGd1YxczZ5TkZzeERJZHE2b1psSmN6b2hUZktoTjlLQng1?=
 =?utf-8?B?UDNZbzJGWFBDdUhKK2Q0ZjdLeTNRRHM4M0poZWtVU1dEbEFMS0JLckNVVWVo?=
 =?utf-8?B?TU9LK09kczM1RDErUnh0T2pjby8xUkFuMlRvQ0RtUnN5cE1rZU1Id084cHpN?=
 =?utf-8?B?cGdHU20zK28wczA3Y0ZkblFDdGZKOGRGUzd1RGYxS0dWdzQyS0hsQ0hWKy9m?=
 =?utf-8?B?bUx4bkg0NVorWTBYdVpXb3NVTERjYjJoQm03dVJJMjZtaUxFV3gxU3ZvOTJ6?=
 =?utf-8?B?eFU3TzR4KzVtSnl5V1pVemIwaXh5T2ZKelZjN1ZTWlpzaG5vSnQwUGVFRXJW?=
 =?utf-8?B?VkZsNTIrcDdkVEFvOTlKMkhLdkd0Y0hqaGpIY0VFeVgxbFM2RVhqVTdpYzc5?=
 =?utf-8?B?TEdlTnJoZUlzQ25XQTFCS3pobm1PSXE4d2xyeG53RXJCMTJZQnJBaUFRZW9o?=
 =?utf-8?B?Y3VKblRzTDhUUjlvYVB6S21WR21ZU3gwa0FkTmF6d1VvMFJBOUw5NjBXK0Fv?=
 =?utf-8?B?RXRFUXdBbWlPa09JMUZLYlFtTFdKY1IyeXE2UXdVWGdTN0FjSU1xZmw5Z2Y1?=
 =?utf-8?B?dVFhV3kyQ210SE9NcVNCQlRpZU1NTUJ4M0hDYmVkUUVZWlVUS3k2UnM2TUlw?=
 =?utf-8?B?L1JlUkF0V3FITEZiZXczb3ZRdGVETnNvang5bHZkbzg0QlZzVUJua1RUb3pa?=
 =?utf-8?B?UWtiUzRBSndYYktpZU13cVh2L0huVU01d0piSzVSNzdFREQxOEJiVFFNUnpT?=
 =?utf-8?B?REJSSEFRWmJhaEhERlk2cTJ5NFpIVFhsbjlzZEw0SEYxdThuMStzUFZleVp3?=
 =?utf-8?B?Wko0cUhPRFo0U1FBeXg1cHA3OENraU12SnhVYzl5MmpMSHpGbVhCTWZEOGMr?=
 =?utf-8?B?Tnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <61986210CB078045B78E05B18B87CB13@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB6194.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa5a0990-014e-45f2-ccc9-08db21052e92
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2023 01:17:14.2513
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 67F5Ai8Fbm6/zSAAsPqSCdwAatMwUx2VJeoPKPYGSc12Lt8lpEkypOjwEMkrcsP/3e5dRy1D8U8b1/RoD55XTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB5883
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

T24gVGh1LCAyMDIzLTAzLTA5IGF0IDE2OjUwIC0wODAwLCBCZW4gR3JlZWFyIHdyb3RlOg0KPiBP
biAzLzcvMjMgMDM6MjIsIERlcmVuIFd1IHdyb3RlOg0KPiA+IEZyb206IE5laWwgQ2hlbiA8eW4u
Y2hlbkBtZWRpYXRlay5jb20+DQo+ID4gDQo+ID4gRklGXyogZmxhZ3MgZnJvbSBtYWM4MDIxMSBp
cyBub3QgQUJJLiBtdDc5MjEgc2hvdWxkIG5vdCBwYXNzIGl0DQo+ID4gaW50byBtY3UNCj4gPiBk
aXJlY3RseS4gUmVtYXAgRklGXyogdG8gZHJpdmVyIGRlZmluZWQgZmxhZ3MgYXMgbWN1IGNvbW1h
bmQgaW5wdXQuDQo+ID4gDQo+ID4gRml4ZXM6IGMyMjJmNzdmZDQyMSAoIndpZmk6IG10NzY6IG10
NzkyMTogZml4IHJ4IGZpbHRlciBpbmNvcnJlY3QNCj4gPiBieSBkcnYvZncgaW5jb25zaXN0ZW50
IikNCj4gPiBTaWduZWQtb2ZmLWJ5OiBOZWlsIENoZW4gPHluLmNoZW5AbWVkaWF0ZWsuY29tPiA+
IFNpZ25lZC1vZmYtYnk6DQo+ID4gRGVyZW4gV3UgPGRlcmVuLnd1QG1lZGlhdGVrLmNvbT4NCj4g
DQo+IEkgdHJpZWQgdGhpcyBwbHVzIHRoZSBwYXRjaCBpdCBpcyBmaXhpbmcgb24gNi4yLjIrIGtl
cm5lbCB3aXRoIDc5MjINCj4gcmFkaW9zLA0KPiBhbmQgYmVoYXZpb3VyIHNlZW1zIHdvcnNlIHRo
YW4gYmVmb3JlIHRoZSB0d28gcGF0Y2hlcyB3ZXJlIGFwcGxpZWQuDQo+IA0KPiBPcmlnaW5hbCBw
cm9ibGVtIEkgd2FzIHRyeWluZyB0byBmaXggaXMgdGhhdCBteSBTVEFzIHdpbGwgY29ubmVjdA0K
PiBmaW5lIG9uIDVHaHosDQo+IGJ1dCB0aGVuIHdoZW4gSSB0cnkgdG8gbW92ZSB0aGVtIHRvIDIu
NEdoeiwgbW9zdCB3aWxsIG5vdCBzY2FuDQo+IGFueXRoaW5nLg0KPiBQYWNrZXQgc25pZmYgc2hv
d3MgcHJvYmUgcmVzcG9uc2VzIGFuZCByZXF1ZXN0cywgc28gSSBzdXNwZWN0ZWQNCj4gZmlybXdh
cmUgaXMNCj4gZmlsdGVyaW5nIHdoZW4gaXQgc2hvdWxkIG5vdC4NCj4gDQo+IFdpdGggdGhlIHR3
byBwYXRjaGVzIGFwcGxpZWQsIGV2ZW4gNUdoeiBpcyBzaG93aW5nIGZhaWx1cmUsIHdpdGggbG90
cw0KPiBvZg0KPiBiZWFjb24gbG9zcyBtZXNzYWdlcyAoSSBhbSBkaXNhYmxpbmcgYmVhY29uIGZp
bHRlcmluZywgd2hpY2gNCj4gcHJldmlvdXNseSB3b3JrZWQNCj4gZmluZSBvbiA3OTIxIG5pYyBp
biA1LjE5IGtlcm5lbCkuDQo+IA0KPiBBcmUgdGhlcmUgb3RoZXIgcGF0Y2hlcyB0aGF0IEkgc2hv
dWxkIGNvbnNpZGVyIHRvIGdldCA3OTIyIHRvIHdvcmsNCj4gYmV0dGVyIGluIDYuMi4yKw0KPiBr
ZXJuZWw/DQo+IA0KPiBbcm9vdEBjdDUyM2MtM2I3ZiB+XSMgY2F0IC9kZWJ1Zy9pZWVlODAyMTEv
d2lwaHkwL210NzYvdmVyc2lvbg0KPiBjaGlwc2V0OiAgICAgICA3OTIyDQo+IEFTSUMtUmV2aXNp
b246IDB4NzkyMjAwMTANCj4gaHdfc3dfdmVyOiAgICAgMHg4YTEwOGExMA0KPiBidWlsZF9kYXRl
OiAgICAyMDIyMTIyNzEyMzE1NGENCj4gYnVzOiAgICAgICAgICAgMDAwMDowNDowMC4wDQo+IGZ3
Y2ZnOiAgICAgICAgIGZ3Y2ZnLW1taW8tMDAwMDowNDowMC4wLnR4dA0KPiBXTS1od19zd192ZXI6
ICBfX19fMDAwMDAwDQo+IFdNLWJ1aWxkX2RhdGU6IDIwMjIxMjI3MTIzMjQzDQo+IFdBLWh3X3N3
X3ZlcjoNCj4gV0EtYnVpbGRfZGF0ZToNCg0KSGkgQmVuLA0KDQpUaGUgaXNzdWVzIHlvdSBtZW50
aW9uIGFyZSBtb3JlIGxpa2Ugb3RoZXIgcHJvYmxlbXMgaW4gZmlybXdhcmUgc2lkZS4NCldlIGRp
ZCBmaXggdGhlbSBpbiBtdDc5MjEgZmlybXdhcmUgYW5kIHBsYW4gdG8gcG9zdCA3OTIyIHZlcnNp
b24uIEkNCndpbGwgdXBkYXRlIHRoZSBwcm9ncmVzcyBzb29uLg0KDQpSZWdhcmRzLA0KRGVyZW4N
Cg0KPiANCj4gDQo+IFRoYW5rcywNCj4gQmVuDQo+IA0K
