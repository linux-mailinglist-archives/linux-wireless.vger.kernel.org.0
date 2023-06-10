Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26BDB72AC6B
	for <lists+linux-wireless@lfdr.de>; Sat, 10 Jun 2023 17:00:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232011AbjFJO7t (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 10 Jun 2023 10:59:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230311AbjFJO7r (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 10 Jun 2023 10:59:47 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1986230F8
        for <linux-wireless@vger.kernel.org>; Sat, 10 Jun 2023 07:59:42 -0700 (PDT)
X-UUID: 6be3d3b4079f11ee9cb5633481061a41-20230610
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=jMivncOSuCRR69J6uMyievXdhQArezQQb2j+ekgg5Bk=;
        b=oLxGsw2Y3m/XPDP3raMIhAlfsGQYxRU78akdeWAp0UNd+whX2vaDdUfcDbTsvVcuWhXsvq9+75WBm3jFAkyDS7Dsyw69WdRsnolywhzFzpD3S+o5CGZFWlzwhbRvvzecx+LbbbSByoEjHj0gSNLvt082gruBltKcbU+9dKWVcV0=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.26,REQID:1b69e505-c8d5-40df-ae52-a23b66fa772b,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:45
X-CID-INFO: VERSION:1.1.26,REQID:1b69e505-c8d5-40df-ae52-a23b66fa772b,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
        elease,TS:45
X-CID-META: VersionHash:cb9a4e1,CLOUDID:f0f1013e-de1e-4348-bc35-c96f92f1dcbb,B
        ulkID:230610001557551Q2D5O,BulkQuantity:33,Recheck:0,SF:38|29|28|17|19|48|
        102,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:40,QS:nil,BEC:nil,C
        OL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_SDM,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,
        TF_CID_SPAM_OBB
X-UUID: 6be3d3b4079f11ee9cb5633481061a41-20230610
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 916517034; Sat, 10 Jun 2023 22:59:38 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Sat, 10 Jun 2023 22:59:37 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Sat, 10 Jun 2023 22:59:37 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bFKoOz5jB/QBLUPefrOv6xtOW4BwmyoRTBHxAqtQfGSXLOexFU17tKgocfx5w4v8qVgiJVKJWKEs30085EZ2xRqjR1d85Q6cyMwS/iAbhk/SWF5rrwEIV+UCcHmU5V2N0spY2CXg7VyHRPEWE0/sbUN4JEza7F8oCJLnUL3+cXwWk7i+STlG172bTtHua8ljSMgLC6R3uCj6qrj+9kvAiA3cEuizVkjChIvE20VBIMC4QWATOR4wE/EtABMi41MfhTQOVICdtgnC/Q+07CH1ocZxGtmgL9B9KfzcJfQmFVIuOk0Kcwpcz3vWgkSsjTDkZiHGwef1l7lOhCwMmorEYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jMivncOSuCRR69J6uMyievXdhQArezQQb2j+ekgg5Bk=;
 b=aCF4QYfNgBKlCiXjIGXmxMgGjIrm3NTNOe0uG9Jjgzo6tTWXT+vpOU9K1UtQ8/6RMgVJvPDAITKJvZbvtTAI174iQe3+y/MOAKH6sOCoMmcebeO9/HDTRdelWwIX3AFeXU454fnucOVfEuxC9YpZGPno/lNeUAkC42jToT6Ws5OZqcLwzOBvK5Uep/LuiWL20DO6GVZEHR0c8svlK5CQinVlYNf2NAeTbh/cHM8rj4KYqPCrd/IUC77FeAh2xjyrKw8GEMPyDPb6zKja6fY4g8vJGruG5rwUC50/wh1tBenz36f48YleITlpoNBp/nCwty+y3shXZzBqvnGBOQfKyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jMivncOSuCRR69J6uMyievXdhQArezQQb2j+ekgg5Bk=;
 b=UXDvsOCSvJ1LJVz5yFoL7++Z2L3JaQRrHCdECxjTtGmrsDZ5IMe/dIa4SdYxNlbJ2ERgULWjsouCs3n9UZ56nHgg9TX5kEqYwCGiJhIzErANi6hxA6ZP78nOGpOYWkgHEg9xLZxyrCMafRSLyJKhCkacYYOiJt8YVDgihrs40Ek=
Received: from TY0PR03MB6354.apcprd03.prod.outlook.com (2603:1096:400:14a::9)
 by KL1PR03MB7260.apcprd03.prod.outlook.com (2603:1096:820:9c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.29; Sat, 10 Jun
 2023 14:59:32 +0000
Received: from TY0PR03MB6354.apcprd03.prod.outlook.com
 ([fe80::7f66:e6d5:9578:c978]) by TY0PR03MB6354.apcprd03.prod.outlook.com
 ([fe80::7f66:e6d5:9578:c978%2]) with mapi id 15.20.6477.028; Sat, 10 Jun 2023
 14:59:32 +0000
From:   Ryder Lee <Ryder.Lee@mediatek.com>
To:     =?utf-8?B?U2hheW5lIENoZW4gKOmZs+i7kuS4nik=?= 
        <Shayne.Chen@mediatek.com>,
        "lorenzo@kernel.org" <lorenzo@kernel.org>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "lorenzo.bianconi@redhat.com" <lorenzo.bianconi@redhat.com>,
        "nbd@nbd.name" <nbd@nbd.name>,
        =?utf-8?B?RXZlbHluIFRzYWkgKOiUoeePiumIuik=?= 
        <Evelyn.Tsai@mediatek.com>,
        =?utf-8?B?RGVyZW4gV3UgKOatpuW+t+S7gSk=?= <Deren.Wu@mediatek.com>
Subject: Re: [PATCH v2 15/15] wifi: mt76: connac: add connac3 mac library
Thread-Topic: [PATCH v2 15/15] wifi: mt76: connac: add connac3 mac library
Thread-Index: AQHZmqriDZefVRx/SEe6qlAreeLN3a+CpeOAgAAFVwCAAAEYgIABJIWZgAA+lwCAABOOgA==
Date:   Sat, 10 Jun 2023 14:59:32 +0000
Message-ID: <681d80909333d7b3f45ca799e3d229913d089320.camel@mediatek.com>
References: <cover.1686298162.git.lorenzo@kernel.org>
         <b7a029d6dfee8e58c58f483ea9e9e7b3bc8012b9.1686298162.git.lorenzo@kernel.org>
         <5010e5e508e89041451288659390fde5ded94db5.camel@mediatek.com>
         <ZINUnqkElqSOITxT@localhost.localdomain>
         <82971c76999ae90be44a524fb95141c5051a9ba0.camel@mediatek.com>
         <ZINXGP6TmDLaZ+lu@localhost.localdomain>
         <PH8PR12MB7230DC95457EF9C667E679AEAC51A@PH8PR12MB7230.namprd12.prod.outlook.com>
         <3cae89c45b0f17eaab20876eb50572ef202f92bc.camel@mediatek.com>
         <d58e857d79ee13752c4d770f80634b2f6c817aa8.camel@mediatek.com>
         <ZIRLJ/8gt5l/2JAt@localhost.localdomain>
         <02adfd744e7aa9ca33015704b48d1e1c29c9a2c7.camel@mediatek.com>
In-Reply-To: <02adfd744e7aa9ca33015704b48d1e1c29c9a2c7.camel@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY0PR03MB6354:EE_|KL1PR03MB7260:EE_
x-ms-office365-filtering-correlation-id: 11c77316-5881-4fac-5308-08db69c34c35
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: I9elrwPWarPoBa0dRBlCXO5cu1tjsr1HXFI+xh1yvtThyyaKAHvx51N3y+7U9MG9Plpb8NM3ogPEDdkjJVuL5ZyZBvYz8Lj7vbCtXixoQ6Lw6PZuiUOm74d/tQDuq6FEfe0X4g54mkEdbmHv4E24oSM4wvhBR0GZ8DY7+MOQkb1dOHSApKJV2Ll061oTPPTYn+6hDnNK8BVpPKA7Li2JBqUrh2smHvEYV6lNIfrgDYhlIanWvuzV17sHA4maIujUJyQ+Ax6bAHdQUTvJ8ibB9EurU3ZXwMNqlLJnf5xIr3rqdN9cku+GpzOiu7fQ3ojmx6AjZeTI0T5yUfKslEWADmPnEH4PeEcaXTwZMzTnri0rZKATWaSvthFhdNcX0pXEur77QyTjptcrEFNUB6mJofO/KRpBQ31yKiZWRNt0EcWfCyLxQRz7H6SLhFPeVY/bs5BehpBM8f256q/t850BQTlkM77sCuxtcpN9RmgPlEJHoajp4Xr0XYkhYiWjpUs+cpIVx1tB7LuOmIK04Jf+oKmN98emnUc+k3jPVjvoJwAe5VYZ/BONYyxfeOIeB7ZLfb2MD7pg/ipljMj9QbsS5nIsMKbRlxCt6uET30W+XJxcwkVfw3lzgl9FKT4sVfCKXA1uGt/KgVnraLlKkVZyZKuyOVKS0Mo7jJ1iHL65CL0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY0PR03MB6354.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(39860400002)(396003)(136003)(376002)(451199021)(4326008)(64756008)(66446008)(66556008)(66946007)(316002)(66476007)(76116006)(41300700001)(186003)(2906002)(110136005)(54906003)(478600001)(8676002)(8936002)(5660300002)(71200400001)(6486002)(107886003)(6512007)(6506007)(122000001)(26005)(83380400001)(36756003)(86362001)(38070700005)(2616005)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cWc2Vlcrc1FGQVVEb0ZFRkMzRktsdVp5Q1NzS0hYUTBFV0dtVFkwdVFraXJh?=
 =?utf-8?B?VVZmZGpwWTJyZWgzekZ3WHdzRFdON2xkOEhtRmw2RUNiWTFJYTQwNDdHeGJn?=
 =?utf-8?B?ZFo0N3g4WkR5MExFYWRHZGdxR3ZFMW5weHJyV0hVOW1hYVk0ZXhyUlpMbHUz?=
 =?utf-8?B?UXRHOXJSMWVBSWtuVHQzL0VZMjJ1aC9KLzVyaFZFRU5SeG43NXN3bXdCUHNM?=
 =?utf-8?B?aUFhMmVZSTZTNXF0aExsRFlRa3lsQU9IL09kQU9vWTJqNVFSZU52YzRxb05K?=
 =?utf-8?B?ZFAvQStVMHE5YVJmZFNsbGJ0RVVyRTJmNmpUZjFteGdrZHJ6RnpkZjhnVWdZ?=
 =?utf-8?B?YTJRQUg0QzdQWExXMHJUVGdRQ294dDNucEQ2Vk5haEF1M2twMWYzVTc5RjZJ?=
 =?utf-8?B?QkVXOUtwTnd3WWNneTFUUmhjbEkyNkZGc3FhMlBVUXdoS0RNa1E0aHIzRExI?=
 =?utf-8?B?UGI3Y2oyaWZhbU5UdmQ0bkpvRFI2azRQbFA3ZDZaRkFmS2JldW9CNGlxTFNX?=
 =?utf-8?B?T2RCd0ZCVU9MSzEybWxldVRCb1paRTdOWE1VQ254dWE2clEyTEpkTWlEMm11?=
 =?utf-8?B?SGRoNWRPc3pGdzNmK3hkaEtncFlkU2tUWVhTMGJXc2htMDRWSHFoZmRWdUtk?=
 =?utf-8?B?RXY1Wk9NZHhpbnhSQ1pFVTdvY2VkNjhBblFkTFh3akthWmdQVVc2cUxMcGs1?=
 =?utf-8?B?WDF0cWR3VnNiTXpyN2IwK1lJZXZhS0JwV094WkVlZEh3SnhqRjQ2VXk0SUpv?=
 =?utf-8?B?UitrUUNGMVVzKzlFdkJENEQxOEN6ZlZidGFKR1FUekFFR1VEVjNQdy85Yzl6?=
 =?utf-8?B?bWd6VXlrRWZYcnp0OXdNNFJETEhsSFFEUGszN2xiWmpGQ05WTnVRNURxN2wv?=
 =?utf-8?B?Z3ZLZytOR1dnMjE4V09kek1sc3pxQURJeTJpZ3BDbURQN1AzbG1ad1B4U1oy?=
 =?utf-8?B?RWtTQ1dBaWRlMll6TTVUVFIvdEtuSTlxRnNVeitEcEVaN2NtVDlSdCt3Qmow?=
 =?utf-8?B?cVE4Q05PN3lEUXJocmJ6NGcvYXNBSTlSdFovVGl4MGJtY2M1K2pFNk9qTzlz?=
 =?utf-8?B?ZHNvYlFzVXRPNVJWTEJVRW1hMG1IU0FOVHcrNUR5dFdxOE9jNStCYW1SSGds?=
 =?utf-8?B?Z0JrOERRZ1pZaFBoT2JHNTB6RDFwY1AxVHBFejh2T24wdFk2cWw3Vm11TFpP?=
 =?utf-8?B?bjZGaGdiZE1NZmQzd09oVkJrbGZyVldwMStwd3RnRmVtM253dkkrSXhTUjJE?=
 =?utf-8?B?TS8wbURPSEJxNlcvZTZLYThiaUcvdFlwMWhHVUJFOHJ5cjlnQjJEMS9DWEQ1?=
 =?utf-8?B?NGdZOSs4QzdwQmQybXNwSWNFS3FISzJIVDFCSzhuWFRwc3JzWVUvWElHQlF3?=
 =?utf-8?B?Mm9YdDhXTnhlMmhVUkptZFVlajVQZ3o5VW13bUovb21lcWF1Y1cwTC81N2h6?=
 =?utf-8?B?Zkg3M3NKZnRlVks1QTdOSE1zY1dESHdyNGFSUktmOXovVVFQZ1dRRVJXZU1q?=
 =?utf-8?B?bWdVMzhjZG5BU2RkQ3dlNytxQm1wMFc0MFVXVFZhcjU4MS9iU1h1V09nWFpV?=
 =?utf-8?B?NVoybnkyTEM2OEU5VFAya2ZzemRpUUtodXcrdHZubERQdGp3YzRFWVFoRXkx?=
 =?utf-8?B?MmtCbkdFSDFQbDA5RWRiUnhhNVpVK3NyNGxGM0U4RVFiSlNiUTd6RkNmV0JQ?=
 =?utf-8?B?MXpIdkFoeFJjT0twclBzS3A5VGJ3cHVlOE96L0xFcmlEdWhUejlsWWVWbHlv?=
 =?utf-8?B?Z2dnakJyWk9pU3ZEYVI0c2x6QWJib0NnOWdvZnBHcWhkNVdOV21udGxUTnFG?=
 =?utf-8?B?WlVFRmlya3F6TllocDBaeWlhSG5jaVZFbDBRUnFwUXREY0Z1M3VmMENwNE5K?=
 =?utf-8?B?Y2FPRCtFdUlkaE1nY1ZDeHoreDNBK0Y1MDQrU3Z4YmFKUFpVZmhnQVNaekt6?=
 =?utf-8?B?YjQvSmo0WFBvSFBnYnpGb0xCTVNpN2dCYzU2cUQ0aVBqVlpINWorT2l3QWpV?=
 =?utf-8?B?Y3FodzlkL2RNMVVsQm5SeHVqRXJVb1FUaE1DT3haMmU1QXFmLzJvdjFXQWxx?=
 =?utf-8?B?NWdjQVJvNGlwK0lHSkpTclpkNGVvRnhIamlEZk5BaW5hNFk2MHdrckxNQWJM?=
 =?utf-8?B?WWF4eWFhTVFZZ2tsbFVITkFuSHBIb1RvSDIxSVN2Szh4ZmxJeTZxb28wQkVm?=
 =?utf-8?B?bWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <525A1A1468E2F44BB1512CE8621A84ED@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY0PR03MB6354.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11c77316-5881-4fac-5308-08db69c34c35
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jun 2023 14:59:32.0711
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ADzhCqoEb8JBd4uTYNS7Y24rmXdoclQH1jJn147eSOnXBwP+CaFuxoFt/y1EdCYJdLNwqQLOg0F0z03/4SxVyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB7260
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

T24gU2F0LCAyMDIzLTA2LTEwIGF0IDEzOjQ5ICswMDAwLCBTaGF5bmUgQ2hlbiAo6Zmz6LuS5Lie
KSB3cm90ZToNCj4gT24gU2F0LCAyMDIzLTA2LTEwIGF0IDEyOjA2ICswMjAwLCBsb3JlbnpvQGtl
cm5lbC5vcmcgd3JvdGU6DQo+ID4gPiBPbiBTYXQsIDIwMjMtMDYtMTAgYXQgMDI6NDcgKzA4MDAs
IFNoYXluZSBDaGVuIHdyb3RlOg0KPiA+ID4gPiA+ID4gT24gRnJpLCAyMDIzLTA2LTA5IGF0IDE4
OjM0ICswMjAwLCANCj4gPiA+ID4gPiA+IGxvcmVuem8uYmlhbmNvbmlAcmVkaGF0LmNvbQ0KPiA+
ID4gPiA+IA0KPiA+ID4gPiA+IHdyb3RlOg0KPiA+ID4gPiA+ID4gPiBPbiBKdW4gMDksIFJ5ZGVy
IExlZSB3cm90ZToNCj4gPiA+ID4gPiA+ID4gPiBPbiBGcmksIDIwMjMtMDYtMDkgYXQgMTA6MTUg
KzAyMDAsIExvcmVuem8gQmlhbmNvbmkNCj4gPiA+ID4gPiA+ID4gPiB3cm90ZToNCj4gPiA+ID4g
PiA+ID4gPiA+ICAgDQo+ID4gPiA+ID4gPiA+ID4gPiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBk
byBub3QgY2xpY2sgbGlua3Mgb3Igb3Blbg0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IGF0dGFjaG1l
bnRzIA0KPiA+ID4gPiA+ID4gPiA+ID4gdW50aWwgeW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRl
ciBvciB0aGUgY29udGVudC4NCj4gPiA+ID4gPiA+ID4gPiA+ICBJbnRyb2R1Y2UgY29ubmFjM19t
YWMgaW4gbXQ3Nl9jb25uYWMgbGlicmFyeSB0bw0KPiA+ID4gPiA+ID4gPiA+ID4gcmV1c2UNCj4g
PiA+ID4gPiA+ID4gPiA+IG1hYw0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IGNvZGUgDQo+ID4gPiA+
ID4gPiA+ID4gPiBzaGFyZWQgYmV0d2VlbiBXaUZpNyBjaGlwc2V0cy4NCj4gPiA+ID4gPiA+ID4g
PiA+IA0KPiA+ID4gPiA+ID4gPiA+ID4gU2lnbmVkLW9mZi1ieTogTG9yZW56byBCaWFuY29uaSA8
bG9yZW56b0BrZXJuZWwub3JnPg0KPiA+ID4gPiANCj4gPiA+ID4gSGkgTG9yZW56bywNCj4gPiAN
Cj4gPiBIaSBTaGF5bmUsDQo+ID4gDQo+IA0KPiBIaSBMb3JlbnpvLA0KPiANCj4gPiA+ID4gDQo+
ID4gPiA+IEkgZG9uJ3QgdGhpbmsgaXQncyBhIGdvb2QgaWRlYSB0byBzdGFydCBzaGFyaW5nIG1h
YyBvciBtY3UNCj4gPiA+ID4gZnVuY3Rpb25zDQo+ID4gPiA+IGZvciBhbGwgV2lGaTcgY2hpcHNl
dHMgYXQgc3VjaCBlYXJseSBzdGFnZS4NCj4gPiA+ID4gDQo+ID4gPiA+IFRoZSBkcml2ZXIgaXMg
c3RpbGwgdW5kZXIgbWFueSBwcm9jZXNzZXMgb2YgYnVnIGZpeGluZywNCj4gPiA+ID4gcGVyZm9y
bWFuY2UNCj4gPiA+ID4gdHVuaW5nLCBhbmQgbmV3IGZlYXR1cmVzIGRldmVsb3BtZW50Lg0KPiA+
ID4gPiBDaGlwc2V0cyB0aGF0IG1haW5seSB1c2VkIGZvciBBUCBvciBTVEEgc2VnbWVudCBoYXZl
IGRpZmZlcmVudA0KPiA+ID4gPiBkZXNpZ25zDQo+ID4gPiA+IGFuZCBzaG91bGQgZmFjZSBkaWZm
ZXJlbnQgcHJvYmxlbXMuDQo+ID4gPiA+IA0KPiA+ID4gPiBTdGFydCBzaGFyaW5nIHRoZSBjb2Rl
IGF0IGVhcmx5IHN0YWdlIHdpbGwgYnJlYWsgdGhlDQo+ID4gPiA+IGluZGVwZW5kZW5jZSwNCj4g
PiA+ID4gbWFrZQ0KPiA+ID4gPiBpdCBtb3JlIGhhcmQgdG8gZGV2ZWxvcCBhbmQgZG8gdmVyaWZp
Y2F0aW9ucywgc2luY2UgbWFueQ0KPiA+ID4gPiBjaGFuZ2VzDQo+ID4gPiA+IHdpbGwNCj4gPiA+
ID4gYWZmZWN0IGNoaXBzZXRzIG9mIGJvdGggc2VnbWVudHMuDQo+ID4gDQo+ID4gbXkgZ29hbCBp
cyB0byBzaGFyZSB0aGUgY29kZSB0aGF0IGhhcmRseSB3aWxsIGJlIGNoYW5nZWQgKG9yIHRoYXQN
Cj4gPiB3aWxsIGhhdmUNCj4gPiB2ZXJ5IGZldyBjaGFuZ2VzIGluIHRoZSBmdXR1cmUsIGkuZS4g
SSBoYXZlIG5vdCBjaGFuZ2VkIG1jdQ0KPiA+IGNvZGViYXNlKS4NCj4gPiBJZiB5b3UgY29uc2lk
ZXIgZm9yIGV4YW1wbGUgdGhlIHJvdXRpbmVzIGJlbG93Og0KPiA+IA0KPiA+IC0gbXQ3Nl9jb25u
YWMqX21hY193cml0ZV90eHdpXzgwMjMoKQ0KPiA+IC0gbXQ3Nl9jb25uYWMqX21hY193cml0ZV90
eHdpXzgwMjExKCkNCj4gPiAtIG10NzZfY29ubmFjKl9tYWNfYWRkX3R4c19za2IoKQ0KPiA+IC0g
bXQ3Nl9jb25uYWMqX3R4d2lfZnJlZSgpDQo+ID4gLSAuLi4NCj4gPiANCj4gPiB0aGV5IGFyZSB0
aGUgc2FtZSBmb3IgbXQ3NjE1L210NzY2MywgbXQ3OTIxL210NzkxNSwgbXQ3OTk2Ly4uICwNCj4g
PiB3aGF0DQo+ID4gaXMNCj4gPiBjaGFuZ2luZyBpcyBqdXN0IHJlZ2lzdGVyIG1hcCBiZXR3ZWVu
IHZlcnNpb25zIChlLmcuIG10NzYxNS9tdDc2NjMNCj4gPiBhbmQNCj4gPiBtdDc5MTUvbXQ3OTIx
KS4gSSB0aGluayBpdCBpcyBub3QgYSBnb29kIGlkZWEgdG8gY29weS1wYXN0ZSB0aGUNCj4gPiBj
b2RlDQo+ID4gYmVjYXVzZSBpdCB3aWxsIGp1c3QgbWFrZSB0aGUgY29kZSBtdWNoIGhhcmRlciB0
byBtYWludGFpbiwgYW5kDQo+ID4gdGhpcw0KPiA+IHdpbGwgYmUNCj4gPiBtb3JlIGRpZmZpY3Vs
dCB0byBhZGRyZXNzIGluIHRoZSBmdXR1cmUuDQo+ID4gSWYgeW91IGNvbnNpZGVyIHRoZSBjb21t
aXQgYmVsb3c6DQo+ID4gDQo+ID4gY29tbWl0IGVhZDQ0OTAyM2QzYWNiMTQyNDg4NmQ3YjhjYzY3
MmVkNjliZGQyN2UNCj4gPiBBdXRob3I6IExvcmVuem8gQmlhbmNvbmkgPGxvcmVuem9Aa2VybmVs
Lm9yZz4NCj4gPiBEYXRlOiAgIFN1biBNYXkgMjggMTI6Mjg6NDkgMjAyMyArMDIwMA0KPiA+IA0K
PiA+ICAgICB3aWZpOiBtdDc2OiBtdDc5OTY6IGZpeCBwb3NzaWJsZSBOVUxMIHBvaW50ZXIgZGVy
ZWZlcmVuY2UgaW4NCj4gPiBtdDc5OTZfbWFjX3dyaXRlX3R4d2koKQ0KPiA+IA0KPiA+ICAgICBG
aXggcG9zc2libGUgTlVMTCBwb2ludGVyIGRlcmVmZXJlbmNlIG9uIG12aWYgcG9pbnRlciBpbg0K
PiA+ICAgICBtdDc5OTZfbWFjX3dyaXRlX3R4d2kgcm91dGluZS4NCj4gPiANCj4gPiBEZXJlbiB3
aWxsIG5lZWRzIHRvIG1vbml0b3IgdGhlIE1MIGFuZCBhcHBseSB0aGUgc2FtZSBmaXggZm9yIHRo
ZQ0KPiA+IG90aGVyIFdpRmk3DQo+ID4gY2hpcHNldCB0b28uDQo+ID4gDQpUaGlzIGRlcGVuZHMg
b24gdmlld3BvaW50LiBGb3IgaW5zdGFuY2UsIEkgcGxhbmVkIHRvIGFkZCBtYW55IGNoYW5nZXMN
CmZvciBtdDc5ODYgYnV0IDc5MjEgZG9lc24ndCB1c2UgKG9yIGV2ZW4gZG9uJ3QgY2FyZSksIGJ1
dCBJIG5lZWQgdG8NCmNoZWNrIG90aGVyIGRvbid0IGNhcmUgZGV2aWNlcyB3aXRob3V0IGFueSBo
ZWxwIChiZWNhdXNlIHRoZXkgZG9uJ3QNCmNhcmUpLCBzbyB3ZSBtYWludGFpbiBtb3JlIGFuIG1v
cmUgcGF0Y2hlcyBpbiBsb2NhbCBicmFuY2ggcmF0aGVyIHRoYW4NCnVwc3RyZW1pbmcuIA0KDQpP
dGhlciB0aGF0IHRoYXQsIEkgdGhpbmsgaXQncyBvayBpbiB3aWZpNiBidXQgd2lmaTcgaXMgUkVB
TExZDQpkaWZmZXJlbnQuIGl0J3MgYmV0dGVyIHRvIHdhaXQgdGhlIG1ham9yIE1MTyBkZXZlbG9w
bWVudCBmaW5pc2hlZCB0bw0KaGF2ZSBhIHdob2xlIHBpY3R1cmUgdG8ga25vdyB3aGF0IHRoZSBi
ZXN0IHdheSB0byB1bmlmeS4NCg0KPiA+IE1vcmVvdmVyIEkga2VwdCBtdDc5OTYvbWFjLntjLGh9
IHRvIHB1dCB0aGUgcGVyLWNoaXBzZXQgY29kZWJhc2UuDQo+ID4gSWYgeW91IHRoaW5rIE1UNzZf
Q09OTkFDM19CQVNJQ19SQVRFU19UQkwxMSBhbmQNCj4gPiBNVDc2X0NPTk5BQzNfQkVBQ09OX1JB
VEVTX1RCTDI1DQo+ID4gYXJlIHNlbnNpYmxlLCB3ZSBjYW4gcHV0IHRoZW0gaW4gbXQ3OTk2L21h
Yy5oDQo+IA0KDQphbmQgdGhpcyBpcyBqdXN0IG9uZSBhbnRoZXIgZXhhbXBsZSBJIGNhbiB0ZWxs
IHJpZ2h0IG5vdy4NCg0KPiBJIHVuZGVyc3RhbmQgeW91ciBjb25jZXJuLCBidXQgaWYgdGhlIGNv
ZGUgc3RhcnRzIHRvIGJlIHNoYXJlZCBhdA0KPiBlYXJseQ0KPiBzdGFnZSwgd2UgbWF5IG5lZWQg
dG8gYWRkIHNldmVyYWwgaXNfbXQ3OTk2KCkgdG8gc3BsaXQgZGlmZmVyZW50DQo+IHBhcnRzDQo+
IHRlbXBvcmFyaWx5IG9yIHBlcm1hbmVudGx5LCBzaW5jZSB3ZSBoYXZlIGRpZmZlcmVudCBkZXZl
bG9wbWVudA0KPiBwcm9jZWR1cmUgYW5kIGZvY3VzaW5nLCBvbiBkZXZpY2VzIG9mIGRpZmZlcmVu
dCBzZWdlbWVudHMuDQo+IA0KPiBCZWxvdyBhcmUgc29tZSBleGFtcGxlcyBJIGNvbmNlcm46DQo+
IC0gV2UncmUgZG9pbmcgc29tZSB0ZXN0cyBhYm91dCBzd2l0Y2hpbmcgYWxsIFRYUyB0byBQUERV
IFRYUywgYW5kIHRoZQ0KPiBjb2RlIGluIG1hY19hZGRfdHhzX3NrYigpIG5lZWRzIHRvIGJlIGNo
YW5nZWQuIElmIGRldmljZXMgb2YgU1RBDQo+IHNlZ2VtZW50IGRvbid0IHdhbnQgdG8gY2hhbmdl
IG9yIHdvbid0IHN3aXRjaCBpbiBzaG9ydCB0aW1lLCB3ZSBtYXkNCj4gbmVlZCB0byBhZGQgaXNf
bXQ3OTk2KCkgdG8gc3BsaXQuDQo+IA0KPiAtIFdoZW4gYWRkaW5nIE1MTyBzdXBwb3J0LCB0aGVy
ZSB3aWxsIGJlIG1hbnkgY2hhbmdlcyBpbg0KPiBtYWNfd3JpdGVfdHh3aSgpIGFuZCB0eHdpX2Zy
ZWUoKSwgY29tcGFyZWQgdG8gcHJldmlvdXMgY2hpcHNldHMuIFRvDQo+IHByZXZlbnQgZnJvbSBh
ZGRpbmcgc2lkZSBlZmZlY3RzIHRvIG90aGVyIGRldmljZXMsIHdlIG1heSBhbHNvIG5lZWQNCj4g
dG8NCj4gYWRkIGlzX210Nzk5NigpIHRvIHNwbGl0IGNvZGUgYXQgbGVhc3QgZm9yIHRlbXBvcmFy
eS4NCj4gDQo+IEkgd291bGQgbGlrZSB0byBrbm93IGlzIGl0IGZpbmUgd2l0aCB5b3UgdG8gYWRk
IHNvbWUgaXNfbXQ3OTk2KCkgdG8NCj4gdGhlDQo+IHNoYXJlZCBjb2RlIGZvciB0aGUgYWJvdmUg
ZXhhbXBsZXM/DQo+IEkgdGhpbmsgdGhpcyBjb3VsZCBoZWxwIHRvIGJhbGFuY2UgdGhlIHRyYWRl
IG9mZiBiZXR3ZWVuIHNoYXJpbmcgY29kZQ0KPiBhbmQgYXNzdXJpbmcgdGhlIGRyaXZlciBzdGFi
aWxpdHkgb24gZGlmZmVyZW50IHNlZ2VtZW50cy4NCj4gDQo+IFRoYW5rcywNCj4gU2hheW5lDQo+
ID4gPiA+ID4gPiA+ID4gPiANCg==
