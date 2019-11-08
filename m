Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA51FF4358
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Nov 2019 10:32:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730614AbfKHJcq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 8 Nov 2019 04:32:46 -0500
Received: from mx0a-00183b01.pphosted.com ([67.231.149.44]:36932 "EHLO
        mx0a-00183b01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726987AbfKHJcq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 8 Nov 2019 04:32:46 -0500
Received: from pps.filterd (m0048106.ppops.net [127.0.0.1])
        by mx0a-00183b01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id xA89V5gb022695;
        Fri, 8 Nov 2019 02:32:39 -0700
Received: from nam02-bl2-obe.outbound.protection.outlook.com (mail-bl2nam02lp2050.outbound.protection.outlook.com [104.47.38.50])
        by mx0a-00183b01.pphosted.com with ESMTP id 2w41usp8sp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 Nov 2019 02:32:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G0UkPfly4pIG30Dpu2lWh9/5bbpBjXuRKvQcWkmkTpnZLyi6L10tmRtDOqiUV+RUckqSMg8rPrsghuXGV6Y6uR9FEY6quBfvFsW3HSwaP223yubl46kx/CVof9kV0g/oa6Q5uh1i01HOfU4fw4916rkRIWVQOCug2AcBKTUzYRcv/rDgqIljYhQuZ3pds7qUFH4MI3Ij3NwydcOSOBBt9+o2ERtbjoqioxB2Ick2kOvrDdz+eRNJsCfS6lJdOWlRDnClOyruF+pL6V3BORLGLe7pzTbb9maOWB85fDq1h/JadZkiLI0W8/1Q5KhGsXL1xfhnhS267MOx3M2euwuKYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VRAyDv70LwUfRN/9C/i7/CGJKbEdyZ6HYb+uVY3Iblc=;
 b=WUpnmretebLgLjKJFZCp80cLQ10tz9EZgHkq9etIuSXYAek6snTw5AKXVAS5VtxU5tYir+b8OR4zOj80uDyCviGP8oJZ/8qJw2ByZ/W7KESXyxrt1RrGC8N0a/gflqw/TOjc+BAF/cGwELcsm7diT45/9HuB8QW6FiA8AXVTzCGXeFRQ869kI8x/t1E3f/NemjvQFwSucBL3ShENGIUOh2teX93ibh2XF3vVNMrevdzpDWo9gtuDQg0lnsZsCjcvedXYDo/WLaHDw4EU5B5CCffFVeKWdSvvk9QJYA9CWngIuORAG/aM0WMY9vqZyGUtDKbgKf/qGtcCOeNjfLX98w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quantenna.com; dmarc=pass action=none
 header.from=quantenna.com; dkim=pass header.d=quantenna.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quantenna.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VRAyDv70LwUfRN/9C/i7/CGJKbEdyZ6HYb+uVY3Iblc=;
 b=nIn5AwBzpYkqRanSQ0oFAbfsmxdh0lohF0f+5fdx97pGCBr5RLbM6X+YHjBdE5ysNi+aAf5pxKTaJpAGcz/DI15z3nLwkb2YwKf9Nvt1a6x+oS3zhW4aaLFKx3FtKlHxMdPvzNqklR1b2WI3/W7SQIwuVluapaJlk5rPDDWiAxM=
Received: from SN6PR05MB3952.namprd05.prod.outlook.com (52.132.125.24) by
 SN6PR05MB4733.namprd05.prod.outlook.com (52.135.114.219) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.16; Fri, 8 Nov 2019 09:32:37 +0000
Received: from SN6PR05MB3952.namprd05.prod.outlook.com
 ([fe80::8482:2e14:2ccc:d6bb]) by SN6PR05MB3952.namprd05.prod.outlook.com
 ([fe80::8482:2e14:2ccc:d6bb%3]) with mapi id 15.20.2451.013; Fri, 8 Nov 2019
 09:32:37 +0000
Received: from SN6PR05MB4928.namprd05.prod.outlook.com (52.135.117.74) by
 SN6PR05MB4976.namprd05.prod.outlook.com (20.177.249.78) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.16; Fri, 8 Nov 2019 09:32:14 +0000
Received: from SN6PR05MB4928.namprd05.prod.outlook.com
 ([fe80::61a0:dd3d:3477:29c9]) by SN6PR05MB4928.namprd05.prod.outlook.com
 ([fe80::61a0:dd3d:3477:29c9%5]) with mapi id 15.20.2451.013; Fri, 8 Nov 2019
 09:32:14 +0000
From:   Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
To:     Tamizh chelvam <tamizhr@codeaurora.org>
CC:     "johannes@sipsolutions.net" <johannes@sipsolutions.net>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Re: [PATCHv8 0/6] cfg80211/mac80211: Add support for TID specific
 configuration
Thread-Topic: [PATCHv8 0/6] cfg80211/mac80211: Add support for TID specific
 configuration
Thread-Index: AQHVk9Zp+IDFjvKhwUy86pHdyrrRoqeBBxoA
Date:   Fri, 8 Nov 2019 09:32:13 +0000
Message-ID: <20191108093207.uv4j44xpm2qvtsv5@bars>
References: <1572957714-16085-1-git-send-email-tamizhr@codeaurora.org>
In-Reply-To: <1572957714-16085-1-git-send-email-tamizhr@codeaurora.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR07CA0004.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::17) To SN6PR05MB4928.namprd05.prod.outlook.com
 (2603:10b6:805:9d::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [195.182.157.78]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 451e95fa-5178-4790-4ccd-08d7642e899a
x-ms-traffictypediagnostic: SN6PR05MB4976:|SN6PR05MB4733:
x-microsoft-antispam-prvs: <SN6PR05MB4976E561FE7066547566D7EAA37B0@SN6PR05MB4976.namprd05.prod.outlook.com>
x-moderation-data: 11/8/2019 9:32:35 AM
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0215D7173F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(7916004)(376002)(39850400004)(396003)(346002)(366004)(136003)(199004)(189003)(2906002)(229853002)(66946007)(1076003)(186003)(66446008)(4326008)(66556008)(64756008)(478600001)(66476007)(71190400001)(6486002)(486006)(7736002)(99286004)(436003)(256004)(71200400001)(14454004)(6436002)(476003)(6246003)(81156014)(446003)(316002)(81166006)(25786009)(3846002)(6116002)(5660300002)(76176011)(8676002)(386003)(6506007)(102836004)(305945005)(6512007)(9686003)(11346002)(86362001)(33716001)(26005)(66066001)(54906003)(8936002)(6916009)(52116002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR05MB4733;H:SN6PR05MB3952.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: quantenna.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EhqHsX63/ioxviNBsrUjtARwaEnxi8TRH/6Agtuna+foiL4y0dIINm2vA4SJrIxweIfYIQAcQWlxP/MYKybvdAqFTQ7uxtW+nejfdwRCyAY6TEmTqFBW0DiiFkiGmmA3AVOkJRbglRrZCj8RPLjXnMeIbjoT2D0/ZnKK7V2l2M0Fi4tUk2gkRY7iBQlyAmVG4UkbDt7CTwC4TeKUuNcDhjjK3TL6Icfu1kJdl/9poAWPRxATE7Pl5glrrZxAg15uPXE4C94EY+NRuIEjY5QFKsLdqK28XXEugm7HpcmRemT/bvSpyyfXJdWd1XcZNmhMIRKmbz30L3oc8LfNoDFCOWQ5PNPqhuRAEKg0At92t6r5emN16+/qLFsgpWKgON+BUy92SOkrHcICscuawd4pr2MrMi/prQYpPCSEpAplYXVZBqNDxsVmLpcAjfY6lHYC
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2CCF32F8CAC450488E2A736C3AAD32C3@namprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: quantenna.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 451e95fa-5178-4790-4ccd-08d7642e899a
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a355dbce-62b4-4789-9446-c1d5582180ff
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ngj5X423R6GhGwF/nFT5Us5bPrqU1OLm6yDKiVm4U8jpcCJFjAlN+Dk5VWwMsxNzerA3w3xzNW+juXKOhBYZvpesYGEhHk2DXG5UU0JWIcyiLb1B+2RhZi4XErMQnZ8x0zaBuGIOoPfR4kPr3wKaytYiUMuA2AEvdo4mgT3AFOdrjMAMaONvmfcvSQGsSJejb13RUDRNtOqJ7hOLK8Rsi7i5bd1cVbKb/dIwes51ItI=
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2019 09:32:37.3438
 (UTC)
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR05MB4733
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-08_02:2019-11-07,2019-11-08 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 phishscore=0 mlxscore=0 bulkscore=0 clxscore=1011 lowpriorityscore=0
 adultscore=0 priorityscore=1501 spamscore=0 mlxlogscore=999
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1911080093
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

> Add infrastructure to support per TID configurations like noack policy,
> retry count, AMPDU control(disable/enable), RTSCTS control(enable/disable=
)
> and TX rate mask configurations.
> This will be useful for the driver which can supports data TID
> specific configuration rather than phy level configurations.
> Here NL80211_CMD_SET_TID_CONFIG added to support this operation by
> accepting TID configuration.
> This command can accept STA mac addreess to make the configuration
> station specific rather than applying to all the connected stations
> to the netdev.
> And this nested command configuration can accept multiple number of
> data TID specific configuration in a single command,
> enum ieee80211_tid_conf_mask used to notify the driver that which
> configuration got modified for the TID.
>=20
> Tamizh chelvam (6):
>   nl80211: New netlink command for TID specific configuration
>   nl80211: Add new netlink attribute for TID speicific retry count
>   nl80211: Add netlink attribute for AMPDU aggregation enable/disable
>   nl80211: Add netlink attribute to enable/disable RTS_CTS
>   nl80211: Add netlink attribute to configure TID specific tx rate
>   mac80211: Add api to support configuring TID specific configuration
>=20
>  include/net/cfg80211.h       |   55 +++++++++
>  include/net/mac80211.h       |    8 ++
>  include/uapi/linux/nl80211.h |  190 +++++++++++++++++++++++++++++
>  net/mac80211/cfg.c           |   28 +++++
>  net/mac80211/driver-ops.h    |   15 +++
>  net/wireless/nl80211.c       |  276 ++++++++++++++++++++++++++++++++++++=
+++---
>  net/wireless/rdev-ops.h      |   12 ++
>  net/wireless/trace.h         |   17 +++
>  8 files changed, 584 insertions(+), 17 deletions(-)

Hi Tamizh, Johannes, and all,

Looks very good to me:
Reviewed-by: Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>

BTW, there are two open questions remaining from the previous reviews:

- NL80211_TX_RATE_LIMITED and NL80211_TX_RATE_FIXED
  Interpretation and validation of these two rate options is left
  up to drivers.

- 'apply to all TIDs' usecase
  Currently, if peer is not specified, then configuration is applied to
  all the connected STAs. It is tempting to use some spare TID value
  to inform drivers that provided configuration should be applied to
  all TIDs of the specified STA or even to all TIDS and STAs. But that
  can not be left up to drivers since this value needs to be passed
  from userspace tools, e.g. from iw.

IIUC, the first question could be addressed later, after we see some
actual users and figure out generic use-cases. But what about the
second question ? Maybe it worth to add and document a single define,
e.g. using TID value 0xff, that can be used between userspace
and drivers for such usecases ?

Regards,
Sergey
