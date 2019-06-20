Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D0264C947
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Jun 2019 10:18:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726246AbfFTISw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 20 Jun 2019 04:18:52 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:5760 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725877AbfFTISw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 20 Jun 2019 04:18:52 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5K8Ihkh017268;
        Thu, 20 Jun 2019 01:18:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=ylmzxRh1zkqkYAQ0Xs98LNa+N+AmamjVEqAk2CI9zVM=;
 b=qc5c4O3DPBOJbjbXG+M2j/c50+WbsTuz7eUXsEL3U79L0rXjpbqDBNPcmMWsD32GV1gb
 tgEVdR/oiUx6uecHYjEx7G/hCEynJKJXZwQ6s4mVJXYo6BZ9fnrqEaIX93X6xr0cJvMK
 5kW8NpSi63EuryYfH01Toae8cz4CdWS9peHnLpfdA/U90noOBdqSnNli5YzXnQ5m2YeN
 jkvoCKc701ysgpyB3q495Vzr7Rxxsxr9ePX5UwoOVFwB45a47ppeIxP2AMOF4eoMxdDI
 EioTcw5XwO5ISGaQjxxlhjx4fAS2H/WSv2CXjFX/pWVjFmUsZc+Uq/Mzhb0wLPu+Wsby xg== 
Received: from sc-exch02.marvell.com ([199.233.58.182])
        by mx0b-0016f401.pphosted.com with ESMTP id 2t7vrk1vt5-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 20 Jun 2019 01:18:49 -0700
Received: from SC-EXCH04.marvell.com (10.93.176.84) by SC-EXCH02.marvell.com
 (10.93.176.82) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Thu, 20 Jun
 2019 01:18:15 -0700
Received: from NAM01-SN1-obe.outbound.protection.outlook.com (104.47.32.57) by
 SC-EXCH04.marvell.com (10.93.176.84) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Thu, 20 Jun 2019 01:18:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ylmzxRh1zkqkYAQ0Xs98LNa+N+AmamjVEqAk2CI9zVM=;
 b=foLeRekTVdeUnZTsglJ3qiXwkzoea8K/OTMszkOw3pvQfC/xPANYH1RmtpTbIf8Had1ueOx3ECk4qIUunvo2SrMokUzTgW4KagPoYVwN+avGBxrBzU250gmPQbWltllB5DYYwtHKed1Lf94LKwAq6RCd5632INu3I8+S4oBVpLs=
Received: from MN2PR18MB2637.namprd18.prod.outlook.com (20.179.80.147) by
 MN2PR18MB3039.namprd18.prod.outlook.com (20.179.83.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.11; Thu, 20 Jun 2019 08:18:10 +0000
Received: from MN2PR18MB2637.namprd18.prod.outlook.com
 ([fe80::3c77:9f53:7e47:7eb8]) by MN2PR18MB2637.namprd18.prod.outlook.com
 ([fe80::3c77:9f53:7e47:7eb8%7]) with mapi id 15.20.1987.014; Thu, 20 Jun 2019
 08:18:10 +0000
From:   Ganapathi Bhat <gbhat@marvell.com>
To:     Kalle Valo <kvalo@codeaurora.org>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "Cathy Luo" <cluo@marvell.com>, Zhiyuan Yang <yangzy@marvell.com>,
        James Cao <jcao@marvell.com>,
        Rakesh Parmar <rakeshp@marvell.com>,
        Sharvari Harisangam <sharvari@marvell.com>
Subject: RE: [PATCH 09/11] mwifiex: update set_mac_address logic
Thread-Topic: [PATCH 09/11] mwifiex: update set_mac_address logic
Thread-Index: AQHVITE55VnlQ40LVUOcb+VOvARLhqaYIVFAgAwa+v2AAAJ6kA==
Date:   Thu, 20 Jun 2019 08:18:10 +0000
Message-ID: <MN2PR18MB263760543D6AF3FC977219AFA0E40@MN2PR18MB2637.namprd18.prod.outlook.com>
References: <1560352331-16898-1-git-send-email-gbhat@marvell.com>
        <MN2PR18MB2637F76B11A51E34A8586208A0EC0@MN2PR18MB2637.namprd18.prod.outlook.com>
 <875zp0u1ao.fsf@purkki.adurom.net>
In-Reply-To: <875zp0u1ao.fsf@purkki.adurom.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [182.72.17.59]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 68dcc469-49de-400b-3b60-08d6f557d518
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR18MB3039;
x-ms-traffictypediagnostic: MN2PR18MB3039:
x-microsoft-antispam-prvs: <MN2PR18MB30397BF09167C0A889D98DA7A0E40@MN2PR18MB3039.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-forefront-prvs: 0074BBE012
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(136003)(346002)(39860400002)(366004)(396003)(189003)(199004)(71190400001)(54906003)(7736002)(25786009)(68736007)(55236004)(33656002)(305945005)(66446008)(66066001)(66556008)(76176011)(53936002)(558084003)(107886003)(6506007)(6116002)(14454004)(256004)(9686003)(6246003)(52536014)(102836004)(8936002)(4326008)(86362001)(7696005)(55016002)(11346002)(81156014)(26005)(64756008)(99286004)(2906002)(186003)(486006)(478600001)(316002)(229853002)(6436002)(476003)(81166006)(3846002)(76116006)(8676002)(73956011)(5660300002)(66946007)(71200400001)(74316002)(446003)(6916009)(78486014)(66476007);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB3039;H:MN2PR18MB2637.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: cWcVcBEDge7K6xw7lC8Q6YhRrk+DzL6kIcj7DEt4qdZ4TCa5PaKycXwCatgzYHjYVsaWcBRWg1Ku2yYaouK/mE2fDWmwhfburhqj9gp7OxHlKzgYYGXoGZ7FCv+hvoeHVMoPWQW2zduBR75z1dB8ki6zfhqDrbi0WCnK0x3g7VIigbKB4ILcBsWQJo3DsSlxriqz9rUnmFNurp8tKcVwRE25qBd9ttNy2pRiFoCu+0P4KZF9MmgbzjQYq/+RIaT3sM9hQCk4DAFhnU7P4HNCBB98rT4AM2yNysHniUlH4rKcwdkWp7VnE8k3wca/fZ+iM2opFKI+oma2CZjQJitSY5Q9sIaLnnLmTeGp9CrIkHE43YPJiAW5sHV59OoNaaJzQhx0l/yOClfI5Kh9rQJkwrmFReem4NfNQKs7A2RNTD4=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 68dcc469-49de-400b-3b60-08d6f557d518
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2019 08:18:10.4009
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gbhat@marvell.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB3039
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-20_06:,,
 signatures=0
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Kalle,

> I don't understand your comment. Are you saying that even if this is mark=
ed
> as "9/11" this was supposed to submitted as a single patch? If that's the=
 case,
> no need to resend.


Yes; That is the case;

Thanks,
Ganapathi
