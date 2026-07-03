Return-Path: <linux-wireless+bounces-38572-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id b2+/HIR1R2ovYgAAu9opvQ
	(envelope-from <linux-wireless+bounces-38572-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 03 Jul 2026 10:40:36 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9306D7002FC
	for <lists+linux-wireless@lfdr.de>; Fri, 03 Jul 2026 10:40:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=JrzV7Ieg;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b="J/A9n0jM";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38572-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38572-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D106031494C2
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Jul 2026 08:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C78C34252C;
	Fri,  3 Jul 2026 08:25:40 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0F2233F8D4
	for <linux-wireless@vger.kernel.org>; Fri,  3 Jul 2026 08:25:38 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783067140; cv=none; b=fijEP3NP8PUhX9rJSh/d859Y11o5PfxRRKGE0dqA1lse+s6Zl8shsx1Prfv+eUytEhrmtenJjz7mw42aolYT63+JEYuIoqOu4dUOW2+Q4W9Dn5r1wl9kqcnPjRpK1z/qAypJw5KhJy6STwXxltk0IINg7pJPDRgmN9WojzJ5FBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783067140; c=relaxed/simple;
	bh=Dpg3iutRyWd7DBYhZ78u+W/RUMDGCc21uO4oxQoluhg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DJ3Eqco0yNzl3IaH/VUyc7rydfFYFAThm3m+nmEQdLlFKdlcp5dnKyxcwJDDBTr0Q7Wdxrjm30vyKRefrn9maLHvDYweSxYQZkCH+jCnsVWl+FM639iT9jCjscf5gC1cIV7SMCujE6NtgYcq5Vn0tIWUJR5jkEj6ZOlmkc9sAxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JrzV7Ieg; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=J/A9n0jM; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6635rqQ63123823
	for <linux-wireless@vger.kernel.org>; Fri, 3 Jul 2026 08:25:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=Dqpl1HMNYWdlwgZ0bz3ue6dFGRSJimYKIUv
	tcO7bB+U=; b=JrzV7IegLBpMqerxgT30Ft8BnWIoMWIEW0yvDptsSE4Y6iRAkp4
	GMZ1tsf4DKXwOsN/fnI34oa27dLYxVXL98o8Ogygbdx2wGGMqvx6ZRYCSNDL2sk/
	siw8BuANh99qIdlrjX2xyrD0o81V/mE0v1wKCkrkDxdgDVwTA6uXYdnBXP7HuJqA
	N5EM5g++8BIw/6OxiMme9WKbii4gqkbLO6m6JW9ALIRDfj59Oyx+OuN74UbwlSg+
	Z5JVzQKEGLT4R8oJERyhB+QZRfmryJIBoxgbNM1PeU0nndN/itxBdKKrUNmhwp/C
	v7MA6TqPGKlrWngXhNNQfjfLyz3T6hVcZEw==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f5qnpcds6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 03 Jul 2026 08:25:37 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-38112fd8b48so415499a91.2
        for <linux-wireless@vger.kernel.org>; Fri, 03 Jul 2026 01:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783067137; x=1783671937; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Dqpl1HMNYWdlwgZ0bz3ue6dFGRSJimYKIUvtcO7bB+U=;
        b=J/A9n0jM6DQNAVc2jhxots5sufFFbpDOEcS/WulQ8rL7lWmtuzeQz26Z3YbCDMrRfy
         tJeajrgOC1JoSgkGF5kU+bZaK7cyyCWZ0EdAUq2LjXXxhcBk97V6defK/0CQgFADc2/+
         OGOrQe2NfkuFYUzKaQzJqvt28P6eQcXjG4SWAEOYJFXnhgHBvMEmhUu9YBWwvs/iKOXb
         MTwjwaabtcC9tTKX5XoSluqADT0Ry06Vj5yRLSJmcHuQzvC4ueoI/J3+MuarkpuhU6gV
         efvt+McbvnlB6Vc3H3p9fMtieMizHwTr9sgaadfJfSZsPWtCLGjk226m8aAO4Me9myGd
         Ekyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783067137; x=1783671937;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dqpl1HMNYWdlwgZ0bz3ue6dFGRSJimYKIUvtcO7bB+U=;
        b=mmTjv2Q0aA79G7Zas5jiHRFEa7ZyjLwbdk1quiQdFfO4EB2h98SYl1WbcRtvPohWxn
         3xSSaHbqPM3y7DKBN6ZB3e+SZHPYDOYY/YC5pRNNET0Z6s+N8+0b3O1ZaT2Pewgjcp5t
         00QpCMfX/zIi3Xd+1gysZUXAGO43KI1HaISCLmlGsNermEZBf2jTmn/WzS+z7KBxXTq6
         QWz/et7p4OerQwz0U4Lk+z75sEgw8xEabaPzrBbdBoy1iC+Q86qaH+nOsfrhUe6r9AtP
         1TJv0xK2G4Vbn3JWWgiE7g975mjCz0x/dOrdh48zOCprMK62hyx79hGHrN1Rc+4A8ZBp
         T4zg==
X-Gm-Message-State: AOJu0Yw8v1eewQXGiT+M6IL1cYHEULZlcq6WLiEu0MhsyhlKakR0Z4RJ
	G14EsiUSRmXvU3WYX9C8cJp0OhR5pNcAe7DInTmDmH6bVTCpaxHKPkAxzovcmY0DgoKpZtmvnKd
	YZ8LGECc1cWHghglllBTAuUdLKgCCi8d+fkIN6+TPcjTQ2ogznmO6eAj5ia8X6yKfUI4nsTd2LR
	He
X-Gm-Gg: AfdE7cmEuCBWV4fYViTiM4l6OApfPdazD3wk/AZ/NaSzEBfJgJLqEKf7cSXKV75ltgh
	JFLhZ4waJSShNRhMYu0ewhXaD6pRSGMk7/zfNzP2Xt3UiFl1v0RGRAGRzKSSvzNFcckejVMhHqo
	PF8F2jKRFRSCcTNe0zw6oTrEQF36Iu0PKEXh9D1zvyuRdKLnnpotlk6W5NSBLPCdgIVjuITV38g
	xRAZwJ95Tzq9SFfrEjcAiyDN/SSNisitjS29/hAH0AFyc3SVrECTq0+W08xveHmbD5//WipOA54
	prCg6uBmao11agSwcKqXzsOdVSLpL05iNn6hR4D+ukgRgWEzLWO7jfpua50f/oWlJQnPsvUmZSG
	qVoJ+dZ9f5JxHA59fi4DyIHvDX2kK+/GyIFv8T++oMKmo
X-Received: by 2002:a17:90b:3fc7:b0:381:610b:e77d with SMTP id 98e67ed59e1d1-381610bf051mr561103a91.29.1783067136592;
        Fri, 03 Jul 2026 01:25:36 -0700 (PDT)
X-Received: by 2002:a17:90b:3fc7:b0:381:610b:e77d with SMTP id 98e67ed59e1d1-381610bf051mr561077a91.29.1783067135859;
        Fri, 03 Jul 2026 01:25:35 -0700 (PDT)
Received: from hu-peddolla-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f0bb84366sm25813484eec.16.2026.07.03.01.25.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 01:25:35 -0700 (PDT)
From: Peddolla Harshavardhan Reddy <peddolla.reddy@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH wireless] wifi: cfg80211: convert pmsr_free_wk to wiphy_work to fix deadlock
Date: Fri,  3 Jul 2026 13:55:23 +0530
Message-Id: <20260703082523.2629324-1-peddolla.reddy@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDA3OSBTYWx0ZWRfX+kiRnKUf3Zza
 5uKKkR63MBd7CKpB4dZe6JwwpGBoBZmc9vZIa49GGWXw030qT1F3zlIWlf/P2/TSMd8qAxZTNvZ
 feob2BaIenjnxyKWhstPZfrEwQ+YCPI=
