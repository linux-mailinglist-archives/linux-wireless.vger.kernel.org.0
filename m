Return-Path: <linux-wireless+bounces-35155-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qKWHNNOA52k+9gEAu9opvQ
	(envelope-from <linux-wireless+bounces-35155-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2026 15:51:15 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3661543B8E8
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2026 15:51:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5C4B43020932
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2026 13:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E1AB3DA5D6;
	Tue, 21 Apr 2026 13:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sveQIkXU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F02D3D9DDF
	for <linux-wireless@vger.kernel.org>; Tue, 21 Apr 2026 13:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776779388; cv=none; b=coH+umbqhzvX0TVMBUOd8gk5G0Q19RLyZNnNMz+lOtt/jkxpoovL6LbiQgGY8v60gvZ4IT+7Y/EiGpu4zhGX17a1MPTwp0MPz3UpAoAsD3EBOoVqMfeDxl04Pc9qt0qGTOghCRiKnLYpKXcNWaq7TWIO2Nfy9osB4JiJNDD5qzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776779388; c=relaxed/simple;
	bh=INhCOGEytU7a+wIFlmBr/Bv85nBMhudD8oEAg1G10Ew=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lmcJF2y5mGggWzs/scilJfpLB+kxcsMCdWXpH82KXHZzkxsR9I9qDJ0ujViZi++eWlCFuWBBZL8/sOPwKG7tCG4LTeDa4fJUHmckvWmJMlPQPCueKakOKpGcbc98bNdyFocp0M2UKkKnWRuKWZn2mv1kaV6fFmPBfFonOS/1Bzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sveQIkXU; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-488ff90d6c7so33116235e9.2
        for <linux-wireless@vger.kernel.org>; Tue, 21 Apr 2026 06:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776779386; x=1777384186; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wFXIqjjIh6B86ukYOT7ztZRXCgjpoe9+bdEteficNBU=;
        b=sveQIkXUAUyGQrBJFx183yifE/CennLIUH8KLqcjczMRl++E4LxKJw84MhT2cUQAGn
         Yqt7BRwi6AyfxvBSICv9BCm+aDkW5uRCMC7zygoM+Pfe1IM23xjNCnpRkD4iPlDvGrpw
         7SUU5SkDC1wPDmAM5koYrktjPFYfs3XVE09dm1dpJ7n3tmcprrvC22UqkBisrFE40xxL
         ue7Ilm+7uGstDDHYEeUh70bC9At00iMfcbzbk/63Dz2NxuK+j46Z5R6wfwp9gScNZlPz
         UK3XaHWAugikMexgHiuYCmFf0Uzm4R0eUg6PVAuIl5FeepFZ/0xeC5CQYBv+qLfmRy8z
         H4vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776779386; x=1777384186;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wFXIqjjIh6B86ukYOT7ztZRXCgjpoe9+bdEteficNBU=;
        b=EsOxPbC+M5gLhaN5CXy6iqdvWcegGbHAQDAzkZSV1nSZXNIgOHhUHjdxvJNh472LPW
         zMfLNINXmTvvHi4lz588DhbwAqhNDmION0LOjvKim8CsyUjKEcBipvqK9wSnLAqf7SxJ
         lYbUmBTlvSMnO+4R3JZ2a6AoJF8ErUTAdKycDsKB7K3NDlK2PqnQbjeezka8cOqpiOcA
         IWEPLRshZrGwRFHX7psr0QQEzBoEzqMlP9biKTN/9m/KB8Zg6WRazYHhKikjM7ptCJir
         RqnT0VmadqQMeIGPMYzvPjbJeTDY55PkbgAtVx3w7nCEjPTJI7rq/xGLAf3r0nSoqgGj
         daiQ==
X-Forwarded-Encrypted: i=1; AFNElJ9OmDFSuEzY6xcc45InqrTn1dEvYmWz1PzY7sWfTKpYHzhLtSphVNWJ+ItiVtMnLffpJC2M4gImo9H8W+yY/A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4gj3o/9hfZdAgqy68zCLb2yQN2RHE4bxcp+vRkuQxgGp+jrVL
	4OBHoDyp27reFZhSviaJ+RGRz2EsryvD9mKP4C1PC2VxBQdyzJiNLY98MVeZ
X-Gm-Gg: AeBDiesL0ropsVftjXDSPUEKHbkvFd2F+A7LG/q1rUmaGUYh3r/s0aEOYKh/1/X5JQc
	qAdu8A1D4SSkViB6GJjltNmVX7vHu04GfuonWFsJE/2zAh7B5fow9gOfJ89eZT0So7B+pNp2o+B
	88OcOcLSLf/HYjZwLJjUkvJIC8AH1LHEgSY3LBrFO2sJ7wsCENbS+ZVZyYyaZ6x4+IP8yTd3vEb
	JBIv08S9WBCO1MuyeoHD36Ki5li7woDeRSEQEXKWF6zpVV+ufPee2pZSL5OVfLj8XbmW9ijlyVv
	SoJZrgNxwbEcJl4D7nBzz9gs96631cnn0SDqWDIQxCsT5noIypuHHJ8U5via2EiEbflI6f66sst
	cYZjVfcGQ79v51aMwokF6fGR6FZK1zlsZvOXWDwPVpdOC/wLS5EZM3KgeT5FekZMRUcv1qOtPC4
	3P0y8=
X-Received: by 2002:a05:600c:1da1:b0:488:d376:42cd with SMTP id 5b1f17b1804b1-488fb785901mr290755475e9.22.1776779385831;
        Tue, 21 Apr 2026 06:49:45 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fb78becdsm176331185e9.5.2026.04.21.06.49.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 06:49:45 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Brian Norris <briannorris@chromium.org>
Cc: Johannes Berg <johannes@sipsolutions.net>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH v3 5/6] wifi: mwifiex: fix OOB read from firmware intf_num in multichannel event
Date: Tue, 21 Apr 2026 13:49:37 +0000
Message-ID: <20260421134938.331334-6-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260421134938.331334-1-tristmd@gmail.com>
References: <20260421134938.331334-1-tristmd@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-35155-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tristmd@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,talencesecurity.com:email]
X-Rspamd-Queue-Id: 3661543B8E8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Tristan Madani <tristan@talencesecurity.com>

