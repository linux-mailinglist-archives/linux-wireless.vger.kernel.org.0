Return-Path: <linux-wireless+bounces-34436-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CHndI+6Y1GmkvgcAu9opvQ
	(envelope-from <linux-wireless+bounces-34436-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Apr 2026 07:41:02 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ED18E3AA05E
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Apr 2026 07:41:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3752B307CA14
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Apr 2026 05:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C28ED231832;
	Tue,  7 Apr 2026 05:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ILNm+Vky"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA53A175A7D
	for <linux-wireless@vger.kernel.org>; Tue,  7 Apr 2026 05:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775540367; cv=none; b=KLX2yJUwLJfNVVzf1BTHKUWCFCllwDXr892GB0Xp/Otz7NpQ6xurQbVnxCIaVgXO4zTwsoHtHcZHYhv94mEX6RObykMNtTyLZhkfflSIAYoGQ6RfaycYlo4FUYkxQNLbtQiKFNUiRqNoZ8OxGAuWUo6omYxyGzX7VLo/M4ifGZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775540367; c=relaxed/simple;
	bh=gLLRysJgqtxfbkMgtSUPg+R5wpGEgyMR7d9ZxiRD9P8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PhqWAbLxFJN9RjQycwOL7+pZcxpizrNFCcPkEj7IGD0D5MJdNUrfdt/eksaKEYwlKFJePiMjjfXt08noR5uV2JJxE8Bh1bjzbkXFZmhQnaoQXHrqNI0VjroPt0HHTjRNWoF0ViuaWwbzlUqrZhPcEQ5mR+uLo6OKPwzR/9bbDGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ILNm+Vky; arc=none smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-6501d242e3fso4438514d50.0
        for <linux-wireless@vger.kernel.org>; Mon, 06 Apr 2026 22:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775540365; x=1776145165; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1GbJv8HFlv+DQypkAJpKdzxb/IM9vv/1UJPgBfIjMvs=;
        b=ILNm+VkyfBTsyIl92P170DyA0/px2n7+3ZelR7AS5hPUhoJ+M0h6AlC+hHuf5dG0fS
         2IcQjos1SpHnlvFIAj+V1Nl0cq7f+OhkekwUr1zRGCPZR0BH8OWHqxnNVnpAnZu9H7YO
         MQdjvhuITFHX//UXMx+XKsAgFyoPDixIYiQzQ3VqE5FNSvzf3hijZmxIeJBkalsQk1A9
         UPJBQSXRqCrxKPYyeVSWSUcJj0Kw+8bl7CHCE2mq0h0IOct1Hgsp4O+TkkOMc14igPVB
         GGU+6N+gCwo3I8+H0iqEwJe1u78RQKWnCI+al8bMB+c2Vk4a71NZQiN/amIQrU30FxR/
         UzDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775540365; x=1776145165;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1GbJv8HFlv+DQypkAJpKdzxb/IM9vv/1UJPgBfIjMvs=;
        b=gmmBJkgDnEsGkgZPsIM9CjHcyDqEYIVJCdX7WTrKoP3nFvq8uOXwArNmUdAoSNEAUL
         LzuIRE2u3cK27bdPPSM7fwgVHVXgO+9DEsMUm5fsEknXaqdzutH6T+NlfAJqRwPmULOg
         4GCZipccRkKEcGqcgtTWOWlDxn7mX2sNWQG3OoZXRLhBXEeSJCp5oVDlpQtMkAF2jgjT
         yoojaxQcykGJhwidwBtj15Ny6w+PbUFUMnq1xACnZPquFBQwrjU5Q5R4PX7i3e4Lgk28
         /uqpDFMzvpKB62l1NFy9oPXG/wmHe9omZB5oYllw5rLTIpCSWyzBy5mX0omgbO/y/UtP
         fftg==
X-Gm-Message-State: AOJu0YzUw8RBWFZZBtZJpiSu9FUBTJMci3MO2vLBVqeTjmriQUSvqStf
	Er2vhqWPTeULThw+TgmgdVGhkgWDNCq0uVlBF0Xr06pxJFUbuPFGlKJl0FeyjHWd
X-Gm-Gg: AeBDietEXYCXiprE31GAiKI8wUjLuiCY6OZh0EHcS73g1Dwa93j6Oa2BY1fHzU3r/2e
	0+RHBAMDkEWLdFDxb+00/jV1baEf9preXwkc/Qxx4A+ulSsnskqzuTx9BCaa8cJ0aTULJzPHNp6
	hSWvE/mghh6kIKEq4C78F0tMp3TxMj4Y9qhxVXMB0FMLyBLgM6FX6TYkjyATsVi0hPp7VkPiVtr
	x/8BN5qB42hvCg3OEXtsNHp/tWk3Z/7PMrsKwxHs34sPy0s4ozEVKcxaiad6GMETCOHq7Yb90x2
	1yuT2mZbtNDbrSibwg80xxyfn7QeLkUpkCanR3mFYdTbLPDQPhKPARSxBI9OyzCDkThSB6+01ED
	knCQ7+touuxODote7an/qdngQmIc0VVbFzZxjg48dMYCL5AYJ75mA4S+q1ojjzgfeKmIVMOjpyh
	vry26TEKi00LTa4KcIo779ZnA1lJhyw7nEGu75hpd2FqHHr7fvjMcICJOJEKldMOT9QUf+o3w=
X-Received: by 2002:a05:690e:128c:b0:650:329b:abbc with SMTP id 956f58d0204a3-6504868e103mr14889711d50.13.1775540364835;
        Mon, 06 Apr 2026 22:39:24 -0700 (PDT)
Received: from DEV.lan (c-75-74-152-49.hsd1.fl.comcast.net. [75.74.152.49])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6503a978b7csm7217468d50.11.2026.04.06.22.39.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 22:39:24 -0700 (PDT)
From: Joshua Klinesmith <joshuaklinesmith@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: nbd@nbd.name,
	lorenzo@kernel.org,
	ryder.lee@mediatek.com,
	shayne.chen@mediatek.com,
	sean.wang@mediatek.com,
	Joshua Klinesmith <joshuaklinesmith@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH wireless v3 2/3] wifi: mt76: mt7915: clear cipher state on key removal for WED offload
