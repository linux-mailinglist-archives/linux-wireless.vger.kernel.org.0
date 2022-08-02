Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2D4A5875A1
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Aug 2022 04:49:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235779AbiHBCtL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 1 Aug 2022 22:49:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232606AbiHBCtJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 1 Aug 2022 22:49:09 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEBBF1AF28
        for <linux-wireless@vger.kernel.org>; Mon,  1 Aug 2022 19:49:07 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2721qZMC019711;
        Tue, 2 Aug 2022 02:48:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=qcppdkim1;
 bh=dbJEAdpVAvKg+HcE9uqIZni/UMt0yUZJhvX3pueYkDQ=;
 b=dHtZtVuwptuNDdxYns/SnYueXhpdxooDUm8PRVIrx0JOivTeSbdKIfbC6PIfjSD5g6pH
 N6KEiOdvr5qOuajGvEqclv9pX1MyW1AnSHUaQWmzPKxMFLhpPXntQGybuxYiEuHWknpf
 +SwE6rEgr/G3ALTTwKqoDrZvIk2JycNwXjbQfq/1gPSeMKgSzwU+L7t3SLo6nY+OYpe3
 BIlFhXLX6XI8biR7XE1ZhZqYL+vypOKFWj7zNc2fsZVaq68O//BKXh/1GZAC5fPDnW37
 J6FSRm47eUqd89qRScUQBYaM+g1upoJsZBfT2glISPOzp1jKG0TmH0fsg72qEcTD+3BB JQ== 
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2104.outbound.protection.outlook.com [104.47.58.104])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3hppa0req7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 02 Aug 2022 02:48:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DKvWPqDDw2fbJdwybkuObDUYtHxmBLs/h+sZjPeotbmoQsokoqnGB25Njrp+96OMbomP6DIQydIwZHeZ7eNiP2PO/0kbP4hlvxtnux8oQEC/tzlcQFmw/kISx5fwL+d97UqpwGveO8/Ev68DLkr1481oUtrCb054qnrkmHZOSZYjafle/kXJiGympaGG8ezmeXpeIudCmZzdVQ4qxji2foMlQWU05A6vTT4sfWzlal8ie1wE2PE0UXTnt29e0w1Xephe9Hnju5fM6sS9H9cy9t97cUnne9yp7MIbFixJSoopFcO6eDuBebtucvb4hPjjsmkDyThAV4w8KVjh8Kt7tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dbJEAdpVAvKg+HcE9uqIZni/UMt0yUZJhvX3pueYkDQ=;
 b=Y/Q/Ux05c7B0yNBHHwLf5vmLN7FN8xwOGzXJ+lC/NKVZmZDzTgR+wFqNiTC+ZglNN/k1nG42F4QPYPZSV4lj1hjuWjvxUtl3+i9FC1V3tIUGQ58h6yRjGhAZosg7Ii+SnomuZ6rw1C6X8Hv/+SpQlowNoXLVjaUxrQ9QFoDGQJIjUtexd+YLuApp3HXvbGzycVqSCWsFAaUIaCE2DzbJLVEhi4ZufNwNWDuzqrD2b3+knKQjFqKh3Fw52QriKgt1ot53Dfws/rzqKD0x5qKfffvRJQOma+Ef/wCcZDcEPKWNZgH4JGnpaphXYUI/lyRGsU36DBoacW9S5uaYF1i3lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
Received: from SN6PR02MB4334.namprd02.prod.outlook.com (2603:10b6:805:ac::20)
 by DM6PR02MB6634.namprd02.prod.outlook.com (2603:10b6:5:213::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.11; Tue, 2 Aug
 2022 02:48:48 +0000
Received: from SN6PR02MB4334.namprd02.prod.outlook.com
 ([fe80::70cb:fc3b:3525:43b7]) by SN6PR02MB4334.namprd02.prod.outlook.com
 ([fe80::70cb:fc3b:3525:43b7%7]) with mapi id 15.20.5482.016; Tue, 2 Aug 2022
 02:48:48 +0000
From:   "Sriram R (QUIC)" <quic_srirrama@quicinc.com>
To:     Kalle Valo <kvalo@kernel.org>,
        "Sriram R (QUIC)" <quic_srirrama@quicinc.com>
CC:     "johannes@sipsolutions.net" <johannes@sipsolutions.net>,
        "nbd@nbd.name" <nbd@nbd.name>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH v2] mac80211: Mesh Fast xmit support
