Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43D9C62268B
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Nov 2022 10:15:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230089AbiKIJPE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 9 Nov 2022 04:15:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229973AbiKIJO3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 9 Nov 2022 04:14:29 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0004E20F56
        for <linux-wireless@vger.kernel.org>; Wed,  9 Nov 2022 01:13:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=E4XIvI6HutdINK1zcDVLKyXPwQOek2tqyBkxs4VpZqw=;
        t=1667985195; x=1669194795; b=s5bYCvs5jlVInflBBAjsp1amjpPcLsp5LyOkbsnf97HCWLd
        RaHxwZNfJWvhCC+l2nbWqt6tTkcQYAZtvpL1r75k5Ea8Hoy82vhzFrRRvKS/sLtIi4A0/yqcn1c9T
        FZ4JzCY0tiJHR+LNz1UdBxMJ8FGSLR8RAEr8TT6+bzi4Xl7IGVtgRbdckAlF0/+inXNm1k7GZMLbV
        /SEMZjc2by6ErGVF6SYYM+kXwmZGtv+g+N/jIvDr+Dqzb/5vRJ/T7T8pKgk7bHFGXQesGA8RLMDDx
        CkxXZQegO3lsaXIdC5f9uX8i7OX9/GJxT9SB/9mKxg+DCr0hkFnnn8bXI6IecSTw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1osh8x-00D4jy-2A;
        Wed, 09 Nov 2022 10:13:12 +0100
Message-ID: <45be33863c53edc5be261950b2592a777690a353.camel@sipsolutions.net>
Subject: Re: Classification of BSS with different frequencies in KHz
From:   Johannes Berg <johannes@sipsolutions.net>
To:     JUN-KYU SHIN <jk.shin@newratek.com>
Cc:     linux-wireless@vger.kernel.org
Date:   Wed, 09 Nov 2022 10:13:10 +0100
In-Reply-To: <20221109061532.GA13554@DESKTOP-7BCE18E.localdomain>
References: <20221109061532.GA13554@DESKTOP-7BCE18E.localdomain>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, 2022-11-09 at 15:15 +0900, JUN-KYU SHIN wrote:
> "freq_offset" also needs to be compared on S1G Band.
> If freq_offset comparison is omitted in cmp_bss, other bss cannot be dist=
inguished in units of khz.


please don't send patches as attachments.

The patch looks wrong, the freq offset is in different units, so this
could cause bad =3D=3D comparisons?

johannes
