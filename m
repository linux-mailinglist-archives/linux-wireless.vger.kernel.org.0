Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 341154E72C2
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Mar 2022 13:09:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355644AbiCYMLV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 25 Mar 2022 08:11:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345960AbiCYMLV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 25 Mar 2022 08:11:21 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 899422DD71
        for <linux-wireless@vger.kernel.org>; Fri, 25 Mar 2022 05:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=vJsrxyZI5Ey6fLfTdp3jvEKM8Ct/nd/CvW2tCPYF/Mw=;
        t=1648210186; x=1649419786; b=QjdoB+09ZmPbyAcs/Ny9AiehY+B5EzEsCBU7EapoMQ713fp
        yR7JybAB0nazxDdkA2MFWYaDXu/+iIL0mZF+iPih5Zz9alJWH2AvSaJ4YwA3FDEHdxm0iVPzAeoF1
        YNoKd3mhkUcUbtwmIv/Vy1SQxMTOxn/L5DlUdXy2Z4EXZVup6NHbM6HJyzswyek3kTEQifhTLlNz7
        S2NumLHAUGYWKdoexTgxa4QyRTwqeLhqZNxIFV1w8ROfsp+WcCU7WW8pjRK7ReIGQMcjbekiZFCR5
        H+rPRofvFrpwZzVDO3IUcXabtBXuRTGYcAMoPbJy5O7DZvaeU1x/OdNNlPrsULVQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1nXilE-000JqX-6v;
        Fri, 25 Mar 2022 13:09:44 +0100
Message-ID: <ada45791b8792f37d4167d24a7fc440f77c2167f.camel@sipsolutions.net>
Subject: Re: [BUG] deadlock in nl80211_vendor_cmd
From:   Johannes Berg <johannes@sipsolutions.net>
To:     William McVicker <willmcvicker@google.com>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
Cc:     linux-wireless@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>
Date:   Fri, 25 Mar 2022 13:09:42 +0100
In-Reply-To: <YjpGlRvcg72zNo8s@google.com>
References: <0000000000009e9b7105da6d1779@google.com>
         <99eda6d1dad3ff49435b74e539488091642b10a8.camel@sipsolutions.net>
         <5d5cf050-7de0-7bad-2407-276970222635@quicinc.com>
         <YjpGlRvcg72zNo8s@google.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 2022-03-22 at 21:58 +0000, William McVicker wrote:
> 
> It would be nice if nl80211_vendor_cmd() could support taking the RTNL lock if
> requested via the vendor flags. That would require moving the wiphy lock to
> nl80211_vendor_cmds() so that it could take the RTNL and wiphy lock in the
> correct order. Is that something you'd be open to Johannes?

Not very, to be honest. If we had a good use case for it, maybe, but
you're not even saying quite what the use case is :)

It's also rather complex, because it'd require effectively open-coding
the pre_doit() stuff in the vendor command handler itself, in order to
look at the sub-command flags while doing it ...

johannes
