Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7A7E2EF0F7
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Jan 2021 11:59:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726468AbhAHK6t (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 8 Jan 2021 05:58:49 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:44933 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725901AbhAHK6t (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 8 Jan 2021 05:58:49 -0500
X-UUID: a2812a66070e49b6adf58535417dd9c8-20210108
X-UUID: a2812a66070e49b6adf58535417dd9c8-20210108
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <shayne.chen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1767557850; Fri, 08 Jan 2021 18:58:04 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 8 Jan 2021 18:58:02 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 8 Jan 2021 18:58:01 +0800
From:   Shayne Chen <shayne.chen@mediatek.com>
To:     linux-wireless <linux-wireless@vger.kernel.org>
CC:     Johannes Berg <johannes@sipsolutions.net>,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
        Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Sujuan Chen <sujuan.chen@mediatek.com>
Subject: [PATCH] mac80211: fix incorrect strlen of .write in debugfs
Date:   Fri, 8 Jan 2021 18:56:43 +0800
Message-ID: <20210108105643.10834-1-shayne.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: ABABAB4B14836EBA9C6DBD0A2BFFC1237D0049382AC8F90DB79B7B7F41F177EA2000:8
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This fixes strlen mismatch problems happening in some .write callbacks
of debugfs.

When trying to configure airtime_flags in debugfs, an error appeared:
# echo 0 > /sys/kernel/debug/ieee80211/phy0/airtime_flags
ash: write error: Invalid argument

The error is returned from kstrtou16() since a wrong length makes it
miss the real end of input string.  To fix this, use count as the string
length, and set proper end of string for a char buffer.

The debug print is shown - airtime_flags_write: count = 2, len = 8,
where the actual length is 2, but "len = strlen(buf)" gets 8.

Also cleanup the other similar cases for the sake of consistency.

Signed-off-by: Sujuan Chen <sujuan.chen@mediatek.com>
Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
---
This patch is based on the discussion from
https://patchwork.kernel.org/project/linux-wireless/list/?series=409693
---
 net/mac80211/debugfs.c | 36 ++++++++++++++++--------------------
 1 file changed, 16 insertions(+), 20 deletions(-)

diff --git a/net/mac80211/debugfs.c b/net/mac80211/debugfs.c
index 9135b6f..9991a6a 100644
--- a/net/mac80211/debugfs.c
+++ b/net/mac80211/debugfs.c
@@ -120,7 +120,6 @@ static ssize_t aqm_write(struct file *file,
 {
 	struct ieee80211_local *local = file->private_data;
 	char buf[100];
-	size_t len;
 
 	if (count > sizeof(buf))
 		return -EINVAL;
@@ -128,10 +127,10 @@ static ssize_t aqm_write(struct file *file,
 	if (copy_from_user(buf, user_buf, count))
 		return -EFAULT;
 
-	buf[sizeof(buf) - 1] = '\0';
-	len = strlen(buf);
-	if (len > 0 && buf[len-1] == '\n')
-		buf[len-1] = 0;
+	if (count && buf[count - 1] == '\n')
+		buf[count - 1] = '\0';
+
+	buf[count] = '\0';
 
 	if (sscanf(buf, "fq_limit %u", &local->fq.limit) == 1)
 		return count;
@@ -177,7 +176,6 @@ static ssize_t airtime_flags_write(struct file *file,
 {
 	struct ieee80211_local *local = file->private_data;
 	char buf[16];
-	size_t len;
 
 	if (count > sizeof(buf))
 		return -EINVAL;
@@ -185,10 +183,10 @@ static ssize_t airtime_flags_write(struct file *file,
 	if (copy_from_user(buf, user_buf, count))
 		return -EFAULT;
 
-	buf[sizeof(buf) - 1] = 0;
-	len = strlen(buf);
-	if (len > 0 && buf[len - 1] == '\n')
-		buf[len - 1] = 0;
+	if (count && buf[count - 1] == '\n')
+		buf[count - 1] = '\0';
+
+	buf[count] = '\0';
 
 	if (kstrtou16(buf, 0, &local->airtime_flags))
 		return -EINVAL;
@@ -237,7 +235,6 @@ static ssize_t aql_txq_limit_write(struct file *file,
 {
 	struct ieee80211_local *local = file->private_data;
 	char buf[100];
-	size_t len;
 	u32 ac, q_limit_low, q_limit_high, q_limit_low_old, q_limit_high_old;
 	struct sta_info *sta;
 
@@ -247,10 +244,10 @@ static ssize_t aql_txq_limit_write(struct file *file,
 	if (copy_from_user(buf, user_buf, count))
 		return -EFAULT;
 
-	buf[sizeof(buf) - 1] = 0;
-	len = strlen(buf);
-	if (len > 0 && buf[len - 1] == '\n')
-		buf[len - 1] = 0;
+	if (count && buf[count - 1] == '\n')
+		buf[count - 1] = '\0';
+
+	buf[count] = '\0';
 
 	if (sscanf(buf, "%u %u %u", &ac, &q_limit_low, &q_limit_high) != 3)
 		return -EINVAL;
@@ -306,7 +303,6 @@ static ssize_t force_tx_status_write(struct file *file,
 {
 	struct ieee80211_local *local = file->private_data;
 	char buf[3];
-	size_t len;
 
 	if (count > sizeof(buf))
 		return -EINVAL;
@@ -314,10 +310,10 @@ static ssize_t force_tx_status_write(struct file *file,
 	if (copy_from_user(buf, user_buf, count))
 		return -EFAULT;
 
-	buf[sizeof(buf) - 1] = '\0';
-	len = strlen(buf);
-	if (len > 0 && buf[len - 1] == '\n')
-		buf[len - 1] = 0;
+	if (count && buf[count - 1] == '\n')
+		buf[count - 1] = '\0';
+
+	buf[count] = '\0';
 
 	if (buf[0] == '0' && buf[1] == '\0')
 		local->force_tx_status = 0;
-- 
2.29.2

