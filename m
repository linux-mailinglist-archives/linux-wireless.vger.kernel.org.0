Return-Path: <linux-wireless+bounces-31599-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iDhcAcjShGlo5gMAu9opvQ
	(envelope-from <linux-wireless+bounces-31599-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 05 Feb 2026 18:26:32 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 72DCDF5E3C
	for <lists+linux-wireless@lfdr.de>; Thu, 05 Feb 2026 18:26:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E33D2301DB8D
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Feb 2026 17:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1975E43D4E3;
	Thu,  5 Feb 2026 17:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KZW++YAA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE33243CEDB
	for <linux-wireless@vger.kernel.org>; Thu,  5 Feb 2026 17:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770312211; cv=none; b=p4z5vucVLCcNKmvs5vExMciFgpZ+iGQfRFHy11wVdBaab0JtoJrS6PfibcJUc78Fe79JodmsxqnAy708F7QLOH74rWv49INx8IVdmTddpHtmkx9AF8UvAE2y/rTiJqjvStQPP7C1a82qIDACQKIkwGUilK+0giEzBR+5QahO1Fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770312211; c=relaxed/simple;
	bh=IIn3uaeCxcPp/5+0kpXP9/e64YESCdwAQ/3PXIdDHVo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HviSAwhZKW7bZc5dAZrBerv1q4DyZwaysBJp1sYPSLGTmYCFUWol3ob9fF/bsAgXGrwFpoZpFLQ96VJTKoIE7tlqPomt8wtY0eHfJW+cYgGWGo9NK7oPwIDCz0sFGwAIHERX4OukOk/BEGxlBl9diYUAHBUUZsGFr4zf4L4NhVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KZW++YAA; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-81e9d0cd082so1066497b3a.0
        for <linux-wireless@vger.kernel.org>; Thu, 05 Feb 2026 09:23:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770312210; x=1770917010; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+yuBsGZrwpORrmTJvhOPX4f7OMrH7yvsvWogFITeQFU=;
        b=KZW++YAAXx6E539ie9dkvNUAl3uHnAxxJNsEpUkKn2hxl8hBGdGxnEel7lwl2cTk6J
         oBlC/zfpKHRVll7cOr4RGDCF1lRfI92zfSt6Ytyx53qutste+NIDltqzbDPTcNRRDTeR
         OdNfRIHrvwocg9qzjhgiRsBaj/S1l96Yhpeu6s8m4P3+IiCQh+R2fLwNb0ivdm2metS/
         IPGP8OBiboGZHTtvaPUq+BzXf0UrHKMa+/P0u2KzGaGyMpqgSIM2osmsf2Ui7tMcQOsK
         jwS2fbCmPZ7qkQjJM7i/aDaY8XTOMI6m2UREIfcSYJjr/ngLv62z6Qva9VMRK087qgS1
         Gbow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770312210; x=1770917010;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+yuBsGZrwpORrmTJvhOPX4f7OMrH7yvsvWogFITeQFU=;
        b=XPLQBayPnzlfFaE2+wIjVCmCiM8P49OxNXVpbzYyAvT1a4WINnmMr62JFqSd9wUx+R
         VJ7azoHm6Y37SQp5P6Xx0LPcHdOi198aDj2FH9m2HeRqNarIu6KNV95WU91lqzHmlnVU
         mAZ2Ndil+HHVgjhcyQnQTYbe83H+ew+wm60h0++yUhC+gb69sD/kreqlDLmQCMUtcVLx
         3k00FlUj9DBtofsyzpneK9pC8106Z6mYyCBu6tal1w5a1FDkWozSsfXBVs0zFJr+0rww
         9iFeKTlLOIsf3yTzMJL+mtXpUl74jcJHhSplEaiqyuxAE0+7K0Sq/UIU0DHeyu/V4UmP
         +rgQ==
X-Gm-Message-State: AOJu0YwI3LnZRqPj7Rqqog4D9fErs/52kGFGV/E14X79OQMsL8yzGMJW
	iGYBkSTddVp5/+pbNJUD1HHVAPjxmPKd2baXm+IaF2flgFRFDBMi4XYL
X-Gm-Gg: AZuq6aKqExP9OTrdwPbm0pcLaH/rFIgTPSs4o47OHQt9rt/09xxJPt2TwFSZNp4N+0w
	1abFT/65jN8+WiH2L8ldw5h5hN6aarw5rGwOVKH5fFui17wRPMpPWj/EEIPuzuTRysaYWvrHHnP
	WWBcpvtHsw3tGVBl/8B+AcXzspT6fmG59/+c7YLTn8W496N6w60GBoqUrX9uztRb3lXECZty5GJ
	LvUW9yGzyiiyJ5RIRwEdfSpQzTvXRakJThhOfZJqxVjnMsI0KMDXS2VFWigAxVYQ90H6tZTJ72U
	bEQGzz3J5d7Z1a067H6OooEozfqcbcwl8h2VGGLc/RkS6kk6KmNFIWMbvo50Okn805v8AnIViO8
	jbfgVjlcmEwTazYV34bqss7P4RoGApjC0mtnhJV5HyKiTXGQ7YfetcrY6wrQd1pyPGebigNyb7b
	tbK2AbwOxZo42f+Acd0i+kuA==
X-Received: by 2002:a05:6a21:a8d:b0:38e:9cc5:217e with SMTP id adf61e73a8af0-393ad005985mr117777637.32.1770312210076;
        Thu, 05 Feb 2026 09:23:30 -0800 (PST)
Received: from mint.. ([106.205.245.146])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c6dcb5e5f98sm29117a12.17.2026.02.05.09.23.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Feb 2026 09:23:29 -0800 (PST)
From: Dhyan K Prajapati <dhyan19022009@gmail.com>
X-Google-Original-From: Dhyan K Prajapati <dhyaan19022009@gmail.com>
To: Johannes Berg <johannes.berg@intel.com>
Cc: linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org,
	stable@vger.kernel.org,
	dhyaan19022009-hue <dhyaan19022009@gmail.com>
Subject: [PATCH v3 wireless] mac80211: fix NULL pointer dereference in monitor mode
Date: Thu,  5 Feb 2026 22:53:12 +0530
Message-ID: <20260205172313.16652-1-dhyaan19022009@gmail.com>
X-Mailer: git-send-email 2.43.0
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
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-31599-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dhyan19022009@gmail.com,linux-wireless@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 72DCDF5E3C
X-Rspamd-Action: no action

From: dhyaan19022009-hue <dhyaan19022009@gmail.com>

Signed-off-by: dhyaan19022009-hue <dhyaan19022009@gmail.com>
---
 net/mac80211/main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/mac80211/main.c b/net/mac80211/main.c
index b05e313c7..190222c26 100644
--- a/net/mac80211/main.c
+++ b/net/mac80211/main.c
@@ -416,6 +416,8 @@ void ieee80211_link_info_change_notify(struct ieee80211_sub_if_data *sdata,
 	case NL80211_IFTYPE_MONITOR:
 		if (!ieee80211_hw_check(&local->hw, WANT_MONITOR_VIF))
 			return;
+		if (!link->conf->bss)
+			return;
 		break;
 	default:
 		break;
-- 
2.43.0


