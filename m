Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F6EC2A436B
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Nov 2020 11:54:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727470AbgKCKyD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 3 Nov 2020 05:54:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726312AbgKCKyC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 3 Nov 2020 05:54:02 -0500
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [IPv6:2001:67c:2050::465:202])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 318C3C0613D1
        for <linux-wireless@vger.kernel.org>; Tue,  3 Nov 2020 02:54:02 -0800 (PST)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:105:465:1:1:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4CQRVH1ZMnzQkHd;
        Tue,  3 Nov 2020 11:53:59 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=doubly.so; s=MBO0001;
        t=1604400837;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kKpROcG5w4Bx/HHrJX5qknPtYo6782fqCzZUw0Bczpw=;
        b=WBHPiQHizJBTCaCCvVBbm5c+mkXI7SBNaEGHjb5YnjNlUUm0/ZWCKkSMgBRdSFlJTN1uKC
        xTCxoKOSsomNOofvXnbnZv+4r719MnDP4DlLOdtAPI5ErwPm/0ixeEC/PTw26NykdKNCKO
        pgZfXi4Iq0tMyMe/uMyNYGsgUYJrsdfBhx5h4gdrvUPRqtdgEQLgwVUy74mTV47hj6Aank
        y7m3XlBJhEcKXLcU+X6s0I4EuziJN3rWlqOJHKBOvdFOYpghVbf5epgnRDVpvxMq0NyMDS
        j7kg/X2YLtghVCfPvpr/odaLHnFvtdpziCF7l6E26FAXTXxTgNGXrUxjOlLHnA==
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter05.heinlein-hosting.de (spamfilter05.heinlein-hosting.de [80.241.56.123]) (amavisd-new, port 10030)
        with ESMTP id JF6sJ1QlO3Es; Tue,  3 Nov 2020 11:53:56 +0100 (CET)
Subject: Re: ath11k with QCA6391
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org, ath11k@lists.infradead.org
References: <c9fb5fa6-297e-a595-7670-c9105641bc83@doubly.so>
 <87wnz3twvo.fsf@codeaurora.org>
From:   Devin Bayer <dev@doubly.so>
Message-ID: <5f3ee526-e96f-3c88-a17e-e7ebf9703ed1@doubly.so>
Date:   Tue, 3 Nov 2020 11:53:55 +0100
MIME-Version: 1.0
In-Reply-To: <87wnz3twvo.fsf@codeaurora.org>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-MBO-SPAM-Probability: 
X-Rspamd-Score: -2.47 / 15.00 / 15.00
X-Rspamd-Queue-Id: 3071F15
X-Rspamd-UID: 30695c
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 02/11/2020 19.51, Kalle Valo wrote:
> 
> To my knowledge, from ath11k point of view, QCA6391 should look the same
> as QCA6390 but most likely the board file for QCA6391 is different.
> 

Thanks. If I get to that point, I have been given firmware files from the
vendor:

4076546464 3602624 amss.bin
1400223385 57936 bdwlan.bin
1400223385 57936 bdwlan.e0102
1400223385 57936 bdwlan.e0104
1400223385 57936 bdwlan.elf
 691636418 57936 bdwlan01.e01
1400223385 57936 bdwlan01.e02
 691636418 57936 bdwlan01.e03
3117335203 57936 bdwlan01.e04
1014175487 266684 m3.bin

They are different than those from your repo, but maybe I can use
bdwlan01.e04 as the board file. 🤔

~ dev
