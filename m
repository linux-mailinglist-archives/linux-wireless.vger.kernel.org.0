Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC62E42AA1
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Jun 2019 17:18:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406059AbfFLPSI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 12 Jun 2019 11:18:08 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:33262 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728203AbfFLPSI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 12 Jun 2019 11:18:08 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5CFCZTa020370
        for <linux-wireless@vger.kernel.org>; Wed, 12 Jun 2019 08:18:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=o5r6M3tHkentZe4Ic0N1FF+OsUnZqKB83sILwNMxUSQ=;
 b=jqo7OjUlS0imfOzr3DcnfDHX8P5QVSE0P2xBAaBPJmADMu5Wrf/AtpCbCbs1UnlZPqy/
 xTmKqpxYrPUTd2w+Utk9YgE1rvubGJ3AySw++qKTFgcxdPEHz1bLVxe2P8fKQRRmLyWd
 CUYfoMlAEOQdU+2nbUgB+9PlLFBl2lVMBZXz9I4swSHL4SNy/LaZTkCPNmeQ0EBfepC5
 ijLSU6UWX8P+NligGLBRSVb0/ew8L/wge8ajR+wDv6A8mhmhATI+wNxnDQES9B4ISRIj
 VIdy7pms4ocfjNxL6pSIS30g3P6aJ62UPfbrhXOGOq3Ssu10EKr8cYOxbcFHa6u/bFVw gQ== 
Received: from sc-exch03.marvell.com ([199.233.58.183])
        by mx0a-0016f401.pphosted.com with ESMTP id 2t2ukn28cr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-wireless@vger.kernel.org>; Wed, 12 Jun 2019 08:18:07 -0700
Received: from SC-EXCH04.marvell.com (10.93.176.84) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Wed, 12 Jun
 2019 08:18:06 -0700
Received: from NAM03-DM3-obe.outbound.protection.outlook.com (104.47.41.57) by
 SC-EXCH04.marvell.com (10.93.176.84) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Wed, 12 Jun 2019 08:18:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o5r6M3tHkentZe4Ic0N1FF+OsUnZqKB83sILwNMxUSQ=;
 b=Qjw3XgMDTcoYqfwP6fVTwBsPU5vkJx2kocFvUN3tYul6XDu/j+SM+BNaPEYWZ3CBY+/HFEyuQP8ge/hV4+9v3zu0+9e03uDHN8IUU3fLSsMT0R4wh1bCNLSNqInrnqGkJLA6yCtW8hLU6kFeCnqi4DfNp5VDGzXGecHI7W0Ktmc=
Received: from MN2PR18MB2637.namprd18.prod.outlook.com (20.179.80.147) by
 MN2PR18MB3102.namprd18.prod.outlook.com (10.255.86.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.12; Wed, 12 Jun 2019 15:18:04 +0000
Received: from MN2PR18MB2637.namprd18.prod.outlook.com
 ([fe80::3c77:9f53:7e47:7eb8]) by MN2PR18MB2637.namprd18.prod.outlook.com
 ([fe80::3c77:9f53:7e47:7eb8%7]) with mapi id 15.20.1987.012; Wed, 12 Jun 2019
 15:18:04 +0000
From:   Ganapathi Bhat <gbhat@marvell.com>
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC:     Cathy Luo <cluo@marvell.com>, Zhiyuan Yang <yangzy@marvell.com>,
        James Cao <jcao@marvell.com>,
        Rakesh Parmar <rakeshp@marvell.com>,
        Sharvari Harisangam <sharvari@marvell.com>
Subject: RE: [PATCH 09/11] mwifiex: update set_mac_address logic
Thread-Topic: [PATCH 09/11] mwifiex: update set_mac_address logic
Thread-Index: AQHVITE55VnlQ40LVUOcb+VOvARLhqaYIVFA
Date:   Wed, 12 Jun 2019 15:18:04 +0000
Message-ID: <MN2PR18MB2637F76B11A51E34A8586208A0EC0@MN2PR18MB2637.namprd18.prod.outlook.com>
References: <1560352331-16898-1-git-send-email-gbhat@marvell.com>
In-Reply-To: <1560352331-16898-1-git-send-email-gbhat@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [106.193.128.232]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d3c39317-1500-42d5-6971-08d6ef492a67
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR18MB3102;
x-ms-traffictypediagnostic: MN2PR18MB3102:
x-microsoft-antispam-prvs: <MN2PR18MB3102F773098730C564E58F1AA0EC0@MN2PR18MB3102.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 0066D63CE6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(396003)(346002)(366004)(376002)(39860400002)(199004)(189003)(33656002)(316002)(66066001)(99286004)(102836004)(446003)(68736007)(558084003)(7696005)(6436002)(5640700003)(476003)(78486014)(71200400001)(11346002)(186003)(53936002)(9686003)(55016002)(2351001)(256004)(71190400001)(6506007)(76116006)(76176011)(54906003)(66446008)(64756008)(66556008)(66476007)(2501003)(73956011)(66946007)(25786009)(74316002)(3846002)(6116002)(86362001)(5660300002)(6246003)(229853002)(478600001)(6916009)(7736002)(2906002)(8676002)(81166006)(486006)(4326008)(81156014)(52536014)(14454004)(305945005)(8936002)(26005)(107886003);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB3102;H:MN2PR18MB2637.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: VDDM3yqlTnxVqYLrS2pSrVgWROvtP+DXGBhLvPORS5q275P6KES8IVa64zyQUxydlcrxzhJ7IgIFWLCv9vo0EzhdaLUD2NRoyS7JZh739lFeEHRfhE8EgY/BcWyihWAEGRDRDxjJIxqClKIQAML8CuBabBC8sCPINzfGW6OA+37R6KQ23DHY20swvEa6T/dQAOZpHIKjKerqx/89ZEx+NEDcAqQqNLY7zBsEZm1CUJJGuh4kcCJbqHGB6y9cThcyusjfWCyvgxUvSwvlhD9jS6V3kBoAiiQ6BsW/Gn8XXwPt7Husbd75iKeszkqFHKvYi2qRdvDOQXk5sm9H5XGq/MJyzcEBZNLreNo0sdcjy29qEWCnP/plYLgzXijWfXT1L4C6CXStXFiEoHZg+ZAsuGUGcT/oW5Qm0kOJV6CneGA=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: d3c39317-1500-42d5-6971-08d6ef492a67
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jun 2019 15:18:04.1116
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gbhat@marvell.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB3102
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-12_09:,,
 signatures=0
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Kalle,

This change is correct one, but I missed changing the .patch file name befo=
re sending. Let me know if this needs to be resend.

Regards,
Ganapathi
