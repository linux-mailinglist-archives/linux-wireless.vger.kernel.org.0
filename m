Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39685663F30
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Jan 2023 12:20:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbjAJLUo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 10 Jan 2023 06:20:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230083AbjAJLUn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 10 Jan 2023 06:20:43 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CA5FC52
        for <linux-wireless@vger.kernel.org>; Tue, 10 Jan 2023 03:20:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=3/Zjpyu/hL6l1jAce40mRGZ15IHg2m4Iv5XWRyxjQLg=;
        t=1673349642; x=1674559242; b=FxDsfFAjQNQiI2LkWE7Z83rV3EhxpRLadoRJHKHtRLoFfLk
        IuUow7JBUnAhNJ2uU9xVl8NZUzSiYTQjtV50+IPKEoQirEfXULFgWcTWEZVx7UoyLrfzKlh0jvp1i
        Xz8Or1avpLCDXk+eP2u5f7l0qWU/gLvJEBAYaWB+O0/ZzC9wNb8I3T/gMEtIi8+nE3IUrm6PnYENB
        y3rdEzd/IOFVuFEPyMPkwaUn+Y4JD/T9vI7h74JEojCJ48/60kaiYD4sV77nrt/2EX4QPtNv5IkuS
        FuhK7MwnO79v32ONakaRoWMFg10azvA5o58oLbCHEkffgC7FiZ/7UUnjULL3uKxg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1pFCgI-00FCpZ-1J;
        Tue, 10 Jan 2023 12:20:38 +0100
Message-ID: <9a2e054444a84e2645cf6397934313b0c41fb725.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: mac80211: add support for scanning in ap mode
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Nick <vincent@systemli.org>, linux-wireless@vger.kernel.org
Cc:     nbd@nbd.name, "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Date:   Tue, 10 Jan 2023 12:20:37 +0100
In-Reply-To: <e41d9701282ba434871e3c3e28798fa4f16c582b.camel@sipsolutions.net>
References: <20230110110524.511258-1-vincent@systemli.org>
         <a7ccf0e6a1481f592fa9ff81f7b6545a4f4a653f.camel@sipsolutions.net>
         <cc230245-2599-7665-3785-150dee0bf873@systemli.org>
         <e41d9701282ba434871e3c3e28798fa4f16c582b.camel@sipsolutions.net>
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

On Tue, 2023-01-10 at 12:19 +0100, Johannes Berg wrote:
> On Tue, 2023-01-10 at 12:18 +0100, Nick wrote:
> > Thanks for your feedback. Can you suggest a better way to do this?
> >=20
>=20
> Well there already is NL80211_SCAN_FLAG_AP?
>=20

Oh sorry you want it independent of the driver.

But why? This was primarily a thing for "does the firmware even support
this".

So really then your driver should set it?

johannes