Date: Tue,  7 Apr 2026 01:39:16 -0400
Message-ID: <20260407053917.75898-3-joshuaklinesmith@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260407053917.75898-1-joshuaklinesmith@gmail.com>
References: <20260407053917.75898-1-joshuaklinesmith@gmail.com>
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
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[nbd.name,kernel.org,mediatek.com,gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-34436-lists,linux-wireless=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joshuaklinesmith@gmail.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: ED18E3AA05E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When switching from WPA-PSK/SAE to open/no encryption, the
DISABLE_KEY path never resets mvif->mt76.cipher back to zero.
The stale cipher value is sent to the WA firmware via BSS_INFO
updates, causing the firmware to keep the protection bit set on
WED-offloaded packets. The hardware then drops all plaintext
frames, resulting in zero throughput.

Reset mvif->mt76.cipher to zero and notify the firmware via
mt7915_mcu_add_bss_info() when the last group key is removed.
The clearing is guarded by checking that both hw_key_idx and
hw_key_idx2 are unset (-1) so that GTK rotation (where the new
key is installed before the old one is removed) and BIGTK
removal while another group key is active do not trigger a
premature zero-cipher BSS update.

Fixes: 3fd2dbd6a1d3 ("mt76: mt7915: update bss_info with cipher after setting the group key")
Cc: stable@vger.kernel.org
Signed-off-by: Joshua Klinesmith <joshuaklinesmith@gmail.com>
---
 drivers/net/wireless/mediatek/mt76/mt7915/main.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/main.c b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
index 116dff49c104..2365d1ccf23d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
@@ -414,6 +414,19 @@ static int mt7915_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 	} else {
 		if (idx == *wcid_keyidx)
 			*wcid_keyidx = -1;
+
+		/* Clear BSS cipher only when the last group key is removed;
+		 * during GTK rotation the new key is installed before the old
+		 * one is removed, so hw_key_idx still points at the new key
+		 * and this condition stays false.
+		 */
+		if (!sta && mvif->mt76.cipher &&
+		    wcid->hw_key_idx == (u8)-1 &&
+		    wcid->hw_key_idx2 == (u8)-1) {
+			mvif->mt76.cipher = 0;
+			mt7915_mcu_add_bss_info(phy, vif, true);
+		}
+
 		goto out;
 	}
 
-- 
2.43.0


