Return-Path: <linux-wireless+bounces-22416-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 917BAAA894E
	for <lists+linux-wireless@lfdr.de>; Sun,  4 May 2025 22:55:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 857AE188A4D7
	for <lists+linux-wireless@lfdr.de>; Sun,  4 May 2025 20:55:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65845187346;
	Sun,  4 May 2025 20:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jA14AT2f"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9432A23A6
	for <linux-wireless@vger.kernel.org>; Sun,  4 May 2025 20:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746392122; cv=none; b=FU4fxBDeRSTDmVkxHFNs4h0jwaH+UZUnIVWXxPPClLY15FyDk8D3VGw3aY90Vte0lQgM8j03Sr2ZySSYi4nO5tYvR4gaX7w2iMgVwc0c0UONM4I8oyS90Vhx8RrCNCNf70fa7t9FluLWN7BiSk4sdOMPmvOFEnDW29EFDwzyY54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746392122; c=relaxed/simple;
	bh=OOWK6zDcgSuLvUmP18w4a9/aflH66xB1iI+AJMSexes=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=pt8RwlgXvW/lUgdumOqnXFoovIhkTRxmju8Su5RAq7ItJgfBtD8dqmXp0UeBLzNVZMkXUlq+JnHe3YvJZ3pyneVsltT3ArFBNWEFPVxNzq8mQ6gIOapoeiXW+5Lg2GYf0/rgUd2VfR+zUgkSohXYT+i9PqNw+q4efU6ET3gamGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jA14AT2f; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5faaddb09feso2231369a12.2
        for <linux-wireless@vger.kernel.org>; Sun, 04 May 2025 13:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746392118; x=1746996918; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fIHXU4a01/GlkNrKvuOopA+lkPENn9zO0RnVH0szbsQ=;
        b=jA14AT2fN8yCBjWjdzAokH9tu4Ppgst9fx66iG8/ApZP2qV8VSpPQy7EGYvRvzqMdh
         A4dwz3Oh231SSrm8pId56mqygnfd3MWWxzEp8N7uR8q9NMibXNGFAkUtsFnQRSnSyn7D
         U1fPhZEZcljHfJw92wJDoeVnezlaMMgAiNVoN1VZoo27R4LDnkRa4O75zlyg9k+Wft+m
         BeZ8dn9JUj7S6VEAHu/gjhgVblnKFxxcIPfsOu6yhQ/HPEZgcBNJla1Qzj/mxmqzPfRc
         3szD2W0JLM+MEWAMeMSMKkhlK0VgdHL72N3TB7eITDtM9+DJFknlEXdmIFoLHxjLyvK2
         PD5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746392118; x=1746996918;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fIHXU4a01/GlkNrKvuOopA+lkPENn9zO0RnVH0szbsQ=;
        b=gueFe/zQc7EpSKnv1ESrZczHDPJ7KymdwNfuX8wlreVxc6+E+ur7l+jwdpMr2xM3RB
         QfWJnLgYO07pHHMDkWGBCd2wKBG+IiOPIgOtfw7KHF6k8a8JBwKJAJpaftLfDDqNx71v
         zPjc3Rzd9cP/uKWxWeiQNad71a4tPgwS/HZFvrjVKVXlpyG/oqrAOT1EfGkW0lJWeakc
         9EOUTf6kAOxLjaPemcNp2a3YCPiRBy/b70bXzYN72BLMl+08uzreLR/qSSfu+sBTVEAs
         4VfrvqYY71Ru0zJqHBjYXNvxGx09nGNd7gJm3DJ5nREzYLvcP993aEaFYZeTdN6roctB
         yWfA==
X-Gm-Message-State: AOJu0YztQwgWBs10RuDEllIqnxZWo07UHB+ACPwKwlt18ZHk0uWLXIlD
	QUyh9UjW+1+ldcrtbkZbB/F1aNeYbXUARYRgAE4nMNi1vf/XsxGk0BbsxA==
