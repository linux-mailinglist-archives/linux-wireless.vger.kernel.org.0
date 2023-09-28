Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFB547B2178
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Sep 2023 17:38:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232032AbjI1Pi4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 28 Sep 2023 11:38:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231979AbjI1Piz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 28 Sep 2023 11:38:55 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9A41AC
        for <linux-wireless@vger.kernel.org>; Thu, 28 Sep 2023 08:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
        Resent-Message-ID:In-Reply-To:References;
        bh=vR6IcYgCqG2TcZ76fxYJN+SvYFIa+FxOfQPvAXvHMlk=; t=1695915533; x=1697125133; 
        b=XYY50sJHGzhGZe9TrgY4aKQ81fQ4VO7DH+gsZE9NFN3Jull8M5PKxTDnXC9eyMUK9xRJQIZWjKP
        G/EwmT7n3S8N+1LD6+MCoA5yTJd0OUIxilBFSfT7GxEUVu//NEGaFyjplDqrO9h5/5apYvZguOrIc
        PFlP92x4pGXoUqtP9nZj66RE7DZNsEYPp0AhEqYnJctJEnCRDU04qW0PrX8mBFS56ROSb4IIv1FI8
        epMQRW0k+3UA4CxlVoVFhdjJQ/cSJXx5mj4zF9dAPboTTdmrECkjF4C7XnbO5V3X+hyVZd0mEXtNT
        pR3LPRydswrd80PW/am8Z+ypdqEadR2JRudA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qlt6H-009sUH-2O;
        Thu, 28 Sep 2023 17:38:50 +0200
Message-ID: <ec69aa2722b07bffd6184d687861cc7e5ae9c1ef.camel@sipsolutions.net>
Subject: removing OCB/WAVE/802.11p
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Rostislav Lisovy <lisovy@gmail.com>,
        Bertold Van den Bergh <bertold.vandenbergh@esat.kuleuven.be>,
        chrisshen@skku.edu, bienaime@skku.edu, pauljeong@skku.edu,
        carloaugusto.grazia@unimore.it
Date:   Thu, 28 Sep 2023 17:38:45 +0200
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

CC'ing lots of people who touched or used this in the past in hopes of
triggering some reaction somewhere ...

I'm trying to do some cleanup in IBSS and following that some other
cleanups wrt. station allocation etc., but OCB pretty much copied the
IBSS code in this area, and I don't know how to use it, how to test it,
who's using it, if anyone is actually maintaining it, etc.

Also, it only ever got implemented for ath9k, so I'm guessing it's not
getting any traction in new products/devices.

So I'm probably going to remove it.

Any takers to help maintain it instead?

johannes


