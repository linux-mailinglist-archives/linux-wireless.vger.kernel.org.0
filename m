Return-Path: <linux-wireless+bounces-34987-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4KW/CoHd5GkibQEAu9opvQ
	(envelope-from <linux-wireless+bounces-34987-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 19 Apr 2026 15:49:53 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 70C9F4243E0
	for <lists+linux-wireless@lfdr.de>; Sun, 19 Apr 2026 15:49:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 08050300B042
	for <lists+linux-wireless@lfdr.de>; Sun, 19 Apr 2026 13:49:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 698AC244661;
	Sun, 19 Apr 2026 13:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X3XHCkX+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E148940DFD7
	for <linux-wireless@vger.kernel.org>; Sun, 19 Apr 2026 13:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776606590; cv=none; b=hIa9yebOVDXGGNmO/5wpVV9GbwB61LA2JmsU4ULRxvJ1nlt0C6Y7AWEZ2imGV/IebXv/Zqppz9WEsaF51I3tpnDQO9hBETJjLQ/QZMc43gRlczc+GfojmIxde2kds2Sl5HAyvTxLqYAvQZZpoUJwYVkmDC5jpvwgccFk4Ml50SE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776606590; c=relaxed/simple;
	bh=3xrHuxqN9REXb5haouNaRx/T2NLPmNTNI7WYsFmhvmM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=iN3BIV0zIAcVTL46lStZCie+TW0PED9oK6ZvRYghvJpFYWVTxsjGLXeY0Q3HtOuOFCoHVRdPJaSZm9h9tRWyAy9VkWLjwlmiXpHncXaO4F8IQ6OQ+UD9NzmM5Eidbm86AUJzXRVHP2sDTVENl2PHbKlfxi4PvnDX9xAlCvoX+H4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X3XHCkX+; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-43d77f6092eso1433576f8f.2
        for <linux-wireless@vger.kernel.org>; Sun, 19 Apr 2026 06:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776606587; x=1777211387; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tpF0mu0rEUBHfDhBHKO1NiMmOFE5thpUtcOVoLHGoq0=;
        b=X3XHCkX+zvrkgX2VQcmOIK7xLF5W6XJS4WdLMvwUWj/9QskZoy5fMHD1Yj3Ox4dOM7
         9b/K3Nb0hlJiqJb+twGdtgF3d6h+07c7ejt3rCLxKYOAUGGip4baup2OkeiHJ5fhlKdZ
         IH/0ncoI6nDN/ugBYLr766EIh7PJD6EGGbZZ9hH11au0Hi7LVGb2NHebrqCf1dyMuxiQ
         HaVYnm/qTU2ENLGs9t9ZlmsF7VgzTPeibZM7RPFWvNOzsJkf+Ne06LamIZq1UO5PSEBd
         NXQfBxjemx+Zoys+xO7b/DotemwCOzjV+Ub/bgYOn/O/L9AiThtu/df8q9qWD2GznFeq
         pqgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776606587; x=1777211387;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tpF0mu0rEUBHfDhBHKO1NiMmOFE5thpUtcOVoLHGoq0=;
        b=mjZBnee8MuSOW6fHKeR5KvGl8K1432iq1gPbhTajJCt9kIWKhQwV8qX/laCUpBS47w
         TBC8lNzYe93kS747PXZEBpNguyUvYtM9I18w4yVegSYuwZDyvQS/KYgSHNckItmlWl2d
         utgiS71vXOQoAsD6p0MlPmHF+FyPFEzjsNxbeASG/wIRfue47CvB/Z1tq7zwfMiCtZIt
         nesEwO/9Qps+TcuBswA9HnmER7O7MHcCWmqdKG95gUNsO/+PWtg/2hL9xHXMrnBUsrtn
         xoAM0Llf0eFb2FKOJ4kyuoOGny8N9L1/jhM/Ej3G2wlZxTz9nMj6fNxaE3ZUTpvwHh+y
         164w==
X-Gm-Message-State: AOJu0YycTzJ9ue6dxSu8FLWPMa6v3or7meQaoSVmfDlcrYEJjCaYo+0u
	qKveLfGGlvD32jwq+b3UgG9er7YY02ypWN8wyNF1J6ios3W3+EDChTZWHQ9k9g==
X-Gm-Gg: AeBDiest2jUibG8+FGQzVn7LLnw1TPIsgn9L/Vxcwvpd/OBWX18+/Jcr+LfwIGzfme5
	GEqPJrHoVrR2+iofZBQO2p4l8b8Ie3LeOIPhLzl1i4sg9SGENKXtNWzHhllPQpVAoMmfcq8tk+q
	VMTQrqSvhXvYNGDHr18tXqvNeEZ8OWvv2kNp6a0XBZX4Dfts24DbaVEtJ0GD6PfwBBdiYt+XLSh
	Y3bIK/leonDaIWcvx3A74p3pMFdl7sB9aClPuwNYQw+aed5XAFgFexyVIqys1UNor6hnn5N2Lv7
	VhXnpUxARG76HEBPHT1APzkhrFI6hx3Y7nC7FP5KvN6P/tOaYCkO01QyNVNrT1m8hakb3F++Lc5
	X37N8TO2EVS07HAgN6exV7Ijp/8UuBeL2BIxe5EzSEWl9fbtgYeRuIufHvGKsZbe/8cg54/y8Vf
	/uT/496uZ8l3aDmtq88gvm/wi3S/Nnv8esGubsjmsP
X-Received: by 2002:a05:600c:4e16:b0:488:d6eb:e63a with SMTP id 5b1f17b1804b1-488fb76fe73mr138924815e9.14.1776606587197;
        Sun, 19 Apr 2026 06:49:47 -0700 (PDT)
Received: from [192.168.1.50] ([81.196.40.93])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fc0f8188sm224660355e9.2.2026.04.19.06.49.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Apr 2026 06:49:46 -0700 (PDT)
Message-ID: <c0bd60ba-4e2d-41cb-8b0c-38454a341d7a@gmail.com>
Date: Sun, 19 Apr 2026 16:49:45 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH rtw-next v2 11/11] wifi: rtw89: Enable the new rtw89_8922au
 module
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <6ba2910d-020c-41bd-86fa-d1b0e0f7a2f5@gmail.com>
Content-Language: en-US
In-Reply-To: <6ba2910d-020c-41bd-86fa-d1b0e0f7a2f5@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-34987-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWO(0.00)[2];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rtl8821cerfe2@gmail.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,realtek.com:email]
X-Rspamd-Queue-Id: 70C9F4243E0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Tested without MLO, mostly in station mode and a little in AP mode.

