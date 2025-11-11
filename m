Return-Path: <linux-wireless+bounces-28842-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 52712C4E379
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Nov 2025 14:44:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AD8E54E7278
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Nov 2025 13:44:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 564E134250C;
	Tue, 11 Nov 2025 13:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dWqsE+ti"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D98331217
	for <linux-wireless@vger.kernel.org>; Tue, 11 Nov 2025 13:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762868648; cv=none; b=n6hstZl0dnk5NGWs1r3EOek6U1cFdvIpkv2ymh2sS4/mBN3B0/Vszw7wqlJOODc+kYOodNQ1ZL/qTiNdFC+SBRLRKUI/pmvRRqi/dNjC5u0g6rohLTviD5L/7CIdidhs8JSYY418EVFuoAjbiih1ISSCVOgbjqX+KrujwcQoXmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762868648; c=relaxed/simple;
	bh=Y45pu3szvM1LM61DHm/QMHbYr9VNOYlQ5x6hLEidAYc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=r1C2x/Tu7Pua7Jjr+AVUhHmHNRwvAgJ1A6J3nyw70E7hinNXC1452evEy3AOnDQ6GUG6POvTTBvyy1k3g849gG32gtDDeqAqcka9OfRzgviidOlERrjtp9IQX+MPZm/ZJGdW3Y38ViU/SIYoj79BAcJxLbkzA8dND8DERlLCUVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dWqsE+ti; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3414de5b27eso3471688a91.0
        for <linux-wireless@vger.kernel.org>; Tue, 11 Nov 2025 05:44:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762868646; x=1763473446; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cfBwH3pvPFzi+4ug5es45AykFcVvN2fmPoAZ0zn4NHc=;
        b=dWqsE+tiKqm5o096GqoxvBOTa6oLsL94tiG/6UizkeKH9fFbLkYWacsxZ7lo8s+UJ7
         wRen5JZOhJuPJ/dGni1EC2V64H0w5MAoxk4P4uBlUgiOqOpGZNrIk9AoK8WYKLJtnCpD
         nhHMoMGnsz3BHL7sGW3dCXWK0B3RIq4HbeGGv+3vrdcy+dYdoEcjrT0sNsL1BhNbmRnc
         TYpUu4KifM61wX1bboPRee5/y4jXzddMNnXFcdqV/aptPHvLrB5lK+S31FuseGXz8guk
         n9cUKbYA2V4tzr5NDk0kh7OnPyZ0I0Or4b1MxcxFpzQ/xW+4YO/C7U9F65PXjhOuDTy9
         wvlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762868646; x=1763473446;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cfBwH3pvPFzi+4ug5es45AykFcVvN2fmPoAZ0zn4NHc=;
        b=TdkAYp2TETayY5lhbrAG1HbsWU/l9vCjgnyDSm1gwN/vVVxiHYweixLbgoIB0B6omD
         IsA1v9qi5b7Do+GGV1VYKJXwiBlMSDmk2LJQWUr5VAo3jQODeDooxwddsPFOG3jo4n9D
         sK3wFCfF+Z92zkHBFPm7IK5hHqDP1x0MLX9kch3T7NZyYWK9wjy4hscXks0QrkZ6nG8v
         ehsqdtFpsxNHCsatdTlcMLN3/i3DcpWHDFnuupL0WfKA24tOorUn9KUmOK4wjRAMdw8Q
         RcIBEH4sgge9q0zHFbwkHHMuL8dSQnZUYMHkVjXG6FTcmMCwUU8Hx8lARoB0glJGLmdu
         MkCQ==
X-Forwarded-Encrypted: i=1; AJvYcCUja/vxFDaDegy7Gn/bMEPR9NQeHL+vPzzzuJM8azs4aq130rWqp10yBhiM8aIh7qtltm8/tlIYhKZBEqL+bQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwVKnR8pzOaXyTSFPwkc3bQoYxnVBQ4LMXCg0dQvkVBSoTXXqmr
	W8pi+zHCz/qA3Gi1Fr+LmQjOB62GWNtG4rZ8ir1CcWcpNlDTsjhoYZsh
X-Gm-Gg: ASbGncsyUj3H5wlr4UT4M0iVJsMxJXDQv+zhPQsp46I98mB8wUAOofNYknYUqnWtmaG
	QsHjFU7MkPq3Hp7TmTr7y+KHbEs2MTTGeaG+/UQfCk4e4PtuyCCsBBIUIdQ4c1LNRLbZTsUHIg2
	37COxNsm7ztwaAtOg9A0dg0qlTbK6AOO7RcBestJGdrCMdZbyzwZ/kP3fWGX/+NCnTY2BoA6QRM
	3RR0p/NUNDEZzUiCNZ3pHDzvM9pXUNJqNHxfd4XTa5PJKunlzOYY31SQ1IHEVpKymdxEjuFf35T
	IOlZfHe7xsJpTpHviN7W0SZBubfjdrVdz+Aur934oCTsYG2xPxLlobs6J45WHvwjPo7D114CUoq
	B0fKf1xMY3t45OAOpXhAZdUJEvex9UsZIfOIAt0lM5iH10xWSw52/8oGp0yOIRU7onuH1PHLSZ9
	0+brhypnyJmlDRX8ccY8U0iohjUyxYiYHxSkInW5eyZ6KT+fh+
X-Google-Smtp-Source: AGHT+IG5CX9IF+l5v2AZ8QaoKkuwIwFpaZ4ilXq5bNALaqBbutW7Q6S6AYvpVVhd99d5MyMbMhdjcw==
X-Received: by 2002:a17:90b:2fcd:b0:340:c4dc:4b8b with SMTP id 98e67ed59e1d1-3436cb284a8mr14778918a91.10.1762868646199;
        Tue, 11 Nov 2025 05:44:06 -0800 (PST)
Received: from localhost.localdomain (36-231-142-150.dynamic-ip.hinet.net. [36.231.142.150])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-343614818f5sm12684855a91.15.2025.11.11.05.44.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 05:44:05 -0800 (PST)
From: Nick Huang <sef1548@gmail.com>
To: nbd@nbd.name,
	lorenzo@kernel.org,
	ryder.lee@mediatek.com
Cc: shayne.chen@mediatek.com,
	sean.wang@mediatek.com,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	Nick Huang <sef1548@gmail.com>
Subject: [PATCH] mt76: connac: remove unused reserved field in gtk rekey TLV struct
Date: Tue, 11 Nov 2025 21:44:00 +0800
Message-ID: <20251111134400.5258-1-sef1548@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The 'reserverd' field in struct mt76_connac_gtk_rekey_tlv was unused
and misspelled. Removing it cleans up the structure definition and
improves code readability.

Signed-off-by: Nick Huang <sef1548@gmail.com>
---
 drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
index 27daf4195..28cf46a5f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
@@ -1681,7 +1681,6 @@ struct mt76_connac_gtk_rekey_tlv {
 	__le32 group_cipher;
 	__le32 key_mgmt; /* NONE-PSK-IEEE802.1X */
 	__le32 mgmt_group_cipher;
-	u8 reserverd[4];
 } __packed;
 
 #define MT76_CONNAC_WOW_MASK_MAX_LEN			16
-- 
2.48.1


