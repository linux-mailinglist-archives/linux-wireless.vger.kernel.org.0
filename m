Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 924784AD10E
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Feb 2022 06:34:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347479AbiBHFdX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Feb 2022 00:33:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbiBHFbQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Feb 2022 00:31:16 -0500
X-Greylist: delayed 62 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 07 Feb 2022 21:31:14 PST
Received: from esa.hc3962-90.iphmx.com (esa.hc3962-90.iphmx.com [216.71.142.165])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1172DC0401DC
        for <linux-wireless@vger.kernel.org>; Mon,  7 Feb 2022 21:31:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qccesdkim1;
  t=1644298273; x=1644903073;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=i5c7c/FNQqHHIM52kq0hqXMNB0tNwQ3cwC61hwXyOn4=;
  b=OkJdb+rMcaVJP3l6veJVCRN2A77jkKH6WoolCUtXxBJinmrnMUy6hcgL
   0bLDY6U1ZmQbDAyU6U269jo9769B3GVSC9bYbdh6vtsN/3WdMmC9xfdoY
   8Xc9lGKoVSi1itK66NUTQKvGzB2bWg677XTU8UG/oL+GOqUKM5yX40Vos
   k=;
Received: from mail-dm6nam11lp2170.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.170])
  by ob1.hc3962-90.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2022 05:30:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JTd34aPBqpxGAfGh5Q7+VKGxxITKOYkokAB9UvVpW5QK5jQRrbX5NAcqgceO0AWLl4Ded6sp+qUtSwMpwfR5ArT0HTpZAhXH2CqMAIw7Nw1tuqqfMVs+hoOpzlyFuiKwUuG5bOS/kHO1tDNKVvqUpLxYePiYb0aCljs/sFiPMMzX6tC9PcwOfiw2IGIY89MOxY2TQwdpcCiKoXXj6ILqfomEGVQlCoUb61TvTYym8MKZhbO4LHYLGoYikk+NHtZGJe6cfdYtRTEoPStjdIylR/abGPDIY2n84jeSGzlU0elCswjf25rFhc141hRF5Yeiy/MfzcXl/qWx8Onq8LTlIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i5c7c/FNQqHHIM52kq0hqXMNB0tNwQ3cwC61hwXyOn4=;
 b=R6TzESPfl6Mmayud8nHjGXUIeZBoKynx8hBEIe5EeilQWj2c54ifW37OzX0NjpmopSHjEc9p8IYjDXGyMp23bIYQAwc9B+oMwQMdwrWBEd58h3pMTMHYz0o0K4d0uGgaQ9GETsspqGkV593vsKecpKT10crR3yOI846DODB8RKxHlr3Fsc0vPMro/kgJLAZoLpjtRLDmc9SfqjfjmX+XGqGqEhzBd9N8hQYxNoSZPrstY6cFolnpr/EKhuOKYuNMqi4DOBUG/t8uXN40fnh07OuEbsnuCmgdEL7bpc9CZIP/Khr0KTPDnhUDbbbEUiPLjSq5IcBy9YH2su/ydRT6/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from DM8PR02MB8199.namprd02.prod.outlook.com (2603:10b6:8:3::7) by
 SJ0PR02MB7232.namprd02.prod.outlook.com (2603:10b6:a03:2a2::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4951.12; Tue, 8 Feb 2022 05:30:08 +0000
Received: from DM8PR02MB8199.namprd02.prod.outlook.com
 ([fe80::18c9:6aff:345:5b9a]) by DM8PR02MB8199.namprd02.prod.outlook.com
 ([fe80::18c9:6aff:345:5b9a%4]) with mapi id 15.20.4951.019; Tue, 8 Feb 2022
 05:30:07 +0000
From:   "Seevalamuthu M (QUIC)" <quic_seevalam@quicinc.com>
To:     Kalle Valo <kvalo@kernel.org>,
        "Seevalamuthu M (QUIC)" <quic_seevalam@quicinc.com>
CC:     "ath11k@lists.infradead.org" <ath11k@lists.infradead.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH] ath11k: Add support for dynamic vlan
Thread-Topic: [PATCH] ath11k: Add support for dynamic vlan
Thread-Index: AQHYBdP/UYq0xfuHg0+PEcWlfHVINKxnMTwTgCIc9LA=
Date:   Tue, 8 Feb 2022 05:30:07 +0000
Message-ID: <DM8PR02MB8199EBB0A4ACC6F64F8C92FFF62D9@DM8PR02MB8199.namprd02.prod.outlook.com>
References: <1641786090-10232-1-git-send-email-quic_seevalam@quicinc.com>
 <87bl0asfsp.fsf@kernel.org>
