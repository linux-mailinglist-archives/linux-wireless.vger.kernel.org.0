Return-Path: <linux-wireless+bounces-333-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49B51801E72
	for <lists+linux-wireless@lfdr.de>; Sat,  2 Dec 2023 21:26:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00D2E280C7D
	for <lists+linux-wireless@lfdr.de>; Sat,  2 Dec 2023 20:25:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3C7E2136C;
	Sat,  2 Dec 2023 20:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="oaq+XIsh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E909E11F
	for <linux-wireless@vger.kernel.org>; Sat,  2 Dec 2023 12:25:47 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-2866951b6e0so1000934a91.2
        for <linux-wireless@vger.kernel.org>; Sat, 02 Dec 2023 12:25:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701548747; x=1702153547; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iWmTwjW3FnLpctM7BL1LmgQcPd+SHX+/bRvCSLNNvhU=;
        b=oaq+XIsh4I3Se+pEmLd6xYfDeHN+k+LYW7VLXSgBC8ii4lv8RuYuB84Zvv/Yq8I/Wi
         4BQyFHgkur102e+MuTRXVaPqfb1WvfJ7hkTLXIMLjPrGyqefTX5Bs9LMMWK8yd2qHVcm
         5EwNi2fM8DtOH+b7Rna8wtBxEdLeEwR0h4hQw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701548747; x=1702153547;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iWmTwjW3FnLpctM7BL1LmgQcPd+SHX+/bRvCSLNNvhU=;
        b=gbuY/hQtrBPz+LSyNWpL0+T4DgIEQF3ZtuXGYBLIkSoOav3QH43I4O9jV0wjLKjbIo
         VjGkuaRWwdRFXH3lR+JUmUUyZQk0gXbTBR4qC0XseeQWYGM8J/WplQmURaQSAzeWWdv8
         +GPyBB0V0mWwmRsrIZ+uf/czP9FuVO88vbUHpuArfqmcxUaQSHEaUw+CKr3LUNjRJWCH
         6feAjFoNN8oBaO0fYKjoyFe5yKRWsgtmN67hSve8Is9x+e54UdjUva0dbI9GeoQLHKQK
         6ZU5la/n9jCp30h1hmXaFFnBlbg3jbNlm1ZhdOeeEHcFdHrgRSgmAXlOgVl1jsb0ZV7G
         Ncug==
X-Gm-Message-State: AOJu0Yzfs0omI/OaWEnf7hzgFn252jApqgSkT5fKtMFInYFHXu0DgIbc
	izt9nI9O7wuXJEyvXpE/KXoFHw==
X-Google-Smtp-Source: AGHT+IHetUDarX9T2ChHXvmUlsmJEsZNIHfoFI1u/mh+/0bCLi8FlhnaePtBtK7zgVVvE8EZ8UKZvg==
X-Received: by 2002:a17:90a:c7d7:b0:286:6cc0:caca with SMTP id gf23-20020a17090ac7d700b002866cc0cacamr1257532pjb.65.1701548747333;
        Sat, 02 Dec 2023 12:25:47 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id nu3-20020a17090b1b0300b002804c91633dsm5226023pjb.14.2023.12.02.12.25.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Dec 2023 12:25:46 -0800 (PST)
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
	Nicolas Dichtel <nicolas.dichtel@6wind.com>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH v2] netlink: Return unsigned value for nla_len()
Date: Sat,  2 Dec 2023 12:25:43 -0800
Message-Id: <20231202202539.it.704-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3148; i=keescook@chromium.org;
 h=from:subject:message-id; bh=zqo8NNuvyL3Qo2gExRi3IB5p0gfHuwCMkVKNBkSt50w=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBla5LGl8X7l/qpTOEDPnYi96YG0MitkUNkEC/FI
 A3j9Fe7zFKJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZWuSxgAKCRCJcvTf3G3A
 JgoaEACVG4dPOEdzCMFdjgjnjNsFP6YjpLhlh2wley6rzZtotKdVNy0AOydgKPjgS65AvnvUNXR
 /IRKgFRbhTx+RtBg3KsqDiB4ONUbRzPkQkz9n5xKKAuVOSI7E1EoH9swDwyTyIYcytqZvlHCc52
 onLfhraPURvpPAZiWQYbgTgKBND4TPOafYeZ/e5XY3EN5p+f3DMXHdbF7H/L9ZpfjveTb9trcf5
 tHkxZEgXMNxPmbazRN4Duy7HLLgRVO4HE1AHImH7eljQf9AYCaAZ1O6BHnLnkzHXRdLiLRMPEya
 DY4kIVbgWCmwlUGP+63nzrVNEWUxxzNb2PeM9nu3Odn8p1bFYNvPYUbRt+h5ShfeHkG6dXZ1/3m
 h9nCL0BfS5ry8Cu2vzeI5/95Js0bEHofGTADKawRIN0Tt7lhEX9dlW5yBQselzzpnCdj6xx//24
 DHvyEtf1oEmI5e++mC/JFIj0xDBzGur/AfXRCWfrZoEscEpHM/snfkGeyuyI0lc0mcRattkSc3P
 xSTQf57GcUHdUhCLkxXM7R5EjmirxJ1YI4F/U6JySq6hi9GPa6KEg/SILEDOc/SLq+YdIFY7m4K
 PT423H32ZacYrNJ8D3laZJlFDzDFasiRxGmOdH8j1BZ3U7e2iaKcNS/98PECi3YfBYz4ZRIz9sq
 3BBeuU0 dTrrwZVQ==
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
 v2:
 - do not clamp return value (kuba)
 - adjust NLA_HDRLEN to be u16 also
 v1: https://lore.kernel.org/all/20231130200058.work.520-kees@kernel.org/
---
 include/net/netlink.h        | 2 +-
 include/uapi/linux/netlink.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

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
diff --git a/include/uapi/linux/netlink.h b/include/uapi/linux/netlink.h
index f87aaf28a649..270feed9fd63 100644
--- a/include/uapi/linux/netlink.h
+++ b/include/uapi/linux/netlink.h
@@ -247,7 +247,7 @@ struct nlattr {
 
 #define NLA_ALIGNTO		4
 #define NLA_ALIGN(len)		(((len) + NLA_ALIGNTO - 1) & ~(NLA_ALIGNTO - 1))
-#define NLA_HDRLEN		((int) NLA_ALIGN(sizeof(struct nlattr)))
+#define NLA_HDRLEN		((__u16) NLA_ALIGN(sizeof(struct nlattr)))
 
 /* Generic 32 bitflags attribute content sent to the kernel.
  *
-- 
2.34.1


