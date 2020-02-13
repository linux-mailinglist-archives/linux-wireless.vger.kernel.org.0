Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A7D8B15BB35
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Feb 2020 10:09:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729629AbgBMJJV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 13 Feb 2020 04:09:21 -0500
Received: from mx0b-00183b01.pphosted.com ([67.231.157.42]:14802 "EHLO
        mx0a-00183b01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729515AbgBMJJU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 13 Feb 2020 04:09:20 -0500
Received: from pps.filterd (m0059811.ppops.net [127.0.0.1])
        by mx0b-00183b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01D91C2d022318;
        Thu, 13 Feb 2020 02:07:37 -0700
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
        by mx0b-00183b01.pphosted.com with ESMTP id 2y1u7fbu2c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Feb 2020 02:07:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JHYBtYXexWqJzW9hUG6kcupOGZmNa6E9OzML1Vla9cL+YRLZlBt7fWqiUzCUCRgP93u/U8Uo/93P7i8sr7+xElZflz+zQtY9XDIHC1SriNld79cBY2necxx5qhoozRXb1DLICdSqaJof+OyXZphRLeUbDK2+AwnxbpBqAHxPL6mFfoZMCzA9IaRSL7JkqtgRE+pY5GgrHOBMuQmNXXmeYCbZo/KSV4EbSUJyeR+5O6t4HTeJc+WZ1cNYP5YDSG10G1M0J2u9FpKIU11roPHLW2ZcxSvfPWONwcOyNLFZHLSHro9ZxX59gHYEvFU1A90e/nhtzj+jcLYj85Jq62WXdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W2eogKq+v3x5NoLXrz87qJ7dAS6BEDGZKry0qB7q3vE=;
 b=F0IPCgYel06qZJD1LPZR2SUZl68F2F5l/plwm7w1XF55ZUaJ6CvnVD+v1H5FW8/cs1SYbioAeF6UgS2vkWAr7iRR8OiyXMwkqt2ewQ1SLDF2kuavJzmGylRPiDuNfRKfjAhDojNyNyzvxUb80YsfRO2VWGlADhgs1ycpWg9v3xpzfpQNGjy6aBcGLJJnD0yR6k1l+l9yUQ+SKJhAZDq00Zcce7qhgVMzlZuOeNbJuVzZhYyB2Rw83u5ash4n05FIuUrOFL++FvWc8aRz4UmVB49a6ED+Lt4UKZB0CIRYnW6octt1/XMs2p9fvXfAEJXGviI4NB+rzE7FpBU5PGuwkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quantenna.com; dmarc=pass action=none
 header.from=quantenna.com; dkim=pass header.d=quantenna.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quantenna.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W2eogKq+v3x5NoLXrz87qJ7dAS6BEDGZKry0qB7q3vE=;
 b=Fnf/fTYPwlZGUdl9dH478HxHbCr14pZZqjzHm425A4y7QnFTFCJ8BG3RiR93Y+evUVBHbJ8tmXITlEYuS5TX0c0OjH4ACUO2pb9lztvFq0dKwcWiBgn/MQfd9IGo7ybL6UQVnQfoCOZk65lywnmfYrBuq/i8QcKaLkMoSj0bcCw=
Received: from BN8PR05MB6657.namprd05.prod.outlook.com (20.178.214.23) by
 BN8PR05MB6548.namprd05.prod.outlook.com (20.178.215.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.18; Thu, 13 Feb 2020 09:07:35 +0000
Received: from BN8PR05MB6657.namprd05.prod.outlook.com
 ([fe80::94f1:58bd:d1b4:7099]) by BN8PR05MB6657.namprd05.prod.outlook.com
 ([fe80::94f1:58bd:d1b4:7099%6]) with mapi id 15.20.2729.025; Thu, 13 Feb 2020
 09:07:35 +0000
Received: from SN6PR05MB4928.namprd05.prod.outlook.com (52.135.117.74) by
 SN6PR05MB5550.namprd05.prod.outlook.com (52.135.110.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.16; Thu, 13 Feb 2020 09:07:06 +0000
Received: from SN6PR05MB4928.namprd05.prod.outlook.com
 ([fe80::25b7:98a0:c066:1a9]) by SN6PR05MB4928.namprd05.prod.outlook.com
 ([fe80::25b7:98a0:c066:1a9%6]) with mapi id 15.20.2729.021; Thu, 13 Feb 2020
 09:07:06 +0000
Received: from bars.quantenna.com (195.182.157.78) by HE1PR05CA0273.eurprd05.prod.outlook.com (2603:10a6:3:fc::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2729.23 via Frontend Transport; Thu, 13 Feb 2020 09:07:04 +0000
From:   Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC:     Johannes Berg <johannes@sipsolutions.net>,
        Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
Subject: [RFC PATCH 1/2] cfg80211: skip strict validation for UDPATE_OWE
 command
Thread-Topic: [RFC PATCH 1/2] cfg80211: skip strict validation for UDPATE_OWE
 command
Thread-Index: AQHV4kz2Q5s3fb8LT0S52R/D0emqZQ==
Date:   Thu, 13 Feb 2020 09:07:05 +0000
Message-ID: <20200213090657.28841-2-sergey.matyukevich.os@quantenna.com>
References: <20200213090657.28841-1-sergey.matyukevich.os@quantenna.com>
In-Reply-To: <20200213090657.28841-1-sergey.matyukevich.os@quantenna.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0273.eurprd05.prod.outlook.com
 (2603:10a6:3:fc::25) To SN6PR05MB4928.namprd05.prod.outlook.com
 (2603:10b6:805:9d::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.11.0
x-originating-ip: [195.182.157.78]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2187cddc-4778-4f81-a1d0-08d7b06418da
x-ms-traffictypediagnostic: SN6PR05MB5550:|BN8PR05MB6548:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR05MB55500B2E9D596227612CE10DA31A0@SN6PR05MB5550.namprd05.prod.outlook.com>
x-moderation-data: 2/13/2020 9:07:32 AM
x-ms-oob-tlc-oobclassifiers: OLM:901;
x-forefront-prvs: 031257FE13
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(346002)(376002)(136003)(39850400004)(366004)(189003)(199004)(2906002)(8936002)(64756008)(478600001)(81166006)(81156014)(66446008)(66556008)(66476007)(6486002)(86362001)(8676002)(103116003)(52116002)(7696005)(36756003)(1076003)(71200400001)(2616005)(4744005)(66946007)(956004)(4326008)(107886003)(6916009)(16526019)(186003)(26005)(316002)(5660300002)(54906003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN8PR05MB6548;H:BN8PR05MB6657.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: quantenna.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nd4ZpeOLbKduDHJbaiBHT0P80BbNwK6mPb4D/BHgfs+ylNMFYtoNaoclbYuONXcWkrzy0jDch1euMHuJalM5lkizyv1cjRYN8H4iUr95DPEpzMG3t2pW3KuP2Vr+V96+8jOEE/Quk2tVPBML/5dwIVx2e1HTCDgEQBc49pe/Jd0aO5HE9QVQm091nEUk1ReOhFRmGRAEPxCl++guqeExqUxE6f4+NgGrV9YSwy1jdDwU7HPA+CkrSm+ZIBAqswvUAChoFtNKxCHySSYxbMOZ8jIBjvEc+uaEVdfjdFdskekoaxHtA42r5npMnfCxYdhdT+8wlM4G8prtSXh4CyBxkrY2OnNInrpE/f5JxysMbWZw6EAf7scTOQc95J1JPFOhOgsRsaTCz+Aw+1O5IMgpb7dMv0bN64TlEg/m1gMZJaquCY/RvIWXcHeW6bRJHppS
x-ms-exchange-antispam-messagedata: BXTRTxBOwbTjEnYG51VCluFamghBvVCfcDZXuJ0blFjSQZP550D+85BznolXzLAw79gKiZ626pZxZQpHyss3u3fJD6TOsAGnJzfUQiMSQW5e+VrcWKvgpEcEZ7zuR/KVaj/HOHTAEvtFNuTTlVLT/g==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: quantenna.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2187cddc-4778-4f81-a1d0-08d7b06418da
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a355dbce-62b4-4789-9446-c1d5582180ff
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HbpAeCKqcZEOUd3riPI/WrX4VmY+7HsXA/keJEUp3P7XU4OKXgrF01pmipxa+B+3OlgMlp78r8ym6BIBrnnxS/04y20xNEFTa26svHL06ToI4XtMwn90MYGMshexpwoKT9EMepUOf7jgTD0gdg03UIfgBroAj0VOTXbZ7t6/xJjle7hSNDl9paTOg94V1j11j7c2YViAJodmqfMxyut3aOsxMPxiOICKoAGwoTgzLkY=
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2020 09:07:35.1029
 (UTC)
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR05MB6548
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-13_01:2020-02-12,2020-02-13 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 clxscore=1015
 adultscore=0 lowpriorityscore=0 mlxlogscore=958 phishscore=0
 malwarescore=0 spamscore=0 mlxscore=0 bulkscore=0 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002130072
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Do not perform strict validation of UPDATE_OWE command.
Otherwise, kernel rejects command executed by hostapd.

Signed-off-by: Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
---
 net/wireless/nl80211.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 33fe6ac1c242..92e0723c21fa 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -14837,6 +14837,7 @@ static const struct genl_ops nl80211_ops[] =3D {
 	},
 	{
 		.cmd =3D NL80211_CMD_UPDATE_OWE_INFO,
+		.validate =3D GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.doit =3D nl80211_update_owe_info,
 		.flags =3D GENL_ADMIN_PERM,
 		.internal_flags =3D NL80211_FLAG_NEED_NETDEV_UP |
--=20
2.11.0

