Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D269C3D37BC
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Jul 2021 11:31:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231340AbhGWIvX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 23 Jul 2021 04:51:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbhGWIvW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 23 Jul 2021 04:51:22 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DD74C061575
        for <linux-wireless@vger.kernel.org>; Fri, 23 Jul 2021 02:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=voNm+gIsmwqVVu27WaakVbNq8OWb2raQX0celWSaJ8o=;
        t=1627032716; x=1628242316; b=ALFpEjxQV1DesDCJTSoyrGtGJVm4Ck18I+PxN5E04o8y7DE
        s5LoUxqq+1MiS3OZsy/B9QtF42Sj0x/yGcU/Hz8UXoYoPaJbWhxFKXmoYbtl9NeQ/c6rLZ03kXPeU
        NPoac5J9fovh5QHCAtyXsxAhoy2mbkDvMYMZflu3U57nAG0pA1D5sEWbDG0lpar+1U1muAdA34ZUG
        aJXFPKYQFpuKVDGfSkyk6sw6y3xQFBP8U8BVLnFR2AX8Ndqgzz2A8fPva5TgrtMzAghijn+8stgJg
        /S7gcHDViyMppSoo67n1PxJLGPyclA/q4P6sz/1H+3JYxGIJiEqXrhNNktfrLOCA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94.2)
        (envelope-from <johannes@sipsolutions.net>)
        id 1m6rUX-000UAl-QV; Fri, 23 Jul 2021 11:31:52 +0200
Message-ID: <a8c4be501b85bcfe478d9597f4d6f90b2887c57c.camel@sipsolutions.net>
Subject: Re: [PATCH 6/9] mac80211: add definition for transmit power
 envelope element
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Wen Gong <wgong@codeaurora.org>, ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Date:   Fri, 23 Jul 2021 11:31:51 +0200
In-Reply-To: <20210517201932.8860-7-wgong@codeaurora.org> (sfid-20210517_222029_289940_80C21857)
References: <20210517201932.8860-1-wgong@codeaurora.org>
         <20210517201932.8860-7-wgong@codeaurora.org>
         (sfid-20210517_222029_289940_80C21857)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, 2021-05-17 at 16:19 -0400, Wen Gong wrote:
> 
> 
> +#define IEEE80211_TPE_MAX_IE_COUNT	8

Is this actually a spec limit?

johannes