In-Reply-To: <87bl0asfsp.fsf@kernel.org>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=quicinc.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 74eb5d27-fca0-4bc1-5fea-08d9eac41192
x-ms-traffictypediagnostic: SJ0PR02MB7232:EE_
x-ld-processed: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d,ExtAddr
x-microsoft-antispam-prvs: <SJ0PR02MB72327FA92C5FEA957C2058BF8A2D9@SJ0PR02MB7232.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZSFiuDHI5ZrIFzEqHQDpW5wS2LZF8cUTcF1JSqW9wx4ppC4yXqAN7RdHJWC6JqAEj483227EIMtiGnQF5QIHpnQCcbjLR5qMcMbuxqsnA3RqW+8NqGDKOW8+t+kGHA3RDs9KTX+a6PRSdyZ7A4v1ZB3hfbE1qaQ2b3EB6mEZkiOr7pK9S4dKs/ZL+rAcC/549vwg/1Jn8Sd+QEXoemp4NitDCrgGEg7ObosmWQ+jjWyl2NixhhAduX4I+AlTOK3RxQRjDscEVaL1wpN1VA0LIVzCJ2rIToJ94G9YrlQWEk3DJRVqwKrBC6f1HZIqfQfFbTLLgAHSsesiIJiCsMPjRE0tj7PaqjKWjXFrRRW5EATe/ayjL6R1ZriN3T3nZ9ZIkzIYXKIs/ieDTosLiqZ+lM84fxuVx2yCumSBIFsPpNDP7Yorg+xkGVv3fe/CPNc6rf+WwIya9XsyEX2ts459vwXMU5ypoZlfrZTCkolrgs58ap3RvAr7i+Xgbi3qYgbFFdbY8DLoovFahm4U6wYc/i1JvFjvslDEnA6C0IDKbOz0lvXiRkaHQQr9KmvlFohaOjBs+cGdqE/szVNQ0gFr17/YOrzaAv3JS/F1jm/f10UthlLQQWN2KqehJnc+phJwTbkxW5w55SFyE2Vp8HKIDOODk8cdNEtC4Emc9j/pmJ0XdUu6QgWZ+Hp8qBCPcBAu7YH29v5uH6L9pmmFuRRboWP4KjfF2Od0eP+rq4vzLBRaljBqkwPpv0nIm3OpFwLVWEMhFjKDq7G1mTdeOSCijl5N+Milpcuxi3uSDUtdjtk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR02MB8199.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(83380400001)(86362001)(110136005)(316002)(54906003)(71200400001)(7696005)(6506007)(9686003)(53546011)(966005)(186003)(33656002)(66476007)(66446008)(26005)(122000001)(38070700005)(4326008)(508600001)(38100700002)(52536014)(5660300002)(76116006)(64756008)(2906002)(66556008)(66946007)(55016003)(8936002)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?5mdRDTgcZkYpa+0rBirActWQF1QUZPqZoqStHmE9IDmqqGgtqoJJRofRDovh?=
 =?us-ascii?Q?DwGYFz4tXuL5XbPMEoPhyK3p9Zlt8pto8XyrcAwVwKr4hi8u/gAw7qWPmGSz?=
 =?us-ascii?Q?nMZtnghCpFJFd+yoZTs395SlVPtLGqgG6XQhfgen7SZzCa+TF0csfgYhH1Qr?=
 =?us-ascii?Q?Anv8kzwbTpO86QypiZ3RqF6yrjDasbdFXttXGoHxxQFLvYITusgTNQKdlL3B?=
 =?us-ascii?Q?LAehxQzz+Ls5kVTMO6JCFFWMt77696zwXyEWRAOlGbiSgoj52eVtsEkgSj3+?=
 =?us-ascii?Q?HiL0pm5sWeB91uaNQKAD9Xyuph1NCt+GjJlDwdP2/4MCFzpztRdJYasePsrX?=
 =?us-ascii?Q?GPTEC8ivlml961G6faiAR/gkzGQ4BasMSTcbgTTIF3ujSu5rPfguAMtH1anm?=
 =?us-ascii?Q?VwsISJtel1a10V+p8nvZ35jdYdpgSZ+sQxIMurkp44rSK3JORtirAoQ7dQOB?=
 =?us-ascii?Q?/laRO4ZfppxvWpwXzSAKbU2NyWv+U4w5FdqqBRETByH3l6HlC8fqxfr/+fY0?=
 =?us-ascii?Q?zhgIm4o0It/NdNoYe3CiM1gxlCWWLQpPC0YUAixUaiWioRAzykWa2LgtzMQ5?=
 =?us-ascii?Q?NaHxILJPP9u7/TYh+9KYNEyqbYcqF8geu0mj3JA2J0ld/5b/X5bcEnvgLsA2?=
 =?us-ascii?Q?ma08mrdIETBnhWkMV64dRXhLgxNu32crBUma1pFgCspUdV+BYb8Jc3d9VImD?=
 =?us-ascii?Q?zRco5IIS9Eg780FOpm36ZsME83zCIJbGUxc9i9cLur5X6SuPcVLcO0YKVkLQ?=
 =?us-ascii?Q?u7FqtQqBzioIwmEtuv/LJVvZdknj+pwQUkQGvNdS8FHMDNEKUQ5YnnqE6QR9?=
 =?us-ascii?Q?6q+CWtPVIgnWDuG79jDjdk4rhiXSWN2Pzm/VW6NunBFMMG/lKQj3mYsFkyjJ?=
 =?us-ascii?Q?q3CmMbtkjry8mG2WE0+ijLVsyenssN6aQRN5s6vLqLUbJAAHDsVAuEaRkIge?=
 =?us-ascii?Q?IkbIwtm8TlcAYuSZ8GIZ6MdFVqFX8oV96YdFyOjFC0tvVjKnJNuWjD/r51LR?=
 =?us-ascii?Q?/JH/H76XCQA0f2p0RMCfdem2jtOOTHxomzjQ3owcmth7q+UsjIZi/PNfMQIS?=
 =?us-ascii?Q?kSCJonGicosc/IsVwV1YLL8MNfR9oX+6GtgarcRePukaVBo63AT6Ann3jycK?=
 =?us-ascii?Q?CGmmmINnRZnek+SWG+zPQTBEnYYXW8gHkJ4i1yW8ykZqkjRXOPEf0njWBCTF?=
 =?us-ascii?Q?JxD1k0woBIjCRrr3U9loQfh03Y+sow/DtOVT3lIkkxikynddxknEFzBU0nQt?=
 =?us-ascii?Q?g0VOopys/P+BoT013C84YNg3mYS7ynhBJhoaqU9rMMrw07jtE6R+IMhs7VId?=
 =?us-ascii?Q?jKKVue/vmvM4krksCbM1a4baBp71Ktav7eLt/IBKQWBwC5R+NQLYAS7RaNFT?=
 =?us-ascii?Q?DpBY+8EyOwXbs056c4GI5oaFMg7SrbRxcHIOTgRIjRSHEDjUSYEjm91fOdlE?=
 =?us-ascii?Q?FYC3tScU9UK4tmiYeXUbXAooqAXww/FJSCpKa7KUpVSJBPWUCx9znCMMTLe+?=
 =?us-ascii?Q?IDGuT0Ci8UQV2IMpPJlpQ5OyOdaub2QI4Cj6c79G6zpg46plSUJbIrcMdAmT?=
 =?us-ascii?Q?9wYoRWZ9aOl+c4lsNSAueIr8IHzV1HHuxIxI9LDFUrAUJ1nLnqydKl2FtJtE?=
 =?us-ascii?Q?RSCErG/PoYH7c4cHK9FaqznyGddOr+V8jnbylD70w8c1gnAcv9nNNAOIPfeb?=
 =?us-ascii?Q?0BHNLg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR02MB8199.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74eb5d27-fca0-4bc1-5fea-08d9eac41192
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2022 05:30:07.7993
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Fn6e+HAs6esCLfsyfOTOpgiSxWpgipfUFWaanHf5OaxQLDbKcrR+Y/7YG76w61wRuBHyuqT6Ql2INdW1f2OufNXP+1MyfnMKWeODhUY6J9A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB7232
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Kalle,

