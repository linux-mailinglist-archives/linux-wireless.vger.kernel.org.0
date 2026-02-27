Return-Path: <linux-wireless+bounces-32272-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yPEQOlocoWlhqQQAu9opvQ
	(envelope-from <linux-wireless+bounces-32272-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Feb 2026 05:23:54 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 494FC1B2A7E
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Feb 2026 05:23:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F07C231FC3D2
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Feb 2026 04:16:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD69019E97B;
	Fri, 27 Feb 2026 04:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b="Os0OB1N9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 085CC3491CD
	for <linux-wireless@vger.kernel.org>; Fri, 27 Feb 2026 04:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772165718; cv=none; b=rrVZudMwBQfffXy2sLyXPO5n4oigcRhMaGPsQcRy94m0fPC16IOc5+DX97+BoJ+4F/BQdElt1PBmylGib0uIcAhajK+TLleB/GzOCeZuqP5OmK4BNI4C7+CpSPGRnzKEKdHoSP4MLa8LJOqY6elp7e2Gg6pO6w9d6HCXXq2QsJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772165718; c=relaxed/simple;
	bh=umFqLkkCtEHhrB5xkU3rA0tKVMH9oBgD+CyFo4/y6oI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fJc4FYgeB8vPi2H72hCt2klSviz3Vhd8euChC1Wjc7AJmB6LOPoNIJ6LIdya8UYe+1ubASzcZPfd7iWSXLNesrYT7mFhb3BWsUKDNLuCtLpsIBXfrp2tzlhLwuVhbbw/L5Y81JQYabmiMQMgfNwXAOgWWfqFryBvFLHbHeXZUPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com; spf=pass smtp.mailfrom=morsemicro.com; dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b=Os0OB1N9; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=morsemicro.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2adbfab4501so7214495ad.2
        for <linux-wireless@vger.kernel.org>; Thu, 26 Feb 2026 20:15:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20230601.gappssmtp.com; s=20230601; t=1772165715; x=1772770515; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AGyuLcmqabu0coAnfLalHKdnzjl2iFV5tkrQRRcYS6g=;
        b=Os0OB1N9xiGjCkz+iwJR1ReXudQThNAcza3FFVRX2BA64X8Jxc401C9McRvmn2DWzB
         o+2LePPm9TbzD7s4CaxfZbdb7U97VEwpYGKxokUzPQ+6ZRx5qPxSF4QX592FKG376t75
         pmwI430oLluD2yXsIA9+U64l27gb55cL9ui0+QtjU6H1ASSwDjoLHXM6DajMCqVzoAaM
         RWMFBpWwL1131oQ3Q62fudSmhKmsEA+WKgN7GJ88xYmAUf3bH5Fc33oHfWfL5efUiVii
         FgMVugnncu7MYkOSKB4an6tMSgL8Tj0SjmvZL7eWiAVVW/43NVOWjbri6wHsFY1xHbgF
         O6Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772165715; x=1772770515;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AGyuLcmqabu0coAnfLalHKdnzjl2iFV5tkrQRRcYS6g=;
        b=q42a4LjesYLhnAXT5DH0z9Fenffaq20qubjbFrTVzjLz/bSUhORljrqupGcUWvYpl7
         itQ5/n3ghG0JDX6nAMF5I/lMnjTV8sl4iHtKCapoA3sW3/oYzFXeGvBuXcM877o9UX/7
         j/CgdjFFe8Hs2vuo8KEXjiQdkT+mbF/NDC6KXlVWHpGvU7qCHm/p1QZ9i34r1++PvicX
         B5qEsHdpx+ihf9/x5UnmJ5fq12ZDZaqJIJN3cMNw3L4E8CtdtPBZ1Al2y5Zvt6iFHxHq
         NuqVZslu3f4bMfriG+4cieRQB0pkcbSj39UcmKXThFqv33UBFj6wKain+Lk7hmuDMjf6
         93ew==
X-Forwarded-Encrypted: i=1; AJvYcCWeS7dvrxtUcRZy3IL7f/hYDOoY438EjtU8VfhZ/PSz8dx5/Fy6tdmpOdwc9yjTaz9Da3trTkRj9gSsu1Y9ew==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx76zB4A+GCwS08DmYkVEDkSBW829mUXJc+IpqGEpf2LByMWRVm
	nKc01dgU8w8JOobDmwJ2TGRsweJMk4X8JuJmMU7s8fdKcIIx/0pq8m7Tj590UsMSSd0=
X-Gm-Gg: ATEYQzySp4tlFTJy3yqbbmNkCrZmSL997KBBN36CL3WX5eiSpfpL5rxwHadEVcMQ1v+
	BkuANx/0lbD4dfJqubbeXejA+MWH2nkMtcyH4Lx6VJOtBhGumtejPbOMjxAQpEa8xnOAuCotJwv
	yQSvybfLTRRCalvWSos/J2m/cOolYyHd89ED+tU+qF6UvRdnJFIg8lLjJMN9CvuO5ZM2PgNu1BT
	J4/3ogm+UrVYU/eCB/4dFr+VIcRSCwAktcjPCYMJeoM42gJ8AVYSx3WDKp1q9MXuaqjNKgXNoQu
	CLhn+GiuZJpa9d8lCr1SUlTovp5Ga/S/n6W+GLfLQdofQ0J7IMCKPpS8PXr0nYKkmc/7vyHSKz+
	XZ/ZB1c9/p7BbDb6WvkcXfP/DOAX+YCkGvOKbSF+BN/hjdiVO1Egb85X3Rh5TTCCYDNdM+MgXQ2
	jE63M66d5bund+Y80WZBZBZobHrmr2noRV9zJ+DWTAKTcqaGA29piDRgClycluYoCIvZCm3+c5/
	b+ZRZXFrlf7/3FF86zbmxSPiAqEToo=
X-Received: by 2002:a17:903:11d2:b0:2a0:a0cc:9994 with SMTP id d9443c01a7336-2ae2e4d6114mr15271685ad.47.1772165715457;
        Thu, 26 Feb 2026 20:15:15 -0800 (PST)
Received: from mma-H9MHD44.lan (60-242-93-14.static.tpgi.com.au. [60.242.93.14])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb6ba5eesm41682865ad.68.2026.02.26.20.15.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 20:15:15 -0800 (PST)
From: Lachlan Hodges <lachlan.hodges@morsemicro.com>
To: johannes@sipsolutions.net,
	Ulf Hansson <ulf.hansson@linaro.org>
Cc: arien.judge@morsemicro.com,
	dan.callaghan@morsemicro.com,
	ayman.grais@morsemicro.com,
	linux-wireless@vger.kernel.org,
	Lachlan Hodges <lachlan.hodges@morsemicro.com>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH wireless-next 33/35] mmc: sdio: add Morse Micro vendor ids
