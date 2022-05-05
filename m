Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B4DE51B89D
	for <lists+linux-wireless@lfdr.de>; Thu,  5 May 2022 09:18:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240924AbiEEHW2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 5 May 2022 03:22:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240905AbiEEHW1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 5 May 2022 03:22:27 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29E7F3DA48
        for <linux-wireless@vger.kernel.org>; Thu,  5 May 2022 00:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=4hM8psBm5VbwftLkRFBG8VOkdNpe7jxaeX8Rnshk+dE=;
        t=1651735128; x=1652944728; b=gjPHkKRlg4YvEvDQUczsAH3wsEm9mOks8PyuoO7XlibuTXw
        TrDtXKi1Iw7a6Db7ON1G8ZjnjwabsQS+PGHbb/8VPAfXXCtPQ0n97mOjRUHkcUKSCjDelPQZfzPhK
        jdWVMwfQvxwuJRkjCz0Qxs0HR0PwY1iIfltUgXR/g5oopceh1g+FDuZrKiDXLPq0IOU8SDpqdMsY9
        /ur5sGUPOAFcOKbD7QbbdUNGdrZjG92z1UOJijLNItbauW8YynWG+neezUoaggjIiS+ZM+sdMFDEv
        /g9Hq5bNCcMnXfmrgKroVcpN42P2+tFWqXZ/ihAwUwLkIZcIrNrNUOmVMIwXam3w==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1nmVl3-002fMu-AX;
        Thu, 05 May 2022 09:18:41 +0200
Message-ID: <53062c8fbe3eaaa281f24c4808a15804938c83ef.camel@sipsolutions.net>
Subject: Re: [PATCH v2] cfg80211: Add support for sending more than two AKMs
 in crypto settings
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Veerendranath Jakkam <quic_vjakkam@quicinc.com>
Cc:     linux-wireless@vger.kernel.org
Date:   Thu, 05 May 2022 09:18:40 +0200
In-Reply-To: <22bf2f78-587d-429b-867f-f73e542018d2@quicinc.com>
References: <1650344143-1615-1-git-send-email-quic_vjakkam@quicinc.com>
         <cb419675d2ae276d9b4eac8ab5deafe62167051f.camel@sipsolutions.net>
         <22bf2f78-587d-429b-867f-f73e542018d2@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
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

On Thu, 2022-05-05 at 10:40 +0530, Veerendranath Jakkam wrote:
> 
> On 5/5/2022 2:24 AM, Johannes Berg wrote:
> > I don't know why, but this patch seems to cause memory corruption and
> > various issues when I run the hwsim tests.
> > 
> Oh.. I ran some hwsim tests from hostap.git to verify the changes but 
> didn't face any issues. Are you seeing the issues with any specific 
> hwsim tests? Also, the issues are coming without any of the below 
> changes also(i.e. with actual patch i sent)?

Yes.

I also came to think - where's the upstream driver using this?

I've been saying this for something like a decade now, I think I'll stop
investing time in such patches.

johannes
