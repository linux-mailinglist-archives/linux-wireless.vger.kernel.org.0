Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58E127D9315
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Oct 2023 11:08:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231233AbjJ0JIR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 27 Oct 2023 05:08:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230101AbjJ0JIQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 27 Oct 2023 05:08:16 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C97E493
        for <linux-wireless@vger.kernel.org>; Fri, 27 Oct 2023 02:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=5Z5Wi+b9/KqswyyexFwwBfjoKXdVSYrsaCKW/5XNS4w=;
        t=1698397693; x=1699607293; b=WjUW331NMsxS7Hc8ztUlkGNzTmMlcOun0pZYLbb/9ewOXVs
        HPon6DGX1+89BuKq1mVQSIXR86rp1JlP8VrYxNXWHC3yT6+vgSGcRBjt5yeq5N46F/cVjNKtxZcfJ
        6l9n0fXBzlQ/m+ETblULbyt+F1xJg8ogH1pnFutbUIFuStQ8FOgaooOGh3t+ibc4kX6KTDyyAxll5
        qqj/F0toakKplLaGoo1xhKogre9ss4u1EQF2XsTbiTvQXTLIYrr5A0wXyfLZTzooOa06E46Ew7tUl
        ZEWXaiDdVP2ZWZT8W584Plljp9KnCULZDSNreidk/N6aJsZLpWleN1MZvZvC1XeA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.97-RC1)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qwIp4-00000004fD2-3NTA;
        Fri, 27 Oct 2023 11:08:07 +0200
Message-ID: <f26cee40e10be4fa91862d85a1c3054e1da909ce.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: ath10k: prefer stack-allocated __le32 variables
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Dmitry Antipov <dmantipov@yandex.ru>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
Cc:     Kalle Valo <kvalo@kernel.org>, ath10k@lists.infradead.org,
        linux-wireless@vger.kernel.org
Date:   Fri, 27 Oct 2023 11:08:05 +0200
In-Reply-To: <20231027082325.126606-1-dmantipov@yandex.ru>
References: <20231027082325.126606-1-dmantipov@yandex.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, 2023-10-27 at 11:23 +0300, Dmitry Antipov wrote:
> There isn't too much sense to 'kzalloc()' buffer

Actually, there is. Consider what's done with it.

johannes
