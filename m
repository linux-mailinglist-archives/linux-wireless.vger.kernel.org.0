Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 355D677FF9D
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Aug 2023 23:16:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355210AbjHQVPt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Aug 2023 17:15:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355209AbjHQVPh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Aug 2023 17:15:37 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B2743594
        for <linux-wireless@vger.kernel.org>; Thu, 17 Aug 2023 14:15:36 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-564b8e60ce9so215976a12.2
        for <linux-wireless@vger.kernel.org>; Thu, 17 Aug 2023 14:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692306935; x=1692911735;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nMv3jMfXfZeQlh3kTaF/x4qTfcNW/XdUdIa35ziuNSc=;
        b=J1b6KXoDvYCj93J82hNUfzOMePqIyx20asgvfw8HIrBYC9PQtriyzORw0vdYF4+R39
         iWtouRrtKVwKoTVR779ILkxd2+wmXCHXfEl4mQdb3YyVkHP0qxhS5ImIk7OhWfMifhaT
         lzD5DICKg8ck9C4XQbF81Lh+TIIdtD2/lzNFQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692306935; x=1692911735;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nMv3jMfXfZeQlh3kTaF/x4qTfcNW/XdUdIa35ziuNSc=;
        b=SpzxmIOa23TXqZZkwRVP/95GES8SV+Ym9laRHMr07Hi0RSw1fxYvUuRPSPsSH2dfl7
         a375nh0waD5DtGCmPnWdU9r8SaOKrid6wIAi1vSOOnhsteQbJlzgJjhd3BBnEPI1UkAA
         RiP86kdPUNIAVdCuqjD+OlhIsMHKE7U4x14RuI+ijRq7IeD9KrCCtno4afa0tbD8Osyo
         4z7+z1K1HsHM4PcZqONXj3b6KYmaTLa9IGGvKU/mLe34ZnEBzUClkuM95dEB23ynxQ7j
         t/Dyq4jCRhJOCo0YiXM4JfyxuYZ3lNAms0+o/BLE0UFsW8ZhiyY8BJ+DI9KXPYRsT7rA
         dUKw==
X-Gm-Message-State: AOJu0YwevdTuTFBfHw/BE2tzBq0b1+Ms1tI9IISVe2tubGtsER40XZ4L
        m/e8H3nUXvKqYtm7W4bYJOq5nw==
X-Google-Smtp-Source: AGHT+IFSRStXoIpZytSRGeOX2ux67DF7cS1Gz0NEDNhY067TSw0TiIcAkAihtDsDuM9L/+3asABlTA==
X-Received: by 2002:a05:6a20:3b11:b0:13d:ee19:7723 with SMTP id c17-20020a056a203b1100b0013dee197723mr939971pzh.35.1692306935477;
        Thu, 17 Aug 2023 14:15:35 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id s26-20020a63925a000000b00564ca424f79sm134316pgn.48.2023.08.17.14.15.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 14:15:32 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Kees Cook <keescook@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Subject: [PATCH 0/7] wifi: cfg80211: Annotate with __counted_by
Date:   Thu, 17 Aug 2023 14:15:22 -0700
Message-Id: <20230817211114.never.208-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1217; i=keescook@chromium.org;
 h=from:subject:message-id; bh=yiiQfq7zNw6Og6zmPL90LK8+bep21Nuhy1wjHFcUIPs=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBk3o3wfdi23SF0O9V7M5/FrNoppSrvOQfoI5J+R
 XT6vWdk1XeJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZN6N8AAKCRCJcvTf3G3A
 JgwiEACXzetgKkVCfCqLwZYnasCT/VOWXlnKrOcsE3M9CS7umMyA5Ao5jkbdGb3iPaj5+695NnQ
 OsDcoof+1Vh27w8lVP186oygdRNYqLvIE1vs9ifMJZapnWrPbbFQ79HYl9OY+nS2JdqAE06A6Hj
 vvRRz8R6kfCnowm3pj9LvnRTcSKuloY5AuvwcgF0vqpzi0MeodvVAjEVnE4zXx89V5zoBOoWCCT
 y3JPlg3p7fHfyhyI0yfZL9EFDLc24rLEdVISCLc67qOBwAmHj1Bb21CfBN6BnQzsft/+bhpMucF
 9fVNFhEHAJd/1c6j46vYzMXLOssCSne+RwiBAJfGkfGANb5oF126fHTwS3wYoAQ8UBe8kYTJFSR
 APxiQjqcFkRUoJ228iVw1TZzrjlS0rrsodImgT3VT9uluwbmZwflgxq5WQN+FXVNjleRZQ32WUz
 7iqzQMKmV4P5k74GLeYqSoVOcV1tDuWgcBcUkz6APY5VF+AeCqM7NoeGIICIWNMJJjcFPHOOCtT
 qk6vSjoWuVXSt62Xl5iVi/cvJSxMOxTyTyRozgDS04DOb8p7C39gewH7M2A2XM9TdftpZhxuKR2
 UEfI5fQ3pj7qjCSHnPhALVrH5ABbSMaQXVYPC9KxgbsZ5i7+2dFQXx8jh0wC2ZU5Dn/fwPlN0/X
 pSqMQ6D R94ZOPOA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

This annotates several structures with the coming __counted_by attribute
for bounds checking of flexible arrays at run-time. As a note toward
applicability, had this mitigation been available already, the flaw
fixed in commit 6311071a0562 ("wifi: nl80211: fix integer overflow in
nl80211_parse_mbssid_elems()") would have already been unexploitable
(i.e. writes through an out-of-bounds index would have been blocked).

Thanks!

-Kees

Kees Cook (7):
  wifi: cfg80211: Annotate struct cfg80211_acl_data with __counted_by
  wifi: cfg80211: Annotate struct cfg80211_cqm_config with __counted_by
  wifi: cfg80211: Annotate struct cfg80211_mbssid_elems with
    __counted_by
  wifi: cfg80211: Annotate struct cfg80211_pmsr_request with
    __counted_by
  wifi: cfg80211: Annotate struct cfg80211_rnr_elems with __counted_by
  wifi: cfg80211: Annotate struct cfg80211_scan_request with
    __counted_by
  wifi: cfg80211: Annotate struct cfg80211_tid_config with __counted_by

 include/net/cfg80211.h | 12 ++++++------
 net/wireless/core.h    |  2 +-
 net/wireless/nl80211.c |  7 +++----
 net/wireless/pmsr.c    |  3 +--
 4 files changed, 11 insertions(+), 13 deletions(-)

-- 
2.34.1

