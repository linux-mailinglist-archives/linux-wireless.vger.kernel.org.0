Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B8A6342A55
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Jun 2019 17:07:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437269AbfFLPHa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 12 Jun 2019 11:07:30 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:60102 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2436492AbfFLPHa (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 12 Jun 2019 11:07:30 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5CF1jSO011984
        for <linux-wireless@vger.kernel.org>; Wed, 12 Jun 2019 08:07:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=fq8m2j5o8LrfGmjQ7j8h0T6md9t1L5nTOXSOIzt96vw=;
 b=kNVQdBnbxW+iCsTVlvlUdlMgBNvzZD0TF/qS8az+zcdvG85gnnduNXNnH740qFF6oKlc
 S1Xnh2N0fvyfYjbnefoDUHRY78d8FKaehGxq2SzFATSHMPLehckbEvcg5/aLVSpuudhZ
 aRCbeJ7sHhVL9/RewL6JRZ5aSW+3zI7Oa6nBWZh9ojDV02DLWWnSP/lHIs4Ii2gfsTV5
 L2eqpgYLV7ElZbPVzb8BRJrGmkBDoPOj0cb/uQRHjW9oWZakIWnTjUSQ+aUMOJcaJghT
 HQgZBxYfUMVRS6aYkMSoGdtWTkonU5frppIdb4/OhW9pxjBNuCWGGXdxx2w6epZEFX/x zw== 
Received: from sc-exch01.marvell.com ([199.233.58.181])
        by mx0a-0016f401.pphosted.com with ESMTP id 2t2ukn26yp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-wireless@vger.kernel.org>; Wed, 12 Jun 2019 08:07:29 -0700
Received: from SC-EXCH02.marvell.com (10.93.176.82) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Wed, 12 Jun
 2019 08:07:28 -0700
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (104.47.46.55) by
 SC-EXCH02.marvell.com (10.93.176.82) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Wed, 12 Jun 2019 08:07:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fq8m2j5o8LrfGmjQ7j8h0T6md9t1L5nTOXSOIzt96vw=;
 b=B4GFZF8bD1ZB7PhcYv69vSy/z9cF/aWq0NacuD/lFS1mJkhBAMIDqq8RQJXYfQv8W9NtTFnbDIKKNM67flflMySXQoLcrP1Wsxlg4VFXJQX3J4mSB8GjHtOFtE772nlQaADRgfYyDW2xvdFDAh0VHGOtUG4c+1YFXCQJArzAd7I=
Received: from MN2PR18MB2637.namprd18.prod.outlook.com (20.179.80.147) by
 MN2PR18MB2766.namprd18.prod.outlook.com (20.178.255.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.11; Wed, 12 Jun 2019 15:07:24 +0000
Received: from MN2PR18MB2637.namprd18.prod.outlook.com
 ([fe80::3c77:9f53:7e47:7eb8]) by MN2PR18MB2637.namprd18.prod.outlook.com
 ([fe80::3c77:9f53:7e47:7eb8%7]) with mapi id 15.20.1987.012; Wed, 12 Jun 2019
 15:07:24 +0000
From:   Ganapathi Bhat <gbhat@marvell.com>
To:     Ganapathi Bhat <gbhat@marvell.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH] mwifiex: update set_mac_address logic
Thread-Topic: [PATCH] mwifiex: update set_mac_address logic
Thread-Index: AQHVIS9cn+RSJGicWkeGZODLc7nu66aYHfMQ
Date:   Wed, 12 Jun 2019 15:07:24 +0000
Message-ID: <MN2PR18MB2637BDA467482E229925B87CA0EC0@MN2PR18MB2637.namprd18.prod.outlook.com>
References: <1560351524-16779-1-git-send-email-gbhat@marvell.com>
In-Reply-To: <1560351524-16779-1-git-send-email-gbhat@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [106.193.128.232]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b8b26cb6-dd66-4950-cb5d-08d6ef47ad0e
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR18MB2766;
x-ms-traffictypediagnostic: MN2PR18MB2766:
x-microsoft-antispam-prvs: <MN2PR18MB27660152FA34ACEAB7320A83A0EC0@MN2PR18MB2766.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-forefront-prvs: 0066D63CE6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(346002)(376002)(396003)(136003)(189003)(199004)(99286004)(6436002)(229853002)(2501003)(76176011)(14454004)(102836004)(7696005)(6506007)(78486014)(71200400001)(558084003)(71190400001)(68736007)(33656002)(52536014)(478600001)(81156014)(256004)(25786009)(81166006)(8676002)(305945005)(7736002)(8936002)(110136005)(6246003)(53936002)(26005)(2906002)(186003)(6116002)(3846002)(5660300002)(74316002)(11346002)(446003)(476003)(486006)(66066001)(86362001)(66446008)(64756008)(76116006)(66946007)(73956011)(66476007)(66556008)(316002)(55016002)(9686003);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB2766;H:MN2PR18MB2637.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Jx0K+V3rfUKkEM5l3HN054f3TE2jK1doonj1uzrsxnsuI24W5qZ76nVNV79kp8sPDFaetxXB0g8X//e0OgO3areDBn5ZJVQ8Uwfh5ZuKuxMfHVFMOzN+lGeztmQe/uNYvFFBGcW1vRaQB/OCL78g8PVP1RUGonYJLpPo5LzEM33iKJcjBoUG6JlNmCHz/aof57HtANKI0jqFKUDyzXEb74lUHB2Lluzlk0d1ZuovXftLiwht1v/kAABgCvXFCU61f3A9NK31xMDjTjZIDo9OmAjgm0RUTCulk4GNbvkG1t0RTb8VwGDFhwkDTEs9QvNFbP6iwrqAZLYEHaCUzsGibhAskVCZStosLX9gE6PgeFYp8bxAxVsaDGEg0RkXftOgvIhwkuSoOvWmG3DDe6srhVpRwPJd2/Eq1mScM+Z/jK8=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: b8b26cb6-dd66-4950-cb5d-08d6ef47ad0e
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jun 2019 15:07:24.3428
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gbhat@marvell.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB2766
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-12_07:,,
 signatures=0
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Kalle,

Kindly ignore this change. I will resend this change with original author n=
ame;

I had an issue with my 'git send-email';  and was trying to fix it. Now it =
is working.=20

Regards,
Ganapathi

