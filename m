Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB7DB5AD845
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Sep 2022 19:17:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231545AbiIERPQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 5 Sep 2022 13:15:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231697AbiIERPO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 5 Sep 2022 13:15:14 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70C9C4B0FE
        for <linux-wireless@vger.kernel.org>; Mon,  5 Sep 2022 10:15:13 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 9A553353D3;
        Mon,  5 Sep 2022 17:15:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1662398111; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lqcIPRczxfdWmkZO56Kcs83+FDpNphXjP0tEpVlr5po=;
        b=x/qpakKfGis4g+seQSubpFaqRmZYGSO69JFx5LcL+8e1bA+POzNT+ZAm3lWgQOg5HcQQ7z
        tsBaKRplXdJW2Z2rvhl4xT1Kbh5FvuJcSiat/SjPt3K0/rhmGBLFLS/EtOoTtIQkeqWQJl
        BI0C4tGCi71oRrdP6x3TYHsciKUeIQU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1662398111;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lqcIPRczxfdWmkZO56Kcs83+FDpNphXjP0tEpVlr5po=;
        b=5n8cy8fiULoFLurr1YhFj0CmLdG2cB88tvq8HFeT8/nqYOJX9BVUnYWW4LxdLopLCSPtQI
        d0zB+kj8Lcjlx7CQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4111113A66;
        Mon,  5 Sep 2022 17:15:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ZnYLDZ8uFmOLCQAAMHmgww
        (envelope-from <lhenriques@suse.de>); Mon, 05 Sep 2022 17:15:11 +0000
Received: from localhost (brahms.olymp [local])
        by brahms.olymp (OpenSMTPD) with ESMTPA id 09434c0c;
        Mon, 5 Sep 2022 17:16:00 +0000 (UTC)
Date:   Mon, 5 Sep 2022 18:16:00 +0100
From:   =?iso-8859-1?Q?Lu=EDs?= Henriques <lhenriques@suse.de>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Gregory Greenman <gregory.greenman@intel.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>
Subject: Re: New 6.1 net/mac80211/rx.c warning with iwlwifi / Ultimate-N 6300
 wifi
Message-ID: <YxYu0CawomVcTlRn@suse.de>
References: <498d714c-76be-9d04-26db-a1206878de5e@redhat.com>
 <YwNNXKEFcX/GK2Sv@suse.de>
 <644e506ab60a58b95bdbbb5d9c3e425622931f8f.camel@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <644e506ab60a58b95bdbbb5d9c3e425622931f8f.camel@sipsolutions.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, Aug 22, 2022 at 12:21:49PM +0200, Johannes Berg wrote:
> On Mon, 2022-08-22 at 10:33 +0100, Luís Henriques wrote:
> > On Sat, Aug 20, 2022 at 03:12:33PM +0200, Hans de Goede wrote:
> > > Hi All,
> > > 
> > > While testing 6.0-rc1 on a Dell Latitude E6430 with:
> > > 
> > > 03:00.0 Network controller: Intel Corporation Centrino Ultimate-N 6300 (rev 35)
> > > 
> > 
> > I've just seem a similar splat on -rc2, with a different card:
> > 
> > 02:00.0 Network controller: Intel Corporation Wireless 8260 (rev 3a)
> > 
> 
> Yeah this is an issue with the new multi-link work.
> 
> We've seen it too, though the rx->link _should_ be set to deflink here
> in the cases of non-MLO connections.
> 
> We're investigating.

FWIW I'm still seeing this with RC4.

Cheers,
--
Luís
