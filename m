Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3278512242
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Apr 2022 21:15:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233003AbiD0TSV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 27 Apr 2022 15:18:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233170AbiD0TSQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 27 Apr 2022 15:18:16 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A38C43382
        for <linux-wireless@vger.kernel.org>; Wed, 27 Apr 2022 12:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=+9IXBObOSsqjtqJDtdiUwlAhLGcWncSy63DdbzZUAZw=;
        t=1651086685; x=1652296285; b=WVr2QIqJTnPdtWjDMYtQQIffqhlu1bAKLJT0GI0gmJx5N+L
        rZ0f55Hd/IWqaFCfXUVnfbe8jFx6s/4r6pfK6pIQRK6fPzvAXs1N/BbOIOysa+xnDa24d2R1BPUgO
        ZwMuSSmjEngMknKQcHSBo/kUBTsLag8pfBCPPoPVszmIhdakYX2V9QM506tTQQWePTFjai2GnOvWH
        d5RIMBdp/BLZ9mm7HSrQAp7eWVPaCALHapM+bNai4msxfGIbj48vfruPSDlKpxAOaK0hqpD4ceBxi
        l9jWoW3zW5ArgpJO4GlToQX39nKzLa8lmI9IqrMSMqrR9hVYeDvSsAcZGAMCNojg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1njn4N-00G2E1-0b;
        Wed, 27 Apr 2022 21:11:23 +0200
Message-ID: <ca53bf4ce43f967723125313d5285cc40eb7d3f4.camel@sipsolutions.net>
Subject: Re: [PATCH] mac80211: Reset MBSSID parameters upon connection
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
Cc:     linux-wireless@vger.kernel.org
Date:   Wed, 27 Apr 2022 21:11:22 +0200
In-Reply-To: <20220427182305.11703-1-quic_mpubbise@quicinc.com>
References: <20220427182305.11703-1-quic_mpubbise@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, 2022-04-27 at 23:53 +0530, Manikanta Pubbisetty wrote:
> Currently MBSSID parameters in struct ieee80211_bss_conf
> are not reset upon connection. This could be problematic
> with some drivers in a scenario where the device first
> connects to a non-transmit BSS and then connects to a
> transmit BSS of a Multi BSS AP. The MBSSID parameters
> which are set after connecting to a non-transmit BSS will
> not be reset and the same parameters will be passed on to
> the driver during the subsequent connection to a transmit
> BSS of a Multi BSS AP.
> 
> For example, firmware running on the ath11k device uses the
> Multi BSS data for tracking the beacon of a non-transmit BSS
> and reports the driver when there is a beacon miss. If we do
> not reset the MBSSID parameters during the subsequent
> connection to a transmit BSS, then the driver would have
> wrong MBSSID data and FW would be looking for an incorrect
> BSSID in the MBSSID beacon of a Multi BSS AP and reports
> beacon loss leading to an unstable connection.
> 
> Reset the MBSSID parameters upon every connection to solve this
> problem.

Oops. Please add (or at least provide) a Fixes line though.

johannes
