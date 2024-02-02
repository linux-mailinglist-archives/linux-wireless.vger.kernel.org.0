Return-Path: <linux-wireless+bounces-3009-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 028E0846ED5
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Feb 2024 12:21:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80F151F22EC8
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Feb 2024 11:21:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED69E13D50A;
	Fri,  2 Feb 2024 11:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="V+E5ysZO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E30B213D50F
	for <linux-wireless@vger.kernel.org>; Fri,  2 Feb 2024 11:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706872856; cv=fail; b=jED63P0D6Qm6Drw4lscfGZ0OT8xsgNNyvSIn3VQZa0DUqsVXkCNdt07ANOZfxWU2AkxIqmmIJ2ZUqAq8poZqX3ArlPYOKLfhHEad/h+uoL6j2mVDzx1lfZdCib/ub3Xc5+4EPdii5jmcEtgSNqsdsUyu/0Alio1nsU42YMSHZLo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706872856; c=relaxed/simple;
	bh=A4qzrbg2rkyn8AtsWpZ2kZnEum9wepF85HSwOcvK/jM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jfNn9Nc3S2RhEQl3P+NwD8pxXSmDjQw9wGyYPNTKZIckSreNFE6niI1FkXi+S6KfVJ/vkmtXm996YOuBieELNPixo6Q8IGRXD5VANW8m61X4nQ1ds6yMPHqV6szFZL0hTvcdbVIDkMjbz7ooslrRH75PRfjiUBmTtYd/wjDwlOA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=qti.qualcomm.com; spf=pass smtp.mailfrom=qti.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=V+E5ysZO; arc=fail smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=qti.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qti.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4127fFV5009566;
	Fri, 2 Feb 2024 11:20:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	qcppdkim1; bh=LClp/wWG7LYFe3+d+BeBUfheiAz8keBKpQomYStjhik=; b=V+
	E5ysZO9LDrgiZOPoly5BL5+i0uEaYw+p/z5euKguOdZg8qR+WNWEc+TWmvMEz3ID
	RlZGENeR1t9Ofj4QE34MPFvLVxj7vOSOdx95dnZj57kdGad1xtJnMmnTcKihtOeL
	ClZUBultDPunocKxwe8ZHb+jQkiLRprs5PNZKPsKXLV3y1MaKkk7uqFeMDoSrxjN
	Q9RiWk/khxeGicHx4TSuSw3z/1QxZGN7gpUVxuJbCacGa6iWZTx3Vc9FJXOU3q7i
	dIjDi4GM4jIa3Z9dvqZUSxJeM9hPBvlEsJGf7pAt109bHCB99yZLeguU0HAeFKwq
	rEjVuzFILxYABcBrJwzg==
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazlp17011008.outbound.protection.outlook.com [40.93.1.8])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w0pwjh6ct-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 Feb 2024 11:20:47 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jEZSMrIFwD9I1kFF3w+IBORVVNMq5swogpn59/RS2BEx8cEx6NERdQG/qpETKOd+uTBYzR9zxcG5NfJlzn4jj88DxfHeptlCBFajdyEtQhstxn8+SP+8ryuH+HizpOKIPOtEBnRK8TrPeH4ySHxlJ0oyXwLX+H1PtNkbTDT8HOY55P7zBxcKCEzgwT6r3f366dbwp7sKuqnwMApaHB9f1QAK48wjMNRTWlLW+Vn/FQDGABS8VGLuyPA3olRA/bdBgGt3DKEBTd4PRvn7HBqR1Wdj8jdDPDEdNdZhjm741qeEw2VrGbGKUSJxc6MHDybcpJzI6ldcuMgtYxmvk/kUBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LClp/wWG7LYFe3+d+BeBUfheiAz8keBKpQomYStjhik=;
 b=AEdUrITQvY8GR0euvAGffVaIqMyrSEm1NUVsTokXcj5z6ziToMewea11xarf6GSNENFFCAbRg40w5XAkB8MLmkSC3LBZBazy79Vq3qym4TARh2zm8mUPzHNLy7Qsr8Y8IPF3/j15HXKvpJNY2lf6qfy512mxvPxpIiBbUL1t3Y8DNvdzeiivVz8y4hUy4h8SIiJT11iJAdlFe01k2bglLsyB52FDVqeFPT+bJqYvUWYT4b/YOzuETVSYcjdqGBaa4zTcfjwqmzUZ3+dwvs54cbXIccyyO21Q4a5/rFZuLIVers83mbwcFHa4bAMIhAsIP5aX0MHbZVauSn0e8olTZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=qti.qualcomm.com; dmarc=pass action=none
 header.from=qti.qualcomm.com; dkim=pass header.d=qti.qualcomm.com; arc=none
