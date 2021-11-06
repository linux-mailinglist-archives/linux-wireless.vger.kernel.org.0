Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AF3D446EF1
	for <lists+linux-wireless@lfdr.de>; Sat,  6 Nov 2021 17:29:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234557AbhKFQbp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 6 Nov 2021 12:31:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231658AbhKFQbo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 6 Nov 2021 12:31:44 -0400
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [IPv6:2001:67c:2050::465:202])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87C53C061570;
        Sat,  6 Nov 2021 09:29:03 -0700 (PDT)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:105:465:1:3:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4HmjVy1zQ3zQkBL;
        Sat,  6 Nov 2021 17:28:58 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
        t=1636216135;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=PZ4kkfynZudBA6x5CzdSYa/sTNo6et8L/IlL/tHsv2c=;
        b=CKn2ghVEvL76onl6imviK2jW9i4SxJDGKzNcdVqjKOlqk+UpipKy8xhDYeXNFg6C6XGN/b
        PvtgMwNv7fmpvqieoC4FENvaNxl3SlZ79a/UZAMbVULf49jxglxwCTzFivmrYnRHVXdxhV
        LzNV8BXX5WmxHLOq2iTdMozC8rNe+KVju/YuHMvgGDx/4Cgxf/2oP15uuN7JMIknyuw/Qs
        O8NpJWkjIryrObMcahHTacVF3IA2I4/VW6oK6ENnMSMyLVMZ8EJOIaPusw8914nSGvB0o1
        MTmA7PYdReCPnUpaC+Yn5veAqIQHT5CDSRMIBJnukhQw/jf1jQOVTPscIEGg7A==
To:     "backports@vger.kernel.org" <backports@vger.kernel.org>
Cc:     linux-wireless@vger.kernel.org
From:   Hauke Mehrtens <hauke@hauke-m.de>
Subject: wireless backports 5.15-rc6-1 released
Message-ID: <51da80fc-5d72-3bbf-2798-acb124aa8e94@hauke-m.de>
Date:   Sat, 6 Nov 2021 17:28:53 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: C188556A
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi

backports-5.15-rc6-1 was released. This is based on Linux 5.15-rc6.
https://cdn.kernel.org/pub/linux/kernel/projects/backports/stable/v5.15-rc6/backports-5.15-rc6-1.tar.xz

All versions after backports 5.10 will only work with kernel 4.4 and 
later, support for older kernel versions was removed.

There is now a updated wiki page with the releases:
https://backports.wiki.kernel.org/index.php/Releases

The source code can be found here:
https://git.kernel.org/cgit/linux/kernel/git/backports/backports.git/

Hauke
