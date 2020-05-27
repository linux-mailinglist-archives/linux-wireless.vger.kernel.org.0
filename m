Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EC9C1E451F
	for <lists+linux-wireless@lfdr.de>; Wed, 27 May 2020 16:03:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730320AbgE0ODr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 27 May 2020 10:03:47 -0400
Received: from mail-co1nam11on2044.outbound.protection.outlook.com ([40.107.220.44]:63452
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730263AbgE0ODq (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 27 May 2020 10:03:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z1pbFsCnw/5OcyU0Lu9HMu+thxTFAEKOKqVZ40XNcmIhADTtXiN1e4qcP7tEwnKdCYjhbfinZdCcdzUFKwAQnoVFCVXKnXPs+8mt4YMmuFmfK9wzObn9DQ0PeU/UpKmfZnJbvw8alBcV7eCy/GnxAFOpTDGrn5Ns4hBt1vYMqukb7Pq2JS2vDkf6MKyk/sfZ5Dg2vo6jvMMb+EDMwQ0qFiMktObeXCHhsmeRL2SaMx6lODBpKnmZt4uMCKItbB4q0fUhoI9W8LTNw90Qe+yWoRCT0X70qdqsCoOl9ezJleER/1NMCfFWcByP/rXThj0gTak7oEeaahwgFiacDQcoww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nSybIebyNNEjolRgo0+V05xxJn5UtCRbQhHagkKWD44=;
 b=a+5rz+lWciDdcOwW1ANqmpKwUb5ieodJbw7I1Ua9DmRLk4zTxDFoMaeijWFAbo+dpv3seso7TDyCtKlVqTFW1RYPN134wNPJXalaT/AxanKMnxdiQ3tUgoDqOqaL3HAiFouM9WRgyCy8a4eRCRjqtqDQKG8VncsNNCCpKwsyTz4OVumQnGFnwZW8AqUBxNItiTtebQZRoq218g/tx6wwFsuI/b9iyUnGVjs3rotQq9qReZwak0clpioxCMD6HJwAl9ngNGlfNlovmaiGbTymnSxjOQqdnl0UxzDkc8hfzDVLYsA7iiTngOEXv2fW08wq0F8k0pFlokXa19bTJfGZmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silabs.com; dmarc=pass action=none header.from=silabs.com;
 dkim=pass header.d=silabs.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=silabs.onmicrosoft.com; s=selector2-silabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nSybIebyNNEjolRgo0+V05xxJn5UtCRbQhHagkKWD44=;
 b=SndlfbwVj7saAx6GlAAH1pymmpjJ5uDw3b1qkZiQjZGI9lSMP7D93fqza6Q3D7fCAPPuA66qffqGs3GYStEDLZPsdNVmLwbxKUcXHUljtPWQJs8N4jwuo2IJPnUvBJesMVdWrAGFv2siDYOZR/FZE3hFdUC1T2RRc3JR8/tpsXI=
Authentication-Results: hauke-m.de; dkim=none (message not signed)
 header.d=none;hauke-m.de; dmarc=none action=none header.from=silabs.com;
Received: from SN6PR11MB2718.namprd11.prod.outlook.com (2603:10b6:805:63::18)
 by SN6PR11MB3214.namprd11.prod.outlook.com (2603:10b6:805:c7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.27; Wed, 27 May
 2020 14:03:43 +0000
Received: from SN6PR11MB2718.namprd11.prod.outlook.com
 ([fe80::c504:2d66:a8f7:2336]) by SN6PR11MB2718.namprd11.prod.outlook.com
 ([fe80::c504:2d66:a8f7:2336%7]) with mapi id 15.20.3021.030; Wed, 27 May 2020
 14:03:43 +0000
From:   =?ISO-8859-1?Q?J=E9r=F4me?= Pouiller <jerome.pouiller@silabs.com>
To:     Hauke Mehrtens <hauke@hauke-m.de>
Cc:     johannes.berg@intel.com, ndesaulniers@google.com,
        pihsun@chromium.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH] wireless: Use linux/stddef.h instead of stddef.h
Date:   Wed, 27 May 2020 16:03:38 +0200
Message-ID: <3791715.gBGQRhG51r@pc-42>
Organization: Silicon Labs
In-Reply-To: <d2db65dc-527b-b9a7-45a6-82a4df9cb732@hauke-m.de>
References: <20200521201422.16493-1-hauke@hauke-m.de> <2555103.LUZAIfNjjX@pc-42> <d2db65dc-527b-b9a7-45a6-82a4df9cb732@hauke-m.de>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-ClientProxiedBy: DM5PR19CA0017.namprd19.prod.outlook.com
 (2603:10b6:3:151::27) To SN6PR11MB2718.namprd11.prod.outlook.com
 (2603:10b6:805:63::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pc-42.localnet (2a01:e35:2435:66a0:544b:f17b:7ae8:fb7) by DM5PR19CA0017.namprd19.prod.outlook.com (2603:10b6:3:151::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.17 via Frontend Transport; Wed, 27 May 2020 14:03:42 +0000
X-Originating-IP: [2a01:e35:2435:66a0:544b:f17b:7ae8:fb7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3b476d47-20bd-4b35-c4b6-08d80246c3f9
X-MS-TrafficTypeDiagnostic: SN6PR11MB3214:
X-Microsoft-Antispam-PRVS: <SN6PR11MB3214829827B25106744581F993B10@SN6PR11MB3214.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 04163EF38A
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BGkdQBVRdvfKew+WAkeyW1t9CeSSlWfsSUISUzSCMfkw7r5qTasrsQlzSvkSy2Agkrbw3mxrBtaL4Yr11uiFyj1C9VpA8Zs0FOZGIfk7ZJiayUoKGkkwiKtuxW2W4gMFWiCRvIkl3iTeAFW7zdQhlxGT46vATnVbF9Kbz9aUFo6zZssG1cF2jgxdnSVVxNi4FSE03War4bNdYJRQJJ1NY9n/lRXxDmrk4lcgpiF4OIybdpEnIrVVg5FbAGljfyoAxvFbV3+nNqiy0E/KmvbjbgVORgAv1PQPtAYCG5N4+4ruWKV7JuOispe9QyzGxt/aydytP3i0Ax4HVx6uvv5W7+HB+NvbuqO1fTWqE23rRRAYAWGUiuCLniOYaGjfmcne
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR11MB2718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(39850400004)(366004)(396003)(136003)(346002)(376002)(478600001)(86362001)(66574014)(4326008)(6916009)(316002)(33716001)(2906002)(186003)(6666004)(16526019)(9686003)(6512007)(66946007)(66556008)(66476007)(5660300002)(53546011)(36916002)(6506007)(8936002)(52116002)(6486002)(83380400001)(8676002)(39026012);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: J1mNB5iuK6OCqlUJezNqxap1sojRoiVDpgyROJQw5AyikLKVQofoGsjPsCDauIrQ2NPH+mQ8+/cyEKuntfZp4M/i6JibiCa3NMJD+nAK5iqmIan0UtcgkNkqZLD2LNE7YMLGGF86CgEt45FIayyFzIvgPeaC7tYzoFQo3zsOsfpbYOpf7EwdLWfQt/GK8wPoJ+LW7dcSm1MXW8n/VF5KAmlZV6PyE7qciVxTL8/hqe8sdcWkSJ/kj6NK2d6NBQOqawIYsIfCGnQTEvgGMPp+DVdQJWI77o006HxrxDF5CcTsULJG5P+ugxqN/fxTrGZxLwtckG/Ffu7Q5D4Mo7xSm0Wvha473zGxjrOo5Jvye1msK6wePGkg4mc9T1B1u/UkbnKo3z7qpcxPsHWucq4NVid9opy37/soar5cyasXihv6m1RhLY2lt22Z9nPKfIFJhwCCMIMdZulhH/v8z4lGDL+uyLWRno8G0vYdlxOBhXiMjJgyum5+/Uj4F9GyFx3HCHoNSR+laCt14iq27U3UDc/kBUQhOxJTGCXZUR5kVTw=
X-OriginatorOrg: silabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b476d47-20bd-4b35-c4b6-08d80246c3f9
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2020 14:03:43.4495
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 54dbd822-5231-4b20-944d-6f4abcd541fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e3iCK/yX8DljrY60JSijThVDUn0B1SFOOfVz4X8Cz2OBsbRK5FvMxyG141X9WSlK1W7Q90um26q9Ey4V7eWiFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB3214
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tuesday 26 May 2020 23:02:56 CEST Hauke Mehrtens wrote:
> On 5/25/20 11:35 AM, J=E9r=F4me Pouiller wrote:
> > On Thursday 21 May 2020 22:14:22 CEST Hauke Mehrtens wrote:
> >> When compiling inside the kernel include linux/stddef.h instead of
> >> stddef.h. When I compile this header file in backports for power PC I
> >> run into a conflict with ptrdiff_t. I was unable to reproduce this in
> >> mainline kernel. I still would like to fix this problem in the kernel.
> >>
> >> Fixes: 6989310f5d43 ("wireless: Use offsetof instead of custom macro."=
)
> >> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
> >> ---
> >>  include/uapi/linux/wireless.h | 6 +++++-
> >>  1 file changed, 5 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/include/uapi/linux/wireless.h b/include/uapi/linux/wirele=
ss.h
> >> index a2c006a364e0..24f3371ad826 100644
> >> --- a/include/uapi/linux/wireless.h
> >> +++ b/include/uapi/linux/wireless.h
> >> @@ -74,7 +74,11 @@
> >>  #include <linux/socket.h>              /* for "struct sockaddr" et al=
  */
> >>  #include <linux/if.h>                  /* for IFNAMSIZ and co... */
> >>
> >> -#include <stddef.h>                     /* for offsetof */
> >> +#ifdef __KERNEL__
> >> +#      include <linux/stddef.h>        /* for offsetof */
> >> +#else
> >> +#      include <stddef.h>              /* for offsetof */
> >> +#endif
> >=20
> > Hello,
> >=20
> > This patch also solves a warning I encountered when I launched sparse
> > (with make C=3D1):
> >=20
> >   /usr/lib/gcc-cross/arm-linux-gnueabihf/9/include/stddef.h:406:9: warn=
ing: preprocessor token offsetof redefined
> >   ./include/linux/stddef.h:17:9: this was the original definition
> >=20
> > However, I wonder if it useful to keep 'include <stddef.h>' when this f=
ile
> > is included from userspace. If it does not compile anymore, there is
> > problem somewhere else, no?
> >=20
> > (Globally, I always find suspicious a kernel source that includes a sys=
tem
> > header)
> Hi,
>=20
> The wireless.h makes use of offsetof and this is defined in system
> stddef.h and in include/linux/stddef.h. When we only include
> linux/stddef.h it will work fine when compiled inside the kernel, but it
> could cause problems when used in user space, because this would include
> ./include/uapi/linux/stddef.h which does not define offsetof.
>=20
> I think we need the #ifdef __KERNEL__ to make this work in the kernel
> and in the user space.

In this case, maybe the problem should be resolved directly in
uapi/linux/stddef.h?

I have found other headers that use offsetof and may have the same problem
(currently, they do not include stddef.h. So, some of the macros do not
compile):
   - include/uapi/linux/fuse.h
   - include/uapi/linux/genwqe/genwqe_card.h
   - include/uapi/linux/gfs2_ondisk.h

--=20
J=E9r=F4me Pouiller


