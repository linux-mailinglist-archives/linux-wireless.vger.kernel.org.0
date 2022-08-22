Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF56159BD86
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Aug 2022 12:22:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234647AbiHVKWD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 22 Aug 2022 06:22:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234645AbiHVKWC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 22 Aug 2022 06:22:02 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C0142A72C
        for <linux-wireless@vger.kernel.org>; Mon, 22 Aug 2022 03:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=R520qLhvi6eR64QPobcb0tF+bZFFRligcxZ5sitGwwQ=;
        t=1661163719; x=1662373319; b=GI9g85V1kT2cbRLXw7RXAhIHQRgvDqRdLRNTi9Uf/0jkqNb
        jIdKQXs8Jgl25e2COncMqkCUxGiQ/Aq60QCknqDhnjAhFDApeHAPKTChWHGbiIqlpLWLOBE7be0h+
        0aQ2vHO46Ggbxw1MxMr1cLzJagNjAwqQ/jItO6k9pNPZAJmWgG4o1QmzYonEJC/bg+bi0IY4Oqe6E
        VZb7ZPEVXaY4Dd8LfS8awQESd3rfAhzdQ1XICS/gRXwmWTj8Pd2MwVjEscHf1h7kG9MLY72oN3Put
        FdrYLyN6CA0C1Wxcf4D5QDqghCXBTxto7EbV0nZetRVw7iv3RX3WXZZrO8rqq1fQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oQ4Z4-00EU40-0e;
        Mon, 22 Aug 2022 12:21:50 +0200
Message-ID: <644e506ab60a58b95bdbbb5d9c3e425622931f8f.camel@sipsolutions.net>
Subject: Re: New 6.1 net/mac80211/rx.c warning with iwlwifi / Ultimate-N
 6300 wifi
From:   Johannes Berg <johannes@sipsolutions.net>
To:     =?ISO-8859-1?Q?Lu=EDs?= Henriques <lhenriques@suse.de>,
        Hans de Goede <hdegoede@redhat.com>
Cc:     Gregory Greenman <gregory.greenman@intel.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>
Date:   Mon, 22 Aug 2022 12:21:49 +0200
In-Reply-To: <YwNNXKEFcX/GK2Sv@suse.de>
References: <498d714c-76be-9d04-26db-a1206878de5e@redhat.com>
         <YwNNXKEFcX/GK2Sv@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-1.fc36) 
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

On Mon, 2022-08-22 at 10:33 +0100, Lu=C3=ADs Henriques wrote:
> On Sat, Aug 20, 2022 at 03:12:33PM +0200, Hans de Goede wrote:
> > Hi All,
> >=20
> > While testing 6.0-rc1 on a Dell Latitude E6430 with:
> >=20
> > 03:00.0 Network controller: Intel Corporation Centrino Ultimate-N 6300 =
(rev 35)
> >=20
>=20
> I've just seem a similar splat on -rc2, with a different card:
>=20
> 02:00.0 Network controller: Intel Corporation Wireless 8260 (rev 3a)
>=20

Yeah this is an issue with the new multi-link work.

We've seen it too, though the rx->link _should_ be set to deflink here
in the cases of non-MLO connections.

We're investigating.

johannes
