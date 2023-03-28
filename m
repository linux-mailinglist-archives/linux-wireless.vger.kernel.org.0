Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65A576CB853
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Mar 2023 09:39:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbjC1HjR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 28 Mar 2023 03:39:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjC1HjR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 28 Mar 2023 03:39:17 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A648196
        for <linux-wireless@vger.kernel.org>; Tue, 28 Mar 2023 00:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=1aCiWsotuTKKkpfjYxMqVJAlIn/qwNM5nDZjA2y6tgI=;
        t=1679989156; x=1681198756; b=db0p6rmKrVxMkRX9iCK9yIF/n9dFkNNvvlec+Duu7Aa5rvj
        Q5/MbaCY4gFL/UucugBbx9sx62C1GKz4upODJ8Y1DoYV8Ev/Y118zPs6gj7jAc/hbHLCaEsGzmcQ/
        MyZIXujO+8AK1imPFLpfg4g39lodzoPssg15F8Fovk/2/DS7vNWgVeLvErnN78qJGGFwRJrWmOGhP
        uXPwkaQme90rFZmUmwbwtbr0Co0IM5pW5keg7M6ADStdZ4VqCXjwETvZEleBKoAL3A/JXtVkkMZaR
        IARxJ0JSYtqDeLZ5JLMFBXTGpv35ieXQU5Y2bV7OHZYPOnv8QifB0qGJg/AbKn8A==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1ph3vF-00Ga82-34;
        Tue, 28 Mar 2023 09:39:14 +0200
Message-ID: <106ad2b4934efd2f81d51b2e66336954bee7c185.camel@sipsolutions.net>
Subject: Re: [PATCH 24/27] wifi: mac80211: implement link switching
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Wen Gong <quic_wgong@quicinc.com>, linux-wireless@vger.kernel.org
Cc:     ath11k@lists.infradead.org, ath12k@lists.infradead.org
Date:   Tue, 28 Mar 2023 09:39:12 +0200
In-Reply-To: <7872a08d-fe37-a876-713d-c5ec40c1893f@quicinc.com>
References: <20220902141259.377789-1-johannes@sipsolutions.net>
         <20220902161143.d99dfbe65c90.I92385ba882ec984a9a2ad18293173436657e82aa@changeid>
         <ca5177fe-3b9f-2309-9afd-1d5e827540f7@quicinc.com>
         <50719d34bc48d816d00b56d3d9efdb59e3e51a16.camel@sipsolutions.net>
         <7872a08d-fe37-a876-713d-c5ec40c1893f@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 2023-03-28 at 15:37 +0800, Wen Gong wrote:
> On 3/27/2023 4:31 PM, Johannes Berg wrote:
> ...
> > > Also I see commit(8fb7e2ef4bab mac80211_hwsim: always activate all li=
nks) and ieee80211_if_parse_active_links()
> > > will use ieee80211_set_active_links(), so I think ieee80211_set_activ=
e_links() has passed test case with some type lower driver/chip?
> > Yes, we have this working on iwlwifi/mvm.
> >=20
> > johannes
> May I know how did you test it?

Just writing to the debugfs file. We have various tests using that now.


johannes
