Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14FC16439C7
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Dec 2022 01:06:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231923AbiLFAGL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 5 Dec 2022 19:06:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229938AbiLFAGJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 5 Dec 2022 19:06:09 -0500
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [IPv6:2001:67c:2050:0:465::101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92A7C1CB2F;
        Mon,  5 Dec 2022 16:06:04 -0800 (PST)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4NR10N05DGz9sQ3;
        Tue,  6 Dec 2022 01:05:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
        t=1670285156;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=d6wfyfEMTjHdepb1uHN+bjxT+QCsupY5nHQSJAHQBes=;
        b=P+qGcCSPKqXN2/iwDUx4MyFS9zsybKd82gN8LCDT2b5bbMK3O+rHBOWPypPoP/FaJ9yLuo
        LIRfDlNBwoqJB+aEq+JAlw13mw7gBqAWSmBM4IDE4TocFC+iANF/33qZnDVHD+nq+tyb2C
        a7fm0XL6cdSk78i9a7B1F7noTew2YUsfuuOuP3tdX3HJ4ZXGroupTPtRwfjhn7/326f8xy
        oXcfj2eQuf5m4CWeAZuLCjfafTevbUaCWceeI1WPCi4wmxSdGzaWufJMNxymmwDZXb8dXq
        Z45FwL6UPiSMwbCyd8DATX4+LcwV1n4bqnDdmJEtu+79LaOWVKo2i9S22wVWfw==
Message-ID: <57da6fbb-7f64-b8ef-7701-4cc939c7a72f@hauke-m.de>
Date:   Tue, 6 Dec 2022 01:05:50 +0100
MIME-Version: 1.0
Content-Language: en-US
To:     "backports@vger.kernel.org" <backports@vger.kernel.org>
Cc:     linux-wireless@vger.kernel.org
From:   Hauke Mehrtens <hauke@hauke-m.de>
Subject: wireless backports 5.15.81-1 and 5.10.157-1 released
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 4NR10N05DGz9sQ3
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi

backports-5.15.81-1 was released. This is based on Linux 5.15.81.
https://cdn.kernel.org/pub/linux/kernel/projects/backports/stable/v5.15.81/backports-5.15.81-1.tar.xz

backports-5.10.157-1 was released. This is based on Linux 5.10.157.
https://cdn.kernel.org/pub/linux/kernel/projects/backports/stable/v5.10.157/backports-5.10.157-1.tar.xz

There is now a updated wiki page with the releases:
https://backports.wiki.kernel.org/index.php/Releases

The source code can be found here:
https://git.kernel.org/cgit/linux/kernel/git/backports/backports.git/

Hauke
