Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 69D14129EF5
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Dec 2019 09:30:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726068AbfLXI3v (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 24 Dec 2019 03:29:51 -0500
Received: from mail-eopbgr30127.outbound.protection.outlook.com ([40.107.3.127]:9902
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726047AbfLXI3v (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 24 Dec 2019 03:29:51 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZBUIe2gMT5gph1fSY1+KY8EAtfzMQogLU/0baTwdcTt4sbUFNal1C7nqvs81rkGYlTo/cM8HPppDYtkv72DcL3Xc0dIaARQh0tyX3TV2zccGVFjVaNqaMaUHpiS2JUQyIlHDZY7WSdRoyZXWpQhFLDFC1cBvQWHnbQUnrVQqt5xDwbw8axH3s4BFxmF+4iXIhise8LLw3sqLVeH/s6V8n5rP5GR3JnkbqLGoWPdFdnoRi9rlgzsTbUIZYZ56LX0DIpo7mWmjQjQthGKFzHPixWT0Er2aWMqePcWZ7X8/Q/ej9pLvZQf0b7AYXRCFuKkC84fZQCcs4VfyNdf3wK0eBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eJm5q2T3WSbC5Kz1kF2mTmevAzeKkSQ4S9BbZysOK4Q=;
 b=oDuZeNsvPVLsWUPN5PjhxZRzVf0d0Bpgktg4Bs5ZUlzbfvHBk5oVbZpeMxKg+Dum5I4edTQu8AKZb3WCxKt5plNrnysveDl7146uimm0Dcwcgh29Iu8PlyTPVfjqRCmVjLQkAcZQvRZ3ggxblKu72ARJ6wCJJcZ488Tgg8RmE34aHbIvkxaoO614AiMlMRkltgEpaw7BS6vU89LZAFkBhsY6aYeCMAio1CfOJpo+IXrLASApYNjtjnPeqV/k1IY4hTM1gBHdHZqlWx0/Y/ig/ykp0h6FZhFLLv4jZgnJjH5/kECnsCEoW3tNbeX/fBOtGJrs1ITBGBP6yJLyJjRQtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tandemg.com; dmarc=pass action=none header.from=tandemg.com;
 dkim=pass header.d=tandemg.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tandemg.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eJm5q2T3WSbC5Kz1kF2mTmevAzeKkSQ4S9BbZysOK4Q=;
 b=rwvbit7nplr6BfLhiEeL3VxXda6sLpqr7mcuUt1Obc5Taft0pSDscQ8vr3MDcFrvrB0AuLfECLzomIRONPtYr2hThWvce7pWQV0nBNhA5eApMhIy02WSb1d2OkDntCF5+cvEHYCM1ydKkqFN3G7oqfHVv76TIn9cDusLPJy1jN8=
Received: from AM6PR02MB3621.eurprd02.prod.outlook.com (52.134.115.32) by
 AM6PR02MB4659.eurprd02.prod.outlook.com (20.177.188.207) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.16; Tue, 24 Dec 2019 08:29:45 +0000
Received: from AM6PR02MB3621.eurprd02.prod.outlook.com
 ([fe80::d967:3749:3fcd:778a]) by AM6PR02MB3621.eurprd02.prod.outlook.com
 ([fe80::d967:3749:3fcd:778a%4]) with mapi id 15.20.2559.017; Tue, 24 Dec 2019
 08:29:45 +0000
From:   Orr Mazor <orr.mazor@tandemg.com>
To:     Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
CC:     Johannes Berg <johannes@sipsolutions.net>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Recall: [PATCH] subsystem: Fix radar event during another phy CAC
Thread-Topic: [PATCH] subsystem: Fix radar event during another phy CAC
Thread-Index: AQHVujRL/YiqiHk0TUm0FHPsJ4D/mw==
X-CallingTelephoneNumber: IPM.Note
X-VoiceMessageDuration: 1
X-FaxNumberOfPages: 0
Date:   Tue, 24 Dec 2019 08:29:45 +0000
Message-ID: <AM6PR02MB362135CB1CD529F8550ECB65EF290@AM6PR02MB3621.eurprd02.prod.outlook.com>
Accept-Language: he-IL, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=orr.mazor@tandemg.com; 
x-originating-ip: [84.95.243.50]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7fb29ef6-0f58-4bc1-7077-08d7884b6e5d
x-ms-traffictypediagnostic: AM6PR02MB4659:
x-microsoft-antispam-prvs: <AM6PR02MB4659FE8BEB25D039E0B1B48DEF290@AM6PR02MB4659.eurprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-forefront-prvs: 0261CCEEDF
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39830400003)(346002)(136003)(376002)(366004)(189003)(199004)(9686003)(558084003)(7696005)(6506007)(52536014)(4326008)(186003)(2906002)(6916009)(44832011)(55016002)(26005)(66476007)(71200400001)(76116006)(64756008)(5660300002)(66446008)(81156014)(8676002)(66946007)(81166006)(33656002)(8936002)(508600001)(66556008)(316002)(86362001)(54906003);DIR:OUT;SFP:1102;SCL:1;SRVR:AM6PR02MB4659;H:AM6PR02MB3621.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: tandemg.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mgd6eVECWLDQfjabjTIHwofwuWFpNVmzce8aoTiKQIjU0GyVhtALxJ/OVYEzwExntlSdVtD58M1m6pmS5YiQyvs5razIstLOEqnCvBzDfPO9aKaOSen8jbUEwLUMzKHNapnMRpyeywcbxjCLnPXntYuyxZSyhYB978dVQ5blisBZPlorKX1D537SDHrjE2UgduudwBIcctoDEVQ77ynLjwDARtw1d5ReJNX1KV585XhLTugBPE4r8Zg+QBgU3/EzEAT8noWcr6x4mZSe6rSt2a6B7vcKxrU234/LUEJPn4T1uqxkY3hwdS+R26564aupXwZtUcurW73NB8faMjx2dqyV65gEtG80u46gbabv9PhQeOStT7qwnN8PqiWw1EbzOL/2UHPO5LDuOTDmhoL87wdP3dEFOtY5A6xEd+XB3akd0Dzdj3f+PZ5beRcyGw3q
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: tandemg.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fb29ef6-0f58-4bc1-7077-08d7884b6e5d
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Dec 2019 08:29:45.0917
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d690b55a-f04a-454b-9f62-fb1e25467a25
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Az84C4oj/TAfmKJcdJUJAVAgRjeJl1iS8IeHIKqj+6JWEX5lhV8y2zB1yIrF4slR5+/P9H1O6/zUsxHa4lqp3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR02MB4659
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Orr Mazor would like to recall the message, "[PATCH] subsystem: Fix radar e=
vent during another phy CAC".=
