Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C49B2172539
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Feb 2020 18:37:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729678AbgB0Rh3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 27 Feb 2020 12:37:29 -0500
Received: from mail-eopbgr150108.outbound.protection.outlook.com ([40.107.15.108]:50340
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729232AbgB0Rh3 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 27 Feb 2020 12:37:29 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CWvJMagbh7wLTqv0lHeli1g4zLS2tUDHSdv/NMmc8GXDqRNqiPYDrPS97RInzrzXA/dlenK3MQuWy6F7JpDQ4woxLUfOx7jgQSSUv/7Hx8iQ7bF44NJtU7BeGg5DUxv6HbIlxxJwvEFAmH49wnx2Nz06mqAR9BdTPc8J4nBspTwhgXNkiCQNLj8bGxjDy5tJ/tfe9wnRD0Qx7vSGqu0SrYWaCEkLC+esRqFWsFAlDfDYlQYmx1pKYspuqsWGRUYyn/hwck4++yVAI/+zpDP72FkZTwvCSS5VuY/dWQF4CRVXH4yZJqg3EjIFmG0JFOzx6WkCXH/IDHbyEFDplj6xHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZK1gHHcMU1hcWblZK/haCtsQh9g/rOSMs38vWnM/LKY=;
 b=FbbUgQVFpt48uYE+Nh2mjx9II6aOCSLq8Yj6FCwFRP2vC5Qb8PFDl+YJohO/0jDw5gWqu3TAcdUEClSff3N6qpUwfW0mXJ4TerB/pkZfuPAId5v9X5Q6vcxv57d86zelr1i3fJNuFgD3BKZkHcVXvEWUw0VH9tEc4sbZ69akyRddy2rXqLLejxnSZigt5lxbNk/axjYKlaAyDey0k6c1VMOfjNrV+APPrH2uaF7h/ZoJXx7K78xi6yPCWjv8kLtl0lNyW/0d1nqgDSva65SCWrcGvRZn6CeDT6zSKbijDJo7iJ1RnsH5/YsLznkFt0lRdTPGTrJ5hxo6EFjB/I2s2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=acksys.fr; dmarc=pass action=none header.from=acksys.fr;
 dkim=pass header.d=acksys.fr; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ACKSYS.onmicrosoft.com; s=selector2-ACKSYS-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZK1gHHcMU1hcWblZK/haCtsQh9g/rOSMs38vWnM/LKY=;
 b=NukhTzKzKnWCJ+C8sgwPcE7eqvOnB+S4flHHnrstK6Jrkn1UnNnupxYXetr5m43mVLKpSFp1cwcs4x2Ryxuo50wwck785YGaA/YkoFu6k0VKxqklpwqzor/H/1jcU+uTu/OaJF5uUaTPomMn9QjoEEKzPHNCAPOCaQTu8SnLhFA=
Received: from DB8PR01MB5529.eurprd01.prod.exchangelabs.com (10.255.170.96) by
 DB8PR01MB6423.eurprd01.prod.exchangelabs.com (20.180.1.209) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.21; Thu, 27 Feb 2020 17:37:24 +0000
Received: from DB8PR01MB5529.eurprd01.prod.exchangelabs.com
 ([fe80::8182:86f9:16d5:e18c]) by DB8PR01MB5529.eurprd01.prod.exchangelabs.com
 ([fe80::8182:86f9:16d5:e18c%7]) with mapi id 15.20.2750.021; Thu, 27 Feb 2020
 17:37:24 +0000
From:   Cedric VONCKEN <cedric.voncken@acksys.fr>
To:     Cedric VONCKEN <cedric.voncken@acksys.fr>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [mac80211]: wds link and Radius authentication issue
Thread-Topic: [mac80211]: wds link and Radius authentication issue
Thread-Index: AdXth2dk69/BCqj0R+ekTWaEqaibqgACfSLgAAC+e3A=
Date:   Thu, 27 Feb 2020 17:37:24 +0000
Message-ID: <DB8PR01MB5529D69C90706C78D3B66BA490EB0@DB8PR01MB5529.eurprd01.prod.exchangelabs.com>
References: <DB8PR01MB5529DDE77726C997EAAC3F3C90EB0@DB8PR01MB5529.eurprd01.prod.exchangelabs.com>
 <DB8PR01MB55290E6894E532ABA3748A5590EB0@DB8PR01MB5529.eurprd01.prod.exchangelabs.com>
In-Reply-To: <DB8PR01MB55290E6894E532ABA3748A5590EB0@DB8PR01MB5529.eurprd01.prod.exchangelabs.com>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=cedric.voncken@acksys.fr; 
x-originating-ip: [81.255.64.235]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9ad1adf6-57c3-42d9-a4d5-08d7bbabb4d8
x-ms-traffictypediagnostic: DB8PR01MB6423:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR01MB642325B19EFEF5B7A13AC0A790EB0@DB8PR01MB6423.eurprd01.prod.exchangelabs.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 03264AEA72
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39830400003)(346002)(366004)(396003)(376002)(136003)(42606007)(189003)(199004)(86362001)(52536014)(8936002)(71200400001)(66574012)(5660300002)(8676002)(81166006)(81156014)(7696005)(6506007)(9686003)(55016002)(2906002)(316002)(66556008)(2940100002)(186003)(76116006)(66946007)(66446008)(64756008)(66476007)(110136005)(26005)(33656002)(478600001)(309714004);DIR:OUT;SFP:1102;SCL:1;SRVR:DB8PR01MB6423;H:DB8PR01MB5529.eurprd01.prod.exchangelabs.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: acksys.fr does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UMfmnsis1pxjT3dq2teKWs3QXlAPMJD+XL+N5KM51U0wq6iWnDo266i6yX54BhVhU84VRaqbYsvwm9pFjcSqAJtU9F+0whY8uKDy1mFGAt1+yuPuvj8Y2l79ROPzh84aw4Q0Da+MzwKP8yS73f6TWGNdizSoJAw8uZs/DFSmw3hUCzFk8wJM4RTW5jW3xvMRpSJH/3AEdAE5PU1opPbSiA16SieCf9rDcy0LvOGHrWljbNiwPHi/oqD3C4DwmRCUjFntxXiPzWXw53bMyf9JdCFGSoO5CRdEZGao4KWH+/n/T1XsJ/bjJZziZOjnfzQ5+hdHGUP3qFdehLCQOMzPQF9bDuU1DGvo3usT8fLjcNrAVLO350Ls1yhxWNmmsJ1Q3lHQPAHYEQ2cEdLif3ygxuz3q0EoZ4xcR4E0pAt4dJ2ouoU2Tc22bi9ccAx17HELMf7VaiPFkYN3z6W/n86yeQV1Srl9snm7EUZRCQ7y5gnhMaSD02MPBt/UIwp1O5G4
x-ms-exchange-antispam-messagedata: pBkC4z1Hr7OFNJY8q9Evb+1weBru0R1neDGhFpCkouLCVsEcI9isGxjG0WaqR1jO8em9AOz2Mto69HxmTlOySDRIhy/w/XsO2isjexwKff807ZtPVjJVVh8tp/pRKrEu/lwRfjJ03I2nf4nwSVjuAQ==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: acksys.fr
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ad1adf6-57c3-42d9-a4d5-08d7bbabb4d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2020 17:37:24.3053
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f18a6414-d5f3-4b5c-9345-f30c01d87e32
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iFLsPeJfe7pfhgXQHqmzE5VKwfmdZFevofDtfPvebsJ9S+Kd5IThzNr2Z5Aj3psz+P3Y+NcmHBqzx7LP3+ZIHBhg7KXsWQLB1icEQUyLr6E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR01MB6423
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Where can I found some information on how the wds system should work? I loo=
ked in 802.11-2012 standard and I didn't found any informations.

