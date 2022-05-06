Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1046351D71D
	for <lists+linux-wireless@lfdr.de>; Fri,  6 May 2022 13:55:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391556AbiEFL7Q (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 6 May 2022 07:59:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1391581AbiEFL7L (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 6 May 2022 07:59:11 -0400
Received: from esa.hc3962-90.iphmx.com (esa.hc3962-90.iphmx.com [216.71.140.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A313065DD
        for <linux-wireless@vger.kernel.org>; Fri,  6 May 2022 04:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qccesdkim1;
  t=1651838126; x=1652442926;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=MmkrEZRLcwI6hirsX9dKPnLus5M+FrCaGo8LIfUW28w=;
  b=iNYXk5URVL/J7Z9lFLDHdO5MyrcynDO77YXiqAx45rNGk1s0wzsGrsIB
   6tG2EM1JkRmdMaB45Cluci0jwigcdpEOYx3FTGYJgvJTa39bFps9mpIhP
   MDGco/x6ICiCcibAzePvPQPiKicS69D9LIkDcgTdEW54Ma4CwxeKxTgQs
   o=;
Received: from mail-dm6nam12lp2171.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.171])
  by ob1.hc3962-90.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2022 11:55:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BlqUl5Pi1Oy9HQ/fQxVU1NAlU5xvT2xHyjfZnUj6T2zXjwYfSBGE79vDVnj527Wv6B+jV9oHTX6oP4hHeUvzT+d3mRmJD8Zz6JQy9aSpyKGL03m0hebYADQ2+/Q0taRng3MOXb24ZbUtH1k638ZtMlwXf7m/zy8L3ldaTD+Rx2uNTKDRStKyKOc3Qn9BPAwd/JZnDs8Xm85I3Lz/wplxDnEjZSSdpD1JlU7c5UC1SHdkwUMF53ZFHVkG3XjbFMbeVUZtiWo2AWc/Avept5IvESW2x02ASFXRnQUBSKE3IfwF7+fYicRSDirZESa+myfwZDnJ+lLAGoVrUQ4Vvdlkzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MmkrEZRLcwI6hirsX9dKPnLus5M+FrCaGo8LIfUW28w=;
 b=IbzY6MLjpiTh2Gx2aH9XbouOh7kSs+cl6ECJ7e8nY85aWVv5pbFu0stfQyr6ugCleMwADBP2oVclAIKYscdpJ5cFFX4rnysHtHpFVJM4M5DzCUrFraKKI6BIuYVitqcJILwBevbpkdZDWyHApQ4DGoQ48ay3m3Ji3uPM6EF6wY0TIDbOPzwfl7RM7u2FpYPfg+kbV1erBz0I1WO2faHHG0XO97B4aZTSQTPxs31s2w9YYPJYUUv1GacH9vJZX6scwT9tVrh+jLsk23z7ALY2xKydeXY6TEOiE8C7e+KNI4bM7VBOo8RPDb+U2prhInEm4OBuitsaeEvlrsVrKh/RSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
Received: from DM8PR02MB8199.namprd02.prod.outlook.com (2603:10b6:8:3::7) by
 SJ0PR02MB7246.namprd02.prod.outlook.com (2603:10b6:a03:29f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24; Fri, 6 May
 2022 11:55:23 +0000
Received: from DM8PR02MB8199.namprd02.prod.outlook.com
 ([fe80::80f6:cc51:2548:d939]) by DM8PR02MB8199.namprd02.prod.outlook.com
 ([fe80::80f6:cc51:2548:d939%9]) with mapi id 15.20.5206.025; Fri, 6 May 2022
 11:55:22 +0000
From:   "Seevalamuthu M (QUIC)" <quic_seevalam@quicinc.com>
To:     "Seevalamuthu M (QUIC)" <quic_seevalam@quicinc.com>,
        Kalle Valo <kvalo@kernel.org>
CC:     "ath11k@lists.infradead.org" <ath11k@lists.infradead.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH] ath11k: Add support for dynamic vlan
Thread-Topic: [PATCH] ath11k: Add support for dynamic vlan
Thread-Index: AQHYBdP/UYq0xfuHg0+PEcWlfHVINKxnMTwTgCIc9LCAiST50A==
Date:   Fri, 6 May 2022 11:55:22 +0000
Message-ID: <DM8PR02MB8199F26D0C35827401CD2686F6C59@DM8PR02MB8199.namprd02.prod.outlook.com>
References: <1641786090-10232-1-git-send-email-quic_seevalam@quicinc.com>
 <87bl0asfsp.fsf@kernel.org>
 <DM8PR02MB8199EBB0A4ACC6F64F8C92FFF62D9@DM8PR02MB8199.namprd02.prod.outlook.com>
In-Reply-To: <DM8PR02MB8199EBB0A4ACC6F64F8C92FFF62D9@DM8PR02MB8199.namprd02.prod.outlook.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=quicinc.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f30d7967-1870-499f-50bc-08da2f574d28
x-ms-traffictypediagnostic: SJ0PR02MB7246:EE_
x-ld-processed: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d,ExtAddr
x-microsoft-antispam-prvs: <SJ0PR02MB72465E75E400A2AF8ACE4F328AC59@SJ0PR02MB7246.namprd02.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EM8A/vKVlZZPFi6eJE+9/RDUdLx7AFupTIxwyMZtU+F+V4U72qOZRZ9GwbW0/ltBA5D0m/UElDu6eykE3/JABRsLYNrrvuBfLjwkT2RK5YyRZEp+4JNrGCQ1ET14k8AhrbdQQFnTjc3BJ6hbmQkMNArQjZ54xAIwOuUZtELsgJujmOj9JcEt2I7bqob39ikTH8nstrAxy1lSZDgj+1LbJN/YOPTeG7/6W9wkqNPOFWf/xQ9bX4VJ0hUzmxv71tVfKv9sbEvM3aHr6UJx0GSzaasZa+6NH3m3TEziE31doCTwt5ChOYVBcZ/Wv/Q3rMOH5VXhpkTBSo9rxPFwqk3LJF7/L+m5wJ2fA2FRGk+fCKgFigfwq9yZaRSfeLrlJevxht554PP+UnBCtKwwFOTCPql9yO+T1YBP+Sr6Ny0HnLJST9v+st9AzOl1pTPjwdSl/GVvEttDdifWDXrJzn49KmA2umMdEfuHUDa9Dqb+qldOVN154QINkri30EFKXvGL/7Yj8IXyF/ulSF5QmGquF7eqyoZq0lqwCEMcup1ZjCGdt5iBUjs1uA+G0nMAXgGEFO7uJh191rAEqRvKLiSKcZG4+n1ppt+GHU6hmC7kdKbdjP7SH9o1zVXmbVSrz9ZHc7WIXp9imExeSs9SKfNDOrQTrXjcQB1p2C6DH6td7/jfV2cK7RhLgxtPmP3H4Uoo8PZgiRsum4qxiBulM5ZpJw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR02MB8199.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38100700002)(38070700005)(33656002)(122000001)(86362001)(110136005)(54906003)(76116006)(2906002)(316002)(71200400001)(64756008)(66446008)(66476007)(4326008)(66556008)(8676002)(5660300002)(52536014)(8936002)(66946007)(186003)(83380400001)(55016003)(6506007)(7696005)(9686003)(53546011)(508600001)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?CV9NfnXBdUvwJZ2hkuJYMB5efpTzJMmenXlbuNgdLnKxh4G6aALnC3yZc6qY?=
 =?us-ascii?Q?bv+z8yvltOC4mhuIrAItk8AprpGiNbrsEpMBhxPpzDLAMWosttJgHlnCQ3my?=
 =?us-ascii?Q?jcXOuhqFNBWJDn+bqbZ6A2ml+dPawr2hCkBr3txfMFf79P971aBu89Ob6zen?=
 =?us-ascii?Q?WIq8EPc6+Btj426lWJs1t6ydELQudHWyvybGJpW0aHgFcXPJy1B8z5m7RtQz?=
 =?us-ascii?Q?KsRWP6VScwTzUB8FvoHyBZnwVYNkey9vpGxi/oAKsOdSJfUyLRplpeB3ULu8?=
 =?us-ascii?Q?bPw/yHY0agsTpU6Lu2llEhy3SNtQSZd80mliuMtA4GrttoaUny5mMwdAgj6Y?=
 =?us-ascii?Q?4XS6nG4g2MBCdQT5zy7asDHH0Mc8KdiRdAnPKFEUJMhTLUi2orJkLlqSDonJ?=
 =?us-ascii?Q?Uhc3e6leaFuAgWrH0QiGULgDiZI+v8C4wnXfuZiA+A4mvSqCgrF2qMrdeUKv?=
 =?us-ascii?Q?08/o+GHKuN8+A88ACeE2dnyBHV/pO6OaUmduGzGgXzaw0vNrqTtJViMkd7Gb?=
 =?us-ascii?Q?x+7k86RmKNSfHUZpkGKce+mQDHmYMaEnMlcUktsbxyGzWzF/7sphEBPFkrmR?=
 =?us-ascii?Q?qyVj3HVv8qHi8Rb4RZFdxyXKudHiScffhGSPxUN7KkSbHj+aFxKVlnc1CHeO?=
 =?us-ascii?Q?0AsJmY95s/YPoc+h4xfKnpo/D5xekYZ05SOGYum676B4St7v0OtTxSZHtXE6?=
 =?us-ascii?Q?FhFI7MdJ2Mc5VoioVXFV5RmBnJi6AiUBtiI/jL4ouYG4Tc3TCjscjogUXYX4?=
 =?us-ascii?Q?uQy2Tli57cKZJ/fyEhXObR1LZ6xz1SBLLE+euxoEGl1TjfqIu5g6nd3QVBNn?=
 =?us-ascii?Q?/aIDodO1HOx+fQZnwdLPj2JzXpaof6+4fkCWxUXmEbUp04kvwMVzBNaMo9Go?=
 =?us-ascii?Q?XXWGqbjxtp1oezp8udNbeNkaJ0R/K5y/ixHriOSeeSUs0cUzMuGidvybif+j?=
 =?us-ascii?Q?0lLjqbr3SE3zm5D+ijoQyjo/XhorjsmP0YZ9nRc6zQsxeX7CmgtuePi1wRYu?=
 =?us-ascii?Q?5+gMiKrqCxjGDFrgjKDila9c7RraFHH6l6jE+TCb934SsjVSmXs6j6pG5D9f?=
 =?us-ascii?Q?vjipnaGE45rv9YnKfwgV4zKsiEkFt08SDcu8hs4LnvvQwmk+bbQQkgko2+10?=
 =?us-ascii?Q?jYHq5enyBO58q1oYF1N+RJB5kemgfZgO3oCaYmVC+rM1lLeLTpfQHVw6xacJ?=
 =?us-ascii?Q?0telmUQJrS3+/Ut4jVcT3NKcF8+2CGVD+rnK41JshjIzDJpNrWDq90oq2F0c?=
 =?us-ascii?Q?ey7HImmb2dA9Jj2PZtwB+QmIAIwKD2sYC7P9w6A8RviZx3cf64E02zSGtvlA?=
 =?us-ascii?Q?wJSY/r0XmYn71n4pytrXmQ1lKnn25m5c2tVI6W+xAUFH6ptmA0g9cmDNIeDE?=
 =?us-ascii?Q?Z2biaZNwFSycseT5Xa3xMCUfW2pytG4tXr/GHVewC70ZXNa2HOHJFI4IzKQP?=
 =?us-ascii?Q?gwSA606Tyeb7Igazrs9HfbM1Ad23DlIXkyB9ZdvqucbD5GrU297vus/ufO9a?=
 =?us-ascii?Q?W05yrW9C1d+/t4E1xXKFo6eqsd+bVj+g9FG3wdMYYmKLeFuTe1BR1j2T6KcQ?=
 =?us-ascii?Q?9ofjqzU4DQpvAwyYAPKRJfTj1XHaXOFFeZOJW9fXrqwnbaNNUEhmijUg/DQY?=
 =?us-ascii?Q?/Kxa0UjyO9sb1oi29N6UONE5rGLi149zVapq15zZKEbkPMRiIMsgiDKWk/ke?=
 =?us-ascii?Q?vECpDErQhbM5CDJ+id+TrdszMw0ue8m21DiLLaOBUlgQSseAuXACu8clkUeR?=
 =?us-ascii?Q?BBciq+NmIw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR02MB8199.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f30d7967-1870-499f-50bc-08da2f574d28
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2022 11:55:22.9338
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xaJ73lc0rpmIM7wWxLpb6SCWIWYdeJmY60sxYRWig+CTtJbp0Mtr3urj0rgAPl4BTo5m6l6cTBgbSNOzqWPbTQTwTBzB9U6nbNoPqO6TZaU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB7246
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org



> -----Original Message-----
> From: Seevalamuthu M (QUIC) <quic_seevalam@quicinc.com>
> Sent: Tuesday, February 8, 2022 11:00 AM
> To: Kalle Valo <kvalo@kernel.org>; Seevalamuthu M (QUIC)
> <quic_seevalam@quicinc.com>
> Cc: ath11k@lists.infradead.org; linux-wireless@vger.kernel.org
> Subject: RE: [PATCH] ath11k: Add support for dynamic vlan
>=20
> Hi Kalle,
>=20
> > -----Original Message-----
> > From: Kalle Valo <kvalo@kernel.org>
> > Sent: Monday, January 17, 2022 6:03 PM
> > To: Seevalamuthu M (QUIC) <quic_seevalam@quicinc.com>
> > Cc: ath11k@lists.infradead.org; linux-wireless@vger.kernel.org
> > Subject: Re: [PATCH] ath11k: Add support for dynamic vlan
> >
> > Seevalamuthu Mariappan <quic_seevalam@quicinc.com> writes:
> >
> > > Advertise AP-VLAN interface type for vlan support in driver.
> > > Metadata information in dp_tx is added to notify firmware that
> > > multicast/broadcast packets are encrypted in software.
> > >
> > > Tested-on: IPQ8074 hw2.0 AHB
> > > WLAN.HK.2.5.0.1-01073-QCAHKSWPL_SILICONZ-1
> > >
> > > Signed-off-by: Seevalamuthu Mariappan <quic_seevalam@quicinc.com>
> >
> > [...]
> >
> > > --- a/drivers/net/wireless/ath/ath11k/dp_tx.c
> > > +++ b/drivers/net/wireless/ath/ath11k/dp_tx.c
> > > @@ -78,6 +78,44 @@ enum hal_encrypt_type
> > ath11k_dp_tx_get_encrypt_type(u32 cipher)
> > >  	}
> > >  }
> > >
> > > +#define HTT_META_DATA_ALIGNMENT    0x8
> > > +
> > > +static int ath11k_dp_metadata_align_skb(struct sk_buff *skb, u8
> > > +align_len) {
> > > +	if (unlikely(skb_cow_head(skb, align_len)))
> > > +		return -ENOMEM;
> > > +
> > > +	skb_push(skb, align_len);
> > > +	memset(skb->data, 0, align_len);
> > > +	return 0;
> > > +}
> >
> > [...]
> >
> > > @@ -211,15 +250,42 @@ int ath11k_dp_tx(struct ath11k *ar, struct
> > ath11k_vif *arvif,
> > >  		goto fail_remove_idr;
> > >  	}
> > >
> > > +	/* Add metadata for sw encrypted vlan group traffic */
> > > +	if (!test_bit(ATH11K_FLAG_HW_CRYPTO_DISABLED, &ar->ab-
> > >dev_flags) &&
> > > +	    !(info->flags & IEEE80211_TX_CTL_HW_80211_ENCAP) &&
> > > +	    !info->control.hw_key &&
> > > +	    ieee80211_has_protected(hdr->frame_control)) {
> > > +		/* HW requirement is that metadata should always point to a
> > > +		 * 8-byte aligned address. So we add alignment pad to start
> > of
> > > +		 * buffer. HTT Metadata should be ensured to be multiple of
> > 8-bytes
> > > +		 *  to get 8-byte aligned start address along with align_pad
> > added
> > > +		 */
> > > +		align_pad =3D ((unsigned long)skb->data) &
> > (HTT_META_DATA_ALIGNMENT - 1);
> > > +		ret =3D ath11k_dp_metadata_align_skb(skb, align_pad);
> > > +		if (unlikely(ret))
> > > +			goto fail_remove_idr;
> >
> > If you push the skb like that shouldn't you also reserve the room for
> > it in struct ieee80211_hw::extra_tx_headroom?
>=20
> [seevalam] : already this is handled using skb_cow_head() in
> ath11k_dp_metadata_align_skb(). Please correct me if I misunderstood your
> point.

Hi Kalle,=20

Do you have any comments on this?=20

Regards,
Seevalamuthu M

