Return-Path: <linux-wireless+bounces-28448-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 93471C2531E
	for <lists+linux-wireless@lfdr.de>; Fri, 31 Oct 2025 14:10:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id ABDFF4F6A96
	for <lists+linux-wireless@lfdr.de>; Fri, 31 Oct 2025 13:04:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAC3734A797;
	Fri, 31 Oct 2025 13:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AWUEHXVz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B434E20297C
	for <linux-wireless@vger.kernel.org>; Fri, 31 Oct 2025 13:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761915875; cv=none; b=M8k1SYqfXFlpJQ2QVNw2p6elftSOJGW82u8BS5IhM6MzXv5n6jLgUqcSA24mY6739LD2ZY2at33O16x09mpL4HR3tL5bN+/39TqN7oR3t2KBXEOQ3ajs34ChAKVjdOFgwzveN4geoDR1GNxi1TYIEYB89Vd8z/91OzDDdqf0onk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761915875; c=relaxed/simple;
	bh=yeiq88IC/wiatgkkK0r6GR62xuv/O/ItLS4vy5v9HZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=uL8M2tjhe+j1YfCjCKL2e8sRwRWgPgXYRR0BKk6zPj7xjSKUEwfMc9WLdKl9hzMYbZ9pQ//WNanS2731ejrzoWMcShqIVZUY5ZXzNr1/bV0spYtruv1poR7m6GO/yyQM5grQmW09Snxb1Uljc6UGp7jgymHk8oOSuLXMlHHUcaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AWUEHXVz; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-475e01db75aso14843415e9.1
        for <linux-wireless@vger.kernel.org>; Fri, 31 Oct 2025 06:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761915872; x=1762520672; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qhTG70xhFOoL3LxdnSOH1s4YIgOQ3cukod+Akz7RCDg=;
        b=AWUEHXVzRER+h3Fa/h/PpkzNHYFo+BN1THtGkFpY5ACBoaNibcfs88be+6wTqjh5c8
         4+rLyQEHYb7P4zllAPFRz9VCNRiRvSDvqT80y8xqGrp1ryUg6VhmMt4Gmm9sXvzNuThu
         I+Q9YNN+DawHtGuUNqAfa6lt14W4ZlfL1U2bt5weoYD/n9CxZVj6haqd6oFAD4/Ds9AF
         b5IDNha0wTlqbgIKwEDgNk1sTybAEMIH3iMM3nzkDGkvM4Q8Patnj0bwuu997iAHSztQ
         gt7kBpINEcP5qJsYeonUmMevIdL3Ugr3+F17Qa85h65aGcA1ootFzMqkoT76epJpDb+n
         bwHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761915872; x=1762520672;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qhTG70xhFOoL3LxdnSOH1s4YIgOQ3cukod+Akz7RCDg=;
        b=AlDhpvMK8F1cNi+9GAQWFM0uWCLjCRZaaL04e/7CTwGVTffHYdsSVtTy7cu7hP4ZW1
         ZB/43DqL2+bdeIegWzZWItmrSh2SZR+pqmMQd4k2WyGycNRE8KjjJkAWHSGZg9qa53Oe
         k9JAiCKg63k/ufMBWM4Aeg8NOTzIlcNOx57+SZg1s5a9fa+GH9TK2orxo5Y4Oeu8WMj5
         /Xcp5pp0duNNyMtc/Ui7s7o0kdeJmeCRTgjZSBzpNDu3+FZyLUV6bVFCu4T3WHbtgk16
         4ArJHrVrdPdSxh63oKJ9AnHrCGpC4KR4Q0KjuaXnUOc0ICumTcvVz5kYuO5WnRYpEdeH
         Kk7Q==
X-Gm-Message-State: AOJu0YxOtbYRnEdTfZHngUweWs2kfryrnCN8B1ChpIQ3g0Ykbte39TX5
	Pa+HnbMDLLr30hFwYs2VyL45to2x/HIpiInUeVJPiOOl+Q3pxot3t+lru5jFab04sWg=
X-Gm-Gg: ASbGncvB0VvMfg1IDsQQaD96AzsIcF39mXIs8K1kKqt+NNPj81ETCidAUv6QUbQQCjo
	RfrS0rQbE7nwk6YTj2OEg2Du+Fzt1iy31B5Dsz8SSDqrqzkBgFQMl4mYmgTmKPiGpD8yqNMMR7r
	N4/3k2sp+EkaR+MbW87CzfYzga35+/0O4hkNcadcm1VzqIP+wvshnIETU8cR3biGHhXqHavOuJH
	ywxU7ezoQPUE79OcNOttgflAVYpOxjv2Ni3JTCNAOUlOyHyAdUhKqGNsH3R+lgQf1vAN4brvSyr
	rCBoZBoZHcKkWS/neC5Xq66ZbhpMJcIegH3AY5sRAh1aJ6k8wzl1/himtKI9zF0fHdizybyI5qC
	A+fFqhQpFeCZDWnZN9/PU8c7zyxuU+lrcudtd4r6olmbxTN1DQzda4dstuGn1Eu0bq6vjkYcLMA
	2wFA5ybp2UTgtTYnrZ
X-Google-Smtp-Source: AGHT+IESqZPWaIgD3AFJm0+ERJLsHPPT26aWWfG1t25b6cC3jhoS3LSTQWz0ZPa8qZHwD6kKbm0TEA==
X-Received: by 2002:a05:600c:1907:b0:46e:59bd:f7d3 with SMTP id 5b1f17b1804b1-4773089c432mr29850955e9.20.1761915872032;
        Fri, 31 Oct 2025 06:04:32 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-47733023256sm33788435e9.17.2025.10.31.06.04.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 06:04:31 -0700 (PDT)
Date: Fri, 31 Oct 2025 16:04:28 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Ping-Ke Shih <pkshih@realtek.com>,
	Harshit Mogalapalli <harshit.m.mogalapalli@gmail.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH] rtlwifi: rtl8188ee: remove an accidental '-' character
Message-ID: <aQSz3KnK4wFIJoe3@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The "->allstasleep" variable is a 1 bit bitfield.  It can only be
0 or 1.  This "= -1" assignement was supposed to be "= 1".  This
doesn't change how the code works, it's just a cleanup.

Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
Found with a static checker rule that Harshit and I wrote.

 drivers/net/wireless/realtek/rtlwifi/rtl8188ee/fw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/fw.c b/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/fw.c
index 7252bc621211..7ef57b1c674c 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/fw.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/fw.c
@@ -694,7 +694,7 @@ void rtl88e_set_p2p_ps_offload_cmd(struct ieee80211_hw *hw, u8 p2p_ps_state)
 
 			if (P2P_ROLE_GO == rtlpriv->mac80211.p2p) {
 				p2p_ps_offload->role = 1;
-				p2p_ps_offload->allstasleep = -1;
+				p2p_ps_offload->allstasleep = 1;
 			} else {
 				p2p_ps_offload->role = 0;
 			}
-- 
2.51.0


