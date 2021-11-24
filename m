Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E96A445B826
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Nov 2021 11:13:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235214AbhKXKQP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 24 Nov 2021 05:16:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234674AbhKXKQP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 24 Nov 2021 05:16:15 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BEC3C061574
        for <linux-wireless@vger.kernel.org>; Wed, 24 Nov 2021 02:13:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=AbK4zDSMNKK3XT71/EgB0946z8wmLvOP2Ubn+gdWD3Y=;
        t=1637748786; x=1638958386; b=G0ILt4lwZZzeMuBB7HZmSHZHLN5PSSljmJsxc/LeNwL/mSe
        bpJ8+wXnCIs3Q93eofgGMcvd4XwtO2QUWSbHBVJQB1T8UlTWppDHXqwlChJjxfpcrVaUes1YWALre
        Ex4a2fGDOQhAeDwzC3VxaWXou4eZNeWpgKbcqix0qlsu4PRXEgcdPkaAEkzbaA0TddHtIctis0XSy
        R7/b3awXfhe8WOM1E06b5h0ZEhervi9a/L4bWZ5PdNR+E0lJyQnZe7vZKW7CP2pNeit8rXzs2sC4P
        7cen8psy0tQW7IH4hejOijCxsZ1QkKjVQF3Pvd9fnXfDQKm8ASbddWJ3MSAGZc5g==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1mppGr-002ELG-0L;
        Wed, 24 Nov 2021 11:12:57 +0100
Message-ID: <54c903dfff255cda79c9c5e7610b678710a795ab.camel@sipsolutions.net>
Subject: Re: [PATCH] net: fix incorrect return code
From:   Johannes Berg <johannes@sipsolutions.net>
To:     liuguoqiang <liuguoqiang@uniontech.com>
Cc:     davem@davemloft.net, kuba@kernel.org,
        linux-wireless@vger.kernel.org
Date:   Wed, 24 Nov 2021 11:12:56 +0100
In-Reply-To: <20211124100151.31233-1-liuguoqiang@uniontech.com>
References: <20211124100151.31233-1-liuguoqiang@uniontech.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.1 (3.42.1-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, 2021-11-24 at 18:01 +0800, liuguoqiang wrote:
> In drv_can_aggregate_in_amsdu, when ops->can_aggregate_in_amsdu is NULL,
> should return -EOPNOTSUPP rather than true.
> 

No, this is wrong, the return type is actually wrong.

johannes
