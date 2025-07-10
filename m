Return-Path: <linux-wireless+bounces-25184-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC6CCB005C9
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Jul 2025 16:53:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AAEFF164DC4
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Jul 2025 14:53:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7CAA273D9D;
	Thu, 10 Jul 2025 14:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="EA4XzKyM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ABBD2741A2;
	Thu, 10 Jul 2025 14:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752159082; cv=none; b=GZ5WBa++ScmNAR59qr1nBB8p1XisrZFx4XluGpo+EQYDVuqlFluWuWdDJaMoMXR3gvgVoERO3CFjVc+KSVmJ5x0qp6QXuSZggqjYjlhngjb40dD0flpLiiCIe39w1YlYVUqi929ItbgfCQlm8O8FE12oiIJVqD77sBj3b4qoyks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752159082; c=relaxed/simple;
	bh=TGQhJa4lx/cHTe/LhorFNJ6YsvdTYs1ocPu0WiZ/mqw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=T7tx0JJB1LFkEgZPFtufsDzkZDCeiC25h9gMyATL97ja7aI1OZxWtCXRrq25AoQZc/vgZmj6fHPQeAqhQTG2odWRulUmBUk9U26Gl/MbHhDdpyY/10qYsatbDMJwfDaQfd907RxigD96X//X+GXBXKt2eZmKflHmcdI0wEiUsFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=EA4XzKyM; arc=none smtp.client-ip=54.204.34.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1752159060;
	bh=1+Kx79UUMTR+HBWcwOxCrMocpYqceV3PK2nUmMA9qKk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=EA4XzKyMy+oCLzXdqkxN3+h6VsacYMEIIPKY/T6eXvofUXrtjX1EwSuiG9Ust4138
	 ENtVeV+OFGWP3YTz7zhDhQhIKbFEF19jexIPglyPRaPrhePGNoYSR7ph/8MkzhZjOs
	 Spj67zc97LlWlkSSK5a82EVtfY4a4lkwqKUfifNE=
X-QQ-mid: zesmtpip3t1752159047t675b042c
X-QQ-Originating-IP: 7KCsD7aX+T8LGM4sbXWAQTDPEH/RCcAWQIorEStaNr8=
Received: from avenger-e500 ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 10 Jul 2025 22:50:45 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 17183148968099377952
EX-QQ-RecipientCnt: 7
From: WangYuli <wangyuli@uniontech.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zhanjun@uniontech.com,
	niecheng1@uniontech.com,
	guanwentao@uniontech.com,
	WangYuli <wangyuli@uniontech.com>
