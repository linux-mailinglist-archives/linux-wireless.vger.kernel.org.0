Return-Path: <linux-wireless+bounces-32274-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wKEXHRIcoWlhqQQAu9opvQ
	(envelope-from <linux-wireless+bounces-32274-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Feb 2026 05:22:42 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 36F471B2A3A
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Feb 2026 05:22:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 79A6F30A9A3F
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Feb 2026 04:17:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1127349AE6;
	Fri, 27 Feb 2026 04:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b="PIMbv2LH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC0B361DA0
	for <linux-wireless@vger.kernel.org>; Fri, 27 Feb 2026 04:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772165727; cv=none; b=J/m0sydD2sJs4Xv1SBwE5GNPO9OWI/OGG2NdCeoo+n9fODkJq7kXeIOk0unUBlAUvpVtQh1NKcrjfDLJwRbiNQd8h87rIhNUbjGQojehW9A5Ofx3bAY13OxPtxOi1TSGKc2INbsaw9FdDGNaGjsjtmQvDGB1D0ueOlC9fIlfDXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772165727; c=relaxed/simple;
	bh=v8qU8tJtC5jnejQW4R5mwXAgBhbt5nQTG8shF1p+FvY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yzc4f6Bm3XfPHzsa4BbtRjM5bIpSIyYC4O3jIL6PNEhoH9Xi6+n13FcdNYYuKcbsM2uJHt+jdAHmMR2TOb9u1C/axFEZKaheFW7POmfpIHoMB1V+T3Vuxr9vFTduu5uzQbJZ7wNWJAv09q8V1gkfGWCJ2fyOW+q8pxmzFD8QX/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com; spf=pass smtp.mailfrom=morsemicro.com; dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b=PIMbv2LH; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=morsemicro.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2a8fba3f769so7782755ad.2
        for <linux-wireless@vger.kernel.org>; Thu, 26 Feb 2026 20:15:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20230601.gappssmtp.com; s=20230601; t=1772165726; x=1772770526; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vmyhDsxO6j2MpvDVoM4PYoG3tyyGfsb58QulbL6d2sU=;
        b=PIMbv2LHph50jmbsjZinEoq3XfxVBBNe5fe9SW6pfcvdSL0b3UJ5BvY8ZojoUL0mso
         7B36bU2sCWmEOFlhQQ8j+8mM3NypVZtXQ0Phbd1tGng3rMwuAh+1TYUfR4r/MNKhuYvW
         op0GljN01Z+V+5N2sCRfk3Xe7bne7rwbvfX4J5dGCxMQuKHckJd8GR3eqj3rxNx5j0Nq
         4qoShXRB/F0/1K7hdb33nrNeETChSr2CKZEXABKMZIyBg4EUax21vdRUaxWMm8tq5rQP
         Q23o8xKyBkm3I5ujNBovMq2FBcQ74WERmj//2B6LtPp/vEo8Cjf058GAFvim7cUgh3CV
         7psA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772165726; x=1772770526;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vmyhDsxO6j2MpvDVoM4PYoG3tyyGfsb58QulbL6d2sU=;
        b=coA/vu6hdai8KiR1u2NkXB9JTtD+XTrkbzfyRmgqnc3U8nnW9PDj1EzQgVTNTVri8A
         pY1oYBxSJA/azpHz843gM/ljvBZWzcZzoHnckv46OgIGEuIFYbL3YITcj+8SG29cOQod
         PSCltjDdu76QcO1UPUI1+77H3TbjBiO4AnWrO2+PujIrF+xpd9m2RtFlxJ/1YqFkdP7c
         YrOPX0ZUATCVu5A6zsBbdRkQm8n4P9ADWRJKKKv1MBE64ESIw0gRjN5J26vW3fXhhCtP
         wBNHO92EL/7jxQhcpIdJm/d6RbPq2/6pRoBeqCwLko6h9X/CoYwXNvS0YR4vr4QrU0p6
         HMVg==
X-Forwarded-Encrypted: i=1; AJvYcCUbPqucpuL/f4XdpR+aj703u0HijfQDdLxntaqn4Hln9OxbCWpp4mFi+nL73pG79Wy9asCQLmXSFCpsC0V3Lg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwRcKmGI4GF9GF/un5+JiO1y2FXfTyPafI1wET/su9DBszAQ1z8
	Pv/DK5W6dYySF96B9gSbNulX4xOJdWUZjKrJjoXO1R2z1Lo2sPxhW6EiOYC5EnmgUjQ=
X-Gm-Gg: ATEYQzxXMhwGMXkHz8Q/TQhRaPMI/xEBpKPbGWmnbzQi8mG0VBseNQ4RNbODevxsKUT
	ib0knevLxTLfz/WxlyUwN3JKv92ZmcGvLs+C1Eo0vQ5CUMugeOdGRWS2A24xvLx1GS8PAKUiLlG
	sta1W6wQ7oXYj9e+U1WvkUhCDMNzQRQHMKhWnpdB5pqi9Xx826gZahwy0YvzY0U8DQ4g6oDcuJB
	XLvv5TRSZDlZgA4itNpdKxPJ2+R8FYPz1ssnaVDQuCC2IfsPF1qC1B3r6cmXadGTbaSGxmtFata
	xslh522WYyjU3sFYpP9qnLcTbuWUMPmXdtLLi3/FrE6e0eT2gAEYhKF3PRAKHdQaTs9/2I7lgmp
	SBWiI+kdb8h9d1HzBeDtn6n8teAEhhu0jZF837mg/UyhsljPAABkAKgKCJ1R/28W1iF5HZkWTfM
	gMgSs34lrW0hUIkAbWcRbPWCuh1U8uINwTHe0s+iEXuCsHLTARtDm49hiHTfq27rtKfGEAtGHk8
	aJI/T9dtjgVAMdWaqiIqrLyu4ZoUKs=
X-Received: by 2002:a17:903:1a67:b0:2ab:2733:bc25 with SMTP id d9443c01a7336-2ae2e3f10d4mr12491625ad.14.1772165726171;
        Thu, 26 Feb 2026 20:15:26 -0800 (PST)
Received: from mma-H9MHD44.lan (60-242-93-14.static.tpgi.com.au. [60.242.93.14])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb6ba5eesm41682865ad.68.2026.02.26.20.15.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 20:15:25 -0800 (PST)
From: Lachlan Hodges <lachlan.hodges@morsemicro.com>
To: johannes@sipsolutions.net
Cc: arien.judge@morsemicro.com,
	dan.callaghan@morsemicro.com,
	ayman.grais@morsemicro.com,
	linux-wireless@vger.kernel.org,
	Lachlan Hodges <lachlan.hodges@morsemicro.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH wireless-next 35/35] wifi: mm81x: add MAINTAINERS entry
