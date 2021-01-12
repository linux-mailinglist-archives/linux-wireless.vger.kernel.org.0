Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE8322F26A9
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Jan 2021 04:27:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726868AbhALD03 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 11 Jan 2021 22:26:29 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:34872 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725885AbhALD03 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 11 Jan 2021 22:26:29 -0500
X-UUID: 1626aee34ba5497bb7d5913a80228cce-20210112
X-UUID: 1626aee34ba5497bb7d5913a80228cce-20210112
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <shayne.chen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 96550990; Tue, 12 Jan 2021 11:20:31 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs06n1.mediatek.inc (172.21.101.129) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 12 Jan 2021 11:20:30 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 12 Jan 2021 11:20:30 +0800
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
Subject: [PATCH v2] mac80211: fix incorrect strlen of .write in debugfs
Date:   Tue, 12 Jan 2021 11:20:28 +0800
Message-ID: <20210112032028.7482-1-shayne.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This fixes strlen mismatch problems happening in some .write callbacks
of debugfs.

When trying to configure airtime_flags in debugfs, an error appeared:
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
v2:
- fix r/w buffer OOB
- put buf[count] = '\0' to an else
---
 net/mac80211/debugfs.c | 44 +++++++++++++++++++-----------------------
 1 file changed, 20 insertions(+), 24 deletions(-)

diff --git a/net/mac80211/debugfs.c b/net/mac80211/debugfs.c
index 48f144f107d5..9e723d943421 100644
--- a/net/mac80211/debugfs.c
+++ b/net/mac80211/debugfs.c
@@ -120,18 +120,17 @@ static ssize_t aqm_write(struct file *file,
 {
 	struct ieee80211_local *local = file->private_data;
 	char buf[100];
-	size_t len;
 
-	if (count > sizeof(buf))
+	if (count >= sizeof(buf))
 		return -EINVAL;
 
 	if (copy_from_user(buf, user_buf, count))
 		return -EFAULT;
 
-	buf[sizeof(buf) - 1] = '\0';
-	len = strlen(buf);
-	if (len > 0 && buf[len-1] == '\n')
-		buf[len-1] = 0;
+	if (count && buf[count - 1] == '\n')
+		buf[count - 1] = '\0';
+	else
+		buf[count] = '\0';
 
 	if (sscanf(buf, "fq_limit %u", &local->fq.limit) == 1)
 		return count;
@@ -177,18 +176,17 @@ static ssize_t airtime_flags_write(struct file *file,
 {
 	struct ieee80211_local *local = file->private_data;
 	char buf[16];
-	size_t len;
 
-	if (count > sizeof(buf))
+	if (count >= sizeof(buf))
 		return -EINVAL;
 
 	if (copy_from_user(buf, user_buf, count))
 		return -EFAULT;
 
-	buf[sizeof(buf) - 1] = 0;
-	len = strlen(buf);
-	if (len > 0 && buf[len - 1] == '\n')
-		buf[len - 1] = 0;
+	if (count && buf[count - 1] == '\n')
+		buf[count - 1] = '\0';
+	else
+		buf[count] = '\0';
 
 	if (kstrtou16(buf, 0, &local->airtime_flags))
 		return -EINVAL;
@@ -237,20 +235,19 @@ static ssize_t aql_txq_limit_write(struct file *file,
 {
 	struct ieee80211_local *local = file->private_data;
 	char buf[100];
-	size_t len;
 	u32 ac, q_limit_low, q_limit_high, q_limit_low_old, q_limit_high_old;
 	struct sta_info *sta;
 
-	if (count > sizeof(buf))
+	if (count >= sizeof(buf))
 		return -EINVAL;
 
 	if (copy_from_user(buf, user_buf, count))
 		return -EFAULT;
 
-	buf[sizeof(buf) - 1] = 0;
-	len = strlen(buf);
-	if (len > 0 && buf[len - 1] == '\n')
-		buf[len - 1] = 0;
+	if (count && buf[count - 1] == '\n')
+		buf[count - 1] = '\0';
+	else
+		buf[count] = '\0';
 
 	if (sscanf(buf, "%u %u %u", &ac, &q_limit_low, &q_limit_high) != 3)
 		return -EINVAL;
@@ -306,18 +303,17 @@ static ssize_t force_tx_status_write(struct file *file,
 {
 	struct ieee80211_local *local = file->private_data;
 	char buf[3];
-	size_t len;
 
-	if (count > sizeof(buf))
+	if (count >= sizeof(buf))
 		return -EINVAL;
 
 	if (copy_from_user(buf, user_buf, count))
 		return -EFAULT;
 
-	buf[sizeof(buf) - 1] = '\0';
-	len = strlen(buf);
-	if (len > 0 && buf[len - 1] == '\n')
-		buf[len - 1] = 0;
+	if (count && buf[count - 1] == '\n')
+		buf[count - 1] = '\0';
+	else
+		buf[count] = '\0';
 
 	if (buf[0] == '0' && buf[1] == '\0')
 		local->force_tx_status = 0;
-- 
2.29.2

