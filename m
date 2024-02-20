Return-Path: <linux-wireless+bounces-3804-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5273685BA97
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Feb 2024 12:30:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10FBC281A7B
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Feb 2024 11:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 008AE664CF;
	Tue, 20 Feb 2024 11:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="SWrAuCIT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A2265BBA
	for <linux-wireless@vger.kernel.org>; Tue, 20 Feb 2024 11:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708428595; cv=fail; b=eVymcX0mw58tYkZ8Pqq61yHxOOY/VE7yZBsmWK3YzWXnUad2yzYn8bgstPqo11TkQscNhP68wjiVWimBRP/TuEmnx2qwUnhTL83aU1e7OO+wW65e6cUz6GtXuRBOogY+kk1nx4n+QbOEWdp5WoqyNH2eM+baAWcFb6gFS7szAdM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708428595; c=relaxed/simple;
	bh=38RQ+arb4ZW0rCPxFGrMxmLLg7Ci+926hIJ/ASajM/c=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UPXShTAlLWFDfOITmzO5ogILbxTvtdOMz+xsMjU+N7IS4k2CzeGLRxfi3bTUfO0JoGXjyUSevS+iTH9Rh56AlTCIfyvtmEIwTQqnCBPMAU5p+90LoyOrCA9Q4PEfzhfCnxU1AZt4GCl3KmS6nraPkXX8nfy/zrcxg1pgYRr6YoU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=SWrAuCIT; arc=fail smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41K3lXXf010879;
	Tue, 20 Feb 2024 11:29:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	qcppdkim1; bh=M3hEn+Y3nsDbPB4bw8I2/G8Cs84tq+OiZvthIJI0SMo=; b=SW
	rAuCITBmkTtTE3kOJ+ksi9Bz6EzYbP2rdAXKXqalKzZXoCydTXBWeFk4R8/DDs3h
	DvLuythhgQiYTQsoYxfTcXpPjYmci6ZYmCYA2Ypng8eUTjnH+39fIVfzDcxhQUTS
	e5F0Nn1nqH+JAq6RekGyDKeov0fCsceg91FoFQ2259hGzIn2dPVOIC5N/boHabGp
	QqJEJeRKGl1QwDaLTyZGoj1SD6yfaQyCgXYoIQEBiFRyt4ozcynp1JaCFOeQuj3W
	hQcM7ww8sEcTVPP8EdOQcgQbxCBoG4TiKTYB8SUosIDSE3OVNtam985k8YxgN6Vr
	NoVeBZXcKw2BAxEkQAsA==
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wckv9gwee-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Feb 2024 11:29:46 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PRrdDqxt3SmIPlajhg5s7eaaTVb46EgBIEltnYm4QuCFSyaQY11vEJxmWcRGPSb4Vr44XB++YurshSVRUDf5fsVKFcXnptioGAgWcXyHeixvyEXN+ooH5B2+XXH1A+BLNG4GjRgxEvLmwXWjylHXocgSuYNNMY1QtHDWS5pNtOvBTQ8oNn8Gf1joH84Y+/AGWGM17g2slbAOPcZCJfpTOTuxCaR+SpQoUhITMBdnuQfA/Uf3ipplcNPirmCq528qZdKEax3qBjAym6fG/Wi+vRrYyw/G1i1Khs5lJqob6POeU6/dgbm8jsVKbVzlSeiSV8Zqoo1b3BAo2n5cEiWrSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M3hEn+Y3nsDbPB4bw8I2/G8Cs84tq+OiZvthIJI0SMo=;
 b=eldtLT9n2ckrALpne8tkEdSkRs9d1LS8rVI1NGUpN6b/HDu1gt0aLf70wimTSXP0j1VyWSNmBLtbYFTokEn6BOWf1RklR8VfEgMGWi9wEFwhJox2dH5BIHrFSLpr4gB2R6azSriXtcda1CSGJCeIHKDxQPNUXIPw+1Erq3Q8IIx7m9sV0GuH5Yrpd4p+stchSDjffQYQrhzt0aDGhE7fUSimxEHPbDIZhaZFtTWkCdgWj2b/NGstJ4KTB0CIwYe7OE0b90BrYbmFMOfDSHImAc7VZE5DEtEtRtSoiQHZCan/gg0Qjb7UQDojvHXwxBqqZGIay1wj86M/f19Ip95FRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
