Return-Path: <linux-wireless+bounces-24996-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C731AFD81B
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Jul 2025 22:18:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF87A7AD3BA
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Jul 2025 20:16:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77829241CAF;
	Tue,  8 Jul 2025 20:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OGklrWOc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E987423D2BB;
	Tue,  8 Jul 2025 20:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752005872; cv=none; b=GjaCQBIlEXRe97RH9bx/ND/FCbZFeai9iIdT3oHw2Ly3yU1CA+PxjPIXDbE84CmIRp8BMZtcDFY46Idm3JSL35tNLJgH1WMLNOpU1vT7OGbQo/UXh+HUrHj0Iwomitgymg4AWuWLHySL5Hwua5900zIMNcXE9Fcd2LBenKi20Wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752005872; c=relaxed/simple;
	bh=X3APSiAWL3Go+tUkn+KBsEhWZUZF0XELnyOttvravBg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M+K/qNZp6CXu6TkXuW6eqlR4s09L+3djsd6VF80oGkcCOQ82NF7nUeZzxszVZL4uMzdt1c+SOWX8tKphkVjQ0/ovzzUkP1J+pNtT7UD8uMGZo9akmhL7acNKW466pUC1SPYvOwmivR/FgVwzZh3fMXontfkdkS8PDnYf+4/Qeyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OGklrWOc; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b271f3ae786so3944389a12.3;
        Tue, 08 Jul 2025 13:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752005870; x=1752610670; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FKAwUXOLwMRO+DlBAOVwR1oRm93Guv88/PxNLjpkT9I=;
        b=OGklrWOcsjZWaFcyp6I9kuY/oOPTcbfUyHhrZD+2voFtWCICBRzhIC5oZktaaX+6Ac
         mtHQEMmkiL02ftHTXegQwpygVWC+pJkOJMPDCa9DHaSlLRZbkfd4sRYttUAz72y3KTAd
         1HB7xwZxIhTdW4l76prqWJ1MdbSxedm2MQGkRCA7HQkD16mBxxs5ClYtecHN4awy7OSD
         G06U37T6jIeeyYhBhP2EB9QxlVQiGrUAzXRzZSM86j+50TQsvL8pm3bWmuRwbX7iAnxy
         KF888VmD2WrLWiPvR8SIKlnLryXKb66hKRordYPSrrR25iXZ3z+sDTsA/Lz4C7soMRk5
         al+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752005870; x=1752610670;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FKAwUXOLwMRO+DlBAOVwR1oRm93Guv88/PxNLjpkT9I=;
        b=a0wLDtoDBwRWQz1iI1SpGOgJONaYW0JyjFUgDQ72XTaUSuRz3094Ukolsjtp652P0v
         e/e/h6l3murvOt3bNTEYqQxPsxfHc8JeX49ntXR2edpiMy6E0v6NmDhf/EXZuBcORSgE
         xknfdCHh+6uBJnR/gAoz+X5VKriDBNLa3cuE2oOJiLvI9QyKFInL0HNdEOxdEG/8SQLD
         5u8rTucTW8i8qZoHeSV7VkIDkTtf5QDk9Hc2QixBO32+bH3LyDDdFvOuAUvm6RrbDvBB
         TNUsjm6cFfRw++diq+/9A4jXHdlD2CV90EjbVGbLq9hkncudlmzdGjiYvRWOBZrKRCkd
         j/dA==
X-Forwarded-Encrypted: i=1; AJvYcCUuO7k+Rg7Q8x9sdocADwdw8zXD5YaPhbgdM0FjlvROBct3tPTYldeeJAvYVMrzSJgn1vEu0n8yG4eK@vger.kernel.org, AJvYcCXMgS8GtmlUV9557d45kAGKZCswx8Q95hbiSe6uOBCZRSy7W7R1NdKmJvR/Akh2TAXVSlhKenfPhP9M/Q==@vger.kernel.org, AJvYcCXsuMpmJtUWkkl+OztRTUQgfcaiETBBPkGInoqLqVLW7ra6MR27ZDKpO1KpubFdPmns99gyFe8oYOM6vH/t@vger.kernel.org
X-Gm-Message-State: AOJu0YyG0fFE1lHx2arxVk5+AehuV4BAgW8fZDPBb+kGQ0RM1YrF1OMc
	dL6C1robkVHeXPzn8rYICiAmoqXBhD+9NRppZS8+N1aBkRwyq51Lg2TlhYr1ZD0w0zE=
X-Gm-Gg: ASbGnctpXDTHxCVwvMBDukcTt2ORsTAoOfcDEMXkTCgR9ydeUp7uPAXB74LfjDBvO2P
	sY30HoFfj8JtBKb+SRc7lhelpcsnLzEXyQkgh8AOqoAtrqQGfmLIM2/9YGYoAyRt71PFd4jsKxl
	OZ00LXrMx4hf9KH15f7kLHoiovYZFdie6G2WmUXVOkEvLEVkeKDIb8DxLeQSxMY+YiVXBLr+f82
	4uGDc1W0jhFsf/+6qXOZWfzuIUlO85ot6gDqKtq3ahbMTMYm8IOaUWXeIPWOcAUFA036aQJ87LV
	6cdQClrRjTP7PZdu7PIVF4XQnj3ysM701KvMFL1SEA4=
X-Google-Smtp-Source: AGHT+IGhYZvUIjBIxwlODZkl6zsUOB58jiXQGVodXCDwRucgR+wkS29RzQC5R5fPb2KJH/9J6nMNUQ==
X-Received: by 2002:a05:6a21:998b:b0:21f:becf:5f4d with SMTP id adf61e73a8af0-22b4504428dmr6840682637.20.1752005870125;
        Tue, 08 Jul 2025 13:17:50 -0700 (PDT)
Received: from archlinux.lan ([2601:644:8200:dab8::1f6])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b38ee5f5d8csm12289625a12.39.2025.07.08.13.17.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 13:17:49 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes@sipsolutions.net>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Stanislaw Gruszka <stf_xl@wp.pl>,
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list),
	linux-mips@vger.kernel.org (open list:MIPS),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/Mediatek SoC support),
	linux-mediatek@lists.infradead.org (moderated list:ARM/Mediatek SoC support)
Subject: [PATCHv2 wireless-next 2/7] wifi: rt2x00: remove mod_name from platform_driver
Date: Tue,  8 Jul 2025 13:17:40 -0700
Message-ID: <20250708201745.5900-3-rosenp@gmail.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250708201745.5900-1-rosenp@gmail.com>
References: <20250708201745.5900-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mod_name is a legacy debugging feature with no real modern use. An
analysis of the underlying MIPS setup code reveals it to also be unused.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
Reviewed-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
---
 drivers/net/wireless/ralink/rt2x00/rt2800soc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/wireless/ralink/rt2x00/rt2800soc.c b/drivers/net/wireless/ralink/rt2x00/rt2800soc.c
index 701ba54bf3e5..e73394cf6ea6 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2800soc.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2800soc.c
@@ -246,7 +246,6 @@ static int rt2800soc_probe(struct platform_device *pdev)
 static struct platform_driver rt2800soc_driver = {
 	.driver		= {
 		.name		= "rt2800_wmac",
-		.mod_name	= KBUILD_MODNAME,
 	},
 	.probe		= rt2800soc_probe,
 	.remove		= rt2x00soc_remove,
-- 
2.50.0


