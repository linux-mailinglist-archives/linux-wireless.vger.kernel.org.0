Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7505177C84F
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Aug 2023 09:12:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235354AbjHOHKA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 15 Aug 2023 03:10:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235225AbjHOHJj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 15 Aug 2023 03:09:39 -0400
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2070.outbound.protection.outlook.com [40.107.249.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBE99CE;
        Tue, 15 Aug 2023 00:09:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MzwRMx90KTtR29FMQR+yW/sRo6E1spahohq0fKAAmpsOldvnCbqHJdoFf9jpONEfQUdJoL+HTP7IaQMFtIS9EbNftE9/T9Omg4vneLGjEcyfcAypZBXj0NqXzCRhxaUcpsZX1/jrprsf/2aMvFPsLY4oDry4Xc8NA7rCvQiX82QU9yTebaUm33e3HthVtmFV7AxgB8qfURBFPIUj1/5zWR54YYjWAk6uh5zK5q8PsFxQn0YZDJrF5b+mtsE+Z1C7hl1IiSN2jtWdCzyXIpJQDMMkn6ZwRTAJfEk2Tiv76SD8prvq1l9Oadzkellqz+oGhiRDAd3Ae1qJgMTC4MHxDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3wcQrTD4VIYPZjKgvlhDjtJe/4HrMh8YUeyf2V9suCc=;
 b=EZOBUuK9u2y/Jrhozrgxt8aWoWVQXreNvPywitXN5N93AP1r9npLGN/oWWTF7V4aikmmSXXW3qzv1mM8SsPOM/1aDafCauIZw9a5zgyRmQ5ya+FFEWK1qg1I+pYEXvfBz5N2El3i2ZKvJ6v1807aj4QyTqxRStqFbGHtKp4hfWGrE6BvvvCxQLtdAUzO6W5m1hEteR1W5pRqntbL/CJQlJ1cDushkrwjvPVh1pOeYjNkNyDSIiDjYF2MVl2xvs2kHAJPVTO7Fam1LXGmCk7sjnKBcGbzkqvn4YQVL9rlzD3YfHbMuDzXyR4/ra5pixio5O6VmW/tV1xcwtXrTgEzGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3wcQrTD4VIYPZjKgvlhDjtJe/4HrMh8YUeyf2V9suCc=;
 b=BNUbeIUaW2ezeQ2XvGZdhOGJ9PlbE8KUQ6JM690Aw/Gsmy+UE6QPaoOlQLmFZWvhNX76xpSq28l4FLCsl5GRytZLqoFhlhFN7xy7I81N7pBJCGSCrANOFhmnuCzaS0P2piHP0yf1wkr81MjE/mf+0xgs6uW0EXjrF8C7fdwsuW8=
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by PAWPR04MB10032.eurprd04.prod.outlook.com (2603:10a6:102:38d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.24; Tue, 15 Aug
 2023 07:09:28 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::693d:8782:eae1:2460]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::693d:8782:eae1:2460%4]) with mapi id 15.20.6678.022; Tue, 15 Aug 2023
 07:09:28 +0000
Content-Type: multipart/mixed;
        boundary="_000_PA4PR04MB9638B8753EFD81E174E55BC3D114APA4PR04MB9638eurp_"
From:   David Lin <yu-hao.lin@nxp.com>
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sharvari Harisangam <sharvari.harisangam@nxp.com>,
        David Lin <yu-hao.lin@nxp.com>,
        Pete Hsieh <tsung-hsien.hsieh@nxp.com>,
        "kvalo@kernel.org" <kvalo@kernel.org>,
        "amitkarwar@gmail.com" <amitkarwar@gmail.com>,
        "ganapathi017@gmail.com" <ganapathi017@gmail.com>,
        "huxinming820@gmail.com" <huxinming820@gmail.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernelorg" <kuba@kernelorg>,
        "pabeni@redhat.com" <pabeni@redhat.com>