Received: from LV8PR02MB10287.namprd02.prod.outlook.com
 (2603:10b6:408:1fa::10) by IA1PR02MB9064.namprd02.prod.outlook.com
 (2603:10b6:208:418::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39; Tue, 20 Feb
 2024 11:29:43 +0000
Received: from LV8PR02MB10287.namprd02.prod.outlook.com
 ([fe80::748c:4d58:afcb:a2ec]) by LV8PR02MB10287.namprd02.prod.outlook.com
 ([fe80::748c:4d58:afcb:a2ec%5]) with mapi id 15.20.7292.036; Tue, 20 Feb 2024
 11:29:42 +0000
From: "Rameshkumar Sundaram (QUIC)" <quic_ramess@quicinc.com>
To: Kalle Valo <kvalo@kernel.org>,
        "Rameshkumar Sundaram (QUIC)"
	<quic_ramess@quicinc.com>
CC: "ath12k@lists.infradead.org" <ath12k@lists.infradead.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Sriram R
	<quic_srirrama@quicinc.com>
Subject: RE: [PATCH v2 03/12] wifi: ath12k: modify ath12k mac start/stop ops
 for single wiphy
Thread-Topic: [PATCH v2 03/12] wifi: ath12k: modify ath12k mac start/stop ops
 for single wiphy
Thread-Index: AQHaWN3llx3RTeDx002mNcYlfjLMAbENOquxgAXazOA=
Date: Tue, 20 Feb 2024 11:29:42 +0000
Message-ID: 
 <LV8PR02MB102877C0CD1CC770B29594191E9502@LV8PR02MB10287.namprd02.prod.outlook.com>
References: <20240206091954.4144454-1-quic_ramess@quicinc.com>
	<20240206091954.4144454-4-quic_ramess@quicinc.com>
 <8734tsnz8i.fsf@kernel.org>
In-Reply-To: <8734tsnz8i.fsf@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR02MB10287:EE_|IA1PR02MB9064:EE_
x-ms-office365-filtering-correlation-id: 29bc67fc-68ea-4fe4-63c7-08dc32073b9e
x-ld-processed: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 KH/h8Xh+COOGDw9Bljm69lOQ4EsHtOG8eyQ2FkZOJLtCPqGGe+u6hiB6EzZ9JLvnirPtTmG4zd/DNxPoKGkXXIPlzYRnwJseIWY3vjTxMDCThFtUtgF0MVINO9nCPewShWqECCnVa0eFuvf/K0F498GKgjP8wE12APL9rQA97pv3oXyD3q+DURPqsGQ+B+r4X1ErcZmYYbNU+bHLWTODkSMiVt+oE9gsmMw2jaL8FyT5UBM0UIenLtAJ3QP2iB6SBBrWmk7DQAzNWCBf7LchQP950nWPwb26TOnImHG3sNFmhKH1TIaoNiJEBDZhbC+lLdXp3BoiYv4o4NFEbaxIeowKpgEJeWhiTd3PBi6Qc3IsCk7iIB1AjNICRsZ1a0dxJnrK/BxdJ+WnTiU5iF9xJdswuUYkn13qAnatPHw6wzs1uZXusUmmFFbADpLqoDUPElz3tAC4+IKC67t1Zfu0m4xmZVQQ7q/7wAtu2XDiF75b2y+NOp66zRB0rhwbbkWkQVuFfMokbOW1jYW0YC4cvA/uQI38e0zftUUrqfyqdmMgQEoE3j41VO32lt3S/9Bg3xfcqxwhsyx3Qx3XTaG2XnnVGgF8/I4t5dQS4lGtoN4=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR02MB10287.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?Iiv+XnIr+elsduiAoOl1Dh5S0mQq/M+DsMjYbN1irTCigjmVSxlvVnkkhafW?=
 =?us-ascii?Q?0Bo2PRIYZ92PbMN7aYhuXxWuZjAjOeEYVZcsbi9u+JZNLr392TyvPB/3ajGg?=
 =?us-ascii?Q?H5egNCB/wI1ZNVixfadl0lAkMksLUA3kmZvS8yYrvJykmP/ESixQIPZgp8f0?=
 =?us-ascii?Q?tRFUMo/pnZ0x9n5KeFEXoU3IJfW/88SMY6Y4btr4+46yEkc/F39uSX1EMI5q?=
 =?us-ascii?Q?YO0O5FZvAYVZEp2Smgs71hj3QoEJW18Hi3JN2ZbWDINWOwU3RJaEkmszIJiH?=
 =?us-ascii?Q?qT/98kYE3y7lx6bOKsRs37n2qgRx333A+VrzOPlJGDcMiKD639ZPD8xgyzXO?=
 =?us-ascii?Q?apyMDs49wkVgpBVfpHprgxenvn9lT60NLf3LRlDTOeCUkQOZ8khSdt2eYfwp?=
 =?us-ascii?Q?H2pUDNDVsaI4X9H8ZCfqQfRNRpeaaz1UXUmsb7bno1U/Uq3tZq++k/SVvOpI?=
 =?us-ascii?Q?gbmhlVaMgEJrg4X630n4EsuRXAaOLp92tDNEvj3loeRUZ8X15gVabLqi4N6X?=
 =?us-ascii?Q?FQnGcy6vkvEAhZEfMOdL2eaykEZkMQbszvfwf+i3A7dDog3/Il8no9ri/wAc?=
 =?us-ascii?Q?6n8TL7PK2chgD8aIZijSWMKYRtkp8gIgjpQrOSXfoVXcoR/ACdGox0z+97nM?=
 =?us-ascii?Q?FrSPl66qJBONo+SPvTd5lKISmfMz86hLIWZ1TncaZGqu6zaMAr+n7itgoM9B?=
 =?us-ascii?Q?OAVZziAnURfSczXzY1f3COrgwn/pj68UkgQ6imLGZ2hW5LGmtG5jN98dAmvU?=
 =?us-ascii?Q?VfH7mZQjkFYycN1k2xtqd3XTSPPnO+O9/1Ze1zdJjKdRjjoHMLEJGdnjNydC?=
 =?us-ascii?Q?d2NfUM8oMcCN22DatZtf3ZDcYAYBu73hzs9qtphu1Am47ztPzwcbl0od3b67?=
 =?us-ascii?Q?Ph7lre6l+D6JgTkvZxip6LfniJK/cFlnwRCyAM39/Xva+2GDZJRAj79QHnMM?=
 =?us-ascii?Q?dzpOMjtkzr0L/SI6cWyme4X7vqr3zLVIEiKf+DaENCozL+B1TUYiwVe0YKCm?=
 =?us-ascii?Q?POsBRFeeYvIfjv2XGnHQQOkpejlM/XUB+T1rLiFLdSj0Ll80wffYm6D6lVQv?=
 =?us-ascii?Q?OqLo6664BMPm6InGcwLh5JcTs4A7BaPrhGHlmPXCDrOTad+qT4OD6ZCmSrnF?=
 =?us-ascii?Q?vo/55DwZe4JNiBmVX5XbqtiQD2JOwl/QpkIvaW88TWvpXULMJS+jlTXfmDDb?=
 =?us-ascii?Q?xcDaM2aksd2tojUYiEuo1NaVSpQbFIrAW1qen8dHSr5adzqZwQAREt27Fcc1?=
 =?us-ascii?Q?D7SfuoAqOhN1RsCf1RVSZEW2NZBiIEKwTvGtN4RznHVFQ6vi3dMoxvnI5keW?=
 =?us-ascii?Q?JPJRmpBYMNMLgs0u5DHymiWzKgIk9iOHFM5olOpWu3zl2LrAeFulOpH7hUvk?=
 =?us-ascii?Q?EqtXL1iehZVKLb1f+EdkggiWx0a4O67GuKi4CYGrsDmhQRPzyG5L/sEZF01Z?=
 =?us-ascii?Q?6RPSAoTUFfQxIS077C7Uckg4fHJE+TaP7KvwiHiuIcFEeIi4mFwKswso0cFb?=
 =?us-ascii?Q?64iGfBY1sCnqoo69g55HS6j7KxttMAxndEEEMIyTw4tG9tVBigabPcllqymK?=
 =?us-ascii?Q?m7rjMnayNfn3E5OMM6wVC+kSKpBjCdNT/eIDd5Zl?=
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
	nI3XCPcv9SRmk7Y/Tn47H6MNmHBbKqBSlJkidwjJV6BSWh51YnAxYwYwAuTIKihHWQkfudliUukgpOKNGRj/HtQ309yhwwG8fwKo2JQY2U899Adi8nGu/OwX1VWUWUN2VWgF52qL0YCGqOJG2oDHnx4XvXjPbFjwEll3e/fM7TEaIbHMUxs94L5AurgB7IDzwlBfeFkGtDD/uRAIMMSViGEiBa2W2odehMOKr8TTpL+H0wYMPl8SiOkyGMMNnWPVVFEuF4/xPACvT//i8GyFn53C0Gp5otwfeoh7Fyb0rXkWpNb0I2BRs1DwJgO4VCfyfATjIdGe2dR1ACXnLwlLCYAXUWNJfRP0jbWL/TcsHgsge0Xbdh/GSFmWyYRdA2CpOkujVQPrhBMrw7qzLDFTZCoMiUPV8NI/FZ0pBtUOGm2E5E4DJpt83LcrwphFtBCt77xS0hArTvRMjs3zBF0/8/OcVy6PL2eYTFV6Mwv+3H1Q/GIMgRiLYnd0KvQ98zTK5KfiZ5/m8es875U8E7ox1e3sIoc3w82pSGJRrL36Gmoe4Re01VvOJYAMbXD+iIT4CcC9ZOz5vUAxcd7TsXEtKAirPGtV7C3DFjl/vsrhblSAofjhJA5zD2rB95nCw0DZ
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR02MB10287.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29bc67fc-68ea-4fe4-63c7-08dc32073b9e
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2024 11:29:42.5504
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nZrPxKtnZYnWO5ntazUUkCuIT3NwUX9FsdMARZiozva2dcnPxSMKacX4q+3sVqKvYovmJK8o4XoQBbKEOSpe+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR02MB9064
X-Proofpoint-ORIG-GUID: Y2IMiClAsYsLUkG3AAOrHewmq3WObQtN
X-Proofpoint-GUID: Y2IMiClAsYsLUkG3AAOrHewmq3WObQtN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-20_06,2024-02-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 lowpriorityscore=0 phishscore=0 clxscore=1011 adultscore=0
 mlxlogscore=746 impostorscore=0 suspectscore=0 malwarescore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402200082

> -----Original Message-----
> From: Kalle Valo <kvalo@kernel.org>
> Sent: Friday, February 16, 2024 10:06 PM
> To: Rameshkumar Sundaram (QUIC) <quic_ramess@quicinc.com>
> Cc: ath12k@lists.infradead.org; linux-wireless@vger.kernel.org; Sriram
> R <quic_srirrama@quicinc.com>
> Subject: Re: [PATCH v2 03/12] wifi: ath12k: modify ath12k mac
> start/stop ops for single wiphy
>=20
> Rameshkumar Sundaram <quic_ramess@quicinc.com> writes:
>=20
> > From: Sriram R <quic_srirrama@quicinc.com>
> >
> > When mac80211 does drv start/stop, apply the state change for all
> the
> > radios within the wiphy in ath12k.
> >
> > Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-
> QCAHKSWPL_SILICONZ-1
> > Tested-on: WCN7850 hw2.0 PCI
> > WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> >
> > Signed-off-by: Sriram R <quic_srirrama@quicinc.com>
> > Signed-off-by: Rameshkumar Sundaram <quic_ramess@quicinc.com>
>=20
> I haven't reviewed the patchset fully yet, first quick impressions:
>=20
> > +static void ath12k_drain_tx(struct ath12k_hw *ah) {
> > +	int i;
> > +	struct ath12k *ar;
>=20
> We usually try to have reverse xmas style, of course not always possible
> but here it is.
>=20
Sure, Will fix it v3.

> > +	ar =3D ah->radio;
> > +
> > +	for (i =3D 0; i < ah->num_radio; i++) {
> > +		ath12k_mac_drain_tx(ar);
> > +		ar++;
> > +	}
> > +}
>=20
> Please avoid pointer arithmetic (in this case 'ar++') as much as possible=
,
> it's just so easy to shoot yourself in the foot. In patch 1 you add
> ath12k_ah_to_ar(), why not use it?
Sure, will avoid this and take reference from ah->radio[]
>=20
> And I see this pattern quite a lot, should we have
> ath12k_for_each_radio() or something like that? Or did I see that macro
> in some patch already?
Sure, makes sense, guess it was in v1 of patch [01/12] in this series, but =
was removed and used inline in subsequent patch sets.
will introduced it back.
>=20
> --
> https://patchwork.kernel.org/project/linux-wireless/list/
>=20
> https://wireless.wiki.kernel.org/en/developers/documentation/submitti
> ngpatches

