Return-Path: <linux-wireless+bounces-37840-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id WT8AJINdMWqOiAUAu9opvQ
	(envelope-from <linux-wireless+bounces-37840-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Jun 2026 16:28:19 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F31B96907CA
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Jun 2026 16:28:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="hmm1mA5/";
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37840-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37840-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6DE7F31A4BA3
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Jun 2026 14:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0047337B00E;
	Tue, 16 Jun 2026 14:17:00 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9670543C047
	for <linux-wireless@vger.kernel.org>; Tue, 16 Jun 2026 14:16:58 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781619419; cv=none; b=KWmSuUYE1iE/z83QEPiV2M/SIZ2gbbBWlJrhxlLRbP8rFk1fz4x71pPTVNsasvYkm/wP77DVPq1Ksfp1zdL96PzyNtHEPS7EO8jL0F+Qq1U7PXv1FXN5MSbidgSxz79321sREkB7vp9I2H6Gke9Tt+MoCL6MWjxcJ4yiGRDF9Gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781619419; c=relaxed/simple;
	bh=VPCRoNUG9aJ7F3yMhRHxwDzPzY+qMW0bGvnF8IJqyug=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fM3uFXaYUVoozj2SX1LDTeSelLyo2uzq8JyvgIPDT31gXIPwnaLQqNNyDTMrMQEhbaMs30ulJKeFIg+iuxJM4eWGI32iDcH63gCQKHh2MB5s/D9CozkGJMH9KyD8IXb0H5bNGuE/wXiUxbWIR51ys0F3qeyCh+RUE3tK5RJ81Gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hmm1mA5/; arc=none smtp.client-ip=209.85.218.51
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-c0115a3794bso511269966b.0
        for <linux-wireless@vger.kernel.org>; Tue, 16 Jun 2026 07:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781619417; x=1782224217; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8VHtkK8tM3BdtAhkGiLPcaxkAA8nOhYvW3opPVSOK/0=;
        b=hmm1mA5/YoJoMTV1Yme7AAP+FEJh7nRhAwkYxCcjT/IYxuPd7goz3oP76WPxPxDJi0
         X4NaXMQ1LPTr+rmI9mOhZ4dEusjKyMjc6jRNvJllVXuIIKxF3YoIZt5i5DB8FBss3QSm
         S/CAVxU1RVX/rsRTf9HPQB1c7yakDaW/Ie9yfvyw1YPq0JcdtzKqJM576Nuoi0qHWYls
         jgB+NSBJqIRm0/jasr+SFA7MpAxtgxgAnKZ68x6CuAuW9uPmVrJMMD+eRT9BenM868W5
         81sbM2GD49ieQNfIaNgG28YX4PUBTQxAFnszmP0jW8aE5LbHqcUJRlmS4sWvOpxwJl6z
         1AEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781619417; x=1782224217;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8VHtkK8tM3BdtAhkGiLPcaxkAA8nOhYvW3opPVSOK/0=;
        b=eUVmbEYZhePa5NoMGmRPPYoXAYv590fqQ0kOWGxKbRu6MJ4r97Qr7isj5qvmBkElgl
         zHBOkyb9uTkaQhww8xRTtFGzUlZLWGjrgXo/pNgoX7Z7A2sU6fFVcRSungdLD2jujfDc
         NBFxIP5FJhU0yio0xT52EjFPKqdBnOCH2wtrBMv9QuNOY18sI/hYbC9ojk1eNB2xgr7c
         HZrdPF9jHK86FCB1qSsV2LEUM4l6PyO+B4bp3uE+d8uWEXw3zIB5KBiJJ3geAT0bEO+C
         gyHSF2ioVNHW+KddSYP249dkxY2T1FxJsjhjhukGoIVKTlNJeIdaN5/9V47zzfDlrZLy
         Rr0Q==
X-Gm-Message-State: AOJu0YzmOKD3icN4G+gwovuXmmS0BOoXqp5xQ5xxqXwA/yQW7wK9XROy
	Q+mjrIjIUr9kFXZh9s/R/878CgYyGZink6r4Vt8OURR5yGxuGOro7QhZrWqu1XtykcQ=
X-Gm-Gg: Acq92OHt+Ds6Dpmli8+ZkTq39PEBsJB03usqIcOXg/VPP3qPp6aahPwZB402BT9GeMp
	lEAsGrnyF5qmmywF4Uwm9ncDxFa5EOa9zyN+ivZF6naeD4InlWMfJoN6yu5BVVoIR1EH0I+DnhA
	Md36z0EZQEsbJB85TH4jp06NOu9wfuYpbFXxvBX8VmvH2nUH4TrDoOxQmRK3KHDxZYWBGa0FrXW
	vUZRzUOzpt6GYGIIKGBpmD9uMLZx3+E6by4Z2AI1mAHGx0N0NEEku8fqQKbv3djx3jLOxLi8tC7
	/YdzlEVXCH5w4oFpUX7CATk3hEoEsn47jYXUFbkZKH0zfi3ls3RyJAJrDNx2zIh7a1/Ah95dAF2
	3rAJOacfMO+Q/APnzWDBtxWV9AUK+eLgctuRbitIhySKoiH4ZA3GzND08I1GXA2czt1TsRsyPjN
	ecQNChmRYos5V9IWMNmp6hRk7fLKtsSgM/5Q==
X-Received: by 2002:a17:907:68a7:b0:bcb:d9c7:c6f with SMTP id a640c23a62f3a-bff496241eemr463151966b.7.1781619416660;
        Tue, 16 Jun 2026 07:16:56 -0700 (PDT)
Received: from localhost ([80.208.66.169])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c01ee8286c9sm373807366b.5.2026.06.16.07.16.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 07:16:56 -0700 (PDT)
From: William Hansen-Baird <william.hansen.baird@gmail.com>
To: pkshih@realtek.com
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	William Hansen-Baird <william.hansen.baird@gmail.com>
Subject: [PATCH rtw-next v2 3/3] wifi: rtlwifi: disable ASPM for RTL8723BE with subsystem ID 17aa:b736
Date: Tue, 16 Jun 2026 16:16:20 +0200
Message-ID: <20260616141620.91081-4-william.hansen.baird@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616141620.91081-1-william.hansen.baird@gmail.com>
References: <20260614135508.70307-1-william.hansen.baird@gmail.com>
 <20260616141620.91081-1-william.hansen.baird@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-37840-lists,linux-wireless=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[williamhansenbaird@gmail.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:pkshih@realtek.com,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:william.hansen.baird@gmail.com,m:williamhansenbaird@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[williamhansenbaird@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F31B96907CA

RTL8723BE outputs a large amount of PCIe AER errors during and
after boot, even before probe and when driver is never loaded.
This causes significant system slowdown.

The errors are the same as reported by
commit 77a6407c6ab2 ("wifi: rtlwifi: disable ASPM for RTL8723BE with subsystem ID 11ad:1723")

Add the RTL8723BE with subsystem ID 17aa:b736 to the rtl_aspm_quirks
table to stop the AER errors. AER errors can still be present prior to
pci probe, as the device by default may have ASPM enabled.

Testing on a Razer Blade 14 2017 which shipped from the
OEM equipped with an RTL8723BE card with this subsystem ID
confirms that this patch resolves the AER flood and allows the
wireless card to function normally once the driver takes over.

Signed-off-by: William Hansen-Baird <william.hansen.baird@gmail.com>
---
 drivers/net/wireless/realtek/rtlwifi/pci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/realtek/rtlwifi/pci.c b/drivers/net/wireless/realtek/rtlwifi/pci.c
index 9de396879806..9919c8588cbd 100644
--- a/drivers/net/wireless/realtek/rtlwifi/pci.c
+++ b/drivers/net/wireless/realtek/rtlwifi/pci.c
@@ -33,6 +33,7 @@ static const u8 ac_to_hwq[] = {
 
 static const struct pci_device_id rtl_aspm_quirks[] = {
 	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_REALTEK, 0xb723, 0x11ad, 0x1723) },
+	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_REALTEK, 0xb723, 0x17aa, 0xb736) },
 	{ 0 }
 };
 
-- 
2.54.0


