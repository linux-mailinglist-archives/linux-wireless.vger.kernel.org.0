Return-Path: <linux-wireless+bounces-12599-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3EA996F6A1
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Sep 2024 16:25:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2DC8287036
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Sep 2024 14:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0ACD1D0DD7;
	Fri,  6 Sep 2024 14:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yc3+GYHL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A6F01D0DDF;
	Fri,  6 Sep 2024 14:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725632699; cv=none; b=E5nMdJD67M2RmI7mXyl2+30k5qhmqFmsUuehKbZFEcU1NCfG/0yw7OtaS2aHdZ0rMbzdmoXHWWffnAxzfvPs1VwheKl9yUXYYxbhe1eK+3wasb7VoaSNSQwKDPULStFLo1zyNeZFVUSU0+mXz1e4E/pOFKWPdHWG/EmHwyF43xY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725632699; c=relaxed/simple;
	bh=Ae/E+HwwnrmVtMR5Ie0tM3RoV8FviaM5rFcynKwfpe0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qBlycqgIxiFzECGwpBOB/VMtmF30w6vVTTZ/ur5ZAD0xoDS3O4GJJ7OoFxKPdTyWgJ3wE9//T2Jnrk+hLuD7XmbeY+m4oPchXOGV1e0uQc7KMmoVLy1U5OdngKSyay/HSNbx23OnS1qEVsGBuRTuFlet/iNHAvCSsiqWOAkRO4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yc3+GYHL; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2053616fa36so21720595ad.0;
        Fri, 06 Sep 2024 07:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725632698; x=1726237498; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MJoi1jywiZO+XvKJEVuaNemlL/axteDLk0qoQjK504s=;
        b=Yc3+GYHLfqkbkUfzf0SPtyTZSurltNjs2HCZBL41kR4nkgU8BtqSJE9l+gqPQvK0p6
         f22PSUWZ6vhA2LpNRqz8wG1HUVRIMBXAPro/qwfTu0tgKrt8dE4iXeby96RvwKw3L2dg
         k48cogLFPb0ZRa47QEhcxYCNfB/Gf3+AqjHFRCvoOHDhTZERkNklcWAFjku63VuaSeCc
         E4X8wuxRIYHOnd/ByP7ODsE58sjVxqimi+FI56HksphRLwALgm+1l0FyIpWs9eEu4CWK
         CEiYlxulqB0XbXRfs6mL/XfWaBb1nxa3NHreB7Wn2vBrgZTAX/8kWQ8F4+vQF/0NBRQR
         0qDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725632698; x=1726237498;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MJoi1jywiZO+XvKJEVuaNemlL/axteDLk0qoQjK504s=;
        b=nWGe4KcqHk2OqPteWKVHfedW4Ojv1WJsQPGr4ZHJX7da6QzlPqzwnH9RQdt9U0KWuq
         Zm8Ojl2sNeyYaOzOBHSjG7EiNeKHx2rJt+NqAEzX460Peb9YNSgKSflEEOeDHIa+Frre
         S8VA4qZkkTftWeGpqsU2IjMe21jLPzs3ssR9att61OlJaU4Upa5znqTC7XOL40Joo3z1
         C+KbZqTS+H9LBJK5V7vqqDTlioT3cHmR5bUND/JCCvNKl4+77g625MobrxZHuAY1TrrP
         zjoU/whgmrq3OQedZmMW+Eitwzg/VencykOaCcvewgjf9polLakTGR2HhGl+OVizlFeU
         cDlA==
X-Forwarded-Encrypted: i=1; AJvYcCU0UGwxL6o4k6vCenMH0mwQhnzRWASMoLNkVVlRFqqFiaINhNosEXN0y4NA9ix43wu64KXYc1KUhhdyBLU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzh4BJ6CDNO+2AlsL6POHd7qi6DFqbgRI6b/js3fV7wsurgKuSS
	XZgV2HZHHK6Kf6V8E0BtPj0o/D3Ly19DaPOdibP/BjqSbUF5SYKIBb3ZKIlI
X-Google-Smtp-Source: AGHT+IEnEyzMjgrIIevOgy8FqtHozXZCGYN6NYb6jc8MdPwzrLM0zHeS6FOL5luf4H+7eMWsltRXOQ==
X-Received: by 2002:a17:902:d58d:b0:206:994b:6d53 with SMTP id d9443c01a7336-206994b6f3emr145549645ad.30.1725632697490;
        Fri, 06 Sep 2024 07:24:57 -0700 (PDT)
Received: from kernelexploit-virtual-machine.localdomain ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-206aea530casm43740605ad.184.2024.09.06.07.24.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 07:24:57 -0700 (PDT)
From: Jeongjun Park <aha310510@gmail.com>
To: toke@toke.dk,
	kvalo@kernel.org
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jeongjun Park <aha310510@gmail.com>
Subject: [PATCH] wifi: ath9k: add range check for conn_rsp_epid in htc_connect_service()
Date: Fri,  6 Sep 2024 23:24:52 +0900
Message-Id: <20240906142452.144525-1-aha310510@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I found the following bug in my fuzzer:

  UBSAN: array-index-out-of-bounds in drivers/net/wireless/ath/ath9k/htc_hst.c:26:51
  index 255 is out of range for type 'htc_endpoint [22]'
  CPU: 0 UID: 0 PID: 8 Comm: kworker/0:0 Not tainted 6.11.0-rc6-dirty #14
  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
  Workqueue: events request_firmware_work_func
  Call Trace:
   <TASK>
   dump_stack_lvl+0x180/0x1b0
   __ubsan_handle_out_of_bounds+0xd4/0x130
   htc_issue_send.constprop.0+0x20c/0x230
   ? _raw_spin_unlock_irqrestore+0x3c/0x70
   ath9k_wmi_cmd+0x41d/0x610
   ? mark_held_locks+0x9f/0xe0
   ...

Since this bug has been confirmed to be caused by insufficient verification 
of conn_rsp_epid, I think it would be appropriate to add a range check for 
conn_rsp_epid to htc_connect_service() to prevent the bug from occurring.

Fixes: fb9987d0f748 ("ath9k_htc: Support for AR9271 chipset.")
Signed-off-by: Jeongjun Park <aha310510@gmail.com>
---
 drivers/net/wireless/ath/ath9k/htc_hst.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/ath/ath9k/htc_hst.c b/drivers/net/wireless/ath/ath9k/htc_hst.c
index eb631fd3336d..aedba5f79bfb 100644
--- a/drivers/net/wireless/ath/ath9k/htc_hst.c
+++ b/drivers/net/wireless/ath/ath9k/htc_hst.c
@@ -293,6 +293,8 @@ int htc_connect_service(struct htc_target *target,
 			service_connreq->service_id);
 		return -ETIMEDOUT;
 	}
+	if (target->conn_rsp_epid < 0 || target->conn_rsp_epid >= ENDPOINT_MAX) 
+		return -EINVAL;
 
 	*conn_rsp_epid = target->conn_rsp_epid;
 	return 0;
--

