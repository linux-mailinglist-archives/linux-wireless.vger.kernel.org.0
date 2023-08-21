Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A16C782606
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Aug 2023 11:06:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234272AbjHUJGj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 21 Aug 2023 05:06:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232684AbjHUJGi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 21 Aug 2023 05:06:38 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B305C9
        for <linux-wireless@vger.kernel.org>; Mon, 21 Aug 2023 02:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=JCBLhefP6X4qljcSYQ3JWAjwPoTMsg4EiJNaPkVo5ZM=;
        t=1692608797; x=1693818397; b=R8u8a49Y7z2q/p7A4ML8RDTetGLDM41OXYOHEwO4Pfn6xyE
        L6nNQJi9xrnqwWQXGVKyaXiZ/HP8ZTYUXNhXqwVuXnDw2hpIeDC56WW5g6Q70cGrvdlSfj6XkmsnY
        zQ/SVzvsh2yH0xsscQ9tU2MGRd6HUvqmMpy/rk1bWK8Ur9T5g9zEio0bthWHNx6iEhJxeRzGY4eQ5
        2Wc3h2lJ6N8C4Bs5+zrEMY718Oy53VN/PrSqlapmXcSbPpj6ee/Oqg1tukmalu7uz9M+ASm6mVhL0
        8vAUioEKEEUFCn3LpvTVqsMnvY+LylihIy3s2lOxNXTbxn9xwRSHQUUh1iMBH5sg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qY0rr-002vhE-0Q;
        Mon, 21 Aug 2023 11:06:35 +0200
Message-ID: <f28ee65621bd52ad59cae891e81431ef83eeaf2e.camel@sipsolutions.net>
Subject: Re: [PATCH] Revert "mac80211: add parse regulatory info in 6 GHz
 operation information"
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Wen Gong <quic_wgong@quicinc.com>
Date:   Mon, 21 Aug 2023 11:06:34 +0200
In-Reply-To: <20230821105903.7482379cde47.Ib72645d02fadc24b520db118abd82e861c87316e@changeid>
References: <20230821105903.7482379cde47.Ib72645d02fadc24b520db118abd82e861c87316e@changeid>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, 2023-08-21 at 10:59 +0200, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
>=20
> This reverts commit cb751b7a57e5 ("mac80211: add parse regulatory info
> in 6 GHz operation information") which added a station type bss_conf
> assignment in a parsing helper function, which will corrupt mesh data.
>=20

Ah crap this won't work, rtw89 already uses this.

Wen please send a fix for this ASAP.

johannes
