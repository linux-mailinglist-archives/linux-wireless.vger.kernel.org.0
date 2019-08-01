Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 13D477D626
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Aug 2019 09:15:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730547AbfHAHPF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 1 Aug 2019 03:15:05 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:43272 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725283AbfHAHPE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 1 Aug 2019 03:15:04 -0400
Received: by mail-lj1-f194.google.com with SMTP id y17so43729748ljk.10
        for <linux-wireless@vger.kernel.org>; Thu, 01 Aug 2019 00:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XqjNTMdCoxg7mqOMzCamjYwRdrBEdNTjPXYyp8Ir2GI=;
        b=OORIw4EpWMna92eRsKeGffoxXQBJ2NFun/gqf6YoseaLgJHqUF95kz6sr/5PJ5d/EZ
         x9hwNhYc76Y0kfSftLKetkDSGKirlzUfVAo5c/Y10kHv0/7jHuGlb+uE8UUVXAkKatIi
         FYN8JvgYdGKyy/cn62LfKX6GsqffgI0AwdxH1/8rUPRmLKXyGjkJyknxCwrks6zJDWqG
         xGTRfe/5aFTwO9VskmbdKft/tdm5/QNy+Badm6VjxDbNuzNZ1wB7OXYQJweCo/WjfSZk
         dLj36xVLVYWqMsqHMMcbh+Jm4Os6g1Q6MKzPZ/xrEQ5qsZgD2YPPwgzR3pJPtUPNMMqr
         WXIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XqjNTMdCoxg7mqOMzCamjYwRdrBEdNTjPXYyp8Ir2GI=;
        b=P4JBsipzVsmjFZQZUycb0ZdMZ40A8ZcrDh608/BuGKwyBpMLnSxmeU5mtCVRZq43b/
         1bga6+ke6RL4QPlmDdE4YmvQhzMawyb/z4azKbISurI1hZ4MBJk7/2QSAq9vxSx1iKQS
         9YWMXaxwPu70M17XDQYCcmiuy35kZUTkzLRA/bTs1yWodd7ytdCsfVU0IfZTZh1TTM3x
         tAa3RSHilfc5zI67zZK1dbHqrr0Q/sl0OvmdNQWKV+k031J91gQ1ub7LxY+4RWhJHNHZ
         TFvdGBmrzxumXMFZv3yF5ax/GovqdWQiQ7JaROdp9iPDf24ra9C5oAm5ybRO4iwxRWYa
         Tjdg==
X-Gm-Message-State: APjAAAVKeHLxAcQP8Wq07zfL6nXu3ZCr3SaGTlpVcbxK57fRso4NfKHn
        Alm0+nyHICVxSGPD1PH/tIc=
X-Google-Smtp-Source: APXvYqyDb8+aPKTKfHRTO3GsA7Jey8wi9mTCLCYl/7DHglzteyhjqyF9N8D5nOE9hYfFvFnDCkAfBQ==
X-Received: by 2002:a2e:9192:: with SMTP id f18mr36879499ljg.52.1564643702975;
        Thu, 01 Aug 2019 00:15:02 -0700 (PDT)
Received: from localhost.localdomain ([109.252.54.73])
        by smtp.gmail.com with ESMTPSA id 63sm14654577ljs.84.2019.08.01.00.15.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Aug 2019 00:15:02 -0700 (PDT)
From:   Denis Kenzior <denkenz@gmail.com>
To:     johannes@sipsolutions.net, linux-wireless@vger.kernel.org
Cc:     Denis Kenzior <denkenz@gmail.com>
Subject: [RFCv1 2/2] nl80211: Don't split-dump for clients with large buffers
Date:   Thu,  1 Aug 2019 02:14:55 -0500
Message-Id: <20190801071455.4974-2-denkenz@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190801071455.4974-1-denkenz@gmail.com>
References: <20190801071455.4974-1-denkenz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

---
 net/wireless/nl80211.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 6774072e836f..e1707cfd9076 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -2496,6 +2496,22 @@ static int nl80211_dump_wiphy(struct sk_buff *skb, struct netlink_callback *cb)
 			rtnl_unlock();
 			return ret;
 		}
+
+		/*
+		 * auto-detect support for large buffer sizes: af_netlink
+		 * will allocate skbufs larger than 4096 in cases where
+		 * it detects that the client receive buffer (given to
+		 * recvmsg) is bigger.  In such cases we can assume that
+		 * performing split dumps is wasteful since the client
+		 * can likely safely consume the entire un-split wiphy
+		 * message in one go without the extra message header
+		 * overhead.
+		 */
+		if (skb_tailroom(skb) > 4096) {
+			state->large_message = true;
+			state->split = false;
+		}
+
 		cb->args[0] = (long)state;
 	}
 
@@ -2529,6 +2545,7 @@ static int nl80211_dump_wiphy(struct sk_buff *skb, struct netlink_callback *cb)
 				 * We can then retry with the larger buffer.
 				 */
 				if ((ret == -ENOBUFS || ret == -EMSGSIZE) &&
+				    !state->large_message &&
 				    !skb->len && !state->split &&
 				    cb->min_dump_alloc < 4096) {
 					cb->min_dump_alloc = 4096;
-- 
2.21.0

