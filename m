Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC65F59BA7C
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Aug 2022 09:45:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233366AbiHVHot (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 22 Aug 2022 03:44:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233364AbiHVHof (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 22 Aug 2022 03:44:35 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82CAE62D8
        for <linux-wireless@vger.kernel.org>; Mon, 22 Aug 2022 00:44:14 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id z20so12680168edb.9
        for <linux-wireless@vger.kernel.org>; Mon, 22 Aug 2022 00:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mind.be; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=hRbZvLq0dRvFCFckN7VFnkQ6eqmxMxPLIXEHlD4vNe8=;
        b=T6d2X4EgTIi0NkbQMzkDPnQnzjTIoSwk9Jiv3TT5+yHlzreNWvC4wYbbjoVvKCVpEA
         GCH4Hj0zB/TyTPuZzJC1k32x6CYaiT9yKSjTmc5klWlK3fCsw0/EcqW1DlvHMnHXIu84
         4YvMB2ja3DF8kCbbi7L+6dARwh64zCOg8jBzuhjeOrPmWstDZgyCPV4T7Xo4+aIggIXD
         8w+O+Dyw7jbbcrShEyNk86P/HIHKdrH/u4I1xyLdXMEuRPycYH5Wf3UIWIMj5aw2rGID
         Fs4fE7IbV0wXB1PG9dHfv3sIZuBu0OfdHi/ZlCndJOh86TRvd1LR2smpD+84fR61Quco
         7C+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=hRbZvLq0dRvFCFckN7VFnkQ6eqmxMxPLIXEHlD4vNe8=;
        b=cleBn4aoYd9V12eHpgk9IYlIwcLqIRzAqoRzajUHxorlQpjBihiZXEkH70ZTgpv+fs
         /T6U0cIpkzLnVfbvCoJPFg/2WsurcDHP1fWFsa/YsvSersqSaLLhrdb51LZQmcJOlJw1
         oYWp8DlRUT9OkkHheQ7uIJNDHsY70w9OwD5gsrZH8gi3Z9KXPIcIelperQ14/vc7GqdP
         pQ5DvOwtkBzVwHdWFD/U08ZtlYCYE86gsZqYJkq/kpCt7/NdzbLANTuQE8G/OUAbjwUt
         FQoxWTiJhIryyH5wM8W+FUnKFdlt3x1TfaYMiZccc+dadlEPtPux1C6gduCU4bzugBUb
         GkXQ==
X-Gm-Message-State: ACgBeo27ujA1zwjMeop9dRWcABetudra6FLpWf2XgQLrniC3IlLRPwvp
        +P/eVpcPG3lk7bBVA6/+T9575w==
X-Google-Smtp-Source: AA6agR5Wg/50+4a+B0z/1Iq6LrGO4Ny79zsEaQMKdHcXvbDF3zlkdyB9466ZQmZCchqq4+/pnzffAQ==
X-Received: by 2002:aa7:da19:0:b0:446:6c5a:7127 with SMTP id r25-20020aa7da19000000b004466c5a7127mr8241491eds.131.1661154252853;
        Mon, 22 Aug 2022 00:44:12 -0700 (PDT)
Received: from debian-hp-1.fritz.box (213.211.136.215.static.edpnet.net. [213.211.136.215])
        by smtp.gmail.com with ESMTPSA id w21-20020a1709061f1500b0072eddcc807fsm5789771ejj.155.2022.08.22.00.44.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Aug 2022 00:44:12 -0700 (PDT)
From:   =?UTF-8?q?Rapha=C3=ABl=20M=C3=A9lotte?= <raphael.melotte@mind.be>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        =?UTF-8?q?Rapha=C3=ABl=20M=C3=A9lotte?= <raphael.melotte@mind.be>
Subject: [RFC PATCH 0/1] iw: add support for retrieving keys
Date:   Mon, 22 Aug 2022 09:43:17 +0200
Message-Id: <20220822074318.291949-1-raphael.melotte@mind.be>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello,

I couldn't find a way to retrieve keys and key sequences using iw, so
the following patch adds support for it.

I wasn't sure whether I should include the (new?) nested NL80211_KEY_*
attributes, or only the global ones. In my simple case any of them
would do, so I included the global ones only.

Kind regards,
Raphael

Raphaël Mélotte (1):
  iw: add support for retrieving keys

 Makefile |  2 +-
 keys.c   | 77 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 78 insertions(+), 1 deletion(-)
 create mode 100644 keys.c

-- 
2.37.1

