Return-Path: <linux-wireless+bounces-31149-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6q7KN8FxdmmIQwEAu9opvQ
	(envelope-from <linux-wireless+bounces-31149-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 25 Jan 2026 20:40:49 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D848823EF
	for <lists+linux-wireless@lfdr.de>; Sun, 25 Jan 2026 20:40:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 304B5300425E
	for <lists+linux-wireless@lfdr.de>; Sun, 25 Jan 2026 19:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3C462FA0C6;
	Sun, 25 Jan 2026 19:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=u-northwestern-edu.20230601.gappssmtp.com header.i=@u-northwestern-edu.20230601.gappssmtp.com header.b="KO4VDU6u"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E389F25771
	for <linux-wireless@vger.kernel.org>; Sun, 25 Jan 2026 19:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769370046; cv=none; b=EogDmR38dgvRifwlh9kUFny5sFnfQ+dgRzlAm20gyrpnXQZX6J5ap17hHngrfCHbgk7EKSDI/paMQRFP3SuR5oh7SDX/BZpcjc4OAHErhJfA/l2Ed5KUiMBo4+PkmZTdE4DnzZUaXNRDO4y2k9mLuC3zemL7bLU7TjADwfC/0cI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769370046; c=relaxed/simple;
	bh=NDw0zdlNccBo0OEGcTqzdJEKe4tgfmzrwRyhiRthcVU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Dr+sEZADVgN6+XO10YbfSntRT9m7fbaPVla6vz0BvdRYJns7WnrzMlHXDtBv2p2CPHSOiOwDCueHgyICTKSCseG8Vk1NhVRTEW4k8iirkLeAcBZL2U9VQeGn1q9QLQnFc6Eihb4LYC6i34lA9R+vemREVW9SJOoC/cDyUl+U6eM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=u.northwestern.edu; spf=pass smtp.mailfrom=u.northwestern.edu; dkim=pass (2048-bit key) header.d=u-northwestern-edu.20230601.gappssmtp.com header.i=@u-northwestern-edu.20230601.gappssmtp.com header.b=KO4VDU6u; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=u.northwestern.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=u.northwestern.edu
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7d148dd16edso3382360a34.2
        for <linux-wireless@vger.kernel.org>; Sun, 25 Jan 2026 11:40:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=u-northwestern-edu.20230601.gappssmtp.com; s=20230601; t=1769370044; x=1769974844; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ujBxaUbZpVezvFs0113sYpNtSpcNhJdPNBv65Q63G8w=;
        b=KO4VDU6u5SNdNTKMe0jk8amn08v1lNE+RtxuoILbQE2zyYgzaYoxh+o9MZCiagVZGL
         YfaCSMZxlCZEB2PhVOzX6scCsYrXv1q9YpCqxA6O/0eXnGKYGDzq4aZtms0WjRHzaOYR
         1j24P8KAzgflWMm0ekgxiQUsqlJZC3Ar9IfsnHfJ+t7Y6RGoKA3N8I2qDYX8Zvo9FApv
         YHd1rQj32v5dlmNw2eQUYp4gPmJrw0C2mV9buTwDL0cbOL3cK7TNDJv3aIS7Y3ahXzIq
         5mmdPVyB+T0Cb5BrAV7eaWX0bQiMPcjgl/SId9El7908s43xLvBeuJbewFaDaJ5GYlfU
         tNQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769370044; x=1769974844;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ujBxaUbZpVezvFs0113sYpNtSpcNhJdPNBv65Q63G8w=;
        b=cDk/L6v7LwoMwdly3eMfM/6i3wmPXHp3kMoJ8wt91yhPnVY5/sxekMFYe6STmsSQLP
         ozV7R6+qa8l4gRYBjuhvMzVFR7jAX1tsT8936435LI8Aifko+Ds2xZxdCv3i8xLHpjZ0
         vi+i0+C3558yragoC/R/DejPsX4+JxhH3sxA8EpZiyC8IWmx4ujQdUItZmY03QATuk5c
         Hn6h1yJHE+6LvkW1spiKN8Ty8/ZceYi8xAzhgoUh5LfKmueaZDf3raVoBwipXb5BfaF+
         MvfaUU225j1EwM1O70mbrk0ch2KNR1GmWF9UPJJuJSbO61+UgrfIWxo/mq4bi8GyzZY4
         iPmQ==
X-Gm-Message-State: AOJu0Yyp6N1HfrgHLbOGNHEbrzfVjMnVQECyOxuCONlf7q/FzKPMdRu6
	OjS7o2RpfVH5bOoGyGCsA0bDlY8lwtQ304e+0hp1Nyr1iXzh3WeX7PvHe4iQZBNPWoU=
X-Gm-Gg: AZuq6aLAqvtGyciT/eNCHtukFMlpBVeAFyHHVqMlFLYnWTY7gmdRALxJS0aCSK0VWdW
	EpRRTj5/vnsU0wjLOs7p1YwBSiLaJ4Rm9KO1fNfSMNOWSrdbCXUjm0xOyBpdzwQsZEhPfmFfa/P
	MBpe+Xtz+JOBW788UrGkpx3mV8o4M4bc7tYkF3cctPzuEefCQuNWJShRXSok4vrX/OSprfLRrhr
	5lEmSTwoGWxyVICIqlYcw5ruMllzGZus4SFfTiw+i1gIP6U1mp0Z1+h2BdAj/iAl7VQSiMVMP76
	FBLW2okNmQ3ww8FQLA/FVRDEZEO5k/W80UKA8G2XJPyd0ShfCepINt+1jfI1GDVIykmCJErx/e7
	vKQXCJulBCKCgxWJDDLasV2AQ8K4FmBTrLMAgfWalE+KPSKWj+lziBVETdNCes74j3CV3M3L74u
	xKm8/qlBCTiwUZt5QhRscGQb14QEa41iA8PfwAWzr901YqvDsjAUarRuFF20hbitAyjjTsTfpNC
	d3DKcRh9y2tNQeK4RcHcLbhIFMYaxE=
X-Received: by 2002:a05:6830:6102:b0:7c7:4f2:e15d with SMTP id 46e09a7af769-7d170223bfdmr1559368a34.16.1769370043771;
        Sun, 25 Jan 2026 11:40:43 -0800 (PST)
Received: from security.cs.northwestern.edu (security.cs.northwestern.edu. [165.124.184.136])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d15b346e2asm6426106a34.2.2026.01.25.11.40.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Jan 2026 11:40:43 -0800 (PST)
From: Ziyi Guo <n7l8m4@u.northwestern.edu>
To: Stanislaw Gruszka <stf_xl@wp.pl>
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ziyi Guo <n7l8m4@u.northwestern.edu>
Subject: [PATCH] wifi: iwlegacy: add missing mutex protection in il4965_store_tx_power()
Date: Sun, 25 Jan 2026 19:40:39 +0000
Message-Id: <20260125194039.1196488-1-n7l8m4@u.northwestern.edu>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[u-northwestern-edu.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[northwestern.edu : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31149-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[wp.pl];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[u-northwestern-edu.20230601.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[n7l8m4@u.northwestern.edu,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[u-northwestern-edu.20230601.gappssmtp.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,u.northwestern.edu:mid]
X-Rspamd-Queue-Id: 4D848823EF
X-Rspamd-Action: no action

il4965_store_tx_power() calls il_set_tx_power() without holding il->mutex.
However, il_set_tx_power() has lockdep_assert_held(&il->mutex) indicating
that callers must hold this lock.

All other callers of il_set_tx_power() properly acquire the mutex:
- il_bg_scan_completed() acquires mutex at common.c:1683
- il_mac_config() acquires mutex at common.c:5006
- il3945_commit_rxon() and il4965_commit_rxon() are called via work
  queues that hold the mutex (like il4965_bg_alive_start)

Add mutex_lock()/mutex_unlock() around the il_set_tx_power() call in
the sysfs store function to fix the missing lock protection.

Signed-off-by: Ziyi Guo <n7l8m4@u.northwestern.edu>
---
 drivers/net/wireless/intel/iwlegacy/4965-mac.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlegacy/4965-mac.c b/drivers/net/wireless/intel/iwlegacy/4965-mac.c
index 3588dec75ebd..57fa866efd9f 100644
--- a/drivers/net/wireless/intel/iwlegacy/4965-mac.c
+++ b/drivers/net/wireless/intel/iwlegacy/4965-mac.c
@@ -4606,7 +4606,9 @@ il4965_store_tx_power(struct device *d, struct device_attribute *attr,
 	if (ret)
 		IL_INFO("%s is not in decimal form.\n", buf);
 	else {
+		mutex_lock(&il->mutex);
 		ret = il_set_tx_power(il, val, false);
+		mutex_unlock(&il->mutex);
 		if (ret)
 			IL_ERR("failed setting tx power (0x%08x).\n", ret);
 		else
-- 
2.34.1


