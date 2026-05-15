Return-Path: <linux-wireless+bounces-36484-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +GTeCmkcB2rnrgIAu9opvQ
	(envelope-from <linux-wireless+bounces-36484-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 15 May 2026 15:15:21 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A86A550509
	for <lists+linux-wireless@lfdr.de>; Fri, 15 May 2026 15:15:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EE0A930FB779
	for <lists+linux-wireless@lfdr.de>; Fri, 15 May 2026 12:13:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31E8F480342;
	Fri, 15 May 2026 12:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mBKI0WdU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9310147ECF3
	for <linux-wireless@vger.kernel.org>; Fri, 15 May 2026 12:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778847150; cv=none; b=PdnnkRGiPdElXJVvCNLOo13cSVW9TS+rRIcj7a6SoZMVBcpGJ04PNkULzWksVJOBEOaGt6i2D5AqoDb5a9Ktvbchdf6TLOEr8QCPox/3ldPM3XWanoOa8ICGRWpFZ2t6WXVKmW9+1bklA2LIpi1bXrabBTEGUfhWVHPuHoNdUs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778847150; c=relaxed/simple;
	bh=2R3vKeNVW74nHrBVufrdcdbAaqqXsE5GSwxXB5EcMe8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AcozTBkRTSQ1uMYoMOhwdxRegWmftT+08hYV3F9OMhC5l4sHOCvFhi0fgWqH1jWaXo8GXVE+JHagYOYNeVfjA9nwpdLeD95hpIGhu4akO+c1GVxatvhRskfZQwAAfZVSSUCZD1+1iRp0uKkixKpaa9hK6ubaThRd6DatsEyfjUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mBKI0WdU; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-50e63771d91so88335621cf.0
        for <linux-wireless@vger.kernel.org>; Fri, 15 May 2026 05:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778847148; x=1779451948; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=amCrfYz+XZIkhe1QNRlSts2vKTBkBvty+ZpNysynPNw=;
        b=mBKI0WdUBvoFb/OCKDjYLq67HP0ZPOpVe51UHLstAoW4bb4W3AQJIkXzrREm6wI96r
         Y0vZDKVVcFQC1NqOALdKla57kQJeV6rUqGiau/sz4pe+MdWv6fmO7UVjZNSPt8OVdIyO
         QB7iIXtG5vwb6LFGFpf4X1v1eFDWHUHXwDBWZLPw7nTvH0wsN0MlAjKnZhf66gkH7au2
         AdagbL6qjCj+Dz6HzKXGkBrfsR5P7/3/QIT6MmbTFPSE/tXDsquKM+tigbXI+7T6ZdAL
         5i6LvsTyTALE5iGWo9+t3Nt7/LpUo/aNbLyZd0Wj5LnldHvtlgbmnfDY4/g8LfLhbPcL
         l5Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778847148; x=1779451948;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=amCrfYz+XZIkhe1QNRlSts2vKTBkBvty+ZpNysynPNw=;
        b=p0Nn1QBr/S31OjtIhag5qKvhCGavdTF+o8lJpUa/ObCYZhitGzuKd7Pznqa88IbUTK
         VVSjKo/cRNJu6Dv8ZUIq7ds6DkGtG/BAAOJ0KaL6KuJLwTq9QsOrFwCkd+xoJXIuQRZS
         IH8zi8CtLRIYuADndqY94cZY98t+uRz5Kkoe3gAFn5Bd0sNOAPELAm/EtF9DPTkmeB70
         uA/FXfeybQDEz87kLC9fPG/wuZ0l/gEa3mSKiZrartn1YXcyxNfVMUXrbfpKGE3zjDDd
         KGrsShKtZKf3b13kwtgnBJZCrn3odmGWd6Yr+YAJafNjW2jFN0Kg++Wx4e7V8vwk/Apu
         hv/w==
X-Forwarded-Encrypted: i=1; AFNElJ+oc+3vSHj0pGpKM0tMA7s07OX8Qfsa8gZFwXlFXeNQf95oSYDBbHHnRHpQKGK4mLDc6r51Qt3IbZbQ9hXMZA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwANcFJ6LeD/UpdS93fEC4Z7WY/yYRtK96RSbAftF6KSyWj3ida
	QwUnLCrfVxVXyqZNhMi8ruvJCYB+gRXKepQY85UUjjsIBYDnux3AotM4
X-Gm-Gg: Acq92OGOpQ0nyharTA3YjIYgIWPjTQlO5JcOOjDZ3sV8dmL1ESHJbt4yFot+cy6nTAb
	BpIj7eyN0+JjZu6PatP8LLjHCOmWeh5OP+BhtzTy49cnSaamc2DCxjlSwASxG8O7GjjJ9/VFmzz
	jqz4NLcNdZYCSMFmAcoCJbxGFNnf3yDu2H3T9yLUWEn2H9+HUAv2Z4XbEFUZYCtpoXNFP1vdtQH
	1EVH55IFlJDBQwqITprzxwvFp6VIViAHxHMo5vZ8L8YZbQ6IP1Dqh4xBQ1hsFI4+r2KvUK2fgb/
	+uhuKE0jBmBZI3jFJPwASGExx1ORRXkXkASIC4wK1UEpdgeBIYRRqPEAkobbHNO2KvIhZDiuH/i
	mBWj2rfCw7XLUgZs5YsOB5OmK8QqnqDtsPDsWkylKv/n+USAX9chnqE4l0+XQQKc5GIVayITDIZ
	wtX1iRusINQ2zuEpT5BBCqEeouSee7dkmgKej3odG+Cms8uHBxHJa7vEUp4p/KfiwpFsbCvSSTz
	/5MfKzJk6QmW4T7HvB4DxpIeeliJrNup1f2he0q2vA=
X-Received: by 2002:a05:622a:1f16:b0:50f:bc57:d69 with SMTP id d75a77b69052e-51659ed0e67mr48506521cf.0.1778847147439;
        Fri, 15 May 2026 05:12:27 -0700 (PDT)
Received: from server0.tail6e7dd.ts.net (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-516456888f6sm45534491cf.3.2026.05.15.05.12.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 05:12:27 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Cc: Johannes Berg <johannes.berg@intel.com>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 3/4] wifi: iwlwifi: mld: include matches tail in match-info length check
Date: Fri, 15 May 2026 08:10:59 -0400
Message-ID: <20260515121100.649334-4-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260515121100.649334-1-michael.bommarito@gmail.com>
References: <20260515121100.649334-1-michael.bommarito@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 2A86A550509
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-36484-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[michaelbommarito@gmail.com,linux-wireless@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

iwl_mld_netdetect_match_info_handler() validates the firmware
notification length against sizeof(*notif) (the fixed-header
size of struct iwl_scan_offload_match_info, 24 bytes) but then
immediately memcpys NETDETECT_QUERY_BUF_LEN bytes from
notif->matches:

	if (IWL_FW_CHECK(mld, len < sizeof(*notif),
			 "Invalid scan offload match notif of length: %d\n",
			 len))
		return true;
	...
	if (results->matched_profiles)
		memcpy(results->matches, notif->matches,
		       NETDETECT_QUERY_BUF_LEN);

NETDETECT_QUERY_BUF_LEN is

	(sizeof(struct iwl_scan_offload_profile_match) *
	 IWL_SCAN_MAX_PROFILES_V2)
	= 18 * 8 = 144 bytes

so a firmware-emitted notif sized at exactly sizeof(*notif)
(24 bytes) satisfies the guard yet the memcpy reads 144 bytes
past the slab-allocated notification buffer.

Reproduced under UML+KASAN via a KUnit harness that lifts the
length-validation + memcpy logic into a self-contained test.
KASAN reports

  BUG: KASAN: slab-out-of-bounds in mld_match_info_buggy.constprop.0
  Read of size 144 at addr ...

Building drivers/net/wireless/intel/iwlwifi/mld/d3.o under
x86_64 allmodconfig with the fix applied yields no new warnings.

This is the same bug shape as the previously fixed sibling
commit 744fabc338e8 ("wifi: iwlwifi: mvm: fix potential
out-of-bounds read in iwl_mvm_nd_match_info_handler()") applied
to the mvm peer function. The mld driver was added in February
2025 and inherited the same length-check miss; apply the same
correction shape.

Cc: stable@vger.kernel.org
Fixes: d1e879ec600f ("wifi: iwlwifi: add iwlmld sub-driver")
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
Assisted-by: Claude:claude-opus-4-7
---
 drivers/net/wireless/intel/iwlwifi/mld/d3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/d3.c b/drivers/net/wireless/intel/iwlwifi/mld/d3.c
index ef98efc8fb1b..e89ec531cb06 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/d3.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/d3.c
@@ -1128,7 +1128,7 @@ iwl_mld_netdetect_match_info_handler(struct iwl_mld *mld,
 			 mld->netdetect))
 		return true;
 
-	if (IWL_FW_CHECK(mld, len < sizeof(*notif),
+	if (IWL_FW_CHECK(mld, len < sizeof(*notif) + NETDETECT_QUERY_BUF_LEN,
 			 "Invalid scan offload match notif of length: %d\n",
 			 len))
 		return true;
-- 
2.53.0


