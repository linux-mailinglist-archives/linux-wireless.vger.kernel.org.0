Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B09C310D3B2
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Nov 2019 11:10:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726608AbfK2KKT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 29 Nov 2019 05:10:19 -0500
Received: from esa15.fujitsucc.c3s2.iphmx.com ([68.232.156.107]:53008 "EHLO
        esa15.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725892AbfK2KKT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 29 Nov 2019 05:10:19 -0500
X-Greylist: delayed 429 seconds by postgrey-1.27 at vger.kernel.org; Fri, 29 Nov 2019 05:10:18 EST
IronPort-SDR: aeQQZLPlQJY4jiM4Q1CO58lwrQLK6G4AE/siLHUxzY0MlzG4hBQAGFlM+YxO8N8Bhz1E2181ZJ
 3nPHvlKGvMWddBWedkwzF1IvoEelyB+yRfV5DsUMex+Vr00Fxe35+yoUewiftUdpgoS42gWeDD
 waQI5GhvD4RgGrv166Lj2VDgCXog7TfPrfvg5jIQplWPsDrvypet9VUC3+w5yNqWmKsoZnh4H2
 1P9B9GH2r/Z1YVyIIdNG3b7BI0lm0gkbdgZZQX8DTaJMOaOsU6lSieel4vGFH2FljBJuIJv/B1
 AiM=
X-IronPort-AV: E=McAfee;i="6000,8403,9455"; a="8064808"
X-IronPort-AV: E=Sophos;i="5.69,257,1571670000"; 
   d="scan'208";a="8064808"
Received: from mail-ty1jpn01lp2059.outbound.protection.outlook.com (HELO JPN01-TY1-obe.outbound.protection.outlook.com) ([104.47.93.59])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2019 19:03:07 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L7s1+KxLGZV6tGgSIIWw+2nYBac8np2Q7ihwIINAPOaQcL2i4TnErYpmdb4L8yl4X+T8Cnxd6G9Jm6QHNXtDBXHZ+HApCrLHGxGI9lsrhS9YgwnE1IbXY147zlGzNSaZLx7+0hQOn1WF01SFWCoyfkRWaUxTzf9SiuwwLVijvlUnhIRmQn6fHK3Ugaq9AkqBP0WuC1MVby/Tqjoo2fZ41ZRnlvtW0Xb/NMgH0kbbYV0JEZtF0LCTxsndNLzXnlIN5aiaa/pr3fgnB6j9Z+7vxpc1YmGs0Z4qZHvW1cyULBPnId4xme/slJOS4hwLQO4tl/1g5nEO2lno9xrqaxc6TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KWgXRrfEEN9JQCzKreNWzDwrQm/R0dFS8BYOjsLKNuY=;
 b=DfX6RROjhqPW0iH+YQY1ltF9wlUA2lwdDZgEUxHTEcdOhYweb/2strMTBmqzfjOH15qP/8YGaFJyJDHnKA54vQVSTu9lLMp0DScLOrpRwZx/dibYutzulFy5NG9DCDjyHqcBcLryyLl0vWoZn017rGquASli/AJiLxAuhDovxRcDbxVcLf/UoswVMsGydTIQoTbBGCKdFxqXPB469ieIKvTI06l5PKBLKcnqik0TQE/o0NiZwZNyAK2q9wob5pIiCpjvCm5FbbiLbUtM+PmK/AMi5ZtqcosrTeub0iJaiR11c73trl3orTMe+jo8XPUmtrCssU1/f/WYhyssdTSA7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KWgXRrfEEN9JQCzKreNWzDwrQm/R0dFS8BYOjsLKNuY=;
 b=ltaJzrMnTM403x4oWf5iU6Mo31driDVcRifB5YTX92RmHBFRwpcgIeXoUYTjPKY+suv+IH6DdARpROv+z0em8djwTvI6M5bg6oLdFF8RJUs23cCBpvnRPwSgC0dkxYZHLHTSWwssVsUFrmvx9mVtHPXSHqp7MQCl/TT2H0gzGSU=
Received: from OSBPR01MB2168.jpnprd01.prod.outlook.com (52.134.242.11) by
 OSBPR01MB1606.jpnprd01.prod.outlook.com (52.134.227.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.21; Fri, 29 Nov 2019 10:03:05 +0000
Received: from OSBPR01MB2168.jpnprd01.prod.outlook.com
 ([fe80::5410:46d5:c655:2775]) by OSBPR01MB2168.jpnprd01.prod.outlook.com
 ([fe80::5410:46d5:c655:2775%3]) with mapi id 15.20.2495.014; Fri, 29 Nov 2019
 10:03:05 +0000
From:   "ambai.masaki@fujitsu.com" <ambai.masaki@fujitsu.com>
To:     "'linux-wireless@vger.kernel.org'" <linux-wireless@vger.kernel.org>
CC:     "'brcm80211-dev-list.pdl@broadcom.com'" 
        <brcm80211-dev-list.pdl@broadcom.com>,
        "'brcm80211-dev-list@cypress.com'" <brcm80211-dev-list@cypress.com>
Subject: What is the license for linux/lib/math/cordic.c?
Thread-Topic: What is the license for linux/lib/math/cordic.c?
Thread-Index: AdWmm5RtoddtbjEIQ/yLayvM+Qn80Q==
Date:   Fri, 29 Nov 2019 10:03:05 +0000
Message-ID: <OSBPR01MB21689E8028F2AFDBBA89076C83460@OSBPR01MB2168.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-shieldmailcheckerpolicyversion: FJ-ISEC-20140924-1
x-shieldmailcheckermailid: 91eeb8209c6040bc9a85221f8aa1faf1
x-securitypolicycheck: OK by SHieldMailChecker v2.3.2
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ambai.masaki@fujitsu.com; 
x-originating-ip: [114.160.9.180]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b8d79a6d-aaa1-4dbb-972a-08d774b353fd
x-ms-traffictypediagnostic: OSBPR01MB1606:
x-microsoft-antispam-prvs: <OSBPR01MB160660829D3AFA859339CBEF83460@OSBPR01MB1606.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 0236114672
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(366004)(376002)(396003)(39860400002)(346002)(189003)(199004)(81166006)(66476007)(66446008)(256004)(478600001)(66066001)(76116006)(6916009)(85182001)(26005)(64756008)(71190400001)(14444005)(6506007)(66946007)(52536014)(8676002)(5660300002)(66556008)(81156014)(14454004)(3846002)(186003)(54906003)(316002)(6116002)(2906002)(74316002)(7696005)(7736002)(71200400001)(25786009)(4326008)(99286004)(102836004)(305945005)(6436002)(86362001)(8936002)(55016002)(9686003)(33656002)(777600001)(491001);DIR:OUT;SFP:1101;SCL:1;SRVR:OSBPR01MB1606;H:OSBPR01MB2168.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: V9htUoKIBmZuXRz0C9sTV/FBlAlXUKMdqtkwDtzhpIDQDFi9Z72KhUKlwRuui7a2wfbOrzMUePVhsiA1c6irD1R9ts8EoenKVHb7O5ZpoYWVn5sPh3IzP04HWija3R+U2aqPVRQ8xruBHRcDZbzKbZybZi2D/Cjl1I5OgCHMfD7105U/x4StPXQ9lInUHd8i8maQQuKmm5pNyNFU18lIlFvAtOjAXyAY96/r95MZffH7llGbyPUQyPlUuDnyVx6nWensHxsGZ4AHpUVPrJYol89dzTOhnFMEpd9h8Hxgqy141KQCFr7UJayM2MQ4dL/UMsszaVQMQOHu84J9oX6qX8RimfiKMzi9Pxdrb3BpEydEmP9crnK2B83rJlxrHG7T1UjU4x+Ge1kric+fMlj4hrPDnRgaIsX8PS8PRl0AnkkNQTgR2Uiiv01NUTseWg9y
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8d79a6d-aaa1-4dbb-972a-08d774b353fd
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2019 10:03:05.2301
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PZYHNzdVu+tVPq94NHCR8Wnz9NAwda5MNEoaUGsgX52x3opVLDC3WwQ84XflFEIYoSdc1SYAZYCoRlMfXrT/fO7ANSK0IbW14lEqgv2f5C8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB1606
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

What is the license for linux/lib/math/cordic.c?

>  * Copyright (c) 2011 Broadcom Corporation
>  *
>  * Permission to use, copy, modify, and/or distribute this software for a=
ny
>  * purpose with or without fee is hereby granted, provided that the above
>  * copyright notice and this permission notice appear in all copies.
>  *
>  * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTI=
ES
>  * WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
>  * MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FO=
R ANY
>  * SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
>  * WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN =
ACTION
>  * OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF OR IN
>  * CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
I think this license is an ISC license.

> MODULE_LICENSE("Dual BSD/GPL");
However, MODULE _ LICENSE declares a different license.
I don't know which license is correct.
What licenses are declared in this file?

Regards,
Ambai


