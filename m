Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87F5A6E4B7B
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Apr 2023 16:32:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbjDQOcC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 17 Apr 2023 10:32:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjDQOcB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 17 Apr 2023 10:32:01 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F7955BA6
        for <linux-wireless@vger.kernel.org>; Mon, 17 Apr 2023 07:32:00 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33HDFCCn000781;
        Mon, 17 Apr 2023 14:31:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=qcppdkim1;
 bh=nZjAzWPJuR/lmJQX+H2xmxUYlPZSmguxNUOgmfWC8I8=;
 b=ldP0yMdeo23C1WXRG1iahiPNQWazlv0o6jgMoI5qZAMzAQSON9RdRh4F9Jzpje6HxCco
 6SQ5WQXFYKmz+n77IP3bPyXcVi/a23JeuvKVWqTxIKhHaEQLI/Qj0YRv91N5a5VNpGsN
 z1e421iyFd9vhmk8pEONztg6nSTvYUF1X7tRwsb/VwJiwViIot70Z4t2WcHrKgq25lsu
 cBAx9iZqYmHYA9OAXXIwgemNphF+qjPehqqednCTU8Q5/aH/4e9Kk/kdIsDj6JDKaWkH
 msYKND8K283/7x6sEqZWjhYHxv1CnzaF8gOH7ZuxK2/Yklpa/qT8ECPbvjrBYLh2zMtj WA== 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2106.outbound.protection.outlook.com [104.47.55.106])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3q12ut8sue-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Apr 2023 14:31:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZLVhvO8q7b1Fv6YxgQuTTvGmLwU3jRS3PwlVl6fnmN52fG3RMnoTkiQlZSEicD+NmBDun1cYbYp30Og4vvMMDu1/BZdXVn3ujtuBZxib618lAMm90ak2ItYZWY6xOyEOhfKhU+vRio+X7NQunBy3EYJMQwYQz4GU5wMpEdpwiHI7Zr+y3TpMwucKAO5OZHb8bawENNYKVrpU52YprwHssHDIT/NSzG1aAtAFkNrfeY39xmpo0gGKQUryxqOhDuAZYnopJeRX9TRSG3IuiQehySQfN5xEJ3m2jXpbPeio+ckvAbocTSY0Hv/lbYhN6Zg1tqwyk8rZ6HfLGsJONIfZ2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nZjAzWPJuR/lmJQX+H2xmxUYlPZSmguxNUOgmfWC8I8=;
 b=mmdkd92w4Mh7k73vc/M2F05wax+8MNwpPeLreriif6wfySFbthpatJM8OOFKpYDx+XK1rrni2a1ChVHr5QJm1WkvLPCFAKht3FQeZLRBjAbTsHFPdScyT9FSAuIaqy3siKeTqFgAwFJ2A2th4Lq3ZHFKwkqY5aQkFwU0l3b2SQf0eo+XR4UIUt6hmYSJYJFxp+N8an254qX1T/66690b9131DxTO5/icmETkbK5jo9CxBhB04R551K1fcL297ydZPw+hn/2V0UEYZL0VPOe/LvwDvqwf5X1AxNwUiwtvXIcYxQexOlvGzhhaB6x5sHuL0brTW1mAlaWNK3JWFPSntA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=qti.qualcomm.com; dmarc=pass action=none
 header.from=qti.qualcomm.com; dkim=pass header.d=qti.qualcomm.com; arc=none
