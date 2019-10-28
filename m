Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 04226E778F
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Oct 2019 18:24:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731875AbfJ1RYr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 28 Oct 2019 13:24:47 -0400
Received: from alexa-out-ams-02.qualcomm.com ([185.23.61.163]:8562 "EHLO
        alexa-out-ams-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730402AbfJ1RYr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 28 Oct 2019 13:24:47 -0400
Received: from ironmsg01-ams.qualcomm.com ([10.251.56.2])
  by alexa-out-ams-02.qualcomm.com with ESMTP; 28 Oct 2019 18:24:41 +0100
IronPort-SDR: 9sRmY7UQhCl+jEfOFGc5eNacSBTtUwdVjSAu3/9qK7uK//WdHzxFSNXmJv4FHRQfpxHe4Y+AqO
 +fHu+qS3kC+C7hDWiG7RRkiDf9KRc6TNM=
Received: from lx-merez1.mea.qualcomm.com ([10.18.173.103])
  by ironmsg01-ams.qualcomm.com with ESMTP; 28 Oct 2019 18:24:41 +0100
From:   Maya Erez <merez@codeaurora.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Lior David <liord@codeaurora.org>, linux-wireless@vger.kernel.org,
        wil6210@qti.qualcomm.com, Maya Erez <merez@codeaurora.org>
Subject: [PATCH v2] wil6210: add SPDX license identifiers
Date:   Mon, 28 Oct 2019 19:24:37 +0200
Message-Id: <1572283477-22976-1-git-send-email-merez@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Lior David <liord@codeaurora.org>

Change all files to add SPDX license identifiers and
remove license text.
This is only an administrative change, there is no change
in actual license or copyright for any file.

Signed-off-by: Lior David <liord@codeaurora.org>
Signed-off-by: Maya Erez <merez@codeaurora.org>
---
 drivers/net/wireless/ath/wil6210/boot_loader.h    | 13 +------------
 drivers/net/wireless/ath/wil6210/cfg80211.c       | 13 +------------
 drivers/net/wireless/ath/wil6210/debug.c          | 13 +------------
 drivers/net/wireless/ath/wil6210/debugfs.c        | 13 +------------
 drivers/net/wireless/ath/wil6210/ethtool.c        | 13 +------------
 drivers/net/wireless/ath/wil6210/fw.c             | 13 +------------
 drivers/net/wireless/ath/wil6210/fw.h             | 13 +------------
 drivers/net/wireless/ath/wil6210/fw_inc.c         | 13 +------------
 drivers/net/wireless/ath/wil6210/interrupt.c      | 13 +------------
 drivers/net/wireless/ath/wil6210/main.c           | 13 +------------
 drivers/net/wireless/ath/wil6210/netdev.c         | 13 +------------
 drivers/net/wireless/ath/wil6210/p2p.c            | 13 +------------
 drivers/net/wireless/ath/wil6210/pcie_bus.c       | 13 +------------
 drivers/net/wireless/ath/wil6210/pm.c             | 13 +------------
 drivers/net/wireless/ath/wil6210/pmc.c            | 13 +------------
 drivers/net/wireless/ath/wil6210/pmc.h            | 17 ++---------------
 drivers/net/wireless/ath/wil6210/rx_reorder.c     | 13 +------------
 drivers/net/wireless/ath/wil6210/trace.c          | 13 +------------
 drivers/net/wireless/ath/wil6210/trace.h          | 13 +------------
 drivers/net/wireless/ath/wil6210/txrx.c           | 13 +------------
 drivers/net/wireless/ath/wil6210/txrx.h           | 13 +------------
 drivers/net/wireless/ath/wil6210/txrx_edma.c      | 13 +------------
 drivers/net/wireless/ath/wil6210/txrx_edma.h      | 13 +------------
 drivers/net/wireless/ath/wil6210/wil6210.h        | 13 +------------
 drivers/net/wireless/ath/wil6210/wil_crash_dump.c | 13 +------------
 drivers/net/wireless/ath/wil6210/wil_platform.c   | 15 ++-------------
 drivers/net/wireless/ath/wil6210/wil_platform.h   | 13 +------------
 drivers/net/wireless/ath/wil6210/wmi.c            | 13 +------------
 drivers/net/wireless/ath/wil6210/wmi.h            | 13 +------------
 29 files changed, 31 insertions(+), 352 deletions(-)

diff --git a/drivers/net/wireless/ath/wil6210/boot_loader.h b/drivers/net/wireless/ath/wil6210/boot_loader.h
index d32c1f4..a8a43c2 100644
--- a/drivers/net/wireless/ath/wil6210/boot_loader.h
+++ b/drivers/net/wireless/ath/wil6210/boot_loader.h
@@ -1,17 +1,6 @@
+/* SPDX-License-Identifier: ISC */
 /* Copyright (c) 2015 Qualcomm Atheros, Inc.
  * Copyright (c) 2018, The Linux Foundation. All rights reserved.
- *
- * Permission to use, copy, modify, and/or distribute this software for any
- * purpose with or without fee is hereby granted, provided that the above
- * copyright notice and this permission notice appear in all copies.
- *
- * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
- * WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
- * MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
- * ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
- * WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
- * ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
- * OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
  */
 
 /* This file contains the definitions for the boot loader
diff --git a/drivers/net/wireless/ath/wil6210/cfg80211.c b/drivers/net/wireless/ath/wil6210/cfg80211.c
index c70854e..7d6f1442 100644
--- a/drivers/net/wireless/ath/wil6210/cfg80211.c
+++ b/drivers/net/wireless/ath/wil6210/cfg80211.c
@@ -1,18 +1,7 @@
+// SPDX-License-Identifier: ISC
 /*
  * Copyright (c) 2012-2017 Qualcomm Atheros, Inc.
  * Copyright (c) 2018-2019, The Linux Foundation. All rights reserved.
- *
- * Permission to use, copy, modify, and/or distribute this software for any
- * purpose with or without fee is hereby granted, provided that the above
- * copyright notice and this permission notice appear in all copies.
- *
- * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
- * WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
- * MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
- * ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
- * WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
- * ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
- * OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
  */
 
 #include <linux/etherdevice.h>
diff --git a/drivers/net/wireless/ath/wil6210/debug.c b/drivers/net/wireless/ath/wil6210/debug.c
index a9befb9..396c94c 100644
--- a/drivers/net/wireless/ath/wil6210/debug.c
+++ b/drivers/net/wireless/ath/wil6210/debug.c
@@ -1,18 +1,7 @@
+// SPDX-License-Identifier: ISC
 /*
  * Copyright (c) 2013,2016 Qualcomm Atheros, Inc.
  * Copyright (c) 2018, The Linux Foundation. All rights reserved.
- *
- * Permission to use, copy, modify, and/or distribute this software for any
- * purpose with or without fee is hereby granted, provided that the above
- * copyright notice and this permission notice appear in all copies.
- *
- * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
- * WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
- * MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
- * ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
- * WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
- * ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
- * OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
  */
 
 #include "wil6210.h"
diff --git a/drivers/net/wireless/ath/wil6210/debugfs.c b/drivers/net/wireless/ath/wil6210/debugfs.c
index 304b4d4..11d0c79 100644
--- a/drivers/net/wireless/ath/wil6210/debugfs.c
+++ b/drivers/net/wireless/ath/wil6210/debugfs.c
@@ -1,18 +1,7 @@
+// SPDX-License-Identifier: ISC
 /*
  * Copyright (c) 2012-2017 Qualcomm Atheros, Inc.
  * Copyright (c) 2018-2019, The Linux Foundation. All rights reserved.
- *
- * Permission to use, copy, modify, and/or distribute this software for any
- * purpose with or without fee is hereby granted, provided that the above
- * copyright notice and this permission notice appear in all copies.
- *
- * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
- * WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
- * MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
- * ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
- * WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
- * ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
- * OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
  */
 
 #include <linux/module.h>
diff --git a/drivers/net/wireless/ath/wil6210/ethtool.c b/drivers/net/wireless/ath/wil6210/ethtool.c
index a04c87f..912c4ea 100644
--- a/drivers/net/wireless/ath/wil6210/ethtool.c
+++ b/drivers/net/wireless/ath/wil6210/ethtool.c
@@ -1,18 +1,7 @@
+// SPDX-License-Identifier: ISC
 /*
  * Copyright (c) 2014,2017 Qualcomm Atheros, Inc.
  * Copyright (c) 2018, The Linux Foundation. All rights reserved.
- *
- * Permission to use, copy, modify, and/or distribute this software for any
- * purpose with or without fee is hereby granted, provided that the above
- * copyright notice and this permission notice appear in all copies.
- *
- * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
- * WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
- * MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
- * ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
- * WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
- * ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
- * OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
  */
 
 #include <linux/etherdevice.h>
diff --git a/drivers/net/wireless/ath/wil6210/fw.c b/drivers/net/wireless/ath/wil6210/fw.c
index 3e2bbbc..6d3413a4 100644
--- a/drivers/net/wireless/ath/wil6210/fw.c
+++ b/drivers/net/wireless/ath/wil6210/fw.c
@@ -1,18 +1,7 @@
+// SPDX-License-Identifier: ISC
 /*
  * Copyright (c) 2014-2015,2017 Qualcomm Atheros, Inc.
  * Copyright (c) 2018, The Linux Foundation. All rights reserved.
- *
- * Permission to use, copy, modify, and/or distribute this software for any
- * purpose with or without fee is hereby granted, provided that the above
- * copyright notice and this permission notice appear in all copies.
- *
- * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
- * WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
- * MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
- * ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
- * WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
- * ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
- * OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
  */
 #include <linux/firmware.h>
 #include <linux/module.h>
diff --git a/drivers/net/wireless/ath/wil6210/fw.h b/drivers/net/wireless/ath/wil6210/fw.h
index fa31647..540fa16 100644
--- a/drivers/net/wireless/ath/wil6210/fw.h
+++ b/drivers/net/wireless/ath/wil6210/fw.h
@@ -1,18 +1,7 @@
+/* SPDX-License-Identifier: ISC */
 /*
  * Copyright (c) 2014,2016 Qualcomm Atheros, Inc.
  * Copyright (c) 2018-2019, The Linux Foundation. All rights reserved.
- *
- * Permission to use, copy, modify, and/or distribute this software for any
- * purpose with or without fee is hereby granted, provided that the above
- * copyright notice and this permission notice appear in all copies.
- *
- * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
- * WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
- * MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
- * ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
- * WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
- * ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
- * OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
  */
 #ifndef __WIL_FW_H__
 #define __WIL_FW_H__
diff --git a/drivers/net/wireless/ath/wil6210/fw_inc.c b/drivers/net/wireless/ath/wil6210/fw_inc.c
index 94ebfa3..fbc84c0 100644
--- a/drivers/net/wireless/ath/wil6210/fw_inc.c
+++ b/drivers/net/wireless/ath/wil6210/fw_inc.c
@@ -1,18 +1,7 @@
+// SPDX-License-Identifier: ISC
 /*
  * Copyright (c) 2014-2017 Qualcomm Atheros, Inc.
  * Copyright (c) 2018-2019, The Linux Foundation. All rights reserved.
- *
- * Permission to use, copy, modify, and/or distribute this software for any
- * purpose with or without fee is hereby granted, provided that the above
- * copyright notice and this permission notice appear in all copies.
- *
- * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
- * WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
- * MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
- * ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
- * WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
- * ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
- * OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
  */
 
 /* Algorithmic part of the firmware download.
diff --git a/drivers/net/wireless/ath/wil6210/interrupt.c b/drivers/net/wireless/ath/wil6210/interrupt.c
index b00a13d..b1480b4 100644
--- a/drivers/net/wireless/ath/wil6210/interrupt.c
+++ b/drivers/net/wireless/ath/wil6210/interrupt.c
@@ -1,18 +1,7 @@
+// SPDX-License-Identifier: ISC
 /*
  * Copyright (c) 2012-2017 Qualcomm Atheros, Inc.
  * Copyright (c) 2018-2019, The Linux Foundation. All rights reserved.
- *
- * Permission to use, copy, modify, and/or distribute this software for any
- * purpose with or without fee is hereby granted, provided that the above
- * copyright notice and this permission notice appear in all copies.
- *
- * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
- * WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
- * MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
- * ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
- * WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
- * ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
- * OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
  */
 
 #include <linux/interrupt.h>
diff --git a/drivers/net/wireless/ath/wil6210/main.c b/drivers/net/wireless/ath/wil6210/main.c
index 9b72202..06091d8a 100644
--- a/drivers/net/wireless/ath/wil6210/main.c
+++ b/drivers/net/wireless/ath/wil6210/main.c
@@ -1,18 +1,7 @@
+// SPDX-License-Identifier: ISC
 /*
  * Copyright (c) 2012-2017 Qualcomm Atheros, Inc.
  * Copyright (c) 2018-2019, The Linux Foundation. All rights reserved.
- *
- * Permission to use, copy, modify, and/or distribute this software for any
- * purpose with or without fee is hereby granted, provided that the above
- * copyright notice and this permission notice appear in all copies.
- *
- * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
- * WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
- * MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
- * ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
- * WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
- * ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
- * OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
  */
 
 #include <linux/moduleparam.h>
diff --git a/drivers/net/wireless/ath/wil6210/netdev.c b/drivers/net/wireless/ath/wil6210/netdev.c
index a87bb84..07b4a25 100644
--- a/drivers/net/wireless/ath/wil6210/netdev.c
+++ b/drivers/net/wireless/ath/wil6210/netdev.c
@@ -1,18 +1,7 @@
+// SPDX-License-Identifier: ISC
 /*
  * Copyright (c) 2012-2017 Qualcomm Atheros, Inc.
  * Copyright (c) 2018-2019, The Linux Foundation. All rights reserved.
- *
- * Permission to use, copy, modify, and/or distribute this software for any
- * purpose with or without fee is hereby granted, provided that the above
- * copyright notice and this permission notice appear in all copies.
- *
- * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
- * WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
- * MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
- * ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
- * WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
- * ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
- * OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
  */
 
 #include <linux/etherdevice.h>
diff --git a/drivers/net/wireless/ath/wil6210/p2p.c b/drivers/net/wireless/ath/wil6210/p2p.c
index db087ea..f26bf04 100644
--- a/drivers/net/wireless/ath/wil6210/p2p.c
+++ b/drivers/net/wireless/ath/wil6210/p2p.c
@@ -1,18 +1,7 @@
+// SPDX-License-Identifier: ISC
 /*
  * Copyright (c) 2014-2017 Qualcomm Atheros, Inc.
  * Copyright (c) 2018, The Linux Foundation. All rights reserved.
- *
- * Permission to use, copy, modify, and/or distribute this software for any
- * purpose with or without fee is hereby granted, provided that the above
- * copyright notice and this permission notice appear in all copies.
- *
- * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
- * WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
- * MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
- * ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
- * WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
- * ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
- * OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
  */
 
 #include "wil6210.h"
diff --git a/drivers/net/wireless/ath/wil6210/pcie_bus.c b/drivers/net/wireless/ath/wil6210/pcie_bus.c
index f1a28236..c174323 100644
--- a/drivers/net/wireless/ath/wil6210/pcie_bus.c
+++ b/drivers/net/wireless/ath/wil6210/pcie_bus.c
@@ -1,18 +1,7 @@
+// SPDX-License-Identifier: ISC
 /*
  * Copyright (c) 2012-2017 Qualcomm Atheros, Inc.
  * Copyright (c) 2018-2019, The Linux Foundation. All rights reserved.
- *
- * Permission to use, copy, modify, and/or distribute this software for any
- * purpose with or without fee is hereby granted, provided that the above
- * copyright notice and this permission notice appear in all copies.
- *
- * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
- * WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
- * MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
- * ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
- * WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
- * ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
- * OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
  */
 
 #include <linux/module.h>
diff --git a/drivers/net/wireless/ath/wil6210/pm.c b/drivers/net/wireless/ath/wil6210/pm.c
index 56143e7..ed4df56 100644
--- a/drivers/net/wireless/ath/wil6210/pm.c
+++ b/drivers/net/wireless/ath/wil6210/pm.c
@@ -1,18 +1,7 @@
+// SPDX-License-Identifier: ISC
 /*
  * Copyright (c) 2014,2017 Qualcomm Atheros, Inc.
  * Copyright (c) 2018-2019, The Linux Foundation. All rights reserved.
- *
- * Permission to use, copy, modify, and/or distribute this software for any
- * purpose with or without fee is hereby granted, provided that the above
- * copyright notice and this permission notice appear in all copies.
- *
- * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
- * WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
- * MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
- * ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
- * WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
- * ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
- * OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
  */
 
 #include "wil6210.h"
diff --git a/drivers/net/wireless/ath/wil6210/pmc.c b/drivers/net/wireless/ath/wil6210/pmc.c
index 4b7ac14..9b4ca6b 100644
--- a/drivers/net/wireless/ath/wil6210/pmc.c
+++ b/drivers/net/wireless/ath/wil6210/pmc.c
@@ -1,18 +1,7 @@
+// SPDX-License-Identifier: ISC
 /*
  * Copyright (c) 2012-2015,2017 Qualcomm Atheros, Inc.
  * Copyright (c) 2018, The Linux Foundation. All rights reserved.
- *
- * Permission to use, copy, modify, and/or distribute this software for any
- * purpose with or without fee is hereby granted, provided that the above
- * copyright notice and this permission notice appear in all copies.
- *
- * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
- * WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
- * MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
- * ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
- * WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
- * ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
- * OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
  */
 
 #include <linux/types.h>
diff --git a/drivers/net/wireless/ath/wil6210/pmc.h b/drivers/net/wireless/ath/wil6210/pmc.h
index 92b8c4d..b3d79eb 100644
--- a/drivers/net/wireless/ath/wil6210/pmc.h
+++ b/drivers/net/wireless/ath/wil6210/pmc.h
@@ -1,18 +1,5 @@
-/*
- * Copyright (c) 2012-2015 Qualcomm Atheros, Inc.
- *
- * Permission to use, copy, modify, and/or distribute this software for any
- * purpose with or without fee is hereby granted, provided that the above
- * copyright notice and this permission notice appear in all copies.
- *
- * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
- * WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
- * MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
- * ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
- * WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
- * ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
- * OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
- */
+/* SPDX-License-Identifier: ISC */
+/* Copyright (c) 2012-2015 Qualcomm Atheros, Inc. */
 
 #include <linux/types.h>
 
diff --git a/drivers/net/wireless/ath/wil6210/rx_reorder.c b/drivers/net/wireless/ath/wil6210/rx_reorder.c
index 13246d2..d385bc0 100644
--- a/drivers/net/wireless/ath/wil6210/rx_reorder.c
+++ b/drivers/net/wireless/ath/wil6210/rx_reorder.c
@@ -1,18 +1,7 @@
+// SPDX-License-Identifier: ISC
 /*
  * Copyright (c) 2014-2017 Qualcomm Atheros, Inc.
  * Copyright (c) 2018-2019, The Linux Foundation. All rights reserved.
- *
- * Permission to use, copy, modify, and/or distribute this software for any
- * purpose with or without fee is hereby granted, provided that the above
- * copyright notice and this permission notice appear in all copies.
- *
- * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
- * WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
- * MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
- * ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
- * WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
- * ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
- * OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
  */
 
 #include "wil6210.h"
diff --git a/drivers/net/wireless/ath/wil6210/trace.c b/drivers/net/wireless/ath/wil6210/trace.c
index cd2534b..6909e98 100644
--- a/drivers/net/wireless/ath/wil6210/trace.c
+++ b/drivers/net/wireless/ath/wil6210/trace.c
@@ -1,17 +1,6 @@
+// SPDX-License-Identifier: ISC
 /*
  * Copyright (c) 2013 Qualcomm Atheros, Inc.
- *
- * Permission to use, copy, modify, and/or distribute this software for any
- * purpose with or without fee is hereby granted, provided that the above
- * copyright notice and this permission notice appear in all copies.
- *
- * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
- * WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
- * MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
- * ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
- * WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
- * ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
- * OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
  */
 
 #include <linux/module.h>
diff --git a/drivers/net/wireless/ath/wil6210/trace.h b/drivers/net/wireless/ath/wil6210/trace.h
index 36ebfcf..11c989e 100644
--- a/drivers/net/wireless/ath/wil6210/trace.h
+++ b/drivers/net/wireless/ath/wil6210/trace.h
@@ -1,18 +1,7 @@
+/* SPDX-License-Identifier: ISC */
 /*
  * Copyright (c) 2013-2016 Qualcomm Atheros, Inc.
  * Copyright (c) 2019, The Linux Foundation. All rights reserved.
- *
- * Permission to use, copy, modify, and/or distribute this software for any
- * purpose with or without fee is hereby granted, provided that the above
- * copyright notice and this permission notice appear in all copies.
- *
- * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
- * WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
- * MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
- * ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
- * WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
- * ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
- * OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
  */
 
 #undef TRACE_SYSTEM
diff --git a/drivers/net/wireless/ath/wil6210/txrx.c b/drivers/net/wireless/ath/wil6210/txrx.c
index 598c1fb..8ebc6d5 100644
--- a/drivers/net/wireless/ath/wil6210/txrx.c
+++ b/drivers/net/wireless/ath/wil6210/txrx.c
@@ -1,18 +1,7 @@
+// SPDX-License-Identifier: ISC
 /*
  * Copyright (c) 2012-2017 Qualcomm Atheros, Inc.
  * Copyright (c) 2018-2019, The Linux Foundation. All rights reserved.
- *
- * Permission to use, copy, modify, and/or distribute this software for any
- * purpose with or without fee is hereby granted, provided that the above
- * copyright notice and this permission notice appear in all copies.
- *
- * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
- * WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
- * MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
- * ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
- * WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
- * ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
- * OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
  */
 
 #include <linux/etherdevice.h>
diff --git a/drivers/net/wireless/ath/wil6210/txrx.h b/drivers/net/wireless/ath/wil6210/txrx.h
index 5120475b..1f4c8ec 100644
--- a/drivers/net/wireless/ath/wil6210/txrx.h
+++ b/drivers/net/wireless/ath/wil6210/txrx.h
@@ -1,18 +1,7 @@
+/* SPDX-License-Identifier: ISC */
 /*
  * Copyright (c) 2012-2016 Qualcomm Atheros, Inc.
  * Copyright (c) 2018-2019, The Linux Foundation. All rights reserved.
- *
- * Permission to use, copy, modify, and/or distribute this software for any
- * purpose with or without fee is hereby granted, provided that the above
- * copyright notice and this permission notice appear in all copies.
- *
- * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
- * WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
- * MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
- * ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
- * WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
- * ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
- * OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
  */
 
 #ifndef WIL6210_TXRX_H
diff --git a/drivers/net/wireless/ath/wil6210/txrx_edma.c b/drivers/net/wireless/ath/wil6210/txrx_edma.c
index 04d576d..778b63b 100644
--- a/drivers/net/wireless/ath/wil6210/txrx_edma.c
+++ b/drivers/net/wireless/ath/wil6210/txrx_edma.c
@@ -1,17 +1,6 @@
+// SPDX-License-Identifier: ISC
 /*
  * Copyright (c) 2012-2019 The Linux Foundation. All rights reserved.
- *
- * Permission to use, copy, modify, and/or distribute this software for any
- * purpose with or without fee is hereby granted, provided that the above
- * copyright notice and this permission notice appear in all copies.
- *
- * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
- * WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
- * MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
- * ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
- * WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
- * ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
- * OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
  */
 
 #include <linux/etherdevice.h>
diff --git a/drivers/net/wireless/ath/wil6210/txrx_edma.h b/drivers/net/wireless/ath/wil6210/txrx_edma.h
index 136c51c..c744c65 100644
--- a/drivers/net/wireless/ath/wil6210/txrx_edma.h
+++ b/drivers/net/wireless/ath/wil6210/txrx_edma.h
@@ -1,17 +1,6 @@
+/* SPDX-License-Identifier: ISC */
 /*
  * Copyright (c) 2012-2016,2018-2019, The Linux Foundation. All rights reserved.
- *
- * Permission to use, copy, modify, and/or distribute this software for any
- * purpose with or without fee is hereby granted, provided that the above
- * copyright notice and this permission notice appear in all copies.
- *
- * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
- * WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
- * MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
- * ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
- * WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
- * ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
- * OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
  */
 
 #ifndef WIL6210_TXRX_EDMA_H
diff --git a/drivers/net/wireless/ath/wil6210/wil6210.h b/drivers/net/wireless/ath/wil6210/wil6210.h
index 0783c79..97626bf 100644
--- a/drivers/net/wireless/ath/wil6210/wil6210.h
+++ b/drivers/net/wireless/ath/wil6210/wil6210.h
@@ -1,18 +1,7 @@
+/* SPDX-License-Identifier: ISC */
 /*
  * Copyright (c) 2012-2017 Qualcomm Atheros, Inc.
  * Copyright (c) 2018-2019, The Linux Foundation. All rights reserved.
- *
- * Permission to use, copy, modify, and/or distribute this software for any
- * purpose with or without fee is hereby granted, provided that the above
- * copyright notice and this permission notice appear in all copies.
- *
- * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
- * WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
- * MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
- * ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
- * WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
- * ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
- * OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
  */
 
 #ifndef __WIL6210_H__
diff --git a/drivers/net/wireless/ath/wil6210/wil_crash_dump.c b/drivers/net/wireless/ath/wil6210/wil_crash_dump.c
index 772cb00..1332eb8 100644
--- a/drivers/net/wireless/ath/wil6210/wil_crash_dump.c
+++ b/drivers/net/wireless/ath/wil6210/wil_crash_dump.c
@@ -1,18 +1,7 @@
+// SPDX-License-Identifier: ISC
 /*
  * Copyright (c) 2015,2017 Qualcomm Atheros, Inc.
  * Copyright (c) 2018-2019, The Linux Foundation. All rights reserved.
- *
- * Permission to use, copy, modify, and/or distribute this software for any
- * purpose with or without fee is hereby granted, provided that the above
- * copyright notice and this permission notice appear in all copies.
- *
- * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
- * WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
- * MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
- * ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
- * WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
- * ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
- * OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
  */
 
 #include "wil6210.h"
diff --git a/drivers/net/wireless/ath/wil6210/wil_platform.c b/drivers/net/wireless/ath/wil6210/wil_platform.c
index 4eed05bd..10e10dc 100644
--- a/drivers/net/wireless/ath/wil6210/wil_platform.c
+++ b/drivers/net/wireless/ath/wil6210/wil_platform.c
@@ -1,17 +1,6 @@
+// SPDX-License-Identifier: ISC
 /*
- * Copyright (c) 2014 Qualcomm Atheros, Inc.
- *
- * Permission to use, copy, modify, and/or distribute this software for any
- * purpose with or without fee is hereby granted, provided that the above
- * copyright notice and this permission notice appear in all copies.
- *
- * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
- * WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
- * MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
- * ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
- * WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
- * ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
- * OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
+ * Copyright (c) 2014-2016 Qualcomm Atheros, Inc.
  */
 
 #include <linux/device.h>
diff --git a/drivers/net/wireless/ath/wil6210/wil_platform.h b/drivers/net/wireless/ath/wil6210/wil_platform.h
index bca0906..5ff6620 100644
--- a/drivers/net/wireless/ath/wil6210/wil_platform.h
+++ b/drivers/net/wireless/ath/wil6210/wil_platform.h
@@ -1,17 +1,6 @@
+/* SPDX-License-Identifier: ISC */
 /*
  * Copyright (c) 2014-2017 Qualcomm Atheros, Inc.
- *
- * Permission to use, copy, modify, and/or distribute this software for any
- * purpose with or without fee is hereby granted, provided that the above
- * copyright notice and this permission notice appear in all copies.
- *
- * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
- * WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
- * MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
- * ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
- * WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
- * ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
- * OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
  */
 
 #ifndef __WIL_PLATFORM_H__
diff --git a/drivers/net/wireless/ath/wil6210/wmi.c b/drivers/net/wireless/ath/wil6210/wmi.c
index f9a006d..7a0d934 100644
--- a/drivers/net/wireless/ath/wil6210/wmi.c
+++ b/drivers/net/wireless/ath/wil6210/wmi.c
@@ -1,18 +1,7 @@
+// SPDX-License-Identifier: ISC
 /*
  * Copyright (c) 2012-2017 Qualcomm Atheros, Inc.
  * Copyright (c) 2018-2019, The Linux Foundation. All rights reserved.
- *
- * Permission to use, copy, modify, and/or distribute this software for any
- * purpose with or without fee is hereby granted, provided that the above
- * copyright notice and this permission notice appear in all copies.
- *
- * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
- * WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
- * MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
- * ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
- * WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
- * ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
- * OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
  */
 
 #include <linux/moduleparam.h>
diff --git a/drivers/net/wireless/ath/wil6210/wmi.h b/drivers/net/wireless/ath/wil6210/wmi.h
index a2f7034..6bd4cce 100644
--- a/drivers/net/wireless/ath/wil6210/wmi.h
+++ b/drivers/net/wireless/ath/wil6210/wmi.h
@@ -1,19 +1,8 @@
+/* SPDX-License-Identifier: ISC */
 /*
  * Copyright (c) 2018-2019, The Linux Foundation. All rights reserved.
  * Copyright (c) 2012-2017 Qualcomm Atheros, Inc.
  * Copyright (c) 2006-2012 Wilocity
- *
- * Permission to use, copy, modify, and/or distribute this software for any
- * purpose with or without fee is hereby granted, provided that the above
- * copyright notice and this permission notice appear in all copies.
- *
- * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
- * WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
- * MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
- * ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
- * WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
- * ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
- * OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
  */
 
 /*
-- 
1.9.1

