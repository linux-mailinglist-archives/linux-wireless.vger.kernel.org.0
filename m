Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 428665F4175
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Oct 2022 13:08:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229472AbiJDLI2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 4 Oct 2022 07:08:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbiJDLI1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 4 Oct 2022 07:08:27 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF2F915FD7
        for <linux-wireless@vger.kernel.org>; Tue,  4 Oct 2022 04:08:18 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 294AuMYm002868;
        Tue, 4 Oct 2022 11:08:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=qcppdkim1;
 bh=do0C/rH5J/Jzhg9XZFxOIkOZAQ4wEpF0WDRJN2OyC0c=;
 b=Dq5KB8gzMITLPuhEZoUMgqb1HBuTRuoiPXKm/eW/mBP3o8++7QR8asPDKyZj/1a2J06u
 iVvbjtMOlit427wUN37GilLfbuwNT8NfdGq95BuQ5M0M2tTWYXyK7VHkU8CB/0zTKLln
 Mxx7eO+HmImVcfvKxEDu6Y+BoX+sJ/fh6IcHvb+q86tkBnmkIWvPmSvyRLhy4gX0jcus
 eluuEN3t4rYWv6OWZWHOBLy43TnWkNVcf+uLSUdMFeVxCu+zDE+MqeZ54nIHa982twLg
 FAaR5SoVK/6Y4X10p/SxwWdCc38qoA7lvKEsneEkLTHGofbJySEdaBYneiWfZ+yNpEaq EA== 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2171.outbound.protection.outlook.com [104.47.57.171])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jxd58nsvm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 Oct 2022 11:08:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I765PzWlZIKZeAoyT3eRhAbIrBucFLRuUKKWl+nDUnWn/ZowWYTMCAMD/wx6uKnZMTskrFUjowSz5USh91jlvRdLwAZZa8he31/1MTaN8Is4DcL0+DOiuVyU17AOzvEoCTG6iI7uarWDDUmlno+zXmF9Pw7/qfEdhmeHiaEwPhhIqU+jlAh1HXAExhSpZ8Mcng+kwbNYleiOotPseEQtb0DcYMgArF4p9ELndQS2dVjW23glRJXffSKgEssEp3jCUOcB77h/n8r46HjKHgx1QTrzdl8S6GUDRKFxX5JOecEDp1g/Tz45AXuLAL6lhE2xa/1Hduv4x8TiBoveJfitlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=do0C/rH5J/Jzhg9XZFxOIkOZAQ4wEpF0WDRJN2OyC0c=;
 b=Hmt1oHK6EJCX0vnICmV1C4tySbAC4hv4Xv14GC7KOf0YP+E4p9x1/5hBPKfJErfbwRnWE0gHttT4+GmhXNkUZUWC4AwBa2x3qOy6SCRqbndLxBqJxzJ4ahK2izzMq2i/JaqdWC+6smqCghZq/naCa808QuJGmem+xKMsU/TDOArVD0pdmeJKMcn/oG9gKstNGVPhKtgvetJFecqlVyR90GyH+1I8OKz7undc/SqtbZr34LX98SCd8sLG5AWnYMQanfK29iMz2tc3bnpevqMHpUfBu28pzZanE2jq685eO/r0GU1sVRIfTsMbTRTr/DgV8t9xWv6MPu1koDba9Qe7lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