The firmware-controlled intf_num is used to iterate the flexible array
bss_type_numlist[] without checking it against the TLV data length. An
inflated value causes out-of-bounds reads past the TLV data.

Clamp intf_num to the available TLV data.

Fixes: 8d6b538a5eac ("mwifiex: handle multichannel event")
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
Changes in v3:
  - Regenerated from wireless-next with proper git format-patch to
    produce valid index hashes (v2 had post-processed index lines).

Changes in v2:
  - No code changes from v1.

 drivers/net/wireless/marvell/mwifiex/sta_event.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/wireless/marvell/mwifiex/sta_event.c b/drivers/net/wireless/marvell/mwifiex/sta_event.c
index fecd88967ceb8..6b7e5b6a66a9e 100644
--- a/drivers/net/wireless/marvell/mwifiex/sta_event.c
+++ b/drivers/net/wireless/marvell/mwifiex/sta_event.c
@@ -450,6 +450,14 @@ void mwifiex_process_multi_chan_event(struct mwifiex_private *priv,
 
 		grp_info = (struct mwifiex_ie_types_mc_group_info *)tlv;
 		intf_num = grp_info->intf_num;
+		{
+			u16 fixed_len = sizeof(*grp_info) -
+					sizeof(grp_info->header);
+			if (tlv_len < fixed_len ||
+			    intf_num > tlv_len - fixed_len)
+				intf_num = 0;
+		}
+
 		for (i = 0; i < intf_num; i++) {
 			bss_type = grp_info->bss_type_numlist[i] >> 4;
 			bss_num = grp_info->bss_type_numlist[i] & BSS_NUM_MASK;
-- 
2.47.3


