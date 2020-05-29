Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B51411E7909
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2020 11:11:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725854AbgE2JLM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 29 May 2020 05:11:12 -0400
Received: from mail-eopbgr70047.outbound.protection.outlook.com ([40.107.7.47]:6178
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725710AbgE2JLM (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 29 May 2020 05:11:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sxb7X7O0A5BxwqCq3ptTOQcFa6LOP7aq6VE/J9CrKtGeZFd5Y9ATSfJzipfyTXUrxqNZsJEFebJCpV1tp9a/P8r3PmA+XOXMbzrLm6KMWegPnW+o6JrpcH3vVtRUwWynT9JHdgfoquJiGUj3lXwwGGJdhJeCVXU6xZeBn6l6zTMWtydmzG/9BL3CWTG2XVclUY2BSP/Hc1VoSZlT/YmTQLAP0Kul/PkkJ4AAEghYWla9Sau4vt/g+cfP7KeuKNaPEVX5b06a3YYk86ZwfxNeMb5IxX2Ux0q8RIxbmE1E9e1j/CasNf1HYv3nXGoI9AHJSAs+xFIA3JDkkym/Fu7Xig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZLy87L1/OfLFm7YZ23kiwJcVZ3F+e8oTzcwNHTfMuHc=;
 b=h2vOw79EcAv2/VSCosM+9eB/nxI5W9ttl8dNsMpCeOX/pVF2W3vLslPOiQAP1Qc3rPHmC5Xxrh+IyJrvkYnGQGAB2mTEm4/BEqdIsNf+yhxoRAnDpqXbdeG1AvgPn9TGncP63XukxGQ3LiRm1wne1ISCqHzeFxeuFbiIXgzLHPvRgqiM+dutBoipJusjtiCm1nCCQUymCa45WClpwS1g3oDBzagigShDpUifjm37qCgyEjbtl8IsiLGTWetNUZx4uzxBN9aQNrH0P+FM1Qgn8zYYL0A9ufyB0m2jBRmyTsSNSMTIlTJKjs2AcMK5v+VvSthEA/4zqUT2Su7pNssuQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZLy87L1/OfLFm7YZ23kiwJcVZ3F+e8oTzcwNHTfMuHc=;
 b=fBcri0+NCH2wbYtTU3Lf5b9BlIJsVTEehB8ZKxUU3Iir8uTx/eF6wY992OVr2iDk9BxeiX00BBWgFS0Sdc6MPd3PooMbD8HUfabUUgVO9VSECxHyC82xuWdtyfpRCBNyghz07Gk2LHqc6P6MyDJ6ECowg5JKF7vjYezwr4phgBs=
Received: from VI1PR04MB4366.eurprd04.prod.outlook.com (2603:10a6:803:3d::27)
 by VI1PR04MB5437.eurprd04.prod.outlook.com (2603:10a6:803:d8::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.17; Fri, 29 May
 2020 09:11:09 +0000
Received: from VI1PR04MB4366.eurprd04.prod.outlook.com
 ([fe80::8102:b59d:36b:4d09]) by VI1PR04MB4366.eurprd04.prod.outlook.com
 ([fe80::8102:b59d:36b:4d09%7]) with mapi id 15.20.3045.018; Fri, 29 May 2020
 09:11:09 +0000
From:   Ganapathi Bhat <ganapathi.bhat@nxp.com>
To:     =?iso-8859-1?Q?Pali_Roh=E1r?= <pali@kernel.org>
CC:     Amitkumar Karwar <amitkarwar@gmail.com>,
        Xinming Hu <huxinming820@gmail.com>,
        =?iso-8859-1?Q?Marek_Beh=FAn?= <marek.behun@nic.cz>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [EXT] mwifiex: Firmware name for W8997 sdio wifi chip
Thread-Topic: [EXT] mwifiex: Firmware name for W8997 sdio wifi chip
Thread-Index: AQHWKrwXtO/N2oQua0+uJ10PPhSg4aiqXxHQgBMCnACAAXIN0IAAAhkAgAAAaZCAAAIiAIAAA9Tg
Date:   Fri, 29 May 2020 09:11:08 +0000
Message-ID: <VI1PR04MB43663ACEAADB7ADD1EB7572D8F8F0@VI1PR04MB4366.eurprd04.prod.outlook.com>
References: <20200515132353.vfor7v4buzoddfmb@pali>
 <VI1PR04MB4366625917BB57695BE454448FBA0@VI1PR04MB4366.eurprd04.prod.outlook.com>
 <20200528103432.irmsaaz72x3xophg@pali>
 <VI1PR04MB4366409B8E293A265851DA948F8F0@VI1PR04MB4366.eurprd04.prod.outlook.com>
 <20200529084630.j7rpdypt6vycsedh@pali>
 <VI1PR04MB4366DECFA1EB5C3D6AADB0818F8F0@VI1PR04MB4366.eurprd04.prod.outlook.com>
 <20200529085536.zivf36mn2d6zx5ii@pali>
In-Reply-To: <20200529085536.zivf36mn2d6zx5ii@pali>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [103.54.18.180]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6b117fe5-a272-41f1-b931-08d803b039b5
x-ms-traffictypediagnostic: VI1PR04MB5437:
x-microsoft-antispam-prvs: <VI1PR04MB54370C7562E7583E47EF19E58F8F0@VI1PR04MB5437.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 04180B6720
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /BYmFKymfNKsMCK2L6ZTPsPYLIClgaX7X6EoxopO3pe4bvrj0jq19c3esMGqVYnNBNJRPx9RvRyzP71POws7O4RdLfKYtQA5ArDkY5l3MKu7b8vzu3AQju1ETXiWDvS1HgG78a9pW3psVIOADaEPdtfURFFuik02Qi7i+U0l2iOpYEA4XQssOP2WkuHylBpWpn6Oqc7zpUu1ioZ+yNihaPExL0w5ujVIGmfpKDvx4wcmjvAzEqg+yy+RQpD31D7BgiT+3XwZILr1ConoIZOCKGBs/M8/qNOiJqQYDOk54QfNuqap0gL5DFhIXj49vJUdssfLu2OfpNSefRov4UJt3w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(136003)(396003)(39860400002)(376002)(366004)(66476007)(66556008)(478600001)(186003)(7696005)(66946007)(76116006)(55016002)(316002)(4326008)(71200400001)(26005)(86362001)(54906003)(64756008)(9686003)(6506007)(66446008)(4744005)(6916009)(52536014)(8936002)(44832011)(2906002)(33656002)(5660300002)(8676002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: fF8nbohU2OcufpVM41B7JaEjKICYSrC8zgqNaBkh4FONkJXY4Gjn2lvS6ZrHxlPT4dgoIhUNdLIaLLlNmWSnZkqtCOf0QNubmtp6ArnRY+nZAQysAAI9Mq/R2rZTDzFNpWtetoXtPORFjSYnOBF+hx1dE0IuX5O7PL+bkQ8/RvK0sP310GtO0QdkgqFMacsHo4TOu8UOfsJRevovw8M1vy5cgg6n7CSWGpHcVRXN33tEK1kChxYiPvqKJpK/cXuHKtyqjKyWKv/cHgb6dvrSUbLakkkmKI+btqTRPC+kP2HU8WgGJPUmepYEucvME2W66S3EwJ9BUhz+rigGtrldwG5Jhu+5r3Mi7i2dnahUwoEpti8hAXtXbeVFWs2gwc8x0vjJpk0hMeMYyXwzpco62/y2IBL7OZ2zZEMu+Y2JcyTjVwFyMjt3WmMwn04b+ySC2A/4moG9XsnP19nOg+VXYL20rOwIIc1/WX2ERjbKcK0AeOXzLiJRhPileb7impF/
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b117fe5-a272-41f1-b931-08d803b039b5
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2020 09:11:08.8774
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qUHVj+GJUOppjGsi2q/OU8mLOiZGVXEauyF49jQ72Elhv7LRrHpSJftkM1hW5YDvkLPU1+BvjkAAsFwtv1u+aA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5437
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Pali,
=20
> Hello Ganapathi! Seems that on both locations is older version of
> sdsd8997_combo_v4.bin firmware, not the latest one. On both location is
> available just version 16.68.1.p179. But we have newer version 16.68.1.p1=
97.
> Could you please recheck it?

p179 do have the fix but we will try to upstream p197 also soon.

Regards,
Ganapathi