It can reach 1.5 Gbps RX, 1 Gbps TX speed.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Acked-by: Ping-Ke Shih <pkshih@realtek.com>
---
v2:
 - Add Acked-by.
 - Add TX and RX speeds to the commit message.
---
 drivers/net/wireless/realtek/rtw89/Kconfig  | 12 ++++++++++++
 drivers/net/wireless/realtek/rtw89/Makefile |  3 +++
 2 files changed, 15 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/Kconfig b/drivers/net/wireless/realtek/rtw89/Kconfig
index 44d8a7f32bf2..43e3b0ef44da 100644
--- a/drivers/net/wireless/realtek/rtw89/Kconfig
+++ b/drivers/net/wireless/realtek/rtw89/Kconfig
@@ -157,6 +157,18 @@ config RTW89_8922AE
 
 	  The variant 8922AE-VS has the same features except 1024-QAM.
 
+config RTW89_8922AU
+	tristate "Realtek 8922AU USB wireless network (Wi-Fi 7) adapter"
+	depends on USB
+	select RTW89_CORE
+	select RTW89_USB
+	select RTW89_8922A
+	help
+	  Select this option will enable support for 8922AU chipset
+
+	  802.11be USB wireless network (Wi-Fi 7) adapter
+	  supporting 2x2 2GHz/5GHz/6GHz 4096-QAM 160MHz channels.
+
 config RTW89_DEBUG
 	bool
 
diff --git a/drivers/net/wireless/realtek/rtw89/Makefile b/drivers/net/wireless/realtek/rtw89/Makefile
index 1be81f254fca..475bad743d75 100644
--- a/drivers/net/wireless/realtek/rtw89/Makefile
+++ b/drivers/net/wireless/realtek/rtw89/Makefile
@@ -88,6 +88,9 @@ rtw89_8922a-objs := rtw8922a.o \
 obj-$(CONFIG_RTW89_8922AE) += rtw89_8922ae.o
 rtw89_8922ae-objs := rtw8922ae.o
 
+obj-$(CONFIG_RTW89_8922AU) += rtw89_8922au.o
+rtw89_8922au-objs := rtw8922au.o
+
 rtw89_core-$(CONFIG_RTW89_DEBUG) += debug.o
 
 obj-$(CONFIG_RTW89_PCI) += rtw89_pci.o
-- 
2.53.0


