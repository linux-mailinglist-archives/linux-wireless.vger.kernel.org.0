Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D98FA68EB17
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Feb 2023 10:24:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231230AbjBHJYI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 8 Feb 2023 04:24:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230027AbjBHJXl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 8 Feb 2023 04:23:41 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BD9B4615D
        for <linux-wireless@vger.kernel.org>; Wed,  8 Feb 2023 01:21:28 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id r8so18600165pls.2
        for <linux-wireless@vger.kernel.org>; Wed, 08 Feb 2023 01:21:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hepV+iTFGvGf0KOoVbxamkm2Qn4YoUyfI8ES6rKF0wQ=;
        b=XMekQefXbAbNsDMcE5b4jruf9kzjSspmT16DCmGi/2sXzkY/8VluuSxpiQVv6A9mL9
         1nB0fUSBLXJmHr+PQghDbygBUbCadtr9mf9GrpbvVSUOKNRqnENLUgxI3JFczegP/y+c
         YuqFHLU+njnZPEG3mGIP+6BsgwXdRxuiUFIkgqfGbj0sgW01c3pm2iA28rQCX83yCWq4
         Lnh1/o4yTbfb2ETILJtAeU/tIQY1zQS1TSox+zA9hv24IJD+vyL7bV2X+5CsLYq8yTuK
         +3iUmoIGZrsOjSx7Gjp1Hti9XIH0xnXunkkV0tDSnPdBLJ7rTuc+glNMewQywmLxlGst
         a+kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hepV+iTFGvGf0KOoVbxamkm2Qn4YoUyfI8ES6rKF0wQ=;
        b=jFC4VAz6RuUwc5hcWKOHsHP5TTQi968754jNoAugEnARqxG2dZicdtWqBVDlvrLwvh
         pq4xD46WEUnTFyVQPkBNhxgflZ8jbmuiBE7FXKbtB5XQ9JSyKeUZRRwD1/iyIOa2Mps9
         wLzT8figSJMX+3RmDV5UUZT+zmlsj30MLFSq8knRPUmycw4Qlui/9YYgfpe1iGjNYAya
         HKMm34foS995PhxjarMPixcOJvyHmEhFlONaHBc5h9ffAxZtgo6Z35NkUpopgBaWU5QI
         Vl/dKsZDAa45AI+ZTEZzIdIB5cZg3kpbNGOtsnjPoSz2v1YpUDTlKnU3Wc12thpiYUH+
         391A==
X-Gm-Message-State: AO0yUKUw06XPDtGGoy7DCHlv5KcgVSJjBVEHl/1m0L1D1Cr4wAcAEXtK
        Kto+Yh+bqZiBNAwbqAFXRjM1mOFoStxAafVhW8iQBCwuAIh0
X-Google-Smtp-Source: AK7set9IKsiswN7GrBYf63uFmNmmP5WE3AlGA9S0YHpX85C2gs+lyzPl5Xe5f16AEwCtilmDO9nEHAWsMonX8kbbWOk=
X-Received: by 2002:a17:90b:fd1:b0:231:714:da9 with SMTP id
 gd17-20020a17090b0fd100b0023107140da9mr640810pjb.40.1675848087638; Wed, 08
 Feb 2023 01:21:27 -0800 (PST)
MIME-Version: 1.0
From:   Arda Demir <ddmirarda@gmail.com>
Date:   Wed, 8 Feb 2023 12:21:08 +0300
Message-ID: <CALDHRCt5KUezfEZCOWK+zYPM1hP32qwZqcoKw09ZjNw=oQoWKg@mail.gmail.com>
Subject: hci0: Malformed MSFT vendor event: 0x02
To:     gregory.greenman@intel.com
Cc:     linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello,

First of all, my bluetooth adapter is;
04:00.0 Network controller: Intel Corporation Wi-Fi 6 AX200 (rev 1a)

I see the following message everytime when i boot the pc on tty.

"Bluetooth: hci0: Malformed MSFT vendor event: 0x02"

But bluetooth works well. If it is not critical it shouldn't print on
tty, right?