-----Message d'origine-----
De=A0: linux-wireless-owner@vger.kernel.org <linux-wireless-owner@vger.kern=
el.org> De la part de Cedric VONCKEN
Envoy=E9=A0: jeudi 27 f=E9vrier 2020 18:24
=C0=A0: linux-wireless@vger.kernel.org
Objet=A0: RE: [mac80211]: wds link and Radius authentication issue

	Please find in attachment 2 wireshark capture

	The file broadcast_V5.4-rc8-1 contain a broadcast frame capture with the l=
atest backport used in my system.
	The file broadcast_V2015-07-21 contain a broadcast frame capture with an o=
ld backport (backport 2015-07-21).

	With the old backport I be able to ping my sta from the AP.

	If we compare the frame
		- In the old backport the bit TODS and FROMDS are set to 1, In latest ver=
sion only the bit FROMDS is set to 1.
		- In old backport the addr1 is set to the mac address of my sta, in lates=
t backport the addr1 is set to broadcast addr (ff:ff:ff:ff:ff:ff)

	In old version the same test doesn't drop the broadcast frame, but I think=
 the AP should send one broadcast per wds sta.

	All comment will be appreciated.

-----Message d'origine-----
De=A0: Cedric VONCKEN <cedric.voncken@acksys.fr> Envoy=E9=A0: jeudi 27 f=E9=
vrier 2020 17:21 =C0=A0: Cedric VONCKEN <cedric.voncken@acksys.fr>; linux-w=
ireless@vger.kernel.org Objet=A0: [mac80211]: wds link and Radius authentic=
ation issue

	 Hi,=20

	Now I identified the origin of the issue but  I need some help to fix.

	For memo the condition to have this issue:
		My sta is still connected to my AP. The sta use the 4addr (wds) system an=
