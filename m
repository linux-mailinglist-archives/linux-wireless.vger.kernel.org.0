Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BD5D7AD3F5
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Sep 2023 10:59:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233113AbjIYI7Q (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 25 Sep 2023 04:59:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233102AbjIYI7P (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 25 Sep 2023 04:59:15 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5BDBD3
        for <linux-wireless@vger.kernel.org>; Mon, 25 Sep 2023 01:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=BJ9w/x/gPTKfHlecBJ73dvr8Wfl8rcbPAjrak8ydKnU=;
        t=1695632348; x=1696841948; b=azidxmYPNTUbHYSUzSnEssbYV4tfkjcT0rCD1hc86KAycKz
        edaxkPWMSu77N2NTJ2ZB0OSNaOMZ/2Ib2qXv7i8IRW0HHq81B0Y30PLYTMHLda/c+3vH1Ba3xec25
        2CgtsSvJCzfH0T5EKWNsbSauvObVXkQW0LYHQSaqyrNhhaV9kpylNQkF/wJtbLnj/BbDP7zlAZXzF
        52cK8qZpN9nr4Nd0LJF1LZBiETVIcp1BFmGAoPySj53zFx3f5HpL4o84f5vUICPkQK+nibZ0QSj7s
        I+QrpJA/rhbzGeGt0R/xi7/q40TSpnlWfnoFwopD1aX9YT8TypeVkyq8hn7XYHkQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qkhQn-003Mgt-2s;
        Mon, 25 Sep 2023 10:59:06 +0200
Message-ID: <7e6076e276f4fd952326208e11998f65df061eac.camel@sipsolutions.net>
Subject: Re: [PATCH v3 1/1] cfg80211: Allow AP/P2PGO to indicate port
 authorization to peer STA/P2PClient
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Vinayak Yadawad <vinayak.yadawad@broadcom.com>
Cc:     linux-wireless@vger.kernel.org, jithu.jance@broadcom.com
Date:   Mon, 25 Sep 2023 10:59:04 +0200
In-Reply-To: <d91c22826cb7d66f78950a953f18fd0d64d496b2.1695385607.git.vinayak.yadawad@broadcom.com>
References: <d91c22826cb7d66f78950a953f18fd0d64d496b2.1695385607.git.vinayak.yadawad@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
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

On Fri, 2023-09-22 at 18:19 +0530, Vinayak Yadawad wrote:
> In 4way handshake offload, cfg80211_port_authorized enables driver
> to indicate successful 4way handshake to cfg80211 layer. Currently
> this path of port authorization is restricted to interface type
> NL80211_IFTYPE_STATION and NL80211_IFTYPE_P2P_CLIENT. This patch
> extends the support for NL80211_IFTYPE_AP and NL80211_IFTYPE_P2P_GO
> interfaces to authorize peer STA/P2P_CLIENT, whenever authentication
> is offloaded on the AP/P2P_GO interface.
>=20
> Signed-off-by: Vinayak Yadawad <vinayak.yadawad@broadcom.com>
> ---
> v2->v3: Fixed indentation in comment

Well, I had another comment on v2, and this patch _still_ doesn't apply.

Also please put 'wifi: ' prefix on all your patches. I've fixed the
other one for you, but I don't want to do it all the time.

johannes

