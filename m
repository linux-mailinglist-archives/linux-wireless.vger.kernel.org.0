Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D58773A78A
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Jun 2023 19:43:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbjFVRnt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 22 Jun 2023 13:43:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjFVRnr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 22 Jun 2023 13:43:47 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC4F41BD6
        for <linux-wireless@vger.kernel.org>; Thu, 22 Jun 2023 10:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=m+oF7eVgolTuMYcbjtdkwjdRRUAjVsIgW8iaSlkFAu4=;
        t=1687455826; x=1688665426; b=kR0QOAmGwbjmFMz48FtZtioktjEpn8d/gy8zyMVT223ngxZ
        kPOsxk36yM2EcGKR7//fVqEcWfqwf2qHchmL+n2vVn9C/ijZfEZLpGTonNEAT+yoX8UL90/dCUJa/
        sIBxmHEDByXAvgLj3W3xKPUJ1gCicv72B22znnmJiWItgwnbstxsG2jVt3kYJAPnvZYYdD/aUUjqN
        0mS30NNql4FqPfjm8W6xA8MMyr+RB7rX2VoOUdlkPO5EZnazCFh6nLBhhmEja7Y52nSwn3CqkOuuw
        6vP/xBVcGQfIoDidEb14qgqPswaLML5+MTsF90QfggnGoWfmIi80LemLLPuAn13g==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qCOLQ-00EqOW-1K;
        Thu, 22 Jun 2023 19:43:44 +0200
Message-ID: <139908050c1c5941d791c228ef06fdfd55615d32.camel@sipsolutions.net>
Subject: Re: [bug report] wifi: mac80211: store BSS param change count from
 assoc response
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     linux-wireless@vger.kernel.org
Date:   Thu, 22 Jun 2023 19:43:43 +0200
In-Reply-To: <1c031edf-a2ab-4548-a181-16b8c641d786@moroto.mountain>
References: <1c031edf-a2ab-4548-a181-16b8c641d786@moroto.mountain>
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

On Thu, 2023-06-22 at 17:47 +0300, Dan Carpenter wrote:
>=20
>     4922         if (control & IEEE80211_MLE_STA_CONTROL_COMPLETE_PROFILE=
 &&
>                                                                          =
 ^^
> Should this be ||?
>=20
>     4923             control & IEEE80211_MLE_STA_CONTROL_NSTR_BITMAP_SIZE=
) {
>     4924                 if (control & IEEE80211_MLE_STA_CONTROL_NSTR_BIT=
MAP_SIZE)
>=20
> This is always true because it's checked on the previous line.
>=20

Oops. There are actually two places doing this, I think I copy/pasted
it.

But the second part of the if statement should simply be removed. The
COMPLETE_PROFILE bit indicates whether or not the NSTR bitmap is
present, and the NSTR_BITMAP_SIZE bit indicates how it's encoded (8 or
16 bits).

Thanks!

johannes
