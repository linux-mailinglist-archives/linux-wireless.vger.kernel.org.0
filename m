Return-Path: <linux-wireless+bounces-510-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A682A8079E8
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Dec 2023 21:59:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C8751F21986
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Dec 2023 20:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 448CA3FE24;
	Wed,  6 Dec 2023 20:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jZZw9mI7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 584821BD
	for <linux-wireless@vger.kernel.org>; Wed,  6 Dec 2023 12:59:12 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1cfb30ce241so1805325ad.0
        for <linux-wireless@vger.kernel.org>; Wed, 06 Dec 2023 12:59:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701896352; x=1702501152; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=J93fduvsJM9IBDskoI9RKo4tnycXW8hW3zH9yUjvMQk=;
        b=jZZw9mI7YrxEPgI+aIObpwp94vnWw09sNo7OJ/9O8MwgjocHUrmcfZpMxhmTZjk3CF
         SZ0XlZj4Tt8IneivqQgFUq6XcOuf9wDJds7WEv3FQKLaytYyPTknLrpB1dfzqRfHHL4X
         kXCU7iBrV3JBcbRr1LsgX3tMkuE4Y+1zGEvic=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701896352; x=1702501152;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J93fduvsJM9IBDskoI9RKo4tnycXW8hW3zH9yUjvMQk=;
        b=l2fKHbDU8CvPsHke3FWZJ6WbfCuHX18LZE68ywnPG06d4SDYcGARNN/sxq/SWn+WOm
         +dj+FOIKPQBQKwKvpIRM2CSX6mJd0qu6pWYUGMrxkVeKrxtRx8Uny8O52DSEvaj0TLAI
         6TT/qvujMg1nyBcZdQTHhFFxy5XuuDYBuavyZYM6s7qj56CKzZbh8UErHQqg/lijBtCl
         mMXrwBre/nB0xq2pO+0YDbR5GrK1KG8LhhTzv4FxgvNrArIW7Ek+W/Rfh+Rd6GpgtcVQ
         9Q8wja3t6G9U0vcawDPeyotbR81AmA1aVMb3Y9/ouZTLBvc2uIG+mwIpiiHWev48+u8l
         0QAA==
X-Gm-Message-State: AOJu0YxDJUrO9gZtQPMgZJ7XYFHsqdFnWT7DxFFNCSYfPy8uLvP1pp0i
	RZKuapWIfcMXO3sbtx43PCoOZQ==
X-Google-Smtp-Source: AGHT+IFvswkhjo/IRJgksME8nSDfGlm3ijJw/G6gOtT77V36Y3AGjjCCSiF/AeJmBG3/ZUhfEybY+w==
X-Received: by 2002:a17:902:ce8c:b0:1d0:5efb:852e with SMTP id f12-20020a170902ce8c00b001d05efb852emr1894519plg.40.1701896351898;
        Wed, 06 Dec 2023 12:59:11 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id g15-20020a1709029f8f00b001cffe1e7374sm241121plq.214.2023.12.06.12.59.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 12:59:11 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Kees Cook <keescook@chromium.org>,
	kernel test robot <lkp@intel.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Jeff Johnson <quic_jjohnson@quicinc.com>,
	Michael Walle <mwalle@kernel.org>,
	Max Schulze <max.schulze@online.de>,
	netdev@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH v3] netlink: Return unsigned value for nla_len()
