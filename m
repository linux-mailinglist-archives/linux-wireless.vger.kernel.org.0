Return-Path: <linux-wireless+bounces-34919-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SNq7Ekbo4WlgzwAAu9opvQ
	(envelope-from <linux-wireless+bounces-34919-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Apr 2026 09:59:02 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BD56B4184CC
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Apr 2026 09:59:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 85F2A3032DEB
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Apr 2026 07:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5594D33AD9A;
	Fri, 17 Apr 2026 07:56:50 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F9BB351C2F;
	Fri, 17 Apr 2026 07:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776412610; cv=none; b=sZOqBk/T3CWpBFJYLTo3K22XatHd0+Vua7od9Lr5/qE+vxvDNvuGhTMdjWQfM8C4Tr+Gbmr8voXj/tuMYs82cpSpcldsJV5epBkW+ldXxL+9E1b3NhFT2sptUkj9ov1//EO1qIPUHFku2b452sLbSmywg4AaYLJZHX0VmPbOEno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776412610; c=relaxed/simple;
	bh=KkyV7TSK5ExB6rSIPUgECDfXxIQcE17wjI6/of9WPtQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZZjxumaZN3v88gAS4pIl715rQQunz7xRxhAYZsG9jzcZpMbrRqgpmqkohDmFCnJ8tfNq09v/Dvukt01Ezh3aMlXfclwQ/zAFUFiXzF2FGs91Nqw58JGMS2W5+LWFYecU2uB81A8JFKJRhckI9Q571fCdM4Hej7+Hp9advjdF3D0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [111.196.245.116])
	by APP-05 (Coremail) with SMTP id zQCowAB3zhG75+FpgWnYDQ--.62028S2;
	Fri, 17 Apr 2026 15:56:43 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Pengpeng Hou <pengpeng@iscas.ac.cn>
Subject: [PATCH] mac80211: minstrel_ht: bound debugfs stats output construction
Date: Fri, 17 Apr 2026 15:56:42 +0800
Message-ID: <20260417075642.32502-1-pengpeng@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAB3zhG75+FpgWnYDQ--.62028S2
X-Coremail-Antispam: 1UD129KBjvAXoW3tr4UZr4fWrWUur1UCr1UAwb_yoW8Gw47to
	Z7ZF4kKFWfJryUWr18Cws7G3WUu3W8WFn8A3yvqrZ8uFZI9r15W340ya40gF1aqr4SvryU
	XrW0qwsrX3yxJrW7n29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UjIYCTnIWjp_UUU5E7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xva
	j40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2
	x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8
	Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26r
	xl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
	6xIIjxv20xvE14v26r1q6rW5McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr
	0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxAIw28IcxkI7VAK
	I48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1lIxAIcVCF04
	k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7Cj
	xVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjfU0pBTUUUUU
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[iscas.ac.cn];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34919-lists,linux-wireless=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pengpeng@iscas.ac.cn,linux-wireless@vger.kernel.org];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.979];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,iscas.ac.cn:mid,iscas.ac.cn:email,80mhz:email]
X-Rspamd-Queue-Id: BD56B4184CC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

minstrel_ht_stats_open() and minstrel_ht_stats_csv_open() build their
entire debugfs outputs in a fixed 32 KiB heap buffer and append each row
with raw sprintf() calls.

The number of rows depends on the current-tree minstrel group/rate
layout, and the final WARN_ON() only checks the accumulated length after
the writes have already happened.

Allocate the debugfs buffer from the current maximum row count and use
bounded appends while constructing the stats and CSV outputs.

Fixes: 9208247d74bc ("mac80211: minstrel_ht: add basic support for VHT rates <= 3SS@80MHz")
Fixes: 2cae0b6a70d6 ("mac80211: add new Minstrel-HT statistic output via csv")

Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
 net/mac80211/rc80211_minstrel_ht_debugfs.c | 263 +++++++++++++--------
 1 file changed, 168 insertions(+), 95 deletions(-)

diff --git a/net/mac80211/rc80211_minstrel_ht_debugfs.c b/net/mac80211/rc80211_minstrel_ht_debugfs.c
index 85149c774505..91e414a799c1 100644
--- a/net/mac80211/rc80211_minstrel_ht_debugfs.c
+++ b/net/mac80211/rc80211_minstrel_ht_debugfs.c
@@ -8,14 +8,66 @@
 #include <linux/debugfs.h>
 #include <linux/ieee80211.h>
 #include <linux/export.h>
