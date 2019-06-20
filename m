Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A3654CE1E
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Jun 2019 15:02:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731813AbfFTNCC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 20 Jun 2019 09:02:02 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:36089 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731801AbfFTNCC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 20 Jun 2019 09:02:02 -0400
Received: by mail-ed1-f65.google.com with SMTP id k21so4635754edq.3
        for <linux-wireless@vger.kernel.org>; Thu, 20 Jun 2019 06:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=9Z+CvZsqpVkrxR9FPiS+noylnD7W5evdDbcv4M6uF+I=;
        b=bjZvRHp9276V1UrLNoSgligD2+YpYUVhbpc1cKOhAuETi6ZKylt71qRSE+DdJSw0w9
         hN5myaErksbtNnv9MlyT0AkEpZVttVYLkc/Up6Un9MirmIVTgvhI6bodbtiMJv3v0QLO
         0gFcFuEs/I96pLYdRvFY1+xJuWTz8N0cWTpbYyHAHYPjEFqpYIegrTFA4L1UhS9wwlDN
         skj4ZJPkDOjzLlUW1huGZrdyLWgivdQ/aDMMz3W2ufOBrmNr/P63tluEQ6iRBBmfbGwo
         q0k2ijYbZMQxcL7cKIRZo/SNDmj3BXVxAVoanp7zvHQpQHya15l5O5fOQN43/45fdCXQ
         nY0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=9Z+CvZsqpVkrxR9FPiS+noylnD7W5evdDbcv4M6uF+I=;
        b=MkFoc+BuD/xweZcVqeQGMYqYqoEnrXWdZYyJG4fOUJNh/no0xYjezQKO3r9f3W23Jr
         eq5aJQD+KO4auptq/pqciPecGeXs3N8nN0jw0JnamcSadWb0+78Iwg0mTSNaDI+Ezvd3
         H1muBvBpu180/fx3Z9EGPGAsPViai3fDGoVL9e0pIW9LE1bkHsOdTxBrMswAzazr1Rn1
         Rk+3Pxy0ReuM8rYUiXTcxlun+4LiDaWr5BwaQNfjopLAkn4LbnV/5RlcAN8ZKl/IU+Jy
         NdwrJo13gsyFD3elOkS6n4MmMW92LqwFLecnZt0+ZJ3RoEQpndq3lh+8O5u6ALE+jx5G
         lK4w==
X-Gm-Message-State: APjAAAWS5NmX6yqLyN+dHSoFNfmi+eA0R+Uf/kmbufpDAhwRfJ7cFePP
        gsQum4ZK8JhVjUql205UHs+/aqHd
X-Google-Smtp-Source: APXvYqz0d7FXxHmf5JTs7vt3NSd/1myczInO28W7Cxz7ePdodE635ob0QyZh0OxPVoddbcN0/rqIrQ==
X-Received: by 2002:a50:95ae:: with SMTP id w43mr110651581eda.115.1561035719428;
        Thu, 20 Jun 2019 06:01:59 -0700 (PDT)
Received: from development1.visionsystems.de (mail.visionsystems.de. [213.209.99.202])
        by smtp.gmail.com with ESMTPSA id h10sm6498562ede.93.2019.06.20.06.01.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Jun 2019 06:01:58 -0700 (PDT)
From:   yegorslists@googlemail.com
To:     linux-wireless@vger.kernel.org
Cc:     johannes@sipsolutions.net,
        Yegor Yefremov <yegorslists@googlemail.com>
Subject: [PATCH] Add SPDX identifiers
Date:   Thu, 20 Jun 2019 15:01:48 +0200
Message-Id: <20190620130148.1674-1-yegorslists@googlemail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Yegor Yefremov <yegorslists@googlemail.com>

