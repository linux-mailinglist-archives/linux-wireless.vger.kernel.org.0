Return-Path: <linux-wireless+bounces-38595-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8/fKJtDCR2qHewAAu9opvQ
	(envelope-from <linux-wireless+bounces-38595-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 03 Jul 2026 16:10:24 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C791A703466
	for <lists+linux-wireless@lfdr.de>; Fri, 03 Jul 2026 16:10:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=jJILaNym;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38595-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38595-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2FAD83017BEC
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Jul 2026 14:09:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4374E3C1994;
	Fri,  3 Jul 2026 14:09:55 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0C1D34F270
	for <linux-wireless@vger.kernel.org>; Fri,  3 Jul 2026 14:09:53 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783087795; cv=none; b=iQVdWEtQx/Uzoa3RZsow61lbC+AIiI+5W8qL5Rda7pAncgoXw00pyguk5V8Mv5nZIjFEwpSPh35oLpBxzpPT/3a7h7w1aIX8p5cChvNQzifD+tgRqnH1lSfArG3e0jKQl2qyrcrfLoLickzmQZYR/m+hsvkiAGCG1rkWq8MYSKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783087795; c=relaxed/simple;
	bh=cSix3bPrnlTsf4ve2O23Fted90eqeCp9GrxRqAK0GSo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UKRzj/BHWs4J/4dh56iQIFP8zM7Q7hSXzp1uPNa2a+vJL/ZXOsOhdEZzo7pfxHmykbtx22HvtbVnLocGv+ML9AQ34ft9+astURUmO/2yfh0lF1GSzB2VwpsVGXJ2rMXOO8oNQvMf9NQahM4nVdyWjepthSdO0hdnP/8961xFtww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jJILaNym; arc=none smtp.client-ip=209.85.216.44
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3812c718debso478675a91.3
        for <linux-wireless@vger.kernel.org>; Fri, 03 Jul 2026 07:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783087793; x=1783692593; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QBxyL++Os8lkDVHZYFCOoQrLTmwe+uKFbLSVULP0jRY=;
        b=jJILaNymWTsnwoWk9Iu16hXhIqVMR4JW1d8pQMtY6jEpxEFd75adXEpHmk64/3Hm35
         vDPsnqNf+gkOPc32K443ztgydcURUUQUN3ZhtYnDpWhzQl1kRH1WWDcWnoteCS/RkJCt
         TuVQSL9Lup8zhugZQOE0yCx9HjwRGqhcypakXbldIp9Dl2fHYy2UgCOZAylHEHuNHAm+
         53qix8JQKpM6Ih6PkxXucVVwem/xM4n1xullAGNk+m67PwT7SySvSjOOirBJd5tIvx3R
         x0zyRwuLVAaUDh2Ci7s3x2ZNw+TLZ8ge/mIDcjM368ITZO4WXje7NYr8lFx3EfPRb2z7
         gGsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783087793; x=1783692593;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QBxyL++Os8lkDVHZYFCOoQrLTmwe+uKFbLSVULP0jRY=;
        b=FYImsohYT7faHZ38WBkRR+JdJ9eH7/Ko/LnjPbi1P2Dh0qL0zAWO+vxcoZYXX/E085
         IJH9WbLO0V2HnTtSdQUfhJqs/DHj0fcXx3uGQbKg4XWP/58Yj5Skg3+hNmJQ9hA2xON6
         2sxwNGIYBLjf/gYCx7pis8l1YyRXNFAbVZid2MugiNDgL5O5QiHfydklna6wen//bmZ8
         OCuFjFngzhtjUDqSySGoVaZZ16mtrOYgKvGKi+V+AGGWGlX+WW6Btfyp+WprYUOrc3KB
         AmdKOdO2JcxSs2dN0sR3VWJDOiOn0XBXUX2eVEjQQ8RS/CZ6Ll2bJ9Gnumlbd2RakIYj
         MgaQ==
X-Gm-Message-State: AOJu0Yy50dYYLPyN6/b7RGjyZ8OArUqYqdWY3rGXcdqakrndhumY8w3i
	D7vfMzA05lDPJ6OgEbGEu4QcIx9A9PYSlBzZb8M/pTYmI4FPLYj5bhNR
X-Gm-Gg: AfdE7cnYpokY/EmvGntqx4LkoMznno7uugYVYvKFDvYihmm8an3MLL2OZQ+6cV9bk+r
	jreDq7vIut0tzHqL+Twfarl0HACD26a1GCk4D/3JZtS9gcRzDmMVXwjcmH0hyVtbatGDMDKS4oP
	wsjfSO2vROmoFAwd1H2ZrLl5J+dBCsWXmREXOFU36NbIJgJhpg5F1IKMKb0ii/EIMlyiPUuKnNP
	UavwYIvvBgYfjrR+BAAjbAsoBUwykZ+gZIdYZRohxB7yiSIPYZoYFXCr/ZK7M6R28mjMbathaSW
	ukq6hsYf6SOi4JXOfI0aeSno/GEDzT2y4ewvbINVjdqajQfYaAY+1rzUW6ofSQv7wIJyCJVTRrz
	aa7zK5rbl94nn7ZPWjb5tOXsO7cil+tAkEnR5h4x9RA+eFcNxNnxxKwB5wR900iGqKMoeZO+s6q
	on34fEJpgw/WSBwgGuF/OU5XL3b3MVWrdSfGaGy6Swzk+5iu+4CSefioh1fvQh/sAhlrnpgMTen
	QdSS2ksLNA=
X-Received: by 2002:a17:90b:534e:b0:36d:8e49:d8 with SMTP id 98e67ed59e1d1-380aa141c37mr10946766a91.15.1783087793147;
        Fri, 03 Jul 2026 07:09:53 -0700 (PDT)
Received: from fedora.localdomain ([152.58.57.44])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f0b7b9a1bsm21612206eec.3.2026.07.03.07.09.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 07:09:52 -0700 (PDT)
From: Praveen Rajendran <praveenrajendran2009@gmail.com>
To: miriam.rachel.korenblit@intel.com,
	johannes.berg@intel.com
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Praveen Rajendran <praveenrajendran2009@gmail.com>
Subject: [PATCH] wifi: iwlwifi: fw: Fix spelling typo in error-dump.h
Date: Fri,  3 Jul 2026 19:37:57 +0530
Message-ID: <20260703140757.3372-1-praveenrajendran2009@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
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
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-38595-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:miriam.rachel.korenblit@intel.com,m:johannes.berg@intel.com,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:praveenrajendran2009@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[praveenrajendran2009@gmail.com,linux-wireless@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[praveenrajendran2009@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C791A703466

Correct a minor grammatical error inside the kernel-doc comments
of error-dump.h where "configuration" was misspelled as "configuraiton".

Signed-off-by: Praveen Rajendran <praveenrajendran2009@gmail.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/error-dump.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/error-dump.h b/drivers/net/wireless/intel/iwlwifi/fw/error-dump.h
index 07f1240df866..692bb17dfc33 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/error-dump.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/error-dump.h
@@ -352,7 +352,7 @@ struct iwl_fw_ini_error_dump_register {
  * struct iwl_fw_ini_dump_cfg_name - configuration name
  * @image_type: image type the configuration is related to
  * @cfg_name_len: length of the configuration name
- * @cfg_name: name of the configuraiton
+ * @cfg_name: name of the configuration
  */
 struct iwl_fw_ini_dump_cfg_name {
 	__le32 image_type;
-- 
2.50.1


