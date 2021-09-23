Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2303C415CE3
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Sep 2021 13:36:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240622AbhIWLhh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 23 Sep 2021 07:37:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238930AbhIWLhg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 23 Sep 2021 07:37:36 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BE56C061574
        for <linux-wireless@vger.kernel.org>; Thu, 23 Sep 2021 04:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=BIiaC5CkSEYjf0gygSuRO5yhBDgpibDzFZYj5rNclMk=;
        t=1632396965; x=1633606565; b=x2dIs/eQCTTCYcy8MsuMRCrHEvmUdBuFe9MnoipN4uBs1nJ
        cOOgXAUvzKpJvTarHwnM28cV2jrgmJrKE1kX6zNtuwK4UBN14HpWST0Lu/pT+Bh2JykktnshqXM2T
        ENtb+HFucIYqKBH5lOY/LIn2fRGW7ah8wdMw5ld8HAhgDhAd10Nbv1oLrSE1kvVftrVJoqU81UAkN
        mXb9Z/c2ypIKsGlrWKLpaa5wUYXhZFQCrNApZKlSY0G6qEP5t5CglZ0X0Vp6Xr5vHr2XeGGxYxkS8
        zOguHwiGjH3y0uhMRxkLfof5kjH5HlaAvuNxxk9dfAPeacs3V5mGOqxHEhgGhl1Q==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95-RC2)
        (envelope-from <johannes@sipsolutions.net>)
        id 1mTN1G-00Ai3W-Rl;
        Thu, 23 Sep 2021 13:36:02 +0200
Message-ID: <10ea557f9dfdf92083b9816d7370926e4222f333.camel@sipsolutions.net>
Subject: Re: [PATCH iw 1/4] iw: nl80211: add NLA_F_NESTED to
 nla_nest_start() with older libnl versions
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Gokul Sivakumar <gokulkumar792@gmail.com>
Cc:     linux-wireless@vger.kernel.org
Date:   Thu, 23 Sep 2021 13:36:01 +0200
In-Reply-To: <20210910141618.1594617-1-gokulkumar792@gmail.com>
References: <20210910141618.1594617-1-gokulkumar792@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Applied 2-4, but

> 
> +#ifndef NL_CAPABILITY_VERSION_3_5_0

I can find no evidence of that symbol ever existing anywhere?

johannes

