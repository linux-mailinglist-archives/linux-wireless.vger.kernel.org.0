Return-Path: <linux-wireless+bounces-29165-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9697FC73672
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Nov 2025 11:12:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0A9CA4EA5C4
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Nov 2025 10:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E98D2D0298;
	Thu, 20 Nov 2025 10:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="dKj/t50D"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E14D2314D31
	for <linux-wireless@vger.kernel.org>; Thu, 20 Nov 2025 10:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763633349; cv=none; b=K20smpBDRwkpOdqsj2hMlHfa6aRht8YUUOfbSgWSo+VfB/sxyJSw8iDKw4bXCm7QTi8d51rnlBYoBJPfhWpZ++RpdEQ/WXIys4DZHjVF7Z4/UOfv7wCZn0Kj2CdAv0QJFN9bJQ9DHRpse0MzPbUvZ9bSs0YJWWsU0ENeT6GWsI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763633349; c=relaxed/simple;
	bh=rDURe3yjNs5V6ZlnCfP0DZCi3QTLY5NLzZcGvojr1Qo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=chaSEM2ajkmujjykbuSKwQ5FGPuQRWlfFojFgjQTheoFMFpFFas6EXRN6avSuQvQ9MqurmloFm0E19fEaISC80vLAwdiY3I3kjcOuXXmuw21ximD47NXUHLGb7kplor8y1tI4tI6LrPDw0BgSezAHMNWFPI83cCWnHI6klgwjEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=dKj/t50D; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-477a219db05so4429725e9.2
        for <linux-wireless@vger.kernel.org>; Thu, 20 Nov 2025 02:09:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1763633342; x=1764238142; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1uXF9VFsFAfpKzQx2DlfjhIQ6Wp5BaO8U1tk/bxW/XY=;
        b=dKj/t50DF7j2JOmTkvjIctwjkkI7J/up3X+zp30n63JtHilxQHuIVV5yAXPgBesxtp
         +/22xCYcj7vNjGDj5No69V2SRMe5eYJAS1Fzm9Nju1yi5ScrHIAbXrLj2hEhxda6uFxN
         ia7YkZMoop1o9Wi5fIqC8BuS+K3I7D/+RvjWT8YCsncRDmOvhMg2BQIyOcs1oqtHUOCm
         HRUIuZy+dbrKncy5ixVVefdgi0AEVAE540ESERhzOJL3frEf74LFEO49FFd0iZJicH8s
         C+a/XqXzc7BAIVXc9sdMV0lcqcEaQxFqmvqe9KICX1iyRsITHeu/H6bHVWnL64XTxWI6
         E+tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763633342; x=1764238142;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1uXF9VFsFAfpKzQx2DlfjhIQ6Wp5BaO8U1tk/bxW/XY=;
        b=po7bP/B2ShxIRk5GW9qmsM43VyqOmx2tQV0Lwtk4XGKS3aeHdiRvB1YRcJ6vlwQrd5
         ai13Obf1Jcj41BZ946UiAR2HDT3t0ck9p3esmEN7eZCiD8mCTRHY49/3j9nDaWdLg7KI
         vMxTC0zT5Lkk+h0Ktth8++wrvcj6+SVYcuPDgtcXVSBqILL/UZKw/qmvcaASKJAor122
         cdHpe2l0/slf2vVi1z2Km33C5V25jsHvrwB0D3S3iMbhl/vT/SaHYyccJeExjqIXRnBx
         kKt6Q72vGssxMlwVhTzsz1MzhRMMdJAJGUAmt5ZQQkEhEgjCZDC9ZPXP1euUHtL8NXcd
         Jajg==
X-Forwarded-Encrypted: i=1; AJvYcCUCUqNmc6VqRZKSqyxJ1F16JHf0XC/LO2UeR1OGM0U9+gi3tyUkmUflSsulO0va81+d0xopiQMz6pICvCppFA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwGY+uNLKHQVESvslrsJJ81fZnVKrGiUOS23mPX+eo14cO/Idrh
	EiZ7cDjGuv74c072JXI9VcSiEBPTpRVEHaHANVTdLkukJrHcV2ltGw96/jZ27OGsYdc=
