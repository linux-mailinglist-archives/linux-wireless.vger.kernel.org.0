Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F2005A4F87
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Aug 2022 16:46:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229883AbiH2OqY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 29 Aug 2022 10:46:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbiH2OqX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 29 Aug 2022 10:46:23 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FE068B2D2
        for <linux-wireless@vger.kernel.org>; Mon, 29 Aug 2022 07:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=rBLa68gXW/Sl3z7HlUAUC8UtxUbFCEOKQ2jCdQNtEx4=;
        t=1661784382; x=1662993982; b=jtLn/QGPPHxSiG9HBFqw+R9Gausk8PsAwFr8yRKfpYox2zX
        5NkbQPdQw8mOuXqFToU3BbHLs9DkCrXKomYDzn8O/6SwvPIFqr7mlZ5/qyDA1rgExKly3x4wR8Z4r
        nF4aRGAqg0ey2/VfgiEElnPvf3Q+OKrgXFLsrvZMvjpEwg0GgL9GrV2LCXR0JF88or3Ab3Gi1ATxJ
        SO940PkxmPcL1JSJ3duI0gzH2U+ofT0Z1p1L1ZguxCoCZYs37kv5LhcKWCwBPdyIwaWWVHYpgf+av
        LEQnfJasvPR/nscp8T8JXKvQfpmljIRNHEYdzvtCZeLzYV4OevxbIYN3T2vDgVZw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oSg1s-002pdZ-0u;
        Mon, 29 Aug 2022 16:46:20 +0200
Message-ID: <467218ec220ea6e36b4222efc5c46e4e350fe1ea.camel@sipsolutions.net>
Subject: Re: [RFC 0/4] mac80211: add TPC support in control path
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Jonas Jelonek <jelonek.jonas@gmail.com>,
        linux-wireless@vger.kernel.org
Cc:     nbd@nbd.name, Thomas Huehn <thomas.huehn@hs-nordhausen.de>
Date:   Mon, 29 Aug 2022 16:46:19 +0200
In-Reply-To: <20220829144147.484787-1-jelonek.jonas@gmail.com>
References: <20220829144147.484787-1-jelonek.jonas@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-1.fc36) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, 2022-08-29 at 16:41 +0200, Jonas Jelonek wrote:
>=20
> I tested the tx-power annotation with an implementation of TPC in ath9k
> (not included in this RFC) and small changes in minstrel_ht for debugfs
> access. Tx-power status report in ath9k required the proposed utility
> function in mac80211.
>=20

Huh wait, now that I got to the end of the series ... this doesn't
actually *do* anything, so what's the point? Shouldn't it come with some
implementation of the control?

johannes
