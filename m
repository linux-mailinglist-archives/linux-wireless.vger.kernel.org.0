Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9BEC4B16BF
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Feb 2022 21:10:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243246AbiBJUKU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 10 Feb 2022 15:10:20 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238417AbiBJUKT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 10 Feb 2022 15:10:19 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84F002735
        for <linux-wireless@vger.kernel.org>; Thu, 10 Feb 2022 12:10:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=Vn1v2NTrbvtFKl+aBjJrgcfektdGUDMKJCOHU2Wiack=;
        t=1644523820; x=1645733420; b=HpfM30ZZ3fqMRD2x8JkOSDbDWGIHbk56nC/qTwuxvdUn3aa
        WjwQZmqprpjdmCj+gaBa6DXow4jxAnHnsoRtQpBBvcnyNUrTPzjHPDkUwuYWjyiGoB6b0TB2S5ixr
        MpQBf2vjfxdvwPLpsDQu9Kd6t5N9IrPFdOyVA15i680FljOqO1yocMrsOTdw72PKzBHnujysx6NjS
        JC6PTLP9TGeeZ2gWA51HLXvPB1uE8rbjzR05jSr+kxVxeEvRChHlZKs2N7uU4oy8sNyaVoHpxfQ4c
        HlEJThCSlpxoM2xBRSUMRc+Jq1hvVFHJzSak+k1BmUjynQ/Sww+JqKVtqTRGdaHg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1nIFli-00HDIv-0q;
        Thu, 10 Feb 2022 21:10:18 +0100
Message-ID: <bcbeaeb1c331a5570e6ab6e03a6ce2875b43f750.camel@sipsolutions.net>
Subject: Re: Possible bug in cfg80211
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Maxim Klimenko Sergievich <klimenkomaximsergievich@gmail.com>,
        linux-wireless@vger.kernel.org
Date:   Thu, 10 Feb 2022 21:10:17 +0100
In-Reply-To: <ba50e373-59d8-d544-e7f9-3fe2a3336056@lwfinger.net>
References: <CAEqd1ZZucLqJMEktzmnCKzwXXkswzqJNf_yr2HZV20LcWtiR6A@mail.gmail.com>
         <ba50e373-59d8-d544-e7f9-3fe2a3336056@lwfinger.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.3 (3.42.3-1.fc35) 
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

On Thu, 2022-02-10 at 12:54 -0600, Larry Finger wrote:
> 
> I am most concerned about that bss_entries_limit=1 option for cfg80211. Do you 
> still get the warnings logged if you eliminate that one?

Yeah that's probably the reason ...

I guess we should ignore it if it's too low to make any sense.

> I also have a question for Johannes, et al. Should the "if (WARN_ON(!oldest))" 
> in net/wireless/scan.c be a WARN_ON_ONCE()? It does not seem worthwhile to spam 
> the logs. It is clear that once this happens, it will happen again and again.
> 

Indeed, that seems reasonable. Want to send a patch?

johannes
