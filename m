Return-Path: <linux-wireless+bounces-3420-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCFCE8509F3
	for <lists+linux-wireless@lfdr.de>; Sun, 11 Feb 2024 16:11:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BE4F1C20DEF
	for <lists+linux-wireless@lfdr.de>; Sun, 11 Feb 2024 15:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E95085B669;
	Sun, 11 Feb 2024 15:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hdRaF0Zv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15FBA5B675
	for <linux-wireless@vger.kernel.org>; Sun, 11 Feb 2024 15:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707664241; cv=none; b=G9t1XPLVMu8D303u6nqO04qdA21wtiBrfJP6Aw9vwAb8nJXCDFteALQ9diWgF4WclUwIU6ddP9aQNt1N2Jm8JGi+UY2BFyN7P1s2GLMD4j/BErK2paaQGyZ3z0GY8RLETQenJJwZudUCAk54b7fhCDUli3SAZGWqoXjNcJtA5Es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707664241; c=relaxed/simple;
	bh=ut070mIF88OxnV8iI5X3AUb+zVQsyrGpevRras2F7+4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XVdCChRZWXqUAB03u2cer/SjMG94ifKEqVlL2/vGw18VgHlW2jz6UX+ZLbtq7TL2DkQzVPBhSLl+rNTmRpDy0o6x8T/zL/rGI1qKc6EKf8zzzAmcrfPQ9aC/6+2gxAVBXg7cMbFgTps06kFGnUTDWmGGEjPsiwj9OMigXxWQT2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hdRaF0Zv; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-33b6c89c5b3so681427f8f.0
        for <linux-wireless@vger.kernel.org>; Sun, 11 Feb 2024 07:10:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707664238; x=1708269038; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cDV/EzkBJSPm/U6XnvIw/DqpzOJLJMD4+Ms07MVvFc0=;
        b=hdRaF0ZvkzRhRNMKDIXV6dkLkvTvPVLCoLZn17MbV3hxFNDOlyBsABbAJ46CuJT+Q1
         dvLfkoVnbRKypazFo7qi29Bau5rzGjRotBD5xQqjmQbRv4gnHYyfn5Ym/2JVrErkBQmk
         KE0I2gvYgV8kGUAEis43EejDw9M0MDwMKl/eA5ctk8U5r5qGsin450/M2/1Z5To0mdY6
         esgEXp8+1VFGJxJFyjoyFb8NgefuGjOl85r/XKFoHgVV1TbtCOJJOwVD+UI7FTwY/zBK
         1UhJ3B8yjj1ZdF9Totgge9E6EutuJSbSECy1vxMKMuiJY3gJPEBXAck4dLii1v6k9uGj
         9TtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707664238; x=1708269038;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cDV/EzkBJSPm/U6XnvIw/DqpzOJLJMD4+Ms07MVvFc0=;
        b=TWQMZG5HPduPINi8idu8trr2kqa1Y+8C3cKuYnBwevfvR+oPjuFJ7eNObXSx6IXjo0
         53iZOrPkzFmil72xjNzHaZgiulQMBJJFJao9Ptt6BWSn+dPqm4bRsfgl+uVk9VUqfegE
         WriFSZBaqZuWlMZmE5m6DMvytXE7erPsbkq8IDx8FSXoyOmcqFucENsI3KuClJmOYhtN
         tSPDlBXb72v6is3zhs4YOPcwC90JMFID/td1w8aewR30mkqe2hMlJGrrYv5hwGRv2UZG
         ZVuyxpWjdQ0X7lrFkUTSR3IdeXd3G6JGh/IEPeaEc+1vndIf19PaUPpA6jptIGPFyDXe
         BMDw==
X-Gm-Message-State: AOJu0YxIbx+YyqOCWWSK3P/FZTySgC/JlbpQwMNg+7WM9YgAS5nt6QYp
	SvG8qyi2NesmbCay2hrMTFFRLwhfFy32v1M3sELprBViuoECn96LB7TIhzSi
X-Google-Smtp-Source: AGHT+IEoSJs0vfzu812As0wknmHbRYkyxXmpDCghVkoLxP+CEvWJvRqlqa2tAPsOz6Kwbhs8lxyZGA==
X-Received: by 2002:a5d:4643:0:b0:33b:232f:63f7 with SMTP id j3-20020a5d4643000000b0033b232f63f7mr3404599wrs.31.1707664238148;
        Sun, 11 Feb 2024 07:10:38 -0800 (PST)
Received: from syracuse.iliad.local (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id ck18-20020a5d5e92000000b0033b7a2136a4sm2057585wrb.97.2024.02.11.07.10.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Feb 2024 07:10:37 -0800 (PST)
From: Nicolas Escande <nico.escande@gmail.com>
To: ath11k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH] wifi: ath11k: remove unused scan_events from struct scan_req_params
Date: Sun, 11 Feb 2024 16:10:36 +0100
Message-ID: <20240211151036.1950292-1-nico.escande@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As discussed in [1] lets remove the unused scan_events field from struct
scan_req_params. Also, as it is not needed anymore, remove the underlying union
wrapping too. No functionnal changes.

[1] https://lore.kernel.org/all/4be7d62e-cb59-462d-aac2-94e27efc22ff@quicinc.com/

Signed-off-by: Nicolas Escande <nico.escande@gmail.com>
---
 drivers/net/wireless/ath/ath11k/wmi.h | 31 +++++++++++----------------
 1 file changed, 13 insertions(+), 18 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/wmi.h b/drivers/net/wireless/ath/ath11k/wmi.h
index bc7adf7f13fb..bb419e3abb00 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.h
+++ b/drivers/net/wireless/ath/ath11k/wmi.h
@@ -3363,24 +3363,19 @@ struct scan_req_params {
 	u32 vdev_id;
 	u32 pdev_id;
 	enum wmi_scan_priority scan_priority;
-	union {
-		struct {
-			u32 scan_ev_started:1,
-			    scan_ev_completed:1,
-			    scan_ev_bss_chan:1,
-			    scan_ev_foreign_chan:1,
-			    scan_ev_dequeued:1,
-			    scan_ev_preempted:1,
-			    scan_ev_start_failed:1,
-			    scan_ev_restarted:1,
-			    scan_ev_foreign_chn_exit:1,
-			    scan_ev_invalid:1,
-			    scan_ev_gpio_timeout:1,
-			    scan_ev_suspended:1,
-			    scan_ev_resumed:1;
-		};
-		u32 scan_events;
-	};
+	u32 scan_ev_started:1,
+	    scan_ev_completed:1,
+	    scan_ev_bss_chan:1,
+	    scan_ev_foreign_chan:1,
+	    scan_ev_dequeued:1,
+	    scan_ev_preempted:1,
+	    scan_ev_start_failed:1,
+	    scan_ev_restarted:1,
+	    scan_ev_foreign_chn_exit:1,
+	    scan_ev_invalid:1,
+	    scan_ev_gpio_timeout:1,
+	    scan_ev_suspended:1,
+	    scan_ev_resumed:1;
 	u32 scan_ctrl_flags_ext;
 	u32 dwell_time_active;
 	u32 dwell_time_active_2g;
-- 
2.43.0


