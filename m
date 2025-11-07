Return-Path: <linux-wireless+bounces-28686-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 09199C40C96
	for <lists+linux-wireless@lfdr.de>; Fri, 07 Nov 2025 17:11:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 76AD54E6979
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Nov 2025 16:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A3652C08BA;
	Fri,  7 Nov 2025 16:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jrq48s87"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F0325B69F
	for <linux-wireless@vger.kernel.org>; Fri,  7 Nov 2025 16:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762531824; cv=none; b=E3XalYDCVCGUsi5dPQve0O4zMIIyAPNMNVEj/bvGVBWYZCRIAmsR6GQYaGtNUdDTffrNsA9XmAXO+juIB+yZwjHDdAbOLboLDzptGWyjVVhhNUWCCeu/Cs5QSGjgAHZ0/4NgNR0FiwrnPmYhbMDxvSUwAuOU4aYvkVTtWrv3rj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762531824; c=relaxed/simple;
	bh=cqqy+i7Nd1GjC/Rib+V/p6r63No1+Xuyq9/ciqMehMU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=i7GZZTIPaL8nMj6uOAPaVKjy8uF0ngy3W0g347LJwvfSvLAL2DQyoYeHs18pX1DCz6u/kkXyc52BqbAeBzc2RNL73uJfF9c3CiHEwrQZckFE5JrnBo5j/Bm56W0JvXuvx7ohB0RaJjdnpQL2XSDtKh7fcyHRq3vIhwUdwN5u5t0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jrq48s87; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3ece1102998so553685f8f.2
        for <linux-wireless@vger.kernel.org>; Fri, 07 Nov 2025 08:10:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762531821; x=1763136621; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VZmNaqCZTCTUiSURP33muypQ7gUINdFSPnA6TayX0Sw=;
        b=jrq48s87VU8l57PgsCb1uLM5yv/C4GRxiMOg67GH1gibWWn8F57pjK2jDWADa0PBtX
         930ianMo1bCOm/B5xt9dq7/VGe81uACVpGo+yQtetoS4XSjj9P1+9XoWdMwGvapy31A4
         qE78Asep/HN5NkvxJdtP4+iLewNK84cb8C2x8DZ4/aSG1Of2NxSzG3O6S2vjxBwNCs6L
         huZl+a9JZzGPCuHVMYVitVDbQTY86IhLPYDhehpbnuAGg0bLJTuT0YNuZ5oDa98R326s
         xuT5M0j7jm+WXRkEtAxA48hheaIk7xPiZ37e2dpB4q2LcURRSKjpZdy8iNIO5yTVYImw
         2NEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762531821; x=1763136621;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VZmNaqCZTCTUiSURP33muypQ7gUINdFSPnA6TayX0Sw=;
        b=OI5tpgyyPy7200ys2GohkR1W5BgooswGXCtYrXlrI9p4gqRMze2BmCab8pocBOG9ro
         GBOgq7auFHcBFIXV27alkZzf2lRb/UOsI7/zB+onNPUpee9SLSTU4VFSe9EzgXqeCyPP
         TsSNAy+UY5Sfc8Y/E2KHWzS7L1Y6Ar6dWwdlkfLlpPvWoKQQDp4UpZoJF9qgYDa4NLZ7
         iDtA6TyhV9BrEphFiQ31ciPsZS4Il0Jkm8UfwJwj8h1vwuF08rB4Jb0dneNSieBMUHTj
         qYPYpTOp5QC8QHFTmpKKphAU2OPG0FPxfptirT9nI5QPtpN63QzPbys7asieFUYTRLHO
         yd4w==
X-Gm-Message-State: AOJu0YzEpX8WzJ9f/rJcjkO5bKUdYIFSoFoo26w0qDTkopJabLqWDhHs
	CrTpB/THO0qpic78zGHmJ3mQjPTp4PHhsPwkgB/LR9xyZ2ceAHXOokIZDrCDNQ==
