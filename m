Return-Path: <linux-wireless+bounces-35958-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2HDDDHB1+mkAPQMAu9opvQ
	(envelope-from <linux-wireless+bounces-35958-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 06 May 2026 00:55:44 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D7914D4783
	for <lists+linux-wireless@lfdr.de>; Wed, 06 May 2026 00:55:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E6162304A092
	for <lists+linux-wireless@lfdr.de>; Tue,  5 May 2026 22:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26D9932E6BB;
	Tue,  5 May 2026 22:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XusBDuVi"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B62A3329C66
	for <linux-wireless@vger.kernel.org>; Tue,  5 May 2026 22:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778021739; cv=none; b=Pmk+L9D67Yj0wO4tNkWJN1Zk4ZDiS2xg7IUKWQDjYWWcIcyTJ7J1nmoi3gvtKqpbUUAq9RxkzjhYKekcYTjiCvV+WVroIr5akw9PF/zkMv0uX3QCQHStF/H9eYX941kik8amF0Acd2vFnBBupEY9Izw8absgEW758zW2y0gGDIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778021739; c=relaxed/simple;
	bh=BU1PL7L2Bp2yU4xdeHt1deaEvz1weog3A29mWx51uqk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eAyPfVTw5nPPf7Qdb0JDm9cEWk5gv1yyk6WbSXmB020a1oEZym3jxmSvfrme0+EXM/gqHICtyCo6dbeTxscRL4liRgLflP1B+6gGfTJUsfb9rBdI3scGgg9LbFePR+0n0BtAVGYAOx2tdAZSfxB5VhZFChZ4QQ6kRPeBL8VjV7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XusBDuVi; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5a86bfa2a4eso4802038e87.1
        for <linux-wireless@vger.kernel.org>; Tue, 05 May 2026 15:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778021736; x=1778626536; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=N/G003nGvaZHjho/dQHFX+4gr4vd/jf7DxB/+coImIk=;
        b=XusBDuViNCCr6cYAiE943F6aJkuvA7CsyW+V6AjuvpyodTRv5slsujNE+sX3+rUdus
         LxSRTp34prUEDfo4GGaZ0y99YHUcwut+TqIZghEQ7lAnwluaJ3MIrRHITyW+kOx6jGCM
         evQCyJj87FSmTUxJGp++wHA9ZUHD3MUMtBJdouRIo3j4dvpvaUEoW159RZ3kFZsAfxWA
         xXlakBuMLhgmUhI4PTMRo0LMHeRlhF0ieMm+aFrxghkDYHfyHh8/9U2lZzyZ2i1dfOGz
         ApPxreFKEs3YlSZeDy88tucRt4wVCIR6TU9J7RclhRsp/aXlVub/klC8DD/hOpsBp9JP
         SZnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778021736; x=1778626536;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N/G003nGvaZHjho/dQHFX+4gr4vd/jf7DxB/+coImIk=;
        b=RbKb9PbI8ruqYauNanYoIvhjVxWdxOWgA+zwFK4kjSHuOT1x+YrrHRUGVkbf3coiZs
         od+G+jkWi8g81DkWy6B9JYGZLAqSzd4ZfoXyGGG+Pp5RPpUosJMhjh2PZWErPAkOksQs
         uF5v+tCIe6VBd7LQ2yxMfD50GVktWTQPoH5SzhuM1xvXhbdgVW+jzMcEmQtgWXZfNYFm
         ZvEQ3WmY8R7GUAGnmw8gq/RX8R5YFRhiRzCE1RMJU3zFxKJR/wAbDCLmM+D6QEUpdvKG
         uUo+W0RPboijcNFqUdXdmGv4Oev+qxzgdx9fCy2XNpI+S5cYNBj/KNzl+x7Jq9sRDbcF
         KdXg==
X-Gm-Message-State: AOJu0YycRGvNtd1Tj/nYHdEGS3rIyn0wMNM/Oe5BwrRS61xTr/Rgva9g
	ClJtCsOHV0uNrtG+fudHmG4z3D0xxnA7WQTbYEhsY9Q8/KepQdF6yh5R7bmPz8yD
X-Gm-Gg: AeBDieuNkaKxZz0FUUb+52AX+B9JOQGEJfmKMtfDhNiX2lwtFdzse2+z2s+RHfTXsjU
	UcwHKIOQQiAxEWZXb0SbHG+5apcUPZ62xkr/niyvYBM3k+SOKlecoQv1HeFwo/vDDwru7+9ramw
	td6V86RSRMnRea2k7UYOCJPMJ6md57Z4tgFj6FmRyheH3q/uI62E6TKD22X2iodpcPhMAssaI5m
	eOuxUs/iZ4r1MmLp2+3u4isAcydacBaTX4Tj1/jejBvOQLfnGnmmrqUPTFdzUksJ/xe+jnwf/da
	5tSc2Lml8SVE9Z2MRQrg7z77+D+MjbJgpvxVOpxbSeCEybz0KfV78FQqRf07jhCWAKKu9eossia
	kWHnRnsDfzyXqwj7YSI7hLrEHXC6vRszSWYLIVI7rPDpVELnhk56BCm0lB526K7E3+yjTNuh1DQ
	oUoDkgq6Da5WlIvmUK5zwt5wdL2BsEI3OG05mBzDwvOtRms9kfWVC+8zqVaFkL5QND93QAuPWMT
	FPEAA==
X-Received: by 2002:a05:6512:3f1e:b0:5a8:7f58:5fba with SMTP id 2adb3069b0e04-5a887adfd8emr286569e87.9.1778021735618;
        Tue, 05 May 2026 15:55:35 -0700 (PDT)
Received: from Shofiq.home (87-92-218-151.rev.dnainternet.fi. [87.92.218.151])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a86c7a1698sm2909326e87.3.2026.05.05.15.55.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 15:55:35 -0700 (PDT)
From: Md Shofiqul Islam <shofiqtest@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: miriam.rachel.korenblit@intel.com,
	linux-kernel@vger.kernel.org,
	Md Shofiqul Islam <shofiqtest@gmail.com>
Subject: [PATCH] wifi: iwlwifi: Fix typo in comment
Date: Wed,  6 May 2026 01:55:34 +0300
Message-ID: <20260505225534.7048-1-shofiqtest@gmail.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 9D7914D4783
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[intel.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-35958-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shofiqtest@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

Fix spelling mistake in comment:
 - sucess -> success
---
 drivers/net/wireless/intel/iwlwifi/mvm/utils.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/utils.c b/drivers/net/wireless/intel/iwlwifi/mvm/utils.c
index 4a33a032c..e8556de58 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/utils.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/utils.c
@@ -111,7 +111,7 @@ int iwl_mvm_send_cmd_status(struct iwl_mvm *mvm, struct iwl_host_cmd *cmd,
 }
 
 /*
- * We assume that the caller set the status to the sucess value
+ * We assume that the caller set the status to the success value
  */
 int iwl_mvm_send_cmd_pdu_status(struct iwl_mvm *mvm, u32 id, u16 len,
 				const void *data, u32 *status)
-- 
2.51.1