Software Package Data Exchange identifiers help to detect source file
licenses and hence simplify the FOSS compliance process.

Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>
---
 ap.c           | 2 ++
 bitrate.c      | 2 ++
 bloom.c        | 2 ++
 coalesce.c     | 2 ++
 connect.c      | 2 ++
 cqm.c          | 2 ++
 event.c        | 2 ++
 ftm.c          | 2 ++
 genl.c         | 2 ++
 hwsim.c        | 2 ++
 ibss.c         | 2 ++
 ieee80211.h    | 2 ++
 info.c         | 2 ++
 interface.c    | 2 ++
 iw.c           | 2 ++
 iw.h           | 2 ++
 link.c         | 2 ++
 measurements.c | 2 ++
 mesh.c         | 2 ++
 mgmt.c         | 2 ++
 mpath.c        | 2 ++
 mpp.c          | 2 ++
 nan.c          | 2 ++
 nl80211.h      | 2 ++
 ocb.c          | 2 ++
 offch.c        | 2 ++
 p2p.c          | 2 ++
 phy.c          | 2 ++
 ps.c           | 2 ++
 reason.c       | 2 ++
 reg.c          | 2 ++
 roc.c          | 2 ++
 scan.c         | 2 ++
 sections.c     | 2 ++
 sha256.c       | 2 ++
 sha256.h       | 2 ++
 station.c      | 2 ++
 status.c       | 2 ++
 survey.c       | 2 ++
 util.c         | 2 ++
 vendor.c       | 2 ++
 wowlan.c       | 2 ++
 42 files changed, 84 insertions(+)

diff --git a/ap.c b/ap.c
index db9efb7..4b9157a 100644
--- a/ap.c
+++ b/ap.c
@@ -1,3 +1,5 @@
+/* SPDX-License-Identifier: ISC */
+
 #include <errno.h>
 #include <netlink/genl/genl.h>
 #include <netlink/genl/family.h>
diff --git a/bitrate.c b/bitrate.c
index 4a026a4..c0ff319 100644
--- a/bitrate.c
+++ b/bitrate.c
@@ -1,3 +1,5 @@
+/* SPDX-License-Identifier: ISC */
+
 #include <errno.h>
 
 #include "nl80211.h"
diff --git a/bloom.c b/bloom.c
index 877a6b5..f697b94 100644
--- a/bloom.c
+++ b/bloom.c
@@ -1,3 +1,5 @@
+/* SPDX-License-Identifier: ISC */
+
 #include <inttypes.h>
 #include "iw.h"
 
diff --git a/coalesce.c b/coalesce.c
index 36dcaef..f3826ca 100644
--- a/coalesce.c
+++ b/coalesce.c
@@ -1,3 +1,5 @@
+/* SPDX-License-Identifier: ISC */
+
 #include <errno.h>
 #include <string.h>
 #include <stdio.h>
diff --git a/connect.c b/connect.c
index 3237a27..a486d21 100644
--- a/connect.c
+++ b/connect.c
@@ -1,3 +1,5 @@
+/* SPDX-License-Identifier: ISC */
+
 #include <errno.h>
 
 #include <netlink/genl/genl.h>
diff --git a/cqm.c b/cqm.c
index 093b744..4e2e846 100644
--- a/cqm.c
+++ b/cqm.c
@@ -1,3 +1,5 @@
+/* SPDX-License-Identifier: ISC */
+
 #include <errno.h>
 
 #include <netlink/genl/genl.h>
diff --git a/event.c b/event.c
index 100f644..a8b4611 100644
--- a/event.c
+++ b/event.c
@@ -1,3 +1,5 @@
+/* SPDX-License-Identifier: ISC */
+
 #include <stdint.h>
 #include <stdbool.h>
 #include <net/if.h>
diff --git a/ftm.c b/ftm.c
index 23be38e..03eaf38 100644
--- a/ftm.c
+++ b/ftm.c
@@ -1,3 +1,5 @@
+/* SPDX-License-Identifier: ISC */
+
 #include <errno.h>
 
 #include <netlink/genl/genl.h>
diff --git a/genl.c b/genl.c
index 7dc27f7..f8dbac3 100644
--- a/genl.c
+++ b/genl.c
@@ -1,3 +1,5 @@
+/* SPDX-License-Identifier: ISC */
+
 /*
  * This ought to be provided by libnl
  */
diff --git a/hwsim.c b/hwsim.c
index 6f82207..fbfaed3 100644
--- a/hwsim.c
+++ b/hwsim.c
@@ -1,3 +1,5 @@
+/* SPDX-License-Identifier: ISC */
+
 #include <errno.h>
 #include <string.h>
 
diff --git a/ibss.c b/ibss.c
index f6cbc4c..645639e 100644
--- a/ibss.c
+++ b/ibss.c
@@ -1,3 +1,5 @@
+/* SPDX-License-Identifier: ISC */
+
 #include <errno.h>
 #include <string.h>
 #include <strings.h>
diff --git a/ieee80211.h b/ieee80211.h
index 8745608..0a7e205 100644
--- a/ieee80211.h
+++ b/ieee80211.h
@@ -1,3 +1,5 @@
+/* SPDX-License-Identifier: ISC */
+
 #ifndef __IEEE80211
 #define __IEEE80211
 
