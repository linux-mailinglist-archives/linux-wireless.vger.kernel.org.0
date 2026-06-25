Return-Path: <linux-wireless+bounces-38084-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id KIA4Okv2PGpDvAgAu9opvQ
	(envelope-from <linux-wireless+bounces-38084-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Jun 2026 11:35:07 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 539786C4476
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Jun 2026 11:35:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=QjSA6MIs;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=OmRvrhvR;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38084-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38084-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 89B5B3082E42
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Jun 2026 09:31:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EE131862A;
	Thu, 25 Jun 2026 09:31:07 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95E9C23BD06
	for <linux-wireless@vger.kernel.org>; Thu, 25 Jun 2026 09:31:05 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782379867; cv=none; b=D/0B+WvN468pLwEmQLUhEhbAuCNOR5KbA4UhNDSLdn0oKWbUnNrA4M/a8Xq0o+Enrg6LnZ1kY+rGjNfpO6IAqtnuXyxdGLMKEX18lcUOTDtNblMhnp8B6ZD7Yna2DwQS/zOlftOjdiRdxbGqR190htv2mzY67N4S2wtmFBTG8iI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782379867; c=relaxed/simple;
	bh=mQvDXGuFl+jqcbRgvUrA6Xa5X/vdooMYSj7vMHeoqMg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=k+Ype5H0QXS82vH4Q+RTTOogf36HlpIqZdsmfkWprP0LhEegp9Isqx0rO5aucScgNjiqTBXn+c7RqN/eXlaTFp8xagWuJWGd56/sN3rQM+ipqW+JiZpYCElZNee9KjTswKXkYLEUBef0yrfYUW7GL8DvG5d7QTEBQpqjpHTvn9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QjSA6MIs; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=OmRvrhvR; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65P8p6n71921058
	for <linux-wireless@vger.kernel.org>; Thu, 25 Jun 2026 09:31:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=A8i4ELAn3hofm7K6gWFXeVXwUUL5ubI2kR1
	B31JwXAg=; b=QjSA6MIs8fKaH/YFZknC9R0aVp1aIYcA7J31KqkXdVINdVBun+v
	hFlhwSJlLLONu50/U4ANdiM5LbQhGdVZ4aE/qE5e4BzOb9W1mdYaDO2ehu3jufLO
	yFjFkNy9A55l986a8lMb+aaY7SWHYnZZwQtQyd4O2NqVu/luJhIpOVRF3U/vfzHp
	Q5cvsVaihCCMO37lynjQlTckQIlrl4CzrwwyMSLgLlGIMV1gPUte7Kxd3bJCIVbB
	ZDpVfvU6NAGirq31AcoFkiOogQpptyr3ProJHaQpCIEUXDvOsn3gN7KgJBVvSXcb
	TAwWl8KT1RmejF+ZiMu1kPiR/knIDKkKFIw==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f0uyqhdad-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 25 Jun 2026 09:31:04 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id a92af1059eb24-137f3465368so3846088c88.1
        for <linux-wireless@vger.kernel.org>; Thu, 25 Jun 2026 02:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782379863; x=1782984663; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=A8i4ELAn3hofm7K6gWFXeVXwUUL5ubI2kR1B31JwXAg=;
        b=OmRvrhvRtVikcviM3J/R32v6YyyDCUzSTof8txm1Oggg9faxInTfdoq7/oi1eJ+JrA
         9h/aaJb4C31AJsjRBShk/JoDgZrg4HWpexv2gwciITPelXG/+0EKoC9erYkHS/5K6U3r
         1oVrPrybK+kQYTlW8y1736GgRi+QLxQLOoHpWYLiAIb5pQL0l7CIkH2VHtN280WJ+Uk7
         dRnQBJrU5yBMXDp6rC9n+ZJP7lJbEMdeX8HY8xHhYKLb1iLXtcYyHqRA6GqRjegrY0yj
         Dbo5cwxlGv51YhhLj6LfqEdJBahSg3RI9dWvQ060xNfHv+CvDBkku4u49XDeD6P2D2I3
         7ZeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782379863; x=1782984663;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A8i4ELAn3hofm7K6gWFXeVXwUUL5ubI2kR1B31JwXAg=;
        b=SXNljyNsWIbzGWvwtreYcJp6Z3RHcgk9q51sn8sZH0c6W+vF/svPkJ6fKdpWtik7z+
         gZaEqs718sjhmql+gU+B6jjwGzupRu2nBg1HX+Mxd/1i3ls10fhVnWuZjqR6j3bw0lGV
         LdTAEcqIISTXC0YmZQtYgTp2LiaRxiEW1q+FgJdPcNyzWMSYhRmuMCdv0E/yXU7nE6Pp
         GIQlEmzFUOx5w5RH+cCREyhgLPi4M+PpQ0t0do2iCpkXCT7NR5xPcWcvzsdWMv6Oh4iH
         Tb2S6+0bPq00oau/OrIDppUpazIPCRGSVuFXX4SriNNJqVTJrF+i1NG1BptlYJHkhYp8
         guMg==
X-Gm-Message-State: AOJu0YxqBWc2beF56L0TvK2qnNV592xo5W7RwwwkL6+XGM+sT8ChQdLM
	s2JkafbcHLgPj6ojL+3Xz3+aHgOnX+jpycqnzOF9mNHSPR1P1P8xFhGShuIwR6fZ6+wP6kgCW4t
	aGcLJ3RTfI5+5iscGEqHMPYGmDO1fbznyKQz+Zlyr7s9Wr08rP7nSvnpyqBaOfhtOVUBSqvnZv+
	he6w==
X-Gm-Gg: AfdE7cmuPqmqvx5rOV3vkWSsvx0y5/6Q35ubmMG5dddICHTu20gvlr2On2CxD4bHasq
	SyI3MCI5u05jRxEbXGDLiaWd9r0JenJjncCq8lOE52pZyKDJM26umMTO6qaQV2RRshmXMsjgWLq
	x62UQyTDc/qEYb+0spAIN7DzdCoMse0Kxqbcm1E15SwDXRnU2L8JNkl7gsyu8Moi6V5/tzXejjD
	El+LUWPiuHP9nosJfzsYDOSNOY38bb4COh2RYqvKKHdNpm6fjHYA1+ESqtfXz0cla9eJ0/fXxhr
	wBeAODw1t8bQlDU+y+CBF2vgW1sLZsAnLZGjWxl/NxYUVbINBAUptnsi3/f3mEL+17rR0mms7Oc
	1KI8DkroUJaYRA8ofFbOTFwFG3Z9YI7hnYq6mnnhjOr8=
X-Received: by 2002:a05:7022:6621:b0:138:6c:477f with SMTP id a92af1059eb24-139dbbc65abmr1710241c88.34.1782379863191;
        Thu, 25 Jun 2026 02:31:03 -0700 (PDT)
X-Received: by 2002:a05:7022:6621:b0:138:6c:477f with SMTP id a92af1059eb24-139dbbc65abmr1710210c88.34.1782379862559;
        Thu, 25 Jun 2026 02:31:02 -0700 (PDT)
Received: from hu-kkavita-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-139d90e95c6sm9375179c88.11.2026.06.25.02.31.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 02:31:01 -0700 (PDT)
From: Kavita Kavita <kavita.kavita@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH wireless-next] wifi: cfg80211: fix regulatory.db async firmware request blocking __usermodehelper_disable()
Date: Thu, 25 Jun 2026 14:59:04 +0530
Message-Id: <20260625092904.2097371-1-kavita.kavita@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: VjfpfXewiRqhUKNYMwiYe0SjEAlEVRzB
X-Proofpoint-ORIG-GUID: VjfpfXewiRqhUKNYMwiYe0SjEAlEVRzB
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI1MDA4MCBTYWx0ZWRfX1ZqVRqrHrzwB
 Zemmwt0ZePJiUczDhNLNyLDd2K4rgrbtIYLNEl4IxRiSflCfDBqh/82O6GpFT+vz06uSKtDoW5a
 P7XheC1Kfktevri2YXSMbTchHraihp0=