X-Authority-Analysis: v=2.4 cv=FoI1OWrq c=1 sm=1 tr=0 ts=6a477201 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=layujpsc8kOD_uEhCSAA:9 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDA3OSBTYWx0ZWRfXwVv3/6/U+rYJ
 tlQa62V4r3d0WrCsfvHxNA3+l/rgNPbK6LSdwqxj/v1eWnMsvuea/YTWeRVLyBE9Ec3bQl6g4KO
 DpTT+3uLz2fesdQhdjWy2WBUBndUGuruvC33j+eeg1GjnSjtgqngKah0d50Mx6XXuGFwlDKT5eJ
 qUEOZaHW6dYVYY+9psYS9WxriyYN4CaBIaPWoPGLF7Uosk8zWvLU5E3DFPopY/J4C1Uc95TiKSa
 1DYwh/E3gjQxIsB2SbA7ncq/aBuRG0fCDmJUG64bonAsdeYhayZ3kG93l5ARYbEBoL4Nt26BgQJ
 CQSJ8yq97EJj7A1a0vS+cSm2/6nWkEclYg7f4RN1+99rSJd/sy7rL8JKykKggIVZ8/3XPvDDDAD
 sT312iBEx/6GUu3VKDUAshhI0IAa58Zu2k7jn+sgrvk+n6dwxRjq3bFonPiyxwYMmOCbVs7Za+C
 M3j/aeaVllGWQT6vMTg==
