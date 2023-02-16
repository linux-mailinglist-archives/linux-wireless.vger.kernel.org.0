Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24BEB699E7A
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Feb 2023 21:59:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230007AbjBPU7h (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 16 Feb 2023 15:59:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbjBPU7g (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 16 Feb 2023 15:59:36 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A6DE505F0
        for <linux-wireless@vger.kernel.org>; Thu, 16 Feb 2023 12:59:33 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id z6so2081300pgk.0
        for <linux-wireless@vger.kernel.org>; Thu, 16 Feb 2023 12:59:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eyV6xJBHPKWzSKdk5A+Tg4UCGONUmKhfgJpQXI3S1og=;
        b=GFZ2g8ZavT0maXKM5cgN9q+An0Xw+I2Rdjq/66h1PnipV/b82hxMi4VFd+X5BYyBsL
         pZIxvwFMVwQNPf25sYxf480kzDBvOWTJO7PzLDkU8yXXtB3ypM6yMJ19yb6iWNeMVeZ5
         WoCCq86o0ZbqHlo+l6ZTS1dMqcaMQ6A5Nfwp8QFpp9Gl/1Wu5ZXn7DvA5Tqglnf4HqYr
         ZT8RAq7V5QonsPkfyw0YD4+O4LZjtxfswx0h3CeL8fwzq47UI9GHYFdn66xv/rx9W/Jn
         S9Xw2rDjZ7XgRCbyCkkRBwwG86C2RvBT4tt1GUR7FLB6uU53zRs9crjWNxT/7xd1JJNQ
         EgIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eyV6xJBHPKWzSKdk5A+Tg4UCGONUmKhfgJpQXI3S1og=;
        b=SJFYSdrf/vbuoUsZL1Bs5V05QWKQHDhy+PZJf4XMnin7tHTfauu2TpZnN10LqfsIR6
         cHbLRRILR5ZOnDSa+q91crCngHK21lqfv97rEZSnnSAW/RlY1e5y3e+sOHmdFOwcTJUz
         dtkyzpI1SqxumrTctUfG915VCJZn1pX8FfYLXOCKkq0n/lsd24qTlwcJ8AbpRhv+WFq/
         fNdzy77eAqcZnZ0rRImLy9cWFlMXw9ypQoEmxw2bTq3OwRx7iyWWBHELxVZZ7k/pKthd
         ye6Wv/RLuSjkhIyNpZzC+C5VaOx5CQBFBcZDbGG/Hcx6up/Xc5id15HzdBH+3WnzKj0V
         YWBg==
X-Gm-Message-State: AO0yUKWpY+5nbapK5Dp8SELrnV2b2zgQCDZubdQMwHMzsSDRLSAu3Laq
        U1lNMWwHEyhoZod0XjSALDE=
X-Google-Smtp-Source: AK7set/UG/kgibfpRrRI9yGmMRG9QgxRfRyVg9HmzOaBrpMJlkPxfvWJImxUO/81ZP78c5SVJQdhCQ==
X-Received: by 2002:aa7:970c:0:b0:5a8:a420:72f7 with SMTP id a12-20020aa7970c000000b005a8a42072f7mr5776075pfg.7.1676581173032;
        Thu, 16 Feb 2023 12:59:33 -0800 (PST)
Received: from localhost.localdomain (2603-8000-0b00-9100-f4e1-a6f1-652b-cfd4.res6.spectrum.com. [2603:8000:b00:9100:f4e1:a6f1:652b:cfd4])
        by smtp.gmail.com with ESMTPSA id k26-20020aa792da000000b0058d92d6e4ddsm1712112pfa.5.2023.02.16.12.59.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Feb 2023 12:59:32 -0800 (PST)
From:   Anthony Refuerzo <anthony96922@gmail.com>
To:     anthony96922@gmail.com
Cc:     linux-wireless@vger.kernel.org
Subject: 
Date:   Thu, 16 Feb 2023 12:59:24 -0800
Message-Id: <20230216205925.10091-1-anthony96922@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


Signed-off-by: Anthony Refuerzo <anthony96922@gmail.com>

