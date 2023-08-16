Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4A2477E25E
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Aug 2023 15:18:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245432AbjHPNR7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 16 Aug 2023 09:17:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245448AbjHPNRk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 16 Aug 2023 09:17:40 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3C5D1BFB
        for <linux-wireless@vger.kernel.org>; Wed, 16 Aug 2023 06:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=kLVNk+514AUgntRtETuoE4q5IODYdDfAP3cBGbMS2Cs=;
        t=1692191859; x=1693401459; b=X3CkCeOfLFVceJAKtfs55q9dlybxRGihqJ4ZRYss+Kudi8f
        UuBDdlCvXmDA92li2VWCekp89oFHr0vUIth2pAW3IQPFXwrVN+5XugYnZwISgMxWbQ3oXrE5NuKe8
        8uW8z6ebz2xD+3j6NrvGvSGfLeneOa9ryH0SFPBSORGyJZci591HNcpG/jnIIfmuY0IC7p/pzy7uz
        fRzAHtckQ10DPqThDjwXNmmNvq24poHz3WDMORY1B0eFhwGMJaNniA05q2BEHyoUF1y0wBR8ISsN9
        0kylOq6S6nUUdN5wBfzI1NwcejCxSBjTFHnb8kdOIPDpuXfUD633bKjZvggIhkeA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qWGP2-00Awtg-1K;
        Wed, 16 Aug 2023 15:17:36 +0200
Message-ID: <115d17ad02b6894ee435d8a12d311219b66e32e4.camel@sipsolutions.net>
Subject: Re: [RFC PATCH v2 6.1] wifi: cfg80211: fix cqm_config access race
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Max Schulze <max.schulze@online.de>, linux-wireless@vger.kernel.org
Date:   Wed, 16 Aug 2023 15:17:35 +0200
In-Reply-To: <96883c2f-0584-3bbf-39cc-ab50c5f1be88@online.de>
References: <20230815134247.4b4bd52ea708.I1a1bb102329fc88e4712eaf394cba3025ada0dc7@changeid>
         <20230815153741.cc51cb52a296.I1a1bb102329fc88e4712eaf394cba3025ada0dc7@changeid>
         <98456a69-d597-505c-6a1b-f33b5f6343e9@online.de>
         <96883c2f-0584-3bbf-39cc-ab50c5f1be88@online.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, 2023-08-16 at 15:08 +0200, Max Schulze wrote:
> Trace from the system I couldn't reach.
>=20
> Looks similar to the first.

Thanks.

> There must be something at odds with the patch.

Yeah I guess I haven't made it any better, have I :)


> Aug 16 09:27:04 h91 kernel: brcmfmac: brcmf_cfg80211_get_station RSSI -57=
 dBm

It's kind of interesting that we see this preceding the crash - even if
the crash then is in something else entirely. Makes me think something
else got corrupted here. I'll take a look at the patch again, maybe I
can spot something.

johannes

