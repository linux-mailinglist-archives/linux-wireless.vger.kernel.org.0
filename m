Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08E581E0AB4
	for <lists+linux-wireless@lfdr.de>; Mon, 25 May 2020 11:36:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389365AbgEYJgb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 25 May 2020 05:36:31 -0400
Received: from mail-dm6nam10on2059.outbound.protection.outlook.com ([40.107.93.59]:29293
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388437AbgEYJga (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 25 May 2020 05:36:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oAUCa2yz7P3D7KrpbFIu01s5l/pM9JMQ1gThj5HmPf75e8TuOcLDmqK8jZETQYhMUk/w8QZKpWfSonkyuhdX/NJ6BkyuM1Zqg2rxF26kFUwrQDa/4ZaBrPvZ5F7kSWVUgNR8VUuU17J+adZvmBXeYrQLXDSITDXnF9rY3B/MlE159s9BB0Zrn0zhZaAHCBDvAKiSsvcucU01m6Zsxq13LALi3rnSmdhVU4FIjyKV94DRfEdoAy2P/9Bi3ySa++vOVOb6i3wBRXkNgc+vM5w8KP0gQ10sQulHamiMKDawQo1mdCVZXwWnBW+XdcQMjGnLq9qHyH2pAeGq/xc6pz9oHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0fqPfsmzSAGmkP6dm1SP4hf/59cEfcCgRULMm3mwpPs=;
 b=UaFFMhKVu/e9dfOpiC4jeooMOMiDgfHmB3FUkRZraW3Vykv8g6ple5JxUkwhPXulbcnDsXZFsiGl0dJ6A/+AXaBwGMUqu8vV7ZCKqnuc941b33PE+MuACt4g4ASppqUPhumRIRM5uLnWOm+srBsl4+vb2CuTDbKWhlrL2m+U+kfLKNVNtMFNEroYekCmxJ6PLB186u7fs9eay5qbWmvxk2VVMnCDiFLZnqFb4bsZploMlVqt0c0b6h+AXcHzCBwCYDQO25WezQB1okQAdjVYQenRLQuZiZDPZYkZl4BwF70Of+emfOcHQM5WYyn17Le+B+9uFDlUt4YBJjkS5d8+0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silabs.com; dmarc=pass action=none header.from=silabs.com;
 dkim=pass header.d=silabs.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=silabs.onmicrosoft.com; s=selector2-silabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0fqPfsmzSAGmkP6dm1SP4hf/59cEfcCgRULMm3mwpPs=;
 b=X87Zxn23aD1jBhUR8ZmhIgorFcnB0NCw0bZydJywNGeqddmLIyMSjJYE7L8Slhg8xXGM9cNQpxHA/VL4euDIMJMVxysiKcxUd+l/J9JLHOkzrBwW1Sw5as068zmxZd2vnNFR+ExFQugnbLxq2tf3y+ywDeKru8Sz3x7RUwZy0eI=
Authentication-Results: hauke-m.de; dkim=none (message not signed)
 header.d=none;hauke-m.de; dmarc=none action=none header.from=silabs.com;
Received: from SN6PR11MB2718.namprd11.prod.outlook.com (2603:10b6:805:63::18)
 by SN6PR11MB3470.namprd11.prod.outlook.com (2603:10b6:805:b7::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.27; Mon, 25 May
 2020 09:35:54 +0000
Received: from SN6PR11MB2718.namprd11.prod.outlook.com
 ([fe80::c504:2d66:a8f7:2336]) by SN6PR11MB2718.namprd11.prod.outlook.com
 ([fe80::c504:2d66:a8f7:2336%7]) with mapi id 15.20.3021.029; Mon, 25 May 2020
 09:35:54 +0000
From:   =?ISO-8859-1?Q?J=E9r=F4me?= Pouiller <jerome.pouiller@silabs.com>
To:     Hauke Mehrtens <hauke@hauke-m.de>
Cc:     johannes.berg@intel.com, ndesaulniers@google.com,
        pihsun@chromium.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH] wireless: Use linux/stddef.h instead of stddef.h
Date:   Mon, 25 May 2020 11:35:46 +0200
Message-ID: <2555103.LUZAIfNjjX@pc-42>
Organization: Silicon Labs
In-Reply-To: <20200521201422.16493-1-hauke@hauke-m.de>
References: <20200521201422.16493-1-hauke@hauke-m.de>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-ClientProxiedBy: PR3P192CA0020.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:102:56::25) To SN6PR11MB2718.namprd11.prod.outlook.com
 (2603:10b6:805:63::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pc-42.localnet (2a01:e35:2435:66a0:544b:f17b:7ae8:fb7) by PR3P192CA0020.EURP192.PROD.OUTLOOK.COM (2603:10a6:102:56::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.23 via Frontend Transport; Mon, 25 May 2020 09:35:51 +0000
X-Originating-IP: [2a01:e35:2435:66a0:544b:f17b:7ae8:fb7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: abb55660-89f7-48d9-d535-08d8008f040d
X-MS-TrafficTypeDiagnostic: SN6PR11MB3470:
X-Microsoft-Antispam-PRVS: <SN6PR11MB34704507352CDC829B3BFCD193B30@SN6PR11MB3470.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 0414DF926F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: InFuEZTDjsJ0u+wR8lDYQhYYVgmuxxwQCHxziLBLBn0ASKZImG9TjTJfoUz3zj5FadXVWfysufG+jj/4xd04mNckQKPlefocBrDRonDteekJ6AW/aYoWgyG0jvRpffR/PpTouJv+R//b08sNxCoQqniA2U5PNiMUFRuc8ewv9irGt3iWiIq/tj9Gg/WaQvm6NDBf3fB+YtrfMV3YbtbLpX0zSmCeT1oPJP9pyg1M6v/jRWoaWFxFPdpOHVhL0Lb0gmR3+jRS1CDD5ucAxsoveokapgaSjo/gJjblFrf9DrngUdri7mOkLK3IAwRwv0JSsj1f2imFfU4i+7ORz9EpGw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR11MB2718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(39850400004)(376002)(396003)(346002)(366004)(136003)(6512007)(5660300002)(9686003)(33716001)(2906002)(66556008)(66476007)(4326008)(6486002)(66574014)(8676002)(8936002)(6666004)(6916009)(6506007)(66946007)(186003)(52116002)(36916002)(86362001)(478600001)(316002)(16526019);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: ASrPJhJsOZPAvGmh1tNJfe8aARKDeVkPjYMrWV4v4q3QOAac1exkSHfY9KsEfXYqefG1EkehQ+mZ5cinDJ2nAXrMglVxJ3goGMyI0wpYMunjRyWLYgDRLhJLqRUPlm5EMeNPtEE/wehyW0vWUpcA/vcJZi/H5+9hnNQTeZF9q2C9RaNUkJmDsdgbGe79XEg/El8frv3ul3gbgGoA2FCF9eYQYwOI8cD+Ik5ynLPHzoX/r5I1Bn4qGhWb0gR9HCBevd6T597hzwq4m4GHlITBBpGww1+Gtw87dMrJ86lmmjHRZHD12tvyo6IeYztah0jZFlbY6RXOr6uzopNAMXxZlKSBVyEPrhhBeTAzNfnuTpTZvMISWlhfUEVpiLiFJv1jkV01w/Iwgd2MEhoPnaFTsd/Q7oLCtRqBjEZFg6RXHFlWkuMrrTPX/oMXSTpeJImEz3qty6uy7fNgHxzi2Y2te1yRp23pC0BSw2mgMWpvtS/fFE72vTIipMoAa0OLQPHwmJs/BEdZXe9VLnUaXTcyV3wdVehjZ/o1A/ilZfgaaSM=
X-OriginatorOrg: silabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abb55660-89f7-48d9-d535-08d8008f040d
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2020 09:35:53.8174
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 54dbd822-5231-4b20-944d-6f4abcd541fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tRfMK4qmSbdZGYLpP0Vz6QYthWV/0OyUXePHE8E3fY0hTIcbCtZtz5FEafq3hKyLXtX/iZsCqqMo4s0gtQ96Tw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB3470
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thursday 21 May 2020 22:14:22 CEST Hauke Mehrtens wrote:
> When compiling inside the kernel include linux/stddef.h instead of
> stddef.h. When I compile this header file in backports for power PC I
> run into a conflict with ptrdiff_t. I was unable to reproduce this in
> mainline kernel. I still would like to fix this problem in the kernel.
>
> Fixes: 6989310f5d43 ("wireless: Use offsetof instead of custom macro.")
> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
> ---
>  include/uapi/linux/wireless.h | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/include/uapi/linux/wireless.h b/include/uapi/linux/wireless.=
h
> index a2c006a364e0..24f3371ad826 100644
> --- a/include/uapi/linux/wireless.h
> +++ b/include/uapi/linux/wireless.h
> @@ -74,7 +74,11 @@
>  #include <linux/socket.h>              /* for "struct sockaddr" et al  *=
/
>  #include <linux/if.h>                  /* for IFNAMSIZ and co... */
>=20
> -#include <stddef.h>                     /* for offsetof */
> +#ifdef __KERNEL__
> +#      include <linux/stddef.h>        /* for offsetof */
> +#else
> +#      include <stddef.h>              /* for offsetof */
> +#endif

Hello,

This patch also solves a warning I encountered when I launched sparse
(with make C=3D1):

  /usr/lib/gcc-cross/arm-linux-gnueabihf/9/include/stddef.h:406:9: warning:=
 preprocessor token offsetof redefined
  ./include/linux/stddef.h:17:9: this was the original definition

However, I wonder if it useful to keep 'include <stddef.h>' when this file
is included from userspace. If it does not compile anymore, there is
problem somewhere else, no?

(Globally, I always find suspicious a kernel source that includes a system
header)


--=20
J=E9r=F4me Pouiller


