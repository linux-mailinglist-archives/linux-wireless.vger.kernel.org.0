Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA4147565B5
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Jul 2023 16:02:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231145AbjGQOCw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 17 Jul 2023 10:02:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbjGQOCv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 17 Jul 2023 10:02:51 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB8BEBD
        for <linux-wireless@vger.kernel.org>; Mon, 17 Jul 2023 07:02:50 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-666edfc50deso2713160b3a.0
        for <linux-wireless@vger.kernel.org>; Mon, 17 Jul 2023 07:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689602570; x=1692194570;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fvHDF/tX78O6/RyEhYiGIXcYSL6N5wva7LECII5yNVU=;
        b=I1t0n+/KyqNFgNzawyXXqBIoyr5H62Z7UFhqNFzC10vdvCuUTcgntMJDJQtXXyebGz
         Ea3M10Tsw4kCXZ63M+ozIY6JEX2X4N6jipMIoAYT9mVPcFKFleWfOsx5ge49pFHWrGSK
         zCENAXcG+DgvV6jkIhrivndMcOBzv4JrpQvYwyhiNAhX1gupVVm2fIKN1dxiSyk5t6Pi
         /Yi6fsW0T8+KU+4j6K/ITgg7P6Hpen0O27K8ubbfZY/LYLBnn/BWryJNjCjQUAeJrVAg
         /i5u61Ob0j+Pv6Mpj+g1PifdNtXdDjvsMyorMd6SYkHJLa2Pr/guhE6ywqeToZa/jrEf
         aUtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689602570; x=1692194570;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fvHDF/tX78O6/RyEhYiGIXcYSL6N5wva7LECII5yNVU=;
        b=V69srcjrH/1s4cWt0zOgLnrLL1lsfUE7XY8P1n+RMDVItefCYqij3FNj/gbtOGnced
         Xm1sj8e/75m3JlOCuALMkkRmdYmn0VZJo/8i6xtlGq4exjJU1gnSKTdM+r13CwWfZB6q
         RwEixQbxjKUBiRMhyZz0WkMDBLaXEY3EaiZIUSduJ0159WNu2MdWWkiDuD8ZziDrrUP8
         oawTvC7g8h0lxlxovdFOHM2lklbRf2zrpq1PR8s9CbVmSnKbi8av25yaunkiL/+JXDir
         KJz98IAruisJxXlRWbVcleD1q2WZsN+bHuW0dm4Jr0L1OwoJikIQRY07m5sQXC55Ro0X
         SkAw==
X-Gm-Message-State: ABy/qLZwndZIFmpR7dAy89rLaByRo9NSfZ//CbtKoAnpTlbZWfxR1+Sd
        QjfupXc2MgWtE+jNRZI8aiw=
X-Google-Smtp-Source: APBJJlF33zba/N5qdY7LQMFro/pNEauGIWiav37oTzqwNB5AXXurchZz/jWSvlT6zTF4shhlCUdyEA==
X-Received: by 2002:a05:6a20:3d91:b0:134:3a9b:4cd7 with SMTP id s17-20020a056a203d9100b001343a9b4cd7mr6653440pzi.23.1689602570125;
        Mon, 17 Jul 2023 07:02:50 -0700 (PDT)
Received: from localhost.localdomain ([221.231.171.18])
        by smtp.gmail.com with ESMTPSA id ey24-20020a056a0038d800b00666add7f047sm11950013pfb.207.2023.07.17.07.02.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jul 2023 07:02:49 -0700 (PDT)
From:   Polaris Pi <pinkperfect2021@gmail.com>
To:     kuba@kernel.org
Cc:     pinkperfect2021@gmail.com, kvalo@kernel.org,
        linux-wireless@vger.kernel.org
Subject: Re: [PATCH v6] wifi: mwifiex: Fix OOB and integer underflow when rx packets
Date:   Mon, 17 Jul 2023 14:02:32 +0000
Message-Id: <20230717140232.3978004-1-pinkperfect2021@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230714224809.3929539-1-pinkperfect2021@gmail.com>
References: <20230714224809.3929539-1-pinkperfect2021@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Jakub, 

This patch has been reviewed by chromeos wifi team, and review tag has been added by their tech leader.
Could you please review it again? 

Thanks!
