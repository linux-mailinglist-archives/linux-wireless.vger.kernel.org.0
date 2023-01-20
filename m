Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90D8F6750A0
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Jan 2023 10:20:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230124AbjATJUT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 20 Jan 2023 04:20:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230119AbjATJUS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 20 Jan 2023 04:20:18 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00BD22D5E
        for <linux-wireless@vger.kernel.org>; Fri, 20 Jan 2023 01:20:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=cyaeYTyeD5DjJf168SDOllAuCiwGfw74bC2cVkeoAAA=;
        t=1674206416; x=1675416016; b=pCmACHpj+vv8Dj6juhnzWezcIwwR6nI5bjEJ0kMWf6DPpRM
        auu81K+Ewj9L5a2nOwthFqJZMO1CpYUnxLMHZLW7Y9ZHsTMQ4s/h2WWLBWrUFa2HLHJOcFY8p3Xn4
        EWkWkZN1DRRKD0Z/OHpAMw6LxFoHrI6ccJIIdLR1CMI+ZoqUFFjl0uqX3fuW2rF5NTiL6YPkJ+0Gw
        bwMg78t/RslmL9qalJN66FGC8T5O+HMYOBeEzG8jBKR/id0Hrip23QfOUbknel0+lsv7az7gIBSe5
        EVi/vtHKrkql5tgxs+EXUqKUFvhmzPA3TWYWb/IDMaAx3H7xDARaVWJ39wwo3YMw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1pInZF-007Nf1-2f;
        Fri, 20 Jan 2023 10:20:13 +0100
Message-ID: <1a063de0aba4a6e2bcf5cacaa661ca8b73c1ffad.camel@sipsolutions.net>
Subject: Re: [RFC 3/4] wifi: nl80211: validate RU puncturing bitmap
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Aloka Dixit <quic_alokad@quicinc.com>,
        Muna Sinada <quic_msinada@quicinc.com>
Cc:     linux-wireless@vger.kernel.org
Date:   Fri, 20 Jan 2023 10:20:13 +0100
In-Reply-To: <0b77bad5-f55c-73d5-7cd0-dfed57871f25@quicinc.com>
References: <1670006154-6092-1-git-send-email-quic_msinada@quicinc.com>
         <1670006154-6092-4-git-send-email-quic_msinada@quicinc.com>
         <3df39d4f2e2e64bd3899cfbe7bade547e54330f7.camel@sipsolutions.net>
         <0b77bad5-f55c-73d5-7cd0-dfed57871f25@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.3 (3.46.3-1.fc37) 
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

Hi Aloka,

> Secondly, this RFC uses ieee80211_valid_disable_subchannel_bitmap()=20
> defined in following RFC you sent:
> https://patchwork.kernel.org/project/linux-wireless/patch/20220325140859.=
e48bf244f157.I3547481d49f958389f59dfeba3fcc75e72b0aa6e@changeid/

Yes, I saw that.

> Is there is any plan for the next version?

Am I correct that by basing your work here on top of that, you're OK
with that being included, and we've concluded the discussion about where
and how the puncturing bitmap should be stored? This patchset was an
RFC, I'm personally happy with the design, but really also want to hear
your opinion and perspective on it.


Anyway if that's the case then I'll go and resubmit the patch - we also
made some more fixes to it since, I think. I'm not sure I'll get to it
today, but I'll do it soon.

johannes