+#include <linux/kernel.h>
+#include <linux/slab.h>
 #include <net/mac80211.h>
 #include "rc80211_minstrel_ht.h"
 
 struct minstrel_debugfs_info {
 	size_t len;
+	size_t size;
 	char buf[];
 };
 
+#define MINSTREL_DEBUGFS_ROW_MAX	128
+
+static size_t minstrel_debugfs_remaining(struct minstrel_debugfs_info *ms,
+					 char *p)
+{
+	return ms->size - (p - ms->buf);
+}
+
+static void minstrel_dbg_append(struct minstrel_debugfs_info *ms, char **pp,
+				const char *fmt, ...)
+{
+	size_t rem;
+	va_list args;
+	int len;
+
+	rem = minstrel_debugfs_remaining(ms, *pp);
+	if (!rem)
+		return;
+
+	va_start(args, fmt);
+	len = vscnprintf(*pp, rem, fmt, args);
+	va_end(args);
+
+	*pp += len;
+}
+
+static void minstrel_dbg_putc(struct minstrel_debugfs_info *ms, char **pp,
+			      char ch)
+{
+	if (minstrel_debugfs_remaining(ms, *pp) <= 1)
+		return;
+
+	*(*pp)++ = ch;
+}
+
+static struct minstrel_debugfs_info *
+minstrel_debugfs_info_alloc(struct minstrel_ht_sta *mi)
+{
+	size_t rows = ARRAY_SIZE(mi->groups) * MCS_GROUP_RATES + 8;
+	size_t buf_size = rows * MINSTREL_DEBUGFS_ROW_MAX;
+	struct minstrel_debugfs_info *ms;
+
+	ms = kvzalloc(sizeof(*ms) + buf_size, GFP_KERNEL);
+	if (!ms)
+		return NULL;
+	ms->size = buf_size;
+	return ms;
+}
+
 static ssize_t
 minstrel_stats_read(struct file *file, char __user *buf, size_t len, loff_t *ppos)
 {
@@ -28,7 +80,7 @@ minstrel_stats_read(struct file *file, char __user *buf, size_t len, loff_t *ppo
 static int
 minstrel_stats_release(struct inode *inode, struct file *file)
 {
-	kfree(file->private_data);
+	kvfree(file->private_data);
 	return 0;
 }
 
@@ -45,7 +97,8 @@ minstrel_ht_is_sample_rate(struct minstrel_ht_sta *mi, int idx)
 }
 
 static char *
-minstrel_ht_stats_dump(struct minstrel_ht_sta *mi, int i, char *p)
+minstrel_ht_stats_dump(struct minstrel_ht_sta *mi, int i,
+		       struct minstrel_debugfs_info *ms, char *p)
 {
 	const struct mcs_group *mg;
 	unsigned int j, tp_max, tp_avg, eprob, tx_time;
@@ -75,33 +128,42 @@ minstrel_ht_stats_dump(struct minstrel_ht_sta *mi, int i, char *p)
 			continue;
 
 		if (gflags & IEEE80211_TX_RC_MCS) {
-			p += sprintf(p, "HT%c0  ", htmode);
-			p += sprintf(p, "%cGI  ", gimode);
-			p += sprintf(p, "%d  ", mg->streams);
+			minstrel_dbg_append(ms, &p, "HT%c0  ", htmode);
+			minstrel_dbg_append(ms, &p, "%cGI  ", gimode);
+			minstrel_dbg_append(ms, &p, "%d  ", mg->streams);
 		} else if (gflags & IEEE80211_TX_RC_VHT_MCS) {
-			p += sprintf(p, "VHT%c0 ", htmode);
-			p += sprintf(p, "%cGI ", gimode);
-			p += sprintf(p, "%d  ", mg->streams);
+			minstrel_dbg_append(ms, &p, "VHT%c0 ", htmode);
+			minstrel_dbg_append(ms, &p, "%cGI ", gimode);
+			minstrel_dbg_append(ms, &p, "%d  ", mg->streams);
 		} else if (i == MINSTREL_OFDM_GROUP) {
-			p += sprintf(p, "OFDM       ");
-			p += sprintf(p, "1 ");
+			minstrel_dbg_append(ms, &p, "OFDM       ");
+			minstrel_dbg_append(ms, &p, "1 ");
 		} else {
-			p += sprintf(p, "CCK    ");
-			p += sprintf(p, "%cP  ", j < 4 ? 'L' : 'S');
-			p += sprintf(p, "1 ");
+			minstrel_dbg_append(ms, &p, "CCK    ");
+			minstrel_dbg_append(ms, &p, "%cP  ",
+					    j < 4 ? 'L' : 'S');
+			minstrel_dbg_append(ms, &p, "1 ");
 		}
 
-		*(p++) = (idx == mi->max_tp_rate[0]) ? 'A' : ' ';
-		*(p++) = (idx == mi->max_tp_rate[1]) ? 'B' : ' ';
-		*(p++) = (idx == mi->max_tp_rate[2]) ? 'C' : ' ';
-		*(p++) = (idx == mi->max_tp_rate[3]) ? 'D' : ' ';
-		*(p++) = (idx == mi->max_prob_rate) ? 'P' : ' ';
-		*(p++) = minstrel_ht_is_sample_rate(mi, idx) ? 'S' : ' ';
+		minstrel_dbg_putc(ms, &p,
+				  (idx == mi->max_tp_rate[0]) ? 'A' : ' ');
+		minstrel_dbg_putc(ms, &p,
+				  (idx == mi->max_tp_rate[1]) ? 'B' : ' ');
+		minstrel_dbg_putc(ms, &p,
+				  (idx == mi->max_tp_rate[2]) ? 'C' : ' ');
+		minstrel_dbg_putc(ms, &p,
+				  (idx == mi->max_tp_rate[3]) ? 'D' : ' ');
+		minstrel_dbg_putc(ms, &p,
+				  (idx == mi->max_prob_rate) ? 'P' : ' ');
+		minstrel_dbg_putc(ms, &p,
+				  minstrel_ht_is_sample_rate(mi, idx) ? 'S' : ' ');
 
 		if (gflags & IEEE80211_TX_RC_MCS) {
-			p += sprintf(p, "  MCS%-2u", (mg->streams - 1) * 8 + j);
+			minstrel_dbg_append(ms, &p, "  MCS%-2u",
+					    (mg->streams - 1) * 8 + j);
 		} else if (gflags & IEEE80211_TX_RC_VHT_MCS) {
-			p += sprintf(p, "  MCS%-1u/%1u", j, mg->streams);
+			minstrel_dbg_append(ms, &p, "  MCS%-1u/%1u",
+					    j, mg->streams);
 		} else {
 			int r;
 
@@ -110,32 +172,34 @@ minstrel_ht_stats_dump(struct minstrel_ht_sta *mi, int i, char *p)
 			else
 				r = minstrel_cck_bitrates[j % 4];
 
-			p += sprintf(p, "   %2u.%1uM", r / 10, r % 10);
+			minstrel_dbg_append(ms, &p, "   %2u.%1uM", r / 10,
+					    r % 10);
 		}
 
-		p += sprintf(p, "  %3u  ", idx);
+		minstrel_dbg_append(ms, &p, "  %3u  ", idx);
 
 		/* tx_time[rate(i)] in usec */
 		duration = mg->duration[j];
 		duration <<= mg->shift;
 		tx_time = DIV_ROUND_CLOSEST(duration, 1000);
-		p += sprintf(p, "%6u  ", tx_time);
+		minstrel_dbg_append(ms, &p, "%6u  ", tx_time);
 
 		tp_max = minstrel_ht_get_tp_avg(mi, i, j, MINSTREL_FRAC(100, 100));
 		tp_avg = minstrel_ht_get_tp_avg(mi, i, j, mrs->prob_avg);
 		eprob = MINSTREL_TRUNC(mrs->prob_avg * 1000);
 
-		p += sprintf(p, "%4u.%1u    %4u.%1u     %3u.%1u"
-				"     %3u   %3u %-3u   "
-				"%9llu   %-9llu\n",
-				tp_max / 10, tp_max % 10,
-				tp_avg / 10, tp_avg % 10,
-				eprob / 10, eprob % 10,
-				mrs->retry_count,
-				mrs->last_success,
-				mrs->last_attempts,
-				(unsigned long long)mrs->succ_hist,
-				(unsigned long long)mrs->att_hist);
+		minstrel_dbg_append(ms, &p,
+				    "%4u.%1u    %4u.%1u     %3u.%1u     ",
+				    tp_max / 10, tp_max % 10,
+				    tp_avg / 10, tp_avg % 10,
+				    eprob / 10, eprob % 10);
+		minstrel_dbg_append(ms, &p, "%3u   %3u %-3u   ",
+				    mrs->retry_count,
+				    mrs->last_success,
+				    mrs->last_attempts);
+		minstrel_dbg_append(ms, &p, "%9llu   %-9llu\n",
+				    (unsigned long long)mrs->succ_hist,
+				    (unsigned long long)mrs->att_hist);
 	}
 
 	return p;
@@ -149,35 +213,35 @@ minstrel_ht_stats_open(struct inode *inode, struct file *file)
 	unsigned int i;
 	char *p;
 
-	ms = kmalloc(32768, GFP_KERNEL);
+	ms = minstrel_debugfs_info_alloc(mi);
 	if (!ms)
 		return -ENOMEM;
 
 	file->private_data = ms;
 	p = ms->buf;
 
-	p += sprintf(p, "\n");
-	p += sprintf(p,
-		     "              best    ____________rate__________    ____statistics___    _____last____    ______sum-of________\n");
-	p += sprintf(p,
-		     "mode guard #  rate   [name   idx airtime  max_tp]  [avg(tp) avg(prob)]  [retry|suc|att]  [#success | #attempts]\n");
+	minstrel_dbg_append(ms, &p, "\n");
+	minstrel_dbg_append(ms, &p,
+			    "              best    ____________rate__________    ____statistics___    _____last____    ______sum-of________\n");
+	minstrel_dbg_append(ms, &p,
+			    "mode guard #  rate   [name   idx airtime  max_tp]  [avg(tp) avg(prob)]  [retry|suc|att]  [#success | #attempts]\n");
 
-	p = minstrel_ht_stats_dump(mi, MINSTREL_CCK_GROUP, p);
+	p = minstrel_ht_stats_dump(mi, MINSTREL_CCK_GROUP, ms, p);
 	for (i = 0; i < MINSTREL_CCK_GROUP; i++)
-		p = minstrel_ht_stats_dump(mi, i, p);
+		p = minstrel_ht_stats_dump(mi, i, ms, p);
 	for (i++; i < ARRAY_SIZE(mi->groups); i++)
-		p = minstrel_ht_stats_dump(mi, i, p);
+		p = minstrel_ht_stats_dump(mi, i, ms, p);
 
-	p += sprintf(p, "\nTotal packet count::    ideal %d      "
-			"lookaround %d\n",
-			max(0, (int) mi->total_packets - (int) mi->sample_packets),
-			mi->sample_packets);
+	minstrel_dbg_append(ms, &p, "\nTotal packet count::    ideal %d      ",
+			    max(0, (int)mi->total_packets -
+				(int)mi->sample_packets));
+	minstrel_dbg_append(ms, &p, "lookaround %d\n", mi->sample_packets);
 	if (mi->avg_ampdu_len)
-		p += sprintf(p, "Average # of aggregated frames per A-MPDU: %d.%d\n",
-			MINSTREL_TRUNC(mi->avg_ampdu_len),
-			MINSTREL_TRUNC(mi->avg_ampdu_len * 10) % 10);
+		minstrel_dbg_append(ms, &p,
+				    "Average # of aggregated frames per A-MPDU: %d.%d\n",
+				    MINSTREL_TRUNC(mi->avg_ampdu_len),
+				    MINSTREL_TRUNC(mi->avg_ampdu_len * 10) % 10);
 	ms->len = p - ms->buf;
-	WARN_ON(ms->len + sizeof(*ms) > 32768);
 
 	return nonseekable_open(inode, file);
 }
