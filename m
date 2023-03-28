Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C92ED6CBB4F
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Mar 2023 11:43:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232345AbjC1JmX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 28 Mar 2023 05:42:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232132AbjC1JmW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 28 Mar 2023 05:42:22 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D12C410CA
        for <linux-wireless@vger.kernel.org>; Tue, 28 Mar 2023 02:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=OJ5I1LR/G7hHb2M4yvcbY3R03aKx0MiJnenV9b6xbhA=;
        t=1679996540; x=1681206140; b=EEw6cEofbL+JIh6JTAhro//yxRGfng92Zh2ug4+J6GxWrOF
        qHP0qAtefAEoPiGu3Oz9l79GrqCfr+sz0LDWnGsU5RHr4VFZE0mELI/Ekhhgb0NXD6e9L2U+CWFLP
        cE7eDgnhfPhRMlefnWxOH23SbI89o3qO/SF/H88aUoNkUGAiJltk0oL3v0oM6xC51uETB9HwZfad6
        tL7dQ7RFnfWmy+P1kjJ7kFsVPrAYiCYD1UmPTdZEnoXKn6usWLDgbZl4Aa9cD95QF+0x0eMf4WdoH
        Ixcf22X1norL/AchNGxhuJ9eItL1PZr4lMJXpUp06UliljovDSC2X9zkEu9jqBIg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1ph5qL-00Gemg-2w;
        Tue, 28 Mar 2023 11:42:18 +0200
Message-ID: <421e93d78deda5ac9e62c58ee275758a3355a503.camel@sipsolutions.net>
Subject: Re: [PATCH] nl80211: Add support to configure allowed frequency
 list for AP operation
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Veerendranath Jakkam <quic_vjakkam@quicinc.com>
Cc:     linux-wireless@vger.kernel.org
Date:   Tue, 28 Mar 2023 11:42:17 +0200
In-Reply-To: <20230328093105.3640436-1-quic_vjakkam@quicinc.com>
References: <20230328093105.3640436-1-quic_vjakkam@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 2023-03-28 at 15:01 +0530, Veerendranath Jakkam wrote:
> Add support to configure the list of allowed 20 MHz channels for AP
> operation using an array of channel center frequencies in MHz, this
> configuration is valid until the AP is stopped. Driver shall filter out
> channels on top of this list of channels based on regulatory or other
> constraints during channel switch etc. Driver shall stop the AP
> operation if all the channels are filtered out during such operation.
>=20

Normally hostapd is doing anything related to the channel picking, so
you need to explain why this is needed.

Really that's true for _any_ patch, please.

johannes
