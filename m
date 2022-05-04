Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D0F4519E1E
	for <lists+linux-wireless@lfdr.de>; Wed,  4 May 2022 13:34:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236670AbiEDLiC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 4 May 2022 07:38:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348897AbiEDLiB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 4 May 2022 07:38:01 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EA692B279
        for <linux-wireless@vger.kernel.org>; Wed,  4 May 2022 04:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=nYGoV3ylmcOTWs7rF3NN/2GWWtxA+11tRC2+2CldSo0=;
        t=1651664065; x=1652873665; b=GOyLLeMl3F0NFq19M9dl1wfNMsMutu867gHiGwubzkBnAD9
        akSUplxJpzG8zLmTgwEHKbgUoQAYHWu3OKM93HkH1T8K1eyLt6mPK4bJ5pNEi1b/8gudyWeSz8M3t
        GCcbCGxTxozRQZKkzeT05NA7FPUz1cQF5qFzhLtuV8B4OKq2G/ofVEjpStf1tRMoZXZ4PWy8YW4Px
        vBFgHtxedzwV4dSHGexT36XkEWXiDAKoN1fz05+icl7j1bnh4z4XIDmY0+sHuJZQ63L4jxC8QW+eA
        1+OjT9S26GW9oenDHKG7zdOtDDRw3+zpoquSSKj4OFX6+4sOFBfr+8lSfhKHw9xQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1nmDGx-0021B5-R9;
        Wed, 04 May 2022 13:34:23 +0200
Message-ID: <a599a199f387ed98e032995f0e5fc4b3a029d270.camel@sipsolutions.net>
Subject: Re: [PATCH v2 1/3] nl80211: retrieve EHT capabilities in AP mode
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Aloka Dixit <quic_alokad@quicinc.com>,
        linux-wireless@vger.kernel.org
Cc:     Vikram Kandukuri <quic_vikram@quicinc.com>,
        Veerendranath Jakkam <quic_vjakkam@quicinc.com>
Date:   Wed, 04 May 2022 13:34:23 +0200
In-Reply-To: <20220323225443.13947-1-quic_alokad@quicinc.com>
References: <20220323225443.13947-1-quic_alokad@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
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

On Wed, 2022-03-23 at 15:54 -0700, Aloka Dixit wrote:
> From: Vikram Kandukuri <quic_vikram@quicinc.com>
> 
> Add support to retrieve the EHT capabilities element passed by
> the userspace in the beacon template and store the pointer in
> struct cfg80211_ap_settings to be used by MAC80211.


s/MAC80211/drivers/ I guess

> +	cap = cfg80211_find_ext_elem(WLAN_EID_EXT_EHT_CAPABILITY, ies, ies_len);
> +	if (cap && cap->datalen >= sizeof(*params->eht_cap) + 1)
> +		params->eht_cap = (void *)(cap->data + 1);
> 

Feels like this should be using ieee80211_eht_capa_size_ok() in some
way, since drivers would probably use it? Maybe even returning an error
to userspace if it's not OK?

johannes
