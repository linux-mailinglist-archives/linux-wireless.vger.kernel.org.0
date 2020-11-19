Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7F3F2B95B4
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Nov 2020 16:08:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727309AbgKSPGN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 19 Nov 2020 10:06:13 -0500
Received: from mail-bn8nam12on2097.outbound.protection.outlook.com ([40.107.237.97]:53440
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726791AbgKSPGN (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 19 Nov 2020 10:06:13 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UANyXC9w9X1wGb8s5AbRrIjzAC3YswFlQKneP1aPlLGXc6Kbv51zXO/8AZbEFj3dhgE8XFE8sI7FqRBSOECv57wEgmta6EY1tGH2jkxQGHHyeyLJTpN1zfjVlTlP1d5YCE1PbO8Q6Tuc3B7XhlVEOP07zJYoolLkKaEQs36bzGT/GiS0bSwpRjaoYBZeo69TBXqrMR9Jvnzpz8M9pUM7DrA9nqzilt4VcZ3o53rNPCXvdGIlJ3YclnG06fvVHHkqnRECM0h+X76zedkFC9cBLVaJy9ij1xixHFvH/qZK2Tj4zoawo2qPaoxM7hvMIJcvzEFiGIl9rjeloJ+jhi6a7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LuppN/rFJCdOfoik5AqxQu1gjHbbUbPnls8VN5DuCc0=;
 b=eQedsU3A6NqaT9OdNqWfrWiyFDnZxClkTPiIer1JDdnlvuDgqlE9sb2FgEuc8fpYEOfXvVhRI46RcvyyB33EwmtIOZO7tIiRpk63eBdS9fBJk53jhGz5dGOxjdygx5nwanD0nY1qPLch5WhONlN+MrhfiVqI/2b5Ga6lk5CD20DhwEKTV8D4M++dJj/JNouv+T5bGHjnFF8GZSpiPZ/Q/ZZimSEyAin4/WWGNHIc4tpejToJ3A/L94LlbT3Q8kHoj4L1Dc2Hp5YOfqdrfO8TPovjiez5UWzGFOyrOZKBmApjRhtpAbGNROwMP2b8ZQVBqWl8j2EdYCdLeEfFr58jyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cradlepoint.com; dmarc=pass action=none
 header.from=cradlepoint.com; dkim=pass header.d=cradlepoint.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cradlepoint.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LuppN/rFJCdOfoik5AqxQu1gjHbbUbPnls8VN5DuCc0=;
 b=elz4ye2Ifjhm0+vn+ooYst3dai3CNV6r5LyoXlvNWpUVPvE86+6LYIo6c+WfHIr8GSBhy6bb3TXtRbQlUipwbGnQGiHCi5+CKDtUZk3olqLWTake6SBbjhi1TBqoWnc1WO4bgzmlK0RgS2AwfZ5LTEDeZ2svC/fefFipyKbWtN4=
Received: from DM5PR12MB1801.namprd12.prod.outlook.com (2603:10b6:3:113::14)
 by DM6PR12MB4251.namprd12.prod.outlook.com (2603:10b6:5:21e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.22; Thu, 19 Nov
 2020 15:06:10 +0000
Received: from DM5PR12MB1801.namprd12.prod.outlook.com
 ([fe80::ec45:e4bb:7102:2092]) by DM5PR12MB1801.namprd12.prod.outlook.com
 ([fe80::ec45:e4bb:7102:2092%12]) with mapi id 15.20.3564.028; Thu, 19 Nov
 2020 15:06:10 +0000
From:   David Poole <dpoole@cradlepoint.com>
To:     Brian Norris <briannorris@chromium.org>,
        Johannes Berg <johannes@sipsolutions.net>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Ben Greear <greearb@candelatech.com>,
        John Crispin <john@phrozen.org>
Subject: Re: [PATCH 0/4] iw: add HE capabilities scan parsing
Thread-Topic: [PATCH 0/4] iw: add HE capabilities scan parsing
Thread-Index: AQHWvVzQB3bCNPOWTUmbhKJnWxauaKnPkCRv
Date:   Thu, 19 Nov 2020 15:06:10 +0000
Message-ID: <DM5PR12MB1801E9BD703DB5E6381CF602D9E00@DM5PR12MB1801.namprd12.prod.outlook.com>
References: <20201118033936.3667788-1-briannorris@chromium.org>
In-Reply-To: <20201118033936.3667788-1-briannorris@chromium.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: chromium.org; dkim=none (message not signed)
 header.d=none;chromium.org; dmarc=none action=none
 header.from=cradlepoint.com;
x-originating-ip: [65.153.116.34]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8752d182-681a-443b-550d-08d88c9ca678
x-ms-traffictypediagnostic: DM6PR12MB4251:
x-microsoft-antispam-prvs: <DM6PR12MB4251CBBFC6592653B6E465E6D9E00@DM6PR12MB4251.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:169;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ffzSJv+j1UINrzF4lyNSI7Juar0nKkbdmtHaE16EYixLMG80KSxgaKeL8aEmhmzbnjx2ToAm9bi8a7vjMkUGdUzhkAkElkWJYuPBFQbg22GhvnRCNsMY/5+5FyrWKA5rWbkrB4orwsbz86dTZIv2bpINGsB5Ws+1j09bGQiV0Rz5KheCcKgK/jon2QvEbSQnY6WKBFtQtHwVkc2ojlhMMQeXgsbFJsmbd620yuKuQJPmEzdKEzZxEFu5sExDuZwPCXNUTU0QcjoM+AfBDoM0LCJIEssnRllZCFajf3G5LTmr3knAuOqcf6PdJ8uXu3gLrMcNClarZZ7CiQYL8HjSn6EthOyV1MM2SRj0K9cr4cpu8QsugeqChBEQB6lB78Ei+LOepqNm0yVEoy04qiF2wg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB1801.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(136003)(39850400004)(366004)(396003)(53546011)(71200400001)(478600001)(186003)(26005)(55016002)(9686003)(8936002)(45080400002)(966005)(6506007)(2906002)(8676002)(83380400001)(52536014)(5660300002)(66476007)(66556008)(7696005)(66446008)(64756008)(4326008)(33656002)(110136005)(316002)(54906003)(86362001)(76116006)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: i1onsYOXRl9k+PSpGFUIjcUeZ5NfvJmtagIh9+ptUV98WfE0mIiUcp1alf/L2XkEwF733ldbyCuU+D0Foa5KPZlcGmF4gy1q1WztrFZ4oB0vOXkXpy51VULfqacu+yBjvho4OMyduy64hmPqLuk7eCwium6I8sZFWbHLDxTgT3zm75Fab6+sxAQ9KBz5QcGKwWI1mWeb2VflCErjXC3quWGH75hvqy3+6L3j/lhrcn2kFJXpXTLEwSiaudrPD/+fFSO0L3psoTjLdTZaTR0Jl4fE6xHy1PgGEmxh/+kJ6V7jEurU5os1MIdG1KkFnDYaLwZqtQKVpJcO+TXBYBAHmCr91CEMBfsG88nYT7lceDGYqWB/FEZgoPRFPcyx6NBAEszcYQCCWVqcoZaf8Wp+LiaHa9gtz1CaBPVylfPrLC0sxPcz02OzWUiBGh3ab5My9c+A7vcT6E2CQ7ZYxTqxmqw3oJuHqdZaDgveSRzksOEUtf7tQKZdTclbRDCas2R8lfASPlFnIa6gkfvKzQaTWksjbXrrt6SSVVOpnMkR3ITAV7mQ8sgTQPB6J7EAc0egRWY9EIX//344OS57PV0XdkBbde+RUA3K7HNgxj0BTDI4yaitY1gSniE+XZaOGz2yA5KdjDehtv1GGvZlZL6emfQ80XR0QbbbKIkg7ZsjWzavuyhCErPuog/S1/Encf5JApyRAdDshkkuGAsEG41IxgK/dCLx6pUtn6HPQs5hWNDuFVxK5Hnz7K3YaJLb2LM7tVZCuCdY3QgG8ypXgrQqnC5Ut4AjJiu/7iQFYSCdWVS4CBgkR4HGR+ub5lP+CRsXpAc/i//jdyH8yOKnlI2rc/Ay5MLXUe4HeMhCd+bKHUxi7U87uBPtrlsIZ+kMx94mzVXl6U6d1qNWhBO1H3R2iQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cradlepoint.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1801.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8752d182-681a-443b-550d-08d88c9ca678
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2020 15:06:10.7716
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 1c02e371-8283-43fd-a70d-1e8e10c567ec
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OqTeyfDhkucb3kkPmGj8MgfXaL5hq3EeHJb9C22NB+CjcFzZ1U05A/vL8hAC8kASPFIDdqnOmWocwbaxknPYaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4251
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

I'll be happy to help test!

________________________________________
From: Brian Norris <briannorris@chromium.org>
Sent: Tuesday, November 17, 2020 8:39 PM
To: Johannes Berg
Cc: linux-wireless@vger.kernel.org; David Poole; Ben Greear; John Crispin; =
Brian Norris
Subject: [PATCH 0/4] iw: add HE capabilities scan parsing

Several others have made halting mentions of doing this:

Subject: iw scan dump for /AX attributes?
https://lore.kernel.org/linux-wireless/8afa882e-64de-7c8b-49f4-ac318f395102=
@candelatech.com/t/#u

Subject: Adding 802.11ax decode to 'iw scan dump'  Checking for interest an=
d looking for feedback.
https://lore.kernel.org/linux-wireless/MWHPR12MB1533B5C250E9B35367EAF628D93=
30@MWHPR12MB1533.namprd12.prod.outlook.com/

But none of those have materialized in acceptable form. So here goes my
bad attempt! I only attempted HE capabilities for now, since that's
partially supported already.

Regards,
Brian

Brian Norris (4):
  iw: scan: add extension tag parsing
  iw: util: factor out HE capability parser
  iw: scan: parse HE capabilities
  iw: scan: fixup HE caps whitespace

 iw.h   |   1 +
 scan.c |  40 ++++++++++++
 util.c | 187 ++++++++++++++++++++++++++++++++++++---------------------
 3 files changed, 159 insertions(+), 69 deletions(-)

--
2.29.2.299.gdc1121823c-goog