X-Gm-Gg: ASbGncuHmo0f9smkjuhKtZyTztIddrLaC8sVmcCMv2yKsM4liZqwG38KPTnz6IlKiUM
	2mUd/HscDAM6qXKTSr4aDv19M6GjdmbwWsdm9G7KJdxrnW4L1gehCfpoee9PPmN4RDn/2LhNf7K
	vO/c8VcEmtAbwcPsm7ZxWu0U0puIxQqRLW1J5JThwxdEbdBysfVTsjSc4w4M+NCSx5HwSoNJy/e
	k+DLHRkukdQ+yJm8aeDIYsY9j2ilgC2SMcLetZZEstUII6gyRglATXN/wsXYkbB/C1gAQOA//yD
	fSqEj9iSxzAOE5GrkiUsS9UO7MDcB7SQtVKBsv9uuDFwgJKCJA==
X-Google-Smtp-Source: AGHT+IH+eVphb+/Qb3NGGogmbXPPR5zLrZcIKzaICiEXGEfU4KrJ4dV9+BrGbVlJfYVbERSjy7UyoA==
X-Received: by 2002:a05:6402:4549:b0:5ec:cd52:27c9 with SMTP id 4fb4d7f45d1cf-5fab05e0767mr3509840a12.31.1746392117724;
        Sun, 04 May 2025 13:55:17 -0700 (PDT)
Received: from [192.168.0.50] ([79.119.240.158])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5fa77b914b4sm4232247a12.51.2025.05.04.13.55.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 May 2025 13:55:17 -0700 (PDT)
Message-ID: <42c89728-134d-41a8-bc7b-8d95940b202b@gmail.com>
Date: Sun, 4 May 2025 23:55:15 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH rtw-next v1 13/13] wifi: rtw89: Enable the new USB modules
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <b146b670-d91c-41a7-96f0-c37945040aea@gmail.com>
Content-Language: en-US
In-Reply-To: <b146b670-d91c-41a7-96f0-c37945040aea@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Enable compilation of the new rtw89_usb and rtw89_8851bu modules.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
 drivers/net/wireless/realtek/rtw89/Kconfig  | 14 ++++++++++++++
 drivers/net/wireless/realtek/rtw89/Makefile |  6 ++++++
 2 files changed, 20 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/Kconfig b/drivers/net/wireless/realtek/rtw89/Kconfig
index 205d7ecca7d7..bd180f3369c3 100644
--- a/drivers/net/wireless/realtek/rtw89/Kconfig
+++ b/drivers/net/wireless/realtek/rtw89/Kconfig
@@ -17,6 +17,9 @@ config RTW89_CORE
 config RTW89_PCI
 	tristate
 
+config RTW89_USB
+	tristate
+
 config RTW89_8851B
 	tristate
 
@@ -49,6 +52,17 @@ config RTW89_8851BE
 
 	  802.11ax PCIe wireless network (Wi-Fi 6) adapter
 
+config RTW89_8851BU
+	tristate "Realtek 8851BU USB wireless network (Wi-Fi 6) adapter"
+	depends on USB
+	select RTW89_CORE
+	select RTW89_USB
+	select RTW89_8851B
+	help
+	  Select this option will enable support for 8851BU chipset
+
+	  802.11ax USB wireless network (Wi-Fi 6) adapter
+
 config RTW89_8852AE
 	tristate "Realtek 8852AE PCI wireless network (Wi-Fi 6) adapter"
 	depends on PCI
diff --git a/drivers/net/wireless/realtek/rtw89/Makefile b/drivers/net/wireless/realtek/rtw89/Makefile
index c751013e811e..891e2d55c335 100644
--- a/drivers/net/wireless/realtek/rtw89/Makefile
+++ b/drivers/net/wireless/realtek/rtw89/Makefile
@@ -31,6 +31,9 @@ rtw89_8851b-objs := rtw8851b.o \
 obj-$(CONFIG_RTW89_8851BE) += rtw89_8851be.o
 rtw89_8851be-objs := rtw8851be.o
 
+obj-$(CONFIG_RTW89_8851BU) += rtw89_8851bu.o
+rtw89_8851bu-objs := rtw8851bu.o
+
 obj-$(CONFIG_RTW89_8852A) += rtw89_8852a.o
 rtw89_8852a-objs := rtw8852a.o \
 		    rtw8852a_table.o \
@@ -81,3 +84,6 @@ rtw89_core-$(CONFIG_RTW89_DEBUG) += debug.o
 obj-$(CONFIG_RTW89_PCI) += rtw89_pci.o
 rtw89_pci-y := pci.o pci_be.o
 
+obj-$(CONFIG_RTW89_USB) += rtw89_usb.o
+rtw89_usb-y := usb.o
+
-- 
2.49.0


