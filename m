Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C5A317231F
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Feb 2020 17:22:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729754AbgB0QVS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 27 Feb 2020 11:21:18 -0500
Received: from mail-eopbgr40091.outbound.protection.outlook.com ([40.107.4.91]:17584
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728963AbgB0QVS (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 27 Feb 2020 11:21:18 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LiLQyPANSZDgDfL0uIrGE1DSooAk2j31KTcHHTaSPZExfaPm3dLwKDePy6ov10JBuuUy8njW/pnwedcxL7Z1kSXqpTRA7MXuze7fhVIaS2KRv7rQPiHEwB4N4ZhOK5nnHGDfqMsY4x7a45fXo9DGZ/TVhL9VP6A96Bz/gx7TNOad3lJMVSVNzXJRJN+Nk153k36p3Ods0op815iVQhzyF4tqwntHMNZn0yNdj5KuLBLT7hEDrNB9SR8nsi6QXzHAbW1hUTIVXh4lv3DhrtRy6bcL221Jgm9LPQOcScJwCAOlMOlNpN1D0+mwIfN92pK11Qh/UfUl0hVUcxJbbf7dGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZSA1ek+fn8OyF0C3+VnZ/v5LanXW92g6cJI8nUWneic=;
 b=b1mg9V1eZI6rsEXJtXsmRcwEZIrx+9vVjkMOf3mG8IpXrJx8VbucJPrPs3rvugLTr4u19nh6jxL+F2OOHcgiET6Y5wTb4GurqSvUX5dyuu41T6NyuXcGRc1HUS4NG30iPtxPFqQL/amCAS6DpzcPuKhHs/6/DDBl9xvPWY77V53OfxdBvG/3q6WwL2LHQUh58jhFrJefUpSu30hiz4l+jEZC+bX7dOIKTWhEQvvI5PeTFWLLHPQ0tkiNJpB6iRd/r8kLxaMS3zCCG9b7PFtjdDXHEC65vL08ixlNEnFZNJDAENA2AuADbF3w0qbyJD6wczPTbfhm6rxr7BXMZ/PHEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=acksys.fr; dmarc=pass action=none header.from=acksys.fr;
 dkim=pass header.d=acksys.fr; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ACKSYS.onmicrosoft.com; s=selector2-ACKSYS-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZSA1ek+fn8OyF0C3+VnZ/v5LanXW92g6cJI8nUWneic=;
 b=uP6cWfy7zZFlW9wE0r+fb0DQp7xBizY3cu53+Y/czWQT/sXIsEFblaaYbZnRZ/VGUG5tCB2pxmYvZfh6Rwj2oQnxFiCF9YjSdhuhXuMR5ZMivOhEbf4cMkGCLF9KFgQ0mg0nQ7GfgXU5m1qkpaGganX9N7ZI+4+qdjan1KhDVgc=
Received: from DB8PR01MB5529.eurprd01.prod.exchangelabs.com (10.255.170.96) by
 DB8PR01MB5659.eurprd01.prod.exchangelabs.com (20.179.251.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.14; Thu, 27 Feb 2020 16:21:14 +0000
Received: from DB8PR01MB5529.eurprd01.prod.exchangelabs.com
 ([fe80::8182:86f9:16d5:e18c]) by DB8PR01MB5529.eurprd01.prod.exchangelabs.com
 ([fe80::8182:86f9:16d5:e18c%7]) with mapi id 15.20.2750.021; Thu, 27 Feb 2020
 16:21:14 +0000
From:   Cedric VONCKEN <cedric.voncken@acksys.fr>
To:     Cedric VONCKEN <cedric.voncken@acksys.fr>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: [mac80211]: wds link and Radius authentication issue
Thread-Topic: [mac80211]: wds link and Radius authentication issue
Thread-Index: AdXth2dk69/BCqj0R+ekTWaEqaibqg==
Date:   Thu, 27 Feb 2020 16:21:14 +0000
Message-ID: <DB8PR01MB5529DDE77726C997EAAC3F3C90EB0@DB8PR01MB5529.eurprd01.prod.exchangelabs.com>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=cedric.voncken@acksys.fr; 
x-originating-ip: [81.255.64.235]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8b677413-327a-49d5-3164-08d7bba11121
x-ms-traffictypediagnostic: DB8PR01MB5659:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR01MB5659BDAD133621604A0BE9B490EB0@DB8PR01MB5659.eurprd01.prod.exchangelabs.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 03264AEA72
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(366004)(42606007)(39830400003)(396003)(136003)(189003)(199004)(66574012)(2906002)(76116006)(66946007)(33656002)(66446008)(86362001)(7696005)(64756008)(66556008)(316002)(66476007)(52536014)(81156014)(71200400001)(186003)(8676002)(478600001)(110136005)(26005)(6506007)(8936002)(55016002)(81166006)(9686003)(5660300002)(309714004);DIR:OUT;SFP:1102;SCL:1;SRVR:DB8PR01MB5659;H:DB8PR01MB5529.eurprd01.prod.exchangelabs.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: acksys.fr does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8g4I9nJgnoNFiEAG8l4lFunCjMTQE8giMj1ct9MUJQEeO1d5kdbXoKpdrMR2ZzszviEWZeUNOMN7mkuwdNPApc3y8xS03ORbszACcTiloa2WIyJf3QwuyPCjx2redN4QxEdN80zqeoiP62gcHf5hfGbjf4erZ4J1E6xni6xmgxll+xvfk9V0tY08bhVmLV7g1iOaJPpj8r7ePkiG+scSWVl2XaxIKBl1/j1+9q2j5yo9K2FOmz6MRQygdWFuxvTAqhZwAHy5dCcxZ5jLK56/xOAPzJB5aLz4GjnfuOHsfpDe4c0UbV7JxneJjCHiHsdYRuVu9sjlT7+CydBz7i/XtupZbwZhKzXR1MQbMoVPWQYsnfUZDnQ+pPuSj7QHYLd1/YjhL+E8D/3eX+XnV4tss1hrT9QoYBS48FiLmYyno9SXJTwGmtB3XYdTTerAxhg+A+htvfNeVgJQqId6okzvfvKnuQ2sWL64kzQXBLrM9Zn1IGIDt4R7uTIAE1iCz2Qd
x-ms-exchange-antispam-messagedata: ksP1F0QnOYilYYmm/ze9afIIhzBxJ13SKzyEt4kE5H7cLnkFH+4plq78uzY/2tGIGPyDK9OYdx1KEMsP6KA+tvjvty9ahyfZzpONo6bqFeRbSk+DTJoZ28i+IXEogFZX6joFJQ1zsRxdvoO8V272ZQ==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: acksys.fr
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b677413-327a-49d5-3164-08d7bba11121
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2020 16:21:14.6192
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f18a6414-d5f3-4b5c-9345-f30c01d87e32
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pZgIdZJ+0zusGL0mK76UnuP4eqzrtMAtVRtCiaHgbmVxZz9DKeiGd3wwuanerpj/ye6SZLljXQoVvEXDMCQCy3bYUPFiiODKM3q6I4UkE4s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR01MB5659
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

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
el.org> De la part de Cedric VONCKEN
Envoy=E9=A0: mercredi 26 f=E9vrier 2020 11:29
=C0=A0: linux-wireless@vger.kernel.org
Objet=A0: wds link and Radius authentication issue

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