X-Gm-Gg: ASbGncteV41n+p+VHlmGXuRr77I1zMplnVfJHF3sD8DhAxyrIPOIziwMoCFSSS/ITgR
	/ASahBT1ANYZL3ZD4oyIRMhEaxQti4v2AJNH/j5uv6EZ6Z9gb7AnC+mOEw8MmeGBvhf6s7qJYlk
	/9vhykcsiL8BWtkPphoiFz0jd5IHDwBNIrCAPFDZWcu9f1ZvL21B46+cTgdY6rwkmfVBHMxQ4NG
	ntMIcCxkWybSu0jv9NyHMok4OBx6E3BceEL1PRTvDYqtXug3XG4TEv3N+LGoopnpx043xglJmkP
	bEiOJ53jzng/iMh1R6Antfh1Qjuhyxho2Y+rI4YzTP9jSzFuc8w6Tel9gzbeCtkT6c1k5tbGu7e
	l2jpIABKnTPKUDiJlfX3Zk78B6H8JsqcRlt4nfNqv9M0aXximXAJ6tzQfTHv9BiU2biGVRuziaR
	eTUmTh2RB/FLP5am1+XYM=
X-Google-Smtp-Source: AGHT+IFhUTaGmfyFMhriOf2jXaCfDff2edIHO9X9lmkZgvp9ybpUQp2Abz+K2VXvxvz755IigneDgg==
X-Received: by 2002:a5d:5d02:0:b0:428:3cd7:a340 with SMTP id ffacd0b85a97d-42ae5ac2306mr3339377f8f.35.1762531820816;
        Fri, 07 Nov 2025 08:10:20 -0800 (PST)
Received: from [192.168.1.50] ([79.119.240.87])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42abe63df69sm6241016f8f.13.2025.11.07.08.10.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Nov 2025 08:10:20 -0800 (PST)
Message-ID: <180a5e77-9297-4ffc-80d5-191dfef47661@gmail.com>
Date: Fri, 7 Nov 2025 18:10:19 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH rtw-next 6/6] wifi: rtw89: Enable the new rtw89_8852au module
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <f0021b8c-efc7-4993-b0a8-8954c682d13b@gmail.com>
Content-Language: en-US
In-Reply-To: <f0021b8c-efc7-4993-b0a8-8954c682d13b@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Tested in station mode and a little in AP mode.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
 drivers/net/wireless/realtek/rtw89/Kconfig  | 11 +++++++++++
 drivers/net/wireless/realtek/rtw89/Makefile |  3 +++
 2 files changed, 14 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/Kconfig b/drivers/net/wireless/realtek/rtw89/Kconfig
index e89f7481475a..44d8a7f32bf2 100644
--- a/drivers/net/wireless/realtek/rtw89/Kconfig
+++ b/drivers/net/wireless/realtek/rtw89/Kconfig
@@ -74,6 +74,17 @@ config RTW89_8852AE
 
 	  802.11ax PCIe wireless network (Wi-Fi 6) adapter
 
+config RTW89_8852AU
+	tristate "Realtek 8852AU USB wireless network (Wi-Fi 6) adapter"
+	depends on USB
+	select RTW89_CORE
+	select RTW89_USB
+	select RTW89_8852A
+	help
+	  Select this option will enable support for 8852AU chipset
+
+	  802.11ax USB wireless network (Wi-Fi 6) adapter
+
 config RTW89_8852BE
 	tristate "Realtek 8852BE PCI wireless network (Wi-Fi 6) adapter"
 	depends on PCI
diff --git a/drivers/net/wireless/realtek/rtw89/Makefile b/drivers/net/wireless/realtek/rtw89/Makefile
index e0d21972e57c..1be81f254fca 100644
--- a/drivers/net/wireless/realtek/rtw89/Makefile
+++ b/drivers/net/wireless/realtek/rtw89/Makefile
@@ -43,6 +43,9 @@ rtw89_8852a-objs := rtw8852a.o \
 obj-$(CONFIG_RTW89_8852AE) += rtw89_8852ae.o
 rtw89_8852ae-objs := rtw8852ae.o
 
+obj-$(CONFIG_RTW89_8852AU) += rtw89_8852au.o
+rtw89_8852au-objs := rtw8852au.o
+
 obj-$(CONFIG_RTW89_8852B_COMMON) += rtw89_8852b_common.o
 rtw89_8852b_common-objs := rtw8852b_common.o
 
-- 
2.51.1