@@ -190,7 +254,8 @@ static const struct file_operations minstrel_ht_stat_fops = {
 };
 
 static char *
-minstrel_ht_stats_csv_dump(struct minstrel_ht_sta *mi, int i, char *p)
+minstrel_ht_stats_csv_dump(struct minstrel_ht_sta *mi, int i,
+			   struct minstrel_debugfs_info *ms, char *p)
 {
 	const struct mcs_group *mg;
 	unsigned int j, tp_max, tp_avg, eprob, tx_time;
@@ -220,32 +285,40 @@ minstrel_ht_stats_csv_dump(struct minstrel_ht_sta *mi, int i, char *p)
 			continue;
 
 		if (gflags & IEEE80211_TX_RC_MCS) {
-			p += sprintf(p, "HT%c0,", htmode);
-			p += sprintf(p, "%cGI,", gimode);
-			p += sprintf(p, "%d,", mg->streams);
+			minstrel_dbg_append(ms, &p, "HT%c0,", htmode);
+			minstrel_dbg_append(ms, &p, "%cGI,", gimode);
+			minstrel_dbg_append(ms, &p, "%d,", mg->streams);
 		} else if (gflags & IEEE80211_TX_RC_VHT_MCS) {
-			p += sprintf(p, "VHT%c0,", htmode);
-			p += sprintf(p, "%cGI,", gimode);
-			p += sprintf(p, "%d,", mg->streams);
+			minstrel_dbg_append(ms, &p, "VHT%c0,", htmode);
+			minstrel_dbg_append(ms, &p, "%cGI,", gimode);
+			minstrel_dbg_append(ms, &p, "%d,", mg->streams);
 		} else if (i == MINSTREL_OFDM_GROUP) {
-			p += sprintf(p, "OFDM,,1,");
+			minstrel_dbg_append(ms, &p, "OFDM,,1,");
 		} else {
-			p += sprintf(p, "CCK,");
-			p += sprintf(p, "%cP,", j < 4 ? 'L' : 'S');
-			p += sprintf(p, "1,");
+			minstrel_dbg_append(ms, &p, "CCK,");
+			minstrel_dbg_append(ms, &p, "%cP,", j < 4 ? 'L' : 'S');
+			minstrel_dbg_append(ms, &p, "1,");
 		}
 
-		p += sprintf(p, "%s" ,((idx == mi->max_tp_rate[0]) ? "A" : ""));
-		p += sprintf(p, "%s" ,((idx == mi->max_tp_rate[1]) ? "B" : ""));
-		p += sprintf(p, "%s" ,((idx == mi->max_tp_rate[2]) ? "C" : ""));
-		p += sprintf(p, "%s" ,((idx == mi->max_tp_rate[3]) ? "D" : ""));
-		p += sprintf(p, "%s" ,((idx == mi->max_prob_rate) ? "P" : ""));
-		p += sprintf(p, "%s", (minstrel_ht_is_sample_rate(mi, idx) ? "S" : ""));
+		minstrel_dbg_append(ms, &p, "%s",
+				    (idx == mi->max_tp_rate[0]) ? "A" : "");
+		minstrel_dbg_append(ms, &p, "%s",
+				    (idx == mi->max_tp_rate[1]) ? "B" : "");
+		minstrel_dbg_append(ms, &p, "%s",
+				    (idx == mi->max_tp_rate[2]) ? "C" : "");
+		minstrel_dbg_append(ms, &p, "%s",
+				    (idx == mi->max_tp_rate[3]) ? "D" : "");
+		minstrel_dbg_append(ms, &p, "%s",
+				    (idx == mi->max_prob_rate) ? "P" : "");
+		minstrel_dbg_append(ms, &p, "%s",
+				    minstrel_ht_is_sample_rate(mi, idx) ? "S" : "");
 
 		if (gflags & IEEE80211_TX_RC_MCS) {
-			p += sprintf(p, ",MCS%-2u,", (mg->streams - 1) * 8 + j);
+			minstrel_dbg_append(ms, &p, ",MCS%-2u,",
+					    (mg->streams - 1) * 8 + j);
 		} else if (gflags & IEEE80211_TX_RC_VHT_MCS) {
-			p += sprintf(p, ",MCS%-1u/%1u,", j, mg->streams);
+			minstrel_dbg_append(ms, &p, ",MCS%-1u/%1u,",
+					    j, mg->streams);
 		} else {
 			int r;
 
@@ -254,36 +327,37 @@ minstrel_ht_stats_csv_dump(struct minstrel_ht_sta *mi, int i, char *p)
 			else
 				r = minstrel_cck_bitrates[j % 4];
 
-			p += sprintf(p, ",%2u.%1uM,", r / 10, r % 10);
+			minstrel_dbg_append(ms, &p, ",%2u.%1uM,",
+					    r / 10, r % 10);
 		}
 
-		p += sprintf(p, "%u,", idx);
+		minstrel_dbg_append(ms, &p, "%u,", idx);
 
 		duration = mg->duration[j];
 		duration <<= mg->shift;
 		tx_time = DIV_ROUND_CLOSEST(duration, 1000);
-		p += sprintf(p, "%u,", tx_time);
+		minstrel_dbg_append(ms, &p, "%u,", tx_time);
 
 		tp_max = minstrel_ht_get_tp_avg(mi, i, j, MINSTREL_FRAC(100, 100));
 		tp_avg = minstrel_ht_get_tp_avg(mi, i, j, mrs->prob_avg);
 		eprob = MINSTREL_TRUNC(mrs->prob_avg * 1000);
 
-		p += sprintf(p, "%u.%u,%u.%u,%u.%u,%u,%u,"
-				"%u,%llu,%llu,",
-				tp_max / 10, tp_max % 10,
-				tp_avg / 10, tp_avg % 10,
-				eprob / 10, eprob % 10,
-				mrs->retry_count,
-				mrs->last_success,
-				mrs->last_attempts,
-				(unsigned long long)mrs->succ_hist,
-				(unsigned long long)mrs->att_hist);
-		p += sprintf(p, "%d,%d,%d.%d\n",
-				max(0, (int) mi->total_packets -
-				(int) mi->sample_packets),
-				mi->sample_packets,
-				MINSTREL_TRUNC(mi->avg_ampdu_len),
-				MINSTREL_TRUNC(mi->avg_ampdu_len * 10) % 10);
+		minstrel_dbg_append(ms, &p, "%u.%u,%u.%u,%u.%u,%u,%u,%u,",
+				    tp_max / 10, tp_max % 10,
+				    tp_avg / 10, tp_avg % 10,
+				    eprob / 10, eprob % 10,
+				    mrs->retry_count,
+				    mrs->last_success,
+				    mrs->last_attempts);
+		minstrel_dbg_append(ms, &p, "%llu,%llu,",
+				    (unsigned long long)mrs->succ_hist,
+				    (unsigned long long)mrs->att_hist);
+		minstrel_dbg_append(ms, &p, "%d,%d,%d.%d\n",
+				    max(0, (int)mi->total_packets -
+					(int)mi->sample_packets),
+				    mi->sample_packets,
+				    MINSTREL_TRUNC(mi->avg_ampdu_len),
+				    MINSTREL_TRUNC(mi->avg_ampdu_len * 10) % 10);
 	}
 
 	return p;
