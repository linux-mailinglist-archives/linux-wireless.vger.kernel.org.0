Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D18AA133993
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Jan 2020 04:24:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726146AbgAHDYA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 7 Jan 2020 22:24:00 -0500
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:25595 "EHLO
        alexa-out-sd-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726142AbgAHDYA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 7 Jan 2020 22:24:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=qti.qualcomm.com; i=@qti.qualcomm.com; q=dns/txt;
  s=qcdkim; t=1578453840; x=1609989840;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version:subject;
  bh=qYVpeKde9jB8SB8P3tRuQJepKF7jENYgaKzIhQ3j3BQ=;
  b=LDbgJ5oCw819bZQj1iFZDGSLKCR3d5vEu372naOiZMCh0iZnfcW1wAdO
   gEC1EPZtM2NiGotivU5+5XJeI1mgscNNg6oIgruhxRAVlVqEi+CTvJCVi
   RreRqr2eKyD22pHkQZDMd8nOX62jzrJYfuCAWvWA+4dwjkGdPEDHHc5Tb
   A=;
Subject: RE: [PATCH v3 0/2] start recovery process when payload length overflow for
 sdio
Thread-Topic: [PATCH v3 0/2] start recovery process when payload length overflow for sdio
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 07 Jan 2020 19:23:59 -0800
Received: from nasanexm03e.na.qualcomm.com ([10.85.0.48])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/AES256-SHA; 07 Jan 2020 19:23:59 -0800
Received: from NASANEXM01B.na.qualcomm.com (10.85.0.82) by
 nasanexm03e.na.qualcomm.com (10.85.0.48) with Microsoft SMTP Server (TLS) id
 15.0.1473.3; Tue, 7 Jan 2020 19:23:58 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (199.106.107.6)
 by NASANEXM01B.na.qualcomm.com (10.85.0.82) with Microsoft SMTP Server (TLS)
 id 15.0.1473.3 via Frontend Transport; Tue, 7 Jan 2020 19:23:58 -0800
