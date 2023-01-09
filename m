Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 223A4662270
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Jan 2023 11:06:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235659AbjAIKGa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 9 Jan 2023 05:06:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236934AbjAIKF4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 9 Jan 2023 05:05:56 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DA0C15FE8
        for <linux-wireless@vger.kernel.org>; Mon,  9 Jan 2023 02:04:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=LXYtkwCulJxyYDxEsC2KhrmJMtqjpJOVDebzve+DexM=;
        t=1673258651; x=1674468251; b=Q5mUEE05HFPq0Q1GgNbUiusbiVLZLyEMHOeRy9mejlV7Hom
        xrebyvAFftpos/a+lISrJFQ3fn0OMW8tuYhE0DAlXm/UfgUizsqgDiiIgh25vvCq0teRTybP1x5yy
        IiulOwWdPbiz0vWmo+KJgEfBgwCTgeDoXgtBY9fiss06s+8aWcUgJKLAE51HeS3nTdAIOHr43NvHW
        pPpyKNhbOmJVMgYNSgqWxmBLD1XxJObbVOYvy/hmzOgD7HGrC0mV6wn9SwCs4+rcuReHxiM7yTVz8
        37qyT5Sjwdg1zuakZ/S3iCe4/f7EiAJoAtWuUsJtilTzq4E6idL274XXYkGamilQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1pEp0h-00EE7p-1e;
        Mon, 09 Jan 2023 11:04:08 +0100
Message-ID: <598af0e9da276e2e7f03f3a7c2a85e3391333a9d.camel@sipsolutions.net>
Subject: Re: authentication timed out by "wifi: mac80211: do link->MLD
 address translation on RX"
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Wen Gong <quic_wgong@quicinc.com>, linux-wireless@vger.kernel.org
Cc:     ath11k@lists.infradead.org
Date:   Mon, 09 Jan 2023 11:04:06 +0100
In-Reply-To: <efad76dd-14ff-4a36-ec67-fe6f3b8dcc5b@quicinc.com>
References: <efad76dd-14ff-4a36-ec67-fe6f3b8dcc5b@quicinc.com>
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

Hi,

On Mon, 2023-01-09 at 17:48 +0800, Wen Gong wrote:
> Hi Johannes,
>=20
> When the rx packet is skb_copy(), the hdr is not re-assign the new skb=
=20
> value, and lead the
>=20
> operation of "translate to MLD addresses" take effect on the original=20
> skb, and lead
>=20
> the check "if (!ether_addr_equal(ifmgd->auth_data->ap_addr,=20
> mgmt->bssid))" fail in ieee80211_rx_mgmt_auth(),
>=20
> and thus happened "authentication timed out".
>=20
> After below change, issue not happen again.
>=20

Yeah ... We found and fixed this, and then a few days later someone else
submitted a patch for it:


https://patchwork.kernel.org/project/linux-wireless/patch/20221208040050.25=
922-1-quic_srirrama@quicinc.com/

johannes
