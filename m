Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 514A07224C4
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Jun 2023 13:38:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232641AbjFELiu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 5 Jun 2023 07:38:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231322AbjFELit (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 5 Jun 2023 07:38:49 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B85B9196
        for <linux-wireless@vger.kernel.org>; Mon,  5 Jun 2023 04:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=Q05Sht0M/UTJAa12ckxTm287Qi60jCMnj7q/oBAgy3Q=;
        t=1685965117; x=1687174717; b=SgsqyDwyxDlJ0mJPoEynOWL3U+Dd/7T7huxMNBv890eYek1
        aH4ZuzCFJvw24tVc8HkprUKaXAxEuO1ZIDKt2XJP1v/NrLe0hfrP1BXgMdbE6ErgxAOlN4sWfEuwn
        B2g1wpbUwrcNpU6OswAy5TEo86jBT059qh95jdIT402yhn6UuP9SMkHbyx3AyOK/s88dzfzM//dsh
        tGN1pktDKDHAez4Voz9fPEbe3qGIpt0fwYq+42F3azxP1npQ2fDk0RVyzNVrxiW6SYpZ1H5QJH0uM
        LAnP6tyaYjn4YspXypEcphNQx667ri0J3oNXDse7itbsQl4AMxlyoZq4zcwiXdpw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1q68Xi-00ER1W-2c;
        Mon, 05 Jun 2023 13:38:34 +0200
Message-ID: <74f52855912292d48ea80d76f4685998a1c3beec.camel@sipsolutions.net>
Subject: Re: [PATCH 09/11] wifi: cfg80211: Add null check for ie data
From:   Johannes Berg <johannes@sipsolutions.net>
To:     gregory.greenman@intel.com
Cc:     linux-wireless@vger.kernel.org,
        Mukesh Sisodiya <mukesh.sisodiya@intel.com>
Date:   Mon, 05 Jun 2023 13:38:34 +0200
In-Reply-To: <20230504134511.828474-10-gregory.greenman@intel.com>
References: <20230504134511.828474-1-gregory.greenman@intel.com>
         <20230504134511.828474-10-gregory.greenman@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.2 (3.48.2-1.fc38) 
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

On Thu, 2023-05-04 at 16:45 +0300, gregory.greenman@intel.com wrote:
> From: Mukesh Sisodiya <mukesh.sisodiya@intel.com>
>=20
> It's valid to pass NULL "ies" pointer to cfg80211_sme_get_conn_ies().
> Add the corresponding NULL-check to avoid NULL pointer access.

Yes ... but it's not valid to do that when ies_len is 0, since you can't
have NULL ies with a length ...

So ... maybe we can do this patch but certainly the description is
bogus. Maybe you're trying to fix some static checker warnings or
something, which maybe is fine, but there was never any chance for an
NPD.

johannes