Received: from CH0PR02MB8212.namprd02.prod.outlook.com (2603:10b6:610:eb::20)
 by BY5PR02MB6930.namprd02.prod.outlook.com (2603:10b6:a03:23e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.23; Tue, 4 Oct
 2022 11:08:00 +0000
Received: from CH0PR02MB8212.namprd02.prod.outlook.com
 ([fe80::a2aa:7ce8:a34:fdb1]) by CH0PR02MB8212.namprd02.prod.outlook.com
 ([fe80::a2aa:7ce8:a34:fdb1%6]) with mapi id 15.20.5676.031; Tue, 4 Oct 2022
 11:08:00 +0000
From:   "Karthikeyan Periyasamy (QUIC)" <quic_periyasa@quicinc.com>
To:     Ping-Ke Shih <pkshih@realtek.com>, Kalle Valo <kvalo@kernel.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC:     "ath12k@lists.infradead.org" <ath12k@lists.infradead.org>
Subject: RE: [PATCH 03/50] wifi: ath12k: add ce.c
Thread-Topic: [PATCH 03/50] wifi: ath12k: add ce.c
Thread-Index: AQHYrmYIa+1DjcULFkeSmJqznG7sDK3c9bIAgCFvcSA=
Date:   Tue, 4 Oct 2022 11:08:00 +0000
Message-ID: <CH0PR02MB821251DF4ED32B07ECDDADCEF65A9@CH0PR02MB8212.namprd02.prod.outlook.com>
References: <20220812161003.27279-1-kvalo@kernel.org>
 <20220812161003.27279-4-kvalo@kernel.org>
 <3634f14f162a4a9fb9c1c89647b9a29d@realtek.com>
In-Reply-To: <3634f14f162a4a9fb9c1c89647b9a29d@realtek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR02MB8212:EE_|BY5PR02MB6930:EE_
x-ms-office365-filtering-correlation-id: 49a5aa2d-8667-4242-4c95-08daa5f8b384
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: m8tEh8aUYSrpI2XBo8mF8tlru/iuuDU5ojc5bCUVu9Tn//zfoBOB6x2xBwb8ij1yS4BzfUJutLFPAMjbV9YF+fgv8MukwCEq2URshc9evqigUk5Odvd8BQAza8pAPwD1T0uQckA/Ym/BFDcFp1JEXpEoCj+SDqWZCs8Alo0xrJBofHegL/s5yuLfxHWqwBIVQ+4WZVCR8vTET926KE0uHJTQNoagEhij3O8ZhXN8JjIPHS+zBiiQNoHVJk5/p2j9i99UdniNlka0NEFJ6eyb7wTu+ZfjF2ZJnmoYdie4CUOVdejlz2XHIgK3kf8nBu0tN348MqesmkmdIxuEFxcgQp3rpXWlJf3wz5qSRlvcN+gor5WHTggKhjBt9WZyBNlqlZG5Cs/ZXPHzKMr5ZDI71lm7HGy9wSTTI0zhV6NCdHz+gz7VlLbcnVRuCue/EA3UE9fAdFnWDZfhPOUqCieSxbj/13VPFkjFzt0bNz/I3aN+T35OmszkIcD/I1BHhuhQqbN4aCKiOywtODF04zbqkg8kIjNS4PJNZcEi/hKwwl04nDlFLBn6BMY+NrK3i/XgQYgw78Crh1HJnjuLl463mmpBKX9AsmP084TkPwPZx3Z/EduAdS/+0C1bR8RCDuefIBIQjL+Hpw/M74koGPF1sZiMpgttQjX7EQQ7IxR3KZkMOuJEKIKO4f+kl+IKn4L5cQsMcbGvnMdQwJbpv+jZlncLemchkyoC4GOyU5xi+BmnwE2lxrZYIVJt5q1WM1BC9OauwfUpDaN0kqMPivxBSw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR02MB8212.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(366004)(39860400002)(136003)(376002)(451199015)(316002)(122000001)(38100700002)(38070700005)(4326008)(8676002)(71200400001)(64756008)(66476007)(186003)(2906002)(66556008)(66946007)(76116006)(66446008)(86362001)(478600001)(41300700001)(110136005)(5660300002)(7696005)(6506007)(53546011)(33656002)(26005)(9686003)(83380400001)(55016003)(8936002)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?kElqbfdMMB3oyct0psURz0pPO7xebpqbsOdAXGNmow7FSatJceWwRXwhQoMQ?=
 =?us-ascii?Q?6+zY5FOhk7y0Snz+hfOcjc4XTTBz+r2ujoJv+RvjzCUqLNLLB/+fmfFu3gKP?=
 =?us-ascii?Q?shJFBQ+8qHhNeJk2P7aoRMQwpvG5hi8NdPIQuswxqyNmJ02rYqJ1W0FxZY8/?=
 =?us-ascii?Q?y0O9btN+HP3J9LmpJRNAZ3Bw92TQ8B3HdAtoXO7kX7SKnNHbnoI6cQ2aOSat?=
 =?us-ascii?Q?dHDQFsG+QnGsFu2NEPaGJ1boersipPOWsMSGPo2i4kgQjF7MBj1AcGtKFdz3?=
 =?us-ascii?Q?Gwg89EfopwQB/SGkkb/YRS5p21s/59rtDReR3BwKB4XDhmnCoCKoSkB2qpPn?=
 =?us-ascii?Q?CnikkRqpVbV9IVLhAq9a0jMlu9QVHJliZNCTbkdBo2oi+ezlRcXeV20L1dXy?=
 =?us-ascii?Q?HeQ8VarY+dXutxYKilPtvNgUeQ4pk5ojcxuTIosTfRPeOojJCzLit2UH5MIl?=
 =?us-ascii?Q?McfyAtu52iCyON6uIVWoFJa+KsaXJeX+X9VWkRUBViZ5H9s53Uy94324mALw?=
 =?us-ascii?Q?seET8/dT8w9PJQ3VQOZ/haBMFZtqKEOIoKNVd+rT+5oCqFYeU5YUIuO/jIhm?=
 =?us-ascii?Q?0yOrtkl2KkYzVUGXnDacx9FSrlBm9VzpwlVVVLOguf8TRhI907Uo2iCTr0hj?=
 =?us-ascii?Q?/1/0L+BmV2Krs6Q8SJxvkQPK59wIxCGsua8gSo7PK35qnoS1310lNE8R/kyH?=
 =?us-ascii?Q?awYGNLNNLfnuGYDXNATxcJy1osTtMAREv1ITQ0vQNxllHwQ7VHN2TaPhoycJ?=
 =?us-ascii?Q?VdXIn9L6iU6uSipS12nV9knxbVsjk+Nz4izLVZqEeOZ+mHIRP4EVlBNI7Dkp?=
 =?us-ascii?Q?pzNg5uuxaTEGIi8OiV7W/wPjJ7izZz5CyX7gpd6njfBp4cHrzeEZ8bejuKp4?=
 =?us-ascii?Q?RjCJ4oXYdO/IfBkLEtrJRMyL1Z9qUbsAhHyGLYd/em6jubm85LSrsQA1wbQk?=
 =?us-ascii?Q?8YHrD5BtYVV1F17uKLCyoOHyOauOmgJC6GqzeTAg9fV0mxw+Kzob5JO1/dvi?=
 =?us-ascii?Q?e2fN8xe87WN1CsPVh+aiUYenQx5Rn1zx/sbY50Zka/kN2Ju4EHWfZMRdhyen?=
 =?us-ascii?Q?g2od2bEJ9qG8r/yO8dXj5Dgnr5zSgN+mZWPbsPqCOyx1/Y3rRSJTFFZz6PtW?=
 =?us-ascii?Q?qzS7jo39W23py9vDEwa33LWchXNdVWcwM9Ufemeu4Uf6lgCO+OnaF8WftHpI?=
 =?us-ascii?Q?vaGL8WKCeVVY6vo/unyLNTA+4Gwu+x8k3YQk94L5B/vlwws6LhuRV0zWfzQw?=
 =?us-ascii?Q?dQ3vI8IYmqRW4mtTvrqV/l6gZ9oKwr8xASfzucabDOAMp5HiiSFu4t9gd102?=
 =?us-ascii?Q?Rv9DlZ/xqXXg2jvzotg+UilNxE9mHq8xsjmxsg0keVQo9vXOHtUBR62KtU+Q?=
 =?us-ascii?Q?nL6twf816ulfjUYGexnlWXZUauLzTpTJN+Uk402f0T3gDdRks92eM2ckZ78B?=
 =?us-ascii?Q?0JYCReoqA4/1zP2czx0avhZJXlDK+E7dTeS1Fz9K+MghhVcQXyzy9Eecc3in?=
 =?us-ascii?Q?RW5K6aGmGzpvm7icgxNgzdtpzQ+1YFKAkG/KZA0QPjbaQIgla21HuHtB4DuB?=
 =?us-ascii?Q?A6ToM22wel+qp+ghdr0SmbapKFxlkOvfduyrTgbS?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR02MB8212.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49a5aa2d-8667-4242-4c95-08daa5f8b384
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2022 11:08:00.8454
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J/a5N09zcRgjig8jcxaqG/VR17Wlupx5YCvjv39ow2OhYeuNLKNWEIShxn+elw7mxz1dP6cYIX+Ceu1gZDzHz9AD5hUkCZvF/jTuycZiMGw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB6930
X-Proofpoint-GUID: xzibRKjS_EHjK74hBihOnQzE8CIzlmCZ
X-Proofpoint-ORIG-GUID: xzibRKjS_EHjK74hBihOnQzE8CIzlmCZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-04_04,2022-09-29_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 mlxscore=0 bulkscore=0 suspectscore=0 malwarescore=0 mlxlogscore=844
 priorityscore=1501 clxscore=1011 spamscore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210040072
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

> -----Original Message-----
> From: Ping-Ke Shih <pkshih@realtek.com>
> Sent: Tuesday, September 13, 2022 9:58 AM
> To: Kalle Valo <kvalo@kernel.org>; linux-wireless@vger.kernel.org
> Cc: ath12k@lists.infradead.org
> Subject: RE: [PATCH 03/50] wifi: ath12k: add ce.c
>=20
> WARNING: This email originated from outside of Qualcomm. Please be wary
> of any links or attachments, and do not enable macros.
>=20
> > -----Original Message-----
> > From: Kalle Valo <kvalo@kernel.org>
> > Sent: Saturday, August 13, 2022 12:09 AM
> > To: linux-wireless@vger.kernel.org
> > Cc: ath12k@lists.infradead.org
> > Subject: [PATCH 03/50] wifi: ath12k: add ce.c
> >
> > From: Kalle Valo <quic_kvalo@quicinc.com>
> >
> > (Patches split into one patch per file for easier review, but the
> > final commit will be one big patch. See the cover letter for more
> > info.)
> >
> > Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
> > ---
> >  drivers/net/wireless/ath/ath12k/ce.c | 971
> > +++++++++++++++++++++++++++++++++++
> >  1 file changed, 971 insertions(+)
> >
> > diff --git a/drivers/net/wireless/ath/ath12k/ce.c
> > b/drivers/net/wireless/ath/ath12k/ce.c
> > new file mode 100644
> > index 000000000000..5694eef37232
> > --- /dev/null
> > +++ b/drivers/net/wireless/ath/ath12k/ce.c
>=20
> [...]
>=20
> > +
> > +static int ath12k_ce_rx_buf_enqueue_pipe(struct ath12k_ce_pipe *pipe,
> > +                                      struct sk_buff *skb, dma_addr_t
> > +paddr) {
> > +     struct ath12k_base *ab =3D pipe->ab;
> > +     struct ath12k_ce_ring *ring =3D pipe->dest_ring;
> > +     struct hal_srng *srng;
> > +     unsigned int write_index;
> > +     unsigned int nentries_mask =3D ring->nentries_mask;
> > +     struct hal_ce_srng_dest_desc *desc;
> > +     int ret;
> > +
>=20
> [...]
>=20
> > +
> > +     ring->skb[write_index] =3D skb;
> > +     write_index =3D CE_RING_IDX_INCR(nentries_mask, write_index);
> > +     ring->write_index =3D write_index;
> > +
> > +     pipe->rx_buf_needed--;
> > +
> > +     ret =3D 0;
>=20
> nit.
> I think '=3D 0' can be initializer like other functions.
>=20
> > +exit:
> > +     ath12k_hal_srng_access_end(ab, srng);
> > +
> > +     spin_unlock_bh(&srng->lock);
> > +
> > +     return ret;
> > +}
> > +
> > +static int ath12k_ce_rx_post_pipe(struct ath12k_ce_pipe *pipe) {
>=20
> [...]
>=20
> > +
> > +             ATH12K_SKB_RXCB(skb)->paddr =3D paddr;
> > +
> > +             ret =3D ath12k_ce_rx_buf_enqueue_pipe(pipe, skb, paddr);
> > +
>=20
> nit.
> this blank line can be removed.
>=20


Sure will address in the next version of the patch

> > +             if (ret) {
> > +                     ath12k_warn(ab, "failed to enqueue rx buf: %d\n",=
 ret);
> > +                     dma_unmap_single(ab->dev, paddr,
> > +                                      skb->len + skb_tailroom(skb),
> > +                                      DMA_FROM_DEVICE);
> > +                     dev_kfree_skb_any(skb);
> > +                     goto exit;
> > +             }
> > +     }
> > +
> > +exit:
> > +     spin_unlock_bh(&ab->ce.ce_lock);
> > +     return ret;
> > +}
> > +
>=20
> [...]
>=20
> > +
> > +int ath12k_ce_send(struct ath12k_base *ab, struct sk_buff *skb, u8
> pipe_id,
> > +                u16 transfer_id)
> > +{
>=20
> [...]
>=20
> > +
> > +     ath12k_hal_srng_access_end(ab, srng);
> > +
> > +     spin_unlock_bh(&srng->lock);
> > +
> > +     spin_unlock_bh(&ab->ce.ce_lock);
>=20
> Two unlock are duplicate of err_unlock. I think they can be merged to a s=
ingle
> copy to reduce maintain effort. If my opinion is accepted, maybe rename
> err_unlock to out_unlock because it becomes a normal flow.
>=20

Sure will address in the next version of the patch

> > +
> > +     return 0;
> > +
> > +err_unlock:
> > +     spin_unlock_bh(&srng->lock);
> > +
> > +     spin_unlock_bh(&ab->ce.ce_lock);
> > +
> > +     return ret;
> > +}
> > +
>=20
> These opinions are not very important. Just for reference.
>=20
> Ping-Ke

Thanks
Karthikeyan
