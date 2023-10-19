Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18BC77CF579
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Oct 2023 12:38:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231984AbjJSKi1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 19 Oct 2023 06:38:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjJSKi0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 19 Oct 2023 06:38:26 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D72BD119
        for <linux-wireless@vger.kernel.org>; Thu, 19 Oct 2023 03:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=64BjuiIoJXnsKmJBOxKeNr4hDLgeJUrCY+eejb5bpO4=;
        t=1697711904; x=1698921504; b=IR4Wv44kOAiVa3KxuvapHbPTLSCBVQbZb/pRQf+xmlz72zn
        KW71J0qVEzWBiNWRoFZzxhuqcdn6zfWaisj0hij0IdUnfzYHjuW1j1Rkv7EVtqp3m0HVthSfIjrrM
        Z0MWn2DlfzsXSwChxRf0rIV4EuXr6/860X4fgeOxvLvLqJYnnPTb/y7vcyFn47qYIal2ltivPG1Xn
        4zH81H8Ycu0eEhdKPe31weDCsCd9cd1toeGmHzaCK2yZsHkX2PfmjrdHNlsyLbogJSzx0DNO8Zpp8
        pT0lViWPiCqUTMmhhU9vA7+r57l/6vNfznv2OOmr4kfyFrT2UmUtqXCw9O6Oh9nw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.97-RC1)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qtQQ2-0000000DIQC-0Jby;
        Thu, 19 Oct 2023 12:38:22 +0200
Message-ID: <06036e52a37713db714d82e535975bf03f6ba366.camel@sipsolutions.net>
Subject: Re: [PATCH wireless] cfg80211: allow grace period for DFS available
 after beacon shutdown
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Felix Fietkau <nbd@nbd.name>, linux-wireless@vger.kernel.org
Date:   Thu, 19 Oct 2023 12:38:21 +0200
In-Reply-To: <20230914112147.26985-1-nbd@nbd.name>
References: <20230914112147.26985-1-nbd@nbd.name>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, 2023-09-14 at 13:21 +0200, Felix Fietkau wrote:
> Fixes reconfiguring an AP on a DFS channel in non-ETSI regdomain

Sorry, I think I mentioned this on IRC but maybe you never saw: can you
please elaborate on the commit message?

It looks pretty OK but describing just that it fixes something seems a
bit sparse.

johannes

