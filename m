Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 266EF67C895
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Jan 2023 11:31:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236251AbjAZKbJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 26 Jan 2023 05:31:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230178AbjAZKbI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 26 Jan 2023 05:31:08 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C23CD34014
        for <linux-wireless@vger.kernel.org>; Thu, 26 Jan 2023 02:31:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=Ang0T1CjTMF7XS5S6tGypgX3zgYghdcNj7spIodOMrk=;
        t=1674729064; x=1675938664; b=JRSG7TK+Y8dQFKEGbiBK0lnfo3doCt8FCwiDBttywj2ElLN
        W+B5x8W/prtMdvy1swlpWfXCgSBTvsnANPhmQFIQtQuNbX+XIVPAhzqvX3pLwc/+sqWquaPNzwyxY
        qLAZ37AFys20yMrwLtgQ5M7SYqmF5fsPBfyASx4vu0slPraa29nQiLfwDVp8ke/B+n1N/tRU97ALU
        /1cSIEeHIMwqQJ6eqV/S1N0nPibUrRUMOkyBm4OmVnAC7MpYuBz6bhT4gKKF++8aZpjnXXt3xsd4Y
        +kG94cIFQFZ5Q7gO/lqoXf+WrlR7P9bE4B8OA6K625NqNFMljfdzitibQe++ECAw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1pKzX3-00CctT-2g;
        Thu, 26 Jan 2023 11:31:01 +0100
Message-ID: <8ae3732af14499d35704afe7c246d173af091b4e.camel@sipsolutions.net>
Subject: Re: [PATCH] nl80211: Allow authentication frames and set keys on
 NAN interface
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Vinay Gannevaram <quic_vganneva@quicinc.com>
Cc:     linux-wireless@vger.kernel.org
Date:   Thu, 26 Jan 2023 11:31:00 +0100
In-Reply-To: <1674568319-27964-1-git-send-email-quic_vganneva@quicinc.com>
References: <1674568319-27964-1-git-send-email-quic_vganneva@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.3 (3.46.3-1.fc37) 
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

On Tue, 2023-01-24 at 19:21 +0530, Vinay Gannevaram wrote:
> Wi-Fi Aware R4 specification defines NAN Pairing which uses PASN handshak=
e
> to authenticate the peer and generate keys. Hence allow to register and t=
ransmit
> the PASN authentication frames on NAN interface and set the keys to drive=
r or
> underlying modules on NAN interface
>=20

I'd be a little worried that there are drivers not expecting this -
maybe needs a feature flag? even for userspace to understand if it's
available?

johannes