> -----Original Message-----
> From: Kalle Valo <kvalo@kernel.org>
> Sent: Monday, January 17, 2022 6:03 PM
> To: Seevalamuthu M (QUIC) <quic_seevalam@quicinc.com>
> Cc: ath11k@lists.infradead.org; linux-wireless@vger.kernel.org
> Subject: Re: [PATCH] ath11k: Add support for dynamic vlan
>=20
> Seevalamuthu Mariappan <quic_seevalam@quicinc.com> writes:
>=20
> > Advertise AP-VLAN interface type for vlan support in driver.
> > Metadata information in dp_tx is added to notify firmware that
> > multicast/broadcast packets are encrypted in software.
> >
> > Tested-on: IPQ8074 hw2.0 AHB
> > WLAN.HK.2.5.0.1-01073-QCAHKSWPL_SILICONZ-1
> >
> > Signed-off-by: Seevalamuthu Mariappan <quic_seevalam@quicinc.com>
>=20
> [...]
>=20
> > --- a/drivers/net/wireless/ath/ath11k/dp_tx.c
> > +++ b/drivers/net/wireless/ath/ath11k/dp_tx.c
> > @@ -78,6 +78,44 @@ enum hal_encrypt_type
> ath11k_dp_tx_get_encrypt_type(u32 cipher)
> >  	}
> >  }
> >
> > +#define HTT_META_DATA_ALIGNMENT    0x8
> > +
> > +static int ath11k_dp_metadata_align_skb(struct sk_buff *skb, u8
> > +align_len) {
> > +	if (unlikely(skb_cow_head(skb, align_len)))
> > +		return -ENOMEM;
> > +
> > +	skb_push(skb, align_len);
> > +	memset(skb->data, 0, align_len);
> > +	return 0;
> > +}
>=20
> [...]
>=20
> > @@ -211,15 +250,42 @@ int ath11k_dp_tx(struct ath11k *ar, struct
> ath11k_vif *arvif,
> >  		goto fail_remove_idr;
> >  	}
> >
> > +	/* Add metadata for sw encrypted vlan group traffic */
> > +	if (!test_bit(ATH11K_FLAG_HW_CRYPTO_DISABLED, &ar->ab-
> >dev_flags) &&
> > +	    !(info->flags & IEEE80211_TX_CTL_HW_80211_ENCAP) &&
> > +	    !info->control.hw_key &&
> > +	    ieee80211_has_protected(hdr->frame_control)) {
> > +		/* HW requirement is that metadata should always point to a
> > +		 * 8-byte aligned address. So we add alignment pad to start
> of
> > +		 * buffer. HTT Metadata should be ensured to be multiple of
> 8-bytes
> > +		 *  to get 8-byte aligned start address along with align_pad
> added
> > +		 */
> > +		align_pad =3D ((unsigned long)skb->data) &
> (HTT_META_DATA_ALIGNMENT - 1);
> > +		ret =3D ath11k_dp_metadata_align_skb(skb, align_pad);
> > +		if (unlikely(ret))
> > +			goto fail_remove_idr;
>=20
> If you push the skb like that shouldn't you also reserve the room for it =
in
> struct ieee80211_hw::extra_tx_headroom?

[seevalam] : already this is handled using skb_cow_head() in ath11k_dp_meta=
data_align_skb(). Please correct me if I misunderstood your point.

>=20
> --
> https://patchwork.kernel.org/project/linux-wireless/list/
>=20
> https://wireless.wiki.kernel.org/en/developers/documentation/submittingp
> atches

Regards,
Seevalamuthu M
