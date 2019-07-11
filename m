Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B164A653DE
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jul 2019 11:34:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727946AbfGKJeC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 11 Jul 2019 05:34:02 -0400
Received: from mx0b-00183b01.pphosted.com ([67.231.157.42]:45512 "EHLO
        mx0a-00183b01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726088AbfGKJeC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 11 Jul 2019 05:34:02 -0400
Received: from pps.filterd (m0048103.ppops.net [127.0.0.1])
        by mx0b-00183b01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6B9UW4C032448;
        Thu, 11 Jul 2019 03:32:16 -0600
Received: from nam03-by2-obe.outbound.protection.outlook.com (mail-by2nam03lp2055.outbound.protection.outlook.com [104.47.42.55])
        by mx0b-00183b01.pphosted.com with ESMTP id 2tp0gh0997-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 11 Jul 2019 03:32:16 -0600
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HtPfberQ6UCMEctJdjNw9DB0EWmq0/UUO67P6n5Hp0/opUBStzyFRnsW4Oe9nsR6Ib2EhPTCTZ2avWga0S8Hto3+vAxPObKOHrYzep3uEdiI/bbty/597LTTpIP0RjMkTf0Ufoa20USfp25vy3DrpUuJ4hYIcr1f+dE12fD6yUmXYQCwN/Yl2e8G0naajIS8d7Mj+2wlgiMQETlIhIfwq/0p6oAqtamMfjRtx78BLHQFOYIroTBLvzaGIrcHdNlIzW2Hng0ZubaKLQbvdmoB3ni1CNWQ9U/iT45jkCSezZA4GW6GyiXzOylgPGEoe3jz0ixsvV61lAGhbAEuM2DfCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ekpHVUHTZT0UgCcZVxa+i7uIKRVUcR6dwU0JzkQWCsI=;
 b=oLhqlq4J9x6Alnzlee9hjTSpi1BzzePVoMEJw4sNSSIBdGXflAGfyqVVesnfiWZf0KlzZfkUihL1Lxq6RtmeWeBNu0d+2VPAXmkJceFhJCy3MnpWSEY5n+vsZ766odL+kzAtnQ3rUFBCgbMyhZEDVAnMsdNRRPMdqVeDwDAQ+rA4sbJZL9mpDse7wfkpenG0Oau5k8MIV99Mw+sIzzRIjjnA3LjCIAAjKDC4bXTCcx/C40zxZa1g4yuFtA1Uiw+eDdfWh6lmDNlPx0s/aotHS9ctFZfgNkzQNDHYykT7GjoDw/j0iilZ1DKou0iEh5OVwWIokIz294zRARcMvfXVig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=quantenna.com;dmarc=pass action=none
 header.from=quantenna.com;dkim=pass header.d=quantenna.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quantenna.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ekpHVUHTZT0UgCcZVxa+i7uIKRVUcR6dwU0JzkQWCsI=;
 b=O306e+PBhGY/KpLYBjOEJZ9cl3ovjL7qCa9nTDCCDvhJ5sxGk3Hnt5K8notvIHOsempI16Mouq4pAHbSgYp9QQMWUXjpPNzZnuxoZcM+HIvlGNt5xygGwfOUcFDpgqwCYjFcT1XeGKU4OnOJXET/duUoHUKsVqjnvvPjndSrZXk=
Received: from BYAPR05MB5352.namprd05.prod.outlook.com (20.177.127.161) by
 BYAPR05MB4599.namprd05.prod.outlook.com (52.135.233.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2073.10; Thu, 11 Jul 2019 09:32:14 +0000
Received: from BYAPR05MB5352.namprd05.prod.outlook.com
 ([fe80::2c06:ca9e:ccb3:f288]) by BYAPR05MB5352.namprd05.prod.outlook.com
 ([fe80::2c06:ca9e:ccb3:f288%7]) with mapi id 15.20.2073.008; Thu, 11 Jul 2019
 09:32:14 +0000
Received: from SN6PR05MB4928.namprd05.prod.outlook.com (52.135.117.74) by
 SN6PR05MB4509.namprd05.prod.outlook.com (52.135.74.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2052.9; Thu, 11 Jul 2019 09:31:39 +0000
Received: from SN6PR05MB4928.namprd05.prod.outlook.com
 ([fe80::13f:5819:79e7:ea8f]) by SN6PR05MB4928.namprd05.prod.outlook.com
 ([fe80::13f:5819:79e7:ea8f%5]) with mapi id 15.20.2073.008; Thu, 11 Jul 2019
 09:31:38 +0000
From:   Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
To:     Johannes Berg <johannes@sipsolutions.net>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Johannes Berg <johannes.berg@intel.com>
Subject: Re: [PATCH 1/3] cfg80211: clean up
 cfg80211_inform_single_bss_frame_data()
Thread-Topic: [PATCH 1/3] cfg80211: clean up
 cfg80211_inform_single_bss_frame_data()
Thread-Index: AQHVMaSdxNwb2pUQcUO+RWdDkAFowKbFM5GA
Date:   Thu, 11 Jul 2019 09:31:38 +0000
Message-ID: <20190711093132.zydtcrkwjvmvmjou@bars>
References: <20190703133823.10530-1-johannes@sipsolutions.net>
In-Reply-To: <20190703133823.10530-1-johannes@sipsolutions.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BY5PR13CA0020.namprd13.prod.outlook.com
 (2603:10b6:a03:180::33) To SN6PR05MB4928.namprd05.prod.outlook.com
 (2603:10b6:805:9d::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [195.182.157.78]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6bd21e12-be1f-40fc-1cb4-08d705e29323
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:SN6PR05MB4509;
x-ms-traffictypediagnostic: SN6PR05MB4509:|BYAPR05MB4599:
x-microsoft-antispam-prvs: <SN6PR05MB450922815179913DC43DAB05A3F30@SN6PR05MB4509.namprd05.prod.outlook.com>
x-moderation-data: 7/11/2019 9:32:13 AM
x-ms-oob-tlc-oobclassifiers: OLM:747;
x-forefront-prvs: 0095BCF226
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(7916004)(396003)(39850400004)(366004)(376002)(136003)(346002)(189003)(199004)(11346002)(68736007)(446003)(52116002)(71190400001)(66066001)(76176011)(6436002)(6246003)(66476007)(476003)(5660300002)(256004)(66556008)(229853002)(66946007)(71200400001)(6916009)(86362001)(486006)(478600001)(14454004)(33716001)(558084003)(6486002)(4326008)(102836004)(7736002)(305945005)(25786009)(81156014)(6116002)(99286004)(386003)(316002)(54906003)(2906002)(26005)(186003)(53936002)(3716004)(8936002)(6512007)(436003)(3846002)(66446008)(64756008)(81166006)(9686003)(8676002)(6506007)(1076003);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB4599;H:BYAPR05MB5352.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: quantenna.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: VWI91gP8oD3vt3dvdESFcERuDzQcPkwhOYNbuVVzkT15NDzM3PovDkU8Y5sY1JBJJXvZl09kEeD9CWE9dK1w1VyWqWSIkSwBo6pfufdlBzBS1bDwc0LOQjyv7Gfdwr+74tKrziPYJzfC60ZkJGwRxIzowVXwdI/ZUC8SrUour+SVpNR/SxVZvwCEJwBw1aubcg2Fa+jkZKNQgC4WTYF0vnIuSu36amJ87sinSlAt1Azf/NGGAj6Be9PigclZ4GR+LmRvXh2NBlx7hm1tkDJNgY4ukci/43xGt2w1ILr7+wwxEcrYZTldlD9InnF3qK+z78V8HGX8868O1ettvrC5mVGrRDQV+hWe8PLAzpJ4hbeLZeJd7M/sk5uUmCHZSbMRwwGFEeLd+W0uGygBMbFEYtaTffK2/LecC67/x86Pgo0=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <87F21C31C78C144DA2018537F94F1EED@namprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: quantenna.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bd21e12-be1f-40fc-1cb4-08d705e29323
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a355dbce-62b4-4789-9446-c1d5582180ff
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SPO_Arbitration_6a889b2b-c765-4c2b-b3ae-bb5bc5580253@quantenna.onmicrosoft.com
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2019 09:32:14.2834
 (UTC)
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB4599
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-11_01:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

> From: Johannes Berg <johannes.berg@intel.com>
>=20
> cfg80211_inform_single_bss_frame_data() doesn't need the
> non_tx_data data argument since it's always NULL.
>=20
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
=20
For all 3 patches:

Reviewed-by: Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>

Regards,
Sergey
