Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCF317D9443
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Oct 2023 11:53:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345406AbjJ0Jxd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 27 Oct 2023 05:53:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230502AbjJ0Jxc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 27 Oct 2023 05:53:32 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 474EB9D
        for <linux-wireless@vger.kernel.org>; Fri, 27 Oct 2023 02:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=U1bDbJE+lcrP5cgqiyYJYmwzGghCUhM8XYVnQVM85N0=;
        t=1698400410; x=1699610010; b=a/I/eoz6vKsKioGS08rs9rZWn/gMa0q9C3d2WndAFeg/SMk
        y2hHccB3LmyG22tSfzewH9k+yFbfCdCKiM2T26IxpaSVIPVK2t2NEXnR0T2+LeR9Xz/6DA4+jHOz9
        XPQDmqzAsHeXhRpuOQM8Cu93Nqq8evNGATpRyP68g0zVRindIoEzBf/UCgpBH01YohgmylYbJ8rjm
        FhuY3bWny4myv2tajGrjxV69Rao+2IlC4PrQ2jLI2ylDG9pNPECLs7KhZCCl/CnW9DFCkS/srr0Jf
        89jcNosl9NS++88BuiHS+38gVYJPAK/nw6vn5DK12j68GvRsOXmskASp1OPm5lgQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.97-RC1)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qwJWx-00000004gFW-2bep;
        Fri, 27 Oct 2023 11:53:27 +0200
Message-ID: <8d5af24635501d1ae2e0a54f7196fc476241f894.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: ath10k: prefer stack-allocated __le32 variables
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Dmitry Antipov <dmantipov@yandex.ru>
Cc:     Kalle Valo <kvalo@kernel.org>, ath10k@lists.infradead.org,
        linux-wireless@vger.kernel.org,
        Jeff Johnson <quic_jjohnson@quicinc.com>
Date:   Fri, 27 Oct 2023 11:53:26 +0200
In-Reply-To: <79560f97-4f42-455d-9031-a2c1eed736e0@yandex.ru>
References: <20231027082325.126606-1-dmantipov@yandex.ru>
         <f26cee40e10be4fa91862d85a1c3054e1da909ce.camel@sipsolutions.net>
         <79560f97-4f42-455d-9031-a2c1eed736e0@yandex.ru>
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

On Fri, 2023-10-27 at 12:50 +0300, Dmitry Antipov wrote:


> Locals can't be used for scatterlists/DMA/etc., right?

Well, a scatterlist by itself doesn't imply anything necessarily, it's
just a data structure.

But yes, you cannot do DMA from the stack, which seems to happen in this
case, or at least can happen.

johannes
