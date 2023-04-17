Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B0CA6E4C20
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Apr 2023 16:57:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230023AbjDQO5U (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 17 Apr 2023 10:57:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229909AbjDQO5S (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 17 Apr 2023 10:57:18 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDE999ECA
        for <linux-wireless@vger.kernel.org>; Mon, 17 Apr 2023 07:56:50 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33HDSjab004007;
        Mon, 17 Apr 2023 14:55:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=qcppdkim1;
 bh=+Jka5nZ3DPzj3TXASvjfhtVBe3dHRULZQraUQFLUJTo=;
 b=oX10y3NRgxy1x5X5QBC8bd7j4ZXcSLFQA+LmJQJeJpxIQIeJ3eFzqOHHSiwlOHtyGWoa
 u/JFJLfzaAvP4ijg1VQ6RyyYguABghOl3otukWClVufN8qXifFFH29pEH9fHjB7u7QNs
 oNJ0DI1qDhoUNmnst0Jy0lyNuHJLjN6nytEQYQIpLYwCGGYLPclyCeInHq9fe5bwzOpv
 PmojuHronkTrVpfr75l19mN1Y5a6XjWboLYmy9FsxN0Ol/4OLQBTeHQ7st/Zc0eN22dT
 NJjxUIUpDV6sLijdD0TO+E0iBEKuyQ3WYkwWK5fp4iZ2A2ZrLnEcwkt1IO9vyMg/j4lz 8A== 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3q171gg8gk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Apr 2023 14:55:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XrgIkUiw7/o4OTFhMHmtMFUxpzc0PHqo8lKG/NAcmhfxNGOd9pfXqSp5VXnymwPJJhcy3D3ORuBimM85mRQZiM/zr98AWPGtTC7bYEo64NN0oDP8V9nZl6vtcPMgrCCh74JM2Fii7VcDXHbSNH3zjoxziHfWDl14SeB7av++LbTo6o05/Z7uolD2Cg4mqIFgS3JIwbCQgTA0EPkYFxT3GHIkmew2KS7n/I3IE1HVdMPjqNRu1qWpVTkQ6UcZ6frmKC5Nt+xGpUqfPmsqZjtzgzGHKDsL0OPAes07AgjQtdXuJGI1FpE8HnvWYI2VsTFnMFvOQTv42M3Hckj+8HsqzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Jka5nZ3DPzj3TXASvjfhtVBe3dHRULZQraUQFLUJTo=;
 b=gpyQApL94GFAM9PGR4IwbsZ01WmZv2a41Rh3J6v0S2We6XiQkNHrPsUpXFZh3Pz5KySVUhd+zUYtlalbltqMUYXzirfvMgv7WIuRdN+3w1rTJ5Wg9YNscsixSmgLZvVF4A9qgAKj8y3AwMg/qXWpcPWb1csgK5ICvbjyiu56AggqNymd5Mi2QbFE2ioO8P5R+CWMQ1A+kJMpLcyBsXdrr5vor+KATSJUgt/jAUhGLtyCvGWpj1xUvsJ2AeQwtkyevlyQB9u1fcDhNpFiSMCeZLHip35jY9gUNzFWKmeZL5Yg5kakNvLoeznCU2LqkMXwQsBJ3s2Z14lFwJORjyMexg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=qti.qualcomm.com; dmarc=pass action=none
 header.from=qti.qualcomm.com; dkim=pass header.d=qti.qualcomm.com; arc=none
Received: from CY4PR02MB2536.namprd02.prod.outlook.com (2603:10b6:903:71::7)
 by PH0PR02MB7334.namprd02.prod.outlook.com (2603:10b6:510:b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Mon, 17 Apr
 2023 14:55:49 +0000
Received: from CY4PR02MB2536.namprd02.prod.outlook.com
 ([fe80::c7cb:8ef8:8058:6af7]) by CY4PR02MB2536.namprd02.prod.outlook.com
 ([fe80::c7cb:8ef8:8058:6af7%7]) with mapi id 15.20.6298.045; Mon, 17 Apr 2023
 14:55:49 +0000
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
Thread-Index: AQHZZ4IPExKM3Sc9TEmK1AyvvEk4m68viRacgAAYRlCAAAfJQA==
Date:   Mon, 17 Apr 2023 14:55:49 +0000
Message-ID: <CY4PR02MB25369A5089F85FC347702D6DF19C9@CY4PR02MB2536.namprd02.prod.outlook.com>
References: <20230405054646.7300-1-quic_rgnanase@quicinc.com>
 <87leiqwttz.fsf@kernel.org>
 <CY4PR02MB253674B0BA0767E1504B76B8F19C9@CY4PR02MB2536.namprd02.prod.outlook.com>
In-Reply-To: <CY4PR02MB253674B0BA0767E1504B76B8F19C9@CY4PR02MB2536.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY4PR02MB2536:EE_|PH0PR02MB7334:EE_
x-ms-office365-filtering-correlation-id: 66b4ef01-bcd0-4028-0ea5-08db3f53d50a
x-ld-processed: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PbCybOvccjKp/xPmGv5N9ngg/AGsX+0LtPA6yxjg391+/vh2uJJo8K69oryp73GjRA3ZAKkxrtdIbC+jve4HgforLBIl7Xyy6UJoFTjk/CyNKpZF7+zF22gLRTKlKWbYh0WkMeizpoIDrzF9YiNKFRGRY71tPaW15fmJHH8nYbE1IQxU7HVGWJn28uiEAA9EB6MqNiXtq5t2pICVJx4PMRa9nrzRBGaOWF5GvvVFCx15PrM3EsHkQO/2X+mzptyTz/pj4Oem7BnuFSYCCZwWUaab9tRwqDiMxkpQf4tZPnZjlLSv0xS7WPV9c+w2hllkNVwAy+n1xbt5N3KrQLLQ4QWzDNE6y+ESGD6wKc+V2NHGvQvJ0MTJVR1hmC5aJg1w9GcJh/ComzEENdE2JzYCN5vV3O6fhUBbTyXkUDG1RWkHt2WiaYmzDB8zuww9YIZ1GI33fdF7KI3cIkqutXehyx2KFQi/SJ0xsTXAHJJLvgbAoPezar0zKHbuxdyFh8+q05uP0RDUQAvD4Kkjuo1q9EZk2GEyArSb7GSzraKdb8tBs/r5unSV6ErbGh8hRA4dc8Va+iJuookA9lVNL8qySQnOYwdwzg9eEMBvwilK0fI1he8KWkDegPAq0mm07jC7Dgw9iBEOPRJbbRTW/REvtQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR02MB2536.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(396003)(366004)(136003)(376002)(451199021)(38070700005)(52536014)(2906002)(5660300002)(8936002)(8676002)(41300700001)(122000001)(55016003)(86362001)(33656002)(38100700002)(478600001)(2940100002)(54906003)(110136005)(26005)(6506007)(53546011)(9686003)(107886003)(186003)(71200400001)(966005)(7696005)(4326008)(64756008)(66446008)(66476007)(66556008)(76116006)(66946007)(316002)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?St4EYqgsgKHr6DfwsRIIX/pfP2ATF/pjq5FNmLmIUYhyUcoPAuy19mzgkyY3?=
 =?us-ascii?Q?tVgPZHq1Fq044yMzFwMYfVlMRxE+gXyGSX1A01ZRlLdicfV5xehrHR8v5lE4?=
 =?us-ascii?Q?g2U1vGBrJY1bvO4FWBocy+XxYVjnm8e0r5CppyH7CD7C/hvYBpz9d3iyuWux?=
 =?us-ascii?Q?+3mQ+lmMuV11Z59fUkjwH5b/L3Yn3xnxHp81THtwoiQvbfYH66IPUPKKZxs0?=
 =?us-ascii?Q?qn67PLDqU7hoR5+Gva1L1gtP8zI3gi5A86W8wPRWvLkt1xNcJTpktC/s8HHu?=
 =?us-ascii?Q?4ZmBoYQHP2OAvdnz+SSpSg6OKABVcBcFOO3bOrM1jddPZyxucY8ucOqjl+Dc?=
 =?us-ascii?Q?9307e0NXNdE71sqLfVc6a5pMyrzCGVRajtR79zgizEpV0sIyTQlosO8d6jGZ?=
 =?us-ascii?Q?e3bKMZ0PCUqVyFOsRI50uyKp6gjCBHeJlXFfQ6RA0EQIJ/odWTRH0v9G1K7s?=
 =?us-ascii?Q?SK4h9K9Qa/tuwTuXAC46tzGLxDhEAQo0BiC9N+NA9kurJbEgW4R8jZZja30K?=
 =?us-ascii?Q?rgNW/9ZfpntqOMK+LQ1vVuwkbxx+uGic71FJcK1voghBVvGPEODTe4+239pC?=
 =?us-ascii?Q?7PFC2ufD8luVKYJk6pK7YVsfgptusFCs19XhRZO4hMfeKv4Rj4v9FsG5x0bn?=
 =?us-ascii?Q?h/AcGCxuTrgh7R+RVPgYBbEa91dToTjrlP9iV+NT3pwLlrF0maI40InkiLeo?=
 =?us-ascii?Q?Bx89k3bLk0+2Jto+T49n/vsX11c/CToWgE+rpxUK1ngpd+0yovtGOnIqK+eK?=
 =?us-ascii?Q?mC+vj8aPmLA64AAy0DeHKS6k2IMDxSykouL0UF20iYn+b+4r6lfJHJZArWPy?=
 =?us-ascii?Q?SK2urEkIedx5IOgStAlVDtYXqWBQUcRmG/cZmN3hxTJNZwuczdKqP8mHhGWz?=
 =?us-ascii?Q?xzJ/I0gOeizCohvY3fKI6iDkrjeTmiKiBH+uVCU5O8SQO7u+PIiBbi4gBOTc?=
 =?us-ascii?Q?XtQvq43U9onCcysI8K02KFxp1hrsBSNEzq6ZTbpYyinovU0iRMk+6v9WJ/g8?=
 =?us-ascii?Q?bQbp3b3teHw5Ood1HcuQ0e9+2OriGCHSc582AFSmbaDHM1VkcDfkZcyYZa6D?=
 =?us-ascii?Q?ByD+E7taz757oKhMhSIu2xyiW7xFp5NKmrG/Z72yK8Xp3cpwyixOTZmof8ou?=
 =?us-ascii?Q?f5ebFrZahmn+VSs9GMJdBoLAtlDMElOHhttH7PxcyPxfn4bQV2v75oBUP5PD?=
 =?us-ascii?Q?Z45dwHIWp6Rxa6/16T6kqZsoSX4JWkOf/8W4sFtdD+kPsJfemRZkV/JTNDu1?=
 =?us-ascii?Q?uhHQxmloJCQ2NaPZf1Jddsokru3QfI4ZfMb/ciFIrZlnqBooSUYOd4GBZv22?=
 =?us-ascii?Q?HtMH3+GYnzcreWApj4ANANzwzpBR18Ts4z1aeARyhk4lVU3rWYiMQ5BDdLtX?=
 =?us-ascii?Q?ZNcwz4WGsgH2S1NVshx+Orr8g6raCuRV7oCziLQeJyWtBC+/gtcQyJb2TwmO?=
 =?us-ascii?Q?3ilWcyds+zWcRmiwa94x0Ly9Gaq3aO512Bi2IboAoFMmiEkJ2HmKecSVjsFE?=
 =?us-ascii?Q?JCU2h5ckOrXvIYkfrbv1Cu1loHaP68P2jVSbyVNwqaiDy2EJeq3Z4GsnnJdu?=
 =?us-ascii?Q?aQ8G51BwmIF9qzxq2w9ARDnyjQrGeBEFeu6OdG8ZfvMlztnj/M2Yp9PwEaYW?=
 =?us-ascii?Q?1A=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: L4If2T7dkAUuDBieeApkzlBrP068XTOWeKcGQ/WMd30X/n05r65gxsIhv/AAlwj/8FWTKy95MsZ06LjS9a4VUcj9ymaS1Iy3WRtHwu1e6twk/Vydm8TeF6DLuFxZ6CKc5rJHo/QXd6qzu+SdhB2+Ca/yVSEy9qgWqK5peatdtwxtAPwO1ZUIU2jZ1qOrA21vJdkWZoC6guAvaV2cxMTdDIRQGuTKLIVTSLQ3exRiM8nnSxwftpbJc1fisQIKWc8/rXfDBzyEvRFn/lHtmI2Jji7SPDLp7e2pFW84PD7cUbIh48hoG2Je5W0qCocRJv5RsrsJypLNzb7/SImCwhwtlCuBl6mqlXC6bRKhoVptNtPzABHo4GwZZCq+RTV5dMGlV1KzXp1zz/6EJnfcHFKqluakHAiNpkp0JB2Oh2QvPvd+6twL4I4N95+ciL11QTJuCWnWM/9XbLg5D/aEfEudlLLsjvoNR8+pA72cZ0fuLh1VAbNexaR0x8XOc1YgKrziH88uc+joCLWzeRTQG+QHWdGNGYeLA4cswvheDO3L41A6FFroW+9vRQ9XHc8PiqXP1eZDe2sneT66ox0nB0Ye3nxavbWU3TN/JHQ9oiWLW1CNuCweIMznbS+QRY2FvucY2s0QZ6iernK7FXzevxicr679uPECYWUmpPkAodpK/5ph0Ioff4hZckfGaAVSJBJQ5NU1ug80ora+/iQGbaQqK1ybgKcrQK+55bhHz470GWCSjRNcdYGXxteXhq4fHCpnuBayLgpQN6bn5hQnM/oO7OsGnFufUuol6L//+k/zuyNwfT9CwKsuJmv6IwL2/uI54SrPvtm5rO0vOR2P9/j8QbfPE60tk9LU/S6Aad/pSgw=
X-OriginatorOrg: qti.qualcomm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR02MB2536.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66b4ef01-bcd0-4028-0ea5-08db3f53d50a
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2023 14:55:49.1815
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: csJ6kvX4RiFvAGShJIY2HDSGZ/aHuldodCvzE4/sXSw6YTDLeTZIXESvtx+y2dkslElRldP+Wxoelzbkf9zBJQWmbmNSZDV7EeEHNqW9p1I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB7334
X-Proofpoint-GUID: vmBiqVaaBdJzGwI5QZJ0xXCwuskyG-Vl
X-Proofpoint-ORIG-GUID: vmBiqVaaBdJzGwI5QZJ0xXCwuskyG-Vl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-17_08,2023-04-17_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 mlxlogscore=976 suspectscore=0 impostorscore=0 bulkscore=0 spamscore=0
 clxscore=1015 phishscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304170131
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

> -----Original Message-----
> From: Ramya Gnanasekar <rgnanase@qti.qualcomm.com>
> Sent: Monday, April 17, 2023 8:01 PM
> To: Kalle Valo <kvalo@kernel.org>; Ramya Gnanasekar (Temp) (QUIC)
> <quic_rgnanase@quicinc.com>
> Cc: ath12k@lists.infradead.org; linux-wireless@vger.kernel.org; Karthik M
> (QUIC) <quic_karm@quicinc.com>
> Subject: RE: [PATCH] wifi: ath12k: add wait operation for tx management
> packets for flush from mac80211
>=20
> > -----Original Message-----
> > From: Kalle Valo <kvalo@kernel.org>
> > Sent: Monday, April 17, 2023 6:26 PM
> > To: Ramya Gnanasekar (Temp) (QUIC) <quic_rgnanase@quicinc.com>
> > Cc: ath12k@lists.infradead.org; linux-wireless@vger.kernel.org;
> > Karthik M
> > (QUIC) <quic_karm@quicinc.com>
> > Subject: Re: [PATCH] wifi: ath12k: add wait operation for tx
> > management packets for flush from mac80211
> >
> > WARNING: This email originated from outside of Qualcomm. Please be
> > wary of any links or attachments, and do not enable macros.
> >
> > Ramya Gnanasekar <quic_rgnanase@quicinc.com> writes:
> >
> > > From: Karthik M <quic_karm@quicinc.com>
> > >
> > > Transmission of management packets are done in a work queue.
> > > Sometimes the workqueue does not finish Tx immediately, then it lead
> > > after the next step of vdev delete finished, it start to send the
> > > management packet to firmware and lead firmware crash.
> > >
> > > ieee80211_set_disassoc() have logic of ieee80211_flush_queues()
> > > after it send_deauth_disassoc() to ath12k, its purpose is make sure
> > > the deauth was actually sent, so it need to change ath12k to match
> > > the purpose of mac80211.
> > >
> > > To address these issues wait for Tx management as well as Tx data pac=
kets.
> > >
> > > Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-
> > QCAHKSWPL_SILICONZ-1
> > >
> > > Signed-off-by: Karthik M <quic_karm@quicinc.com>
> > > Signed-off-by: Ramya Gnanasekar <quic_rgnanase@quicinc.com>
> > >
> > > diff --git a/drivers/net/wireless/ath/ath12k/core.c
> > > b/drivers/net/wireless/ath/ath12k/core.c
> > > index a89e66653f04..499b81cd938e 100644
> >
> > Ramya, how do you submit your patches? Your patches are missing the
> > "---" line which breaks my scripts. I have asked this already before bu=
t no reply
> from you:
> >
> > https://lore.kernel.org/all/87edqot8m4.fsf@kernel.org/
> >
> > Please do not ignore my questions. If you continue to do that I will
> > just stop taking patches from you.
> >
> > --
> > https://patchwork.kernel.org/project/linux-wireless/list/
> >
> > https://wireless.wiki.kernel.org/en/developers/documentation/submittin
> > gpatch
> > es
>=20
> Hi Kalle,
>=20
> I use "git send-email" to send the patches and the patches are generated =
using
> "git format-patch" command.
>=20
> Thanks,
> Ramya

Hi Kalle,

I used "git format-patch -p1" which removed "---" while generating patch. I=
 will correct it by using "git format-patch -1" in future patches.
Also I will resend this patch with right format.

Thanks,
Ramya

