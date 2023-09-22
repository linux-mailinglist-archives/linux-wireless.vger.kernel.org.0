Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28D957AAE10
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Sep 2023 11:32:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233002AbjIVJci (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 22 Sep 2023 05:32:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233170AbjIVJc0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 22 Sep 2023 05:32:26 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B601171A
        for <linux-wireless@vger.kernel.org>; Fri, 22 Sep 2023 02:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=Frg5hyq2bBM60XTLJ/qKchKmDsCMKE27yBIudsgMRqE=;
        t=1695375084; x=1696584684; b=O2Y4LcKifLvLJWSWKteWFU9UD88UEozNdN9dhmVqHRIo/TZ
        Gjd4cm6UWX3fBKonUNUV5p6WM223pZ3/dmBG3ZtV8vJuJkktir3zTD5g34+2fpOM7BZptFLOQtAxd
        dn4JvA6AOwsidYhyrU4JUsAb2b19kn48Lq1N4GH+MYlEpUyBJfFpEyOg9sPFFTqpf+oaqqujWldIa
        FUCKS720d4s2/Fl31sMkMwhzbVb8NagAv2V+DU+uMFxzVsbhOj6cnQGZWMfENvf63XBHA+QVj62tV
        l3TzCZayvxjn9qqcCJ21rAbThSV6dDQYeT3843sd2mW+KwPmigAC+EU9ZADZ1tTg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qjcVN-00F71i-0r;
        Fri, 22 Sep 2023 11:31:21 +0200
Message-ID: <05bfe2ff2771770ce119601adf30e14dded3a4ff.camel@sipsolutions.net>
Subject: Re: [PATCH 1/1] cfg80211: OWE DH IE handling offload
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Vinayak Yadawad <vinayak.yadawad@broadcom.com>
Cc:     linux-wireless@vger.kernel.org, jithu.jance@broadcom.com
Date:   Fri, 22 Sep 2023 11:31:19 +0200
In-Reply-To: <f891cce4b52c939dfc6b71bb2f73e560e8cad287.1695374530.git.vinayak.yadawad@broadcom.com>
References: <f891cce4b52c939dfc6b71bb2f73e560e8cad287.1695374530.git.vinayak.yadawad@broadcom.com>
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

On Fri, 2023-09-22 at 14:55 +0530, Vinayak Yadawad wrote:
> Introduce new feature flags for OWE offload that driver can
> advertise to indicate kernel/application space to avoid DH IE
> handling. When this flag is advertised, the driver/device will
> take care of DH IE inclusion and processing of peer DH IE to
> generate PMK.
>=20

Seems like you'd also need something that userspace actually says
"please offload this", so you don't end up doing it twice if it's an
older userspace?

johannes
