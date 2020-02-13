Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 27BFF15BDF4
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Feb 2020 12:46:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729820AbgBMLqF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 13 Feb 2020 06:46:05 -0500
Received: from mx0a-00183b01.pphosted.com ([67.231.149.44]:33372 "EHLO
        mx0a-00183b01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729511AbgBMLqF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 13 Feb 2020 06:46:05 -0500
Received: from pps.filterd (m0048105.ppops.net [127.0.0.1])
        by mx0a-00183b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01DBh1S5010035
        for <linux-wireless@vger.kernel.org>; Thu, 13 Feb 2020 04:46:04 -0700
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by mx0a-00183b01.pphosted.com with ESMTP id 2y1ufxergv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-wireless@vger.kernel.org>; Thu, 13 Feb 2020 04:46:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SESsLZ/EmHO7jvRmRNC1X4W4rwmblcPhYjPnzf+KTssjCsMFg+KIGXZLChjscmLQtbtwgq152m7b6hEuu6BlZnNL9wrdLgPED59V83IHhJ0jFNIRnMWoK4vvfp8QWYbKm8gfIwiggjmEITIkbI/lCS0LNDTGxprcyvVQ/OfqGSyvddXIXZuNer/T3VzivnarP8qCABr8K2YmgCnNaprRa9p9W0QdbZSAQovECua5xfD1OC/YObBGC4fiQxG5Xwr+ulf9cVgA0Us2UqcmJra3c0LpWgmSYCtD0d67JmMO2muQ50s6h3O+bz7lfc+P3eP6Hdw7A4LduD8fMhIgGPv/yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/4PwYidN/ADXtQtXEYXSzCdpdzu4ZaPnW2+Xc74MbT4=;
 b=RROCKTx3pDiNOG/B8IAqhSPy6bzqB4bHfWEoQIqCy+0XnaTBHhOdkAlK8G1CTwgeV9bBalBrFwa1b/BVhtYd5r/AcpC7N0d+OlK96mw9x2a5Yq2V3wPCMPFSxOjHSbEGLXIWyOZEfUXWPs7xiGhbnwk8h6dTBl70s09zGRGARI030kbhO8uy/4Dlb9QOVBCYcO9czykp7YM8D98riO+T7ZM08N8shP3mFh+RbWWllko/GoE1HVhtKCbv/KRrstMSZ97O1UJ9x06dqCyQpcCLR7ToXb2PNJGM6GwvPBRMsoL8qM7j1tZxTUlPdXYF3uBu3DvvWaDLcyXF2yqA9uWwWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quantenna.com; dmarc=pass action=none
 header.from=quantenna.com; dkim=pass header.d=quantenna.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quantenna.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/4PwYidN/ADXtQtXEYXSzCdpdzu4ZaPnW2+Xc74MbT4=;
 b=PsIgWXynR52mWLsjZ2SVYfvQ3VKmWPni1fEvyrQ0d036bEwogTIxjIPEYmIheTf1kMwaSL3uoZteyrRgkEcjapyVstfSNKNFUWVgtB9sPzt+oEMkVoWIS2o4mTCBoSsjJIm3niooJ65eggjjp3/vsqVxoLVKrMdDcBCr1F+xC/4=
Received: from SN6PR05MB4397.namprd05.prod.outlook.com (52.135.73.16) by
 SN6PR05MB4560.namprd05.prod.outlook.com (52.135.75.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.16; Thu, 13 Feb 2020 11:46:02 +0000
Received: from SN6PR05MB4397.namprd05.prod.outlook.com
 ([fe80::d002:cb3b:6c19:8b96]) by SN6PR05MB4397.namprd05.prod.outlook.com
 ([fe80::d002:cb3b:6c19:8b96%6]) with mapi id 15.20.2729.020; Thu, 13 Feb 2020
 11:46:01 +0000
Received: from SN6PR05MB4928.namprd05.prod.outlook.com (52.135.117.74) by
 SN6PR05MB5597.namprd05.prod.outlook.com (52.135.111.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.16; Thu, 13 Feb 2020 11:45:30 +0000
Received: from SN6PR05MB4928.namprd05.prod.outlook.com
 ([fe80::25b7:98a0:c066:1a9]) by SN6PR05MB4928.namprd05.prod.outlook.com
 ([fe80::25b7:98a0:c066:1a9%6]) with mapi id 15.20.2729.021; Thu, 13 Feb 2020
 11:45:30 +0000
Received: from bars.quantenna.com (195.182.157.78) by HE1PR05CA0129.eurprd05.prod.outlook.com (2603:10a6:7:28::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2729.25 via Frontend Transport; Thu, 13 Feb 2020 11:45:29 +0000
From:   Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC:     Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
Subject: [PATCH 3/5] qtnfmac: set valid edmg in cfg80211_chan_def
Thread-Topic: [PATCH 3/5] qtnfmac: set valid edmg in cfg80211_chan_def
Thread-Index: AQHV4mMXAwb/JCOU2EiG4m8XUoR+3g==
Date:   Thu, 13 Feb 2020 11:45:30 +0000
Message-ID: <20200213114518.4415-4-sergey.matyukevich.os@quantenna.com>
References: <20200213114518.4415-1-sergey.matyukevich.os@quantenna.com>
In-Reply-To: <20200213114518.4415-1-sergey.matyukevich.os@quantenna.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0129.eurprd05.prod.outlook.com
 (2603:10a6:7:28::16) To SN6PR05MB4928.namprd05.prod.outlook.com
 (2603:10b6:805:9d::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.11.0
x-originating-ip: [195.182.157.78]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 379374d6-27ca-43a7-634e-08d7b07a39f2
x-ms-traffictypediagnostic: SN6PR05MB5597:|SN6PR05MB4560:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR05MB55974F8EADB9E48D008ECA8BA31A0@SN6PR05MB5597.namprd05.prod.outlook.com>
x-moderation-data: 2/13/2020 11:45:59 AM
x-ms-oob-tlc-oobclassifiers: OLM:102;
x-forefront-prvs: 031257FE13
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(376002)(39850400004)(346002)(396003)(136003)(199004)(189003)(6916009)(36756003)(103116003)(26005)(71200400001)(2616005)(4326008)(6666004)(66946007)(186003)(956004)(16526019)(5660300002)(107886003)(478600001)(66476007)(66446008)(81166006)(6486002)(64756008)(66556008)(2906002)(1076003)(8936002)(8676002)(81156014)(86362001)(316002)(7696005)(52116002)(4744005);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR05MB4560;H:SN6PR05MB4397.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: quantenna.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZhBN582WFq2j7d76aWWj3DwaKddgEt4l8gPdchC7trSbt1/4ek5AJehY6z1UGNLITsZkllNFHWSno8SkCBPn2pgf2d0Qcl93hvKqyL5LrwjGWrXqVyZoyekisgtlRIzk9jRx2G+8OYTmtOunrg3BB2w/160S+yNLPavXb5Rs+hLc7E9dpW9VMUr4PnTlIQi5CbLTrYJDSSV5fsEuZveb9wpW/7vLg8wvCJieamRbsIMmXoVh6khj4VMS4jCAC+lwJWN34YSxNPso6ZJV4Wwh6/jeOIqvjmwtbnDUY1Aay2T4BsmgkqOb0z6XkZoApiNGnFzKAJK5Emagvz9itQrR3eIMzED3b5ClWpne2bbTwM9EzzHWCPH+njcy/yePMaN+LtFvBBP1FjT2QCLANFzTCVQOAroeBGS8Cs+zqiS4SK+j+uNWGHJ3mzEpUBlsJhWp
x-ms-exchange-antispam-messagedata: TH0J+FLi2KcCtFyZRKE/pRkt/FI0HBKHgJO2Z3lkoqaRI6ZnMGhBEph4nK6Ag1dC5/i9SL14eBBeH6nqDqupp/DfFCAguz6mkYg24uuro9rpiJ6Xksmw6K7tfTnxJiCufzPDRF9QembR3Eiq2zRIHw==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: quantenna.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 379374d6-27ca-43a7-634e-08d7b07a39f2
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a355dbce-62b4-4789-9446-c1d5582180ff
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ubPcpsNoAmNEp6Zy3Oai7cybGNvSyZm2w5IePlxp/HYBBdLTRf6xH04EmtxtryG6Viy7TIAwm3lmFc6rmZmCd0kn6tZPDtQCtmNVSjD64EGNMb4hqNE/uFj9AoHG1S6XoBciO+/4Hyog2/KH2wDVkghUw0jnGrqXeLO4yI4/pnbEQ/hn91Ssu7zvSC6CWNtcISmicpQZLgPkTbUsJlpaz8BI8tr7QYCROIP8KrfJfxw=
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2020 11:46:02.0074
 (UTC)
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR05MB4560
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-13_03:2020-02-12,2020-02-13 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 malwarescore=0
 mlxscore=0 impostorscore=0 phishscore=0 bulkscore=0 suspectscore=0
 mlxlogscore=769 lowpriorityscore=0 priorityscore=1501 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002130093
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Make sure that edmg field of cfg80211_chan_def structure is properly
initialized by zeros. Otherwise cfg80211_chandef_valid may return
false if edmg fields contain some garbage.

Signed-off-by: Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
---
 drivers/net/wireless/quantenna/qtnfmac/qlink_util.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/quantenna/qtnfmac/qlink_util.c b/drivers/=
net/wireless/quantenna/qtnfmac/qlink_util.c
index 1a972bce7b8b..30b60d6ae546 100644
--- a/drivers/net/wireless/quantenna/qtnfmac/qlink_util.c
+++ b/drivers/net/wireless/quantenna/qtnfmac/qlink_util.c
@@ -124,6 +124,8 @@ void qlink_chandef_q2cfg(struct wiphy *wiphy,
 	chdef->center_freq1 =3D le16_to_cpu(qch->center_freq1);
 	chdef->center_freq2 =3D le16_to_cpu(qch->center_freq2);
 	chdef->width =3D qlink_chanwidth_to_nl(qch->width);
+	chdef->edmg.bw_config =3D 0;
+	chdef->edmg.channels =3D 0;
 }
=20
 void qlink_chandef_cfg2q(const struct cfg80211_chan_def *chdef,
--=20
2.11.0

