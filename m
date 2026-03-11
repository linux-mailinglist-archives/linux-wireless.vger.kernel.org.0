Return-Path: <linux-wireless+bounces-32956-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id jd0/Mi4PsWlwqQIAu9opvQ
	(envelope-from <linux-wireless+bounces-32956-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Mar 2026 07:43:58 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 261C525CF0A
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Mar 2026 07:43:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B9E1F312D6D5
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Mar 2026 06:43:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F12C9372EC6;
	Wed, 11 Mar 2026 06:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b="Vm/tDTWr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B47BF286415
	for <linux-wireless@vger.kernel.org>; Wed, 11 Mar 2026 06:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773211435; cv=none; b=Na51h3nCdrANXfROxm1Qkov5yYh4ayJxh+yCszs+n0xxV+E4IJ9jjv0NiBDpP2Obv4jGd3tr+1itMmyFbdjEakIJ9CbUA1BNRewD7QXtaB1+KP/clJjzt9K5HhcSTTxoqyGDR2O8yzwz0PPCKGSJCZNvGJkfyIDNRnqrQkLH1Rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773211435; c=relaxed/simple;
	bh=drPGH3vrdzKFUl0Ei5rMSe3Sqz6giAO06yaVdudiF7A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cvcmbaixPYFwxyKdtoydr6HYiisfvLpQma3XIjSNEOLoXHRRAztXCfTnKPBpFsPuNQJ5wuFybWM1/PWvHUWYnCIs99wDcNX5/cc4I2AV9wJDsyzpBt/azYOlwtPpPmIWnqKuh4+ExE0ZzqcQNIs/XsX2Q3YISbdLFp1bNr35aTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com; spf=pass smtp.mailfrom=morsemicro.com; dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b=Vm/tDTWr; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=morsemicro.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2aaf43014d0so101034115ad.2
        for <linux-wireless@vger.kernel.org>; Tue, 10 Mar 2026 23:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20230601.gappssmtp.com; s=20230601; t=1773211434; x=1773816234; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7H6If4cDM53mcRNVKQbAoN4GNFObfKcGSlYuiqjW710=;
        b=Vm/tDTWrHVggSqzeQF/JdaJewe9Bi1Ccdib7jxlv+/G15x29efV5FJkV0y0hflEXrT
         QhpbhdprrmY15WFuXo3cg/NFn89v/XpST+gZXE7QhckKTKUWrNk8VnjffH1KR/F1EwM4
         MToGxe+ls6bu/nDL4yI+upvFd7i0A9Gphk0sP5LsYqkGveBE1+lQLWbWRDq2XHckckiL
         fetgDXuaCeKYi1Uf5aiHLvFjUChnV9IlVlPgEJTG48xedCVX1OUzTiCGaN3MsP2i6PL/
         jlNqcuR0McYHKYFW8EeAnI9DwGFtcFtVmaks/bJ1F8s4e27/xUasDE6GN5jyHZCLKJcT
         ArFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773211434; x=1773816234;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7H6If4cDM53mcRNVKQbAoN4GNFObfKcGSlYuiqjW710=;
        b=Qur5L+uXLDBVM0TQunhr2omoYx2gOSMuqm105nwiIvgIKq32aN1Qib7qj6hS3bGh9l
         xviDZXDkbohOG+zL8AD+s5YkiI7jEpKl/KYjzn9ffGwJ4QpXYysWqsr9d1c6PDvjJKDO
         QyYHMlWRK92WvlZyz6CKNQwgsz+r31OB4zEUzm0/p5n2Phe3qhDir98pd7LqnUKHtykw
         njHO/A1jLyg+fnY8wdQFvU0c8/o45y/7uLpeOHvC/31Pia2fpVub8YXx3Kz5e23WaFlL
         VTLmdoS6ylDoaAIy8yNQGDgFsXhR4NcrX2Leq3IZ+v93/+iAuvxTYuRjhMYdTCXrh45C
         jclQ==
X-Gm-Message-State: AOJu0YzllM8+xL5b4w6/tC43OmIjZ3bbafQssixaZFLmISPRUGgoHfaa
	NLqdm8LwgO0XM3qADMsnE+4lPB5ZtHAdBjYi9AAG3asuNjELHTALGsL1MMNJ1ahf7iWOHA6Ah6e
	Fq3dP
X-Gm-Gg: ATEYQzxeIoOjPLI1CSsUh6W86chdWgVGMRGPalPiOdrfSi8Ro23nO5NVYbvfvHnZU7m
	lwBuUzgs90YwDU/Pf0ap90MfJ5RIov/uAsqG4CuND8EXuhX6RZYrjlRl1bp9gJNhGBEV4ssL6jh
	XEvIDweCAcO0GDCJza84j/Y+3Isk0O0PRt9p6mieICybUtXt+U5xAbIG2VAjWISbjBXG4/ZvfX6
	hYZu6CUFTM4lZHyWeWyt3PIdY00SBHyS+DE2C7EfvveMgTMAW4y7AhyW3LuXeCF3UnKBQofBbI6
	/yczT9G9kTbAgkoJhVl/X77eumNRmEDh0F+IJ3OvCMauLP/Oq0iFQZjsYsbyTG/2PGFlgJuZn+v
	HtYokBb9wfZe9xKHyJC4i/kdWkzSgQjXa01kEvKvmlpPPJhHh2zMSLTSBM7E/O9togrUFN7d9yV
	lRP5YDamunvAucUo6AzynzOlWDFd0UrkLQpmlfzKOuU0yWzqucAr5xs9jKmXpmdlZyY55wX4Q2p
	5Eokz84bj/lGrAGtvs552o/kO5vHtM=
X-Received: by 2002:a17:902:ce0d:b0:2ae:80f9:d8ad with SMTP id d9443c01a7336-2aeae76f3f1mr16059875ad.5.1773211434052;
        Tue, 10 Mar 2026 23:43:54 -0700 (PDT)
Received: from mma-H9MHD44.lan (60-242-93-14.static.tpgi.com.au. [60.242.93.14])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aeae34d930sm12555225ad.44.2026.03.10.23.43.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 23:43:53 -0700 (PDT)
From: Lachlan Hodges <lachlan.hodges@morsemicro.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	arien.judge@morsemicro.com,
	Lachlan Hodges <lachlan.hodges@morsemicro.com>
Subject: [PATCH wireless-next v2] wifi: cfg80211: init S1G properly when creating chandef
Date: Wed, 11 Mar 2026 17:43:39 +1100
Message-ID: <20260311064339.524758-1-lachlan.hodges@morsemicro.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 261C525CF0A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[morsemicro-com.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[morsemicro.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32956-lists,linux-wireless=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_NEQ_ENVFROM(0.00)[lachlan.hodges@morsemicro.com,linux-wireless@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[morsemicro-com.20230601.gappssmtp.com:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[morsemicro-com.20230601.gappssmtp.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,morsemicro.com:mid,morsemicro.com:email]
X-Rspamd-Action: no action

When creating a chandef, the initial width is determined by the
chan_type argument leading to a default width of 20/20_NOHT/40 which
does not make sense for S1G channels. Fix this by ensuring we default
S1G chandefs to a width of 1MHz.

Signed-off-by: Lachlan Hodges <lachlan.hodges@morsemicro.com>
---
v1 -> v2:

- Remove the mac80211-based wording in the commit message and keep it
  simple.
---
 net/wireless/chan.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/wireless/chan.c b/net/wireless/chan.c
index 68221b1ab45e..c0c0151fe55f 100644
--- a/net/wireless/chan.c
+++ b/net/wireless/chan.c
@@ -32,6 +32,12 @@ void cfg80211_chandef_create(struct cfg80211_chan_def *chandef,
 		.freq1_offset = chan->freq_offset,
 	};
 
+	if (cfg80211_chandef_is_s1g(chandef)) {
+		chandef->width = NL80211_CHAN_WIDTH_1;
+		chandef->center_freq1 = chan->center_freq;
+		return;
+	}
+
 	switch (chan_type) {
 	case NL80211_CHAN_NO_HT:
 		chandef->width = NL80211_CHAN_WIDTH_20_NOHT;
-- 
2.43.0


