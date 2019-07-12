Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 123F5669E3
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jul 2019 11:27:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726069AbfGLJ1q (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 12 Jul 2019 05:27:46 -0400
Received: from mx0a-00183b01.pphosted.com ([67.231.149.44]:54420 "EHLO
        mx0a-00183b01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725987AbfGLJ1q (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 12 Jul 2019 05:27:46 -0400
Received: from pps.filterd (m0048106.ppops.net [127.0.0.1])
        by mx0a-00183b01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6C9QBFp006559;
        Fri, 12 Jul 2019 03:27:40 -0600
Received: from nam02-bl2-obe.outbound.protection.outlook.com (mail-bl2nam02lp2059.outbound.protection.outlook.com [104.47.38.59])
        by mx0a-00183b01.pphosted.com with ESMTP id 2tpm27rn1s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 12 Jul 2019 03:27:40 -0600
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YYN/0TgRBr4VZC02YLce0PwwM+90IiQ6aiCMf/WtzBCJuwESVfzSk83MhTbsB0kj3T3Bd0QS6HF0CX8XBrFWfbgtgPwI4SHLgcFSDZHt8bcXtnhraksmjAezTCsfJhNQQzt3bHIbd4/PljH9w+2jYVoWSPSmLr404rDfdcfNj/ni48KTLDF9vULZLF6mY8QPpE2rKbSV7Cli0D4ZrztiJfKQw62BfdT6fKtHUYbfjk8iLFPGRRzYXfsoS2yF3gfLVDepjqiHs7xKzchXCHX91Wvq/n1KVmXtA1MZou/B+5sONQIbctKDlA3hHf86rJHz+7yuGdRLELBsM3VpG4HP0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mwiaSKv9rCHiOrAUYZdMqc6ix5P+LUdjGgmUxwVB/h8=;
 b=Vj+iYRRBnLyvoZF7X+cyP08PuPKFh9gJEeat0DRMmomiQr8dVq9F+l+XNvPVXn3J5V98nI3FNiOHpXdxxJaG14txjIVwUtkhBkwH9oRw0Vy2LN/j4mdHj9v6LgawAdmwWVsDIerzHBaNF/IkeEHE6cIevTeNeVmIOBx8LwVCJTIITntS0+F4fsFUxQi+WFd3gUBExrUup+go25RuVku9Bn8T3V7/tY+SCye4kMTWygsMlsyUoXkjkTjYbuu3HnUX0jGfyaJZL3hK/NqdVAEIh88efZul0cyYjcV2VMU9Vu5523Iv1/ySD+IhiyyWy1CNcTdl/I3j6blo/3jNrp9MGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=quantenna.com;dmarc=pass action=none
 header.from=quantenna.com;dkim=pass header.d=quantenna.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quantenna.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mwiaSKv9rCHiOrAUYZdMqc6ix5P+LUdjGgmUxwVB/h8=;
 b=HY0nuHYI2KInP3UCK/APWyN+utT1ZXlAsn4i8M8oVPmCc1/rWlNnePHp+uzXRW/hlu6n+uaUZq6Ei8GpTCtWPg8O4Xww13ZVNchC9E88fVSaOXS3fdVBQURSY+4hAidt67VMO1PEIvlkBUZA+11Rw2QxSz0XZRhINzWMXMd+9Q8=
Received: from DM6PR05MB5241.namprd05.prod.outlook.com (20.177.223.217) by
 DM6PR05MB5708.namprd05.prod.outlook.com (20.178.24.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2073.10; Fri, 12 Jul 2019 09:27:33 +0000
Received: from DM6PR05MB5241.namprd05.prod.outlook.com
 ([fe80::c557:2bee:edab:666c]) by DM6PR05MB5241.namprd05.prod.outlook.com
 ([fe80::c557:2bee:edab:666c%3]) with mapi id 15.20.2094.007; Fri, 12 Jul 2019
 09:27:33 +0000
Received: from SN6PR05MB4928.namprd05.prod.outlook.com (52.135.117.74) by
 SN6PR05MB4624.namprd05.prod.outlook.com (52.135.114.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2073.10; Fri, 12 Jul 2019 09:27:22 +0000
Received: from SN6PR05MB4928.namprd05.prod.outlook.com
 ([fe80::13f:5819:79e7:ea8f]) by SN6PR05MB4928.namprd05.prod.outlook.com
 ([fe80::13f:5819:79e7:ea8f%5]) with mapi id 15.20.2073.012; Fri, 12 Jul 2019
 09:27:22 +0000
From:   Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
To:     Johannes Berg <johannes@sipsolutions.net>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Igor Mitsyanko <igor.mitsyanko.os@quantenna.com>,
        Mikhail Karpenko <mkarpenko@quantenna.com>
Subject: Re: [RFC PATCH v3 0/2] cfg80211: fix duplicated scan entries after
 channel switch
Thread-Topic: [RFC PATCH v3 0/2] cfg80211: fix duplicated scan entries after
 channel switch
Thread-Index: AQHVN0YTcguWGm31CkW9q/08y0KK9qbGtPyAgAAEdoA=
Date:   Fri, 12 Jul 2019 09:27:22 +0000
Message-ID: <20190712092716.ywnkns473s5rtoku@bars>
References: <20190710173651.15770-1-sergey.matyukevich.os@quantenna.com>
 <1c371a5921200a11da459b591df121bbcb0f967d.camel@sipsolutions.net>
In-Reply-To: <1c371a5921200a11da459b591df121bbcb0f967d.camel@sipsolutions.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BY5PR04CA0026.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::36) To SN6PR05MB4928.namprd05.prod.outlook.com
 (2603:10b6:805:9d::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [195.182.157.78]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ccc50efb-d945-417b-f9a0-08d706ab24a1
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:SN6PR05MB4624;
x-ms-traffictypediagnostic: SN6PR05MB4624:|DM6PR05MB5708:
x-microsoft-antispam-prvs: <SN6PR05MB46245D67238B7C65ED099451A3F20@SN6PR05MB4624.namprd05.prod.outlook.com>
x-moderation-data: 7/12/2019 9:27:31 AM
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 00963989E5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(7916004)(366004)(136003)(376002)(346002)(39850400004)(396003)(189003)(199004)(476003)(102836004)(6506007)(6116002)(3846002)(6916009)(2906002)(386003)(71190400001)(7736002)(99286004)(6512007)(486006)(33716001)(6436002)(76176011)(6486002)(68736007)(6246003)(8936002)(11346002)(8676002)(9686003)(53936002)(52116002)(81166006)(305945005)(81156014)(107886003)(446003)(26005)(436003)(66066001)(229853002)(66556008)(66446008)(316002)(1076003)(54906003)(14454004)(64756008)(66476007)(4326008)(256004)(14444005)(5024004)(5660300002)(25786009)(71200400001)(478600001)(186003)(66946007)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR05MB5708;H:DM6PR05MB5241.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: quantenna.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: BZFJVt25/tw679kU2jUT10nB8Zqoxn64C6wpF6PJv9vckuLaT5KhYA/tldj0uHNYHJQLO/vXZUZ2q4Iqu1pVodHSt05RffAwWodl/OeEVJBA59kZseHLuFzL35UoZBTwpz/SWEV7THCm24GzvWuc0W8wo7ZixLhLkerZwwzOB4b7wT4ehJD3HSXTpyN/Qh6W6qMHqCDil8LyQimYSDDMH/RM9xd/0UHIGla/znwYOOxYsRFzVQMrP3c1rVA8NrqRZOqLu/KblcAd6ubeQ+cw78luZYFM8U4dLM5X/elOOQ5EhDBCCFi9zoxfyzNiRihMwSRn90apGo8gyCZEwAatLyn5Oz4JFoNsGiJIHpBBXFcuxXjBZaOuiDOIgE/xVy4g1mtmExk30lNhjI7bK1SNEAES/CMuh81QGJOXGOOV2YE=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3AAE1AE67A76504DA71F078EBCA428D6@namprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: quantenna.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccc50efb-d945-417b-f9a0-08d706ab24a1
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a355dbce-62b4-4789-9446-c1d5582180ff
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SPO_Arbitration_0fc3d25a-4582-474e-a675-f5e2d79b83d6@quantenna.onmicrosoft.com
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jul 2019 09:27:33.6024
 (UTC)
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR05MB5708
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-12_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907120099
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, Jul 12, 2019 at 11:11:19AM +0200, Johannes Berg wrote:
>=20
> [External Email]: This email arrived from an external source - Please exe=
rcise caution when opening any attachments or clicking on links.
>=20
> > Suggested approach to handle non-transmitting BSS entries is simplified=
 in the
> > following sense. If new entries have been already created after channel=
 switch,
> > only transmitting bss will be updated using IEs of new entry for the sa=
me
> > transmitting bss. Non-transmitting bss entries will be updated as soon =
as
> > new mgmt frames are received. Updating non-transmitting bss entries see=
ms
> > too expensive: nested nontrans_list traversing is needed since we can n=
ot
> > rely on the same order of old and new non-transmitting entries.
>=20
> That sounds like a reasonable trade-off. I do wonder though what happens
> if we're connected to a non-transmitting BSS?

Well, here I rely upon the assumption that CSA IEs of non-transmitting BSS
are handled correctly by mac80211 or any FullMAC firmware. And if we are
connected to non-transmitting BSS rather than transmitting one, the
following code in the beginning of new cfg80211_update_assoc_bss_entry
function is supposed to care about this use-case:

+       /* use transmitting bss */
+       if (cbss->pub.transmitted_bss)
+               cbss =3D container_of(cbss->pub.transmitted_bss,
+                                   struct cfg80211_internal_bss,
+                                   pub);

In other words, regardless of which BSS we are connected to, the whole
hierarchy of non-transmitting BSS entries will be updated, including
their channels and location in rb-tree.

Regards,
Sergey