Received: from CH2PR02MB6648.namprd02.prod.outlook.com (20.180.17.135) by
 CH2PR02MB6424.namprd02.prod.outlook.com (52.132.231.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.12; Wed, 8 Jan 2020 03:23:57 +0000
Received: from CH2PR02MB6648.namprd02.prod.outlook.com
 ([fe80::25bf:9481:a37:d17]) by CH2PR02MB6648.namprd02.prod.outlook.com
 ([fe80::25bf:9481:a37:d17%6]) with mapi id 15.20.2602.016; Wed, 8 Jan 2020
 03:23:57 +0000
From:   Wen Gong <wgong@qti.qualcomm.com>
To:     Wen Gong <wgong@codeaurora.org>,
        "ath10k@lists.infradead.org" <ath10k@lists.infradead.org>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Thread-Index: AQHVv7yp9si7CAGiVUy3dkYfLXGi1qfgJiJQ
Date:   Wed, 8 Jan 2020 03:23:57 +0000
Message-ID: <CH2PR02MB66484ED5F29338E0E4408758843E0@CH2PR02MB6648.namprd02.prod.outlook.com>
References: <20191231092806.6247-1-wgong@codeaurora.org>
In-Reply-To: <20191231092806.6247-1-wgong@codeaurora.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=wgong@qti.qualcomm.com; 
x-originating-ip: [180.166.53.42]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7d5e7ec1-3844-4df2-a34f-08d793ea325d
x-ms-traffictypediagnostic: CH2PR02MB6424:
x-microsoft-antispam-prvs: <CH2PR02MB64248803F44CC325841EE73F843E0@CH2PR02MB6424.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2582;
x-forefront-prvs: 02760F0D1C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(346002)(366004)(136003)(39860400002)(376002)(13464003)(199004)(189003)(2906002)(86362001)(5660300002)(316002)(4326008)(966005)(478600001)(81166006)(76116006)(6506007)(8676002)(9686003)(26005)(110136005)(53546011)(33656002)(66476007)(8936002)(81156014)(7696005)(52536014)(4744005)(66446008)(66556008)(71200400001)(66946007)(64756008)(55016002)(186003);DIR:OUT;SFP:1102;SCL:1;SRVR:CH2PR02MB6424;H:CH2PR02MB6648.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:0;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +ZJOcKtOYj8A7rYy+35rufIMpnTD61BrtvXDbxWc2FWjppY1+CGsfeW/ZaQykg6U4xJtZBw37XSEtyPfR/JtKQZ0hBHqJiN8vV3mElRwEuAOuNcLVxaBA3xiLTiLLnuo/eggklSsylY9sCVYuHsQhM5gQwH12VENpq9E2rZl8IHKSLV9W3Jp+X11QhFIUd0R80yDDnY+cxMloCQIf6DEgRb0gr8jzuaGQizSfLfUlAU0YVq0mkFhu6VCYkSScXO4lITEpjGZFW8lKW3qjLTLn+HYZd3pZJ/iVy1bqd6V1S2iE/9bFkuBkMyNdyqNek4c+ipb596i2uuQOJUhacmGHDtewW5cG6VdHMIHWW+LVbLrCgS5ho4mqZAf0KtjGwEHp2Q7+2S/GtHr/8CrQEvS7QWLoEWYlYP9RxepqXVP0d4ZgeIShsI47tEIV7a2NNJIbXfil7P8XIkymZyuF8PgeUj4u2g5jVNV6zwuR0OaSanWSNiQ5s5PjB1kT5F2RUsLrArEnXZOnZ8XK5cO+LW0GeHN/LNhjfeagyjtkOF3UPYdO6+F8nkCRW6bNT5c1oJB
x-ms-exchange-transport-forked: True
arc-seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fJagWDhyB/ORZSZWOcri5iGzvfyl4BBuNCO6oeZ0YXds3mFfzrRlvjwvVZXhj1QQkjFRJaG1Ly0VRpw8CMk8tlVoA9kbhFmb4v5I/hsuOW7qkQ5NlWsyWkrU7gwrx3L2c9BopbJ7Cz+wwADnj6TjAv0M0uwwYUnL7nkpBwNgdAuUFBJHu4kKgCus7l9fbeclrXnj4sW/CId5OFfiThsFWjjtaT1cC1k+EFN3yYt9/R3rQn6UKhYhc3cabEkW+ju+rpqXt4SaGpWWaNmWSSfCg77B+4IGE32PiG7uFQgdf/VCswp7ODHcb3VHwPGLPB2igsUKdXxazTWDyrc3jj2J7w==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2PYoZauIjoYiIciVCjguTSfMKNf3VjsNBl0AtGjbMXI=;
 b=hg6RWMHmPZqYJXMb6zbCSjPzpA/NQHSBAvI3L6ZUIlpff5tKAEXcdV7Gf/+eKvCIG/SGzz63q39/MVROWhxgntQMTcsna/dXFKSye+lxcA3kEA+5FxGd/OXQBjd/YOjOo+S2nr+/RmYin4J6uMuPpuKY6qhgLsz/t6ScEmtGwkv12Nh9uzz1w8y1G5D8uzjdCy3Uy3x/hvhG0luWzXSYRp+S+LZnZb8fIY9V8PpVticYc9bYfCAkYq5azV71ERAmiPus7E4YLz6vQVVnbzUnRePftvRukyJU4SRBtMxjgix9i9cIowlTa1sWm0LSNAuaAn/y1mYQ5Yx91bhNiD3+2w==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=qti.qualcomm.com; dmarc=pass action=none
 header.from=qti.qualcomm.com; dkim=pass header.d=qti.qualcomm.com; arc=none
dkim-signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.onmicrosoft.com; s=selector1-qualcomm-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2PYoZauIjoYiIciVCjguTSfMKNf3VjsNBl0AtGjbMXI=;
 b=Xjs7UaOxYx2p8czjULS2AE+xQ3iNXDgbm81QKIjlqtfVoWeRo+dryE1+jzGixZzr3ZbQsbrujGkrVJJkjWYs1XLQ/FGoyfxqd3Mwa5ZC9SRHS7KAAYdwKZ/SQhawgmfQamen8LgMgCACWF9NtjEajOZiWedoTQ6/+6PMrcCkTCM=
x-ms-exchange-crosstenant-network-message-id: 7d5e7ec1-3844-4df2-a34f-08d793ea325d
x-ms-exchange-crosstenant-originalarrivaltime: 08 Jan 2020 03:23:57.1627 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: JTqlmxVhBL1RW9seNkdpmJT8QyMHhEmHtR7IXKL0tyBmJmiYwUD0ywOjp1ERNukgGbqzHgOY84ff+oAg0ChZFw==
x-ms-exchange-transport-crosstenantheadersstamped: CH2PR02MB6424
x-originatororg: qti.qualcomm.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

> -----Original Message-----
> From: ath10k <ath10k-bounces@lists.infradead.org> On Behalf Of Wen Gong
> Sent: Tuesday, December 31, 2019 5:28 PM
> To: ath10k@lists.infradead.org
> Cc: linux-wireless@vger.kernel.org
> Subject: [EXT] [PATCH v3 0/2] start recovery process when payload length
> overflow for sdio
>

V4 sent:
https://patchwork.kernel.org/cover/11322579/
https://patchwork.kernel.org/patch/11322581/
https://patchwork.kernel.org/patch/11322583/

> _______________________________________________
> ath10k mailing list
> ath10k@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/ath10k
