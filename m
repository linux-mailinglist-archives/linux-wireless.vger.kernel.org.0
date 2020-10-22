Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA679296184
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Oct 2020 17:15:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2901276AbgJVPPA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 22 Oct 2020 11:15:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2509904AbgJVPPA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 22 Oct 2020 11:15:00 -0400
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [IPv6:2001:67c:2050::465:102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DDE4C0613CE
        for <linux-wireless@vger.kernel.org>; Thu, 22 Oct 2020 08:15:00 -0700 (PDT)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [80.241.60.241])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4CH9ry3jKHzQky8;
        Thu, 22 Oct 2020 17:14:58 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=doubly.so; s=MBO0001;
        t=1603379696;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=GmK1EdkKAIkwuTB3sbxQGsAQiWFGLkcQ0W0MfvDd1Sw=;
        b=e5OTu+th/tGToyff/ZubChdqi4zRoLy+KvHmjeja41nV74g/FlVSoDaOImzWZWvb4p+yI8
        kUT1BYox2mHYsqpOYjEascFGHd120cfb1I5SkMHCRKHEnQdRXcGUcyYma1AyUK30fIszDf
        dH4Ubbyixa0+MuzirQEMm3/3ZMv33RKJTKQdzdPa+a660AMueV/MMpEZ1Ys8c07zcDT1fr
        akFSX1yfVNveZxny0jViMp5cQGARxOQFiZiVcBv++qnDvVvD5LaCdLha5OOEJSkHV9wuc3
        F1dtgn6btaHBHEa1FyBIIvQQOpxf31TCnQBxwTzhmf97pboD/s69YenZns1N5A==
Received: from smtp2.mailbox.org ([80.241.60.241])
        by spamfilter01.heinlein-hosting.de (spamfilter01.heinlein-hosting.de [80.241.56.115]) (amavisd-new, port 10030)
        with ESMTP id rbeTqO8aI4jh; Thu, 22 Oct 2020 17:14:55 +0200 (CEST)
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org, kvalo@qca.qualcomm.com
From:   Devin Bayer <dev@doubly.so>
Subject: ath11k with QCA6391
Message-ID: <c9fb5fa6-297e-a595-7670-c9105641bc83@doubly.so>
Date:   Thu, 22 Oct 2020 17:14:54 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-MBO-SPAM-Probability: 
X-Rspamd-Score: -2.93 / 15.00 / 15.00
X-Rspamd-Queue-Id: 665B3108B
X-Rspamd-UID: 774875
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello,

I have recently purchased some QCA6391 cards and I am going to try to
get them working with Linux.

I've seen the instructions for QCA6390 and I'm wondering if they will
also apply to QCA6391, or if it's possible to get it working without
major work.

Does anyone know?

~ dev
