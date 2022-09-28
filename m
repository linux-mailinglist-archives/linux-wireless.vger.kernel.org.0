Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA7635EE070
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Sep 2022 17:29:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234449AbiI1P3R (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 28 Sep 2022 11:29:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233895AbiI1P27 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 28 Sep 2022 11:28:59 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44CC24DB32
        for <linux-wireless@vger.kernel.org>; Wed, 28 Sep 2022 08:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=37EOxp/iCVHSBCtfr+3t/FcQTpssKgQl/uIYUuUiCAA=;
        t=1664378937; x=1665588537; b=NvXAPlFV59BvHZUiljSdyU5RQsp2Zq3tD0IWey/maNXwhSX
        aTTD0PAaufrGmRyFmHcQm2QKbpb3UsxCRDrileiHYu19fX5J9bDf1i6dP1s2Io27NbtZBWy321G3l
        0m8GEilFm5jU8YajPmvWtQmI/kOZyhkZz6nlj8MhGemXWidySHqvxzaC7xYNxldO0U713EpHEnILH
        Y+MnZoE59o5ZThCOnn3do3GTk8VOXNA1A6S5+Js7kPcXJ5UQFAdvWOw/d2Ut7Tyg+SpC3ncDcD+iJ
        cg6jiu3OiW5369YQD2W5c4UtN6mypnRVZrAzhhtTdDQqF0OHYARKcAg2FUN5QnsA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1odYzV-00ARg9-2U;
        Wed, 28 Sep 2022 17:28:53 +0200
Message-ID: <868131d13ed7c4c8b5d4938adcd71cf1ff8e9677.camel@sipsolutions.net>
Subject: Re: [PATCH 10/27] wifi: mac80211: isolate driver from inactive links
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Wen Gong <quic_wgong@quicinc.com>, linux-wireless@vger.kernel.org
Cc:     ath11k@lists.infradead.org
Date:   Wed, 28 Sep 2022 17:28:52 +0200
In-Reply-To: <d1fda46a-2481-8e05-e0a5-9f2bd3850ff4@quicinc.com>
References: <20220902141259.377789-1-johannes@sipsolutions.net>
         <20220902161143.5ce3dad3be7c.I92e9f7a6c120cd4a3631baf486ad8b6aafcd796f@changeid>
         <5d82e564-86bf-c26b-077a-d0bc14e2d3c3@quicinc.com>
         <74f3eb848326607b15336c31a02bdd861ccafb47.camel@sipsolutions.net>
         <2de44394-cb93-7be4-481f-2d92788b8d28@quicinc.com>
         <351f74e0e1cd6e9724f97dbd042bdc5e04c44842.camel@sipsolutions.net>
         <c05780bc-864c-9323-499d-a8b1ba1c2ef2@quicinc.com>
         <545227cf18baac94ea8aa24dc08b250c47949541.camel@sipsolutions.net>
         <c7fd18fa-531f-a90d-a8fb-442a5aa66d7d@quicinc.com>
         <d1fda46a-2481-8e05-e0a5-9f2bd3850ff4@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
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

Hi,

Sorry - still catching up from PF related matters ...

> May I know some more info/status about the "incoming=C2=A0 new method to =
let=20
> drivers set the link address"?
>=20

I wasn't actually planning to work on that myself, FWIW.

johannes
