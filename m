Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE56864A435
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Dec 2022 16:33:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232512AbiLLPdu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 12 Dec 2022 10:33:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232528AbiLLPdi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 12 Dec 2022 10:33:38 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A7311005E
        for <linux-wireless@vger.kernel.org>; Mon, 12 Dec 2022 07:33:37 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id bg10so5768602wmb.1
        for <linux-wireless@vger.kernel.org>; Mon, 12 Dec 2022 07:33:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZIxktvDnzAq4COgkYt0knjrMZ3maL29etVrhbwvLz6A=;
        b=IcF8TFB+DErdN4WwpbhKskKdBkaaHZ2tnSM7M1T+c9gzY+zPQRLzTNqpl4rajH0eJ0
         ik07M5mZG4Vd3Ik/OGd17u3Gbj58KWQLkrBUgMpvQk+D/gyAN27oADfT7hzreLe9oryj
         uQ7gOsNL+RXaUIZLCurN/qg4ekUjX7jTRPuvvNzpat+HDdSgLnLhP5LlShyTvw8mCphQ
         gHbDPQTog+K26l9K4o271Q7gm5L2P01h2BPzW5NjY9wKOHCqxaVwMOrMwGrSR+vbDgmz
         jTAm58zEwkueNtzC8z0zAk9XHqH1wpqgcSMxZjrTLSv5FYPbLMgtTxENs/6UVzwr2vgs
         4+pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZIxktvDnzAq4COgkYt0knjrMZ3maL29etVrhbwvLz6A=;
        b=YQufjtGqFh6mhBvBRWy8IA/VZUrPkrHOx/yzV8T3sQQBNChdhRh5ly2dUgaLN/x4Da
         +TFsYqxdx+HH9Kdt6LqF81B/GloFwijcBzbYduqzOrUNAoZBV9su78ioPYkj8X0C9uoY
         SvnHHK/Qnv/tP0PdLvPxzHVFo4gVYkEcDMUGR/hy3e3DlEel36QB7a2rrctmonWwN2Kj
         787+mhpGuS2cXu2pgyVhMkG6D8ZJ8vxd1gFOVwq+ELc1SDODZsuBr4xg5XZQRVDGC4lV
         IYYNNUzqrCPJxdMe6TdVwtcwr0+bPYmOQqfl3kGqyTaVd9Y0E3/iKJx7VKCPMsvy+hvc
         iwXA==
X-Gm-Message-State: ANoB5pl2Zg6gBW0iC8epf+C4BtjjVtJAEiJrJurAyW/FZKOSw4M2PoF8
        MjjA8UWBK5bLE/YiTO5O/Ok=
X-Google-Smtp-Source: AA0mqf6/GiTDx7JILus/PTMjQTbpu0eFZb1gmP6UB+Uus1lG3t+V20HXy/PLyqWE1gbLfmDou4xb9g==
X-Received: by 2002:a05:600c:253:b0:3d2:17a5:17fe with SMTP id 19-20020a05600c025300b003d217a517femr6720181wmj.18.1670859215716;
        Mon, 12 Dec 2022 07:33:35 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id t123-20020a1c4681000000b003cf87623c16sm9758516wma.4.2022.12.12.07.33.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Dec 2022 07:33:35 -0800 (PST)
Date:   Mon, 12 Dec 2022 18:33:30 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     pkshih@realtek.com
Cc:     linux-wireless@vger.kernel.org
Subject: [bug report] rtw89: add Realtek 802.11ax driver
Message-ID: <Y5dJymTl15fBnQtV@kili>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello Ping-Ke Shih,

The patch e3ec7017f6a2: "rtw89: add Realtek 802.11ax driver" from Oct
11, 2021, leads to the following potential issue (just from reading
the code):

drivers/net/wireless/realtek/rtw89/core.h
    3878 static inline u32
    3879 rtw89_read32_mask(struct rtw89_dev *rtwdev, u32 addr, u32 mask)
    3880 {
    3881         u32 shift = __ffs(mask);
    3882         u32 orig;
    3883         u32 ret;
    3884 
    3885         orig = rtw89_read32(rtwdev, addr);
--> 3886         ret = (orig & mask) >> shift;

I think this line should be:

	ret = (orig & mask) >> (shift - 1);

A typical mask here is 0xff so __ffs() is 1 because the first bit is
set.  This code will do: ret = (orig & 0xff) >> 1;  I think it should be
ret = (orig & 0xff) >> 0;

If the mask was 0xff00 I would expect >> 8 instead of >> 9 etc.

    3887 
    3888         return ret;
    3889 }

regards,
dan carpenter
