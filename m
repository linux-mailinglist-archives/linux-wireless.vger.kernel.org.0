Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AE007C6DB8
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Oct 2023 14:13:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347237AbjJLMNt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 12 Oct 2023 08:13:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347211AbjJLMNs (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 12 Oct 2023 08:13:48 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F1ECC9
        for <linux-wireless@vger.kernel.org>; Thu, 12 Oct 2023 05:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=kM+sSAftxNLB9WT7j/0tw0qtBBVhoBQtkgtn/QAY3Pc=;
        t=1697112827; x=1698322427; b=gYjcBwulNRLa1XrQ+uUHJ4raHeqmNSfbrL/elFek6ZeQz9l
        /tWi0ceVYHdTMfVKxM05BQx1bouKW3iTWtqDhO44tnMSCaH5PePJld4ZHyu4edDZo3kcs+klNzTzr
        jxxOg+c4kL6TjnDVj/UoH0JZhUwrDOu5n39OVqLlQwsw1ye4b72dy0S9PW74o+BF9rMKcSRlnc6+/
        IgkQqbDq7f8c/m1MsIZ7ikDtc0a83asZ+uh4RzGs23h2jeq2moZUjA4HnrHBxa7JAJNQfof1pHERQ
        IoBR7u9GwDBodNygu0k6Fs907we6JzTroGTGbTs2eX3K0jagkp0iCzY5nfS1QvEQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.97-RC1)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qquZU-00000003Jim-1kjc;
        Thu, 12 Oct 2023 14:13:44 +0200
Message-ID: <dfb80594f144fd4ad4cfc7ef205ec0590ce6ca2f.camel@sipsolutions.net>
Subject: Re: [PATCH 2/3] cfg80211: validate RU puncturing bitmap
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Aloka Dixit <quic_alokad@quicinc.com>,
        linux-wireless@vger.kernel.org
Cc:     Jeff Johnson <quic_jjohnson@quicinc.com>
Date:   Thu, 12 Oct 2023 14:13:43 +0200
In-Reply-To: <9fd4a3097e078c1fe2acd5fbd0c559b0390daa49.camel@sipsolutions.net>
References: <20220214223051.3610-1-quic_alokad@quicinc.com>
         <20220214223051.3610-3-quic_alokad@quicinc.com>
         <a9813545a25cd63f71cc31476230514a80350802.camel@sipsolutions.net>
         <6cf56be5-16d6-2bcd-150f-bf29f98b7f1b@quicinc.com>
         <58fdd62041c0388740cabea5a421c5417f959124.camel@sipsolutions.net>
         <9fd4a3097e078c1fe2acd5fbd0c559b0390daa49.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
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

And another thing - separately because it's not related to puncturing,
but in the same thread because it's related to the channel context
handling...

We also realized that a very similar thing might happen for the OFDMA
trigger frame processing. Obviously I don't know if this is hardware or
firmware in ath12k, but given the speed this happens at, at least in our
device we can't really control it up-front.

As a client, you might (for various reasons) connect to an AP with a
lower bandwidth than the AP has configured. In this case, OFDMA UL/DL is
still mostly mandatory (80 MHz STA in a 160/320 MHz BSS, 160 MHz STA in
a 320 MHz BSS). As a result, if you end up being a STA with two EH
connections (*), you have to be able to parse the trigger frame /
downlink OFDMA RU allocation according to the *AP bandwidth* (**).

(*) And expect OFDMA on them, so RU allocations are relative to the AP
bandwidth; we're assuming for now that P2P will not use OFDMA.

(**) See 36.3.2.7 80 MHz operating non-AP EHT STAs participating in
wider bandwidth OFDMA and 36.3.2.8 for 160 MHz.


As a result, I'm thinking of adding the OFDMA bandwidth to the chandef,
and then treating two different ones as incompatible, though due to (*)
we might want driver-local decision on whether OFDMA is possible or not,
at least unless you agree that we should ignore it in P2P. For HE, OFDMA
exists but you don't participate in wider-than-your-bandwidth OFMDA, so
I guess we'd treat it as not relevant there.

Then we might end up with a situation where we have two different say 80
MHz channel contexts in mac80211 because one is with a 320 MHz AP and
the other with a 160 MHz AP, but that's necessary, I think.


Thoughts?

johannes
