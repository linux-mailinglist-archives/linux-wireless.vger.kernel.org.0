Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90EBE7E2A89
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Nov 2023 17:59:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232875AbjKFQ7w (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 6 Nov 2023 11:59:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232477AbjKFQ7v (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 6 Nov 2023 11:59:51 -0500
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B037C1BC
        for <linux-wireless@vger.kernel.org>; Mon,  6 Nov 2023 08:59:48 -0800 (PST)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-1f03db0a410so2948029fac.1
        for <linux-wireless@vger.kernel.org>; Mon, 06 Nov 2023 08:59:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699289987; x=1699894787; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:sender:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RRaQCB+WAyZCRxwh3nGzG4C9VXbodi8S/JIQ1w8O7Po=;
        b=MppJ/Q45BIerDqLwsaSm/laSAND2L4vdFx7SPEwViBo24hYlOxuVD8c7VSQyx1SU4X
         XRcoqKMgKahrdNo4YjEDDzADu5utcBSjPuqS+sTWvLeQ6klyhlMT+4tzpbBA1SxhmihO
         VhHCk0NKEdERoatF3g7bqoRC83Wwb8j7gcuBdgLCNjDfFubENYgQE/OyurNB6TPce51N
         bI3kccwoVXHSESXArfdwVEoBqDbini1iXBmNaowhnTaj9LN78tIN+YkRUa1kRtD1CsqG
         faMWc7RDQryOw3ojKFxw5gzQtmboOh+Dk+DTn2eC18wXcQsL8dogpyo5fCI4pPgZnXic
         I5iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699289987; x=1699894787;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:sender:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RRaQCB+WAyZCRxwh3nGzG4C9VXbodi8S/JIQ1w8O7Po=;
        b=jahDNgUnuamyvrPXm7kml+NnaCUJ22CHvcY9729AXnxY5uMtnvMOtGbZ7kp5Pfh9T5
         l6n0zgHEbQ/ACujZr9chcI8J7cNQQ9/G1WpFaUCzSKcBNnlblIeFjuljXHv9lJQ7BBlI
         lcWXvXkEOietY/PtPZwLfLXzGn2GC2/Q4JC+EL/whqHaBvSC+meH99Ao3Er9d03+tfah
         hgMPMd2fFgusqi3ptVVmF0IjyHnhtxRrxqyW8wnHX4Wirs/S9gCk/ey5lT67S08tpvKl
         uwssFni282Qrc95OVV000BXA4GhZUjrYCWvro8oT9XvI9Z36pGLFGPCGhVL4ZrOJkR6C
         yz3A==
X-Gm-Message-State: AOJu0YzWLJavgjeQijiAXNLHBO9Hsn/C2WvttrJoNKekK7JCEJ+FuEGG
        mfyXQbnllss/5K+jRqGpiksHqZko4BQ=
X-Google-Smtp-Source: AGHT+IEOp41g8n5cGTj1t37rhV8hBULVBN8tqWQFh3wavlFONqlB/yCh4XsJx8eEhYWOHDmfrjy0iQ==
X-Received: by 2002:a05:6870:9126:b0:1ea:1e74:c377 with SMTP id o38-20020a056870912600b001ea1e74c377mr294433oae.36.1699289986941;
        Mon, 06 Nov 2023 08:59:46 -0800 (PST)
Received: from [192.168.0.162] ([216.130.59.33])
        by smtp.gmail.com with ESMTPSA id y1-20020a056870e3c100b001d6a92f79dcsm1478072oad.2.2023.11.06.08.59.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Nov 2023 08:59:46 -0800 (PST)
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <68dd07cf-538f-46b8-8979-b9b9c98a3ea6@lwfinger.net>
Date:   Mon, 6 Nov 2023 10:59:45 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To:     linux-wireless <linux-wireless@vger.kernel.org>
From:   Larry Finger <Larry.Finger@lwfinger.net>
Subject: iwlmvm spams the logs with kernel 6.7-rc0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

Since I switched to kernel 6.7-rc0, also known as 6.6.0-git+, my log is spammed 
with the following messages:

[53181.545583] iwlwifi 0000:04:00.0: Failed to create debugfs directory under 
netdev:wlp4s0
[53596.526017] debugfs: Directory 'iwlmvm' with parent 'netdev:wlp4s0' already 
present!

My Intel device is as follows:

04:00.0 Network controller [0280]: Intel Corporation Wireless 7260 [8086:08b1] 
(rev 73)

Thanks,

Larry