X-Gm-Gg: ASbGncvdv2yD9tn0wHUnu9TvcV+y9vHzuGoa/6r+y0/ObYM2vXxvw/lXCFr5coRSMkU
	K/b85h3Cj4XzqvOqsQKlh/oXVENSMNzETlbK9Il3pl1kr4KiRC91pnb1m9ZyFFQ5NhySajegZMR
	U4tDU4AtR3LPbxkVcuyG+rIhVgpHqhjAti4rwcuyavPSJTIkN3iXroxK35rMpJcQW7g5U/Vr7ld
	ykDhYzYpgiTwbUPN3J/BwKeo3/eV1pkYeaPFaK10ayiUZilTVULCeeLlPPggnFgCKJi7Vj1Sy8O
	NG4PbYfUoKN1v1pVHJXB/ZwUVOYwn7tiIuW3g2UwpxPoL5Cu+QDNwrbtE7F6rJVZJQXlkawe5hl
	+ebuUMeoL4athnSBBv9AbSCMdDZvM3EiYSWjCC3ZBI9lR0IWr9eZ54cPB8ACeWUKL+G5FDA7o4+
	Oluch3f/OeioOZnhq7NlqOEXas5xHotDvnW1s3IhMOuWYTCA==
X-Google-Smtp-Source: AGHT+IFG/fGQ5Vb3wK7EPPRO8U/BHcMlM5LtB9eAhXpEGncQmbfbL4oc/JbNB057Uy13+oD8TN5Wqg==
X-Received: by 2002:a05:600c:c492:b0:471:9da:5232 with SMTP id 5b1f17b1804b1-477b895a76emr25976625e9.15.1763633341685;
        Thu, 20 Nov 2025 02:09:01 -0800 (PST)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477a9de46cdsm58914125e9.8.2025.11.20.02.09.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Nov 2025 02:09:01 -0800 (PST)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH v2 2/3] wifi: iwlwifi: fw: replace use of system_unbound_wq with system_dfl_wq
Date: Thu, 20 Nov 2025 11:08:49 +0100
Message-ID: <20251120100850.66192-3-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251120100850.66192-1-marco.crivellari@suse.com>
References: <20251120100850.66192-1-marco.crivellari@suse.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch continues the effort to refactor workqueue APIs, which has begun
with the changes introducing new workqueues and a new alloc_workqueue flag:

   commit 128ea9f6ccfb ("workqueue: Add system_percpu_wq and system_dfl_wq")
   commit 930c2ea566af ("workqueue: Add new WQ_PERCPU flag")

The point of the refactoring is to eventually alter the default behavior of
workqueues to become unbound by default so that their workload placement is
optimized by the scheduler.

Before that to happen after a careful review and conversion of each individual
case, workqueue users must be converted to the better named new workqueues with
no intended behaviour changes:

   system_wq -> system_percpu_wq
   system_unbound_wq -> system_dfl_wq

This way the old obsolete workqueues (system_wq, system_unbound_wq) can be
removed in the future.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
index 2ce55859641c..e5f31b82339a 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
@@ -2933,7 +2933,7 @@ int iwl_fw_dbg_collect_desc(struct iwl_fw_runtime *fwrt,
 	IWL_WARN(fwrt, "Collecting data: trigger %d fired.\n",
 		 le32_to_cpu(desc->trig_desc.type));
 
-	queue_delayed_work(system_unbound_wq, &wk_data->wk,
+	queue_delayed_work(system_dfl_wq, &wk_data->wk,
 			   usecs_to_jiffies(delay));
 
 	return 0;
@@ -3237,7 +3237,7 @@ int iwl_fw_dbg_ini_collect(struct iwl_fw_runtime *fwrt,
 	if (sync)
 		iwl_fw_dbg_collect_sync(fwrt, idx);
 	else
-		queue_delayed_work(system_unbound_wq,
+		queue_delayed_work(system_dfl_wq,
 				   &fwrt->dump.wks[idx].wk,
 				   usecs_to_jiffies(delay));
 
-- 
2.51.1


