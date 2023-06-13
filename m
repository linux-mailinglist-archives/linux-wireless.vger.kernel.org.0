Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38D9672E988
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Jun 2023 19:29:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239655AbjFMRXL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 13 Jun 2023 13:23:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239148AbjFMRWa (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 13 Jun 2023 13:22:30 -0400
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B36101FDC
        for <linux-wireless@vger.kernel.org>; Tue, 13 Jun 2023 10:22:04 -0700 (PDT)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4Qgb2Z3PGHz9sSw
        for <linux-wireless@vger.kernel.org>; Tue, 13 Jun 2023 19:21:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=espindo.la; s=MBO0001;
        t=1686676918;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=i0Y/GVcmcSX1TK0hhx9IEod5ctrEmoe2zQTE7nbWutk=;
        b=AgiHL4ipFAa7LxQCckMdbwMnDxqXvsFYtsRe99GVVZvbAb26mel55DEsTZvVIdVIvt5WQA
        cQ9AKyPFhbj+nQ3l++yGK5jTYvq8nzhLlJgYDIZwdDjZYT/t12J/pKWvEW6XN0zqkdVNfK
        o4woe1CM7NDI1Y1QuVA2ks5PYA0ZujE0drNktznUV++ZA26y7uOs7/a6e1vKJ4RinEgJk5
        Uh3gcGy3uQWhgwsMc/cbpqJYGVwFJs7m1+ctxylg6yhe1REmgbbcBOFIgFdww2QOMErsAG
        3PPkt8I07Ysu2QPhcoaIG91wznSyb9ZsuedCpqwVIp467vn+oYh7KRok6UmG0A==
From:   =?utf-8?Q?Rafael_=C3=81vila_de_Esp=C3=ADndola?= <rafael@espindo.la>
To:     linux-wireless@vger.kernel.org
Subject: iwlwifi: Stops receiving unicast
Date:   Tue, 13 Jun 2023 17:21:37 +0000
Message-ID: <87a5x3b7mm.fsf@espindo.la>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

My laptop with an Intel 8265 stops receiving unicast packets after a day
or so. My current test setup has 3 machines in the same wifi network

* The laptop with the intel 8265 which has network problems
* A phone
* A desktop running wireshark in monitor mode

If I try to ping the phone from the laptop, the machine in monitor mode
sees frames going from my laptop to phone and back. This is the case
both when my laptop is seeing the pongs and when it isn't.

The wifi network is encrypted, so I can't be sure the frames have the
pings and pongs, but the data length is always 100 bytes.

When the ping program is not getting the pongs, neither wireshark or a
small xdp program on the laptop will see them either, so they are being
dropped at a lower level. Wireshark on the laptop still reports
broadcasts (like ARP) and multicasts (like mDNS).

I have had similar issues with both a 6.1.32-0-lts and 6.3.4-0-edge
alpine kernels, so I suspect a firmware issue, which is:

firmware-version: 36.ca7b901d.0 8265-36.ucode

Following
https://wireless.wiki.kernel.org/en/users/drivers/iwlwifi/debugging I
have enabled CONFIG_IWLWIFI_DEBUG and CONFIG_IWLWIFI_DEVICE_TRACING and
installed trace-cmd, but I don't know what to check next.

I have also reported this at https://bugzilla.kernel.org/show_bug.cgi?id=217535

Thanks,
Rafael
