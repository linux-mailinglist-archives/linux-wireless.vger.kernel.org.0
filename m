Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC48332C134
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Mar 2021 01:02:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245477AbhCCVR1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 3 Mar 2021 16:17:27 -0500
Received: from mail-dm6nam12on2048.outbound.protection.outlook.com ([40.107.243.48]:11261
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238418AbhCCR2q (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 3 Mar 2021 12:28:46 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mT22LSAAfXsC0OmIFLtBhdooqNIbFHFPPip0/vHY/owzMAFyhaSr/XwiWtDU53A2q/uuC+svSOf5r06O6kcEDV4/XfgpaDNWtyWbBOeODA3+HlJ4XNIJ/qeli3SrYDWxk0F6dB0AGCjfkUh4JFWxlgoUGmQBqA7gqhz1wpw5b3AsCvSB5nA+e4VDcmcV5uNoQNGtM1BSasmCcBuG4tuf76cY7K8y/sB7xErIgUdRnpl1pd3AQzR3QAulDKx7Jrbg26lFhXCPgVpvAH8mSTlXJfbZXE1UEhOgxTQ54uHr+cu9FN5WC4ymK9ixGjgkBImALD2gZfrhZtBuxGdtIhmpwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qHWsQdcRd3xHkQDyBcll/2v5j9fJoV7CBsmzqjhh0+0=;
 b=c7lQ/US+K/Ni9/8YQ7Of5uKRE/NXmnKKo/Z85G303g0Y05QBQWjyWZHne9CmqnU3alrabcOfpbIBexJutamrnv8lMSVYJBTv5hrTyzFXqcNWr14FaYUZE1SsOTVBd77MJD6WGgNb8qSJSGAqJ1nGyQf4iw/fpUqEQ3NQdPRLiNvNT1CGtGL/VGz2ZdyALDNFB+jLVWrtJrstt3ilzT7RfJHuIPZaTTjsnpl3TlEQRmeITdQ5s0VHMDOk9AEKW8tXRkTQbr7o2l81DWSXWLi0e+5KeCLI684WjGtqHDQk3KKHPEhT6Xwm2/mMvW7SVvkNAPGxFRcaVwusG5INlg4Dxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silabs.com; dmarc=pass action=none header.from=silabs.com;
 dkim=pass header.d=silabs.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=silabs.onmicrosoft.com; s=selector2-silabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qHWsQdcRd3xHkQDyBcll/2v5j9fJoV7CBsmzqjhh0+0=;
 b=XeaF4YdiJUmViR2uQsiMOheyNYc4+awtoidnhFqAlV72CSVatC25daU0d51CXFhPabeP7GERWCihOtbOv5rzQQbqXkcnBNCFX4YIyUKAUTTudnZXFh4uUv6BxxY7JXZqyMXn9rubf2h/t53WZ+GeesoduwvRZ2fU6FmPyI5Me+8=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=silabs.com;
Received: from SN6PR11MB2718.namprd11.prod.outlook.com (2603:10b6:805:63::18)
 by SA0PR11MB4576.namprd11.prod.outlook.com (2603:10b6:806:97::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Wed, 3 Mar
 2021 17:27:03 +0000
Received: from SN6PR11MB2718.namprd11.prod.outlook.com
 ([fe80::41bc:5ce:dfa0:9701]) by SN6PR11MB2718.namprd11.prod.outlook.com
 ([fe80::41bc:5ce:dfa0:9701%7]) with mapi id 15.20.3890.030; Wed, 3 Mar 2021
 17:27:03 +0000
From:   =?ISO-8859-1?Q?J=E9r=F4me?= Pouiller <jerome.pouiller@silabs.com>
To:     linux-firmware@kernel.org
Cc:     linux-wireless@vger.kernel.org, Kalle Valo <kvalo@codeaurora.org>
Subject: pull-request: linux-firmware: silabs: add new firmware for WF200
Date:   Wed, 03 Mar 2021 18:26:57 +0100
Message-ID: <2833354.gXvVfaC4I7@pc-42>
Organization: Silicon Labs
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Originating-IP: [2a01:e35:2435:66a0:544b:f17b:7ae8:fb7]
X-ClientProxiedBy: SN7PR04CA0246.namprd04.prod.outlook.com
 (2603:10b6:806:f3::11) To SN6PR11MB2718.namprd11.prod.outlook.com
 (2603:10b6:805:63::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pc-42.localnet (2a01:e35:2435:66a0:544b:f17b:7ae8:fb7) by SN7PR04CA0246.namprd04.prod.outlook.com (2603:10b6:806:f3::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend Transport; Wed, 3 Mar 2021 17:27:02 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 01617a6e-7687-449f-3306-08d8de698f23
X-MS-TrafficTypeDiagnostic: SA0PR11MB4576:
X-Microsoft-Antispam-PRVS: <SA0PR11MB4576231DD8D84ED4557F059893989@SA0PR11MB4576.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1850;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WdQL6s2iDf4pXjqXbdjJYC0M/6739T+2H7ngXWAgdLQUIgSd9hzLbqpIG6LzRI3CWDqodrfKDPcG4VfuNKKKxaHPuwCxacJ32CH5PbrqGpeYW7rxiikuoOc0xvTSfgxi//cQc+m0/CE3A0rNlxeQ0c79UXekqZa28dCGlprHOXfbqmsNyhODwEJJDDaqEiq42Ar7bi3lDxH7z3zMCfB+oXe35+mKSJNfjFaSrCjXEQXK2hK1m4VkbCs3Zt7XgTH2RLRMLFBS1gizwbrwyW+qc5efkRW9nSj52RcYoe2xS9Se2BrjSEjxhv7gON0lkJI6rX0MFx62+xbHIwnlwd5tizauVGcrVwxjRVv4ab34jXvSruhIVUGsVNgQF2VlmNKE5WVqenSc7hWANNlx7Es9DUGcd14ObVjffKosug8NZCSANvop56LVwNmUJXH3RrzI+iWpjcGZISf5taYxzb78EGUJVpZP+lNB1CsE3vAlMl+0cnt+dFgyqGZSeWuFABl/0gxf3q1sXI2uiSVe4HvCCXx4sCREuP58JGigDOsP3iEH7oKSZcOXoNcbV4q0huB6LpkKO0Aj2c93Qc1Wx1xtkw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR11MB2718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(39850400004)(396003)(136003)(346002)(376002)(66556008)(8676002)(478600001)(66946007)(66476007)(36916002)(52116002)(8936002)(6666004)(33716001)(6486002)(2906002)(6506007)(9686003)(6512007)(6916009)(316002)(5660300002)(4326008)(16526019)(86362001)(186003)(39026012);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?iso-8859-1?Q?/KdKch0XOlfSugD55cvJwej/kpXci+XvsCdbkGWlifPVOx5bP3Qs+2quO/?=
 =?iso-8859-1?Q?kOU8QXCgj2/FTRqXbny57VRhYw8+CbRDMLvbwz50/9z1Ut9VcSPbGb6ON+?=
 =?iso-8859-1?Q?smv1TwCbpbBmt0juPtYwKmNC86JKMzk/HhOr0HjTyPYRrUbVAAU+UnerAZ?=
 =?iso-8859-1?Q?LJ7TISmTcnonTSehG6ZiJd55acrrM6AObikIQyYAC0WsdHXIwe9Yu7Sk8f?=
 =?iso-8859-1?Q?JfW1TmNz9cNE2oVkL93US/fI1uLGKwNz6ec9NTeLON3sJ724HYx1uKjkB6?=
 =?iso-8859-1?Q?WQa+1DuGK2AqEEmHGvegkJopGJrGallHBfPFyYltu8k253WEU8/KAtTnZw?=
 =?iso-8859-1?Q?UnzeP5xMjnn0NVrq4B8DIB0r+sjHZqJkiYEfyJ3ihnjXlb33IHQBmMoxIp?=
 =?iso-8859-1?Q?buSbN43evkmOQ4oHk68JrRgVTx8yFxJZMlDlh+jSku39ymxFyCWnk61YqQ?=
 =?iso-8859-1?Q?H7GTCJCCgBxHEsbPG2ClnSnIqUZv/FjvQmfG1uCEwNaBcMTk5RmnyWZO2W?=
 =?iso-8859-1?Q?DaVpxXbcxfBt/8j9SYAPrzHnGmogvaxK6FMPxZ8Gm8k9lTvCMd8htS/saS?=
 =?iso-8859-1?Q?s5exjYRRK/ayujbyLmeXhZG4yUDIg0/IBXkY/ixz/Ih0g4YyYOFVXoX4ui?=
 =?iso-8859-1?Q?0A/sLwqcJoQgTI57Xx9zbJf7UM2MsWGeqPg9QWdyI5ucSf1QU1Nz4NA359?=
 =?iso-8859-1?Q?n3iWHY3OSqiyNb0WiWzfLhlr9V3THIRwZEzIQ6kPFGMxOx0lessEE6TnIW?=
 =?iso-8859-1?Q?I1zWbY2Pvu4AMwoqQNUCBVkdTGg0WxEziIy/ZLpD1OUBHR0laLuR124r6Z?=
 =?iso-8859-1?Q?2ibQ9XLqWpzXei3uk+WukgG6j0pSJ+lrVkEv13gUIl+2ka8LFSBXJ+ksQe?=
 =?iso-8859-1?Q?CK6B8P/C4usLcOgSRcYh6YDQLxTPnVWTPoiPo4mNCfN7UOiYhzXlcvSpuB?=
 =?iso-8859-1?Q?bI+4EzcqGglSvEK8cOE8mOUPiLX/qO6/vAHfD3ftSCGV7oYU6MJ/m3RQzp?=
 =?iso-8859-1?Q?D01B/Q03s2SSj3SZrLeLtHNpJL+Y30Dueo3GSnTXxpDhTR/Wea1l8hUmCn?=
 =?iso-8859-1?Q?qv9t0rK7H7ebgVJPFyolUI+TP092AlFD3zlQK30QzrCFX0D5Pkne62FSnu?=
 =?iso-8859-1?Q?HO0lFxeCZ4HlioUSv9/Ntb7xbt9JH9HMglSK7xhUOYTwddpVUFq5sRQNhU?=
 =?iso-8859-1?Q?c3RdbhbNTFDORH9Pj10vibbOwclEA7Ghmul9uu1pGG1MQkIv8LSdEcF55b?=
 =?iso-8859-1?Q?CBJpfimG0JUyOjgMPi9jVRvHPTp2K35R5IQhYWix30qI3eamBylscTb28i?=
 =?iso-8859-1?Q?2S/F3r1xogVz7KMOCdtUEQJyLIeno96eS/ClXQ3RNvw/7sPCaXczblabx0?=
 =?iso-8859-1?Q?N14pX9xUZQJTjBpaFO1bj221HVeMvO6lSTKtvYOeEDACJhaKKSV1XZ50ie?=
 =?iso-8859-1?Q?efYMa9/9wQAA4QO9?=
X-OriginatorOrg: silabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01617a6e-7687-449f-3306-08d8de698f23
X-MS-Exchange-CrossTenant-AuthSource: SN6PR11MB2718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2021 17:27:02.9075
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 54dbd822-5231-4b20-944d-6f4abcd541fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cMFRp7qFWGEreV7O1jdHTHxI/JIgupMoBtjjm5Fs6y2N2FQO7HBeAjdbCriQKhpzDqiStbuBiVcPkP+5D2JbXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4576
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello,

I know that PRs are less convenient for review, but it seems that my patch
does not want to reach the MLs (because it is too big?).

So, this PR contains only one commit. It adds the firmware for Silabs
WF200. This firmware is necessary for the wfx driver currently hosted in
the staging/ directory of the Linux kernel.

J=E9r=F4me Pouiller


The following changes since commit f7915a0c29fee27a310cebd7155b9e3a6eb71a1d=
:

  amdgpu: add initial firmware for green sardine (2021-02-11 09:31:02 -0500=
)

are available in the Git repository at:

  git@github.com:jerome-pouiller/linux-firmware.git add-silabs-wf200

for you to fetch changes up to 520f71bdedba1b0687b0d9fbd86ff9e84a56677b:

  silabs: add new firmware for WF200 (2021-03-02 14:32:33 +0100)

----------------------------------------------------------------
J=E9r=F4me Pouiller (1):
      silabs: add new firmware for WF200

 WHENCE                  |  10 ++++++++++
 silabs/LICENCE.wf200    | 115 ++++++++++++++++++++++++++++++++++++++++++++=
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 silabs/wfm_wf200_C0.sec | Bin 0 -> 305232 bytes
 3 files changed, 125 insertions(+)
 create mode 100644 silabs/LICENCE.wf200
 create mode 100644 silabs/wfm_wf200_C0.sec




