Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A84AA4F18A5
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Apr 2022 17:41:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378043AbiDDPne (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 4 Apr 2022 11:43:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237783AbiDDPne (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 4 Apr 2022 11:43:34 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7463393F5
        for <linux-wireless@vger.kernel.org>; Mon,  4 Apr 2022 08:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=gxo+ARTv0iL7XOsq2uPmtKhJkpSvF0KLgFdhrt2AFs4=;
        t=1649086897; x=1650296497; b=URSWP0hzhgpzplooT+KdJzxwgyreTnlpbVV27x/oPrCXwTi
        BQDHF9NprO9hqMFceDSDr4DaWTW0L6NWeB0UgsHTGmrD/FpGL8L/BUMtSPsH4QAoyFIvwwtiN+oTo
        RkI9Ajy6na1/nouNKcXmJf6cgU0mdnwTlrLSEW71pMBZ3KBF9A9h45eWVp3H/Hzm49rZU/CAAEZeK
        nlGSl3Y0KJQXozhLlatJD51kynenNqpdmKH9XzRe7FSHtF0Az3jgcZtNyMlytyquoqPQ4NpDbsJAN
        rpn/+4i3UaGuFrQN3GhYP4bqtkpcj/pBzzezP5Z5jDfNmFW2IJGgywVHKrZ8Ijdw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1nbOpj-004y1W-2L;
        Mon, 04 Apr 2022 17:41:35 +0200
Message-ID: <f73b62ea7f04899db5e49c9722e99ba31172f787.camel@sipsolutions.net>
Subject: Re: [RFC v2] mac80211: prepare sta handling for MLO support
From:   Johannes Berg <johannes@sipsolutions.net>
To:     "Sriram R (QUIC)" <quic_srirrama@quicinc.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Date:   Mon, 04 Apr 2022 17:41:34 +0200
In-Reply-To: <SN6PR02MB433476576476A9AA7EAF3F95F7E59@SN6PR02MB4334.namprd02.prod.outlook.com>
References: <1648555198-8065-1-git-send-email-quic_srirrama@quicinc.com>
         <467e7f83270a9b1f8e2b32f27b48607e2c2ff480.camel@sipsolutions.net>
         <SN6PR02MB433476576476A9AA7EAF3F95F7E59@SN6PR02MB4334.namprd02.prod.outlook.com>
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

On Mon, 2022-04-04 at 15:40 +0000, Sriram R (QUIC) wrote:
> Hi Johannes,
> > 
> > I think this looks fine - want to send it as a PATCH? I think I'll just apply the
> > spatch directly.
> Sure, Let me send out a PATCH shortly.
> > 
> > If there's any needed fixups beyond the spatch that might be good to know too.
> So, in this patch (mac80211) I had to manually fix couple of changes around ADD_STA_STATS, TRACE_EVENT macros.
> 
> In drivers, only below change was required in addition.
> 

Nice! So if you include all the manual bits, you can also leave out
mac80211 changes from the spatch if you like, I'll just run the spatch
when applying it so we have it on the exact tree snapshot.

johannes