d the sta if device (wlan0) is bridged with my eth0 interface.
		In this condition I'm not able to ping the sta from the AP.

	The origin of the issue is in rx.c from driver/net/mac80211. In function _=
_ieee80211_data_to_8023
	if (sdata->vif.type =3D=3D NL80211_IFTYPE_STATION &&
	     !!sdata->u.mgd.use_4addr !=3D !!ieee80211_has_a4(hdr->frame_control))=
 {
		if (!sdata->u.mgd.use_4addr)
			return -1;
		else if (!ether_addr_equal(hdr->addr1, sdata->vif.addr)){   ------> this =
test is the origin of my issue
			check_port_control =3D true;
    	}

	The ARP frame are sent in broadcast. The broadcast are sent without addr4 =
(the flag TODS and FROMDS are not set) and addr1 =3D=3D ff:ff:ff:ff:ff:ff.
	In this case check_port_control is set to true and several line below in t=
he same function the packet is dropped.

	I can add a test with  is_broadcast_ether_addr in "else if (!ether_addr_eq=
ual(hdr->addr1, sdata->vif.addr)){", but I'm not sure that is the best solu=
tion.=20

	What are your comments?

	Regards.
-----Message d'origine-----
De=A0: linux-wireless-owner@vger.kernel.org <linux-wireless-owner@vger.kern=
el.org> De la part de Cedric VONCKEN Envoy=E9=A0: mercredi 26 f=E9vrier 202=
0 11:29 =C0=A0: linux-wireless@vger.kernel.org Objet=A0: wds link and Radiu=
s authentication issue

	Dear mailing list,=20

	I'm facing an issue when my equipement are configured with WDS and radius =
authentication.

	My both product (the AP and the sta) are using the same hostapd/wpa_suppli=
cant and wifi driver version.
	The wifi driver version is openwrt backport-5.4-rc8-1 package.

	My AP is configured to accept the WDS sta. In the AP side the ifname wlan0=
.sta1 are created and added in the bridge.
	My sta is configured to use the WDS addresses.

	If the security policy is configured to WPA-PSK and in the client side the=
 client if is added to the bridge, the communication work (I can ping my AP=
 from my sta).
	If the security policy is configured to WPA-EAP (I tested PEAP-MSCHAPV2 an=
d EAP-TLS) and the client if is in a bridge, the communication doesn't work=
.

	I did a Wireshark capture on other WIFI interface, the packet seem sent by=
 the AP and by the sta (I can see a broadcast frame sent, and the packet ty=
pe is data. I think it is the arp request). But these frames are not receiv=
ed (I make a wireshar capture on the sta and AP if, no arp frame are receiv=
ed).

	I don't know where I need to search to fix this issue. Could you give me s=
ome pointer/help to fix it.

	Thanks for your help.








