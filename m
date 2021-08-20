Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C79D3F2903
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Aug 2021 11:17:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235426AbhHTJSC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 20 Aug 2021 05:18:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235063AbhHTJSB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 20 Aug 2021 05:18:01 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 669E3C061575
        for <linux-wireless@vger.kernel.org>; Fri, 20 Aug 2021 02:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=C34DC/JZ/0jrJFT1WLTx+jmXW+TLNZPwmBEN0go/p9k=;
        t=1629451043; x=1630660643; b=WWHBMJZU1qHp00M5mchLWjpcwcNExYYNTUk4GFjGfftKY1C
        yRhzKoe0hn/yZbg9ZrVRx4+U79DSS1rAqcRVDBSjLVz1MvURNf03/2z2ROjH0ah51vygqMOTN0500
        nCJ+KrOCAQxfM8DsxgevCyRcDtuGS87RzQOXCPRcYJAalu2RBDDXqwpKFdcLdJ8juQq67PFyh5+D+
        zHNjZ/gyIQ6WHJ/dwpF8hANU44PbwYyVQ3EI/RuxX5FVCIfJEd6f5P0dNC5vAbl6nHmLYOkPUITnB
        QXgram3RDcWccSYXLnc+QNgtm397WXujFNEzpZstxDN+dSX9LBe/wiOlGsGKTv9A==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94.2)
        (envelope-from <johannes@sipsolutions.net>)
        id 1mH0eO-00DWv8-Qi; Fri, 20 Aug 2021 11:17:20 +0200
Message-ID: <2c55dce18c94d778207b3fc452a09e14ee80c032.camel@sipsolutions.net>
Subject: Re: question on HE debugfs output
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Ben Greear <greearb@candelatech.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Date:   Fri, 20 Aug 2021 11:17:20 +0200
In-Reply-To: <578da3a0-f029-4e60-d4e6-34d42def62e8@candelatech.com>
References: <578da3a0-f029-4e60-d4e6-34d42def62e8@candelatech.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Ben,

> While poking around in things, I noticed that the
> he_capa debugfs is not showing the least-common-denominator, but rather
> more specifically the peer's capabilities.
> 
> This could be bugs in how I'm using this, but thought I'd ask to
> see if this was on purpose or not.

It was on purpose. Also, for HE it's different from HT/VHT in that we
don't do this in the stack any more.

I'm not really sure _why_ now (or if we should change it), but I seem to
remember it was just a lot more complex to do in general, but drivers
didn't really care so much since they tend to have a lot of hard-coded
assumptions, e.g. they might not care about seeing 2, 3 or more streams
supported if their code assumes the device always only supports 2 in the
first place, so all they need is a >= 2 check in this case, for example.

If you wanted to change that, I wouldn't mind, but it might be complex.

johannes