X-Authority-Analysis: v=2.4 cv=EsLiaycA c=1 sm=1 tr=0 ts=6a3cf558 cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=KSijteOHSPyhfr2HdScA:9 a=Kq8ClHjjuc5pcCNDwlU0:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI1MDA4MCBTYWx0ZWRfXyHDnhVwN08eV
 qi13WG8xXo/+SpLKZRA1ECIksbjntxfnMNcdw1JMS18lc0pYfPh0NAuYdZcNQyNQBd0MUVu/Sz9
 glgv7s3psKy0CWgX5Gs6uZJ/tXUulIBA4CVw6xtgGMjLZRcWVaIcvlnQQbnKO6UQiQ9g+UItynQ
 bkoeooUHLEI0I7ZExYJjmDFCLOUlv2PuFiP9kCJOkFsSkimLZ+Fadd/w92B8MbF1oEfXJRXe1vY
 yzSbGVreO4X6n352nyCNLIU7Mjhtw5EM2wLOTlmPbzBnYzkjM8Q/R3Y9dHCYng+qurNU+DpaI2U
 uZ5TlWo/C7S+KjnYvIoBb7TYyrD4Db/1o+Qg8apyvpib+NOzog/1rAPaCXlEluV1CF5X3Is5RYz
 dPSqHuvTAB9aaqqUZ6xpLsN4eF3TkWVGpHXqefrj+R5czy9GEonqQUFfV6sqT+MAFUB9f6V5igX
 KXcqemyEepBEGq15BIg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-25_01,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 adultscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606250080
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	TAGGED_FROM(0.00)[bounces-38084-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:johannes@sipsolutions.net,m:linux-wireless@vger.kernel.org,s:lists@lfdr.de];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER(0.00)[kavita.kavita@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kavita.kavita@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime,qualcomm.com:dkim,qualcomm.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 539786C4476

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

Signed-off-by: Kavita Kavita <kavita.kavita@oss.qualcomm.com>
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


