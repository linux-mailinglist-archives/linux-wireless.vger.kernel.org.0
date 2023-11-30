Return-Path: <linux-wireless+bounces-260-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E7BF7FFBE6
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Nov 2023 21:01:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 609CE1C211FE
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Nov 2023 20:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E32D53E10;
	Thu, 30 Nov 2023 20:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GGyJ41Gi"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7203F10D9
	for <linux-wireless@vger.kernel.org>; Thu, 30 Nov 2023 12:01:04 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-5c27ee9c36bso1113431a12.1
        for <linux-wireless@vger.kernel.org>; Thu, 30 Nov 2023 12:01:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701374464; x=1701979264; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DjLamxZyQfbyptpIvpzFIM9HoGVb6+OmTO9thE+0l0A=;
        b=GGyJ41GinrkCDijL/CNfx8rZzdU+bWwf+Sretpgifqmsok/ABKqMO18zKMQK1XPOLv
         GkFrv6Eq7jtCBnl6+iPQCJQNQCbeRV7WwdarFUCZV3qBmHrrO5Stq5YMAk0DeDMnv3AA
         tV+ja7xTeosbnInimbMe/Rfe4j/CPfl07T2H0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701374464; x=1701979264;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DjLamxZyQfbyptpIvpzFIM9HoGVb6+OmTO9thE+0l0A=;
        b=g3t+yv7vr3gcIEkDzyoCPVtodBAyZevBoqYXp6e/MiXsmNqjxwENIzK3btkCgNhIoF
         1ripuW1RrAlIEYTH89eRZDBQ6TqoAQjgv0jjeSPlktBumXf3uQnlpa3lHaWyAB8FbUO9
         1giSInmvxF83ch7AxbcN/zgbWQuH04rSIfhwZ/QDZpOVU5kuoM57b9GYg3JW7/ZhSNU2
         Es+A9EDN0Lx+U9PFEH/xCco8lpE69ryJDwS+Wsnzlp6OxTFkDE4ig1SK95RGII05KiZ+
         CEIkDSv3S8aWN6VoqRQUREowC9FKFF5BMSOI5eobnvZlqNDpJRdXPU75n3/O1u0xqAQU
         EDbA==
X-Gm-Message-State: AOJu0Yw/Ska+xDOMONbbW3JBWgVazHfHIIHFPXwDoMofk2XY1sOO+f1L
	YxEZVJouOccortHUPePuVtaRGw==
X-Google-Smtp-Source: AGHT+IGgDbuduO0TRl7R7gO2PBc8v+3LqmhG3IlJd7Is7C7ylYuOHkDxFPlQnCSCFhMp0VOLmpjRUQ==
X-Received: by 2002:a17:90b:3b86:b0:285:a179:7174 with SMTP id pc6-20020a17090b3b8600b00285a1797174mr22305244pjb.29.1701374463664;
        Thu, 30 Nov 2023 12:01:03 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id gg16-20020a17090b0a1000b002858ac5e401sm3687765pjb.45.2023.11.30.12.01.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 12:01:03 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Kees Cook <keescook@chromium.org>,
	kernel test robot <lkp@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
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
Subject: [PATCH] netlink: Return unsigned value for nla_len()
Date: Thu, 30 Nov 2023 12:01:01 -0800
Message-Id: <20231130200058.work.520-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2452; i=keescook@chromium.org;
 h=from:subject:message-id; bh=penjs9WkGWzsqXkZBizH1HvU0T+dKnNfeIaWwvPQsRs=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlaOn9cgfbrAAjas3hx+hd183f+KUlnaqvvTcKU
 c2eIz0CGr+JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZWjp/QAKCRCJcvTf3G3A
 JmIKD/9fiJNBEEe9sj4peZsNPvhzqGeV+ixJOnS3btR7fRWXAR9QBI7p3472rOKKDSEWZRdQTRA
 B5AlP8Marc+gBPUBdlUI2yQuf7iLVJ01rwNk7MwwIm0p8877bB9Ge135CpOadBdbi6N52wYlslO
 fbY82GwnMjEL9QLeGY+bnVljthqsh0u4kzcj5lvIekba/DjxD02UIl6gDiGOjBKEdXYXH0W5+7B
 uW1xm50ZqStiyMkZZNdBsN/x+4w0StkgnevqMlHan+qTAGKPSQjfgBwnfOT3z/FVMnCGQyCtxYn
 9KfatOF3VjZl46DHRNfQge4XVW5DOmOROeWhrNkQO37hOF0WQxOkonKxggOmynztvZXky5GdJJk
 tiLIaHyOqJWjxqwHX3USmrjr8WoFXqUGLZUkIj/opc+VpAHdsRN4ZwFLeXcPBLTiC+NWdxXKBo8
 O520MI1VJ1DXdtevqUR5SSfNbJcdcPnvAYoi6HLgonCzGcTextAdQBvRSp21GJ/2V3HMZVkKlUw
 ljYYLzEDitegFiqrm8+9uwtU+sELR7aZ5uaeM0Yi8Co6ml4VYGgxOHKANC8kTvqTGL03DbLrCfV
 dh6a2w5v9R7rWMFPujOVF3bg8C82w7O6z1FrfxDu3Z/+4EnrtLPo0zdTUkrQe6/6HW1xnnx89m3
 N9xuByR CH8DD7Tw==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

The return value from nla_len() is never expected to be negative, and can
never be more than struct nlattr::nla_len (a u16). Adjust the prototype
on the function, and explicitly bounds check the subtraction. This will
let GCC's value range optimization passes know that the return can never
be negative, and can never be larger than u16. As recently discussed[1],
this silences the following warning in GCC 12+:

net/wireless/nl80211.c: In function 'nl80211_set_cqm_rssi.isra':
net/wireless/nl80211.c:12892:17: warning: 'memcpy' specified bound 18446744073709551615 exceeds maximum object size 9223372036854775807 [-Wstringop-overflow=]
12892 |                 memcpy(cqm_config->rssi_thresholds, thresholds,
      |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
12893 |                        flex_array_size(cqm_config, rssi_thresholds,
      |                        ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
12894 |                                        n_thresholds));
      |                                        ~~~~~~~~~~~~~~

This has the additional benefit of being defensive in the face of nlattr
corruption or logic errors (i.e. nla_len being set smaller than
NLA_HDRLEN).

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202311090752.hWcJWAHL-lkp@intel.com/ [1]
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Johannes Berg <johannes@sipsolutions.net>
Cc: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Michael Walle <mwalle@kernel.org>
Cc: Max Schulze <max.schulze@online.de>
Cc: netdev@vger.kernel.org
Cc: linux-wireless@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/net/netlink.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/net/netlink.h b/include/net/netlink.h
index 167b91348e57..c59679524705 100644
--- a/include/net/netlink.h
+++ b/include/net/netlink.h
@@ -1214,9 +1214,9 @@ static inline void *nla_data(const struct nlattr *nla)
  * nla_len - length of payload
  * @nla: netlink attribute
  */
-static inline int nla_len(const struct nlattr *nla)
+static inline u16 nla_len(const struct nlattr *nla)
 {
-	return nla->nla_len - NLA_HDRLEN;
+	return nla->nla_len > NLA_HDRLEN ? nla->nla_len - NLA_HDRLEN : 0;
 }
 
 /**
-- 
2.34.1