diff --git a/info.c b/info.c
index e6270c8..fc0361d 100644
--- a/info.c
+++ b/info.c
@@ -1,3 +1,5 @@
+/* SPDX-License-Identifier: ISC */
+
 #include <stdbool.h>
 
 #include <netlink/genl/genl.h>
diff --git a/interface.c b/interface.c
index b697482..de5546b 100644
--- a/interface.c
+++ b/interface.c
@@ -1,3 +1,5 @@
+/* SPDX-License-Identifier: ISC */
+
 #include <errno.h>
 #include <string.h>
 #include <stdbool.h>
diff --git a/iw.c b/iw.c
index da71617..5bb22c4 100644
--- a/iw.c
+++ b/iw.c
@@ -1,3 +1,5 @@
+/* SPDX-License-Identifier: ISC */
+
 /*
  * nl80211 userspace tool
  *
diff --git a/iw.h b/iw.h
index bc0b3ac..ea7bd6c 100644
--- a/iw.h
+++ b/iw.h
@@ -1,3 +1,5 @@
+/* SPDX-License-Identifier: ISC */
+
 #ifndef __IW_H
 #define __IW_H
 
diff --git a/link.c b/link.c
index 1ed7f63..4e73279 100644
--- a/link.c
+++ b/link.c
@@ -1,3 +1,5 @@
+/* SPDX-License-Identifier: ISC */
+
 #include <net/if.h>
 #include <errno.h>
 #include <string.h>
diff --git a/measurements.c b/measurements.c
index 385143f..54ca402 100644
--- a/measurements.c
+++ b/measurements.c
@@ -1,3 +1,5 @@
+/* SPDX-License-Identifier: ISC */
+
 #include <errno.h>
 
 #include "nl80211.h"
diff --git a/mesh.c b/mesh.c
index 0650d0c..2591a4b 100644
--- a/mesh.c
+++ b/mesh.c
@@ -1,3 +1,5 @@
+/* SPDX-License-Identifier: ISC */
+
 #include <errno.h>
 #include <string.h>
 
diff --git a/mgmt.c b/mgmt.c
index 338435d..8639f9c 100644
--- a/mgmt.c
+++ b/mgmt.c
@@ -1,3 +1,5 @@
+/* SPDX-License-Identifier: ISC */
+
 #include <string.h>
 #include <errno.h>
 
diff --git a/mpath.c b/mpath.c
index e39c24b..3cb465b 100644
--- a/mpath.c
+++ b/mpath.c
@@ -1,3 +1,5 @@
+/* SPDX-License-Identifier: ISC */
+
 #include <net/if.h>
 #include <errno.h>
 #include <string.h>
diff --git a/mpp.c b/mpp.c
index 58bf28e..23193a4 100644
--- a/mpp.c
+++ b/mpp.c
@@ -1,3 +1,5 @@
+/* SPDX-License-Identifier: ISC */
+
 #include <net/if.h>
 #include <errno.h>
 
diff --git a/nan.c b/nan.c
index 1d8d795..a846b68 100644
--- a/nan.c
+++ b/nan.c
@@ -1,3 +1,5 @@
+/* SPDX-License-Identifier: ISC */
+
 #include <net/if.h>
 #include <errno.h>
 #include <string.h>
diff --git a/nl80211.h b/nl80211.h
index 6f09d15..750b116 100644
--- a/nl80211.h
+++ b/nl80211.h
@@ -1,3 +1,5 @@
+/* SPDX-License-Identifier: ISC */
+
 #ifndef __LINUX_NL80211_H
 #define __LINUX_NL80211_H
 /*
diff --git a/ocb.c b/ocb.c
index fc9579b..1678e49 100644
--- a/ocb.c
+++ b/ocb.c
@@ -1,3 +1,5 @@
+/* SPDX-License-Identifier: ISC */
+
 #include <errno.h>
 #include <string.h>
 
diff --git a/offch.c b/offch.c
index 19e170e..684eea3 100644
--- a/offch.c
+++ b/offch.c
@@ -1,3 +1,5 @@
+/* SPDX-License-Identifier: ISC */
+
 #include <errno.h>
 
 #include <netlink/genl/genl.h>
diff --git a/p2p.c b/p2p.c
index 2d4bab0..1d12046 100644
--- a/p2p.c
+++ b/p2p.c
@@ -1,3 +1,5 @@
+/* SPDX-License-Identifier: ISC */
+
 #include <netlink/genl/genl.h>
 #include <netlink/genl/family.h>
 #include <netlink/genl/ctrl.h>