@@ -297,7 +371,7 @@ minstrel_ht_stats_csv_open(struct inode *inode, struct file *file)
 	unsigned int i;
 	char *p;
 
-	ms = kmalloc(32768, GFP_KERNEL);
+	ms = minstrel_debugfs_info_alloc(mi);
 	if (!ms)
 		return -ENOMEM;
 
@@ -305,14 +379,13 @@ minstrel_ht_stats_csv_open(struct inode *inode, struct file *file)
 
 	p = ms->buf;
 
-	p = minstrel_ht_stats_csv_dump(mi, MINSTREL_CCK_GROUP, p);
+	p = minstrel_ht_stats_csv_dump(mi, MINSTREL_CCK_GROUP, ms, p);
 	for (i = 0; i < MINSTREL_CCK_GROUP; i++)
-		p = minstrel_ht_stats_csv_dump(mi, i, p);
+		p = minstrel_ht_stats_csv_dump(mi, i, ms, p);
 	for (i++; i < ARRAY_SIZE(mi->groups); i++)
-		p = minstrel_ht_stats_csv_dump(mi, i, p);
+		p = minstrel_ht_stats_csv_dump(mi, i, ms, p);
 
 	ms->len = p - ms->buf;
-	WARN_ON(ms->len + sizeof(*ms) > 32768);
 
 	return nonseekable_open(inode, file);
 }
-- 
2.50.1 (Apple Git-155)


