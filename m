Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAE0C73A8B5
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Jun 2023 21:00:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbjFVTAr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 22 Jun 2023 15:00:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230090AbjFVTAq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 22 Jun 2023 15:00:46 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53FAA186
        for <linux-wireless@vger.kernel.org>; Thu, 22 Jun 2023 12:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=F/2ZuQbqUheUNKvNQWlTc+fFluEGxvy6I4h3lsMDex4=;
        t=1687460445; x=1688670045; b=djmZITu1LbGCODaxOcdMpr0ojW9gFefNM+6DHLFS+JnnAgV
        awOMZ43gqlv7k1sgpy7x9QHMzt4BGaWb40sao+GAoUtUch3XISwe+xZLG9yEWjyEtj24T2EvqcxVh
        CTy+nKz4kaqcmfBz9Mfsytb33bVwf+iPfInh1Xfv4JpzOZag0CaEDWjTXPsYePajoNnAiz1tCoXhv
        3oM9FeT/Sjg9yCDHhzg5xN4X1GH7vuD6XbC/GBClwUBO+FMXhdglnldX1f0Ga9EOdDF/LRGHHR12C
        zq1QoHRaIT591YuFkwBOc43RKOK4DAglp9tThq8j8fMbgxmH2nADS7WAnOavoA2g==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qCPXv-00EsDm-2L;
        Thu, 22 Jun 2023 21:00:43 +0200
Message-ID: <e35f9776f7defdedfe9bc40d2c03418857c428f8.camel@sipsolutions.net>
Subject: Re: [bug report] wifi: mac80211: store BSS param change count from
 assoc response
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     linux-wireless@vger.kernel.org
Date:   Thu, 22 Jun 2023 21:00:42 +0200
In-Reply-To: <139908050c1c5941d791c228ef06fdfd55615d32.camel@sipsolutions.net>
References: <1c031edf-a2ab-4548-a181-16b8c641d786@moroto.mountain>
         <139908050c1c5941d791c228ef06fdfd55615d32.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.3 (3.48.3-1.fc38) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, 2023-06-22 at 19:43 +0200, Johannes Berg wrote:
> On Thu, 2023-06-22 at 17:47 +0300, Dan Carpenter wrote:
> >=20
> >     4922         if (control & IEEE80211_MLE_STA_CONTROL_COMPLETE_PROFI=
LE &&
> >                                                                        =
   ^^
> > Should this be ||?
> >=20
> >     4923             control & IEEE80211_MLE_STA_CONTROL_NSTR_BITMAP_SI=
ZE) {
> >     4924                 if (control & IEEE80211_MLE_STA_CONTROL_NSTR_B=
ITMAP_SIZE)
> >=20
> > This is always true because it's checked on the previous line.
> >=20
>=20
> Oops. There are actually two places doing this, I think I copy/pasted
> it.
>=20
> But the second part of the if statement should simply be removed.

Actually that's wrong, it should check the present bit :) Anyway, fixed,
thanks.

johannes
