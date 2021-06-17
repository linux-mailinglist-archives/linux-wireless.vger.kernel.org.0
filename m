Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A03E53AB83F
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:03:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233637AbhFQQGC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:06:02 -0400
Received: from mail-eopbgr140042.outbound.protection.outlook.com ([40.107.14.42]:47438
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233617AbhFQQFv (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:05:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XM6t+I5BCxdQzNpKOi539TS7NZIlEdzRu/5faXUGhYfohdDvr/yKBR9kF/Owup2WpYFHpvLK4QBGAU0RsclIcSWzvKYB32Axzfyrs2K2OTN7ZmlJXHkdZfpIvi1ZVIz4EdJq/SBTMI6l2ySa2EWcxwNKHh+WiAvl+MbvBAh0yOrRUIkRNUVz3TgONCiVcM/Qf6t5eINLupFwmKjLv0U3erPQd8iLr6nVPaX8rxwTb7WrY0owrEzmgALKD31MD7S40c2zotD3w4a5MnRcuViOQYja7HwtylTRI4o4QCJELKPUX1KZ+VsXOeEvRfneytI5wi05EHSNVdkxAZTQRm99ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RZHtsMb4PF9agSqaH31h36z2R7griV8xCe3Ipmo8/xw=;
 b=IgPOHAmz33AIMCWBJ+EG2fKtbtrqIK+aiyOnvxxWlPceBK1oljSBP1IVCSrI2xVWNRaOQ02f1+YPHE/q/UBpBeK3HOpXbM14r0ZcyP5bAfHr5K/WZ6auTDbWhgYGG76YdoC79fkQ4KbVB+wYuGyTm8+Zup8s2xmYiCgv8dt0gQNay8Pg6RSc80QTmndg1hQGZv920qN2r+zs+9+BsR9/dIWtSCg2cxVGzO7Wcd5yDrNHhsEsy7TKKQq9q4oUpDQEq27bMi5hWtZxrT2jF1a97FhsX7E6iAW1TekUOcazy6XKjxYhKm6aE+YLkBLc2eqTxKyaNRG/04dHTy7lLSTyjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RZHtsMb4PF9agSqaH31h36z2R7griV8xCe3Ipmo8/xw=;
 b=XqmJKWhkAC9FAfEUknjG4FXtN5SBf5Jb/LQ1FdTAbPF5AfyuhdPqnM4kLZs+kTQwZe8n/B/tl5LFOTWh7urkJVbwVIZrb6odzCR6/FRLkRaZulkL4BVkCPAgfVYSiV+9s+uJRVTOmnifeNhvuggUT6oj+9CXABrdch+Noru9kMg=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM9P192MB1234.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:388::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.16; Thu, 17 Jun
 2021 16:03:39 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f%4]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 16:03:39 +0000
From:   viktor.barna@celeno.com
To:     linux-wireless@vger.kernel.org
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Aviad Brikman <aviad.brikman@celeno.com>,
        Eliav Farber <eliav.farber@gmail.com>,
        Oleksandr Savchenko <oleksandr.savchenko@celeno.com>,
        Shay Bar <shay.bar@celeno.com>,
        Viktor Barna <viktor.barna@celeno.com>
Subject: [RFC v1 036/256] cl8k: add chandef.c
Date:   Thu, 17 Jun 2021 15:58:43 +0000
Message-Id: <20210617160223.160998-37-viktor.barna@celeno.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210617160223.160998-1-viktor.barna@celeno.com>
References: <20210617160223.160998-1-viktor.barna@celeno.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-Originating-IP: [62.216.42.54]
X-ClientProxiedBy: PR3PR09CA0018.eurprd09.prod.outlook.com
 (2603:10a6:102:b7::23) To AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:38b::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:03:13 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e986aea2-439c-403d-6a14-08d931a96989
X-MS-TrafficTypeDiagnostic: AM9P192MB1234:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM9P192MB12344A4EAEE4707EB1F93D18F60E9@AM9P192MB1234.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9RU7h/sondPh47ORRrESA0zl7IhUoMwoNBUewuCq5McAVnjvkna9/SkelPS4F0NmVGFCrdZfpfxxoZ7zlAsApgAP6w/I/e7fwBQrsjgJOCZOAMeKBxDodxJq4NZW2i6yxR8TwtWWS14nHyGT3B7Nnv8f9Inl3rjDxLnJFimveh3fDj5ChA3E1+qBYyESSjAg7ECNQjRIfJA2+eew8OaYd5NQg4IbkDFeinlcQgP2WqM5q7sYd8hvdlAcwsgnWcvtyhK+LEimnGmqNj30u60ld97LYcOR63VQAlvMVXcnu/PNM0NjtHWZJtUfryaRSx8x25ROZC8TIHg4EdgKfr32XSd3PP+ySgRHpxKzjGIssNp16bASgoDpIUo6+OSDYIFDc5Tpyk8OyDO6gaDeUnS2JXdcfAATqm3ioHK58iQGujuk6JLhXf4TYe9WuQ84FnIj8Emgqm2n8U0fboq9g9EmvAbXVC9NSAf2j+NL7RWpChk9torQft+rTVhTWypBpcp8Kx+3Tm0BK7JbphRB3wPk17fnf5Z9Vhxw6vJEM8xAj6vA/ObAWVrZRH5QdtoWiBQbXUzD/6kE2PSxkWPWWGkBNwmjbZEk+QITHc09Swy3w5OvXs7Ziy9NicQMv3z8W7pQWiQh7HLzTkfZUr9ho500n3tCPIzZyPyBOTpWJ0q5/zTwq5IOh6CRu0l3UnFguRE6hmpdO1FllyiTlV/LYAtqdA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(376002)(366004)(136003)(346002)(396003)(39850400004)(6666004)(107886003)(36756003)(956004)(66476007)(66556008)(2616005)(66946007)(6916009)(2906002)(26005)(9686003)(1076003)(6512007)(6486002)(16526019)(6506007)(38100700002)(52116002)(86362001)(8936002)(316002)(38350700002)(186003)(55236004)(54906003)(8676002)(5660300002)(508600001)(83380400001)(4326008)(69590400013)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?R8aq9dHrDgrAoHS8ctNrSbXvITG9+33cOrQ/cKevH2aZ6f9sULzhUZbX3W1I?=
 =?us-ascii?Q?yzMEjlDSSUD5Jaot0gfAxdAqn3Vj8E/ioTEzJXb49Aag2mKPu1r6QoQrP1iB?=
 =?us-ascii?Q?UD1lHupJytAztrAIxl/EZSTnEI/JP0xBH8QHaQ9e3wf0umyLYW9Gte7aWPwm?=
 =?us-ascii?Q?R/TDXtKWMoZ4li1msPyIBH8/X+1NxNVIvzdRJHwl+H8ateMqLE0oTBUc7Stq?=
 =?us-ascii?Q?ilhk/BVjMTk++Wn9HRuX6dnZihBfvT633m5lLhr0a0kTev5Wg6cg9cf9prO8?=
 =?us-ascii?Q?vGuswHILZYKAUyUhYNc2PHR1q/zC6K1V9OrCyFM9TGD/XVS6RaB/yj8TPQ7S?=
 =?us-ascii?Q?VZJ/iabCew2xfSnTJZ2gks4246UDkjHHlqA9hNk4PsclOtKNlMmz9nGJjqOQ?=
 =?us-ascii?Q?UrCCD6rR2qBa9no51gk0DZx5UfZM0esGl757k8ZN0defQYN+FHJ1XvDGBk8y?=
 =?us-ascii?Q?prHiRHFN9qedncsTbg5W1tTNj0VV6BoFpq0FM6ShCEZ0aDYRyj64THwp2W+Y?=
 =?us-ascii?Q?WswdUCNoQKdaCdNqqherMVv/WPoC/uAz0Z8YdmjPTO42XMOc++/x7fUm/EPd?=
 =?us-ascii?Q?aNvRbGE+mAw71Z6HzquLGt4K3SpxfXMIrxktwNfCUk5doh42qInWKVDCb+Aa?=
 =?us-ascii?Q?XgXVLkBypMK3BbmKhzvJssz3j/Zjqe2gWODdeTtkXb6DmPIXLVhFGdgNJVEe?=
 =?us-ascii?Q?/YHnZFOyM8BaovUI1x2FrciXXkNbW0/XNvv+LK9m/0DgZ2REgNgCKQslgXss?=
 =?us-ascii?Q?pBN/Fzh0cV9Ag/oJa95U+tza7hl0fdlVS9Qzf/wFMRcEq7XN0o8uqsmfea2k?=
 =?us-ascii?Q?tALwPw/DCUQ1SVZuLlDuVy8FBsM53IapmoaljACU0QyI88/0N8CVk6Z1i5Hx?=
 =?us-ascii?Q?zWTXgaAWMg/y3kEfb/jsNjIHSj6jhQi/WptA97+jKEBtPQsm/HV0JmXPS8i+?=
 =?us-ascii?Q?pG+KTSjCb0iC1kISnYsRQPNsCOEujbIQArI2BQ9kmqQZRAO3B5jrYpQV094r?=
 =?us-ascii?Q?Ru7p7PpjWoOsSEfK5tM4/D5dH9O8VJbunY2R69Y3XaNPEHKEe0a2vwf+mrPp?=
 =?us-ascii?Q?XthgrX7raCbIQQpim7HIVC/SK2vd7slsVgBjIjNr0LZDtCvhRskZJz4vY/1t?=
 =?us-ascii?Q?ESvT8j4m+fAD3AgOVjg9O1y3JqpbhmNpqZaFUdNRLZWMTpiW/ulMgjZmwxTJ?=
 =?us-ascii?Q?fxkof6IzaywL+67JqwWzkVDZUiB6kUu3fNx6aN6BFDNTmJPGHvAEoWe8EP7S?=
 =?us-ascii?Q?76m1J8Q99ARGQo+akmYfDS7upwlt1RJUUd4UQH8Ac2VsEvK1eyFqPtWphfeg?=
 =?us-ascii?Q?goZ7hueelAtkDfjIVDe7rTPS?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e986aea2-439c-403d-6a14-08d931a96989
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:03:14.0847
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BTIKz66uw37h5SgKS8jJyVsJi38MfBeimxsr/OMxxIH8yegA/5u0Px9Qd5Gvg6TqxMRWCQvtq+0oPO9bqqgUqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P192MB1234
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 drivers/net/wireless/celeno/cl8k/chandef.c | 152 +++++++++++++++++++++
 1 file changed, 152 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/chandef.c

diff --git a/drivers/net/wireless/celeno/cl8k/chandef.c b/drivers/net/wirel=
ess/celeno/cl8k/chandef.c
new file mode 100644
index 000000000000..61e127386b32
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/chandef.c
@@ -0,0 +1,152 @@
+// SPDX-License-Identifier: MIT
+/* Copyright(c) 2019-2021, Celeno Communications Ltd. */
+
+#include "chandef.h"
+#include "band.h"
+#include "utils/utils.h"
+#include "chip.h"
+
+static int cl_chandef_calc_6g(struct cl_hw *cl_hw, u16 freq, u32 bw, u32 o=
ffset,
+                             u32 *primary, u32 *center)
+{
+       u32 bw_mhz =3D BW_TO_MHZ(bw);
+       u32 min_freq =3D 0;
+
+       if (freq =3D=3D FREQ6G(2)) {
+               min_freq =3D FREQ6G(2);
+       } else if (freq >=3D FREQ6G(1) && freq <=3D FREQ6G(233)) {
+               min_freq =3D FREQ6G(1);
+       } else {
+               cl_dbg_err(cl_hw, "Invalid frequecy - %u\n", freq);
+               return -EINVAL;
+       }
+
+       *primary =3D freq - (freq - min_freq) % 20;
+       *center =3D *primary - (*primary - min_freq) % bw_mhz + offset;
+
+       return 0;
+}
+
+static int cl_chandef_calc_5g(struct cl_hw *cl_hw, u16 freq, u32 bw, u32 o=
ffset,
+                             u32 *primary, u32 *center)
+{
+       u32 bw_mhz =3D BW_TO_MHZ(bw);
+       u32 min_freq =3D 0;
+
+       if ((freq >=3D FREQ5G(36) && freq <=3D FREQ5G(64)) ||
+           (freq >=3D FREQ5G(100) && freq <=3D FREQ5G(144))) {
+               min_freq =3D FREQ5G(36);
+       } else if (freq >=3D FREQ5G(149) && freq <=3D FREQ5G(165)) {
+               min_freq =3D FREQ5G(149);
+       } else {
+               cl_dbg_err(cl_hw, "Invalid frequecy - %u\n", freq);
+               return -EINVAL;
+       }
+
+       *primary =3D freq - (freq - min_freq) % 20;
+       *center =3D *primary - (*primary - min_freq) % bw_mhz + offset;
+
+       return 0;
+}
+
+static int cl_chandef_calc_24g(struct cl_hw *cl_hw, u16 freq, u32 bw, u32 =
offset,
+                              u32 *primary, u32 *center)
+{
+       u32 min_freq =3D 0;
+
+       if (freq < FREQ2G(1) || freq > FREQ2G(14)) {
+               cl_dbg_err(cl_hw, "Invalid frequecy - %u\n", freq);
+               return -EINVAL;
+       }
+
+       min_freq =3D freq < FREQ2G(14) ? FREQ2G(1) : FREQ2G(14);
+       *primary =3D freq - (freq - min_freq) % 5;
+
+       if (bw =3D=3D CHNL_BW_20) {
+               *center =3D *primary;
+       } else {
+               if (freq <=3D FREQ2G(4)) {
+                       /* Above extension channel */
+                       *center =3D *primary + offset;
+               } else if (freq >=3D FREQ2G(10)) {
+                       /* Below extension channel */
+                       *center =3D *primary - offset;
+               } else {
+                       /* Channels 5-9 must be below if channel 13 is not =
supported */
+                       if (!cl_chan_info_get(cl_hw, 13, CHNL_BW_20) &&
+                           /* For Calibration, when using 2.4GHz channels =
on TCV0 to set SX0. */
+                           !cl_chan_info_get(cl_hw->chip->cl_hw_tcv1, 13, =
CHNL_BW_20)) {
+                               *center =3D *primary - offset;
+                       } else {
+                               /* Set below/above according to NVRAM confi=
guration */
+                               if (cl_hw->conf->ce_extension_channel =3D=
=3D -1)
+                                       *center =3D *primary - offset;
+                               else
+                                       *center =3D *primary + offset;
+                       }
+               }
+       }
+
+       return 0;
+}
+
+int cl_chandef_calc(struct cl_hw *cl_hw, u32 channel, u32 bw,
+                   enum nl80211_chan_width *width, u32 *primary, u32 *cent=
er)
+{
+       u16 freq =3D ieee80211_channel_to_frequency(channel, cl_hw->nl_band=
);
+       u32 offset =3D 0;
+       int ret =3D 0;
+
+       switch (bw) {
+       case CHNL_BW_20:
+               offset =3D 0;
+               if (channel =3D=3D 14)
+                       *width =3D NL80211_CHAN_WIDTH_20_NOHT;
+               else
+                       *width =3D NL80211_CHAN_WIDTH_20;
+               break;
+       case CHNL_BW_40:
+               offset =3D 10;
+               *width =3D NL80211_CHAN_WIDTH_40;
+               break;
+       case CHNL_BW_80:
+               if (cl_band_is_24g(cl_hw)) {
+                       cl_dbg_err(cl_hw, "Invalid bandwidth - %u\n", bw);
+                       return -EINVAL;
+               }
+               offset =3D 30;
+               *width =3D NL80211_CHAN_WIDTH_80;
+               break;
+       case CHNL_BW_160:
+               if (cl_band_is_24g(cl_hw)) {
+                       cl_dbg_err(cl_hw, "Invalid bandwidth - %u\n", bw);
+                       return -EINVAL;
+               }
+               offset =3D 70;
+               *width =3D NL80211_CHAN_WIDTH_160;
+               break;
+       default:
+               cl_dbg_err(cl_hw, "Invalid bandwidth - %u\n", bw);
+               return -EINVAL;
+       }
+
+       if (cl_band_is_6g(cl_hw))
+               ret =3D cl_chandef_calc_6g(cl_hw, freq, bw, offset, primary=
, center);
+       else if (cl_band_is_5g(cl_hw))
+               ret =3D cl_chandef_calc_5g(cl_hw, freq, bw, offset, primary=
, center);
+       else
+               ret =3D cl_chandef_calc_24g(cl_hw, freq, bw, offset, primar=
y, center);
+
+       cl_dbg_trace(cl_hw, "primary=3D%u center=3D%u\n", *primary, *center=
);
+
+       return ret;
+}
+
+int cl_chandef_get_default(struct cl_hw *cl_hw, enum nl80211_chan_width *w=
idth,
+                          u32 *primary, u32 *center)
+{
+       u32 bw =3D cl_hw->conf->ce_channel_bandwidth;
+       u32 channel =3D cl_hw->conf->ha_channel;
+
+       return cl_chandef_calc(cl_hw, channel, bw, width, primary, center);
+}
--
2.30.0

________________________________
The information transmitted is intended only for the person or entity to wh=
ich it is addressed and may contain confidential and/or privileged material=
. Any retransmission, dissemination, copying or other use of, or taking of =
any action in reliance upon this information is prohibited. If you received=
 this in error, please contact the sender and delete the material from any =
computer. Nothing contained herein shall be deemed as a representation, war=
ranty or a commitment by Celeno. No warranties are expressed or implied, in=
cluding, but not limited to, any implied warranties of non-infringement, me=
rchantability and fitness for a particular purpose.
________________________________