Date: Wed,  6 Dec 2023 12:59:07 -0800
Message-Id: <20231206205904.make.018-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2690; i=keescook@chromium.org;
 h=from:subject:message-id; bh=pLbf9+8/Dl6ABNGi9y3vSm6UF9GJMzpseYPTOTsyx3s=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlcOCb/xqKImyOG8B5tSBdCnmYR3X3y0Fpi6OPz
 +IJ//WINgGJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZXDgmwAKCRCJcvTf3G3A
 Jla8D/4u3zQcCSzbtxkzBPPv06VCqIqEjWUmThCDWb+7VGajZMflRwumsBIenZhrHpN5F5aclOO
 4VuHTW8AM5MPLgfRnMQ4JvuUp2Upru5NZQjfGbfMVR8helKPFcBr9hc04VO1f92ifYptZRN/LKb
 jOKQWB3KCZMuQasgWFlbpupkYVvuSZVid0v4uHPmr+XPVJHMHShYG5uojmi79M+Ublpsz9iH88S
 lbfK82rcT0UN8FROEBI2dTwMS5WlKw4KrykUQbatRuSyFrU7vSM2SFxoT55PrI419GzCH35Rvqc
 gz7Zap2Sr3KnVwn21KhkpdXtzjiX8Y/hOeWFpfSnhS/PlKtOUWwS84KMSfBCuqIWqBo62i0+zGT
 tyELRq341AAVcM5zvGvxbytPFkyPSbNR7dZJ2STXBR6LM0NKhVEqnpQXcXn2zq5bhpj25epO8cJ
 5rHqEuJaVlT0U7t1RHlp3tkdieB2VJpkHjx9vnAMrB7aXV+30hKEZZvtgIpv6UXRdfnBYXufLpw
 hPjF2ZyQ7BEW3wi3OqKe0Hw0rZrzOYmCRZ5s/oUW5icBLeD2zNyTioD8elQ+oFohpwdafgXuy/v
 9qOsRL44DGAAZ+T1MUSWBz+xvuCU2vKWiUkQWVbeT+otZYhXiojiclK7j+OVH8jbd3TIghZHF6P
 3UCxxmr ZBhWuGBg==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

The return value from nla_len() is never expected to be negative, and can
never be more than struct nlattr::nla_len (a u16). Adjust the prototype
on the function. This will let GCC's value range optimization passes
know that the return can never be negative, and can never be larger than
u16. As recently discussed[1], this silences the following warning in
GCC 12+:

net/wireless/nl80211.c: In function 'nl80211_set_cqm_rssi.isra':
net/wireless/nl80211.c:12892:17: warning: 'memcpy' specified bound 18446744073709551615 exceeds maximum object size 9223372036854775807 [-Wstringop-overflow=]
12892 |                 memcpy(cqm_config->rssi_thresholds, thresholds,
      |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
12893 |                        flex_array_size(cqm_config, rssi_thresholds,
      |                        ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
12894 |                                        n_thresholds));
      |                                        ~~~~~~~~~~~~~~

A future change would be to clamp the subtraction to make sure it never
wraps around if nla_len is somehow less than NLA_HDRLEN, which would
have the additional benefit of being defensive in the face of nlattr
corruption or logic errors.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202311090752.hWcJWAHL-lkp@intel.com/ [1]
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: David S. Miller <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Johannes Berg <johannes@sipsolutions.net>
Cc: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Michael Walle <mwalle@kernel.org>
Cc: Max Schulze <max.schulze@online.de>
Cc: netdev@vger.kernel.org
Cc: linux-wireless@vger.kernel.org
Link: https://lore.kernel.org/r/20231202202539.it.704-kees@kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 v3: do not cast NLA_HDRLEN to u16 (nicolas.dichtel)
 v2: https://lore.kernel.org/all/20231202202539.it.704-kees@kernel.org/
 v1: https://lore.kernel.org/all/20231130200058.work.520-kees@kernel.org/
---
 include/net/netlink.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/net/netlink.h b/include/net/netlink.h
index 83bdf787aeee..7678a596a86b 100644
--- a/include/net/netlink.h
+++ b/include/net/netlink.h
@@ -1200,7 +1200,7 @@ static inline void *nla_data(const struct nlattr *nla)
  * nla_len - length of payload
  * @nla: netlink attribute
  */
-static inline int nla_len(const struct nlattr *nla)
+static inline u16 nla_len(const struct nlattr *nla)
 {
 	return nla->nla_len - NLA_HDRLEN;
 }
-- 
2.34.1


