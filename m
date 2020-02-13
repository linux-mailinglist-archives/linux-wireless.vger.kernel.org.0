Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA25E15BD83
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Feb 2020 12:15:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729544AbgBMLP0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 13 Feb 2020 06:15:26 -0500
Received: from mx0b-00183b01.pphosted.com ([67.231.157.42]:26534 "EHLO
        mx0a-00183b01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729526AbgBMLP0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 13 Feb 2020 06:15:26 -0500
Received: from pps.filterd (m0048103.ppops.net [127.0.0.1])
        by mx0b-00183b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01DBAWfv009437;
        Thu, 13 Feb 2020 04:13:43 -0700
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
        by mx0b-00183b01.pphosted.com with ESMTP id 2y1u4wm3k9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Feb 2020 04:13:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EX1ToELzgNBGtlscG9igWHb8LMx7p/2tbeYDFpBA6cn5ZGO/j4dcnbCuC+r5OWf1ujAG8KKoR+LXOnyXNGdgiR0FFiovzR4wHwIqerNSA81AU6+SvyP7MqX3m3wdpP/W9SJlifA2o/5wVcnET1N9oMMz9ZX7ItQTJzplmwP31mJvZjVNXZ6xbNqnW9GSLUwj4SDJo7jo7f0jGvO3yRhQjGBYO4jiaFqIJCss28rB/PiwVa9eDWLH81Pa+CdnXe7OTdZ/Dor9W11hBstEhC3cEtNSt5foLKEgloHe2QOrzus5NcXC2sKzM+V/oWjDvAJsIK1zYruxI1nvM6GnJqh28g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z/SdksgpQelIXH0EisAZ2QmjkVUAz8WGTJtEdTLamk4=;
 b=Yg6AwKzbN/s+i873P/40rCHHcvUL9Lozz0Lvf08Pxy+5CJKCfyQvZe7crCMoIV3Far4upwcXYlY1PxlXDb5sdT++djZlVKLOJ/2Z8r6PePqBzpTtFKwdMFLrNJ+HI9A3mkc1TVLAikhyJ2uqycBp0PUy+np7qdHRM+zOuTf/po1TYmoFLL2B1IQ+sCh0TQTwBM1K9IkKNF+7iBaeK+QBzMf/82s+sZWoLhTmBOInBHNd5JgJBAsrKMCX6wTRRZDP8fYHVdtt+GhcEJjWw+wJkQ8wxRDCaYsl3CFkvK/JmNVdGZfdb1kPocw0NqLjJEszj2+e2OYlSv3U+GeT2VlxlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quantenna.com; dmarc=pass action=none
 header.from=quantenna.com; dkim=pass header.d=quantenna.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quantenna.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z/SdksgpQelIXH0EisAZ2QmjkVUAz8WGTJtEdTLamk4=;
 b=jzlBYjxT35RGVycNPXgbYmqMUkDia7RSYp0/dPPz5GbHu4EaeNMdBh37IPHnqiMB6puXH7DOLR7A8yhuezIPmjhf2sS+P3pbM/aEoGnoILE8enf9CNvNguBnZaKMr/LvCWjLLM4SgOyr9y6wGDOO0S+VXYcUXicH4YlFbemNcmw=
Received: from BYAPR05MB4727.namprd05.prod.outlook.com (52.135.235.140) by
 BYASPR01MB0070.namprd05.prod.outlook.com (20.179.60.216) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.6; Thu, 13 Feb 2020 11:13:40 +0000
Received: from BYAPR05MB4727.namprd05.prod.outlook.com
 ([fe80::948:1ca9:c6c4:3797]) by BYAPR05MB4727.namprd05.prod.outlook.com
 ([fe80::948:1ca9:c6c4:3797%7]) with mapi id 15.20.2729.021; Thu, 13 Feb 2020
 11:13:40 +0000
Received: from SN6PR05MB4928.namprd05.prod.outlook.com (52.135.117.74) by
 SN6PR05MB5056.namprd05.prod.outlook.com (20.177.248.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.16; Thu, 13 Feb 2020 11:13:07 +0000
Received: from SN6PR05MB4928.namprd05.prod.outlook.com
 ([fe80::25b7:98a0:c066:1a9]) by SN6PR05MB4928.namprd05.prod.outlook.com
 ([fe80::25b7:98a0:c066:1a9%6]) with mapi id 15.20.2729.021; Thu, 13 Feb 2020
 11:13:07 +0000
Received: from bars (195.182.157.78) by HE1P192CA0001.EURP192.PROD.OUTLOOK.COM (2603:10a6:3:fe::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2729.22 via Frontend Transport; Thu, 13 Feb 2020 11:13:06 +0000
From:   Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
To:     Johannes Berg <johannes@sipsolutions.net>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Re: [RFC PATCH 1/2] cfg80211: skip strict validation for UDPATE_OWE
 command
Thread-Topic: [RFC PATCH 1/2] cfg80211: skip strict validation for UDPATE_OWE
 command
Thread-Index: AQHV4kz2Q5s3fb8LT0S52R/D0emqZagY1umAgAAhmIA=
Date:   Thu, 13 Feb 2020 11:13:07 +0000
Message-ID: <20200213111300.jgb3kkvwq6am3aj7@bars>
References: <20200213090657.28841-1-sergey.matyukevich.os@quantenna.com>
 <20200213090657.28841-2-sergey.matyukevich.os@quantenna.com>
 <703b19463655cbb8a5ab9469caec5d3936dbe35d.camel@sipsolutions.net>
In-Reply-To: <703b19463655cbb8a5ab9469caec5d3936dbe35d.camel@sipsolutions.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1P192CA0001.EURP192.PROD.OUTLOOK.COM (2603:10a6:3:fe::11)
 To SN6PR05MB4928.namprd05.prod.outlook.com (2603:10b6:805:9d::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [195.182.157.78]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7250a4e4-76d5-4999-0df6-08d7b075b3a9
x-ms-traffictypediagnostic: SN6PR05MB5056:|BYASPR01MB0070:
x-microsoft-antispam-prvs: <SN6PR05MB505675560A28A693412C705FA31A0@SN6PR05MB5056.namprd05.prod.outlook.com>
x-moderation-data: 2/13/2020 11:13:37 AM
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 031257FE13
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39850400004)(376002)(366004)(136003)(346002)(199004)(189003)(55016002)(8936002)(956004)(9686003)(1076003)(478600001)(4744005)(8676002)(81166006)(81156014)(52116002)(6916009)(6496006)(66946007)(66446008)(4326008)(64756008)(66556008)(66476007)(33716001)(71200400001)(186003)(5660300002)(16526019)(26005)(2906002)(316002)(9576002)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYASPR01MB0070;H:BYAPR05MB4727.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: quantenna.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8mlYUcvO73wyzLdQ8lJBAWohAym0ZK8LrAeC7HJnHIMtUVG4rWR9Px1g046dWH+MvVwmFMwrlb7QNo1voHLTFg+kvSqFm20JR59DG6yIkc6chkTswnxBrEjH7nufEZIjJE/utOvQy188c/ltxrNF+L6bvnHZVswN1niSLJgo0leVyPq6WoDBFMHZmrv+nHYG956c9dHWS7bldgIrUPoUfxzNCRArslR69GutmNmDkhJMBrXLuwptk4CWR03+Yzdm08NI39x+rINUI+lYp0wFc92k6oD1Jo6T0ee7yILp2Qu87k2Hsc1Ok6S+asjC2+TKXA6jJkzQb8juOBflkOxhtJ/K3Pb4tYbaVNiAYBHgK2kaRZCwDEHOY9ynJL5gYiiTe4hWfDG1WS3ytV5p1KQCAaFVTNgxuphv9PXPrCBlNA1OBkybrG/6kJq8ig198JyD
x-ms-exchange-antispam-messagedata: IGzrDzH20FzDV0vK6MVfMjF2rom2YSnt1Iga1U4G+euFzLrcrTTJqBC8SzNnLf9U67TJjqv1VjWUfRgJT9Tr3hOl533QRq/oOIct7/Nh+jEHI308Cc75Hv8RdtntjjAjV30eFbSsOJlcNoJ9giregw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <AA22C7B6BB981247884EE3782342B7E1@namprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: quantenna.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7250a4e4-76d5-4999-0df6-08d7b075b3a9
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a355dbce-62b4-4789-9446-c1d5582180ff
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sOqZz0DzbJBsJdXFKlMj8gl5NSbKHvOa5nT6Hax2kKB4sKZqOddhm9uN6iKqg+OU4wscRCwKQ8i3xLAJ+lT9vdQx0ffmvHmRK+8Ay52mq7FWIDRx0FlmbrGn/rjfq9/dqr8+butmRz4pXjD7tEsmqFODH1h0L5r/p51p+9jFf6t0fioMVydi/OF7sv0bpd9vbTlVLFOKcPGUNTW4wWAkEyW74A8vPRtM4JTI9lqUdYw=
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2020 11:13:40.6858
 (UTC)
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYASPR01MB0070
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-13_03:2020-02-12,2020-02-13 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 priorityscore=1501
 bulkscore=0 suspectscore=0 malwarescore=0 mlxlogscore=936 mlxscore=0
 adultscore=0 impostorscore=0 spamscore=0 phishscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002130089
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, Feb 13, 2020 at 10:12:47AM +0100, Johannes Berg wrote:
>=20
> [External Email]: This email arrived from an external source - Please exe=
rcise caution when opening any attachments or clicking on links.
>=20
> On Thu, 2020-02-13 at 09:07 +0000, Sergey Matyukevich wrote:
> > Do not perform strict validation of UPDATE_OWE command.
> > Otherwise, kernel rejects command executed by hostapd.
>=20
> Can't we fix hostapd? I mean, it's a relatively new command, so why
> shouldn't we validate it strictly?

That is why this patch is RFC: see cover email :)

Sure, I can fix hostapd instead. Could you point me at some good
starting point to look at ? Are there any user-space tools that
started to use strict validation ?

P.S.
If you are ok with the second patch, then could you just take it
from this series ? Or should I resubmit ?

Regards,
Sergey