Subject: [PATCH] mac80211: fix unsigned int link_id format specifiers in trace.h
Date: Thu, 10 Jul 2025 22:50:43 +0800
Message-ID: <2D6CF44B8B2BA412+20250710145043.331831-1-wangyuli@uniontech.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: M/ESU50hZOEXtAvbZgXwKigzfcc5LBLnkc1EV1Tp3P/7QWcuWZ8sGy8a
	/yudt5aYznFHl6NAfeC7iyc68pzy0mRQj5AOokFvpg8rbMnFZnCJqRpMFibgnh6YbB2dHLu
	XXa7baQg/Ip9ihUU1uVkmKqygcONIRZQiSp+921U/XvcOh7+qR3HzdpsmAKhgdBWuxhoKrT
	HK462cbuLri5zFL1VXxnljemAkatWn8uS/2/Zw7yNYmi0sEer+7ZPznloW5Bt8yAPDLWNOs
	pOfbKclrmZErgjJyNgjeBoKkKlgZBsAUTLIPBLcbASz/MCw6wJEVmSo/lYFfS5ER3bULJYV
	9cuRB6NkQ4aVb91LMRRJJjGRJsBPUxAuXQzYfBS/v1dqKKntrs0zdWyXyGO4MvF1nb5SJKI
	eJJDgtAslgdQMNY442i2MUFrFEhR0JOV5XCX+onaCU4ByPXnxrHrXfqd8TskAkOs+u0K1aI
	EVuHxA1Y3uMWRIC24w6j12bwk6NghyGYvM/phwXITtU1ABxby4kmJDw0D4TUbjNscZT+Gdh
	uHFYgiugO79cMmPYs6wUGa7tHoBj0eFRDD2JSFROH+vuumRh7sMLlMdFl23UoCRkl9SYRvZ
	dwos7+V7Vx6sWIcU6atDSn6hqnZ+J4/jUHOqzuLjjsVnshNY4+Fgd4gpYpAz1lI9kX9MB/E
	gxG0QAT3qgXIOE90IYTFSTHklRYv7az4R5OCxRxzjZKEu5NKBJjm1yysvjMbBihaizGILsU
	8S3mHMYi375PdHXmOaRebyITDIIV2EqzDhMyxgFMmBaz5gzAUHiEWW43QBbfJ1goTy4p9g0
	VEHrftkenMpMwn/LTSjLHjZvlQnLRKT1vHm6xJJXgcEi9n/MIgOfLUin2YMaSBfi0Inr7ed
	OfjQwQbtW66gKPt5skKHB395vesfqLktykYYDuL9prUCe9wx1y0oVkEL6SQJTkTd7bDVgqa
	jNIj5WiQ4+nbdilOgCviSDMlyDW2EwsjUwxquFkJXWxRrgdTq+Pk5x9iJ3rSCdbIdHUHKfE
	P7rvQcjkZzMChf1fGNXkPznJ8ktbwe7BqlUVHM+1gjWRUHaK8h
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
X-QQ-RECHKSPAM: 0

Fix format specifiers for link_id fields declared as 'unsigned int'
to use %u instead of %d. This affects several trace events where
link_id was incorrectly formatted as signed integer.

Signed-off-by: WangYuli <wangyuli@uniontech.com>
---
 net/mac80211/trace.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/mac80211/trace.h b/net/mac80211/trace.h
index 72fad8ea8bb9..cd1e0c4dfe2f 100644
--- a/net/mac80211/trace.h
+++ b/net/mac80211/trace.h
@@ -1070,7 +1070,7 @@ TRACE_EVENT(drv_conf_tx,
 	),
 
 	TP_printk(
-		LOCAL_PR_FMT  VIF_PR_FMT  " link_id: %d, AC:%d",
+		LOCAL_PR_FMT  VIF_PR_FMT  " link_id: %u, AC:%d",
 		LOCAL_PR_ARG, VIF_PR_ARG, __entry->link_id, __entry->ac
 	)
 );
@@ -1785,7 +1785,7 @@ DECLARE_EVENT_CLASS(local_sdata_chanctx,
 	),
 
 	TP_printk(
-		LOCAL_PR_FMT VIF_PR_FMT " link_id:%d" CHANCTX_PR_FMT,
+		LOCAL_PR_FMT VIF_PR_FMT " link_id:%u" CHANCTX_PR_FMT,
 		LOCAL_PR_ARG, VIF_PR_ARG, __entry->link_id, CHANCTX_PR_ARG
 	)
 );
@@ -2194,7 +2194,7 @@ TRACE_EVENT(drv_get_txpower,
 	),
 
 	TP_printk(
-		LOCAL_PR_FMT VIF_PR_FMT " link_id:%d dbm:%d ret:%d",
+		LOCAL_PR_FMT VIF_PR_FMT " link_id:%u dbm:%d ret:%d",
 		LOCAL_PR_ARG, VIF_PR_ARG, __entry->link_id, __entry->dbm, __entry->ret
 	)
 );
@@ -2912,7 +2912,7 @@ TRACE_EVENT(api_chswitch_done,
 	),
 
 	TP_printk(
-		VIF_PR_FMT " success=%d link_id=%d",
+		VIF_PR_FMT " success=%d link_id=%u",
 		VIF_PR_ARG, __entry->success, __entry->link_id
 	)
 );
-- 
2.50.0


