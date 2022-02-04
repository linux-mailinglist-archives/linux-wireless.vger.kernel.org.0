Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84BB44AA28D
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Feb 2022 22:46:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236141AbiBDVqs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 4 Feb 2022 16:46:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233413AbiBDVqr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 4 Feb 2022 16:46:47 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88CE3C061714
        for <linux-wireless@vger.kernel.org>; Fri,  4 Feb 2022 13:46:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=9eVtwZfZ+uJG2ZN94tHrXDVYLfr65No0A3jJIxqdgIU=;
        t=1644011205; x=1645220805; b=DlRmUXZP/H8Db4a+AYAGP4vnWhRrSRL+emXWIojFCsZFWuE
        kWmD/vc5w4idtN8F8Kwr32T7iHCDIho5N0mUXLfvG8w90rocsLZGSYQWwhbbRiXPw4ROd8GpJffpA
        HZRWHMcJH8VgJWg8NoHgmTpY9P0sBGULlU/WiaFbVyY96yOAVW7sNigRnE3pq6uU/IwlA3bbC3MdO
        emyN+l/4E+86vWupxveKZ1Zax6Jnz++Mtr8+CpyGkG//X0vfoO/EmHUSDk35A+msoYdAULTK0Ew3M
        8dsl+A6RMgZF4uw8/YeYfSAqoE47SgJPLH0XG7UMkmTRXiE/Zfc3UPfBincb4WIA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1nG6Pg-00EdSJ-Bb;
        Fri, 04 Feb 2022 22:46:40 +0100
Message-ID: <d7494a948df4fddd6a5ae783558d31bce115f0ff.camel@sipsolutions.net>
Subject: Re: [PATCH] mt76: mt7915: fix injected MPDU transmission to not use
 HW A-MSDU
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Johan Almbladh <johan.almbladh@anyfinetworks.com>, nbd@nbd.name,
        lorenzo.bianconi83@gmail.com
Cc:     ryder.lee@mediatek.com, linux-wireless@vger.kernel.org
Date:   Fri, 04 Feb 2022 22:46:39 +0100
In-Reply-To: <20220204154730.166194-1-johan.almbladh@anyfinetworks.com>
References: <20220204154730.166194-1-johan.almbladh@anyfinetworks.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.3 (3.42.3-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, 2022-02-04 at 16:47 +0100, Johan Almbladh wrote:
> 
> diff --git a/mt7915/mac.c b/mt7915/mac.c
> index 08ee78f6..1848fa16 100644
> --- a/mt7915/mac.c

You should probably resend that with a full path.

johannes