Date: Fri, 27 Feb 2026 15:10:43 +1100
Message-ID: <20260227041108.66508-34-lachlan.hodges@morsemicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260227041108.66508-1-lachlan.hodges@morsemicro.com>
References: <20260227041108.66508-1-lachlan.hodges@morsemicro.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[morsemicro-com.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[morsemicro.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[morsemicro-com.20230601.gappssmtp.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32272-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lachlan.hodges@morsemicro.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,morsemicro.com:mid,morsemicro.com:email,morsemicro-com.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 494FC1B2A7E
X-Rspamd-Action: no action

Add the Morse Micro mm81x series vendor ids.

Signed-off-by: Lachlan Hodges <lachlan.hodges@morsemicro.com>
---
 include/linux/mmc/sdio_ids.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/mmc/sdio_ids.h b/include/linux/mmc/sdio_ids.h
index 673cbdf43453..3ccfe3679c91 100644
--- a/include/linux/mmc/sdio_ids.h
+++ b/include/linux/mmc/sdio_ids.h
@@ -116,6 +116,10 @@
 #define SDIO_VENDOR_ID_MICROCHIP_WILC		0x0296
 #define SDIO_DEVICE_ID_MICROCHIP_WILC1000	0x5347
 
+#define SDIO_VENDOR_ID_MORSEMICRO		0x325B
+#define SDIO_VENDOR_ID_MORSEMICRO_MM81XB1	0x0709
+#define SDIO_VENDOR_ID_MORSEMICRO_MM81XB2	0x0809
+
 #define SDIO_VENDOR_ID_REALTEK			0x024c
 #define SDIO_DEVICE_ID_REALTEK_RTW8723BS	0xb723
 #define SDIO_DEVICE_ID_REALTEK_RTW8821BS	0xb821
-- 
2.43.0