Received: from CY4PR02MB2536.namprd02.prod.outlook.com (2603:10b6:903:71::7)
 by DS0PR02MB9222.namprd02.prod.outlook.com (2603:10b6:8:11d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Mon, 17 Apr
 2023 14:31:24 +0000
Received: from CY4PR02MB2536.namprd02.prod.outlook.com
 ([fe80::c7cb:8ef8:8058:6af7]) by CY4PR02MB2536.namprd02.prod.outlook.com
 ([fe80::c7cb:8ef8:8058:6af7%7]) with mapi id 15.20.6298.045; Mon, 17 Apr 2023
 14:31:23 +0000
From:   Ramya Gnanasekar <rgnanase@qti.qualcomm.com>
To:     Kalle Valo <kvalo@kernel.org>,
        "Ramya Gnanasekar (Temp) (QUIC)" <quic_rgnanase@quicinc.com>
CC:     "ath12k@lists.infradead.org" <ath12k@lists.infradead.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "Karthik M (QUIC)" <quic_karm@quicinc.com>
Subject: RE: [PATCH] wifi: ath12k: add wait operation for tx management
 packets for flush from mac80211
Thread-Topic: [PATCH] wifi: ath12k: add wait operation for tx management
 packets for flush from mac80211
Thread-Index: AQHZZ4IPExKM3Sc9TEmK1AyvvEk4m68viRacgAAYRlA=
Date:   Mon, 17 Apr 2023 14:31:22 +0000
Message-ID: <CY4PR02MB253674B0BA0767E1504B76B8F19C9@CY4PR02MB2536.namprd02.prod.outlook.com>
References: <20230405054646.7300-1-quic_rgnanase@quicinc.com>
 <87leiqwttz.fsf@kernel.org>
In-Reply-To: <87leiqwttz.fsf@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY4PR02MB2536:EE_|DS0PR02MB9222:EE_
x-ms-office365-filtering-correlation-id: a0721236-9ef8-41ee-ba2d-08db3f506b0d
x-ld-processed: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EupyXEiwhmKr3NdEsd2W2dI0rekM/0b1rGFRkY+89KyzYYiu62/w6NCmyT78oBKyf2Gu3Tj/CtUxHG2ukMd1OOhd1dig2iHOPpCr+lFf8+ObhIi8PBNQAx49mt/UTlJcO3VCvhwR3gF2lI3tjnHuS5pNmSUXV716XSFE59623dgylWsrPI9wAwaX7L6/m7Qx1MyUJzK98E89ltkY5P+M42KoMLMB6hykRXH5xnRMF7/bxVryBYUJGzQ+W7X0pPQ7amPw61GVV2RlRD0GRXyf2Sj7M6krXPkFvLRa+EFxAMS/5kNI+3Wqe0RN+CR5qgiTR3Z5Zbx5Z5VJxobfhj4govnhjlbFcdxkn6lQD9es03HboKpnj3b7QbovSE0QPIrWQzeQ5u/fW5DnvQGnVPQJhvfX+Ah9t34ul52FTo5CgGl4z5MKSLqdUM1e7E5MnfYL//3AYzSV10FqbOVhGIYH5clMKLwSEgsbkfbSHJQlOoiijgxeETiWykGp53Hy57WpFKdkXPEfyr4caIY6aY2SKTc05iMQgbz8OIck5xnMnzCgS7nzXRnstTTYRYrNaPfyZov1H/BMRXv1GgPQImyykAquPseDcos+EdiBIw8uzp0p7iATjyZXNn5RXmTISqQqkzWuizHzdoEajAaNwtnbQw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR02MB2536.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(376002)(346002)(366004)(136003)(451199021)(478600001)(71200400001)(38100700002)(8936002)(8676002)(316002)(41300700001)(55016003)(66476007)(4326008)(76116006)(66946007)(66556008)(66446008)(122000001)(54906003)(110136005)(186003)(107886003)(2906002)(53546011)(38070700005)(26005)(6506007)(64756008)(86362001)(9686003)(83380400001)(33656002)(52536014)(5660300002)(966005)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?fJuJE186/UFY08qJLQ/qB40jD+ldR3Vz8FZiP4npsEGzXPT0VqJ7XeOOJCy6?=
 =?us-ascii?Q?FRYte605xgqKsl1XoF96GuisJpe3Uouzka09zV2cDEK6byShT9EHEF5//amY?=
 =?us-ascii?Q?+b+LLWsvcqyRuWKlJIEzGdUhmruHSRqX+wBhmu7T+Hncda+oiGhntft0x4qX?=
 =?us-ascii?Q?rL2BEMpLAyX0a9RMAdQK8ITUa3Z+L2YjbVHaFEPqNocMIwXAiUltBdwcPEYV?=
 =?us-ascii?Q?/ZiFsvLuZsRHNAcjPU0Tqx1yKj7zqJTV6boK/uPvRbw9CgaWZBD0+q3IIv35?=
 =?us-ascii?Q?XUkNSFmPeNktRCz9BIW0v/lQpiaJ7I+qZeHKNMPn8RYHfWjK9E7qcIHSo1ZG?=
 =?us-ascii?Q?BKP80HCVyAYl5tPsvuUXzIpOZCaLYPPFfnvlyG5qFv33ksrdyj2uBx5RVdbW?=
 =?us-ascii?Q?7O7nbSiKM9WA1FppeSJJQt2Yrx+YAaXHPoBsCIdMqPt+fxrXu6KNEnX8voek?=
 =?us-ascii?Q?aBWUods82tkI599HWeTBHOBNEJARFwcfZPkmsGc+yQteJvPiZ67s3WD6RH+w?=
 =?us-ascii?Q?XJHNQrJsliFOK/OWt6QlrgFhtZEt/zRKMF2Niq7LAGAhSh5OZQ/gpz1xnrxN?=
 =?us-ascii?Q?VUYd7P/v704Gtx5dJg85jS7TbL0KYoMVNudjqCF2CIYJKWMuUt6wbmx5KcpS?=
 =?us-ascii?Q?LdLbwUzUaIGWChyWe0zFP5C4+/CUjTZc0QM1UsnxCyxzYjnL0kXKGX41yzvk?=
 =?us-ascii?Q?WpohAmEIV5+kjjx3zYv442ZK28GSwiBwNT4v7qmxZ0B771gI/monSKFEyMGI?=
 =?us-ascii?Q?Ph/kauz+dJws87TAMhf5eDuFuuAJalXxk7j9OYuvU5wZGTgpMh8Q+bK8OuC/?=
 =?us-ascii?Q?Gu5IXF6DyX24k6hH5b3JQPbN6cUCZnPdxBR0wVONpnIqZeqzqeD4Gv4eM3QT?=
 =?us-ascii?Q?iGWi01t5eFmKaEMeKKzn8i0Se8zni4JBsi+kTkltFdhptMsB9XPGg63oTwUX?=
 =?us-ascii?Q?odS8Hi3lnqcgzxgkAtdHiTXID51hdRMJA5tHKpMSK9xWdOI+iTP/yaOlJ8I0?=
 =?us-ascii?Q?0IQ/yNFZVzlN3jG9i2RVSPs+ElpDX4wQbAtlZLaZYiePdyJk4sRK/cZ2gsfy?=
 =?us-ascii?Q?OE8JHi8X+jyMdMGhmw4PDtG3WJXn/UPP7Yb+rjXHDNTG1vIDeqlDEfS1nT7M?=
 =?us-ascii?Q?MBIbPIe6hTjqBv5J/xoC6I4PMc5Klk9u517KmMr3WUPabnvwZJxcl0LCi4Xm?=
 =?us-ascii?Q?uw9bm8ISN2vpK2SXS8dQNOLg5a+UfO7aCVEwBb5gAdPMXGUJS8P+d+r71Xvs?=
 =?us-ascii?Q?j2tg8dRo+BCxixSt/3+4JdIr9PvARGZxcGy9pGw2+7c9lL/4ZeUN9JAjmkLI?=
 =?us-ascii?Q?ld3w/isbJv4fvyolVL8aQOuQY3hL94v9HhuErZQI/X+SBZPPpOtZe6154im4?=
 =?us-ascii?Q?iZ20aXBk1vQwJrdKNiO9BpVBtGwgoyLehy5tB8Pa1aze2Ys9grB8ellfyH5L?=
 =?us-ascii?Q?6YC28Xi9jn22IpXp83GHht259QVsFTqYKEGXStOqb/T6dkBKvXes2/gM62aR?=
 =?us-ascii?Q?uwoWznzRZvHkXYfy0zW7Z3h5zoFjuFYIQKBKcKQJIO3qn/N3netWLmnfLX8g?=
 =?us-ascii?Q?d6g2MlcjYakYDemp+hpVgAVDjtAP8ua0y9pAn8q/XEwopzJg8Qcabu1FvN9+?=
 =?us-ascii?Q?Xg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Md9LIurBNMirk8baqSuoNIcEHV+DGDzPp2jSLbiP+iQUsFWzT44/q7wT3caXTyjEdOrYZ3sxWp28n0C8k4cyE5JR2Cy9wMm2coC0Sy/o96+kg5j/vrPH4g+iSaol0D/wofVtIQdY6silkDfna5aHGGR89VG+cz7oTY6bnJ7Wyj/Cw9Wnra3VQnMUBtRLHI+y8utEa88lFF610ocG25jZiQ+2liGzEuUthn8/3f9vCK81LEsS9a08180PfxjdYXOu0/URa8KH/CCBtFnvbZNE9TczfkZyA5/D/CwGkUfOEmzITLq8HO44Wk13vyxRtJLo+JaAP5ZaEPCZBrGF/DKH50wCEi2lHrDhzilDUffZMdMpwsM12TtLnlV3yfXzxywZkt2j8EUrEL7MgAz+RKAUm9JYUC52Btv6AlZuIpnkbhG04A8iYKbcvQfv06v5h8p3VLkRDAL6KEukZNlPr37PliR/g1Izw4mygoAMs0Es6zp4NMjlIRJXXjUCgLhrRage6jDYjHJbylEfFy5LH5/VB+sV24tUJ3Jufifyov/dT2tK71H1A1pPX9m6Q6arqgpZskao/mtUq2nuH+/K8hdmjCnSdsgJa67rBkBxezUwsu8mNYT5p8CzP12OwhtAnTeyRPKOFMZrnjfn8l+N4RDfHn0i9W++uHhr0JQRTzTv3hGL3QscCxstAQApBWDXmIFwm4t67SZ9mwrb1iIkvW4B1EAIjqu1ySwBKuMuQ6/Hdk5CBEx6EJcRwJtMfymKn/Kj/5lbgLw5gpHHKHwaD5Hv26N0yeglJvqXRL7nFbBxzJwCDWEslTRvhPKtkxRTUEAnZZq9zho3t/rfB1lOnHrvs+8ITy6K6B4gMccOPf9wDS4=
X-OriginatorOrg: qti.qualcomm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR02MB2536.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0721236-9ef8-41ee-ba2d-08db3f506b0d
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2023 14:31:22.8973
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: m5Cg6IE6jwigfIotTKs0BtCaiiY6S6zrAyRBDo0VJPAEtLR8DOgpzi1YcQuL+nLsYKWuHrOBJ1ZNVZBzCZme+UNrOOBlz7Bd2/v4qaHHwyg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR02MB9222
X-Proofpoint-GUID: WNN5wp6IAr1VZLeQctAhZ8SqsxprXvh2
X-Proofpoint-ORIG-GUID: WNN5wp6IAr1VZLeQctAhZ8SqsxprXvh2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-17_09,2023-04-17_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 priorityscore=1501 mlxlogscore=999 lowpriorityscore=0 adultscore=0
 phishscore=0 mlxscore=0 clxscore=1011 suspectscore=0 impostorscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304170130
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

> -----Original Message-----
> From: Kalle Valo <kvalo@kernel.org>
> Sent: Monday, April 17, 2023 6:26 PM
> To: Ramya Gnanasekar (Temp) (QUIC) <quic_rgnanase@quicinc.com>
> Cc: ath12k@lists.infradead.org; linux-wireless@vger.kernel.org; Karthik M
> (QUIC) <quic_karm@quicinc.com>
> Subject: Re: [PATCH] wifi: ath12k: add wait operation for tx management
> packets for flush from mac80211
>=20
> WARNING: This email originated from outside of Qualcomm. Please be wary o=
f
> any links or attachments, and do not enable macros.
>=20
> Ramya Gnanasekar <quic_rgnanase@quicinc.com> writes:
>=20
> > From: Karthik M <quic_karm@quicinc.com>
> >
> > Transmission of management packets are done in a work queue. Sometimes
> > the workqueue does not finish Tx immediately, then it lead after the
> > next step of vdev delete finished, it start to send the management
> > packet to firmware and lead firmware crash.
> >
> > ieee80211_set_disassoc() have logic of ieee80211_flush_queues() after
> > it send_deauth_disassoc() to ath12k, its purpose is make sure the
> > deauth was actually sent, so it need to change ath12k to match the
> > purpose of mac80211.
> >
> > To address these issues wait for Tx management as well as Tx data packe=
ts.
> >
> > Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-
> QCAHKSWPL_SILICONZ-1
> >
> > Signed-off-by: Karthik M <quic_karm@quicinc.com>
> > Signed-off-by: Ramya Gnanasekar <quic_rgnanase@quicinc.com>
> >
> > diff --git a/drivers/net/wireless/ath/ath12k/core.c
> > b/drivers/net/wireless/ath/ath12k/core.c
> > index a89e66653f04..499b81cd938e 100644
>=20
> Ramya, how do you submit your patches? Your patches are missing the "---"=
 line
> which breaks my scripts. I have asked this already before but no reply fr=
om you:
>=20
> https://lore.kernel.org/all/87edqot8m4.fsf@kernel.org/
>=20
> Please do not ignore my questions. If you continue to do that I will just=
 stop
> taking patches from you.
>=20
> --
> https://patchwork.kernel.org/project/linux-wireless/list/
>=20
> https://wireless.wiki.kernel.org/en/developers/documentation/submittingpa=
tch
> es

Hi Kalle,

I use "git send-email" to send the patches and the patches are generated us=
ing "git format-patch" command.

Thanks,
Ramya