Subject: [PATCH v4 0/1] Patch History
Thread-Topic: [PATCH v4 0/1] Patch History
Thread-Index: AdnPR2z5RfEdmhOXQ3+2NbaQx2XQrw==
Date:   Tue, 15 Aug 2023 07:09:28 +0000
Message-ID: <PA4PR04MB9638B8753EFD81E174E55BC3D114A@PA4PR04MB9638.eurprd04.prod.outlook.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: <PA4PR04MB9638B8753EFD81E174E55BC3D114A@PA4PR04MB9638.eurprd04.prod.outlook.com>
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR04MB9638:EE_|PAWPR04MB10032:EE_
x-ms-office365-filtering-correlation-id: c41031e1-2e2a-48bb-c145-08db9d5e90a5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EdYQg7sT7qQyGCoH55Y2AAz4YYLs5wSFlNavSbWbZV5yU8iuWs9JZ7QHiQ1CBlre5Y6CmNhEUps6gbnY7jdBqs/QfBO5FiabYQ7kxdRaYhvPMtxyJ597swgpz30EHH2bagWssoIq8VuMDTVhYU0rnW+Ia22rkGcr02JRssBewatchrrhmraX5Vd9OVxbEeSJMdnE6DEhFeGnlXdtGxaBbi6zFiALuhH5oVjoxdYkzmhSwMGns/sTIZr2SGOAKcNZsmLjE3uzVJmB60xpB3rnT4nmLyn57h8dzAKPsSepLKGUzia8EBSYNMdR7vrDpf0bTb0w0QRo5WD5bADt2QVLbyWfuPrndTyYotdU6JA4g7TJsQ487KZa9fqSfgzjnp5ucWwkPLdidhhUZt6lfFKrv3LA4UOsfP4qf30PODyo7D/sQPCMjyk5z4elagvJ3iyhaa5MVFRPtBPNW7curZZFsDfjz0dWH8+6Mq5S3xhCeL5jzabpd6Akz9iQ0Cuj4qFnCHoH34wcrCIBu0dw6Hxp5ieNtZ3UxyqAPDOVy5ghYR/fkVMLGLOr6xo86w4CpWSTSJyPIHSo5rHxfgs0mBumQng4wPB6dkdiuyW0Z3Vn12LnguG6OAPvJzbq79Jo+3An
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(136003)(346002)(366004)(376002)(396003)(1800799006)(186006)(451199021)(55016003)(478600001)(122000001)(8676002)(71200400001)(8936002)(4326008)(6916009)(64756008)(41300700001)(316002)(66446008)(54906003)(38070700005)(38100700002)(66476007)(66946007)(76116006)(66556008)(83380400001)(9686003)(6506007)(7696005)(26005)(86362001)(2906002)(52536014)(5660300002)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Avv6Byv3pxoNUeyuu4qYN9ckrv9ZduncOj2Yt5sSld3Nw4N+AOLm256uE6CK?=
 =?us-ascii?Q?mT2B0EtLbDYoAtvp/6t2eJaJOvCOnVJ5qOKZOV47I4fPxH1FvYFgc/rf6o5T?=
 =?us-ascii?Q?er3AXjFP9oTc4xnsE7QeyDb8AiAwRtYAVsmM3JJ/3Mt2EyR3QYyC9eH4ijMK?=
 =?us-ascii?Q?j13uAtDEnMPgdm6EA7wLefDL3N0Cd3QoxUzdlfBXtMzF3IyGOSt/IUtBuJEv?=
 =?us-ascii?Q?LrfHuUexZSza141uXH3mfqGmqyji357m/Fs9fMUTyCTXg0PxWzbmYXkO3GQT?=
 =?us-ascii?Q?7/zYpf/RWGN5PRpOv+MGOeGK0Jk6Nl0+rvYpyN5IrF3A7JfrgUd7hXTDJS/A?=
 =?us-ascii?Q?2GqDSboKpGT7Bv9T8TqMMCS/YYBk+HvmM/Z2IRktKOzLnmtokMsJurjTufg1?=
 =?us-ascii?Q?B8AGTnzH8V3FpIkiaXqG6fZu3eaeHHhoitjFd1hZx49+o/cAfOm81wIDUtox?=
 =?us-ascii?Q?ZB6X/+pIaf1RBxi01wBXB+wrSOjvswCwpxv+i80Xk7tVcOkM7rbitRnC+znY?=
 =?us-ascii?Q?tFmYx6/4p7nSEpmkdL/X0xfuin3IoCoGuFDVgyMCf2BsEchmJ2s3KQv8GfnM?=
 =?us-ascii?Q?ZA+qxZWAT8wzKH5nd3JRfaNZWedX/16fI7rtmcWRqJmLNvEZfQZZ2wGMsTOQ?=
 =?us-ascii?Q?49gDZhrJvHHsS5+l6CdTjppRQD5HA+li239NRGGbw1Rz0xLnPW96Bfw28ldy?=
 =?us-ascii?Q?iICw8vKuluDAGbtUxImDCdLibFAncz7DNVaTUMXGwuTU7/+9CvXGI5FJGfuR?=
 =?us-ascii?Q?8KIlmcdAwLYOwoU3eNcjfJeiLupvn2SmGKCYedC4q3BgnBmjcvEhO2R6fiGH?=
 =?us-ascii?Q?x4x6mwq+a/ZhxM0Curx0n9xcIyOY90ZZRIOxLy6+Lmxw69OI/3GfuuGd+OZR?=
 =?us-ascii?Q?5uPuAwpC5GZ5hDObbFJAwqJJ1hKgSExLCut0h56FMAlbdFE80QOzTSr5yTYv?=
 =?us-ascii?Q?B46AA5GMa1vci95ccuOq6jVpC7QDi2ysPSTgaXWb3U44ZQStY9BHsxE74aS6?=
 =?us-ascii?Q?3sOhq9SCTpxJqBY5CvCW1AI34VV89SduFhDzh5yGcIoqK4KvcFBpCnW8dY74?=
 =?us-ascii?Q?SCxyKvLADdf1OeX6y6YKBDgr2pFBKmU5p4CSUfpAqyHShPKGToc7CzRhYwoL?=
 =?us-ascii?Q?iyFPoY+i4MsqnzFgD8GCvlLKtfv+7A8Jg5VWnwXNtmRDP4kHucfLfS83ln/d?=
 =?us-ascii?Q?OzDdrYfeAp9UJ2tejYXT+A/SIdxFWGHENKs5alDxtKZWd8kvcfdsCiRxjes5?=
 =?us-ascii?Q?uC1VxedYf6AuXZwLeeimDri8kBlF22fPAeg/j2n7VSkDwpYXspU2u11q3rhU?=
 =?us-ascii?Q?na1uw5gWFbzDmDhXnWModDkFN2Pa7N5OAnTFfvu+qxcYiy/NIpSD4HQefiGY?=
 =?us-ascii?Q?2dD5CjJlmWKM3cXQ6RbpEx7325wtfwHZ3zl9OLC3JFtseMMg6ttqwKQ5xcKU?=
 =?us-ascii?Q?7wbIOmUQvT74SkC9UmisVQRDop39wOTLih4/A2vqR6Bd0f3xoJj2zGx72rrn?=
 =?us-ascii?Q?EM7tMP+7SyAOvB+vqCV6e72ua8WY9/JREK3fKT3SuCeQPd6KtT8K35Q7C2sA?=
 =?us-ascii?Q?PooCS9aBZqi277+WhzU9Nj+OmID2YdNo40KoFiwf?=
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c41031e1-2e2a-48bb-c145-08db9d5e90a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Aug 2023 07:09:28.1724
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EgEH+qkMS7ZZKG0Cz7bDwBGILHVoqImHr2VQXfPxXwBa5LexA0vvy0KDnygSJSZFzYkgyYeM9RQ0tXkQTckHcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB10032
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

--_000_PA4PR04MB9638B8753EFD81E174E55BC3D114APA4PR04MB9638eurp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Patch v4:

1. Correct one bad code segment.
2. Add code to check firmware key api version for host_mlme.

Patch v3:

Clean and clear commit message.

Patch v2:

1. Checkpatch error: pwe[1] -> pwe[0].
2. Remove module parameter 'host_mlme'.
3. Won't advertise NL80211_FEATURE_SAE if host mlme is disabled.

David Lin (1):
  wifi: mwifiex: added code to support host mlme.

 .../net/wireless/marvell/mwifiex/cfg80211.c   | 327 ++++++++++++++++++
 drivers/net/wireless/marvell/mwifiex/cmdevt.c |  14 +-
 drivers/net/wireless/marvell/mwifiex/decl.h   |  12 +
 drivers/net/wireless/marvell/mwifiex/fw.h     |  15 +
 drivers/net/wireless/marvell/mwifiex/init.c   |   3 +
 drivers/net/wireless/marvell/mwifiex/join.c   |  64 +++-
 drivers/net/wireless/marvell/mwifiex/main.h   |  10 +
 drivers/net/wireless/marvell/mwifiex/scan.c   |   6 +
 drivers/net/wireless/marvell/mwifiex/sdio.c   |  13 +
 drivers/net/wireless/marvell/mwifiex/sdio.h   |   2 +
 .../net/wireless/marvell/mwifiex/sta_event.c  |  18 +-
 .../net/wireless/marvell/mwifiex/sta_ioctl.c  |   3 +-
 drivers/net/wireless/marvell/mwifiex/sta_tx.c |  10 +-
 .../net/wireless/marvell/mwifiex/uap_cmd.c    |  26 ++
 drivers/net/wireless/marvell/mwifiex/util.c   |  73 ++++
 15 files changed, 583 insertions(+), 13 deletions(-)

