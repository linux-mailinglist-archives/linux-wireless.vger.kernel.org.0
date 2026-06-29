Return-Path: <linux-wireless+bounces-38254-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id VefuHoURQmqnzgkAu9opvQ
	(envelope-from <linux-wireless+bounces-38254-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jun 2026 08:32:37 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 119EC6D6588
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jun 2026 08:32:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=ZRtQzKxW;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b="B4KXNRv/";
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38254-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38254-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7CFBF3002308
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jun 2026 06:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 675B52628D;
	Mon, 29 Jun 2026 06:32:35 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFDAA2F4A14
	for <linux-wireless@vger.kernel.org>; Mon, 29 Jun 2026 06:32:33 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782714755; cv=none; b=izMTFe5LGXhO1D6+YZuBj5LF7CAw7HLKNpO96ttQU0rSpuW/Uo/Cll2BnnMFwUo0gWbM46pQAi4ypfNiZs01n8YoNesvLJ/vW+WH07YNgcOQjXWk2n/w2dNLdfKALjrImEiTGRLxo/uVIKnA5d91+uyzp0HFVp4ocfYI/YGjcyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782714755; c=relaxed/simple;
	bh=n+D9bLZPHf8d6AwomQy9Ey9fgzSETci1B8poQpB9x14=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BkbTDrHYZxmJqbZ4zxVFi+d4j5aqWYcw9UpQFQbNVrfhAZkusjyU4GRs9rbiQY40Ic0/69p5rKOH+omcFiyaZOB72p87hJDCEPu9z6+B6LR0ATa03445rE/X2TmSqsTn4v1ynH3vYKr+/MW35zuXfDr+lyy+CE2da+svXAev1DA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZRtQzKxW; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=B4KXNRv/; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65T4NOuI1766959
	for <linux-wireless@vger.kernel.org>; Mon, 29 Jun 2026 06:32:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=8aBuRF4NbRAP4w7JxOyKx7tjuM51R0BLyZq
	FmIy0gvo=; b=ZRtQzKxWrB8cXo4MtyseWVT9uf1y1794jdBt69y0GEbVXf5OYUD
	7ZuUxwIx2ISRHjAhlA+os8L0pP/vVh8iQfrl5RZlEygTtWaHidgJUNYvB8UAgppc
	XFcoVd5QrNABA14kVu/Bb6cHdjukconPn+Dc6ayHzMdr+0QX/0U/xmzgqr5Ww2Gr
	qVrGpeiPdzJg/x/zZTCBw43YM4y6012+488dIlQQoiZwFAQeHrTlt6ckcP+KZg0p
	RqPe2bACcfAD98PIN6q0R99f0XtLizDJ/UcPmPiigt17ZHE7ZzIEzsFMh3BV7k7B
	zDyrjo92l1M0T4HYuOPD8O0qTdGgX/n9dYg==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f270a4ywb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 29 Jun 2026 06:32:32 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-30ed53abff8so321551eec.1
        for <linux-wireless@vger.kernel.org>; Sun, 28 Jun 2026 23:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782714752; x=1783319552; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=8aBuRF4NbRAP4w7JxOyKx7tjuM51R0BLyZqFmIy0gvo=;
        b=B4KXNRv/vs1laVHAwGFfCHR/3WJL9SveYCVwDGf6h9kIOyjcfLBz8NIGqm/dESrn1B
         gbdibscGQoMF60/bYGHcLHdl8tUx6FA+WgAS3xJynD5SW+kAizh/YA9M9jat46lm6p9s
         MteDTYbB7JXROq9SDi4zRcJ1tPuYW5GKhjT53J/7RdUM9wQoULyKuVu4sImMFNd3E8XQ
         HzJe1Md2scttJDjUT56dSirrlw3GQxSS2KM8tqhzKIcqwdCDP+W8NxLDc14vKekSw1DB
         p5P5X6rVMtKa+PGQQbZXFYZaKaeRspFJe2eh/jzXi6bdsN6kQqrctmoQqdQHZdptyyks
         eFEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782714752; x=1783319552;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8aBuRF4NbRAP4w7JxOyKx7tjuM51R0BLyZqFmIy0gvo=;
        b=g4r6FwOu/kqvHLtEgdVe8UCFXl/60doP/JY+RK8dJhqG9PBYG8dAlfuuSE/HjGUsAx
         KyK9b/a12/HLwVb2VdFmCRJ//AN0evXGCGSqI6dJYK8mxHP1+853AllYUUj9bOMn+JZ9
         XGotHv6+0BhSpWbNpsyjnwsFakVlqTqcRF5ZcagPgsSwuB9Gqi63plXa1MIXIRwHpAsq
         tj682LmEOE/5Tgdd4Hky/WtXGYA64FF9voDlpL2cDts+Gfr1rOES0a7576Qj3te/2UlV
         wY6kZEcqf2q0C1N/JIUPORTwag0cAaSU5IqoSV1oM2J3kEQiIITwIOOCwFDOk0TlhRZ2
         4Hbg==
X-Gm-Message-State: AOJu0YzAsXGMJGdFPHfohkFQpEYJjJP6tWtALJkcxrK8xAmwxJmjq0II
	MRNWQ8g4/rOhVX1y+VJtGi70ZDLIldw7wW+fixVUpPi2Vmk3CaHcX2IHHAoVQMQaqi0SEgUEasl
	8+2upHddDBCf6NuZwI+4X9bF7MSoYBV3qChUCVNlQfjnSpBN7ltIbjPZG1jRlEmI6mE+VPoRess
	LHFg==
X-Gm-Gg: AfdE7cmPxh3+4UFDnkky76P+E9DsZ1qDoVEoX3lqX3APsMP+PDSB8C4685Qd9OZcRMH
	jXxqD4DUGNhorfNVyxhEipp/wHHOoB98MItXBsoiDe10wsr7HBxEEaxTFqPE9iwdhqVi7RB5+yu
	RqUyfKpkeKERh4SAoSe4vEkUhZeqFvV0FJ/kELcDTzUEoP78AO/Ok1Cw2W2bRpquUDNYvCbUevP
	uboT1MuH5KraB8L75EJVTGrGWZ3CM7+036lwNDW4K+rC1DxFbifmAz1v9CcB0DJBBbxK21xz4rk
	yXL6au0bCgUg/fzVhbYm60ok4roDpLH2Z9bXQ4eiGxylOBxIOfeb24ZLJHUahAn2aGEvnGq9NMQ
	l1r559K81xXUMcYTfo/JGHFDVIUCbZv5/mI013LLo0ew=
X-Received: by 2002:a05:7300:8b85:b0:304:bce9:25fa with SMTP id 5a478bee46e88-30c84cf58edmr12843273eec.4.1782714751856;
        Sun, 28 Jun 2026 23:32:31 -0700 (PDT)
X-Received: by 2002:a05:7300:8b85:b0:304:bce9:25fa with SMTP id 5a478bee46e88-30c84cf58edmr12843247eec.4.1782714751144;
        Sun, 28 Jun 2026 23:32:31 -0700 (PDT)
Received: from hu-kkavita-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c7c8afc91sm43751229eec.14.2026.06.28.23.32.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2026 23:32:30 -0700 (PDT)
From: Kavita Kavita <kavita.kavita@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, kavita.kavita@oss.qualcomm.com
Subject: [PATCH wireless-next v2] wifi: cfg80211: fix regulatory.db async firmware request blocking __usermodehelper_disable()
Date: Mon, 29 Jun 2026 12:01:59 +0530
Message-Id: <20260629063159.3288957-1-kavita.kavita@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDA1MyBTYWx0ZWRfX/imzDqrCv3fg
 UQukMoMPEGQP0feh7zFGFe3pHy7WOaQyZJWnr2n7n9vxSSOkaLwabPZKOLTYlOxkvyTwshp1Eu5
 99RUBApob63ioahkQZ3GNy+PNFN9UO9PHcfdMqgJxHx/HgMU1+NtOQNV440VL1UjjQ+xcEhfy6y
 YkfMxIXBye968yFoUKMF/63uQbKR+KwwE3YyaGauigN/0Q2kc2fCaU5DvH6clOwxKiEy1jwnO5B
 d7abVqyFG7DPPMsP5I/Xxz7v9RJBBPMw/Fnxm6WkS9VBSqgIpHKXLxCcFG1F/08YSQTMyujLIj1
 mmgueWDp42oW1+WEIIE2gDpa8FMW1n7w9238EwgAl48jK2NBN4PYO9xkInw9oepeSBi+2Rz9rlZ
 7FR7whJ5Z0JYj1HYeBxHDgg0ByjpNwYbKiT/b3Y0notaJZCsl8UOtoOiFUaOIWBlcnLKwgtu0uf
 40YqZESYFMoeu/48MZQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDA1MyBTYWx0ZWRfX/rlAc0ldTMRI
 2M59B1Fahv+e7zjAB+IGnCBR7/rSUFKIIBfTugM+Oc4aihXJzrN44dbW3iRq83535bG2tD02ubc
 mmj39AhplQjbCKvwVWtFpYTGn1Fpj1E=
X-Proofpoint-GUID: eScczTixHJ6nSoTGVu5wx9Py2ToFiojU
X-Proofpoint-ORIG-GUID: eScczTixHJ6nSoTGVu5wx9Py2ToFiojU
X-Authority-Analysis: v=2.4 cv=Fe4HAp+6 c=1 sm=1 tr=0 ts=6a421180 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=KSijteOHSPyhfr2HdScA:9 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 adultscore=0 lowpriorityscore=0 phishscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290053
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-38254-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:johannes@sipsolutions.net,m:linux-wireless@vger.kernel.org,m:kavita.kavita@oss.qualcomm.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[kavita.kavita@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kavita.kavita@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 119EC6D6588

cfg80211 schedules an asynchronous request_firmware() work item for
regulatory.db via request_firmware_work_func(). When the direct
firmware load fails, _request_firmware() falls back to the sysfs
fallback path via firmware_fallback_sysfs(), which blocks indefinitely
in wait_for_completion_killable_timeout() waiting for userspace to
supply the firmware through the sysfs interface.

While this work item is pending, any caller of
__usermodehelper_disable() will deadlock attempting to acquire the
usermodehelper rwsem for writing, since the sysfs firmware fallback
path holds the rwsem for reading and is blocked waiting for userspace
response that can never arrive while usermode helpers are being
disabled.

Observed call traces where system suspend blocked due to regulatory.db
async firmware request:

  kworker/6:3 (pid 194) holding usermodehelper rwsem read lock, blocked
   waiting for userspace firmware response:
     wait_for_completion_killable_timeout+0x48
     firmware_fallback_sysfs+0x270
     _request_firmware+0x790
     request_firmware_work_func+0x44
     process_one_work[jt]+0x59c
     worker_thread+0x260
     kthread+0x150
     ret_from_fork+0x10

  Caller blocked in __usermodehelper_disable() during system suspend:
     rwsem_down_write_slowpath+0x768
     down_write+0x98
     __usermodehelper_disable+0x3c
     freeze_processes+0x18
     pm_suspend+0x320
     state_store+0x104
     kernfs_fop_write_iter[jt]+0x168
     vfs_write+0x270
     ksys_write+0x78

Any service or kernel subsystem invoking __usermodehelper_disable() is
susceptible to this hang as long as the regulatory.db sysfs fallback
request remains outstanding.

Fix this by replacing the unconditional uevent-based load with a
two-step approach. First, attempt a synchronous load via
request_firmware_direct() at init time. This is fast and
non-blocking, if the file is present in standard paths it is loaded
immediately with no delay. If not found, the load is deferred to
wiphy_regulatory_register() and triggered via
firmware_request_nowait_nowarn() only when the first non-self-managed
wiphy registers.

For self-managed drivers (REGULATORY_WIPHY_SELF_MANAGED), the hang is
avoided because wiphy_regulatory_register() handles them separately
and the deferred load path is never reached, so the file load is not
attempted at all. For this case, regulatory information is obtained
from driver/firmware during wiphy registration. For non-self-managed
drivers, the file is required and is expected to be present. The
deferred load via firmware_request_nowait_nowarn() is triggered only
when the first such wiphy registers. This ensures the database is
loaded only when it is actually needed, avoiding the sysfs fallback
path on systems where the file is absent at init time.

Also refactor regdb_fw_cb() into two functions: regdb_load() which
validates and stores the firmware image, and regdb_fw_cb_restore()
which is the async callback that calls restore_regulatory_settings()
to replay all pending regulatory requests (country hints from core,
user, driver and country IE) that arrived while the database was not
yet available.

NOTE:
This issue was observed on Android platforms where regulatory.db is
absent.
Steps to reproduce on Android platforms:
  1. Power off the device completely.
  2. Connect the charger; the device enters off-mode charging.
  3. While in off-mode charging, short press the power key.

Fixes: 007f6c5e6eb4 ("cfg80211: support loading regulatory database as firmware file")
Signed-off-by: Kavita Kavita <kavita.kavita@oss.qualcomm.com>
---
Changes in v2:
 - Added Fixes Tag in commit.
---
 net/wireless/reg.c | 132 ++++++++++++++++++++++++++-------------------
 1 file changed, 78 insertions(+), 54 deletions(-)

diff --git a/net/wireless/reg.c b/net/wireless/reg.c
index 1e8214d6b6d8..d7b864d32ba1 100644
--- a/net/wireless/reg.c
+++ b/net/wireless/reg.c
@@ -988,78 +988,98 @@ static int query_regdb(const char *alpha2)
 	return -ENODATA;
 }
 
-static void regdb_fw_cb(const struct firmware *fw, void *context)
+MODULE_FIRMWARE("regulatory.db");
+
+/* Validate and store firmware image as regdb. Used by all load paths. */
+static int regdb_load(const struct firmware *fw)
 {
-	int set_error = 0;
-	bool restore = true;
 	void *db;
 
-	if (!fw) {
-		pr_info("failed to load regulatory.db\n");
-		set_error = -ENODATA;
-	} else if (!valid_regdb(fw->data, fw->size)) {
+	ASSERT_RTNL();
+
+	if (!valid_regdb(fw->data, fw->size)) {
 		pr_info("loaded regulatory.db is malformed or signature is missing/invalid\n");
-		set_error = -EINVAL;
+		return -EINVAL;
 	}
 
+	db = kmemdup(fw->data, fw->size, GFP_KERNEL);
+	if (!db)
+		return -ENOMEM;
+
+	regdb = db;
+	return 0;
+}
+
+static void regdb_fw_cb_restore(const struct firmware *fw, void *context)
+{
+	int err;
+
 	rtnl_lock();
-	if (regdb && !IS_ERR(regdb)) {
-		/* negative case - a bug
-		 * positive case - can happen due to race in case of multiple cb's in
-		 * queue, due to usage of asynchronous callback
-		 *
-		 * Either case, just restore and free new db.
-		 */
-	} else if (set_error) {
-		regdb = ERR_PTR(set_error);
-	} else if (fw) {
-		db = kmemdup(fw->data, fw->size, GFP_KERNEL);
-		if (db) {
-			regdb = db;
-			restore = context && query_regdb(context);
-		} else {
-			restore = true;
-		}
-	}
 
-	if (restore)
+	/* Skip if a concurrent wiphy registration already loaded the db. */
+	if (regdb && !IS_ERR(regdb))
+		goto out_unlock;
+
+	/*
+	 * Replay all pending regulatory hints that arrived while the
+	 * database was not yet available, regardless of load outcome.
+	 */
+	if (!fw) {
+		pr_info("failed to load regulatory.db\n");
+		regdb = ERR_PTR(-ENODATA);
 		restore_regulatory_settings(true, false);
+		goto out_unlock;
+	}
 
-	rtnl_unlock();
+	err = regdb_load(fw);
+	if (err)
+		regdb = ERR_PTR(err);
 
-	kfree(context);
+	restore_regulatory_settings(true, false);
 
+out_unlock:
+	rtnl_unlock();
 	release_firmware(fw);
 }
 
-MODULE_FIRMWARE("regulatory.db");
-
 static int query_regdb_file(const char *alpha2)
 {
+	const struct firmware *fw;
 	int err;
 
 	ASSERT_RTNL();
 
-	if (regdb)
+	if (regdb && !IS_ERR(regdb))
 		return query_regdb(alpha2);
 
-	alpha2 = kmemdup(alpha2, 2, GFP_KERNEL);
-	if (!alpha2)
-		return -ENOMEM;
+	/*
+	 * Load failed or async udev load in progress. If -EINPROGRESS,
+	 * hints are preserved and replayed once the udev load completes.
+	 */
+	if (IS_ERR(regdb) && PTR_ERR(regdb) != -EINPROGRESS)
+		return PTR_ERR(regdb);
 
-	err = request_firmware_nowait(THIS_MODULE, true, "regulatory.db",
-				      &reg_fdev->dev, GFP_KERNEL,
-				      (void *)alpha2, regdb_fw_cb);
+	/*
+	 * Preserve the hint if the file is not found on direct paths;
+	 * an async udev load will be triggered on wiphy registration
+	 * and will replay all pending hints on completion.
+	 */
+	err = request_firmware_direct(&fw, "regulatory.db", &reg_fdev->dev);
 	if (err)
-		kfree(alpha2);
+		return 0;
+	err = regdb_load(fw);
+	release_firmware(fw);
+	if (err) {
+		regdb = ERR_PTR(err);
+		return err;
+	}
 
-	return err;
+	return query_regdb(alpha2);
 }
 
 int reg_reload_regdb(void)
 {
 	const struct firmware *fw;
-	void *db;
 	int err;
 	const struct ieee80211_regdomain *current_regdomain;
 	struct regulatory_request *request;
@@ -1068,21 +1088,14 @@ int reg_reload_regdb(void)
 	if (err)
 		return err;
 
-	if (!valid_regdb(fw->data, fw->size)) {
-		err = -ENODATA;
-		goto out;
-	}
-
-	db = kmemdup(fw->data, fw->size, GFP_KERNEL);
-	if (!db) {
-		err = -ENOMEM;
-		goto out;
-	}
-
 	rtnl_lock();
 	if (!IS_ERR_OR_NULL(regdb))
 		kfree(regdb);
-	regdb = db;
+	err = regdb_load(fw);
+	if (err) {
+		regdb = ERR_PTR(err);
+		goto out_unlock;
+	}
 
 	/* reset regulatory domain */
 	current_regdomain = get_cfg80211_regdom();
@@ -1103,7 +1116,6 @@ int reg_reload_regdb(void)
 
 out_unlock:
 	rtnl_unlock();
- out:
 	release_firmware(fw);
 	return err;
 }
@@ -4085,6 +4097,8 @@ void wiphy_regulatory_register(struct wiphy *wiphy)
 {
 	struct regulatory_request *lr = get_last_request();
 
+	ASSERT_RTNL();
+
 	/* self-managed devices ignore beacon hints and country IE */
 	if (wiphy->regulatory_flags & REGULATORY_WIPHY_SELF_MANAGED) {
 		wiphy->regulatory_flags |= REGULATORY_DISABLE_BEACON_HINTS |
@@ -4097,6 +4111,16 @@ void wiphy_regulatory_register(struct wiphy *wiphy)
 		 */
 		if (lr->initiator == NL80211_REGDOM_SET_BY_USER)
 			reg_call_notifier(wiphy, lr);
+	} else if (!regdb) {
+		/*
+		 * regulatory.db not yet loaded; trigger an async udev
+		 * request to load it when the first wiphy registers.
+		 */
+		if (!firmware_request_nowait_nowarn(THIS_MODULE,
+						    "regulatory.db",
+						    &reg_fdev->dev, GFP_KERNEL,
+						    NULL, regdb_fw_cb_restore))
+			regdb = ERR_PTR(-EINPROGRESS);
 	}
 
 	if (!reg_dev_ignore_cell_hint(wiphy))

base-commit: 972c4dd19cb92e03d75b66c426cfade07582a1ba
-- 
2.34.1


