Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B7441258FB
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Dec 2019 01:58:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbfLSA6F (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 18 Dec 2019 19:58:05 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:38409 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726518AbfLSA6F (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 18 Dec 2019 19:58:05 -0500
Received: by mail-pg1-f194.google.com with SMTP id a33so2191186pgm.5
        for <linux-wireless@vger.kernel.org>; Wed, 18 Dec 2019 16:58:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=yOH7ELVRGRHpc5yc+mhaOVn02IC0gb5hZs9FIFXbe9M=;
        b=nx7gphMj/8rKg9wjNACwYtnulIZ6Z8xrg7ko+Bj8Q4Goa9SMGAoBSjEbCjgcisRPZz
         94RNOJQzTVei6D1ksrt+NFqvHYe6qpB7kXp5ddvzZmtYECJDiqIz/mLjmbL5pJopdi/8
         YpYDwZcEXU8rsPmhRDAYFBKDYrIKY7rBgBZkI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=yOH7ELVRGRHpc5yc+mhaOVn02IC0gb5hZs9FIFXbe9M=;
        b=Z38NrAVlzBX0PM5RKy/CCQn35kNhzzwckBBBm28S3dnr9VY8pPkjxx6EjJFmiRDJpq
         oryA0RPULnr/d9rbLMw3Iy9k+TtSvL8xBWgOQND92uvLAQGjIYy0tjBcwvFbwwwyk5p3
         YiLVa18b4KbGU653cjKdpwUrUINJGWJ0KgM9xR9FZByqD7YFq/bZTWEqfEXGa5BtSqpo
         w/+wdPN4eebtAIZnr4mjWsidov9n5kDJpocHt9xQYy7b/a5aK6aNFYeXE8rYFRMKfRwJ
         VgJPxo3aueR/YDJiafC8hA/XQ+93+tkr9bc2sutLKhmqtgG+FYMT4lzWe5mvlg0A+njo
         UF2g==
X-Gm-Message-State: APjAAAUpItShvEvIrKRRx6eXoC4TpArEH4IfD6c/TxAcZ/OF03Itspkl
        5QlO4igZmhVT8RKgEZjs969/Tg==
X-Google-Smtp-Source: APXvYqyEyAYA+swFuBfwD7jDeGcbH7mn+r/8mhydPwx0i9i1OR3DvHQExZunnygp3gx8B2+525aKYg==
X-Received: by 2002:a63:234f:: with SMTP id u15mr6106045pgm.88.1576717084567;
        Wed, 18 Dec 2019 16:58:04 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id z130sm4704185pgz.6.2019.12.18.16.58.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2019 16:58:03 -0800 (PST)
Date:   Wed, 18 Dec 2019 16:58:02 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath11k@lists.infradead.org
Subject: [PATCH] ath11k: Use sizeof_field() instead of FIELD_SIZEOF()
Message-ID: <201912181657.CE7D3CE33@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The FIELD_SIZEOF() macro was redundant, and is being removed from the
kernel. Since commit c593642c8be0 ("treewide: Use sizeof_field() macro")
this is one of the last users of the old macro, so replace it.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
resend: https://lore.kernel.org/lkml/87d0cl8q46.fsf@kamboji.qca.qualcomm.com
---
 drivers/net/wireless/ath/ath11k/wmi.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath11k/wmi.h b/drivers/net/wireless/ath/ath11k/wmi.h
index 4a518d406bc5..fd7cb07a9940 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.h
+++ b/drivers/net/wireless/ath/ath11k/wmi.h
@@ -44,7 +44,7 @@ struct wmi_tlv {
 
 #define WMI_TLV_LEN	GENMASK(15, 0)
 #define WMI_TLV_TAG	GENMASK(31, 16)
-#define TLV_HDR_SIZE	FIELD_SIZEOF(struct wmi_tlv, header)
+#define TLV_HDR_SIZE	sizeof_field(struct wmi_tlv, header)
 
 #define WMI_CMD_HDR_CMD_ID      GENMASK(23, 0)
 #define WMI_MAX_MEM_REQS        32
-- 
2.17.1


-- 
Kees Cook