--=20
2.25.1


--_000_PA4PR04MB9638B8753EFD81E174E55BC3D114APA4PR04MB9638eurp_
Content-Disposition: attachment; filename="winmail.dat"
Content-Transfer-Encoding: base64
Content-Type: application/ms-tnef; name="winmail.dat"

eJ8+IpdbAQaQCAAEAAAAAAABAAEAAQeQBgAIAAAA5AQAAAAAAADoAAEJgAEAIQAAAEJBQTRDMkU3
NEE3QUJFNDhCQkY5RDBCMUFGQkJGREVBAM4HAQ2ABAACAAAAAgACAAEFgAMADgAAAOcHCAAPAAcA
CQAcAAIAMwEBIIADAA4AAADnBwgADwAHAAkAHAACADMBAQiABwAYAAAASVBNLk1pY3Jvc29mdCBN
YWlsLk5vdGUAMQgBBIABAB0AAABbUEFUQ0ggdjQgMC8xXSBQYXRjaCBIaXN0b3J5AMQIAQuAAQAh
AAAAQkFBNEMyRTc0QTdBQkU0OEJCRjlEMEIxQUZCQkZERUEAzgcBA5AGANAwAABaAAAAAgF/AAEA
AABRAAAAPFBBNFBSMDRNQjk2MzhCODc1M0VGRDgxRTE3NEU1NUJDM0QxMTRBQFBBNFBSMDRNQjk2
MzguZXVycHJkMDQucHJvZC5vdXRsb29rLmNvbT4AAAAACwAfDgAAAAACAQkQAQAAAJMDAACPAwAA
PwcAAExaRnW/nAfdYQAKZmJpZAQAAGNjwHBnMTI1MgD+A0PwdGV4dAH3AqQD4wIABGNoCsBzZXQw
IO8HbQKDAFARTTIKgAa0AoCWfQqACMg7CWIxOQ7AvwnDFnIKMhZxAoAVYioJsHMJ8ASQYXQFsg5Q
A2Bzom8BgCBFeBHBbhgwXQZSdgSQF7YCEHIAwHR9CFBuGjEQIAXABaAbZGSaIANSIBAiF7JcdgiQ
5HdrC4BkNR1TBPAHQA0XcDAKcRfyYmttawZzAZAAICBCTV9C4EVHSU59CvwB8QvwGDIgUBiAEcAg
djRoOlxsC4BlCoEiRDHULiAIUHIJcGMFQAIguRngYmEcYAWgAQAgEgBWZweAAjAuIjUyIyBBrmQk
JRiQG9BoBZBrHHAaaRsAdwrAGeBrZXnwIGFwaSHwBJAAkAIgCxxwBbFoGRB0X21srweAJQYiNSGl
MyItQx5wHwORAHAkISuhG8JtbWlzBUAHgXNhGDApPyHDMn8iLyMwJoIKsCHCBJADYHIAOiBwd2Vb
MV1IIC0+MRMwXSUJUt5lBGAaMCzwBHB1HnAxEK0KwGEHgBuiJyinJyUG6jMjIFcCICcFQCQQG3ID
BAAZ4E5MODAyMQAxX0ZFQVRVUsBFX1NBRSAGkCiTfyzwKQE34AQgDeEBoB5wZFktfURhHWAcYEwL
gCDIKDEpLuYgIAPwJtD/MQAnADvhEDAxACQQAQAl2HBzdXBwCRE4GC19IMouP7AvGFB0LwPwCXCb
HnAEEC8AwBohbGxAsCE8RC9jZmc20y5jATuwIHwgMzI3IPYrQv87RmQFECfiP+9A/DptAQB2JPBC
UEKQIDF6NELgLUQfRS9BGQWBbP4uIeBCckeQIYBED0j/QQrsZndLA0s0NUuvTL9A++8LgCzQQkU7
sDNPf1CPQPvsam8LgFKmNkexQwBH7/9Ub0EKAMBWUUsWEjBTX1hv/0EKHkFWZ1bgWx9cL108DeD6
b1KmMVM/X+9g/2IASxXeIEuZP79krwGQX0cQJNL7QlFHcjhHyWcvaD9pQSgg/yOQSvBp1FMiV19r
T2h+DNBfR0VbAWp/b69BRnUnoF/3RuFCQ0diMl7RYs9zD3Qb9zZgbZNHYjdioUPpT1Em0Ad3oSZh
GbJkLCA1OB9ioAuAEgA2UQIgcygrPil7oGKRAQAecHxULSm5LvwtLQMwJSYOoC4AUAcvCxVCgOAA
HwBCAAEAAAAUAAAARABhAHYAaQBkACAATABpAG4AAAAfAGUAAQAAACYAAAB5AHUALQBoAGEAbwAu
AGwAaQBuAEAAbgB4AHAALgBjAG8AbQAAAAAAHwBkAAEAAAAKAAAAUwBNAFQAUAAAAAAAAgFBAAEA
AABcAAAAAAAAAIErH6S+oxAZnW4A3QEPVAIAAACARABhAHYAaQBkACAATABpAG4AAABTAE0AVABQ
AAAAeQB1AC0AaABhAG8ALgBsAGkAbgBAAG4AeABwAC4AYwBvAG0AAAAfAAJdAQAAACYAAAB5AHUA
LQBoAGEAbwAuAGwAaQBuAEAAbgB4AHAALgBjAG8AbQAAAAAAHwDlXwEAAAAuAAAAcwBpAHAAOgB5
AHUALQBoAGEAbwAuAGwAaQBuAEAAbgB4AHAALgBjAG8AbQAAAAAAHwAaDAEAAAAUAAAARABhAHYA
aQBkACAATABpAG4AAAAfAB8MAQAAACYAAAB5AHUALQBoAGEAbwAuAGwAaQBuAEAAbgB4AHAALgBj
AG8AbQAAAAAAHwAeDAEAAAAKAAAAUwBNAFQAUAAAAAAAAgEZDAEAAABcAAAAAAAAAIErH6S+oxAZ
nW4A3QEPVAIAAACARABhAHYAaQBkACAATABpAG4AAABTAE0AVABQAAAAeQB1AC0AaABhAG8ALgBs
AGkAbgBAAG4AeABwAC4AYwBvAG0AAAAfAAFdAQAAACYAAAB5AHUALQBoAGEAbwAuAGwAaQBuAEAA
bgB4AHAALgBjAG8AbQAAAAAACwBAOgEAAAAfABoAAQAAABIAAABJAFAATQAuAE4AbwB0AGUAAAAA
AAMA8T8EBAAACwBAOgEAAAADAP0/5AQAAAIBCzABAAAAEAAAALqkwudKer5Iu/nQsa+7/eoDABcA
AQAAAEAAOQAARAtuR8/ZAUAACDA/mSBuR8/ZAQsAKQAAAAAAHwDZPwEAAAAAAgAAUABhAHQAYwBo
ACAAdgA0ADoADQAKAA0ACgAxAC4AIABDAG8AcgByAGUAYwB0ACAAbwBuAGUAIABiAGEAZAAgAGMA
bwBkAGUAIABzAGUAZwBtAGUAbgB0AC4ADQAKADIALgAgAEEAZABkACAAYwBvAGQAZQAgAHQAbwAg
AGMAaABlAGMAawAgAGYAaQByAG0AdwBhAHIAZQAgAGsAZQB5ACAAYQBwAGkAIAB2AGUAcgBzAGkA
bwBuACAAZgBvAHIAIABoAG8AcwB0AF8AbQBsAG0AZQAuAA0ACgANAAoAUABhAHQAYwBoACAAdgAz
ADoADQAKAA0ACgBDAGwAZQBhAG4AIABhAG4AZAAgAGMAbABlAGEAcgAgAGMAbwBtAG0AaQB0ACAA
bQBlAHMAcwBhAGcAZQAuAA0ACgANAAoAUABhAHQAYwBoACAAdgAyADoADQAKAA0ACgAxAC4AIABD
AGgAZQBjAGsAcABhAHQAYwBoACAAZQByAHIAbwByADoAIABwAHcAZQBbADEAXQAgAC0APgAgAHAA
dwBlAFsAMABdAC4ADQAKADIALgAgAFIAZQBtAG8AdgBlACAAbQBvAGQAdQBsAGUAIABwAGEAcgBh
AG0AZQB0AGUAcgAgACcAaABvAHMAdABfAG0AbABtAGUAJwAuAA0ACgAzAC4AAAALAACACCAGAAAA
AADAAAAAAAAARgAAAAAUhQAAAAAAAB8AAICGAwIAAAAAAMAAAAAAAABGAQAAAB4AAABhAGMAYwBl
AHAAdABsAGEAbgBnAHUAYQBnAGUAAAAAAAEAAAAaAAAAegBoAC0AVABXACwAIABlAG4ALQBVAFMA
AAAAAAMAAIAIIAYAAAAAAMAAAAAAAABGAQAAADIAAABFAHgAYwBoAGEAbgBnAGUAQQBwAHAAbABp
AGMAYQB0AGkAbwBuAEYAbABhAGcAcwAAAAAAIAAAAEgAAIAIIAYAAAAAAMAAAAAAAABGAQAAACIA
AABOAGUAdAB3AG8AcgBrAE0AZQBzAHMAYQBnAGUASQBkAAAAAADhMRDEKi67SMFFCNudXpClHwAA
gBOP8kH0gxRBpYTu21prC/8BAAAAFgAAAEMAbABpAGUAbgB0AEkAbgBmAG8AAAAAAAEAAAAqAAAA
QwBsAGkAZQBuAHQAPQBNAFMARQB4AGMAaABhAG4AZwBlAFIAUABDAAAAAAAfAPo/AQAAABQAAABE
AGEAdgBpAGQAIABMAGkAbgAAAB8ANwABAAAAOgAAAFsAUABBAFQAQwBIACAAdgA0ACAAMAAvADEA
XQAgAFAAYQB0AGMAaAAgAEgAaQBzAHQAbwByAHkAAAAAAB8APQABAAAAAgAAAAAAAAADADYAAAAA
AAIBcQABAAAAFgAAAAHZz0ds+UXxHZoTl0N/tjW2kMdl0K8AAB8AcAABAAAAOgAAAFsAUABBAFQA
QwBIACAAdgA0ACAAMAAvADEAXQAgAFAAYQB0AGMAaAAgAEgAaQBzAHQAbwByAHkAAAAAAB8ANRAB
AAAAogAAADwAUABBADQAUABSADAANABNAEIAOQA2ADMAOABCADgANwA1ADMARQBGAEQAOAAxAEUA
MQA3ADQARQA1ADUAQgBDADMARAAxADEANABBAEAAUABBADQAUABSADAANABNAEIAOQA2ADMAOAAu
AGUAdQByAHAAcgBkADAANAAuAHAAcgBvAGQALgBvAHUAdABsAG8AbwBrAC4AYwBvAG0APgAAAAAA
AwDeP59OAAADABMSAAAAAAIBAIATj/JB9IMUQaWE7ttaawv/AQAAAC4AAABIAGUAYQBkAGUAcgBC
AG8AZAB5AEYAcgBhAGcAbQBlAG4AdABMAGkAcwB0AAAAAAABAAAAIgAAAAEACgAAAAQAAAAAAAAA
FAAAAAAAAAAAAAAA/////wAAAAAAAAsAAIATj/JB9IMUQaWE7ttaawv/AQAAABwAAABIAGEAcwBR
AHUAbwB0AGUAZABUAGUAeAB0AAAAAAAAAAsAAIATj/JB9IMUQaWE7ttaawv/AQAAACgAAABJAHMA
UQB1AG8AdABlAGQAVABlAHgAdABDAGgAYQBuAGcAZQBkAAAAAAAAAEAABzCq8uxtR8/ZAQIBCwAB
AAAAEAAAALqkwudKer5Iu/nQsa+7/eoDACYAAAAAAAsABgwAAAAAAgEQMAEAAABGAAAAAAAAAMil
JbGII5JKg6pkkAqkqyoHAE8+IND8Jt1ErmEHWjoK3ScAAAAAAQsAAE8+IND8Jt1ErmEHWjoK3ScA
AiEalPQAAAAAAgETMAEAAAAQAAAARfEdmhOXQ3+2NbaQx2XQrwIBFDABAAAADAAAAGAAAADMOAin
UAAAAAMAWzMBAAAAAwBaNgAAAAADAGg2DQAAAAsA+jYBAAAAHwD4PwEAAAAUAAAARABhAHYAaQBk
ACAATABpAG4AAAAfACJAAQAAAAYAAABFAFgAAAAAAB8AI0ABAAAA/AAAAC8ATwA9AEUAWABDAEgA
QQBOAEcARQBMAEEAQgBTAC8ATwBVAD0ARQBYAEMASABBAE4ARwBFACAAQQBEAE0ASQBOAEkAUwBU
AFIAQQBUAEkAVgBFACAARwBSAE8AVQBQACAAKABGAFkARABJAEIATwBIAEYAMgAzAFMAUABEAEwA
VAApAC8AQwBOAD0AUgBFAEMASQBQAEkARQBOAFQAUwAvAEMATgA9AEMAQgAwADQARgA2ADUAOQAx
AEEARAA2ADQANAA2AEIAOABBAEEAQgBDADkAQgA2ADUARABBAEUAOQAyADAANwAtAE4AWABGADUA
NwA2ADIANAAAAB8AJEABAAAABgAAAEUAWAAAAAAAHwAlQAEAAAD8AAAALwBPAD0ARQBYAEMASABB
AE4ARwBFAEwAQQBCAFMALwBPAFUAPQBFAFgAQwBIAEEATgBHAEUAIABBAEQATQBJAE4ASQBTAFQA
UgBBAFQASQBWAEUAIABHAFIATwBVAFAAIAAoAEYAWQBEAEkAQgBPAEgARgAyADMAUwBQAEQATABU
ACkALwBDAE4APQBSAEUAQwBJAFAASQBFAE4AVABTAC8AQwBOAD0AQwBCADAANABGADYANQA5ADEA
QQBEADYANAA0ADYAQgA4AEEAQQBCAEMAOQBCADYANQBEAEEARQA5ADIAMAA3AC0ATgBYAEYANQA3
ADYAMgA0AAAAHwAwQAEAAAAUAAAARABhAHYAaQBkACAATABpAG4AAAAfADFAAQAAABQAAABEAGEA
dgBpAGQAIABMAGkAbgAAAB8AOEABAAAAFAAAAEQAYQB2AGkAZAAgAEwAaQBuAAAAHwA5QAEAAAAU
AAAARABhAHYAaQBkACAATABpAG4AAAADAFlAAAAAAAMAWkAAAAAAAwA3UAEAAAADAAlZAQAAAB8A
Cl0BAAAAJgAAAHkAdQAtAGgAYQBvAC4AbABpAG4AQABuAHgAcAAuAGMAbwBtAAAAAAAfAAtdAQAA
ACYAAAB5AHUALQBoAGEAbwAuAGwAaQBuAEAAbgB4AHAALgBjAG8AbQAAAAAAAgEVXQEAAAASAAAA
AtOhbmgrvG9MqSzZnFwwFjUBAAACARZdAQAAABIAAAAC06FuaCu8b0ypLNmcXDAWNQEAAAMAAIBQ
42MLzJzQEbzbAIBfzM4EAQAAACQAAABJAG4AZABlAHgAaQBuAGcARQByAHIAbwByAEMAbwBkAGUA
AAAbAAAAHwAAgFDjYwvMnNARvNsAgF/MzgQBAAAAKgAAAEkAbgBkAGUAeABpAG4AZwBFAHIAcgBv
AHIATQBlAHMAcwBhAGcAZQAAAAAAAQAAAHAAAABJAG4AZABlAHgAaQBuAGcAIABQAGUAbgBkAGkA
bgBnACAAdwBoAGkAbABlACAAQgBpAGcARgB1AG4AbgBlAGwAUABPAEkASQBzAFUAcABUAG8ARABh
AHQAZQAgAGkAcwAgAGYAYQBsAHMAZQAuAAAACwAAgFDjYwvMnNARvNsAgF/MzgQBAAAAJgAAAEkA
cwBQAGUAcgBtAGEAbgBlAG4AdABGAGEAaQBsAHUAcgBlAAAAAAAAAAAAHwAAgB+k6zOoei5Cvnt5
4amOVLMBAAAAOAAAAEMAbwBuAHYAZQByAHMAYQB0AGkAbwBuAEkAbgBkAGUAeABUAHIAYQBjAGsA
aQBuAGcARQB4AAAAAQAAAC4BAABJAEkAPQBbAEMASQBEAD0AOQBhADEAZABmADEANAA1AC0AOQA3
ADEAMwAtADcAZgA0ADMALQBiADYAMwA1AC0AYgA2ADkAMABjADcANgA1AGQAMABhAGYAOwBJAEQA
WABIAEUAQQBEAD0ARAA5AEMARgA0ADcANgBDAEYAOQA7AEkARABYAEMATwBVAE4AVAA9ADEAXQA7
AFQARgBSAD0ATgBvAHQARgBvAHIAawBpAG4AZwA7AFYAZQByAHMAaQBvAG4APQBWAGUAcgBzAGkA
bwBuACAAMQA1AC4AMgAwACAAKABCAHUAaQBsAGQAIAA2ADYANwA4AC4AMAApACwAIABTAHQAYQBn
AGUAPQBIADQAOwBVAFAAPQAxADAAOwBEAFAAPQAxAEMAMQAAAAAAQAAAgAggBgAAAAAAwAAAAAAA
AEYAAAAAv4UAAOD2+2xHz9kBCwAAgAggBgAAAAAAwAAAAAAAAEYAAAAAgoUAAAAAAAACAQCACCAG
AAAAAADAAAAAAAAARgEAAAA2AAAASQBuAFQAcgBhAG4AcwBpAHQATQBlAHMAcwBhAGcAZQBDAG8A
cgByAGUAbABhAHQAbwByAAAAAAABAAAAEAAAANRUn0a9aaxPn1g6UZc92UoDAA00/T8AAB8AAICG
AwIAAAAAAMAAAAAAAABGAQAAAC4AAABhAHUAdABoAGUAbgB0AGkAYwBhAHQAaQBvAG4ALQByAGUA
cwB1AGwAdABzAAAAAAABAAAAsgAAAGQAawBpAG0APQBuAG8AbgBlACAAKABtAGUAcwBzAGEAZwBl
ACAAbgBvAHQAIABzAGkAZwBuAGUAZAApACAAaABlAGEAZABlAHIALgBkAD0AbgBvAG4AZQA7AGQA
bQBhAHIAYwA9AG4AbwBuAGUAIABhAGMAdABpAG8AbgA9AG4AbwBuAGUAIABoAGUAYQBkAGUAcgAu
AGYAcgBvAG0APQBuAHgAcAAuAGMAbwBtADsAAAAAAB8AAICGAwIAAAAAAMAAAAAAAABGAQAAACAA
AAB4AC0AbQBzAC0AaABhAHMALQBhAHQAdABhAGMAaAAAAAEAAAACAAAAAAAAAB8AAICGAwIAAAAA
AMAAAAAAAABGAQAAAC4AAAB4AC0AbQBzAC0AcAB1AGIAbABpAGMAdAByAGEAZgBmAGkAYwB0AHkA
cABlAAAAAAABAAAADAAAAEUAbQBhAGkAbAAAAB8AAICGAwIAAAAAAMAAAAAAAABGAQAAADYAAAB4
AC0AbQBzAC0AdAByAGEAZgBmAGkAYwB0AHkAcABlAGQAaQBhAGcAbgBvAHMAdABpAGMAAAAAAAEA
AABKAAAAUABBADQAUABSADAANABNAEIAOQA2ADMAOAA6AEUARQBfAHwAUABBAFcAUABSADAANABN
AEIAMQAwADAAMwAyADoARQBFAF8AAAAAAB8AAICGAwIAAAAAAMAAAAAAAABGAQAAAFAAAAB4AC0A
bQBzAC0AbwBmAGYAaQBjAGUAMwA2ADUALQBmAGkAbAB0AGUAcgBpAG4AZwAtAGMAbwByAHIAZQBs
AGEAdABpAG8AbgAtAGkAZAAAAAEAAABKAAAAYwA0ADEAMAAzADEAZQAxAC0AMgBlADIAYQAtADQA
OABiAGIALQBjADEANAA1AC0AMAA4AGQAYgA5AGQANQBlADkAMABhADUAAAAAAB8AAICGAwIAAAAA
AMAAAAAAAABGAQAAADgAAAB4AC0AbQBzAC0AZQB4AGMAaABhAG4AZwBlAC0AcwBlAG4AZABlAHIA
YQBkAGMAaABlAGMAawAAAAEAAAAEAAAAMQAAAB8AAICGAwIAAAAAAMAAAAAAAABGAQAAADoAAAB4
AC0AbQBzAC0AZQB4AGMAaABhAG4AZwBlAC0AYQBuAHQAaQBzAHAAYQBtAC0AcgBlAGwAYQB5AAAA
AAABAAAABAAAADAAAAAfAACAhgMCAAAAAADAAAAAAAAARgEAAAAqAAAAeAAtAG0AaQBjAHIAbwBz
AG8AZgB0AC0AYQBuAHQAaQBzAHAAYQBtAAAAAAABAAAADgAAAEIAQwBMADoAMAA7AAAAAAAfAACA
hgMCAAAAAADAAAAAAAAARgEAAABEAAAAeAAtAG0AaQBjAHIAbwBzAG8AZgB0AC0AYQBuAHQAaQBz
AHAAYQBtAC0AbQBlAHMAcwBhAGcAZQAtAGkAbgBmAG8AAAABAAAAAgUAAEUAZABZAFEAZwA3AHMA
VAA3AHEAUQB5AEcAQwBvAEgANQA1AFkAMgBBAEEAegA0AFkAWQBMAHMANQB3AFMARgBsAE4AYQB2
AFMAYgBXAGIAWgBWADUAeQBVADgAaQB1AFcAcwA5AEoAWgA3AFEASABpAFEAMQBDAEIAbAByAGUA
NQBZADYAQwBtAE4AaABFAFUAcABzADYAZwBiAG4AWQA3AGoAZABCAHEAcwAvAFEAZgBCAE8ANQBG
AGkAYQBiAFkAUQA3AGsAeABkAFIAYQBZAGgAdgBQAE0AdAB4AHkASgA1ADkANwBzAHcAZwBwAHoA
MwAwAEUASABIADIAYgBhAGcAVwBzAHMAbwBJAHEAOABWAHUATQBEAFQAVgBoAFkAVQAwAHIAbgBX
ACsASQBhADIAMgByAGsARwBjAHIAMAAyAEoAUgBzAHMAQgBlAHcAYQB0AGMAaAByAHIAaABtAHIA
YQBYADUAVgBkADkATwBWAHgAYgBFAGUAUwBKAE0AZABuAEUANgBEAEUAaABGAGUARwBuAGwAWABk
AHQARwB4AGEAQgBiAGkANgB6AEYAaQBBAEwAdQBoAEgANQBvAFYAagBvAHgAZABZAGsAegBtAGgA
UwB3AE0ARwBuAHMALwBzAFQASQBaAHIAMgBTAEcATwBBAEsAYwBOAFoAcwBtAEwAagBFADMAdQB6
AFYASgBtAEIANgAwAHgAcABCADMAcgBuAFQANABuAG0ATAB5AG4ANQA3AGgAOABkAHoAQQBLAFAA
cwBTAGUAcABMAEsARwBVAHoAaQBhADgARQBCAFMAWQBOAE0AZABSADcAdgByAEQAcABmADAAYgBU
AGIAMAB3ADAAUQBSAG8ANQBXAEQANQBiAEEARAB0ADIAUQBWAEwAYgB5AFcAZgB1AFAAcgBuAGQA
VAB5AFkAbwB0AGQAVQA2AEoAQQA0AGcANwBUAEoAcwBRADQAOAA3AEsAWgBhADkAZgBxAFMAZgBn
AHoAagBuAHAANQB1AGMAVwB3AGsAUABMAGQAaQBkAGgAaABVAFoAdAA2AGwAZgBGAEsAcgB2ADMA
TABBADQAVQBPAHMAZgBQADQAcQBmADMAMABQAE8ARAB5AG8ANwBEAC8AcwBRAFAAQwBNAGoAeQBr
ADUAegA0AGUAbABhAGcAdgBKADMAaQB5AGgAYQBhADUATQBWAEYAUgBQAHQAQgBQAE4AVwA3AGMA
dQByAFoAWgBGAHMARABmAGoAegAwAGQAVwBIADgAKwA2AE0AcQA1AFMAMwB4AGgAQwBlAEwANQBq
AHoAYQBiAHAAZAA2AEEAawB6ADkAaQBRADAAQwB1AGoANABxAEYAbgBDAEgAbwBIADMANAB3AGMA
cgBDAEkAQgB1ADAAZAB3ADYASAB4AHAANQBpAGUATgB0AFoAMwBVAHgAeQBxAEEAUABEAE8AVgB5
ADUAZwBoAFkAUgAvAGYAawBWAE0ATABHAEwATwByADYAeABvADgANgB3ADQAQwBwAFcAUwBUAFMA
SgB5AFAASQBIAFMAbwA1AHIASAB4AGYAZwBzADAAbQBCAHUAbQBRAG4AZwA0AHcAUABCADYAZABr
AGQAaQB1AHkAVwAwAFoAMwBWAG4AMQAyAEwAbgBnAHUARwA2AE8AQQBQAHYASgB6AGIAcQA3ADkA
SgBvACsAMwBBAG4AAAAAAB8AAICGAwIAAAAAAMAAAAAAAABGAQAAADgAAAB4AC0AZgBvAHIAZQBm
AHIAbwBuAHQALQBhAG4AdABpAHMAcABhAG0ALQByAGUAcABvAHIAdAAAAAEAAAAmBAAAQwBJAFAA
OgAyADUANQAuADIANQA1AC4AMgA1ADUALgAyADUANQA7AEMAVABSAFkAOgA7AEwAQQBOAEcAOgBl
AG4AOwBTAEMATAA6ADEAOwBTAFIAVgA6ADsASQBQAFYAOgBOAEwASQA7AFMARgBWADoATgBTAFAA
TQA7AEgAOgBQAEEANABQAFIAMAA0AE0AQgA5ADYAMwA4AC4AZQB1AHIAcAByAGQAMAA0AC4AcABy
AG8AZAAuAG8AdQB0AGwAbwBvAGsALgBjAG8AbQA7AFAAVABSADoAOwBDAEEAVAA6AE4ATwBOAEUA
OwBTAEYAUwA6ACgAMQAzADIAMwAwADAAMgA4ACkAKAAzADkAOAA2ADAANAAwADAAMAAwADIAKQAo
ADEAMwA2ADAAMAAzACkAKAAzADQANgAwADAAMgApACgAMwA2ADYAMAAwADQAKQAoADMANwA2ADAA
MAAyACkAKAAzADkANgAwADAAMwApACgAMQA4ADAAMAA3ADkAOQAwADAANgApACgAMQA4ADYAMAAw
ADYAKQAoADQANQAxADEAOQA5ADAAMgAxACkAKAA1ADUAMAAxADYAMAAwADMAKQAoADQANwA4ADYA
MAAwADAAMAAxACkAKAAxADIAMgAwADAAMAAwADAAMQApACgAOAA2ADcANgAwADAAMgApACgANwAx
ADIAMAAwADQAMAAwADAAMAAxACkAKAA4ADkAMwA2ADAAMAAyACkAKAA0ADMAMgA2ADAAMAA4ACkA
KAA2ADkAMQA2ADAAMAA5ACkAKAA2ADQANwA1ADYAMAAwADgAKQAoADQAMQAzADAAMAA3ADAAMAAw
ADAAMQApACgAMwAxADYAMAAwADIAKQAoADYANgA0ADQANgAwADAAOAApACgANQA0ADkAMAA2ADAA
MAAzACkAKAAzADgAMAA3ADAANwAwADAAMAAwADUAKQAoADMAOAAxADAAMAA3ADAAMAAwADAAMgAp
ACgANgA2ADQANwA2ADAAMAA3ACkAKAA2ADYAOQA0ADYAMAAwADcAKQAoADcANgAxADEANgAwADAA
NgApACgANgA2ADUANQA2ADAAMAA4ACkAKAA4ADMAMwA4ADAANAAwADAAMAAwADEAKQAoADkANgA4
ADYAMAAwADMAKQAoADYANQAwADYAMAAwADcAKQAoADcANgA5ADYAMAAwADUAKQAoADIANgAwADAA
NQApACgAOAA2ADMANgAyADAAMAAxACkAKAAyADkAMAA2ADAAMAAyACkAKAA1ADIANQAzADYAMAAx
ADQAKQAoADUANgA2ADAAMwAwADAAMAAwADIAKQAoADMAMwA2ADUANgAwADAAMgApADsARABJAFIA
OgBPAFUAVAA7AFMARgBQADoAMQAxADAAMQA7AAAAAAAfAACAhgMCAAAAAADAAAAAAAAARgEAAABc
AAAAeAAtAG0AcwAtAGUAeABjAGgAYQBuAGcAZQAtAGEAbgB0AGkAcwBwAGEAbQAtAG0AZQBzAHMA
YQBnAGUAZABhAHQAYQAtAGMAaAB1AG4AawBjAG8AdQBuAHQAAAABAAAABAAAADEAAAAfAACAhgMC
AAAAAADAAAAAAAAARgEAAABKAAAAeAAtAG0AcwAtAGUAeABjAGgAYQBuAGcAZQAtAGEAbgB0AGkA
cwBwAGEAbQAtAG0AZQBzAHMAYQBnAGUAZABhAHQAYQAtADAAAAAAAAEAAACCDAAAQQB2AHYANgBC
AHkAdgAzAHAAeABvAE4AVQBlAHkAdQB1ADQAcQBZAE4AOQBjAGsAcgB2ADkAWgBkAHUAbgBjAE8A
agAyAFkAdAA1AHMAUwBsAGQAMwBOAHcANABOACsAQQBPAEwAbQAyADUANgB1AEUANgBDAEsAbQBU
ADIAQgAwAEUAdABMAGIARABZAG8AQQB0AHYAcAAvADYAdAAyAGUASgBhAEoATwB2AEMATwBuAFYA
SgA1AHEATwBLAFoATwBWADQANwBJADQAZgBQAHgASAAxAEYAdgBZAEYAZwBjAC8AcgBmADYAbwA1
AFQAZQByADMAQQBYAGoARgBQADkAbwBUAGMANAB4AG4AcwBFADcAUQBlAHkARABiADgAQQBpAEEA
dwBSAHQAWQBBAFYAcwBtAE0AMwBKAEoALwAzAE0AdAAyAEUAeQBSADMAUQBZAHkAQwA5AGUASAA0
AGkAagBNAEsAagAxADMAdQBBAHQARABFAG4ATQBQAGcAZABtADYARQBBADcAdwBMAGUAZgBEAEwA
MwBOADAAQwBkADMAUQBvAHgAVQB6AGQAbABmAEIAWAB0AE0AegBGADMASQB5AEcATwBTAHQALwBJ
AFUAdABCAHUASgBFAHYATAByAGYASAB1AFUAZQB4AFoAUwB6AGEAMQA0ADEAdQBYAEgAMwBtAGYA
cQBHAG0AcQB5AGoAaQAzADUANwBtAC8ARgBzADkAZgBNAFUAVAB5AEMAVABYAGcAMABQAHgAVwB6
AGIAbQBZAFgAawBPADMARwBRAFQANwAvAHoAWQBwAGYALwBSAFcARwBOADUAUABSAHAATwB2ACsA
TQBHAE8AZQBHAEsAMABKAGsANgBOAGwAMAArAHIAdgBZAHAAeQBOADUASQByAEYAMwBBADcASgBm
AHIAZwBVAGQANwBoAFgAVABEAEoAUwAvAEEAMgBHAHEARABTAGIAbwBLAHAARwBUADcAQgB2ADkA
VAA4AFQAcQBNAE0AQwBTAC8AWQBZAEIAawArAEgAdgBtAE0ALwBaADIASQBSAGsAdABLAE8AegBM
AG4AbQB0AG8AawBNAHMASgB1AHIAagBUAHUAZgBnADEAQgA4AEEARwBUAG4AegBIADgAVgAzAEYA
cABJAGsAaQBhAFgAcQBHADYAZgBaAHUAMwBlAGEAZQBIAEgAaABvAGkAdABqAEYAZAAxAGgAWgB4
ADQAOQArAG8ALwBjAEEAZgBPAG0AOAAxAHcASQBEAFUAdABvAHgAWgBCADYAWAAvACsAcABJAGEA
ZgAxAFIAQgB4AGkAMAAxAHcAQgBYAEIAKwB3AHIAUwBPAGoAdgBzAHcAQwB3AHAAeAB2ACsAaQA4
ADAAWABrADcAdABWAGMATwBrAE0ANwByAGIAaQB0AFIAbgBDACsAegBuAFkAdABGAG0AWQB4ADYA
LwA0AHAANwBuAFMARQBwAG0AawBkAEwALwBYADAAeABmAHUAaQBuADMASQBvAEMAbwBHAHUARgBE
AFYAZwB5AE0AQwBmADIAQgBzAEUAYwBoAG0ASgAyAHMAMwBLAFEAdgA4AEcAZgBuAE0AWgBBACsA
cQB4AFoAVwBBAFQAOAB3AHoASwBIADUAbgBkADMASgBSAGYAYQBOAFoAVwBlAGQAWAAvADEANgBm
AEkANwByAHQAbQBjAFcAUgBxAEoAbQBMAE4AdgBFAFoAZgBRAFoAWgAyAHcARwBNAHMAVABPAFEA
NAA5AGcARABaAGgAcgBKAHYASABIAHMAUwA1ACsAbAA2AEMAZABUAGoAcABwAFIAUQBEADUASABB
ACsAbABpADIAMwA5AE4AUgBHAEcAYgB3ADEAUgB6ADAAeABMAG4AUABXADkANgBCAGYAdwAyADgA
bABkAHkAaQBJAEMAdwA4AHYASwB1AGwAdQBEAEEARwBiAHQAVQB4AEkAbQBEAEMAZABMAGkAYgBG
AEEAbgBjAHoANwBEAE4AVgBhAFQAVQBNAFgARwB3AHUAVABVADcALwArADkAQwB2AFgARwBJADUA
RgBKAEcAZgB1AFIAOABLAEkAbABtAGMAZABBAHcATABZAE8AdwBvAFUAMwBlAE4AYwBqAGYASgBl
AGkATAB1AHAAdgBuADIAUwBtAEcASwBDAFkAZQBkAEMANABxADMAQgBnAG4AQgBtAGoAYwB2AEUA
aABPADIAUgA2AGYAaQBHAEgAeAA0AHgANgBtAHcAcQArAGEALwBaAGgAeABNADAAQwB1AHIAeAAw
AG4AOQB4AGMASQB5AE8AWQA5ADAAWgBaAFIASQBPAHgATAB5ADYAKwBMAG0AeAB3ADYAOQBPAEkA
LwAzAEcAZgB1AHUARwBkACsATwBaAFIANQB1AFAAdQBBAHcAcABDADUARwBaADUAaABEAE8AYgBi
AEYASgBBAHcAcQBKAEoAMQBoAEsAZwBTAEUAeABMAEMAdQB0ADAAaAA1ADYARgBNAEEAbABiAGQA
RgBFADgAMABRAE8AegBUAFMAcgA1AHkAVABZAHYAQgA0ADYAQQBBADUARwBNAGEAMQB2AGMAaQA5
ADUAYwBjAHUATwBxADYAagBWAHAAQwA3AFEARABpADIAeQBzAFAAUwBUAGcAYQBYAFcAYgAzAFUA
NAA0AFoAUQBTAHQAWQA5AEIASABzAHgARQA3ADQAYQBTADYAMwBzAE8AaABxADkAUwBDAFQAcAB4
AEoAcQBCAFkANQBDAHYAQwBXADEAQQBJADMANABWAFYAOAA5AFMAZAB1AEYAaABEAHoAaAA1AHkA
RwBjAEkAbwBxAEsANABLAHYAYwBGAEIAcABDAG4AVwA4AGQAWQA3ADQAUwBDAHgAeQBLAHYATABB
AEQAZABmADEATwBlAFgANgB5ADYAWQBLAEIARABnAHIAMgBwAEYAQgBLAG0AVQA1AHAANABDAFMA
VQBmAHAAQQBxAHkASABTAGgAUABLAEcAVABvAGMANwBDAHoAUgBoAFkAdwBvAEwAaQB5AEYAUABv
AFkAKwBpADQATQBzAHEAbgB6AEYAZwBEADgARwBDAHYAbABMAEsAdABmAHYAKwA3AEEAOABKAGcA
NQBWAFcAbgB3AFgATgB0AG0AUgBEAFAANABrAEgAdQBjAGYATABmAFMAOAAzAGwAbgAvAGQATwB6
AEQAZAByAFkAZgBlAEEAcAA5AFUASgAyAHQAZQBqAFkAWABUACsAQQAvAFMASQBkAHgARgBXAEcA
SABFAE4ASwBzADUAYQBsAEQAeAB0AEsAWgBXAGQAOABrAHYAYwBmAGQAcwBDAGkAUgB4AGoAZQBz
ADUAdQBDADEAVgB4AGUAZABZAGYANgBBAHUAWABaAHcATABlAGUAaQBtAEQAcgBpADgAawBCAGwA
RgAyADIAZgBQAEEAZQBnAC8AagAyAG4ANwBWAFMAawBEAHcAcABZAFgAcwBwAFUAMgB1ADEAMQBx
ADMAcgBoAFUAbgBhADEAdQB3ADUAZwBXAEYAYgB6AEQAbQBEAGgAWABuAFcATQBvAGQARABrAEYA
TgAyAFAAYQA3AE4ANQBPAEEAbgBUAEYAZgB2AHUAKwBxAHgAYwBZAGkAeQAvAE4ASQBwAFMARAA0
AEgAUQBlAGYAaQBHAFkAMgBkAEQANQBDAGoASgBsAG0AVwBLAE0AMwBjAFgAUQA2AFIAYgBwAEUA
eAA3ADMAMgA1AHcAdABmAHcASABaADMAegBsADkATwBMAEMAMwBKAEYAdABzAGUATQBNAGcANgB0
AHQAcQB3AEsAUQA1AHgAYwBLAFUANwB3AGIASQBPAG0AVQBRAHYAVAA3ADQAUwBrAEMAOQBVAG0A
aQBzAFYAUQBSAEQAbwBwADMAOQB3AE8AVABMAGkAaAA0AC8AQQAyAHYAcQBSADYAQgBkADAAZgAz
AHgAbwBKAGoAMgB6AEcAeAA3ADIAcgByAG4ARQBNADcAdABNAFAAKwA3AFMAeQBBAE8AdgBCACsA
dgBxAEMAVgA2AGUANwAyAHUAYQA4AFcAWQA5AC8ASgBSAEUASwAzAGYASwBUADMAUwB1AEMAZQBR
AFAAZAA2AEsAdABUADgASwAzADUAUQA3AEMAMgBzAEEAUABvAG8AQwBTADkAYQBCAFoAcQBpADIA
NwA3ACsAVwBoAHoAVQA5AE4AagArAE8AbQBJAEQAMgBZAGQATgBvADQAMABLAG8ARgBpAHcAZgAA
AAAA70E=

--_000_PA4PR04MB9638B8753EFD81E174E55BC3D114APA4PR04MB9638eurp_--