Received: from IA1PR02MB9043.namprd02.prod.outlook.com (2603:10b6:208:3a5::13)
 by SJ0PR02MB8578.namprd02.prod.outlook.com (2603:10b6:a03:3f6::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.30; Fri, 2 Feb
 2024 11:20:44 +0000
Received: from IA1PR02MB9043.namprd02.prod.outlook.com
 ([fe80::4342:fb34:2e06:66e0]) by IA1PR02MB9043.namprd02.prod.outlook.com
 ([fe80::4342:fb34:2e06:66e0%7]) with mapi id 15.20.7249.027; Fri, 2 Feb 2024
 11:20:43 +0000
From: Lingbo Kong <lingbok@qti.qualcomm.com>
To: Kalle Valo <kvalo@kernel.org>,
        "Lingbo Kong (QUIC)"
	<quic_lingbok@quicinc.com>
CC: "ath12k@lists.infradead.org" <ath12k@lists.infradead.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "Ramasamy
 Kaliappan (QUIC)" <quic_rkaliapp@quicinc.com>
Subject: RE: [PATCH v3] wifi: ath12k: report tx bitrate for iw dev xxx station
 dump
Thread-Topic: [PATCH v3] wifi: ath12k: report tx bitrate for iw dev xxx
 station dump
Thread-Index: AQHaNwljeY+TzF/lSE+tLUqyemzbCLDUkEhegCKUWfA=
Date: Fri, 2 Feb 2024 11:20:43 +0000
Message-ID: 
 <IA1PR02MB90432E82A9842EAA47A7B87498422@IA1PR02MB9043.namprd02.prod.outlook.com>
References: <20231225080723.9518-1-quic_lingbok@quicinc.com>
 <877ckgazt2.fsf@kernel.org>
In-Reply-To: <877ckgazt2.fsf@kernel.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR02MB9043:EE_|SJ0PR02MB8578:EE_
x-ms-office365-filtering-correlation-id: 9c829889-63e5-4a45-f2d5-08dc23e0feec
x-ld-processed: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 AT8+Ry/6kWGmjPN+Q4QHBVzbCoijQ4i5DSRG/a4s6knWGv8fvfdvy01wuRIIOJuk76zusXDj/B7/zaNlgBLjdgU3oRUPWbPb4IsbpxWJ6dETu2wni/3ogprP/0Go4neIh7o3yuT7VsM8hRzecdBAbBV3PxQItYY6LYtSgnq94oPmBQNCF+BcjBNx4lI/3VSbw4g+7rGFzEpLWtjiPwwMorQFaz/LyRRREpblU/F2gi+GqsivHCZ9qnqdpbh0cpfHyyEHZsRGATkGM8d32zPMvICpMutam654MRmZQiVwpGBnXbsQRyzqOnvzU5jADGQt9KcTFYlOLwQfsN3uRGwtVr+biMux/IJ12eAvr6eAF9U9SG4a0KSKezUgUGNKPaq5/UcI54psoWvKRnuPs4vFDdJOLvOdmW9bYSZvkGfEdDmwj4TRugh6gJhrdEHy5ih8qZWhp5dCoZp9qs+CXyTRfKtHXN42YX9coLhkruS3p1CFS0HGpmPe2mXxob+dCPEszM0nSRquJjs5OCoy3TmZQaByB852FW+DHrpfT9AGpKiaBLAf5L/PF5kfJtnhtu4hihht2cTlJMCK5Rkg19hvjCG9Wy2DOXL3ahqGO298cyLTWk8MNOrwrSEG7q3zJ7o/4wMvHOpf8xT5D1UkD6zr0JNFHucyi60ueYxQktP4RfgbEE8Q3W++yLv5kWjCZ1PzdNwPHLaXzj0Ril5DazLz2Q==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR02MB9043.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(376002)(136003)(346002)(366004)(230273577357003)(230922051799003)(230173577357003)(1800799012)(451199024)(64100799003)(186009)(107886003)(26005)(55016003)(41300700001)(66446008)(38070700009)(64756008)(66556008)(66476007)(316002)(54906003)(71200400001)(9686003)(966005)(478600001)(53546011)(6506007)(7696005)(83380400001)(38100700002)(122000001)(66946007)(5660300002)(110136005)(33656002)(2906002)(76116006)(86362001)(4326008)(8676002)(8936002)(52536014)(13513002)(21314003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?cNZq5P7mXud4yoqHYzzt0WBjS9+cM4Voie3IX8522l4eVAyMPQn9b5jsYzyI?=
 =?us-ascii?Q?2gqr8moLHTUraGloXoZusS6XGNumq4J3c5pnTUFCi0UO8zRu4MeHOZe6qJhY?=
 =?us-ascii?Q?zhOGgqCQBbsiCMm9YGzDuKWUJcBffyeBHbmWcZYK2wFLvrH7wIHKKgHYsozE?=
 =?us-ascii?Q?jYwpYwc6ozapJ3OuD9zb2DIpE8I9VtnJgTVXjuy1CaI9FDkhAqM07fiP3rLy?=
 =?us-ascii?Q?3CJe9nQ2puBMlFFqO29cJi84sM3ki7tlwu7OgIOXNm4I6G81RZxp2mWsavcs?=
 =?us-ascii?Q?t/R14oKI0plOm7ypz+4nJ2hjohJObQgAeqvJb5X7Hn02nRpkzFyv7KFCAtbK?=
 =?us-ascii?Q?onqIgqfyJO5tqDmAcPe1WpKJ7IKRWEW63JSVbSwS3Q1tnvcAkNtxoUnlOMeL?=
 =?us-ascii?Q?TJ+WxzcCT4JFakS4QClvhFk7KGSf4BilZrZ/yP+1NukXu+BIQtnFqA+mXU1O?=
 =?us-ascii?Q?xO2j6y3rS4kfzM/TCDpJD4bRB/UTMwEKY9d0Az2ZJJtyZ7wINblV75N0YEW2?=
 =?us-ascii?Q?3aHxQiCcQGtiNknCtwMgVhE1kMsm05z05riQdZOKfYvhGeEIOOQTeSOaCoUi?=
 =?us-ascii?Q?+tmCxNdQ3tw/I4p7hNFILns8xMTMC24nQgrfI9Er+Tc9815qKdJmYlA9GxEj?=
 =?us-ascii?Q?AJog+g09sAaCyZyvr/SwNojXd1fgRQcc/Q8WoUDLDj/s4fqyA4oRMj7BMD1w?=
 =?us-ascii?Q?6uVblyJoZ5WJ972tRcllZUx2zS04Ay/8pQxS2H9UCVobt0vf1qtDV+rwAdhB?=
 =?us-ascii?Q?Y4ElFB8nnguXEhjB7yt++j5+pqUZvjko85ApIfuTQsa6YK0IeVJikaLC0MyB?=
 =?us-ascii?Q?bxQ3Rwp8xPWmblRglmbosF5Jk54KO59DmHorYxkiQlHBgTFPHG4t1fgs8YMS?=
 =?us-ascii?Q?+0sJ1lK012143re1HdQvJB7SF4ctFlTa3iyoIBPLy2BvkkKk2y1LOKvnsoAD?=
 =?us-ascii?Q?RbjBlzarkPTMd38S/yWJb9oWhbqITuNDZKIKvXTHmu2ZG+IyeIuwG4ZfKRF9?=
 =?us-ascii?Q?BlHS1j82oUVX2uKzbE6HpTp4AmYuYvnOZaefYPon8TuGHA+Cmovuo/cinHSM?=
 =?us-ascii?Q?RCK9PpgvTjt38S8L5k1iS0Jp2QALF7mOqxbJT9YGkgrzBm2GRger7VUN0SiJ?=
 =?us-ascii?Q?cACpbYu4yHTHFMTMgXN3Mqo9BEGJ2/7bf/QZGwwS2eKewgzhOI8dEZkVa6ZT?=
 =?us-ascii?Q?EHKt/pn+kNN/ypGGtY9Av5m7gAzJqg+FKJedBdoVIrM7AjfCydIrjBPdFTcb?=
 =?us-ascii?Q?hd2sjzBBF5++puvr/Zvo/nWuOLIxQN2zL3oKq0oke7yBCI7qNYmXsXnpRwHg?=
 =?us-ascii?Q?tOUjwDyVQF02oRPBr9joWemA3wB9MNAXiNqoUvathirygMCLlPCiEOdM/YZd?=
 =?us-ascii?Q?59PtIlYynHVXA3RzakLCKMs4eq/Oxna5OhT6QojF5xOIaNG4tR67MPORomjs?=
 =?us-ascii?Q?jw6UnKyMJfh0Ji2RCfChC0twUjv4FS2TqtRa1b+BKfU/8feJ/IiWLobrjHXQ?=
 =?us-ascii?Q?SAG84QapDp8q2IXH/x0anuRt8oPcUYHJbvbJauHdCpW2iyHGhUe5rjrC6QvI?=
 =?us-ascii?Q?siBUFSjT5Hi09BFWFpYaANFDtIMpO+4yoQjaulbv?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	MKmI+6l+vEYivxT9cIoXTcRlj7PuFLVbUu8Xkzb1t6MvptwyVf0lnsg/G6hDJZvWUvmt/vMC/1lf+FBmzrM/L7B7eo4UCJNiALDlbbmjnc/AUHXmOk1WsbLdfRjYGZhkjOuG8onQXdI32GOxGKujuc2ojjTyTmlC5LExCC0USXvacdf74V8zQfmW0qKJDI4LzH7TcgYZaaa8i8rnfxrKsRtIqJ1Em1o7M9BU8bRaNn4WYVGWaNzHIw7wYXtsHHAmfHbkpSH48pF3zJuGihnjWUlhKshCRmAVnjhKEK21ojYVTZAFzTiPY3i5SdkKnzBFr1/lSultjqiPhkgbTS0XxTXzNK42TEVqOLv3V34HQO2GZFwxmdUhCoI2kqgIl2s3fPGeBsdCof5ErTluq4V93zMNsaPQvvzpT+NhTgTafs/DOyOACqZXrgsTC1AolKKIWUmMKTGl3dceF2qXPP5zQjBrEamMpzU5vAOpshL4Oc3nAjMs3wCekTohVQ5sNYyZUc8OPvQ0PwBz7848CpEpx80rzf5qGEaJF7NtyVFLBQ9MhgbNqhBnIi3paQjbwDqPheR70N9qgWoTWmjMIPrvUL1Iu1vyXKu06hH0lhWv6IT277ssWWUBYXC/Ram5SZl3
X-OriginatorOrg: qti.qualcomm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR02MB9043.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c829889-63e5-4a45-f2d5-08dc23e0feec
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2024 11:20:43.5901
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 32Q4oVHr6GRNMs7dchLO1UcaAS4eeNc2IwgdylbO6R/wWAPHQdDTwBOSDa1felNigVm7H+SivMpoRV2jt1u+R9JpdozIcfttEq6tQ/CS7Bg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB8578
X-Proofpoint-GUID: 1HoYO56-fXGTJSvyKufoWYas9Ged5-Sr
X-Proofpoint-ORIG-GUID: 1HoYO56-fXGTJSvyKufoWYas9Ged5-Sr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-02_05,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 clxscore=1011 mlxscore=0 phishscore=0 mlxlogscore=556
 malwarescore=0 suspectscore=0 adultscore=0 priorityscore=1501 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402020082

> -----Original Message-----
> From: Kalle Valo <kvalo@kernel.org>
> Sent: Thursday, January 11, 2024 7:13 PM
> To: Lingbo Kong (QUIC) <quic_lingbok@quicinc.com>
> Cc: ath12k@lists.infradead.org; linux-wireless@vger.kernel.org
> Subject: Re: [PATCH v3] wifi: ath12k: report tx bitrate for iw dev xxx st=
ation
> dump
>=20
> WARNING: This email originated from outside of Qualcomm. Please be wary
> of any links or attachments, and do not enable macros.
>=20
> Lingbo Kong <quic_lingbok@quicinc.com> writes:
>=20
> > The tx bitrate of "iw dev xxx station dump" always show an invalid
> > value "tx bitrate: 6.0MBit/s".
> >
> > To address this issue, parse the tx complete report from firmware and
> > indicate the tx rate to mac80211.
> >
> > After that, "iw dev xxx station dump" show the correct tx bitrate such =
as:
> > tx bitrate: 104.0 MBit/s MCS 13
> > tx bitrate: 144.4 MBit/s MCS 15 short GI tx bitrate: 626.9 MBit/s
> > 80MHz HE-MCS 6 HE-NSS 2 HE-GI 0 HE-DCM 0 tx bitrate: 1921.5 MBit/s
> > 160MHz HE-MCS 9 HE-NSS 2 HE-GI 0 HE-DCM 0
> >
> > Tested-on: WCN7850 hw2.0 PCI
> > WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4
> >
> > Signed-off-by: Lingbo Kong <quic_lingbok@quicinc.com>
>=20
> [...]
>=20
> > +static void ath12k_dp_tx_update(struct ath12k *ar, struct
> > +hal_tx_status *ts) {
> > +     if (!ar->ab->hw_params->single_pdev_only)
> > +             return;
>=20
> I'm not really a fan of using single_pdev_only to check for other feature=
s.
> Basically what this check implies is if we are using a mobile chipset or =
not,
> right?
>=20
> I can't test QCN9274 right now but why do we need this check? I would hop=
e
> that the firmware interface is designed so that this check is not needed.
>=20

Hi kalle,
You're right, Ramasamy Kaliappan help me test this patch on QCN9274.
I'll send you a new version of this patch.

Best regards,
Lingbo Kong

> --
> https://patchwork.kernel.org/project/linux-wireless/list/
>=20
> https://wireless.wiki.kernel.org/en/developers/documentation/submittingpa=
t
> ches

