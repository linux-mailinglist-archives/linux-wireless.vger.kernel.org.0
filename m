Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 122A179E3C1
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Sep 2023 11:31:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239183AbjIMJbJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 13 Sep 2023 05:31:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239027AbjIMJbJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 13 Sep 2023 05:31:09 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 636761726
        for <linux-wireless@vger.kernel.org>; Wed, 13 Sep 2023 02:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=0HjGzzpL5e6VD8lATmDxACQc4Lc6/wISHHGG+pYQZLI=;
        t=1694597465; x=1695807065; b=e5CkxGFSMkE0wC2VnKTw2JLELGxdMPNCW9w6gPwT/PVKvNA
        aaIFCDgtHF+2f9+ykhgsqr7boBFV7JU8jYAse/lUi6kYnrT8k9R6p42Pr6jjTl5nT5JorGbwssLL+
        zit7ongNrKwHpEHWNs3QpvBFUvsS0uKEsrjagyhw7DsHXThi7zWN2qk74uso2gtEAYa6XdFBHwN+e
        rIAA5OimW7DCm1IaP3ZL7JlFGGADtF1Z4PbaGSibj7CCy/xEKL+WdnCJYvl7qxTpLp+W9VPgDiUGk
        rfB+E+k/Q7UzZk+6bQMKkHfeMgrwAD7nf2YvUUtLpz3LpMgEGg1s93uvcZ2mriRA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qgMD8-00Ejcq-2g;
        Wed, 13 Sep 2023 11:31:03 +0200
Message-ID: <7d4eae1a38e3791e467bf29195abd781e43789ce.camel@sipsolutions.net>
Subject: Re: [PATCH 1/1] cfg80211: Allow AP/P2PGO to indicate port
 authorization to peer STA/P2PClient
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Vinayak Yadawad <vinayak.yadawad@broadcom.com>
Cc:     linux-wireless@vger.kernel.org, jithu.jance@broadcom.com
Date:   Wed, 13 Sep 2023 11:31:01 +0200
In-Reply-To: <85614ee38fd3f68ade1810c2be0863c45c22fef1.1694499025.git.vinayak.yadawad@broadcom.com>
References: <85614ee38fd3f68ade1810c2be0863c45c22fef1.1694499025.git.vinayak.yadawad@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 2023-09-12 at 12:24 +0530, Vinayak Yadawad wrote:
> In 4way handshake offload, cfg80211_port_authorized
> enables driver to indicate successful 4way handshake to cfg80211 layer.
> Currently this path of port authorization is restricted to
> interface type NL80211_IFTYPE_STATION and NL80211_IFTYPE_P2P_CLIENT.
> This patch extends the support for NL80211_IFTYPE_AP and
> NL80211_IFTYPE_P2P_GO interfaces to authorize peer STA/P2P_CLIENT,
> whenever authentication is offloaded on the AP/P2P_GO interface.

It seems that this should at least also come with documentation updates
in nl80211.h?

And proper code indentation :-)

> - * @bssid: the BSSID of the AP
> + * @peer_mac: BSSID of the AP/P2P GO in case of STA/GC or STA/GC macaddr=
ess in
> + * case of AP/P2P GO

And "peer_addr" is probably better? Technically, after all, it's the
"MAC address" (which you also spelled wrong), but the "MAC" itself :)

johannes

