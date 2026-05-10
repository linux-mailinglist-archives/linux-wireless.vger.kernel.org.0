Return-Path: <linux-wireless+bounces-36141-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id jCs5OwNeAGoGHgEAu9opvQ
	(envelope-from <linux-wireless+bounces-36141-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 10 May 2026 12:29:23 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 638C25039F9
	for <lists+linux-wireless@lfdr.de>; Sun, 10 May 2026 12:29:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AEFF3300A109
	for <lists+linux-wireless@lfdr.de>; Sun, 10 May 2026 10:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0533E257854;
	Sun, 10 May 2026 10:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fZ+pYkhZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68FF62032D
	for <linux-wireless@vger.kernel.org>; Sun, 10 May 2026 10:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778408958; cv=none; b=enai5pHBm6nTCJ2vnwGaRB66zy16ns7fwl5HFqo6WQZm/D4+R6LwAUOPMjITY8ra3SflYc7SIAPka46g6PceisSyrmRbfabbyS8cUhJwfWFeCtHTmd4EmqFdwsgwe004KehLiiCoRCuXvvjylpRXdYgi4M1sI1E9lnd7cxodw8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778408958; c=relaxed/simple;
	bh=o8eLa5U7RGyJZuBKXY2A3Mt8d1mQXIUPlY3RV7+a67A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=F1ncNN9KCzZ1sD06XawnrdWWLrbYD8Lv6uw1yU807wgPlH6blXJth9gj5A/Mb+k8ur2r5XGqMTGBYxr25nFi7A77IiSb6F1FTI8QODuPleRFp/7TrQ+jQTCoPL634ZCzWK4R9r1XJ6sj5gca+fo15ExhXpBWbAzbTVfSCOhoorE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fZ+pYkhZ; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-393800586aeso43496421fa.1
        for <linux-wireless@vger.kernel.org>; Sun, 10 May 2026 03:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778408955; x=1779013755; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8H4uVV5AgLYrtuJu7CeuLlxyoa7HTanOvw0Zw/EkqYY=;
        b=fZ+pYkhZB3Lliyi4jA0gY0IUdGjOR8tZ94Lu7FE6vTm81i7REFGuD8sB3SbdvOTQJH
         1mZ9nEIHJoTzEhYPyCUo0Hp4wWIdFACV/XbePpaqWC79hE+qNQJ1THpBVLyQ4Gr2gGN1
         AtpARgyn15UBx6NYwY5UcKIMDKoLkG9xRxdq0D9H5ibQMRY7HJxGIyZF8YE45BBcqrWA
         z/r0O9FXq4zYnUNTC4sUhBkQ3pWtlOxDJQBVmwp9eDLa6FItBNI1wOc850XpSdljrX77
         Yd5r3RqW65dHK72OiRR53xIhDts4BPACHAE0/dqpWuGmJvdAxIGhkLuTRCTB/UVPZ8NN
         bbIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778408955; x=1779013755;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8H4uVV5AgLYrtuJu7CeuLlxyoa7HTanOvw0Zw/EkqYY=;
        b=PAGDj+4FHWFGiZSnWv1EamoQgobTZfqHMVfl1mW88BmSoBe+LKYxEwgi59eZTZkBtA
         RxpZeBLdpwDlW5+hMZ4se04Qs7IIFQMNkKB+2Kxt/GQla5WNg5p0U5nateSHDz+NgGkZ
         ebbQ0qfeXFOFFDWLBxkU5SaGX0/wtvrpMsnG7g0GfEakq9ZYaLkWNzfR2qLuj9TG+JHY
         5Syslsx++X+Ii9BmGHrbgLnrhA6g8LeTnQAMdzZePJiyjGuwy9DHGRkGLjDz7atu+0W2
         06H0E/43QMrln/XuyxpGuAdfZRkMcAOCcLjl2BJ3kGezlCBniDgZF+yQ+bStfi8yUdwO
         8hlA==
X-Gm-Message-State: AOJu0YxoejoAcObK06l+3WP/UZsbVrLifPQ/lvVbyxFgdAy3ZyJpR2ED
	g0ME6p2jjiZBJg2zX2PmmCobAFsq97dhG6TXleLxst6e49W2Y04Nnt647kQ4bmaE
X-Gm-Gg: Acq92OGxmjRL8Lr/jMsYY5kX8qXAS4mJpYptAtv/+UbjqX3E9oY2lKEaKbPVbcRsHcd
	QNt8M+xIVgduBGSuy0Un9SmH5epuyjI1oXStBdRiHB6Mzy7UqJVyhDvO5vmpJun3NHY8mAnaA8u
	K3qJlp4X8xf2ynBDfQmeoAWTgoz2G59PQ2QfwpUyhhrsHlTc5AzsL7e/XiAvJRHwsM6rXzwnDsX
	Jsn+3sVuzVr9OxTIE687a/0s9LDXxbOe8KxdfoWbXNHb7AWRHGfgGlrXtwo3bIpK8+o/6hJSrc1
	BkzgsEWY6wWbNnmNYbQsl83S5/pXSoA6Mqy2YB7f5sllDLQtQut8dUv0OdeEqL1yKJPZ60v/90j
	CCjz7AU9Oj2DbzZVktGwdwl/oZ7CjAEWIX8bh6oJ05ZAaGSplqHlHM9f9DEkQIhOSMnirHIH9XV
	oIKz96TtythvxRMci0v1RfB1y8ofVxU48KTZUbSn7h
X-Received: by 2002:a05:651c:2113:b0:38a:5bf2:80d6 with SMTP id 38308e7fff4ca-393daec8fd3mr47745331fa.5.1778408954818;
        Sun, 10 May 2026 03:29:14 -0700 (PDT)
Received: from arch ([217.76.176.49])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-393f60db2f3sm17956511fa.22.2026.05.10.03.29.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 May 2026 03:29:14 -0700 (PDT)
From: Dmitry Gomzyakov <nicerok11@gmail.com>
X-Google-Original-From: Dmitry Gomzyakov <kyoto1337@protonmail.com>
To: linux-wireless@vger.kernel.org
Cc: Dmitry Gomzyakov <nicerok11@gmail.com>
Subject: [PATCH 0/2] wifi: mt76: fix NAT performance degradation on MT799x
Date: Sun, 10 May 2026 15:29:09 +0500
Message-ID: <20260510102911.1883849-1-kyoto1337@protonmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 638C25039F9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-36141-lists,linux-wireless=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nicerok11@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,protonmail.com:mid]
X-Rspamd-Action: no action

From: Dmitry Gomzyakov <nicerok11@gmail.com>

This series fixes severe IPv4 NAT download performance degradation
(30-40 Mbps limit) observed on MT799x platforms (MT7987A+MT7991A,
MT7992, MT7996).

Patch 1 adds MT7991A (0x7991) to is_mt7996() to ensure correct
chip-specific settings are used.

Patch 2 restores host-driven TXWI filling for all packets, fixing
firmware misinterpretation of NAT-modified IPv4 packets.

Dmitry Gomzyakov (2):
  wifi: mt76: connac: add MT7991A (0x7991) to is_mt7996()
  wifi: mt76: mt7996: always fill txwi for 802.3 packets

 mt76_connac.h |  3 ++-
 mt7996/mac.c  | 12 +++++-------
 2 files changed, 7 insertions(+), 8 deletions(-)

--
2.54.0

