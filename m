Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B979101ACF
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Nov 2019 09:03:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726921AbfKSID3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 19 Nov 2019 03:03:29 -0500
Received: from mx3.watchguard.com ([63.251.166.21]:12062 "EHLO
        mx3.watchguard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725784AbfKSID3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 19 Nov 2019 03:03:29 -0500
Received: from PRDITOMBX01.wgti.net (172.24.2.21) by PRDITOMBX01.wgti.net
 (172.24.2.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1531.3; Tue, 19 Nov
 2019 00:03:26 -0800
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (172.24.2.15) by
 owa.watchguard.com (172.24.2.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1531.3 via Frontend
 Transport; Tue, 19 Nov 2019 00:03:26 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KmKX2WIz9DI/rkfAYerzdMgzEPhNpQ4ju8JClrS/dyv4j4LUxl2a25axeWB41lz+6Gp+N8OpX4miRJFUUrK9TSCUZ4vxVDiSm7JD5Jj8ouxelcQ5t4ca61MQIIvDc5hi5CapaxSrdY0We3Dpr5HDOBjF4iPIQst43th8fFlfRtsHicRto2Yai/Cd058crByxYpQvg8eTY661qt47fw/8GRaYzY1hiY0ruWzarAD8XufKp4aACHxAjzNoo+o9vdl8MV7y8GqpozMa+bW83ekx5Pa/Nmke2HxeT/35kjPAHr41FIH5iCS/huW96dd4pYoqCOz2/+GiWmTghgmj8dhdZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HKL6m0dIJCLNnoKAENXq+8D7IgD0SWuS2pS8Sw012xg=;
 b=IEdBUivqqfFH9Pf1VP0ZC0pVbmk5kXmuraC/q6Uze1QWJKqH4I+b3ANnwQuZPWFLp6zfaVAqFm0wiQWGoFrLSiuSTb9iV14XWIeF+tK+DL5R8FEd9WA3oHc6jucynDLkpMJxN9Hk0DIVKbaxoksEbu18Dycj8Hfnn0e45fcK5zJT9VJj8oIyZFB///dihjb4xmhz8gpGKrJOP/tHJ9Mm1GbJt7xsSB7XG2g04S/Z+4isAqRjnUw9pFYoNjQrfy5ehUNKpQ70wBKpPr3KOKF2Fcezv8Yk0vJlr/jb2kCzadRb9Tfv1gEe2BZIIbvil/m8oxuA7wscI15tgjAqbYfFDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=watchguard.com; dmarc=pass action=none
 header.from=watchguard.com; dkim=pass header.d=watchguard.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wgt.onmicrosoft.com;
 s=selector2-wgt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HKL6m0dIJCLNnoKAENXq+8D7IgD0SWuS2pS8Sw012xg=;
 b=TgAL8y+CYCvurmFor9ORyBEzy1GiwPrO6Kjapr/PDzu8cZQTi48rpvdo6hD73OQfGX5c4ln76LFp33j2P4Iy06xzqYf66TIu+ADLr3NDbEeC/0DjLiDteHjnOh7Z8O7FiaN3xx03MX2XII4Ss0EA721gz76/8LwzGi7V9GXz2Cw=
Received: from DM6PR10MB2873.namprd10.prod.outlook.com (20.177.216.210) by
 DM6PR10MB4233.namprd10.prod.outlook.com (10.141.184.208) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.16; Tue, 19 Nov 2019 08:03:24 +0000
Received: from DM6PR10MB2873.namprd10.prod.outlook.com
 ([fe80::481a:55d7:e282:c326]) by DM6PR10MB2873.namprd10.prod.outlook.com
 ([fe80::481a:55d7:e282:c326%7]) with mapi id 15.20.2451.029; Tue, 19 Nov 2019
 08:03:24 +0000
From:   Ming Chen <Ming.Chen@watchguard.com>
To:     =?iso-8859-1?Q?Toke_H=F8iland-J=F8rgensen?= <toke@redhat.com>,
        Ming Chen <ming032217@gmail.com>,
        Johannes Berg <johannes@sipsolutions.net>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH v4] mac80211: Drop the packets whose source or destination
 mac address is empty
Thread-Topic: [PATCH v4] mac80211: Drop the packets whose source or
 destination mac address is empty
Thread-Index: AQHVnEROQmNFleZyvEa38z2h3bxkd6eQzzuAgAFCJbA=
Date:   Tue, 19 Nov 2019 08:03:24 +0000
Message-ID: <DM6PR10MB2873E994ABFB1798B36CE49B9A4C0@DM6PR10MB2873.namprd10.prod.outlook.com>
References: <20191116060833.45752-1-ming.chen@watchguard.com>
 <87blt9ctd4.fsf@toke.dk>
In-Reply-To: <87blt9ctd4.fsf@toke.dk>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Ming.Chen@watchguard.com; 
x-originating-ip: [64.94.121.131]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 70f4a2ba-ec8e-4d71-11f6-08d76cc6f3db
x-ms-traffictypediagnostic: DM6PR10MB4233:
x-microsoft-antispam-prvs: <DM6PR10MB42339D75A6FDF2B4D444765C9A4C0@DM6PR10MB4233.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 022649CC2C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(136003)(396003)(39850400004)(346002)(366004)(13464003)(189003)(199004)(81166006)(486006)(478600001)(11346002)(66946007)(99286004)(9686003)(14444005)(476003)(256004)(446003)(76176011)(52536014)(7696005)(66066001)(64756008)(71190400001)(71200400001)(2906002)(66446008)(66556008)(66476007)(76116006)(55016002)(74316002)(33656002)(229853002)(81156014)(5660300002)(6436002)(102836004)(7736002)(6506007)(6246003)(4326008)(186003)(26005)(8676002)(53546011)(14454004)(86362001)(6116002)(8936002)(25786009)(110136005)(66574012)(316002)(305945005)(3846002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR10MB4233;H:DM6PR10MB2873.namprd10.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: watchguard.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1hx3gnPgZf7mJ04gsMFk+2UBaryMdHGaIgg68kidVdOYZhfpfaiReDc4ZBO1M4oqYcId3823xCMgl92CmPj3u70v3MrluVNo1EkI9DY84SABfLbEocBiUxROCsZmfnTRSpO1IRX2+JTcYgnfKbMcbOs/suS8/d7OqO8afUL06V6K1uwMmQue+sC9x+ScUD9Z7I/dsx4J0uH0aXNzuC1Zy2EFg2JCLMnEL6jQKskEfJoZfueZyyiUHWWGHYBqS0ISWKXYJaJCglm5DvWfI2R0T8f2kPD30kbT5NXyGRLqySw3Rrvdet9UEcsiT88Sv1dugn4pJW+fpBDXa2/jJuzEqHfD7N7SE7CJ4c8fBrhUxzjRE14Xhjz3hDNEW3wrl3mAmtS2JG3D18necn0aCrFH0/kDJsEzGdzRwv2KaWMK/HO58VNzqcBwoZm7OAw/r55o
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 70f4a2ba-ec8e-4d71-11f6-08d76cc6f3db
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2019 08:03:24.4900
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 2563c132-88f5-466f-bbb2-e83153b3c808
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q+Njs//Z54b+dMVJHSHardRyScUmLp5TmBErhRwNmSl5ZVGo6Mf40DCuWfNbNfYcK0KfeaOEuTalgduUDeWzX/oDQBTfa1LX9Xu78Lr+XNs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4233
X-OriginatorOrg: watchguard.com
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Thanks. Please see the inline reply.


Ming

> -----Original Message-----
> From: Toke H=F8iland-J=F8rgensen <toke@redhat.com>
> Sent: Monday, November 18, 2019 3:33 AM
> To: Ming Chen <ming032217@gmail.com>; Johannes Berg
> <johannes@sipsolutions.net>
> Cc: linux-wireless@vger.kernel.org; Ming Chen
> <Ming.Chen@watchguard.com>
> Subject: Re: [PATCH v4] mac80211: Drop the packets whose source or
> destination mac address is empty
>=20
> Ming Chen <ming032217@gmail.com> writes:
>=20
> > We found ath9k could occasionally receive some frames from Linux IP
> > stack with empty source and destination mac address, especially when
> > the radio mode works as a wireless client and configure a static IP.
> > If the ADDBA has been negotiated, this kind of error packets will
> > cause the driver failed to find the opposite node (VAP) while in the
> function of processing these frame's TX complete interrupt.
> >
> > The above failure happens inside the TX complete processing function
> > ath_tx_process_buffer while calling ieee80211_find_sta_by_ifaddr.
> > Inside the function ieee80211_find_sta_by_ifaddr, the condition of
> > ether_addr_equal(sta->sdata->vif.addr, localaddr) will return false
> > since localaddr(hdr->addr2, 802.3 source mac) is an empty mac address.
> >
> > Finally, this function will return NULL to ath_tx_process_buffer.
> > And then ath_tx_process_buffer will call ath_tx_complete_aggr to
> > complete the frame(s), However, the sta is NULL at this moment, so it
> > could complete this kind of the frame(s) but doesn't (and cannot) updat=
e
> the BA window.
> > Please see the below snippet of ath_tx_complete_aggr if (!sta) {
> >         INIT_LIST_HEAD(&bf_head);
> >         while (bf) {
> >                 bf_next =3D bf->bf_next;
> >
> >                 if (!bf->bf_state.stale || bf_next !=3D NULL)
> >                         list_move_tail(&bf->list, &bf_head);
> >
> >                 ath_tx_complete_buf(sc, bf, txq, &bf_head, NULL, ts,
> > 0);
> >
> >                 bf =3D bf_next;
> >         }
> >         return;
> > }
> >
> > To fix this issue, we could remove the comparison of localaddr of
> > ieee80211_find_sta_by_ifaddr when works as a wireless client - it
> > won't have more than one sta (VAP) found, but I don't think it is the b=
est
> solution.
>=20
> Ah, so the TX path doesn't do any lookups when the device is a sta, but t=
he
> TX completion path does? This was the information I was looking for; plea=
se
> explain this in the commit message, you don't need to paste in the code :=
)
>=20
[Ming Chen] As I said previously, this issue can be exposed when the radio =
works as a wireless client. The TX path will look up the sta(vap) by BSSID =
instead of mac address in SKB (see ieee80211_lookup_ra_sta). The BSSID woul=
d have been stored when the client is connected, so it could succeed to get=
 the sta(vap). However, in the TX completion path, it will also compare the=
 source mac in SKB and the one of the interface, after it retrieves the sta=
(vap) from hash_node table (see ieee80211_find_sta_by_ifaddr).

> > Dropping this kind of error packet before it goes into the driver,
> > should be the right direction.
>=20
> So I still wonder why this happens from higher up in the stack. If there'=
s a
> legitimate reason, maybe dropping the packet is not the right thing? And =
if
> there is *no* legitimate reason, maybe the packet should be dropped highe=
r
> up in the stack instead?
>=20
> What kind of packets does this happen with?
[Ming Chen] It should an ARP packet. I can see this kind of packet before A=
RP table is complete. If so, how about dropping it in the function of ieee8=
0211_subif_start_xmit?
>=20
> -Toke

