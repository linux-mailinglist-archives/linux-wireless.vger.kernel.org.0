Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7F42433DD3
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Oct 2021 19:53:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232640AbhJSRzS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 19 Oct 2021 13:55:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232148AbhJSRzS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 19 Oct 2021 13:55:18 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50E8BC06161C
        for <linux-wireless@vger.kernel.org>; Tue, 19 Oct 2021 10:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=xybQQEVgIksmOkY4rdpYTKLnEuPlLQ7zlS/Weyr/P8k=;
        t=1634665985; x=1635875585; b=dgTdADG4PUDfLdk+rlBSXSy86GrCTp4ddysKKpXZhhAeF5h
        G+JVGQ41awr0KsJVtjo36cAf5tnDynURHQL5ZnUaNWp65hgxk6SJjxd6sNrKCBe0Vx+Hrjyp06jUv
        66kgJq+lKsSm1W3DeL/fryqDnXs8vWW95eBcdFQ69kcEu0fC5Ty/GLpywwzrLHl89ZkUUzrOZiXuu
        cbbx2FgNUEQL33mHw2eFgLmns1lnr6SwTH0PhtVQzGvjG5OckHB7Ng2iAU/KHW52fXNgSIG4LYBcu
        xX7xLzKhRGBjcr8cM2jYCMZ8odDUB1/xLGPRL5Oz38PCfADlIAbil7FFL+hEH5cg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1mctIM-004Xcn-M0;
        Tue, 19 Oct 2021 19:53:02 +0200
Message-ID: <49d6cbb87dc23ad797a39d9f57ca48edd708fa3c.camel@sipsolutions.net>
Subject: Re: [PATCH 1/2] mac80211: use eth_hw_addr_set()
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     linux-wireless@vger.kernel.org
Date:   Tue, 19 Oct 2021 19:53:01 +0200
In-Reply-To: <20211019162816.1384077-1-kuba@kernel.org>
References: <20211019162816.1384077-1-kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 2021-10-19 at 09:28 -0700, Jakub Kicinski wrote:
> Commit 406f42fa0d3c ("net-next: When a bond have a massive amount
> of VLANs...") introduced a rbtree for faster Ethernet address look
> up. To maintain netdev->dev_addr in this tree we need to make all
> the writes to it got through appropriate helpers.
> 
Looks fine. Do you expect me to apply this (and if so where), or will
you?

johannes


