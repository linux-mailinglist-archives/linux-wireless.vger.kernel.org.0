Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3865A4743A7
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Dec 2021 14:39:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230262AbhLNNji (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 14 Dec 2021 08:39:38 -0500
Received: from esa.hc3962-90.iphmx.com ([216.71.140.77]:62894 "EHLO
        esa.hc3962-90.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232273AbhLNNji (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 14 Dec 2021 08:39:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qccesdkim1;
  t=1639489177; x=1640093977;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ORfmEoTg5e6IUOr/myEXcsnuWWwuA0/vVDltSH7iVQQ=;
  b=Spr3fukZ21u7/IURKJPSfqFaQF5eWWfOSoNvZFFTBhb7kuc0KtLRvRDr
   +LMreiJMl18kvYRSDib5ezRqALR1ThvMm5lSaLguPRHgUTWvckE+Ztpon
   xM3TocG/GPXJJCo+IeitXr4LMS/U9xNkViO6jniC52x40hcrHVhS+VwCO
   E=;
Received: from mail-dm3nam07lp2043.outbound.protection.outlook.com (HELO NAM02-DM3-obe.outbound.protection.outlook.com) ([104.47.56.43])
  by ob1.hc3962-90.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2021 13:39:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jr1oC4tSPyIqnSp+ahqwf1bNeOQVwOrxyL4EWFUFA3BtiRCtVqJAg6J4IRelNs9SHGe3+ZBz7MKrIgbBokBABUiwIwhnYTirQm8ZGvjzpAciK3RMPF6Hy35z9oWWsMmHbpqeUHSOG90hd0uz/FOUtVi60MP6q3c73H2Fe0Rpn9mF75woC7u7WLfQY5Gorh39ZkLruoMoCz/Pzv7F+8QD8XlQIFnpFm6tfW8TVm0n70TtCWkegv9hnakFT+2Nl41ZeWchqe95wdkWy3XDg/RUXLIl3stJ1smHs6iPLEOP/py4qEWTBthv7kEQrAy2eoNC/kc9SVcft7uJbsIXSXHtmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ORfmEoTg5e6IUOr/myEXcsnuWWwuA0/vVDltSH7iVQQ=;
 b=KpNbfFGuEolo2uv+F/mOmTbmJl15Pk8PXJbYUVjUWG5jcDXD1RWTZDN3gQEbxFIdFueW0wyim5Ev62MmOluzfESNxv7Ijlcx8an4LuOTAfMIOYf2Zxb8j3QWJxYBYiduu2mgG1YY6sGzcZFgHhF4P41sgTZVWBhBl6Bm8VhVWKUE4mYT2g89SkPt3wkz6MZS8wemklVIlmbcBkqFthbGEOkYTANl2RtIj7wj2CHeHp8YOp8crt6hrndid0erO3hoRiTYR9g5SfLY1nBSNyj98VzI/M8bjP8yEZP5WeL1DNbPuVePslUhHkH8zUUjM3hTkxQMtKTz+VbpnM2an6EEaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
Received: from DM8PR02MB8154.namprd02.prod.outlook.com (2603:10b6:8:1b::15) by
 DM6PR02MB6922.namprd02.prod.outlook.com (2603:10b6:5:252::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4778.11; Tue, 14 Dec 2021 13:39:36 +0000
Received: from DM8PR02MB8154.namprd02.prod.outlook.com
 ([fe80::a024:dbf:49ab:8e4e]) by DM8PR02MB8154.namprd02.prod.outlook.com
 ([fe80::a024:dbf:49ab:8e4e%8]) with mapi id 15.20.4778.017; Tue, 14 Dec 2021
 13:39:36 +0000
From:   "Venkateswara Naralasetty (QUIC)" <quic_vnaralas@quicinc.com>
To:     Kalle Valo <kvalo@kernel.org>,
        "Venkateswara Naralasetty (QUIC)" <quic_vnaralas@quicinc.com>
CC:     "ath11k@lists.infradead.org" <ath11k@lists.infradead.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCHv2 1/2] ath11k: add dbring debug support
Thread-Topic: [PATCHv2 1/2] ath11k: add dbring debug support
Thread-Index: AQHX3SUI6bNZzMFUrkagQwAhoH5RlawnV+KHgArN4UA=
Date:   Tue, 14 Dec 2021 13:39:35 +0000
Message-ID: <DM8PR02MB8154D011444A2EAFDC6F42D6E6759@DM8PR02MB8154.namprd02.prod.outlook.com>
References: <1637312901-10279-1-git-send-email-quic_vnaralas@quicinc.com>
 <8735n4nzca.fsf@codeaurora.org>
In-Reply-To: <8735n4nzca.fsf@codeaurora.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=quicinc.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 007f7097-e456-4629-7254-08d9bf072b39
x-ms-traffictypediagnostic: DM6PR02MB6922:EE_
x-ld-processed: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d,ExtAddr
x-microsoft-antispam-prvs: <DM6PR02MB69226DD2E3DF1739DC7FC4989A759@DM6PR02MB6922.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: g7vXLHgdsO0/NgnsloDg8OjioY+eXdgWfat1TpMZlzd8vsAK5/a1ZN3PydF8kieBqCInOUjh8AAiGgJ5zGLyecikVH7PR9hgVI+mtguYTq3VGw/baAxFKNTU1cg55gI7x2F1Ribr51rjaBPBje9OZ6K6tLydDF0usI320dDKUojygh4LB6wpBb21fzNAPW0YUMMof7xfBnHwUYmi+UUxH8UUbZCrl/w32vVcwEVjkKvyxB2m/PhM76BWotiwriPzUIrzb56SjFWbKmquWQ96rTD8qA2xl80JSbcwocoquB66FyKGyYsw5lu5+vdit0sCHAFzjih5DX+sfNn84DC8OcaobIvfZ1WBJP1ZYZiDPqhhBvxnxY6NbeJQaumTyYVvMWOz+BiyTHV4ZeMIQolY4wr6VveSVPxz3PGZo7OKgCot6w0AyIWl6GXcfZSiKHm8Kw0VqrcsaPidwC5B/Rde3Bvc7LjKZxc06gwUfZh3yLpJXWKRh9ymlwX7EtLFS6nb1/IZRJxI6FLRoqIKopmC6EKx5qtod1Kj/vVgnuBxeem4a5R0DlptgYPJzchA/zjM+8C8W7W2o8X5rfeVZ3ngZ0a/B0QvZWLHFL1yNFae3VttnrsoYFFEh9r/RXc/MLaOdVNuRPp7xTXciiOCYAhoNh6+cjeUDvrvD/tnuZydHKfPbghI8u1KA9n5kwcdfxRoLrqf4dG/vZboTeMo8Tk1jtwzpLIqndyXoywvPjcQWKShgkER3oKArVYsEkZWGrAMbXclLoNLbeY2mEFrgELZDCzv28Qq0fVb4U195TLOo3dLPXytl0SOda6kIXMyGfxAA9NHds9wCaOnwkreHw1IgA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR02MB8154.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(55016003)(122000001)(86362001)(38100700002)(7696005)(2906002)(8936002)(110136005)(9686003)(316002)(8676002)(186003)(52536014)(38070700005)(53546011)(6506007)(66446008)(83380400001)(66946007)(966005)(54906003)(71200400001)(66556008)(5660300002)(33656002)(64756008)(4326008)(26005)(76116006)(66476007)(508600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?AjXvgviwqXxaJZjh2J45/iKIoDAyfNacVv/Xz4skmu2VHRlXN+HyNjyW9HEy?=
 =?us-ascii?Q?XTJ9JpESVBNwm7zfvO5Y5wXvFqoqmE8tBPfFBwXqjd8q1Kx61107kFyJwRGU?=
 =?us-ascii?Q?V5EFnDBOwW3A/FAEXzoECf1oLlNs7UgEuVZ9rvAyOCzuvpYGSKqhzAvWVzJg?=
 =?us-ascii?Q?3OykoD3Qh6ozLbN03mn35jZ0Jzb4wYOUbnhDDACi2VPjiRTggxjqvwmM8nGl?=
 =?us-ascii?Q?EnZtbJqwNG8KHojO8Kg3fRcWJdXvYR3nSYTYFgtLbH+gfmoJo/PiWxZWeNeK?=
 =?us-ascii?Q?gS/L9FLofVXXRoJok3oAG4bCmHN4LrXXg9J26DJnH5qRCJdC7/l3mnE2qaog?=
 =?us-ascii?Q?60jFdUdFNRgrrEE2dkJkvmzTpNweGjsd03ajhx2KUtEIuNIRxHoLvkc5kB6V?=
 =?us-ascii?Q?jXPnrmU+AiJ3soW6gVPKKb9vuj4tUctj9I1LFVArMYRe6H+4Y5Wu0IM2p+BD?=
 =?us-ascii?Q?Rwic0p7fq0Ve8NPiX0fQOIUyTY9D9fSoTjY/SjV0KUHQTZicm6i0C+HkdiV3?=
 =?us-ascii?Q?ZiHQLLNqkY5OjLWonAjsLt75P10dCX6II2o7Uv0aCnSMtILZDhm9KnaXdqAB?=
 =?us-ascii?Q?4pnSN6dpOur+MxvSn3n5bDkgU0x9CETRc8jrm6dwaqtZivvW8OfdlUYvG+Cb?=
 =?us-ascii?Q?3ecsqA70y61wKjcHahA6tSg+5MRasTR2fqUJeT/Oy1DLMGn33bPgOfBfShnE?=
 =?us-ascii?Q?0jGEKc7AxZu3tUez7tIbuIHlnabRJ8uS2/SviOIA3KMsiKKh6pQj2W1DyCrv?=
 =?us-ascii?Q?zgDe+k3zN0WJO1KwCbVy4JZbLXcdjjlBEr5/Bympou5ozam9alK+ukPNK0Vr?=
 =?us-ascii?Q?49v5ODfA5a8d+xQFYtMx3/prMJC8xmpTT5jY1brui4HbWvsEii2QLVY1dNuA?=
 =?us-ascii?Q?iM5LbRGgnG2xzvFV1QMkEWx0IHtV05+QdAFplCHDuf4Szsb6rrP6omZwc5WN?=
 =?us-ascii?Q?S5kHaJMQ/cpJebcMEaBs4EbRLTIw/kLixmQ0agfO8RwhWlb7pvem9UgDGAbF?=
 =?us-ascii?Q?7P04qDFXQE+sO11NdybjpmJQSr1W0l7lFWZGRJY6CRiGabLibXr4RI1BDTiL?=
 =?us-ascii?Q?YVMUlqDh3s3bVmO7N4gD9nR+BrHrJZJBp3fH+1Mn4PEDK6KcWWOGdvGUb4Kj?=
 =?us-ascii?Q?7u3G9cEeW51SEuL9l1AnahkyXdOh+Bqm5wFX6L/j31RYGmREiZyNhAWTg+5T?=
 =?us-ascii?Q?pXC7PdjbDRtbPgfh621iahlysAitbpE7l0RL6JzlT+YkZP15DngJszOckC2z?=
 =?us-ascii?Q?O3WeGOLyPwianAUt+38y9g3J8lCB9OcsnLCGRC6dNJLEZAhEYJVaXM6k/ZBu?=
 =?us-ascii?Q?Ea9R4yHBefToi99XY26JIVibGkKvv1urDof2EArFx6rGLgo85DeNEqcuL/SS?=
 =?us-ascii?Q?wE5yub4EXr+Hud8wQJyWNgk0Dl6CSxqUyG9qqOPWvc/Btb/1h45ToWUiVKoB?=
 =?us-ascii?Q?eZZyTIeAQfN0790w2gL6A2SLz30xwgcPItfV/pUFkwoPMTp9fFnzazbpJf8M?=
 =?us-ascii?Q?w0yve20+c4fI8YaqW6+3ZlOrcstHshAbRn3/sHTRycfgQ9kVgdRBWBmvcrrI?=
 =?us-ascii?Q?CADQdgqM2j+7tm0GwLOVwXu2dzpADOCJ4Pjvyc0+vw2opgx7mrMykWB4QXMm?=
 =?us-ascii?Q?J7BLcieo885XmMvkUbttLSuR6DAXLUD8tpAEkgwvKvv9?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR02MB8154.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 007f7097-e456-4629-7254-08d9bf072b39
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2021 13:39:35.9571
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wgHTserAe+sQBLcRaqL2W2V4I8IkxGtnqQosyRVfEm7enZaJRrPc3zK4oUCui09WJNbQchkpeWbCNjXAD+UvmHMRxDZwACD/tU1RxglpYHM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB6922
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

> -----Original Message-----
> From: Kalle Valo <kvalo@kernel.org>
> Sent: Tuesday, December 7, 2021 10:10 PM
> To: Venkateswara Naralasetty (QUIC) <quic_vnaralas@quicinc.com>
> Cc: ath11k@lists.infradead.org; linux-wireless@vger.kernel.org
> Subject: Re: [PATCHv2 1/2] ath11k: add dbring debug support
>=20
> Venkateswara Naralasetty <quic_vnaralas@quicinc.com> writes:
>=20
> > Target copies spectral report and CFR report through dbring to host
> > for further processing. This mechanism involves ring and buffer
> > management in the Host, FW, and uCode, where improper tail pointer
> > update issues are seen.
> >
> > This dbring debug support help to debug such issues by tracking head
> > and tail pointer movement along with the timestamp at which each
> > buffer is received and replenished.
> >
> > Usage:
> >
> > echo <module_id> <val> > /sys/kernel/debug/ath11k/ipq8074_2/
> > mac0/enable_dbr_debug
> >
> > module_id: 0 for spectral and 1 for CFR
> > val: 0 - disable, 1 - enable.
> >
> > Tested-on: IPQ8074 WLAN.HK.2.4.0.1-01467-QCAHKSWPL_SILICONZ-1
> >
> > Signed-off-by: Venkateswara Naralasetty <quic_vnaralas@quicinc.com>
>=20
> The commit log is really minimal and is not really describing the whole
> implementation. For example, I see that you create a new directory debugf=
s
> and the commit log mentions nothing about that.
>=20
> What about other hardware like QCA6390 or WCN6855? You mention nothing
> about those, how are they affected?
>=20
Sure, I will update the commit log in the next version.

> And to be honest, I'm not sure if this debug feature is really worth to h=
ave in
> upstream due to the extra complexity it creates.
>=20
> Also usually it's a good idea to have the fix first in the patchset and t=
hen extra
> patches after the fixes. That way it's easy to take the fixes and skip th=
e extra
> patches.
>=20
We faced few issues like head/tail pointer discrepancies between ath11k hos=
t  & FW during spectral scan feature development.
So, this debugfs entry would be helpful to debug such kind of issue in futu=
re.

> Few comments when I was skimming this over:
>=20
> > --- a/drivers/net/wireless/ath/ath11k/core.h
> > +++ b/drivers/net/wireless/ath/ath11k/core.h
> > @@ -442,6 +442,7 @@ struct ath11k_debug {
> >  	u32 pktlog_peer_valid;
> >  	u8 pktlog_peer_addr[ETH_ALEN];
> >  	u32 rx_filter;
> > +	struct ath11k_db_module_debug
> *module_debug[WMI_DIRECT_BUF_MAX];
>=20
> module_debug is not really a descriptive name for a field.

Sure, I will change it.

>=20
> > --- a/drivers/net/wireless/ath/ath11k/debugfs.c
> > +++ b/drivers/net/wireless/ath/ath11k/debugfs.c
> > @@ -50,6 +50,45 @@ static const char
> *htt_bp_lmac_ring[HTT_SW_LMAC_RING_IDX_MAX] =3D {
> >  	"MONITOR_DEST_RING",
> >  };
> >
> > +void ath11k_dbring_add_debug_entry(struct ath11k *ar,
> > +				   enum wmi_direct_buffer_module id,
> > +				   enum ath11k_db_ring_dbg_event event,
> > +				   struct hal_srng *srng)
> > +{
>=20
> The style used in ath11k is that the second word describes the filename t=
he
> function is in. So this should be something like
> ath11k_debugfs_add_dbring_entry().
>=20
> > +	struct ath11k_db_module_debug *db_module_debug;
>=20
> Similar naming for structs, please.

Sure.

>=20
> --
> https://patchwork.kernel.org/project/linux-wireless/list/
>=20
> https://wireless.wiki.kernel.org/en/developers/documentation/submittingp
> atches
