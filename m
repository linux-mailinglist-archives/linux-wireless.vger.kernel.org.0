Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 523B56B5CC6
	for <lists+linux-wireless@lfdr.de>; Sat, 11 Mar 2023 15:21:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230293AbjCKOVQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 11 Mar 2023 09:21:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230301AbjCKOUc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 11 Mar 2023 09:20:32 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FA6961A8E
        for <linux-wireless@vger.kernel.org>; Sat, 11 Mar 2023 06:19:05 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id p16so5170058wmq.5
        for <linux-wireless@vger.kernel.org>; Sat, 11 Mar 2023 06:19:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678544343;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YSv+F8AGnMXjXqhp1B4cRj+J6hg1Z08xLn6d3o932LQ=;
        b=pqTPBIqlQmhhWfr9exbwgOXz13QsNKSDh4DDBy7wfYunvShHebTbbMQZkCUK1PUJ9V
         CDacBIhgN7/A2dDMWyb9B6aMAbtZ7AuK45jJHDwVK/PWVQ6XnXkie1X/YlA1GqH3p3i5
         XqzVIfTazohn7zZLD72lXMJu8wMu0bMpt8rDlPPMVayOWhGdufrS1NiTEjgJjkdSi9iG
         pCldmqQumo0E0rGkyZeK8fLpLJJ549M8YXNlx6sn1xJCm7mrWuxucfuSHotNbr7wSQXJ
         lIsLNoTnRdHqbfesV4kC1u6yLfjbjy31oYSZRpf6paVGMndCY3QnpnvjJxmzFvIG8D8e
         2LfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678544343;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YSv+F8AGnMXjXqhp1B4cRj+J6hg1Z08xLn6d3o932LQ=;
        b=SBqO+P6g8RrcK/OVCg4C29zhi23uzuXSDhH6HknZ7Jvl0gnaQABohk29V/OB5M0BLr
         mojlLz8JB9J12mMDwFKJ9bj0koLNCdgRuFnXAk9dC8Rm3mvcMRXvliLL5X/A6dr6Tk9c
         zGRK4Taw8z5hb+m1oK42Rus1dMhiiFe/ntyqQQDiFlLwj6aAEatg0vxkgPK15Xs5JyXU
         8bFfQZ0G4p8/a26yP/a/NqUhVNEJZ35v8MwKgBc2BBlAy8MLAXigPjXFu4/eZ47op96d
         NEZZN9TFbh+C0Jkmuar2qG/ShmkBGoQIUC3vHHJ77s7fm4KW2gqUhqveIUfPso/4HbF/
         THtQ==
X-Gm-Message-State: AO0yUKVsUOl0dzA4QeK5Gsn/40qt6syjWjHeKlPFnJuJjh7j7Q/aECVN
        CK3mfS3ZSbsG9OlDkwgF5WNcjJw77rAt5g==
X-Google-Smtp-Source: AK7set/NVC3KXZtclEGBBSospw8sOCkrPO6WlGGSq6zHL3iy5XoIJFtFrzG8nFyqvJhlhlv3aH2fxw==
X-Received: by 2002:a05:600c:4751:b0:3ea:f73e:9d8a with SMTP id w17-20020a05600c475100b003eaf73e9d8amr5756221wmo.30.1678544342776;
        Sat, 11 Mar 2023 06:19:02 -0800 (PST)
Received: from solpc.. (67.pool90-171-92.dynamic.orange.es. [90.171.92.67])
        by smtp.gmail.com with ESMTPSA id n6-20020a7bcbc6000000b003e21f01c426sm3020623wmi.9.2023.03.11.06.19.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Mar 2023 06:19:02 -0800 (PST)
From:   Joan Bruguera <joanbrugueram@gmail.com>
To:     linux-wireless@vger.kernel.org
Cc:     Alexander Wetzel <alexander@wetzel-home.de>,
        Johannes Berg <johannes.berg@intel.com>,
        Hector Martin <marcan@marcan.st>
Subject: Re: [REGRESSION] Patch broke WPA auth: Re: [PATCH v2] wifi: cfg80211: Fix use after free for wext
Date:   Sat, 11 Mar 2023 14:18:54 +0000
Message-Id: <20230311141854.137375-1-joanbrugueram@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <d6851c2b-7966-6cb4-a51c-7268c60e0a86@marcan.st>
References: <d6851c2b-7966-6cb4-a51c-7268c60e0a86@marcan.st>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

I can also confirm the regression with the (out-of-tree) broadcom-wl driver.
As Hector said reverting the cipher_group / n_ciphers_pairwise lines is enough.
See: https://gist.github.com/joanbm/fb90f4807b719a2e37a496936faabec9

Regards,
- Joan
