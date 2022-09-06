Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 190F85AE1D2
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Sep 2022 10:03:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232972AbiIFIDj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 6 Sep 2022 04:03:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231569AbiIFIDi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 6 Sep 2022 04:03:38 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDC6A5508C
        for <linux-wireless@vger.kernel.org>; Tue,  6 Sep 2022 01:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=NiJR9Su2W87OUOjm2p5pYM/FpIgS26uEd6G8KziU/ro=;
        t=1662451416; x=1663661016; b=nVKfzazWkco0HFrML3kus737L2YoOuwSENr+VOmDFxeQMVd
        gAIhGLvHtT8rUUImfF9VlyuxpkiC9dNsib20FQrDBZLZLa+YQOxjNixxg+9WMKPTOKGdODImYcfJ3
        eduaAqFoA1Z6+3ns0BOOle6vA3pz0pdfavpAowuZjVedQRMZkEpHcz4B0P1eejjmdQUCLZSF6GQru
        EVMnGJvP3p5rKnFnyHHh7G34WIqglnIe8UykfijdeOPNGU6foHCVM9/pymq3hTmqYsQWLLe4QO7iw
        D+u+By+2xhhUQkyW4ESrM46Svz6Vz7QFnJVNr+bwHYiRksNOiFC1fct29Q6K+9YA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oVTYU-009KWu-18;
        Tue, 06 Sep 2022 10:03:34 +0200
Message-ID: <e01e75013f71ede7b29f2751238935e7147796f2.camel@sipsolutions.net>
Subject: Re: [PATCH 00/27] another set of MLO patches
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Wen Gong <quic_wgong@quicinc.com>, linux-wireless@vger.kernel.org
Cc:     ilan.peer@intel.com, andrei.otcheretianski@intel.com
Date:   Tue, 06 Sep 2022 10:03:33 +0200
In-Reply-To: <935ef9e9-2092-e3f0-0edd-4aa29f4fa775@quicinc.com>
References: <20220902141259.377789-1-johannes@sipsolutions.net>
         <6175bc95-201c-cfab-2ae6-9ba77e830394@quicinc.com>
         <09556b33ad998ad243cf75dbc230f3b07349a87e.camel@sipsolutions.net>
         <935ef9e9-2092-e3f0-0edd-4aa29f4fa775@quicinc.com>
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

On Tue, 2022-09-06 at 15:58 +0800, Wen Gong wrote:
>=20
> Now I hit an issue is: wpa_supplicant reject the authentication from AP=
=20
> while connecting.
> because the addr of authentication is replaced the link=20
> bssid(00:03:7f:12:99:99) with MLD address(aa:03:7f:12:99:99) in=20
> mac80211's ieee80211_prepare_and_rx_handle().
> wls1: SME: Ignore authentication with unexpected peer aa:03:7f:12:99:99
>=20

Well, OK, you obviously are adjusting the supplicant to work with MLO
(otherwise you wouldn't get an MLO connection in the first place), so
yeah, this is part of the adjustments needed.

Ilan/Andrei have all of this working, maybe we can share the patches
even before rebase etc.

johannes
