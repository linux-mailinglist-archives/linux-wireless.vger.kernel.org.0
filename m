Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 54DF41724F1
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Feb 2020 18:23:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729904AbgB0RXh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 27 Feb 2020 12:23:37 -0500
Received: from mail-eopbgr150095.outbound.protection.outlook.com ([40.107.15.95]:31206
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729863AbgB0RXh (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 27 Feb 2020 12:23:37 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S407Lksk0s4T7W9R/eKQAZ/UNRgGFmj3GE9q5zW/3buF0yRofJtetdxTb5kMzzMPvsZiHHUEjmejmmFxOwzAwXm8xu1ZQ1bueykW0iAl68p+/qzqOqHMt1hJcJUEA4vUaDyqgenY/Zq+hpyUxtTj1xr609gvjQWQXo6S26B8FX7daPt+32q9UaQsudWKEpTOeArlA2lWITp5Gp1JOSPY1BrF+yUzDp36VkYqqh5k4uZO7Z6bLyq5h6Ljrms4Vpz0wlhT+UqhYIMZyId81BETHvdR2Chy/nsl7/xcuWi7ct87JBUeu83javDpUzL1fNdMdXZTWDDx9WZ3g+nwxRvbaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q66wlrLCp7oHRnpMDRtYWAkjAcJzxa0EcB4tBJJUVIY=;
 b=ZKsOeUPmBDpf/cdxwM3ksfX03BmmYDq8dKBiRwse+5kX9IHndTHFW5APUFax+fzCk01+NIH71cJY9iUruzL4v1MBt3jUnmvCDMXBs0ZUqlb2nUXS6IjLByRE7P6hTIa9lwcjNX6JhIhJX37YX9dMOHlm69m8OtfzHvELUi9w/25+LwITzG4podUzFQLVfg76u9XJHGnco024np6GXv8DukNwPYU3yLDtjouh0SB7Vl+qYXIxNSN2IiX8vXdW5nt1qGjH1vzQNOKMnAB39aFw4xyn8SPPIpLa6JiU1M+M4nKFhkyS1A0m1oO6lWe0I0kWDEFNcqvOdl+M9Hp4l5BXlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=acksys.fr; dmarc=pass action=none header.from=acksys.fr;
 dkim=pass header.d=acksys.fr; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ACKSYS.onmicrosoft.com; s=selector2-ACKSYS-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q66wlrLCp7oHRnpMDRtYWAkjAcJzxa0EcB4tBJJUVIY=;
 b=X8HXIbFHyTKJWRXlzBP+Bm4RJisfDgvd9Ec+HRfhY4t9zSYOheytjUMlxOX1EHNeO2LKMsFHCAZ4cs5VfirX+faACnD5dL8nsBN2f75VVMVNwrfTGx6h7AYmyMdQg7YXLcufE6umwC/iFuPBB0LVLS9qRGM+tg3XK9CiXKRG1Fc=
Received: from DB8PR01MB5529.eurprd01.prod.exchangelabs.com (10.255.170.96) by
 DB8PR01MB6325.eurprd01.prod.exchangelabs.com (20.180.3.83) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.15; Thu, 27 Feb 2020 17:23:33 +0000
Received: from DB8PR01MB5529.eurprd01.prod.exchangelabs.com
 ([fe80::8182:86f9:16d5:e18c]) by DB8PR01MB5529.eurprd01.prod.exchangelabs.com
 ([fe80::8182:86f9:16d5:e18c%7]) with mapi id 15.20.2750.021; Thu, 27 Feb 2020
 17:23:33 +0000
From:   Cedric VONCKEN <cedric.voncken@acksys.fr>
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [mac80211]: wds link and Radius authentication issue
Thread-Topic: [mac80211]: wds link and Radius authentication issue
Thread-Index: AdXth2dk69/BCqj0R+ekTWaEqaibqgACfSLg
Date:   Thu, 27 Feb 2020 17:23:33 +0000
Message-ID: <DB8PR01MB55290E6894E532ABA3748A5590EB0@DB8PR01MB5529.eurprd01.prod.exchangelabs.com>
References: <DB8PR01MB5529DDE77726C997EAAC3F3C90EB0@DB8PR01MB5529.eurprd01.prod.exchangelabs.com>
In-Reply-To: <DB8PR01MB5529DDE77726C997EAAC3F3C90EB0@DB8PR01MB5529.eurprd01.prod.exchangelabs.com>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=cedric.voncken@acksys.fr; 
x-originating-ip: [81.255.64.235]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 30cd0df0-2f43-48c9-3406-08d7bba9c59d
x-ms-traffictypediagnostic: DB8PR01MB6325:
x-microsoft-antispam-prvs: <DB8PR01MB6325D199E470DAF79043D21B90EB0@DB8PR01MB6325.eurprd01.prod.exchangelabs.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 03264AEA72
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39830400003)(396003)(346002)(376002)(42606007)(366004)(136003)(189003)(199004)(316002)(86362001)(186003)(26005)(71200400001)(66446008)(66576008)(66556008)(66476007)(66946007)(64756008)(76116006)(5660300002)(52536014)(7696005)(6506007)(33656002)(66574012)(8936002)(81166006)(8676002)(81156014)(508600001)(2906002)(55016002)(9686003)(6916009)(2940100002)(309714004);DIR:OUT;SFP:1102;SCL:1;SRVR:DB8PR01MB6325;H:DB8PR01MB5529.eurprd01.prod.exchangelabs.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: acksys.fr does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: x6KWAtFZVOaSBcom1QvK+ztgo+YoMRqatnCS5lbB+tmsRjPz5MhxK21+PNAwZSOFkPu1bEQpEFS6yDeyUxGeTNBz8IvF3aHpndiagSJC4AdhV39LFRP2HEhK851j33LHfIRaYelenpqSubf4SIDfQkMgZpCGcyoOtRghVI9XkLv9SoXG4vYVLHK8vn7TQ237iiBymM9GEnNJ/B7I52g/qGh8qQp1Mze2hLX6/PVOl+YqfJ5AKm2c9tMkwW+rHH4wo4GLVYCXXuIZfLzlBwzHLWayWK/pjQMDH0MZqCgdXYMedvTRMIWyfUndOmB9cPGagTxDh9PPmle51rstEF89uLs/jO99OvUA1Wkkc3a8/aFOb11Sm56QozHDksafnNwap/Ku3+expxI7j6jxmmJLrTMAtWClQFLNaq/SkcXE9vaVzgKDdp+nlfSbJg1/Vy4MtYWCksPtFH3NxdS2h7wCuaeMj2tW+pv9XDoVuKG2F5o5YVlLnKaNQGkMVrBQ/0qH
x-ms-exchange-antispam-messagedata: egtLu9AdnM9gWjbG/Ea3ljenqxsl6F8zaIBl9qIb9TW5FCizrEaJzDbA8QDgkY4GA7gmLkEh0X7jckMNYQu6V9E1RnQ+oT1cG7Vl9WUlyahBxObTa6mn1PZJAbvuhFUd1EQKonwPUG9AQ04arUGu6Q==
x-ms-exchange-transport-forked: True
Content-Type: multipart/mixed;
        boundary="_003_DB8PR01MB55290E6894E532ABA3748A5590EB0DB8PR01MB5529eurp_"
MIME-Version: 1.0
X-OriginatorOrg: acksys.fr
X-MS-Exchange-CrossTenant-Network-Message-Id: 30cd0df0-2f43-48c9-3406-08d7bba9c59d
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2020 17:23:33.4556
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f18a6414-d5f3-4b5c-9345-f30c01d87e32
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NnJYcpqCMIDfuLbEPmf/SYTi4p8vAn3jtRUjBWVlJhHnNoc6KxzNjGuSWR9YdH6GXHq4mOJSUUJ/CLIvERanaCoiTs0P1w3uDiYeg6X/YDU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR01MB6325
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

--_003_DB8PR01MB55290E6894E532ABA3748A5590EB0DB8PR01MB5529eurp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

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
De=A0: Cedric VONCKEN <cedric.voncken@acksys.fr>=20
Envoy=E9=A0: jeudi 27 f=E9vrier 2020 17:21
=C0=A0: Cedric VONCKEN <cedric.voncken@acksys.fr>; linux-wireless@vger.kern=
el.org
Objet=A0: [mac80211]: wds link and Radius authentication issue

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









--_003_DB8PR01MB55290E6894E532ABA3748A5590EB0DB8PR01MB5529eurp_
Content-Type: application/octet-stream; name="broadcast_V5.4-rc8-1.pcapng"
Content-Description: broadcast_V5.4-rc8-1.pcapng
Content-Disposition: attachment; filename="broadcast_V5.4-rc8-1.pcapng";
	size=2608; creation-date="Thu, 27 Feb 2020 15:17:41 GMT";
	modification-date="Thu, 27 Feb 2020 15:17:41 GMT"
Content-Transfer-Encoding: base64

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

--_003_DB8PR01MB55290E6894E532ABA3748A5590EB0DB8PR01MB5529eurp_
Content-Type: application/octet-stream; name="broadcast_V2015-07-21.pcapng"
Content-Description: broadcast_V2015-07-21.pcapng
Content-Disposition: attachment; filename="broadcast_V2015-07-21.pcapng";
	size=4508; creation-date="Thu, 27 Feb 2020 17:12:51 GMT";
	modification-date="Thu, 27 Feb 2020 17:12:51 GMT"
Content-Transfer-Encoding: base64

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
AGwAAAA=

--_003_DB8PR01MB55290E6894E532ABA3748A5590EB0DB8PR01MB5529eurp_--
