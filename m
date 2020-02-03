Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 11868150A26
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Feb 2020 16:47:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727783AbgBCPrR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 3 Feb 2020 10:47:17 -0500
Received: from mail-eopbgr60112.outbound.protection.outlook.com ([40.107.6.112]:30950
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727296AbgBCPrR (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 3 Feb 2020 10:47:17 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R4Ogyp3mlw8IaTEZAVnXNj1E8mi0l6jh3X+ysy8ZjzIjIKW6E1dkunRLP68zMUPY8zt28oiAQZsQ0wzjP9XxchTs7EUYsDQU76HcrinXnnH6F9KdwC1u0q41M7tEEIeIpjNd0fVUvWvTNIUU95/Hwhs2cTRWaZJSzaSiEpBNxfasdxrFB9Wx2V35ks2vhXUN16wnQOPK3sVGscFd1oZ3vzeLCoD4v0jCEfFVsxjkzsLj+56NXeQ+kWjuvPh+IzM03jFCtCEuFkLSxmULr0pGdN430DtswCvhMwMCF8p/3m57aJqW3t3jt3BgVRsIOfqnjpth0I5FNPlYToWLQ7bvmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=of3nnXcwG5cVZNPAa515z2lkHTpXfGqS7IvAJzG1Vl4=;
 b=cKKWawmMqL70n5OYjKnpqP6hQU14mf1NcPQebwj/op1NrnSU3PSDCZZBqx6CQ8SDCkyENKe6h27CAdzjvloA1+I5oRkbxz9HG3YvV47rJpV88JY0qR+xLCaPSnTRKIzGbWPsOYiMiCB8cO5M2pL0KhO8aCtH8QmtZ2D/qFAGozybfG7r68U4CJE1q9ZdJ/5v05gIJBpO9QC9NlnLiEtPRBmRJ4FWCdyyeVJbGe3ZAluWvBj+69XKyekvq7qi65KdIrdI9sTiHBXC2hWnm67sjmv+6zpu6KpstpE5cc6KRph9BLIPyGGu81Y8zYXRoX98gkjLyG9zaYiYSzbRQDlbUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=acksys.fr; dmarc=pass action=none header.from=acksys.fr;
 dkim=pass header.d=acksys.fr; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ACKSYS.onmicrosoft.com; s=selector2-ACKSYS-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=of3nnXcwG5cVZNPAa515z2lkHTpXfGqS7IvAJzG1Vl4=;
 b=LdVHSbe6O/Jyuz78q6l8xyC0ATFBqPd4ib0/Hz+gJJEmi/zdZe5IP8Pa7nD8y1/husatXsE6sd/JO6XiC9X7ozNGOk+W9GJcoL068yqm0/f/DwA3uoLIffOvSdgLTEvSNzkQLCxeYBGQqDbxWJrr+1Z7rStKjjYjJloIsDVdc5g=
Received: from DB8PR01MB5529.eurprd01.prod.exchangelabs.com (10.255.170.96) by
 DB8PR01MB5884.eurprd01.prod.exchangelabs.com (10.255.18.218) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.27; Mon, 3 Feb 2020 15:47:14 +0000
Received: from DB8PR01MB5529.eurprd01.prod.exchangelabs.com
 ([fe80::8182:86f9:16d5:e18c]) by DB8PR01MB5529.eurprd01.prod.exchangelabs.com
 ([fe80::8182:86f9:16d5:e18c%7]) with mapi id 15.20.2686.031; Mon, 3 Feb 2020
 15:47:14 +0000
From:   Cedric VONCKEN <cedric.voncken@acksys.fr>
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: mac80211: background scan issue
Thread-Topic: mac80211: background scan issue
Thread-Index: AdXap38Z9r3VzHvRQzOI17lJbtE2+A==
Date:   Mon, 3 Feb 2020 15:47:13 +0000
Message-ID: <DB8PR01MB5529FBFD07C989F0E934CDD990000@DB8PR01MB5529.eurprd01.prod.exchangelabs.com>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=cedric.voncken@acksys.fr; 
x-originating-ip: [81.255.64.235]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9067b5c9-a952-4ed6-76da-08d7a8c056f7
x-ms-traffictypediagnostic: DB8PR01MB5884:
x-microsoft-antispam-prvs: <DB8PR01MB5884010ED4F417399405B5EE90000@DB8PR01MB5884.eurprd01.prod.exchangelabs.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0302D4F392
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(136003)(42606007)(376002)(346002)(39830400003)(199004)(189003)(55016002)(9686003)(6506007)(2906002)(33656002)(316002)(52536014)(7696005)(86362001)(6916009)(71200400001)(5660300002)(186003)(81156014)(81166006)(76116006)(66946007)(8676002)(8936002)(66556008)(508600001)(66446008)(26005)(64756008)(66476007);DIR:OUT;SFP:1102;SCL:1;SRVR:DB8PR01MB5884;H:DB8PR01MB5529.eurprd01.prod.exchangelabs.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: acksys.fr does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yECBh4pAoqpFTIMnhKtKOcLwQQV4F5YyJycKIcukougHBwYiHhclZ02DM2lrzzwoiDynej8PtGFwSl98md6VDmGmn43hw8mAL5wVt9dqVjEFFjMzypQwE6hnoj0lLOuUInxCz8ZGhQV8X1wDVmxb3Xdjp9fLVBhwuWtBDLvmWa7hmmFDXS8+PgjDM8VJ0GZ5jt1bxwP4kA74hKIvzoIdFK01lMFoRjjiaf6aNnunUhCFY3A0e1VgNuC8pt4TKKVnIdmfern8hWu4Cj3hj+3C63mlji+37NDkwykLPEaRBw3WXR3wlzGAQuwYqRatO9YaOvN7xOK1eXLz7G94BREQ6+MT6k83UZAq9Op2N2xgoWoWuBqATgXWz4wMb+4PEdEkVFkVavXD6wF3OuiuQ3CKhQTySDGf26IvuNe9vBJHAkDUGz25Zsa52FgxTT4UeYGn
x-ms-exchange-antispam-messagedata: 9XSR9D6PftxVORPcwzSzoB2tvUkuQXKBZlq9PDh1dSK4oXZm1mpGC3sC/RSQY6Pn+tMFJZP02PZ9YFYgBDjk6XKyrANBw5TYOdyhNS4cJndaZS8Q1hIh6GjfeV8ZTA9psHMhhf6VUMYuVwAlb9mX/w==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: acksys.fr
X-MS-Exchange-CrossTenant-Network-Message-Id: 9067b5c9-a952-4ed6-76da-08d7a8c056f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2020 15:47:14.0541
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f18a6414-d5f3-4b5c-9345-f30c01d87e32
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BfIGceCy7gaBGqtuOKwAMdia/EYKcngrny2d/66OI1iydxhvO0izFbLYv25g/M/jMohr0AdC/kGpBf5FEBPEEjHR4K/9bLWlD3ZbX425TUU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR01MB5884
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

	I'm working on background scan algorithm.

	In backport 5.4-rc8-1 from openwrt I found an issue on background scan in =
mac80211.

	In background scan we must send a power save indication to the AP to avoid=
 packets lost during the scan. The previous version of  mac80211 (a very ol=
d version) used a null function to send the power save status to the AP.
	In this backport (5.4-rc8-1) this null function was replaced by QOS null f=
unction, and this frame is never sent when the power save bit is set to 1.

	I found the origin of this issue and she still present in the latest versi=
on of mac80211.

	In the function ieee80211_tx_h_check_assoc from net/mac80211/tx.c a test i=
s wrong. Please find below the part of the patch necessary to fix this issu=
e (the other hunk in my patch concern my work).
=09
@@ -297,7 +297,8 @@ ieee80211_tx_h_check_assoc(struct ieee80
       if (unlikely(test_bit(SCAN_SW_SCANNING, &tx->local->scanning)) &&
           test_bit(SDATA_STATE_OFFCHANNEL, &tx->sdata->state) &&
           !ieee80211_is_probe_req(hdr->frame_control) &&
-          !ieee80211_is_nullfunc(hdr->frame_control))
+          !ieee80211_is_nullfunc(hdr->frame_control) &&
+              !ieee80211_is_qos_nullfunc(hdr->frame_control))
               /*
                * When software scanning only nullfunc frames (to notify
                * the sleep state to the AP) and probe requests (for the

Sorry I know it is not correctly formated, but at this time I cannot genera=
ted a correct patch. This patch is very easy to apply in the main branch.

Regards.

C=E9dric Voncken