Date: Fri, 27 Feb 2026 15:10:45 +1100
Message-ID: <20260227041108.66508-36-lachlan.hodges@morsemicro.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[morsemicro-com.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[morsemicro.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[morsemicro-com.20230601.gappssmtp.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32274-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lachlan.hodges@morsemicro.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,morsemicro.com:mid,morsemicro.com:email,morsemicro-com.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 36F471B2A3A
X-Rspamd-Action: no action

Add an entry for mm81x to the MAINTAINERS file.

Signed-off-by: Lachlan Hodges <lachlan.hodges@morsemicro.com>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index b8d8a5c41597..14d890d7f859 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17850,6 +17850,15 @@ F:	drivers/regulator/mpq7920.c
 F:	drivers/regulator/mpq7920.h
 F:	include/linux/mfd/mp2629.h
 
+MORSE MICRO MM81X WIRELESS DRIVER
+M:	Lachlan Hodges <lachlan.hodges@morsemicro.com>
+M:	Dan Callaghan <dan.callaghan@morsemicro.com>
+R:	Arien Judge <arien.judge@morsemicro.com>
+L:	linux-wireless@vger.kernel.org
+S:	Supported
+F:	Documentation/devicetree/bindings/net/wireless/morsemicro,mm81x.yaml
+F:	drivers/net/wireless/morsemicro/mm81x/
+
 MOST(R) TECHNOLOGY DRIVER
 M:	Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
 M:	Christian Gromm <christian.gromm@microchip.com>
-- 
2.43.0


