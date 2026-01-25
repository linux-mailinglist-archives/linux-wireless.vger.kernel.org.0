Return-Path: <linux-wireless+bounces-31153-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cVKLImCodmkZUAEAu9opvQ
	(envelope-from <linux-wireless+bounces-31153-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Jan 2026 00:33:52 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 552F68325B
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Jan 2026 00:33:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D04DF300106C
	for <lists+linux-wireless@lfdr.de>; Sun, 25 Jan 2026 23:33:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C827A30FC1D;
	Sun, 25 Jan 2026 23:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UKAoNCpr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 437B730EF7A
	for <linux-wireless@vger.kernel.org>; Sun, 25 Jan 2026 23:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769384025; cv=none; b=L7YeiiPLk4B9Zcpw/39xwEmBaKs6OngsrYbsf/2A21FhmJzo8tfmV4k44hZ59/gamt5SgRDCgyqshkyK5KYXbqD5zr6aP8KuE3Ez/DZ2vWTJbHgK8gP7xdRkiFzTKEcARRdpEuGmUDLpZxBqYw+6hxzeLtLT07nDopm6dCUsgBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769384025; c=relaxed/simple;
	bh=40HDaw8ntqkj11TLcXWCKMbTSTaBwFBrT4JI2rWl1Fg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JCllqwPG7q7F7qHArsLeLpebhXqxjPVO4wd4FEFOqqBEnKXR3jkth1r3e4O1IMq8z/UCx00dlQyynswzrMLYimmodqH7uQXW4AWyrLhIS7KPyOcCF33qrAoGEAgOY9RgaAs50a5YQK5EqmXLlpwUR/NMF5MrbrI2Q9M2vgv1eI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UKAoNCpr; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-47ee3a63300so45020555e9.2
        for <linux-wireless@vger.kernel.org>; Sun, 25 Jan 2026 15:33:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769384023; x=1769988823; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hxZFFubEOU7PGE71UzXJvLIW4o2EMn+DKQPsfeMWqfQ=;
        b=UKAoNCprplxnEp4hCh/uNyISdbtgB/t6NxpjElu9BAg7pxAM3ttZq/m3cwMPBebwYv
         kPxDdaHjHx7fE0O23J1wGNU4fqL4k6KCllPHmGLQ4Af/UMajhbF4yM1LpTa5eV0VU3oT
         mUaUfwkbKUmqiQVcJFFCnjYJK+1yX4Kcd13XJG6hQO4jZ7suFT+86D3qpPEvn64YLnC9
         ksigIWyxm2cYdUqr2/KDA55w6zR6ehsFUSDTyxoAJi9BrlM60r+5d1hBOZ6LMQLLRwQP
         XY3pJFILLhzVeE5kC2pi6NmpUTEZfZKO07hUGjEOT5q0AvOx7NjYsCRYJpIKuJvicYhr
         g40A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769384023; x=1769988823;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hxZFFubEOU7PGE71UzXJvLIW4o2EMn+DKQPsfeMWqfQ=;
        b=CLp+2dOc4+vng3TQvV4j2T7n2HvvPc1y7WVuN+zEDLkm6z83bNU1r+qM597TOHOrJb
         Wl9ChYpMY5UFsj5u+S0z0RVJC3OGnBjOTd9yhVQybYb0Q6U5afmDIkVZ9cQE9s9aNNn2
         CYd4z3c5G2yf2G5qXe+vr/jdcfJPVjfUyFrtnwkHPNkAYLBtFYUMVx99rjVyAnisVEYS
         bktBC9uLt+LPNeTeP9gUSuoRbliHFerT7N0uolneXiIC6t00KZSt8uO45Mfoi3TleLrn
         KR1aX4EzmP14KqwEgShSt6rTCXzxGzUhUJkH5G3TsImP1Y9eIGlwtrWafb9sc00pxA1S
         sT4w==
X-Forwarded-Encrypted: i=1; AJvYcCXWW9F4KtHLlJtBg3FlrLQ6JDom/DGwFYQ2rQz9vlWQ7T4VXJtjNfLZ2d6fkbiAXUp2VFkFHPfCSdA00FoS1g==@vger.kernel.org
X-Gm-Message-State: AOJu0YxpuGTtfKJcZXkm1rTNFq5ENeXJQpfTcKxPMKKZLw6+aCzcCaVL
	wzBXgMOEv5ckqr0mtOstGLHVpNQ1MPpPrgvvINiWyfApXARqefLviZNx
X-Gm-Gg: AZuq6aJxbfDW78hkNws74eOvgFX6cCEQ8r13pT/YyUnnIXrHPuT9rQQ02SvH26LnlLe
	TR4O2Bx6Aig7R8PfkKXAKUUJ+Ejbsl6EdIKH01WTJGjByxfuaHNM74NcWI2zVsxuzyvIhE4h5pt
	CbiF5RvkVzgo2p/2rY+ATM5T7MdvwgyuFoiUnGGmsqBgdPHQfEt/BbzCntO1XmeiqHF//qMPFaC
	PpDWnWcT2mlxlh2YUDVRjNrYW8b63MS9Mg1j/j0GeAalYNQ5QdoyUX1W+mmwDah5jxTJX5FKgCK
	5p9x2snQmyRhVboI88ZAftW47JIbFfEZ5cn9RAZQZylyChjJm+G9cH8gYOwW76GNIthrC/SEtFD
	vWcPj0Yyw2pCFvO40DEh3C448MCL4txQ+xGbuWXgY3XswfTKFoMDlewMKeBGtlng6x5nLazsOxo
	r+IgqTtIRofClMKzmeWQAkrUapAN8=
X-Received: by 2002:a05:600c:4f8e:b0:477:b642:9dc1 with SMTP id 5b1f17b1804b1-4805cf669d1mr40697975e9.20.1769384022447;
        Sun, 25 Jan 2026 15:33:42 -0800 (PST)
Received: from debian.powerhub ([2a0a:ef40:e94:5d01:a218:5589:9f9c:4f52])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4804d84ef51sm209938985e9.5.2026.01.25.15.33.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Jan 2026 15:33:42 -0800 (PST)
From: Chris Bainbridge <chris.bainbridge@gmail.com>
To: miriam.rachel.korenblit@intel.com,
	kvalo@kernel.org
Cc: johannes.berg@intel.com,
	benjamin@sipsolutions.net,
	gustavoars@kernel.org,
	linux-intel-wifi@intel.com,
	linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chris Bainbridge <chris.bainbridge@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] Revert "wifi: iwlwifi: trans: remove STATUS_SUSPENDED"
