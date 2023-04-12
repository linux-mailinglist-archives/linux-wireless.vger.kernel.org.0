Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDDDC6DED88
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Apr 2023 10:26:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbjDLI0Q (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 12 Apr 2023 04:26:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbjDLI0P (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 12 Apr 2023 04:26:15 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECE186A5F
        for <linux-wireless@vger.kernel.org>; Wed, 12 Apr 2023 01:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
        Resent-Message-ID:In-Reply-To:References;
        bh=dpiy0MvZLTIJH213uQc5AsDTynjP5Xf46HKUSLlwTJk=; t=1681287974; x=1682497574; 
        b=XQZV9WsyPUFrm45mstKr2cFBfhuqPhtAO2K2mq2n26xto3TKlksl2ZOOKPsMk72fEa+ik+sxES/
        2dH99k0fzEzPGVAxxM5/1vVJ4SsQCS64KIXIgPJkKoiiEKKflsxKXoyeeEO7Rk6iuI+RD0UrKVh24
        CTIIfiguaoaugswuzgonmfO/w5odWpBJfFfWWasKJ8YpK9k7Y4X+TFlHazfIelH2BYnIrZOFgrGA7
        umbmZzAF06oHhLq5dmay7W2/09xhiZ5Jvmr+hGIttLBYDjsR3X5ycG2vyWNbLs+F88HsPk+XLMKjk
        5kvX1Fs8OVu7sE4kBWRRqBt+ltIgxHdrFtPg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1pmVnv-00DZAP-2f;
        Wed, 12 Apr 2023 10:26:11 +0200
Message-ID: <d0e26bef6e92b2c379377147f337a65d12794e81.camel@sipsolutions.net>
Subject: ancient wifi bug report
From:   Johannes Berg <johannes@sipsolutions.net>
To:     briemers@redhat.com
Cc:     linux-wireless@vger.kernel.org,
        John Linville <linville@tuxdriver.com>
Date:   Wed, 12 Apr 2023 10:26:10 +0200
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
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

Hi,

Sorry to bother you, I'm investigating my own kernel commit 05cb91085760
("mac80211: disable powersave for broken APs") and I see that it says
you reported the issue, but I can't seem to find the report anywhere
I've looked (my inbox, bugzilla.kernel.org, lore.kernel.org,
bugzilla.redhat.com) ... only found this thread:
https://lore.kernel.org/all/1319795987.8931.7.camel@jlt3.sipsolutions.net/

The reason I'm investigating this now is that we're considering removing
this workaround and refusing the connection to such a broken AP, since
the AID is used in more places now (even PHY headers) and it's getting
hard to keep this workaround working properly with firmware etc.

Do you remember anything about the bug report, such as the AP it was
happening on?

Thanks,
johannes
