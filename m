Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11A104FB9D9
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Apr 2022 12:40:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241995AbiDKKm6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 11 Apr 2022 06:42:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345716AbiDKKmx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 11 Apr 2022 06:42:53 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF49E37026
        for <linux-wireless@vger.kernel.org>; Mon, 11 Apr 2022 03:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=ZEJ8IHqL5ip494hZ18NEoK8iVgKYDovIRs+Dz5evWFU=;
        t=1649673639; x=1650883239; b=DfhF+UvqkTZIHOdk6ksRFrrhRJxYdX44qGvJkNWyG23q/QT
        BkRk/2AAazLr5coOKv8zEp9N8nHD1yV1XrFwmBLfSsdTtLs68QVLypWP9GJsYoiRm/emDziE4Ktyh
        dH0V4AyZe5EZff8HMEjEzYbKwnTNCyTBnkGttNP2bKyKRFftJzBTzOfdk+ZLUtuPoDLmYGJK2p00Q
        ubTYtUIbdftEZhi3weDy/BiC+qpXE+B6GNuiJHae9TOoK03wS5QGIFKRnk/rHy3/WkyLhBNeA3UYd
        R+XqCoR4GNDV961Qh9wb9EIxotnToyVnntkUSj8ejzwqnQd5j2Xl4EdqP/jw/fKQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1ndrTI-008FFm-Q1;
        Mon, 11 Apr 2022 12:40:36 +0200
Message-ID: <f39df1cac6519e9f2037d26ea8a75e39cf869ed3.camel@sipsolutions.net>
Subject: Re: [PATCH] mac80211 : fix bw change to 40 MHz during channel switch
From:   Johannes Berg <johannes@sipsolutions.net>
To:     quic_haric@quicinc.com
Cc:     linux-wireless@vger.kernel.org
Date:   Mon, 11 Apr 2022 12:40:35 +0200
In-Reply-To: <1649393452-11704-1-git-send-email-quic_haric@quicinc.com>
References: <1649393452-11704-1-git-send-email-quic_haric@quicinc.com>
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


> +++ b/net/mac80211/spectmgmt.c
> @@ -148,6 +148,11 @@ int ieee80211_parse_ch_switch_ie(struct ieee80211_sub_if_data *sdata,
>  					    IEEE80211_HT_OP_MODE_CCFS2_SHIFT),
>  		};
>  
> +		csa_ie->chandef.width = NL80211_CHAN_WIDTH_40;
> +		csa_ie->chandef.center_freq1 =
> +			ieee80211_channel_to_frequency(wide_bw_chansw_ie->new_center_freq_seg0,
> +						       new_chan->band);
> +
>  		/* default, for the case of IEEE80211_VHT_CHANWIDTH_USE_HT,
>  		 * to the previously parsed chandef
>  		 */

It seems like this should go under the comment, and change
new_vht_chandef, not csa_ie->chandef?

johannes
