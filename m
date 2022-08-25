Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E82D5A0C38
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Aug 2022 11:04:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238220AbiHYJEo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 25 Aug 2022 05:04:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235033AbiHYJEn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 25 Aug 2022 05:04:43 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DB6A88DCA
        for <linux-wireless@vger.kernel.org>; Thu, 25 Aug 2022 02:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=BO3b9Smj+QsNb25/lzMl2phYryOdiZtlIVRzrfC8HXA=;
        t=1661418282; x=1662627882; b=lr1wqr/ADMJwfl6Ei3fP/J4pIZJTc5RQRH1tkqkpnTbZ9/D
        MQ4JAaIt5BCx50b4kxw8C3H4EGwA/S2d6CS4zc6KqT9PzGLAOgVeep3FGNuL0/Y0+HmeIg6UtvMmu
        YEM89tUZAZXYw6BlkmI0+nCyLdlyw1VtAp/Lz0FkRpjykY5iGLp/oq6JLpot1kMByL/CMcKtLzs+A
        pAJ2gHUzz+Vf7q7vFEBKHxO4kJ/k/P9ylneKd9HHmfsuWI07siHHVU4eBlqK9APgQdB0ATzrwkebZ
        l/ExxhPXRgRGc1fa3ctwgKq4Tjh8GEnEoEy93TxmIPJuZa7hP3nGtqCbeMv6vIZA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oR8n2-00Gzhh-1u;
        Thu, 25 Aug 2022 11:04:40 +0200
Message-ID: <0344624b36425f93c515748083a0b43280979078.camel@sipsolutions.net>
Subject: Re: [PATCH 1/1] cfg80211: Allow AP/P2PGO to indicate port
 authorization to peer STA/P2PClient
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Vinayak Yadawad <vinayak.yadawad@broadcom.com>
Cc:     linux-wireless@vger.kernel.org, jithu.jance@broadcom.com
Date:   Thu, 25 Aug 2022 11:04:39 +0200
In-Reply-To: <5ee2d7c8f809c3d7f773ad4231cb894af850e1a2.1657720730.git.vinayak.yadawad@broadcom.com>
References: <5ee2d7c8f809c3d7f773ad4231cb894af850e1a2.1657720730.git.vinayak.yadawad@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-1.fc36) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, 2022-07-14 at 11:00 +0530, Vinayak Yadawad wrote:
> In 4way handshake offload, cfg80211_port_authorized
> enables driver to indicate successful 4way handshake to cfg80211 layer.
> Currently this path of port authorization is restricted to
> interface type NL80211_IFTYPE_STATION and NL80211_IFTYPE_P2P_CLIENT.
> This patch extends the support for NL80211_IFTYPE_AP and
> NL80211_IFTYPE_P2P_GO interfaces to authorize peer STA/P2P_CLIENT,
> whenever authentication is offloaded on the AP/P2P_GO interface.
>=20

This patch no longer applies, please rebase it.

johannes