Date: Sun, 25 Jan 2026 23:33:34 +0000
Message-ID: <20260125233335.6875-1-chris.bainbridge@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[intel.com,sipsolutions.net,kernel.org,vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31153-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chrisbainbridge@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,yhbt.net:url]
X-Rspamd-Queue-Id: 552F68325B
X-Rspamd-Action: no action

This reverts commit e769f6f27ffe41331e00b69a33aa8a34db4dd830.

The removal of STATUS_SUSPENDED (which tracks suspend/resume state)
resulted in an intermittent race condition on resume. The fault can be
reproduced by carrying out repeated suspend/resume cycles while passing
traffic through the NIC. A typical failure looks like:

[  141.093986] iwlwifi 0000:01:00.0: Error sending SCAN_CFG_CMD: time out after 2000ms.
[  141.094057] iwlwifi 0000:01:00.0: Current CMD queue read_ptr 441 write_ptr 442
[  141.094864] iwlwifi 0000:01:00.0: Start IWL Error Log Dump:
[  141.094866] iwlwifi 0000:01:00.0: Transport status: 0x00000042, valid: 6
[  141.094870] iwlwifi 0000:01:00.0: Loaded firmware version: 89.7f71c7f4.0 ty-a0-gf-a0-89.ucode
[  141.094873] iwlwifi 0000:01:00.0: 0x01000071 | ADVANCED_SYSASSERT
...
[  141.098401] iwlwifi 0000:01:00.0: iwl_mvm_check_rt_status failed, device is gone during suspend

