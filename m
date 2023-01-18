Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13A51671ABC
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Jan 2023 12:35:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbjARLfN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 18 Jan 2023 06:35:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbjARLeO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 18 Jan 2023 06:34:14 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F0EF4DCFB
        for <linux-wireless@vger.kernel.org>; Wed, 18 Jan 2023 02:53:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=oZoPdiTOmK+YZDFTEkEdEkd0/Ts0fuzEBPP7u3AXbhM=;
        t=1674039196; x=1675248796; b=HobQOa4ZPJBoieCQNxBWZ1h13cSDkbmoJFiC9El6hk9MwOz
        Jmhnjqb5dQNUM5MpZK6YtEOg3BtpVTMWFURl6qQgSpN+hxeFp5l3SjZEnqwz4S5sF51q2pDwPYOZF
        eUxvBswBK5exVC+Lq3dwJCGyTq+QACy94X17bUFZdMue/hs0YeGgXpQudIT2Ke1kmvCq2auRsOHhv
        APACMBJKQ+1ZWlppAleUs6ZFRTzxP7un98No+TxIc6nNLtejGDlFKvM2ypBR8tebxyTy7Ly2bgC64
        LqaQ5jkTm1JvtnGqdY1WnPcH3ZTuq9xb5FV4puiUuhLHogvfJJNVU2tuaGh3RojQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1pI644-005ZMX-2x
        for linux-wireless@vger.kernel.org;
        Wed, 18 Jan 2023 11:53:09 +0100
Message-ID: <0d48910607d61e86380b88c61ad1b9c542527c3e.camel@sipsolutions.net>
Subject: Re: [PATCH 2/2] mac80211: remove
 ieee80211_tx_h_check_control_port_protocol()
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Date:   Wed, 18 Jan 2023 11:53:08 +0100
In-Reply-To: <20200326155333.05f411833f60.Ibf3dccc8aea73ae868da352811e5f1a3aef72ee0@changeid> (sfid-20200326_155343_424401_D7EC8810)
References: <20200326155333.f183f52b02f0.I4054e2a8c11c2ddcb795a0103c87be3538690243@changeid>
         <20200326155333.05f411833f60.Ibf3dccc8aea73ae868da352811e5f1a3aef72ee0@changeid>
         (sfid-20200326_155343_424401_D7EC8810)
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

On Thu, 2020-03-26 at 15:53 +0100, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
>=20
> This code is actually not ever effective, since the skb->protocol
> isn't set up correctly (or at all) on outgoing frames. Also, we
> already set the flags (except for IEEE80211_TX_CTL_USE_MINRATE)
> in other code paths, and rate control already handles the frames
> specially. Just remove it entirely.
>=20

Thread necromancy alert ...

But for my own information (and everyone else who cares):

This breaks a couple of hwsim test cases, for example
ap_wpa2_psk_no_control_port.

johannes