X-Proofpoint-ORIG-GUID: EAhDTN3ed3chdVmRxkd76zgA9Ok2wDHC
X-Proofpoint-GUID: EAhDTN3ed3chdVmRxkd76zgA9Ok2wDHC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 clxscore=1015 lowpriorityscore=0
 priorityscore=1501 phishscore=0 bulkscore=0 spamscore=0 suspectscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607030079
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	TAGGED_FROM(0.00)[bounces-38572-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:johannes@sipsolutions.net,m:linux-wireless@vger.kernel.org,s:lists@lfdr.de];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER(0.00)[peddolla.reddy@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[peddolla.reddy@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,qualcomm.com:email,qualcomm.com:dkim,oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9306D7002FC

When a netlink socket that owns a PMSR session is closed,
cfg80211_release_pmsr() clears the request's nl_portid and queues
pmsr_free_wk to call cfg80211_pmsr_process_abort() asynchronously.

If the interface tears down concurrently, cfg80211_pmsr_wdev_down()
is called under wiphy_lock and calls cancel_work_sync(&pmsr_free_wk)
to wait for any running work. The work function acquires wiphy_lock
via guard(wiphy) before calling process_abort.

This is a deadlock: wdev_down holds wiphy_lock and blocks inside
cancel_work_sync(); pmsr_free_wk blocks trying to acquire that same
wiphy_lock. Neither thread can proceed.

The same deadlock is reachable from cfg80211_leave_locked(), which
calls cfg80211_pmsr_wdev_down() for all interface types under
wiphy_lock.

Fix this by converting pmsr_free_wk from a plain work_struct to a
wiphy_work. The wiphy_work dispatcher holds wiphy_lock when running
work items, so the explicit guard(wiphy) in the work function is no
longer needed. wiphy_work_cancel() can be called safely while holding
wiphy_lock - since wiphy_lock prevents the work from running
concurrently, wiphy_work_cancel() never blocks, eliminating the
deadlock.

Remove the cancel_work_sync() for pmsr_free_wk from the
NETDEV_GOING_DOWN handler. cfg80211_leave(), called unconditionally
just before it, already cancels any pending work under wiphy_lock
via wiphy_work_cancel() inside cfg80211_pmsr_wdev_down().

Fixes: 6dccbc9f3e1d ("wifi: cfg80211: cancel pmsr_free_wk in cfg80211_pmsr_wdev_down")
Signed-off-by: Peddolla Harshavardhan Reddy <peddolla.reddy@oss.qualcomm.com>
---
 include/net/cfg80211.h | 2 +-
 net/wireless/core.c    | 3 +--
 net/wireless/core.h    | 2 +-
 net/wireless/pmsr.c    | 8 +++-----
 4 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 8188ad200de5..3751a1d74765 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -7265,7 +7265,7 @@ struct wireless_dev {
 
 	struct list_head pmsr_list;
 	spinlock_t pmsr_lock;
-	struct work_struct pmsr_free_wk;
+	struct wiphy_work pmsr_free_wk;
 
 	unsigned long unprot_beacon_reported;
 
diff --git a/net/wireless/core.c b/net/wireless/core.c
index 3dcf63b04c41..b6bb25ee89cd 100644
--- a/net/wireless/core.c
+++ b/net/wireless/core.c
@@ -1613,7 +1613,7 @@ void cfg80211_init_wdev(struct wireless_dev *wdev)
 	INIT_LIST_HEAD(&wdev->mgmt_registrations);
 	INIT_LIST_HEAD(&wdev->pmsr_list);
 	spin_lock_init(&wdev->pmsr_lock);
-	INIT_WORK(&wdev->pmsr_free_wk, cfg80211_pmsr_free_wk);
+	wiphy_work_init(&wdev->pmsr_free_wk, cfg80211_pmsr_free_wk);
 
 #ifdef CONFIG_CFG80211_WEXT
 	wdev->wext.default_key = -1;
@@ -1747,7 +1747,6 @@ static int cfg80211_netdev_notifier_call(struct notifier_block *nb,
 			cfg80211_remove_links(wdev);
 		/* since we just did cfg80211_leave() nothing to do there */
 		cancel_work_sync(&wdev->disconnect_wk);
-		cancel_work_sync(&wdev->pmsr_free_wk);
 		break;
 	case NETDEV_DOWN:
 		wiphy_lock(&rdev->wiphy);
diff --git a/net/wireless/core.h b/net/wireless/core.h
index df47ed6208a5..f60c66b88677 100644
--- a/net/wireless/core.h
+++ b/net/wireless/core.h
@@ -586,7 +586,7 @@ cfg80211_get_6ghz_power_type(const u8 *elems, size_t elems_len,
 
 void cfg80211_release_pmsr(struct wireless_dev *wdev, u32 portid);
 void cfg80211_pmsr_wdev_down(struct wireless_dev *wdev);
-void cfg80211_pmsr_free_wk(struct work_struct *work);
+void cfg80211_pmsr_free_wk(struct wiphy *wiphy, struct wiphy_work *work);
 
 void cfg80211_remove_link(struct wireless_dev *wdev, unsigned int link_id);
 void cfg80211_remove_links(struct wireless_dev *wdev);
diff --git a/net/wireless/pmsr.c b/net/wireless/pmsr.c
index c8447448f3a5..2c8db33d9c30 100644
--- a/net/wireless/pmsr.c
+++ b/net/wireless/pmsr.c
@@ -807,13 +807,11 @@ static void cfg80211_pmsr_process_abort(struct wireless_dev *wdev)
 	}
 }
 
-void cfg80211_pmsr_free_wk(struct work_struct *work)
+void cfg80211_pmsr_free_wk(struct wiphy *wiphy, struct wiphy_work *work)
 {
 	struct wireless_dev *wdev = container_of(work, struct wireless_dev,
 						 pmsr_free_wk);
 
-	guard(wiphy)(wdev->wiphy);
-
 	cfg80211_pmsr_process_abort(wdev);
 }
 
@@ -829,7 +827,7 @@ void cfg80211_pmsr_wdev_down(struct wireless_dev *wdev)
 	}
 	spin_unlock_bh(&wdev->pmsr_lock);
 
-	cancel_work_sync(&wdev->pmsr_free_wk);
+	wiphy_work_cancel(wdev->wiphy, &wdev->pmsr_free_wk);
 	if (found)
 		cfg80211_pmsr_process_abort(wdev);
 
@@ -844,7 +842,7 @@ void cfg80211_release_pmsr(struct wireless_dev *wdev, u32 portid)
 	list_for_each_entry(req, &wdev->pmsr_list, list) {
 		if (req->nl_portid == portid) {
 			req->nl_portid = 0;
-			schedule_work(&wdev->pmsr_free_wk);
+			wiphy_work_queue(wdev->wiphy, &wdev->pmsr_free_wk);
 		}
 	}
 	spin_unlock_bh(&wdev->pmsr_lock);

base-commit: dc59e4fea9d83f03bad6bddf3fa2e52491777482
-- 
2.34.1


