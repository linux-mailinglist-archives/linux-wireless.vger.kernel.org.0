Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 077741ECC65
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jun 2020 11:19:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726733AbgFCJTK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 3 Jun 2020 05:19:10 -0400
Received: from mail-eopbgr80085.outbound.protection.outlook.com ([40.107.8.85]:39233
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725943AbgFCJTJ (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 3 Jun 2020 05:19:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oCev6/4IzHDEM/b4vMMeEea7pC5Y3PGPdlgx4NfABZLzoaIU1YWscsvCvPkiIdN73cgMmdUcaU6d6hnnZOC4Kd7TUxQMINiIJsmi5DcWJwLzO96xEl5sUcCClKVtnU9gNMkKvWQPx4O9+eGZzyqUjk97ywtLJJ14MrskpQ/HhtMAH383y5/tUnCoGpTA4AemBn5VAXkvZ4vSmRnBOK8zA529uVN0QfPXfMTJ0X+GlZW0h+svcoJacnBHwvL4THv3l+CQn4EMk4lIgAsWmtia8M33IR8Sh7sKxIhePTRZSshaTUpGlni3fgtdUaTy8YzFINfYJX8IxFNRqA3kbW1BSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X8SYUhiaGRf3gliqgDPh+9KTtHYELGZpzrQRlk9zyqo=;
 b=hhWqUKiDvnRV8zEUkaxFNM6Myc3IPynJYAPW9GfTTKZpM6P2MPuxRsTL9pTHZYV5ETLvz+1s+XAVdffsAzascjhbhPZXw/0bKIwKSQhyvrpsLLZsdkG0pRqUGFBANJ4wYJIaoNSDVR5dgDUUwapvI4I3BY3Ca+184yTzJd/Og+Y/dC3zWoZp/xNojgzSSHfmYVGNYu7jNp7wxo6Sr7vIWlBoD/PYPmAiAq0USFj/w7A8ha2PhIKmX/JFjn0jt+IJThL3DpBYNggJ1IIs4S7QHzt9KhMSr2YYsq5zJRe05PEtO3YROHnpjdeJa/kbdeDeDT0QYD+w9N5n5oESgR5Gyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X8SYUhiaGRf3gliqgDPh+9KTtHYELGZpzrQRlk9zyqo=;
 b=K315Ehqtmod3y0pMIkI9NLGnx74jjVqRV6BEC/8SzjS5r+jG1GKAjTt2baWbBTq1oGpisCrssTnl9scaJE+UW6kOULe6o0yQGe+RX87MUjz3rMJDRXLiFhKr3GKA2l2AYFwiIQfbWKbEo483FrSl3HLoi2tlcO5MRD+4QcPN2pE=
Received: from VI1PR04MB4366.eurprd04.prod.outlook.com (2603:10a6:803:3d::27)
 by VI1PR04MB5854.eurprd04.prod.outlook.com (2603:10a6:803:e2::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18; Wed, 3 Jun
 2020 09:19:05 +0000
Received: from VI1PR04MB4366.eurprd04.prod.outlook.com
 ([fe80::8102:b59d:36b:4d09]) by VI1PR04MB4366.eurprd04.prod.outlook.com
 ([fe80::8102:b59d:36b:4d09%7]) with mapi id 15.20.3066.018; Wed, 3 Jun 2020
 09:19:05 +0000
From:   Ganapathi Bhat <ganapathi.bhat@nxp.com>
To:     =?utf-8?B?UGFsaSBSb2jDoXI=?= <pali@kernel.org>,
        Amitkumar Karwar <amitkarwar@gmail.com>,
        Xinming Hu <huxinming820@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        =?utf-8?B?TWFyZWsgQmVow7pu?= <marek.behun@nic.cz>
CC:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Hemantkumar Suthar <shemant@marvell.com>,
        Rakesh Parmar <rakeshp@marvell.com>,
        Zhaoyang Liu <liuzy@marvell.com>, Cathy Luo <cluo@marvell.com>
Subject: RE: [EXT] [PATCH 3/4] btmrvl: Fix firmware filename for sd8977
 chipset
Thread-Topic: [EXT] [PATCH 3/4] btmrvl: Fix firmware filename for sd8977
 chipset
Thread-Index: AQHWOYAy6bkPN43VMU+fo9K0ANK4PqjGnQwQ
Date:   Wed, 3 Jun 2020 09:19:04 +0000
Message-ID: <VI1PR04MB4366D05C485E5DBD0A34CEA48F880@VI1PR04MB4366.eurprd04.prod.outlook.com>
References: <20200603082229.15043-1-pali@kernel.org>
 <20200603082229.15043-4-pali@kernel.org>
In-Reply-To: <20200603082229.15043-4-pali@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [103.54.18.180]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: de750f16-8d1d-4157-f569-08d8079f2998
x-ms-traffictypediagnostic: VI1PR04MB5854:
x-microsoft-antispam-prvs: <VI1PR04MB58540EF4067960007B9FE01A8F880@VI1PR04MB5854.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-forefront-prvs: 04238CD941
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: v9s1g4L4ZIUk5gjyZpPmUoL3qUQ0wusJVTmUdOEEHoS9VtpdRw/REuuW+7DcA+mAMfqn9YBRH2zgrPxAd7UNbKh8PT6C5TLoj15HAVhFMTpaEVFDBiYXWJPqtcrz+2lh0+CG6+JKgs9ACDnpvRB0tU0b797fQCVo0Yt79V4rnOot2NMv+x00eBDPMmoz7cIRQMLkpjK1pQY+fVr7znZE7+uAf006D4Q3MwyvvAAwOKm26vKBcp7e5+LqfEowOwwSX/NkHQizfImoje41oxZqt28jMjmgxJmF5ER32Tbykzzvk2pA6YzYh62zNFo0jRy8UZpHyfnb6VbSWpr5pMT1Pg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(136003)(39860400002)(396003)(346002)(366004)(478600001)(4326008)(44832011)(86362001)(6506007)(66446008)(8676002)(2906002)(5660300002)(19618925003)(66476007)(26005)(33656002)(8936002)(52536014)(55016002)(66946007)(76116006)(4270600006)(64756008)(66556008)(186003)(558084003)(7696005)(9686003)(54906003)(316002)(7416002)(71200400001)(110136005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: RjxcNSTFkOcUN465dcH1qd7WsBa7zLxsqRb9QCAkH5/lhwL8GKPyPphSAUF0iVbXVhXNMmx5i06kXNdJVBQYvi809Q+tzRevk9TV0YIV7kH3X7UWYAnHDmxmW+gpV+5Ez6Ahx4CPuEhu/PUmJ7Qw13CTUvBMY+AGBpdq8/vLmT24oEhQyUkQoePn8BVll2EoKutEzhzRUJMrjbpffVPCvkkgbX3w9HdN3qrma706pBlI9hrH1RLOad+ahGR9uZgrRtdvONN68uYn8zpV/5ET41lE48rb47j0MPQqqvolZPYszDvkB7VLSJ4B8GqJDDY7Y3AHFOrb9Qssq4MnxG0PpcU0qO399yNEc+eKqIZcckUP/g95v84+DISs3tx9IMxGPX/TYHUrNN9QnmIBG+F9QUoPN7QcLkM6U9gqPLw7itvLJ6ChiUuoY/swPPsM/3M167zS4qSDgqXTFDcRLq+fvcI2NFbJXHH1a2B/qiSp0tA=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de750f16-8d1d-4157-f569-08d8079f2998
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2020 09:19:05.0190
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s64sNS4D6xRGhcUDEeoGKzoDFcrvTXc4ziALQSk558UktZS+y+WQBR0aNbInjDN5tGEsY9VCYjbof0W8WwnYEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5854
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

QWNrZWQtYnk6IEdhbmFwYXRoaSBCaGF0IDxnYW5hcGF0aGkuYmhhdEBueHAuY29tPg0K