The kernel then oops due to a null pointer dereference in
iwl_mvm_realloc_queues_after_restart().

Fixes: e769f6f27ffe ("wifi: iwlwifi: trans: remove STATUS_SUSPENDED")
Closes: https://yhbt.net/lore/linux-wireless/aTDoDiD55qlUZ0pn@debian.local/
Cc: <stable@vger.kernel.org>
Signed-off-by: Chris Bainbridge <chris.bainbridge@gmail.com>
---
 .../net/wireless/intel/iwlwifi/iwl-trans.c    | 22 +++++++++++++++++--
 .../net/wireless/intel/iwlwifi/iwl-trans.h    |  3 +++
 2 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.c b/drivers/net/wireless/intel/iwlwifi/iwl-trans.c
index cc8a84018f70..f5c4aa165c5b 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.c
@@ -306,6 +306,9 @@ int iwl_trans_send_cmd(struct iwl_trans *trans, struct iwl_host_cmd *cmd)
 		     test_bit(STATUS_RFKILL_OPMODE, &trans->status)))
 		return -ERFKILL;
 
+	if (unlikely(test_bit(STATUS_SUSPENDED, &trans->status)))
+		return -EHOSTDOWN;
+
 	if (unlikely(test_bit(STATUS_FW_ERROR, &trans->status)))
 		return -EIO;
 
@@ -406,6 +409,8 @@ int iwl_trans_start_hw(struct iwl_trans *trans)
 	might_sleep();
 
 	clear_bit(STATUS_TRANS_RESET_IN_PROGRESS, &trans->status);
+	/* opmode may not resume if it detects errors */
+	clear_bit(STATUS_SUSPENDED, &trans->status);
 
 	return iwl_trans_pcie_start_hw(trans);
 }
@@ -505,17 +510,30 @@ iwl_trans_dump_data(struct iwl_trans *trans, u32 dump_mask,
 
 int iwl_trans_d3_suspend(struct iwl_trans *trans, bool reset)
 {
+	int err;
+
 	might_sleep();
 
-	return iwl_trans_pcie_d3_suspend(trans, reset);
+	err = iwl_trans_pcie_d3_suspend(trans, reset);
+
+	if (!err)
+		set_bit(STATUS_SUSPENDED, &trans->status);
+
+	return err;
 }
 IWL_EXPORT_SYMBOL(iwl_trans_d3_suspend);
 
 int iwl_trans_d3_resume(struct iwl_trans *trans, bool reset)
 {
+	int err;
+
 	might_sleep();
 
-	return iwl_trans_pcie_d3_resume(trans, reset);
+	err = iwl_trans_pcie_d3_resume(trans, reset);
+
+	clear_bit(STATUS_SUSPENDED, &trans->status);
+
+	return err;
 }
 IWL_EXPORT_SYMBOL(iwl_trans_d3_resume);
 
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
index a552669db6e2..c4d06a323f9b 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
@@ -290,6 +290,8 @@ static inline void iwl_free_rxb(struct iwl_rx_cmd_buffer *r)
  *	the firmware state yet
  * @STATUS_TRANS_RESET_IN_PROGRESS: reset is still in progress, don't
  *	attempt another reset yet
+ * @STATUS_SUSPENDED: device is suspended, don't send commands that
+ *	aren't marked accordingly
  */
 enum iwl_trans_status {
 	STATUS_SYNC_HCMD_ACTIVE,
@@ -303,6 +305,7 @@ enum iwl_trans_status {
 	STATUS_IN_SW_RESET,
 	STATUS_RESET_PENDING,
 	STATUS_TRANS_RESET_IN_PROGRESS,
+	STATUS_SUSPENDED,
 };
 
 static inline int
-- 
2.47.3