diff --git a/phy.c b/phy.c
index 716677e..a5159c7 100644
--- a/phy.c
+++ b/phy.c
@@ -1,3 +1,5 @@
+/* SPDX-License-Identifier: ISC */
+
 #include <stdbool.h>
 #include <errno.h>
 #include <strings.h>
diff --git a/ps.c b/ps.c
index de36d2b..67f7a38 100644
--- a/ps.c
+++ b/ps.c
@@ -1,3 +1,5 @@
+/* SPDX-License-Identifier: ISC */
+
 #include <errno.h>
 #include <string.h>
 
diff --git a/reason.c b/reason.c
index f91c681..74f516b 100644
--- a/reason.c
+++ b/reason.c
@@ -1,3 +1,5 @@
+/* SPDX-License-Identifier: ISC */
+
 #include <stdint.h>
 #include "iw.h"
 
diff --git a/reg.c b/reg.c
index a2368df..7a83df2 100644
--- a/reg.c
+++ b/reg.c
@@ -1,3 +1,5 @@
+/* SPDX-License-Identifier: ISC */
+
 #include <errno.h>
 #include <string.h>
 #include <stdbool.h>
diff --git a/roc.c b/roc.c
index c6eda10..a159487 100644
--- a/roc.c
+++ b/roc.c
@@ -1,3 +1,5 @@
+/* SPDX-License-Identifier: ISC */
+
 #include <errno.h>
 #include <string.h>
 
diff --git a/scan.c b/scan.c
index 6ad3ad4..1993f0b 100644
--- a/scan.c
+++ b/scan.c
@@ -1,3 +1,5 @@
+/* SPDX-License-Identifier: ISC */
+
 #include <net/if.h>
 #include <errno.h>
 #include <string.h>
diff --git a/sections.c b/sections.c
index 38095f6..3b0ec8b 100644
--- a/sections.c
+++ b/sections.c
@@ -1,3 +1,5 @@
+/* SPDX-License-Identifier: ISC */
+
 #include "iw.h"
 
 SECTION(get);
diff --git a/sha256.c b/sha256.c
index 4a43df8..da9d967 100644
--- a/sha256.c
+++ b/sha256.c
@@ -1,3 +1,5 @@
+/* SPDX-License-Identifier: ISC */
+
 #include "sha256.h"
 
 /**
diff --git a/sha256.h b/sha256.h
index d3eb3c0..4a32604 100644
--- a/sha256.h
+++ b/sha256.h
@@ -1,3 +1,5 @@
+/* SPDX-License-Identifier: ISC */
+
 #ifndef SHA256
 #define SHA256
 
diff --git a/station.c b/station.c
index aaad079..d8f0ae3 100644
--- a/station.c
+++ b/station.c
@@ -1,3 +1,5 @@
+/* SPDX-License-Identifier: ISC */
+
 #include <net/if.h>
 #include <errno.h>
 #include <string.h>
diff --git a/status.c b/status.c
index 731727d..7529021 100644
--- a/status.c
+++ b/status.c
@@ -1,3 +1,5 @@
+/* SPDX-License-Identifier: ISC */
+
 #include <stdint.h>
 #include "iw.h"
 
diff --git a/survey.c b/survey.c
index 9325353..ffaf85a 100644
--- a/survey.c
+++ b/survey.c
@@ -1,3 +1,5 @@
+/* SPDX-License-Identifier: ISC */
+
 #include <net/if.h>
 
 #include <netlink/genl/genl.h>
diff --git a/util.c b/util.c
index 41277b5..55993c7 100644
--- a/util.c
+++ b/util.c
@@ -1,3 +1,5 @@
+/* SPDX-License-Identifier: ISC */
+
 #include <ctype.h>
 #include <netlink/attr.h>
 #include <errno.h>
diff --git a/vendor.c b/vendor.c
index d203d85..7610354 100644
--- a/vendor.c
+++ b/vendor.c
@@ -1,3 +1,5 @@
+/* SPDX-License-Identifier: ISC */
+
 #include <errno.h>
 #include <string.h>
 
diff --git a/wowlan.c b/wowlan.c
index 778c0db..71392d1 100644
--- a/wowlan.c
+++ b/wowlan.c
@@ -1,3 +1,5 @@
+/* SPDX-License-Identifier: ISC */
+
 #include <errno.h>
 #include <string.h>
 #include <stdio.h>
-- 
2.17.0

