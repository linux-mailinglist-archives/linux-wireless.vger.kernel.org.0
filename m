Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07AE54633D8
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Nov 2021 13:08:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241362AbhK3MLo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 30 Nov 2021 07:11:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241364AbhK3ML3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 30 Nov 2021 07:11:29 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1220C061756
        for <linux-wireless@vger.kernel.org>; Tue, 30 Nov 2021 04:08:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=EpOt4LCCae2kziFyit/kJHhBPWxiyGzljcSP1CisKf8=;
        t=1638274090; x=1639483690; b=dPjUq3oKecIIuqUZNuN3xF+ICFQLIceVOCi5oYifll59vbP
        NVU054rwLBKqEGh+hIUQBkII/oaqU74Qx2dL0P+V0tQFTVwDvGgB8huQAhQ+RxaGOG0AcAS86UpYP
        9SWEHuVn7usb7VxX0UmfpZZRDrKmysibaUU6Op2U6uEz9FL/fp/jcJUGhSeAHmGvd93VZEchdGRui
        CKrguYkYDcq1uilHCTbPHTcj330HwrYEJSqxYbMEBVDo1dV7L0Y08sjEkf7ReatR21RKYeaxUA4DP
        KZqQrTLrcYLqgkTzNASM8Ho4rYkfmeRi2o0h3XtmTHRfqgECr0KTSA3ikVz7FOOw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1ms1vb-004uHf-Bz;
        Tue, 30 Nov 2021 13:08:07 +0100
Message-ID: <ab8d2785a32d46a1d48a95870dff08aa9f442be9.camel@sipsolutions.net>
Subject: Re: [PATCH 15/16] mac80211: agg-tx: don't schedule_and_wake_txq()
 under sta->lock
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Luca Coelho <luca@coelho.fi>,
        Toke =?ISO-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>
Cc:     linux-wireless@vger.kernel.org
Date:   Tue, 30 Nov 2021 13:08:06 +0100
In-Reply-To: <a8b6dd0a49309eae96cf822c6e587adc05d14b7b.camel@coelho.fi>
References: <20211129133248.83829-1-luca@coelho.fi>
         <iwlwifi.20211129152938.d5fceeb7e166.I555fef8e67d93fff3d9a304886c4a9f8b322e591@changeid>
         <8735nf9ieg.fsf@toke.dk>
         <e947923fbeefd81d3b24acf009212d61864fac2c.camel@coelho.fi>
         <87ilw998vk.fsf@toke.dk>
         <41b83b76a37c51585fbe53cb03f9cf3ddc395e2c.camel@sipsolutions.net>
         <a8b6dd0a49309eae96cf822c6e587adc05d14b7b.camel@coelho.fi>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.1 (3.42.1-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 2021-11-30 at 13:57 +0200, Luca Coelho wrote:
> > > > 
> 
> Johannes, do you want me to send v2 or do you want to add the tag
> yourself? There is one more patch that is broken (ugh, sorry) that I
> need to fix anyway...
> 

Well if you resend I don't have to remember, so that wouldn't hurt
either ;-)

johannes