Thread-Topic: [PATCH v2] mac80211: Mesh Fast xmit support
Thread-Index: AQHYpXUVFTNQRUv3A0ywBopbgbcsBq2ZzmMogAEbN1A=
Date:   Tue, 2 Aug 2022 02:48:48 +0000
Message-ID: <SN6PR02MB433460ED656B8A53E9A200C8F79D9@SN6PR02MB4334.namprd02.prod.outlook.com>
References: <20220801070418.5420-1-quic_srirrama@quicinc.com>
 <875yjcjnlz.fsf@kernel.org>
In-Reply-To: <875yjcjnlz.fsf@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 34142f7b-1ab5-4e8e-7a2c-08da7431863c
x-ms-traffictypediagnostic: DM6PR02MB6634:EE_
x-ld-processed: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dENPPU3RW2s/uvRGuFz8wCznHyxLA6uzzsGgElPHSQgiNakhGvsX35oHGalk3nMPTSUyyZj6kPwRxlBOhWwe1nQrNuzC/bVMeyPjwzOLGLjM2wZ498cDcguC61cH3FHuJcZlupkAEdiHUuYIov2WktgzhrP22o4txIB11mFVH9x5rTTHwB3j+CcjalinCUDhnVZ8i78vy02pyhFOyokN20vUYZ3W76yRhHYOeq2phhBoznplcOrxHXT8RcS1dFGU7MJFd9JonYRC+puMARX2NSMu1ZeXxFWf3TvKrgs2ZLaVZ97o9D72dxEZN7i3zsTRMq3ETe+nxn1JhzULcr2XhmxsrnRd8b2jcRdLXKsnxaecTlHod3G5USfGVIu3kFizxj4MMRsw67d0tacLEsYuPMbHSfZPL4pIwwvyTCBGKItqkz7ZhpZFW8KNGG99KJ/BUFFHDkSVGBjlwuYqhIEoGA7zwYmXinTt5tKpgajpxePxFrEaKxsZr/noJ3kqsRdAHFjFshB5mv8ztGS6nTKGx+sevvbl0NSwqfC5wGXKZgALmq4xEuhAwiVcAqGKoe0p+xYpHuFVIlVWPk/8LiwIm/w5wyfl3ULNFYr4SzuBf6YEz2ZsBy+v5KQxbZwxksBqmUg8AbdrSiA51vdSLZwBFUqxoYyjGPiH5CfdMc9bTZqaI1cZloJSaHJBq8wQwWLynNEKubNycP3uI0jpjxUx/P/+v/m+t4NxleQvzQ6AcUsBTwEUwYg6Lb9obK0zU8UL0kpJcp+NF9VuL/C65BlfRTZar8+MP/M4Q/95pgefwTPCno2jiUlQODKZLABNHiHp
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR02MB4334.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(136003)(396003)(366004)(376002)(346002)(5660300002)(186003)(76116006)(66946007)(8936002)(66476007)(8676002)(64756008)(4326008)(66556008)(66446008)(33656002)(52536014)(2906002)(316002)(558084003)(478600001)(71200400001)(9686003)(26005)(54906003)(110136005)(55016003)(41300700001)(86362001)(6506007)(7696005)(38100700002)(122000001)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?svLLWimXtIAuEuVoZHzO7QBHVo6T6ar1ZMHCDOYB2okv7eM3SMqKiN7UjtQy?=
 =?us-ascii?Q?iof5BDv7SgSqRDnN2QjptC+b+Fzfug//BZI6jab7zlg0sgcVlsmFt6iGS+rg?=
 =?us-ascii?Q?shVH31aHX4D5fEQ/Cs/+jDFCV6GQtkE0n2qJk7xurKhZqJMu9DGEOpZm/mkT?=
 =?us-ascii?Q?DTtvDbnMA6vsFCCRPyFmVs8ic3m84Di8NlTPzhJBfkY7LoIP9d6ic/RfY1lz?=
 =?us-ascii?Q?yw86TEhYQDheYhaGAXlI9U9I9rGcLe3zwmPdQYG1C/DhJQqmkPGiCi1HGnZF?=
 =?us-ascii?Q?lRoxi/hwqdrY9SNLR3v631SCuEtTnqKvoFudwircTJ4ptXpQisAq112x7Fmb?=
 =?us-ascii?Q?4pXJdcT2qDpkCkxM/A8bb3xTUqrPrvsKYK5jOianEPWwJVyjgcpkMkJbetEf?=
 =?us-ascii?Q?fBadUJnzmNHRw8xlI368GoKDRyt/3C4NAIqcUbYcervDYl6QVje5Jynj8yMx?=
 =?us-ascii?Q?AcJXS7Q76K17QYd1lqIG/DYd9wQxIduKTfRc6W9AugifExsSUUsruBAPdlUn?=
 =?us-ascii?Q?ROShmdTO0jiRlsAsi+dWfsyo4LvCyy+qZXqeNKmrNRllfvFojjC1lKBxQ/Ka?=
 =?us-ascii?Q?93TpXoDVCVtXG82aSOgcPrfe7LpKl1GqiM9Neek4v2khl49hiCGzefJB/sfm?=
 =?us-ascii?Q?jDO81Qvt6+9Zsbad653MhcLo+CL/plkUef6DSdkk7TE8yWJ86rjoNAV/dnnz?=
 =?us-ascii?Q?S4nR7PmjkRZVq8V2Ctn6FCdhnf4dWRs33X7b1mwkK0Xkw2qqUhWAzi7ZkFN9?=
 =?us-ascii?Q?Xj4njmddGoRhqGtlNcuqDcURQHp3y2XBunREuP2hA15hLpJJj+jn1hbKwxtZ?=
 =?us-ascii?Q?WNEOMT/e5aH4PzV+LLEWo4Ndqbu8WoAwBq5/0pcKu0upuK5Fs4ycyK4ytC+G?=
 =?us-ascii?Q?XTo0GgiVlUbjjPXm7XsNP4PHhycm4tYr+ALFY1KenpUQprLs4HmgmWErwTH5?=
 =?us-ascii?Q?vFNkaozBMIVtGGr7whJ6k1A8iRTlKCeAk8ii+U6tsNyyeEzp7wTPR/OeCCNa?=
 =?us-ascii?Q?V6Grr5XX2VxtUqnQacHErlS6cFPv6EGFBX9aMDR5aAQsyPOC7H993EZwLAb3?=
 =?us-ascii?Q?dJGbnuxPKR1QY5GXQ08vIZP9SqynF5TeXOS0sOahWNqSNSyamlfhuohqGdwL?=
 =?us-ascii?Q?zXTcVOYHoXsojCMmVwTVlXX4OltoDrgHFRr05+ezLI/ohpdJCErENAr5QUym?=
 =?us-ascii?Q?IkZHBtnkDNHd7yR9qXlL9HDV6C6Pd3THXo7pTJ+XEGcifLGHjgi2UOVS2HDD?=
 =?us-ascii?Q?Ww9/gP/H94c/Pv5J6h8+RvNF22FabM9wX4dtoxpm2qUxBaMpnUbVMFTNFROk?=
 =?us-ascii?Q?1QGDa03O6dq9CBVzuldTrbtPdK8NqhwgjfOm8mLwhmEomO7LZaM8tyUM8bnT?=
 =?us-ascii?Q?C0fgCfDxr7FlQG9Rq5rSHbCcNDKfE1AyOdniQ+FcFcz+fVS7PteNsP2dsNZw?=
 =?us-ascii?Q?EzmG5vKpSnLpRORT7UKobRv+PxNe6V4oZPgQxHuLhsWNoZK71TZw3SXLIgeP?=
 =?us-ascii?Q?739q8Art6qbO9c0RQ2wE+rC9d2QGgtxuCh/8JTlY1hTEggBGAtBzVIXKmSMb?=
 =?us-ascii?Q?g9ponDfVl01eYBEI/lCn053W2H7LAgryfX3C8z5g?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR02MB4334.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34142f7b-1ab5-4e8e-7a2c-08da7431863c
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2022 02:48:48.0051
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: v/DOrWeZAkz/p0tPgT/WOHWwX39Bm/gnvx5GtsuEV0R9O9J4bZJ+F9GAs+sA2rWTYW4Nz/yyiTOI41GZzdyqCKxiE5y84xKRm77FJ6DhOoU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB6634
X-Proofpoint-GUID: NIz2-zgJj-VpAm7u0stbJa1oXbfKeqEW
X-Proofpoint-ORIG-GUID: NIz2-zgJj-VpAm7u0stbJa1oXbfKeqEW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-02_01,2022-08-01_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 mlxscore=0 phishscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0
 bulkscore=0 priorityscore=1501 clxscore=1011 mlxlogscore=509 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2208020012
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

>
>The title should be:
>
>wifi: mac80211: Mesh Fast xmit support
>
>But I suspect Johannes can fix that so no need resend because of this.

Thanks, I missed it.

Regards,
Sriram.R=20
