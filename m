Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63EBA722CDA
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Jun 2023 18:42:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233724AbjFEQmQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 5 Jun 2023 12:42:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233996AbjFEQmO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 5 Jun 2023 12:42:14 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EDA5CD
        for <linux-wireless@vger.kernel.org>; Mon,  5 Jun 2023 09:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=sZRVu8ZHGsDmzQgEnTw2dd6E6AR6oq7Up1vwUMzxZJU=;
        t=1685983333; x=1687192933; b=gHIsnay9an5z6pL2pRQ4wLQLc8fauwROzo+vPlIz/gihVkb
        fdbIpxZz9K9AX+AQ7cm8+KlNRzJFNT3ir5BmerwOoCURDFNOLLFtcWTtjy22MleNYNoQlhvHn6Ogh
        ZEavHGNZTk95JaYvcUMvN3PWu+5XBy3I3h9opJXB283t7bo4jvtsEWSAbDq8NTsNZZP6deFGtWSaw
        8XaLcfk1ZiEFiu9wcjbcfjkpDufu81nR1S3h+aiOS9rfhEaKIbW6KoOoK1EWG7XDdug/I9+KPEonQ
        5by9zQBEZWXiUM4Mf/kVudjAgaKBubuZ1JQjN3/OmrA3LDjhVZt5UeuQH0k+X8VA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1q6DHW-00EXwI-1u;
        Mon, 05 Jun 2023 18:42:10 +0200
Message-ID: <8545d75827ff8d85fece58542539db6c9930d3b6.camel@sipsolutions.net>
Subject: Re: [PATCH 1/2] wifi: cfg80211: Reject (re-)association to the same
 BSSID
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Kevin Lund <kglund@google.com>, linux-wireless@vger.kernel.org
Date:   Mon, 05 Jun 2023 18:42:08 +0200
In-Reply-To: <20230602225751.164525-1-kglund@google.com>
References: <20230602225751.164525-1-kglund@google.com>
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

On Fri, 2023-06-02 at 16:57 -0600, Kevin Lund wrote:
> Within cfg80211_connect, reject the (re-)association request if we are
> already connected to the exact BSSID which is being requested. This
> prevents an unnecessary attempt to connect which in the best case
> leaves us back where we started.
>=20
> There is precedent for behaving this way over on the userspace SME side
> of things in cfg80211_mlme_auth. Further, cfg80211_connect already makes
> several basic checks to ensure the connection attempt is reasonable, so
> this fits in that context.
>=20

I don't think this is right - we should be able to reassoc back to the
same AP in some cases, for example in 11be this comes up when you want
to change the negotiated links.

johannes
