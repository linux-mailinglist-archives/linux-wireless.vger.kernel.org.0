Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E5D64B65DC
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Feb 2022 09:19:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233202AbiBOIT6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 15 Feb 2022 03:19:58 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235364AbiBOITy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 15 Feb 2022 03:19:54 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C75799BBA9
        for <linux-wireless@vger.kernel.org>; Tue, 15 Feb 2022 00:19:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=Tt8am4XY104W3qvqzm4aJUvijcFeemboxKr7E4QB4fI=;
        t=1644913182; x=1646122782; b=ZmTddYHUNTbyGqSWuy2ob20VGkNG7JtbqmxSdteEDXBPPYj
        y6xkKpkLAbQXE8ihLs+bF/1z5GrZUJNARsJWh5vciHj8cax1UbexMA64rGlmMhervXjg9rdWufmZW
        d/oP+eGDAwIOhNg003xPuG78AxZOAXu/SsNUeFCgUC6HXsqxLPtOTP1eQdayo+1GQ/naN8Ou4eeZb
        8dHgZkHHoHvTi1WgsjaOGZUrO5drXVTm+MhwL/qdROOxmT78sUVAdonVGeL9FxvWOO3GUrsRBb/Ef
        VcRIgfUYVJyvNdYZsgpstdPWUSS7faSEfgpztnjnwdNz4QHtzoYZlRSm3EOeOcCQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1nJt3k-001LZP-IU;
        Tue, 15 Feb 2022 09:19:40 +0100
Message-ID: <a9813545a25cd63f71cc31476230514a80350802.camel@sipsolutions.net>
Subject: Re: [PATCH 2/3] cfg80211: validate RU puncturing bitmap
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Aloka Dixit <quic_alokad@quicinc.com>,
        linux-wireless@vger.kernel.org
Date:   Tue, 15 Feb 2022 09:19:39 +0100
In-Reply-To: <20220214223051.3610-3-quic_alokad@quicinc.com>
References: <20220214223051.3610-1-quic_alokad@quicinc.com>
         <20220214223051.3610-3-quic_alokad@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.3 (3.42.3-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, 2022-02-14 at 14:30 -0800, Aloka Dixit wrote:
> 
> +/* IEEE P802.11be/D1.31, December 2021, Table 36-30 5-bit punctured channel
> + * indication for the non-OFDMA case in an EHT MU PPDU
> + */
> +static const u16 ru_punct_bitmap_80[] = {0xF, 0xE, 0xD, 0xB, 0x7};
> +static const u16 ru_punct_bitmap_160[] = {0xFF, 0xFE, 0xFD, 0xFB, 0xF7, 0xEF,
> +					  0xDF, 0xBF, 0x7F, 0xFC, 0xF3, 0xCF,
> +					  0x3F};
> +static const u16 ru_punct_bitmap_320[] = {0xFFFF, 0xFFFC, 0xFFF3, 0xFFCF,
> +					  0xFF3F, 0xFCFF, 0xF3FF, 0xCFFF,
> +					  0x3FFF, 0xFFF0, 0xFF0F, 0xF0FF,
> +					  0x0FFF, 0xFFC0, 0xFF30, 0xFCF0,
> +					  0xF3F0, 0xCFF0, 0x3FF0, 0x0FFC,
> +					  0x0FF3, 0x0FCF, 0x0F3F, 0x0CFF,
> +					  0x03FF};
> +
> +bool cfg80211_ru_punct_bitmap_valid(const struct cfg80211_chan_def *chandef)
> 

Heh. We wrote basically the same code just the other day (except I think
inverting the bitmasks or something?) in mac80211 for the client side,
i.e. when receiving puncturing from the AP ...

Can we export this function maybe so mac80211 can use it?


Conceptually, I'm wondering if it really belongs into the chandef? Can
you explain why it's part of the channel configuration? If you've got
two chandefs with the same control channel, CCFS and bandwidth, but
different puncturing, does it really make sense to treat them as two
separate channel contexts, e.g. in mac80211? It seems strange to do
that.

johannes
